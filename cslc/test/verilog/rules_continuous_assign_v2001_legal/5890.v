// Test type: Continuous assignment - pl1, h0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous589;
wire a;
assign (pull1, highz0) #10 a=1'b1;
endmodule
