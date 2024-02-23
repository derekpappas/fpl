// Test type: Continuous assignment - pl0, h1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous532;
wire a;
assign (pull0, highz1) #(1) a=1'b1;
endmodule
