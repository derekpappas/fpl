//---------------------------------------------------------------------
// 6502 Softcore project
// Created April 11, 2005
// By James Patchell
//
// This code may be used anyway the user sees fit.  This is an open
// source project (i.e...it has no commercial value)
//---------------------------------------------------------------------
// This module connects the ALU to the data bus, and the internal
// registers.
// A => Accumulator
// X => X index register
// Y => Y index register
// S => Stack Pointer
// T => Temporary Register
//---------------------------------------------------------------------

module data(CLK,RESET,DATAIN,OP,DATAOUT,Carry,Ovf,Neg,Zero,BCD,IRQ,BRK);
	input CLK;
	input RESET;
	input [7:0] DATAIN;
	input [26:0] OP;
	output [7:0] DATAOUT;
	output Carry,Ovf,Neg,Zero;
	input BCD;
	input IRQ;
	input BRK;
			
 	reg [7:0]A,X,Y,S;	//accumulator, X Reg, Y Reg, Stack Pointer
	reg [7:0] M;		//alu mux
	reg [7:0] T;		//temporary register
	wire [7:0] C;		//output of alu
	wire Carry,Ovf,Neg,Zero;	//status bits from ALU
	reg [7:0] DATAOUT;

	//------------------------------------------------------------
	// Temporary Register
	// OP[23] == 1, then load T temporary reg from alu
	//------------------------------------------------------------
	always @(posedge CLK or posedge RESET)
	begin
		if(RESET)
			T <= 8'b00000000;	//clear accumulator
		else
		begin
			if(OP[23])
				T <= C;	//load accumulator from alu
			else
				T <= T;	//hold
		end
	end

	//------------------------------------------------------------
	// Accumulator
	// OP[16] == 1, then load accumulator from alu
	//------------------------------------------------------------
	always @(posedge CLK or posedge RESET)
	begin
		if(RESET)
			A <= 8'b00000000;	//clear accumulator
		else
		begin
			if(OP[16])
				A <= C;	//load accumulator from alu
			else
				A <= A;	//hold
		end
	end
	//-------------------------------------------------------------
	// X Index Register
	// OP[17] == 1, then load X Reg from alu
	//-------------------------------------------------------------
	always @ (posedge CLK or posedge RESET)
	begin
		if(RESET)
			X <= 8'b00000000;	//clear X Index Register
		else
		begin
			if(OP[17])
				X <= C;	//load X index register from alu
			else
				X <= X;	//hold
		end
	end
	//--------------------------------------------------------------
	// Y Index Register
	// OP[18] == 1, then load Y Reg from ALU
	//--------------------------------------------------------------
	always @ (posedge CLK or posedge RESET)
	begin
		if(RESET)
			Y <= 8'b00000000;	//clear Y index Register
		else
		begin
			if(OP[18])
				Y <= C;	//load Y index register from ALU
			else
				Y <= Y;	//hold
		end
	end
	//--------------------------------------------------------------
	// S Stack Pointer Register
	// OP[19] == 1, then load S reg from ALU
	//--------------------------------------------------------------
	always @ (posedge CLK or posedge RESET)
	begin
		if(RESET)
			S <= 8'b00000000;	//Clear S Stack pointer register
		else
		begin
			if (OP[19])
				S <= C;	//load stack pointer form ALU
			else
				S <= S;
		end
	end
	//--------------------------------------------------------------
	// multiplexor for ALU A input
	//--------------------------------------------------------------
	always @ (OP[22:20] or A or X or Y or S or DATAIN)
	begin
		case(OP[22:20])
			3'b000: M <= A;
			3'b001: M <= X;
			3'b010: M <= Y;
			3'b011: M <= S;
			3'b100: M <= DATAIN;
			default: M <= 8'bx;	//don't care
		endcase
	end

	//--------------------------------------------------------------
	// multiplexor for output data
	//--------------------------------------------------------------

	always @ (OP[26:24] or T or A or Y or X or S or Carry or Ovf or Neg or Zero or BRK or BCD or IRQ)
	begin
		case (OP[26:24])
			3'b000: DATAOUT <= A;
			3'b001: DATAOUT <= X;
			3'b010: DATAOUT <= Y;
			3'b011: DATAOUT <= S;
			3'b100: DATAOUT <= T;
			3'b101: DATAOUT <= {Neg,Ovf,1'b0,BRK,BCD,IRQ,Zero,Carry};	//status reg P
			default: DATAOUT <= 8'bx;	//don't care
		endcase
	end
	//--------------------------------------------------------------
	// ALU 
	//--------------------------------------------------------------

	alu alu1 (.CLK(CLK),.RESET(RESET),.A(M),.B(DATAIN),.Y(C),.OP(OP[15:0]),.C(Carry),.N(Neg),.V(Ovf),.Z(Zero) );

endmodule
