// Test type: Continuous assignment - st1, sup0 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous319;
wire a;
assign (strong1, supply0) #10 a=1'b1;
endmodule
