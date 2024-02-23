// Test type: always statement - procedural_timing_control_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon28;
reg [7:0]a;
always 
#10 a=2;
endmodule
