// Copyright 2003 Star Galaxy Publishing
// File: moore.v

module moore (a, clk, reset,  z);
  parameter s0 = 0, s1=1, s2=2, s3=3;

  input a, clk, reset;

  output z;
  reg z;

  reg [1:0] moore_state;

  always @(posedge clk)
    if (reset)
      moore_state = s0;
    else
      case (moore_state)
        s0: begin z = 1; moore_state = a ? s0 : s2; end
        s1: begin z = 0; moore_state = a? s0: s2; end
        s2: begin z = 0; moore_state = a ? s2 : s3; end
        s3: begin z = 1; moore_state = a ? s1 : s3; end
      endcase
endmodule
