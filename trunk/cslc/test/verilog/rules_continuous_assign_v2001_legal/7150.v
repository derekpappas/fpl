// Test type: Continuous assignment - h1, pl0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous715;
wire a;
assign (highz1, pull0) #(1,2) a=1'b1;
endmodule
