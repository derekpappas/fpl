// Test type: Continuous assignment - pl1, wk0 - 1 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous428;
wire a,b;
assign (pull1, weak0) #(1) a=1'b1, b=1'b0;
endmodule
