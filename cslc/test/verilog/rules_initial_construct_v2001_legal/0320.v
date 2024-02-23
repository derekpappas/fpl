// Test type: initial statement - seq_block - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon32;
reg [7:0]a,b;
initial (*b*) begin #10 a=2;
end
endmodule
