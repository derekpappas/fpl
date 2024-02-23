// Test type: Continuous assignment - wk1, st0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous454;
wire a;
assign (weak1, strong0) #10 a=1'b1;
endmodule
