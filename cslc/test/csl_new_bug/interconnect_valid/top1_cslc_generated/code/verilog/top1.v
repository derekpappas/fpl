`include "defines.v"

module top1();
// Location of source csl unit: file name = multipl_units.csl line number = 27
  wire x1;
  wire x2;
  wire x3;
  wire y1;
  wire y2;
  wire y3;
  wire x;
  wire y;
  assign   x = {x1, x2, x3};
  assign   y = {y1, y2, y3};
  top top();
  `include "top1.logic.v"
endmodule

