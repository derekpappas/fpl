/**********************************************************************
 * $port_info example -- Verilog test bench source code
 *
 * Verilog test bench to test the $port_info PLI application.
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
  wire sum, co;

  addbit i1 (a, b, ci, sum, co);

  initial
    begin
      #10 $port_info(i1);
      #10 $finish;
    end
endmodule

/*** A gate level 1 bit adder model ***/
`timescale 1ns / 1ns
module addbit (a, b, ci, sum, co, foo);
  input  a, b, ci;
  output sum, co;
  output [3:0] foo;

  wire  a, b, ci;
  reg   sum, co;
  wand  scalared [3:0] foo;

  always @(a or b or ci)
    {co,sum} = a + b + ci;

endmodule
/*********************************************************************/
