// Test type: par_block - fork - 1 statement - join
// Vparser rule name:
// Author: andreib
module par_block3;
reg a;
initial fork
	a=1'b1;
	join
endmodule
