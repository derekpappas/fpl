// Test type: Continuous assignment - sup0, h1 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous506;
wire a,b;
assign (supply0, highz1) #(1,2) a=1'b1, b=1'b0;
endmodule
