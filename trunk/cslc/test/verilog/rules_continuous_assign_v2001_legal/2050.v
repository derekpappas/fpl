// Test type: Continuous assignment - wk0, sup1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous205;
wire a;
assign (weak0, supply1) #(1,2) a=1'b1;
endmodule
