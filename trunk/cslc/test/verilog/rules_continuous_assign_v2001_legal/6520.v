// Test type: Continuous assignment - h0, pl1 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous652;
wire a;
assign (highz0, pull1) #(1) a=1'b1;
endmodule
