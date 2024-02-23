// Test type: always statement - case_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon5;
reg [7:0]a,b,c;
always (*b*)case(a)
	0:b=2;
	1:c=2;
	endcase
endmodule
