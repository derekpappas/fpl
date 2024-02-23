// Test type: Continuous assignment - sup0, pl1 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous58;
wire a;
assign (supply0, pull1) #(1,2,3) a=1'b1;
endmodule
