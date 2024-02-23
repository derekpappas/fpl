//////////////////////////////////////////////////////////////////////////////
//  File name : am29lv2562m.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version: | author:       | mod date:    |  changes made:
//    V1.0     M.Radmanovic    04 Oct 20      Initial release
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        FLASH
//  Technology:     Flash Memory
//  Part:           am29lv2562m
//
//  Description:    512 Mbit(16Mb x 32-Bit/32Mb x 16-Bit)
//                        Uniform Sector Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am29lv2562m
(
    A23      ,
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

    DQ31     ,
    DQ30     ,
    DQ29     ,
    DQ28     ,
    DQ27     ,
    DQ26     ,
    DQ25      ,
    DQ24      ,
    DQ23      ,
    DQ22      ,
    DQ21      ,
    DQ20      ,
    DQ19      ,
    DQ18      ,
    DQ17      ,
    DQ16      ,
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
    WORDNeg  ,
    RY
);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
    input  A23  ;
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

    inout  DQ31  ;
    inout  DQ30  ;
    inout  DQ29  ;
    inout  DQ28  ;
    inout  DQ27  ;
    inout  DQ26  ;
    inout  DQ25  ;
    inout  DQ24  ;
    inout  DQ23  ;
    inout  DQ22  ;
    inout  DQ21  ;
    inout  DQ20  ;
    inout  DQ19  ;
    inout  DQ18  ;
    inout  DQ17  ;
    inout  DQ16  ;
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
    input  WORDNeg  ;
    output RY       ;

    parameter mem_file_name1   = "none";
    parameter prot_file_name   = "none";
    parameter secsi_file_name1 = "none";
    parameter UserPreload      = 1'b0;
    parameter TimingModel      = "DefaultTimingModel";
    parameter mem_file_name2   = "none";
    parameter secsi_file_name2 = "none";

// Instance of FLASH memory
am29lv2562m_flash  #(mem_file_name1,prot_file_name,secsi_file_name1,
                     UserPreload,TimingModel) FLASH_1
(
    .A23(A23)  ,
    .A22(A22)  ,
    .A21(A21)  ,
    .A20(A20)  ,
    .A19(A19)  ,
    .A18(A18)  ,
    .A17(A17)  ,
    .A16(A16)  ,
    .A15(A15)  ,
    .A14(A14)  ,
    .A13(A13)  ,
    .A12(A12)  ,
    .A11(A11)  ,
    .A10(A10)  ,
    .A9(A9)    ,
    .A8(A8)    ,
    .A7(A7)    ,
    .A6(A6)    ,
    .A5(A5)    ,
    .A4(A4)    ,
    .A3(A3)    ,
    .A2(A2)    ,
    .A1(A1)    ,
    .A0(A0)    ,
    .DQ15(DQ23),
    .DQ14(DQ22),
    .DQ13(DQ21),
    .DQ12(DQ20),
    .DQ11(DQ19),
    .DQ10(DQ18),
    .DQ9(DQ17)  ,
    .DQ8(DQ16)  ,
    .DQ7(DQ7)  ,
    .DQ6(DQ6)  ,
    .DQ5(DQ5)  ,
    .DQ4(DQ4)  ,
    .DQ3(DQ3)  ,
    .DQ2(DQ2)  ,
    .DQ1(DQ1)  ,
    .DQ0(DQ0)  ,
    .CENeg(CENeg),
    .OENeg(OENeg) ,
    .WENeg(WENeg)      ,
    .WPNeg(WPNeg)      ,
    .RESETNeg(RESETNeg),
    .WORDNeg(WORDNeg),
    .RY(RY));

// Instance of FLASH memory
am29lv2562m_flash  #(mem_file_name2,prot_file_name,secsi_file_name2,
                     UserPreload,TimingModel) FLASH_2
(
    .A23(A23)    ,
    .A22(A22)    ,
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
    .DQ15(DQ31)  ,
    .DQ14(DQ30)  ,
    .DQ13(DQ29)  ,
    .DQ12(DQ28)  ,
    .DQ11(DQ27)  ,
    .DQ10(DQ26)  ,
    .DQ9(DQ25)    ,
    .DQ8(DQ24)    ,
    .DQ7(DQ15)    ,
    .DQ6(DQ14)    ,
    .DQ5(DQ13)    ,
    .DQ4(DQ12)    ,
    .DQ3(DQ11)    ,
    .DQ2(DQ10)    ,
    .DQ1(DQ9)    ,
    .DQ0(DQ8)    ,
    .CENeg(CENeg),
    .OENeg(OENeg) ,
    .WENeg(WENeg)      ,
    .WPNeg(WPNeg)      ,
    .WORDNeg(WORDNeg),
    .RESETNeg(RESETNeg),
    .RY(RY));
endmodule

////////////////////////////////////////////////////
// Timing model for FLASH component of am29lv2562m_flash
////////////////////////////////////////////////////

// Instance of FLASH memory
module am29lv2562m_flash
(
    A23      ,
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
    RESETNeg ,
    WPNeg    ,
    WORDNeg  ,
    RY

);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
    input  A23  ;
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
    input  RESETNeg ;
    input  WPNeg    ;
    input  WORDNeg  ;
    output RY       ;

