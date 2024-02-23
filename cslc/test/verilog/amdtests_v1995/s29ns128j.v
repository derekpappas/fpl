//////////////////////////////////////////////////////////////////////////////
//  File name : s29ns128j.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  | author:     | mod date:   | changes made:
//    V1.0      M.Radmanovic  04 Sep 10    Initial release
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           s29ns128j
//
//  Description:   128Mbit (8M x16-Bit) Simultaneous opration, Burst mode,
//                 Top boot sector
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns
 ////////////////////////////////////////////////
 // Top level module, FLASH and SRAM as instances
 ////////////////////////////////////////////////
module s29ns128j
(
    A22      ,
    A21      ,
    A20      ,
    A19      ,
    A18      ,
    A17      ,
    A16      ,

    DQ15     ,
    DQ14     ,
    DQ13     ,
    DQ12     ,
    DQ11     ,
    DQ10     ,
    DQ9      ,
    DQ8      ,
    DQ7      ,
    DQ6      ,
    DQ5      ,
    DQ4      ,
    DQ3      ,
    DQ2      ,
    DQ1      ,
    DQ0      ,

    CENeg    ,
    AVDNeg   ,
    OENeg    ,
    WENeg    ,
    RESETNeg ,
    CLK      ,
    WPNeg    ,
    Vpp      ,
    RDY      );

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
    input  A22  ;
    input  A21  ;
    input  A20  ;
    input  A19  ;
    input  A18  ;
    input  A17  ;
    input  A16  ;

    inout  DQ15  ;
    inout  DQ14  ;
    inout  DQ13  ;
    inout  DQ12  ;
    inout  DQ11  ;
    inout  DQ10  ;
    inout  DQ9   ;
    inout  DQ8   ;
    inout  DQ7   ;
    inout  DQ6   ;
    inout  DQ5   ;
    inout  DQ4   ;
    inout  DQ3   ;
    inout  DQ2   ;
    inout  DQ1   ;
    inout  DQ0   ;

    input  CENeg    ;
    input  AVDNeg   ;
    input  OENeg    ;
    input  WENeg    ;
    input  RESETNeg ;
    input  CLK      ;
    input  WPNeg    ;
    input  Vpp      ;
    output RDY       ;
// interconnect path delay signals

    wire  A22_ipd  ;
    wire  A21_ipd  ;
    wire  A20_ipd  ;
    wire  A19_ipd  ;
    wire  A18_ipd  ;
    wire  A17_ipd  ;
    wire  A16_ipd  ;

    wire  DQ15_ipd  ;
    wire  DQ14_ipd  ;
    wire  DQ13_ipd  ;
    wire  DQ12_ipd  ;
    wire  DQ11_ipd  ;
    wire  DQ10_ipd  ;
    wire  DQ9_ipd   ;
    wire  DQ8_ipd   ;
    wire  DQ7_ipd   ;
    wire  DQ6_ipd   ;
    wire  DQ5_ipd   ;
    wire  DQ4_ipd   ;
    wire  DQ3_ipd   ;
    wire  DQ2_ipd   ;
    wire  DQ1_ipd   ;
    wire  DQ0_ipd   ;

    wire [22 : 0] A;
    assign A = {
                A22_ipd,
                A21_ipd,
                A20_ipd,
                A19_ipd,
                A18_ipd,
                A17_ipd,
                A16_ipd,
                DQ15_ipd,
                DQ14_ipd,
                DQ13_ipd,
                DQ12_ipd,
                DQ11_ipd,
                DQ10_ipd,
                DQ9_ipd,
                DQ8_ipd,
                DQ7_ipd,
                DQ6_ipd,
                DQ5_ipd,
                DQ4_ipd,
                DQ3_ipd,
                DQ2_ipd,
                DQ1_ipd,
                DQ0_ipd };

    wire [15 : 0 ] DIn;
    assign DIn = {DQ15_ipd,
                  DQ14_ipd,
                  DQ13_ipd,
                  DQ12_ipd,
                  DQ11_ipd,
                  DQ10_ipd,
                  DQ9_ipd,
                  DQ8_ipd,
                  DQ7_ipd,
                  DQ6_ipd,
                  DQ5_ipd,
                  DQ4_ipd,
                  DQ3_ipd,
                  DQ2_ipd,
                  DQ1_ipd,
                  DQ0_ipd };

    wire [15 : 0 ] DOut;
    assign DOut = {DQ15,
                  DQ14,
                  DQ13,
                  DQ12,
                  DQ11,
                  DQ10,
                  DQ9,
                  DQ8,
                  DQ7,
                  DQ6,
                  DQ5,
                  DQ4,
                  DQ3,
                  DQ2,
                  DQ1,
                  DQ0 };

    wire  CENeg_ipd    ;
    wire  CSNeg_ipd   ;
    wire  AVDNeg_ipd   ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  RESETNeg_ipd ;
    wire  CLK_ipd      ;
    wire  WPNeg_ipd    ;
    wire  Vpp_ipd      ;

    reg ESTART_T1   ; // Start TimeOut
    reg ESTART_T1_in;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

    wire  DQ15_zd  ;
    wire  DQ14_zd  ;
    wire  DQ13_zd  ;
    wire  DQ12_zd  ;
    wire  DQ11_zd  ;
    wire  DQ10_zd  ;
    wire  DQ9_zd   ;
    wire  DQ8_zd   ;
    wire  DQ7_zd   ;
    wire  DQ6_zd   ;
    wire  DQ5_zd   ;
    wire  DQ4_zd   ;
    wire  DQ3_zd   ;
    wire  DQ2_zd   ;
    wire  DQ1_zd   ;
    wire  DQ0_zd   ;

    wire  DQ15_Pass;
    wire  DQ14_Pass;
    wire  DQ13_Pass;
    wire  DQ12_Pass;
    wire  DQ11_Pass;
    wire  DQ10_Pass;
    wire  DQ9_Pass;
    wire  DQ8_Pass;
    wire  DQ7_Pass;
    wire  DQ6_Pass;
    wire  DQ5_Pass;
    wire  DQ4_Pass;
    wire  DQ3_Pass;
    wire  DQ2_Pass;
    wire  DQ1_Pass;
    wire  DQ0_Pass;

    reg [15 : 0] DOut_zd;
    assign {DQ15_zd,
            DQ14_zd,
            DQ13_zd,
            DQ12_zd,
            DQ11_zd,
            DQ10_zd,
            DQ9_zd,
            DQ8_zd,
            DQ7_zd,
            DQ6_zd,
            DQ5_zd,
            DQ4_zd,
            DQ3_zd,
            DQ2_zd,
            DQ1_zd,
            DQ0_zd  } = DOut_zd;

    reg [15 : 0] DOut_Pass;
    assign {DQ15_Pass,
            DQ14_Pass,
            DQ13_Pass,
            DQ12_Pass,
            DQ11_Pass,
            DQ10_Pass,
            DQ9_Pass,
            DQ8_Pass,
            DQ7_Pass,
            DQ6_Pass,
            DQ5_Pass,
            DQ4_Pass,
            DQ3_Pass,
            DQ2_Pass,
            DQ1_Pass,
            DQ0_Pass  } = DOut_Pass;

    reg RDY_zd;
    reg RDY_Pass;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name = "none";
    parameter TimingModel     = "DefaultTimingModel";

    parameter MemSize         = 24'h7FFFFF;
    parameter PartID          = "s29ns128j";
    parameter MaxData         = 16'hFFFF; // 65535;
    parameter SecSize         = 16'h8000; // secsize
    parameter SubSecSize      = 16'h2000; // secsize
    parameter BankNum         = 4;
    parameter SecNum          = 256;
    parameter SecNumBank      = 64;
    parameter SubSecNum       = 4;
    parameter HiAddrBit       = 22;
    parameter LowSecAddrBit   = 15;
    parameter TopSec          = 255;
    parameter BurstBound      = 64;
    parameter ComandBurstInit = 8'hE5;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ERS_ACT  ; ////Erase Suspend

    reg PDONE    ; ////Prog. Done
    reg PSTART   ; ////Start Programming
    //Program location is in protected sector
    reg PERR     ;

    reg EDONE    ; ////Ers. Done
    reg ESTART   ; ////Start Erase
    reg ESUSP    ; ////Suspend Erase
    reg ERES     ; ////Resume Erase
    //All sectors selected for erasure are protected
    reg EERR     ;
    //Sectors selected for erasure
    reg [SecNum-1:0] Ers_Queue; // = SecNum'b0;
    reg [SubSecNum-1:0] Ers_SubTop_Queue ;

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SA = 0;         // 0 - SecNum
    integer SSA= 0;         // 0 SubSec number
    //Address within sector
    integer Address = 0;        // 0 - SecSize
    reg[HiAddrBit:0] AddressLatch;

    //A19:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer Mem[0:MemSize];
    //Sector Protection Status
    reg [SecNum-1:0] Sec_Prot=~(0);
    reg [SecNum-1:0] Sec_ProtTmp=~(0);
    //Sector Protection for top 4 sectors
    reg [SubSecNum-1:0] SubSecTop_Prot=~(0);
    reg [SubSecNum-1:0] SubSecTop_ProtTmp=~(0);
    integer CFI_array[16:92];
    integer sssa[0:SubSecNum-1];
    integer ssea[0:SubSecNum-1] ;

    // Burst mode signals
    reg [7:0] BurstModeReg;
    reg [2:0] BurstMode;
    reg [2:0] BurstWait;

    reg Viol = 1'b0;

    reg [BankNum-1:0] BankAutosel;
    reg [BankNum-1:0] BankBusy;
    reg       Start_burst;
    reg       End_burst;
    integer cnt = 0;

    reg ASynchroMod = 1'b1;
    reg oe = 1'b0;
    event oe_event;

    event initOK;
    //Status reg.
    reg[7:0] Status = 8'b0;

    // iterator for FOR loop
    integer i,j,k;
