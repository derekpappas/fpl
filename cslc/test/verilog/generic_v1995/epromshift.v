`timescale 1 ns /100 ps

// `include "micro.v"

/*******************************************************************************
*
* Authors: Adrian Ellsworth & Dennis King
* ---------------------------------------
*
* Last Edited: February 24, 1999
* -----------------------------
* 
* Description
* -----------
* This module will serve as a 32K x 16bit EPROM.  The data stored in it is
* the user code (instructions) for the DECE RISC processor.
*
******************************************************************************/
		
module eprom(rd, address_bus, data_bus, eprom_reset, inta);
// This module is for debugging the instruction set.
// Not to be used in real operation

	output[15:0] data_bus;
	input [15:0] address_bus;
	input rd;			// OE = RD
	input eprom_reset;
	input inta;

	wire [15:0] address_bus;
	wire [15:0] data_bus;
	wire rd;
	wire eprom_reset;
	wire inta;

	// Define program as in a real EEPROM
	reg [15:0] mem[0:'h7FFF];  // Instructions of 16-bits each
	reg [15:0] data;
	wire cs;

	// Put program into eeprom (HERE:	jmpcc HERE; )

	assign cs = address_bus[15] && rd && ~inta;

	tristate tristate7(data, data_bus, cs);

	always @(posedge rd or eprom_reset)
	begin
		if (eprom_reset)
			begin
			$display("Resetting the EEPROM with the USER code into it!");

			mem['h0] = 16'h0002;  	// TOP:	ADDL#	R0, R1, 0x0002
			mem['h1] = 16'h4803;	//
			mem['h2] = 16'h1111;	// 	ADDL#	R2, R1, 0x1111
			mem['h3] = 16'h4883;    //
			mem['h4] = 16'h0000;    //	SHIFTu	R3, R2, 0x0000(R0)
	 		mem['h5] = 16'h40C4;	// 

			mem['h6] = 16'h6666;	// ADDL# R2, R1, 0x6666
			mem['h7] = 16'h4883;	//
			mem['h8] = 16'h0400;	// SHIFTs R3, R2, 0x00(R0) 
			mem['h9] = 16'h40C4;	//

			mem['hA] = 16'h0001;	// SUBL	R0, R1, 0x0001
			mem['hB] = 16'h5002;	//
			mem['hC] = 16'h1111;	// ADDL# R2, R1, 0x1111
			mem['hD] = 16'h4883;	//
			mem['hE] = 16'h0400;	// SHIFTs R3, R2, 0x00(R0)
			mem['hF] = 16'h40C4;	//

			mem['h10] = 16'h0001;	// ADDL	R0, R1, 0x0001
			mem['h11] = 16'h4802;	//
			mem['h12] = 16'h1111;	// ADDL# R2, R1, 0x1111
			mem['h13] = 16'h4883;	//
			mem['h14] = 16'h0402;	// SHIFTs  R3, R2, 0x02(R0)
			mem['h15] = 16'h40C4;	//
		
			mem['h16] = 16'h0010;	// SUBL	R0, R1, 16
			mem['h17] = 16'h5002; 	//
			mem['h18] = 16'hFFFF;	// ADDL	R2, R1, 0xFFFF
			mem['h19] = 16'h4882;	//
			mem['h1A] = 16'h0400;	// SHIFTs R3, R2, 0x00(R0)
			mem['h1B] = 16'h40C4;	//

			mem['h1C] = 16'h0002;	// ADDL	R0, R1, 0x0002
			mem['h1D] = 16'h4802; 	//
			mem['h1E] = 16'hFFFF;	// ADDL# R2, R1, 0xFFFF
			mem['h1F] = 16'h4883;	//
			mem['h20] = 16'h040C;	// SHIFTs  R3, R2, 0x0C(R0)
			mem['h21] = 16'h40C4;	//
			
			mem['h22] = 16'h9999;	// ADDL	R3, R1, 0x9999
			mem['h23] = 16'h48C2; 	//
			mem['h24] = 16'h0006;	// SUBL	R0, R1, 6
			mem['h25] = 16'h5002;	//
			mem['h26] = 16'h0401;	// SHIFTs R3, R3, 0x01(R6)
			mem['h27] = 16'h40C6;	//
		
			mem['h28] = 16'h8028;	//  DONE: JMP  DONE
			mem['h29] = 16'h0000; 	//
			
			end
		else
		begin
			data = mem[address_bus[14:0]];
		end

	end // always

endmodule // eprom
