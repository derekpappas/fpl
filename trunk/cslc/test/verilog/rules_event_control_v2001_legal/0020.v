// Test type: event_control - @ expression
// Vparser rule name:
// Author: andreib
module event_control2;
reg clk,a;
always @ (~clk)
a=~a;
endmodule
