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
* This module will serve as a 32K x 16bit SRAM.  
*
******************************************************************************/
		
module sram(rd, wr, address_bus, data_bus, inta);
// This module is for debugging the instruction set.
// Not to be used in real operation

	inout [15:0] data_bus;
	input [15:0] address_bus;
	input rd, wr;			// OE = RD, WE = WR
	input inta;

	wire [15:0] address_bus;
	wire [15:0] data_bus;
	wire rd, wr;
	wire inta;	

	reg [15:0] mem[0:16'h7FFF];	  // 16-bit wide SRAM
	reg [15:0] data;	
	wire cs;

	assign cs = ~address_bus[15] && rd && ~inta;

	tristate tristate6(data, data_bus, cs);

	always @(posedge rd or posedge wr)
	begin
		if (rd && ~wr)
		begin
			data = mem[address_bus];
		end
		else if (wr && ~rd)
		begin
			mem[address_bus] = data_bus;
		end

	end // always

endmodule // sram
