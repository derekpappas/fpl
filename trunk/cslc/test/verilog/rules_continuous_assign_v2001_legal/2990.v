// Test type: Continuous assignment - sup1, pl0 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous299;
wire a,b;
assign (supply1, pull0) #(1,2,3) a=1'b1, b=1'b0;
endmodule
