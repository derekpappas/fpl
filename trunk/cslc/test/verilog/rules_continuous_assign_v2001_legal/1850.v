// Test type: Continuous assignment - pl0, wk1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous185;
wire a,b;
assign (pull0, weak1) #10 a=1'b1, b=1'b0;
endmodule
