// Test type: case_statement - case - expression,expression,expression:null
// Vparser rule name:
// Author: andreib
module case_statement5;
reg a,b;
initial case(a)
	4'b0000,4'b0001,4'b0010:;
	endcase
endmodule
