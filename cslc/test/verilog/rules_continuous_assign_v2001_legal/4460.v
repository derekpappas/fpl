// Test type: Continuous assignment - wk1, sup0 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous446;
wire a,b;
assign (weak1, supply0) #(1,2) a=1'b1, b=1'b0;
endmodule
