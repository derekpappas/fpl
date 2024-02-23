/*******************************************************************************************************************************
**
**    Copyright © 1998..2002 Advanced Architectures
**
**    All rights reserved
**    Confidential Information
**    Limited Distribution to Authorized Persons Only
**    Created and Protected as an Unpublished Work under the U.S. Copyright act of 1976.
**
**    Project Name       : A2-Register Bus
**    Module Name        : A2-Register Bus Master/Slave Interface TAP
**
**    Author             : RTT
**    Version            : 1.2
**    Creation Date      : 2001/08/15
**    Description        : Combined master/slave interface TAP
**
**    $Revision: $
**        $Date: $
**          $ID: $
**
********************************************************************************************************************************
**    THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
**    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
**    BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
**    TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
**    AND ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
**    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
********************************************************************************************************************************
**
**    NOTES:    usage --   a2r_tap  #(
**                                     A2R_masterID,
**                                     A2R_slaveID,
**                                     5'b"Pipesettings",
**                                     SLV_addr_width
**                                  )
**                         <Instance_Name>
**                                  (
**                                     <list_of_ports>
**                                  );
**
********************************************************************************************************************************
**   IF IN RING MODE:
**   The input "a2r_pipe_en" from all A2R taps should be taken to the top of the system hierarchy and tied high initially.
**   After first pass P&R revue the timing of A2R segments and disable (tie low) all "a2r_pipe_en" so that a minimum number
**   of pipeline stages exist in the ring and timing can still be met.
**
*******************************************************************************************************************************/

/* verilator lint_off VARHIDDEN */
/* verilator lint_off WIDTH     */

`include "A2_common.cfg"
`include "a2r_common.cfg"

