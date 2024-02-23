//-----------------------------------------------------------------------------
// Title         : MIPS Single-Cycle Control Unit
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : control_multi.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Control unit for the MIPS "Multicycle" processor implementation described
//   Section 5.5 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the function specified in Figure 5.38 on p. 339 of COD3e.
//
//-----------------------------------------------------------------------------

module control_multi( clk, reset, Op, PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
                     MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst );
input clk;
input reset;
input [5:0] Op;
output PCWrite;
output PCWriteCond;
output IorD;
output MemRead;
output MemWrite;
output MemtoReg;
output IRWrite;
output [1:0] PCSource;
output [1:0] ALUOp;
output ALUSrcA;
output [1:0] ALUSrcB;
output RegWrite;
output RegDst;

reg PCWrite;
reg PCWriteCond;
reg IorD;
reg MemRead;
reg MemWrite;
reg MemtoReg;
reg IRWrite;
reg [1:0] PCSource;
reg [1:0] ALUOp;
reg ALUSrcA;
reg [1:0] ALUSrcB;
reg RegWrite;
reg RegDst;

// Symbolic constants for Opcodes
    parameter R_FORMAT = 6'd0;
    parameter LW       = 6'd35;
    parameter SW       = 6'd43;
    parameter BEQ      = 6'd4;
    parameter ADDI     = 6'd8;
    parameter J        = 6'd2;


reg [3:0] current_state, next_state;

// State Codes for FSM
parameter S0=4'd0, S1=4'd1, S2=4'd2, S3=4'd3, S4=4'd4,
          S5=4'd5, S6=4'd6, S7=4'D7, S8=4'd8, S9=4'd9, ERROR=4'bxxxx;

// State Register
always @(posedge clk) 
  if (reset) current_state <= S0;
  else current_state <= next_state;


// Next-State & Output Logic
always @(current_state or Op or reset)
begin
  // default values
  PCWrite = 1'b0;
  PCWriteCond = 1'b0;
  IorD     = 1'bx;
  MemRead  = 1'b0;
  MemWrite = 1'b0;
  MemtoReg = 1'bx;
  IRWrite  = 1'b0;
  PCSource = 2'bxx;
  ALUOp    = 2'bxx;
  ALUSrcA  = 1'bx;
  ALUSrcB  = 2'bxx;
  RegWrite = 1'b0;
  RegDst   = 1'bx;
  if (reset) next_state = S0;
  else case (current_state)
    S0: begin
      MemRead = 1'b1;
      ALUSrcA = 1'b0;
      IorD = 1'b0;
      IRWrite = 1'b1;
      ALUSrcB = 2'b01;
      ALUOp = 2'b00;
      PCWrite = 1'b1;
      PCSource = 2'b00;
      next_state = S1;
    end
    S1: begin
      ALUSrcA = 1'b0;
      ALUSrcB = 2'b11;
      ALUOp = 2'b00;
      case (Op)
        LW, SW:    next_state = S2;
        R_FORMAT:  next_state = S6;
        BEQ:       next_state = S8;
        J:         next_state = S9;
        default:   next_state = ERROR;  // Important!
      endcase
    end
    S2: begin
      ALUSrcA = 1'b1;
      ALUSrcB = 2'b10;
      ALUOp = 2'b00;
      case (Op)
        LW:      next_state = S3;
        SW:      next_state = S5;
        default: next_state = ERROR;  // Should never happen!
      endcase
    end
    S3: begin
      MemRead = 1'b1;
      IorD = 1'b1;
      next_state = S4;
    end
    S4: begin
      RegDst = 1'b0;
      RegWrite = 1'b1;
      MemtoReg = 1'b1;
      next_state = S0;
    end
    S5: begin
      MemWrite = 1'b1;
      IorD = 1'b1;
      next_state = S0;
    end
    S6: begin
      ALUSrcA = 1'b1;
      ALUSrcB = 2'b00;
      ALUOp = 2'b10;
      next_state = S7;
    end
    S7: begin
      RegDst = 1'b1;
      RegWrite = 1'b1;
      MemtoReg = 1'b0;
      next_state = S0;
    end
    S8: begin
      ALUSrcA = 1'b1;
      ALUSrcB = 2'b00;
      ALUOp = 2'b01;
      PCWriteCond = 1'b1;
      PCSource = 2'b01;
      next_state = S0;
    end
    S9: begin
      PCWrite = 1'b1;
      PCSource = 2'b10;
      next_state = S0;
    end
    default: next_state = S0;
  endcase
end // always

endmodule


