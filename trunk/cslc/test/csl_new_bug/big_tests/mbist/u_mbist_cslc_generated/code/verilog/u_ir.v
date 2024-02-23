`include "defines.v"

module u_ir(p_clock,
            p_i,
            p_opcode,
            p_rdst,
            p_op1,
            p_op2,
            p_c,
            p_braddr,
            p_sha,
            p_const8,
            p_romaddr,
            p_d);
// Location of source csl unit: file name = mbist_datapath.csl line number = 132
  input p_clock;
  input [15:0] p_i;
  output [4:0] p_opcode;
  output [3:0] p_rdst;
  output [3:0] p_op1;
  output [3:0] p_op2;
  output p_c;
  output [11 - 1:0] p_braddr;
  output [4 - 1:0] p_sha;
  output [7:0] p_const8;
  output [7:0] p_romaddr;
  output p_d;
  `include "mbist_datapath.csl" 
  endmodule

