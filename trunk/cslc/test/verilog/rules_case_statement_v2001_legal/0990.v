// Test type: case_statement - casex - 3 x expression,expression:null (default null)
// Vparser rule name:
// Author: andreib
module case_statement99;
reg a,b;
initial casex(a)
	4'bz?xX,4'b0001:;
	4'b0010,4'b0011:;
	default ;
	endcase
endmodule
