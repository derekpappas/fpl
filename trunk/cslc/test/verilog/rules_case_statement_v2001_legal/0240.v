// Test type: case_statement - case - 3 x expression:statement (default:null)
// Vparser rule name:
// Author: andreib
module case_statement24;
reg a,b;
initial case(a)
	4'b0000:b=1;
	4'b0001:b=0;
	default: ;
	endcase
endmodule
