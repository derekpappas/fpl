// Test type: Continuous assignment - pl0, wk1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous187;
wire a;
assign (pull0, weak1) #(1) a=1'b1;
endmodule
