// Test type: Continuous assignment - st0, sup1 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous86;
wire a,b;
assign (strong0, supply1) #(1,2) a=1'b1, b=1'b0;
endmodule