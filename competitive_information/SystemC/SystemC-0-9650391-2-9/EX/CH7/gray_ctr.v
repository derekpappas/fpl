// Copyright 2003 Star Galaxy Publishing
// File: gray_ctr.v

module gray_ctr (clk, reset, up_down, hold, gray_count);
  parameter s0 =3'b000, s1=3'b001, s2=3'b011, s3=3'b010,
   s4=3'b110, s5=3'b111, s6=3'b101, s7=3'b100;

  input clk, reset, up_down, hold;

  output [2:0] gray_count;
  reg [2:0] gray_count;

  always @(negedge clk or negedge reset)
    if (! reset)
      gray_count = s0;
    else if (! hold)
      case (gray_count)
        s0: gray_count = up_down ? s1 : s7;
        s1: gray_count = up_down ? s2 : s0;
        s2: gray_count = up_down ? s3 : s1;
        s3: gray_count = up_down ? s4 : s2;
        s4: gray_count = up_down ? s5 : s3;
        s5: gray_count = up_down ? s6 : s4;
        s6: gray_count = up_down ? s7 : s5;
        s7: gray_count = up_down ? s0 : s6;
      endcase
endmodule

