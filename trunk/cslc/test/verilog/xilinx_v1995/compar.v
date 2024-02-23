module compar(A, B, cmp); 
input [7:0] A; 
input [7:0] B; 
output cmp; 
assign cmp = A >= B ? 1'b1 : 1'b0; 
endmodule