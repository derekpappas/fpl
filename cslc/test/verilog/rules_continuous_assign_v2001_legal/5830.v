// Test type: Continuous assignment - st1, h0 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous583;
wire a;
assign (strong1, highz0) #(1,2,3) a=1'b1;
endmodule
