//////////////////////////////////////////////////////////////////////////////
//  File name : am29lv642d.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  | author:        | % date:   | changes made:
//    V1.0     M.Stojsavljevic   04 Aug 31   Initial     
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     MCP Flash Memory
//  Part:           am29lv642d
//
//  Description:    128 Megabit (8 M x 16-Bit) MCP Flash Memory
//                 (Two am29lv640d Flash devices)
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
 // Top level module, FLASH as instances
 ////////////////////////////////////////////////
module am29lv642d
(
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

    CENegf1   ,
    CENegf2   ,
    OENeg    ,
    WENeg    ,
    ACC      ,
    RESETNeg ,
    RY
);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
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

    input  CENegf1  ;
    input  CENegf2  ;
    input  OENeg    ;
    input  WENeg    ;
    input  ACC      ;
    input  RESETNeg ;
    output RY       ;

   // port signals declaration
    wire  A21  ;
    wire  A20  ;
    wire  A19  ;
    wire  A18  ;
    wire  A17  ;
    wire  A16  ;
    wire  A15  ;
    wire  A14  ;
    wire  A13  ;
    wire  A12  ;
    wire  A11  ;
    wire  A10  ;
    wire  A9   ;
    wire  A8   ;
    wire  A7   ;
    wire  A6   ;
    wire  A5   ;
    wire  A4   ;
    wire  A3   ;
    wire  A2   ;
    wire  A1   ;
    wire  A0   ;

    wire  DQ15  ;
    wire  DQ14  ;
    wire  DQ13  ;
    wire  DQ12  ;
    wire  DQ11  ;
    wire  DQ10  ;
    wire  DQ9   ;
    wire  DQ8   ;
    wire  DQ7   ;
    wire  DQ6   ;
    wire  DQ5   ;
    wire  DQ4   ;
    wire  DQ3   ;
    wire  DQ2   ;
    wire  DQ1   ;
    wire  DQ0   ;

    wire  CENegf1  ;
    wire  CENegf2  ;
    wire  OENeg    ;
    wire  WENeg    ;
    wire  ACC      ;
    wire  RESETNeg ;
    reg   RY       ;
    wire  RY1       ;
    wire  RY2       ;

always @ (RY1 or RY2)
begin
    if ((RY1 == 0) || (RY2 == 0))
        RY = 1'b0;
    else
        RY = 1'bz;
end

    parameter mem_file_name = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name  = "none";
    parameter UserPreload     = 1'b0;
    parameter TimingModel     = "DefaultTimingModel";

// Instance of FLASH memory
am29lv640d  #(mem_file_name,prot_file_name,secsi_file_name,
              UserPreload,TimingModel) U_FLASH_1
(
    .A21(A21)    ,
    .A20(A20)    ,
    .A19(A19)    ,
    .A18(A18)    ,
    .A17(A17)    ,
    .A16(A16)    ,
    .A15(A15)    ,
    .A14(A14)    ,
    .A13(A13)    ,
    .A12(A12)    ,
    .A11(A11)    ,
    .A10(A10)    ,
    .A9(A9)      ,
    .A8(A8)      ,
    .A7(A7)      ,
    .A6(A6)      ,
    .A5(A5)      ,
    .A4(A4)      ,
    .A3(A3)      ,
    .A2(A2)      ,
    .A1(A1)      ,
    .A0(A0)      ,
    .DQ15(DQ15)  ,
    .DQ14(DQ14)  ,
    .DQ13(DQ13)  ,
    .DQ12(DQ12)  ,
    .DQ11(DQ11)  ,
    .DQ10(DQ10)  ,
    .DQ9(DQ9)    ,
    .DQ8(DQ8)    ,
    .DQ7(DQ7)    ,
    .DQ6(DQ6)    ,
    .DQ5(DQ5)    ,
    .DQ4(DQ4)    ,
    .DQ3(DQ3)    ,
    .DQ2(DQ2)    ,
    .DQ1(DQ1)    ,
    .DQ0(DQ0)    ,
    .CENeg(CENegf1),
    .OENeg(OENeg) ,
    .WENeg(WENeg)      ,
    .ACC(ACC)      ,
    .RESETNeg(RESETNeg),
    .RY(RY1));

// Instance of FLASH memory
am29lv640d  #(mem_file_name,prot_file_name,secsi_file_name,
              UserPreload,TimingModel) U_FLASH_2
(
    .A21(A21)    ,
    .A20(A20)    ,
    .A19(A19)    ,
    .A18(A18)    ,
    .A17(A17)    ,
    .A16(A16)    ,
    .A15(A15)    ,
    .A14(A14)    ,
    .A13(A13)    ,
    .A12(A12)    ,
    .A11(A11)    ,
    .A10(A10)    ,
    .A9(A9)      ,
    .A8(A8)      ,
    .A7(A7)      ,
    .A6(A6)      ,
    .A5(A5)      ,
    .A4(A4)      ,
    .A3(A3)      ,
    .A2(A2)      ,
    .A1(A1)      ,
    .A0(A0)      ,
    .DQ15(DQ15)  ,
    .DQ14(DQ14)  ,
    .DQ13(DQ13)  ,
    .DQ12(DQ12)  ,
    .DQ11(DQ11)  ,
    .DQ10(DQ10)  ,
    .DQ9(DQ9)    ,
    .DQ8(DQ8)    ,
    .DQ7(DQ7)    ,
    .DQ6(DQ6)    ,
    .DQ5(DQ5)    ,
    .DQ4(DQ4)    ,
    .DQ3(DQ3)    ,
    .DQ2(DQ2)    ,
    .DQ1(DQ1)    ,
    .DQ0(DQ0)    ,
    .CENeg(CENegf2),
    .OENeg(OENeg) ,
    .WENeg(WENeg)      ,
    .ACC(ACC)      ,
    .RESETNeg(RESETNeg),
    .RY(RY2));
endmodule

////////////////////////////////////////////////////
// Timing model for FLASH component of am29lv642d
////////////////////////////////////////////////////
module am29lv640d
(
    A21     ,
    A20     ,
    A19     ,
    A18     ,
    A17     ,
    A16     ,
    A15     ,
    A14     ,
    A13     ,
    A12     ,
    A11     ,
    A10     ,
    A9      ,
    A8      ,
    A7      ,
    A6      ,
    A5      ,
    A4      ,
    A3      ,
    A2      ,
    A1      ,
    A0      ,

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
    ACC      ,
    RESETNeg ,
    RY     );

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
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
    input  ACC      ;
    input  RESETNeg ;
    output RY       ;

