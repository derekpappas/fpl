// Test type: always statement - par_block - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon22;
reg [7:0]a;
always 
fork
	a<=2;
join
endmodule
