// Test type: case_statement - casex - expression:statement
// Vparser rule name:
// Author: andreib
module case_statement82;
reg a,b;
initial casex(a)
	4'bz?xX:b=1;
	endcase
endmodule
