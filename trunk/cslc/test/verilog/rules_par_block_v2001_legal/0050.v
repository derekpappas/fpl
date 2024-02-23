// Test type: par_block - fork - block.id (ASCII) -  1 statement - join
// Vparser rule name:
// Author: andreib
module par_block5;
reg a;
initial fork:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	a=1'b1;
	join
endmodule
