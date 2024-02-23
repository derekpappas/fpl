// Test type: event_control - @ hierarchical_event_id
// Vparser rule name:
// Author: andreib
module event_control1;
reg clk;
event a;
always @a
  clk=~clk;
endmodule
