//////////////////////////////////////////////////////////////////////////////
//  File name : s29jl032h3.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version: | author:      | % date:     | changes made:
//    V1.0    M.Radmanovic    04 Oct 20    Initial release
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           s29jl032h3
//
//  Description:    Flash Memory s29jl032h3 Flash device
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
 // Top level module
 ////////////////////////////////////////////////

module s29jl032h3
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
    BYTENeg,
    RY      );

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
    input  BYTENeg ;
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
    wire  RESETNeg_ipd ;
    wire  WPNeg_ipd    ;
    wire  BYTENeg_ipd  ;

//  internal delays
    reg HANG_out    ; // Program/Erase Timing Limit
    reg HANG_in     ;
    reg START_T1   ; // Start TimeOut
    reg START_T1_in;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

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

    reg RY_zd = 1;

    reg POW_in     ;
    reg POW_out    ;
    reg POB_in     ;
    reg POB_out    ;
    reg POU_in     ;
    reg POU_out    ;

    reg SEO_in      ;
    reg SEO_out     ;

    parameter UserPreload     = 1'b0;
    parameter flash_file_name = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name  = "none";
    parameter TimingModel     = "DefaultTimingModel";

    parameter DelayValues = "FROM_PLI";
    parameter PartID        = "s29jl032h3";
    parameter MaxData       = 255;
    parameter SecSize       = 16'hFFFF;
    parameter SecNum        = 63; //
    parameter SubSecNum     = 7;
    parameter HiAddrBit     = 20;
    parameter SecSiSize = 255;

    // powerup
    reg PoweredUp;

     //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg OTP_ACT  ; ////SecSi access
    reg AS_ACT  ; ////AUTOSELECT access
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
    reg [SecNum:0] Ers_Queue; // = SecNum'b0;
    reg [SubSecNum:0] Ers_Sub_Queue;

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SubSect = 0;         // 0 - SubSecNum
    integer SA      = 0;         // 0 TO SecNum
    integer SSA     = 0;         // 0 TO SubSecNum
    integer BA     = 0;         // 0 TO SubSecNum
    //Address within sector
    integer Address = 0;         // 0 - SecSize
    integer SubAddr = 0;
    integer SecSiAddr = 0;         // 0 - SecNum

    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    //A19:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    reg RST ;
    reg reseted ;
    reg BYTE ;

   integer Mem[0:(SecNum+1)*(SecSize+1)-1];
    //Sector Protection Status
    reg [SecNum:0] Sec_Prot=128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    //Sector Protection for sub sectors
    reg [SubSecNum:0] SubSec_Prot =8'hFF;

    integer SecSi[0:SecSiSize];
    integer CFI_array[16:91];

    //SecSi ProtectionStatus
    reg FactoryProt = 0;

    reg Viol = 1'b0;

    // Address of variable size sector
    integer VarSect = -1;
    reg     vs;

    integer     BankNum = 1;

    // Addresses of the Protected Sector
    integer ProtSecNum_1 = 0;
    integer ProtSecNum_2 = 1;

     integer WBData[0:1];
    integer WBAddr[0:1];

    reg [1:0] BankAddress;

    event MergeE;

    integer cnt = 0;

    reg oe = 1'b0;
    event oe_event;

    event initOK;
    reg[7:0] temp;

    //Status reg.
    reg[7:0] Status = 16'b0;

    // iterator for FOR loop
    integer i,j,k;

   //TPD_XX_DATA
   time OEDQ_t;
   time CEDQ_t;
   time BYTEDQ_t;
   time ADDRDQ_t;
   time OENeg_posEvent;
   time CENeg_posEvent;
   time OENeg_event;
   time CENeg_event;
   time BYTENeg_event;
   time ADDR_event;
   reg FROMOE;
   reg FROMCE;
   reg FROMBYTE;
   reg FROMADDR;
   time   OEDQ_01;
   time   CEDQ_01;
   time   ADDRDQ_01;

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
 buf   (BYTENeg_ipd  , BYTENeg  );
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

 nmos   (RY  ,   1'b0      , ~RY_zd);

   wire deg;

   wire Embd;

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
    specparam           tpd_BYTENeg_DQ0         =1;

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
    specparam           thold_BYTENeg_CENeg     =1; //telf, tehfl

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
     specparam   tdevice_POB                     = 5000; //5 us;
     specparam   tdevice_POW                     = 7000; //7 us;
     specparam   tdevice_POU                     = 4000; //4 us;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 400000000; //400 ms;
            //Timing Limit Exceeded
     specparam   tdevice_HANG                    = 200000000; //2000 ms;
            //program/erase suspend timeout
     specparam   tdevice_START_T1               = 20000; //20 us;
            //sector erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 80000; //80 us;
            //device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 20000; //20 us; //tReady

     // If tpd values are fetched from specify block, these parameters
     // must change along with SDF values, SDF values change will NOT
     // imlicitly apply here !
     // If you want tpd values to be fetched by the model itself, please
     // use the PLI routine approach but be shure to set parameter
     // DelayValues to "FROM_PLI" as default

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
//for DQ signals
    if (FROMCE)( CENeg => DQ0 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ1 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ2 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ3 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ4 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ5 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ6 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ7 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ8 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ9 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ10 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ11 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ12 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ13 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ14 ) = tpd_CENeg_DQ0;
    if (FROMCE)( CENeg => DQ15 ) = tpd_CENeg_DQ0;

    if (FROMOE)( OENeg => DQ0 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ1 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ2 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ3 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ4 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ5 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ6 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ7 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ8 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ9 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ10 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ11 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ12 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ13 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ14 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ15 ) = tpd_OENeg_DQ0;

    if (FROMADDR)( A0 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A0 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A1 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A2 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A3 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A4 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A5 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A6 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A7 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A8 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A9 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A10 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A11 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A12 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A13 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A14 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A15 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A16 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A17 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A18 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A19 => DQ15 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ0 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ1 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ2 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ3 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ4 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ5 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ6 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ7 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ8 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ9 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ10 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ11 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ12 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ13 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ14 ) = tpd_A0_DQ0;
    if (FROMADDR)( A20 => DQ15 ) = tpd_A0_DQ0;

    if (~BYTE && FROMADDR)( DQ15 => DQ0 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ1 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ2 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ3 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ4 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ5 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ6 ) = tpd_A0_DQ0;
    if (~BYTE && FROMADDR)( DQ15 => DQ7 ) = tpd_A0_DQ0;

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

    if (~RESETNeg)( RESETNeg => DQ0 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ1 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ2 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ3 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ4 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ5 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ6 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ7 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ8 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) ( RESETNeg => DQ9 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) ( RESETNeg => DQ10 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ11 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ12 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ13 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg) ( RESETNeg => DQ14 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ15 ) = tpd_RESETNeg_DQ0;

//for RY signal
  (WENeg => RY)     = tpd_WENeg_RY;
  (CENeg => RY)     = tpd_CENeg_RY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

  $setup ( A0 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A1 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A2 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A3 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A4 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A5 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A6 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A7 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A8 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A9 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A10 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A11 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A12 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A13 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A14 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A15 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A16 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A17 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A18 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A19 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
  $setup ( A20 , negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);

  $setup ( A0 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A1 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A2 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A3 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A4 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A5 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A6 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A7 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A8 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A9 , negedge WENeg &&& CheckEnable_A0_WE,  tsetup_A0_CENeg, Viol);
  $setup ( A10 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A11 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A12 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A13 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A14 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A15 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A16 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A17 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A18 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A19 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
  $setup ( A20 , negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);

  $setup ( DQ0 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ1 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ2 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ3 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ4 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ5 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ6 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ7 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ8 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ9 , posedge CENeg &&& CheckEnable_DQ0_CE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ10 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ11 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ12 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ13 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ14 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ15 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ0 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ1 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ2 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ3 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ4 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ5 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ6 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ7 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ8 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ9 , posedge WENeg &&& CheckEnable_DQ0_WE,  tsetup_DQ0_CENeg, Viol);
  $setup ( DQ10 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ11 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ12 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ13 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ14 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_DQ0_CENeg, Viol);
  $setup ( DQ15 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_DQ0_CENeg, Viol);

  $setup ( CENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);
  $setup ( BYTENeg , negedge CENeg , tsetup_A0_CENeg, Viol);

  $setup ( BYTENeg , negedge WENeg , tsetup_A0_CENeg, Viol);
  $setup ( OENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);

  $hold ( posedge RESETNeg &&& (CENeg===1), CENeg , thold_CENeg_RESETNeg, Viol);
  $hold ( posedge RESETNeg &&& (OENeg===1), OENeg , thold_CENeg_RESETNeg, Viol);
  $hold ( posedge RESETNeg &&& (WENeg===1), WENeg , thold_CENeg_RESETNeg, Viol);
  $hold ( posedge OENeg, WENeg , thold_WENeg_OENeg, Viol);

  $hold ( posedge WENeg&&&Embd==0,OENeg , thold_OENeg_WENeg, Viol);
  $hold ( posedge WENeg&&&Embd==1,OENeg  , thold_OENeg_WENeg, Viol);

  $hold ( posedge WENeg, CENeg , thold_WENeg_OENeg, Viol);
  $hold ( negedge CENeg, BYTENeg, thold_BYTENeg_CENeg, Viol);
  $hold ( negedge WENeg, BYTENeg, thold_A0_CENeg, Viol);

  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A0 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A1 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A2 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A3 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A4 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A5 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A6 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A7 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A8 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A9 ,  thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A10 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A11 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A12 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A13 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A14 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A15 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A16 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A17 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A18 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A19 , thold_A0_CENeg, Viol);
  $hold (  negedge CENeg &&& CheckEnable_A0_CE, A20 , thold_A0_CENeg, Viol);

  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A0 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A1 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A2 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A3 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A4 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A5 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A6 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A7 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A8 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A9 ,  thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A10 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A11 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A12 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A13 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A14 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A15 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A16 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A17 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A18 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A19 , thold_A0_CENeg, Viol);
  $hold ( negedge WENeg &&& CheckEnable_A0_WE, A20 , thold_A0_CENeg, Viol);

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
  $width (posedge A0, tpw_A0_negedge);//ok

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

    // FSM states
    parameter RESET                =6'd0;
    parameter Z001                 =6'd1;
    parameter PREL_SETBWB          =6'd2;
    parameter PREL_ULBYPASS        =6'd3;
    parameter PREL_ULBYPASS_RESET  =6'd4;
    parameter CFI                  =6'd5;
    parameter AS                   =6'd6;
    parameter A0SEEN               =6'd7;
    parameter OTP                  =6'd8;
    parameter OTP_Z001             =6'd9;
    parameter OTP_PREL             =6'd10;
    parameter OTP_EXIT             =6'd11;
    parameter OTP_A0SEEN           =6'd12;
    parameter C8                   =6'd13;
    parameter C8_Z001              =6'd14;
    parameter C8_PREL              =6'd15;
    parameter ERS                  =6'd16;
    parameter SERS                 =6'd17;
    parameter ESPS                 =6'd18;
    parameter SERS_EXEC            =6'd19;
    parameter ESP                  =6'd20;
    parameter ESP_SETBWB           =6'd21;
    parameter ESP_Z001             =6'd22;
    parameter ESP_A0SEEN           =6'd23;
    parameter PGMS                 =6'd24;
    parameter ESP_ULBYPASS         =6'd25;
    parameter ESP_ULBYPASS_RESET   =6'd26;

   reg[17*8:1] ShiftTM;
   reg[16*8:1] Top_Bottom_Switch;

    reg [5:0] current_state;
    reg [5:0] next_state;

    reg [3:0] BankProg ;
    reg [3:0] BankAutosel;
    reg [3:0] BankBypassLock;
    reg [3:0] BankErase;
    reg [3:0] BankEraseExec;

    reg deq;
    reg Embeded;

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

   always @(PDONE,EDONE)
    begin
        if ((PDONE == 0)|| (EDONE == 0))
            Embeded=1'b1;
        else
            Embeded=1'b0;
    end

    assign Embd=Embeded;

  initial
  begin
      ShiftTM = TimingModel;
      for(Top_Bottom_Switch = ShiftTM;
      !(  (Top_Bottom_Switch =="S29JL032H55TAI31")
        ||(Top_Bottom_Switch =="S29JL032H55TFI31")
        ||(Top_Bottom_Switch =="S29JL032H55TAI32")
        ||(Top_Bottom_Switch =="S29JL032H55TFI32")
        ||(Top_Bottom_Switch =="S29JL032H60TAI31")
        ||(Top_Bottom_Switch =="S29JL032H60TFI31")
        ||(Top_Bottom_Switch =="S29JL032H60TAI32")
        ||(Top_Bottom_Switch =="S29JL032H60TFI32")
        ||(Top_Bottom_Switch =="S29JL032H70TAI31")
        ||(Top_Bottom_Switch =="S29JL032H70TFI31")
        ||(Top_Bottom_Switch =="S29JL032H70TAI32")
        ||(Top_Bottom_Switch =="S29JL032H70TFI32")
        ||(Top_Bottom_Switch =="S29JL032H90TAI31")
        ||(Top_Bottom_Switch =="S29JL032H90TFI31")
        ||(Top_Bottom_Switch =="S29JL032H90TAI32")
        ||(Top_Bottom_Switch =="S29JL032H90TFI32"));

     Top_Bottom_Switch = ShiftTM)
     begin

      ShiftTM = ( ShiftTM >> 8 );
  end

   if (   (Top_Bottom_Switch =="S29JL032H55TAI31")
        ||(Top_Bottom_Switch =="S29JL032H55TFI31")
        ||(Top_Bottom_Switch =="S29JL032H60TAI31")
        ||(Top_Bottom_Switch =="S29JL032H60TFI31")
        ||(Top_Bottom_Switch =="S29JL032H70TAI31")
        ||(Top_Bottom_Switch =="S29JL032H70TFI31")
        ||(Top_Bottom_Switch =="S29JL032H90TAI31")
        ||(Top_Bottom_Switch =="S29JL032H90TFI31"))
        begin
            VarSect       = SecNum;
            vs            = 1'b1;
            ProtSecNum_1   = 7;
            ProtSecNum_2   = 6;
        end
    else
            begin
             VarSect = 0;
             vs      = 1'b0;
             ProtSecNum_1 = 0;
             ProtSecNum_2 = 1;

            end

        -> initOK;
 end

  // initialize memory and load preload files if any
    initial
    begin : NBlck
    integer i,j;
    integer tmp1,tmp2,tmp3;
    integer secure_silicon[0:SecSiSize];
    reg     sector_prot_tmp[0:SecNum+2*SubSecNum];

        for (i=0;i<=((SecNum+1)*(SecSize+1)-1);i=i+1)
        begin
            Mem[i]=MaxData;
        end

       for (i=0;i<=SecSiSize;i=i+1)
       begin
          secure_silicon[i]=MaxData;
       end

        for (i=0;i<=SecNum;i=i+1)
        begin
           Ers_Queue[i] = 0;
           Sec_Prot[i]=0;
        end
        for (i=0;i<=7;i=i+1)
        begin
           Ers_Sub_Queue[i] = 0;
           SubSec_Prot[i] = 0;
        end

        //- Sector protection preload
        //s29jl032h_prot.mem sector protect file
        // // - comment
        // @aaa - <aaa> stands for sector address
        // (aaaa is incremented at every load)
        // b - <b> is 1 for protected sector <aaa>, 0 for unprotect.
        // If <aaa> > SecNum SecSi is protected/unprotected
        if (UserPreload && !(prot_file_name == "none"))
        begin
           $readmemb(prot_file_name,sector_prot_tmp);
        end

        // - Secsi  preload
        // s29jl032h_secsi.mem secsi file
        // // - comment
        // @aaa - <aaa> stands for sector address
        // dd - <dd> is byte to be written at SecSi(aa++)
        //   (aa is incremented at every load)
        if (UserPreload && !(secsi_file_name == "none"))
        begin
           $readmemh(secsi_file_name,secure_silicon);
        end

        // - Memory  preload
        // s29jl032h.mem memory  file
        // // - comment
        // @aaa - <aaa> stands for sector address
        // dd - <dd> is byte to be written at SecSi(aa++)
        //   (aa is incremented at every load)
        if (UserPreload && !(flash_file_name == "none"))
        begin
           $readmemh(flash_file_name,Mem);
        end

         for (i=0;i<=SecSiSize;i=i+1)
        begin
           SecSi[i] = secure_silicon[i];
       end

        Sec_Prot[0]  = sector_prot_tmp[0];
                 Sec_Prot[1]  = sector_prot_tmp[1];
                 Sec_Prot[2]  = sector_prot_tmp[1];
                 Sec_Prot[3]  = sector_prot_tmp[1];
                 for (i=4;i<=59;i=i+1)
                 Sec_Prot[i]  = sector_prot_tmp[i/4 +1];

                 Sec_Prot[60]  = sector_prot_tmp[16];
                 Sec_Prot[61]  = sector_prot_tmp[16];
                 Sec_Prot[62]  = sector_prot_tmp[16];
                 for (i=0;i<=7;i=i+1)
                 SubSec_Prot[i]  = sector_prot_tmp[i+17];

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
        #100 PoweredUp = 1'b1;
    end

    always @(RESETNeg)
    begin
        RST <= #499 RESETNeg;
    end

   always @(BYTENeg)
    begin
        BYTE = BYTENeg;
    end

    initial
    begin

        write    = 1'b0;
        read     = 1'b0;
        Addr   = 0;

        ULBYPASS = 1'b0;
        ESP_ACT  = 1'b0 ;
        OTP_ACT  = 1'b0 ;
        AS_ACT  = 1'b0 ;

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

   ////////////////////////////////////////////////////////////////////////////
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
    always @(negedge BYTENeg)
    begin
        BYTENeg_event = $time;
    end
    always @(A)
    begin
        ADDR_event = $time;
    end
   always @(DIn[15])
   begin
       if (~BYTE)
           ADDR_event = $time;
   end

     always @(posedge OENeg)
    begin
        OENeg_posEvent = $time;
    end
    always @(posedge CENeg)
    begin
        CENeg_posEvent = $time;
    end
    ////////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ////////////////////////////////////////////////////////////////////////////
always @(negedge RST)
begin
    ESP_ACT = 1'b0;
    AS_ACT = 1'b0;
    OTP_ACT = 1'b0;
    ULBYPASS = 1'b0;
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

always @(next_state or RESETNeg or WENeg or RST or
         READY  or PoweredUp)
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
//    //////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

//    //latch address on rising edge and data on falling edge  of write
    always @(gWE_n or  gCE_n or  gOE_n )
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

 // ///////////////////////////////////////////////////////////////////////////
// //Process that reports warning when changes on signals WE#, CE#, OE# are
// //discarded
// ///////////////////////////////////////////////////////////////////////////
    always @(posedge WENeg)
    begin: PulseWatch1
         if ((gWE_n == WENeg)&& (CENeg === 0)) $display("Glitch on WE#");
    end
    always @(posedge CENeg)
    begin: PulseWatch2
        if (gCE_n == CENeg) $display("Glitch on CE#");
    end
    always @(posedge OENeg)
    begin: PulseWatch3
        if ((gOE_n == OENeg)&&(CENeg === 0)) $display("Glitch on OE#");
     end

    ///////////////////////////////////////////////////////////////////////////
    //Latch address on falling edge of WE# or CE# what ever comes later
    //Latches data on rising edge of WE# or CE# what ever comes first
    // also Write cycle decode
    ///////////////////////////////////////////////////////////////////////////
    integer A_tmp  ;
    integer SA_tmp ;
    integer A_tmp1 ;
    integer A_tmp2 ;
    integer BA_tmp;

    reg CE;

 always @(CENeg_ipd or WENeg_ipd or OENeg_ipd or MergeE or write)
        begin
                A_tmp  =  A[14:0];
                A_tmp2  =  A[11:0];
                SA_tmp =  A[HiAddrBit:15];
                BA_tmp =  A[HiAddrBit:18];

                if (vs == 1)
                    begin
                       case (BA_tmp)
                        0,1,2,3,4,5: BA = 0;
                        6,7: BA = 1;
                        endcase
                    end
                else
                    begin
                       case (BA_tmp)
                        0,1: BA = 0;
                        2,3,4,5,6,7: BA = 1;
                        endcase
                    end
     end

always @(WENeg_ipd)// or reseted)
        begin
        if (reseted)
        begin
            if (~WENeg_ipd && ~CENeg_ipd && OENeg_ipd )
            begin
                A_tmp  =  A[14:0];
                A_tmp2  =  A[11:0];
                SA_tmp =  A[HiAddrBit:15];
                BA_tmp =  A[HiAddrBit:18];

                  for(i=0;i<=SubSecNum;i=i+1)
                begin
                   if ( A_tmp >= sssa(i) && A_tmp <= ssea(i) )
                   begin
                      SubSect = i;
                   end
                end

                if (~BYTE)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

                Address = A_tmp1;
               Addr   = A_tmp;
               SecAddr = SA_tmp;
               SubAddr<=A_tmp2;

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
                A_tmp  =  A[14:0];
                A_tmp2  =  A[11:0];
                SA_tmp =  A[HiAddrBit:15];
                BA_tmp =  A[HiAddrBit:18];

                  for(i=0;i<=SubSecNum;i=i+1)
                begin
                   if ( A_tmp >= sssa(i) && A_tmp <= ssea(i) )
                   begin
                      SubSect = i;
                   end
                end

                if (~BYTE)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

               Address = A_tmp1;
               Addr   = A_tmp;
               SubAddr<=A_tmp2;
               SecAddr = SA_tmp;

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
                A_tmp  =  A[14:0];
                A_tmp2  =  A[11:0];
                SA_tmp =  A[HiAddrBit:15];
                BA_tmp =  A[HiAddrBit:18];

                if (~BYTE)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

              SecAddr = SA_tmp;
              Address = A_tmp1;
               Addr   = A_tmp;
              SubAddr<=A_tmp2;

            end

                SecAddr = SA_tmp;
                Address = A_tmp1;
                SubAddr<=A_tmp2;

                for(i=0;i<=SubSecNum;i=i+1)
                begin
                   if ( A_tmp >= sssa(i) && A_tmp <= ssea(i) )
                   begin
                      SubSect = i;
                   end
                end

                CE = CENeg;
                Addr   = A_tmp;

        end
        end

   always @(A or BYTE)
   begin
        if (reseted)
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
                -> MergeE;
    end

   always @(DIn)
   begin
        if (reseted)
            if (~BYTE && WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
                 -> MergeE;
    end

   always @(MergeE)
   begin
                A_tmp  =  A[14:0];
                A_tmp2  =  A[11:0];
                SA_tmp =  A[HiAddrBit:15];
                BA_tmp =  A[HiAddrBit:18];

                if (~BYTE)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

                SecAddr = SA_tmp;
                Address = A_tmp1;
                SubAddr<=A_tmp2;

                for(i=0;i<=SubSecNum;i=i+1)
                begin
                   if ( A_tmp >= sssa(i) && A_tmp <= ssea(i) )
                   begin
                      SubSect = i;
                   end
                end

                CE = CENeg;
                Addr   = A_tmp;

   end

    always @(posedge write)
    begin
                A_tmp  =  A[14:0];
                A_tmp2  =  A[11:0];
                SA_tmp =  A[HiAddrBit:15];
                BA_tmp =  A[HiAddrBit:18];

        for(i=0;i<=SubSecNum;i=i+1)
        begin
            if ( A_tmp >= sssa(i) && A_tmp <= ssea(i) )
            begin
                SubSect = i;
            end
        end
        SecAddr = SA_tmp;
        CE = CENeg;
        Addr   = A_tmp;
        Address = A_tmp1;
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
                if ((~FactoryProt   && OTP_ACT )||

                 (((SA != VarSect && ( ~Sec_Prot[SA] &&
                       (~Ers_Queue[SA] || ~ESP_ACT ))) ||
                     ( SA == VarSect &&
                      ( ~SubSec_Prot[SSA] &&
                       (~Ers_Sub_Queue[SSA] || ~ESP_ACT ))))&& ~OTP_ACT))
                begin
                  if(ULBYPASS)
                     duration_write = tdevice_POU;
                  else
                   begin
                    if (BYTE)
                    duration_write = tdevice_POW;
                    else duration_write = tdevice_POB;
                  end
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
                    for (i=0;i<=SecNum;i=i+1)
                      begin
                        if ( i == VarSect )
                            begin
                                for(j=0;j<=SubSecNum;j=j+1)
                                begin
                                if((Ers_Sub_Queue[j]==1'b1)&&(~SubSec_Prot[j]))
                                  cnt_erase = cnt_erase + 1;
                                end
                            end

                         else
                         begin
                             if ((Ers_Queue[i]==1'b1) && (Sec_Prot[i]!=1'b1))
                                  cnt_erase = cnt_erase + 1;
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

//    //////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    //////////////////////////////////////////////////////////////////////////
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
            if (BYTE)
                DataHi = DIn[15:8];
        //            DataLo    = D_tmp0;
            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
            A_PAT_1   = ((Addr==16'h555) && ~ULBYPASS) || ULBYPASS;
    end

   always @( write or reseted)
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

            PREL_SETBWB:
            begin
                    if (A_PAT_1 && (DataLo==8'hA0))
                        next_state = A0SEEN;
                    else if (A_PAT_1 && (DataLo==8'h20))
                        next_state = PREL_ULBYPASS;
                    else if (A_PAT_1 && (DataLo==8'h90))
                        next_state = AS;
                    else if (A_PAT_1 && (DataLo==8'h80))
                        next_state = C8;
                    else if (A_PAT_1 && (DataLo==8'h88))
                        next_state = OTP;
                    else
                        next_state = RESET;
             end

            PREL_ULBYPASS:
            begin
                  if ((BankBypassLock[BA]) && (DataLo==8'h90))
                        next_state = PREL_ULBYPASS_RESET;
                  else   if (A_PAT_1 && (DataLo==8'hA0))
                        next_state = A0SEEN;
                    else
                        next_state = PREL_ULBYPASS;
            end

            PREL_ULBYPASS_RESET:
            begin
                    if (DataLo==8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
            end

            AS :
            begin
                  if (DataLo==16'hF0)
                       if (ESP_ACT == 1)
                         next_state = ESP;
                       else
                         next_state = RESET;
                  else
                     if ((Addr== 16'h55) && (DataLo == 16'h98))
                        next_state = CFI;
                     else
                      next_state = AS;
            end

            CFI:
            begin
               if (DataLo==8'hF0)
                    if (ESP_ACT == 1)
                       if(AS_ACT == 1)
                          next_state = AS;
                       else
                          next_state = ESP;
                    else
                       if(AS_ACT == 1)
                         next_state = AS;
                       else
                         next_state = RESET;
               else
                        next_state <= CFI;
           end


            A0SEEN:
            begin
                    if (((BankBypassLock[BA]) && (ULBYPASS))
                         || (~ULBYPASS))
                         next_state = PGMS;
                    else
                         next_state = PREL_ULBYPASS;
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
                        next_state = OTP;
              end

              OTP_PREL :
              begin
                    if (A_PAT_1 && (DataLo == 16'h90))
                        next_state = OTP_EXIT;
                    else if (A_PAT_1 && (DataLo == 16'hA0))
                        next_state = OTP_A0SEEN;
                    else
                        next_state = OTP;
              end

            OTP_EXIT:
              begin
                    if (DataLo == 16'h00)
                            next_state = RESET;
                    else
                        next_state = OTP;
              end

            OTP_A0SEEN :
              begin
                   next_state = PGMS;
              end

            C8:
            begin
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else
                        next_state = RESET;
            end

            C8_Z001:
            begin
                    if (PATTERN_2)
                        next_state = C8_PREL;
                    else
                        next_state = RESET;
            end

            C8_PREL:
            begin
                    if (A_PAT_1 && DataLo==8'h10)
                        next_state = ERS;
                    else if(DataLo==8'h30)
                        next_state = SERS;
                    else
                     next_state = RESET;
            end

            SERS:
            begin
                 if (~CTMOUT)
                  begin
                     if (DataLo == 8'hB0)
                       if (BankErase[BA])
                             next_state = ESP; // ESP according to datasheet
                       else
                            next_state = SERS;
                     else if (DataLo==8'h30)
                        next_state = SERS;
                    else
                    next_state = RESET;
                 end
            end

            ESP:
            begin
                  if (DataLo == 8'h30  && (BankErase[BA]))
                        next_state = SERS_EXEC;
                    else
                        if (Addr == 8'h55 && DataLo == 8'h98)
                            next_state = CFI;
                        else if (PATTERN_1)
                            next_state = ESP_Z001;
            end

            ESP_ULBYPASS:
             begin
                    if (DataLo == 8'hA0)
                        next_state <= ESP_A0SEEN;
                    else if (DataLo == 8'h90  && (BankBypassLock[BA]))
                        next_state = ESP_ULBYPASS_RESET;
              end

            ESP_ULBYPASS_RESET:
             begin
                    if (DataLo == 8'h00)
                        next_state = ESP;
                    else
                        next_state = ESP_ULBYPASS;

             end

            ESP_Z001:
            begin
                    if (PATTERN_2)
                        next_state = ESP_SETBWB;
                    else
                        next_state = ESP;
            end

            ESP_SETBWB:
            begin
                    if (A_PAT_1 && (DataLo==8'h90))
                        next_state = AS;
                    else if(A_PAT_1 && DataLo == 8'hA0)
                        next_state = ESP_A0SEEN;
                    else if(A_PAT_1 && DataLo == 8'h20)
                        next_state = ESP_ULBYPASS;

                    else
                        next_state = ESP;
            end

            ESP_A0SEEN:
            begin
                 if (((BankBypassLock[BA]) && (ULBYPASS))
                  || (~ULBYPASS))
                     next_state = PGMS;
                 else
                        next_state = ESP_ULBYPASS;
            end

        endcase

    end

    always @(posedge PDONE or negedge PERR)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
         begin
            if (current_state==PGMS && ESP_ACT && ULBYPASS)
                next_state = ESP_ULBYPASS;
            else if (current_state==PGMS && ESP_ACT)
                    next_state = ESP;
            else if (current_state==PGMS && ULBYPASS)
                    next_state = PREL_ULBYPASS;
            else if (current_state==PGMS && OTP_ACT)
                    next_state = OTP;
            else if (current_state==PGMS)
                    next_state = RESET;
         end
    end

    always @(posedge EDONE or negedge EERR or reseted)
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
    integer i,j;
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
           if (current_state==SERS_EXEC &&
           ((write==1'b0) && (EERR!=1'b1) && BankErase[BA]) &&
           (DataLo==16'hB0))
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
            if ((current_state==SERS) && (CTMOUT))
                next_state = SERS_EXEC;
        end
    end

   always @(posedge START_T1 or reseted)
    begin: StateGen5 //ok
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if ((current_state==ESPS) && (START_T1))
                next_state = ESP;
    end

   event bank_erase_event;

   always @(bank_erase_event)
    begin
       #100000 BankErase = BankEraseExec;
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

  always @(posedge read)
       begin
          BankAddress = BA;
          ->oe_event;
      end

    always @(DIn[15])
    begin
        if ((BYTE==0) && read)
         begin
            BankAddress = BA;
             ->oe_event;
         end
    end

    always @(Address or SecAddr or BYTE)
    begin
        if (read )
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

            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            FROMADDR = 1'b1;
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t)&&FROMOE) ||
              ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                TempData = DOut_zd;
                FROMADDR = 1'b0;
                if (~BYTE)
                    DOut_Pass[15:8] = 8'bz;
                else
                    DOut_Pass[15:8] = 8'bx;
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
           if ((CENeg_posEvent <= OENeg_posEvent) &&
           ( CENeg_posEvent + 5 >= $time))
               FROMOE = 1'b0;
           if ((OENeg_posEvent < CENeg_posEvent) &&
           ( OENeg_posEvent + 5 >= $time))
               FROMCE = 1'b0;
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
                if (oe)
                    MemRead(DOut_zd);
            end

            AS :
            begin
                if (oe)
                begin
                    if (BankAutosel[BA]== 1)
                      begin
                         if (BYTE)
                         begin
                            if (SubAddr == 0 || SubAddr == 2 || SubAddr == 3)
                              DOut_zd[15:8] = 0;
                            else
                            if (SubAddr == 1)
                              DOut_zd[15:8] = 8'h22;
                            else
                              DOut_zd[15:8] = 8'bz;
                         end
                           else
                                DOut_zd[15:8] = 8'bz;

                         if (SubAddr == 0)
                              DOut_zd[7:0] = 1;

                         else if (SubAddr == 1)
                              begin
                                if (vs == 1)
                                DOut_zd[7:0] <=  8'h50;
                                else
                                DOut_zd[7:0] <=  8'h53;
                              end

                          else if (SubAddr == 2)
                          begin
                              DOut_zd[7:1] = 7'b0;
                              if ( SecAddr == VarSect )
                                  DOut_zd[0] = SubSec_Prot[SubSect];

                              else
                                  DOut_zd[0] = Sec_Prot[SecAddr];
                          end
                          else  if (SubAddr == 3)
                               begin
                                DOut_zd[6:0] = 7'h02;
                                DOut_zd[7] = FactoryProt;
                              end

                          else DOut_zd[7:0] = 8'bz;
                     end
                   else
                    begin
                      if (ESP_ACT == 0)
                        begin
                             MemRead(DOut_zd);
                          end
                      else
                        begin
                        if  (( SecAddr != VarSect && Ers_Queue[SecAddr]!=1'b1)
                         ||(SecAddr == VarSect&&Ers_Sub_Queue[SubSect]!=1'b1))
                              begin
                                  MemRead(DOut_zd);
                              end
                          else
                              begin
                               //////////////////////////////////////
                               ///read status
                               ///////////////////////////////////////
                               Status[7] = 1;
                               // Status[6] No toggle
                               Status[5] = 0;
                               Status[2] = ~ Status[2]; //toggle
                               DOut_zd = Status;
                              end

                       end
                    end

                end
            end

            CFI :
            begin
              if (oe)
                begin
                    if ((Addr >= 16'h10 && Addr <= 16'h3C) ||
                        (Addr >= 16'h40 && Addr <= 16'h50) ||
                        (Addr >= 16'h57 && Addr <= 16'h5B))
                     begin
                         DOut_zd[15:0] = CFI_array[Addr];
                         if (~BYTENeg)
                           DOut_zd[15:8] = 8'bZ;
                         if (~BYTENeg && !((Address % 2) == 0))
                           DOut_zd[7:0] = 8'bZ;
                     end
                   else
                     begin
                         DOut_zd[15:0] = 16'bZ;
                        $display ("Invalid CFI query address");
                     end
                end
            end

           OTP :
            begin
                if (oe)
                begin
                    //read SecSi Sector Region
                    SecSiAddr = Address%(SecSiSize +1);
                    if (SecSi[SecSiAddr]==-1)
                        DOut_zd[7:0] = 8'bx;
                    else
                        DOut_zd[7:0] = SecSi[SecSiAddr];

                    if (BYTENeg)
                        if (SecSi[SecSiAddr+1]==-1)
                            DOut_zd[15:8]= 8'bx;
                        else
                            DOut_zd[15:8] = SecSi[SecSiAddr+1];
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
            end

            SERS :
             begin
              if (oe)
                begin
                 if (BankErase[BA])
                    begin
                    ///////////////////////////////////////////////////////////
                    //read status - sector erase timeout
                    ///////////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    Status[3] = 1'b0;

                    DOut_zd = Status;
                    end
                    else
                        MemRead(DOut_zd);
               end
             end

            ESPS :
             begin
              if (oe)
               begin
                if (BankErase[BA])
                 begin
                    ///////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ///////////////////////////////////////////////////////////
                   if (((SecAddr == VarSect)&&(Ers_Sub_Queue[SubSect]== 1'b1))
                    || ((SecAddr != VarSect)&& (Ers_Queue[SecAddr]==1'b1)))
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
                    else
                        MemRead(DOut_zd);
            end
        end

          SERS_EXEC:
           begin
              if (oe)
                begin
                 if (BankErase[BA])
                   begin
                    ///////////////////////////////////////////////////
                    //read status erase
                    ///////////////////////////////////////////////////
                   if(((SecAddr == VarSect)&&(Ers_Sub_Queue[SubSect] == 1'b1))
                    || ((SecAddr != VarSect)&&(Ers_Queue[SecAddr]==1'b1)))
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
                   else
                        MemRead(DOut_zd);
            end
        end

           ESP :
          begin
            if (oe)
            begin
                ///////////////////////////////////////////////////////////
                //read
                ///////////////////////////////////////////////////////////

                if   (( SecAddr != VarSect  &&  Ers_Queue[SecAddr]!=1'b1)
                      ||( SecAddr == VarSect && Ers_Sub_Queue[SubSect]!=1'b1))
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
        end

        PREL_ULBYPASS:
            begin
                 if (oe)
                  if (BankAutosel[BA]== 0)
                     begin
                         MemRead(DOut_zd);
                     end
            end

       ESP_ULBYPASS :
            begin
                 if (oe)
                  if (BankAutosel[BA]== 0)
                    begin
                     if   (( SecAddr != VarSect  &&  Ers_Queue[SecAddr]!=1'b1)
                      ||( SecAddr == VarSect && Ers_Sub_Queue[SubSect]!=1'b1))
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
            end

        PGMS :
        begin
            if (oe)
            begin
               if  (ESP_ACT == 0)
                  begin
                  if (BankProg[BA] == 1)
                    begin
                      //////////////////////////////////////////////////////
                      //read status
                      ///////////////////////////////////////////////////////
                      Status[6] = ~Status[6]; //toggle
                      Status[5] = 1'b0;
                      //Status[2) no toggle
                      Status[1] = 1'b0;
                      DOut_zd = Status;

                      if (((SecAddr == VarSect)&&(SubSect == SSA)&&
                           (SecAddr == SA))
                      || ((SecAddr != VarSect && (SecAddr == SA))))
                          DOut_zd[7] = Status[7];
                      else
                          DOut_zd[7] = ~Status[7];

                      if(BYTE==0)
                             DOut_zd[15:8] = 8'bz;
                    end
                  else
                          MemRead(DOut_zd);
                  end
              else
               begin
                 if (BankProg[BA] != 1)
                  begin
                      if (( SecAddr != VarSect && Ers_Queue[SecAddr]!=1'b1)
                       ||(SecAddr == VarSect && Ers_Sub_Queue[SubSect]!=1'b1))
                          begin
                            MemRead(DOut_zd);
                          end
                       else
                          begin
                          //////////////////////////////////////////////////////
                          //read status
                          //////////////////////////////////////////////////////
                           Status[7] = 1'b1;
                           // Status[6) No toggle
                           Status[5] = 1'b0;
                           Status[2] = ~Status[2]; //toggle
                           DOut_zd = Status;
                           if(BYTE==0)
                             DOut_zd[15:8] = 8'bz;
                         end
                  end
                 else
                   begin
                   //////////////////////////////////////////////////////
                   //read status
                   ///////////////////////////////////////////////////////
                   Status[6] = ~Status[6]; //toggle
                   Status[5] = 1'b0;
                   //Status[2) no toggle
                   Status[1] = 1'b0;
                   DOut_zd = Status;
                   if(((SecAddr == VarSect)&&(SubSect == SSA)&&(SecAddr == SA))
                   || ((SecAddr != VarSect)&&(SecAddr == SA)))
                       DOut_zd[7] = Status[7];
                   else
                       DOut_zd[7] = ~Status[7];

                   if(BYTE==0)
                             DOut_zd[15:8] = 8'bz;
                    end
            end
       end
      end

       endcase

    end
 end
//*******************************************

    always @(write or reseted)
    begin : Output_generation
        if (~reseted)
        begin
            ESP_ACT       = 1'b0;
            OTP_ACT       = 1'b0;
            AS_ACT       = 1'b0;
            ULBYPASS       = 1'b0;
            BankErase      = 4'b0000;
            BankEraseExec  = 4'b0000;
            BankBypassLock = 4'b0000;
            BankAutosel    = 4'b0000;
            BankProg       = 4'b0000;
            Ers_Queue = 128'd0;
            Ers_Sub_Queue = 8'b00000000;
         end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
            ESP_ACT       = 1'b0;
            OTP_ACT       = 1'b0;
            AS_ACT       = 1'b0;
            ULBYPASS       = 1'b0;
            BankErase      = 4'b0000;
            BankEraseExec  = 4'b0000;
            BankBypassLock = 4'b0000;
            BankAutosel    = 4'b0000;
            BankProg       = 4'b0000;
            Ers_Queue = 128'd0;
            Ers_Sub_Queue = 8'b00000000;
            RY_zd = 1'b1;
                begin
                end
            end

            Z001 :
            begin
            end


            PREL_SETBWB :
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==16'h20))
                     begin
                        BankBypassLock[BA] <= 1;
                        ULBYPASS = 1'b1;
                     end
                    else if (A_PAT_1 && (DataLo==16'h90))
                      begin
                        BankAutosel [BA] = 1;
                        ULBYPASS = 1'b0;
                          AS_ACT       = 1'b1;
                      end
                    else if (A_PAT_1 && (DataLo==16'h88))
                      begin
                        OTP_ACT   = 1;
                        ULBYPASS = 1'b0;
                      end
                end
            end

            PREL_ULBYPASS,ESP_ULBYPASS :
            begin
                if (~write)
                  if (A_PAT_1 && (DataLo==16'h90))
                     begin
                        ULBYPASS = 1'b0;
                    end
                RY_zd = 1'b1;
            end

             PREL_ULBYPASS_RESET,ESP_ULBYPASS_RESET :
                if ((~write) && (DataLo != 16'h00 ))
                  begin
                        ULBYPASS = 1'b1;
                  end

            CFI:
            begin
            end

            AS :
            begin
                if (~write)
                    if (DataLo==16'hF0)  //remove autoselect mode bank
                     begin
                        BankAutosel = 4'b0000;
                         AS_ACT = 1'b0;
                         if (ESP_ACT == 1)
                            ULBYPASS  = 0;
                    end
            end

            OTP_PREL :
            begin
                if (~write)
                    if (A_PAT_1 && (DataLo==16'h90))
                       ULBYPASS = 1'b0;
            end

           OTP :
            begin
                RY_zd = 1;
            end

            A0SEEN,ESP_A0SEEN :
            begin
                if (~write)
                begin
                    BankProg[BA] = 1;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;

                        WBData[0] = DataLo;
                        WBData[1] = DataHi;

                    WBAddr[0] = Address;// % 32;
                    SA = SecAddr;
                    SSA = SubSect;
                    temp = DataLo;
                    Status[7] = ~temp[7];

                    if (BYTE)
                        WBAddr[1] = WBAddr[0] +1;
                    else
                        WBAddr[1] = -1;
                end
           end

           OTP_A0SEEN :
            begin
                if (~write)
                begin
                    OTP_ACT = 1;
                    BankProg[BA] = 1;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;


                    WBAddr[0] = Address;
                    SA = SecAddr;
                    SSA = SubSect;
                    temp = DataLo;
                    Status[7] = ~temp[7];

                   if (Address > 511)
                   $display("Invalid program address in SecSi region:",Address);

                      WBData[0] = DataLo;
                        WBData[1] = DataHi;


                    if (BYTE)
                        WBAddr[1] = WBAddr[0] +1;
                    else
                        WBAddr[1] = -1;
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
                begin
                  if (A_PAT_1 && DataLo == 16'h10)
                   //Start Chip Erase
                   begin
                       ESUSP  = 1'b0;
                       ERES   = 1'b0;
                       Ers_Queue = 64'hFFFFFFFFFFFFFFFF;
                       Ers_Sub_Queue = 8'b11111111;
                       Status = 8'b00000000;
                       ESTART = 1'b1;
                       BankErase = 4'b1111;
                       for (i=0;i<=SecNum;i=i+1)
                       begin
                           if (i!=VarSect)
                           begin
                                if  (~Sec_Prot[i])
                                    BankEraseExec[i] = 1'b1;
                           end
                           else
                           begin
                               for (j=0;j<=SubSecNum;j=j+1)
                                   if (~SubSec_Prot[j])
                                        BankEraseExec[0] = 1'b1;
                           end

                       end
                       -> bank_erase_event;
                       ESTART = #1 1'b0;
                       ESP_ACT = 1'b1;
                   end
                  else if (DataLo==16'h30)
                   begin
                   RY_zd = 1'b0;
                   //put selected sector to sec. ers. queue
                   //start timeout
                   ESP_ACT = 1'b1;
                   Ers_Queue = 128'd0;
                   Ers_Sub_Queue = 8'b00000000;
                   if (SecAddr == VarSect)
                       Ers_Sub_Queue[SubSect] = 1'b1;
                   else
                    begin

                       Ers_Queue[SecAddr] = 1'b1;
                    end
                   BankErase[BA] = 1'b1;
                   CTMOUT_in = 1'b1;
                   if ((SecAddr != VarSect) && ~Sec_Prot[SecAddr])
                       BankEraseExec[BA] = 1'b1;
                   else if  (SecAddr == VarSect &&
                   ~SubSec_Prot[SubSect])
                       BankEraseExec[BA] = 1'b1;

                   disable TCTMOUTr;
                       CTMOUT_in = 1'b0;
                       #1 CTMOUT_in <= 1'b1;
                   end
               end
           end

           ERS :
           begin
            RY_zd = 1'b0;
           end

           SERS :
           begin
           if (~write && ~CTMOUT)
             begin
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
                    disable TCTMOUTr;
                       CTMOUT_in = 1'b0;
                       #1 CTMOUT_in <= 1'b1;

                   if (SecAddr == VarSect)
                       Ers_Sub_Queue[SubSect] = 1'b1;

                   else
                        Ers_Queue[SecAddr] = 1'b1;
                   BankErase[BA] = 1'b1;
                   if ((SecAddr != VarSect) && ~Sec_Prot[SecAddr])
                      BankEraseExec[BA] = 1'b1;
                   else if ((SecAddr == VarSect)&&
                   ~SubSec_Prot[SubSect])
                      BankEraseExec[BA] = 1'b1;

                   CTMOUT_in = 1'b0;
                  end
               else
               begin
                   CTMOUT_in  = 1'b0;
                   Ers_Queue = 0;
                   Ers_Sub_Queue = 0;
               end
            end
           end

           SERS_EXEC :
           begin
               if (~write)
                   if (DataLo==8'hB0 && BankErase[BA])
                   begin
                       START_T1_in = 1'b1;
                       ESUSP = 1'b1;
                       ESUSP = #1 1'b0;
                   end
            RY_zd = 1'b0;
           end

           ESP :
           begin
               if (~write)
                begin
                   if (DataLo==16'h30 && BankErase[BA])
                   begin
                       ERES = 1'b1;
                       ERES = #1 1'b0;
                   end
                end

           end

           ESP_Z001 :
           begin
           end

           ESP_SETBWB :
           begin
               if (~write)
                   if (A_PAT_1 && (DataLo == 16'h20))
                    begin
                       BankBypassLock[BA] = 1'b1;
                       ULBYPASS = 1'b1;
                    end
                   else if (A_PAT_1 && (DataLo == 16'h90))   //autoselect mode
                      begin
                       BankAutosel[BA] = 1'b1;
                       AS_ACT = 1'b1;
                     end

           end

        endcase
        end
    end

   always @(current_state or reseted)
    begin
        if (reseted)
            if (current_state==RESET) RY_zd = 1'b1;
            if (current_state==PREL_ULBYPASS) RY_zd = 1'b1;
            if (current_state==ERS) RY_zd = 1'b0;
            if (current_state==SERS) RY_zd = 1'b1;
            if (current_state==OTP)  RY_zd = 1'b1;
            if (current_state==ESP_ULBYPASS) RY_zd = 1'b1;
            if (current_state==ESPS) RY_zd = 1'b0;
            if (current_state==SERS_EXEC) RY_zd = 1'b0;
            if (current_state==ESP)
                begin
                   RY_zd = 1'b1;
                   BankProg = 4'b0000;
                end
            if (current_state==PGMS) RY_zd = 1'b0;
    end

//******************************
    always @(EERR or EDONE )
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
                            for(k=2*sssa(j);k<=2*ssea(j)+1;k=k+1)
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
             begin
                for (i=0;i<=SecNum;i=i+1)
                 begin
                   if ( i == VarSect)
                     begin
                      for( j=0;j<=SubSecNum;j=j+1)
                        if ( SubSec_Prot[j]!=1'b1 )
                            for(k=2*sssa(j);k<=2*ssea(j)+1;k=k+1)
                                Mem[sa(i)+k] = MaxData;
                     end

                  else
                    begin
                     if (Sec_Prot[i]!=1'b1)
                         for (j=0;j<=SecSize;j=j+1)
                            Mem[sa(i)+j] = MaxData;
                   end
               end
             end
          RY_zd = 1'b0;
       end
    end


    always @(CTMOUT or current_state)
    begin : SERS2
        if (current_state==SERS && CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                ESTART = 1'b1;
                ESTART = #1 1'b0;
                for(i=0;i<=BankNum;i=i+1)
                 begin
                    if ((BankEraseExec[i]==0 && BankErase[i] == 1))
                       ->bank_erase_event ;
                 end
            end
    end

    always @(START_T1 or current_state)
    begin : ESPS2
       if (current_state==ESPS && START_T1)
          begin
                START_T1_in = 1'b0;
                ESP_ACT = 1'b1;
          end

    end

    always @( EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
    if (current_state==SERS_EXEC)
    begin
      if (EERR!=1'b1)
            begin
               for (i=0;i<=SecNum;i=i+1)
                 begin
                       if ( i == VarSect)
                          begin
                             for( j=0;j<=SubSecNum;j=j+1)
                             begin
                             if (SubSec_Prot[j]!=1'b1&&Ers_Sub_Queue[j]==1'b1)
                             for(k=2*sssa(j);k<=2*ssea(j)+1;k=k+1)
                               Mem[sa(i)+k] = -1;
                             end
                          end
                       else

                               begin
                                  if (Sec_Prot[i]!=1'b1 && Ers_Queue[i])
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
                              begin
                                if (SubSec_Prot[j]!=1'b1 && Ers_Sub_Queue[j])
                                    for(k=2*sssa(j);k<=2*ssea(j)+1;k=k+1)
                                        Mem[sa(i)+k] = MaxData;
                              end
                          end
                        else
                                begin
                                  if (Sec_Prot[i]!=1'b1 && Ers_Queue[i])
                                  for (j=0;j<=SecSize;j=j+1)
                                      Mem[sa(i)+j] = MaxData;
                                end

                      end
            end
         RY_zd = 1'b0;
    end
    end
//

    always @(current_state or posedge PDONE)
     begin: PGMS2
       integer i,j;
         if (current_state==PGMS)
           begin
           //busy signal active
            RY_zd = 1'b0;
             if (PERR!=1'b1)
               begin
                        //Word/Byte program
                      wr_cnt = 0;
                      if (WBAddr[1] > -1 )
                          wr_cnt =1;

                     for (i=wr_cnt;i>=0;i=i-1)
                      begin
                          new_int= WBData[i];
                          if (OTP_ACT!=1'b1)   //mem write
                          old_int=Mem[sa(SA) + WBAddr[i]];
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
                          Mem[sa(SA) + WBAddr[i]] = -1;
                          else
                          SecSi[WBAddr[i]] = -1;

                      end

                    if (PDONE && ~PSTART)
                       for (i=wr_cnt;i>=0;i=i-1)
                         begin
                           if (OTP_ACT!=1'b1)   //mem write
                           Mem[sa(SA) + WBAddr[i]] = WBData[i];
                           else
                           SecSi[WBAddr[i]]   = WBData[i];
                           WBData[i]= -1;
                        end

               end
        end
     end

    always @( negedge PERR)
    begin: PGMS3
    integer i,j;
    if (current_state==PGMS)
    begin
           if (~PERR)
                BankProg = 4'b0000;
    end
    end

  always @(gOE_n or gCE_n or RESETNeg or RST )
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
             DOut_zd = 16'bZ;
    end

    always @(BYTENeg)
    begin
        if (~BYTENeg)
            DOut_zd[15:8] = 8'bZ;
    end

 reg Sec_Prot_reg_1, Sec_Prot_reg_2;

 always @(WPNeg)
  if($time>0)
   begin
        //Hardware Write Protection
        if (~WPNeg)
        begin
            Sec_Prot_reg_1 = SubSec_Prot[ProtSecNum_1];
            Sec_Prot_reg_2 = SubSec_Prot[ProtSecNum_2];
            SubSec_Prot[ProtSecNum_1] = 1'b1;
            SubSec_Prot[ProtSecNum_2] = 1'b1;
        end
        else
         begin
            SubSec_Prot[ProtSecNum_1] = Sec_Prot_reg_1;
            SubSec_Prot[ProtSecNum_2] = Sec_Prot_reg_2;

       end
  end

    initial
    begin
        ///////////////////////////////////////////////////////////////////////
        //CFI array data
        ///////////////////////////////////////////////////////////////////////

            //CFI query identification string
            for (i=16;i<92;i=i+1)
                 CFI_array[i] = -1;

            CFI_array[16'h10] = 16'h0051;
            CFI_array[16'h11] = 16'h0052;
            CFI_array[16'h12] = 16'h0059;
            CFI_array[16'h13] = 16'h0002;
            CFI_array[16'h14] = 16'h0000;
            CFI_array[16'h15] = 16'h0040;
            CFI_array[16'h16] = 16'h0000;
            CFI_array[16'h17] = 16'h0000;
            CFI_array[16'h18] = 16'h0000;
            CFI_array[16'h19] = 16'h0000;
            CFI_array[16'h1A] = 16'h0000;

            //system interface string
            CFI_array[16'h1B] = 16'h0027;
            CFI_array[16'h1C] = 16'h0036;
            CFI_array[16'h1D] = 16'h0000;
            CFI_array[16'h1E] = 16'h0000;
            CFI_array[16'h1F] = 16'h0003;
            CFI_array[16'h20] = 16'h0000;
            CFI_array[16'h21] = 16'h0009;
            CFI_array[16'h22] = 16'h0000;
            CFI_array[16'h23] = 16'h0005;
            CFI_array[16'h24] = 16'h0000;
            CFI_array[16'h25] = 16'h0004;
            CFI_array[16'h26] = 16'h0000;
            //device geometry definition
            CFI_array[16'h27] = 16'h0016;
            CFI_array[16'h28] = 16'h0002;
            CFI_array[16'h29] = 16'h0000;
            CFI_array[16'h2A] = 16'h0000;
            CFI_array[16'h2B] = 16'h0000;
            CFI_array[16'h2C] = 16'h0002;
            CFI_array[16'h2D] = 16'h0007;
            CFI_array[16'h2E] = 16'h0000;
            CFI_array[16'h2F] = 16'h0020;
            CFI_array[16'h30] = 16'h0000;
            CFI_array[16'h31] = 16'h003E;
            CFI_array[16'h32] = 16'h0000;
            CFI_array[16'h33] = 16'h0000;
            CFI_array[16'h34] = 16'h0001;
            CFI_array[16'h35] = 16'h0000;
            CFI_array[16'h36] = 16'h0000;
            CFI_array[16'h37] = 16'h0000;
            CFI_array[16'h38] = 16'h0000;
            CFI_array[16'h39] = 16'h0000;
            CFI_array[16'h3A] = 16'h0000;
            CFI_array[16'h3B] = 16'h0000;
            CFI_array[16'h3C] = 16'h0000;
            //primary vendor-specific extended query
            CFI_array[16'h40] = 16'h0050;
            CFI_array[16'h41] = 16'h0052;
            CFI_array[16'h42] = 16'h0049;
            CFI_array[16'h43] = 16'h0031;
            CFI_array[16'h44] = 16'h0033;
            CFI_array[16'h45] = 16'h000C;
            CFI_array[16'h46] = 16'h0002;
            CFI_array[16'h47] = 16'h0001;
            CFI_array[16'h48] = 16'h0001;
            CFI_array[16'h49] = 16'h0004;

            CFI_array[16'h4A]  = 16'h0030;
            CFI_array[16'h58] = 16'h0017;

            CFI_array[16'h4B] = 16'h0000;
            CFI_array[16'h4C] = 16'h0000;
            CFI_array[16'h4D] = 16'h0085;
            CFI_array[16'h4E] = 16'h0095;
            CFI_array[16'h4F] = 16'h0002 + vs;
            CFI_array[16'h50] = 16'h0001;

            CFI_array[16'h57] = 16'h0002;
            CFI_array[16'h5A] = 16'h0000;
            CFI_array[16'h5B] = 16'h0000;

            CFI_array[16'h59] = 16'h0030;

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
    input  [15:0] sect;
    begin
        sa = sect * (SecSize + 1);
    end
    endfunction

    function integer sssa;
    input  [15:0] subsect;
    begin
            if (subsect == 0)
                sssa=16'h0000;
            else if (subsect == 1)
                sssa=16'h1000;
            else if (subsect == 2)
                sssa=16'h2000;
            else if (subsect == 3)
                sssa=16'h3000;
            else if (subsect == 4)
                sssa=16'h4000;
            else if (subsect == 5)
                sssa=16'h5000;
            else if (subsect == 6)
                sssa=16'h6000;
             else
                sssa=16'h7000;

    end
    endfunction

    function integer ssea;
    input  [15:0] subsect;
    begin
         if (subsect == 0)
                ssea=16'h0FFF;
            else if (subsect == 1)
                ssea=16'h1FFF;
            else if (subsect == 2)
                ssea=16'h2FFF;
            else if (subsect == 3)
                ssea=16'h3FFF;
            else if (subsect == 4)
                ssea=16'h4FFF;
            else if (subsect == 5)
                ssea=16'h5FFF;
            else if (subsect == 6)
                ssea=16'h6FFF;
             else
                ssea=16'h7FFF;

    end
    endfunction

  task MemRead;
    inout [15:0] DOut_zd;

    begin
        if (Mem[sa(SecAddr)+Address]==-1)
            DOut_zd[7:0] = 8'bx;
        else
            DOut_zd[7:0] = Mem[sa(SecAddr)+Address];
        if (BYTENeg)
            if (Mem[sa(SecAddr)+Address+1]==-1)
                DOut_zd[15:8]= 8'bx;
            else
                DOut_zd[15:8] = Mem[sa(SecAddr)+Address+1];
    end
    endtask
endmodule

 module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule