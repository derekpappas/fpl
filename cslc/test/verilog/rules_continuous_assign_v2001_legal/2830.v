// Test type: Continuous assignment - sup1, st0 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous283;
wire a;
assign (supply1, strong0) #(1,2,3) a=1'b1;
endmodule
