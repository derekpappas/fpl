// Test type: initial statement - seq_block - no attribute instance
// Vparser rule name:
// Author: andreib
module initcon31;
reg [7:0]a;
initial begin
#10 a=2;
end
endmodule
