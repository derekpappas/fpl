//////////////////////////////////////////////////////////////////////////////
//  File name : am42bds6408g.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  | author:        | % date:   | changes made:
//    V1.0     J.Bogosavljevic  04 Feb 26   Initial release
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Multi-Chip packeg
//  Part:           am42bds6408g
//
//  Description:    64Mbit (4Mx16bit) Simultaneous opration, Burst mode Flash
//                  Memory and
//                  8Mbit (512Kx16bit) Static RAM
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am42bds6408g
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

    CENeg    ,
    CE1Negs  ,
    CE2s     ,
    OENeg    ,
    WENeg    ,
    RESETNeg ,
    LBNegs   ,
    UBNegs   ,
    CLK      ,
    AVDNeg   ,
    WPNeg    ,
    ACC      ,
    RDY

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

    input  CENeg    ;
    input  CE1Negs  ;
    input  CE2s     ;
    input  OENeg    ;
    input  WENeg    ;
    input  RESETNeg ;
    input  LBNegs   ;
    input  UBNegs   ;
    input  CLK      ;
    input  AVDNeg   ;
    input  WPNeg    ;
    input  ACC      ;
    output RDY      ;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter sram_file_name   = "none";
    parameter TimingModel = "DefaultTimingModel";

    flash_64 #(UserPreload,
               mem_file_name,
               TimingModel)
    U1
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

    CENeg    ,
    OENeg    ,
    WENeg    ,
    RESETNeg ,
    CLK      ,
    AVDNeg   ,
    WPNeg    ,
    ACC      ,
    RDY

);

    sram_8 #(UserPreload,
              sram_file_name,
              TimingModel)
    U2
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

    CE1Negs  ,
    CE2s     ,
    OENeg    ,
    WENeg    ,

    LBNegs   ,
    UBNegs

);
endmodule
//////////////////////
//MODULE DACLARATION
//////////////////////

module flash_64
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

    CENeg    ,
    OENeg    ,
    WENeg    ,
    RESETNeg ,
    CLK      ,
    AVDNeg   ,
    WPNeg    ,
    ACC      ,
    RDY

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

    input  CENeg    ;
    input  OENeg    ;
    input  WENeg    ;
    input  RESETNeg ;
    input  CLK      ;
    input  AVDNeg   ;
    input  WPNeg    ;
    input  ACC      ;
    output RDY      ;

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
    wire  CLK          ;
    wire  AVDNeg       ;
    wire  WPNeg        ;
    wire  ACC          ;

//  internal delays
    reg START_T1    ; // Start TimeOut
    reg START_T1_in ;
    reg CTMOUT      ; // Sector Erase TimeOut
    reg CTMOUT_in   ;
    reg READY_in    ;
    reg READY       ; // Device ready after reset

    wire  DQ15_z  ;
    wire  DQ14_z  ;
    wire  DQ13_z  ;
    wire  DQ12_z  ;
    wire  DQ11_z  ;
    wire  DQ10_z  ;
    wire  DQ9_z   ;
    wire  DQ8_z   ;
    wire  DQ7_z   ;
    wire  DQ6_z   ;
    wire  DQ5_z   ;
    wire  DQ4_z   ;
    wire  DQ3_z   ;
    wire  DQ2_z   ;
    wire  DQ1_z   ;
    wire  DQ0_z   ;

    reg [15 : 0] Dout_zd;
    reg [15 : 0] Dout_z;
    assign {DQ15_z,
            DQ14_z,
            DQ13_z,
            DQ12_z,
            DQ11_z,
            DQ10_z,
            DQ9_z,
            DQ8_z,
            DQ7_z,
            DQ6_z,
            DQ5_z,
            DQ4_z,
            DQ3_z,
            DQ2_z,
            DQ1_z,
            DQ0_z  } = Dout_z;

    reg RDY_zd;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID     = "flash";
    parameter BankNum    = 3;
    parameter MaxData    = 16'hFFFF;
    parameter MemSize    = 24'h3FFFFF;
    parameter SecSize_l  = 16'h7FFF;
    parameter SecSize_s  = 16'h1FFF;
    parameter SecNum     = 133;
    parameter BootSecNum = 7;
    parameter HiAddrBit  = 21;
    parameter HiConfBit  = 19;
    parameter LoConfBit  = 12;

    parameter MinCfiAddr  = 16'h10;
    parameter MaxCfiAddr  = 16'h5b;

    // scale divedes time needed for sector erase when LongTimming is FALSE
    // scale must be less then:
    // 2000 for min delays ->scale = 1900 -> tse = 105.2 us
    // 4000 for typ delays->scale = 3800 -> tse = 105.2 us
    // 50 000 for max delays->scale = 47600 -> tse = 105.4 us
    //otherwise sector erase time is shorter then 100 us
    parameter scale       = 1900;
//    parameter scale       = 3900;
//    parameter scale       = 47600;

    //varaibles to resolve if bottom or top architecture is used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found;

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
    reg EERR0    ;
    reg EERR1    ;
    reg EERR2    ;
    reg EERR3    ;

    //Sectors selected for erasure
    reg [SecNum:0] Ers_Queue; // = SecNum'b0;

    //Command Register
    reg write ;
    reg read  ;

    //Sector Address
    integer SecAddr;//            = 0;         // 0 - SecNum
    integer SA;//                 = 0;         // 0 TO SecNum
    //Address within sector
    integer Address;//             = 0;         // 0 - SecSize
    reg [HiConfBit:0] CR_Addr;//    = 0;
    reg [HiAddrBit:0] Whole_Addr;// = 0;

    reg LA;//                      = 1'b0;

    reg [HiConfBit:0] ConfRegData;

//    integer D_tmp0; //0 TO MaxData;

    integer Addr = 0 ;         //0 TO 16'h7FF#
    integer Addr_cnt;

    reg enable_cnt = 1;

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer tIACC_cnt_dwn;
//    integer tmp_tIACC;
    reg bound_cross;
    reg bound_cross_active;
    reg CLK_active;//wire???

    reg Dout_zd_burst;
    integer LB_P;
    integer LB_A;
    integer LB_Ei [0:BankNum];

    integer BA;
    integer burst_mode;

    integer Mem[0:MemSize];
    //Sector Protection Status
    reg[SecNum:0] Sec_Prot; //= SecNum'b0;

    integer CFI_array[MinCfiAddr:MaxCfiAddr];

    // timing check violation
    reg Viol = 1'b0;
    //Address of variable size sector (bottom or top boot sector)
    reg     vs;
    integer first_prot;
    reg reduced_hnd;
    integer max_wrap_thr;
/////////////////

    reg oe = 1'b0;
    event oe_event;

    event MergeE;

    //Status reg.
    reg[7:0] Status = 8'b0;

    reg[15:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    reg[7:0] temp;

    integer i,j,k;

   //TPD_XX_DATA
    time OEDQ_t;
    time CEDQ_t;
    time ADDRDQ_t;
    time OEDQ_open_t;
    time CEDQ_open_t;
    time ADDRDQ_open_t;

    time OENeg_event;
    time CENeg_event;
    time ADDR_event;
    time wait_time;

    reg FROMOE;
    reg FROMCE;

    integer Open3state = 0;

    integer ADDRDQ_01;
    integer OEDQ_1z;
    integer CEDQ_1z;

    integer WBData;
    integer WBAddr;

    reg[15:0] TempData;
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
    buf   (CLK_ipd      , CLK      );
    buf   (AVDNeg_ipd   , AVDNeg   );
    buf   (WPNeg_ipd    , WPNeg    );
    buf   (ACC_ipd      , ACC      );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ15,   DQ15_z , 1);
    nmos   (DQ14,   DQ14_z , 1);
    nmos   (DQ13,   DQ13_z , 1);
    nmos   (DQ12,   DQ12_z , 1);
    nmos   (DQ11,   DQ11_z , 1);
    nmos   (DQ10,   DQ10_z , 1);
    nmos   (DQ9 ,   DQ9_z  , 1);
    nmos   (DQ8 ,   DQ8_z  , 1);
    nmos   (DQ7 ,   DQ7_z  , 1);
    nmos   (DQ6 ,   DQ6_z  , 1);
    nmos   (DQ5 ,   DQ5_z  , 1);
    nmos   (DQ4 ,   DQ4_z  , 1);
    nmos   (DQ3 ,   DQ3_z  , 1);
    nmos   (DQ2 ,   DQ2_z  , 1);
    nmos   (DQ1 ,   DQ1_z  , 1);
    nmos   (DQ0 ,   DQ0_z  , 1);

    nmos   (RDY  ,  RDY_zd    ,1);

    wire deg;
    wire cs_flash;
    wire cs_flash_deg;
    wire clk_hi;
    wire clk_lo;
    wire clk_hi_ac;
    wire clk_lo_ac;
    wire flash_as;
    wire flash_s;
    wire avd_la;
    wire flash_s_la;


    assign cs_flash =  ~CENeg;
    assign cs_flash_deg = ~CENeg &&  deg;
    assign clk_hi = ~CENeg && ~ConfRegData[19] && ConfRegData[17] ;
    assign clk_lo = ~CENeg && ~ConfRegData[19] && ~ConfRegData[17];
    assign clk_hi_ac = ~CENeg && ~ConfRegData[19] && ConfRegData[17] && (LA);
    assign clk_lo_ac = ~CENeg && ~ConfRegData[19] && ~ConfRegData[17] && (LA);

    assign flash_as = ~CENeg && ConfRegData[19];
    assign flash_s = ~CENeg && ~ConfRegData[19];

    assign avd_la =  ConfRegData[19]? ConfRegData[19]:(LA);
    assign flash_s_la = ~CENeg && ~ConfRegData[19] && (LA);
specify

        // tipd delays: interconnect path delays , mapped to input port delays.
        // In Verilog is not necessary to declare any tipd_ delay variables,
        // they can be taken from SDF file
        // With all the other delays real delays would be taken from SDF file

    // tpd delays
//    specparam           tpd_CENeg_DQ0           =1;
//    specparam           tpd_OENeg_DQ0           =1;
//    specparam           tpd_A0_DQ0              =1;
//    specparam           tpd_CLK_DQ0             =1;

    specparam           tpd_A0_DQ0              =1;
    specparam           tpd_A0_DQ1              =1;
    specparam           tpd_A0_DQ2              =1;
    specparam           tpd_A0_DQ3              =1;
    specparam           tpd_A0_DQ4              =1;
    specparam           tpd_A0_DQ5              =1;
    specparam           tpd_A0_DQ6              =1;
    specparam           tpd_A0_DQ7              =1;
    specparam           tpd_A0_DQ8              =1;
    specparam           tpd_A0_DQ9              =1;
    specparam           tpd_A0_DQ10              =1;
    specparam           tpd_A0_DQ11              =1;
    specparam           tpd_A0_DQ12              =1;
    specparam           tpd_A0_DQ13              =1;
    specparam           tpd_A0_DQ14              =1;
    specparam           tpd_A0_DQ15              =1;
    specparam           tpd_A1_DQ0              =1;
    specparam           tpd_A1_DQ1              =1;
    specparam           tpd_A1_DQ2              =1;
    specparam           tpd_A1_DQ3              =1;
    specparam           tpd_A1_DQ4              =1;
    specparam           tpd_A1_DQ5              =1;
    specparam           tpd_A1_DQ6              =1;
    specparam           tpd_A1_DQ7              =1;
    specparam           tpd_A1_DQ8              =1;
    specparam           tpd_A1_DQ9              =1;
    specparam           tpd_A1_DQ10              =1;
    specparam           tpd_A1_DQ11              =1;
    specparam           tpd_A1_DQ12              =1;
    specparam           tpd_A1_DQ13              =1;
    specparam           tpd_A1_DQ14              =1;
    specparam           tpd_A1_DQ15              =1;
    specparam           tpd_A2_DQ0              =1;
    specparam           tpd_A2_DQ1              =1;
    specparam           tpd_A2_DQ2              =1;
    specparam           tpd_A2_DQ3              =1;
    specparam           tpd_A2_DQ4              =1;
    specparam           tpd_A2_DQ5              =1;
    specparam           tpd_A2_DQ6              =1;
    specparam           tpd_A2_DQ7              =1;
    specparam           tpd_A2_DQ8              =1;
    specparam           tpd_A2_DQ9              =1;
    specparam           tpd_A2_DQ10              =1;
    specparam           tpd_A2_DQ11              =1;
    specparam           tpd_A2_DQ12              =1;
    specparam           tpd_A2_DQ13              =1;
    specparam           tpd_A2_DQ14              =1;
    specparam           tpd_A2_DQ15              =1;
    specparam           tpd_A3_DQ0              =1;
    specparam           tpd_A3_DQ1              =1;
    specparam           tpd_A3_DQ2              =1;
    specparam           tpd_A3_DQ3              =1;
    specparam           tpd_A3_DQ4              =1;
    specparam           tpd_A3_DQ5              =1;
    specparam           tpd_A3_DQ6              =1;
    specparam           tpd_A3_DQ7              =1;
    specparam           tpd_A3_DQ8              =1;
    specparam           tpd_A3_DQ9              =1;
    specparam           tpd_A3_DQ10              =1;
    specparam           tpd_A3_DQ11              =1;
    specparam           tpd_A3_DQ12              =1;
    specparam           tpd_A3_DQ13              =1;
    specparam           tpd_A3_DQ14              =1;
    specparam           tpd_A3_DQ15              =1;
    specparam           tpd_A4_DQ0              =1;
    specparam           tpd_A4_DQ1              =1;
    specparam           tpd_A4_DQ2              =1;
    specparam           tpd_A4_DQ3              =1;
    specparam           tpd_A4_DQ4              =1;
    specparam           tpd_A4_DQ5              =1;
    specparam           tpd_A4_DQ6              =1;
    specparam           tpd_A4_DQ7              =1;
    specparam           tpd_A4_DQ8              =1;
    specparam           tpd_A4_DQ9              =1;
    specparam           tpd_A4_DQ10              =1;
    specparam           tpd_A4_DQ11              =1;
    specparam           tpd_A4_DQ12              =1;
    specparam           tpd_A4_DQ13              =1;
    specparam           tpd_A4_DQ14              =1;
    specparam           tpd_A4_DQ15              =1;
    specparam           tpd_A5_DQ0              =1;
    specparam           tpd_A5_DQ1              =1;
    specparam           tpd_A5_DQ2              =1;
    specparam           tpd_A5_DQ3              =1;
    specparam           tpd_A5_DQ4              =1;
    specparam           tpd_A5_DQ5              =1;
    specparam           tpd_A5_DQ6              =1;
    specparam           tpd_A5_DQ7              =1;
    specparam           tpd_A5_DQ8              =1;
    specparam           tpd_A5_DQ9              =1;
    specparam           tpd_A5_DQ10              =1;
    specparam           tpd_A5_DQ11              =1;
    specparam           tpd_A5_DQ12              =1;
    specparam           tpd_A5_DQ13              =1;
    specparam           tpd_A5_DQ14              =1;
    specparam           tpd_A5_DQ15              =1;
    specparam           tpd_A6_DQ0              =1;
    specparam           tpd_A6_DQ1              =1;
    specparam           tpd_A6_DQ2              =1;
    specparam           tpd_A6_DQ3              =1;
    specparam           tpd_A6_DQ4              =1;
    specparam           tpd_A6_DQ5              =1;
    specparam           tpd_A6_DQ6              =1;
    specparam           tpd_A6_DQ7              =1;
    specparam           tpd_A6_DQ8              =1;
    specparam           tpd_A6_DQ9              =1;
    specparam           tpd_A6_DQ10              =1;
    specparam           tpd_A6_DQ11              =1;
    specparam           tpd_A6_DQ12              =1;
    specparam           tpd_A6_DQ13              =1;
    specparam           tpd_A6_DQ14              =1;
    specparam           tpd_A6_DQ15              =1;
    specparam           tpd_A7_DQ0              =1;
    specparam           tpd_A7_DQ1              =1;
    specparam           tpd_A7_DQ2              =1;
    specparam           tpd_A7_DQ3              =1;
    specparam           tpd_A7_DQ4              =1;
    specparam           tpd_A7_DQ5              =1;
    specparam           tpd_A7_DQ6              =1;
    specparam           tpd_A7_DQ7              =1;
    specparam           tpd_A7_DQ8              =1;
    specparam           tpd_A7_DQ9              =1;
    specparam           tpd_A7_DQ10              =1;
    specparam           tpd_A7_DQ11              =1;
    specparam           tpd_A7_DQ12              =1;
    specparam           tpd_A7_DQ13              =1;
    specparam           tpd_A7_DQ14              =1;
    specparam           tpd_A7_DQ15              =1;
    specparam           tpd_A8_DQ0              =1;
    specparam           tpd_A8_DQ1              =1;
    specparam           tpd_A8_DQ2              =1;
    specparam           tpd_A8_DQ3              =1;
    specparam           tpd_A8_DQ4              =1;
    specparam           tpd_A8_DQ5              =1;
    specparam           tpd_A8_DQ6              =1;
    specparam           tpd_A8_DQ7              =1;
    specparam           tpd_A8_DQ8              =1;
    specparam           tpd_A8_DQ9              =1;
    specparam           tpd_A8_DQ10              =1;
    specparam           tpd_A8_DQ11              =1;
    specparam           tpd_A8_DQ12              =1;
    specparam           tpd_A8_DQ13              =1;
    specparam           tpd_A8_DQ14              =1;
    specparam           tpd_A8_DQ15              =1;
    specparam           tpd_A9_DQ0              =1;
    specparam           tpd_A9_DQ1              =1;
    specparam           tpd_A9_DQ2              =1;
    specparam           tpd_A9_DQ3              =1;
    specparam           tpd_A9_DQ4              =1;
    specparam           tpd_A9_DQ5              =1;
    specparam           tpd_A9_DQ6              =1;
    specparam           tpd_A9_DQ7              =1;
    specparam           tpd_A9_DQ8              =1;
    specparam           tpd_A9_DQ9              =1;
    specparam           tpd_A9_DQ10              =1;
    specparam           tpd_A9_DQ11              =1;
    specparam           tpd_A9_DQ12              =1;
    specparam           tpd_A9_DQ13              =1;
    specparam           tpd_A9_DQ14              =1;
    specparam           tpd_A9_DQ15              =1;
    specparam           tpd_A10_DQ0              =1;
    specparam           tpd_A10_DQ1              =1;
    specparam           tpd_A10_DQ2              =1;
    specparam           tpd_A10_DQ3              =1;
    specparam           tpd_A10_DQ4              =1;
    specparam           tpd_A10_DQ5              =1;
    specparam           tpd_A10_DQ6              =1;
    specparam           tpd_A10_DQ7              =1;
    specparam           tpd_A10_DQ8              =1;
    specparam           tpd_A10_DQ9              =1;
    specparam           tpd_A10_DQ10              =1;
    specparam           tpd_A10_DQ11              =1;
    specparam           tpd_A10_DQ12              =1;
    specparam           tpd_A10_DQ13              =1;
    specparam           tpd_A10_DQ14              =1;
    specparam           tpd_A10_DQ15              =1;
    specparam           tpd_A11_DQ0              =1;
    specparam           tpd_A11_DQ1              =1;
    specparam           tpd_A11_DQ2              =1;
    specparam           tpd_A11_DQ3              =1;
    specparam           tpd_A11_DQ4              =1;
    specparam           tpd_A11_DQ5              =1;
    specparam           tpd_A11_DQ6              =1;
    specparam           tpd_A11_DQ7              =1;
    specparam           tpd_A11_DQ8              =1;
    specparam           tpd_A11_DQ9              =1;
    specparam           tpd_A11_DQ10              =1;
    specparam           tpd_A11_DQ11              =1;
    specparam           tpd_A11_DQ12              =1;
    specparam           tpd_A11_DQ13              =1;
    specparam           tpd_A11_DQ14              =1;
    specparam           tpd_A11_DQ15              =1;
    specparam           tpd_A12_DQ0              =1;
    specparam           tpd_A12_DQ1              =1;
    specparam           tpd_A12_DQ2              =1;
    specparam           tpd_A12_DQ3              =1;
    specparam           tpd_A12_DQ4              =1;
    specparam           tpd_A12_DQ5              =1;
    specparam           tpd_A12_DQ6              =1;
    specparam           tpd_A12_DQ7              =1;
    specparam           tpd_A12_DQ8              =1;
    specparam           tpd_A12_DQ9              =1;
    specparam           tpd_A12_DQ10              =1;
    specparam           tpd_A12_DQ11              =1;
    specparam           tpd_A12_DQ12              =1;
    specparam           tpd_A12_DQ13              =1;
    specparam           tpd_A12_DQ14              =1;
    specparam           tpd_A12_DQ15              =1;
    specparam           tpd_A13_DQ0              =1;
    specparam           tpd_A13_DQ1              =1;
    specparam           tpd_A13_DQ2              =1;
    specparam           tpd_A13_DQ3              =1;
    specparam           tpd_A13_DQ4              =1;
    specparam           tpd_A13_DQ5              =1;
    specparam           tpd_A13_DQ6              =1;
    specparam           tpd_A13_DQ7              =1;
    specparam           tpd_A13_DQ8              =1;
    specparam           tpd_A13_DQ9              =1;
    specparam           tpd_A13_DQ10              =1;
    specparam           tpd_A13_DQ11              =1;
    specparam           tpd_A13_DQ12              =1;
    specparam           tpd_A13_DQ13              =1;
    specparam           tpd_A13_DQ14              =1;
    specparam           tpd_A13_DQ15              =1;
    specparam           tpd_A14_DQ0              =1;
    specparam           tpd_A14_DQ1              =1;
    specparam           tpd_A14_DQ2              =1;
    specparam           tpd_A14_DQ3              =1;
    specparam           tpd_A14_DQ4              =1;
    specparam           tpd_A14_DQ5              =1;
    specparam           tpd_A14_DQ6              =1;
    specparam           tpd_A14_DQ7              =1;
    specparam           tpd_A14_DQ8              =1;
    specparam           tpd_A14_DQ9              =1;
    specparam           tpd_A14_DQ10              =1;
    specparam           tpd_A14_DQ11              =1;
    specparam           tpd_A14_DQ12              =1;
    specparam           tpd_A14_DQ13              =1;
    specparam           tpd_A14_DQ14              =1;
    specparam           tpd_A14_DQ15              =1;
    specparam           tpd_A15_DQ0              =1;
    specparam           tpd_A15_DQ1              =1;
    specparam           tpd_A15_DQ2              =1;
    specparam           tpd_A15_DQ3              =1;
    specparam           tpd_A15_DQ4              =1;
    specparam           tpd_A15_DQ5              =1;
    specparam           tpd_A15_DQ6              =1;
    specparam           tpd_A15_DQ7              =1;
    specparam           tpd_A15_DQ8              =1;
    specparam           tpd_A15_DQ9              =1;
    specparam           tpd_A15_DQ10              =1;
    specparam           tpd_A15_DQ11              =1;
    specparam           tpd_A15_DQ12              =1;
    specparam           tpd_A15_DQ13              =1;
    specparam           tpd_A15_DQ14              =1;
    specparam           tpd_A15_DQ15              =1;
    specparam           tpd_A16_DQ0              =1;
    specparam           tpd_A16_DQ1              =1;
    specparam           tpd_A16_DQ2              =1;
    specparam           tpd_A16_DQ3              =1;
    specparam           tpd_A16_DQ4              =1;
    specparam           tpd_A16_DQ5              =1;
    specparam           tpd_A16_DQ6              =1;
    specparam           tpd_A16_DQ7              =1;
    specparam           tpd_A16_DQ8              =1;
    specparam           tpd_A16_DQ9              =1;
    specparam           tpd_A16_DQ10              =1;
    specparam           tpd_A16_DQ11              =1;
    specparam           tpd_A16_DQ12              =1;
    specparam           tpd_A16_DQ13              =1;
    specparam           tpd_A16_DQ14              =1;
    specparam           tpd_A16_DQ15              =1;
    specparam           tpd_A17_DQ0              =1;
    specparam           tpd_A17_DQ1              =1;
    specparam           tpd_A17_DQ2              =1;
    specparam           tpd_A17_DQ3              =1;
    specparam           tpd_A17_DQ4              =1;
    specparam           tpd_A17_DQ5              =1;
    specparam           tpd_A17_DQ6              =1;
    specparam           tpd_A17_DQ7              =1;
    specparam           tpd_A17_DQ8              =1;
    specparam           tpd_A17_DQ9              =1;
    specparam           tpd_A17_DQ10              =1;
    specparam           tpd_A17_DQ11              =1;
    specparam           tpd_A17_DQ12              =1;
    specparam           tpd_A17_DQ13              =1;
    specparam           tpd_A17_DQ14              =1;
    specparam           tpd_A17_DQ15              =1;
    specparam           tpd_A18_DQ0              =1;
    specparam           tpd_A18_DQ1              =1;
    specparam           tpd_A18_DQ2              =1;
    specparam           tpd_A18_DQ3              =1;
    specparam           tpd_A18_DQ4              =1;
    specparam           tpd_A18_DQ5              =1;
    specparam           tpd_A18_DQ6              =1;
    specparam           tpd_A18_DQ7              =1;
    specparam           tpd_A18_DQ8              =1;
    specparam           tpd_A18_DQ9              =1;
    specparam           tpd_A18_DQ10              =1;
    specparam           tpd_A18_DQ11              =1;
    specparam           tpd_A18_DQ12              =1;
    specparam           tpd_A18_DQ13              =1;
    specparam           tpd_A18_DQ14              =1;
    specparam           tpd_A18_DQ15              =1;
    specparam           tpd_A19_DQ0              =1;
    specparam           tpd_A19_DQ1              =1;
    specparam           tpd_A19_DQ2              =1;
    specparam           tpd_A19_DQ3              =1;
    specparam           tpd_A19_DQ4              =1;
    specparam           tpd_A19_DQ5              =1;
    specparam           tpd_A19_DQ6              =1;
    specparam           tpd_A19_DQ7              =1;
    specparam           tpd_A19_DQ8              =1;
    specparam           tpd_A19_DQ9              =1;
    specparam           tpd_A19_DQ10              =1;
    specparam           tpd_A19_DQ11              =1;
    specparam           tpd_A19_DQ12              =1;
    specparam           tpd_A19_DQ13              =1;
    specparam           tpd_A19_DQ14              =1;
    specparam           tpd_A19_DQ15              =1;
    specparam           tpd_A20_DQ0              =1;
    specparam           tpd_A20_DQ1              =1;
    specparam           tpd_A20_DQ2              =1;
    specparam           tpd_A20_DQ3              =1;
    specparam           tpd_A20_DQ4              =1;
    specparam           tpd_A20_DQ5              =1;
    specparam           tpd_A20_DQ6              =1;
    specparam           tpd_A20_DQ7              =1;
    specparam           tpd_A20_DQ8              =1;
    specparam           tpd_A20_DQ9              =1;
    specparam           tpd_A20_DQ10              =1;
    specparam           tpd_A20_DQ11              =1;
    specparam           tpd_A20_DQ12              =1;
    specparam           tpd_A20_DQ13              =1;
    specparam           tpd_A20_DQ14              =1;
    specparam           tpd_A20_DQ15              =1;
    specparam           tpd_A21_DQ0              =1;
    specparam           tpd_A21_DQ1              =1;
    specparam           tpd_A21_DQ2              =1;
    specparam           tpd_A21_DQ3              =1;
    specparam           tpd_A21_DQ4              =1;
    specparam           tpd_A21_DQ5              =1;
    specparam           tpd_A21_DQ6              =1;
    specparam           tpd_A21_DQ7              =1;
    specparam           tpd_A21_DQ8              =1;
    specparam           tpd_A21_DQ9              =1;
    specparam           tpd_A21_DQ10              =1;
    specparam           tpd_A21_DQ11              =1;
    specparam           tpd_A21_DQ12              =1;
    specparam           tpd_A21_DQ13              =1;
    specparam           tpd_A21_DQ14              =1;
    specparam           tpd_A21_DQ15              =1;
    specparam           tpd_CENeg_DQ0           =1;
    specparam           tpd_CENeg_DQ1           =1;
    specparam           tpd_CENeg_DQ2           =1;
    specparam           tpd_CENeg_DQ3           =1;
    specparam           tpd_CENeg_DQ4           =1;
    specparam           tpd_CENeg_DQ5           =1;
    specparam           tpd_CENeg_DQ6           =1;
    specparam           tpd_CENeg_DQ7           =1;
    specparam           tpd_CENeg_DQ8           =1;
    specparam           tpd_CENeg_DQ9           =1;
    specparam           tpd_CENeg_DQ10           =1;
    specparam           tpd_CENeg_DQ11           =1;
    specparam           tpd_CENeg_DQ12           =1;
    specparam           tpd_CENeg_DQ13           =1;
    specparam           tpd_CENeg_DQ14           =1;
    specparam           tpd_CENeg_DQ15           =1;
    specparam           tpd_OENeg_DQ0           =1;
    specparam           tpd_OENeg_DQ1           =1;
    specparam           tpd_OENeg_DQ2           =1;
    specparam           tpd_OENeg_DQ3           =1;
    specparam           tpd_OENeg_DQ4           =1;
    specparam           tpd_OENeg_DQ5           =1;
    specparam           tpd_OENeg_DQ6           =1;
    specparam           tpd_OENeg_DQ7           =1;
    specparam           tpd_OENeg_DQ8           =1;
    specparam           tpd_OENeg_DQ9           =1;
    specparam           tpd_OENeg_DQ10           =1;
    specparam           tpd_OENeg_DQ11           =1;
    specparam           tpd_OENeg_DQ12           =1;
    specparam           tpd_OENeg_DQ13           =1;
    specparam           tpd_OENeg_DQ14           =1;
    specparam           tpd_OENeg_DQ15           =1;
    specparam           tpd_CLK_DQ0           =1;
    specparam           tpd_CLK_DQ1           =1;
    specparam           tpd_CLK_DQ2           =1;
    specparam           tpd_CLK_DQ3           =1;
    specparam           tpd_CLK_DQ4           =1;
    specparam           tpd_CLK_DQ5           =1;
    specparam           tpd_CLK_DQ6           =1;
    specparam           tpd_CLK_DQ7           =1;
    specparam           tpd_CLK_DQ8           =1;
    specparam           tpd_CLK_DQ9           =1;
    specparam           tpd_CLK_DQ10           =1;
    specparam           tpd_CLK_DQ11           =1;
    specparam           tpd_CLK_DQ12           =1;
    specparam           tpd_CLK_DQ13           =1;
    specparam           tpd_CLK_DQ14           =1;
    specparam           tpd_CLK_DQ15           =1;

    specparam           tpd_CLK_RDY             =1;

    specparam           tsetup_A0_CLK            =1;
    specparam           thold_A0_CLK             =1;
    specparam           tsetup_A0_AVDNeg         =1;
    specparam           thold_A0_AVDNeg          =1;
    specparam           thold_OENeg_WENeg        =1;
    specparam           thold_CENeg_RESETNeg     =1;
    specparam           thold_OENeg_RESETNeg     =1;
    specparam           tsetup_A0_WENeg          =1;
    specparam           thold_A0_WENeg           =1;
    specparam           tsetup_DQ0_WENeg         =1;
    specparam           thold_DQ0_WENeg          =1;
    specparam           tsetup_CLK_AVDNeg        =1;
    specparam           tsetup_CLK_WENeg         =1;
    specparam           thold_CLK_WENeg          =1;

    specparam           tsetup_AVDNeg_WENeg      =1;
    specparam           thold_AVDNeg_WENeg       =1;
    specparam           tsetup_AVDNeg_CLK        =1;
    specparam           thold_AVDNeg_CLK         =1;

    specparam           thold_DQ0_CLK            =1;
    specparam           tsetup_CENeg_CLK         =1;
    specparam           tsetup_RDY_CLK           =1;
     // tpw values: pulse width
     specparam           tpw_RESETNeg_negedge    =1;
     specparam           tpw_WENeg_negedge       =1;
     specparam           tpw_WENeg_posedge       =1;
     specparam           tpw_AVDNeg_negedge      =1;


    // tdevice values: values for internal delays
            //Program Operation
     specparam   tdevice_pow                     = 210000; //12 us;
     specparam   tdevice_pou                     = 120000; //12 us;
            //Sector Erase Operation    tWHWH2
     specparam   tdevice_seo                     = 5e9; //1 sec;

            //program/erase suspend timeout
     specparam   tdevice_START_T1               = 35000; //20 us;
            //sector erase command sequence timeout
     specparam   tdevice_CTMOUT                  = 50000; //50 us;
            //device ready after Hardware reset(during embeded algorithm)
     specparam   tdevice_READY                   = 35000; //20 us; //tReady


