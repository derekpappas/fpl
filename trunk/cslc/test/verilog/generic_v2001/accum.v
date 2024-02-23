//------------------------------------------------------------------
// general purpose register module for a 6502 clone CPU
//
// Created: 3-13-2005
// Author:Jim Patchell
// Contact: patchell@cox.net
// This code was created as open source and may be used freely.
//------------------------------------------------------------------

module register(clk,op,reset,A,B,C,D,O);
	//-------------------------------------------------------
	// general purpose register
	// It performs 5 operations:
	//	NOP	(REG ->REG)
	//	A->REG
	//	B->REG
	//	C->REG
	//	D->REG
	//
	//-------------------------------------------------------
    input clk;
    input [2:0] op;
    input reset;
    input [7:0] A;
    input [7:0] B;
    input [7:0] C;
    input [7:0] D;
    output [7:0] O;

	reg [7:0] O;

	always @(posedge clk or posedge reset)
	begin
		if(reset)
			O <= 8'b00000000;	//reset register to zero
		else
		begin
			case(op)
				3'b000: O<= O;	//hold register contents NOP
				3'b001: O<= A;	//A->REG
				3'b010: O<= B;	//B->REG
				3'b011: O<= C;	//C->REG
				3'b100: O<= D;	//D->REG
				3'b101: O<= O;	//NOP
				3'b110: O<= O; //NOP
				3'b111: O<= O;	//NOP
			endcase
		end
	end

endmodule
