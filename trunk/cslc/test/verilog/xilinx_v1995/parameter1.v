      ////////////////////////////////////////////
     // PARAMETER1.V Version 1.0               //
    // Xilinx HDL Synthesis Design Guide      //
   // Example of using a parameter data type //
  // to produce more readable code          //
 // December 1997                          //
////////////////////////////////////////////

module parameter1(OPCODE, A, B, OP_OUT);

   output       OP_OUT;
   input  [1:0] OPCODE;
   input        A, B;

   reg OP_OUT;

   parameter ZERO    = 2'b00;
   parameter A_AND_B = 2'b01; 
   parameter A_OR_B  = 2'b10;
   parameter ONE     = 2'b11;

   always @ (OPCODE or A or B)
   begin
      if      (OPCODE == ZERO)    OP_OUT = 1'b0;
      else if (OPCODE == A_AND_B) OP_OUT = A & B;
      else if (OPCODE == A_OR_B)  OP_OUT = A | B;
      else                        OP_OUT = 1'b1;
   end

endmodule