// interconnect path delay signals
    wire  A23_ipd  ;
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

    wire [23 : 0] A;
    assign A = {A23_ipd,
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
    assign DOut ={DQ15,
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
    wire  WORDNeg_ipd  ;

    reg ESUSP_out   = 0; // Start Erase Suspend TimeOut
    reg ESUSP_in    = 0;
    reg PSUSP_out   = 0; // Start rase Suspend TimeOut
    reg PSUSP_in    = 0;
    reg CTMOUT      = 0; // Sector Erase TimeOut
    reg CTMOUT_in   = 0;
    reg READY_in    = 0;
    reg READY       = 0; // Device ready after reset

    reg [15 : 0] DOut_zd;

    wire  DQ15_Pass   ;
    wire  DQ14_Pass   ;
    wire  DQ13_Pass   ;
    wire  DQ12_Pass   ;
    wire  DQ11_Pass   ;
    wire  DQ10_Pass   ;
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
            DQ0_Pass } = DOut_Pass;

    reg RY_zd = 1;

    parameter mem_file_name   = "am29lv2562m.mem";
    parameter prot_file_name  = "am29lv2562m_prot.mem";
    parameter secsi_file_name = "am29lv2562m_secsi.mem";
    parameter UserPreload     = 1'b1;

    parameter TimingModel = "defaulttimingmodel";

    parameter PartID    = "am29lv2562m";
    parameter MaxData   = 16'hFF;
    parameter SecSize   = 16'hFFFF;
    parameter SecSiSize = 255;
    parameter SecNum    = 511;
    parameter HiAddrBit = 23;

    //Address of the Protected Sector
    integer  ProtSecNum = -1;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ; ////Unlock Bypass Active
    reg OTP_ACT  ; ////SecSi access
    reg PSP_ACT  ; ////Program Suspend
    reg ESP_ACT  ; ////Erase Suspend
    integer LCNT ; ////Load Counter  0-31

    ////number of location to be writen in Write Buffer: 0-31 WORDs.
    ////if 32 word/WORD programming
    integer PCNT  ;  //0-32

    reg PDONE    ; ////Prog. Done
    reg PSTART   ; ////Start Programming
    reg PSUSP    ; ////Suspend programming
    reg PRES     ; ////Resume Programming
    //Program location is in protected sector
    reg PERR     ;

    reg EDONE    ; ////Ers. Done
    reg ESTART   ; ////Start Erase
    reg ESUSP    ; ////Suspend Erase
    reg ERES     ; ////Resume Erase
    //All sectors selected for erasure are protected
    reg EERR     ;
    //Sectors selected for erasure
    reg [SecNum:0] Ers_queue;

    //Command Register
    reg write ;
    reg read  ;

    reg read_page       = 1'b0;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum

    integer SA      = 0;         // 0 TO SecNum
    integer WBPage  = 0;
    //Address within sector
    integer Address = 0;         // 0 - SecSize
    integer SecSiAddr= 0;
    integer SubAddr = 0;

    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    integer Addr ;         //0 TO 16'h7FF#

    integer WPage;         //0 TO 16'h7FF#

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;
    reg WORD ;

    //Sector Protection Status
    reg [511:0] Sec_Prot;
    //SecSi ProtectionStatus
    reg FactoryProt = 1;

    // timing check violation
    reg Viol = 1'b0;

    integer Mem[0:(SecNum+1)*(SecSize+1)-1];
    integer CFI_array[16:80];
    integer SecSi[0:SecSiSize];

    integer WBData[0:31];
    integer WBAddr[0:31];

    integer BaseLoc = 0;
    event MergeE;

    integer cnt = 0;

    reg Sec_Prot_reg  = 1'b0;

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
   time OENeg_posEvent;
   time CENeg_posEvent;
   time OENeg_event;
   time CENeg_event;
   time ADDR_event;
   time WORDNeg_event;
   reg FROMOE;
   reg FROMCE;
   reg FROMADDR;
   integer   OEDQ_01;
   integer   CEDQ_01;
   integer   ADDRDQ_01;
   reg[15:0] TempData;
   wire read_inpage;
   wire read_nopage;
   wire word_inpage;
   wire word_nopage;
   assign read_inpage = FROMADDR & read_page;
   assign read_nopage = FROMADDR & ~read_page;
   assign word_inpage = FROMADDR & read_page  && ~WORD;
   assign word_nopage = FROMADDR & ~read_page && ~WORD;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////

 buf   (A23_ipd, A23);
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
 buf   (RESETNeg_ipd , RESETNeg );
 buf   (WPNeg_ipd    , WPNeg    );
 buf   (WORDNeg_ipd  , WORDNeg  );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ15,  DQ15_Pass  , 1);
    nmos   (DQ14,  DQ14_Pass  , 1);
    nmos   (DQ13,  DQ13_Pass  , 1);
    nmos   (DQ12,  DQ12_Pass  , 1);
    nmos   (DQ11,  DQ11_Pass  , 1);
    nmos   (DQ10,  DQ10_Pass  , 1);
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

    nmos   (RY  ,   1'b0   , ~RY_zd);

    wire deg;

    //VHDL VITAL CheckEnable equivalents
    // Address setup/hold near WE# falling edge
    wire CheckEnable_A0_WE;
    assign CheckEnable_A0_WE = ~CENeg & OENeg;
    // Data setup/hold near WE# rising edge
    wire CheckEnable_DQ0_WE;
    assign CheckEnable_DQ0_WE = ~CENeg & OENeg & deg;
    // Address setup/hold near CE# falling edge
    wire CheckEnable_A0_CE;
    assign CheckEnable_A0_CE = ~WENeg & OENeg;
    // Data setup/hold near CE# rising edge
    wire CheckEnable_DQ0_CE;
    assign CheckEnable_DQ0_CE = ~WENeg & OENeg & deg;
    // Address setup/hold near OE# falling edge when toggle
    wire CheckEnable_A0_OE;
    assign  CheckEnable_DQ0_CE = ~CENeg & (ESP_ACT | PSP_ACT);

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

        // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1; //tRP
     specparam           tpw_WENeg_negedge       =1; //tWP
     specparam           tpw_WENeg_posedge       =1; //tWPH
     specparam           tpw_CENeg_negedge       =1; //tCP
     specparam           tpw_CENeg_posedge       =1; //tCEPH
     specparam           tpw_A0_negedge          =1; //tWC tRC

        // tdevice values: values for internal delays
            //Effective Write Buffer Program Operation  tWHWH1
     specparam   tdevice_WBPB                    = 7500;     //7500 ns;
             //Program Operation
     specparam   tdevice_POW                     = 60000;    //60 us;
            //Unlock bypass Program Operation
     specparam   tdevice_POU                     = 54000;     //54 us;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_SEO                     = 500000000; //500 ms;
            //Timing Limit Exceeded
     specparam   tdevice_HANG                    = 2000000000;//2 sec;
            //program/erase suspend timeout
     specparam   tdevice_ESUSP                   = 20000;     //20 us;
            //program/erase suspend timeout
     specparam   tdevice_PSUSP                   = 15000;     //15 us;
            //sector erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 50000;     //50 us;
            //device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 20000;     //20 us;

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
    (CENeg => RY) = tpd_CENeg_RY;
    (WENeg => RY) = tpd_WENeg_RY;

    if (FROMCE) (CENeg => DQ0 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ1 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ2 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ3 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ4 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ5 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ6 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ7 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ8 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ9 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ10 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ11 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ12 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ13 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ14 ) = tpd_CENeg_DQ0;
    if (FROMCE) (CENeg => DQ15 ) = tpd_CENeg_DQ0;

    if (FROMOE)( OENeg => DQ0  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ1  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ2  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ3  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ4  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ5  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ6  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ7  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ8  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ9  ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ10 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ11 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ12 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ13 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ14 ) = tpd_OENeg_DQ0;
    if (FROMOE)( OENeg => DQ15 ) = tpd_OENeg_DQ0;

    if (~RESETNeg)( RESETNeg => DQ0 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ1 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ2 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ3 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ4 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ5 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ6 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ7 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ8 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ9 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ10) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ11) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ12) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ13) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ14) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)( RESETNeg => DQ15) = tpd_RESETNeg_DQ0;

    if (read_nopage)
        (A0 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A0 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A1 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A1 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A2 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A2 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A3 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A3 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A4 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A4 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A5 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A5 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A6 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A6 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A7 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A7 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A8 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A8 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A9 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A9 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A10 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A10 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A11 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A11 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A12 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A12 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A13 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A13 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A14 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A14 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A15 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A15 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A16 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A16 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A17 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A17 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A18 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A18 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A19 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A19 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A20 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A20 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A21 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A21 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A22 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A22 => DQ15)    = tpd_A0_DQ0;

    if (read_nopage)
        (A23 => DQ0)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ1)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ2)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ3)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ4)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ5)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ6)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ7)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ8)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ9)     = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ10)    = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ11)    = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ12)    = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ13)    = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ14)    = tpd_A0_DQ0;
    if (read_nopage)
        (A23 => DQ15)    = tpd_A0_DQ0;

    if (word_nopage)
        (DQ15 => DQ0)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ1)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ2)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ3)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ4)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ5)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ6)     = tpd_A0_DQ0;
    if (word_nopage)
        (DQ15 => DQ7)     = tpd_A0_DQ0;

    if (read_inpage)
        (A0 => DQ0)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ1)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ2)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ3)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ4)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ5)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ6)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ7)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ8)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ9)     = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ10)    = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ11)    = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ12)    = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ13)    = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ14)    = tpd_A0_DQ0;
    if (read_inpage)
        (A0 => DQ15)    = tpd_A0_DQ0;

    if (read_inpage)
        (A1 => DQ0)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ1)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ2)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ3)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ4)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ5)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ6)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ7)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ8)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ9)     = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ10)    = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ11)    = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ12)    = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ13)    = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ14)    = tpd_A0_DQ0;
    if (read_inpage)
        (A1 => DQ15)    = tpd_A0_DQ0;

    if (word_inpage)
        (DQ15 => DQ0)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ1)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ2)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ3)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ4)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ5)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ6)     = tpd_A0_DQ0;
    if (word_inpage)
        (DQ15 => DQ7)     = tpd_A0_DQ0;

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
    $setup ( A10, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A11, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A12, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A13, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A14, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A15, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A16, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A17, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A18, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A19, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A20, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A21, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A22, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);
    $setup ( A23, negedge CENeg &&& CheckEnable_A0_CE, tsetup_A0_CENeg, Viol);

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
    $setup ( A10, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A11, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A12, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A13, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A14, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A15, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A16, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A17, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A18, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A19, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A20, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A21, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A22, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);
    $setup ( A23, negedge WENeg &&& CheckEnable_A0_WE, tsetup_A0_CENeg, Viol);

    $setup ( A0 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A1 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A2 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A3 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A4 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A5 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A6 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A7 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A8 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A9 , negedge OENeg &&& CheckEnable_A0_OE,   tsetup_A0_CENeg, Viol);
    $setup ( A10, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A11, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A12, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A13, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A14, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A15, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A16, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A17, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A18, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A19, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A20, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A21, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A22, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);
    $setup ( A23, negedge OENeg &&& CheckEnable_A0_OE, tsetup_A0_CENeg, Viol);

    $setup ( DQ0 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ1 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ2 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ3 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ4 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ5 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ6 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ7 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ8 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ9 , posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg, Viol);
    $setup ( DQ10, posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg,Viol);
    $setup ( DQ11, posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg,Viol);
    $setup ( DQ12, posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg,Viol);
    $setup ( DQ13, posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg,Viol);
    $setup ( DQ14, posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg,Viol);
    $setup ( DQ15, posedge CENeg &&& CheckEnable_DQ0_CE, tsetup_A0_CENeg,Viol);

    $setup ( DQ0 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ1 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ2 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ3 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ4 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ5 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ6 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ7 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ8 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ9 , posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ10, posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ11, posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ12, posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ13, posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ14, posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);
    $setup ( DQ15, posedge WENeg &&& CheckEnable_DQ0_WE, tsetup_A0_CENeg, Viol);

    $setup ( OENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);
    $setup ( CENeg   , negedge WENeg , tsetup_A0_CENeg, Viol);

    $hold ( posedge RESETNeg &&& (CENeg===1), CENeg,thold_CENeg_RESETNeg, Viol);
    $hold ( posedge RESETNeg &&& (OENeg===1), OENeg,thold_CENeg_RESETNeg, Viol);
    $hold ( posedge RESETNeg &&& (WENeg===1), WENeg,thold_CENeg_RESETNeg, Viol);

    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A0 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A1 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A2 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A3 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A4 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A5 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A6 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A7 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A8 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A9 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A10 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A11 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A12 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A13 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A14 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A15 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A16 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A17 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A18 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A19 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A20 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A21 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A22 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& CheckEnable_A0_CE, A23 , thold_A0_CENeg, Viol);

    $hold ( negedge WENeg, A0 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A1 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A2 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A3 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A4 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A5 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A6 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A7 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A8 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A9 &&& CheckEnable_A0_WE,  thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A10&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A11&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A12&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A13&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A14&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A15&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A16&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A17&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A18&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A19&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A20&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A21&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A22&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, A23&&& CheckEnable_A0_WE , thold_A0_CENeg, Viol);

    $hold ( negedge CENeg, DQ0 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ1 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ2 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ3 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ4 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ5 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ6 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ7 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ8 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ9 &&& CheckEnable_DQ0_CE,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ10&&& CheckEnable_DQ0_CE , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ11&&& CheckEnable_DQ0_CE , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ12&&& CheckEnable_DQ0_CE , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ13&&& CheckEnable_DQ0_CE , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ14&&& CheckEnable_DQ0_CE , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg, DQ15&&& CheckEnable_DQ0_CE ,   thold_A0_CENeg, Viol);

    $hold ( negedge WENeg, DQ0 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ1 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ2 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ3 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ4 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ5 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ6 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ7 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ8 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ9 &&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ10&&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ11&&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ12&&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ13&&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ14&&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);
    $hold ( negedge WENeg, DQ15&&& CheckEnable_DQ0_WE,   thold_A0_CENeg, Viol);

    $hold ( posedge WENeg, CENeg , thold_WENeg_OENeg, Viol);
    $hold ( posedge CENeg, WENeg , thold_WENeg_OENeg, Viol);
    $hold ( posedge OENeg, CENeg , thold_WENeg_OENeg, Viol);

    $hold ( posedge WENeg, OENeg , thold_OENeg_WENeg, Viol);
    $hold ( posedge OENeg, WENeg , thold_WENeg_OENeg, Viol);

    $width (negedge RESETNeg, tpw_RESETNeg_negedge);

    $width (posedge WENeg, tpw_WENeg_posedge);
    $width (negedge WENeg, tpw_WENeg_negedge);
    $width (posedge CENeg, tpw_CENeg_posedge);
    $width (negedge CENeg, tpw_CENeg_negedge);

    $width (posedge A0 , tpw_A0_negedge);
    $width (posedge A1 , tpw_A0_negedge);
    $width (posedge A2 , tpw_A0_negedge);
    $width (posedge A3 , tpw_A0_negedge);
    $width (posedge A4 , tpw_A0_negedge);
    $width (posedge A5 , tpw_A0_negedge);
    $width (posedge A6 , tpw_A0_negedge);
    $width (posedge A7 , tpw_A0_negedge);
    $width (posedge A8 , tpw_A0_negedge);
    $width (posedge A9 , tpw_A0_negedge);
    $width (posedge A10, tpw_A0_negedge);
    $width (posedge A11, tpw_A0_negedge);
    $width (posedge A12, tpw_A0_negedge);
    $width (posedge A13, tpw_A0_negedge);
    $width (posedge A14, tpw_A0_negedge);
    $width (posedge A15, tpw_A0_negedge);
    $width (posedge A16, tpw_A0_negedge);
    $width (posedge A17, tpw_A0_negedge);
    $width (posedge A18, tpw_A0_negedge);
    $width (posedge A19, tpw_A0_negedge);
    $width (posedge A20, tpw_A0_negedge);
    $width (posedge A21, tpw_A0_negedge);
    $width (posedge A22, tpw_A0_negedge);
    $width (posedge A23, tpw_A0_negedge);

    $width (negedge A0 , tpw_A0_negedge);
    $width (negedge A1 , tpw_A0_negedge);
    $width (negedge A2 , tpw_A0_negedge);
    $width (negedge A3 , tpw_A0_negedge);
    $width (negedge A4 , tpw_A0_negedge);
    $width (negedge A5 , tpw_A0_negedge);
    $width (negedge A6 , tpw_A0_negedge);
    $width (negedge A7 , tpw_A0_negedge);
    $width (negedge A8 , tpw_A0_negedge);
    $width (negedge A9 , tpw_A0_negedge);
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
    $width (negedge A21, tpw_A0_negedge);
    $width (negedge A22, tpw_A0_negedge);
    $width (negedge A23, tpw_A0_negedge);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET                =6'd0;
 parameter Z001                 =6'd1;
 parameter PREL_SETBWB          =6'd2;
 parameter PREL_ULBYPASS        =6'd3;
 parameter ESP_ULBYPASS         =6'd4;
 parameter PREL_ULBYPASS_RESET  =6'd5;
 parameter ESP_ULBYPASS_RESET   =6'd6;
 parameter CFI                  =6'd7;
 parameter AS                   =6'd8;
 parameter AS_CFI               =6'd9;
 parameter A0SEEN               =6'd10;
 parameter OTP                  =6'd11;
 parameter OTP_Z001             =6'd12;
 parameter OTP_PREL             =6'd13;
 parameter OTP_EXIT             =6'd14;
 parameter OTP_A0SEEN           =6'd15;
 parameter C8                   =6'd16;
 parameter C8_Z001              =6'd17;
 parameter C8_PREL              =6'd18;
 parameter ERS                  =6'd19;
 parameter SERS                 =6'd20;
 parameter ESPS                 =6'd21;
 parameter SERS_EXEC            =6'd22;
 parameter ESP                  =6'd23;
 parameter ESP_SETBWB           =6'd24;
 parameter PSP_SETBWB           =6'd25;
 parameter ESP_Z001             =6'd26;
 parameter PSP_Z001             =6'd27;
 parameter ESP_A0SEEN           =6'd28;
 parameter ESP_AS               =6'd29;
 parameter PSP_AS               =6'd30;
 parameter ESP_CFI              =6'd31;
 parameter PSP_CFI              =6'd32;
 parameter ESP_AS_CFI           =6'd33;
 parameter PSP_AS_CFI           =6'd34;
 parameter PGMS                 =6'd35;
 parameter PSPS                 =6'd36;
 parameter PSP                  =6'd37;
 parameter WBPGMS_WBCNT         =6'd38;
 parameter WBPGMS_WBLSTA        =6'd39;
 parameter WBPGMS_WBLOAD        =6'd40;
 parameter WBPGMS_CONFB         =6'd41;
 parameter WBPGMS_WBABORT       =6'd42;
 parameter WBPGMS_Z001          =6'd43;
 parameter WBPGMS_PREL          =6'd44;

 reg [6:0] current_state;
 reg [6:0] next_state;

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

