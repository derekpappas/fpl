//////////////////////////////////////////////////////////////////////////////
//  File name : am29bl162c.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion.
//
//  MODIFICATION HISTORY :
//
//  version: | author:      | mod date: | changes made:
//    V1.0    N.Makljenovic  04 Aug 27   Inital Release
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           am29bl162c
//
//  Description:    16Mbit (1M x16-Bit) Simultaneous opration, Burst mode,
//                  Top boot sector
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ps
 ////////////////////////////////////////////////
 // Bot level module, FLASH
 ////////////////////////////////////////////////

module am29bl162c
(
    A19     ,
    A18     ,
    A17     ,
    A16     ,
    A15     ,
    A14     ,
    A13     ,
    A12     ,
    A11     ,
    A10     ,
    A9      ,
    A8      ,
    A7      ,
    A6      ,
    A5      ,
    A4      ,
    A3      ,
    A2      ,
    A1      ,
    A0      ,
             
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
    LBANeg   ,
    OENeg    ,
    WENeg    ,
    RESETNeg ,
    CLK      ,
    BAANeg   ,
    IND      ,
    RY      );

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
    input  A19  ;
    input  A18  ;
    input  A17  ;
    input  A16  ;
    input  A15  ;
    input  A14  ;
    input  A13  ;
    input  A12  ;
    input  A11  ;
    input  A10  ;
    input  A9   ;
    input  A8   ;
    input  A7   ;
    input  A6   ;
    input  A5   ;
    input  A4   ;
    input  A3   ;
    input  A2   ;
    input  A1   ;
    input  A0   ;

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
    input  LBANeg   ;
    input  OENeg    ;
    input  WENeg    ;
    input  RESETNeg ;
    input  CLK      ;
    input  BAANeg   ;
    output IND      ;
    output RY       ;

// interconnect path delay signals

    wire  A19_ipd  ;
    wire  A18_ipd  ;
    wire  A17_ipd  ;
    wire  A16_ipd  ;
    wire  A15_ipd  ;
    wire  A14_ipd  ;
    wire  A13_ipd  ;
    wire  A12_ipd  ;
    wire  A11_ipd  ;
    wire  A10_ipd  ;
    wire  A9_ipd   ;
    wire  A8_ipd   ;
    wire  A7_ipd   ;
    wire  A6_ipd   ;
    wire  A5_ipd   ;
    wire  A4_ipd   ;
    wire  A3_ipd   ;
    wire  A2_ipd   ;
    wire  A1_ipd   ;
    wire  A0_ipd   ;

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

    wire [19 : 0] A;
    assign A = {
             
                A19_ipd,
                A18_ipd,
                A17_ipd,
                A16_ipd,
                A15_ipd,
                A14_ipd,
                A13_ipd,
                A12_ipd,
                A11_ipd,
                A10_ipd,
                A9_ipd,
                A8_ipd,
                A7_ipd,
                A6_ipd,
                A5_ipd,
                A4_ipd,
                A3_ipd,
                A2_ipd,
                A1_ipd,
                A0_ipd };

    wire [19 : 0 ] DIn;
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
    wire  CSNeg_ipd    ;
    wire  AVD_ipd      ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  RESETNeg_ipd ;
    wire  CLK_ipd      ;
    wire  WPNeg_ipd    ;
    wire  ACC_ipd      ;

