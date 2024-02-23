//////////////////////////////////////////////////////////////////////
////                                                              ////
////  camera_bench_defines.v                                      ////
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
// $Log: camera_bench_defines.v,v $
// Revision 1.2  2003/10/17 05:53:02  markom
// mbist signals updated according to newest convention
//
// Revision 1.1.1.1  2003/05/12 13:07:39  tadejm
// Camera IP Core
//
// Revision 1.2  2003/05/12 09:54:48  tadejm
// Heading changed
//
//
//
//


/*===================================================================
  Following defines select which camera module is used!
  Only ONE shoud be defined !!!
===================================================================*/

`define HITACHI_CAM
//`define OMNIVISION_CAM