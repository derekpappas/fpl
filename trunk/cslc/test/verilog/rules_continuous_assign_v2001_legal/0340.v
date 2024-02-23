// Test type: Continuous assignment - sup0, st1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous34;
wire a;
assign (supply0, strong1) #10 a=1'b1;
endmodule
