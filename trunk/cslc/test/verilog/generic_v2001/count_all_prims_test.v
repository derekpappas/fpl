/**********************************************************************
 * $count_primitives example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $count_primitives PLI application 
 * on a 1-bit adder modeled using gate primitives.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg  a, b, ci, clk;
  wire sum, co, sum2;

  addbit i1 (a, b, ci, sum, co);
  buf (sum2, sum);

  initial
    begin
      #1 $count_primitives;
      #1 $finish;
    end
endmodule

/*** A gate level 1 bit adder model ***/
`timescale 1ns / 1ns
module addbit (a, b, ci, sum, co);
  input  a, b, ci;
  output sum, co;

  wire  a, b, ci, sum, co,
        n1, n2, n3;

  xor    (n1, a, b);
  xor #2 (sum, n1, ci);
  and    (n2, a, b);
  and    (n3, n1, ci);
  or  #2 (co, n2, n3);
  
  specify
    (a *> sum) = 5;
    (b *> sum, co) = 5;
  endspecify

endmodule
/*********************************************************************/
