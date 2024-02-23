// Test type: case_statement - casez - 3 x expression:statement (default null)
// Vparser rule name:
// Author: andreib
module case_statement58;
reg a,b;
initial casez(a)
	4'bzZ?0:b=1;
	4'b0001:b=0;
	default ;
	endcase
endmodule
