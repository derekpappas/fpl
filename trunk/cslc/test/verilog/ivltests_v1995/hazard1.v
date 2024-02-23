module hazard(IR2, IR3, IR4, IR5, COND2, cond_bit, COND4,pause3,pause2,pause1,nop4,nop3,nop2,c5a,c6a,c7,aluxz4sel,aluxpc4sel,aluxz5sel,aluyz4sel, aluypc4sel,aluyz5sel,md4z4sel,md4pc4sel,md4z5sel,c11);

	parameter prop = 3;
	
	input[31:0] IR2, IR3, IR4, IR5;
	input       COND2, cond_bit, COND4;

	output       pause2;
	output	     pause1;
	output       pause3;
	output       nop4;
	output       nop2;
	output       nop3;
	output       c5a, c6a, c7;
	output       aluxz4sel,aluxpc4sel,aluxz5sel,aluyz4sel, aluypc4sel,aluyz5sel,md4z4sel,md4pc4sel,md4z5sel,c11;
/*
	`define rdst5 IR5[26:22]
	`define rdst4 IR4[26:22]
	`define rs12  IR2[21:17]
	`define rs22  IR2[15:11]
	`define rs13  IR3[21:17]
	`define rs23  IR3[15:11]
	`define rs14  IR4[21:17]
	`define rs24  IR4[15:11]
	`define rst2  IR2[26:22]
	`define rst3  IR3[26:22]
	`define rst4  IR4[26:22]

	wire[4:0]  rdst5;
	wire[4:0]  rdst4;
	wire[4:0]  rs12;
	wire[4:0]  rs22;
	wire[4:0]  rs13;
	wire[4:0]  rs23;
	wire[4:0]  rs14;
	wire[4:0]  rs24;
	wire[4:0]  rst2;
	wire[4:0]  rst3;
	wire[4:0]  rst4;
*/
	
        
	// temp wires
	wire imm3b, imm2b, jmpl3, jmpl4, jmpl5, aluh3, aluh3b, pause1, nop4;	

	// Wires for pause2
	wire orld4ldx4,andeq2imm3b,orrdst4up1eq1,andup1alu3,andeq1ldx3,andeq1stx3,andeq1jmpl3,andaluh3,tmppause2,pause2,tmp3pause;

	// wires for pause3
	wire tmppause3, pause3;

	// wires for nop2 nop3
	wire br2tnoh, br3t, br4t,nop2,nop3 ;

// module opcode decoder
opdec IR2dec (IR2[31:27],noop2,add2,sub2,or2,and2,not2,xor2,cmp2,br2,jmp2,ld2,ldi2,ldx2,st2,stx2,hlt2,alu2,ldst2);
opdec IR3dec (IR3[31:27],noop3,add3,sub3,or3,and3,not3,xor3,cmp3,br3,jmp3,ld3,ldi3,ldx3,st3,stx3,hlt3,alu3,ldst3);
opdec IR4dec (IR4[31:27],noop4,add4,sub4,or4,and4,not4,xor4,cmp4,br4,jmp4,ld4,ldi4,ldx4,st4,stx4,hlt4,alutmp4,ldst4);
opdec IR5dec (IR5[31:27],noop5,add5,sub5,or5,and5,not5,xor5,cmp5,br5,jmp5,ld5,ldi5,ldx5,st5,stx5,hlt5,alutmp5,ldst5);

// modifying alu4 and alu5 to not send compare instruction's rdst value
wire alu4,alu5,cmp5b,cmp4b;
not #(prop) (cmp4b,cmp4);
not #(prop) (cmp5b,cmp5);
and #(prop) (alu4,alutmp4,cmp4b);
and #(prop) (alu5,alutmp5,cmp5b);

// comparator instantiation
// inputs are a,b output out
comp eq1(IR4[26:22],IR3[21:17],rdst4rs13);
comp eq2(IR4[26:22],IR3[15:11],rdst4rs23);
comp eq3(IR5[26:22],IR2[21:17],rdst5rs12);
comp eq4(IR5[26:22],IR2[15:11],rdst5rs22);
comp eq5(IR5[26:22],IR2[26:22],rdst5rst2);
comp eq6(IR5[26:22],IR3[21:17],rdst5r13);
comp eq7(IR5[26:22],IR3[15:11],rdst5r23);
comp eq8(IR5[26:22],IR3[26:22],rdst5rt3);
comp eq9(IR4[26:22],IR3[26:22],rdst4rt3);
comp eq10(IR5[26:22],IR4[26:22],rdst5rt4);

