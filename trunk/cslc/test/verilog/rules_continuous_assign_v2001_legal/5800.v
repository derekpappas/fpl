// Test type: Continuous assignment - st1, h0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous580;
wire a;
assign (strong1, highz0) #(1,2) a=1'b1;
endmodule
