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

			mem['h0] = 16'h8000;  	// TOP:	ADDL#	R0, R0, 0x8000	 			
			mem['h1] = 16'h4801;	//
			mem['h2] = 16'h8000;	// ADDL	R0, R0, 0x8000
			mem['h3] = 16'h4800;    //
			mem['h4] = 16'h8042;    // JMPc	B1 
	 		mem['h5] = 16'h0180;	// 
			mem['h6] = 16'h8044;	// C1: JMPv B2
			mem['h7] = 16'h0200;	//
			mem['h8] = 16'h8046;	// C2: JMPnhv B3
			mem['h9] = 16'h02C0;	//

			mem['hA] = 16'h0008;	// C3:	ADDL#	R0, R1, 0x0080 
			mem['hB] = 16'h4803;	//
			mem['hC] = 16'h0008;	// ADDL	R0, R0, 0x0080 
			mem['hD] = 16'h4800;	//
			mem['hE] = 16'h8048;	// JMPhv	B4 
			mem['hF] = 16'h0280;	//
			mem['h10] = 16'h804A;	// C4:	JMPnv	B5 
			mem['h11] = 16'h0240;	//		
			mem['h12] = 16'h804c;	// C5:	JMPnc	B6 
			mem['h13] = 16'h01C0;	//

			mem['h14] = 16'h4444;	// C6:	ADDL#	R0, R1, 0x4444 
			mem['h15] = 16'h4803;	//
			mem['h16] = 16'h2222;	// SUBL	R0, R0, 0x2222	 
			mem['h17] = 16'h5000; 	//
			mem['h18] = 16'h804E;	// JMPnz 	B7 
			mem['h19] = 16'h00C0;	//
			mem['h1A] = 16'h8050;	// C7:	JMPnn	B8 
			mem['h1B] = 16'h0140;	//

			mem['h1C] = 16'h4444;	// C8:	ADDL#	R0, R1, 0x2222 
			mem['h1D] = 16'h4803; 	//
			mem['h1E] = 16'h4444;	// SUBL	R0, R0, 0x4444 
			mem['h1F] = 16'h5000;	//
			mem['h20] = 16'h8052;	// JMPlt	B9 
			mem['h21] = 16'h0340;	//			
			mem['h22] = 16'h8054;	// C9:	JMPlte	B10 
			mem['h23] = 16'h03C0; 	//

			mem['h24] = 16'h7FFF;	// C10:	ADDL#	R0, R1, 0x5555
			mem['h25] = 16'h4803;	//
			mem['h26] = 16'h8000;	//	SUBL	R0, R0, 0x1111 
			mem['h27] = 16'h5000;	//
			mem['h28] = 16'h8056;	// 	JMPgt 	B11	
			mem['h29] = 16'h0380; 	//
			mem['h2A] = 16'h8058;	// C11:	JMPgte	B12
			mem['h2B] = 16'h0300;	//

			mem['h2C] = 16'h8000;	// C12:	ADDL#	R0, R1, 0x8000 
			mem['h2D] = 16'h4803;	//
			mem['h2E] = 16'h7FFF;	// 	SUBL	R0, R0, 0x7FFF
			mem['h2F] = 16'h5000; 	//
			mem['h30] = 16'h805C;	// C13:	JMPgteu	B14 
			mem['h31] = 16'h0400;	//

			mem['h32] = 16'h7FFF;	// C14:	ADDL#	R0, R1, 0x7FFF
			mem['h33] = 16'h4803; 	//
			mem['h34] = 16'h8000;	// SUBL	R0, R0, 0x8000 
			mem['h35] = 16'h5000;	//
			mem['h36] = 16'h805E;	// JMPltu	B15 
			mem['h37] = 16'h0440;	//
			mem['h38] = 16'h8060;	// C15:	JMPlteu	B16 
			mem['h39] = 16'h0480;	//

			mem['h3A] = 16'h8888;	// C16:	ADDL#	R0, R1, 0x8888
			mem['h3B] = 16'h4803;	//
			mem['h3C] = 16'h8888;	//	SUBL	R0, R0, 0x8888 
			mem['h3D] = 16'h5000; 	//
			mem['h3E] = 16'h8062;	// 	JMPz	B17
			mem['h3F] = 16'h0080;	//
			mem['h40] = 16'h8064;	// C17:	JMPnn	B18
			mem['h41] = 16'h0140;	//

			mem['h42] = 16'h8006;	// B1:	JMP	C1 
			mem['h43] = 16'h0000; 	//
			mem['h44] = 16'h8008;	// B2:	JMP	C2  
			mem['h45] = 16'h0000;	//
			mem['h46] = 16'h800A;	// B3:	JMP	C3 
			mem['h47] = 16'h0000; 	//
			mem['h48] = 16'h8010;	// B4:	JMP	C4 
			mem['h49] = 16'h0000;	//
			mem['h4A] = 16'h8012;	// B5:	JMP	C5 
			mem['h4B] = 16'h0000; 	//
			mem['h4C] = 16'h8014;	// B6:	JMP	C6 
			mem['h4D] = 16'h0000;	//
			mem['h4E] = 16'h801A;	// B7:	JMP	C7 
			mem['h4F] = 16'h0000; 	//
			mem['h50] = 16'h801C;	// B8:	JMP	C8  
			mem['h51] = 16'h0000;	//
			mem['h52] = 16'h8022;	// B9:	JMP	C9 
			mem['h53] = 16'h0000; 	//
			mem['h54] = 16'h8024;	// B10:	JMP	C10  
			mem['h55] = 16'h0000;	//
			mem['h56] = 16'h802A;	// B11:	JMP	C11 
			mem['h57] = 16'h0000; 	//
			mem['h58] = 16'h802C;	// B12:	JMP	C12  
			mem['h59] = 16'h0000;	//
			mem['h5A] = 16'h8030;	// B13:	JMP	C13 
			mem['h5B] = 16'h0000; 	//
			mem['h5C] = 16'h8032;	// B14:	JMP	C14  
			mem['h5D] = 16'h0000;	//
			mem['h5E] = 16'h8038;	// B15:	JMP	C15 
			mem['h5F] = 16'h0000; 	//
			mem['h60] = 16'h803A;	// B16:	JMP	C16  
			mem['h61] = 16'h0000;	//
			mem['h62] = 16'h8040;	// B17:	JMP	C17
			mem['h63] = 16'h0000; 	// 
			mem['h64] = 16'h8064;	// B18:	JMP	B18  
			mem['h65] = 16'h0000;	//

			
			end
		else
		begin
			data = mem[address_bus[14:0]];
		end

	end // always

endmodule // eprom
