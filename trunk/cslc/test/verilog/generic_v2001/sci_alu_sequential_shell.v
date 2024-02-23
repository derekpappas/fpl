/**********************************************************************
 * $scientific_alu example -- Verilog HDL shell module
 *
 * Scientific ALU C model, sequential logic version.
 *
 * Note: The Verilog language does not permit floating point numbers
 * to be connected to module ports.  However, the language provides
 * built-in system functions which convert real numbers to 64-bit
 * vectors, and vice-versa, so the real values can be passed through
 * a module the port connection. These built-in system functions are
 * $realtobits() and $bitstoreal().
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 1ns
module scientific_alu(clock, a_in, b_in, opcode,
                      result_out, exception, error);
  input         clock;
  input  [63:0] a_in, b_in;
  input   [3:0] opcode;
  output [63:0] result_out;
  output        exception, error;

  real          a, b, result; // real variables used in this module
  reg           exception, error;

  // convert real numbers to/from 64-bit vector port connections
  assign result_out = $realtobits(result);
  always @(a_in) a  = $bitstoreal(a_in);
  always @(b_in) b  = $bitstoreal(b_in);

  //call the PLI application which interfaces to the C model  
  initial
    $scientific_alu(clock, a, b, opcode, result, exception, error);

endmodule