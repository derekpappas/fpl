`include "defines.v"

module uk842(pin0,
             pin1,
             pin2,
             pin3,
             clk,
             reset);
// Location of source csl unit: file name = ar16.csl line number = 113
  input [3 - 1:0] pin0;
  input [12 - 1:0] pin1;
  input [8 - 1:0] pin2;
  input [3 - 1:0] pin3;
  input clk;
  input reset;
  u3 ui0();
  u4 ui1();
  u5 ui2();
  `include "uk842.logic.v"
endmodule
