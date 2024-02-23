// Test type: case_statement - casez - expression:statement
// Vparser rule name:
// Author: andreib
module case_statement42;
reg a,b;
initial casez(a)
	4'bzZ?0:b=1;
	endcase
endmodule
