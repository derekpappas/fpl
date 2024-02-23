// Test type: always statement - par_block - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon24;
reg [7:0]a,b,c;
always (*b, c*) fork
	a<=2;
join
endmodule
