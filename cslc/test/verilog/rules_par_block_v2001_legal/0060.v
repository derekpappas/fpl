// Test type: par_block - fork - block.id (ASCII) - more statements - join
// Vparser rule name:
// Author: andreib
module par_block6;
reg a,b,c,d;
initial fork:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_$
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
