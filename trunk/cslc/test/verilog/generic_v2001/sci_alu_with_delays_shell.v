/**********************************************************************
 * $scientific_alu example -- Verilog HDL shell module
 *
 * Scientific ALU C model, combinational logic version with pin-to-pin
 * path delays.  The path delays are represented using a Verilog 
 * specify block.
 *
 * NOTES:
 * - Note: The Verilog language does not permit floating point numbers
 *   to be connected to module ports.  However, the language provides
 *   built-in system functions which convert real numbers to 64-bit
 *   vectors, and vice-versa, so the real values can be passed through
 *   a module the port connection. These built-in system functions are
 *   $realtobits() and $bitstoreal().
 *
 * - Some Verilog simulators require that path delays to be used with
 *   models where all ports are connected to uni-directional
 *   primitives with nets data types connected to the inputs an outputs
 *   of the primitives.  This model satisfies this restriction by
 *   adding buffers to all input and output ports.
 *
 * - This shell module uses the array of instances from the IEEE 1364
 *   Verilog standard.  Some simulators do not support this construct,
 *   and may require using a separate instance statement for each bit
 *   of a vector.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *********************************************************************/
`timescale 1ns / 100ps
module scientific_alu(a_in, b_in, opcode_in,
                      result_out, exception, error);
  output [63:0] result_out;
  output        exception, error;
  input  [63:0] a_in, b_in;
  input   [3:0] opcode_in;

  wire   [63:0] result_out, result_vector;
  wire   [63:0] a_in, a_vector;
  wire   [63:0] b_in, b_vector;
  wire    [3:0] opcode_in, opcode_vector;
  wire          exception, error;

  reg           exception_reg, error_reg;
  real          a, b, result; // real variables used in this module

  // convert real numbers to/from 64-bit vector port connections
  assign result_vector = $realtobits(result);
  always @(a_vector)  a = $bitstoreal(a_vector);
  always @(b_vector)  b = $bitstoreal(b_vector);

  //call the PLI application which interfaces to the C model  
  initial
    $scientific_alu(a, b, opcode_vector,
                    result, exception_reg, error_reg);

  specify
    (a_in, b_in *> result_out, exception, error) = (5.6, 4.7);
    (opcode_in  *> result_out, exception, error) = (3.4, 3.8);
  endspecify

  // add buffers to all ports, with nets connected to each buffer
  // (this example uses the array of instance syntax in the
  // from the IEEE 1364-1995 Verilog standard
  buf result_buf[63:0] (result_out, result_vector);
  buf excep_buf        (exception,  exception_reg);
  buf error_buf        (error,      error_reg);

  buf a_buf[63:0]      (a_vector, a_in);
  buf b_buf[63:0]      (b_vector, b_in);
  buf opcode_buf[3:0]  (opcode_vector, opcode_in);

endmodule
