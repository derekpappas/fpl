// Test type: Continuous assignment - st1, st0 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous335;
wire a,b;
assign (strong1, strong0) #10 a=1'b1, b=1'b0;
endmodule
