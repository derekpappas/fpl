//THE `PROTECT `ENDPROTECT DIRECTIVES HAVE BEEN COMMENTED

///////////////////////////////////////////////////////////////////////////
// NOR-type Flash Memory                                                 //
// MBM29LV008TA/BA (1Mx8, boot block)                                    //
// Verilog Simulation Model                                              // 
// Version: 1.1                                                          //
// Date: 2000/03/07                                                      //
// Designed by FUJITSU                                                   //
// module : MBM29LV008A                                                  //
//                                                                       //
//   Copyright (c) FUJITSU LIMITED, 1999.                                //
//   All Rights Reserved. Licensed Library.                              //
///////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ns

`celldefine
module MBM29LV008A(
  A,      // Address Input
  DQ,     // Data Input/Output
  XCE,    // Chip Enable Input
  XOE,    // Output Enable Input
  XWE,    // Write Enable Input
  XRESET, // Hard Reset Input
  RY_XBY  // Ready/Busy Output
);

// External Parameter
parameter SP_VER  = "SP90" ; // Speed Version SP70,SP90,SP120
parameter ERR_FLG = 0      ; // Error Flag  0:Normal, 1:Error
parameter B_TYPE  = "TOP"  ; // Block Type  0:Top, 1:Bottom

//////////////////////////////////////////////////////////////////////
//`protect
//////////////////////////////////////////////////////////////////////
// History                                                          //
//                         : 0.01  1999/09/27 LV016 -> LV008A modify//
// ==> m_lv008a.v 1st Release                                       //
//                         : 1.0   1999/10/01                       //
//                         : 1.0a  1999/11/22 data latch modify     //
//                         : 1.1   2000/03/07 modify toggle bit2    //
//////////////////////////////////////////////////////////////////////
// pin width
  parameter AB=20 ; // Address Bus width
  parameter SAB=7 ; // Sector Address Bus width
  parameter W=8 ; // Data Bus width
  parameter SA=10 ;

  input [AB-1:0] A ;
  inout [W-1:0]  DQ ;
  input XCE,XOE,XWE,XRESET ;
  output RY_XBY ;

// Architecture
parameter NUM_OF_ADDR  = 1<<(AB) ; // 2**(AB)  -- AB=20
parameter NUM_OF_SECTOR = (1<<(SAB-3))-1 + 4 ; // 2**(SAB-3)+3  -- SAB=7 -> 19
parameter NUM_OF_BOOT = (1<<3) -4 ; // 2**3-4 -> 4 // Number of boot Sector

