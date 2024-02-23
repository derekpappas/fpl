// Test type: Continuous assignment - st1, h0 - 3 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous585;
wire a,b,c;
assign (strong1, highz0) #(1,2,3) a=1'b1, b=1'b0, c=1'd2;
endmodule
