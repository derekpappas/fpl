// Test type: Continuous assignment - h0, pl1 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous658;
wire a;
assign (highz0, pull1) #(1,2,3) a=1'b1;
endmodule
