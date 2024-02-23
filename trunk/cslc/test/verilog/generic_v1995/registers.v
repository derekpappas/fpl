/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      registers.v 
*  Date:           Aug. 8th, 1999
*  Author:         Walter Li
*  Function:       Internal Registers Module of the Board Controller
*  Change History: 26/01/00, WL, Changed the active level for out[8:15].
*				   15/02/00, WL, Changed the active level for out[2:15].
******************************************************************************/

//Presetable 14-bit registers
module registers (data, pre_, ce_wr, out);

   input [7:0] data;
   input pre_;
   input [1:0] ce_wr;
   output [15:2] out;

   integer i;

   reg  [15:2] out;
	// wire [15:2] out;
   wire temp0, temp1;

	assign temp0 = ce_wr[0];
	assign temp1 = ce_wr[1];
	//assign out[15:2] = 14'h3fff;

 	// 6-bit register with active-high clock & asynchronous preset
	always @ (posedge temp0 or negedge pre_) begin
		if (!pre_)
		  begin
		    out[7:2] = 6'h3f;		// physical output signals default 
									// are "Hi" (Feb. 15,00)
		  end
		else
		  begin
			for ( i = 2; i < 8; i = i + 1)	
			  begin
			 	out[i] = !data[i];	// set data[*] to "0", the physical output
									// signals out[*] are "Hi"; means disable.   
			  end
		  end
	end

	// 8-bit register with active-high clock & asynchronous preset
	always @ (posedge temp1 or negedge pre_) begin
		if (!pre_)
		  begin
			out[9:8] = 2'h0;		// defult are "Lo" (Jan. 26,00)
		    out[15:10] = 6'h3f;		// default are "Hi" (Jan. 26,00)
		  end
		else
		  begin
			for ( i = 2; i < 8; i = i + 1)
			  begin
			 	out[8+i] = !data[i];	// set data[*] to "1", the physical
										// signals out[*] are "Lo";
			  end						// means enable.
				
			out[8] = data[0];		// out[8:9] = "00", LEDs is OFF
			out[9] = data[1];   	// out[8:9] = "11", LEDs is ON		  
		  end
	end		// end of always
	
endmodule