//  internal delays
    reg POW_in     ;
    reg POW_out    ;

    reg SEO_in      ;
    reg SEO_out     ;

    reg HANG_out    ; // Program/Erase Timing Limit
    reg HANG_in     ;
    reg PSTART_T1   ; // Start TimeOut
    reg PSTART_T1_in;
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

    wire  DQ15_pass;
    wire  DQ14_pass;
    wire  DQ13_pass;
    wire  DQ12_pass;
    wire  DQ11_pass;
    wire  DQ10_pass;
    wire  DQ9_pass;
    wire  DQ8_pass;
    wire  DQ7_pass;
    wire  DQ6_pass;
    wire  DQ5_pass;
    wire  DQ4_pass;
    wire  DQ3_pass;
    wire  DQ2_pass;
    wire  DQ1_pass;
    wire  DQ0_pass;

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

    reg [15 : 0] DOut_pass;
    assign {DQ15_pass,
            DQ14_pass,
            DQ13_pass,
            DQ12_pass,
            DQ11_pass,
            DQ10_pass,
            DQ9_pass,
            DQ8_pass,
            DQ7_pass,
            DQ6_pass,
            DQ5_pass,
            DQ4_pass,
            DQ3_pass,
            DQ2_pass,
            DQ1_pass,
            DQ0_pass  } = DOut_pass;

    reg RY_zd;
    reg IND_zd = 1'b1;
    reg IND_pass = 1'b1;

    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter UserPreload     = 1'b0;
    parameter TimingModel     = "DefaultTimingModel";
    parameter MemSize         = 20'hFFFFF;
    parameter PartID          = "am29bl162c";
    parameter MaxData         = 16'hFFFF; // 65535;
    parameter SecSize         = 20'h20000; // secsize
    parameter SecNum          = 8;
    parameter SubSecNum       = 4;
    parameter HiAddrBit       = 19;
    parameter LowSecAddrBit   = 17;
    parameter BottomSec       = 0;

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
    reg [SubSecNum-1:0] Ers_SubBot_Queue ;

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SA = 0;         // 0 - SecNum 
    integer SSA= 0;      // 0 SubSec number
    //Address within sector
    integer Address = 0;         // 0 - SecSize
    integer BrAddrSt = 0;
    reg[HiAddrBit:0] AddressLatch;

    time ADDRDQ_01, CEDQ_01, OEDQ_01, CLKDQ_01, RESETDQ;
    reg BurstEnable;

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
    reg [SecNum-1:0] Sec_Prot=0;
    reg [SecNum-1:0] Sec_ProtTmp=0;
    //Sector Protection for Bot 4 sectors
    reg [SubSecNum-1:0] Ssb_prot;
    reg [SubSecNum-1:0] Ssb_protTmp;
    integer CFI_array[8'h10:8'h4C];
    integer sssa[0:SubSecNum-1];
    integer ssea[0:SubSecNum-1] ;

    // Burst mode signals
    reg WrapAround;

    reg Viol = 1'b0;

    reg       Start_burst;
    reg       End_burst;
    reg EntEmbaded;
    integer cnt = 0;  

    reg ASynchroMod = 1'b1;
    reg oe = 1'b0;
    event oe_event;

    event initOK;

    //Status reg.
    reg[7:0] Status = 8'b0;
    reg[15:0] CFI_data = 0;

    // iterator for FOR loop
    integer i,j,k;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
 buf   (A19_ipd, A19);
 buf   (A18_ipd, A18);
 buf   (A17_ipd, A17);
 buf   (A16_ipd, A16);
 buf   (A15_ipd, A15);
 buf   (A14_ipd, A14);
 buf   (A13_ipd, A13);
 buf   (A12_ipd, A12);
 buf   (A11_ipd, A11);
 buf   (A10_ipd, A10);
 buf   (A9_ipd , A9 );
 buf   (A8_ipd , A8 );
 buf   (A7_ipd , A7 );
 buf   (A6_ipd , A6 );
 buf   (A5_ipd , A5 );
 buf   (A4_ipd , A4 );
 buf   (A3_ipd , A3 );
 buf   (A2_ipd , A2 );
 buf   (A1_ipd , A1 );
 buf   (A0_ipd , A0 );

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
 buf   (LBANeg_ipd   , LBANeg   );
 buf   (OENeg_ipd    , OENeg    );
 buf   (WENeg_ipd    , WENeg    );
 buf   (RESETNeg_ipd , RESETNeg );
 buf   (CLK_ipd      , CLK      );
 buf   (ACC_ipd      , BAANeg   );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
 nmos   (DQ15,   DQ15_pass , 1);
 nmos   (DQ14,   DQ14_pass , 1);
 nmos   (DQ13,   DQ13_pass , 1);
 nmos   (DQ12,   DQ12_pass , 1);
 nmos   (DQ11,   DQ11_pass , 1);
 nmos   (DQ10,   DQ10_pass , 1);
 nmos   (DQ9 ,   DQ9_pass , 1);
 nmos   (DQ8 ,   DQ8_pass , 1);
 nmos   (DQ7 ,   DQ7_pass , 1);
 nmos   (DQ6 ,   DQ6_pass , 1);
 nmos   (DQ5 ,   DQ5_pass , 1);
 nmos   (DQ4 ,   DQ4_pass , 1);
 nmos   (DQ3 ,   DQ3_pass , 1);
 nmos   (DQ2 ,   DQ2_pass , 1);
 nmos   (DQ1 ,   DQ1_pass , 1);
 nmos   (DQ0 ,   DQ0_pass , 1);

 nmos   (RY  ,   1'b0      , ~RY_zd);
 buf    (IND ,   IND_pass);

 wire deg;
 reg ClkOe_en = 1'b0;
 reg ClkAddr_en = 1'b1;
 reg ClkAddr_tmp = 1'b1;
 reg clk_RYOe = 1'b1; 
 reg ADDRDQ = 0;  
 reg first_b = 1'b0;

 wire OE_en;
 reg  FROMCE, FROMOE, FROMADDR, FROMCLK, FROMCLK_RY, FROMOE_RY;
 reg  close_buffer;
 wire SyncEn; 
 assign SyncEn  = ~LBANeg & ~ASynchroMod & ~CENeg;
 wire ASynchro;
 assign ASynchro = ASynchroMod;
  wire clk_out;
 assign clk_out = ClkOe_en && ClkAddr_en&& ~OENeg && ~CENeg &&  CLK && reseted;
  wire ClkIndEn;
  wire SynchroOe;

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
                        //(tCE,tCE,tDF,-,tDF,-)
     specparam           tpd_CENeg_DQ0           =1;
                       //(tOE,tOE,tDF,-,tDF,-)
     specparam           tpd_OENeg_DQ0           =1;

     specparam           tpd_CLK_DQ0             =1;
                          
     specparam           tpd_CLK_IND             =1;

     specparam           tpd_WENeg_RY            =1;

     // Setup values
     // Asynchronous write //tAS, async, WENeg \
     specparam           tsetup_A0_WENeg           =1;
     specparam           tsetup_A0_CENeg           =1;
                         //tDS, WENeg /
     specparam           tsetup_DQ0_WENeg          =1;
     specparam           tsetup_DQ0_CENeg          =1;
                         //tCS, CENeg LOW, WENeg \
     specparam           tsetup_CENeg_WENeg        =1;
                         
     // Synchronous write //tAS for synchro, WENeg high , LBANeg /
     specparam           tsetup_A0_LBANeg          =1;
     specparam           tsetup_A0_CLK             =1;
                         //tCAS, LBANeg \
     specparam           tsetup_CENeg_LBANeg       =1;
                         // tAVSW, LBANeg low, WENeg \
     specparam           tsetup_LBANeg_WENeg       =1;
     specparam           tsetup_CLK_WENeg_LBANeg_EQ_0  =1;
     specparam           tsetup_CLK_WENeg_LBANeg_EQ_1  =1;

                        //tGHWL, OENeg HIGH , WENeg \
     specparam           tsetup_OENeg_WENeg        =1;
     specparam           tsetup_WENeg_OENeg        =1;
                         // tOEH, status check, WEneg HIGH, OENeg \

     // Burst mode       //tCES  , CE LOW    , CLK /
     specparam           tsetup_CENeg_CLK          =1;
     specparam           tsetup_LBANeg_CLK         =1;

     specparam           tsetup_RY_CLK           =1;
     specparam           tsetup_CLK_LBANeg       =1;
     specparam           tsetup_CLK_WENeg        =1;

     // thold values: hold times
     specparam           thold_CENeg_RESETNeg    =1; //tRH  edge /
     specparam           thold_OENeg_RESETNeg    =1; //tRH  edge /

     specparam           thold_OENeg_WENeg       =1; //tOEH edge /
     specparam           thold_A0_WENeg          =1; //tAH async edge \
     specparam           thold_A0_CENeg          =1; //tAH async edge \
     // Synchro address latch
     specparam           thold_A0_CLK            =1; //tACH edge /
     specparam           thold_A0_LBANeg         =1;
                         //tAAH, tAAVDH, tAH synchro, edge /
     specparam           thold_CLK_WENeg         =1; //tCHW, edge \
     specparam           thold_LBANeg_CLK        =1; //tAVHC, edge /

     specparam           thold_DQ0_WENeg         =1; //tDH edge /
     specparam           thold_DQ0_CENeg         =1; //tDH edge /

     specparam           thold_WENeg_OENeg       =1; //tGHWL edge /
     specparam           thold_WENeg_CENeg       =1;
     specparam           thold_CENeg_WENeg       =1; //tCH, edge /

        // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1; //tRP
     specparam           tpw_WENeg_negedge       =1; //tWP
     specparam           tpw_WENeg_posedge       =1; //tWPH
     specparam           tpw_LBANeg_negedge      =1; //tAVDP

        // tdevice values: values for internal delays
            //Program Operation
     specparam   tdevice_POW                     = 9000; //9 us;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 1000000000;//1 sec;
            // erase suspend timeout
     specparam   tdevice_ESTART_T1               = 20000; //20 us;
            //sector erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 50000; //50 us;
            //device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 20000; //20 us; //tReady

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A0 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A1 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A1 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A2 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A2 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A3 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A3 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A4 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A4 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A5 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A5 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A6 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A6 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A7 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A7 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A8 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A8 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A9 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A9 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A10 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A10 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A11 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A11 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A12 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A12 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A13 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A13 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A14 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A14 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A15 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A15 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A16 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A16 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A17 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A17 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A18 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A18 => DQ15 ) = tpd_A0_DQ0;

    if (FROMADDR && ASynchroMod)
        ( A19 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR && ASynchroMod)
        ( A19 => DQ15 ) = tpd_A0_DQ0;

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

    (WENeg => RY)     = tpd_WENeg_RY;
    (CENeg => RY)     = tpd_WENeg_RY;

    if (clk_out) (CLK => IND) = tpd_CLK_IND;
    if (FROMOE) (OENeg  => IND) = tpd_CLK_IND;
    if (FROMCE) (CENeg  => IND) = tpd_CLK_IND;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           /
