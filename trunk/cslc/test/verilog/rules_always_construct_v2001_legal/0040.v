// Test type: always statement - case_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon4;
reg [7:0]a,b,c;
always case(a)
	0:b=2;
	1:c=2;
	endcase
endmodule
