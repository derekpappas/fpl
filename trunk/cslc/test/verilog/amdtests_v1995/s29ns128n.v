//////////////////////////////////////////////////////////////////////////////
//  File name : s29ns128n.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODifICATION HISTORY :
//
//  version:  | author:      |   date:     | changes made:
//    V1.0      T.Popovic      04 Aug 30    Initial Release
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           S29NS128N
//
//  Description:   128 Megabit (8 M x 16-Bit)
//                 Simultaneous Read/Write, Burst Mode Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Comments :
//      For correct simulation, simulator resolution should be set to 1ps
//      Refer to s29ns datasheet, burst operating frequency sections
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps

module s29ns128n
(
    A22      ,
    A21      ,
    A20      ,
    A19      ,
    A18      ,
    A17      ,
    A16      ,

    ADQ15    ,
    ADQ14    ,
    ADQ13    ,
    ADQ12    ,
    ADQ11    ,
    ADQ10    ,
    ADQ9     ,
    ADQ8     ,
    ADQ7     ,
    ADQ6     ,
    ADQ5     ,
    ADQ4     ,
    ADQ3     ,
    ADQ2     ,
    ADQ1     ,
    ADQ0     ,

    CLK      ,
    RESETNeg ,
    CENeg    ,
    OENeg    ,
    WENeg    ,
    AVDNeg   ,
    WPNeg    ,
    ACC      ,
    RDY
);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////

    input  A22  ;
    input  A21  ;
    input  A20  ;
    input  A19  ;
    input  A18  ;
    input  A17  ;
    input  A16  ;

    inout  ADQ15 ;
    inout  ADQ14 ;
    inout  ADQ13 ;
    inout  ADQ12 ;
    inout  ADQ11 ;
    inout  ADQ10 ;
    inout  ADQ9  ;
    inout  ADQ8  ;
    inout  ADQ7  ;
    inout  ADQ6  ;
    inout  ADQ5  ;
    inout  ADQ4  ;
    inout  ADQ3  ;
    inout  ADQ2  ;
    inout  ADQ1  ;
    inout  ADQ0  ;

    input  CLK      ;
    input  RESETNeg ;
    input  CENeg    ;
    input  OENeg    ;
    input  WENeg    ;
    input  AVDNeg   ;
    input  WPNeg    ;
    input  ACC      ;
    output RDY      ;

// interconnect path delay signals

    wire  A22_ipd  ;
    wire  A21_ipd  ;
    wire  A20_ipd  ;
    wire  A19_ipd  ;
    wire  A18_ipd  ;
    wire  A17_ipd  ;
    wire  A16_ipd  ;

    wire  ADQ15_ipd ;
    wire  ADQ14_ipd ;
    wire  ADQ13_ipd ;
    wire  ADQ12_ipd ;
    wire  ADQ11_ipd ;
    wire  ADQ10_ipd ;
    wire  ADQ9_ipd  ;
    wire  ADQ8_ipd  ;
    wire  ADQ7_ipd  ;
    wire  ADQ6_ipd  ;
    wire  ADQ5_ipd  ;
    wire  ADQ4_ipd  ;
    wire  ADQ3_ipd  ;
    wire  ADQ2_ipd  ;
    wire  ADQ1_ipd  ;
    wire  ADQ0_ipd  ;

    wire [22 : 0] A;
    assign A = {
                A22_ipd,
                A21_ipd,
                A20_ipd,
                A19_ipd,
                A18_ipd,
                A17_ipd,
                A16_ipd,
                ADQ15_ipd,
                ADQ14_ipd,
                ADQ13_ipd,
                ADQ12_ipd,
                ADQ11_ipd,
                ADQ10_ipd,
                ADQ9_ipd,
                ADQ8_ipd,
                ADQ7_ipd,
                ADQ6_ipd,
                ADQ5_ipd,
                ADQ4_ipd,
                ADQ3_ipd,
                ADQ2_ipd,
                ADQ1_ipd,
                ADQ0_ipd };

    wire [15 : 0 ] DIn;
    assign DIn = {ADQ15_ipd,
                  ADQ14_ipd,
                  ADQ13_ipd,
                  ADQ12_ipd,
                  ADQ11_ipd,
                  ADQ10_ipd,
                  ADQ9_ipd,
                  ADQ8_ipd,
                  ADQ7_ipd,
                  ADQ6_ipd,
                  ADQ5_ipd,
                  ADQ4_ipd,
                  ADQ3_ipd,
                  ADQ2_ipd,
                  ADQ1_ipd,
                  ADQ0_ipd };

    wire [15 : 0 ] DOut;
    assign DOut = {ADQ15,
                   ADQ14,
                   ADQ13,
                   ADQ12,
                   ADQ11,
                   ADQ10,
                   ADQ9,
                   ADQ8,
                   ADQ7,
                   ADQ6,
                   ADQ5,
                   ADQ4,
                   ADQ3,
                   ADQ2,
                   ADQ1,
                   ADQ0 };

    wire  CLK_ipd      ;
    wire  RESETNeg_ipd ;
    wire  CENeg_ipd    ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  AVDNeg_ipd   ;
    wire  WPNeg_ipd    ;
    wire  ACC_ipd      ;

//  internal delays

    reg PWO_in          ;
    reg PWO_out         ;
    reg WRBO_in         ;
    reg WRBO_out        ;
    reg SEO16_in        ;
    reg SEO16_out       ;
    reg SEO64_in        ;
    reg SEO64_out       ;
    reg ACCT_in         ;
    reg ACCT_out        ;
    reg IACC_in         ;
    reg IACC_out        ;
    reg PPBP_in         ;
    reg PPBP_out        ;
    reg PPBE_in         ;
    reg PPBE_out        ;
    reg PUT_in          ;
    reg PUT_out         ;
    reg START_in        ;
    reg START_out       ;
    reg SET_in          ;
    reg SET_out         ;
    reg HANG_in         ;
    reg HANG_out        ;

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

    reg RDY_zd;
    reg RDY_temp = 1'b0;

    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name = "none";
    parameter UserPreload     = 1'b0;
    parameter TimingModel = "DefaultTimingModel";

    parameter PartID         = "s29ns128n";
    parameter MaxData        = 16'hFFFF;
    parameter MaxAddr        = 24'h7FFFFF;
    parameter SecNum         = 130;
    parameter BankNum        = 15;
    parameter SecGroupNum    = 1;
    parameter Sec16Num       = 3;
    parameter SecSize64      = 16'hFFFF;
    parameter SecSize16      = 16'h3FFF;
    parameter BankSize       = 20'h7FFFF;
    parameter SecBit64       = 7;
    parameter SecBit16       = 9;
    parameter BankBit        = 4;
    parameter HiAddrBit      = 22;
    parameter PWLength       = 3;
    parameter WrBuffLength   = 31;
    parameter WrBuffPgNum    = 20'h7FFFF;

    //varaibles to resolve between Standard/Reduced devices
    reg [20*8:1] handle_string;//stores copy of TimingModel
    reg [7:0] fetch_char;//stores "t" or "b" character
    integer found = 1'b0;

    // powerup
    reg PoweredUp;

    reg SYN; //Synchronous mode
    reg CLK_PATH_EN;

    //FSM control signals
    reg ULBYPASS  =1'b0;//Unlock Bypass Active
    reg ESP_ACT   =1'b0;//Erase Suspend
    reg PSP_ACT   =1'b0;//Program Suspend
    reg LOCK_ACT  =1'b0;//Lock Register program
    reg PASS_ACT  =1'b0;//Password program
    reg WRBUFF_ACT=1'b0;//Wrbuffer program
    reg SecSi     =1'b0;//SecSi Sector mapped in Sec 0

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

    reg WP_l     ;// WP control signal
    reg HI_FREQ  ;// signal that indicates clk frequency
    integer WS_FREQ;// number of ws needed- depends of frequency

    //Sectors selected for erasure
    reg [SecNum:0]  ERS_QUEUE; // = SecNum'b0;
    //Banks selected for erasure
    reg [BankNum:0] ERS_QUEUE_B; // = BankNum'b0;

    //Command Register
    reg write               = 1'b0;
    reg write_asyc          = 1'b0;
    reg read                = 1'b0;
    reg burst_rd            = 1'b0;
    reg burst_oe            = 1'b0;
    reg sector_switch_chk   = 1'b0;

    //Parameters of bank specific operations
    //Supports 15 (or less) bank architecture
    reg[3:0]  BankPassAddr;
    reg[3:0]  BankASAddr;
    reg[3:0]  BankPgSuspAddr;
    reg[3:0]  BankErSuspAddr;
    reg[3:0]  BankDYBAddr;
    reg[3:0]  BankPPBAddr;
    reg[3:0]  BankPPBLAddr;
    reg[4:0]  PrgBank; //must support -1 recognition

    // write buffer signals
    integer WrBuffSec;
    integer WrBuffPage;
    integer WrBuffCnt;
    integer WrCnt;
    integer WrBuffData[0:WrBuffLength];
    integer WrBuffAddr[0:WrBuffLength];

    //password signals
    integer PASS_UNLCK  = 1'b0;
    integer PASS_TEMP[0:PWLength];

    //protection bit signals
    integer SecDYBAddr;
    integer SecPPBAddr;

    //Address
    integer Address  = -1;          // -1 - MaxAddr
    //Address 11 downto 0
    integer AddrCom  = 0;
    integer AddrPass = 0;           // 0 - 3
    //Sector Address
    integer SecAddr  = -1;          // -1 - SecNum
    //Bank Address
    integer BankAddr = -1;          // 0 - BankNum
    //Write page buffer address
    integer BuffPageAddr = -1;      // -1 - WrBuffPgNum

    integer Data;       //-1 TO MaxData;
    integer DataLo;     //0 TO MaxData;

    //glitch protection
    wire gWE_n ;
    wire gCE_n ;
    wire gOE_n ;
    reg RST ;
    reg reseted ;

    //Memory
    integer Mem[0:MaxAddr];
    integer SecSiMem[0:8'hFF];
    integer CFIMem[8'h10:8'h68];
    reg[15:0] CONF_REG;
    reg[15:0] LOCK_REG;
    //Sector Protection status
    integer Password[0:PWLength];
    reg[SecNum:0] DYB;
    reg[SecNum:0] PPB;
    reg PPB_LOCK;

    reg[SecNum:0] Boot_Sec = 0;

    // timing check violation
    reg Viol = 1'b0;

    reg HWResetGlitch = 1'b0;
    reg HWResetStart  = 1'b0;
    reg Glitch = 1'b0;

    // used to determine clock frequency
    time LAST_CLK = 0;

    // StateTransition values
    reg R;
    reg E;

    //Bus Cycle Decode
    reg[HiAddrBit:0] A_tmp;
    integer LatchedWrAddr;
    reg RD;
    reg LATCHED;

    //StateGen
    //Command Sequence detection
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_1    = 1'b0;

    //Functional
    integer WS_CNT;
    reg Prior_IACC;
    reg oe = 1'b0;
    reg we = 1'b0;
    //status reg.
    reg[15:0] status = 16'b0;
    reg[15:0]  old_bit;
    reg[15:0]  new_bit;
    integer old_int;
    integer new_int;
    reg[7:0] temp;
    integer x;
    //Burst Params
    integer BurstAddr;
    integer BurstSec;
    integer BurstLength;
    integer RdCnt;
    reg [15 : 0] DOut_burst;

    integer DelayCyc_CNT;
    integer DelayCycSwitch;
    integer BoundarySwitch;

    reg ONE_READ;
    reg CONF_REG_8;
    //Burst mode control
    reg INITIAL_WAIT;
    reg INITIAL_ACCESS;
    reg BOUNDARY_CROSS;
    reg NO_PROGRESS;
    reg BURST_END;
    reg IN_W_ELAPSED;

    integer i,j,k;

    //TPD_XX_DATA
    time OEDQ_t;
    time CEDQ_t;
    time ADDRDQ_t;
    time AddrTime;
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

    reg [6:0] current_state;
    reg [6:0] next_state;
    reg [2:0] RD_MODE;

    // FSM states
    parameter RESET                 =8'h00;
    parameter Z001                  =8'h01;
    parameter CFI                   =8'h02;
    parameter PREL_SETBWB           =8'h03;
    parameter PREL_ULBYPASS         =8'h04;
    parameter PREL_ULBYPASS_RESET   =8'h05;
    parameter A0SEEN                =8'h06;
    parameter C8                    =8'h07;
    parameter C8_Z001               =8'h08;
    parameter C8_PREL               =8'h09;
    parameter ERS                   =8'h0A;
    parameter SERS                  =8'h0B;
    parameter ESPS                  =8'h0C;
    parameter SERS_EXEC             =8'h0D;
    parameter ESP                   =8'h0E;
    parameter ESP_Z001              =8'h0F;
    parameter ESP_PREL              =8'h10;
    parameter PREL_WR2BUFF          =8'h11;
    parameter WR2BUFF_0             =8'h12;
    parameter WR2BUFF_CNT           =8'h13;
    parameter PREL_PRFLASH          =8'h14;
    parameter PGMS                  =8'h15;
    parameter PGSPS                 =8'h16;
    parameter PGS                   =8'h17;
    parameter PGS_Z001              =8'h18;
    parameter PGS_PREL              =8'h19;
    parameter WR2BUFF_AB            =8'h1A;
    parameter WR2BUFF_AB_Z001       =8'h1B;
    parameter WR2BUFF_AB_PREL       =8'h1C;
    parameter AS                    =8'h1D;
    parameter SECSI_EX              =8'h1E;
    parameter SET_CONF              =8'h1F;
    parameter RD_CONF               =8'h20;
    parameter PREL_PASS             =8'h21;
    parameter PASS_A0SEEN           =8'h22;
    parameter PASS_EX               =8'h23;
    parameter PASS_UN_Z001          =8'h24;
    parameter PASS_UN_PREL          =8'h25;
    parameter PASS_UN1              =8'h26;
    parameter PASS_UN2              =8'h27;
    parameter PASS_UN3              =8'h28;
    parameter PASS_UN4              =8'h29;
    parameter PASS_UN_W             =8'h2A;
    parameter PREL_LR               =8'h2B;
    parameter LR_A0SEEN             =8'h2C;
    parameter LR_PREL_EX            =8'h2D;
    parameter PREL_PPB              =8'h2E;
    parameter PPB_PREL_PR           =8'h2F;
    parameter PPB_PGMS              =8'h30;
    parameter PPB_PREL_ER           =8'h31;
    parameter PPB_ERS               =8'h32;
    parameter PPB_PREL_EX           =8'h33;
    parameter PREL_PPBLCK           =8'h34;
    parameter PPBLCK_PREL_ST        =8'h35;
    parameter PPBLCK_PREL_EX        =8'h36;
    parameter PREL_DYB              =8'h37;
    parameter DYB_PREL_ST           =8'h38;
    parameter DYB_PREL_EX           =8'h39;
    parameter SECSI_A0SEEN          =8'h3A;
    parameter HW_RESET_UNKNOWN      =8'h3B;
    parameter HW_RESET_INIT         =8'h3C;

    //read mode
    parameter NONE              = 4'd0;
    parameter SINGLE_RD         = 4'd1;
    parameter LINEAR            = 4'd2;
    parameter LINEAR_NO_WRAP    = 4'd3;
    parameter CONTINUOUS        = 4'd4;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
    buf   (A22_ipd, A22);
    buf   (A21_ipd, A21);
    buf   (A20_ipd, A20);
    buf   (A19_ipd, A19);
    buf   (A18_ipd, A18);
    buf   (A17_ipd, A17);
    buf   (A16_ipd, A16);

    buf   (ADQ15_ipd, ADQ15);
    buf   (ADQ14_ipd, ADQ14);
    buf   (ADQ13_ipd, ADQ13);
    buf   (ADQ12_ipd, ADQ12);
    buf   (ADQ11_ipd, ADQ11);
    buf   (ADQ10_ipd, ADQ10);
    buf   (ADQ9_ipd , ADQ9 );
    buf   (ADQ8_ipd , ADQ8 );
    buf   (ADQ7_ipd , ADQ7 );
    buf   (ADQ6_ipd , ADQ6 );
    buf   (ADQ5_ipd , ADQ5 );
    buf   (ADQ4_ipd , ADQ4 );
    buf   (ADQ3_ipd , ADQ3 );
    buf   (ADQ2_ipd , ADQ2 );
    buf   (ADQ1_ipd , ADQ1 );
    buf   (ADQ0_ipd , ADQ0 );

    buf   (CLK_ipd      , CLK      );
    buf   (RESETNeg_ipd , RESETNeg );
    buf   (CENeg_ipd    , CENeg    );
    buf   (OENeg_ipd    , OENeg    );
    buf   (WENeg_ipd    , WENeg    );
    buf   (AVDNeg_ipd   , AVDNeg   );
    buf   (WPNeg_ipd    , WPNeg    );
    buf   (ACC_ipd      , ACC      );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (ADQ15,   DQ15_Pass , 1);
    nmos   (ADQ14,   DQ14_Pass , 1);
    nmos   (ADQ13,   DQ13_Pass , 1);
    nmos   (ADQ12,   DQ12_Pass , 1);
    nmos   (ADQ11,   DQ11_Pass , 1);
    nmos   (ADQ10,   DQ10_Pass , 1);
    nmos   (ADQ9 ,   DQ9_Pass  , 1);
    nmos   (ADQ8 ,   DQ8_Pass  , 1);
    nmos   (ADQ7 ,   DQ7_Pass  , 1);
    nmos   (ADQ6 ,   DQ6_Pass  , 1);
    nmos   (ADQ5 ,   DQ5_Pass  , 1);
    nmos   (ADQ4 ,   DQ4_Pass  , 1);
    nmos   (ADQ3 ,   DQ3_Pass  , 1);
    nmos   (ADQ2 ,   DQ2_Pass  , 1);
    nmos   (ADQ1 ,   DQ1_Pass  , 1);
    nmos   (ADQ0 ,   DQ0_Pass  , 1);

    nmos   (RDY ,    RDY_zd    , 1);

    wire deg;

 // Needed for TimingChecks
 // VHDL CheckEnable Equivalent
    wire Check_ADQ0_CLK;
    assign Check_ADQ0_CLK    =  ~CENeg && SYN && WENeg && ~AVDNeg;

    wire Check_ADQ0_AVDNeg;
    assign Check_ADQ0_AVDNeg = ~CENeg && ~OENeg;

    wire Check_ADQ0_WENeg;
    assign Check_ADQ0_WENeg  = ~CENeg && OENeg;

    wire Check_OENeg_WENeg;
    assign Check_OENeg_WENeg = ~PDONE || ~EDONE;

    wire Check_AVDNeg_CLK;
    assign Check_AVDNeg_CLK  = ~CENeg && ~AVDNeg && SYN;

    wire Check_CENeg_CLK;
    assign Check_CENeg_CLK   = SYN;

    wire CLK_PATH_ENABLE;
    assign CLK_PATH_ENABLE   = CLK_PATH_EN && SYN;

specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

    specparam       tpd_RESETNeg_ADQ0       =   1;//tACC
    specparam       tpd_CENeg_ADQ0_SYN_EQ_1 =   1;//tce, tcez in syn
    specparam       tpd_OENeg_ADQ0_SYN_EQ_1 =   1;//toe, toez in syn
    specparam       tpd_CENeg_ADQ0_SYN_EQ_0 =   1;//tce, tcez in asyn
    specparam       tpd_OENeg_ADQ0_SYN_EQ_0 =   1;//toe, toez in asyn
    specparam       tpd_CENeg_RDY           =   1;//tcr, tcez
    specparam       tpd_OENeg_RDY           =   1;//toe, toez
    specparam       tpd_CLK_ADQ0            =   1;//tcka/tbacc
    specparam       tpd_CLK_RDY             =   1;//tracc

    //tsetup values
    specparam       tsetup_ADQ0_AVDNeg      =   1;//taavds,taas,/
    specparam       tsetup_ADQ0_CLK         =   1;//tacs
    specparam       tsetup_CENeg_CLK        =   1;//tces
    specparam       tsetup_AVDNeg_CLK       =   1;//tavds
    specparam       tsetup_ADQ0_WENeg       =   1;//tds,/
    specparam       tsetup_CENeg_WENeg      =   1;//tcs

    //thold values
    specparam       thold_CENeg_RESETNeg    =   1;//tRH,/
    specparam       thold_OENeg_RESETNeg    =   1;//tRH,/
    specparam       thold_ADQ0_AVDNeg       =   1;//tAAVDH,tAAH,/
    specparam       thold_ADQ0_CLK          =   1;//tACH
    specparam       thold_AVDNeg_CLK        =   1;//tAVH
    specparam       thold_OENeg_WENeg       =   1;//toeh,/
    specparam       thold_CENeg_WENeg       =   1;//tch,\
    specparam       thold_OENeg_AVDNeg      =   1;//tavdo,\
    specparam       thold_ADQ0_WENeg        =   1;//tdh /

    //tpw values
    specparam       tpw_RESETNeg_negedge    =   1;//tRP
    specparam       tpw_CLK_negedge         =   1;//tCL
    specparam       tpw_CLK_posedge         =   1;//tCH
    specparam       tpw_AVDNeg_negedge      =   1;//tAVDP
    specparam       tpw_WENeg_negedge       =   1;//tWP
    specparam       tpw_WENeg_posedge       =   1;//tWPH
    specparam       tperiod_CLK             =   1;//tCLK


    //tdevice values: values for internal delays
    specparam       tdevice_PWO             =   40000;
    specparam       tdevice_WRBO            =   9400;
    //Sector Erase Operation
    specparam       tdevice_SEO64           =   600000000;
    specparam       tdevice_SEO16           =   150000000;
    //program/erase suspend timeout
    specparam       tdevice_START           =   35000;
    //sector erase command sequence timeout
    specparam       tdevice_SET             =   50000;
    //device ready after Hardware reset(during embeded algorithm)
    //Protection Bit Program
    specparam       tdevice_PPBP            =   150000;
    //Protection Bit Erase
    specparam       tdevice_PPBE            =   15000000;
    //Password Unlock
    specparam       tdevice_PUT             =   1000;

    //Tacc and Tiacc - access times
    //Must be specifed aligned to model timescale due to its usage
    //within path delay dection and access time calculations
    specparam       tdevice_TIACC_ts        =   69000;
    specparam       tdevice_IACC_ts         =   70000;

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

// Data ouptut paths
    if (FROMCE && SYN )
            ( CENeg => ADQ0 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ1 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ2 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ3 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ4 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ5 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ6 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ7 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ8 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ9 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ10 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ11 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ12 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ13 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ14 ) = tpd_CENeg_ADQ0_SYN_EQ_1;
    if (FROMCE && SYN )
            ( CENeg => ADQ15 ) = tpd_CENeg_ADQ0_SYN_EQ_1;

    if (FROMOE && SYN )
            ( OENeg => ADQ0 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ1 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ2 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ3 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ4 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ5 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ6 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ7 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ8 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ9 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ10 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ11 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ12 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ13 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ14 ) = tpd_OENeg_ADQ0_SYN_EQ_1;
    if (FROMOE && SYN )
            ( OENeg => ADQ15 ) = tpd_OENeg_ADQ0_SYN_EQ_1;

    if (FROMCE && ~SYN )
            ( CENeg => ADQ0 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ1 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ2 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ3 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ4 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ5 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ6 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ7 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ8 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ9 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ10 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ11 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ12 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ13 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ14 ) = tpd_CENeg_ADQ0_SYN_EQ_0;
    if (FROMCE && ~SYN )
            ( CENeg => ADQ15 ) = tpd_CENeg_ADQ0_SYN_EQ_0;

    if (FROMOE && ~SYN )
            ( OENeg => ADQ0 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ1 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ2 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ3 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ4 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ5 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ6 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ7 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ8 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ9 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ10 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ11 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ12 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ13 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ14 ) = tpd_OENeg_ADQ0_SYN_EQ_0;
    if (FROMOE && ~SYN )
            ( OENeg => ADQ15 ) = tpd_OENeg_ADQ0_SYN_EQ_0;

    if (~RESETNeg)
        ( RESETNeg => ADQ0 ) = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ1 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ2 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ3 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ4 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ5 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ6 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ7 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ8 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ9 )  = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ10 ) = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ11 ) = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ12 ) = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ13 ) = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ14 ) = tpd_RESETNeg_ADQ0;
    if (~RESETNeg)
        ( RESETNeg => ADQ15 ) = tpd_RESETNeg_ADQ0;

    if (CLK_PATH_ENABLE)
            ( CLK => ADQ0 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ1 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ2 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ3 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ4 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ5 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ6 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ7 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ8 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ9 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ10 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ11 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ12 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ13 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ14 ) = tpd_CLK_ADQ0;
    if (CLK_PATH_ENABLE)
            ( CLK => ADQ15 ) = tpd_CLK_ADQ0;

