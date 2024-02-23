/**********************************************************************
 * $list_path_delays example -- Verilog test bench source code
 *
 * Verilog test bench to test the $list_path_delays PLI application.
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
  wire [1:0] results;

  addbit i1 (test[0], test[1], test[2], results[0], results[1]);

  initial
    begin
      #1 $list_path_delays(i1);
      #1 $finish;
    end
endmodule

/*** A gate level 1 bit adder model ***/
`timescale 1ns / 10ps
module addbit (a, b, ci, sum, co);
  input  a, b, ci;
  output sum, co;

  wire  a, b, ci, sum, co, n1, n2, n3, n4;
  wire  [3:0] foo = 4'bXZ10;

  xor    p1 (n1, a, b);    // all transitions have same delay
  xor    p2 (sum, n1, ci); //rise, fall delays
  and    p3 (n2, a, b);
  and    p4 (n3, n1, ci);
//  or     p5 (co, n2, n3);  //integer delay
  bufif1 p6 (co, n2, 1'b0); //all delay values

  specify
    (a *> sum) = 3.1415;
    (b *> sum) = (1:2:3, 4:5:6, 7:8:9);
    (ci *> sum, co) = (1, 2, 3, 4, 5, 6);
  endspecify

endmodule
/*********************************************************************/
