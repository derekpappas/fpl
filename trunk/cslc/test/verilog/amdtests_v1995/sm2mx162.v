//THE `PROTECT `ENDPROTECT DIRECTIVES HAVE BEEN COMMENTED

///////////////////////////////////////////////////////////////////////////
// Static RAM (2M:256Kx8/128Kx16) Verilog Simulation Model               // 
// Version: 1.1                                                          //
// Date: 2001/01/15                                                      //
// Designed by FUJITSU                                                   //
// module : SRAM2Mx16                                                    //
//                                                                       //
//   Copyright (c) FUJITSU LIMITED, 2000.                                //
//   All Rights Reserved. Licensed Library.                              //
///////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ns

`celldefine
module SRAM2Mx16(
  A,      // Address Input
  SA,     // Address Input
  DQ,     // Data Input/Output
  XCE1,   // Chip Enable Input
  CE2,    // Chip Enable Input
  XOE,    // Output Enable Input
  XWE,    // Write Enable Input
  XLB,    // Low Byte Control Input
  XUB,    // Upper Byte ControlInput
  XBYTE   // Byte/Word Configuration Input
);

//////////////////////////////////////////////////////////////////////
//`protect
//////////////////////////////////////////////////////////////////////
// History                                                          //
// ==> sm2mx16.v 1st Release                                        //
//                         : 1.0   2000/08/09                       //
//                         : 1.1   2001/01/15 modify AC parameter   //
//////////////////////////////////////////////////////////////////////
// pin width
  parameter AB=17 ; // Address Bus width
  parameter W=16 ; // Data Bus width

  input [AB-1:0] A ;
  inout [W-1:0]  DQ ;
  input XCE1,CE2,XOE,XWE ;
  input SA,XLB,XUB,XBYTE ;

// Architecture
parameter NUM_OF_ADDR  = 1<<(AB) ; //AB=17 -> 128k

//////////////////////////////////////////////////////////////////////
// register declaration
//   wdt  name         addr
reg [W-1:0] ARRAY [NUM_OF_ADDR-1:0] ; //128k x16

reg [7:0] DQ_LB, DQ_UB ;
reg XCE ;
reg XCEorXOE, XCEorXWE ;
reg RD_LB, RD_UB ;
reg WR_LB, WR_UB ; 
reg AFTER_A, AFTER_XCE, AFTER_XOE ;
reg AFTER_XWE ;
reg AFTER_XLB, AFTER_XUB ;
reg OUT_HIZ_LB, OUT_HIZ_UB ;
reg XCE_ACT, XWE_ACT, XOE_ACT, XLB_ACT, XUB_ACT ;
reg OUT_ACT, OUT_HOLD ;
reg INVALID ;
reg WP_A, WP_DQ, WP_XCE, WP_XWE, WP_XLB, WP_XUB ;
reg WP_DQ_LB, WP_DQ_UB ;
reg EN_WP_LB, EN_WP_UB ;
wire SABUF, EN_LB, EN_UB ;

time tAA, tCO1, tCO2, tOE, tCOE, tOEE, tOD, tODO, tOH, tBA, tBE, tBD ;
time tWP, tCW, tAW, tAS, tWR, tODW, tOEW, tDS, tDH, tBW ;

time rfA, rfDQ_LB, rfDQ_UB, rXCE, fXCE, rXWE, fXWE ;
time rXLB, fXLB, rXUB, fXUB ;
time rWR_LB, fWR_LB, rWR_UB, fWR_UB ;
time rEN_WP_LB, fEN_WP_LB, rEN_WP_UB, fEN_WP_UB ;

event DQ_OUTPUT ;
event EN_WP_LB_event, EN_WP_UB_event ;
event ARRAY_event ;

