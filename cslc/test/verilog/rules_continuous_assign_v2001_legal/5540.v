// Test type: Continuous assignment - wk0, h1 - 3 mintypmax - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous554;
wire a,b;
assign (weak0, highz1) #(1,2,3) a=1'b1, b=1'b0;
endmodule
