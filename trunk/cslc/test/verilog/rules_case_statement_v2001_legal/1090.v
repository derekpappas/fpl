// Test type: case_statement - casex - 3 x expression:null (default statement)
// Vparser rule name:
// Author: andreib
module case_statement109;
reg a,b;
initial casex(a)
	4'bz?xX:;
	4'b0001:;
	default b=0;
	endcase
endmodule
