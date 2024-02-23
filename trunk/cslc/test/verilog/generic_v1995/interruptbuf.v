`timescale 1 ns /100 ps

// `include "micro.v"

`timescale 1 ns /100 ps

// `include "micro.v"

/*******************************************************************************
*
* Authors: Adrian Ellsworth & Dennis King
* ---------------------------------------
*
* Last Edited: March25, 1999
* -----------------------------
* 
* Description
* -----------
* This module will serve as a External interrupt Handler*
******************************************************************************/
		
module interrupt(inta, rd, iom, data_bus);
// This module is for debugging Hardware interrupts.
// The control lines are to simulate the operations of the 22v10(U19)
// Not to be used in real operation

	output [15:0] data_bus;
	input rd, inta, iom;			// OE = RD, WE = WR

	wire [15:0] data_bus;
	wire rd, inta, iom;

	wire cs;
	reg [15:0] data;	

	assign cs = inta && rd && iom;

	tristate tristate8(data, data_bus, cs);

	always @(posedge inta)
	begin
		data = 16'h8060;
	
	end // always

endmodule // interrupt
