// Test type: event_control - @ event expr or event expr or ...
// Vparser rule name:
// Author: andreib
module event_control6;
reg a,b,clk;
always @ (a or b or clk)
a=~a;
endmodule
