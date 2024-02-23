// Test type: par_block - fork - block.id (ASCII) - block item declaration - more statements - join
// Vparser rule name:
// Author: andreib
module par_block10;
initial fork:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
	reg a,b,c,d;	
	a=1'b1;
	case(a)
	    0:b=1;
	    1:b=0;
	endcase
	fork:sub_fork
		c=8'hA2;
		d=6'o12;
	join
	join
endmodule
