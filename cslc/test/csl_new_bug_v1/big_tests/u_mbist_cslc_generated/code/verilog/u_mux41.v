`include "defines.v"

module u_mux41(in0,
               in1,
               in2,
               in3,
               sel,
               ifc_out0_o);
// Location of source csl unit: file name = mbist_datapath.csl line number = 106
  input [15:0] in0;
  input [15:0] in1;
  input [15:0] in2;
  input [15:0] in3;
  input [4 - 1:0] sel;
  output [15:0] ifc_out0_o;
  `include "u_mux41.logic.v"
endmodule

