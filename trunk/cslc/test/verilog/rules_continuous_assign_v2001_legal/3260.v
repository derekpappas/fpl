// Test type: Continuous assignment - st1, sup0 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous326;
wire a,b;
assign (strong1, supply0) #(1,2) a=1'b1, b=1'b0;
endmodule