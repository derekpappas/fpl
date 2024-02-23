// Test type: Continuous assignment - sup0, sup1 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous28;
wire a;
assign (supply0, supply1) #(1,2,3) a=1'b1;
endmodule
