`include "defines.v"

module uk757(pin0,
             pin1,
             pin2,
             pin3,
             clk,
             reset);
// Location of source csl unit: file name = ar16.csl line number = 126
  input [3 - 1:0] pin0;
  input [12 - 1:0] pin1;
  input [8 - 1:0] pin2;
  input [3 - 1:0] pin3;
  input clk;
  input reset;
  u1 ui3();
  u3 ui4();
  `include "uk757.logic.v"
endmodule

