// Test type: case_statement - casex - 3 x expression,expression,expression:statement (default:statement)
// Vparser rule name:
// Author: andreib
module case_statement120;
reg a,b;
initial casex(a)
	4'bz?xX,4'b0001,4'b0010:b=1;
	4'b0011,4'b0100,4'b0101:b=0;
	default:b=0;
	endcase
endmodule
