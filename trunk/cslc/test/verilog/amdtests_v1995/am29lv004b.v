//////////////////////////////////////////////////////////////////////////////
//  File name : am29lv004b.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  |    author:    | % date:   | changes made:
//    V1.0       A.Savic       04 Aprl 08     Initial
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           am29lv004b
//
//  Description:   4Mbit(512K x 8-Bit) CMOS Flash Memory
//                 Boot sector architecture determined by TimingModel generic
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am29lv004b
(
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
    RY

);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////

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
    output RY       ;

// interconnect path delay signals

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

    wire [18 : 0] A;
    assign A = {
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

    wire  DQ7_ipd   ;
    wire  DQ6_ipd   ;
    wire  DQ5_ipd   ;
    wire  DQ4_ipd   ;
    wire  DQ3_ipd   ;
    wire  DQ2_ipd   ;
    wire  DQ1_ipd   ;
    wire  DQ0_ipd   ;

    wire [7 : 0 ] DIn;
    assign DIn = {DQ7_ipd,
                  DQ6_ipd,
                  DQ5_ipd,
                  DQ4_ipd,
                  DQ3_ipd,
                  DQ2_ipd,
                  DQ1_ipd,
                  DQ0_ipd };

    wire [7 : 0 ] DOut;
    assign DOut = {DQ7,
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

//  internal delays

    reg START_T1    ; // Start TimeOut
    reg START_T1_in ;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

    reg [7 : 0] DOut_zd;

    wire  DQ7_Pass   ;
    wire  DQ6_Pass   ;
    wire  DQ5_Pass   ;
    wire  DQ4_Pass   ;
    wire  DQ3_Pass   ;
    wire  DQ2_Pass   ;
    wire  DQ1_Pass   ;
    wire  DQ0_Pass   ;
    reg [7 : 0] DOut_Pass;
    assign {DQ7_Pass,
            DQ6_Pass,
            DQ5_Pass,
            DQ4_Pass,
            DQ3_Pass,
            DQ2_Pass,
            DQ1_Pass,
            DQ0_Pass  } = DOut_Pass;

    reg RY_zd;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID    = "AM29LV004B";
    parameter MaxData   = 255;
    parameter SecSize   = 65535;
    parameter SecNum    = 7;
    parameter SubSecNum = 3;
    parameter HiAddrBit = 18;

    //varaibles to resolve if bottom or top architecture is used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ESP_ACT  ; ////Erase Suspend

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
    reg [SubSecNum:0] Ers_sub_queue;

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SubSect = 0;         // 0 - SubSecNum
    integer SA      = 0;         // 0 TO SecNum
    integer SSA     = 0;         // 0 TO SubSecNum
    //Address within sector
    integer Address = 0;         // 0 - SecSize


    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    //A19:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer Mem[0:(SecNum+1)*(SecSize+1)-1];
    //Sector Protection Status
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;
    //Sector Protection for first 4 sectors
    //or last 4, depending on chosen model
    reg [SubSecNum:0] SubSec_Prot;

    // timing check violation
    reg Viol = 1'b0;

    //Address of variable size sector (bottom or top boot sector)
    integer VarSect = -1;
    reg     vs;


    integer WBData[0:1];
    integer WBAddr[0:1];

    reg oe = 1'b0;
    event oe_event;
    event MergeE;

    //Status reg.
    reg[7:0] Status = 16'b0;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    integer S_ind = 0;
    integer ind = 0;

    reg[7:0] temp;

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
   reg FROMADDR;
   integer   OEDQ_01;
   integer   CEDQ_01;
   integer   ADDRDQ_01;

   reg[7:0] TempData;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ7 ,   DQ7_Pass  , 1);
    nmos   (DQ6 ,   DQ6_Pass  , 1);
    nmos   (DQ5 ,   DQ5_Pass  , 1);
    nmos   (DQ4 ,   DQ4_Pass  , 1);
    nmos   (DQ3 ,   DQ3_Pass  , 1);
    nmos   (DQ2 ,   DQ2_Pass  , 1);
    nmos   (DQ1 ,   DQ1_Pass  , 1);
    nmos   (DQ0 ,   DQ0_Pass  , 1);

    nmos   (RY  ,   1'b0      , ~RY_zd);

    wire deg;

    //VHDL VITAL CheckEnable equivalents
    // Address setup/hold near WE# falling edge
    wire ChecktOEH_WE;
    assign ChecktOEH_WE = ((~PDONE || ~EDONE) && OENeg && ~CENeg);
    wire ChecktOEH_CE;
    assign ChecktOEH_CE = ((~PDONE || ~EDONE) && OENeg && ~WENeg);
    wire CheckEnable_A0_CE;
    assign CheckEnable_A0_CE = ~WENeg && OENeg;
    wire CheckEnable_A0_WE;
    assign CheckEnable_A0_WE = ~CENeg && OENeg;
    wire ChecktGHWL_WE;
    assign ChecktGHWL_WE = ((OENeg === 1'b1) && (CENeg === 1'b0));
    wire ChecktGHWL_CE;
    assign ChecktGHWL_CE = ((OENeg === 1'b1) && (WENeg === 1'b0));
    wire CheckEnable_DQ0_WE;
    assign CheckEnable_DQ0_WE = ~CENeg && OENeg && deg;
    wire CheckEnable_DQ0_CE;
    assign CheckEnable_DQ0_CE = ~WENeg && OENeg && deg;

specify

        // tipd delays: interconnect path delays , mapped to input port delays.
        // In Verilog is not necessary to declare any tipd_ delay variables,
        // they can be taken from SDF file
        // With all the other delays real delays would be taken from SDF file

    // tpd delays
    specparam           tpd_RESETNeg_DQ0        =1;
    specparam           tpd_A0_DQ0              =1;//tacc ok
    specparam           tpd_CENeg_DQ0           =1;//ok
                      //(tCE,tCE,tDF,-,tDF,-)
    specparam           tpd_OENeg_DQ0           =1;//ok
                      //(tOE,tOE,tDF,-,tDF,-)
    specparam           tpd_WENeg_RY            =1;    //tBUSY
    specparam           tpd_CENeg_RY            =1;    //tBUSY

    // tsetup values: setup time
    specparam           tsetup_A0_WENeg         =1;   //tAS edge \
    specparam           tsetup_DQ0_WENeg        =1;   //tDS edge /
    specparam           tsetup_OENeg_WENeg      =1;   //0 edge /
    specparam           tsetup_CENeg_WENeg      =1;   //0 ns /

    // thold values: hold times
    specparam           thold_A0_WENeg          =1; //tAH  edge \
    specparam           thold_DQ0_WENeg         =1; //tDH edge /
    specparam           thold_OENeg_WENeg       =1; //tOEH edge /
    specparam           thold_CENeg_WENeg       =1; //tOEH edge /
    specparam           thold_OENeg_RESETNeg    =1; //tRH  edge /
    specparam           thold_CENeg_RESETNeg    =1; //tRH  edge /
    specparam           thold_WENeg_OENeg       =1; //tGHWL edge /

     // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1; //tRP
     specparam           tpw_WENeg_negedge       =1; //tWP
     specparam           tpw_WENeg_posedge       =1; //tWPH
     specparam           tpw_CENeg_negedge       =1; //tCP
     specparam           tpw_CENeg_posedge       =1; //tCEPH

     // tdevice values: values for internal delays
     //Program Operation
     specparam   tdevice_POB                     = 9000; //9 us;
     //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 700000000; //700 ms;
     //Program/Erase suspend timeout
     specparam   tdevice_START_T1               = 20000; //20 us;
     //Sector Erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 50000; //50 us;
     //Device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 20000; //20 us; //tReady

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

    if ( FROMADDR )  ( A0 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A0 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A1 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A2 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A3 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A4 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A5 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A6 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A7 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A8 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A9 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A10 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A11 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A12 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A13 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A14 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A15 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A16 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A17 => DQ7 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ0 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ1 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ2 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ3 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ4 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ5 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ6 ) = tpd_A0_DQ0;
    if ( FROMADDR )  ( A18 => DQ7 ) = tpd_A0_DQ0;


//for RY signal
  (WENeg => RY)     = tpd_WENeg_RY;
  (CENeg => RY)     = tpd_CENeg_RY;


////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

        //tOEH, OE# HoldHigh near WE# /, Toggle
        $hold ( posedge WENeg &&& ChecktOEH_WE, OENeg , thold_OENeg_WENeg, Viol);
        $hold ( posedge CENeg &&& ChecktOEH_CE, OENeg , thold_OENeg_WENeg, Viol);
        //tRH, RESET# high time before read
        $hold ( posedge RESETNeg &&& (CENeg===1), CENeg , thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& (OENeg===1), OENeg , thold_CENeg_RESETNeg, Viol);
        //tRP, RESET# low
        $width (negedge RESETNeg, tpw_RESETNeg_negedge);

        // Address setup/hold checks near WE#/CE# falling edge
        $setup ( A0 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A1 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A2 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A3 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A4 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A5 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A6 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
        $setup ( A7 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_WENeg, Viol);
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


        // DQ setup/hold near WE#/CE# rising edge
        $setup ( DQ0 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ0 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ0  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ1  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ2  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ3  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ4  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ5  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ6  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& CheckEnable_DQ0_CE, DQ7  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ0  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ1  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ2  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ3  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ4  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ5  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ6  ,  thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CheckEnable_DQ0_WE, DQ7  ,  thold_DQ0_WENeg, Viol);

        //Write pulse width
        $width (negedge WENeg &&& (CENeg === 1'b0), tpw_WENeg_negedge);
        $width (negedge CENeg &&& (WENeg === 1'b0), tpw_WENeg_negedge);
        $width (posedge WENeg, tpw_WENeg_posedge);
        $width (posedge CENeg, tpw_WENeg_posedge);

        // OE# SetupHigh to WE#/CE# low
        $setup ( OENeg   , negedge WENeg &&& ChecktGHWL_WE , tsetup_OENeg_WENeg, Viol);
        $setup ( OENeg   , negedge CENeg &&& ChecktGHWL_CE , tsetup_OENeg_WENeg, Viol);
        //tCS
        $setup ( CENeg   , negedge WENeg &&& (CENeg === 1'b0) , tsetup_CENeg_WENeg, Viol);
        $setup ( WENeg   , negedge CENeg &&& (WENeg === 1'b0) , tsetup_CENeg_WENeg, Viol);
        //tCH
        $hold ( posedge WENeg &&& (CENeg === 1'b0), CENeg , thold_CENeg_WENeg, Viol);
        $hold ( posedge CENeg &&& (WENeg === 1'b0), WENeg , thold_CENeg_WENeg, Viol);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET               =6'd0;
 parameter Z001                =6'd1;
 parameter PREL_SETBWB         =6'd2;
 parameter PREL_ULBYPASS       =6'd3;
 parameter PREL_ULBYPASS_RESET =6'd4;
 parameter AS                  =6'd5;
 parameter A0SEEN              =6'd6;
 parameter C8                  =6'd7;
 parameter C8_Z001             =6'd8;
 parameter C8_PREL             =6'd9;
 parameter ERS                 =6'd10;
 parameter SERS                =6'd11;
 parameter ESPS                =6'd12;
 parameter SERS_EXEC           =6'd13;
 parameter ESP                 =6'd14;
 parameter ESP_Z001            =6'd15;
 parameter ESP_PREL            =6'd16;
 parameter ESP_A0SEEN          =6'd17;
 parameter ESP_AS              =6'd18;
 parameter PGMS                =6'd19;

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
    // check when data is generated from model to avoid setuphold check in
    // those occasion
    assign deg=deq;

    initial
    begin: InitMemory
    integer i,j;
    integer tmp1,tmp2,tmp3;
    reg     sector_prot[0:SecNum+SubSecNum];

//TOP OR BOTTOM arch model is used
    //assumptions:
    //1. TimingModel has format as
    //"AM29LV004BT70EC"
    //it is important that 11-th character from first one is "T" or "B"

    //2. TimingModel does not have more then 20 characters

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
        tmp_char[j] = TimingModel[(i-9)*8+j];//bottom/top character is 10
        end                                  //characters right from first ("a")
     end

    if (tmp_char == "T")
        begin
        VarSect = SecNum;
        vs      = 1'b1;
        end
    else   // Bottom boot sector architecture
        begin
        VarSect = 0;
        vs      = 1'b0;
        end

        for (i=0;i<=((SecNum+1)*(SecSize+1)-1);i=i+1)
        begin
           Mem[i]=MaxData;
        end

        for (i=0;i<=SecNum+SubSecNum;i=i+1)
        begin
           sector_prot[i]=0;
        end
        for (i=0;i<=3;i=i+1)
        begin
           SubSec_Prot[i] = 0;
        end

        if (UserPreload && !(prot_file_name == "none"))
        begin
           //am29lv004b_prot  sector protect file
           //   //      - comment
           //   @aa    - <aaa> stands for sector address
           //   (aa is incremented at every load)
           //   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
           //am29lv004b memory preload file
           //  @aaaaa   - <aaaa> stands for address within last defined sector
           //  dd      - <dd> is byte to be written at Mem(nn)(aaaa++)
           // (aaaaa is incremented at every load)
           $readmemh(mem_file_name,Mem);
        end

         for (i=0;i<=SecNum;i=i+1)
         begin
             Ers_queue[i] = 0;
             Sec_Prot[i]  = sector_prot[i];
         end
         //Load smaller size sectors
        for (i=0;i<=SubSecNum;i=i+1)
        begin
             Ers_sub_queue[i] = 0;
             SubSec_Prot[i] = sector_prot[SecNum+i];
        end
        //Loaded as top, convert if bottom ( SHIFT )
        if (VarSect == 0)
            for(i=SecNum;i>0;i=i-1)
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
             RY_zd = 1'b1;
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
always @(negedge RST)
begin
    if (RESETNeg !== 1'b0)
    begin
        ESP_ACT = 1'b0;
        ULBYPASS = 1'b0;
    end
end

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
         READY or PoweredUp)
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

//    ///////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    ///////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

//    //latch address on rising edge and data on falling edge  of write
    always @(gWE_n or gCE_n or gOE_n)//or RESETNeg)
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

//    ///////////////////////////////////////////////////////////////////////////
//    // Latch address on falling edge of WE# or CE# what ever comes later
//    // Latches data on rising edge of WE# or CE# what ever comes first
//    // also Write cycle decode
//    ///////////////////////////////////////////////////////////////////////////
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
                A_tmp  =  A[15:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 =  A[15:0];
            end
        end
   end

   always @(CENeg_ipd)
   begin
        if (reseted)
        begin
            if (~CENeg_ipd && (WENeg_ipd != OENeg_ipd) )
            begin
                A_tmp  =  A[15:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 =  A[15:0];
            end
        end
   end

   always @(negedge OENeg_ipd )//or reseted)
   begin
        if (reseted)
        begin
            if (~OENeg_ipd && WENeg_ipd && ~CENeg_ipd)
            begin
                A_tmp  =  A[15:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 =  A[15:0];
            end
            if (~OENeg_ipd)
            begin
                SecAddr = SA_tmp;
                Address = A_tmp1;
                for(i=0;i<=SubSecNum;i=i+1)
                begin
                   if ( A_tmp1 >= sssa(i) && A_tmp1 <= ssea(i) )
                   begin
                      SubSect = i;
                   end
                end
                CE = CENeg;
                Addr   = A_tmp;
          end
        end
   end

   always @(A)// or reseted)
   begin
        if (reseted)
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  A[15:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 =  A[15:0];
                SecAddr = SA_tmp;
                Address = A_tmp1;
                for(i=0;i<=SubSecNum;i=i+1)
                begin
                   if ( A_tmp1 >= sssa(i) && A_tmp1 <= ssea(i) )
                   begin
                      SubSect = i;
                   end
                end
                CE = CENeg;
                Addr   = A_tmp;
            end
    end

    always @(posedge write)
    begin
        SecAddr = SA_tmp;
        Address = A_tmp1;
        for(i=0;i<=SubSecNum;i=i+1)
        begin
            if( A_tmp1 >= sssa(i) && A_tmp1 <= ssea(i) )
            begin
                SubSect = i;
            end
        end
        CE = CENeg;
        Addr   = A_tmp;
    end


//    ///////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
//    ///////////////////////////////////////////////////////////////////////////

 integer cnt_write = 0;
 //time elapsed_write  ;
 time duration_write ;
 //time start_write    ;
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
                       (~Ers_queue[SA] || ~ESP_ACT ))) ||
                     ( SA == VarSect &&
                      ( ~SubSec_Prot[SSA] &&
                       (~Ers_sub_queue[SSA] || ~ESP_ACT ))))
                begin
                    duration_write = tdevice_POB;
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
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if ( i == VarSect )
                    begin
                        for(j=0;j<=SubSecNum;j=j+1)
                        begin
                            if ((Ers_sub_queue[j]==1'b1) && (~SubSec_Prot[j]))
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
                    duration_erase = cnt_erase* tdevice_SEO;
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

//    ///////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    ///////////////////////////////////////////////////////////////////////////
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
            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
            A_PAT_1   = (Addr==16'h555);
    end

    always @(negedge write or reseted)
    begin: StateGen1
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (~write)
            case (current_state)
            RESET :
            begin
                    if (PATTERN_1)
                        next_state = Z001;
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
                    else//?
                        next_state = RESET;
            end

            PREL_ULBYPASS :
            begin
                    if (DataLo == 16'h90 )
                        next_state <= PREL_ULBYPASS_RESET;
                    if (DataLo == 16'hA0)
                        next_state = A0SEEN;
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

            AS :
            begin
                    if (DataLo==16'hF0)
                        next_state = RESET;
                    else
                        next_state = AS;
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


            ERS :
            begin
            end


            SERS :
            begin
                   if (~CTMOUT)
                        if (DataLo == 16'hB0)
                            next_state = ESP; // ESP according to datasheet
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
                  else
                  begin
                      if (PATTERN_1)
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
                    if (A_PAT_1 && DataLo == 16'hA0)
                        next_state = ESP_A0SEEN;
                    else if (A_PAT_1 && DataLo == 16'h90)
                        next_state = ESP_AS;
                    else
                        next_state = ESP;
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

            endcase
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
                next_state = RESET;

        end
    end

    always @(negedge write or reseted)
    begin: StateGen7 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS_EXEC)
                if ((write==1'b0) && (EERR!=1'b1))
                    if (DataLo==16'hB0)
                    begin
                        next_state = ESPS;
                        ESUSP = 1'b1;
                        ESUSP <= #1 1'b0;
                    end
        end
    end


    always @(CTMOUT or reseted)
    begin: StateGen4 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS)
                if (CTMOUT)  next_state = SERS_EXEC;
        end
    end

    always @(posedge START_T1 or reseted)
    begin: StateGen5 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==ESPS)
                if (START_T1) next_state = ESP;
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
          ->oe_event;
    end
    always @(Address, SecAddr)
    begin
        if (read)
             ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    always @(DOut_zd)
    begin : OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            CEDQ_t = CENeg_event  + CEDQ_01;
            OEDQ_t = OENeg_event  + OEDQ_01;
            ADDRDQ_t = ADDR_event + ADDRDQ_01;

            FROMADDR = 1'b1;
            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t)&&FROMOE) ||
              ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                FROMADDR = 1'b0;
                TempData = DOut_zd;
                DOut_Pass[7:0] = 8'bx;
                #(ADDRDQ_t - $time) DOut_Pass <= TempData;
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

    always @(oe or reseted or current_state)
    begin
        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                ESP_ACT   = 1'b0;
                RY_zd = 1'b1;
                if (oe)
                    MemRead(DOut_zd);
            end

            PREL_ULBYPASS :
            begin
                RY_zd = 1'b1;
            end

            AS, ESP_AS :
            begin
                if (oe)
                begin
                    if ((Addr % 16'h100) == 0)
                        DOut_zd = 1;
                    else if ((Addr % 16'h100) == 1)
                        begin
                            if (vs == 1)
                                DOut_zd = 8'hB5;
                             else
                                DOut_zd = 8'hB6;
                        end
                    else if ((Addr % 16'h100) == 2)
                    begin
                        DOut_zd[7:1] = 7'b0;
                        if ( SecAddr == VarSect )
                            DOut_zd[0] = SubSec_Prot[SubSect];
                        else
                            DOut_zd[0] = Sec_Prot[SecAddr];
                    end
                    else DOut_zd[7:0] = 8'bz;
                end
            end

            ERS :
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    // read status / embeded erase algorithm - Chip Erase
                    ///////////////////////////////////////////////////////////
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    Status[2] = ~Status[2]; //toggle

                    DOut_zd = Status;
                end
                RY_zd = 1'b0;
            end

        SERS :
        begin
            if (oe)
            begin
                    ///////////////////////////////////////////////////////////
                    //read status - sector erase timeout
                    ///////////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    Status[3] = 1'b0;

                    DOut_zd = Status;
            end
            //ready signal active
            RY_zd = 1'b1;
        end

        ESPS :
        begin
            if (oe)
            begin
                    ///////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ///////////////////////////////////////////////////////////
                    if (((SecAddr == VarSect)&&(Ers_sub_queue[SubSect] == 1'b1))
                    || ((SecAddr != VarSect)&&(Ers_queue[SecAddr]==1'b1)))
                    begin
                        Status[7] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                    end
                    else
                        Status[7] = 1'b1;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    DOut_zd = Status;
            end
        end

        SERS_EXEC:
        begin
            if (oe)
            begin
                    ///////////////////////////////////////////////////
                    //read status erase
                    ///////////////////////////////////////////////////
                    if (((SecAddr == VarSect)&&(Ers_sub_queue[SubSect] == 1'b1))
                    || ((SecAddr != VarSect)&&(Ers_queue[SecAddr]==1'b1)))
                    begin
                        Status[7] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                    end
                    else
                    Status[7] = 1'b1;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    DOut_zd = Status;
            end
            RY_zd = 1'b0;
        end

        ESP :
        begin
            if (oe)
            begin
                ///////////////////////////////////////////////////////////
                //read
                ///////////////////////////////////////////////////////////

                if    (( SecAddr != VarSect && Ers_queue[SecAddr]!=1'b1)
                       || ( SecAddr == VarSect && Ers_sub_queue[SubSect]!=1'b1))
                begin
                    MemRead(DOut_zd);
                end
                else
                begin
                    ///////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    // Status[6) No toggle
                    Status[5] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                    DOut_zd = Status;
                end
            end
            //ready signal active
            RY_zd = 1'b1;
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
                Status[1] = 1'b0;
                DOut_zd = Status;
                if (((SecAddr == VarSect)&&(SubSect == SSA))
                    || ((SecAddr != VarSect)&&(SecAddr == SA)))
                    DOut_zd[7] = Status[7];
                else
                    DOut_zd[7] = ~Status[7];

            end

        end
        endcase

        end
    end
//*******************************************
    always @(negedge write or reseted)
    begin : Output_generation
        if (reseted)
        begin
        if (~write)
        begin
        case (current_state)

            PREL_SETBWB :
            begin
                    if (A_PAT_1 && (DataLo==16'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==16'h90))
                        ULBYPASS = 1'b0;
            end

            PREL_ULBYPASS :
            begin
                if (DataLo==16'h90)
                        ULBYPASS = 1'b0;
            end

            PREL_ULBYPASS_RESET :
            begin
                if (DataLo != 16'h00 )
                        ULBYPASS = 1'b1;
            end

            A0SEEN :
            begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WBData[0] = DataLo;
                    WBAddr[0] = Address;// % 32;
                    SA = SecAddr;
                    SSA = SubSect;
                    temp = DataLo;
                    Status[7] = ~temp[7];
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
                        Ers_sub_queue = ~(0);
                        Status = 16'b0000000000001000;
                    end
                    else if (DataLo==16'h30)
                    begin
                        //put selected sector to sec. ers. queue
                        //start timeout
                        Ers_queue = 0;
                        Ers_sub_queue = 0;
                        if ( SecAddr == VarSect )
                             Ers_sub_queue[SubSect] = 1'b1;
                        else
                             Ers_queue[SecAddr] = 1'b1;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;

                    end
            end

            SERS :
            begin
                  if (~CTMOUT)
                  begin
                    if (DataLo == 16'hB0)
                    begin
                        //need to start erase process prior to suspend
                        ESTART = 1'b1;
                        ESTART = #1 1'b0;
                        ESUSP  = 1'b0;
                        ESUSP  = #1 1'b1;
                        ESUSP  <= #2 1'b0;
                        ERES   = 1'b0;
                        //suspend timeout (should be 0 according to datasheet)
                    end
                    else if (DataLo==16'h30)
                    begin
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                        if ( SecAddr == VarSect )
                           Ers_sub_queue[SubSect] = 1'b1;
                        else
                           Ers_queue[SecAddr] = 1'b1;
                    end
                  end
            end

            SERS_EXEC :
            begin
                if (~EDONE && (EERR!=1'b1))
                    if (DataLo==16'hB0)
                    begin
                        START_T1_in = 1'b1;
                    end
            end

            ESP :
            begin
                if (DataLo == 16'h30)
                    begin
                        //resume erase
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                    end
            end

            ESP_A0SEEN :
            begin
                    ESP_ACT = 1'b1;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WBData[0] = DataLo;
                    WBAddr[0] = Address;// % 32;
                    SA = SecAddr;
                    SSA = SubSect;
                    temp = DataLo;
                    Status[7] = ~temp[7];
            end

        endcase
        end//(~write)
        end//(reseted)
    end

    always @(current_state or reseted)
    begin
        if (reseted)
            if (current_state==RESET) RY_zd = 1'b1;
            if (current_state==PREL_ULBYPASS) RY_zd = 1'b1;
            if (current_state==ERS) RY_zd = 1'b0;
            if (current_state==SERS) RY_zd = 1'b1;
            if (current_state==ESPS) RY_zd = 1'b0;
            if (current_state==SERS_EXEC) RY_zd = 1'b0;
            if (current_state==ESP) RY_zd = 1'b1;
            if (current_state==PGMS) RY_zd = 1'b0;

    end
//******************************
always @(EERR or EDONE or current_state)
begin : ERS2
integer i;
integer j;

    if (current_state==ERS)
    begin
        if (EERR!=1'b1)
            for (i=0;i<=SecNum;i=i+1)
            begin
                if ( i == VarSect)
                begin
                    for( j=0;j<=SubSecNum;j=j+1)
                        if ( SubSec_Prot[j]!=1'b1 )
                            for(k=sssa(j);k<=ssea(j);k=k+1)
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
                               for(k=sssa(j);k<=ssea(j);k=k+1)
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
        begin
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
            end
            RY_zd = 1'b1;
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
                //ESUSP = 1'b1;
                //ESUSP <= #1 1'b0;
            end
            RY_zd = 1'b0;
        end
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
        if (current_state==SERS_EXEC)
        begin//ja
            if (EERR!=1'b1)
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if ( i == VarSect)
                    begin
                        for( j=0;j<=SubSecNum;j=j+1)
                            if (SubSec_Prot[j]!=1'b1 && Ers_sub_queue[j]==1'b1)
                                for(k=sssa(j);k<=ssea(j);k=k+1)
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
                                if (SubSec_Prot[j]!=1'b1 && Ers_sub_queue[j] )
                                    for(k=sssa(j);k<=ssea(j);k=k+1)
                                        Mem[sa(i)+k] = MaxData;
                        end
                        else
                        begin
                            if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                                for (j=0;j<=SecSize;j=j+1)
                                    Mem[sa(i)+j] = MaxData;
                        end
                    end
            end
            //busy signal active
            RY_zd = 1'b0;
        end
    end
//
    always @(current_state or posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
        if (current_state==PGMS)
        begin
            //busy signal active
            RY_zd = 1'b0;
            if (PERR!=1'b1)
            begin
                    new_int= WBData[0];
                    old_int=Mem[sa(SA) + WBAddr[0]];

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

                        WBData[0]= new_int;
                    end
                    else
                        WBData[0]= -1;
                    Mem[sa(SA) + WBAddr[0]] = -1;

                if (PDONE)
                begin
                    Mem[sa(SA) + WBAddr[0]] = WBData[0];
                    WBData[0]= -1;
                end
            end
        end
    end

    always @(gOE_n or gCE_n or RESETNeg or RST )
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
             DOut_zd = 8'bZ;
    end

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
        ADDRDQ_01 = $time;
    end


    function integer sa;
    input integer sect;
    begin
        sa = sect * (SecSize + 1);
    end
    endfunction

    function integer sssa;
    input integer subsect;
    begin
        if ( vs == 0 )
        begin
            if (subsect == 0)
                sssa=16'h0000;
            else if (subsect == 1)
                sssa=16'h4000;
            else if (subsect == 2)
                sssa=16'h6000;
            else if (subsect == 3)
                sssa=16'h8000;
        end
        else
        begin
            if (subsect == 0)
                sssa=16'h0000;
            else if (subsect == 1)
                sssa=16'h8000;
            else if (subsect == 2)
                sssa=16'hA000;
            else if (subsect == 3)
                sssa=16'hC000;
        end
    end
    endfunction

    function integer ssea;
    input integer subsect;
    begin
        if ( vs == 0 )
        begin
            if (subsect == 0)
                ssea=16'h3FFF;
            else if (subsect == 1)
                ssea=16'h5FFF;
            else if (subsect == 2)
                ssea=16'h7FFF;
            else if (subsect == 3)
                ssea=16'hFFFF;
        end
        else
        begin
            if (subsect == 0)
                ssea=16'h7FFF;
            else if (subsect == 1)
                ssea=16'h9FFF;
            else if (subsect == 2)
                ssea=16'hBFFF;
            else if (subsect == 3)
                ssea=16'hFFFF;
        end
    end
    endfunction

task MemRead;
inout [15:0] DOut_zd;

begin
    if (Mem[sa(SecAddr)+Address]==-1)
            DOut_zd[7:0] = 8'bx;
    else
            DOut_zd[7:0] = Mem[sa(SecAddr)+Address];
end
endtask

endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
