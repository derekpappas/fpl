// Test type: Continuous assignment - h0, st1 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous635;
wire a,b;
assign (highz0, strong1) #10 a=1'b1, b=1'b0;
endmodule
