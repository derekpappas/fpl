// Test type: seq_block - begin - block.id (ASCII) -  1 statement - end
// Vparser rule name:
// Author: andreib
module seq_block5;
reg a;
initial begin:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	a=1'b1;
	end
endmodule
