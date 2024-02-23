// Test type: Continuous assignment - wk1, st0 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous458;
wire a,b;
assign (weak1, strong0) #(1) a=1'b1, b=1'b0;
endmodule
