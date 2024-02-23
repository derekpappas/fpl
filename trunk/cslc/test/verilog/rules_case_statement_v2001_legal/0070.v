// Test type: case_statement - case - default null
// Vparser rule name:
// Author: andreib
module case_statement7;
reg a;
initial case(a)
	default ;
	endcase
endmodule