// jmpl3,4,5
and #(prop) (jmpl2, jmp2, IR2[16]);
and #(prop) (jmpl3, jmp3, IR3[16]);
and #(prop) (jmpl4, jmp4, IR4[16]);
and #(prop) (jmpl5, jmp5, IR5[16]);

// wires needed below
wire ir216b, ir316b, ir416b, ir516b;

// jmp2,3,4
not #(prop) (ir216b, IR2[16]);
not #(prop) (ir316b, IR3[16]);
not #(prop) (ir416b, IR4[16]);
not #(prop) (ir516b, IR5[16]);
and #(prop) (jmp_2, jmp2, ir216b);
and #(prop) (jmp_3, jmp3, ir316b);
and #(prop) (jmp_4, jmp4, ir416b);
and #(prop) (jmp_5, jmp5, ir516b);


// alu hazard 3
or #(prop) (aluh3, add3, sub3, cmp3);

// LOGIC FOR IMM3bar
not #(prop) (imm3b, IR3[16]);

// LOGIC FOR IMM2bar
not #(prop) (imm2b, IR2[16]);


// LOGIC FOR PAUSE2
or #(prop) (orld4ldx4, ld4, ldx4);
and #(prop) (andeq2imm3b, rdst4rs23, imm3b);
or #(prop) (orrdst4up1eq1, andeq2imm3b, rdst4rs13);
and #(prop) (andup1alu3, alu3, orrdst4up1eq1);
and #(prop) (andeq1ldx3, rdst4rs13, ldx3);
and #(prop) (andeq1stx3, rdst4rs13, stx3);
and #(prop) (andeq1jmpl3, rdst4rs13, jmpl3);
and #(prop) (andaluh3, aluh3, br2);
or #(prop) (tmppause2, andup1alu3, andeq1ldx3, andeq1stx3, andeq1jmpl3);
and #(prop) (tmp3pause, tmppause2, orld4ldx4);

// Data forwarding corner case -- > When a instruction is in the 3rd stage
// which is dependent on both instruction in the 4th stage and instruction
// in the 5th  stage and whose destination registers will be available when
// each one of them reaches the 5th stage respectively.
// We need to insert a NOP since we have to consume the forwarded data in
// same cycle. 

comp eq11(IR3[26:22],IR2[21:17],rdst3rs12);
comp eq12(IR4[26:22],IR2[15:11],rdst4rs22);
comp eq13(IR4[26:22],IR2[21:17],rdst4rs12);
comp eq14(IR3[26:22],IR2[15:11],rdst3rs22);

// wires needed below
wire rdst3rs12andrdst4rs22;
wire rdst3rs22andrdst4rs12;
wire tmp_corner, ldh3, ldh4, add_pause2, without_corner; 

and #(prop) (rdst3rs12andrdst4rs22, rdst3rs12, rdst4rs22);
and #(prop) (rdst3rs22andrdst4rs12, rdst3rs22, rdst4rs12);
or #(prop) (tmp_corner, rdst3rs12andrdst4rs22, rdst3rs22andrdst4rs12);

or #(prop) (ldh3, ld3, ldx3, ldi3);
or #(prop) (ldh4, ld4, ldx4, ldi4);
and #(prop) (add_pause2, alu2, ldh3, ldh4, tmp_corner);
or #(prop) (without_corner,tmp3pause,andaluh3);
or #(prop) (pause2, without_corner, add_pause2);

// LOGIC FOR PAUSE1
assign pause1 = pause2;

// LOGIC FOR PAUSE3
or #(prop) (tmppause3, andup1alu3, andeq1ldx3, andeq1stx3, andeq1jmpl3);
and #(prop) (pause3, tmppause3, orld4ldx4);

assign nop4 = pause3; 

// LOGIC FOR NOP2

not #(prop) (aluh3b, aluh3);
and #(prop) (br2tnoh,aluh3b,COND2);
and #(prop) (br3t, br3, cond_bit);
and #(prop) (br4t, br4, COND4);
or #(prop) (nop2, jmp2, jmp3, jmp4, br2tnoh, br3t, br4t,hlt2,hlt3,hlt4,hlt5);

