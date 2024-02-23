//////////////////////////////////////////////////////////////////////////////
//  File name : am29bds320g.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2003, 2004 Spansion, LLC.
//
//  MODifICATION HISTORY :
//
//  version:  | author:        |   date:   | changes made:
//    V0.1       A.Savic         03 Nov 13  Initial
//    V0.2       A.Savic         03 Dec 11  Burst Initial Access time update
//                                          Memory declaration
//                                          Timing Checks update
//                                          Bus cycle decode / access time
//    V0.3      A.Savic         03 Dec 16   Updated for NC Sim
//    V0.4      A.Savic         03 Dec 18   No bank restriction for Sector Erase
//                                          Erase Suspend / Resume refer to
//                                          all busy / suspended banks
//    V0.5      A.Savic         14 Jan 04   Specify block path expansion for
//                                          unique ModelSim/NCSim Verilog SDF
//    v0.6      A.Savic         16 Jan 04   Preload section update - sector
//                                          contents independent preload
//    v0.7      A.Savic         04 Feb 19   Memory wrap with busy sector check
//                                          HW RESET flag update
//                                          Erase suspended sector programming
//                                          restriciton
//                                          TimingChecks VHDL SetupLow,
//                                          SetupHigh, HoldLow, HoldHigh
//                                          equivalents added
//                                          Burst halt / latch close timing
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           AM29BDS320G
//
//  Description:   Description:   32 Megabit (2 M x 16-Bit) CMOS 1.8 Volt-only
//                 Simultaneous Read/Write, Burst Mode Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am29bds320g
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

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////

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
    reg START_T1    ; // Start TimeOut
    reg START_T1_in ;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset
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

    reg RY_zd;

    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter UserPreload     = 1'b0;
    parameter LongTiming = 1;
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID    = "AM29BDS320G";
    parameter MaxData   = 16'hFFFF;
    parameter SecSize   = 20'h7FFF;
    parameter SecNum    = 69;
    parameter HiAddrBit = 20;
    parameter ADDRRange = 21'h1FFFFF;


    parameter NO_SYNC             = 4'd0;
    parameter CONTINUOUS          = 4'd1;
    parameter LINEAR              = 4'd2;
    parameter SYNCR               = 4'd3;
    reg [2:0] READ_MODE;

    //varaibles to resolve if bottom or top architecture is used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ESP_ACT  ; ////Erase Suspend - Erase Suspend Program

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
    reg [SecNum:0] Ers_queue; // = SecNum'b0;

    //Command Register
    reg WRITE     = 1'b1;
    reg READ      = 1'b1;
    reg BURST     = 1'b1;
    reg ReadINIT  = 1'b1;

    reg BURST_TR;
    reg SYNCREAD;

    //Parameters of bank specific operations
    //Supports 4 (or less) bank architecture
    reg[1:0] BankID;
    reg[1:0] BankASEL;
    reg[1:0] BankPROGRAM;
    reg[1:0] BankUBPASS;
    reg[3:0] BankERASE;
    reg[1:0] BankSLOCK;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SA      = 0;
    integer SecLatched;        // 0 TO SecNum
    integer D_tmp; //0 TO MaxData;
    integer Addr;  //0 TO SecSize, Address within sector

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg OE_burst;
    reg RST ;
    reg reseted ;
    // active CLK edge detcetion
    reg CLKMerge;

    integer Mem[0:ADDRRange];
    reg[19:0] ConfReg;
    //Sector Protection Status
    integer WP1;
    integer WP2;//WP# protected depending on TimingModel
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;

    // timing check violation
    reg Viol = 1'b0;

    // StateTransition values
    reg R;
    reg E;
    //Bus Cycle Decode
    integer AddressLatched;
    integer AddrLO;
    integer AddrHI;
    reg READCYCLE;
    reg WRITECYCLE;
    reg LATCHED;
    //Functional
    integer CFI_array[8'h10:8'h5B];
    integer ASEL_array[8'h00:8'h0F];

    integer WData;
    integer WAddr;
    //Command Sequence detection
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_1    = 1'b0;
    reg oe = 1'b0;
    //Status reg.
    reg[15:0] Status = 16'b0;
    reg[15:0]  old_bit, new_bit;
    integer old_int, new_int;

    integer Data;
    reg[15:0] DOut_temp;
    reg RY_temp;
    integer ASELInd;
    reg[7:0] temp;
    reg[HiAddrBit:0] tmpA;
    integer tmpSect;
    reg ReadOK;
    reg RYData;
    reg[15:0] ReadData;
    integer DataLo;
    //Burst Params
    integer AddrLOW;
    integer AddrHIGH;
    integer AddrCHECK;
    integer BurstAddr;
    integer BurstSect;
    integer BurstBorder;
    integer WrapMax;
    reg[1:0] BankCHECK;
    integer SectorCHECK;
    reg BusyBOUND;
    reg[15:0] CrossData;
    //Burst latency values
    integer BusyDelay;
    integer BoundDelay;
    integer BurstDelay;
    integer PriorIACC;
    reg LATCHED_3E_3F;

    reg[15:0] OutputD;
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
   integer   OEDQ_01;
   integer   CEDQ_01;
   integer   ADDRDQ_01;
   integer   tpd_A1_DQ_tr01;
   integer   tpd_A2_DQ_tr01;

   //Disitguish Top/Bottom architecture
   reg Top;
   reg Standard;
   reg Reduced;
   reg VIO18;
   reg VIO3;

   reg[15:0] TempData;
   event oe_event;
   event MergeE;

   integer SectorA;
   integer SectorB;

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

    nmos   (RDY ,   RY_zd     , 1);
    wire deg;

 // Needed for TimingChecks
 // VHDL CheckEnable Equivalent
 wire SYNC;
 assign SYNC = ConfReg[19] == 1'b0;
 wire CheckDataWE;
 assign CheckDataWE = ~CENeg && OENeg && DIn != DOut_zd;
 wire CheckAddrWE;
 assign CheckAddrWE = ~AVDNeg && ~CENeg && OENeg;
 wire CLKPositive;
 assign CLKPositive = SYNC && ConfReg[17] === 1'b1 && ~AVDNeg;
 wire CLKNegative;
 assign CLKNegative = SYNC && ConfReg[17] === 1'b0 && ~AVDNeg;
 wire AVDCheckP;
 assign AVDCheckP   = SYNC && ConfReg[17] === 1'b1 && ~AVDNeg;
 wire AVDCheckN;
 assign AVDCheckN   = SYNC && ConfReg[17] === 1'b0 && ~AVDNeg;
 wire SYNCCLK;
 assign SYNCCLK = ((ConfReg[17] === 1'b0 && ~CLK) ||
                   (ConfReg[17] === 1'b1 && CLK)) &&
                   ConfReg[19] === 1'b0;

 wire ASYNCCLK;
 assign ASYNCCLK = ConfReg[19] == 1'b1;

 wire CLKPositive_CENeg_Low;
 assign CLKPositive_CENeg_Low = CLKPositive && ~CENeg;

 wire CLKNegative_CENeg_Low;
 assign CLKNegative_CENeg_Low = CLKNegative && ~CENeg;

 wire CENeg_Low;
 assign CENeg_Low = ~CENeg;

 wire AVDNeg_Low;
 assign AVDNeg_Low = ~AVDNeg;

 wire WENeg_High;
 assign WENeg_High = WENeg;

 wire OENeg_High;
 assign OENeg_High = OENeg;

 wire CENeg_High;
 assign CENeg_High = CENeg;

reg temp19 = ConfReg[19];
reg temp17 = ConfReg[17];

specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file
    // tpd delays
    specparam           tpd_A0_DQ0              =1;
    specparam           tpd_CENeg_DQ0           =1;
                      //(tCE,tCE,tDF,-,tDF,-)
    specparam           tpd_OENeg_DQ0           =1;
                      //(tOE,tOE,tDF,-,tDF,-)
    specparam           tpd_CLK_DQ0             =1;
    specparam           tpd_CLK_RDY             =1;
    // tsetup values: setup time
    specparam           tsetup_A0_CLK           =1;//tACS
    specparam           tsetup_A0_AVDNeg        =1;//tAAVDS,tAAS,/
    specparam           tsetup_A0_WENeg         =1;//tAS,\
    specparam           tsetup_DQ0_WENeg        =1;//tDS,/
    specparam           tsetup_CLK_WENegS       =1;//tCSW2
    specparam           tsetup_CLK_WENegA       =1;//tCSW1
    specparam           tsetup_AVDNeg_WENeg     =1;//tAVSW
    specparam           tsetup_CENeg_CLK        =1;//tCES
    specparam           tsetup_CENeg_AVDNeg     =1;//tCAS
    specparam           tsetup_AVDNeg_CLK       =1;//tAVC
    specparam           tsetup_CENeg_WENeg      =1;//tCS
    // thold values: hold times
    specparam           thold_A0_CLK             =1;//tACH
    specparam           thold_A0_AVDNeg          =1;//tAAVDH,tAAH,/
    specparam           thold_A0_WENeg           =1;//tAH,\
    specparam           thold_DQ0_WENeg          =1;//tDH /
    specparam           thold_CLK_WENeg          =1;//tCHW,\
    specparam           thold_AVDNeg_WENeg       =1;//tAVHC,\
    specparam           thold_OENeg_WENeg        =1;//tOEH,/
    specparam           thold_CENeg_WENeg        =1;//tCH,\
    specparam           thold_OENeg_RESETNeg     =1;//tOEH,/
    specparam           thold_CENeg_RESETNeg     =1;//tCH,\
    specparam           thold_WENeg_OENeg        =1;//tGHWL,/
    specparam           thold_AVDNeg_CLK         =1;//tAVHC
     // tpw values: pulse width
    specparam           tpw_RESETNeg_negedge     =1; //tRP
    specparam           tpw_WENeg_negedge        =1; //tWP
    specparam           tpw_WENeg_posedge        =1; //tWPH
    specparam           tpw_AVDNeg_negedge       =1; //tAVDP

    // tdevice values: values for internal delays
            //Program Operation
    specparam   tdevice_POW                      = 11500; //11.5 (typ) us;
          //Sector Erase Operation
    specparam   tdevice_SEO                      = 400000000; //400 ms;
//    specparam   tdevice_SEO                      = 40000; //40 us;
           //Timing Limit Exceeded
    specparam   tdevice_HANG                     = 400000000; //400 ms; //?
            //program/erase suspend timeout
    //specparam   tdevice_PSTART_T1              = 5000;  //5 us;
    specparam   tdevice_START_T1                 = 20000; //20 us;
           //sector erase command sequence timeout
    specparam   tdevice_CTMOUT                   = 50000; //50 us; (typ)
           //device ready after Hardware reset(during embeded algorithm)
    specparam   tdevice_READY                    = 20000; //20 us; //tReady (typ)

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
//for DQ signals
if (FROMCE)
        ( CENeg => DQ0 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ1 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ2 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ3 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ4 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ5 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ6 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ7 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ8 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ9 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ10 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ11 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ12 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ13 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ14 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ15 ) = tpd_CENeg_DQ0;


    if (FROMOE)
        ( OENeg => DQ0 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ1 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ2 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ3 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ4 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ5 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ6 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ7 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ8 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ9 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ10 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ11 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ12 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ13 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ14 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ15 ) = tpd_OENeg_DQ0;


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


    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ0 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ1 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ2 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ3 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ4 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ5 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ6 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ7 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ8 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ9 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ10 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ11 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ12 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ13 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ14 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg && ~OENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ15 ) = tpd_CLK_DQ0;

    if (FROMCE)
        (CENeg *> RDY) = tpd_CENeg_DQ0;
    if (FROMOE)
        (OENeg *> RDY ) = tpd_OENeg_DQ0;
    if ( temp19 == 1'b0 && ~OENeg &&
    (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
        ( CLK *>  RDY ) = tpd_CLK_RDY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

        $setup ( A0  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A1  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A2  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A3  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A4  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A5  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A6  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A7  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A8  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A9  , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A10 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A11 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A12 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A13 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A14 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A15 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A16 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A17 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A18 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A19 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A20 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);

        $setup ( A0  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A1  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A2  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A3  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A4  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A5  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A6  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A7  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A8  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A9  , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A10 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A11 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A12 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A13 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A14 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A15 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A16 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A17 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A18 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A19 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A20 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);

        $setup ( A0  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A1  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A2  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A3  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A4  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A5  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A6  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A7  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A8  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A9  , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A10 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A11 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A12 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A13 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A14 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A15 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A16 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A17 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A18 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A19 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A20 , posedge AVDNeg              ,  tsetup_A0_AVDNeg, Viol);

        $setup ( A0  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A1  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A2  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A3  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A4  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A5  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A6  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A7  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A8  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A9  , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A20 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);


        $setup ( DQ0  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9  , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 , posedge WENeg &&& CheckDataWE,  tsetup_DQ0_WENeg, Viol);

        $setup ( CLK    ,negedge WENeg &&&  SYNCCLK  ,  tsetup_CLK_WENegS  , Viol);
        $setup ( CLK    ,negedge WENeg &&&  ASYNCCLK ,  tsetup_CLK_WENegA  , Viol);
        $setup ( AVDNeg ,negedge WENeg &&&  AVDNeg_Low         ,  tsetup_AVDNeg_WENeg, Viol);
        $setup ( CENeg  ,posedge CLK &&& CLKPositive_CENeg_Low ,  tsetup_CENeg_CLK   , Viol);
        $setup ( CENeg  ,negedge CLK &&& CLKNegative_CENeg_Low ,  tsetup_CENeg_CLK   , Viol);
        $setup ( CENeg  ,negedge AVDNeg &&& CENeg_Low,  tsetup_CENeg_AVDNeg, Viol);
        $setup ( CENeg  ,negedge WENeg &&& CENeg_Low ,  tsetup_CENeg_WENeg , Viol);
        $setup ( AVDNeg ,negedge CLK &&& AVDCheckN   ,  tsetup_AVDNeg_CLK  , Viol);
        $setup ( AVDNeg ,posedge CLK &&& AVDCheckP   ,  tsetup_AVDNeg_CLK  , Viol);
        $hold ( negedge WENeg , CLK    , thold_CLK_WENeg, Viol);
        $hold ( negedge WENeg , AVDNeg &&& AVDNeg_Low  , thold_AVDNeg_WENeg, Viol);
        $hold ( posedge WENeg , OENeg &&& OENeg_High   , thold_OENeg_WENeg, Viol);
        $hold ( posedge WENeg , CENeg &&& CENeg_Low    , thold_CENeg_WENeg, Viol);
        $hold ( posedge OENeg , WENeg &&& WENeg_High   , thold_WENeg_OENeg, Viol);
        $hold ( negedge CLK &&& AVDCheckN, AVDNeg  , thold_AVDNeg_CLK, Viol);
        $hold ( posedge CLK &&& AVDCheckP, AVDNeg  , thold_AVDNeg_CLK, Viol);
        $hold ( posedge RESETNeg, CENeg &&& CENeg_High, thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg, OENeg &&& OENeg_High, thold_OENeg_RESETNeg, Viol);

        $hold ( posedge CLK &&& CLKPositive, A0 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A1 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A2 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A3 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A4 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A5 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A6 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A7 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A8 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A9 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A10 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A11 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A12 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A13 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A14 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A15 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A16 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A17 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A18 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A19 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A20 , thold_A0_CLK, Viol);

        $hold ( negedge CLK &&& CLKNegative, A0 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A1 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A2 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A3 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A4 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A5 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A6 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A7 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A8 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A9 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A10 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A11 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A12 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A13 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A14 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A15 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A16 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A17 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A18 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A19 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A20 , thold_A0_CLK, Viol);

        $hold ( posedge AVDNeg         , A0 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A1 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A2 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A3 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A4 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A5 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A6 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A7 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A8 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A9 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A10 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A11 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A12 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A13 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A14 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A15 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A16 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A17 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A18 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A19 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg         , A20 , thold_A0_AVDNeg, Viol);

        $hold ( negedge WENeg &&& CheckAddrWE, A0 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A1 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A2 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A3 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A4 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A5 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A6 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A7 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A8 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A9 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A10 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A11 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A12 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A13 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A14 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A15 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A16 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A17 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A18 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A19 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A20 , thold_A0_WENeg, Viol);

        $hold ( posedge WENeg &&& CheckDataWE, DQ0 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ1 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ2 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ3 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ4 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ5 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ6 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ7 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ8 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ9 ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ10 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ11 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ12 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ13 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ14 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckDataWE, DQ15 , thold_DQ0_WENeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (negedge AVDNeg  , tpw_AVDNeg_negedge);
        $width (posedge WENeg   , tpw_WENeg_posedge);
        $width (negedge WENeg   , tpw_WENeg_negedge);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET               =6'd0;
 parameter PREL_SLOCK          =6'd1;
 parameter SEC_LOCK            =6'd2;
 parameter Z001                =6'd3;
 parameter PREL_SETBWB         =6'd4;
 parameter PREL_ULBYPASS       =6'd5;
 parameter RES_ULBYPASS        =6'd6;
 parameter CFI                 =6'd7;
 parameter AS                  =6'd8;
 parameter A0SEEN              =6'd9;
 parameter C8                  =6'd10;
 parameter C8_Z001             =6'd11;
 parameter C8_PREL             =6'd12;
 parameter ERS                 =6'd13;
 parameter SERS                =6'd14;
 parameter ESPS                =6'd15;
 parameter SERS_EXEC           =6'd16;
 parameter ESP                 =6'd17;
 parameter ESP_Z001            =6'd18;
 parameter ESP_PREL            =6'd19;
 parameter ESP_CFI             =6'd20;
 parameter ESP_A0SEEN          =6'd21;
 parameter ESP_AS              =6'd22;
 parameter PGMS                =6'd23;

 parameter DBank               = 2'b00;
 parameter CBank               = 2'b01;
 parameter BBank               = 2'b10;
 parameter ABank               = 2'b11;

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
            CEDQ_t = CENeg_event  + CEDQ_01;
            OEDQ_t = OENeg_event  + OEDQ_01;
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

    // find which 4 sectors have variable size
    initial
    begin
    //TOP OR BOTTOM arch model is used
    //assumptions:
    //1. TimingModel has format as
    //"am29bds320gt"
    //it is important that 12-th character from first one is "t" or "b"
    //2. TimingModel does not have more  then 20 characters

    tmp_timing = TimingModel;//copy of TimingModel
    i = 19;
    while ((i >= 0) && (found != 1'b1))//search for first non null character
    begin                              //i keeps position of first non null character
        j = 7;
        while ((j >= 0) && (found != 1'b1))
        begin
            if (tmp_timing[i*8+j] != 1'd0)
                found = 1'b1;
            else
                j = j-1;
        end
        i = i - 1;
     end

     if (found)//if non null character is found
     begin
        for (j=0;j<=7;j=j+1)
         begin
        tmp_char[j] = TimingModel[(i-10)*8+j];//bottom/top character is 11
        end                                  //characters right from first ("a")
     end

    if (tmp_char == "T")
        begin
            WP1 = 68;
            WP2 = 69;
            Top = 1'b1;
        end
    else   // Bottom boot sector architecture
        begin
            WP1 = 0;
            WP2 = 1;
            Top = 1'b0;
        end
    if (found)//if non null character is found
     begin
        for (j=0;j<=7;j=j+1)
         begin
        tmp_char[j] = TimingModel[(i-12)*8+j];//bottom/top character is 13
        end                                  //characters right from first ("a")
     end
    if (tmp_char == "3")
    begin
        Reduced = 1'b1;
        Standard = 1'b0;
        VIO3    = 1'b1;
    end
    else if (tmp_char == "4")
    begin
        Standard = 1'b1;
        Reduced = 1'b0;
        VIO3     = 1'b1;
    end
    else if (tmp_char == "8")
    begin
        Reduced  = 1'b1;
        Standard = 1'b0;
        VIO18    = 1'b1;
    end
    else if (tmp_char == "9")
    begin
        Standard = 1'b1;
        Reduced = 1'b0;
        VIO18    = 1'b1;
    end
          // Bottom boot sector architecture

            CFI_array[8'h10] = 8'h51;
            CFI_array[8'h11] = 8'h52;
            CFI_array[8'h12] = 8'h59;
            CFI_array[8'h13] = 8'h02;
            CFI_array[8'h14] = 8'h00;
            CFI_array[8'h15] = 8'h40;
            CFI_array[8'h16] = 8'h00;
            CFI_array[8'h17] = 8'h00;
            CFI_array[8'h18] = 8'h00;
            CFI_array[8'h19] = 8'h00;
            CFI_array[8'h1A] = 8'h00;
            //system interface string
            CFI_array[8'h1B] = 8'h17;
            CFI_array[8'h1C] = 8'h19;
            CFI_array[8'h1D] = 8'h00;
            CFI_array[8'h1E] = 8'h00;
            CFI_array[8'h1F] = 8'h04;
            CFI_array[8'h20] = 8'h00;
            CFI_array[8'h21] = 8'h09;
            CFI_array[8'h22] = 8'h00;
            CFI_array[8'h23] = 8'h04;
            CFI_array[8'h24] = 8'h00;
            CFI_array[8'h25] = 8'h04;
            CFI_array[8'h26] = 8'h00;
            //device geometry definition
            CFI_array[8'h27] = 8'h16;
            CFI_array[8'h28] = 8'h01;
            CFI_array[8'h29] = 8'h00;
            CFI_array[8'h2A] = 8'h00;
            CFI_array[8'h2B] = 8'h00;
            CFI_array[8'h2C] = 8'h03;
            CFI_array[8'h2D] = 8'h03;
            CFI_array[8'h2E] = 8'h00;
            CFI_array[8'h2F] = 8'h04;
            CFI_array[8'h30] = 8'h00;
            CFI_array[8'h31] = 8'h3D;
            CFI_array[8'h32] = 8'h00;
            CFI_array[8'h33] = 8'h00;
            CFI_array[8'h34] = 8'h01;
            CFI_array[8'h35] = 8'h03;
            CFI_array[8'h36] = 8'h00;
            CFI_array[8'h37] = 8'h04;
            CFI_array[8'h38] = 8'h00;
            CFI_array[8'h39] = 8'h00;
            CFI_array[8'h3A] = 8'h00;
            CFI_array[8'h3B] = 8'h00;
            CFI_array[8'h3C] = 8'h00;
            //primary vendor-specific extended query
            CFI_array[8'h40] = 8'h50;
            CFI_array[8'h41] = 8'h52;
            CFI_array[8'h42] = 8'h49;
            CFI_array[8'h43] = 8'h31;
            CFI_array[8'h44] = 8'h33;
            CFI_array[8'h45] = 8'h04;
            CFI_array[8'h46] = 8'h02;
            CFI_array[8'h47] = 8'h01;
            CFI_array[8'h48] = 8'h00;
            CFI_array[8'h49] = 8'h05;
            CFI_array[8'h4A] = 8'h33;
            CFI_array[8'h4B] = 8'h01;
            CFI_array[8'h4C] = 8'h00;
            CFI_array[8'h4D] = 8'hB5;
            CFI_array[8'h4E] = 8'hC5;
            if (Top)
                CFI_array[8'h4F] = 8'h03;
            else
                CFI_array[8'h4F] = 8'h02;
            CFI_array[8'h50] = 8'h00;
            CFI_array[8'h57] = 8'h04;
            CFI_array[8'h58] = 8'h13;
            CFI_array[8'h59] = 8'h10;
            CFI_array[8'h5A] = 8'h10;
            CFI_array[8'h5B] = 8'h13;

            ASEL_array[8'h00] = 16'h0001;
            ASEL_array[8'h01] = 16'h227E;
            if (Standard) // TimingModel(14) = '9' OR TimingModel(14) = '4'
                // Standard Handshake
                ASEL_array[8'h03] = 16'h0042;
            else if (Reduced) //TimingModel(14) = '8' OR TimingModel(14) = '3'
                // Reduced Handshake
                ASEL_array[8'h03] = 16'h0043;
            if (VIO18) // TimingModel(14) = '8' OR  TimingModel(14) = '9'
            begin
                //1.8 V
                if (Top) // TimingModel(12) = 'T'
                    ASEL_array[8'h0E] = 16'h2222;
                else
                    ASEL_array[8'h0E] = 16'h2223;
            end
            else if (VIO3) //if TimingModel(14) = '4' OR  TimingModel(14) = '3'
                //3 V
                if (Top) // TimingModel(12) = 'T'
                    ASEL_array[8'h0E] = 16'h2214;
                else
                    ASEL_array[8'h0E] = 16'h2234;

            ASEL_array[8'h0F] = 16'h2200;
    end

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j;
    integer tmp1,tmp2,tmp3;
    integer sector_preload[0:SecSize];
    integer base;
    reg     sector_prot[0:SecNum];

        for (i=0;i<=ADDRRange;i=i+1)
        begin
            Mem[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
           sector_prot[i]=0;
        end
        if (UserPreload && !(prot_file_name == "none"))
        begin
           //am29bds320g_prot  sector protect file
           //   //      - comment
           //   @aaa    - <aaa> stands for sector address
           //   (aaaa is incremented at every load)
           //   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(prot_file_name == "none"))
        begin
        //am29bds320g memory preload file
        //  @aaaa   - <aaaa> stands for address within last defined sector
        //  dd      - <dd> is byte to be written at Mem(nn)(aaaa++)
        // (aaaa is incremented at every load)
        // preload sector 7 in bank A with recognizable data
        // for burst read mode testing
        // address range to be filled is 90h to FFh
        // Fill region near bank boundary B-->A with recognizable data
        // preload last sector in bank B (50) and first one in bank A (51)
        // for burst read mode with bank cross testing
        // address range to be filled is 16#7FF0# to 16#7FFF# for within
        // sector 50 and 16#00# to 16#6F# in sector 51
        // verify bank boundary read bahavior with crosses to busy and
        // non-busy bank
           $readmemh(mem_file_name,Mem);
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
             Ers_queue[i] = 0;
             Sec_Prot[i]  = ~sector_prot[i];
        end
        WData = 0;
        WAddr = -1;
    end

    //Power Up time 100 ns;
    initial
    begin
             PoweredUp = 1'b0;
             #100 PoweredUp = 1'b1;   //??????
    end

    always @(RESETNeg)
    begin
        RST <= #499 RESETNeg;
    end

    initial
    begin
        WRITE    = 1'b1;
        READ     = 1'b1;
        ReadINIT = 1'b1;
        BURST    = 1'b1;

        ULBYPASS = 1'b0;
        ESP_ACT  = 1'b0 ;

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
        OENeg_event = 0;
        CENeg_event = 0;

        READ_MODE = NO_SYNC;
        ConfReg[19:12] = 8'b11100101;
        BankERASE = 0;
    end

   always @(posedge START_T1_in)
   begin:TESTARTT1r
     #tdevice_START_T1 START_T1 = START_T1_in;
   end
   always @(negedge START_T1_in)
   begin:TESTARTT1f
     #1 START_T1 = START_T1_in;
   end

   always @(posedge CTMOUT_in)
   begin:TCTMOUTr
     #tdevice_CTMOUT CTMOUT = CTMOUT_in;
   end
   always @(negedge CTMOUT_in)
   begin:TCTMOUTf
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

   always @(posedge TIACC_in)
   begin : AccessTime
       if ( Reduced && (Addr % 2 == 0) )
           #(tpd_A2_DQ_tr01 - 1) TIACC_out = 1'b1;
       else
           #(tpd_A1_DQ_tr01 - 1) TIACC_out = 1'b1;
   end
   always @(negedge TIACC_in)
   begin
       disable AccessTime;
       TIACC_out = 1'b0;
   end
   ///////////////////////////////////////////////////////////////////////////
   ////     obtain 'LAST_EVENT information
   ///////////////////////////////////////////////////////////////////////////
    always @(negedge OENeg)
    begin
        OENeg_event = $time;
    end
    always @(negedge CENeg)
    begin
        CENeg_event = $time;
    end

    //////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    //////////////////////////////////////////////////////////////////////////
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
         READY or PoweredUp)// or PDONE or  EDONE
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

//    ////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    ////////////////////////////////////////////////////////////////////////
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
        if (ConfReg[17] == 1'b1)
            CLKMerge = CLK;
        else
            CLKMerge = ~CLK;
    end

//    ////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    ////////////////////////////////////////////////////////////////////////

    always @(posedge AVDNeg)
    begin
        if ( ~CENeg && WENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        // Synchronous AVD# rising edge address latch
        if ( gWE_n && ~gCE_n && ~LATCHED &&
        reseted==1'b1 && ConfReg[19] == 1'b0 )
        begin
           READCYCLE = 1'b1;
           LATCHED = 1'b1;
           AddressLatched = A;
           SecAddr = ReturnSectorID(AddressLatched);
           BankID = ReturnBank(AddressLatched);
           SecLatched = ReturnSectorID(AddressLatched);
           ADDRHILO(AddrLO, AddrHI, SecLatched);
           Addr =  AddressLatched - AddrLO;
           BurstDelay = 1;
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
        READCYCLE = 1'b0;
        WRITECYCLE = 1'b0;
        RY_temp = 1'b0;
        if ( ~CENeg && WENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
        end
    end

    always @(posedge CLKMerge)
    begin
        //Initiate READ (Burst mode)
       if ( READCYCLE &&
       reseted==1'b1 && ConfReg[19] == 1'b0 )
       begin
           READCYCLE = 1'b0;
           BURST = 1'b0;
           #1 BURST <= 1'b1;
       end
       // Synchronous CLK active edge address latch
       if ( gWE_n && ~gCE_n && ~AVDNeg && ~LATCHED &&
       reseted==1'b1 && ConfReg[19] == 1'b0 )
       begin
           READCYCLE = 1'b1;
           LATCHED = 1'b1;
           AddressLatched = A;
           SecAddr = ReturnSectorID(AddressLatched);
           BankID = ReturnBank(AddressLatched);
           SecLatched = ReturnSectorID(AddressLatched);
           ADDRHILO(AddrLO, AddrHI, SecLatched);
           Addr =  AddressLatched - AddrLO;
           BurstDelay =0;
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

    always @(A)
    begin
        if ( ~AVDNeg && ~CENeg && WENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        if ( WENeg && ~CENeg && ~OENeg && ~AVDNeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
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
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge CENeg)
    begin
        if ( WENeg && ~CENeg && ~OENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(posedge gWE_n)
    begin
        if ( RESETNeg != 1'b0 && ~gCE_n && OENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
        // WRITE operation
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
        // Synchronous WRITE operation data latch
        if ( ~gCE_n && WRITECYCLE && gOE_n && RESETNeg != 1'b0 &&
        reseted==1'b1 && ConfReg[19] == 1'b0 )
        begin
             WRITECYCLE = 1'b0;
             SecAddr = ReturnSectorID(AddressLatched);
             BankID = ReturnBank(AddressLatched);
             SecLatched = ReturnSectorID(AddressLatched);
             ADDRHILO(AddrLO, AddrHI, SecLatched);
             Addr =  AddressLatched - AddrLO;
             D_tmp = DIn[15:0];
             WRITE = 1'b0;
             #1 WRITE <= 1'b1;
        end
    end

    always @(posedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 && ~gWE_n && OENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
        // WRITE operation
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
        // Synchronous WRITE operation data latch
        if ( ~gWE_n && WRITECYCLE && gOE_n && RESETNeg != 1'b0 &&
        reseted==1'b1 && ConfReg[19] == 1'b0 )
        begin
             WRITECYCLE = 1'b0;
             SecAddr = ReturnSectorID(AddressLatched);
             BankID = ReturnBank(AddressLatched);
             SecLatched = ReturnSectorID(AddressLatched);
             ADDRHILO(AddrLO, AddrHI, SecLatched);
             Addr =  AddressLatched - AddrLO;
             D_tmp = DIn[15:0];
             WRITE = 1'b0;
             #1 WRITE <= 1'b1;
        end
    end
    always @(negedge gWE_n or negedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 &&
            ~gCE_n && ~gWE_n && OENeg && ~AVDNeg
            && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        if ( ~gCE_n && ~gWE_n && OENeg && READCYCLE &&
        reseted==1'b1 && ConfReg[19] == 1'b0 )
        begin
            READCYCLE = 1'b0;
            WRITECYCLE = 1'b1;
        end
    end

//    ////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
//    ////////////////////////////////////////////////////////////////////////

 time duration_write ;
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
                if (Sec_Prot[SA]
                    && (~Ers_queue[SA] || ~ESP_ACT )
                    && ACC
                    && ~(~WPNeg && (SA == WP1 || SA == WP2)))
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

//    ////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    ////////////////////////////////////////////////////////////////////////
 integer cnt_erase = 0;      // 0 - SecNum+SubSecNum
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
        if (reseted)
        begin
            if (ESTART && EDONE)
            begin
                cnt_erase = 0;
                for (i=0;i<=SecNum;i=i+1)
                    if ((Ers_queue[i]==1'b1)
                        && (Sec_Prot[i])
                        && ACC
                        && ~(~WPNeg && (i==WP1 || i==WP2)))
                            cnt_erase = cnt_erase + 1;

                if (cnt_erase>0)
                begin
                    elapsed_erase = 0;
                    duration_erase = cnt_erase* tdevice_SEO;
                    if ( LongTiming == 0 )
                        duration_erase = cnt_erase* tdevice_SEO/10000;
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

//    ////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    ////////////////////////////////////////////////////////////////////////

    //WRITE CYCLE
    always @(negedge WRITE or reseted)
    begin: StateGen1
        if (~WRITE)
        begin
            Data      = D_tmp;
            DataLo    = D_tmp % 12'h100;
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end
        BURST_TR = 1'b0;
        SYNCREAD = 1'b0;
        if (reseted!=1'b1)
            next_state = current_state;
        else if (~WRITE)
            case (current_state)
            RESET :
            begin
                if (PATTERN_1)
                    next_state = Z001;
                else if ((Addr % 12'h100 == 8'h55) && (DataLo==8'h98))
                    next_state = CFI;
                else if (DataLo == 8'h60)
                    next_state = PREL_SLOCK;
                else
                    next_state = RESET;
            end

            PREL_SLOCK :
            begin
                if (DataLo == 8'h60 && BankID == BankSLOCK)
                    next_state <= SEC_LOCK;
                else
                    next_state <= RESET;
            end

            SEC_LOCK :
            begin
                if (DataLo == 8'hF0)
                    next_state <= RESET;
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
                else if (A_PAT_1 && (DataLo==16'hC0))
                    next_state = RESET;
                else//?
                    next_state = RESET;
            end

            PREL_ULBYPASS :
            begin
                if (DataLo == 16'hA0)
                    next_state = A0SEEN;
                else if (DataLo == 16'h80)
                    next_state = C8_PREL;
                else if (DataLo == 16'h90 && BankID == BankUBPASS )
                    next_state <= RES_ULBYPASS;
                else
                    next_state = PREL_ULBYPASS;
            end

            RES_ULBYPASS :
            begin
               if (DataLo == 16'h00 )
                   next_state <= RESET;
               else
                   next_state <= PREL_ULBYPASS;
            end

            CFI :
            begin
                if (DataLo == 8'hF0)
                    next_state <= RESET;
                else
                    next_state <=  CFI;
            end

            AS :
            begin
                if (DataLo==16'hF0)
                    next_state = RESET;
                else
                    next_state = AS;
            end

            A0SEEN :
            begin
                if (~ULBYPASS)
                    next_state = PGMS;
                else
                    if ( BankID == BankUBPASS )
                        next_state = PGMS;
                    else
                        next_state = PREL_ULBYPASS;
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
                if ((A_PAT_1 || ULBYPASS) && (DataLo==16'h10))
                    next_state = ERS;
                else if (DataLo==16'h30 && ~(ULBYPASS && BankID != BankUBPASS))
                    next_state = SERS;
                else if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end

            ERS :
            begin
            end

            SERS :
            begin
                if (~CTMOUT)
                    if (DataLo == 16'hB0 && BusyBankE(BankID))
                        next_state = ESP; // ESP according to datasheet
                    else if (DataLo==16'h30)// && BankID == BankERASE)
                        next_state = SERS;
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
                    else
                        next_state = RESET;
            end

            ESPS:
            begin
            end

            SERS_EXEC :
            begin
                if ((EERR != 1'b1) && (DataLo == 8'hB0) && BusyBankE(BankID))
                    next_state = ESPS;
            end

            ESP :
            begin
                if (DataLo == 8'h30 && BusyBankE(BankID))
                    next_state = SERS_EXEC;
                else if (DataLo == 8'hA0 && ULBYPASS && BankID == BankUBPASS)
                    next_state = ESP_A0SEEN;
                else if ( Addr % 12'h100 == 8'h55 && DataLo == 8'h98 )
                    next_state <= ESP_CFI;
                else if (PATTERN_1)
                    next_state = ESP_Z001;
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
                    next_state = ESP_A0SEEN;
                else if (A_PAT_1 && DataLo == 16'h90)
                    next_state = ESP_AS;
                else
                    next_state = ESP;
            end

            ESP_CFI :
            begin
                if ( DataLo == 8'hF0 )
                    next_state <= ESP;
            end

            ESP_A0SEEN :
            begin
                if ( Ers_queue[SecAddr] != 1'b1 )
                    next_state = PGMS; //set ESP
            end

            ESP_AS :
            begin
                if (DataLo == 16'hF0)
                     next_state = ESP;
            end

            PGMS :
            begin
            end

            endcase
    end

    //BURST READ DETECTION
    always @(negedge BURST or reseted)
    begin: StateGenB
        if (~BURST)
        begin
            Data      = D_tmp;
            DataLo    = D_tmp % 12'h100;
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end
        BURST_TR = 1'b0;
        SYNCREAD = 1'b0;
        if (reseted!=1'b1)
            next_state = current_state;
        else if (~BURST)
            case (current_state)
            RESET :
            begin
                BURST_TR = 1'b1;
            end

            SEC_LOCK :
            begin
                if (BankID != BankSLOCK)
                    BURST_TR = 1'b1;
            end

            PREL_ULBYPASS :
            begin
                if (BankID != BankUBPASS)
                    BURST_TR = 1'b1;
            end

            CFI :
            begin
                SYNCREAD = 1'b1;
            end

            AS :
            begin
                if (BankID != BankASEL)
                    BURST_TR = 1'b1;
                else
                    SYNCREAD = 1'b1;
            end

            ERS :
            begin
                SYNCREAD = 1'b1;
            end

            SERS :
            begin
                if (BusyBankE(BankID))
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            ESPS:
            begin
                if (BusyBankE(BankID))
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            SERS_EXEC :
            begin
                if (BusyBankE(BankID))
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            ESP :
            begin
                if (BusyBankE(BankID) && Ers_queue[SecAddr])
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            ESP_CFI :
            begin
                SYNCREAD = 1'b1;
            end

            ESP_AS :
            begin
                if ( BankID == BankASEL )
                    SYNCREAD = 1'b1;
                else if ( BusyBankE(BankID) && BankID != BankASEL
                && Ers_queue[SecAddr] == 1'b1 )
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            PGMS :
            begin
                if ( BankID == BankPROGRAM )
                    SYNCREAD = 1'b1;
                else if ( BankID != BankPROGRAM && ESP_ACT &&
                BusyBankE(BankID) && Ers_queue[SecAddr] == 1'b1 )
                    SYNCREAD = 1'b1;
                else
                    BURST_TR = 1'b1;
            end

            endcase

            if ( BURST_TR )
            begin
                if (ConfReg[16:15] == 2'b0 )
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
    //Burst HALT
    always @(negedge AVDNeg or posedge CENeg)
    begin
        if (READ_MODE != NO_SYNC)
            READ_MODE = NO_SYNC;
    end

    always @(posedge PDONE or negedge PERR)
    begin: StateGen6 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                if (ESP_ACT)
                    next_state = ESP;
                else if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end
        end
    end

    always @(posedge EDONE or negedge EERR)
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC))
                if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
        end
    end

    always @(CTMOUT or reseted)
    begin: StateGen4 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS)
                if (CTMOUT === 1'b1)  next_state = SERS_EXEC;
        end
    end

    always @(posedge START_T1 or reseted)
    begin: StateGen5 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==ESPS)
                if (START_T1 === 1'b1) next_state = ESP;
    end

    always @(negedge READ or negedge BURST or negedge WRITE or reseted)
    begin
        if (~WRITE)
        begin
            Data      = D_tmp;
            DataLo    = D_tmp % 12'h100;
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end
        if (~BURST)
        begin
            BurstBorder = ConfReg[16:15]*8;
            if (ConfReg[16:15] == 2'b11)
                BurstBorder = 32;
            BurstAddr = Addr;
            BurstSect = SecAddr;
            BurstDelay = BurstDelay + ConfReg[14:12] + 1;
            RY_temp = 1'b0;
            if (ConfReg[16:15] == 2'b0)
            begin
                LATCHED_3E_3F = 1'b0;
                PriorIACC = 0;
                BusyDelay = 0;
                BoundDelay = 0;
                if (Reduced)
                begin
                    if ( BurstAddr % 8'h40 == 8'h3D )
                        PriorIACC = 1;
                    else if ( BurstAddr % 8'h40 == 8'h3E )
                    begin
                        PriorIACC = 2;
                        LATCHED_3E_3F = 1'b1;
                    end
                    else if ( BurstAddr % 8'h40 == 8'h3F )
                    begin
                        PriorIACC = 3;
                        LATCHED_3E_3F = 1'b1;
                    end
                    else if ( BurstAddr % 2 == 1 )
                        PriorIACC = 1;
                end
            end
            else
            begin
                WrapMax = 128;
                if ( (BurstAddr % 2 == 1 ) && Reduced )
                        BurstDelay = BurstDelay + 1;
            end
        end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                ESP_ACT = 1'b0;
                if (~READ)
                    DOut_zd = READMEM(SecAddr,Addr);
                else if (~WRITE && DataLo == 16'h60)
                    BankSLOCK = BankID;
            end

            PREL_SLOCK :
            begin
            end

            SEC_LOCK :
            begin
                if (~WRITE && BankID == BankSLOCK && DataLo == 16'h60 )
                begin
                    temp = Addr;
                    Sec_Prot[SecAddr] = temp[6];
                end
                if ( BankID == BankSLOCK )
                    OutputD = 16'bz;
                else
                    OutputD = READMEM(SecAddr,Addr);
                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                if (~WRITE)
                    if (A_PAT_1 && (DataLo==16'h20))
                    begin
                        ULBYPASS = 1'b1;
                        BankUBPASS = BankID;
                    end
                    else if (A_PAT_1 && (DataLo==16'h90))
                        BankASEL = BankID;
                    else if (A_PAT_1 && DataLo == 16'hC0)
                    begin
                        tmpSect = SecAddr;
                        ADDRHILO(AddrLOW, AddrHIGH, tmpSect);
                        tmpA = AddrLOW+Addr;
                        ConfReg[19:12] = tmpA[19:12];
                        if (ConfReg[14:12] == 2'b0)
                            ConfReg[18] = 1'b1;
                    end
            end

            PREL_ULBYPASS :
            begin
                if ( BankID == BankUBPASS )
                    OutputD = 16'bz;
                else
                    OutputD = READMEM(SecAddr,Addr);
                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
            end

            RES_ULBYPASS :
            begin
                if ((~WRITE) && (DataLo == 16'h00))
                    ULBYPASS = 1'b0;
            end

            CFI :
            begin
                OutputD = 0;
                if (((Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                ((Addr >= 16'h40) && (Addr <= 16'h50)) ||
                ((Addr >= 16'h57) && (Addr <= 16'h5B)))
                    OutputD[7:0] = CFI_array[Addr];
                else if (~READ)//|| ~BURST)
                    $display("Invalid CFI query address");

                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
            end

            AS :
            begin
                if ( BankID == BankASEL )
                begin
                    ASELInd = Addr % 16;
                    if ( ASELInd == 0 || ASELInd == 1 || ASELInd == 3
                    ||  ASELInd == 16'h0E || ASELInd == 16'h0F )
                        OutputD = ASEL_array[ASELInd];
                    else if (ASELInd == 2)
                    begin
                        OutputD = 0;
                        OutputD[0] = ~Sec_Prot[SecAddr];
                    end
                end
                else
                    OutputD = READMEM(SecAddr,Addr);
                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
            end

            A0SEEN :
            begin
                if (~WRITE && ~(ULBYPASS && BankID != BankUBPASS))
                begin
                    BankPROGRAM = BankID;
                    WData = D_tmp;
                    WAddr = Addr;
                    SA = SecAddr;
                    temp = Data % 12'h100;
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
                    if ((A_PAT_1 || ULBYPASS) && (DataLo==16'h10))
                    begin
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ERES   = 1'b0;
                        Ers_queue = ~(0);
                        Status = 16'b0000000000001000;
                    end
                    else if (DataLo==16'h30 &&
                    ~(ULBYPASS && BankID != BankUBPASS))
                    begin
                        //put selected sector to sec. ers. queue
                        //start timeout
                        //BankERASE = BankID;
                        BankE;
                        Ers_queue = 0;
                        Ers_queue[SecAddr] = 1'b1;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                    end
            end

            ERS :
            begin
                if (~READ)// || ~BURST)
                begin
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    Status[6] = ~Status[6]; //toggle
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                    OutputD = Status;
                end
                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
            end

            SERS :
            begin
                if (~CTMOUT && ~WRITE)
                begin
                    if (DataLo == 16'hB0 && BusyBankE(BankID))
                    begin
                        //need to start erase process prior to suspend
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP = 1'b1;
                        ESUSP <= #1 1'b0;
                        ERES   = 1'b0;
                        //suspend timeout (should be 0 according to datasheet)
                        START_T1_in = 1'b0;
                    end
                    else if (DataLo==16'h30)//&& BankID == BankERASE)
                    begin
                        BankE;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                        Ers_queue[SecAddr] = 1'b1;
                    end
                end
                Status[7] = 1'b1;
                Status[3] = 1'b0;
                if ( BusyBankE(BankID) )
                    OutputD = Status;
                else
                    OutputD = READMEM(SecAddr,Addr);
                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
            end

        ESPS :
        begin
            if (~READ)// || ~BURST )
            begin
                Status[6] = ~Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                if ( Ers_queue[SecAddr] == 1'b1)
                begin
                    Status[7] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                end
                if ( BusyBankE(BankID) )
                    OutputD = Status;
                else
                    OutputD = READMEM(SecAddr,Addr);
            end
            if (~READ)
            begin
                SyncData = OutputD;
                DOut_zd = OutputD;
            end
        end

        SERS_EXEC:
        begin
            if ( ~READ )// || ~BURST )
            begin
                if (Ers_queue[SecAddr]==1'b1)
                begin
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                end
                Status[6] = ~Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                if ( BusyBankE(BankID) )
                    OutputD = Status;
                else
                    OutputD = READMEM(SecAddr,Addr);
            end
            if (~READ)
            begin
                SyncData = OutputD;
                DOut_zd = OutputD;
            end
            if (~WRITE && ~EDONE && (EERR!=1'b1) && DataLo==16'hB0)
            begin
                START_T1_in = 1'b1;
                ESUSP = 1'b1;
                ESUSP <= #1 1'b0;
            end
        end

        ESP :
        begin
            if (~WRITE && DataLo == 16'h30 && BusyBankE(BankID) )
            begin
                //resume erase
                ERES = 1'b1;
                ERES <= #1 1'b0;
            end
            if (~READ) //|| ~BURST)
            begin
                Status[5] = 1'b0;
                if ( Ers_queue[SecAddr] == 1'b1 )
                begin
                    Status[7] = 1'b1;
                    Status[2] = ~Status[2]; //toggle
                end
                if ( Ers_queue[SecAddr] != 1'b1 )
                    OutputD = READMEM(SecAddr,Addr);
                else
                    OutputD = Status;
            end
            if (~READ)
            begin
                SyncData = OutputD;
                DOut_zd = OutputD;
            end
        end

        ESP_Z001 :
        begin
        end

        ESP_PREL :
        begin
            if (~WRITE && DataLo == 16'h90 )
                BankASEL = BankID;
        end

        ESP_CFI :
        begin
            OutputD = 0;
            if (((Addr >= 16'h10) && (Addr <= 16'h3C)) ||
            ((Addr >= 16'h40) && (Addr <= 16'h50)) ||
            ((Addr >= 16'h57) && (Addr <= 16'h5B)))
                OutputD[7:0] = CFI_array[Addr];
             else if (~READ)// || ~BURST)
                 $display("Invalid CFI query address");
             if (~READ)
             begin
                 SyncData = OutputD;
                 DOut_zd = OutputD;
             end
       end

        ESP_A0SEEN :
        begin
            if ((~WRITE) && Ers_queue[SecAddr] != 1'b1)
            begin
                ESP_ACT = 1'b1;
                //PSTART = '1', '0' AFTER 1 ns;
                PSTART = 1'b1;
                PSTART <= #1 1'b0;
                WData = D_tmp;
                WAddr = Addr;
                SA = SecAddr;
                temp = Data % 12'h100;
                Status[7] = ~temp[7];
                BankPROGRAM = BankID;
            end
        end

        ESP_AS :
        begin
            if ( BankID == BankASEL )
            begin
                ASELInd = Addr % 16;
                if ( ASELInd == 0 || ASELInd == 1 || ASELInd == 3
                ||  ASELInd == 16'h0E || ASELInd == 16'h0F )
                    OutputD = ASEL_array[ASELInd];
                else if ( ASELInd == 2 )
                begin
                    OutputD = 0;
                    OutputD[0] = ~Sec_Prot[SecAddr];
                end
            end
            else if ( BankID != BankASEL &&
            BusyBankE(BankID) && ( ~READ ) &&// || ~BURST) &&
            Ers_queue[SecAddr] == 1'b1 )
            begin
                Status[7] = 1'b1;
                Status[5] = 1'b0;
                Status[2] = ~Status[2]; //toggle
                OutputD = Status;
            end
            else
                OutputD = READMEM(SecAddr,Addr);
            if (~READ)
            begin
                SyncData = OutputD;
                DOut_zd = OutputD;
            end
        end

        PGMS :
        begin
                if (~READ)// || ~BURST)
                begin
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    // Status(2) no toggle
                    Status[1] = 1'b0;
                    if ( BankID == BankPROGRAM )
                        OutputD = Status;
                    else if ( BankID != BankPROGRAM && ESP_ACT &&
                    BusyBankE(BankID) && Ers_queue[SecAddr] )
                    begin
                        Status[2] = ~Status[2];
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM(SecAddr,Addr);
                end
                if (~READ)
                begin
                    SyncData = OutputD;
                    DOut_zd = OutputD;
                end
        end
        endcase
        if (~READ && READ_MODE != NO_SYNC )
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
                    if (Sec_Prot[i]!=1'b0
                    && ~(~WPNeg && (i==WP1 || i==WP2))
                    && ACC)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end
            if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if (Sec_Prot[i]!=1'b0
                    && ~(~WPNeg && (i==WP1 || i==WP2))
                    && ACC)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = MaxData;

                end
    end
end

    always @(CTMOUT or current_state)
    begin : SERS2
        if (current_state==SERS)
        begin
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                ERES   = 1'b0;
            end
        end
    end

    always @(START_T1 or current_state)
    begin : ESPS2
        if (current_state==ESPS)
        begin
            if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
            end
        end
    end
    always @(posedge EDONE)
    begin
        BankERASE = 0;
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
    integer SecErsLOW;
    integer SecErsHIGH;

        if (current_state==SERS_EXEC)
        begin//ja

            if (EERR!=1'b1)
            begin
                if (~EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO(SecErsLOW,SecErsHIGH,i);
                        if (Sec_Prot[i]!=1'b0
                        && ~(~WPNeg && (i==WP1 || i==WP2))
                        && ACC && Ers_queue[i])
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = -1;
                    end

                if (EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO(SecErsLOW,SecErsHIGH,i);
                        if (Sec_Prot[i]!=1'b0
                        && ~(~WPNeg && (i==WP1 || i==WP2))
                        && ACC && Ers_queue[i])
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = MaxData;
                    end
                end
          end
    end
//
    always @(current_state or PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
    integer SecProgLOW;
    integer SecProgHIGH;

        if (current_state==PGMS)
        begin
            ADDRHILO(SecProgLOW,SecProgHIGH,SA);
            if (PERR!=1'b1)
            begin
                if (~PDONE)
                begin
                    new_int= WData;
                    old_int=Mem[SecProgLOW+WAddr];
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
                        WData= new_int;
                    end
                    else
                        WData = -1;
                    Mem[SecProgLOW+WAddr] = -1;
                end
                else
                    Mem[SecProgLOW+WAddr] = WData;
            end
        end
    end

    always @(OENeg or CENeg or RESETNeg or RST )
    begin
        //Output Disable Control
        if (OENeg || CENeg || (~RESETNeg && ~RST))
        begin
             if (DOut_zd !== 1'bz)
             begin
                 DOut_temp = DOut_zd;
                 RY_temp = RY_zd;
             end
             DOut_zd = 16'bZ;
             RY_zd = 1'bz;
        end
    end
    // Hardware RESET cycle
    always @(negedge RST)
    begin
        if (~RESETNeg)
        begin
            ESP_ACT = 1'b0;
            ULBYPASS = 1'b0;
            READ_MODE = NO_SYNC;
            ConfReg[19:12] = 8'b11100101;
            BankERASE = 0;
        end
    end
    //SYNC mode
    always @(negedge CENeg or negedge OENeg)
    begin
        if (~CENeg && ~OENeg && gWE_n && RST && ~ConfReg[19])
        begin
            DOut_zd = DOut_temp;
            RY_zd = RY_temp;
        end
    end

    //Synchronous READ modes
    always @(posedge CLKMerge or negedge ReadINIT)
    begin
        case ( READ_MODE )
            LINEAR :
            begin
                // Linear Burst 8/16/32
                ReadOK = ~OE_burst && ~CENeg && WENeg;
                if ( BurstDelay > 0 )
                begin
                    // IND/WAIT# active one cycle before data
                    BurstDelay = BurstDelay - 1;
                    if (~ConfReg[18] && BurstDelay == 1)
                    begin
                        if ( ReadOK )
                            RY_zd = 1'b1;
                        else
                            RY_temp = 1'b1;
                    end
                    else
                    begin
                        if ( ReadOK )
                            RY_zd = 1'b0;
                        else
                            RY_temp = 1'b0;
                    end
                end
                if ( BurstDelay == 0 && WrapMax > 0 && TIACC_out == 1'b1)
                begin
                    WrapMax = WrapMax - 1;
                    ReadData = READMEM(BurstSect,BurstAddr);
                    RYData = 1'b1;
                    if ( ReadOK )
                    begin
                        DOut_zd = ReadData;
                        RY_zd = RYData;
                    end
                    else
                    begin
                        DOut_temp = ReadData;
                        RY_temp = RYData;
                    end
                    BurstAddr = BurstAddr + 1;
                    if ( BurstAddr % BurstBorder == 0 )
                        BurstAddr = BurstAddr - BurstBorder;
               end
               else if ( BurstDelay == 0 && WrapMax == 0 )
                    if ( ReadOK )
                        RY_zd = 1'b0;
                    else
                        RY_temp = 1'b0;

               if ( TIACC_out != 1'b1 )
                    if ( ReadOK )
                        RY_zd = 1'b0;
                    else
                        RY_temp = 1'b0;
            end

            CONTINUOUS :
            begin
            //Continuous Burst
                 ReadOK = ~OE_burst && ~CENeg && WENeg;
                    if ( PriorIACC > 0 )
                    begin
                        PriorIACC = PriorIACC -1 ;
                        if ( ReadOK )
                            RY_zd = 1'b0;
                        else
                            RY_temp = 1'b0;
                    end
                    else if ( BurstDelay > 0 )
                    begin
                        BurstDelay = BurstDelay - 1;
                        RYData = 1'b0;
                        if ( ~ConfReg[18] && BurstDelay == 1 )
                            RYData = 1'b1;
                        if ( ReadOK )
                            RY_zd = RYData;
                        else
                            RY_temp = RYData;
                    end
                    else if ( BoundDelay > 0 )
                    begin
                        BoundDelay = BoundDelay - 1;
                        if ( BusyDelay > 0 )
                            if (BoundDelay == 1)
                                RYData = ~ConfReg[18];
                            else
                                RYData = ConfReg[18];
                        else
                            if (BoundDelay == 2)
                                RYData = ~ConfReg[18];
                            else
                                RYData = 1'b1;
                        if ( ReadOK )
                            RY_zd = RYData;
                        else
                            RY_temp = RYData;
                    end
                    else if ( BusyDelay > 0 )
                    begin
                        if ( BusyDelay == 2 )
                        begin
                            BusyDelay = 1;
                            RYData = ~ConfReg[18];
                        end
                        else
                        begin
                            // No progress
                            RYData = 1'b1;
                            ReadData = CrossData;
                        end
                        if ( ReadOK )
                        begin
                            DOut_zd = ReadData;
                            RY_zd = RYData;
                        end
                        else
                        begin
                            DOut_temp = ReadData;
                            RY_temp = RYData;
                        end
                    end
                    if ( BurstDelay == 0 && BoundDelay == 0 && BusyDelay == 0
                    && TIACC_out == 1'b1)
                    begin
                        ReadData = READMEM(BurstSect,BurstAddr);
                        if (((BurstAddr % 8'h40 == 8'h3F) ||
                        (BurstAddr % 8'h40==8'h3E && ~ConfReg[18])) &&
                        Reduced && ~LATCHED_3E_3F )
                            RYData = 1'b0;
                        else
                            RYData = 1'b1;
                        if (BurstAddr % 8'h40 == 8'h3F)
                        begin
                            ADDRHILO(AddrLOW, AddrHIGH, BurstSect);
                            AddrCHECK = AddrLOW + BurstAddr;
                            //Bank Boundary Check
                            //Reduced Handshake devices
                            BankCHECK =
                            ReturnBank((AddrCHECK+1) % (ADDRRange+1));
                            SectorCHECK =
                            ReturnSectorID((AddrCHECK+1) % (ADDRRange+1));
                            BusyBOUND = 1'b0;
                            BoundDelay = 0;
                            BusyDelay = 0;
                            if (BankCHECK == BankASEL &&
                            (current_state==AS || current_state==ESP_AS))
                            begin
                                CrossData = ASEL_array[0];
                                BusyBOUND = 1'b1;
                            end
                            else if (BankCHECK==BankPROGRAM &&
                            current_state==PGMS)
                            begin
                                CrossData = Status;
                                BusyBOUND = 1'b1;
                            end
                            else if (BusyBankE(BankCHECK) &&
                            (current_state==SERS ||
                            current_state==SERS_EXEC ||
                            current_state==ESPS))
                            begin
                                CrossData = Status;
                                BusyBOUND = 1'b1;
                            end
                            else if (BankCHECK==BankUBPASS &&
                            current_state==PREL_ULBYPASS)
                            begin
                                CrossData = 16'bz;
                                BusyBOUND = 1'b1;
                            end
                            else if (BankCHECK==BankSLOCK &&
                            current_state == SEC_LOCK)
                            begin
                                CrossData = 16'bz;
                                BusyBOUND = 1'b1;
                            end
                            else if (Ers_queue[SectorCHECK] &&
                            (current_state == ESP || current_state == ESPS))
                            begin
                                CrossData = Status;
                                BusyBOUND = 1'b1;
                            end
                            else if (Ers_queue[SectorCHECK] &&
                            (current_state == PGMS && ESP_ACT))
                            begin
                                CrossData = Status;
                                CrossData[7] = 1'b1;
                                BusyBOUND = 1'b1;
                            end
                            if ( BusyBOUND &&
                            ReturnBank(AddrCHECK)!= BankCHECK )
                            begin
                                if ( ~LATCHED_3E_3F && Reduced )
                                    BoundDelay = 2;
                                BusyDelay = 2;
                            end
                            else if ( BusyBOUND &&
                            ReturnSectorID(AddrCHECK)!= SectorCHECK )
                            begin
                                if ( ~LATCHED_3E_3F && Reduced )
                                    BoundDelay = 2;
                                BusyDelay = 2;
                            end
                            else if ( ReturnBank(AddrCHECK)!= BankCHECK &&
                            ~LATCHED_3E_3F && Reduced )
                            begin
                            // Bank Boundary, NOT Program/Erase bank
                                BoundDelay = 3;
                                BusyDelay = 0;
                            end
                            else if (Reduced && ~LATCHED_3E_3F )
                            begin
                            // Reduced Hadshake devices
                            // 3F address boundary latency
                                BoundDelay = 3;
                                BusyDelay = 0;
                            end
                            //Sector Boundary Check
                            //Address Update
                            SectorA = ReturnSectorID(AddrCHECK);
                            SectorB = ReturnSectorID((AddrCHECK+1) % (ADDRRange+1));
                            if ( SectorA != SectorB )
                            begin
                                if ( BurstSect == SecNum )
                                    BurstSect = 0;
                                else
                                    BurstSect = BurstSect + 1;
                                BurstAddr = 0;
                            end
                            else
                                BurstAddr = BurstAddr + 1;
                            if ( LATCHED_3E_3F )
                               LATCHED_3E_3F = 1'b0;
                            if ( BoundDelay == 0 && BusyDelay > 0 && ~ConfReg[18] )
                                RYData = 1'b0;
                        end
                        else
                            BurstAddr = BurstAddr + 1;
                        if ( ReadOK )
                        begin
                            DOut_zd = ReadData;
                            RY_zd = RYData;
                        end
                        else
                        begin
                            DOut_temp = ReadData;
                            RY_temp = RYData;
                        end
                    end
                    if ( TIACC_out != 1'b1 )
                        if ( ReadOK )
                            RY_zd = 1'b0;
                        else
                            RY_temp = 1'b0;
                end

            SYNCR :
            begin
                // sync READ operation, does not iterate like BURST MODE
                // Data returned after initial delay
                    ReadOK = ~OE_burst && ~CENeg && WENeg;
                    if ( BurstDelay > 0 )
                    begin
                        BurstDelay = BurstDelay - 1;
                        if (~ConfReg[18] && BurstDelay == 1 )
                            if ( ReadOK )
                                RY_zd = 1'b1;
                            else
                                RY_temp = 1'b1;
                        else
                            if ( ReadOK )
                                RY_zd = 1'b0;
                            else
                                RY_temp = 1'b0;
                    end
                    if ( BurstDelay == 0 )
                        if ( ReadOK )
                        begin
                            DOut_zd = SyncData;
                            RY_zd = 1'b1;
                        end
                        else
                        begin
                            DOut_temp = SyncData;
                            RY_temp = 1'b1;
                        end
            end

            NO_SYNC :
            begin
            end

        endcase
    end

  function [6:0] ReturnSectorID;
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

 function[1:0] ReturnBank;
 input[HiAddrBit:0] ADDR;
 begin
     if  ( ADDR / 20'h80000 == 0 )
         ReturnBank = DBank;
     else if ( ADDR / 20'h80000 == 1 )
         ReturnBank = CBank;
     else if ( ADDR / 20'h80000 == 2 )
         ReturnBank = BBank;
     else if ( ADDR / 20'h80000 == 3 )
         ReturnBank = ABank;
 end
 endfunction

 function BusyBankE;
 input[1:0] BankNum;
 begin
     BusyBankE = ((BankNum == DBank) && BankERASE[0]) ||
                 ((BankNum == CBank) && BankERASE[1]) ||
                 ((BankNum == BBank) && BankERASE[2]) ||
                 ((BankNum == ABank) && BankERASE[3]);
 end
 endfunction

 task BankE;
 begin
     if ( BankID == DBank )
         BankERASE[0] = 1'b1;
     else if ( BankID == CBank )
         BankERASE[1] = 1'b1;
     else if ( BankID == BBank )
         BankERASE[2] = 1'b1;
     else//ABank
         BankERASE[3] = 1'b1;
 end
 endtask

 function[15:0] READMEM;
 input SecAddress;
 input Address;
 integer SecAddress;
 integer Address;
 integer AddrBASE;
 integer Data;
 begin
     if (SecAddress <= 3)
         AddrBASE  = SecAddress*20'h02000;
     else if ((SecAddress > 3) && (SecAddress < 66))
         AddrBASE  = (SecAddress-3)*20'h8000;
     else
         AddrBASE  = 21'h1F8000 + (SecAddress-66)*16'h02000;
     Data = Mem[AddrBASE+Address];
     if ( Data == -1 )
         READMEM = 16'bx;
     else
         READMEM = Data;
 end
 endfunction
 //SIM
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
     AddrHIGH = (SectorID-3)*20'h08000+16'h07FFF;
  end
  else
  begin
     AddrLOW  = 21'h1F8000 + (SectorID-66)*16'h02000;
     AddrHIGH = 21'h1F8000 + (SectorID-66)*16'h02000 + 16'h01FFF;
  end
 end
 endtask

    reg  BuffInOE, BuffInCE, BuffInADDR, BuffInOdd, BuffInEven;
    wire BuffOutOE, BuffOutCE, BuffOutADDR, BuffOutOdd, BuffOutEven;

    BUFFER    BUFOE          (BuffOutOE  , BuffInOE);
    BUFFER    BUFCE          (BuffOutCE  , BuffInCE);
    BUFFER    BUFADDR        (BuffOutADDR, BuffInADDR);
    BUFFER    BUFACCESS_ODD  (BuffOutOdd , BuffInOdd);
    BUFFER    BUFACCESS_EVEN (BuffOutEven, BuffInEven);

    initial
    begin
        BuffInOE    = 1'b1;
        BuffInCE    = 1'b1;
        BuffInADDR  = 1'b1;
        BuffInOdd   = 1'b1;
        BuffInEven  = 1'b1;
    end

    always @(posedge BuffOutOE)
    begin
        OEDQ_01 = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CEDQ_01 = $time;
    end
    always @(posedge BuffOutADDR)
    begin
        ADDRDQ_01 = $time;
    end
    always @(posedge BuffOutOdd)
    begin
        tpd_A1_DQ_tr01 = $time;
    end
    always @(posedge BuffOutEven)
    begin
        tpd_A2_DQ_tr01 = $time;
    end

endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
