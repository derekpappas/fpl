// Test type: Continuous assignment - wk1, sup0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous445;
wire a;
assign (weak1, supply0) #(1,2) a=1'b1;
endmodule