// RDY output paths
    (CENeg => RDY) = tpd_CENeg_RDY;

    if ( ~CENeg && SYN )
        ( OENeg =>  RDY ) = tpd_OENeg_RDY;

    if ( CLK_PATH_ENABLE )
        ( CLK =>  RDY ) = tpd_CLK_RDY;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

        $setup ( ADQ0  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ1  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ2  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ3  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ4  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ5  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ6  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ7  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ8  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ9  , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ10 , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ11 , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ12 , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ13 , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ14 , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( ADQ15 , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A16   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A17   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A18   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A19   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A20   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A21   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);
        $setup ( A22   , posedge CLK &&& Check_ADQ0_CLK , tsetup_ADQ0_CLK,Viol);

        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ0 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ1 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ2 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ3 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ4 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ5 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ6 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ7 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ8 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ9 ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ10,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ11,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ12,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ13,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ14,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , ADQ15,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A16  ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A17  ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A18  ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A19  ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A20  ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A21  ,   thold_ADQ0_CLK, Viol);
        $hold ( posedge CLK &&& Check_ADQ0_CLK , A22  ,   thold_ADQ0_CLK, Viol);

        $setup ( ADQ0    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ1    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ2    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ3    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ4    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ5    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ6    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ7    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ8    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ9    , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ10   , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ11   , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ12   , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ13   , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ14   , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( ADQ15   , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A16     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A17     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A18     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A19     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A20     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A21     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);
        $setup ( A22     , posedge AVDNeg &&& Check_ADQ0_AVDNeg,
                                                     tsetup_ADQ0_AVDNeg, Viol);

        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ0    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ1    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ2    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ3    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ4    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ5    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ6    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ7    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ8    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ9    ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ10   ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ11   ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ12   ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ13   ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ14   ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, ADQ15   ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A16     ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A17     ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A18     ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A19     ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A20     ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A21     ,
                                                       thold_ADQ0_AVDNeg, Viol);
        $hold ( posedge AVDNeg &&& Check_ADQ0_AVDNeg, A22     ,
                                                       thold_ADQ0_AVDNeg, Viol);


        $setup ( ADQ0    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                       tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ1    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                       tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ2    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ3    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ4    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ5    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ6    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ7    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ8    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ9    , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ10   , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ11   , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ12   , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ13   , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ14   , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);
        $setup ( ADQ15   , posedge WENeg &&& Check_ADQ0_WENeg,
                                                     tsetup_ADQ0_WENeg, Viol);

        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ0    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ1    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ2    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ3    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ4    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ5    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ6    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ7    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ8    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ9    ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ10   ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ11   ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ12   ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ13   ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ14   ,
                                                        thold_ADQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& Check_ADQ0_WENeg, ADQ15   ,
                                                        thold_ADQ0_WENeg, Viol);

        $setup ( AVDNeg    ,posedge CLK &&& Check_AVDNeg_CLK,
                                                      tsetup_AVDNeg_CLK, Viol);
        $hold ( posedge CLK &&& Check_AVDNeg_CLK, AVDNeg    ,
                                                      thold_AVDNeg_CLK, Viol);

        $setup ( CENeg    , posedge CLK &&& Check_CENeg_CLK,
                                                      tsetup_CENeg_CLK, Viol);

        $setup ( CENeg  , negedge WENeg,   tsetup_CENeg_WENeg, Viol);
        $hold ( posedge WENeg ,   CENeg,   thold_CENeg_WENeg,  Viol);

        $hold ( posedge WENeg   , OENeg &&& Check_OENeg_WENeg,
                                                    thold_OENeg_WENeg, Viol);
        $hold ( posedge AVDNeg  , OENeg &&& ~CENeg           ,
                                                    thold_OENeg_AVDNeg, Viol);

        $hold ( posedge RESETNeg, CENeg     ,  thold_CENeg_RESETNeg, Viol);
        $hold ( posedge RESETNeg, OENeg     ,  thold_OENeg_RESETNeg, Viol);

        $width (negedge RESETNeg, tpw_RESETNeg_negedge);
        $width (negedge AVDNeg  , tpw_AVDNeg_negedge);
        $width (posedge WENeg   , tpw_WENeg_posedge);
        $width (negedge WENeg   , tpw_WENeg_negedge);
        $width (posedge CLK     , tpw_CLK_posedge);
        $width (negedge CLK     , tpw_CLK_negedge);
        $period(negedge CLK, tperiod_CLK);
        $period(posedge CLK, tperiod_CLK);

    endspecify

    //tdevice parameters aligned to model timescale
    //32bits exceeded
    time       tdevice_PWO_ts     = tdevice_PWO * 1000;
    time       tdevice_WRBO_ts    = tdevice_WRBO * 1000;
    //Sector Erase Operation
    time       tdevice_SEO64_ts   = tdevice_SEO64 * 1000;
    time       tdevice_SEO16_ts   = tdevice_SEO16 * 1000;
    //program/erase suspend timeout
    time       tdevice_START_ts   = tdevice_START * 1000;
    //sector erase command sequence timeout
    time       tdevice_SET_ts     = tdevice_SET * 1000;
    //device ready after Hardware reset(during embeded algorithm)
    //Protection Bit Program
    time       tdevice_PPBP_ts    = tdevice_PPBP * 1000;
    //Protection Bit Erase
    time       tdevice_PPBE_ts    = tdevice_PPBE * 1000;
    //Password Unlock
    time       tdevice_PUT_ts     = tdevice_PUT * 1000;

    //Used as wait periods
    time       poweredupT_ts   = 1000000000; // 1 ms
    time       resetpulseT_ts  = 20000000;   // 20 us
    time       boundary66MHz_ts= 15152;
    time       boundary68MHz_ts= 14706;
    time       boundary54MHz_ts= 18519;
    time       boundary40MHz_ts= 25000;
    time       perrpulseT_ts   = 1000000;
    time       eerrpulseT_ts   = 100000000;
    time       wepulseT_ts     = 3000;       // 3 ns

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
            //tACC relevant for asynchronous access time
            ADDRDQ_t = AddrTime   + ADDRDQ_01;
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
                if (CONF_REG[15])
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
           DOut_Pass = 16'bz;
       end
    end

    //////////////////////////////////////////////////////////
    //          RDY Pin Value Gen
    //////////////////////////////////////////////////////////

    always @(RDY_temp,OENeg,CENeg)
    begin
        if (~CENeg)
        begin
            if (SYN)
            begin
                if (~OENeg)
                begin
                    if ( CONF_REG[10])
                        RDY_zd = RDY_temp;
                    else
                        RDY_zd = ~RDY_temp;
                end
                else
                    RDY_zd = CONF_REG[10];
            end
            else
                RDY_zd = 1'b1;
        end
        else
            RDY_zd = 1'bz;
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

    integer TMindex;
    initial
    begin
        for (i=0;i<=SecNum;i=i+1)
        begin
            ERS_QUEUE[i] = 0;
        end

        for (i=0;i<=BankNum;i=i+1)
        begin
            ERS_QUEUE_B[i] = 0;
        end

        //////////////////////////////////////////////////////////////////-
        //CFI array data / S29NS128N DEVICE SPECIFIC
        //////////////////////////////////////////////////////////////////-
        //CFI query identification string
        CFIMem[16'h10] = 16'h51;
        CFIMem[16'h11] = 16'h52;
        CFIMem[16'h12] = 16'h59;
        CFIMem[16'h13] = 16'h02;
        CFIMem[16'h14] = 16'h00;
        CFIMem[16'h15] = 16'h40;
        CFIMem[16'h16] = 16'h00;
        CFIMem[16'h17] = 16'h00;
        CFIMem[16'h18] = 16'h00;
        CFIMem[16'h19] = 16'h00;
        CFIMem[16'h1A] = 16'h00;
            //System interface string
        CFIMem[16'h1B] = 16'h17;
        CFIMem[16'h1C] = 16'h19;
        CFIMem[16'h1D] = 16'h00;
        CFIMem[16'h1E] = 16'h00;
        CFIMem[16'h1F] = 16'h06;
        CFIMem[16'h20] = 16'h09;
        CFIMem[16'h21] = 16'h0A;
        CFIMem[16'h22] = 16'h00;
        CFIMem[16'h23] = 16'h03;
        CFIMem[16'h24] = 16'h01;
        CFIMem[16'h25] = 16'h02;
        CFIMem[16'h26] = 16'h00;
            //device geometry definition
        CFIMem[16'h27] = 16'h18;
        CFIMem[16'h28] = 16'h01;
        CFIMem[16'h29] = 16'h00;
        CFIMem[16'h2A] = 16'h06;
        CFIMem[16'h2B] = 16'h00;
        CFIMem[16'h2C] = 16'h02;
        CFIMem[16'h2D] = 16'h7E;
        CFIMem[16'h2E] = 16'h00;
        CFIMem[16'h2F] = 16'h00;
        CFIMem[16'h30] = 16'h02;
        CFIMem[16'h31] = 16'h03;
        CFIMem[16'h32] = 16'h00;
        CFIMem[16'h33] = 16'h80;
        CFIMem[16'h34] = 16'h00;
        CFIMem[16'h35] = 16'h00;
        CFIMem[16'h36] = 16'h00;
        CFIMem[16'h37] = 16'h00;
        CFIMem[16'h38] = 16'h00;
        CFIMem[16'h39] = 16'h00;
        CFIMem[16'h3A] = 16'h00;
        CFIMem[16'h3B] = 16'h00;
        CFIMem[16'h3C] = 16'h00;
            //primary vendor-specific extended query
        CFIMem[16'h40] = 16'h50;
        CFIMem[16'h41] = 16'h52;
        CFIMem[16'h42] = 16'h49;
        CFIMem[16'h43] = 16'h31;
        CFIMem[16'h44] = 16'h34;
        CFIMem[16'h45] = 16'h10;
        CFIMem[16'h46] = 16'h02;
        CFIMem[16'h47] = 16'h01;
        CFIMem[16'h48] = 16'h00;
        CFIMem[16'h49] = 16'h08;
        CFIMem[16'h4A] = 16'h78;
        CFIMem[16'h4B] = 16'h01;
        CFIMem[16'h4C] = 16'h00;
        CFIMem[16'h4D] = 16'h85;
        CFIMem[16'h4E] = 16'h95;
        CFIMem[16'h4F] = 16'h03;
        CFIMem[16'h50] = 16'h01;
        CFIMem[16'h51] = 16'h01;
        CFIMem[16'h52] = 16'h08;
        CFIMem[16'h53] = 16'h14;
        CFIMem[16'h54] = 16'h14;
        CFIMem[16'h55] = 16'h05;
        CFIMem[16'h56] = 16'h05;
        CFIMem[16'h57] = 16'h10;
        CFIMem[16'h58] = 16'h08;
        CFIMem[16'h59] = 16'h08;
        CFIMem[16'h5A] = 16'h08;
        CFIMem[16'h5B] = 16'h08;
        CFIMem[16'h5C] = 16'h08;
        CFIMem[16'h5D] = 16'h08;
        CFIMem[16'h5E] = 16'h08;
        CFIMem[16'h5F] = 16'h08;
        CFIMem[16'h60] = 16'h08;
        CFIMem[16'h61] = 16'h08;
        CFIMem[16'h62] = 16'h08;
        CFIMem[16'h63] = 16'h08;
        CFIMem[16'h64] = 16'h08;
        CFIMem[16'h65] = 16'h08;
        CFIMem[16'h66] = 16'h08;
        CFIMem[16'h67] = 16'h0B;
        CFIMem[16'h68] = 16'h02;
    end

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j;
    integer tmp1,tmp2,tmp3;
    integer secsi[0:8'hFF];
    reg     sector_prot[0:SecNum];

        for (i=0;i<=MaxAddr;i=i+1)
        begin
           Mem[i]=MaxData;
        end
        for (i=0;i<8'hFF;i=i+1)
        begin
           secsi[i]=MaxData;
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
           sector_prot[i]=1'b1;
        end
        if (UserPreload && !(prot_file_name == "none"))
        begin
            //   s29ns128n prot file
            //   /       - comment
            //   @sss    - <sss> is the hexadecimal number of
            //   the sector to be protected
            //   b is 0 if the sector should be protected
            //   If not specified a sector is unprotected
            //   sss is incremented on every load
            //   No empty lines.
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
            //   s29ns128n memory file
            //   /       - comment
            //   @aaaaaa - <aaaaaa> stands for address
            //   dddd    - <dddd>   is word to be written at Mem(aaaa++)
            //  (aaaa is incremented at every load)
            //   No empty lines.--------------
           $readmemh(mem_file_name,Mem);
        end
        if (UserPreload && !(secsi_file_name == "none"))
        begin
            //   s29ns128n SecSi file
            //   /       - comment
            //   @aaaaaa - <aaaaaa> stands for address
            //   dddd    - <dddd>   is word to be written at SecSi(aaaa++)
            //  (aaaa is incremented at every load)
            //   No empty lines.
          $readmemh(secsi_file_name,secsi);
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            PPB[i] = sector_prot[i];
        end

        //SecSi Preload
        for (i=0;i<=8'hFF;i=i+1)
        begin
           SecSiMem[i] = secsi[i];
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
        #(resetpulseT_ts-1) RST <= 1'b0;
    end

    always @(posedge RESETNeg)
    begin
        disable RST_falling_edge;
        // after 200 ns
        #200000 RST <= 1'b1;
    end

    always @(posedge PoweredUp)
    begin
        for (i=0;i<=SecNum-2;i=i+1)
            Boot_Sec[i] = 1'b0;
        Boot_Sec[SecNum] = 1'b1;
        Boot_Sec[SecNum-1] = 1'b1;
    end

    initial
    begin
        SYN         = 1'b0;

        ULBYPASS    = 1'b0;
        ESP_ACT     = 1'b0;
        PSP_ACT     = 1'b0;
        LOCK_ACT    = 1'b0;
        PASS_ACT    = 1'b0;
        WRBUFF_ACT  = 1'b0;

        SecSi       = 1'b0;

        PDONE    = 1'b1;
        PSTART   = 1'b0;
        PRES     = 1'b0;
        PSUSP    = 1'b0;
        PERR     = 1'b0;

        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;
        EERR     = 1'b0;

        ERS_QUEUE = 0;
        ERS_QUEUE_B = 0;

        LAST_CLK = 0;

        WP_l     = 1'b0;
        HI_FREQ  = 1'b0;

        R = 0;
        E = 0;

        OENeg_event = 0;
        CENeg_event = 0;
        ADDR_event  = 0;
        AddrTime    = 0;

        RD_MODE = NONE;

        CONF_REG = 16'b1010111111001000;
        LOCK_REG = ~(0);
        for(i=0;i<=SecNum;i=i+1)
            DYB[i] = 1'b1;
        for(i=0;i<=3;i=i+1)
            Password[i] = MaxData;
        PPB_LOCK = 1'b1;
    end

    always @(posedge START_in)
    begin:TSTARTr
        #(tdevice_START_ts-1) START_out = START_in;
    end
    always @(negedge START_in)
    begin:TSTARTf
        #1 START_out = START_in;
    end

    // Protection Bit Program
    always @(posedge PPBP_in)
    begin : ProtProgTime
        #(tdevice_PPBP_ts - 1) PPBP_out = 1'b1;
    end
    always @(negedge PPBP_in)
    begin
        disable ProtProgTime;
        PPBP_out = 1'b0;
    end
    // Protection Bit Erase
    always @(posedge PPBE_in)
    begin : ProtEraseTime
        #(tdevice_PPBE_ts - 1) PPBE_out = 1'b1;
    end
    always @(negedge PPBE_in)
    begin
        disable ProtEraseTime;
        PPBE_out = 1'b0;
    end
    // Sector erase timeout
    always @(posedge SET_in)
    begin : SectorEraseTimeout
        #(tdevice_SET_ts - 1) SET_out = 1'b1;
    end
    always @(negedge SET_in)
    begin
        disable SectorEraseTimeout;
        SET_out = 1'b0;
    end
    // Password Unlock
    always @(posedge PUT_in)
    begin : UnlockTime
        #(tdevice_PUT_ts - 1) PUT_out = 1'b1;
    end
    always @(negedge PUT_in)
    begin
        disable UnlockTime;
        PUT_out = 1'b0;
    end
    //Initial Access
    always @(posedge IACC_in)
    begin : AccessTime
       #(tdevice_TIACC_ts - 1) IACC_out = 1'b1;
    end
    always @(negedge IACC_in)
    begin
        disable AccessTime;
        IACC_out = 1'b0;
    end

    ////////////////////////////////////////////////////////////////////////////
    ////     obtain 'LAST_EVENT information
    ////////////////////////////////////////////////////////////////////////////
    always @(negedge OENeg)
    begin
        OENeg_event = $time;
    end
    always @(negedge CENeg)
    begin
        CENeg_event = $time;
    end

    ////////////////////////////////////////////////////////////////////////////
    // Process that determines clock frequency
    ////////////////////////////////////////////////////////////////////////////

always @(posedge CLK)
begin
    if (LAST_CLK > 0)
    begin
        if( ($time -LAST_CLK) > boundary66MHz_ts)
        begin
            HI_FREQ = 1'b0;
        end
        else
        begin
            HI_FREQ = 1'b1;
        end
        if( ($time - LAST_CLK) < boundary68MHz_ts)
        begin
            WS_FREQ = 6;
        end
        else if( ($time - LAST_CLK) < boundary54MHz_ts)
        begin
            WS_FREQ = 5;
        end
        else if( ($time - LAST_CLK) < boundary40MHz_ts)
        begin
            WS_FREQ = 4;
        end
        else
        begin
            WS_FREQ = 3;
        end
    end
    LAST_CLK = $time;
end

    ////////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ////////////////////////////////////////////////////////////////////////////

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

always @(next_state, RESETNeg, RST, PoweredUp)
begin
    if (PoweredUp)
    begin
        if ( RESETNeg === 1'b1 )
        begin
            current_state = next_state;
            reseted = 1'b1;
        end
        if ( RESETNeg === 1'b0 && RST === 1'b0)
        begin
            current_state = RESET; //reset
            reseted       = 1'b0;
            CONF_REG      = 16'b1010111111001000;
            SYN           = 1'b0;
            if( LOCK_REG[2] === 1'b0 )
                PPB_LOCK= 1'b0;
            else
                PPB_LOCK= 1'b1;
            if( LOCK_REG[4] === 1'b1 )
                DYB = ~(0);
            else
                DYB = 0;
        end
    end
    else
    begin
        current_state = RESET;
        reseted = 1'b0;
    end
end

//    //////////////////////////////////////////////////////////////////////////
//    //Glitch Protection: Inertial Delay does not propagate pulses <5ns
//    //////////////////////////////////////////////////////////////////////////
    assign #wepulseT_ts gWE_n = WENeg_ipd;
    assign #wepulseT_ts gCE_n = CENeg_ipd;
    assign #wepulseT_ts gOE_n = OENeg_ipd;


//    //////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    //////////////////////////////////////////////////////////////////////////

//    //////////////////////////////////////////////////////
//    //Process for generating the write and read signals
//    /////////////////////////////////////////////////////
    always @(gWE_n, gCE_n, gOE_n, RESETNeg, reseted)
    begin
        if (RESETNeg !== 1'b0 && reseted === 1'b1)
            if (~gWE_n  && ~gCE_n && gOE_n )
                write = 1'b1;
            else if (gWE_n  && ~gCE_n && gOE_n)
                write = 1'b0;
        if (gWE_n  && ~gCE_n  && ~gOE_n )
            read = 1'b1;
        else
            read = 1'b0;
    end

    always @(negedge AVDNeg)
    begin
        if ( reseted === 1'b1 && ~CENeg)
        begin
            A_tmp = A[HiAddrBit:0];
            AddrTime = $time;
            if (SYN)
            begin
                burst_rd =1'b0;
                IACC_in  =1'b0;
                LATCHED  =1'b0;
                RD       =1'b0;
            end
        end
    end

    always @(posedge AVDNeg)
    begin
        if (reseted === 1'b1 && ~CENeg && OENeg)
            LatchedWrAddr = A_tmp;
        if (reseted === 1'b1 && ~SYN && ~CENeg && WENeg)
              ADDRESS_GENERATE(A_tmp,Address,AddrCom,SecAddr,
                                                BankAddr,BuffPageAddr,AddrPass);
    end

    always @(A)
    begin
        if ( reseted === 1'b1 && ~AVDNeg && ~CENeg)
        begin
            A_tmp = A[HiAddrBit:0];
            AddrTime = $time;
        end
    end

    always @(posedge CLK)
    begin
        if( reseted===1'b1 && SYN && WENeg && OENeg && ~CENeg && ~AVDNeg
                                                             && ~LATCHED)
        begin
            RD      = 1'b1;
            LATCHED = 1'b1;
            ADDRESS_GENERATE(A_tmp,Address,AddrCom,SecAddr,
                                                BankAddr,BuffPageAddr,AddrPass);
            IACC_in = 1'b1;
            burst_rd= 1'b1;
        end
        if( reseted ===1'b1 && SYN && WENeg && RD )
            burst_rd= 1'b1;
    end

    always @(negedge gWE_n)
    begin
        if( reseted ===1'b1 && ~gCE_n && gOE_n )
        begin
            ADDRESS_GENERATE(LatchedWrAddr,Address,AddrCom,SecAddr,
                                                BankAddr,BuffPageAddr,AddrPass);
            RD = 1'b0;
        end
    end

    always @(posedge WENeg)
    begin
        if(reseted === 1'b1 && write)
        begin
            Data = DIn[15:0];
            if (DIn[7] !== 1'bx)
                DataLo = DIn[7:0];
        end
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program / Write Buffer Operation
//    // start/ suspend/ resume
//    //////////////////////////////////////////////////////////////////////////

 event pdone_event;
 time elapsed_p;
 time duration_p;
 time start_p;
 time pow;
 time wrbo;

    always @(posedge reseted)
    begin
        disable pdone_process;
        PDONE = 1'b1;
    end

    always @( posedge PSTART)
    begin: program
    integer i;
        if (reseted && PDONE)
        begin
            start_p   = $time;
            elapsed_p = 0;
            i       = WrBuffSec;
            if ((((~PPB[i] || ~DYB[i] || (~WP_l && Boot_Sec[i])
                  || ~ACC) || (ESP_ACT && ERS_QUEUE[i]))
                  && ~PASS_ACT && ~LOCK_ACT) ||
               (SecSi && ((WrBuffAddr[0] < 16'h80) || ~(LOCK_REG[0]))) ||
               ( PASS_ACT && ~(LOCK_REG[2])))
            begin
                PERR = 1'b1;
                PERR <= #perrpulseT_ts 1'b0;
            end
            else
            begin
                if ( WRBUFF_ACT )
                duration_p = (WrBuffCnt+1) * tdevice_WRBO_ts;
            else
                duration_p = tdevice_PWO_ts;
                PDONE = 1'b0;
                ->pdone_event;
            end
        end
    end

    always @(pdone_event)
    begin:pdone_process
        #duration_p PDONE = 1'b1;
    end

    always @(posedge PSUSP)
    begin
        if (reseted && ~PDONE)
        begin
            disable pdone_process;
            elapsed_p  = $time - start_p;
            duration_p = duration_p - elapsed_p;
            PDONE = 1'b0;
        end
    end

    always @(posedge PRES)
    begin
        if (reseted && ~PDONE)
        begin
            start_p = $time;
            ->pdone_event;
        end
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    //////////////////////////////////////////////////////////////////////////
 event edone_event;
 integer cnt_erase = 0;
 time elapsed_e;
 time duration_e;
 time start_e;
 time seo16;
 time seo64;

    always @(posedge reseted)
    begin
        disable edone_process;
        EDONE = 1'b1;
    end

    always @(posedge ESTART)
    begin: erase
    integer i;
        if (reseted && EDONE)
        begin
            seo16  = tdevice_SEO16_ts;
            seo64  = tdevice_SEO64_ts;
            cnt_erase  = 0;
            duration_e = 0;
            start_e    = $time;
            for (i=0;i<=SecNum;i=i+1)
                if ( ERS_QUEUE[i] && DYB[i] && PPB[i] &&
                   ( WP_l || (~Boot_Sec[i])) && ACC)
                begin
                    cnt_erase = cnt_erase +1;
                    if ( i >= SecNum-Sec16Num )
                        duration_e = duration_e + seo16;
                    else
                        duration_e = duration_e + seo64;
                end

            if (cnt_erase>0)
            begin
                elapsed_e = 0;
                EDONE = 1'b0;
                ->edone_event;
            end
            else
            begin
                EERR = 1'b1;
                EERR <= #eerrpulseT_ts 1'b0;
            end
        end
    end

    always @(edone_event)
    begin : edone_process
        #(duration_e-2) EDONE = 1'b1;
    end

    always @(posedge ESUSP)
    begin
        if (reseted && ~EDONE)
        begin
            disable edone_process;
            elapsed_e  = $time - start_e;
            duration_e = duration_e - elapsed_e;
            EDONE = 1'b0;
        end
    end
    always @(posedge ERES)
    begin
        if (reseted && ~EDONE)
        begin
            start_e = $time;
            EDONE = 1'b0;
            ->edone_event;
        end
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    //////////////////////////////////////////////////////////////////////////

    //WRITE CYCLE TRANSITIONS
    always @(negedge write or negedge reseted)
    begin: StateGen0
        if (~write)
        begin
            PATTERN_1 = (AddrCom == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (AddrCom == 12'h2AA && DataLo == 8'h55);
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
                    begin
                        next_state = Z001;
                    end
                    else if ((DataLo==16'hA0) && SecSi)
                        next_state = SECSI_A0SEEN;
                    else if((AddrCom == 12'h55 && (DataLo==16'h98)) && ~SecSi)
                        next_state = CFI;
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

            CFI :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hF0)
                    begin
                        if (PSP_ACT)
                            next_state = PGS;
                        else if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                end
            end

            PREL_SETBWB:
            begin
                if (~write)
                begin
                    if ((AddrCom == 12'h555) && (DataLo == 8'hE0) && ~SecSi)
                        next_state = PREL_DYB;
                    else if ((AddrCom==12'h555) && (DataLo==8'h50) && ~SecSi)
                        next_state = PREL_PPBLCK;
                    else if ((AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                        next_state = PREL_PPB;
                    else if ((AddrCom==12'h555) && (DataLo==8'h40) && ~SecSi)
                        next_state = PREL_LR;
                    else if ((AddrCom==12'h555) && (DataLo==8'h20) && ~SecSi)
                        next_state = PREL_ULBYPASS;
                    else if ((AddrCom==12'h555) && (DataLo==8'h90) && ~SecSi)
                        next_state = AS;
                    else if ((AddrCom==12'h555) && (DataLo==8'h90) && SecSi)
                        next_state = SECSI_EX;
                    else if ((AddrCom==12'h555) && (DataLo==8'h60) && ~SecSi)
                        next_state = PREL_PASS;     // Password entry
                    else if (DataLo==8'hA0)
                        next_state = A0SEEN;
                    else if (DataLo==8'h25)
                        next_state = PREL_WR2BUFF;
                    else if ((AddrCom==12'h555) && (DataLo==8'hD0) && ~SecSi)
                        next_state = SET_CONF;
                    else if ((AddrCom==12'h555) && (DataLo==8'hC6) && ~SecSi)
                        next_state = RD_CONF;
                    else if ((AddrCom==12'h555) && (DataLo==8'h80))
                        next_state = C8;
                    else if ((AddrCom==12'h555) && (DataLo==8'h88))
                        next_state = RESET;     // SecSi Entry
                    else
                        next_state = RESET;
                end
            end

            PREL_ULBYPASS  :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hA0)
                        next_state = A0SEEN;
                    else if ((DataLo == 8'h90) &&
                             (PrgBank>= BankNum || PrgBank==BankAddr))
                        next_state = PREL_ULBYPASS_RESET;
                end
            end

            PREL_ULBYPASS_RESET  :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end
            end

            A0SEEN :
            begin
                if (~write)
                    next_state = PGMS;
            end

            SECSI_A0SEEN :
            begin
                if (~write)
                begin
                    if ( SecAddr == 0)
                        next_state = PGMS;
                    else
                    begin
                        if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                end
            end

            C8     :
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
                    if ((AddrCom==12'h555) && (DataLo==8'h10) && ~SecSi)
                        next_state = ERS;
                    else if  ((DataLo==8'h30) && (SecAddr !==0 || ~SecSi))
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
            end

            SERS   :
            begin
                if (~write)
                begin
                    if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankAddr])
                        next_state = ESP;
                    else if ((DataLo == 8'h30) && (SecAddr !==0 || ~SecSi))
                        next_state = SERS;
                    else
                        next_state = RESET;
                end
            end

            SERS_EXEC:
            begin
                if (~write && ~EERR)
                begin
                    if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankAddr])
                        next_state = ESPS;
                end
            end

            ESP    :
            begin
                if (~write)
                begin
                    if  ((DataLo == 8'h30) && ERS_QUEUE_B[BankAddr])
                        next_state = SERS_EXEC;
                    else if (PATTERN_1)
                        next_state = ESP_Z001;
                    else if ((DataLo==16'hA0) && SecSi)
                        next_state = SECSI_A0SEEN;
                    else if ((AddrCom == 12'h55) && (DataLo== 8'h98) && ~SecSi)
                        next_state = CFI;
                end
            end

            ESP_Z001:
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = ESP_PREL;
                    else
                        next_state = ESP;
                end
            end

            ESP_PREL:
            begin
                if (~write)
                begin
                    if  (DataLo == 8'h25)
                        next_state = PREL_WR2BUFF;
                    else if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi)
                        next_state = PREL_DYB;
                    else if ((AddrCom==12'h555) && (DataLo==8'hC0)  && ~SecSi)
                        next_state = PREL_PPB;
                    else if ((AddrCom==12'h555) && (DataLo==8'h90) && ~SecSi)
                        next_state = AS;
                    else if ((AddrCom==12'h555) && (DataLo==8'h90) && SecSi)
                        next_state = SECSI_EX;
                    else if ((AddrCom==12'h555) && (DataLo == 8'h88)
                                && ~(ERS_QUEUE[0]))
                        next_state = ESP; //SecSi Entry
                    else
                        next_state = ESP;
                end
            end

            PREL_WR2BUFF:
            begin
                if (~write)
                begin
                    if  ((SecAddr == WrBuffSec) && (DataLo < 32))
                        next_state = WR2BUFF_0;
                    else
                        next_state = WR2BUFF_AB;
                end
            end

            WR2BUFF_0 :
            begin
                if (~write)
                begin
                    if ((BuffPageAddr == WrBuffPage) && (WrCnt >0))
                        next_state = WR2BUFF_CNT;
                    else if ((BuffPageAddr == WrBuffPage) && (WrCnt ==0))
                        next_state = PREL_PRFLASH;
                    else
                        next_state = WR2BUFF_AB;
                end
            end

            WR2BUFF_CNT :
            begin
                if (~write)
                begin
                    if  ((BuffPageAddr == WrBuffPage) && (WrCnt >0))
                        next_state = WR2BUFF_CNT;
                    else if ((BuffPageAddr == WrBuffPage) && (WrCnt ==0))
                        next_state = PREL_PRFLASH;
                    else
                        next_state = WR2BUFF_AB;
                end
            end

            PREL_PRFLASH  :
            begin
                if (~write)
                begin
                    if  ((SecAddr==WrBuffSec) && (DataLo==8'h29))
                        next_state = PGMS;
                    else
                        next_state = WR2BUFF_AB;
                end
            end

            PGMS:
            begin
                if (~write && ~PERR)
                begin
                    if ((DataLo == 16'hB0) && (BankAddr==PrgBank))
                        next_state = PGSPS;
                end
            end

            PGS:
            begin
                if (~write)
                begin
                    if  ((DataLo == 16'h30) && (BankAddr == PrgBank))
                        next_state = PGMS;
                    else if (PATTERN_1)
                        next_state = PGS_Z001;
                    else if ((AddrCom == 16'h55) && (DataLo== 16'h98) && ~SecSi)
                        next_state = CFI;
                end
            end

            PGS_Z001:
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = PGS_PREL;
                    else
                        next_state = PGS;
                end
            end

            PGS_PREL:
            begin
                if (~write)
                begin
                    if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi)
                        next_state = PREL_DYB;
                    else if ((AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                        next_state = PREL_PPB;
                    else if ((AddrCom==12'h555) && (DataLo== 8'h90) && ~SecSi)
                        next_state = AS;
                    else if ((AddrCom==12'h555) && (DataLo==8'h90) && SecSi)
                        next_state = SECSI_EX;
                    else if ((AddrCom==12'h555) && (DataLo == 8'h88)
                                       && (WrBuffSec !==0))
                        next_state = PGS; //SecSi Entry
                    else
                        next_state = PGS;
                end
            end

            WR2BUFF_AB:
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = WR2BUFF_AB_Z001;
                end
            end

            WR2BUFF_AB_Z001  :
            begin
                if (~write)
                begin
                    if (PATTERN_2)
                        next_state = WR2BUFF_AB_PREL;
                    else
                        next_state = WR2BUFF_AB;
                end
            end

            WR2BUFF_AB_PREL :
            begin
                if (~write)
                begin
                    if ((AddrCom == 12'h555) && (DataLo == 8'hF0))
                    begin
                        if    (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else
                        next_state = WR2BUFF_AB;
                end
            end

            SET_CONF  :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hF0)
                        next_state = RESET;
                    else if (AddrCom == 12'h000)
                        next_state = SET_CONF; // set conf reg
                    else
                        next_state = SET_CONF;
                end
            end

            RD_CONF  :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hF0)
                        next_state = RESET;
                    else
                        next_state = RD_CONF;
                end
            end

            PREL_PASS :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hA0)
                        next_state = PASS_A0SEEN;
                    else if (DataLo == 8'h90)
                        next_state = PASS_EX;
                    else if ((AddrCom == 12'h000) && (DataLo== 8'h25))
                        next_state = PASS_UN_Z001;
                end
            end

            PASS_A0SEEN  :
            begin
                if (~write)
                    next_state = PGMS;
            end

            PASS_EX      :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h00)
                        next_state = RESET; // exit password
                    else
                        next_state = PREL_PASS;
                end
            end

            PASS_UN_Z001 :
            begin
                if (~write)
                begin
                    if ((DataLo == 8'h03) && (AddrCom == 12'h000))
                        next_state = PASS_UN_PREL;
                    else
                        next_state = PREL_PASS;
                end
            end

            PASS_UN_PREL :
            begin
                if (~write)
                    next_state = PASS_UN1;
            end

            PASS_UN1     :
            begin
                if (~write)
                    next_state = PASS_UN2;
            end

            PASS_UN2     :
            begin
                if (~write)
                    next_state = PASS_UN3;
            end

            PASS_UN3     :
            begin
                if (~write)
                    next_state = PASS_UN4;
            end

            PASS_UN4     :
            begin
                if (~write)
                begin
                    if ((AddrCom == 12'h000) && (DataLo == 8'h29))
                        next_state = PASS_UN_W;
                    else
                        next_state = PREL_PASS;
                end
            end

            PREL_LR      :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'hA0)
                        next_state = LR_A0SEEN;
                    else if (DataLo == 8'h90)
                        next_state = LR_PREL_EX;
                end
            end

            LR_A0SEEN   :
            begin
                if (~write)
                begin
                    if  (AddrCom == 12'h00)
                        next_state = PGMS;   // write to LR
                    else
                        next_state = PREL_LR;
                end
            end

            LR_PREL_EX   :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_LR;
                end
            end

            PREL_PPB     :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'hA0)
                        next_state = PPB_PREL_PR;
                    else if (DataLo == 8'h80)
                        next_state = PPB_PREL_ER;
                    else if (DataLo == 8'h90)
                        next_state = PPB_PREL_EX;
                end
            end

            PPB_PREL_PR  :
            begin
                if (~write)
                begin
                    if  ((DataLo == 8'h00) &&
                        (~ESP_ACT || ~(ERS_QUEUE[SecAddr])) &&
                        (~PSP_ACT || (SecAddr !== WrBuffSec )))
                        next_state = PPB_PGMS;
                    else
                        next_state = PREL_PPB;
                end
            end

            PPB_PREL_ER  :
            begin
                if (~write)
                begin
                    if  ((DataLo == 8'h30) && ~ESP_ACT && ~PSP_ACT )
                        next_state = PPB_ERS;
                    else
                        next_state = PREL_PPB;
                end
            end

            PPB_PREL_EX  :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'h00)
                    begin
                        if (PSP_ACT)
                            next_state = PGS;
                        else if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else
                        next_state = PREL_PPB;
                end
            end

            PREL_PPBLCK  :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'hA0)
                        next_state = PPBLCK_PREL_ST;
                    else if (DataLo == 8'h90)
                        next_state = PPBLCK_PREL_EX;
                end
            end

            PPBLCK_PREL_ST   :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'h00)
                        next_state = PREL_PPBLCK;   // set PPB Lock Bit
                    else
                        next_state = PREL_PPBLCK;
                end
            end

            PPBLCK_PREL_EX   :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_PPBLCK;
                end
            end

            PREL_DYB         :
            begin
                if (~write)
                begin
                    if (DataLo == 8'hA0)
                        next_state = DYB_PREL_ST;
                    else if (DataLo == 8'h90)
                        next_state = DYB_PREL_EX;
                end
            end

            DYB_PREL_ST      :
            begin
                if (~write)
                    next_state = PREL_DYB;   // set/reset DYB
            end

            DYB_PREL_EX      :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h00)
                    begin
                        if (PSP_ACT)
                            next_state = PGS;
                        else if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else
                        next_state = PREL_DYB;
                end
            end

            AS    :
            begin
                if (~write)
                begin
                    if  (DataLo == 8'hF0)
                    begin
                        if (PSP_ACT)
                            next_state = PGS;
                        else if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                end
            end

            SECSI_EX :
            begin
                if (~write)
                begin
                    if (DataLo == 8'h00)
                    begin
                        // SecSi Exit
                        if (PSP_ACT)
                            next_state = PGS;
                        else if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                end
            end

            HW_RESET_UNKNOWN :
            begin
            end

            HW_RESET_INIT :
            begin
            end

            endcase
    end

    //PPB_PGMS state, PPBP_out
    always @(PPBP_out)
    begin: StateGen1
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PPB_PGMS)
                if (PPBP_out === 1'b1)
                    next_state = PREL_PPB;
        end
    end

    //PPB_ERS state, PPBE_out
    always @(PPBE_out)
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PPB_ERS)
                if (PPBE_out === 1'b1)
                    next_state = PREL_PPB;
        end
    end

     // PASS_UN_W state, PUT_out
    always @(posedge PUT_out)
    begin: StateGen3
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PASS_UN_W)
                next_state = PREL_PASS;
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
    always @(SET_out)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS)
                if (SET_out === 1'b1)
                    next_state = SERS_EXEC;
        end
    end

    // ESPS state, START_out
    always @(posedge START_out)
    begin: StateGen6
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==ESPS)
                if (START_out === 1'b1)
                    next_state = ESP;
    end

    // PGMS state, PDONE/PERR
    always @(posedge PDONE or negedge PERR)
    begin: StateGen7
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==PGMS)
            begin
                if ( ESP_ACT )
                    next_state = ESP;
                else if ( ULBYPASS )
                    next_state = PREL_ULBYPASS;
                else if ( LOCK_ACT )
                    next_state = PREL_LR;
                else if ( PASS_ACT )
                    next_state = PREL_PASS;
                else
                    next_state = RESET;
            end
        end
    end

    // PGSPS state, START_out
    always @(posedge START_out)
    begin: StateGen8
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (current_state==PGSPS)
                if (START_out === 1'b1)
                    next_state = PGS;
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

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read)
    begin
          ->oe_event;
    end

    always @(posedge burst_rd)
    begin
          ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    always @( posedge oe)
    begin: Output
    begin
            ONE_READ = 1'b0;
            case (current_state)
            RESET :
            begin
                //reading array data
                READ_ARRAY_DATA(Address,BankAddr,SecAddr,SecSi,ONE_READ);
            end

            CFI :
            begin
                begin
                    if (((Address >= 8'b10) && (Address <= 8'h3C)) ||
                                 ((Address >= 8'h40) && (Address <= 8'h68)))
                         DOut_zd = CFIMem[Address];
                    else
                    begin
                         DOut_zd = 16'bz;
                         // error CFI Address out of range
                         $display("Invalid CFI query address");
                    end
                    ONE_READ   = 1'b1;
                end
            end

            ERS  :
            begin
                // reading status enabled
                //////////////////////////////////////////////////////////-
                // read status / embeded erase algorithm - Chip Erase
                //////////////////////////////////////////////////////////-
                if (read)
                begin
                    status[7] = 1'b0;
                    status[6] = ~ status[6]; //toggle
                    status[5] = 1'b0;
                    status[3] = 1'b1;
                    status[2] = ~ status[2]; //toggle
                end
                DOut_zd[7:0] = status;
                DOut_zd[15:8]=8'bz;
                ONE_READ     =1'b1;
            end

            SERS   :
            begin
                if ( ERS_QUEUE_B[BankAddr] )
                begin
                ////////////////////////////////////////////////////////
                //read status - sector erase timeout
                ////////////////////////////////////////////////////////
                if (read)
                begin
                        status[3] = 1'b0;
                        status[7] = 1'b1;
                end
                DOut_zd[7:0] = status;
                DOut_zd[15:8]= 8'bz;
                ONE_READ     = 1'b1;
                end
                else
                begin
                    READ_ARRAY_DATA(Address,BankAddr,SecAddr
                                                        ,SecSi,ONE_READ);
                end
            end

            ESPS :
            begin
                if ( ERS_QUEUE_B[BankAddr])
                begin
                    ////////////////////////////////////////////////////////
                    //read status / erase suspend timeout - stil erasing
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        if ( ERS_QUEUE[SecAddr])
                        begin
                            status[7] = 1'b0;
                            status[2] = ~ status[2]; //toggle
                        end
                        else
                            status[7] = 1'b1;
                        status[6] = ~ status[6]; //toggle
                        status[5] = 1'b0;
                        status[3] = 1'b1;
                    end
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
                else
                    READ_ARRAY_DATA(Address,BankAddr,SecAddr
                                                        ,SecSi,ONE_READ);
            end

            SERS_EXEC:
            begin
                // reading data && status enabled
                if ( ERS_QUEUE_B[BankAddr])
                begin
                    ////////////////////////////////////////////////////
                    //read status Erase Busy
                    ////////////////////////////////////////////////////
                    if (read)
                    begin
                        if (ERS_QUEUE[SecAddr])
                        begin
                            status[7] = 1'b0;
                            status[2] = ~ status[2]; //toggle
                        end
                        else
                            status[7] = 1'b1;
                        status[6] = ~ status[6]; //toggle
                        status[5] = 1'b0;
                        status[3] = 1'b1;
                    end
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
                else
                    READ_ARRAY_DATA(Address,BankAddr,SecAddr
                                                        ,SecSi,ONE_READ);
            end

            ESP    :
            begin
                ////////////////////////////////////////////////////////////
                //read
                ////////////////////////////////////////////////////////////
                if ( ~(ERS_QUEUE[SecAddr]) )
                begin
                    READ_ARRAY_DATA(Address,BankAddr,SecAddr
                                                        ,SecSi,ONE_READ);
                end
                else
                begin
                    ////////////////////////////////////////////////////////
                    //read status
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[7] = 1'b1;
                        // status[6] No toggle
                        status[5] = 1'b0;
                        status[2] = ~ status[2]; // toggle
                    end
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
            end

            PGSPS :
            begin
                // reading data && status enabled
                if ( BankAddr == PrgBank )
                begin
                    ////////////////////////////////////////////////////////
                    //read status
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[6] = ~ status[6]; //toggle
                        status[5] = 1'b0;
                        //status[2] no toggle
                        status[1] = 1'b0;
                    end
                    DOut_zd[7:0]= status;
                    if ( SecAddr == WrBuffSec || LOCK_ACT || PASS_ACT)
                        DOut_zd[7] = status[7];
                    else
                        DOut_zd[7] = ~ status[7];
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
                else if ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr]) )
                        READ_ARRAY_DATA(Address,BankAddr, SecAddr
                                                        ,SecSi,ONE_READ);
                else
                begin
                    ////////////////////////////////////////////////////////
                    //erase suspend active
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[7] = 1'b1;
                        // status[6] No toggle
                        status[5] = 1'b0;
                        status[2] = ~ status[2]; // toggle
                    end
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ   = 1'b1;
                end
            end

            PGMS:
            begin
                if ( BankAddr == PrgBank )
                begin
                    ////////////////////////////////////////////////////////
                    //read status
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[6] = ~ status[6]; //toggle
                        status[5] = 1'b0;
                        //status[2] no toggle
                        status[1] = 1'b0;
                    end
                    DOut_zd[7:0]= status;
                    if ( SecAddr == WrBuffSec || LOCK_ACT || PASS_ACT )
                        DOut_zd[7] = status[7];
                    else
                        DOut_zd[7] = ~ status[7];
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
                else if ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr]) )
                        READ_ARRAY_DATA(Address,BankAddr, SecAddr
                                                        ,SecSi,ONE_READ);
                else
                begin
                    ////////////////////////////////////////////////////////
                    //erase suspend active
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[7] = 1'b1;
                        // status[6] No toggle
                        status[5] = 1'b0;
                        status[2] = ~ status[2]; // toggle
                    end
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
            end

            PGS:
            begin
                // reading data && status enabled
                if ( SecAddr !== WrBuffSec )
                    if ( ESP_ACT && ERS_QUEUE[SecAddr] )
                    begin
                        ////////////////////////////////////////////////////
                        //read status
                        ////////////////////////////////////////////////////
                        if (read)
                        begin
                            status[7] = 1'b1;
                            // status[6] No toggle
                            status[5] = 1'b0;
                            status[2] = ~ status[2]; // toggle
                        end
                        DOut_zd[7:0]= status;
                        DOut_zd[15:8]=8'bz;
                        ONE_READ   = 1'b1;
                    end
                    else
                        READ_ARRAY_DATA(Address,BankAddr, SecAddr
                                                        ,SecSi,ONE_READ);
                else
                    ONE_READ=1'b1;
            end

            WR2BUFF_AB:
            begin
                if ( BankAddr == PrgBank  )
                begin
                    ////////////////////////////////////////////////////////
                    //read status
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[7] = status[7];
                        status[6] = ~ status[6];
                        status[5] = 1'b0;
                        status[1] = 1'b1;
                    end
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                    ONE_READ     = 1'b1;
                end
                else if ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr]))
                        READ_ARRAY_DATA(Address,BankAddr, SecAddr
                                                        ,SecSi,ONE_READ);
                else
                begin
                    ////////////////////////////////////////////////////////
                    //erase suspend active
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                        status[7] = 1'b1;
                        // status[6] No toggle
                        status[5] = 1'b0;
                        status[2] = ~ status[2]; // toggle
                    end
                    DOut_zd[7:0]= status;
                    DOut_zd[15:8]=8'bz;
                    ONE_READ   = 1'b1;
                end
            end

            RD_CONF  :
            begin
                ONE_READ   = 1'b1;
                if ( Address == 12'h000)
                    DOut_zd = CONF_REG;
            end

            PREL_PASS :
            begin
                if ( BankAddr == 0 )
                begin
                    if ( LOCK_REG[2])
                        DOut_zd = Password[AddrPass];
                    else
                        DOut_zd = MaxData;
                    ONE_READ = 1'b1;
                end
                else
                    READ_ARRAY_DATA(Address,BankAddr,SecAddr
                                                        ,SecSi,ONE_READ);
            end

            PREL_LR      :
            begin
                // reading Lock Register is allowed or Data
                if ( BankAddr == 0 )
                    ONE_READ   = 1'b1;
                    if ( AddrCom == 12'h00 )
                        DOut_zd = LOCK_REG;
                else
                    READ_ARRAY_DATA(Address,BankAddr,
                                    SecAddr,SecSi,ONE_READ);
            end

            PREL_PPB     :
            begin
                // reading PPB && array data allowed
                if ( BankAddr == BankPPBAddr )
                begin
                    ONE_READ   = 1'b1;
                    DOut_zd    = 16'b0;
                    DOut_zd[0] = PPB[SecAddr];
                end
                else
                    if ( ESP_ACT && ERS_QUEUE[SecAddr])
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        if (read)
                        begin
                            status[7] = 1'b1;
                            // status[6] No toggle
                            status[5] = 1'b0;
                            status[2] = ~ status[2]; // toggle
                        end
                        DOut_zd[7:0] = status;
                        DOut_zd[15:8]= 8'bz;
                        ONE_READ     = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                        READ_ARRAY_DATA(Address,BankAddr,
                                                    SecAddr,SecSi,ONE_READ);
                    else
                        ONE_READ = 1'b1;
            end

            PPB_PGMS :
            begin
                if ( BankAddr == 0 )
                begin
                    //////////////////////////////////////////////////////-
                    // reading PPB program status
                    //////////////////////////////////////////////////////-
                    if (read)
                    begin
                        status[6] = ~ status[6]; // toggle
                    end
                    ONE_READ     = 1'b1;
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                end
                else
                    if ( ESP_ACT && ERS_QUEUE[SecAddr])
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        if (read)
                        begin
                            status[7] = 1'b1;
                            // status[6] No toggle
                            status[5] = 1'b0;
                            status[2] = ~ status[2]; // toggle
                        end
                        DOut_zd[7:0] = status;
                        DOut_zd[15:8]= 8'bz;
                        ONE_READ     = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                        READ_ARRAY_DATA(Address,BankAddr,
                                                    SecAddr,SecSi,ONE_READ);
                    else
                        ONE_READ = 1'b1;
            end

            PPB_ERS :
            begin
                if ( BankAddr == 0 )
                begin
                    ////////////////////////////////////////////////////////
                    // reading All PPB erase status
                    ////////////////////////////////////////////////////////
                    if (read)
                    begin
                            status[6] = ~ status[6]; // toggle
                    end
                    ONE_READ     = 1'b1;
                    DOut_zd[7:0] = status;
                    DOut_zd[15:8]= 8'bz;
                end
                else
                    READ_ARRAY_DATA(Address,BankAddr,SecAddr
                                                        ,SecSi,ONE_READ);
            end

            PREL_PPBLCK  :
            begin
            // reading PPB Lock enabled
                if ( BankAddr == BankPPBLAddr )
                begin
                    DOut_zd    = 16'b0;
                    DOut_zd[0] = PPB_LOCK;
                    ONE_READ   = 1'b1;
                end
                else
                    READ_ARRAY_DATA(Address,BankAddr,
                                            SecAddr,SecSi,ONE_READ);
            end

            PREL_DYB         :
            begin
                //reading DYB && array data enabled
                if ( BankAddr == BankDYBAddr )
                begin
                    ONE_READ   = 1'b1;
                    DOut_zd    = 16'b0;
                    DOut_zd[0] = DYB[SecAddr];
                end
                else
                    if ( ESP_ACT && ERS_QUEUE[SecAddr] )
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        if (read)
                        begin
                            status[7] = 1'b1;
                            // status[6] No toggle
                            status[5] = 1'b0;
                            status[2] = ~ status[2]; // toggle
                        end
                        DOut_zd[7:0] = status;
                        DOut_zd[15:8]= 8'bz;
                        ONE_READ    = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                        READ_ARRAY_DATA(Address,BankAddr,
                                                    SecAddr,SecSi,ONE_READ);
                    else
                        ONE_READ = 1'b1;
            end

            AS    :
            begin
                if ( BankAddr == BankASAddr )
                begin
                    case ( Address % (BankSize+1))
                    8'h00   : DOut_zd= 16'h0001;
                    8'h01   : DOut_zd= 16'h2C7E;
                    8'h03   : DOut_zd= 16'h0000; //TBD
                    8'h07   : DOut_zd= 16'h0089;
                    8'h0E   : DOut_zd= 16'h2C35;
                    8'h0F   : DOut_zd= 16'h2C00;
                    default :
                        if ((Address % 12'h100) == 8'h02)
                        begin
                            DOut_zd[15:1] = 15'b0;
                            DOut_zd[0]    = ~ PPB[SecAddr];
                        end
                        else
                            DOut_zd = 16'bz;
                    endcase
                    ONE_READ   = 1'b1;
                end
                else
                begin
                    if ( ESP_ACT && ERS_QUEUE[SecAddr])
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        if (read)
                        begin
                            status[7] = 1'b1;
                            // status[6] No toggle
                            status[5] = 1'b0;
                            status[2] = ~ status[2]; // toggle
                        end
                        DOut_zd[7:0]  = status;
                        DOut_zd[15:8] = 8'bz;
                        ONE_READ      = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                        READ_ARRAY_DATA(Address,BankAddr,
                                                    SecAddr,SecSi,ONE_READ);
                    else
                        ONE_READ = 1'b1;
                end
            end
            endcase
            if (burst_rd && SYN)
            begin
                if (ONE_READ)
                    RD_MODE = SINGLE_RD;
                else
                begin
                    if ((CONF_REG[2:0] >= 2) && (CONF_REG[2:0] <=4)
                                                            && CONF_REG[3])
                        RD_MODE = LINEAR;
                    else if((CONF_REG[2:0]>=2)&&(CONF_REG[2:0]<=4)
                                                            && ~(CONF_REG[3]))
                        RD_MODE = LINEAR_NO_WRAP;
                    else if( CONF_REG[2:0] == 0)
                        RD_MODE = CONTINUOUS;
                end
                if(Address <= -1)
                    RD_MODE = NONE;
            end
            if( oe && SYN && (RD_MODE !== NONE))
                DOut_zd = DOut_burst;
            if( OENeg || CENeg || ~RESETNeg)
                DOut_zd = 16'bz;
        end
    end

    always @(negedge write)
    begin: Func0
        PATTERN_1 = (AddrCom == 12'h555 && DataLo == 8'hAA);
        PATTERN_2 = (AddrCom == 12'h2AA && DataLo == 8'h55);
        if (reseted === 1'b1)
        begin
            case (current_state)
            RESET :
            begin
                ESP_ACT   = 1'b0;
                ULBYPASS  = 1'b0;
                SET_in    = 1'b0;
                PPBP_in   = 1'b0;
                PPBE_in   = 1'b0;
                PUT_in    = 1'b0;
                START_in  = 1'b0;
            end

            PREL_SETBWB:
            begin
                if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi )
                begin
                    BankDYBAddr = BankAddr;
                    SecDYBAddr  = SecAddr;
                end
                else if (( AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                begin
                    BankPPBAddr = BankAddr;
                    SecPPBAddr  = SecAddr;
                end
                else if (( AddrCom==12'h555) && (DataLo==8'h50) && ~SecSi)
                    BankPPBLAddr = BankAddr;
                else if (( AddrCom==12'h555) &&  (DataLo==8'h40) && ~SecSi)
                    LOCK_ACT    = 1'b1;
                else if (( AddrCom==12'h555) && (DataLo==8'h20) && ~SecSi)
                begin
                    PrgBank     = -1;
                    ULBYPASS    = 1'b1;
                end
                else if (( AddrCom==12'h555) && (DataLo==8'h90) && ~SecSi)
                    BankASAddr  = BankAddr;
                else if ((AddrCom==12'h555) && (DataLo==8'h60) && ~SecSi)
                    PASS_ACT    = 1'b1;
                else if (DataLo==8'h25)
                begin
                    PrgBank    = BankAddr;
                    WrBuffSec  = SecAddr;
                    WrBuffPage = BuffPageAddr;
                end
                else if (( AddrCom==12'h555) && (DataLo==8'h88))
                    SecSi       = 1'b1;    // SecSi Entry
            end

            A0SEEN:
            begin
                PSTART = 1'b1;
                PSTART <= #1 1'b0;
                WRBUFF_ACT    = 1'b0;
                WrBuffData[0] = Data;
                WrBuffAddr[0] = Address;
                WrBuffSec     = SecAddr;
                WrBuffCnt     = 0;
                PrgBank       = BankAddr;
                WP_l          = WPNeg;
                temp          = DataLo;
                status[7]     = ~ temp[7];
            end

            SECSI_A0SEEN:
            begin
                if ( SecAddr == 0 )
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WRBUFF_ACT    = 1'b0;
                    WrBuffData[0] = Data;
                    WrBuffAddr[0] = Address;
                    WrBuffSec     = SecAddr;
                    WrBuffCnt     = 0;
                    PrgBank       = BankAddr;
                    WP_l          = WPNeg;
                    temp          = DataLo;
                    status[7]     = ~ temp[7];
                end
            end

            C8_PREL:
            begin
                if ((AddrCom==12'h555) && (DataLo==8'h10) && ~SecSi)
                begin
                    ESTART = 1'b1;
                    ESTART <= #1 1'b0;
                    ESUSP  = 1'b0;
                    ERES   = 1'b0;
                    ERS_QUEUE     = ~(0);
                    ERS_QUEUE_B   = ~(0);
                    status        = 8'b0;
                    WP_l          = WPNeg;
                end
                else if ((DataLo==8'h30) && ((SecAddr!==0) || ~SecSi))
                begin
                    ERS_QUEUE     = 0;
                    ERS_QUEUE_B   = 0;
                    ERS_QUEUE[SecAddr]   =1'b1;
                    ERS_QUEUE_B[BankAddr]=1'b1;
                    SET_in               =1'b1;
                    WP_l           = WPNeg;
                end
            end

            SERS   :
            begin
                if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankAddr])
                begin
                    BankErSuspAddr=BankAddr;                //erasure must
                    ERES          = 1'b0;                   //begin before
                    SET_in        = 1'b0;                   //suspending
                    ESTART        = 1'b1;
                    ESTART       <= #1 1'b0;
                    ESUSP         = #1 1'b1;
                    ESUSP        <= #2 1'b0;
                end
                else if ((DataLo == 8'h30) && (SecAddr!==0 || ~SecSi))
                begin
                    ESUSP         = #1 1'b1;
                    ESUSP        <= #2 1'b0;  //one more timeout
                    ERS_QUEUE[SecAddr]    =1'b1;
                    ERS_QUEUE_B[BankAddr] =1'b1;
                end
                else
                begin
                SET_in         =1'b0;
                end
            end

            SERS_EXEC:
            begin
                if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankAddr])
                begin
                    ERES          = 1'b0;
                    ESUSP         = 1'b1;
                    ESUSP        <= #1 1'b0;
                    START_in      = 1'b1;
                end
            end

            ESP    :
            begin
                if ((DataLo == 8'h30) && ERS_QUEUE_B[BankAddr])
                begin
                    ERES         = 1'b1;
                    ERES        <= #1 1'b0;
                    ESP_ACT      = 1'b0;
                end
            end

            ESP_PREL:
            begin
                if (DataLo == 8'h25)
                begin
                    PrgBank    = BankAddr;
                    WrBuffSec  = SecAddr;
                    WrBuffPage = BuffPageAddr;
                end
                else if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi)
                begin
                    BankDYBAddr = BankAddr;
                    SecDYBAddr  = SecAddr;
                end
                else if ((AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                begin
                    BankPPBAddr = BankAddr;
                    SecPPBAddr  = SecAddr;
                end
                else if ((AddrCom==12'h555) && (DataLo==8'h90) && ~SecSi)
                    BankASAddr  = BankAddr;
                else if ((AddrCom==12'h555) && (DataLo ==8'h88)
                                && ~(ERS_QUEUE[0]))
                    SecSi = 1'b1;    //SecSi Entry
            end

            PREL_WR2BUFF:
            begin
                if ( SecAddr == WrBuffSec && DataLo < 32 )
                begin
                    WrCnt     = DataLo;
                    WrBuffCnt = DataLo;
                end
                else
                begin
                    temp          = DataLo;
                    status[7]     = ~ temp[7];
                end
            end

            WR2BUFF_0 :
            begin
                if (BuffPageAddr == WrBuffPage && WrCnt > 0 )
                begin
                    WrBuffAddr[WrCnt] = Address;
                    WrBuffData[WrCnt] = Data;
                    WrCnt             = WrCnt-1;
                end
                else if ( BuffPageAddr == WrBuffPage && WrCnt == 0 )
                begin
                    WrBuffAddr[WrCnt] = Address;
                    WrBuffData[WrCnt] = Data;
                end
                else
                begin
                    temp          = DataLo;
                    status[7]     = ~ temp[7];
                end
            end

            WR2BUFF_CNT :
            begin
                if ( BuffPageAddr == WrBuffPage && WrCnt > 0 )
                begin
                    WrBuffAddr[WrCnt] = Address;
                    WrBuffData[WrCnt] = Data;
                    WrCnt             = WrCnt-1;
                end
                else if ( BuffPageAddr == WrBuffPage && WrCnt == 0 )
                begin
                    WrBuffAddr[WrCnt] = Address;
                    WrBuffData[WrCnt] = Data;
                end
                else
                begin
                    temp          = DataLo;
                    status[7]     = ~ temp[7];
                end
            end

            PREL_PRFLASH  :
            begin
                if (SecAddr == WrBuffSec && DataLo==8'h29)
                begin
                    WRBUFF_ACT = 1'b1;
                    WP_l       = WPNeg;
                    PSTART     = 1'b1;
                    PSTART    <= #1 1'b0;
                end
                temp          = DataLo;
                status[7]     = ~ temp[7];
            end

            PGS:
            begin
                if ((DataLo == 16'h30) && (BankAddr == PrgBank))
                begin
                    PRES         = 1'b1;
                    PRES        <= #1 1'b0;
                    PSP_ACT = 1'b0;
                end
            end

            PGMS:
            begin
                if ((DataLo == 8'hB0) && (BankAddr==PrgBank))
                begin
                    PRES          = 1'b0;
                    PSUSP         = 1'b1;
                    PSUSP        <= #1 1'b0;
                    START_in      = 1'b1;
                end
            end

            PGS_PREL:
            begin
                if (( AddrCom == 12'h555) && (DataLo==8'hE0) && ~SecSi)
                begin
                    BankDYBAddr = BankAddr;
                    SecDYBAddr  = SecAddr;
                end
                else if (( AddrCom==12'h555) && (DataLo==12'hC0) && ~SecSi)
                begin
                    BankPPBAddr = BankAddr;
                    SecPPBAddr  = SecAddr;
                end
                else if (( AddrCom==12'h555) && (DataLo==12'h90) && ~SecSi)
                    BankASAddr  = BankAddr;
                else if (( AddrCom==12'h555) && (DataLo == 12'h88)
                            && (WrBuffSec !==0))
                    SecSi  = 1'b1; //SecSi Entry
            end

            SET_CONF  :
            begin
                if (( DataLo !== 8'hF0) && (AddrCom == 12'h000))
                begin
                    CONF_REG = Data;
                    SYN      = ~ (CONF_REG[15]);
                    if (CONF_REG[15])
                        RD_MODE = NONE;
                end
            end

            PASS_A0SEEN  :
            begin
                PSTART        = 1'b1;
                PSTART       <= #1 1'b0;
                WRBUFF_ACT    = 1'b0;
                WrBuffData[0] = Data;
                WrBuffAddr[0] = AddrPass;
                WrBuffSec     = 0;
                WrBuffCnt     = 0;
                PrgBank       = 0;
                temp          = DataLo;
                status[7]     = ~ temp[7];
            end

            PASS_EX      :
            begin
                if (DataLo == 8'h00)
                    PASS_ACT = 1'b0;
            end

            PASS_UN_Z001 :
            begin
                if ((DataLo == 8'h03) && (AddrCom == 12'h000))
                    for (i=0;i<=PWLength;i=i+1)
                        PASS_TEMP[i] = MaxData;
            end

            PASS_UN_PREL :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN1     :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN2     :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN3     :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN4     :
            begin
                if (( AddrCom == 12'h000) && (DataLo == 8'h29))
                    PASS_UNLCK = 1'b1;
                    for (i=0;i<=PWLength;i=i+1)
                        if ( PASS_TEMP[i] !== Password[i] )
                            PASS_UNLCK = 1'b0;
                    PUT_in = 1'b1;
            end

            LR_A0SEEN   :
            begin
                if (AddrCom == 12'h00)
                begin
                    PSTART        = 1'b1;
                    PSTART       <= #1 1'b0;
                    WRBUFF_ACT    = 1'b0;
                    WrBuffData[0] = Data;
                    WrBuffAddr[0] = 0;
                    WrBuffSec     = 0;
                    WrBuffCnt     = 0;
                    PrgBank       = 0;
                    temp          = DataLo;
                    status[7]     = ~ temp[7];
                end
            end

            LR_PREL_EX   :
            begin
                if ( DataLo == 8'h00 )
                    LOCK_ACT = 1'b0;
            end

            PREL_PPB     :
            begin
                PPBP_in = 1'b0;
                PPBE_in = 1'b0;
            end

            PPB_PREL_PR  :
            begin
                if ((DataLo == 8'h00) &&
                    (~ESP_ACT || ~(ERS_QUEUE[SecAddr])) &&
                    (~PSP_ACT || (SecAddr !== WrBuffSec )))
                begin
                    SecPPBAddr  = SecAddr;
                    BankPPBAddr = BankAddr;
                    PPBP_in = 1'b1;
                end
            end

            PPB_PREL_ER  :
            begin
                if ((DataLo == 8'h30) && ~ESP_ACT && ~PSP_ACT )
                    PPBE_in = 1'b1;
            end

            PPBLCK_PREL_ST   :
            begin
                if (DataLo == 8'h00)
                    PPB_LOCK = 1'b0;   // set PPB Lock Bit
            end

            DYB_PREL_ST      :
            begin
                if ((DataLo == 8'h00) &&
                ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr])) &&
                ( ~PSP_ACT || SecAddr!== WrBuffSec))
                begin
                    DYB[SecAddr] = 1'b0;
                    BankDYBAddr  = BankAddr;
                end
                else if ((DataLo == 8'h01) &&
                ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr])) &&
                ( ~PSP_ACT || SecAddr!==WrBuffSec))
                begin
                    DYB[SecAddr] = 1'b1;
                    BankDYBAddr  = BankAddr;
                end
            end

            SECSI_EX :
            begin
                if (DataLo == 8'h00)
                    SecSi = #5000 1'b0;
            end
            endcase
        end
    end

    //PPB_PGMS state, PPBP_out
    always @(posedge PPBP_out)
    begin : Func1
        if (current_state == PPB_PGMS)
            PPBP_in = 1'b0;
            if ( PPB_LOCK == 1'b1)
                PPB[SecPPBAddr] = 1'b0;
    end

    //PPB_ERS state, PPBE_out
    always @(posedge PPBE_out)
    begin : Func2
        if (current_state == PPB_ERS)
            PPBE_in = 1'b0;
            if ( PPB_LOCK == 1'b1 && LOCK_REG[3])
                PPB = ~(0);
    end

    //PASS_UN_W state, PUT_out
    always @(posedge PUT_out)
    begin : Func3
        if ( current_state == PASS_UN_W )
            PUT_in = 1'b0;
            if ( PASS_UNLCK && ~(LOCK_REG[2]))
                PPB_LOCK = 1'b1;
    end

    //ERS state, EDONE falling edge, EDONE rising edge
    always @(EERR or EDONE)
    begin : Func4
    integer i;
    integer j;
        if (current_state == ERS)
        begin
        if (EERR!=1'b1)
            if (~EDONE)//falling edge
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if (PPB[i] && DYB[i] &&
                       (WP_l || ~( Boot_Sec[i])) && ACC)
                        if (i >= SecNum-Sec16Num)
                            for (j =(i-SecNum+Sec16Num)*(SecSize16+1)+sgsa(1);
                                 j<=(i-SecNum+Sec16Num)*(SecSize16+1)+
                                                            sgsa(1)+SecSize16;
                                 j=j+1)
                                Mem[j] = -1;
                        else
                            for (j =i*(SecSize64+1) + sgsa(0);
                                 j<=i*(SecSize64+1) + sgsa(0) + SecSize64;
                                 j=j+1)
                                Mem[j] = -1;
                end
            end
            if (EDONE)//rising edge
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if (PPB[i] && DYB[i] &&
                       (WP_l || ~( Boot_Sec[i])) && ACC)
                        if (i >= SecNum-Sec16Num)
                            for (j =(i-SecNum+Sec16Num)*(SecSize16+1)+sgsa(1);
                                 j<=(i-SecNum+Sec16Num)*(SecSize16+1)+
                                                            sgsa(1)+SecSize16;
                                 j=j+1)
                                Mem[j] = MaxData;
                        else
                            for (j =i*(SecSize64+1) + sgsa(0);
                                 j<=i*(SecSize64+1) + sgsa(0) + SecSize64;
                                 j=j+1)
                                Mem[j] = MaxData;
                end
            end
        end
    end

    //SERS state, SET_out
    always @(SET_out)
    begin : Func5
        if (current_state==SERS)
        begin
            if (SET_out)
            begin
                SET_in   = 1'b0;
                START_in = 1'b0;
                ESUSP    = 1'b0;
                ERES     = 1'b0;
                ESTART   = 1'b1;
                ESTART  <= #1 1'b0;
            end
        end
    end

    //ESPS state, START_out
    always @(START_out)
    begin : Func6
        if (current_state==ESPS)
        begin
            if (START_out)
            begin
                ESP_ACT  = 1'b1;
                START_in = 1'b0;
                SET_in   = 1'b0;
            end
        end
    end

    //SERS_EXEC state, EDONE falling edge, EDONE rising edge
    always @(EERR or EDONE)
    begin: Func7
    integer i,j;
        if (current_state==SERS_EXEC)
        begin
            if (EERR!=1'b1)
            begin
                if (~EDONE)
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                    if (ERS_QUEUE[i] && PPB[i] && DYB[i] &&
                       (WP_l || ~( Boot_Sec[i])) && ACC)
                        if (i >= SecNum-Sec16Num)
                            for (j =(i-SecNum+Sec16Num)*(SecSize16+1)+sgsa(1);
                                 j<=(i-SecNum+Sec16Num)*(SecSize16+1)+
                                                            sgsa(1)+SecSize16;
                                 j=j+1)
                                Mem[j] = -1;
                        else
                            for (j =i*(SecSize64+1) + sgsa(0);
                                 j<=i*(SecSize64+1) + sgsa(0) + SecSize64;
                                 j=j+1)
                                Mem[j] = -1;
                    end
                end
                if (EDONE)
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                    if (ERS_QUEUE[i] && PPB[i] && DYB[i] &&
                       (WP_l || ~( Boot_Sec[i])) && ACC)
                        if (i >= SecNum-Sec16Num)
                            for (j =(i-SecNum+Sec16Num)*(SecSize16+1)+sgsa(1);
                                 j<=(i-SecNum+Sec16Num)*(SecSize16+1)+
                                                            sgsa(1)+SecSize16;
                                 j=j+1)
                                Mem[j] = MaxData;
                        else
                            for (j =i*(SecSize64+1) + sgsa(0);
                                 j<=i*(SecSize64+1) + sgsa(0) + SecSize64;
                                 j=j+1)
                                Mem[j] = MaxData;
                    end
                end
            end
        end
    end

    //PGMS state, PDONE rising edge, PDONE falling edge
    always @(PDONE) // or PERR or PDONE)
    begin: Func9
    integer i,j;
        if (current_state==PGMS)
        begin
            if (PERR != 1'b1)
            begin
                if (~PDONE)//falling
                begin
                    x          = WrBuffSec;
                    for(i=WrBuffCnt;i>=0;i=i-1)
                    begin
                        new_int = WrBuffData[i];
                        old_int = -1;
                        if (PASS_ACT )
                            old_int = Password[WrBuffAddr[i]];
                        else if (LOCK_ACT)
                        begin
                            if (LOCK_REG[0]=== 1'bx)
                                old_int =-1;
                            else
                                old_int =LOCK_REG;
                        end
                        else if( SecSi && (x==0) && (WrBuffAddr[0]<=8'hFF)
                                               && (WrBuffAddr[0]>=8'h80))
                            old_int =SecSiMem[WrBuffAddr[i]];
                        else
                            old_int =Mem[WrBuffAddr[i]];
                        if (new_int>-1)
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
                            WrBuffData[i]= new_int;
                        end
                    end
                    if (PASS_ACT && LOCK_REG[2])
                        Password[WrBuffAddr[0]] = -1;
                    else if (LOCK_ACT)
                    begin
                        if ( new_bit[1] || new_bit[2])
                            LOCK_REG[4:0] = 5'bx;
                    end
                    else if ( SecSi && (x==0) && (WrBuffAddr[0]<=8'hFF)
                             && WrBuffAddr[0]>=8'h80 && LOCK_REG[0])
                        for(i=WrBuffCnt;i>=0;i=i-1)
                            SecSiMem[WrBuffAddr[i]] = -1;
                    else if(( PPB[x] && DYB[x] &&
                           (WP_l || ~(Boot_Sec[x])) && ACC)
                                && ( ~ESP_ACT || ~(ERS_QUEUE[x])))
                        for(i=WrBuffCnt;i>=0;i=i-1)
                            Mem[WrBuffAddr[i]] = -1;
                end
                if (PDONE)//rising
                begin
                    WRBUFF_ACT = 1'b0;
                    x          = WrBuffSec;
                    if (PASS_ACT && LOCK_REG[2])
                    begin
                        Password[WrBuffAddr[0]] = WrBuffData[0];
                        WrBuffData[0]           = -1;
                    end
                    else if (LOCK_ACT)
                    begin
                        if ( new_bit[1] || new_bit[2])
                            LOCK_REG[4:0] = new_bit[4:0];
                    end
                    else if ( SecSi && (x==0) && (WrBuffAddr[0]<=8'hFF)
                             && WrBuffAddr[0]>=8'h80 && LOCK_REG[0])
                    begin
                        for(i=WrBuffCnt;i>=0;i=i-1)
                        begin
                            SecSiMem[WrBuffAddr[i]] = WrBuffData[i];
                            WrBuffData[i]           = -1;
                        end
                    end
                    else if(( PPB[x] && DYB[x] &&
                           (WP_l || ~(Boot_Sec[x])) && ACC)
                                && ( ~ESP_ACT || ~(ERS_QUEUE[x])))
                    begin
                        for(i=WrBuffCnt;i>=0;i=i-1)
                        begin
                            Mem[WrBuffAddr[i]] = WrBuffData[i];
                            WrBuffData[i]      = -1;
                        end
                    end
                end
            end
        end
    end

    //PGSPS state, START_out
    always @(posedge START_out)
    begin : Func10
        if (current_state == PGSPS)
        begin
            START_in = 1'b0;
            PSP_ACT  = 1'b1;
       end
    end

    //Burst data setup
    always @( OENeg or DOut_burst)
    begin
        if (~OENeg && SYN )
            DOut_zd = DOut_burst;
    end

    //Output Disable Control
    always @(posedge OENeg)
    begin
        if (OENeg)
            DOut_zd = 16'bz;
    end

    //Output Disable Control
    always @(posedge CENeg )
    begin
        if (CENeg)
        begin
            DOut_zd    = 16'bZ;
            DOut_burst = 16'bZ;
        end
    end

    //Output Disable Control
    always @(negedge RESETNeg)
    begin
        if(~RESETNeg)
        begin
            DOut_zd = 16'bZ;
            DOut_burst = 16'bZ;
        end
    end

    //unknown data on outputs
    always @(DOut_zd)
    begin
        if( ~OENeg && ~ AVDNeg)
            DOut_zd = 16'bx;
    end

    // Hardware RESET cycle
    always @(negedge RST)
    begin
        if (~RESETNeg)
        begin
            RD_MODE  = NONE;
            CONF_REG = 16'b1010111111001000;
            SYN      = 1'b0;
            if( ~(LOCK_REG[2]))
                PPB_LOCK = 1'b0;
            else
                PPB_LOCK = 1'b1;
            if (LOCK_REG[4])
                    DYB = ~(0);
            else
                    DYB = 0;
            ESP_ACT  = 1'b0;
            ULBYPASS = 1'b0;
            PSP_ACT  = 1'b0;
            PASS_ACT = 1'b0;
            LOCK_ACT = 1'b0;
            SecSi    = 1'b0;
        end
    end

    //Initializing burst parameters
    always @(posedge burst_rd)
    begin
        BurstAddr      = Address;
        BurstSec       = SecAddr;
        if (CONF_REG[2:0] == 2 )
            BurstLength = 8;
        else if (CONF_REG[2:0] == 3)
            BurstLength = 16;
        else if (CONF_REG[2:0] == 4)
            BurstLength = 32;
        else
            BurstLength = 0;
        RdCnt          = BurstLength;
        WS_CNT         = CONF_REG[13:11] + 2;
        DelayCyc_CNT   = (BurstAddr % 4);
        if ( ((BurstAddr % 8'h80) >= 8'h7C) &&
                        ((BurstAddr % 8'h80) <= 8'h7F ))
            DelayCyc_CNT = DelayCyc_CNT + 1;
        if ( WS_FREQ  == 5 )
            DelayCyc_CNT = DelayCyc_CNT - 1;
        else if ( WS_FREQ  == 4 )
            DelayCyc_CNT = DelayCyc_CNT - 2;
        else if ( WS_FREQ  <= 3 )
            DelayCyc_CNT = DelayCyc_CNT - 3;
        if ( WS_CNT <= 2 )
            CONF_REG_8 = 1'b1;
        else
            CONF_REG_8 = CONF_REG[8];

        if ( DelayCyc_CNT < 0 )
            DelayCyc_CNT = 0;
        DelayCycSwitch = 0;
        CLK_PATH_EN    = 1'b0;
        INITIAL_WAIT   = ( WS_CNT > 2);
        INITIAL_ACCESS = ( WS_CNT <= 2);
        BOUNDARY_CROSS = 1'b0;
        NO_PROGRESS    = 1'b0;
        BURST_END      = 1'b0;
        Prior_IACC     = 1'b1;
        IN_W_ELAPSED   = ( WS_CNT <= 2);
        DOut_burst     = 16'bz;
    end

    //Synchronous READ modes
    always @(posedge CLK or posedge IACC_out)
    begin
        if (CLK|| (IACC_out && IN_W_ELAPSED))
        begin
            if (RD_MODE == LINEAR)
            // linear mode only implemented
            begin
                if (INITIAL_WAIT )
                begin
                    WS_CNT = WS_CNT - 1;
                    RDY_temp = 1'b0;
                    if ( WS_CNT <= 2 )
                    begin
                        INITIAL_WAIT  = 1'b0;
                        INITIAL_ACCESS= 1'b1;
                        CLK_PATH_EN   = 1'b1;
                        if (~CONF_REG_8)
                        begin
                            RDY_temp = 1'b1;
                        end
                    end
                end
                else if ( INITIAL_ACCESS )
                begin
                    if ( IACC_out )
                    begin
                        if (CLK)
                            CLK_PATH_EN= 1'b1;
                        Prior_IACC     = 1'b0;
                        if ( DelayCycSwitch ==0 && (BurstAddr % 4 < 3))
                        begin
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            BurstAddr = BurstAddr + 1;
                            CHECK_END(RdCnt,1'b1,BURST_END);
                            if ( (BurstAddr % 4) == 3 )
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 4;
                                else
                                    DelayCycSwitch = 1;
                        end
                        else if ( DelayCycSwitch==0 && (BurstAddr % 4 == 3))
                        begin
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            if ( DelayCyc_CNT == 0 )
                            begin
                                RDY_temp      = 1'b1;
                                DelayCycSwitch = 4;
                                BurstAddr = BurstAddr + 1;
                                CHECK_END(RdCnt,1'b1,BURST_END);
                            end
                            else
                            begin
                                RDY_temp = CONF_REG_8;
                                DelayCyc_CNT = DelayCyc_CNT -1;
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 3;
                                else
                                    DelayCycSwitch = 2;
                            end
                        end
                        else if ( DelayCycSwitch == 1 )
                        begin
                            RDY_temp = CONF_REG_8;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                            else
                                DelayCycSwitch = 2;
                        end
                        else if ( DelayCycSwitch == 2 )
                        begin
                            RDY_temp = 1'b0;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                        end
                        else if ( DelayCycSwitch == 3 )
                        begin
                            RDY_temp = ~ CONF_REG_8;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            NEXT_ADDR_LIN(BurstAddr,BurstLength);
                            CHECK_END(RdCnt,1'b1,BURST_END);
                            DelayCycSwitch = 4;
                        end
                        else // DelayCycSwitch == 4
                        begin
                            INITIAL_ACCESS = 1'b0;
                            DelayCycSwitch = 0;
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            NEXT_ADDR_LIN(BurstAddr,BurstLength);
                            CHECK_END(RdCnt,1'b1,BURST_END);
                        end
                    end
                    else
                        RDY_temp = ~ CONF_REG_8;
                    IN_W_ELAPSED = 1'b1;
                end
                else if ( BURST_END )
                begin
                    RDY_temp = 1'b0;
                    DOut_burst  = 16'bz;
                end
                else //
                begin
                    READ_BURST_DATA(BurstAddr,BurstSec);
                    NEXT_ADDR_LIN(BurstAddr,BurstLength);
                    CHECK_END(RdCnt,1'b1,BURST_END);
                    if (~ BURST_END )
                        RDY_temp = 1'b1;
                    else
                        RDY_temp = CONF_REG_8;
                end
            end
            else if (RD_MODE ==CONTINUOUS || RD_MODE==LINEAR_NO_WRAP)
            // continuous mode && linear without wrap
            begin
                if ( INITIAL_WAIT )
                begin
                    WS_CNT   = WS_CNT - 1;
                    RDY_temp = 1'b0;
                    if ( WS_CNT <= 2 )
                    begin
                        INITIAL_WAIT  = 1'b0;
                        INITIAL_ACCESS= 1'b1;
                        CLK_PATH_EN   = 1'b1;
                        if ( ~CONF_REG_8)
                        begin
                            RDY_temp = 1'b1;
                        end
                    end
                end
                else if ( INITIAL_ACCESS )
                begin
                    if ( IACC_out )
                    begin
                        if (CLK)
                            CLK_PATH_EN= 1'b1;
                        Prior_IACC     = 1'b0;
                        if ( DelayCycSwitch==0 && (BurstAddr % 4 < 3 ))
                        begin
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            NEXT_ADDR(BurstAddr,BurstSec);
                            CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,BURST_END);
                            if ( BurstAddr % 4 == 3 )
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 4;
                                else
                                    DelayCycSwitch = 1;
                        end
                        else if ( DelayCycSwitch == 0 && (BurstAddr % 4) ==3)
                        begin
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            if ( DelayCyc_CNT == 0 )
                            begin
                                RDY_temp       = 1'b1;
                                DelayCycSwitch = 4;
                                BurstAddr = BurstAddr + 1;
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                            ,BURST_END);
                            end
                            else
                            begin
                                RDY_temp    = CONF_REG_8;
                                DelayCyc_CNT = DelayCyc_CNT -1;
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 3;
                                else
                                    DelayCycSwitch = 2;
                            end
                        end
                        else if ( DelayCycSwitch == 1 )
                        begin
                            RDY_temp = CONF_REG_8;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                            else
                                DelayCycSwitch = 2;
                        end
                        else if ( DelayCycSwitch == 2 )
                        begin
                            RDY_temp = 1'b0;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                        end
                        else if ( DelayCycSwitch == 3 )
                        begin
                            RDY_temp = ~CONF_REG_8;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            NEXT_ADDR(BurstAddr,BurstSec);
                            CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,BURST_END);
                            DelayCycSwitch = 4;
                        end
                        else //DelayCycSwitch == 4
                        begin
                            INITIAL_ACCESS = 1'b0;
                            DelayCycSwitch = 0;
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,BURST_END);
                            if ( (BurstAddr % 8'h80) == 8'h7F )
                            begin
                                if ( HI_FREQ == 1'b1 )
                                    RDY_temp = CONF_REG_8;
                                else
                                    NEXT_ADDR(BurstAddr,BurstSec);
                                INITIAL_ACCESS = 1'b0;
                                BOUNDARY_CROSS = 1'b1;
                                BoundarySwitch = 0;
                            end
                            else
                            begin
                                NEXT_ADDR(BurstAddr,BurstSec);
                            end
                        end
                    end
                    else
                        RDY_temp = ~ CONF_REG_8;
                    IN_W_ELAPSED = 1'b1;
                end
                else if ( BURST_END )
                begin
                    RDY_temp = 1'b0;
                    DOut_burst  = 16'bz;
                end
                else if ( BOUNDARY_CROSS )
                begin
                    if ( BoundarySwitch == 0 )
                    begin
                        if ( HI_FREQ == 1'b1 )
                        begin
                            RDY_temp = ~ CONF_REG_8;
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            NEXT_ADDR(BurstAddr,BurstSec);
                            BoundarySwitch = 1;
                        end
                        else
                        begin
                            RDY_temp = 1'b1;
                            Sector_switch_check(BurstAddr,BurstSec,NO_PROGRESS);
                            if ( NO_PROGRESS )
                                READ_SINGLE_SYNC_DATA(BurstAddr,
                                                       BurstSec);
                            else
                            begin
                                READ_BURST_DATA(BurstAddr,BurstSec);
                                NEXT_ADDR(BurstAddr,BurstSec);
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                                   ,BURST_END);
                            end
                            BOUNDARY_CROSS = 1'b0;
                        end
                    end
                    else  // Boundary switch==1
                    begin
                        RDY_temp = 1'b1;
                        Sector_switch_check(BurstAddr,BurstSec,NO_PROGRESS);
                        if ( NO_PROGRESS )
                            READ_SINGLE_SYNC_DATA(BurstAddr,BurstSec);
                        else
                        begin
                            READ_BURST_DATA(BurstAddr,BurstSec);
                            NEXT_ADDR(BurstAddr,BurstSec);
                            CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,BURST_END);
                        end
                        BOUNDARY_CROSS = 1'b0;
                    end
                    if (BURST_END )
                        RDY_temp = CONF_REG_8;
                end
                else if ( NO_PROGRESS )
                begin
                    RDY_temp = 1'b1;
                    READ_SINGLE_SYNC_DATA(BurstAddr,BurstSec);
                end
                else
                begin
                    READ_BURST_DATA(BurstAddr,BurstSec);
                    // check boundary crossing && sector switch
                    CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,BURST_END);
                    if (~ BURST_END )
                        RDY_temp = 1'b1;
                    else
                        RDY_temp = CONF_REG_8;
                    if ( (BurstAddr % 8'h80) == 8'h7F )
                    begin
                        if ( HI_FREQ == 1'b1 )
                            RDY_temp = CONF_REG_8;
                        else
                            NEXT_ADDR(BurstAddr,BurstSec);
                        BOUNDARY_CROSS = 1'b1;
                        BoundarySwitch = 0;
                    end
                    else
                    begin
                        NEXT_ADDR(BurstAddr,BurstSec);
                    end
                end
            end

            else if (RD_MODE==SINGLE_RD)
            begin
                if ( INITIAL_WAIT )
                begin
                    WS_CNT   = WS_CNT - 1;
                    RDY_temp = 1'b0;
                    if ( WS_CNT <= 2 )
                    begin
                        INITIAL_WAIT  = 1'b0;
                        INITIAL_ACCESS= 1'b1;
                        CLK_PATH_EN   = 1'b1;
                        if ( ~CONF_REG_8 )
                        begin
                            RDY_temp = 1'b1;
                        end
                    end
                end
                else  // INITIAL ACCESS
                begin
                    if ( IACC_out )
                    begin
                        RDY_temp = 1'b1;
                        READ_SINGLE_SYNC_DATA(BurstAddr,BurstSec);
                    end
                    else
                        RDY_temp = ~ CONF_REG_8;
                    IN_W_ELAPSED = 1'b1;
                end
            end
       end
    end

 task ADDRESS_GENERATE;
 input[HiAddrBit:0]      A;
 output integer Addr;
 output integer AddrC;
 output integer SAddr;
 output integer BAddr;
 output integer BPAddr;
 output integer AP;

 reg[HiAddrBit:0] tmp;
 begin
    Addr  = -1;
    AddrC =  0;
    SAddr = -1;
    BAddr = -1;
    BPAddr= -1;
    AP    =  0;
    AP = A[1:0];
    Addr  = A[HiAddrBit:0];
    AddrC = A[11:0];
    if (A[HiAddrBit:0] >= sgsa(0) && A[HiAddrBit:0] <= sgea(0))
    begin
        tmp[SecBit64-1:0]= A[HiAddrBit:(HiAddrBit-SecBit64+1)];
        SAddr            = tmp[(SecBit64-1):0];
    end
    if ( A[HiAddrBit : 0] >= sgsa(1) && A[HiAddrBit:0] <= sgea(1))
    begin
        tmp[(SecBit16 - SecBit64 -1):0]
                  = A[(HiAddrBit-SecBit64):(HiAddrBit-SecBit16+1)];
        SAddr = tmp[(SecBit16-SecBit64-1):0]+SecNum-Sec16Num;
    end
    BAddr = A[HiAddrBit:(HiAddrBit-BankBit+1)];
    BPAddr= A[HiAddrBit:5];
 end
 endtask

 task READ_ARRAY_DATA;
 input integer Addr;
 input integer Bank;
 input integer Sec;
 input SS;
 output mode;
 begin
    if ( (~SS || (Sec!==0)) && (Addr >= 0 ))
    begin
        if ( Mem[Addr]!== -1 )
            DOut_zd = Mem[Addr];
        else
            DOut_zd = 16'bx;
    end
    else if (( Addr>=8'h00) && (Addr < 12'h100))
    begin
        if ( SecSiMem[Addr] !== -1 )
            DOut_zd = SecSiMem[Addr];
        else
            DOut_zd = 16'bx;
    end
    else if (SS && Sec==0 && (( Addr < 0) || (Addr >= 12'h100)))
    begin
        DOut_zd = 16'bz;
        // SecSi Address out of range
        $display("Address out of SecSi range.");
    end
    else
    begin
        DOut_zd = 16'bz;
    end
    if ( SS && (Sec == 0) )
        mode = 1'b1;
    else
        mode = 1'b0;
 end
 endtask

 task Sector_switch_check;
 input integer BAddr;
 input integer BSec;
 output Switch;

 integer  Bank;
 reg  SW;
 reg  Switch_out;
 begin
        SW         = 1'b0;
        Switch_out = 1'b0;
        if ( BAddr <= sgea(0) || BAddr >= sgsa(0) )
            SW = ((BAddr % (SecSize64+1)) === 0);
        else
            SW = ((BAddr % (SecSize16+1)) === 0);
        if ( SW )
        begin
            Bank = (BAddr / (BankSize+1));
            if (current_state==SERS|| current_state==ESPS
                || current_state==SERS_EXEC  )
            begin
                if ( ERS_QUEUE_B[Bank] )
                    Switch_out = 1'b1;
            end
            else if (current_state==ESP)
            begin
                if ( ERS_QUEUE[BSec] )
                    Switch_out = 1'b1;
            end
            else if (current_state==PGMS || current_state==PGSPS ||
                     current_state==WR2BUFF_AB)
            begin
                if ( (Bank == PrgBank) ||
                             (ESP_ACT && ERS_QUEUE[BSec]) )
                    Switch_out = 1'b1;
            end
            else if (current_state==PGS)
            begin
                if ( (BSec == WrBuffSec) ||
                             (ESP_ACT && ERS_QUEUE[BSec]) )
                    Switch_out = 1'b1;
            end
            else if (current_state==PREL_LR)
            begin
                if ( Bank == 0 )
                    Switch_out = 1'b1;
            end
            else if (current_state==PREL_PASS )
            begin
                if ( Bank == 0 )
                    Switch_out = 1'b1;
            end
            else if (current_state==PREL_PPB)
            begin
                if ( (Bank == BankPPBAddr) || (ESP_ACT && ERS_QUEUE[BSec])
                                     || (PSP_ACT && BSec == WrBuffSec))
                    Switch_out = 1'b1;
            end
            else if (current_state==PPB_ERS || current_state==PPB_PGMS )
            begin
                if ( (Bank == 0) || (ESP_ACT && ERS_QUEUE[BSec])
                                     || (PSP_ACT && BSec == WrBuffSec))
                    Switch_out = 1'b1;
            end
            else if (current_state==PREL_DYB)
            begin
                if ( (Bank == BankDYBAddr) || (ESP_ACT && ERS_QUEUE[BSec])
                                     || (PSP_ACT && BSec == WrBuffSec))
                    Switch_out = 1'b1;
            end
            else if (current_state==PREL_PPBLCK)
            begin
                if ( Bank == BankPPBLAddr )
                    Switch_out = 1'b1;
            end
            else if (current_state==AS)
            begin
                if ( (Bank == BankASAddr) || (ESP_ACT && ERS_QUEUE[BSec])
                                     || (PSP_ACT && BSec == WrBuffSec))
                    Switch_out = 1'b1;
            end
            if ( SecSi && (BSec ==0) )
                Switch_out = 1'b1;
            Switch = Switch_out;
        end
 end
 endtask

 task NEXT_ADDR;
 inout integer BAddr;
 inout integer BSec;
 begin
    if ( BAddr == MaxAddr )
    begin
        BAddr = 0;
        BSec  = 0;
    end
    else
    begin
        BAddr = BAddr+1;
        if ( BAddr <= sgea(0) || BAddr >= sgsa(0) )
        begin
            if ((BAddr % (SecSize64+1)) == 0)
                BSec= BSec + 1;
        end
        else
        begin
            if ((BAddr % (SecSize16+1)) == 0)
                BSec = BSec+1;
        end
    end
 end
 endtask

 task NEXT_ADDR_LIN;
 inout integer BAddr;
 input integer Length;
 begin
    BAddr = BAddr + 1;
    if ( (BAddr % Length) == 0 )
        BAddr= BAddr - Length;
 end
 endtask

 task CHECK_END;
 inout integer CNT;
 input Enable;
 output BEnd;
 begin
    if ( Enable )
    begin
        CNT=CNT-1;
        if ( CNT == 0 )
            BEnd = 1'b1;
        else
            BEnd = 1'b0;
    end
    else
        BEnd = 1'b0;
 end
 endtask

 task READ_BURST_DATA;
 input integer BAddr;
 input integer BSec ;
 begin
    if ( Mem[BAddr]!==-1 )
        DOut_burst = Mem[BAddr];
    else
        DOut_burst = 16'bx;
 end
 endtask

 task READ_SINGLE_SYNC_DATA;
 input integer Addr;
 input integer Sec;

 integer Bank;
 begin
    Bank     = (Addr / (BankSize+1));
    DOut_burst  = 16'bz;
    if (current_state == CFI)
    begin
        if (((Address >= 8'h10) && (Address <= 8'h3C)) ||
                    ((Address >= 8'h40) && (Address <= 8'h68)))
            DOut_burst = CFIMem[Addr];
        else
        begin
            DOut_burst = 16'bz;
            $display("Invalid CFI query address");
        end
    end

    else if (current_state==ERS       || current_state==SERS       ||
             current_state==SERS_EXEC || current_state==ESP        ||
             current_state==PGS       || current_state==PPB_PGMS   ||
             current_state==PPB_ERS   || current_state==WR2BUFF_AB ||
             current_state==ESPS)
    begin
        DOut_burst[7:0]  = status;
        DOut_burst[15:8] = 8'bz;
    end

    else if (current_state==PGMS || current_state==PGSPS)
    begin
        DOut_burst[7:0]  = status;
        if ( Sec == WrBuffSec || PASS_ACT || LOCK_ACT )
            DOut_burst[7] = status[7];
        else
            DOut_burst[7] = ~(status[7]);
        DOut_burst[15:8]  = 8'bz;
    end

    else if(current_state==RD_CONF)
    begin
        if ( Addr == 12'h000 )
            DOut_burst    = CONF_REG;
    end

    else if (current_state==PREL_LR)
    begin
        DOut_burst = LOCK_REG;
    end

    else if (current_state==PREL_PASS)
    begin
        if (LOCK_REG[2])
            DOut_burst = Password[Addr % 4];
        else
            DOut_burst = MaxData;
    end

    else if (current_state==PREL_PPB)
    begin
        if ( Bank == BankPPBAddr )
        begin
            DOut_burst    = 16'b0;
            DOut_burst[0] = PPB[Sec];
        end
        else
        begin
            DOut_burst[7:0] = status;
            DOut_burst[15:8]= 8'bz;
        end
    end

    else if (current_state==PREL_PPBLCK)
    begin
        if ( Bank == BankPPBLAddr )
        begin
            DOut_burst    = 16'b0;
            DOut_burst[0] = PPB_LOCK;
        end
    end

    else if (current_state==PREL_DYB)
    begin
        if ( Bank == BankDYBAddr )
        begin
            DOut_burst      = 16'b0;
            DOut_burst[0]   = DYB[Sec];
        end
        else
        begin
            DOut_burst[7:0] = status;
            DOut_burst[15:8]= 8'bz;
        end
    end

    else if (current_state==AS)
    begin
        if ( Bank == BankASAddr )
            case (Addr % (BankSize+1))
            8'h00 : DOut_burst = 16'h0001;
            8'h01 : DOut_burst = 16'h2C7E;
            8'h03 : DOut_burst = 16'h0000;
            8'h07 : DOut_burst = 16'h0089;
            8'h0E : DOut_burst = 16'h2C35;
            8'h0F : DOut_burst = 16'h2C00;
            default :
                if (( Addr % 12'h100) == 12'h02)
                begin
                    DOut_burst[15:1]  = 15'b0;
                    DOut_burst[0]     = ~(PPB[SecAddr]);
                end
                else
                    DOut_burst  = 16'bz;
            endcase
        else
        begin
            DOut_burst[7:0]  = status;
            DOut_burst[15:8] = 8'bz;
        end
    end
    if (SecSi && (Sec == 0) )
    begin
        if (( Addr>=8'h00) && (Addr < 12'h100))
        begin
            if ( SecSiMem[Addr] !== -1 )
                DOut_burst = SecSiMem[Addr];
            else
                DOut_burst = 16'bx;
        end
        else
        begin
            DOut_burst = 16'bz;
            // SecSi Address out of range
            $display("Address out of SecSi range.");
        end
    end
    if ( PSP_ACT && (Sec == WrBuffSec ))
            DOut_burst = 16'bz;
    if ( CENeg || ~RESETNeg)
            DOut_burst = 16'bz;
 end
 endtask

 function integer sgsa;
 input integer i;
 begin
      if (i == 0)
        sgsa=24'h000000;
      else
        sgsa=24'h7F0000;
 end
 endfunction

 function integer sgea;
 input integer i;
 begin
      if (i == 0)
        sgea=24'h7EFFFF;
      else
        sgea=24'h7FFFFF;
 end
 endfunction

    reg  BuffInOE,  BuffInCE,  BuffInADDR;
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
