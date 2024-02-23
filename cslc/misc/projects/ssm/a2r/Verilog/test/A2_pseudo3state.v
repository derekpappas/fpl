/********************************************************************************************************************************
**
**    Copyright © 1998..2002 Advanced Architectures
**
**    All rights reserved
**    Confidential Information
**    Limited Distribution to Authorized Persons Only
**    Created and Protected as an Unpublished Work under the U.S.Copyright act of 1976.
**
**    Project Name         : A2B Synchronous System Bus
**    Description          : Pseudo-3-state Bus Fabric
**
**    Author               : RTT
**    Creation Date        : 10/10/2002
**    Version Number       : 2.0
**
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
**
**                      mi                                   mi                                   mi
**                     / \                                  / \                                  / \
**               ____ /   \                           ____ /   \                           ____ /   \
**       ao==<==(_OR_(=+===\==========<===bi..ao==<==(_OR_(=+===\==========<===bi..ao==<==(_OR_(=+===\==========<===bi
**                     |    \_____                          |    \_____                          |    \_____
**       ai==>=========|=+===)_OR_}===>===bo..ai==>=========|=+===)_OR_}===>===bo..ai==>=========|=+===)_OR_}===>===bo
**                     | |                                  | |                                  | |
**                     | \_____                             | \_____                             | \_____
**                     +==)_OR_)==> mo                      +==)_OR_)==> mo                      +==)_OR_)==> mo
**
**    Pseudo-3-state bus uses two wires per bit, one travelling from left-to-right and the other from right-to-left.  The output
**    from the module (mi) is OR-ed into the bus sending data in both directions left and right.  Both left and right inputs
**    (ai and bi) are OR-ed together to provide the input to the module (mo).  Optionally the data output from the module (mi)
**    can be OR-ed into the output to the module (mo) by setting A2B_enable_passthrough = 1;
**
**    The bus is formed by butting-up multiple a2b_pseudo3state module next to each other in a chain and setting the very end
**    inputs to zero
**
**    Notes for Synthesis:
**
********************************************************************************************************************************
**
**    USAGE:
**          a2b_pseudo3state  #(A2B_acb_width,0) u1 ( .mi(mod_a2b_acb_o),     // This is module 1 and attached to 0 and 2
**                                                    .mo(a2b_mod_acb_i),
**                                                    .ai(a2b_acb_seg01),     // attaches to segment from 0 to 1
**                                                    .ao(a2b_acb_seg10),     // attaches to segment from 1 to 0
**                                                    .bi(a2b_acb_seg21),     // attaches to segment from 2 to 1
**                                                    .bo(a2b_acb_seg12) );   // attaches to segment from 1 to 2
**
********************************************************************************************************************************/
`timescale 1ns/10ps

module      a2_pseudo3state  ( mo, mi, ao, ai, bo, bi );

parameter   BUS_WIDTH   =  32;         // All input sources must be the same width or padded to match!
parameter   PASSTHROUGH =   0;         // If the module needs its out passed through to the input set to 1

input       [BUS_WIDTH-1:0]   mi;      // Data from a module to be placed on the pseudo-3-state bus
input       [BUS_WIDTH-1:0]   ai;      // Data from the a side pseudo-3-state bus
input       [BUS_WIDTH-1:0]   bi;      // Data from the b side pseudo-3-state bus
output      [BUS_WIDTH-1:0]   mo;      // Data from the pseudo-3-state bus to send to a module
output      [BUS_WIDTH-1:0]   ao;      // Data to the a side pseudo-3-state bus
output      [BUS_WIDTH-1:0]   bo;      // Data to the b side pseudo-3-state bus

assign      mo = (PASSTHROUGH ? mi : {BUS_WIDTH{1'b0}}) | ai | bi;
assign      ao =  mi | bi;
assign      bo =  mi | ai;

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

