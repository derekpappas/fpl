`include "defines.v"

module r_caddr(p_clock,
               p_reset,
               p_enable,
               p_direction,
               p_br_addr,
               p_sel,
               p_addr_out);
// Location of source csl unit: file name = mbist_datapath.csl line number = 62
  input p_clock;
  input p_reset;
  input p_enable;
  input p_direction;
  input [15:0] p_br_addr;
  input p_sel;
  output [15:0] p_addr_out;
  `include "mbist_datapath.csl" 
  endmodule

