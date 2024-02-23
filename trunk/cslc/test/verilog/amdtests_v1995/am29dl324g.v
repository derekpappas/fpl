//////////////////////////////////////////////////////////////////////////////
//  File name : am29dl324g.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version: | author:      |  mod date: | changes made:
//    V1.0    M.Radmanovic    04 Feb 17   Initial release
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           AM29DL324G
//
//  Description:  32 Megabit(4M x 8-Bit/2M x 16-Bit) CMOS 3.0 Volt-only,
//                Simultaneous Operation Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am29dl324g
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
    parameter mem_file_name   = "none";//"am29dl324g.mem";
    parameter prot_file_name  = "none";//"am29dl324g_prot.mem";
    parameter secsi_file_name = "none";//"am29dl324g_secsi.mem";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID = "am29dl324g";
    parameter MaxData = 255;
    parameter SecSize = 65535;
    parameter SecSiSize = 255;
    parameter SecNum = 70;
    parameter HiAddrBit = 20;
    parameter AddrRANGE = 4194303;

    //variables to resolve if bottom or top architecture is used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;
    integer top_bottom;
    integer ProtSecNum;
    integer ProtSecNum1;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg OTP_ACT  ; ////SecSi access
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

    //Parameters of bank specific operations
    //Supports 2 (or less) bank architecture
    reg[1:0] BankID;
    reg[1:0] BankASEL;
    reg[1:0] BankPROGRAM;
    reg[1:0] BankUBPASS;
    reg[1:0] BankERASE;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum

    integer SA      = 0;         // 0 TO SecNum

    //Address within sector
    integer Address = 0;         // 0 - SecSize

    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    integer Addr ;         //0 TO 16'h7FF#

    integer AddrLO;
    integer AddrHI;

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;
    //Sector Protection Status
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;
    //SecSi ProtectionStatus
    reg FactoryProt;

    // timing check violation
    reg Viol = 1'b0;

    integer Mem[0:AddrRANGE];
    integer CFI_array[16:79];
    integer SecSi[0:SecSiSize];

    integer WData[0:31];
    integer WAddr[0:31];

    integer cnt = 0;

    reg Sec_Prot_reg  = 1'b0;
    reg Sec_Prot_reg1  = 1'b0;

    //Status reg.
    reg[7:0] Status = 8'b0;
    integer S_ind = 0;
    integer ind = 0;
    reg Si = 1'b0;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    reg[7:0] temp;

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
    reg FROMADDR;
    integer OEDQ_01;
    integer CEDQ_01;
    integer ADDRDQ_01;
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

 nmos   (RY  ,  1'b0   , ~RY_zd);

 wire deg;

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
     specparam           tpd_WENeg_RY            =1;    //tBUSY
     specparam           tpd_BYTENeg_DQ15        =1;
                         // tsetup values: setup time
                         // tsetup values: setup time

     specparam           tsetup_A0_CENeg         =1;   //tAS edge \
     specparam           tsetup_A0_OENeg         =1;   //tASO edge \
     specparam           tsetup_DQ0_CENeg        =1;   //tDS edge /

                          // thold values: hold times
     specparam           thold_CENeg_RESETNeg    =1; //tRH  edge /
     specparam           thold_OENeg_WENeg       =1; //tOEH edge /
     specparam           thold_A0_CENeg          =1; //tAH  edge \
     specparam           thold_A0_OENeg          =1; //tAHT edge \
     specparam           thold_DQ0_CENeg         =1; //tDH edge /
     specparam           thold_WENeg_OENeg       =1; //tGHVL edge /
     specparam           thold_BYTENeg_CENeg     =1;

        // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1; //tRP
     specparam           tpw_OENeg_posedge       =1; //tOEPH
     specparam           tpw_WENeg_negedge       =1; //tWP
     specparam           tpw_WENeg_posedge       =1; //tWPH
     specparam           tpw_CENeg_negedge       =1; //tCP
     specparam           tpw_CENeg_posedge       =1; //tCEPH
     specparam           tpw_A0_negedge          =1; //tWC tRC


        // tdevice values: values for internal delays
     specparam   tdevice_POB                     = 5000; //5 us;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 400000000; //400 ms;
            //Timing Limit Exceeded
     specparam   tdevice_HANG                    = 400000000; //400 ms; //?
            //program/erase suspend timeout
     specparam   tdevice_START_T1                = 5000; //5 us;
            //sector erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 50000; //50 us;
            //device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 20000; //20 us; //tReady


///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
  (CENeg => RY) = tpd_WENeg_RY;
  (WENeg => RY) = tpd_WENeg_RY;

//  if (FROMCE)
//  (CENeg *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//            DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_CENeg_DQ0;
  if (FROMCE)
  (CENeg *> DQ0) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ1) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ2) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ3) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ4) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ5) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ6) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ7) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ8) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ9) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ10) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ11) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ12) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ13) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ14) = tpd_CENeg_DQ0;

  if (FROMCE)
  (CENeg *> DQ15) = tpd_CENeg_DQ0;
//  if (FROMOE)
//  (OENeg *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//            DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_OENeg_DQ0;
  if (FROMOE)
  (OENeg *> DQ0) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ1) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ2) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ3) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ4) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ5) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ6) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ7) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ8) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ9) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ10) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ11) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ12) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ13) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ14) = tpd_OENeg_DQ0;

  if (FROMOE)
  (OENeg *> DQ15) = tpd_OENeg_DQ0;
