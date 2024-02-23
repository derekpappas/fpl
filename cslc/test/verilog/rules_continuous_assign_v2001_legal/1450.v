// Test type: Continuous assignment - pl0, sup1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous145;
wire a;
assign (pull0, supply1) #(1,2) a=1'b1;
endmodule
