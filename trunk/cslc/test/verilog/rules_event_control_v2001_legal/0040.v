// Test type: event_control - @ negedge expression
// Vparser rule name:
// Author: andreib
module event_control4;
reg clk,a;
always @ (negedge clk)
a=~a;
endmodule