//  if (~RESETNeg) (RESETNeg *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//            DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_RESETNeg_DQ0;
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
//  if (FROMADDR)
//     (A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10,
//      A11, A12, A13, A14, A15, A16, A17, A18, A19,
//      A20 *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//                 DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_A0_DQ0;
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
//  if (~BYTENeg && FROMADDR) (DQ15 *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//            DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ0) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ1) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ2) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ3) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ4) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ5) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ6) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ7) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ8) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ9) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ10) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ11) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ12) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ13) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ14) = tpd_A0_DQ0;
  if (~BYTENeg && FROMADDR) (DQ15 *> DQ15) = tpd_A0_DQ0;
//  if (BYTENeg) (BYTENeg *> DQ15, DQ1, DQ2 , DQ3 , DQ4 , DQ5 , DQ6 , DQ7,
//            DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ0) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ15) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ14) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ13) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ12) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ11) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ10) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ9) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ8) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ7) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ6) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ5) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ4) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ3) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ2) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ1) = tpd_BYTENeg_DQ15;
  if (BYTENeg) (BYTENeg *> DQ0) = tpd_BYTENeg_DQ15;
//  if (~BYTENeg) (BYTENeg *> DQ15, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ8)
//                    = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ15) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ14) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ13) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ12) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ11) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ10) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ9) = tpd_BYTENeg_DQ15;
  if (~BYTENeg) (BYTENeg *> DQ8) = tpd_BYTENeg_DQ15;
////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////
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
        $setup ( A0 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A1 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A2 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A3 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A4 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A5 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A6 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A7 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A8 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A9 , negedge OENeg,  tsetup_A0_OENeg, Viol);
        $setup ( A10 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A11 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A12 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A13 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A14 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A15 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A16 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A17 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A18 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A19 , negedge OENeg, tsetup_A0_OENeg, Viol);
        $setup ( A20 , negedge OENeg, tsetup_A0_OENeg, Viol);

        $setup ( DQ0 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ8 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ9 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ10 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ11 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ12 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ13 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ14 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ15 , posedge CENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ0 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ8 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ9 , posedge WENeg &&& deg,  tsetup_DQ0_CENeg, Viol);
        $setup ( DQ10 , posedge WENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ11 , posedge WENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ12 , posedge WENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ13 , posedge WENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ14 , posedge WENeg &&& deg, tsetup_DQ0_CENeg, Viol);
        $setup ( DQ15 , posedge WENeg &&& deg, tsetup_DQ0_CENeg, Viol);

        $setup ( BYTENeg , negedge WENeg , tsetup_A0_CENeg, Viol);

        $hold ( posedge RESETNeg &&& (CENeg===1), CENeg , thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& (OENeg===1), OENeg , thold_CENeg_RESETNeg, Viol);

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
        $hold ( negedge OENeg, A0 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A1 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A2 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A3 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A4 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A5 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A6 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A7 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A8 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A9 ,  thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A10 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A11 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A12 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A13 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A14 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A15 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A16 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A17 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A18 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A19 , thold_A0_CENeg, Viol);
        $hold ( negedge OENeg, A20 , thold_A0_CENeg, Viol);

        $hold ( posedge CENeg, DQ0 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ1 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ2 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ3 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ4 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ5 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ6 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ7 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ8 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ9 ,  thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ10 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ11 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ12 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ13 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ14 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg, DQ15 ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ0  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ1  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ2  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ3  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ4  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ5  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ6  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ7  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ8  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ9  ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ10 ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ11 ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ12 ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ13 ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ14 ,   thold_DQ0_CENeg, Viol);
        $hold ( posedge WENeg, DQ15 ,   thold_DQ0_CENeg, Viol);

        $hold ( posedge WENeg, OENeg , thold_OENeg_WENeg, Viol);
        $hold ( posedge OENeg, WENeg , thold_WENeg_OENeg, Viol);

        $hold ( negedge CENeg, BYTENeg, thold_BYTENeg_CENeg, Viol);
        $hold ( negedge WENeg, BYTENeg, thold_A0_CENeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);

        $width (posedge OENeg, tpw_OENeg_posedge);
        $width (posedge WENeg, tpw_WENeg_posedge);
        $width (negedge WENeg, tpw_WENeg_negedge);
        $width (posedge CENeg, tpw_CENeg_posedge);
        $width (negedge CENeg, tpw_CENeg_negedge);

        $width (posedge A0, tpw_A0_negedge);
        $width (negedge A0, tpw_A0_negedge);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET           =6'd0;
 parameter Z001            =6'd1;
 parameter PREL_SETBWB     =6'd2;
 parameter PREL_ULBYPASS   =6'd3;
 parameter RES_ULBYPASS    =6'd4;
 parameter CFI             =6'd5;
 parameter AS              =6'd6;
 parameter A0SEEN          =6'd7;
 parameter OTP             =6'd8;
 parameter OTP_Z001        =6'd9;
 parameter OTP_PREL        =6'd10;
 parameter OTP_AS          =6'd11;
 parameter OTP_A0SEEN      =6'd12;
 parameter C8              =6'd13;
 parameter C8_Z001         =6'd14;
 parameter C8_PREL         =6'd15;
 parameter ERS             =6'd16;
 parameter SERS            =6'd17;
 parameter ESPS            =6'd18;
 parameter SERS_EXEC       =6'd19;
 parameter ESP             =6'd20;
 parameter ESP_Z001        =6'd21;
 parameter ESP_PREL        =6'd22;
 parameter ESP_CFI         =6'd23;
 parameter ESP_A0SEEN      =6'd24;
 parameter ESP_AS          =6'd25;
 parameter PGMS            =6'd26;

 parameter DBank           = 2'b00;
 parameter CBank           = 2'b01;
 parameter BBank           = 2'b10;
 parameter ABank           = 2'b11;

 reg  [5:0] current_state;
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

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j;
    reg     sector_prot[0:71];
    integer secure_silicon[0:SecSiSize];

        for (i=0;i<=AddrRANGE;i=i+1)
        begin
            Mem[i] = MaxData;
        end
        for (i=0;i<=71;i=i+1)
        begin
           sector_prot[i]=0;
        end
        for (i=0;i<=SecSiSize;i=i+1)
        begin
           secure_silicon[i]=MaxData;
        end

        if ((UserPreload) && !(prot_file_name == "none"))
        begin
           //- Sector protection preload
           //am29dl324g_prot  sector protect file
           //   //      - comment
           //   @aaa    - <aaa> stands for sector address
           //   (aaaa is incremented at every load)
           //   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
           //   If <aaa> > SecNum SecSi
           //   is protected/unprotected
           $readmemb(prot_file_name,sector_prot);
        end
        if ((UserPreload) && !(secsi_file_name == "none"))
        begin
           // Secure Silicon Sector Region preload
           // am29dl324g_secsi memory file
           //   //       - comment
           //   @aa     - <aa> stands for address within last defined sector
           //   dd      - <dd> is byte to be written at SecSi(aa++)
           //  (aa is incremented at every load)
           $readmemh(secsi_file_name,secure_silicon);
        end
        if ((UserPreload) && !(mem_file_name == "none"))
        begin
           // Memory Preload
           //am29dl324g.mem, memory preload file
           //  @aaaaaa   - <aaaaaa> stands for address within last defined sector
           //  dd      - <dd> is byte to be written at Mem(nn)(aaaaaa++)
           // (aaaaaa is incremented at every load)
           $readmemh(mem_file_name,Mem);
        end
        for (i=0;i<=SecNum;i=i+1)
        begin
            Ers_queue[i] = 0;
            Sec_Prot[i] = sector_prot[i];
        end
        for (i=0;i<=31;i=i+1)
        begin
            WData[i] = 0;
            WAddr[i] = -1;
        end
        for (i=0;i<=SecSiSize;i=i+1)
        begin
            SecSi[i] = secure_silicon[i];
        end
        FactoryProt = sector_prot[71];

