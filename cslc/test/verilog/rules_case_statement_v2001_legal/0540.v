// Test type: case_statement - casez - 2 x expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement54;
reg a,b;
initial casez(a)
	4'bzZ?0,4'b0001:b=1;
	4'b0010,4'b0011:b=0;
	endcase
endmodule
