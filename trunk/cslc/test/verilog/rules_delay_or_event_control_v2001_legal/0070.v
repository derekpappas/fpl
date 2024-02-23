// Test type: delay_or_event_control - repeat(expression) event_control
// Vparser rule name:
// Author: andreib
module delay_or_event_control7;
reg a,clk;
initial repeat(~a) @clk;
endmodule
