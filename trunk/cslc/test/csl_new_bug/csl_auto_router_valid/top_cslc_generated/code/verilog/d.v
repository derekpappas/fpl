`include "defines.v"

module d(ar_clk_ck,
         ar_rst_reset,
         ar_p_out1_p_out,
         ar_p_in1_p_in,
         ifc_top_ifc_p1_in,
         ifc_top_ifc_p2_out,
         ifc_top_p_sg);
// Location of source csl unit: file name = c_test2.csl line number = 32
  input [1 - 1:0] ar_clk_ck;
  input [1 - 1:0] ar_rst_reset;
  input [8 - 1:0] ar_p_in1_p_in;
  input [8 - 1:0] ifc_top_ifc_p1_in;
  input [8 - 1:0] ifc_top_p_sg;
  output [8 - 1:0] ar_p_out1_p_out;
  output [8 - 1:0] ifc_top_ifc_p2_out;
  c c0(.ck(ar_clk_ck),
       .ifc1_ifc_p1_in(ifc_top_ifc_p1_in),
       .ifc1_ifc_p2_out(ifc_top_ifc_p2_out),
       .ifc1_p_sg(ifc_top_p_sg),
       .p_in(ar_p_in1_p_in),
       .p_out(ar_p_out1_p_out),
       .reset(ar_rst_reset));
  `include "d.logic.v"
endmodule

