// Test type: case_statement - case - expression:statement
// Vparser rule name:
// Author: andreib
module case_statement2;
reg a,b;
initial case(a)
	4'b0000:b=1;
	endcase
endmodule
