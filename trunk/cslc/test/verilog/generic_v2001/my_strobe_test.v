/**********************************************************************
 * $my_strobe example -- Verilog test bench source code
 *
 * Verilog test bench to test the $my_strobe PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;

  reg [3:0] sum, a, b;
  reg clock;
  
  always @(posedge clock)
    $my_strobe(sum);
    
  always @(posedge clock)
    sum = a + b;
    
  initial
    begin
      clock = 0;
      forever #5 clock = ~ clock;
    end
  
  initial
    begin
      //$monitor("At %0d sum=%b",$stime, sum);
      a = 4'h0;
      b = 4'h0;
      @(negedge clock) a = 4'h1;
      @(negedge clock) b = 4'h1;
      @(negedge clock) a = 4'hF;
      @(negedge clock) $finish;
    end
endmodule
      