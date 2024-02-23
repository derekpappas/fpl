// Test type: Continuous assignment - pl0, h1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous529;
wire a;
assign (pull0, highz1) #10 a=1'b1;
endmodule