// interconnect path delay signals

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

    wire [21 : 0] A;
    assign A = {
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
    wire  ACC_ipd      ;

//  internal delays
    reg POW_in     ;
    reg POW_out    ;
    reg SEO_in      ;
    reg SEO_out     ;
    reg HANG_out    ; // Program/Erase Timing Limit
    reg HANG_in     ;
    reg PSTART_T1   ; // Start TimeOut
    reg PSTART_T1_in;
    reg ESTART_T1   ; // Start TimeOut
    reg ESTART_T1_in;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

    wire  DQ15_zd  ;
    wire  DQ14_zd  ;
    wire  DQ13_zd  ;
    wire  DQ12_zd  ;
    wire  DQ11_zd  ;
    wire  DQ10_zd  ;
    wire  DQ9_zd   ;
    wire  DQ8_zd   ;
    wire  DQ7_zd   ;
    wire  DQ6_zd   ;
    wire  DQ5_zd   ;
    wire  DQ4_zd   ;
    wire  DQ3_zd   ;
    wire  DQ2_zd   ;
    wire  DQ1_zd   ;
    wire  DQ0_zd   ;
    wire  DQ15_pass;
    wire  DQ14_pass;
    wire  DQ13_pass;
    wire  DQ12_pass;
    wire  DQ11_pass;
    wire  DQ10_pass;
    wire  DQ9_pass;
    wire  DQ8_pass;
    wire  DQ7_pass;
    wire  DQ6_pass;
    wire  DQ5_pass;
    wire  DQ4_pass;
    wire  DQ3_pass;
    wire  DQ2_pass;
    wire  DQ1_pass;
    wire  DQ0_pass;

    reg [15 : 0] DOut_zd;
    assign {DQ15_zd,
            DQ14_zd,
            DQ13_zd,
            DQ12_zd,
            DQ11_zd,
            DQ10_zd,
            DQ9_zd,
            DQ8_zd,
            DQ7_zd,
            DQ6_zd,
            DQ5_zd,
            DQ4_zd,
            DQ3_zd,
            DQ2_zd,
            DQ1_zd,
            DQ0_zd  } = DOut_zd;

    reg [15 : 0] DOut_pass ;
    assign {DQ15_pass,
            DQ14_pass,
            DQ13_pass,
            DQ12_pass,
            DQ11_pass,
            DQ10_pass,
            DQ9_pass,
            DQ8_pass,
            DQ7_pass,
            DQ6_pass,
            DQ5_pass,
            DQ4_pass,
            DQ3_pass,
            DQ2_pass,
            DQ1_pass,
            DQ0_pass  } = DOut_pass;

    reg RY_zd;

    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name = "none";
    parameter UserPreload     = 1'b0;
    parameter TimingModel     = "DefaultTimingModel";
    parameter MemSize         = 24'h3FFFFF;
    parameter PartID          = "am29lv640d";
    parameter MaxData         = 16'hFFFF; // 65535;
    parameter SecSize         = 16'h8000; // secsize
    parameter SecNum          = 128;
    parameter HiAddrBit       = 21;
    parameter LowSecAddrBit   = 15;
    parameter SecSiSize       = 16'h7F;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg ERS_ACT  ; ////Erase Suspend
    reg PGMS_ACT ; ////Program Embedded Algorithm

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
    reg [SecNum-1:0] Ers_Queue; // = SecNum'b0;

    // secsi active
    reg OTP_ACT = 1'b0;
    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SA = 0;         // 0 - SecNum
    //Address within sector
    integer Address = 0;         // 0 - SecSize
    integer BrAddrSt = 0;
    reg[HiAddrBit:0] AddressLatch;

    time ADDRDQ_01, CEDQ_01, OEDQ_01, RESETDQ;
    reg BurstEnable;

    //A19:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer Mem[0:MemSize];
    integer SecSi[0: SecSiSize];
    //Sector Protection Status
    reg [SecNum-1:0] Sec_Prot=0;

    integer CFI_array[8'h10:8'h4F];

    reg Viol = 1'b0;

    integer cnt = 0;

    reg oe = 1'b0;
    event oe_event;

    //Status reg.
    reg[7:0] Status = 8'b0;
    reg[15:0] CFI_data = 0;

    // iterator for FOR loop
    integer i,j,k;

    reg FactoryProt;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
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
 buf   (A9_ipd , A9);
 buf   (A8_ipd , A8);
 buf   (A7_ipd , A7);
 buf   (A6_ipd , A6);
 buf   (A5_ipd , A5);
 buf   (A4_ipd , A4);
 buf   (A3_ipd , A3);
 buf   (A2_ipd , A2);
 buf   (A1_ipd , A1);
 buf   (A0_ipd , A0);

 buf   (DQ15_ipd, DQ15);
 buf   (DQ14_ipd, DQ14);
 buf   (DQ13_ipd, DQ13);
 buf   (DQ12_ipd, DQ12);
 buf   (DQ11_ipd, DQ11);
 buf   (DQ10_ipd, DQ10);
 buf   (DQ9_ipd , DQ9);
 buf   (DQ8_ipd , DQ8);
 buf   (DQ7_ipd , DQ7);
 buf   (DQ6_ipd , DQ6);
 buf   (DQ5_ipd , DQ5);
 buf   (DQ4_ipd , DQ4);
 buf   (DQ3_ipd , DQ3);
 buf   (DQ2_ipd , DQ2);
 buf   (DQ1_ipd , DQ1);
 buf   (DQ0_ipd , DQ0);

 buf   (CENeg_ipd    , CENeg   );
 buf   (OENeg_ipd    , OENeg   );
 buf   (WENeg_ipd    , WENeg   );
 buf   (ACC_ipd , ACC);
 buf   (RESETNeg_ipd , RESETNeg);

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
nmos   (DQ15,   DQ15_pass , 1);
nmos   (DQ14,   DQ14_pass , 1);
nmos   (DQ13,   DQ13_pass , 1);
nmos   (DQ12,   DQ12_pass , 1);
nmos   (DQ11,   DQ11_pass , 1);
nmos   (DQ10,   DQ10_pass , 1);
nmos   (DQ9 ,   DQ9_pass , 1);
nmos   (DQ8 ,   DQ8_pass , 1);
nmos   (DQ7 ,   DQ7_pass , 1);
nmos   (DQ6 ,   DQ6_pass , 1);
nmos   (DQ5 ,   DQ5_pass , 1);
nmos   (DQ4 ,   DQ4_pass , 1);
nmos   (DQ3 ,   DQ3_pass , 1);
nmos   (DQ2 ,   DQ2_pass , 1);
nmos   (DQ1 ,   DQ1_pass , 1);
nmos   (DQ0 ,   DQ0_pass , 1);

nmos   (RY  ,   1'b0      , ~RY_zd);

wire deg;
reg ADDRDQ = 0;

wire OE_en;
reg  FROMCE, FROMOE, FROMADDR;
reg  close_buffer;

wire toggleEN;
wire toggleCE;
wire toggleOE;
assign toggleEN = (ERS_ACT==1 && PGMS_ACT==1);
assign toggleCE = (CENeg===0) && toggleEN;
assign toggleOE = (OENeg===0) && toggleEN;

/////////////////////////////////////////////
// Timing check and propagation delay section
/////////////////////////////////////////////
specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

    // tpd delays
    specparam           tpd_A0_DQ0             =1;
    specparam           tpd_CENeg_DQ0          =1; //(tCE,tCE,tDF,-,tDF,-)
    specparam           tpd_OENeg_DQ0          =1; //(tOE,tOE,tDF,-,tDF,-)
    specparam           tpd_WENeg_RY           =1;

    // Setup values
    specparam           tsetup_A0_WENeg        =1; //tAS, WENeg \
    specparam           tsetup_A0_OENeg        =1; //tASO, OENeg \
    specparam           tsetup_DQ0_WENeg       =1; //tDS, WENeg /
    specparam           tsetup_CENeg_WENeg     =1; //tCS, CENeg LOW, WENeg \
    specparam           tsetup_OENeg_WENeg     =1; //tGHWL,OENeg HIGH,WENeg \

    // thold values
    specparam           thold_A0_WENeg         =1; //tAH edge \
    specparam           thold_A0_OENeg         =1; //tAHT  edge /
    specparam           thold_DQ0_WENeg        =1; //tDH edge /

    specparam           thold_WENeg_OENeg      =1; //tGHWL edge /
    specparam           thold_OENeg_WENeg      =1; //tOEH edge /
    specparam           thold_CENeg_WENeg      =1; //tCH, edge /
    specparam           thold_WENeg_CENeg      =1; //tWH, edge /
    specparam           thold_CENeg_RESETNeg   =1; //tRH  edge /
    specparam           thold_OENeg_RESETNeg   =1; //tRH  edge /
    // tpw values: pulse width
    specparam           tpw_RESETNeg_negedge   =1; //tRP
    specparam           tpw_WENeg_negedge      =1; //tWP
    specparam           tpw_WENeg_posedge      =1; //tWPH
    specparam           tpw_CENeg_negedge      =1; //tCP
    specparam           tpw_CENeg_posedge      =1; //tCPH
    specparam           tpw_OENeg_posedge      =1; //tOEPH
    specparam           tpw_OENeg_negedge      =1; //tOEPH
    specparam           tpw_A0_negedge         =1; //tRC
    specparam           tpw_A0_posedge         =1; //tRC

    // tdevice values: values for internal delays
           //Program Operation
    specparam   tdevice_POW                     = 11000; //11 us;
           //Sector Erase Operation    tWHWH2
    specparam   tdevice_SEO                     = 1600000000;//1.6 sec;
           // erase suspend timeout
    specparam   tdevice_ESTART_T1               = 20000; //20 us;
           //sector erase command sequence timeout
    specparam   tdevice_CTMOUT                  = 50000; //50 us;
           //device ready after Hardware reset(during embeded algorithm)
    specparam   tdevice_READY                   = 20000; //20 us; //tReady

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
    if (FROMADDR)
        ( A0 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A0 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A1 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A1 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A2 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A2 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A3 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A3 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A4 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A4 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A5 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A5 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A6 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A6 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A7 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A7 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A8 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A8 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A9 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A9 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A10 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A10 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A11 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A11 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A12 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A12 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A13 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A13 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A14 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A14 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A15 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A15 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A16 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A16 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A17 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A17 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A18 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A18 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A19 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A19 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A20 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A20 => DQ15) = tpd_A0_DQ0;

    if (FROMADDR)
        ( A21 => DQ0) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ1) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ2) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ3) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ4) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ5) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ6) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ7) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ8) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ9) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ10) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ11) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ12) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ13) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ14) = tpd_A0_DQ0;
    if (FROMADDR)
        ( A21 => DQ15) = tpd_A0_DQ0;

    if (FROMCE)
        (CENeg => DQ0)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ1)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ2)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ3)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ4)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ5)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ6)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ7)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ8)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ9)     = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ10)    = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ11)    = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ12)    = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ13)    = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ14)    = tpd_CENeg_DQ0;
    if (FROMCE)
        (CENeg => DQ15)    = tpd_CENeg_DQ0;

    if (FROMOE)
        (OENeg => DQ0)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ1)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ2)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ3)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ4)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ5)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ6)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ7)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ8)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ9)     = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ10)    = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ11)    = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ12)    = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ13)    = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ14)    = tpd_OENeg_DQ0;
    if (FROMOE)
        (OENeg => DQ15)    = tpd_OENeg_DQ0;

    (WENeg => RY)     = tpd_WENeg_RY;
    (CENeg => RY)     = tpd_WENeg_RY;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           /
