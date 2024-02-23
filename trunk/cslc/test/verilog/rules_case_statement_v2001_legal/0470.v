// Test type: case_statement - casez - default null
// Vparser rule name:
// Author: andreib
module case_statement47;
reg a;
initial casez(a)
	default ;
	endcase
endmodule
