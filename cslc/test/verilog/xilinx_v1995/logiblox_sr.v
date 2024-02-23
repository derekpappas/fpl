      //////////////////////////////////////////
     // LOGIBLOX_SR.V Version 1.0            //
    // Example of a LogiBLOX                //
   // Shift Register instantiation         //
  // HDL Synthesis Design Guide for FPGAs //
 // August 1997                          //
//////////////////////////////////////////

//----------------------------------------------------
// LogiBLOX SHIFT Module "shifter_16"
// Created by LogiBLOX version M1.3.7
//    on Wed Aug 13 17:58:12 1997
// Attributes 
//    MODTYPE = SHIFT
//    BUS_WIDTH = 16
//    ENCODING = UNSIGNED
//    OPTYPE = RIGHT
//    SHIFT_TYPE = LOGICAL
//    SYNC_VAL = 0
//----------------------------------------------------


module logiblox_sr (DATA_IN, CLOCK, ENABLE, RESET, 
                    DATA_OUT);

   input         DATA_IN;   // Serial input data
   input         CLOCK;     // System clock
   input         ENABLE;    // Shifter Enable
   input         RESET;     // Synchronous Reset
   output [15:0] DATA_OUT;  // Parallel Ouput Data

   wire        DATA_IN, CLOCK, ENABLE, RESET;
   wire [15:0] DATA_OUT;

   shifter_16  LB_EXAMPLE(.MS_IN(DATA_IN), .SYNC_CTRL(RESET), 
                           .CLK_EN(ENABLE), .CLOCK(CLOCK), 
                           .Q_OUT(DATA_OUT));

endmodule

module shifter_16(MS_IN, SYNC_CTRL, CLK_EN, CLOCK, Q_OUT);
   input         MS_IN;
   input         SYNC_CTRL;
   input         CLK_EN;
   input         CLOCK;
   output [15:0] Q_OUT;
endmodule

