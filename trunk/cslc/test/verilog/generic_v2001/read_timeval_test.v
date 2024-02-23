/**********************************************************************
 * $read_timeval example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $read_timeval PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  time T;
  
  initial
    begin
      T = 0;
      T[1] = 1;
      T[32] = 1;
      #1 $read_timeval(T);
      #1 $finish;
    end
endmodule

/*********************************************************************/

