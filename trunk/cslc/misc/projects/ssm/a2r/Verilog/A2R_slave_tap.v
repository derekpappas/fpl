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
**    Module Name        : A2-Register Bus Slave only Interface TAP
**
**    Author             : RTT
**    Creation Date      : 2001/08/15
**    Description        : Slave only interface TAP
**
**    $Revision: 1.0 $
**    $Date: 2002-05-13 09:16:21-07 $
**    $ID: $
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
**    NOTES:    usage --   a2r_slave #(
**                                     A2R_slaveID,
**                                     5'b"Pipesettings",
**                                     SLV_addr_width
**                                  )
**                         <Instance_Name>
**                                  (
**                                     <list_of_ports>
**                                  );
**
**    OCP   COMPLIANCE:
**
**          This module may be used to connect to OCP compliant cores using "Basic" signal group only
**
**          To attach an OCP System Target to this core uncomment the `define OCPIP_MASTER
**          The OCP System Target is an OCP 'slave' so this module communicates to it through an OCP 'master' interface.
**
*******************************************************************************************************************************/

`include "A2_common.cfg"
`include "A2R_common.cfg"

module a2r_slave
   #(
   // Passed parameters------------------------------------
   parameter   A2R_slaveID          = 0,                   // Identity of this TAP as a Slave,  default is 0;
   parameter   [4:0] PPL            = 5'b11111,            // Sets pipelining for this module

   // Global parameters------------------------------------
   `include   "a2r_parameters.vh"

   )(// Global
                  clock,
                  reset,

                  // A2R Bus Interface
                  a2r_pipe_en,

                  a2r_in,
                  a2r_aphi_in,
                  a2r_read_in,
                  a2r_write_in,
                  a2r_ready_in,
                  a2r_error_in,
                  a2r_grant_in,

                  a2r_out,
                  a2r_aphi_out,
                  a2r_read_out,
                  a2r_write_out,
                  a2r_ready_out,
                  a2r_error_out,
                  a2r_grant_out,

                  // Slave Interface
                 `ifdef A2R_EXTENSION_RETRY
                  a2r_retry_in,
                  a2r_retry_out,
                  slave_retry,
                 `endif

                  slave_address,
                  slave_write_data,
                  slave_read_data,
                  slave_read,
                  slave_write,
                  slave_ready,
                  slave_error
                 );

// Global
input                               clock;                 // System Clock
input                               reset;                 // Global Reset
input                               a2r_pipe_en;           // Enable pipelining for this module -- allows fine tuning at P&R

// A2R Register Bus Interface
input    [A2R_width         -1:0]   a2r_in;                // Bus input to this TAP
input                               a2r_aphi_in;           // Address Phase in
input                               a2r_read_in;           // Read  Command in
input                               a2r_write_in;          // Write Command in
input                               a2r_ready_in;          // Ready in
input                               a2r_error_in;          // Error in
input                               a2r_grant_in;          // Grant in   -- pass through in serial mode!

output   [A2R_width         -1:0]   a2r_out;               // Bus output from this TAP
output                              a2r_aphi_out;          // Address Phase out
output                              a2r_read_out;          // Read  Command out
output                              a2r_write_out;         // Write Command out
output                              a2r_ready_out;         // Ready out
output                              a2r_error_out;         // Error out
output                              a2r_grant_out;         // Grant out

// Slave Interface
input    [A2R_width-1         :0]   slave_read_data;       // Read Data from Slave
input                               slave_ready;           // Slave Ready
input                               slave_error;           // Slave detected an error

output   [A2R_width-1         :0]   slave_write_data;      // Write Data to Slave
output   [A2R_width-1         :0]   slave_address;         // Address to Slave
output                              slave_read;            // Read  Command to Slave
output                              slave_write;           // Write Command to Slave

// Extensions
`ifdef A2R_EXTENSION_RETRY
input                               a2r_retry_in;
output                              a2r_retry_out;
input                               slave_retry;
`endif