///////////////////////////////////////////////////////////////////////////////
        $setup ( A0 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A1 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A2 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A3 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A4 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A5 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A6 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A7 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A8 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A9 ,  negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge WENeg &&& ~CENeg, tsetup_A0_WENeg, Viol);

        $setup ( A0 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A1 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A2 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A3 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A4 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A5 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A6 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A7 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A8 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A9 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A10 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A11 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A12 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A13 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A14 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A15 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A16 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A17 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A18 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
        $setup ( A19 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);

        $setup ( DQ0 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ8 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ9 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ10 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ11 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ12 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ13 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ14 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ15 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);

        $setup ( DQ0 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 ,  posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);

        $setup ( A0 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A1 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A2 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A3 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A4 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A5 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A6 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A7 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A8 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A9 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A10 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A11 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A12 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A13 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A14 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A15 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A16 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A17 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A18 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
        $setup ( A19 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);

        $setup ( CENeg , negedge WENeg , tsetup_CENeg_WENeg, Viol);
        $setup ( WENeg , negedge CENeg , tsetup_CENeg_WENeg, Viol);
        $setup ( CENeg,  posedge CLK&&&SyncEn, tsetup_CENeg_CLK, Viol);
        $setup ( LBANeg, posedge CLK&&&ASynchro, tsetup_LBANeg_CLK, Viol);
        $setup ( BAANeg, posedge CLK&&&ASynchro, tsetup_LBANeg_CLK, Viol);
        $setup ( OENeg,  negedge WENeg , tsetup_OENeg_WENeg, Viol);
        $setup ( WENeg,  negedge OENeg , tsetup_WENeg_OENeg, Viol);
        $setup ( OENeg,  negedge WENeg , tsetup_WENeg_OENeg, Viol);
        $setup ( RY,     negedge CENeg,  tsetup_RY_CLK, Viol);
        $setup ( RY,     negedge WENeg,  tsetup_RY_CLK, Viol);

        $hold ( posedge CLK&&&SyncEn, A0 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A1 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A2 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A3 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A4 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A5 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A6 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A7 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A8 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A9 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A10 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A11 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A12 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A13 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A14 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A15 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A16 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A17 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A18 , thold_A0_CLK, Viol);
        $hold ( posedge CLK&&&SyncEn, A19 , thold_A0_CLK, Viol);

        $hold ( negedge CENeg &&& WENeg==0, A0 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A1 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A2 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A3 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A4 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A5 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A6 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A7 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A8 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A9 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A10 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A11 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A12 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A13 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A14 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A15 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A16 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A17 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A18 , tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A19 , tsetup_A0_CENeg, Viol);

        $hold (  posedge CENeg &&& WENeg==0, DQ0 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ1 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ2 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ3 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ4 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ5 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ6 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ7 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ8 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ9 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ10 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ11 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ12 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ13 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ14 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge CENeg &&& WENeg==0, DQ15 ,tsetup_DQ0_CENeg, Viol);

        $hold ( negedge WENeg &&& CENeg==0, A0 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A1 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A2 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A3 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A4 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A5 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A6 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A7 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A8 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A9 ,  tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A10 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A11 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A12 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A13 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A14 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A15 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A16 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A17 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A18 , tsetup_A0_CENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A19 , tsetup_A0_CENeg, Viol);

        $hold (  posedge WENeg &&& CENeg==0, DQ0 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ1 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ2 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ3 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ4 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ5 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ6 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ7 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ8 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ9 , tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ10 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ11 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ12 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ13 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ14 ,tsetup_DQ0_CENeg, Viol);
        $hold (  posedge WENeg &&& CENeg==0, DQ15 ,tsetup_DQ0_CENeg, Viol);

        $hold ( posedge CLK&&&SyncEn, DQ0,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ1,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ2,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ3,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ4,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ5,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ6,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ7,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ8,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ9,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( posedge CLK&&&SyncEn, DQ15,   thold_DQ0_WENeg, Viol);

        $hold ( posedge CLK, LBANeg&&&~ASynchro, thold_LBANeg_CLK, Viol);
        $hold ( posedge CLK, BAANeg&&&~ASynchro, thold_LBANeg_CLK, Viol);
        $hold ( posedge RESETNeg&&&CENeg, CENeg, thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg&&&OENeg, OENeg, thold_OENeg_RESETNeg, Viol);
        $hold ( posedge WENeg, CENeg , thold_WENeg_CENeg, Viol);
        $hold ( posedge CENeg, WENeg , thold_WENeg_CENeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (posedge WENeg, tpw_WENeg_posedge);
        $width (negedge WENeg, tpw_WENeg_negedge);
        $width (negedge CENeg, tpw_LBANeg_negedge);
        $width (posedge CENeg, tpw_LBANeg_negedge);
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
    parameter SET_MODE            =6'd8;
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

    reg deq;
    reg read_nosuspend_sect;
    integer WRData  = 0;
    integer Mem_tmp= 0;
    integer  WRSA;
    integer  WRAddress;
    integer WrapCnt     = 0;
    integer WrapMode    = 0;

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
        ClkOe_en <= 1'b1;
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
     sssa[2]=16'h3000;
     sssa[3]=16'h4000;
     ssea[0]=16'h1FFF;
     ssea[1]=16'h2FFF;
     ssea[2]=16'h3FFF;
     ssea[3]=20'h1FFFF;
      -> initOK;
    end 

    // preload
    initial
    begin: InitMemory
    integer j, sect, sect_addr;
    integer  sector_prot[0:SecNum + SubSecNum - 2];

        for (j=0;j<=MemSize;j=j+1)
            Mem[j]=MaxData;

        for (j=0;j<=SecNum + SubSecNum - 2;j=j+1)
            sector_prot[j]=0;  
        
        if (UserPreload && mem_file_name != "")
           $readmemh(mem_file_name,Mem); 
        if (UserPreload && prot_file_name != "")
           $readmemh(prot_file_name,sector_prot);

        for (j=0;j<=SecNum + SubSecNum - 2;j=j+1)
           if (j < 4)
               Ssb_prot[j] = sector_prot[j];
           else
               Sec_Prot[j-3] = sector_prot[j];

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
        ERS_ACT  = 1'b0;

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
                    R = 1'b0;//prog or erase not in progress
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
                  (R && RESETNeg && ~RST && ~READY))// ||
                  //(R && RESETNeg && RST && ~READY))
            begin
                //no state transition while RESET# low
                current_state = RESET; //reset start
                reseted       = 1'b0;
            end
        end
        else
        begin
            current_state = RESET; // reset
            reseted       = 1'b0;
            E = 1'b0;
            R = 1'b0;
        end
end

//    /////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    /////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

//    //latch address on rising edge and data on falling edge  of write
    always @(gWE_n or  gCE_n or  gOE_n or RESETNeg or reseted)
    begin: write_dc
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
    //Latch address on falling edge of WE# or CE# what ever comes later
    //Latches data on rising edge of WE# or CE# what ever comes first
    // also Write cycle decode
    ///////////////////////////////////////////////////////////////////////////
    integer A_tmp  ; 
    integer SA_tmp ; 
    integer BA_tmp;
    //DATA  High Byte
    integer Data;
    //DATA Low Byte
    integer DataLo;
    reg CE;

   reg   addr_latch = 1'b0;
   event addrLatch_event;
   always @(posedge WENeg_ipd, posedge CENeg_ipd)// or reseted)
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

   always @(A, CENeg, OENeg, WENeg)// or reseted)
    begin 
        if ((~CENeg && (WENeg != OENeg) && ASynchroMod ) ||
        (~CENeg && ~WENeg  && ~ASynchroMod ))
        begin
           -> addrLatch_event;
        end
    end

   always @(posedge CLK)
    begin
           if (CLK&& ~LBANeg && ~CENeg && ~addr_latch)
           begin
              -> addrLatch_event;
              addr_latch = 1'b1;
           end
    end

   always @(CENeg, LBANeg)
    begin 
        if (CENeg || LBANeg)
        begin
            addr_latch = 1'b0; 
        end
    end

    always @( addrLatch_event)
    begin
        Addr          = A[10:0];
        Address       = A[LowSecAddrBit-1:0];
        case (A[LowSecAddrBit-1 : LowSecAddrBit-5]) 
            2 : SSA = 1;
            3 : SSA = 2;
            0, 1 : SSA = 0;
            default : SSA = 3;
        endcase
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
                if (((SA != BottomSec)
                    && ~Sec_Prot[SA]
                    && ~Ers_Queue[SA])
                ||  
                    (SA == BottomSec && ~Ssb_prot[SSA]
                    && ~Ers_SubBot_Queue[SSA]))
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
 integer cnt_erase = 0;      // 0 - SecNum
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
                        if (i != BottomSec) 
                        begin
                          if (Ers_Queue[i] && ~Sec_Prot[i])  
                             cnt_erase = cnt_erase +1;
                        end
                        else
                        begin
                            for (y=0;y<= SubSecNum-1; y=y+1)
                            begin
                                if (Ers_SubBot_Queue[y]  && 
                                    ~Ssb_prot[y]) 
                                    cnt_erase = cnt_erase +1;
                            end
                        end
                    end
                    if (cnt_erase>0)
                    begin 
                        duration_erase = cnt_erase * tdevice_SEO;
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
        reg     RY_tmp;   // temp signal for ready
        integer AutoselAddress;
        time erase_start;

        task SetInd;
        begin
            if(~ASynchroMod)
               if (BrAddrSt%32 == 0 && Address%32 == 31) 
                  IND_zd = 0;
               else if (Address == BrAddrSt - 1)
                  IND_zd = 0;
               else
                  IND_zd = 1;
        end 
        endtask
        
        task DriveOut;
        begin
            if (Mem[SA*SecSize + Address]==-1) 
                DOut_zd[15:0] = 16'bx;
            else
                DOut_zd[15:0] = Mem[SA*SecSize + Address];
            SetInd;
         end
       endtask

       task Read_AS;
       begin
           AutoselAddress = Address % 12'h100;
           if (AutoselAddress == 0)
               DOut_zd = 1'b1;
           else if (AutoselAddress == 1)
               DOut_zd = 16'h2203;
           else if (AutoselAddress == 2)
               if (( (SA != BottomSec) &&
                   (~Sec_Prot[SA])) ||
                   ((SA == BottomSec) &&
                   (~Ssb_prot[SSA])))
                   // sector unlock
                   DOut_zd[15:0] = 16'h0000;
               else
                   // sector lock
                   DOut_zd[15:0] = 16'h0001;
           else if (AutoselAddress == 3) 
           begin
               if(ASynchroMod)
                   DOut_zd[15:0] = 16'h0000;
               else
                   DOut_zd[15:0] = 16'h0001;
           end
           else
               DOut_zd[15:0] = 16'bz;
       end
       endtask

       task Readmem_EraseSuspend;
       integer y;
       begin
            read_nosuspend_sect = 1'b1;
            if (SA != BottomSec) 
            begin
                if  (Ers_Queue[SA] && ~Sec_Prot[SA]) 
                    read_nosuspend_sect =1'b0;
            end 
            else
               if (Ers_SubBot_Queue[SSA]
               && ~Ssb_prot[SSA])   
                    read_nosuspend_sect = 1'b0;

            if (read_nosuspend_sect) 
            begin
                DriveOut;
            end
            else 
            begin
                if (~EntEmbaded)
                 begin   
                     Status[7] = 1'b1;
                     //Status[6] No toggle
                     Status[5] = 1'b0;
                     Status[2] = ~ Status[2]; //toggle
                     EntEmbaded = 1'b1;
                 end
                 DOut_zd[7 : 0] = Status;
                 DOut_zd[15 : 8] = 8'bz;
           end
        end
     endtask

     task Read_EraseStatus;
     begin
         Status[7] = 1'b0;
         Status[6] = ~ Status[6];
         Status[5] = 1'b0;
         Status[3] = 1'b1;
         if ($time - erase_start > 100000)
         begin
             if ((SA != BottomSec && Ers_Queue[SA] && ~Sec_Prot[SA]) ||
             (SA == BottomSec && Ers_SubBot_Queue[SSA] && ~Ssb_prot[SSA]))
                    Status[2] = ~ Status[2];
         end
         else
             if (SA != BottomSec && Ers_Queue[SA] || SA == BottomSec && 
             Ers_SubBot_Queue[SSA])
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
            RESET :
            begin
                if (~write)
                begin
                    if (PATTERN_1)     
                        next_state = Z001;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = CFI;
                    else
                        next_state = RESET;
                end
            end

            Z001 :
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
                        next_state = SET_MODE;
                    else if (A_PAT_1 && (DataLo==8'h80))
                        next_state = C8;
                    else
                        next_state = RESET;
                end
             end
             
            SET_MODE   :
            begin
                if (~write)
                begin
                   next_state = RESET; 
                end
            end

            PREL_ULBYPASS:
            begin
                if (~write)
                begin 
                    if (DataLo==8'h90) 
                        next_state = UNLOCK_RESET;
                    else if (DataLo==8'hA0) 
                        next_state = A0SEEN;
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
                      next_state = PGMS;
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
                        next_state = SERS;
                    else
                    begin
                        next_state = RESET;
                    end
                end
            end   
                 

            ERS :
            begin
            end

            SERS:
            begin
                if (~write)
                begin 
                   if (DataLo == 8'hB0 )
                    begin
                        if (ASynchroMod)
                            next_state = ESP; // ESP according to datasheet
                    end
                    else if (DataLo==8'h30)
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
            end

            SERS_EXEC :
            begin
            end

            ESPS:
            begin
            end

            ESP:
            begin
                if (~write) 
                    if (DataLo == 8'h30)
                        next_state = SERS_EXEC;
                    else
                        if (Addr == 8'h55 && DataLo == 8'h98) 
                            next_state = ESP_CFI;
                        else if (PATTERN_1) 
                            next_state = ESP_Z001;
            end

            ESP_ULBYPASS:
                if (~write)
                    if (DataLo==16'hA0) 
                        next_state = ESP_A0SEEN; 
                    else if (DataLo==16'h90)
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
            end

            ESP_A0SEEN:
            begin     
                if (~write) 
                    next_state = PGMS;
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

            PGMS :
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
                next_state = RESET;
            end
        end
    end

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

    always @(posedge ESTART_T1 or reseted)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (current_state==ESPS && ESTART_T1)
        begin
            next_state = ESP;
        end
    end

    always @(negedge write or reseted)
    begin: StateGen8
        if (reseted!=1'b1)
            next_state = current_state;
        else  
        begin
        if (current_state==SERS_EXEC && write==1'b0 && EERR!=1'b1)
                if (DataLo==8'hB0 && ASynchroMod)
                        next_state = ESPS;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // Burst block - task
    ///////////////////////////////////////////////////////////////////////////
    //Burst Address
    always@ (negedge CENeg or negedge OENeg)
    begin
          if (ASynchroMod)
              EntEmbaded = 1'b0;
    end

    always@ (negedge LBANeg)
    begin
          if (~ASynchroMod)
              EntEmbaded = 1'b0;
    end

    event End_burst_event;
    reg   erase_active = 1'b0;
    reg   BrEmbaded;
    reg   erase_suspend = 1'b0;

    task INIT_BURST;
    begin
        
        BrEmbaded  = 1'b0;
        BrAddrSt   = Address;
        WrapCnt     = 32 - AddressLatch[4:0];
        WrapMode    = 32;
        BurstEnable = 1'b0;
        BurstEnable <= #(ADDRDQ_01) 1'b1;
    end
    endtask

    task SET_BURST_PARAMETER;
    begin
    if (CLK && BurstEnable && ~BAANeg) //posedge CLK
        begin
            WrapCnt = WrapCnt - 1;
            if (WrapCnt > 0) //wrap mode
            begin
                Address = Address +1;
            end
            else if(WrapCnt == 0) // wrap turnround
            begin
                WrapCnt   = WrapMode;
                Address = Address - WrapMode +1;
            end
        end
        if (EntEmbaded)
                 -> End_burst_event;
        if (read)
            ->oe_event;
   end
   endtask

    ///////////////////////////////////////////////////////////////////////////
    //Burst mode state
    ///////////////////////////////////////////////////////////////////////////
    event start_burst_event;
    reg burst_start_flag = 1'b0;

    always@ (posedge CLK)
    begin
       if (~ASynchroMod && CLK && ~LBANeg && ~burst_start_flag &&
       ~CENeg && WENeg)
       begin
          -> start_burst_event;
          burst_start_flag = 1'b1;
       end
       else
          if (ReadBurst_state == BURST_READ)
            SET_BURST_PARAMETER;
    end

    always@ (posedge LBANeg)
    begin
        burst_start_flag = 1'b0;
    end

    always@ (start_burst_event)
    begin : BurstStart
        begin
            Start_burst = 1'b1;
            Start_burst = #1 1'b0;
        end
    end

    always@ (posedge gCE_n, gWE_n, reseted)
    begin : BurstDeactive
        if (gCE_n || ~reseted || ~gWE_n)
        begin
            End_burst = 1'b1;
            End_burst = #1 1'b0;
        end
    end

    always@ (Start_burst)
    begin : BurstControlActive
        if (Start_burst && reseted)
        begin 
            ReadBurst_state = BURST_READ;
            INIT_BURST;
            SET_BURST_PARAMETER;
        end
    end

    always@ (End_burst_event)   
    begin : EndBurstembedded
         End_burst = 1'b1;
         End_burst = #1 1'b0;
    end

    always@ (End_burst, reseted)
    begin : BurstControlIdle
        if (End_burst || ~reseted)
        begin
            ReadBurst_state = IDLE_BURST_READ;
            if (gCE_n==1'b1 || CENeg==1'b1 || ~reseted || ~gWE_n)
                RY_tmp = 1'bZ;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////
    always @(posedge read)
    begin
         ->oe_event;
    end

    always @(AddressLatch)
    begin
         if(read && ASynchroMod)
            ->oe_event;
    end

    integer y; 
    integer tmp;
    always @(oe_event)
    begin
        if (reseted)
        begin  
        case (current_state)
            RESET :
            begin
               DriveOut;
            end

            CFI, AS_CFI, ESP_CFI, ESP_AS_CFI :
            begin
                if (ASynchroMod || (~ASynchroMod && ~EntEmbaded))
                begin
                    CFI_data = 16'bZ;
                    if ((AddressLatch>=8'h10 && AddressLatch <=8'h3C ) || 
                        (AddressLatch>=8'h40 && AddressLatch <= 8'h4C))
                         CFI_data[15:0] = CFI_array[AddressLatch];
                    else
                        $display ("Invalid CFI query address");
                    EntEmbaded = 1'b1;
                end
                DOut_zd = CFI_data;
            end

            AS : 
            begin
               if (ASynchroMod || (~ASynchroMod && ~EntEmbaded))
               begin
                   Read_AS;
                   EntEmbaded = 1'b1;
               end    
            end

            ERS :
            begin
                if (~EntEmbaded)
                begin
                    Read_EraseStatus;
                    EntEmbaded = 1'b1;
                end
                DOut_zd[7:0] = Status;
                DOut_zd[15 : 8] = 8'bz;
            end

            SERS :
            begin
                ///////////////////////////////////////////////////////////
                //read status - sector erase timeout
                ///////////////////////////////////////////////////////////
                if (~EntEmbaded)
                begin
                    Status[3] = 1'b0;
                    EntEmbaded = 1'b1;
                end
                DOut_zd[7:0] = Status;
                DOut_zd[15 : 8] = 8'bz;
            end

            ESPS :
            begin
                   ///////////////////////////////////////////////////////////
                   //read status / erase suspend timeout - stil erasing
                   ///////////////////////////////////////////////////////////
                  if (~EntEmbaded)
                  begin
                      Read_EraseStatus;
                      EntEmbaded = 1'b1;
                  end
                  DOut_zd[7:0] = Status;
                  DOut_zd[15 : 8] = 8'bz; 
            end

            SERS_EXEC:
            begin
                 if (~EntEmbaded)
                 begin
                     Read_EraseStatus;
                     EntEmbaded = 1'b1;
                 end
                 DOut_zd[7:0] = Status;
                 DOut_zd[15 : 8] = 8'bz;
            end

            ESP :
            begin
                Readmem_EraseSuspend;
            end 

            ESP_ULBYPASS:
            begin
            end
          
            ESP_AS : 
            begin
                if (ASynchroMod || (~ASynchroMod && ~EntEmbaded))
                begin
                    Read_AS;
                    EntEmbaded = 1'b1;
                end    
            end

           PGMS :
           begin
                if (~EntEmbaded)
                begin 
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        //Status(2) no toggle
                        Status[1] = 1'b0;
                        EntEmbaded = 1'b1;
                end
                DOut_zd[7:0] = Status;
                DOut_zd[15:8] = 8'bz;
            end 
     endcase
    end
 end
//*******************************************

    always @(write or reseted)
    begin : Output_generation
        if (~reseted)
        begin
            ERS_ACT   = 1'b0;
            ULBYPASS  = 1'b0;
            Ers_Queue = 0;
            Ers_SubBot_Queue = 0;
            ASynchroMod = 1;
         end 
         
        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                ERS_ACT   = 1'b0;
                ULBYPASS  = 1'b0;
                Ers_Queue = 0;
                Ers_SubBot_Queue = 0;
                if (~write)
                begin  
                end 
            end
              
            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
            end
            
            SET_MODE :
            begin
                if (~write)
                    if (DataLo % 2 == 0) 
                        ASynchroMod = 1;
                    else
                        ASynchroMod = 0;
            end

            PREL_ULBYPASS :
            begin
                ULBYPASS = 1'b1;
            end


            CFI, AS_CFI, ESP_CFI, ESP_AS_CFI  :
            begin
            end   
            
            AS :
            begin
            end

            UNLOCK_RESET, ESP_UNLOCK_RESET:
            begin   
                if (~write) 
                    if (DataLo==16'h00)
                    begin
                        ULBYPASS = 1'b0;
                    end
             end

            A0SEEN , ESP_A0SEEN:
            begin      
            if (~write) 
                    if (
                        ((SA != BottomSec) && ~Sec_Prot[SA]) ||
                        ((SA == BottomSec) && ~Ssb_prot[SSA])
                        )
                    begin
                        WRData  = Data;
                        WRSA = SA;
                        WRAddress = Address;
                        Mem_tmp = Mem[WRSA*SecSize + WRAddress]; 
                        Mem[WRSA*SecSize + WRAddress] = -1;
                        Status[7] = ~ DataLo[7];
                        PSTART = 1'b1; //////////////////////!
                        PSTART <= #1 1'b0;
                    end
                    else
                    begin
                        Status[7] = ~ DataLo[7];
                        PSTART = 1'b1; 
                        PSTART = #1 1'b0;
                    end
            end

            C8:
            begin
            end

            C8_Z001 :
            begin
            end

            C8_PREL :
            begin
                if (~write)
                    if (A_PAT_1 && DataLo == 16'h10)
                    //Start Chip Erase
                    begin
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_Queue = ~(0);
                        Ers_SubBot_Queue = ~(0);
                        Status = 8'b00001000;
                        ESTART = 1'b1;
                        ESTART = #1 1'b0;
                        ERS_ACT = 1'b1;
                        erase_start = $time;
                    end
                else if (DataLo==16'h30)
                begin  
                    //put selected sector to sec. ers. queue
                    //start timeout
                    ERS_ACT = 1'b1; 
                    Ers_Queue = 0;
                    Ers_SubBot_Queue = 0;
                    CTMOUT_in = 1'b1;
                    if (SA == BottomSec) 
                        Ers_SubBot_Queue[SSA] = 1'b1;
                    else
                        Ers_Queue[SA] = 1'b1;
                end
            end 

            ERS :
            begin
            end

            SERS :
            begin
            if (~write)
                if (DataLo == 16'hB0)
                begin
                    //need to start erase process prior to suspend
                     if (ASynchroMod)    
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
                    if (SA == BottomSec) 
                        Ers_SubBot_Queue[SSA] = 1'b1;
                    else
                         Ers_Queue[SA] = 1'b1;

                    CTMOUT_in = 1'b0; 
                    CTMOUT_in = #2 1'b1;
                end
                else
                begin
                    CTMOUT_in  = 1'b0;
                    Ers_Queue = 0;
                    Ers_SubBot_Queue = 0;
                end
            end

            SERS_EXEC :
            begin
                if (~write) 
                    if (DataLo==8'hB0 && ASynchroMod)
                    begin
                        ESTART_T1_in = 1'b1;
                        ESUSP = 1'b1;
                        ESUSP = #1 1'b0;
                    end
            end

            ESP :
            begin
                if (~write) 
                    if (DataLo==16'h30) 
                    begin
                        ERES = 1'b1;
                        ERES = #1 1'b0;
                    end
            end

            ESP_ULBYPASS:
            begin
                ULBYPASS = 1'b1;
            end

            ESP_Z001 :
            begin
            end

            ESP_PREL :
            begin
            end

            ESP_AS :
            begin
            end

            PGMS :
            begin
            end

        endcase
        end
    end
    
//****************************** 
    always @(EERR or EDONE or current_state)
    begin : ERS2
    integer i;
    integer j;
    integer mem_ind;
    if (current_state==ERS)
    begin
        if (EERR!=1'b1)
        begin
            for (i=1;i<=SecNum-1;i=i+1)
                if  (~Sec_Prot[i])
                begin
                     mem_ind = i*SecSize;
                     for (y=0;y<=SecSize -1 ;y=y+1)
                     begin
                         Mem[mem_ind + y] = -1;
                     end
                end
                for (y=0;y<=SubSecNum-1;y=y+1)
                    if (~Ssb_prot[y] )
                         for (k=sssa[y];k<=ssea[y];k=k+1)
                             Mem[BottomSec*SecSize + k]=-1;

            if (EDONE)
            begin
                for (i=1;i<=SecNum-1;i=i+1)
                   if  (~Sec_Prot[i])
                   begin
                       mem_ind = i*SecSize;
                       for (y=0;y<=SecSize -1 ;y=y+1)
                       begin
                            Mem[mem_ind + y] = MaxData;
                       end
                   end
                   for (y=0;y<=SubSecNum-1;y=y+1)
                      if (~Ssb_prot[y] )
                           for (k=sssa[y];k<=ssea[y];k=k+1)
                               Mem[BottomSec*SecSize + k]= MaxData;
             end
         end
    end
    end

    always @(CTMOUT or current_state)
    begin : SERS2    
        if (current_state==SERS)
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                ESTART_T1_in = 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                erase_start = $time;
                ESTART = 1'b1;
                ESTART = #1 1'b0;
            end
    end

    always @(ESTART_T1 or current_state)
    begin : ESPS2
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
            for (i=1;i<=SecNum-1;i=i+1)
                if  (~Sec_Prot[i] && Ers_Queue[i])
                begin
                     mem_ind = i*SecSize;   
                     for (y=0;y<=SecSize -1 ;y=y+1)
                         Mem[mem_ind + y] = -1;
                end
            for (y=0;y<=SubSecNum-1;y=y+1)
                if (~Ssb_prot[y] && Ers_SubBot_Queue[y] )
                     for (k=sssa[y];k<=ssea[y];k=k+1)
                         Mem[BottomSec*SecSize + k]=-1;

            if (EDONE)
            begin
                for (i=1;i<=SecNum-1;i=i+1)
                    if  (~Sec_Prot[i]&& Ers_Queue[i])
                    begin
                         mem_ind = i*SecSize;  
                         for (y=0;y<=SecSize -1 ;y=y+1)
                         begin
                             Mem[mem_ind + y] = MaxData;
                         end
                    end
                    for (y=0;y<=SubSecNum-1;y=y+1)
                        if (~Ssb_prot[y] && Ers_SubBot_Queue[y])
                             for (k=sssa[y];k<=ssea[y];k=k+1)
                                 Mem[BottomSec*SecSize + k]= MaxData;
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
                if ((Mem_tmp != -1) && (WRData != -1)) 
                    begin
                        Mem[WRSA*SecSize+WRAddress] = WRData & Mem_tmp;
                    end
                else
                begin
                    Mem[WRSA*SecSize+WRAddress] = WRData;
                end 
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

    always @(gOE_n or gCE_n or RESETNeg or RST)
    begin
        //Output Disable Control
        IND_zd = 1'b1;
    end

   always @(current_state or reseted)
     begin
         if (reseted)
         begin
             if (current_state==RESET)               RY_zd = 1'b1;
             else if (current_state==ERS)            RY_zd = 1'b0;
             else if (current_state==SERS)           RY_zd = 1'b1;
             else if (current_state==ESPS)           RY_zd = 1'b0;
             else if (current_state==SERS_EXEC)      RY_zd = 1'b0;
             else if (current_state==ESP)            RY_zd = 1'b1;
             else if (current_state==PREL_ULBYPASS)  RY_zd = 1'b1;
             else if (current_state==ESP_ULBYPASS)   RY_zd = 1'b1;
             else if (current_state==PGMS)           RY_zd = 1'b0;
             else RY_zd = 1'b1;
         end
     end

    initial
    begin
        ///////////////////////////////////////////////////////////////////////
        //CFI array data
        ///////////////////////////////////////////////////////////////////////
            //CFI query identification string
            for (i=8'h10; i<8'h4C ;i=i+1)
                 CFI_array[i] = -1;

            CFI_array[8'h10]  = 16'h0051;
            CFI_array[8'h11]  = 16'h0052;
            CFI_array[8'h12]  = 16'h0059;
            CFI_array[8'h13]  = 16'h0002;
            CFI_array[8'h14]  = 16'h0000;
            CFI_array[8'h15]  = 16'h0040;
            CFI_array[8'h16]  = 16'h0000;
            CFI_array[8'h17]  = 16'h0000;
            CFI_array[8'h18]  = 16'h0000;
            CFI_array[8'h19]  = 16'h0000;
            CFI_array[8'h1A]  = 16'h0000;
            CFI_array[8'h1B]  = 16'h0027;
            CFI_array[8'h1C]  = 16'h0036;
            CFI_array[8'h1D]  = 16'h0000;
            CFI_array[8'h1E]  = 16'h0000;
            CFI_array[8'h1F]  = 16'h0004;
            CFI_array[8'h20]  = 16'h0000;
            CFI_array[8'h21]  = 16'h000A;
            CFI_array[8'h22]  = 16'h0000;
            CFI_array[8'h23]  = 16'h0005;
            CFI_array[8'h24]  = 16'h0000;
            CFI_array[8'h25]  = 16'h0004;
            CFI_array[8'h26]  = 16'h0000;
            CFI_array[8'h27]  = 16'h0015;
            CFI_array[8'h28]  = 16'h0001;
            CFI_array[8'h29]  = 16'h0000;
            CFI_array[8'h2A]  = 16'h0000;
            CFI_array[8'h2B]  = 16'h0000;
            CFI_array[8'h2C]  = 16'h0004;
            CFI_array[8'h2D]  = 16'h0000;
            CFI_array[8'h2E]  = 16'h0000;
            CFI_array[8'h2F]  = 16'h0040;
            CFI_array[8'h30]  = 16'h0000;
            CFI_array[8'h31]  = 16'h0001;
            CFI_array[8'h32]  = 16'h0000;
            CFI_array[8'h33]  = 16'h0020;
            CFI_array[8'h34]  = 16'h0000;
            CFI_array[8'h35]  = 16'h0000;
            CFI_array[8'h36]  = 16'h0000;
            CFI_array[8'h37]  = 16'h0080;
            CFI_array[8'h38]  = 16'h0003;
            CFI_array[8'h39]  = 16'h0006;
            CFI_array[8'h3A]  = 16'h0000;
            CFI_array[8'h3B]  = 16'h0000;
            CFI_array[8'h3C]  = 16'h0004;
            CFI_array[8'h40]  = 16'h0050;
            CFI_array[8'h41]  = 16'h0052;
            CFI_array[8'h42]  = 16'h0049;
            CFI_array[8'h43]  = 16'h0031;
            CFI_array[8'h44]  = 16'h0030;
            CFI_array[8'h45]  = 16'h0000;
            CFI_array[8'h46]  = 16'h0002;
            CFI_array[8'h47]  = 16'h0001;
            CFI_array[8'h48]  = 16'h0001;
            CFI_array[8'h49]  = 16'h0004;
            CFI_array[8'h4A]  = 16'h0000;
            CFI_array[8'h4B]  = 16'h0003;
            CFI_array[8'h4C]  = 16'h0000;
   end

   reg  BuffIn1, BuffIn2, BuffIn3, BuffIn4, BuffIn5, BuffIn6, BuffIn7,
        BuffIn8;
   wire BuffOut1,BuffOut2,BuffOut3,BuffOut4,BuffOut5,BuffOut6,BuffOut7,
        BuffOut8;

   reg  BuffInOE, BuffInCE, BuffInADDR, BuffInCLK, BuffInRESETDQ;
   wire BuffOutOE, BuffOutCE, BuffOutADDR, BuffOutCLK, BuffOutRESETDQ;

   VITALBuf    BUFOENeg   (BuffOutOE, BuffInOE);
   VITALBuf    BUFCENeg   (BuffOutCE, BuffInCE);
   VITALBuf    BUFA       (BuffOutADDR, BuffInADDR);
   VITALBuf    BUFCLK     (BuffOutCLK, BuffInCLK);
   VITALBuf    BUFRESETDQ (BuffOutRESETDQ, BuffInRESETDQ);

   initial
    begin
        BuffInOE   = 1'b1;
        BuffInCE   = 1'b1;
        BuffInADDR = 1'b1;
        BuffInCLK  = 1'b1;
        BuffInRESETDQ= 1'b1;
    end

    time CEDQ_t, OEDQ_t, ADDRDQ_t, CLKDQ_t, open_buf_t;
    time CENeg_event, OENeg_event, ADDR_event, LatchAddr_event, CLK_event = 0;
    wire CE_en;
    reg  [15:0] TempData;
    reg  [15:0] CeData;
    reg  [15:0] AddrData;
    reg  from_address;
    wire  ADR_en;
    event fromAddr_event, fromCeClk_event, fromCeOe_event;
    time OENeg_posEvent=0;
    time CENeg_posEvent=0;
    event addr_wait, ce_wait;

    always @(posedge BuffOutOE)
    begin
        OEDQ_01 = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CEDQ_01 = $time;
    end
    always @(BuffOutADDR)
    begin
        ADDRDQ_01 = $time;
    end
    always @(BuffOutCLK)
    begin
        CLKDQ_01 = $time;
    end
    always @(BuffOutRESETDQ)
    begin
        RESETDQ  = $time;
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

   always @(A)
   begin
        ADDR_event = $time;
   end

   always @(posedge CLK)
   begin
        if (~LBANeg)
            LatchAddr_event = $time;
   end

    always @(DOut_zd)
    begin : OutputGen
        time  time_t;
        if (DOut_zd[0] !== 1'bz)
        begin
            if (ASynchroMod)
            begin
                close_buffer = 1'b0;
                CEDQ_t = CENeg_event  + CEDQ_01;
                OEDQ_t = OENeg_event  + OEDQ_01;
                ADDRDQ_t = ADDR_event + ADDRDQ_01;
                FROMADDR =((ADDRDQ_t >= CEDQ_t) && (ADDRDQ_t >= OEDQ_t) &&
                ( ADDRDQ_t > $time));
                FROMCE = ((CEDQ_t >= OEDQ_t) && (CEDQ_t >= $time));
                FROMOE = ((OEDQ_t > CEDQ_t) && (OEDQ_t >= $time));
                
                DOut_pass[15:0] = 16'hz; 
                if(FROMCE && ~FROMOE && ~FROMADDR)
                begin
                   #(CEDQ_t - $time);
                end
                if( FROMADDR&& (FROMOE || FROMCE))
                begin
                    FROMADDR = 1'b0;
                    if (from_address == 1'b0) 
                    begin
                       DOut_pass[15:0] = 16'hx;
                       #(ADDRDQ_t - $time);
                    end
                       
                    from_address = 1'b1;    
                end
                DOut_pass[15:0] = DOut_zd[15:0];
           end 
           else
           begin
                ADDRDQ_t = LatchAddr_event + ADDRDQ_01;
                OEDQ_t   = OENeg_event  + OEDQ_01;
                time_t = (OEDQ_01+ OENeg_event - CLK_event);
                FROMOE = 1'b1;
                if (ADDRDQ_t > $time)
                begin
                    ClkAddr_tmp = 1'b0;
                    if (first_b == 1'b0)
                    begin
                          DOut_pass[15:0] = 16'hz;
                    end
                    #(ADDRDQ_t - $time);
                end
                else if ( time_t > 0 && time_t <= OEDQ_01 && OEDQ_t >= $time)
                    #(time_t);
                first_b = 1'b1;
                DOut_pass[15:0] = DOut_zd[15:0];
                #0.1 ClkAddr_tmp = 1'b1;
                
          end
       end
   end

   always @(negedge CENeg)
   begin
       first_b = 1'b0;
   end
   
   always @(gCE_n, gOE_n)
   begin
       if(gCE_n == 1'b1 || gOE_n == 1'b1)
           from_address = 1'b0;
   end

   always @(DOut_zd)
   begin
       if (DOut_zd[0] === 1'bz)
       begin
           disable OutputGen;
           FROMCE = 1'b0;
           FROMOE = 1'b0;     
           FROMCLK = 1'b0;
           FROMADDR = 1'b0;
           close_buffer = 1'b1;
           DOut_pass <= #(RESETDQ-5) DOut_zd;
       end
   end

   time ADDRIND_t;
   time OEIND_t;
   always @(IND_zd)
   begin : INDGen
       time  time_t;
       if (~IND_zd )
       begin
           ADDRIND_t = LatchAddr_event + ADDRDQ_01;
           OEIND_t   = OENeg_event  + OEDQ_01;
           time_t = (OEDQ_01+ OENeg_event - CLK_event);
           IND_pass = IND_zd;
       end
       else
           if (OENeg || CENeg)
               IND_pass <= #(RESETDQ-5) IND_zd;
           else
               IND_pass = IND_zd;
    end

 endmodule

 module VITALBuf ( OUT,IN);
   input IN;
   output OUT;
   buf   ( OUT, IN);
 endmodule
