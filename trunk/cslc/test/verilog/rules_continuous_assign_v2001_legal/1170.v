// Test type: Continuous assignment - st0, pl1 - 2 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous117;
wire a,b,c;
assign (strong0, pull1) #(1,2) a=1'b1, b=1'b0, c=1'd2;
endmodule
