// Test type: loop statement - for
// Vparser rule name:
// Author: andreib
module loop_statement4;
reg a;
integer i;
initial for (i=0;i<10;i=i+1)
	a=a+1;
endmodule
