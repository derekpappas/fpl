// Test type: Continuous assignment - st1, pl0 - 2 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous357;
wire a,b,c;
assign (strong1, pull0) #(1,2) a=1'b1, b=1'b0, c=1'd2;
endmodule