// Test type: case_statement - casex - 3 x expression:statement (default null)
// Vparser rule name:
// Author: andreib
module case_statement98;
reg a,b;
initial casex(a)
	4'bz?xX:b=1;
	4'b0001:b=0;
	default ;
	endcase
endmodule
