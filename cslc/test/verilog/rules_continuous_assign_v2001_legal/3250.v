// Test type: Continuous assignment - st1, sup0 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous325;
wire a;
assign (strong1, supply0) #(1,2) a=1'b1;
endmodule
