// Test type: initial statement - seq_block - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon33;
reg [7:0]a,b,c;
initial (*b, c*) begin #10 a=2;
end
endmodule
