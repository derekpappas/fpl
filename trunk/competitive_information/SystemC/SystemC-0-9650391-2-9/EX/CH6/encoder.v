// Copyright 2003 Star Galaxy Publishing
// File: encoder.v

module encoder (data, yout);
  input [7:0] data;

  output [2:0] yout;
  reg [2:0] yout;

  always @(data)
    case (data)
      'h01 : yout = 0;
      'h02: yout = 1;
      'h04: yout = 2;
      'h08: yout = 3;
      'h10: yout = 4;
      'h20: yout = 5;
      'h40: yout = 6;
      'h80: yout = 7;
      default: yout = 3'bx;
   endcase
endmodule
