// Test type: Continuous assignment - st0, wk1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous130;
wire a;
assign (strong0, weak1) #(1,2) a=1'b1;
endmodule
