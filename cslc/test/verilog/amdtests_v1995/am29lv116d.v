//////////////////////////////////////////////////////////////////////////////
//  File name : am29lv116d.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version: | author:         | % date: | changes made:
//    V1.0    J.Bogosavljevic   04 Jul 30 Initial release
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           am29lv116d
//
//  Description:   16Mbit (2M x 8-Bit)Boot Sector Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am29lv116d
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
    assign DOut ={DQ7,
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

    wire  DQ7_z   ;
    wire  DQ6_z   ;
    wire  DQ5_z   ;
    wire  DQ4_z   ;
    wire  DQ3_z   ;
    wire  DQ2_z   ;
    wire  DQ1_z   ;
    wire  DQ0_z   ;

    reg [7 : 0] DOut_zd;
    reg [7 : 0] DOut_z;
    assign {DQ7_z,
            DQ6_z,
            DQ5_z,
            DQ4_z,
            DQ3_z,
            DQ2_z,
            DQ1_z,
            DQ0_z  } = DOut_z;

    reg RY_zd;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID        = "am29lv116d";
    parameter MaxData       = 255;
    parameter MemSize       = 21'h1FFFFF;
    parameter SecSize_l     = 16'hFFFF;
    parameter SecSize_s_32  = 16'h7FFF;
    parameter SecSize_s_16  = 16'h3FFF;
    parameter SecSize_s_8   = 16'h1FFF;
    parameter SecNum        = 34;
    parameter BootSecNum    = 3;
    parameter HiAddrBit     = 20;
    parameter MinCfiAddr    = 16'h10;
    parameter MaxCfiAddr    = 16'h4C;

    // powerup
    reg PoweredUp;

    //varaibles to resolve if bottom or top architecture is used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;


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

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SA      = 0;         // 0 TO SecNum

    //Address within sector
    integer Address = 0;         // 0 - SecSize

    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    //A21:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer Mem[0:MemSize];
    //Sector Protection Status
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;
    integer CFI_array[MinCfiAddr:MaxCfiAddr];

    // timing check violation
    reg     Viol = 1'b0;

    integer WBData;
    integer WBAddr;
    reg     top;
    reg oe = 1'b0;
    event oe_event;

    event initOK;
    event MergeE;

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
    time OEDQ_t;
    time CEDQ_t;
    time ADDRDQ_t;

    time OEDQ_open_t;
    time CEDQ_open_t;
    time ADDRDQ_open_t;

    time OENeg_event = 0;
    time CENeg_event= 0;
    time ADDR_event= 0;
    time wait_time;

    reg FROMOE;
    reg FROMCE;
    reg SWITCH;

    integer ADDRDQ_01;
    integer OEDQ_1z;
    integer CEDQ_1z;

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
 nmos   (DQ7 ,   DQ7_z  , 1);
 nmos   (DQ6 ,   DQ6_z  , 1);
 nmos   (DQ5 ,   DQ5_z  , 1);
 nmos   (DQ4 ,   DQ4_z  , 1);
 nmos   (DQ3 ,   DQ3_z  , 1);
 nmos   (DQ2 ,   DQ2_z  , 1);
 nmos   (DQ1 ,   DQ1_z  , 1);
 nmos   (DQ0 ,   DQ0_z  , 1);

 nmos   (RY  ,   1'b0, ~RY_zd);
                          
 wire deg;
 wire cond1;
 wire cond2;
 assign cond1 = (~PDONE || ~EDONE);
 assign cond2 = (cond1 && OENeg == 1'b1);
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

     specparam           tpd_WENeg_RY            =1;
     specparam           tpd_CENeg_RY            =1;

// tsetup values: setup time
     specparam           tsetup_A0_OENeg         =1;
     specparam           tsetup_DQ0_CENeg         =1;
// thold values: hold times
     specparam           thold_A0_CENeg          =1;
     specparam           thold_A0_WENeg          =1;

     specparam           thold_OENeg_WENeg       =1;

     specparam           thold_CENeg_RESETNeg    =1;
     specparam           thold_OENeg_RESETNeg    =1;
     specparam           thold_WENeg_RESETNeg    =1;
        // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1;
     specparam           tpw_WENeg_negedge       =1;
     specparam           tpw_WENeg_posedge       =1;
     specparam           tpw_CENeg_negedge       =1;
     specparam           tpw_CENeg_posedge       =1;
     specparam           tpw_A0_negedge          =1;
     specparam           tpw_A1_negedge          =1;
     specparam           tpw_A2_negedge          =1;
     specparam           tpw_A3_negedge          =1;
     specparam           tpw_A4_negedge          =1;
     specparam           tpw_A5_negedge          =1;
     specparam           tpw_A6_negedge          =1;
     specparam           tpw_A7_negedge          =1;
     specparam           tpw_A8_negedge          =1;
     specparam           tpw_A9_negedge          =1;
     specparam           tpw_A10_negedge          =1;
     specparam           tpw_A11_negedge          =1;
     specparam           tpw_A12_negedge          =1;
     specparam           tpw_A13_negedge          =1;
     specparam           tpw_A14_negedge          =1;
     specparam           tpw_A15_negedge          =1;
     specparam           tpw_A16_negedge          =1;
     specparam           tpw_A17_negedge          =1;
     specparam           tpw_A18_negedge          =1;
     specparam           tpw_A19_negedge          =1;
     specparam           tpw_A20_negedge          =1;

     specparam           tpw_OENeg_posedge       =1;

// tdevice values: values for internal delays

            //Program Operation                    max values
     specparam   tdevice_POB                     = 300000;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 15e9;

     //program/erase suspend timeout
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

  (WENeg => RY)     = tpd_WENeg_RY;
  (CENeg => RY)     = tpd_CENeg_RY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////
        $setup ( A0 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A1 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A2 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A3 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A4 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A5 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A6 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A7 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A8 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A9 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A10 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A11 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A12 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A13 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A14 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A15 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A16 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A17 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A18 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A19 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);
        $setup ( A20 , negedge OENeg &&& cond1, tsetup_A0_OENeg, Viol);

        $setup ( DQ0 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);

        $setup ( DQ0 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);

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

        $hold ( posedge WENeg &&& cond2, OENeg, thold_A0_CENeg, Viol);


        $hold ( posedge RESETNeg &&& (CENeg===1), CENeg , thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& (OENeg===1), OENeg , thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& (WENeg===1), WENeg , thold_CENeg_RESETNeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (posedge WENeg, tpw_WENeg_posedge);
        $width (negedge WENeg, tpw_WENeg_negedge);
        $width (posedge CENeg, tpw_CENeg_posedge);
        $width (negedge CENeg, tpw_CENeg_negedge);
        $width (negedge A0, tpw_A0_negedge);
        $width (negedge A1, tpw_A0_negedge);
        $width (negedge A2, tpw_A0_negedge);
        $width (negedge A3, tpw_A0_negedge);
        $width (negedge A4, tpw_A0_negedge);
        $width (negedge A5, tpw_A0_negedge);
        $width (negedge A6, tpw_A0_negedge);
        $width (negedge A7, tpw_A0_negedge);
        $width (negedge A8, tpw_A0_negedge);
        $width (negedge A9, tpw_A0_negedge);
        $width (negedge A10, tpw_A0_negedge);
        $width (negedge A11, tpw_A0_negedge);
        $width (negedge A12, tpw_A0_negedge);
        $width (negedge A13, tpw_A0_negedge);
        $width (negedge A14, tpw_A0_negedge);
        $width (negedge A15, tpw_A0_negedge);
        $width (negedge A16, tpw_A0_negedge);
        $width (negedge A17, tpw_A0_negedge);
        $width (negedge A18, tpw_A0_negedge);
        $width (negedge A19, tpw_A0_negedge);
        $width (negedge A20, tpw_A0_negedge);

        $width (posedge OENeg &&& cond1, tpw_OENeg_posedge);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET           =6'd0;
 parameter Z001            =6'd1;
 parameter PREL_SETBWB     =6'd2;
 parameter PREL_ULBYPASS   =6'd3;
 parameter CFI             =6'd4;
 parameter AS              =6'd5;
 parameter AS_CFI          =6'd6;
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
 parameter ESP_CFI         =6'd18;
 parameter ESP_A0SEEN      =6'd19;
 parameter ESP_AS          =6'd20;
 parameter PGMS            =6'd21;

    reg [5:0] current_state;
    reg [5:0] next_state;

    reg deq;

    integer sector_preload[0:MemSize];
    integer sector_prot[0:SecNum];

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

    reg [SecNum:0] Sec_Prot_tmp ;
    initial
    begin

//TOP OR BOTTOM arch model is used
    //assumptions:
    //1. TimingModel has format as
    //"am29lv116dt"
    //it is important that 11-th character from first one is "t" or "b"
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
        tmp_char[j] = TimingModel[(i-9)*8+j];//bottom/top character is 11
        end                                  //characters right from first ("a")
    end
    if (tmp_char == "t")
        top         = 1'b1;
    else if (tmp_char == "b")
          top         = 1'b0;

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
            //am29lv116d_prot  sector protect file
            //   //      - comment
            //   @sec    - <sec> stands for sector number
            //   (sec is incremented at every load)
            //   d       - <d> is 1 for protected sector <sec>, 0 for unprotect.
            $readmemb(prot_file_name,sector_prot);
        end

        if (UserPreload && mem_file_name != "none")
        begin
            //am29lv116d.mem, memory preload file
            //  @aaaaaa - <aaaaaa> stands for address within memory
            //  dd      - <dd> is byte to be written at Mem((aaaaaa++)
            // (aaaaaa is incremented at every load)
            $readmemh(mem_file_name,sector_preload);
        end

        for (i=0;i<=1;i=i+1)
        begin
            WBData = 0;
            WBAddr = -1;
        end

        //memory preload
        for(j=0;j<=MemSize;j=j+1)
            Mem[j] = sector_preload[j];

        for (i = 0; i<= SecNum; i = i+1)
            Sec_Prot[i] = sector_prot[i];
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
        Addr     = 0;

        SecAddr  = 0;         // 0 - SecNum
        SA       = 0;         // 0 TO SecNum

        Address  = 0;         // 0 - SecSize

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
   begin:TSTARTT1r
     #tdevice_START_T1 START_T1 = START_T1_in;
   end

   always @(negedge START_T1_in)
   begin:TSTARTT1f
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
        if (gWE_n == WENeg) $display("WARNING: Glitch on WE#");
    end
    always @(CENeg)
    begin: PulseWatch2
        if (gCE_n == CENeg)
            $display("WARNING: Glitch on CE#");
    end
    always @(OENeg)
    begin: PulseWatch3
        if (gOE_n == OENeg)
            $display("WARNING: Glitch on OE#");
    end

    //events timings
    always @(gCE_n)
    begin
        if (RESETNeg != 1'b0)
            CENeg_event = $time;
    end

    always @(gOE_n)
    begin
        if (RESETNeg != 1'b0)
            OENeg_event = $time;
    end
   event AddrE;
   always @(A)// or reseted)
    begin
        if (RESETNeg != 1'b0)
            ADDR_event = $time;
    end

///////////////////////////////////////////
//open tristate buffers control
    always @(DOut_zd[7:0])
    begin : open_buff
        if (DOut_zd[0] !== 1'bz)
        begin
            //open buffers
            CEDQ_open_t = CENeg_event  + CEDQ_1z;
            OEDQ_open_t = OENeg_event  + OEDQ_1z;
            SWITCH = 1;
            FROMCE = ((CEDQ_open_t >= OEDQ_open_t) &&
                       (CEDQ_open_t >= $time));
            FROMOE  = ((OEDQ_open_t >= CEDQ_open_t) &&
                       (OEDQ_open_t >= $time));

            //delays
            ADDRDQ_t = ADDR_event + ADDRDQ_01;
            if (ADDRDQ_t>= $time &&
                ((ADDRDQ_t >= OEDQ_open_t && FROMOE) ||
                 (ADDRDQ_t >= CEDQ_open_t && FROMCE)))
            begin
                TempData = DOut_zd[7:0];
                DOut_z[7:0] = 8'bx;
                DOut_z[7:0] <= #(ADDRDQ_t - $time ) TempData[7:0];
            end
            else
                DOut_z[7:0] = DOut_zd[7:0];
        end
        else
        begin
            DOut_z[7:0] = DOut_zd[7:0];

            FROMCE = 0;
            FROMOE = 0;
            SWITCH = 0;
        end
    end

    reg  BuffInOE, BuffInCE, BuffInADDR;
    reg  BuffCtrlOE, BuffCtrlCE;
    wire BuffOutOE, BuffOutCE, BuffOutADDR;

    BUFFERIF    BUFOE   (BuffOutOE, BuffInOE, BuffCtrlOE);
    BUFFERIF    BUFCE   (BuffOutCE, BuffInCE, BuffCtrlCE);
    BUFFER      BUFADDR (BuffOutADDR, BuffInADDR);

    initial
    begin
        BuffInOE   = 1'b1;
        BuffCtrlOE = 1'b0;

        BuffInCE   = 1'b1;
        BuffCtrlCE = 1'b0;

        BuffInADDR  = 1'b1;
    end
    time tmp_oe;
    time tmp_ce;

    always @(BuffOutOE)
    begin
        if (BuffOutOE === 1'bZ)
        begin
            tmp_oe = $time;
            BuffCtrlOE = 1'b1;//open buffer
        end
        else if (BuffOutOE == 1'b1)
            OEDQ_1z = $time - tmp_oe;
    end

    always @(BuffOutCE)
    begin
        if (BuffOutCE === 1'bZ)
        begin
            tmp_ce = $time;
            BuffCtrlCE = 1'b1;//open buffer
        end
        else if (BuffOutCE == 1'b1)
            CEDQ_1z = $time - tmp_ce;
    end

    always @(posedge BuffOutADDR)
    begin
        ADDRDQ_01 = $time;
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

   always @(WENeg_ipd)// or reseted)
    begin
        if (reseted)
        begin
            if (~WENeg_ipd && ~CENeg_ipd && OENeg_ipd )
            begin
                A_tmp  =  A[10:0];
                RestoreSectAddr(A, SA_tmp, A_tmp1);
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
                RestoreSectAddr(A, SA_tmp, A_tmp1);
            end
            else if (CENeg_ipd && write)
            begin
            end
        end
    end

   always @(negedge OENeg_ipd )//or reseted)
    begin
        if (reseted)
        begin
            if (~OENeg_ipd && WENeg_ipd && ~CENeg_ipd)
            begin
                A_tmp  =  A[10:0];
                RestoreSectAddr(A, SA_tmp, A_tmp1);
            end
            if (~OENeg_ipd)
            begin
                SecAddr = SA_tmp;
                Address = A_tmp1;
                Addr   = A_tmp;
            end
        end
    end

   always @(A)// or reseted)
    begin
        if (reseted)
        begin
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  A[10:0];
                RestoreSectAddr(A, SA_tmp, A_tmp1);
                SecAddr = SA_tmp;
                Address = A_tmp1;
                Addr   = A_tmp;
            end
       end
    end

    always @(posedge write)
    begin
        SecAddr = SA_tmp;
        Address = A_tmp1;
        Addr   = A_tmp;
    end

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
//    /////////////////////////////////////////////////////////////////////////

 integer cnt_write = 0;
 time duration_write ;
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
                if ( ~Sec_Prot[SA] &&
                   (~Ers_queue[SA] || ~ESP_ACT ))
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
                        if ((Ers_queue[i]==1'b1) && (Sec_Prot[i]!=1'b1))
                        begin
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

//    /////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    /////////////////////////////////////////////////////////////////////////
        reg PATTERN_1  = 1'b0;
        reg PATTERN_2  = 1'b0;
        reg A_PAT_1  = 1'b0;

        //DATA  High Byte
        integer DataHi   ;
        //DATA Low Byte
        integer DataLo   ;

    always @(negedge write)
    begin
        if (~write)
        begin
            DataLo = DIn[7:0];
            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
            A_PAT_1   = ((Addr==16'h555) && ~ULBYPASS) || ULBYPASS;
        end
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
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = PREL_SETBWB;
                    else
                        next_state = RESET;
                end
            end

            PREL_SETBWB :
            begin
                if (~write)
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
            end

            PREL_ULBYPASS :
            begin
                if (~write)
                begin
                    if (DataLo==16'h90)
                        next_state = AS;
                    else if  (DataLo==16'hA0)
                        next_state = A0SEEN;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            CFI :
            begin
                if (~write)
                begin
                    if (DataLo==16'hF0)
                        next_state = RESET;
                    else
                        next_state =  CFI;
                end
            end

            AS :
            begin
                if (~write)
                begin
                  if (DataLo==16'hF0)
                      next_state = RESET;
                  else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
                  else if (Addr == 16'h55 && DataLo == 16'h98)
                        next_state = AS_CFI;
                  else
                      next_state = AS;
                end
            end

            A0SEEN :
            begin
                if (~write)
                begin
                    next_state = PGMS;
                end
            end

            C8 :
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else
                        next_state = RESET;
                 end
            end

            C8_Z001 :
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = C8_PREL;
                    else
                        next_state = RESET;
                end
            end

            C8_PREL :
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==16'h10))
                        next_state = ERS;
                    else if (DataLo==16'h30)
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
            end

            ERS :
            begin
            end

            SERS :
            begin
                if (~write)
                begin
                    if (~CTMOUT)
                    begin
                        if (DataLo == 16'hB0)
                            next_state = ESPS; // ESP according to datasheet
                        else if (DataLo==16'h30)
                            next_state = SERS;
                        else
                            next_state = RESET;
                    end
                end
             end

            SERS_EXEC :
            begin
            end

            ESP :
            begin
                if (~write)
                begin
                    if (ULBYPASS)
                    begin
                        if (DataLo == 16'h20)
                        begin
                        end
                        else if (A_PAT_1 && (DataLo == 16'hA0))
                            next_state = ESP_A0SEEN;
                        else if (DataLo==16'h90)
                            next_state = ESP_AS;
                    end
                    else if (DataLo == 16'h30 )
                        next_state = SERS_EXEC;
                    else
                    begin
                        if ((Addr == 16'h55) && (DataLo == 16'h98))
                            next_state = ESP_CFI;
                        else if (PATTERN_1)
                            next_state = ESP_Z001;
                    end
                end
            end

              ESP_Z001 :
              begin
                if (~write)
                    if (PATTERN_2)
                        next_state = ESP_PREL;
                    else
                        next_state = ESP;
               end

              ESP_PREL :
              begin       
                if (~write)  
                    if (A_PAT_1 && (DataLo == 16'h20))  
                        next_state = ESP; //set ULBYPASS
                    else if (A_PAT_1 && DataLo == 16'hA0)
                        next_state = ESP_A0SEEN;
                    else if (A_PAT_1 && DataLo == 16'h90)
                        next_state = ESP_AS;
                    else
                        next_state = ESP;
              end

              ESP_CFI :
              begin
                if (~write)
                begin
                    if ((Addr == 16'h55) && (DataLo == 16'h98))
                    begin
                    end
                    else if (DataLo == 16'hF0)
                        next_state = ESP;
                    else if (DataLo == 16'h30)
                        next_state = SERS_EXEC;
                    else
                        next_state = ESP;
                end
              end

            ESP_A0SEEN :
            begin
                if (~write)
                begin
                    next_state = PGMS;
                end
            end

              ESP_AS :
              begin
                if (~write)
                begin
                    if (DataLo == 16'hF0)
                        // resret ULBYPASS
                        next_state = ESP;
                    else if (ULBYPASS)
                        next_state = ESP;
                    else if ((Addr==16'h55) && (DataLo==16'h98))
                        next_state = AS_CFI;
                end
              end

            AS_CFI :
            begin
                if (~write)
                    if (DataLo==16'hf0)
                        if (ESP_ACT == 1)
                            next_state = ESP_AS;
                        else
                            next_state = AS;
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
                begin
                    if (DataLo==16'hB0 )
                        next_state = ESPS;
                end
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
                begin
                    MemRead(DOut_zd);
                end
            end

            CFI :
            begin
                if (oe)
                begin
                    ReadCfi(DOut_zd);
                 end
            end

            AS :
            begin
                if (oe)
                    if (~ULBYPASS)
                    begin
                        AsRead(DOut_zd);
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
                    if (Ers_queue[SecAddr]==1'b1)
                        Status[2] = ~Status[2]; //toggle
                    DOut_zd[7:0] = Status;
                end
            end

            SERS_EXEC:
            begin
                if (oe)
                begin
                    ///////////////////////////////////////////////////
                    //read status erase
                    ///////////////////////////////////////////////////
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    if (Ers_queue[SecAddr]==1'b1)
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
                    if  ( Ers_queue[SecAddr]!=1'b1)
                        MemRead(DOut_zd[7:0]);
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
                    ReadCfi(DOut_zd);
            end

            ESP_AS :
            begin
                if (oe)
                begin
                    if (~ULBYPASS)
                        AsRead(DOut_zd);
                end
            end

            AS_CFI :
            begin
                if (oe)
                    ReadCfi(DOut_zd);
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
                    //Status[1] = 1'b0;
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
        case (current_state)
            RESET :
            begin
                ESP_ACT   = 1'b0;
                CTMOUT_in = 1'b0;

                if (~write)
                begin
                end
                //ready signal active
                RY_zd = 1'b1;
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                if (~write)
                begin  
                    if (A_PAT_1 && (DataLo==16'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==16'h90))
                    begin
                        ULBYPASS = 1'b0;
                    end
                end
            end

            PREL_ULBYPASS :
            begin
                if (~write)
                begin
                    if (DataLo==16'h20)
                        ULBYPASS = 1'b1;
                    else if (DataLo==16'h90)
                    begin
                    end
                end

                //ready signal active
                RY_zd = 1'b1;
            end

            CFI :
            begin
                if (~write)
                    if ((Addr==16'h55) && (DataLo==16'h98))
                    begin
                    end
                    else if (DataLo==16'hF0)
                    begin
                    end
            end

            AS :
            begin
                if (~write)
                    if (DataLo==16'hF0)
                    begin
                        ULBYPASS  = 1'b0;
                    end
            end

            A0SEEN :
            begin
                if (~write)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;

                    WBData = DataLo;
                    WBAddr = Address;
                    SA = SecAddr;

                    temp = DataLo;
                    Status[7] = ~temp[7];
                end
            end

            C8 :
            begin
                if (~write)
                    begin
                    end
            end

            C8_Z001 :
            begin
            end

            C8_PREL :
            begin
                if (~write)
                begin
                      if (A_PAT_1 && (DataLo==16'h10))
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
            end

            ERS :
            begin
            end

            SERS :
            begin
                if (~write)
                begin
                    if (~CTMOUT)
                    begin
                        if (DataLo == 16'hB0)
                        begin
                            //need to start erase process prior to suspend
                            ESTART = 1'b1;
                            ESTART <= #1 1'b0;
                            ERES   = 1'b0;
                            //suspend timeout (should be 0 according to datasheet)
                            START_T1_in = 1'b1;///
                        end
                        else if (DataLo==16'h30)
                        begin
                            disable TCTMOUTr;
                            CTMOUT_in = 1'b0;
                            CTMOUT_in <= #1 1'b1;
                            Ers_queue[SecAddr] = 1'b1;
                        end
                    end
                end
                //ready signal active
                RY_zd = 1'b1;
            end

            SERS_EXEC :
            begin
                if (~write)
                    if (~EDONE && (EERR!=1'b1))
                        if (DataLo==16'hB0)
                            START_T1_in = 1'b1;
                RY_zd = 1'b0;
            end

            ESP :
            begin
                if (~write)
                begin
                        if (DataLo == 16'h30 )
                        begin
                            //resume erase
                            ERES = 1'b1;
                            ERES <= #1 1'b0;
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
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo == 16'h20))
                        ULBYPASS = 1'b1;
                end
            end

            ESP_CFI :
            begin
                if (~write)
                begin  
                    if (DataLo == 16'hF0)
                        ESP_ACT = 1'b1;
                    else if (DataLo == 16'h30)
                    begin
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                    end
                    else
                        ESP_ACT = 1'b1;
                end
            end

            ESP_A0SEEN :
            begin
                if (~write)
                begin
                    ESP_ACT = 1'b1;
                        //PSTART = '1', '0' AFTER 1 ns;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;

                    WBData = DataLo;
                    WBAddr = Address;
                    SA = SecAddr;

                    temp = DataLo;
                    Status[7] = ~temp[7];
                end
            end

            ESP_AS :
            begin
                if (~write)
                    if (DataLo == 16'hF0)
                        // resret ULBYPASS
                        ULBYPASS = 1'b0;
            end

            AS_CFI :
            begin
                if (~write)
                    if (DataLo == 16'hF0)
                        ULBYPASS = 1'b0;
            end

            PGMS :
            begin
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
            if (current_state==ESPS) RY_zd = 1'b0;
            if (current_state==ESP) RY_zd = 1'b1;
            if (current_state==SERS_EXEC) RY_zd = 1'b0;
            if (current_state==PGMS) RY_zd = 1'b0;
    end

//******************************
    always @(EERR or EDONE or current_state)
    begin : ERS2
    integer i;
    integer j;

    if (current_state==ERS)
    begin
           RY_zd = 1'b0;
        if (EERR!=1'b1)
        begin
            for (i=0;i<=SecNum;i=i+1)
            begin
                if (Sec_Prot[i]!=1'b1)
                    for (j=0;j<=SecSize(i);j=j+1)
                        Mem[sa(i)+j] = -1;
            end
            if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if (Sec_Prot[i]!=1'b1)
                        for (j=0;j<=SecSize(i);j=j+1)
                            Mem[sa(i)+j] = MaxData;
                end
           // busy signal active

        end
    end
    end

always @(posedge EDONE or negedge EERR)
begin : ResetBank
    if (current_state==ERS || current_state == SERS_EXEC)
    begin
        ESP_ACT = 1'b0;
    end
end

    always @(CTMOUT or current_state)
    begin : SERS2
        if (current_state==SERS)
         begin
            RY_zd = 1'b1;
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                //ESTART = '1', '0' AFTER 1 ns;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                //ready signal active
            end
         end
    end
    always @(START_T1 or current_state)
    begin : ESPS2
        if (current_state==ESPS)
        begin
            RY_zd = 1'b0;
            CTMOUT_in = 1'b0;
            ESUSP = 1'b1;
            if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
                ESUSP = 1'b0;
                 //busy signal active
            end
        end
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
        if (current_state==SERS_EXEC)
        begin
            RY_zd = 1'b0;
            if (EERR!=1'b1)
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                   if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                        for (j=0;j<=SecSize(i);j=j+1)
                            Mem[sa(i)+j] = -1;
                end

                if (EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                            for (j=0;j<=SecSize(i);j=j+1)
                                 Mem[sa(i)+j] = MaxData;
                    end
                        //busy signal active

            end
        end
    end

    always @(current_state or posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    //integer i,j;
    if (current_state==PGMS)
    begin
           //busy signal active
            RY_zd = 1'b0;
            if (PERR!=1'b1)
            begin
                new_int= WBData;
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
                    WBData= new_int;
                end
                else
                    WBData= -1;

                Mem[sa(SA)+WBAddr] = -1;

                if (PDONE && ~PSTART)
                    begin
                        Mem[sa(SA)+WBAddr] = WBData;
                        WBData= -1;
                    end
                 
            end
        end
    end



    always @(gOE_n or gCE_n or RESETNeg or RST)
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
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
            CFI_array[16'h2C] = 16'h04;
            CFI_array[16'h2D] = 16'h00;
            CFI_array[16'h2E] = 16'h00;
            CFI_array[16'h2F] = 16'h40;
            CFI_array[16'h30] = 16'h00;
            CFI_array[16'h31] = 16'h01;
            CFI_array[16'h32] = 16'h00;
            CFI_array[16'h33] = 16'h20;
            CFI_array[16'h34] = 16'h00;
            CFI_array[16'h35] = 16'h00;
            CFI_array[16'h36] = 16'h00;
            CFI_array[16'h37] = 16'h80;
            CFI_array[16'h38] = 16'h00;
            CFI_array[16'h39] = 16'h1E;
            CFI_array[16'h3A] = 16'h00;
            CFI_array[16'h3B] = 16'h00;
            CFI_array[16'h3C] = 16'h01;
            //primary vendor-specific extended query
            CFI_array[16'h40] = 16'h50;
            CFI_array[16'h41] = 16'h52;
            CFI_array[16'h42] = 16'h49;
            CFI_array[16'h43] = 16'h31;
            CFI_array[16'h44] = 16'h30;
            CFI_array[16'h45] = 16'h00;
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h01;
            CFI_array[16'h49] = 16'h04;
            CFI_array[16'h4A] = 16'h00;
            CFI_array[16'h4B] = 16'h00;
            CFI_array[16'h4C] = 16'h00;
    end

////////////////
// functions
////////////
//////////////////
//SECTOR FUNCTIONS
//////////////////
function integer SecSize;
input integer i;
begin
    if ((top  && i <= 30) ||
        (!top && i >= 4))
        SecSize = SecSize_l;
    else if ((top  && i == 31) ||
             (!top && i == 3))
        SecSize = SecSize_s_32;
    else if ((top  && (i == 32 || i == 33)) ||
             (!top && (i == 1  || i == 2)))
        SecSize = SecSize_s_8;
    else
        SecSize = SecSize_s_16;
end
endfunction


function integer sa;
input integer sect;
begin
    sa = 0;
    for (j=0;j<=sect -1 ;j=j+1)
       sa = sa + SecSize(j) + 1;
end
endfunction

function integer ea;
input integer sect;
begin
    ea = 0;
    for (j=0;j<=sect -1 ;j=j+1)
       ea = ea + SecSize(j) + 1;
    ea = ea + SecSize(sect);
end
endfunction

//RestoreSectAdde
task RestoreSectAddr;
input reg [HiAddrBit:0] A;
inout integer SecAddr;
inout integer Addr;
integer SA_tmp;
reg [15 : 0] A_tmp;
integer boot_sec_tmp;
integer incr;
begin
    A_tmp = 0;
    SA_tmp = A[HiAddrBit:16];
    if ((!top && SA_tmp != 0) ||
        (top && SA_tmp != 31))
    begin
        SecAddr = SA_tmp;
        A_tmp = A[15:0];
        if (!top)
            SecAddr = SecAddr + BootSecNum;
    end
    else
    begin
        boot_sec_tmp = A[15:13];
        if ((top  && boot_sec_tmp < 4) ||
            (!top && boot_sec_tmp < 2))
                incr = 0;
        else if ((top  && boot_sec_tmp < 5) ||
                 (!top && boot_sec_tmp < 3))
                incr = 1;
        else if ((top  && boot_sec_tmp < 6) ||
                 (!top && boot_sec_tmp < 4))
                incr = 2;
        else
                incr = 3;

        SecAddr = SA_tmp + incr;
        if (SecSize(SecAddr) == SecSize_s_32)
            A_tmp = A[14:0];
        else if (SecSize(SecAddr) == SecSize_s_16)
            A_tmp = A[13:0];
        else if (SecSize(SecAddr) == SecSize_s_8)
            A_tmp = A[12:0];

    end
       Addr = A_tmp;

end
endtask

/////////////////////////////////////
//Mem, SecSI, CFI, AS read functions
////////////////////////////////////
task MemRead;
inout [7:0] DOut_zd;
begin
    if (Mem[sa(SecAddr)+Address]==-1)
            DOut_zd[7:0] = 8'bx;
    else
            DOut_zd[7:0] = Mem[sa(SecAddr)+Address];
end
endtask

task AsRead;
inout [7:0] DOut_zd;
//input Address;
//input SecAddr;
begin
    if (Address == 0)
        DOut_zd[7:0] = 1;
    else if (Address == 1)
        if (top)
            DOut_zd[7:0] = 8'hC7;
        else
            DOut_zd[7:0] = 8'h4C;
    else if (Address == 2)
        begin
            DOut_zd[7:1] = 7'b0;
            DOut_zd[0] = Sec_Prot[SecAddr];
        end
    else
    begin
        DOut_zd[7:0] = 8'bz;
        $display ("NOTE: Invalid AS address");
    end

end
endtask
task ReadCfi;
inout [7:0] DOut_zd;
//integer Addr;
begin
    DOut_zd[7:0] = 16'b0;
    if ((Addr>=MinCfiAddr)&&(Addr<=MaxCfiAddr))
     begin
         DOut_zd[7:0] = CFI_array[Addr];
     end
     else
     begin
        DOut_zd[7:0] = 8'bz;
        $display ("NOTE: Invalid CFI query address");
    end
end
endtask

endmodule

module BUFFERIF (OUT,IN, CTRL);
    input IN, CTRL;
    output OUT;
    bufif1   ( OUT, IN, CTRL);
endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule

