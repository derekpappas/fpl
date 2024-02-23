// Copyright 2003 Star Galaxy Publishing
// File: mod_counter.v

module mod_counter (clk, clear, q, qbar);
  parameter UPTO = 11, NBITS = 4;

  input clk, clear;

  output [NBITS-1:0] q, qbar;
  reg [NBITS-1:0] tmp, q, qbar, counter;

  always @(posedge clk or posedge clear)
    if (clear)
      counter = 0;
    else begin
       tmp = counter + 1;

       if (tmp == UPTO)
         counter = 0;
    end
    //   counter = (counter + 1) % 10;
      // counter = counter + 1;

  always @(counter) begin
    q = counter;
    qbar = ~ counter;
  end
endmodule
