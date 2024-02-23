// Test type: Continuous assignment - sup0, sup1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous22;
wire a;
assign (supply0, supply1) #(1) a=1'b1;
endmodule
