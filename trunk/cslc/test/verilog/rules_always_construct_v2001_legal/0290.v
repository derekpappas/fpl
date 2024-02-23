// Test type: always statement - procedural_timing_control_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon29;
reg [7:0]a,b;
always (*b*) #10 a=2;
endmodule
