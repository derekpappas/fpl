// Test type: Continuous assignment - pl1, h0 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous599;
wire a,b;
assign (pull1, highz0) #(1,2,3) a=1'b1, b=1'b0;
endmodule