module a2r_tap
   #(
   // Passed parameters
   parameter   A2R_masterID            = 0,                 // Identity of this TAP as a Master, default is 0;
   parameter   A2R_slaveID             = 0,                 // Identity of this TAP as a Slave,  default is 0;
   parameter   A2R_maskID              = 8'hFF,             // Mask of IDs connected through A2R gateway
   parameter   A2R_gateway             = 0,                 // Set to 1 if connected to an A2R gateway
   parameter   [4:0] PPL               = 5'b11111,          // Sets pipelining for this module -- see "a2r_parameter.vh"
   // Global parameters
   `include  "a2r_parameters.vh"
   )(
   // Global
   input                               clock,               // System Clock
   input                               reset,               // Global Reset
   input                               a2r_pipe_en,         // Enable pipelining for this module -- allows fine tuning at P&R

   // A2R Arbitration Interface
   input    [A2R_num_requestors-1:0]   a2r_grant_in,        // Register Bus Arbitration Grant
   input    [A2R_num_requestors-1:0]   a2r_request_in,      // Register Bus Arbitration Request

   output                              a2r_request_out,     // Register Bus Request Out to local arbitration
   output                              a2r_grant_out,       // Register Bus Grant -- indicates current owner

   // A2R Register Bus Interface
   input    [A2R_width-1         :0]   a2r_in,              // Bus input to this TAP
   input                               a2r_aphi_in,         // Address Phase in
   input                               a2r_write_in,        // Write Command in
   input                               a2r_read_in,         // Read Command in
   input                               a2r_ready_in,        // Ready in
   input                               a2r_error_in,        // Error in

   output   [A2R_width-1         :0]   a2r_out,             // Bus output from this TAP
   output                              a2r_aphi_out,        // Address Phase out
   output                              a2r_write_out,       // Write Commadn out
   output                              a2r_read_out,        // Read Commadn out
   output                              a2r_ready_out,       // Ready out
   output                              a2r_error_out,       // Error out

   // Extensions
   `ifdef A2R_EXTENSION_RETRY
   input                               a2r_retry_in,
   output                              a2r_retry_out,
   input                               slave_retry,
   `endif

   // A2R is a Slave to External Master
   input    [A2R_width-1         :0]   master_address,      // Address input from Master
   input    [A2R_width-1         :0]   master_write_data,   // Write Data in from Master
   input                               master_read,         // Read  Command from Master
   input                               master_write,        // Write Command from Master
   output   [A2R_width-1         :0]   master_read_data,    // Read Data out  to   Master
   output                              master_ready,        // Bus Busy signal to  Master
   output                              master_error,        // Bus Error signal to Master

   // A2R is Master to External Slave
   input    [A2R_width-1         :0]   slave_read_data,     // Read Data from Slave
   input                               slave_ready,         // Slave Ready
   input                               slave_error,         // Slave detected an error
   output wire [A2R_width-1      :0]   slave_write_data,    // Write Data to Slave
   output reg  [A2R_width-1      :0]   slave_address,       // Address to Slave
   output reg                          slave_read,          // Read Command to Slave
   output reg                          slave_write,         // Write Command to Slave
   output reg                          slave_reset          // Slave interface reset

   );

localparam  A2R_grant_width      =  A2R_OR_fabric ? A2R_num_requestors : 1;
localparam  NUM_MTR_STATES       =  3;

localparam
   IDLE           =  3'b 000,    // Idle
   BUSY           =  3'b 001,    // Bus is busy no local request
   REQUEST        =  3'b 011,    // Request
   REQ_BUSY       =  3'b 010,    // Bus is busy w/ request
   PENDING        =  3'b 110,    // Win arbitration waiting for current transaction to finish
   ADDRESS_PHASE  =  3'b 111,    // Begin transaction
   WAIT_READY     =  3'b 101,    // Wait for ready
   READY          =  3'b 100;    // Ready

// LOCALS ======================================================================================================================


reg  [NUM_MTR_STATES-1:0]  master_state;

reg                        init_n;
reg                        a2r_request_ppl;
reg                        a2r_enable_out;
reg                        a2r_mtr_en_out;
reg                        a2r_slv_en_out;

reg      [A2R_width-1:0]   tap_in;
reg                        tap_aphi_in;
reg                        tap_write_in;
reg                        tap_read_in;
reg                        tap_ready_in;
reg                        tap_error_in;
reg                        tap_grant_in;

reg      [A2R_width-1:0]   tap;
reg                        tap_request;
reg                        tap_grant;
reg                        tap_aphi_out;
reg                        tap_aphi_out_d;
reg                        tap_read_out;
reg                        tap_write_out;
reg                        tap_ready;
reg                        tap_error;

reg                [3:0]   grant_start;

`ifdef A2R_EXTENSION_RETRY
reg                        tap_retry_in;
reg                        tap_retry_master;
reg                        tap_retry_slave;
wire                       tap_retry_out;
`endif

wire [NUM_MTR_STATES-1 :0] next_state;

wire     [A2R_width-1:0]   tap_out;
wire                       tap_ready_out;
wire                       tap_error_out;
wire                       detect;
wire                       slave_done;
wire                       address_phase;
wire                       active;
wire                       valid_request;
wire                       grant;
wire                       win;
wire                       no_requests;
wire                       abort;
wire                       write_enable;
wire                       slave_access;
wire                       start_grant;      // Kicks off grant token after reset
wire                       busy_states;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// RESET
//       Init is used as a synchronous reset only where absolutely necessary in the rest of the module.  This flop also
//       ensures that the reset is synchronized to the clock, especially the release!!
//       Note "init" is active low "init_n" so an inversion is not required on use!

always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset)
      init_n  <= `tCQ FALSE;
   else
      init_n  <= `tCQ TRUE;
   end

// INITIAL =====================================================================================================================

`ifndef  synthesis
// synopsys translate_off
initial begin
   $display(" A2R TAP setup: Master ID = %2d, Target ID = %2d, Pipeline Settings = %5b:",
      A2R_masterID,
      A2R_slaveID,
      PPL
      );
   end
