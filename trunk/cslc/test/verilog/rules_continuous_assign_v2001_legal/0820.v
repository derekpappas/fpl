// Test type: Continuous assignment - st0, sup1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous82;
wire a;
assign (strong0, supply1) #(1) a=1'b1;
endmodule