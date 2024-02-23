// Test type: Continuous assignment - h0, st1 - 1 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous639;
wire a,b,c;
assign (highz0, strong1) #(1) a=1'b1, b=1'b0, c=1'd2;
endmodule