///////////////////////////////////////////////////////////////////////////////
        $setup ( A0 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A1 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A2 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A3 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A4 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A5 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A6 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A7 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A8 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A9 ,  negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A20 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A21 , negedge WENeg &&& CENeg==0, tsetup_A0_WENeg, Viol);

        $setup ( A0 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A1 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A2 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A3 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A4 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A5 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A6 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A7 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A8 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A9 ,  negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A20 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);
        $setup ( A21 , negedge CENeg &&& WENeg==0, tsetup_A0_WENeg, Viol);

        $setup ( A0 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A1 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A2 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A3 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A4 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A5 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A6 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A7 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A8 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A9 ,  negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A10 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A11 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A12 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A13 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A14 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A15 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A16 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A17 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A18 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A19 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A20 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);
        $setup ( A21 , negedge OENeg &&& toggleCE, tsetup_A0_OENeg, Viol);

        $setup ( DQ0 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 ,posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 ,posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 ,posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 ,posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 ,posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 ,posedge CENeg &&& WENeg==0, tsetup_DQ0_WENeg, Viol);

        $setup ( DQ0 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 ,posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 ,posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 ,posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 ,posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 ,posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 ,posedge WENeg &&& CENeg==0, tsetup_DQ0_WENeg, Viol);

        $setup ( CENeg, negedge WENeg , tsetup_CENeg_WENeg, Viol);
        $setup ( WENeg, negedge CENeg , tsetup_CENeg_WENeg, Viol);
        $setup ( OENeg, negedge WENeg , tsetup_OENeg_WENeg, Viol);

        $hold ( negedge CENeg &&& WENeg==0, A0 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A1 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A2 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A3 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A4 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A5 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A6 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A7 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A8 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A9 ,  thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A10 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A11 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A12 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A13 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A14 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A15 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A16 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A17 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A18 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A19 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A20 , thold_A0_WENeg, Viol);
        $hold ( negedge CENeg &&& WENeg==0, A21 , thold_A0_WENeg, Viol);

        $hold ( negedge WENeg &&& CENeg==0, A0 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A1 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A2 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A3 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A4 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A5 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A6 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A7 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A8 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A9 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A10 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A11 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A12 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A13 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A14 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A15 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A16 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A17 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A18 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A19 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A20 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& CENeg==0, A21 , thold_A0_WENeg, Viol);

        $hold ( posedge OENeg &&& toggleCE, A0 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A1 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A2 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A3 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A4 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A5 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A6 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A7 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A8 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A9 ,  thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A10 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A11 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A12 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A13 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A14 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A15 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A16 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A17 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A18 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A19 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A20 , thold_A0_OENeg, Viol);
        $hold ( posedge OENeg &&& toggleCE, A21 , thold_A0_OENeg, Viol);

        $hold ( posedge CENeg &&& toggleOE, A0 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A1 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A2 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A3 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A4 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A5 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A6 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A7 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A8 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A9 ,  thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A10 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A11 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A12 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A13 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A14 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A15 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A16 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A17 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A18 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A19 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A20 , thold_A0_OENeg, Viol);
        $hold ( posedge CENeg &&& toggleOE, A21 , thold_A0_OENeg, Viol);

        $hold ( posedge CENeg &&& WENeg==0, DQ0 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ1 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ2 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ3 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ4 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ5 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ6 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ7 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ8 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ9 , thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ10, thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ11, thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ12, thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ13, thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ14, thold_DQ0_WENeg, Viol);
        $hold ( posedge CENeg &&& WENeg==0, DQ15, thold_DQ0_WENeg, Viol);

        $hold ( posedge WENeg &&& CENeg==0, DQ0 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ1 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ2 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ3 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ4 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ5 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ6 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ7 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ8 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ9 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ10, thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ11, thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ12, thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ13, thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ14, thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& CENeg==0, DQ15, thold_DQ0_WENeg, Viol);

        $hold ( posedge WENeg &&& toggleEN, OENeg, thold_OENeg_WENeg, Viol);
        $hold ( posedge OENeg, WENeg, thold_WENeg_OENeg, Viol);
        $hold ( posedge CENeg, WENeg, thold_CENeg_WENeg, Viol);
        $hold ( posedge WENeg, CENeg, thold_WENeg_CENeg, Viol);
        $hold ( posedge RESETNeg &&& CENeg, CENeg, thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& OENeg, OENeg, thold_OENeg_RESETNeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (posedge WENeg, tpw_WENeg_posedge);
        $width (negedge WENeg, tpw_WENeg_negedge);
        $width (posedge CENeg, tpw_CENeg_posedge);
        $width (negedge CENeg, tpw_CENeg_negedge);
        $width (posedge OENeg &&& toggleEN, tpw_OENeg_posedge);
        $width (negedge A0, tpw_A0_negedge);
        $width (posedge A0, tpw_A0_posedge);
    endspecify

///////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        /
///////////////////////////////////////////////////////////////////////////////

    // FSM states
    parameter RESET               =6'd0;
    parameter Z001                =6'd1;
    parameter PREL_SETBWB         =6'd2;
    parameter PREL_ULBYPASS       =6'd3;
    parameter CFI                 =6'd5;
    parameter AS                  =6'd6;
    parameter OTP                 =6'd7;
    parameter OTP_Z001            =6'd8;
    parameter OTP_PREL            =6'd9;
    parameter OTP_A0SEEN          =6'd10;
    parameter OTP_EXIT            =6'd11;
    parameter OTP_FP1             =6'd12;
    parameter OTP_FP2             =6'd13;
    parameter A0SEEN              =6'd14;
    parameter C8                  =6'd15;
    parameter C8_Z001             =6'd16;
    parameter C8_PREL             =6'd17;
    parameter ERS                 =6'd18;
    parameter SERS                =6'd19;
    parameter ESPS                =6'd20;
    parameter AS_CFI              =6'd21;
    parameter UNLOCK_RESET        =6'd25;
    parameter SERS_EXEC           =6'd26;
    parameter ESP                 =6'd27;
    parameter ESP_Z001            =6'd28;
    parameter ESP_PREL            =6'd29;
    parameter ESP_CFI             =6'd31;
    parameter ESP_A0SEEN          =6'd32;
    parameter ESP_AS              =6'd33;
    parameter ESP_AS_CFI          =6'd34;
    parameter ESP_ULBYPASS        =6'd35;
    parameter ESP_ULBYPASS_RESET  =6'd36;
    parameter PGMS                =6'd37;

    reg [5:0] current_state;
    reg [5:0] next_state;

    reg deq;
    reg read_nosuspend_sect;
    integer WRData  = 0;
    integer Mem_tmp= 0;
    integer WRSA;
    integer WRAddress;

    always @(DIn, DOut)
    begin
      if (DIn==DOut)
        deq=1'b1;
      else
        deq=1'b0;
    end
    // check when data is generated from model to avoid setuphold check in
    assign deg=deq;

    // preload
    initial
    begin: InitMemory
    integer j, sect, sect_addr;
    integer  sector_prot[0:SecNum];

        for (j=0;j<=MemSize;j=j+1)
            Mem[j]=MaxData;

        for (j=0;j<=SecSiSize;j=j+1)
            SecSi[j]=MaxData;

        for (j=0;j<=SecNum - 1;j=j+1)
            sector_prot[j]=0;

        // - Memory  preload
        // am29lv640d.mem memory  file
        // // - comment
        // @aaa - <aaa> stands for sector address
        // dd - <dd> is byte to be written at SecSi(aa++)
        //   (aa is incremented at every load)
        if (UserPreload && mem_file_name != "")
           $readmemh(mem_file_name,Mem);

        // - Secsi  preload
        // am29lv640d_secsi.mem secsi file
        // // - comment
        // @aaa - <aaa> stands for sector address
        // dd - <dd> is byte to be written at SecSi(aa++)
        //   (aa is incremented at every load)
        if (UserPreload && secsi_file_name != "")
           $readmemh(secsi_file_name,SecSi);

        //- Sector protection preload
        //am29lv640d_prot.mem sector protect file
        // // - comment
        // @sec - <sec> stands for sector address
        // (sec is incremented at every load)
        // d - <d> is 1 for protected sector <sec>, 0 for unprotect.
        // @80   - if d = 1 SecSi is factory protected
        //       - if d = 0 Secsi is customer lockable
        if (UserPreload && prot_file_name != "")
           $readmemh(prot_file_name,sector_prot);

        for (i=0;i<=SecNum-1;i=i+1)
             Sec_Prot[i] = sector_prot[i];
        FactoryProt = sector_prot[SecNum];
    end

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
        ERS_ACT  = 1'b0;
        PGMS_ACT = 1'b0;

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

    always @(posedge ESTART_T1_in)
    begin:TESTARTT1r
      #tdevice_ESTART_T1 ESTART_T1 = ESTART_T1_in;
    end
    always @(negedge ESTART_T1_in)
    begin:TESTARTT1f
      #1 ESTART_T1 = ESTART_T1_in;
    end

    always @(posedge CTMOUT_in)
    begin:TCTMOUTr
      #tdevice_CTMOUT CTMOUT = CTMOUT_in;
    end
    always @(negedge CTMOUT_in)
    begin:TCTMOUTf
      disable TCTMOUTr;
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
         READY or PoweredUp) // or  EDONE or PDONE
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

