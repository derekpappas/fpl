// Test type: case_statement - case - 2 x expression,expression,expression:null
// Vparser rule name:
// Author: andreib
module case_statement15;
reg a,b;
initial case(a)
	4'b0000,4'b0001,4'b0010:;
	4'b0011,4'b0100,4'b0101:;
	endcase
endmodule
