// Test type: Continuous assignment - pl0, sup1 - 2 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous147;
wire a,b,c;
assign (pull0, supply1) #(1,2) a=1'b1, b=1'b0, c=1'd2;
endmodule
