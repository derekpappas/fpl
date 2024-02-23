//THE `PROTECT `ENDPROTECT DIRECTIVES HAVE BEEN COMMENTED

///////////////////////////////////////////////////////////////////////////
// NOR-type Flash Memory                                                 //
// MBM29DL322TE/BE (4Mx8/2Mx16, boot block)                              //
// Verilog Simulation Model                                              // 
// Version: 1.1a                                                          //
// Date: 2001/01/18                                                      //
// Designed by FUJITSU                                                   //
// module : MBM29DL322E                                                  //
//                                                                       //
//   Copyright (c) FUJITSU LIMITED, 2000.                                //
//   All Rights Reserved. Licensed Library.                              //
///////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ns

`celldefine
module MBM29DL322E(
  A,      // Address Input
  DQ,     // Data Input/Output
  XCE,    // Chip Enable Input
  XOE,    // Output Enable Input
  XWE,    // Write Enable Input
  XRESET, // Hard Reset Input
  XBYTE,  // Byte/Word Configuration Input
  RY_XBY, // Ready/Busy Output
  XWP     // Write Protect Input
);

// External Parameter
parameter SP_VER  = "SP90" ; // Speed Version SP80,SP90,SP120
parameter ERR_FLG = 0      ; // Error Flag  0:Normal, 1:Error
parameter B_TYPE  = "TOP"  ; // Block Type  0:Top, 1:Bottom

//////////////////////////////////////////////////////////////////////
//`protect
//////////////////////////////////////////////////////////////////////
// History                                                          //
// DL16x -> DL322E                                                  //
//                         : 0.01  2000/01/11                       //
// ==> m_dl322e.v 1st Release                                       //
//                         : 1.0   2000/01/17                       //
//                         : 1.1   2000/03/07 modify toggle bit2    //
//                         : 1.1a  2001/01/18 modify AC parameter   //
//////////////////////////////////////////////////////////////////////
// pin width
  parameter AB=21 ; // Address Bus width
  parameter SAB=9 ; // Sector Address Bus width
  parameter W=16 ; // Data Bus width
  parameter BA = 3 ; // Bank Address Bus width (321:6,322:3,323:2,324:1)
  parameter SA=11 ;

  input [AB-1:0] A ;
  inout [W-1:0]  DQ ;
  input XCE,XOE,XWE,XRESET,XBYTE,XWP ;
  output RY_XBY ;

// Architecture
parameter NUM_OF_ADDR  = 1<<(AB) ; // 2**(AB)  -- AB=21
parameter NUM_OF_SECTOR = (1<<(SAB-3)) + 7 ; // 2**(SAB-3)+7  -- SAB=9 -> 71
parameter NUM_OF_BOOT = (1<<3) ; // 2**3 -> 8 // Number of boot Sector
parameter NUM_OF_PROTECT = (1<<(SAB-5)) +NUM_OF_BOOT +1 ;// Number of protect
parameter BANK_SEC = (1<<(SAB-3)) - (1<<(SAB-3-BA)) ; //Bank Sector number

parameter HAB = AB-SAB+3 ; // Hidden ROM Address bus width
parameter NUM_OF_HIROM  = 1<<(HAB) ; // 2**(HAB) -- HAB=15 -> 32K word