///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
//for DQ signals
/*  (A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10,
   A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21
   *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
      DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_A0_DQ0;//ok

*/
  
        (A0 *> DQ0) = tpd_A0_DQ0;
        (A0 *> DQ1) = tpd_A0_DQ1;
        (A0 *> DQ2) = tpd_A0_DQ2;
        (A0 *> DQ3) = tpd_A0_DQ3;
        (A0 *> DQ4) = tpd_A0_DQ4;
        (A0 *> DQ5) = tpd_A0_DQ5;
        (A0 *> DQ6) = tpd_A0_DQ6;
        (A0 *> DQ7) = tpd_A0_DQ7;
        (A0 *> DQ8) = tpd_A0_DQ8;
        (A0 *> DQ9) = tpd_A0_DQ9;
        (A0 *> DQ10) = tpd_A0_DQ10;
        (A0 *> DQ11) = tpd_A0_DQ11;
        (A0 *> DQ12) = tpd_A0_DQ12;
        (A0 *> DQ13) = tpd_A0_DQ13;
        (A0 *> DQ14) = tpd_A0_DQ14;
        (A0 *> DQ15) = tpd_A0_DQ15;
        (A1 *> DQ0) = tpd_A1_DQ0;
        (A1 *> DQ1) = tpd_A1_DQ1;
        (A1 *> DQ2) = tpd_A1_DQ2;
        (A1 *> DQ3) = tpd_A1_DQ3;
        (A1 *> DQ4) = tpd_A1_DQ4;
        (A1 *> DQ5) = tpd_A1_DQ5;
        (A1 *> DQ6) = tpd_A1_DQ6;
        (A1 *> DQ7) = tpd_A1_DQ7;
        (A1 *> DQ8) = tpd_A1_DQ8;
        (A1 *> DQ9) = tpd_A1_DQ9;
        (A1 *> DQ10) = tpd_A1_DQ10;
        (A1 *> DQ11) = tpd_A1_DQ11;
        (A1 *> DQ12) = tpd_A1_DQ12;
        (A1 *> DQ13) = tpd_A1_DQ13;
        (A1 *> DQ14) = tpd_A1_DQ14;
        (A1 *> DQ15) = tpd_A1_DQ15;
        (A2 *> DQ0) = tpd_A2_DQ0;
        (A2 *> DQ1) = tpd_A2_DQ1;
        (A2 *> DQ2) = tpd_A2_DQ2;
        (A2 *> DQ3) = tpd_A2_DQ3;
        (A2 *> DQ4) = tpd_A2_DQ4;
        (A2 *> DQ5) = tpd_A2_DQ5;
        (A2 *> DQ6) = tpd_A2_DQ6;
        (A2 *> DQ7) = tpd_A2_DQ7;
        (A2 *> DQ8) = tpd_A2_DQ8;
        (A2 *> DQ9) = tpd_A2_DQ9;
        (A2 *> DQ10) = tpd_A2_DQ10;
        (A2 *> DQ11) = tpd_A2_DQ11;
        (A2 *> DQ12) = tpd_A2_DQ12;
        (A2 *> DQ13) = tpd_A2_DQ13;
        (A2 *> DQ14) = tpd_A2_DQ14;
        (A2 *> DQ15) = tpd_A2_DQ15;
        (A3 *> DQ0) = tpd_A3_DQ0;
        (A3 *> DQ1) = tpd_A3_DQ1;
        (A3 *> DQ2) = tpd_A3_DQ2;
        (A3 *> DQ3) = tpd_A3_DQ3;
        (A3 *> DQ4) = tpd_A3_DQ4;
        (A3 *> DQ5) = tpd_A3_DQ5;
        (A3 *> DQ6) = tpd_A3_DQ6;
        (A3 *> DQ7) = tpd_A3_DQ7;
        (A3 *> DQ8) = tpd_A3_DQ8;
        (A3 *> DQ9) = tpd_A3_DQ9;
        (A3 *> DQ10) = tpd_A3_DQ10;
        (A3 *> DQ11) = tpd_A3_DQ11;
        (A3 *> DQ12) = tpd_A3_DQ12;
        (A3 *> DQ13) = tpd_A3_DQ13;
        (A3 *> DQ14) = tpd_A3_DQ14;
        (A3 *> DQ15) = tpd_A3_DQ15;
        (A4 *> DQ0) = tpd_A4_DQ0;
        (A4 *> DQ1) = tpd_A4_DQ1;
        (A4 *> DQ2) = tpd_A4_DQ2;
        (A4 *> DQ3) = tpd_A4_DQ3;
        (A4 *> DQ4) = tpd_A4_DQ4;
        (A4 *> DQ5) = tpd_A4_DQ5;
        (A4 *> DQ6) = tpd_A4_DQ6;
        (A4 *> DQ7) = tpd_A4_DQ7;
        (A4 *> DQ8) = tpd_A4_DQ8;
        (A4 *> DQ9) = tpd_A4_DQ9;
        (A4 *> DQ10) = tpd_A4_DQ10;
        (A4 *> DQ11) = tpd_A4_DQ11;
        (A4 *> DQ12) = tpd_A4_DQ12;
        (A4 *> DQ13) = tpd_A4_DQ13;
        (A4 *> DQ14) = tpd_A4_DQ14;
        (A4 *> DQ15) = tpd_A4_DQ15;
        (A5 *> DQ0) = tpd_A5_DQ0;
        (A5 *> DQ1) = tpd_A5_DQ1;
        (A5 *> DQ2) = tpd_A5_DQ2;
        (A5 *> DQ3) = tpd_A5_DQ3;
        (A5 *> DQ4) = tpd_A5_DQ4;
        (A5 *> DQ5) = tpd_A5_DQ5;
        (A5 *> DQ6) = tpd_A5_DQ6;
        (A5 *> DQ7) = tpd_A5_DQ7;
        (A5 *> DQ8) = tpd_A5_DQ8;
        (A5 *> DQ9) = tpd_A5_DQ9;
        (A5 *> DQ10) = tpd_A5_DQ10;
        (A5 *> DQ11) = tpd_A5_DQ11;
        (A5 *> DQ12) = tpd_A5_DQ12;
        (A5 *> DQ13) = tpd_A5_DQ13;
        (A5 *> DQ14) = tpd_A5_DQ14;
        (A5 *> DQ15) = tpd_A5_DQ15;
        (A6 *> DQ0) = tpd_A6_DQ0;
        (A6 *> DQ1) = tpd_A6_DQ1;
        (A6 *> DQ2) = tpd_A6_DQ2;
        (A6 *> DQ3) = tpd_A6_DQ3;
        (A6 *> DQ4) = tpd_A6_DQ4;
        (A6 *> DQ5) = tpd_A6_DQ5;
        (A6 *> DQ6) = tpd_A6_DQ6;
        (A6 *> DQ7) = tpd_A6_DQ7;
        (A6 *> DQ8) = tpd_A6_DQ8;
        (A6 *> DQ9) = tpd_A6_DQ9;
        (A6 *> DQ10) = tpd_A6_DQ10;
        (A6 *> DQ11) = tpd_A6_DQ11;
        (A6 *> DQ12) = tpd_A6_DQ12;
        (A6 *> DQ13) = tpd_A6_DQ13;
        (A6 *> DQ14) = tpd_A6_DQ14;
        (A6 *> DQ15) = tpd_A6_DQ15;
        (A7 *> DQ0) = tpd_A7_DQ0;
        (A7 *> DQ1) = tpd_A7_DQ1;
        (A7 *> DQ2) = tpd_A7_DQ2;
        (A7 *> DQ3) = tpd_A7_DQ3;
        (A7 *> DQ4) = tpd_A7_DQ4;
        (A7 *> DQ5) = tpd_A7_DQ5;
        (A7 *> DQ6) = tpd_A7_DQ6;
        (A7 *> DQ7) = tpd_A7_DQ7;
        (A7 *> DQ8) = tpd_A7_DQ8;
        (A7 *> DQ9) = tpd_A7_DQ9;
        (A7 *> DQ10) = tpd_A7_DQ10;
        (A7 *> DQ11) = tpd_A7_DQ11;
        (A7 *> DQ12) = tpd_A7_DQ12;
        (A7 *> DQ13) = tpd_A7_DQ13;
        (A7 *> DQ14) = tpd_A7_DQ14;
        (A7 *> DQ15) = tpd_A7_DQ15;
        (A8 *> DQ0) = tpd_A8_DQ0;
        (A8 *> DQ1) = tpd_A8_DQ1;
        (A8 *> DQ2) = tpd_A8_DQ2;
        (A8 *> DQ3) = tpd_A8_DQ3;
        (A8 *> DQ4) = tpd_A8_DQ4;
        (A8 *> DQ5) = tpd_A8_DQ5;
        (A8 *> DQ6) = tpd_A8_DQ6;
        (A8 *> DQ7) = tpd_A8_DQ7;
        (A8 *> DQ8) = tpd_A8_DQ8;
        (A8 *> DQ9) = tpd_A8_DQ9;
        (A8 *> DQ10) = tpd_A8_DQ10;
        (A8 *> DQ11) = tpd_A8_DQ11;
        (A8 *> DQ12) = tpd_A8_DQ12;
        (A8 *> DQ13) = tpd_A8_DQ13;
        (A8 *> DQ14) = tpd_A8_DQ14;
        (A8 *> DQ15) = tpd_A8_DQ15;
        (A9 *> DQ0) = tpd_A9_DQ0;
        (A9 *> DQ1) = tpd_A9_DQ1;
        (A9 *> DQ2) = tpd_A9_DQ2;
        (A9 *> DQ3) = tpd_A9_DQ3;
        (A9 *> DQ4) = tpd_A9_DQ4;
        (A9 *> DQ5) = tpd_A9_DQ5;
        (A9 *> DQ6) = tpd_A9_DQ6;
        (A9 *> DQ7) = tpd_A9_DQ7;
        (A9 *> DQ8) = tpd_A9_DQ8;
        (A9 *> DQ9) = tpd_A9_DQ9;
        (A9 *> DQ10) = tpd_A9_DQ10;
        (A9 *> DQ11) = tpd_A9_DQ11;
        (A9 *> DQ12) = tpd_A9_DQ12;
        (A9 *> DQ13) = tpd_A9_DQ13;
        (A9 *> DQ14) = tpd_A9_DQ14;
        (A9 *> DQ15) = tpd_A9_DQ15;
        (A10 *> DQ0) = tpd_A10_DQ0;
        (A10 *> DQ1) = tpd_A10_DQ1;
        (A10 *> DQ2) = tpd_A10_DQ2;
        (A10 *> DQ3) = tpd_A10_DQ3;
        (A10 *> DQ4) = tpd_A10_DQ4;
        (A10 *> DQ5) = tpd_A10_DQ5;
        (A10 *> DQ6) = tpd_A10_DQ6;
        (A10 *> DQ7) = tpd_A10_DQ7;
        (A10 *> DQ8) = tpd_A10_DQ8;
        (A10 *> DQ9) = tpd_A10_DQ9;
        (A10 *> DQ10) = tpd_A10_DQ10;
        (A10 *> DQ11) = tpd_A10_DQ11;
        (A10 *> DQ12) = tpd_A10_DQ12;
        (A10 *> DQ13) = tpd_A10_DQ13;
        (A10 *> DQ14) = tpd_A10_DQ14;
        (A10 *> DQ15) = tpd_A10_DQ15;
        (A11 *> DQ0) = tpd_A11_DQ0;
        (A11 *> DQ1) = tpd_A11_DQ1;
        (A11 *> DQ2) = tpd_A11_DQ2;
        (A11 *> DQ3) = tpd_A11_DQ3;
        (A11 *> DQ4) = tpd_A11_DQ4;
        (A11 *> DQ5) = tpd_A11_DQ5;
        (A11 *> DQ6) = tpd_A11_DQ6;
        (A11 *> DQ7) = tpd_A11_DQ7;
        (A11 *> DQ8) = tpd_A11_DQ8;
        (A11 *> DQ9) = tpd_A11_DQ9;
        (A11 *> DQ10) = tpd_A11_DQ10;
        (A11 *> DQ11) = tpd_A11_DQ11;
        (A11 *> DQ12) = tpd_A11_DQ12;
        (A11 *> DQ13) = tpd_A11_DQ13;
        (A11 *> DQ14) = tpd_A11_DQ14;
        (A11 *> DQ15) = tpd_A11_DQ15;
        (A12 *> DQ0) = tpd_A12_DQ0;
        (A12 *> DQ1) = tpd_A12_DQ1;
        (A12 *> DQ2) = tpd_A12_DQ2;
        (A12 *> DQ3) = tpd_A12_DQ3;
        (A12 *> DQ4) = tpd_A12_DQ4;
        (A12 *> DQ5) = tpd_A12_DQ5;
        (A12 *> DQ6) = tpd_A12_DQ6;
        (A12 *> DQ7) = tpd_A12_DQ7;
        (A12 *> DQ8) = tpd_A12_DQ8;
        (A12 *> DQ9) = tpd_A12_DQ9;
        (A12 *> DQ10) = tpd_A12_DQ10;
        (A12 *> DQ11) = tpd_A12_DQ11;
        (A12 *> DQ12) = tpd_A12_DQ12;
        (A12 *> DQ13) = tpd_A12_DQ13;
        (A12 *> DQ14) = tpd_A12_DQ14;
        (A12 *> DQ15) = tpd_A12_DQ15;
        (A13 *> DQ0) = tpd_A13_DQ0;
        (A13 *> DQ1) = tpd_A13_DQ1;
        (A13 *> DQ2) = tpd_A13_DQ2;
        (A13 *> DQ3) = tpd_A13_DQ3;
        (A13 *> DQ4) = tpd_A13_DQ4;
        (A13 *> DQ5) = tpd_A13_DQ5;
        (A13 *> DQ6) = tpd_A13_DQ6;
        (A13 *> DQ7) = tpd_A13_DQ7;
        (A13 *> DQ8) = tpd_A13_DQ8;
        (A13 *> DQ9) = tpd_A13_DQ9;
        (A13 *> DQ10) = tpd_A13_DQ10;
        (A13 *> DQ11) = tpd_A13_DQ11;
        (A13 *> DQ12) = tpd_A13_DQ12;
        (A13 *> DQ13) = tpd_A13_DQ13;
        (A13 *> DQ14) = tpd_A13_DQ14;
        (A13 *> DQ15) = tpd_A13_DQ15;
        (A14 *> DQ0) = tpd_A14_DQ0;
        (A14 *> DQ1) = tpd_A14_DQ1;
        (A14 *> DQ2) = tpd_A14_DQ2;
        (A14 *> DQ3) = tpd_A14_DQ3;
        (A14 *> DQ4) = tpd_A14_DQ4;
        (A14 *> DQ5) = tpd_A14_DQ5;
        (A14 *> DQ6) = tpd_A14_DQ6;
        (A14 *> DQ7) = tpd_A14_DQ7;
        (A14 *> DQ8) = tpd_A14_DQ8;
        (A14 *> DQ9) = tpd_A14_DQ9;
        (A14 *> DQ10) = tpd_A14_DQ10;
        (A14 *> DQ11) = tpd_A14_DQ11;
        (A14 *> DQ12) = tpd_A14_DQ12;
        (A14 *> DQ13) = tpd_A14_DQ13;
        (A14 *> DQ14) = tpd_A14_DQ14;
        (A14 *> DQ15) = tpd_A14_DQ15;
        (A15 *> DQ0) = tpd_A15_DQ0;
        (A15 *> DQ1) = tpd_A15_DQ1;
        (A15 *> DQ2) = tpd_A15_DQ2;
        (A15 *> DQ3) = tpd_A15_DQ3;
        (A15 *> DQ4) = tpd_A15_DQ4;
        (A15 *> DQ5) = tpd_A15_DQ5;
        (A15 *> DQ6) = tpd_A15_DQ6;
        (A15 *> DQ7) = tpd_A15_DQ7;
        (A15 *> DQ8) = tpd_A15_DQ8;
        (A15 *> DQ9) = tpd_A15_DQ9;
        (A15 *> DQ10) = tpd_A15_DQ10;
        (A15 *> DQ11) = tpd_A15_DQ11;
        (A15 *> DQ12) = tpd_A15_DQ12;
        (A15 *> DQ13) = tpd_A15_DQ13;
        (A15 *> DQ14) = tpd_A15_DQ14;
        (A15 *> DQ15) = tpd_A15_DQ15;
        (A16 *> DQ0) = tpd_A16_DQ0;
        (A16 *> DQ1) = tpd_A16_DQ1;
        (A16 *> DQ2) = tpd_A16_DQ2;
        (A16 *> DQ3) = tpd_A16_DQ3;
        (A16 *> DQ4) = tpd_A16_DQ4;
        (A16 *> DQ5) = tpd_A16_DQ5;
        (A16 *> DQ6) = tpd_A16_DQ6;
        (A16 *> DQ7) = tpd_A16_DQ7;
        (A16 *> DQ8) = tpd_A16_DQ8;
        (A16 *> DQ9) = tpd_A16_DQ9;
        (A16 *> DQ10) = tpd_A16_DQ10;
        (A16 *> DQ11) = tpd_A16_DQ11;
        (A16 *> DQ12) = tpd_A16_DQ12;
        (A16 *> DQ13) = tpd_A16_DQ13;
        (A16 *> DQ14) = tpd_A16_DQ14;
        (A16 *> DQ15) = tpd_A16_DQ15;
        (A17 *> DQ0) = tpd_A17_DQ0;
        (A17 *> DQ1) = tpd_A17_DQ1;
        (A17 *> DQ2) = tpd_A17_DQ2;
        (A17 *> DQ3) = tpd_A17_DQ3;
        (A17 *> DQ4) = tpd_A17_DQ4;
        (A17 *> DQ5) = tpd_A17_DQ5;
        (A17 *> DQ6) = tpd_A17_DQ6;
        (A17 *> DQ7) = tpd_A17_DQ7;
        (A17 *> DQ8) = tpd_A17_DQ8;
        (A17 *> DQ9) = tpd_A17_DQ9;
        (A17 *> DQ10) = tpd_A17_DQ10;
        (A17 *> DQ11) = tpd_A17_DQ11;
        (A17 *> DQ12) = tpd_A17_DQ12;
        (A17 *> DQ13) = tpd_A17_DQ13;
        (A17 *> DQ14) = tpd_A17_DQ14;
        (A17 *> DQ15) = tpd_A17_DQ15;
        (A18 *> DQ0) = tpd_A18_DQ0;
        (A18 *> DQ1) = tpd_A18_DQ1;
        (A18 *> DQ2) = tpd_A18_DQ2;
        (A18 *> DQ3) = tpd_A18_DQ3;
        (A18 *> DQ4) = tpd_A18_DQ4;
        (A18 *> DQ5) = tpd_A18_DQ5;
        (A18 *> DQ6) = tpd_A18_DQ6;
        (A18 *> DQ7) = tpd_A18_DQ7;
        (A18 *> DQ8) = tpd_A18_DQ8;
        (A18 *> DQ9) = tpd_A18_DQ9;
        (A18 *> DQ10) = tpd_A18_DQ10;
        (A18 *> DQ11) = tpd_A18_DQ11;
        (A18 *> DQ12) = tpd_A18_DQ12;
        (A18 *> DQ13) = tpd_A18_DQ13;
        (A18 *> DQ14) = tpd_A18_DQ14;
        (A18 *> DQ15) = tpd_A18_DQ15;
        (A19 *> DQ0) = tpd_A19_DQ0;
        (A19 *> DQ1) = tpd_A19_DQ1;
        (A19 *> DQ2) = tpd_A19_DQ2;
        (A19 *> DQ3) = tpd_A19_DQ3;
        (A19 *> DQ4) = tpd_A19_DQ4;
        (A19 *> DQ5) = tpd_A19_DQ5;
        (A19 *> DQ6) = tpd_A19_DQ6;
        (A19 *> DQ7) = tpd_A19_DQ7;
        (A19 *> DQ8) = tpd_A19_DQ8;
        (A19 *> DQ9) = tpd_A19_DQ9;
        (A19 *> DQ10) = tpd_A19_DQ10;
        (A19 *> DQ11) = tpd_A19_DQ11;
        (A19 *> DQ12) = tpd_A19_DQ12;
        (A19 *> DQ13) = tpd_A19_DQ13;
        (A19 *> DQ14) = tpd_A19_DQ14;
        (A19 *> DQ15) = tpd_A19_DQ15;
        (A20 *> DQ0) = tpd_A20_DQ0;
        (A20 *> DQ1) = tpd_A20_DQ1;
        (A20 *> DQ2) = tpd_A20_DQ2;
        (A20 *> DQ3) = tpd_A20_DQ3;
        (A20 *> DQ4) = tpd_A20_DQ4;
        (A20 *> DQ5) = tpd_A20_DQ5;
        (A20 *> DQ6) = tpd_A20_DQ6;
        (A20 *> DQ7) = tpd_A20_DQ7;
        (A20 *> DQ8) = tpd_A20_DQ8;
        (A20 *> DQ9) = tpd_A20_DQ9;
        (A20 *> DQ10) = tpd_A20_DQ10;
        (A20 *> DQ11) = tpd_A20_DQ11;
        (A20 *> DQ12) = tpd_A20_DQ12;
        (A20 *> DQ13) = tpd_A20_DQ13;
        (A20 *> DQ14) = tpd_A20_DQ14;
        (A20 *> DQ15) = tpd_A20_DQ15;
        (A21 *> DQ0) = tpd_A21_DQ0;
        (A21 *> DQ1) = tpd_A21_DQ1;
        (A21 *> DQ2) = tpd_A21_DQ2;
        (A21 *> DQ3) = tpd_A21_DQ3;
        (A21 *> DQ4) = tpd_A21_DQ4;
        (A21 *> DQ5) = tpd_A21_DQ5;
        (A21 *> DQ6) = tpd_A21_DQ6;
        (A21 *> DQ7) = tpd_A21_DQ7;
        (A21 *> DQ8) = tpd_A21_DQ8;
        (A21 *> DQ9) = tpd_A21_DQ9;
        (A21 *> DQ10) = tpd_A21_DQ10;
        (A21 *> DQ11) = tpd_A21_DQ11;
        (A21 *> DQ12) = tpd_A21_DQ12;
        (A21 *> DQ13) = tpd_A21_DQ13;
        (A21 *> DQ14) = tpd_A21_DQ14;
        (A21 *> DQ15) = tpd_A21_DQ15;

