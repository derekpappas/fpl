// Test type: Continuous assignment - h0, wk1 - 3 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous675;
wire a,b,c;
assign (highz0, weak1) #(1,2,3) a=1'b1, b=1'b0, c=1'd2;
endmodule
