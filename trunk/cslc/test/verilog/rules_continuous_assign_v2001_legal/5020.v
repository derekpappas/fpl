// Test type: Continuous assignment - sup0, h1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous502;
wire a;
assign (supply0, highz1) #(1) a=1'b1;
endmodule
