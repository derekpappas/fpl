// Test type: Continuous assignment - h1, st0 - 2 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous702;
wire a,b,c;
assign (highz1, strong0) #(1,2) a=1'b1, b=1'b0, c=1'd2;
endmodule
