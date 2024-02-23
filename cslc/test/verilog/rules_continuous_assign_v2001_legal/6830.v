// Test type: Continuous assignment - h1, sup0 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous683;
wire a,b;
assign (highz1, supply0) #(1) a=1'b1, b=1'b0;
endmodule
