//////////////////////////////////////////////////////////////////////////////
//  File name : s29al032d_03_04.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2005 SPANSION, LLC 
//
//  MODIFICATION HISTORY :
//
//  version: |  author:    |  mod date:   |  changes made:
//    V1.0     D.Lukovic     05 May 12      Initial release
//
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           S29AL032D
//
//  Description:    32Mbit (4M x8-Bit) Boot Sector Flash Memory
//
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module s29al032d_03_04
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
    RESETNeg ,
    WPNeg    ,
    BYTENeg  ,
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
    input  RESETNeg ;
    input  WPNeg    ;
    input  BYTENeg  ;
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
    assign A = {A20_ipd,
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
    wire  RESETNeg_ipd ;
    wire  WPNeg_ipd    ;
    wire  BYTENeg_ipd  ;

//  internal delays
    reg POW_in     ;
    reg POW_out    ;
    reg PO_in       ;
    reg PO_out      ;
    reg SEO_in      ;
    reg SEO_out     ;

    reg HANG_out    ; // Program/Erase Timing Limit
    reg HANG_in     ;
    reg START_T1    ; // Start TimeOut
    reg START_T1_in ;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

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

    reg [15 : 0] DOut_zd;
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

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";//"s29al032d_03_04.mem";
    parameter prot_file_name  = "none";//"s29al032d_03_04_prot.mem";
    parameter secsi_file_name = "none";//"s29al032d_03_04_secsi.mem";

    parameter TimingModel = "DefaultTimingModel";//"S29AL032D70TAI030";

    parameter PartID = "S29AL032D";
    parameter MaxData = 255;
    parameter SecSize = 65535;
    parameter SecSiSize = 255;
    parameter SecNum = 63;
    parameter SubSecNum = 7;
    parameter HiAddrBit = 20;
    parameter MemSize   = (SecNum + 1)*(SecSize + 1)-1;

    //Address of the Protected Sector
    integer  ProtSecNum = 63;

    //varaibles to resolve architecture used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;
    reg High;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg OTP_ACT  ; ////SecSi access
    reg ESP_ACT  ; ////Erase Suspend

    ////number of location to be writen in Write Buffer: 0-31 bytes.
    ////if 32 word/byte programming 
    
    reg PSTART   ; ////Start Programming
    reg PDONE    ; ////Prog. Done
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
    reg [SubSecNum:0] Ers_Sub_queue;

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SubSect = 0;         // 0 - SubSecNum
    integer SA      = 0;         // 0 TO SecNum
    integer SSA     = 0;         // 0 TO SubSecNum
    integer WBPage  = 0;
    //Address within sector
    integer Address = 0;         // 0 - SecSize

    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    //A22:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    integer WPage;         //0 TO 16'h7FF#
    integer RPage;         //0 TO 16'h2000#
    reg RPchange ;      // boolean = true;

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;
    //Sector Protection Status
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;
    reg [SubSecNum:0] SubSec_Prot;
    //SecSi ProtectionStatus
    reg FactoryProt;

    // timing check violation
    reg Viol = 1'b0;
    integer VarSect = 0;
    reg     vs;

    integer Mem[0:MemSize];
    integer CFI_array[16:90];
    integer SecSi[0:SecSiSize];

    integer WBData[0:1];
    integer WBAddr[0:1];

    integer BaseLoc = 0;

    integer cnt = 0;

    reg [1:0]Sec_Prot_reg  = 2'b0;

    //Status reg.
    reg[7:0] Status = 8'b0;
    integer S_ind = 0;
    integer ind = 0;
    reg Si = 1'b0;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    reg[7:0] temp;

    reg OTP_Err = 1'b0;
    reg oe = 1'b0;
    event oe_event;

    //TPD_XX_DATA
    time OEDQ_t;
    time CEDQ_t;
    time ADDRDQ_t;
    time OENeg_event;
    time CENeg_event;
    time ADDR_event;
    reg FROMOE;
    reg FROMCE;
    reg FROMBYTE;
    reg FROMADDR;
    integer   OEDQ_01;
    integer   CEDQ_01;
    integer   ADDRDQ;
    reg[15:0] TempData;

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
    buf   (RESETNeg_ipd , RESETNeg );
    buf   (WPNeg_ipd    , WPNeg    );
    buf   (BYTENeg_ipd  , BYTENeg  );

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

    nmos   (RY ,   1'b0      ,  ~RY_zd);

    wire deg;

    //Check Enable Equivalents

    //VHDL VITAL CheckEnable equivalents
    // Address setup/hold near WE# falling edge
    wire CheckEnable_A0_WE;
    assign CheckEnable_A0_WE = ~CENeg && OENeg;
    // Data setup/hold near WE# rising edge
    wire CheckEnable_DQ0_WE;
    assign CheckEnable_DQ0_WE = ~CENeg && OENeg && deg;
    // Address setup/hold near CE# falling edge
    wire CheckEnable_A0_CE;
    assign CheckEnable_A0_CE = ~WENeg && OENeg;
    // Data setup/hold near CE# rising edge
    wire CheckEnable_DQ0_CE;
    assign CheckEnable_DQ0_CE = ~WENeg && OENeg && deg;
    //WE# hold near OE# during read
    wire ReadProgress;
    assign ReadProgress = (( PDONE == 1 ) || ( EDONE == 1 ));
    //WE# hold near OE# during embd algs.
    wire EmbdProgress;
    assign EmbdProgress = (( PDONE == 0 ) || ( EDONE == 0 ));

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
    specparam           tpd_RESETNeg_DQ0        =1;
                      //(-,-,0,-,0,-)
    specparam           tpd_CENeg_RY            =1;    //tBUSY
    specparam           tpd_WENeg_RY            =1;    //tBUSY
    specparam           tpd_BYTENeg_DQ0         =1;

                        // tsetup values: setup time
    specparam           tsetup_A0_WENeg         =1;   //tAS edge \
    specparam           tsetup_DQ0_WENeg        =1;   //tDS edge /

                         // thold values: hold times
    specparam           thold_CENeg_RESETNeg    =1; //tRH  edge /
    specparam           thold_A0_WENeg          =1; //tAH  edge \
    specparam           thold_DQ0_CENeg         =1; //tDH edge /
    specparam           thold_WENeg_OENeg       =1; //tGHVL edge /
    specparam           thold_OENeg_WENeg       =1; //tOEH edge / 
    specparam           thold_BYTENeg_CENeg     =1; //telf, tehfl     

                        // tpw values: pulse width
    specparam           tpw_RESETNeg_negedge    =1; //tRP
    specparam           tpw_WENeg_negedge       =1; //tWP
    specparam           tpw_WENeg_posedge       =1; //tWPH
    specparam           tpw_CENeg_negedge       =1; //tCP
    specparam           tpw_CENeg_posedge       =1; //tCEPH
    specparam           tpw_A0_negedge          =1; //tWC tRC
    specparam           tpw_A0_posedge          =1; //tWC tRC ok 

                        // tdevice values: values for internal delays
                        //Effective Write Byte Program Operation  tWHWH1
    specparam   tdevice_POB                     = 9000; // 9 us
           //Program Operation
    specparam   tdevice_POW                     = 11000; //11 us;
           //Sector Erase Operation    tWHWH2
    specparam   tdevice_SEO                     = 700000000; //700 ms;
           //Timing Limit Exceeded
    specparam   tdevice_HANG                    = 400000000; //400 ms; //?
           //erase suspend timeout
    specparam   tdevice_START_T1                = 20000; //20 us;
           //sector erase command sequence timeout
    specparam   tdevice_CTMOUT                  = 50000; //50 us;
           //device ready after Hardware reset(during embeded algorithm)
    specparam   tdevice_READY                   = 20000; //20 us; //tReady

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
    (CENeg => RY) = tpd_CENeg_RY;
    (WENeg => RY) = tpd_WENeg_RY;

    if (FROMCE) (CENeg *> DQ0) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ1) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ2) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ3) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ4) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ5) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ6) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ7) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ8) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ9) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ10) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ11) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ12) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ13) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ14) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg *> DQ15) = tpd_CENeg_DQ0;
    if (FROMOE) (OENeg *> DQ0) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ1) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ2) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ3) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ4) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ5) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ6) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ7) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ8) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ9) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ10) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ11) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ12) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ13) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ14) = tpd_OENeg_DQ0;
    if (FROMOE) (OENeg *> DQ15) = tpd_OENeg_DQ0;

    if (~RESETNeg) (RESETNeg *> DQ0) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ1) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ2) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ3) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ4) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ5) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ6) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ7) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ8) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ9) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ10) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ11) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ12) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ13) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ14) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ15) = tpd_RESETNeg_DQ0;

    if (FROMADDR) (A0 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A0 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A1 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A2 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A3 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A4 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A5 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A6 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A7 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A8 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ3) = tpd_A0_DQ0; 
    if (FROMADDR) (A9 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A9 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A10 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A11 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A12 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A13 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A14 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A15 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A16 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A17 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A18 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A19 *> DQ15) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ0) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ1) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ2) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ3) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ4) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ5) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ6) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ7) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ8) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ9) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ10) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ11) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ12) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ13) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ14) = tpd_A0_DQ0;
    if (FROMADDR) (A20 *> DQ15) = tpd_A0_DQ0;  

    if (~BYTENeg && FROMADDR)( DQ15 => DQ0 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ1 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ2 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ3 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ4 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ5 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ6 ) = tpd_A0_DQ0;
    if (~BYTENeg && FROMADDR)( DQ15 => DQ7 ) = tpd_A0_DQ0;

    if (BYTENeg)( BYTENeg => DQ0 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ1 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ2 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ3 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ4 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ5 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ6 ) = tpd_BYTENeg_DQ0;
    if (BYTENeg)( BYTENeg => DQ7 ) = tpd_BYTENeg_DQ0; 

        ( BYTENeg => DQ8 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ9 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ10 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ11 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ12 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ13 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ14 ) = tpd_BYTENeg_DQ0;
        ( BYTENeg => DQ15 ) = tpd_BYTENeg_DQ0;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////
    $setup ( A0 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A1 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A2 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A3 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A4 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A5 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A6 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A7 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol );
    $setup ( A8 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A9 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A10 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A11 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A12 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A13 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A14 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A15 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A16 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A17 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A18 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A19 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
    $setup ( A20 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);

    $setup ( A0 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A1 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A2 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A3 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A4 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A5 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A6 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A7 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A8 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A9 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_WENeg, Viol);
    $setup ( A10 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A11 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A12 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A13 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A14 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A15 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A16 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A17 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A18 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A19 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);
    $setup ( A20 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_WENeg, Viol);

    $setup ( DQ0 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                     tsetup_DQ0_WENeg, Viol);
    $setup ( DQ1 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                     tsetup_DQ0_WENeg, Viol);
    $setup ( DQ2 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ3 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ4 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ5 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ6 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ7 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ8 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ9 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ10 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ11 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ12 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ13 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ14 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ15 , posedge CENeg &&& CheckEnable_DQ0_CE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ0 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ1 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ2 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ3 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ4 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ5 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ6 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ7 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ8 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ9 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ10 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ11 , posedge WENeg &&& CheckEnable_DQ0_WE,
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ12 , posedge WENeg &&& CheckEnable_DQ0_WE, 
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ13 , posedge WENeg &&& CheckEnable_DQ0_WE, 
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ14 , posedge WENeg &&& CheckEnable_DQ0_WE, 
                                                      tsetup_DQ0_WENeg, Viol);
    $setup ( DQ15 , posedge WENeg &&& CheckEnable_DQ0_WE, 
                                                      tsetup_DQ0_WENeg, Viol);

    $hold ( posedge RESETNeg &&& (CENeg===1), negedge CENeg 
                                                , thold_CENeg_RESETNeg, Viol);
    $hold ( posedge RESETNeg &&& (OENeg===1), negedge OENeg , 
                                                  thold_CENeg_RESETNeg, Viol);

    $hold ( posedge WENeg, negedge OENeg &&& EmbdProgress,
                                                     thold_OENeg_WENeg, Viol);

    $hold ( negedge CENeg, BYTENeg, thold_BYTENeg_CENeg, Viol);

    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A0 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A1 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A2 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A3 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A4 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A5 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A6 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A7 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A8 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A9 ,  thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A10 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A11 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A12 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A13 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A14 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A15 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A16 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A17 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A18 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A19 , thold_A0_WENeg, Viol);
    $hold (  negedge CENeg &&& CheckEnable_A0_CE, A20 , thold_A0_WENeg, Viol);

    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A0 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A1 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A2 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A3 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A4 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A5 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A6 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A7 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A8 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A9 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A10 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A11 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A12 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A13 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A14 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A15 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A16 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A17 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A18 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A19 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& CheckEnable_A0_WE, A20 , thold_A0_WENeg, Viol);

    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ0 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ1 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ2 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ3 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ4 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ5 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ6 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ7 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ8 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ9 ,  thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ10 , thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ11 , thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ12 , thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ13 , thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ14 , thold_DQ0_CENeg, Viol);
    $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ15 , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ0  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ1  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ2  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ3  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ4  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ5  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ6  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ7  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ8  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ9  , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ10 , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ11 , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ12 , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ13 , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ14 , thold_DQ0_CENeg, Viol);
    $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ15 , thold_DQ0_CENeg, Viol);

    $width (negedge RESETNeg, tpw_RESETNeg_negedge);
    $width (posedge WENeg&&&(CENeg===0), tpw_WENeg_posedge);
    $width (negedge WENeg&&&(CENeg===0), tpw_WENeg_negedge);
    $width (posedge CENeg, tpw_CENeg_posedge);
    $width (negedge CENeg, tpw_CENeg_negedge);
    $width (negedge A0, tpw_A0_negedge);//ok
    $width (negedge A1, tpw_A0_negedge);//ok
    $width (negedge A2, tpw_A0_negedge);//ok
    $width (negedge A3, tpw_A0_negedge);//ok
    $width (negedge A4, tpw_A0_negedge);//ok            
    $width (negedge A5, tpw_A0_negedge);//ok    
    $width (negedge A6, tpw_A0_negedge);//ok
    $width (negedge A7, tpw_A0_negedge);//ok
    $width (negedge A8, tpw_A0_negedge);//ok
    $width (negedge A9, tpw_A0_negedge);//ok
    $width (negedge A10, tpw_A0_negedge);//ok            
    $width (negedge A11, tpw_A0_negedge);//ok    
    $width (negedge A12, tpw_A0_negedge);//ok
    $width (negedge A13, tpw_A0_negedge);//ok
    $width (negedge A14, tpw_A0_negedge);//ok
    $width (negedge A15, tpw_A0_negedge);//ok
    $width (negedge A16, tpw_A0_negedge);//ok            
    $width (negedge A17, tpw_A0_negedge);//ok    
    $width (negedge A18, tpw_A0_negedge);//ok
    $width (negedge A19, tpw_A0_negedge);//ok
    $width (negedge A20, tpw_A0_negedge);//ok
    $width (posedge A0, tpw_A0_posedge);//ok
    $width (posedge A1, tpw_A0_posedge);//ok
    $width (posedge A2, tpw_A0_posedge);//ok
    $width (posedge A3, tpw_A0_posedge);//ok
    $width (posedge A4, tpw_A0_posedge);//ok            
    $width (posedge A5, tpw_A0_posedge);//ok    
    $width (posedge A6, tpw_A0_posedge);//ok
    $width (posedge A7, tpw_A0_posedge);//ok
    $width (posedge A8, tpw_A0_posedge);//ok
    $width (posedge A9, tpw_A0_posedge);//ok
    $width (posedge A10, tpw_A0_posedge);//ok            
    $width (posedge A11, tpw_A0_posedge);//ok    
    $width (posedge A12, tpw_A0_posedge);//ok
    $width (posedge A13, tpw_A0_posedge);//ok
    $width (posedge A14, tpw_A0_posedge);//ok
    $width (posedge A15, tpw_A0_posedge);//ok
    $width (posedge A16, tpw_A0_posedge);//ok            
    $width (posedge A17, tpw_A0_posedge);//ok    
    $width (posedge A18, tpw_A0_posedge);//ok
    $width (posedge A19, tpw_A0_posedge);//ok
    $width (posedge A20, tpw_A0_posedge);//ok

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
    parameter RESET           =6'd0;
    parameter Z001            =6'd1;
    parameter PREL_SETBWB     =6'd2;
    parameter PREL_ULBYPASS   =6'd3;
    parameter CFI_U           =6'd4;
    parameter CFI             =6'd5;
    parameter AS              =6'd6;
    parameter A0SEEN          =6'd7;
    parameter OTP             =6'd8;
    parameter OTP_Z001        =6'd9;
    parameter OTP_PREL        =6'd10;
    parameter OTP_AS          =6'd11;
    parameter OTP_AS_CFI      =6'd12;
    parameter OTP_A0SEEN      =6'd13;
    parameter C8              =6'd14;
    parameter C8_Z001         =6'd15;
    parameter C8_PREL         =6'd16;
    parameter ERS             =6'd17;
    parameter SERS            =6'd18;
    parameter ESPS            =6'd19;
    parameter SERS_EXEC       =6'd20;
    parameter ESP             =6'd21;
    parameter ESP_Z001        =6'd22;
    parameter ESP_PREL        =6'd23;
    parameter ESP_CFI_U       =6'd24;
    parameter ESP_CFI         =6'd25;
    parameter ESP_A0SEEN      =6'd26;
    parameter ESP_AS          =6'd27;
    parameter PGMS            =6'd28;
    parameter PREL_ULBYPASS_RESET =6'd29;
    parameter AS_CFI          =6'd30;
 
    reg [5:0] current_state;
    reg [5:0] next_state;

    reg deq;

    always @(DIn, DOut)
    begin
        if (DIn==DOut)
            deq=1'b1;
        else
            deq=1'b0;
    end
    // chech when data is generated from model to avoid setuphold check in
    // those occasion
    assign deg=deq;

    integer i,j;
    reg     sector_prot[0:SecNum+SubSecNum+1];
    integer tmp1,tmp2,tmp3;

    // find which 4 sectors have variable size
    initial
    begin
