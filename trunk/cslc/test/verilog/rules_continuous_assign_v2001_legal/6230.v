// Test type: Continuous assignment - h0, sup1 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous623;
wire a,b;
assign (highz0, supply1) #(1) a=1'b1, b=1'b0;
endmodule
