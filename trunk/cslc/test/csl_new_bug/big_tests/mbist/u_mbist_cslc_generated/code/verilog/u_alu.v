`include "defines.v"

module u_alu(p_op1,
             p_op2,
             p_opsel,
             p_cin,
             p_res,
             p_cout);
// Location of source csl unit: file name = mbist_datapath.csl line number = 160
  input [15:0] p_op1;
  input [15:0] p_op2;
  input [2:0] p_opsel;
  input p_cin;
  output [15:0] p_res;
  output p_cout;
  `include "mbist_datapath.csl" 
  endmodule

