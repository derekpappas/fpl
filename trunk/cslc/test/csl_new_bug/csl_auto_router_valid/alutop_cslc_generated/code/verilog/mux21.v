`include "defines.v"

module mux21(inifc0_o,
             inifc1_o,
             muxout,
             s);
// Location of source csl unit: file name = onestagealu2.csl line number = 64
  input [DATA_WIDTH - 1:0] inifc0_o;
  input [DATA_WIDTH - 1:0] inifc1_o;
  input s;
  output [DATA_WIDTH - 1:0] muxout;
  `include "mux21.logic.v"
endmodule

