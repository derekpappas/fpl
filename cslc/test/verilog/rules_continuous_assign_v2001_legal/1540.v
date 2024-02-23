// Test type: Continuous assignment - pl0, st1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous154;
wire a;
assign (pull0, strong1) #10 a=1'b1;
endmodule
