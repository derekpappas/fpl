// Test type: initial statement - par_block - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon24;
reg [7:0]a,b,c;
initial (*b, c*) fork
	a<=2;
join
endmodule
