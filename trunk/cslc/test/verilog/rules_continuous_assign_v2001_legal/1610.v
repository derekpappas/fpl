// Test type: Continuous assignment - pl0, st1 - 2 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous161;
wire a,b;
assign (pull0, strong1) #(1,2) a=1'b1, b=1'b0;
endmodule
