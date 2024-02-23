// Test type: case_statement - casez - 3 x expression:null (default:null)
// Vparser rule name:
// Author: andreib
module case_statement63;
reg a;
initial casez(a)
	4'bzZ?0:;
	4'b0001:;
	default: ;
	endcase
endmodule
