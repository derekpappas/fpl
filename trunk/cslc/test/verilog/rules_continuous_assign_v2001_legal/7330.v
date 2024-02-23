// Test type: Continuous assignment - h1, wk0 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous733;
wire a;
assign (highz1, weak0) #(1,2,3) a=1'b1;
endmodule
