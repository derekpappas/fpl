// Test type: seq_block - begin - more statements - end
// Vparser rule name:
// Author: andreib
module seq_block4;
reg a,b,c,d;
initial begin
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
