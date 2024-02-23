// Test type: always statement - par_block - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon23;
reg [7:0]a,b;
always (*b*) fork
	a<=2;
join
endmodule
