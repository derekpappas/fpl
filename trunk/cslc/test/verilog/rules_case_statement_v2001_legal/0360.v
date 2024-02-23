// Test type: case_statement - case - 3 x expression:statement (default:statement)
// Vparser rule name:
// Author: andreib
module case_statement36;
reg a,b;
initial case(a)
	4'b0000:b=1;
	4'b0001:b=0;
	default:b=0;
	endcase
endmodule
