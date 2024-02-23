// Test type: Continuous assignment - pl1, sup0 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous380;
wire a,b;
assign (pull1, supply0) #10 a=1'b1, b=1'b0;
endmodule
