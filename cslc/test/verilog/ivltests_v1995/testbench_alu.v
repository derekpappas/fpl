module testbench_alu;

// This is the top most file. The alu module will be instantiated within
// this file. The input vectors will be read from a formatted text file and
// outputs from the alu will be verified with reference outputs.

parameter width = 32;

wire [4:0] opcode;
wire [width-1:0] alu_x,alu_y;
wire [width:0] result;
wire nop1,add1,sub1,and1,or1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,hlt1; 

// Instantiate the Design Under Verification (DUV)
alu myalu(result,alu_x,alu_y,add1,sub1,and1,or1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,);

// The opcode decoder will drive some inputs of the DUV
dcd5_32 opdec(opcode,nop1,add1,sub1,or1,and1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,hlt1);

// This file drives the inputs of the DUV
data_generator datagen(opcode,alu_x,alu_y,clk);
// rnd_data_generator datagen(opcode,alu_x,alu_y,clk);

// This module acts as an checker comparing DUV o/p with predicted output
checker check(result,alu_x,alu_y,nop1,add1,sub1,or1,and1,not1,xor1,cmp1,br1,jmp1,ld1,ldi1,ldx1,st1,stx1,hlt1);

// Instantiate Oscillator
oscillator osc(clk,clk_n);

endmodule