//TOP OR BOTTOM arch model is used
    //assumptions:
    //1. TimingModel has format as
    //"s29al032dxxxxx"
    //it is important that 16-th character from first one is "t" or "b"
    //2. TimingModel does not have more then 20 characters
    tmp_timing = TimingModel;//copy of TimingModel
    i = 19;
    while ((i >= 0) && (found != 1'b1))//search for first non null character
    begin                      //i keeps position of first non null character
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
    i = i +1;
    if (found)//if non null character is found
    begin
        for (j=0;j<=7;j=j+1)
        begin
            tmp_char[j] = TimingModel[(i-15)*8+j];//bottom/top character is 16
        end                                  //characters right from first ("s")
    end
    if (tmp_char == "3")
    begin
        VarSect = SecNum;
        vs      = 1'b1;
    end
    else if (tmp_char == "4"  )
    begin
        VarSect = 0;
        vs      = 1'b0;
    end

    // initialize memory and load preoload files if any

        for (i=0;i<(SecSize+1)*(SecNum+1);i=i+1)
            Mem[i]=MaxData;
        for (i=0;i<=SecNum+SubSecNum;i=i+1)
            sector_prot[i]=0;
        for (i=0;i<=SubSecNum;i=i+1)
        begin
            SubSec_Prot[i] = 0;
            Ers_Sub_queue[i] = 0;
        end
        for (i=0;i<=SecSiSize;i=i+1)
            SecSi[i]=MaxData;
        for (i=0;i<=SecNum;i=i+1)
            Ers_queue[i] = 0;
        for (i=0;i<=SecNum;i=i+1)
            Sec_Prot = 0;
        if (UserPreload)
        begin
            //- Sector protection preload
            //s29al032d_03_04_prot.mem  sector protect file
            //   //      - comment
            //   @aaa    - <aaa> stands for sector address
            //   (aaaa is incremented at every load)
            //   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
            //   If <aaa> > SecNum SecSi
            //   is protected/unprotected
            if (prot_file_name != "none") $readmemb(prot_file_name,sector_prot);
            // Secure Silicon Sector Region preload
            // Secure Silicon Sector Region preload
            // s29al032d_03_04_secsi memory file
            //   //       - comment
            //   @aa     - <aa> stands for address within last defined sector
            //   dd      - <dd> is byte to be written at SecSi(aa++)
            //  (aa is incremented at every load)
            if (secsi_file_name != "none") $readmemh(secsi_file_name,SecSi);
            // Memory Preload
            //s29al032d_03_04.mem, memory preload file
            //  @aaaa   - <aaaa> stands for address within last defined sector
            //  dd      - <dd> is byte to be written at Mem(nn)(aaaa++)
            // (aaaa is incremented at every load)
            if (mem_file_name != "none") $readmemh(mem_file_name,Mem);
        end

        for (i=0;i<=7;i=i+1)
        begin
            SubSec_Prot[i] = sector_prot[i+16];
        end

        for (i=0;i<59;i=i+1)
        begin
            Sec_Prot[i]  = sector_prot[i/4];
        end
            Sec_Prot[60]  = sector_prot[15];
            Sec_Prot[61]  = sector_prot[15];
            Sec_Prot[62]  = sector_prot[15];

        FactoryProt = sector_prot[24];

        if (vs==0)
            for (i=SecNum;i>=0;i=i-1)
                Sec_Prot[i] = Sec_Prot[i-1];

        for (i=0;i<=1;i=i+1)
        begin
            WBData[i] = 0;
            WBAddr[i] = -1;
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
        write    = 1'b0;
        read     = 1'b0;
        Addr     = 0;
        ULBYPASS = 1'b0;
        OTP_ACT  = 1'b0;
        ESP_ACT  = 1'b0;
        PSTART   = 1'b0;
        PDONE    = 1'b1;
        PERR     = 1'b0;
        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;
        EERR     = 1'b0;
        READY_in = 1'b0;
        READY    = 1'b0;
        OTP_Err  = 1'b0;
    end

    always @(posedge START_T1_in)
    begin:TSTARTT1r
        #tdevice_START_T1 START_T1 = START_T1_in;
    end

    always @(negedge START_T1_in)
    begin:TSTARTT1f
        #1 START_T1 = START_T1_in;
    end

    always @(posedge CTMOUT_in)
    begin:TCTMOUTr
        #(tdevice_CTMOUT - 1) CTMOUT = CTMOUT_in;
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

    always @(A)
    begin
        ADDR_event = $time;
    end

    always @(DIn[15])
    begin
        if (~BYTENeg)
            ADDR_event = $time;
    end

    ////////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ////////////////////////////////////////////////////////////////////////////

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
        READY  or PoweredUp)   //or PDONE or  EDONE
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
                current_state = RESET;
                reseted       = 1'b0;
            end
        end
        else
        begin
            current_state = RESET;
            reseted       = 1'b0;
            E = 1'b0;
            R = 1'b0;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
    ///////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

    //latch address on rising edge and data on falling edge  of write
    always @(gWE_n or  gCE_n or  gOE_n or RESETNeg)
    begin: write_dc
        if (RESETNeg!=1'b0)
        begin
            if (~gWE_n && ~gCE_n && gOE_n)
                write = 1'b1;
            else
                write = 1'b0;
        end
        if (gWE_n && ~gCE_n && ~gOE_n)
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
    begin: PulseWatch
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
    integer A_tmp1 ;

    reg CE;

   always @(WENeg_ipd)// or reseted)
    begin
        if (reseted)
        begin
            if (~WENeg_ipd && ~CENeg_ipd && OENeg_ipd )
            begin
                A_tmp  =  A[10:0];
                SA_tmp =  A[HiAddrBit:15];

                if (~BYTENeg)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};
            end
            else if (WENeg_ipd && write)
            begin
            end
        end
    end

   always @(CENeg_ipd)
    begin
        if (reseted)
        begin
            if (~CENeg_ipd && (WENeg_ipd != OENeg_ipd) )
            begin
                A_tmp  =  A[10:0];
                SA_tmp =  A[HiAddrBit:15];

                if (~BYTENeg)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};
            end
            else if (CENeg_ipd && write)
            begin
            end
        end
    end

    always @(negedge OENeg_ipd )
    begin
        if (reseted)
        begin
            if (~OENeg_ipd && WENeg_ipd && ~CENeg_ipd)
            begin
                A_tmp  =  A[10:0];
                SA_tmp =  A[HiAddrBit:15];
                if (~BYTENeg)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};
            end
            begin
                SecAddr = SA_tmp;
                Address = A_tmp1;
                CE = CENeg;
                Addr   = A_tmp;
                for(i=0;i<=SubSecNum;i=i+1)
                   if ( A_tmp1 >= sssa(vs, i) && A_tmp1 <= ssea(vs, i) )
                      SubSect = i;
            end
        end
    end

    always @(A or BYTENeg)
    begin
        if (reseted)
        begin
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  A[10:0];
                SA_tmp =  A[HiAddrBit:15];
                if (~BYTENeg)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};
                SecAddr = SA_tmp;
                Address = A_tmp1;
                CE = CENeg;
                Addr   = A_tmp;
                for(i=0;i<=SubSecNum;i=i+1)
                   if ( A_tmp1 >= sssa(vs, i) && A_tmp1 <= ssea(vs, i) )
                      SubSect = i;
            end
        end
    end

    always @(DIn)// or reseted)
    begin
        if (reseted)
        begin
            if (~BYTENeg && WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  A[10:0];
                SA_tmp =  A[HiAddrBit:15];
                A_tmp1 = { A[14:0],DIn[15] };
                SecAddr = SA_tmp;
                Address = A_tmp1;
                CE = CENeg;
                Addr   = A_tmp;
                for(i=0;i<=SubSecNum;i=i+1)
                   if ( A_tmp1 >= sssa(vs, i) && A_tmp1 <= ssea(vs, i) )
                      SubSect = i;
            end
        end
    end

    always @(posedge write)
    begin
       SecAddr = SA_tmp;
       Address = A_tmp1;
       CE = CENeg;
       Addr   = A_tmp;
       for(i=0;i<=SubSecNum;i=i+1)
          if ( A_tmp1 >= sssa(vs, i) && A_tmp1 <= ssea(vs, i) )
             SubSect = i;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Program/ Write Buffer Program Operations
    // start/ suspend/ resume
    ///////////////////////////////////////////////////////////////////////////

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
                if (( SA != VarSect &&
                     ( ~Sec_Prot[SA] &&
                      (~Ers_queue[SA] || ~ESP_ACT )   &&
                      (~FactoryProt   || ~OTP_ACT ))) ||
                    ( SA == VarSect &&
                     ( ~SubSec_Prot[SSA] &&
                      (~Ers_Sub_queue[SSA] || ~ESP_ACT )   &&
                      (~FactoryProt   || ~OTP_ACT ))))
                begin
                    
                        if (BYTENeg) 
                            duration_write = tdevice_POW - 5;
                        else
                            duration_write = tdevice_POB - 5;
                    elapsed_write = 0;
                    PDONE = 1'b0;
                    ->pdone_event;
                    start_write   = $time;
                end
                else
                begin
                    PERR = 1'b1;
                    PERR <= #995 1'b0;
                end
            end
        end
    end

    always @(pdone_event)
    begin:pdone_process
        PDONE = 1'b0;
        #duration_write PDONE = 1'b1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Erase Operations
    ///////////////////////////////////////////////////////////////////////////
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
        if (reseted)
        begin
            if (ESTART && EDONE)
            begin
                cnt_erase = 0;
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if ( i == VarSect )
                    begin
                       for(j=0;j<=SubSecNum;j=j+1)
                       begin
                          if ((Ers_Sub_queue[j]==1'b1) && (~SubSec_Prot[j]))
                             cnt_erase = cnt_erase + 1;
                       end
                    end
                    else
                    begin
                      if ((Ers_queue[i]==1'b1) && (Sec_Prot[i]!=1'b1))
                           cnt_erase = cnt_erase + 1;
                    end
                end
                if (cnt_erase>0)
                begin
                    elapsed_erase = 0;
                    duration_erase = ((cnt_erase* tdevice_SEO) - 5);
                    ->edone_event;
                    start_erase = $time;
                end
                else
                begin
                    EERR = 1'b1;
                    EERR <= #99995  1'b0;
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

    ///////////////////////////////////////////////////////////////////////////
    // Main Behavior Process
    // combinational process for next state generation
    ///////////////////////////////////////////////////////////////////////////
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_1  = 1'b0;

    //DATA  High Byte
    integer DataHi   ;
    //DATA Low Byte
    integer DataLo   ;

    always @(negedge write)
    begin
        DataLo = DIn[7:0];
        if (BYTENeg)
            DataHi = DIn[15:8];
        PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
        PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
        A_PAT_1   = ((Addr==16'h555) && ~ULBYPASS) || ULBYPASS;
    end

    always @(negedge write or reseted)
    begin: StateGen1

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
                else if (A_PAT_1 && (DataLo==16'h88))
                    next_state = OTP;
                else if (A_PAT_1 && (DataLo==16'h80))
                    next_state = C8;
                else
                    next_state = RESET;
            end

            PREL_ULBYPASS :
            begin
                if (DataLo==16'h90)
                    next_state = PREL_ULBYPASS_RESET;
                else if (A_PAT_1 && (DataLo==16'hA0))
                    next_state = A0SEEN;
                else
                    next_state = PREL_ULBYPASS;
            end

            PREL_ULBYPASS_RESET :
            begin
                   if (DataLo == 16'h00 )
                        next_state = RESET;
                   else
                        next_state = PREL_ULBYPASS;
            end

            CFI :
            begin
                if ((Addr==16'h55) && (DataLo==16'h98))
                    next_state = CFI;
                else if (DataLo==16'hF0)
                    next_state = RESET;
                else
                    next_state =  CFI;
            end

            AS :
            begin
                if ((Addr==16'h55) && (DataLo==16'h98))
                    next_state = AS_CFI;
                else if (DataLo==16'hF0)
                    next_state = RESET;
                else
                    next_state = AS;
            end

            AS_CFI :
            begin
                if (DataLo==16'hF0)
                    next_state = AS;
                else
                    next_state = AS_CFI;
            end

            A0SEEN :
            begin
                next_state = PGMS;
            end

            OTP :
            begin
                if (PATTERN_1)
                    next_state = OTP_Z001;
                else
                    next_state = OTP;
            end

            OTP_Z001 :
            begin
                if (PATTERN_2)
                    next_state = OTP_PREL;
                else
                    next_state = OTP_Z001;
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
                if (DataLo==16'h00)
                    if (ESP_ACT)
                        next_state = ESP;
                    else
                        next_state = RESET;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = OTP_AS_CFI;
                    else if (DataLo==16'hF0)
                        next_state = OTP;
                    else
                        next_state = OTP_AS;
            end

            OTP_AS_CFI :
            begin
                if (DataLo==16'hF0)
                    next_state = OTP_AS;
                else
                    next_state =  OTP_AS_CFI;
            end

            OTP_A0SEEN :
            begin
                if ((vs == 1 && SecAddr == 16'h3f &&
                        Address >= 16'hff00 && Address <= 16'hffFF)
                   || (vs == 0 && SecAddr == 16'h00 &&
                        Address >= 16'h0000 && Address <= 16'h00FF))
                    next_state = PGMS;
                else
                    next_state = OTP;
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
                if (~CTMOUT)
                    if (DataLo == 16'hB0)
                        next_state = ESP; 
                    else if (DataLo==16'h30)
                        next_state = SERS;
                    else
                        next_state = RESET;
            end

            SERS_EXEC :
            begin
            end

            ESP :
            begin
                if (DataLo == 16'h30)
                    next_state = SERS_EXEC;
                else if (ULBYPASS)
                begin
                    if (DataLo == 16'h20)
                    begin
                    end
                    if (A_PAT_1 && (DataLo == 16'hA0))
                        next_state = ESP_A0SEEN;
                    else if (A_PAT_1 && (DataLo == 16'h90))
                        next_state = ESP_AS;
                end
                else
                begin
                    if ((Addr == 16'h55) && (DataLo == 16'h98))
                        next_state = ESP_CFI;
                    else if (PATTERN_1)
                        next_state = ESP_Z001;
                end
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
                if (A_PAT_1 && (DataLo == 16'h20))
                    next_state = ESP; //set ULBYPASS
                else if (A_PAT_1 && DataLo == 16'hA0)
                    next_state = ESP_A0SEEN;
                else if (A_PAT_1 && DataLo == 16'h88)
                    next_state = OTP; //set ESP
                else if (A_PAT_1 && DataLo == 16'h90)
                    next_state = ESP_AS;
                else
                    next_state = ESP;
            end

            ESP_CFI :
            begin
                if (DataLo == 16'hF0)
                    next_state = ESP;
                else
                    next_state = ESP_CFI;
            end

            ESP_A0SEEN :
            begin
                next_state = PGMS; //set ESP
            end

            ESP_AS :
            begin
                next_state = ESP;
            end

            PGMS :
            begin
            end

        endcase

    end

    always @(posedge PDONE or negedge PERR)
    begin: StateGen6
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
                else if (OTP_ACT)
                    next_state = OTP;
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
            begin
                if (EDONE)
                    next_state = RESET;
            end
        end
    end

    always @(negedge EERR or reseted)
    begin: StateGen3
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC) 
               || (current_state==PGMS))
                if (~EERR)
                    if (~(EERR!=1'b1))
                        if (ULBYPASS)
                            next_state = PREL_ULBYPASS;
                        else
                            next_state = RESET;
        end
    end

    always @(CTMOUT or reseted)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
        if (current_state==SERS)
            if (CTMOUT)  next_state = SERS_EXEC;
        end
    end     

    always @(posedge START_T1 or reseted)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (current_state==ESPS)
            if (START_T1) next_state = ESP;
    end

    always @(negedge write or reseted)
    begin: StateGen7

        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
        if (current_state==SERS_EXEC)
            if ((write==1'b0) && (EERR!=1'b1))
                if (DataLo==16'hB0)
                    next_state = ESPS;
        end
    end

    always @(posedge START_T1 or reseted)
    begin: StateGen8

        if (reseted!=1'b1)
            next_state = current_state;
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
      ->oe_event;
    end
    always @(Address)
    begin
      if (read)
        ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    always @(oe or reseted or current_state)
    begin
        if (reseted)
        begin
        case (current_state)

            RESET :
            begin
                if (oe)
                      MemRead(DOut_zd);
            end

            CFI :
            begin
                 if (oe)
                  CFIRead(DOut_zd);
            end

            AS :
            begin
                if (oe)
               ASRead(DOut_zd);
            end

            AS_CFI:
            begin
            if (oe)
                  CFIRead(DOut_zd);
            end

            OTP :
            begin
                if (oe)
                begin
                    //read SecSi Sector Region
                if (((vs == 1) && (SecAddr == VarSect) && 
                   ((Address >= 16'hFF00) && (Address <= 16'hFFFF))) ||
                   ((vs == 0) && (SecAddr == VarSect) && 
                   ((Address >= 16'h0000) && (Address <= 16'h00FF))))
                        begin
                            if (SecSi[(Address % (SecSiSize + 1))]==-1)
                                DOut_zd[7:0] = 8'bx;
                            else
                                DOut_zd[7:0] = SecSi[(Address % 
                                                              (SecSiSize + 1))];
                            if (BYTENeg)
                                if (SecSi[(Address % (SecSiSize + 1))+1]==-1)
                                    DOut_zd[15:8]= 8'bx;
                                else
                                    DOut_zd[15:8] = SecSi[(Address % 
                                                            (SecSiSize + 1))+1];
                        end
                    else
                    $display("Invalid address in SecSi mode");
               end
            end

            OTP_AS :
            begin
                if (oe)
                   ASRead(DOut_zd);
            end

            OTP_AS_CFI :
            begin
                if (oe)
                  CFIRead(DOut_zd);
            end

            ERS :
            begin
                if (oe)
                    begin
                        ////////////////////////////////////////////////////////
                        // read status / embeded erase algorithm - Chip Erase
                        ////////////////////////////////////////////////////////
                        Status[7] = 1'b0;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        DOut_zd[7:0] = Status;
                   end
            end

            SERS :
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status - sector erase timeout
                    ///////////////////////////////////////////////////////////
                    Status[3] = 1'b0;
                    DOut_zd[7:0] = Status;
                end
            end

            ESPS :
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ///////////////////////////////////////////////////////////
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    if (SecAddr == VarSect)
                        begin
                            if ( Ers_Sub_queue[SubSect] == 1'b1 )
                                Status[2] = ~Status[2]; //toggle
                        end
                    else
                        if ( Ers_queue[SecAddr] == 1'b1 )
                            Status[2] = ~Status[2]; //toggle
                        DOut_zd[7:0] = Status;
                end
            end

            SERS_EXEC:
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////
                    //read status erase HANG
                    ///////////////////////////////////////////////////
                    //%el should never hang
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    if (SecAddr == VarSect)
                    begin
                        if ( Ers_Sub_queue[SubSect] == 1'b1 )
                            Status[2] = ~Status[2]; //toggle
                    end
                    else
                        if ( Ers_queue[SecAddr] == 1'b1 )
                            Status[2] = ~Status[2]; //toggle

                    DOut_zd[7:0] = Status;
                end
            end

            ESP :
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read
                    ///////////////////////////////////////////////////////////
                    if    (( SecAddr != VarSect && Ers_queue[SecAddr]!=1'b1)
                       || ( SecAddr == VarSect && Ers_Sub_queue[SubSect]!=1'b1))
                        MemRead(DOut_zd);
                    else
                    begin
                        ///////////////////////////////////////////////////////
                        //read status
                        ///////////////////////////////////////////////////////
                        Status[7] = 1'b1;
                        // Status[6) No toggle
                        Status[5] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                        DOut_zd[7:0] = Status;
                    end
                end
            end

            ESP_CFI :
            begin
                if (oe)
                  CFIRead(DOut_zd);
            end

            ESP_AS :
            begin
                if ((oe) && ( ULBYPASS == 0 ))  
                    ASRead(DOut_zd);            
            end

            PGMS :
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////////
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    //Status[2) no toggle
                    Status[1] = 1'b0;
                    DOut_zd[7:0] = Status;
                end
            end

        endcase
        end
    end

    always @(negedge write or reseted)
    begin : Output_generation
        if (reseted)
        begin
        case (current_state)

            RESET :
            begin
                OTP_ACT   = 1'b0;
                ESP_ACT   = 1'b0;
                begin
                    if (PATTERN_1)
                    begin
                    end
                    else if ((Addr==16'h55) && (DataLo==16'h98))
                        ULBYPASS = 1'b0;
                end
                    //ready signal active
                    RY_zd = 1'b1;
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                begin
                    if (A_PAT_1 && (DataLo==16'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==16'h90))
                        ULBYPASS = 1'b0;
                    else if (A_PAT_1 && (DataLo==16'h88))
                    begin
                        ULBYPASS = 1'b0;
                        OTP_ACT  = 1'b1;
                    end
                end
            end

            PREL_ULBYPASS :
            begin
                begin
                    if (DataLo==16'h20)
                        ULBYPASS = 1'b1;
                    else if (DataLo==16'h98)
                        ULBYPASS = 1'b0;
                    else if (A_PAT_1 && (DataLo==16'h90))
                        ULBYPASS = 1'b0;
                    else if (A_PAT_1 && (DataLo==16'h88))
                    begin
                        ULBYPASS = 1'b0;
                        OTP_ACT  = 1'b1;
                    end
                end
                //ready signal active
                RY_zd = 1'b1;
            end

            CFI :
            begin
                    if ((Addr==16'h55) && (DataLo==16'h98))
                    begin
                    end
                    else if (DataLo==16'hF0)
                        ULBYPASS  = 1'b0;
            end

            AS :
            begin
                if (DataLo==16'hF0)
                    ULBYPASS  = 1'b0;
            end

            A0SEEN :
            begin
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    if (Viol!=1'b0)
                    begin
                        WBData[0] = -1;
                        WBData[1] = -1;
                        Viol=1'b0;
                    end
                    else
                    begin
                        WBData[0] = DataLo;
                        WBData[1] = DataHi;
                    end
                    WBAddr[0] = Address;
                    SA = SecAddr;
                    SSA = SubSect;
                    temp = DataLo;
                    Status[7] = ~temp[7];
                    if (BYTENeg)
                        WBAddr[1] = WBAddr[0] +1;
                    else
                        WBAddr[1] = -1;
                end
            end

            OTP :
            begin
                OTP_ACT = 1'b1;
                   if (PATTERN_1)
                //ready signal active
                RY_zd = 1'b1;
            end

            OTP_Z001 :
            begin
            end

            OTP_PREL :
            begin
                begin
                    if (A_PAT_1 && (DataLo == 16'h90))
                        ULBYPASS = 1'b0;
                end
            end

            OTP_AS :
            begin
                begin
                    if (DataLo==16'h00)
                    begin
                        OTP_ACT =1'b0;
                        ULBYPASS  = 1'b0;
                    end 
                end
            end

            OTP_A0SEEN :
            begin
                begin
                    OTP_ACT = 1'b1;
                    ///////////////////////////////////////////////////////////
                    //SecSi programming: TBD
                    ///////////////////////////////////////////////////////////
                   
                if (((vs == 1) && (SecAddr == VarSect) && 
                   ((Address >= 16'hFF00) && (Address <= 16'hFFFF))) ||
                   ((vs == 0) && (SecAddr == VarSect) && 
                   ((Address >= 16'h0000) && (Address <= 16'h00FF))))
                begin    
                      PSTART = 1'b1;
                      PSTART <= #1 1'b0;
                end
                else           
                    OTP_Err = 1'b1;
                    if (Viol!=1'b0)
                    begin
                        WBData[0] = -1;
                        WBData[1] = -1;
                        Viol = 1'b0;
                    end
                    else
                    begin
                        WBData[0] = DataLo;
                        WBData[1] = DataHi;
                    end
                WBAddr[0] = (Address % (SecSiSize + 1)) ;
                if (OTP_Err)
                     $display("Invalid Address in SecSi");
                    temp = DataLo;
                    Status[7] = ~temp[7];
                    if (BYTENeg)
                        WBAddr[1] = WBAddr[0] +1;
                    else
                        WBAddr[1] = -1;
                end
            end

            C8 :
            begin
                if (PATTERN_1)
                    begin
                    end
                    else
                        ULBYPASS  = 1'b0;
            end

            C8_Z001 :
            begin
                if (PATTERN_2)
                    begin
                    end
            end

            C8_PREL :
            begin
                if (A_PAT_1 && (DataLo==16'h10))
                    begin
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_queue = ~(0);
                        Ers_Sub_queue = ~(0);
                        Status = 8'b00001000;
                    end
                    else if (DataLo==16'h30)
                    begin
                        //put selected sector to sec. ers. queue
                        //start timeout
                        Ers_queue = 0;
                        Ers_Sub_queue = 0;
                        if ( SecAddr == VarSect )
                             Ers_Sub_queue[SubSect] = 1'b1;
                        else
                             Ers_queue[SecAddr] = 1'b1;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                    end
            end

            SERS :
            begin
                begin
                    if (~CTMOUT)
                    begin
                        if (DataLo == 16'hB0)
                        begin
                            //need to start erase process prior to suspend
                           ESTART = 1'b1;
                           ESTART <= #1 1'b0;
                           ESUSP  = 1'b0;
                           ERES   = 1'b0;
                           //suspend timeout 
                           START_T1_in = 1'b1;
                        end
                        else if (DataLo==16'h30)
                        begin
                            disable TCTMOUTr;
                            CTMOUT_in = 1'b0;
                            #1 CTMOUT_in <= 1'b1;
                            if ( SecAddr == VarSect )
                                Ers_Sub_queue[SubSect] = 1'b1;
                            else
                                Ers_queue[SecAddr] = 1'b1;
                        end
                    end
                end
                //ready signal active
                RY_zd = 1'b0;
            end

            SERS_EXEC :
            begin
                 if (~EDONE && (EERR!=1'b1))
                        if (DataLo==16'hB0)
                        begin
                            START_T1_in = 1'b1;
                            RY_zd = 1'b0;
                            ESUSP = 1'b1;
                        end
            end

            ESP :
            begin
                begin
                    if (DataLo == 16'h30)
                    begin
                        //resume erase
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                    end
                    else if (ULBYPASS)
                    begin
                        if (DataLo == 16'h20)
                        begin
                        end
                    end
                end
                //ready signal active
                RY_zd = 1'b1;
            end

            ESP_Z001 :
            begin
            end

            ESP_PREL :
            begin
                begin
                    if (A_PAT_1 && (DataLo == 16'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo == 16'h88))
                        ESP_ACT = 1'b1;
                end
            end

            ESP_CFI :
            begin
                begin
                    if ((Addr == 16'h55) && (DataLo == 16'h98))
                    begin
                    end
                    else if (DataLo == 16'hF0)
                        ESP_ACT = 1'b1;
                    else
                        ESP_ACT = 1'b1;
                end
            end

            ESP_A0SEEN :
            begin
                begin
                    ESP_ACT = 1'b1;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    if (Viol!=1'b0)
                    begin
                        WBData[0] = -1;
                        WBData[1] = -1;
                        Viol = 1'b0;
                    end
                    else
                    begin
                        WBData[0] = DataLo;
                        WBData[1] = DataHi;
                    end 
                        WBData[0] = DataLo;
                        WBData[1] = DataHi;
                    
                    WBAddr[0] = Address;
                    SA = SecAddr;
                    SSA = SubSect;
                    temp = DataLo;
                    Status[7] = ~temp[7];
                    if (BYTENeg)
                        WBAddr[1] = WBAddr[0] +1;
                    else
                        WBAddr[1] = -1;
                end
            end

            ESP_AS :
            begin
                if (DataLo == 16'h00)
                    // resret ULBYPASS
                    ULBYPASS = 1'b0;
            end

            PGMS :
            begin
                if (~PDONE)
                        if (DataLo == 16'hB0)
                        begin
                          START_T1_in = 1'b1;
                        end
                //busy signal active
                RY_zd = 1'b0;
            end

        endcase
        end
    end

    always @(current_state or reseted)
    begin
        if (reseted)
            if (current_state==RESET) RY_zd = 1'b1;
            if (current_state==PREL_ULBYPASS) RY_zd = 1'b1;
            if (current_state==ESP) RY_zd = 1'b1;
            if (current_state==SERS_EXEC) RY_zd = 1'b0;
            if (current_state==SERS) RY_zd = 1'b0;
            if (current_state==PGMS) RY_zd = 1'b0;
            if (current_state==OTP) RY_zd = 1'b1;
            if (current_state==ESPS) RY_zd = 1'b0;
    end

    always @(EERR or EDONE or current_state)
    begin : ERS2
    integer i;
    integer j;
    integer k;
        if (current_state==ERS)
        begin
            if (EERR!=1'b1)
              for (i=0;i<=SecNum;i=i+1)
                begin
                  if ( i == VarSect)
                    begin
                      for( j=0;j<=SubSecNum;j=j+1)
                        if ( SubSec_Prot[j]!=1'b1 )
                          for(k=sssa(vs, j);k<=ssea(vs, j);k=k+1)
                                 Mem[sa(i)+k] = -1;
                    end
                  else
                    begin
                      if (Sec_Prot[i]!=1'b1)
                        for (j=0;j<=SecSize;j=j+1)
                          Mem[sa(i)+j] = -1;
                    end
                end
            if (EDONE)
              for (i=0;i<=SecNum;i=i+1)
                begin
                  if ( i == VarSect )
                    begin
                      for( j=0;j<=SubSecNum;j=j+1)
                        if ( SubSec_Prot[j]!=1'b1 )
                          for(k=sssa(vs, j);k<=ssea(vs, j);k=k+1)
                                 Mem[sa(i)+k] = MaxData;
                    end
                  else
                    begin
                      if (Sec_Prot[i]!=1'b1)
                        for (j=0;j<=SecSize;j=j+1)
                           Mem[sa(i)+j] = MaxData;
                    end
                end
            // busy signal active
            RY_zd = 1'b0;
       end
    end

    always @(CTMOUT or current_state)
    begin : SERS2
      if (current_state==SERS)
        if (CTMOUT)
          begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                //ready signal active
                RY_zd = 1'b0;
          end
    end

    always @(START_T1 or current_state)
    begin : ESPS2
        if (current_state==ESPS)
          if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
                ESUSP = 1'b0;
                 //busy signal active
                 RY_zd = 1'b0;
            end
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j,k;

    if (current_state==SERS_EXEC)
        if (EERR!=1'b1)
        begin
            for (i=0;i<=SecNum;i=i+1)
            begin
                if ( i == VarSect)
                begin
                    for( j=0;j<=SubSecNum;j=j+1)
                        if (SubSec_Prot[j]!=1'b1 && Ers_Sub_queue[j]==1'b1)
                            for(k=sssa(vs, j);k<=ssea(vs, j);k=k+1)
                                Mem[sa(i)+k] = -1;
                end
                else
                begin
                    if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                        for (j=0;j<=SecSize;j=j+1)
                            Mem[sa(i)+j] = -1;
                end
            end
            if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if ( i == VarSect )
                    begin
                        for( j=0;j<=SubSecNum;j=j+1)
                            if (SubSec_Prot[j]!=1'b1 && Ers_Sub_queue[j] )
                            for(k=sssa(vs, j);k<=ssea(vs, j);k=k+1)
                                Mem[sa(i)+k] = MaxData;
                    end
                    else
                    begin
                        if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                            for (j=0;j<=SecSize;j=j+1)
                                Mem[sa(i)+j] = MaxData;
                    end
                end
            //busy signal active
            RY_zd = 1'b0;
        end
    end

    always @(current_state or posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
        if (current_state==PGMS)
        begin
           //busy signal active
            RY_zd = 1'b0;
            if (PERR!=1'b1)
            begin
                if (WBAddr[1] < 0 )
                    wr_cnt = 0;
                else 
                    wr_cnt = 1;
                for (i=wr_cnt;i>=0;i=i-1)
                begin
                    new_int= WBData[i];
                    old_int = 0;
                    if (OTP_ACT!=1'b1)
                        old_int=Mem[SA*(SecSize+1)+WBAddr[i]];
                    else
                        old_int=SecSi[WBAddr[i]];
                    if (new_int>-1)
                    begin
                        new_bit = new_int;
                        if (old_int>-1)
                        begin
                            old_bit = old_int;
                            for(j=0;j<=7;j=j+1)
                                if (~old_bit[j])
                                    new_bit[j]=1'b0;
                            new_int=new_bit;
                        end
                        WBData[i]= new_int;
                    end
                    else
                        WBData[i]= -1;
                end
                for (i=wr_cnt;i>=0;i=i-1)
                begin
                    if (OTP_ACT!=1'b1)   //mem write
                        Mem[SA*(SecSize+1)+WBAddr[i]] = -1;
                    else
                        SecSi[WBAddr[i]]   = -1;
                end
                if (PDONE && ~PSTART)
                for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1)
                            if (OTP_ACT!=1'b1)   //mem write
                                Mem[SA*(SecSize+1)+WBAddr[i]] = WBData[i];
                            else //SecSi write
                                SecSi[WBAddr[i]]   = WBData[i];
                        else
                            $display("Write Address error");
                        WBData[i]= -1;
                    end
            end
        end
    end

    //Output timing control
    always @(DOut_zd)
    begin : OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            CEDQ_t = CENeg_event  + CEDQ_01;
            OEDQ_t = OENeg_event  + OEDQ_01;
            ADDRDQ_t = ADDR_event + ADDRDQ;
            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            FROMADDR = 1'b1;
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t)&&FROMOE) ||
              ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                TempData = DOut_zd;
                FROMADDR = 1'b0;
                if (~BYTENeg)
                    DOut_Pass[15:8] = 8'bz;
                else
                    DOut_Pass[15:8] = 8'bx;
                DOut_Pass[7:0] = 8'bx;
                DOut_Pass <= #(ADDRDQ_t - $time) TempData;
            end
            else
            begin
                DOut_Pass = DOut_zd;
            end
        end
    end

    always @(DOut_zd)
    begin
        if (DOut_zd[0] === 1'bz)
        begin
            disable OutputGen;
            FROMCE = 1'b1;
            FROMOE = 1'b1;
            FROMADDR = 1'b0;
            DOut_Pass = DOut_zd;
        end
    end

    always @(gOE_n or RESETNeg or RST or BYTENeg or gCE_n)
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
            DOut_zd = 16'bZ;
        else
            if (~BYTENeg)
                DOut_zd[15:8] = 8'bZ;
     end

    always @(WPNeg)
    begin
        //Hardware Write Protection
        if (~WPNeg)
        begin
            Sec_Prot_reg[1] = SubSec_Prot[vs*SubSecNum];
            Sec_Prot_reg[0] = SubSec_Prot[vs*(SubSecNum-2)+1];
            SubSec_Prot[vs*SubSecNum]       = 1'b1;
            SubSec_Prot[vs*(SubSecNum-2)+1] = 1'b1;
        end
        else
          begin
            SubSec_Prot[vs*SubSecNum]       = Sec_Prot_reg[1];
            SubSec_Prot[vs*(SubSecNum-2)+1] = Sec_Prot_reg[0];
          end

    end

    initial
    begin : InitCFI
    integer i;
    integer j;
        ///////////////////////////////////////////////////////////////////////
        //CFI array data
        ///////////////////////////////////////////////////////////////////////
            for(i=16; i<=90; i=i+1)
                  CFI_array[i] = 16'h0;

            //CFI query identification string
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
            //system interface string
            CFI_array[16'h1B] = 16'h27;
            CFI_array[16'h1C] = 16'h36;
            CFI_array[16'h1D] = 16'h00;
            CFI_array[16'h1E] = 16'h00;
            CFI_array[16'h1F] = 16'h04;
            CFI_array[16'h20] = 16'h00;
            CFI_array[16'h21] = 16'h0A;
            CFI_array[16'h22] = 16'h00;
            CFI_array[16'h23] = 16'h05;
            CFI_array[16'h24] = 16'h00;
            CFI_array[16'h25] = 16'h04;
            CFI_array[16'h26] = 16'h00;
            //device geometry definition
            CFI_array[16'h27] = 16'h16;
            CFI_array[16'h28] = 16'h02;
            CFI_array[16'h29] = 16'h00;
            CFI_array[16'h2A] = 16'h05;
            CFI_array[16'h2B] = 16'h00;
            CFI_array[16'h2C] = 16'h02;
            CFI_array[16'h2D] = 16'h3F;
            CFI_array[16'h2E] = 16'h00;
            CFI_array[16'h2F] = 16'h20;
            CFI_array[16'h30] = 16'h00;
            CFI_array[16'h31] = 16'h3E;
            CFI_array[16'h32] = 16'h00;
            CFI_array[16'h33] = 16'h00;
            CFI_array[16'h34] = 16'h01;
            CFI_array[16'h35] = 16'h00;
            CFI_array[16'h36] = 16'h00;
            CFI_array[16'h37] = 16'h00;
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
            CFI_array[16'h44] = 16'h31;
            CFI_array[16'h45] = 16'h00;
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h01;
            CFI_array[16'h49] = 16'h04;
            CFI_array[16'h4A] = 16'h00;
            CFI_array[16'h4B] = 16'h00;
            CFI_array[16'h4C] = 16'h00;
            CFI_array[16'h4D] = 16'hB5;
            CFI_array[16'h4E] = 16'hC5;
            if ( ~vs )
                CFI_array[16'h4F] = 16'h02;
            else
                CFI_array[16'h4F] = 16'h03;
            
    end

    function integer sa;
    input integer sect;
    begin
        sa = sect * (SecSize + 1);
    end
    endfunction

    function integer sssa;
    input integer vs;
    input integer subsect;
    begin
        if (subsect == 0)
            sssa=16'h0000;
        else if (subsect == 1)
            sssa=16'h2000;
        else if (subsect == 2)
            sssa=16'h4000;
        else if (subsect == 3)
            sssa=16'h6000;
        else if (subsect == 4)
            sssa=16'h8000;
        else if (subsect == 5)
            sssa=16'hA000;
        else if (subsect == 6)
            sssa=16'hC000;
        else if (subsect == 7)
            sssa=16'hE000;
    end
    endfunction

    function integer ssea;
    input integer vs;
    input integer subsect;
    begin
        if (subsect == 0)
            ssea=16'h1FFF;
        else if (subsect == 1)
            ssea=16'h3FFF;
        else if (subsect == 2)
            ssea=16'h5FFF;
        else if (subsect == 3)
            ssea=16'h7FFF;
        else if (subsect == 4)
            ssea=16'h9FFF;
        else if (subsect == 5)
            ssea=16'hBFFF;
        else if (subsect == 6)
            ssea=16'hDFFF;
        else if (subsect == 7)
            ssea=16'hFFFF;
    end
    endfunction

//////Read from memory
    task MemRead;
    inout [15:0] DOut_zd;
    begin
    if (Mem[(SecAddr*(SecSize+1))+Address]==-1)
        DOut_zd[7:0] = 8'bx;
    else
        DOut_zd[7:0] = Mem[(SecAddr*(SecSize+1))+Address];
    if (BYTENeg)
        if (Mem[(SecAddr*(SecSize+1))+Address+1]==-1)
            DOut_zd[15:8]= 8'bx;
        else
            DOut_zd[15:8] = Mem[(SecAddr*(SecSize+1))+Address+1];
    end
    endtask

/////////Read from CFI
    task  CFIRead;
    inout [15:0] DOut_zd;
    begin
    DOut_zd[15:0] = 16'b0;
    //CFI read using 16bit address
    if ((Addr>16'h10)&&(Addr<16'h4F))
    begin
        if (~BYTENeg)
            DOut_zd[15:8] = 8'bZ;
        DOut_zd[7:0] = CFI_array[Addr];
    end
    else
        $display("Invalid CFI query address");
    end
    endtask

/////////////Read AS Code
    task  ASRead;
    inout [15:0] DOut_zd;
    begin
        if (~BYTENeg)
            if ((Addr == 0) || (Addr == 1) || (Addr == 2) || (Addr == 3))
                DOut_zd[15:8] = 0;
            else  
                DOut_zd[15:8] = 8'hZ;
        else
            if (Addr == 1)
                DOut_zd[15:8] = 8'h22;
            else if ((Addr == 0) || (Addr == 2) || (Addr == 3))
                DOut_zd[15:8] = 0;
            else
                DOut_zd[15:8] = 8'hZ;
        if (Addr == 0)
            DOut_zd[7:0] = 1;
        else if (Addr == 1)
            if (vs == 1) 
            DOut_zd[7:0] = 8'hF6;
        else 
            DOut_zd[7:0] = 8'hF9;
        else if (Addr == 2)
        begin
            DOut_zd[7:1] = 7'b0;
            if ( SecAddr == VarSect )
                DOut_zd[0] = SubSec_Prot[SubSect];
            else
                DOut_zd[0] = Sec_Prot[SecAddr];
        end
        else if (Addr == 3)
        begin
        if (FactoryProt)
            DOut_zd[7:0] = 8'h99;
        else
            DOut_zd[7:0] = 8'h19;
        end
    end
    endtask

    reg  BuffInOE, BuffInCE, BuffInADDR;
    wire BuffOutOE, BuffOutCE, BuffOutADDR;

    BUFFER    BUFOE   (BuffOutOE, BuffInOE);
    BUFFER    BUFCE   (BuffOutCE, BuffInCE);
    BUFFER    BUFADDR (BuffOutADDR, BuffInADDR);
    initial
    begin
        BuffInOE   = 1'b1;
        BuffInCE   = 1'b1;
        BuffInADDR = 1'b1;
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
        ADDRDQ = $time;
    end
endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule