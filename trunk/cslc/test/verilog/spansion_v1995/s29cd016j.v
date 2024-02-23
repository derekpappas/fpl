///////////////////////////////////////////////////////////////////////////////
//  File name : s29cd016j.v
///////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2005 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  | author:   |   mod date:       | changes made:
//  V1.0        M.Vlahovic    05 Jun 08          Initial
//
///////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        FLASH
//  Technology:     Flash Memory
//  Part:           s29cd016j
//
//  Description:    16Mbit(512K x 32-Bit) Simultaneous opration, Burst Mode,
//                  Bottom and Top boot sector
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module s29cd016j
(
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

    DQ31    ,
    DQ30    ,
    DQ29    ,
    DQ28    ,
    DQ27    ,
    DQ26    ,
    DQ25    ,
    DQ24    ,
    DQ23    ,
    DQ22    ,
    DQ21    ,
    DQ20    ,
    DQ19    ,
    DQ18    ,
    DQ17    ,
    DQ16    ,
    DQ15    ,
    DQ14    ,
    DQ13    ,
    DQ12    ,
    DQ11    ,
    DQ10    ,
    DQ9     ,
    DQ8     ,
    DQ7     ,
    DQ6     ,
    DQ5     ,
    DQ4     ,
    DQ3     ,
    DQ2     ,
    DQ1     ,
    DQ0     ,

    CENeg   ,
    ADVNeg  ,
    OENeg   ,
    WENeg   ,
    WPNeg   ,
    RESETNeg,
    CLK     ,
    INDWAITNeg ,
    RYBYNeg);

////////////////////////////////////////////////////////////////////////
// P||t / Part Pin Declarations
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
    input  ADVNeg   ;
    input  OENeg    ;
    input  WENeg    ;
    input  RESETNeg ;
    input  CLK      ;
    input  WPNeg    ;
    output INDWAITNeg ;
    output RYBYNeg  ;

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
    assign A = {A18_ipd,
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

    wire DQ31_ipd  ;
    wire DQ30_ipd  ;
    wire DQ29_ipd  ;
    wire DQ28_ipd  ;
    wire DQ27_ipd  ;
    wire DQ26_ipd  ;
    wire DQ25_ipd  ;
    wire DQ24_ipd  ;
    wire DQ23_ipd  ;
    wire DQ22_ipd  ;
    wire DQ21_ipd  ;
    wire DQ20_ipd  ;
    wire DQ19_ipd  ;
    wire DQ18_ipd  ;
    wire DQ17_ipd  ;
    wire DQ16_ipd  ;
    wire DQ15_ipd  ;
    wire DQ14_ipd  ;
    wire DQ13_ipd  ;
    wire DQ12_ipd  ;
    wire DQ11_ipd  ;
    wire DQ10_ipd  ;
    wire DQ9_ipd   ;
    wire DQ8_ipd   ;
    wire DQ7_ipd   ;
    wire DQ6_ipd   ;
    wire DQ5_ipd   ;
    wire DQ4_ipd   ;
    wire DQ3_ipd   ;
    wire DQ2_ipd   ;
    wire DQ1_ipd   ;
    wire DQ0_ipd   ;

    wire [31 : 0 ] DIn;
    assign DIn = {DQ31_ipd,
                DQ30_ipd,
                DQ29_ipd,
                DQ28_ipd,
                DQ27_ipd,
                DQ26_ipd,
                DQ25_ipd,
                DQ24_ipd,
                DQ23_ipd,
                DQ22_ipd,
                DQ21_ipd,
                DQ20_ipd,
                DQ19_ipd,
                DQ18_ipd,
                DQ17_ipd,
                DQ16_ipd,
                DQ15_ipd,
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

    wire [31 : 0 ] DOut;
    assign DOut = { DQ31,
                    DQ30,
                    DQ29,
                    DQ28,
                    DQ27,
                    DQ26,
                    DQ25,
                    DQ24,
                    DQ23,
                    DQ22,
                    DQ21,
                    DQ20,
                    DQ19,
                    DQ18,
                    DQ17,
                    DQ16,
                    DQ15,
                    DQ14,
                    DQ13,
                    DQ12,
                    DQ11,
                    DQ10,
                    DQ9 ,
                    DQ8 ,
                    DQ7 ,
                    DQ6 ,
                    DQ5 ,
                    DQ4 ,
                    DQ3 ,
                    DQ2 ,
                    DQ1 ,
                    DQ0 };

    wire  CENeg_ipd    ;
    wire  ADV_ipd      ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  RESETNeg_ipd ;
    wire  CLK_ipd      ;
    wire  WPNeg_ipd    ;

//  internal delays
    reg TStart_out = 0; // e_start TimeOut
    reg TStart_in  = 0;
    reg Ctmout_out  = 0; // Sector Erase TimeOut
    reg Ctmout_in   = 0;
    reg Ready_in    = 0;
    reg Ready_out   = 0; // Device Ready_out after reset

    wire  DQ31_zd  ;
    wire  DQ30_zd  ;
    wire  DQ29_zd  ;
    wire  DQ28_zd  ;
    wire  DQ27_zd  ;
    wire  DQ26_zd  ;
    wire  DQ25_zd  ;
    wire  DQ24_zd  ;
    wire  DQ23_zd  ;
    wire  DQ22_zd  ;
    wire  DQ21_zd  ;
    wire  DQ20_zd  ;
    wire  DQ19_zd  ;
    wire  DQ18_zd  ;
    wire  DQ17_zd  ;
    wire  DQ16_zd  ;
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

    wire  DQ31_Pass;
    wire  DQ30_Pass;
    wire  DQ29_Pass;
    wire  DQ28_Pass;
    wire  DQ27_Pass;
    wire  DQ26_Pass;
    wire  DQ25_Pass;
    wire  DQ24_Pass;
    wire  DQ23_Pass;
    wire  DQ22_Pass;
    wire  DQ21_Pass;
    wire  DQ20_Pass;
    wire  DQ19_Pass;
    wire  DQ18_Pass;
    wire  DQ17_Pass;
    wire  DQ16_Pass;
    wire  DQ15_Pass;
    wire  DQ14_Pass;
    wire  DQ13_Pass;
    wire  DQ12_Pass;
    wire  DQ11_Pass;
    wire  DQ10_Pass;
    wire  DQ9_Pass;
    wire  DQ8_Pass;
    wire  DQ7_Pass;
    wire  DQ6_Pass;
    wire  DQ5_Pass;
    wire  DQ4_Pass;
    wire  DQ3_Pass;
    wire  DQ2_Pass;
    wire  DQ1_Pass;
    wire  DQ0_Pass;

    reg [31 : 0] DOut_zd;
    assign {DQ31_zd,
            DQ30_zd,
            DQ29_zd,
            DQ28_zd,
            DQ27_zd,
            DQ26_zd,
            DQ25_zd,
            DQ24_zd,
            DQ23_zd,
            DQ22_zd,
            DQ21_zd,
            DQ20_zd,
            DQ19_zd,
            DQ18_zd,
            DQ17_zd,
            DQ16_zd,
            DQ15_zd,
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
            DQ0_zd} = DOut_zd;

    reg [31 : 0] DOut_pass;
    assign {DQ31_Pass,
            DQ30_Pass,
            DQ29_Pass,
            DQ28_Pass,
            DQ27_Pass,
            DQ26_Pass,
            DQ25_Pass,
            DQ24_Pass,
            DQ23_Pass,
            DQ22_Pass,
            DQ21_Pass,
            DQ20_Pass,
            DQ19_Pass,
            DQ18_Pass,
            DQ17_Pass,
            DQ16_Pass,
            DQ15_Pass,
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
            DQ0_Pass} = DOut_pass;
    reg RY_zd = 1;

    parameter mem_file_name   = "none";
    parameter secsi_file_name = "none";
    parameter prot_file_name  = "none";
    parameter UserPreload     = 1'b0;
    parameter TimingModel     = "DefaultTimingModel";

    parameter PartID        = "s29cd016j";
    parameter MaxData       = 16'hFFFF;
    parameter SecS          = 16'h4000;
    parameter SecSiS        = 8'h40;
    parameter BankN         = 2;
    parameter SecN          = 32;
    parameter SSecN         = 8;
    parameter HAddr         = 18;
    parameter LAddrS        = 14;
    parameter BotSec        = 0;
    parameter TopSec        = 31;
    parameter glitch_t      = 5;

    parameter PL0 = 8'h0E;
    parameter SL0 = 8'h16;
    parameter OW0 = 8'h1E;
    parameter WP  = 8'h3A;

    parameter PL1 = 8'h0A;
    parameter SL1 = 8'h12;
    parameter OW1 = 8'h1A; // powerup
    reg PoweredUp;
    // Unlock Bypass signal
    reg Ulbypass     = 0;

    // Program Control Signals
    reg Pgms_act         = 0;   //Erase Embedded
    reg PDone            = 1;   //Prog. Done
    reg PStart           = 0;   //Start Programming
    reg PSusp            = 0;   //Suspend Program
    reg PRes             = 0;   //Resume Program
    reg PErr             = 0;   //Error Program

    // Erase Control Signals
    reg Ers_act          = 0;   //Erae Embedded
    reg EDone            = 1;   //Ers. Done
    reg EStart           = 0;   //Start Erase
    reg ESusp            = 0;   //Suspend Erase
    reg ERes             = 0;   //Resume Erase
    reg EErr             = 0;   //Error Erase
    integer ers_cnt  = 0;

    //Sectors selected for erasure
    reg [SecN-1:0]  E_queue;
    reg [SSecN-1:0] ET_queue ;
    reg [SSecN-1:0] EB_queue;

    //Command Register
    reg write ;
    reg read  ;

    //Address
    integer BA      = 0;
    integer SA      = 0;
    integer SSA     = 0;
    integer SaPPB   = 0;
    integer SSaPPB  = 0;
    integer Address = 0;
    integer AddrFsm = 0;
    integer AddrPpb = 0;
    integer RAddr   = 0;
    integer PpbBL   = 0;
    time    LAddr_event;
    reg  secsi_addressed   = 0;
    reg  secsi_range       = 0;
    reg[HAddr:0] ALatch;

    // Letch for burst comand register
    reg[31:0] Password[0:1];

    reg[31:0] Data;
    reg[7:0]  DataLo;

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;

    reg RST ;
    reg reseted ;

    integer MemLow   [0:SecN*SecS-1];
    integer MemHigh  [0:SecN*SecS-1];
    integer SecSiLow [0:SecSiS-1];
    integer SecSiHigh[0:SecSiS-1];
    //Sector Protection Status
    reg [SecN-1:0]  S_prot =0;
    reg [SSecN-1:0] SB_prot=0;
    reg [SSecN-1:0] ST_prot=0;

    reg [SecN-1:0]  SPpb_prot =0;
    reg [SSecN-1:0] SBPpb_prot=0;
    reg [SSecN-1:0] STPpb_prot=0;

    reg [SecN-1:0]  SDyb_prot=0;
    reg [SSecN-1:0] SBDyb_prot=0;
    reg [SSecN-1:0] STDyb_prot=0;

    integer CFI_array[16:91];
    integer sssa[0:SSecN-1];
    integer ssea[0:SSecN-1] ;

    integer PasUnCycle =0;
    reg PasMLock   = 1'b0;
    reg PerMLock   = 1'b0;
    reg Ppb_lock_b = 1'b0;
    reg Otp_lock   = 1'b0;
    reg Otp_act    = 1'b0;
    reg PPrDone    = 1'b1;
    reg PUDone     = 1'b1;
    reg Dyb_prot;
    reg BProt_done;

    reg Viol = 1'b0;

    // type of model
    reg top_model;
    // BURST
    reg StartB       = 0;
    reg EndB         = 0;
    reg[15:0] CommandReg ;

    reg ASyncMod      ;
    reg IND_act       ;
    reg Edge_Act      ;
    reg[2:0] BurstRead_Mode;
    reg[3:0] BurstWait;

    reg IND_zd        = 1;
    reg IND_pass      = 1;
    reg KPathEnable   = 0;
    reg beginB        = 1'b0;
    integer WrapCnt   = 0;

    // Address variables
    reg [BankN-1:0] BBusy    = 0;
    reg [BankN-1:0] BAsel    = 0;
    reg [BankN-1:0] BULock   = 0;
    reg [BankN-1:0] BErase   = 0;
    reg [BankN-1:0] BErase_t = 0;

    // Bank Size
    parameter small_bank = 1'b0; //small bank
    parameter large_bank = 1'b1; //big bank
    reg size_bank;

    // iterators for for loop
    integer i,j,k;
    ///////////////////////////////////////////////////////////////////////////
    //Interconnect Path Delay Section
    ///////////////////////////////////////////////////////////////////////////

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

    buf   (DQ31_ipd, DQ31);
    buf   (DQ30_ipd, DQ30);
    buf   (DQ29_ipd, DQ29);
    buf   (DQ28_ipd, DQ28);
    buf   (DQ27_ipd, DQ27);
    buf   (DQ26_ipd, DQ26);
    buf   (DQ25_ipd ,DQ25);
    buf   (DQ24_ipd ,DQ24);
    buf   (DQ23_ipd ,DQ23);
    buf   (DQ22_ipd ,DQ22);
    buf   (DQ21_ipd ,DQ21);
    buf   (DQ20_ipd ,DQ20);
    buf   (DQ19_ipd ,DQ19);
    buf   (DQ18_ipd ,DQ18);
    buf   (DQ17_ipd ,DQ17);
    buf   (DQ16_ipd ,DQ16);
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
    buf   (ADVNeg_ipd   , ADVNeg   );
    buf   (OENeg_ipd    , OENeg    );
    buf   (WENeg_ipd    , WENeg    );
    buf   (RESETNeg_ipd , RESETNeg );
    buf   (CLK_ipd      , CLK      );
    buf   (WPNeg_ipd    , WPNeg    );
   /////////////////////////////////////////////////////////////////////////////
   // Propagation  delay Section
   /////////////////////////////////////////////////////////////////////////////

    nmos   (DQ31,   DQ31_Pass , 1);
    nmos   (DQ30,   DQ30_Pass , 1);
    nmos   (DQ29,   DQ29_Pass , 1);
    nmos   (DQ28,   DQ28_Pass , 1);
    nmos   (DQ27,   DQ27_Pass , 1);
    nmos   (DQ26,   DQ26_Pass , 1);
    nmos   (DQ25,   DQ25_Pass , 1);
    nmos   (DQ24,   DQ24_Pass , 1);
    nmos   (DQ23,   DQ23_Pass , 1);
    nmos   (DQ22,   DQ22_Pass , 1);
    nmos   (DQ21,   DQ21_Pass , 1);
    nmos   (DQ20,   DQ20_Pass , 1);
    nmos   (DQ19,   DQ19_Pass , 1);
    nmos   (DQ18,   DQ18_Pass , 1);
    nmos   (DQ17,   DQ17_Pass , 1);
    nmos   (DQ16,   DQ16_Pass , 1);
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

    nmos   (RYBYNeg  ,     1'b0      , ~RY_zd);
    nmos   (INDWAITNeg  ,  IND_pass  , 1);

    reg  tpd_CE, tpd_OE, tpd_addr, tpd_clk;
    reg  we_act = 0;
    wire ASynchroOe;
    wire SynchroOe;
    wire ASynchroCe;
    wire ASynchro_wewr;
    wire Synchro_wewr;
    wire SynchroCe;
    wire clk_path;
    wire embd;

    wire ASynchro;
    assign ASynchro = ASyncMod;
    assign ASynchro_wewr = ASyncMod && ~CENeg;
    assign Synchro_wewr = ~ASyncMod && ~CENeg;

    wire SyncEn;
    wire se_we_clk;
    wire hold_a_adv;
    wire toggle_v;
    wire act_we;
    assign embd = ~PDone | ~EDone;
    assign SyncEn = ~ADVNeg & ~ASyncMod;
    assign ASynchroOe = tpd_OE & ASyncMod;
    assign SynchroOe  = tpd_OE & ~ASyncMod;
    assign ASynchroCe = tpd_CE & ASyncMod;
    assign SynchroCe  = tpd_CE & ~ASyncMod;
    assign clk_path   = tpd_clk & ~ASyncMod & CLK;
    assign se_we_clk  = ~ASyncMod & WENeg & ~ CENeg;
    assign toggle_v   = ~RY_zd;
    assign hold_a_adv = ~CENeg & ~ASyncMod & ~beginB;
    assign act_we = we_act;
/////////////////////////////////////////////
// Timing check and propagation delay section
/////////////////////////////////////////////
specify
    // tipd delays: interconnect path delays , mapped to input p||t delays.
    // In Verilog is ~ necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

    specparam           tpd_A0_DQ0                    =1;
    specparam           tpd_CENeg_DQ0                 =1;
    specparam           tpd_OENeg_DQ0                 =1;
    specparam           tpd_CLK_DQ0                   =1;
    specparam           tpd_CLK_INDWAITNeg            =1;
    specparam           tpd_OENeg_INDWAITNeg          =1;
    specparam           tpd_CENeg_INDWAITNeg          =1;
    specparam           tpd_WENeg_RYBYNeg             =1;
    specparam           tsetup_A0_WENeg               =1;
    specparam           tsetup_DQ0_WENeg              =1;
    specparam           tsetup_DQ0_CENeg              =1;
    specparam           tsetup_A0_CENeg               =1;
    specparam           tsetup_CENeg_WENeg            =1;
    specparam           tsetup_WENeg_CENeg            =1;
    specparam           tsetup_A0_ADVNeg              =1;
    specparam           tsetup_A0_CLK                 =1;
    specparam           tsetup_CENeg_ADVNeg           =1;
    specparam           tsetup_ADVNeg_WENeg           =1;
    specparam           tsetup_CLK_WENeg_ADVNeg_EQ_0  =1;
    specparam           tsetup_CLK_WENeg_ADVNeg_EQ_1  =1;
    specparam           tsetup_OENeg_WENeg            =1;
    specparam           tsetup_WENeg_OENeg            =1;
    specparam           tsetup_CENeg_CLK              =1;
    specparam           tsetup_ADVNeg_CLK             =1;
    specparam           tsetup_WPNeg_WENeg            =1;
    specparam           tsetup_RYBYNeg_WENeg          =1;
    specparam           tsetup_RYBYNeg_CLK            =1;
    specparam           tsetup_CLK_ADVNeg             =1;
    specparam           tsetup_CLK_WENeg              =1;

    specparam           thold_CENeg_RESETNeg    =1;
    specparam           thold_OENeg_RESETNeg    =1;
    specparam           thold_OENeg_WENeg       =1;
    specparam           thold_A0_CENeg          =1;
    specparam           thold_A0_WENeg          =1;

    specparam           thold_A0_CLK            =1;
    specparam           thold_A0_ADVNeg         =1;
    specparam           thold_CLK_WENeg         =1;
    specparam           thold_ADVNeg_CLK        =1;
    specparam           thold_CENeg_CLK         =1;
    specparam           thold_DQ0_CENeg         =1;
    specparam           thold_DQ0_WENeg         =1;
    specparam           thold_WENeg_OENeg       =1;
    specparam           thold_WENeg_CENeg       =1;
    specparam           thold_WPNeg_RYBYNeg     =1;
    specparam           thold_CENeg_WENeg       =1;

    specparam           tpw_RESETNeg_negedge    =1;
    specparam           tpw_WENeg_negedge       =1;
    specparam           tpw_WENeg_posedge       =1;
    specparam           tpw_CENeg_negedge       =1;
    specparam           tpw_CENeg_posedge       =1;
    specparam           tpw_ADVNeg_negedge      =1;
    specparam           tpw_A0_negedge          =1;
    specparam           tpw_A0_posedge          =1;
    specparam           tpw_CLK_posedge         =1;
    specparam           tpw_CLK_negedge         =1;
    specparam           tperiod_CLK             =1;
    specparam           tperiod_WENeg           =1;
    
    // tdevice values: values for internal delays
    specparam tdevice_POW            = 18000;      //18 us;
    // Sector Erase Operation    tWHWH2
    specparam tdevice_SEO            = 1000000000; //1 sec;
    // erase suspend timeout - only max time specified
    specparam tdevice_TSTART         = 20000;     //20 us;
    // sector erase command sequence timeout
    specparam tdevice_CTMOUT         = 80000;     //80 us;
    // device Ready after Hardware reset(during embeded algorithm)
    specparam tdevice_READY          = 11000;     //11 us;
    // PPB program time
    specparam tdevice_PPBW           = 150000;    //150 us;
    // PPB erase time
    specparam tdevice_PPBE           = 15000000;  //15 ms;
    // uncock ppbLock commAND - time neaded for bouth part of password
    specparam tdevice_UNLOCK         = 2000;      //2 us;

///////////////////////////////////////////////////////////////////////////////
// Input P||t  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

    if (tpd_addr)
        ( A0 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A0 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A1 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A1 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A2 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A2 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A3 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A3 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A4 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A4 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A5 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A5 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A6 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A6 => DQ31 ) = tpd_A0_DQ0;

        if (tpd_addr)
        ( A7 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A7 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A8 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A8 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A9 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A9 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A10 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A10 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A11 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        (A11 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A11 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A12 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A12 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A13 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A13 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A14 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A14 => DQ31 ) = tpd_A0_DQ0;

        if (tpd_addr)
        ( A15 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A15 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A16 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A16 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A17 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A17 => DQ31 ) = tpd_A0_DQ0;

    if (tpd_addr)
        ( A18 => DQ0 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ1 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ2 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ3 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ4 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ5 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ6 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ7 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ8 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ9 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ10 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ11 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ12 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ13 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ14 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ15 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ16 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ17 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ18 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ19 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ20 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ21 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ22 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ23 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ24 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ25 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ26 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ27 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ28 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ29 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ30 ) = tpd_A0_DQ0;
    if (tpd_addr)
        ( A18 => DQ31 ) = tpd_A0_DQ0;    

    if (ASynchroCe)
        ( CENeg => DQ0 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ1 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ2 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ3 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ4 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ5 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ6 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ7 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ8 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ9 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ10 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ11 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ12 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ13 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ14 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ15 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ16 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ17 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ18 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ19 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ20 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ21 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ22 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ23 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ24 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ25 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ26 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ27 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ28 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ29 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ30 ) = tpd_CENeg_DQ0;
    if (ASynchroCe)
        ( CENeg => DQ31 ) = tpd_CENeg_DQ0;

    if (SynchroCe)
        ( CENeg => DQ0 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ1 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ2 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ3 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ4 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ5 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ6 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ7 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ8 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ9 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ10 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ11 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ12 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ13 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ14 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ15 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ16 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ17 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ18 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ19 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ20 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ21 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ22 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ23 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ24 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ25 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ26 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ27 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ28 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ29 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ30 ) = tpd_CENeg_DQ0;
    if (SynchroCe)
        ( CENeg => DQ31 ) = tpd_CENeg_DQ0;

    if (SynchroOe)
        ( OENeg => DQ0 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ1 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ2 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ3 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ4 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ5 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ6 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ7 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ8 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ9 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ10 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ11 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ12 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ13 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ14 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ15 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ16 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ17 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ18 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ19 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ20 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ21 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ22 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ23 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ24 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ25 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ26 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ27 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ28 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ29 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ30 ) = tpd_OENeg_DQ0;
    if (SynchroOe)
        ( OENeg => DQ31 ) = tpd_OENeg_DQ0;

    if (ASynchroOe)
        ( OENeg => DQ0 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ1 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ2 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ3 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ4 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ5 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ6 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ7 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ8 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ9 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ10 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ11 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ12 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ13 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ14 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ15 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ16 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ17 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ18 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ19 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ20 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ21 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ22 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ23 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ24 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ25 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ26 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ27 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ28 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ29 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ30 ) = tpd_OENeg_DQ0;
    if (ASynchroOe)
        ( OENeg => DQ31 ) = tpd_OENeg_DQ0;

    if (clk_path)
        (CLK  => DQ0) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ1) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ2) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ3) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ4) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ5) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ6) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ7) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ8) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ9) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ10) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ11) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ12) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ13) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ14) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ15) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ16) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ17) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ18) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ19) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ20) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ21) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ22) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ23) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ24) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ25) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ26) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ27) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ28) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ29) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ30) = tpd_CLK_DQ0;
    if (clk_path)
        (CLK  => DQ31) = tpd_CLK_DQ0;

    if (reseted)
        (WENeg => RYBYNeg)     = tpd_WENeg_RYBYNeg;
    if (reseted)
        (CENeg => RYBYNeg)     = tpd_WENeg_RYBYNeg;

    if  (clk_path)
        (CLK  => INDWAITNeg) = tpd_CLK_INDWAITNeg;
    if  (SynchroOe)
        (OENeg  => INDWAITNeg) = tpd_OENeg_INDWAITNeg;
    if  (SynchroCe)
        (CENeg  => INDWAITNeg) = tpd_CENeg_INDWAITNeg;
    if  (ASynchroOe)
        (OENeg  => INDWAITNeg) = tpd_OENeg_INDWAITNeg;
    if  (ASynchroCe)
        (CENeg  => INDWAITNeg) = tpd_CENeg_INDWAITNeg;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           /
///////////////////////////////////////////////////////////////////////////////
    $setup ( CENeg, posedge CLK&&&SyncEn, tsetup_CENeg_CLK, Viol);
    $setup ( ADVNeg, posedge CLK&&&SyncEn,tsetup_ADVNeg_CLK,Viol);

    $setup ( A0 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A1 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A2 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A3 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A4 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A5 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A6 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A7 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A8 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A9 ,  posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A10 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A11 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A12 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A13 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A14 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A15 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A16 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A17 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);
    $setup ( A18 , posedge CLK&&&SyncEn, tsetup_A0_CLK, Viol);

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

    $setup ( DQ0 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ1 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ2 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ3 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ4 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ5 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ6 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ7 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ8 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ9 ,  posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ10 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ11 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ12 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ13 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ14 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ15 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ16 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ17 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ18 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ19 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ20 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ21 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ22 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ23 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ24 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ25 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ26 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ27 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ28 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ29 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ30 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);
    $setup ( DQ31 , posedge WENeg &&& ASynchro_wewr==1,tsetup_DQ0_WENeg, Viol);

    $setup ( DQ0 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ1 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ2 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ3 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ4 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ5 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ6 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ7 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ8 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ9 ,  posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ10 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ11 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ12 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ13 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ14 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ15 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ16 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ17 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ18 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ19 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ20 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ21 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ22 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ23 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ24 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ25 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ26 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ27 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ28 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ29 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ30 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);
    $setup ( DQ31 , posedge WENeg &&& Synchro_wewr==1, tsetup_DQ0_WENeg, Viol);

    $setup ( A0 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A1 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A2 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A3 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A4 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A5 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A6 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A7 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A8 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A9 ,  negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A10 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A11 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A12 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A13 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A14 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A15 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A16 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A17 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);
    $setup ( A18 , negedge CENeg &&& WENeg==0, tsetup_A0_CENeg, Viol);

    $setup ( DQ0 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ1 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ2 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ3 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ4 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ5 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ6 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ7 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ8 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ9 ,  posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ10 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ11 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ12 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ13 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ14 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ15 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ16 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ17 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ18 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ19 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ20 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ21 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ22 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ23 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ24 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ25 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ26 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ27 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ28 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ29 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ30 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);
    $setup ( DQ31 , posedge CENeg &&& WENeg==0, tsetup_DQ0_CENeg, Viol);

    $setup ( CENeg, negedge WENeg &&& CENeg==0, tsetup_CENeg_WENeg, Viol);
    $setup ( WENeg, negedge CENeg &&& WENeg==0, tsetup_WENeg_CENeg, Viol);

    $setup ( WENeg, negedge OENeg &&& embd==1 ,tsetup_WENeg_OENeg, Viol);
    $setup ( WENeg, negedge OENeg &&& embd==0 ,tsetup_WENeg_OENeg, Viol);
    $setup ( OENeg, negedge WENeg &&& OENeg==1, tsetup_OENeg_WENeg, Viol);
    $setup ( WPNeg, posedge WENeg             , tsetup_WPNeg_WENeg, Viol);
    $setup ( RYBYNeg   , negedge WENeg , tsetup_RYBYNeg_WENeg, Viol);
    $setup ( RYBYNeg   , negedge CENeg , tsetup_RYBYNeg_WENeg, Viol);

    $hold ( posedge CLK&&&SyncEn, ADVNeg,thold_ADVNeg_CLK, Viol);

    $hold ( posedge CLK&&&SyncEn,  A0 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A1 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A2 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A3 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A4 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A5 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A6 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A7 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A8 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A9 , thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A10 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A11 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A12 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A13 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A14 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A15 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A16 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A17 ,thold_A0_CLK, Viol);
    $hold ( posedge CLK&&&SyncEn,  A18 ,thold_A0_CLK, Viol);

    $hold ( posedge ADVNeg&&&SyncEn,  A0 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A1 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A2 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A3 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A4 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A5 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A6 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A7 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A8 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A9 , thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A10 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A11 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A12 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A13 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A14 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A15 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A16 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A17 ,thold_A0_CLK, Viol);
    $hold ( posedge ADVNeg&&&SyncEn,  A18 ,thold_A0_CLK, Viol);

    $hold (  posedge WENeg&&&CENeg==0,CENeg, thold_CENeg_WENeg, Viol);

    $hold ( negedge WENeg &&& ASynchro_wewr==1, A0 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A1 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A2 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A3 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A4 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A5 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A6 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A7 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A8 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A9 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A10 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A11 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A12 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A13 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A14 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A15 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A16 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A17 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& ASynchro_wewr==1, A18 , thold_A0_WENeg, Viol);

    $hold ( negedge WENeg &&& Synchro_wewr==1, A0 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A1 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A2 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A3 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A4 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A5 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A6 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A7 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A8 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A9 ,  thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A10 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A11 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A12 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A13 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A14 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A15 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A16 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A17 , thold_A0_WENeg, Viol);
    $hold ( negedge WENeg &&& Synchro_wewr==1, A18 , thold_A0_WENeg, Viol);

    $hold (  posedge WENeg &&& CENeg==0, DQ0 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ1 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ2 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ3 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ4 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ5 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ6 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ7 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ8 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ9 ,  thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ10 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ11 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ12 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ13 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ14 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ15 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ16 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ17 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ18 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ19 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ20 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ21 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ22 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ23 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ24 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ25 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ26 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ27 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ28 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ29 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ30 , thold_DQ0_WENeg, Viol);
    $hold (  posedge WENeg &&& CENeg==0, DQ31 , thold_DQ0_WENeg, Viol);

    $hold ( negedge CENeg &&& WENeg==0, A0 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A1 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A2 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A3 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A4 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A5 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A6 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A7 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A8 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A9 ,  thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A10 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A11 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A12 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A13 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A14 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A15 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A16 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A17 , thold_A0_CENeg, Viol);
    $hold ( negedge CENeg &&& WENeg==0, A18 , thold_A0_CENeg, Viol);

    $hold (  posedge CENeg &&& WENeg==0, DQ0 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ1 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ2 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ3 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ4 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ5 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ6 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ7 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ8 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ9 , thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ10 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ11 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ12 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ13 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ14 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ15 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ16 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ17 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ18 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ19 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ20 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ21 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ22 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ23 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ24 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ25 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ26 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ27 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ28 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ29 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ30 ,thold_DQ0_CENeg, Viol);
    $hold (  posedge CENeg &&& WENeg==0, DQ31 ,thold_DQ0_CENeg, Viol);

    $hold ( posedge CENeg &&& WENeg==0, WENeg, thold_WENeg_CENeg, Viol);
    $hold ( posedge RYBYNeg ,    WPNeg , thold_WPNeg_RYBYNeg, Viol);
    $hold ( posedge RESETNeg&&&CENeg, CENeg, thold_CENeg_RESETNeg, Viol);
    $hold ( posedge RESETNeg&&&OENeg, OENeg, thold_OENeg_RESETNeg, Viol);

    $width (negedge RESETNeg, tpw_RESETNeg_negedge);
    $width (posedge WENeg, tpw_WENeg_posedge);
    $width (negedge WENeg&&&act_we==1, tpw_WENeg_negedge);
    $width (negedge WENeg&&&act_we==0, tpw_WENeg_negedge);
    $width (posedge CENeg   , tpw_WENeg_posedge);
    $width (negedge CENeg&&&WENeg==0, tpw_WENeg_negedge);
    $width (negedge ADVNeg  , tpw_ADVNeg_negedge);
    $width (posedge CLK     , tpw_CLK_posedge);
    $width (negedge CLK     , tpw_CLK_negedge);
    $period(negedge CLK, tperiod_CLK);
    $period(posedge CLK, tperiod_CLK);
    $period(negedge WENeg, tperiod_WENeg);
    $width (negedge A0   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A1   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A2   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A3   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A4   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A5   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A6   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A7   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A8   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A9   &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A10  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A11  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A12  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A13  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A14  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A15  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A16  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A17  &&& WENeg==1, tpw_A0_negedge);
    $width (negedge A18  &&& WENeg==1, tpw_A0_negedge);

    $width (posedge A0   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A1   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A2   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A3   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A4   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A5   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A6   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A7   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A8   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A9   &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A10  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A11  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A12  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A13  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A14  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A15  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A16  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A17  &&& WENeg==1, tpw_A0_posedge);
    $width (posedge A18  &&& WENeg==1, tpw_A0_posedge);