//   /////////////////////////////////////////////////////////////////////////
//   //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//   /////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd; //AFTER 5 ns;
    assign #5 gCE_n = CENeg_ipd; //AFTER 5 ns;
    assign #5 gOE_n = OENeg_ipd; //AFTER 5 ns;

//    //latch address on rising edge and data on falling edge  of write
    always @(gWE_n or  gCE_n or  gOE_n or RESETNeg or reseted)
    begin: write_dc
            if (RESETNeg && reseted)
            begin
                if (~gWE_n && ~gCE_n && gOE_n)
                    write = 1'b1;
                else
                    write = 1'b0;
            end

            if (gWE_n && ~gCE_n && ~gOE_n && reseted)
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
    begin: PulseWatch2
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
    //DATA  High Byte
    integer Data;
    //DATA Low Byte
    integer DataLo;

    reg CE;

    event addrLatch_event;
    always @(posedge WENeg_ipd, posedge CENeg_ipd)// or reseted)
    begin
        if (reseted)
        begin
        if (write)
            begin
               DataLo = DIn[7:0];
               Data   = DIn[15:0];
            end
        end
    end

    always @(A, CENeg, OENeg, WENeg)// or reseted)
    begin
        if (~CENeg && (WENeg != OENeg))
               -> addrLatch_event;
    end

    always @( addrLatch_event)
    begin
        Addr          = A[10:0];
        Address       = A[LowSecAddrBit-1:0];
        SA            = A[HiAddrBit:LowSecAddrBit];
        AddressLatch  = A;
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
                if ((~Sec_Prot[SA] && ~Ers_Queue[SA] && ~OTP_ACT) ||
                   (FactoryProt==0 && OTP_ACT))
                begin
                        duration_write = tdevice_POW;
                     -> pdone_event;
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
                    for (i=0;i<=SecNum-1;i=i+1)
                    begin
                          if (Ers_Queue[i] && ~Sec_Prot[i])
                             cnt_erase = cnt_erase +1;
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