// REGISTERS ===================================================================================================================

reg                              a2r_enable_out;
reg                              a2r_slv_en_out;
reg      [A2R_width     -1:0]    tap_in;
reg                              tap_aphi_in;
reg                              tap_read_in;
reg                              tap_write_in;
reg                              tap_ready_in;
reg                              tap_error_in;
reg                              tap_grant_in;

reg      [A2R_width      -1:0]   tap;
reg                              tap_ready;
reg                              tap_error;

reg      [A2R_width      -1:0]   slave_address;
reg                              slave_read;
reg                              slave_write;

wire     [A2R_width     -1:0]    tap_out;
wire                             tap_ready_out;
wire                             tap_error_out;
wire                             detect;
wire                             slave_done;

`ifdef A2R_EXTENSION_RETRY
reg                              retry_access;
reg                              tap_retry_in;
reg                              tap_retry;
wire                             tap_retry_out;
`endif

// INITIAL =====================================================================================================================

`ifdef   synthesis
`else
// synopsys translate_off
initial begin
   $display(" A2R TAP setup:                 Target ID = %2d, Pipeline Settings = %5b:",
      A2R_slaveID,
      PPL
      );
   end
// synopsys translate_on
`endif

// BUS OUTPUT ==================================================================================================================

// These registers will synthesize out when not used -- depends on PPL settings

always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      tap               <= #1  0;
      tap_ready         <= #1  FALSE;
      tap_error         <= #1  FALSE;
      end
   else begin
      tap               <= #1  slave_read ?  slave_read_data
                         :                  {A2R_width{1'b0}};

      tap_ready         <= #1  slave_ready;
      tap_error         <= #1  slave_error;
      end
   end

assign   tap_ready_out  =  PPL[Slave_Ready_OUT]  ? tap_ready   :  slave_ready;

assign   tap_error_out  =  PPL[Slave_Ready_OUT]  ? tap_error   :  slave_error;

assign   tap_out        = !PPL[Slave_Ready_OUT] && slave_read  ?  slave_read_data : tap;


`ifdef   A2R_EXTENSION_RETRY
always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      tap_retry   <= #1  FALSE;
      end
   else begin
      tap_retry   <= #1  slave_retry;
      end
   end

assign   tap_retry_out  =  PPL[Slave_Ready_OUT]  ? tap_retry    :  slave_retry;
`endif
// BUS IN ======================================================================================================================

// These registers MAY NOT synthesize out
// If the "a2r_pipe_en" signals are tied to zero these registers may synthesize out depending on pipe_settings "PPL"
// If the "a2r_pipe_en" signals are connected to a register externally then these registers will not synthesize out and
// can be used to tune the timing of the register bus fabric.

always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      tap_in         <= #1  0;
      tap_aphi_in    <= #1  FALSE;
      tap_read_in    <= #1  FALSE;
      tap_write_in   <= #1  FALSE;
      tap_ready_in   <= #1  FALSE;
      tap_error_in   <= #1  FALSE;
      tap_grant_in   <= #1  FALSE;
      end
   else begin
      // Capture bus signals
      tap_in         <= #1  a2r_in;
      tap_aphi_in    <= #1  a2r_aphi_in;
      tap_read_in    <= #1  a2r_read_in;
      tap_write_in   <= #1  a2r_write_in;
      tap_ready_in   <= #1  a2r_ready_in;
      tap_error_in   <= #1  a2r_error_in;
      tap_grant_in   <= #1  A2R_OR_fabric ? FALSE : a2r_grant_in;
      end
   end

`ifdef   A2R_EXTENSION_RETRY
always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      tap_retry_in   <= #1  FALSE;
      end
   else begin
      tap_retry_in   <= #1  a2r_retry_in;
      end
   end
