// Test type: Continuous assignment - st0, wk1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous124;
wire a;
assign (strong0, weak1) #10 a=1'b1;
endmodule
