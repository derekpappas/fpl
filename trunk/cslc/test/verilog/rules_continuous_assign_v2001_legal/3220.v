// Test type: Continuous assignment - st1, sup0 - 1 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous322;
wire a;
assign (strong1, supply0) #(1) a=1'b1;
endmodule
