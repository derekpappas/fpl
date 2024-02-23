// Test type: delay_control - delay_value - identifier
// Vparser rule name:
// Author: andreib
module delay_control3;
reg a;
parameter DY=3;
initial #DY a=1'b1;
endmodule
