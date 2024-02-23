/*******************************************************************************************************************************
**
**    Copyright © 2001..2002 Advanced Architectures
**
**    All rights reserved
**    Confidential Information
**    Limited Distribution to Authorized Persons Only
**    Created and Protected as an Unpublished Work under the U.S. Copyright act of 1976.
**
**    Project Name       : A2-Register Bus
**    Module Name        : Sample Slave Interface to registers
**
**    Author             : RTT
**    Creation Date      : 2001/11/15
**    Version Number     : 1.0
**    Description        : Example of interfacing to the A2R as a slave.
**                         The registers could be any register within a module of the system
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
*******************************************************************************************************************************/

`include "A2_common.cfg"
`include "a2r_common.cfg"

module  A2R_sample_slave
   #(
   parameter   SLV_addr_width = 3,
   `include   "a2r_parameters.vh"   // Defines characteristics of this instantiation of the A2R bus
   )( // Global
   clock, reset,
   // A2R Bus slave interface signals

  `ifdef  A2R_EXTENSION_RETRY
   slave_retry,
  `endif

   slave_address,
   slave_write_data,
   slave_read_data,
   slave_read,
   slave_write,
   slave_ready
   );


input                         clock, reset;
input    [SLV_addr_width-1:0] slave_address;
input    [A2R_width     -1:0] slave_write_data;
input                         slave_read;
input                         slave_write;

output   [A2R_width     -1:0] slave_read_data;
output                        slave_ready;

`ifdef  A2R_EXTENSION_RETRY
output                        slave_retry;
`endif

reg      [A2R_width     -1:0] slave_register_0;
reg      [A2R_width     -1:0] slave_register_1;
reg      [A2R_width     -1:0] slave_register_2;
reg      [A2R_width     -1:0] slave_register_3;
reg      [A2R_width     -1:0] slave_register_4;
reg      [A2R_width     -1:0] slave_register_5;
reg      [A2R_width     -1:0] slave_register_6;

// The registers themselves
always @(`ACTIVE_EDGE clock `or_ACTIVE_EDGE_reset) begin
   if (`ACTIVE_LEVEL_reset) begin
      slave_register_0  <= 0;
      slave_register_1  <= 0;
      slave_register_2  <= 0;
      slave_register_3  <= 0;
      slave_register_4  <= 0;
      slave_register_5  <= 0;
      slave_register_6  <= 0;
      end
   else if (slave_write) begin
      if (slave_address == 0) slave_register_0  <= slave_write_data;
      if (slave_address == 1) slave_register_1  <= slave_write_data;
      if (slave_address == 2) slave_register_2  <= slave_write_data;
      if (slave_address == 3) slave_register_3  <= slave_write_data;
      if (slave_address == 4) slave_register_4  <= slave_write_data;
      if (slave_address == 5) slave_register_5  <= slave_write_data;
      if (slave_address == 6) slave_register_6  <= slave_write_data;
      end
   end

// Read data multiplexor
assign   slave_read_data   =  (slave_address == 0) ?  slave_register_0
                           :  (slave_address == 1) ?  slave_register_1
                           :  (slave_address == 2) ?  slave_register_2
                           :  (slave_address == 3) ?  slave_register_3
                           :  (slave_address == 4) ?  slave_register_4
                           :  (slave_address == 5) ?  slave_register_5
                           :  (slave_address == 6) ?  slave_register_6
                           :                          {A2R_width{1'bx}};

assign   slave_ready = slave_read | slave_write;     // For single cycle accesses connect directly to "ready"

`ifdef  A2R_EXTENSION_RETRY
assign   slave_retry = FALSE;
`endif

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

