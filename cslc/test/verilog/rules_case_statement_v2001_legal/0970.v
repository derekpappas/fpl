// Test type: case_statement - casex - 3 x expression:null (default null)
// Vparser rule name:
// Author: andreib
module case_statement97;
reg a;
initial casex(a)
	4'bz?xX:;
	4'b0001:;
	default ;
	endcase
endmodule
