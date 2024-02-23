`include "defines.v"

module eth_miim(Clk,
                Reset,
                Divider,
                CtrlData,
                Rgad,
                Fiad,
                NoPre,
                WCtrlData,
                RStat,
                ScanStat,
                Mdio,
                Mdc,
                Busy,
                LinkFail,
                Nvalid,
                Prsd,
                WCtrlDataStart,
                RStatStart,
                UpdateMIIRX_DATAReg);
// Location of source csl unit: file name = ethall.csl line number = 248
  input Clk;
  input Reset;
  input [8 - 1:0] Divider;
  input [16 - 1:0] CtrlData;
  input [5 - 1:0] Rgad;
  input [5 - 1:0] Fiad;
  input NoPre;
  input WCtrlData;
  input RStat;
  input ScanStat;
  input Mdio;
  output Mdc;
  output Busy;
  output LinkFail;
  output Nvalid;
  output [16 - 1:0] Prsd;
  output WCtrlDataStart;
  output RStatStart;
  output UpdateMIIRX_DATAReg;
  `include "eth_miim.logic.v"
endmodule

