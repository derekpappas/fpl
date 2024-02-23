// Test type: initial statement - procedural_timing_control_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module initcon28;
reg [7:0]a;
initial 
#10 a=2;
endmodule
