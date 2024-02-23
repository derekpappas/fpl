/**********************************************************************
 * $read_stimulus_short example -- Verilog test bench source code
 *
 * Verilog test bench to test the $read_stimulus_short PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg   [8:0] input_vector;
  wire  [3:0] a, b, sum;
  wire        ci, co;

  add4 i1 (a, b, ci, sum, co);

  assign {ci, a, b} = input_vector;
  
  initial
    begin
      $timeformat(-9,0," ns",10);
      $monitor("%t:  a=%b  b=%b  ci=%b  sum=%b  co=%b",
               $time, a, b, ci, sum, co);
      $read_stimulus_short("read_stimulus.pat", input_vector);
      #500 $finish;
    end
endmodule

/*** A netlist level 4-bit adder model ***/
`timescale 1ns / 1ns
module add4 (a, b, ci, sum, co);
  input  [3:0] a, b;
  input        ci;
  output [3:0] sum;
  output       co;

  wire   [3:0] a, b, sum;
  wire         ci, c0, c1, c2, co;

  addbit u0 (a[0], b[0], ci, sum[0], c0);
  addbit u1 (a[1], b[1], c0, sum[1], c1);
  addbit u2 (a[2], b[2], c1, sum[2], c2);
  addbit u3 (a[3], b[3], c2, sum[3], co);

endmodule

/*** A gate level 1-bit adder model ***/
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
endmodule
/**********************************************************************/
