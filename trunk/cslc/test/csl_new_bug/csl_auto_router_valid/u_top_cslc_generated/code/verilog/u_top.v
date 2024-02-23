`include "defines.v"

module u_top(p_t_in,
             p_t_out0,
             p_t_out1);
// Location of source csl unit: file name = ar3b.csl line number = 57
  input [2 - 1:0] p_t_in;
  output p_t_out0;
  output p_t_out1;
  u_c c(.ar_p_t_in_p_a_in(p_t_in),
        .ar_p_t_out1_p_a_out(p_t_out1));
  u_d d(.p_d_in1(p_t_in),
        .p_d_out(p_t_out0));
  `include "u_top.logic.v"
endmodule

