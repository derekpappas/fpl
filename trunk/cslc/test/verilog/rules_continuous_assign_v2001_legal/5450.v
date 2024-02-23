// Test type: Continuous assignment - wk0, h1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous545;
wire a,b;
assign (weak0, highz1) #10 a=1'b1, b=1'b0;
endmodule
