// Test type: Continuous assignment - pl1, pl0 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous416;
wire a,b;
assign (pull1, pull0) #(1,2) a=1'b1, b=1'b0;
endmodule