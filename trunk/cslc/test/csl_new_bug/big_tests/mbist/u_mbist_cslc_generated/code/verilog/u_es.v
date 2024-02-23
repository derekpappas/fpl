`include "defines.v"

module u_es(p_c,
            p_ec);
// Location of source csl unit: file name = mbist_datapath.csl line number = 123
  input [7:0] p_c;
  output [15:0] p_ec;
  `include "mbist_datapath.csl" 
  endmodule

