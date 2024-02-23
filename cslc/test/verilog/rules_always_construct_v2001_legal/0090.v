// Test type: always statement - conditional_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon9;
reg [7:0]a,b,c;
always (*b, c*)if(a)
	b=2;
endmodule
