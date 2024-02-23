/**********************************************************************
 * $func_72bit example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $func_72bit PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg  [71:0] result;

  initial
    begin
      #1 result = $func_72bit("");
      #1 $display("$func_72bit() returns %b ", result);
    end

endmodule

/**********************************************************************/
