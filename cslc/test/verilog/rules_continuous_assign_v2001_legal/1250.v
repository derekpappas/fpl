// Test type: Continuous assignment - st0, wk1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous125;
wire a,b;
assign (strong0, weak1) #10 a=1'b1, b=1'b0;
endmodule
