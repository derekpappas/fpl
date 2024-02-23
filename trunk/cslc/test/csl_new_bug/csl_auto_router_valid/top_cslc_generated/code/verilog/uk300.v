`include "defines.v"

module uk300(pin0,
             pin1,
             pin2,
             pin3,
             clk,
             reset);
// Location of source csl unit: file name = ar16.csl line number = 81
  input [3 - 1:0] pin0;
  input [12 - 1:0] pin1;
  input [8 - 1:0] pin2;
  input [3 - 1:0] pin3;
  input clk;
  input reset;
  u1 ui0();
  u1 ui1();
  u4 ui2();
  u0 ui3();
  `include "uk300.logic.v"
endmodule
