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
**    Module Name        : A2-Register Bus Example Parallel connected TOP LEVEL
**
**    Author             : RTT
**    Creation Date      : 2002/08/15
**    Description        : Example TOP LEVEL with three TAPS
**
**    $Revision: 1.0 $
**    $Date: 2002-05-13 09:16:20-07 $
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
**    NOTES:
**          Maybe built using a wide input OR gate to connect the buses together or can use pseudo tristate bus
**          The outputs from the A2R TAPS assert zeros when not in use so simple OR-ing is sufficient
**          Both schemes use modules from the A2B system bus:  the parallel wide OR uses   "a2b_or.v"
**                                                             the pseudi-tristate  uses   "a2b_pseudo3state.v"
**
*******************************************************************************************************************************/

//`define  PSEUDO_TRISTATE
`include "A2_common.cfg"
`include "A2R_common.cfg"

module a2r_parallel_top
   #(
   `include "A2R_parameters.vh"
   )(
   clock,
   reset,
   pe0, pe1, pe2, pe3, pe4,

   m0_ad, m0_wd, m0_read, m0_write,
   m1_ad, m1_wd, m1_read, m1_write,
   m2_ad, m2_wd, m2_read, m2_write,

   s0_rd, s0_error, s0_ready, s0_retry,
   s1_rd, s1_error, s1_ready, s1_retry,
   s2_rd, s2_error, s2_ready, s2_retry,

   m0_rd, m0_ready, m0_error,
   m1_rd, m1_ready, m1_error,
   m2_rd, m2_ready, m2_error,

   s0_ad, s0_wd, s0_read, s0_write,
   s1_ad, s1_wd, s1_read, s1_write,
   s2_ad, s2_wd, s2_read, s2_write
   );


input                                  clock;
input                                  reset;
input                                  pe0;
input                                  pe1;
input                                  pe2;
input                                  pe3;
input                                  pe4;
input    [A2R_width-1            :0]   m0_ad;
input    [A2R_width-1            :0]   m0_wd;
input                                  m0_read;
input                                  m0_write;
input    [A2R_width-1            :0]   m1_ad;
input    [A2R_width-1            :0]   m1_wd;
input                                  m1_read;
input                                  m1_write;
input    [A2R_width-1            :0]   m2_ad;
input    [A2R_width-1            :0]   m2_wd;
input                                  m2_read;
input                                  m2_write;

input    [A2R_width-1            :0]   s0_rd;
input                                  s0_error;
input                                  s0_ready;
input                                  s0_retry;
input    [A2R_width-1            :0]   s1_rd;
input                                  s1_error;
input                                  s1_ready;
input                                  s1_retry;
input    [A2R_width-1            :0]   s2_rd;
input                                  s2_error;
input                                  s2_retry;
input                                  s2_ready;

output   [A2R_width-1            :0]   m0_rd;
output                                 m0_ready;
output                                 m0_error;
output   [A2R_width-1            :0]   m1_rd;
output                                 m1_ready;
output                                 m1_error;
output   [A2R_width-1            :0]   m2_rd;
output                                 m2_ready;
output                                 m2_error;

output   [A2R_width-1            :0]   s0_ad;
output   [A2R_width-1            :0]   s0_wd;
output                                 s0_read;
output                                 s0_write;
output   [A2R_width-1            :0]   s1_ad;
output   [A2R_width-1            :0]   s1_wd;
output                                 s1_read;
output                                 s1_write;
output   [A2R_width-1            :0]   s2_ad;
output   [A2R_width-1            :0]   s2_wd;
output                                 s2_read;
output                                 s2_write;

// LOCALS ======================================================================================================================

wire     [A2R_width-1            :0]   b;          // Parallel bus of all "a2r" signals
wire     [A2R_width-1            :0]   ti0;
wire     [A2R_width-1            :0]   ti1;
wire     [A2R_width-1            :0]   ti2;
wire     [A2R_width-1            :0]   to0;
wire     [A2R_width-1            :0]   to1;
wire     [A2R_width-1            :0]   to2;


wire     [A2R_num_requestors-1   :0]   a2r_gnt;
wire     [A2R_num_requestors-1   :0]   a2r_req;

wire                                   b_a2r_retry, b2_a2r_retry, b1_a2r_retry, b0_a2r_retry;
wire                                   b_a2r_error, b2_a2r_error, b1_a2r_error, b0_a2r_error;
wire                                   b_a2r_ready, b2_a2r_ready, b1_a2r_ready, b0_a2r_ready;
wire                                   b_a2r_read,  b2_a2r_read,  b1_a2r_read,  b0_a2r_read;
wire                                   b_a2r_write, b2_a2r_write, b1_a2r_write, b0_a2r_write;
wire                                   b_a2r_aphi,  b2_a2r_aphi,  b1_a2r_aphi,  b0_a2r_aphi ;

// BUS FABRIC ==================================================================================================================

// These signals are not included in the pseudo-trisate model as this is only a model.  In a real
// system these signals should also use the pseudo-tristate if that is the preferred hook-up method.

   or b_or37   (b_a2r_retry,     b2_a2r_retry, b1_a2r_retry, b0_a2r_retry);
   or b_or36   (b_a2r_error,     b2_a2r_error, b1_a2r_error, b0_a2r_error);
   or b_or35   (b_a2r_ready,     b2_a2r_ready, b1_a2r_ready, b0_a2r_ready);
   or b_or34   (b_a2r_write,     b2_a2r_write, b1_a2r_write, b0_a2r_write);
   or b_or33   (b_a2r_read,      b2_a2r_read,  b1_a2r_read,  b0_a2r_read );
   or b_or32   (b_a2r_aphi,      b2_a2r_aphi,  b1_a2r_aphi,  b0_a2r_aphi );

`ifdef   PSEUDO_TRISTATE

