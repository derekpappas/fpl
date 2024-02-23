//-----------------------------------------------------------------------------
// Title         : MIPS Single-Cycle Processor
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : mips_multi.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   "Multicycle" implementation of the MIPS processor subset described in
//   Section 5.5  of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the equivalent of Figure 5.28 on page 323 of COD3e
//
//-----------------------------------------------------------------------------

module mips_multi(clk, reset);
    input clk, reset;

    // instruction bus
    wire [31:0] instr;

    // break out important fields from instruction
    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
    wire [25:0] j_offset;
    wire [31:0] j_addr;

    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign shamt = instr[10:6];
    assign funct = instr[5:0];
    assign immed = instr[15:0];
    assign j_offset = instr[25:0];

    // sign-extender
    assign extend_immed = { {16{immed[15]}}, immed };
    
    // branch offset shifter
    assign b_offset = extend_immed << 2;


    // datapath signals
    wire [4:0] rfile_wn;

    wire [31:0] pc, pc_next, mem_addr, mem_rd, mdr, rfile_wd, 
                rfile_rd1, rfile_rd2, a, b, alu_a, alu_b, aluout_in, aluout;

    // jump address
    assign j_addr = { pc[31:28], j_offset, 2'b0 };
    
    // control signals

    wire PCWriteEnable, PCWriteBr, PCWrite, PCWriteCond, Zero, IRWrite, IorD, 
         MemRead, MemWrite, MemtoReg, RegWrite, RegDst, ALUSrcA;

    wire [1:0] ALUOp, ALUSrcB, PCSource;
    wire [2:0] Operation;

    // module instantiations

    reg32en		PC(clk, reset, PCWriteEnable, pc_next, pc);

    mux2             MEM_MUX(IorD, pc, aluout, mem_addr);

    mem32            MEM(clk, MemRead, MemWrite, mem_addr, b, mem_rd);

    reg32en          IR(clk, reset, IRWrite, mem_rd, instr);

    reg32            MDR(clk, reset, mem_rd, mdr);

    reg_file	       RFILE(clk, RegWrite, rs, rt, rfile_wn, rfile_rd1, rfile_rd2, rfile_wd); 

    mux2             RFMUX(MemtoReg, aluout, mdr, rfile_wd);

    mux2 #(5)        RFWNMUX(RegDst, rt, rd, rfile_wn);

    reg32            A(clk, reset, rfile_rd1, a);

    reg32            B(clk, reset, rfile_rd2, b);

    mux2             ALUMUXA(ALUSrcA, pc, a, alu_a);

    mux4             ALUMUXB(ALUSrcB, b, 32'd4, extend_immed, b_offset, alu_b);

    alu              ALU(Operation, alu_a, alu_b, aluout_in, Zero);

    reg32            ALUOUT(clk, reset, aluout_in, aluout);

    mux3             PCMUX(PCSource, aluout_in, aluout, j_addr, pc_next);

    and              BR_AND(PCWriteBr, PCWriteCond, Zero);

    or               PC_OR(PCWriteEnable, PCWriteBr, PCWrite);

    control_multi   CTL(.clk(clk), .reset(reset), .Op(opcode), .PCWrite(PCWrite), 
                        .PCWriteCond(PCWriteCond), .IorD(IorD), .MemRead(MemRead),
                        .MemWrite(MemWrite), .MemtoReg(MemtoReg), .IRWrite(IRWrite),
                        .PCSource(PCSource), .ALUOp(ALUOp), .ALUSrcB(ALUSrcB), .ALUSrcA(ALUSrcA),
                        .RegWrite(RegWrite), .RegDst(RegDst));

    alu_ctl          ALUCTL(ALUOp, funct, Operation);
endmodule
