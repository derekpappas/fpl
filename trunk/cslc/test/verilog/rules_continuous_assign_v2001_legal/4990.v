// Test type: Continuous assignment - sup0, h1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous499;
wire a;
assign (supply0, highz1) #10 a=1'b1;
endmodule
