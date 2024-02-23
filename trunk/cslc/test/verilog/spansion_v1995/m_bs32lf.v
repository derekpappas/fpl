///////////////////////////////////////////////////////////////////////////
// NOR-type Flash Memory                                                 //
// MBM29BS32LF (2Mx16, boot block)                                       //
// Verilog Simulation Model                                              //
// Version: 1.0                                                          //
// Date: 2003/02/18                                                      //
// Designed by FUJITSU                                                   //
// module : MBM29BS32LF                                                  //
//                                                                       //
//   Copyright (c) FUJITSU LIMITED, 2003.                                //
//   All Rights Reserved. Licensed Library.                              //
///////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ns

`celldefine
module MBM29BS32LF(
  A,      // Address Input
  DQ,     // Data Input/Output
  XCE,    // Chip Enable Input
  XOE,    // Output Enable Input
  XWE,    // Write Enable Input
  XRESET, // Hard Reset Input
  XWP,    // Write Protect Input
  CLK,    // Clock Input
  XAVD,   // Address Valid Input
  RDY     // Ready Output
);
/*************************************************************************
* NOTE: ACC signal is not described in HDL model, so the function showed
*       as follows are not available.
*   1. When ACC is VIL, hardware protect method to lock all sectors.
*   2. When ACC is VACC, accelerated program operation.
*************************************************************************/

// External Parameter
parameter SP_VER  = "SP18" ; // Speed Version SP18,SP25
parameter ERR_FLG = 0      ; // Error Flag  0:Normal, 1:Error

//////////////////////////////////////////////////////////////////////
////`protect
//////////////////////////////////////////////////////////////////////
// History                                                          //
//        : 0.1   2003/02/16  :                                     //
// ==> m_bs32lf.v 1st Release                                       //
//        : 1.0   2003/02/18  : comply with Edition 02.01           //
//////////////////////////////////////////////////////////////////////
// pin width
  parameter AB=21 ; // Address Bus width
  parameter SAB=8 ; // Sector Address Bus width
  parameter W=16 ; // Data Bus width
  parameter BA = 2 ; // Bank Address Bus width
  parameter SA=10 ;
  parameter BL = 6 ; // Burst length

  input [AB-1:0] A ;
  inout [W-1:0]  DQ ;
  input XCE,XOE,XWE,XRESET,XWP ;
  input CLK,XAVD ;
  output RDY ;

// Architecture
parameter NUM_OF_ADDR  = 1<<(AB) ; // 2**(AB)  -- AB=21
parameter NUM_OF_SECTOR = (1<<(SAB-2)) + 6 ; // -- SAB=8 -> 70
parameter NUM_OF_BOOT = (1<<2) ; // 2**2 -> 4 // Number of boot Sector
parameter NUM_OF_PROTECT = NUM_OF_SECTOR ;// Number of protect

//Number of sectors in Bank
parameter BANK_SEC1 = (1<<(SAB-2-BA))+3 ;         //Bank1 (13h:19)
parameter BANK_SEC2 = NUM_OF_SECTOR/2-BANK_SEC1 ; //Bank2 (10h:16)
parameter BANK_SEC3 = BANK_SEC2 ;                 //Bank3 (10h:16)
parameter BANK_SEC4 = BANK_SEC1 ;                 //Bank4 (13h:19)


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
parameter      QUERY_CMD = 8'b10011000 ; // 98h
parameter    PROTECT_CMD = 8'b01100000 ; // 60h
//parameter     VERIFY_CMD = 8'b01000000 ; // 40h
parameter  BURST_SET_CMD = 8'b11000000 ; // C0h

// <<Program/Erase Operations>>
parameter PGMS_TIME = 6000 ; // 6us --Program Time(tWHWH1)
parameter SERS_TIME = 500000000 ; // 0.5sec --Sector Erase Time(tWHWH2)
parameter TIMEOUT = 50000 ; // 50us --Sector Erase Timeout(tTOW)

parameter tSUSPEND = 20000 ; // 20us
parameter tPROTECT_PGM = 1000 , // 1us
          tPROTECT_ERS = 400000 ; // 400us

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
//parameter STAT_PGMS_SUSPEND  = 5'b01110 ; // 0Eh
parameter STAT_ERS           = 5'b10000 ; // 10h
parameter STAT_ERS_END       = 5'b10001 ; // 11h
parameter STAT_ERASE_HANG    = 5'b10010 ; // 12h
parameter STAT_SERS_TIMEOUT  = 5'b10100 ; // 14h
parameter STAT_SERS_START    = 5'b10101 ; // 15h
parameter STAT_SERS          = 5'b10110 ; // 16h
parameter STAT_SERS_END      = 5'b10111 ; // 17h
parameter STAT_ERASE_SUSPEND = 5'b11000 ; // 18h
parameter STAT_FAST_MODE     = 5'b11001 ; // 19h
parameter STAT_QUERY         = 5'b11010 ; // 1Ah
parameter STAT_PROTECT_SETUP = 5'b11011 ; // 1Bh
parameter STAT_PROTECT       = 5'b11100 ; // 1Ch
//parameter STAT_PROTECT_VERIFY= 5'b11101 ; // 1Dh

//////////////////////////////////////////////////////////////////////
// register declaration
//   wdt  name         addr
reg [W-1:0] FARRAY [NUM_OF_ADDR-1:0] ;
reg [4:0] FSTATE, FSTATE_next, FSTATE_PGM_next ;
reg [4:0] FSTATE_tWHWH2_next, FSTATE_ERS_next ;
reg [AB-1:0] ABUF, RABUF ;
reg [AB-1:0] FADDR ;
reg [W-1:0] FDQ, FDATA, LATCH_DATA ;
reg [W-1:0] DINBUF ;
reg ESP ;
integer TIMER ;
reg [SAB-1:0] ESA, SLA ;
reg TOGGLE ;
reg XCEorXOE, XCEorXWE ;
reg AFTER_A, AFTER_XCE, AFTER_XOE ;
reg AFTER_XRESET ;
reg OUT_HOLD, OUT_HIZ ;
reg INVALID ;
integer EA ;
reg FT_MODE ;
time tWHWH1, tWHWH2 ;
reg HIT_ESA, EN_PROTECT;
reg [NUM_OF_SECTOR-1:0] SEL ;
reg RSEL, ASEL ;
reg [NUM_OF_SECTOR-1:0] PROTECT_REG ;
reg EN_BANK ;
reg [3:0] SEL_BANK ;
reg [3:0] ERS_BANK, CMD_BANK, PGM_BANK ;
reg [NUM_OF_PROTECT-1:0] LOCK_STATUS ; // 0:unlock, 1:lock

reg [W-1:0] PRO_REG ;
reg INV_ADD ;
reg PGM_FLG ;
reg ATD ;

reg [AB-1:0] PABUF ;

reg LATCH_FLG ;
reg AFTER_BA, AFTER_RDY ;
reg AFTER_LA, INIT_ACT ;

reg INIT_FLG ;
reg INC_FLG ;
reg BURST_NOP ;
reg WAIT_INIT ;

reg [AB-1:0] LOAD_ADDR ;
reg [AB-1:0] INIT_ADDR ;
reg [BL-1:0] INC_ADDR ;

reg [BL:0] BST_CNT ;
reg [3:0] INIT_CNT ;

integer IRA ;

reg BST_MODE ;
reg RDY_MODE ;
reg CLK_EDGE ;

integer BST_LEN ;
integer BST_TYPE ;
integer INT_CYC ;

reg [7:0] MANUFAC_CODE, DEV_CODE ;
reg [7:0] EXTEND_CODE1, EXTEND_CODE2 ;
integer ISA, ISB ;
integer SEL_BIT ;
reg [SAB-1:0] TOP_ADD, BOTM_ADD ;
reg [BA-1:0] BADDR ;

reg [7:0] CFI_CODE [(1<<7):0] ;

time tACC, tCE, tOE, tOH, tREADY ;
time tAS, tAH, tDS, tDH, tOEH_READ, tOEH_POLLING, tGHWL, tWP, tWPH,
     tRP, tRH, tOES, tGHEL, tEOE ;
time tASO, tAHT, tOEPH, tCEPH ;

time rfA, rfDQ, rXCE, fXCE, rXOE, fXOE, rXWE, fXWE,
     rXRESET, fXRESET, rXCEorXWE, fXCEorXWE, rXCEorXOE,
     fXCEorXOE , EMB_TIME ;
time rXAVD, fXAVD, rCLK, fCLK, tCLK ;


