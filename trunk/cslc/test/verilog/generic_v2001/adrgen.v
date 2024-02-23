//------------------------------------------------------------------
// address generator module for a 6502 clone CPU
//
// Created: 3-13-2005
// Author:Jim Patchell
// Contact: patchell@cox.net
// This code was created as open source and may be used freely.
//
//------------------------------------------------------------------
// operation of the address generator is controlled by the op
// paramter.
// It has the following format:
//
// Bit0   :If 1, load reg TL from data bus, otherwise hold
// Bit1   :If 1, load reg TH from data bus, otherwise hold
// Bit2..3:Controls action into PCL (program counter low)
//		00 :: NOP
//		01 :: DB -> PCL
//		10 :: AdderL -> PCL
//		11 :: TL -> PCL
// Bit4..5:Controls action into PCH (program counter high)
//		00 :: NOP
//		01 :: DB -> PCH
//		10 :: AdderH -> PCH
//		11 :: TH -> PCH
// Bit6..7:Controls output to address bus
//		00 :: PCL + PCH -> ADDRESS BUS
//		01 :: TL + TH -> ADDRESS BUS
//		10 :: S + $01 -> ADDRESS BUS
//		11 :: ADDER -> ADDRESS BUS
// Bit8:Controls A input to ADDER
//		0 :: PC
//		1 :: T
// Bit9..10:Controls B input to ADDER
//		00 :: X-REG
//		01 :: Y-REG
//		10 :: 1 (increment)
//		11 :: DB
//------------------------------------------------------------------

module adrgen(clk,reset,op,S,DB,X,Y,DBO,ADR);
    input clk;			//system clock input
    input reset;		//system reset input
    input [7:0] S;		//input from the stack pointer
    input [7:0] DB;		//input from the data bus
    input [7:0] X;		//input from the X index register
    input [7:0] Y; 		//input from the Y index register
    input [10:0] op;		//operation code for address generator next state
    output [15:0] ADR;	//this is the output from the address generator
	output [7:0] DBO;	//data bus output

	reg [15:0] ADR;	//this is the output from the address generator

	reg [7:0] PCL;		//program counter low
	reg [7:0] PCH;		//program counter high
	reg [7:0] TL;		//temp register low
	reg [7:0] TH;		//temp register high
	reg [15:0]SUM;		//output of adder
	reg [15:0] SA;		//a input to adder
	reg [15:0] SB;		//b input to adder

	//--------------------------------------------
	// program counter low register
	//--------------------------------------------
	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			PCL <= 8'b00000000;	//reset reg to 0;
		else
		begin
			case (op[3:2])
				2'b00:PCL <= PCL;	//hold PCL reg
				2'b01:PCL <= DB;	//load data bus
				2'b10:PCL <= SUM[7:0];	//load output of adder
				2'b11:PCL <= TL;	// load temp reg
			endcase
		end
	end

	//--------------------------------------------
	// program counter high register
	//--------------------------------------------
	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			PCH <= 8'b00000000;	//reset reg to 0;
		else
		begin
			case (op[5:4])
				2'b00:PCH	<= PCH;	//hold PCH reg (NOP)
				2'b01:PCH <= DB;	//load data bus
				2'b10:PCH <= SUM[15:8]; //load output of adder
				2'b11:PCH <= TH;	//load temp reg
			endcase
		end
	end

	//---------------------------------------------
	// temporary register low
	//---------------------------------------------

	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			TL <= 8'b00000000;	//reset reg to 0;
		else
		begin
			if(op[0])
				TL <= DB;		//load data bus into TL
			else
				TL <= TL;		//hold TL register (NOP)
		end
	end

	//----------------------------------------------
	// temporary register high
	//----------------------------------------------

	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			TH <= 8'b00000000;	//reset register to 0
		else
		begin
			if(op[1])
				TH <= DB;		//load data bus into TL
			else
				TH <= TH;		//hold TH register
		end
	end

	//-----------------------------------------------
	// 16 bit address adder/incrmentor
	//-----------------------------------------------
	always @ (op[8] or PCH or PCL or TL or TH)
	begin
		case (op[8])
			1'b0:SA <= {PCH,PCL};	//program counter
			1'b1:SA <= {TH,TL};		//temp reg
		endcase
	end

	always @ (op[10:9] or X or Y or DB)
	begin
		case (op[10:9])
			2'b00:SB <= {8'b00000000,X};	//add X reg
			2'b01:SB <= {8'b00000000,Y}; 	//add Y reg
			2'b10:SB <= {16'b0000000000000001};	//add 1
			2'b11:SB <= {DB[7],DB[7],DB[7],DB[7],DB[7],DB[7],DB[7],DB[7],DB};	//sign extend DB
		endcase
	end

	always @ (SA or SB)
		SUM = SA + SB;	//add SA and SB together

	//-----------------------------------------------
	// address output mux
	//-----------------------------------------------
	always @ (op[7:6] or SUM or PCL or PCH or TL or TH or S)
	begin
		case (op[7:6])
			2'b00:ADR <= {PCH,PCL};	//program counter
			2'b01:ADR <= {TH,TL};	//temp register
			2'b10:ADR <= {8'b00000001,S};	//stack pointer
			2'b11:ADR <= SUM;		//output of adder
		endcase
	end
endmodule
