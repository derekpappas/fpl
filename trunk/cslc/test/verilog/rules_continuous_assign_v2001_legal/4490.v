// Test type: Continuous assignment - wk1, sup0 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous449;
wire a,b;
assign (weak1, supply0) #(1,2,3) a=1'b1, b=1'b0;
endmodule
