// Test type: Continuous assignment - sup0, sup1 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous29;
wire a,b;
assign (supply0, supply1) #(1,2,3) a=1'b1, b=1'b0;
endmodule
