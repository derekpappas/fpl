/**********************************************************************
 * $propagatep_test example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $propagatep_test PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg  [7:0] reg1;
  real       real1;
  reg  [7:0] mem1 [0:3];

  initial
    begin
      $monitor("\nAt time %0d in test bench: reg1=%h  real1=%2.1f  mem1[0]=%h\n",
               $stime, reg1, real1, mem1[0]);
      reg1  = 1'b0;
      real1 = 0.0;

      #1 $display("Calling $propagatep_test(reg1)...");
         $propagatep_test(reg1);

      #1 $display("Calling $propagatep_test(real1)...");
         $propagatep_test(real1);

      #1 $display("Calling $propagatep_test(reg1[2])...");
         $propagatep_test(reg1[2]);

      #1 $display("Calling $propagatep_test(reg1[7:4])...");
         $propagatep_test(reg1[7:4]);

      #1 $display("Calling $propagatep_test(mem1[0])...");
         $propagatep_test(mem1[0]);

      #1 $finish;
    end

endmodule

/**********************************************************************/
