// Test type: Continuous assignment - st0, h1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous520;
wire a;
assign (strong0, highz1) #(1,2) a=1'b1;
endmodule
