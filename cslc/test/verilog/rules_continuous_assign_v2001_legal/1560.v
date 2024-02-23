// Test type: Continuous assignment - pl0, st1 - delay - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous156;
wire a,b,c;
assign (pull0, strong1) #10 a=1'b1, b=1'b0, c=1'd2;
endmodule
