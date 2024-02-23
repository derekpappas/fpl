// Test type: case_statement - case - 3 x expression:null (default statement)
// Vparser rule name:
// Author: andreib
module case_statement29;
reg a,b;
initial case(a)
	4'b0000:;
	4'b0001:;
	default b=0;
	endcase
endmodule
