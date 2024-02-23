///////////////////////////////////////////////////////////////////////////////
//  File name : am29lv017d.v
///////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  | author:        | % date:   | changes made:
//    V1.0     G. Gojanovic     04 Sep 03   Initial release
///////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           AM29LV017D
//
//  Description:   017DU 16Mbit(2M x 8-Bit) Uniform Sector Flash Memory
//
///////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                        //
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns
module am29lv017d
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

///////////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
///////////////////////////////////////////////////////////////////////////////
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

    reg HANG_out    ; // Program/Erase Timing Limit
    reg HANG_in     ;
    reg START_T1    ; // Start TimeOut
    reg START_T1_in ;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

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

    wire  DQ7_zd   ;
    wire  DQ6_zd   ;
    wire  DQ5_zd   ;
    wire  DQ4_zd   ;
    wire  DQ3_zd   ;
    wire  DQ2_zd   ;
    wire  DQ1_zd   ;
    wire  DQ0_zd   ;

    reg [7 : 0] DOut_zd;
    assign {DQ7_zd,
            DQ6_zd,
            DQ5_zd,
            DQ4_zd,
            DQ3_zd,
            DQ2_zd,
            DQ1_zd,
            DQ0_zd  } = DOut_zd;

    reg RY_zd;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID    = "AM29LV017D";
    parameter MaxData   = 255;
    parameter SecSize   = 65535;
    parameter SecNum    = 31;
    parameter HiAddrBit = 20;
    parameter MemSize   = (SecNum+1) *(SecSize+1)-1;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ESP_ACT  ; ////Erase Suspend
    reg AS_ACT   ; ////Autoselect active

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
    reg write ;
    reg read  ;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SA      = 0;         // 0 TO SecNum
    //Address within sector
    integer Address = 0;         // 0 - SecSize

    integer D_tmp0; //0 TO MaxData;

    //A20:A12 Don't Care
    integer Addr ;         //0 TO 16'hFFF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer Mem[0:MemSize];
    //Sector Protection Status
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;

    integer CFI_array[16:90];

    // timing check violation
    reg Viol = 1'b0;

    integer WBData;
    integer WBAddr;

    reg oe = 1'b0;
    event oe_event;

    //Status reg.
    reg[7:0] Status = 8'b0;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    integer S_ind = 0;
    integer ind = 0;

    reg[7:0] temp;

    integer i,j,k;

   //TPD_XX_DATA
    time WADDR;
    time OEDQ_t;
    time ADDRDQ_t;
    time CEDQ_t;
    time OENeg_event;
    time CENeg_event;
    time ADDR_event;
    reg FROMOE;
    reg FROMCE;
    reg FROMADDR;
    reg SWITCH;

    integer   OEDQ_01;
    integer   CEDQ_01;
    integer   ADDRDQ_01;
    reg[7:0] TempData;

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

    nmos   (RY  ,   1'b0    , ~RY_zd);

    wire deg;

specify

        // tipd delays: interconnect path delays , mapped to input port delays.
        // In Verilog is not necessary to declare any tipd_ delay variables,
        // they can be taken from SDF file
        // With all the other delays real delays would be taken from SDF file

    // tpd delays

    specparam           tpd_A0_DQ0              =1;
    specparam           tpd_A0_DQ1              =1;
    specparam           tpd_A0_DQ2              =1;
    specparam           tpd_A0_DQ3              =1;
    specparam           tpd_A0_DQ4              =1;
    specparam           tpd_A0_DQ5              =1;
    specparam           tpd_A0_DQ6              =1;
    specparam           tpd_A0_DQ7              =1;
    specparam           tpd_A1_DQ0              =1;
    specparam           tpd_A1_DQ1              =1;
    specparam           tpd_A1_DQ2              =1;
    specparam           tpd_A1_DQ3              =1;
    specparam           tpd_A1_DQ4              =1;
    specparam           tpd_A1_DQ5              =1;
    specparam           tpd_A1_DQ6              =1;
    specparam           tpd_A1_DQ7              =1;
    specparam           tpd_A2_DQ0              =1;
    specparam           tpd_A2_DQ1              =1;
    specparam           tpd_A2_DQ2              =1;
    specparam           tpd_A2_DQ3              =1;
    specparam           tpd_A2_DQ4              =1;
    specparam           tpd_A2_DQ5              =1;
    specparam           tpd_A2_DQ6              =1;
    specparam           tpd_A2_DQ7              =1;
    specparam           tpd_A3_DQ0              =1;
    specparam           tpd_A3_DQ1              =1;
    specparam           tpd_A3_DQ2              =1;
    specparam           tpd_A3_DQ3              =1;
    specparam           tpd_A3_DQ4              =1;
    specparam           tpd_A3_DQ5              =1;
    specparam           tpd_A3_DQ6              =1;
    specparam           tpd_A3_DQ7              =1;
    specparam           tpd_A4_DQ0              =1;
    specparam           tpd_A4_DQ1              =1;
    specparam           tpd_A4_DQ2              =1;
    specparam           tpd_A4_DQ3              =1;
    specparam           tpd_A4_DQ4              =1;
    specparam           tpd_A4_DQ5              =1;
    specparam           tpd_A4_DQ6              =1;
    specparam           tpd_A4_DQ7              =1;
    specparam           tpd_A5_DQ0              =1;
    specparam           tpd_A5_DQ1              =1;
    specparam           tpd_A5_DQ2              =1;
    specparam           tpd_A5_DQ3              =1;
    specparam           tpd_A5_DQ4              =1;
    specparam           tpd_A5_DQ5              =1;
    specparam           tpd_A5_DQ6              =1;
    specparam           tpd_A5_DQ7              =1;
    specparam           tpd_A6_DQ0              =1;
    specparam           tpd_A6_DQ1              =1;
    specparam           tpd_A6_DQ2              =1;
    specparam           tpd_A6_DQ3              =1;
    specparam           tpd_A6_DQ4              =1;
    specparam           tpd_A6_DQ5              =1;
    specparam           tpd_A6_DQ6              =1;
    specparam           tpd_A6_DQ7              =1;
    specparam           tpd_A7_DQ0              =1;
    specparam           tpd_A7_DQ1              =1;
    specparam           tpd_A7_DQ2              =1;
    specparam           tpd_A7_DQ3              =1;
    specparam           tpd_A7_DQ4              =1;
    specparam           tpd_A7_DQ5              =1;
    specparam           tpd_A7_DQ6              =1;
    specparam           tpd_A7_DQ7              =1;
    specparam           tpd_A8_DQ0              =1;
    specparam           tpd_A8_DQ1              =1;
    specparam           tpd_A8_DQ2              =1;
    specparam           tpd_A8_DQ3              =1;
    specparam           tpd_A8_DQ4              =1;
    specparam           tpd_A8_DQ5              =1;
    specparam           tpd_A8_DQ6              =1;
    specparam           tpd_A8_DQ7              =1;
    specparam           tpd_A9_DQ0              =1;
    specparam           tpd_A9_DQ1              =1;
    specparam           tpd_A9_DQ2              =1;
    specparam           tpd_A9_DQ3              =1;
    specparam           tpd_A9_DQ4              =1;
    specparam           tpd_A9_DQ5              =1;
    specparam           tpd_A9_DQ6              =1;
    specparam           tpd_A9_DQ7              =1;
    specparam           tpd_A10_DQ0              =1;
    specparam           tpd_A10_DQ1              =1;
    specparam           tpd_A10_DQ2              =1;
    specparam           tpd_A10_DQ3              =1;
    specparam           tpd_A10_DQ4              =1;
    specparam           tpd_A10_DQ5              =1;
    specparam           tpd_A10_DQ6              =1;
    specparam           tpd_A10_DQ7              =1;
    specparam           tpd_A11_DQ0              =1;
    specparam           tpd_A11_DQ1              =1;
    specparam           tpd_A11_DQ2              =1;
    specparam           tpd_A11_DQ3              =1;
    specparam           tpd_A11_DQ4              =1;
    specparam           tpd_A11_DQ5              =1;
    specparam           tpd_A11_DQ6              =1;
    specparam           tpd_A11_DQ7              =1;
    specparam           tpd_A12_DQ0              =1;
    specparam           tpd_A12_DQ1              =1;
    specparam           tpd_A12_DQ2              =1;
    specparam           tpd_A12_DQ3              =1;
    specparam           tpd_A12_DQ4              =1;
    specparam           tpd_A12_DQ5              =1;
    specparam           tpd_A12_DQ6              =1;
    specparam           tpd_A12_DQ7              =1;
    specparam           tpd_A13_DQ0              =1;
    specparam           tpd_A13_DQ1              =1;
    specparam           tpd_A13_DQ2              =1;
    specparam           tpd_A13_DQ3              =1;
    specparam           tpd_A13_DQ4              =1;
    specparam           tpd_A13_DQ5              =1;
    specparam           tpd_A13_DQ6              =1;
    specparam           tpd_A13_DQ7              =1;
    specparam           tpd_A14_DQ0              =1;
    specparam           tpd_A14_DQ1              =1;
    specparam           tpd_A14_DQ2              =1;
    specparam           tpd_A14_DQ3              =1;
    specparam           tpd_A14_DQ4              =1;
    specparam           tpd_A14_DQ5              =1;
    specparam           tpd_A14_DQ6              =1;
    specparam           tpd_A14_DQ7              =1;
    specparam           tpd_A15_DQ0              =1;
    specparam           tpd_A15_DQ1              =1;
    specparam           tpd_A15_DQ2              =1;
    specparam           tpd_A15_DQ3              =1;
    specparam           tpd_A15_DQ4              =1;
    specparam           tpd_A15_DQ5              =1;
    specparam           tpd_A15_DQ6              =1;
    specparam           tpd_A15_DQ7              =1;
    specparam           tpd_A16_DQ0              =1;
    specparam           tpd_A16_DQ1              =1;
    specparam           tpd_A16_DQ2              =1;
    specparam           tpd_A16_DQ3              =1;
    specparam           tpd_A16_DQ4              =1;
    specparam           tpd_A16_DQ5              =1;
    specparam           tpd_A16_DQ6              =1;
    specparam           tpd_A16_DQ7              =1;
    specparam           tpd_A17_DQ0              =1;
    specparam           tpd_A17_DQ1              =1;
    specparam           tpd_A17_DQ2              =1;
    specparam           tpd_A17_DQ3              =1;
    specparam           tpd_A17_DQ4              =1;
    specparam           tpd_A17_DQ5              =1;
    specparam           tpd_A17_DQ6              =1;
    specparam           tpd_A17_DQ7              =1;
    specparam           tpd_A18_DQ0              =1;
    specparam           tpd_A18_DQ1              =1;
    specparam           tpd_A18_DQ2              =1;
    specparam           tpd_A18_DQ3              =1;
    specparam           tpd_A18_DQ4              =1;
    specparam           tpd_A18_DQ5              =1;
    specparam           tpd_A18_DQ6              =1;
    specparam           tpd_A18_DQ7              =1;
    specparam           tpd_A19_DQ0              =1;
    specparam           tpd_A19_DQ1              =1;
    specparam           tpd_A19_DQ2              =1;
    specparam           tpd_A19_DQ3              =1;
    specparam           tpd_A19_DQ4              =1;
    specparam           tpd_A19_DQ5              =1;
    specparam           tpd_A19_DQ6              =1;
    specparam           tpd_A19_DQ7              =1;
    specparam           tpd_A20_DQ0              =1;
    specparam           tpd_A20_DQ1              =1;
    specparam           tpd_A20_DQ2              =1;
    specparam           tpd_A20_DQ3              =1;
    specparam           tpd_A20_DQ4              =1;
    specparam           tpd_A20_DQ5              =1;
    specparam           tpd_A20_DQ6              =1;
    specparam           tpd_A20_DQ7              =1;
    specparam           tpd_CENeg_DQ0           =1;
    specparam           tpd_CENeg_DQ1           =1;
    specparam           tpd_CENeg_DQ2           =1;
    specparam           tpd_CENeg_DQ3           =1;
    specparam           tpd_CENeg_DQ4           =1;
    specparam           tpd_CENeg_DQ5           =1;
    specparam           tpd_CENeg_DQ6           =1;
    specparam           tpd_CENeg_DQ7           =1;
    specparam           tpd_OENeg_DQ0           =1;
    specparam           tpd_OENeg_DQ1           =1;
    specparam           tpd_OENeg_DQ2           =1;
    specparam           tpd_OENeg_DQ3           =1;
    specparam           tpd_OENeg_DQ4           =1;
    specparam           tpd_OENeg_DQ5           =1;
    specparam           tpd_OENeg_DQ6           =1;
    specparam           tpd_OENeg_DQ7           =1;

    specparam           tpd_RESETNeg_DQ0           =1;
    specparam           tpd_RESETNeg_DQ1           =1;
    specparam           tpd_RESETNeg_DQ2           =1;
    specparam           tpd_RESETNeg_DQ3           =1;
    specparam           tpd_RESETNeg_DQ4           =1;
    specparam           tpd_RESETNeg_DQ5           =1;
    specparam           tpd_RESETNeg_DQ6           =1;
    specparam           tpd_RESETNeg_DQ7           =1;

    specparam           tpd_WENeg_RY            =1;    //tBUSY
    specparam           tpd_CENeg_RY            =1;    //tBUSY

    // tsetup values: setup time
    specparam           tsetup_A0_CENeg         =1;   //tAS edge \
    specparam           tsetup_DQ0_CENeg        =1;   //tDS edge /
    specparam           tsetup_OENeg_WENeg      =1;   //0 edge /
    specparam           tsetup_CENeg_WENeg      =1;   //0 ns /

    // thold values: hold times
    specparam           thold_A0_CENeg          =1; //tAH  edge \
    specparam           thold_DQ0_CENeg         =1; //tDH edge /
    specparam           thold_OENeg_WENeg       =1; //tOEH edge /
    specparam           thold_CENeg_WENeg       =1; //tOEH edge /
    specparam           thold_CENeg_RESETNeg    =1; //tRH  edge /

    specparam           thold_WENeg_OENeg       =1; //tGHVL edge /

    // tpw values: pulse width
    specparam           tpw_RESETNeg_negedge    =1; //tRP
    specparam           tpw_WENeg_negedge       =1; //tWP
    specparam           tpw_WENeg_posedge       =1; //tWPH
    specparam           tpw_CENeg_negedge       =1; //tCP
    specparam           tpw_CENeg_posedge       =1; //tCEPH
    specparam           tpw_A0_negedge          =1; //tWC tRC ok

   // tdevice values: values for internal delays
           //Program Operation
    specparam   tdevice_POB                     = 9000; //5 us;
           //Sector Erase Operation    tWHWH2
    specparam   tdevice_SEO                     = 700000000; //700 ms;
           //Timing Limit Exceeded
    specparam   tdevice_HANG                    = 400000000; //400 ms; //?
           //program/erase suspend timeout
    //specparam   tdevice_PSTART_T1               = 5000;  //5 us;
    specparam   tdevice_START_T1               = 20000; //20 us;
           //sector erase command sequence timeout
    specparam   tdevice_CTMOUT                  = 50000; //50 us;
           //device ready after Hardware reset(during embeded algorithm)
    specparam   tdevice_READY                   = 20000; //20 us; //tReady

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
//for DQ signals

    (A0 *> DQ0) = tpd_A0_DQ0;
    (A0 *> DQ1) = tpd_A0_DQ1;
    (A0 *> DQ2) = tpd_A0_DQ2;
    (A0 *> DQ3) = tpd_A0_DQ3;
    (A0 *> DQ4) = tpd_A0_DQ4;
    (A0 *> DQ5) = tpd_A0_DQ5;
    (A0 *> DQ6) = tpd_A0_DQ6;
    (A0 *> DQ7) = tpd_A0_DQ7;
    (A1 *> DQ0) = tpd_A1_DQ0;
    (A1 *> DQ1) = tpd_A1_DQ1;
    (A1 *> DQ2) = tpd_A1_DQ2;
    (A1 *> DQ3) = tpd_A1_DQ3;
    (A1 *> DQ4) = tpd_A1_DQ4;
    (A1 *> DQ5) = tpd_A1_DQ5;
    (A1 *> DQ6) = tpd_A1_DQ6;
    (A1 *> DQ7) = tpd_A1_DQ7;
    (A2 *> DQ0) = tpd_A2_DQ0;
    (A2 *> DQ1) = tpd_A2_DQ1;
    (A2 *> DQ2) = tpd_A2_DQ2;
    (A2 *> DQ3) = tpd_A2_DQ3;
    (A2 *> DQ4) = tpd_A2_DQ4;
    (A2 *> DQ5) = tpd_A2_DQ5;
    (A2 *> DQ6) = tpd_A2_DQ6;
    (A2 *> DQ7) = tpd_A2_DQ7;
    (A3 *> DQ0) = tpd_A3_DQ0;
    (A3 *> DQ1) = tpd_A3_DQ1;
    (A3 *> DQ2) = tpd_A3_DQ2;
    (A3 *> DQ3) = tpd_A3_DQ3;
    (A3 *> DQ4) = tpd_A3_DQ4;
    (A3 *> DQ5) = tpd_A3_DQ5;
    (A3 *> DQ6) = tpd_A3_DQ6;
    (A3 *> DQ7) = tpd_A3_DQ7;
    (A4 *> DQ0) = tpd_A4_DQ0;
    (A4 *> DQ1) = tpd_A4_DQ1;
    (A4 *> DQ2) = tpd_A4_DQ2;
    (A4 *> DQ3) = tpd_A4_DQ3;
    (A4 *> DQ4) = tpd_A4_DQ4;
    (A4 *> DQ5) = tpd_A4_DQ5;
    (A4 *> DQ6) = tpd_A4_DQ6;
    (A4 *> DQ7) = tpd_A4_DQ7;
    (A5 *> DQ0) = tpd_A5_DQ0;
    (A5 *> DQ1) = tpd_A5_DQ1;
    (A5 *> DQ2) = tpd_A5_DQ2;
    (A5 *> DQ3) = tpd_A5_DQ3;
    (A5 *> DQ4) = tpd_A5_DQ4;
    (A5 *> DQ5) = tpd_A5_DQ5;
    (A5 *> DQ6) = tpd_A5_DQ6;
    (A5 *> DQ7) = tpd_A5_DQ7;
    (A6 *> DQ0) = tpd_A6_DQ0;
    (A6 *> DQ1) = tpd_A6_DQ1;
    (A6 *> DQ2) = tpd_A6_DQ2;
    (A6 *> DQ3) = tpd_A6_DQ3;
    (A6 *> DQ4) = tpd_A6_DQ4;
    (A6 *> DQ5) = tpd_A6_DQ5;
    (A6 *> DQ6) = tpd_A6_DQ6;
    (A6 *> DQ7) = tpd_A6_DQ7;
    (A7 *> DQ0) = tpd_A7_DQ0;
    (A7 *> DQ1) = tpd_A7_DQ1;
    (A7 *> DQ2) = tpd_A7_DQ2;
    (A7 *> DQ3) = tpd_A7_DQ3;
    (A7 *> DQ4) = tpd_A7_DQ4;
    (A7 *> DQ5) = tpd_A7_DQ5;
    (A7 *> DQ6) = tpd_A7_DQ6;
    (A7 *> DQ7) = tpd_A7_DQ7;
    (A8 *> DQ0) = tpd_A8_DQ0;
    (A8 *> DQ1) = tpd_A8_DQ1;
    (A8 *> DQ2) = tpd_A8_DQ2;
    (A8 *> DQ3) = tpd_A8_DQ3;
    (A8 *> DQ4) = tpd_A8_DQ4;
    (A8 *> DQ5) = tpd_A8_DQ5;
    (A8 *> DQ6) = tpd_A8_DQ6;
    (A8 *> DQ7) = tpd_A8_DQ7;
    (A9 *> DQ0) = tpd_A9_DQ0;
    (A9 *> DQ1) = tpd_A9_DQ1;
    (A9 *> DQ2) = tpd_A9_DQ2;
    (A9 *> DQ3) = tpd_A9_DQ3;
    (A9 *> DQ4) = tpd_A9_DQ4;
    (A9 *> DQ5) = tpd_A9_DQ5;
    (A9 *> DQ6) = tpd_A9_DQ6;
    (A9 *> DQ7) = tpd_A9_DQ7;
    (A10 *> DQ0) = tpd_A10_DQ0;
    (A10 *> DQ1) = tpd_A10_DQ1;
    (A10 *> DQ2) = tpd_A10_DQ2;
    (A10 *> DQ3) = tpd_A10_DQ3;
    (A10 *> DQ4) = tpd_A10_DQ4;
    (A10 *> DQ5) = tpd_A10_DQ5;
    (A10 *> DQ6) = tpd_A10_DQ6;
    (A10 *> DQ7) = tpd_A10_DQ7;
    (A11 *> DQ0) = tpd_A11_DQ0;
    (A11 *> DQ1) = tpd_A11_DQ1;
    (A11 *> DQ2) = tpd_A11_DQ2;
    (A11 *> DQ3) = tpd_A11_DQ3;
    (A11 *> DQ4) = tpd_A11_DQ4;
    (A11 *> DQ5) = tpd_A11_DQ5;
    (A11 *> DQ6) = tpd_A11_DQ6;
    (A11 *> DQ7) = tpd_A11_DQ7;
    (A12 *> DQ0) = tpd_A12_DQ0;
    (A12 *> DQ1) = tpd_A12_DQ1;
    (A12 *> DQ2) = tpd_A12_DQ2;
    (A12 *> DQ3) = tpd_A12_DQ3;
    (A12 *> DQ4) = tpd_A12_DQ4;
    (A12 *> DQ5) = tpd_A12_DQ5;
    (A12 *> DQ6) = tpd_A12_DQ6;
    (A12 *> DQ7) = tpd_A12_DQ7;
    (A13 *> DQ0) = tpd_A13_DQ0;
    (A13 *> DQ1) = tpd_A13_DQ1;
    (A13 *> DQ2) = tpd_A13_DQ2;
    (A13 *> DQ3) = tpd_A13_DQ3;
    (A13 *> DQ4) = tpd_A13_DQ4;
    (A13 *> DQ5) = tpd_A13_DQ5;
    (A13 *> DQ6) = tpd_A13_DQ6;
    (A13 *> DQ7) = tpd_A13_DQ7;
    (A14 *> DQ0) = tpd_A14_DQ0;
    (A14 *> DQ1) = tpd_A14_DQ1;
    (A14 *> DQ2) = tpd_A14_DQ2;
    (A14 *> DQ3) = tpd_A14_DQ3;
    (A14 *> DQ4) = tpd_A14_DQ4;
    (A14 *> DQ5) = tpd_A14_DQ5;
    (A14 *> DQ6) = tpd_A14_DQ6;
    (A14 *> DQ7) = tpd_A14_DQ7;
    (A15 *> DQ0) = tpd_A15_DQ0;
    (A15 *> DQ1) = tpd_A15_DQ1;
    (A15 *> DQ2) = tpd_A15_DQ2;
    (A15 *> DQ3) = tpd_A15_DQ3;
    (A15 *> DQ4) = tpd_A15_DQ4;
    (A15 *> DQ5) = tpd_A15_DQ5;
    (A15 *> DQ6) = tpd_A15_DQ6;
    (A15 *> DQ7) = tpd_A15_DQ7;
    (A16 *> DQ0) = tpd_A16_DQ0;
    (A16 *> DQ1) = tpd_A16_DQ1;
    (A16 *> DQ2) = tpd_A16_DQ2;
    (A16 *> DQ3) = tpd_A16_DQ3;
    (A16 *> DQ4) = tpd_A16_DQ4;
    (A16 *> DQ5) = tpd_A16_DQ5;
    (A16 *> DQ6) = tpd_A16_DQ6;
    (A16 *> DQ7) = tpd_A16_DQ7;
    (A17 *> DQ0) = tpd_A17_DQ0;
    (A17 *> DQ1) = tpd_A17_DQ1;
    (A17 *> DQ2) = tpd_A17_DQ2;
    (A17 *> DQ3) = tpd_A17_DQ3;
    (A17 *> DQ4) = tpd_A17_DQ4;
    (A17 *> DQ5) = tpd_A17_DQ5;
    (A17 *> DQ6) = tpd_A17_DQ6;
    (A17 *> DQ7) = tpd_A17_DQ7;
    (A18 *> DQ0) = tpd_A18_DQ0;
    (A18 *> DQ1) = tpd_A18_DQ1;
    (A18 *> DQ2) = tpd_A18_DQ2;
    (A18 *> DQ3) = tpd_A18_DQ3;
    (A18 *> DQ4) = tpd_A18_DQ4;
    (A18 *> DQ5) = tpd_A18_DQ5;
    (A18 *> DQ6) = tpd_A18_DQ6;
    (A18 *> DQ7) = tpd_A18_DQ7;
    (A19 *> DQ0) = tpd_A19_DQ0;
    (A19 *> DQ1) = tpd_A19_DQ1;
    (A19 *> DQ2) = tpd_A19_DQ2;
    (A19 *> DQ3) = tpd_A19_DQ3;
    (A19 *> DQ4) = tpd_A19_DQ4;
    (A19 *> DQ5) = tpd_A19_DQ5;
    (A19 *> DQ6) = tpd_A19_DQ6;
    (A19 *> DQ7) = tpd_A19_DQ7;
    (A20 *> DQ0) = tpd_A20_DQ0;
    (A20 *> DQ1) = tpd_A20_DQ1;
    (A20 *> DQ2) = tpd_A20_DQ2;
    (A20 *> DQ3) = tpd_A20_DQ3;
    (A20 *> DQ4) = tpd_A20_DQ4;
    (A20 *> DQ5) = tpd_A20_DQ5;
    (A20 *> DQ6) = tpd_A20_DQ6;
    (A20 *> DQ7) = tpd_A20_DQ7;

    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ0) = tpd_CENeg_DQ0;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ1) = tpd_CENeg_DQ1;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ2) = tpd_CENeg_DQ2;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ3) = tpd_CENeg_DQ3;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ4) = tpd_CENeg_DQ4;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ5) = tpd_CENeg_DQ5;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ6) = tpd_CENeg_DQ6;
    if (~SWITCH || (SWITCH && FROMCE))
      (CENeg *> DQ7) = tpd_CENeg_DQ7;

    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ0) = tpd_OENeg_DQ0;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ1) = tpd_OENeg_DQ1;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ2) = tpd_OENeg_DQ2;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ3) = tpd_OENeg_DQ3;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ4) = tpd_OENeg_DQ4;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ5) = tpd_OENeg_DQ5;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ6) = tpd_OENeg_DQ6;
    if (~SWITCH || (SWITCH && FROMOE))
      (OENeg *> DQ7) = tpd_OENeg_DQ7;

    if (~RESETNeg) (RESETNeg *> DQ0) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) (RESETNeg *> DQ1) = tpd_RESETNeg_DQ1;
    if (~RESETNeg) (RESETNeg *> DQ2) = tpd_RESETNeg_DQ2;
    if (~RESETNeg) (RESETNeg *> DQ3) = tpd_RESETNeg_DQ3;
    if (~RESETNeg) (RESETNeg *> DQ4) = tpd_RESETNeg_DQ4;
    if (~RESETNeg) (RESETNeg *> DQ5) = tpd_RESETNeg_DQ5;
    if (~RESETNeg) (RESETNeg *> DQ6) = tpd_RESETNeg_DQ6;
    if (~RESETNeg) (RESETNeg *> DQ7) = tpd_RESETNeg_DQ7;

