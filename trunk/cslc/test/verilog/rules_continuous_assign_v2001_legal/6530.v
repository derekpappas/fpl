// Test type: Continuous assignment - h0, pl1 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous653;
wire a,b;
assign (highz0, pull1) #(1) a=1'b1, b=1'b0;
endmodule
