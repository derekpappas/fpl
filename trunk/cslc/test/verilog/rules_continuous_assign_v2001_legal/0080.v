// Test type: Continuous assignment - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous8;
wire a,b;
assign #(1) a=1'b1, b=1'b0;
endmodule
