// Test type: Continuous assignment - st1, st0 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous344;
wire a,b;
assign (strong1, strong0) #(1,2,3) a=1'b1, b=1'b0;
endmodule
