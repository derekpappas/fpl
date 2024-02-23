// Test type: Continuous assignment - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous13;
wire a;
assign #(1,2,3) a=1'b1;
endmodule
