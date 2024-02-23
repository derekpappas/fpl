// Test type: seq_block - begin - block.id (ASCII) - more block items declaration - end
// Vparser rule name:
// Author: andreib
module seq_block8;
initial begin:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a,b;
	integer c;
	real d,e;
	end
endmodule
