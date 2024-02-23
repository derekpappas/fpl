// Test type: always statement - procedural_timing_control_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon30;
reg [7:0]a,b,c;
always (*b, c*) #10 a=2;
endmodule
