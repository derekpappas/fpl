module testbench_opdec;

// This is the top most file. The opdec module will be instantiated within
// this file. The input vectors will be read from a formatted text file and
// outputs from the opcode decoder will be verified with reference outputs.


wire [4:0] opcode;
wire nop1,add1,sub1,and1,or1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,hlt1; 

// Instantiate the design under verification
dcd5_32 opdec(opcode,nop1,add1,sub1,or1,and1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,hlt1);

// This file drives the inputs of the DUV
data_generator datagen(opcode,clk);
// rnd_data_generator datagen(opcode,clk);

 
// This module acts as an checker comparing DUV o/p with predicted output
checker check(opcode,nop1,add1,sub1,or1,and1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,hlt1);

// Instantiate Oscillator
oscillator osc(clk,clk_n);

endmodule