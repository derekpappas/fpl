// Test type: event_control - @*
// Vparser rule name:
// Author: andreib
module event_control9;
reg a,b;
always @*
a=~a+b;
endmodule
