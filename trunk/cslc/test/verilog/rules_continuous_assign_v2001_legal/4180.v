// Test type: Continuous assignment - pl1, pl0 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous418;
wire a;
assign (pull1, pull0) #(1,2,3) a=1'b1;
endmodule