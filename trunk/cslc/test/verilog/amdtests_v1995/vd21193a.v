//THE `PROTECT `ENDPROTECT DIRECTIVES HAVE BEEN COMMENTED

///////////////////////////////////////////////////////////////////////////
// MCP (Multi-Chip Package)  Verilog Simulation Model                    //
//   Flash Memory(16M:x8/x16) & Static RAM(4M:x8/x16)                    //
// Version: 1.1                                                          //
// Date: 2000/10/31                                                      //
// Designed by FUJITSU                                                   //
// module : MB84VD21093                                                  //
//                                                                       //
//   Copyright (c) FUJITSU LIMITED, 2000.                                //
//   All Rights Reserved. Licensed Library.                              //
///////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ns

`celldefine
module MB84VD21193A(
  A,      // Address Input
  SA,     // Address Input
  DQ,     // Data Input/Output
  XCEf,   // Chip Enable Input
  XCE1s,  // Chip Enable Input
  CE2s,   // Chip Enable Input
  XOE,    // Output Enable Input
  XWE,    // Write Enable Input
  XRESET, // Hard Reset Input
  CIOf,   // Byte/Word Configuration Input
  CIOs,   // Byte/Word Configuration Input
  XLB,    // Low Byte Control Input
  XUB,    // Uper Byte ControlInput
  RY_XBY, // Ready/Busy Output
  XWP     // Write Protect Input
);

// pin width
  parameter AB=20 ; // Address Bus width
  parameter W=16 ; // Data Bus width

  input [AB-1:0] A ;
  inout [W-1:0]  DQ ;
  input XCEf,XOE,XWE,XRESET,CIOf,XWP ;
  input SA,XCE1s,CE2s,CIOs,XLB,XUB ;
  output RY_XBY ;

// External Parameter (FLASH)
parameter ERR_FLG = 0       ; // Error Flag  0:Normal, 1:Error

// External Parameter (SRAM)

////////////////////////////////////////////////////////////////
// module     instance pin
  MBM29DL163D  flash  ( A, DQ, XCEf, XOE, XWE, XRESET, CIOf, RY_XBY, XWP ) ;
  SRAM4Mx16    sram   ( A[17:0], SA, DQ, XCE1s, CE2s, XOE, XWE
                        , XLB, XUB, CIOs ) ;

  defparam flash.ERR_FLG=ERR_FLG ;
////////////////////////////////////////////////////////////////
//`protect
////////////////////////////////////////////////////////////////
// Flash Parameter (16M,x8/x16,Bottom Boot)
  parameter B_TYPE  = "BOTM"  ; // Block Type
  parameter SAB=8 ; // Sector Address Bus width

  defparam flash.B_TYPE=B_TYPE ;
  defparam flash.AB=AB ;
  defparam flash.SAB=SAB ;
  defparam flash.W=W ;

// SRAM Parameter (4M,x8/x16)
  parameter ABs=18 ; // Address Bus width
  parameter Ws=16 ; // Data Bus width

  defparam sram.AB=ABs ;
  defparam sram.W=Ws ;
//////////////////////////////////////////////////////////////////////
// History                                                          //
// ==> vd21193a.v 1st Release                                       //
//                         : 1.0   2000/08/18                       //
//                         : 1.1   2000/10/31 add. timing check     //
//////////////////////////////////////////////////////////////////////
//--< Chip Enable Check >--
always @( negedge XCEf or negedge XCE1s or posedge CE2s ) begin
  if ( XCEf == 1'b0 && XCE1s == 1'b0 && CE2s == 1'b1 ) begin
    $write("%t : 3010 Illegal Operation in Chip Enable Input.\n", $time) ;
  end
end
//--< CIOf/CIOs Check >--
always @( CIOf or CIOs ) begin
  if ( $time > 0 ) begin
    $write("%t : 3020 CIOf/CIOs should be fix to High or Low.\n", $time) ;
  end
end

endmodule
//`endprotect
`endcelldefine

`include "mp_dl163d.v"
`include "sm4mx16.v"
