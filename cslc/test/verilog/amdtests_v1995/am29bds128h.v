//////////////////////////////////////////////////////////////////////////////
//  File name : am29bds128h.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2003, 2004 Spansion, LLC.
//
//  MODifICATION HISTORY :
//
//  version:  | author:        |   date:   | changes made:
//    V0.1       A.Savic         03 Dec 08    First release
//    V0.2       A.Savic         03 Dec 09    RDY comment update - open
//                                            drain output
//                                            Memory array declaration
//    V0.3       A.Savic         03 Dec 16    Updated for NC Sim
//    V0.4       A.Savic         03 Dec 18   No bank restriction for Sector Erase
//                                           Erase Suspend / Resume refer to
//                                           all busy / suspended banks
//    V0.5       A.Savic         04 Jan 14   Specify block path expansion for
//                                           unique ModelSim/NCSim Verilog SDF
//    v0.6       A.Savic         04 Jan 19   Preload section update - sector
//                                           contents independent preload
//    v0.7       A.Savic         04 Feb 19   Memory wrap with busy sector check
//                                           HW RESET flag update
//                                           Erase suspended sector programming
//                                           restriciton
//                                           TimingChecks VHDL SetupLow,
//                                           SetupHigh, HoldLow, HoldHigh
//                                           equivalents added
//    v0.8       A.Savic         04 Jun 28   Aligned to new datasheet revision :
//                                           June 7, 2004 AM29BDS128H/064H_00_A4
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           AM29BDS128H
//
//  Description:   128 Megabit (8 M x 16-Bit) CMOS 1.8 Volt-only
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