// protect
parameter PROTECT_STATUS = {NUM_OF_SECTOR{1'b0}} ; // 0:unprotect, 1:protect

// command
parameter ADDR_PAT1 = 11'b10101010101 ; // 555h
parameter ADDR_PAT2 = 11'b01010101010 ; // 2AAh
parameter DATA_PAT1 = 8'b10101010 ;      //  AAh
parameter DATA_PAT2 = 8'b01010101 ;      //  55h

parameter      RESET_CMD = 8'b11110000 ; // F0h
parameter         AS_CMD = 8'b10010000 ; // 90h
parameter    PROGRAM_CMD = 8'b10100000 ; // A0h
parameter  ERS_SETUP_CMD = 8'b10000000 ; // 80h
parameter SECTOR_ERS_CMD = 8'b00110000 ; // 30h
parameter   CHIP_ERS_CMD = 8'b00010000 ; // 10h
parameter    SUSPEND_CMD = 8'b10110000 ; // B0h
parameter     RESUME_CMD = 8'b00110000 ; // 30h
parameter       FAST_CMD = 8'b00100000 ; // 20h

parameter MANUFAC_ADDR = 8'b00000000 ; // 00h
parameter DEVICE_ADDR  = 8'b00000001 ; // 01h
parameter PROTECT_ADDR = 8'b00000010 ; // 02h

// <<Program/Erase Operations>>
parameter PGMS_TIME = 8000 ; // 8us (byte mode)
parameter SERS_TIME = 1000000000 ; // 1sec
parameter TIMEOUT = 50000 , // 50us
          tSUSPEND = 20000 ; // 20us
parameter tPROTECT = 250000 ; // 250us
parameter tPROTECT_PGM = 1000 , // 1us
          tPROTECT_ERS = 100000 ; // 100us

// state
parameter STAT_RESET         = 5'b00000 ; // 00h
parameter STAT_PZ1           = 5'b00001 ; // 01h
parameter STAT_PREL          = 5'b00010 ; // 02h
parameter STAT_C8            = 5'b00011 ; // 03h
parameter STAT_C8_PZ1        = 5'b00100 ; // 04h
parameter STAT_C8_PREL       = 5'b00101 ; // 05h
parameter STAT_PGM_SETUP     = 5'b01000 ; // 08h
parameter STAT_PGMS          = 5'b01001 ; // 09h
parameter STAT_PGMS_END      = 5'b01010 ; // 0Ah
parameter STAT_PGMS_HANG     = 5'b01011 ; // 0Bh
parameter STAT_AS            = 5'b01100 ; // 0Ch
parameter STAT_AS_INVALID    = 5'b01101 ; // 0Dh
parameter STAT_ERS           = 5'b10000 ; // 10h
parameter STAT_ERS_END       = 5'b10001 ; // 11h
parameter STAT_ERASE_HANG    = 5'b10010 ; // 12h
parameter STAT_SERS_TIMEOUT  = 5'b10100 ; // 14h
parameter STAT_SERS_START    = 5'b10101 ; // 15h
parameter STAT_SERS          = 5'b10110 ; // 16h
parameter STAT_SERS_END      = 5'b10111 ; // 17h
parameter STAT_ERASE_SUSPEND = 5'b11000 ; // 18h
parameter STAT_FAST_MODE     = 5'b11001 ; // 19h

//////////////////////////////////////////////////////////////////////
// register declaration
//   wdt  name         addr
reg [W-1:0] FARRAY [NUM_OF_ADDR-1:0] ;
reg [4:0] FSTATE, FSTATE_next, FSTATE_PGM_next ;
reg [4:0] FSTATE_tWHWH2_next, FSTATE_ERS_next ;
reg [AB-1:0] ABUF ;
reg [SA:0] FADDR ;
reg [W-1:0] FDATA, LATCH_DATA ;
reg [W-1:0] DINBUF ;
reg ESP ;
integer TIMER ;
reg [SAB-1:0] ESA ;
reg TOGGLE ;
reg XCEorXOE, XCEorXWE ;
reg AFTER_A, AFTER_XCE, AFTER_XOE ;
reg AFTER_XRESET ;
reg OUT_HOLD, OUT_HIZ ;
reg INVALID ;
reg FT_MODE ;
time tWHWH1, tWHWH2 ;
reg HIT_ESA, EN_PROTECT;
reg [NUM_OF_SECTOR-1:0] SEL ;
reg RSEL, ASEL ;
reg [NUM_OF_SECTOR-1:0] PROTECT_REG ;
reg INV_ADD ;
reg PGM_FLG ;
reg ATD ;

reg [15:0] MANUFAC_CODE ;
reg [15:0] DEV_CODE ;
integer ISA, ISB ;
integer SEL_BIT ;
reg [SAB-1:0] BOOT_ADD ;
integer ISN1, ISN2 ;
reg [7:0] BSA [NUM_OF_BOOT-1:0] ;

time tACC, tCE, tOE, tDF, tOH, tREADY ;
time tAS, tAH, tDS, tDH, tOEH_READ, tOEH_POLLING, tGHWL, tWP, tWPH,
     tCP, tCPH, tRP, tRH, tBUSY, tOES, tGHEL, tEOE ;

time rfA, rfDQ, rXCE, fXCE, rXOE, fXOE, rXWE, fXWE,
     rXRESET, fXRESET, rXCEorXWE, fXCEorXWE, rXCEorXOE,
     fXCEorXOE, EMB_TIME ;

event DQ_OUTPUT ;
event TIMER_INC ;
event FSTATE_event ;
event FSTATE_PGM_event ;
event FSTATE_tWHWH2_event ;
event FSTATE_tREADY_event ;
event FSTATE_SERS_TIMEOUT_event ;
event RY_XBY_tBUSY ;
event FSTATE_RESET_event ;
event INV_ADD_event ;
event LATCH_DATA_event ;

reg RY_XBY ;

reg [W-1:0] OUTBUF ;
//////////////////////////////////////////////////////////////////////
reg [W-1:0] oDQ ;
reg OUT_CTL ;
assign DQ = OUT_CTL ? oDQ : {W{1'bz}} ;
//////////////////////////////////////////////////////////////////////

initial begin : memory_initialize
  integer i ;
  for( i=0 ; i < NUM_OF_ADDR  ; i=i+1 ) FARRAY[i] = {W{1'b1}} ;
end

initial begin : dependent_init
  PROTECT_REG = PROTECT_STATUS ;
  FSTATE = STAT_RESET ;
  FSTATE_next = STAT_RESET ;
  FADDR = 0 ;
  OUTBUF = {W{1'bx}} ;
  ESP = 0 ;
  TIMER = 0 ;
  TOGGLE = 1 ;
  XCEorXOE = 1 ;
  XCEorXWE = 1 ;
  AFTER_A = 0 ;
  AFTER_XCE = 0 ;
  AFTER_XOE = 0 ;
  AFTER_XRESET = 0 ;
  OUT_HIZ = 0 ;
  OUT_HOLD = 0 ;
  INVALID = 0 ;
  FT_MODE = 0 ;
  tWHWH1 = PGMS_TIME ;
  HIT_ESA = 0 ;
  SEL = 0 ;
  RSEL = 0 ;
  ASEL = 0 ;
  RY_XBY = 1'bz ;
  PGM_FLG = 1'b0 ;
  ATD = 1'b0 ;

  MANUFAC_CODE = 8'b00000100 ; // 04h

  // dependent on Block Type
  if( B_TYPE == "TOP" ) begin  // Top
    DEV_CODE = 8'b00111110 ; // 3Eh
    BOOT_ADD = {SAB{1'b1}} ; 
    BSA[0]   = 8'b1111111X ;
    BSA[1]   = 8'b11111101 ;
    BSA[2]   = 8'b11111100 ;
    BSA[3]   = 8'b111110XX ;
    ISN1 = NUM_OF_SECTOR-1 ;
    ISN2 = 0 ;
  end
  else begin // Bottom
    DEV_CODE = 8'b00110111 ; // 37h
    BOOT_ADD = {SAB{1'b0}} ; 
    BSA[0]   = 8'b0000000X ;
    BSA[1]   = 8'b00000010 ;
    BSA[2]   = 8'b00000011 ;
    BSA[3]   = 8'b000001XX ;
    ISN1 = 0 ;
    ISN2 = NUM_OF_BOOT-1 ;
  end

  // Timing Parameter
  if ( SP_VER == "SP70" ) begin 
    //--<Read Cycle Operation >>
    tACC   =    70 ; tCE    =    70 ; tOE    =    30 ; 
    tDF    =    25 ; tOH    =     0 ; tREADY = 20000 ; // 20 us
    //--<Write Cycle Operation >>
    tAS    =     0 ; tAH    =    45 ; tDS    =    35 ; tDH    =     0 ;
    tOEH_READ =  0 ; tOEH_POLLING = 10 ; tGHWL  =     0 ;
    tWP    =    35 ; tWPH   =    25 ; tCP    =    35 ; tCPH   =    25 ;
    tRP    =   500 ; tRH    =   200 ; tBUSY  =    90 ; 
    tOES   =     0 ; tGHEL  =     0 ; tEOE   =    30 ;
  end
  else if ( SP_VER == "SP90" ) begin 
    //--<Read Cycle Operation >>
    tACC   =    90 ; tCE    =    90 ; tOE    =    35 ; 
    tDF    =    30 ; tOH    =     0 ; tREADY = 20000 ; // 20 us
    //--<Write Cycle Operation >>
    tAS    =     0 ; tAH    =    45 ; tDS    =    45 ; tDH    =     0 ;
    tOEH_READ =  0 ; tOEH_POLLING = 10 ; tGHWL  =     0 ;
    tWP    =    45 ; tWPH   =    25 ; tCP    =    45 ; tCPH   =    25 ;
    tRP    =   500 ; tRH    =   200 ; tBUSY  =    90 ;
    tOES   =     0 ; tGHEL  =     0 ; tEOE   =    35 ;
  end
  else if ( SP_VER == "SP120" ) begin 
    //--<Read Cycle Operation >>
    tACC   =   120 ; tCE    =   120 ; tOE    =    50 ; 
    tDF    =    30 ; tOH    =     0 ; tREADY = 20000 ; // 20 us
    //--<Write Cycle Operation >>
    tAS    =     0 ; tAH    =    50 ; tDS    =    50 ; tDH    =     0 ;
    tOEH_READ =  0 ; tOEH_POLLING = 10 ; tGHWL  =     0 ;
    tWP    =    50 ; tWPH   =    30 ; tCP    =    50 ; tCPH   =    30 ;
    tRP    =   500 ; tRH    =   200 ; tBUSY  =    90 ;
    tOES   =     0 ; tGHEL  =     0 ; tEOE   =    50 ;
  end
  else begin
    $write("Speed Version '%s' was not suitable.\n",SP_VER) ;
    $finish ;
  end

  // reset timing variables
  rfA       = 0 ;
  rXCE      = 0 ;
  fXCE      = 0 ;
  rXOE      = 0 ;
  fXOE      = 0 ;
  rXWE      = 0 ;
  fXWE      = 0 ;
  rXRESET   = 0 ;
  fXRESET   = 0 ;
  rXCEorXWE = 0 ;
  fXCEorXWE = 0 ;
  rXCEorXOE = 0 ;
  fXCEorXOE = 0 ;
  EMB_TIME   = 0 ;
end

//////////////////////////////////////////////////////////////////////
//<< Toggle Bit Operation >>
always @( XCE or XOE ) begin
  XCEorXOE = XCE | XOE ;
end

always @(posedge XCEorXOE or EMB_TIME ) begin
  if( FSTATE==STAT_PGMS          || FSTATE==STAT_PGMS_HANG
   || FSTATE==STAT_SERS_TIMEOUT  || FSTATE==STAT_SERS_START
   || FSTATE==STAT_SERS          || FSTATE==STAT_ERASE_HANG ) begin
    TOGGLE = ~ TOGGLE ;
  end
  else if(FSTATE==STAT_ERASE_SUSPEND) begin
    if( HIT_ESA==1'b1 ) TOGGLE = ~ TOGGLE ;
  end
  else begin
    TOGGLE = 1 ;
  end
end

//<< Address latch >>
always @( XCE or XWE or XOE ) begin
  XCEorXWE = (XCE | XWE) | (~ XOE) ;
end

always @(negedge XCEorXWE ) begin
  FADDR = A[SA:0] ; // Command address buffer
  ABUF = A ; // Address buffer (program/erase)
end

//<< Data latch >>
always @( DQ or negedge XCEorXWE ) begin
  if ( XCEorXWE == 1'b0 ) begin
    #(tDS) DINBUF = DQ ;
  end
end

//--<< Main Process >>--

//--< Program Operation >--
task PROGRAM ;
    inout [W-1:0] ARRAY_DATA ;
    input [W-1:0] PGM_DATA ;
    input XFLG ;
    reg [W-1:0] CURRENT_DATA ;
    reg VALID_DATA ;
  begin
    CURRENT_DATA = PGM_DATA ;
    VALID_DATA = ^ARRAY_DATA ;

    if ( XFLG == 1'b1 ) begin
      ARRAY_DATA = CURRENT_DATA ;
    end
    else if ( VALID_DATA === 1'bX ) begin
      PGM_FLG = 1'bX ;
    end
    else begin
      ARRAY_DATA = ARRAY_DATA & CURRENT_DATA ;
      if ( ( ARRAY_DATA & CURRENT_DATA ) != CURRENT_DATA ) begin
        PGM_FLG = 1'b1 ;
      end
      else begin
        PGM_FLG = 1'b0 ;
      end
    end
  end
endtask 

//--< Sector Earse Address set >--
task SADD_SET ;
    input sel_sec ;
    integer sel_sec, sel_num ;
    reg [7:0] badd ;
  begin
    if( B_TYPE=="TOP" ) sel_num = NUM_OF_SECTOR-1-sel_sec ;
    else                sel_num = sel_sec ;

    if( sel_num <= NUM_OF_BOOT-1 ) begin // Boot sector
      badd = BSA[sel_num] ;
      if ( sel_num == 0 ) begin
          ISA = { badd[SAB-1:1], {AB-SAB+1{1'b0}} } ;
          ISB = 2*( 1<<(AB-SAB) ) -1 ; // 16K byte
          tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 2*(1<<(AB-SAB)) ;
      end
      else if ( sel_num == 3 ) begin
          ISA = { badd[SAB-1:2], {AB-SAB+2{1'b0}} } ;
          ISB = 4*( 1<<(AB-SAB) ) -1 ; // 32K byte
          tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 4*(1<<(AB-SAB)) ;
      end
      else begin
          ISA = { badd[SAB-1:0], {AB-SAB{1'b0}} } ;
          ISB = 1*( 1<<(AB-SAB) ) -1 ; // 8K byte
          tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 1*(1<<(AB-SAB)) ;
      end
    end
    else begin // Normal sector
        ISA = ( sel_sec - ISN2 ) * ( 1<<(AB-SAB+3) ) ;
        ISB = 8*( 1<<(AB-SAB) ) -1 ; // 64K byte
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 8*(1<<(AB-SAB)) ;
    end
  end 
endtask


//--< Hardware Reset Operation >--
always @(negedge XRESET) begin :C1_XRESET
  integer i,j ;
  reg [W-1:0] CURRENT_DATA ;
  if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG )
  begin
    if ( PROTECT_REG[SEL_BIT] == 1'b0 ) begin
        PROGRAM( FARRAY[ABUF], {W{1'bx}}, 1 ) ;
    end
    -> FSTATE_tREADY_event ;
    disable C1_FSTATE_PGM_event ;
    $write("%t : 1440 Hardware Reset during Program.\n", $time) ;
  end
  else if ( FSTATE==STAT_SERS_START || FSTATE==STAT_SERS
         || FSTATE==STAT_SERS_END || FSTATE==STAT_ERASE_HANG
         || FSTATE==STAT_ERS ) begin
    for ( i=0 ; i<= NUM_OF_SECTOR -1 ; i=i+1 ) begin
        SADD_SET( i ) ;
      if( SEL[i]==1'b1 && PROTECT_REG[i]==1'b0 ) begin
            for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'bx}} ;
      end
    end // for ( i=0 ; i<= NUM_OF_SECTOR ; i=i+1 )
    -> FSTATE_tREADY_event ;
    disable C1_FSTATE_tWHWH2_event ;
    $write("%t : 1450 Hardware Reset during Erase.\n", $time) ;
  end
  else begin
    FSTATE = STAT_RESET ;
    disable C1_FSTATE_SERS_TIMEOUT ;
  end
end // always @(negedge XRESET) begin

always @( FSTATE_tREADY_event ) begin :C1_XRESET_tREADY
  #tREADY ;
  FSTATE = STAT_RESET ;
end

//--<< Staus transition Operation (WE or CE rising edge) >>--
always @(posedge XCEorXWE) begin :C1_XCEorXWE
  case ( FSTATE )
    STAT_RESET : begin
        if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end  // STAT_RESET
    STAT_PZ1 : begin
        if ( ( FADDR[SA:0] == ADDR_PAT2[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT2 ) ) begin
          FSTATE = STAT_PREL ;
        end
        else if ( DINBUF[7:0] == RESUME_CMD && ESP==1'b1 ) begin
          FSTATE = STAT_SERS_START ;
          ESP = 1'b0 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_PZ1
    STAT_PREL : begin
        if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == ERS_SETUP_CMD ) && ( ESP == 1'b0 ) ) begin
          FSTATE = STAT_C8 ;
        end
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == PROGRAM_CMD ) ) begin
          FSTATE = STAT_PGM_SETUP ;
        end
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == AS_CMD ) ) begin
          FSTATE = STAT_AS ;
        end
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == FAST_CMD ) && ( ESP == 1'b0 ) ) begin
          FSTATE = STAT_FAST_MODE ;
          FT_MODE = 1'b1 ;
        end
        else if ( DINBUF[7:0] == RESUME_CMD && ESP==1'b1 ) begin
          FSTATE = STAT_SERS_START ;
          ESP = 1'b0 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_PREL
    STAT_C8 : begin
        if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_C8_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_C8
    STAT_C8_PZ1 : begin
        if ( ( FADDR[SA:0] == ADDR_PAT2[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT2 ) ) begin
          FSTATE = STAT_C8_PREL ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_C8_PZ1
    STAT_C8_PREL : begin
        if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == CHIP_ERS_CMD ) ) begin
          FSTATE = STAT_ERS ;
        end
        else if ( DINBUF[7:0] == SECTOR_ERS_CMD ) begin
          FSTATE = STAT_SERS_TIMEOUT ;
          RSEL = 1'b1 ;
          ESA = ABUF[AB-1:AB-SAB] ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_C8_PREL
    STAT_AS : begin
        if ( DINBUF[7:0] == RESET_CMD || DINBUF[7:0] == {8{1'b0}} ) begin
          if ( ESP == 1'b1 ) begin
            FSTATE = STAT_ERASE_SUSPEND ;
          end
          else begin
            FSTATE = STAT_RESET ;
          end
        end
        else begin
          FSTATE = STAT_AS_INVALID ;
          $write("%t : 1350 Invalid Command. Write Reset Command.\n", $time) ;
        end
      end // STAT_AS
    STAT_AS_INVALID : begin
        if ( DINBUF[7:0] == RESET_CMD ) begin
          if ( ESP == 1'b1 ) begin
            FSTATE = STAT_ERASE_SUSPEND ;
          end
          else begin
            FSTATE = STAT_RESET ;
          end
        end
        else begin
          $write("%t : 1390 Command was ignored. Write Reset Command.\n", $time) ;
        end
      end // STAT_AS_INVALID
    STAT_FAST_MODE : begin
        if ( DINBUF[7:0] == PROGRAM_CMD ) begin
          FSTATE = STAT_PGM_SETUP ;
        end
        else if ( DINBUF[7:0] == AS_CMD ) begin
          FSTATE = STAT_AS ;
          FT_MODE = 1'b0 ;
        end
        else begin
          $write("%t : 1380 Command was ignored during Fast Mode.\n", $time) ;
        end
      end // STAT_FAST_MODE
    STAT_PGM_SETUP : begin
        FSTATE = STAT_PGMS ;
        FDATA = DINBUF ;
      end // STAT_PGM_SETUP
    STAT_PGMS : begin
        $write("%t : 1360 Command was ignored during Program.\n", $time) ;
      end // STAT_PGMS
    STAT_PGMS_END : begin
      end // STAT_PGMS_END
    STAT_PGMS_HANG : begin
        if ( DINBUF[7:0] == RESET_CMD ) begin
          FSTATE = STAT_PGMS_END ;
        end
        else begin
          $write("%t : 1390 Command was ignored. Write Reset Command.\n", $time) ;
        end
      end // STAT_PGMS_HANG
    STAT_ERS : begin
      end // STAT_ERS
    STAT_ERS_END : begin
      end // STAT_ERS_END
    STAT_ERASE_HANG : begin
        if ( DINBUF[7:0] == RESET_CMD ) begin
          FSTATE = STAT_SERS_END ;
        end
        else begin
          $write("%t : 1390 Command was ignored. Write Reset Command.\n", $time) ;
        end
      end // STAT_ERASE_HANG
    STAT_SERS_TIMEOUT : begin
        if ( DINBUF[7:0] == SECTOR_ERS_CMD ) begin
          FSTATE = STAT_SERS_TIMEOUT ;
          ESA = ABUF[AB-1:AB-SAB] ;
        end
        else if ( DINBUF[7:0] == SUSPEND_CMD ) begin
            FSTATE = STAT_ERASE_SUSPEND ;
            ESP = 1'b1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_SERS_TIMEOUT
    STAT_SERS_START : begin
      end // STAT_SERS_START
    STAT_SERS : begin
        if ( DINBUF[7:0] == SUSPEND_CMD && ASEL == 1'b0 ) begin
          #tSUSPEND FSTATE = STAT_ERASE_SUSPEND ;
          ESP = 1'b1 ;
        end
        else begin
          $write("%t : 1370 Command was ignored during Erase.\n", $time) ;
        end
      end // STAT_SERS
    STAT_SERS_END : begin
      end // STAT_SERS_END
    STAT_ERASE_SUSPEND : begin
        if ( DINBUF[7:0] == RESUME_CMD ) begin
          FSTATE = STAT_SERS_START ;
          ESP = 1'b0 ;
        end
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_ERASE_SUSPEND
  endcase
end // always @(posedge XCEorXWE) begin

//--<<Reset command Status >>--
always @( FSTATE_RESET_event ) begin
  if( ESP == 1'b1 ) begin
    FSTATE = STAT_ERASE_SUSPEND ;
    if ( DINBUF[7:0] !== RESET_CMD ) 
      $write("%t : 1340 Invalid Command. Return to Suspend Read Mode.\n", $time) ;
  end
  else begin
    FSTATE = STAT_RESET ;
    if ( DINBUF[7:0] !== RESET_CMD ) 
      $write("%t : 1330 Invalid Command. Return to Read Mode.\n", $time) ;
  end
end

//--<< Status Transition Process >>--
always @( FSTATE ) begin :C1_FSTATE
  integer i,j ;
  reg VALUE_CARRAY, VALUE_FDATA ;
  reg [W-1:0] CURRENT_DATA ;

  case ( FSTATE )
    STAT_RESET : begin
        tWHWH2 = 0 ;
        RSEL = 1'b0 ;
        ASEL = 1'b0 ;
        ESP  = 1'b0 ;
        FT_MODE = 1'b0 ;
      end // STAT_RESET
    STAT_PGMS : begin
        SELECT_BIT( ABUF[AB-1:AB-SAB] ) ;
        if ( INV_ADD == 1'b1 ) begin
            FSTATE_next = STAT_PGMS_END ;
            -> FSTATE_event ;
            $write("%t : 1410 Program was ignored. Invalid Address has been selected.\n", $time) ;
        end
        else if ( PROTECT_REG[SEL_BIT] == 1'b1 ) begin
          tWHWH1 = tPROTECT_PGM ;
          FSTATE_PGM_next = STAT_PGMS_END ;
          -> FSTATE_PGM_event ;
          $write("%t : 1460 Program was ignored. Protected Sector has been selected.\n", $time) ;
        end
        else if ( SEL[SEL_BIT] == 1'b1 ) begin
            FSTATE_next = STAT_PGMS_END ;
            -> FSTATE_event ;
            $write("%t : 1400 Program Command was ignored. Suspended Sector has been selected.\n", $time) ;
        end
        else if ( ERR_FLG == 1'b1 ) begin
            PROGRAM( FARRAY[ABUF], {W{1'bx}}, 1 ) ;
            FSTATE_PGM_next = STAT_PGMS_HANG ;
            -> FSTATE_PGM_event ;
        end
        else begin
            PROGRAM( FARRAY[ABUF], FDATA, 0 ) ;

            if ( PGM_FLG === 1'b0 ) begin
                FSTATE_PGM_next = STAT_PGMS_END ;
                -> FSTATE_PGM_event ;
                if ( ^FDATA === 1'bX ) begin
                  $write("%t : 1320 Invalid Data was programmed.\n", $time) ;
                end
            end
            else if ( PGM_FLG === 1'b1 ) begin
                FSTATE_PGM_next = STAT_PGMS_HANG ;
                -> FSTATE_PGM_event ;
                $write("%t : 1430 Program was hanguped. Data will be programmed 0 to 1.\n", $time) ;
            end
            else begin
                FSTATE_PGM_next = STAT_PGMS_HANG ;
                -> FSTATE_PGM_event ;
                $write("%t : 1420 Program was hanguped. Invalid Data has been selected\n", $time) ;
            end
        end
      end // STAT_PGMS
    STAT_PGMS_END : begin
        EMB_TIME = $time ;
        if ( ESP == 1'b1 ) begin
          FSTATE_next = STAT_ERASE_SUSPEND ;
          -> FSTATE_event ;
        end
        else if ( FT_MODE == 1'b1 ) begin
          FSTATE_next = STAT_FAST_MODE ;
          -> FSTATE_event ;
        end
        else begin
          FSTATE_next = STAT_RESET ;
          -> FSTATE_event ;
        end
      end // STAT_PGMS_END
    STAT_ERS : begin
        ASEL = 1'b1 ;
        FSTATE_next = STAT_SERS_START ;
        -> FSTATE_event ;
      end // STAT_ERS
    STAT_SERS_TIMEOUT : begin
        -> FSTATE_SERS_TIMEOUT_event ;
      end
    STAT_SERS_START : begin
        tWHWH2 = 0 ;
        FSTATE_next = STAT_SERS ;
        -> FSTATE_event ;
      end // STAT_SERS_START
    STAT_SERS : begin
        for ( i=0 ; i<= NUM_OF_SECTOR -1 ; i=i+1 ) begin
          if( SEL[i]==1'b1 && PROTECT_REG[i]==1'b0 ) begin
              SADD_SET( i ) ;
               if ( ERR_FLG==1'b1 )
                 for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'bx}} ;
               else
                 for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'b1}} ;
          end
        end // for ( i=0 ; i<= NUM_OF_SECTOR ; i=i+1 )
        if ( tWHWH2 == 0 ) begin
            tWHWH2 = tPROTECT_ERS ;
            FSTATE_tWHWH2_next = STAT_SERS_END ;
            -> FSTATE_tWHWH2_event ;
            $write("%t : 1470 Erase was ignored. Protected sector has been selected.\n", $time) ;
        end
        else if ( ERR_FLG == 1'b1 ) begin
            FSTATE_tWHWH2_next = STAT_ERASE_HANG ;
            -> FSTATE_tWHWH2_event ;
        end
        else begin
            FSTATE_tWHWH2_next = STAT_SERS_END ;
            -> FSTATE_tWHWH2_event ;
        end
      end // STAT_SERS
    STAT_SERS_END : begin
        EMB_TIME = $time ;
        FSTATE_next = STAT_RESET ;
        -> FSTATE_event ;
      end // STAT_SERS_END
    default : begin
      end
  endcase
  -> DQ_OUTPUT ;
end // always @( FSTATE ) begin

//--<Sector Erase Tiemout>--
always @( TIMER ) begin :C1_FSTATE_SERS_TIMEOUT
  if ( FSTATE==STAT_SERS_TIMEOUT ) begin
    if ( TIMER >= TIMEOUT ) begin
      FSTATE_next = STAT_SERS_START ;
      -> FSTATE_event ;
      TIMER = 0 ;
    end
    else begin
      -> TIMER_INC ;
    end
  end
  else begin
      TIMER = 0 ;
  end
end
always @( ESA ) begin
  TIMER = 1 ;
end

//--<< Status Delay >>--
always @( FSTATE_event ) begin
  FSTATE = FSTATE_next ;
end
always @( FSTATE_PGM_event ) begin :C1_FSTATE_PGM_event
  #tWHWH1
    FSTATE = FSTATE_PGM_next ;
end
always @( FSTATE_tWHWH2_event ) begin :C1_FSTATE_tWHWH2_event
  #tWHWH2
    FSTATE = FSTATE_tWHWH2_next ;
end

//--<< Array Data Latch >>--
always @( FSTATE or A ) begin :C1_LATCH_DATA
  LATCH_DATA = FARRAY[A] ;
  -> LATCH_DATA_event ;
end

//--<< Output Buffer >>--
always @( LATCH_DATA_event or XCEorXOE or HIT_ESA or EN_PROTECT or ATD )
begin :C1_OUTBUF
  if ( ATD == 1'b1 ) begin // power on control 
  //--<Read mode Output>--
  if ( FSTATE == STAT_RESET || FSTATE == STAT_FAST_MODE
         || FSTATE == STAT_ERASE_SUSPEND || FSTATE == STAT_PGM_SETUP
         || FSTATE == STAT_PZ1 || FSTATE == STAT_PREL || FSTATE == STAT_C8
         || FSTATE == STAT_C8_PZ1 || FSTATE == STAT_C8_PREL ) begin
    //--<Normal mode >--
    if ( HIT_ESA == 1'b0 ) begin
      if ( EMB_TIME == $time ) begin
          #0    OUTBUF[7] = LATCH_DATA[7] ;
          #tEOE OUTBUF[6:0] = LATCH_DATA[6:0]  ;
      end
      else begin 
          OUTBUF = LATCH_DATA ;
      end
    end
    //--<Suspend mode >--
    else if ( HIT_ESA == 1'b1 ) begin
        OUTBUF[7] = 1'b1 ;
        OUTBUF[6] = 1'b1 ;
        OUTBUF[5] = 1'b0 ;
        OUTBUF[4] = 1'bx ;
        OUTBUF[3] = 1'b0 ;
        OUTBUF[2] = TOGGLE ;
        OUTBUF[1] = 1'bx ;
        OUTBUF[0] = 1'bx ;
    end
  end
  //--<Autoselect mode Output>--
  else if ( FSTATE == STAT_AS ) begin
      if ( A[7:0] == MANUFAC_ADDR && A[10] == 1'b0 ) begin
        OUTBUF = MANUFAC_CODE ;
      end
      else if ( A[7:0] == DEVICE_ADDR && A[10] == 1'b0 ) begin
        OUTBUF = DEV_CODE ;
      end
      else if ( A[7:0] == PROTECT_ADDR && A[10] == 1'b0 ) begin
        OUTBUF = { {(W-1){1'b0}}, EN_PROTECT } ;
      end
      else begin
        OUTBUF = {W{1'bx}} ;
      end
  end
  //--<Status Output>--
  else begin
    //--<Program mode Output>--
    if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END ) begin
      OUTBUF[7] = ~ FDATA[7] ;
      OUTBUF[6] = TOGGLE ;
      OUTBUF[5] = 1'b0 ;
      OUTBUF[4] = 1'bx ;
      OUTBUF[3] = 1'b0 ;
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
      if      ( HIT_ESA==1'b0 ) OUTBUF[2] = 1'b1 ;
      else if ( HIT_ESA==1'b1 ) OUTBUF[2] = TOGGLE ;
    end
    //--<Erase Timeout mode Output>--
    else if ( FSTATE == STAT_SERS_TIMEOUT ) begin
      OUTBUF[7] = 1'b0 ;
      OUTBUF[6] = TOGGLE ;
      OUTBUF[5] = 1'b0 ;
      OUTBUF[4] = 1'bx ;
      OUTBUF[3] = 1'b0 ;
      OUTBUF[2] = TOGGLE ;
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
    end
    //--<Erase mode Output>--
    else if ( FSTATE == STAT_ERS || FSTATE == STAT_ERS_END
            || FSTATE == STAT_SERS_START || FSTATE == STAT_SERS
            || FSTATE == STAT_SERS_END ) begin
      OUTBUF[7] = 1'b0 ;
      OUTBUF[6] = TOGGLE ;
      OUTBUF[5] = 1'b0 ;
      OUTBUF[4] = 1'bx ;
      OUTBUF[3] = 1'b1 ;
      OUTBUF[2] = TOGGLE ;
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
    end
    //--< Time Limit Over Output >--
    else if ( FSTATE == STAT_PGMS_HANG ) begin
      OUTBUF[7] = ~ FDATA[7] ;
      OUTBUF[6] = TOGGLE ;
      OUTBUF[5] = 1'b1 ;
      OUTBUF[4] = 1'bx ;
      OUTBUF[3] = 1'b0 ;
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
      if      ( ESP==1'b0 ) OUTBUF[2] = 1'b1 ;
      else if ( ESP==1'b1 ) OUTBUF[2] = 1'bx ;
    end
    else if ( FSTATE == STAT_ERASE_HANG ) begin
      OUTBUF[7] = 1'b0 ;
      OUTBUF[6] = TOGGLE ;
      OUTBUF[5] = 1'b1 ;
      OUTBUF[4] = 1'bx ;
      OUTBUF[3] = 1'b1 ;
      OUTBUF[2] = 1'bx ;
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
    end
    else begin
      OUTBUF= {W{1'bx}} ;
    end
  end
  -> DQ_OUTPUT ;
  end
end  // C1_OUTBUF

//--<< Output Buffer Control >>--
always @( DQ_OUTPUT ) begin :C1_OUTPUT
  //--< Disable Process >--
  if ( XCEorXOE == 1'b1 || XRESET == 1'b0 ) begin
    if ( OUT_HIZ == 1'b1 ) begin
      oDQ = {W{1'bx}} ;
      OUT_CTL = 1'b1 ;
    end
    else if ( OUT_HIZ == 1'b0 ) begin
      oDQ = {W{1'bz}} ;
      OUT_CTL = 1'b0 ;
    end
  end
  //--< Enable Process >--
  else if ( (XCEorXOE == 1'b0) && ( XRESET == 1'b1) ) begin
    //--< Output Delay >--
    if ( INVALID == 1'b1 ) begin
      if ( OUT_HOLD == 1'b0 ) begin
        oDQ = {W{1'bx}} ;
        OUT_CTL = 1'b1 ;
      end
    end
    //--< Output Buffer Enable >--
    else begin
      oDQ = OUTBUF ;
      OUT_CTL = 1'b1 ;
    end
  end
  else begin
    oDQ = {W{1'bz}} ;
    OUT_CTL = 1'b0 ;
  end
end  // always @( DQ_OUTPUT ) begin :C1_OUTPUT

//////////////////////////////////////////////////////////////////////

//--<< RY_XBY Output >>--
always @( FSTATE ) begin
  if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END
   || FSTATE==STAT_PGMS_HANG || FSTATE==STAT_ERS
   || FSTATE==STAT_ERS_END || FSTATE==STAT_ERASE_HANG
   || FSTATE==STAT_SERS_TIMEOUT || FSTATE==STAT_SERS_START
   || FSTATE==STAT_SERS || FSTATE==STAT_SERS_END ) begin
      -> RY_XBY_tBUSY ; // #tBUSY  RY_XBY = 1'b0 ;
  end
  else begin
    disable RY_XBY_delay_tBUSY ;
    RY_XBY = 1'bz ;
  end
end
always @( RY_XBY_tBUSY ) begin : RY_XBY_delay_tBUSY
  #(tBUSY) RY_XBY = 1'b0 ;
end

//--<< Sector Erase Selector >>--
task SELECT_BIT ;
    input [SAB-1:0] add ;
    integer i ;
    reg [7:0] badd ;
  begin
    if ( add[SAB-1:3] == BOOT_ADD[SAB-1:3] ) begin // Boot Sector
      for ( i=0 ; i<= NUM_OF_BOOT-1 ; i=i+1 ) begin
        if ( B_TYPE == "TOP" ) SEL_BIT = ISN1 - i ;
        else                   SEL_BIT = i ;
        badd = BSA[i] ;
        if ( i==0 ) begin //16k byte
          if ( add[3:1] == badd[3:1] ) i= NUM_OF_BOOT ;
        end
        else if ( i==3 ) begin //32k byte
          if ( add[3:2] == badd[3:2] ) i= NUM_OF_BOOT ;
        end
        else begin //8k byte
          if ( add[3:0] == badd[3:0] ) i= NUM_OF_BOOT ;
        end
      end
    end
    else begin // Normal Sector (64k byte)
      SEL_BIT = add[SAB-1:3] + ISN2 ;
    end
  end
endtask

always @( ESA or RSEL or ASEL) begin : SECTOR_ERASE_SELECTOR
  if ( RSEL == 1'b0 ) begin
    if ( ASEL == 1'b1 ) SEL = {NUM_OF_SECTOR{1'b1}} ;
    else                SEL = {NUM_OF_SECTOR{1'b0}} ;
  end
  else begin
    SELECT_BIT( ESA ) ;
    if ( INV_ADD == 1'b0 ) SEL[SEL_BIT] = 1'b1 ;
  end
end // always @( ESA or RSEL ) begin : SECTOR_ERASE_SELECTOR

always @( A or SEL ) begin : A_or_SEL
  SELECT_BIT( A[AB-1:AB-SAB] ) ;
  if( SEL[SEL_BIT] == 1'b1 ) HIT_ESA = 1'b1 ;
  else                       HIT_ESA = 1'b0 ;
end // always @( A or SEL ) begin

//--<< Protect Status >>--
always @( A or PROTECT_REG ) begin : PROTECT_ENABLE
  SELECT_BIT( A[AB-1:AB-SAB] ) ;
  if ( PROTECT_REG[SEL_BIT] == 1'b1 )
     EN_PROTECT = 1'b1 ;
  else
     EN_PROTECT = 1'b0 ;
end

//--<< DQ Output delay >>--
always @( A ) begin
  if( AFTER_A == 1'b0 ) begin
    AFTER_A = 1'b1 ;
    OUT_HOLD = 1'b1 ;
  end
  else begin
    disable DELAY_A ;
    #(tOH) OUT_HOLD = 1'b0 ;
    -> DQ_OUTPUT ;
    #(tACC-tOH) AFTER_A = 1'b0 ;
  end
end
always @( posedge AFTER_A ) begin : DELAY_A
  #(tOH) OUT_HOLD = 1'b0 ;
  -> DQ_OUTPUT ;
  #(tACC-tOH) AFTER_A = 1'b0 ;
end

always @( negedge XCE ) begin
  if ( AFTER_XCE == 1'b0 ) begin
    AFTER_XCE = 1'b1 ;
  end
  else begin
    disable DELAY_XCE ;
    #tCE AFTER_XCE = 1'b0 ;
  end
end
always @( posedge AFTER_XCE ) begin : DELAY_XCE
  #tCE AFTER_XCE = 1'b0 ;
end

always @( negedge XOE ) begin
  if ( AFTER_XOE == 1'b0 ) begin
    AFTER_XOE = 1'b1 ;
  end
  else begin
    disable DELAY_XOE ;
    #tOE AFTER_XOE = 1'b0 ;
  end
end
always @( posedge AFTER_XOE ) begin : DELAY_XOE
  #tOE AFTER_XOE = 1'b0 ;
end

always @( posedge XRESET ) begin
  if ( $time >0 ) begin
    if ( AFTER_XRESET == 1'b0 ) begin
      AFTER_XRESET = 1'b1 ;
    end
    else begin
      disable DELAY_XRESET ;
      #tRH AFTER_XRESET = 1'b0 ;
    end
  end
end
always @( posedge AFTER_XRESET ) begin : DELAY_XRESET
  #tRH AFTER_XRESET = 1'b0 ;
end

//--<< Output to Invalid Data >>--
always @( AFTER_A or AFTER_XCE or AFTER_XOE or AFTER_XRESET) begin
  INVALID = AFTER_A | AFTER_XCE | AFTER_XOE | AFTER_XRESET ;
  -> DQ_OUTPUT ;
end

//--<< Output to High-Z >>--
always @( posedge XCEorXOE ) begin
  if ( XRESET == 1'b1 ) OUT_HIZ = 1'b1 ; 
end
always @( negedge XRESET ) begin
  if ( XCEorXOE == 1'b0 ) OUT_HIZ = 1'b1 ; 
end
always @( posedge OUT_HIZ ) begin
  #(tDF) OUT_HIZ = 1'b0 ;
  -> DQ_OUTPUT ;
end

//--<< I/O signal Operation time >>--
always @( A ) begin
  rfA = $time ;
end

always @( DQ ) begin
  rfDQ = $time ;
end

always @( XCE ) begin
  if ( XCE == 1'b1 ) begin
    rXCE = $time ;
  end
  else begin
    fXCE = $time ;
  end
end

always @( XOE ) begin
  if ( XOE == 1'b1 ) begin
    rXOE = $time ;
  end
  else begin
    fXOE = $time ;
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

always @( XRESET ) begin
  if ( XRESET == 1'b1 ) begin
    rXRESET = $time ;
  end
  else begin
    fXRESET = $time ;
  end
  -> DQ_OUTPUT ;
end

always @( XCEorXWE ) begin
  if ( XCEorXWE == 1'b1 ) begin
    rXCEorXWE = $time ;
  end
  else begin
    fXCEorXWE = $time ;
  end
end

always @( XCEorXOE ) begin
  if ( XCEorXOE == 1'b1 ) begin
    rXCEorXOE = $time ;
  end
  else begin
    fXCEorXOE = $time ;
  end
  -> DQ_OUTPUT ;
end

always @( rfA or fXCE or rXRESET ) begin
  if ( (rfA + fXCE + rXRESET) > 0 ) ATD = 1'b1 ; 
end

//--<< Invalid Address Check >>--
always @( A ) begin
  if ( ^A == 1'b0 || ^A == 1'b1 ) begin
    INV_ADD = 1'b0 ;
  end
  else begin
    INV_ADD = 1'b1 ;
    -> INV_ADD_event ;
  end
end

//--< Invalid Read Address >--
always @( INV_ADD_event or XCEorXOE or XRESET ) begin
  if ( $time > 0 ) begin
  if ( INV_ADD == 1 && XCEorXOE == 1'b0 && XRESET== 1'b1 ) begin
    $write("%t : 1300 Invalid Address during Read cycle.\n",$time) ;
  end
  end
end
//--< Invalid Write Address >--
always @( negedge XCEorXWE ) begin
  if( INV_ADD == 1'b1 ) begin
    $write("%t : 1310 Invalid Address during Write cycle.\n",$time) ;
  end
end

//--<< AC Characteristics >>--
//--< RESET Pulse width >--
always @( posedge XRESET ) begin
  if ( $time > 0 &&  ( $time - fXRESET ) < tRP ) begin
    $write("%t : 1010 /RESET Pulse width (tRP) was not suitable.\n", $time) ;
  end
end

//--< Output Enable Setup Time >--
always @( posedge XWE ) begin
  if ( $time > 0 &&  ( $time - rXOE ) < tOES ) begin
    $write("%t : 1030 Output Enable Setup Time (tOES) was not suitable.\n", $time) ;
  end
end // always @( posedge XWE ) begin

//--< Output Enable Hold Time >--
always @( negedge XOE ) begin
  if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END
    || FSTATE == STAT_PGMS_HANG || FSTATE == STAT_ERS
    || FSTATE == STAT_ERS_END || FSTATE == STAT_ERASE_HANG
    || FSTATE == STAT_SERS_TIMEOUT || FSTATE == STAT_SERS_START
    || FSTATE == STAT_SERS || FSTATE == STAT_SERS_END
    || FSTATE == STAT_ERASE_SUSPEND ) begin
    if ( $time > 0 &&  ( $time - rXWE ) < tOEH_POLLING ) begin
      $write("%t : 1040 Output Enable Hold Time (tOEH) was not suitable.\n", $time) ;
    end
  end
  else begin
    if ( $time > 0 &&  ( $time - rXWE ) < tOEH_READ ) begin
      $write("%t : 1040 Output Enable Hold Time (tOEH) was not suitable.\n", $time) ;
    end
  end
end // always @( negedge XOE ) begin

//--< Write Pulse width (write cycle) >--
always @( posedge XCEorXWE ) begin //--< Low width >--
  if ( $time > 0 &&  ( $time - fXCEorXWE ) < tWP ) begin
    // WE Pulse
    if ( ( $time - fXWE ) < tWP && rXWE == $time ) begin
      $write("%t : 1050 /WE Pulse width (tWP) was not suitable.\n", $time) ;
    end
    // CE Pulse
    else if ( ( $time - fXCE ) < tCP && rXCE == $time ) begin
      $write("%t : 1060 /CE Pulse width (tCP) was not suitable.\n", $time) ;
    end
    else begin
      $write("%t : 1070 Write Pulse width (tWP) was not suitable.\n", $time) ;
    end
  end
end
always @( negedge XCEorXWE ) begin //--< High width >--
  if ( $time > 0 &&  ( $time - rXCEorXWE ) < tWPH ) begin
    // WE Pulse
    if ( ( $time - rXWE ) < tWPH && fXWE == $time ) begin
      $write("%t : 1080 /WE Pulse width High (tWPH) was not suitable.\n", $time) ;
    end
    // CE Pulse
    else if ( ( $time - rXCE ) < tCPH && fXCE == $time ) begin
      $write("%t : 1090 /CE Pulse width High (tCPH) was not suitable.\n", $time) ;
    end
    else begin
      $write("%t : 1100 Write Pulse width High (tWPH) was not suitable.\n", $time) ;
    end
  end
end

//--< WE Read Recover time (write cycle) >--
always @( negedge XWE ) begin
  if ( $time > 0 &&  ( $time - rXOE ) < tGHWL ) begin
    $write("%t : 1110 /WE Read Recover Time (tGHWL) was not suitable.\n", $time) ;
  end
end // always @( negedge XWE )

//--< CE Read Recover time (write cycle) >--
always @( negedge XCE ) begin
  if ( $time > 0 &&  ( $time - rXOE ) < tGHEL ) begin
    $write("%t : 1120 /CE Read Recover Time (tGHEL) was not suitable.\n", $time) ;
  end
end // always @( negedge XCE )

//--< Address Setup time (write cycle) >--
always @( negedge XCEorXWE ) begin
  if ( $time > 0 &&  ( $time - rfA ) < tAS ) begin
    $write("%t : 1130 Address Setup Time (tAS) was not suitable.\n", $time) ;
  end
end // always @( negedge XCEorXWE )

//--< Address Hold time (write cycle) >--
always @( A ) begin
  if ( $time > 0 && ( $time - fXCEorXWE ) < tAH && fXCEorXWE > 0) begin
    $write("%t : 1140 Address Hold Time (tAH) was not suitable.\n", $time) ;
  end
  if ( $time > 0 &&  ( $time - rXRESET ) < tRH && rXRESET > 0) begin
    $write("%t : 1020 /RESET Hold Time (tRH) was not suitable.\n", $time) ;
  end
end // always @( A )

//--< Data Setup Time (write cycle) >--
always @( posedge XCEorXWE ) begin
  if ( $time > 0 &&  ( $time - rfDQ ) < tDS && $time!=rfDQ ) begin
    $write("%t : 1150 Data Setup Time (tDS) was not suitable.\n", $time) ;
  end
end // always @( posedge XCEorXWE ) begin

//--< Data Hold Time (write cycle) >--
always @( DQ ) begin
  if ( $time > 0 &&  ( $time - rXCEorXWE ) < tDH ) begin
    $write("%t : 1160 Data Hold Time (tDH) was not suitable.\n", $time) ;
  end
end // always @( DQ ) begin

//--< OE,WE falling Check (write cycle) >--
always @( negedge XCE or negedge XWE or negedge XOE ) begin
  if ( XCE == 1'b0 && XWE == 1'b0 && XOE == 1'b0 ) begin
    $write("%t : 1190 /WE and /OE were 'Low' at sametime.\n", $time) ;
  end
end

//////////////////////////////////////////////////////////////////////
always @( TIMER_INC ) begin
  #1 TIMER = TIMER + 1 ;
end

endmodule
//`endprotect
`endcelldefine
