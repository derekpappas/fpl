// Test type: case_statement - casex - 2 x expression:null
// Vparser rule name:
// Author: andreib
module case_statement91;
reg a;
initial casex(a)
	4'bz?xX:;
	4'b0001:;
	endcase
endmodule
