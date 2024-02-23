
//////////////////////////////////////////////////////////////////////////////
//  File name : s29ws032j.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004, Spansion, LCC.
//
//  MODIFICATION HISTORY :
//
//   version: | author:    |   mod date:  | changes made:
//     V1.0    D.Komaromi      04 Aug 25    Initial
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           s29ws032j
//
//  Description:   32 Mbit(2M x 16-Bit) Burst Mode,
//                 Simultanous Read/Write Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module s29ws032j
(
    A20      ,
    A19      ,
    A18      ,
    A17      ,
    A16      ,
    A15      ,
    A14      ,
    A13      ,
    A12      ,
    A11      ,
    A10      ,
    A9       ,
    A8       ,
    A7       ,
    A6       ,
    A5       ,
    A4       ,
    A3       ,
    A2       ,
    A1       ,
    A0       ,

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
    OENeg    ,
    WENeg    ,
    RDY      ,
    CLK      ,
    AVDNeg   ,
    RESETNeg ,
    WPNeg    ,
    ACC
);

    input  A20  ;
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
    input  OENeg    ;
    input  WENeg    ;
    input  CLK      ;
    input  AVDNeg   ;
    input  RESETNeg ;
    input  WPNeg    ;
    input  ACC      ;
    output RDY      ;

// interconnect path delay signals

    wire  A20_ipd  ;
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

    wire [20 : 0] A;
    assign A = {
                A20_ipd,
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
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  CLK_ipd      ;
    wire  AVDNeg_ipd   ;
    wire  RESETNeg_ipd ;
    wire  WPNeg_ipd    ;
    wire  ACC_ipd      ;

//  internal delays

    reg HANG_out    ; // Program/Erase Timing Limit
    reg HANG_in     ;
    reg START_out   ; // Start TimeOut
    reg START_in    ;
    reg CTMOUTP_out ; // Sector Erase TimeOut
    reg CTMOUTP_in  ;
    reg READY_out   ;
    reg READY_in    ; // Device ready after reset
    reg TIACC_out   ;
    reg TIACC_in    ; // Initial Access

    reg [15 : 0] DOut_zd;

    wire  DQ15_Pass  ;
    wire  DQ14_Pass  ;
    wire  DQ13_Pass  ;
    wire  DQ12_Pass  ;
    wire  DQ11_Pass  ;
    wire  DQ10_Pass  ;
    wire  DQ9_Pass   ;
    wire  DQ8_Pass   ;
    wire  DQ7_Pass   ;
    wire  DQ6_Pass   ;
    wire  DQ5_Pass   ;
    wire  DQ4_Pass   ;
    wire  DQ3_Pass   ;
    wire  DQ2_Pass   ;
    wire  DQ1_Pass   ;
    wire  DQ0_Pass   ;

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

    parameter mem_file_name   = "none";
    parameter UserPreload     = 1'b0;
    parameter LongTiming = 1;
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID    = "S29WS032J";
    parameter HiAddrBit = 20;
    parameter MaxData   = 16'hFFFF;
    parameter sizeB     = 20'h7FFF;
    parameter sizeS     = 20'h1FFF;
    parameter SecNum    = 69;
    parameter BankNum   = 4;
    parameter MaxLoc    = 21'h1FFFFF;

    parameter ASYNCR             = 4'd0;
    parameter SYNCR              = 4'd1;
    parameter CONTINUOUS          = 4'd2;
    parameter LINEAR             = 4'd3;

    reg [2:0] READ_MODE;

    // powerup
    reg PoweredUp;
    reg SYNCH;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ESP_ACT  ; ////Erase Suspend
    reg AS_ACT   ; ////Autoselect Mode Active

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
    reg [SecNum:0] ERS_QUEUE; // = SecNum'b0;

    //Parameters of bank specific operations
    integer   BankAS =-1;
    integer   BankPRG =-1;
    reg[3:0]  BankERS;

    reg CLK_out;
    reg RDY_sync;

    //Command Register
    reg READ        = 1'b0;
    reg burst_rd    = 1'b0;
    reg WRITE       = 1'b1;
    reg ReadINIT    = 1'b1;
    reg OE_burst    = 1'b1;

    reg BURST_TR;
    reg SYNCREAD;

    integer D_tmp; //0 TO MaxData;
    integer DataLo;

    //Sector Address
    integer SB      = -1;         // 0 TO BankNum
    integer SA      = -1;         // 0 TO SecNum
    integer Addr    = -1;
    integer AddrCom = -1;
    integer AddrCFI = -1;
    reg Lock = 1'b1;

    reg RST ;
    reg reseted ;
    reg CLK_PATH_EN;

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    //Main Flash
    integer Mem[0:MaxLoc];
    //Sector Protection Status
    reg [SecNum:0] Prot;

    reg[19:0] CFR;

    integer CFI_Vect[8'h10:8'h5B];

    // timing check violation
    reg Viol = 1'b0;

    // StateTransition values
    reg R;
    reg E;
    //Bus Cycle Decode
    reg RD;
    reg WR;
    reg LATCHED;
    reg[HiAddrBit:0] A_tmp;
    //Functional
    integer WrData  = -1;
    integer WrAddr  = -1;
    integer WrSec   = -1;

    //Command Sequence detection
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_CFI  = 1'b0;
    reg A_PAT_1  = 1'b0;
    reg oe = 1'b0;
    //Status reg.
    reg[15:0] Status = 16'b0;
    reg[15:0]  old_bit, new_bit;
    integer old_int, new_int;

    reg[15:0] DOut_temp;
    reg[7:0] temp;

    reg[15:0] ReadData;
    reg[20:0] Atmp;
    integer secLU;

    //Burst Params
    integer AddrHi;
    integer AddrLow;
    integer BurstAddr;
    integer BurstSect;
    integer BurstBorder;
    reg BusyBOUND;
    reg[15:0] CrossData;
    integer CrossBank;
    integer CrossSec;
    //Burst latency values
    integer BusyDelay;
    integer BoundDelay;
    integer InitDelay;
    reg LATCHED_3E_3F;
    reg ODDADDR;
    reg ODDNEXT;
    reg stall_a;
    reg busy_stat;
    reg inc_a;
    reg cnt;
    reg stall;
    reg noout;
    reg[20:0] tmp;

    reg[15:0] DataOut;
    reg[15:0] SyncData;

    integer i,j,k;
   //TPD_XX_DATA
   time OEDQ_t;
   time CEDQ_t;
   time ADDRDQ_t;
   time OENeg_event;
   time CENeg_event;
   time ADDR_event;
   reg FROMOE;
   reg FROMCE;
   reg[15:0] TempData;

   event oe_event;

   integer   OEDQ_01;
   integer   OEDQ_02;
   integer   CEDQ_01;
   integer   CEDQ_02;
   integer   ADDRDQ_01;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
    buf   (A20_ipd, A20);
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
    buf   (OENeg_ipd    , OENeg    );
    buf   (WENeg_ipd    , WENeg    );
    buf   (CLK_ipd      , CLK      );
    buf   (AVDNeg_ipd   , AVDNeg   );
    buf   (RESETNeg_ipd , RESETNeg );
    buf   (WPNeg_ipd    , WPNeg    );
    buf   (ACC_ipd      , ACC      );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ15,   DQ15_Pass , 1);
    nmos   (DQ14,   DQ14_Pass , 1);
    nmos   (DQ13,   DQ13_Pass , 1);
    nmos   (DQ12,   DQ12_Pass , 1);
    nmos   (DQ11,   DQ11_Pass , 1);
    nmos   (DQ10,   DQ10_Pass , 1);
    nmos   (DQ9 ,   DQ9_Pass  , 1);
    nmos   (DQ8 ,   DQ8_Pass  , 1);
    nmos   (DQ7 ,   DQ7_Pass  , 1);
    nmos   (DQ6 ,   DQ6_Pass  , 1);
    nmos   (DQ5 ,   DQ5_Pass  , 1);
    nmos   (DQ4 ,   DQ4_Pass  , 1);
    nmos   (DQ3 ,   DQ3_Pass  , 1);
    nmos   (DQ2 ,   DQ2_Pass  , 1);
    nmos   (DQ1 ,   DQ1_Pass  , 1);
    nmos   (DQ0 ,   DQ0_Pass  , 1);

    nmos   (RDY ,   RDY_zd     , 1);
    wire deg;

    //VHDL VITAL CheckEnable equivalents

 wire A_CLKP_CHECK;
 assign A_CLKP_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b1
        && ~CENeg && WENeg && ~AVDNeg;
 wire A_CLKN_CHECK;
 assign A_CLKN_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b0
        && ~CENeg && WENeg && ~AVDNeg;
 wire CENeg_CLKP_CHECK;
 assign CENeg_CLKP_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b1 && ~CENeg;
 wire CENeg_CLKN_CHECK;
 assign CENeg_CLKN_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b0&& ~CENeg;
 wire AVDNeg_CLKP_CHECK;
 assign AVDNeg_CLKP_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b1
        && ~CENeg && WENeg && AVDNeg===1'b0;
 wire AVDNeg_CLKN_CHECK;
 assign AVDNeg_CLKN_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b0
        && ~CENeg && WENeg && AVDNeg===1'b0;
 wire DQ_WENeg_CHECK;
 assign DQ_WENeg_CHECK = ~CENeg && AVDNeg;
 wire DQ_CENeg_CHECK;
 assign DQ_CENeg_CHECK = CFR[19] === 1'b1 && ~WENeg && AVDNeg;
 wire AVDNeg_WENeg_CHECK;
 assign AVDNeg_WENeg_CHECK = ~CENeg;
 wire CLKP_WENeg_CHECK;
 assign CLKP_WENeg_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b1 && ~AVDNeg;
 wire CLKN_WENeg_CHECK;
 assign CLKN_WENeg_CHECK = CFR[19] === 1'b0 && CFR[17] === 1'b0 && ~AVDNeg;
 wire A_CENeg_CHECK;
 assign A_CENeg_CHECK = CFR[19] === 1'b1 && ~AVDNeg && ~WENeg;
 wire ASYN_A_WENeg_CHECK;
 assign ASYN_A_WENeg_CHECK = CFR[19] === 1'b1 && ~CENeg && ~AVDNeg;
 wire SYN_A_WENeg_CHECK;
 assign SYN_A_WENeg_CHECK = CFR[19] === 1'b0 && ~CENeg && ~AVDNeg;
 wire ASYN_A_AVDNeg_CHECK;
 assign ASYN_A_AVDNeg_CHECK = CFR[19] === 1'b1 && ~CENeg && WENeg;
 wire SYN_A_AVDNeg_CHECK;
 assign SYN_A_AVDNeg_CHECK = CFR[19] === 1'b0 && ~CENeg && WENeg;
 wire OENeg_WENeg_CHECK;
 assign OENeg_WENeg_CHECK = PDONE === 1'b0 || EDONE === 1'b0;
 wire CLK_PATH_ENABLE;
 assign CLK_PATH_ENABLE = CLK_PATH_EN && CFR[19] === 1'b0;
 wire CLK_HI_CHK;
 assign CLK_HI_CHK = ~CENeg && ~CFR[19] && CFR[17]
        && (READ_MODE == CONTINUOUS || READ_MODE == LINEAR) ;
 wire CLK_LO_CHK;
 assign CLK_LO_CHK = ~CENeg && ~CFR[19] && ~CFR[17]
       && (READ_MODE == CONTINUOUS || READ_MODE == LINEAR);

reg temp19 = CFR[19];
reg temp17 = CFR[17];
reg temp18 = CFR[18];

specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file
    // tpd delays

    specparam           tpd_RESETNeg_DQ0         =1;//
    specparam           tpd_A0_DQ0               =1;//tACC
    specparam           tpd_CENeg_DQ0 =1;//
     //(tCE,tCE,tCEZ,-tCEZ-) asynchronous mode
    specparam           tpd_OENeg_DQ0 =1;//
    specparam           tpd_OENeg_DQ1 =1;//
     //(tOE,tOE,tOEZ,-tOEZ-)
    specparam           tpd_CENeg_RDY            =1;//;
     //(-,-,tCEZ,-,tCEZ,tCR)
    specparam           tpd_CLK_RDY              =1;//tRACC
    specparam           tpd_CLK_DQ0              =1;//tBACC

    // tsetup values: setup time
    specparam           tsetup_A0_CLK            =1;//tACS
    specparam           tsetup_CENeg_CLK         =1;//tCES
    specparam           tsetup_CENeg_AVDNeg      =1;//tCAS edge\
    specparam           tsetup_AVDNeg_CLK        =1;//tAVC
    specparam           tsetup_DQ0_CENeg         =1;//tDS edge /
    specparam           tsetup_DQ0_WENeg         =1;//tDS edge /
    specparam           tsetup_CENeg_WENeg       =1;//tCS edge \
    specparam           tsetup_WENeg_CENeg       =1;//tCS edge \
    specparam           tsetup_AVDNeg_WENeg      =1;//tAVSW edge \
    specparam           tsetup_CLK_WENeg         =1;//tCS edge \
    specparam           tsetup_A0_CENeg          =1;//tAS edge/

    specparam           tsetup_A0_AVDNeg         =1;
    specparam           tsetup_A0_WENeg          =1;

   //thold values: hold times
    specparam           thold_A0_CLK            =1;//tACH
    specparam           thold_OENeg_WENeg       =1;//tOEH edge /
    specparam           thold_CENeg_RESETNeg    =1;//tRH  edge /
    specparam           thold_OENeg_RESETNeg    =1;//tRH  edge /
    specparam           thold_DQ0_CENeg         =1;//tDH edge /
    specparam           thold_DQ0_WENeg         =1;//tDH edge /
    specparam           thold_CENeg_WENeg       =1;//tCH edge /
    specparam           thold_WENeg_CENeg       =1;//tCH edge/
    specparam           thold_AVDNeg_CLK        =1;//tADHC
    specparam           thold_AVDNeg_WENeg      =1;//tADHC
    specparam           thold_A0_CENeg          =1;//tAH edge/

    specparam      thold_A0_AVDNeg              =1;//tAH edge/
    specparam      thold_A0_WENeg               =1;//tAH edge\

    specparam      thold_DQ0_CLK            =1;//tbdh
    specparam      tsetup_RDY_CLK           =1;//trdys

     // tpw values: pulse width
    specparam           tpw_RESETNeg_negedge     =1; //tRP
    specparam           tpw_WENeg_negedge        =1; //tWP
    specparam           tpw_WENeg_posedge        =1; //tWPH
    specparam           tpw_AVDNeg_negedge       =1; //tAVDP
    specparam           tpw_CLK_negedge          =1; //tCL
    specparam           tpw_CLK_posedge          =1; //tCH
    specparam           tpw_CENeg_negedge        =1; //tWP
    specparam           tpw_CENeg_posedge        =1; //tWPH

    // tperiod values: period
    specparam           tperiod_CLK              =1; //tCLK

    // tdevice values: values for internal delays
            //Program Operation
    specparam   tdevice_POW        = 6000; // 6 us
           //Sector Erase operation, big sector
    specparam     tdevice_SEO_b    = 400000000;// 0.4 sec
         //Sector Erase operation, small sector
    specparam     tdevice_SEO_s    = 200000000;// 0.2 sec
         //device ready after hardware reset(during embeded algorithm)
    specparam     tdevice_READYP   = 35000;// 35 us
         //sector erase command sequence timeout
    specparam     tdevice_CTMOUTP  = 50000; //50 us
         //program/erase suspend timeout
    specparam     tdevice_START    = 35000;// 35 us
         //initial acces delay tiacc
    specparam     tdevice_TIACC    = 70;
         //Timing Limit Exceeded
    specparam    tdevice_HANG     = 2000000000;//2 sec; //?

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
//for DQ signals
    if (FROMOE && ~temp18)
         ( OENeg *> DQ0 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ1 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ2 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ3 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ4 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ5 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ6 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ7 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ8 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ9 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ10 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ11 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ12 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ13 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ14 ) = tpd_OENeg_DQ0;
    if (FROMOE && ~temp18)
        ( OENeg *> DQ15 ) = tpd_OENeg_DQ0;

    if (FROMOE && temp18)
        ( OENeg *> DQ0 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ1 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ2 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ3 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ4 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ5 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ6 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ7 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ8 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ9 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ10 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ11 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ12 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ13 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ14 ) = tpd_OENeg_DQ1;
    if (FROMOE && temp18)
        ( OENeg *> DQ15 ) = tpd_OENeg_DQ1;

    if (FROMCE && ~temp18)
        ( CENeg *> DQ0 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ1 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ2 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ3 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ4 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ5 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ6 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ7 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ8 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ9 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ10 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ11 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ12 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ13 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ14 ) = tpd_CENeg_DQ0;
    if (FROMCE && ~temp18)
        ( CENeg *> DQ15 ) = tpd_CENeg_DQ0;

    if (FROMCE && temp18)
        ( CENeg *> DQ0 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ1 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ2 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ3 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ4 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ5 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ6 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ7 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ8 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ9 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ10 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ11 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ12 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ13 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ14 ) = tpd_CENeg_DQ0;
    if (FROMCE && temp18)
        ( CENeg *> DQ15 ) = tpd_CENeg_DQ0;

        ( A0 => DQ0 ) = tpd_A0_DQ0;
        ( A0 => DQ1 ) = tpd_A0_DQ0;
        ( A0 => DQ2 ) = tpd_A0_DQ0;
        ( A0 => DQ3 ) = tpd_A0_DQ0;
        ( A0 => DQ4 ) = tpd_A0_DQ0;
        ( A0 => DQ5 ) = tpd_A0_DQ0;
        ( A0 => DQ6 ) = tpd_A0_DQ0;
        ( A0 => DQ7 ) = tpd_A0_DQ0;
        ( A0 => DQ8 ) = tpd_A0_DQ0;
        ( A0 => DQ9 ) = tpd_A0_DQ0;
        ( A0 => DQ10 ) = tpd_A0_DQ0;
        ( A0 => DQ11 ) = tpd_A0_DQ0;
        ( A0 => DQ12 ) = tpd_A0_DQ0;
        ( A0 => DQ13 ) = tpd_A0_DQ0;
        ( A0 => DQ14 ) = tpd_A0_DQ0;
        ( A0 => DQ15 ) = tpd_A0_DQ0;
        ( A1 => DQ0 ) = tpd_A0_DQ0;
        ( A1 => DQ1 ) = tpd_A0_DQ0;
        ( A1 => DQ2 ) = tpd_A0_DQ0;
        ( A1 => DQ3 ) = tpd_A0_DQ0;
        ( A1 => DQ4 ) = tpd_A0_DQ0;
        ( A1 => DQ5 ) = tpd_A0_DQ0;
        ( A1 => DQ6 ) = tpd_A0_DQ0;
        ( A1 => DQ7 ) = tpd_A0_DQ0;
        ( A1 => DQ8 ) = tpd_A0_DQ0;
        ( A1 => DQ9 ) = tpd_A0_DQ0;
        ( A1 => DQ10 ) = tpd_A0_DQ0;
        ( A1 => DQ11 ) = tpd_A0_DQ0;
        ( A1 => DQ12 ) = tpd_A0_DQ0;
        ( A1 => DQ13 ) = tpd_A0_DQ0;
        ( A1 => DQ14 ) = tpd_A0_DQ0;
        ( A1 => DQ15 ) = tpd_A0_DQ0;
        ( A2 => DQ0 ) = tpd_A0_DQ0;
        ( A2 => DQ1 ) = tpd_A0_DQ0;
        ( A2 => DQ2 ) = tpd_A0_DQ0;
        ( A2 => DQ3 ) = tpd_A0_DQ0;
        ( A2 => DQ4 ) = tpd_A0_DQ0;
        ( A2 => DQ5 ) = tpd_A0_DQ0;
        ( A2 => DQ6 ) = tpd_A0_DQ0;
        ( A2 => DQ7 ) = tpd_A0_DQ0;
        ( A2 => DQ8 ) = tpd_A0_DQ0;
        ( A2 => DQ9 ) = tpd_A0_DQ0;
        ( A2 => DQ10 ) = tpd_A0_DQ0;
        ( A2 => DQ11 ) = tpd_A0_DQ0;
        ( A2 => DQ12 ) = tpd_A0_DQ0;
        ( A2 => DQ13 ) = tpd_A0_DQ0;
        ( A2 => DQ14 ) = tpd_A0_DQ0;
        ( A2 => DQ15 ) = tpd_A0_DQ0;
        ( A3 => DQ0 ) = tpd_A0_DQ0;
        ( A3 => DQ1 ) = tpd_A0_DQ0;
        ( A3 => DQ2 ) = tpd_A0_DQ0;
        ( A3 => DQ3 ) = tpd_A0_DQ0;
        ( A3 => DQ4 ) = tpd_A0_DQ0;
        ( A3 => DQ5 ) = tpd_A0_DQ0;
        ( A3 => DQ6 ) = tpd_A0_DQ0;
        ( A3 => DQ7 ) = tpd_A0_DQ0;
        ( A3 => DQ8 ) = tpd_A0_DQ0;
        ( A3 => DQ9 ) = tpd_A0_DQ0;
        ( A3 => DQ10 ) = tpd_A0_DQ0;
        ( A3 => DQ11 ) = tpd_A0_DQ0;
        ( A3 => DQ12 ) = tpd_A0_DQ0;
        ( A3 => DQ13 ) = tpd_A0_DQ0;
        ( A3 => DQ14 ) = tpd_A0_DQ0;
        ( A3 => DQ15 ) = tpd_A0_DQ0;
        ( A4 => DQ0 ) = tpd_A0_DQ0;
        ( A4 => DQ1 ) = tpd_A0_DQ0;
        ( A4 => DQ2 ) = tpd_A0_DQ0;
        ( A4 => DQ3 ) = tpd_A0_DQ0;
        ( A4 => DQ4 ) = tpd_A0_DQ0;
        ( A4 => DQ5 ) = tpd_A0_DQ0;
        ( A4 => DQ6 ) = tpd_A0_DQ0;
        ( A4 => DQ7 ) = tpd_A0_DQ0;
        ( A4 => DQ8 ) = tpd_A0_DQ0;
        ( A4 => DQ9 ) = tpd_A0_DQ0;
        ( A4 => DQ10 ) = tpd_A0_DQ0;
        ( A4 => DQ11 ) = tpd_A0_DQ0;
        ( A4 => DQ12 ) = tpd_A0_DQ0;
        ( A4 => DQ13 ) = tpd_A0_DQ0;
        ( A4 => DQ14 ) = tpd_A0_DQ0;
        ( A4 => DQ15 ) = tpd_A0_DQ0;
        ( A5 => DQ0 ) = tpd_A0_DQ0;
        ( A5 => DQ1 ) = tpd_A0_DQ0;
        ( A5 => DQ2 ) = tpd_A0_DQ0;
        ( A5 => DQ3 ) = tpd_A0_DQ0;
        ( A5 => DQ4 ) = tpd_A0_DQ0;
        ( A5 => DQ5 ) = tpd_A0_DQ0;
        ( A5 => DQ6 ) = tpd_A0_DQ0;
        ( A5 => DQ7 ) = tpd_A0_DQ0;
        ( A5 => DQ8 ) = tpd_A0_DQ0;
        ( A5 => DQ9 ) = tpd_A0_DQ0;
        ( A5 => DQ10 ) = tpd_A0_DQ0;
        ( A5 => DQ11 ) = tpd_A0_DQ0;
        ( A5 => DQ12 ) = tpd_A0_DQ0;
        ( A5 => DQ13 ) = tpd_A0_DQ0;
        ( A5 => DQ14 ) = tpd_A0_DQ0;
        ( A5 => DQ15 ) = tpd_A0_DQ0;
        ( A6 => DQ0 ) = tpd_A0_DQ0;
        ( A6 => DQ1 ) = tpd_A0_DQ0;
        ( A6 => DQ2 ) = tpd_A0_DQ0;
        ( A6 => DQ3 ) = tpd_A0_DQ0;
        ( A6 => DQ4 ) = tpd_A0_DQ0;
        ( A6 => DQ5 ) = tpd_A0_DQ0;
        ( A6 => DQ6 ) = tpd_A0_DQ0;
        ( A6 => DQ7 ) = tpd_A0_DQ0;
        ( A6 => DQ8 ) = tpd_A0_DQ0;
        ( A6 => DQ9 ) = tpd_A0_DQ0;
        ( A6 => DQ10 ) = tpd_A0_DQ0;
        ( A6 => DQ11 ) = tpd_A0_DQ0;
        ( A6 => DQ12 ) = tpd_A0_DQ0;
        ( A6 => DQ13 ) = tpd_A0_DQ0;
        ( A6 => DQ14 ) = tpd_A0_DQ0;
        ( A6 => DQ15 ) = tpd_A0_DQ0;
        ( A7 => DQ0 ) = tpd_A0_DQ0;
        ( A7 => DQ1 ) = tpd_A0_DQ0;
        ( A7 => DQ2 ) = tpd_A0_DQ0;
        ( A7 => DQ3 ) = tpd_A0_DQ0;
        ( A7 => DQ4 ) = tpd_A0_DQ0;
        ( A7 => DQ5 ) = tpd_A0_DQ0;
        ( A7 => DQ6 ) = tpd_A0_DQ0;
        ( A7 => DQ7 ) = tpd_A0_DQ0;
        ( A7 => DQ8 ) = tpd_A0_DQ0;
        ( A7 => DQ9 ) = tpd_A0_DQ0;
        ( A7 => DQ10 ) = tpd_A0_DQ0;
        ( A7 => DQ11 ) = tpd_A0_DQ0;
        ( A7 => DQ12 ) = tpd_A0_DQ0;
        ( A7 => DQ13 ) = tpd_A0_DQ0;
        ( A7 => DQ14 ) = tpd_A0_DQ0;
        ( A7 => DQ15 ) = tpd_A0_DQ0;
        ( A8 => DQ0 ) = tpd_A0_DQ0;
        ( A8 => DQ1 ) = tpd_A0_DQ0;
        ( A8 => DQ2 ) = tpd_A0_DQ0;
        ( A8 => DQ3 ) = tpd_A0_DQ0;
        ( A8 => DQ4 ) = tpd_A0_DQ0;
        ( A8 => DQ5 ) = tpd_A0_DQ0;
        ( A8 => DQ6 ) = tpd_A0_DQ0;
        ( A8 => DQ7 ) = tpd_A0_DQ0;
        ( A8 => DQ8 ) = tpd_A0_DQ0;
        ( A8 => DQ9 ) = tpd_A0_DQ0;
        ( A8 => DQ10 ) = tpd_A0_DQ0;
        ( A8 => DQ11 ) = tpd_A0_DQ0;
        ( A8 => DQ12 ) = tpd_A0_DQ0;
        ( A8 => DQ13 ) = tpd_A0_DQ0;
        ( A8 => DQ14 ) = tpd_A0_DQ0;
        ( A8 => DQ15 ) = tpd_A0_DQ0;
        ( A9 => DQ0 ) = tpd_A0_DQ0;
        ( A9 => DQ1 ) = tpd_A0_DQ0;
        ( A9 => DQ2 ) = tpd_A0_DQ0;
        ( A9 => DQ3 ) = tpd_A0_DQ0;
        ( A9 => DQ4 ) = tpd_A0_DQ0;
        ( A9 => DQ5 ) = tpd_A0_DQ0;
        ( A9 => DQ6 ) = tpd_A0_DQ0;
        ( A9 => DQ7 ) = tpd_A0_DQ0;
        ( A9 => DQ8 ) = tpd_A0_DQ0;
        ( A9 => DQ9 ) = tpd_A0_DQ0;
        ( A9 => DQ10 ) = tpd_A0_DQ0;
        ( A9 => DQ11 ) = tpd_A0_DQ0;
        ( A9 => DQ12 ) = tpd_A0_DQ0;
        ( A9 => DQ13 ) = tpd_A0_DQ0;
        ( A9 => DQ14 ) = tpd_A0_DQ0;
        ( A9 => DQ15 ) = tpd_A0_DQ0;
        ( A10 => DQ0 ) = tpd_A0_DQ0;
        ( A10 => DQ1 ) = tpd_A0_DQ0;
        ( A10 => DQ2 ) = tpd_A0_DQ0;
        ( A10 => DQ3 ) = tpd_A0_DQ0;
        ( A10 => DQ4 ) = tpd_A0_DQ0;
        ( A10 => DQ5 ) = tpd_A0_DQ0;
        ( A10 => DQ6 ) = tpd_A0_DQ0;
        ( A10 => DQ7 ) = tpd_A0_DQ0;
        ( A10 => DQ8 ) = tpd_A0_DQ0;
        ( A10 => DQ9 ) = tpd_A0_DQ0;
        ( A10 => DQ10 ) = tpd_A0_DQ0;
        ( A10 => DQ11 ) = tpd_A0_DQ0;
        ( A10 => DQ12 ) = tpd_A0_DQ0;
        ( A10 => DQ13 ) = tpd_A0_DQ0;
        ( A10 => DQ14 ) = tpd_A0_DQ0;
        ( A10 => DQ15 ) = tpd_A0_DQ0;
        ( A11 => DQ0 ) = tpd_A0_DQ0;
        ( A11 => DQ1 ) = tpd_A0_DQ0;
        ( A11 => DQ2 ) = tpd_A0_DQ0;
        ( A11 => DQ3 ) = tpd_A0_DQ0;
        ( A11 => DQ4 ) = tpd_A0_DQ0;
        ( A11 => DQ5 ) = tpd_A0_DQ0;
        ( A11 => DQ6 ) = tpd_A0_DQ0;
        ( A11 => DQ7 ) = tpd_A0_DQ0;
        ( A11 => DQ8 ) = tpd_A0_DQ0;
        ( A11 => DQ9 ) = tpd_A0_DQ0;
        ( A11 => DQ10 ) = tpd_A0_DQ0;
        ( A11 => DQ11 ) = tpd_A0_DQ0;
        ( A11 => DQ12 ) = tpd_A0_DQ0;
        ( A11 => DQ13 ) = tpd_A0_DQ0;
        ( A11 => DQ14 ) = tpd_A0_DQ0;
        ( A11 => DQ15 ) = tpd_A0_DQ0;
        ( A12 => DQ0 ) = tpd_A0_DQ0;
        ( A12 => DQ1 ) = tpd_A0_DQ0;
        ( A12 => DQ2 ) = tpd_A0_DQ0;
        ( A12 => DQ3 ) = tpd_A0_DQ0;
        ( A12 => DQ4 ) = tpd_A0_DQ0;
        ( A12 => DQ5 ) = tpd_A0_DQ0;
        ( A12 => DQ6 ) = tpd_A0_DQ0;
        ( A12 => DQ7 ) = tpd_A0_DQ0;
        ( A12 => DQ8 ) = tpd_A0_DQ0;
        ( A12 => DQ9 ) = tpd_A0_DQ0;
        ( A12 => DQ10 ) = tpd_A0_DQ0;
        ( A12 => DQ11 ) = tpd_A0_DQ0;
        ( A12 => DQ12 ) = tpd_A0_DQ0;
        ( A12 => DQ13 ) = tpd_A0_DQ0;
        ( A12 => DQ14 ) = tpd_A0_DQ0;
        ( A12 => DQ15 ) = tpd_A0_DQ0;
        ( A13 => DQ0 ) = tpd_A0_DQ0;
        ( A13 => DQ1 ) = tpd_A0_DQ0;
        ( A13 => DQ2 ) = tpd_A0_DQ0;
        ( A13 => DQ3 ) = tpd_A0_DQ0;
        ( A13 => DQ4 ) = tpd_A0_DQ0;
        ( A13 => DQ5 ) = tpd_A0_DQ0;
        ( A13 => DQ6 ) = tpd_A0_DQ0;
        ( A13 => DQ7 ) = tpd_A0_DQ0;
        ( A13 => DQ8 ) = tpd_A0_DQ0;
        ( A13 => DQ9 ) = tpd_A0_DQ0;
        ( A13 => DQ10 ) = tpd_A0_DQ0;
        ( A13 => DQ11 ) = tpd_A0_DQ0;
        ( A13 => DQ12 ) = tpd_A0_DQ0;
        ( A13 => DQ13 ) = tpd_A0_DQ0;
        ( A13 => DQ14 ) = tpd_A0_DQ0;
        ( A13 => DQ15 ) = tpd_A0_DQ0;
        ( A14 => DQ0 ) = tpd_A0_DQ0;
        ( A14 => DQ1 ) = tpd_A0_DQ0;
        ( A14 => DQ2 ) = tpd_A0_DQ0;
        ( A14 => DQ3 ) = tpd_A0_DQ0;
        ( A14 => DQ4 ) = tpd_A0_DQ0;
        ( A14 => DQ5 ) = tpd_A0_DQ0;
        ( A14 => DQ6 ) = tpd_A0_DQ0;
        ( A14 => DQ7 ) = tpd_A0_DQ0;
        ( A14 => DQ8 ) = tpd_A0_DQ0;
        ( A14 => DQ9 ) = tpd_A0_DQ0;
        ( A14 => DQ10 ) = tpd_A0_DQ0;
        ( A14 => DQ11 ) = tpd_A0_DQ0;
        ( A14 => DQ12 ) = tpd_A0_DQ0;
        ( A14 => DQ13 ) = tpd_A0_DQ0;
        ( A14 => DQ14 ) = tpd_A0_DQ0;
        ( A14 => DQ15 ) = tpd_A0_DQ0;
        ( A15 => DQ0 ) = tpd_A0_DQ0;
        ( A15 => DQ1 ) = tpd_A0_DQ0;
        ( A15 => DQ2 ) = tpd_A0_DQ0;
        ( A15 => DQ3 ) = tpd_A0_DQ0;
        ( A15 => DQ4 ) = tpd_A0_DQ0;
        ( A15 => DQ5 ) = tpd_A0_DQ0;
        ( A15 => DQ6 ) = tpd_A0_DQ0;
        ( A15 => DQ7 ) = tpd_A0_DQ0;
        ( A15 => DQ8 ) = tpd_A0_DQ0;
        ( A15 => DQ9 ) = tpd_A0_DQ0;
        ( A15 => DQ10 ) = tpd_A0_DQ0;
        ( A15 => DQ11 ) = tpd_A0_DQ0;
        ( A15 => DQ12 ) = tpd_A0_DQ0;
        ( A15 => DQ13 ) = tpd_A0_DQ0;
        ( A15 => DQ14 ) = tpd_A0_DQ0;
        ( A15 => DQ15 ) = tpd_A0_DQ0;
        ( A16 => DQ0 ) = tpd_A0_DQ0;
        ( A16 => DQ1 ) = tpd_A0_DQ0;
        ( A16 => DQ2 ) = tpd_A0_DQ0;
        ( A16 => DQ3 ) = tpd_A0_DQ0;
        ( A16 => DQ4 ) = tpd_A0_DQ0;
        ( A16 => DQ5 ) = tpd_A0_DQ0;
        ( A16 => DQ6 ) = tpd_A0_DQ0;
        ( A16 => DQ7 ) = tpd_A0_DQ0;
        ( A16 => DQ8 ) = tpd_A0_DQ0;
        ( A16 => DQ9 ) = tpd_A0_DQ0;
        ( A16 => DQ10 ) = tpd_A0_DQ0;
        ( A16 => DQ11 ) = tpd_A0_DQ0;
        ( A16 => DQ12 ) = tpd_A0_DQ0;
        ( A16 => DQ13 ) = tpd_A0_DQ0;
        ( A16 => DQ14 ) = tpd_A0_DQ0;
        ( A16 => DQ15 ) = tpd_A0_DQ0;
        ( A17 => DQ0 ) = tpd_A0_DQ0;
        ( A17 => DQ1 ) = tpd_A0_DQ0;
        ( A17 => DQ2 ) = tpd_A0_DQ0;
        ( A17 => DQ3 ) = tpd_A0_DQ0;
        ( A17 => DQ4 ) = tpd_A0_DQ0;
        ( A17 => DQ5 ) = tpd_A0_DQ0;
        ( A17 => DQ6 ) = tpd_A0_DQ0;
        ( A17 => DQ7 ) = tpd_A0_DQ0;
        ( A17 => DQ8 ) = tpd_A0_DQ0;
        ( A17 => DQ9 ) = tpd_A0_DQ0;
        ( A17 => DQ10 ) = tpd_A0_DQ0;
        ( A17 => DQ11 ) = tpd_A0_DQ0;
        ( A17 => DQ12 ) = tpd_A0_DQ0;
        ( A17 => DQ13 ) = tpd_A0_DQ0;
        ( A17 => DQ14 ) = tpd_A0_DQ0;
        ( A17 => DQ15 ) = tpd_A0_DQ0;
        ( A18 => DQ0 ) = tpd_A0_DQ0;
        ( A18 => DQ1 ) = tpd_A0_DQ0;
        ( A18 => DQ2 ) = tpd_A0_DQ0;
        ( A18 => DQ3 ) = tpd_A0_DQ0;
        ( A18 => DQ4 ) = tpd_A0_DQ0;
        ( A18 => DQ5 ) = tpd_A0_DQ0;
        ( A18 => DQ6 ) = tpd_A0_DQ0;
        ( A18 => DQ7 ) = tpd_A0_DQ0;
        ( A18 => DQ8 ) = tpd_A0_DQ0;
        ( A18 => DQ9 ) = tpd_A0_DQ0;
        ( A18 => DQ10 ) = tpd_A0_DQ0;
        ( A18 => DQ11 ) = tpd_A0_DQ0;
        ( A18 => DQ12 ) = tpd_A0_DQ0;
        ( A18 => DQ13 ) = tpd_A0_DQ0;
        ( A18 => DQ14 ) = tpd_A0_DQ0;
        ( A18 => DQ15 ) = tpd_A0_DQ0;
        ( A19 => DQ0 ) = tpd_A0_DQ0;
        ( A19 => DQ1 ) = tpd_A0_DQ0;
        ( A19 => DQ2 ) = tpd_A0_DQ0;
        ( A19 => DQ3 ) = tpd_A0_DQ0;
        ( A19 => DQ4 ) = tpd_A0_DQ0;
        ( A19 => DQ5 ) = tpd_A0_DQ0;
        ( A19 => DQ6 ) = tpd_A0_DQ0;
        ( A19 => DQ7 ) = tpd_A0_DQ0;
        ( A19 => DQ8 ) = tpd_A0_DQ0;
        ( A19 => DQ9 ) = tpd_A0_DQ0;
        ( A19 => DQ10 ) = tpd_A0_DQ0;
        ( A19 => DQ11 ) = tpd_A0_DQ0;
        ( A19 => DQ12 ) = tpd_A0_DQ0;
        ( A19 => DQ13 ) = tpd_A0_DQ0;
        ( A19 => DQ14 ) = tpd_A0_DQ0;
        ( A19 => DQ15 ) = tpd_A0_DQ0;
        ( A20 => DQ0 ) = tpd_A0_DQ0;
        ( A20 => DQ1 ) = tpd_A0_DQ0;
        ( A20 => DQ2 ) = tpd_A0_DQ0;
        ( A20 => DQ3 ) = tpd_A0_DQ0;
        ( A20 => DQ4 ) = tpd_A0_DQ0;
        ( A20 => DQ5 ) = tpd_A0_DQ0;
        ( A20 => DQ6 ) = tpd_A0_DQ0;
        ( A20 => DQ7 ) = tpd_A0_DQ0;
        ( A20 => DQ8 ) = tpd_A0_DQ0;
        ( A20 => DQ9 ) = tpd_A0_DQ0;
        ( A20 => DQ10 ) = tpd_A0_DQ0;
        ( A20 => DQ11 ) = tpd_A0_DQ0;
        ( A20 => DQ12 ) = tpd_A0_DQ0;
        ( A20 => DQ13 ) = tpd_A0_DQ0;
        ( A20 => DQ14 ) = tpd_A0_DQ0;
        ( A20 => DQ15 ) = tpd_A0_DQ0;

    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ0 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ1 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ2 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ3 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ4 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ5 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ6 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ7 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ8 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ9 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ10 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ11 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ12 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ13 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ14 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg && CLK_PATH_ENABLE &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS))
            ( CLK => DQ15 ) = tpd_CLK_DQ0;

    if (~RESETNeg )
        ( RESETNeg => DQ0 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ1 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ2 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ3 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ4 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ5 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ6 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ7 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ8 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ9 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ10 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ11 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ12 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ13 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ14 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg )
        ( RESETNeg => DQ15 ) = tpd_RESETNeg_DQ0;


    (CENeg *> RDY) = tpd_CENeg_RDY;

    if ( temp19 == 1'b0 && ~CENeg &&
    (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
        ( CLK *>  RDY ) = tpd_CLK_RDY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////
        $setup ( A0  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A1  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A2  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A3  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A4  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A5  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A6  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A7  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A8  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A9  , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A10 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A11 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A12 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A13 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A14 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A15 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A16 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A17 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A18 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A19 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A20 , posedge CLK &&& A_CLKP_CHECK, tsetup_A0_CLK, Viol);

        $setup ( A0  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A1  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A2  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A3  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A4  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A5  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A6  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A7  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A8  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A9  , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A10 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A11 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A12 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A13 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A14 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A15 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A16 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A17 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A18 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A19 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);
        $setup ( A20 , negedge CLK &&& A_CLKN_CHECK, tsetup_A0_CLK, Viol);

        $setup (CENeg ,posedge CLK &&& CENeg_CLKP_CHECK,tsetup_CENeg_CLK,Viol);
        $setup (CENeg ,negedge CLK &&& CENeg_CLKN_CHECK,tsetup_CENeg_CLK,Viol);
        $setup (CENeg ,negedge AVDNeg,  tsetup_CENeg_AVDNeg, Viol);
        $setup (AVDNeg,negedge CLK &&& AVDNeg_CLKN_CHECK,tsetup_AVDNeg_CLK,Viol);
        $setup (AVDNeg,posedge CLK &&& AVDNeg_CLKP_CHECK,tsetup_AVDNeg_CLK,Viol);

        $setup (DQ0  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ1  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ2  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ3  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ4  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ5  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ6  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ7  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ8  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ9  , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ10 , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ11 , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ12 , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ13 , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ14 , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);
        $setup (DQ15 , posedge WENeg &&& DQ_WENeg_CHECK,tsetup_DQ0_WENeg,Viol);

        $setup (DQ0  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ1  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ2  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ3  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ4  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ5  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ6  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ7  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ8  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ9  , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ10 , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ11 , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ12 , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ13 , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ14 , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);
        $setup (DQ15 , posedge CENeg &&& DQ_CENeg_CHECK,tsetup_DQ0_CENeg, Viol);

        $setup (CENeg, negedge WENeg  ,  tsetup_CENeg_WENeg , Viol);
        $setup (WENeg, negedge CENeg  ,  tsetup_WENeg_CENeg , Viol);

        $setup (AVDNeg,negedge WENeg &&& AVDNeg_WENeg_CHECK
                ,tsetup_AVDNeg_CLK,Viol);
        $setup (CLK   ,negedge WENeg &&&  CLKP_WENeg_CHECK
                ,tsetup_CLK_WENeg ,Viol);
        $setup (CLK   ,negedge WENeg &&&  CLKN_WENeg_CHECK
                ,tsetup_CLK_WENeg , Viol);

        $setup (A0  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup (A1  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup (A2  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup (A3  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup (A4  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A5  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A6  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A7  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A8  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A9  , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A10 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A11 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A12 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A13 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A14 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A15 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A16 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A17 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A18 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A19 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A20 , posedge AVDNeg &&& SYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);

        $setup ( A0  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A1  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A2  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A3  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A4  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A5  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A6  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A7  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A8  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A9  , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A10 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A11 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A12 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A13 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A14 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A15 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A16 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A17 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A18 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A19 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A20 , posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK
                ,  tsetup_A0_AVDNeg, Viol);

        $setup ( A0  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A1  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A2  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A3  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A4  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A5  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A6  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A7  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A8  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A9  , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A10 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A11 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A12 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A13 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A14 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A15 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A16 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A17 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A18 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A19 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);
        $setup ( A20 , negedge CENeg &&& A_CENeg_CHECK  ,tsetup_A0_CENeg, Viol);

        $setup ( A0  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A1  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A2  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A3  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A4  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A5  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A6  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A7  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A8  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A9  , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A20 , negedge WENeg &&& SYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);

        $setup ( A0  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A1  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A2  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A3  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A4  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A5  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A6  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A7  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A8  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A9  , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);
        $setup ( A20 , negedge WENeg &&& ASYN_A_WENeg_CHECK
                 ,  tsetup_A0_WENeg, Viol);

        $hold ( posedge CLK &&& A_CLKP_CHECK, A0 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A1 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A2 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A3 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A4 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A5 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A6 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A7 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A8 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A9 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A10 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A11 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A12 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A13 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A14 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A15 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A16 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A17 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A18 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A19 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& A_CLKP_CHECK, A20 , thold_A0_CLK, Viol);

        $hold ( negedge CLK &&& A_CLKN_CHECK, A0 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A1 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A2 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A3 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A4 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A5 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A6 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A7 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A8 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A9 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A10 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A11 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A12 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A13 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A14 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A15 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A16 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A17 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A18 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A19 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& A_CLKN_CHECK, A20 , thold_A0_CLK, Viol);

        $hold ( negedge CLK &&& AVDNeg_CLKN_CHECK, AVDNeg
                , thold_AVDNeg_CLK, Viol);
        $hold ( posedge CLK &&& AVDNeg_CLKP_CHECK, AVDNeg
                , thold_AVDNeg_CLK, Viol);

        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ0 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ1 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ2 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ3 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ4 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ5 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ6 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ7 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ8 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ9 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ10 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ11 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ12 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ13 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ14 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ_WENeg_CHECK, DQ15 , thold_DQ0_WENeg, Viol);

        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ0 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ1 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ2 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ3 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ4 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ5 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ6 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ7 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ8 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ9 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ10 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ11 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ12 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ13 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ14 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ_CENeg_CHECK, DQ15 , thold_DQ0_CENeg, Viol);

        $hold ( negedge WENeg &&& AVDNeg_WENeg_CHECK, AVDNeg
                , thold_AVDNeg_WENeg, Viol);
        $hold ( negedge WENeg , CENeg , thold_CENeg_WENeg, Viol);
        $hold ( negedge CENeg , WENeg , thold_WENeg_CENeg, Viol);

        $hold ( negedge CENeg &&& A_CENeg_CHECK, A0 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A1 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A2 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A3 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A4 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A5 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A6 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A7 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A8 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A9 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A10 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A11 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A12 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A13 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A14 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A15 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A16 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A17 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A18 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A19 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& A_CENeg_CHECK, A20 , thold_A0_CENeg, Viol);

        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A0
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A1
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A2
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A3
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A4
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A5
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A6
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A7
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A8
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A9
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A10
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A11
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A12
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A13
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A14
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A15
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A16
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A17
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A18
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A19
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& ASYN_A_AVDNeg_CHECK, A20
                , thold_A0_AVDNeg, Viol);

        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A0
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A1
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A2
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A3
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A4
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A5
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A6
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A7
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A8
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A9
                ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A10
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A11
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A12
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A13
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A14
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A15
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A16
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A17
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A18
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A19
                , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& SYN_A_AVDNeg_CHECK, A20
                , thold_A0_AVDNeg, Viol);

        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A0
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A1
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A2
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A3
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A4
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A5
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A6
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A7
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A8
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A9
                ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A10
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A11
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A12
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A13
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A14
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A15
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A16
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A17
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A18
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A19
                , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& ASYN_A_WENeg_CHECK, A20
                , thold_A0_WENeg, Viol);

        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A0  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A1  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A2  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A3  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A4  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A5  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A6  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A7  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A8  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A9  , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A10 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A11 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A12 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A13 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A14 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A15 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A16 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A17 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A18 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A19 , thold_A0_WENeg,Viol);
        $hold ( negedge WENeg &&& SYN_A_WENeg_CHECK, A20 , thold_A0_WENeg,Viol);

        $hold ( posedge WENeg, OENeg, thold_OENeg_WENeg, Viol);
        $hold ( posedge RESETNeg &&& ~CENeg, CENeg, thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& ~OENeg, OENeg, thold_OENeg_RESETNeg, Viol);

        $hold ( posedge CLK &&& CLK_HI_CHK, DQ0  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ1  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ2  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ3  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ4  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ5  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ6  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ7  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ8  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ9  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ10 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ11 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ12 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ13 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ14 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& CLK_HI_CHK, DQ15 ,   thold_DQ0_CLK, Viol);

        $hold ( negedge CLK &&& CLK_LO_CHK, DQ0  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ1  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ2  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ3  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ4  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ5  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ6  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ7  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ8  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ9  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ10 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ11 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ12 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ13 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ14 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& CLK_LO_CHK, DQ15 ,   thold_DQ0_CLK, Viol);

        $setup (posedge RDY   ,posedge CLK &&& CLK_HI_CHK,  tsetup_RDY_CLK, Viol);
        $setup (posedge RDY   ,negedge CLK &&& CLK_LO_CHK,tsetup_RDY_CLK, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (negedge AVDNeg  , tpw_AVDNeg_negedge);
        $width (posedge WENeg   , tpw_WENeg_posedge);
        $width (negedge WENeg   , tpw_WENeg_negedge);
        $width (posedge CLK     , tpw_CLK_posedge);
        $width (negedge CLK     , tpw_CLK_negedge);

        $period (posedge CLK, tperiod_CLK);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////
// FSM states
 parameter RESET               =6'd0;
 parameter Z001                =6'd1;
 parameter PREL_SETBWB         =6'd2;
 parameter CFI                 =6'd3;
 parameter AS                  =6'd4;
 parameter PREL_ULBYPASS       =6'd5;
 parameter ULBYPASS_C8         =6'd6;
 parameter PREL_ULBYPASS_RESET =6'd7;
 parameter A0SEEN              =6'd8;
 parameter C8                  =6'd9;
 parameter C8_Z001             =6'd10;
 parameter C8_PREL             =6'd11;
 parameter ERS                 =6'd12;
 parameter SERS                =6'd13;
 parameter ESP                 =6'd14;
 parameter ESPS                =6'd15;
 parameter SERS_EXEC           =6'd16;
 parameter ESP_Z001            =6'd17;
 parameter ESP_PREL            =6'd18;
 parameter PGMS                =6'd19;
 parameter SLU_1               =6'd20;
 parameter SLU_2               =6'd21;
 parameter SLU_3               =6'd22;

 reg [5:0] current_state;
 reg [5:0] next_state;
 reg deq;

    //////////////////////////////////////////////////////////
    //          Output Data Gen
    //////////////////////////////////////////////////////////
    always @(DOut_zd)
    begin : OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            if (CFR[19] == 1'b1)
            begin
                CEDQ_t = CENeg_event  + CEDQ_01;
                OEDQ_t = OENeg_event  + OEDQ_01;
            end
            else
            begin
                CEDQ_t = CENeg_event  + CEDQ_02;
                OEDQ_t = OENeg_event  + OEDQ_02;
            end
            ADDRDQ_t = ADDR_event + ADDRDQ_01;
                FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
                FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t)&&FROMOE) ||
              ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                TempData = DOut_zd;
                DOut_Pass = 16'bx;
                DOut_Pass <= #( ADDRDQ_t - $time ) TempData;
            end
            else if ((OEDQ_t < $time && CEDQ_t < $time ) &&
            (ADDRDQ_t > $time ))
            begin
                TempData = DOut_zd;
                DOut_Pass <= #( ADDRDQ_t - $time ) TempData;
            end
            else
                DOut_Pass = DOut_zd;
       end
   end

   always @(DOut_zd)
   begin
       if (DOut_zd[0] === 1'bz)
       begin
           disable OutputGen;
           FROMCE = 1'b1;
           FROMOE = 1'b1;
           DOut_Pass = DOut_zd;
       end
    end

    always @(DIn, DOut)
    begin
        if (DIn==DOut)
            deq=1'b1;
        else
            deq=1'b0;
    end
    // check when data is generated from model to avoid setuphold check in
    // those occasion
    assign deg=deq;

    initial
    begin
            CFI_Vect[8'h10] = 16'h0051;
            CFI_Vect[8'h11] = 16'h52;
            CFI_Vect[8'h12] = 16'h59;
            CFI_Vect[8'h13] = 16'h02;
            CFI_Vect[8'h14] = 16'h00;
            CFI_Vect[8'h15] = 16'h40;
            CFI_Vect[8'h16] = 16'h00;
            CFI_Vect[8'h17] = 16'h00;
            CFI_Vect[8'h18] = 16'h00;
            CFI_Vect[8'h19] = 16'h00;
            CFI_Vect[8'h1A] = 16'h00;
            //system interface string
            CFI_Vect[8'h1B] = 16'h17;
            CFI_Vect[8'h1C] = 16'h19;
            CFI_Vect[8'h1D] = 16'h00;
            CFI_Vect[8'h1E] = 16'h00;
            CFI_Vect[8'h1F] = 16'h03;
            CFI_Vect[8'h20] = 16'h00;
            CFI_Vect[8'h21] = 16'h09;
            CFI_Vect[8'h22] = 16'h00;
            CFI_Vect[8'h23] = 16'h04;
            CFI_Vect[8'h24] = 16'h00;
            CFI_Vect[8'h25] = 16'h04;
            CFI_Vect[8'h26] = 16'h00;
            //device geometry definition
            CFI_Vect[8'h27] = 16'h16;
            CFI_Vect[8'h28] = 16'h01;
            CFI_Vect[8'h29] = 16'h00;
            CFI_Vect[8'h2A] = 16'h00;
            CFI_Vect[8'h2B] = 16'h00;
            CFI_Vect[8'h2C] = 16'h03;
            CFI_Vect[8'h2D] = 16'h03;
            CFI_Vect[8'h2E] = 16'h00;
            CFI_Vect[8'h2F] = 16'h40;
            CFI_Vect[8'h30] = 16'h00;
            CFI_Vect[8'h31] = 16'h3D;
            CFI_Vect[8'h32] = 16'h00;
            CFI_Vect[8'h33] = 16'h00;
            CFI_Vect[8'h34] = 16'h01;
            CFI_Vect[8'h35] = 16'h03;
            CFI_Vect[8'h36] = 16'h00;
            CFI_Vect[8'h37] = 16'h40;
            CFI_Vect[8'h38] = 16'h00;
            CFI_Vect[8'h39] = 16'h00;
            CFI_Vect[8'h3A] = 16'h00;
            CFI_Vect[8'h3B] = 16'h00;
            CFI_Vect[8'h3C] = 16'h00;
            //primary vendor-specific extended query
            CFI_Vect[8'h40] = 16'h50;
            CFI_Vect[8'h41] = 16'h52;
            CFI_Vect[8'h42] = 16'h49;
            CFI_Vect[8'h43] = 16'h31;
            CFI_Vect[8'h44] = 16'h33;
            CFI_Vect[8'h45] = 16'h04;
            CFI_Vect[8'h46] = 16'h02;
            CFI_Vect[8'h47] = 16'h01;
            CFI_Vect[8'h48] = 16'h00;
            CFI_Vect[8'h49] = 16'h05;
            CFI_Vect[8'h4A] = 16'h33;
            CFI_Vect[8'h4B] = 16'h01;
            CFI_Vect[8'h4C] = 16'h00;
            CFI_Vect[8'h4D] = 16'hB5;
            CFI_Vect[8'h4E] = 16'hC5;
            CFI_Vect[8'h4F] = 16'h01;
            CFI_Vect[8'h50] = 16'h00;
            CFI_Vect[8'h57] = 16'h04;
            CFI_Vect[8'h58] = 16'h13;
            CFI_Vect[8'h59] = 16'h10;
            CFI_Vect[8'h5A] = 16'h10;
            CFI_Vect[8'h5B] = 16'h13;
 end
 // initialize memory and load preoload files if any

    initial
    begin : Memory_Init
    integer i;

        for (i=0;i<= MaxLoc;i=i+1)
        begin
            Mem[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
           Prot[i]=1;
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
           //s29ws032j memory preload file
           //  @aaaaaa  - <aaaaaa> stands for address within last defined sector
           //  dddd      - <dddd> is byte to be written at Mem(aaaaaa++)
           // (aaaa is incremented at every load)
           $readmemh(mem_file_name,Mem);
        end
        WrData = 0;
        WrAddr = -1;
        WrSec = -1;
    end

    //Power Up time 100 ns;
    initial
    begin
             PoweredUp = 1'b0;
             #100 PoweredUp = 1'b1;   //??????
    end

    always @(RESETNeg)
    begin
        RST <= #500 RESETNeg;
    end

    initial
    begin
        WRITE    = 1'b1;
        READ     = 1'b0;
        ReadINIT = 1'b1;
        burst_rd = 1'b1;

        ULBYPASS = 1'b0;
        ESP_ACT  = 1'b0 ;
        AS_ACT   = 1'b0 ;

        PDONE    = 1'b1;
        PSTART   = 1'b0;

        PERR     = 1'b0;

        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;

        EERR     = 1'b0;
        READY_in = 1'b0;
        READY_out= 1'b0;
        OENeg_event = 0;
        CENeg_event = 0;

        READ_MODE = ASYNCR;
        CFR[19:12] = 8'b11100101;
        SYNCH = !CFR[19];
        BankPRG  = -1;
        BankERS = 3'b0;
        BankAS   = -1;
        ERS_QUEUE = 69'b0;
    end

   always @(posedge START_in)
   begin:TESTARTT1r
     #tdevice_START START_out = START_in;
   end
   always @(negedge START_in)
   begin:TESTARTT1f
     #1 START_out = START_in;
   end

   always @(posedge CTMOUTP_in)
   begin:TCTMOUTPr
     #tdevice_CTMOUTP CTMOUTP_out = CTMOUTP_in;
   end
   always @(negedge CTMOUTP_in)
   begin:TCTMOUTPf
     #1 CTMOUTP_out = CTMOUTP_in;
   end
   always @(posedge READY_in)
   begin:TREADYr
     #tdevice_READYP READY_out = READY_in;
   end
   always @(negedge READY_in)
   begin:TREADYf
     #1 READY_out = READY_in;
   end
   always @(posedge TIACC_in)
   begin : AccessTime
     #tdevice_TIACC TIACC_out = 1'b1;
   end
   always @(negedge TIACC_in)
   begin
       disable AccessTime;
       TIACC_out = 1'b0;
   end

    ////////////////////////////////////////////////////////////////////////////
    ////     obtain 'LAST_EVENT information
    ////////////////////////////////////////////////////////////////////////////
    always @(negedge OENeg)
    begin
        OENeg_event = $time;
    end
    always @(negedge CENeg)
    begin
        CENeg_event = $time;
    end
    ////////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ////////////////////////////////////////////////////////////////////////////
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
            READY_out or PoweredUp)
    begin: StateTransition

        if (PoweredUp)
        begin
            if (RESETNeg && (~R || (R && READY_out)))
            begin
                current_state = next_state;
                READY_in = 1'b0;
                E = 1'b0;
                R = 1'b0;
                reseted = 1'b1;
            end
            else if ((~R && ~RESETNeg && ~RST) ||
                  (R && ~RESETNeg && ~RST && ~READY_out) ||
                  (R && RESETNeg && ~RST && ~READY_out))
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
//    //////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    //////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

    always @(negedge OENeg)
    begin : OE_burstF
        #OEDQ_01 OE_burst = 1'b0;
    end

    always @(posedge OENeg)
    begin : OE_burstR
        disable OE_burstF;
        OE_burst = 1'b1;
    end

    always @(CLK)
    begin
        if (CFR[17] == 1'b1)
            CLK_out = CLK;
        else
            CLK_out = ~CLK;
    end


//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
//    //////////////////////////////////////////////////////////////////////////

 //time elapsed_write  ;
 time duration_write ;
 //time start_write    ;
 event pdone_event;

    always @(posedge reseted)
    begin
        disable pdone_process;
        PDONE = 1'b1;
    end

    always @(reseted or PSTART)
    begin
        if (reseted)
        begin
            if (PSTART && PDONE)
            begin
                if (!Prot[SA]
                    && (~ERS_QUEUE[SA] || ~ESP_ACT )
                    && ACC
                    && ~(~WPNeg && (SA == 0 || SA == 1)))
                begin
                    duration_write = tdevice_POW;
                    PDONE = 1'b0;
                    ->pdone_event;
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

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    //////////////////////////////////////////////////////////////////////////
 integer cnt_erase = 0;
 time elapsed_erase;
 time duration_erase;
 time start_erase;
 integer fact;

    always @(posedge reseted)
    begin
        disable edone_process;
        EDONE = 1'b1;
    end
    event edone_event;
    always @(reseted or ESTART)
    begin: erase
    integer i;
        if (reseted)
        begin
            if (ESTART && EDONE)
            begin
                if ( LongTiming == 0 )
                    fact = 10000;
                else
                    fact = 1;
                cnt_erase = 0;
                duration_erase = 0;
                for (i=0;i<=SecNum;i=i+1)
                    if ((ERS_QUEUE[i]==1'b1) && (!Prot[i])
                        && ACC && ~(~WPNeg && (i==0 || i==1)))
                        begin
                            cnt_erase = cnt_erase + 1;
                            if (i< 4 || i > 65)
                               duration_erase = duration_erase
                                                + (tdevice_SEO_s/fact);
                            else
                               duration_erase = duration_erase
                                                + (tdevice_SEO_b/fact);
                        end
                if (cnt_erase>0)
                begin
                    elapsed_erase = 0;
                    ->edone_event;
                    start_erase = $time;
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

    always @(CLK)
    begin
        if (CFR[17] == 1'b1)
            CLK_out = CLK;
        else
            CLK_out = ~CLK;
    end

//    //////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    //////////////////////////////////////////////////////////////////////////
reg[20:0] AddressLatched;
    always @(posedge AVDNeg)
    begin
        if ( ~CENeg && WENeg
        && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
            AddressLatched = A;
            SA = ReturnSectorID(AddressLatched);
            SB= ReturnBankID(AddressLatched);
            Addr= AddressLatched;
        end
        // Synchronous AVD# rising edge address latch
        if ( gWE_n && ~gCE_n && ~LATCHED &&
        reseted==1'b1 && CFR[19] == 1'b0 )
        begin
           RD = 1'b1;
           LATCHED = 1'b1;
           AddressLatched = A;
           SA = ReturnSectorID(AddressLatched);
           SB = ReturnBankID(AddressLatched);
           Addr =  AddressLatched ;
           ADDR_event = $time;
           TIACC_in = 1'b0;
           TIACC_in <= #1 1'b1;
           if ( ~OENeg )
           begin
               READ = 1'b0;
               #1 READ <= 1'b1;
           end
       end
    end

    always @(negedge AVDNeg)
    begin
        LATCHED  = 1'b0;
        RD = 1'b0;
        WR = 1'b0;
        if ( ~CENeg && WENeg
        && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
        end
    end

    always @(posedge CLK_out)
    begin
        //Initiate READ (Burst mode)
       if ( RD &&
       reseted==1'b1 && CFR[19] == 1'b0 )
       begin
           RD = 1'b0;
           burst_rd = 1'b0;
           #2 burst_rd <= 1'b1;
       end
       // Synchronous CLK active edge address latch
       if ( ~gCE_n && ~AVDNeg && ~LATCHED &&
       reseted==1'b1 && CFR[19] == 1'b0 )
       begin

           LATCHED = 1'b1;
           AddressLatched = A;
           SA = ReturnSectorID(AddressLatched);
           SB = ReturnBankID(AddressLatched);
           Addr =  AddressLatched;
           ADDR_event = $time;
           TIACC_in = 1'b0;
           TIACC_in <= #1 1'b1;
           if (WENeg)
              RD = 1'b1;
           if ( ~OENeg )
           begin
               READ = 1'b0;
               #1 READ <= 1'b1;
           end
       end
    end

    always @(A)
    begin
        if ( ~AVDNeg && ~CENeg && WENeg
        && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
            AddressLatched = A;
            SA = ReturnSectorID(AddressLatched);
            SB = ReturnBankID (AddressLatched);
        end
        if ( WENeg && ~CENeg && ~OENeg && ~AVDNeg
        && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
        // Initiate READ
            SA = ReturnSectorID(AddressLatched);
            SB = ReturnBankID(AddressLatched);
            Addr =  AddressLatched;
            ADDR_event = $time;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge OENeg)
    begin
        if ( WENeg && ~CENeg && reseted==1'b1 )
        begin
        // Initiate READ
            SA = ReturnSectorID(AddressLatched);
            SB = ReturnBankID(AddressLatched);
            Addr =  AddressLatched;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(posedge gWE_n)
    begin
        if ( RESETNeg != 1'b0 && ~gCE_n && OENeg
        && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
        // WRITE operation
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
        // Synchronous WRITE operation data latch
        if ( ~gCE_n && WR && gOE_n && RESETNeg != 1'b0 &&
        reseted==1'b1 && CFR[19] == 1'b0 )
        begin
             WR = 1'b0;
             D_tmp = DIn[15:0];
             WRITE = 1'b0;
             #1 WRITE <= 1'b1;
        end
    end

    always @(posedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 && ~gWE_n && OENeg
        && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
        // WRITE operation
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
    end
    always @(negedge gWE_n or negedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 &&
            ~gCE_n && ~gWE_n && OENeg && ~AVDNeg
            && reseted==1'b1 && CFR[19] == 1'b1 )
        begin
            AddressLatched = A;
            SA = ReturnSectorID(AddressLatched);
            SB = ReturnBankID(AddressLatched);
            Addr =  AddressLatched;
        end
        if ( ~gCE_n && ~gWE_n && OENeg &&
        reseted==1'b1 && CFR[19] == 1'b0 )
        begin
            RD = 1'b0;
            WR = 1'b1;
        end
    end

/////////////////////////////////////////////////////////////////////////////
//// Main Behavior Process
//// combinational process for next state generation
/////////////////////////////////////////////////////////////////////////////

    always @(negedge WRITE)
    begin
         DataLo = DIn[7:0];

         PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
         PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
         A_PAT_1   = (Addr % 16'h1000 == 12'h555);
         A_PAT_CFI = (Addr % 16'h100 == 8'h55);
    end

    always @( WRITE or reseted)
    begin: StateGen1
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (~WRITE)
            case (current_state)
            RESET :
            begin
                if(DataLo==16'h60)
                    next_state = SLU_1;
                else if (PATTERN_1)
                    next_state = Z001;
                else if (DataLo==16'h98 && A_PAT_CFI)
                    next_state = CFI;
                else
                    next_state = RESET;
            end
            Z001 :
            begin
                if (PATTERN_2)
                    next_state = PREL_SETBWB;
                else
                    next_state = RESET;
            end
            PREL_SETBWB :
            begin
                if (A_PAT_1 && (DataLo==16'h20))
                    next_state = PREL_ULBYPASS;
                else if  (A_PAT_1 && (DataLo==16'h90))
                    next_state = AS;
                else if (A_PAT_1 && (DataLo==16'hA0))
                    next_state = A0SEEN;
                else if (A_PAT_1 && (DataLo==16'h80))
                    next_state = C8;
                else
                    next_state = RESET;
            end
            CFI :
            begin
                if (DataLo == 16'hF0 )
                    if (AS_ACT)
                        next_state <= AS;
                    else if (ESP_ACT)
                        next_state <= ESP;
                    else
                        next_state = RESET;
            end
            PREL_ULBYPASS :
            begin
                if (DataLo == 16'h90 )
                    next_state <= PREL_ULBYPASS_RESET;
                else if (DataLo == 16'hA0)
                    next_state = A0SEEN;
                else if (DataLo == 16'h80)
                    next_state = ULBYPASS_C8;
                else
                    next_state = PREL_ULBYPASS;
            end
            PREL_ULBYPASS_RESET :
            begin
                if (DataLo == 16'h00 )
                   next_state <= RESET;
                else
                   next_state <= PREL_ULBYPASS;
            end

            ULBYPASS_C8:
            begin
                if (DataLo == 16'h10 )
                    next_state <= ERS;
                else if (DataLo == 16'h30)
                    next_state = SERS;
                else
                    next_state = PREL_ULBYPASS;
            end
            AS :
            begin
                if (DataLo==16'h98 && A_PAT_CFI)
                    next_state = CFI;
                else if (DataLo==16'hF0)
                    if  (ESP_ACT==1'b0)
                        next_state = RESET;
                    else
                        next_state = ESP;
            end
            A0SEEN :
            begin
                next_state = PGMS;
            end
            C8 :
            begin
                if (PATTERN_1)
                    next_state = C8_Z001;
                else
                    next_state = RESET;

            end
            C8_Z001 :
            begin
                if (PATTERN_2)
                    next_state = C8_PREL;
                else
                    next_state = RESET;
            end
            C8_PREL :
            begin
                if (A_PAT_1 && (DataLo==16'h10))
                    next_state = ERS;
                else if (DataLo==16'h30)
                    next_state = SERS;
                else
                    next_state = RESET;
            end
            SERS :
            begin
                if (~CTMOUTP_out)
                    if (DataLo == 16'hB0)
                        next_state = ESP;
                    else if (DataLo==16'h30)
                        next_state = SERS;
                    else
                        if (ULBYPASS)
                           next_state = PREL_ULBYPASS;
                        else
                           next_state = RESET;
            end
            SERS_EXEC :
            begin
                if (DataLo == 16'hB0 && BankERS[SB]==1'b1)
                    next_state = ESPS;
            end
            ESP :
            begin
                if ((DataLo == 16'h30) && (BankERS[SB] ==1))
                    next_state = SERS_EXEC;
                else if (PATTERN_1)
                    next_state = ESP_Z001;
                else if (DataLo==16'h98 && A_PAT_CFI)
                    next_state = CFI;
            end
            ESP_Z001 :
            begin
                if (PATTERN_2)
                    next_state = ESP_PREL;
                else
                    next_state = ESP;
            end
            ESP_PREL :
            begin
                if (A_PAT_1 && DataLo == 16'hA0)
                    next_state = A0SEEN;
                else if (A_PAT_1 && DataLo == 16'h90)
                    next_state = AS;
                else
                    next_state = ESP;
            end
            SLU_1:
            begin
                if (DataLo == 16'h60)
                    next_state = SLU_2;
                else
                    next_state = RESET;

            end
            SLU_2:
            begin
                if (DataLo == 16'h60)
                    next_state = SLU_3;
                else
                    next_state = RESET;

            end
            SLU_3:
            begin
                if (DataLo == 16'hF0)
                    next_state = RESET;
                else
                    next_state = SLU_3;
            end
            endcase
      end

    always @(posedge PDONE or negedge PERR)
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
           if (current_state==PGMS && ESP_ACT)
             begin
                next_state = ESP;
                BankPRG = -1;
             end
            else if (current_state==PGMS && ULBYPASS)
            begin
                next_state = PREL_ULBYPASS;
                BankPRG = -1;
            end
            else next_state = RESET;
        end
    end

    always @(posedge EDONE or negedge EERR)
    begin: StateGen3
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC))
                begin
                if (ULBYPASS==1'b0)
                   next_state = RESET;
                else
                   next_state = PREL_ULBYPASS;
                end
        end
    end

    always @(negedge WRITE or reseted)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
           if (current_state==SERS_EXEC &&
           ((WRITE==1'b0) && (EERR!=1'b1)) &&
           (DataLo==16'hB0) && (BankERS[SB]==1'b1))
            begin
                next_state = ESPS;
                ESUSP = 1'b1;
                ESUSP <= #1 1'b0;
                ESP_ACT =1'b1;
            end
        end
    end

    always @(posedge CTMOUTP_out or reseted)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==SERS) && (CTMOUTP_out))
                next_state = SERS_EXEC;
        end
    end

   always @(posedge START_out or reseted)
    begin: StateGen7
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if ((current_state==ESPS) && (START_out))
            begin
                next_state = ESP;
                ESP_ACT= 1'b1;
            end
    end

    //BURST READ DETECTION
    always @(negedge burst_rd or reseted)
    begin: StateGenB
        if (~burst_rd)
        begin
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
            A_PAT_CFI = (Addr % 16'h100 == 8'h55);
        end
        BURST_TR = 1'b0;
        SYNCREAD = 1'b0;
        if (reseted!=1'b1)
            next_state = current_state;
        else if (~burst_rd)
            case (current_state)
            RESET :
            begin
                BURST_TR = 1'b1;
            end

            PREL_ULBYPASS :
            begin
                BURST_TR = 1'b1;
            end

            CFI :
            begin
                SYNCREAD = 1'b1;
            end

            AS :
            begin
                if (BankAS != SB)
                    BURST_TR = 1'b1;
            end

            ERS :
            begin
                SYNCREAD = 1'b1;
            end

            SERS :
            begin
                if (BankERS[SB])
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            ESPS:
            begin
                if (BankERS[SB])
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            SERS_EXEC :
            begin
                if (BankERS[SB])
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            ESP :
            begin
                if ((ERS_QUEUE[SA])&&(BankERS[SB]))
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            PGMS :
            begin
                if ( BankPRG==SB )
                    SYNCREAD = 1'b1;
                else if ( ESP_ACT && ERS_QUEUE[SA])
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end
            endcase

            if ( BURST_TR )
            begin
                if (CFR[16:15] == 2'b0 )
                    READ_MODE = CONTINUOUS;
                else
                    READ_MODE = LINEAR;
                ReadINIT = 1'b0;
                #1 ReadINIT = 1'b1;
            end
            else if ( SYNCREAD )
            begin
                READ_MODE = SYNCR;
                ReadINIT = 1'b0;
                #2 ReadINIT = 1'b1;
            end
    end

    always @(negedge AVDNeg or posedge CENeg)
    begin
        if (READ_MODE != ASYNCR)
            READ_MODE = ASYNCR;
    end
    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge READ)
    begin
          ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end
    always @( oe or negedge burst_rd or negedge WRITE or reseted)
    begin
        if (~WRITE)
        begin
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end
        if (~burst_rd)
        begin
            BurstBorder = CFR[16:15]*8;
            if (CFR[16:15] == 2'b11)
                BurstBorder = 32;
            BurstAddr = Addr;
            BurstSect = SA;
            InitDelay = CFR[14:12] + 1;
            BoundDelay = 0;
            BusyDelay = 0;
            ODDADDR =  Addr % 2 ==1;
            ODDNEXT =0;
            noout = 0;
            LATCHED_3E_3F = (Addr % 16'h40==6'h3E)||(Addr % 16'h40==6'h3F);
            stall = 0;
            stall_a = 0;
            inc_a = 0;
            busy_stat= 0;
            CLK_PATH_EN =0;
        end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                ESP_ACT    = 1'b0;
                ULBYPASS   = 1'b0;
                AS_ACT     = 1'b0;
                CTMOUTP_in = 1'b0;
                START_in   = 1'b0;
                for (i=0;i<=SecNum;i=i+1)
                begin
                   ERS_QUEUE[i]=0;
                end
                for (i=0;i<=BankNum;i=i+1)
                begin
                  BankERS[i]=1'b0;
                end
                if (oe)
                begin
                    if (!SYNCH)
                        DataOut = RD_MEM(Mem[Addr]);
                    else
                        DataOut = RD_MEM(Mem[BurstAddr]);
                DOut_zd = DataOut;
                end
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                if (~WRITE)
                    if (A_PAT_1 && (DataLo==16'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==16'h90))
                    begin
                        BankAS = SB;
                        AS_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo == 16'hC0)
                    begin
                        Atmp = Addr;
                        CFR[19:12] = Atmp[19:12];
                    end
            end

            PREL_ULBYPASS :
            begin
                    DataOut = RD_MEM(Mem[Addr]);
                if (oe)
                begin
                    SyncData = DataOut;
                    DOut_zd = DataOut;
                end
            end

            CFI :
            begin
                DataOut = 0;
                if (((Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                ((Addr >= 16'h40) && (Addr <= 16'h50)) ||
                ((Addr >= 16'h57) && (Addr <= 16'h5B)))
                    DataOut = CFI_Vect[Addr];
                else
                begin
                    DataOut = 16'bz;
                    $display("Invalid CFI query address");
                end
                if (oe)
                begin
                    SyncData = DataOut;
                    DOut_zd = DataOut;
                end
            end

            AS :
            begin
              if(oe)
              begin
                if (SB == BankAS)
                begin
                    if ( Addr % 16 == 0)
                       DataOut= 16'h1;
                    else if(Addr % 16 == 1)
                       DataOut= 16'h227E;
                    else if(Addr % 16 == 16'h0E)
                       DataOut= 16'h2200;
                    else if(Addr % 16 == 16'h0F)
                       DataOut= 16'h2234;
                    else if (Addr % 16 == 2)
                    begin
                        DataOut = 0;
                        DataOut[0] = Prot[SA];
                    end
                    else
                        DataOut = 16'bz;
                end
                else if (ESP_ACT && ERS_QUEUE[SA])
                begin
                    Status[7] = 1'b1;
                    Status[5] = 1'b0;
                    Status[3] = 1'b0;
                    Status[2] = !(Status[2]); // toggle
                    DataOut[7:0] = Status;
                    DataOut[15:8]=8'bz;
                end
                else
                    DataOut = RD_MEM(Mem[Addr]);
                DOut_zd  = DataOut;
             end
             else if (~WRITE && DataLo==16'hF0)
             begin
                 BankAS= -1;
                 AS_ACT=1'b0;
             end
            end

            A0SEEN :
            begin
                if (~WRITE)
                begin
                    BankPRG =SB;
                    WrData = D_tmp;
                    WrAddr = Addr;
                    WrSec = SA;
                    temp = DataLo;
                    Status[7] = ~temp[7];
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                end
            end

            C8 :
            begin
            end

            C8_Z001 :
            begin
            end

            C8_PREL :
            begin
                if (~WRITE)
                    if (DataLo==16'h10)
                    begin
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ERES   = 1'b0;
                        ERS_QUEUE = ~(0);
                    end
                    else if (DataLo==16'h30)
                    begin
                        ERS_QUEUE = 0;
                        ERS_QUEUE[SA] = 1'b1;
                        BankERS[SB]=1'b1;
                        disable TCTMOUTPr;
                        CTMOUTP_in = 1'b0;
                        #1 CTMOUTP_in <= 1'b1;
                    end
            end

            ULBYPASS_C8 :
            begin
                if (~WRITE)
                    if (DataLo==16'h10)
                    begin
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ERES   = 1'b0;
                        ERS_QUEUE = ~(0);
                    end
                    else if (DataLo==16'h30)
                    begin
                        ERS_QUEUE = 0;
                        ERS_QUEUE[SA] = 1'b1;
                        BankERS[SB]=1'b1;
                        disable TCTMOUTPr;
                        CTMOUTP_in = 1'b0;
                        #1 CTMOUTP_in <= 1'b1;
                    end
            end

            ERS :
            begin
                if (oe)
                begin
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    Status[6] = ~Status[6]; //toggle
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                    DataOut[7:0] = Status;
                    DataOut[15:8]=8'bz;
                end
                if (oe)
                begin
                    SyncData = DataOut;
                    DOut_zd = DataOut;
                end
           end

           SERS :
           begin
               if (~CTMOUTP_out && ~WRITE)
                begin
                    if (DataLo == 16'hB0 && BankERS[SB])
                    begin
                        //need to start erase process prior to suspend
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP = 1'b1;
                        ESUSP <= #1 1'b0;
                        ESP_ACT =1'b1;
                        ERES   = 1'b0;
                        START_in = 1'b0;
                    end
                    else if (DataLo==16'h30)
                    begin
                        disable TCTMOUTPr;
                        CTMOUTP_in = 1'b0;
                        #1 CTMOUTP_in <= 1'b1;
                        ERS_QUEUE[SA] = 1'b1;
                        BankERS[SB]=1'b1;
                    end
                    else
                    begin
                       disable TCTMOUTPr;
                       CTMOUTP_in = 1'b0;
                    end
                end
                Status[7] = 1'b1;
                Status[3] = 1'b0;
                if ( BankERS[SB] )
                begin
                    DataOut[7:0] = Status;
                    DataOut[15:8]=8'bz;
                end
                else
                begin
                    DataOut = RD_MEM(Mem[Addr]);
                end
                if (oe)
                begin
                    SyncData = DataOut;
                    DOut_zd = DataOut;
                end
            end

        ESPS :
        begin
            if (oe)
            begin
                Status[6] = ~Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                if ( ERS_QUEUE[SA] == 1'b1)
                begin
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                end
                if ( BankERS[SB] )
                begin
                    DataOut[7:0] = Status;
                    DataOut[15:8]=8'bz;
                end
                else
                    DataOut = RD_MEM(Mem[Addr]);
            end
            if (oe)
            begin
                SyncData = DataOut;
                DOut_zd = DataOut;
            end
        end

        SERS_EXEC:
        begin
            if ( oe )
            begin
                if (BankERS[SB])
                begin
                    if (ERS_QUEUE[SA] == 1'b1)
                    begin
                        Status[7] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                    end
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    DataOut[7:0] = Status;
                    DataOut[15:8]=8'bz;
                end
                else
                    DataOut = RD_MEM(Mem[Addr]);
            end
            if (oe)
            begin
                SyncData = DataOut;
                DOut_zd = DataOut;
            end
            if (~WRITE && ~EDONE &&(EERR!=1'b1)&& DataLo==16'hB0 && BankERS[SB])
            begin
                START_in = 1'b1;
                ESUSP = 1'b1;
                ESUSP <= #1 1'b0;
                ESP_ACT =1'b1;
            end
        end

        ESP :
        begin
            if (~WRITE && DataLo == 16'h30 && BankERS[SB] )
            begin
                //resume erase
                ERES = 1'b1;
                ERES <= #1 1'b0;
                ESP_ACT = 1'b0;
            end
            if (oe)
            begin

                if ( ERS_QUEUE[SA] == 1'b1 )
                begin
                    Status[7] = 1'b1;
                    Status[5] = 1'b0;
                    Status[3] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                end
                if ( ERS_QUEUE[SA] != 1'b1 )
                    DataOut = RD_MEM(Mem[Addr]);
                else
                begin
                    DataOut[7:0] = Status;
                    DataOut[15:8]=8'bz;
                end
            end
            if (oe)
            begin
                SyncData = DataOut;
                DOut_zd = DataOut;
            end
        end

        ESP_Z001 :
        begin
        end

        ESP_PREL :
        begin
            if (~WRITE && A_PAT_1 &&DataLo == 16'h90 )
                BankAS = SB;
                AS_ACT = 1'b1;
        end

        PGMS :
        begin
            if (oe)
                begin
                    if (BankPRG == SB)
                    begin
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b0;
                    // Status(2) no toggle
                        if (ESP_ACT)
                          Status[2]=1'b1;
                        DataOut[7:0] = Status;
                        DataOut[15:8]=8'bz;
                    end
                    else if (ESP_ACT && ERS_QUEUE[SA] )
                    begin
                        Status[7] = 1'b1;
                        Status[5] = 1'b0;
                        Status[3] = 1'b0;
                        Status[2] = ~Status[2];
                        DataOut[7:0] = Status;
                        DataOut[15:8]=8'bz;
                    end
                    else
                        DataOut = RD_MEM(Mem[Addr]);
                end
                if (oe)
                begin
                    SyncData = DataOut;
                    DOut_zd = DataOut;
                end
        end

        SLU_1:
        begin
        end

        SLU_2:
        begin
            if (~WRITE)
            begin
                if (DataLo==16'h60)
                begin
                    secLU = SA;
                    tmp = Addr;
                    Lock = !tmp[6];
                end
            end
        end

        SLU_3:
        begin
            Prot[secLU] =Lock;
            if (~WRITE)
            begin
                if (DataLo==16'h60)
                begin
                    secLU = SA;
                    tmp = Addr;
                    Lock = !tmp[6];
                end
            end
        end

        endcase
        if (oe && READ_MODE != ASYNCR )
        begin
            DOut_temp = DOut_zd;
        end
    end
end

always @(EERR or EDONE or current_state)
begin : ERS2
integer i;
integer j;
integer SecErsLOW;
integer SecErsHIGH;
    if (current_state==ERS)
    begin
        if (EERR!=1'b1)
            if (~EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if (Prot[i]==1'b0
                    && ~(~WPNeg && (i==0 || i==1))
                    && ACC)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end
            if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if (Prot[i]==1'b0
                    && ~(~WPNeg && (i==0 || i==1))
                    && ACC)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = MaxData;

                end
    end
end

    always @(CTMOUTP_out or current_state)
    begin : SERS2
        if (current_state==SERS)
        begin
            if (CTMOUTP_out)
            begin
                CTMOUTP_in = 1'b0;
                START_in = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                ERES   = 1'b0;
            end
        end
    end

    always @(START_out or current_state)
    begin : ESPS2
        if (current_state==ESPS)
        begin
            if (START_out)
            begin
                ESP_ACT = 1'b1;
                START_in = 1'b0;
            end
        end
    end
    always @(posedge EDONE)
    begin
        BankERS = 0;
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
    integer SecErsLOW;
    integer SecErsHIGH;

        if (current_state==SERS_EXEC)
        begin
            if (EERR!=1'b1)
            begin
                if (~EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO(SecErsLOW,SecErsHIGH,i);
                        if (Prot[i]==1'b0
                        && ~(~WPNeg && (i==0 || i==1))
                        && ACC && ERS_QUEUE[i])
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = -1;
                    end

                if (EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO(SecErsLOW,SecErsHIGH,i);
                        if (Prot[i]==1'b0
                        && ~(~WPNeg && (i==0 || i==1))
                        && ACC && ERS_QUEUE[i])
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = MaxData;
                    end
                end
          end
    end

    always @(current_state or PDONE)
    begin: PGMS2
    integer i,j;
        if (current_state==PGMS)
        begin
            if (PERR!=1'b1)
            begin
                if (~PDONE)
                begin
                    new_int= WrData;
                    old_int=Mem[WrAddr];
                    if (new_int>-1)
                    begin
                        new_bit = new_int;
                        if (old_int>-1)
                        begin
                            old_bit = old_int;
                            for(j=0;j<=15;j=j+1)
                                if (~old_bit[j])
                                    new_bit[j]=1'b0;
                            new_int=new_bit;
                        end
                        WrData= new_int;
                    end
                    else
                        WrData = -1;
                    Mem[WrAddr] = -1;
                end
                else
                    Mem[WrAddr] = WrData;
            end
        end
    end

    always @(OENeg or CENeg or RESETNeg or RST )
    begin
        //Output Disable Control
        if (OENeg || CENeg || (~RESETNeg && ~RST))
        begin
             DOut_zd = 16'bZ;
             RDY_zd = 1'bz;
        end
    end

    always @(negedge CENeg or RDY_sync)
    begin
        if (~CENeg && RST && ~CFR[19])
            RDY_zd = RDY_sync;
        else
            RDY_zd = 1'bz;
    end

    // Hardware RESET cycle
    always @(negedge RST)
    begin
        if (~RESETNeg)
        begin
            ESP_ACT = 1'b0;
            AS_ACT = 1'b0;
            for (i=0;i<=SecNum;i=i+1)
            begin
              Prot[i]=1;
            end
            ULBYPASS = 1'b0;
            READ_MODE = ASYNCR;
            CFR[19:12] = 8'b11100101;
            BankERS = 4'b0000;
            BankPRG=-1;
            BankAS=-1;
        end
    end

    //Synchronous READ modes
    always @(posedge CLK_out or negedge ReadINIT)
    begin
        case ( READ_MODE )
            ASYNCR :
            begin
            end

            SYNCR :
            begin
                if ( InitDelay > 0 )
                begin
                    InitDelay = InitDelay - 1;
                    if (~CFR[18] && InitDelay == 1 )
                        RDY_sync = 1'b1;
                    else
                        RDY_sync = 1'b0;
                    if ( InitDelay == 0 )
                    begin
                        DOut_zd = SyncData;
                        RDY_sync = 1'b1;
                        CLK_PATH_EN = 1;
                    end
                end
            end

            LINEAR:
            begin
                // Linear Burst 8/16/32
                if ( InitDelay > 0 )
                begin
                    InitDelay = InitDelay - 1;
                    if (~CFR[18] && InitDelay == 1)
                        RDY_sync = 1'b1;
                    else
                        RDY_sync = 1'b0;
                    if (InitDelay == 0)
                        CLK_PATH_EN = 1;
                end
                if ( InitDelay == 0 && TIACC_out == 1'b1)
                begin
                    DOut_zd = RD_MEM(Mem[BurstAddr]);
                    RDY_sync = 1'b1;
                    BurstAddr = BurstAddr + 1;
                    if ( BurstAddr % BurstBorder == 0 )
                        BurstAddr = BurstAddr - BurstBorder;
                 end
               else if ( TIACC_out != 1'b1 && InitDelay == 0 )
                        RDY_sync = 1'b0;

            end

            CONTINUOUS :
            begin
            //Continuous Burst
                if ( InitDelay > 0 )
                begin
                    InitDelay = InitDelay - 1;
                    if (~CFR[18] && InitDelay == 1)
                        RDY_sync = 1'b1;
                    else
                        RDY_sync = 1'b0;
                    if (InitDelay == 0)
                        CLK_PATH_EN = 1;
                end
                else if ( BoundDelay > 0 )
                begin
                    ReadData = RD_MEM( Mem[BurstAddr]);
                    if (BoundDelay==3 || BoundDelay==2)
                    begin
                        BoundDelay = BoundDelay - 1;
                        RDY_sync = 1'b0;
                    end
                    else if (BoundDelay==1 && ODDADDR)
                    begin
                        ODDADDR= 0;
                        RDY_sync = 1'b0;
                    end
                    else
                    begin
                       if (BurstSect == SecNum)
                           BurstSect = 0;
                       else
                           BurstSect = BurstSect + 1;
                       if (BurstAddr== MaxLoc)
                           BurstAddr = 0;
                       else
                           BurstAddr = BurstAddr + 1;
                       stall_a =1;
                       if (!CFR[18])
                           noout = 1;
                       BoundDelay = BoundDelay - 1;
                    end
                    DOut_zd = ReadData;
                end
                else if (BusyDelay > 0)
                begin
                   if (BusyDelay ==4||BusyDelay ==3||BusyDelay ==2)
                   begin
                      RDY_sync = 1'b0;
                      BusyDelay = BusyDelay - 1;
                   end
                   else
                   begin
                      RDY_sync = ! CFR[18];
                      ReadData = CrossData;
                      BusyDelay= BusyDelay - 1;
                      busy_stat= 1;
                      if (BurstSect == SecNum)
                         BurstSect = 0;
                      else
                         BurstSect = BurstSect + 1;
                      if (BurstAddr== MaxLoc)
                         BurstAddr = 0;
                      else
                         BurstAddr = BurstAddr + 1;
                   end
                   DOut_zd = ReadData;
                end
               if (InitDelay == 0 && BoundDelay == 0 && BusyDelay == 0
                   && TIACC_out == 1'b1)
               begin
                  if (inc_a && cnt < 1)
                  begin
                      BurstAddr = BurstAddr + 1;
                      cnt = cnt+1;
                  end
                  if (! (busy_stat || noout))
                      ReadData = RD_MEM(Mem[BurstAddr]);
                  else
                      noout=0;
                  if ((BurstAddr % 7'h40 == 6'h3F)&& !LATCHED_3E_3F)
                      if( CFR[18]==1'b0)
                          RDY_sync = 1'b0;
                      else
                      begin
                          RDY_sync = 1'b1;
                          inc_a =0;
                      end
                  else if (BurstAddr % 7'h40== 6'h3E)
                      RDY_sync = 1'b1;
                  else if((BurstAddr % 5'h10 == 4'hF)&& !LATCHED_3E_3F)
                      if(ODDADDR)
                      begin
                          RDY_sync =(CFR[18]);
                          stall = 1;
                          ODDADDR=0;
                          ODDNEXT=1;
                      end
                      else if (ODDNEXT)
                      begin
                          RDY_sync =!(CFR[18]);
                          stall = 0;
                          ODDNEXT=0;
                      end
                      else
                      begin
                          stall=0;
                          RDY_sync = 1'b1;
                      end
                  else
                      RDY_sync = 1'b1;
                  //end
                  if(BurstAddr % 7'h40 == 6'h3F)
                  begin
                     tmp = BurstAddr;
                     CrossBank = (ReturnBankID(tmp)+1)% BankNum;
                     CrossSec  = (ReturnSectorID(tmp)+1)% SecNum;
                     BusyBOUND = 0;
                     BoundDelay= 0;
                     BusyDelay = 0;
                     if (CrossBank == BankAS && current_state==AS)
                     begin
                         CrossData = 1;
                         BusyBOUND = 1;
                     end
                     else if(CrossBank == BankPRG && current_state==PGMS)
                     begin
                         CrossData[7:0]= Status;
                         CrossData[15:8]=8'bz;
                         BusyBOUND = 1;
                     end
                     else if(BankERS[CrossBank]&&
                            (current_state==SERS ||
                             current_state==SERS_EXEC ||
                             current_state==ESPS))
                         begin
                         CrossData[7:0]= Status;
                         CrossData[15:8]=8'bz;
                         BusyBOUND = 1;
                         end
                     else if(ERS_QUEUE[CrossSec] &&
                           (current_state == ESP|| current_state == ESPS))
                     begin
                        CrossData[7:0]= Status;
                        CrossData[15:8]=8'bz;
                        BusyBOUND = 1;
                     end
                     else if(ERS_QUEUE[CrossSec] &&
                           (current_state == PGMS && ESP_ACT ))
                     begin
                        CrossData[7:0]= Status;
                        CrossData [7] = 1'b1;
                        CrossData[15:8]=8'bz;
                        BusyBOUND = 1;
                     end
                     if (BusyBOUND)
                        if (CFR[18])
                            BusyDelay = 4;
                        else
                            BusyDelay = 3;
                     else
                       if( !LATCHED_3E_3F )
                           if (CFR[18])
                               BoundDelay = 3;
                           else
                               BoundDelay = 2;
                       else
                       begin
                          LATCHED_3E_3F =0;
                          if (BurstSect == SecNum)
                              BurstSect = 0;
                          else
                               BurstSect= BurstSect + 1;
                          if (BurstAddr== MaxLoc)
                               BurstAddr = 0;
                          else
                               BurstAddr = BurstAddr + 1;
                       end
                   end
                   else
                      if (! stall && !stall_a && !busy_stat)
                          BurstAddr = BurstAddr + 1;
                      else
                      begin
                           if (CFR[18] && stall_a)
                           begin
                              inc_a = 1;
                              cnt =0;
                           end
                          stall_a = 0;
                      end
                   DOut_zd = ReadData;
                   if (TIACC_out == 1'b0 && InitDelay == 0)
                       RDY_sync = 1'b0;
             end
          end
       endcase
   end

 task ADDRHILO;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   SectorID;
 integer AddrLOW;
 integer AddrHIGH;
 integer SectorID;
 begin

  if    (SectorID <= 3)
  begin
     AddrLOW  = SectorID*20'h02000;
     AddrHIGH = SectorID*20'h02000 + 20'h01FFF;
  end
  else if ((SectorID > 3) && (SectorID < 66))
  begin
     AddrLOW  = (SectorID-3)*20'h08000;
     AddrHIGH = (SectorID-3)*20'h08000+20'h07FFF;
  end
  else
  begin
     AddrLOW  = 21'h1F8000 + (SectorID-66)*20'h02000;
     AddrHIGH = 21'h1F8000 + (SectorID-66)*20'h02000 + 20'h01FFF;
  end
 end
 endtask

 function[15:0] RD_MEM;
 input integer Data;
 begin
     if ( Data == -1 )
         RD_MEM = 16'bx;
     else

         RD_MEM = Data;
 end
 endfunction

 function integer ReturnSectorID;
 input [HiAddrBit:0] ADDR;
 integer conv;
 begin
     conv = ADDR / 16'h8000;
     if ( conv == 0 )
        ReturnSectorID = ADDR / 16'h2000;
     else if (( conv >= 1 ) && ( conv <= 62 ))
        ReturnSectorID = 3 + conv;
     else
        ReturnSectorID = 66 + (ADDR - 21'h1F8000)/16'h2000;
  end
  endfunction

 function integer ReturnBankID;
 input[HiAddrBit:0] ADDR;
 begin
      ReturnBankID = ADDR / 20'h80000;
 end
 endfunction

    reg  BuffInOE1, BuffInOE2, BuffInCE1, BuffInCE2,BuffInADDR;
    wire BuffOutOE1, BuffOutOE2, BuffOutCE1, BuffOutCE2,BuffOutADDR;

    BUFFER    BUFOE1   (BuffOutOE1, BuffInOE1);
    BUFFER    BUFOE2   (BuffOutOE2, BuffInOE2);
    BUFFER    BUFCE1  (BuffOutCE1, BuffInCE1);
    BUFFER    BUFCE2   (BuffOutCE2, BuffInCE2);
    BUFFER    BUFADDR (BuffOutADDR, BuffInADDR);
    initial
    begin
        BuffInOE1   = 1'b1;
        BuffInOE2   = 1'b1;
        BuffInCE1    = 1'b1;
        BuffInCE2    = 1'b1;
        BuffInADDR   = 1'b1;
    end

    always @(posedge BuffOutOE1)
    begin
        OEDQ_01 = $time;
    end

    always @(posedge BuffOutOE2)
    begin
        OEDQ_02 = $time;
    end

    always @(posedge BuffOutCE1)
    begin
        CEDQ_01 = $time;
    end

    always @(posedge BuffOutCE2)
    begin
        CEDQ_02 = $time;
    end

    always @(posedge BuffOutADDR)
    begin
        ADDRDQ_01 = $time;
    end

endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
