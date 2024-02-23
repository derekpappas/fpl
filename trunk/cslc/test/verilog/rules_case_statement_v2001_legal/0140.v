// Test type: case_statement - case - 2 x expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement14;
reg a,b;
initial case(a)
	4'b0000,4'b0001:b=1;
	4'b0010,4'b0011:b=0;
	endcase
endmodule
