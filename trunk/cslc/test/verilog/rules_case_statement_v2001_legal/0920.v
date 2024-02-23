// Test type: case_statement - casex - 2 x expression:statement
// Vparser rule name:
// Author: andreib
module case_statement92;
reg a,b;
initial casex(a)
	4'bz?xX:b=1;
	4'b0001:b=0;
	endcase
endmodule
