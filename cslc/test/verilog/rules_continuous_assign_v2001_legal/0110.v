// Test type: Continuous assignment - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous11;
wire a,b;
assign #(1,2) a=1'b1, b=1'b0;
endmodule