/////////////////////////////////////////////////////////////////////////////
//// Main Behavior Process
//// combinational process for next state generation
/////////////////////////////////////////////////////////////////////////////
reg PATTERN_1  = 1'b0;
reg PATTERN_2  = 1'b0;
reg A_PAT_1  = 1'b0;
reg     RY_tmp;   // temp signal for ready
integer AutoselAddress;
time erase_start;

    task DriveOut;
        begin

            if (Mem[SA*SecSize + Address]==-1)
                DOut_zd[15:0] = 16'bx;
            else
                DOut_zd[15:0] = Mem[SA*SecSize + Address];
        end
    endtask

    task Read_AS;
        begin
            AutoselAddress = Address % 12'h100;

            if (AutoselAddress == 0)
               DOut_zd = 1'b1;
            else if (AutoselAddress == 1)
               DOut_zd = 16'h22D7;
            else if (AutoselAddress == 2)
            begin
                if (~Sec_Prot[SA])
                    // sector unlock
                    DOut_zd[15:0] = 16'h0000;
                else
                    // sector lock
                    DOut_zd[15:0] = 16'h0001;
            end
            else
                DOut_zd[15:0] = 16'bz;
        end
    endtask

    task Readmem_EraseSuspend;
        integer y;
        begin
            read_nosuspend_sect = 1'b1;
            if  (Ers_Queue[SA] && ~Sec_Prot[SA])
                read_nosuspend_sect =1'b0;

            if (read_nosuspend_sect)
            begin
                DriveOut;
            end
            else
            begin
                 Status[7] = 1'b1;
                 //Status[6] No toggle
                 Status[5] = 1'b0;
                 Status[2] = ~ Status[2]; //toggle
                 DOut_zd[7 : 0] = Status;
                 DOut_zd[15 : 8] = 8'bz;
            end
        end
    endtask

    task Read_EraseStatus;
    begin
        Status[7] = 1'b0;
        Status[6] = ~ Status[6];
        Status[5] = 1'b0;
        Status[3] = 1'b1;
        if ($time - erase_start > 100000)
            begin
            if (Ers_Queue[SA] && ~Sec_Prot[SA])
                Status[2] = ~ Status[2];
            end
        else
            if (Ers_Queue[SA])
                Status[2] = ~ Status[2];
    end
    endtask

    always @( write or reseted)
    begin: StateGen1
        if (~write)
        begin
            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
            A_PAT_1   = ((Addr==16'h555) && ~ULBYPASS) || ULBYPASS;
        end
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

            PREL_SETBWB:
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==8'hA0))
                        next_state = A0SEEN;
                    else if (A_PAT_1 && (DataLo==8'h20))
                        next_state = PREL_ULBYPASS;
                    else if (A_PAT_1 && (DataLo==8'h88))
                        next_state = OTP;
                    else if (A_PAT_1 && (DataLo==8'h90))
                        next_state = AS;
                    else if (A_PAT_1 && (DataLo==8'h80))
                        next_state = C8;
                    else
                        next_state = RESET;
                end
             end

            PREL_ULBYPASS:
            begin
                if (~write)
                begin
                    if (DataLo==8'h90)
                        next_state = UNLOCK_RESET;
                    else if (DataLo==8'hA0)
                        next_state = A0SEEN;
                end
            end

            UNLOCK_RESET:
            begin
                if (~write)
                begin
                    if (DataLo==8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            CFI:
            begin
                if (~write)
                begin
                    if (DataLo==8'hF0)
                       next_state = RESET;
                end
            end

            OTP:
            begin
                if (~write)
                    if (PATTERN_1)
                        next_state = OTP_Z001;
                    else if (Address % 12'h100 == 8'h02 && DataLo == 8'h60)
                        next_state = OTP_FP1;
                    else
                        next_state = OTP;
            end

            OTP_FP1:
            begin
                if (~write)
                    if (Address % 12'h100 == 8'h02 && DataLo == 8'h40)
                        next_state = OTP_FP2;
                    else
                        next_state = OTP;
            end

            OTP_FP2:
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = OTP;
            end

            OTP_Z001:
            begin
               if (~write)
                   if (PATTERN_2)
                       next_state = OTP_PREL;
                   else
                       next_state = OTP;
            end

            OTP_PREL:
            begin
               if (~write)
                   if (A_PAT_1 && (DataLo == 8'h90))
                       next_state = OTP_EXIT;
                   else if (A_PAT_1 && (DataLo == 8'hA0))
                       next_state = OTP_A0SEEN;
                   else
                       next_state = OTP;
            end

            OTP_EXIT:
            begin
               if (~write)
                   if ((DataLo == 16'h00) && (ERS_ACT == 0))
                       next_state = RESET;
                   else if ((DataLo == 16'h00) && (ERS_ACT == 1))
                        next_state = ESP;
                   else
                       next_state = OTP;
            end

            OTP_A0SEEN:
            begin
                if (~write)
                    if (SA==0 && Address<=SecSiSize)
                        next_state = PGMS;
                    else
                        next_state = OTP;
            end

            AS:
            begin
                if (~write)
                begin
                    if (DataLo==8'hF0)
                        next_state = RESET;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = AS_CFI;
                end
            end

            AS_CFI:
            begin
                if (~write)
                begin
                    if (DataLo==8'hF0)
                        next_state = AS;
                    else
                        next_state = AS_CFI;
                end
            end

            A0SEEN:
            begin
                if (~write)
                begin
                      next_state = PGMS;
                end
            end

            C8:
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else
                        next_state = RESET;
                end
            end

            C8_Z001:
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = C8_PREL;
                    else
                        next_state = RESET;
                end
            end

            C8_PREL:
            begin
                if (~write)
                begin
                    if (A_PAT_1 && DataLo==8'h10)
                        next_state = ERS;
                    else if (DataLo==8'h30)
                        next_state = SERS;
                    else
                    begin
                        next_state = RESET;
                    end
                end
            end

            ERS :
            begin
            end

            SERS:
            begin
                if (~write)
                begin
                   if (DataLo == 8'hB0)
                    begin
                         next_state = ESP; // ESP according to datasheet
                    end
                    else if (DataLo==8'h30)
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
            end

            SERS_EXEC :
            begin
            end

            ESPS:
            begin
            end

            ESP:
            begin
                if (~write)
                    if (DataLo == 8'h30)
                        next_state = SERS_EXEC;
                    else
                        if (Addr == 8'h55 && DataLo == 8'h98)
                            next_state = ESP_CFI;
                        else if (PATTERN_1)
                            next_state = ESP_Z001;
            end

            ESP_Z001:
            begin
                if (~write)
                    if (PATTERN_2)
                        next_state = ESP_PREL;
                    else
                        next_state = ESP;
            end

            ESP_PREL:
            begin
                if (~write)
                    if (A_PAT_1 && (DataLo==8'h90))
                        next_state = ESP_AS;
                    else if(A_PAT_1 && DataLo == 8'hA0)
                        next_state = ESP_A0SEEN;
                    else if(A_PAT_1 && DataLo == 8'h20)
                        next_state = ESP_ULBYPASS;
                    else if(A_PAT_1 && DataLo == 8'h88)
                        next_state = OTP;
                    else
                        next_state = ESP;
            end

            ESP_ULBYPASS:
             begin
               if (~write)
                   if (DataLo==8'hA0)
                       next_state = ESP_A0SEEN;
                   else if(DataLo == 8'h90)
                       next_state = ESP_ULBYPASS_RESET;
             end

            ESP_ULBYPASS_RESET :
               begin
               if (~write)
                   if (DataLo==8'h00)
                       next_state = ESP;
                   else
                       next_state = ESP_ULBYPASS;
               end

            ESP_CFI:
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = ESP;
            end

            ESP_A0SEEN:
            begin
                if (~write)
                    next_state = PGMS;
            end

            ESP_AS:
            begin
                if (~write)
                    if (DataLo==8'hF0)
                        next_state = ESP;
                    else if ((Addr==8'h55) && (DataLo==8'h98))
                        next_state = ESP_AS_CFI;
                    else
                        next_state = ESP_AS;
            end

            ESP_AS_CFI:
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = ESP_AS;
                    else
                        next_state = ESP_AS_CFI;
            end

            PGMS :
            begin
            end
        endcase
    end

    always @(posedge PDONE or negedge PERR)
    begin: StateGen7

        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                if (ERS_ACT)
                begin
                    if  (ULBYPASS)
                        next_state = ESP_ULBYPASS;
                    else if (OTP_ACT)
                        next_state = OTP;
                    else
                        next_state = ESP;
                end
                else if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else if (OTP_ACT)
                    next_state = OTP;
                else
                    next_state = RESET;
            end
        end
    end
    always @(posedge EDONE or negedge EERR or reseted)
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

    always @(CTMOUT or reseted)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS && CTMOUT)
               next_state = SERS_EXEC;
        end
    end

    always @(posedge ESTART_T1 or reseted)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (current_state==ESPS && ESTART_T1)
        begin
            next_state = ESP;
        end
    end

    always @(negedge write or reseted)
    begin: StateGen8

        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
        if (current_state==SERS_EXEC && write==1'b0 && EERR!=1'b1)
                if (DataLo==8'hB0)
                        next_state = ESPS;
        end
    end

    reg   erase_active = 1'b0;
    reg   erase_suspend = 1'b0;

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
         ->oe_event;
    end

    always @(AddressLatch)
    begin
         if(read)
            ->oe_event;
    end

    integer y;
    integer tmp;
    always @(oe_event)
    begin
        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
               DriveOut;
            end

            CFI, AS_CFI, ESP_CFI, ESP_AS_CFI :
            begin
                CFI_data = 16'bZ;
                if ((AddressLatch>=8'h10 && AddressLatch <=8'h3C) ||
                    (AddressLatch>=8'h40 && AddressLatch <= 8'h4F))
                     CFI_data[15:0] = CFI_array[AddressLatch];
                else
                    $display ("Invalid CFI query address");

                DOut_zd = CFI_data;
            end

            AS :
            begin
                Read_AS;
            end

            OTP:
            begin
                if (SA == 0 && Address <= SecSiSize)
                    if (SecSi[Address]== -1)
                        DOut_zd = 16'bx;
                    else
                        DOut_zd = SecSi[Address];
                else
                begin
                    DOut_zd = 16'bz;
                    $display("Invalid SecSi Address read");
                end
            end

            OTP_FP2:
            begin
                if (Address % 12'h100 == 8'h02 )
                    if (FactoryProt)
                         DOut_zd = 16'h98;
                    else
                         DOut_zd = 16'h18;
            end

            ERS :
            begin
                Read_EraseStatus;
                DOut_zd[7:0] = Status;
                DOut_zd[15 : 8] = 8'bz;
            end

            SERS :
            begin
                ///////////////////////////////////////////////////////////
                //read status - sector erase timeout
                ///////////////////////////////////////////////////////////
                Status[3] = 1'b0;
                DOut_zd[7:0] = Status;
                DOut_zd[15 : 8] = 8'bz;
            end

            ESPS :
            begin
                   ///////////////////////////////////////////////////////////
                   //read status / erase suspend timeout - stil erasing
                   ///////////////////////////////////////////////////////////
                  Read_EraseStatus;
                  DOut_zd[7:0] = Status;
                  DOut_zd[15 : 8] = 8'bz;
            end

            SERS_EXEC:
            begin
                 Read_EraseStatus;
                 DOut_zd[7:0] = Status;
                 DOut_zd[15 : 8] = 8'bz;
            end

            ESP :
            begin
                Readmem_EraseSuspend;
            end

            ESP_AS :
            begin
                Read_AS;
            end

           PGMS :
           begin
                Status[6] = ~Status[6]; //toggle
                Status[5] = 1'b0;
                DOut_zd[7:0] = Status;
                DOut_zd[15:8] = 8'bz;
            end
     endcase
    end
 end
//*******************************************

    always @(write or reseted)
    begin : Output_generation
        if (~reseted)
        begin
            ERS_ACT   = 1'b0;
            PGMS_ACT  = 1'b0;
            OTP_ACT   = 1'b0;
            ULBYPASS  = 1'b0;
            Ers_Queue = 0;
         end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                ERS_ACT   = 1'b0;
                PGMS_ACT  = 1'b0;
                OTP_ACT   = 1'b0;
                ULBYPASS  = 1'b0;
                Ers_Queue = 0;
                if (~write)
                begin
                end
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
            end

            PREL_ULBYPASS :
            begin
                ULBYPASS = 1'b1;
            end

            CFI, AS_CFI, ESP_CFI, ESP_AS_CFI  :
            begin
            end

            AS :
            begin
            end

            UNLOCK_RESET :
            begin
                if (~write)
                    if (DataLo==16'h00)
                    begin
                        ULBYPASS = 1'b0;
                    end
            end

            OTP:
            begin
                OTP_ACT = 1'b1;
            end

            OTP_A0SEEN:
            begin
                if (~write)
                    if (SA==0 && Address <= SecSiSize)
                    begin
                        if (FactoryProt)
                        begin
                            Status[7] = ~ DataLo[7];
                            PSTART = 1'b1;
                            PSTART = #1 1'b0;
                        end
                        else
                        begin
                            OTP_ACT = 1'b1;
                            WRData = Data;
                            WRAddress = Address;
                            Status[7] = ~DataLo[7];
                            Mem_tmp = SecSi[WRAddress];
                            SecSi[WRAddress] = -1;
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                        end
                    end
                    else
                        $display("Can not program to invalid SecSi Address");
           end

            A0SEEN , ESP_A0SEEN:
            begin
            if (~write)
                    if (~Sec_Prot[SA])
                    begin
                        WRData  = Data;
                        WRSA = SA;
                        WRAddress = Address;
                        Mem_tmp = Mem[WRSA*SecSize + WRAddress];
                        Mem[WRSA*SecSize + WRAddress] = -1;
                        Status[7] = ~ DataLo[7];
                        PSTART = 1'b1; //////////////////////!
                        PSTART <= #1 1'b0;
                    end
                    else
                    begin
                        Status[7] = ~ DataLo[7];
                        PSTART = 1'b1;
                        PSTART = #1 1'b0;
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
                    if (A_PAT_1 && DataLo == 16'h10)
                    //Start Chip Erase
                    begin
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_Queue = ~(0);
                        Status = 8'b00001000;
                        ESTART = 1'b1;
                        ESTART = #1 1'b0;
                        ERS_ACT = 1'b1;
                        erase_start = $time;
                    end
                else if (DataLo==16'h30)
                begin
                    //put selected sector to sec. ers. queue
                    //start timeout
                    ERS_ACT = 1'b1;
                    Ers_Queue = 0;
                    CTMOUT_in = 1'b1;
                    Ers_Queue[SA] = 1'b1;
                end
            end

            ERS :
            begin
            end

            SERS :
            begin
            if (~write)
                if (DataLo == 16'hB0)
                begin
                    //need to start erase process prior to suspend
                    CTMOUT_in = 1'b0;
                    ERES      = 1'b0;
                    ESTART    = 1'b1;
                    ESTART    = #1 1'b0;
                    ESUSP     = 1'b1;
                    ESUSP     = #1 1'b0;
                end
                else if (DataLo==16'h30)
                begin
                    Ers_Queue[SA] = 1'b1;

                    CTMOUT_in = 1'b0;
                    CTMOUT_in = #2 1'b1;
                end
                else
                begin
                    CTMOUT_in  = 1'b0;
                    Ers_Queue = 0;
                 end
            end

            SERS_EXEC :
            begin
                if (~write)
                    if (DataLo==8'hB0)
                    begin
                        ESTART_T1_in = 1'b1;
                        ESUSP = 1'b1;
                        ESUSP = #1 1'b0;
                    end
            end

            ESP :
            begin
                if (~write)
                    if (DataLo==16'h30)
                    begin
                        ERES = 1'b1;
                        ERES = #1 1'b0;
                    end
            end

            ESP_Z001 :
            begin
            end

            ESP_PREL :
            begin
            end

            ESP_AS :
            begin
            end

            PGMS :
            begin
                PGMS_ACT  = 1'b1;
            end
        endcase
        end
    end

//******************************
    always @(EERR or EDONE or current_state)
    begin : ERS2
    integer i;
    integer j;
    integer mem_ind;
    if (current_state==ERS)
    begin
        if (EERR!=1'b1)
        begin
            for (i=0;  i<=SecNum-1; i=i+1)
                if  (~Sec_Prot[i])
                begin
                     mem_ind = i*SecSize;
                     for (y=0;y<=SecSize -1 ;y=y+1)
                     begin
                         Mem[mem_ind + y] = -1;
                     end
                end

            if (EDONE)
            begin
                for (i=0;i<=SecNum-1;i=i+1)
                   if  (~Sec_Prot[i])
                   begin
                       mem_ind = i*SecSize;
                       for (y=0;y<=SecSize -1 ;y=y+1)
                       begin
                            Mem[mem_ind + y] = MaxData;
                       end
                   end
             end
         end
    end
    end

    always @(CTMOUT or current_state)
    begin : SERS2
        if (current_state==SERS)
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                ESTART_T1_in = 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                erase_start = $time;
                ESTART = 1'b1;
                ESTART = #1 1'b0;
            end
    end

    always @(ESTART_T1 or current_state)
    begin : ESPS2
        if (current_state==ESPS)
            if (ESTART_T1)
             begin
                ESTART_T1_in = 1'b0;
             end
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
    integer mem_ind;
    if (current_state==SERS_EXEC)
    begin
        if (EERR!=1'b1)
        begin
            for (i=0; i<=SecNum-1; i=i+1)
                if  (~Sec_Prot[i] && Ers_Queue[i])
                begin
                     mem_ind = i*SecSize;
                     for (y=0;y<=SecSize -1 ;y=y+1)
                         Mem[mem_ind + y] = -1;
                end

            if (EDONE)
            begin
                for (i=0;i<=SecNum-1;i=i+1)
                    if  (~Sec_Prot[i]&& Ers_Queue[i])
                    begin
                         mem_ind = i*SecSize;
                         for (y=0;y<=SecSize -1 ;y=y+1)
                         begin
                             Mem[mem_ind + y] = MaxData;
                         end
                    end
             end
         end
    end
    end

    always @( posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
    if (current_state==PGMS)
    begin
           if (~PERR)
                if  (PDONE)
                    if (Mem_tmp != -1)
                        if (~OTP_ACT)
                             Mem[WRSA*SecSize+WRAddress] = WRData & Mem_tmp;
                        else
                             SecSi[WRAddress] =  WRData & Mem_tmp;
                    else
                        if (~OTP_ACT)
                             Mem[WRSA*SecSize+WRAddress] = WRData ;
                        else
                             SecSi[WRAddress] = WRData;
    end
    end

    always @(gOE_n or gCE_n or RESETNeg or RST)
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
         begin
            DOut_zd = 16'bZ;
         end
    end

    always @(current_state or reseted)
    begin
        if (reseted)
        begin
            if (current_state==RESET)               RY_zd = 1'b1;
            else if (current_state==ERS)            RY_zd = 1'b0;
            else if (current_state==SERS)           RY_zd = 1'b1;
            else if (current_state==ESPS)           RY_zd = 1'b0;
            else if (current_state==SERS_EXEC)      RY_zd = 1'b0;
            else if (current_state==ESP)            RY_zd = 1'b1;
            else if (current_state==PREL_ULBYPASS)  RY_zd = 1'b1;
            else if (current_state==PGMS)           RY_zd = 1'b0;
            else RY_zd = 1'b1;
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
            CFI_array[16'h1B] = 16'h0030;
            CFI_array[16'h1C] = 16'h0036;
            CFI_array[16'h1D] = 16'h0000;
            CFI_array[16'h1E] = 16'h0000;
            CFI_array[16'h1F] = 16'h0004;
            CFI_array[16'h20] = 16'h0000;
            CFI_array[16'h21] = 16'h000A;
            CFI_array[16'h22] = 16'h0000;
            CFI_array[16'h23] = 16'h0005;
            CFI_array[16'h24] = 16'h0000;
            CFI_array[16'h25] = 16'h0004;
            CFI_array[16'h26] = 16'h0000;
            //device geometry definition
            CFI_array[16'h27] = 16'h0017;
            CFI_array[16'h28] = 16'h0000;
            CFI_array[16'h29] = 16'h0000;
            CFI_array[16'h2A] = 16'h0000;
            CFI_array[16'h2B] = 16'h0000;
            CFI_array[16'h2C] = 16'h0001;
            CFI_array[16'h2D] = 16'h007F;
            CFI_array[16'h2E] = 16'h0000;
            CFI_array[16'h2F] = 16'h0000;
            CFI_array[16'h30] = 16'h0001;
            CFI_array[16'h31] = 16'h0000;
            CFI_array[16'h32] = 16'h0000;
            CFI_array[16'h33] = 16'h0000;
            CFI_array[16'h34] = 16'h0000;
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
            CFI_array[16'h44] = 16'h0031;
            CFI_array[16'h45] = 16'h0001;
            CFI_array[16'h46] = 16'h0002;
            CFI_array[16'h47] = 16'h0004;
            CFI_array[16'h48] = 16'h0001;
            CFI_array[16'h49] = 16'h0004;
            CFI_array[16'h4A] = 16'h0000;
            CFI_array[16'h4B] = 16'h0000;
            CFI_array[16'h4C] = 16'h0000;
            CFI_array[16'h4D] = 16'h00B5;
            CFI_array[16'h4E] = 16'h00C5;
            CFI_array[16'h4F] = 16'h0000;
    end

    reg  BuffIn1, BuffIn2, BuffIn3, BuffIn4, BuffIn5, BuffIn6, BuffIn7,
        BuffIn8;
    wire BuffOut1,BuffOut2,BuffOut3,BuffOut4,BuffOut5,BuffOut6,BuffOut7,
        BuffOut8;

    VITALBuf  TPOW (BuffOut1, BuffIn1);
    VITALBuf  TPOU (BuffOut2, BuffIn2);
    VITALBuf  TSEO (BuffOut3, BuffIn3);
    VITALBuf  TREADY  (BuffOut4, BuffIn4);
    VITALBuf  TCTMOUT (BuffOut5, BuffIn5);
    VITALBuf  TESTART_T1(BuffOut7, BuffIn7);

    reg  BuffInOE, BuffInCE, BuffInADDR,  BuffInRESETDQ;
    wire BuffOutOE, BuffOutCE, BuffOutADDR,  BuffOutRESETDQ;

    VITALBuf    BUFOENeg   (BuffOutOE, BuffInOE);
    VITALBuf    BUFCENeg   (BuffOutCE, BuffInCE);
    VITALBuf    BUFA       (BuffOutADDR, BuffInADDR);
    VITALBuf    BUFRESETDQ (BuffOutRESETDQ, BuffInRESETDQ);

    initial
    begin
        BuffInOE   = 1'b1;
        BuffInCE   = 1'b1;
        BuffInADDR = 1'b1;
        BuffInRESETDQ= 1'b1;
    end

    time CEDQ_t, OEDQ_t, ADDRDQ_t, open_buf_t;

    time CENeg_event, OENeg_event, ADDR_event, LatchAddr_event;
    wire CE_en;
    reg  [15:0] TempData;
    reg  [15:0] CeData;
    reg  [15:0] AddrData;
    reg  from_address;
    wire  ADR_en;
    event fromAddr_event, fromCeOe_event;
    time OENeg_posEvent=0;
    time CENeg_posEvent=0;
    event addr_wait, ce_wait;

    always @(posedge BuffOutOE)
    begin
        OEDQ_01 = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CEDQ_01 = $time;
    end
    always @(BuffOutADDR)
    begin
        ADDRDQ_01 = $time;
    end
    always @(BuffOutRESETDQ)
    begin
        RESETDQ  = $time;
    end

    always @(negedge CENeg)
    begin
         CENeg_event = $time;
    end

    always @(negedge OENeg)
    begin
         OENeg_event = $time;
    end

    always @(posedge OENeg)
    begin
        OENeg_posEvent = $time;
    end
    always @(posedge CENeg)
    begin
        CENeg_posEvent = $time;
    end

    always @(A)
    begin
        ADDR_event = $time;
    end

    always @(DOut_zd)
    begin : OutputGen
        time  time_t;
        if (DOut_zd[0] !== 1'bz)
        begin
                close_buffer = 1'b0;
                CEDQ_t = CENeg_event  + CEDQ_01;
                OEDQ_t = OENeg_event  + OEDQ_01;
                ADDRDQ_t = ADDR_event + ADDRDQ_01;
                FROMADDR =((ADDRDQ_t >= CEDQ_t) && (ADDRDQ_t >= OEDQ_t) &&
                ( ADDRDQ_t > $time));
                FROMCE = ((CEDQ_t >= OEDQ_t) && (CEDQ_t >= $time));
                FROMOE = ((OEDQ_t > CEDQ_t) && (OEDQ_t >= $time));

                DOut_pass[15:0] = 16'hz;
                if(FROMCE && ~FROMOE && ~FROMADDR)
                begin
                   #(CEDQ_t - $time);
                end
                if( FROMADDR&& (FROMOE || FROMCE))
                begin
                    FROMADDR = 1'b0;
                    if (from_address == 1'b0)
                    begin
                       DOut_pass[15:0] = 16'hx;
                       #(ADDRDQ_t - $time);
                    end

                    from_address = 1'b1;
                end
                DOut_pass[15:0] = DOut_zd[15:0];
       end
    end

    always @(gCE_n, gOE_n)
    begin
        if(gCE_n == 1'b1 || gOE_n == 1'b1)
            from_address = 1'b0;
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
            close_buffer = 1'b1;
            DOut_pass <= DOut_zd;
        end
    end
endmodule

module VITALBuf ( OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
