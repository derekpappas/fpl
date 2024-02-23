// Test type: Continuous assignment - h0, sup1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous620;
wire a,b;
assign (highz0, supply1) #10 a=1'b1, b=1'b0;
endmodule
