// Test type: Continuous assignment - st1, wk0 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous365;
wire a,b;
assign (strong1, weak0) #10 a=1'b1, b=1'b0;
endmodule
