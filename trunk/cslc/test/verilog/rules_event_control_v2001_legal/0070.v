// Test type: event_control - @ event expr, event expr
// Vparser rule name:
// Author: andreib
module event_control7;
reg a,clk;
always @ (a,clk)
a=~a;
endmodule