///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
 buf   (A22_ipd, A22);
 buf   (A21_ipd, A21);
 buf   (A20_ipd, A20);
 buf   (A19_ipd, A19);
 buf   (A18_ipd, A18);
 buf   (A17_ipd, A17);
 buf   (A16_ipd, A16);

 buf   (DQ15_ipd, DQ15);
 buf   (DQ14_ipd, DQ14);
 buf   (DQ13_ipd, DQ13);
 buf   (DQ12_ipd, DQ12);
 buf   (DQ11_ipd, DQ11);
 buf   (DQ10_ipd, DQ10);
 buf   (DQ9_ipd , DQ9 );
 buf   (DQ8_ipd , DQ8 );
 buf   (DQ7_ipd , DQ7 );
 buf   (DQ6_ipd , DQ6 );
 buf   (DQ5_ipd , DQ5 );
 buf   (DQ4_ipd , DQ4 );
 buf   (DQ3_ipd , DQ3 );
 buf   (DQ2_ipd , DQ2 );
 buf   (DQ1_ipd , DQ1 );
 buf   (DQ0_ipd , DQ0 );

 buf   (CENeg_ipd    , CENeg    );
 buf   (AVDNeg_ipd   , AVDNeg   );
 buf   (OENeg_ipd    , OENeg    );
 buf   (WENeg_ipd    , WENeg    );
 buf   (RESETNeg_ipd , RESETNeg );
 buf   (CLK_ipd      , CLK      );
 buf   (Vpp_ipd      , Vpp      );
 buf   (WPNeg_ipd    , WPNeg    );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
 nmos   (DQ15,   DQ15_Pass , 1);
 nmos   (DQ14,   DQ14_Pass , 1);
 nmos   (DQ13,   DQ13_Pass , 1);
 nmos   (DQ12,   DQ12_Pass , 1);
 nmos   (DQ11,   DQ11_Pass , 1);
 nmos   (DQ10,   DQ10_Pass , 1);
 nmos   (DQ9 ,   DQ9_Pass , 1);
 nmos   (DQ8 ,   DQ8_Pass , 1);
 nmos   (DQ7 ,   DQ7_Pass , 1);
 nmos   (DQ6 ,   DQ6_Pass , 1);
 nmos   (DQ5 ,   DQ5_Pass , 1);
 nmos   (DQ4 ,   DQ4_Pass , 1);
 nmos   (DQ3 ,   DQ3_Pass , 1);
 nmos   (DQ2 ,   DQ2_Pass , 1);
 nmos   (DQ1 ,   DQ1_Pass , 1);
 nmos   (DQ0 ,   DQ0_Pass , 1);

 nmos   (RDY  ,   RDY_Pass   , 1);

 wire deg;
 reg ClkOe_en = 1'b0;
 reg ClkAddr_en = 1'b1;
 reg ClkAddr_tmp = 1'b1;
 reg clk_RdyOe = 1'b1;
 reg ADDRDQ = 0;

 wire OE_en;
 reg  FROMCE, FROMOE, FROMADDR, FROMCLK, FROMCLK_RDY, FROMOE_RDY;
 reg  close_buffer;
 reg  PtEn_tmp = 1'b1;
 wire SyncEn;
 wire PathEnable;
 assign PathEnable = PtEn_tmp;
 assign SyncEn  = ~AVDNeg & ~ASynchroMod & ~CENeg;
 wire SyncData;
 assign SyncData  = AVDNeg & ~ASynchroMod & ~CENeg & RESETNeg & RDY === 1'b1;
 wire ASynchro;
 assign ASynchro = ASynchroMod;
 wire clk_out;
 assign clk_out = ClkOe_en && ClkAddr_en&& ~OENeg && ~CENeg && ~ASynchroMod &&
        PathEnable;

/////////////////////////////////////////////
// Timing check and propagation delay section
/////////////////////////////////////////////
specify

        // tipd delays: interconnect path delays , mapped to input port delays.
        // In Verilog is not necessary to declare any tipd_ delay variables,
        // they can be taken from SDF file
        // With all the other delays real delays would be taken from SDF file
                        // tpd delays
     specparam           tpd_A0_DQ0              =1;
     specparam           tpd_CENeg_DQ0           =1;
     specparam           tpd_OENeg_DQ0           =1;
     specparam           tpd_CLK_DQ0             =1;
     specparam           tpd_OENeg_RDY           =1;
     specparam           tpd_CLK_RDY             =1;

     // Setup values
     // Asynchronous write //tAS, async, WENeg \
     specparam           tsetup_A0_AVDNeg          =1;
                         //tDS, WENeg /
     specparam           tsetup_DQ0_WENeg          =1;
                         //tCS, CENeg LOW, WENeg \
     specparam           tsetup_CENeg_WENeg        =1;
     // Synchronous write //tAS for synchro, WENeg high , AVDNeg /
     specparam           tsetup_DQ0_CLK            =1;
     specparam           tsetup_A0_CLK             =1;
                         //tGHWL, OENeg HIGH , WENeg \
     specparam           tsetup_OENeg_WENeg        =1;
     specparam           tsetup_WENeg_OENeg        =1;

     // Burst mode       //tCES  , CE LOW    , CLK /
     specparam           tsetup_CENeg_CLK        =1;
     specparam           tsetup_AVDNeg_CLK       =1;
     specparam           tsetup_RDY_CLK          =1;

     // thold values: hold times
     specparam           thold_CENeg_RESETNeg    =1; //tRH  edge /
     specparam           thold_OENeg_RESETNeg    =1; //tRH  edge /
     // Synchro address latch
     specparam           thold_A0_CLK            =1; //tACH edge /
     specparam           thold_A0_AVDNeg           =1;
                         //tAAH, tAAVDH, tAH synchro, edge /
     specparam           thold_AVDNeg_CLK        =1; //tAVHC, edge /
     specparam           thold_DQ0_WENeg         =1; //tDH edge /
     specparam           thold_WENeg_CENeg       =1;
     specparam           thold_DQ0_CLK           =1;
        // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1; //tRP
     specparam           tpw_WENeg_negedge       =1; //tWP
     specparam           tpw_WENeg_posedge       =1; //tWPH
     specparam           tpw_AVDNeg_negedge      =1; //tAVDP

        // tdevice values: values for internal delays
            //Program Operation
     specparam   tdevice_POW                     = 9000; //9 us;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 400000000;//400 ms;
            // erase suspend timeout
     specparam   tdevice_ESTART_T1               = 35000; //35 us;
            //sector erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 50000; //50 us;
            //device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 35000; //35 us; //tReady

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

  if (FROMCE)
      (CENeg => DQ0)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ1)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ2)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ3)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ4)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ5)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ6)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ7)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ8)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ9)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ10)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ11)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ12)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ13)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ14)     = tpd_CENeg_DQ0;
  if (FROMCE)
      (CENeg => DQ15)     = tpd_CENeg_DQ0;

  if (FROMOE)
      (OENeg => DQ0)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ1)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ2)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ3)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ4)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ5)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ6)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ7)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ8)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ9)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ10)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ11)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ12)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ13)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ14)     = tpd_OENeg_DQ0;
  if (FROMOE)
      (OENeg => DQ15)     = tpd_OENeg_DQ0;

  if (clk_out)
      (CLK => DQ0)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ1)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ2)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ3)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ4)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ5)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ6)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ7)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ8)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ9)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ10)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ11)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ12)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ13)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ14)     = tpd_CLK_DQ0;
  if (clk_out)
      (CLK => DQ15)     = tpd_CLK_DQ0;

  (OENeg => RDY)     = tpd_OENeg_RDY;
  (CENeg => RDY)     = tpd_OENeg_RDY;

  if (clk_RdyOe && ~OENeg && ~CENeg  && ~ASynchroMod  && PathEnable)
        (CLK   => RDY)     = tpd_CLK_RDY;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           /
