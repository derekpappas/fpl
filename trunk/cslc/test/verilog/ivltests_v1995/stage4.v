module stage4(IR5,Z5,WR,BR4,JMP4,ADDR_IN2,D_IN2,CLK,clr,IR4,PC4,Z4,MD4,D_OUT2,c11);

	output [31:0] IR5,Z5,ADDR_IN2,D_IN2;
	output WR,BR4,JMP4;
	input CLK,clr,c11;
	input [31:0] IR4,PC4,Z4,MD4,D_OUT2;
	wire [1:0] mp5;
	wire [31:0] z5in,tmp_din2;


	mux2 #(32,6) seldin2(c11,tmp_din2,MD4,Z5);
	mux4 #(32,6) mymux5(mp5[0],mp5[1],z5in,D_OUT2,Z4,PC4,1);
	d_reg #(32,8) z5reg(CLK,Z5,z5in,clr );
	d_reg #(32,8) ir5reg(CLK,IR5,IR4,clr);
	opdec dec5(IR4[31:27],nop,add,sub,or2,and2,not2,xor2,cmp,br,jmp,ld,ldi,ldx,st,stx,hlt,alu,ldst);

	or(WR,st,stx);
	or(mp5[0],alu,ldi,br);
	assign mp5[1]=jmp;
	assign ADDR_IN2=Z4;
	assign D_IN2=tmp_din2;
	assign BR4=br;
	assign JMP4=jmp;
endmodule