wire     [A2R_width-1            :0]   taL;
wire     [A2R_width-1            :0]   taR   =  {A2R_width{1'b0}};  // Left-hand end going 'Right'
wire     [A2R_width-1            :0]   tbL;
wire     [A2R_width-1            :0]   tbR;
wire     [A2R_width-1            :0]   tcL;
wire     [A2R_width-1            :0]   tcR;
wire     [A2R_width-1            :0]   tdL   =  {A2R_width{1'b0}};  // Right-hand end going 'Left'
wire     [A2R_width-1            :0]   tdR;

   a2_pseudo3state #(32,1) ptb0  ( .mo(ti0), .mi(to0), .ao(taL), .ai(taR), .bo(tbR), .bi(tbL) );
   a2_pseudo3state #(32,1) ptb1  ( .mo(ti1), .mi(to1), .ao(tbL), .ai(tbR), .bo(tcR), .bi(tcL) );
   a2_pseudo3state #(32,1) ptb2  ( .mo(ti2), .mi(to2), .ao(tcL), .ai(tcR), .bo(tdR), .bi(tdL) );


`else

or u_a2r_fabric[A2R_width-1:0]  (
              b[A2R_width-1:0],
            to2[A2R_width-1:0],
            to1[A2R_width-1:0],
            to0[A2R_width-1:0]
   );

   assign   ti0 = b;
   assign   ti1 = b;
   assign   ti2 = b;
`endif


// A2R TAPS ====================================================================================================================

   a2r_tap #(
               0,                   // A2R_masterID
               8'h00,               // A2R_slaveID
               8'h00,               // A2R_maskID
               FALSE,               // A2R_gateway
               TAP_pipe_settings_0, // PPL settings
               1                    // Section Number
             ) tap0 (
               .clock               (clock),
               .reset               (reset),
               .a2r_pipe_en         (pe2),

               .a2r_aphi_in         (b_a2r_aphi),
               .a2r_error_in        (b_a2r_error),
               .a2r_grant_in        (a2r_gnt[A2R_num_requestors-1:0]),
               .a2r_in              (ti0[A2R_width-1:0]),
               .a2r_ready_in        (b_a2r_ready),
               .a2r_request_in      (a2r_req[A2R_num_requestors-1:0]),
               .a2r_write_in        (b_a2r_write),
               .a2r_read_in         (b_a2r_read),

`ifdef A2R_EXTENSION_RETRY
               .a2r_retry_in        (b_a2r_retry),
               .a2r_retry_out       (b0_a2r_retry),
               .slave_retry         (s0_retry),
`endif
               .a2r_aphi_out        (b0_a2r_aphi),
               .a2r_error_out       (b0_a2r_error),
               .a2r_grant_out       (a2r_gnt[0]),
               .a2r_out             (to0[A2R_width-1:0]),
               .a2r_ready_out       (b0_a2r_ready),
               .a2r_request_out     (a2r_req[0]),
               .a2r_read_out        (b0_a2r_read),
               .a2r_write_out       (b0_a2r_write),

               .master_address      (m0_ad[A2R_width-1:0]),
               .master_write_data   (m0_wd[A2R_width-1:0]),
               .master_read_data    (m0_rd[A2R_width-1:0]),
               .master_read         (m0_read),
               .master_write        (m0_write),
               .master_error        (m0_error),
               .master_ready        (m0_ready),

               .slave_address       (s0_ad[A2R_width-1:0]),
               .slave_write_data    (s0_wd[A2R_width-1:0]),
               .slave_read_data     (s0_rd[A2R_width-1:0]),
               .slave_read          (s0_read),
               .slave_write         (s0_write),
               .slave_error         (s0_error),
               .slave_ready         (s0_ready)
               );

   a2r_tap #(  1,                   // A2R_masterID
               8'h01,               // A2R_slaveID
               8'h00,               // A2R_maskID
               FALSE,               // A2R_gateway
               TAP_pipe_settings_1, // PPL settings
               1                    // Section Number
             ) tap1 (
               .clock               (clock),
               .reset               (reset),
               .a2r_pipe_en         (pe1),

               .a2r_aphi_in         (b_a2r_aphi),
               .a2r_error_in        (b_a2r_error),
               .a2r_grant_in        (a2r_gnt[A2R_num_requestors-1:0]),
               .a2r_in              (ti1[A2R_width-1:0]),
               .a2r_ready_in        (b_a2r_ready),
               .a2r_request_in      (a2r_req[A2R_num_requestors-1:0]),
               .a2r_read_in         (b_a2r_read),
               .a2r_write_in        (b_a2r_write),

`ifdef A2R_EXTENSION_RETRY
               .a2r_retry_in        (b_a2r_retry),
               .a2r_retry_out       (b1_a2r_retry),
               .slave_retry         (s1_retry),
`endif

               .a2r_aphi_out        (b1_a2r_aphi),
               .a2r_error_out       (b1_a2r_error),
               .a2r_grant_out       (a2r_gnt[1]),
               .a2r_out             (to1[A2R_width-1:0]),
               .a2r_ready_out       (b1_a2r_ready),
               .a2r_request_out     (a2r_req[1]),
               .a2r_read_out        (b1_a2r_read),
               .a2r_write_out       (b1_a2r_write),

               .master_address      (m1_ad[A2R_width-1:0]),
               .master_write_data   (m1_wd[A2R_width-1:0]),
               .master_read_data    (m1_rd[A2R_width-1:0]),
               .master_read         (m1_read),
               .master_write        (m1_write),
               .master_ready        (m1_ready),
               .master_error        (m1_error),

               .slave_address       (s1_ad[A2R_width-1:0]),
               .slave_write_data    (s1_wd[A2R_width-1:0]),
               .slave_read_data     (s1_rd[A2R_width-1:0]),
               .slave_read          (s1_read),
               .slave_write         (s1_write),
               .slave_ready         (s1_ready),
               .slave_error         (s1_error)
               );

   a2r_tap #(  2,                   // A2R_masterID
               8'h01,               // A2R_slaveID
               8'h01,               // A2R_maskID
               TRUE,                // A2R_gateway
               TAP_pipe_settings_1, // PPL settings
               1                    // Section Number
             ) tap2 (
               .clock               (clock),
               .reset               (reset),
               .a2r_pipe_en         (pe3),

               .a2r_aphi_in         (b_a2r_aphi),
               .a2r_error_in        (b_a2r_error),
               .a2r_grant_in        (a2r_gnt[A2R_num_requestors-1:0]),
               .a2r_in              (ti2[A2R_width-1:0]),
               .a2r_ready_in        (b_a2r_ready),
               .a2r_request_in      (a2r_req[A2R_num_requestors-1:0]),
               .a2r_read_in         (b_a2r_read),
               .a2r_write_in        (b_a2r_write),

`ifdef A2R_EXTENSION_RETRY
               .a2r_retry_in        (b_a2r_retry),
               .a2r_retry_out       (b2_a2r_retry),
               .slave_retry         (s2_retry),
`endif

               .a2r_aphi_out        (b2_a2r_aphi),
               .a2r_error_out       (b2_a2r_error),
               .a2r_grant_out       (a2r_gnt[2]),
               .a2r_out             (to2[A2R_width-1:0]),
               .a2r_ready_out       (b2_a2r_ready),
               .a2r_request_out     (a2r_req[2]),
               .a2r_read_out        (b2_a2r_read),
               .a2r_write_out       (b2_a2r_write),

               .master_address      (m2_ad[A2R_width-1:0]),
               .master_read         (m2_read),
               .master_write        (m2_write),
               .master_write_data   (m2_wd[A2R_width-1:0]),
               .master_ready        (m2_ready),
               .master_error        (m2_error),
               .master_read_data    (m2_rd[A2R_width-1:0]),

               .slave_error         (s2_error),
               .slave_read_data     (s2_rd[A2R_width-1:0]),
               .slave_ready         (s2_ready),
               .slave_address       (s2_ad[A2R_width-1:0]),
               .slave_read          (s2_read),
               .slave_write         (s2_write),
               .slave_write_data    (s2_wd[A2R_width-1:0])
               );


endmodule // a2r_parallel_top

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