//LOGIC FOR NOP3
wire tmp_nop3;
or #(prop) (tmp_nop3, andaluh3, add_pause2);
assign  nop3 = tmp_nop3;


// wires for C5A
wire c5acomm,andalu2,andldx2,andstx2,c5a;

//LOGIC FOR C5A

or #(prop) (c5acomm , alu5, ld5, ldx5, ldi5, jmpl5);
and #(prop) (andalu2,rdst5rs12,alu2,c5acomm);
and #(prop) (andldx2,rdst5rs12,ldx2,c5acomm);
and #(prop) (andstx2, rdst5rs12,stx2,c5acomm);
or #(prop) (c5a,andalu2,andldx2,andstx2);

//wires for c6a
wire tmpc6a, c6a;

//LOGIC FOR C6A


and #(prop) (tmpc6a,rdst5rs22, alu2, imm2b);
and #(prop) (c6a,tmpc6a,c5acomm);

//WIRES FOR C7A
wire st2_stx2,c7;

// LOGIC FOR C7A
or #(prop) (st2_stx2,st2,stx2);
and #(prop) (c7,rdst5rst2,c5acomm,st2_stx2);


//LOGIC FOR ALUXZ4SEL
//wires 
wire alu4_ldi4,tmpxz41,tmpxz42,tmpxz43,tmpxz44, aluxz4sel;

or #(prop) (alu4_ldi4,alu4,ldi4);
and #(prop) (tmpxz41,rdst4rs13,alu3,alu4_ldi4);
and #(prop) (tmpxz42,rdst4rs13,ldx3,alu4_ldi4);
and #(prop) (tmpxz43,rdst4rs13,stx3,alu4_ldi4);
and #(prop) (tmpxz44,rdst4rs13,jmp3,alu4_ldi4);
or #(prop) (aluxz4sel,tmpxz41,tmpxz42,tmpxz43,tmpxz44);

//LOGIC FOR ALUXPC4SEL
//wires 
wire tmpxpc41,aluxpc4sel;

or #(prop) (tmpxpc41,alu3,ldx3,stx3,jmp3);
and #(prop) (aluxpc4sel,rdst4rs13,jmpl4,tmpxpc41);

// LOGIC FOR ALUXZ5SEL
//wires
wire tmpxz51,tmpxz52,tmpxz53,tmpxz54,aluxz5sel;

and #(prop) (tmpxz51,rdst5r13,alu3,c5acomm);
and #(prop) (tmpxz52,rdst5r13,ldx3,c5acomm);
and #(prop) (tmpxz53,rdst5r13,stx3,c5acomm);
and #(prop) (tmpxz54,rdst5r13,jmp3,c5acomm);
or #(prop) (aluxz5sel,tmpxz51,tmpxz52,tmpxz53,tmpxz54);

//LOGIC FOR ALUYZ4SEL
wire aluyz4sel;

and #(prop) (aluyz4sel,alu3,rdst4rs23, imm3b, alu4_ldi4);


//LOGIC FOR ALUYPC4SEL
wire aluypc4sel;

and #(prop) (aluypc4sel,alu3,rdst4rs23, imm3b, jmpl4);


//LOGIC FOR ALUYZ5SEL
wire aluyz5sel;

and #(prop) (aluyz5sel,alu3,rdst5r23, imm3b, c5acomm);

//LOGIC FOR MD4Z4SEl
wire md4z4sel,st3_stx3;

or #(prop) (st3_stx3,st3,stx3);
and #(prop) (md4z4sel,alu4_ldi4,rdst4rt3,st3_stx3);

//LOGIC FOR MD4PC4SEl
wire md4pc4sel;

and #(prop) (md4pc4sel,jmpl4,rdst4rt3,st3_stx3);

//LOGIC FOR MD4Z5SEl
wire md4z5sel;

and #(prop) (md4z5sel,c5acomm,rdst5rt3,st3_stx3);


//LOGIC FOR c11
wire c11,ld5_ldx5,st4_stx4;

or #(prop) (ld5_ldx5,ld5,ldx5);
or #(prop) (st4_stx4,stx4,st4);
and #(prop) (c11,rdst5rt4,ld5_ldx5,st4_stx4);

endmodule







