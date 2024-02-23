// Test type: Continuous assignment - wk0, wk1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous247;
wire a;
assign (weak0, weak1) #(1) a=1'b1;
endmodule
