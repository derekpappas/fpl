// Test type: delay_or_event_control - (event_expression)
// Vparser rule name:
// Author: andreib
module delay_or_event_control4;
reg a,clk;
initial @(clk==1) a=1'b1;
endmodule
