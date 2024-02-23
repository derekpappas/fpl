// Test type: case_statement - case - default statement
// Vparser rule name:
// Author: andreib
module case_statement9;
reg a,b;
initial case(a)
	default b=0;
	endcase
endmodule
