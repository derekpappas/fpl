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

			mem['h0] = 16'h6666;  	// TOP:	ADDL# R0, R1, 0X6666	 			
			mem['h1] = 16'h4802;	//
			mem['h2] = 16'hAAAA;	// ADDL# R2, R3, 0XAAAA	
			mem['h3] = 16'h4886;    //

			mem['h4] = 16'h0000;    // SUB#	R3, R2, R0
	 		mem['h5] = 16'hD0C4;	// 
			mem['h6] = 16'h2222;	// SUBL	R3, R2, 0X2222
			mem['h7] = 16'h50C6;	//

			mem['h8] = 16'h1000;	// AND# R3, R0, R2
			mem['h9] = 16'hD8C0;	//
			mem['hA] = 16'h5555;	// ANDL R3, R3, 0X5555
			mem['hB] = 16'h58C6;	//
			
			mem['hC] = 16'h0020;	// ORL R14, R14, 0X0020
			mem['hD] = 16'h639D;	//

			mem['hE] = 16'h1000;	// OR# R3, R0, R2
			mem['hF] = 16'hE0C0;	//
			mem['h10] = 16'hFFFF;	// ORL R3, R3, 0XFFFF
			mem['h11] = 16'h60C6;	//
		
			mem['h12] = 16'h0000;	// XOR# R3, R3, R0
			mem['h13] = 16'hE8C6;	//
			mem['h14] = 16'hAAAA;	// XORL R0, R3, 0XAAAA
			mem['h15] = 16'h6806;	//
		
			mem['h16] = 16'h0010;	// STOREM 0X0010, RO
			mem['h17] = 16'h1800; 	//
			mem['h18] = 16'h0000;	// ISTORE (R9+R0), R2
			mem['h19] = 16'h9892;	//
			mem['h1A] = 16'h0001;	// DSTORE 0X0001(R0), R0
			mem['h1B] = 16'h3800;	//

			mem['h1C] = 16'h0010;	// LOADM R1, 0X0010
			mem['h1D] = 16'h1040; 	//
			mem['h1E] = 16'h0000;	// ILOADM R2, (R9+R0)
			mem['h1F] = 16'h9092;	//
			mem['h20] = 16'h0001;	// DLOAD R3, 0X001(R0)
			mem['h21] = 16'h30C0;	//
			
			mem['h22] = 16'h0000;	// ANDL# R9, R9, 0X0000
			mem['h23] = 16'h5A53; 	//
			mem['h24] = 16'h8000;	// ADDL# R0, R9, 0X8000
			mem['h25] = 16'h4813;	//
			mem['h26] = 16'h0032;	// ADDL# R1, R9, 0X0032
			mem['h27] = 16'h4853;	//

			mem['h28] = 16'h8032;	// CALL DK, R3
			mem['h29] = 16'h08C0; 	//
			mem['h2A] = 16'h0800;	// ICALL (R0+R1), R3 
			mem['h2B] = 16'h88C0;	//
			mem['h2C] = 16'h0032;	// DCALL 0X0032(R0), R3
			mem['h2D] = 16'h28C0;	//

			mem['h2E] = 16'h8060;	// INT 0X8060
			mem['h2F] = 16'h7000; 	//

			mem['h30] = 16'h8030;	// DONE: JMP DONE 
			mem['h31] = 16'h0000;	//

			mem['h32] = 16'h1800;	// DK: ADD R4, R2, R3
			mem['h33] = 16'hC905; 	//
			mem['h34] = 16'h1800;	// SUB R4, R2, R3
			mem['h35] = 16'hD105;	//
			mem['h36] = 16'h0000;	// ADDL R15, R3, 0X0000 
			mem['h37] = 16'h4BC7;	//

			mem['h60] = 16'h2222;	// ISR0: STOREM 0X2222, R14
			mem['h61] = 16'h1B80;	//
			mem['h62] = 16'h0000;	// ADDL R9, R9, 0x0000
			mem['h63] = 16'h5A53;	//
			mem['h64] = 16'h0003;	// ADDL R0, R9, 0x0003
			mem['h65] = 16'h4813; 	//
			mem['h66] = 16'h0001;	// LOOP: SUBL R0, R0, 0x0001 
			mem['h67] = 16'h5000;	//
			mem['h68] = 16'h8066;	// JMPNZ LOOP
			mem['h69] = 16'h00C0;	//
			mem['h6A] = 16'h2222;	// LOADM R14, 0X2222
			mem['h6B] = 16'h1380; 	//
			mem['h6C] = 16'h0000;	// ADDL# R15, R13, 0X0000 
			mem['h6D] = 16'h4BDB;	//
			
			end
		else
		begin
			data = mem[address_bus[14:0]];
		end

	end // always

endmodule // eprom
