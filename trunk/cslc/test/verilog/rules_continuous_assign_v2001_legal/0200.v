// Test type: Continuous assignment - sup0, sup1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous20;
wire a,b;
assign (supply0, supply1) #10 a=1'b1, b=1'b0;
endmodule
