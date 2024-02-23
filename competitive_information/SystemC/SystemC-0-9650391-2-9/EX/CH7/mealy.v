// Copyright 2003 Star Galaxy Publishing
// File: mealy.v

module mealy (clk, reset, a, z);
  input a, clk, reset;

  output z;

  parameter S0=4'b1110, S1=4'b1101, S2=4'b1011, S3=4'b0111;

  reg [3:0] mealy_state, next_state;
  reg z;

  always @(negedge clk or posedge reset)
    if (reset)   
      mealy_state = S0;
    else
      mealy_state = next_state;

  always @(a or mealy_state)
    case (mealy_state)
      S0: if (a) begin z = 1; next_state = S3; end else z = 0;
      S1: if (a) begin z = 1; next_state = S0; end else z = 0;
      S2: if (!a) z = 0; else begin z = 1; next_state = S1; end
      S3: begin z = 0; next_state = !a ? S2 : S1; end
    endcase
endmodule