// synopsys translate_on
`endif

// MASTER ======================================================================================================================
//
// NOTE: Arbitration function requires the last grant signal to derive the next one.  On reset slave ID 0 is given the
//       grant and this stays set until the first request.  Once a new grant is decided by arbitration (could still be "0")
//       the active master's state machine will remove grant so that no-one else can access the bus.  Grant is
//       re-asserted at the end of the transaction to enable the next arbitration.  If there are no requests then the
//       grant signal asserted stays on (parked) until a request(s) arrive.
//
//       In parallel mode (OR_fabric) the arbitration is done in parallel by the arbitrate function that has a slice of the
//       arbiter in each A2R tap.  The requests and grants are broadcast to each module from every other module.
//
//       In serial mode (~OR_fabric) the arbitration is by token passing whereby a grant signal passes around the ring until
//       it reaches a module with an active request.  This module holds the token while it performs its access and then passes
//       the token on around the ring.  The tokens are pipelined along with the rest of the ring so that the circumnavigation
//       of the ring by the grant token is dependant on the pipeline settings of the ring.  The grant is released by an active
//       Master as soon as it is waiting for data so that arbitration for the next transaction is overlapped with the data
//       phase of the current transaction.
//

assign      valid_request     =  master_read | master_write ;

assign      grant             =  a2r_pipe_en    ?  tap_grant_in      :  a2r_grant_in;

//     `tUD delay used to ensure a non-zero loop delay for a serial fabric with no pipeline stages (Asynchronous loop)

generate if (A2R_OR_fabric) begin
      assign      win           =  arbitrate (a2r_request_in, a2r_grant_in, A2R_masterID);   // Distributed Arbitration
      assign      no_requests   = ~|a2r_request_in;
      assign `tUD a2r_grant_out =  tap_grant;
      end
   else begin
      assign      win           =  a2r_request_out &  grant;
      assign      no_requests   = ~a2r_request_out &  grant;
      assign `tUD a2r_grant_out =  tap_grant | ~a2r_request_out & grant;
      end
   endgenerate

generate if (PPL[Request_IN])
      assign   a2r_request_out   =  tap_request;
   else
      assign   a2r_request_out   =  valid_request & ~active;
   endgenerate

a2rfsm  fsm (
   // Outputs
   .next_state    (next_state),
   .aphi_out      (address_phase),
   .busy          (busy_states),
   .active        (active),
   .abort         (abort),
   // Inputs
   .mstr_state    (master_state),
   .vld_req       (valid_request),
   .aphi_in       (a2r_aphi_in),
   .ardy_in       (a2r_ready_in),
   .win           (win),
   .mstr_rdd_i    (PPL[Master_IN  ]),
   .mstr_adr_o    (PPL[Address_OUT]),
   .mstr_req_i    (PPL[Request_IN ])
   );

