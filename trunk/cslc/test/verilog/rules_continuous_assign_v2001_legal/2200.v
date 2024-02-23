// Test type: Continuous assignment - wk0, st1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous220;
wire a;
assign (weak0, strong1) #(1,2) a=1'b1;
endmodule
