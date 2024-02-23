/**********************************************************************
 * $realpow example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $realpow PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  real        result, r1, r2;

  initial
    begin
      r1 = 5.1;
      r2 = 2.2;

      #1 $display("\n$realpow(2.5, 3) returns %f", $realpow(2.5, 3));
      #1 result = $realpow(r1, r2);
      #1 $display("$realpow(r1,r2) returns %f (r1=%2.1f r2=%2.1f)\n",
                   result, r1, r2);
      #1 $finish;
    end

endmodule
/*********************************************************************/

