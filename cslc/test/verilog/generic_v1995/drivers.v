/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      drivers.v 
*  Date:           Aug. 8th, 1999
*  Author:         Walter Li
*  Function:       Internal Buffers Module of the Board Controller
*  Change History: Feb.15,00,	WL,	Inverted the input level for OUT[0:15]
******************************************************************************/
module drivers ( in, out, irq0_smi_, hrst_740, ce_rd,
                       data);
  // Port Declaration
	input [15:0] in;
	input [15:2] out;
	input irq0_smi_;
	input hrst_740;
	input [3:0] ce_rd;

	output [7:0] data;
  // Wire Declaration
	wire oe;
	wire [7:0] out_in;
	reg [7:0] data0;
	tri [7:0] data;
  // Integer Declaration
	integer i;

  // Concurent Assignment
	assign out_in[0] = irq0_smi_;	
	assign out_in[1] = hrst_740;	
	assign out_in[7:2] = out[7:2];
	assign oe = ce_rd[0] & ce_rd[1] & ce_rd[2] & ce_rd[3];
	assign data[7:0] = (!oe ? data0[7:0] : 8'hz);
	
	// always statement
	always @(ce_rd[3:0])
	  begin
	 	case (ce_rd[3:0])
	 	       4'b1110 :			// address: XX00h
	 	       begin				//inverted the input level(Feb.15,00)
					for ( i = 0; i < 8; i = i + 1)
	 	         		data0[i] = !out_in[i];
	 	       end
	 	       4'b1101 :			// address: XX08h
	 	       begin				//inverted the input level(Feb.15,00)
					for ( i = 2; i < 8; i = i + 1)
	 	         		data0[i] = !out[i+8];
					data0[0] = out[8];	// No inversion for out[8:9]
					data0[1] = out[9];	// since out[8:9] is "00" with LED OFF
	 	       end
			   4'b1011 :			// address: XX10h
	 	       begin
	 	         data0[7:0] = in[7:0];
	 	       end
			   4'b0111 :			// address: XX18h
	 	       begin
	 	         data0[7:0] = in[15:8];
	 	       end
	 	       default : 
				 data0[7:0] = 8'hz;
	 	endcase	 		
	  end
 endmodule

