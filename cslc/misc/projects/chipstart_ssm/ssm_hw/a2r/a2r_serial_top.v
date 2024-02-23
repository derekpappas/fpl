
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
**    Module Name        : A2-Register Bus Example Serially connected TOP LEVEL
**
**    Author             : RTT
**    Creation Date      : 2001/08/15
**    Description        : Example TOP LEVEL with four TAPS
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
**
*******************************************************************************************************************************/

`include "A2_common.cfg"
`include "a2r_common.cfg"

module a2r_serial_top
   #(
   `include "a2r_parameters.vh"
   )(
   clock,
   reset,
   pe0, pe1, pe2, pe3, pe4,

   m0_ad, m0_wd, m0_read, m0_write,
   m1_ad, m1_wd, m1_read, m1_write,
   m2_ad, m2_wd, m2_read, m2_write,

   s0_error, s0_rd,     s0_ready,
   s1_error, s1_rd,     s1_ready,
   s2_error, s2_rd,     s2_ready,

`ifdef A2R_EXTENSION_RETRY
   s0_retry, s1_retry,  s2_retry,
`endif

   m0_ready,  m0_error,  m0_rd,
   m1_ready,  m1_error,  m1_rd,
   m2_ready,  m2_error,  m2_rd,

   s0_ad, s0_wd, s0_read, s0_write,
   s1_ad, s1_wd, s1_read, s1_write,
   s2_ad, s2_wd, s2_read, s2_write
   );


input                                  clock;
input                                  m0_read;
input                                  m0_write;
input                                  m1_read;
input                                  m1_write;
input                                  m2_read;
input                                  m2_write;
input                                  pe0;
input                                  pe1;
input                                  pe2;
input                                  pe3;
input                                  pe4;
input                                  reset;
input                                  s0_error;
input                                  s1_error;
input                                  s2_error;
input                                  s0_ready;
input                                  s1_ready;
input                                  s2_ready;

`ifdef A2R_EXTENSION_RETRY
input                                  s0_retry;
input                                  s1_retry;
input                                  s2_retry;
`endif

input    [A2R_width-1            :0]   m0_ad;
input    [A2R_width-1            :0]   m0_wd;
input    [A2R_width-1            :0]   m1_ad;
input    [A2R_width-1            :0]   m1_wd;
input    [A2R_width-1            :0]   m2_ad;
input    [A2R_width-1            :0]   m2_wd;
input    [A2R_width-1            :0]   s0_rd;
input    [A2R_width-1            :0]   s1_rd;
input    [A2R_width-1            :0]   s2_rd;
output                                 m0_ready;
output                                 m0_error;
output                                 m1_ready;
output                                 m1_error;
output                                 m2_ready;
output                                 m2_error;
output                                 s0_read;
output                                 s0_write;
output                                 s1_read;
output                                 s1_write;
output                                 s2_read;
output                                 s2_write;
output   [A2R_width-1            :0]   m0_rd;
output   [A2R_width-1            :0]   m1_rd;
output   [A2R_width-1            :0]   m2_rd;
output   [A2R_width-1            :0]   s0_ad;
output   [A2R_width-1            :0]   s0_wd;
output   [A2R_width-1            :0]   s1_ad;
output   [A2R_width-1            :0]   s1_wd;
output   [A2R_width-1            :0]   s2_ad;
output   [A2R_width-1            :0]   s2_wd;

// INITIAL =====================================================================================================================

`ifdef synthesis
`else
// synopsis translate_off
initial begin
   $display(" Number of masters in serial segment = %3d", A2R_num_masters);
   end
// synopsis translate_on
`endif

// LOCALS ======================================================================================================================

wire   [A2R_num_taps*A2R_width-1 :0]   a2r;
wire   [A2R_num_taps-1           :0]   a2r_aphi;
wire   [A2R_num_taps-1           :0]   a2r_error;
wire   [A2R_num_taps-1           :0]   a2r_ready;
wire   [A2R_num_taps-1           :0]   a2r_read;
wire   [A2R_num_taps-1           :0]   a2r_write;

