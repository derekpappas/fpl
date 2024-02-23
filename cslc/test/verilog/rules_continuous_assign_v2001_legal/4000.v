// Test type: Continuous assignment - pl1, st0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous400;
wire a;
assign (pull1, strong0) #(1,2) a=1'b1;
endmodule
