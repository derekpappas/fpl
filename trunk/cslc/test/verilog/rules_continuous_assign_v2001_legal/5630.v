// Test type: Continuous assignment - sup1, h0 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous563;
wire a,b;
assign (supply1, highz0) #(1) a=1'b1, b=1'b0;
endmodule