wire   [A2R_num_taps-1           :0]   a2r_grant;
wire   [A2R_num_taps-1           :0]   a2r_req;

wire   [A2R_width-1              :0]   s4_wd;
wire   [A2R_width-1              :0]   s4_rd;
wire   [A2R_width-1              :0]   s4_ad;

`ifdef   A2R_EXTENSION_RETRY
wire   [A2R_num_taps-1           :0]   a2r_retry;
`endif

// A2R TAPS ====================================================================================================================

   a2r_tap #(  4'h0,                // Master ID
               8'h12,               // Slave  ID
               8'h00,               // Mask
               FALSE,               // Gateway module ?
               TAP_pipe_settings_0
            )
         tap0  (.clock              (clock),
                .reset              (reset),
                .a2r_pipe_en        (pe0),

                .a2r_out            (a2r[TapID_0*A2R_width+31:TapID_0*A2R_width]),
                .a2r_aphi_out       (a2r_aphi[TapID_0]),
                .a2r_error_out      (a2r_error[TapID_0]),
                .a2r_ready_out      (a2r_ready[TapID_0]),
                .a2r_read_out       (a2r_read [TapID_0]),
                .a2r_write_out      (a2r_write[TapID_0]),
                .a2r_request_out    (a2r_req  [TapID_0]),
                .a2r_grant_out      (a2r_grant[TapID_0]),

                .a2r_in             (a2r[TapID_0_in*A2R_width+31:TapID_0_in*A2R_width]),
                .a2r_aphi_in        (a2r_aphi[TapID_0_in]),
                .a2r_error_in       (a2r_error[TapID_0_in]),
                .a2r_ready_in       (a2r_ready[TapID_0_in]),
                .a2r_read_in        (a2r_read [TapID_0_in]),
                .a2r_write_in       (a2r_write[TapID_0_in]),
                .a2r_request_in     (FALSE),
                .a2r_grant_in       (a2r_grant[TapID_0_in]),

                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_0_in]),
                .a2r_retry_out      (a2r_retry[TapID_0]),
                .slave_retry        (s0_retry),
                `endif

                .master_address     (m0_ad[A2R_width-1 :0]),
                .master_read        (m0_read),
                .master_write       (m0_write),
                .master_write_data  (m0_wd[A2R_width-1 :0]),
                .master_ready       (m0_ready),
                .master_error       (m0_error),
                .master_read_data   (m0_rd[A2R_width-1 :0]),

                .slave_address      (s0_ad[A2R_width-1 :0]),
                .slave_read         (s0_read),
                .slave_write        (s0_write),
                .slave_write_data   (s0_wd[A2R_width-1 :0]),
                .slave_error        (s0_error),
                .slave_read_data    (s0_rd[A2R_width-1 :0]),
                .slave_ready        (s0_ready));

   a2r_tap  #( 4'h1,                // Master ID
               8'h13,               // Slave  ID
               8'h00,               // Mask
               FALSE,               // Gateway module ?
               TAP_pipe_settings_1
             )
         tap1  (.clock              (clock),
                .reset              (reset),
                .a2r_pipe_en        (pe1),

                .a2r_out            (a2r[TapID_1*A2R_width+31:TapID_1*A2R_width]),
                .a2r_aphi_out       (a2r_aphi[TapID_1]),
                .a2r_error_out      (a2r_error[TapID_1]),
                .a2r_ready_out      (a2r_ready[TapID_1]),
                .a2r_read_out       (a2r_read [TapID_1]),
                .a2r_write_out      (a2r_write[TapID_1]),
                .a2r_request_out    (a2r_req  [TapID_1]),
                .a2r_grant_out      (a2r_grant[TapID_1]),

                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_1_in]),
                .a2r_retry_out      (a2r_retry[TapID_1]),
                .slave_retry        (s1_retry),
                `endif

                .a2r_in             (a2r[TapID_1_in*A2R_width+31:TapID_1_in*A2R_width]),
                .a2r_aphi_in        (a2r_aphi[TapID_1_in]),
                .a2r_error_in       (a2r_error[TapID_1_in]),
                .a2r_ready_in       (a2r_ready[TapID_1_in]),
                .a2r_read_in        (a2r_read [TapID_1_in]),
                .a2r_write_in       (a2r_write[TapID_1_in]),
                .a2r_request_in     (FALSE),
                .a2r_grant_in       (a2r_grant[TapID_1_in]),

                .master_address     (m1_ad[A2R_width-1 :0]),
                .master_read        (m1_read),
                .master_write       (m1_write),
                .master_write_data  (m1_wd[A2R_width-1 :0]),
                .master_ready       (m1_ready),
                .master_error       (m1_error),
                .master_read_data   (m1_rd[A2R_width-1 :0]),

                .slave_address      (s1_ad[A2R_width-1 :0]),
                .slave_read         (s1_read),
                .slave_write        (s1_write),
                .slave_write_data   (s1_wd[A2R_width-1 :0]),
                .slave_error        (s1_error),
                .slave_read_data    (s1_rd[A2R_width-1 :0]),
                .slave_ready        (s1_ready));

   a2r_tap  #(  4'h2,               // Master ID
                8'h00,              // Slave  ID
                8'h03,              // Mask
                FALSE,              // Gateway module ?
                TAP_pipe_settings_2
             )
         tap2  (.clock              (clock),
                .reset              (reset),
                .a2r_pipe_en        (pe2),

                .a2r_out            (a2r[TapID_2*A2R_width+31:TapID_2*A2R_width]),
                .a2r_aphi_out       (a2r_aphi[TapID_2]),
                .a2r_error_out      (a2r_error[TapID_2]),
                .a2r_ready_out      (a2r_ready[TapID_2]),
                .a2r_read_out       (a2r_read [TapID_2]),
                .a2r_write_out      (a2r_write[TapID_2]),
                .a2r_request_out    (a2r_req  [TapID_2]),
                .a2r_grant_out      (a2r_grant[TapID_2]),

                .a2r_in             (a2r[TapID_2_in*A2R_width+31:TapID_2_in*A2R_width]),
                .a2r_aphi_in        (a2r_aphi[TapID_2_in]),
                .a2r_error_in       (a2r_error[TapID_2_in]),
                .a2r_ready_in       (a2r_ready[TapID_2_in]),
                .a2r_read_in        (a2r_read [TapID_2_in]),
                .a2r_write_in       (a2r_write[TapID_2_in]),
                .a2r_request_in     (FALSE),
                .a2r_grant_in       (a2r_grant[TapID_2_in]),

                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_2_in]),
                .a2r_retry_out      (a2r_retry[TapID_2]),
                .slave_retry        (s2_retry),
                `endif

                .master_address     (m2_ad[A2R_width-1 :0]),
                .master_read        (m2_read),
                .master_write       (m2_write),
                .master_write_data  (m2_wd[A2R_width-1 :0]),
                .master_ready       (m2_ready),
                .master_error       (m2_error),
                .master_read_data   (m2_rd[A2R_width-1 :0]),

                .slave_address      (s2_ad[A2R_width-1 :0]),
                .slave_read         (s2_read),
                .slave_write        (s2_write),
                .slave_write_data   (s2_wd[A2R_width-1 :0]),
                .slave_error        (s2_error),
                .slave_read_data    (s2_rd[A2R_width-1 :0]),
                .slave_ready        (s2_ready));

   a2r_slave #( 8'h14,              // Slave ID
                TAP_pipe_settings_4
              )
         tap3  (.clock              (clock),
                .reset              (reset),
                .a2r_pipe_en        (pe4),

                .a2r_out            (a2r[TapID_3*A2R_width+31:TapID_3*A2R_width]),
                .a2r_aphi_out       (a2r_aphi[TapID_3]),
                .a2r_error_out      (a2r_error[TapID_3]),
                .a2r_ready_out      (a2r_ready[TapID_3]),
                .a2r_read_out       (a2r_read [TapID_3]),
                .a2r_write_out      (a2r_write[TapID_3]),
                .a2r_grant_out      (a2r_grant[TapID_3]),

                .a2r_in             (a2r[TapID_3_in*A2R_width+31:TapID_3_in*A2R_width]),
                .a2r_aphi_in        (a2r_aphi[TapID_3_in]),
                .a2r_error_in       (a2r_error[TapID_3_in]),
                .a2r_ready_in       (a2r_ready[TapID_3_in]),
                .a2r_read_in        (a2r_read [TapID_3_in]),
                .a2r_write_in       (a2r_write[TapID_3_in]),
                .a2r_grant_in       (a2r_grant[TapID_3_in]),

                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_3_in]),
                .a2r_retry_out      (a2r_retry[TapID_3]),
                .slave_retry        (s4_retry),
                `endif

                .slave_address      (s4_ad),
                .slave_read         (s4_read),
                .slave_write        (s4_write),
                .slave_write_data   (s4_wd[A2R_width-1 :0]),
                .slave_error        (FALSE),       // Error not supported by slave
                .slave_read_data    (s4_rd[A2R_width-1 :0]),
                .slave_ready        (s4_ready));


   dummy_tap
         tap4  (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_4*A2R_width+31:
                                               TapID_4*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_4]),
                .a2r_error_out      (a2r_error[TapID_4]),
                .a2r_ready_out      (a2r_ready[TapID_4]),
                .a2r_read_out       (a2r_read [TapID_4]),
                .a2r_write_out      (a2r_write[TapID_4]),
                .a2r_grant_out      (a2r_grant[TapID_4]),
                .a2r_grant_in       (a2r_grant[TapID_4_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_4_in]),
                .a2r_retry_out      (a2r_retry[TapID_4]),
                `endif
                .a2r_in             (      a2r[TapID_4_in*A2R_width+31:
                                               TapID_4_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_4_in]),
                .a2r_error_in       (a2r_error[TapID_4_in]),
                .a2r_ready_in       (a2r_ready[TapID_4_in]),
                .a2r_read_in        (a2r_read [TapID_4_in]),
                .a2r_write_in       (a2r_write[TapID_4_in]) );

   dummy_tap
         tap5  (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_5*A2R_width+31:
                                               TapID_5*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_5]),
                .a2r_error_out      (a2r_error[TapID_5]),
                .a2r_ready_out      (a2r_ready[TapID_5]),
                .a2r_read_out       (a2r_read [TapID_5]),
                .a2r_write_out      (a2r_write[TapID_5]),
                .a2r_grant_out      (a2r_grant[TapID_5]),
                .a2r_grant_in       (a2r_grant[TapID_5_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_5_in]),
                .a2r_retry_out      (a2r_retry[TapID_5]),
                `endif
                .a2r_in             (      a2r[TapID_5_in*A2R_width+31:
                                               TapID_5_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_5_in]),
                .a2r_error_in       (a2r_error[TapID_5_in]),
                .a2r_ready_in       (a2r_ready[TapID_5_in]),
                .a2r_read_in        (a2r_read [TapID_5_in]),
                .a2r_write_in       (a2r_write[TapID_5_in]) );

   dummy_tap
         tap6  (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_6*A2R_width+31:
                                               TapID_6*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_6]),
                .a2r_error_out      (a2r_error[TapID_6]),
                .a2r_ready_out      (a2r_ready[TapID_6]),
                .a2r_read_out       (a2r_read [TapID_6]),
                .a2r_write_out      (a2r_write[TapID_6]),
                .a2r_grant_out      (a2r_grant[TapID_6]),
                .a2r_grant_in       (a2r_grant[TapID_6_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_6_in]),
                .a2r_retry_out      (a2r_retry[TapID_6]),
                `endif
                .a2r_in             (      a2r[TapID_6_in*A2R_width+31:
                                               TapID_6_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_6_in]),
                .a2r_error_in       (a2r_error[TapID_6_in]),
                .a2r_ready_in       (a2r_ready[TapID_6_in]),
                .a2r_read_in        (a2r_read [TapID_6_in]),
                .a2r_write_in       (a2r_write[TapID_6_in]) );

   dummy_tap
         tap7  (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_7*A2R_width+31:
                                               TapID_7*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_7]),
                .a2r_error_out      (a2r_error[TapID_7]),
                .a2r_ready_out      (a2r_ready[TapID_7]),
                .a2r_read_out       (a2r_read [TapID_7]),
                .a2r_write_out      (a2r_write[TapID_7]),
                .a2r_grant_out      (a2r_grant[TapID_7]),
                .a2r_grant_in       (a2r_grant[TapID_7_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_7_in]),
                .a2r_retry_out      (a2r_retry[TapID_7]),
                `endif
                .a2r_in             (      a2r[TapID_7_in*A2R_width+31:
                                               TapID_7_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_7_in]),
                .a2r_error_in       (a2r_error[TapID_7_in]),
                .a2r_ready_in       (a2r_ready[TapID_7_in]),
                .a2r_read_in        (a2r_read [TapID_7_in]),
                .a2r_write_in       (a2r_write[TapID_7_in]) );

   dummy_tap
         tap8  (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_8*A2R_width+31:
                                               TapID_8*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_8]),
                .a2r_error_out      (a2r_error[TapID_8]),
                .a2r_ready_out      (a2r_ready[TapID_8]),
                .a2r_read_out       (a2r_read [TapID_8]),
                .a2r_write_out      (a2r_write[TapID_8]),
                .a2r_grant_out      (a2r_grant[TapID_8]),
                .a2r_grant_in       (a2r_grant[TapID_8_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_8_in]),
                .a2r_retry_out      (a2r_retry[TapID_8]),
                `endif
                .a2r_in             (      a2r[TapID_8_in*A2R_width+31:
                                               TapID_8_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_8_in]),
                .a2r_error_in       (a2r_error[TapID_8_in]),
                .a2r_ready_in       (a2r_ready[TapID_8_in]),
                .a2r_read_in        (a2r_read [TapID_8_in]),
                .a2r_write_in       (a2r_write[TapID_8_in]) );

   dummy_tap
         tap9  (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_9*A2R_width+31:
                                               TapID_9*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_9]),
                .a2r_error_out      (a2r_error[TapID_9]),
                .a2r_ready_out      (a2r_ready[TapID_9]),
                .a2r_read_out       (a2r_read [TapID_9]),
                .a2r_write_out      (a2r_write[TapID_9]),
                .a2r_grant_out      (a2r_grant[TapID_9]),
                .a2r_grant_in       (a2r_grant[TapID_9_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_9_in]),
                .a2r_retry_out      (a2r_retry[TapID_9]),
                `endif
                .a2r_in             (      a2r[TapID_9_in*A2R_width+31:
                                               TapID_9_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_9_in]),
                .a2r_error_in       (a2r_error[TapID_9_in]),
                .a2r_ready_in       (a2r_ready[TapID_9_in]),
                .a2r_read_in        (a2r_read [TapID_9_in]),
                .a2r_write_in       (a2r_write[TapID_9_in]) );

   dummy_tap
         tap10 (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_10*A2R_width+31:
                                               TapID_10*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_10]),
                .a2r_error_out      (a2r_error[TapID_10]),
                .a2r_ready_out      (a2r_ready[TapID_10]),
                .a2r_read_out       (a2r_read [TapID_10]),
                .a2r_write_out      (a2r_write[TapID_10]),
                .a2r_grant_out      (a2r_grant[TapID_10]),
                .a2r_grant_in       (a2r_grant[TapID_10_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_10_in]),
                .a2r_retry_out      (a2r_retry[TapID_10]),
                `endif
                .a2r_in             (      a2r[TapID_10_in*A2R_width+31:
                                               TapID_10_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_10_in]),
                .a2r_error_in       (a2r_error[TapID_10_in]),
                .a2r_ready_in       (a2r_ready[TapID_10_in]),
                .a2r_read_in        (a2r_read [TapID_10_in]),
                .a2r_write_in       (a2r_write[TapID_10_in]) );

   dummy_tap
         tap11 (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_11*A2R_width+31:
                                               TapID_11*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_11]),
                .a2r_error_out      (a2r_error[TapID_11]),
                .a2r_ready_out      (a2r_ready[TapID_11]),
                .a2r_read_out       (a2r_read [TapID_11]),
                .a2r_write_out      (a2r_write[TapID_11]),
                .a2r_grant_out      (a2r_grant[TapID_11]),
                .a2r_grant_in       (a2r_grant[TapID_11_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_11_in]),
                .a2r_retry_out      (a2r_retry[TapID_11]),
                `endif
                .a2r_in             (      a2r[TapID_11_in*A2R_width+31:
                                               TapID_11_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_11_in]),
                .a2r_error_in       (a2r_error[TapID_11_in]),
                .a2r_ready_in       (a2r_ready[TapID_11_in]),
                .a2r_read_in        (a2r_read [TapID_11_in]),
                .a2r_write_in       (a2r_write[TapID_11_in]) );

   dummy_tap
         tap12 (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_12*A2R_width+31:
                                               TapID_12*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_12]),
                .a2r_error_out      (a2r_error[TapID_12]),
                .a2r_ready_out      (a2r_ready[TapID_12]),
                .a2r_read_out       (a2r_read [TapID_12]),
                .a2r_write_out      (a2r_write[TapID_12]),
                .a2r_grant_out      (a2r_grant[TapID_12]),
                .a2r_grant_in       (a2r_grant[TapID_12_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_12_in]),
                .a2r_retry_out      (a2r_retry[TapID_12]),
                `endif
                .a2r_in             (      a2r[TapID_12_in*A2R_width+31:
                                               TapID_12_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_12_in]),
                .a2r_error_in       (a2r_error[TapID_12_in]),
                .a2r_ready_in       (a2r_ready[TapID_12_in]),
                .a2r_read_in        (a2r_read [TapID_12_in]),
                .a2r_write_in       (a2r_write[TapID_12_in]) );

   dummy_tap
         tap13 (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_13*A2R_width+31:
                                               TapID_13*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_13]),
                .a2r_error_out      (a2r_error[TapID_13]),
                .a2r_ready_out      (a2r_ready[TapID_13]),
                .a2r_read_out       (a2r_read [TapID_13]),
                .a2r_write_out      (a2r_write[TapID_13]),
                .a2r_grant_out      (a2r_grant[TapID_13]),
                .a2r_grant_in       (a2r_grant[TapID_13_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_13_in]),
                .a2r_retry_out      (a2r_retry[TapID_13]),
                `endif
                .a2r_in             (      a2r[TapID_13_in*A2R_width+31:
                                               TapID_13_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_13_in]),
                .a2r_error_in       (a2r_error[TapID_13_in]),
                .a2r_ready_in       (a2r_ready[TapID_13_in]),
                .a2r_read_in        (a2r_read [TapID_13_in]),
                .a2r_write_in       (a2r_write[TapID_13_in]) );

   dummy_tap
         tap14 (.clock              (clock),
                .reset              (reset),
                .a2r_out            (      a2r[TapID_14*A2R_width+31:
                                               TapID_14*A2R_width]),
                .a2r_aphi_out       ( a2r_aphi[TapID_14]),
                .a2r_error_out      (a2r_error[TapID_14]),
                .a2r_ready_out      (a2r_ready[TapID_14]),
                .a2r_read_out       (a2r_read [TapID_14]),
                .a2r_write_out      (a2r_write[TapID_14]),
                .a2r_grant_out      (a2r_grant[TapID_14]),
                .a2r_grant_in       (a2r_grant[TapID_14_in]),
                `ifdef  A2R_EXTENSION_RETRY
                .a2r_retry_in       (a2r_retry[TapID_14_in]),
                .a2r_retry_out      (a2r_retry[TapID_14]),
                `endif
                .a2r_in             (      a2r[TapID_14_in*A2R_width+31:
                                               TapID_14_in*A2R_width]),
                .a2r_aphi_in        ( a2r_aphi[TapID_14_in]),
                .a2r_error_in       (a2r_error[TapID_14_in]),
                .a2r_ready_in       (a2r_ready[TapID_14_in]),
                .a2r_read_in        (a2r_read [TapID_14_in]),
                .a2r_write_in       (a2r_write[TapID_14_in]) );



