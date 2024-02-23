// Test type: case_statement - casez - expression,expression,expression:statement
// Vparser rule name:
// Author: andreib
module case_statement46;
reg a,b;
initial casez(a)
	4'bzZ?0,4'b0001,4'b0010:b=1;
	endcase
endmodule
