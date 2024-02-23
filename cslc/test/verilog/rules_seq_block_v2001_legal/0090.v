// Test type: seq_block - begin - block.id (ASCII) - block item declaration -  1 statement - end
// Vparser rule name:
// Author: andreib
module seq_block9;

initial begin:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a;
	a=1'b1;
	end
endmodule
