// Test type: seq_block - begin - block.id (ASCII) - block item declaration - more statements - end
// Vparser rule name:
// Author: andreib
module seq_block10;
initial begin:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a,b,c,d;	
	a=1'b1;
	case(a)
	    0:b=1;
	    1:b=0;
	endcase
	begin:sub_begin
		c=8'hA2;
		d=6'o12;
	end
	end
endmodule
