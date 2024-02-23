// Test type: initial statement - blocking_assignment - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon3;
reg [7:0]a,b,c;
initial (*b, c*)a=2;
endmodule
