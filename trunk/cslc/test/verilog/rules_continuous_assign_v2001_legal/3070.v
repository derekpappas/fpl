// Test type: Continuous assignment - sup1, wk0 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous307;
wire a;
assign (supply1, weak0) #(1) a=1'b1;
endmodule
