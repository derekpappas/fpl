// Test type: always statement - conditional_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon7;
reg [7:0]a,b;
always if(a)
	b=0;
endmodule
