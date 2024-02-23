// Test type: initial statement - par_block - no attribute instance
// Vparser rule name:
// Author: andreib
module initcon22;
reg [7:0]a;
initial 
fork
	a<=2;
join
endmodule
