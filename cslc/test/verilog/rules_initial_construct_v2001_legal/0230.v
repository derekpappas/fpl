// Test type: initial statement - par_block - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon23;
reg [7:0]a,b;
initial (*b*) fork
	a<=2;
join
endmodule
