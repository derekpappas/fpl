// Test type: Continuous assignment - sup0, wk1 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous71;
wire a,b;
assign (supply0, weak1) #(1,2) a=1'b1, b=1'b0;
endmodule
