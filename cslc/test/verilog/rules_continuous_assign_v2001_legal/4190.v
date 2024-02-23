// Test type: Continuous assignment - pl1, pl0 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous419;
wire a,b;
assign (pull1, pull0) #(1,2,3) a=1'b1, b=1'b0;
endmodule
