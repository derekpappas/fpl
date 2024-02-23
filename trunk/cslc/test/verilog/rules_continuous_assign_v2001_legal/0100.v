// Test type: Continuous assignment - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous10;
wire a;
assign #(1,2) a=1'b1;
endmodule
