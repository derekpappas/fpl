/**********************************************************************
 * $my_monitor2 example -- Verilog test bench source code
 *
 * Verilog test bench to test the $my_monitor1 PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;

  reg [3:0] q, d;
  reg clock;
  
  initial
    $my_monitor2(clock, q, d);
    
  always @(posedge clock)
    q <= #1 d;
    
  initial
    begin
      clock = 0;
      forever #5 clock = ~ clock;
    end
  
  initial
    begin
      d = 4'h0;
      @(negedge clock) d = 4'h1;
      @(negedge clock) d = 4'hF;
      @(negedge clock) $finish;
    end
endmodule
      