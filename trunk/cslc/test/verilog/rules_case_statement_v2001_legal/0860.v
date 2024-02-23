// Test type: case_statement - casex - expression,expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement86;
reg a,b;
initial casex(a)
	4'bz?xX,4'b0001,4'b0010:b=1;
	endcase
endmodule
