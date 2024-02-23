// Test type: par_block - fork - block.id (ASCII) - more block items declaration - join
// Vparser rule name:
// Author: andreib
module par_block8;
initial fork:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a,b;
	integer c;
	real d,e;
	join
endmodule
