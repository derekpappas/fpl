///////////////////////////////////////////////////////////////////////////////
//  File name : s29ws256n.v
///////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2005 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
// version:   |      author:    | mod date:  | changes made:
//   V1.0           A.Savic       04 Feb 19    Initial Version
//   V1.1           A.Savic       04 Mar 03    - A0h command removed
//   V1.2           A.Savic       04 Mar 05    - A0h command suported (V1.0)
//                                             - HW RESET cycle timing
//   V1.3           A.Savic       04 Jul 15    - Latest datasheet aligned
//   V1.4           A.Savic       05 Jan 10    - Address latch modified
//                                             - RESET active level sensitive
//                                             - PPB Lock commands BA specific
///////////////////////////////////////////////////////////////////////////////
// PART DESCRIPTION:
//
// Library:    FLASH
// Technology: FLASH MEMORY
// Part:       S29WS256N
//
// Description: 256 Megabit (16/8/4 M x 16-Bit)
//              Simultaneous Read/Write, Burst Mode Flash Memory
//////////////////////////////////////////////////////////////////////////////
//  Comments :
//      For correct simulation, simulator resolution should be set to 1ps
//      Refer to S29WS datasheet, burst operating frequency sections
//
//////////////////////////////////////////////////////////////////////////////
// Known Bugs:
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps

module s29ws256n
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

    CENegf1  ,
    OENeg    ,
    WENeg    ,
    CLK      ,
    AVDNeg   ,
    RESETNeg ,
    WPNeg    ,
    ACC      ,
    RDY
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

    input  CENegf1  ;
    input  OENeg    ;
    input  WENeg    ;
    input  CLK      ;
    input  AVDNeg   ;
    input  RESETNeg ;
    input  WPNeg    ;
    input  ACC      ;
    output RDY      ;

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
    assign A = {
                A23_ipd,
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
    assign DIn = {
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

    wire  CENegf1_ipd  ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  CLK_ipd      ;
    wire  AVDNeg_ipd   ;
    wire  RESETNeg_ipd ;
    wire  WPNeg_ipd    ;
    wire  ACC_ipd      ;

//  internal delays

    reg TIACC_in        ;
    reg TIACC_out       ;
    reg SEO16KW_in      ;
    reg SEO16KW_out     ;
    reg SEO64KW_in      ;
    reg SEO64KW_out     ;
    reg START_T1        ;
    reg START_T1_in     ;
    reg CTMOUT          ;
    reg CTMOUT_in       ;
    reg PBPROG_in       ;
    reg PBPROG_out      ;
    reg PBERASE_in      ;
    reg PBERASE_out     ;
    reg UNLOCKDONE_in   ;
    reg UNLOCKDONE_out  ;
    // ConfigurationRegister14 option
    reg NoRowBound_in   ;
    reg NoRowBound_out  ;

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

    reg RY_zd;
    reg RY_async = 1'b0;
    reg RY_sync = 1'b0;

    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name = "none";
    parameter UserPreload     = 1'b0;
    parameter LongTiming      = 1'b1;
    parameter TimingModel     = "S29WS256NOSBFW01";

    parameter PartID        = "S29WS256N";
    parameter MaxData       = 16'hFFFF;
    parameter SecSize       = 20'hFFFF;
    parameter SecNum        = 261;
    parameter SecNum_bank0  = 19;
    parameter SecSiSize     = 256;
    parameter HiAddrBit     = 23;
    parameter ADDRRange     = 24'hFFFFFF;

    //varaibles to resolve between Standard/Reduced devices
    reg [20*8:1] handle_string;//stores copy of TimingModel
    reg [7:0] fetch_char;//stores "t" or "b" character
    integer found = 1'b0;

    // powerup
    reg PoweredUp;

    //FSM control signals
    reg ULBYPASS ;//Unlock Bypass Active
    reg ESP_ACT  ;//Erase Suspend
    reg PSP_ACT  ;//Program Suspend
    reg LOCK_ACT ;//Lock Register program

    reg PDONE    ; //Prog. Done
    reg PSTART   ; //Start Programming
    reg PSUSP    ; //Suspend Programming
    reg PRES     ; //Resume Programming
    reg PERR     ; //Protected

    reg EDONE    ; //Ers. Done
    reg ESTART   ; //Start Erase
    reg ESUSP    ; //Suspend Erase
    reg ERES     ; //Resume Erase
    //All sectors selected for erasure are protected
    reg EERR     ;

    //Sectors selected for erasure
    reg [SecNum:0] Ers_queue;

    //Command Register
    reg WRITE     = 1'b1;
    reg READ      = 1'b1;
    reg READ_A    = 1'b1;
    reg BURST     = 1'b1;
    reg ReadINIT  = 1'b1;

    //Parameters of bank specific operations
    //Supports 15 (or less) bank architecture
    reg[3:0]  BankID;
    reg[3:0]  BankASEL;
    reg[3:0]  BankPROGRAM;
    reg[3:0]  BankCFI;
    reg[3:0]  BankPPB;
    reg[3:0]  BankDYB;
    reg[3:0]  BankPPBLOCK;
    reg[15:0] BankERASE;

    reg[3:0] BankCHECK;
    reg[11:0] SectorCHECK;

    reg WB_FLAG;

    integer SA_WriteBuffer;
    integer PA_WriteBuffer;
    integer Cnt_WriteBuffer;
    integer LCNT;

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SA      = 0;         // 0 TO SecNum
    integer D_tmp; //0 TO MaxData;
    integer Addr;  //0 TO SecSize, Address within sector
    integer SSWAddr;
    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;
    reg RST ;
    reg reseted ;

    // active CLK edge detcetion
    reg CLKMerge;

    integer Mem[0:ADDRRange];
    integer SecSi[0:(SecSiSize-1)];
    reg[15:0] ConfReg;
    reg[15:0] LockReg;
    //Sector Protection Status
    integer Password[0:3];
    reg[SecNum:0] DYB;
    reg[SecNum:0] PPB;

    reg PPBLock;
    integer BurstDelay;
    // timing check violation
    reg Viol = 1'b0;

    reg HWResetGlitch = 1'b0;

    //CLK_Gen
    reg InitL = 1'b1;
    reg InitH = 1'b1;
    reg CLK_50L;
    reg CLK_50H;
    reg CLK_100;

    // StateTransition values
    reg R;
    reg E;
    //Bus Cycle Decode
    integer AddressLatched;
    integer AddrLO;
    integer AddrHI;
    reg READCYCLE;
    reg WRITECYCLE;
    reg LATCHED;
    reg SetTM;
    integer SecLatched;

    //StateGen
    //Command Sequence detection
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_1    = 1'b0;
    reg BURST_TR;
    reg SYNCREAD;
    reg[15:0] tempLR_t;
    reg[15:0] tempLR_f;

    //Functional
    integer CFI_array[8'h10:8'h67];
    integer ASEL_array[8'h00:8'h0F];
    integer WData;
    integer WAddr;
    integer SecSiAddr;
    reg oe = 1'b0;
    //Status reg.
    reg[15:0] Status = 16'b0;
    reg DQ7Poll;
    reg[15:0]  old_bit;
    reg[15:0]  new_bit;
    integer old_int;
    integer new_int;
    integer Data;
    integer ASELInd;
    reg[7:0] temp;
    integer AddrCFI;
    reg ReadOK;
    integer DataLo;
    //Burst Params
    integer AddrLOW;
    integer AddrHIGH;
    integer BurstAddr;
    integer BurstSect;
    integer AddrSuspend;
    integer SectSuspend;
    integer WMSuspend;
    integer A7Addr;
    integer A7Sect;
    integer BurstBorder;
    integer WrapMax;
    reg BusyBOUND;
    reg[15:0] CrossData;
    //Burst latency values
    reg INITIAL_DELAY;
    reg INITIAL_ACCESS;
    reg PRIOR_TO_IACC;
    reg DEVICE_BUSY;
    reg WITHOUT_WRAP;
    reg WrapMaxCOND;
    reg LatencyBOUND;
    integer LatencyCODE;
    integer WSDelay;
    reg RY_active;

    integer Data_WriteBuffer[0:31];
    integer Addr_WriteBuffer[0:31];

    reg[15:0] OutputD;
    reg[15:0] SyncData;

    reg[3:0] PassMATCH;
    integer SA_ProtBit;

    reg[11:0] SecTemp;
    reg[11:0] SecHlp;

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
    integer   OEDQ_01;
    integer   CEDQ_01;
    integer   ADDRDQ_01;

    reg[15:0] TempData;
    event oe_event;
    event MergeE;

    integer SectorA;
    integer SectorB;

    reg [2:0] BankMODE;
    reg [6:0] current_state;
    reg [6:0] next_state;
    reg [2:0] READ_MODE;
    reg [2:0] PGMS_FLAG;

    //latest revison added
    reg[3:0] T;
    reg AdvancePointer = 1'b1;
    reg ConcurrentREAD = 1'b0;
    integer StartAddress_WriteBuffer;
    integer ASEL_03;
    reg HWResetStart;
    time AdvanceT[0:3];
    time AdvanceT_bound[0:3];
    time AdvanceT_nobound[0:3];
    time Period[0:3];
    time IncrementT;
    integer Freq;
    reg D4Latency;
    reg BURST_LENGTH;
    reg Glitch = 1'b0;
    event T0_event;
    event T1_event;
    event T2_event;
    event T3_event;
    reg[SecNum:0] dyb_boot_value;
    reg[1:0] frequency_supported;

    parameter OL = 2'b00;
    parameter OP = 2'b01;
    parameter OS = 2'b10;

    // FSM states
    parameter RESET              =8'h00;
    parameter Z001               =8'h01;
    parameter PREL_SETBWB        =8'h02;
    parameter PREL_ULBYPASS      =8'h03;
    parameter EXIT_ULBYPASS      =8'h04;
    parameter EXIT_BankMODE      =8'h05;
    parameter CFI                =8'h06;
    parameter UBP_CFI            =8'h07;
    parameter AS                 =8'h08;
    parameter CR_READ            =8'h09;
    parameter CR_WRITE           =8'h0A;
    parameter EXIT_CR            =8'h0B;
    parameter LOCKREG_CMDSET     =8'h0C;
    parameter LOCKREG_A0SEEN     =8'h0D;
    parameter EXIT_LOCKREG       =8'h0E;
    parameter PPB_CMDSET         =8'h0F;
    parameter PPB_A0SEEN         =8'h10;
    parameter PPB_PROG           =8'h11;
    parameter PPB_80SEEN         =8'h12;
    parameter PPB_ERS            =8'h13;
    parameter EXIT_PPB           =8'h14;
    parameter DYB_CMDSET         =8'h15;
    parameter DYB_SETCLEAR       =8'h16;
    parameter EXIT_DYB           =8'h17;
    parameter PASS_A0SEEN        =8'h18;
    parameter PASSUNLOCK1        =8'h19;
    parameter PASSUNLOCK2        =8'h1A;
    parameter PASSUNLOCK3        =8'h1B;
    parameter PASSUNLOCK4        =8'h1C;
    parameter PASSUNLOCK5        =8'h1D;
    parameter PASSUNLOCK6        =8'h1E;
    parameter PASSUNLOCK         =8'h1F;
    parameter PPBLOCK_SET        =8'h20;
    parameter SECSI_A0SEEN       =8'h21;
    parameter A0SEEN             =8'h22;
    parameter C8                 =8'h23;
    parameter C8_Z001            =8'h24;
    parameter C8_PREL            =8'h25;
    parameter ERS                =8'h26;
    parameter SERS               =8'h27;
    parameter ESPS               =8'h28;
    parameter SERS_EXEC          =8'h29;
    parameter ESP                =8'h2A;
    parameter ESP_Z001           =8'h2B;
    parameter ESP_PREL           =8'h2C;
    parameter ESP_CFI            =8'h2D;
    parameter ESP_A0SEEN         =8'h2E;
    parameter ESP_AS             =8'h2F;
    parameter ESP_PPB            =8'h30;
    parameter ESP_DYB            =8'h31;
    parameter ESP_OTP            =8'h32;
    parameter ESP_OTP_Z001       =8'h33;
    parameter ESP_OTP_PREL       =8'h34;
    parameter ESP_OTP_EXIT       =8'h35;
    parameter PGMS               =8'h36;
    parameter PSPS               =8'h37;
    parameter PSP                =8'h38;
    parameter PSP_Z001           =8'h39;
    parameter PSP_PREL           =8'h3A;
    parameter PSP_CFI            =8'h3B;
    parameter PSP_AS             =8'h3C;
    parameter PSP_PPB            =8'h3D;
    parameter PSP_DYB            =8'h3E;
    parameter PSP_OTP            =8'h3F;
    parameter PSP_OTP_Z001       =8'h40;
    parameter PSP_OTP_PREL       =8'h41;
    parameter PSP_OTP_EXIT       =8'h42;
    parameter WBPGMS_WBCNT       =8'h43;
    parameter WBPGMS_WBLSTA      =8'h44;
    parameter WBPGMS_WBLOAD      =8'h45;
    parameter WBPGMS_CONFB       =8'h46;
    parameter WBPGMS_WBABORT     =8'h47;
    parameter WBPGMS_Z001        =8'h48;
    parameter WBPGMS_PREL        =8'h49;
    parameter HW_RESET_UNKNOWN   =8'h4A;
    parameter HW_RESET_INIT      =8'h4B;
    parameter PPBLOCK_CMDSET     =8'h4C;
    parameter EXIT_PPBLOCK       =8'h4D;
    parameter ESP_PPBLOCK        =8'h4E;
    parameter PSP_PPBLOCK        =8'h4F;

    parameter SecSiENABLED       =2'h1;
    parameter PasswordENABLED    =2'h3;

    parameter MEMORY             =2'h0;
    parameter OTP                =2'h1;
    parameter PASSW              =2'h2;
    parameter LREG               =2'h3;

    parameter NO_SYNC    = 4'd0;
    parameter CONTINUOUS = 4'd1;
    parameter LINEAR     = 4'd2;
    parameter SYNCR      = 4'd3;
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

    buf   (CENegf1_ipd  , CENegf1  );
    buf   (OENeg_ipd    , OENeg    );
    buf   (WENeg_ipd    , WENeg    );
    buf   (CLK_ipd      , CLK      );
    buf   (AVDNeg_ipd   , AVDNeg   );
    buf   (RESETNeg_ipd , RESETNeg );
    buf   (WPNeg_ipd    , WPNeg    );
    buf   (ACC_ipd      , ACC      );

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

    nmos   (RDY ,   RY_zd     , 1);
    wire deg;

    // Needed for TimingChecks
    // VHDL CheckEnable Equivalent
    wire Check_A0_CLK_posedge;
    assign Check_A0_CLK_posedge =
        ~ConfReg[15] && ConfReg[6] && ~AVDNeg && CLKMerge;

    wire Check_A0_WENeg_negedge;
    assign Check_A0_WENeg_negedge = ~CENegf1 && ~AVDNeg && OENeg;

    wire Check_A0_CENeg_negedge;
    assign Check_A0_CENeg_negedge = ~WENeg && ~AVDNeg && OENeg;

    wire Check_DQ0_WENeg_posedge;
    assign Check_DQ0_WENeg_posedge = ~CENegf1 && OENeg;

    wire Check_DQ0_CENeg_posedge;
    assign Check_DQ0_CENeg_posedge = ~WENeg && OENeg;

    wire Check_CLK_posedge;
    assign Check_CLK_posedge = ~ConfReg[15] && ConfReg[6] && CLKMerge;

    wire Check_No_Read;
    assign Check_No_Read = OENeg;

    wire Check_SetupHoldLow_AVDNeg;
    assign Check_SetupHoldLow_AVDNeg = ~AVDNeg;

    wire Check_SetupHoldLow_AVDNeg_CLK_posedge;
    assign Check_SetupHoldLow_AVDNeg_CLK_posedge = Check_CLK_posedge && ~AVDNeg;

    wire Check_SetupHoldLow_CENeg_CLK_posedge;
    assign Check_SetupHoldLow_CENeg_CLK_posedge =
        Check_A0_CLK_posedge && ~CENegf1;

    wire Check_CENeg_AVDNeg;
    assign Check_CENeg_AVDNeg = ~ConfReg[15] && ~CENegf1;

    wire CLKPathEnable;
    assign CLKPathEnable = ~ConfReg[15] && ~CENegf1 &&
        (READ_MODE == LINEAR || READ_MODE == CONTINUOUS) &&
        ~ConcurrentREAD;

reg temp15 = ConfReg[15];

specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

    specparam       tpd_A0_DQ0              =   1;//tACC
    specparam       tpd_CENegf1_DQ0         =   1;//tCE
    specparam       tpd_CENegf1_RDY         =   1;//tCR
    specparam       tpd_OENeg_DQ0           =   1;//tOE
    specparam       tpd_CLK_DQ0             =   1;//tCKA/tCKZ
    specparam       tpd_CLK_RDY             =   1;//tRACC
    //tsetup values
    specparam       tsetup_A0_AVDNeg        =   1;//tAAVDS,tAAS,/
    specparam       tsetup_CENegf1_AVDNeg   =   1;//tCAS
    specparam       tsetup_A0_CLK           =   1;//tACS
    specparam       tsetup_CENegf1_CLK      =   1;//tCES
    specparam       tsetup_AVDNeg_CLK       =   1;//tAVC
    specparam       tsetup_A0_WENeg         =   1;//tAS,\
    specparam       tsetup_DQ0_WENeg        =   1;//tDS,/
    specparam       tsetup_CENegf1_WENeg    =   1;//tCS
    specparam       tsetup_AVDNeg_WENeg     =   1;//tAVSW
    specparam       tsetup_CLK_WENeg        =   1;//tCSW
    //thold values
    specparam       thold_A0_AVDNeg         =   1;//tAAVDH,tAAH,/
    specparam       thold_A0_CLK            =   1;//tACH
    specparam       thold_A0_WENeg          =   1;//tAH,\
    specparam       thold_DQ0_WENeg         =   1;//tDH /
    specparam       thold_WENeg_OENeg       =   1;//tGHWL,/
    specparam       thold_CENegf1_WENeg     =   1;//tCH,\
    specparam       thold_AVDNeg_WENeg      =   1;//tAVHW,\
    specparam       thold_AVDNeg_CLK        =   1;//tAVHC
    specparam       thold_CENegf1_RESETNeg  =   1;//tRH,/
    specparam       thold_OENeg_RESETNeg    =   1;//tRH,/
    //tpw values
    specparam       tpw_AVDNeg_negedge      =   1;//tAVDP
    specparam       tpw_WENeg_negedge       =   1;//tWP
    specparam       tpw_WENeg_posedge       =   1;//tWPH
    specparam       tpw_CLK_negedge         =   1;//tCL
    specparam       tpw_CLK_posedge         =   1;//tCH
    specparam       tpw_RESETNeg_negedge    =   1;//tRP
    specparam       tperiod_CLK             =   1;//tCLK

    //tdevice values: values for internal delays
    specparam       tdevice_POW             =   40000;
    specparam       tdevice_WBUF            =   9400;
    //Sector Erase Operation    tWHWH2
    specparam       tdevice_SEO64KW         =   600000000;
    specparam       tdevice_SEO16KW         =   150000000;
    //program/erase suspend timeout
    specparam       tdevice_START           =   20000;
    //sector erase command sequence timeout
    specparam       tdevice_CTMOUT          =   50000;
    //device ready after Hardware reset(during embeded algorithm)
    //Protection Bit Program
    specparam       tdevice_PROTP           =   150000;
    //Protection Bit Erase
    specparam       tdevice_PROTE           =   15000000;
    //Password Unlock
    specparam       tdevice_UNLOCK          =   1000;

    //TIACC, needed for burst access
    //Must be specifed aligned to model timescale due to its usage
    //within path delay dection and access time calculations
    specparam       tdevice_TIACC_ts        =   69000;

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

// Data ouptut paths
    if (FROMCE)
        ( CENegf1 => DQ0 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ1 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ2 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ3 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ4 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ5 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ6 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ7 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ8 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ9 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ10 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ11 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ12 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ13 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ14 ) = tpd_CENegf1_DQ0;
    if (FROMCE)
        ( CENegf1 => DQ15 ) = tpd_CENegf1_DQ0;

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
    if (FROMOE)
        ( OENeg => DQ8 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ9 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ10 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ11 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ12 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ13 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ14 ) = tpd_OENeg_DQ0;
    if (FROMOE)
        ( OENeg => DQ15 ) = tpd_OENeg_DQ0;

        ( A0 => DQ0 ) = tpd_A0_DQ0;
        ( A0 => DQ1 ) = tpd_A0_DQ0;
        ( A0 => DQ2 ) = tpd_A0_DQ0;
        ( A0 => DQ3 ) = tpd_A0_DQ0;
        ( A0 => DQ4 ) = tpd_A0_DQ0;
        ( A0 => DQ5 ) = tpd_A0_DQ0;
        ( A0 => DQ6 ) = tpd_A0_DQ0;
        ( A0 => DQ7 ) = tpd_A0_DQ0;
        ( A0 => DQ8 ) = tpd_A0_DQ0;
        ( A0 => DQ9 ) = tpd_A0_DQ0;
        ( A0 => DQ10 ) = tpd_A0_DQ0;
        ( A0 => DQ11 ) = tpd_A0_DQ0;
        ( A0 => DQ12 ) = tpd_A0_DQ0;
        ( A0 => DQ13 ) = tpd_A0_DQ0;
        ( A0 => DQ14 ) = tpd_A0_DQ0;
        ( A0 => DQ15 ) = tpd_A0_DQ0;
        ( A1 => DQ0 ) = tpd_A0_DQ0;
        ( A1 => DQ1 ) = tpd_A0_DQ0;
        ( A1 => DQ2 ) = tpd_A0_DQ0;
        ( A1 => DQ3 ) = tpd_A0_DQ0;
        ( A1 => DQ4 ) = tpd_A0_DQ0;
        ( A1 => DQ5 ) = tpd_A0_DQ0;
        ( A1 => DQ6 ) = tpd_A0_DQ0;
        ( A1 => DQ7 ) = tpd_A0_DQ0;
        ( A1 => DQ8 ) = tpd_A0_DQ0;
        ( A1 => DQ9 ) = tpd_A0_DQ0;
        ( A1 => DQ10 ) = tpd_A0_DQ0;
        ( A1 => DQ11 ) = tpd_A0_DQ0;
        ( A1 => DQ12 ) = tpd_A0_DQ0;
        ( A1 => DQ13 ) = tpd_A0_DQ0;
        ( A1 => DQ14 ) = tpd_A0_DQ0;
        ( A1 => DQ15 ) = tpd_A0_DQ0;
        ( A2 => DQ0 ) = tpd_A0_DQ0;
        ( A2 => DQ1 ) = tpd_A0_DQ0;
        ( A2 => DQ2 ) = tpd_A0_DQ0;
        ( A2 => DQ3 ) = tpd_A0_DQ0;
        ( A2 => DQ4 ) = tpd_A0_DQ0;
        ( A2 => DQ5 ) = tpd_A0_DQ0;
        ( A2 => DQ6 ) = tpd_A0_DQ0;
        ( A2 => DQ7 ) = tpd_A0_DQ0;
        ( A2 => DQ8 ) = tpd_A0_DQ0;
        ( A2 => DQ9 ) = tpd_A0_DQ0;
        ( A2 => DQ10 ) = tpd_A0_DQ0;
        ( A2 => DQ11 ) = tpd_A0_DQ0;
        ( A2 => DQ12 ) = tpd_A0_DQ0;
        ( A2 => DQ13 ) = tpd_A0_DQ0;
        ( A2 => DQ14 ) = tpd_A0_DQ0;
        ( A2 => DQ15 ) = tpd_A0_DQ0;
        ( A3 => DQ0 ) = tpd_A0_DQ0;
        ( A3 => DQ1 ) = tpd_A0_DQ0;
        ( A3 => DQ2 ) = tpd_A0_DQ0;
        ( A3 => DQ3 ) = tpd_A0_DQ0;
        ( A3 => DQ4 ) = tpd_A0_DQ0;
        ( A3 => DQ5 ) = tpd_A0_DQ0;
        ( A3 => DQ6 ) = tpd_A0_DQ0;
        ( A3 => DQ7 ) = tpd_A0_DQ0;
        ( A3 => DQ8 ) = tpd_A0_DQ0;
        ( A3 => DQ9 ) = tpd_A0_DQ0;
        ( A3 => DQ10 ) = tpd_A0_DQ0;
        ( A3 => DQ11 ) = tpd_A0_DQ0;
        ( A3 => DQ12 ) = tpd_A0_DQ0;
        ( A3 => DQ13 ) = tpd_A0_DQ0;
        ( A3 => DQ14 ) = tpd_A0_DQ0;
        ( A3 => DQ15 ) = tpd_A0_DQ0;
        ( A4 => DQ0 ) = tpd_A0_DQ0;
        ( A4 => DQ1 ) = tpd_A0_DQ0;
        ( A4 => DQ2 ) = tpd_A0_DQ0;
        ( A4 => DQ3 ) = tpd_A0_DQ0;
        ( A4 => DQ4 ) = tpd_A0_DQ0;
        ( A4 => DQ5 ) = tpd_A0_DQ0;
        ( A4 => DQ6 ) = tpd_A0_DQ0;
        ( A4 => DQ7 ) = tpd_A0_DQ0;
        ( A4 => DQ8 ) = tpd_A0_DQ0;
        ( A4 => DQ9 ) = tpd_A0_DQ0;
        ( A4 => DQ10 ) = tpd_A0_DQ0;
        ( A4 => DQ11 ) = tpd_A0_DQ0;
        ( A4 => DQ12 ) = tpd_A0_DQ0;
        ( A4 => DQ13 ) = tpd_A0_DQ0;
        ( A4 => DQ14 ) = tpd_A0_DQ0;
        ( A4 => DQ15 ) = tpd_A0_DQ0;
        ( A5 => DQ0 ) = tpd_A0_DQ0;
        ( A5 => DQ1 ) = tpd_A0_DQ0;
        ( A5 => DQ2 ) = tpd_A0_DQ0;
        ( A5 => DQ3 ) = tpd_A0_DQ0;
        ( A5 => DQ4 ) = tpd_A0_DQ0;
        ( A5 => DQ5 ) = tpd_A0_DQ0;
        ( A5 => DQ6 ) = tpd_A0_DQ0;
        ( A5 => DQ7 ) = tpd_A0_DQ0;
        ( A5 => DQ8 ) = tpd_A0_DQ0;
        ( A5 => DQ9 ) = tpd_A0_DQ0;
        ( A5 => DQ10 ) = tpd_A0_DQ0;
        ( A5 => DQ11 ) = tpd_A0_DQ0;
        ( A5 => DQ12 ) = tpd_A0_DQ0;
        ( A5 => DQ13 ) = tpd_A0_DQ0;
        ( A5 => DQ14 ) = tpd_A0_DQ0;
        ( A5 => DQ15 ) = tpd_A0_DQ0;
        ( A6 => DQ0 ) = tpd_A0_DQ0;
        ( A6 => DQ1 ) = tpd_A0_DQ0;
        ( A6 => DQ2 ) = tpd_A0_DQ0;
        ( A6 => DQ3 ) = tpd_A0_DQ0;
        ( A6 => DQ4 ) = tpd_A0_DQ0;
        ( A6 => DQ5 ) = tpd_A0_DQ0;
        ( A6 => DQ6 ) = tpd_A0_DQ0;
        ( A6 => DQ7 ) = tpd_A0_DQ0;
        ( A6 => DQ8 ) = tpd_A0_DQ0;
        ( A6 => DQ9 ) = tpd_A0_DQ0;
        ( A6 => DQ10 ) = tpd_A0_DQ0;
        ( A6 => DQ11 ) = tpd_A0_DQ0;
        ( A6 => DQ12 ) = tpd_A0_DQ0;
        ( A6 => DQ13 ) = tpd_A0_DQ0;
        ( A6 => DQ14 ) = tpd_A0_DQ0;
        ( A6 => DQ15 ) = tpd_A0_DQ0;
        ( A7 => DQ0 ) = tpd_A0_DQ0;
        ( A7 => DQ1 ) = tpd_A0_DQ0;
        ( A7 => DQ2 ) = tpd_A0_DQ0;
        ( A7 => DQ3 ) = tpd_A0_DQ0;
        ( A7 => DQ4 ) = tpd_A0_DQ0;
        ( A7 => DQ5 ) = tpd_A0_DQ0;
        ( A7 => DQ6 ) = tpd_A0_DQ0;
        ( A7 => DQ7 ) = tpd_A0_DQ0;
        ( A7 => DQ8 ) = tpd_A0_DQ0;
        ( A7 => DQ9 ) = tpd_A0_DQ0;
        ( A7 => DQ10 ) = tpd_A0_DQ0;
        ( A7 => DQ11 ) = tpd_A0_DQ0;
        ( A7 => DQ12 ) = tpd_A0_DQ0;
        ( A7 => DQ13 ) = tpd_A0_DQ0;
        ( A7 => DQ14 ) = tpd_A0_DQ0;
        ( A7 => DQ15 ) = tpd_A0_DQ0;
        ( A8 => DQ0 ) = tpd_A0_DQ0;
        ( A8 => DQ1 ) = tpd_A0_DQ0;
        ( A8 => DQ2 ) = tpd_A0_DQ0;
        ( A8 => DQ3 ) = tpd_A0_DQ0;
        ( A8 => DQ4 ) = tpd_A0_DQ0;
        ( A8 => DQ5 ) = tpd_A0_DQ0;
        ( A8 => DQ6 ) = tpd_A0_DQ0;
        ( A8 => DQ7 ) = tpd_A0_DQ0;
        ( A8 => DQ8 ) = tpd_A0_DQ0;
        ( A8 => DQ9 ) = tpd_A0_DQ0;
        ( A8 => DQ10 ) = tpd_A0_DQ0;
        ( A8 => DQ11 ) = tpd_A0_DQ0;
        ( A8 => DQ12 ) = tpd_A0_DQ0;
        ( A8 => DQ13 ) = tpd_A0_DQ0;
        ( A8 => DQ14 ) = tpd_A0_DQ0;
        ( A8 => DQ15 ) = tpd_A0_DQ0;
        ( A9 => DQ0 ) = tpd_A0_DQ0;
        ( A9 => DQ1 ) = tpd_A0_DQ0;
        ( A9 => DQ2 ) = tpd_A0_DQ0;
        ( A9 => DQ3 ) = tpd_A0_DQ0;
        ( A9 => DQ4 ) = tpd_A0_DQ0;
        ( A9 => DQ5 ) = tpd_A0_DQ0;
        ( A9 => DQ6 ) = tpd_A0_DQ0;
        ( A9 => DQ7 ) = tpd_A0_DQ0;
        ( A9 => DQ8 ) = tpd_A0_DQ0;
        ( A9 => DQ9 ) = tpd_A0_DQ0;
        ( A9 => DQ10 ) = tpd_A0_DQ0;
        ( A9 => DQ11 ) = tpd_A0_DQ0;
        ( A9 => DQ12 ) = tpd_A0_DQ0;
        ( A9 => DQ13 ) = tpd_A0_DQ0;
        ( A9 => DQ14 ) = tpd_A0_DQ0;
        ( A9 => DQ15 ) = tpd_A0_DQ0;
        ( A10 => DQ0 ) = tpd_A0_DQ0;
        ( A10 => DQ1 ) = tpd_A0_DQ0;
        ( A10 => DQ2 ) = tpd_A0_DQ0;
        ( A10 => DQ3 ) = tpd_A0_DQ0;
        ( A10 => DQ4 ) = tpd_A0_DQ0;
        ( A10 => DQ5 ) = tpd_A0_DQ0;
        ( A10 => DQ6 ) = tpd_A0_DQ0;
        ( A10 => DQ7 ) = tpd_A0_DQ0;
        ( A10 => DQ8 ) = tpd_A0_DQ0;
        ( A10 => DQ9 ) = tpd_A0_DQ0;
        ( A10 => DQ10 ) = tpd_A0_DQ0;
        ( A10 => DQ11 ) = tpd_A0_DQ0;
        ( A10 => DQ12 ) = tpd_A0_DQ0;
        ( A10 => DQ13 ) = tpd_A0_DQ0;
        ( A10 => DQ14 ) = tpd_A0_DQ0;
        ( A10 => DQ15 ) = tpd_A0_DQ0;
        ( A11 => DQ0 ) = tpd_A0_DQ0;
        ( A11 => DQ1 ) = tpd_A0_DQ0;
        ( A11 => DQ2 ) = tpd_A0_DQ0;
        ( A11 => DQ3 ) = tpd_A0_DQ0;
        ( A11 => DQ4 ) = tpd_A0_DQ0;
        ( A11 => DQ5 ) = tpd_A0_DQ0;
        ( A11 => DQ6 ) = tpd_A0_DQ0;
        ( A11 => DQ7 ) = tpd_A0_DQ0;
        ( A11 => DQ8 ) = tpd_A0_DQ0;
        ( A11 => DQ9 ) = tpd_A0_DQ0;
        ( A11 => DQ10 ) = tpd_A0_DQ0;
        ( A11 => DQ11 ) = tpd_A0_DQ0;
        ( A11 => DQ12 ) = tpd_A0_DQ0;
        ( A11 => DQ13 ) = tpd_A0_DQ0;
        ( A11 => DQ14 ) = tpd_A0_DQ0;
        ( A11 => DQ15 ) = tpd_A0_DQ0;
        ( A12 => DQ0 ) = tpd_A0_DQ0;
        ( A12 => DQ1 ) = tpd_A0_DQ0;
        ( A12 => DQ2 ) = tpd_A0_DQ0;
        ( A12 => DQ3 ) = tpd_A0_DQ0;
        ( A12 => DQ4 ) = tpd_A0_DQ0;
        ( A12 => DQ5 ) = tpd_A0_DQ0;
        ( A12 => DQ6 ) = tpd_A0_DQ0;
        ( A12 => DQ7 ) = tpd_A0_DQ0;
        ( A12 => DQ8 ) = tpd_A0_DQ0;
        ( A12 => DQ9 ) = tpd_A0_DQ0;
        ( A12 => DQ10 ) = tpd_A0_DQ0;
        ( A12 => DQ11 ) = tpd_A0_DQ0;
        ( A12 => DQ12 ) = tpd_A0_DQ0;
        ( A12 => DQ13 ) = tpd_A0_DQ0;
        ( A12 => DQ14 ) = tpd_A0_DQ0;
        ( A12 => DQ15 ) = tpd_A0_DQ0;
        ( A13 => DQ0 ) = tpd_A0_DQ0;
        ( A13 => DQ1 ) = tpd_A0_DQ0;
        ( A13 => DQ2 ) = tpd_A0_DQ0;
        ( A13 => DQ3 ) = tpd_A0_DQ0;
        ( A13 => DQ4 ) = tpd_A0_DQ0;
        ( A13 => DQ5 ) = tpd_A0_DQ0;
        ( A13 => DQ6 ) = tpd_A0_DQ0;
        ( A13 => DQ7 ) = tpd_A0_DQ0;
        ( A13 => DQ8 ) = tpd_A0_DQ0;
        ( A13 => DQ9 ) = tpd_A0_DQ0;
        ( A13 => DQ10 ) = tpd_A0_DQ0;
        ( A13 => DQ11 ) = tpd_A0_DQ0;
        ( A13 => DQ12 ) = tpd_A0_DQ0;
        ( A13 => DQ13 ) = tpd_A0_DQ0;
        ( A13 => DQ14 ) = tpd_A0_DQ0;
        ( A13 => DQ15 ) = tpd_A0_DQ0;
        ( A14 => DQ0 ) = tpd_A0_DQ0;
        ( A14 => DQ1 ) = tpd_A0_DQ0;
        ( A14 => DQ2 ) = tpd_A0_DQ0;
        ( A14 => DQ3 ) = tpd_A0_DQ0;
        ( A14 => DQ4 ) = tpd_A0_DQ0;
        ( A14 => DQ5 ) = tpd_A0_DQ0;
        ( A14 => DQ6 ) = tpd_A0_DQ0;
        ( A14 => DQ7 ) = tpd_A0_DQ0;
        ( A14 => DQ8 ) = tpd_A0_DQ0;
        ( A14 => DQ9 ) = tpd_A0_DQ0;
        ( A14 => DQ10 ) = tpd_A0_DQ0;
        ( A14 => DQ11 ) = tpd_A0_DQ0;
        ( A14 => DQ12 ) = tpd_A0_DQ0;
        ( A14 => DQ13 ) = tpd_A0_DQ0;
        ( A14 => DQ14 ) = tpd_A0_DQ0;
        ( A14 => DQ15 ) = tpd_A0_DQ0;
        ( A15 => DQ0 ) = tpd_A0_DQ0;
        ( A15 => DQ1 ) = tpd_A0_DQ0;
        ( A15 => DQ2 ) = tpd_A0_DQ0;
        ( A15 => DQ3 ) = tpd_A0_DQ0;
        ( A15 => DQ4 ) = tpd_A0_DQ0;
        ( A15 => DQ5 ) = tpd_A0_DQ0;
        ( A15 => DQ6 ) = tpd_A0_DQ0;
        ( A15 => DQ7 ) = tpd_A0_DQ0;
        ( A15 => DQ8 ) = tpd_A0_DQ0;
        ( A15 => DQ9 ) = tpd_A0_DQ0;
        ( A15 => DQ10 ) = tpd_A0_DQ0;
        ( A15 => DQ11 ) = tpd_A0_DQ0;
        ( A15 => DQ12 ) = tpd_A0_DQ0;
        ( A15 => DQ13 ) = tpd_A0_DQ0;
        ( A15 => DQ14 ) = tpd_A0_DQ0;
        ( A15 => DQ15 ) = tpd_A0_DQ0;
        ( A16 => DQ0 ) = tpd_A0_DQ0;
        ( A16 => DQ1 ) = tpd_A0_DQ0;
        ( A16 => DQ2 ) = tpd_A0_DQ0;
        ( A16 => DQ3 ) = tpd_A0_DQ0;
        ( A16 => DQ4 ) = tpd_A0_DQ0;
        ( A16 => DQ5 ) = tpd_A0_DQ0;
        ( A16 => DQ6 ) = tpd_A0_DQ0;
        ( A16 => DQ7 ) = tpd_A0_DQ0;
        ( A16 => DQ8 ) = tpd_A0_DQ0;
        ( A16 => DQ9 ) = tpd_A0_DQ0;
        ( A16 => DQ10 ) = tpd_A0_DQ0;
        ( A16 => DQ11 ) = tpd_A0_DQ0;
        ( A16 => DQ12 ) = tpd_A0_DQ0;
        ( A16 => DQ13 ) = tpd_A0_DQ0;
        ( A16 => DQ14 ) = tpd_A0_DQ0;
        ( A16 => DQ15 ) = tpd_A0_DQ0;
        ( A17 => DQ0 ) = tpd_A0_DQ0;
        ( A17 => DQ1 ) = tpd_A0_DQ0;
        ( A17 => DQ2 ) = tpd_A0_DQ0;
        ( A17 => DQ3 ) = tpd_A0_DQ0;
        ( A17 => DQ4 ) = tpd_A0_DQ0;
        ( A17 => DQ5 ) = tpd_A0_DQ0;
        ( A17 => DQ6 ) = tpd_A0_DQ0;
        ( A17 => DQ7 ) = tpd_A0_DQ0;
        ( A17 => DQ8 ) = tpd_A0_DQ0;
        ( A17 => DQ9 ) = tpd_A0_DQ0;
        ( A17 => DQ10 ) = tpd_A0_DQ0;
        ( A17 => DQ11 ) = tpd_A0_DQ0;
        ( A17 => DQ12 ) = tpd_A0_DQ0;
        ( A17 => DQ13 ) = tpd_A0_DQ0;
        ( A17 => DQ14 ) = tpd_A0_DQ0;
        ( A17 => DQ15 ) = tpd_A0_DQ0;
        ( A18 => DQ0 ) = tpd_A0_DQ0;
        ( A18 => DQ1 ) = tpd_A0_DQ0;
        ( A18 => DQ2 ) = tpd_A0_DQ0;
        ( A18 => DQ3 ) = tpd_A0_DQ0;
        ( A18 => DQ4 ) = tpd_A0_DQ0;
        ( A18 => DQ5 ) = tpd_A0_DQ0;
        ( A18 => DQ6 ) = tpd_A0_DQ0;
        ( A18 => DQ7 ) = tpd_A0_DQ0;
        ( A18 => DQ8 ) = tpd_A0_DQ0;
        ( A18 => DQ9 ) = tpd_A0_DQ0;
        ( A18 => DQ10 ) = tpd_A0_DQ0;
        ( A18 => DQ11 ) = tpd_A0_DQ0;
        ( A18 => DQ12 ) = tpd_A0_DQ0;
        ( A18 => DQ13 ) = tpd_A0_DQ0;
        ( A18 => DQ14 ) = tpd_A0_DQ0;
        ( A18 => DQ15 ) = tpd_A0_DQ0;
        ( A19 => DQ0 ) = tpd_A0_DQ0;
        ( A19 => DQ1 ) = tpd_A0_DQ0;
        ( A19 => DQ2 ) = tpd_A0_DQ0;
        ( A19 => DQ3 ) = tpd_A0_DQ0;
        ( A19 => DQ4 ) = tpd_A0_DQ0;
        ( A19 => DQ5 ) = tpd_A0_DQ0;
        ( A19 => DQ6 ) = tpd_A0_DQ0;
        ( A19 => DQ7 ) = tpd_A0_DQ0;
        ( A19 => DQ8 ) = tpd_A0_DQ0;
        ( A19 => DQ9 ) = tpd_A0_DQ0;
        ( A19 => DQ10 ) = tpd_A0_DQ0;
        ( A19 => DQ11 ) = tpd_A0_DQ0;
        ( A19 => DQ12 ) = tpd_A0_DQ0;
        ( A19 => DQ13 ) = tpd_A0_DQ0;
        ( A19 => DQ14 ) = tpd_A0_DQ0;
        ( A19 => DQ15 ) = tpd_A0_DQ0;
        ( A20 => DQ0 ) = tpd_A0_DQ0;
        ( A20 => DQ1 ) = tpd_A0_DQ0;
        ( A20 => DQ2 ) = tpd_A0_DQ0;
        ( A20 => DQ3 ) = tpd_A0_DQ0;
        ( A20 => DQ4 ) = tpd_A0_DQ0;
        ( A20 => DQ5 ) = tpd_A0_DQ0;
        ( A20 => DQ6 ) = tpd_A0_DQ0;
        ( A20 => DQ7 ) = tpd_A0_DQ0;
        ( A20 => DQ8 ) = tpd_A0_DQ0;
        ( A20 => DQ9 ) = tpd_A0_DQ0;
        ( A20 => DQ10 ) = tpd_A0_DQ0;
        ( A20 => DQ11 ) = tpd_A0_DQ0;
        ( A20 => DQ12 ) = tpd_A0_DQ0;
        ( A20 => DQ13 ) = tpd_A0_DQ0;
        ( A20 => DQ14 ) = tpd_A0_DQ0;
        ( A20 => DQ15 ) = tpd_A0_DQ0;
        ( A21 => DQ0 ) = tpd_A0_DQ0;
        ( A21 => DQ1 ) = tpd_A0_DQ0;
        ( A21 => DQ2 ) = tpd_A0_DQ0;
        ( A21 => DQ3 ) = tpd_A0_DQ0;
        ( A21 => DQ4 ) = tpd_A0_DQ0;
        ( A21 => DQ5 ) = tpd_A0_DQ0;
        ( A21 => DQ6 ) = tpd_A0_DQ0;
        ( A21 => DQ7 ) = tpd_A0_DQ0;
        ( A21 => DQ8 ) = tpd_A0_DQ0;
        ( A21 => DQ9 ) = tpd_A0_DQ0;
        ( A21 => DQ10 ) = tpd_A0_DQ0;
        ( A21 => DQ11 ) = tpd_A0_DQ0;
        ( A21 => DQ12 ) = tpd_A0_DQ0;
        ( A21 => DQ13 ) = tpd_A0_DQ0;
        ( A21 => DQ14 ) = tpd_A0_DQ0;
        ( A21 => DQ15 ) = tpd_A0_DQ0;
        ( A22 => DQ0 ) = tpd_A0_DQ0;
        ( A22 => DQ1 ) = tpd_A0_DQ0;
        ( A22 => DQ2 ) = tpd_A0_DQ0;
        ( A22 => DQ3 ) = tpd_A0_DQ0;
        ( A22 => DQ4 ) = tpd_A0_DQ0;
        ( A22 => DQ5 ) = tpd_A0_DQ0;
        ( A22 => DQ6 ) = tpd_A0_DQ0;
        ( A22 => DQ7 ) = tpd_A0_DQ0;
        ( A22 => DQ8 ) = tpd_A0_DQ0;
        ( A22 => DQ9 ) = tpd_A0_DQ0;
        ( A22 => DQ10 ) = tpd_A0_DQ0;
        ( A22 => DQ11 ) = tpd_A0_DQ0;
        ( A22 => DQ12 ) = tpd_A0_DQ0;
        ( A22 => DQ13 ) = tpd_A0_DQ0;
        ( A22 => DQ14 ) = tpd_A0_DQ0;
        ( A22 => DQ15 ) = tpd_A0_DQ0;
        ( A23 => DQ0 ) = tpd_A0_DQ0;
        ( A23 => DQ1 ) = tpd_A0_DQ0;
        ( A23 => DQ2 ) = tpd_A0_DQ0;
        ( A23 => DQ3 ) = tpd_A0_DQ0;
        ( A23 => DQ4 ) = tpd_A0_DQ0;
        ( A23 => DQ5 ) = tpd_A0_DQ0;
        ( A23 => DQ6 ) = tpd_A0_DQ0;
        ( A23 => DQ7 ) = tpd_A0_DQ0;
        ( A23 => DQ8 ) = tpd_A0_DQ0;
        ( A23 => DQ9 ) = tpd_A0_DQ0;
        ( A23 => DQ10 ) = tpd_A0_DQ0;
        ( A23 => DQ11 ) = tpd_A0_DQ0;
        ( A23 => DQ12 ) = tpd_A0_DQ0;
        ( A23 => DQ13 ) = tpd_A0_DQ0;
        ( A23 => DQ14 ) = tpd_A0_DQ0;
        ( A23 => DQ15 ) = tpd_A0_DQ0;

    if (CLKPathEnable)
            ( CLK => DQ0 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ1 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ2 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ3 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ4 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ5 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ6 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ7 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ8 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ9 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ10 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ11 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ12 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ13 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ14 ) = tpd_CLK_DQ0;
    if (CLKPathEnable)
            ( CLK => DQ15 ) = tpd_CLK_DQ0;

    if (~temp15)
            ( CLK => DQ0 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ1 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ2 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ3 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ4 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ5 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ6 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ7 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ8 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ9 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ10 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ11 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ12 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ13 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ14 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);
    if (~temp15)
            ( CLK => DQ15 ) = (tdevice_TIACC_ts, tdevice_TIACC_ts);

    // RDY output paths
    (CENegf1 *> RDY) = tpd_CENegf1_RDY;

    if ( temp15 == 1'b0 && ~CENegf1 && CLKMerge == 1'b1)
    ( CLK *>  RDY ) = tpd_CLK_RDY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

    $setup (A0 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A1 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A2 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A3 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A4 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A5 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A6 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A7 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A8 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A9 , posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A10, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A11, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A12, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A13, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A14, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A15, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A16, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A17, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A18, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A19, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A20, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A21, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A22, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);
    $setup (A23, posedge CLK &&& Check_A0_CLK_posedge,tsetup_A0_CLK,Viol);

    $hold (posedge CLK &&& Check_A0_CLK_posedge, A0 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A1 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A2 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A3 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A4 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A5 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A6 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A7 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A8 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A9 ,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A10,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A11,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A12,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A13,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A14,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A15,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A16,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A17,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A18,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A19,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A20,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A21,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A22,thold_A0_CLK,Viol);
    $hold (posedge CLK &&& Check_A0_CLK_posedge, A23,thold_A0_CLK,Viol);

    $setup (A0    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A1    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A2    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A3    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A4    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A5    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A6    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A7    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A8    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A9    , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A10   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A11   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A12   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A13   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A14   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A15   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A16   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A17   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A18   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A19   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A20   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A21   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A22   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);
    $setup (A23   , posedge AVDNeg , tsetup_A0_AVDNeg, Viol);

    $hold (posedge AVDNeg , A0    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A1    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A2    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A3    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A4    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A5    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A6    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A7    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A8    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A9    ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A10   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A11   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A12   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A13   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A14   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A15   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A16   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A17   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A18   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A19   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A20   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A21   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A22   ,   thold_A0_AVDNeg, Viol);
    $hold (posedge AVDNeg , A23   ,   thold_A0_AVDNeg, Viol);

    $setup (A0    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A1    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A2    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A3    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A4    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A5    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A6    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A7    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A8    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A9    , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A10   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A11   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A12   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A13   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A14   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A15   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A16   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A17   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A18   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A19   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A20   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A21   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A22   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);
    $setup (A23   , negedge WENeg &&& Check_A0_WENeg_negedge,
            tsetup_A0_WENeg, Viol);

    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A0 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A1 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A2 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A3 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A4 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A5 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A6 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A7 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A8 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A9 ,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A10,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A11,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A12,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A13,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A14,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A15,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A16,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A17,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A18,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A19,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A20,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A21,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A22,thold_A0_WENeg,Viol);
    $hold (negedge WENeg &&& Check_A0_WENeg_negedge, A23,thold_A0_WENeg,Viol);

    $setup (A0    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A1    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A2    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A3    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A4    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A5    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A6    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A7    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A8    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A9    , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A10   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A11   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A12   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A13   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A14   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A15   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A16   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A17   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A18   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A19   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A20   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A21   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A22   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);
    $setup (A23   , negedge CENegf1 &&& Check_A0_CENeg_negedge,
        tsetup_A0_WENeg, Viol);

    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A0 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A1 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A2 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A3 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A4 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A5 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A6 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A7 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A8 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A9 ,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A10,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A11,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A12,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A13,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A14,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A15,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A16,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A17,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A18,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A19,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A20,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A21,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A22,thold_A0_WENeg,Viol);
    $hold (negedge CENegf1 &&& Check_A0_CENeg_negedge,A23,thold_A0_WENeg,Viol);

    $setup (DQ0    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ1    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ2    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ3    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ4    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ5    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ6    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ7    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ8    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ9    , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ10   , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ11   , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ12   , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ13   , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ14   , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ15   , posedge WENeg &&& Check_DQ0_WENeg_posedge,
        tsetup_DQ0_WENeg, Viol);

    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ0 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ1 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ2 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ3 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ4 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ5 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ6 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ7 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ8 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ9 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ10,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ11,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ12,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ13,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ14,
        thold_DQ0_WENeg, Viol);
    $hold (posedge WENeg &&& Check_DQ0_WENeg_posedge, DQ15,
        thold_DQ0_WENeg, Viol);

    $setup (DQ0    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ1    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ2    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ3    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ4    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ5    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ6    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ7    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ8    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ9    , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ10   , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ11   , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ12   , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ13   , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ14   , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);
    $setup (DQ15   , posedge CENegf1 &&& Check_DQ0_CENeg_posedge,
        tsetup_DQ0_WENeg, Viol);

    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ0 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ1 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ2 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ3 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ4 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ5 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ6 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ7 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ8 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ9 ,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ10,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ11,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ12,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ13,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ14,
        thold_DQ0_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_DQ0_CENeg_posedge, DQ15,
        thold_DQ0_WENeg, Viol);

    $setup (AVDNeg , negedge WENeg &&& Check_SetupHoldLow_AVDNeg ,
        tsetup_AVDNeg_WENeg, Viol);
    $hold (negedge WENeg &&& Check_SetupHoldLow_AVDNeg, AVDNeg ,
        thold_AVDNeg_WENeg , Viol);

    $setup (AVDNeg, posedge CLK &&& Check_SetupHoldLow_AVDNeg_CLK_posedge,
        tsetup_AVDNeg_CLK, Viol);
    $hold (posedge CLK &&& Check_SetupHoldLow_AVDNeg_CLK_posedge, AVDNeg,
        thold_AVDNeg_CLK, Viol);

    $setup (CENegf1, posedge CLK &&& Check_SetupHoldLow_CENeg_CLK_posedge,
        tsetup_CENegf1_CLK, Viol);

    $setup (CENegf1, negedge AVDNeg &&& Check_CENeg_AVDNeg,
        tsetup_CENegf1_AVDNeg, Viol);

    $setup (CENegf1  , negedge WENeg   &&& Check_No_Read,
        tsetup_CENegf1_WENeg, Viol);
    $setup (WENeg    , negedge CENegf1 &&& Check_No_Read,
        tsetup_CENegf1_WENeg, Viol);
    $hold (posedge WENeg   &&& Check_No_Read, CENegf1,
        thold_CENegf1_WENeg, Viol);
    $hold (posedge CENegf1 &&& Check_No_Read, WENeg  ,
        thold_CENegf1_WENeg, Viol);

    $hold (posedge WENeg   , OENeg &&& ~CENegf1  ,
        thold_WENeg_OENeg, Viol);
    $hold (posedge CENegf1 , OENeg &&& ~WENeg    ,
        thold_WENeg_OENeg, Viol);

    $setup (CLK    , negedge WENeg &&& Check_CLK_posedge,
        tsetup_CLK_WENeg, Viol);

    $hold (posedge RESETNeg &&& CENegf1, CENegf1,
        thold_CENegf1_RESETNeg, Viol);
    $hold (posedge RESETNeg &&& OENeg  , OENeg  ,
        thold_OENeg_RESETNeg, Viol);

    $width (negedge RESETNeg, tpw_RESETNeg_negedge);
    $width (negedge AVDNeg  , tpw_AVDNeg_negedge);
    $width (posedge WENeg   , tpw_WENeg_posedge);
    $width (negedge WENeg   , tpw_WENeg_negedge);
    $width (posedge CENegf1 , tpw_WENeg_posedge);
    $width (negedge CENegf1 , tpw_WENeg_negedge);
    $width (posedge CLK     , tpw_CLK_posedge);
    $width (negedge CLK     , tpw_CLK_negedge);
    $period(negedge CLK, tperiod_CLK);
    $period(posedge CLK, tperiod_CLK);

    endspecify

    //tdevice parameters aligned to model timescale
    //32bits exceeded
    time       tdevice_POW_ts     = tdevice_POW * 1000;
    time       tdevice_WBUF_ts    = tdevice_WBUF * 1000;
    //Sector Erase Operation    tWHWH2
    time       tdevice_SEO64KW_ts = tdevice_SEO64KW * 1000;
    time       tdevice_SEO16KW_ts = tdevice_SEO16KW * 1000;
    //program/erase suspend timeout
    time       tdevice_START_ts   = tdevice_START * 1000;
    //sector erase command sequence timeout
    time       tdevice_CTMOUT_ts  = tdevice_CTMOUT * 1000;
    //device ready after Hardware reset(during embeded algorithm)
    //Protection Bit Program
    time       tdevice_PROTP_ts   = tdevice_PROTP * 1000;
    //Protection Bit Erase
    time       tdevice_PROTE_ts   = tdevice_PROTE * 1000;
    //Password Unlock
    time       tdevice_UNLOCK_ts  = tdevice_UNLOCK * 1000;

    //Used as wait periods
    time       poweredupT_ts   = 100000;
    time       resetpulseT_ts  = 30000000;
    time       boundary66MHz_ts= 15151;
    time       perrpulseT_ts   = 1000000;
    time       eerrpulseT_ts   = 100000000;
    time       wepulseT_ts     = 3000;

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

    reg deq;
    //////////////////////////////////////////////////////////
    //          Output Data Gen
    //////////////////////////////////////////////////////////
    always @(DOut_zd)
    begin : OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            CEDQ_t = CENeg_event  + CEDQ_01;
            OEDQ_t = OENeg_event  + OEDQ_01;
            if ( ConfReg[15] == 1'b1 )
            //tACC relevant for asynchronous assecss time
                ADDRDQ_t = ADDR_event + ADDRDQ_01;
            else
            //tIACC relevant for synchronous assecss time
                ADDRDQ_t = ADDR_event + tdevice_TIACC_ts;

            FROMCE = ((CEDQ_t >= OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            if ((ADDRDQ_t > $time )&&
            (((ADDRDQ_t>OEDQ_t)&&FROMOE) ||
            ((ADDRDQ_t>CEDQ_t)&&FROMCE)))
            begin
                TempData = DOut_zd;
                DOut_Pass = 16'bx;
                DOut_Pass <= #( ADDRDQ_t - $time ) TempData;
            end
            else if ((OEDQ_t < $time && CEDQ_t < $time ) &&
            (ADDRDQ_t > $time ))
            begin
                if (ConfReg[15])
                begin
                    TempData = DOut_zd;
                    DOut_Pass <= #( ADDRDQ_t - $time ) TempData;
                end
                else
                    DOut_Pass = DOut_zd;
            end
            else
                DOut_Pass = DOut_zd;
        end
    end

    always @(DOut_zd)
    begin
        if (DOut_zd[0] === 1'bz)
        begin
            disable OutputGen;
            FROMCE = 1'b1;
            FROMOE = 1'b1;
            DOut_Pass = DOut_zd;
        end
    end
    //////////////////////////////////////////////////////////
    //          RDY Pin Value Gen
    //////////////////////////////////////////////////////////

    always @(RY_sync)
    begin
        if ( ConfReg[15] == 1'b0 && CENegf1 === 1'b0 )
        begin
            if (ConfReg[10])
                RY_zd = RY_sync;
            else
                RY_zd = ~RY_sync;
        end
    end

    always @(CENegf1)
    begin
        if (CENegf1 === 1'b0)
            RY_zd = ~ConfReg[10];
        else if (CENegf1 === 1'b1)
            RY_zd = 1'bz;
    end

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
        AdvanceT_bound[0]   = 62500;
        AdvanceT_bound[1]   = 60600;
        AdvanceT_bound[2]   = 55560;
        AdvanceT_bound[3]   = 50000;
        AdvanceT_nobound[0] = 50000;
        AdvanceT_nobound[1] = 45450;
        AdvanceT_nobound[2] = 37040;
        AdvanceT_nobound[3] = 25000;
        Period[0]           = 12500;
        Period[1]           = 15150;
        Period[2]           = 18520;
        Period[3]           = 25000;
    end

    integer TMindex;
    initial
    begin

            handle_string = TimingModel;
            for(TMindex=16;TMindex>=15;TMindex=TMindex-1)
            begin
                fetch_char = handle_string;
                handle_string = handle_string >> 8;
            end
            //TimingModel(15) specifies DYB boot option
            if (fetch_char == "0")
                dyb_boot_value = ~(0);
            else
                dyb_boot_value = 0;

            DYB = dyb_boot_value;

            for(TMindex=14;TMindex>=11;TMindex=TMindex-1)
            begin
                fetch_char = handle_string;
                handle_string = handle_string >> 8;
            end
            //TimingModel(11) specifies maximal supported frequency
            if (fetch_char == "S")
                frequency_supported = OS;
            else if (fetch_char == "P")
                frequency_supported = OP;
            else if (fetch_char == "L")
                frequency_supported = OL;

            ///////////////////////////////////////////////////////////////////
            //CFI array data / S29WS256N DEVICE SPECIFIC
            ///////////////////////////////////////////////////////////////////
            //CFI query identification string
            //device geometry definition
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
            //System interface string
            CFI_array[16'h1B] = 16'h17;
            CFI_array[16'h1C] = 16'h19;
            CFI_array[16'h1D] = 16'h00;
            CFI_array[16'h1E] = 16'h00;
            CFI_array[16'h1F] = 16'h06;
            CFI_array[16'h20] = 16'h09;
            CFI_array[16'h21] = 16'h0A;
            CFI_array[16'h22] = 16'h00;
            CFI_array[16'h23] = 16'h03;
            CFI_array[16'h24] = 16'h01;
            CFI_array[16'h25] = 16'h02;
            CFI_array[16'h26] = 16'h00;
            CFI_array[16'h27] = 16'h19;
            CFI_array[16'h28] = 16'h01;
            CFI_array[16'h29] = 16'h00;
            CFI_array[16'h2A] = 16'h06;
            CFI_array[16'h2B] = 16'h00;
            CFI_array[16'h2C] = 16'h03;
            CFI_array[16'h2D] = 16'h03;
            CFI_array[16'h2E] = 16'h00;
            CFI_array[16'h2F] = 16'h80;
            CFI_array[16'h30] = 16'h00;
            CFI_array[16'h31] = 16'hFD;
            CFI_array[16'h32] = 16'h00;
            CFI_array[16'h33] = 16'h00;
            CFI_array[16'h34] = 16'h02;
            CFI_array[16'h35] = 16'h03;
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
            CFI_array[16'h44] = 16'h34;
            CFI_array[16'h45] = 16'h100;//
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h00;
            CFI_array[16'h49] = 16'h08;
            CFI_array[16'h4A] = 16'hDF;
            CFI_array[16'h4B] = 16'h01;
            CFI_array[16'h4C] = 16'h00;
            CFI_array[16'h4D] = 16'h85;
            CFI_array[16'h4E] = 16'h95;
            CFI_array[16'h4F] = 16'h01;
            CFI_array[16'h50] = 16'h01;
            CFI_array[16'h51] = 16'h01;
            CFI_array[16'h52] = 16'h07;
            CFI_array[16'h53] = 16'h14;
            CFI_array[16'h54] = 16'h14;
            CFI_array[16'h55] = 16'h05;
            CFI_array[16'h56] = 16'h05;
            CFI_array[16'h57] = 16'h10;
            CFI_array[16'h58] = 16'h13;
            CFI_array[16'h59] = 16'h10;
            CFI_array[16'h5A] = 16'h10;
            CFI_array[16'h5B] = 16'h10;
            CFI_array[16'h5C] = 16'h10;
            CFI_array[16'h5D] = 16'h10;
            CFI_array[16'h5E] = 16'h10;
            CFI_array[16'h5F] = 16'h10;
            CFI_array[16'h60] = 16'h10;
            CFI_array[16'h61] = 16'h10;
            CFI_array[16'h62] = 16'h10;
            CFI_array[16'h63] = 16'h10;
            CFI_array[16'h64] = 16'h10;
            CFI_array[16'h65] = 16'h10;
            CFI_array[16'h66] = 16'h10;
            CFI_array[16'h67] = 16'h13;

            ASEL_array[16'h00] = 16'h0001;
            ASEL_array[16'h01] = 16'h227E;
            ASEL_array[16'h0E] = 16'h2230;
            ASEL_array[16'h0F] = 16'h2200;
            //For address 03h
            if (dyb_boot_value == 0)
                ASEL_03 = 16'h80;//"0000000010000000";
            else
                ASEL_03 = 16'h82;//"0000000010000010";
            ASEL_array[16'h03] = ASEL_03;
    end

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j;
    integer tmp1,tmp2,tmp3;
    integer secure_silicon[0:(SecSiSize-1)];
    integer base;
    reg     sector_prot[0:SecNum];

        for (i=0;i<=ADDRRange;i=i+1)
        begin
            Mem[i]=MaxData;
        end
        for (i=0;i<SecSiSize;i=i+1)
        begin
            secure_silicon[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            sector_prot[i]=1'b0;
        end
        if (UserPreload && !(prot_file_name == "none"))
        begin
        //s29ws256n  sector protect file
        //s29ws256n_prot.mem
        //    //   - comment
        //   @aa     - <aa> stands for sector identification 0..105
        //   If nothing specified the corresponding sector will be
        //   unprotected ( default ).
        //   Sector protected by delivered s29ws256n_prot.mem file are :
        //   SA = 1
        //   SA = 194 (C2h) and SA = 195 (C3h) or bank 11 to bank 12 cross
        //   SA = 229 (E5h)
        //   SA = 261 (105h) or the last memory sector
        //   NO empty lines
        //   Note that sector number length must be strictly 3
        //   ( 001 insted of 1 etc. )
        //
            $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
            //s29ws256n memory file
            //s29ws256n.mem
            //   //       - comment
            //   @aaaa    - <aaaa> stands for address
            //   dddd     - <dddd> is word to be written at Mem(aaaa++)
            //  (aaaa is incremented at every load)
            //  32 words region for BURST mode testing starts at 00B0
            //   NO EMPTY LINES
            //
            // preload sector 2 in bank 14 (229) with recognizable data
            // for burst read mode testing
            // address range to be filled is 00h to 1FFh
            //
            // Fill region near bank boundary 11//>12 with recognizable data
            // preload last sector in bank 11 (194) and first one in bank 12
            //  (195) for burst read mode with bank cross testing
            // address range to be filled is 16#FFE0# to 16#FFFF# for within
            // sector 194 and 16#00# to 16#FF# in sector 195
            // verify bank boundary read bahavior with crosses to busy and
            // non-busy bank
            //
            // preload last sector within last bank (15) with recognizable data
            // for burst read mode testing with memory wrap
            // address range to be filled is 3FE0h to 3FFFh
            //
            $readmemh(mem_file_name,Mem);
        end
        if (UserPreload && !(secsi_file_name == "none"))
        begin
        //s29ws256n SecSi preload file
        //s29ws_secsi memory file
        ////      - comment
        //@aa     - <aa> stands for address within last defined sector
        //dd      - <dd> is byte to be written at SecSi(aa++)
        // (aa is incremented at every load)
        // only first 1-5 columns are loaded. NO empty lines !
            $readmemh(secsi_file_name,secure_silicon);
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            Ers_queue[i] = 0;
            PPB[i] = !sector_prot[i];
        end
        WData = 0;
        WAddr = -1;

        //SecSi Preload
        for (i=0;i<SecSiSize;i=i+1)
        begin
            SecSi[i] = secure_silicon[i];
        end
    end

    //Power Up time 100 ns;
    initial
    begin
        PoweredUp = 1'b0;
        #poweredupT_ts PoweredUp = 1'b1;
    end

    always @(negedge RESETNeg)
    begin : RST_falling_edge
        #resetpulseT_ts RST <= 1'b0;
    end

    always @(posedge RESETNeg)
    begin
        disable RST_falling_edge;
        #1;
        RST <= 1'b1;
    end

    initial
    begin
        WRITE    = 1'b1;
        READ     = 1'b1;
        READ_A   = 1'b1;
        ReadINIT = 1'b1;
        BURST    = 1'b1;

        ULBYPASS = 1'b0;
        ESP_ACT  = 1'b0 ;
        PSP_ACT = 1'b0;
        LOCK_ACT = 1'b0;

        PDONE    = 1'b1;
        PSTART   = 1'b0;
        PSTART   = 1'b0;
        PSUSP    = 1'b0;
        PERR     = 1'b0;

        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;
        EERR     = 1'b0;

        Ers_queue = 0;

        InitL = 1;
        InitH = 1;
        R = 0;
        E = 0;

        OENeg_event = 0;
        CENeg_event = 0;
        ADDR_event = 0;

        READ_MODE = NO_SYNC;

        ConfReg = 16'b1110111111001000;
        BankERASE = 0;
        LockReg = ~(0);
        DYB = dyb_boot_value;
        for(i=0;i<=3;i=i+1)
            Password[i] = MaxData;
        PPBLock = 1'b1;
    end

    always @(posedge START_T1_in)
    begin:TESTARTT1r
        #(tdevice_START_ts-1) START_T1 = START_T1_in;
    end
    always @(negedge START_T1_in)
    begin:TESTARTT1f
        #1 START_T1 = START_T1_in;
    end

    always @(posedge CTMOUT_in)
    begin:TCTMOUTr
        #tdevice_CTMOUT_ts CTMOUT = CTMOUT_in;
    end
    always @(negedge CTMOUT_in)
    begin:TCTMOUTf
        #1 CTMOUT = CTMOUT_in;
    end

    // Protection Bit Program
    always @(posedge PBPROG_in)
    begin : ProtProgTime
        #(tdevice_PROTP_ts - 1) PBPROG_out = 1'b1;
    end
    always @(negedge PBPROG_in)
    begin
        disable ProtProgTime;
        PBPROG_out = 1'b0;
    end
    // Protection Bit Erase
    always @(posedge PBERASE_in)
    begin : ProtEraseTime
    time EraseSIM;
        if ( LongTiming )
            EraseSIM = tdevice_PROTE_ts;
        else
            EraseSIM = tdevice_PROTE_ts / 100;
        #(EraseSIM - 1) PBERASE_out = 1'b1;
    end
    always @(negedge PBERASE_in)
    begin
        disable ProtEraseTime;
        PBERASE_out = 1'b0;
    end
    // Password Unlock
    always @(posedge UNLOCKDONE_in)
    begin : UnlockTime
        #(tdevice_UNLOCK_ts - 1) UNLOCKDONE_out = 1'b1;
    end
    always @(negedge UNLOCKDONE_in)
    begin
        disable UnlockTime;
        UNLOCKDONE_out = 1'b0;
    end
    //Initial Access
    always @(posedge TIACC_in)
    begin : AccessTime
        #(tdevice_TIACC_ts - 1) TIACC_out = 1'b1;
    end
    always @(negedge TIACC_in)
    begin
        disable AccessTime;
        TIACC_out = 1'b0;
    end
    //Configurationregister14
    always @(posedge NoRowBound_in)
    begin : CR14_OPTION
        #boundary66MHz_ts NoRowBound_out = 1'b1;//66MHz
    end
    always @(negedge NoRowBound_in)
    begin
        disable CR14_OPTION;
        NoRowBound_out = 1'b0;
    end
    ///////////////////////////////////////////////////////////////////////////
    ////     obtain 'LAST_EVENT information
    ///////////////////////////////////////////////////////////////////////////
    always @(negedge OENeg)
    begin
        OENeg_event = $time;
    end
    always @(negedge CENegf1)
    begin
        CENeg_event = $time;
    end

    ///////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ///////////////////////////////////////////////////////////////////////////

always @(negedge RESETNeg)
begin
    if (PoweredUp)
    begin
        Glitch = 1'b0;
        HWResetStart = 1'b1;
        HWResetStart <= #1 1'b0;
        current_state = HW_RESET_INIT;
    end
    else
    begin
        current_state = RESET;
        reseted = 1'b0;
    end
end

always @(posedge RESETNeg)
begin
    if (PoweredUp)
    begin
        if ( RST === 1'b1 )
        begin
            Glitch = 1'b1;
            HWResetGlitch = 1'b1;
            HWResetGlitch <= #1 1'b0;
        end
    end
    else
    begin
        current_state = RESET;
        reseted = 1'b0;
    end
end

always @(negedge RST)
begin
    if ( RESETNeg === 1'b0 )
    begin
        current_state = RESET;
        reseted = 1'b0;
    end
end

always @(next_state, RESETNeg, RST, PoweredUp)
begin
    if (PoweredUp)
    begin
        if ( RESETNeg === 1'b1 )
        begin
            current_state = next_state;
            reseted = 1'b1;
        end
    end
    else
    begin
        current_state = RESET;
        reseted = 1'b0;
    end
end

//    /////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    /////////////////////////////////////////////////////////////////////////
    assign #wepulseT_ts gWE_n = WENeg_ipd;
    assign gCE_n = CENegf1_ipd;
    assign gOE_n = OENeg_ipd;

//  CLK Gen - ConfigurationRegister dependant
    always @(CLK)
    begin
        CLKMerge = CLK;
    end

//    /////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    /////////////////////////////////////////////////////////////////////////

    always @(posedge AVDNeg)
    begin
        if ( ~CENegf1 && WENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        // Synchronous AVD# rising edge address latch
        if ( gWE_n && ~gCE_n && ~LATCHED &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            READCYCLE = 1'b1;
            LATCHED = 1'b1;
            AddressLatched = A;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            Addr =  AddressLatched - AddrLO;
            BurstDelay = 1;
            SetTM = 1'b1;
        end
    end

    always @(negedge AVDNeg)
    begin
        LATCHED  = 1'b0;
        READCYCLE = 1'b0;
        WRITECYCLE = 1'b0;
        SetTM = 1'b0;
        ConcurrentREAD = 1'b0;
        if ( ~CENegf1 && WENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
        end
        RY_sync = 1'b0;
    end

    always @(posedge CLKMerge)
    begin
        //Initiate READ (Burst mode)
        if ( READCYCLE &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            READCYCLE = 1'b0;
            if (SetTM)
            begin
                ADDR_event = $time;
                TIACC_in = 1'b0;
                TIACC_in <= #1 1'b1;
                ConcurrentREAD = 1'b1;
                if ( OENeg == 1'b0 && CENegf1 == 1'b0 )
                begin
                    READ = 1'b0;
                    #1 READ <= 1'b1;
                end
            end
            BURST = 1'b0;
            #1 BURST <= 1'b1;
        end
        // Synchronous CLK active edge address latch
        if ( gWE_n && ~gCE_n && ~AVDNeg && ~LATCHED &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            READCYCLE = 1'b1;
            LATCHED = 1'b1;
            AddressLatched = A;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            Addr =  AddressLatched - AddrLO;
            BurstDelay =0;
            SetTM = 1'b0;
            ADDR_event = $time;
            TIACC_in = 1'b0;
            TIACC_in <= #1 1'b1;
            if ( ~OENeg && ~CENegf1 )
            begin
                READ = 1'b0;
                #1 READ <= 1'b1;
            end
        end
        if (( reseted==1'b1 && ConfReg[15] == 1'b0 ) && ConcurrentREAD )
            ConcurrentREAD = 1'b0;
    end

    always @(A)
    begin
        if ( ~AVDNeg && ~CENegf1 && WENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
            // tACC count
            ADDR_event = $time;
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        if ( WENeg && ~CENegf1 && ~OENeg && ~AVDNeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
        // Initiate READ
            ADDR_event = $time;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr = AddressLatched - AddrLO;
            READ_A = 1'b0;
            READ = 1'b0;
            #1 READ_A <= 1'b1;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge OENeg)
    begin
        if ( ~AVDNeg && ~CENegf1 && WENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        if ( WENeg && ~CENegf1 && reseted==1'b1 )
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge CENegf1)
    begin
        if ( ~AVDNeg && ~OENeg && WENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        if ( WENeg && ~CENegf1 && ~OENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(posedge gWE_n)
    begin
        if ( RESETNeg != 1'b0 && ~gCE_n && OENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
        // WRITE operation
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
        // Synchronous WRITE operation data latch
        if ( ~gCE_n && WRITECYCLE && gOE_n && RESETNeg != 1'b0 &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            WRITECYCLE = 1'b0;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
    end

    always @(posedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 && ~gWE_n && OENeg
        && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
        // WRITE operation
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
        // Synchronous WRITE operation data latch
        if ( ~gWE_n && WRITECYCLE && gOE_n && RESETNeg != 1'b0 &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            WRITECYCLE = 1'b0;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            Addr =  AddressLatched - AddrLO;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
    end
    always @(negedge gWE_n or negedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 &&
            ~gCE_n && ~gWE_n && OENeg && ~AVDNeg
            && reseted==1'b1 && ConfReg[15] == 1'b1 )
        begin
            AddressLatched = A;
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
        end
        if ( ~gCE_n && ~gWE_n && OENeg && READCYCLE &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            READCYCLE = 1'b0;
            WRITECYCLE = 1'b1;
        end
        // Asynchronous WRITE cycle Address Latch
        // Supported in synchronous mode
        if ( ~gCE_n && ~gWE_n && gOE_n && ~AVDNeg &&
        reseted==1'b1 && ConfReg[15] == 1'b0 )
        begin
            READCYCLE = 1'b0;
            WRITECYCLE = 1'b1;
            LATCHED = 1'b1;
            AddressLatched = A;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            SecLatched = ReturnSectorID(AddressLatched);
            ADDRHILO(AddrLO, AddrHI, SecLatched);
            Addr =  AddressLatched - AddrLO;
        end
    end

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program Operation
//    // start/ suspend/ resume
//    /////////////////////////////////////////////////////////////////////////

event pdone_event;
time elapsed_write;
time duration_write;
time start_write;
time pow;

    always @(posedge reseted)
    begin
        disable pdone_process;
        PDONE = 1'b1;
    end

    always @(reseted or PSTART)
    begin
        if ( WB_FLAG )
            duration_write = (Cnt_WriteBuffer+1) * tdevice_WBUF_ts;
        else
            duration_write = tdevice_POW_ts;

        if (reseted)
        begin
            if (PSTART && PDONE)
            begin
                if (((DYB[SA] && PPB[SA] &&
                (~Ers_queue[SA] || ~ESP_ACT)) ||
                (SA == 0 && BankMODE == SecSiENABLED) ||
                (BankID == 0 && BankMODE == PasswordENABLED) ||
                PGMS_FLAG == LREG) &&//Handle Lock Register Program
                ACC &&
                ~(~WPNeg && (SA <= 3 || SA >= SecNum-3)) &&
                ~ (BankMODE == SecSiENABLED && BankID == 0 && (
                // SecSi Sector Factory Region Protected
                (SSWAddr < 16'h80 ||
                // SecSi Sector Customer Region protection check
                (SSWAddr >= 16'h80 && ~LockReg[0])))) &&
                ~(BankMODE == PasswordENABLED && BankID == 0 && ~LockReg[2]))
                begin
                    PDONE = 1'b0;
                    start_write = $time;
                    ->pdone_event;
                end
                else
                begin
                    PERR = 1'b1;
                    PERR <= #perrpulseT_ts 1'b0;
                end
            end
        end
    end

    always @(pdone_event)
    begin:pdone_process
        PDONE = 1'b0;
        #duration_write PDONE = 1'b1;
    end

    always @(reseted or PSUSP)
    begin
        if (reseted)
            if (PSUSP && ~PDONE)
            begin
                disable pdone_process;
                elapsed_write = $time - start_write;
                duration_write = duration_write - elapsed_write;
                PDONE = 1'b0;
            end
    end

    always @(reseted or PRES)
    begin
        if (reseted)
            if (PRES && ~PDONE)
            begin
                start_write = $time;
                PDONE = 1'b0;
                ->pdone_event;
            end
    end

//    /////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    /////////////////////////////////////////////////////////////////////////
integer cnt_erase = 0;      // 0 - SecNum+SubSecNum
time elapsed_erase;
time duration_erase;
time start_erase;
time seoSMALL;
time seoLARGE;

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
                if ( LongTiming )
                begin
                    seoSMALL  = tdevice_SEO16KW_ts;
                    seoLARGE  = tdevice_SEO64KW_ts;
                end
                else
                begin
                    seoSMALL  = tdevice_SEO16KW_ts/10000;
                    seoLARGE  = tdevice_SEO64KW_ts/10000;
                end
                cnt_erase = 0;
                duration_erase = 0;
                for (i=0;i<=SecNum;i=i+1)
                    if ( Ers_queue[i] &&
                    DYB[i] && PPB[i] &&
                    ~(~WPNeg && (i <= 3 || i >= SecNum-3)) &&
                    ACC &&
                    ~(i<SecNum_bank0 && BankMODE != RESET))
                    begin
                        cnt_erase = cnt_erase +1;
                        if ( i <= 3 || i >= SecNum-3 )
                            duration_erase = duration_erase + seoSMALL;
                        else
                            duration_erase = duration_erase + seoLARGE;
                    end

                if (cnt_erase>0)
                begin
                    elapsed_erase = 0;
                    ->edone_event;
                    start_erase = $time;
                end
                else
                begin
                    EERR = 1'b1;
                    EERR <= #eerrpulseT_ts 1'b0;
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

    //WRITE CYCLE
    always @(negedge WRITE or reseted or negedge BURST)
    begin: StateGen0
        if (~WRITE)
        begin
            Data      = D_tmp;
            DataLo    = D_tmp % 12'h100;
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end
        BURST_TR = 1'b0;
        SYNCREAD = 1'b0;
        if (reseted!=1'b1)
            next_state = current_state;
        else if (~WRITE || ~BURST)
            case (current_state)
            RESET :
            begin
                if (~WRITE)
                begin
                    if (PATTERN_1)
                        next_state = Z001;
                    // Check if Bank0 Enabled !!!
                    else if ((A_PAT_1 && (DataLo==16'h98)) &&
                    ACCEPT(1'b1))
                        next_state = CFI;
                    else if ( BankMODE == PasswordENABLED )
                    begin
                        if (DataLo == 16'hA0)
                            next_state = PASS_A0SEEN;
                        else if ((Addr % 16'h100 == 16'h00) &&
                        (DataLo == 16'h25))
                            next_state = PASSUNLOCK1;
                        else if (DataLo == 16'h90)
                            next_state = EXIT_BankMODE;
                    end
                    else
                        next_state = RESET;
                end
                else if (~BURST)
                begin
                    if ( BankMODE != RESET )
                    begin
                        SYNCREAD = ( BankID == 0 && BankMODE != SecSiENABLED);
                        BURST_TR = ~SYNCREAD;
                    end
                    else
                        BURST_TR = 1'b1;
                end
            end

            Z001 :
            begin
                if (~WRITE)
                begin
                    if (PATTERN_2)
                        next_state = PREL_SETBWB;
                    else
                        next_state = RESET;
                end
            end

            PREL_SETBWB :
            begin
                if (~WRITE)
                begin
                    if (A_PAT_1 && (DataLo == 16'h90) &&
                    ACCEPT(1'b1))
                        next_state = AS;
                    else if (A_PAT_1 && (DataLo == 16'hA0))
                    begin
                        if ( BankMODE == SecSiENABLED && BankID == 0 )
                            next_state = SECSI_A0SEEN;
                        else
                            next_state = A0SEEN;
                    end
                    else if (A_PAT_1 && (DataLo == 16'h80))
                        next_state = C8;
                    else if (A_PAT_1 && (DataLo == 16'hC6))
                        next_state = CR_READ;
                    else if (A_PAT_1 && (DataLo == 16'hD0))
                        next_state = CR_WRITE;
                    else if (A_PAT_1 && (DataLo == 16'h20) &&
                    BankMODE == RESET)
                        next_state = PREL_ULBYPASS;
                    else if (A_PAT_1 && (DataLo == 16'h88) &&
                    BankMODE == RESET)
                    begin
                        next_state = RESET;
                        BankMODE = SecSiENABLED;
                    end
                    else if (A_PAT_1 && (DataLo == 16'h40) &&
                    BankMODE == RESET)
                    begin
                        next_state = LOCKREG_CMDSET;
                        LOCK_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && (DataLo == 16'h60) &&
                    BankMODE == RESET)
                    begin
                        next_state = RESET;
                        BankMODE = PasswordENABLED;
                    end
                    else if (A_PAT_1 && (DataLo == 16'h50) &&
                    BankMODE == RESET)
                    begin
                        next_state = PPBLOCK_CMDSET;
                    end
                    else if (A_PAT_1 && (DataLo == 16'hC0) &&
                    BankMODE == RESET)
                        next_state = PPB_CMDSET;
                    else if (A_PAT_1 && (DataLo == 16'hE0) &&
                    BankMODE == RESET)
                        next_state = DYB_CMDSET;
                    else if (A_PAT_1 && (DataLo == 16'h90) &&
                    BankMODE == SecSiENABLED)
                            next_state = EXIT_BankMODE;
                    else if ((DataLo == 16'h25) &&
                    ACCEPT(1'b0))
                            next_state = WBPGMS_WBCNT;
                    else
                        next_state = RESET;
                end
            end

            PREL_ULBYPASS  :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hA0)
                        next_state = A0SEEN;
                    else if (DataLo == 16'h98)
                        next_state = UBP_CFI;
                    else if (DataLo == 16'h90 )
                        next_state = EXIT_ULBYPASS;
                    else if ((DataLo == 16'h25) &&
                    ACCEPT(1'b1))
                        next_state = WBPGMS_WBCNT;
                    else
                        next_state = PREL_ULBYPASS;
                end
                else if (~BURST)
                    BURST_TR = 1'b1;
            end

            EXIT_ULBYPASS :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            EXIT_BankMODE :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h00)
                        BankMODE = RESET;
                    next_state = RESET;
                end
            end

            CFI :
            begin
                if ((~WRITE) && (DataLo == 16'hF0))
                    next_state = RESET;
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID==BankCFI || ~ACCEPT(1'b0) );
                    BURST_TR = ~SYNCREAD;
                end
            end

            UBP_CFI :
            begin
                if ((~WRITE) && (DataLo == 16'hF0))
                    next_state = PREL_ULBYPASS;
                else if (~BURST)
                begin
                    SYNCREAD = BankID==BankCFI;
                    BURST_TR = ~SYNCREAD;
                end
            end

            AS :
            begin
                if ((~WRITE) && (DataLo == 16'hF0))
                    next_state = RESET;
                else if (~BURST)
                begin
                    SYNCREAD = (BankID==BankASEL || ~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            CR_READ :
            begin
                if ((~WRITE) && (DataLo == 16'hF0))
                    next_state = RESET;
                else if (~BURST)
                    SYNCREAD = 1'b1;
            end

            CR_WRITE :
            begin
                if (~WRITE)
                    next_state = EXIT_CR;
            end

            EXIT_CR :
            begin
                if ((~WRITE) && (DataLo == 16'hF0))
                    next_state = RESET;
            end

            LOCKREG_CMDSET :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hA0)
                        next_state = LOCKREG_A0SEEN;
                    else if (DataLo == 16'h90)
                        next_state = EXIT_LOCKREG;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == 0 && Addr == 16'h77);
                    BURST_TR = ( BankID != 0 );
                end
            end

            LOCKREG_A0SEEN :
            begin
                if (~WRITE)
                begin
                    tempLR_t = Data;
                    if (((Addr % 16'h100) == 16'h77) &&
                    ~(tempLR_t[1] == 1'b0 && tempLR_t[2] == 1'b0))
                        next_state = PGMS;
                    else
                        next_state = LOCKREG_CMDSET;
                end
            end

            EXIT_LOCKREG :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h00)
                    begin
                        next_state = RESET;
                        LOCK_ACT = 1'b0;
                    end
                    else
                        next_state = LOCKREG_CMDSET;
                end
            end

            PPB_CMDSET :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hA0)
                        next_state = PPB_A0SEEN;
                    else if (DataLo == 16'h80)
                        next_state = PPB_80SEEN;
                    else if (DataLo == 16'h90)
                        next_state = EXIT_PPB;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankPPB );
                    BURST_TR = ~SYNCREAD;
                end
            end

            PPB_A0SEEN :
            begin
                if (~WRITE)
                begin
                    if ( BankID == BankPPB && (DataLo == 16'h00))
                        next_state = PPB_PROG;
                    else
                        next_state = PPB_CMDSET;
                end
            end

            PPB_PROG :
            begin
                if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankPPB );
                    BURST_TR = ~SYNCREAD;
                end
            end

            PPB_80SEEN :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h30)
                        next_state = PPB_ERS;
                    else
                        next_state = PPB_CMDSET;
                end
            end

            PPB_ERS :
            begin
                if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankPPB );
                    BURST_TR = ~SYNCREAD;
                end
            end

            EXIT_PPB :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h00)
                    begin
                        if ( PSP_ACT == 1'b1 )
                            next_state = PSP;
                        else if ( ESP_ACT == 1'b1 )
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else
                    begin
                        if ( PSP_ACT == 1'b1 )
                            next_state = PSP_PPB;
                        else if ( ESP_ACT == 1'b1 )
                            next_state = ESP_PPB;
                        else
                            next_state = PPB_CMDSET;
                    end
                end
            end

            DYB_CMDSET :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hA0)
                        next_state = DYB_SETCLEAR;
                    else if (DataLo == 16'h90)
                        next_state = EXIT_DYB;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankDYB );
                    BURST_TR = ~SYNCREAD;
                end
            end

            DYB_SETCLEAR :
            begin
                if (~WRITE)
                    next_state = DYB_CMDSET;
            end

            EXIT_DYB :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h00)
                    begin
                        if ( PSP_ACT == 1'b1 )
                            next_state = PSP;
                        else if ( ESP_ACT == 1'b1 )
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else
                    begin
                        if ( PSP_ACT == 1'b1 )
                            next_state = PSP_DYB;
                        else if ( ESP_ACT == 1'b1 )
                            next_state = ESP_DYB;
                        else
                            next_state = DYB_CMDSET;
                    end
                end
            end

            PPBLOCK_CMDSET :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hA0)
                        next_state = PPBLOCK_SET;
                    else if (DataLo == 16'h90)
                        next_state = EXIT_PPBLOCK;
                end
                if (~BURST)
                begin
                    SYNCREAD = (BankID == BankPPBLOCK);
                    BURST_TR = (~SYNCREAD);
                end
            end

            PPBLOCK_SET :
            begin
                if (~WRITE)
                    next_state = PPBLOCK_CMDSET;
            end

            EXIT_PPBLOCK :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h00)
                    begin
                        if (PSP_ACT == 1'b1)
                            next_state = PSP;
                        else if (ESP_ACT == 1'b1)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else
                    begin
                        if (PSP_ACT == 1'b1)
                            next_state = PSP_PPBLOCK;
                        else if (ESP_ACT == 1'b1)
                            next_state = ESP_PPBLOCK;
                        else
                            next_state = PPBLOCK_CMDSET;
                    end
                end
            end

            PASS_A0SEEN :
            begin
                if (~WRITE)
                begin
                    next_state = PGMS;
                end
            end

            PASSUNLOCK1 :
            begin
                if (~WRITE)
                begin
                    if ((Addr % 16'h100 == 16'h00) && (DataLo == 16'h03))
                        next_state = PASSUNLOCK2;
                    else
                        next_state = RESET;
                end
            end

            PASSUNLOCK2 :
            begin
                if (~WRITE)
                    next_state = PASSUNLOCK3;
            end

            PASSUNLOCK3 :
            begin
                if (~WRITE)
                    next_state = PASSUNLOCK4;
            end

            PASSUNLOCK4 :
            begin
                if (~WRITE)
                    next_state = PASSUNLOCK5;
            end

            PASSUNLOCK5 :
            begin
                if (~WRITE)
                    next_state = PASSUNLOCK6;
            end

            PASSUNLOCK6 :
            begin
                if (~WRITE)
                begin
                    if (( Addr % 16'h100 == 16'h00 ) && DataLo == 16'h29)
                        next_state = PASSUNLOCK;
                    else
                        next_state = RESET;
                end
            end

            PASSUNLOCK :
            begin
            end

            SECSI_A0SEEN :
            begin
                if (~WRITE)
                    next_state = PGMS;
            end

            A0SEEN         :
            begin
                if (~WRITE)
                begin
                    if (ACCEPT(1'b0))
                        next_state = PGMS;
                    else
                        next_state = RESET;
                end
            end

            C8 :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_1 )
                        next_state = C8_Z001;
                    else
                        next_state = RESET;
                end
            end

            C8_Z001        :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_2 )
                        next_state = C8_PREL;
                    else
                        next_state = RESET;
                end
            end

            C8_PREL        :
            begin
                if (~WRITE)
                begin
                    if ( A_PAT_1 && DataLo == 16'h10)
                        next_state = ERS;
                    else if ( DataLo == 16'h30 )
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
            end

            ERS :
            begin
                if (~BURST)
                    SYNCREAD = 1'b1;
            end

            SERS           :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hB0 && BankERASE[BankID] == 1'b1)
                        next_state = ESP;
                    else if (DataLo == 16'h30)
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
                if (~BURST)
                begin
                    SYNCREAD = ( BankERASE[BankID] == 1'b1 || ~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESPS           :
            begin
                if (~BURST)
                begin
                    SYNCREAD = BankERASE[BankID] == 1'b1 || ~ACCEPT(1'b0);
                    BURST_TR = ~SYNCREAD;
                end
            end

            SERS_EXEC :
            begin
                if ( EERR != 1'b1 )
                begin
                    if (~WRITE)
                    begin
                        if ( DataLo == 16'hB0 && BankERASE[BankID] == 1'b1 )
                            next_state = ESPS;
                    end
                end
                if (~BURST)
                begin
                    SYNCREAD = (BankERASE[BankID] == 1'b1 ||~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h30 && BankERASE[BankID] == 1'b1 )
                        next_state = SERS_EXEC;
                    else if (( Addr % 16'h100 == 16'h55) &&
                    DataLo == 16'h98 && ACCEPT(1'b1))
                        next_state = ESP_CFI;
                    else if ( PATTERN_1 )
                        next_state = ESP_Z001;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ((BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1) ||
                    ~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_Z001 :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_2 )
                        next_state = ESP_PREL;
                    else
                        next_state = ESP;
                end
            end

            ESP_PREL :
            begin
                if (~WRITE)
                begin
                    if ( A_PAT_1 && DataLo == 16'hA0 )
                        next_state = ESP_A0SEEN;
                    else if ( A_PAT_1 && DataLo == 16'h90 &&
                    ACCEPT(1'b1))
                        next_state = ESP_AS;
                    else if ( A_PAT_1 && DataLo == 16'h88 &&
                    BankMODE == RESET )
                    begin
                        next_state = ESP_OTP;
                        BankMODE = SecSiENABLED;
                    end
                    else if ( A_PAT_1 && DataLo == 16'hC0 &&
                    BankMODE == RESET )
                        next_state = ESP_PPB;
                    else if ( A_PAT_1 && DataLo == 16'hE0 &&
                    BankMODE == RESET )
                        next_state = ESP_DYB;
                    else if ( A_PAT_1 && DataLo == 16'h50 &&
                    BankMODE == RESET )
                        next_state = ESP_PPBLOCK;
                    else if ( DataLo == 16'h25 && Ers_queue[SecAddr] == 1'b0 &&
                    ACCEPT(1'b0))
                        next_state = WBPGMS_WBCNT;
                    else
                        next_state = ESP;
                end
            end

            ESP_CFI :
            begin
                if ((~WRITE) && DataLo == 16'hF0)
                        next_state = ESP;
                else if (~BURST)
                begin
                    SYNCREAD = (BankID == BankCFI || ((BankID != BankCFI) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_A0SEEN :
            begin
                if (~WRITE)
                begin
                    if ( Ers_queue[SecAddr] == 1'b0 &&
                    ACCEPT(1'b0))
                        next_state = PGMS;
                    else
                        next_state = ESP;
                end
            end

            ESP_AS :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'hF0 )
                        next_state = ESP;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankASEL || ((BankID != BankASEL) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_PPB :
            begin
                if ((~WRITE) && DataLo == 16'h90)
                    next_state = EXIT_PPB;
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankPPB || ((BankID != BankPPB) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_DYB :
            begin
                if ((~WRITE) && DataLo == 16'h90)
                    next_state = EXIT_DYB;
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankDYB || ((BankID != BankDYB) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_PPBLOCK :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h90)
                        next_state = EXIT_PPBLOCK;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ((BankID == BankPPBLOCK) ||
                    ((BankID != BankPPBLOCK) && BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1));
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_OTP :
            begin
                if ((~WRITE) && PATTERN_1)
                    next_state = ESP_OTP_Z001;
                else if (~BURST)
                begin
                    SYNCREAD = (BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1);
                    BURST_TR = ~SYNCREAD;
                end
            end

            ESP_OTP_Z001 :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_2 )
                        next_state = ESP_OTP_PREL;
                    else
                        next_state = ESP_OTP;
                end
            end

            ESP_OTP_PREL :
            begin
                if (~WRITE)
                begin
                    if  ( DataLo == 16'h90 )
                        next_state = ESP_OTP_EXIT;
                    else
                        next_state = ESP_OTP;
                end
            end

            ESP_OTP_EXIT :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h00 )
                    begin
                        next_state = ESP;
                        BankMODE = RESET;
                    end
                    else
                        next_state = ESP_OTP;
                end
            end

            PGMS :
            begin

                if ((~WRITE) && PERR != 1'b1)
                begin
                    if ( DataLo == 16'hB0 && BankPROGRAM == BankID )
                        next_state = PSPS;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankPROGRAM ||
                    ((BankID != BankPROGRAM) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSPS           :
            begin
                if (~BURST)
                begin
                    SYNCREAD = (BankID == BankPROGRAM ||
                    ((BankID != BankPROGRAM) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP            :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h30 && BankID == BankPROGRAM )
                        next_state = PGMS;
                    else if (( Addr % 16'h100 == 16'h55 || ULBYPASS == 1'b1) &&
                    DataLo == 16'h98 && ACCEPT(1'b1))
                        next_state = PSP_CFI;
                    else if ( PATTERN_1 )
                        next_state = PSP_Z001;
                end
                else if (~BURST)
                begin
                    SYNCREAD = (SecAddr == SA ||
                    ((BankID != BankPROGRAM) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP_Z001       :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_2 )
                        next_state = PSP_PREL;
                    else
                        next_state = PSP;
                end
            end

            PSP_PREL :
            begin
                if (~WRITE)
                begin
                    if ( A_PAT_1 && DataLo == 16'h90 &&
                    ACCEPT(1'b1))
                        next_state = PSP_AS;
                    else if ( A_PAT_1 && DataLo == 16'h88 &&
                    BankMODE == RESET)
                    begin
                        next_state = PSP_OTP;
                        BankMODE = SecSiENABLED;
                    end
                    else if ( A_PAT_1 && DataLo == 16'hC0 &&
                    BankMODE == RESET )
                        next_state = PSP_PPB;
                    else if ( A_PAT_1 && DataLo == 16'hE0 &&
                    BankMODE == RESET )
                        next_state = PSP_DYB;
                    else if ( A_PAT_1 && DataLo == 16'h50 &&
                    BankMODE == RESET )
                        next_state = PSP_PPBLOCK;
                    else
                        next_state = PSP;
                end
            end

            PSP_CFI        :
            begin
                if ((~WRITE) && DataLo == 16'hF0)
                        next_state = PSP;
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankCFI || ((BankID != BankCFI) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ ACCEPT(1'b0) || SecAddr == SA);
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP_AS :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hF0)
                        next_state = PSP;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankASEL || ((BankID != BankASEL) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ ACCEPT(1'b0) || SecAddr == SA);
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP_PPB :
            begin
                if ((~WRITE) && DataLo == 16'h90)
                    next_state = EXIT_PPB;
                else if (~BURST)
                begin
                    SYNCREAD = (BankID == BankPPB || ((BankID != BankPPB) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    SecAddr == SA);
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP_DYB :
            begin
                if ((~WRITE) && DataLo == 16'h90)
                    next_state = EXIT_DYB;
                else if (~BURST)
                begin
                    SYNCREAD = (BankID == BankDYB || ((BankID != BankDYB) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    SecAddr == SA);
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP_PPBLOCK :
                if (~WRITE)
                begin
                    if (DataLo == 16'h90)
                        next_state = EXIT_PPBLOCK;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ((BankID == BankPPBLOCK) ||
                    ((BankID != BankPPBLOCK) && (BankERASE[BankID] == 1'b1) &&
                    (Ers_queue[SecAddr] == 1'b1)) || (SecAddr == SA));
                    BURST_TR = ~SYNCREAD;
                end

            PSP_OTP :
            begin
                if ((~WRITE) && PATTERN_1)
                    next_state = PSP_OTP_Z001;
                else if (~BURST)
                begin
                    SYNCREAD = ((BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1) || SecAddr == SA);
                    BURST_TR = ~SYNCREAD;
                end
            end

            PSP_OTP_Z001 :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_2 )
                        next_state = PSP_OTP_PREL;
                    else
                        next_state = PSP_OTP;
                end
            end

            PSP_OTP_PREL :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h90 )
                        next_state = PSP_OTP_EXIT;
                    else
                        next_state = PSP_OTP;
                end
            end

            PSP_OTP_EXIT :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h00 )
                    begin
                        next_state = PSP;
                        BankMODE = RESET;
                    end
                    else
                        next_state = PSP_OTP;
                end
            end

            WBPGMS_WBCNT  :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) && (DataLo < 32) &&
                    (StartAddress_WriteBuffer == Addr))
                        next_state = WBPGMS_WBLSTA;
                    else
                        next_state = WBPGMS_WBABORT;
                end
            end

            WBPGMS_WBLSTA :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) &&
                    (StartAddress_WriteBuffer == Addr))
                    begin
                        if (LCNT > 0)
                            next_state = WBPGMS_WBLOAD;
                        else
                            next_state = WBPGMS_CONFB;
                    end
                    else
                        next_state = WBPGMS_WBABORT;
                end
            end

            WBPGMS_WBLOAD :
            begin
                if (~WRITE)
                begin
                    if (((Addr / 32) == PA_WriteBuffer) &&
                    ( SecAddr == SA_WriteBuffer ))
                    begin
                        if (LCNT > 0)
                            next_state = WBPGMS_WBLOAD;
                        else
                            next_state = WBPGMS_CONFB;
                    end
                    else
                        next_state = WBPGMS_WBABORT;
                end
            end

            WBPGMS_CONFB  :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) && (DataLo == 16'h29))
                        next_state = PGMS;
                    else
                        next_state = WBPGMS_WBABORT;
                end
            end

            WBPGMS_WBABORT:
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_1 )
                        next_state = WBPGMS_Z001;
                end
                else if (~BURST)
                begin
                    SYNCREAD = ( BankID == BankPROGRAM ||
                    ((BankID != BankPROGRAM) &&
                    BankERASE[BankID] == 1'b1 && Ers_queue[SecAddr] == 1'b1) ||
                    ~ACCEPT(1'b0));
                    BURST_TR = ~SYNCREAD;
                end
            end

            WBPGMS_Z001   :
            begin
                if (~WRITE)
                begin
                    if ( PATTERN_2 )
                        next_state = WBPGMS_PREL;
                    else
                        next_state = WBPGMS_WBABORT;
                end
            end

            WBPGMS_PREL   :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'hF0)
                    begin
                        if ( ESP_ACT == 1'b1 )
                            next_state = ESP;
                        else if ( ULBYPASS == 1'b1 )
                            next_state = PREL_ULBYPASS;
                        else
                            next_state = RESET;
                    end
                    else
                        next_state = WBPGMS_WBABORT;
                end
            end

            HW_RESET_UNKNOWN, HW_RESET_INIT :
            begin
            end

        endcase

        if ( BURST_TR )
        begin
            if (ConfReg[2:0] == 3'b0 )
                READ_MODE = CONTINUOUS;
            else
            begin
                if ( ConfReg[3] == 1'b1 )
                    READ_MODE = LINEAR;
                else
                    READ_MODE = CONTINUOUS;
            end
            ReadINIT = 1'b0;
            ReadINIT <= #2 1'b1;
        end
        else if ( SYNCREAD )
        begin
            READ_MODE = SYNCR;
            ReadINIT = 1'b0;
            ReadINIT <= #2 1'b1;
        end

    end

    //Burst HALT
    always @(negedge AVDNeg or posedge CENegf1)
    begin
        if (READ_MODE != NO_SYNC)
            READ_MODE = NO_SYNC;
        RY_sync = 1'b0;
    end

    //Any state, HW RESET < tRP cycle
    always @(posedge HWResetGlitch)
    begin: StateGen_Default
        next_state = HW_RESET_UNKNOWN;
    end
    //HW reset initiated
    always @(posedge HWResetStart)
    begin: StateGen_Default1
        next_state = HW_RESET_INIT;
    end

    //PPB_PROG state, PBPROG_out
    always @(PBPROG_out)
    begin: StateGen1
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PPB_PROG)
                if (PBPROG_out === 1'b1)  next_state = PPB_CMDSET;
        end
    end

    //PPB_ERS state, PBERASE_out
    always @(PBERASE_out)
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PPB_ERS)
                if (PBERASE_out === 1'b1)  next_state = PPB_CMDSET;
        end
    end

    // PASSUNLOCK state, UNLOCKDONE_out
    always @(posedge UNLOCKDONE_out)
    begin: StateGen3
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PASSUNLOCK)
                next_state = RESET;
        end
    end

    //ERS state, SERS_EXEC state, EDONE/EERR
    always @(posedge EDONE or negedge EERR)
    begin: StateGen4
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if ((current_state==ERS) || (current_state==SERS_EXEC))
                next_state = RESET;
        end
    end

    // SERS state, CTMOUT
    always @(CTMOUT)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS)
                if (CTMOUT === 1'b1)  next_state = SERS_EXEC;
        end
    end

    // ESPS state, START_T1
    always @(posedge START_T1)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==ESPS)
                if (START_T1 === 1'b1) next_state = ESP;
    end

    // PGMS state, PDONE/PERR
    always @(posedge PDONE or negedge PERR)
    begin: StateGen8
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                if ( ESP_ACT == 1'b1 )
                    next_state = ESP;
                else if ( ULBYPASS == 1'b1 )
                    next_state = PREL_ULBYPASS;
                else if ( LOCK_ACT == 1'b1 )
                    next_state = LOCKREG_CMDSET;
                else
                    next_state = RESET;
            end
        end
    end

    // PSP state, START_T1
    always @(posedge START_T1)
    begin: StateGen9
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==PSPS)
                if (START_T1 === 1'b1) next_state = PSP;
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(negedge READ or negedge READ_A or
        negedge BURST or negedge WRITE or reseted)
    begin
        if (~WRITE)
        begin
            Data      = D_tmp;
            DataLo    = D_tmp % 12'h100;
            PATTERN_1 = (Addr % 16'h1000 == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr % 16'h1000 == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = (Addr % 16'h1000 == 12'h555);
        end
        if (~BURST)
        begin
            if (ConfReg[2:0] != 3'b0)
            begin
                BurstBorder = (ConfReg[2:0]-1)*8;
                if (ConfReg[2:0] == 3'b100)
                    BurstBorder = 32;
            end
            BurstAddr = Addr;
            BurstSect = SecAddr;
            BurstDelay = BurstDelay + ConfReg[13:11] + 1;
            WSDelay = Addr % 4;

            WrapMaxCOND = 1'b0;
            if (ConfReg[2:0] != 3'b000 && ConfReg[3] == 1'b0 )
            begin
                WrapMax = BurstBorder;
                WrapMaxCOND = 1'b1;
            end
                AdvanceT[0] = AdvanceT_nobound[0];
                AdvanceT[1] = AdvanceT_nobound[1];
                AdvanceT[2] = AdvanceT_nobound[2];
                AdvanceT[3] = AdvanceT_nobound[3];
            if ( ConfReg[2:0] != 0 && ConfReg[3] )
            begin
                WrapMaxCOND = 1'b1;
                WrapMax = BurstBorder;
            end
            IncrementT = 0;
            D4Latency = 1'b0;
            DEVICE_BUSY = 1'b0;

            INITIAL_DELAY = (BurstDelay > 1);
            INITIAL_ACCESS = ( BurstDelay == 1 );

            WITHOUT_WRAP = 1'b0;

            BURST_LENGTH = 1'b0;
            RY_active = 1'b1;

            PRIOR_TO_IACC = 1'b1;
            LatencyBOUND = 1'b0;
        end

        if (reseted)
        begin
        case (current_state)
            RESET :
            begin
                RY_async = 1'b0;
                ESP_ACT   = 1'b0;
                PSP_ACT = 1'b0;
                ULBYPASS = 1'b0;
                if (~READ)
                begin
                    if (ACCEPT(1'b1))
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    else
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
                if (~WRITE)
                begin
                    if ((A_PAT_1 && (DataLo == 16'h98) &&
                    ACCEPT(1'b1)))
                        BankCFI = BankID;
                end
            end

            Z001 :
            begin
            end

            PREL_SETBWB :
            begin
                if (~WRITE)
                begin
                    if ((A_PAT_1 && (DataLo == 16'h90) &&
                    ACCEPT(1'b1)))
                        BankASEL = BankID;
                    else if (A_PAT_1 && (DataLo == 16'h20) &&
                    BankMODE == RESET)
                        ULBYPASS = 1'b1;
                    else if (A_PAT_1 && (DataLo == 16'hC0) &&
                    BankMODE == RESET)
                        BankPPB = BankID;
                    else if (A_PAT_1 && (DataLo == 16'hE0) &&
                    BankMODE == RESET)
                        BankDYB = BankID;
                    else if (A_PAT_1 && (DataLo == 16'h50) &&
                    BankMODE == RESET)
                        BankPPBLOCK = BankID;
                    else if ((DataLo == 16'h25) &&
                    ACCEPT(1'b0))
                    begin
                        SA_WriteBuffer = SecAddr;
                        StartAddress_WriteBuffer = Addr;
                    end
                end
            end

            PREL_ULBYPASS :
            begin
                if (~WRITE)
                begin
                    if (DataLo == 16'h98)
                        BankCFI = BankID;
                    else if ((DataLo == 16'h25) &&
                    ACCEPT(1'b1))
                    begin
                        SA_WriteBuffer = SecAddr;
                        StartAddress_WriteBuffer = Addr;
                    end
                end
                if (~READ)
                begin
                    OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            EXIT_ULBYPASS :
            begin
                if ((~WRITE) && (DataLo == 16'h00))
                    ULBYPASS = 1'b0;
            end

            EXIT_BankMODE :
            begin
            end

            CFI :
            begin
                if (~READ)
                begin
                    if ( BankID == BankCFI )
                    begin
                        OutputD = 0;
                        if ((( Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                        ((Addr >= 16'h40) && (Addr <= 16'h67)))
                            OutputD[8:0] = CFI_array[Addr];
                        else
                            $display("Invalid CFI query address");
                    end
                    else if (ACCEPT(1'b1))
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    else
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            UBP_CFI  :
            begin
                if (~READ)
                begin
                    if ( BankID == BankCFI )
                    begin
                        OutputD = 0;
                        if ((( Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                        ((Addr >= 16'h40) && (Addr <= 16'h67)))
                            OutputD[8:0] = CFI_array[Addr];
                        else
                            $display("Invalid CFI query address");
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            AS :
            begin
                if (~READ)
                begin
                    if ( BankID == BankASEL )
                    begin
                        ASELInd = Addr % 16;
                        OutputD = ASEL_array[ASELInd];
                    end
                    else if (ACCEPT(1'b1))
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    else
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            CR_READ :
            begin
                if ((~READ) && ((Addr % 16'h100) == 16'h00))
                begin
                    DOut_zd = ConfReg;
                    SyncData = ConfReg;
                end
            end

            CR_WRITE :
            begin
                if (~WRITE)
                begin
                    if ( Addr % 16'h100 == 16'h00 )
                        ConfReg = Data;
                    if ( ConfReg[13:11] == 0 )
                        ConfReg[8] = 1'b1;
                end
            end

            EXIT_CR :
            begin
            end

            LOCKREG_CMDSET :
            begin
                if (~READ)
                begin
                    if ( BankID == 0 && ((Addr % 16'h100) == 16'h77))
                        OutputD = LockReg;
                    else if ( BankID != 0 )
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            LOCKREG_A0SEEN :
            begin
                if (~WRITE)
                begin
                    tempLR_f = Data;
                    if (((Addr % 16'h100) == 16'h77) && ~
                    (tempLR_f[2] == 1'b0 && tempLR_f[1] == 1'b0))
                    begin
                        BankPROGRAM = 0;
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                        PSUSP = 1'b0;
                        PRES = 1'b0;
                        if ( tempLR_f[1] == 1'b0 && LockReg[2] == 1'b0 )
                            // Can not program SPMLB if PPMLB programmed
                            tempLR_f[1] = 1'b1;
                        else if ( tempLR_f[2] == 1'b0 && LockReg[1] == 1'b0 )
                            // Can not program PPMLB if SPMLB programmed
                            tempLR_f[2] = 1'b1;
                        WData = tempLR_f;//Data
                        WAddr = Addr;
                        PGMS_FLAG = LREG;
                        WB_FLAG = 1'b0;
                        SA = SecAddr;
                        temp = Data;
                        DQ7Poll = ~temp[7];
                    end
                end
            end

            EXIT_LOCKREG :
            begin
            end

            PPB_CMDSET :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPB )
                    begin
                        OutputD = 1'b0;
                        OutputD[0] = PPB[SecAddr];
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PPB_A0SEEN :
            begin
                if ((~WRITE) &&
                BankID == BankPPB && (DataLo == 16'h00))
                begin
                    PBPROG_in = 1'b0;
                    PBPROG_in <= #1 1'b1;
                    SA_ProtBit = SecAddr;
                end
            end

            PPB_PROG :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPB )
                    begin
                        Status[5] = 1'b0;
                        Status[1] = 1'b0;
                        Status[6] = ~ Status[6]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PPB_80SEEN :
            begin
                if ((~WRITE) && (DataLo == 16'h30))
                begin
                    PBERASE_in = 1'b0;
                    PBERASE_in <= #1 1'b1;
                end
            end

            PPB_ERS :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPB )
                    begin
                        Status[5] = 1'b0;
                        Status[1] = 1'b0;
                        Status[6] = ~ Status[6]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            EXIT_PPB :
            begin
            end

            DYB_CMDSET :
            begin
                if (~READ)
                begin
                    if ( BankID == BankDYB )
                    begin
                        OutputD = 0;
                        OutputD[0] = DYB[SecAddr];
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            DYB_SETCLEAR :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h00 && BankID == BankDYB )
                        DYB[SecAddr] = 1'b0;
                    else if ( DataLo == 16'h01 && BankID == BankDYB )
                        DYB[SecAddr] = 1'b1;
                end
            end

            EXIT_DYB :
            begin
            end

            PPBLOCK_CMDSET :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPBLOCK )
                    begin
                        OutputD = 0;
                        OutputD[0] = PPBLock;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PPBLOCK_SET :
            begin
                if ((~WRITE) && (DataLo == 16'h00))
                begin
                    PPBLock = 1'b0;
                    ASEL_array[3] = ASEL_03;
                end
            end

            EXIT_PPBLOCK :
            begin
            end

            PASS_A0SEEN :
            begin
                if (~WRITE)
                begin
                    BankPROGRAM = 0;
                    WData = Data;
                    WAddr = Addr % 4;
                    PGMS_FLAG = PASSW;
                    WB_FLAG = 1'b0;
                    SA = SecAddr;
                    temp = Data;
                    DQ7Poll = ~temp[7];
                    PSUSP = 1'b0;
                    PRES = 1'b0;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                end
            end

            PASSUNLOCK1 :
            begin
                PassMATCH = 0;
            end

            PASSUNLOCK2, PASSUNLOCK3, PASSUNLOCK4, PASSUNLOCK5 :
            begin
                if ((~WRITE) && (Addr % 16'h100 <4))
                    PassMATCH[(Addr % 16'h100) % 4] =
                    ( Password[(Addr % 16'h100) % 4] == Data );
            end

            PASSUNLOCK6 :
            begin
                if ((~WRITE) && ( Addr % 16'h100 == 16'h00 )
                && DataLo == 16'h29)
                begin
                    UNLOCKDONE_in = 1'b0;
                    UNLOCKDONE_in <= #1 1'b1;
                end
            end

            PASSUNLOCK :
            begin
            end

            SECSI_A0SEEN :
            begin
                if (~WRITE)
                begin
                    if ( Addr >= SecSiSize )
                        $display("Address out of SecSi 256W range.");
                    BankPROGRAM = 0;
                    WData = Data;
                    SSWAddr = Addr % SecSiSize;
                    WAddr = Addr % SecSiSize;
                    PGMS_FLAG = OTP;
                    WB_FLAG = 1'b0;
                    SA = 0;
                    temp = Data;
                    DQ7Poll = ~temp[7];
                    PSUSP = 1'b0;
                    PRES = 1'b0;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                end
            end

            A0SEEN         :
            begin
                if ((~WRITE) && ACCEPT(1'b0))
                begin
                    BankPROGRAM = BankID;
                    WData = Data;
                    WAddr = Addr;
                    PGMS_FLAG = MEMORY;
                    WB_FLAG = 1'b0;
                    SA = SecAddr;
                    temp = Data;
                    DQ7Poll = ~temp[7];
                    PSUSP = 1'b0;
                    PRES = 1'b0;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                end
            end

            C8             :
            begin
            end

            C8_Z001        :
            begin
            end

            C8_PREL        :
            begin
                if (~WRITE)
                begin
                    if (A_PAT_1 && DataLo == 16'h10)
                    begin
                        //Start Chip Erase
                        ESUSP  = 1'b0;
                        ERES   = 1'b0;
                        Ers_queue = ~(0);
                        Status = 16'b0000000000001000;
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                    end
                    else if ( DataLo == 16'h30 )
                    begin
                        BankERASE = 0;
                        BankERASE[BankID] = 1'b1;
                        Ers_queue = 0;
                        Ers_queue[SecAddr] = 1'b1;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        CTMOUT_in <= #2 1'b1;
                    end
                end
            end

            ERS :
            begin
                if (~READ)
                begin
                    Status[5] = 1'b0;
                    Status[3] = 1'b1;
                    Status[6] = ~Status[6]; //toggle
                    Status[7] = 1'b0;
                    Status[2] = ~Status[2]; //toggle
                    OutputD = Status;
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            SERS :
            begin
                if (~WRITE)
                begin
                    if ((DataLo == 16'hB0) && BankERASE[BankID] == 1'b1)
                    begin
                        ERES = 1'b0;
                        START_T1_in = 1'b0;
                        ESUSP = 1'b1;
                        ESUSP <= #1 1'b0;
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                    end
                    else if (DataLo == 16'h30)
                    begin
                        BankERASE[BankID] = 1'b1;
                        disable TCTMOUTr;
                        CTMOUT_in = 1'b0;
                        CTMOUT_in <= #2 1'b1;
                        Ers_queue[SecAddr] = 1'b1;
                    end
                end
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankERASE[BankID] == 1'b1 )
                    begin
                        Status[7] = 1'b1;
                        Status[3] = 1'b0;
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESPS :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankERASE[BankID] == 1'b1 )
                    begin
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        if (Ers_queue[SecAddr] == 1'b1)
                        begin
                            Status[7] = 1'b0;
                            Status[2] = ~ Status[2]; //toggle
                        end
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            SERS_EXEC :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankERASE[BankID] == 1'b1 )
                    begin
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        if ( Ers_queue[SecAddr] == 1'b1 )
                        begin
                            Status[2] = ~Status[2]; //toggle
                            Status[7] = 1'b0;
                        end
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
                if ((~WRITE) && EERR != 1'b1 && DataLo == 16'hB0 )
                begin
                    START_T1_in = 1'b1;
                    ESUSP = 1'b1;
                    ESUSP = #1 1'b0;
                end
            end

            ESP :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h30 && BankERASE[BankID] == 1'b1 )
                    begin
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                        ESP_ACT = 1'b0;
                    end
                    else if (( Addr % 16'h100 == 16'h55 ) &&
                    DataLo == 16'h98 && ACCEPT(1'b1))
                        BankCFI = BankID;
                end
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_Z001 :
            begin
            end

            ESP_PREL :
            begin
                if (~WRITE)
                begin
                    if ( A_PAT_1 && DataLo == 16'h90 &&
                    ACCEPT(1'b1))
                        BankASEL = BankID;
                    else if ( A_PAT_1 && DataLo == 16'hC0 &&
                    BankMODE == RESET )
                        BankPPB = BankID;
                    else if ( A_PAT_1 && DataLo == 16'hE0 &&
                    BankMODE == RESET )
                        BankDYB = BankID;
                    else if ( A_PAT_1 && DataLo == 16'h50 &&
                    BankMODE == RESET )
                        BankPPBLOCK = BankID;
                    else if ( DataLo == 16'h25 && Ers_queue[SecAddr] == 1'b0 &&
                    ACCEPT(1'b0))
                    begin
                        SA_WriteBuffer = SecAddr;
                        StartAddress_WriteBuffer = Addr;
                    end
                end
            end

            ESP_CFI :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if (BankID == BankCFI)
                    begin
                        OutputD = 0;
                        if ((( Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                        ((Addr >= 16'h40) && (Addr <= 16'h67)))
                            OutputD = CFI_array[Addr];
                        else
                            $display("Invalid CFI query address");
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_A0SEEN :
            begin
                if ((~WRITE) && Ers_queue[SecAddr] == 1'b0 &&
                ACCEPT(1'b0))
                begin
                    ESP_ACT = 1'b1;
                    WData = Data;
                    WAddr = Addr;
                    PGMS_FLAG = MEMORY;
                    WB_FLAG = 1'b0;
                    SA = SecAddr;
                    temp = Data;
                    DQ7Poll = ~temp[7];
                    BankPROGRAM = BankID;
                    PSUSP = 1'b0;
                    PRES = 1'b0;
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                end
            end

            ESP_AS :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankID == BankASEL )
                    begin
                        ASELInd = Addr % 16;
                        OutputD = ASEL_array[ASELInd];
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_PPB :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPB )
                    begin
                        OutputD = 0;
                        OutputD[0] = PPB[SecAddr];
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_DYB :
            begin
                if (~READ)
                begin
                    if ( BankID == BankDYB )
                    begin
                        OutputD = 0;
                        OutputD[0] = DYB[SecAddr];
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_PPBLOCK :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPBLOCK )
                    begin
                        OutputD = 0;
                        OutputD[0] = PPBLock;
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_OTP :
            begin
                if (~READ)
                begin
                    if ( BankID == 0 )
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            ESP_OTP_Z001 :
            begin
            end

            ESP_OTP_PREL :
            begin
            end

            ESP_OTP_EXIT :
            begin
            end

            PGMS :
            begin
                if ((~WRITE) && PERR != 1'b1 &&
                DataLo == 16'hB0 && BankPROGRAM == BankID)
                begin
                    START_T1_in = 1'b1;
                    PSUSP = 1'b1;
                    PSUSP <= #1 1'b0;
                end
                if (~READ)
                begin
                    if ( BankID == BankPROGRAM )
                    begin
                        if ((WB_FLAG && Addr == Addr_WriteBuffer[0]) ||
                        ( ~WB_FLAG && Addr == WAddr ))
                            Status[7] = DQ7Poll;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[1] = 1'b0;
                        OutputD = Status;
                    end
                    else if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSPS :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPROGRAM )
                    begin
                        if ((WB_FLAG && Addr == Addr_WriteBuffer[0]) ||
                        ( ~ WB_FLAG && Addr == WAddr ))
                            Status[7] = DQ7Poll;
                        Status[6] = ~ Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[1] = 1'b0;
                        OutputD = Status;
                    end
                    else if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if (BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1)
                    begin
                        Status[5] = 1'b0;
                        Status[2] = ~Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP :
            begin
                if (~WRITE)
                begin
                    if ( DataLo == 16'h30 && BankID == BankPROGRAM )
                    begin
                        PRES = 1'b1;
                        PRES <= #1 1'b0;
                        PSP_ACT = 1'b0;
                    end
                    else if (( Addr % 16'h100 == 16'h55 || ULBYPASS == 1'b1)&&
                    DataLo == 16'h98 && ACCEPT(1'b1))
                        BankCFI = BankID;
                end
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( SecAddr == SA )
                        $display("%s",
                        "Read from program suspended sector is NOT allowed");
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[7] = 1'b1;
                        Status[5] = 1'b0;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_Z001       :
            begin
            end

            PSP_PREL       :
            begin
                if (~WRITE)
                begin
                    if ( A_PAT_1 && DataLo == 16'h90 &&
                    ACCEPT(1'b1) )
                        BankASEL = BankID;
                    else if (A_PAT_1 && DataLo == 16'hC0 &&
                    BankMODE == RESET)
                        BankPPB = BankID;
                    else if (A_PAT_1 && DataLo == 16'hE0 &&
                    BankMODE == RESET)
                        BankDYB = BankID;
                    else if (A_PAT_1 && DataLo == 16'h50 &&
                    BankMODE == RESET)
                        BankPPBLOCK = BankID;
                end
            end

            PSP_CFI :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankID == BankCFI )
                    begin
                        OutputD = 0;
                        if ((( Addr >= 16'h10) && (Addr <= 16'h3C)) ||
                        ((Addr >= 16'h40) && (Addr <= 16'h67)))
                            OutputD = CFI_array[Addr];
                        else
                            $display("Invalid CFI query address");
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else if ( SecAddr == SA )
                    begin
                        $display("Program suspended sector read - invalid");
                        OutputD = 16'bx;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_AS :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankID == BankASEL )
                    begin
                        ASELInd = Addr % 16;
                        OutputD = ASEL_array[ASELInd];
                    end
                    else if (BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1)
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else if ( SecAddr == SA )
                    begin
                        $display("Program suspended sector read - invalid");
                        OutputD = 16'bx;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_PPB :
            begin
                if (~READ)
                begin
                    if (  BankID == BankPPB )
                    begin
                        OutputD = 0;
                        OutputD[0] = PPB[SecAddr];
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else if ( SecAddr == SA )
                    begin
                        $display("Program suspended sector read - invalid");
                        OutputD = 16'bx;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_DYB :
            begin
                if (~READ)
                begin
                    if ( BankID == BankDYB )
                    begin
                        OutputD = 0;
                        OutputD[0] = DYB[SecAddr];
                    end
                    else if (BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1)
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else if ( SecAddr == SA )
                    begin
                        $display("Program suspended sector read - invalid");
                        OutputD = 16'bx;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_PPBLOCK :
            begin
                if (~READ)
                begin
                    if ( BankID == BankPPBLOCK )
                    begin
                        OutputD = 0;
                        OutputD[0] = PPBLock;
                    end
                    else if (BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1)
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else if ( SecAddr == SA )
                    begin
                        $display("Program suspended sector read - invalid");
                        OutputD = 16'bx;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_OTP :
            begin
                if (~READ)
                begin
                    if ( SecAddr == SA )
                    begin
                        $display("Program suspended sector read - invalid");
                        OutputD = 16'bx;
                    end
                    else if ( BankID == 0 )
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[7] = 1'b1;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            PSP_OTP_Z001 :
            begin
            end

            PSP_OTP_PREL :
            begin
            end

            PSP_OTP_EXIT :
            begin
            end

            WBPGMS_WBCNT   :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) && (DataLo < 32) &&
                    StartAddress_WriteBuffer == Addr)
                    begin
                        Cnt_WriteBuffer = DataLo;
                        LCNT = DataLo;
                    end
                end
            end

            WBPGMS_WBLSTA  :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) &&
                    StartAddress_WriteBuffer == Addr)
                    begin
                        PA_WriteBuffer = Addr / 32;
                        Data_WriteBuffer[LCNT] = Data;
                        Addr_WriteBuffer[LCNT] = Addr;
                        if ( LCNT > 0 )
                            LCNT = LCNT -1;
                        temp = DataLo;
                        DQ7Poll = ~temp[7];
                        if ( BankMODE == SecSiENABLED && SA_WriteBuffer == 0 )
                        begin
                            if ( Addr >= SecSiSize )
                                $display( "Address out of SecSi 256W range.");
                            Addr_WriteBuffer[LCNT] = Addr % SecSiSize;
                        end
                    end
                end
            end

            WBPGMS_WBLOAD  :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) &&
                    (Addr/32) == PA_WriteBuffer)
                    begin
                        Data_WriteBuffer[LCNT] = Data;
                        Addr_WriteBuffer[LCNT] = Addr;
                        if ( LCNT > 0 )
                            LCNT = LCNT -1;
                        temp = DataLo;
                        DQ7Poll = ~temp[7];

                        if ( BankMODE == SecSiENABLED && SA_WriteBuffer == 0 )
                        begin
                            if ( Addr >= SecSiSize )
                                $display( "Address out of SecSi 256W range.");
                            Addr_WriteBuffer[LCNT] =
                            Addr_WriteBuffer[LCNT] % SecSiSize;
                        end
                    end
                end//
            end

            WBPGMS_CONFB   :
            begin
                if (~WRITE)
                begin
                    if ((SecAddr == SA_WriteBuffer) && (DataLo == 16'h29))
                    begin
                        SA = SA_WriteBuffer;
                        BankPROGRAM = BankID;
                        WB_FLAG = 1'b1;
                        if ( BankMODE == SecSiENABLED && BankID == 0 )
                            PGMS_FLAG = OTP;
                        else
                            PGMS_FLAG = MEMORY;
                        PSUSP  = 1'b0;
                        PRES   = 1'b0;
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                    end
                end
            end

            WBPGMS_WBABORT :
            begin
                if (~READ)
                begin
                    if (~ACCEPT(1'b1))
                        OutputD = READMEM_DISABLE(SecAddr,Addr);
                    else if (BankID == BankPROGRAM)
                    begin
                        if (( Addr == Addr_WriteBuffer[0] && LCNT == 0 ) ||
                        (LCNT > 0 && LCNT < 31 &&
                        Addr == Addr_WriteBuffer[(LCNT + 1) % 32]))
                            Status[7] = DQ7Poll;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[1] = 1'b1;
                        OutputD = Status;
                    end
                    else if ( BankERASE[BankID] == 1'b1 &&
                    Ers_queue[SecAddr] == 1'b1 )
                    begin
                        Status[5] = 1'b0;
                        Status[2] = ~ Status[2]; //toggle
                        OutputD = Status;
                    end
                    else
                        OutputD = READMEM_RESET(SecAddr,Addr);
                    DOut_zd = OutputD;
                    SyncData = OutputD;
                end
            end

            WBPGMS_Z001    :
            begin
            end

            WBPGMS_PREL    :
            begin
            end

            HW_RESET_UNKNOWN, HW_RESET_INIT :
            begin
            end

        endcase

        //Burst RESUME Detection
        if (~READ && (READ_MODE != SYNCR) &&
        (READ_MODE != NO_SYNC) && BURST !== 1'b0)
        begin
            DOut_zd = READMEM_BURST(SectSuspend,AddrSuspend);
        end

    end
end

    // BankERASE flags update, erase finished
    always @(posedge EDONE)
    begin
        BankERASE = 0;
    end

    //PPB_PROG state, PBPROG_out
    always @(posedge PBPROG_out)
    begin : Functionality1
        if (current_state == PPB_PROG && PPBLock == 1'b1)
            PPB[SA_ProtBit] = 1'b0;
        PBPROG_in = 1'b0;
    end

    //PPB_ERS state, PBERASE_out
    always @(posedge PBERASE_out)
    begin : Functionality2
        if (current_state == PPB_ERS && PPBLock == 1'b1)
            PPB = ~0;
        PBERASE_in = 1'b0;
    end

    //PASSUNLOCK state, UNLOCKDONE_out
    always @(posedge UNLOCKDONE_out)
    begin : Functionality3
        if (( current_state == PASSUNLOCK )&&( PassMATCH == 4'b1111 ))
        begin
            PPBLock = 1'b1;
            ASEL_array[3] = ASEL_03 + 1;
        end
        UNLOCKDONE_in = 1'b0;
    end

    //ERS state, EDONE falling edge, EDONE rising edge
    always @(EERR or EDONE)
    begin : Functionality4
    integer i;
    integer j;
    integer SecErsLOW;
    integer SecErsHIGH;
        if (current_state == ERS)
        begin
        if (EERR!=1'b1)
            if (~EDONE)//falling edge
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if ((DYB[i] == 1'b1 && PPB[i] == 1'b1 &&
                    ~(WPNeg === 1'b0 && (i <= 3 || i >= SecNum-3)) &&
                    ~(ACC === 1'b0)) &&
                    ~(i<SecNum_bank0 && BankMODE != RESET))
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = -1;
                end
            end
            if (EDONE)//rising edge
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    ADDRHILO(SecErsLOW,SecErsHIGH,i);
                    if ((DYB[i] == 1'b1 && PPB[i] == 1'b1 &&
                    ~(WPNeg === 1'b0 && (i <= 3 || i >= SecNum-3)) &&
                    ~(ACC === 1'b0)) &&
                    ~(i<SecNum_bank0 && BankMODE != RESET))
                        for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                            Mem[j] = MaxData;
                end
            end
        end
    end

    //SERS state, CTMOUT
    always @(CTMOUT)
    begin : Functionality5
        if (current_state==SERS)
        begin
            if (CTMOUT)
            begin
                CTMOUT_in = 1'b0;
                START_T1_in = 1'b0;
                ESUSP = 1'b0;
                ERES   = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
            end
        end
    end

    //ESPS state, START_T1
    always @(START_T1)
    begin : Functionality6
        if (current_state==ESPS)
        begin
            if (START_T1)
            begin
                ESP_ACT = 1'b1;
                START_T1_in = 1'b0;
            end
        end
    end

    //SERS_EXEC state, EDONE falling edge, EDONE rising edge
    always @(EERR or EDONE)
    begin: Functionality7
    integer i,j;
    integer SecErsLOW;
    integer SecErsHIGH;

        if (current_state==SERS_EXEC)
        begin
            if (EERR!=1'b1)
            begin
                if (~EDONE)
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO(SecErsLOW,SecErsHIGH,i);
                        if (Ers_queue[i] == 1'b1 &&
                        DYB[i] == 1'b1 && PPB[i] == 1'b1 &&
                        ~ (WPNeg === 1'b0 && (i <= 3 || i >= SecNum-3)) &&
                        ~ (ACC === 1'b0) &&
                        ~ (i<SecNum_bank0 && BankMODE != RESET))
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = -1;
                    end
                end

                if (EDONE)
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        ADDRHILO(SecErsLOW,SecErsHIGH,i);
                        if (Ers_queue[i] == 1'b1 &&
                        DYB[i] == 1'b1 && PPB[i] == 1'b1 &&
                        ~ (WPNeg === 1'b0 && (i <= 3 || i >= SecNum-3)) &&
                        ~ (ACC === 1'b0) &&
                        ~ (i<SecNum_bank0 && BankMODE != RESET))
                            for (j=SecErsLOW;j<=SecErsHIGH;j=j+1)
                                Mem[j] = MaxData;
                    end
                end
            end
        end
    end

    //PGMS state, PDONE rising edge, PDONE falling edge
    always @(PDONE)
    begin: Functionality9
    integer i,j;
    integer SecProgLOW;
    integer SecProgHIGH;

        if (current_state==PGMS)
        begin
            ADDRHILO(SecProgLOW,SecProgHIGH,SA);
            if ((PERR != 1'b1) && (~WB_FLAG))//No Write to Buffer
            begin
                if (~PDONE)//falling
                begin
                    new_int = WData;
                    if ( PGMS_FLAG == OTP )
                        old_int = SecSi[SSWAddr];
                    else if ( PGMS_FLAG == MEMORY )
                        old_int = Mem[SecProgLOW + WAddr];
                    else if ( PGMS_FLAG == PASSW )
                        old_bit = Password[WAddr];
                    else if ( PGMS_FLAG == LREG )
                        old_bit = LockReg;

                    new_bit = new_int;
                    if ((PGMS_FLAG == OTP || PGMS_FLAG == MEMORY) &&
                    (old_int>-1))
                    begin
                        old_bit = old_int;
                        new_bit = new_bit & old_bit;
                        new_int = new_bit;
                        WData = new_int;
                    end
                    else if ((PGMS_FLAG == PASSW || PGMS_FLAG == LREG) &&
                    (old_bit[0]!==1'bx))
                    begin
                        new_bit = new_bit & old_bit;
                        new_int = new_bit;
                        WData = new_int;
                    end
                    if (PGMS_FLAG == OTP)
                        SecSi[SSWAddr] = -1;
                    else if (PGMS_FLAG == MEMORY)
                        Mem[SecProgLOW + WAddr] = -1;
                    else if ( PGMS_FLAG == PASSW )
                        Password[WAddr] = 16'bx;
                    else if ( PGMS_FLAG == LREG )
                        LockReg = 16'bx;
                end
                if (PDONE)//rising
                begin
                    if ( PGMS_FLAG == OTP )
                        SecSi[SSWAddr] = WData;
                    else if ( PGMS_FLAG == PASSW )
                        Password[WAddr] = WData;
                    else if ( PGMS_FLAG == LREG )
                    begin
                        LockReg = WData;
                        if ( ~LockReg[0] )
                        begin
                            ASEL_03 = 16'hC0 + (ASEL_03 % 16'h10);
                            ASEL_array[3] = 16'hC0 + (ASEL_array[3] % 16'h10);
                        end
                    end
                    else
                        Mem[SecProgLOW + WAddr] = WData;
                end
            end
            else if ((PERR != 1'b1) && (WB_FLAG))
            begin//Write to Buffer Programming
                ADDRHILO(SecProgLOW,SecProgHIGH,SA_WriteBuffer);
                if (~PDONE)//falling
                begin
                    for(i=0; i<=Cnt_WriteBuffer; i=i+1)
                    begin
                        new_int = Data_WriteBuffer[i];
                        if ( PGMS_FLAG == OTP )
                            old_int = SecSi[Addr_WriteBuffer[i]];
                        else
                            old_int = Mem[SecProgLOW + Addr_WriteBuffer[i]];
                        new_bit = new_int;
                        if ( old_int > -1 )
                        begin
                            old_bit = old_int;
                            new_bit = new_bit & old_bit;
                            new_int = new_bit;
                        end
                        Data_WriteBuffer[i] = new_int;
                    end
                    for(i=0; i<=Cnt_WriteBuffer; i=i+1)
                    begin
                        if ( PGMS_FLAG == OTP )
                            SecSi[Addr_WriteBuffer[i]] = -1;
                        else
                            Mem[SecProgLOW + Addr_WriteBuffer[i]] = -1;
                    end
                end
                if (PDONE)//rising
                begin
                    for(i=Cnt_WriteBuffer; i>=0; i=i-1)
                    begin
                        if ( PGMS_FLAG == OTP )
                            SecSi[Addr_WriteBuffer[i]] = Data_WriteBuffer[i];
                        else
                            Mem[SecProgLOW + Addr_WriteBuffer[i]] =
                                Data_WriteBuffer[i];
                    end
                end
            end
        end
    end

    //PSPS state, START_T1
    always @(posedge START_T1)
    begin : Functionality10
        if (current_state == PSPS)
        begin
            START_T1_in = 1'b0;
            PSP_ACT = 1'b1;
        end
    end

    //Burst Suspend/Resume detection
    always @(posedge OENeg)
    begin
        DOut_zd = 16'bz;
    end

    //Output Disable Control
    always @(posedge CENegf1)
    begin
        DOut_zd = 16'bZ;
    end

    //Output Disable Control
    always @(negedge RST)
    begin
        if (~RESETNeg)
            DOut_zd = 16'bZ;
    end

    // Hardware RESET cycle
    always @(negedge RST)
    begin
        if (~RESETNeg)
        begin
            READ_MODE = NO_SYNC;
            BankERASE = 0;
            BankMODE = RESET;
            LOCK_ACT = 1'b0;
            ConfReg = 16'b1110111111001000;
            if ( LockReg[2] === 1'b0 )
            begin
                PPBLock = 1'b0;
                ASEL_array[3] = ASEL_03;
            end
            else
            begin
                PPBLock = 1'b1;
                ASEL_array[3] = ASEL_03 + 1;
            end
            DYB = dyb_boot_value;
            ESP_ACT = 1'b0;
            ULBYPASS = 1'b0;
            PSP_ACT = 1'b0;
            PBPROG_in = 1'b0;
            PBERASE_in = 1'b0;
            UNLOCKDONE_in = 1'b0;
            START_T1_in = 1'b0;
        end
    end

    //Synchronous READ modes
    always @(posedge CLKMerge or negedge ReadINIT)
    begin

        case ( READ_MODE )
            LINEAR :
            begin
                // Linear Burst 8/16/32 with wrap
                    AddrSuspend = BurstAddr;
                    SectSuspend = BurstSect;
                    WMSuspend = WrapMax;
                    DetectFrequency(Freq);
                    if ( INITIAL_DELAY )
                    begin
                        BurstDelay = BurstDelay - 1;
                        RY_sync = 1'b0;
                        if ( BurstDelay == 1 )
                        begin
                            INITIAL_DELAY = 1'b0;
                            INITIAL_ACCESS = 1'b1;
                            if ( ~ConfReg[8] && OENeg == 1'b0 &&
                            TIACC_out == 1'b1 )
                                RY_sync = 1'b1;
                        end
                    end
                    else if ( BURST_LENGTH && OENeg == 1'b0 )
                    begin
                        RY_sync = RY_active && ConfReg[8];
                        RY_active = 1'b0;
                        DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                    end
                    else if ( INITIAL_ACCESS && OENeg == 1'b0 )
                    begin
                        if ( TIACC_out == 1'b1 )
                        begin
                            IncrementT = IncrementT + Period[Freq];
                            if ( D4Latency )
                            begin
                                RY_sync = 1'b0;
                                if ( IncrementT > AdvanceT[Freq] )
                                begin
                                    D4Latency = 1'b0;
                                    INITIAL_ACCESS = 1'b0;
                                    RY_sync  = 1'b1;
                                    DOut_zd =
                                    READMEM_BURST(BurstSect,BurstAddr);
                                    UpdateADDRL(BurstAddr,BurstBorder);
                                   CheckWrap(WrapMaxCOND,WrapMax,BURST_LENGTH);
                                end
                                else if ((IncrementT + Period[Freq]) >
                                AdvanceT[Freq])
                                begin
                                    RY_sync = ~ConfReg[8];
                                end
                            end
                            else if ( BurstAddr % 4 <= 2 )
                            begin
                                RY_sync = 1'b1;
                                DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                                CheckWrap(WrapMaxCOND,WrapMax,BURST_LENGTH);
                                BurstAddr = BurstAddr + 1;
                            end
                            else if ( BurstAddr % 4 == 3 )
                            begin
                                RY_sync = 1'b1;
                                if ((IncrementT + Period[Freq]) <=
                                AdvanceT[Freq])
                                    RY_sync = ConfReg[8];
                                DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                                UpdateADDRL(BurstAddr,BurstBorder);
                                CheckWrap(WrapMaxCOND,WrapMax,BURST_LENGTH);
                                D4Latency = 1'b1;
                            end
                        end
                    end
                    else if ( OENeg == 1'b0 )
                    begin
                        RY_sync = 1'b1;
                        DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                        CheckWrap(WrapMaxCOND,WrapMax,BURST_LENGTH);
                        UpdateADDRL(BurstAddr,BurstBorder);
                    end
            end

            CONTINUOUS :
            begin
                    //Continuous / Linear without wrap around
                    AddrSuspend = BurstAddr;
                    SectSuspend = BurstSect;
                    WMSuspend = WrapMax;
                    DetectFrequency(Freq);
                    if ( INITIAL_DELAY )
                    begin
                        BurstDelay = BurstDelay - 1;
                        RY_sync = 1'b0;
                        if ( BurstDelay == 1 )
                        begin
                            INITIAL_DELAY = 1'b0;
                            INITIAL_ACCESS = 1'b1;
                            if  ( ConfReg[8] == 1'b0  && OENeg == 1'b0 &&
                            TIACC_out == 1'b1 )
                                RY_sync = 1'b1;
                        end
                    end
                    else if ( WITHOUT_WRAP  && OENeg == 1'b0 )
                    begin
                        RY_sync = RY_active  && ConfReg[8];
                        RY_active = 1'b0;
                        DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                    end
                    else if ( DEVICE_BUSY  && OENeg == 1'b0 )
                    begin
                        RY_sync = 1'b1;
                        DOut_zd = CrossData;
                    end
                    else if ( INITIAL_ACCESS  && OENeg == 1'b0 )
                    begin
                        if ( TIACC_out == 1'b1 )
                        begin
                            IncrementT = IncrementT + Period[Freq];
                            if ( D4Latency )
                            begin
                                RY_sync = 1'b0;
                                if ( IncrementT > AdvanceT[Freq] )
                                begin
                                    D4Latency = 1'b0;
                                    INITIAL_ACCESS = 1'b0;
                                    RY_sync = 1'b1;
                                    if ( ~BusyBOUND )
                                    begin
                                        DOut_zd =
                                        READMEM_BURST(BurstSect,BurstAddr);
                                        UpdateADDR(BurstSect,BurstAddr);
                                        CheckWrap(
                                            WrapMaxCOND,
                                            WrapMax,
                                            WITHOUT_WRAP);
                                    end
                                    else
                                    begin
                                        DOut_zd = CrossData;
                                        DEVICE_BUSY = 1'b1;
                                    end
                                end
                                else if  ((IncrementT + Period[Freq]) >
                                AdvanceT[Freq])
                                    RY_sync = ~ConfReg[8];
                            end
                            else if ( BurstAddr % 4 <= 2 )
                            begin
                                RY_sync = 1'b1;
                                DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                                BurstAddr = BurstAddr + 1;
                                CheckWrap(WrapMaxCOND,WrapMax,WITHOUT_WRAP);
                            end
                            else if ( BurstAddr % 4 == 3 )
                            begin
                                DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                                CheckBoundary(
                                    BusyBOUND,
                                    CrossData,
                                    BurstAddr,
                                    BurstSect);
                                if ((BurstAddr % 16'h80) == 16'h7F &&
                                //66Mhz or higher
                                (NoRowBound_out == 1'b0 ||
                                //below 66Mhz, but CR.14 requires latency
                                (NoRowBound_out == 1'b1 &&
                                ConfReg[14] == 1'b1)))
                                begin
                                    AdvanceT[Freq] = AdvanceT_bound[Freq];
                                end
                                RY_sync = 1'b1;
                                if  ((IncrementT + Period[Freq]) <=
                                AdvanceT[Freq])
                                    RY_sync = ConfReg[8];
                                UpdateADDR(BurstSect,BurstAddr);
                                CheckWrap(WrapMaxCOND,WrapMax,WITHOUT_WRAP);
                                D4Latency = 1'b1;
                            end
                        end
                    end
                    else if ( OENeg == 1'b0 )
                    begin
                        if ( LatencyBOUND )
                        begin
                            RY_sync = ~ConfReg[8];
                            DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                            LatencyBOUND = 1'b0;
                            CheckBoundary(
                                BusyBOUND,
                                CrossData,
                                BurstAddr,
                                BurstSect);
                            DEVICE_BUSY = BusyBOUND;
                            UpdateADDR(BurstSect,BurstAddr);
                            CheckWrap(WrapMaxCOND,WrapMax,WITHOUT_WRAP);
                        end
                        else
                        begin
                            RY_sync = 1'b1;
                            DOut_zd = READMEM_BURST(BurstSect,BurstAddr);
                            if ( BurstAddr % 4 == 3 )
                            begin
                                LatencyBOUND =
                                (((BurstAddr % 16'h80) == 16'h7F) &&
                                (NoRowBound_out == 1'b0 ||
                                ConfReg[14] == 1'b1));
                                if ( LatencyBOUND )
                                    RY_sync = ConfReg[8];
                                if  (((BurstAddr % 16'h80) == 16'h7F) &&
                                ~LatencyBOUND)
                                begin
                                    CheckBoundary(
                                        BusyBOUND,
                                        CrossData,
                                        BurstAddr,
                                        BurstSect);
                                    DEVICE_BUSY = BusyBOUND;
                                end
                            end
                            if  (~LatencyBOUND)
                            begin
                                UpdateADDR(BurstSect,BurstAddr);
                                CheckWrap(WrapMaxCOND,WrapMax,WITHOUT_WRAP);
                            end
                        end
                    end
                    NoRowBound_in = 1'b0;
                    NoRowBound_in <= #1 1'b1;
            end

            SYNCR :
            begin
                    if ( INITIAL_DELAY )
                    begin
                        BurstDelay = BurstDelay - 1;
                        RY_sync = 1'b0;
                        if ( BurstDelay == 1 )
                        begin
                            INITIAL_DELAY = 1'b0;
                            if ( ConfReg[8] == 1'b0  &&
                            OENeg == 1'b0 && TIACC_out == 1'b1 )
                                RY_sync = 1'b1;
                        end
                    end
                    else if ( TIACC_out == 1'b1  && OENeg == 1'b0 )
                        RY_sync = 1'b1;
            end

            NO_SYNC :
            begin
            end

        endcase

end

    // T array assignment
    always @(T0_event)
    begin : T0_control
        T[0] = 1'b0;
        #(Period[0]-1) T[0] = 1'b1;
    end
    always @(T1_event)
    begin : T1_control
        T[1] = 1'b0;
        #(Period[1]-1) T[1] = 1'b1;
    end
    always @(T2_event)
    begin : T2_control
        T[2] = 1'b0;
        #(Period[2]-1) T[2] = 1'b1;
    end
    always @(T3_event)
    begin : T3_control
        T[3] = 1'b0;
        #(Period[3]-1) T[3] = 1'b1;
    end

    function [11:0] ReturnSectorID;
    input [HiAddrBit:0] ADDR;
    integer conv;
    begin
        conv = ADDR / 20'h10000;
        if ( conv == 0 )
            ReturnSectorID = ADDR / 24'h4000;
        else if (( ADDR >= 24'h10000 ) && ( ADDR <= 24'hFEFFFF ))
            ReturnSectorID = 3 + conv;
        else
            ReturnSectorID = 258 + (ADDR - 24'hFF0000)/24'h4000;
    end
    endfunction

    function[3:0] ReturnBank;
    input[HiAddrBit:0] ADDR;
    begin
        ReturnBank = ADDR / 24'h100000;
    end
    endfunction

    function ACCEPT;
    input ChMode;
    begin
        ACCEPT = ((BankID != 0) || (BankID==0 && BankMODE==RESET));
        if (~ChMode )
            ACCEPT = (ACCEPT || (BankID==0 && BankMODE==SecSiENABLED));
    end
    endfunction

    task ADDRHILO;
    inout  AddrLOW;
    inout  AddrHIGH;
    input   SectorID;
    integer AddrLOW;
    integer AddrHIGH;
    integer SectorID;
    begin

        if (SectorID <= 3)
        begin
            AddrLOW  = SectorID*20'h04000;
            AddrHIGH = SectorID*20'h04000 + 20'h3FFF;
        end
        else if ((SectorID > 3) && (SectorID < 258))
        begin
            AddrLOW  = (SectorID-3)*20'h10000;
            AddrHIGH = (SectorID-3)*20'h10000+16'hFFFF;
        end
        else
        begin
            AddrLOW  = 24'hFF0000 + (SectorID-258)*20'h04000;
            AddrHIGH = 24'hFF0000 + (SectorID-258)*20'h04000 + 16'h3FFF;
        end
    end
    endtask

    function[15:0] READMEM_RESET;
    input SecAddress;
    input Address;
    integer SecAddress;
    integer Address;
    integer AddrBASE;
    integer Data;
    begin
        if (SecAddress <= 3)
            AddrBASE  = SecAddress*20'h04000;
        else if ((SecAddress > 3) && (SecAddress < 258))
            AddrBASE  = (SecAddress-3)*20'h10000;
        else
            AddrBASE  = 24'hFF0000 + (SecAddress-258)*20'h04000;
        Data = Mem[AddrBASE+Address];
        if ( Data == -1 )
            READMEM_RESET = 16'bx;
        else
            READMEM_RESET = Data;
    end
    endfunction

    function[15:0] READMEM_BURST;
    input SecAddress;
    input Address;
    integer SecAddress;
    integer Address;
    integer AddrBASE;
    integer Data;
    begin
        if (SecAddress <= 3)
            AddrBASE  = SecAddress*20'h04000;
        else if ((SecAddress > 3) && (SecAddress < 258))
            AddrBASE  = (SecAddress-3)*20'h10000;
        else
            AddrBASE  = 24'hFF0000 + (SecAddress-258)*20'h04000;
        if (SecAddress < SecNum_bank0 && BankMODE == SecSiENABLED)
            Data = SecSi[Address % SecSiSize];
        else
            Data = Mem[AddrBASE+Address];
        if ( Data == -1 )
            READMEM_BURST = 16'bx;
        else
            READMEM_BURST = Data;
    end
    endfunction

    //READMEM_DISABLE(SecAddr, Addr);
    function[15:0] READMEM_DISABLE;
    input SecAddress;
    input Address;
    integer SecAddress;
    integer Address;
    integer AddrBASE;
    integer Data;
    begin
        if (SecAddress <= 3)
            AddrBASE  = SecAddress*20'h04000;
        else if ((SecAddress > 3) && (SecAddress < 258))
            AddrBASE  = (SecAddress-3)*20'h10000;
        else
            AddrBASE  = 24'hFF0000 + (SecAddress-258)*20'h04000;

        Data = 16'bx;
        if ( BankMODE == SecSiENABLED )
        begin
            if ( SecAddr == 0 )
            begin
                if (~(Addr<SecSiSize))
                    $display("Address out of SecSi 256W range.");
                Data = SecSi[Address % SecSiSize];
            end
            else
                Data = Mem[AddrBASE+Address];
            if ( Data == -1 )
                READMEM_DISABLE =  16'bx;
            else
                READMEM_DISABLE = Data;
        end
        else if ( BankMODE == PasswordENABLED )
        begin
            if ( LockReg[2] )
                READMEM_DISABLE = Password[Addr % 4];
            else
                READMEM_DISABLE = ~(16'b0);
        end
    end
    endfunction

    task UpdateADDR;
    inout  BurstSect;
    inout  BurstAddr;
    integer BurstSect;
    integer BurstAddr;
    integer AddrLOW;
    integer AddrHIGH;
    integer AddrCHECK;
    integer SecHlp2;
    begin
        SecHlp2 = BurstSect;
        ADDRHILO(AddrLOW, AddrHIGH, SecHlp2);
        AddrCHECK = AddrLOW + BurstAddr;
        //Address Update
        SecHlp = ReturnSectorID(AddrCHECK);
        SecTemp = ReturnSectorID((AddrCHECK+1) % (ADDRRange+1));
        if ( SecHlp != SecTemp )
        begin
            if ( BurstSect == SecNum )
                BurstSect = 0;
            else
            begin
                BurstSect = BurstSect + 1;
            end
            BurstAddr = 0;
        end
        else
            BurstAddr = BurstAddr + 1;
    end
    endtask

    task UpdateADDRL;
    inout   BurstAddr;
    input   BurstBorder;
    integer BurstAddr;
    integer BurstBorder;
    begin
        BurstAddr = BurstAddr + 1;
        if ( BurstAddr % BurstBorder == 0 )
            BurstAddr = BurstAddr - BurstBorder;
    end
    endtask

    task CheckBoundary;
    inout  BusyBOUND;
    inout[15:0] CrossData;
    inout  BurstAddr;
    inout  BurstSect;
    integer BurstAddr;
    integer BurstSect;
    integer AddrCHECK;
    integer AddrLOW;
    integer AddrHIGH;
    begin
        ADDRHILO(AddrLOW, AddrHIGH, BurstSect);
        AddrCHECK = AddrLOW + BurstAddr;
        BankCHECK =
        ReturnBank((AddrCHECK+1) % (ADDRRange+1));
        SectorCHECK =
        ReturnSectorID((AddrCHECK+1) % (ADDRRange+1));
        BusyBOUND = 1'b0;

        if (BankCHECK == BankASEL && (current_state==AS ||
        current_state == ESP_AS || current_state == PSP_AS))
        begin
            CrossData = ASEL_array[0];
            BusyBOUND = 1'b1;
        end
        // CFI mode bank
        else if (BankCHECK == BankCFI && (current_state == CFI ||
        current_state == ESP_CFI || current_state == PSP_CFI ||
        current_state == UBP_CFI))
        begin
            CrossData = 16'bx;
            BusyBOUND = 1'b1;
        // PPB mode bank
        end
        else if (BankCHECK == BankPPB && (current_state == PPB_CMDSET ||
        current_state == ESP_PPB || current_state == PSP_PPB))
        begin
            CrossData = 0;
            CrossData[0] = PPB[SectorCHECK];
            BusyBOUND = 1'b1;
        end
        // DYB mode bank
        else if (BankCHECK == BankDYB && (current_state == DYB_CMDSET ||
        current_state == ESP_DYB || current_state == PSP_DYB))
        begin
            CrossData = 0;
            CrossData[0] = DYB[SectorCHECK];
            BusyBOUND = 1'b1;
        end
        // Lock Register mode bank
        else if (BankCHECK == 0 && (current_state == LOCKREG_CMDSET))
        begin
            CrossData = LockReg;
            BusyBOUND = 1'b1;
        end
        // Password mode bank
        else if (BankCHECK == 0 && (BankMODE == PasswordENABLED))
        begin
            CrossData = Password[0];
            if ( LockReg[2] == 1'b0 )
                CrossData = ~(0);
            BusyBOUND = 1'b1;
        end
        // PPBLock mode bank
        else if (BankCHECK == BankPPBLOCK &&
        (current_state == PPBLOCK_CMDSET ||
        current_state == ESP_PPBLOCK || current_state == PSP_PPBLOCK))
        begin
            CrossData = 0;
            CrossData[0] = PPBLock;
            BusyBOUND = 1'b1;
        end
        // Busy programming
        else if (BankCHECK == BankPROGRAM && (
        current_state == PGMS || current_state == PSPS ||
        (current_state == WBPGMS_WBABORT)))
        begin
            CrossData = Status;
            BusyBOUND = 1'b1;
        end
        // Busy erasing
        else if (BankERASE[BankCHECK] &&
        (current_state == SERS || current_state == SERS_EXEC ||
        current_state == ESPS))
        begin
            CrossData = Status;
            BusyBOUND = 1'b1;
        end
        //Erase Suspended
        else if (Ers_queue[SectorCHECK] && (
        current_state == ESP     ||
        current_state == ESP_CFI || current_state == ESP_AS ||
        current_state == ESP_PPB || current_state == ESP_DYB ||
        current_state == ESP_OTP))
        begin
            CrossData = Status;
            BusyBOUND = 1'b1;
        end
        // Programming issued from Erase Suspend
        else if (Ers_queue[SectorCHECK] && ESP_ACT && (
        current_state == PGMS || current_state == PSPS ||
        current_state == PSP  ||
        current_state == PSP_CFI || current_state == PSP_AS ||
        current_state == PSP_PPB || current_state == PSP_DYB ||
        current_state == PSP_OTP))
        begin
            CrossData = Status;
            BusyBOUND = 1'b1;
        end
        //Program Suspended - not allowed
        else if (((SectorCHECK == SA && ~WB_FLAG) ||
        (SectorCHECK == SA_WriteBuffer && WB_FLAG)) && (
        current_state == PSP ||
        current_state == PSP_CFI || current_state == PSP_AS ||
        current_state == PSP_PPB || current_state == PSP_DYB ||
        current_state == PSP_OTP))
        begin
            CrossData = 16'bx;
            BusyBOUND = 1'b1;
        end
        else if (BankCHECK == BankPPB &&
        (current_state == PPB_PROG || current_state == PPB_ERS))
        begin
            CrossData = Status;
            BusyBOUND = 1'b1;
        end
        BusyBOUND =
        (BusyBOUND &&
        ( ReturnBank(AddrCHECK)!= BankCHECK ||
        ReturnSectorID(AddrCHECK)!= SectorCHECK ));
    end
    endtask

    task CheckWrap;
    input  WrapMaxCOND;
    inout  WrapMax;
    inout  WITHOUT_WRAP;

    integer WrapMax;

    begin
        if ( WrapMaxCOND )
        begin
            WrapMax = WrapMax - 1;
            if ( WrapMax == 1 )
                WITHOUT_WRAP = 1'b1;
        end
    end
    endtask

    task DetectFrequency;
    output Freq;
    integer Freq;
    begin
        Freq = 0;
    end
    endtask

    reg  BuffInOE, BuffInCE, BuffInADDR;
    wire BuffOutOE, BuffOutCE, BuffOutADDR;

    BUFFER    BUFOE          (BuffOutOE  , BuffInOE);
    BUFFER    BUFCE          (BuffOutCE  , BuffInCE);
    BUFFER    BUFADDR        (BuffOutADDR, BuffInADDR);

    initial
    begin
        BuffInOE    = 1'b1;
        BuffInCE    = 1'b1;
        BuffInADDR  = 1'b1;
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
