// Test type: Continuous assignment - sup1, st0 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous275;
wire a,b;
assign (supply1, strong0) #10 a=1'b1, b=1'b0;
endmodule
