// Test type: nonblocking_assignment - delay control - expression
// Vparser rule name:
// Author: andreib
module nonblocking_assignment2;
reg a;
initial a<=#10 2;
endmodule