/*  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
              DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_CENeg_DQ0;
*/

  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ0) = tpd_CENeg_DQ0;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ1) = tpd_CENeg_DQ1;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ2) = tpd_CENeg_DQ2;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ3) = tpd_CENeg_DQ3;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ4) = tpd_CENeg_DQ4;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ5) = tpd_CENeg_DQ5;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ6) = tpd_CENeg_DQ6;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ7) = tpd_CENeg_DQ7;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ8) = tpd_CENeg_DQ8;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ9) = tpd_CENeg_DQ9;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ10) = tpd_CENeg_DQ10;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ11) = tpd_CENeg_DQ11;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ12) = tpd_CENeg_DQ12;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ13) = tpd_CENeg_DQ13;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ14) = tpd_CENeg_DQ14;
  if (!Open3state || (Open3state && FROMCE))
    (CENeg *> DQ15) = tpd_CENeg_DQ15;


//  if (!Open3state || (Open3state && FROMOE))
//    (OENeg *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//              DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_OENeg_DQ0;

  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ0) = tpd_OENeg_DQ0;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ1) = tpd_OENeg_DQ1;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ2) = tpd_OENeg_DQ2;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ3) = tpd_OENeg_DQ3;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ4) = tpd_OENeg_DQ4;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ5) = tpd_OENeg_DQ5;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ6) = tpd_OENeg_DQ6;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ7) = tpd_OENeg_DQ7;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ8) = tpd_OENeg_DQ8;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ9) = tpd_OENeg_DQ9;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ10) = tpd_OENeg_DQ10;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ11) = tpd_OENeg_DQ11;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ12) = tpd_OENeg_DQ12;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ13) = tpd_OENeg_DQ13;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ14) = tpd_OENeg_DQ14;
  if (!Open3state || (Open3state && FROMOE))
      (OENeg *> DQ15) = tpd_OENeg_DQ15;



//  if (clk_hi && CLK || clk_lo && ~CLK) (CLK *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//      DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_CLK_DQ0;//ok



  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ0) = tpd_CLK_DQ0;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ1) = tpd_CLK_DQ1;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ2) = tpd_CLK_DQ2;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ3) = tpd_CLK_DQ3;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ4) = tpd_CLK_DQ4;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ5) = tpd_CLK_DQ5;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ6) = tpd_CLK_DQ6;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ7) = tpd_CLK_DQ7;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ8) = tpd_CLK_DQ8;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ9) = tpd_CLK_DQ9;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ10) = tpd_CLK_DQ10;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ11) = tpd_CLK_DQ11;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ12) = tpd_CLK_DQ12;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ13) = tpd_CLK_DQ13;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ14) = tpd_CLK_DQ14;
  if (clk_hi && CLK || clk_lo && ~CLK)
    (CLK *> DQ15) = tpd_CLK_DQ15;



  if (clk_hi && CLK || clk_lo && ~CLK) (CLK *> RDY) = tpd_CLK_RDY;//ok

//  if (clk_lo) (NOT CLK *> DQ0, DQ1, DQ2, DQ3, DQ4, DQ5, DQ6, DQ7,
//      DQ8, DQ9, DQ10, DQ11, DQ12, DQ13, DQ14, DQ15) = tpd_CLK_DQ1;//ok

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////


        $setup ( A0 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A1 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A2 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A3 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A4 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A5 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A6 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A7 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A8 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A9 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A10 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A11 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A12 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A13 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A14 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A15 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A16 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A17 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A18 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A19 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A20 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);
        $setup ( A21 , posedge AVDNeg &&& avd_la, tsetup_A0_AVDNeg, Viol);

        $hold ( posedge AVDNeg &&& avd_la, A0 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A1 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A2 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A3 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A4 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A5 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A6 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A7 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A8 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A9 ,  thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A10 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A11 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A12 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A13 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A14 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A15 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A16 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A17 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A18 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A19 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A20 , thold_A0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& avd_la, A21 , thold_A0_AVDNeg, Viol);

        $setup ( A0 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A1 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A2 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A3 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A4 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A5 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A6 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A7 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A8 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A9 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A10 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A11 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A12 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A13 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A14 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A15 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A16 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A17 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A18 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A19 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A20 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);
        $setup ( A21 , posedge CLK &&& clk_hi_ac , tsetup_A0_CLK, Viol);

        $setup ( A0 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A1 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A2 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A3 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A4 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A5 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A6 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A7 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A8 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A9 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A10 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A11 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A12 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A13 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A14 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A15 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A16 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A17 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A18 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A19 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A20 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);
        $setup ( A21 , negedge CLK &&& clk_lo_ac , tsetup_A0_CLK, Viol);


        $hold ( posedge CLK &&& clk_hi_ac , A0 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A1 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A2 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A3 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A4 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A5 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A6 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A7 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A8 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A9 ,  thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A10 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A11 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A12 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A13 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A14 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A15 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A16 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A17 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A18 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A19 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A20 , thold_A0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi_ac , A21 , thold_A0_CLK, Viol);


        $hold ( negedge CLK &&& clk_lo_ac , A0 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A1 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A2 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A3 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A4 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A5 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A6 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A7 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A8 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A9 ,  thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A10 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A11 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A12 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A13 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A14 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A15 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A16 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A17 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A18 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A19 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A20 , thold_A0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo_ac , A21 , thold_A0_CLK, Viol);


        $setup ( A0 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A1 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A2 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A3 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A4 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A5 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A6 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A7 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A8 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A9 , negedge WENeg &&& flash_as,  tsetup_A0_WENeg, Viol);
        $setup ( A10 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A11 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A12 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A13 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A14 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A15 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A16 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A17 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A18 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A19 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A20 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);
        $setup ( A21 , negedge WENeg &&& flash_as, tsetup_A0_WENeg, Viol);


        $hold ( negedge WENeg &&& flash_as, A0 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A1 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A2 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A3 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A4 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A5 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A6 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A7 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A8 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A9 ,  thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A10 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A11 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A12 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A13 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A14 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A15 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A16 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A17 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A18 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A19 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A20 , thold_A0_WENeg, Viol);
        $hold ( negedge WENeg &&& flash_as, A21 , thold_A0_WENeg, Viol);

        $hold ( posedge CLK &&& clk_hi, DQ0  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ1  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ2  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ3  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ4  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ5  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ6  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ7  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ8  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ9  ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ10 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ11 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ12 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ13 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ14 ,   thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& clk_hi, DQ15 ,   thold_DQ0_CLK, Viol);

        $hold ( negedge CLK &&& clk_lo, DQ0  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ1  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ2  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ3  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ4  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ5  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ6  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ7  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ8  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ9  ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ10 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ11 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ12 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ13 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ14 ,   thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& clk_lo, DQ15 ,   thold_DQ0_CLK, Viol);

        $setup ( posedge RDY   , posedge CLK &&& clk_hi,  tsetup_RDY_CLK, Viol);//OE = 0
        $setup ( posedge RDY   , negedge CLK &&& clk_lo,  tsetup_RDY_CLK, Viol);

        $setup ( negedge CENeg , posedge CLK &&& clk_hi_ac,  tsetup_CENeg_CLK, Viol);
        $setup ( negedge CENeg , negedge CLK &&& clk_lo_ac,  tsetup_CENeg_CLK, Viol);

        $setup ( negedge AVDNeg , posedge CLK &&& clk_hi,  tsetup_AVDNeg_CLK, Viol);
        $setup ( negedge AVDNeg , negedge CLK &&& clk_lo,  tsetup_AVDNeg_CLK, Viol);

        $hold  ( posedge CLK &&& clk_hi, posedge AVDNeg,   tsetup_AVDNeg_CLK, Viol);
        $hold  ( negedge CLK &&& clk_lo, posedge AVDNeg,   tsetup_AVDNeg_CLK, Viol);

        $hold ( posedge WENeg &&& cs_flash, negedge OENeg , thold_OENeg_WENeg, Viol);//pdone = 0 or edone = 0

        $setup ( DQ0 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , posedge WENeg &&& cs_flash_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 , posedge WENeg &&& cs_flash_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 , posedge WENeg &&& cs_flash_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 , posedge WENeg &&& cs_flash_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 , posedge WENeg &&& cs_flash_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 , posedge WENeg &&& cs_flash_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 , posedge WENeg &&& cs_flash_deg, tsetup_DQ0_WENeg, Viol);

        $setup (  CLK , negedge AVDNeg &&& flash_as,  tsetup_CLK_AVDNeg, Viol);

        $hold  ( negedge WENeg &&& flash_as , CLK,   tsetup_CLK_WENeg, Viol);

        $setup ( negedge AVDNeg , negedge WENeg &&& cs_flash,  tsetup_AVDNeg_WENeg, Viol);//low
        $hold  ( negedge WENeg &&& cs_flash, posedge AVDNeg,   tsetup_AVDNeg_WENeg, Viol);//low

        $setup (  CLK , negedge WENeg &&& flash_s_la ,  tsetup_CLK_WENeg, Viol);//cs 19 = 0 AND LA rising

        $hold ( posedge RESETNeg &&& (CENeg===1), CENeg , thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg &&& (OENeg===1), OENeg , thold_CENeg_RESETNeg, Viol);

        $width (negedge RESETNeg , tpw_RESETNeg_negedge);
        $width (posedge WENeg    &&& cs_flash, tpw_WENeg_posedge);
        $width (negedge WENeg    &&& cs_flash, tpw_WENeg_negedge);
        $width (negedge AVDNeg   &&& cs_flash, tpw_AVDNeg_negedge);

////////////////////////
        $hold ( negedge WENeg &&& cs_flash, DQ0  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ1  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ2  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ3  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ4  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ5  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ6  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ7  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ8  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ9  ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ10 ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ11 ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ12 ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ13 ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ14 ,   thold_DQ0_WENeg, Viol);
        $hold ( negedge WENeg &&& cs_flash, DQ15 ,   thold_DQ0_WENeg, Viol);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter RESET           =6'd0;
 parameter Z001            =6'd1;
 parameter PREL_SETBWB     =6'd2;
 parameter PREL_ULBYPASS   =6'd3;
 parameter SLU_Z001        =6'd4;
 parameter SLU_PREL        =6'd5;
 parameter SLU             =6'd6;
 parameter CFI             =6'd7;
 parameter AS              =6'd8;
 parameter AS_CFI          =6'd9;
 parameter A0SEEN          =6'd10;
 parameter C8              =6'd11;
 parameter C8_Z001         =6'd12;
 parameter C8_PREL         =6'd13;
 parameter ERS             =6'd14;
 parameter SERS            =6'd15;
 parameter ESPS            =6'd16;
 parameter SERS_EXEC       =6'd17;
 parameter ESP             =6'd18;
 parameter ESP_Z001        =6'd19;
 parameter ESP_PREL        =6'd20;
 parameter ESP_CFI         =6'd21;
 parameter ESP_A0SEEN      =6'd22;
 parameter ESP_AS          =6'd23;
 parameter PGMS            =6'd24;

 reg [5:0] current_state;
 reg [5:0] next_state;
 reg deq;
 integer sector_preload[0:MemSize];

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

