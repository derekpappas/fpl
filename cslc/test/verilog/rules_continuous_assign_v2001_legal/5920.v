// Test type: Continuous assignment - pl1, h0 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous592;
wire a;
assign (pull1, highz0) #(1) a=1'b1;
endmodule
