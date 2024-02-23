// Test type: case_statement - casex - expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement84;
reg a,b;
initial casex(a)
	4'bz?xX,4'b0001:b=1;
	endcase
endmodule
