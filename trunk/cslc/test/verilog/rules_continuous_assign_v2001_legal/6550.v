// Test type: Continuous assignment - h0, pl1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous655;
wire a;
assign (highz0, pull1) #(1,2) a=1'b1;
endmodule