//TOP OR BOTTOM arch model is used
    //assumptions:
    //1. TimingModel has format as
    //"am29dl324gt"
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
     i = i +1;
     if (found)//if non null character is found
     begin
        for (j=0;j<=7;j=j+1)
         begin
        tmp_char[j] = TimingModel[(i-10)*8+j];//bottom/top character is 10
        end                                  //characters right from first ("a")
     end
      if (tmp_char == "T")
      begin
          top_bottom = 1'b1;
          ProtSecNum = 69;
          ProtSecNum1 = 70;
      end
      else if (tmp_char == "B")
      begin
          top_bottom = 1'b0;
          ProtSecNum = 0;
          ProtSecNum1 = 1;
      end

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
            CFI_array[16'h27] = 16'h16;
            CFI_array[16'h28] = 16'h02;
            CFI_array[16'h29] = 16'h00;
            CFI_array[16'h2A] = 16'h00;
            CFI_array[16'h2B] = 16'h00;
            CFI_array[16'h2C] = 16'h02;
            CFI_array[16'h2D] = 16'h07;
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
            CFI_array[16'h44] = 16'h33;
            CFI_array[16'h45] = 16'h04;
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h01;
            CFI_array[16'h49] = 16'h04;
            CFI_array[16'h4A] = 16'h20;
            CFI_array[16'h4B] = 16'h00;
            CFI_array[16'h4C] = 16'h00;
            CFI_array[16'h4D] = 16'h85;
            CFI_array[16'h4E] = 16'h95;
            if (tmp_char == "T")
                CFI_array[16'h4F] = 16'h03;
            else
                CFI_array[16'h4F] = 16'h02;

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
        Addr   = 0;

        ULBYPASS = 1'b0;
        OTP_ACT  = 1'b0 ;
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
        BankERASE = 0;
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
    always @(DIn[15])
    begin
        if (~BYTENeg)
            ADDR_event = $time;
    end

    //////////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    //////////////////////////////////////////////////////////////////////////////
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

//    ///////////////////////////////////////////////////////////////////////////
//    //Process that reports warning when changes on signals WE#, CE#, OE# are
//    //discarded
//    ///////////////////////////////////////////////////////////////////////////
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
//    ///////////////////////////////////////////////////////////////////////////
//    //Latch address on falling edge of WE# or CE# what ever comes later
//    //Latches data on rising edge of WE# or CE# what ever comes first
//    // also Write cycle decode
//    ///////////////////////////////////////////////////////////////////////////
        integer A_tmp  ;
        integer A_tmp1 ;
        integer AddrTmp ;
        integer AddressLatched;
        integer sector ;

        reg CE;

   always @(WENeg_ipd)// or reseted)
    begin
        if (reseted)
        begin
            if (~WENeg_ipd && ~CENeg_ipd && OENeg_ipd )
            begin
                A_tmp  =  A[10:0];
                AddressLatched = A;

                sector = ReturnSectorID(AddressLatched);
                BankID = ReturnBank(AddressLatched);

                ADDRHILO1(AddrLO, AddrHI, ReturnSectorID(AddressLatched));

                AddrTmp =  AddressLatched - AddrLO/2;

                if (~BYTENeg)
                    A_tmp1 = { AddrTmp[14:0],DIn[15] };
                else
                    A_tmp1 = { AddrTmp[14:0],1'b0};
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
                AddressLatched = A;

                sector = ReturnSectorID(AddressLatched);
                BankID = ReturnBank(AddressLatched);

                ADDRHILO1(AddrLO, AddrHI, ReturnSectorID(AddressLatched));

                AddrTmp =  AddressLatched - AddrLO/2;

                if (~BYTENeg)
                    A_tmp1 = { AddrTmp[14:0],DIn[15] };
                else
                    A_tmp1 = { AddrTmp[14:0],1'b0};
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
                AddressLatched = A;

                sector = ReturnSectorID(AddressLatched);
                BankID = ReturnBank(AddressLatched);

                ADDRHILO1(AddrLO, AddrHI, ReturnSectorID(AddressLatched));

                AddrTmp =  AddressLatched - AddrLO/2;

                if (~BYTENeg)
                    A_tmp1 = { AddrTmp[14:0],DIn[15] };
                else
                    A_tmp1 = { AddrTmp[14:0],1'b0};
            end
            if (~OENeg_ipd)
            begin

                BankID = ReturnBank(AddressLatched);
                SecAddr = ReturnSectorID(AddressLatched);
                Address = A_tmp1;
                CE = CENeg;
                Addr = A_tmp;
            end
        end
    end

   always @(A or BYTENeg)// or reseted)
    begin
        if (reseted)
        begin
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  A[10:0];
                AddressLatched = A;

                sector = ReturnSectorID(AddressLatched);
                BankID = ReturnBank(AddressLatched);

                ADDRHILO1(AddrLO, AddrHI, ReturnSectorID(AddressLatched));

                AddrTmp =  AddressLatched - AddrLO/2;

                if (~BYTENeg)
                    A_tmp1 = { AddrTmp[14:0],DIn[15] };
                else
                    A_tmp1 = { AddrTmp[14:0],1'b0};

                BankID = ReturnBank(AddressLatched);
                SecAddr = ReturnSectorID(AddressLatched);
                Address = A_tmp1;
                CE = CENeg;
                Addr = A_tmp;

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
                AddressLatched = A;

                sector = ReturnSectorID(AddressLatched);
                BankID = ReturnBank(AddressLatched);

                ADDRHILO1(AddrLO, AddrHI, ReturnSectorID(AddressLatched));

                AddrTmp =  AddressLatched - AddrLO/2;

                A_tmp1 = { AddrTmp[14:0],DIn[15] };

                BankID = ReturnBank(AddressLatched);
                SecAddr = ReturnSectorID(AddressLatched);
                Address = A_tmp1;
                CE = CENeg;
                Addr = A_tmp;
            end
        end
    end

    always @(posedge write)
    begin
       BankID = ReturnBank(AddressLatched);
       SecAddr = ReturnSectorID(AddressLatched);
       Address = A_tmp1;
       CE = CENeg;
       Addr = A_tmp;
    end

//    ///////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program Operations
//    // start
//    ///////////////////////////////////////////////////////////////////////////

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
                if (~(Sec_Prot[SA] ||
                       (Ers_queue[SA] && ESP_ACT) ||
                       (FactoryProt && OTP_ACT) ))
                begin

                    if (BYTENeg) cnt_write = 2;
                    else cnt_write = 1;

                    duration_write = cnt_write* tdevice_POB;
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
                    if (Ers_queue[i] && Sec_Prot[i]!=1'b1)
                        cnt_erase = cnt_erase + 1;
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
        if (~write)
        begin
            DataLo = DIn[7:0];
            if (BYTENeg)
             DataHi = DIn[15:8];
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
                    else if (A_PAT_1 && (DataLo==16'h88))
                        next_state = OTP;
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
                    if (A_PAT_1 && (DataLo==16'h90))
                        next_state = RES_ULBYPASS;
                    else if (A_PAT_1 && (DataLo==16'hA0))
                        next_state = A0SEEN;
                    else if (A_PAT_1 && (DataLo==16'h88))
                        next_state = OTP;
                    else if (A_PAT_1 && (DataLo==16'h80))
                        next_state = C8_PREL;
                end
            end

            RES_ULBYPASS :
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==16'h00))
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            CFI :
            begin
                if (~write)
                begin
                    if ((Addr == 16'h55) && (DataLo == 16'h98))
                        next_state = CFI;
                    else if (DataLo == 16'hF0)
                        next_state = RESET;
                    else
                        next_state = CFI;
                 end
             end

            AS :
            begin
                if (~write)
                 begin
                      if (DataLo==16'hF0)
                          next_state = RESET;
                  else
                      next_state = AS;
                end
            end

            A0SEEN :
            begin
                if (~write)
                    if ((ULBYPASS && BankID==BankUBPASS) || (~ULBYPASS))
                    begin
                        next_state = PGMS;
                    end
            end

            OTP :
            begin
              if (~write)
              begin
                  if (PATTERN_1)
                      next_state = OTP_Z001;
                    else
                        next_state = OTP;
              end
            end

              OTP_Z001 :
              begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = OTP_PREL;
                    else
                        next_state = OTP;
                end
              end

              OTP_PREL :
              begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo == 16'h90))
                        next_state = OTP_AS;
                    else if (A_PAT_1 && (DataLo == 16'hA0))
                        next_state = OTP_A0SEEN;
                    else
                        next_state = OTP;
                end
              end

              OTP_AS :
              begin
                if (~write)
                begin
                    if (DataLo==16'hF0)
                        if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;

                    else if (DataLo == 16'h00)
                        if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;

                    else
                        next_state = OTP;
                 end
               end

              OTP_A0SEEN :
              begin
                if (~write)
                    if ((ULBYPASS && BankID==BankUBPASS) || (~ULBYPASS))
                    begin
                        next_state = PGMS; //set OTP
                    end
             end

              C8 :
              begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
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
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
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
                    else if ((DataLo==16'h30) && ~(ULBYPASS &&
                            BankID != BankUBPASS))
                        next_state = SERS;
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
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
                    if (~CTMOUT)
                        if ((DataLo == 16'hB0) && (BusyBankE(BankID)))
                            next_state = ESP; // ESP according to datasheet
                        else if (DataLo==16'h30)// && (BankID == BankERASE))
                            next_state = SERS;
                        else if (ULBYPASS)
                            next_state = PREL_ULBYPASS;
                        else
                            next_state = RESET;
             end

              SERS_EXEC :
              begin
              end

              ESP :
              begin
                if (~write)
                begin
                    if ((DataLo == 16'h30) && BusyBankE(BankID))
                        next_state = SERS_EXEC;
                    else if (ULBYPASS)
                    begin
                        if (DataLo == 16'h98)
                            next_state = ESP_CFI;
                        else if (A_PAT_1 && (DataLo == 16'hA0) &&
                                 (BankID == BankUBPASS))
                            next_state = ESP_A0SEEN;
                        else if (A_PAT_1 && (DataLo == 16'h88))
                            next_state = OTP; //set ESP
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
                    else if (A_PAT_1 && DataLo == 16'h88)
                        next_state = OTP; //set ESP
                    else if (A_PAT_1 && DataLo == 16'h90)
                        next_state = ESP_AS;
                    else
                        next_state = ESP;
              end

              ESP_CFI :
              begin
                if (~write)
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

              ESP_A0SEEN :
              begin
                if (~write)
                    next_state = PGMS; //set ESP
              end

              ESP_AS :
              begin
                if (~write)
                    if (DataLo == 16'hF0)
                        // reset ULBYPASS
                        next_state = ESP;
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
                    if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
                    else
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
        if ((current_state==ERS) || (current_state==SERS_EXEC))
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
                if ((DataLo==16'hB0) &&  BusyBankE(BankID))
                    next_state = ESPS;
        end
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
                begin
                    DOut_zd[7:0] = READMEM(sector, Address);

                    if (BYTENeg)
                        DOut_zd[15:8] = READMEM(sector, Address+1);

                end
            end

            PREL_ULBYPASS :
            begin
                if (oe)
                begin
                    if (BankID != BankUBPASS)
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
                    else
                    begin
                        DOut_zd[7:0] = 8'bz;

                        if (BYTENeg)
                            DOut_zd[15:8] = 8'bz;
                    end
                end
            end

            CFI :
            begin
                 if (oe)
                 begin
                    DOut_zd[15:0] = 16'b0;
                    if ((Addr>16'h10)&&(Addr<16'h4F))
                    begin
                          if (~BYTENeg)
                            DOut_zd[15:8] = 8'bZ;
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
                  if (BankID == BankASEL)
                    begin

                        if (BYTENeg == 1)
                        begin
                            if (Addr == 0)
                                DOut_zd[15:8] = 0;
                            else if (Addr == 1)
                                DOut_zd[15:8] = 8'h22;
                            else if (Addr == 2)
                                DOut_zd[15:8] = 0;
                            else if (Addr == 3)
                                DOut_zd[15:8] = 0;
                        end
                        else
                            DOut_zd[15:8] = 8'bZ;

                        if (Addr == 0)
                            DOut_zd[7:0] = 1;
                        else if (Addr == 1)
                        begin
                            READAS(DOut_zd[7:0]);
                        end
                        else if (Addr == 2)
                        begin
                            DOut_zd[7:1] = 7'b0;
                            DOut_zd[0] = Sec_Prot[SecAddr];
                        end
                        else if (Addr == 3)
                        begin
                            DOut_zd[7:0] = 2;

                            DOut_zd[7] = FactoryProt;
                        end
                    end
                    else
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
                end
            end

            OTP :
            begin
                if (oe)
                begin
                    //read SecSi Sector Region
                    if (SecSi[Address]==-1)
                        DOut_zd[7:0] = 8'bx;
                    else
                        DOut_zd[7:0] = SecSi[Address];

                    if (BYTENeg)
                        if (SecSi[Address+1]==-1)
                            DOut_zd[15:8]= 8'bx;
                        else
                            DOut_zd[15:8] = SecSi[Address+1];
               end
            end

            OTP_AS :
            begin
                if (oe)
                begin
                  if (BankID == BankASEL)
                    begin
                        if (BYTENeg == 1)
                        begin
                            if (Addr == 0)
                                DOut_zd[15:8] = 0;
                            else if (Addr == 1)
                                DOut_zd[15:8] = 8'h22;
                            else if (Addr == 2)
                                DOut_zd[15:8] = 0;
                            else if (Addr == 3)
                                DOut_zd[15:8] = 0;
                        end
                        else
                            DOut_zd[15:8] = 8'bZ;

                        if (Addr == 0)
                            DOut_zd[7:0] = 1;
                        else if (Addr == 1)
                        begin
                            READAS(DOut_zd[7:0]);
                        end
                        else if (Addr == 2)
                        begin
                            DOut_zd[7:1] = 7'b0;
                            DOut_zd[0] = Sec_Prot[SecAddr];
                        end
                        else if (Addr == 3)
                        begin
                            DOut_zd[7:0] = 2;

                            DOut_zd[7] = FactoryProt;
                        end
                    end
                    else
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
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
                    if (BusyBankE(BankID))
                    begin
                        ///////////////////////////////////////////////////////////
                        //read status - sector erase timeout
                        ///////////////////////////////////////////////////////////
                        Status[3] = 1'b0;

                        DOut_zd[7:0] = Status;
                    end
                    else
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
                end
            end

            ESPS :
            begin
                if (oe)
                begin
                    if (BusyBankE(BankID))
                    begin
                        ///////////////////////////////////////////////////////////
                        //read status / erase suspend timeout - stil erasing
                        ///////////////////////////////////////////////////////////
                        Status[7] = 1'b0;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        if ( Ers_queue[SecAddr] == 1'b1 )
                            Status[2] = ~Status[2]; //toggle

                        DOut_zd[7:0] = Status;
                    end
                    else
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
                end
            end

            SERS_EXEC:
            begin
                if (oe)
                begin
                    if (BusyBankE(BankID))
                    begin
                        ///////////////////////////////////////////////////
                        //read status erase HANG
                        ///////////////////////////////////////////////////
                        //%el should never hang
                        Status[7] = 1'b0;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        if ( Ers_queue[SecAddr] == 1'b1 )
                            Status[2] = ~Status[2]; //toggle

                         DOut_zd[7:0] = Status;
                    end
                    else
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
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
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
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

                        DOut_zd[7:0] = Status;
                     end
                  end
              end

            ESP_CFI :
            begin
                if (oe)
                begin
                    DOut_zd[15:0] = 16'b0;
                    if ((Addr>16'h10)&&(Addr<16'h4F))
                    begin
                          if (~BYTENeg)
                            DOut_zd[15:8] = 8'bZ;
                          DOut_zd[7:0] = CFI_array[Addr];
                    end
                    else
                        $display ("Invalid CFI query address");
                 end
            end

            ESP_AS :
            begin
                if (oe)
                begin
                  if (BankID == BankASEL)
                    begin
                        if (BYTENeg == 1)
                        begin
                            if (Addr == 0)
                                DOut_zd[15:8] = 0;
                            else if (Addr == 1)
                                DOut_zd[15:8] = 8'h22;
                            else if (Addr == 2)
                                DOut_zd[15:8] = 0;
                            else if (Addr == 3)
                                DOut_zd[15:8] = 0;
                        end
                        else
                            DOut_zd[15:8] = 8'bZ;

                        if (Addr == 0)
                            DOut_zd[7:0] = 1;
                        else if (Addr == 1)
                        begin
                            READAS(DOut_zd[7:0]);
                        end
                        else if (Addr == 2)
                        begin
                            DOut_zd[7:1] = 7'b0;
                            DOut_zd[0] = Sec_Prot[SecAddr];
                        end
                        else if (Addr == 3)
                        begin
                            DOut_zd[7:0] = 2;
                            DOut_zd[7] = FactoryProt;
                        end
                    end
                    else
                    begin
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
                    end
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
                    //Status[2) no toggle
                    Status[1] = 1'b0;
                    if ( BankID == BankPROGRAM )
                        DOut_zd[7:0] = Status;
                    else if ( BankID != BankPROGRAM && ESP_ACT &&
                    BusyBankE(BankID) && Ers_queue[SecAddr] )
                    begin
                        Status[2] = ~Status[2];
                        DOut_zd[7:0] = Status;
                    end
                    else
                        DOut_zd[7:0] = READMEM(sector, Address);

                        if (BYTENeg)
                            DOut_zd[15:8] = READMEM(sector, Address+1);
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
                OTP_ACT = 1'b0;
                ESP_ACT = 1'b0;

                if (~write)
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
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==16'h20))
                    begin
                        ULBYPASS = 1'b1;
                        BankUBPASS = BankID;
                    end
                    else if (A_PAT_1 && (DataLo==16'h90))
                    begin
                        ULBYPASS = 1'b0;
                        BankASEL = BankID;
                    end
                    else if (A_PAT_1 && (DataLo==16'h88))
                    begin
                        ULBYPASS = 1'b0;
                        OTP_ACT  = 1'b1;
                    end
                end
              end

              PREL_ULBYPASS :
              begin
                if (~write)
                begin
                 if (A_PAT_1 && (DataLo==16'h88))
                 begin
                    ULBYPASS = 1'b0;
                    OTP_ACT  = 1'b1;
                 end
                end

                //ready signal active
                RY_zd = 1'b1;
              end

              RES_ULBYPASS :
              begin
                if (~write)
                begin
                 if (A_PAT_1 && (DataLo==16'h00))
                    ULBYPASS = 1'b0;
                end

                //ready signal active
                RY_zd = 1'b1;
              end

              CFI :
              begin
                if (~write)
                  if (DataLo==16'hF0)
                      ULBYPASS  = 1'b0;
              end

              AS :
              begin
                if (~write)
                    if (DataLo==16'hF0)
                        ULBYPASS  = 1'b0;
              end

              A0SEEN :
              begin
                if ((~write) && ~(ULBYPASS && (BankID != BankUBPASS)))
                begin
                    BankPROGRAM = BankID;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;

                    WData[0] = -1;
                    WData[1] = -1;
                    if (Viol == 1'b0)
                    begin
                        WData[0] = DataLo;
                        WData[1] = DataHi;
                    end

                    WAddr[0] = Address;
                    SA = SecAddr;
                    temp = DataLo;
                    Status[7] = ~temp[7];

                    if (BYTENeg)
                        WAddr[1] = WAddr[0] +1;
                    else
                        WAddr[1] = -1;
                 end
              end

              OTP :
              begin
                OTP_ACT = 1'b1;
                if (~write)
                //ready signal active
                RY_zd = 1'b1;
                end

              OTP_Z001 :
              begin
              end

              OTP_PREL :
              begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo == 16'h90))
                    begin
                        ULBYPASS = 1'b0;
                        BankASEL = BankID;
                    end
                end
               end

              OTP_AS :
              begin
                if (~write)
                begin
                    if (DataLo==16'hF0 || DataLo == 16'h00)
                    begin
                        OTP_ACT =1'b0;
                        if (ESP_ACT)
                            ULBYPASS  = 1'b0;
                    end
                end
              end

              OTP_A0SEEN :
              begin
                if (~write)
                begin
                    OTP_ACT = 1'b1;
                    BankPROGRAM = ABank;
                    ///////////////////////////////////////////////////////////
                    //SecSi programming: TBD
                    ///////////////////////////////////////////////////////////
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WData[0] = -1;
                    WData[1] = -1;
                    if (Viol == 1'b0)
                    begin
                        WData[0] = DataLo;
                        WData[1] = DataHi;
                    end

                    WAddr[0] = Address;

                    SA = 70 * top_bottom;
                    if (((SecAddr != 70) && (top_bottom == 1)) ||
                       ((SecAddr != 0) && (top_bottom == 0)))
                        $display("Invalid sector Address in SecSi");

                    temp = DataLo;
                    Status[7] = ~temp[7];

                    if (BYTENeg)
                        WAddr[1] = WAddr[0] +1;
                    else
                        WAddr[1] = -1;
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
                if (~write)
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
                    else if ((DataLo==16'h30) && ~(ULBYPASS && (BankID != BankUBPASS)))
                    begin
                        //put selected sector to sec. ers. queue
                        //start timeout
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
                RY_zd = 1'b0;
              end

              SERS :
              begin
              if (~write)
              begin
                if (~CTMOUT)
                begin
                    if ((DataLo == 16'hB0)&&(BusyBankE(BankID)))
                    begin
                        //need to start erase process prior to suspend
                        //ESTART = '1', '0' AFTER 1 ns;
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP = 1'b1;
                        ESUSP <= #1 1'b0;
                        ERES   = 1'b0;
                        //suspend timeout (should be 0 according to datasheet)
                    end
                    else if (DataLo==16'h30)//&&(BankID == BankERASE))
                    begin
                        BankE;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                        //CTMOUT_in = 1'b1;
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
                        begin
                            START_T1_in = 1'b1;
                            ESUSP = 1'b1;
                            RY_zd = 1'b0;
                        end
            end

              ESP :
              begin
                if (~write)
                begin
                    if ((DataLo == 16'h30 ) && BusyBankE(BankID))
                    begin
                        //resume erase
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                    end
                    else if (ULBYPASS)
                    begin
                      if (A_PAT_1 && (DataLo == 16'h88))
                            ESP_ACT = 1'b1;
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
                    else if (A_PAT_1 && (DataLo == 16'h88))
                        ESP_ACT = 1'b1;
                end
              end

              ESP_CFI :
              begin
                if (~write)
                begin
                    if (DataLo == 16'hF0)
                        ESP_ACT = 1'b1;
                    else if ((DataLo == 16'h30) && BusyBankE(BankID))
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
                    BankPROGRAM = BankID;
                    ESP_ACT = 1'b1;

                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;

                    WData[0] = -1;
                    WData[1] = -1;
                    if (Viol == 1'b0)
                    begin
                        WData[0] = DataLo;
                        WData[1] = DataHi;
                    end

                    WData[0] = DataLo;
                    WData[1] = DataHi;
                    WAddr[0] = Address;
                    SA = SecAddr;

                    temp = DataLo;
                    Status[7] = ~temp[7];

                    if (BYTENeg)
                        WAddr[1] = WAddr[0] +1;
                    else
                        WAddr[1] = -1;
                end
              end

              ESP_AS :
              begin
                if (~write)
                    if (DataLo == 16'hF0)
                        // resret ULBYPASS
                        ULBYPASS = 1'b0;
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
            if (current_state==PGMS) RY_zd = 1'b0;
            if (current_state==OTP) RY_zd = 1'b1;
            if (current_state==ESPS) RY_zd = 1'b0;

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
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO1(SecErsLOW,SecErsHIGH,i);
                    if (Sec_Prot[i]!=1'b1)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end
                if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO1(SecErsLOW,SecErsHIGH,i);
                    if (Sec_Prot[i]!=1'b1)
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = MaxData;
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
                RY_zd = 1'b1;
            end
    end

    always @(START_T1 or current_state)
    begin : ESPS2
        if (current_state==ESPS)
            if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
                //busy signal active
                ESUSP = 1'b0;
                RY_zd = 1'b0;
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
            if (EERR!=1'b1)
            begin
                for (i=0;i<=SecNum;i=i+1)
                    begin
                    ADDRHILO1(SecErsLOW,SecErsHIGH,i);
                    if (Ers_queue[i] && (Sec_Prot[i]!=1'b1))
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                    end

                if (EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO1(SecErsLOW,SecErsHIGH,i);
                        if (Ers_queue[i] && (Sec_Prot[i]!=1'b1))
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = MaxData;
                    end
                //busy signal active
                RY_zd = 1'b0;
           end
    end

    always @(current_state or posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
    integer SecProgLOW;
    integer SecProgHIGH;
        if (current_state==PGMS)
        begin
             ADDRHILO1(SecProgLOW,SecProgHIGH,SA);
           //busy signal active
            RY_zd = 1'b0;
            if (PERR!=1'b1)
            begin
                wr_cnt= 0;
                if (BYTENeg)
                    wr_cnt= 1;

                for (i=wr_cnt;i>=0;i=i-1)
                begin
                    new_int= WData[i];
                    if (OTP_ACT!=1'b1)   //mem write
                        old_int=Mem[SecProgLOW+WAddr[i]];
                    else
                        old_int=SecSi[WAddr[i]];

                    if (new_int > -1)
                    begin
                        new_bit = new_int;
                        if (old_int > -1)
                        begin
                            old_bit = old_int;
                            for(j=0;j<=7;j=j+1)
                                if (~old_bit[j])
                                    new_bit[j]=1'b0;
                            new_int=new_bit;
                        end

                        WData[i]= new_int;
                    end
                    else
                        WData[i]= -1;
                end
                for (i=wr_cnt;i>=0;i=i-1)
                begin
                    if (OTP_ACT!=1'b1)   //mem write
                        Mem[SecProgLOW+WAddr[i]] = -1;
                    else
                        SecSi[WAddr[i]]   = -1;

                end

                if (PDONE && ~PSTART)
                for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WAddr[i]> -1)
                            if (OTP_ACT!=1'b1)   //mem write
                                Mem[SecProgLOW+WAddr[i]] = WData[i];
                            else //SecSi write
                                SecSi[WAddr[i]]   = WData[i];
                        WData[i]= -1;
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
            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            FROMADDR = 1'b1;
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t) && FROMOE) ||
              ((ADDRDQ_t>CEDQ_t )&& FROMCE)))
            begin
                TempData = DOut_zd;
                FROMADDR = 1'b0;
                if (~BYTENeg)
                    DOut_Pass[15:8] = 8'bz;
                else
                    DOut_Pass[15:8] = 8'bx;
                DOut_Pass[7:0] = 8'bx;
                DOut_Pass <= #( ADDRDQ_t - $time ) TempData;
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
        if (PoweredUp)
            if (~WPNeg)
            begin
               Sec_Prot_reg = Sec_Prot[ProtSecNum];
               Sec_Prot_reg1 = Sec_Prot[ProtSecNum1];
               Sec_Prot[ProtSecNum] = 1'b1;
               Sec_Prot[ProtSecNum1] = 1'b1;
            end
            else
            begin
               Sec_Prot[ProtSecNum] = Sec_Prot_reg;
               Sec_Prot[ProtSecNum1] = Sec_Prot_reg1;
            end
    end

 function BusyBankE;
 input[1:0] BankNum;
 begin
     BusyBankE = ((BankNum == BBank) && BankERASE[0]) ||
                 ((BankNum == ABank) && BankERASE[1]);
 end
 endfunction

 task BankE;
 begin
     if ( BankID == BBank )
         BankERASE[0] = 1'b1;
     else if ( BankID == ABank )
         BankERASE[1] = 1'b1;
 end
 endtask

 function[7:0] READMEM;
 input sector;
 input Address;
 integer sector;
 integer Address;
 integer AddrBASE;
 integer Data;
 begin

     if (top_bottom == 1)
     begin
        if (sector < 63)
            AddrBASE  = sector*20'h10000;
        else
            AddrBASE = 22'h3F0000 + (sector-63)*16'h2000;
     end
     else
     begin
        if (sector <= 7)
            AddrBASE  = sector*20'h02000;
        else
            AddrBASE = (sector-7)*20'h10000;
     end

     Data = Mem[AddrBASE + Address];

     if ( Data == -1 )
         READMEM = 8'bx;
     else
         READMEM = Data;
 end
 endfunction

 task READAS;
 inout  DATA;
 reg [7:0] DATA;
 begin
     if (top_bottom == 1)
            DATA = 8'h5C;
     else
            DATA = 8'h5F;
 end
 endtask

  function [7:0] ReturnSectorID;
  input [HiAddrBit:0] ADDR;
  integer conv;
  begin
       conv = ADDR / 16'h8000;
       if (top_bottom == 1)
       begin
         if ( conv <= 62 )
            ReturnSectorID = conv;
         else
            ReturnSectorID = 63 + (ADDR - 24'h1F8000)/16'h1000;
       end
       else
       begin
         if ( conv == 0 )
            ReturnSectorID = ADDR/16'h1000;
         else
            ReturnSectorID = 7 + conv;
       end
  end
  endfunction

 function[1:0] ReturnBank;
 input[HiAddrBit:0] ADDR;
 integer result;
 begin

    result = ADDR / 20'h40000;
    if ((top_bottom == 0 && (result == 0 || result == 1 ||
        result == 2 || result == 3)) ||
       (top_bottom == 1 && (result == 7 || result == 6 ||
        result == 4 || result == 5)))
        ReturnBank = ABank;
    else
        ReturnBank = BBank;
 end
 endfunction

 task ADDRHILO1;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   sector;
 integer AddrLOW;
 integer AddrHIGH;
 integer sector;
 begin

     if (top_bottom == 1)
     begin
        if (sector < 63)
        begin
            AddrLOW  = sector*20'h10000;
            AddrHIGH = sector*20'h10000 + 20'h0FFFF;
        end
        else
        begin
            AddrLOW  = 22'h3F0000 + (sector-63)*16'h2000;
            AddrHIGH = 22'h3F0000 + (sector-63)*16'h2000 + 20'h01FFF;
        end
     end
     else
     begin
        if (sector <= 7)
        begin
            AddrLOW  = sector*20'h02000;
            AddrHIGH = sector*20'h02000 + 20'h01FFF;
        end
        else
        begin
            AddrLOW = (sector-7)*20'h10000;
            AddrHIGH = (sector-7)*20'h10000 + 20'h0FFFF;
        end
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
        ADDRDQ_01 = $time;
    end
endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
