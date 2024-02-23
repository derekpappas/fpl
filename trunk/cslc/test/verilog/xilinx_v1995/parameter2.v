      ////////////////////////////////////////////
     // PARAMETER2.V Version 1.0               //
    // Xilinx HDL Synthesis Design Guide      //
   // Example of using a parameter data type //
  // to specify a bus size                  //
 // December 1997                          //
////////////////////////////////////////////

module parameter2(out, a, b, sel);

   parameter size = 8;

   output [size-1:0] out;
   input  [size-1:0] a, b;
   input             sel;

   assign out = (sel) ? a : b;

endmodule
