// Test type: case_statement - casez - 3 x expression:null (default:statement)
// Vparser rule name:
// Author: andreib
module case_statement75;
reg a,b;
initial casez(a)
	4'bzZ?0:;
	4'b0001:;
	default:b=0;
	endcase
endmodule
