// Test type: initial statement - case_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon5;
reg [7:0]a,b,c;
initial (*b*)case(a)
	0:b=2;
	1:c=2;
	endcase
endmodule
