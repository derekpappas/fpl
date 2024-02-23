// Test type: Continuous assignment - st1, h0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous574;
wire a;
assign (strong1, highz0) #10 a=1'b1;
endmodule
