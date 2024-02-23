module stage2(IR2, PC2, clk, C, Z, N, V, R1, R2, Z5, clr, nop3, pause3, c5a, c6a, c7,  a1, a2, IR3, PC3, X3, Y3, MD3,cond_bit,COND2);

/*****************************************************************
        This module is the 2nd stage of the VeSPA processor.
        The following modules are instantiated
        1. opcode decoder
        2. sign extension module
        3. check condition codes
******************************************************************/

	parameter gate_delay = 3;
	
	input [31:0] IR2;
	input [31:0] PC2;
	input        clk;
	input        C,Z,N,V;
	input [31:0] R1, R2;
	input        clr;
	input	     nop3,pause3,c5a,c6a,c7;
	input [31:0] Z5;	

	output[4:0]  a1,a2;
	output[31:0] IR3;
	output[31:0] PC3;
	output[31:0] X3;
	output[31:0] Y3;
	output[31:0] MD3;
	output       cond_bit;
	output       COND2;
	
	
	//defining some internal wires
	wire mp2;
	wire imm2;
	wire mp3;
	wire mp4;
	wire[4:0] op_a2mux;
	

	// connecting wires
	//wire[31:0] R1,R2, 
	wire [31:0] PC3_mux_in;
	wire[31:0] out2;
	wire[31:0] X3_in;
	wire[31:0] Y3_in;
	wire       alu2;
	wire[4:0]  a1,a2;
	wire clr, tmp_cond,COND2;	
	wire[31:0] ir3_mux,nop3_out;
	wire[31:0] md3_mux;

//Instantiate OPCODE Decoder
// delay of 6 inside module 
dcd5_32 opdecode2(IR2[31:27], nop2, add2, sub2, or2, and2, not2, xor2, cmp2, br2, jmp2, ld2, ldi2, ldx2, st2, stx2, hlt2);

// Instantiate Sign Extension Module
// parameter is the individual gate delays for all gates in sext module
sext_mod #(3)sext(IR2, alu2, jmp2, br2, st2, ld2, ldi2, stx2, ldx2,  out2, imm16, imm17, imm22, imm23);

// Instantiate checkcc module
testcc checkcc(IR2[26:23],C,Z,N,V,tmp_cond);

// LOGIC FOR PAUSING THE X3 AND Y3 MUX's WHEN PAUSE 3 signal is active
wire pause3b;

not #3 (pause3b,pause3);
or #3 (mp2_c5a,mp2,c5a);
or #3 (mp3_c6a,mp3,c6a);
and #3 (x3sel0, pause3b, mp2_c5a);
or #3 (x3sel1, pause3, c5a);
and #3(y3sel0,pause3b,mp3_c6a);
or #3 (y3sel1,pause3,c6a);


// Instantiate Mux's
// select, Output, Input0, Input1, in2,in3
//RECTIFICATION by bigsursoftware: 
//mux4: select[1:0], in0[31:0], in1[31:0], in2[31:0], in3[31:0], output[31:0]
mux4 #(32,6) x3mux({x3sel0,x3sel1},X3_in,R1,PC2,X3,Z5);
mux4 #(32,6) y3mux({y3sel0,y3sel1},Y3_in,R2,out2,Y3,Z5);
mux2 #(5,6)  a2mux(mp4,op_a2mux,IR2[15:11],IR2[26:22]);
mux4 #(32,6)  md3mux({c7,pause3},md3_mux,R2,Z5,MD3,MD3);

//mux4 sel0,sel1,out,in0-3! selcts what goes in IR3 
mux4 #(32,6) ir3mux({nop3,pause3},ir3_mux, IR2, nop3_out, IR3, IR3);

//mux for PC2 input
mux2 #(32,6) pc3_mux(pause3,PC3_mux_in,PC2,PC3);

//Instantiate condition register
// parameters width, propogation delay
d_reg #(1,8) condreg(clk,cond_bit,COND2,clr);

// dreg for nop3
d_reg #(32,8) nop3reg(clk,nop3_out,0,clr);

// instantiate 32 bit register
// clock output input
d_reg #(32,8) PC3_reg (clk,PC3,PC3_mux_in,clr);
d_reg #(32,8) X3_reg  (clk,X3,X3_in,clr);
d_reg #(32,8) Y3_reg  (clk,Y3,Y3_in,clr);
d_reg #(32,8) IR3_reg (clk,IR3,ir3_mux,clr);
d_reg #(32,8) MD3_reg (clk,MD3,md3_mux,clr); 
 


// GENERATE PROPER CONDITION CODE
and #(gate_delay) (COND2, br2, tmp_cond);


// COMBINATIONAL CIRCUITS AND OTHER ASSIGNMENTS	

	// defining a1 and a2 signals
	assign a1 = IR2[21:17];
	assign a2 = op_a2mux;

	// creating signals for mux's
	assign mp2 = br2;
	or #(gate_delay) imm_or(imm2,imm16,imm17,imm22,imm23);	
	assign mp3 = imm2;
	or #(gate_delay) st_or_stx(mp4,st2,stx2);

	// creating alu2 signal
	or #(gate_delay) gen_alu2 (alu2,add2, sub2, or2, and2, not2, xor2, cmp2);
		
   


endmodule












