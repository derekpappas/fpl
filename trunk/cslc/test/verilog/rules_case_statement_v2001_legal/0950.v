// Test type: case_statement - casex - 2 x expression,expression,expression:null
// Vparser rule name:
// Author: andreib
module case_statement95;
reg a,b;
initial casex(a)
	4'bz?xX,4'b0001,4'b0010:;
	4'b0011,4'b0100,4'b0101:;
	endcase
endmodule