// Test type: Continuous assignment - st0, h1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous514;
wire a;
assign (strong0, highz1) #10 a=1'b1;
endmodule
