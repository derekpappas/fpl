// Test type: case_statement - case - expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement4;
reg a,b;
initial case(a)
	4'b0000,4'b0001:b=1;
	endcase
endmodule
