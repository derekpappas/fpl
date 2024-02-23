module sext_mod(IR, alu, jmp, br, st, ld, ldi, stx, ldx,  out, imm16, imm17, imm22, imm23);
	parameter gate_delay=3;

	// Input and Output Definitions
	input [31:0] IR;
	input alu, jmp, br, st, ld, ldi, stx, ldx;
	output[31:0] out;
	output imm16, imm17, imm22, imm23;
	
	// Definitions of Internal wires and regs 
	tri[31:0] out;
	wire imm16, imm17, imm22, imm23;
	
	
	wire and_ir_alu;
	wire sel_buf12;
	wire sel_buf4;
	wire sel_buf67;

	// Circuit Begins
	
	// definition for imm16
	and #(gate_delay) and1(and_ir_alu, IR[16], alu);
	or #(gate_delay) or1(imm16, and_ir_alu, jmp);
	
	
	// definition for imm17 22 and 23
	or #(gate_delay) or2(imm17, stx, ldx);
	or #(gate_delay) or3(imm22, st, ld, ldi);
	assign imm23 = br;
	

	// signals for enabling buffers
	or #(gate_delay) or4(sel_buf12, imm16, imm17, imm22, imm23);
	or #(gate_delay) or5(sel_buf4, imm17, imm22, imm23);
	or #(gate_delay) or6(sel_buf67, imm22, imm23);
	
	tribuf_var #(16,(gate_delay))  buffer1 (out[15:0],  IR[15:0], sel_buf12);
	tribuf_31_x #(16,(gate_delay)) buffer3 (out[31:16], IR[15],   imm16);
	
	bufif1 #(gate_delay) buffer4(out[16],    IR[16], sel_buf4);
	tribuf_31_x #(17,(gate_delay))    buffer5(out[31:17], IR[16], imm17);
	
	tribuf_var #(5,(gate_delay))   buffer6(out[21:17], IR[21:17], sel_buf67);
	tribuf_31_x #(22,(gate_delay)) buffer7(out[31:22], IR[21],    imm22);

	tribuf_31_x #(22,(gate_delay)) buffer8(out[31:22], IR[22], imm23);
  	
endmodule

module tribuf_var(out,in,sel);
	parameter width = 1,gate_delay=0;
	input [width-1:0] in;
	output [width-1:0] out;	
	input sel;
	
	wire[width-1:0] in;
	tri [width-1:0] out;
	wire sel;
	
	bufif1 #(gate_delay) tmpbuf[width-1:0](out,in,sel);
endmodule 

module tribuf_31_x(out,in,sel);
	parameter down_x=0,gate_delay=0;
	input in, sel;
	output [(31-down_x):0] out;
	
	tri [(31-down_x):0] out;
	wire[(31-down_x):0] tmp;
	wire in,sel;
	assign tmp[(31-down_x):0] = {(31-down_x+1){in}};
	
	bufif1 #(gate_delay) tmpbuf[(31-down_x):0](out,tmp,sel);
endmodule	