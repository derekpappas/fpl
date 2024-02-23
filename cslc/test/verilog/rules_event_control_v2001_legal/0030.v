// Test type: event_control - @ posedge expression
// Vparser rule name:
// Author: andreib
module event_control3;
reg clk,a;
always @ (posedge clk)
a=~a;
endmodule
