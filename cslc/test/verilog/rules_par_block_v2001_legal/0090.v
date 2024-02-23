// Test type: par_block - fork - block.id (ASCII) - block item declaration -  1 statement - join
// Vparser rule name:
// Author: andreib
module par_block9;

initial fork:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a;
	a=1'b1;
	join
endmodule
