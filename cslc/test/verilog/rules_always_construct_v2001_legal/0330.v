// Test type: always statement - seq_block - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon33;
reg [7:0]a,b,c;
always (*b, c*) begin #10 a=2;
end
endmodule
