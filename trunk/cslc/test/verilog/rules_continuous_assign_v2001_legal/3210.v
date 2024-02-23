// Test type: Continuous assignment - st1, sup0 - delay - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous321;
wire a,b,c;
assign (strong1, supply0) #10 a=1'b1, b=1'b0, c=1'd2;
endmodule
