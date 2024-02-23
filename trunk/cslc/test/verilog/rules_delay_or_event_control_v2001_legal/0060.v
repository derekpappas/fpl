// Test type: delay_or_event_control - @(*)
// Vparser rule name:
// Author: andreib
module delay_or_event_control6;
reg a;
initial @(*) a=1'b1;
endmodule
