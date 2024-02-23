`include "defines.v"

module alutop(cin,
              aluout,
              cout,
              selal,
              ops_a,
              ops_b,
              selops_s);
// Location of source csl unit: file name = onestagealu2.csl line number = 81
  input cin;
  input selal;
  input [DATA_WIDTH - 1:0] ops_a;
  input [DATA_WIDTH - 1:0] ops_b;
  input selops_s;
  output [DATA_WIDTH - 1:0] aluout;
  output cout;
  wire [8 - 1:0] outifc0_o;
  ostga ostga0(.cin(cin),
               .cout(cout),
               .opifc0_a(ops_a),
               .opifc0_b(ops_b),
               .outifc0_o(outifc0_o),
               .selifc0_s(selops_s));
  ostgl ostgl0(.opifc0_a(ops_a),
               .opifc0_b(ops_b),
               .outifc0_o(outifc0_o),
               .selifc0_s(selops_s));
  mux21 mux21a(.inifc0_o(outifc0_o),
               .inifc1_o(outifc0_o),
               .muxout(aluout),
               .s(selal));
  `include "alutop.logic.v"
endmodule

