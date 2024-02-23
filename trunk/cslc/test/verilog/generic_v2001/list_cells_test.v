/**********************************************************************
 * $list_cells example -- Verilog test bench source code
 *
 * Verilog test bench to test the $list_cells PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/

/**********************************************************************
 * Top-level test bench module for a 4-bit adder model.
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg    [3:0] a, b;
  wire   [3:0] sum;
  reg          ci;
  wire         co;

  add4 i1 (a, b, ci, sum, co);

  initial
    begin
      #1 $list_cells(i1);
      #1 $finish;
    end
endmodule

/**********************************************************************
 * 4-bit adder model, using a 1-bit adder model.
 *********************************************************************/
`timescale 1ns / 1ns
module add4 (a, b, ci, sum, co);
  input  [3:0] a, b;
  input        ci;
  output [3:0] sum;
  output       co;

  wire   [3:0] a, b, sum;
  wire         ci, co, co1, co2, co3;

  addbit  a1  (a[0], b[0], ci,  sum[0], co1);
  addbit  a2  (a[1], b[1], co1, sum[1], co2);
  addbit  a3  (a[2], b[2], co2, sum[2], co3);
  addbit  a4  (a[3], b[3], co3, sum[3], co );

endmodule

/**********************************************************************
 * 1-bit adder model, using cells from a library.
 *********************************************************************/
`timescale 1ns / 1ns
module addbit (a, b, ci, sum, co);
  input  a, b, ci;
  output sum, co;

  wire  a, b, ci, sum, co,
        n1, n2, n3;

  xor2  u1  (n1, a, b);
  xor2  u2  (sum, n1, ci);
  and2  u3  (n2, a, b);
  and2  u4  (n3, n1, ci);
  or2   u5  (co, n2, n3);

endmodule
/**********************************************************************
* Cell library
 *********************************************************************/
`resetall
`celldefine
`timescale 1ns / 10ps
module or2 (y, a, b);
  output y;
  input  a, b;
  wire   y, a, b;  //wire data type for cmos
  or    (y, a, b);
  specify
    (a *> y) = 1.0;
    (b *> y) = 1.0;
    specparam BaseDelay$   = 2.5;
    specparam InputLoad$a  = 0.3;
    specparam InputLoad$b  = 0.3;
    specparam InputLoad$c  = 0.3;
    specparam in_cap_pf$a  = 0.02;
    specparam in_cap_pf$b  = 0.02;
    specparam in_cap_pf$c  = 0.02;
    specparam out_cap_pf$  = 0.05;
  endspecify
endmodule
`endcelldefine
/*********************************************************************/
`resetall
`celldefine
`timescale 1ns / 10ps
module xor2 (y, a, b);
  output y;
  input  a, b;
  wire   y, a, b;  //wire data type for cmos
  xor   (y, a, b);
  specify
    (a *> y) = 1.0;
    (b *> y) = 1.0;
    specparam BaseDelay$   = 2.5;
    specparam InputLoad$a  = 0.3;
    specparam InputLoad$b  = 0.3;
    specparam InputLoad$c  = 0.3;
    specparam in_cap_pf$a  = 0.02;
    specparam in_cap_pf$b  = 0.02;
    specparam in_cap_pf$c  = 0.02;
    specparam out_cap_pf$  = 0.05;
  endspecify
endmodule
`endcelldefine
/*********************************************************************/
`resetall
`celldefine
`timescale 1 ns / 10 ps
module and2 (y, a, b);
  output y;
  input  a, b;
  wire   y, a, b;  //wire data type for cmos
  and   (y, a, b);
  specify
    (a *> y) = 1.0;
    (b *> y) = 1.0;
    specparam BaseDelay$   = 2.5;
    specparam InputLoad$a  = 0.2;
    specparam InputLoad$b  = 0.2;
    specparam in_cap_pf$a  = 0.02;
    specparam in_cap_pf$b  = 0.02;
    specparam out_cap_pf$  = 0.05;
  endspecify
endmodule
`endcelldefine
/*********************************************************************/
