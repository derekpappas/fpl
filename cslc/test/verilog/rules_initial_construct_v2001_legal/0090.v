// Test type: initial statement - conditional_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon9;
reg [7:0]a,b,c;
initial (*b, c*)if(a)
	b=2;
endmodule
