// Test type: Continuous assignment - h1, sup0 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous682;
wire a;
assign (highz1, supply0) #(1) a=1'b1;
endmodule