///////////////////////////////////////////////////////////////////////////////
        $setup ( DQ0 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ1 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ2 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ3 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ4 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ5 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ6 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ7 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ8 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ9 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ10, posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ11, posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ12, posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ13, posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ14, posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( DQ15, posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A16 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A17 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A18 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A19 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A20 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A21 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);
        $setup ( A22 , posedge AVDNeg&&&~CENeg, tsetup_A0_AVDNeg, Viol);

        $setup ( DQ0 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ1 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ2 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ3 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ4 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ5 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ6 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ7 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ8 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ9 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ10, posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ11, posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ12, posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ13, posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ14, posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( DQ15, posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A16 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A17 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A18 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A19 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A20 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A21 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);
        $setup ( A22 , posedge CLK&&&SyncEn, tsetup_DQ0_CLK, Viol);

        $setup ( DQ0 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10, posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11, posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12, posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13, posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14, posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15, posedge WENeg&&&deg, tsetup_DQ0_WENeg, Viol);

        $setup ( CENeg , negedge WENeg , tsetup_CENeg_WENeg, Viol);
        $setup ( CENeg, posedge CLK&&&SyncEn, tsetup_CENeg_CLK, Viol);
        $setup ( AVDNeg,posedge CLK&&&SyncEn, tsetup_AVDNeg_CLK, Viol);
        $setup ( OENeg,  negedge WENeg , tsetup_OENeg_WENeg, Viol);
        $setup ( WENeg, negedge OENeg , tsetup_WENeg_OENeg, Viol);
        $setup ( RDY,   posedge CLK&&&SyncEn, tsetup_RDY_CLK, Viol);

        $hold ( posedge AVDNeg&&&~CENeg, DQ0 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ1 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ2 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ3 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ4 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ5 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ6 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ7 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ8 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ9 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ10 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ11 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ12 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ13 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ14 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, DQ15 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A16  , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A17  , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A18  , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A19  , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A20  , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A21  , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg&&&~CENeg, A22  , thold_A0_AVDNeg, Viol);

        $hold ( posedge CLK&&&SyncEn==1, DQ0 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ1 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ2 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ3 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ4 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ5 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ6 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ7 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ8 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ9 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ10,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ11,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ12,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ13,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ14,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, DQ15,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A16 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A17 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A18 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A19 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A20 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A21 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn==1, A22 ,  thold_A0_CLK, Viol);

        $hold ( posedge WENeg, DQ0  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ1  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ2  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ3  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ4  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ5  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ6  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ7  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ8  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ9  ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ10 ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ11 ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ12 ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ13 ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ14 ,   thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg, DQ15 ,   thold_DQ0_WENeg, Viol);

        $hold ( posedge CLK&&&SyncData==1, DQ0,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ1,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ2,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ3,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ4,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ5,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ6,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ7,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ8,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ9,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ10,  thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ11,  thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ12,  thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ13,  thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ14,  thold_DQ0_CLK, Viol);
        $hold ( posedge CLK&&&SyncData==1, DQ15,  thold_DQ0_CLK, Viol);

        $hold ( posedge CLK, AVDNeg, thold_AVDNeg_CLK, Viol);
        $hold ( posedge RESETNeg&&&CENeg, CENeg, thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg&&&OENeg, OENeg, thold_OENeg_RESETNeg, Viol);
        $hold ( posedge WENeg, CENeg , thold_WENeg_CENeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (posedge WENeg, tpw_WENeg_posedge);
        $width (negedge WENeg, tpw_WENeg_negedge);
        $width (negedge AVDNeg, tpw_AVDNeg_negedge);

    endspecify
///////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        /
///////////////////////////////////////////////////////////////////////////////

    // FSM states
    parameter RESET               =6'd0;
    parameter Z001                =6'd1;
    parameter PREL_SETBWB         =6'd2;
    parameter PREL_ULBYPASS       =6'd3;
    parameter CFI                 =6'd5;
    parameter AS                  =6'd6;
    parameter A0SEEN              =6'd7;
    parameter SEC_SECURITY_PRIOR2 =6'd8;
    parameter SEC_SECURITY_PRIOR  =6'd9;
    parameter SEC_SECURITY        =6'd10;
    parameter C8                  =6'd13;
    parameter C8_Z001             =6'd14;
    parameter C8_PREL             =6'd15;
    parameter ERS                 =6'd16;
    parameter SERS                =6'd17;
    parameter ESPS                =6'd18;
    parameter AS_CFI              =6'd19;
    parameter UNLOCK_RESET        =6'd25;
    parameter SERS_EXEC           =6'd26;
    parameter ESP                 =6'd27;
    parameter ESP_Z001            =6'd28;
    parameter ESP_PREL            =6'd29;
    parameter ESP_ULBYPASS        =6'd30;
    parameter ESP_CFI             =6'd31;
    parameter ESP_A0SEEN          =6'd32;
    parameter ESP_AS              =6'd33;
    parameter ESP_AS_CFI          =6'd34;
    parameter PGMS                =6'd35;
    parameter ESP_UNLOCK_RESET    =6'd36;

    reg [5:0] current_state;
    reg [5:0] next_state;

    parameter IDLE_BURST_READ = 1'b0;
    parameter BURST_READ = 1'b1;
    reg ReadBurst_state;

    reg [BankNum-1:0] BankBypassLock;
    reg [BankNum-1:0] BankErase;
    reg [BankNum-1:0] BankEraseExec;
    integer BA;

    reg deq;
    reg read_nosuspend_sect;
    integer WRData  = 0;
    integer Mem_tmp= 0;
    integer  WRSA;
    integer  WRAddress;

    // temporary timing model vector
    reg[17*8:1] tmp_timing;
    reg[7:0] tmp_char;
    integer found = 0;

    always @(DIn, DOut)
    begin
      if (DIn==DOut)
        deq=1'b1;
      else
        deq=1'b0;
    end
    // check when data is generated from model to avoid setuphold check in
    assign deg=deq;
    // enable data path delay when CLK
    always @(gOE_n)
    begin
      if (gOE_n == 1'b0)
        #1 ClkOe_en <= 1'b1;
      else
        ClkOe_en = 1'b0;
    end
    always @(ClkAddr_tmp)
    begin
      if (ClkAddr_tmp == 1'b1)
        #1 ClkAddr_en <= 1'b1;
      else
        #1 ClkAddr_en = 1'b0;
    end

    initial
    begin
      // init arrays holding start/end address
      // of smaller sectors
     sssa[0]=16'h0000;
     sssa[1]=16'h2000;
     sssa[2]=16'h4000;
     sssa[3]=16'h6000;
     ssea[0]=16'h1FFF;
     ssea[1]=16'h3FFF;
     ssea[2]=16'h5FFF;
     ssea[3]=16'h7FFF;
      -> initOK;
    end

    // preload
    initial
    begin: InitMemory
    integer j, sect, sect_addr;
    integer sector_preload[0:SecSize-1];
    reg     sector_prot[0:SecNum-1];

        for (j=0;j<=MemSize;j=j+1)
            Mem[j]=MaxData;

        //s29ns128j memory preload format file
        //   /         - comment
        //   @aaaaaa   - <aaaaaa> stands for address
        //   dddd      - <dddd> is word to be written at Mem(aaaaaa++)
        //                      (aaaaaa is incremented at every load)
        //   only first 1-7 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
        if (UserPreload && mem_file_name != "")
           $readmemh(mem_file_name,Mem);
    end
    //Power Up time 100 ns;
    initial
    begin
        PoweredUp = 1'b0;
        #100 PoweredUp = 1'b1;
    end

    always @(RESETNeg)
    begin
        RST <= #499 RESETNeg;
    end

    initial
    begin
        write    = 1'b0;
        read     = 1'b0;
        Addr   = 0;

        ULBYPASS = 1'b0;
        ERS_ACT  = 1'b0 ;

        PDONE    = 1'b1;
        PSTART   = 1'b0;
        PERR     = 1'b0;

        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;

        EERR     = 1'b0;
        READY_in = 1'b0;
        READY    = 1'b0;
    end
   initial
   begin
       BurstModeReg = ComandBurstInit;
       BurstMode    = BurstModeReg[5:3];
       BurstWait    = BurstModeReg[2:0];
   end

   always @(BurstModeReg)
   begin: BurstModeReg_alias
     BurstMode       = BurstModeReg[5:3];
     BurstWait       = BurstModeReg[2:0];
   end

   always @(posedge ESTART_T1_in)
   begin:TESTARTT1r
     #tdevice_ESTART_T1 ESTART_T1 = ESTART_T1_in;
   end
   always @(negedge ESTART_T1_in)
   begin:TESTARTT1f
     #1 ESTART_T1 = ESTART_T1_in;
   end

   always @(posedge CTMOUT_in)
   begin:TCTMOUTr
     #tdevice_CTMOUT CTMOUT = CTMOUT_in;
   end
   always @(negedge CTMOUT_in)
   begin:TCTMOUTf
     disable TCTMOUTr;
     #1 CTMOUT = CTMOUT_in;
   end
   always @(posedge READY_in)
   begin:TREADYr
     #tdevice_READY READY = READY_in;
   end
   always @(negedge READY_in)
   begin:TREADYf
     #1 READY = READY_in;
   end
   ///////////////////////////////////////////////////////////////////////////
   //// sequential process for reset control and FSM state transition
   ///////////////////////////////////////////////////////////////////////////
   reg R;
   reg E;
   always @(RESETNeg)
   begin
        if (PoweredUp)
        begin
        //Hardware reset timing control
            if (~RESETNeg)
            begin
                E = 1'b0;
                if (~PDONE || ~EDONE)
                begin
                    //if program or erase in progress
                    READY_in = 1'b1;
                    R = 1'b1;
                end
                else
                begin
                    READY_in = 1'b0;
                    R = 1'b0;         //prog or erase not in progress
                end
            end
            else if (RESETNeg && RST)
            begin
                //RESET# pulse < tRP
                READY_in = 1'b0;
                R = 1'b0;
                E = 1'b1;
            end
         end
    end

    always @(next_state or RESETNeg or CENeg or RST or
         READY or PoweredUp) // or  EDONE or PDONE
    begin: StateTransition
        if (PoweredUp)
        begin
            if (RESETNeg && (~R || (R && READY)))
            begin
                current_state = next_state;
                READY_in = 1'b0;
                E = 1'b0;
                R = 1'b0;
                reseted = 1'b1;
            end
            else if ((~R && ~RESETNeg && ~RST) ||
                  (R && ~RESETNeg && ~RST && ~READY) ||
                  (R && RESETNeg && ~RST && ~READY))
            begin
                //no state transition while RESET# low
                current_state = RESET; //reset start
                reseted       = 1'b0;
            end
        end
        else
        begin
            current_state = RESET;      // reset
            reseted       = 1'b0;
            E = 1'b0;
            R = 1'b0;
        end
    end

///////////////////////////////////////////////////////////////////////////
////Glitch Protection: Inertial Delay does not propagate pulses <5ns
///////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

////latch address on rising edge and data on falling edge  of write
    always @(gWE_n or  gCE_n or  gOE_n or RESETNeg or AVDNeg or reseted)
    begin: write_dc
        if (AVDNeg)
        begin
            if (RESETNeg && reseted)
            begin
                if (~gWE_n && ~gCE_n && gOE_n)
                    write = 1'b1;
                else
                    write = 1'b0;
            end

            if (gWE_n && ~gCE_n && ~gOE_n && reseted)
                read = 1'b1;
            else
                read = 1'b0;
      end
      else
      begin
          write = 1'b0;
          read = 1'b0;
      end
    end

    ///////////////////////////////////////////////////////////////////////////
    //Process that reports warning when changes on signals WE#, CE#, OE# are
    //discarded
    ///////////////////////////////////////////////////////////////////////////
    always @(WENeg)
    begin: PulseWatch1
        if (gWE_n == WENeg) $display("Glitch on WE#");
    end
    always @(CENeg)
    begin: PulseWatch2
        if (gCE_n == CENeg) $display("Glitch on CE#");
    end
    always @(OENeg)
    begin: PulseWatch3
        if (gOE_n == OENeg) $display("Glitch on OE#");
     end

    ///////////////////////////////////////////////////////////////////////////
    //Latch address
    ///////////////////////////////////////////////////////////////////////////
    integer A_tmp  ;
    integer SA_tmp ;
    integer BA_tmp;
    integer Data;
    //DATA Low Byte
    integer DataLo;

    reg CE;
    reg   addr_latch = 1'b0;
    event addrLatch_event;
    always @(posedge WENeg_ipd, posedge CENeg_ipd)
    begin
        if (reseted)
        begin
        if (write)
            begin
               DataLo = DIn[7:0];
               Data   = DIn[15:0];
            end
        end
    end
    always @(A)
    begin
        if (~AVDNeg && ~ CENeg_ipd && ~addr_latch)
        begin
           -> addrLatch_event;
           ASynchroMod = 1'b1;
        end
    end
    always @(negedge CENeg)
    begin
           if (~AVDNeg && ~addr_latch)
           begin
             ASynchroMod = 1'b1;
              -> addrLatch_event;
           end
    end
    always @(negedge AVDNeg)
    begin
           if (~CENeg)
           begin
              ASynchroMod = 1'b1;
              -> addrLatch_event;
           end
    end
    always @(posedge CLK)
    begin
           if (CLK&& ~AVDNeg && (~CENeg || gCE_n) &&
           ~addr_latch)
           begin
              ASynchroMod = 1'b0;
              -> addrLatch_event;
              addr_latch = 1'b1;
           end
    end

    always @(CENeg, AVDNeg)
    begin
        if (CENeg || AVDNeg)
        begin
            addr_latch = 1'b0;
        end
    end

    always @( addrLatch_event)
    begin
        Addr          = A[10:0];
        Address       = A[LowSecAddrBit-1:0];
        BA            = A[HiAddrBit:HiAddrBit-1];
        SSA           = A[LowSecAddrBit-1:LowSecAddrBit-2];
        SA            = A[HiAddrBit:LowSecAddrBit];

        AddressLatch  = A;
    end

/////////////////////////////////////////////////////////////////////////////
//// Timing control for the Program/ Write Buffer Program Operations
//// start/ suspend/ resume
/////////////////////////////////////////////////////////////////////////////

 integer cnt_write = 0;
 time elapsed_write  ;
 time duration_write ;
 time start_write    ;
 event pdone_event;

    always @(posedge reseted)
    begin
        PDONE = 1'b1;
    end
    always @(reseted or PSTART)
    begin
        if (reseted)
        begin
             if (PSTART && PDONE)
             begin
                if (((SA != TopSec)
                    && ~Sec_Prot[SA]
                    && ~Ers_Queue[SA])
                ||
                    (SA == TopSec && ~SubSecTop_Prot[SSA]
                    && ~Ers_SubTop_Queue[SSA]))
                begin
                        duration_write = tdevice_POW;

                     -> pdone_event;
                end
                else
                begin
                    PERR = 1'b1;
                    PERR <= #1000 1'b0;
                end
                end
            end
    end

    always @(pdone_event)
    begin:pdone_process
        PDONE = 1'b0;
        #duration_write PDONE = 1'b1;
    end

/////////////////////////////////////////////////////////////////////////////
//// Timing control for the Erase Operations
/////////////////////////////////////////////////////////////////////////////
 integer cnt_erase = 0;
 time elapsed_erase;
 time duration_erase;
 time start_erase;

    always @(posedge reseted)
    begin
        disable edone_process;
        EDONE = 1'b1;
    end

    event edone_event;
    always @(reseted or ESTART)
    begin: erase
    integer i;
    integer y;
        if (reseted)
            begin
              if (ESTART && EDONE)
              begin
                    cnt_erase = 0;
                    for (i=0;i<=SecNum-1;i=i+1)
                    begin
                        if (i != TopSec)
                        begin
                          if (Ers_Queue[i] && ~Sec_Prot[i])
                             cnt_erase = cnt_erase +2;
                        end
                        else
                        begin
                            for (y=0;y<= SubSecNum-1; y=y+1)
                            begin
                                if (Ers_SubTop_Queue[y]  &&
                                    ~SubSecTop_Prot[y])
                                    cnt_erase = cnt_erase +1;
                            end
                        end
                    end
                    if (cnt_erase>0)
                    begin
                        duration_erase = cnt_erase * tdevice_SEO/2;
                        start_erase = $time;
                        -> edone_event;
                    end
                    else
                    begin
                        EERR = 1'b1;
                        EERR <= #100000  1'b0;
                    end
                end
            end
        end

    always @(edone_event)
    begin : edone_process
        EDONE = 1'b0;
        #duration_erase EDONE = 1'b1;
    end

    always @(reseted or ESUSP)
    begin
        if (reseted)
            if (ESUSP && ~EDONE)
            begin
                disable edone_process;
                elapsed_erase = $time - start_erase;
                duration_erase = duration_erase - elapsed_erase;
                EDONE = 1'b0;
            end
    end

    always @(reseted or ERES)
    begin
        if (reseted)
            if (ERES && ~EDONE)
            begin
                start_erase = $time;
                EDONE = 1'b0;
                ->edone_event;
            end
    end

/////////////////////////////////////////////////////////////////////////////
//// Main Behavior Process
//// combinational process for next state generation
/////////////////////////////////////////////////////////////////////////////
        reg PATTERN_1  = 1'b0;
        reg PATTERN_2  = 1'b0;
        reg A_PAT_1  = 1'b0;
        reg     RDY_tmp;   // temp signal for ready
        integer AutoselAddress;
        time erase_start;
        task Drive_DoutZd;
        begin

                if (Mem[SA*SecSize + Address]==-1)
                    DOut_zd[15:0] = 16'bx;
                else
                    DOut_zd[15:0] = Mem[SA*SecSize + Address];
         end
       endtask

       task Read_AutoSelect_space;
       begin
           AutoselAddress = Address % 12'h100;
           if (~ASynchroMod)
              SSA = Address % SubSecSize;

           if (AutoselAddress == 0)
               DOut_zd = 1'b1;
           else if (AutoselAddress == 1)
               DOut_zd = 16'h007E;
           else if (AutoselAddress == 2)
               if (( (SA != TopSec) &&
                   (~Sec_Prot[SA])) ||
                   ((SA == TopSec) &&
                   (~SubSecTop_Prot[SSA])))
                   // sector unlock
                   DOut_zd[15:0] = 16'h0000;
               else
                   // sector lock
                   DOut_zd[15:0] = 16'h0001;

           else if (AutoselAddress == 3)
           begin
                   DOut_zd[15:0] = 16'h0043;
           end
           else if (AutoselAddress == 14)
           begin
                   DOut_zd[15:0] = 16'h0016;
           end
           else if (AutoselAddress == 15)
               DOut_zd[15:0] = 16'h0000;
           else
               DOut_zd[15:0] = 16'bz;
       end
       endtask

       task Readmem_EraseSuspend;
       integer y;
       begin
            read_nosuspend_sect = 1'b1;
            if (~ASynchroMod)
               SSA = Address / SubSecSize;
            if (SA != TopSec)
            begin
                if  (Ers_Queue[SA] && ~Sec_Prot[SA])
                    read_nosuspend_sect =1'b0;
            end
            else
               if (Ers_SubTop_Queue[SSA]
               && ~SubSecTop_Prot[SSA])
                    read_nosuspend_sect = 1'b0;

            if (read_nosuspend_sect)
            begin
                Drive_DoutZd;
            end
            else
            begin
                 Status[7] = 1'b1;
                 //Status[6] No toggle
                 Status[5] = 1'b0;
                 Status[2] = ~ Status[2]; //toggle
                 DOut_zd[7 : 0] = Status;
                 DOut_zd[15 : 8] = 8'bz;
           end
        end
     endtask

     task Read_EraseStatus;
     begin
         if (~ASynchroMod)
               SSA = Address / SubSecSize;
         Status[7] = 1'b0;
         Status[6] = ~ Status[6];
         Status[5] = 1'b0;
         Status[3] = 1'b1;
         if ($time - erase_start > 100000)
         begin
             if ((SA != TopSec && Ers_Queue[SA] && ~Sec_Prot[SA]) ||
             (SA == TopSec && Ers_SubTop_Queue[SSA] && ~SubSecTop_Prot[SSA]))
                    Status[2] = ~ Status[2];
         end
         else
             if (SA != TopSec && Ers_Queue[SA] || SA == TopSec &&
             Ers_SubTop_Queue[SSA])
                     Status[2] = ~ Status[2];

     end
     endtask

     always @( write or reseted)
     begin: StateGen1
        if (~write)
        begin
            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
            A_PAT_1   = ((Addr==16'h555) && ~ULBYPASS) || ULBYPASS;
        end
        if (reseted!=1'b1)
            next_state = current_state;
        else
        case (current_state)
            RESET:
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = Z001;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = CFI;
                    else if(DataLo== 8'h60)
                       next_state <= SEC_SECURITY_PRIOR2;
                    else
                        next_state = RESET;
                end
            end

            SEC_SECURITY_PRIOR2 :
            begin
                if (~write)
                    if (DataLo== 8'h60)
                        next_state <= SEC_SECURITY_PRIOR;
                    else
                        if(BankErase == 0)
                            next_state = RESET;
                        else
                            next_state = ESP;
            end

            SEC_SECURITY_PRIOR :
            begin
                if (~write)
                begin
                    if (DataLo== 8'h60)
                        next_state = SEC_SECURITY;
                    else
                        if(BankErase == 0)
                            next_state = RESET;
                        else
                            next_state = ESP;
                end
            end

            SEC_SECURITY :
            begin
                if (~write)
                    if (DataLo== 8'hF0)
                        if(BankErase == 0)
                            next_state = RESET;
                        else
                            next_state = ESP;
                    else
                        next_state = SEC_SECURITY;
            end

            Z001:
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = PREL_SETBWB;
                    else
                        next_state = RESET;
                end
            end

            PREL_SETBWB:
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==8'hA0))
                        next_state = A0SEEN;
                    else if (A_PAT_1 && (DataLo==8'h20))
                        next_state = PREL_ULBYPASS;
                    else if (A_PAT_1 && (DataLo==8'h90))
                        next_state = AS;
                    else if (A_PAT_1 && (DataLo==8'hC0))
                        next_state = RESET;
                    else if (A_PAT_1 && (DataLo==8'h80))
                        next_state = C8;
                    else
                        next_state = RESET;
                end
             end

            PREL_ULBYPASS:
            begin
                if (~write)
                begin
                    if ((BankBypassLock[BA]) && (DataLo==8'h90))
                        next_state = UNLOCK_RESET;
                    else if (DataLo==8'hA0)
                        next_state = A0SEEN;
                    else if (DataLo==8'h80)
                        next_state = C8_PREL;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            UNLOCK_RESET:
            begin
                if (~write)
                begin
                    if (DataLo==8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            CFI:
            begin
                if (~write)
                begin
                    if (DataLo==8'hF0)
                       next_state = RESET;
                end
            end

            AS:
            begin
                if (~write)
                begin
                    if (DataLo==8'hF0)
                        next_state = RESET;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = AS_CFI;
                end
            end

            AS_CFI:
            begin
                if (~write)
                begin
                    if (DataLo==8'hF0)
                        next_state = AS;
                    else
                        next_state = AS_CFI;
                end
            end

            A0SEEN:
            begin
                if (~write)
                begin
                    if (((BankBypassLock[BA]) && (ULBYPASS))
                         || (~ULBYPASS))
                         next_state = PGMS;
                    else
                         next_state = PREL_ULBYPASS;
                end
            end

            C8:
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else
                        next_state = RESET;
                end
            end

            C8_Z001:
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = C8_PREL;
                    else
                        next_state = RESET;
                end
            end

            C8_PREL:
            begin
                if (~write)
                begin
                    if (A_PAT_1 && DataLo==8'h10)
                        next_state = ERS;
                    else if (DataLo==8'h30)
                        if (((BankBypassLock[BA]) && (ULBYPASS))
                         || (~ULBYPASS))
                            next_state = SERS;
                        else
                            next_state = PREL_ULBYPASS;
                    else
                    begin
                        if (~ULBYPASS)
                            next_state = RESET;
                        else
                            next_state = PREL_ULBYPASS;
                    end
                end
            end

            ERS:
            begin
            end

            SERS:
            begin
                if (~write)
                begin
                    if (DataLo == 8'hB0)
                        if (BankErase[BA])
                             next_state = ESP;
                        else
                             next_state = SERS;
                    else if (DataLo==8'h30)
                        next_state = SERS;
                    else
                        if (~ULBYPASS)
                              next_state = RESET;
                         else
                              next_state =  PREL_ULBYPASS;
                end
            end

            SERS_EXEC:
            begin
            end

            ESPS:
            begin
            end

            ESP:
            begin
                if (~write)
                    if (DataLo == 8'h30  && (BankErase[BA]))
                        next_state = SERS_EXEC;
                    else if(DataLo== 8'h60)
                       next_state <= SEC_SECURITY_PRIOR2;
                    else
                        if (Addr == 8'h55 && DataLo == 8'h98)
                            next_state = ESP_CFI;
                        else if (PATTERN_1)
                            next_state = ESP_Z001;
            end

            ESP_ULBYPASS:
                if (~write)
                    if (DataLo == 16'h30 && BankErase[BA])
                        next_state = SERS_EXEC;
                    else if (DataLo==16'hA0)
                        next_state = ESP_A0SEEN;
                    else if (BankBypassLock[BA] && DataLo==16'h90)
                            next_state = ESP_UNLOCK_RESET;

            ESP_UNLOCK_RESET:
                if (~write)
                    if (DataLo == 16'h00)
                        next_state = ESP;
                    else
                        next_state = ESP_ULBYPASS;

            ESP_Z001:
            begin
                if (~write)
                    if (PATTERN_2)
                        next_state = ESP_PREL;
                    else
                        next_state = ESP;
            end

            ESP_PREL:
            begin
                if (~write)
                    if (A_PAT_1 && DataLo == 8'h20)
                        next_state = ESP_ULBYPASS;
                    else if (A_PAT_1 && (DataLo==8'h90))
                        next_state = ESP_AS;
                    else if(A_PAT_1 && DataLo == 8'hA0)
                        next_state = ESP_A0SEEN;
                    else
                        next_state = ESP;
            end

            ESP_CFI:
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = ESP;
                    else
                        next_state = ESP_CFI;
            end

            ESP_A0SEEN:
            begin
                if (~write)
                   if (((BankBypassLock[BA]) && (ULBYPASS))
                    || (~ULBYPASS))
                         next_state = PGMS;
                    else
                         next_state = ESP_ULBYPASS;
            end

            ESP_AS:
            begin
                if (~write)
                    if (DataLo==8'hF0)
                        next_state = ESP;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = ESP_AS_CFI;
                    else
                        next_state = ESP_AS;
            end

            ESP_AS_CFI:
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = ESP_AS;
                    else
                        next_state = ESP_AS_CFI;
            end

            PGMS:
            begin
            end

        endcase

    end

    always @(posedge PDONE or negedge PERR)
    begin: StateGen7
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                    if (ERS_ACT)
                        if (~ULBYPASS)
                            next_state = ESP;
                        else
                            next_state <= ESP_ULBYPASS;
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
                    else
                        next_state = RESET;
            end
        end
    end

    always @(posedge EDONE or negedge EERR or reseted)
    begin: StateGen2

        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC))
            begin
                if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end
        end
    end

    event bank_erase_event;
    always @(CTMOUT or reseted)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS && CTMOUT)
               next_state = SERS_EXEC;
        end
    end

    always @(bank_erase_event)
    begin
       #100000 BankErase = BankEraseExec;
    end

    always @(posedge ESTART_T1 or reseted)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (current_state==ESPS && ESTART_T1)
        begin
            if (~ULBYPASS)
               next_state = ESP;
            else
               next_state = ESP_ULBYPASS;
        end
    end

    always @(negedge write or reseted)
    begin: StateGen8

        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
        if (current_state==SERS_EXEC && write==1'b0 && EERR!=1'b1)
                if (DataLo==8'hB0 && BankErase[BA])
                        next_state = ESPS;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // Burst block - task
    ///////////////////////////////////////////////////////////////////////////
    //Burst Address
    parameter LINEAR            = 0;
    parameter WRAP_AROUND       = 1;
    parameter WRAP_NO_AROUND    = 2;
    integer WrapMode    = 0;    // 0 - LINEAR, 1 - Wrap Around, 2 - Wrap No Ar.
    integer BoundNoCross = 0;

    integer Wait_Cycle  = 0;     // Burst Initial Delay
    integer WrapCnt     = 8;

    integer BrBoundCross;
    event EndB_ev;
    reg   erase_active = 1'b0;
    reg BrEmbaded;
    reg   erase_suspend = 1'b0;

    task erase_active_task;
    input [1:0] BA;
    input [7:0] SA;
    input [14:0] Address;
    output erase_active;
    output erase_suspend;
    begin
        erase_active = 1'b0;
        erase_suspend =1'b0;
        SSA = Address / SubSecSize;
        if ((BankErase[BA] && current_state== ERS) ||
        (BankErase[BA] && current_state== SERS) ||
        (BankErase[BA] && current_state== ESPS) ||
        (BankErase[BA] && current_state== SERS_EXEC))
             erase_active = 1'b1;
        else if (BankErase[BA])
        begin
            if ((SA != TopSec &&  Ers_Queue[SA]  && ~Sec_Prot[SA]) ||
            (SA== TopSec && Ers_SubTop_Queue[SSA] && ~SubSecTop_Prot[SSA]))
                    erase_suspend = 1'b1;
        end
    end
    endtask

    task SetRdy;
    begin
        RDY_tmp = 1'b1;

        if (Wait_Cycle != 0)
            RDY_tmp = 1'b0;
    end
    endtask

    task INIT_BURST;
    begin
        Wait_Cycle  = BurstWait+2;
        RDY_tmp = 1'b0;
        BrEmbaded = 1'b0;
        BrBoundCross = 1'b0;
        BoundNoCross = 0;
        if (AddressLatch[0] == 1'b1)
             Wait_Cycle = Wait_Cycle +1;

        case (BurstMode)
            3'b000 , 3'b100 :
            begin
                WrapCnt     = -1;
                WrapMode    = LINEAR;
            end

            3'b001 :
            begin
                WrapCnt     =  8 - AddressLatch[2:0];
                WrapMode    =  WRAP_AROUND;
            end

            3'b010 :
            begin
                WrapCnt     = 16 - AddressLatch[3:0];
                WrapMode    = WRAP_AROUND;
            end

            3'b011 :
            begin
                WrapCnt     = 32 - AddressLatch[4:0];
                WrapMode    = WRAP_AROUND;
            end

            3'b101 :
            begin
                WrapCnt     = 8;
                WrapMode    = WRAP_NO_AROUND;
            end

            3'b110 :
            begin
                WrapCnt     = 16;
                WrapMode    = WRAP_NO_AROUND;
            end

            3'b111 :
            begin
                WrapCnt     = 32;
                WrapMode    = WRAP_NO_AROUND;
            end

            default : ;
        endcase

        if (WrapMode != WRAP_AROUND)
            begin
            case (Address % BurstBound)
                6'h3e :  begin
                             Wait_Cycle  = Wait_Cycle +2;
                             BoundNoCross = 1;
                         end
                6'h3f :  begin
                             Wait_Cycle  = Wait_Cycle +2;
                          end
                default : ;
            endcase
        end
        erase_active_task(BA, SA, Address, erase_active, erase_suspend);
        if ((BankBusy[BA] || erase_active == 1'b1
        || BankAutosel[BA]  || erase_suspend == 1'b1 ))
               BrEmbaded = 1'b1;

    end
    endtask

    task SET_BURST_PARAMETER;
    begin
    if (CLK) //posedge CLK
        begin
        if(Wait_Cycle == 0)
            begin
            if (WrapMode != LINEAR)
                WrapCnt = WrapCnt - 1;
            if (WrapCnt > 0 && WrapMode == WRAP_AROUND) //wrap mode
            begin
                Address = Address +1;
            end
            else if(WrapCnt == 0 && WrapMode == WRAP_AROUND) // wrap turnround
            begin
                case (BurstMode)
                   3'b001 :    // wrap 8
                   begin
                       Address = Address - 8 +1;
                       WrapCnt = 8;
                   end
                   3'b010 :    // wrap 16
                   begin
                       Address = Address - 16 +1;
                       WrapCnt = 16;
                   end
                   3'b011 :   // wrap 32
                   begin
                       Address = Address - 32 +1;
                       WrapCnt = 32;
                   end
                   default : ;
                endcase

            end
            else    //linear mode
            begin
                Address = Address + 1;
                if (WrapCnt == 0)
                begin

                    Address = Address -1;
                    RDY_tmp = 1'b0;
                    Wait_Cycle = 1;
                    -> EndB_ev;
                end
                if (Address == SecSize)
                begin
                    SA = SA + 1;
                    Address   = 0;
                    if ((SA % SecNumBank)==0)
                    begin
                        if (SA == SecNum)
                            SA = 0;
                        BA = ((BA + 1) % BankNum);
                    end
                end

                if((Address % BurstBound)==BurstBound-1)
                begin
                    if (BoundNoCross==0)
                    begin
                        Wait_Cycle = 2;
                        BrBoundCross  = 1;
                    end
                    else
                       BoundNoCross = 0;
                end

                erase_active_task(BA, SA, Address, erase_active,
                erase_suspend);
                if (BankBusy[BA]==1'b1
                || erase_active ==1'b1 || erase_suspend==1'b1
                || BankAutosel[BA] ==1'b1)
                begin
                     -> EndB_ev;
                     BrBoundCross = 0;
                     Wait_Cycle   = 5;
                     RDY_tmp      = 1'b0;
                end
            end
            end
        else
        begin
            Wait_Cycle = Wait_Cycle-1;
            RDY_tmp    = 1'b0;
        end

        if (Wait_Cycle == 0 || BrBoundCross == 1)
        begin
            SetRdy;
            BrBoundCross = 0;
        end

        if (read)
            ->oe_event;
     end

   end
   endtask

    ///////////////////////////////////////////////////////////////////////////
    //Burst mode state
    ///////////////////////////////////////////////////////////////////////////
    event start_burst_event;
    reg br_flag = 1'b0;

    always@ (posedge CLK)
    begin
       if (CLK && ~AVDNeg && ~br_flag &&
       (~CENeg || ~gCE_n) && WENeg)
       begin
          -> start_burst_event;
          br_flag = 1'b1;
       end
       else
          if (ReadBurst_state == BURST_READ)
            SET_BURST_PARAMETER;

    end

    always@ (posedge AVDNeg)
    begin
        br_flag = 1'b0;

    end

    always@ (start_burst_event)
    begin: BurstStart
        begin
            Start_burst = 1'b1;
            Start_burst = #1 1'b0;
        end
    end

    always@ (gCE_n, posedge CENeg, gWE_n, reseted)
    begin : BurstDeactive
        if (gCE_n || ~reseted || ~gWE_n)
        begin
            End_burst = 1'b1;
            End_burst = #1 1'b0;
        end
    end

    always@ (Start_burst)
    begin: BurstControlActive
        if (Start_burst && reseted)
        begin
            ReadBurst_state = BURST_READ;
            INIT_BURST;
            SET_BURST_PARAMETER;
        end
    end

    always@ (EndB_ev)
    begin: EndBurstembedded
         End_burst = 1'b1;
         End_burst = #1 1'b0;
    end

    always@ (End_burst, reseted)
    begin: BurstControlIdle
        if (End_burst || ~reseted)
        begin
            ReadBurst_state = IDLE_BURST_READ;
            if (gCE_n==1'b1 || CENeg==1'b1 || ~reseted || ~gWE_n)
                RDY_tmp = 1'bZ;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //Sector Protection Block:Vpp rising
    ///////////////////////////////////////////////////////////////////////////

    always @ (Vpp, WPNeg, SubSecTop_ProtTmp, Sec_ProtTmp)
    begin
        SubSecTop_Prot  = SubSecTop_ProtTmp;
        Sec_Prot        = Sec_ProtTmp;
        if(WPNeg == 1'b0)
        begin
            SubSecTop_Prot[SubSecNum-1 : SubSecNum-2]  = ~(0);
        end
        if(Vpp == 1'b0)
        begin
            Sec_Prot  = ~(0);
            SubSecTop_Prot  = ~(0);
        end
    end

    task SoftProtectSector;
    begin
        if ((SA != TopSec))
            Sec_ProtTmp[SA] = ~AddressLatch[6];
        else
            SubSecTop_ProtTmp[SSA] = ~AddressLatch[6];
    end
    endtask

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
       ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    integer y;
    integer tmp;
    always @(oe or reseted or current_state)
    begin

        if (reseted)
        begin
        case (current_state)
            RESET:
            begin
                if (oe)
                begin
                   Drive_DoutZd;
                end
            end

            SEC_SECURITY_PRIOR2:
            begin
            end

            SEC_SECURITY_PRIOR:
            begin
            end

            SEC_SECURITY:
            begin
             end

            CFI, AS_CFI, ESP_CFI, ESP_AS_CFI:
            begin
            if (oe)
            begin
                DOut_zd = 16'bZ;
                if ((AddressLatch>=16'h10) && (AddressLatch <= 16'h5C))
                begin
                    if (CFI_array[AddressLatch] != -1)
                    begin
                        DOut_zd[7:0] = CFI_array[AddressLatch];
                        DOut_zd[15:8] = 8'b0;
                    end
                end
                else
                begin
                    $display ("Invalid CFI query address");
                end
            end
            end

            AS:
            begin
            if (oe)
            begin
                if (BankAutosel[BA])
                begin
                    Read_AutoSelect_space;
                end
                else
                    Drive_DoutZd;
            end
            end

            PREL_ULBYPASS:
            begin
            if(oe)
                if (BankBypassLock[BA])
                    DOut_zd = 16'bz;
                else
                    Drive_DoutZd;
            end

            ERS:
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ///////////////////////////////////////////////////////////
                     Read_EraseStatus;
                     DOut_zd[7:0] = Status;
                     DOut_zd[15: 8] = 8'bz;
                end
            end

            SERS:
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status - sector erase timeout
                    ///////////////////////////////////////////////////////////
                    if (BankErase[BA])
                    begin
                        Status[3]   = 1'b0;
                        DOut_zd[7:0] = Status;
                        DOut_zd[15: 8] = 8'bz;
                    end
                    else
                        Drive_DoutZd;
                end
            end

            ESPS:
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ///////////////////////////////////////////////////////////
                    if (BankErase[BA])
                    begin
                         Read_EraseStatus;
                         DOut_zd[7:0] = Status;
                         DOut_zd[15 : 8] = 8'bz;
                    end
                    else
                        Drive_DoutZd;
                end
            end

            SERS_EXEC:
            begin
                if (oe)
                begin
                    if (BankErase[BA])
                    begin
                         Read_EraseStatus;
                         DOut_zd[7:0] = Status;
                         DOut_zd[15 : 8] = 8'bz;
                    end
                    else
                        Drive_DoutZd;
                end
            end

            ESP:
            begin
                if (oe)
                begin
                    Readmem_EraseSuspend;
                end
            end

            ESP_ULBYPASS:
            begin
                if (oe)
                    Readmem_EraseSuspend;
            end

            ESP_AS:
            begin
            if (oe)
            begin
                if (BankAutosel[BA])
                begin
                    Read_AutoSelect_space;
                end
                else
                    Readmem_EraseSuspend;
            end
            end

           PGMS:
           begin
           if (oe)
               if (BankBusy[BA]==1'b1)
               begin
               ///////////////////////////////////////////////////////////
               //read status
               //////////////////////////////////////////////////////////
                   Status[6] = ~Status[6]; //toggle
                   Status[5] = 1'b0;
                   //Status(2) no toggle
                   Status[1] = 1'b0;
                   DOut_zd[7:0] = Status;
                   DOut_zd[15:8] = 8'bz;
               end
               else  // read form non program sector!!!!!!!!!!!!!!!!!!
               begin
                  Readmem_EraseSuspend;
               end
           end
        endcase
    end
    end

    always@(current_state)
    begin
        case(current_state)
        CFI, AS_CFI, ESP_CFI, ESP_AS_CFI:
            BankBusy = ~(0);
        endcase
    end

    always @(write or reseted)
    begin: Output_generation
        if (~reseted)
        begin
            ERS_ACT   = 1'b0;
            ULBYPASS  = 1'b0;
            BankErase = 0;
            BankEraseExec = 0;
            BankBypassLock = 0;
            BankAutosel = 0;
            BankBusy = 0;
            Ers_Queue = 0;
            Ers_SubTop_Queue = 0;
            ASynchroMod = 1;
            BurstModeReg = ComandBurstInit;
         end

        if (reseted)
        begin
        case (current_state)
            RESET:
            begin
                ERS_ACT   = 1'b0;
                ULBYPASS  = 1'b0;
                BankErase = 0;
                BankEraseExec = 0;
                BankBypassLock = 0;
                BankAutosel = 0;
                BankBusy = 0;
                Ers_Queue = 0;
                Ers_SubTop_Queue = 0;
                if (~write)
                begin
                end
            end

            Z001:
            begin
            end

            SEC_SECURITY_PRIOR2:
            begin
            end

            SEC_SECURITY_PRIOR:
            if (~write)
            begin
               if (DataLo == 16'h60)
                   if (~((SA != TopSec && Ers_Queue[SA]) ||
                   (SA == TopSec && Ers_SubTop_Queue[SSA])))
                       SoftProtectSector;
            end

            SEC_SECURITY:
            begin
                if (~write)
                begin
                    if (DataLo == 16'h60)
                        if (~((SA != TopSec && Ers_Queue[SA]) ||
                        (SA == TopSec && Ers_SubTop_Queue[SSA])))
                            SoftProtectSector;
                end
            end

            PREL_SETBWB:
            begin
                if (~write)
                begin
                if (A_PAT_1 && (DataLo == 16'h20))
                    BankBypassLock[BA] = 1'b1;
                else if (A_PAT_1 && (DataLo == 16'h90))   //autoselect mode
                    BankAutosel[BA] = 1'b1;
                else if (A_PAT_1 && (DataLo == 16'hC0))
                    BurstModeReg = AddressLatch[19:12];
                end
            end

            PREL_ULBYPASS:
            begin
                ULBYPASS = 1'b1;
            end

            CFI, AS_CFI, ESP_CFI, ESP_AS_CFI :
            begin
                if (~write)
                   if (DataLo==16'hF0)  //remove autoselect mode bank
                        BankBusy = 0;
            end

            AS:
            begin
                if (~write)
                    if (DataLo==16'hF0)  //remove autoselect mode bank
                        BankAutosel = 0;
            end

            UNLOCK_RESET, ESP_UNLOCK_RESET:
            begin
                if (~write)
                    if (DataLo==16'h00)
                    begin
                        BankBypassLock = 0;
                        ULBYPASS = 1'b0;
                    end
             end

            A0SEEN , ESP_A0SEEN:
            begin
            if (~write)
                if ((BankBypassLock[BA] && ULBYPASS )
                         || (~ULBYPASS))
                begin
                    if (
                        (
                        (SA != TopSec)
                        && ~Sec_Prot[SA]) ||
                        ((SA == TopSec) &&~SubSecTop_Prot[SSA]))
                    begin
                        WRData  = Data;
                        WRSA = SA;
                        WRAddress = Address;
                        Mem_tmp = Mem[WRSA*SecSize + WRAddress];
                        Mem[WRSA*SecSize + WRAddress] = -1;
                        Status[7] = ~ DataLo[7];
                        BankBusy[BA] = 1'b1;
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                    end
                    else
                    begin
                        Status[7] = ~ DataLo[7];
                        BankBusy[BA] = 1'b1;
                        PSTART = 1'b1;
                        PSTART = #1 1'b0;
                    end
                end
            end

            C8:
            begin
            end

            C8_Z001:
            begin
            end

            C8_PREL:
            begin
                if (~write)
                    if (A_PAT_1 && DataLo == 16'h10)
                    //Start Chip Erase
                    begin
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_Queue = ~(0);
                        Ers_SubTop_Queue = ~(0);
                        Status = 8'b00001000;
                        ESTART = 1'b1;
                        BankErase = ~(0);
                        ESTART = #1 1'b0;
                        ERS_ACT = 1'b1;
                        erase_start = $time;
                    end
                else if (DataLo==16'h30)
                begin
                    //put selected sector to sec. ers. queue
                    //start timeout
                    if (((BankBypassLock[BA]) && (ULBYPASS))
                    || (~ULBYPASS))
                    begin
                        ERS_ACT = 1'b1;
                        Ers_Queue = 0;
                        Ers_SubTop_Queue = 0;
                        if (SA == TopSec)
                            Ers_SubTop_Queue[SSA] = 1'b1;
                        else
                            Ers_Queue[SA] = 1'b1;
                        BankErase[BA] = 1'b1;
                        CTMOUT_in = 1'b1;
                        if ((SA != TopSec)
                        && ~Sec_Prot[SA])
                            BankEraseExec[BA] = 1'b1;
                        else if ((SA == TopSec)&&
                        ~SubSecTop_Prot[SSA])
                            BankEraseExec[BA] = 1'b1;
                     end
                end
            end

            ERS:
            begin
            end

            SERS:
            begin
            if (~write)
                if (DataLo == 16'hB0)
                begin
                    //need to start erase process prior to suspend
                    if (BankErase[BA])
                    begin
                        CTMOUT_in = 1'b0;
                        ERES      = 1'b0;
                        ESTART    = 1'b1;
                        ESTART    = #1 1'b0;
                        ESUSP     = 1'b1;
                        ESUSP     = #1 1'b0;
                    end
                end
                else if (DataLo==16'h30)
                begin
                    if (SA == TopSec)
                        Ers_SubTop_Queue[SSA] = 1'b1;
                    else
                         Ers_Queue[SA] = 1'b1;
                    BankErase[BA] = 1'b1;
                    if ((SA != TopSec)
                    && ~Sec_Prot[SA])
                       BankEraseExec[BA] = 1'b1;
                    else if ((SA == TopSec)&&
                    ~SubSecTop_Prot[SSA])
                       BankEraseExec[BA] = 1'b1;

                    CTMOUT_in = 1'b0;
                    CTMOUT_in = #2 1'b1;
                end
                else
                begin
                    CTMOUT_in  = 1'b0;
                    Ers_Queue = 0;
                    Ers_SubTop_Queue = 0;
                end

            end

            SERS_EXEC:
            begin
                if (~write)
                    if (DataLo==8'hB0 && BankErase[BA])
                    begin
                        ESTART_T1_in = 1'b1;
                        ESUSP = 1'b1;
                        ESUSP = #1 1'b0;
                    end
            end

            ESP:
            begin
                if (~write)
                    if (DataLo==16'h30 && BankErase[BA])
                    begin
                        ERES = 1'b1;
                        ERES = #1 1'b0;
                    end
            end

            ESP_ULBYPASS:
            begin
                ULBYPASS = 1'b1;
                if (~write)
                    if (DataLo == 16'h30 && BankErase[BA])
                        ERES = 1'b1;
                        ERES = #1 1'b0;
            end

            ESP_Z001:
            begin
            end

            ESP_PREL:
            begin
                if (~write)
                    if (A_PAT_1 && (DataLo == 16'h20))
                        BankBypassLock[BA] = 1'b1;
                    else if (A_PAT_1 && (DataLo == 16'h90))   //autoselect mode
                        BankAutosel[BA] = 1'b1;
                    else if (A_PAT_1 && (DataLo == 16'hC0))
                        BurstModeReg = AddressLatch[19:12];
            end

            ESP_AS:
            begin
                if (~write)
                    if (DataLo==16'hF0)  //remove autoselect mode bank
                        BankAutosel = 0;
            end

            PGMS:
            begin
            end
        endcase
        end
    end

//******************************
    always @(EERR or EDONE or current_state)
    begin: ERS2
    integer i;
    integer j;
    integer mem_ind;
    if (current_state==ERS)
    begin
        if (EERR!=1'b1)
        begin
            for (i=0;i<=SecNum-2;i=i+1)
                if  (~Sec_Prot[i])
                begin
                     mem_ind = i*SecSize;
                     for (y=0;y<=SecSize -1 ;y=y+1)
                     begin
                         Mem[mem_ind + y] = -1;
                     end
                end
                for (y=0;y<=SubSecNum-1;y=y+1)
                    if (~SubSecTop_Prot[y] )
                         for (k=sssa[y];k<=ssea[y];k=k+1)
                             Mem[TopSec*SecSize + k]=-1;
            if (EDONE)
            begin
                for (i=0;i<=SecNum-2;i=i+1)
                   if  (~Sec_Prot[i])
                   begin
                       mem_ind = i*SecSize;
                       for (y=0;y<=SecSize -1 ;y=y+1)
                       begin
                            Mem[mem_ind + y] = MaxData;
                       end
                   end
                   for (y=0;y<=SubSecNum-1;y=y+1)
                      if (~SubSecTop_Prot[y] )
                           for (k=sssa[y];k<=ssea[y];k=k+1)
                               Mem[TopSec*SecSize + k]= MaxData;
             end
         end
    end
    end

    always @(CTMOUT or current_state)
    begin: SERS2
        if (current_state==SERS)
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                ESTART_T1_in = 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                erase_start = $time;
                -> bank_erase_event;
                ESTART = 1'b1;
                ESTART = #1 1'b0;
            end
    end

    always @(ESTART_T1 or current_state)
    begin: ESPS2
        if (current_state==ESPS)
            if (ESTART_T1 )
             begin
                ESTART_T1_in = 1'b0;
             end
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
    integer mem_ind;
    if (current_state==SERS_EXEC)
    begin
        if (EERR!=1'b1)
        begin
            for (i=0;i<=SecNum-2;i=i+1)
                if  (~Sec_Prot[i] && Ers_Queue[i])
                begin
                     mem_ind = i*SecSize;
                     for (y=0;y<=SecSize -1 ;y=y+1)
                         Mem[mem_ind + y] = -1;
                end
            for (y=0;y<=SubSecNum-1;y=y+1)
                if (~SubSecTop_Prot[y] && Ers_SubTop_Queue[y] )
                     for (k=sssa[y];k<=ssea[y];k=k+1)
                         Mem[TopSec*SecSize + k]=-1;

            if (EDONE)
            begin
                for (i=0;i<=SecNum-2;i=i+1)
                    if  (~Sec_Prot[i]&& Ers_Queue[i])
                    begin
                         mem_ind = i*SecSize;
                         for (y=0;y<=SecSize -1 ;y=y+1)
                         begin
                             Mem[mem_ind + y] = MaxData;
                         end
                    end
                    for (y=0;y<=SubSecNum-1;y=y+1)
                        if (~SubSecTop_Prot[y] && Ers_SubTop_Queue[y])
                             for (k=sssa[y];k<=ssea[y];k=k+1)
                                 Mem[TopSec*SecSize + k]= MaxData;
             end
         end
    end
    end

    always @( posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
    if (current_state==PGMS)
    begin
           if (~PERR)
                if  (PDONE)

                    if ((Mem_tmp != -1) & (WRData != -1))
                        begin
                            Mem[WRSA*SecSize+WRAddress] = WRData & Mem_tmp;
                            BankBusy = 0;
                        end
                    else
                    begin
                        Mem[WRSA*SecSize+WRAddress] = WRData;
                        BankBusy = 0;
                    end
    end
    end

    always @( negedge PERR)
    begin: PGMS3
    integer i,j;
    if (current_state==PGMS)
    begin
           if (~PERR)
                BankBusy = 0;
    end
    end

    always @(gOE_n or gCE_n or RESETNeg or RST)
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
         begin
            DOut_zd = 16'bZ;
         end
    end

    always @(gOE_n or OENeg or gCE_n or RESETNeg or RST or RDY_tmp)
    begin
        //Control for RDY
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
        begin
            RDY_zd =  1'bZ;
            if ((~OENeg && ~gCE_n) && ~ASynchroMod
            && (RESETNeg || RST))
                RDY_zd = RDY_tmp;
        end
        else if (~gOE_n && ~gCE_n && ~ASynchroMod)
            RDY_zd =  RDY_tmp;
     end

    initial
    begin
        ///////////////////////////////////////////////////////////////////////
        //CFI array data
        ///////////////////////////////////////////////////////////////////////
            //CFI query identification string
            for (i=16;i<93;i=i+1)
                 CFI_array[i] = -1;
            CFI_array[8'h10] = 16'h0051;
            CFI_array[8'h11] = 16'h0052;
            CFI_array[8'h12] = 16'h0059;
            CFI_array[8'h13] = 16'h0002;
            CFI_array[8'h14] = 16'h0000;
            CFI_array[8'h15] = 16'h0040;
            CFI_array[8'h16] = 16'h0000;
            CFI_array[8'h17] = 16'h0000;
            CFI_array[8'h18] = 16'h0000;
            CFI_array[8'h19] = 16'h0000;
            CFI_array[8'h1A] = 16'h0000;
            CFI_array[8'h1B] = 16'h0017;
            CFI_array[8'h1C] = 16'h0019;
            CFI_array[8'h1D] = 16'h0000;
            CFI_array[8'h1E] = 16'h0000;
            CFI_array[8'h1F] = 16'h0003;
            CFI_array[8'h20] = 16'h0000;
            CFI_array[8'h21] = 16'h0009;
            CFI_array[8'h22] = 16'h0000;
            CFI_array[8'h23] = 16'h0005;
            CFI_array[8'h24] = 16'h0000;
            CFI_array[8'h25] = 16'h0004;
            CFI_array[8'h26] = 16'h0000;
            CFI_array[8'h27] = 16'h0018;
            CFI_array[8'h28] = 16'h0001;
            CFI_array[8'h29] = 16'h0000;
            CFI_array[8'h2A] = 16'h0000;
            CFI_array[8'h2B] = 16'h0000;
            CFI_array[8'h2C] = 16'h0002;
            CFI_array[8'h2D] = 16'h00FE;
            CFI_array[8'h2E] = 16'h0000;
            CFI_array[8'h2F] = 16'h0000;
            CFI_array[8'h30] = 16'h0001;
            CFI_array[8'h31] = 16'h0003;
            CFI_array[8'h32] = 16'h0000;
            CFI_array[8'h33] = 16'h0040;
            CFI_array[8'h34] = 16'h0000;
            CFI_array[8'h35] = 16'h0000;
            CFI_array[8'h36] = 16'h0000;
            CFI_array[8'h37] = 16'h0000;
            CFI_array[8'h38] = 16'h0000;
            CFI_array[8'h39] = 16'h0000;
            CFI_array[8'h3A] = 16'h0000;
            CFI_array[8'h3B] = 16'h0000;
            CFI_array[8'h3C] = 16'h0000;
            CFI_array[8'h40] = 16'h0050;
            CFI_array[8'h41] = 16'h0052;
            CFI_array[8'h42] = 16'h0049;
            CFI_array[8'h43] = 16'h0031;
            CFI_array[8'h44] = 16'h0033;
            CFI_array[8'h45] = 16'h0000;
            CFI_array[8'h46] = 16'h0002;
            CFI_array[8'h47] = 16'h0001;
            CFI_array[8'h48] = 16'h0000;
            CFI_array[8'h49] = 16'h0005;
            CFI_array[8'h4A] = 16'h00C0;
            CFI_array[8'h4B] = 16'h0001;
            CFI_array[8'h4C] = 16'h0000;
            CFI_array[8'h4D] = 16'h00B5;
            CFI_array[8'h4E] = 16'h00C5;
            CFI_array[8'h4F] = 16'h0003;
            CFI_array[8'h50] = 16'h0000;
            CFI_array[8'h57] = 16'h0004;
            CFI_array[8'h58] = 16'h0040;
            CFI_array[8'h59] = 16'h0040;
            CFI_array[8'h5A] = 16'h0040;
            CFI_array[8'h5B] = 16'h0043;
            CFI_array[8'h5C] = 16'h0002;
   end

   reg  BuffIn1, BuffIn2, BuffIn3, BuffIn4, BuffIn5, BuffIn6;
   wire BuffOut1,BuffOut2,BuffOut3,BuffOut4,BuffOut5,BuffOut6;

   VITALBuf  TPOW (BuffOut1, BuffIn1);
   VITALBuf  TSEO (BuffOut3, BuffIn3);
   VITALBuf  TREADY  (BuffOut4, BuffIn4);
   VITALBuf  TCTMOUT (BuffOut5, BuffIn5);
   VITALBuf  TESTART_T1(BuffOut6, BuffIn6);

   reg  BuffInOE, BuffInCE, BuffInASync, BuffInAAsync, BuffInCLK;
   wire BuffOutOE, BuffOutCE, BuffOutAAsync, BuffOutASync, BuffOutCLK;

   VITALBuf    BUFOENeg   (BuffOutOE, BuffInOE);
   VITALBuf    BUFCENeg   (BuffOutCE, BuffInCE);
   VITALBuf    BUFCLK     (BuffOutCLK, BuffInCLK);
   VITALBuf    BUFADDRasync  (BuffOutAAsync, BuffInAAsync);
   VITALBuf    BUFADDRsync   (BuffOutASync, BuffInASync);

   initial
    begin
        BuffInOE   = 1'b1;
        BuffInCE   = 1'b1;
        BuffInCLK  = 1'b1;
        BuffInAAsync = 1'b1;
        BuffInASync  = 1'b1;
    end

    time CEDQ_t, OEDQ_t, ADDRDQ_t, CLKDQ_t, CLK_RDY_t, OE_RDY_t;
    time AASYNCDQ_01, ASYNCDQ_01, CEDQ_01, OEDQ_01, CLKDQ_01;
    time CENeg_event, OENeg_event, ADDR_event, CLK_event, ADDRSync_event = 0;
    time OENeg_posEvent=0;
    time CENeg_posEvent=0;
    integer sync_flag = 0;

    always @(posedge BuffOutOE)
    begin
        OEDQ_01 = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CEDQ_01 = $time;
    end
    always @(BuffOutAAsync)
    begin
        AASYNCDQ_01 = $time;
    end
    always @(BuffOutASync)
    begin
        ASYNCDQ_01 = $time;
    end

    always @(BuffOutCLK)
    begin
        CLKDQ_01 = $time;
    end

    always @(negedge CENeg)
    begin
         CENeg_event = $time;
    end

    always @(negedge OENeg)
    begin
         OENeg_event = $time;
    end

    always @(posedge CLK)
    begin
         CLK_event = $time;
    end

    always @(posedge OENeg)
    begin
        OENeg_posEvent = $time;
    end
    always @(posedge CENeg)
    begin
        CENeg_posEvent = $time;
    end

    always @(AddressLatch)
    begin
         ADDR_event = $time;
    end

    always @(posedge CLK)
    begin
         if(~CENeg && ~AVDNeg && sync_flag == 0)
         begin
            ADDRSync_event = $time;
            sync_flag = 1;
         end
    end

    always @(posedge AVDNeg, posedge CENeg)
    begin
         sync_flag = 0;
    end

    always @(DOut_zd)
    begin: OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            if (ASynchroMod)
            begin
                close_buffer = 1'b0;
                CEDQ_t = CENeg_event  + CEDQ_01;
                OEDQ_t = OENeg_event  + OEDQ_01;
                ADDRDQ_t = ADDR_event + AASYNCDQ_01;
                FROMADDR =((ADDRDQ_t >= CEDQ_t) && (ADDRDQ_t >= OEDQ_t) &&
                ( ADDRDQ_t >= $time));
                FROMCE = ((CEDQ_t >= OEDQ_t) && (CEDQ_t >= $time));
                FROMOE  = ((OEDQ_t > CEDQ_t) && (OEDQ_t >= $time));

                DOut_Pass[15:0] = 16'hz;
                if(FROMCE && ~FROMOE && ~FROMADDR)
                begin
                   #(CEDQ_t - $time);
                end
                if( FROMADDR&& (FROMOE || FROMCE))
                begin
                    DOut_Pass[15:0] = 16'hx;
                    #(ADDRDQ_t - $time);
                end
                DOut_Pass[15:0] = DOut_zd[15:0];
           end
           else
           begin
                ADDRDQ_t = ADDRSync_event + ASYNCDQ_01;
                if (ADDRDQ_t >= $time)
                begin
                    ClkAddr_tmp = 1'b0;
                    DOut_Pass[15:0] = 16'hx;
                    #(ADDRDQ_t - $time);
                end
                else if (End_burst)
                    # ASYNCDQ_01;
                DOut_Pass[15:0] = DOut_zd[15:0];
                #1 ClkAddr_tmp = 1'b1;
          end
       end
   end

   always @(RDY_zd)
   begin: RDYGen
        time tAD;
        if (RDY_zd !== 1'bz)
        begin
            PtEn_tmp = 1'b1;
            if (BankBusy[BA] || BankAutosel[BA]
            || (BankErase[BA] && (current_state == SERS_EXEC ||
            current_state == ERS))
            || (SA == TopSec  && ~SubSecTop_Prot[SSA]
                && Ers_SubTop_Queue[SSA])
            || (SA != TopSec && ~Sec_Prot[SA]
                && Ers_Queue[SA]))
            begin
                PtEn_tmp = 1'b0;
                tAD = ADDRSync_event + ASYNCDQ_01;
                if (~End_burst)
                begin
                    tAD = ADDRSync_event + ASYNCDQ_01;
                    if (tAD > $time)
                    begin
                        RDY_Pass <= 1'b0;
                        RDY_Pass <= #(tAD-$time) 1'b1;
                    end
                    else
                        RDY_Pass <= 1'b1;
                    end
                else
                begin
                    RDY_Pass <= #(CLKDQ_01) 1'b0;
                    RDY_Pass <= #(ASYNCDQ_01) 1'b1;
                end
                -> EndB_ev;
            end
            else
            begin
                CLK_RDY_t = CLK_event + CLKDQ_01;
                OE_RDY_t  = OENeg_event+ OEDQ_01;
                if((OE_RDY_t - CLK_event) < OEDQ_01 && CLK_RDY_t > $time &&
                OE_RDY_t > $time)
                begin
                    clk_RdyOe = 1'b0; # (CLKDQ_01);
                    RDY_Pass <= RDY_zd; #1 clk_RdyOe = 1'b1;
                end
                else
                begin
                    RDY_Pass = RDY_zd;
                end
            end
       end
       else
            RDY_Pass = RDY_zd;
   end

   always @(DOut_zd)
   begin
       if (DOut_zd[0] === 1'bz)
       begin
           disable OutputGen;
           FROMCE = 1'b1;
           FROMOE = 1'b1;
           if ((CENeg_posEvent <= OENeg_posEvent) &&
           ( CENeg_posEvent + 5 >= $time))
               FROMOE = 1'b0;
           if ((OENeg_posEvent < CENeg_posEvent) &&
           ( OENeg_posEvent + 5 >= $time))
               FROMCE = 1'b0;
           FROMCLK = 1'b0;
           FROMADDR = 1'b0;
           close_buffer = 1'b1;
           DOut_Pass = DOut_zd;
       end
   end
 endmodule

 module VITALBuf ( OUT,IN);
   input IN;
   output OUT;
   buf   ( OUT, IN);
 endmodule