always @(`ACTIVE_EDGE clock) begin
   master_state   <= `tCQ {NUM_MTR_STATES{init_n}} &  next_state;
   end

generate if (PPL[Master_IN]) begin
`ifdef A2R_EXTENSION_RETRY
      assign      master_ready      =  (master_state == READY) & ~tap_retry_master;
`else
      assign      master_ready      =   master_state == READY;
`endif
      assign      master_error      =  (master_state == WAIT_READY)        &  tap_error_in;
      assign      master_read_data  =  {A2R_width{master_state == READY}}  &  tap_in;
      end
   else begin
`ifdef A2R_EXTENSION_RETRY
      assign      master_ready      =  a2r_ready_in  & ~a2r_retry_in & ~busy_states;
`else
      assign      master_ready      =  a2r_ready_in  & ~busy_states;
`endif
      assign      master_error      =  a2r_error_in  & ~busy_states;
      assign      master_read_data  =  {A2R_width{master_ready}} &  a2r_in;   // Lower power!
      end
   endgenerate


// BUS OUTPUT ==================================================================================================================

generate if (A2R_masterID == 0) begin
      always @(`ACTIVE_EDGE clock)
         grant_start <= `tCQ {4{init_n}} & (grant_start == 15 ? 15 : grant_start +1);
      assign   start_grant =  (grant_start == 14);
      end
   else
      assign   start_grant = 0;
   endgenerate

always @(`ACTIVE_EDGE clock) begin
   tap               <= `tCQ  address_phase                                ?  master_address
                        :     master_write && (master_state == WAIT_READY) ?  master_write_data
                        :     slave_read                                   ?  slave_read_data
                        :                                                    {A2R_width{1'b0}};

   tap_request       <= `tCQ  init_n &  valid_request& ~active;
   tap_aphi_out      <= `tCQ  init_n &  address_phase;
   tap_aphi_out_d    <= `tCQ  init_n &  tap_aphi_out;

   tap_grant         <= `tCQ  init_n &  start_grant
                        |     init_n &  abort
                        |     init_n &  tap_aphi_out_d
                        |     init_n &  tap_grant & no_requests;

   tap_read_out      <= `tCQ  init_n &  address_phase & master_read;
   tap_write_out     <= `tCQ  init_n &  address_phase & master_write;
   tap_ready         <= `tCQ  init_n &  slave_ready;
   tap_error         <= `tCQ  init_n &  slave_error;
   end

generate if (PPL[Slave_Ready_OUT]) begin
      assign   tap_ready_out  =  tap_ready;
      assign   tap_error_out  =  tap_error;
      assign   tap_out        =  tap;
      end
   else begin
      assign   tap_ready_out  =  slave_ready;
      assign   tap_error_out  =  slave_error;
      assign   tap_out        =  slave_read  ?  slave_read_data :  tap;
      end
   endgenerate

`ifdef   A2R_EXTENSION_RETRY
always @(`ACTIVE_EDGE clock) begin
   tap_retry_master  <= `tCQ  init_n & (master_state == WAIT_READY)  & a2r_ready_in & a2r_retry_in
                        |     init_n & (master_state == READY)       & tap_retry_master;

   tap_retry_slave   <= `tCQ  init_n &  slave_retry;
   end

generate if (PPL[Slave_Ready_OUT])
      assign   tap_retry_out  =  tap_retry_slave;
   else
      assign   tap_retry_out  =  slave_retry;
   endgenerate
`endif

// BUS FABRIC ==================================================================================================================

generate
   if       (!PPL[Slave_Ready_OUT]) assign write_enable =                 detect & ~a2r_write_in;
   else if  (!PPL[Slave_Select_IN]) assign write_enable = ~a2r_pipe_en &  detect & ~a2r_write_in;
   else                             assign write_enable =  1'b 0;
   endgenerate

generate
   if       (!PPL[Slave_Ready_OUT]) assign slave_access =                 detect;
   else if  (!PPL[Slave_Select_IN]) assign slave_access = ~a2r_pipe_en &  detect;
   else                             assign slave_access =  1'b 0;
   endgenerate

generate if (A2R_OR_fabric) begin
      assign a2r_out       =  tap_out;
      assign a2r_aphi_out  =  tap_aphi_out;
      assign a2r_read_out  =  tap_read_out;
      assign a2r_write_out =  tap_write_out;
      assign a2r_ready_out =  tap_ready_out;
      assign a2r_error_out =  tap_error_out;
`ifdef   A2R_EXTENSION_RETRY
      assign a2r_retry_out =  tap_retry_out;
`endif
      end
   else begin
      always @(`ACTIVE_EDGE clock) begin
         a2r_enable_out    <= `tCQ   init_n &  slave_read
                                 |   init_n & (master_state == WAIT_READY)    & ~a2r_ready_in
                                 |   init_n &  write_enable
                                 |   init_n &  address_phase;

         a2r_mtr_en_out    <= `tCQ   init_n & (master_state == WAIT_READY)    & ~a2r_ready_in
                                 |   init_n &  address_phase;

         a2r_slv_en_out    <= `tCQ   init_n & (slave_read | slave_write)
                                 |   init_n &  a2r_slv_en_out & ~tap_ready_in & ~a2r_aphi_in
                                 |   init_n &  slave_access;
         end

// NOTE: If a parallel fabric is specified then "a2r_enable_out" et al are always TRUE and these assignments will synthesize out
//       leaving direct assignment of the tap outputs to the a2r outputs.
//
//       `tUD delay used to ensure a non-zero loop delay for a serial fabric with no pipeline stages (Asynchronous loop)

      wire         pipeline_en   =  a2r_pipe_en  | `ACTIVE_LEVEL_reset; // Reset ensures asynchronous loop is cleared
      assign `tUD  a2r_out       =  a2r_enable_out  ? tap_out       : (pipeline_en ? tap_in       : a2r_in);
      assign `tUD  a2r_aphi_out  =  a2r_mtr_en_out  ? tap_aphi_out  : (pipeline_en ? tap_aphi_in  : a2r_aphi_in);
      assign `tUD  a2r_read_out  =  a2r_enable_out  ? tap_read_out  : (pipeline_en ? tap_read_in  : a2r_read_in);
      assign `tUD  a2r_write_out =  a2r_enable_out  ? tap_write_out : (pipeline_en ? tap_write_in : a2r_write_in);
      assign `tUD  a2r_ready_out =  a2r_slv_en_out  ? tap_ready_out : (pipeline_en ? tap_ready_in : a2r_ready_in);
      assign `tUD  a2r_error_out =  a2r_slv_en_out  ? tap_error_out : (pipeline_en ? tap_error_in : a2r_error_in);

`ifdef   A2R_EXTENSION_RETRY
      assign `tUD  a2r_retry_out =  a2r_slv_en_out  ? tap_retry_out : (pipeline_en ? tap_retry_in : a2r_retry_in);
`endif
      end
   endgenerate

// BUS IN ======================================================================================================================

always @(`ACTIVE_EDGE clock) begin
   // Capture bus signals
   tap_in         <= `tCQ  a2r_in;
   tap_aphi_in    <= `tCQ  init_n &  a2r_aphi_in;
   tap_read_in    <= `tCQ  init_n &  a2r_read_in;
   tap_write_in   <= `tCQ  init_n &  a2r_write_in;
   tap_ready_in   <= `tCQ  init_n &  a2r_ready_in;
   tap_error_in   <= `tCQ  init_n &  a2r_error_in;
   tap_grant_in   <= `tCQ  A2R_OR_fabric ? FALSE :  init_n &  a2r_grant_in;
   end

`ifdef   A2R_EXTENSION_RETRY
always @(`ACTIVE_EDGE clock) begin
   tap_retry_in   <= `tCQ  init_n &  a2r_retry_in;
   end
`endif

// SLAVE =======================================================================================================================

generate if (PPL[Slave_Select_IN]) begin

      assign   detect = decode(tap_in[A2R_width-1:(A2R_width-A2R_lg2_slaves)],A2R_slaveID, A2R_maskID, A2R_gateway)
                      & tap_aphi_in & ~tap_ready_in;

      always @(`ACTIVE_EDGE clock) begin
         slave_address  <= `tCQ  detect ?  tap_in   :  slave_address;

         slave_write    <= `tCQ  init_n &  detect      &  tap_write_in    // Set with detect
                              |  init_n &  slave_write & ~slave_done;     // Clear w/ ready or error

         slave_read     <= `tCQ  init_n &  detect      &  tap_read_in     // Set with detect
                              |  init_n &  slave_read  & ~slave_done;     // Clear w/ ready or error
         end
      assign   slave_write_data   =  tap_in;
      end
   else begin

      assign   detect = decode(a2r_in[A2R_width-1:(A2R_width-A2R_lg2_slaves)],A2R_slaveID, A2R_maskID, A2R_gateway)
                      & a2r_aphi_in & ~a2r_ready_in;

      always @(`ACTIVE_EDGE clock) begin
         slave_address  <= `tCQ  detect ?  a2r_in  :   slave_address;

         slave_write    <= `tCQ  init_n &  detect      &  a2r_write_in     // Set with detect
                              |  init_n &  slave_write & ~slave_done;      // Clear w/ ready or error

         slave_read     <= `tCQ  init_n &  detect      &  a2r_read_in      // Set with detect
                              |  init_n &  slave_read  & ~slave_done;      // Clear w/ ready or error
         end

      assign   slave_write_data   =  a2r_in;
      end
   endgenerate

assign   slave_done  =  slave_ready
`ifdef   A2R_EXTENSION_RETRY
                     |  slave_retry
`endif
                     |  slave_error;


// FUNCTIONS ===================================================================================================================
//
// BUS ARBITRATION FUNCTION
//
// For the rotating priority a four master example the function will generate one of these depending on it's ID:
//
// win[0] = request[0] && grant[0] && !request[1] && !request[2] && !request[3]    -- just won, give way to everyone else
//       || request[0] && grant[1] && !request[2] && !request[3]                   --
//       || request[0] && grant[2] && !request[3]                                  --
//       || request[0] && grant[3]                                                 -- highest priority, ignore everyone else
//
// win[1] = request[1] && grant[1] && !request[2] && !request[3] && !request[0]    -- just won, give way to everyone else
//       || request[1] && grant[2] && !request[3] && !request[0]                   --
//       || request[1] && grant[3] && !request[0]                                  --
//       || request[1] && grant[0]                                                 -- highest priority, ignore everyone else
//
// win[2] = request[2] && grant[2] && !request[3] && !request[0] && !request[1]    -- just won, give way to everyone else
//       || request[2] && grant[3] && !request[0] && !request[1]                   --
//       || request[2] && grant[0] && !request[1]                                  --
//       || request[2] && grant[1]                                                 -- highest priority, ignore everyone else
//
// win[3] = request[3] && grant[3] && !request[0] && !request[1] && !request[2]    -- just won, give way to everyone else
//       || request[3] && grant[0] && !request[1] && !request[2]                   --
//       || request[3] && grant[1] && !request[2]                                  --
//       || request[3] && grant[2]                                                 -- highest priority, ignore everyone else
//

function arbitrate;
input    [A2R_num_masters-1   :0]   request;
input    [A2R_num_masters-1   :0]   grant;
input    [A2R_num_masters-1   :0]   ID;
integer  i,j;
reg      win, higher_requests;
begin
win = FALSE;
for (i=0; i<A2R_num_masters; i=i+1) begin
   higher_requests = FALSE;
   for (j=i+1; j<A2R_num_masters; j=j+1) begin
      higher_requests = higher_requests | request[(j+ID)%A2R_num_masters];
      end
   win = win | (request[ID] & grant[(i+ID)%A2R_num_masters] & ~higher_requests);
   end
arbitrate = win;
end
endfunction

// Describe Address Mapping of Targets and Gates ===============================================================================
//
// ADDRESS MAP FOR SLAVES
//
// For simplicity the slave address are decoded only from the upper address bits.
//
// If there are four  or less slaves, for example, then the top two bits are used
// If there are eight or less slaves               then the top three bits are used
// etc..
//
//
function    decode;
input       [A2R_lg2_slaves -1:0] address;
input       [A2R_lg2_slaves -1:0] ID;
input       [A2R_lg2_slaves -1:0] mask;
input                             direction;

decode   =  direction ^ &( (mask | ( address ~^ ID )));

endfunction

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
