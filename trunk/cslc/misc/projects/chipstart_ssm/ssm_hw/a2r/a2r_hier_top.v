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
**    Module Name        : A2-Register Bus Example TOP LEVEL connecting a serial segment to a parallel segment
**
**    Author             : RTT
**    Creation Date      : 2001/08/15
**    Description        : Example TOP LEVEL with two segments and a gateway between them
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

module a2r_hier_top
   #(
   `include "a2r_parameters.vh"
   )(
    clock,
    m0_ad, m0_read, m0_wd, m0_write,
    m1_ad, m1_read, m1_wd, m1_write,
    m2_ad, m2_read, m2_wd, m2_write,
    m3_ad, m3_read, m3_wd, m3_write,
    pe0, pe1, pe2, pe3, pe4, reset,
    s0_error, s0_rd, s0_ready,
    s1_error, s1_rd, s1_ready,
    s2_error, s2_rd, s2_ready,
    s3_error, s3_rd, s3_ready,
`ifdef A2R_EXTENSION_RETRY
    s3_retry, s2_retry, s1_retry, s0_retry,
`endif
    m0_ready, m0_error, m0_rd, m1_ready, m1_error, m1_rd,
    m2_ready, m2_error, m2_rd, m3_ready, m3_error, m3_rd,
    s0_ad, s0_wd, s0_read, s0_write,
    s1_ad, s1_wd, s1_read, s1_write,
    s2_ad, s2_wd, s2_read, s2_write,
    s3_ad, s3_wd, s3_read, s3_write
    );


input                                  clock;
input                                  m0_read;
input                                  m0_write;
input                                  m1_read;
input                                  m1_write;
input                                  m2_read;
input                                  m2_write;
input                                  m3_read;
input                                  m3_write;
input                                  pe0;
input                                  pe1;
input                                  pe2;
input                                  pe3;
input                                  pe4;
input                                  reset;
input                                  s0_error;
input                                  s0_ready;
input                                  s1_error;
input                                  s1_ready;
input                                  s2_error;
input                                  s2_ready;
input                                  s3_error;
input                                  s3_ready;
`ifdef A2R_EXTENSION_RETRY
input                                  s0_retry;
input                                  s1_retry;
input                                  s2_retry;
input                                  s3_retry;
`endif
input    [A2R_width-1            :0]   m0_ad;
input    [A2R_width-1            :0]   m0_wd;
input    [A2R_width-1            :0]   m1_ad;
input    [A2R_width-1            :0]   m1_wd;
input    [A2R_width-1            :0]   m2_ad;
input    [A2R_width-1            :0]   m2_wd;
input    [A2R_width-1            :0]   m3_ad;
input    [A2R_width-1            :0]   m3_wd;
input    [A2R_width-1            :0]   s0_rd;
input    [A2R_width-1            :0]   s1_rd;
input    [A2R_width-1            :0]   s2_rd;
input    [A2R_width-1            :0]   s3_rd;
output                                 m0_ready;
output                                 m0_error;
output                                 m1_ready;
output                                 m1_error;
output                                 m2_ready;
output                                 m2_error;
output                                 m3_ready;
output                                 m3_error;
output                                 s0_read;
output                                 s0_write;
output                                 s1_read;
output                                 s1_write;
output                                 s2_read;
output                                 s2_write;
output                                 s3_read;
output                                 s3_write;
output   [A2R_width-1            :0]   m0_rd;
output   [A2R_width-1            :0]   m1_rd;
output   [A2R_width-1            :0]   m2_rd;
output   [A2R_width-1            :0]   m3_rd;
output   [A2R_width-1            :0]   s0_ad;
output   [A2R_width-1            :0]   s0_wd;
output   [A2R_width-1            :0]   s1_ad;
output   [A2R_width-1            :0]   s1_wd;
output   [A2R_width-1            :0]   s2_ad;
output   [A2R_width-1            :0]   s2_wd;
output   [A2R_width-1            :0]   s3_ad;
output   [A2R_width-1            :0]   s3_wd;

// LOCALS ======================================================================================================================

wire   [A2R_width-1              :0]   gsA_ad;
wire   [A2R_width-1              :0]   gsA_wd;
wire   [A2R_width-1              :0]   gsA_rd;
wire   [A2R_width-1              :0]   gmA_ad;
wire   [A2R_width-1              :0]   gmA_wd;
wire   [A2R_width-1              :0]   gmA_rd;
wire   [A2R_width-1              :0]   gsB_ad;
wire   [A2R_width-1              :0]   gsB_wd;
wire   [A2R_width-1              :0]   gsB_rd;
wire   [A2R_width-1              :0]   gmB_ad;
wire   [A2R_width-1              :0]   gmB_wd;
wire   [A2R_width-1              :0]   gmB_rd;

// SERIAL SEGMENT ==============================================================================================================

   a2r_serial_top #(0 /* Section Number */) serial0  (
                        .clock      (clock),
                        .pe0        (pe0),
                        .pe1        (pe1),
                        .pe2        (pe2),
                        .pe3        (pe3),
                        .pe4        (pe4),
                        .reset      (reset),
`ifdef A2R_EXTENSION_RETRY
                        .s0_retry   (s2_retry),
                        .s1_retry   (s3_retry),
                        .s2_retry   (gsA_retry),
