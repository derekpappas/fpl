// Test type: Continuous assignment - wk0, pl1 - 3 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous238;
wire a;
assign (weak0, pull1) #(1,2,3) a=1'b1;
endmodule
