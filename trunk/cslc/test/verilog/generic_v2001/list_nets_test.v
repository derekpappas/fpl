/**********************************************************************
 * $list_nets example -- Verilog test bench source code
 *
 * Verilog test bench to test the $list_nets PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module top;
  reg  [2:0] test;
  wire [2:0] results;

  addbit i1 (test[0], test[1], test[2], results[0], results[1]);

  initial
    begin
      test = 3'b000;
      #10 test = 3'b001;

      #10 $list_nets(top);
      #10 $list_nets(i1);

      #10 $finish;
    end
endmodule

/*** A gate level 1 bit adder model ***/
`timescale 1ns / 1ns
module addbit (a, b, ci, sum, co);
  input  a, b, ci;
  output sum, co;

  wire  a, b, ci, sum, co, n1, n2, n3;
  wire  [3:0] foo = 4'bXZ10;

  xor    (n1, a, b);
  xor #2 (sum, n1, ci);
  and    (n2, a, b);
  and    (n3, n1, ci);
  or  #2 (co, n2, n3);

endmodule
/*********************************************************************/

