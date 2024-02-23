// Test type: case_statement - case - 2 x expression:statement
// Vparser rule name:
// Author: andreib
module case_statement12;
reg a,b;
initial case(a)
	4'b0000:b=1;
	4'b0001:b=0;
	endcase
endmodule
