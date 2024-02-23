// Test type: event_control - @ event expr, event expr, ...
// Vparser rule name:
// Author: andreib
module event_control8;
reg a,b,c,clk;
always @ (a,b,c,clk)
a=~a;
endmodule
