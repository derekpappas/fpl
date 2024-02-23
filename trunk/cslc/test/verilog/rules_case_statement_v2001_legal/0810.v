// Test type: case_statement - casex - expression:null
// Vparser rule name:
// Author: andreib
module case_statement81;
reg a;
initial casex(a)
	4'bz?xX:;
	endcase
endmodule
