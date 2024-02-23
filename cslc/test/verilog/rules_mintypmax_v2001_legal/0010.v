// Test type: Constant Expression - primary - genvar
// Vparser rule name:
// Author: andreib
module constantexpression;
wire a;
genvar i;
generate
for (i=0; i<4; i=i+1)
  begin: ASSIGN
  assign a = 1'b1;
  end
endgenerate
endmodule
