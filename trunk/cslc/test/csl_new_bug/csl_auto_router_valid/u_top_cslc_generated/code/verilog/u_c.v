`include "defines.v"

module u_c(ar_p_t_in_p_a_in,
           ar_p_t_out1_p_a_out);
// Location of source csl unit: file name = ar3b.csl line number = 40
  input [2 - 1:0] ar_p_t_in_p_a_in;
  output [1 - 1:0] ar_p_t_out1_p_a_out;
  u_a a(.p_a_in(ar_p_t_in_p_a_in),
        .p_a_out(ar_p_t_out1_p_a_out));
  u_b b(.p_b_in(ar_p_t_in_p_a_in));
  `include "u_c.logic.v"
endmodule

