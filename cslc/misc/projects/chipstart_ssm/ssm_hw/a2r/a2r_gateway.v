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
**    Module Name        : A2-Register Bus GATEWAY
**
**    Author             : RTT
**    Creation Date      : 2001/08/15
**    Description        : A GATEWAY connects two A2R segments together the A side has priority over the B side in case
**                         there is a conflict where both segments try to access the other at the same time.  The B side will
**                         'back-off' and retry the access later and in doing so will let the A side access through onto the
**                         B-side bus segment.
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

module a2r_gateway
   #(
   `include    "a2r_parameters.vh"
   )(
   input  [A2R_width-1:0]  gsA_ad,        // Gateway slave  A-side address
   input  [A2R_width-1:0]  gsA_wd,        // Gateway slave  A-side write data
   input                   gsA_read,      // Gateway slave  A-side read
   input                   gsA_write,     // Gateway slave  A-side write
   output [A2R_width-1:0]  gsA_rd,        // Gateway slave  A-side read data
   output                  gsA_ready,     // Gateway slave  A-side ready
   output                  gsA_retry,     // Gateway slave  A-side retry
   output                  gsA_error,     // Gateway slave  A-side error

   output [A2R_width-1:0]  gmA_ad,        // Gateway master A-side address
   output [A2R_width-1:0]  gmA_wd,        // Gateway master A-side write data
   output                  gmA_write,     // Gateway master A-side write
   output                  gmA_read,      // Gateway master A-side read
   input  [A2R_width-1:0]  gmA_rd,        // Gateway master A-side read data
   input                   gmA_ready,     // Gateway master A-side ready
   input                   gmA_error,     // Gateway master A-side error

   input  [A2R_width-1:0]  gsB_ad,        // Gateway slave  B-side address
   input  [A2R_width-1:0]  gsB_wd,        // Gateway slave  B-side write data
   input                   gsB_read,      // Gateway slave  B-side read
   input                   gsB_write,     // Gateway slave  B-side write
   output [A2R_width-1:0]  gsB_rd,        // Gateway slave  B-side read data
   output                  gsB_ready,     // Gateway slave  B-side ready
   output                  gsB_retry,     // Gateway slave  B-side retry
   output                  gsB_error,     // Gateway slave  B-side error

   output [A2R_width-1:0]  gmB_ad,        // Gateway master B-side address
   output [A2R_width-1:0]  gmB_wd,        // Gateway master B-side write data
   output                  gmB_write,     // Gateway master B-side write
   output                  gmB_read,      // Gateway master B-side read
   input  [A2R_width-1:0]  gmB_rd,        // Gateway master B-side read data
   input                   gmB_ready,     // Gateway master B-side ready
   input                   gmB_error      // Gateway master B-side error
   );


// A2R GATEWAY LOGIC ===========================================================================================================

// gmA is for the bridge to be a master on the serial bus using signals received from the parallel bus slave port gsB
// gsA is for the bridge to be a slave  to the serial bus and pass down to the parallel bus though its master port gmB

// Gateway master B <-> slave A
assign   gmB_ad      =  gsA_ad;
assign   gmB_wd      =  gsA_wd;
assign   gmB_read    =  gsA_read;
assign   gmB_write   =  gsA_write;

assign   gsA_rd      =  gmB_rd;
assign   gsA_ready   =  gmB_ready;
assign   gsA_error   =  gmB_error;
assign   gsA_retry   =  FALSE;                                             // A-side has priority so no retry

// Gateway master A <-> slave B

assign   gmA_ad      =  gsB_ad;
assign   gmA_wd      =  gsB_wd;
assign   gmA_read    =  gsB_read  & ~gsA_read & ~gsA_write;                // Kill the read  if B-side access comes on
assign   gmA_write   =  gsB_write & ~gsA_read & ~gsA_write;                // Kill the write if B-side access comes on

// Retry is used here in case of a conflict from both buses to cause the lower level bus, parallel in this example, to
// "back-off" and let the higher level bus through.  Note that retry also forces ready:

assign   gsB_rd      =  gmA_rd;
assign   gsB_retry   = (gsA_read  | gsA_write) & (gsB_read | gsB_write);   // Conflict causes retry
assign   gsB_ready   =  gmA_ready | gsB_retry;                             // ready when non-busy or conflict that causes retry
assign   gsB_error   =  gmA_error;

endmodule // a2r_gateway

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

