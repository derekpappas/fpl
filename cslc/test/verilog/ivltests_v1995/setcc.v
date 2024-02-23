module setcc(op1,op2,result,add,sub,cmp,c,z,n,v);
	
	parameter width = 32;
	input [width-1:0] op1;
	input [width-1:0] op2;
	input [width:0] result;
	input add,sub,cmp;
	output c;
	output z;
	output n;
	output v;
        
        wire c,z,n,v;
	wire subt;
	or #(3) subt_or(subt,sub,cmp);
    	assign 	c =  result[width];
	assign	#6 z = ~(|result[width-1:0]);
	assign	#12 v =  (result[width-1] & ~op1[width-1] & ~(subt^op2[width-1])) | (~result[width-1] & op1[width-1] & (subt^op2[width-1]));
	assign	n =   result[width-1];
           
endmodule
 