// SLAVE DEVICE ================================================================================================================

   A2R_sample_slave  #(3,6)
         slave4( // Global
                .clock              (clock),
                .reset              (reset),
                // A2R Bus slave interface signals

                `ifdef  A2R_EXTENSION_RETRY
                .slave_retry        (s4_retry),
                `endif

                .slave_address      (s4_ad[2:0]),
                .slave_write_data   (s4_wd[A2R_width-1 :0]),
                .slave_read_data    (s4_rd[A2R_width-1 :0]),
                .slave_read         (s4_read),
                .slave_write        (s4_write),
                .slave_ready        (s4_ready));


endmodule // a2r_top

module  dummy_tap
   #(
   `include "a2r_parameters.vh"
   )(
   clock, reset,
   a2r_out,
   a2r_aphi_out,
   a2r_error_out,
   a2r_ready_out,
   a2r_read_out,
   a2r_write_out,
   a2r_grant_out,
  `ifdef  A2R_EXTENSION_RETRY
   a2r_retry_in,
   a2r_retry_out,
  `endif
   a2r_in,
   a2r_aphi_in,
   a2r_error_in,
   a2r_ready_in,
   a2r_read_in,
   a2r_write_in,
   a2r_grant_in
   );

input                               clock, reset;
// A2R Register Bus Interface
input    [A2R_width-1         :0]   a2r_in;                // Bus input to this TAP
input                               a2r_aphi_in;           // Address Phase in
input                               a2r_read_in;           // Read Command in
input                               a2r_write_in;          // Write Command in
input                               a2r_ready_in;          // Ready in
input                               a2r_error_in;          // Error in
input                               a2r_grant_in;          // grant in

output   [A2R_width-1         :0]   a2r_out;               // Bus output from this TAP
output                              a2r_aphi_out;          // Address Phase out
output                              a2r_read_out;          // Read Command out
output                              a2r_write_out;         // Write Commadn out
output                              a2r_ready_out;         // Ready out
output                              a2r_error_out;         // Error out
output                              a2r_grant_out;         // Grant out

`ifdef  A2R_EXTENSION_RETRY
input                               a2r_retry_in;
output                              a2r_retry_out;
reg                                 a2r_retry_out;
`endif

reg      [A2R_width-1         :0]   a2r_out;
reg                                 a2r_aphi_out;
reg                                 a2r_read_out;
reg                                 a2r_write_out;
reg                                 a2r_ready_out;
reg                                 a2r_error_out;
reg                                 a2r_grant_out;

always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      a2r_out        <=  0;
      a2r_aphi_out   <=  FALSE;
      a2r_read_out   <=  FALSE;
      a2r_write_out  <=  FALSE;
      a2r_ready_out  <=  FALSE;
      a2r_error_out  <=  FALSE;
      a2r_grant_out  <=  FALSE;
     `ifdef  A2R_EXTENSION_RETRY
      a2r_retry_out  <=  FALSE;
     `endif
      end
   else begin
      a2r_out        <=  a2r_in;
      a2r_aphi_out   <=  a2r_aphi_in;
      a2r_read_out   <=  a2r_read_in;
      a2r_write_out  <=  a2r_write_in;
      a2r_ready_out  <=  a2r_ready_in;
      a2r_error_out  <=  a2r_error_in;
      a2r_grant_out  <=  a2r_grant_in;
     `ifdef  A2R_EXTENSION_RETRY
      a2r_retry_out  <=  a2r_retry_in;
     `endif
      end
   end

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