module am29bds128h
(
    A22      ,
    A21      ,
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

    input  A22  ;
    input  A21  ;
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

    wire  A22_ipd  ;
    wire  A21_ipd  ;
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

    wire [22 : 0] A;
    assign A = {
                A22_ipd,
                A21_ipd,
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

    reg HANG_out      ; // Program/Erase Timing Limit
    reg HANG_in       ;
    reg START_T1      ; // Start TimeOut
    reg START_T1_in   ;
    reg CTMOUT        ; // Sector Erase TimeOut
    reg CTMOUT_in     ;
    reg READY         ; // Device ready after reset
    reg READY_in      ;
    reg TRCC_out      ; // Continuous Read cycle
    reg TRCC_in       ;
    reg ROWBOUND_in   ;
    reg TIACC_out     ;// Initial Access
    reg TIACC_in      ;
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
    reg RY_async = 1'b1;
    reg RY_sync = 1'b0;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name = "none";
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID    = "AM29BDS128H";
    parameter MaxData   = 16'hFFFF;
    parameter SecSize   = 20'h7FFF;
    parameter SecNum    = 269;
    parameter GroupNum  = 83;
    parameter SecSiSize = 127;
    parameter HiAddrBit = 22;
    parameter ADDRRange = 23'h7FFFFF;

    parameter OW  = 8'b00011010;
    parameter PL  = 8'b00001010;
    parameter SL  = 8'b00010010;
    parameter WP  = 8'b00000010;
    parameter WPE = 8'b01000010;

    //varaibles to resolve between Standard/Reduced devices
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;

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
    reg[1:0] BankCHECK;
    reg[11:0] SectorCHECK;
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

    reg OE_burst;
    reg RST ;
    reg reseted ;
    // active CLK edge detcetion
    reg CLKMerge;

    integer Mem[0:ADDRRange];
    integer SecSi[0:SecSiSize];
    reg[19:0] ConfReg;
    //Sector Protection Status
    integer Password[0:3];
    reg[SecNum:0] DYB;
    reg[GroupNum:0] PPB;
    reg PPBLock;
    reg PPMLB;
    reg SPMLB;
    reg SSPB;
    reg Reduced;
    integer BurstDelay;
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
    integer AddrCHECK;
    integer BurstAddr;
    integer BurstOffset;
    integer BurstSect;
    integer AddrSuspend;
    integer SectSuspend;
    reg     RYSuspend;
    integer LatencyAddr;
    integer LatencySect;
    integer BurstBorder;
    integer WrapMax;
    reg BusyBOUND;
    reg[15:0] CrossData;
    //Burst latency values
    reg LATCHED_3E_3F;
    reg INITIAL;
    reg RESUMED;
    reg LatencyRESUME;
    reg LatencyBOUND;
    reg LatencyBUSY;
    reg STALL;
    integer ResumeCODE;
    integer BoundCODE;
    integer BusyCODE;

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
   integer   ADDRDQ_01;
   integer   tpd_A1_DQ_tr01;
   integer   tpd_A2_DQ_tr01;

   reg[15:0] TempData;
   event oe_event;
   event MergeE;

   integer SectorA;
   integer SectorB;

   reg [5:0] current_state;
   reg [5:0] next_state;
   reg [5:0] ExitFrom;
   reg [2:0] READ_MODE;

   parameter NO_SYNC    = 4'd0;
   parameter CONTINUOUS = 4'd1;
   parameter LINEAR     = 4'd2;
   parameter SYNCR      = 4'd3;

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
 wire CheckDataCE;
 assign CheckDataCE = ~WENeg && OENeg && DIn != DOut_zd;
 wire CheckAddrWE;
 assign CheckAddrWE = ~AVDNeg && ~CENeg && OENeg;
 wire CheckAddrCE;
 assign CheckAddrCE = ~AVDNeg && ~WENeg && OENeg;
 wire CLKPositive;
 assign CLKPositive = SYNC && ConfReg[17] === 1'b1 && ~AVDNeg;
 wire CLKNegative;
 assign CLKNegative = SYNC && ConfReg[17] === 1'b0 && ~AVDNeg;
 wire CLKPositiveOES;
 assign CLKPositiveOES = SYNC && ConfReg[17] === 1'b1;
 wire CLKNegativeOES;
 assign CLKNegativeOES = SYNC && ConfReg[17] === 1'b0;
 wire AVDCheckP;
 assign AVDCheckP   = SYNC && ConfReg[17] === 1'b1 && ~AVDNeg;
 wire AVDCheckN;
 assign AVDCheckN   = SYNC && ConfReg[17] === 1'b0 && ~AVDNeg;
 wire CheckCLKWE;
 assign CheckCLKWE = ((ConfReg[17] === 1'b0 && ~CLK) ||
                    (ConfReg[17] === 1'b1 && CLK)) &&
                    ConfReg[19] === 1'b0;

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

reg temp17 = ConfReg[17];
reg temp19 = ConfReg[19];

specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

        // tpd delays
    specparam        tpd_A0_DQ0           = 1;//tACC
    specparam        tpd_CENeg_DQ0        = 1;//tCE
    specparam        tpd_CENeg_RDY        = 1;//tCR
    specparam        tpd_OENeg_DQ0        = 1;//tOE
    specparam        tpd_CLK_DQ0          = 1;//tCKA/tCKZ
    specparam        tpd_CLK_RDY          = 1; //tRACC
    specparam        tpd_AVDNeg_DQ0       = 1;//tACC
    //

    //tsetup values
    specparam        tsetup_A0_AVDNeg     = 1;//tAAVDS,tAAS,/
    specparam        tsetup_CENeg_AVDNeg  = 1;//tCAS
    specparam        tsetup_A0_CLK        = 1;//tACS
    specparam        tsetup_CENeg_CLK     = 1;//tCES
    specparam        tsetup_AVDNeg_CLK    = 1;//tAVC
    specparam        tsetup_OENeg_CLK     = 1;//tOES
    specparam        tsetup_A0_WENeg      = 1;//tAS,\
    specparam        tsetup_A0_CENeg      = 1;//tAS,\
    specparam        tsetup_DQ0_WENeg     = 1;//tDS,/
    specparam        tsetup_DQ0_CENeg     = 1;//tDS,/
    specparam        tsetup_CENeg_WENeg   = 1;//tCS
    specparam        tsetup_AVDNeg_WENeg  = 1;//tAVSW
    specparam        tsetup_CLK_WENeg     = 1;//tCSW
    //thold values
    specparam        thold_A0_AVDNeg      = 1;//tAAVDH,tAAH,/
    specparam        thold_A0_CLK         = 1;//tACH
    specparam        thold_A0_WENeg       = 1;//tAH,\
    specparam        thold_A0_CENeg       = 1;//tAH,\
    specparam        thold_DQ0_WENeg      = 1;//tDH /
    specparam        thold_DQ0_CENeg      = 1;//tDH /
    specparam        thold_WENeg_OENeg    = 1;//tGHWL,/
    specparam        thold_CENeg_WENeg    = 1;//tCH,\
    specparam        thold_AVDNeg_WENeg   = 1;//tAVHW,\
    specparam        thold_AVDNeg_CLK     = 1;//tAVHC
    specparam        thold_OENeg_RESETNeg = 1;//tRH,/
    specparam        thold_CENeg_RESETNeg = 1;//tRH,/
    //tpw values
    specparam        tpw_AVDNeg_negedge   = 1; //tAVDP
    specparam        tpw_WENeg_negedge    = 1; //tWP
    specparam        tpw_WENeg_posedge    = 1; //tWPH
    specparam        tpw_RESETNeg_negedge = 1; //tRP
    //tdevice values: values for internal delays
    specparam        tdevice_POW          = 9000;
    //Sector Erase Operation    tWHWH2
    specparam        tdevice_SEO32KW      = 400000000;
    specparam        tdevice_SEO4KW       = 200000000;
    //Timing Limit Exceeded
    specparam        tdevice_HANG         = 400000000;
    //program/erase suspend timeout
    specparam        tdevice_START_T1     = 35000;
    //sector erase command sequence timeout
    specparam        tdevice_CTMOUT       = 50000;
    //device ready after Hardware reset(during embeded algorithm)
    specparam        tdevice_READY        = 30000; //tReady
    //Continuous Burst Read Cycle
    specparam        tdevice_TRCC         = 1000000;
    // Protection Bit Program
    specparam        tdevice_PROTP        = 150000;
    // Protection Bit Erase
    specparam        tdevice_PROTE        = 15000000;
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
        ( A21 => DQ0 ) = tpd_A0_DQ0;
        ( A21 => DQ1 ) = tpd_A0_DQ0;
        ( A21 => DQ2 ) = tpd_A0_DQ0;
        ( A21 => DQ3 ) = tpd_A0_DQ0;
        ( A21 => DQ4 ) = tpd_A0_DQ0;
        ( A21 => DQ5 ) = tpd_A0_DQ0;
        ( A21 => DQ6 ) = tpd_A0_DQ0;
        ( A21 => DQ7 ) = tpd_A0_DQ0;
        ( A21 => DQ8 ) = tpd_A0_DQ0;
        ( A21 => DQ9 ) = tpd_A0_DQ0;
        ( A21 => DQ10 ) = tpd_A0_DQ0;
        ( A21 => DQ11 ) = tpd_A0_DQ0;
        ( A21 => DQ12 ) = tpd_A0_DQ0;
        ( A21 => DQ13 ) = tpd_A0_DQ0;
        ( A21 => DQ14 ) = tpd_A0_DQ0;
        ( A21 => DQ15 ) = tpd_A0_DQ0;
        ( A22 => DQ0 ) = tpd_A0_DQ0;
        ( A22 => DQ1 ) = tpd_A0_DQ0;
        ( A22 => DQ2 ) = tpd_A0_DQ0;
        ( A22 => DQ3 ) = tpd_A0_DQ0;
        ( A22 => DQ4 ) = tpd_A0_DQ0;
        ( A22 => DQ5 ) = tpd_A0_DQ0;
        ( A22 => DQ6 ) = tpd_A0_DQ0;
        ( A22 => DQ7 ) = tpd_A0_DQ0;
        ( A22 => DQ8 ) = tpd_A0_DQ0;
        ( A22 => DQ9 ) = tpd_A0_DQ0;
        ( A22 => DQ10 ) = tpd_A0_DQ0;
        ( A22 => DQ11 ) = tpd_A0_DQ0;
        ( A22 => DQ12 ) = tpd_A0_DQ0;
        ( A22 => DQ13 ) = tpd_A0_DQ0;
        ( A22 => DQ14 ) = tpd_A0_DQ0;
        ( A22 => DQ15 ) = tpd_A0_DQ0;


    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ0 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ1 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ2 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ3 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ4 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ5 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ6 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ7 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ8 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ9 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ10 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ11 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ12 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ13 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ14 ) = tpd_CLK_DQ0;
    if ( temp19 == 1'b0 && ~CENeg &&
       (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
       (((temp17 == 1'b1) && CLK) || ((temp17 == 1'b0) && ~CLK)))
            ( CLK => DQ15 ) = tpd_CLK_DQ0;


// RDY output paths
 (CENeg *> RDY) = tpd_CENeg_RDY;

 if ( temp19 == 1'b0 && ~CENeg &&
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
        $setup ( A21 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);
        $setup ( A22 , posedge CLK &&& CLKPositive, tsetup_A0_CLK, Viol);

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
        $setup ( A21 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);
        $setup ( A22 , negedge CLK &&& CLKNegative, tsetup_A0_CLK, Viol);

        $setup ( A0  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A1  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A2  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A3  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A4  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A5  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A6  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A7  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A8  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A9  , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A10 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A11 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A12 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A13 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A14 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A15 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A16 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A17 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A18 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A19 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A20 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A21 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);
        $setup ( A22 , posedge AVDNeg ,  tsetup_A0_AVDNeg, Viol);

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
        $setup ( A21 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);
        $setup ( A22 , negedge WENeg &&& CheckAddrWE, tsetup_A0_WENeg, Viol);

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
        $setup ( A21 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);
        $setup ( A22 , negedge CENeg &&& CheckAddrCE, tsetup_A0_CENeg, Viol);

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

        $setup ( CENeg  ,negedge AVDNeg &&& CENeg_Low   ,  tsetup_CENeg_AVDNeg, Viol);
        $setup ( CENeg  ,posedge CLK &&& CLKPositive_CENeg_Low ,  tsetup_CENeg_CLK   , Viol);
        $setup ( CENeg  ,negedge CLK &&& CLKNegative_CENeg_Low ,  tsetup_CENeg_CLK   , Viol);
        $setup ( AVDNeg ,negedge CLK &&& AVDCheckN   ,  tsetup_AVDNeg_CLK  , Viol);
        $setup ( AVDNeg ,posedge CLK &&& AVDCheckP   ,  tsetup_AVDNeg_CLK  , Viol);
        $setup ( OENeg  ,posedge CLK &&& CLKPositiveOES ,  tsetup_OENeg_CLK   , Viol);
        $setup ( OENeg  ,negedge CLK &&& CLKNegativeOES ,  tsetup_OENeg_CLK   , Viol);
        $setup ( CENeg  ,negedge WENeg &&& CENeg_Low ,  tsetup_CENeg_WENeg , Viol);
        $setup ( AVDNeg ,negedge WENeg &&&  AVDNeg_Low         ,  tsetup_AVDNeg_WENeg, Viol);
        $setup ( CLK    ,negedge WENeg &&&  CheckCLKWE ,tsetup_CLK_WENeg   , Viol);
        $hold ( negedge WENeg , AVDNeg &&& AVDNeg_Low  , thold_AVDNeg_WENeg, Viol);
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
        $hold ( posedge CLK &&& CLKPositive, A21 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& CLKPositive, A22 , thold_A0_CLK, Viol);

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
        $hold ( negedge CLK &&& CLKNegative, A21 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& CLKNegative, A22 , thold_A0_CLK, Viol);

        $hold ( posedge AVDNeg , A0 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A1 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A2 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A3 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A4 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A5 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A6 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A7 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A8 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A9 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A10 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A11 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A12 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A13 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A14 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A15 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A16 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A17 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A18 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A19 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A20 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A21 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg , A22 , thold_A0_AVDNeg, Viol);

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
        $hold ( negedge WENeg &&& CheckAddrWE, A21 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CheckAddrWE, A22 , thold_A0_WENeg, Viol);

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
        $hold ( negedge CENeg &&& CheckAddrCE, A21 , thold_A0_CENeg, Viol);
        $hold ( negedge CENeg &&& CheckAddrCE, A22 , thold_A0_CENeg, Viol);

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
 parameter PPB_LOCK_SET        =6'd48;
 parameter PPB_PROGRAM_VERIFY  =6'd49;
 parameter PPB_ERASE_VERIFY    =6'd50;
 parameter OTP_PROTBIT         =6'd51;
 parameter EXIT_1              =6'd52;
 parameter EXIT_2              =6'd53;
 parameter EXIT_3              =6'd54;

 parameter DBank               = 2'b00;
 parameter CBank               = 2'b01;
 parameter BBank               = 2'b10;
 parameter ABank               = 2'b11;

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
    //////////////////////////////////////////////////////////
    //          RDY Pin Value Gen
    //////////////////////////////////////////////////////////
    always @(RY_async)
    begin
        if ( ConfReg[19] == 1'b1 && CENeg === 1'b0 )
            RY_zd1 = RY_async;
    end

    always @(RY_sync)
    begin
        if ( ConfReg[19] == 1'b0 && CENeg === 1'b0)
            RY_zd1 = RY_sync;
    end

    always @(negedge CENeg)
    begin
        if ( ConfReg[19] == 1'b0 )
            RY_zd1 = 1'b0;
        else
            RY_zd1 = RY_async;
    end

    always @(posedge CENeg)
    begin
        RY_zd1 = 1'bz;
    end

    //Open-drain
    always @(RY_zd1)
    begin
        if ( ConfReg[19] == 1'b1 && RY_zd1 === 1'b1 )
            RY_zd = 1'bz;
        else
            RY_zd = RY_zd1;
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
    //1. TimingModel has format as
    //"am29bds128hXXXXX"
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
        tmp_char[j] = TimingModel[(i-11)*8+j];//Reduced/Standard character is 12
        end                                  //characters right from first ("a")
    end
    if (tmp_char == "5" || tmp_char == "8")
        Reduced = 1'b1;
    else if (tmp_char == "6" || tmp_char == "9")
        Reduced = 1'b0;

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
            //System interface string
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
            CFI_array[8'h27] = 8'h18;
            CFI_array[8'h28] = 8'h01;
            CFI_array[8'h29] = 8'h00;
            CFI_array[8'h2A] = 8'h00;
            CFI_array[8'h2B] = 8'h00;
            CFI_array[8'h2C] = 8'h03;
            CFI_array[8'h2D] = 8'h07;
            CFI_array[8'h2E] = 8'h00;
            CFI_array[8'h2F] = 8'h20;
            CFI_array[8'h30] = 8'h00;
            CFI_array[8'h31] = 8'hFD;
            CFI_array[8'h32] = 8'h00;
            CFI_array[8'h33] = 8'h00;
            CFI_array[8'h34] = 8'h01;
            CFI_array[8'h35] = 8'h07;
            CFI_array[8'h36] = 8'h00;
            CFI_array[8'h37] = 8'h20;
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
            CFI_array[8'h45] = 8'h0C;
            CFI_array[8'h46] = 8'h02;
            CFI_array[8'h47] = 8'h01;
            CFI_array[8'h48] = 8'h00;
            CFI_array[8'h49] = 8'h07;
            CFI_array[8'h4A] = 8'hE7;
            CFI_array[8'h4B] = 8'h01;
            CFI_array[8'h4C] = 8'h00;
            CFI_array[8'h4D] = 8'hB5;
            CFI_array[8'h4E] = 8'hC5;
            CFI_array[8'h4F] = 8'h01;
            CFI_array[8'h50] = 8'h00;
            CFI_array[8'h57] = 8'h04;
            CFI_array[8'h58] = 8'h27;
            CFI_array[8'h59] = 8'h60;
            CFI_array[8'h5A] = 8'h60;
            CFI_array[8'h5B] = 8'h27;

            ASEL_array[8'h00] = 16'h0001;
            ASEL_array[8'h01] = 16'h227E;
            ASEL_array[8'h0E] = 16'h2218;
            ASEL_array[8'h0F] = 16'h2200;
            if ( ~Reduced )
            // Standard Handshake
                ASEL_array[8'h03] = 16'h0080;
            else
                ASEL_array[8'h03] = 16'h00A0;
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
           //am29bds128h_prot  sector protect file
           //   //      - comment
           //   @aaa    - <aaa> stands for sector address
           //   (aaaa is incremented at every load)
           //   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
           //am29bds128h memory preload file
          //  @aaaa   - <aaaa> stands for address within last defined sector
          //  dd      - <dd> is byte to be written at Mem(nn)(aaaa++)
          // (aaaa is incremented at every load)
          // preload sector 7 in bank A with recognizable data
          // for burst read mode testing
          // address range to be filled is 90h to FFh
          // Fill region near bank boundary B-->A with recognizable data
          // preload last sector in bank B (230) and first one in bank A (231)
          // for burst read mode with bank cross testing
          // address range to be filled is 16#7FF0# to 16#7FFF# within
          // sector 230 and 16#00# to 16#6F# in sector 231
          // verify bank boundary read bahavior with crosses to busy and
          // non-busy bank

           $readmemh(mem_file_name,Mem);
        end
        if (UserPreload && !(secsi_file_name == "none"))
        begin
          // am29bds_secsi memory file
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
        ReadINIT = 1'b1;
        BURST    = 1'b1;

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

        READ_MODE = NO_SYNC;
        ConfReg[19:12] = 8'b11100101;
        PPBLock = 1'b0;
        PPMLB = 1'b0;
        SPMLB = 1'b0;
        SSPB = 1'b0;
        for(i=0;i<=3;i=i+1)
            Password[i] = MaxData;
        DYB = 0;
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
    time EraseSIM;
        EraseSIM = tdevice_PROTE;
        #(EraseSIM - 1) PBERASE_out = 1'b1;
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
    // Burst Access
    always @(posedge TRCC_in or posedge ROWBOUND_in)
    begin : ReadCycleTime
        #(tdevice_TRCC - 1) TRCC_out = 1'b1;
    end
    always @(negedge TRCC_in or negedge ROWBOUND_in)
    begin
        disable ReadCycleTime;
        TRCC_out = 1'b0;
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

    ///////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ///////////////////////////////////////////////////////////////////////////
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

//    /////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    /////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

    always @(CLK)
    begin
        if (ConfReg[17] == 1'b1)
            CLKMerge = CLK;
        else
            CLKMerge = ~CLK;
    end

//    /////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    /////////////////////////////////////////////////////////////////////////

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
           TRCC_in = 1'b0;
           TRCC_in <= #1 1'b1;
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
        if ( ~CENeg && WENeg
        && reseted==1'b1 && ConfReg[19] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
        end
        RY_sync = 1'b0;
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
           TRCC_in = 1'b0;
           TRCC_in <= #1 1'b1;
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
        // Asynchronous WRITE cycle Address Latch
        // Supported in synchronous mode
        if ( ~gCE_n && ~gWE_n && gOE_n && ~AVDNeg &&
        reseted==1'b1 && ConfReg[19] == 1'b0 )
        begin
            READCYCLE = 1'b0;
            WRITECYCLE = 1'b1;
            LATCHED = 1'b1;
            AddressLatched = A;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            Addr =  AddressLatched - AddrLO;
        end
    end

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program Operation
//    // start/ suspend/ resume
//    /////////////////////////////////////////////////////////////////////////

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
                ACC &&
                ~(~WPNeg && (SA <= 3 || SA >= SecNum-3)) &&
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

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    /////////////////////////////////////////////////////////////////////////
 integer cnt_erase = 0;      // 0 - SecNum+SubSecNum
 time elapsed_erase;
 time duration_erase;
 time start_erase;
 time seoSMALL;
 time seoLARGE;

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
                seoSMALL  = tdevice_SEO4KW;
                seoLARGE  = tdevice_SEO32KW;
                cnt_erase = 0;
                duration_erase = 0;
                for (i=0;i<=SecNum;i=i+1)
                    if ( Ers_queue[i] &&
                    ~DYB[i] && ~PPB[GroupID(i)] &&
                    ~(~WPNeg && (i <= 3 || i >= SecNum-3)) &&
                    ACC )
                    begin
                        cnt_erase = cnt_erase +1;
                        if ( i <= 7 || i >= SecNum-7 )
                            duration_erase = duration_erase + seoSMALL;
                        else
                            duration_erase = duration_erase + seoLARGE;
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

//    /////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    /////////////////////////////////////////////////////////////////////////

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
                else if (A_PAT_1 && (DataLo == 8'hC0))
                    next_state = RESET;
                else if (A_PAT_1 && (DataLo == 8'h38) && ~PPMLB)
                    next_state = PASSPROG_PREL;
                else if (A_PAT_1 && (DataLo == 8'hC8))
                    next_state = PASSVERIFY;
                else if (A_PAT_1 && (DataLo == 8'h28))
                    next_state = PASSUNLOCK0;
                else if (A_PAT_1 && (DataLo == 8'h60))
                    next_state = PROTBIT_PREL;
                else if (A_PAT_1 && (DataLo == 8'h78))
                    next_state = PPB_LOCK_SET;
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
                else if (DataLo==16'h30 && ~(ULBYPASS && BankID != BankUBPASS))
                    next_state = SERS;
                else if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end

            SERS :
            begin
                if (~CTMOUT)
                    if (DataLo == 16'hB0 && BusyBankE(BankID))
                        next_state = ESP; // ESP according to datasheet
                    else if (DataLo==16'h30) //&& BankID == BankERASE)
                        next_state = SERS;
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
                    else
                        next_state = RESET;
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
                else if ( (Addr % 12'h100 == 8'h55 ||
                (ULBYPASS && BankID == BankUBPASS))&& DataLo == 8'h98 )
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
                if (Ers_queue[SecAddr] != 1'b1)
                    next_state = PGMS; //set ESP
            end

            ESP_AS :
            begin
                if (DataLo == 16'hF0)
                     next_state = ESP;
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
                if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PASSVERIFY;
                end
            end

            PASSUNLOCK0 :
            begin
                if ((Addr % 4 == 0) )
                    next_state = PASSUNLOCK1;
                else
                    next_state = RESET;
            end

            PASSUNLOCK1 :
            begin
                if ((Addr % 4 == 1) )
                    next_state = PASSUNLOCK2;
                else
                    next_state = RESET;
            end

            PASSUNLOCK2 :
            begin
                if ((Addr % 4 == 2) )
                    next_state = PASSUNLOCK3;
                else
                    next_state = RESET;
            end

            PASSUNLOCK3 :
            begin
                if ((Addr % 4 == 3) )
                    next_state = PASSUNLOCK;
                else
                    next_state = RESET;
            end

            PASSUNLOCK :
            begin
                if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PASSUNLOCK;
                end
            end

            PPB_LOCK_SET :
            begin
                if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PPB_LOCK_SET;
                end
            end

            PROTBIT_PREL :
            begin
                if (DataLo == 16'h68 && (Addr % 16'h100 == WP) )
                    next_state = PPB_PROGRAM;
                else if (DataLo == 16'h60 && (Addr % 16'h100 == WPE) )
                    next_state = PPB_ERASE;
                else if (DataLo == 16'h68 && (Addr % 16'h100 == PL) )
                    next_state = PPMLB_PROGRAM;
                else if (DataLo == 16'h68 && (Addr % 16'h100 == SL) )
                    next_state = SPMLB_PROGRAM;
                //else if (DataLo == 16'h68 && (Addr % 16'h100 == OW) )
                //    next_state = SSPB_PROGRAM;
                else
                    next_state = RESET;
            end

            PPBDYB :
            begin
                if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PPBDYB;
                end
            end

            DYBWE :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
            end

            PPB_PROGRAM :
            begin
                if ( PBPROG_out == 1'b1
                && DataLo == 16'h48 && ( Addr % 16'h100 == WP ) )
                    next_state = PPB_PROGRAM_VERIFY;
            end

            PPB_PROGRAM_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
                else if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PPB_PROGRAM_VERIFY;
                end
                else if (DataLo == 16'h68 && (Addr % 16'h100 == WP) )
                    next_state = PPB_PROGRAM;
            end

            PPB_ERASE :
            begin
                if ( PBERASE_out == 1'b1
                && DataLo == 16'h40 && ( Addr % 16'h100 == WPE ) )
                    next_state = PPB_ERASE_VERIFY;
            end

            PPB_ERASE_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
                else if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PPB_ERASE_VERIFY;
                end
                else if (DataLo == 16'h60 && (Addr % 16'h100 == WPE) )
                    next_state = PPB_ERASE;
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
                else if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = PPMLB_VERIFY;
                end
            end

            SPMLB_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = RESET;
                else if ( PATTERN_1 )
                begin
                    next_state = EXIT_1;
                    ExitFrom = SPMLB_VERIFY;
                end
            end

            SSPB_VERIFY :
            begin
                if ( DataLo == 16'hF0 )
                    next_state = OTP;
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
                else if (A_PAT_1 && (DataLo == 16'h60))
                    next_state = OTP_PROTBIT;
                else
                    next_state = OTP;
            end

            OTP_PROTBIT :
            begin
                if ((DataLo == 16'h68) && (Addr % 16'h100 == OW))
                    next_state = SSPB_PROGRAM;
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

            EXIT_1 :
            begin
                if ( PATTERN_2 )
                    next_state = EXIT_2;
                else
                    next_state = ExitFrom;
            end

            EXIT_2 :
            begin
                if (A_PAT_1 && (DataLo == 16'h90))
                    next_state = EXIT_3;
                else
                    next_state = ExitFrom;
            end

            EXIT_3 :
            begin
                if ( DataLo == 16'h00 )
                    next_state = RESET;
                else
                    next_state = ExitFrom;
            end

            ERS, ESPS, PGMS :
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

            PREL_ULBYPASS :
            begin
                if (BankID != BankUBPASS)
                    BURST_TR = 1'b1;
            end

            CFI :
            begin
                SYNCREAD = 1'b1;
            end

            UBP_CFI :
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

            PASSPROG :
            begin
                SYNCREAD = 1'b1;
            end

            PASSVERIFY :
            begin
                SYNCREAD = 1'b1;
            end

            PASSUNLOCK :
            begin
                SYNCREAD = 1'b1;
            end

            PPBDYB :
            begin
                SYNCREAD = 1'b1;
            end

            PPB_PROGRAM_VERIFY :
            begin
                SYNCREAD = 1'b1;
            end

            PPB_ERASE_VERIFY :
            begin
                SYNCREAD = 1'b1;
            end

            PPMLB_VERIFY :
            begin
                SYNCREAD = 1'b1;
            end

            SPMLB_VERIFY :
            begin
                SYNCREAD = 1'b1;
            end

            SSPB_VERIFY :
            begin
                SYNCREAD = 1'b1;
            end

            OTP :
            begin
                SYNCREAD = 1'b1;
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

    //ERS state, SERS_EXEC state, EDONE/EERR
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

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

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
            INITIAL = 1'b1;
            BurstBorder = ConfReg[16:15]*8;
            if (ConfReg[16:15] == 2'b11)
                BurstBorder = 32;
            BurstAddr = Addr;
            BurstSect = SecAddr;
            BurstDelay = BurstDelay + ConfReg[14:12] + 1;
            RESUMED = 1'b1;
            STALL = 1'b0;
            LatencyRESUME = 1'b0;
            LatencyBUSY = 1'b0;
            LatencyBOUND = 1'b0;
            if (ConfReg[16:15] == 2'b0)
            begin
               LATCHED_3E_3F =
               (( BurstAddr % 8'h40 == 8'h3E ) ||
               ( BurstAddr % 8'h40 == 8'h3F ));
               if ( Reduced && LATCHED_3E_3F )
                   BurstDelay = BurstDelay + 2;
               else if ( Reduced && BurstAddr % 2 == 1 )
                   BurstDelay = BurstDelay + 1;
            end
            else
            begin
                WrapMax = 128;
                if ( Reduced && BurstAddr % 2 == 1 )
                    BurstDelay = BurstDelay + 1;
            end
        end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                RY_async = 1'b1;
                ESP_ACT = 1'b0;
                if (~READ)
                    DOut_zd = READMEM(SecAddr,Addr);
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
                    else if (A_PAT_1 && (DataLo==16'h78))
                        PPBLock = 1'b1;
            end

            PREL_ULBYPASS :
            begin
                if ( BankID == BankUBPASS )
                    OutputD = 16'bz;
                else
                    OutputD = READMEM(SecAddr,Addr);
                if (~READ)
                begin
                    DOut_zd = OutputD;
                    SyncData = OutputD;
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
                        OutputD[0] = PPB[GroupID(SecAddr)];
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
                    WData = Data;
                    WAddr = Addr;
                    SA = SecAddr;
                    temp = Data % 12'h100;
                    Status[7] = ~temp[7];
                    RY_async = 1'b0;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                end
            end

            C8_PREL :
            begin
                if (~WRITE)
                    if ((A_PAT_1 || ULBYPASS) && (DataLo==16'h10))
                    begin
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        RY_async = 1'b0;
                        ERES   = 1'b0;
                        ESUSP = 1'b0;
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
                if (~READ)
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
                        RY_async = 1'b0;
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
                RY_async = 1'b0;
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
             else if (~READ)
                 $display("Invalid CFI query address");
             if (~READ)
             begin
                 DOut_zd = OutputD;
                 SyncData = OutputD;
             end
        end

        ESP_A0SEEN :
        begin
            if ((~WRITE) && (Ers_queue[SecAddr] != 1'b1))
            begin
                ESP_ACT = 1'b1;
                //PSTART = '1', '0' AFTER 1 ns;
                PSTART = 1'b1;
                PSTART <= #1 1'b0;
                RY_async = 1'b0;
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
            begin
                SyncData = OutputD;
                DOut_zd = OutputD;
            end
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

        PASSPROG_PREL :
        begin
            if (~WRITE )
            begin
                WAddrPass = Addr % 4;
                WDataPass = Data;
                PASSPDONE_in = 1'b0;
                #1 PASSPDONE_in <= 1'b1;
                RY_async = 1'b0;
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
            end
            if (~READ )
            begin
                DOut_zd = Status;
                SyncData = Status;
            end
        end

        PASSVERIFY :
        begin
            if ( PPMLB != 1'b1 )
                OutputD = Password[Addr % 4];
            else
                OutputD = ~(0);
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        PASSUNLOCK0 :
        begin
            if ( ~WRITE && (Addr % 4 == 0) )
                UnlockPass = ( Password[Addr % 4] == Data );
        end

        PASSUNLOCK1 :
        begin
            if ( ~WRITE && (Addr % 4 == 1) )
                UnlockPass =  ( UnlockPass && Password[Addr % 4] == Data );
        end

        PASSUNLOCK2 :
        begin
            if (~WRITE && (Addr % 4 == 2) )
                UnlockPass =  ( UnlockPass && Password[Addr % 4] == Data );
        end

        PASSUNLOCK3 :
        begin
            if (~WRITE && (Addr % 4 == 3) )
            begin
                UnlockPass =  ( UnlockPass && Password[Addr % 4] == Data );
                UNLOCKDONE_in = 1'b0;
                #1 UNLOCKDONE_in <= 1'b1;
                RY_async = 1'b0;
            end
        end

        PASSUNLOCK :
        begin
            if (~READ && UNLOCKDONE_out == 1'b0 )
                Status[6] = ~Status[6];
            if (~READ )
            begin
                DOut_zd = Status;
                SyncData = Status;
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
                    RY_async = 1'b0;
                end
                else if ( DataLo == 16'h60 && (Addr % 16'h100 == WPE) )
                begin
                    PBERASE_in = 1'b0;
                    #1 PBERASE_in <= 1'b1;
                    RY_async = 1'b0;
                end
                else if ( DataLo == 16'h68 && (Addr % 16'h100 == PL) )
                begin
                    PBPROG_in = 1'b0;
                    #1 PBPROG_in <= 1'b1;
                    RY_async = 1'b0;
                end
                else if ( DataLo == 16'h68 && (Addr % 16'h100 == SL) )
                begin
                    PBPROG_in = 1'b0;
                    #1 PBPROG_in <= 1'b1;
                    RY_async = 1'b0;
                end
        end

        PPBDYB :
        begin
            OutputD = 0;
            OutputD[1] = PPBLock;
            OutputD[0] = DYB[SecAddr];
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
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

        PPB_PROGRAM_VERIFY :
        begin
            OutputD = 0;
            OutputD[0] = PPB[GroupID(SecAddr)];
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        PPB_ERASE_VERIFY :
        begin
            OutputD = 0;
            OutputD[0] = PPB[GroupID(SecAddr)];
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        Z001, C8, C8_Z001,
        PPB_PROGRAM, ESP_Z001, OTP_AS, OTP_Z001, OTP_PREL,
        EXIT_1, EXIT_2, EXIT_3, PPB_LOCK_SET,
        PPB_ERASE, PPMLB_PROGRAM, SPMLB_PROGRAM, SSPB_PROGRAM :
        begin
        end

        PPMLB_VERIFY :
        begin
            if (Addr % 16'h100 == PL )
            begin
                OutputD = 0;
                OutputD[0] = PPMLB;
            end
            else
                OutputD = 16'bz;
            if ( ~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        SPMLB_VERIFY :
        begin
            if (Addr % 16'h100 == SL )
            begin
                OutputD = 0;
                OutputD[0] = SPMLB;
            end
            else
                OutputD = 16'bz;
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        SSPB_VERIFY :
        begin
            if (Addr % 16'h100 == OW )
            begin
                OutputD = 0;
                OutputD[0] = SSPB;
            end
            else
                OutputD = 16'bz;
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        OTP :
        begin
            SecSiAddr = Addr % (SecSiSize + 1);
            if (SecSi[SecSiAddr] == -1 )
                OutputD = 16'bx;
            else
                OutputD = SecSi[SecSiAddr];
            if (~READ )
            begin
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
        end

        OTP_PROTBIT :
        begin
            if ( DataLo == 16'h68 && (Addr % 16'h100 == OW) )
            begin
                PBPROG_in = 1'b0;
                #1 PBPROG_in <= 1'b1;
                RY_async = 1'b0;
            end
        end

        OTP_A0SEEN :
        begin
            if ( ~WRITE )
            begin
                RY_async = 1'b0;
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

    if ( READ_MODE != NO_SYNC && READ_MODE != SYNCR && ~READ
    && (~RESUMED || STALL ))
        DOut_zd = 16'bz;

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
                    && ~(~WPNeg && (i <= 3 || i >= SecNum -3))
                    && ACC)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end
            if (EDONE)
            begin
                RY_async = 1'b1;
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if (DYB[i] == 1'b0
                    && PPB[GroupID(i)] == 1'b0
                    && ~(~WPNeg && (i <= 3 || i >= SecNum -3))
                    && ACC)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = MaxData;
                end
            end
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
                RY_async = 1'b0;
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
                RY_async = 1'b1;
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
                    && ~(~WPNeg && (i <= 3 || i >= SecNum -3))
                    && ACC && Ers_queue[i] )
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end

                if (EDONE)
                begin
                    RY_async = 1'b1;
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                         ADDRHILO(SecErsLOW,SecErsHIGH,i);
                         if (DYB[i] == 1'b0
                         && PPB[GroupID(i)] == 1'b0
                         && ~(~WPNeg && (i <= 3 || i >= SecNum -3))
                         && ACC && Ers_queue[i] )
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
            RY_async = 1'b1;
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
                    RY_async = 1'b1;
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
            RY_async = 1'b1;
        end
    end

    //PASSUNLOCK state, UNLOCKDONE_out
    always @(posedge UNLOCKDONE_out)
    begin : PASSUNLOCKPP
        if ( current_state == PASSUNLOCK )
        begin
            if ( UnlockPass )
                PPBLock = 1'b0;
            RY_async = 1'b1;
        end
    end

    //PPB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : PPB_PROGRAM2
        if (current_state == PPB_PROGRAM )
        begin
            if (PPBLock == 1'b0)
                PPB[GroupID(PBSecAddr)] = 1'b1;
            RY_async = 1'b1;
        end
    end

    //PPB_ERASE state, PBERASE_out
    always @(posedge PBERASE_out)
    begin : PPB_ERASE2
        if (current_state == PPB_ERASE)
        begin
            if (PPBLock == 1'b0)
                PPB = 0;
            RY_async = 1'b1;
        end
    end

    //PPMLB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : PPMLB_PROGRAM2
        if (current_state == PPMLB_PROGRAM)
        begin
            if (SPMLB != 1'b1)
                PPMLB = 1'b1;
            RY_async = 1'b1;
        end
    end

    //SPMLB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : SPMLB_PROGRAM2
        if (current_state == SPMLB_PROGRAM)
        begin
            if (PPMLB != 1'b1)
                SPMLB = 1'b1;
            RY_async = 1'b1;
        end
    end

    //SSPB_PROGRAM state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : SSPB_PROGRAM2
        if (current_state == SSPB_PROGRAM)
        begin
            SSPB = 1'b1;
            ASEL3 = ASEL_array[3];
            ASEL3[6] = 1'b1;
            ASEL_array[3] = ASEL3;
            RY_async = 1'b1;
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
        if (READ_MODE == NO_SYNC || READ_MODE == SYNCR || INITIAL)
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
           READ_MODE = NO_SYNC;
            BankERASE = 0;
            OTP_ACT = 1'b0;
            if ( PPMLB == 1'b1 )
                PPBLock = 1'b1;
            else
                PPBLock = 1'b0;
            DYB = 0;
            ESP_ACT = 1'b0;
            ULBYPASS = 1'b0;
            READ_MODE = NO_SYNC;
            ConfReg[19:12] = 8'b11100101;
            PBPROG_in = 1'b0;
            PBERASE_in = 1'b0;
            PASSPDONE_in = 1'b0;
            UNLOCKDONE_in = 1'b0;
        end
    end

    //Synchronous READ modes
    always @(posedge CLKMerge or negedge ReadINIT)
    begin
        case ( READ_MODE )
            LINEAR :
            begin
                   // Linear Burst 8/16/32
                    if ( BurstDelay == 1 && OENeg )
                        STALL = 1'b1;

                    if ( BurstDelay > 0 && ~STALL )
                    begin
                        BurstDelay = BurstDelay - 1;
                        RY_sync = 1'b0;
                        // When Initial delay set to two CLK cycles
                        // RDY defaults to being active with data
                        if ( ConfReg[18] == 1'b0 && BurstDelay == 1 &&
                        ~OENeg )
                            RY_sync = 1'b1;
                    end
                    else if (STALL )
                    begin
                        if ( BurstDelay > 0 )
                            BurstDelay = BurstDelay - 1;
                        if ( ~OENeg )
                            STALL = 1'b0;
                        RY_sync = 1'b0;
                    end

                    if ( BurstDelay == 0 && WrapMax > 0 && ~STALL )
                    begin
                        if ( TIACC_out == 1'b1 && TRCC_out == 1'b0 )
                            if ( OENeg == 1'b0 )
                            begin
                                if ( RESUMED )
                                begin
                                    INITIAL = 1'b0;
                                    AddrSuspend = BurstAddr;
                                    SectSuspend = BurstSect;
                                    WrapMax = WrapMax - 1;
                                    if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr - 1 &&
                                    ResumeCODE == 0 )
                                    begin
                                    // Latency cycles after Burst Resume
                                    // Reduced devices
                                        RY_sync = ConfReg[18];
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                        ResumeCODE = 1;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr &&
                                    ResumeCODE == 1 )
                                    begin
                                        RY_sync = 1'b0;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        ResumeCODE = 2;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr &&
                                    ResumeCODE == 2 )
                                    begin
                                        RY_sync = ~ConfReg[18];
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        ResumeCODE = 3;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr &&
                                    ResumeCODE == 3 )
                                    begin
                                        RY_sync = 1'b1;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                        ResumeCODE = 4;
                                        LatencyRESUME = 1'b0;
                                    end
                                    else
                                    begin
                                        RY_sync = 1'b1;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                    end
                                    if ( BurstAddr % BurstBorder == 0 )
                                    begin
                                         BurstAddr = BurstAddr - BurstBorder;
                                    end
                                end
                                else // ~RESUMED
                                begin
                                    RESUMED = 1'b1;
                                    DOut_zd =
                                    READMEM(SectSuspend,AddrSuspend);
                                    RY_sync = RYSuspend;
                                end
                            end
                            else // OE# HIGH
                            begin
                                if ( RESUMED )
                                    RYSuspend = RY_sync;
                                RY_sync = 1'b0;
                                DOut_zd = 16'bz;
                                RESUMED = 1'b0;
                                //LatencyBOUND = 1'b0;
                                if ( Reduced )
                                begin
                                    LatencyAddr = AddrSuspend;
                                    LatencySect = SectSuspend;
                                    UpdateADDRL(LatencyAddr, BurstBorder);
                                    UpdateADDRL(LatencyAddr, BurstBorder);
                                    if ((AddrSuspend % 16'h40 ) % 2 == 0 )
                                        UpdateADDRL(LatencyAddr, BurstBorder);
                                    LatencyRESUME = 1'b1;
                                    ResumeCODE = 0;
                                end
                                else
                                    LatencyRESUME = 1'b0;
                            end
                        else//tIACC ~PASSED, AFTER CLKs COUNTED
                            RY_sync = 1'b0;
                    end
                    else if (BurstDelay == 0 && WrapMax == 0 )
                        RY_sync = 1'b0;

                    if ( TIACC_out != 1'b1)
                        RY_sync = 1'b0;
            end

            CONTINUOUS :
            begin
                 //Continuous Burst
                    if ( BurstDelay == 1 && OENeg == 1'b1 )
                         STALL = 1'b1;
                    if ( BurstDelay > 0 && ~STALL )
                    begin
                         BurstDelay = BurstDelay - 1;
                         RY_sync = 1'b0;
                         // When Initial delay set to two CLK cycles
                         // RDY defaults to being active with data
                         if (ConfReg[18] == 1'b0 && BurstDelay == 1 &&
                         OENeg == 1'b0 )
                             RY_sync = 1'b1;
                    end
                    else if ( STALL )
                    begin
                        if ( BurstDelay > 0 )
                            BurstDelay = BurstDelay - 1;
                        if ( OENeg == 1'b0 )
                            STALL = 1'b0;
                        RY_sync = 1'b0;
                    end

                    if ( BurstDelay == 0 && ~STALL )
                        if ( TIACC_out == 1'b1 && TRCC_out == 1'b0 )
                            if ( OENeg == 1'b0 )
                            begin
                                if (RESUMED )
                                begin
                                    INITIAL = 1'b0;
                                    AddrSuspend = BurstAddr;
                                    SectSuspend = BurstSect;
                                    BurstOffset = BurstAddr % 16'h40;
                                    if ( BurstOffset == 0 )
                                        LATCHED_3E_3F = 1'b0;
                                    if ( LatencyBUSY && BusyCODE == 0 )
                                    begin
                                        RY_sync = ~ConfReg[18];
                                        BusyCODE = 1;
                                    end
                                    else if ( LatencyBUSY && BusyCODE == 1 )
                                    begin
                                    // For busy sector read status returned
                                    // data will not progress
                                        RY_sync = 1'b1;
                                        DOut_zd = CrossData;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr -1 &&
                                    BurstSect == LatencySect &&
                                    ResumeCODE == 0 )
                                    begin
                                    // Latency cycles after Burst Resume
                                    // Reduced devices
                                        RY_sync = ConfReg[18];
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                        ResumeCODE = 1;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr  &&
                                    BurstSect == LatencySect &&
                                    ResumeCODE == 1 )
                                    begin
                                        RY_sync = 1'b0;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        ResumeCODE = 2;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr  &&
                                    BurstSect == LatencySect &&
                                    ResumeCODE == 2 )
                                    begin
                                        RY_sync = ~ConfReg[18];
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        ResumeCODE = 3;
                                    end
                                    else if ( LatencyRESUME &&
                                    BurstAddr == LatencyAddr  &&
                                    BurstSect == LatencySect &&
                                    ResumeCODE == 3 )
                                    begin
                                        RY_sync = 1'b1;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                        ResumeCODE = 4;
                                        LatencyRESUME = 1'b0;
                                    end
                                    else if ( BurstOffset == 16'h3E &&
                                    ~LATCHED_3E_3F )
                                    begin
                                    // Row Boundary Latencies
                                        //LatencyBOUND = 1'b1;
                                        //BoundCODE = 0;
                                        RY_sync = ConfReg[18];
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                    end
                                    else if ( BurstOffset == 16'h3F &&
                                    ~LATCHED_3E_3F && ~LatencyBOUND )
                                    begin
                                        ROWBOUND_in = 1'b0;
                                        #1 ROWBOUND_in = 1'b1;
                                        LatencyBOUND = 1'b1;
                                        RY_sync = 1'b0;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BoundCODE = 1;
                                    end
                                    else if ( LatencyBOUND && BoundCODE == 1 )
                                    begin
                                        RY_sync = ~ConfReg[18];
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BoundCODE = 2;
                                    end
                                    else if ( LatencyBOUND && BoundCODE == 2 )
                                    begin
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        CheckBoundary(BusyBOUND, CrossData,
                                        BurstAddr, BurstSect);
                                        UpdateADDR(BurstSect,BurstAddr);
                                        if ( ~BusyBOUND )
                                            RY_sync = 1'b1;
                                        else
                                        begin
                                            RY_sync = ConfReg[18];
                                            LatencyBUSY = 1'b1;
                                            BusyCODE = 0;
                                        end
                                        BoundCODE = 3;
                                        LatencyBOUND = 1'b0;
                                    end
                                    else if (BurstOffset == 16'h3E &&
                                    LATCHED_3E_3F )
                                    begin
                                        RY_sync = 1'b1;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                    end
                                    else if (BurstOffset == 16'h3F &&
                                    LATCHED_3E_3F && ~LatencyBOUND )
                                    begin
                                        ROWBOUND_in = 1'b0;
                                        #1 ROWBOUND_in <= 1'b1;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        CheckBoundary(BusyBOUND, CrossData,
                                        BurstAddr, BurstSect);
                                        UpdateADDR(BurstSect,BurstAddr);
                                        if ( ~BusyBOUND )
                                            RY_sync = 1'b1;
                                        else
                                        begin
                                            RY_sync = ConfReg[18];
                                            LatencyBUSY = 1'b1;
                                            BusyCODE = 0;
                                        end
                                    end
                                    else
                                    begin
                                        RY_sync = 1'b1;
                                        DOut_zd =
                                        READMEM(BurstSect,BurstAddr);
                                        BurstAddr = BurstAddr + 1;
                                    end
                                end
                                else // ~RESUMED
                                begin
                                    RESUMED = 1'b1;
                                    DOut_zd =
                                    READMEM(SectSuspend,AddrSuspend);
                                    RY_sync = RYSuspend;
                                end//RESUMED 1'b1/FALSE
                            end
                            else//OE HIGH
                            begin
                                if (RESUMED )
                                    RYSuspend = RY_sync;
                                RY_sync = 1'b0;
                                DOut_zd = 16'bz;
                                RESUMED = 1'b0;
                                //LatencyBOUND = 1'b0;
                                if ( Reduced &&
                                AddrSuspend % 16'h40 != 16'h3C &&
                                AddrSuspend % 16'h40 != 16'h3D )
                                begin
                                    LatencyAddr = AddrSuspend;
                                    LatencySect = SectSuspend;
                                    UpdateADDR(LatencySect, LatencyAddr);
                                    UpdateADDR(LatencySect, LatencyAddr);
                                    if ((AddrSuspend % 16'h40 ) % 2 == 0 )
                                        UpdateADDR(LatencySect, LatencyAddr);
                                    LatencyRESUME = 1'b1;
                                    ResumeCODE = 0;
                                end
                                else
                                    LatencyRESUME = 1'b0;
                            end//OE# LOW/HIGH
                        else//tIACC == 1'b0
                            RY_sync = 1'b0;//NOT TRCC_out;
                    if ( TIACC_out != 1'b1)
                        RY_sync = 1'b0;
                end

            SYNCR :
            begin
                // sync READ operation, does not iterate like BURST MODE
                // Data returned after initial delay
                    if ( BurstDelay > 0 )
                    begin
                        BurstDelay = BurstDelay - 1;
                        RY_sync = 1'b0;
                        // When Initial delay set to two CLK cycles
                        // RDY defaults to being active with data
                        if (ConfReg[18] == 1'b0 && BurstDelay == 1 &&
                        ConfReg[14:12] != 0 )
                            RY_sync = 1'b1;
                    end
                    if (OENeg == 1'b0 && BurstDelay == 0 )
                        RY_sync = 1'b1;
                    else if (OENeg == 1'b1 )
                        RY_sync = 1'b0;
            end

            NO_SYNC :
            begin
            end

        endcase
    end

  function [11:0] ReturnSectorID;
  input [HiAddrBit:0] ADDR;
  integer conv;
  begin
       conv = ADDR / 16'h8000;
       if ( conv == 0 )
          ReturnSectorID = ADDR / 16'h1000;
       else if (( conv >= 1 ) && ( conv <= 254 ))
          ReturnSectorID = 7 + conv;
       else
          ReturnSectorID = 262 + (ADDR - 23'h7F8000)/16'h1000;
  end
  endfunction

  function[9:0] GroupID;
  input SECADDR;
  integer SECADDR;
  begin
      if ( SECADDR <= 10 )
          GroupID = SECADDR;
      else if ( SECADDR >= 11 && SECADDR <= 258 )
          GroupID = 11 + (SECADDR-11)/4;
      else
          GroupID = 73 + (SECADDR - 259);
  end
  endfunction

 function[1:0] ReturnBank;
 input[HiAddrBit:0] ADDR;
 begin
     if  ( ADDR / 23'h100000 == 0 )
         ReturnBank = DBank;
     else if ( ((ADDR / 23'h100000) >= 1) && ((ADDR / 23'h100000) <=3) )
         ReturnBank = CBank;
     else if ( ((ADDR / 23'h100000) >= 4) && ((ADDR / 23'h100000) <=6) )
         ReturnBank = BBank;
     else
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
     if (SecAddress <= 7)
         AddrBASE  = SecAddress*20'h01000;
     else if ((SecAddress > 7) && (SecAddress < 262))
         AddrBASE  = (SecAddress-7)*20'h8000;
     else
         AddrBASE  = 23'h7F8000 + (SecAddress-262)*16'h1000;
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
  else if ((SectorID > 7) && (SectorID < 262))
  begin
     AddrLOW  = (SectorID-7)*20'h8000;
     AddrHIGH = (SectorID-7)*20'h8000+16'h7FFF;
  end
  else
  begin
     AddrLOW  = 23'h7F8000 + (SectorID-262)*16'h1000;
     AddrHIGH = 23'h7F8000 + (SectorID-262)*16'h1000 + 16'h0FFF;
  end
 end
 endtask

 task UpdateADDR;
 inout  BurstSect;
 inout  BurstAddr;
 integer BurstSect;
 integer BurstAddr;
 integer AddrLOW;
 integer AddrHIGH;
 integer AddrCHECK;
 integer SecHlp2;
 begin
     SecHlp2 = BurstSect;
     ADDRHILO(AddrLOW, AddrHIGH, SecHlp2);
     AddrCHECK = AddrLOW + BurstAddr;
     //Address Update
     SecHlp = ReturnSectorID(AddrCHECK);
     SecTemp = ReturnSectorID((AddrCHECK+1) % (ADDRRange+1));
     if ( SecHlp != SecTemp )
     begin
         if ( BurstSect == SecNum )
             BurstSect = 0;
         else
         begin
             BurstSect = BurstSect + 1;
         end
         BurstAddr = 0;
     end
     else
         BurstAddr = BurstAddr + 1;
 end
 endtask

 task UpdateADDRL;
 inout   BurstAddr;
 input   BurstBorder;
 integer BurstAddr;
 integer BurstBorder;
 begin
     BurstAddr = BurstAddr + 1;
     if ( BurstAddr % BurstBorder == 0 )
         BurstAddr = BurstAddr - BurstBorder;
 end
 endtask

 task CheckBoundary;
 inout  BusyBOUND;
 inout[15:0] CrossData;
 inout  BurstAddr;
 inout  BurstSect;
 integer BurstAddr;
 integer BurstSect;
 integer AddrCHECK;
 integer AddrLOW;
 integer AddrHIGH;
 //integer SecHlp2;
 begin
     ADDRHILO(AddrLOW, AddrHIGH, BurstSect);
     AddrCHECK = AddrLOW + BurstAddr;
     BankCHECK =
     ReturnBank((AddrCHECK+1) % (ADDRRange+1));
     SectorCHECK =
     ReturnSectorID((AddrCHECK+1) % (ADDRRange+1));
     BusyBOUND = 1'b0;
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
     BusyBOUND =
     (BusyBOUND &&
     ( ReturnBank(AddrCHECK)!= BankCHECK ||
     ReturnSectorID(AddrCHECK)!= SectorCHECK ));
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