endspecify

    ///////////////////////////////////////////////////////////////////////////
    // WE#/CE# control write select
    ///////////////////////////////////////////////////////////////////////////
     always @(CENeg)
    begin
        if (~CENeg && WENeg)
            we_act = 1'b1;
        else if (CENeg && WENeg)
            we_act = 1'b0;
    end

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

    // FSM states
    parameter RESET                   =6'd0;
    parameter Z001                    =6'd1;
    parameter PREL_SETBWB             =6'd2;
    parameter PREL_ULBYPASS           =6'd3;
    parameter UNLOCK_RESET            =6'd5;
    parameter OTP                     =6'd6;
    parameter DYB                     =6'd7;
    parameter STATUS_BPROTECT         =6'd8;
    parameter PPB_ERASE               =6'd10;
    parameter PPB_PROGRAM             =6'd11;
    parameter PPB_PROGRAM_VERIFY      =6'd12;
    parameter PPB_ERASE_VERIFY        =6'd13;
    parameter PPB_LOCK                =6'd14;
    parameter COMMAND_REG_WRITE       =6'd15;
    parameter COMMAND_REG_READ        =6'd16;
    parameter PERSISTANT_MODE_PROGRAM =6'd17;
    parameter PERSISTANT_MODE_VERIFY  =6'd18;
    parameter OTP_LOCK_PROGRAM        =6'd19;
    parameter OTP_LOCK_VERIFY         =6'd20;
    parameter PASSWORD_MODE_PROGRAM   =6'd21;
    parameter PASSWORD_MODE_VERIFY    =6'd22;
    parameter PASSWORD_SET            =6'd23;
    parameter PASSWORD_PROGRAM        =6'd24;
    parameter PASSWORD_VERIFY         =6'd25;
    parameter PASSWORD_UNLOCK_SET     =6'd26;
    parameter PASSWORD_UNLOCK         =6'd29;
    parameter DYB_STATUS              =6'd31;
    parameter CFI                     =6'd32;
    parameter AS                      =6'd33;
    parameter AS_CFI                  =6'd34;
    parameter A0SEEN                  =6'd35;
    parameter C8                      =6'd36;
    parameter C8_Z001                 =6'd37;
    parameter C8_PREL                 =6'd40;
    parameter ERS                     =6'd41;
    parameter SERS                    =6'd42;
    parameter SPS                     =6'd43;
    parameter SERS_EXEC               =6'd44;
    parameter SUSP                    =6'd45;
    parameter SUSP_AS                 =6'd46;
    parameter SUSP_OTP                =6'd47;
    parameter SUSP_Z001               =6'd48;
    parameter SUSP_SETBWB             =6'd49;
    parameter SUSP_CFI                =6'd50;
    parameter SUSP_ULBYPASS           =6'd51;
    parameter SUSP_ULBYPASS_RESET     =6'd52;
    parameter SUSP_AS_CFI             =6'd53;
    parameter SUSP_A0SEEN             =6'd54;
    parameter PGMS                    =6'd55;

    reg [5:0] current_state;
    reg [5:0] next_state;
    reg [5:0] idle_state;

    // Burst fsm
    parameter IDLE_READ  = 1'b0;
    parameter BURST_READ = 1'b1;
    reg BurstState;

    // check when data is generated from model to avoid setuphold check in
    initial
    begin
        Password[0] = ~(0);
        Password[1] = ~(0);
    end

    initial
    begin
        // init arrays holding e_start/end address of smaller Sectors
        sssa[0] = 16'h0000;
        sssa[1] = 16'h0800;
        sssa[2] = 16'h1000;
        sssa[3] = 16'h1800;
        sssa[4] = 16'h2000;
        sssa[5] = 16'h2800;
        sssa[6] = 16'h3000;
        sssa[7] = 16'h3800;
        ssea[0] = 16'h07FF;
        ssea[1] = 16'h0FFF;
        ssea[2] = 16'h17FF;
        ssea[3] = 16'h1FFF;
        ssea[4] = 16'h27FF;
        ssea[5] = 16'h2FFF;
        ssea[6] = 16'h37FF;
        ssea[7] = 16'h3FFF;
    end

    // preload
    initial
    begin: InitMemory
        reg[31:0] mem_preload[0:SecS*SecN -1];
        reg[31:0] secsi_preload[0:SecSiS -1];
        integer prot_preload [0:23];
        reg[31:0] MaxDPreload ;
        integer sec_ind;
        MaxDPreload = (MaxData+1)*(MaxData+1)-1;
        for (j=0;j<=SecN*SecS-1;j=j+1)
        begin
            mem_preload[j]=MaxDPreload;
        end
        for (j=0;j<=SecSiS-1;j=j+1)
        begin
            secsi_preload[j]=MaxDPreload;
        end
        for (sec_ind = 0; sec_ind <= 23; sec_ind = sec_ind + 1)
            prot_preload[sec_ind] = 0;
        // - Memory  preload, s29cd016j.mem
        //   s29cd016j memory file
        //   /        - comment
        //   @aaaaa   - <aaaaa> stands for address
        //   dddddddd - <dddddddd> is double word to be written at Mem(aaaaa++)
        //              (aaaaa is incremented at every load)
        //   NO EMPTY LINES.
        if (UserPreload && mem_file_name != "none")
            $readmemh(mem_file_name, mem_preload);

        // - SecSi  preload, s29cd016j_secsi.mem
        //   s29cd016j SecSi memory file
        //   /        - comment
        //   @aa      - <aa> stands for address
        //   dddddddd - <dddddddd> is double word to be written at SecSi(aa++)
        //              (aa is incremented at every load)
        //   NO EMPTY LINES.
        if (UserPreload && secsi_file_name != "none")
            $readmemh(secsi_file_name, secsi_preload);

        //   - Sector protect preload, s29cd016j_prot.mem
        //   s29cd016j_prot  sector protect file
        //   //   - comment
        //   @aa  - <aa> stands for sector group identification
        //   d    - <d> is bit to be written at SecProt(aa++)
        //             (aa is incremented at every load)
        //   NO EMPTY LINES.
        if (UserPreload && prot_file_name != "none")
            $readmemh(prot_file_name, prot_preload);

        for (i=0;i<=SecS*SecN-1;i=i+1)
        begin
            MemHigh[i] = mem_preload[i]/(MaxData+1);
            MemLow[i]  = mem_preload[i]%(MaxData+1);
        end
        for (i=0;i<=SecSiS-1;i=i+1)
        begin
            SecSiHigh[i] = secsi_preload[i]/(MaxData+1);
            SecSiLow[i]  = secsi_preload[i]%(MaxData+1);
        end

        for (sec_ind = 0; sec_ind <= 23; sec_ind = sec_ind + 1)
        begin
            if (prot_preload[sec_ind] == 1)
            begin
                if (sec_ind <= 7)
                begin
                    SaPPB  = 0;
                    SSaPPB = sec_ind;
                end
                else if (sec_ind == 8)
                    SaPPB  = BotSec + 1;
                else if (sec_ind <= 14)
                    SaPPB  = 4 + (sec_ind - 9)*4;
                else if (sec_ind == 15)
                    SaPPB  = TopSec - 1;
                else
                begin
                    SaPPB  = TopSec;
                    SSaPPB = sec_ind - 16;
                end
                PpbBL  = (SaPPB / 4)*4;
                if  ((SaPPB - BotSec) > 0 && (SaPPB - BotSec) < 4)
                    SPpb_prot[BotSec+3 : BotSec+1] = 3'b111;
                else if ((TopSec - SaPPB) > 0 && (TopSec - SaPPB)<4)
                    SPpb_prot[TopSec-1 : TopSec-3] = 3'b111;
                else if (SaPPB != BotSec && SaPPB != TopSec)
                begin
                    SPpb_prot[PpbBL]   = 1;
                    SPpb_prot[PpbBL+1] = 1;
                    SPpb_prot[PpbBL+2] = 1;
                    SPpb_prot[PpbBL+3] = 1;
                end
                else if (SaPPB == BotSec)
                    SBPpb_prot[SSaPPB] = 1;
                else
                    STPpb_prot[SSaPPB] = 1;
            end
        end
    end

    initial
    begin : TimeModelSet
        reg[19*8:1] tmp_timing;
        reg[7:0] tmp_char;
        integer found;
        integer i;
        integer j;
        tmp_timing = TimingModel;//copy of TimingModel
        i = 19;
        found = 0;
        //search for first non null character
        //i keeps position of first non null character
        while ((i >= 0) && (found != 1))
        begin
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
                //bottom/top character is 9
                tmp_char[j] = TimingModel[(i-15)*8+j];
            end
        end
        if (tmp_char == "1")
        begin
            top_model = 1'b0;
        end
        else if (tmp_char == "0")
        begin
            top_model = 1'b1;
        end
    end

    //Power Up time 100 ns;
    initial
    begin
        PoweredUp = 1'b0;
        #100 PoweredUp = 1'b1;
    end

    initial
    begin
        CommandReg = 16'h9CC3;
        ASyncMod   = CommandReg[15];
        IND_act    = CommandReg[8];
        Edge_Act   = CommandReg[5];
        BurstRead_Mode = CommandReg[2 : 0];
        BurstWait      = CommandReg[13 : 10];
    end

    always@(CommandReg)
    begin
        ASyncMod   = CommandReg[15];
        IND_act    = CommandReg[8];
        Edge_Act   = CommandReg[5];
        BurstRead_Mode = CommandReg[2 : 0];
        BurstWait      = CommandReg[13 : 10];
        if (BurstRead_Mode == 3'b000 || BurstRead_Mode == 3'b100 ||
        BurstRead_Mode  == 3'b101 || BurstRead_Mode == 3'b110)
            ASyncMod = 1'b1;
    end

    always @(RESETNeg)
    begin : RST1
        RST <= #499 RESETNeg;
    end

    always @(posedge TStart_in)
    begin:EStart1
        #(tdevice_TSTART- glitch_t) TStart_out = TStart_in;
    end
    always @(negedge TStart_in)
    begin:EStart2
        disable EStart1;
        #1 TStart_out = TStart_in;
    end

    always @(posedge Ctmout_in)
    begin:TCtmout1
        #(tdevice_CTMOUT- glitch_t) Ctmout_out = Ctmout_in;
    end

    always @(negedge Ctmout_in)
    begin:TCtmout2
        disable TCtmout1;
        #1 Ctmout_out = Ctmout_in;
    end

    always @(posedge Ready_in)
    begin:TReady1
        #(tdevice_READY- glitch_t) Ready_out = Ready_in ;
    end

    always @(negedge Ready_in)
    begin:TReady2
        disable TReady1;
        #1 Ready_out = Ready_in ;
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
                if (current_state == PGMS || current_state == SERS_EXEC ||
                    current_state == ERS  || current_state  == SPS)
                begin
                    //if program or erase in progress
                    Ready_in = 1'b1;
                    R = 1'b1;
                end
                else
                begin
                    Ready_in = 1'b0;
                    R = 1'b0;         //prog or erase not in progress
                end
            end
            else if (RESETNeg && RST)
            begin
                //RESET# pulse < tRP
                Ready_in = 1'b0;
                R = 1'b0;
                E = 1'b1;
            end
        end
    end

    always @(next_state or RESETNeg or CENeg or RST or Ready_out or PoweredUp)
    begin: StateTransition
        if (PoweredUp)
        begin
            if (RESETNeg && (~R || (R && Ready_out)))
            begin
                current_state = next_state;
                Ready_in = 1'b0;
                E = 1'b0;
                R = 1'b0;
                reseted = 1'b1;
            end
            else if ((~R && ~RESETNeg && ~RST) ||
                (R && ~RESETNeg && ~RST && ~Ready_out) ||
                (R && RESETNeg && ~RST && ~Ready_out))
            begin
                //no state transition while RESET# low
                current_state = RESET; //reset e_start
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

    //////////////////////////////////////////////////////////////////////////
    //Glitch Protection: Inertial Delay does ~ propagate pulses <3ns
    //////////////////////////////////////////////////////////////////////////
    assign #5 gWE_n = WENeg_ipd;
    assign #5 gCE_n = CENeg_ipd;
    assign #5 gOE_n = OENeg_ipd;

    // process that detect read or write cycle on bus
    always @(gWE_n or  gCE_n or  gOE_n or RESETNeg or reseted)
    begin: write_dc
            if (RESETNeg && reseted)
            begin
                if (~gWE_n && ~gCE_n && gOE_n)
                    write = 1'b1;
                else
                    write = 1'b0;
            end

            if (gWE_n && ~gCE_n && ~gOE_n && (RESETNeg || RST))
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
        if (gWE_n == WENeg)
            $display("Glitch on WE#");
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
    // Latch address process
    ///////////////////////////////////////////////////////////////////////////
    reg addr_l  = 1'b0;
    reg[HAddr:0] AL_tmp;
    always @(posedge WENeg_ipd, posedge CENeg_ipd)
    begin : AddressDecode0
        if (reseted)
        begin
        if (write)
            begin
                DataLo = DIn[7:0];
                Data   = DIn[31:0];
            end
        end
    end

    always @(A, CENeg, OENeg, WENeg)
    begin : AddressDecode1
        if (~CENeg && (WENeg != OENeg))
            AL_tmp = A;
        if (~CENeg && ~WENeg && OENeg)
            SetAddress;
        if (~CENeg && WENeg && ~OENeg && ASyncMod)
            SetAddress;
    end

    always@(ADVNeg)
    begin : AddressDecode2
        if (~CENeg && ADVNeg && reseted && ~ASyncMod && ~addr_l)
        begin
            AL_tmp = A;
            SetAddress;
            LAddr_event = $time;
        end
    end

    always@(posedge CLK)
    begin : AddressDecode3
        if (~CENeg && ~ADVNeg && reseted && ~ASyncMod && ~addr_l)
        begin
            AL_tmp = A;
            SetAddress;
            LAddr_event = $time;
        end
        addr_l = 1'b1;
    end

    always@(posedge gCE_n, negedge gWE_n, negedge ADVNeg)
    begin : AddressDecode4
        addr_l = 1'b0;
    end

    always @(posedge write)
    begin
        SetAddress;
    end

    task SetAddress;
    begin
        AddrFsm     = AL_tmp[10:0];
        AddrPpb     = AL_tmp[5:0];
        Address     = AL_tmp[LAddrS-1:0];
        SSA         = AL_tmp[LAddrS-1:LAddrS-3];
        SA          = AL_tmp[HAddr:LAddrS];
        ALatch      = AL_tmp;
        if ((AL_tmp[HAddr : HAddr-1] != 2'b11 && top_model == 1'b0) ||
        (AL_tmp[HAddr : HAddr-1] == 2'b00  && top_model == 1'b1))
            BA = 1'b0;
        else
            BA = 1'b1;
    end
    endtask

    /////////////////////////////////////////////////////////////////////////
    //Timing control for the Program Operations
    //////////////////////////////////////////////////////////////////////////
    time p_elapsed;
    time p_duration;
    time p_start;

    always @(negedge reseted)
    begin
        PDone = 1'b1;
        disable Program1;
        disable Program3;
    end

    always @(PStart)
    begin : Program1
        if (PStart && reseted && PDone)
        begin
            if (~PErr)
            begin
                p_elapsed      = 0 ;
                p_start        = $time;
                p_duration     = tdevice_POW - glitch_t;
                PDone          =  1'b0;
                PDone          = # p_duration 1'b1;
            end
            else
            begin
                PDone     =  1'b0;
                PDone     = #1000 1'b1;
                $display("Cannot write in suspend/protect sector");
            end
        end
    end

    always @(PSusp)
    begin: Program2
        if (reseted && PSusp && ~PDone)
        begin
            disable Program1;
            disable Program3;
            p_elapsed = $time - p_start;
            p_duration = p_duration - p_elapsed;
            PDone = 1'b0;
        end
    end

    always @(PRes)
    begin: Program3
        if (reseted && PRes && ~PDone)
        begin
            p_start       = $time;
            PDone       = 1'b0;
            PDone       = #p_duration 1'b1;
        end
    end
    ///////////////////////////////////////////////////////////////////////////
    //// Timing control for the Erase Operations
    ///////////////////////////////////////////////////////////////////////////
    time e_elapsed;
    time e_duration;
    time e_start;

    always @(negedge reseted)
    begin
        disable Erase1;
        disable Erase3;
        EDone = 1'b1;
    end

    always @(EStart)
    begin: Erase1
        if (reseted && EStart && EDone)
        begin
            if (~EErr)
            begin
                e_elapsed      = 0 ;
                e_start        = $time;
                e_duration     = ers_cnt * tdevice_SEO;
                EDone        = 1'b0;
                EDone        = #e_duration 1'b1;

            end
            else
            begin
                EDone       <= 1'b0;
                EDone       <= #100000 1'b1;
                $display ("Erase in protected sector aborted");
            end
        end
    end

    always @(ESusp)
    begin: Erase2
        if (reseted && ESusp && ~EDone)
        begin
            disable Erase1;
            disable Erase3;
            e_elapsed = $time - e_start;
            e_duration = e_duration - e_elapsed;
            EDone = 1'b0;
        end
    end

    always @(ERes)
    begin: Erase3
        if (reseted && ERes && ~EDone)
        begin
            e_start       = $time;
            EDone       = 1'b0;
            EDone       = #e_duration 1'b1;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //// Main Behavior Process
    //// combinational process for next state generation
    ///////////////////////////////////////////////////////////////////////////
    always @(write or reseted)
    begin: StateGen1
        reg PATTERN_1  ;
        reg PATTERN_2  ;
        reg A_PAT  ;
        PATTERN_1 = (AddrFsm==16'h555) && (DataLo==8'hAA) ;
        PATTERN_2 = (AddrFsm==16'h2AA) && (DataLo==8'h55) ;
        A_PAT   = (AddrFsm==16'h555);
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            case (current_state)
            OTP_LOCK_VERIFY, PERSISTANT_MODE_VERIFY, PASSWORD_MODE_VERIFY ,
            PASSWORD_VERIFY, DYB_STATUS, DYB, OTP_LOCK_PROGRAM, STATUS_BPROTECT,
            PERSISTANT_MODE_PROGRAM , PASSWORD_MODE_PROGRAM, PPB_PROGRAM,
            PPB_PROGRAM_VERIFY, PPB_ERASE, PPB_ERASE_VERIFY, PPB_LOCK :
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = idle_state;
            end
            endcase

            case (current_state)
            RESET :
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = Z001;
                    else if ((AddrFsm == 8'h55) && (Data == 32'h00000098))
                         next_state = CFI;
                    else
                        next_state = RESET;
                end
            end

            Z001  :
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = PREL_SETBWB;
                    else
                        next_state = idle_state;
                end
            end

            PREL_SETBWB    :
            begin
                if (~write)
                begin
                    if (A_PAT && (DataLo == 8'hA0))
                        next_state = A0SEEN;
                    else if (A_PAT && (DataLo == 8'h20))
                    begin
                        if (idle_state == RESET)
                            next_state = PREL_ULBYPASS;
                        else
                            next_state = idle_state;
                    end
                    else if (A_PAT && (DataLo == 8'h90))
                        next_state = AS;
                    else if (A_PAT && (DataLo == 8'h38))
                        next_state = PASSWORD_SET;
                    else if (A_PAT && (DataLo == 8'hC8))
                        next_state = PASSWORD_VERIFY;
                    else if (A_PAT && (DataLo == 8'h28))
                        next_state = PASSWORD_UNLOCK_SET;
                    else if (A_PAT && (DataLo == 8'h88))
                        next_state = OTP;
                    else if (A_PAT && (DataLo == 8'h48))
                        next_state = DYB;
                    else if (A_PAT && (DataLo == 8'h60))
                        next_state = STATUS_BPROTECT;
                    else if (A_PAT && (DataLo == 8'h58))
                        next_state = DYB_STATUS;
                    else if (A_PAT && (DataLo == 8'h78))
                        next_state = PPB_LOCK;
                    else if (A_PAT && (DataLo == 8'hD0))
                        next_state = COMMAND_REG_WRITE;
                    else if (A_PAT && (DataLo == 8'hC6))
                        next_state = COMMAND_REG_READ;
                    else if (A_PAT && (DataLo == 8'h80))
                        next_state = C8;
                    else
                        next_state = idle_state;
                end
            end

            COMMAND_REG_WRITE   :
            begin
                if (~write)
                    next_state = idle_state;
            end

            COMMAND_REG_READ   :
            begin
                if (~write && DataLo==8'hF0)
                    next_state = idle_state;
            end

            PREL_ULBYPASS    :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h90)
                        next_state = UNLOCK_RESET;
                    else if (DataLo == 8'hA0)
                        next_state = A0SEEN;
                    else if (DataLo == 8'h80)
                        next_state = C8_PREL;
                    else if (Data == 32'h00000098)
                        next_state = CFI;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            UNLOCK_RESET   :
            begin
                if (~write)
                    if (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
            end

            OTP      :
            begin
                if (~write)
                    if (PATTERN_1)
                        next_state = Z001;
                    else
                        next_state = OTP;
            end

            PASSWORD_PROGRAM      :
            begin
                if (~write && PPrDone == 1 && DataLo==8'hF0)
                    next_state = RESET;
            end

            STATUS_BPROTECT   :
            begin
                if (~write)
                begin
                    if (DataLo==8'h68 && AddrPpb==WP )
                        next_state = PPB_PROGRAM;
                    else if (DataLo==8'h60 && AddrPpb==WP)
                        next_state = PPB_ERASE;
                    else if (DataLo==8'h68 && (AddrPpb==SL0 || AddrPpb==SL1))
                        next_state = PERSISTANT_MODE_PROGRAM;
                    else if (DataLo==8'h68 && (AddrPpb==PL0 || AddrPpb==PL1))
                        next_state = PASSWORD_MODE_PROGRAM;
                    else if (DataLo==8'h68 && (AddrPpb==OW0 || AddrPpb==OW1))
                        next_state = OTP_LOCK_PROGRAM;
                end
            end

            OTP_LOCK_PROGRAM   :
            begin
                if (BProt_done == 1 &&  ~write &&  DataLo==8'h48 &&
                (AddrPpb==OW0 || AddrPpb==OW1))
                    next_state = OTP_LOCK_VERIFY;
            end

            PERSISTANT_MODE_PROGRAM   :
            begin
                if (BProt_done  &&  ~write &&  DataLo==8'h48 &&
                (AddrPpb==SL0 || AddrPpb==SL1))
                    next_state = PERSISTANT_MODE_VERIFY;
            end

            PASSWORD_MODE_PROGRAM   :
            begin
                if (BProt_done  &&  ~write &&  DataLo==8'h48 &&
                (AddrPpb==PL0 || AddrPpb==PL1))
                    next_state = PASSWORD_MODE_VERIFY;
            end

            PPB_PROGRAM   :
            begin
                if (BProt_done &&  ~write && DataLo == 8'h48 &&
                AddrPpb == WP)
                    next_state = PPB_PROGRAM_VERIFY;
            end

            PPB_ERASE   :
            begin
                if (BProt_done == 1'b1 && ~write && DataLo == 8'h40 &&
                AddrPpb == WP)
                    next_state = PPB_ERASE_VERIFY;
            end

            AS    :
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = idle_state;
                    else if (DataLo == 8'h00 && Otp_act )
                        next_state = RESET;
                    else if (AddrFsm == 8'h55 && Data == 32'h00000098 &&
                    ~ Otp_act)
                        next_state = AS_CFI;
            end

            AS_CFI   :
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                        next_state = AS;
            end

            CFI   :
            begin
                if (~write)
                    if (DataLo == 8'hF0)
                    begin
                        if (Ulbypass == 1'b0)
                            next_state = RESET;
                        else
                            next_state = PREL_ULBYPASS;
                    end
                    else
                        next_state =  CFI;
            end

            A0SEEN    :
            begin
                if (~write)
                    next_state = PGMS;
            end

            C8    :
            begin
                if (~write)
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else
                        next_state = idle_state;
            end

            C8_Z001   :
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = C8_PREL;
                    else
                        next_state = idle_state;
                end
            end

            C8_PREL   :
            begin
                if (~write)
                begin
                    if (A_PAT && DataLo == 8'h10)
                        next_state = ERS;
                    else if (DataLo == 8'h30 && ~Ulbypass)
                    begin
                        next_state = SERS;
                    end
                    else
                    begin
                        if (Ulbypass == 1'b0)
                            next_state = idle_state;
                        else
                            next_state = PREL_ULBYPASS;
                    end
                end
            end

            SERS  :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hB0)
                    begin
                        if (BErase[BA] && ~EErr && ~Otp_act)
                            next_state = SUSP;
                    end
                    else if (DataLo == 8'h30)
                        next_state = SERS;
                    else
                        next_state = idle_state;
                end
            end

            SERS_EXEC :
            begin
                if (~write && ~EErr && ~Otp_act && DataLo == 8'hB0 &&
                BErase[BA])
                    next_state = SPS;
            end

            SUSP   :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h30)
                    begin
                        if (~Pgms_act && BErase[BA])
                            next_state = SERS_EXEC;
                        else if (BBusy[BA])
                            next_state = PGMS;
                    end
                    else
                    begin
                        if (AddrFsm == 8'h55 && Data == 32'h00000098)
                            next_state = SUSP_CFI;
                        else if (PATTERN_1)
                            next_state = SUSP_Z001;
                    end
                end
            end

            SUSP_Z001  :
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = SUSP_SETBWB;
                    else
                        next_state = idle_state;
                end
            end

            SUSP_SETBWB  :
            begin
                if (~write)
                begin
                    if (A_PAT && (DataLo==8'h90))
                        next_state = SUSP_AS;
                    else if (A_PAT && (DataLo == 8'h20))
                    begin
                        if (idle_state == SUSP)
                            next_state = SUSP_ULBYPASS;
                        else
                            next_state = idle_state;
                    end
                    else if (A_PAT && DataLo == 8'hA0)
                        next_state = SUSP_A0SEEN;
                    else if (A_PAT && DataLo==8'h88)
                        next_state = SUSP_OTP;
                    else
                        next_state = idle_state;
                end
            end

            SUSP_ULBYPASS   :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h30)
                    begin
                        if (Pgms_act == 0 && BErase[BA])
                            next_state = SERS_EXEC;
                        else if (BBusy[BA])
                            next_state = PGMS;
                    end
                    else if (AddrFsm == 8'h55 && Data == 32'h00000098)
                        next_state = SUSP_CFI;
                    else if (DataLo == 8'hA0)
                        next_state = SUSP_A0SEEN;
                    else if (DataLo == 8'h90)
                        next_state = SUSP_ULBYPASS_RESET;
                end
            end

            SUSP_ULBYPASS_RESET  :
            begin
                if (~write)
                    if (DataLo == 8'h00)
                        next_state = SUSP;
                    else
                        next_state = SUSP_ULBYPASS;
            end

            SUSP_OTP      :
            begin
                if (~write)
                    if (PATTERN_1)
                        next_state = SUSP_Z001;
                    else
                        next_state = SUSP_OTP;
            end

            SUSP_AS :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hF0)
                        next_state = idle_state;
                    else if (DataLo == 8'h00 && Otp_act )
                        next_state = SUSP;
                    else if (AddrFsm == 8'h55 && Data == 32'h00000098
                    && ~ Otp_act)
                        next_state = SUSP_AS_CFI;
                end
            end

            SUSP_CFI   :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hF0)
                    begin
                        if (Ulbypass == 1'b0)
                            next_state = SUSP;
                        else
                            next_state = SUSP_ULBYPASS;
                    end
                end
            end

            SUSP_AS_CFI   :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hF0)
                        next_state = SUSP_AS;
                    else
                        next_state = SUSP_AS_CFI;
                end
            end

            SUSP_A0SEEN:
            begin
                if (~write)
                    if (~Pgms_act)
                        next_state = PGMS;
                    else
                    begin
                        if (~Ulbypass)
                            next_state = idle_state;
                        else
                            next_state = SUSP_ULBYPASS;
                    end
            end

            PGMS      :
            begin
                if (~write)
                    if (DataLo==8'hB0 && ~ Otp_act && BBusy[BA])
                    begin
                        next_state = SPS;
                    end
            end
        endcase
        end
    end

    always @(negedge PPrDone or reseted)
    begin: StateGen3
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==PASSWORD_SET))
            begin
                next_state =PASSWORD_PROGRAM ;
            end
        end
    end

    always @(posedge PUDone or reseted)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==PASSWORD_UNLOCK))
            begin
                next_state = idle_state;
            end
        end
    end

    always @(negedge PUDone or reseted)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==PASSWORD_UNLOCK_SET))
            begin
                next_state = PASSWORD_UNLOCK;
            end
        end
    end

    always @(posedge PDone)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                if (Otp_act)
                    next_state = OTP;
                else if (Ers_act)
                begin
                    if (~Ulbypass)
                        next_state = idle_state;
                    else
                        next_state = SUSP_ULBYPASS;
                end
                else if (Ulbypass)
                    next_state = PREL_ULBYPASS;
                else
                    next_state = idle_state;
            end
        end
    end

    always @(posedge EDone or reseted)
    begin: StateGen8
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC))
            begin
                if (Otp_act)
                    next_state = OTP;
                else
                begin
                    if (~Ulbypass)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end
        end
    end

    always @(Ctmout_out or reseted)
    begin: StateGen9
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS && Ctmout_out)
                next_state = SERS_EXEC;
        end
    end

    always @(TStart_out or reseted)
    begin: StateGen10
        if (reseted!=1'b1)
            next_state = current_state;
        else
        if (current_state==SPS && TStart_out)
            if (~Ulbypass)
                next_state = SUSP;
            else
                next_state = SUSP_ULBYPASS;
    end

    always@(reseted, WPNeg, SPpb_prot, STPpb_prot, SBPpb_prot,
    SDyb_prot, STDyb_prot, SBDyb_prot, Otp_act)
    begin : WP_PROC
        if (reseted)
        begin
            S_prot   = SPpb_prot  | SDyb_prot;
            ST_prot  = STPpb_prot | STDyb_prot;
            SB_prot  = SBPpb_prot | SBDyb_prot;
            if (Otp_act)
                if  (~top_model)
                    ST_prot[7] = 1;
                else
                    SB_prot[0] = 1;
            //Hardware Write Protection
            if (WPNeg == 1'b0)
                if (top_model == 1'b0)
                    SB_prot[1 : 0]            = ~(0);
                else if (top_model == 1'b1)
                    ST_prot[SSecN-1 : SSecN-2]= ~(0);
        end
    end
    ////////////////////////////////////////////////////////////////////////////
    // Burst Block                                                            //
    ////////////////////////////////////////////////////////////////////////////
    always@ (posedge CLK)
    begin : BurstControl
        if ((~CENeg && ~ADVNeg) && gWE_n  && ~ beginB && ~ASyncMod)
        begin
            StartB = 1'b1;
            StartB = #1 1'b0;
            beginB = 1'b1;
        end
    end

    always@ (posedge ADVNeg)
    begin : BurstControl2
        if (~CENeg && gWE_n  && ~ beginB && ~ASyncMod)
        begin
            StartB = 1'b1;
            StartB = #1 1'b0;
        end
    end

    always@ (posedge CENeg, posedge gCE_n, negedge gWE_n)
    begin : BurstControl3
        if ((CENeg && gCE_n ) || gCE_n || ~gWE_n)
        begin
            EndB = 1'b1;
            EndB = #1 1'b0;
        end
    end

    always@ (negedge ADVNeg)
    begin : BurstControl4
        beginB  = 1'b0;
    end

    always@ (StartB ,EndB, reseted)
    begin : ReadState
        if (StartB)
            BurstState = BURST_READ;
        if (EndB || ~reseted)
            BurstState = IDLE_READ;
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////
    integer WaitCycle ;
    integer WrapMode  ;
    integer BrAddrSt  ;
    reg[1:0]BurstMode ;
    reg oe_ev;

    always@ (posedge StartB)
    begin : BurstInit
        WaitCycle = BurstWait+1;
        BrAddrSt  = Address;
        if (ADVNeg== 1)
            WaitCycle = WaitCycle +1;
        case (BurstRead_Mode)
             3'b001 :    // wrap 2
              begin
                WrapCnt     = 2 -  ALatch[0];
                WrapMode    = 2;
             end
             3'b010 :    // wrap 4
             begin
                WrapCnt     = 4 -  ALatch[1 : 0];
                WrapMode    = 4;
             end
             3'b011 :    // wrap 8
             begin
                WrapCnt     = 8 -  ALatch[2 : 0];
                WrapMode    = 8;
             end
        endcase
        if (IND_act)
            if (BrAddrSt % WrapMode == 0)
                BrAddrSt = Address + WrapMode -1;
            else
                BrAddrSt = Address - 1;
        IND_zd = 1;
    end

    always@ (posedge CLK)
    begin : BurstCycle
       if (BurstState == BURST_READ)
       begin
           if (WaitCycle == 0)
           begin
               if (ADVNeg)
               begin
                   WrapCnt = WrapCnt - 1;
                   if (WrapCnt > 0)   //wrap mode
                       Address = Address +1;
                   else  // wrap turnround
                   begin
                       Address = Address - WrapMode +1;
                       WrapCnt = WrapMode;
                   end
               end
           end
           else
               WaitCycle=WaitCycle-1;
           oe_ev <=    1'b1;
           oe_ev <= #1 1'b0;
        end
    end

    reg[31:0] WRData      = 0;
    reg[31:0] LSData      = 0;
    integer WRSA          = 0;
    integer WRSSA         = 0;
    integer WRA           = 0;
    integer ErsMem        = 0;
    integer data_mem      = 0;
    integer PassA         = 0;
    integer DataDyb       = 0;
    reg[SecN-3:0] all_ones = ~(0);
    reg rd_nosusp         = 0;
    reg oe                = 0;
    reg DybProt           = 0;
    reg WR_secsi          = 0;
    reg WR_secsi_range    = 0;

    reg[31:0] Status      = 0;
    reg[31:0] PassD       = 0;

    time erase_start;
    event BErase_act;
    always @(BErase_act)
    begin
        #100000 BErase = BErase_t;
    end

    task DriveOut;
    begin
        SecSi_AddrValid;
        if (Otp_act  && secsi_addressed == 1'b1)
        begin
            if (secsi_range == 1'b1)
            begin
                if (SecSiLow[RAddr] == -1)
                    DOut_zd = 32'bx;
                else
                    DOut_zd[31:16] = SecSiHigh[RAddr];
                    DOut_zd[15:0]  = SecSiLow[RAddr];
            end
            else
            begin
                DOut_zd = 32'bx;
                $display ("invalid SecSi address");
            end
        end
        else
        begin
            if (MemLow[SA*SecS + RAddr] == -1)
                DOut_zd = 32'bx;
            else
            begin
                DOut_zd[31:16] = MemHigh[SA*SecS + RAddr];
                DOut_zd[15:0]  = MemLow[SA*SecS + RAddr];
            end
        end
        if (~ASyncMod)
        begin
            if ((BrAddrSt % WrapMode == 0) &&
            (Address % WrapMode == WrapMode-1) && WaitCycle == 0)
                IND_zd = 0;
            else if ((Address == BrAddrSt - 1) && WaitCycle == 0)
                IND_zd = 0;
            else
                IND_zd = 1;
        end
        else
            IND_zd   = 1'b1;
    end
    endtask

    task SecSi_AddrValid;
    begin
        if (((SA==TopSec && SSA == 7  && ~top_model ) ||
            (SA==BotSec && SSA == 0  && top_model))&& Otp_act)
        begin
            secsi_addressed =  1'b1;
            if ((SA==TopSec && ~top_model  &&  Address >= 16'h3FC0) ||
            (SA==BotSec && top_model && Address < 16'h0040))
                secsi_range = 1'b1;
            else
                secsi_range = 1'b0;

            if (SA==TopSec && ~top_model  && Address >= 16'h3FC0)
                RAddr = Address - 16'h3FC0;
            else
                RAddr = Address;
        end
        else
        begin
            secsi_addressed =1'b0;
            secsi_range     = 1'b0;
            RAddr = Address;
        end
    end
    endtask

    reg[31:0] AutoselData;
    integer   AutoselAddress;
    task Read_as;
    begin
        AutoselAddress  = Address % 16'h100;
        if (AutoselAddress == 0)
            AutoselData = 1;
        else if (AutoselAddress == 1)
            AutoselData = 32'h0000007E;
        else if (AutoselAddress == 2)
        begin
            if ((SA != TopSec && SA != BotSec && SPpb_prot[SA] == 1'b0) ||
            ( SA == TopSec && STPpb_prot[SSA] == 1'b0) ||
            ( SA == BotSec && SBPpb_prot[SSA] == 1'b0))
                AutoselData = 1;
            else
                AutoselData = 0;
        end
        else if (AutoselAddress == 14)
                AutoselData = 32'h00000009;
        else if (AutoselAddress == 15)
        begin
            if  (~top_model)
                AutoselData = 1;
            else
                AutoselData = 0;
        end
        else
            AutoselData = 32'bx;
        IND_zd  = 1;
        EndB    = 1'b1;
        EndB   <=  #1 1'b0;
        DOut_zd = AutoselData;
    end
    endtask

    task RdSusp_mem;
    begin
        rd_nosusp =  1'b1;
        if ((SA != BotSec && SA != TopSec && E_queue[SA] && ~S_prot[SA]) ||
        (SA == BotSec && EB_queue[SSA] && ~SB_prot[SSA]) ||
        (SA == TopSec && ET_queue[SSA] && ~ST_prot[SSA]))
        begin
            rd_nosusp = 1'b0;
        end
        if (rd_nosusp)
        begin
            DriveOut;
        end
        else
        begin
            Status[7] = 1'b1;
            //Status[6] No toggle
            Status[5] = 1'b0;
            Status[2] = ~ Status[2]; //toggle
            IND_zd  = 1;
            EndB    = 1'b1;
            EndB   <=  #1 1'b0;
            DOut_zd = Status;
        end
        if (Pgms_act && SA==WRSA && ((SA !=TopSec && SA != BotSec)
        || (SA==TopSec && SSA==WRSSA) || (SA==BotSec && SSA==WRSSA))
        && ~(Otp_act && secsi_range) )
        begin
            DOut_zd <= 32'bx;
            IND_zd  = 1;
            EndB    = 1'b1;
            EndB   <=  #1 1'b0;
            $display("Read from program suspended sector is NOT allowed");
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
            if ((SA != BotSec && SA != TopSec && E_queue[SA] && ~S_prot[SA]) ||
            (SA == BotSec && EB_queue[SSA] && ~SB_prot[SSA]) ||
            (SA == TopSec && ET_queue[SSA] && ~ST_prot[SSA]))
            begin
                Status[2] = ~ Status[2];
            end
        end
        else
        begin
            if ((SA != BotSec && SA != TopSec && E_queue[SA]) ||
            (SA == BotSec && EB_queue[SSA]) ||
            (SA == TopSec && ET_queue[SSA]))
            begin
                Status[2] = ~ Status[2];
            end
        end
        IND_zd  = 1;
        EndB    = 1'b1;
        EndB   <=  #1 1'b0;
        DOut_zd = Status;
    end
    endtask

    integer sect_ers = 0;
    task EraseMem;
    begin
        for (i=0;i<=SecN-1;i=i+1)
            if (i!=BotSec && i!=TopSec)
            begin
                if  (~S_prot[i] && E_queue[i])
                begin
                    ers_cnt = ers_cnt + 1;
                    sect_ers = i*SecS;
                    for (j=0;j<=SecS-1;j=j+1)
                    begin
                        MemLow[sect_ers + j] = ErsMem;
                        MemHigh[sect_ers + j] = ErsMem;
                    end
                end
            end
            else if (i== BotSec)
            begin
                sect_ers = i*SecS;
                for (j=0;j<=SSecN-1;j=j+1)
                    if (~SB_prot[j] && EB_queue[j])
                    begin
                        ers_cnt = ers_cnt + 1;
                        for (k=sssa[j];k<=ssea[j];k=k+1)
                        begin
                            MemLow[sect_ers + k]= ErsMem;
                            MemHigh[sect_ers + k]= ErsMem;
                        end
                    end
            end
            else
            begin
                sect_ers = i*SecS;
                for (j=0;j<=SSecN-1;j=j+1)
                    if (~ST_prot[j] && ET_queue[j])
                    begin
                        ers_cnt  = ers_cnt + 1;
                        for (k=sssa[j];k<=ssea[j];k=k+1)
                        begin
                            MemLow[sect_ers + k]= ErsMem;
                            MemHigh[sect_ers + k]= ErsMem;
                        end
                    end
            end
    end
    endtask

    task SetErsQ;
    begin
        if (SA == TopSec)
        begin
            ET_queue[SSA] = 1'b1;
        end
        else if (SA == BotSec)
        begin
            EB_queue[SSA] = 1'b1;
        end
        else
        begin
            E_queue[SA]   = 1'b1;
        end
        BErase[BA]= 1'b1;
        if ((SA != TopSec && SA != BotSec) && ~S_prot[SA])
        begin
            BErase_t[BA] = 1'b1;
            EErr         = 1'b0;
        end
        else if (SA == TopSec && ~ST_prot[SSA])
        begin
            BErase_t[BA] = 1'b1;
            EErr         = 1'b0;
        end
        else if (SA == BotSec && ~SB_prot[SSA])
        begin
            BErase_t[BA] = 1'b1;
            EErr         = 1'b0;
        end
    end
    endtask

    task ReturnBank;
    begin
        if ((BA == 1 && top_model == 0) ||
        (BA  == 0 && top_model == 1))
            size_bank = small_bank;
        else
            size_bank = large_bank;
    end
    endtask

    task bit_status;
    begin
        if (BProt_done == 0)
            Status[6] = ~ Status[6];
        IND_zd  = 1;
        EndB    = 1'b1;
        EndB   <=  #1 1'b0;
        DOut_zd[7 : 0]  = Status;
        DOut_zd[31 : 8] = 0 ;
    end
    endtask

    always@ (posedge read, ALatch, posedge oe_ev)
    begin
        if(read)
        begin
            oe  = 1'b1;
            oe <= 1'b0;
        end
    end

    always @(oe)
    begin
        ReturnBank;
        if (R && (RESETNeg || RST) && oe)
        begin
            if (~BErase[BA] &&  ~BBusy[BA])
                DriveOut;
            else
                IND_zd = 1'bZ;
        end
        if (reseted)
        begin
            case (current_state)
                RESET :
                begin
                    if(oe)
                        DriveOut;
                end

                COMMAND_REG_READ   :
                begin
                    if (oe)
                        if (BBusy[BA])
                        begin
                            DOut_zd[15 : 0]  = CommandReg;
                            DOut_zd[31 : 16] = 0;
                            IND_zd  = 1;
                            EndB    =  1'b1;
                            EndB   <= #1 1'b0;
                        end
                        else
                            DriveOut;
                end

                OTP  :
                begin
                    if(oe)
                        DriveOut;
                end

                CFI, AS_CFI, SUSP_CFI, SUSP_AS_CFI:
                begin
                    if(oe)
                    begin
                        DOut_zd = 32'bx;
                        if ((ALatch>=16'h10) && (ALatch <= 16'h5B))
                        begin
                            if (CFI_array[ALatch] != -1)
                            begin
                                DOut_zd[7:0] = CFI_array[ALatch];
                                DOut_zd[31:8] = 0;
                            end
                        end
                        else
                        begin
                            $display ("Invalid CFI query address");
                        end
                        IND_zd  = 1;
                        EndB    =  1'b1;
                        EndB   <= #1 1'b0;
                    end
                end

                AS :
                begin
                    if(oe)
                        if (BAsel[BA])
                            Read_as;
                        else
                            DriveOut;
                end

                PREL_ULBYPASS  :
                begin
                end

                PASSWORD_UNLOCK :
                begin
                    if(oe)
                    begin
                        if (size_bank == small_bank)
                        begin
                            Status[7] = ~ PassD[7];
                            Status[6] = ~ Status[6]; //toggle
                            Status[5] = 1'b0;
                            Status[1] = 1'b0;
                            DOut_zd = Status;
                            IND_zd  = 1;
                            EndB    =  1'b1;
                            EndB   <= #1 1'b0;
                        end
                        else
                            DriveOut;
                    end
                end

                STATUS_BPROTECT   :
                begin
                    if(oe)
                    begin
                        DOut_zd = 32'bx;
                        if  (AddrPpb==SL0 || AddrPpb==SL1)
                        begin
                            DOut_zd[31:1] = 0;
                            DOut_zd[0] =  PerMLock;
                        end
                        if  (AddrPpb==PL0 || AddrPpb==PL1)
                        begin
                            DOut_zd[31:1] = 0;
                            DOut_zd[0] =  PasMLock;
                        end
                        if  (AddrPpb==OW0 || AddrPpb==OW1)
                        begin
                            DOut_zd[31:1] = 0;
                            DOut_zd[0] =  Otp_lock;
                        end
                        IND_zd = 1;
                        EndB    =  1'b1;
                        EndB   <= #1 1'b0;
                    end
                end

                PASSWORD_PROGRAM :
                begin
                    if (oe)
                    begin
                        if (PPrDone == 1'b0)
                        begin
                            Status[7] =  ~ PassD[7];
                            Status[6] =  ~ Status[6];
                        end
                        else
                            Status[7] =    PassD[7];
                        Status[5] =  1'b0;
                        Status[1] =  1'b0;
                        DOut_zd = Status;
                        IND_zd  = 1;
                        EndB    =  1'b1;
                        EndB   <= #1 1'b0;
                    end
                end

                PASSWORD_VERIFY   :
                begin
                    if (oe)
                    begin
                        if (PasMLock == 1'b1)
                            DOut_zd = ~(0);
                        else
                            DOut_zd = Password[Address[0]];
                        IND_zd  = 1;
                        EndB    =  1'b1;
                        EndB   <= #1 1'b0;
                    end
                end

                PASSWORD_MODE_PROGRAM, OTP_LOCK_PROGRAM,
                PERSISTANT_MODE_PROGRAM :
                begin
                    if (oe)
                        bit_status;
                end

                PPB_PROGRAM, PPB_ERASE :
                begin
                    if (oe)
                        if (size_bank == small_bank)
                            bit_status;
                        else
                            DriveOut;
                end

                PPB_PROGRAM_VERIFY :
                begin
                    if (oe)
                        if (AddrPpb == WP)
                        begin
                            IND_zd = 1;
                            if (((SaPPB !=  BotSec) && (SaPPB !=  TopSec) &&
                                (SPpb_prot[SaPPB] == 1'b0)) ||
                                ((SaPPB == BotSec) && (~SBPpb_prot[SSaPPB])) ||
                                ((SaPPB == TopSec) && (~STPpb_prot[SSaPPB])))
                                begin
                                    // Sector unlock
                                    DOut_zd[31:1] = 0;
                                    DOut_zd[0] = 1'b0;
                                end
                                else
                                begin
                                    // Sector lock
                                    DOut_zd[31:1] = 0;
                                    DOut_zd[0] = 1'b1;
                                end
                        end
                        else
                        begin
                            DOut_zd = 32'bx;
                            EndB    = 1'b1;
                            EndB   <=  #1 1'b0;
                            IND_zd = 1;
                        end
                end

                OTP_LOCK_VERIFY :
                begin
                    if (oe)
                        if (AddrPpb==OW0 || AddrPpb==OW1)
                        begin
                            IND_zd = 1'b1;
                            DOut_zd[31:1] = 0;
                            DOut_zd[0] =  Otp_lock;
                        end
                        else
                        begin
                            DOut_zd = 32'bx;
                            EndB    = 1'b1;
                            EndB   <=  #1 1'b0;
                            IND_zd = 1;
                        end
                end

                PERSISTANT_MODE_VERIFY :
                begin
                    if (oe)
                        if (AddrPpb==SL0 || AddrPpb==SL1)
                        begin
                            IND_zd = 1'b1;
                            DOut_zd[31:1] = 0;
                            DOut_zd[0] =  PerMLock;
                        end
                        else
                        begin
                            DOut_zd = 32'bx;
                            EndB    = 1'b1;
                            EndB   <=  #1 1'b0;
                            IND_zd = 1;
                        end
                end

                PASSWORD_MODE_VERIFY :
                begin
                    if (oe)
                        if (AddrPpb==PL0 || AddrPpb==PL1)
                        begin
                            DOut_zd[31:1] = 0;
                            IND_zd      = 1'b1;
                            DOut_zd[0] = PasMLock;
                        end
                        else
                        begin
                            DOut_zd = 32'bx;
                            EndB    = 1'b1;
                            EndB   <=  #1 1'b0;
                            IND_zd = 1;
                        end
                end

                PPB_ERASE_VERIFY :
                begin
                    if (oe)
                        if (AddrPpb == WP)
                        begin
                            DOut_zd[31:1] = 0;
                            IND_zd = 1;
                            if (STPpb_prot == 0 && SBPpb_prot == 0
                            && SPpb_prot == 0)
                                DOut_zd[0] = 1'b0;
                            else
                            // Sector lock
                                DOut_zd[0] = 1'b1;
                        end
                        else
                        begin
                            IND_zd = 1;
                            DOut_zd = 32'bx;
                            EndB    = 1'b1;
                            EndB   <=  #1 1'b0;
                        end
                end

                DYB_STATUS   :
                begin
                    if(oe)
                    begin
                        if (((SA !=  BotSec) &&  (SA !=  TopSec) &&
                        (SDyb_prot[SA] == 1'b0)) ||
                        ((SA == BotSec) && (SBDyb_prot[SSA]== 1'b0)) ||
                        ((SA == TopSec) && (STDyb_prot[SSA]== 1'b0)))
                        begin
                            // Sector unlock
                            DOut_zd[31:2] = 0;
                            DOut_zd[0] = 1'b0;
                            DOut_zd[1] = Ppb_lock_b;
                        end
                        else
                        begin
                            // Sector lock
                            DOut_zd[31:2] = 0;
                            DOut_zd[0] = 1'b1;
                            DOut_zd[1] = Ppb_lock_b;
                        end
                        IND_zd  = 1;
                        EndB    = 1'b1;
                        EndB   <=  #1 1'b0;
                    end
                end

                ERS :
                begin
                    if(oe)
                        Read_EraseStatus;
                end

                SERS :
                begin
                    if(oe)
                        if (BErase[BA])
                        begin
                            Status[3] = 1'b0;
                            DOut_zd   = Status;
                            IND_zd = 1;
                            EndB    =  1'b1;
                            EndB   <= #1 1'b0;
                        end
                        else
                            if (size_bank == large_bank)
                                DriveOut;
                            else
                            begin
                                DOut_zd = 32'bx;
                                IND_zd  = 1;
                                EndB    = 1'b1;
                                EndB   <=  #1 1'b0;
                            end
                end

                SPS :
                begin
                    if(oe)
                        if (BBusy[BA] && Pgms_act)
                        begin
                            Status[6] = ~Status[6]; //toggle
                            Status[5] = 1'b0;
                            Status[1] = 1'b0;
                            DOut_zd = Status;
                            IND_zd  = 1;
                            EndB    =  1'b1;
                            EndB   <= #1 1'b0;
                        end
                        else if (BErase[BA] && Ers_act)
                        begin
                            Read_EraseStatus;
                        end
                        else
                            if (size_bank == large_bank)
                                DriveOut;
                            else
                            begin
                                DOut_zd = 32'bx;
                                IND_zd  = 1;
                                EndB    = 1'b1;
                                EndB   <=  #1 1'b0;
                            end
                end

                SERS_EXEC:
                begin
                    if(oe)
                        if (BErase[BA])
                        begin
                            Read_EraseStatus;
                        end
                        else
                            if (size_bank == large_bank)
                                DriveOut;
                            else
                            begin
                                DOut_zd = 32'bx;
                                IND_zd  = 1;
                                EndB    = 1'b1;
                                EndB   <=  #1 1'b0;
                            end
                end

                SUSP :
                begin
                    if(oe)
                        RdSusp_mem;
                end

                SUSP_ULBYPASS:
                begin
                    if(oe)
                        RdSusp_mem;
                end

                SUSP_OTP:
                begin
                    if(oe)
                        RdSusp_mem;
                end

                SUSP_AS :
                begin
                    if(oe)
                        if (BAsel[BA])
                            Read_as;
                        else
                            RdSusp_mem;
                end

                PGMS :
                begin
                    if(oe)
                        if (BBusy[BA]==1'b1)
                        begin
                            Status[6] = ~Status[6]; //toggle
                            Status[5] = 1'b0;
                            Status[1] = 1'b0;
                            DOut_zd = Status;
                            IND_zd  = 1;
                            EndB    =  1'b1;
                            EndB   <= #1 1'b0;
                        end
                        else  // read form non program Sector!!!!!!!!!!!!!!!!!!
                            if (size_bank == large_bank)
                                RdSusp_mem;
                            else
                            begin
                                DOut_zd = 32'bx;
                                IND_zd  = 1;
                                EndB    = 1'b1;
                                EndB   <=  #1 1'b0;
                            end
                end

                default :
                begin
                    IND_zd = 1'bZ;
                end
            endcase
        end
    end

    always @( write)
    begin : functional_generation
        reg A_PAT  ;
        A_PAT   = (AddrFsm==16'h555);
        if (reseted && ~write)
        case (current_state)
            RESET :
            begin

            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                if (A_PAT && (DataLo == 8'h90))   //autoselect mode
                    BAsel[BA] = 1;
                else if (A_PAT && (DataLo==8'h58  || DataLo==8'h90 ||
                DataLo == 8'hC6))
                    BBusy[BA] = 1;
            end

            PASSWORD_UNLOCK_SET   :
            begin
                PassA     =  (Address[0]);
                PassD     =  Data;
                Status[7] =  Data[7];
                PUDone    = 1'b0;
                PUDone <= # (tdevice_UNLOCK- glitch_t) 1'b1 ;
            end

            COMMAND_REG_WRITE   :
            begin
                CommandReg = Data[15 : 0];
            end

            PASSWORD_SET   :
            begin
                PPrDone = 1'b0;
                PPrDone <= # (tdevice_POW - glitch_t) 1'b1 ;
                PassA =  Address[0];
                PassD =  Data;
                Status[7] =  Data[7];
            end

            DYB :
            begin
                if (DataLo !=  8'hF0)
                begin
                    DataDyb = DataLo % 16;
                    if (DataDyb == 0)
                        DybProt = 0;
                    else if (DataDyb == 1)
                        DybProt = 1;
                    SecSi_AddrValid;
                    if (~secsi_addressed && (DataDyb == 0 || DataDyb == 1))
                    begin
                        if (SA != BotSec && SA != TopSec)
                            SDyb_prot[SA] = DybProt;
                        else if (SA == BotSec)
                            SBDyb_prot[SSA] = DybProt;
                        else
                            STDyb_prot[SSA] = DybProt;
                    end
                end
            end

            STATUS_BPROTECT   :
            begin
                if (DataLo == 8'h68 && AddrPpb == WP)
                begin
                    BProt_done = 1'b0;
                    BProt_done <= # (tdevice_PPBW- glitch_t) 1'b1;
                    SaPPB =  SA;
                    SSaPPB =  SSA;
                end
                else if (DataLo == 8'h60 && AddrPpb == WP)
                begin
                    BProt_done = 1'b0;
                    BProt_done <= # (tdevice_PPBE- glitch_t) 1'b1;
                end
                else if (DataLo == 8'h68 && (AddrPpb==SL0 || AddrPpb==SL1))
                begin
                    BProt_done = 1'b0;
                    BProt_done <= # (tdevice_PPBW- glitch_t) 1'b1;
                end
                else if (DataLo == 8'h68 && (AddrPpb==PL0 || AddrPpb==PL1))
                begin
                    BProt_done = 1'b0;
                    BProt_done <= # (tdevice_PPBW- glitch_t) 1'b1;
                end
                else if (DataLo == 8'h68 &&  (AddrPpb==OW0 || AddrPpb==OW1))
                begin
                    BProt_done = 1'b0;
                    BProt_done <= # (tdevice_PPBW- glitch_t) 1'b1;
                end
            end

            AS :
            begin
                if (DataLo == 8'hF0)
                    BAsel = 0;
                else if (DataLo == 8'h00 && Otp_act )
                    BAsel = 0;
            end

            UNLOCK_RESET  , SUSP_ULBYPASS_RESET  :
            begin
                if (DataLo == 8'h00)
                begin
                    Ulbypass = 1'b0;
                end
            end

            A0SEEN , SUSP_A0SEEN :
            begin
                if (Pgms_act == 0)
                begin
                    SecSi_AddrValid;
                    WRData    = Data;
                    WRSA      = SA;
                    WRSSA     = SSA;
                    WRA       = RAddr;
                    WR_secsi  = secsi_addressed;
                    WR_secsi_range = secsi_range;
                    if (Otp_act  && secsi_addressed == 1'b1)
                        if (secsi_range == 1'b1 && Otp_lock == 0)
                        begin
                            if (SecSiLow[WRA] != -1)
                            begin
                                LSData[31 : 16] = SecSiHigh[WRA];
                                LSData[15 : 0 ] = SecSiLow[WRA];
                            end
                            else
                                LSData = 32'bx;
                            SecSiLow[WRA]   = -1;
                            SecSiHigh[WRA]  = -1;
                            Status[7]  = ~ DataLo[7];
                            BBusy      = 0;
                            BBusy[BA]  = 1;
                            PErr       = 1'b0;
                            PStart     = 1'b1;
                            PStart     = #1 1'b0;
                        end
                        else
                        begin
                            Status[7] = ~DataLo[7];
                            BBusy      = 0;
                            BBusy[BA]  = 1;
                            PErr      = 1'b1;
                            PStart     = 1'b1;
                            PStart     = #1 1'b0;
                            $display ("programing in non-valid SecSi region");
                        end
                    else
                    begin
                        if ((SA!=TopSec && SA!=BotSec && E_queue[SA] == 0
                        && S_prot[SA] == 0) ||
                        (SA  == TopSec && ET_queue[SSA] == 0 &&
                         ST_prot[SSA] == 0) ||
                        (SA  == BotSec && EB_queue[SSA] == 0 &&
                         SB_prot[SSA] == 0))
                        begin
                            WRData    = Data;
                            WRSA      = SA;
                            WRSSA     = SSA;
                            WRA       = Address;
                            if (MemLow[WRSA*SecS + WRA] != -1)
                            begin
                                LSData[31 : 16] = MemHigh[WRSA*SecS + WRA];
                                LSData[15 : 0 ] = MemLow[WRSA*SecS + WRA];
                            end
                            else
                                LSData = 32'bx;
                            MemHigh[WRSA*SecS + WRA] = -1;
                            MemLow[WRSA*SecS + WRA]  = -1;
                            Status[7] = ~ DataLo[7];
                            BBusy     = 0;
                            BBusy[BA] = 1;
                            PErr      = 1'b0;
                            PStart    = 1'b1;
                            PStart    = #1 1'b0;
                        end
                        else
                        begin
                            Status[7] = ~ DataLo[7];
                            BBusy     = 0;
                            BBusy[BA] = 1;
                            PErr      = 1'b1;
                            PStart    = 1'b1;
                            PStart    = #1 1'b0;
                        end
                    end
                end
            end

            C8_PREL :
            begin
                if (DataLo == 8'h10)
                //e_start Chip Erase
                begin
                    ers_cnt  =   0;
                    if (S_prot[SecN-2:1] == all_ones && ST_prot == 8'hFF &&
                    SB_prot == 8'hFF)
                        EErr     =   1;
                    else
                        EErr     =   0;
                    E_queue  = ~(0);
                    ET_queue = ~(0);
                    EB_queue = ~(0);
                    BErase   = ~(0);
                    Ers_act  = 1'b1;
                    erase_start = $time;
                    ErsMem = -1;
                    EraseMem;
                    ESusp    = 1'b0;
                    ERes     = 1'b0;
                    EStart   = 1'b1;
                    EStart   = #1 1'b0;
                end
                else if (DataLo==8'h30 && ~Ulbypass)
                begin
                    //put selected Sector to sec. ERS. queue
                    //e_start timeout
                    EErr     = 1;
                    ers_cnt  = 0;
                    Status[7:0]   = "00001000";
                    SetErsQ;
                    Ctmout_in = 1'b1;
                    Ers_act = 1'b1;
                end
            end

            SERS :
            begin
                if (DataLo == 8'hB0)
                begin
                    if (~ EErr && BErase[BA]  && ~ Otp_act)
                    begin
                        -> BErase_act;
                        ErsMem = -1;
                        EraseMem;
                        Ctmout_in = 1'b0;
                        ERes      = 1'b0;
                        EStart    = 1'b1;
                        EStart    = #1 1'b0;
                        ESusp     = 1'b1;
                        ESusp     = #1 1'b0;
                        erase_start = $time;
                    end
                end
                else if (DataLo==16'h30)
                begin
                    SetErsQ;
                    Ctmout_in  = 1'b0;
                    Ctmout_in <= #2 1'b1;
                end
                else
                begin
                    Ctmout_in  = 1'b0;
                    E_queue  = 0;
                    ET_queue = 0;
                    EB_queue = 0;
                end
            end

            SERS_EXEC :
            begin
                if (DataLo==8'hB0 && BErase[BA] && EErr!=1'b1 && ~ Otp_act)
                begin
                    TStart_in = 1'b1;
                    ESusp     = 1'b1;
                    ESusp     = #1 1'b0;
                end
            end

            SUSP :
            begin
                if (DataLo == 8'h30 && BBusy[BA])
                begin
                    if (Ers_act == 0)
                        idle_state = RESET;
                    PRes = 1'b1;
                    PRes = #1 1'b0;
                end
                else if (DataLo == 8'h30 && BErase[BA])
                begin
                    ERes = 1'b1;
                    ERes = #1 1'b0;
                end
            end

            SUSP_SETBWB  :
            begin
                if (A_PAT && (DataLo == 8'h90))
                    BAsel[BA] = 1'b1;
            end

            SUSP_AS :
            begin
                if (DataLo == 8'hF0)
                    BAsel = 0;
                else if (DataLo == 8'h00 && Otp_act)
                    BAsel = 0;
            end

            SUSP_ULBYPASS:
            begin
                if (DataLo == 8'h30 && BBusy[BA])
                begin
                    PRes = 1'b1;
                    PRes = #1 1'b0;
                end
                else if (DataLo == 8'h30 && BErase[BA])
                begin
                    ERes = 1'b1;
                    ERes = #1 1'b0;
                end
            end

            PGMS :
            begin
                if (DataLo==8'hB0 && Otp_act!=1 && BBusy[BA]==1)
                begin
                    TStart_in = 1'b1;
                    PSusp     = 1'b1;
                    PSusp     = #1 1'b0;
                end
            end
        endcase
    end

    always @(posedge EDone)
    begin : ERS2
    if (current_state==ERS || current_state==SERS_EXEC)
    begin
        if (EErr !=1'b1)
        begin
            ErsMem = MaxData;
            EraseMem;
        end
    end
    end

    always @(Ctmout_out)
    begin : SERS2
        if (current_state==SERS && Ctmout_out)
        begin
            -> BErase_act;
            ErsMem = -1;
            EraseMem;
            erase_start = $time;
            Ctmout_in = 1'b0;
            ERes      = 1'b0;
            ESusp     = 1'b0;
            EStart    = 1'b1;
            EStart    = #1 1'b0;
        end
    end

    always @(TStart_out)
    begin : SUSPS2
        if (current_state==SPS && TStart_out)
            TStart_in = 1'b0;
    end

    always @(posedge PDone)
    begin: PGMS2
        if (current_state==PGMS)
        begin
            if (~PErr)
            begin
                if (LSData[0] !== 1'bx)
                    data_mem = LSData & WRData;
                else
                    data_mem = WRData;
                if (Otp_act  &&  WR_secsi_range)
                begin
                    SecSiHigh[WRA] = data_mem[31 : 16];
                    SecSiLow[WRA]  = data_mem[15 : 0 ];
                end
                else
                begin
                    MemHigh[WRSA*SecS + WRA]= data_mem[31 : 16];
                    MemLow[WRSA*SecS + WRA] = data_mem[15 : 0 ];
                end
            end
            BBusy = 0;
            Pgms_act = 0;
        end
    end

    always @(posedge BProt_done)
    begin : PSD
        case (current_state)
            PERSISTANT_MODE_PROGRAM :
            begin
                PerMLock =  ~PasMLock;
            end
            OTP_LOCK_PROGRAM:
            begin
                Otp_lock =  1'b1;
            end
            PASSWORD_MODE_PROGRAM:
            begin
                PasMLock =  ~PerMLock;
            end
            PPB_PROGRAM:
            begin
                if (Ppb_lock_b == 1'b0)
                begin
                    PpbBL = (SaPPB / 4)*4;
                    if  ((SaPPB - BotSec) > 0 &&(SaPPB - BotSec) < 4)
                        SPpb_prot[BotSec+3 : BotSec+1] = ~(0);
                    else if ((TopSec - SaPPB) > 0 && (TopSec - SaPPB) <4 )
                        SPpb_prot[TopSec-1 : TopSec-3] = ~(0);
                    else if ((SaPPB != BotSec) && (SaPPB != TopSec))
                    begin
                        SPpb_prot[PpbBL] = 1'b1;
                        SPpb_prot[PpbBL+1] = 1'b1;
                        SPpb_prot[PpbBL+2] = 1'b1;
                        SPpb_prot[PpbBL+3] = 1'b1;
                    end
                    else if (SaPPB == BotSec)
                        SBPpb_prot[SSaPPB] = 1;
                    else
                        STPpb_prot[SSaPPB] = 1;
                end
            end
            PPB_ERASE:
            begin
                if (Ppb_lock_b == 1'b0)
                begin
                    SPpb_prot = 0;
                    SBPpb_prot = 0;
                    STPpb_prot = 0;
                end
            end
        endcase
    end

    always @(posedge PPrDone)
    begin : PPU
        if (reseted && current_state==PASSWORD_PROGRAM)
            if (PasMLock == 1'b0)
                Password[PassA] = PassD & Password[PassA];
    end

    always @(PUDone)
    begin : PPD
        if ( PUDone && reseted && current_state==PASSWORD_UNLOCK)
        begin
            if (Password[PassA] == PassD && PasUnCycle == 0 && PassA == 0)
                PasUnCycle = 1;
            else if (Password[PassA] == PassD && PasUnCycle && PassA)
            begin
                PasUnCycle  = 0;
                if (PasMLock)
                    Ppb_lock_b  = 0;
            end
            else
                PasUnCycle = 0;
        end
    end

    always @(current_state or reseted or BProt_done or
    PUDone or PPrDone)
    begin
        if (reseted)
            if (current_state==RESET)
                RY_zd = 1'b1;
            if (current_state==ERS)
                RY_zd = 1'b0;
            if (current_state==SERS)
                RY_zd = 1'b1;
            if (current_state==SPS)
                RY_zd = 1'b0;
            if (current_state==SERS_EXEC)
                RY_zd = 1'b0;
            if (current_state==SUSP)
                RY_zd = 1'b1;
            if (current_state==OTP)
                RY_zd = 1'b1;
            if (current_state==PREL_ULBYPASS)
                RY_zd = 1'b1;
            if (current_state==SUSP_ULBYPASS)
                RY_zd = 1'b1;
            if (current_state==PGMS)
                RY_zd = 1'b0;
            if (current_state==OTP_LOCK_PROGRAM)
                RY_zd = BProt_done;
            if (current_state==PERSISTANT_MODE_PROGRAM)
                RY_zd = BProt_done;
            if (current_state==PASSWORD_MODE_PROGRAM)
                RY_zd = BProt_done;
            if (current_state==PPB_PROGRAM)
                RY_zd = BProt_done;
            if (current_state==PPB_ERASE)
                RY_zd = BProt_done;
            if (current_state==PASSWORD_PROGRAM)
                RY_zd = PPrDone;
            if (current_state==PASSWORD_UNLOCK)
                RY_zd = PUDone;
    end

    always @(current_state or reseted)
    begin
        if (reseted)
        begin
            if (current_state==RESET)
            begin
                Ulbypass  = 1'b0;
                BErase    = 0;
                BErase_t  = 0;
                BBusy     = 0;
                BBusy     = 0;
                E_queue   = 0;
                ET_queue  = 0;
                EB_queue  = 0;
                BProt_done = 1'b1;
                Ers_act   = 1'b0;
                Pgms_act  = 1'b0;
                Ctmout_in = 1'b0;
                Otp_act   = 1'b0;
                idle_state = RESET;
            end
            if (current_state==PREL_ULBYPASS)
            begin
                Ulbypass  = 1'b1;
                BErase    = 0;
                BErase_t  = 0;
                BBusy     = 0;
                BAsel     = 0;
                E_queue   = 0;
                ET_queue  = 0;
                EB_queue  = 0;
                Ers_act   = 1'b0;
                Pgms_act  = 1'b0;
                Ctmout_in = 1'b0;
                Otp_act   = 1'b0;
            end
            if (current_state==OTP)
            begin
                idle_state = OTP;
                Ulbypass   = 0;
                BAsel      = 0;
                BBusy      = 0;
                Otp_act    = 1;
            end
            if (current_state==SUSP_OTP)
            begin
                idle_state = SUSP_OTP;
                Ulbypass   = 0;
                BAsel      = 0;
                Otp_act    = 1;
            end
            if (current_state==SUSP)
            begin
                idle_state = SUSP;
                Otp_act   = 1'b0;
                Ulbypass  = 1'b0;
            end
            if (current_state==SUSP_ULBYPASS)
            begin
                Otp_act   = 1'b0;
                Ulbypass  = 1'b1;
            end
            if (current_state==PPB_LOCK)
            begin
                if (PasMLock != 1'b1)
                    Ppb_lock_b = 1'b1;
            end
            if (current_state==PGMS)
            begin
                Pgms_act = 1'b1;
            end
        end
        else
        begin
            idle_state = RESET;
            SBDyb_prot = 0;
            STDyb_prot = 0;
            SDyb_prot  = 0;
            PasUnCycle = 0;
            Otp_act    = 0;
            CommandReg = 16'h9CC3;
            Ppb_lock_b = PasMLock;
        end
    end

    always @(gOE_n or gCE_n or RESETNeg or RST, DOut_zd, IND_zd)
    begin
        //Output Disable Control
        if (gOE_n || gCE_n || (~RESETNeg && ~RST))
        begin
            DOut_zd  = 32'bZ;
            IND_zd   = 1'bz;
        end
    end

    initial
    begin
        ///////////////////////////////////////////////////////////////////////
        //CFI array data
        ///////////////////////////////////////////////////////////////////////
        for (i=16;i<92;i=i+1)
            CFI_array[i] = -1;

        CFI_array[8'h10] = 16'h0051;
        CFI_array[8'h11] = 16'h0052;
        CFI_array[8'h12] = 16'h0059;
        CFI_array[8'h13] = 16'h0002;
        CFI_array[8'h14] = 16'h0000;
        CFI_array[8'h15] = 16'h0040;
        CFI_array[8'h16] = 16'h0000;
        CFI_array[8'h17] = 16'h0000;
        CFI_array[8'h18] = 16'h0000;
        CFI_array[8'h19] = 16'h0000;
        CFI_array[8'h1A] = 16'h0000;
        //system interface string
        CFI_array[8'h1B] = 16'h0023;
        CFI_array[8'h1C] = 16'h0027;
        CFI_array[8'h1D] = 16'h0000;
        CFI_array[8'h1E] = 16'h0000;
        CFI_array[8'h1F] = 16'h0004;
        CFI_array[8'h20] = 16'h0000;
        CFI_array[8'h21] = 16'h0009;
        CFI_array[8'h22] = 16'h0000;
        CFI_array[8'h23] = 16'h0005;
        CFI_array[8'h24] = 16'h0000;
        CFI_array[8'h25] = 16'h0007;
        CFI_array[8'h26] = 16'h0000;
        //device geometry definition
        CFI_array[8'h27] = 16'h0015;
        CFI_array[8'h28] = 16'h0003;
        CFI_array[8'h29] = 16'h0000;
        CFI_array[8'h2A] = 16'h0000;
        CFI_array[8'h2B] = 16'h0000;
        CFI_array[8'h2C] = 16'h0003;
        CFI_array[8'h2D] = 16'h0007;
        CFI_array[8'h2E] = 16'h0000;
        CFI_array[8'h2F] = 16'h0020;
        CFI_array[8'h30] = 16'h0000;
        CFI_array[8'h31] = 16'h001D;
        CFI_array[8'h32] = 16'h0000;
        CFI_array[8'h33] = 16'h0000;
        CFI_array[8'h34] = 16'h0001;
        CFI_array[8'h35] = 16'h0007;
        CFI_array[8'h36] = 16'h0000;
        CFI_array[8'h37] = 16'h0020;
        CFI_array[8'h38] = 16'h0000;
        CFI_array[8'h39] = 16'h0000;
        CFI_array[8'h3A] = 16'h0000;
        CFI_array[8'h3B] = 16'h0000;
        CFI_array[8'h3C] = 16'h0000;
        //primary vendor-specific extended query
        CFI_array[8'h40] = 16'h0050;
        CFI_array[8'h41] = 16'h0052;
        CFI_array[8'h42] = 16'h0049;
        CFI_array[8'h43] = 16'h0031;
        CFI_array[8'h44] = 16'h0033;
        CFI_array[8'h45] = 16'h0004;
        CFI_array[8'h46] = 16'h0002;
        CFI_array[8'h47] = 16'h0001;
        CFI_array[8'h48] = 16'h0000;
        CFI_array[8'h49] = 16'h0006;
        CFI_array[8'h4A] = 16'h001F;
        CFI_array[8'h4B] = 16'h0001;
        CFI_array[8'h4C] = 16'h0000;
        CFI_array[8'h4D] = 16'h00B5;
        CFI_array[8'h4E] = 16'h00C5;
        CFI_array[8'h4F] = 16'h0001;
        CFI_array[8'h50] = 16'h0001;
        CFI_array[8'h51] = 16'h0000;
        CFI_array[8'h57] = 16'h0002;
        CFI_array[8'h58] = 16'h000F;
        CFI_array[8'h59] = 16'h001F;
        CFI_array[8'h5A] = 16'h0000;
        CFI_array[8'h5B] = 16'h0000;
    end

   ////////////////////////////////////////////////////////////////////////////
    // Data Output Dealy Block
    ////////////////////////////////////////////////////////////////////////////
    time OE_DQ,    CE_DQ,   A_DQ, CLK_DQ, HiZ_DQ, TIACC_DQ;
    time CE_DQ_t,  OE_DQ_t, A_DQ_t, Sync_DQ_t;
    time CE_ev,    OE_ev,   A_ev, CE_pev, OE_pev, OCE_pev, CLK_ev, OECLK_t;
    reg  BuffInCE,  BuffInOE,  BuffInA,  BuffInCLK, BuffInHIZ, BuffInTIACC;
    wire BuffOutCE, BuffOutOE, BuffOutA, BuffOutCLK, BuffOutHIZ, BuffOutTIACC;
    reg  OpenBuff = 1'b0;
    VITALBuf    BUFOE      (BuffOutOE, BuffInOE);
    VITALBuf    BUFCE      (BuffOutCE, BuffInCE);
    VITALBuf    BUFCLK     (BuffOutCLK, BuffInCLK);
    VITALBuf    BUFA       (BuffOutA, BuffInA);
    VITALBuf    BUFHIZ     (BuffOutHIZ, BuffInHIZ);
    VITALBuf    BUFTIACC   (BuffOutTIACC, BuffInTIACC);
    initial
    begin
        BuffInOE  = 1'b1;
        BuffInCE  = 1'b1;
        BuffInA   = 1'b1;
        BuffInCLK = 1'b1;
        BuffInHIZ = 1'b1;
        BuffInTIACC = 1'b1;
    end

    always @(posedge BuffOutTIACC)
    begin
        TIACC_DQ = $time;
    end
    always @(posedge BuffOutOE)
    begin
        OE_DQ = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CE_DQ = $time;
    end
    always @(posedge BuffOutA)
    begin
        A_DQ = $time;
    end
    always @(posedge BuffOutCLK)
    begin
        CLK_DQ = $time;
    end
    always @(posedge BuffOutHIZ)
    begin
        HiZ_DQ = $time;
    end

    always @(negedge OENeg)
    begin
        OE_ev = $time;
    end
    always @(negedge gCE_n)
    begin
        CE_ev = $time - 5;
    end
    always @(posedge CENeg)
    begin
        CE_pev = $time;
    end
    always @(posedge OENeg)
    begin
        OE_pev = $time;
    end
    always @(posedge CENeg, posedge OENeg)
    begin
        OCE_pev = $time;
    end
    always @(A)
    begin
        A_ev = $time;
    end
    always @(posedge CLK)
    begin
        CLK_ev = $time;
    end

    reg[31:0] DOut_t;
    reg       IND_t ;
    always @(DOut_zd, IND_zd)
    begin: OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            DOut_t = DOut_zd;
            IND_t  = IND_zd;
            CE_DQ_t  = CE_ev  + CE_DQ;
            OE_DQ_t  = OE_ev  + OE_DQ;
            A_DQ_t   = A_ev   + A_DQ;
            Sync_DQ_t = LAddr_event   + TIACC_DQ;
            tpd_addr   =((A_DQ_t >= CE_DQ_t) && (A_DQ_t >= OE_DQ_t) &&
            ( A_DQ_t >= $time) && ASyncMod);
            tpd_CE  = ((CE_DQ_t >= OE_DQ_t) && (CE_DQ_t >= $time));
            tpd_OE  = ((OE_DQ_t > CE_DQ_t) && (OE_DQ_t >= $time));
            OECLK_t =   OE_DQ_t - CLK_ev;
            if(tpd_CE && ~tpd_OE && ~tpd_addr)
            begin
                DOut_pass = 32'hz;
                #(CE_DQ_t - $time);
            end
            if( tpd_addr&& (tpd_OE || tpd_CE) && ASyncMod)
            begin
                tpd_addr    = 1'b0;
                IND_pass    = IND_t;
                DOut_pass   = 32'hx;
                #(A_DQ_t - $time);
            end
            if( Sync_DQ_t > $time && (tpd_OE || tpd_CE) && ~ASyncMod)
            begin
                tpd_addr    = 1'b0;
                IND_pass    = IND_t;
                if (OpenBuff == 1'b0)
                    DOut_pass   = 32'hx;
                #(Sync_DQ_t - $time);
            end
            if (~ASyncMod && OECLK_t>0 && OECLK_t<OE_DQ && OE_DQ_t>=$time)
            begin
                tpd_clk <= #1 1'b0;
                #(CLK_DQ);
            end
            if (~OENeg && ~CENeg && ~ASyncMod && (CLK_ev == $time))
                #CLK_DQ;
            tpd_clk   <= #1 1'b1;
            OpenBuff   = 1'b1;
            DOut_pass  = DOut_t;
            IND_pass   = IND_t;
        end
    end

    always @(DOut_zd)
    begin
        if (DOut_zd[0] === 1'bz)
        begin
            if(~ASyncMod && reseted)
                #(HiZ_DQ - glitch_t);
            disable OutputGen;
            tpd_clk  = 1'b0;
            tpd_addr = 1'b0;
            OpenBuff = 1'b0;
            tpd_CE = 1'b1;
            tpd_OE = 1'b1;
            if (OE_pev == OCE_pev &&  (CE_pev + 20) > OE_pev)
                tpd_OE = 1'b0;
            else if (CE_pev == OCE_pev &&  (OE_pev + 20) > CE_pev)
                tpd_CE = 1'b0;
            DOut_pass = DOut_zd;
            IND_pass = IND_zd;
        end
    end
endmodule

module VITALBuf ( OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule