// Test type: Continuous assignment - st1, pl0 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous353;
wire a,b;
assign (strong1, pull0) #(1) a=1'b1, b=1'b0;
endmodule
