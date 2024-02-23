//////////////////////////////////////////////////////////////////////
////                                                              ////
////  camera_defines.v                                            ////
////                                                              ////
////  This file is part of the "camera" project                   ////
////  http://www.opencores.org/projects/camera/                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - tadej@opencores.org                                   ////
////      - Tadej Markovic                                        ////
////                                                              ////
////  All additional information is avaliable in the README.txt   ////
////  file.                                                       ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Tadej Markovic, tadej@opencores.org       ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: camera_defines.v,v $
// Revision 1.13  2003/12/04 09:41:26  simons
// FF_DELAY replaced by CAMERA_FF_DELAY.
//
// Revision 1.12  2003/11/25 11:07:27  tadejm
// Signal delays for FF changed from #1 to #TP_CAM or #TP_WB due to testing synchronization. Some other FF count improvements.
//
// Revision 1.11  2003/10/20 08:45:08  tadejm
// Added missing signals in sensitivity lists. Removed non-blocking assignment in case statement in cr and cb tables. Changed define from CASE_RAM to UNSIGNED MULTIPLIER in defines file.
//
// Revision 1.10  2003/10/17 05:53:03  markom
// mbist signals updated according to newest convention
//
// Revision 1.9  2003/10/16 08:09:30  tadejm
// Bug solved; counters for counting lines written in WB frame buffer didn't clear when frame finished. Added new file used in testbench, which does not cover full functionality yet.
//
// Revision 1.7  2003/10/01 13:35:02  tadejm
// Totaly new version. Supports BYPASS, input data ordering, output data ordering, interrupts after adjustable number of lines, INT_STATUS register, etc.
// Currently there are problems with INT signal.
//
// Revision 1.6  2003/08/14 15:21:30  simons
// async_reset_flop replaced by camera_async_reset_flop, synchronizer_flop replaced by camera_synchronizer_flop, artisan ram instance added.
//
// Revision 1.5  2003/07/15 11:35:52  tadejm
// Windows .
//
// Revision 1.4  2003/07/15 10:35:25  tadejm
// BIST added for FIFO BLOCK RAM. BLOCK ROM changed to case sentence. Hierarchy vhanged.
//
// Revision 1.3  2003/07/14 21:58:25  tadejm
// BIST added for FIFO BLOCK RAM. BLOCK ROM changed to
// case sentence. Hierarchy changed
//
//
//

  // the number of cycles, after which WB bus must be released
  //   MAX 5'h31, MIN 5'h1
  `define NUM_OF_BUS_CYC 5'h16

  // all flip-flops in the design have this inter-assignment delay
  //   due to simulation purposses, when SIM is defined in script, 
  //   then it is adjustable.
//  `ifdef SIM
//    `define TP_CAM  camera_testbench.tp_cam
//    `define TP_WB   camera_testbench.tp_wb
//    `define TP_SYNC camera_testbench.tp_sync
//  `else
    `define TP_CAM  1
    `define TP_WB   1
    `define TP_SYNC 0
//  `endif
`define CAMERA_FF_DELAY   1

//###################################################################
// defines for camera FIFO !
//###################################################################

  // Fifo implementation defines:
  // If FPGA and XILINX are defined, Xilinx's BlockSelectRAM+ is instantiated for Fifo storage.
  // 16 bit width is used, so 8 bits of address ( 256 ) locations are available.
  // If FPGA is not defined, then ASIC RAMs are used. Currently there is only one version of 
  // ARTISAN RAM supported. User should generate synchronous RAM with width of 32 and instantiate 
  // it in camera_tpram.v. These can be dual port rams ( write port in one clock domain, read in other ),
  // or it can be two port RAM ( read and write ports in both clock domains ).

  `define FPGA
  `define XILINX

//###################################
// Choose type of RAM for FIFO!
//###################################

  `ifdef FPGA
      `ifdef XILINX
          `define FIFO_BLOCK_RAM
          //`define FIFO_DIST_RAM
  // for FPGA following can be set
         `define FIFO_ADDR_LENGTH 8
         `define FIFO_DEPTH (1 << `FIFO_ADDR_LENGTH)
      `else
      `endif
  `else
      `define VIRTUALSILICON_RAM
      //`define ARTISAN_RAM
      //`define CAMERA_BIST
  // for ASIC following must be fixed
       `define FIFO_ADDR_LENGTH 6 // 64 locations
       `define FIFO_DEPTH (1 << `FIFO_ADDR_LENGTH)
  `endif

//###################################################################
// defines for camera conversions from Y,Cb,Cr to R,G,B !
//###################################################################

  //###################################################
  // Choose type of RAM or MULTIPLIER for CONVERSIONs!
  //###################################################

  `ifdef FPGA
      `ifdef XILINX
          //`define CONVERSION_CASE_RAM
          //`define CONVERSION_SIGNED_MULTIPLIER
          `define CONVERSION_UNSIGNED_MULTIPLIER
      `else
          //`define CONVERSION_CASE_RAM
          //`define CONVERSION_SIGNED_MULTIPLIER
          `define CONVERSION_UNSIGNED_MULTIPLIER
      `endif
  `else
      //`define CONVERSION_CASE_RAM
      //`define CONVERSION_SIGNED_MULTIPLIER
      `define CONVERSION_UNSIGNED_MULTIPLIER
  `endif


/* width of MBIST control bus */
`define CAMERA_MBIST_CTRL_WIDTH 3

