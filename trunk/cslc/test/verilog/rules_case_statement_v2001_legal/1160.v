// Test type: case_statement - casex - 3 x expression:statement (default:statement)
// Vparser rule name:
// Author: andreib
module case_statement116;
reg a,b;
initial casex(a)
	4'bz?xX:b=1;
	4'b0001:b=0;
	default:b=0;
	endcase
endmodule
