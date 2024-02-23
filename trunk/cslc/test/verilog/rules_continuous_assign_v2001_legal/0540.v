// Test type: Continuous assignment - sup0, pl1 - 1 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous54;
wire a,b,c;
assign (supply0, pull1) #(1) a=1'b1, b=1'b0, c=1'd2;
endmodule
