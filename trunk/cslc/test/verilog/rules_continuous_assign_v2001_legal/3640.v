// Test type: Continuous assignment - st1, wk0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous364;
wire a;
assign (strong1, weak0) #10 a=1'b1;
endmodule