//TOP OR BOTTOM arch model is used
//assumptions:
//1. TimingModel has format as
//"AM29LV2562M(H/L)120RPII
    integer i;
    initial
    begin : TimeModelSet
        reg[19*8:1] tmp_timing;
        reg[7:0] tmp_char;
        integer found;
        integer j;
        tmp_timing = TimingModel;//copy of TimingModel
        i = 20;
        found = 0;
        while ((i >= 0) && (found != 1))// search for first non null character
        begin                           // i keeps position of first non
            j = 7;                      // null character
            while ((j >= 0) && (found != 1))
            begin
                if (tmp_timing[i*8+j] != 1'd0)
                    found = 1;
                else
                    j = j-1;
            end
            i = i - 1;
        end
        i = i + 1;

        if (found)   //if non null character is found
        begin
            for (j=0;j<=7;j=j+1)
                tmp_char[j] = TimingModel[(i-11)*8+j];
        end

        if (tmp_char == "H" || tmp_char == "h")
        begin
            ProtSecNum = SecNum;
        end
        else
            ProtSecNum = 0;
    end

// initialize memory and load preload files if any
    initial
    begin: InitMemory
    integer i,j;
    integer sector_preload[0:SecSize];
    reg     sector_prot   [0:134];
    integer secure_silicon[0:SecSiSize];

        for (i=0;i<=((SecNum+1)*(SecSize+1)-1);i=i+1)
        begin
            Mem[i] = MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
           sector_prot[i]=0;
           Ers_queue[i] = 0;
        end

        for (i=0;i<=SecSiSize;i=i+1)
        begin
           secure_silicon[i]=MaxData;
        end

        //- Sector protection preload
        //am29lv2562m_prot.mem sector protect file
        //   /       - comment
        //   @sss  - <sss> stands for sector number
        //   d    - <d> is bit to be written at SecProt(sss++)
        //             (ss is incremented at every load)
        //             (At last position(134) is factory protection)
        //   only first 1-4 columns are loaded. NO empty lines !!!!!!!!!!!!!
        if (UserPreload && !(prot_file_name == "none"))
        begin
           $readmemb(prot_file_name,sector_prot);
        end

        // - Memory  preload
        // am29lv2562m.mem memory  file
        // // - comment
        // @aaaaaaa - <aaaaaaa> stands for sector address
        // dd - <dd> is byte to be written at Mem(aaaaaaa++)
        //   (aaaaaaa is incremented at every load)
        if (UserPreload && !(mem_file_name == "none"))
        begin
           $readmemh(mem_file_name,Mem);
        end

        // - Secsi  preload
        // am29lv2562m_secsi.mem secsi file
        // // - comment
        // @aa - <aa> stands for sector address
        // dd - <dd> is byte to be written at SecSi(aa++)
        //   (aa is incremented at every load)
        if (UserPreload && !(secsi_file_name == "none"))
        begin
           $readmemh(secsi_file_name,secure_silicon);
        end

        for (i=4;i<=507;i=i+1)
        begin
            Sec_Prot[i]  = sector_prot[(i/4)+3];
        end
        Sec_Prot[0]  = sector_prot[0];
        Sec_Prot[1]  = sector_prot[1];
        Sec_Prot[2]  = sector_prot[2];
        Sec_Prot[3]  = sector_prot[3];
        Sec_Prot[508]= sector_prot[130];
        Sec_Prot[509]= sector_prot[131];
        Sec_Prot[510]= sector_prot[132];
        Sec_Prot[511]= sector_prot[133];
        FactoryProt  = sector_prot[134];

        for (i=0;i<=31;i=i+1)
        begin
                WBData[i] = 0;
                WBAddr[i] = -1;
        end
        for (i=0;i<=SecSiSize;i=i+1)
        begin
            SecSi[i] = secure_silicon[i];
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

    always @(WORDNeg)
    begin
        WORD = WORDNeg;
    end

    initial
    begin
        write    = 1'b0;
        read     = 1'b0;
        Addr   = 0;
        WPage  = 0;

        ULBYPASS = 1'b0;
        OTP_ACT  = 1'b0 ;
        PSP_ACT  = 1'b0 ;
        ESP_ACT  = 1'b0 ;
        LCNT  = 0 ;

        PCNT  = 0;

        PDONE    = 1'b1;
        PSTART   = 1'b0;
        PSUSP    = 1'b0;
        PRES     = 1'b0;

        PERR     = 1'b0;

        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;

        EERR     = 1'b0;
        READY_in = 1'b0;
        READY    = 1'b0;
        end

   always @(posedge ESUSP_in)
   begin:ESUSP1
     #tdevice_ESUSP ESUSP_out = ESUSP_in;
   end
   always @(negedge ESUSP_in)
   begin:ESUSP2
     disable ESUSP1;
     #1 ESUSP_out = ESUSP_in;
   end

   always @(posedge PSUSP_in)
   begin:PSUSP1
     #tdevice_PSUSP PSUSP_out = PSUSP_in;
   end
   always @(negedge PSUSP_in)
   begin:PSUSP2
     disable PSUSP1;
     #1 PSUSP_out = PSUSP_in;
   end

   always @(posedge CTMOUT_in)
   begin:CTMOUT1
     #tdevice_CTMOUT CTMOUT = CTMOUT_in;
   end
   always @(negedge CTMOUT_in)
   begin:CTMOUT2
     disable CTMOUT1;
     #1 CTMOUT = CTMOUT_in;
   end

   always @(posedge READY_in)
   begin:READY1
     #tdevice_READY READY = READY_in;
   end
   always @(negedge READY_in)
   begin:READY2
     disable READY1;
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
    always @(negedge WORDNeg)
    begin
        WORDNeg_event = $time;
    end
    always @(A)
    begin
        ADDR_event = $time;
    end
    always @(DIn[15])
    begin
        if (WORDNeg === 0)
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
                READY_in = 1'b0;
                R = 1'b0;
                E = 1'b1;
            end
         end
end

always @(next_state or RESETNeg or CENeg or RST or READY or PoweredUp)
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

////////////////////////////////////////////////////////////////////////////
////Glitch Protection: Inertial Delay does not propagate pulses <5ns
////////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd;
    assign #5 gCE_n = CENeg_ipd;
    assign #5 gOE_n = OENeg_ipd;

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

/////////////////////////////////////////////////////////////////////////////
////Latch address on falling edge of WE# or CE# what ever comes later
////Latches data on rising edge of WE# or CE# what ever comes first
//// also Write cycle decode
/////////////////////////////////////////////////////////////////////////////
    integer A_tmp  ;
    integer SA_tmp ;
    integer A_tmp1 ;
    integer A_tmp2 ;

    reg CE;

    always @(CENeg_ipd or WENeg_ipd or OENeg_ipd or MergeE or write)
    begin
         A_tmp  =  A[10:0];
         A_tmp2  =  A[7:0];
         SA_tmp =  A[HiAddrBit:15];
         WPage   <= A_tmp1 / 32;
    end

    always @(WENeg_ipd)
    begin
    if (reseted)
    begin
        if (~WENeg_ipd && ~CENeg_ipd && OENeg_ipd )
        begin
            A_tmp  =  A[10:0];
            A_tmp2  =  A[7:0];
            SA_tmp =  A[HiAddrBit:15];

            if (~WORD)
                A_tmp1 = { A[14:0],DIn[15] };
            else
                A_tmp1 = { A[14:0],1'b0};

           WPage   <= A_tmp1 / 32;

           Address = A_tmp1;
           Addr   = A_tmp;
           SecAddr = SA_tmp;
           SubAddr<=A_tmp2;

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
            A_tmp2  =  A[7:0];
            SA_tmp =  A[HiAddrBit:15];

            if (~WORD)
                A_tmp1 = { A[14:0],DIn[15] };
            else
                A_tmp1 = { A[14:0],1'b0};

           Address = A_tmp1;
           Addr   = A_tmp;
           SubAddr<=A_tmp2;
           SecAddr = SA_tmp;
           WPage   <= A_tmp1 / 32;

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
                A_tmp2  =  A[7:0];
                SA_tmp =  A[HiAddrBit:15];

                if (~WORD)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

              SecAddr = SA_tmp;
              Address = A_tmp1;
               Addr   = A_tmp;
              SubAddr<=A_tmp2;
              WPage   <= A_tmp1 / 32;

            end

                SecAddr = SA_tmp;
                Address = A_tmp1;
                SubAddr<=A_tmp2;
                WPage   <= A_tmp1 / 32;

                CE = CENeg;
                Addr   = A_tmp;

        end
    end

   always @(A or WORD)
   begin
        if (reseted)
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
                -> MergeE;
   end

   always @(DIn)
   begin
        if (reseted)
            if (~WORD && WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
                 -> MergeE;
    end

   always @(MergeE)
   begin
                A_tmp  =  A[10:0];
                A_tmp2  =  A[7:0];
                SA_tmp =  A[HiAddrBit:15];
                if (~WORD)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

                SecAddr = SA_tmp;
                Address = A_tmp1;
                SubAddr<=A_tmp2;

                WPage   <= A_tmp1 / 32;
                CE = CENeg;
                Addr   = A_tmp;

   end

    always @(posedge write)
    begin
                A_tmp  =  A[10:0];
                A_tmp2  =  A[7:0];
                SA_tmp =  A[HiAddrBit:15];
                if (~WORD)
                    A_tmp1 = { A[14:0],DIn[15] };
                else
                    A_tmp1 = { A[14:0],1'b0};

        SecAddr = SA_tmp;
        CE = CENeg;
        Addr   = A_tmp;
        Address = A_tmp1;
        WPage   <= A_tmp1 / 32;
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
                if (((Sec_Prot[SA] == 0 &&(Ers_queue[SA]== 0 || ESP_ACT == 0))
                   && (OTP_ACT == 0 )) ||
                   (FactoryProt == 0 && OTP_ACT == 1))
                begin
                    if (PCNT<32)  //buffer
                    begin
                        if (WORDNeg) cnt_write = PCNT+2;
                        else cnt_write = PCNT+1;
                        duration_write = cnt_write* tdevice_WBPB;
                    end
                    else   //Word/DWord program
                        if (ULBYPASS == 1)
                            duration_write = tdevice_POU;
                        else
                            duration_write = tdevice_POW;
                    elapsed_write = 0;
                    PDONE = 1'b0;
                    ->pdone_event;
                    start_write   = $time;
                end
                else
                begin
                    PERR = 1'b1;
                    PERR <= #1000 1'b0;
                end
            end
         end
    end

    always @(reseted or PSUSP)
    begin
        if (reseted)
        begin
        if (PSUSP & ~PDONE)
        begin
            disable pdone_process;
            elapsed_write  = $time - start_write;
            duration_write = duration_write - elapsed_write;
            PDONE = 1'b0;
        end
        end
    end

    always @(reseted or PRES)
    begin
        if (reseted)
        begin
        if (PRES & ~PDONE)
        begin
            start_write = $time;
            ->pdone_event;
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

/////////////////////////////////////////////////////////////////////////////
//// Main Behavior Process
//// combinational process for next state generation
/////////////////////////////////////////////////////////////////////////////
        reg PATTERN_1  = 1'b0;
        reg PATTERN_2  = 1'b0;
        reg A_PAT_1  = 1'b0;

        //DATA  High WORD
        integer DataHi   ;
        //DATA Low WORD
        integer DataLo   ;

        always @(negedge write)
        begin
            DataLo = DIn[7:0];
            if (WORDNeg)
                DataHi = DIn[15:8];

            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55) ;
            A_PAT_1   = ((Addr==16'h555) && ~ULBYPASS) || ULBYPASS;
        end

    always @(write or reseted)
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

            CFI :
            begin
                if (DataLo==8'hF0)
                    next_state = RESET;
                else
                    next_state =  CFI;
            end

            PREL_SETBWB :
            begin
                if (A_PAT_1 && (DataLo==16'h20))
                    next_state = PREL_ULBYPASS;
                else if  (A_PAT_1 && (DataLo==8'h90))
                    next_state = AS;
                else if (A_PAT_1 && (DataLo==8'hA0))
                    next_state = A0SEEN;
                else if (A_PAT_1 && (DataLo==8'h88))
                    next_state = OTP;
                else if (A_PAT_1 && (DataLo==8'h80))
                    next_state = C8;
                else if (DataLo==8'h25)
                    next_state = WBPGMS_WBCNT;
                else
                    next_state = RESET;
            end

            PREL_ULBYPASS :
            begin
                if (DataLo == 8'h90 )
                    next_state = PREL_ULBYPASS_RESET;
                else if (A_PAT_1 && (DataLo == 8'hA0))
                    next_state = A0SEEN;
                else
                    next_state = PREL_ULBYPASS;
            end

            PREL_ULBYPASS_RESET :
            begin
                if (DataLo == 8'h00 )
                    next_state = RESET;
                else
                    next_state = PREL_ULBYPASS;
            end

            WBPGMS_WBCNT :
            begin
                if ((SecAddr == SA) &&
                   ((~WORDNeg && DataLo<32) ||
                    (WORDNeg && DataLo<16)))
                    next_state = WBPGMS_WBLSTA;
                else
                    next_state = WBPGMS_WBABORT;
            end

            WBPGMS_WBLSTA :
            begin
                if (SecAddr == SA)
                    if (LCNT>0)
                        next_state = WBPGMS_WBLOAD;
                    else
                        next_state = WBPGMS_CONFB;
                else
                    next_state = WBPGMS_WBABORT;
            end

            WBPGMS_WBLOAD :
            begin
                if (WPage==WBPage)
                    if (LCNT>0)
                        next_state = WBPGMS_WBLOAD;
                    else
                        next_state = WBPGMS_CONFB;
                else
                    next_state = WBPGMS_WBABORT;
            end

            WBPGMS_CONFB :
            begin
                if ((SecAddr == SA) && (DataLo == 8'h29))
                    next_state = PGMS;
                else
                    next_state = WBPGMS_WBABORT;
            end

            WBPGMS_WBABORT :
            begin
                if (PATTERN_1)
                    next_state = WBPGMS_Z001;
            end

            WBPGMS_Z001 :
            begin
                if (PATTERN_2)
                    next_state = WBPGMS_PREL;
                else
                    next_state = WBPGMS_WBABORT;
            end

            WBPGMS_PREL :
            begin
                if (DataLo == 8'hF0)
                begin
                    if (ESP_ACT)
                        next_state = ESP;
                    else if (OTP_ACT)
                        next_state = OTP;
                    else
                        next_state = RESET;
                end
                else
                    next_state = WBPGMS_WBABORT;
            end

            AS :
            begin
                if (DataLo==8'hF0)
                    next_state = RESET;
                else if ((Addr==8'h55) && (DataLo==8'h98))
                    next_state = AS_CFI;
                else
                    next_state = AS;
            end

            AS_CFI :
            begin
                if (DataLo==8'hF0)
                    next_state = AS;
                else
                    next_state =  AS_CFI;
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
                    next_state = OTP;
            end

            OTP_PREL :
            begin
                if (A_PAT_1 && (DataLo == 8'h90))
                    next_state = OTP_EXIT;
                else if (DataLo == 8'h25)
                    next_state = WBPGMS_WBCNT;
                else if (A_PAT_1 && (DataLo == 8'hA0)&& (PSP_ACT != 1))
                    next_state = OTP_A0SEEN;
                else
                    next_state = OTP;
            end

            OTP_EXIT :
            begin
                if (DataLo == 8'h00)
                    if (PSP_ACT == 1)
                        next_state = PSP;
                    else if (ESP_ACT == 1)
                        next_state = ESP;
                    else
                        next_state = RESET;
                else
                    next_state <= OTP;
            end

            OTP_A0SEEN :
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
                if (A_PAT_1 && (DataLo==8'h10))
                    next_state = ERS;
                else if (DataLo==8'h30)
                    next_state = SERS;
                else
                    next_state = RESET;
            end

            SERS :
            begin
                if (~CTMOUT)
                if (DataLo == 8'hB0)
                    next_state = ESP; // ESP according to datasheet
                else if (DataLo==8'h30)
                    next_state = SERS;
                else
                    next_state = RESET;
            end

            SERS_EXEC :
            begin
                if (DataLo == 8'hB0)
                    next_state = ESPS;
            end

            ESP :
            begin
                if (DataLo == 8'h30)
                    next_state = SERS_EXEC;
                else
                begin
                    if ((Addr == 8'h55) && (DataLo == 8'h98))
                        next_state = ESP_CFI;
                    else if (PATTERN_1)
                        next_state = ESP_Z001;
                end
            end

            PSP :
            begin
                if (DataLo == 8'h30)
                    next_state = PGMS;
                else
                begin
                    if ((Addr == 8'h55) && (DataLo == 8'h98))
                        next_state = PSP_CFI;
                    else if (PATTERN_1)
                        next_state = PSP_Z001;
                end
            end

            ESP_ULBYPASS:
            begin
                if (DataLo == 8'hA0)
                    next_state = ESP_A0SEEN;
                else if (DataLo == 8'h90)
                    next_state = ESP_ULBYPASS_RESET;
            end

            ESP_ULBYPASS_RESET:
            begin
                if (DataLo == 8'h00)
                    next_state = ESP;
                else
                    next_state = ESP_ULBYPASS;
            end

            ESP_Z001 :
            begin
                if (PATTERN_2)
                    next_state = ESP_SETBWB;
                else
                    next_state = ESP;
            end

            PSP_Z001 :
            begin
                if (PATTERN_2)
                    next_state = PSP_SETBWB;
                else
                    next_state = PSP;
            end

            ESP_SETBWB :
            begin
                if (A_PAT_1 && (DataLo == 8'h20))
                    next_state = ESP_ULBYPASS;
                else if (DataLo == 16'h25)
                    next_state = WBPGMS_WBCNT;
                else if (A_PAT_1 && DataLo == 8'hA0)
                    next_state = ESP_A0SEEN;
                else if (A_PAT_1 && DataLo == 8'h90)
                    next_state = ESP_AS;
                else if (A_PAT_1 && DataLo == 8'h88)
                    next_state = OTP;
                else
                    next_state = ESP;
            end

            PSP_SETBWB :
            begin
                if (A_PAT_1 && DataLo == 8'h90)
                    next_state = PSP_AS;
                else if (A_PAT_1 && DataLo == 8'h88)
                    next_state = OTP;
                else
                    next_state = PSP;
            end

            ESP_CFI:
            begin
                if (DataLo == 8'hF0)
                    next_state = ESP;
                else
                    next_state = ESP_CFI;
            end

            PSP_CFI:
            begin
                if (DataLo == 8'hF0)
                    next_state = PSP;
                else
                    next_state = PSP_CFI;
            end

            ESP_A0SEEN :
            begin
                  next_state = PGMS;
            end

            ESP_AS :
            begin
                if (DataLo == 8'hF0)
                    next_state = ESP;
                else if ((Addr == 8'h55) && (DataLo == 8'h98))
                    next_state = ESP_AS_CFI;
            end

            PSP_AS :
            begin
                  if (DataLo == 8'hF0)
                      next_state = PSP;
                  else if ((Addr == 8'h55) && (DataLo == 8'h98))
                      next_state = PSP_AS_CFI;
            end

            ESP_AS_CFI:
            begin
                if (DataLo == 8'hF0)
                    next_state = ESP_AS;
                else
                    next_state = ESP_AS_CFI;
            end

            PSP_AS_CFI:
            begin
                if (DataLo == 8'hF0)
                    next_state = PSP_AS;
                else
                    next_state = PSP_AS_CFI;
            end

            PGMS :
            begin
            if ((PERR!=1'b1) && (DataLo==8'hB0)&& (OTP_ACT != 1)&&
                (Ers_queue[SecAddr]!= 1))
                next_state = PSPS;
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
                   if  (ULBYPASS == 1)
                       next_state = ESP_ULBYPASS;
                   else if (OTP_ACT)
                       next_state = OTP;
                   else
                       next_state = ESP;
               else if  (ULBYPASS == 1)
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
                next_state = RESET;

        end
    end

    always @(negedge write or reseted)
    begin: StateGen7
    integer i,j;
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
           if (current_state==SERS_EXEC &&
           ((write==1'b0) && (EERR!=1'b1)) && (DataLo==8'hB0))
            begin
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
            if ((current_state==SERS) && (CTMOUT))
                next_state = SERS_EXEC;
        end
    end

   always @(posedge ESUSP_out or reseted)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if ((current_state==ESPS) && (ESUSP_out))
                next_state = ESP;
    end

    always @(posedge PSUSP_out or reseted)
    begin: StateGen8
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==PSPS)&& (PSUSP_out))
                next_state = PSP;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
      ->oe_event;
    end

    always @(DIn[15])
    begin
        if ((WORD==0) && read)
         begin
             ->oe_event;
         end
    end

    always @(Address or SecAddr or read)
    begin
        if (read )
             ->oe_event;
    end

    always @(WORD)
    begin
        if (~CENeg && ~OENeg )
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

        OTP :
            begin
                if (oe)
                begin
                    //read SecSi Sector Region
                    SecSiAddr = Address %(SecSiSize +1);
                    DOut_zd[7:0] = 8'bx;
                    if (SecSi[SecSiAddr]!= -1)
                        DOut_zd[7:0] = SecSi[SecSiAddr];

                    if (WORDNeg)
                        begin
                            DOut_zd[15:8]= 8'bx;
                            if (SecSi[SecSiAddr+1]!=-1)
                                DOut_zd[15:8] = SecSi[SecSiAddr+1];
                        end
               end
           end

        CFI, AS_CFI, ESP_CFI, PSP_CFI, ESP_AS_CFI, PSP_AS_CFI :
        begin
            if (oe)
                begin
                if ((Addr >= 16'h10 && Addr <= 16'h3C) ||
                        (Addr >= 16'h40 && Addr <= 16'h50))
                    begin
                        if (CFI_array[Addr] != -1)
                        begin
                            DOut_zd[15:0] = CFI_array[Addr];
                            if (WORDNeg  == 0)
                                DOut_zd[15:8] = 8'hzz;
                            if (~WORDNeg && !((Address % 2) == 0))
                                DOut_zd[7 : 0] <= 8'hzz;
                        end
                        else
                        begin
                        $display("Invalid CFI query address");
                        DOut_zd = 16'hzzzz;
                        end
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
                DOut_zd[7:0] = Status[7:0];
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
                DOut_zd[7:0] = Status[7:0];
            end
        end

        ESPS :
        begin
            if (oe)
            begin
                ///////////////////////////////////////////////////////////
                //read status / erase suspend timeout - stil erasing
                ///////////////////////////////////////////////////////////
                if (Ers_queue[SecAddr]==1'b1)
                begin
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                end
                else
                    Status[7] = 1'b1;
                Status[6] = ~Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                DOut_zd[7:0] = Status[7:0];
            end
        end

        PSPS :
        begin
            if (oe)
            begin
            ////////////////////////////////////////////////////////
            ///////////read status
            ///////////////////////////////////////////////////////
             Status[6] = ~Status[6]; //toggle
             Status[5] = 1'b0;
             Status[1] = 1'b0;
             DOut_zd[7:0] = Status[7:0];

             if (SecAddr == SA)
                 DOut_zd[7]  = Status[7];
             else
                 DOut_zd[7]  = ~Status[7];
            end
        end

        WBPGMS_WBABORT :
        begin
            if (oe)
            begin
            ///////////////////////////////////////////////////////////////
            //read status / write buffer abort
            ///////////////////////////////////////////////////////////////
            Status[6] = ~Status[6]; //toggle
            Status[5] = 1'b0;
            Status[1] = 1'b1;

            DOut_zd[7:0] = Status[7:0];
            end
        end

         SERS_EXEC:
         begin
            if (oe)
            begin
            ///////////////////////////////////////////////////////
            ///read status Erase Busy
            ///////////////////////////////////////////////////////
            if (Ers_queue[SecAddr] == 1)
                begin
                    Status[7] = 0;
                    Status[2] = ~Status[2]; //toggle
                end
                else
                    Status[7] = 1;
                Status[6] = ~Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;

                DOut_zd[7:0] = Status[7:0];
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

                DOut_zd[7:0] = Status[7:0];
                end
            end
        end

        PSP :
        begin
            if (oe)
            begin
            ///////////////////////////////////////////////////////////
            //read
            ///////////////////////////////////////////////////////////
            if ((Ers_queue[SecAddr]!=1'b1) && (SecAddr != SA))
                begin
                    MemRead(DOut_zd);
                end
            else if (Ers_queue[SecAddr]== 1'b1)
                begin
                ///////////////////////////////////////////////////////
                //read status
                ///////////////////////////////////////////////////////
                Status[7] = 1'b1;
                // Status[6) No toggle
                Status[5] = 1'b0;
                Status[2] = ~Status[2]; //toggle

                DOut_zd[7:0] = Status[7:0];
                end
            end
        end

        AS, ESP_AS, PSP_AS :
        begin
            if (oe)
            begin
              if (SubAddr == 0)
                  DOut_zd[15:0] = 16'h0001;
              else if (SubAddr == 1)
                  DOut_zd[15:0] = 16'h227E;
              else if (SubAddr == 14)
                  DOut_zd[15:0] = 16'h2212;
              else if (SubAddr == 15)
                  DOut_zd[15:0] = 16'h2201;

              else if (SubAddr == 2)
              begin
                  DOut_zd[15:0] = 16'b0000;
                  DOut_zd[0] = Sec_Prot[SecAddr];
              end

              else if (SubAddr == 3)
              begin
                  DOut_zd[15:0] = 16'h0000;
                  DOut_zd[3:0]  = 4'h8;
                  DOut_zd[7]  = FactoryProt;
                  DOut_zd[4]  = (ProtSecNum/SecNum);
              end
              if (WORDNeg === 0)
                 DOut_zd[15:8] = 8'hzz;
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
            DOut_zd[7:0] = Status[7:0];
            if (SecAddr == SA)
                DOut_zd[7]  = Status[7];
            else
                DOut_zd[7]  = ~Status[7];
            end
        end
        endcase
    end
    end

    always @( write or reseted)
    begin : Output_generation
    if (~reseted)
        begin
            ESP_ACT     = 1'b0;
            OTP_ACT     = 1'b0;
            ULBYPASS    = 1'b0;
            Ers_queue   = 0;
         end

    if (reseted)
    begin
        case (current_state)
            RESET:
            begin
                OTP_ACT   = 1'b0;
                PSP_ACT   = 1'b0;
                ESP_ACT   = 1'b0;
                Ers_queue = 0;
                //ready signal active
                RY_zd = 1'b1;
              end

            PREL_SETBWB :
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==16'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==8'h90))
                        ULBYPASS = 1'b0;
                    else if (A_PAT_1 && (DataLo==8'h88))
                    begin
                        OTP_ACT  = 1'b1;
                    end
                    else if (DataLo==8'h25)
                        //fix Sector Address SA
                        SA = SecAddr;
                end
            end

            PREL_ULBYPASS_RESET, ESP_ULBYPASS_RESET:
            begin
                if (~write)
                   if (DataLo == 8'h00)
                       ULBYPASS = 1'b0;
            end

            OTP_PREL :
            begin
                if (~write)
                begin
                    if (DataLo==8'h25)
                    begin
                        SA = 0;
                        if (SecAddr!=0)
                            $display( "Invalid sector address in SecSi mode");
                    end
                end
            end

            OTP_EXIT :
            begin
                if (DataLo == 8'h00)
                    OTP_ACT = 0;
            end

            A0SEEN, OTP_A0SEEN, ESP_A0SEEN :
            begin
                if (~write)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    PSUSP  = 1'b0;
                    PRES   = 1'b0;
                    PCNT   = 32;
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
                    WBAddr[0] = Address % 32;
                    if  (OTP_ACT != 1)
                        WBPage = WPage;
                    else
                        WBPage = WPage % 8;
                    SA = SecAddr;
                    temp = DataLo;
                    Status[7]  = ~temp[7];
                    if (OTP_ACT == 1)
                    begin
                        if (SecAddr != 0)
                             $display("Invalid sector Address in SecSi");
                        if (Address >= 256)
                        begin
                            $display("Invalid program address in SecSi");
                            $display("Adress= %d", Addr);
                        end
                    end

                    if (WORDNeg)
                        WBAddr[1] = WBAddr[0] +1;
                    else
                        WBAddr[1] = -1;
                 end
            end

            C8_PREL :
            begin
                if (~write)
                    if (A_PAT_1 && (DataLo==8'h10))
                    begin
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_queue = ~(0);
                        Status[7:0] = 8'b00001000;
                    end
                    else if (DataLo==8'h30)
                    begin
                        //put selected sector to sec. ers. queue
                        //start timeout
                        Ers_queue = 0;
                        Ers_queue[SecAddr] = 1'b1;
                        disable CTMOUT1;
                        CTMOUT_in = 1'b0;
                        #1 CTMOUT_in <= 1'b1;
                    end
            end

            SERS :
            begin
            if (~write && ~CTMOUT)
            begin
                if (DataLo == 8'hB0)
                begin
                   //need to start erase process prior to suspend
                    CTMOUT_in = 1'b0;
                    ERES      = 1'b0;
                    ESTART    = 1'b1;
                    ESTART    = #1 1'b0;
                    ESUSP     = 1'b1;
                    ESUSP     = #1 1'b0;
                end
                else if (DataLo==8'h30)
                begin
                    disable CTMOUT1;
                    CTMOUT_in = 1'b0;
                    #1 CTMOUT_in <= 1'b1;
                    Ers_queue[SecAddr] = 1'b1;
                    CTMOUT_in = 1'b0;
                end
                else
                begin
                    CTMOUT_in  = 1'b0;
                    Ers_queue = 0;
                end
            end
            end

            SERS_EXEC :
            begin
            if (~write)
                if ((~EDONE && (EERR!=1'b1)) && (DataLo==8'hB0))
                   begin
                    ESUSP_in = 1'b1;
                    ESUSP = 1'b1;
                    ESUSP = #1 1'b0;
                   end
            end

            WBPGMS_WBCNT :
              begin
                if (~write)
                    if ((SecAddr == SA) &&
                       ((~WORDNeg && DataLo<32) ||
                        (WORDNeg && DataLo<16)))
                    begin
                        cnt = DataLo;
                        if (WORDNeg)
                            cnt = cnt *2;

                        PCNT = cnt;
                        LCNT = cnt;
                    end
               end

              WBPGMS_WBLSTA :
              begin
                if (~write)
                begin
                    if(SecAddr == SA)
                    begin
                        if (Viol!=1'b0)
                        begin
                            WBData[cnt] = -1;
                            Viol = 1'b0;
                        end
                        else
                            WBData[cnt] = DataLo;
                        WBAddr[cnt] = Address % 32;

                        if (WORDNeg)
                        begin
                            if (Viol!=1'b0)
                            begin
                                WBData[cnt+1] = -1;
                                Viol = 1'b0;
                            end
                            else
                                WBData[cnt+1] = DataHi;

                            WBAddr[cnt+1] = (Address % 32) +1;
                            if (cnt>0)
                                cnt = cnt -1;
                        end

                        if (cnt>0)
                            cnt = cnt -1;
                        //save last loaded data for data polling
                        temp = DataLo;
                        Status[7] = ~temp[7];

                        if (OTP_ACT)
                            WBPage = WPage % 8;
                        else
                            WBPage = WPage;

                        if (WPage>=8)
                        $display("Invalid Write Buffer Page selected in SecSi");

                    end
                    LCNT = cnt;
                 end
                 end

              WBPGMS_WBLOAD :
              begin
                if (~write)
                begin
                    if (WPage == WBPage)
                    begin
                        if (Viol!=1'b0)
                        begin
                            WBData[cnt] = -1;
                            Viol = 1'b0;
                        end
                        else
                            WBData[cnt] = DataLo;

                        WBAddr[cnt] = Address % 32;
                        if (WORDNeg)
                        begin
                            if (Viol!=1'b0)
                            begin
                                WBData[cnt+1] = -1;
                                Viol = 1'b0;
                            end
                            else
                                WBData[cnt+1] = DataHi;

                            WBAddr[cnt+1] = (Address % 32) +1;
                            if (cnt>0)
                                cnt = cnt -1;
                        end

                        if (cnt>0)
                            cnt = cnt -1;

                        //save last loaded data for data polling

                        temp = DataLo;
                        Status[7] = ~temp[7];
                    end
                    LCNT = cnt;
                 end
                 end

              WBPGMS_CONFB :
              begin
                if (~write)
                    if ((SecAddr == SA) && (DataLo == 8'h29))
                    begin
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                        PSUSP  = 1'b0;
                        PRES   = 1'b0;
                    end
               end

              WBPGMS_WBABORT :
              begin
                if (~write)
                    if (PATTERN_1)
                //busy signal active
                RY_zd = 1'b0;
              end

              WBPGMS_PREL :
              begin
                if (~write)
                    if (DataLo == 8'hF0)
                    begin
                        PSP_ACT = 1'b0;
                    end
               end

            ESP :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h30)
                    begin
                        //resume erase
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                    end
                end
            end

            PSP :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h30)
                    begin
                        //resume erase
                        PRES = 1'b1;
                        PRES <= #1 1'b0;
                        PSP_ACT = 0;
                    end
                end
            end

            ESP_SETBWB:
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo == 8'h20))
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==8'h88))
                        OTP_ACT  = 1'b1;
                    else if (DataLo == 8'h25)
                        SA = SecAddr;
                end
            end

            AS :
            begin
                if (~write)
                    if (DataLo==8'hF0)
                        ULBYPASS  = 1'b0;
            end

             PGMS :
             begin
                if ((~write)&& (OTP_ACT == 0))
                    if (~PDONE)
                        if (DataLo == 8'hB0)
                        begin
                            PSUSP_in = 1'b1;
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
                if (current_state==WBPGMS_WBABORT) RY_zd = 1'b0;
                if (current_state==ESP) RY_zd = 1'b1;
                if (current_state==SERS_EXEC) RY_zd = 1'b0;
                if (current_state==PSP) RY_zd = 1'b1;
                if (current_state==ERS) RY_zd = 1'b0;
                if (current_state==PGMS) RY_zd = 1'b0;
                if (current_state==PSPS) RY_zd = 1'b0;
                if (current_state==OTP) RY_zd = 1'b1;
                if (current_state==ESPS) RY_zd = 1'b0;

    end

    always @(EERR or EDONE or current_state)
    begin : ERS2
    integer i;
    integer j;
        if (current_state==ERS)
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if ((Sec_Prot[i]!=1'b1) &&(EERR!=1'b1))
                        for (j=0;j<=SecSize;j=j+1)
                            Mem[sa(i)+j] = -1;
                end
                if ((EDONE)&&(EERR!=1'b1))
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        if (Sec_Prot[i]!=1'b1)
                             for (j=0;j<=SecSize;j=j+1)
                                 Mem[sa(i)+j] = MaxData;
                    end
          end
    end

    always @(CTMOUT or current_state)
    begin : SERS2
        if (current_state==SERS && CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                ESUSP_in = 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
                ESTART = 1'b1;
                ESTART = #1 1'b0;
            end
    end

    always @(ESUSP_out or current_state)
    begin : ESPS2
        if (current_state==ESPS && ESUSP_out)
            begin
                ESP_ACT = 1'b1;
                ESUSP_in = 1'b0;
            end
    end

    always @(EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
        if (current_state==SERS_EXEC)
        begin
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
        end
    end

    always @(current_state or posedge PDONE)
    begin: PGMS2
    integer i,j;
        if (current_state==PGMS)
            begin
                if (PERR!=1'b1)
                begin
                BaseLoc = WBPage * 32;

                if (PCNT < 32)   //buffer
                begin
                    wr_cnt = PCNT;
                    if (WORDNeg)
                        wr_cnt= wr_cnt+1;
                end
                else   //Word/WORD program
                begin
                    wr_cnt = 0;
                    if (WORDNeg)
                        wr_cnt =1;
                end
                for (i=wr_cnt;i>=0;i=i-1)
                begin
                    new_int= WBData[i];
                    if (OTP_ACT!=1'b1)   //mem write
                        old_int=Mem[sa(SA)+BaseLoc+WBAddr[i]];
                    else
                        old_int=SecSi[BaseLoc+WBAddr[i]];

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

                        WBData[i]= new_int;
                    end
                    else
                        WBData[i]= -1;
                end
                for (i=wr_cnt;i>=0;i=i-1)
                begin
                    if (OTP_ACT!=1'b1)   //mem write
                    begin
                        Mem[sa(SA)+BaseLoc+WBAddr[i]] = -1;
                    end
                    else
                        SecSi[BaseLoc+WBAddr[i]]   = -1;

                end

                if (PDONE && ~PSTART)
                for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1)
                            if (OTP_ACT!=1'b1)   //mem write
                                Mem[sa(SA)+BaseLoc+WBAddr[i]] = WBData[i];
                            else //SecSi write
                                SecSi[BaseLoc+WBAddr[i]]   = WBData[i];

                        else
                            $display("WriteBuffer Address error");
                        WBData[i]= -1;
                    end
            end
        end
    end

        always @(current_state or PSUSP_out)
        begin: PSPS2
                if (current_state==PSPS)
                begin
                if (PSUSP_out)
                begin
                    PSUSP_in = 1'b0;
                    PSUSP = 1'b1;
                    PSUSP <= #1 1'b0;
                end
                //busy signal active
                RY_zd = 1'b0;
                PSP_ACT = 1;
        end
    end

    always @(gOE_n or gCE_n or RESETNeg or RST or WORDNeg)
    begin
        //Output Disable Control
        if (gOE_n || gCE_n ||(~RESETNeg && ~RST))
            DOut_zd = 16'hzzzz;
        else
            if (~WORDNeg)
                DOut_zd[15:8] = 8'bzz;
    end

    always @(WPNeg)
    begin
        //Hardware Write Protection
        if (~WPNeg)
        begin
            Sec_Prot_reg = Sec_Prot[ProtSecNum];
            Sec_Prot[ProtSecNum] = 1'b1;
        end
        else
            Sec_Prot[ProtSecNum] = Sec_Prot_reg;
    end

    initial
    begin
    ///////////////////////////////////////////////////////////////////////
    //CFI array data
    ///////////////////////////////////////////////////////////////////////
    //CFI query identification string
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
    CFI_array[16'h1F] = 16'h0007;
    CFI_array[16'h20] = 16'h0007;
    CFI_array[16'h21] = 16'h000A;
    CFI_array[16'h22] = 16'h0000;
    CFI_array[16'h23] = 16'h0001;
    CFI_array[16'h24] = 16'h0005;
    CFI_array[16'h25] = 16'h0004;
    CFI_array[16'h26] = 16'h0000;
    //device geometry definition
    CFI_array[16'h27] = 16'h0019;
    CFI_array[16'h28] = 16'h0002;
    CFI_array[16'h29] = 16'h0000;
    CFI_array[16'h2A] = 16'h0005;
    CFI_array[16'h2B] = 16'h0000;
    CFI_array[16'h2C] = 16'h0001;
    CFI_array[16'h2D] = 16'h01FF;
    CFI_array[16'h2E] = 16'h0001;
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
    CFI_array[16'h44] = 16'h0033;
    CFI_array[16'h45] = 16'h0008;
    CFI_array[16'h46] = 16'h0002;
    CFI_array[16'h47] = 16'h0001;
    CFI_array[16'h48] = 16'h0001;
    CFI_array[16'h49] = 16'h0004;
    CFI_array[16'h4A] = 16'h0000;
    CFI_array[16'h4B] = 16'h0000;
    CFI_array[16'h4C] = 16'h0001;
    CFI_array[16'h4D] = 16'h00B5;
    CFI_array[16'h4E] = 16'h00C5;
    CFI_array[16'h4F] = 16'h0000 + (16'h0001 * (4+(ProtSecNum/SecNum)));
    CFI_array[16'h50] = 16'h0001;
    end

    ///////////////////////////////////////////////////////////////////////////
    //Read Page signal
    ///////////////////////////////////////////////////////////////////////////
    reg[HiAddrBit-2 : 0] Address_page;
    always@ (posedge read)
    begin : PD_PAGE1
         Address_page = A[HiAddrBit : 2];
    end

    always@ (negedge read, A, WORD, DIn[15])
    begin : PD_PAGE2
       if(read)
       begin
          if (A[HiAddrBit : 2] == Address_page)
             read_page = 1'b1;
          else
          begin
             read_page    = 1'b0;
             Address_page = A[HiAddrBit : 2];
          end
       end
       else
           read_page = 1'b0;
    end

  ////////////////////////////////////////////////////////////////////////////
  // Data Output delay Block
  ////////////////////////////////////////////////////////////////////////////
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

    task MemRead;
    inout [15:0] DOut_zd;
    begin
        if (Mem[sa(SecAddr)+Address]==-1)
            DOut_zd[7:0] = 8'bxx;
        else
            DOut_zd[7:0] = Mem[sa(SecAddr)+Address];
        if (WORDNeg)
            if (Mem[sa(SecAddr)+Address+1]==-1)
                DOut_zd[15:8]= 8'bxx;
            else
                DOut_zd[15:8] = Mem[sa(SecAddr)+Address+1];
    end
    endtask

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
                if (~WORD)
                    DOut_Pass[15:8] = 8'hzz;
                else
                    DOut_Pass[15:8] = 8'hxx;
                DOut_Pass[7:0] = 8'hxx;
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
endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule