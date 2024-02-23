/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      decoder.v 
*  Date:           Aug. 8th, 1999
*  Author:         Walter Li
*  Function:       Address Decoding Module of the Board Controller
*  Change History:
******************************************************************************/

`include "lpm_decode.v"

// Address decoding and generating read and write strobes for registers and buffers access
module decoder ( addr, bc_cs_, oe_, we_,
                       ce_wr, ce_rd, ce);
  // Port Declaration
	input [3:0] addr;
	input bc_cs_, oe_, we_;
	output [1:0] ce_wr;
	output [3:0] ce_rd;
	output [7:4] ce;
   // Wire Declaration
	wire [7:0] de_out;
   // integer Declaration
	integer i;
  // Concurent Assignment

  // 3-line-to-8-line decoder
	lpm_decode decoder (.data (addr[3:1]), .enable (!bc_cs_), .eq (de_out[7:0]));
		defparam decoder.LPM_WIDTH = 3;
		defparam decoder.LPM_DECODES = 8;
	
	assign ce_rd[0] = oe_ | (!de_out[0]);
	assign ce_rd[1] = oe_ | (!de_out[1]);
	assign ce_rd[2] = oe_ | (!de_out[2]);
	assign ce_rd[3] = oe_ | (!de_out[3]);
				
	assign ce_wr[0] = we_ | (!de_out[0]);
	assign ce_wr[1] = we_ | (!de_out[1]);

	assign ce[4] = !de_out[4];
	assign ce[5] = !de_out[5];
	assign ce[6] = !de_out[6];
	assign ce[7] = !de_out[7];
	
endmodule

