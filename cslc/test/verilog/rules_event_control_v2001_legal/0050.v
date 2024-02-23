// Test type: event_control - @ event expr or event expr
// Vparser rule name:
// Author: andreib
module event_control5;
reg a,clk;
always @ (a or clk)
a=~a;
endmodule
