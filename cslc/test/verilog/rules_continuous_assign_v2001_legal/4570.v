// Test type: Continuous assignment - wk1, st0 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous457;
wire a;
assign (weak1, strong0) #(1) a=1'b1;
endmodule
