
module opdec(opcode,nop,add,sub,or2,and2,not2,xor2,cmp,br,jmp,ld,ldi,ldx,st,stx,hlt,alu,ldst);

// PORT DECLARATIONS
	output nop,add,sub,or2,and2,not2,xor2,cmp,br,jmp,ld,ldi,ldx,st,stx,hlt,alu,ldst;
	input [4:0] opcode;

// Instantiate the opdec.v module
// has a delay of 6 inside the module (not a parameter)
dcd5_32 opcodedec(opcode,nop,add,sub,or2,and2,not2,xor2,cmp,br,jmp,ld,ldi,ldx,st,stx,hlt);


	// Logic to generate alu and ldst signal
	or #(3) g1(alu,add,sub,or2,and2,not2,xor2,cmp);
	or #(3) g2(ldst,ld,ldi,ldx,st,stx);


endmodule