//TOP OR BOTTOM arch model is used
    //assumptions:
    //1. TimingModel has format as
    //"am42bds6408gt"
    //it is important that 10-th character from first one is "t" or "b"

    //2. TimingModel does not have more then 20 characters

    tmp_timing = TimingModel;//copy of TimingModel
    i = 19;
    found = 0;
    while ((i >= 0) && (found != 1))//search for first non null character
    begin                              //i keeps position of first non null character
        j = 7;
        while ((j >= 0) && (found != 1))
        begin
            if (tmp_timing[i*8+j] != 1'd0)
                found = 1;
            else
                j = j-1;
        end
        i = i - 1;
     end
    i = i +1;
//TOP/BOTTOM
    if (found)//if non null character is found
    begin
        for (j=0;j<=7;j=j+1)
        begin
            tmp_char[j] = TimingModel[(i-12)*8+j];//bottom/top character is 9
        end                                  //characters right from first ("a")
    end
        if (tmp_char == "t")
        begin
            vs = 1'b1;
            first_prot = SecNum -1;
        end
        else if (tmp_char == "b")
        begin
            vs = 1'b0;
            first_prot = 0;
        end
//RTEDUCED /STANDARD HANDSHAKE
    if (found)
    begin
        for (j=0;j<=7;j=j+1)
        begin
            tmp_char[j] = TimingModel[(i-14)*8+j];//handshake option character is 15th
        end                                  //characters right from first ("a")
    end
    if (tmp_char == "8")//reduced
        reduced_hnd = 1'b1;
    else if (tmp_char == "9")//standard
        reduced_hnd = 1'b0;

    // initialize memory and load preoload files if any
        for (i=0;i<=MemSize;i=i+1)
        begin
           sector_preload[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            Sec_Prot[i] = 1;
            Ers_Queue[i] = 0;
        end

        if (UserPreload && mem_file_name != "none")
        begin
           //am42bds6408g.mem, memory preload file
           //  @aaaaaa - <aaaaaa> stands for address within last defined sector
           //  dddd    - <dddd> is word to be written at Mem(aaaaaa++)
           // (aaaa is incremented at every load)
           $readmemh(mem_file_name,sector_preload);
        end

        //memory load
        for (j=0;j<=MemSize;j=j+1)
            Mem[j]=sector_preload[j];

        WBData = 0;
        WBAddr = -1;
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

        SecAddr            = 0;         // 0 - SecNum
        SA                 = 0;         // 0 TO SecNum
    //Address within sector
        Address             = 0;         // 0 - SecSize
        CR_Addr    = 0;
        Whole_Addr = 0;

        LA = 1'b0;

        enable_cnt = 1'b1;

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
        EERR0    = 1'b0;
        EERR1    = 1'b0;
        EERR2    = 1'b0;
        EERR3    = 1'b0;
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

//////////////////////////////////////
//hardware write protection
/////////////////////////////////////
    reg[SecNum:0] Sec_Prot_reg = (0); //= SecNum'b0;
    reg Sec_Prot_reg0 = 1'b0;
    reg Sec_Prot_reg1 = 1'b0;
    time acc_time;
    time wp_time;
    event wp_event;
    always @(ACC_ipd)
    begin

        acc_time = $time;
        if (ACC_ipd == 1'b0)
        begin
            for (i=0;i<=SecNum;i=i+1)
                if ((i!=first_prot) && (i!=(first_prot+1)))
                begin
                    Sec_Prot_reg[i] = Sec_Prot[i];
                    Sec_Prot[i] = 1'b1;
                end
        end
        else //if (ACC_ipd == 1'b1)
        begin
            for (i=0;i<=SecNum;i=i+1)
                if ((i!=first_prot) && (i!=(first_prot+1)))
                    Sec_Prot[i] = Sec_Prot_reg[i];
        end
            -> wp_event;
    end

    always @(WPNeg_ipd)
    begin
        wp_time = $time;
            -> wp_event;
    end
    time wp_or_acc;

    always @(wp_event)
    begin : hardware_ctrl
        wp_or_acc = $time;
        if ((acc_time == wp_time && ~WPNeg_ipd && ACC_ipd) ||//falling WP and rising ACC
            (acc_time == wp_time && ~ACC_ipd   && WPNeg_ipd)||//falling ACc and rising WP
            (acc_time != wp_time && wp_time == wp_or_acc && ~ACC_ipd) ||
            (acc_time != wp_time && acc_time == wp_or_acc && ~WPNeg_ipd))
        begin
        end
        else if ((acc_time == wp_time && ~WPNeg_ipd && ~ACC_ipd) ||
                 (wp_time == wp_or_acc && ~WPNeg_ipd && ACC_ipd)||
                 (acc_time == wp_or_acc && ~ACC_ipd && WPNeg_ipd))
        begin
                Sec_Prot_reg[0] = Sec_Prot[first_prot];
                Sec_Prot_reg[1] = Sec_Prot[first_prot+1];
                Sec_Prot[first_prot] = 1'b1;
                Sec_Prot[first_prot+1] = 1'b1;
        end
        else if ((acc_time == wp_time && WPNeg_ipd && ACC_ipd) ||
                 (wp_time == wp_or_acc && WPNeg_ipd && ACC_ipd) ||
                 (acc_time == wp_or_acc && ACC_ipd && WPNeg_ipd))
        begin
                Sec_Prot[first_prot] = Sec_Prot_reg[0];
                Sec_Prot[first_prot+1] = Sec_Prot_reg[1];
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
    begin: PulseWatch2
        if (gCE_n == CENeg)
            $display("Glitch on CE#");
    end
    always @(OENeg)
    begin: PulseWatch3
        if (gOE_n == OENeg)
            $display("Glitch on OE#");
    end

///////////////////////////////////////////
//open tristate buffers control
    always @(Dout_zd[15:0])
    begin : open_buff
    if (!burst_mode)
    begin
        if (Dout_zd[0] !== 1'bz)
        begin
            //open buffers
            CEDQ_open_t = CENeg_event  + CEDQ_1z;
            OEDQ_open_t = OENeg_event  + OEDQ_1z;
            Open3state = 1;
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
                TempData = Dout_zd[15:0];
                Dout_z[15:0] = 16'bx;
                Dout_z[15:0] <= #(wait_time - $time ) TempData;
            end
            else
            begin
                Dout_z[15:0] = Dout_zd[15:0];
            end

        end
        else
        begin
            Dout_z[15:0] = Dout_zd[15:0];
            FROMCE = 0;
            FROMOE = 0;
            Open3state = 0;
        end
    end
    else//burst_mode
        Dout_z[15:0] = Dout_zd[15:0];
    end

    reg  BuffInOE, BuffInCE, BuffInADDR ;
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

//    ///////////////////////////////////////////////////////////////////////////
//    //Latch address on falling edge of WE# or CE# what ever comes later
//    //Latches data on rising edge of WE# or CE# what ever comes first
//    // also Write cycle decode
//    ///////////////////////////////////////////////////////////////////////////
        integer A_tmp  ;
        integer SA_tmp ;
        integer A_tmp1 ;
        reg[HiConfBit:0] CR_Addr_tmp;
        reg LA_tmp     ;

   always @(WENeg_ipd)// or reseted)
	begin
        if (reseted)
        begin
            if (~CENeg_ipd)
            begin
                if (ConfRegData[19] && (~WENeg_ipd) && (~AVDNeg_ipd) && (~LA))
                begin
                    LA = 1'b1;
                    Whole_Addr = A;
                end
            end
        end
    end

   always @(AVDNeg_ipd)// or reseted)
	begin
        if (reseted)
        begin
            if (~CENeg_ipd)
            begin
                if (ConfRegData[19])
                begin
                    //WE latch addresses
                    if (~WENeg_ipd && ~AVDNeg && ~LA)
                    begin
                        LA = 1'b1;
                        Whole_Addr = A;
                    end
                    //AVD latch addresses
                    else if ((AVDNeg_ipd) && (~LA))
                    begin
                        LA = 1'b1;
                        Whole_Addr = A;
                        LA = #1 1'b0;
                    end
                    //latch is transparent
                    else if (~LA && ~AVDNeg_ipd)
                        Whole_Addr = A;
                end
                //burst
                //AVD rising edge
                else if ((AVDNeg_ipd) && (~LA))
                begin
                        LA = 1'b1;
                        Whole_Addr = A;
                        LA = #1 1'b0;
                end
                if (AVDNeg_ipd && ~CENeg_ipd && LA)
                    LA = 1'b0;
            end
        end
    end
    always @(A)
    begin
        if (reseted)
            if (~CENeg_ipd && ConfRegData[19] == 1'b1 && ~AVDNeg_ipd && (~LA))
                Whole_Addr = A;
    end

    always @(CENeg_ipd)
	begin
        if (reseted)
        begin
            if(~CENeg_ipd)
                if (ConfRegData[19])
                    if (~AVDNeg_ipd && ~LA && ~WENeg_ipd)
                    begin
                        Whole_Addr = A;
                        LA = 1'b1;
                    end
                    else if (~AVDNeg_ipd && ~LA)
                        Whole_Addr = A;

        if (CENeg_ipd)
            LA = 1'b0;
        else if (AVDNeg_ipd && ~CENeg_ipd && LA)
            LA = 1'b0;
        end
	end

    always @(CLK_active)// or reseted)
    begin
        if (reseted)
        begin
            if (~CENeg_ipd)
            begin
                if (~ConfRegData[19])
                    if ((~AVDNeg_ipd) && CLK_active && (~LA))
                    begin
                        LA = 1'b1;
                        Whole_Addr = A;
                    end
            end
        end
    end


   always @(negedge OENeg_ipd)//or reseted)
	begin
        if (reseted)
        begin
            A_tmp  =  Whole_Addr[10:0];
            RestoreSectAddr(Whole_Addr, SA_tmp, A_tmp1);

            SecAddr = SA_tmp;
            BA = ResolveBank(SA_tmp);
            Address = A_tmp1;
            Addr   = A_tmp;
            CR_Addr[HiConfBit:LoConfBit] = Whole_Addr[HiConfBit:LoConfBit];
        end
    end

   always @(Whole_Addr)// or reseted)
   begin
        if (reseted)
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
            begin
                A_tmp  =  Whole_Addr[10:0];
                RestoreSectAddr(Whole_Addr, SA_tmp, A_tmp1);

                SecAddr = SA_tmp;
                BA = ResolveBank(SA_tmp);
                Address = A_tmp1;
                Addr   = A_tmp;
                CR_Addr[HiConfBit:LoConfBit] = Whole_Addr[HiConfBit:LoConfBit];
            end
    end

    always @(posedge write)
    begin
        A_tmp  =  Whole_Addr[10:0];
        RestoreSectAddr(Whole_Addr, SA_tmp, A_tmp1);

        SecAddr = SA_tmp;
        BA = ResolveBank(SA_tmp);
        Address = A_tmp1;
        Addr   = A_tmp;
        CR_Addr[HiConfBit:LoConfBit] = Whole_Addr[HiConfBit:LoConfBit];
    end

    always @(posedge LA)
    begin
        A_tmp  =  Whole_Addr[10:0];
        RestoreSectAddr(Whole_Addr, SA_tmp, A_tmp1);

        SecAddr = SA_tmp;
        BA = ResolveBank(SA_tmp);
        Address = A_tmp1;
        Addr   = A_tmp;
        CR_Addr[HiConfBit:LoConfBit] = Whole_Addr[HiConfBit:LoConfBit];
    end


//    ///////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
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
                if ( (~Sec_Prot[SA] &&
                     (~Ers_Queue[SA] || ~ESP_ACT )))
                begin
                    if (ULBYPASS)
                        duration_write = tdevice_pou;
                    else
                        duration_write = tdevice_pow;
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
 integer bank0;
 integer bank1;
 integer bank2;
 integer bank3;
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
                bank0 = 0;
                bank1 = 0;
                bank2 = 0;
                bank3 = 0;
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if ((Ers_Queue[i]==1'b1) && (Sec_Prot[i]!=1'b1))
                    begin
                        cnt_erase = cnt_erase + 1;
                        if (bank0 || ResolveBank(i) == 0)
                            bank0 = 1;
                        if (bank1 || ResolveBank(i) == 1)
                            bank1 = 1;
                        if (bank2 || ResolveBank(i) == 2)
                            bank2 = 1;
                        if (bank3 || ResolveBank(i) == 3)
                            bank3 = 1;
                    end
                end
                if (cnt_erase>0)
                begin
                    elapsed_erase = 0;
                    duration_erase = cnt_erase* tdevice_seo;
                    ->edone_event;
                    start_erase = $time;
                end
                else
                begin
                    EERR = 1'b1;
                    EERR <= #100000  1'b0;
                end
                if (!bank0 && BankLockedForErs(0))
                begin
                    EERR0 = 1'b1;
                    EERR0 <= #100000  1'b0;
                end
                if (!bank1 && BankLockedForErs(1))
                begin
                    EERR1 = 1'b1;
                    EERR1 <= #100000  1'b0;
                end
                if (!bank2 && BankLockedForErs(2))
                begin
                    EERR2 = 1'b1;
                    EERR2 <= #100000  1'b0;
                end
                if (!bank3 && BankLockedForErs(3))
                begin
                    EERR3 = 1'b1;
                    EERR3 <= #100000  1'b0;
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
//////////////////////////////
//Hardware Write Protection
//////////////////////////////


//    ///////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    ///////////////////////////////////////////////////////////////////////////
        reg PATTERN_1  = 1'b0;
        reg PATTERN_2  = 1'b0;
        reg A_PAT_1  = 1'b0;

        //DATA Low Byte
        integer DataLo   ;

    always @(negedge write)
    begin
        if (~write)
        begin
            DataLo = DIn[15:0];
            PATTERN_1 = (Addr==16'h555) && (DataLo==16'hAA) ;
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==16'h55) ;
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
                    else if ((Addr==8'h55) && (DataLo==16'h98))
                        next_state = CFI;
                    else if (DataLo == 16'h60)
                        next_state = SLU_Z001;
                    else
                        next_state = RESET;
                end
            end

            SLU_Z001 :
            begin
                if (~write)
                begin
                    if (DataLo == 16'h60)
                        next_state = SLU_PREL;
                    else
                        next_state = RESET;
                end
            end

            SLU_PREL :
            begin
                if (~write)
                begin
                    if (DataLo == 16'h60)
                        next_state = SLU;
                    else
                        next_state = RESET;
                end
            end

            SLU :
            begin
                if (~write)
                begin
                    if (DataLo == 16'hf0)
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
                    else if (A_PAT_1 && (DataLo==16'hC0))
                        next_state = RESET;
                    else
                        next_state = RESET;
                end
            end

            PREL_ULBYPASS :
            begin
                if (~write)
                begin
                    if (A_PAT_1 && (DataLo==16'h90))
                        next_state = AS;
                    else if (A_PAT_1 && (DataLo==16'hA0))
                        next_state = A0SEEN;
                    else if (A_PAT_1 && (DataLo==16'h80))
                        next_state = C8_PREL;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            CFI :
            begin
                if (~write)
                begin
                    if ((Addr==16'h55) && (DataLo==16'h98))
                        next_state = CFI;
                    else if (DataLo==16'hF0)
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
                    else if ((Addr==16'h55) && (DataLo==16'h98))
                        next_state = AS_CFI;
                    else
                        next_state = AS;
                end
            end

            A0SEEN :
            begin
                if (~write)
                    next_state = PGMS;
                else
                    next_state = A0SEEN;
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
                        if (DataLo == 16'hB0 && BankLockedForErs(BA))
                            next_state = ESPS; // ESP according to datasheet
                        else if (DataLo==16'h30)
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
                    if (DataLo == 16'h30 && BankLockedForErs(BA))
                        next_state = SERS_EXEC;
                    else if (ULBYPASS)
                    begin
                        if (DataLo == 16'h20)
                        begin
                        end
                        else if (A_PAT_1 && (DataLo == 16'hA0))
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
                    if ((Addr == 16'h55) && (DataLo == 16'h98))
                    begin
                    end
                    else if (DataLo == 16'hF0)
                        next_state = ESP;
                    else if (DataLo == 16'h30 && BankLockedForErs(BA))
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
                        // resret ULBYPASS
                        next_state = ESP;
                    else if ((Addr==16'h55) && (DataLo==16'h98))
                        next_state = AS_CFI;
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

    always @(posedge PDONE or negedge PERR)//reseted
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

    always @(posedge EDONE or negedge EERR)//reseted
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC))
            begin
                if (ULBYPASS)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = RESET;
            end
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
                    if (DataLo==16'hB0 && BankLockedForErs(BA))
                        next_state = ESPS;
        end
    end

    always @(CTMOUT or reseted or current_state)
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
    always @(posedge reseted)
    begin
        LB_P = -1;
        LB_A = -1;
        //ResetBankForErs_All(LB_Ei);
        ResetBankForErs_All(i);
        ConfRegData = 20'b11100101000000000000;
    end
    always @(PoweredUp)
    begin
        Sec_Prot = ~(0);
    end

    always @(posedge read)
    begin
        if (!burst_mode)
              ->oe_event;
    end

    always @(Address or SecAddr)
    begin
        if (read && !burst_mode)
             ->oe_event;
    end
    always @(Addr_cnt)
    begin
        if (burst_mode && read)
            -> oe_event;
    end
    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end
integer BurstBA;
integer BurstSA;
    always @(oe or reseted or current_state)
    begin
        if (oe)
        begin
            BurstBA = ResolveBankFromAddr(Addr_cnt);
            BurstSA = ResolveSectFromAddr(Addr_cnt);
        end
        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                if (oe)
                begin
                    MemRead(Dout_zd);
                end
            end

            SLU_Z001 :
            begin
            end

            Z001 :
            begin
            end

            CFI :
            begin
                if (oe)
                begin
                    CfiRead(Dout_zd);
                end
            end

            AS :
            begin
                if (oe)
                begin
                    if ((!burst_mode && LB_A == BA) ||
                       (burst_mode &&
                        Addr_cnt >= bsa(LB_A) && Addr_cnt <= bea(LB_A)))
                        AsRead(Dout_zd);
                    else
                        MemRead(Dout_zd);
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

                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end
            end

        SERS :
        begin
            if (oe)
            begin
                if (!burst_mode && BankLockedForErs(BA) ||
                     burst_mode && BankLockedForErs(BurstBA))
                begin
                    ///////////////////////////////////////////////////////////
                    //read status - sector erase timeout
                    ///////////////////////////////////////////////////////////
                    Status[3] = 1'b0;

                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end
                else
                    MemRead(Dout_zd);
            end
        end

        ESPS :
        begin
            if (oe)
            begin
                if (!burst_mode && BankLockedForErs(BA) ||
                     burst_mode && BankLockedForErs(BurstBA))
                begin
                    ///////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ///////////////////////////////////////////////////////////
                    Status[7] = 1'b0;
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    Status[2] = ~Status[2]; //toggle

                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end
                else
                    MemRead(Dout_zd);
            end
        end

        SERS_EXEC:
        begin
            if (oe)
            begin
                if (!burst_mode && BankLockedForErs(BA) ||
                     burst_mode && BankLockedForErs(BurstBA))
                begin
                            ///////////////////////////////////////////////////
                            //read status erase HANG
                            ///////////////////////////////////////////////////
                            //%el should never hang
                            Status[7] = 1'b0;
                            Status[6] = ~Status[6]; //toggle
                            Status[5] = 1'b0;
                            Status[3] = 1'b1;
                            Status[2] = ~Status[2]; //toggle

                            Dout_zd[7:0] = Status;
                            Dout_zd[15:8] = 8'bZ;
                end
                else
                    MemRead(Dout_zd);
            end
        end

        ESP :
        begin
            if (oe)
            begin
                if (!burst_mode && Ers_Queue[SecAddr] == 1 ||
                     burst_mode && BurstSA > -1 && Ers_Queue[BurstSA] == 1)
                begin
                    ///////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    // Status[6) No toggle
                    Status[5] = 1'b0;
                    Status[2] = ~Status[2]; //toggle

                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end

                ///////////////////////////////////////////////////////////
                //read
                ///////////////////////////////////////////////////////////
                else
                    MemRead(Dout_zd[15:0]);
            end
        end

        ESP_CFI :
        begin
            if (oe)
                CfiRead(Dout_zd);
        end

        ESP_AS :
        begin
            if (oe)
                if ((!burst_mode && LB_A == BA) ||
                     (burst_mode &&
                      Addr_cnt >= bsa(LB_A) && Addr_cnt <= bea(LB_A)))
                    AsRead(Dout_zd);
                else if (Ers_Queue[SecAddr] != 1)
                    MemRead(Dout_zd);
                else
                begin
                    ///////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    // Status[6) No toggle
                    Status[5] = 1'b0;
                    Status[2] = ~Status[2]; //toggle

                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end
        end

        AS_CFI :
        begin
            if (oe)
                CfiRead(Dout_zd);
        end

        PGMS :
        begin
            if (oe)
                if ((!burst_mode && LB_P == BA) ||
                      (burst_mode && LB_P == BurstBA))
                begin
                    ///////////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////////
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    //Status[2) no toggle
                    Status[1] = 1'b0;
                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end
                else if (ESP_ACT == 1 &&
                      ((!burst_mode && Ers_Queue[SecAddr] == 1) ||
                       (burst_mode && BurstSA >-1 && Ers_Queue[BurstSA] == 1)))
                begin
                    ///////////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    // Status[6] no toggle
                    Status[5] = 1'b0;
                    Status[2] = ~Status[2];// toggle
                    Status[1] = 1'b0;
                    Dout_zd[7:0] = Status;
                    Dout_zd[15:8] = 8'bZ;
                end
                else
                    MemRead(Dout_zd);
        end

        endcase
        end
    end
//*******************************************
integer lock;
reg[HiAddrBit:0] tmp_addr;

    always @(negedge write or reseted)
    begin : Output_generation
        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                ESP_ACT   = 1'b0;
                if (~write)
                begin
                end
            end

            SLU_PREL :
            begin
                if (~write)
                    if (DataLo == 16'h60)
                    begin
                        tmp_addr = Address;
                        if (tmp_addr[6] == 0)
                            lock = 1;
                        else
                            lock = 0;
                        Sec_Prot[SecAddr] = lock;
                    end
            end

            SLU :
            begin
                if (~write)
                    if (DataLo == 16'h60)
                    begin
                        tmp_addr = Address;
                        if (tmp_addr[6] == 0)
                            lock = 1;
                        else
                            lock = 0;
                        Sec_Prot[SecAddr] = lock;
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
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==16'h90))
                    begin
                        ULBYPASS = 1'b0;
                        LB_A = BA;
                    end
                    else if (A_PAT_1 && (DataLo==16'hC0))
                        ConfRegData = CR_Addr;
                end
            end

            PREL_ULBYPASS :
            begin
                if (~write)
                begin
                    if (DataLo==16'h20)
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo==16'h90))
                        LB_A = BA;
                end
            end

            CFI :
            begin
            end

            AS :
            begin
                if (~write)
                    if (DataLo==16'hF0)
                    begin
                        LB_A = -1;
                        ULBYPASS  = 1'b0;
                    end
            end

            A0SEEN :
            begin
                if (~write)
                begin
                    LB_P = BA;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;

                    WBData = DataLo;
                    WBAddr = Address;// % 32;
                    SA = SecAddr;
                    temp = DataLo;
                    Status[7] = ~temp[7];
                end
            end

            C8 :
            begin
                if (~write)
                    if (PATTERN_1)
                    begin
                    end
                    //else ULBYPASS  = 1'b0;
            end

            C8_Z001 :
            begin
            end

            C8_PREL :
            begin
                if (~write)  
                    if (A_PAT_1 && (DataLo==16'h10))
                    begin
                        for(i=0; i<=BankNum; i=i+1)
                            LB_Ei[i] = i;
                        //Start Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_Queue = ~(0);
                        Status = 8'b00001000;
                    end
                    else if (DataLo==16'h30)
                    begin
                        AddBankForErs(BA);
                        //put selected sector to sec. ers. queue
                        //start timeout
                        Ers_Queue = 0;
                        Ers_Queue[SecAddr] = 1'b1;
                        CTMOUT_in = 1'b1;
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
                        if (DataLo == 16'hB0 && BankLockedForErs(BA))
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
                            AddBankForErs(BA);
                            disable TCTMOUTr;
                            CTMOUT_in = 1'b0;
                            CTMOUT_in <= #1 1'b1;
                            Ers_Queue[SecAddr] = 1'b1;
                        end
                        else
                            ResetBankForErs_All(i);
                    end
                end
            end

            SERS_EXEC :
            begin

            if (~write)
                if (~EDONE && (EERR!=1'b1))
                    if (DataLo==16'hB0 && BankLockedForErs(BA))
                    begin
                        ESUSP  = 1'b1;
                        START_T1_in = 1'b1;
                    end
            end

            ESP :
            begin
                if (~write)
                begin
                    if (DataLo == 16'h30 && BankLockedForErs(BA))
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
                        else if (A_PAT_1 && DataLo == 16'h90)
                            LB_A = BA;
                    end
                end
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
                    else if (A_PAT_1 && DataLo == 16'h90)
                        LB_A = BA;
                end
            end

            ESP_CFI :
            begin
                if (~write)
                begin
                    if (DataLo == 16'hF0)
                        ESP_ACT = 1'b1;
                    else if (DataLo == 16'h30 && BankLockedForErs(BA))
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
                    LB_P = BA;
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
                    begin
                        // resret ULBYPASS
                        ULBYPASS = 1'b0;
                        LB_A = -1;
                    end
            end

            AS_CFI :
            begin
                if (~write)
                    if (DataLo == 16'hF0)
                    begin
                    end
            end

            PGMS :
            begin
            end

        endcase
        end
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
                    for (j=0;j<=SectSize(i);j=j+1)//size of sect
                        Mem[ssa(i)+j] = -1;
            end
            if (EDONE)
                for (i=0;i<=SecNum;i=i+1)
                begin
                    begin
                        if (Sec_Prot[i]!=1'b1)
                            for (j=0;j<=SectSize(i);j=j+1)
                                Mem[ssa(i)+j] = MaxData;
                    end
                end
    end
end

always @(posedge EDONE or negedge EERR)
begin : ResetBank
    if (current_state==ERS || current_state == SERS_EXEC)
        ResetBankForErs_All(i);
end

    always @(CTMOUT or current_state)
    begin : SERS2
        if (current_state==SERS)
        begin
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                //ESTART = '1', '0' AFTER 1 ns;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
                ESUSP  = 1'b0;
                ERES   = 1'b0;
            end
        end
    end

    always @(START_T1 or current_state)
    begin : ESPS2
        if (current_state==ESPS)
        begin
            CTMOUT_in = 1'b0;
            if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
                ESUSP = 1'b0;
            end
        end
    end

    always @(current_state or EERR or EDONE)
    begin: SERS_EXEC2
    integer i,j;
        if (current_state==SERS_EXEC)
        begin
            if (EERR!=1'b1)
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if (Sec_Prot[i]!=1'b1 && Ers_Queue[i])
                        for (j=0;j<=SectSize(i);j=j+1)
                            Mem[ssa(i)+j] = -1;
                end

                if (EDONE)
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        if (Sec_Prot[i]!=1'b1 && Ers_Queue[i])
                            for (j=0;j<=SectSize(i);j=j+1)
                               Mem[ssa(i)+j] = MaxData;
                    end
            end
        end
    end
always @(negedge EERR0)
begin : ResetBank0
    if (current_state == SERS_EXEC)
        ResetBankForErs(0);
end

always @(negedge EERR1)
begin : ResetBank1
    if (current_state == SERS_EXEC)
        ResetBankForErs(1);
end

always @(negedge EERR2)
begin : ResetBank2
    if (current_state == SERS_EXEC)
        ResetBankForErs(2);
end

always @(negedge EERR3)
begin : ResetBank3
    if (current_state == SERS_EXEC)
        ResetBankForErs(3);

end

    always @(current_state or posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
    integer i,j;
        if (current_state==PGMS)
        begin
            if (PERR!=1'b1)
            begin
                new_int= WBData;
                old_int=Mem[ssa(SA)+WBAddr];
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
                    WBData= new_int;
                end
                else
                    WBData= -1;
                Mem[ssa(SA)+WBAddr] = -1;

                if (PDONE && ~PSTART)//PSATRT???
                begin
                    Mem[ssa(SA)+WBAddr] = WBData;
                    WBData= -1;
                end
            end
        end
    end

always @(posedge PDONE or negedge PERR)
begin : ResetProgrammingBank
    if (current_state == PGMS)
        LB_P = -1;
end
    always @(gCE_n or gOE_n or RESETNeg or RST)
    begin
        //Output Disable Control
        if (gCE_n || gOE_n || (~RESETNeg && ~RST))
            Dout_zd = 16'bZ;
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
        CFI_array[16'h1B] = 16'h17;
        CFI_array[16'h1C] = 16'h19;
        CFI_array[16'h1D] = 16'h00;
        CFI_array[16'h1E] = 16'h00;
        CFI_array[16'h1F] = 16'h04;
        CFI_array[16'h20] = 16'h00;
        CFI_array[16'h21] = 16'h09;
        CFI_array[16'h22] = 16'h00;
        CFI_array[16'h23] = 16'h04;
        CFI_array[16'h24] = 16'h00;
        CFI_array[16'h25] = 16'h04;
        CFI_array[16'h26] = 16'h00;
        //device geometry definition
        CFI_array[16'h27] = 16'h17;
        CFI_array[16'h28] = 16'h01;
        CFI_array[16'h29] = 16'h00;
        CFI_array[16'h2A] = 16'h00;
        CFI_array[16'h2B] = 16'h00;
        CFI_array[16'h2C] = 16'h03;
        CFI_array[16'h2D] = 16'h03;
        CFI_array[16'h2E] = 16'h00;
        CFI_array[16'h2F] = 16'h40;
        CFI_array[16'h30] = 16'h00;
        CFI_array[16'h31] = 16'h7D;
        CFI_array[16'h32] = 16'h00;
        CFI_array[16'h33] = 16'h00;
        CFI_array[16'h34] = 16'h01;
        CFI_array[16'h35] = 16'h03;
        CFI_array[16'h36] = 16'h00;
        CFI_array[16'h37] = 16'h40;
        CFI_array[16'h38] = 16'h00;
        CFI_array[16'h39] = 16'h00;
        CFI_array[16'h3A] = 16'h00;
        CFI_array[16'h3B] = 16'h00;
        CFI_array[16'h3C] = 16'h00;
        CFI_array[16'h3D] = 16'h00;
        CFI_array[16'h3E] = 16'h00;
        CFI_array[16'h3F] = 16'h00;
        //primary vendor-specific extended query
        CFI_array[16'h40] = 16'h50;
        CFI_array[16'h41] = 16'h52;
        CFI_array[16'h42] = 16'h49;
        CFI_array[16'h43] = 16'h31;
        CFI_array[16'h44] = 16'h33;
        CFI_array[16'h45] = 16'h04;
        CFI_array[16'h46] = 16'h02;
        CFI_array[16'h47] = 16'h01;
        CFI_array[16'h48] = 16'h00;
        CFI_array[16'h49] = 16'h05;
        CFI_array[16'h4A] = 16'h63;
        CFI_array[16'h4B] = 16'h01;
        CFI_array[16'h4C] = 16'h00;
        CFI_array[16'h4D] = 16'hB5;
        CFI_array[16'h4E] = 16'hC5;
        if (vs)//top architeture
            CFI_array[16'h4F] = 16'h02;
        else
            CFI_array[16'h4F] = 16'h03;
        CFI_array[16'h50] = 16'h00;
        CFI_array[16'h51] = 16'h00;
        CFI_array[16'h52] = 16'h00;
        CFI_array[16'h53] = 16'h00;
        CFI_array[16'h54] = 16'h00;
        CFI_array[16'h55] = 16'h00;
        CFI_array[16'h56] = 16'h00;
        CFI_array[16'h57] = 16'h04;
        CFI_array[16'h58] = 16'h23;
        CFI_array[16'h59] = 16'h20;
        CFI_array[16'h5A] = 16'h20;
        CFI_array[16'h5B] = 16'h23;
    end

    always @(ConfRegData)
    begin
        if (ConfRegData[19] == 1'b0)
            burst_mode = 1;
        else
            burst_mode = 0;
    end

    always @(CLK_ipd)
    begin : CLK_active_edge
        if (ConfRegData[17] == 1'b1)
            CLK_active = CLK;
        else
            CLK_active = ~CLK;
    end

//RDY control
    integer active_algo_rdy;
    integer BurstSA_rdy;
    always @(tIACC_cnt_dwn, Addr_cnt, gOE_n, gCE_n)
    begin : RDY_gen_proc
        if (~gOE_n && ~gCE_n && burst_mode)
        begin
            if (ConfRegData[18] == 1'b1 &&
                tIACC_cnt_dwn >0)
                RDY_zd = 1'b0;
            else if (ConfRegData[18] == 1'b0)
            begin
                BurstSA_rdy = ResolveSectFromAddr(((Addr_cnt +1) % (MemSize +1)));
                ActiveAlgo(active_algo_rdy,
                    ((Addr_cnt +1) % (MemSize +1)), BurstSA_rdy);

                if (ConfRegData[16:15] == 0 &&
                    tIACC_cnt_dwn == 0 &&
                    ((Addr_cnt % 8'h40) == 8'h3F) &&
                    active_algo_rdy)
                    RDY_zd = 1'b0;
                else if ((tIACC_cnt_dwn > 1) ||
                    (((Addr_cnt % 8'h40) == 8'h3E) &&
                    ((Whole_Addr % 8'h40) != 8'h3E) &&
                    ((Whole_Addr % 8'h40) != 8'h3F) &&
                    ConfRegData[16:15] == 0) ||
                    (((Addr_cnt % 8'h40) == 8'h3E) &&
                    !reduced_hnd &&
                    ((Whole_Addr % 8'h40) == 8'h3E) &&
                    ConfRegData[16:15] == 0))

                    RDY_zd = 1'b0;
                else
                    RDY_zd = 1'b1;
            end
            else
                RDY_zd = 1'b1;
        end
            if (gOE_n || gCE_n || (~RESETNeg && ~RST))
                RDY_zd = 1'bZ;
    end

//tIACC_cnt_dwn
    reg [HiAddrBit:0] Latched_Addr;
    integer bound_cross_loc;
    integer bound_cross_loc_active;
    always @(LA)//, CLK_active, bound_cross, bound_cross_active)
    begin
        if (burst_mode)
            if (LA)//rising edge
            begin
                disable dec_tiacc;
                Latched_Addr = Whole_Addr;
                bound_cross_loc = 0;
                bound_cross_loc_active = 0;
                LoadtIACC(Latched_Addr, ConfRegData, bound_cross_loc,
                bound_cross_loc_active, tIACC_cnt_dwn);
            end
     end

    always @(bound_cross)//, CLK_active, bound_cross, bound_cross_active)
    begin
        if (burst_mode)
            if (bound_cross == 1)//rising edge
            begin
                bound_cross_loc = 1;
                bound_cross_loc_active = 0;
                LoadtIACC(Latched_Addr, ConfRegData, bound_cross_loc,
                bound_cross_loc_active, tIACC_cnt_dwn);
            end
     end

    always @(bound_cross_active)//, CLK_active, bound_cross, bound_cross_active)
    begin
        if (burst_mode)
            if (bound_cross_active == 1)//rising edge
            begin
                bound_cross_loc = 0;
                bound_cross_loc_active = 1;
                LoadtIACC(Latched_Addr, ConfRegData, bound_cross_loc,
                bound_cross_loc_active, tIACC_cnt_dwn);
            end
     end
    always @(CLK_active)//, CLK_active, bound_cross, bound_cross_active)
    begin : dec_tiacc
        if (burst_mode)
            if (CLK_active == 1 && tIACC_cnt_dwn != 0)//rising edge
            begin
                #1 tIACC_cnt_dwn = tIACC_cnt_dwn -1;
            end
     end
//burst read

integer Start_Addr;
integer Addr_cnt_l;


    always @ (read or tIACC_cnt_dwn)
    begin
        if (burst_mode == 1)
            if (read && tIACC_cnt_dwn == 0)
            begin
               //disable burst_read_proc_cnt_dwn;
               Addr_cnt = Addr_cnt_l;
            end
            if (~read)
                Addr_cnt = -1;
    end
    always @(LA)
    begin : burst_read_proc
    if (burst_mode)
        if (LA)
        begin
            Addr_cnt_l = Whole_Addr;
            Start_Addr = Whole_Addr;
            max_wrap_thr = 0;
        end
    end
integer  active_algo_clk;
integer  BurstSA_clk;
    always @(CLK_active)
    begin : burst_read_proc_cnt_dwn
    if (burst_mode)
        if (read && tIACC_cnt_dwn == 0)
            if (CLK_active == 1 && enable_cnt)
            begin
                IncrAddr_cnt(Addr_cnt_l, Start_Addr);
                if ((Addr_cnt_l % 8'h40) == 8'h3F)
                begin
                    bound_cross = 1'b1;
                    bound_cross = #1 1'b0;
                end
                BurstSA_clk = ResolveSectFromAddr(((Addr_cnt +1) % (MemSize +1)));
                ActiveAlgo(active_algo_clk,
                    ((Addr_cnt +1) % (MemSize +1)), BurstSA_clk);
                if (active_algo_clk)
                begin
                    Addr_cnt = -1;
                    bound_cross_active = 1'b1;
                    bound_cross_active = #1 1'b0;
                end
                else
                    Addr_cnt = Addr_cnt_l;
            end
    end

//enable counter
integer  active_algo_en;
integer  BurstSA_en;
    always @(Addr_cnt, LB_P)
    begin : enable_addr_cnt
        BurstSA_en = ResolveSectFromAddr(Addr_cnt);
        ActiveAlgo(active_algo_en, Addr_cnt, BurstSA_en);

        if (active_algo_en)
            enable_cnt = 1'b0;
    end
    always @(LA)
    begin
        enable_cnt = 1'b1;
    end

////////////////////////////
//PROCEDURES AND FUNCTIONS
////////////////////////////

///////////////////////////////
//Sector and Address functions
//////////////////////////////
function integer SectSize;
input integer i;
begin
    SectSize = 0;
    if (i >= 4 && i <= 129)
        SectSize = SecSize_l;
    else
        SectSize = SecSize_s;
end
endfunction

function integer ssa;
input integer i;
begin
    if (i <= 3)
        ssa = (SectSize(i)+1)*i;
    else if (i <= 129)
        ssa = (SectSize(i)+1)*(i-3);
    else
        ssa = 24'h3f8000 + (SectSize(i)+1)*(i-130);
end
endfunction

function integer sea;
input integer i;
begin
    if (i <= 3)
        sea = (SectSize(i)+1)*(i+1) -1;
    else if (i <= 129)
        sea = (SectSize(i)+1)*(i-3+1) - 1;
    else
        sea = 24'h3f8000 + (SectSize(i)+1)*(i-130+1) - 1;
end
endfunction

task RestoreSectAddr;
input reg [HiAddrBit:0] A;
inout integer SecAddr;
inout integer A_tmp;
integer SA_tmp;
begin
    SA_tmp = A[HiAddrBit:15];
    if (SA_tmp == 0)
    begin
        SecAddr = SA_tmp + A[14:13];
        A_tmp = A[12:0];
    end
    else if (SA_tmp <SecNum - BootSecNum +1)
    begin
        SecAddr = SA_tmp + 3;
        A_tmp = A[14:0];
    end
    else
    begin
        SecAddr = SA_tmp + 3 + A[14:13];
        A_tmp = A[12:0];
    end
end
endtask

///////////////////////
//Bank Access
//////////////////////
function integer bsa;
input integer bank;
begin
    if (bank == 0)
        bsa = ssa(0);
    else if (bank == 1)
        bsa = ssa(35);
    else if (bank == 2)
        bsa = ssa(67);
    else
        bsa = ssa(99);
end
endfunction

function integer bea;
input integer bank;
begin
    if (bank == 0)
        bea = sea(34);
    else if (bank == 1)
        bea = sea(66);
    else if (bank == 2)
        bea = sea(98);
    else
        bea = sea(133);
end
endfunction

function integer ResolveBank;
input integer sect;
begin
    if (sect <= 34)
        ResolveBank = 0;
    else if (sect <= 66)
        ResolveBank = 1;
    else if (sect <= 98)
        ResolveBank = 2;
    else
        ResolveBank = 3;
end
endfunction

function integer ResolveBankFromAddr;
input integer Addr_cnt;
begin
    ResolveBankFromAddr = -1;
    if (Addr_cnt >= 0)
        for(i=0; i<= BankNum; i=i+1)
            if (Addr_cnt >= bsa(i) && Addr_cnt <= bea(i))
                ResolveBankFromAddr = i;
end
endfunction

function integer ResolveSectFromAddr;
input integer Addr_cnt;
begin
    ResolveSectFromAddr = -1;
    if (Addr_cnt >= 0)
        for(i=0; i<=SecNum; i=i+1)
            if (Addr_cnt>= ssa(i) && Addr_cnt <= sea(i))
                ResolveSectFromAddr = i;
end
endfunction

function integer BankLockedForErs;
input integer BA;
begin
    BankLockedForErs = 0;
    if (BA >= 0)
        for (i=0; i<=BankNum; i = i+1)
            if (LB_Ei[i] == BA)
                BankLockedForErs = 1;
end
endfunction

task AddBankForErs;
input integer BA;
integer found;
integer i;
begin
    found = 0;
    i = 0;
    for (i=0; i <= BankNum; i=i+1)
        if (LB_Ei[i] == BA)
            found = 1;
    i = 0;
    while ((i <= BankNum) && (found != 1))
    begin
        if (LB_Ei[i] == -1)
        begin
            found = 1;
            LB_Ei[i] = BA;
        end
        i = i + 1;
    end
end
endtask

task ResetBankForErs;
input integer BA;
begin
    for (i=0; i <= BankNum; i=i+1)
        if (LB_Ei[i] == BA)
            LB_Ei[i] = -1;
end
endtask

task ResetBankForErs_All;
input integer m;
begin
    for(i=0; i<= BankNum; i=i+1)
        LB_Ei[i] = -1;
end
endtask

/////////////////////////////
//Address counter functions
/////////////////////////////
task IncrAddr_cnt;
inout integer Addr_cnt;
input integer Start_Addr;
integer mode;
integer Seg_SA;
begin
    mode = ConfRegData[16:15];
    if (mode == 3)
        mode = mode + 1;
    if (mode == 0)
        if (Addr_cnt == MemSize)
           Addr_cnt = 0;
        else
           Addr_cnt = Addr_cnt + 1;
    else
        if (max_wrap_thr < 127)
        begin
            Seg_SA = (Start_Addr/(mode*8))*(mode*8);
            if (Addr_cnt == Seg_SA + (mode*8) - 1)
                Addr_cnt = Seg_SA;
            else
                Addr_cnt = Addr_cnt + 1;
            max_wrap_thr =max_wrap_thr + 1;
        end
end
endtask

task LoadtIACC;
input reg[HiAddrBit:0] Address;
input reg[HiConfBit:0] ConfRegData;
input integer bound_cross;
input integer bound_cross_active;
inout integer tIACC;

integer mode;
integer lat;
integer Addr_local;
integer tmp_tIACC;
begin
    mode = ConfRegData[16:15];
    tmp_tIACC = 0;
    lat = ConfRegData[14:12];

    if (bound_cross_active)
        Addr_local = 0;
    else
        Addr_local = Address%16'h40;
    if (!bound_cross && !bound_cross_active &&
        !reduced_hnd && mode == 0 && Addr_local == 16'h3F)
        begin
        if (AVDNeg == 0)
            tmp_tIACC = 2*(lat + 2) -1;
        else
            tmp_tIACC = 2*(lat + 2);
        end
    else if (bound_cross && mode != 0)
        tmp_tIACC = 0;
    else if (bound_cross && reduced_hnd)
        if (Addr_local == 8'h3f || Addr_local == 8'h3e)
            tmp_tIACC = 0;
        else
            tmp_tIACC = 2;
    else
    begin
        if (AVDNeg == 0)
            tmp_tIACC = lat + 2 - 1;
        else
        begin
            tmp_tIACC = lat + 2;
        end

        if (reduced_hnd)
        begin
            if ((Addr_local % 2) == 1)
                tmp_tIACC = tmp_tIACC + 1;
            if (mode == 0)
                if (Addr_local == 8'h3d)
                    tmp_tIACC = tmp_tIACC + 1;
                else if (Addr_local == 8'h3e)
                    tmp_tIACC = tmp_tIACC + 2;
                else if (Addr_local == 8'h3f)
                    tmp_tIACC = tmp_tIACC + 3;
        end
    end
    tIACC = tmp_tIACC;
end
endtask

task ActiveAlgo;
inout integer active_algo;
input integer Addr_cnt;
input integer BurstSA;
begin
    active_algo = 0;
    active_algo = ((LB_P > -1) &&
        (Addr_cnt >= bsa(LB_P)) &&
        (Addr_cnt <= bea(LB_P)));
    if (!active_algo)
        active_algo = ((LB_A > -1) &&
            (Addr_cnt >= bsa(LB_A)) &&
            (Addr_cnt <= bea(LB_A)));
    if ((ESP_ACT == 0) ||
        (ESP_ACT == 1 && (BurstSA > -1) && Ers_Queue[BurstSA] == 1))
        begin
            i = 0;
            while (!active_algo && i <= BankNum)
            begin
                active_algo = ((LB_Ei[i] > -1) &&
                               (Addr_cnt >= bsa(LB_Ei[i])) &&
                               (Addr_cnt <= bea(LB_Ei[i])));
                i = i+1;
            end
        end
end
endtask

task MemRead;
inout [15:0] Dout_zd;
integer A_tmp;

begin
    if (burst_mode == 0)
        A_tmp = ssa(SecAddr) + Address;
    else
        A_tmp = Addr_cnt;

    if (A_tmp < 0)
        Dout_zd = 16'bX;
    else
        if (Mem[A_tmp] == -1)
            Dout_zd = 16'bX;
        else
            Dout_zd = Mem[A_tmp];
end
endtask

task AsRead;
inout [15:0] Dout_zd;
integer A_tmp;
integer SA_tmp;
integer SA;
reg [HiAddrBit:0] A;
begin
    if (!burst_mode)
    begin
        A_tmp = Address;
        SA_tmp = SecAddr;
    end
    else
    begin
        A = Addr_cnt;
        SA = A[HiAddrBit:15];

        if (SA == 0)
        begin
            SA_tmp = SA + A[14:13];
            A_tmp = A[12:0];
        end
        else if (SA < SecNum - BootSecNum + 1)
        begin
            SA_tmp = SA + 3;
            A_tmp = A[14:0];
        end
        else
        begin
            SA_tmp = SA + 3 + A[14:13];
            A_tmp = A[12:0];
        end
    end

    if (A_tmp == 1 || A_tmp == 16'h0E || A_tmp == 16'h0F)
        Dout_zd[15:8] = 16'h22;
    else
        Dout_zd[15:8] = 0;

    if (A_tmp == 0)
        Dout_zd [7:0] = 1;
    else if (A_tmp == 1)
        Dout_zd [7:0] = 8'h7E;
    else if (A_tmp == 2)
    begin
        Dout_zd [7:1] = 0;
        Dout_zd[0] = Sec_Prot[SA_tmp];
    end
    else if (A_tmp == 3)
        if (reduced_hnd)
            Dout_zd[7:0] = 8'h43;
        else
            Dout_zd[7:0] = 8'h42;
    else if (A_tmp == 16'h0E)
        if (vs)
            Dout_zd [7:0] = 8'h04;
        else
            Dout_zd [7:0] = 8'h24;
    else if (A_tmp == 16'h0F)
            Dout_zd [7:0] = 1;
    else
    begin
        Dout_zd = 16'bZ;
        $display("Invalid AS address");
    end
end
endtask

task CfiRead;
inout [15:0] Dout_zd;
integer Addr;
begin
    if (!burst_mode)
        Addr = ssa(SecAddr) + Address;
    else
        Addr = Addr_cnt;

    Dout_zd[15:0] = 16'b0;
    if ((Addr>=MinCfiAddr)&&(Addr<=MaxCfiAddr))
         Dout_zd[15:0] = CFI_array[Addr];
    else
    begin
        Dout_zd[15:0] = 16'bZ;
        $display ("Invalid CFI query address");
    end
end
endtask

endmodule

module VITALbuf ( OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule

module sram_8
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

    CE1Negs  ,
    CE2s     ,
    OENeg    ,
    WENeg    ,

    LBNegs   ,
    UBNegs

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

    input  CE1Negs  ;
    input  CE2s     ;
    input  OENeg    ;
    input  WENeg    ;
    input  LBNegs   ;
    input  UBNegs   ;

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



    wire  CE1Negs_ipd  ;
    wire  CE2s_ipd     ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;

    wire  LBNegs_ipd   ;
    wire  UBNegs_ipd   ;

    wire  DQ15_z  ;
    wire  DQ14_z  ;
    wire  DQ13_z  ;
    wire  DQ12_z  ;
    wire  DQ11_z  ;
    wire  DQ10_z  ;
    wire  DQ9_z   ;
    wire  DQ8_z   ;
    wire  DQ7_z   ;
    wire  DQ6_z   ;
    wire  DQ5_z   ;
    wire  DQ4_z   ;
    wire  DQ3_z   ;
    wire  DQ2_z   ;
    wire  DQ1_z   ;
    wire  DQ0_z   ;

    reg [15 : 0] Dout_zd;
    reg [15 : 0] Dout_z;
    assign {DQ15_z,
            DQ14_z,
            DQ13_z,
            DQ12_z,
            DQ11_z,
            DQ10_z,
            DQ9_z,
            DQ8_z,
            DQ7_z,
            DQ6_z,
            DQ5_z,
            DQ4_z,
            DQ3_z,
            DQ2_z,
            DQ1_z,
            DQ0_z  } = Dout_z;


    parameter UserPreload     = 1'b0;
    parameter sram_file_name   = "none";
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID        = "sram";
    parameter MaxData_S     = 16'hFFFF;
    parameter SramSize      = 20'h7FFFF;
    parameter HiAddrBitSram = 18;

    //Command Register
    reg write ;
    reg read  ;

    //Address
    integer Address             = 0;

    integer SramMem[0:SramSize];

    // timing check violation
    reg Viol = 1'b0;
/////////////////

    time OEDQ_t;
    time CE1DQ_t;
    time CE2DQ_t;
    time ADDRDQ_t;
    time LBDQ_t;
    time UBDQ_t;
    time OEDQ_open_t;
    time CE1DQ_open_t;
    time CE2DQ_open_t;
    time ADDRDQ_open_t;
    time LBDQ_open_t;
    time UBDQ_open_t;

    time OENeg_event;
    time CE1Neg_event;
    time CE2_event;
    time ADDR_event;
    time UBNeg_event;
    time LBNeg_event;
    time wait_time;
    reg FROMOE;
    reg FROMCE1;
    reg FROMCE2;
    reg FROMLB;
    reg FROMUB;
    integer Open3state = 0;
    integer Open3state_lo = 0;
    integer Open3state_hi = 0;
    integer OEDQ_01;
    integer CE1DQ_01;
    integer ADDRDQ_01;
    integer LBDQ_01;

    integer OEDQ_1z;
    integer CE1DQ_1z;
    integer LBDQ_1z;

    reg[7:0] TempData;
    reg[7:0] TempData1;

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

 buf   (CE1Negs_ipd   , CE1Negs   );
 buf   (CE2s_ipd      , CE2s      );
 buf   (OENeg_ipd     , OENeg    );
 buf   (WENeg_ipd     , WENeg    );
 buf   (UBNegs_ipd    , UBNegs    );
 buf   (LBNegs_ipd    , LBNegs    );
///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ15,   DQ15_z , 1);
    nmos   (DQ14,   DQ14_z , 1);
    nmos   (DQ13,   DQ13_z , 1);
    nmos   (DQ12,   DQ12_z , 1);
    nmos   (DQ11,   DQ11_z , 1);
    nmos   (DQ10,   DQ10_z , 1);
    nmos   (DQ9 ,   DQ9_z  , 1);
    nmos   (DQ8 ,   DQ8_z  , 1);
    nmos   (DQ7 ,   DQ7_z  , 1);
    nmos   (DQ6 ,   DQ6_z  , 1);
    nmos   (DQ5 ,   DQ5_z  , 1);
    nmos   (DQ4 ,   DQ4_z  , 1);
    nmos   (DQ3 ,   DQ3_z  , 1);
    nmos   (DQ2 ,   DQ2_z  , 1);
    nmos   (DQ1 ,   DQ1_z  , 1);
    nmos   (DQ0 ,   DQ0_z  , 1);

    wire deg;
    wire cs_sram;
    wire cs_sram_read;
    wire cs_sram_write;
    wire cs_write_deg;

    assign cs_sram =  ~CE1Negs && CE2s;
    assign cs_sram_read =  read;
    assign cs_sram_write =  write;
    assign cs_write_deg = write && deg;

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
    specparam           tpd_A0_DQ8              =1;
    specparam           tpd_A0_DQ9              =1;
    specparam           tpd_A0_DQ10              =1;
    specparam           tpd_A0_DQ11              =1;
    specparam           tpd_A0_DQ12              =1;
    specparam           tpd_A0_DQ13              =1;
    specparam           tpd_A0_DQ14              =1;
    specparam           tpd_A0_DQ15              =1;
    specparam           tpd_A1_DQ0              =1;
    specparam           tpd_A1_DQ1              =1;
    specparam           tpd_A1_DQ2              =1;
    specparam           tpd_A1_DQ3              =1;
    specparam           tpd_A1_DQ4              =1;
    specparam           tpd_A1_DQ5              =1;
    specparam           tpd_A1_DQ6              =1;
    specparam           tpd_A1_DQ7              =1;
    specparam           tpd_A1_DQ8              =1;
    specparam           tpd_A1_DQ9              =1;
    specparam           tpd_A1_DQ10              =1;
    specparam           tpd_A1_DQ11              =1;
    specparam           tpd_A1_DQ12              =1;
    specparam           tpd_A1_DQ13              =1;
    specparam           tpd_A1_DQ14              =1;
    specparam           tpd_A1_DQ15              =1;
    specparam           tpd_A2_DQ0              =1;
    specparam           tpd_A2_DQ1              =1;
    specparam           tpd_A2_DQ2              =1;
    specparam           tpd_A2_DQ3              =1;
    specparam           tpd_A2_DQ4              =1;
    specparam           tpd_A2_DQ5              =1;
    specparam           tpd_A2_DQ6              =1;
    specparam           tpd_A2_DQ7              =1;
    specparam           tpd_A2_DQ8              =1;
    specparam           tpd_A2_DQ9              =1;
    specparam           tpd_A2_DQ10              =1;
    specparam           tpd_A2_DQ11              =1;
    specparam           tpd_A2_DQ12              =1;
    specparam           tpd_A2_DQ13              =1;
    specparam           tpd_A2_DQ14              =1;
    specparam           tpd_A2_DQ15              =1;
    specparam           tpd_A3_DQ0              =1;
    specparam           tpd_A3_DQ1              =1;
    specparam           tpd_A3_DQ2              =1;
    specparam           tpd_A3_DQ3              =1;
    specparam           tpd_A3_DQ4              =1;
    specparam           tpd_A3_DQ5              =1;
    specparam           tpd_A3_DQ6              =1;
    specparam           tpd_A3_DQ7              =1;
    specparam           tpd_A3_DQ8              =1;
    specparam           tpd_A3_DQ9              =1;
    specparam           tpd_A3_DQ10              =1;
    specparam           tpd_A3_DQ11              =1;
    specparam           tpd_A3_DQ12              =1;
    specparam           tpd_A3_DQ13              =1;
    specparam           tpd_A3_DQ14              =1;
    specparam           tpd_A3_DQ15              =1;
    specparam           tpd_A4_DQ0              =1;
    specparam           tpd_A4_DQ1              =1;
    specparam           tpd_A4_DQ2              =1;
    specparam           tpd_A4_DQ3              =1;
    specparam           tpd_A4_DQ4              =1;
    specparam           tpd_A4_DQ5              =1;
    specparam           tpd_A4_DQ6              =1;
    specparam           tpd_A4_DQ7              =1;
    specparam           tpd_A4_DQ8              =1;
    specparam           tpd_A4_DQ9              =1;
    specparam           tpd_A4_DQ10              =1;
    specparam           tpd_A4_DQ11              =1;
    specparam           tpd_A4_DQ12              =1;
    specparam           tpd_A4_DQ13              =1;
    specparam           tpd_A4_DQ14              =1;
    specparam           tpd_A4_DQ15              =1;
    specparam           tpd_A5_DQ0              =1;
    specparam           tpd_A5_DQ1              =1;
    specparam           tpd_A5_DQ2              =1;
    specparam           tpd_A5_DQ3              =1;
    specparam           tpd_A5_DQ4              =1;
    specparam           tpd_A5_DQ5              =1;
    specparam           tpd_A5_DQ6              =1;
    specparam           tpd_A5_DQ7              =1;
    specparam           tpd_A5_DQ8              =1;
    specparam           tpd_A5_DQ9              =1;
    specparam           tpd_A5_DQ10              =1;
    specparam           tpd_A5_DQ11              =1;
    specparam           tpd_A5_DQ12              =1;
    specparam           tpd_A5_DQ13              =1;
    specparam           tpd_A5_DQ14              =1;
    specparam           tpd_A5_DQ15              =1;
    specparam           tpd_A6_DQ0              =1;
    specparam           tpd_A6_DQ1              =1;
    specparam           tpd_A6_DQ2              =1;
    specparam           tpd_A6_DQ3              =1;
    specparam           tpd_A6_DQ4              =1;
    specparam           tpd_A6_DQ5              =1;
    specparam           tpd_A6_DQ6              =1;
    specparam           tpd_A6_DQ7              =1;
    specparam           tpd_A6_DQ8              =1;
    specparam           tpd_A6_DQ9              =1;
    specparam           tpd_A6_DQ10              =1;
    specparam           tpd_A6_DQ11              =1;
    specparam           tpd_A6_DQ12              =1;
    specparam           tpd_A6_DQ13              =1;
    specparam           tpd_A6_DQ14              =1;
    specparam           tpd_A6_DQ15              =1;
    specparam           tpd_A7_DQ0              =1;
    specparam           tpd_A7_DQ1              =1;
    specparam           tpd_A7_DQ2              =1;
    specparam           tpd_A7_DQ3              =1;
    specparam           tpd_A7_DQ4              =1;
    specparam           tpd_A7_DQ5              =1;
    specparam           tpd_A7_DQ6              =1;
    specparam           tpd_A7_DQ7              =1;
    specparam           tpd_A7_DQ8              =1;
    specparam           tpd_A7_DQ9              =1;
    specparam           tpd_A7_DQ10              =1;
    specparam           tpd_A7_DQ11              =1;
    specparam           tpd_A7_DQ12              =1;
    specparam           tpd_A7_DQ13              =1;
    specparam           tpd_A7_DQ14              =1;
    specparam           tpd_A7_DQ15              =1;
    specparam           tpd_A8_DQ0              =1;
    specparam           tpd_A8_DQ1              =1;
    specparam           tpd_A8_DQ2              =1;
    specparam           tpd_A8_DQ3              =1;
    specparam           tpd_A8_DQ4              =1;
    specparam           tpd_A8_DQ5              =1;
    specparam           tpd_A8_DQ6              =1;
    specparam           tpd_A8_DQ7              =1;
    specparam           tpd_A8_DQ8              =1;
    specparam           tpd_A8_DQ9              =1;
    specparam           tpd_A8_DQ10              =1;
    specparam           tpd_A8_DQ11              =1;
    specparam           tpd_A8_DQ12              =1;
    specparam           tpd_A8_DQ13              =1;
    specparam           tpd_A8_DQ14              =1;
    specparam           tpd_A8_DQ15              =1;
    specparam           tpd_A9_DQ0              =1;
    specparam           tpd_A9_DQ1              =1;
    specparam           tpd_A9_DQ2              =1;
    specparam           tpd_A9_DQ3              =1;
    specparam           tpd_A9_DQ4              =1;
    specparam           tpd_A9_DQ5              =1;
    specparam           tpd_A9_DQ6              =1;
    specparam           tpd_A9_DQ7              =1;
    specparam           tpd_A9_DQ8              =1;
    specparam           tpd_A9_DQ9              =1;
    specparam           tpd_A9_DQ10              =1;
    specparam           tpd_A9_DQ11              =1;
    specparam           tpd_A9_DQ12              =1;
    specparam           tpd_A9_DQ13              =1;
    specparam           tpd_A9_DQ14              =1;
    specparam           tpd_A9_DQ15              =1;
    specparam           tpd_A10_DQ0              =1;
    specparam           tpd_A10_DQ1              =1;
    specparam           tpd_A10_DQ2              =1;
    specparam           tpd_A10_DQ3              =1;
    specparam           tpd_A10_DQ4              =1;
    specparam           tpd_A10_DQ5              =1;
    specparam           tpd_A10_DQ6              =1;
    specparam           tpd_A10_DQ7              =1;
    specparam           tpd_A10_DQ8              =1;
    specparam           tpd_A10_DQ9              =1;
    specparam           tpd_A10_DQ10              =1;
    specparam           tpd_A10_DQ11              =1;
    specparam           tpd_A10_DQ12              =1;
    specparam           tpd_A10_DQ13              =1;
    specparam           tpd_A10_DQ14              =1;
    specparam           tpd_A10_DQ15              =1;
    specparam           tpd_A11_DQ0              =1;
    specparam           tpd_A11_DQ1              =1;
    specparam           tpd_A11_DQ2              =1;
    specparam           tpd_A11_DQ3              =1;
    specparam           tpd_A11_DQ4              =1;
    specparam           tpd_A11_DQ5              =1;
    specparam           tpd_A11_DQ6              =1;
    specparam           tpd_A11_DQ7              =1;
    specparam           tpd_A11_DQ8              =1;
    specparam           tpd_A11_DQ9              =1;
    specparam           tpd_A11_DQ10              =1;
    specparam           tpd_A11_DQ11              =1;
    specparam           tpd_A11_DQ12              =1;
    specparam           tpd_A11_DQ13              =1;
    specparam           tpd_A11_DQ14              =1;
    specparam           tpd_A11_DQ15              =1;
    specparam           tpd_A12_DQ0              =1;
    specparam           tpd_A12_DQ1              =1;
    specparam           tpd_A12_DQ2              =1;
    specparam           tpd_A12_DQ3              =1;
    specparam           tpd_A12_DQ4              =1;
    specparam           tpd_A12_DQ5              =1;
    specparam           tpd_A12_DQ6              =1;
    specparam           tpd_A12_DQ7              =1;
    specparam           tpd_A12_DQ8              =1;
    specparam           tpd_A12_DQ9              =1;
    specparam           tpd_A12_DQ10              =1;
    specparam           tpd_A12_DQ11              =1;
    specparam           tpd_A12_DQ12              =1;
    specparam           tpd_A12_DQ13              =1;
    specparam           tpd_A12_DQ14              =1;
    specparam           tpd_A12_DQ15              =1;
    specparam           tpd_A13_DQ0              =1;
    specparam           tpd_A13_DQ1              =1;
    specparam           tpd_A13_DQ2              =1;
    specparam           tpd_A13_DQ3              =1;
    specparam           tpd_A13_DQ4              =1;
    specparam           tpd_A13_DQ5              =1;
    specparam           tpd_A13_DQ6              =1;
    specparam           tpd_A13_DQ7              =1;
    specparam           tpd_A13_DQ8              =1;
    specparam           tpd_A13_DQ9              =1;
    specparam           tpd_A13_DQ10              =1;
    specparam           tpd_A13_DQ11              =1;
    specparam           tpd_A13_DQ12              =1;
    specparam           tpd_A13_DQ13              =1;
    specparam           tpd_A13_DQ14              =1;
    specparam           tpd_A13_DQ15              =1;
    specparam           tpd_A14_DQ0              =1;
    specparam           tpd_A14_DQ1              =1;
    specparam           tpd_A14_DQ2              =1;
    specparam           tpd_A14_DQ3              =1;
    specparam           tpd_A14_DQ4              =1;
    specparam           tpd_A14_DQ5              =1;
    specparam           tpd_A14_DQ6              =1;
    specparam           tpd_A14_DQ7              =1;
    specparam           tpd_A14_DQ8              =1;
    specparam           tpd_A14_DQ9              =1;
    specparam           tpd_A14_DQ10              =1;
    specparam           tpd_A14_DQ11              =1;
    specparam           tpd_A14_DQ12              =1;
    specparam           tpd_A14_DQ13              =1;
    specparam           tpd_A14_DQ14              =1;
    specparam           tpd_A14_DQ15              =1;
    specparam           tpd_A15_DQ0              =1;
    specparam           tpd_A15_DQ1              =1;
    specparam           tpd_A15_DQ2              =1;
    specparam           tpd_A15_DQ3              =1;
    specparam           tpd_A15_DQ4              =1;
    specparam           tpd_A15_DQ5              =1;
    specparam           tpd_A15_DQ6              =1;
    specparam           tpd_A15_DQ7              =1;
    specparam           tpd_A15_DQ8              =1;
    specparam           tpd_A15_DQ9              =1;
    specparam           tpd_A15_DQ10              =1;
    specparam           tpd_A15_DQ11              =1;
    specparam           tpd_A15_DQ12              =1;
    specparam           tpd_A15_DQ13              =1;
    specparam           tpd_A15_DQ14              =1;
    specparam           tpd_A15_DQ15              =1;
    specparam           tpd_A16_DQ0              =1;
    specparam           tpd_A16_DQ1              =1;
    specparam           tpd_A16_DQ2              =1;
    specparam           tpd_A16_DQ3              =1;
    specparam           tpd_A16_DQ4              =1;
    specparam           tpd_A16_DQ5              =1;
    specparam           tpd_A16_DQ6              =1;
    specparam           tpd_A16_DQ7              =1;
    specparam           tpd_A16_DQ8              =1;
    specparam           tpd_A16_DQ9              =1;
    specparam           tpd_A16_DQ10              =1;
    specparam           tpd_A16_DQ11              =1;
    specparam           tpd_A16_DQ12              =1;
    specparam           tpd_A16_DQ13              =1;
    specparam           tpd_A16_DQ14              =1;
    specparam           tpd_A16_DQ15              =1;
    specparam           tpd_A17_DQ0              =1;
    specparam           tpd_A17_DQ1              =1;
    specparam           tpd_A17_DQ2              =1;
    specparam           tpd_A17_DQ3              =1;
    specparam           tpd_A17_DQ4              =1;
    specparam           tpd_A17_DQ5              =1;
    specparam           tpd_A17_DQ6              =1;
    specparam           tpd_A17_DQ7              =1;
    specparam           tpd_A17_DQ8              =1;
    specparam           tpd_A17_DQ9              =1;
    specparam           tpd_A17_DQ10              =1;
    specparam           tpd_A17_DQ11              =1;
    specparam           tpd_A17_DQ12              =1;
    specparam           tpd_A17_DQ13              =1;
    specparam           tpd_A17_DQ14              =1;
    specparam           tpd_A17_DQ15              =1;
    specparam           tpd_A18_DQ0              =1;
    specparam           tpd_A18_DQ1              =1;
    specparam           tpd_A18_DQ2              =1;
    specparam           tpd_A18_DQ3              =1;
    specparam           tpd_A18_DQ4              =1;
    specparam           tpd_A18_DQ5              =1;
    specparam           tpd_A18_DQ6              =1;
    specparam           tpd_A18_DQ7              =1;
    specparam           tpd_A18_DQ8              =1;
    specparam           tpd_A18_DQ9              =1;
    specparam           tpd_A18_DQ10              =1;
    specparam           tpd_A18_DQ11              =1;
    specparam           tpd_A18_DQ12              =1;
    specparam           tpd_A18_DQ13              =1;
    specparam           tpd_A18_DQ14              =1;
    specparam           tpd_A18_DQ15              =1;

    specparam           tpd_CE1Negs_DQ0           =1;
    specparam           tpd_CE1Negs_DQ1           =1;
    specparam           tpd_CE1Negs_DQ2           =1;
    specparam           tpd_CE1Negs_DQ3           =1;
    specparam           tpd_CE1Negs_DQ4           =1;
    specparam           tpd_CE1Negs_DQ5           =1;
    specparam           tpd_CE1Negs_DQ6           =1;
    specparam           tpd_CE1Negs_DQ7           =1;
    specparam           tpd_CE1Negs_DQ8           =1;
    specparam           tpd_CE1Negs_DQ9           =1;
    specparam           tpd_CE1Negs_DQ10           =1;
    specparam           tpd_CE1Negs_DQ11           =1;
    specparam           tpd_CE1Negs_DQ12           =1;
    specparam           tpd_CE1Negs_DQ13           =1;
    specparam           tpd_CE1Negs_DQ14           =1;
    specparam           tpd_CE1Negs_DQ15           =1;

    specparam           tpd_CE2s_DQ0           =1;
    specparam           tpd_CE2s_DQ1           =1;
    specparam           tpd_CE2s_DQ2           =1;
    specparam           tpd_CE2s_DQ3           =1;
    specparam           tpd_CE2s_DQ4           =1;
    specparam           tpd_CE2s_DQ5           =1;
    specparam           tpd_CE2s_DQ6           =1;
    specparam           tpd_CE2s_DQ7           =1;
    specparam           tpd_CE2s_DQ8           =1;
    specparam           tpd_CE2s_DQ9           =1;
    specparam           tpd_CE2s_DQ10           =1;
    specparam           tpd_CE2s_DQ11           =1;
    specparam           tpd_CE2s_DQ12           =1;
    specparam           tpd_CE2s_DQ13           =1;
    specparam           tpd_CE2s_DQ14           =1;
    specparam           tpd_CE2s_DQ15           =1;

    specparam           tpd_OENeg_DQ0           =1;
    specparam           tpd_OENeg_DQ1           =1;
    specparam           tpd_OENeg_DQ2           =1;
    specparam           tpd_OENeg_DQ3           =1;
    specparam           tpd_OENeg_DQ4           =1;
    specparam           tpd_OENeg_DQ5           =1;
    specparam           tpd_OENeg_DQ6           =1;
    specparam           tpd_OENeg_DQ7           =1;
    specparam           tpd_OENeg_DQ8           =1;
    specparam           tpd_OENeg_DQ9           =1;
    specparam           tpd_OENeg_DQ10           =1;
    specparam           tpd_OENeg_DQ11           =1;
    specparam           tpd_OENeg_DQ12           =1;
    specparam           tpd_OENeg_DQ13           =1;
    specparam           tpd_OENeg_DQ14           =1;
    specparam           tpd_OENeg_DQ15           =1;

    specparam           tpd_LBNegs_DQ0           =1;
    specparam           tpd_LBNegs_DQ1           =1;
    specparam           tpd_LBNegs_DQ2           =1;
    specparam           tpd_LBNegs_DQ3           =1;
    specparam           tpd_LBNegs_DQ4           =1;
    specparam           tpd_LBNegs_DQ5           =1;
    specparam           tpd_LBNegs_DQ6           =1;
    specparam           tpd_LBNegs_DQ7           =1;

    specparam           tpd_UBNegs_DQ8           =1;
    specparam           tpd_UBNegs_DQ9           =1;
    specparam           tpd_UBNegs_DQ10           =1;
    specparam           tpd_UBNegs_DQ11           =1;
    specparam           tpd_UBNegs_DQ12           =1;
    specparam           tpd_UBNegs_DQ13           =1;
    specparam           tpd_UBNegs_DQ14           =1;
    specparam           tpd_UBNegs_DQ15           =1;

    specparam           tpd_WENeg_DQ0           =1;
    specparam           tpd_WENeg_DQ1           =1;
    specparam           tpd_WENeg_DQ2           =1;
    specparam           tpd_WENeg_DQ3           =1;
    specparam           tpd_WENeg_DQ4           =1;
    specparam           tpd_WENeg_DQ5           =1;
    specparam           tpd_WENeg_DQ6           =1;
    specparam           tpd_WENeg_DQ7           =1;
    specparam           tpd_WENeg_DQ8           =1;
    specparam           tpd_WENeg_DQ9           =1;
    specparam           tpd_WENeg_DQ10           =1;
    specparam           tpd_WENeg_DQ11           =1;
    specparam           tpd_WENeg_DQ12           =1;
    specparam           tpd_WENeg_DQ13           =1;
    specparam           tpd_WENeg_DQ14           =1;
    specparam           tpd_WENeg_DQ15           =1;


    specparam           thold_DQ0_A0           =1;

    specparam           thold_DQ0_WENeg         =1;
    specparam           tsetup_CE1Negs_WENeg    =1;
    specparam           tsetup_A0_WENeg         =1;
    specparam           tsetup_LBNegs_WENeg     =1;
    specparam           tsetup_UBNegs_WENeg     =1;
    specparam           tsetup_WENeg_CE1Negs    =1;
    specparam           tsetup_DQ0_WENeg        =1;

    specparam           tpw_A0_negedge         =1;
    specparam           tpw_WENeg_negedge      =1;
    specparam           tpw_CE1Negs_negedge    =1;
    specparam           tpw_CE2s_negedge       =1;


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
  (A0 *> DQ8) = tpd_A0_DQ8;
  (A0 *> DQ9) = tpd_A0_DQ9;
  (A0 *> DQ10) = tpd_A0_DQ10;
  (A0 *> DQ11) = tpd_A0_DQ11;
  (A0 *> DQ12) = tpd_A0_DQ12;
  (A0 *> DQ13) = tpd_A0_DQ13;
  (A0 *> DQ14) = tpd_A0_DQ14;
  (A0 *> DQ15) = tpd_A0_DQ15;
  (A1 *> DQ0) = tpd_A1_DQ0;
  (A1 *> DQ1) = tpd_A1_DQ1;
  (A1 *> DQ2) = tpd_A1_DQ2;
  (A1 *> DQ3) = tpd_A1_DQ3;
  (A1 *> DQ4) = tpd_A1_DQ4;
  (A1 *> DQ5) = tpd_A1_DQ5;
  (A1 *> DQ6) = tpd_A1_DQ6;
  (A1 *> DQ7) = tpd_A1_DQ7;
  (A1 *> DQ8) = tpd_A1_DQ8;
  (A1 *> DQ9) = tpd_A1_DQ9;
  (A1 *> DQ10) = tpd_A1_DQ10;
  (A1 *> DQ11) = tpd_A1_DQ11;
  (A1 *> DQ12) = tpd_A1_DQ12;
  (A1 *> DQ13) = tpd_A1_DQ13;
  (A1 *> DQ14) = tpd_A1_DQ14;
  (A1 *> DQ15) = tpd_A1_DQ15;
  (A2 *> DQ0) = tpd_A2_DQ0;
  (A2 *> DQ1) = tpd_A2_DQ1;
  (A2 *> DQ2) = tpd_A2_DQ2;
  (A2 *> DQ3) = tpd_A2_DQ3;
  (A2 *> DQ4) = tpd_A2_DQ4;
  (A2 *> DQ5) = tpd_A2_DQ5;
  (A2 *> DQ6) = tpd_A2_DQ6;
  (A2 *> DQ7) = tpd_A2_DQ7;
  (A2 *> DQ8) = tpd_A2_DQ8;
  (A2 *> DQ9) = tpd_A2_DQ9;
  (A2 *> DQ10) = tpd_A2_DQ10;
  (A2 *> DQ11) = tpd_A2_DQ11;
  (A2 *> DQ12) = tpd_A2_DQ12;
  (A2 *> DQ13) = tpd_A2_DQ13;
  (A2 *> DQ14) = tpd_A2_DQ14;
  (A2 *> DQ15) = tpd_A2_DQ15;
  (A3 *> DQ0) = tpd_A3_DQ0;
  (A3 *> DQ1) = tpd_A3_DQ1;
  (A3 *> DQ2) = tpd_A3_DQ2;
  (A3 *> DQ3) = tpd_A3_DQ3;
  (A3 *> DQ4) = tpd_A3_DQ4;
  (A3 *> DQ5) = tpd_A3_DQ5;
  (A3 *> DQ6) = tpd_A3_DQ6;
  (A3 *> DQ7) = tpd_A3_DQ7;
  (A3 *> DQ8) = tpd_A3_DQ8;
  (A3 *> DQ9) = tpd_A3_DQ9;
  (A3 *> DQ10) = tpd_A3_DQ10;
  (A3 *> DQ11) = tpd_A3_DQ11;
  (A3 *> DQ12) = tpd_A3_DQ12;
  (A3 *> DQ13) = tpd_A3_DQ13;
  (A3 *> DQ14) = tpd_A3_DQ14;
  (A3 *> DQ15) = tpd_A3_DQ15;
  (A4 *> DQ0) = tpd_A4_DQ0;
  (A4 *> DQ1) = tpd_A4_DQ1;
  (A4 *> DQ2) = tpd_A4_DQ2;
  (A4 *> DQ3) = tpd_A4_DQ3;
  (A4 *> DQ4) = tpd_A4_DQ4;
  (A4 *> DQ5) = tpd_A4_DQ5;
  (A4 *> DQ6) = tpd_A4_DQ6;
  (A4 *> DQ7) = tpd_A4_DQ7;
  (A4 *> DQ8) = tpd_A4_DQ8;
  (A4 *> DQ9) = tpd_A4_DQ9;
  (A4 *> DQ10) = tpd_A4_DQ10;
  (A4 *> DQ11) = tpd_A4_DQ11;
  (A4 *> DQ12) = tpd_A4_DQ12;
  (A4 *> DQ13) = tpd_A4_DQ13;
  (A4 *> DQ14) = tpd_A4_DQ14;
  (A4 *> DQ15) = tpd_A4_DQ15;
  (A5 *> DQ0) = tpd_A5_DQ0;
  (A5 *> DQ1) = tpd_A5_DQ1;
  (A5 *> DQ2) = tpd_A5_DQ2;
  (A5 *> DQ3) = tpd_A5_DQ3;
  (A5 *> DQ4) = tpd_A5_DQ4;
  (A5 *> DQ5) = tpd_A5_DQ5;
  (A5 *> DQ6) = tpd_A5_DQ6;
  (A5 *> DQ7) = tpd_A5_DQ7;
  (A5 *> DQ8) = tpd_A5_DQ8;
  (A5 *> DQ9) = tpd_A5_DQ9;
  (A5 *> DQ10) = tpd_A5_DQ10;
  (A5 *> DQ11) = tpd_A5_DQ11;
  (A5 *> DQ12) = tpd_A5_DQ12;
  (A5 *> DQ13) = tpd_A5_DQ13;
  (A5 *> DQ14) = tpd_A5_DQ14;
  (A5 *> DQ15) = tpd_A5_DQ15;
  (A6 *> DQ0) = tpd_A6_DQ0;
  (A6 *> DQ1) = tpd_A6_DQ1;
  (A6 *> DQ2) = tpd_A6_DQ2;
  (A6 *> DQ3) = tpd_A6_DQ3;
  (A6 *> DQ4) = tpd_A6_DQ4;
  (A6 *> DQ5) = tpd_A6_DQ5;
  (A6 *> DQ6) = tpd_A6_DQ6;
  (A6 *> DQ7) = tpd_A6_DQ7;
  (A6 *> DQ8) = tpd_A6_DQ8;
  (A6 *> DQ9) = tpd_A6_DQ9;
  (A6 *> DQ10) = tpd_A6_DQ10;
  (A6 *> DQ11) = tpd_A6_DQ11;
  (A6 *> DQ12) = tpd_A6_DQ12;
  (A6 *> DQ13) = tpd_A6_DQ13;
  (A6 *> DQ14) = tpd_A6_DQ14;
  (A6 *> DQ15) = tpd_A6_DQ15;
  (A7 *> DQ0) = tpd_A7_DQ0;
  (A7 *> DQ1) = tpd_A7_DQ1;
  (A7 *> DQ2) = tpd_A7_DQ2;
  (A7 *> DQ3) = tpd_A7_DQ3;
  (A7 *> DQ4) = tpd_A7_DQ4;
  (A7 *> DQ5) = tpd_A7_DQ5;
  (A7 *> DQ6) = tpd_A7_DQ6;
  (A7 *> DQ7) = tpd_A7_DQ7;
  (A7 *> DQ8) = tpd_A7_DQ8;
  (A7 *> DQ9) = tpd_A7_DQ9;
  (A7 *> DQ10) = tpd_A7_DQ10;
  (A7 *> DQ11) = tpd_A7_DQ11;
  (A7 *> DQ12) = tpd_A7_DQ12;
  (A7 *> DQ13) = tpd_A7_DQ13;
  (A7 *> DQ14) = tpd_A7_DQ14;
  (A7 *> DQ15) = tpd_A7_DQ15;
  (A8 *> DQ0) = tpd_A8_DQ0;
  (A8 *> DQ1) = tpd_A8_DQ1;
  (A8 *> DQ2) = tpd_A8_DQ2;
  (A8 *> DQ3) = tpd_A8_DQ3;
  (A8 *> DQ4) = tpd_A8_DQ4;
  (A8 *> DQ5) = tpd_A8_DQ5;
  (A8 *> DQ6) = tpd_A8_DQ6;
  (A8 *> DQ7) = tpd_A8_DQ7;
  (A8 *> DQ8) = tpd_A8_DQ8;
  (A8 *> DQ9) = tpd_A8_DQ9;
  (A8 *> DQ10) = tpd_A8_DQ10;
  (A8 *> DQ11) = tpd_A8_DQ11;
  (A8 *> DQ12) = tpd_A8_DQ12;
  (A8 *> DQ13) = tpd_A8_DQ13;
  (A8 *> DQ14) = tpd_A8_DQ14;
  (A8 *> DQ15) = tpd_A8_DQ15;
  (A9 *> DQ0) = tpd_A9_DQ0;
  (A9 *> DQ1) = tpd_A9_DQ1;
  (A9 *> DQ2) = tpd_A9_DQ2;
  (A9 *> DQ3) = tpd_A9_DQ3;
  (A9 *> DQ4) = tpd_A9_DQ4;
  (A9 *> DQ5) = tpd_A9_DQ5;
  (A9 *> DQ6) = tpd_A9_DQ6;
  (A9 *> DQ7) = tpd_A9_DQ7;
  (A9 *> DQ8) = tpd_A9_DQ8;
  (A9 *> DQ9) = tpd_A9_DQ9;
  (A9 *> DQ10) = tpd_A9_DQ10;
  (A9 *> DQ11) = tpd_A9_DQ11;
  (A9 *> DQ12) = tpd_A9_DQ12;
  (A9 *> DQ13) = tpd_A9_DQ13;
  (A9 *> DQ14) = tpd_A9_DQ14;
  (A9 *> DQ15) = tpd_A9_DQ15;
  (A10 *> DQ0) = tpd_A10_DQ0;
  (A10 *> DQ1) = tpd_A10_DQ1;
  (A10 *> DQ2) = tpd_A10_DQ2;
  (A10 *> DQ3) = tpd_A10_DQ3;
  (A10 *> DQ4) = tpd_A10_DQ4;
  (A10 *> DQ5) = tpd_A10_DQ5;
  (A10 *> DQ6) = tpd_A10_DQ6;
  (A10 *> DQ7) = tpd_A10_DQ7;
  (A10 *> DQ8) = tpd_A10_DQ8;
  (A10 *> DQ9) = tpd_A10_DQ9;
  (A10 *> DQ10) = tpd_A10_DQ10;
  (A10 *> DQ11) = tpd_A10_DQ11;
  (A10 *> DQ12) = tpd_A10_DQ12;
  (A10 *> DQ13) = tpd_A10_DQ13;
  (A10 *> DQ14) = tpd_A10_DQ14;
  (A10 *> DQ15) = tpd_A10_DQ15;
  (A11 *> DQ0) = tpd_A11_DQ0;
  (A11 *> DQ1) = tpd_A11_DQ1;
  (A11 *> DQ2) = tpd_A11_DQ2;
  (A11 *> DQ3) = tpd_A11_DQ3;
  (A11 *> DQ4) = tpd_A11_DQ4;
  (A11 *> DQ5) = tpd_A11_DQ5;
  (A11 *> DQ6) = tpd_A11_DQ6;
  (A11 *> DQ7) = tpd_A11_DQ7;
  (A11 *> DQ8) = tpd_A11_DQ8;
  (A11 *> DQ9) = tpd_A11_DQ9;
  (A11 *> DQ10) = tpd_A11_DQ10;
  (A11 *> DQ11) = tpd_A11_DQ11;
  (A11 *> DQ12) = tpd_A11_DQ12;
  (A11 *> DQ13) = tpd_A11_DQ13;
  (A11 *> DQ14) = tpd_A11_DQ14;
  (A11 *> DQ15) = tpd_A11_DQ15;
  (A12 *> DQ0) = tpd_A12_DQ0;
  (A12 *> DQ1) = tpd_A12_DQ1;
  (A12 *> DQ2) = tpd_A12_DQ2;
  (A12 *> DQ3) = tpd_A12_DQ3;
  (A12 *> DQ4) = tpd_A12_DQ4;
  (A12 *> DQ5) = tpd_A12_DQ5;
  (A12 *> DQ6) = tpd_A12_DQ6;
  (A12 *> DQ7) = tpd_A12_DQ7;
  (A12 *> DQ8) = tpd_A12_DQ8;
  (A12 *> DQ9) = tpd_A12_DQ9;
  (A12 *> DQ10) = tpd_A12_DQ10;
  (A12 *> DQ11) = tpd_A12_DQ11;
  (A12 *> DQ12) = tpd_A12_DQ12;
  (A12 *> DQ13) = tpd_A12_DQ13;
  (A12 *> DQ14) = tpd_A12_DQ14;
  (A12 *> DQ15) = tpd_A12_DQ15;
  (A13 *> DQ0) = tpd_A13_DQ0;
  (A13 *> DQ1) = tpd_A13_DQ1;
  (A13 *> DQ2) = tpd_A13_DQ2;
  (A13 *> DQ3) = tpd_A13_DQ3;
  (A13 *> DQ4) = tpd_A13_DQ4;
  (A13 *> DQ5) = tpd_A13_DQ5;
  (A13 *> DQ6) = tpd_A13_DQ6;
  (A13 *> DQ7) = tpd_A13_DQ7;
  (A13 *> DQ8) = tpd_A13_DQ8;
  (A13 *> DQ9) = tpd_A13_DQ9;
  (A13 *> DQ10) = tpd_A13_DQ10;
  (A13 *> DQ11) = tpd_A13_DQ11;
  (A13 *> DQ12) = tpd_A13_DQ12;
  (A13 *> DQ13) = tpd_A13_DQ13;
  (A13 *> DQ14) = tpd_A13_DQ14;
  (A13 *> DQ15) = tpd_A13_DQ15;
  (A14 *> DQ0) = tpd_A14_DQ0;
  (A14 *> DQ1) = tpd_A14_DQ1;
  (A14 *> DQ2) = tpd_A14_DQ2;
  (A14 *> DQ3) = tpd_A14_DQ3;
  (A14 *> DQ4) = tpd_A14_DQ4;
  (A14 *> DQ5) = tpd_A14_DQ5;
  (A14 *> DQ6) = tpd_A14_DQ6;
  (A14 *> DQ7) = tpd_A14_DQ7;
  (A14 *> DQ8) = tpd_A14_DQ8;
  (A14 *> DQ9) = tpd_A14_DQ9;
  (A14 *> DQ10) = tpd_A14_DQ10;
  (A14 *> DQ11) = tpd_A14_DQ11;
  (A14 *> DQ12) = tpd_A14_DQ12;
  (A14 *> DQ13) = tpd_A14_DQ13;
  (A14 *> DQ14) = tpd_A14_DQ14;
  (A14 *> DQ15) = tpd_A14_DQ15;
  (A15 *> DQ0) = tpd_A15_DQ0;
  (A15 *> DQ1) = tpd_A15_DQ1;
  (A15 *> DQ2) = tpd_A15_DQ2;
  (A15 *> DQ3) = tpd_A15_DQ3;
  (A15 *> DQ4) = tpd_A15_DQ4;
  (A15 *> DQ5) = tpd_A15_DQ5;
  (A15 *> DQ6) = tpd_A15_DQ6;
  (A15 *> DQ7) = tpd_A15_DQ7;
  (A15 *> DQ8) = tpd_A15_DQ8;
  (A15 *> DQ9) = tpd_A15_DQ9;
  (A15 *> DQ10) = tpd_A15_DQ10;
  (A15 *> DQ11) = tpd_A15_DQ11;
  (A15 *> DQ12) = tpd_A15_DQ12;
  (A15 *> DQ13) = tpd_A15_DQ13;
  (A15 *> DQ14) = tpd_A15_DQ14;
  (A15 *> DQ15) = tpd_A15_DQ15;
  (A16 *> DQ0) = tpd_A16_DQ0;
  (A16 *> DQ1) = tpd_A16_DQ1;
  (A16 *> DQ2) = tpd_A16_DQ2;
  (A16 *> DQ3) = tpd_A16_DQ3;
  (A16 *> DQ4) = tpd_A16_DQ4;
  (A16 *> DQ5) = tpd_A16_DQ5;
  (A16 *> DQ6) = tpd_A16_DQ6;
  (A16 *> DQ7) = tpd_A16_DQ7;
  (A16 *> DQ8) = tpd_A16_DQ8;
  (A16 *> DQ9) = tpd_A16_DQ9;
  (A16 *> DQ10) = tpd_A16_DQ10;
  (A16 *> DQ11) = tpd_A16_DQ11;
  (A16 *> DQ12) = tpd_A16_DQ12;
  (A16 *> DQ13) = tpd_A16_DQ13;
  (A16 *> DQ14) = tpd_A16_DQ14;
  (A16 *> DQ15) = tpd_A16_DQ15;
  (A17 *> DQ0) = tpd_A17_DQ0;
  (A17 *> DQ1) = tpd_A17_DQ1;
  (A17 *> DQ2) = tpd_A17_DQ2;
  (A17 *> DQ3) = tpd_A17_DQ3;
  (A17 *> DQ4) = tpd_A17_DQ4;
  (A17 *> DQ5) = tpd_A17_DQ5;
  (A17 *> DQ6) = tpd_A17_DQ6;
  (A17 *> DQ7) = tpd_A17_DQ7;
  (A17 *> DQ8) = tpd_A17_DQ8;
  (A17 *> DQ9) = tpd_A17_DQ9;
  (A17 *> DQ10) = tpd_A17_DQ10;
  (A17 *> DQ11) = tpd_A17_DQ11;
  (A17 *> DQ12) = tpd_A17_DQ12;
  (A17 *> DQ13) = tpd_A17_DQ13;
  (A17 *> DQ14) = tpd_A17_DQ14;
  (A17 *> DQ15) = tpd_A17_DQ15;
  (A18 *> DQ0) = tpd_A18_DQ0;
  (A18 *> DQ1) = tpd_A18_DQ1;
  (A18 *> DQ2) = tpd_A18_DQ2;
  (A18 *> DQ3) = tpd_A18_DQ3;
  (A18 *> DQ4) = tpd_A18_DQ4;
  (A18 *> DQ5) = tpd_A18_DQ5;
  (A18 *> DQ6) = tpd_A18_DQ6;
  (A18 *> DQ7) = tpd_A18_DQ7;
  (A18 *> DQ8) = tpd_A18_DQ8;
  (A18 *> DQ9) = tpd_A18_DQ9;
  (A18 *> DQ10) = tpd_A18_DQ10;
  (A18 *> DQ11) = tpd_A18_DQ11;
  (A18 *> DQ12) = tpd_A18_DQ12;
  (A18 *> DQ13) = tpd_A18_DQ13;
  (A18 *> DQ14) = tpd_A18_DQ14;
  (A18 *> DQ15) = tpd_A18_DQ15;

  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ0) = tpd_CE1Negs_DQ0;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ1) = tpd_CE1Negs_DQ1;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ2) = tpd_CE1Negs_DQ2;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ3) = tpd_CE1Negs_DQ3;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ4) = tpd_CE1Negs_DQ4;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ5) = tpd_CE1Negs_DQ5;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ6) = tpd_CE1Negs_DQ6;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ7) = tpd_CE1Negs_DQ7;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ8) = tpd_CE1Negs_DQ8;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ9) = tpd_CE1Negs_DQ9;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ10) = tpd_CE1Negs_DQ10;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ11) = tpd_CE1Negs_DQ11;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ12) = tpd_CE1Negs_DQ12;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ13) = tpd_CE1Negs_DQ13;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ14) = tpd_CE1Negs_DQ14;
  if (!Open3state || (Open3state && FROMCE1))
    (CE1Negs *> DQ15) = tpd_CE1Negs_DQ15;

  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ0) = tpd_CE2s_DQ0;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ1) = tpd_CE2s_DQ1;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ2) = tpd_CE2s_DQ2;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ3) = tpd_CE2s_DQ3;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ4) = tpd_CE2s_DQ4;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ5) = tpd_CE2s_DQ5;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ6) = tpd_CE2s_DQ6;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ7) = tpd_CE2s_DQ7;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ8) = tpd_CE2s_DQ8;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ9) = tpd_CE2s_DQ9;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ10) = tpd_CE2s_DQ10;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ11) = tpd_CE2s_DQ11;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ12) = tpd_CE2s_DQ12;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ13) = tpd_CE2s_DQ13;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ14) = tpd_CE2s_DQ14;
  if (!Open3state || (Open3state && FROMCE2))
    (CE2s *> DQ15) = tpd_CE2s_DQ15;


  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ0) = tpd_OENeg_DQ0;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ1) = tpd_OENeg_DQ1;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ2) = tpd_OENeg_DQ2;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ3) = tpd_OENeg_DQ3;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ4) = tpd_OENeg_DQ4;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ5) = tpd_OENeg_DQ5;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ6) = tpd_OENeg_DQ6;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ7) = tpd_OENeg_DQ7;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ8) = tpd_OENeg_DQ8;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ9) = tpd_OENeg_DQ9;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ10) = tpd_OENeg_DQ10;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ11) = tpd_OENeg_DQ11;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ12) = tpd_OENeg_DQ12;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ13) = tpd_OENeg_DQ13;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ14) = tpd_OENeg_DQ14;
  if (!Open3state || (Open3state && FROMOE))
    (OENeg *> DQ15) = tpd_OENeg_DQ15;

  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ0) = tpd_LBNegs_DQ0;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ1) = tpd_LBNegs_DQ1;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ2) = tpd_LBNegs_DQ2;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ3) = tpd_LBNegs_DQ3;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ4) = tpd_LBNegs_DQ4;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ5) = tpd_LBNegs_DQ5;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ6) = tpd_LBNegs_DQ6;
  if (!Open3state || (Open3state && FROMLB))
    (LBNegs *> DQ7) = tpd_LBNegs_DQ7;

  if (FROMUB)
    (UBNegs *> DQ8) = tpd_UBNegs_DQ8;
  if (FROMUB)
    (UBNegs *> DQ9) = tpd_UBNegs_DQ9;
  if (FROMUB)
    (UBNegs *> DQ10) = tpd_UBNegs_DQ10;
  if (FROMUB)
    (UBNegs *> DQ11) = tpd_UBNegs_DQ11;
  if (FROMUB)
    (UBNegs *> DQ12) = tpd_UBNegs_DQ12;
  if (FROMUB)
    (UBNegs *> DQ13) = tpd_UBNegs_DQ13;
  if (FROMUB)
    (UBNegs *> DQ14) = tpd_UBNegs_DQ14;
  if (FROMUB)
    (UBNegs *> DQ15) = tpd_UBNegs_DQ15;

    (WENeg *> DQ0) = tpd_WENeg_DQ0;
    (WENeg *> DQ1) = tpd_WENeg_DQ1;
    (WENeg *> DQ2) = tpd_WENeg_DQ2;
    (WENeg *> DQ3) = tpd_WENeg_DQ3;
    (WENeg *> DQ4) = tpd_WENeg_DQ4;
    (WENeg *> DQ5) = tpd_WENeg_DQ5;
    (WENeg *> DQ6) = tpd_WENeg_DQ6;
    (WENeg *> DQ7) = tpd_WENeg_DQ7;
    (WENeg *> DQ8) = tpd_WENeg_DQ8;
    (WENeg *> DQ9) = tpd_WENeg_DQ9;
    (WENeg *> DQ10) = tpd_WENeg_DQ10;
    (WENeg *> DQ11) = tpd_WENeg_DQ11;
    (WENeg *> DQ12) = tpd_WENeg_DQ12;
    (WENeg *> DQ13) = tpd_WENeg_DQ13;
    (WENeg *> DQ14) = tpd_WENeg_DQ14;
    (WENeg *> DQ15) = tpd_WENeg_DQ15;


////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////
//tas
        $hold ( A0 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A0 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A1 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A2 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A3 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A4 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A5 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A6 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A7 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A8 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A9 &&& cs_sram_read,         DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A10 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A11 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A12 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A13 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A14 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A15 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A16 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A17 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ0,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ1,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ2,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ3,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ4,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ5,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ6,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ7,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ8,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ9,    thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ10,   thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ11,   thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ12,   thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ13,   thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ14,   thold_DQ0_WENeg, Viol);
        $hold ( A18 &&& cs_sram_read,        DQ15,   thold_DQ0_WENeg, Viol);

        $setup ( DQ0 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , posedge WENeg &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 , posedge WENeg &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 , posedge WENeg &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 , posedge WENeg &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 , posedge WENeg &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 , posedge WENeg &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 , posedge WENeg &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);

        $setup ( DQ0 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , posedge CE1Negs &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 , posedge CE1Negs &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 , posedge CE1Negs &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 , posedge CE1Negs &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 , posedge CE1Negs &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 , posedge CE1Negs &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 , posedge CE1Negs &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);

        $setup ( DQ0 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9 , negedge CE2s &&& cs_write_deg,  tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10 , negedge CE2s &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11 , negedge CE2s &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12 , negedge CE2s &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13 , negedge CE2s &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14 , negedge CE2s &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15 , negedge CE2s &&& cs_write_deg, tsetup_DQ0_WENeg, Viol);

        $setup ( CE1Negs , posedge WENeg &&& cs_sram_write,    tsetup_DQ0_WENeg, Viol);
        $setup ( CE1Negs , posedge CE2s &&& cs_sram_write,    tsetup_DQ0_WENeg, Viol);
        $setup ( CE2s    , posedge WENeg &&& cs_sram_write,    tsetup_DQ0_WENeg, Viol);
        $setup ( CE2s    , posedge CE1Negs &&& cs_sram_write,    tsetup_DQ0_WENeg, Viol);

        $setup (  A0, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A1, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A2, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A3, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A4, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A5, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A6, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A7, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A8, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A9, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A10, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A11, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A12, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A13, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A14, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A15, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A16, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A17, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A18, posedge WENeg &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);

        $setup (  A0, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A1, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A2, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A3, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A4, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A5, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A6, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A7, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A8, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A9, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A10, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A11, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A12, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A13, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A14, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A15, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A16, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A17, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A18, posedge CE1Negs &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);

        $setup (  A0, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A1, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A2, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A3, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A4, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A5, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A6, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A7, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A8, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A9, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A10, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A11, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A12, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A13, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A14, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A15, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A16, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A17, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);
        $setup (  A18, posedge CE2s &&& cs_sram_write, tsetup_DQ0_WENeg, Viol);

        $setup (  LBNegs, posedge WENeg &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);
        $setup (  UBNegs, posedge WENeg &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);

        $setup (  LBNegs, posedge CE1Negs &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);
        $setup (  UBNegs, posedge CE1Negs &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);

        $setup (  LBNegs, posedge CE2s &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);
        $setup (  UBNegs, posedge CE2s &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);

        $setup (  WENeg, posedge CE1Negs &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);
        $setup (  WENeg, posedge CE2s &&& cs_sram_write,  tsetup_DQ0_WENeg, Viol);

        $width (negedge WENeg &&& cs_sram_write, tpw_WENeg_negedge);
        $width (negedge CE1Negs &&& cs_sram_write, tpw_CE1Negs_negedge);
        $width (posedge CE2s &&& cs_sram_write, tpw_CE2s_negedge);
        $width (negedge A0 &&& cs_sram, tpw_A0_negedge);
        $width (posedge A0 &&& cs_sram, tpw_A0_negedge);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////
 reg deq;
 integer sector_preload[0:SramSize];
 integer i, j, k;

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
    // initialize memory and load preoload files if any
        for (i=0;i<=SramSize;i=i+1)
        begin
           sector_preload[i]=MaxData_S;
        end

        if (UserPreload && sram_file_name != "none")
        begin
           //am42bds6408g.sram, memory preload file
           //  @aaaa   - <aaaa> stands for address within last defined sector
           //  dddd    - <dd> is byte to be written at Mem(aaaa++)
           // (aaaa is incremented at every load)
           $readmemh(sram_file_name,sector_preload);
        end

        //memory load
        for (j=0;j<=SramSize;j=j+1)
            SramMem[j]=sector_preload[j];
   end

    initial
    begin
        write    = 1'b0;
        read     = 1'b0;
        Address     = 0;
    end
//////////////////////////////////////////////////////////////////////////////
////LAST_EVENT information
//////////////////////////////////////////////////////////////////////////////
    always @(negedge OENeg)
    begin
        OENeg_event = $time;
    end
    always @(negedge CE1Negs)
    begin
        CE1Neg_event = $time;
    end
    always @(negedge CE2s)
    begin
        CE2_event = $time;
    end
    always @(A)
    begin
        ADDR_event = $time;
    end
    always @(LBNegs)
    begin
        LBNeg_event = $time;
    end
    always @(UBNegs)
    begin
        UBNeg_event = $time;
    end

//    //latch address on rising edge and data on falling edge  of write
    always @(WENeg_ipd or CE1Negs_ipd or CE2s_ipd or OENeg_ipd)
    begin: write_dc
            if (~WENeg_ipd && ~CE1Negs_ipd && CE2s_ipd && OENeg_ipd)
                write = 1'b1;
            else
                write = 1'b0;
    end

    always @(WENeg_ipd or CE1Negs_ipd or CE2s_ipd or OENeg_ipd)
    begin: read_dc
        if (WENeg_ipd && ~CE1Negs_ipd && CE2s_ipd && ~OENeg_ipd)
           read = 1'b1;
        else
            read = 1'b0;
    end

//    ///////////////////////////////////////////////////////////////////////////
//    latch address  and data, according to LBNeg and UBNeg, on rising edge
//     of WE# or CE1Negs or falling edge of CE2s, whatever comes first
//    ///////////////////////////////////////////////////////////////////////////
integer D_tmp0_s;
integer D_tmp1_s;

   always @(write or WENeg_ipd or CE1Negs_ipd or CE2s_ipd )// or reseted)
   begin :SRAM_WRITE_LATCH
        if (write)
        begin
            Address = A;
            if (LBNegs_ipd == 0)
                D_tmp0_s = DIn[7:0];
            else
                D_tmp0_s = -1;
            if (UBNegs_ipd == 0)
                D_tmp1_s = DIn[15:8];
            else
                D_tmp1_s = -1;
        end
    end

reg [15:0] tmp;
    always @(write)
    begin
        if (write == 0)
        begin
            tmp = SramMem[Address];
            if (D_tmp0_s != -1)
                tmp[7:0] = D_tmp0_s;
            if (D_tmp1_s != -1)
                tmp[15:8] = D_tmp1_s;
            SramMem[Address] = tmp;
        end
    end
///////////////
//SRAM read
//////////////
    always @(read or A or LBNegs_ipd or UBNegs_ipd)
    begin
        if (read)
        begin
            SramRead(A, LBNegs_ipd, UBNegs_ipd, Dout_zd);
        end
    end
        //Output Disable Control
    always @(CE1Negs or CE2s or OENeg_ipd)
    begin
        if ( CE1Negs_ipd || ~CE2s_ipd || OENeg_ipd)
            Dout_zd = 16'bZ;
     end

//open tristate buffers contrpl
    always @(Dout_zd[15:0])
    begin : open_buff
        if (Dout_zd[0] !== 1'bz || Dout_zd[8] !== 1'bz)
        begin
            //open buffers
            CE1DQ_open_t = CE1Neg_event  + CE1DQ_1z;
            CE2DQ_open_t = CE2_event  + CE1DQ_1z;
            OEDQ_open_t = OENeg_event  + OEDQ_1z;
            Open3state = 1;
            FROMCE1 = ((CE1DQ_open_t >= OEDQ_open_t) &&
                       (CE1DQ_open_t >= LBDQ_open_t) &&
                       (CE1DQ_open_t >= UBDQ_open_t) &&
                       (CE1DQ_open_t >= CE2DQ_open_t) &&
                       (CE1DQ_open_t >= $time));
            FROMCE2 = ((CE2DQ_open_t >= OEDQ_open_t) &&
                       (CE2DQ_open_t >= LBDQ_open_t) &&
                       (CE2DQ_open_t >= UBDQ_open_t) &&
                       (CE2DQ_open_t >= CE1DQ_open_t) &&
                       (CE2DQ_open_t >= $time));
            FROMOE = ((OEDQ_open_t >= CE1DQ_open_t) &&
                      (OEDQ_open_t >= LBDQ_open_t) &&
                      (OEDQ_open_t >= UBDQ_open_t) &&
                      (OEDQ_open_t >= CE1DQ_open_t) &&
                      (OEDQ_open_t >= $time));
        end
        else
        begin
            FROMCE1 = 0;
            FROMCE2 = 0;
            FROMOE = 0;
            Open3state = 0;
        end
    end
    always @(Dout_zd[7:0])
    begin : open_buff_lo
        if (Dout_zd[0] !== 1'bz)
        begin
            //open buffers
            LBDQ_open_t = LBNeg_event  + LBDQ_1z;
            Open3state_lo = 1;
            FROMLB = ((LBDQ_open_t >= CE1DQ_open_t) &&
                      (LBDQ_open_t >= OEDQ_open_t) &&
                      (LBDQ_open_t >= UBDQ_open_t) &&
                      (LBDQ_open_t >= CE1DQ_open_t) &&
                      (LBDQ_open_t >= $time) );
        end
        else
        begin
            FROMLB = 0;
            Open3state_lo = 0;
        end
    end

    always @(Dout_zd[15:8])
    begin : open_buff_hi
        if (Dout_zd[8] !== 1'bz)
        begin
            //open buffers
            UBDQ_open_t = UBNeg_event  + LBDQ_1z;
            Open3state_hi = 1;
            FROMUB = ((UBDQ_open_t >= CE1DQ_open_t) &&
                      (UBDQ_open_t >= OEDQ_open_t) &&
                      (UBDQ_open_t >= LBDQ_open_t) &&
                      (UBDQ_open_t >= CE1DQ_open_t) &&
                      (UBDQ_open_t >= $time));
        end
        else
        begin
            FROMUB = 0;
            Open3state_hi = 0;
        end
    end

    //Output timing control
    always @(Dout_zd[7:0])
    begin : OutputGen
        if (Dout_zd[0] !== 1'bz)
        begin
            //delays
            CE1DQ_t  = CE1Neg_event  + CE1DQ_01;
            CE2DQ_t  = CE2_event  + CE1DQ_01;
            OEDQ_t   = OENeg_event  + OEDQ_01;
            LBDQ_t   = LBNeg_event  + LBDQ_01;
            UBDQ_t   = UBNeg_event  + LBDQ_01;
            ADDRDQ_t = ADDR_event + ADDRDQ_01;

            if ((ADDRDQ_t >= $time )&&
                (ADDRDQ_t >= OEDQ_t) &&
                (ADDRDQ_t >= CE1DQ_t )&&
                (ADDRDQ_t >= CE2DQ_t )&&
                (ADDRDQ_t >= LBDQ_t) &&
                (ADDRDQ_t >= UBDQ_t))
                wait_time = ADDRDQ_t;
            else if ((CE1DQ_t >= $time )&&
                (CE1DQ_t >= OEDQ_t) &&
                (CE1DQ_t >= CE2DQ_t )&&
                (CE1DQ_t >= LBDQ_t) &&
                (CE1DQ_t >= UBDQ_t) &&
                (CE1DQ_t >= ADDRDQ_t))
                wait_time = CE1DQ_t;
            else if ((CE2DQ_t >= $time )&&
                (CE2DQ_t >= OEDQ_t) &&
                (CE2DQ_t >= CE1DQ_t )&&
                (CE2DQ_t >= LBDQ_t) &&
                (CE2DQ_t >= UBDQ_t) &&
                (CE2DQ_t >= ADDRDQ_t))
                wait_time = CE2DQ_t;
            else if ((OEDQ_t >= $time )&&
                (OEDQ_t >= CE1DQ_t )&&
                (OEDQ_t >= CE2DQ_t )&&
                (OEDQ_t >= LBDQ_t) &&
                (OEDQ_t >= UBDQ_t) &&
                (OEDQ_t >= ADDRDQ_t))
                wait_time = OEDQ_t;
            else if ((LBDQ_t >= $time )&&
                (LBDQ_t >= CE1DQ_t )&&
                (LBDQ_t >= CE2DQ_t )&&
                (LBDQ_t >= OEDQ_t) &&
                (LBDQ_t >= UBDQ_t) &&
                (LBDQ_t >= ADDRDQ_t))
                wait_time = LBDQ_t;
            if (wait_time >= $time &&
                ((wait_time >= OEDQ_open_t && FROMOE) ||
                 (wait_time >= CE1DQ_open_t && FROMCE1) ||
                 (wait_time >= CE2DQ_open_t && FROMCE2)))
            begin
                TempData = Dout_zd[7:0];
                if(~LBNegs)
                begin
                    Dout_z[7:0] = 8'bx;
                end
                Dout_z[7:0] <= #(wait_time - $time ) TempData;
            end
            else
            begin
                Dout_z[7:0] = Dout_zd[7:0];
            end
       end
       else
            Dout_z[7:0] = Dout_zd[7:0];
   end
    always @(Dout_zd[15:8])
    begin : OutputGen1
        if (Dout_zd[8] !== 1'bz)
        begin
            //delays
            CE1DQ_t  = CE1Neg_event  + CE1DQ_01;
            CE2DQ_t  = CE2_event  + CE1DQ_01;
            OEDQ_t   = OENeg_event  + OEDQ_01;
            LBDQ_t   = LBNeg_event  + LBDQ_01;
            UBDQ_t   = UBNeg_event  + LBDQ_01;
            ADDRDQ_t = ADDR_event + ADDRDQ_01;

            if ((ADDRDQ_t >= $time )&&
                (ADDRDQ_t >= OEDQ_t) &&
                (ADDRDQ_t >= CE1DQ_t )&&
                (ADDRDQ_t >= CE2DQ_t )&&
                (ADDRDQ_t >= LBDQ_t) &&
                (ADDRDQ_t >= UBDQ_t))
                wait_time = ADDRDQ_t;
            else if ((CE1DQ_t >= $time )&&
                (CE1DQ_t >= OEDQ_t) &&
                (CE1DQ_t >= CE2DQ_t )&&
                (CE1DQ_t >= LBDQ_t) &&
                (CE1DQ_t >= UBDQ_t) &&
                (CE1DQ_t >= ADDRDQ_t))
                wait_time = CE1DQ_t;
            else if ((CE2DQ_t >= $time )&&
                (CE2DQ_t >= OEDQ_t) &&
                (CE2DQ_t >= CE1DQ_t )&&
                (CE2DQ_t >= LBDQ_t) &&
                (CE2DQ_t >= UBDQ_t) &&
                (CE2DQ_t >= ADDRDQ_t))
                wait_time = CE2DQ_t;
            else if ((OEDQ_t >= $time )&&
                (OEDQ_t >= CE1DQ_t )&&
                (OEDQ_t >= CE2DQ_t )&&
                (OEDQ_t >= LBDQ_t) &&
                (OEDQ_t >= UBDQ_t) &&
                (OEDQ_t >= ADDRDQ_t))
                wait_time = OEDQ_t;
            else if ((UBDQ_t >= $time )&&
                (UBDQ_t >= CE1DQ_t )&&
                (UBDQ_t >= CE2DQ_t )&&
                (UBDQ_t >= OEDQ_t) &&
                (UBDQ_t >= LBDQ_t) &&
                (UBDQ_t >= ADDRDQ_t))
                wait_time = UBDQ_t;

            if (wait_time >= $time &&
                ((wait_time >= OEDQ_open_t && FROMOE) ||
                 (wait_time >= CE1DQ_open_t && FROMCE1) ||
                 (wait_time >= CE2DQ_open_t && FROMCE2)))
            begin
                TempData1 = Dout_zd[15:8];
                if(~UBNegs)
                begin
                    Dout_z[15:8] = 8'bx;
                end
                Dout_z[15:8] <= #(wait_time - $time ) TempData1;
            end
            else
            begin
                Dout_z[15:8] = Dout_zd[15:8];
            end
       end
       else
            Dout_z[15:8] = Dout_zd[15:8];
   end

    reg  BuffInOE, BuffInCE1, BuffInADDR, BuffInLB;
    reg  BuffCtrlOE, BuffCtrlCE1, BuffCtrlLB;
    wire BuffOutOE, BuffOutCE1, BuffOutADDR, BuffOutLB;

    BUFFERIF    BUFOE   (BuffOutOE, BuffInOE, BuffCtrlOE);
    BUFFERIF    BUFCE1  (BuffOutCE1, BuffInCE1, BuffCtrlCE1);
    BUFFER      BUFADDR (BuffOutADDR, BuffInADDR);
    BUFFERIF    BUFLB   (BuffOutLB, BuffInLB, BuffCtrlLB);


    initial
    begin
        BuffInOE   = 1'b1;
        BuffCtrlOE = 1'b0;

        BuffInCE1   = 1'b1;
        BuffCtrlCE1 = 1'b0;

        BuffInADDR  = 1'b1;

        BuffInLB    = 1'b1;
        BuffCtrlLB = 1'b0;
    end
time tmp_oe;
time tmp_ce;
time tmp_lb;

    always @(BuffOutOE)
    begin
        if (BuffOutOE === 1'bZ)
        begin
            tmp_oe = $time;
            BuffCtrlOE = 1'b1;//open buffer
        end
        else if (BuffOutOE == 1'b1)
        begin
            OEDQ_1z = $time - tmp_oe;
            BuffInOE = 1'b0;
            tmp_oe = $time;
        end
        else if (BuffOutOE == 1'b0)
            OEDQ_01 = $time - tmp_oe;
    end

    always @(BuffOutCE1)
    begin
        if (BuffOutCE1 === 1'bZ)
        begin
            tmp_ce = $time;
            BuffCtrlCE1 = 1'b1;//open buffer
        end
        else if (BuffOutCE1 == 1'b1)
        begin
            CE1DQ_1z = $time - tmp_ce;
            BuffInCE1 = 1'b0;
            tmp_ce = $time;
        end
        else if (BuffOutCE1 == 1'b0)
            CE1DQ_01 = $time - tmp_ce;
    end

    always @(BuffOutLB)
    begin
        if (BuffOutLB === 1'bZ)
        begin
            tmp_lb = $time;
            BuffCtrlLB = 1'b1;//open buffer
        end
        else if (BuffOutLB == 1'b1)
        begin
            LBDQ_1z = $time - tmp_lb;
            BuffInLB = 1'b0;
            tmp_lb = $time;
        end
        else if (BuffOutLB == 1'b0)
            LBDQ_01 = $time - tmp_lb;
    end

    always @(posedge BuffOutADDR)
    begin
        ADDRDQ_01 = $time;
    end

////////////////////////////
//PROCEDURES AND FUNCTIONS
////////////////////////////

task SramRead;
input reg[HiAddrBitSram:0] Address;
input reg LBNegs;
input reg UBNegs;
inout reg [15:0] Dout_zd;
reg [15:0] tmp;
begin
    tmp = SramMem[Address];
    if (LBNegs == 0)
        Dout_zd[7:0] = tmp[7:0];
    else
        Dout_zd[7:0] = 8'bz;
    if (UBNegs == 0)
        Dout_zd[15:8] = tmp[15:8];
    else
        Dout_zd[15:8] = 8'bz;
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

