/**********************************************************************
 * $scientific_alu example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $scientific_alu C model PLI 
 * application.  This test uses the Scientific Alu as a latched
 * logic device.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
 
`include "sci_alu_latched_shell.v"

`timescale 1ns / 1ns
module test;

  reg   [4:0] opcode;
  reg         enable;
  wire        excep, err;
  real        a, b, result1, result2;
  wire [63:0] a_in, b_in, result_out1, result_out2;

  // convert real numbers to/from 64-bit vector port connections
  always @(result_out1) result1 = $bitstoreal(result_out1);
  always @(result_out2) result2 = $bitstoreal(result_out2);
  assign a_in = $realtobits(a);
  assign b_in = $realtobits(b);

  scientific_alu i1 (enable, a_in, b_in,  opcode[3:0], result_out1, excep, err);
  scientific_alu i2 (enable, a_in, b_in, ~opcode[3:0], result_out2, excep, err);

  initial
    begin
      $timeformat(-9,0," ns",7);
      $monitor("At %t: result1=%.2f \tresult2=%.2f \t  excep=%b  err=%b  a=%.1f  b=%.1f  opcode=%h, enable=%b",
               $time, result1, result2, excep, err, a, b, opcode[3:0], enable);
      enable = 1;
      a = 16.0;
      b =  2.0;
      for (opcode=0; opcode<=15; opcode=opcode+1)
        #1 ;
      
      #10 $display("");
      enable = 0;

      #10 $display("\n");
      $finish;
    end

endmodule

/*********************************************************************/