// protect
parameter PROTECT_STATUS = {NUM_OF_PROTECT{1'b0}} ; // 0:unprotect, 1:protect

// command
parameter ADDR_PAT1 = 12'b101010101010 ; // AAAh
parameter ADDR_PAT2 = 12'b010101010101 ; // 555h
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
parameter     VERIFY_CMD = 8'b01000000 ; // 40h
parameter  HIROM_ENT_CMD = 8'b10001000 ; // 88h
parameter  HIROM_RST_CMD = 8'b00000000 ; // 00h

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
parameter STAT_QUERY         = 5'b11010 ; // 1Ah
parameter STAT_PROTECT_SETUP = 5'b11011 ; // 1Bh
parameter STAT_PROTECT       = 5'b11100 ; // 1Ch
parameter STAT_PROTECT_VERIFY= 5'b11101 ; // 1Dh

//////////////////////////////////////////////////////////////////////
// register declaration
//   wdt  name         addr
reg [W-1:0] FARRAY [NUM_OF_ADDR-1:0] ;
reg [W-1:0] HARRAY [NUM_OF_HIROM-1:0] ;
reg [4:0] FSTATE, FSTATE_next, FSTATE_PGM_next ;
reg [4:0] FSTATE_tWHWH2_next, FSTATE_ERS_next ;
reg [AB-1:0] ABUF ;
reg ABB, ABBUF ;
reg [SA:0] FADDR ;
reg [W-1:0] FDQ, FDATA, LATCH_DATA ;
reg [W-1:0] DINBUF ;
reg ESP ;
integer TIMER ;
reg [SAB-1:0] ESA ;
reg TOGGLE ;
reg XCEorXOE, XCEorXWE ;
reg AFTER_A, AFTER_XCE, AFTER_XOE ;
reg PGM_XBYTE ;
reg XBYTE_HIZ, XBYTE_ACT ;
reg AFTER_XRESET ;
reg OUT_HOLD, OUT_HIZ ;
reg INVALID ;
integer EA ;
reg FT_MODE ;
time tWHWH1, tWHWH2 ;
reg HIT_ESA, EN_PROTECT;
reg [NUM_OF_SECTOR-1:0] SEL ;
reg RSEL, ASEL ;
reg EN_BANK, SEL_BK1, SEL_BK2 ;
reg [NUM_OF_SECTOR-1:0] PROTECT_REG ;

reg [HAB-1:0] ABUFH ;
reg HIROM, EN_HIROM, EN_HIROM_LA, HIROM_PRO ;
reg [W-1:0] PRO_REG ;
reg INV_ADD ;
reg PGM_FLG ;
reg ATD ;

reg [15:0] MANUFAC_CODE ;
reg [15:0] DEV_CODE ;
integer ISA, ISB ;
integer SEL_BIT ;
reg [SAB-3-1:0] BOOT_ADD ;
reg [BA-1:0] BADDR ;

reg [7:0] CFI_CODE [(1<<7):0] ;

time tACC, tCE, tOE, tDF, tOH, tREADY ;
time tAS, tAH, tDS, tDH, tOEH_READ, tOEH_POLLING, tGHWL, tWP, tWPH,
     tCP, tCPH, tRP, tRH, tBUSY, tOES, tGHEL, tEOE ;
time tASO, tAHT, tOEPH, tCEPH ;

time rfA, rfDQ, rXCE, fXCE, rXOE, fXOE, rXWE, fXWE,
     rXRESET, fXRESET, rXCEorXWE, fXCEorXWE, rXCEorXOE,
     fXCEorXOE ,rfXBYTE, EMB_TIME ;

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
reg OUT_CTL, OUT_CTL_H ;
assign DQ[7:0] = OUT_CTL ? oDQ[7:0] : {8{1'bz}} ;
assign DQ[15:8] = OUT_CTL_H ? oDQ[15:8] : {8{1'bz}} ;
//////////////////////////////////////////////////////////////////////

initial begin : memory_initialize
  integer i ;
  for( i=0 ; i < NUM_OF_ADDR  ; i=i+1 ) FARRAY[i] = {W{1'b1}} ;
  for( i=0 ; i < NUM_OF_HIROM ; i=i+1 ) HARRAY[i] = {W{1'b1}} ;
end

initial begin : dependent_init
  integer i, j ;

  PROTECT_REG = {NUM_OF_SECTOR{1'b0}} ;
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
  XBYTE_HIZ = 0 ;
  XBYTE_ACT = 0 ;
  OUT_HIZ = 0 ;
  OUT_HOLD = 0 ;
  INVALID = 0 ;
  EA = 1 ;
  FT_MODE = 0 ;
  tWHWH1 = 0 ;
  HIT_ESA = 0 ;
  SEL = 0 ;
  RSEL = 0 ;
  ASEL = 0 ;
  RY_XBY = 1'bz ;
  PGM_XBYTE = 1 ;
  EN_BANK = 1'b0 ;
  SEL_BK1 = 1'b0 ;
  SEL_BK2 = 1'b0 ;
  BADDR = {BA{1'b0}} ; 
  HIROM = 1'b0 ;
  EN_HIROM = 1'b0 ;
  EN_HIROM_LA = 1'b0 ;
  HIROM_PRO = 1'b0 ;
  PRO_REG = 1'b0 ;
  PGM_FLG = 1'b0 ;
  ATD = 1'b0 ;

  MANUFAC_CODE = 8'b00000100 ; // 04h

  // dependent on Block Type
  if( B_TYPE == "TOP" ) begin  // Top
    BOOT_ADD = {(SAB-3){1'b1}} ; 
    CFI_CODE[79] = 8'b00000010 ; //Boot description
    DEV_CODE = 8'b01010101 ; // 55h (322)
    for ( i=0 ; i<=NUM_OF_PROTECT-1 ; i=i+1 ) begin
      if( PROTECT_STATUS[i] == 1'b1 ) begin 
        if( i == 0 ) begin
          PROTECT_REG[i] = 1'b1 ;
        end
        else if ( i == 1) begin
          for( j=0 ; j<=2 ; j=j+1 ) PROTECT_REG[i+j] = 1'b1 ;
        end
        else if ( i < (1<<(SAB-5))) begin
          for( j=0 ; j<=3 ; j=j+1 ) PROTECT_REG[4*(i-1)+j] = 1'b1 ;
        end
        else if ( i == (1<<(SAB-5))) begin
          for( j=0 ; j<=2 ; j=j+1 ) PROTECT_REG[4*(i-1)+j] = 1'b1 ;
        end
        else begin
           PROTECT_REG[NUM_OF_SECTOR-NUM_OF_BOOT + i-NUM_OF_BOOT -1] = 1'b1 ;
        end
      end
    end
  end
  else begin // Bottom
    BOOT_ADD = {(SAB-3){1'b0}} ; 
    CFI_CODE[79] = 8'b00000011 ; //Boot description
    DEV_CODE = 8'b01010110 ; // 56h (322)
    for ( i=NUM_OF_PROTECT-1 ; i >=0 ; i=i-1 ) begin
      if( PROTECT_STATUS[i] == 1'b1 ) begin
        if( i == NUM_OF_PROTECT-1 ) begin
          PROTECT_REG[i] = 1'b1 ;
        end
        else if ( i == NUM_OF_PROTECT ) begin
          for( j=0 ; j<=2 ; j=j+1 ) PROTECT_REG[i-j] = 1'b1 ;
        end
        else if ( i < NUM_OF_BOOT ) begin
          for( j=NUM_OF_BOOT-1 ; j<=NUM_OF_BOOT+3 ; j=j+1 )
            PROTECT_REG[4*(i-NUM_OF_BOOT)+j] = 1'b1 ;
        end
        else if ( i == NUM_OF_BOOT ) begin
          for( j=0 ; j<=2 ; j=j+1 ) PROTECT_REG[i+j] = 1'b1 ;
        end
        else begin
          PROTECT_REG[i] = 1'b1 ;
        end
      end
    end
  end

  CFI_CODE[16] = 8'b01010001 ; CFI_CODE[17] = 8'b01010010 ;
  CFI_CODE[18] = 8'b01011001 ; // 16-18  ASCII "QRY"
  CFI_CODE[19] = 8'b00000010 ; CFI_CODE[20] = 8'b00000000 ; //Primary command
  CFI_CODE[21] = 8'b01000000 ; CFI_CODE[22] = 8'b00000000 ; //Primary table 
  CFI_CODE[23] = 8'b00000000 ; CFI_CODE[24] = 8'b00000000 ; //Alternate command
  CFI_CODE[25] = 8'b00000000 ; CFI_CODE[26] = 8'b00000000 ; //Alternate table
  CFI_CODE[27] = 8'b00100111 ; //Vcc min
  CFI_CODE[28] = 8'b00110110 ; //Vcc max
  CFI_CODE[29] = 8'b00000000 ; //Vpp min
  CFI_CODE[30] = 8'b00000000 ; //Vpp max
  CFI_CODE[31] = 8'b00000100 ; //Word write time typ 
  CFI_CODE[32] = 8'b00000000 ; //Buffer write time typ  
  CFI_CODE[33] = 8'b00001010 ; //Sector erase time typ 
  CFI_CODE[34] = 8'b00000000 ; //Chip erase time typ 
  CFI_CODE[35] = 8'b00000101 ; //Word write time max
  CFI_CODE[36] = 8'b00000000 ; //Buffer write time max
  CFI_CODE[37] = 8'b00000100 ; //Sector erase time max
  CFI_CODE[38] = 8'b00000000 ; //Chip erase time max
  CFI_CODE[39] = 8'b00010101 ; //Device size
  CFI_CODE[40] = 8'b00000010 ; // 40-41 Interface description
  CFI_CODE[41] = 8'b00000000 ;
  CFI_CODE[42] = 8'b00000000 ; // 42-43 Malti write byte number max
  CFI_CODE[43] = 8'b00000000 ;
  CFI_CODE[44] = 8'b00000010 ; //Erase block number
  CFI_CODE[45] = 8'b00000111 ;CFI_CODE[46] = 8'b00000000 ;
  CFI_CODE[47] = 8'b01000000 ;CFI_CODE[48] = 8'b00000000 ;
  CFI_CODE[49] = 8'b00101110 ;CFI_CODE[50] = 8'b00000000 ;
  CFI_CODE[51] = 8'b00100000 ;CFI_CODE[52] = 8'b00000000 ;
  CFI_CODE[53] = 8'b00000000 ;CFI_CODE[54] = 8'b00000001 ;
  CFI_CODE[55] = 8'b10000000 ;CFI_CODE[56] = 8'b00000000 ;
  CFI_CODE[57] = 8'b00000000 ;CFI_CODE[58] = 8'b00000000 ;
  CFI_CODE[59] = 8'b00000000 ;CFI_CODE[60] = 8'b00000001 ;
  CFI_CODE[64] = 8'b00000000 ;CFI_CODE[65] = 8'b00000000 ;
  CFI_CODE[66] = 8'b01001001 ; // 64-66 ASCII 8'bPRI"
  CFI_CODE[67] = 8'b00110001 ; //Major version number
  CFI_CODE[68] = 8'b00110001 ; //Minor version number 
  CFI_CODE[69] = 8'b00000000 ; //Address sensitive unlock
  CFI_CODE[70] = 8'b00000010 ; //Erase suspend
  CFI_CODE[71] = 8'b00000001 ; //Sector protection
  CFI_CODE[72] = 8'b00000001 ; //Sector temporary
  CFI_CODE[73] = 8'b00000100 ; //Sector protect algorithm
  CFI_CODE[74] = BANK_SEC ;    //Bank Sector number
  CFI_CODE[75] = 8'b00000000 ; //Burst mode
  CFI_CODE[76] = 8'b00000000 ; //Pege mode
  CFI_CODE[77] = 8'b10000101 ; //Vacc min
  CFI_CODE[78] = 8'b10010101 ; //Vacc max

  // Timing Parameter
   if ( SP_VER == "SP90" ) begin 
    //--<Read Cycle Operation >>
    tACC   =    90 ; tCE    =    90 ; tOE    =    40 ; 
    tDF    =    30 ; tOH    =     0 ; tREADY =    20 ;
    //--<Write Cycle Operation >>
    tAS    =     0 ; tAH    =    45 ; tDS    =    35 ; tDH    =     0 ;
    tASO   =    15 ; tAHT   =     0 ; tCEPH  =    20 ; tOEPH  =    20 ;
    tOEH_READ =  0 ; tOEH_POLLING = 10 ; tGHWL  =     0 ;
    tWP    =    35 ; tWPH   =    30 ; tCP    =    35 ; tCPH   =    30 ;
    tRP    =   500 ; tRH    =   200 ; tBUSY  =    90 ; tOES   =     0 ; 
    tGHEL  =     0 ; tEOE   =    90 ;
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
  rfXBYTE   = 0 ;
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
    if( EN_BANK==1'b1 || HIT_ESA == 1'b1 ) TOGGLE = ~ TOGGLE ;
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
  FADDR = { A[SA-1:0], ABB }; // Command address buffer
  ABUF = A ; // Address buffer (program/erase)
  ABBUF = ABB ; // Address buffer (byte mode)
  PGM_XBYTE = XBYTE ; // Program 
  ABUFH = A[HAB-1:0] ;
  
  if ( XBYTE == 1'b1 ) begin //word mode setup
    tWHWH1 = PGMS_TIME*2 ;
    EA = 1 ;
  end
  else if ( XBYTE == 1'b0 ) begin //byte mode setup
    tWHWH1 = PGMS_TIME ;
    EA = 0 ;
  end
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
    reg [W-1:0] CURRENT_DATA, CARRAY ;
    reg VALID_DATA ;
  begin
    CARRAY = ARRAY_DATA ;
    if ( PGM_XBYTE == 1'b1 ) begin 
      CURRENT_DATA = PGM_DATA ;
      VALID_DATA = ^CARRAY ;
    end
    else if ( PGM_XBYTE == 1'b0 ) begin
      if ( ABBUF==1'b0 ) begin
        CURRENT_DATA = { CARRAY[W-1:8], PGM_DATA[7:0] } ;
        VALID_DATA = ^CARRAY[7:0] ;
      end
      else if( ABBUF==1'b1 ) begin
        CURRENT_DATA = { PGM_DATA[7:0], CARRAY[7:0] } ;
        VALID_DATA = ^CARRAY[W-1:8] ;
      end
    end

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
    if( B_TYPE=="TOP" ) begin
      if( sel_sec >= NUM_OF_SECTOR-NUM_OF_BOOT ) begin // Boot sector
        ISA = ( 1<<(AB) ) - (NUM_OF_SECTOR-sel_sec)*( 1<<(AB-SAB) ) ;
        ISB = 1*( 1<<(AB-SAB) ) -1 ; // 4K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME*2 * 1*(1<<(AB-SAB)) ;
      end
      else begin // Uniform sector
        ISA = ( sel_sec ) * ( 1<<(AB-SAB+3) ) ;
        ISB = 8*( 1<<(AB-SAB) ) -1 ; // 32K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME*2 * 8*(1<<(AB-SAB)) ;
      end
    end 
    else begin // bottom
      if( sel_sec <= NUM_OF_BOOT-1 ) begin // Boot sector
        ISA = ( sel_sec ) * ( 1<<(AB-SAB) ) ;
        ISB = 1*( 1<<(AB-SAB) ) -1 ; // 4K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME*2 * 1*(1<<(AB-SAB)) ;
      end
      else begin // Uniform sector
        ISA = ( sel_sec - (NUM_OF_BOOT-1) ) * ( 1<<(AB-SAB+3) );
        ISB = 8*( 1<<(AB-SAB) ) -1 ; // 32K word
        tWHWH2 = tWHWH2 + SERS_TIME + PGMS_TIME*2 * 8*(1<<(AB-SAB)) ;
      end
    end 
  end 
endtask


//--< Hardware Reset Operation >--
always @(negedge XRESET) begin :C1_XRESET
  integer i,j ;
  reg [W-1:0] CURRENT_DATA ;
  if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG )
  begin
    if ( EN_HIROM_LA == 1'b0 && PROTECT_REG[SEL_BIT] == 1'b0 )
        PROGRAM( FARRAY[ABUF], {W{1'bx}}, 1 ) ;
    else if ( EN_HIROM_LA == 1'b1 && HIROM_PRO == 1'b0 )
        PROGRAM( HARRAY[ABUFH], {W{1'bx}}, 1 ) ;
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
        if( (( B_TYPE=="TOP" &&  i >= NUM_OF_SECTOR-NUM_OF_BOOT )
          || ( B_TYPE=="BOTM" &&  i <= NUM_OF_BOOT-1 )) && HIROM==1'b1 ) begin
            for ( j=0 ; j < NUM_OF_HIROM ; j=j+1 ) HARRAY[j] = {W{1'bx}} ;
        end
        else begin
            for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'bx}} ;
        end
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
  HIROM = 1'b0 ;
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
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else if( ( FADDR[6:0]>>EA == ADDR_PAT1[6:0]>>EA )
          && ( DINBUF[7:0] == QUERY_CMD ) ) begin
          FSTATE = STAT_QUERY ;
        end
        else if( ( DINBUF[7:0] == PROTECT_CMD ) && ESP==1'b0 ) begin
          if( HIROM==1'b1 ) begin
            FSTATE = STAT_PROTECT_SETUP ;
            BADDR = BOOT_ADD[BA-1:0] ;
          end
          else begin
            $write("%t : 1540 Protect Command was ignored. during not Hidden ROM Mode.\n", $time) ;
          end
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end  // STAT_RESET
    STAT_PZ1 : begin
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT2[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT2 ) ) begin
          FSTATE = STAT_PREL ;
        end
        else if ( DINBUF[7:0] == RESUME_CMD && ESP==1'b1 && EN_BANK==1'b1 ) begin
          FSTATE = STAT_SERS_START ;
          ESP = 1'b0 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_PZ1
    STAT_PREL : begin
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == ERS_SETUP_CMD ) && ( ESP == 1'b0 ) ) begin
          FSTATE = STAT_C8 ;
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == PROGRAM_CMD ) ) begin
          FSTATE = STAT_PGM_SETUP ;
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == AS_CMD ) ) begin
          FSTATE = STAT_AS ;
          BADDR = ABUF[AB-1:AB-BA] ;
          HIROM = 1'b0 ;
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == FAST_CMD ) && ( ESP == 1'b0 ) ) begin
          FSTATE = STAT_FAST_MODE ;
          FT_MODE = 1'b1 ;
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == HIROM_ENT_CMD ) && ( ESP == 1'b0 ) ) begin
          FSTATE = STAT_RESET ;
          BADDR = BOOT_ADD[BA-1:0] ;
          HIROM  = 1'b1 ;
        end
        else if ( DINBUF[7:0] == RESUME_CMD && ESP==1'b1 && EN_BANK==1'b1 ) begin
          FSTATE = STAT_SERS_START ;
          ESP = 1'b0 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_PREL
    STAT_C8 : begin
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_C8_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_C8
    STAT_C8_PZ1 : begin
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT2[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT2 ) ) begin
          FSTATE = STAT_C8_PREL ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_C8_PZ1
    STAT_C8_PREL : begin
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
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
          BADDR = ABUF[AB-1:AB-BA] ;
          FT_MODE = 1'b0 ;
          HIROM = 1'b0 ;
        end
        else begin
          $write("%t : 1380 Command was ignored during Fast Mode.\n", $time) ;
        end
      end // STAT_FAST_MODE
    STAT_QUERY : begin
        if ( DINBUF[7:0] == RESET_CMD ) begin
          FSTATE = STAT_RESET ;
        end
        else begin
          $write("%t : 1500 Command was ignored during Query mode.\n", $time) ;
        end
      end // STAT_QUERY
    STAT_PGM_SETUP : begin
        FSTATE = STAT_PGMS ;
        FDATA = DINBUF ;
        if ( PGM_XBYTE == 1'b0 ) FDATA[W-1:8] = {8{1'b0}} ;
        BADDR = ABUF[AB-1:AB-BA] ;
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
          BADDR = ABUF[AB-1:AB-BA] ;
        end
        else if ( DINBUF[7:0] == SUSPEND_CMD ) begin
          if( EN_BANK == 1'b1 ) begin
            FSTATE = STAT_ERASE_SUSPEND ;
            ESP = 1'b1 ;
          end
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_SERS_TIMEOUT
    STAT_SERS_START : begin
      end // STAT_SERS_START
    STAT_SERS : begin
        if ( DINBUF[7:0] == SUSPEND_CMD && EN_BANK == 1'b1 && ASEL == 1'b0 ) begin
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
        if ( DINBUF[7:0] == RESUME_CMD && EN_BANK == 1'b1 ) begin
          FSTATE = STAT_SERS_START ;
          ESP = 1'b0 ;
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end // STAT_ERASE_SUSPEND
    STAT_PROTECT_SETUP : begin
        if( ( DINBUF[7:0] == PROTECT_CMD ) ) begin
          if( ABUF[6]==1'b0 && ABUF[1]==1'b1 && ABUF[0]==1'b0 ) begin
            FSTATE = STAT_PROTECT ;
            BADDR = BOOT_ADD[BA-1:0] ;
          end
          else begin
            $write("%t : 1520 Command was ignored. (A6,A1,A0)=(0,1,0) was not selected.\n", $time) ;
          end
        end
        else if( ( DINBUF[7:0] == VERIFY_CMD ) ) begin
          if( ABUF[6]==1'b0 && ABUF[1]==1'b1 && ABUF[0]==1'b0 ) begin
            FSTATE = STAT_PROTECT_VERIFY ;
            BADDR = BOOT_ADD[BA-1:0] ;
          end
          else begin
            $write("%t : 1520 Command was ignored. (A6,A1,A0)=(0,1,0) was not selected.\n", $time) ;
          end
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          -> FSTATE_RESET_event ;
        end
      end  // STAT_PROTECT_SETUP
    STAT_PROTECT : begin
        if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          $write("%t : 1510 Command was ignored during Sector Protect.\n", $time) ;
        end
      end  // STAT_PROTECT
    STAT_PROTECT_VERIFY : begin
        if( ( DINBUF[7:0] == PROTECT_CMD ) ) begin
          if( ABUF[6]==1'b0 && ABUF[1]==1'b1 && ABUF[0]==1'b0 ) begin
            FSTATE = STAT_PROTECT ;
            BADDR = BOOT_ADD[BA-1:0] ;
          end
          else begin
            $write("%t : 1520 Command was ignored. (A6,A1,A0)=(0,1,0) was not selected.\n", $time) ;
          end
        end
        else if ( ( FADDR[SA:0]>>EA == ADDR_PAT1[SA:0]>>EA )
          && ( DINBUF[7:0] == DATA_PAT1 ) ) begin
          FSTATE = STAT_PZ1 ;
        end
        else begin
          FSTATE = STAT_PROTECT_SETUP ;
          $write("%t : 1550 Invalid Command. Return to Protect Setup Mode.\n", $time) ;
        end
      end  // STAT_PROTECT_VERIFY
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
        else if ( ( PROTECT_REG[SEL_BIT] == 1'b1 && EN_HIROM_LA == 1'b0 )
               || ( HIROM_PRO == 1'b1 && EN_HIROM_LA == 1'b1 ) ) begin
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
            if ( EN_HIROM_LA == 1'b0 )
              PROGRAM( FARRAY[ABUF], {W{1'bx}}, 1 ) ;
            else
              PROGRAM( HARRAY[ABUFH], {W{1'bx}}, 1 ) ;
            FSTATE_PGM_next = STAT_PGMS_HANG ;
            -> FSTATE_PGM_event ;
        end
        else begin
            if ( EN_HIROM_LA == 1'b0 )
              PROGRAM( FARRAY[ABUF], FDATA, 0 ) ;
            else
              PROGRAM( HARRAY[ABUFH], FDATA, 0 ) ;

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
            if( (( B_TYPE=="TOP" &&  i >= NUM_OF_SECTOR-NUM_OF_BOOT )
              || ( B_TYPE=="BOTM" &&  i <= NUM_OF_BOOT-1 )) && HIROM==1'b1 ) begin
              if ( HIROM_PRO==1'b0 ) begin
              SADD_SET( i ) ;
               if ( ERR_FLG==1'b1 )
                 for ( j=0 ; j < NUM_OF_HIROM ; j=j+1 ) HARRAY[j] = {W{1'bx}} ;
               else
                 for ( j=0 ; j < NUM_OF_HIROM ; j=j+1 ) HARRAY[j] = {W{1'b1}} ;
              end
            end
            else begin
              SADD_SET( i ) ;
               if ( ERR_FLG==1'b1 )
                 for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'bx}} ;
               else
                 for ( j=0 ; j<= ISB ; j=j+1 ) FARRAY[ ISA + j ] = {W{1'b1}} ;
            end
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
        if ( EN_HIROM_LA == 1'b1 ) begin
            HIROM_PRO = 1'b1 ;
            #(tPROTECT)
            FSTATE_next = STAT_PROTECT_SETUP ;
            -> FSTATE_event ;
        end
        else begin
            FSTATE_next = STAT_PROTECT_SETUP ;
            -> FSTATE_event ;
            $write("%t : 1530 Protect Commnad was ignored. Hidden ROM Area has been not selected.\n", $time) ;
        end
      end // STAT_PROTECT
    STAT_PROTECT_VERIFY : begin
        if ( EN_HIROM_LA == 1'b1 ) begin
            PRO_REG = HIROM_PRO ;
        end
        else begin
            PRO_REG = {W{1'bx}} ;
            $write("%t : 1560 Address invalid. Hidden ROM Area has been not selected.\n", $time) ;
        end
      end // STAT_PROTECT_VERIFY
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
always @( FSTATE or A or ABB or EN_HIROM ) begin :C1_LATCH_DATA
  reg [W-1:0] WDATA ;
  reg [HAB-1:0] A_HIROM ;
  A_HIROM = A[HAB-1:0] ;
  if ( EN_HIROM == 1'b0 ) WDATA = FARRAY[A] ;
  else                    WDATA = HARRAY[A_HIROM] ;
  if ( XBYTE == 1'b1 ) begin
      LATCH_DATA = WDATA ;
  end
  else if ( XBYTE == 1'b0 && XBYTE_HIZ == 1'b0 ) begin
      LATCH_DATA[15:8] = {8{1'bx}} ;
      if      ( ABB==1'b1 ) LATCH_DATA[7:0] = WDATA[15:8] ;
      else if ( ABB==1'b0 ) LATCH_DATA[7:0] = WDATA[7:0] ;
  end
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
         || (EN_BANK == 1'b0 && FSTATE != STAT_QUERY) ) begin
    //--<Normal mode >--
    if ( HIT_ESA == 1'b0 || FSTATE == STAT_SERS_TIMEOUT ) begin
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
        OUTBUF[5] = 1'b0 ;
        OUTBUF[4] = 1'bx ;
        OUTBUF[3] = 1'b0 ;
        OUTBUF[2] = TOGGLE ;
        OUTBUF[1] = 1'bx ;
        OUTBUF[0] = 1'bx ;
        if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END ) begin
          OUTBUF[7] = ~ FDATA[7] ;
          OUTBUF[6] = TOGGLE ;
        end
        else begin
          OUTBUF[7] = 1'b1 ;
          OUTBUF[6] = 1'b1 ;
        end
    end
  end
  //--<Autoselect mode Output>--
  else if ( FSTATE == STAT_AS ) begin
      if ( A[7:0] == MANUFAC_ADDR ) begin
        OUTBUF = { {8{1'b0}}, MANUFAC_CODE } ;
      end
      else if ( A[7:0] == DEVICE_ADDR ) begin
        OUTBUF = { 8'b00100010, DEV_CODE } ;
      end
      else if ( A[7:0] == PROTECT_ADDR ) begin
        OUTBUF = { {(W-1){1'b0}}, EN_PROTECT } ;
      end
      else begin
        OUTBUF = {W{1'bx}} ;
      end
  end
  //--<Query mode Output>--
  else if ( FSTATE == STAT_QUERY ) begin
      if ( CFI_CODE[A[6:0]] === 8'bx ) begin
        OUTBUF = {W{1'bx}} ;
      end
      else begin
        OUTBUF[15:8] = {8{1'b0}} ;
        OUTBUF[7:0] = CFI_CODE[A[6:0]] ;
      end
  end
  //--<Protect Verify mode Output>--
  else if ( FSTATE == STAT_PROTECT_VERIFY ) begin
        OUTBUF = PRO_REG ;
  end
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
      OUTBUF[2] = 1'b1 ;
      OUTBUF[1] = 1'bx ;
      OUTBUF[0] = 1'bx ;
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
      OUTBUF[7:0] = {8{1'bx}} ;
    end
  end
  -> DQ_OUTPUT ;
  end
end  // C1_OUTBUF

//--<< Output Buffer Control >>--
always @( DQ_OUTPUT ) begin :C1_OUTPUT
  //--<< High Byte Output >>--
  //--< Disable Process >--
  if ( XBYTE == 1'b0 ) begin
    if ( XBYTE_HIZ == 1'b1 && XCEorXOE == 1'b0 && XRESET == 1'b1 ) begin
      oDQ[15:8] = {8{1'bx}} ;
      OUT_CTL_H = 1'b1 ;
    end  
    else if ( XBYTE_HIZ == 1'b0 ) begin
      oDQ[15:8] = {8{1'bz}} ;
      OUT_CTL_H = 1'b0 ;
    end  
  end 
  else if ( XCEorXOE == 1'b1 || XRESET == 1'b0 ) begin
    if ( OUT_HIZ == 1'b1 ) begin
      oDQ[15:8] = {8{1'bx}} ;
      OUT_CTL_H = 1'b1 ;  
    end  
    else if ( OUT_HIZ == 1'b0 ) begin
      oDQ[15:8] = {8{1'bz}} ;
      OUT_CTL_H = 1'b0 ;
    end
  end
  //--< Enable Process >--
  else if ( (XCEorXOE == 1'b0) && ( XRESET == 1'b1) && (XBYTE==1'b1) ) begin
    //--< Output Delay >--
    if ( INVALID == 1'b1 || XBYTE_ACT==1'b1 ) begin
      if ( OUT_HOLD == 1'b0 ) begin
        oDQ[15:8] = {8{1'bx}} ;
        OUT_CTL_H = 1'b1 ;
      end
    end
    //--< Output Buffer Enable >--
    else begin
      oDQ[15:8] = OUTBUF[15:8] ;
      OUT_CTL_H = 1'b1 ;
    end
  end 
  else begin
    oDQ[15:8] = {8{1'bz}} ;
    OUT_CTL_H = 1'b0 ;
  end 

  //--<< Low Byte Output >>--
  //--< Disable Process >--
  if ( XCEorXOE == 1'b1 || XRESET == 1'b0 ) begin
    if ( OUT_HIZ == 1'b1 ) begin
      oDQ[7:0] = {8{1'bx}} ;
      OUT_CTL = 1'b1 ;
    end
    else if ( OUT_HIZ == 1'b0 ) begin
      oDQ[7:0] = {8{1'bz}} ;
      OUT_CTL = 1'b0 ;
    end
  end
  //--< Enable Process >--
  else if ( (XCEorXOE == 1'b0) && ( XRESET == 1'b1) ) begin
    //--< Output Delay >--
    if ( INVALID == 1'b1 ) begin
      if ( OUT_HOLD == 1'b0 ) begin
        oDQ[7:0] = {8{1'bx}} ;
        OUT_CTL = 1'b1 ;
      end
    end
    //--< Output Buffer Enable >--
    else begin
      oDQ[7:0] = OUTBUF[7:0] ;
      OUT_CTL = 1'b1 ;
    end
  end
  else begin
    oDQ[7:0] = {8{1'bz}} ;
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
  begin
    if ( add[SAB-1:3] == BOOT_ADD ) begin // Boot Sector (4k word)
      if ( B_TYPE == "TOP" ) SEL_BIT = add[2:0] + NUM_OF_SECTOR - NUM_OF_BOOT ;
      else                   SEL_BIT = add[2:0] ;
    end
    else begin // Uniform Sector (32k word)
      if ( B_TYPE == "TOP" ) SEL_BIT = add[SAB-1:3] ;
      else                   SEL_BIT = add[SAB-1:3] + NUM_OF_BOOT-1 ;
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

//--<< Bank Address Selector >>--
  always @( BADDR or SEL or FSTATE ) begin : BANK_SELECT
    if( FSTATE==STAT_SERS_START || FSTATE==STAT_SERS || FSTATE==STAT_SERS_END
     || FSTATE==STAT_ERASE_SUSPEND || FSTATE == STAT_ERASE_HANG 
     || FSTATE==STAT_ERS || FSTATE==STAT_ERS_END ) begin
      if ( B_TYPE == "TOP" ) begin
          SEL_BK1 = |SEL[NUM_OF_SECTOR-1:BANK_SEC] ;
          SEL_BK2 = |SEL[BANK_SEC-1:0] ;
      end
      else begin
          SEL_BK1 = |SEL[NUM_OF_SECTOR-BANK_SEC-1:0] ;
          SEL_BK2 = |SEL[NUM_OF_SECTOR-1:NUM_OF_SECTOR-BANK_SEC] ;
      end
    end
    else begin
        if(  BADDR == BOOT_ADD[BA-1:0] ) begin //Boot Sector(Bank1)
            SEL_BK1 = 1'b1 ;
            SEL_BK2 = 1'b0 ;
        end
        else begin //Uniform Sector(Bank2)
            SEL_BK1 = 1'b0 ;
            SEL_BK2 = 1'b1 ;
        end
    end
  end

  always @( FSTATE or A or SEL_BK1 or SEL_BK2 ) begin : BANK_ENABLE
    reg EN_BOOT ;
    if( FSTATE==STAT_PGMS || FSTATE==STAT_PGMS_END || FSTATE==STAT_PGMS_HANG
     || FSTATE==STAT_AS || FSTATE==STAT_AS_INVALID
     || FSTATE==STAT_SERS_TIMEOUT || FSTATE==STAT_SERS_START
     || FSTATE==STAT_SERS || FSTATE==STAT_SERS_END
     || FSTATE==STAT_ERASE_SUSPEND || FSTATE == STAT_ERASE_HANG
     || FSTATE==STAT_ERS || FSTATE==STAT_ERS_END || HIROM==1'b1 ) begin
      if( SEL_BK1==1'b1 && SEL_BK2==1'b1 ) begin
          EN_BANK = 1'b1 ;
      end
      else begin
        if(  A[AB-1:AB-BA] == BOOT_ADD[BA-1:0] ) begin
            EN_BOOT = 1'b0 ;
        end
        else begin
            EN_BOOT = 1'b1 ;
        end
        if( SEL_BK1==1'b1 && EN_BOOT==1'b0 ) begin 
            EN_BANK = 1'b1 ;
        end
        else if( SEL_BK2==1'b1 && EN_BOOT==1'b1 ) begin
            EN_BANK = 1'b1 ;
        end
        else begin 
            EN_BANK = 1'b0 ;
        end
      end
    end
    else begin
      EN_BANK = 1'b0 ;
    end
  end

//--<< Byte Switch Delay >>--
always @( XBYTE ) begin : XBYTE_DELAY
  if ( XBYTE == 1'b0 ) begin
    #0
      XBYTE_HIZ = 1'b1 ;
    #tOE 
      XBYTE_HIZ = 1'b0 ;
  end
  else if ( XBYTE ==1'b1 ) begin
    #0
      XBYTE_ACT = 1'b1 ;
    #tACC
      XBYTE_ACT = 1'b0 ;
  end
end // always @( XBYTE ) begin : XBYTE_DELAY

always @( XBYTE_HIZ or XBYTE_ACT ) begin
  -> DQ_OUTPUT ;
end

//< Byte Address setup>
always @( A or DQ ) begin
  case ( XBYTE )
    0 : begin // Byte mode
        if ( XBYTE_HIZ == 1'b0 ) begin
          ABB = DQ[15] ;
          FDQ = { {8{1'b0}} , DQ[7:0] } ;
        end
      end
    1 : begin // Word mode
        ABB = 1'b0 ;
        FDQ = DQ ;
      end
    default : begin
      end
  endcase  
end

//--<< Write Protect Operation >>--
always @( XWP ) begin
  if ( XWP == 1'b0 ) begin
    if ( B_TYPE == "TOP" ) begin
      PROTECT_REG[NUM_OF_SECTOR-1:NUM_OF_SECTOR-2] = 2'b11 ;
    end
    else begin
      PROTECT_REG[1:0] = 2'b11 ;
    end
  end
  else if ( XWP == 1'b1 ) begin
    if ( B_TYPE == "TOP" ) begin
      if ( PROTECT_STATUS[NUM_OF_BOOT-1]==1'b0 )
        PROTECT_REG[NUM_OF_SECTOR-1:NUM_OF_SECTOR-2] = 2'b00 ;
    end
    else begin
      if ( PROTECT_STATUS[0]==1'b0 ) PROTECT_REG[1:0] = 2'b00 ;
    end
  end
end

//--<< Protect Status >>--
always @( A or PROTECT_REG or EN_HIROM ) begin : PROTECT_ENABLE
  SELECT_BIT( A[AB-1:AB-SAB] ) ;
  if ( PROTECT_REG[SEL_BIT] == 1'b1 && EN_HIROM==1'b0 )
     EN_PROTECT = 1'b1 ;
  else if ( HIROM_PRO == 1'b1 && EN_HIROM == 1'b1 )
     EN_PROTECT = 1'b1 ;
  else
     EN_PROTECT = 1'b0 ;
end

//--<< Hidden ROM Area Selecter >>--
always @( A or ABUF or HIROM ) begin
  if ( HIROM == 1'b0 ) begin
      EN_HIROM = 1'b0 ;
      EN_HIROM_LA = 1'b0 ;
  end
  else begin
    if ( A[AB-1:AB-SAB+3] == BOOT_ADD ) 
      EN_HIROM = 1'b1 ;
    else
      EN_HIROM = 1'b0 ;
    if ( ABUF[AB-1:AB-SAB+3] == BOOT_ADD ) 
      EN_HIROM_LA = 1'b1 ;
    else
      EN_HIROM_LA = 1'b0 ;
  end
end

//--<< DQ Output delay >>--
always @( A or ABB ) begin
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
always @( A or ABB ) begin
  rfA = $time ;
end

always @( FDQ ) begin
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

always @( XBYTE ) begin
  rfXBYTE = $time ;
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
always @( A or ABB) begin
  if ( ^{A, ABB} == 1'b0 || ^{A, ABB} == 1'b1 ) begin
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
always @( A or ABB ) begin
  if ( $time > 0 && ( $time - fXCEorXWE ) < tAH && fXCEorXWE > 0) begin
    $write("%t : 1140 Address Hold Time (tAH) was not suitable.\n", $time) ;
  end
  if ( $time > 0 &&  ( $time - rXRESET ) < tRH && rXRESET > 0) begin
    $write("%t : 1020 /RESET Hold Time (tRH) was not suitable.\n", $time) ;
  end
end // always @( A or ABB)

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
    else if ( ( $time - rXCE ) < tCEPH && rXOE <= rfA ) begin
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
always @( A or ABB ) begin
  if ( FSTATE == STAT_PGMS || FSTATE == STAT_PGMS_END
    || FSTATE == STAT_PGMS_HANG || FSTATE == STAT_ERS
    || FSTATE == STAT_ERS_END || FSTATE == STAT_ERASE_HANG
    || FSTATE == STAT_SERS_TIMEOUT || FSTATE == STAT_SERS_START
    || FSTATE == STAT_SERS || FSTATE == STAT_SERS_END
    || FSTATE == STAT_ERASE_SUSPEND ) begin
    if ( $time > 0 && ( $time - fXCEorXOE ) < tAHT ) begin
      $write("%t : 1230 Address Hold Time (tAHT) was not suitable.\n", $time) ;
    end
  end
end // always @( A or ABB)

//--< Data Setup Time (write cycle) >--
always @( posedge XCEorXWE ) begin
  if ( $time > 0 &&  ( $time - rfDQ ) < tDS && $time!=rfDQ ) begin
    $write("%t : 1150 Data Setup Time (tDS) was not suitable.\n", $time) ;
  end
end // always @( posedge XCEorXWE ) begin

//--< Data Hold Time (write cycle) >--
always @( FDQ ) begin
  if ( $time > 0 &&  ( $time - rXCEorXWE ) < tDH ) begin
    $write("%t : 1160 Data Hold Time (tDH) was not suitable.\n", $time) ;
  end
end // always @( FDQ ) begin

//--< OE,WE falling Check (write cycle) >--
always @( negedge XCE or negedge XWE or negedge XOE ) begin
  if ( XCE == 1'b0 && XWE == 1'b0 && XOE == 1'b0 ) begin
    $write("%t : 1190 /WE and /OE were 'Low' at sametime.\n", $time) ;
  end
end

//--< XBYTE Setup time (write cycle) >--
always @( negedge XCEorXWE ) begin
  if ( FSTATE == STAT_PGM_SETUP ) begin
    if ( $time > 0 &&  ( $time - rfXBYTE ) < tAS ) begin
      $write("%t : 1170 /BYTE Setup Time (tSET) was not suitable.\n", $time) ;
    end
  end
end // always @( negedge XCEorXWE )

//--< XBYTE Hold time (write cycle) >--
always @( XBYTE ) begin
  if ( FSTATE == STAT_PGM_SETUP ) begin
    if ( $time > 0 && ( $time - fXCEorXWE ) < tAH ) begin
      $write("%t : 1180 /BYTE Hold Time (tHOLD) was not suitable.\n", $time) ;
    end
  end
end // always @( XBYTE )

//////////////////////////////////////////////////////////////////////
always @( TIMER_INC ) begin
  #1 TIMER = TIMER + 1 ;
end

endmodule
//`endprotect
`endcelldefine
