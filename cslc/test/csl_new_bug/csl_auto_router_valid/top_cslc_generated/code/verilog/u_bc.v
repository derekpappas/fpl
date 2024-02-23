`include "defines.v"

module u_bc(ck,
            reset,
            p_bc_in,
            p_bc_out,
            ar_p_a_out_p_b_in,
            ar_p_c_out_p_d_in);
// Location of source csl unit: file name = c_test1.csl line number = 29
  input ck;
  input reset;
  input [8 - 1:0] p_bc_in;
  input [8 - 1:0] ar_p_a_out_p_b_in;
  output [8 - 1:0] p_bc_out;
  output [8 - 1:0] ar_p_c_out_p_d_in;
  wire [8 - 1:0] ar_p_b_out_p_c_in;
  u_b b(.ck(ck),
        .p_b_in(ar_p_a_out_p_b_in),
        .p_b_out(ar_p_b_out_p_c_in),
        .reset(reset));
  u_c c(.ck(ck),
        .p_c_in(ar_p_b_out_p_c_in),
        .p_c_out(ar_p_c_out_p_d_in),
        .reset(reset));
  `include "u_bc.logic.v"
endmodule

