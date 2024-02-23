// Test type: case_statement - casez - default:statement
// Vparser rule name:
// Author: andreib
module case_statement50;
reg a,b;
initial casez(a)
	default:b=0;
	endcase
endmodule