reg [W-1:0] OUTBUF ;
//////////////////////////////////////////////////////////////////////
reg [W-1:0] oDQ ;
reg OUT_CTL_LB, OUT_CTL_UB ;
assign DQ[7:0] = OUT_CTL_LB ? oDQ[7:0] : {8{1'bz}} ;
assign DQ[15:8] = OUT_CTL_UB ? oDQ[15:8] : {8{1'bz}} ;
//////////////////////////////////////////////////////////////////////

initial begin : memory_initialize
  integer i ;
  for( i=0 ; i < NUM_OF_ADDR ; i = i + 1 ) begin
    ARRAY[i] = {W{1'b1}} ;
  end
end

initial begin : dependent_init
  XCE = 1 ;
  XCEorXOE = 1 ;
  XCEorXWE = 1 ;
  RD_LB = 1 ;
  RD_UB = 1 ;
  WR_LB = 1 ;
  WR_UB = 1 ;
  AFTER_A = 0 ;
  AFTER_XCE = 0 ;
  AFTER_XOE = 0 ;
  AFTER_XWE = 0 ;
  AFTER_XLB = 0 ;
  AFTER_XUB = 0 ;
  OUT_HIZ_LB = 0 ;
  OUT_HIZ_UB = 0 ;
  XCE_ACT = 0 ;
  XWE_ACT = 0 ;
  XOE_ACT = 0 ;
  XLB_ACT = 0 ;
  XUB_ACT = 0 ;
  OUT_ACT = 0 ;
  OUT_HOLD = 0 ;
  INVALID = 0 ;
  WP_A = 0 ;
  WP_XWE = 0 ;
  WP_XCE = 0 ;
  WP_XLB = 0 ;
  WP_XUB = 0 ;
  WP_DQ_LB = 0 ;
  WP_DQ_UB = 0 ;
  EN_WP_LB = 1 ;
  EN_WP_UB = 1 ;

  // Timing Parameter
    //--<Read Cycle Operation >>
    tAA   =   85 ; tCO1  =   85 ; tCO2  =   85 ;
    tOE   =   45 ; tCOE  =    5 ; tOEE  =    0 ;
    tOD   =   35 ; tODO  =   35 ; tOH   =   10 ;
    tBA   =   85 ; tBE   =    0 ; tBD   =   35 ;
    //--<Write Cycle Operation >>
    tWP   =   55 ; tCW   =   70 ; tAW   =   70 ; tAS   =    0 ;
    tWR   =    0 ; tODW  =   35 ; tOEW  =    0 ; tDS   =   35 ;
    tDH   =    0 ; tBW   =   55 ;

  // reset timing variables
  rfA       = 0 ;
  rfDQ_LB   = 0 ;
  rfDQ_UB   = 0 ;
  rXCE      = 0 ;
  fXCE      = 0 ;
  rXWE      = 0 ;
  fXWE      = 0 ;
  rXLB      = 0 ;
  fXLB      = 0 ;
  rXUB      = 0 ;
  fXUB      = 0 ;
  rWR_LB    = 0 ;
  fWR_LB    = 0 ;
  rWR_UB    = 0 ;
  fWR_UB    = 0 ;
  rEN_WP_LB    = 0 ;
  fEN_WP_LB    = 0 ;
  rEN_WP_UB    = 0 ;
  fEN_WP_UB    = 0 ;
end

//////////////////////////////////////////////////////////////////////
//<< Bus Operation >>
//<Chip Enable>
always @( XCE1 or CE2 ) begin
  XCE = XCE1 | ~CE2 ;
end

//<Byte/Word Configuration>
assign EN_LB = XBYTE ? XLB : 1'b0 ;
assign EN_UB = XBYTE ? XUB : 1'b1 ;
assign SABUF = XBYTE ? 1'b0 : SA ;

//<Output Enable Contorl>
always @( XCE or XOE or XWE ) begin
  XCEorXOE = XCE | XOE | ~XWE ;
end
always @( XCEorXOE or EN_LB ) begin
  RD_LB = XCEorXOE | EN_LB ;
  -> DQ_OUTPUT ;
end
always @( XCEorXOE or EN_UB ) begin
  RD_UB = XCEorXOE | EN_UB ;
  -> DQ_OUTPUT ;
end

//<Write Enable Contorl>
always @( XCE or XWE ) begin
  XCEorXWE = XCE | XWE ;
end
always @( XCEorXWE or EN_LB ) begin
  WR_LB = XCEorXWE | EN_LB ;
end
always @( XCEorXWE or EN_UB ) begin
  WR_UB = XCEorXWE | EN_UB ;
end
always @( DQ ) begin
  DQ_LB = DQ[7:0] ;
  DQ_UB = DQ[15:8] ;
end

//--<< Write Operation >>-
always @( negedge EN_WP_LB ) begin : WRITE_LB
  reg [W-1:0] CURRENT_DATA ;
  if ( WR_LB == 1'b0 && EN_WP_LB == 1'b0 ) begin
   if ( rEN_WP_LB != fEN_WP_LB ) begin
      CURRENT_DATA = ARRAY[A] ;
    if ( ^DQ_LB === 1'b0 || ^DQ_LB === 1'b1 ) begin 
      if (SABUF==1'b0) ARRAY[A] = { CURRENT_DATA[15:8], DQ_LB } ;
      if (SABUF==1'b1) ARRAY[A] = { DQ_LB, CURRENT_DATA[7:0] } ;
    end
    else begin // invalid data
      //if (SABUF==1'b0) ARRAY[A] = { CURRENT_DATA[15:8], {8{1'bx}} } ;
      //if (SABUF==1'b1) ARRAY[A] = { {8{1'bx}}, CURRENT_DATA[7:0] } ;
    end
      -> ARRAY_event ;
   end
  end
end
always @( negedge EN_WP_UB ) begin : WRITE_UB
  reg [W-1:0] CURRENT_DATA ;
  if ( WR_UB == 1'b0 && EN_WP_UB == 1'b0 ) begin
   if ( rEN_WP_UB != fEN_WP_UB ) begin
      CURRENT_DATA = ARRAY[A] ;
    if ( ^DQ_UB === 1'b0 || ^DQ_UB === 1'b1 ) begin 
      ARRAY[A] = { DQ_UB, CURRENT_DATA[7:0] } ;
    end
    else begin // invalid data
      //ARRAY[A] = { {8{1'bx}}, CURRENT_DATA[7:0] } ;
    end
      -> ARRAY_event ;
   end
  end
end

//--<< Output Buffer >>--
always @( A or ARRAY_event ) begin
  OUTBUF = ARRAY[A] ;
  -> DQ_OUTPUT ;
end

//--<< Output Buffer Control >>--
always @( DQ_OUTPUT ) begin : OUTPUT
  //<<Low Byte>>
  //--< Disable Process >--
  if ( RD_LB == 1'b1 ) begin
    if ( OUT_HIZ_LB == 1'b1 ) begin
      oDQ[7:0] = {8{1'bx}} ; 
      OUT_CTL_LB = 1'b1 ;
    end
    else begin
      OUT_CTL_LB = 1'b0 ;
    end
  end
  //--< Enable Process >--
  else if ( RD_LB == 1'b0 && OUT_ACT==1'b0 && XLB_ACT==1'b0 ) begin
    //--< Output Delay >--
    if ( INVALID==1'b1 || AFTER_XLB==1'b1 ) begin
      if (OUT_HOLD==1'b0) begin
        oDQ[7:0] = {8{1'bx}} ; 
        OUT_CTL_LB = 1'b1 ;
      end
    end
    //--< Output Buffer Enable >--
    else begin
      if (SABUF==1'b0) oDQ[7:0] = OUTBUF[7:0] ;
      if (SABUF==1'b1) oDQ[7:0] = OUTBUF[15:8] ;
      OUT_CTL_LB = 1'b1 ;
    end
  end
  else begin
      OUT_CTL_LB = 1'b0 ;
  end
  //<<Upper Byte>>
  //--< Disable Process >--
  if ( RD_UB == 1'b1 ) begin
    if ( OUT_HIZ_UB == 1'b1 ) begin
      oDQ[15:8] = {8{1'bx}} ; 
      OUT_CTL_UB = 1'b1 ;
    end
    else begin
      OUT_CTL_UB = 1'b0 ;
    end
  end
  //--< Enable Process >--
  else if ( RD_UB == 1'b0 && OUT_ACT==1'b0 && XUB_ACT==1'b0 ) begin
    //--< Output Delay >--
    if ( INVALID==1'b1 || AFTER_XUB==1'b1 ) begin
      if (OUT_HOLD==1'b0) begin
        oDQ[15:8] = {8{1'bx}} ; 
        OUT_CTL_UB = 1'b1 ;
      end
    end
    //--< Output Buffer Enable >--
    else begin
      oDQ[15:8] = OUTBUF[15:8] ;
      OUT_CTL_UB = 1'b1 ;
    end
  end
  else begin
      OUT_CTL_UB = 1'b0 ;
  end
end  // always @( DQ_OUTPUT ) begin :C1_OUTPUT

//////////////////////////////////////////////////////////////////////
//--<< Write Enable >>--
always @( A or SABUF ) begin
  if( WP_A == 1'b0 ) begin
    WP_A = 1'b1 ;
  end
  else begin
    disable WRITE_A ;
    #(tAW) WP_A = 1'b0 ;
  end
end
always @( posedge WP_A ) begin : WRITE_A
  #(tAW) WP_A = 1'b0 ;
end

always @( negedge XCE ) begin
  if ( WP_XCE == 1'b0 ) begin
    WP_XCE = 1'b1 ;
  end
  else begin
    disable WRITE_XCE ;
    #(tCW) WP_XCE = 1'b0 ;
  end
end
always @( posedge WP_XCE ) begin : WRITE_XCE
  #(tCW) WP_XCE = 1'b0 ;
end

always @( negedge XWE ) begin
  if ( WP_XWE == 1'b0 ) begin
    WP_XWE = 1'b1 ;
  end
  else begin
    disable WRITE_XWE ;
    #(tWP) WP_XWE = 1'b0 ;
  end
end
always @( posedge WP_XWE ) begin : WRITE_XWE
  #(tWP) WP_XWE = 1'b0 ;
end

always @( negedge EN_LB ) begin
  if ( WP_XLB == 1'b0 ) begin
    WP_XLB = 1'b1 ;
  end
  else begin
    disable WRITE_XLB ;
    #(tBW) WP_XLB = 1'b0 ;
  end
end
always @( posedge WP_XLB ) begin : WRITE_XLB
  #(tBW) WP_XLB = 1'b0 ;
end

always @( negedge EN_UB ) begin
  if ( WP_XUB == 1'b0 ) begin
    WP_XUB = 1'b1 ;
  end
  else begin
    disable WRITE_XUB ;
    #(tBW) WP_XUB = 1'b0 ;
  end
end
always @( posedge WP_XUB ) begin : WRITE_XUB
  #(tBW) WP_XUB = 1'b0 ;
end

always @( DQ_LB ) begin
  if ( WP_DQ_LB == 1'b0 ) begin
    WP_DQ_LB = 1'b1 ;
  end
  else begin
    disable WRITE_DQ_LB ;
    #(tDS) WP_DQ_LB = 1'b0 ;
  end
end
always @( posedge WP_DQ_LB ) begin : WRITE_DQ_LB
  #(tDS) WP_DQ_LB = 1'b0 ;
end

always @( DQ_UB ) begin
  if ( WP_DQ_UB == 1'b0 ) begin
    WP_DQ_UB = 1'b1 ;
  end
  else begin
    disable WRITE_DQ_UB ;
    #(tDS) WP_DQ_UB = 1'b0 ;
  end
end
always @( posedge WP_DQ_UB ) begin : WRITE_DQ_UB
  #(tDS) WP_DQ_UB = 1'b0 ;
end

always @( WP_A or WP_DQ_LB or WP_XCE or WP_XWE or WP_XLB) begin
  EN_WP_LB = WP_A | WP_DQ_LB | WP_XCE | WP_XWE | WP_XLB ;
end
always @( WP_A or WP_DQ_UB or WP_XCE or WP_XWE or WP_XUB) begin
  EN_WP_UB =  WP_A | WP_DQ_UB | WP_XCE | WP_XWE | WP_XUB ;
end

//////////////////////////////////////////////////////////////////////
//--<< DQ Output delay >>--
always @( A or SABUF ) begin
  if( AFTER_A == 1'b0 ) begin
    AFTER_A = 1'b1 ;
    OUT_HOLD = 1'b1 ;
  end
  else begin
    disable DELAY_A ;
    #(tAA) AFTER_A = 1'b0 ;
  end
end
always @( posedge AFTER_A ) begin : DELAY_A
  #(tAA) AFTER_A = 1'b0 ;
end
always @( posedge AFTER_A ) begin
  #(tOH) OUT_HOLD = 1'b0 ;
  -> DQ_OUTPUT ;
end

always @( negedge XCE ) begin
  if ( AFTER_XCE == 1'b0 ) begin
    AFTER_XCE = 1'b1 ;
    XCE_ACT = 1'b1 ;
  end
  else begin
    disable DELAY_XCE ;
    #(tCOE) XCE_ACT = 1'b0 ;
    #(tCO1-tCOE) AFTER_XCE = 1'b0 ;
  end
end
always @( posedge AFTER_XCE ) begin : DELAY_XCE
  #(tCOE) XCE_ACT = 1'b0 ;
  #(tCO1-tCOE) AFTER_XCE = 1'b0 ;
end

always @( negedge XWE ) begin
  if ( XWE_ACT == 1'b0 ) begin
    XWE_ACT = 1'b1 ;
  end
  else begin
    disable DELAY_XWE_ACT ;
    #(tOEW) XWE_ACT = 1'b0 ;
  end
end
always @( posedge XWE_ACT ) begin : DELAY_XWE_ACT
  #(tOEW) XWE_ACT = 1'b0 ;
end

always @( posedge XWE ) begin
  if ( AFTER_XWE == 1'b0 ) begin
    AFTER_XWE = 1'b1 ;
  end
  else begin
    disable DELAY_XWE ;
    #(tOE) AFTER_XWE = 1'b0 ;
  end
end
always @( posedge AFTER_XWE ) begin : DELAY_XWE
  #(tOE) AFTER_XWE = 1'b0 ;
end

always @( negedge XOE ) begin
  if ( AFTER_XOE == 1'b0 ) begin
    AFTER_XOE = 1'b1 ;
    XOE_ACT = 1'b1 ;
  end
  else begin
    disable DELAY_XOE ;
    #(tOEE) XOE_ACT = 1'b0 ;
    #(tOE-tOEE) AFTER_XOE = 1'b0 ;
  end
end
always @( posedge AFTER_XOE ) begin : DELAY_XOE
  #(tOEE) XOE_ACT = 1'b0 ;
  #(tOE-tOEE) AFTER_XOE = 1'b0 ;
end

always @( negedge EN_LB ) begin
  if ( AFTER_XLB == 1'b0 ) begin
    XLB_ACT =1'b1 ;
    AFTER_XLB = 1'b1 ;
  end
  else begin
    disable DELAY_XLB ;
    #(tBE) XLB_ACT = 1'b0 ;
    #(tBA-tBE) AFTER_XLB = 1'b0 ;
  end
end
always @( posedge AFTER_XLB ) begin : DELAY_XLB
  #(tBE) XLB_ACT = 1'b0 ;
  #(tBA-tBE) AFTER_XLB = 1'b0 ;
end

always @( negedge EN_UB ) begin
  if ( AFTER_XUB == 1'b0 ) begin
    XUB_ACT =1'b1 ;
    AFTER_XUB = 1'b1 ;
  end
  else begin
    disable DELAY_XUB ;
    #(tBE) XUB_ACT = 1'b0 ;
    #(tBA-tBE) AFTER_XUB = 1'b0 ;
  end
end
always @( posedge AFTER_XUB ) begin : DELAY_XUB
  #(tBE) XUB_ACT = 1'b0 ;
  #(tBA-tBE) AFTER_XUB = 1'b0 ;
end

always @( XLB_ACT or XUB_ACT or AFTER_XLB or AFTER_XUB ) begin
  -> DQ_OUTPUT ;
end

//--<< Output to High-Z >>--
// tOD=tODO=tODW=tBD //
always @( posedge RD_LB ) begin
  OUT_HIZ_LB = 1'b1 ; 
end
always @( posedge RD_UB ) begin
  OUT_HIZ_UB = 1'b1 ; 
end
always @( posedge OUT_HIZ_LB ) begin
  #(tOD) OUT_HIZ_LB = 1'b0 ;
end
always @( posedge OUT_HIZ_UB ) begin
  #(tOD) OUT_HIZ_UB = 1'b0 ;
end

always @( OUT_HIZ_LB or OUT_HIZ_UB ) begin
  -> DQ_OUTPUT ;
end

//--<< Output to Active >>--
always @( XCE_ACT or XWE_ACT or XOE_ACT) begin
  if ( XCE_ACT | XWE_ACT | XOE_ACT) begin
    OUT_ACT = 1'b1 ;
  end
  else begin
    OUT_ACT = 1'b0 ;
  end
  -> DQ_OUTPUT ;
end

//--<< Output to Invalid Data >>--
always @( AFTER_A or AFTER_XCE or AFTER_XOE or AFTER_XWE ) begin
  if ( AFTER_A | AFTER_XCE | AFTER_XOE | AFTER_XWE ) begin
    INVALID = 1'b1 ;
  end
  else begin
    INVALID = 1'b0 ;
  end
  -> DQ_OUTPUT ;
end

//--<< I/O signal Operation time >>--
always @( A or SABUF ) begin
  rfA = $time ;
end

always @( DQ_LB ) begin
  rfDQ_LB = $time ;
end
always @( DQ_UB ) begin
  rfDQ_UB = $time ;
end

always @( XCE ) begin
  if ( XCE == 1'b1 ) begin
    rXCE = $time ;
  end
  else begin
    fXCE = $time ;
  end
end

always @( XWE ) begin
  if ( XWE == 1'b1 ) begin
    rXWE = $time ;
  end
  else begin
    fXWE = $time ;
  end
end

always @( EN_LB ) begin
  if ( XLB == 1'b1 ) begin
    rXLB = $time ;
  end
  else begin
    fXLB = $time ;
  end
end
always @( EN_UB ) begin
  if ( XUB == 1'b1 ) begin
    rXUB = $time ;
  end
  else begin
    fXUB = $time ;
  end
end

always @( WR_LB ) begin
  if ( WR_LB == 1'b1 ) begin
    rWR_LB = $time ;
  end
  else begin
    fWR_LB = $time ;
  end
end
always @( WR_UB ) begin
  if ( WR_UB == 1'b1 ) begin
    rWR_UB = $time ;
  end
  else begin
    fWR_UB = $time ;
  end
end

always @( EN_WP_LB ) begin
  if ( EN_WP_LB == 1'b0 ) begin
    fEN_WP_LB = $time ;
  end
  else begin
    rEN_WP_LB = $time ;
  end
end
always @( EN_WP_UB ) begin
  if ( EN_WP_UB == 1'b0 ) begin
    fEN_WP_UB = $time ;
  end
  else begin
    rEN_WP_UB = $time ;
  end
end

//--<< AC Characteristics >>--
//--< Write Pulse width (write cycle) >--
always @( posedge WR_LB ) begin : WRITE_PULSE_L
  reg wflag ;
  wflag=1'b0 ;
  if ( $time > 0 && ( rWR_LB != fWR_LB ) ) begin
     // WE pulse
    if ( ( $time - fXWE ) < tWP && rXWE == $time ) begin
        $write("%t : 2010 /WE Pulse width (tWP) was not suitable.\n", $time) ;
        wflag=1'b1 ;
    end
    // CE pulse
    if ( ( $time - fXCE ) < tCW && rXCE == $time ) begin
        $write("%t : 2020 Chip Enable to End of Write (tCW) was not suitable.\n", $time) ;
        wflag=1'b1 ;
    end
    // LB pulse
    if ( ( $time - fXLB ) < tBW && rXLB == $time ) begin
        $write("%t : 2030 /LB Pulse to End of Write (tRW) was not suitable.\n", $time) ;
        wflag=1'b1 ;
    end
    // Write pulse
    if ( ($time - fWR_LB) < tWP && wflag == 1'b0 ) begin
        $write("%t : 2050 Write Pulse width (tWP) was not suitable.\n", $time) ;
    end
  end
end
always @( posedge WR_UB ) begin : WRITE_PULSE_U
  reg wflag ;
  wflag=1'b0 ;
  if ( $time > 0 && ( rWR_UB != fWR_UB ) ) begin
     // WE pulse
    if ( ( $time - fXWE ) < tWP && rXWE == $time ) begin
      if ( rWR_LB!=rWR_UB || fWR_LB!=fWR_UB )
        $write("%t : 2010 /WE Pulse width (tWP) was not suitable.\n", $time) ;
        wflag=1'b1 ;
    end
    // CE pulse
    if ( ( $time - fXCE ) < tCW && rXCE == $time ) begin
      if ( rWR_LB!=rWR_UB || fWR_LB!=fWR_UB )
        $write("%t : 2020 Chip Enable to End of Write (tCW) was not suitable.\n", $time) ;
        wflag=1'b1 ;
    end
    // UB pulse
    if ( ( $time - fXUB ) < tBW && rXUB == $time ) begin
        $write("%t : 2040 /UB Pulse to End of Write (tRW) was not suitable.\n", $time) ;
        wflag=1'b1 ;
    end
    // Write pulse
    if ( ($time - fWR_UB) < tWP && wflag == 1'b0 ) begin
      if ( rWR_LB!=rWR_UB || fWR_LB!=fWR_UB )
        $write("%t : 2050 Write Pulse width (tWP) was not suitable.\n", $time) ;
    end
  end
end

//--< Write Recover time (write cycle) >--
always @( A ) begin
  if ( $time > 0 && ( ( $time-rWR_LB ) < tWR | ( $time-rWR_UB ) < tWR ) ) begin
    $write("%t : 2070 Write Recover Time (tWR) was not suitable.\n", $time) ;
  end
end

//--< Address Setup time (write cycle) >--
always @( negedge WR_LB or negedge WR_UB ) begin
  if ( $time > 0 &&  ( $time - rfA ) < tAS ) begin
    $write("%t : 2080 Address Setup Time (tAS) was not suitable.\n", $time) ;
  end
end

//--< Address valid (write cycle) >--
//--< Data Setup Time (write cycle) >--
always @( posedge WR_LB ) begin
  if ( rWR_LB!=fWR_LB ) begin
    if ( $time > 0 &&  ( $time - rfA ) < tAW ) begin
      $write("%t : 2060 Address valid to END of Write (tAW) was not suitable.\n", $time) ;
    end
    if ( $time > 0 &&  ( $time - rfDQ_LB ) < tDS ) begin
      $write("%t : 2090 Data Setup Time (tDS) was not suitable.\n", $time) ;
    end
  end
end
always @( posedge WR_UB ) begin
  if ( rWR_UB!=fWR_UB ) begin
    if ( $time > 0 &&  ( $time - rfA ) < tAW ) begin
      if ( rWR_LB!=rWR_UB || fWR_LB!=fWR_UB )
        $write("%t : 2060 Address valid to END of Write (tAW) was not suitable.\n", $time) ;
    end
    if ( $time > 0 &&  ( $time - rfDQ_UB ) < tDS ) begin
      if ( rWR_LB!=rWR_UB || rfDQ_LB!=rfDQ_UB )
        $write("%t : 2090 Data Setup Time (tDS) was not suitable.\n", $time) ;
    end
  end
end

//--< Data Hold Time (write cycle) >--
always @( DQ_LB ) begin
  if ( $time > 0 &&  ( $time - rWR_LB ) < tDH ) begin
    $write("%t : 2100 Data Hold Time (tDH) was not suitable.\n", $time) ;
  end
end
always @( DQ_UB ) begin
  if ( $time > 0 &&  ( $time - rWR_UB ) < tDH ) begin
    $write("%t : 2100 Data Hold Time (tDH) was not suitable.\n", $time) ;
  end
end

//--< OE,WE falling Check (write cycle) >--
always @( negedge XCE or negedge XWE or negedge XOE ) begin
  if ( XCE == 1'b0 && XWE == 1'b0 && XOE == 1'b0 ) begin
   if ( RD_LB==1'b0 || RD_UB==1'b0 )
    $write("%t : 2110 /WE and /OE were 'Low' at sametime.\n", $time) ;
  end
end

//////////////////////////////////////////////////////////////////////

endmodule
//`endprotect
`endcelldefine
