// Test type: par_block - fork - block.id (ASCII) - 1 block item declaration - join
// Vparser rule name:
// Author: andreib
module par_block7;
initial fork:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a;
	join
endmodule
