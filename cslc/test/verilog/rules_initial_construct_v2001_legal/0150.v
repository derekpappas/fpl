// Test type: initial statement - event_trigger - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon15;
reg b,c;
event a;
initial (*b, c*)->a;
endmodule
