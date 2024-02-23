//////////////////////////////////////////////////////////////////////////////
//  File name : s29pl032j.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODifICATION HISTORY :
//
//  version:   | author:     | mod date:   | changes made:
//    V1.0      A.Savic        04 Apr 02    Initial release
//
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           S29PL032J
//
//  Description:   32 Megabit (2 M x 16-Bit) CMOS 3 Volt-only
//                 Simultaneous Read/Write, Page Mode Flash Memory
//
//  Comment    :   CFI value for 45h address not yet defined ( TBD )
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module s29pl032j
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
    WPNeg    ,
    RESETNeg ,
    RY
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
    input  WPNeg    ;
    input  RESETNeg ;
    output RY       ;

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
    wire  WPNeg_ipd    ;
    wire  RESETNeg_ipd ;

//  internal delays

    reg START_T1      ; // Start TimeOut
    reg START_T1_in   ;
    reg CTMOUT        ; // Sector Erase TimeOut
    reg CTMOUT_in     ;
    reg READY         ; // Device ready after reset
    reg READY_in      ;
    reg PBPROG_out   ;// Protection Bit Program
    reg PBPROG_in    ;
    reg PBERASE_out  ;// Protection Bit Erase
    reg PBERASE_in   ;
    reg UNLOCKDONE_out;// Password Unlock
    reg UNLOCKDONE_in ;
    reg PASSPDONE_out ;// Password Program
    reg PASSPDONE_in  ;

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
    reg RY_zd1;

    parameter UserPreload     = 1'b0;
    parameter LongTiming      = 1'b1;
    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name = "none";
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID    = "S29PL032J";
    parameter MaxData   = 16'hFFFF;
    parameter SecSize   = 20'h7FFF;
    parameter SecNum    = 77;
    parameter GroupNum  = 35;
    parameter PageNum   = 26'h3FFFF;// 8W pages
    parameter SecSiSize = 127;
    parameter HiAddrBit = 20;
    parameter ADDRRange = 23'h1FFFFF;

    parameter OW = 8'b00011010;
    parameter PL = 8'b00001010;
    parameter SL = 8'b00010010;
    parameter WP = 8'b00000010;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ESP_ACT  ; ////Erase Suspend
    reg OTP_ACT  ; ////SecSi Enabled

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

    //Parameters of bank specific operations
    //Supports 4 (or less) bank architecture
    reg[1:0] BankID;
    reg[1:0] BankASEL;
    reg[1:0] BankPROGRAM;
    reg[1:0] BankUBPASS;
    reg[3:0] BankERASE;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SA      = 0;         // 0 TO SecNum
    integer D_tmp; //0 TO MaxData;
    integer Addr;  //0 TO SecSize, Address within sector
    integer SSWAddr;
    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer Mem[0:ADDRRange];
    integer SecSi[0:SecSiSize];
    //Sector Protection Status
    integer Password[0:3];
    reg[SecNum:0] DYB;
    reg[GroupNum:0] PPB;
    reg PPBLock;
    reg PPMLB;
    reg SPMLB;
    reg SSPB;
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
    integer SecLatched;

    //Command Sequence detection
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_1    = 1'b0;

    //Functional
    integer CFI_array[8'h10:8'h5B];
    integer ASEL_array[8'h00:8'h0F];
    reg[7:0] ASEL3;
    integer WData;
    integer WAddr;
    integer SecSiAddr;
    reg oe = 1'b0;
    //Status reg.
    reg[15:0] Status = 16'b0;
    reg[15:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer Data;
    integer ASELInd;
    reg[7:0] temp;
    reg[HiAddrBit:0] tmpA;
    integer AddrCFI;
    integer tmpSect;
    reg ReadOK;
    integer DataLo;
    //Burst Params
    integer AddrLOW;
    integer AddrHIGH;

    reg[15:0] OutputD;
    reg[15:0] SyncData;

    reg[11:0] SecTemp;
    reg[11:0] SecHlp;

    integer WAddrPass;
    reg[15:0] WDataPass;
    reg UnlockPass;
    integer PBSecAddr;

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
   integer   ADDRDQ_01_InitialPageAccess;
   integer   ADDRDQ_01_SubsequentPageAccess;
   reg InitialPageAccess;
   reg SubsequentPageAccess;
   integer   CurrentReadPage;
   integer   PreviousReadPage;

   reg[15:0] TempData;
   event oe_event;
   event MergeE;

   integer SectorA;
   integer SectorB;

   reg [5:0] current_state;
   reg [5:0] next_state;

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
    buf   (WPNeg_ipd    , WPNeg    );
    buf   (RESETNeg_ipd , RESETNeg );

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

     nmos   (RY    ,   1'b0     , ~RY_zd);
     //nmos   (RDY ,   RY_zd     , 1);
    wire deg;

    // Needed for TimingChecks
    // VHDL CheckEnable Equivalent
        wire tOEH_WE;
        assign tOEH_WE = OENeg && ~CENeg && ~RY_zd;
        wire tOEH_CE;
        assign tOEH_CE = OENeg && ~WENeg && ~RY_zd;

        wire OENeg_High;
        assign OENeg_High = OENeg;
        wire CENeg_High;
        assign CENeg_High = CENeg;

        wire CheckAddrWE;
        assign CheckAddrWE = ~CENeg && OENeg;
        wire CheckAddrCE;
        assign CheckAddrCE = ~WENeg && OENeg;

        wire tASO_Toggle_OE;
        assign tASO_Toggle_OE = ~CENeg && WENeg && ~RY_zd;
        wire tASO_Toggle_CE;
        assign tASO_Toggle_CE = ~OENeg && WENeg && ~RY_zd;

        wire CheckDataWE;
        assign CheckDataWE = ~CENeg && OENeg && DIn != DOut_zd;
        wire CheckDataCE;
        assign CheckDataCE = ~WENeg && OENeg && DIn != DOut_zd;

        wire ChecktOEPH;
        assign ChecktOEPH = ~CENeg && WENeg && ~RY_zd;

        wire tGHWL_WE;
        assign tGHWL_WE = OENeg && ~CENeg;
        wire tGHWL_CE;
        assign tGHWL_CE = OENeg && ~WENeg;

        wire CENeg_Low;
        assign CENeg_Low = ~CENeg;

        wire WENeg_High;
        assign WENeg_High = WENeg;

        wire WENeg_Low;
        assign WENeg_Low = ~WENeg;

specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

        // tpd delays
    specparam        tpd_A0_DQ0           = 1;//tACC
    specparam        tpd_CENeg_DQ0        = 1;//tCE
    specparam        tpd_OENeg_DQ0        = 1;//tOE
    specparam        tpd_WENeg_RDY        = 1;//tOE
    specparam        tpd_CENeg_RDY        = 1;//tOE

    //tsetup values
    specparam        tsetup_A0_WENeg      = 1;//tAS,\
    specparam        tsetup_A0_CENeg      = 1;//tAS,\
    specparam        tsetup_DQ0_WENeg     = 1;//tDS,/
    specparam        tsetup_DQ0_CENeg     = 1;//tDS,/
    specparam        tsetup_CENeg_WENeg   = 1;//tCS
    specparam        tsetup_OENeg_WENeg   = 1;
    specparam        tsetup_A0_OENeg      = 1;//tAS0
    //thold values
    specparam        thold_OENeg_RESETNeg = 1;//tRH,/
    specparam        thold_CENeg_RESETNeg = 1;//tRH,/
    specparam        thold_A0_WENeg       = 1;//tAH,\
    specparam        thold_A0_CENeg       = 1;//tAH,\
    specparam        thold_DQ0_WENeg      = 1;//tDH /
    specparam        thold_DQ0_CENeg      = 1;//tDH /
    specparam        thold_WENeg_OENeg    = 1;//tGHWL,/
    specparam        thold_OENeg_WENeg    = 1;//tOEH
    specparam        thold_CENeg_WENeg    = 1;//tCH,\
    specparam        thold_A0_OENeg       = 1;//tAHT
    //tpw values
    specparam        tpw_WENeg_negedge    = 1; //tWP
    specparam        tpw_WENeg_posedge    = 1; //tWPH
    specparam        tpw_OENeg_posedge    = 1; //tOEPH
    specparam        tpw_RESETNeg_negedge = 1; //tRP

    //tdevice values: values for internal delays
    specparam        tdevice_POW          = 6000;
    //Sector Erase Operation    tWHWH2
    specparam        tdevice_SEO          = 500000000;
    //program/erase suspend timeout
    specparam        tdevice_START_T1     = 20000;
    //sector erase command sequence timeout
    specparam        tdevice_CTMOUT       = 50000;
    //device ready after Hardware reset(during embeded algorithm)
    specparam        tdevice_READY        = 20000; //tReady
    // Protection Bit Program
    specparam        tdevice_PROTP        = 100000;
    // Protection Bit Erase
    specparam        tdevice_PROTE        = 1200000;
    // Password Unlock
    specparam        tdevice_UNLOCK       = 2000;

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

    // Data ouptut paths
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

    if (InitialPageAccess)
        ( A0 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A0 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A1 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A2 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A3 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A4 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A5 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A6 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A7 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A8 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A9 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A10 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A11 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A12 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A13 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A14 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A15 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A16 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A17 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A18 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A19 => DQ15 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ0 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ1 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ2 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ3 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ4 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ5 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ6 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ7 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ8 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ9 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ10 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ11 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ12 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ13 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ14 ) = tpd_A0_DQ0;
    if (InitialPageAccess)
        ( A20 => DQ15 ) = tpd_A0_DQ0;


    if (SubsequentPageAccess)
        ( A0 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A0 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A1 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A2 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A3 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A4 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A5 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A6 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A7 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A8 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A9 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A10 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A11 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A12 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A13 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A14 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A15 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A16 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A17 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A18 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A19 => DQ15 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ0 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ1 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ2 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ3 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ4 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ5 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ6 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ7 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ8 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ9 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ10 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ11 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ12 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ13 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ14 ) = tpd_A0_DQ0;
    if (SubsequentPageAccess)
        ( A20 => DQ15 ) = tpd_A0_DQ0;

// RDY output paths
 (CENeg *> RY) = tpd_CENeg_RDY;
 (WENeg *> RY) = tpd_CENeg_RDY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

        // OE# hold HIGH time after WE# rising edge
        // tOEH
        $hold ( posedge WENeg &&& tOEH_WE, OENeg   ,  thold_OENeg_WENeg, Viol);
        // Alternate CE# control
        $hold ( posedge CENeg &&& tOEH_CE, OENeg   ,  thold_OENeg_WENeg, Viol);

        // OE# hold HIGH time after RESET rising edge
        // tRH
        $hold ( posedge RESETNeg &&& OENeg_High, OENeg , thold_OENeg_RESETNeg, Viol);
        // CE# hold HIGH time after RESET rising edge
        // tRH
        $hold ( posedge RESETNeg &&& CENeg_High, CENeg , thold_CENeg_RESETNeg, Viol);

        // tRP
        $width (negedge RESETNeg, tpw_RESETNeg_negedge);

        // Setup/Hold Check between A and WENeg falling edge
        // tAS, tAH
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
        // Alternate CE# control
        $setup ( A0  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A1  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A2  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A3  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A4  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A5  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A6  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A7  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A8  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A9  , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A10 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A11 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A12 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A13 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A14 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A15 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A16 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A17 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A18 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A19 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A20 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A0 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A1 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A2 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A3 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A4 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A5 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A6 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A7 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A8 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A9 ,  thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A10 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A11 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A12 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A13 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A14 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A15 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A16 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A17 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A18 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A19 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A20 , thold_A0_CENeg, Viol);

        // Setup/Hold Check between A and OENeg falling edge
        // tASO, while reading toggle information
        $setup ( A0  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A1  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A2  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A3  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A4  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A5  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A6  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A7  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A8  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A9  , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A10 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A11 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A12 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A13 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A14 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A15 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A16 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A17 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A18 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A19 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $setup ( A20 , negedge OENeg &&& tASO_Toggle_OE, tsetup_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A0 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A1 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A2 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A3 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A4 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A5 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A6 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A7 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A8 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A9 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A10 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A11 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A12 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A13 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A14 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A15 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A16 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A17 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A18 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A19 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& tASO_Toggle_OE, A20 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A0 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A1 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A2 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A3 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A4 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A5 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A6 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A7 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A8 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A9 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A10 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A11 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A12 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A13 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A14 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A15 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A16 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A17 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A18 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A19 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& tASO_Toggle_CE, A20 , thold_A0_OENeg, Viol);

        // Setup/Hold Check between DATA and WENeg rising edge
        // tDS, tDH
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

        // Alternate CE# control
        $setup ( DQ0  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ8  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ9  , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ10 , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ11 , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ12 , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ13 , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ14 , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ15 , posedge CENeg &&& CheckDataCE,  tsetup_DQ0_CENeg, Viol);

        $hold ( posedge CENeg &&& CheckDataCE, DQ0 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ1 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ2 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ3 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ4 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ5 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ6 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ7 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ8 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ9 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ10 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ11 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ12 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ13 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ14 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& CheckDataCE, DQ15 , thold_DQ0_CENeg, Viol);

        // tOEPH
        $width (posedge OENeg &&& ChecktOEPH, tpw_OENeg_posedge);

        // OE# setup HIGH time before WE# falling edge
        // tGHWL
        $setup ( OENeg  ,negedge WENeg &&& tGHWL_WE ,  tsetup_OENeg_WENeg , Viol);
        // Alternate CE# control
        $setup ( OENeg  ,negedge CENeg &&& tGHWL_CE ,  tsetup_OENeg_WENeg , Viol);

        // CE# setup LOW time before WE# falling edge
        // tCS
        $setup ( CENeg  ,negedge WENeg &&& CENeg_Low ,  tsetup_CENeg_WENeg , Viol);
        // Alternate CE# control
        $setup ( WENeg  ,negedge CENeg &&& WENeg_Low ,  tsetup_CENeg_WENeg , Viol);
        // CE# hold LOW time after WE# rising edge
        // tCH
        $hold ( posedge WENeg &&& CENeg_Low, CENeg   ,  thold_CENeg_WENeg, Viol);
        // Alternate CE# control
        $hold ( posedge CENeg &&& WENeg_Low, WENeg   ,  thold_CENeg_WENeg, Viol);

        // Pulse width checks
        // tWP, tWPH
        $width (posedge WENeg &&& ~CENeg  , tpw_WENeg_posedge);
        $width (negedge WENeg &&& ~CENeg  , tpw_WENeg_negedge);
        // Alternate CE# control
        $width (posedge CENeg &&& ~WENeg  , tpw_WENeg_posedge);
        $width (negedge CENeg &&& ~WENeg  , tpw_WENeg_negedge);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET               =6'd0;
 parameter Z001                =6'd1;
 parameter PREL_SETBWB         =6'd2;
 parameter PREL_ULBYPASS       =6'd3;
 parameter RES_ULBYPASS        =6'd4;
 parameter CFI                 =6'd5;
 parameter UBP_CFI             =6'd6;
 parameter AS                  =6'd7;
 parameter A0SEEN              =6'd8;
 parameter C8                  =6'd9;
 parameter C8_Z001             =6'd10;
 parameter C8_PREL             =6'd11;
 parameter ERS                 =6'd12;
 parameter SERS                =6'd13;
 parameter ESPS                =6'd14;
 parameter SERS_EXEC           =6'd15;
 parameter ESP                 =6'd16;
 parameter ESP_Z001            =6'd17;
 parameter ESP_PREL            =6'd18;
 parameter ESP_CFI             =6'd19;
 parameter ESP_A0SEEN          =6'd20;
 parameter ESP_AS              =6'd21;
 parameter PGMS                =6'd22;
 parameter PASSPROG_PREL       =6'd23;
 parameter PASSPROG            =6'd24;
 parameter PASSUNLOCK0         =6'd25;
 parameter PASSUNLOCK1         =6'd26;
 parameter PASSUNLOCK2         =6'd27;
 parameter PASSUNLOCK3         =6'd28;
 parameter PASSUNLOCK          =6'd29;
 parameter PROTBIT_PREL        =6'd30;
 parameter PPBDYB              =6'd31;
 parameter DYBWE               =6'd32;
 parameter PPB_PROGRAM         =6'd33;
 parameter PPB_VERIFY          =6'd34;
 parameter PPB_ERASE           =6'd35;
 parameter PPMLB_PROGRAM       =6'd36;
 parameter SPMLB_PROGRAM       =6'd37;
 parameter SSPB_PROGRAM        =6'd38;
 parameter PPMLB_VERIFY        =6'd39;
 parameter SPMLB_VERIFY        =6'd40;
 parameter SSPB_VERIFY         =6'd41;
 parameter OTP                 =6'd42;
 parameter OTP_Z001            =6'd43;
 parameter OTP_PREL            =6'd44;
 parameter OTP_AS              =6'd45;
 parameter OTP_A0SEEN          =6'd46;
 parameter PASSVERIFY          =6'd47;

 parameter DBank               = 2'b11;
 parameter CBank               = 2'b10;
 parameter BBank               = 2'b01;
 parameter ABank               = 2'b00;

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
            ADDRDQ_t = ADDR_event + ADDRDQ_01_InitialPageAccess;
            if ( SubsequentPageAccess )
                ADDRDQ_t = ADDR_event + ADDRDQ_01_SubsequentPageAccess;

            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t > CEDQ_t) && ( OEDQ_t >= $time));
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t)&&FROMOE) ||
              ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                $display( " Read before tACC from address change. ");
                TempData = DOut_zd;
                DOut_Pass = 16'bx;
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

            CFI_array[16'h10] = 16'h51;
            CFI_array[16'h11] = 16'h52;
            CFI_array[16'h12] = 16'h59;
            CFI_array[16'h13] = 16'h02;
            CFI_array[16'h14] = 16'h00;
            CFI_array[16'h15] = 16'h40;
            CFI_array[16'h16] = 16'h00;
            CFI_array[16'h17] = 16'h00;
            CFI_array[16'h18] = 16'h00;
            CFI_array[16'h19] = 16'h00;
            CFI_array[16'h1A] = 16'h00;
           //System interface string
            CFI_array[16'h1B] = 16'h27;
            CFI_array[16'h1C] = 16'h36;
            CFI_array[16'h1D] = 16'h00;
            CFI_array[16'h1E] = 16'h00;
            CFI_array[16'h1F] = 16'h03;
            CFI_array[16'h20] = 16'h00;
            CFI_array[16'h21] = 16'h09;
            CFI_array[16'h22] = 16'h00;
            CFI_array[16'h23] = 16'h04;
            CFI_array[16'h24] = 16'h00;
            CFI_array[16'h25] = 16'h04;
            CFI_array[16'h26] = 16'h00;
            CFI_array[16'h27] = 16'h16;
            CFI_array[16'h28] = 16'h01;
            CFI_array[16'h29] = 16'h00;
            CFI_array[16'h2A] = 16'h00;
            CFI_array[16'h2B] = 16'h00;
            CFI_array[16'h2C] = 16'h03;
            CFI_array[16'h2D] = 16'h07;
            CFI_array[16'h2E] = 16'h00;
            CFI_array[16'h2F] = 16'h20;
            CFI_array[16'h30] = 16'h00;
            CFI_array[16'h31] = 16'h3D;
            CFI_array[16'h32] = 16'h00;
            CFI_array[16'h33] = 16'h00;
            CFI_array[16'h34] = 16'h01;
            CFI_array[16'h35] = 16'h07;
            CFI_array[16'h36] = 16'h00;
            CFI_array[16'h37] = 16'h20;
            CFI_array[16'h38] = 16'h00;
            CFI_array[16'h39] = 16'h00;
            CFI_array[16'h3A] = 16'h00;
            CFI_array[16'h3B] = 16'h00;
            CFI_array[16'h3C] = 16'h00;
           //primary vendor-specific extended query
            CFI_array[16'h40] = 16'h50;
            CFI_array[16'h41] = 16'h52;
            CFI_array[16'h42] = 16'h49;
            CFI_array[16'h43] = 16'h31;
            CFI_array[16'h44] = 16'h33;
           // To Be Defined
            CFI_array[16'h45] = 16'h0C;
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h01;
            CFI_array[16'h49] = 16'h07;
            CFI_array[16'h4A] = 16'h3F;
            CFI_array[16'h4B] = 16'h00;
            CFI_array[16'h4C] = 16'h02;
            CFI_array[16'h4D] = 16'h85;
            CFI_array[16'h4E] = 16'h95;
            CFI_array[16'h4F] = 16'h01;
            CFI_array[16'h50] = 16'h01;
            CFI_array[16'h57] = 16'h04;
            CFI_array[16'h58] = 16'h0F;
            CFI_array[16'h59] = 16'h18;
            CFI_array[16'h5A] = 16'h18;
            CFI_array[16'h5B] = 16'h0F;

            ASEL_array[16'h00] = 16'h0001;
            ASEL_array[16'h01] = 16'h227E;
            ASEL_array[16'h0E] = 16'h220A;
            ASEL_array[16'h0F] = 16'h2201;
            ASEL_array[16'h03] = 16'h0080;
    end

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j;
    integer tmp1,tmp2,tmp3;
    integer secure_silicon[0:SecSiSize];
    integer base;
    reg     sector_prot[0:SecNum];

        for (i=0;i<=ADDRRange;i=i+1)
        begin
           Mem[i]=MaxData;
        end
        for (i=0;i<=SecSiSize;i=i+1)
        begin
           secure_silicon[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
           DYB[i]=1'b0;
        end
        for (i=0;i<=GroupNum;i=i+1)
        begin
           PPB[i]=1'b0;
        end
        if (UserPreload && !(prot_file_name == "none"))
        begin
           //s29pl032j_prot  sector protect file
           //   //      - comment
           //   @aaa    - <aaa> stands for sector address
           //   (aaaa is incremented at every load)
           //   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
           //s29pl032j memory preload file
          //  @aaaa   - <aaaa> stands for address within last defined sector
          //  dd      - <dd> is byte to be written at Mem(nn)(aaaa++)
          // (aaaa is incremented at every load)

           $readmemh(mem_file_name,Mem);
        end
        if (UserPreload && !(secsi_file_name == "none"))
        begin
          // s29pl_secsi memory file
           //   //       - comment
           //   @aa     - <aa> stands for address within last defined sector
           //   dd      - <dd> is byte to be written at SecSi(aa++)
           //  (aa is incremented at every load)
           $readmemh(secsi_file_name,secure_silicon);
        end
        // Sector Protection Preload
        for (i=0;i<=SecNum;i=i+1)
            if ( sector_prot[i] )
                PPB[GroupID(i)] = PPB[GroupID(i)] | 1'b1;

        for (i=0;i<=SecNum;i=i+1)
        begin
             Ers_queue[i] = 0;
        end
        WData = 0;
        WAddr = -1;

        //SecSi Preload
        for (i=0;i<=SecSiSize;i=i+1)
        begin
           SecSi[i] = secure_silicon[i];
        end
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

        ULBYPASS = 1'b0;
        ESP_ACT  = 1'b0 ;
        OTP_ACT = 1'b0;

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

        PPBLock = 1'b0;
        PPMLB = 1'b0;
        SPMLB = 1'b0;
        SSPB = 1'b0;
        for(i=0;i<=3;i=i+1)
            Password[i] = MaxData;
        DYB = 0;
        BankERASE = 0;
        PreviousReadPage = PageNum + 1;
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

   // Protection Bit Program
    always @(posedge PBPROG_in)
    begin : ProtProgTime
        #(tdevice_PROTP - 1) PBPROG_out = 1'b1;
    end
    always @(negedge PBPROG_in)
    begin
        disable ProtProgTime;
        PBPROG_out = 1'b0;
    end
    // Protection Bit Erase
    always @(posedge PBERASE_in)
    begin : ProtEraseTime
        #(tdevice_PROTE - 1) PBERASE_out = 1'b1;
    end
    always @(negedge PBERASE_in)
    begin
        disable ProtEraseTime;
        PBERASE_out = 1'b0;
    end
    // Password Unlock
    always @(posedge UNLOCKDONE_in)
    begin : UnlockTime
        #(tdevice_UNLOCK - 1) UNLOCKDONE_out = 1'b1;
    end
    always @(negedge UNLOCKDONE_in)
    begin
        disable UnlockTime;
        UNLOCKDONE_out = 1'b0;
    end
    // Password Program
    always @(posedge PASSPDONE_in)
    begin : PassTime
        #(tdevice_POW - 1) PASSPDONE_out = 1'b1;
    end
    always @(negedge PASSPDONE_in)
    begin
        disable PassTime;
        PASSPDONE_out = 1'b0;
    end

    //////////////////////////////////////////////////////////////////////////////
    ////     obtain 'LAST_EVENT information
    //////////////////////////////////////////////////////////////////////////////
    always @(negedge OENeg)
    begin
        OENeg_event = $time;
    end
    always @(negedge CENeg)
    begin
        CENeg_event = $time;
    end
    always @(A)
    begin
        ADDR_event = $time;
    end

    //////////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    //////////////////////////////////////////////////////////////////////////////
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
         READY or PoweredUp) //or PDONE or  EDONE
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

//    ///////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    ///////////////////////////////////////////////////////////////////////////
    assign #3 gWE_n = WENeg_ipd; //AFTER 3 ns;
    assign #3 gCE_n = CENeg_ipd; //AFTER 3 ns;
    assign #3 gOE_n = OENeg_ipd; //AFTER 3 ns;

//    ///////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    ///////////////////////////////////////////////////////////////////////////
    always @(negedge gWE_n or negedge gCE_n)
    begin
        if ( RESETNeg !== 1'b0 &&
            ~gCE_n && ~gWE_n && OENeg && reseted==1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
    end

    always @(posedge gWE_n)
    begin
        if ( RESETNeg !== 1'b0 && ~gCE_n && OENeg && reseted==1'b1 )
        begin
            // WRITE operation
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
    end

    always @(posedge gCE_n)
    begin
       if ( RESETNeg !== 1'b0 && ~gWE_n && OENeg && reseted==1'b1 )
        begin
            // WRITE operation
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
    end

    always @(A)
    begin
        if ( WENeg && ~CENeg && ~OENeg && reseted==1'b1 )
        begin
        // Initiate READ
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            SecAddr = SecLatched;
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            ADDR_event = $time;
            CurrentReadPage = ( AddressLatched / 8 );
            SubsequentPageAccess = ( PreviousReadPage == CurrentReadPage );
            InitialPageAccess = ~SubsequentPageAccess;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge OENeg or negedge CENeg)
    begin
        if ( WENeg && ~CENeg && ~OENeg && reseted==1'b1 )
        begin
        // Initiate READ
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            SecAddr = SecLatched;
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            CurrentReadPage = ( AddressLatched / 8 );
            SubsequentPageAccess = ( PreviousReadPage == CurrentReadPage );
            InitialPageAccess = ~SubsequentPageAccess;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(posedge CENeg)
    begin
        PreviousReadPage = PageNum + 1;
    end

    always @(posedge READ)
    begin
        PreviousReadPage = CurrentReadPage;
    end

//    ///////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program Operation
//    // start/ suspend/ resume
//    ///////////////////////////////////////////////////////////////////////////

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
                if (((SA != 0 && ( ~DYB[SA] && ~PPB[GroupID(SA)] &&
                (~Ers_queue[SA] || ~ESP_ACT ) ) ) ||
                (SA == 0 && ((~OTP_ACT &&
                ~DYB[0] && ~PPB[0] ) || OTP_ACT ))) &&
                ~(~WPNeg && (SA <= 1 || SA >= SecNum-1)) &&
                ~(OTP_ACT && ( SA != 0 ||
                (SSWAddr < 64 || (SSWAddr >= 64 && SSPB)))))
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

//    ///////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    ///////////////////////////////////////////////////////////////////////////
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
                duration_erase = 0;
                for (i=0;i<=SecNum;i=i+1)
                    if ( Ers_queue[i] &&
                    ~DYB[i] && ~PPB[GroupID(i)] &&
                    ~(~WPNeg && (i <= 1 || i >= SecNum-1)))
                    begin
                        cnt_erase = cnt_erase +1;
                        duration_erase = duration_erase + tdevice_SEO;
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
                    EERR <= #400000  1'b0;
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

//    ///////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    ///////////////////////////////////////////////////////////////////////////

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
                if (A_PAT_1 && (DataLo == 8'h20))
                    next_state = PREL_ULBYPASS;
                else if (A_PAT_1 && (DataLo == 8'h90))
                    next_state = AS;
                else if (A_PAT_1 && (DataLo == 8'hA0))
                    next_state = A0SEEN;
                else if (A_PAT_1 && (DataLo == 8'h80))
                    next_state = C8;
                else if (A_PAT_1 && (DataLo == 8'h38) && ~PPMLB)
                    next_state = PASSPROG_PREL;
                else if (A_PAT_1 && (DataLo == 8'hC8))
                    next_state = PASSVERIFY;
                else if (A_PAT_1 && (DataLo == 8'h28))
                    next_state = PASSUNLOCK0;
                else if (A_PAT_1 && (DataLo == 8'h60))
                    next_state = PROTBIT_PREL;
                else if (A_PAT_1 && (DataLo == 8'h78))
                    next_state = RESET;
                else if (A_PAT_1 && (DataLo == 8'h58))
                    next_state = PPBDYB;
                else if (A_PAT_1 && (DataLo == 8'h48))
                   next_state = DYBWE;
                else if (A_PAT_1 && (DataLo == 8'h88))
                begin
                    next_state = OTP;
                    OTP_ACT = 1'b1;
                end
                else
                    next_state = RESET;
            end

            PREL_ULBYPASS :
            begin
                if (DataLo == 16'hA0)
                    next_state = A0SEEN;
                else if (DataLo == 16'h98)
                    next_state = UBP_CFI;
                else if (DataLo == 16'h80)
                    next_state = C8_PREL;
                else if (DataLo == 16'h90)
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
            end

            UBP_CFI :
            begin
                if (DataLo == 8'hF0)
                    next_state <= PREL_ULBYPASS;
            end

            AS :
            begin
                if (DataLo==16'hF0)
                    next_state = RESET;
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
                else if (DataLo==16'h30 && ~(ULBYPASS))
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
                    else if (DataLo==16'h30) //&& BankID == BankERASE)
                        next_state = SERS;
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
                else if (Addr % 12'h100 == 8'h55 && DataLo == 8'h98 )
                    next_state = ESP_CFI;
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
                else if (A_PAT_1 && DataLo == 16'h88)
                begin
                    next_state = OTP;
                    OTP_ACT = 1'b1;
                end
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

            PASSPROG_PREL :
            begin
                next_state = PASSPROG;
            end

            PASSPROG :
            begin
                if ( PASSPDONE_out == 1'b1 && DataLo == 16'hF0 )
                    next_state = RESET;
            end

            PASSVERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            PASSUNLOCK0 :
            begin
            end

            PASSUNLOCK1 :
            begin
            end

            PASSUNLOCK2 :
            begin
            end

            PASSUNLOCK3 :
            begin
            end

            PROTBIT_PREL :
            begin
                if (DataLo == 16'h68 && (Addr % 16'h100 == WP) )
                    next_state = PPB_PROGRAM;
                else if (DataLo == 16'h60 && (Addr % 16'h100 == WP) )
                    next_state = PPB_ERASE;
                else if (DataLo == 16'h68 && (Addr % 16'h100 == PL) )
                    next_state = PPMLB_PROGRAM;
                else if (DataLo == 16'h68 && (Addr % 16'h100 == SL) )
                    next_state = SPMLB_PROGRAM;
                else if (DataLo == 16'h68 && (Addr % 16'h100 == OW) )
                    next_state = SSPB_PROGRAM;
                else if (DataLo == 16'h48 && (Addr % 16'h100 == PL) )
                    next_state = PPMLB_VERIFY;
                else if (DataLo == 16'h48 && (Addr % 16'h100 == SL) )
                    next_state = SPMLB_VERIFY;
                else if (DataLo == 16'h48 && (Addr % 16'h100 == OW) )
                    next_state = SSPB_VERIFY;
                else
                    next_state = RESET;
            end

            PPBDYB :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            DYBWE :
            begin
                next_state = RESET;
            end

            PPB_PROGRAM :
            begin
                if ( PBPROG_out == 1'b1
                && DataLo == 16'h48 && ( Addr % 16'h100 == WP ) )
                    next_state = PPB_VERIFY;
            end

            PPB_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            PPB_ERASE :
            begin
                if ( PBERASE_out == 1'b1
                && DataLo == 16'h40 && ( Addr % 16'h100 == WP ) )
                    next_state = PPB_VERIFY;
            end

            PPMLB_PROGRAM :
            begin
                if ( PBPROG_out == 1'b1
                && DataLo == 16'h48 && ( Addr % 16'h100 == PL ) )
                    next_state = PPMLB_VERIFY;
            end

            SPMLB_PROGRAM :
            begin
                if ( PBPROG_out == 1'b1
                && DataLo == 16'h48 && ( Addr % 16'h100 == SL ) )
                    next_state = SPMLB_VERIFY;
            end

            SSPB_PROGRAM :
            begin
                if ( PBPROG_out == 1'b1
                && DataLo == 16'h48 && ( Addr % 16'h100 == OW ) )
                    next_state = SSPB_VERIFY;
            end

            PPMLB_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            SPMLB_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            SSPB_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            OTP :
            begin
                if (PATTERN_1 )
                    next_state = OTP_Z001;
                else
                    next_state = OTP;
            end

            OTP_Z001 :
            begin
                if (PATTERN_2 )
                    next_state = OTP_PREL;
                else
                    next_state = OTP;
            end

            OTP_PREL :
            begin
                if (A_PAT_1 && (DataLo == 16'h90))
                    next_state = OTP_AS;
                else if (A_PAT_1 && (DataLo == 16'hA0))
                    next_state = OTP_A0SEEN;
                else
                    next_state = OTP;
            end

            OTP_AS :
            begin
                if (DataLo==16'h00 )
                begin
                    if ( ESP_ACT == 1'b1 )
                        next_state = ESP;
                    else
                        next_state = RESET;
                    OTP_ACT = 1'b0;
                end
                else
                    next_state = OTP;
            end

            OTP_A0SEEN :
            begin
                next_state = PGMS; //set OTP
            end

        endcase
    end

    //ERS state, SERS_EXEC state, EDONE/EERR
    always @(posedge EDONE or negedge EERR)
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==ERS)
            begin
                if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end
            else if  (current_state==SERS_EXEC)
                next_state = RESET;
        end
    end

    // SERS state, CTMOUT
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

    // ESPS state, START_T1
    always @(posedge START_T1 or reseted)
    begin: StateGen5 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==ESPS)
                if (START_T1 === 1'b1) next_state = ESP;
    end

    // PGMS state, PDONE/PERR
    always @(posedge PDONE or negedge PERR)
    begin: StateGen6 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                if (OTP_ACT)
                    next_state = OTP;
                else if (ESP_ACT)
                    next_state = ESP;
                else if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end
        end
    end

     // PASSUNLOCK state, UNLOCKDONE_out
    always @(posedge UNLOCKDONE_out)
    begin: StateGen7
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PASSUNLOCK0)
                next_state = PASSUNLOCK1;
            else if (current_state == PASSUNLOCK1)
                next_state = PASSUNLOCK2;
            else if (current_state == PASSUNLOCK2)
                next_state = PASSUNLOCK3;
            else if (current_state == PASSUNLOCK3)
                next_state = RESET;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(negedge READ or negedge WRITE or reseted)
    begin
        if (~WRITE)
        begin
            Data      = D_tmp;
            DataLo    = D_tmp % 12'h100;
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                RY_zd = 1'b1;
                ESP_ACT = 1'b0;
                if (~READ)
                    DOut_zd = READMEM(SecAddr,Addr);
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
                    else if (A_PAT_1 && (DataLo==16'h78))
                        PPBLock = 1'b1;
            end

            PREL_ULBYPASS :
            begin
                if (~READ)
                begin
                    if ( BankID == BankUBPASS )
                        DOut_zd = 16'bz;
                    else
                        DOut_zd = READMEM(SecAddr,Addr);
                end
            end

            RES_ULBYPASS :
            begin
                if ((~WRITE) && (DataLo == 16'h00))
                    ULBYPASS = 1'b0;
            end

            CFI , UBP_CFI :
            begin
                OutputD = 0;
                if (((Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                ((Addr >= 16'h40) && (Addr <= 16'h50)) ||
                ((Addr >= 16'h57) && (Addr <= 16'h5B)))
                    OutputD[7:0] = CFI_array[Addr];
                else if (~READ)
                    $display("Invalid CFI query address");
                if (~READ)
                    DOut_zd = OutputD;
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
                        OutputD[0] = PPB[GroupID(SecAddr)];
                    end
                end
                else
                    OutputD = READMEM(SecAddr,Addr);
                if (~READ)
                    DOut_zd = OutputD;
            end

            A0SEEN :
            begin
                if (~WRITE && ~(ULBYPASS && BankID != BankUBPASS))
                begin
                    BankPROGRAM = BankID;
                    WData = Data;
                    WAddr = Addr;
                    SA = SecAddr;
                    temp = Data % 12'h100;
                    Status[7] = ~temp[7];
                    RY_zd = 1'b0;
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
                        RY_zd = 1'b0;
                        ERES   = 1'b0;
                        ESUSP = 1'b0;
                        Ers_queue = ~(0);
                        Status = 16'b0000000000001000;
                    end
                    else if (DataLo==16'h30 && ~(ULBYPASS))
                    begin
                        //put selected sector to sec. ers. queue
                        //start timeout
                        //BankERASE = BankID;
                        BankERASE = 0;
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
                if (~READ)
                begin
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    Status[6] = ~Status[6]; //toggle
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                    DOut_zd = Status;
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
                    else if (DataLo==16'h30)// && BankID == BankERASE)
                    begin
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                        Ers_queue[SecAddr] = 1'b1;
                        BankE;
                    end
                end
                Status[7] = 1'b1;
                Status[3] = 1'b0;

                if (~READ)
                begin
                    if ( BusyBankE(BankID) )
                        DOut_zd = Status;
                    else
                        DOut_zd = READMEM(SecAddr,Addr);
                end
        end

        ESPS :
        begin
            if (~READ )
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
                    DOut_zd = Status;
                else
                    DOut_zd = READMEM(SecAddr,Addr);
            end
        end

        SERS_EXEC:
        begin
            if ( ~READ )
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
                    DOut_zd = Status;
                else
                    DOut_zd = READMEM(SecAddr,Addr);
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
                RY_zd = 1'b0;
            end
            if (~READ)
            begin
                Status[5] = 1'b0;
                if ( Ers_queue[SecAddr] == 1'b1 )
                begin
                    Status[7] = 1'b1;
                    Status[2] = ~Status[2]; //toggle
                end
                if ( Ers_queue[SecAddr] != 1'b1 )
                    DOut_zd = READMEM(SecAddr,Addr);
                else
                    DOut_zd = Status;
            end
        end

        ESP_Z001 :
        begin
        end

        ESP_PREL :
        begin
            if (~WRITE && A_PAT_1 && DataLo == 16'h90 )
                BankASEL = BankID;
        end

        ESP_CFI :
        begin
            OutputD = 0;
            if (((Addr >= 16'h10) && (Addr <= 16'h3C)) ||
            ((Addr >= 16'h40) && (Addr <= 16'h50)) ||
            ((Addr >= 16'h57) && (Addr <= 16'h5B)))
                OutputD[7:0] = CFI_array[Addr];
             else if (~READ)
                 $display("Invalid CFI query address");
             if (~READ)
                 DOut_zd = OutputD;
        end

        ESP_A0SEEN :
        begin
            if (~WRITE)
            begin
                ESP_ACT = 1'b1;
                PSTART = 1'b1;
                PSTART <= #1 1'b0;
                RY_zd = 1'b0;
                WData = Data;
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
                    OutputD[0] = PPB[GroupID(SecAddr)];
                end
            end
            else if ( BankID != BankASEL &&
            BusyBankE(BankID) && ( ~READ ) &&
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
                DOut_zd = OutputD;
        end

        PGMS :
        begin
                if (~READ )
                begin
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    // Status(2) no toggle
                    Status[1] = 1'b0;
                    if ( BankID == BankPROGRAM )
                        DOut_zd = Status;
                    else if ( BankID != BankPROGRAM && ESP_ACT &&
                    BusyBankE(BankID) && Ers_queue[SecAddr] )
                    begin
                        Status[2] = ~Status[2];
                        DOut_zd = Status;
                    end
                    else
                        DOut_zd = READMEM(SecAddr,Addr);
                end
        end

        PASSPROG_PREL :
        begin
            if (~WRITE )
            begin
                WAddrPass = Addr % 4;
                WDataPass = Data;
                PASSPDONE_in = 1'b0;
                #1 PASSPDONE_in <= 1'b1;
                RY_zd = 1'b0;
            end
        end

        PASSPROG :
        begin
            if (~READ && PASSPDONE_out == 1'b0 )
            begin
                Status[7] = ~WDataPass[7];
                Status[6] = ~Status[6];
                Status[5] = 1'b0;
                Status[1] = 1'b0;
                DOut_zd = Status;
            end
        end

        PASSVERIFY :
        begin
            if (~READ)
            begin
                if ( PPMLB != 1'b1 )
                    DOut_zd = Password[Addr % 4];
                else
                    DOut_zd = ~(0);
            end
        end

        PASSUNLOCK0 :
        begin
            if ( ~WRITE )
            begin
                UnlockPass = ((Password[0] == Data) && (Addr % 4 == 0));
                UNLOCKDONE_in = 1'b0;
                #1 UNLOCKDONE_in <= 1'b1;
                RY_zd = 1'b0;
            end
            if ((~READ) && (~UNLOCKDONE_out))
            begin
                Status[6] = ~Status[6];
                DOut_zd = Status;
            end

        end

        PASSUNLOCK1 :
        begin
            if ((~WRITE) && UNLOCKDONE_out)
            begin
                UnlockPass = UnlockPass && ((Password[1] == Data) && (Addr % 4 == 1));
                UNLOCKDONE_in = 1'b0;
                #1 UNLOCKDONE_in <= 1'b1;
                RY_zd = 1'b0;
            end
            if ((~READ) && (~UNLOCKDONE_out))
            begin
                Status[6] = ~Status[6];
                DOut_zd = Status;
            end
        end

        PASSUNLOCK2 :
        begin
            if ((~WRITE) && UNLOCKDONE_out)
            begin
                UnlockPass = UnlockPass && ((Password[2] == Data) && (Addr % 4 == 2));
                UNLOCKDONE_in = 1'b0;
                #1 UNLOCKDONE_in <= 1'b1;
                RY_zd = 1'b0;
            end
            if ((~READ) && (~UNLOCKDONE_out))
            begin
                Status[6] = ~Status[6];
                DOut_zd = Status;
            end
        end

        PASSUNLOCK3 :
        begin
            if ((~WRITE) && UNLOCKDONE_out)
            begin
                UnlockPass = UnlockPass && ((Password[3] == Data) && (Addr % 4 == 3));
                UNLOCKDONE_in = 1'b0;
                #1 UNLOCKDONE_in <= 1'b1;
                RY_zd = 1'b0;
            end
            if ((~READ) && (~UNLOCKDONE_out))
            begin
                Status[6] = ~Status[6];
                DOut_zd = Status;
            end
        end

        PROTBIT_PREL :
        begin
            if (~WRITE )
                if (DataLo == 16'h68 && (Addr % 16'h100 == WP) )
                begin
                    PBSecAddr = SecAddr;
                    PBPROG_in = 1'b0;
                    #1 PBPROG_in <= 1'b1;
                    RY_zd = 1'b0;
                end
                else if ( DataLo == 16'h60 && (Addr % 16'h100 == WP) )
                begin
                    PBERASE_in = 1'b0;
                    #1 PBERASE_in <= 1'b1;
                    RY_zd = 1'b0;
                end
                else if ( DataLo == 16'h68 && (Addr % 16'h100 == PL) )
                begin
                    PBPROG_in = 1'b0;
                    #1 PBPROG_in <= 1'b1;
                    RY_zd = 1'b0;
                end
                else if ( DataLo == 16'h68 && (Addr % 16'h100 == SL) )
                begin
                    PBPROG_in = 1'b0;
                    #1 PBPROG_in <= 1'b1;
                    RY_zd = 1'b0;
                end
                else if ( DataLo == 16'h68 && (Addr % 16'h100 == OW) )
                begin
                    PBPROG_in = 1'b0;
                    #1 PBPROG_in <= 1'b1;
                    RY_zd = 1'b0;
                end
        end

        PPBDYB :
        begin
            if (~READ )
            begin
                DOut_zd = 0;
                DOut_zd[1] = PPBLock;
                DOut_zd[0] = DYB[SecAddr];
            end
        end

        DYBWE :
        begin
            if (~WRITE )
                if (Data % 2 == 0 )
                    DYB[SecAddr] = 1'b0;
                else
                    DYB[SecAddr] = 1'b1;
        end

        PPB_PROGRAM :
        begin
        end

        PPB_VERIFY :
        begin
            if (~READ )
            begin
                DOut_zd = 0;
                DOut_zd[0] = PPB[GroupID(SecAddr)];
            end
        end

        PPB_ERASE :
        begin
        end

        PPMLB_PROGRAM :
        begin
        end

        SPMLB_PROGRAM :
        begin
        end

        SSPB_PROGRAM :
        begin
        end

        PPMLB_VERIFY :
        begin
            if (~READ)
            begin
                if (Addr % 16'h100 == PL )
                begin
                    DOut_zd = 0;
                    DOut_zd[0] = PPMLB;
                end
                else
                    DOut_zd = 16'bz;
            end
        end

        SPMLB_VERIFY :
        begin
            if (~READ)
            begin
                if (Addr % 16'h100 == SL )
                begin
                    DOut_zd = 0;
                    DOut_zd[0] = SPMLB;
                end
                else
                    DOut_zd = 16'bz;
            end
        end

        SSPB_VERIFY :
        begin
            if (~READ)
            begin
                if (Addr % 16'h100 == OW )
                begin
                    DOut_zd = 0;
                    DOut_zd[0] = SSPB;
                end
                else
                    DOut_zd = 16'bz;
            end
        end

        OTP :
        begin
            if (~READ)
            begin
                SecSiAddr = Addr % (SecSiSize + 1);
                if (SecSi[SecSiAddr] == -1 )
                    DOut_zd = 16'bx;
                else
                    DOut_zd = SecSi[SecSiAddr];
            end
        end

        OTP_Z001 :
        begin
        end

        OTP_PREL :
        begin
        end

        OTP_AS :
        begin
        end

        OTP_A0SEEN :
        begin
            if ( ~WRITE )
            begin
                RY_zd = 1'b0;
                WData = Data;
                WAddr = Addr % (SecSiSize + 1);
                SSWAddr = WAddr;
                BankPROGRAM = BankID;
                SA = 0;
                PSTART = 1'b1;
                #1 PSTART <= 1'b0;
                temp = Data;
                Status[7] = ~temp[7];
                if ( SecAddr != 0 )
                    $display("Invalid sector Address in SecSi");
                if ( Addr > 127 )
                    $display("Invalid program address in SecSi region. ");
            end
        end
    endcase

    end
end

    //ERS state, EDONE/EERR
    always @(EERR or EDONE)
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
                    if (DYB[i] == 1'b0
                    && PPB[GroupID(i)] == 1'b0
                    && ~(~WPNeg && (i <= 1 || i >= SecNum-1)))
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end
            if (EDONE)
            begin
                RY_zd = 1'b1;
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if (DYB[i] == 1'b0
                    && PPB[GroupID(i)] == 1'b0
                    && ~(~WPNeg && (i <= 1 || i >= SecNum -1)))
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = MaxData;
                end
            end
        end
    end
    always @(negedge EERR)
    begin
        if ((current_state==ERS) || (current_state==SERS_EXEC))
        begin
            RY_zd = 1'b1;
            BankERASE = 0;
        end
    end

    //SERS state, CTMOUT
    always @(CTMOUT)
    begin : SERS2
        if (current_state==SERS)
        begin
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                RY_zd = 1'b0;
                ESUSP = 1'b0;
                ERES   = 1'b0;
            end
        end
    end

    //ESPS state, START_T1
    always @(START_T1)
    begin : ESPS2
        if (current_state==ESPS)
        begin
            if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
                RY_zd = 1'b1;
            end
        end
    end

    always @(posedge EDONE)
    begin
        BankERASE = 0;
    end
    //SERS_EXEC state, EERR/EDONE
    always @(EERR or EDONE)
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
                    if (DYB[i] == 1'b0
                    && PPB[GroupID(i)] == 1'b0
                    && ~(~WPNeg && (i <= 1 || i >= SecNum-1)) && Ers_queue[i] )
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end

                if (EDONE)
                begin
                    RY_zd = 1'b1;
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                         ADDRHILO(SecErsLOW,SecErsHIGH,i);
                         if (DYB[i] == 1'b0
                         && PPB[GroupID(i)] == 1'b0
                         && ~(~WPNeg && (i <= 3 || i >= SecNum -3)) && Ers_queue[i] )
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = MaxData;
                    end
                end
           end
       end
    end

    always @(PERR)
    begin
        if (current_state==PGMS && ~PERR)
            RY_zd = 1'b1;
    end

    //PGMS state, PDONE
    always @(PDONE) // or PERR or PDONE)
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
                    if ( OTP_ACT )
                        old_int=SecSi[WAddr];
                    else
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
                    if ( OTP_ACT )
                        SecSi[WAddr] = -1;
                    else
                        Mem[SecProgLOW + Addr] = -1;
                end
                else
                begin
                    RY_zd = 1'b1;
                    if ( OTP_ACT )
                        SecSi[WAddr] = WData;
                    else
                        Mem[SecProgLOW + WAddr] = WData;
                end
            end
        end
    end

    //PASSPROG state, PASSPDONE_out
    always @(posedge PASSPDONE_out)
    begin : PASSPROG2
        if (current_state == PASSPROG)
        begin
            Password[WAddrPass] = WDataPass & Password[WAddrPass];
            RY_zd = 1'b1;
        end
    end

    //PASSUNLOCK state, UNLOCKDONE_out
    always @(posedge UNLOCKDONE_out)
    begin : PASSUNLOCKPP
        if ( (current_state == PASSUNLOCK0) ||
             (current_state == PASSUNLOCK1) ||
             (current_state == PASSUNLOCK2) )
        begin
            RY_zd = 1'b1;
        end
        else if (current_state == PASSUNLOCK3)
        begin
            if ( UnlockPass )
                PPBLock = 1'b0;
            RY_zd = 1'b1;
        end
    end

    //PPB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : PPB_PROGRAM2
        if (current_state == PPB_PROGRAM )
        begin
            if ( PPBLock == 1'b0 )
                PPB[GroupID(PBSecAddr)] = 1'b1;
            RY_zd = 1'b1;
        end
    end

    //PPB_ERASE state, PBERASE_out
    always @(posedge PBERASE_out)
    begin : PPB_ERASE2
        if (current_state == PPB_ERASE)
        begin
            if ( PPBLock == 1'b0 )
                PPB = 0;
            RY_zd = 1'b1;
        end
    end

    //PPMLB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : PPMLB_PROGRAM2
        if (current_state == PPMLB_PROGRAM )
        begin
            if (SPMLB !== 1'b1)
                PPMLB = 1'b1;
            RY_zd = 1'b1;
        end
    end

    //SPMLB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : SPMLB_PROGRAM2
        if (current_state == SPMLB_PROGRAM)
        begin
            if ( PPMLB != 1'b1 )
                SPMLB = 1'b1;
            RY_zd = 1'b1;
        end
    end

    //SSPB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : SSPB_PROGRAM2
        if (current_state == SSPB_PROGRAM)
        begin
            SSPB = 1'b1;
            ASEL_array[3] = 16'hC0;
            RY_zd = 1'b1;
        end
    end

    //Output Disable Control
    always @(posedge CENeg)
    begin
        DOut_zd = 16'bZ;
    end
    //Output Disable Control
    always @(posedge OENeg)
    begin
        DOut_zd = 16'bZ;
    end
    //Output Disable Control
    always @(negedge RST)
    begin
        if (~RESETNeg)
            DOut_zd = 16'bZ;
    end

    // Hardware RESET cycle
    always @(negedge RST)
    begin
        if (~RESETNeg)
        begin
            BankERASE = 0;
            OTP_ACT = 1'b0;
            if ( PPMLB == 1'b1 )
                PPBLock = 1'b1;
            else
                PPBLock = 1'b0;
            DYB = 0;
            ESP_ACT = 1'b0;
            ULBYPASS = 1'b0;
            PBPROG_in = 1'b0;
            PBERASE_in = 1'b0;
            PASSPDONE_in = 1'b0;
            UNLOCKDONE_in = 1'b0;
        end
    end

  function [11:0] ReturnSectorID;
  input [HiAddrBit:0] ADDR;
  integer conv;
  begin
       if ( ADDR < 16'h8000 )
           ReturnSectorID = ADDR / 16'h1000;
       else if ((ADDR >= 16'h8000) && (ADDR < 24'h1F8000))
           ReturnSectorID = ADDR / 16'h8000 + 7;
       else if (ADDR >= 24'h1F8000)
           ReturnSectorID = 70 + (ADDR - 24'h1F8000) / 16'h1000;
  end
  endfunction

  function[9:0] GroupID;
  input SECADDR;
  integer SECADDR;
  begin
      if ( SECADDR < 11 )
          GroupID = SECADDR;
      else if (( SECADDR >= 11 ) && ( SECADDR <= 66 ))
          GroupID = (SECADDR - 11) / 4 + 11;
      else if ( SECADDR > 66 )
          GroupID = 25 + (SECADDR - 67);
  end
  endfunction

 function[1:0] ReturnBank;
 input[HiAddrBit:0] ADDR;
 begin
     if  ( ADDR / 24'h40000 == 0 )
         ReturnBank = ABank;
     else if ( ((ADDR / 24'h40000) >= 1) && ((ADDR / 24'h40000) <=3) )
         ReturnBank = BBank;
     else if ( ((ADDR / 24'h40000) >= 4) && ((ADDR / 24'h40000) <=6) )
         ReturnBank = CBank;
     else
         ReturnBank = DBank;
 end
 endfunction

 function BusyBankE;
 input[1:0] BankNum;
 begin
     BusyBankE = ((BankNum == ABank) && BankERASE[0]) ||
                 ((BankNum == BBank) && BankERASE[1]) ||
                 ((BankNum == CBank) && BankERASE[2]) ||
                 ((BankNum == DBank) && BankERASE[3]);
 end
 endfunction

 task BankE;
 begin
     if ( BankID == ABank )
         BankERASE[0] = 1'b1;
     else if ( BankID == BBank )
         BankERASE[1] = 1'b1;
     else if ( BankID == CBank )
         BankERASE[2] = 1'b1;
     else//DBank
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
     if (SecAddress <= 7)
         AddrBASE  = SecAddress*20'h01000;
     else if ((SecAddress > 7) && (SecAddress < 70))
         AddrBASE  = (SecAddress-7)*20'h8000;
     else
         AddrBASE  = 24'h1F8000 + (SecAddress-70)*16'h1000;
     Data = Mem[AddrBASE+Address];
     if ( Data == -1 )
         READMEM = 16'bx;
     else
         READMEM = Data;
 end
 endfunction

 task ADDRHILO;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   SectorID;
 integer AddrLOW;
 integer AddrHIGH;
 integer SectorID;
 begin

  if    (SectorID <= 7)
  begin
     AddrLOW  = SectorID*20'h01000;
     AddrHIGH = SectorID*20'h01000 + 20'h0FFF;
  end
  else if ((SectorID > 7) && (SectorID < 70))
  begin
     AddrLOW  = (SectorID-7)*20'h8000;
     AddrHIGH = (SectorID-7)*20'h8000+16'h7FFF;
  end
  else
  begin
     AddrLOW  = 24'h1F8000 + (SectorID-70)*16'h1000;
     AddrHIGH = 24'h1F8000 + (SectorID-70)*16'h1000 + 16'h0FFF;
  end
 end
 endtask


    reg  BuffInOE, BuffInCE, BuffInADDR_Initial, BuffInADDR_Subsequent;
    wire BuffOutOE, BuffOutCE, BuffOutADDR_Initial, BuffOutADDR_Subsequent;

    BUFFER    BUFOE          (BuffOutOE  , BuffInOE);
    BUFFER    BUFCE          (BuffOutCE  , BuffInCE);
    BUFFER    BUFADDR_tACC   (BuffOutADDR_Initial   , BuffInADDR_Initial   );
    BUFFER    BUFADDR_tPACC  (BuffOutADDR_Subsequent, BuffInADDR_Subsequent);

    initial
    begin
        BuffInOE                = 1'b1;
        BuffInCE                = 1'b1;
        BuffInADDR_Initial      = 1'b1;
        BuffInADDR_Subsequent   = 1'b1;
    end

    always @(posedge BuffOutOE)
    begin
        OEDQ_01 = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CEDQ_01 = $time;
    end
    always @(posedge BuffOutADDR_Initial)
    begin
        ADDRDQ_01_InitialPageAccess = $time;
    end
    always @(posedge BuffOutADDR_Subsequent)
    begin
        ADDRDQ_01_SubsequentPageAccess = $time;
    end


endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
