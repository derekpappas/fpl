// Test type: Continuous assignment - pl1, wk0 - 2 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous432;
wire a,b,c;
assign (pull1, weak0) #(1,2) a=1'b1, b=1'b0, c=1'd2;
endmodule
