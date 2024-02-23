// Test type: Continuous assignment - st1, st0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous340;
wire a;
assign (strong1, strong0) #(1,2) a=1'b1;
endmodule
