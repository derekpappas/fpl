// Test type: Continuous assignment - h1, st0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous694;
wire a;
assign (highz1, strong0) #10 a=1'b1;
endmodule
