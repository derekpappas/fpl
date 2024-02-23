// Test type: case_statement - casez - 2 x expression,expression:null
// Vparser rule name:
// Author: andreib
module case_statement53;
reg a,b;
initial casez(a)
	4'bzZ?0,4'b0001:;
	4'b0010,4'b0011:;
	endcase
endmodule
