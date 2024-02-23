// Test type: Continuous assignment - h1, st0 - 1 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous699;
wire a,b,c;
assign (highz1, strong0) #(1) a=1'b1, b=1'b0, c=1'd2;
endmodule
