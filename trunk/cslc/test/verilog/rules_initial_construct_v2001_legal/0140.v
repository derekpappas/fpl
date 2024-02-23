// Test type: initial statement - event_trigger - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon14;
reg b;
event a;
initial (*b*)->a;
endmodule