`endif

// SLAVE CONTROL ===============================================================================================================

assign   detect      =  PPL[Slave_Select_IN] ?
                           decode(tap_in[A2R_width-1:(A2R_width-A2R_lg2_slaves)], A2R_slaveID, 8'h00, FALSE ) & tap_aphi_in
                        :  decode(a2r_in[A2R_width-1:(A2R_width-A2R_lg2_slaves)], A2R_slaveID, 8'h00, FALSE ) & a2r_aphi_in;


assign   slave_done  =  slave_ready
                        `ifdef   A2R_EXTENSION_RETRY
                     |   slave_retry
                        `endif
                     |   slave_error;

always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      slave_address  <= #1 0;
      slave_read     <= #1 FALSE;
      slave_write    <= #1 FALSE;
      end
   else begin
      slave_address  <= #1 detect    ? (PPL[Slave_Select_IN] ? tap_in   : a2r_in)
                      :                 slave_address;

      slave_read     <= #1 detect    & (PPL[Slave_Select_IN] ? tap_read_in  : a2r_read_in)      // Set with detect & read
                      | slave_read   & ~slave_done;                                             // Clear with ready or error

      slave_write    <= #1 detect    & (PPL[Slave_Select_IN] ? tap_write_in : a2r_write_in)     // Set with detect & write
                      | slave_write  & ~slave_done;                                             // Clear with ready or error
      end
   end

assign   slave_write_data   =  PPL[Slave_Select_IN] ? tap_in : a2r_in;

// BUS FABRIC ==================================================================================================================

always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      a2r_enable_out    <= #1  FALSE;
      a2r_slv_en_out    <= #1  FALSE;
      end
   else begin
      a2r_enable_out    <= #1  slave_read
                         // The following terms may drop out through synthesis depending on the pipeline settings
                         | ~PPL[Slave_Select_IN]   & ~a2r_pipe_en    &  detect   & ~a2r_write_in
                         | ~PPL[Slave_Ready_OUT]                     &  detect   & ~a2r_write_in
                         |  A2R_OR_fabric;

      a2r_slv_en_out    <= #1 (slave_read | slave_write)
                         |  a2r_slv_en_out         & ~tap_ready_in   & ~a2r_aphi_in
                         // The following terms may drop out through synthesis depending on the pipeline settings
                         | ~PPL[Slave_Select_IN]   &  detect
                         | ~PPL[Slave_Ready_OUT]   &  detect
                         |  A2R_OR_fabric;
      end
   end

// NOTE: If a parallel fabric is specified then "a2r_slv_en_out" is always TRUE and these assignments will synthesize out
//       leaving direct assignment of the tap outputs to the a2r outputs.
//
//       `tUD delay used to ensure a non-zero loop delay for a serial fabric with no pipeline stages (Asynchronous loop)

wire           pipeline_en    =  a2r_pipe_en | `ACTIVE_LEVEL_reset;

assign   `tUD  a2r_out        =  a2r_enable_out ? tap_out       : (pipeline_en ? tap_in       : a2r_in      );
assign   `tUD  a2r_aphi_out   =                                   (pipeline_en ? tap_aphi_in  : a2r_aphi_in );
assign   `tUD  a2r_read_out   =                                   (pipeline_en ? tap_read_in  : a2r_read_in );
assign   `tUD  a2r_write_out  =                                   (pipeline_en ? tap_write_in : a2r_write_in);
assign   `tUD  a2r_ready_out  =  a2r_slv_en_out ? tap_ready_out : (pipeline_en ? tap_ready_in : a2r_ready_in);
assign   `tUD  a2r_error_out  =  a2r_slv_en_out ? tap_error_out : (pipeline_en ? tap_error_in : a2r_error_in);
assign   `tUD  a2r_grant_out  =                                   (pipeline_en ? tap_grant_in : a2r_grant_in);

`ifdef   A2R_EXTENSION_RETRY
assign   `tUD  a2r_retry_out  =  a2r_slv_en_out ? tap_retry_out : (pipeline_en ? tap_retry_in : a2r_retry_in);
`endif


// Describe Address Mapping of Targets and Gates ===============================================================================

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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
