`include "defines.v"

module u_control(s_status,
                 op_instr,
                 r_instr,
                 wr_haddr,
                 wr_crtaddr,
                 wr_ram,
                 rd_ram,
                 rd_im,
                 rd_rom,
                 incr,
                 decr,
                 wr_dm,
                 rd_dm);
// Location of source csl unit: file name = mbist_datapath.csl line number = 195
  input [8 - 1:0] s_status;
  output op_instr;
  output r_instr;
  output wr_haddr;
  output wr_crtaddr;
  output wr_ram;
  output rd_ram;
  output rd_im;
  output rd_rom;
  output incr;
  output decr;
  output wr_dm;
  output rd_dm;
  `include "u_control.logic.v"
endmodule

