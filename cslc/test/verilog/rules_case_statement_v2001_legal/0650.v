// Test type: case_statement - casez - 3 x expression,expression:null (default:null)
// Vparser rule name:
// Author: andreib
module case_statement65;
reg a,b;
initial casez(a)
	4'bzZ?0,4'b0001:;
	4'b0010,4'b0011:;
	default: ;
	endcase
endmodule