//for RY signal
    (WENeg => RY)     = tpd_WENeg_RY;
    (CENeg => RY)     = tpd_CENeg_RY;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                          //
///////////////////////////////////////////////////////////////////////////////

    $setup ( A0 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A1 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A2 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A3 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A4 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A5 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A6 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A7 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A8 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A9 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A10 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A11 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A12 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A13 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A14 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A15 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A16 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A17 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A18 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A19 , negedge CENeg, tsetup_A0_CENeg, Viol);
    $setup ( A20 , negedge CENeg, tsetup_A0_CENeg, Viol);

    $setup ( A0 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A1 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A2 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A3 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A4 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A5 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A6 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A7 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A8 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A9 , negedge WENeg,  tsetup_A0_CENeg, Viol);
    $setup ( A10 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A11 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A12 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A13 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A14 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A15 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A16 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A17 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A18 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A19 , negedge WENeg, tsetup_A0_CENeg, Viol);
    $setup ( A20 , negedge WENeg, tsetup_A0_CENeg, Viol);

    $setup ( DQ0 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ1 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ2 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ3 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ4 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ5 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ6 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ7 , posedge CENeg &&& deg, tsetup_A0_CENeg, Viol);
    $setup ( DQ0 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ1 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ2 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ3 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ4 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ5 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ6 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);
    $setup ( DQ7 , posedge WENeg &&& deg,  tsetup_A0_CENeg, Viol);

    $setup ( CENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);
    $setup ( OENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);
    $setup ( OENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);

    $hold ( posedge RESETNeg &&& (CENeg===1),CENeg ,thold_CENeg_RESETNeg,Viol);
    $hold ( posedge RESETNeg &&& (OENeg===1),OENeg ,thold_CENeg_RESETNeg,Viol);
    $hold ( posedge OENeg, WENeg , thold_WENeg_OENeg, Viol);
    $hold ( posedge WENeg, OENeg , thold_OENeg_WENeg, Viol);
    $hold ( posedge WENeg, CENeg , thold_WENeg_OENeg, Viol);
    $hold ( posedge OENeg, CENeg , thold_WENeg_OENeg, Viol);

    $hold ( negedge CENeg, A0 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A1 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A2 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A3 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A4 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A5 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A6 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A7 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A8 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A9 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A10 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A11 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A12 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A13 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A14 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A15 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A16 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A17 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A18 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A19 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, A20 , thold_A0_CENeg, Viol);

    $hold ( negedge WENeg, A0 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A1 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A2 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A3 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A4 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A5 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A6 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A7 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A8 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A9 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A10 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A11 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A12 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A13 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A14 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A15 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A16 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A17 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A18 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A19 , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A20 , thold_A0_CENeg, Viol);

    $hold ( negedge CENeg, DQ0 ,  thold_DQ0_CENeg, Viol);
    $hold ( negedge CENeg, DQ1 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ2 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ3 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ4 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ5 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ6 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ7 ,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ0  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ1  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ2  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ3  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ4  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ5  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ6  ,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ7  ,   thold_A0_CENeg, Viol);

    $width (negedge RESETNeg, tpw_RESETNeg_negedge);
    $width (posedge WENeg, tpw_WENeg_posedge);
    $width (negedge WENeg, tpw_WENeg_negedge);
    $width (posedge CENeg, tpw_CENeg_posedge);
    $width (negedge CENeg, tpw_CENeg_negedge);
    $width (negedge A0, tpw_A0_negedge);//ok
    $width (posedge A0, tpw_A0_negedge);//ok

