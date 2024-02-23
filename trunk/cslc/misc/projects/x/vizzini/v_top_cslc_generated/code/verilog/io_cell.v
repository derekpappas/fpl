`include "defines.v"

module io_cell(pad_in,
               pad_out,
               pad_en,
               pad_pin);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 141
  input pad_out;
  input pad_en;
  output pad_in;
  inout pad_pin;
  `include "io_cell.logic.v"
endmodule

