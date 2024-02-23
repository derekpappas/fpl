// Test type: Continuous assignment - wk0, pl1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous235;
wire a;
assign (weak0, pull1) #(1,2) a=1'b1;
endmodule
