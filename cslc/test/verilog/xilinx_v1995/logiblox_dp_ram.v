      /////////////////////////////////////////////
     //  LOGIBLOX_DP_RAM.V Version 1.0          //
    //  Example of an instantiation of a       //
   //  LogiBLOX created Duel Port RAM module  //
  // HDL Synthesis Design Guide for FPGAs    //
 // May 1997                                //
/////////////////////////////////////////////

module logiblox_dp_ram (WRITE_ADDR, DATA_IN, WE, 
                        CLOCK, DATA_OUT, READ_ADDR);

input  [3:0] WRITE_ADDR, DATA_IN, READ_ADDR ;
input        WE, CLOCK ;
output [3:0] DATA_OUT ;


//----------------------------------------------------
// LogiBLOX DP_RAM Module "lb_dp_ram"
// Created by LogiBLOX version M1.3.7
//    on Tue Sep  2 15:53:19 1997
// Attributes 
//    MODTYPE = DP_RAM
//    BUS_WIDTH = 4
//    DEPTH = 16
//    MEMFILE = lb_memfile
//----------------------------------------------------


lb_dp_ram DPRAM16X4
( .A(WRITE_ADDR),
  .SPO(),
  .DI(DATA_IN),
  .WR_EN(WE),
  .WR_CLK(CLOCK),
  .DPO(DATA_OUT),
  .DPRA(READ_ADDR));

endmodule


// Module definition for LogiBLOX DP_RAM

module lb_dp_ram(A, SPO, DI, WR_EN, WR_CLK, DPO, DPRA);

   input  [3:0] A;
   output [3:0] SPO;
   input  [3:0] DI;
   input        WR_EN;
   input        WR_CLK;
   output [3:0] DPO;
   input  [3:0] DPRA;

endmodule
