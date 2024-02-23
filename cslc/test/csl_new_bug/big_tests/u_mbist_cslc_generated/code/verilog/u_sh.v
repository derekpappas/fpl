`include "defines.v"

module u_sh(ifc_din_o,
            ifc_dout_o,
            p_sham);
// Location of source csl unit: file name = mbist_datapath.csl line number = 143
  input [15:0] ifc_din_o;
  input [15:0] p_sham;
  output [15:0] ifc_dout_o;
  `include "u_sh.logic.v"
endmodule

