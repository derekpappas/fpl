// Test type: always statement - seq_block - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon31;
reg [7:0]a;
always begin
#10 a=2;
end
endmodule