`endif
                        .m0_ad      (m2_ad),
                        .m0_read    (m2_read),
                        .m0_wd      (m2_wd),
                        .m0_write   (m2_write),
                        .m0_ready   (m2_ready),
                        .m0_error   (m2_error),
                        .m0_rd      (m2_rd),
                        .s0_ad      (s2_ad),
                        .s0_read    (s2_read),
                        .s0_wd      (s2_wd),
                        .s0_write   (s2_write),
                        .s0_rd      (s2_rd),
                        .s0_ready   (s2_ready),
                        .s0_error   (s2_error),

                        .m1_ad      (m3_ad),
                        .m1_read    (m3_read),
                        .m1_wd      (m3_wd),
                        .m1_write   (m3_write),
                        .m1_ready   (m3_ready),
                        .m1_error   (m3_error),
                        .m1_rd      (m3_rd),
                        .s1_ad      (s3_ad),
                        .s1_read    (s3_read),
                        .s1_wd      (s3_wd),
                        .s1_write   (s3_write),
                        .s1_rd      (s3_rd),
                        .s1_ready   (s3_ready),
                        .s1_error   (s3_error),

                        .m2_ad      (gmA_ad),
                        .m2_read    (gmA_read),
                        .m2_wd      (gmA_wd),
                        .m2_write   (gmA_write),
                        .m2_ready   (gmA_ready),
                        .m2_error   (gmA_error),
                        .m2_rd      (gmA_rd),
                        .s2_ad      (gsA_ad),
                        .s2_read    (gsA_read),
                        .s2_wd      (gsA_wd),
                        .s2_write   (gsA_write),
                        .s2_rd      (gsA_rd),
                        .s2_ready   (gsA_ready),
                        .s2_error   (gsA_error));


// PARALLEL SEGMENT ============================================================================================================

   a2r_parallel_top #(1 /* Section Number */ ) parallel0 (
                        .clock      (clock),
                        .pe0        (pe0),
                        .pe1        (pe1),
                        .pe2        (pe2),
                        .pe3        (pe3),
                        .pe4        (pe4),
                        .reset      (reset),
`ifdef A2R_EXTENSION_RETRY
                        .s0_retry   (s0_retry),
                        .s1_retry   (s3_retry),
                        .s2_retry   (gsB_retry),
`endif
                        .m0_ad      (m0_ad),
                        .m0_read    (m0_read),
                        .m0_wd      (m0_wd),
                        .m0_write   (m0_write),
                        .m0_ready   (m0_ready),
                        .m0_error   (m0_error),
                        .m0_rd      (m0_rd),
                        .s0_ad      (s0_ad),
                        .s0_read    (s0_read),
                        .s0_wd      (s0_wd),
                        .s0_write   (s0_write),
                        .s0_rd      (s0_rd),
                        .s0_ready   (s0_ready),
                        .s0_error   (s0_error),

                        .m1_ad      (m1_ad),
                        .m1_read    (m1_read),
                        .m1_wd      (m1_wd),
                        .m1_write   (m1_write),
                        .m1_ready   (m1_ready),
                        .m1_error   (m1_error),
                        .m1_rd      (m1_rd),
                        .s1_ad      (s1_ad),
                        .s1_read    (s1_read),
                        .s1_wd      (s1_wd),
                        .s1_write   (s1_write),
                        .s1_rd      (s1_rd),
                        .s1_ready   (s1_ready),
                        .s1_error   (s1_error),

                        .m2_ad      (gmB_ad),
                        .m2_read    (gmB_read),
                        .m2_wd      (gmB_wd),
                        .m2_write   (gmB_write),
                        .m2_ready   (gmB_ready),
                        .m2_error   (gmB_error),
                        .m2_rd      (gmB_rd),
                        .s2_ad      (gsB_ad),
                        .s2_read    (gsB_read),
                        .s2_wd      (gsB_wd),
                        .s2_write   (gsB_write),
                        .s2_rd      (gsB_rd),
                        .s2_ready   (gsB_ready),
                        .s2_error   (gsB_error));

// A2R GATEWAY =================================================================================================================

   a2r_gateway  gate0 ( .gmA_ad     (gmA_ad),
                        .gmA_read   (gmA_read),
                        .gmA_wd     (gmA_wd),
                        .gmA_write  (gmA_write),
                        .gmA_ready  (gmA_ready),
                        .gmA_error  (gmA_error),
                        .gmA_rd     (gmA_rd),
                        .gsA_ad     (gsA_ad),
                        .gsA_read   (gsA_read),
                        .gsA_wd     (gsA_wd),
                        .gsA_write  (gsA_write),
                        .gsA_rd     (gsA_rd),
                        .gsA_ready  (gsA_ready),
                        .gsA_error  (gsA_error),
`ifdef A2R_EXTENSION_RETRY
                        .gsA_retry  (gsA_retry),
                        .gsB_retry  (gsB_retry),
`endif
                        .gmB_ad     (gmB_ad),
                        .gmB_read   (gmB_read),
                        .gmB_wd     (gmB_wd),
                        .gmB_write  (gmB_write),
                        .gmB_ready  (gmB_ready),
                        .gmB_error  (gmB_error),
                        .gmB_rd     (gmB_rd),
                        .gsB_ad     (gsB_ad),
                        .gsB_read   (gsB_read),
                        .gsB_wd     (gsB_wd),
                        .gsB_write  (gsB_write),
                        .gsB_rd     (gsB_rd),
                        .gsB_ready  (gsB_ready),
                        .gsB_error  (gsB_error));


endmodule // a2r_hier_top

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

