// Copyright 2003 Star Galaxy Publishing
// File: moore2.v

module moore2 (a, clk, reset,  z);
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
        s0: begin moore_state = a ? s0 : s2; end
        s1: begin moore_state = a? s0: s2; end
        s2: begin moore_state = a ? s2 : s3; end
        s3: begin moore_state = a ? s1 : s3; end
      endcase

  always @(moore_state)
      case (moore_state)
        s0: begin z = 1; end
        s1: begin z = 0; end
        s2: begin z = 0; end
        s3: begin z = 1; end
      endcase
endmodule
