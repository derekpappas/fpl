// Test type: Continuous assignment - wk0, pl1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous232;
wire a;
assign (weak0, pull1) #(1) a=1'b1;
endmodule
