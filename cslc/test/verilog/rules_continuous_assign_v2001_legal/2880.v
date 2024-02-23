// Test type: Continuous assignment - sup1, pl0 - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous288;
wire a,b,c;
assign (supply1, pull0) a=1'b1, b=1'b0, c=1'd2;
endmodule
