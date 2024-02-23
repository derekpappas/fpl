// Test type: delay_control - (mintypmax) - expression:expression:expression
// Vparser rule name:
// Author: andreib
module delay_control5;
reg a;
initial #(1:2:3) a=1'b1;
endmodule
