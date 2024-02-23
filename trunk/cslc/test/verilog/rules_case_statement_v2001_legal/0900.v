// Test type: case_statement - casex - default:statement
// Vparser rule name:
// Author: andreib
module case_statement90;
reg a,b;
initial casex(a)
	default:b=0;
	endcase
endmodule