endspecify
///////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                       //
///////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET           =6'd0;
 parameter Z001            =6'd1;
 parameter PREL_SETBWB     =6'd2;
 parameter PREL_ULBYPASS   =6'd3;
 parameter PREL_ULBYPASS_RESET   =6'd4;
 parameter CFI             =6'd5;
 parameter AS              =6'd6;
 parameter A0SEEN          =6'd7;
 parameter C8              =6'd8;
 parameter C8_Z001         =6'd9;
 parameter C8_PREL         =6'd10;
 parameter ERS             =6'd11;
 parameter SERS            =6'd12;
 parameter ESPS            =6'd13;
 parameter SERS_EXEC       =6'd14;
 parameter ESP             =6'd15;
 parameter ESP_Z001        =6'd16;
 parameter ESP_PREL        =6'd17;
 parameter ESP_A0SEEN      =6'd18;
 parameter ESP_AS          =6'd19;
 parameter PGMS            =6'd20;

 reg [5:0] current_state;
 reg [5:0] next_state;

 reg deq;

    integer sector_preload[0:MemSize];
    reg     sector_prot[0:SecNum];

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

    // initialize memory and load preoload files if any

        for (i=0;i<=MemSize;i=i+1)
        begin
           sector_preload[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
           sector_prot[i]=0;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            Sec_Prot[i] = 0;
            Ers_queue[i] = 0;
        end

        if (UserPreload && prot_file_name != "none")
        begin
           //am29lv017d_prot  sector protect file
           //   //      - comment
           //   @aa    - <aa> stands for sector address
           //   (aa is incremented at every load)
           //   b       - <b> is 1 for protected sector <aa>, 0 for unprotect.
           $readmemb(prot_file_name,sector_prot);
       end
       if (UserPreload && mem_file_name != "none")
       begin
           //am29lv017d.mem, memory preload file
           //  @aaaaaa - <aaaaaa> stands for address within last defined sector
           //  dd      - <dd> is byte to be written at Mem(nn)(aaaa++)
           // (aaaaaa is incremented at every load)
           $readmemh(mem_file_name,sector_preload);
        end

        for (j=0;j<=MemSize;j=j+1)
            Mem[j]=sector_preload[j];

       //sector protect
        for (i=0;i<SecNum;i=i+1)
        begin
            Sec_Prot[i]  = sector_prot[i];
        end
        WBData = 0;
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
        ESP_ACT  = 1'b0;
        AS_ACT   = 1'b0;

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
     #(tdevice_CTMOUT-5) CTMOUT = CTMOUT_in;
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

//    /////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    /////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd;
    assign #5 gCE_n = CENeg_ipd;
    assign #5 gOE_n = OENeg_ipd;

//    //latch address on rising edge and data on falling edge  of write
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

//    /////////////////////////////////////////////////////////////////////////
//    //Process that reports warning when changes on signals WE#, CE#, OE# are
//    //discarded
//    /////////////////////////////////////////////////////////////////////////
    always @(WENeg)
    begin: PulseWatch1
        if (gWE_n == WENeg) $display("Glitch on WE#");
    end
    always @(CENeg)
    begin: PulseWatch2
        if (gCE_n == CENeg)
            $display("Glitch on CE#");
    end

    always @(OENeg)
    begin: PulseWatch3
        if (gOE_n == OENeg)
            $display("Glitch on OE#");
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
    always @(A)
    begin
        ADDR_event = $time;
    end

//    /////////////////////////////////////////////////////////////////////////
//    //Latch address on falling edge of WE# or CE# what ever comes later
//    //Latches data on rising edge of WE# or CE# what ever comes first
//    // also Write cycle decode
//    /////////////////////////////////////////////////////////////////////////
        integer A_tmp  ;
        integer SA_tmp ;
        integer A_tmp1 ;

        reg CE;

    always @(WENeg_ipd)
    begin
        if (reseted)
        begin
            if (~WENeg_ipd && ~CENeg_ipd && OENeg_ipd )
            begin
                A_tmp  =  A[11:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 = A[15:0];
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
                A_tmp  =  A[11:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 = A[15:0];
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
                A_tmp  =  A[11:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 = A[15:0];
            end
            if (~OENeg_ipd)
            begin
                SecAddr = SA_tmp;
                Address = A_tmp1;

                CE = CENeg;
                Addr   = A_tmp;
            end
        end
    end
   always @(A)
    begin
        if (reseted)
        begin
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  A[11:0];
                SA_tmp =  A[HiAddrBit:16];
                A_tmp1 = A[15:0];

                SecAddr = SA_tmp;
                Address = A_tmp1;

                CE = CENeg;
                Addr   = A_tmp;
            end
       end
    end

   always @(posedge write)
   begin
       SecAddr = SA_tmp;
       Address = A_tmp1;
       CE = CENeg;
       Addr   = A_tmp;
   end

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
//    /////////////////////////////////////////////////////////////////////////

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
                if ((~Sec_Prot[SA] && (~Ers_queue[SA] || ~ESP_ACT )))
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

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    /////////////////////////////////////////////////////////////////////////
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
                    if ((Ers_queue[i]==1'b1) && (Sec_Prot[i]!=1'b1))
                        cnt_erase = cnt_erase + 1;
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
//    /////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    /////////////////////////////////////////////////////////////////////////
        reg PATTERN_1  = 1'b0;
        reg PATTERN_2  = 1'b0;

        //DATA Low Byte
        integer DataLo   ;

    always @(negedge write)
    begin
        if (~write)
        begin
            DataLo = DIn[7:0];
            PATTERN_1 = (DataLo==8'hAA) ;
            PATTERN_2 = (DataLo==8'h55) ;
        end
    end

    always @(negedge write or reseted)
    begin: StateGen1
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (~write)
        begin
        case (current_state)
            RESET :
            begin
                if (PATTERN_1)
                    next_state = Z001;
                else if ((Addr==8'h55) && (DataLo==8'h98))
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
                if (DataLo==16'h20)
                    next_state = PREL_ULBYPASS;
                else if  (DataLo==16'h90)
                    next_state = AS;
                else if (DataLo==16'hA0)
                    next_state = A0SEEN;
                else if (DataLo==16'h80)
                    next_state = C8;
                else
                    next_state = RESET;
            end


            PREL_ULBYPASS :
            begin
                if (DataLo==16'h90)
                    next_state = PREL_ULBYPASS_RESET;
                else if (DataLo==16'hA0)
                    next_state = A0SEEN;
                else
                    next_state = PREL_ULBYPASS;
            end

            PREL_ULBYPASS_RESET :
            begin
                if (DataLo==16'h00)
                   next_state = RESET;
                else
                   next_state = PREL_ULBYPASS;
            end

            CFI :
            begin
                if ((Addr==16'h55) && (DataLo==16'h98))
                    next_state = CFI;
                else if ((DataLo==16'hF0) && (AS_ACT==1'b0) && (ESP_ACT!=1'b1))
                    next_state = RESET;
                else if ((DataLo==16'hF0) && (AS_ACT==1'b1) && (ESP_ACT==1'b1))
                    next_state = ESP_AS;
                else if ((DataLo==16'hF0) && (AS_ACT==1'b1))
                    next_state = AS;
                else if ((DataLo==16'hF0) && (ESP_ACT==1'b1) && (AS_ACT!=1'b1))
                    next_state = ESP;
                else
                    next_state =  CFI;
            end

            AS :
            begin
                if (DataLo==16'hF0)
                    next_state = RESET;
                else if ((Addr==16'h55) && (DataLo==16'h98))
                    next_state = CFI;
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
                if (DataLo==16'h10)
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
                begin
                    if (DataLo == 16'hB0)
                        next_state = ESP; // ESP according to datasheet
                    else if (DataLo==16'h30)
                        next_state = SERS;
                    else
                       next_state = RESET;
                end
            end

            SERS_EXEC :
            begin
            end

            ESP :
            begin
                if (DataLo == 16'h30)
                    next_state = SERS_EXEC;
                else if (PATTERN_1)
                    next_state = ESP_Z001;
                else if ((Addr==16'h55) && (DataLo==16'h98))
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
                if (DataLo == 16'hA0)
                    next_state = ESP_A0SEEN;
                else if (DataLo == 16'h90)
                    next_state = ESP_AS;
                else
                    next_state = ESP;
            end

            ESP_A0SEEN :
            begin
                next_state = PGMS;
            end

            ESP_AS :
            begin
                if (DataLo == 16'hF0)
                    next_state = ESP;
                else if ((Addr==16'h55) && (DataLo==16'h98))
                    next_state = CFI;
            end

            PGMS :
            begin
            end

        endcase
        end
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
                next_state = RESET;
            end
        end
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

    always @(CTMOUT or reseted)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS)
                if (CTMOUT)
                    next_state = SERS_EXEC;
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

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
          ->oe_event;
    end
    always @(Address or SecAddr)
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
                    MemRead(DOut_zd[7:0]);
            end

            CFI :
            begin
                if (oe)
                begin
                    DOut_zd[7:0] = 8'bz;
                    if (((Addr>=16'h10)&&(Addr<=16'h3C))||
                    ((Addr>=16'h40)&&(Addr<=16'h4C)))
                    begin
                            DOut_zd[7:0] = CFI_array[Addr];
                    end
                    else
                        $display ("Invalid CFI query address");
                end
            end

            AS :
            begin
                if (oe)
                begin
                    if (Addr == 0)
                        DOut_zd[7:0] = 1;
                    else if (Addr == 1)
                        begin
                                DOut_zd[7:0] = 8'hC8;
                        end
                    else if (Addr == 2)
                    begin
                        DOut_zd[7:1] = 7'b0;
                        DOut_zd[0] = Sec_Prot[SecAddr];
                    end
                    else
                        $display ("Invalid address in autoselect");
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

                    DOut_zd[7:0] = Status;
                end
            end

            SERS :
            begin
                if (oe)
                begin
                        ///////////////////////////////////////////////////////
                        //read status - sector erase timeout
                        ///////////////////////////////////////////////////////
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
                    //read is modified so status 2 toggles only if sector
                    // selected for erasure is read
                    // if sector that is not selected for erasure is read
                    // Status 2 stays does not change vaule
                    if ( Ers_queue[SecAddr]==1'b1)
                        Status[2] = ~Status[2]; //toggle
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;

                    DOut_zd[7:0] = Status;
                end
            end

            SERS_EXEC:
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////////////
                    //read status erase HANG
                    ///////////////////////////////////////////////////////////
                    //%el should never hang
                    //read is modified so status 2 toggles only if sector
                    // selected for erasure is read
                    // if sector that is not selected for erasure is read
                    // Status 2 stays does not change vaule
                    if ( Ers_queue[SecAddr]==1'b1)
                        Status[2] = ~Status[2]; //toggle
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;

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
                    if (Ers_queue[SecAddr]!=1'b1)
                    begin
                        MemRead(DOut_zd[7:0]);
                    end
                    else
                    begin
                        ///////////////////////////////////////////////////////
                        //read status
                        ///////////////////////////////////////////////////////
                        Status[7] = 1'b1;
                        Status[5] = 1'b0;
                        Status[2] = ~Status[2]; //toggle

                        DOut_zd[7:0] = Status;
                    end
                end
            end

            ESP_AS :
            begin
                if (oe)
                begin
                    if (Addr == 0)
                        DOut_zd[7:0] = 1;
                    else if (Addr == 1)
                            DOut_zd[7:0] = 8'hC8;
                    else if (Addr == 2)
                    begin
                        DOut_zd[7:1] = 7'b0;
                             DOut_zd[0] = Sec_Prot[SecAddr];
                    end
                    else
                        $display ("Invalid address in autoselect");
                end
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
                    DOut_zd[7:0] = Status;
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
            RESET :
            begin
                ESP_ACT   = 1'b0;

                    if (PATTERN_1)
                    begin
                    end
                    else if ((Addr==16'h55) && (DataLo==16'h98))
                        ULBYPASS = 1'b0;
                //ready signal active
                RY_zd = 1'b1;
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                if (DataLo==16'h20)
                    ULBYPASS = 1'b1;
                else if (DataLo==16'h90)
                    AS_ACT = 1'b1;
            end

            PREL_ULBYPASS :
            begin
            end

            PREL_ULBYPASS_RESET :
            begin
                if (DataLo==16'h00)
                    ULBYPASS = 1'b0;
            end

            CFI :
            begin
            end

            AS :
            begin
                if (DataLo==16'hF0)
                    AS_ACT = 1'b0;
            end

            A0SEEN :
            begin
                PSTART = 1'b1;
                PSTART <= #1 1'b0;

                WBData = -1;
                if (Viol!=1'b0)
                begin
                    Viol=1'b0;
                end
                else
                begin
                    WBData = DataLo;
                end
                WBAddr = Address;
                SA = SecAddr;
                temp = DataLo;
                Status[7] = ~temp[7];
            end

            C8 :
            begin
                if (PATTERN_1)
                begin
                end
            end

            C8_Z001 :
            begin
            end

            C8_PREL :
            begin
                if (DataLo==16'h10)
                begin
                    //Start Chip Erase
                    ESTART = 1'b1;
                    ESTART <= #1 1'b0;
                    ESUSP  = 1'b0;
                    ERES   = 1'b0;
                    Ers_queue = ~(0);
                    Status = 8'b00001000;
                end
                else if (DataLo==16'h30)
                begin
                    //put selected sector to sec. ers. queue
                    //start timeout
                    Ers_queue = 0;
                    Ers_queue[SecAddr] = 1'b1;
                    disable TCTMOUTr;
                    CTMOUT_in = 1'b0;
                    CTMOUT_in <= #1 1'b1;
                end
            end

            ERS :
            begin
                RY_zd = 1'b0;//
            end

            SERS :
            begin
                if (~CTMOUT)
                begin
                    if (DataLo == 16'hB0)
                    begin
                        //need to start erase process prior to suspend
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP  = 1'b1;
                        ERES   = 1'b0;
                        //suspend timeout (should be 0 according to datasheet)
                        START_T1_in = 1'b1;
                    end
                    else if (DataLo==16'h30)
                    begin
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        CTMOUT_in <= #1 1'b1;
                           Ers_queue[SecAddr] = 1'b1;
                    end
                end
                //ready signal active
                RY_zd = 1'b1;
            end

            SERS_EXEC :
            begin
                if (~EDONE && (EERR!=1'b1))
                    if (DataLo==16'hB0)
                    begin
                        ESUSP  = 1'b1;
                        START_T1_in = 1'b1;
                    end
            RY_zd = 1'b0;
            end

            ESP :
            begin
                if (DataLo == 16'h30)
                begin
                    //resume erase
                    ERES = 1'b1;
                    ERES <= #1 1'b0;
                end
                //ready signal active
                RY_zd = 1'b1;
            end

            ESP_Z001 :
            begin
            end

            ESP_PREL :
            begin
                if (DataLo==16'h90)
                    AS_ACT = 1'b1;
            end

            ESP_AS :
            begin
                    if (DataLo==16'hF0)
                        AS_ACT = 1'b0;
            end

            ESP_A0SEEN :
            begin
                ESP_ACT = 1'b1;

                PSTART = 1'b1;
                PSTART <= #1 1'b0;

                WBData = -1;
                if (Viol!=1'b0)
                begin
                    Viol = 1'b0;
                end
                else
                begin
                    WBData = DataLo;
                end
                WBAddr = Address;
                SA = SecAddr;

                temp = DataLo;
                Status[7] = ~temp[7];
            end

            PGMS :
            begin
                //busy signal active
                RY_zd = 1'b0;
            end

        endcase
        end
        end
    end
    always @(current_state or reseted)
    begin
        if (reseted)
            if (current_state==RESET) RY_zd = 1'b1;
            if (current_state==PREL_ULBYPASS) RY_zd = 1'b1;
            if (current_state==ERS) RY_zd = 1'b0;//ja
            if (current_state==SERS) RY_zd = 1'b1;//ja
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
                    if (Sec_Prot[i]!=1'b1)
                        for (j=0;j<=SecSize;j=j+1)
                            Mem[sa(i)+j] = -1;
            end
            if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                        if (Sec_Prot[i]!=1'b1)
                            for (j=0;j<=SecSize;j=j+1)
                                Mem[sa(i)+j] = MaxData;
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
            //ready signal active
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
                ESUSP = 1'b0;
            end
            //busy signal active
            RY_zd = 1'b0;//
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
                        if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                            for (j=0;j<=SecSize;j=j+1)
                                Mem[sa(i)+j] = -1;
                end

                if (EDONE)
                    for (i=0;i<=SecNum;i=i+1)
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
                begin
                    new_int= WBData;
                    if  (WBAddr >= 0)
                        old_int=Mem[sa(SA)+WBAddr];

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

                        WBData = new_int;
                    end
                    else
                        WBData = -1;
                end

                begin
                    if (WBAddr < 0)
                            $display("Write Address error");
                    else    //mem write
                        Mem[sa(SA)+WBAddr] = -1;
                end

                if (PDONE && ~PSTART)
                    begin
                        if (WBAddr> -1)
                            //mem write
                            Mem[sa(SA)+WBAddr] = WBData;
                        WBData = -1;
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
            ADDRDQ_t = ADDR_event + ADDRDQ_01;
            SWITCH = 1;
            WADDR = ADDRDQ_t- $time;
            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            FROMADDR = 1'b1;
            if ((ADDRDQ_t > $time )&&(((ADDRDQ_t>=OEDQ_t)&&FROMOE) ||
              ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                TempData = DOut_zd;
                FROMADDR = 1'b0;
                DOut_Pass[7:0] = 8'bx;
                DOut_Pass <= #(WADDR) TempData;
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
           SWITCH = 0;
           DOut_Pass = DOut_zd;
       end
    end

    always @(gOE_n or RESETNeg or RST)
    begin
        //Output Disable Control
        if (gOE_n || (~RESETNeg && ~RST))
            DOut_zd = 8'bZ;
    end

    initial
    begin
        ///////////////////////////////////////////////////////////////////////
        //CFI array data
        ///////////////////////////////////////////////////////////////////////

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
            CFI_array[16'h27] = 16'h15;
            CFI_array[16'h28] = 16'h00;
            CFI_array[16'h29] = 16'h00;
            CFI_array[16'h2A] = 16'h00;
            CFI_array[16'h2B] = 16'h00;
            CFI_array[16'h2C] = 16'h01;
            CFI_array[16'h2D] = 16'h1F;
            CFI_array[16'h2E] = 16'h00;
            CFI_array[16'h2F] = 16'h00;
            CFI_array[16'h30] = 16'h01;
            CFI_array[16'h31] = 16'h00;
            CFI_array[16'h32] = 16'h00;
            CFI_array[16'h33] = 16'h00;
            CFI_array[16'h34] = 16'h00;
            CFI_array[16'h35] = 16'h00;
            CFI_array[16'h36] = 16'h00;
            CFI_array[16'h37] = 16'h80;
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
            CFI_array[16'h44] = 16'h30;
            CFI_array[16'h45] = 16'h01;
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h01;
            CFI_array[16'h49] = 16'h04;
            CFI_array[16'h4A] = 16'h00;
            CFI_array[16'h4B] = 16'h00;
            CFI_array[16'h4C] = 16'h00;
    end

function integer sa;
input integer sect;
begin
    sa = sect * (SecSize + 1);
end
endfunction

task MemRead;
inout [7:0] DOut_zd;
begin
    if (Mem[sa(SecAddr)+Address]==-1)
            DOut_zd[7:0] = 8'bx;
    else
            DOut_zd[7:0] = Mem[sa(SecAddr)+Address];
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
        ADDRDQ_01 = $time;
    end

endmodule

module BUFFER ( OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
