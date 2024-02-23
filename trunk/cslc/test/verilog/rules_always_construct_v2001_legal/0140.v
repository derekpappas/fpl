// Test type: always statement - event_trigger - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon14;
reg b;
event a;
always (*b*)->a;
endmodule
