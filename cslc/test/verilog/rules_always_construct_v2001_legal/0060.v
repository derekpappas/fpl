// Test type: always statement - case_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon6;
reg [7:0]a,b,c;
always (*b, c*)case(a)
	0:b=2;
	1:c=2;
	endcase
endmodule
