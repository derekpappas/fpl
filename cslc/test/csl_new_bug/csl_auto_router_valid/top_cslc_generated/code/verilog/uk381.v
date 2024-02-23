`include "defines.v"

module uk381(pin0,
             pin1,
             pin2,
             pin3,
             clk,
             reset);
// Location of source csl unit: file name = ar16.csl line number = 95
  input [3 - 1:0] pin0;
  input [12 - 1:0] pin1;
  input [8 - 1:0] pin2;
  input [3 - 1:0] pin3;
  input clk;
  input reset;
  u4 ui0();
  u3 ui1();
  u3 ui2();
  u3 ui3();
  u3 ui4();
  u3 ui5();
  `include "uk381.logic.v"
endmodule

