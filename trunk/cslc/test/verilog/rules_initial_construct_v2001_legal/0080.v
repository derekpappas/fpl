// Test type: initial statement - conditional_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon8;
reg [7:0]a,b;
initial (*b*)if(a)
	b=2;
endmodule
