// Test type: Continuous assignment - pl0, pl1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous170;
wire a,b;
assign (pull0, pull1) #10 a=1'b1, b=1'b0;
endmodule
