// Test type: always statement - conditional_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon8;
reg [7:0]a,b;
always (*b*)if(a)
	b=2;
endmodule
