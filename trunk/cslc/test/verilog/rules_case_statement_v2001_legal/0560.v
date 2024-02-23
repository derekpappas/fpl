// Test type: case_statement - casez - 2 x expression,expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement56;
reg a,b;
initial casez(a)
	4'bzZ?0,4'b0001,4'b0010:b=1;
	4'b0011,4'b0100,4'b0101:b=0;
	endcase
endmodule
