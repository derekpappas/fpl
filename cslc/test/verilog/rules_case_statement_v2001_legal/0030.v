// Test type: case_statement - case - expression,expression:null
// Vparser rule name:
// Author: andreib
module case_statement3;
reg a,b;
initial case(a)
	4'b0000,4'b0001:;
	endcase
endmodule
