// Test type: Continuous assignment - sup1, h0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous559;
wire a;
assign (supply1, highz0) #10 a=1'b1;
endmodule
