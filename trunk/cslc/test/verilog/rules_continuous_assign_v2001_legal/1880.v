// Test type: Continuous assignment - pl0, wk1 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous188;
wire a,b;
assign (pull0, weak1) #(1) a=1'b1, b=1'b0;
endmodule
