module stage5(IR5, Z5, R3, a3, reg_write,hlt5_found,clk,clr);
	
	parameter gate_delay = 3;

	input[31:0] IR5;
	input[31:0] Z5;
	input       clk,clr;
	
	output[31:0] R3;
	output[4:0]  a3;
	output       reg_write;
	output       hlt5_found;
	// defining internal wires
	wire       reg_write;
	wire       jmpl;
	wire[4:0]  a3;
	wire[31:0] R3;
	wire       clk,clr;
	wire       hlt5_found;

// Module Instantiations
// has a delay of 6 time units
dcd5_32 opdecode5(IR5[31:27], nop5, add5, sub5, or5, and5, not5, xor5, cmp5, br5, jmp5, ld5, ldi5, ldx5, st5, stx5, hlt5);
d_reg #(1,8) hlt5_bit(clk,hlt5_found,hlt5,clr); 

// internal combitional logic to generate reg_write signal

	and #(gate_delay)gen_jmpl(jmpl,jmp5,IR5[16]);
	or #(gate_delay) gen_write_or(reg_write,add5,sub5,and5,or5,not5,xor5,jmpl,ld5,ldi5,ldx5);

	assign a3 = IR5[26:22];
	assign R3 = Z5;




endmodule