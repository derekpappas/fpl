// Test type: always statement - seq_block - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon32;
reg [7:0]a,b;
always (*b*) begin #10 a=2;
end
endmodule