time tIACC, tBACC, tAVDS, tACS, tACH, tBDH, tCEZ, tOEZ, tCES, tRDYS, tRACC ;
time tAAS, tAAH, tAVC, tAVD, tAVDP, tAAVDS, tAAVDH ;
time tCAS, tCH, tCS, tASW, tAHW ;

time tNEXTPAGE ;

event DQ_OUTPUT ;
event TIMER_INC ;
event FSTATE_event ;
event FSTATE_PGM_event ;
event FSTATE_tWHWH2_event ;
event FSTATE_tREADY_event ;
event FSTATE_SERS_TIMEOUT_event ;
event FSTATE_RESET_event ;
event INV_ADD_event ;
event LATCH_DATA_event ;
event ACTIVE_CLK ;

event WAIT_NEXT_event ;

reg RDY ;
reg [W-1:0] OUTBUF ;
//////////////////////////////////////////////////////////////////////
reg [W-1:0] oDQ ;
reg OUT_CTL ;
assign DQ[W-1:0] = OUT_CTL ? oDQ[W-1:0] : {W{1'bz}} ;
//////////////////////////////////////////////////////////////////////

initial begin : memory_initialize
  integer i ;
  for( i=0 ; i < NUM_OF_ADDR  ; i=i+1 ) FARRAY[i] = {W{1'b1}} ;
end

initial begin : dependent_init
  integer i, j ;

  PROTECT_REG = {NUM_OF_SECTOR{1'b1}} ;
  LOCK_STATUS = {NUM_OF_PROTECT{1'b1}} ;
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
  EA = 1 ;
  FT_MODE = 0 ;
  tWHWH1 = PGMS_TIME ;
  HIT_ESA = 0 ;
  SEL = 0 ;
  RSEL = 0 ;
  ASEL = 0 ;
  EN_BANK = 1'b0 ;
  SEL_BANK = 4'b0000 ;
  BADDR = {BA{1'b0}} ; 
  PRO_REG = 1'b0 ;
  PGM_FLG = 1'b0 ;
  ATD = 1'b0 ;
  PGM_BANK = 4'b0000 ;

  PABUF = {AB{1'bx}} ; 

  LATCH_FLG = 1'b0 ;

  AFTER_LA = 0 ;
  AFTER_BA = 0 ;
  INIT_ACT = 0 ;
  INIT_FLG = 1'b0 ;
  INC_FLG = 1'b0 ;
  WAIT_INIT = 1'b0 ;
  BURST_NOP = 1'b0 ;
  AFTER_RDY = 0 ;

  BST_MODE = 1'b1 ;
  RDY_MODE = 1'b1 ;
  CLK_EDGE = 1'b1 ;
  BST_LEN = 6 ;
  INT_CYC = 7 ;
  BST_TYPE = 0 ;

  TOP_ADD = {SAB{1'b1}} ; 
  BOTM_ADD = {SAB{1'b0}} ; 

  MANUFAC_CODE = 8'b00000100 ; // 04h
  DEV_CODE = 8'b01111110 ; // 7Eh
  EXTEND_CODE1 = 8'b00110011 ; // 23h
  EXTEND_CODE2 = 8'b00000000 ; // 00h

  CFI_CODE[16] = 8'b01010001 ; CFI_CODE[17] = 8'b01010010 ;
  CFI_CODE[18] = 8'b01011001 ; //16-18  ASCII "QRY"
  CFI_CODE[19] = 8'b00000010 ; CFI_CODE[20] = 8'b00000000 ; //Primary command
  CFI_CODE[21] = 8'b01000000 ; CFI_CODE[22] = 8'b00000000 ; //Primary table 
  CFI_CODE[23] = 8'b00000000 ; CFI_CODE[24] = 8'b00000000 ; //Alternate command
  CFI_CODE[25] = 8'b00000000 ; CFI_CODE[26] = 8'b00000000 ; //Alternate table
  CFI_CODE[27] = 8'b00010111 ; //Vcc min
  CFI_CODE[28] = 8'b00011001 ; //Vcc max
  CFI_CODE[29] = 8'b00000000 ; //Vpp min
  CFI_CODE[30] = 8'b00000000 ; //Vpp max
  CFI_CODE[31] = 8'b00000100 ; //Word write time typ 
  CFI_CODE[32] = 8'b00000000 ; //Buffer write time typ  
  CFI_CODE[33] = 8'b00001001 ; //Sector erase time typ 
  CFI_CODE[34] = 8'b00000000 ; //Chip erase time typ 
  CFI_CODE[35] = 8'b00000100 ; //Word write time max
  CFI_CODE[36] = 8'b00000000 ; //Buffer write time max
  CFI_CODE[37] = 8'b00000100 ; //Sector erase time max
  CFI_CODE[38] = 8'b00000000 ; //Chip erase time max
  CFI_CODE[39] = 8'b00010110 ; //Device size
  CFI_CODE[40] = 8'b00000001 ; //40-41 Interface description
  CFI_CODE[41] = 8'b00000000 ;
  CFI_CODE[42] = 8'b00000000 ; //42-43 Malti write byte number max
  CFI_CODE[43] = 8'b00000000 ;
  CFI_CODE[44] = 8'b00000011 ; //Erase block number
  CFI_CODE[45] = 8'b00000011 ;CFI_CODE[46] = 8'b00000000 ; //45-48 Erase Block1
  CFI_CODE[47] = 8'b00100000 ;CFI_CODE[48] = 8'b00000000 ;
  CFI_CODE[49] = 8'b00111101 ;CFI_CODE[50] = 8'b00000000 ; //49-52 Erase Block2
  CFI_CODE[51] = 8'b00000000 ;CFI_CODE[52] = 8'b00000001 ;
  CFI_CODE[53] = 8'b00000011 ;CFI_CODE[54] = 8'b00000000 ; //53-56 Erase Block3
  CFI_CODE[55] = 8'b00100000 ;CFI_CODE[56] = 8'b00000000 ;
  CFI_CODE[57] = 8'b00000000 ;CFI_CODE[58] = 8'b00000000 ; //57-60 Erase Block4
  CFI_CODE[59] = 8'b00000000 ;CFI_CODE[60] = 8'b00000000 ;
  CFI_CODE[64] = 8'b01010000 ;CFI_CODE[65] = 8'b01010010 ; //64-66 ASCII "PRI"
  CFI_CODE[66] = 8'b01001001 ;
  CFI_CODE[67] = 8'b00110001 ; //Major version number
  CFI_CODE[68] = 8'b00110011 ; //Minor version number 
  CFI_CODE[69] = 8'b00000100 ; //Address sensitive unlock
  CFI_CODE[70] = 8'b00000010 ; //Erase suspend
  CFI_CODE[71] = 8'b00000001 ; //Sector protection
  CFI_CODE[72] = 8'b00000000 ; //Sector temporary
  CFI_CODE[73] = 8'b00000101 ; //Sector protect algorithm
  CFI_CODE[74] = 8'b00110011 ; //Total number of sectors except Bank1
  CFI_CODE[75] = 8'b00000001 ; //Burst mode
  CFI_CODE[76] = 8'b00000000 ; //Pege mode
  CFI_CODE[77] = 8'b10110101 ; //Vacc min
  CFI_CODE[78] = 8'b11000101 ; //Vacc max
  CFI_CODE[79] = 8'b00000010 ; //Boot Type
  CFI_CODE[80] = 8'b00000000 ; //Program Suspend
  CFI_CODE[87] = 8'b00000100 ; //Bank Organization
  CFI_CODE[88] = BANK_SEC1 ; //Number of sectors in Bnak1
  CFI_CODE[89] = BANK_SEC2 ; //Number of sectors in Bnak2
  CFI_CODE[90] = BANK_SEC3 ; //Number of sectors in Bank3
  CFI_CODE[91] = BANK_SEC4 ; //Number of sectors in Bank4

  // Timing Parameter
  if ( SP_VER == "SP18" ) begin 
    //--<Read Cycle Operation >>
    tACC   =    70 ; tCE    =    70 ; tOE    =  13.5 ;
    tOH    =     0 ; tREADY = 20000 ;
    tIACC  =   106 ; tBACC  =  13.5 ; tAVDS  =     5 ; tACS   =     5 ;
    tACH   =     7 ; tBDH   =     4 ; tCEZ   =    10 ; tOEZ   =    10 ;
    tCES   =     5 ; tRDYS  =     5 ; tRACC  =  13.5 ; tAAS   =     5 ;
    tAAH   =     7 ; tAVC   =     5 ; tAVD   =    12 ; tAVDP  =    12 ;
    tAAVDS =     5 ; tAAVDH =     7 ;
    //--<Write Cycle Operation >>
    tAS    =     0 ; tAH    =    45 ; tDS    =    45 ; tDH    =     0 ;
    tASO   =    12 ; tAHT   =     0 ; tCEPH  =    20 ; tOEPH  =    20 ;
    tOEH_READ =  0 ; tOEH_POLLING = 10 ; tGHWL  =     0 ;
    tWP    =    50 ; tWPH   =    30 ;
    tRP    =   500 ; tRH    =   200 ;
    tOES   =     0 ; tGHEL  =     0 ; tEOE   =    70 ;
    tCAS   =     0 ; tCH    =     0 ; tCS    =     0 ;
    tASW   =     5 ; tAHW   =     5 ;
  end
  else if ( SP_VER == "SP25" ) begin 
    //--<Read Cycle Operation >>
    tACC   =    70 ; tCE    =    70 ; tOE    =    20 ; 
    tOH    =     0 ; tREADY = 20000 ;
    tIACC  =   120 ; tBACC  =    20 ; tAVDS  =     5 ; tACS   =     5 ;
    tACH   =     7 ; tBDH   =     4 ; tCEZ   =    10 ; tOEZ   =    10 ;
    tCES   =     5 ; tRDYS  =     5 ; tRACC  =    20 ; tAAS   =     5 ;
    tAAH   =     7 ; tAVC   =     5 ; tAVD   =    12 ; tAVDP  =    12 ;
    tAAVDS =     5 ; tAAVDH =     7 ;
    //--<Write Cycle Operation >>
    tAS    =     0 ; tAH    =    45 ; tDS    =    45 ; tDH    =     0 ;
    tASO   =    12 ; tAHT   =     0 ; tCEPH  =    20 ; tOEPH  =    20 ;
    tOEH_READ =  0 ; tOEH_POLLING = 10 ; tGHWL  =     0 ;
    tWP    =    50 ; tWPH   =    30 ;
    tRP    =   500 ; tRH    =   200 ;
    tOES   =     0 ; tGHEL  =     0 ; tEOE   =    70 ;
    tCAS   =     0 ; tCH    =     0 ; tCS    =     0 ;
    tASW   =     5 ; tAHW   =     5 ;
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
  EMB_TIME  = 0 ;
  rXAVD     = 0 ;
  fXAVD     = 0 ;
  rCLK      = 0 ;
  fCLK      = 0 ;
  tCLK      = 0 ;
end

//////////////////////////////////////////////////////////////////////
//<< Toggle Bit Operation >>
always @( XCE or XOE ) begin
  XCEorXOE = XCE | XOE ;
end

always @( posedge XCEorXOE ) begin
  if( FSTATE==STAT_PGMS          || FSTATE==STAT_PGMS_HANG
   || FSTATE==STAT_SERS_TIMEOUT  || FSTATE==STAT_SERS_START
   || FSTATE==STAT_SERS          || FSTATE==STAT_ERASE_HANG ) begin
    if( EN_BANK==1'b1 || HIT_ESA == 1'b1 ) TOGGLE = ~ TOGGLE ;
  end
  else if(FSTATE==STAT_ERASE_SUSPEND ) begin
    if( HIT_ESA==1'b1 ) TOGGLE = ~ TOGGLE ;
  end
  else begin
    TOGGLE = 1 ;
  end
end
always @( FSTATE ) begin
  if( ~(FSTATE==STAT_PGMS          || FSTATE==STAT_PGMS_HANG
     || FSTATE==STAT_SERS_TIMEOUT  || FSTATE==STAT_SERS_START
     || FSTATE==STAT_SERS          || FSTATE==STAT_ERASE_HANG
     || FSTATE==STAT_ERASE_SUSPEND ) ) begin
     TOGGLE = 1 ;
  end
end

//<< Address latch >>
always @( XCE or XWE or XOE ) begin
  XCEorXWE = (XCE | XWE) | (~ XOE) ;
end
always @( negedge XCEorXWE ) begin
  if( XAVD == 1'b0 || $time == rXAVD ) begin
    if( LATCH_FLG == 1'b0 ) begin
      FADDR = A ; // Command address buffer
      ABUF = A ; // Address buffer (program/erase)
    end
  end
end
always @( ACTIVE_CLK ) begin
  if( XCE == 1'b0 && XCEorXWE == 1'b1 && $time != fXAVD ) begin
  if( XAVD == 1'b0 && LATCH_FLG == 1'b0 ) begin
    FADDR = A ; // Command address buffer
    ABUF = A ; // Address buffer (program/erase)
    LATCH_FLG = 1'b1 ;
  end
  end
end
always @( XAVD ) begin
  if( XAVD == 1'b1 ) begin
    if( XCE == 1'b0 && XCEorXWE == 1'b1 && LATCH_FLG == 1'b0 ) begin
    if( $time != rXWE ) begin
      FADDR = A ; // Command address buffer
      ABUF = A ; // Address buffer (program/erase)
      LATCH_FLG = 1'b1 ;
    end
    end
  end
  else if( XAVD == 1'b0 ) begin
      LATCH_FLG = 1'b0 ;
  end
end
always @( negedge XCE ) begin
      LATCH_FLG = 1'b0 ;
end


//<< Data latch >>
always @( DQ or negedge XCEorXWE ) begin
  if ( XCEorXWE == 1'b0 ) begin
    DINBUF <= #(tDS-1) DQ ;
  end
end

//--<< Main Process >>--

//--< Program Operation >--
task PROGRAM ;
    inout [W-1:0] ARRAY_DATA ;
    input [W-1:0] PGM_DATA ;
    input XFLG ;
    reg [W-1:0] CURRENT_DATA, CARRAY ;
    reg VALID_DATA ;
  begin
    CARRAY = ARRAY_DATA ;
    CURRENT_DATA = PGM_DATA ;
    VALID_DATA = ^CARRAY ;

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
    integer sel_sec ;
  begin
    if( sel_sec <= NUM_OF_BOOT-1 ) begin // Boot sector
        ISA = ( sel_sec ) * ( 1<<(AB-SAB) ) ;
        ISB = 1*( 1<<(AB-SAB) ) -1 ; // 8K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 1*(1<<(AB-SAB)) ;
    end
    else if( sel_sec >= NUM_OF_SECTOR-NUM_OF_BOOT ) begin // Boot sector
        ISA = ( 1<<(AB) ) - (NUM_OF_SECTOR-sel_sec)*( 1<<(AB-SAB) ) ;
        ISB = 1*( 1<<(AB-SAB) ) -1 ; // 8K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 1*(1<<(AB-SAB)) ;
    end
    else begin // Uniform sector
        ISA = ( sel_sec - (NUM_OF_BOOT-1) ) * ( 1<<(AB-SAB+2) );
        ISB = 4*( 1<<(AB-SAB) ) -1 ; // 32K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME * 4*(1<<(AB-SAB)) ;
    end
  end 
endtask


//--< Hardware Reset Operation >--
always @(negedge XRESET) begin :C1_XRESET
  integer i,j ;
  reg [W-1:0] CURRENT_DATA ;
  reg hw_flg ;
  hw_flg = 1'b0 ;
  if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG ) begin
    if ( PROTECT_REG[SEL_BIT] == 1'b0 )
        PROGRAM( FARRAY[PABUF], {W{1'bx}}, 1 ) ;
    PABUF = {AB{1'bx}} ; 
      -> FSTATE_tREADY_event ;
      disable C1_FSTATE_PGM_event ;
      $write("%t : 1440 Hardware Reset during Program.\n", $time) ;
      hw_flg = 1'b1 ;
  end
  if ( (FSTATE==STAT_SERS_START || FSTATE==STAT_SERS
         || FSTATE==STAT_SERS_END || FSTATE==STAT_ERASE_HANG
         || FSTATE==STAT_ERS )  || ESP==1'b1 ) begin
    for ( i=0 ; i<= NUM_OF_SECTOR -1 ; i=i+1 ) begin
      if( SEL[i]==1'b1 && PROTECT_REG[i]==1'b0 ) begin
            SADD_SET( i ) ;
            for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'bx}} ;
      end
    end // for ( i=0 ; i<= NUM_OF_SECTOR ; i=i+1 )
    if ( ESP==1'b0 ) begin
      -> FSTATE_tREADY_event ;
      disable C1_FSTATE_tWHWH2_event ;
      $write("%t : 1450 Hardware Reset during Erase.\n", $time) ;
      hw_flg = 1'b1 ;
    end
    else begin
      $write("%t : 1455 Hardware Reset during Erase Suspend.\n", $time) ;
    end
  end
  if (hw_flg==1'b0 ) begin
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
integer i, j ;
  case ( FSTATE )
    STAT_RESET : begin
        if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else if( ( FADDR[6:0] == ADDR_PAT1[6:0] )
          && ( DINBUF[7:0] == QUERY_CMD ) ) begin
            FSTATE = STAT_QUERY ;
            BADDR = ABUF[AB-1:AB-BA] ;
        end
        else if( ( DINBUF[7:0] == PROTECT_CMD ) && ESP==1'b0 ) begin
            FSTATE = STAT_PROTECT_SETUP ;
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
          BADDR = ABUF[AB-1:AB-BA] ;
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
          BADDR = ABUF[AB-1:AB-BA] ;
        end
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == FAST_CMD ) && ( ESP == 1'b0 )) begin
            FSTATE = STAT_FAST_MODE ;
            FT_MODE = 1'b1 ;
        end
        else if( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == BURST_SET_CMD ) && ( ESP == 1'b0 )) begin
          //-- Burst Configuration Register Setting --//
          // Read Mode Set //
            if( FADDR[19] == 1'b0) BST_MODE = 1'b0 ;
            else                   BST_MODE = 1'b1 ;
          // Ready Mode Set //
            if( FADDR[18] == 1'b0) RDY_MODE = 1'b0 ;
            else                   RDY_MODE = 1'b1 ;
          // Active Clock edge Set //
            if( FADDR[17] == 1'b0) CLK_EDGE = 1'b0 ;
            else                   CLK_EDGE = 1'b1 ;
          // Burst Read Type Set (Burst Length) //
            if( FADDR[16:15] == 2'b01)      BST_TYPE = 1 ;
            else if( FADDR[16:15] == 2'b10) BST_TYPE = 2 ;
            else if( FADDR[16:15] == 2'b11) BST_TYPE = 3 ;
            else                            BST_TYPE = 0 ;
          // Initial Access Wait Set (Initial Latency) //
            if( FADDR[14:12] <= 3'b101 ) INT_CYC = FADDR[14:12] +2 ;
            else $write("%t : 1800 Invalid Initial Latency Configuration.\n", $time) ;
          FSTATE = STAT_RESET ;
        end
        else if ( DINBUF[7:0] == RESUME_CMD && ESP==1'b1 ) begin
          FSTATE = STAT_SERS_START ;
          BADDR = ABUF[AB-1:AB-BA] ;
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
          BADDR = ABUF[AB-1:AB-BA] ;
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
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_AS_INVALID ;
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
        else if ( ~( (( FADDR[SA:0] == ADDR_PAT1[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT1 ))
                 ||  (( FADDR[SA:0] == ADDR_PAT2[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT2 )) )  ) begin
          $write("%t : 1390 Command was ignored. Write Reset Command.\n", $time) ;
        end
      end // STAT_AS_INVALID
    STAT_FAST_MODE : begin
        if ( DINBUF[7:0] == PROGRAM_CMD ) begin
          FSTATE = STAT_PGM_SETUP ;
        end
        else if ( DINBUF[7:0] == AS_CMD ) begin
          FSTATE = STAT_AS ;
          BADDR = ABUF[AB-1:AB-BA] ;
          FT_MODE = 1'b0 ;
        end
        else begin
          $write("%t : 1380 Command was ignored during Fast Mode.\n", $time) ;
        end
      end // STAT_FAST_MODE
    STAT_QUERY : begin
        if ( DINBUF[7:0] == RESET_CMD ) begin
          FSTATE = STAT_RESET ;
        end
        else if ( ~( (( FADDR[SA:0] == ADDR_PAT1[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT1 ))
                 ||  (( FADDR[SA:0] == ADDR_PAT2[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT2 )) )  ) begin
          $write("%t : 1500 Command was ignored during Query mode.\n", $time) ;
        end
      end // STAT_QUERY
    STAT_PGM_SETUP : begin
        FSTATE = STAT_PGMS ;
        FDATA = DINBUF ;
        BADDR = ABUF[AB-1:AB-BA] ;
        PABUF = ABUF ; // Program Address
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
        else if ( ~( (( FADDR[SA:0] == ADDR_PAT1[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT1 ))
                 ||  (( FADDR[SA:0] == ADDR_PAT2[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT2 )) )  ) begin
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
        else if ( ~( (( FADDR[SA:0] == ADDR_PAT1[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT1 ))
                 ||  (( FADDR[SA:0] == ADDR_PAT2[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT2 )) )  ) begin
          $write("%t : 1390 Command was ignored. Write Reset Command.\n", $time) ;
        end
      end // STAT_ERASE_HANG
    STAT_SERS_TIMEOUT : begin
        if ( DINBUF[7:0] == SECTOR_ERS_CMD ) begin
          FSTATE = STAT_SERS_TIMEOUT ;
          ESA = ABUF[AB-1:AB-SAB] ;
          BADDR = ABUF[AB-1:AB-BA] ;
        end
        else if ( DINBUF[7:0] == SUSPEND_CMD ) begin
            FSTATE = STAT_ERASE_SUSPEND ;
            BADDR = ABUF[AB-1:AB-BA] ;
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
            BADDR = ABUF[AB-1:AB-BA] ;
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
          BADDR = ABUF[AB-1:AB-BA] ;
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
    STAT_PROTECT_SETUP : begin
        if( ( DINBUF[7:0] == PROTECT_CMD ) ) begin
            FSTATE = STAT_PROTECT ;
        end
        else if ( ( FADDR[SA:0] == ADDR_PAT1[SA:0] )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end  // STAT_PROTECT_SETUP
    STAT_PROTECT : begin
        if( ( DINBUF[7:0] == PROTECT_CMD ) ) begin
          SLA = ABUF[AB-1:AB-SAB] ;
        end
        else if( ( DINBUF[7:0] == RESET_CMD ) ) begin
          FSTATE = STAT_RESET ;
        end
        else if ( ~( (( FADDR[SA:0] == ADDR_PAT1[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT1 ))
                 ||  (( FADDR[SA:0] == ADDR_PAT2[SA:0] )
                   && ( DINBUF[7:0] == DATA_PAT2 )) )  ) begin
          $write("%t : 1390 Command was ignored. Write Reset Command.\n", $time) ;
        end
      end  // STAT_PROTECT
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
    if ( DINBUF[7:0] !== RESET_CMD && $time > 0 ) 
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
        ESA  = {SAB{1'bx}} ; 
      end // STAT_RESET
    STAT_PGMS : begin
        SELECT_BIT( PABUF[AB-1:AB-SAB] ) ;
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
            PROGRAM( FARRAY[PABUF], {W{1'bx}}, 1 ) ;
            FSTATE_PGM_next = STAT_PGMS_HANG ;
            -> FSTATE_PGM_event ;
        end
        else begin
            PROGRAM( FARRAY[PABUF], FDATA, 0 ) ;

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
        PABUF = {AB{1'bx}} ;
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
    STAT_PROTECT : begin
//            #(tPROTECT)
//            FSTATE_next = STAT_PROTECT_SETUP ;
//            -> FSTATE_event ;
      end // STAT_PROTECT
//    STAT_PROTECT_VERIFY : begin
//      end // STAT_PROTECT_VERIFY
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
//always @( ESA or FSTATE_SERS_TIMEOUT_event ) begin
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
always @( FSTATE or IRA ) begin :C1_LATCH_DATA
  reg [W-1:0] WDATA ;
  WDATA = FARRAY[IRA] ;

  LATCH_DATA = WDATA ;
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
         || FSTATE == STAT_C8_PZ1 || FSTATE == STAT_C8_PREL 
         || EN_BANK == 1'b0 ) begin
    //--<Normal mode >--
    if ( HIT_ESA == 1'b0 ) begin
      if ( EMB_TIME == $time ) begin
          #0    OUTBUF[15:7] = LATCH_DATA[W-1:7] ;
          #tEOE OUTBUF[6:0] = LATCH_DATA[6:0]  ;
      end
      else begin 
          OUTBUF = LATCH_DATA ;
      end
    end
    //--<Suspend mode >--
    else if ( HIT_ESA == 1'b1 ) begin
        OUTBUF[15:8] = {8{1'bx}} ;
        OUTBUF[4] = 1'bx ;
        OUTBUF[3] = 1'b0 ;
        OUTBUF[1] = 1'bx ;
        OUTBUF[0] = 1'bx ;
        if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END ) begin
          OUTBUF[7] = ~ FDATA[7] ;
          OUTBUF[6] = TOGGLE ;
          OUTBUF[5] = 1'b0 ;
          OUTBUF[2] = TOGGLE ;
        end
        else if ( FSTATE == STAT_PGMS_HANG ) begin
          OUTBUF[7] = ~ FDATA[7] ;
          OUTBUF[6] = TOGGLE ;
          OUTBUF[5] = 1'b1 ;
          OUTBUF[2] = 1'bx ;
        end
        else begin
          OUTBUF[7] = 1'b1 ;
          OUTBUF[6] = 1'b1 ;
          OUTBUF[5] = 1'b0 ;
          OUTBUF[2] = TOGGLE ;
        end
    end
    else begin
      OUTBUF = {W{1'bx}} ;
    end
  end
  //--<Autoselect mode Output>--
  else if ( FSTATE == STAT_AS ) begin
      if ( IRA[7:0] == 8'h00 ) begin //manufacture code
        OUTBUF = { 8'h00, MANUFAC_CODE } ;
      end
      else if ( IRA[7:0] == 8'h01 ) begin //device code
        OUTBUF = { 8'h22, DEV_CODE } ;
      end
      else if ( IRA[7:0] == 8'h02 ) begin //protect status code
        OUTBUF = { {(W-1){1'b0}}, EN_PROTECT } ;
      end
      else if ( IRA[7:0] == 8'h0E ) begin //extened code
        OUTBUF = { 8'h22, EXTEND_CODE1 } ;
      end
      else if ( IRA[7:0] == 8'h0F ) begin //extened code
        OUTBUF = { 8'h22, EXTEND_CODE2 } ;
      end
      else begin
        OUTBUF = {W{1'bx}} ;
      end
  end
  //--<Query mode Output>--
  else if ( FSTATE == STAT_QUERY ) begin
      if ( CFI_CODE[IRA[6:0]] === 8'bx ) begin
        OUTBUF = {W{1'bx}} ;
      end
      else begin
        OUTBUF[15:8] = {8{1'b0}} ;
        OUTBUF[7:0] = CFI_CODE[IRA[6:0]] ;
      end
  end
  //--<Protect Verify mode Output>--
//  else if ( FSTATE == STAT_PROTECT_VERIFY ) begin
//        OUTBUF = PRO_REG ;
//  end
  //--<Status Output>--
  else begin
    OUTBUF[15:8] = {8{1'bx}} ;
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
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
      if      ( HIT_ESA==1'b0 ) OUTBUF[2] = 1'b1 ;
      else if ( HIT_ESA==1'b1 ) OUTBUF[2] = TOGGLE ;
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
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
      if      ( HIT_ESA==1'b0 ) OUTBUF[2] = 1'b1 ;
      else if ( HIT_ESA==1'b1 ) OUTBUF[2] = TOGGLE ;
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
      OUTBUF[7:0] = {8{1'bx}} ;
    end
  end
  end
end  // C1_OUTBUF

//--<< Output Buffer Control >>--
always @( DQ_OUTPUT or OUTBUF ) begin :C1_OUTPUT
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
    if ( INVALID == 1'b1 || BURST_NOP ==1'b1 ) begin
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

//--<< Sector Erase Selector >>--
task SELECT_BIT ;
    input [SAB-1:0] add ;
  begin
    if ( add[SAB-1:2] == TOP_ADD[SAB-2-1:0] )       //Top Boot (4k word)
          SEL_BIT = add[1:0] + NUM_OF_SECTOR - 4 ;
    else if ( add[SAB-1:2] == BOTM_ADD[SAB-2-1:0] ) //Bottom Boot (4k word)
          SEL_BIT = add[1:0] ;
    else                                          // Uniform Sector (32k word)
          SEL_BIT = add[SAB-1:2] + NUM_OF_BOOT-1 ;
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

always @( IRA or SEL ) begin : A_or_SEL
  SELECT_BIT( IRA[AB-1:AB-SAB] ) ;
  if( SEL[SEL_BIT] == 1'b1 ) HIT_ESA = 1'b1 ;
  else                       HIT_ESA = 1'b0 ;
end

//--<< Bank Address Selector >>--
  always @( SEL ) begin : ERASE_BANK_SELECT
    ERS_BANK[0] = |SEL[BANK_SEC1-1:0] ;
    ERS_BANK[1] = |SEL[BANK_SEC2+BANK_SEC1-1:BANK_SEC1] ;
    ERS_BANK[2] = |SEL[NUM_OF_SECTOR-BANK_SEC4-1:BANK_SEC2+BANK_SEC1] ;
    ERS_BANK[3] = |SEL[NUM_OF_SECTOR-1:NUM_OF_SECTOR-BANK_SEC4] ;
  end
  always @( BADDR ) begin : COMMAND_BANK_SELECT
    if( BADDR < (1<<(BA-1)) ) begin
        if( BADDR == BOTM_ADD[BA-1:0] )
          CMD_BANK = 4'b0001 ; //Select Bnak1
        else
          CMD_BANK = 4'b0010 ; //Select Bnak2
    end
    else begin
        if( BADDR == TOP_ADD[BA-1:0] )
          CMD_BANK = 4'b1000 ; //Select Bnak4
        else
          CMD_BANK = 4'b0100 ; //Select Bnak3
    end
  end
  always @( PABUF ) begin : PROGRAM_BANK_SELECT
    if ( ^PABUF === 1'bx ) begin
          PGM_BANK = 4'b0000 ; //No Select 
    end
    else if( PABUF[AB-1:AB-BA] < (1<<(BA-1)) ) begin
        if( PABUF[AB-1:AB-BA] == BOTM_ADD[BA-1:0] )
          PGM_BANK = 4'b0001 ; //Select Bnak1
        else
          PGM_BANK = 4'b0010 ; //Select Bnak2
    end
    else begin
        if( PABUF[AB-1:AB-BA] == TOP_ADD[BA-1:0] )
          PGM_BANK = 4'b1000 ; //Select Bnak4
        else
          PGM_BANK = 4'b0100 ; //Select Bnak3
    end
  end

  always @( FSTATE or ERS_BANK or CMD_BANK or PGM_BANK ) begin : BANK_SELECT
    if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG ) begin
          SEL_BANK = CMD_BANK | PGM_BANK ;
    end
    else if( FSTATE==STAT_SERS_TIMEOUT || FSTATE==STAT_SERS_START
        || FSTATE==STAT_SERS || FSTATE==STAT_SERS_END
        || FSTATE==STAT_ERASE_SUSPEND || FSTATE == STAT_ERASE_HANG
        || FSTATE==STAT_ERS || FSTATE==STAT_ERS_END ) begin
          SEL_BANK = CMD_BANK | ERS_BANK ;
    end
    else if( FSTATE==STAT_AS || FSTATE==STAT_AS_INVALID || FSTATE==STAT_QUERY ) begin
          SEL_BANK = CMD_BANK | PGM_BANK | ERS_BANK ;
    end
    else begin
       SEL_BANK = 4'b0000 ;
    end
  end

  always @( IRA or SEL_BANK ) begin : BANK_ENABLE
    integer hit_bank ;
    if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG
     || FSTATE==STAT_AS || FSTATE==STAT_AS_INVALID
     || FSTATE==STAT_SERS_TIMEOUT || FSTATE==STAT_SERS_START
     || FSTATE==STAT_SERS || FSTATE==STAT_SERS_END
     || FSTATE==STAT_ERASE_SUSPEND || FSTATE == STAT_ERASE_HANG
     || FSTATE==STAT_ERS || FSTATE==STAT_ERS_END || FSTATE==STAT_QUERY ) begin
      if( SEL_BANK==4'b1111 ) begin
          EN_BANK = 1'b1 ;
      end
      else if( SEL_BANK==4'b0000 ) begin
          EN_BANK = 1'b0 ;
      end
      else begin
        if( IRA[AB-1:AB-BA] < (1<<(BA-1)) ) begin
          if( IRA[AB-1:AB-BA] == BOTM_ADD[BA-1:0] )
            hit_bank = 0 ; //Select Bnak1
          else
            hit_bank = 1 ; //Select Bnak2
        end
        else begin
          if( IRA[AB-1:AB-BA] == TOP_ADD[BA-1:0] )
            hit_bank = 3 ; //Select Bnak4
          else
            hit_bank = 2 ; //Select Bnak3
        end
          EN_BANK = SEL_BANK[hit_bank] ;
      end
    end
    else begin
      EN_BANK = 1'b0 ;
    end
  end


//--<< Write Protect Operation >>--
always @( SLA ) begin
  SELECT_BIT( SLA ) ;
  if( ABUF[6]==1'b0 ) LOCK_STATUS[SEL_BIT] = 1'b1 ; //locked sector
  if( ABUF[6]==1'b1 ) LOCK_STATUS[SEL_BIT] = 1'b0 ; //unlocked sector
end

always @( XWP or LOCK_STATUS ) begin
  if ( XWP == 1'b0 ) begin
      PROTECT_REG = { LOCK_STATUS[NUM_OF_SECTOR-1:2], 2'b11 } ;
  end
  else if ( XWP == 1'b1 ) begin
      PROTECT_REG = LOCK_STATUS ;
  end
end

//--<< Protect Status >>--
always @( A or PROTECT_REG ) begin : PROTECT_ENABLE
  SELECT_BIT( A[AB-1:AB-SAB] ) ;
  if ( PROTECT_REG[SEL_BIT] == 1'b1 )
     EN_PROTECT = 1'b1 ;
  else
     EN_PROTECT = 1'b0 ;
end

//////////////////////////////////////////////////////////////////////
//--<< Burst Processor >>--
always @( CLK ) begin
  if ( CLK == CLK_EDGE ) begin
    -> ACTIVE_CLK ;
    tCLK = $time ;
  end
end

always @( ACTIVE_CLK ) begin : BURST_PRO
  if ( BST_MODE == 1'b0 && XCE == 1'b0 && XRESET == 1'b1 && $time != fXCE ) begin
    // Load Burst Address
    if ( INIT_FLG == 1'b0 && INC_FLG == 1'b0 && $time != fXAVD) begin
    if ( XAVD == 1'b0 || $time == rXAVD) begin
      LOAD_ADDR = RABUF ;
      INIT_FLG = 1'b1 ;
      INIT_CNT = 0 ;
      BURST_NOP = 1'b0 ;
      WAIT_INIT = 1'b1 ;
    end
    end
    // Burst Initial
    else if ( INIT_FLG == 1'b1 ) begin
      INIT_CNT = INIT_CNT + 1 ;
      if ( INC_FLG == 1'b0 ) begin
        if( INIT_CNT >= INT_CYC ) begin
          BST_CNT = 0 ;
          INIT_ADDR = LOAD_ADDR ;
          INC_ADDR[BL-1:0] = LOAD_ADDR[BL-1:0] ;
          INIT_FLG = 1'b0 ;
          INC_FLG = 1'b1 ;
          if( INIT_ACT == 1'b1 ) begin
            BURST_NOP = 1'b1 ;
            if ( XCEorXOE == 1'b0 ) begin
              $write("%t : 1810 Latency setting for Iintial Access (tIACC) was not suitable.\n", $time) ;
            end
          end
        end
        if( (RDY_MODE == 1'b1 && INIT_CNT >= INT_CYC-1 ) ||
            (RDY_MODE == 1'b0 && INIT_CNT >= INT_CYC-2 ) ) begin
          WAIT_INIT = 1'b0 ;
        end
      end
      else if ( INC_FLG == 1'b1 ) begin
        if( INIT_CNT >= INT_CYC ) begin
          INIT_CNT = -1 ;
          if (RDY_MODE == 1'b0 ) begin
            WAIT_INIT = 1'b0 ;
            -> WAIT_NEXT_event ;
          end
        end
        else if( INIT_CNT >= 1 ) begin
          BST_CNT = -1 ;
          INIT_ADDR[AB-1:BL] = INIT_ADDR[AB-1:BL] + 1 ;
          INIT_ADDR[BL-1:0] = {(BL-1){1'b0}} ;
          INIT_FLG = 1'b0 ;
          INIT_CNT = INT_CYC ;
          tNEXTPAGE = $time ;
        end
        if( RDY_MODE == 1'b1 && INIT_CNT == 0 ) begin
          WAIT_INIT = 1'b0 ;
          -> WAIT_NEXT_event ;
        end
      end
    end
    // Address Increment
    if ( INC_FLG == 1'b1 && INIT_FLG == 1'b0 ) begin
    if ( (EN_BANK == 1'b0 && HIT_ESA == 1'b0 )
      || (EN_BANK == 1'b1 && HIT_ESA == 1'b0 && FSTATE==STAT_ERASE_SUSPEND)
      ) begin

      BST_CNT[BL:0] = BST_CNT[BL:0] + 1 ;
      if ( BST_TYPE == 0 ) begin //continuous burst
        INC_ADDR[BL-1:0] = INIT_ADDR[BL-1:0] + BST_CNT[BL-1:0] ;
        if( INC_ADDR[BL-1:0] == 8'h3F && BST_CNT > 2 ) begin
           INIT_FLG = 1'b1 ;
        end
        if( ((RDY_MODE == 1'b1 && INC_ADDR[BL-1:0] == 8'h3F ) ||
            (RDY_MODE == 1'b0 && INC_ADDR[BL-1:0] == 8'h3E )) && BST_CNT > 2 ) begin
           WAIT_INIT = 1'b1 ;
        end
      end
      else begin //linear burst
        if( BST_TYPE == 1 ) //8word
          INC_ADDR[BL-4:0] = INIT_ADDR[BL-4:0] + BST_CNT[BL-4:0] ;
        else if( BST_TYPE == 2 ) //16word
          INC_ADDR[BL-3:0] = INIT_ADDR[BL-3:0] + BST_CNT[BL-3:0] ;
        else if( BST_TYPE == 3 ) //32word 
          INC_ADDR[BL-2:0] = INIT_ADDR[BL-2:0] + BST_CNT[BL-2:0] ;
        if( BST_CNT == 8'h7F ) begin
          BURST_NOP = 1'b1 ;
          if ( XCEorXOE == 1'b0 ) begin
          $write("%t : 1820 Illegal wrap around operation. Request new initial address.\n", $time) ;          end
        end
      end
    end
    else begin //burst termenate
      INIT_FLG  = 1'b0 ;
      INC_FLG    = 1'b0 ;
      LOAD_ADDR  = {AB{1'bX}} ;
      INIT_ADDR = {AB{1'bX}} ;
      INC_ADDR   = {BL{1'bX}} ;
      WAIT_INIT = 1'b0 ;
    end
    end
  end
end // always @( ACTIVE_CLK )

always @( XAVD ) begin
  if ( BST_MODE == 1'b0 && XCE == 1'b0 && XRESET == 1'b1 ) begin
    if ( XAVD == 1'b1 ) begin
      if ( INIT_FLG == 1'b0 && INC_FLG == 1'b0 ) begin
        @( ACTIVE_CLK ) ;

      if ( INIT_FLG == 1'b0 && INC_FLG == 1'b0 ) begin
        LOAD_ADDR = RABUF ;
        INIT_FLG = 1'b1 ;
        INIT_CNT = 0 ;
        BURST_NOP = 1'b0 ;
        WAIT_INIT = 1'b1 ;
      end

      end
    end
    else if ( XAVD == 1'b0 ) begin
        INIT_FLG = 1'b0 ;
        INC_FLG = 1'b0 ;
        LOAD_ADDR  = {AB{1'bX}} ;
        INIT_ADDR = {AB{1'bX}} ;
        INC_ADDR   = {BL{1'bX}} ;
        WAIT_INIT = 1'b0 ;
    end
  end
end

// Bonudary Cross into Busy Bank
always @( EN_BANK or HIT_ESA ) begin
  if ( BST_MODE == 1'b0 && XCE == 1'b0 ) begin
    if ( HIT_ESA == 1'b1 || (EN_BANK == 1'b1 && FSTATE!=STAT_ERASE_SUSPEND) ) begin
    if ( tNEXTPAGE == $time ) begin
        BURST_NOP = 1'b1 ;
      @( ACTIVE_CLK ) ;
      #tBACC ;
        BURST_NOP = 1'b0 ;
        -> DQ_OUTPUT ;
    end
    end
  end
end
always @( WAIT_NEXT_event ) begin : WAIT_INTOBUSY
reg [AB-1:0] sa ;
reg hit ;
integer hit_bank ;

  hit = 1'b0 ;
  sa[AB-1:BL] = INIT_ADDR[AB-1:BL] + 1 ;
  sa[BL-1:0] = {(BL-1){1'b0}} ;

  if ( ESP == 1'b1 ) begin
      SELECT_BIT( sa[AB-1:AB-SAB] ) ;
      if( SEL[SEL_BIT] == 1'b1 ) hit = 1'b1;
  end
  if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG
   || FSTATE==STAT_SERS_TIMEOUT || FSTATE==STAT_SERS_START
   || FSTATE==STAT_SERS || FSTATE==STAT_SERS_END
   || FSTATE == STAT_ERASE_HANG
   || FSTATE==STAT_AS || FSTATE==STAT_AS_INVALID || FSTATE==STAT_QUERY ) begin
      if( SEL_BANK==4'b1111 ) begin
          hit = 1'b1 ;
      end
      else if( SEL_BANK==4'b0000 ) begin
          hit = 1'b0 ;
      end
      else begin
        if( sa[AB-1:AB-BA] < (1<<(BA-1)) ) begin
          if( sa[AB-1:AB-BA] == BOTM_ADD[BA-1:0] )
            hit_bank = 0 ; //Select Bnak1
          else
            hit_bank = 1 ; //Select Bnak2
        end
        else begin
          if( sa[AB-1:AB-BA] == TOP_ADD[BA-1:0] )
            hit_bank = 3 ; //Select Bnak4
          else
            hit_bank = 2 ; //Select Bnak3
        end
          hit = SEL_BANK[hit_bank] ;
      end
  end

  if ( hit == 1'b1 ) begin
    @( ACTIVE_CLK ) ;
      WAIT_INIT = 1'b1 ;
    @( ACTIVE_CLK ) ;
      WAIT_INIT = 1'b0 ;
  end
end

// Burst Terminate
always @( XCE or XRESET ) begin
  if ( XCE == 1'b1 || XRESET == 1'b0 ) begin
    INIT_FLG  = 1'b0 ;
    INC_FLG    = 1'b0 ;
    LOAD_ADDR  = {AB{1'bX}} ;
    INIT_ADDR = {AB{1'bX}} ;
    INC_ADDR   = {BL{1'bX}} ;
    WAIT_INIT = 1'b0 ;
  end
end

always @( A or XAVD or XCE ) begin
  if ( XCE == 1'b0 && XAVD == 1'b0) begin
      RABUF = A ; // Read Address Buffer
  end
end

always @( RABUF or LOAD_ADDR or INIT_ADDR or INC_ADDR ) begin
  if ( BST_MODE == 1'b0 ) begin
    if ( BURST_NOP == 1'b0 ) begin
    if ( (EN_BANK == 1'b0 && HIT_ESA == 1'b0)
      || (EN_BANK == 1'b1 && HIT_ESA == 1'b0 && FSTATE==STAT_ERASE_SUSPEND) ) begin
      if ( INIT_FLG == 1'b1 && INC_FLG == 1'b0 ) begin
          IRA = LOAD_ADDR ;
      end
      else if ( INC_FLG == 1'b1 ) begin
        if ( BST_TYPE == 0 ) //continuous burst
          IRA = {INIT_ADDR[AB-1:BL], INC_ADDR[BL-1:0]} ;
        else if( BST_TYPE == 1 ) //8word linear burst
          IRA = {INIT_ADDR[AB-1:BL-3], INC_ADDR[BL-4:0]} ;
        else if( BST_TYPE == 2 ) //16word linear burst
          IRA = {INIT_ADDR[AB-1:BL-2], INC_ADDR[BL-3:0]} ;
        else if( BST_TYPE == 3 ) //32word linear burst
          IRA = {INIT_ADDR[AB-1:BL-1], INC_ADDR[BL-2:0]} ;
      end
      else begin
          IRA = RABUF ;
      end
    end
    else begin
        IRA = RABUF ;
    end
    end
  end
  else begin
        IRA = RABUF ;
  end
end
//////////////////////////////////////////////////////////////////////
//--<< RDY Output >>--
always @( XRESET or AFTER_XOE or AFTER_BA or AFTER_RDY or OUT_HIZ or OUT_HOLD ) begin
  //--< Disable Process >--
  if ( BST_MODE == 1'b1 ) begin
      RDY = 1'bz ;
  end
  else if ( XCEorXOE == 1'b1 || XRESET == 1'b0 ) begin
    if ( OUT_HIZ == 1'b1 ) begin
      RDY = 1'bx ;
    end
    else if ( OUT_HIZ == 1'b0 ) begin
      RDY = 1'bz ;
    end
  end
  //--< Enable Process >--
  else if ( (XCEorXOE == 1'b0) && ( XRESET == 1'b1) ) begin
    //--< Output Delay >--
    if ( AFTER_XOE == 1'b1 || AFTER_RDY == 1'b1) begin
      if ( OUT_HOLD == 1'b0 ) begin
        RDY = 1'bx ;
      end
    end
    //--< Output Buffer Enable >--
    else if ( WAIT_INIT == 1'b1 ) begin
      RDY = 1'b0 ;
    end
    else begin
      RDY = 1'b1 ;
    end
  end
  else begin
    RDY = 1'bz ;
  end
end  // always @( DQ_OUTPUT ) begin

//////////////////////////////////////////////////////////////////////


//--<< DQ Output delay >>--
always @( A ) begin
  if( XAVD == 1'b0 ) begin
  if( AFTER_A == 1'b0 ) begin
    AFTER_A = 1'b1 ;
    if(XCEorXOE==1'b0 && fXCEorXOE!=$time) OUT_HOLD = 1'b1 ;
  end
  else begin
    disable DELAY_A ;
    #(tOH) OUT_HOLD = 1'b0 ;
    -> DQ_OUTPUT ;
    #(tACC-tOH) AFTER_A = 1'b0 ;
  end
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

always @( LOAD_ADDR ) begin
  if( AFTER_LA == 1'b0 ) begin
    if( INIT_FLG ==1'b1 ) begin
      AFTER_LA = 1'b1 ;
      INIT_ACT = 1'b1 ;
    end
  end
  else begin
    disable DELAY_LA ;
    #(tACC) AFTER_LA = 1'b0 ;
    #(tIACC-tACC) INIT_ACT = 1'b0 ;
  end
end
always @( posedge AFTER_LA ) begin : DELAY_LA
  #(tACC) AFTER_LA = 1'b0 ;
  #(tIACC-tACC) INIT_ACT = 1'b0 ;
end

always @( INC_ADDR ) begin
  if( AFTER_BA == 1'b0 ) begin
    AFTER_BA = 1'b1 ;
    if(XCEorXOE==1'b0 && fXCEorXOE!=$time) OUT_HOLD = 1'b1 ;
  end
  else begin
    disable DELAY_BA ;
    #(tBDH) OUT_HOLD = 1'b0 ;
    -> DQ_OUTPUT ;
    #(tBACC-tBDH) AFTER_BA = 1'b0 ;
  end
end
always @( posedge AFTER_BA ) begin : DELAY_BA
  #(tBDH) OUT_HOLD = 1'b0 ;
  -> DQ_OUTPUT ;
  #(tBACC-tBDH) AFTER_BA = 1'b0 ;
end

always @( WAIT_INIT ) begin
  if( AFTER_RDY == 1'b0 ) begin
    AFTER_RDY = 1'b1 ;
    if(XCEorXOE==1'b0 && fXCEorXOE!=$time) OUT_HOLD = 1'b1 ;
  end
  else begin
    disable DELAY_RDY ;
    #(tBDH) OUT_HOLD = 1'b0 ;
    #(tRACC-tBDH) AFTER_RDY = 1'b0 ;
  end
end
always @( posedge AFTER_RDY ) begin : DELAY_RDY
  #(tBDH) OUT_HOLD = 1'b0 ;
  #(tRACC-tBDH) AFTER_RDY = 1'b0 ;
end

//--<< Output to Invalid Data >>--
always @( AFTER_A or AFTER_LA or AFTER_BA or AFTER_XCE or AFTER_XOE or AFTER_XRESET) begin
  if ( BST_MODE == 1'b0 && ((EN_BANK == 1'b0 && HIT_ESA == 1'b0)
      || (EN_BANK == 1'b1 && HIT_ESA == 1'b0 && FSTATE==STAT_ERASE_SUSPEND)) )
    INVALID = AFTER_XCE | AFTER_XOE | AFTER_XRESET | AFTER_LA | AFTER_BA ;
  else
    INVALID = AFTER_A | AFTER_XCE | AFTER_XOE | AFTER_XRESET ;
  -> DQ_OUTPUT ;
end

//--<< Output to High-Z >>--
always @( posedge XCEorXOE ) begin
  if ( XRESET == 1'b1 ) begin
    OUT_HOLD = 1'b1 ; 
    OUT_HIZ = 1'b1 ; 
  end
end
always @( negedge XRESET ) begin
  if ( XCEorXOE == 1'b0 ) begin
    OUT_HOLD = 1'b1 ; 
    OUT_HIZ = 1'b1 ; 
  end
end
always @( posedge OUT_HIZ ) begin
  #(tOH) OUT_HOLD = 1'b0 ;
  -> DQ_OUTPUT ;
  #(tOEZ-tOH) OUT_HIZ = 1'b0 ;
  -> DQ_OUTPUT ;
end

//--<< I/O signal Operation time >>--
always @( A ) begin
  rfA = $time ;
end

always @( DQ ) begin
  if ( XCE==1'b0 && XWE==1'b0 && XOE==1'b1 ) begin
    rfDQ = $time ;
  end
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

always @( XAVD ) begin
  if ( XAVD == 1'b1 ) begin
    rXAVD = $time ;
  end
  else begin
    fXAVD = $time ;
  end
end

always @( CLK ) begin
  if ( CLK == 1'b1 ) begin
    rCLK = $time ;
  end
  else begin
    fCLK = $time ;
  end
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
always @( INV_ADD_event or XCEorXOE or XRESET) begin
  if ( $time > 0 ) begin
  if ( INV_ADD == 1'b1 && XCEorXOE == 1'b0 && XRESET== 1'b1 ) begin
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
always @( rfA ) begin
  if ( rfA != fXCEorXWE && LATCH_FLG == 1'b0 ) begin
  if ( $time > 0 && ( $time - fXCEorXWE ) < tAH && fXCEorXWE > 0) begin
    $write("%t : 1140 Address Hold Time (tAH) was not suitable.\n", $time) ;
  end
  end
end // always @( rfA )

//--< Reset Hold time >--
always @( rfA or fXCEorXOE or fXCEorXWE ) begin
  if ( $time > 0 &&  ( $time - rXRESET ) < tRH && rXRESET > 0) begin
    $write("%t : 1020 /RESET Hold Time (tRH) was not suitable.\n", $time) ;
  end
end // always @( rfA, XCE )

//--< OE,CE High Pulse Time (Toggle Cycle) >--
always @( negedge XCEorXOE ) begin
  if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END
    || FSTATE == STAT_PGMS_HANG || FSTATE == STAT_ERS
    || FSTATE == STAT_ERS_END || FSTATE == STAT_ERASE_HANG
    || FSTATE == STAT_SERS_TIMEOUT || FSTATE == STAT_SERS_START
    || FSTATE == STAT_SERS || FSTATE == STAT_SERS_END
    || FSTATE == STAT_ERASE_SUSPEND ) begin
    if ( $time > 0 ) begin
    if ( ( $time - rXOE ) < tOEPH && rXOE <= rfA ) begin
      $write("%t : 1200 /OE Pulse width High Time (tOEPH) was not suitable.\n", $time) ;
    end
    else if ( ( $time - rXOE ) < tOEH_POLLING ) begin
      $write("%t : 1040 Output Enable Hold Time (tOEH) was not suitable.\n", $time) ;
    end
    else if ( ( $time - rXCE ) < tCEPH && rXCE <= rfA ) begin
      $write("%t : 1210 /CE Pulse width High Time (tCEPH) was not suitable.\n", $time) ;
    end
    end
  end
end // always @( negedge XCEorXOE ) begin

//--< Address Setup time (toggle cycle) >--
always @( negedge XCEorXOE ) begin
  if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END
    || FSTATE == STAT_PGMS_HANG || FSTATE == STAT_ERS
    || FSTATE == STAT_ERS_END || FSTATE == STAT_ERASE_HANG
    || FSTATE == STAT_SERS_TIMEOUT || FSTATE == STAT_SERS_START
    || FSTATE == STAT_SERS || FSTATE == STAT_SERS_END
    || FSTATE == STAT_ERASE_SUSPEND ) begin
    if ( $time > 0 &&  ( $time - rfA ) < tASO && fXOE == $time ) begin
      $write("%t : 1220 Address Setup Time (tASO) was not suitable.\n", $time) ;
    end
  end
end // always @( negedge XCEorXOE )

//--< Address Hold time (toggle cycle) >--
always @( A ) begin
  if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END
    || FSTATE == STAT_PGMS_HANG || FSTATE == STAT_ERS
    || FSTATE == STAT_ERS_END || FSTATE == STAT_ERASE_HANG
    || FSTATE == STAT_SERS_TIMEOUT || FSTATE == STAT_SERS_START
    || FSTATE == STAT_SERS || FSTATE == STAT_SERS_END
    || FSTATE == STAT_ERASE_SUSPEND ) begin
    if ( $time > 0 && ( $time - rXCEorXOE ) < tAHT ) begin
      $write("%t : 1230 Address Hold Time (tAHT) was not suitable.\n", $time) ;
    end
  end
end // always @( A )

//--< Data Setup Time (write cycle) >--
always @( posedge XCEorXWE ) begin
  if ( $time > 0 &&  ( $time - rfDQ ) < tDS ) begin
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


//--< XAVD Pulse width >--
always @( posedge XAVD ) begin
  if ( XCE == 1'b0 ) begin
    if ( $time > 0 &&  ( $time - fXAVD ) < tAVDP ) begin
      $write("%t : 1600 /AVD Pulse width (tAVDP) was not suitable.\n", $time) ;
    end
  end
end

//--< Address Setup time to AVD High >--
always @( posedge XAVD ) begin
  if( XCE == 1'b0 && XCEorXWE == 1'b1 && LATCH_FLG == 1'b0 ) begin
    if ( $time > 0 &&  ( $time - rfA ) < tAAS ) begin
      $write("%t : 1610 Address Setup Time to /AVD High (tAAS) was not suitable.\n", $time) ;
    end
  end
end

//--< Address Hold time from AVD High >--
always @( rfA ) begin
  if ( XCE == 1'b0 && rfA != rXAVD ) begin
    if ( $time > 0 && ( $time - rXAVD ) < tAAH && rXAVD > 0) begin
      $write("%t : 1620 Address Hold Time from /AVD High (tAAH) was not suitable.\n", $time) ;
    end
  end
end

//--< Address,CE,AVD Setup time to CLK >--
always @( ACTIVE_CLK ) begin
  if ( $time != fXAVD && XCE == 1'b0 && XAVD == 1'b0 && XCEorXWE == 1'b1) begin
    if ( $time > 0 &&  ( $time - fXAVD ) < tAVDS ) begin
      $write("%t : 1630 /AVD Setup Time to CLK (tAVDS) was not suitable.\n", $time) ;
    end
    if ( $time > 0 &&  ( $time - rfA ) < tACS ) begin
      $write("%t : 1640 Address Setup Time to CLK (tACS) was not suitable.\n", $time) ;
    end
    if ( $time > 0 &&  ( $time - fXCE ) < tCES ) begin
      $write("%t : 1660 /CE Setup Time to CLK (tCES) was not suitable.\n", $time) ;
    end
  end
  if ( BST_MODE == 1'b0 && XCE == 1'b0 ) begin
    if ( $time > 0 &&  ( $time - fXAVD ) < tAVC && XAVD == 1'b1 ) begin
      $write("%t : 1670 /AVD Setup Time to CLK (tAVC) was not suitable.\n", $time) ;
    end
  end
end

//--< Address Hold time from CLK >--
always @( rfA ) begin
  if ( XCE == 1'b0 && XAVD == 1'b0 && LATCH_FLG == 1'b1 ) begin
  if ( $time > 0 && ( $time - tCLK ) < tACH ) begin
    $write("%t : 1650 Address Hold Time from CLK (tACH) was not suitable.\n", $time) ;
  end
  end
end

//--< AVD Setup time to WE Low >--
always @( negedge XCEorXWE ) begin
  if ( XAVD == 1'b0 ) begin
  if ( $time > 0 &&  ( $time - fXAVD ) < tASW ) begin
    $write("%t : 1700 /AVD Setup Time to /WE Low (tASW) was not suitable.\n", $time) ;
  end
  end
end

//--< AVD Hold time from WE Low >--
always @( posedge XAVD ) begin
  if ( XCEorXWE == 1'b0 ) begin
  if ( $time > 0 && ( $time - fXCEorXWE ) < tAHW ) begin
    $write("%t : 1710 /AVD Hold Time from /WE Low (tAHW) was not suitable.\n", $time) ;
  end
  end
end

//--< WE Setup Time from /AVD High >--
always @( negedge XCEorXWE ) begin
  if ( XAVD == 1'b1 ) begin
  if ( $time > 0 && ( $time - rXAVD ) < tAHW ) begin
    $write("%t : 1720 /WE Setup Time from /AVD High (tAHW) was not suitable.\n", $time) ;
  end
  end
end

//////////////////////////////////////////////////////////////////////
always @( TIMER_INC ) begin
  #1 TIMER = TIMER + 1 ;
end

endmodule
//`endprotect
`endcelldefine
