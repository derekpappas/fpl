// Test type: case_statement - casez - 2 x expression:statement
// Vparser rule name:
// Author: andreib
module case_statement52;
reg a,b;
initial casez(a)
	4'bzZ?0:b=1;
	4'b0001:b=0;
	endcase
endmodule
