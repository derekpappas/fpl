// Test type: case_statement - case - 3 x expression:null (default null)
// Vparser rule name:
// Author: andreib
module case_statement17;
reg a;
initial case(a)
	4'b0000:;
	4'b0001:;
	default ;
	endcase
endmodule
