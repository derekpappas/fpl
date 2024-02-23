`include "defines.v"

module uk982(pin0,
             pin1,
             pin2,
             pin3,
             clk,
             reset);
// Location of source csl unit: file name = ar16.csl line number = 154
  input [3 - 1:0] pin0;
  input [12 - 1:0] pin1;
  input [8 - 1:0] pin2;
  input [3 - 1:0] pin3;
  input clk;
  input reset;
  u2 ui0();
  u5 ui1();
  u0 ui2();
  u2 ui3();
  u1 ui4();
  `include "uk982.logic.v"
endmodule

