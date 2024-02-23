// Test type: always statement - event_trigger - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon15;
reg b,c;
event a;
always (*b, c*)->a;
endmodule
