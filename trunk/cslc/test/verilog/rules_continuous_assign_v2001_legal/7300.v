// Test type: Continuous assignment - h1, wk0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous730;
wire a;
assign (highz1, weak0) #(1,2) a=1'b1;
endmodule
