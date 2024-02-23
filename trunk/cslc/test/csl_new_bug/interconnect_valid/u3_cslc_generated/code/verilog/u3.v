`include "defines.v"

module u3(x,
          ifc10_y1,
          ifc10_y2,
          ifc20_y,
          ifc20_x);
// Location of source csl unit: file name = concat_assign9.csl line number = 15
  input [18 - 1:0] x;
  input [7 - 1:0] ifc20_x;
  output ifc10_y1;
  output [5 - 1:0] ifc10_y2;
  output [5 - 1:0] ifc20_y;
  assign   x = {ifc10_y2, ifc20_y, ifc10_y1, ifc20_x};
  `include "u3.logic.v"
endmodule

