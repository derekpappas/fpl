// Test type: case_statement - casex - expression,expression:null
// Vparser rule name:
// Author: andreib
module case_statement83;
reg a,b;
initial casex(a)
	4'bz?xX,4'b0001:;
	endcase
endmodule
