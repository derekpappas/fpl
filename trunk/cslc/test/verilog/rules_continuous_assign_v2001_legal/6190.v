// Test type: Continuous assignment - h0, sup1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous619;
wire a;
assign (highz0, supply1) #10 a=1'b1;
endmodule
