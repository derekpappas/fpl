//////////////////////////////////////////////////////////////////////////////
//  File name : s29ws512p.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004, Spansion, LCC.
//
//  MODIFICATION HISTORY :
//
//   version: | author:    |   mod date:  | changes made:
//     V1.0     T.Popovic      04 Dec 13    Initial
//     V1.1     T.Popovic      05 Feb 25    Latest datasheet aligned
//                                          Added Page Read
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        FLASH
//  Technology:     Flash Memory
//  Part:           s29ws512p
//
//  Description: 512 Mbit(32M x 16-Bit),Simultaneous Read/Write,
//               SDR/DDR Burst Mode Flash Memory
//////////////////////////////////////////////////////////////////////////////
//  Comments :
//      For correct simulation, simulator resolution should be set to 1ps
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps

module s29ws512p
(
    A24      ,
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

    CLK      ,
    RESETNeg ,
    CENeg    ,
    OENeg    ,
    WENeg    ,
    AVDNeg   ,
    WPNeg    ,
    ACC      ,
    DQS1     ,
    RDYDQS0
);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////

    input  A24  ;
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

    input  CLK      ;
    input  RESETNeg ;
    input  CENeg    ;
    input  OENeg    ;
    input  WENeg    ;
    input  AVDNeg   ;
    input  WPNeg    ;
    input  ACC      ;
    output DQS1     ;
    output RDYDQS0  ;

// interconnect path delay signals

    wire  A24_ipd  ;
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

    wire [24 : 0] A;
    assign A = {
                A24_ipd,
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

    wire  CLK_ipd      ;
    wire  RESETNeg_ipd ;
    wire  CENeg_ipd    ;
    wire  OENeg_ipd    ;
    wire  WENeg_ipd    ;
    wire  AVDNeg_ipd   ;
    wire  WPNeg_ipd    ;
    wire  ACC_ipd      ;

//  internal delays

    reg IACC_in ; // Initial access delay
    reg IACC_out;
    reg PPBP_in;  // PPB Program Timeout
    reg PPBP_out;
    reg PPBE_in;  // PPB Erase All Timeout
    reg PPBE_out;
    reg PUT_in;   // Password Unlock Timeout
    reg PUT_out;
    reg START_in; // Program/Erase Suspend
    reg START_out;// Timeout
    reg SET_in ;  // Sector Erase Timeout
    reg SET_out;
    reg READY_in; // Device Ready after Hardware
    reg READY_out;// Reset
    reg HANG_in;  // Operation Timing Limit
    reg HANG_out;

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
    reg RY_zd1;
    reg RDY_temp = 1'bz;

    reg DQS_zd;
    reg DQS_zd1;
    reg DQS_temp = 1'bz;

    parameter UserPreload = 1'b0;
    parameter mem_file_name = "none";
    parameter secsi_file_name = "none";
    parameter prot_file_name = "none";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID = "s29ws512p";
    parameter MaxData = 16'hFFFF;
    parameter MemSize = 25'h1FFFFFF;
    parameter SecNum = 517;
    parameter BankNum = 15;
    parameter SecGroupNum = 2;
    parameter SecSize64 = 16'hFFFF ;
    parameter SecSize16 = 16'h3FFF ;
    parameter BankSize = 21'h1FFFFF ;
    parameter HiAddrBit = 24;
    parameter PWLength = 3;
    parameter WrBuffLength = 31;
    parameter WrBuffPgNum = 20'hFFFFF ;

    //varaibles to resolve between devices
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;       //stores character
    integer found = 1'b0;

    // powerup
    reg PoweredUp = 1'b0;

    reg SYN = 1'b0;    //Synchronous mode
    reg SDR = 1'b0;    //Single Data Rate
    reg DDR = 1'b0;    //Double Data Rate
    reg ZHOLD = 1'b0;  //Zero Hold mode
    reg SYNC_DIS = 1'b0;

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

     //All sectors selected for programming are protected
    reg PERR     ;

    reg EDONE    ; //Ers. Done
    reg ESTART   ; //Start Erase
    reg ESUSP    ; //Suspend Erase
    reg ERES     ; //Resume Erase

    //All sectors selected for erasure are protected
    reg EERR     ;

    //Sectors selected for erasure
    reg [SecNum:0]  ERS_QUEUE; // = SecNum'b0;
    //Banks selected for erasure
    reg [BankNum:0] ERS_QUEUE_B; // = BankNum'b0;

    //Command Register
    reg WRITE = 1'b1;
    reg READ = 1'b1;
    reg BURST = 1'b1;
    reg ReadINIT = 1'b1;
    //Bus cycle decode process
    integer AddressLatched;
    integer WrAddressLatched;
    reg READCYCLE;
    reg WRITECYCLE;
    reg LATCHED;
    reg AVDLATCHED;

    integer BurstDelay;

    integer BankASAddr ;
    integer BankCFIAddr;
    integer PrgBank ;
    integer BankDYBAddr;
    integer BankPPBAddr ;

    integer CurrentReadPage;
    integer PreviousReadPage;
    reg InitialPageAccess;
    reg SubsequentPageAccess;

    reg HANG= 1'b0;

    reg CLKMerge = 1'b0;

    //signal used for latching the WPNeg input
    reg WP_l ;

    // WRITE buffer signals
    integer WrBuffSec;
    integer WrBuffPage;
    integer WrBuffCnt;
    integer WrCnt;
    integer WrBuffData[0:WrBuffLength];
    integer WrBuffAddr[0:WrBuffLength];

    //password signals
    integer PASS_UNLCK = 1'b0;
    integer PASS_TEMP[0:PWLength];

    //protection bit signals
    integer SecPPBAddr;

    //Address
    integer Addr  = -1;          // -1 - MemSize
    //Address 11 downto 0
    integer AddrCom  = 0;
    integer AddrPass = 0;        // 0 - 3
    //Sector Address
    integer SecAddr  = -1;       // -1 - SecNum
    //Bank Address
    integer BankID = -1;         // 0 - BankNum
    //Write page buffer address
    integer BuffPageAddr = -1;   // -1 - WrBuffPgNum
    integer D_tmp;
    integer Data;       //-1 TO MaxData;
    integer DataLo;     //0 TO MaxData;

    //glitch protection
    reg gWE_n ;
    reg gCE_n ;
    reg gOE_n ;
    reg gAVD_n ;

    //reset timing
    reg RST ;
    reg reseted ;

    //Memory
    integer Mem[0:MemSize];
    integer SecSiMem[0:8'hFF];
    integer CFIMem[8'h10:8'h67];
    reg[15:0] ConfReg0;
    reg[15:0] ConfReg1;
    reg[15:0] LOCK_REG;
    //Sector Protection Status
    integer Password[0:PWLength];
    reg[SecNum:0] DYB;
    reg[SecNum:0] PPB;
    reg PPB_LOCK;

    reg[SecNum:0] Boot_Sec = 0;

    // timing check violation
    reg Viol = 1'b0;

    // StateTransition values
    reg R;
    reg E;

    //StateGen
    //Command Sequence detection
    reg PATTERN_1 = 1'b0;
    reg PATTERN_2 = 1'b0;

    //ReadModeGen
    reg BURST_TR ;
    reg SYNCREAD ;

    //Functional
    reg oe = 1'b0;
    //Status reg.
    reg[7:0] Status = 8'b0;
    reg[15:0] old_bit;
    reg[15:0] new_bit;
    integer old_int;
    integer new_int;
    reg[7:0] temp;
    integer x;
    reg SecProt;

    integer WrBuffCnt_temp;
    integer WrCnt_temp;
    integer WrBuffData_temp[0:WrBuffLength];
    integer WrBuffAddr_temp[0:WrBuffLength+1];

    // Burst variables
    integer BurstAddr = -1;
    integer BurstSec = -1;
    integer LatencyAddr;
    integer BurstLength;
    integer RdCnt;
    reg[15:0] DOut_burst =16'bZ;
    reg[15:0] SyncData;
    reg[15:0] CrossData;

    integer WS_Initial;
    integer WS_Latency;
    integer WS_Boundary;

    //Burst mode control
    reg INITIAL;
    reg BOUNDARY_CROSS;
    reg NO_PROGRESS;
    reg BURST_END;
    reg IN_W_ELAPSED;
    reg DATA_DELAY = 1'b0;
    reg BusyBound ;

    integer DelayCyc_CNT  ;
    integer DelayCycSwitch;
    integer BoundarySwitch;

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
    integer OEDQ_01;
    integer CEDQ_01;
    integer ADDRDQIN_01;
    integer ADDRDQPAGE_01;
    integer IACCZHDQ_01;
    integer IACCLDQ_01;

    reg[15:0] TempData;
    event oe_event;

    // states
    reg [6:0] current_state;
    reg [6:0] next_state;
    reg [2:0] RD_MODE;

    reg [6:0] CFIExit;

    reg [15:0]OutputD ;

    reg deq;

    parameter NOSYNC        = 4'd0;
    parameter CONTINUOUS    = 4'd1;
    parameter LINEAR        = 4'd2;
    parameter LINEAR_NO_WRAP= 4'd3;
    parameter SYNCR         = 4'd4;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
    buf   (A24_ipd, A24);
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

    nmos   (RDYDQS0,RY_zd     , 1);
    nmos   (DQS1,   DQS_zd    , 1);
    wire deg;

 // Needed for TimingChecks
 // VHDL CheckEnable Equivalent
 wire CENeg_CLK_check;
 assign CENeg_CLK_check = ~ConfReg0[15] && ~AVDNeg && ~CENeg;
 wire A0_CLK_L_check;
 assign A0_CLK_L_check = ~ConfReg0[15] && ~AVDNeg && ~CENeg && ~ZHOLD;
 wire A0_CLK_ZH_check;
 assign A0_CLK_ZH_check = ~ConfReg0[15] && ~AVDNeg && ~CENeg && ZHOLD;
 wire AVDNeg_CLK_check;
 assign AVDNeg_CLK_check =  ~ConfReg0[15] && ~CENeg && ~AVDNeg;
 wire A0_AVDNeg_L_check;
 assign A0_AVDNeg_L_check = ~CENeg && ~ZHOLD;
 wire A0_AVDNeg_ZH_check;
 assign A0_AVDNeg_ZH_check = ~CENeg && ZHOLD;
 wire A0_WENeg_L_check;
 assign A0_WENeg_L_check = ~CENeg && OENeg && ~AVDNeg && ~ZHOLD;
 wire A0_WENeg_ZH_check;
 assign A0_WENeg_ZH_check = ~CENeg && OENeg && ~AVDNeg && ZHOLD;
 wire A0_CENeg_L_check;
 assign A0_CENeg_L_check = ~WENeg && OENeg && ~AVDNeg && ~ZHOLD;
 wire A0_CENeg_ZH_check;
 assign A0_CENeg_ZH_check = ~WENeg && OENeg && ~AVDNeg && ZHOLD;
 wire DQ0_WENeg_check;
 assign DQ0_WENeg_check = ~CENeg;
 wire DQ0_CENeg_check;
 assign DQ0_CENeg_check = ~WENeg;
 wire CLK_WENeg_check;
 assign CLK_WENeg_check = ~ConfReg0[15]&& ~CENeg && ~AVDNeg && CLK;
 wire OENeg_WENeg_check;
 assign OENeg_WENeg_check = ~PDONE || ~EDONE;
 wire AVDNeg_WENeg_check;
 assign AVDNeg_WENeg_check = ~CENeg;
 wire AVDNeg_CENeg_check;
 assign AVDNeg_CENeg_check = ~WENeg;
 wire DQ0_CLK_check;
 assign DQ0_CLK_check = ~ConfReg0[15] && ~CENeg && ~OENeg
                             && IN_W_ELAPSED && IACC_out;
 wire DQ0_CLK_DDR_check;
 assign DQ0_CLK_DDR_check = ~ConfReg0[15]&& ConfReg0[5] && ~CENeg && ~OENeg
                             && IN_W_ELAPSED && IACC_out;

 wire AVDNeg_ASYN_check;
 assign AVDNeg_ASYN_check = ~SYN;
 wire AVDNeg_SYN_check;
 assign AVDNeg_SYN_check = SYN;
 wire CLK_SDR_check;
 assign CLK_SDR_check = ~ConfReg0[15]&& ~ConfReg0[5];
 wire CLK_DDR_check;
 assign CLK_DDR_check = ~ConfReg0[15]&& ConfReg0[5];
 //Pathdelay wires
 wire TRACCR;
 assign TRACCR =(~CENeg && ~ConfReg0[15] && ~ConfReg0[5]&& CLK &&~ConfReg0[4])||
   (~CENeg && ~ConfReg0[15] && ConfReg0[5]&& ~ConfReg0[4])||
   (~CENeg && ~ConfReg0[15] &&~(DATA_DELAY)&&~ConfReg0[5]&&CLK && ConfReg0[4])||
   (~CENeg && ~ConfReg0[15] && ~(DATA_DELAY)&& ConfReg0[5]&& ConfReg0[4]);
 wire TBACCR;
 assign TBACCR =(~CENeg && ~ConfReg0[15] && DATA_DELAY && ~ConfReg0[5]
                                                        && CLK && ConfReg0[4])||
   (~CENeg && ~ConfReg0[15] && DATA_DELAY && ConfReg0[5]&& ConfReg0[4]);
 wire TRACCD;
 assign TRACCD =(~CENeg && ~ConfReg0[15] && ~DATA_DELAY&& ~ConfReg0[5]&& CLK )||
   (~CENeg && ~ConfReg0[15]&& ~DATA_DELAY && ConfReg0[5]);
 wire TBACCD;
 assign TBACCD =(~CENeg && ~ConfReg0[15] && DATA_DELAY && ~ConfReg0[5]&& CLK )||
   (~CENeg && ~ConfReg0[15]&& DATA_DELAY && ConfReg0[5]);

reg temp15 = ConfReg0[15];
reg temp5 = ConfReg0[5];

 specify

    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

        // tpd delays
    specparam        tpd_RESETNeg_DQ0                   = 1;//
    specparam        tpd_A0_DQ0_InitialPageAccess_EQ_1  = 1;//tacc
    specparam        tpd_A0_DQ0_SubsequentPageAccess_EQ_1= 1;//tacc
    specparam        tpd_CENeg_DQ0                      = 1;//tce
    specparam        tpd_OENeg_DQ0                      = 1;//toe, toeZ
    specparam        tpd_CLK_DQ0                        = 1;//tbacc
    specparam        tpd_OENeg_RDYDQS0                  = 1;//toe
    specparam        tpd_CENeg_RDYDQS0                  = 1;//tcr, tcez
    specparam        tpd_OENeg_DQS1                     = 1;//toe, tcez
    specparam        tpd_CENeg_DQS1                     = 1;//tcr, tcez
    specparam        tpd_CLK_RDYDQS0_TRACCR_EQ_1        = 1;//tracc
    specparam        tpd_CLK_RDYDQS0_TBACCR_EQ_1        = 1;//tbacc
    specparam        tpd_CLK_DQS1_TRACCD_EQ_1           = 1;//tracc
    specparam        tpd_CLK_DQS1_TBACCD_EQ_1           = 1;//tbacc

    //tsetup values
    specparam      tsetup_CENeg_CLK                           = 1;//tces edge/
    specparam      tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge    = 1;//tas edge/
    specparam      tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge    = 1;//tas edge/
    specparam      tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge = 1;//taavds /
    specparam      tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge = 1;//taavds /
    specparam      tsetup_AVDNeg_CLK                          = 1;//tavc edge/
    specparam      tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge  = 1;//tas edge\
    specparam      tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge  = 1;//tas edge\
    specparam      tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge  = 1;//tas edge\
    specparam      tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge  = 1;//tas edge\
    specparam      tsetup_AVDNeg_WENeg    = 1;//tavsw edge \
    specparam      tsetup_AVDNeg_CENeg    = 1;//tavsw edge \
    specparam      tsetup_DQ0_WENeg       = 1;//tds edge /
    specparam      tsetup_DQ0_CENeg       = 1;//tds edge /
    specparam      tsetup_CLK_WENeg       = 1;//tcsw edge \
    specparam      tsetup_CENeg_AVDNeg    = 1;//tcas edge \
    specparam      tsetup_CENeg_WENeg     = 1;//tcs edge \
    specparam      tsetup_WENeg_CENeg     = 1;//tcs edge \

    //thold values
    specparam        thold_CENeg_RESETNeg                       = 1;//trh edge /
    specparam        thold_OENeg_RESETNeg                       = 1;//trh edge /
    specparam        thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge     = 1;//tah edge /
    specparam        thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge     = 1;//tah edge /
    specparam        thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge  = 1;//tah edge /
    specparam        thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge  = 1;//tah edge /
    specparam        thold_AVDNeg_CLK                           = 1;//tavhc ed /
    specparam        thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge   = 1;//tas edge /
    specparam        thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge   = 1;//tas edge /
    specparam        thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge   = 1;//tas edge /
    specparam        thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge   = 1;//tas edge /
    specparam        thold_AVDNeg_WENeg   = 1;//tavhw edge \
    specparam        thold_AVDNeg_CENeg   = 1;//tavhw edge \
    specparam        thold_OENeg_WENeg    = 1;//toeh edge /
    specparam        thold_CENeg_WENeg    = 1;//tch edge /
    specparam        thold_WENeg_CENeg    = 1;//tch edge /
    specparam        thold_DQ0_WENeg      = 1;//tdh edge /
    specparam        thold_DQ0_CENeg      = 1;//tdh edge /
    specparam        thold_DQ0_CLK        = 1;//tbdh edge /

    //tpw values
    specparam        tpw_RESETNeg_negedge           = 1; //trp
    specparam        tpw_AVDNeg_SYN_EQ_0_negedge    = 1; //tavdp
    specparam        tpw_AVDNeg_SYN_EQ_1_negedge    = 1; //tavdp
    specparam        tpw_WENeg_negedge              = 1; //twp
    specparam        tpw_WENeg_posedge              = 1; //twphwith
    specparam        tpw_CENeg_negedge              = 1; //twp
    specparam        tpw_CENeg_posedge              = 1; //twph
    specparam        tpw_CLK_SDR_EQ_1_negedge= 1; //tcl
    specparam        tpw_CLK_DDR_EQ_1_negedge= 1; //tcl
    specparam        tpw_CLK_SDR_EQ_1_posedge= 1; //tch
    specparam        tpw_CLK_DDR_EQ_1_posedge= 1; //tch
    //period values
    specparam        tperiod_WENeg_negedge = 1; //tWC
    specparam        tperiod_WENeg_posedge = 1; //tWC
    specparam        tperiod_CENeg_negedge = 1; //tWC
    specparam        tperiod_CENeg_posedge = 1; //tWC
    specparam        tperiod_CLK_SDR_EQ_1  = 1; //tCLK
    specparam        tperiod_CLK_DDR_EQ_1  = 1; //tCLK
    //tdevice values: values for internal delays
    specparam        tdevice_PWO          = 30000;
    specparam        tdevice_WRBO         = 6000;
    specparam        tdevice_SEO64        = 600000000;
    specparam        tdevice_SEO16        = 350000000;
    specparam        tdevice_HANG         = 400000000;
    specparam        tdevice_IACC_ZH      = 83;
    specparam        tdevice_IACC_L       = 80;
    specparam        tdevice_PPBP         = 150000;
    specparam        tdevice_PPBE         = 15000000;
    specparam        tdevice_PUT          = 1000;
    specparam        tdevice_START        = 20000;
    specparam        tdevice_SET          = 50000;
    specparam        tdevice_READY        = 10000;

    specparam        tdevice_IACC_ZH_ts   = 83000;
    specparam        tdevice_IACC_L_ts    = 80000;

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

// Data ouptut paths

    if (FROMCE)
        ( CENeg => DQ0 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ1 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ2 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ3 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ4 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ5 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ6 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ7 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ8 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ9 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ10 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ11 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ12 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ13 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ14 ) = tpd_CENeg_DQ0;
    if (FROMCE)
        ( CENeg => DQ15 ) = tpd_CENeg_DQ0;

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

    if(InitialPageAccess) (A0=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A0=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A1=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A2=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A3=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A4=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A5=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A6=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A7=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A8=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A9=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A10=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A11=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A12=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A13=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A14=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A15=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A16=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A17=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A18=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A19=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A20=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A21=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A22=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A23=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ0) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ1) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ2) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ3) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ4) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ5) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ6) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ7) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ8) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ9) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ10) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ11) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ12) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ13) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ14) =tpd_A0_DQ0_InitialPageAccess_EQ_1;
    if(InitialPageAccess) (A24=>DQ15) =tpd_A0_DQ0_InitialPageAccess_EQ_1;

    if(SubsequentPageAccess) (A0=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A0=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A1=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A2=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A3=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A4=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A5=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A6=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A7=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A8=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A9=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A10=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A11=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A12=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A13=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A14=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A15=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A16=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A17=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A18=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A19=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A20=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A21=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A22=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A23=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ0) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ1) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ2) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ3) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ4) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ5) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ6) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ7) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ8) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ9) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ10) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ11) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ12) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ13) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ14) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;
    if(SubsequentPageAccess) (A24=>DQ15) =tpd_A0_DQ0_SubsequentPageAccess_EQ_1;

    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ0 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ1 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ2 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ3 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ4 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ5 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ6 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ7 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ8 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ9 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ10 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ11 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ12 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ13 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ14 ) = tpd_CLK_DQ0;
    if ((~CENeg && ~temp15 && IN_W_ELAPSED && CLK &&
        (RD_MODE == CONTINUOUS || RD_MODE==LINEAR || RD_MODE == LINEAR_NO_WRAP)
         && ~SYNC_DIS)||(~CENeg && ~temp15&& IN_W_ELAPSED && ~CLK &&
         temp5 && (RD_MODE == CONTINUOUS || RD_MODE==LINEAR||
         RD_MODE == LINEAR_NO_WRAP)&& ~SYNC_DIS ))
            ( CLK => DQ15 ) = tpd_CLK_DQ0;

    if (~RESETNeg)
        ( RESETNeg => DQ0 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ1 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ2 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ3 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ4 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ5 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ6 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ7 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ8 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ9 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ10 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ11 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ12 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ13 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ14 ) = tpd_RESETNeg_DQ0;
    if (~RESETNeg)
        ( RESETNeg => DQ15 ) = tpd_RESETNeg_DQ0;

// RDY output paths
    (CENeg *> RDYDQS0) = tpd_CENeg_RDYDQS0;
    if (~CENeg && ~temp15)
        (OENeg *> RDYDQS0) = tpd_OENeg_RDYDQS0;
    if (TRACCR)
        ( CLK *>  RDYDQS0 ) = tpd_CLK_RDYDQS0_TRACCR_EQ_1;
    if (TBACCR)
        ( CLK *>  RDYDQS0 ) = tpd_CLK_RDYDQS0_TBACCR_EQ_1;

// DQS1 output paths
    (CENeg *> DQS1) = tpd_CENeg_DQS1;
    if (~CENeg && ~temp15)
        (OENeg *> DQS1) = tpd_OENeg_DQS1;
    if (TRACCD)
        ( CLK *>  DQS1 ) = tpd_CLK_DQS1_TRACCD_EQ_1;
    if (TBACCD)
        ( CLK *>  DQS1 ) = tpd_CLK_DQS1_TBACCD_EQ_1;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////

        $setup ( CENeg , posedge CLK &&& CENeg_CLK_check,tsetup_CENeg_CLK,Viol);
        $setup ( A0  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A1  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A2  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A3  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A4  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A5  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A6  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A7  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A8  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A9  , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A10 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A11 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A12 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A13 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A14 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A15 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A16 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A17 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A18 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A19 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A20 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A21 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A22 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A23 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A24 , posedge CLK &&& A0_CLK_L_check,
                              tsetup_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);

        $setup ( A0  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A1  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A2  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A3  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A4  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A5  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A6  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A7  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A8  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A9  , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A10 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A11 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A12 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A13 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A14 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A15 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A16 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A17 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A18 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A19 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A20 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A21 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A22 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A23 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A24 , posedge CLK &&& A0_CLK_ZH_check,
                              tsetup_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);

        $setup ( AVDNeg , posedge CLK &&& AVDNeg_CLK_check,
                                                    tsetup_AVDNeg_CLK, Viol);

        $setup ( A0  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A1  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A2  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A3  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A4  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A5  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A6  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A7  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A8  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A9  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A10  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A11  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A12  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A13  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A14  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A15  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A16  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A17  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A18  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A19  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A20  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A21  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A22  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A23  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $setup ( A24  , posedge AVDNeg &&& A0_AVDNeg_L_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);

        $setup ( A0  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A1  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A2  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A3  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A4  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A5  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A6  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A7  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A8  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A9  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A10  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A11  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A12  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A13  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A14  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A15  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A16  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A17  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A18  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A19  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A20  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A21  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A22  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A23  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $setup ( A24  , posedge AVDNeg &&& A0_AVDNeg_ZH_check,
                           tsetup_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);

        $setup ( A0  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A1  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A2  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A3  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A4  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A5  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A6  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A7  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A8  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A9  , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A10 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A11 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A12 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A13 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A14 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A15 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A16 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A17 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A18 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A19 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A20 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A21 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A22 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A23 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A24 , negedge WENeg &&& A0_WENeg_L_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);

        $setup ( A0  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A1  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A2  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A3  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A4  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A5  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A6  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A7  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A8  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A9  , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A10 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A11 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A12 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A13 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A14 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A15 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A16 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A17 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A18 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A19 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A20 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A21 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A22 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A23 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A24 , negedge WENeg &&& A0_WENeg_ZH_check,
                              tsetup_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);

        $setup ( A0  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A1  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A2  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A3  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A4  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A5  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A6  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A7  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A8  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A9  , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A10 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A11 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A12 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A13 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A14 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A15 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A16 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A17 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A18 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A19 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A20 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A21 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A22 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A23 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $setup ( A24 , negedge CENeg &&& A0_CENeg_L_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);

        $setup ( A0  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A1  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A2  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A3  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A4  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A5  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A6  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A7  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A8  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A9  , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A10 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A11 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A12 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A13 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A14 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A15 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A16 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A17 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A18 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A19 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A20 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A21 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A22 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A23 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $setup ( A24 , negedge CENeg &&& A0_CENeg_ZH_check,
                              tsetup_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);

        $setup ( DQ0, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ1, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ2, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ3, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ4, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ5, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ6, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ7, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ8, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ9, posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ10,posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ11,posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ12,posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ13,posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ14,posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);
        $setup ( DQ15,posedge WENeg &&& DQ0_WENeg_check,tsetup_DQ0_WENeg, Viol);

        $setup ( DQ0, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ1, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ2, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ3, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ4, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ5, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ6, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ7, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ8, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ9, posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ10,posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ11,posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ12,posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ13,posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ14,posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);
        $setup ( DQ15,posedge CENeg &&& DQ0_CENeg_check,tsetup_DQ0_CENeg, Viol);

        $setup ( CLK  ,negedge WENeg &&& CLK_WENeg_check,tsetup_CLK_WENeg,Viol);
        $setup ( AVDNeg ,negedge WENeg &&& AVDNeg_WENeg_check
                                                     ,tsetup_AVDNeg_WENeg,Viol);
        $setup ( AVDNeg ,negedge CENeg &&& AVDNeg_CENeg_check
                                                     ,tsetup_AVDNeg_CENeg,Viol);

        $setup ( CENeg ,negedge AVDNeg,tsetup_CENeg_AVDNeg,Viol);

        $setup ( CENeg ,negedge WENeg,tsetup_CENeg_WENeg,Viol);
        $setup ( WENeg ,negedge CENeg,tsetup_WENeg_CENeg,Viol);

        $hold ( posedge RESETNeg, CENeg,thold_CENeg_RESETNeg,Viol);
        $hold ( posedge RESETNeg, OENeg,thold_OENeg_RESETNeg,Viol);

        $hold ( posedge CLK &&& A0_CLK_L_check, A0 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A1 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A2 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A3 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A4 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A5 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A6 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A7 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A8 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A9 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A10 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A11 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A12 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A13 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A14 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A15 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A16 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A17 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A18 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A19 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A20 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A21 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A22 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A23 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_L_check, A24 ,
                            thold_A0_CLK_ZHOLD_EQ_0_noedge_posedge, Viol);

        $hold ( posedge CLK &&& A0_CLK_ZH_check, A0 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A1 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A2 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A3 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A4 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A5 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A6 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A7 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A8 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A9 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A10 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A11 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A12 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A13 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A14 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A15 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A16 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A17 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A18 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A19 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A20 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A21 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A22 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A23 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge CLK &&& A0_CLK_ZH_check, A24 ,
                            thold_A0_CLK_ZHOLD_EQ_1_noedge_posedge, Viol);

        $hold ( posedge CLK &&& AVDNeg_CLK_check, AVDNeg
                                                   ,thold_AVDNeg_CLK, Viol);
        $hold ( posedge WENeg &&& OENeg_WENeg_check ,OENeg
                                                  ,thold_OENeg_WENeg, Viol);
        $hold ( negedge WENeg &&& AVDNeg_WENeg_check ,AVDNeg
                                                 ,thold_AVDNeg_WENeg, Viol);
        $hold ( negedge CENeg &&& AVDNeg_CENeg_check ,AVDNeg
                                                 ,thold_AVDNeg_CENeg, Viol);

        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A0 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A1 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A2 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A3 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A4 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A5 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A6 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A7 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A8 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A9 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A10 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A11 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A12 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A13 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A14 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A15 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A16 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A17 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A18 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A19 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A20 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A21 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A22 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A23 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_L_check, A24 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_0_noedge_posedge, Viol);

        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A0 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A1 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A2 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A3 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A4 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A5 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A6 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A7 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A8 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A9 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A10 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A11 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A12 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A13 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A14 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A15 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A16 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A17 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A18 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A19 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A20 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A21 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A22 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A23 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);
        $hold ( posedge AVDNeg &&& A0_AVDNeg_ZH_check, A24 ,
                            thold_A0_AVDNeg_ZHOLD_EQ_1_noedge_posedge, Viol);

        $hold ( negedge WENeg &&& A0_WENeg_L_check, A0 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A1 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A2 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A3 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A4 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A5 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A6 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A7 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A8 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A9 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A10 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A11 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A12 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A13 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A14 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A15 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A16 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A17 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A18 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A19 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A20 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A21 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A22 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A23 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_L_check, A24 ,
                            thold_A0_WENeg_ZHOLD_EQ_0_noedge_negedge, Viol);

        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A0 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A1 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A2 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A3 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A4 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A5 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A6 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A7 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A8 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A9 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A10 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A11 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A12 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A13 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A14 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A15 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A16 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A17 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A18 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A19 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A20 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A21 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A22 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A23 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge WENeg &&& A0_WENeg_ZH_check, A24 ,
                            thold_A0_WENeg_ZHOLD_EQ_1_noedge_negedge, Viol);

        $hold ( negedge CENeg &&& A0_CENeg_L_check, A0 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A1 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A2 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A3 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A4 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A5 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A6 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A7 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A8 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A9 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A10 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A11 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A12 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A13 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A14 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A15 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A16 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A17 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A18 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A19 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A20 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A21 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A22 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A23 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_L_check, A24 ,
                            thold_A0_CENeg_ZHOLD_EQ_0_noedge_negedge, Viol);

        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A0 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A1 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A2 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A3 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A4 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A5 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A6 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A7 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A8 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A9 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A10 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A11 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A12 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A13 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A14 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A15 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A16 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A17 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A18 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A19 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A20 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A21 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A22 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A23 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);
        $hold ( negedge CENeg &&& A0_CENeg_ZH_check, A24 ,
                            thold_A0_CENeg_ZHOLD_EQ_1_noedge_negedge, Viol);

        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ0 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ1 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ2 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ3 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ4 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ5 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ6 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ7 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ8 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ9 , thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ10 ,thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ11 ,thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ12 ,thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ13 ,thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ14 ,thold_DQ0_WENeg, Viol);
        $hold ( posedge WENeg &&& DQ0_WENeg_check, DQ15 ,thold_DQ0_WENeg, Viol);

        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ0 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ1 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ2 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ3 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ4 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ5 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ6 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ7 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ8 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ9 , thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ10 ,thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ11 ,thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ12 ,thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ13 ,thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ14 ,thold_DQ0_CENeg, Viol);
        $hold ( posedge CENeg &&& DQ0_CENeg_check, DQ15 ,thold_DQ0_CENeg, Viol);

        $hold ( posedge CLK &&& DQ0_CLK_check, DQ0 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ1 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ2 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ3 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ4 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ5 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ6 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ7 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ8 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ9 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ10 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ11 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ12 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ13 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ14 ,thold_DQ0_CLK, Viol);
        $hold ( posedge CLK &&& DQ0_CLK_check, DQ15 ,thold_DQ0_CLK, Viol);

        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ0 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ1 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ2 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ3 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ4 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ5 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ6 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ7 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ8 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ9 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ10 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ11 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ12 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ13 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ14 ,thold_DQ0_CLK, Viol);
        $hold ( negedge CLK &&& DQ0_CLK_DDR_check, DQ15 ,thold_DQ0_CLK, Viol);

        $hold ( posedge WENeg , CENeg ,thold_CENeg_WENeg, Viol);
        $hold ( posedge CENeg , WENeg ,thold_WENeg_CENeg, Viol);

        $width (negedge RESETNeg ,tpw_RESETNeg_negedge);
        $width (negedge AVDNeg &&& AVDNeg_ASYN_check ,
                                                  tpw_AVDNeg_SYN_EQ_0_negedge);
        $width (negedge AVDNeg &&& AVDNeg_SYN_check ,
                                                  tpw_AVDNeg_SYN_EQ_1_negedge);
        $width (posedge WENeg   , tpw_WENeg_posedge);
        $width (negedge WENeg   , tpw_WENeg_negedge);
        $width (posedge CENeg   , tpw_CENeg_posedge);
        $width (negedge CENeg   , tpw_CENeg_negedge);
        $width (negedge CLK &&& CLK_SDR_check, tpw_CLK_SDR_EQ_1_negedge);
        $width (posedge CLK &&& CLK_SDR_check, tpw_CLK_SDR_EQ_1_negedge);
        $width (negedge CLK &&& CLK_DDR_check, tpw_CLK_DDR_EQ_1_negedge);
        $width (posedge CLK &&& CLK_DDR_check, tpw_CLK_DDR_EQ_1_negedge);

        $period(negedge WENeg, tperiod_WENeg_negedge);
        $period(posedge WENeg, tperiod_WENeg_posedge);
        $period(negedge CENeg, tperiod_CENeg_negedge);
        $period(posedge CENeg, tperiod_CENeg_posedge);
        $period(negedge CLK &&& CLK_SDR_check, tperiod_CLK_SDR_EQ_1);
        $period(posedge CLK &&& CLK_SDR_check, tperiod_CLK_SDR_EQ_1);
        $period(negedge CLK &&& CLK_DDR_check, tperiod_CLK_DDR_EQ_1);
        $period(posedge CLK &&& CLK_DDR_check, tperiod_CLK_DDR_EQ_1);

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
    //device ready after Hardware reset
    time       tdevice_READY_ts   = tdevice_READY * 1000;
    //Protection Bit Program
    time       tdevice_PPBP_ts    = tdevice_PPBP * 1000;
    //Protection Bit Erase
    time       tdevice_PPBE_ts    = tdevice_PPBE * 1000;
    //Password Unlock
    time       tdevice_PUT_ts     = tdevice_PUT * 1000;
    //Hang
    time       tdevice_HANG_ts    = tdevice_HANG * 1000;

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////
    // FSM states
    parameter RESET                 =8'h00;
    parameter Z001                  =8'h01;
    parameter CFI                   =8'h02;
    parameter PREL_SETBWB           =8'h03;
    parameter PREL_ULBYPASS         =8'h04;
    parameter PREL_ULBYPASS_RESET   =8'h05;
    parameter A0SEEN                =8'h06;
    parameter SECSI_A0SEEN          =8'h07;
    parameter C8                    =8'h08;
    parameter C8_Z001               =8'h09;
    parameter C8_PREL               =8'h0A;
    parameter ERS                   =8'h0B;
    parameter SERS                  =8'h0C;
    parameter ESPS                  =8'h0D;
    parameter SERS_EXEC             =8'h0E;
    parameter ESP                   =8'h0F;
    parameter ESP_Z001              =8'h10;
    parameter ESP_PREL              =8'h11;
    parameter PREL_WR2BUFF          =8'h12;
    parameter WR2BUFF_0             =8'h13;
    parameter WR2BUFF_CNT           =8'h14;
    parameter PREL_PRFLASH          =8'h15;
    parameter PGMS                  =8'h16;
    parameter PGSPS                 =8'h17;
    parameter PGS                   =8'h18;
    parameter PGS_Z001              =8'h19;
    parameter PGS_PREL              =8'h1A;
    parameter WR2BUFF_AB            =8'h1B;
    parameter WR2BUFF_AB_Z001       =8'h1C;
    parameter WR2BUFF_AB_PREL       =8'h1D;
    parameter AS                    =8'h1E;
    parameter SECSI_EX              =8'h1F;
    parameter SET_CONF              =8'h20;
    parameter SET_CONF1             =8'h21;
    parameter SET_CONF_EXIT         =8'h22;
    parameter RD_CONF               =8'h23;
    parameter PREL_PASS             =8'h24;
    parameter PASS_A0SEEN           =8'h25;
    parameter PASS_EX               =8'h26;
    parameter PASS_UN_Z001          =8'h27;
    parameter PASS_UN_PREL          =8'h28;
    parameter PASS_UN1              =8'h29;
    parameter PASS_UN2              =8'h2A;
    parameter PASS_UN3              =8'h2B;
    parameter PASS_UN4              =8'h2C;
    parameter PASS_UN_W             =8'h2D;
    parameter PREL_LR               =8'h2E;
    parameter LR_A0SEEN             =8'h2F;
    parameter LR_PREL_EX            =8'h30;
    parameter PREL_PPB              =8'h31;
    parameter PPB_PREL_PR           =8'h32;
    parameter PPB_PGMS              =8'h33;
    parameter PPB_PREL_ER           =8'h34;
    parameter PPB_ERS               =8'h35;
    parameter PPB_PREL_EX           =8'h36;
    parameter PREL_PPBLCK           =8'h37;
    parameter PPBLCK_PREL_ST        =8'h38;
    parameter PPBLCK_PREL_EX        =8'h39;
    parameter PREL_DYB              =8'h3A;
    parameter DYB_PREL_ST           =8'h3B;
    parameter DYB_PREL_EX           =8'h3C;

    //////////////////////////////////////////////////////////
    //          Output Data Gen
    //////////////////////////////////////////////////////////
    always @(DOut_zd)
    begin : OutputGen
        if (DOut_zd[0] !== 1'bz)
        begin
            CEDQ_t = CENeg_event + CEDQ_01;
            OEDQ_t = OENeg_event + OEDQ_01;
            ADDRDQ_t = ADDR_event + ADDRDQIN_01;
            if (SubsequentPageAccess)
                ADDRDQ_t = ADDR_event + ADDRDQPAGE_01;
            FROMCE = ((CEDQ_t > OEDQ_t) && ( CEDQ_t >= $time));
            FROMOE = ((OEDQ_t >= CEDQ_t) && ( OEDQ_t >= $time));
            if ((ADDRDQ_t > $time )&&
             (((ADDRDQ_t>OEDQ_t) && FROMOE) ||
              ((ADDRDQ_t>CEDQ_t) && FROMCE)))
            begin
                TempData = DOut_zd;
                DOut_Pass = 16'bx;
                #( ADDRDQ_t - $time ) DOut_Pass = TempData;
            end
            else if ((OEDQ_t < $time && CEDQ_t < $time ) &&
             (ADDRDQ_t > $time ))
            begin
                TempData = DOut_zd;
                #( ADDRDQ_t - $time ) DOut_Pass = TempData;
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
    always @(RDY_temp or negedge CENeg)
    begin
        if (ConfReg0[15] == 1'b0 && ~CENeg)
        begin
            if(~ConfReg0[4])
                if (ConfReg0[10])
                    RY_zd = RDY_temp;
                else
                    RY_zd = ~RDY_temp;
        end
        else
            RY_zd = 1'bz;
    end

    always @(DQS_temp or negedge CENeg)
    begin
        if (ConfReg0[15] == 1'b0 && ~CENeg)
        begin
            if(ConfReg0[4])
                if (DQS_temp ==1'bZ || ConfReg0[10])
                    RY_zd = DQS_temp;
                else
                    RY_zd = ~DQS_temp;
        end
        else
            RY_zd = 1'bz;
    end

    always @(posedge CENeg)
    begin
        RY_zd = 1'bz;
    end

    //////////////////////////////////////////////////////////
    //          DQS1 Pin Value Gen
    //////////////////////////////////////////////////////////
    always @(DQS_temp or negedge CENeg)
    begin
        if (ConfReg0[15] == 1'b0 && ~CENeg)
            if (DQS_temp ==1'bZ || ConfReg0[10])
                DQS_zd = DQS_temp;
            else
                DQS_zd = ~DQS_temp;
        else
            DQS_zd = 1'bz;
    end

    always @(posedge CENeg)
    begin
        DQS_zd = 1'bz;
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
        // This  may be timing model specific
        LOCK_REG[15:5] = ~(0);
        LOCK_REG[4] = 1'b1;
        LOCK_REG[3] = 1'b1;
        LOCK_REG[2:0] = ~(0);
        PPB_LOCK = 1'b1;
        for (i=0;i<=SecNum;i=i+1)
            Boot_Sec[i] = 1'b0;
        Boot_Sec[3:0] = ~(0);
        Boot_Sec[SecNum:SecNum-3] = ~(0);
        PreviousReadPage = -1;
        ZHOLD = 1'b0;
    end

    // initialize CFI array
    initial
    begin
            //CFI Query Identification String
        CFIMem[8'h10] = 16'h0051;
        CFIMem[8'h11] = 16'h0052;
        CFIMem[8'h12] = 16'h0059;
        CFIMem[8'h13] = 16'h0002;
        CFIMem[8'h14] = 16'h0000;
        CFIMem[8'h15] = 16'h0040;
        CFIMem[8'h16] = 16'h0000;
        CFIMem[8'h17] = 16'h0000;
        CFIMem[8'h18] = 16'h0000;
        CFIMem[8'h19] = 16'h0000;
        CFIMem[8'h1A] = 16'h0000;
            //System Interface String
        CFIMem[8'h1B] = 16'h0017;
        CFIMem[8'h1C] = 16'h0019;
        CFIMem[8'h1D] = 16'h0000;
        CFIMem[8'h1E] = 16'h0000;
        CFIMem[8'h1F] = 16'h0005;
        CFIMem[8'h20] = 16'h0009;
        CFIMem[8'h21] = 16'h0008;
        CFIMem[8'h22] = 16'h0000;
        CFIMem[8'h23] = 16'h0003;
        CFIMem[8'h24] = 16'h0001;
        CFIMem[8'h25] = 16'h0003;
        CFIMem[8'h26] = 16'h0000;
            //Device Geometry Definition
        CFIMem[8'h27] = 16'h0020;
        CFIMem[8'h28] = 16'h0001;
        CFIMem[8'h29] = 16'h0000;
        CFIMem[8'h2A] = 16'h0005;
        CFIMem[8'h2B] = 16'h0000;
        CFIMem[8'h2C] = 16'h0003;
        CFIMem[8'h2D] = 16'h0003;
        CFIMem[8'h2E] = 16'h0000;
        CFIMem[8'h2F] = 16'h0080;
        CFIMem[8'h30] = 16'h0000;
        CFIMem[8'h31] = 16'h01FD;
        CFIMem[8'h32] = 16'h0000;
        CFIMem[8'h33] = 16'h0000;
        CFIMem[8'h34] = 16'h0002;
        CFIMem[8'h35] = 16'h0003;
        CFIMem[8'h36] = 16'h0000;
        CFIMem[8'h37] = 16'h0080;
        CFIMem[8'h38] = 16'h0000;
        CFIMem[8'h39] = 16'h0000;
        CFIMem[8'h3A] = 16'h0000;
        CFIMem[8'h3B] = 16'h0000;
        CFIMem[8'h3C] = 16'h0000;
            //Primary Vendor-Specific Extended Query
        CFIMem[8'h40] = 16'h0050;
        CFIMem[8'h41] = 16'h0052;
        CFIMem[8'h42] = 16'h0049;
        CFIMem[8'h43] = 16'h0031;
        CFIMem[8'h44] = 16'h0034;
        CFIMem[8'h45] = 16'h000A;
        CFIMem[8'h46] = 16'h0002;
        CFIMem[8'h47] = 16'h0001;
        CFIMem[8'h48] = 16'h0000;
        CFIMem[8'h49] = 16'h0008;
        CFIMem[8'h4A] = 16'h01E3;
        CFIMem[8'h4B] = 16'h0001;
        CFIMem[8'h4C] = 16'h0002;
        CFIMem[8'h4D] = 16'h0085;
        CFIMem[8'h4E] = 16'h0095;
        CFIMem[8'h4F] = 16'h0001;
        CFIMem[8'h50] = 16'h0001;
        CFIMem[8'h51] = 16'h0001;
        CFIMem[8'h52] = 16'h0008;
        CFIMem[8'h53] = 16'h0014;
        CFIMem[8'h54] = 16'h0014;
        CFIMem[8'h55] = 16'h0005;
        CFIMem[8'h56] = 16'h0005;
        CFIMem[8'h57] = 16'h0010;
        CFIMem[8'h58] = 16'h0023;
        CFIMem[8'h59] = 16'h0020;
        CFIMem[8'h5A] = 16'h0020;
        CFIMem[8'h5B] = 16'h0020;
        CFIMem[8'h5C] = 16'h0020;
        CFIMem[8'h5D] = 16'h0020;
        CFIMem[8'h5E] = 16'h0020;
        CFIMem[8'h5F] = 16'h0020;
        CFIMem[8'h60] = 16'h0020;
        CFIMem[8'h61] = 16'h0020;
        CFIMem[8'h62] = 16'h0020;
        CFIMem[8'h63] = 16'h0020;
        CFIMem[8'h64] = 16'h0020;
        CFIMem[8'h65] = 16'h0020;
        CFIMem[8'h66] = 16'h0020;
        CFIMem[8'h67] = 16'h0023;
    end

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j;
    integer tmp1,tmp2,tmp3;
    integer secsi[0:8'hFF];
    reg     sector_prot[0:SecNum];

        for (i=0;i<=MemSize;i=i+1)
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
            //s29ws512p_prot  sector protect file
            //    //   - comment
            //   @aaa  - <aaa> stands for sector identification 0..205h
            //   If not specified for sector in this file the
            //   corresponding sector will be unprotected ( default ).
            //   Only first 1-4 columns are loaded
            //   No empty lines
            //   Note that sector number length must be strictly 3
            //   ( 001 instead of 1 etc. )
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && !(mem_file_name == "none"))
        begin
            // s29ws512p memory file
            //  //       - comment
            //  @aaaaaaa - <aaaaaaa> stands for address
            //  dddd     - <dddd> is word to be written at Mem(aaaaaaa++)
            //  aaaaaaa is incremented at every load)
            //  only first 1-8 columns are loaded.
            //  32 words region for BURST mode testing starts at 00F0
            //  NO EMPTY LINES
            //////////////////////////////////////////////////////////////////
            // preload sector 3 in bank 3 with recognizable data
            // for burst read mode testing
            // address range to be filled is 90h to FFh
            //////////////////////////////////////////////////////////////////
            // Fill region near bank boundary 2//>3 with recognizable data
            // preload last sector in bank 2 (98) and first one in bank 3 (99)
            // for burst read mode with bank cross testing
            // address range to be filled is 16#FFF0# to 16#FFFF# for within
            // sector 98 and 16#00# to 16#6F# in sector 99
            // verify bank boundary read behavior with crosses to busy and
            // non-busy bank
            //////////////////////////////////////////////////////////////////
           $readmemh(mem_file_name,Mem);
        end
        if (UserPreload && !(secsi_file_name == "none"))
        begin
            //s29ws512p_secsi memory file
            //  //      - comment
            //  @aa     - <aa> stands for address within SecSi region
            //  dddd    - <dddd> is word to be written at SecSi(aa++)
            //  (aa is incremented at every load)
            //  only first 1-4 columns are loaded. NO empty lines !
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

     //Power Up time 30 us
    initial
    begin
        PoweredUp = 1'b0;
        #30000 PoweredUp = 1'b1;
    end

    always @(negedge RESETNeg)
    begin : RST_falling_edge
        #49999 RST = 1'b0;
    end

    always @(posedge RESETNeg)
    begin
        disable RST_falling_edge;
        #1 RST = 1'b1;
    end

    initial
    begin
        SYN = 1'b0;
        SDR = 1'b1;
        DDR = 1'b0;

        READ = 1'b1;
        WRITE = 1'b1;
        BURST = 1'b1;
        ReadINIT = 1'b1;

        RST = 1'b0;
        reseted = 1'b0;

        ULBYPASS = 1'b0;
        ESP_ACT = 1'b0;
        PSP_ACT = 1'b0;
        LOCK_ACT = 1'b0;
        PASS_ACT = 1'b0;
        WRBUFF_ACT  = 1'b0;
        SecSi = 1'b0;

        PDONE = 1'b1;
        PSTART = 1'b0;
        PRES = 1'b0;
        PSUSP = 1'b0;
        PERR = 1'b0;

        EDONE = 1'b1;
        ESTART = 1'b0;
        ESUSP = 1'b0;
        ERES = 1'b0;
        EERR = 1'b0;

        ERS_QUEUE = 0;
        ERS_QUEUE_B = 0;

        OENeg_event = 0;
        CENeg_event = 0;
        ADDR_event  = 0;
        AddrTime    = 0;

        READY_in = 1'b0;
        READY_out = 1'b0;

        next_state = RESET;
        current_state = RESET;
        RD_MODE = NOSYNC;

        for(i=0;i<=SecNum;i=i+1)
            if( LOCK_REG[4])
               DYB[i] = 1'b1;
            else
               DYB[i] = 1'b0;
        ConfReg0 = 16'b1011111111001000;
        ConfReg1 = 16'b1111111111101111;
        for(i=0;i<=3;i=i+1)
            Password[i] = MaxData;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Device internal operation control
    ///////////////////////////////////////////////////////////////////////////
     always @(posedge START_in)
    begin:TSTARTr
        #(tdevice_START_ts) START_out = START_in;
    end
    always @(negedge START_in)
    begin:TSTARTf
        #1 START_out = START_in;
    end
    // Protection Bit Program
    always @(posedge PPBP_in)
    begin : ProtProgTime
        #(tdevice_PPBP_ts) PPBP_out = 1'b1;
    end
    always @(negedge PPBP_in)
    begin
        disable ProtProgTime;
        PPBP_out = 1'b0;
    end
    // Protection Bit Erase
    always @(posedge PPBE_in)
    begin : ProtEraseTime
        #(tdevice_PPBE_ts) PPBE_out = 1'b1;
    end
    always @(negedge PPBE_in)
    begin
        disable ProtEraseTime;
        PPBE_out = 1'b0;
    end
    // Sector erase timeout
    always @(posedge SET_in)
    begin : SectorEraseTimeout
        #(tdevice_SET_ts-3) SET_out = 1'b1;
    end
    always @(negedge SET_in)
    begin
        disable SectorEraseTimeout;
        SET_out = 1'b0;
    end
    // Device ready after hardware reset
    always @(posedge READY_in)
    begin : ReadyTime
        #(tdevice_READY_ts) READY_out = 1'b1;
    end
    always @(negedge READY_in)
    begin
        disable ReadyTime;
        READY_out = 1'b0;
    end
    // Password Unlock
    always @(posedge PUT_in)
    begin : UnlockTime
        #(tdevice_PUT_ts) PUT_out = 1'b1;
    end
    always @(negedge PUT_in)
    begin
        disable UnlockTime;
        PUT_out = 1'b0;
    end
    //Initial Access
    always @(posedge IACC_in)
    begin : AccessTime
        if ( ZHOLD )
            #(IACCZHDQ_01-1) IACC_out = 1'b1;
        else
            #(IACCLDQ_01-1) IACC_out = 1'b1;
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

    //////////////////////////////////////////////////////////////////////////
    // Clock active edge --> CLKMerge rising edge, needed for burst sequences
    //////////////////////////////////////////////////////////////////////////
    always @(CLK)
    begin
        if (CLK)
        begin
            CLKMerge = 1'b1;
            #1 CLKMerge = 1'b0;
        end
        if (~CLK)
            if (ConfReg0[5])
            begin
                CLKMerge = 1'b1;
                #1 CLKMerge = 1'b0;
            end
    end

    ////////////////////////////////////////////////////////////////////////////
    // sequential process for reset control and FSM state transition
    ////////////////////////////////////////////////////////////////////////////
    always @(negedge RESETNeg or negedge RST)
    begin
        if (PoweredUp)
        begin
            E   = 1'b0;
            R = 1'b1;
            READY_in  = 1'b1;
        end
        else
        begin
            current_state = RESET;
            reseted = 1'b0;
            R = 1'b0;
            E = 1'b0;
        end
    end

    always @(posedge RESETNeg)
    begin
        if (PoweredUp)
        begin
            if ( RST === 1'b1 )
            begin
                READY_in  = 1'b0;
                R = 1'b0;
                E = 1'b1;
            end
        end
        else
        begin
            current_state = RESET;
            reseted = 1'b0;
            R = 1'b0;
            E = 1'b0;
        end
    end

    always @(next_state, R, RST, READY_out, PoweredUp)
    begin
        if (PoweredUp)
        begin
            if ( RESETNeg === 1'b1 && (~R || (R && READY_out)))
            begin
                current_state = next_state;
                reseted = 1'b1;
                READY_in = 1'b0;
                R = 1'b0;
                E = 1'b0;
            end
            else if ( RESETNeg == 1'b0 && RST == 1'b1 )
            begin
                current_state = next_state;
                reseted       = 1'b1;
            end
            else if ((~R && ~RESETNeg && ~RST )              ||
                    ( R && ~RESETNeg && ~RST && ~READY_out)  ||
                    ( R && RESETNeg  && ~RST && ~READY_out))
            begin
                current_state = RESET; //reset
                reseted = 1'b0;
            end
        end
        else
        begin
            current_state = RESET;
            reseted = 1'b0;
            R = 1'b0;
            E = 1'b0;
        end
    end

    ////////////////////////////////////////////////////////////////////////////
    //   Glitch Protection: Inertial Delay does not propagate pulses <2ns
    ////////////////////////////////////////////////////////////////////////////
    always @(negedge WENeg_ipd)
    begin: gWE_n_f
        #2000 gWE_n = WENeg_ipd;
    end
    always @(posedge WENeg_ipd)
    begin
        disable gWE_n_f;
        gWE_n = WENeg_ipd;
    end

    always @(negedge CENeg_ipd)
    begin: gCE_n_f
        #2000 gCE_n = CENeg_ipd;
    end
    always @(posedge CENeg_ipd)
    begin
        disable gCE_n_f;
        gCE_n = CENeg_ipd;
    end

    always @(negedge OENeg_ipd)
    begin: gOE_n_f
        #2000 gOE_n = OENeg_ipd;
    end
    always @(posedge OENeg_ipd)
    begin
        disable gOE_n_f;
        gOE_n = OENeg_ipd;
    end

    always @(negedge AVDNeg_ipd)
    begin: gAVD_n_f
        #2000 gAVD_n = AVDNeg_ipd;
    end
    always @(posedge AVDNeg_ipd)
    begin
        disable gAVD_n_f;
        gAVD_n = AVDNeg_ipd;
    end

//    //////////////////////////////////////////////////////////////////////////
//    //Address/Data Latch
//    //////////////////////////////////////////////////////////////////////////
    always @(posedge AVDNeg)
    begin
        if ( ~CENeg && WENeg
        && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
            AddressLatched = A;
        end
        // Synchronous AVD# rising edge address latch
        if ( WENeg && ~CENeg && ~LATCHED &&
        reseted==1'b1 && ConfReg0[15] == 1'b0 && ~SYNC_DIS)
        begin
           READCYCLE = 1'b1;
           LATCHED = 1'b1;
           AVDLATCHED = 1'b1;
           AddressLatched = A;
           SecAddr = ReturnSectorID(AddressLatched);
           BankID = ReturnBank(AddressLatched);
           Addr =  AddressLatched ;
           BuffPageAddr = ReturnBuffPage(AddressLatched);
           AddrPass  = AddressLatched % 4;
           if (~ConfReg0[5])
               BurstDelay = 1;
           else
               BurstDelay = 2;
           IACC_in = 1'b0;
           if ( ~OENeg )
           begin
               CurrentReadPage = AddressLatched / 8;
               SubsequentPageAccess = (PreviousReadPage == CurrentReadPage);
               InitialPageAccess = ~SubsequentPageAccess;
               READ = 1'b0;
               #1 READ <= 1'b1;
           end
       end
    end

    always @(negedge AVDNeg)
    begin
        LATCHED = 1'b0;
        AVDLATCHED = 1'b0;
        READCYCLE = 1'b0;
        WRITECYCLE = 1'b0;
        IN_W_ELAPSED = 1'b0;
        if ( WENeg && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
            AddressLatched = A;
            // tACC count
            ADDR_event = $time;
        end
    end

    always @(posedge CLK)
    begin
        //Initiate READ (Burst mode)
       if ( READCYCLE &&
       reseted==1'b1 && ConfReg0[15] == 1'b0 && ~SYNC_DIS)
       begin
           if (AVDLATCHED)
           begin
                // tACC count
                ADDR_event = $time;
           end
           READCYCLE = 1'b0;
           BURST = 1'b0;
           BURST <= #2 1'b1;
           IACC_in <= #1 1'b1;
       end
       // Synchronous CLK active edge address latch
       if ( WENeg && ~CENeg && ~AVDNeg && ~LATCHED &&
       reseted==1'b1 && ConfReg0[15] == 1'b0 && ~SYNC_DIS )
       begin
           READCYCLE = 1'b1;
           LATCHED = 1'b1;
           AddressLatched = A;
           SecAddr = ReturnSectorID(AddressLatched);
           BankID = ReturnBank(AddressLatched);
           Addr =  AddressLatched;
           BuffPageAddr = ReturnBuffPage(AddressLatched);
           AddrPass  = AddressLatched % 4;
           BurstDelay =0;
           ADDR_event = $time;
           IACC_in = 1'b0;
           IACC_in <= #1 1'b1;
           if ( ~OENeg )
           begin
               CurrentReadPage = AddressLatched / 8;
               SubsequentPageAccess = (PreviousReadPage == CurrentReadPage);
               InitialPageAccess = ~SubsequentPageAccess;
               READ = 1'b0;
               #1 READ <= 1'b1;
           end
       end
    end

    always @(A)
    begin
        if ( ~AVDNeg && WENeg
        && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
            // tACC count
            ADDR_event = $time;
            AddressLatched = A;
        end
        if ( WENeg && ~CENeg && ~OENeg && ~AVDNeg
        && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched ;
            BuffPageAddr = ReturnBuffPage(AddressLatched);
            AddrPass  = AddressLatched % 4;
            CurrentReadPage = AddressLatched / 8;
            SubsequentPageAccess = (PreviousReadPage == CurrentReadPage);
            InitialPageAccess = ~SubsequentPageAccess;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge OENeg)
    begin
        if ( WENeg && ~CENeg && reseted==1'b1 )
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched;
            BuffPageAddr = ReturnBuffPage(AddressLatched);
            AddrPass  = AddressLatched % 4;
            CurrentReadPage = AddressLatched / 8;
            SubsequentPageAccess = (PreviousReadPage == CurrentReadPage);
            InitialPageAccess = ~SubsequentPageAccess;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(negedge CENeg)
    begin
        if ( WENeg && ~CENeg && ~OENeg
        && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
        // Initiate READ
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            Addr =  AddressLatched;
            BuffPageAddr = ReturnBuffPage(AddressLatched);
            AddrPass  = AddressLatched % 4;
            CurrentReadPage = AddressLatched / 8;
            SubsequentPageAccess = (PreviousReadPage == CurrentReadPage);
            InitialPageAccess = ~SubsequentPageAccess;
            READ = 1'b0;
            #1 READ <= 1'b1;
        end
    end

    always @(posedge gWE_n or posedge gCE_n)
    begin
        if ( RESETNeg != 1'b0
        && ((gWE_n && ~gCE_n) || (gCE_n && ~gWE_n))&& OENeg
        && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
        // WRITE operation
            SecAddr = ReturnSectorID(WrAddressLatched);
            BankID = ReturnBank(WrAddressLatched);
            Addr =  WrAddressLatched;
            BuffPageAddr = ReturnBuffPage(WrAddressLatched);
            AddrPass  = WrAddressLatched % 4;
            D_tmp = DIn[15:0];
            WRITE = 1'b0;
            #1 WRITE <= 1'b1;
        end
        // Synchronous WRITE operation data latch
        if ((gWE_n && ~gCE_n)
        && WRITECYCLE && gOE_n && RESETNeg != 1'b0 &&
        reseted==1'b1 && ConfReg0[15] == 1'b0 && ~SYNC_DIS)
        begin
             WRITECYCLE = 1'b0;
             SecAddr = ReturnSectorID(AddressLatched);
             BankID = ReturnBank(AddressLatched);
             BuffPageAddr = ReturnBuffPage(AddressLatched);
             AddrPass  = AddressLatched % 4;
             Addr =  AddressLatched;
             D_tmp = DIn[15:0];
             WRITE = 1'b0;
             #1 WRITE <= 1'b1;
        end
    end

    always @(negedge gWE_n or negedge gCE_n)
    begin
        if ( RESETNeg != 1'b0 &&
            ~gCE_n && ~gWE_n && gOE_n && ~gAVD_n
            && reseted==1'b1 && (ConfReg0[15] == 1'b1 || SYNC_DIS))
        begin
            WrAddressLatched = A;
        end
        if ( ~gCE_n && ~gWE_n && gOE_n &&
        reseted==1'b1 && ConfReg0[15] == 1'b0 && ~SYNC_DIS)
        begin
            READCYCLE = 1'b0;
            WRITECYCLE = 1'b1;
        end
        // Asynchronous WRITE cycle Address Latch
        // Supported in synchronous mode
        if ( ~gCE_n && ~gWE_n && gOE_n && ~gAVD_n && ~LATCHED &&
        reseted==1'b1 && ConfReg0[15] == 1'b0 && ~SYNC_DIS)
        begin
            READCYCLE = 1'b0;
            WRITECYCLE = 1'b1;
            LATCHED = 1'b1;
            AddressLatched = A;
            SecAddr = ReturnSectorID(AddressLatched);
            BankID = ReturnBank(AddressLatched);
            BuffPageAddr = ReturnBuffPage(AddressLatched);
            AddrPass  = AddressLatched % 4;
            Addr =  AddressLatched;
        end
    end

    // Terminate Page Access
    always @(posedge CENeg)
    begin
        PreviousReadPage = -1;
    end

    //////////////////////////////////////////////////////////////////////////
    // Page Access Control Process
    //////////////////////////////////////////////////////////////////////////
    always @(posedge READ)
    begin
        PreviousReadPage = CurrentReadPage;
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program / Write Buffer Operation
//    // start/ suspend/ resume
//    //////////////////////////////////////////////////////////////////////////

 event pdone_event;
 time elapsed_p;
 time duration_p;
 time start_p;
 time pwo;
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
            start_p = $time;
            elapsed_p = 0;
            i = WrBuffSec;
            if ((((~PPB[i] || ~DYB[i] || (~WP_l && Boot_Sec[i])
                  || ~ACC) || (ESP_ACT && ERS_QUEUE[i]))
                  && ~PASS_ACT && ~LOCK_ACT && (~SecSi || i>0)) ||
               (SecSi && (WrBuffAddr[0] < 16'h80 || ~LOCK_REG[0]||
                WrBuffAddr[0] > 16'hFF) && i==0) ||
               ( PASS_ACT && ~(LOCK_REG[2])))
            begin
                PERR = 1'b1;
                PERR <= #1000000 1'b0;
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
            elapsed_p = $time - start_p;
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
            seo16 = tdevice_SEO16_ts;
            seo64 = tdevice_SEO64_ts;
            cnt_erase = 0;
            duration_e = 0;
            start_e = $time;
            for (i=0;i<=SecNum;i=i+1)
                if ( ERS_QUEUE[i] && DYB[i] && PPB[i] &&
                   ( WP_l || (~Boot_Sec[i])) && ACC)
                begin
                    if( i <= 3 || i >= SecNum -3 )
                        duration_e=duration_e + seo16;
                    else
                        duration_e=duration_e + seo64;
                end

            if (duration_e>0)
            begin
                elapsed_e = 0;
                EDONE = 1'b0;
                -> edone_event;
            end
            else
            begin
                EERR = 1'b1;
                EERR <= #100000000 1'b0;
            end
        end
    end

    always @(edone_event)
    begin : edone_process
        #(duration_e) EDONE = 1'b1;
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
    always @(negedge WRITE or negedge reseted)
    begin: StateGen0
        if (~WRITE)
        begin
            AddrCom = Addr % 13'h1000;
            Data = D_tmp;
            DataLo = D_tmp % 9'h100;
            PATTERN_1 = (AddrCom == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (AddrCom == 12'h2AA && DataLo == 8'h55);
        end
        if (reseted!=1'b1)
            next_state = current_state;
        else
            if (~WRITE)
                case (current_state)
                RESET :
                begin
                    if(PATTERN_1)
                        next_state = Z001;
                    else if ((DataLo==16'hA0) && SecSi)
                        next_state = SECSI_A0SEEN;
                    else if((AddrCom % 12'h100== 12'h55
                            && (DataLo==16'h98))&& ~SecSi)
                        next_state = CFI;
                end

                Z001 :
                begin
                    if(PATTERN_2)
                        next_state = PREL_SETBWB;
                    else
                        next_state = RESET;
                end

                CFI :
                begin
                    if (DataLo == 8'hF0)
                        next_state = CFIExit;
                end

                PREL_SETBWB :
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
                    else if ((AddrCom==12'h555) && DataLo==8'hA0)
                        next_state = A0SEEN;
                    else if (DataLo==8'h25 && (~SecSi || SecAddr>0))
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

                PREL_ULBYPASS :
                begin
                    if (DataLo == 8'hA0)
                        next_state = A0SEEN;
                    else if  (DataLo == 8'h25)
                        next_state = PREL_WR2BUFF;
                    else if (DataLo == 8'h98)
                        next_state = CFI;
                    else if (DataLo == 8'h80)
                        next_state = C8_PREL;
                    else if (DataLo == 8'h90)
                        next_state = PREL_ULBYPASS_RESET;
                end

                PREL_ULBYPASS_RESET :
                begin
                    if  (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_ULBYPASS;
                end

                A0SEEN :
                begin
                    if(~SecSi || SecAddr>0)
                        next_state = PGMS;
                    else
                        if( ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                end

                SECSI_A0SEEN :
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
                    if ((DataLo==8'h10) &&(((AddrCom==12'h555) &&  ~SecSi)
                        || ULBYPASS))
                        next_state = ERS;
                    else if ((DataLo==8'h30) && (SecAddr !==0 || ~SecSi))
                        next_state = SERS;
                    else if (ULBYPASS)
                        next_state = PREL_ULBYPASS;
                    else
                        next_state = RESET;
                end

                SERS :
                begin
                    if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankID])
                        next_state = ESP;
                    else if ((DataLo == 8'h30) && (SecAddr !==0 || ~SecSi))
                        next_state = SERS;
                    else
                        if(~ULBYPASS)
                            next_state = RESET;
                        else
                            next_state = PREL_ULBYPASS;
                end

                SERS_EXEC :
                begin
                    if (~EERR)
                    begin
                        if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankID])
                            next_state = ESPS;
                    end
                end

                ESP :
                begin
                    if ((DataLo == 8'h30) && ERS_QUEUE_B[BankID])
                        next_state = SERS_EXEC;
                    else if (PATTERN_1)
                        next_state = ESP_Z001;
                    else if ((DataLo==16'hA0) && SecSi)
                        next_state = SECSI_A0SEEN;
                    else if ((AddrCom % 12'h100 == 8'h55) &&
                            (DataLo== 8'h98) && ~SecSi)
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
                    if  (DataLo == 8'h25 && (~SecSi || SecAddr>0))
                        next_state = PREL_WR2BUFF;
                    else if ( AddrCom==12'h555 && DataLo==8'hA0 )
                        next_state = A0SEEN;
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

                PREL_WR2BUFF:
                begin
                    if ((SecAddr == WrBuffSec) && (DataLo < 32))
                        next_state = WR2BUFF_0;
                    else
                        next_state = WR2BUFF_AB;
                end

                WR2BUFF_0 :
                begin
                    if ((BuffPageAddr == WrBuffPage) && (WrCnt >0))
                        next_state = WR2BUFF_CNT;
                    else if ((BuffPageAddr == WrBuffPage) && (WrCnt ==0))
                        next_state = PREL_PRFLASH;
                    else
                        next_state = WR2BUFF_AB;
                end

                WR2BUFF_CNT :
                begin
                    if ((BuffPageAddr == WrBuffPage) && (WrCnt >0))
                        next_state = WR2BUFF_CNT;
                    else if ((BuffPageAddr == WrBuffPage) && (WrCnt == 0))
                        next_state = PREL_PRFLASH;
                    else
                        next_state = WR2BUFF_AB;
                end

                PREL_PRFLASH  :
                begin
                    if ((SecAddr==WrBuffSec) && (DataLo==8'h29))
                        next_state = PGMS;
                    else
                        next_state = WR2BUFF_AB;
                end

                PGMS :
                begin
                    if (~PERR)
                    begin
                        if ((DataLo == 16'hB0) && ~LOCK_ACT && ~PASS_ACT)
                            next_state = PGSPS;
                    end
                end

                PGS :
                begin
                    if (DataLo == 16'h30)
                        next_state = PGMS;
                    else if (PATTERN_1)
                        next_state = PGS_Z001;
                    else if ((AddrCom % 12'h100== 8'h55) && (DataLo== 8'h98)
                              && ~SecSi)
                        next_state = CFI;
                end

                PGS_Z001 :
                begin
                    if (PATTERN_2)
                        next_state = PGS_PREL;
                    else
                        next_state = PGS;
                end

                PGS_PREL :
                begin
                    if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi)
                        next_state = PREL_DYB;
                    else if ((AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                        next_state = PREL_PPB;
                    else if ((AddrCom==12'h555) && (DataLo== 8'h90) && ~SecSi)
                        next_state = AS;
                    else if ((AddrCom==12'h555) && (DataLo==8'h90) && SecSi
                              && (WrBuffSec!==0))
                        next_state = SECSI_EX;
                    else if ((AddrCom==12'h555) && (DataLo == 8'h88)
                            && (WrBuffSec!==0) && (~ESP_ACT || ~ERS_QUEUE[0]))
                        next_state = PGS; //SecSi Entry
                    else
                        next_state = PGS;
                end

                WR2BUFF_AB :
                begin
                    if (PATTERN_1)
                        next_state = WR2BUFF_AB_Z001;
                end

                WR2BUFF_AB_Z001 :
                begin
                    if (PATTERN_2)
                        next_state = WR2BUFF_AB_PREL;
                    else
                        next_state = WR2BUFF_AB;
                end

                WR2BUFF_AB_PREL :
                begin
                    if ((AddrCom == 12'h555) && (DataLo == 8'hF0))
                    begin
                        if(ESP_ACT)
                            next_state = ESP;
                        else if (ULBYPASS)
                            next_state = PREL_ULBYPASS;
                        else
                            next_state = RESET;
                    end
                    else
                        next_state = WR2BUFF_AB;
                end

                SET_CONF :
                begin
                    if (AddrCom % 12'h100 == 8'h00)
                        next_state = SET_CONF1; // set conf reg
                    else
                        next_state = RESET;
                end

                SET_CONF1 :
                begin
                    if (AddrCom % 12'h100 == 8'h01)
                        next_state = SET_CONF_EXIT; // set conf reg
                    else
                        next_state = RESET;
                end

                SET_CONF_EXIT :
                begin
                    if (DataLo == 8'hF0)
                        next_state = RESET;
                end

                RD_CONF :
                begin
                    if (DataLo == 8'hF0)
                        next_state = RESET;
                end

                PREL_PASS :
                begin
                    if (DataLo == 8'hA0)
                        next_state = PASS_A0SEEN;
                    else if (DataLo == 8'h90)
                        next_state = PASS_EX;
                    else if ((AddrCom % 9'h100 == 8'h00) && (DataLo== 8'h25))
                        next_state = PASS_UN_Z001;
                end

                PASS_A0SEEN :
                begin
                    next_state = PGMS;
                end

                PASS_EX :
                begin
                    if (DataLo == 8'h00)
                        next_state = RESET; // exit password
                    else
                        next_state = PREL_PASS;
                end

                PASS_UN_Z001 :
                begin
                    if ((DataLo == 8'h03) && (AddrCom % 12'h100 == 8'h00))
                        next_state = PASS_UN_PREL;
                    else
                        next_state = PREL_PASS;
                end

                PASS_UN_PREL :
                begin
                    next_state = PASS_UN1;
                end

                PASS_UN1 :
                begin
                    next_state = PASS_UN2;
                end

                PASS_UN2 :
                begin
                    next_state = PASS_UN3;
                end

                PASS_UN3 :
                begin
                    next_state = PASS_UN4;
                end

                PASS_UN4 :
                begin
                    if ((AddrCom % 12'h100  == 8'h00) && (DataLo == 8'h29))
                        next_state = PASS_UN_W;
                    else
                        next_state = PREL_PASS;
                end

                PREL_LR :
                begin
                    if (DataLo == 8'hA0)
                        next_state = LR_A0SEEN;
                    else if (DataLo == 8'h90)
                        next_state = LR_PREL_EX;
                end

                LR_A0SEEN :
                begin
                    if(AddrCom == 12'h00)
                        next_state = PGMS;   // WRITE to LR
                    else
                        next_state = PREL_LR;
                end

                LR_PREL_EX :
                begin
                    if (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_LR;
                end

                PREL_PPB :
                begin
                    if (DataLo == 8'hA0)
                        next_state = PPB_PREL_PR;
                    else if (DataLo == 8'h80)
                        next_state = PPB_PREL_ER;
                    else if (DataLo == 8'h90)
                        next_state = PPB_PREL_EX;
                end

                PPB_PREL_PR :
                begin
                    if ((DataLo == 8'h00) && (BankID == BankPPBAddr))
                        next_state = PPB_PGMS;
                    else
                        next_state = PREL_PPB;
                end

                PPB_PREL_ER  :
                begin
                    if (DataLo == 8'h30)
                        next_state = PPB_ERS;
                    else
                        next_state = PREL_PPB;
                end

                PPB_PREL_EX :
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
                        next_state = PREL_PPB;
                end

                PREL_PPBLCK :
                begin
                    if (DataLo == 8'hA0)
                        next_state = PPBLCK_PREL_ST;
                    else if (DataLo == 8'h90)
                        next_state = PPBLCK_PREL_EX;
                end

                PPBLCK_PREL_ST :
                begin
                    if (DataLo == 8'h00)
                        next_state = PREL_PPBLCK;   // set PPB Lock Bit
                    else
                        next_state = PREL_PPBLCK;
                end

                PPBLCK_PREL_EX :
                begin
                    if (DataLo == 8'h00)
                        next_state = RESET;
                    else
                        next_state = PREL_PPBLCK;
                end

                PREL_DYB :
                begin
                    if (DataLo == 8'hA0)
                        next_state = DYB_PREL_ST;
                    else if (DataLo == 8'h90)
                        next_state = DYB_PREL_EX;
                end

                DYB_PREL_ST :
                begin
                    next_state = PREL_DYB;   // set/reset DYB
                end

                DYB_PREL_EX :
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

                AS :
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
                    else if (DataLo == 8'h98 && AddrCom % 12'h100== 8'h55)
                        next_state = CFI;
                end

                SECSI_EX :
                begin
                    // SecSi Exit
                    if (PSP_ACT)
                        next_state = PGS;
                    else if (ESP_ACT)
                        next_state = ESP;
                    else
                        next_state = RESET;
                end

                endcase
    end
    //PPB_PGMS state, PPBP_out
    always @(posedge PPBP_out)
    begin: StateGen1
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PPB_PGMS)
                next_state = PREL_PPB;
        end
    end

    //PPB_ERS state, PPBE_out
    always @(posedge PPBE_out)
    begin: StateGen2
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state == PPB_ERS)
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
            begin
                if (~ULBYPASS)
                    next_state = RESET;
                else
                    next_state = PREL_ULBYPASS;
            end
        end
    end

    // SERS state
    always @(SET_out)
    begin: StateGen5
        if (reseted!=1'b1)
            next_state = current_state;
        else
        begin
            if (current_state==SERS)
                if (SET_out == 1'b1)
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
                next_state = PGS;
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge READ)
    begin
          ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    //SYNCHRONOUS MODE DISABLE DETECTION
    always @(current_state or reseted)
    begin: StateGenSyncDis
        SYNC_DIS = 1'b0;
        if (reseted == 1'b1)
        begin
            case (current_state)
                PREL_PPB :
                begin
                    SYNC_DIS = 1'b1;
                end

                PREL_DYB :
                begin
                    SYNC_DIS = 1'b1;
                end
            endcase
        end
    end

    //BURST READ DETECTION
    always @(negedge BURST or reseted)
    begin: StateGenB
        BURST_TR = 1'b0;
        SYNCREAD = 1'b0;
        if (reseted == 1'b1)
        begin
            if (~BURST)
            begin
                case (current_state)
                RESET :
                begin
                    BURST_TR = 1'b1;
                end

                CFI :
                begin
                    if( BankID == BankCFIAddr)
                        SYNCREAD = 1'b1;
                    else if( CFIExit == AS && BankID == BankASAddr)
                        SYNCREAD = 1'b1;
                    else if( ESP_ACT && ERS_QUEUE[SecAddr])
                        SYNCREAD = 1'b1;
                    else if( ~PSP_ACT || SecAddr != WrBuffSec)
                        BURST_TR = 1'b1;
                end

                PREL_ULBYPASS :
                begin
                    BURST_TR = 1'b1;
                end

                ERS :
                begin
                    SYNCREAD = 1'b1;
                end

                SERS :
                begin
                    if (ERS_QUEUE_B[BankID])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                ESPS :
                begin
                    if (ERS_QUEUE_B[BankID])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                SERS_EXEC :
                begin
                    if (ERS_QUEUE_B[BankID])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                ESP :
                begin
                    if (ERS_QUEUE[SecAddr])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                PGMS :
                begin
                    if ( BankID == PrgBank )
                        SYNCREAD = 1'b1;
                    else if (ESP_ACT && ERS_QUEUE[SecAddr])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                PGSPS :
                begin
                    if (SecAddr == WrBuffSec)
                        SYNCREAD = 1'b1;
                    else if(ESP_ACT && ERS_QUEUE[SecAddr])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                PGS :
                begin
                    if (SecAddr == WrBuffSec)
                        SYNCREAD = 1'b1;
                    else if ( ESP_ACT && ERS_QUEUE[SecAddr] )
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                WR2BUFF_AB :
                begin
                    if( BankID == PrgBank)
                        SYNCREAD = 1'b1;
                    else if( ESP_ACT && ERS_QUEUE[SecAddr])
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                RD_CONF :
                begin
                    SYNCREAD = 1'b1;
                end

                PREL_PASS :
                begin
                    if( BankID == 0)
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                PREL_LR :
                begin
                    if( BankID == 0)
                        SYNCREAD = 1'b1;
                    else
                        BURST_TR = 1'b1;
                end

                PREL_PPBLCK :
                begin
                    SYNCREAD = 1'b1;
                end

                AS :
                begin
                    if( BankID == BankASAddr)
                        SYNCREAD = 1'b1;
                    else if( ESP_ACT && ERS_QUEUE[SecAddr])
                        SYNCREAD = 1'b1;
                    else if( ~PSP_ACT || SecAddr != WrBuffSec)
                        BURST_TR = 1'b1;
                end
                endcase
                if ( BURST_TR )
                begin
                    if (!( SecSi && SecAddr==0 && Addr> 8'hFF ))
                    begin
                        if( ConfReg0[2:0] == 3'b0 )
                            RD_MODE = CONTINUOUS;
                        else if (~ConfReg0[3])
                            RD_MODE = LINEAR_NO_WRAP;
                        else
                            RD_MODE = LINEAR;
                        ReadINIT = 1'b0;
                        #2 ReadINIT = 1'b1;
                    end
                end
                else if ( SYNCREAD )
                begin
                    RD_MODE = SYNCR;
                    ReadINIT = 1'b0;
                    #2 ReadINIT = 1'b1;
                end
            end
        end
    end

    //Burst HALT
    always @(negedge AVDNeg or posedge gCE_n or negedge gWE_n)
    begin
        if (RD_MODE != NOSYNC)
            RD_MODE = NOSYNC;
    end

    // Output generation
    always @( posedge oe)
    begin: Output
            case (current_state)
            RESET :
            begin
                //reading array data
                READMEM(Addr,BankID,SecAddr,SecSi);
                DOut_zd = OutputD;
            end

            CFI :
            begin
                 if( BankID == BankCFIAddr)
                    if ((Addr % (BankSize+1) >= 8'h10 &&
                        Addr % (BankSize+1) <= 8'h3C) ||
                        ( Addr % (BankSize+1) >= 8'h40 &&
                        Addr % (BankSize+1) <= 8'h67))
                        OutputD = CFIMem[Addr % (BankSize +1)];
                    else
                    begin
                        OutputD = 16'bz;
                        // error CFI Address out of range
                        $display("Invalid CFI query address");
                    end
                else
                begin
                    if(CFIExit == AS && BankID == BankASAddr)
                    begin
                        SecProt = (~PPB[SecAddr] || ~DYB[SecAddr]
                             || ( ~WPNeg && Boot_Sec[SecAddr])|| ~ACC);
                        case (Addr % 12'h100)
                                0 : OutputD= 16'h0001;
                                1 : OutputD= 16'h007E;
                                3 :
                                begin
                                    OutputD = 0;
                                    OutputD[7]=1'b1;
                                    OutputD[6]= ~LOCK_REG[0];
                                    OutputD[5]=1'b0;
                                    OutputD[4 : 3]=0;
                                end
                                8'h0E :OutputD= 16'h003D;
                                8'h0F :OutputD= 16'h0000;
                                2 :
                                begin
                                    OutputD = 0;
                                    OutputD[0] = SecProt;
                                end
                                default :
                                begin
                                    OutputD=16'bz;
                                    $display ("Invalid AS address");
                                end
                        endcase
                    end
                    else if( ESP_ACT && ERS_QUEUE[SecAddr])
                    begin
                        ////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////
                        // Status[6] No toggle
                        Status[5] = 1'b0;
                        Status[2] = ! Status[2]; // toggle
                        OutputD[7:0]= Status;
                        OutputD[15:8]=0;
                        OutputD[7] = 1'b1;
                    end
                    else if(~PSP_ACT || SecAddr != WrBuffSec)
                        READMEM(Addr,BankID,SecAddr,SecSi);
                    else
                        OutputD = 16'bz;
                end
                DOut_zd = OutputD;
                SyncData = OutputD;
            end

            PREL_ULBYPASS :
            begin
                  READMEM(Addr,BankID,SecAddr,SecSi);
                  DOut_zd = OutputD;
                  SyncData = OutputD;
            end

            ERS :
            begin
                // reading Status enabled
                //////////////////////////////////////////////////////////-
                // READ Status / embeded erase algorithm - Chip Erase
                //////////////////////////////////////////////////////////-
                Status[7] = 1'b0;
                Status[6] = ~ Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                Status[2] = ~ Status[2]; //toggle
                OutputD = 0;
                OutputD[7:0]= Status;
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            SERS :
            begin
                Status[3] = 1'b0;
                Status[6] = ~ Status[6]; //toggle
                if ( ERS_QUEUE[SecAddr] )
                    Status[7] = 1'b0;
                else
                    Status[7] = 1'b1;
                if ( ERS_QUEUE_B[BankID] )
                begin
                    OutputD = 0;
                    OutputD[7:0]= Status;
                end
                else
                begin
                    READMEM(Addr,BankID,SecAddr,SecSi);
                end
                DOut_zd = OutputD;
                SyncData = OutputD;
            end

            ESPS :
            begin
                Status[6] = ~ Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                if ( ERS_QUEUE_B[BankID])
                begin
                    ////////////////////////////////////////////////////////
                    //READ Status / erase suspend timeout - stil erasing
                    ////////////////////////////////////////////////////////
                    if ( ERS_QUEUE[SecAddr])
                    begin
                        Status[7] = 1'b0;
                        Status[2] = ~ Status[2]; //toggle
                    end
                    else
                        Status[7] = 1'b1;
                    OutputD = 0;
                    OutputD[7:0]= Status;
                end
                else
                    READMEM(Addr,BankID,SecAddr,SecSi);
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            SERS_EXEC :
            begin
                Status[6] = ~ Status[6]; //toggle
                Status[5] = 1'b0;
                Status[3] = 1'b1;
                // reading data && Status enabled
                if ( ERS_QUEUE_B[BankID])
                begin
                    ////////////////////////////////////////////////////
                    //READ Status Erase Busy
                    ////////////////////////////////////////////////////
                    if (ERS_QUEUE[SecAddr])
                    begin
                        Status[7] = 1'b0;
                        Status[2] = ~ Status[2]; //toggle
                    end
                    else
                        Status[7] = 1'b1;
                    OutputD = 0;
                    OutputD[7:0]= Status;
                end
                else
                    READMEM(Addr,BankID,SecAddr,SecSi);
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            ESP :
            begin
                ////////////////////////////////////////////////////////////
                //READ
                ////////////////////////////////////////////////////////////
                if ( ~(ERS_QUEUE[SecAddr]) )
                begin
                    READMEM(Addr,BankID,SecAddr,SecSi);
                end
                else
                begin
                    ////////////////////////////////////////////////////////
                    //READ Status
                    ////////////////////////////////////////////////////////
                    Status[7] = 1'b1;
                    // Status[6] No toggle
                    Status[5] = 1'b0;
                    Status[2] = ~ Status[2]; // toggle
                    OutputD = 0;
                    OutputD[7:0]= Status;
                end
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            PGSPS :
            begin
                // reading data && Status enabled
                Status[6] = ~ Status[6]; //toggle
                Status[5] = 1'b0;
                //Status[2] no toggle
                Status[1] = 1'b0;
                if ( BankID == PrgBank )
                begin
                    ////////////////////////////////////////////////////////
                    //READ Status
                    ////////////////////////////////////////////////////////
                    OutputD = 0;
                    OutputD[7:0]= Status;
                    if ( Addr == WrBuffAddr[0] || LOCK_ACT)
                        OutputD[7] = Status[7];
                    else
                        OutputD[7] = ~ Status[7];
                end
                else if ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr]) )
                        READMEM(Addr,BankID,SecAddr,SecSi);
                else
                begin
                    ////////////////////////////////////////////////////////
                    //erase suspend active
                    ////////////////////////////////////////////////////////
                    Status[2] = ~ Status[2]; // toggle
                    OutputD = 0;
                    OutputD[7:0]= Status;
                    OutputD[7]= 1'b1;
                end
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            PGMS:
            begin
                Status[6] = ~ Status[6]; //toggle
                Status[5] = 1'b0;
                //Status[2] no toggle
                Status[1] = 1'b0;
                if ( BankID == PrgBank )
                begin
                    ////////////////////////////////////////////////////////
                    //READ Status
                    ////////////////////////////////////////////////////////
                    OutputD = 0;
                    OutputD[7:0]= Status;
                    if ( Addr == WrBuffAddr[0] || LOCK_ACT )
                        OutputD[7] = Status[7];
                    else
                        OutputD[7] = ~ Status[7];
                end
                else if ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr]) )
                       READMEM(Addr,BankID,SecAddr,SecSi);
                else
                begin
                    ////////////////////////////////////////////////////////
                    //erase suspend active
                    ////////////////////////////////////////////////////////
                    Status[2] = ~ Status[2]; // toggle
                    OutputD = 0;
                    OutputD[7:0]= Status;
                    OutputD[7]= 1'b1;
                end
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            PGS:
            begin
                // reading data && Status enabled
                if ( SecAddr !== WrBuffSec )
                    if ( ESP_ACT && ERS_QUEUE[SecAddr] )
                    begin
                        ////////////////////////////////////////////////////
                        //READ Status
                        ////////////////////////////////////////////////////
                        // Status[6] No toggle
                        Status[5] = 1'b0;
                        Status[2] = ~ Status[2]; // toggle
                        OutputD = 0;
                        OutputD[7:0]= Status;
                        OutputD[7]= 1'b1;
                    end
                    else
                        READMEM(Addr,BankID,SecAddr,SecSi);
                else
                    OutputD = 16'bZ;
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            WR2BUFF_AB:
            begin
                Status[6] = ~ Status[6];
                Status[5] = 1'b0;
                Status[1] = 1'b1;
                if ( BankID == PrgBank  )
                begin
                    ////////////////////////////////////////////////////////
                    //READ Status
                    ////////////////////////////////////////////////////////
                    OutputD = 0;
                    OutputD[7:0]= Status;
                    if (Addr == WrBuffAddr[0])
                        OutputD[7]= Status[7];
                    else
                        OutputD[7]= ~Status[7];
                end
                else if ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr]))
                        READMEM(Addr,BankID,SecAddr,SecSi);
                else
                begin
                    ////////////////////////////////////////////////////////
                    //erase suspend active
                    ////////////////////////////////////////////////////////
                    Status[2] = ~ Status[2]; // toggle
                    OutputD = 0;
                    OutputD[7:0]= Status;
                    OutputD[7]= 1'b1;
                end
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            RD_CONF  :
            begin
                if ( Addr% 12'h100 == 8'h00)
                    OutputD = ConfReg0;
                else if ( Addr% 12'h100 == 8'h01)
                    OutputD = ConfReg1;
                else
                    OutputD = 16'bZ;
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            PREL_PASS :
            begin
                if ( BankID == 0 )
                begin
                    if ( LOCK_REG[2] )
                        if ( Password[AddrPass] != -1 )
                            OutputD = Password[AddrPass];
                        else
                            OutputD = 16'bx;
                    else
                        OutputD = MaxData;
                end
                else
                    READMEM(Addr,BankID,SecAddr,SecSi);
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            PREL_LR :
            begin
                // reading Lock Register is allowed or Data
                if ( BankID == 0 )
                begin
                    if (Addr % 12'h100==0 )
                    begin
                        DOut_zd = LOCK_REG;
                        SyncData= LOCK_REG;
                    end
                    else
                    begin
                        DOut_zd = 16'bz;
                        SyncData= 16'bz;
                    end
                end
                else
                begin
                    READMEM(Addr,BankID,SecAddr,SecSi);
                    DOut_zd = OutputD;
                end
            end

            PREL_PPB :
            begin
                // reading PPB and array data allowed
                if ( BankID == BankPPBAddr )
                begin
                    DOut_zd    = 16'b0;
                    DOut_zd[0] = PPB[SecAddr];
                end
                else
                    if ( ESP_ACT && ERS_QUEUE[SecAddr])
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        Status[7] = 1'b1;
                        // Status[6] No toggle
                        Status[5] = 1'b0;
                        Status[2] = ~ Status[2]; // toggle
                        DOut_zd[7:0] = Status;
                        DOut_zd[15:8]= 8'b0;
                        DOut_zd[7] = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                    begin
                        READMEM(Addr,BankID,SecAddr,SecSi);
                        DOut_zd <= OutputD;
                    end
                    else
                        DOut_zd = 16'bZ;
            end

            PREL_PPBLCK :
            begin
                // reading PPB Lock enabled
                OutputD = 16'b0;
                OutputD[0] = PPB_LOCK;
                DOut_zd = OutputD;
                SyncData= OutputD;
            end

            PREL_DYB :
            begin
                //reading DYB and array data enabled
                if ( BankID == BankDYBAddr )
                begin
                    DOut_zd = 16'b0;
                    DOut_zd[0] = DYB[SecAddr];
                end
                else
                    if ( ESP_ACT && ERS_QUEUE[SecAddr] )
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        // Status[6] No toggle
                        Status[5] = 1'b0;
                        Status[2] = ~ Status[2]; // toggle
                        DOut_zd[7:0] = Status;
                        DOut_zd[15:8]= 8'b0;
                        DOut_zd[7] = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                    begin
                        READMEM(Addr,BankID,SecAddr,SecSi);
                        DOut_zd <= OutputD;
                    end
                    else
                        DOut_zd = 16'bz;
            end

            AS :
            begin
                if ( BankID == BankASAddr )
                begin
                    SecProt = (~PPB[SecAddr] || ~DYB[SecAddr]
                             || ( ~WPNeg && Boot_Sec[SecAddr])|| ~ACC);
                    case ( Addr % 16'h100 )
                    8'h00 : OutputD= 16'h0001;
                    8'h01 : OutputD= 16'h007E;
                    8'h03 :
                        begin
                            OutputD= 16'h0000;
                            OutputD[7]=1'b1;
                            OutputD[6]= !LOCK_REG[0];
                        end
                    8'h0E : OutputD= 16'h003D;
                    8'h0F : OutputD= 16'h0000;
                    8'h02 :
                        begin
                            OutputD= 0;
                            OutputD[0] = SecProt;
                        end
                    default :
                        begin
                            OutputD = 16'bz;
                            $display ("Invalid AS address");
                        end
                    endcase
                end
                else
                begin
                    if ( ESP_ACT && ERS_QUEUE[SecAddr])
                    begin
                        ////////////////////////////////////////////////////
                        //erase suspend active
                        ////////////////////////////////////////////////////
                        // Status[6] No toggle
                        Status[5] = 1'b0;
                        Status[2] = ~ Status[2]; // toggle
                        OutputD[7:0]  = Status;
                        OutputD[15:8] = 8'b0;
                        OutputD[7]  = 1'b1;
                    end
                    else if ( ~PSP_ACT || SecAddr !== WrBuffSec )
                    begin
                        READMEM(Addr,BankID,SecAddr,SecSi);
                    end
                    else
                        OutputD = 16'bz;
                end
                DOut_zd = OutputD;
                SyncData = OutputD;
            end
            endcase
    end

    always @(negedge AVDNeg)
    begin:RDYDQS_0
            RDY_temp = 1'b1;
            DQS_temp = 1'b1;
    end

    // WRITE signal transitions
    always @(negedge WRITE)
    begin: Func0
        Data = D_tmp;
        DataLo = D_tmp % 12'h100;
        AddrCom = Addr % 16'h1000;
        PATTERN_1 = (AddrCom == 12'h555 && DataLo == 8'hAA);
        PATTERN_2 = (AddrCom == 12'h2AA && DataLo == 8'h55);
        if (reseted === 1'b1)
        begin
            case (current_state)
            RESET :
            begin
                ESP_ACT = 1'b0;
                PSP_ACT = 1'b0;
                ULBYPASS = 1'b0;
                SET_in = 1'b0;
                if ( AddrCom % 12'h100 == 8'h55 && DataLo == 8'h98
                         && ~SecSi)
                begin
                    BankCFIAddr = BankID;
                    CFIExit = RESET;
                end
            end

            PREL_SETBWB :
            begin
                if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi )
                begin
                    BankDYBAddr = BankID;
                end
                else if (( AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                begin
                    BankPPBAddr = BankID;
                end
                else if (( AddrCom==12'h555) &&  (DataLo==8'h40) && ~SecSi)
                    LOCK_ACT = 1'b1;
                else if ((AddrCom==12'h555) &&(DataLo==8'h20) && ~SecSi)
                    ULBYPASS = 1'b1;
                else if ((AddrCom==12'h555) &&(DataLo==8'h90) && ~SecSi)
                    BankASAddr = BankID;
                else if ((AddrCom==12'h555) && (DataLo==8'h60) && ~SecSi)
                    PASS_ACT = 1'b1;
                else if (DataLo==8'h25 && (~SecSi || SecAddr>0))
                begin
                    PrgBank = BankID;
                    WrBuffSec = SecAddr;
                end
                else if (( AddrCom==12'h555) && (DataLo==8'h88))
                    SecSi = 1'b1;    // SecSi Entry
            end

            PREL_ULBYPASS :
            begin
                if( DataLo == 8'h98)
                begin
                    BankCFIAddr = BankID;
                    CFIExit = PREL_ULBYPASS;
                end
                else if (DataLo == 8'h25)
                begin
                    PrgBank = BankID;
                    WrBuffSec = SecAddr;
                end
            end

            A0SEEN :
            begin
                if (~SecSi || SecAddr>0)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WRBUFF_ACT = 1'b0;
                    WrBuffData[0] = Data;
                    WrBuffAddr[0] = Addr;
                    WrBuffSec = SecAddr;
                    WrBuffCnt = 0;
                    PrgBank = BankID;
                    WP_l = WPNeg;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
            end

            SECSI_A0SEEN :
            begin
                if ( SecAddr == 0 )
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WRBUFF_ACT = 1'b0;
                    WrBuffData[0] = Data;
                    WrBuffAddr[0] = Addr;
                    WrBuffSec = SecAddr;
                    WrBuffCnt = 0;
                    PrgBank = BankID;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
            end

            C8_PREL :
            begin
                if (DataLo==8'h10 && ((AddrCom==12'h555 && ~SecSi)|| ULBYPASS ))
                begin
                    ESTART = 1'b1;
                    ESTART <= #1 1'b0;
                    ESUSP = 1'b0;
                    ERES = 1'b0;
                    ERS_QUEUE  = ~(0);
                    ERS_QUEUE_B  = ~(0);
                    WP_l = WPNeg;
                    Status = 8'b0;
                end
                else if ((DataLo==8'h30) && ((SecAddr!==0) || ~SecSi))
                begin
                    ERS_QUEUE = 0;
                    ERS_QUEUE_B = 0;
                    ERS_QUEUE[SecAddr] =1'b1;
                    ERS_QUEUE_B[BankID]=1'b1;
                    WP_l = WPNeg;
                    SET_in = #1 1'b0;
                    SET_in <= #2 1'b1;
                end
            end

            SERS   :
            begin
                if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankID])
                begin
                    ERES = 1'b0;                  //erasure must
                    SET_in = 1'b0;                //begin before
                    ESTART = 1'b1;                //suspending
                    ESTART <= #1 1'b0;
                    ESUSP = #1 1'b1;
                    ESUSP <= #2 1'b0;
                end
                else if ((DataLo == 8'h30) && (SecAddr!==0 || ~SecSi))
                begin
                    SET_in = #1 1'b0;
                    SET_in <= #2 1'b1;  //one more timeout
                    ERS_QUEUE[SecAddr] =1'b1;
                    ERS_QUEUE_B[BankID] =1'b1;
                    WP_l = WPNeg;
                end
                else
                begin
                    SET_in =1'b0;
                end
            end

            SERS_EXEC:
            begin
                if ((DataLo == 8'hB0) && ERS_QUEUE_B[BankID] && EERR!= 1'b1)
                begin
                    ERES = 1'b0;
                    ESUSP = 1'b1;
                    ESUSP <= #1 1'b0;
                    START_in = 1'b1;
                end
            end

            ESP    :
            begin
                if ((DataLo == 8'h30) && ERS_QUEUE_B[BankID])
                begin
                    ERES = 1'b1;
                    ERES <= #1 1'b0;
                    ESP_ACT = 1'b0;
                end
                else if ((AddrCom  % 12'h100 == 12'h55) && DataLo==8'h98
                                                               && ~SecSi)
                begin
                    BankCFIAddr = BankID;
                    CFIExit = ESP;
                end
            end

            ESP_PREL:
            begin
                if (DataLo == 8'h25 && (~SecSi || SecAddr>0))
                begin
                    PrgBank = BankID;
                    WrBuffSec = SecAddr;
                end
                else if ((AddrCom==12'h555) && (DataLo==8'hE0) && ~SecSi)
                begin
                    BankDYBAddr = BankID;
                end
                else if ((AddrCom==12'h555) && (DataLo==8'hC0) && ~SecSi)
                begin
                    BankPPBAddr = BankID;
                end
                else if ((AddrCom==12'h555) && (DataLo==8'h90) && ~SecSi)
                begin
                    BankASAddr  = BankID;
                end
                else if ((AddrCom==12'h555) && (DataLo ==8'h88)
                                && ~(ERS_QUEUE[0]))
                    SecSi = 1'b1;//SecSi Entry
            end

            PREL_WR2BUFF:
            begin
                if ( SecAddr == WrBuffSec && DataLo < 32 )
                begin
                    WrCnt = DataLo;
                    WrBuffCnt_temp = DataLo;
                    WrBuffPage = BuffPageAddr;
                end
                else
                begin
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                    WrBuffAddr[0] = Addr;
                end
            end

            WR2BUFF_0 :
            begin
                if (BuffPageAddr == WrBuffPage && WrCnt > 0 )
                begin
                    WrBuffAddr_temp[WrCnt] = Addr;
                    WrBuffData_temp[WrCnt] = Data;
                    WrCnt = WrCnt-1;
                end
                else if ( BuffPageAddr == WrBuffPage && WrCnt == 0 )
                begin
                    WrBuffAddr_temp[WrCnt] = Addr;
                    WrBuffData_temp[WrCnt] = Data;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
                else
                begin
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                    WrBuffAddr[0] = Addr;
                end
            end

            WR2BUFF_CNT :
            begin
                if ( BuffPageAddr == WrBuffPage && WrCnt > 0 )
                begin
                    WrBuffAddr_temp[WrCnt] = Addr;
                    WrBuffData_temp[WrCnt] = Data;
                    WrCnt = WrCnt-1;
                end
                else if ( BuffPageAddr == WrBuffPage && WrCnt == 0 )
                begin
                    WrBuffAddr_temp[WrCnt] = Addr;
                    WrBuffData_temp[WrCnt] = Data;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
                else
                begin
                    WrBuffAddr[0] = Addr;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
            end

            PREL_PRFLASH  :
            begin
                if (SecAddr == WrBuffSec && DataLo==8'h29)
                begin
                    WRBUFF_ACT = 1'b1;
                    WrCnt_temp = WrBuffCnt_temp;
                    for(i=0;i<=WrBuffCnt_temp;i=i+1)
                    begin
                        for(j=i+1;j<=WrBuffCnt_temp;j=j+1)
                        begin
                            if (WrBuffAddr_temp[j]== WrBuffAddr_temp[i])
                                WrBuffAddr_temp[j]= -1;
                        end
                    end
                    for(i=WrBuffCnt_temp;i>=0;i=i-1)
                    begin
                        if (WrBuffAddr_temp[i] == -1 )
                        begin
                            for(j=i;j<=WrBuffCnt_temp;j=j+1)
                            begin
                                WrBuffAddr_temp[j]= WrBuffAddr_temp[j+1];
                                WrBuffData_temp[j]= WrBuffData_temp[j+1];
                            end
                            WrCnt_temp = WrCnt_temp -1;
                        end
                    end
                    for(i=0;i<=WrBuffLength;i=i+1)
                        WrBuffAddr[i] = WrBuffAddr_temp[i];
                    for(i=0;i<=WrBuffLength;i=i+1)
                        WrBuffData[i] = WrBuffData_temp[i];
                    WrBuffCnt = WrCnt_temp;
                    PSTART = 1'b1;
                    PSTART  <= #1 1'b0;
                    WP_l = WPNeg;
                end
                else
                begin
                    WrBuffAddr[0] = Addr;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
            end

            PGS:
            begin
                if (DataLo == 16'h30)
                begin
                    PRES = 1'b1;
                    PRES <= #1 1'b0;
                    PSP_ACT = 1'b0;
                end
                else if (AddrCom % 12'h100 == 8'h55
                         && DataLo== 8'h98 && ~SecSi)
                begin
                     BankCFIAddr = BankID;
                     CFIExit = PGS;
                end
            end

            PGMS:
            begin
                if ((DataLo == 8'hB0) && ~LOCK_ACT && ~PASS_ACT)
                begin
                    PRES  = 1'b0;
                    PSUSP = 1'b1;
                    PSUSP <= #1 1'b0;
                    START_in = 1'b1;
                end
            end

            PGS_PREL:
            begin
                if (( AddrCom == 12'h555) && (DataLo==8'hE0) && ~SecSi)
                begin
                    BankDYBAddr = BankID;
                end
                else if (( AddrCom==12'h555) && (DataLo==12'hC0) && ~SecSi)
                    BankPPBAddr = BankID;
                else if (( AddrCom==12'h555) && (DataLo==12'h90) && ~SecSi)
                    BankASAddr  = BankID;
                else if (( AddrCom==12'h555) && (DataLo == 12'h88)
                        && (WrBuffSec !==0) && (~ESP_ACT || ~ERS_QUEUE[0]))
                    SecSi  = 1'b1; //SecSi Entry
            end

            SET_CONF :
            begin
                if ((AddrCom % 12'h100== 8'h00))
                begin
                    ConfReg0 = Data;
                    SYN = ~ (ConfReg0[15]);
                    SDR = ~ (ConfReg0[5]);
                    DDR = ConfReg0[5];
                end
            end

            SET_CONF1 :
            begin
                if ((AddrCom % 12'h100== 8'h01))
                    ConfReg1 = Data;
            end

            PASS_A0SEEN :
            begin
                PSTART = 1'b1;
                PSTART <= #1 1'b0;
                WRBUFF_ACT = 1'b0;
                WrBuffData[0] = Data;
                WrBuffAddr[0] = Addr;
                WrBuffSec = 0;
                WrBuffCnt = 0;
                PrgBank = 0;
                temp = DataLo;
                Status[7] = ~ temp[7];
            end

            PASS_EX :
            begin
                if (DataLo == 8'h00)
                    PASS_ACT = 1'b0;
            end

            PASS_UN_Z001 :
            begin
                if ((DataLo == 8'h03) && (AddrCom %12'h100 == 8'h00))
                begin
                    for (i=0;i<=PWLength;i=i+1)
                        PASS_TEMP[i] = MaxData;
                end
            end

            PASS_UN_PREL :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN1 :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN2 :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN3 :
            begin
                PASS_TEMP[AddrPass] = Data;
            end

            PASS_UN4 :
            begin
                if (( AddrCom % 12'h100 == 8'h00) && (DataLo == 8'h29))
                    PASS_UNLCK = 1'b1;
                    for (i=0;i<=PWLength;i=i+1)
                    begin
                        if ( PASS_TEMP[i] !== Password[i] )
                            PASS_UNLCK = 1'b0;
                    end
                    PUT_in = 1'b1;
            end

            LR_A0SEEN :
            begin
                if (AddrCom == 12'h00)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    WRBUFF_ACT = 1'b0;
                    WrBuffData[0] = Data;
                    WrBuffAddr[0] = 0;
                    WrBuffSec = 0;
                    WrBuffCnt = 0;
                    PrgBank = BankID;
                    temp = DataLo;
                    Status[7] = ~ temp[7];
                end
            end

            LR_PREL_EX :
            begin
                if ( DataLo == 8'h00 )
                    LOCK_ACT = 1'b0;
            end

            PREL_PPB :
            begin
                PPBP_in = 1'b0;
                PPBE_in = 1'b0;
            end

            PPB_PREL_PR :
            begin
                if ((DataLo == 8'h00) && BankID == BankPPBAddr)
                begin
                    SecPPBAddr = SecAddr;
                    PPBP_in = 1'b1;
                end
            end

            PPB_PREL_ER :
            begin
                if (DataLo == 8'h30)
                begin
                    PPBE_in = 1'b1;
                end
            end

            PPBLCK_PREL_ST :
            begin
                if (DataLo == 8'h00)
                    PPB_LOCK = 1'b0;   // set PPB Lock Bit
            end

            DYB_PREL_ST :
            begin
                if ((DataLo % 12'h100 == 8'h00) &&
                ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr])) &&
                BankID== BankDYBAddr &&
                ( ~PSP_ACT || SecAddr!== WrBuffSec))
                begin
                    DYB[SecAddr] = 1'b0;
                end
                else if ((DataLo % 12'h100 == 8'h01) &&
                BankID== BankDYBAddr &&
                ( ~ESP_ACT || ~(ERS_QUEUE[SecAddr])) &&
                ( ~PSP_ACT || SecAddr!==WrBuffSec))
                begin
                    DYB[SecAddr] = 1'b1;
                end
            end

            AS :
            begin
                if( (AddrCom % 9'h100 == 8'h55)&&
                          DataLo== 8'h98 && ~SecSi)
                begin
                    BankCFIAddr = BankID;
                    CFIExit = AS;
                end
            end

            SECSI_EX :
            begin
                if (DataLo == 8'h00)
                    SecSi = 1'b0;
            end
            endcase
        end
    end

    //PPB_PGMS state, PPBP_out
    always @(posedge PPBP_out)
    begin : Func1
        if (current_state == PPB_PGMS)
            PPBP_in = 1'b0;
            if ( PPB_LOCK == 1'b1&&
                (~ESP_ACT || ~ERS_QUEUE[SecPPBAddr]) &&
                (~PSP_ACT || SecPPBAddr!=WrBuffSec))
                PPB[SecPPBAddr] = 1'b0;
    end

    //PPB_ERS state, PPBE_out
    always @(posedge PPBE_out)
    begin : Func2
        if (current_state == PPB_ERS)
            PPBE_in = 1'b0;
            if ( PPB_LOCK == 1'b1 && LOCK_REG[3] && ~ESP_ACT && ~PSP_ACT)
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
        if (EERR!=1'b1 )
            if (~EDONE)//falling edge
            begin
                for (i=0;i<=SecNum;i=i+1)
                begin
                    if (PPB[i] && DYB[i] &&
                       (WP_l || ~( Boot_Sec[i])) && ACC)
                        if( i <= 3)
                            for (j =i*(SecSize16+1) + sgsa(0);
                                j<= i*(SecSize16+1) + sgsa(0)+SecSize16;
                                j=j+1)
                                Mem[j] = -1;
                        else if (i < SecNum-3 )
                            for (j = (i-4)*(SecSize64+1) + sgsa(1);
                                 j<= (i-4)*(SecSize64+1) + sgsa(1)+SecSize64;
                                 j=j+1)
                                Mem[j] = -1;
                        else
                            for( j = (i-(SecNum-3))*(SecSize16+1) + sgsa(2);
                                 j<= (i-(SecNum-3))*(SecSize16+1)
                                                         +sgsa(2)+SecSize16;
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
                        if( i <= 3)
                            for (j =i*(SecSize16+1) + sgsa(0);
                                j<= i*(SecSize16+1) + sgsa(0)+SecSize16;
                                j=j+1)
                                Mem[j] = MaxData;
                        else if (i < SecNum-3 )
                            for (j = (i-4)*(SecSize64+1) + sgsa(1);
                                 j<= (i-4)*(SecSize64+1) + sgsa(1)+SecSize64;
                                 j=j+1)
                                Mem[j] = MaxData;
                        else
                            for( j = (i-(SecNum-3))*(SecSize16+1) + sgsa(2);
                                 j<= (i-(SecNum-3))*(SecSize16+1)
                                                         +sgsa(2)+SecSize16;
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
                SET_in = 1'b0;
                START_in = 1'b0;
                ESUSP = 1'b0;
                ERES = 1'b0;
                ESTART = 1'b1;
                ESTART <= #1 1'b0;
            end
        end
    end

    //ESPS state, START_out
    always @(posedge START_out)
    begin : Func6
        if (current_state==ESPS)
        begin
            ESP_ACT = 1'b1;
            START_in = 1'b0;
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
                        if( i <= 3)
                            for (j =i*(SecSize16+1) + sgsa(0);
                                j<= i*(SecSize16+1) + sgsa(0)+SecSize16;
                                j=j+1)
                                Mem[j] = -1;
                        else if (i < SecNum-3 )
                            for (j = (i-4)*(SecSize64+1) + sgsa(1);
                                 j<= (i-4)*(SecSize64+1) + sgsa(1)+SecSize64;
                                 j=j+1)
                                Mem[j] = -1;
                        else
                            for( j = (i-(SecNum-3))*(SecSize16+1) + sgsa(2);
                                 j<= (i-(SecNum-3))*(SecSize16+1)
                                                         +sgsa(2)+SecSize16;
                                 j=j+1)
                                Mem[j] = -1;
                    end
                end
                if (EDONE)
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                    if (ERS_QUEUE[i] && PPB[i] && DYB[i] &&
                       (WPNeg || ~( Boot_Sec[i])) && ACC)
                       if( i <= 3)
                            for (j =i*(SecSize16+1) + sgsa(0);
                                j<= i*(SecSize16+1) + sgsa(0)+SecSize16;
                                j=j+1)
                                Mem[j] = MaxData;
                        else if (i < SecNum-3 )
                            for (j = (i-4)*(SecSize64+1) + sgsa(1);
                                 j<= (i-4)*(SecSize64+1) + sgsa(1)+SecSize64;
                                 j=j+1)
                                Mem[j] = MaxData;
                        else
                            for( j = (i-(SecNum-3))*(SecSize16+1) + sgsa(2);
                                 j<= (i-(SecNum-3))*(SecSize16+1)
                                                         +sgsa(2)+SecSize16;
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
                if (~PDONE )//falling
                begin
                    x = WrBuffSec;
                    for(i=WrBuffCnt;i>=0;i=i-1)
                    begin
                        new_int = WrBuffData[i];
                        old_int = -1;
                        if (PASS_ACT )
                            old_int = Password[WrBuffAddr[i]% 4];
                        else if (LOCK_ACT)
                            old_int = LOCK_REG;
                        else if( SecSi && (x==0) && (WrBuffAddr[0]<=8'hFF))
                            old_int = SecSiMem[WrBuffAddr[i]];
                        else
                            old_int = Mem[WrBuffAddr[i]];
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
                            WrBuffData[i]= new_int;
                        end
                        else
                            WrBuffData[i]= -1;
                    end
                    if (PASS_ACT && LOCK_REG[2])
                        Password[WrBuffAddr[0]% 4] = -1;
                    else if ( SecSi && (x==0) && (WrBuffAddr[0]<=8'hFF)
                             && WrBuffAddr[0]>=8'h80 && LOCK_REG[0])
                        SecSiMem[WrBuffAddr[0]] = -1;
                    else if(( PPB[x] && DYB[x] &&
                           (WP_l || ~(Boot_Sec[x])) && ACC)
                           && ( ~ESP_ACT || ~(ERS_QUEUE[x]))&& ~LOCK_ACT)
                        for(i=WrBuffCnt;i>=0;i=i-1)
                            Mem[WrBuffAddr[i]] = -1;
                end
                if (~HANG && PDONE)//rising
                begin
                    WRBUFF_ACT = 1'b0;
                    x = WrBuffSec;
                    if (PASS_ACT && LOCK_REG[2])
                    begin
                        Password[WrBuffAddr[0]% 4] = WrBuffData[0];
                        WrBuffData[0] = -1;
                    end
                    else if (LOCK_ACT)
                    begin
                        new_bit = WrBuffData[0];
                        if ( new_bit[1] || new_bit[2])
                            LOCK_REG[2:1] = new_bit[2:1];
                        LOCK_REG[0]= new_bit[0];
                    end
                    else if ( SecSi && (x==0) && (WrBuffAddr[0]<=8'hFF)
                             && WrBuffAddr[0]>=8'h80 && LOCK_REG[0])
                    begin
                        SecSiMem[WrBuffAddr[0]] = WrBuffData[0];
                        WrBuffData[0] = -1;
                    end
                    else if(( PPB[x] && DYB[x] &&
                           (WP_l || ~(Boot_Sec[x])) && ACC)
                                && ( ~ESP_ACT || ~(ERS_QUEUE[x])))
                    begin
                        for(i=WrBuffCnt;i>=0;i=i-1)
                        begin
                            Mem[WrBuffAddr[i]] = WrBuffData[i];
                            WrBuffData[i] = -1;
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
            PSP_ACT = 1'b1;
       end
    end

    // Hardware RESET cycle
    always @(negedge RST)
    begin
        if (~RESETNeg)
        begin
            PASS_ACT = 1'b0;
            LOCK_ACT = 1'b0;
            SecSi = 1'b0;
            ULBYPASS = 1'b0;
            ESP_ACT = 1'b0;
            PSP_ACT = 1'b0;
            WRBUFF_ACT =1'b0;
            ConfReg0 = 16'b1011111111001000;
            ConfReg1 = 16'b1111111111101111;
            SYN = 1'b0;
            SDR = 1'b1;
            DDR = 1'b0;
            ERS_QUEUE = 0;
            ERS_QUEUE_B = 0;
            if( LOCK_REG[2] == 1'b0 )
                PPB_LOCK = 1'b0;
            else
                PPB_LOCK = 1'b1;
            if( LOCK_REG[4] == 1'b1 )
                DYB = ~(0);
            else
                DYB = 0;
            PPBP_in = 1'b0;
            PPBE_in = 1'b0;
            PUT_in = 1'b0;
            START_in = 1'b0;
            SET_in = 1'b0;
            RD_MODE = NOSYNC;
        end
    end

    //Initializing burst parameters
    always @(negedge BURST)
    begin
        INITIAL = 1'b1;
        DelayCycSwitch = 0;
        BurstAddr = Addr;
        BurstSec = SecAddr;
        if ( ConfReg0[2:0] == 3'b010 )
            BurstLength = 8;
        else if (ConfReg0[2:0] == 3'b011 )
            BurstLength = 16;
        else if (ConfReg0[2:0] == 3'b100 )
            BurstLength = 32;
        else
            BurstLength = 0;
        RdCnt = BurstLength;
        if (~ConfReg1[0])
        begin
            if (ConfReg0[13:11] <=4 )
                WS_Initial = ConfReg0[13:11]+2;
            else // ConfReg0[13:11] = 7
                WS_Initial = 7;
        end
        else
        begin
            if (ConfReg0[13:11] <=5 )
                WS_Initial = ConfReg0[13:11]+8;
            else
                WS_Initial = 13;
        end
        // Set WS_Latency according to WS_Initial
        if (WS_Initial >=9)
            WS_Latency = 7;
        else
            WS_Latency = WS_Initial-2;
        // Set WS_Boundary according to WS_Initial
        if (WS_Initial >=9)
            WS_Boundary = WS_Initial-9;
        else
            WS_Boundary = 0;
        if (ConfReg0[5])
            BurstDelay = BurstDelay + WS_Initial -2;
        else
            BurstDelay = BurstDelay + WS_Initial -1;
        IN_W_ELAPSED = 1'b0;
        DATA_DELAY = 1'b0;
        BOUNDARY_CROSS = 1'b0;
        BURST_END = 1'b0;
        NO_PROGRESS = 1'b0;
        BusyBound = 1'b0;
        DelayCyc_CNT = BurstAddr % 8;
        if ((DelayCyc_CNT - (7-WS_Latency)) > 0)
            DelayCyc_CNT = DelayCyc_CNT - (7-WS_Latency);
        else
            DelayCyc_CNT = 0;
        LatencyAddr = ((BurstAddr / 8)*8) + 7;
    end

    // Burst functionality
    always @(posedge CLKMerge or negedge ReadINIT)
    begin:BurstRead
        if (RD_MODE==LINEAR)
        begin
            if ( BurstDelay > 0 )
            begin
                BurstDelay = BurstDelay - 1;
                if (~OENeg)
                begin
                    RDY_temp = 1'b0;
                    DQS_temp = 1'b0;
                end
                if ( BurstDelay == 1 )
                begin
                    if (~ConfReg0[8])
                        RDY_temp = 1'b1;
                end
                if ( BurstDelay == 0 )
                    RDY_temp = 1'b1;
            end
            if ( BurstDelay == 0 )
            begin
                if (IACC_out || ~IN_W_ELAPSED)
                begin
                    if ( BURST_END )
                        RDY_temp = 1'b0;
                    else if ( INITIAL )
                    begin
                        if ( DelayCycSwitch == 0
                            && BurstAddr != LatencyAddr )
                        begin
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DQS_temp =  ~DQS_temp;
                            NEXT_ADDR_LIN(BurstAddr,BurstLength);
                            CHECK_END(RdCnt,1'b1,BURST_END);
                            if ( BurstAddr == LatencyAddr )
                            begin
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 4;
                                else
                                    DelayCycSwitch = 1;
                            end
                        end
                        else if ( DelayCycSwitch==0
                            && BurstAddr==LatencyAddr )
                        begin
                            if (  DelayCyc_CNT > 0 )
                                RDY_temp = ConfReg0[8];
                            else
                                RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DQS_temp = ~DQS_temp;
                            if ( DelayCyc_CNT == 0 )
                            begin
                                INITIAL = 1'b0;
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                DelayCycSwitch = 0;
                            end
                            else
                            begin
                                DelayCyc_CNT = DelayCyc_CNT -1;
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 3;
                                else
                                    DelayCycSwitch = 2;
                            end
                        end
                        else if ( DelayCycSwitch == 1 )
                        begin
                            RDY_temp = ConfReg0[8];
                            DQS_temp = ~ DQS_temp;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                            else
                                DelayCycSwitch = 2;
                        end
                        else if ( DelayCycSwitch == 2 )
                        begin
                            RDY_temp = 1'b0;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                        end
                        else if ( DelayCycSwitch == 3 )
                        begin
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            NEXT_ADDR_LIN(BurstAddr,BurstLength);
                            CHECK_END(RdCnt,1'b1,BURST_END);
                            RDY_temp = ~ConfReg0[8];
                            DelayCycSwitch = 4;
                        end
                        else //DelayCycSwitch = 4
                        begin
                            INITIAL = 1'b0;
                            DelayCycSwitch = 0;
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DQS_temp = ~DQS_temp;
                            NEXT_ADDR_LIN(BurstAddr,BurstLength);
                            CHECK_END(RdCnt,1'b1,BURST_END);
                        end
                        if (BURST_END)
                            RDY_temp = ConfReg0[8];
                    end
                    else //
                    begin
                        READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                        NEXT_ADDR_LIN(BurstAddr,BurstLength);
                        CHECK_END(RdCnt,1'b1,BURST_END);
                        DQS_temp = ~DQS_temp;
                        if (~ BURST_END )
                            RDY_temp = 1'b1;
                        else
                            RDY_temp = ConfReg0[8];
                    end
                end
                else
                begin
                    if ( ~OENeg )
                        $display( " More wait states should be programmed ");
                end
                if ( IN_W_ELAPSED )
                    DATA_DELAY = 1'b1;
                IN_W_ELAPSED = 1'b1;
            end
        end
        else if ( RD_MODE == CONTINUOUS || RD_MODE == LINEAR_NO_WRAP )
        begin
            if ( BurstDelay > 0 )
            begin
                BurstDelay = BurstDelay - 1;
                if (~OENeg)
                begin
                    RDY_temp = 1'b0;
                    DQS_temp = 1'b0;
                end
                if ( BurstDelay == 1 )
                begin
                    if (~ConfReg0[8])
                        RDY_temp = 1'b1;
                end
                if ( BurstDelay == 0 )
                    RDY_temp = 1'b1;
            end
            if ( BurstDelay == 0 )
            begin
                if (IACC_out || ~ IN_W_ELAPSED)
                begin
                    if ( BURST_END )
                        RDY_temp = 1'b0;
                    else if ( INITIAL )
                    begin
                        if ( DelayCycSwitch == 0
                            && BurstAddr != LatencyAddr )
                            begin
                            RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DQS_temp = ~ DQS_temp;
                            NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                            CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,
                                                            BURST_END);
                            if ( BurstAddr == LatencyAddr )
                            begin
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 4;
                                else
                                    DelayCycSwitch = 1;
                            end
                        end
                        else if ( DelayCycSwitch==0
                            && BurstAddr==LatencyAddr )
                            begin
                            if (  DelayCyc_CNT > 0 )
                                RDY_temp = ConfReg0[8];
                            else
                                RDY_temp = 1'b1;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DQS_temp = ~ DQS_temp;
                            if ( DelayCyc_CNT == 0 )
                            begin
                                INITIAL = 1'b0;
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                DelayCycSwitch = 0;
                            end
                            else
                            begin
                                DelayCyc_CNT = DelayCyc_CNT -1;
                                if ( DelayCyc_CNT == 0 )
                                    DelayCycSwitch = 3;
                                else
                                    DelayCycSwitch = 2;
                            end
                        end
                        else if ( DelayCycSwitch == 1 )
                        begin
                            RDY_temp = ConfReg0[8];
                            DQS_temp = ~ DQS_temp;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                            else
                                DelayCycSwitch = 2;
                        end
                        else if ( DelayCycSwitch == 2 )
                        begin
                            RDY_temp = 1'b0;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            DelayCyc_CNT = DelayCyc_CNT -1;
                            if ( DelayCyc_CNT == 0 )
                                DelayCycSwitch = 3;
                        end
                        else if ( DelayCycSwitch == 3 )
                        begin
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            if ( BurstAddr % 8'h80 == 8'h7F )
                            begin
                                if ( WS_Boundary > 0 )
                                    RDY_temp = 1'b0;
                                else
                                begin
                                    CheckBoundary(BusyBound, CrossData,
                                        BurstAddr, BurstSec);
                                    NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                    CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                                ,BURST_END);
                                    RDY_temp = ~ ConfReg0[8];
                                end
                                INITIAL = 1'b0;
                                BOUNDARY_CROSS = 1'b1;
                                BoundarySwitch = 0;
                            end
                            else
                            begin
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                                ,BURST_END);
                                RDY_temp = ~ ConfReg0[8];
                                DelayCycSwitch = 4;
                            end
                        end
                        else //DelayCycSwitch == 4
                        begin
                            INITIAL = 1'b0;
                            DelayCycSwitch = 0;
                            DQS_temp = ~ DQS_temp;
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            if ( BurstAddr % 8'h80 == 8'h7F )
                            begin
                                if ( WS_Boundary > 0 )
                                    RDY_temp = ConfReg0[8];
                                else
                                begin
                                    CheckBoundary(BusyBound, CrossData,
                                        BurstAddr, BurstSec);
                                    NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                    CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                                ,BURST_END);
                                    RDY_temp = 1'b1;
                                end
                                BOUNDARY_CROSS = 1'b1;
                                BoundarySwitch = 0;
                            end
                            else
                            begin
                                RDY_temp = 1'b1;
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,
                                                            BURST_END);
                            end
                        end
                        if (BURST_END)
                            RDY_temp = ConfReg0[8];
                    end
                    else if ( BOUNDARY_CROSS )
                    begin
                        if ( BoundarySwitch == 0 )
                        begin
                            if ( WS_Boundary > 0 )
                            begin
                                READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                                WS_Boundary = WS_Boundary - 1;
                                if ( WS_Boundary > 0 )
                                begin
                                    RDY_temp = 1'b0;
                                    BoundarySwitch = 1;
                                end
                                else
                                begin
                                    RDY_temp = ~ ConfReg0[8];
                                    CheckBoundary(BusyBound, CrossData,
                                        BurstAddr, BurstSec);
                                    NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                    CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,
                                                        BURST_END);
                                    BoundarySwitch = 2;
                                end
                            end
                            else
                                BoundarySwitch = 3;
                        end
                        else if ( BoundarySwitch == 1 )
                        begin
                            READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                            WS_Boundary = WS_Boundary - 1;
                            if ( WS_Boundary > 0 )
                                RDY_temp = 1'b0;
                            else
                            begin
                                RDY_temp = ~ ConfReg0[8];
                                CheckBoundary(BusyBound, CrossData,
                                        BurstAddr, BurstSec);
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,
                                                        BURST_END);
                                BoundarySwitch = 2;
                            end
                        end
                        else // Boundary switch==2
                            BoundarySwitch=3;
                        if ( BoundarySwitch == 3 )
                        begin
                            RDY_temp = 1'b1;
                            if ( BusyBound )
                            begin
                                NO_PROGRESS = 1'b1;
                                DOut_burst = CrossData;
                                DQS_temp = ~ DQS_temp;
                            end
                            else
                            begin
                                READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                DQS_temp = ~ DQS_temp;
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP,
                                                        BURST_END);
                            end
                            BOUNDARY_CROSS = 1'b0;
                        end
                        if (BURST_END)
                            RDY_temp = ConfReg0[8];
                    end
                    else if ( NO_PROGRESS )
                        RDY_temp = 1'b1;
                    else
                    begin
                        READ_BURST_DATA(BurstAddr,BurstSec,SecSi);
                        DQS_temp = ~ DQS_temp;
                        if ( BurstAddr % 8'h80 == 8'h7F )
                        begin
                            if ( WS_Boundary > 0 )
                                RDY_temp = ConfReg0[8];
                            else
                            begin
                                CheckBoundary(BusyBound, CrossData,
                                    BurstAddr, BurstSec);
                                NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                                CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                                ,BURST_END);
                                RDY_temp = 1'b1;
                            end
                            BOUNDARY_CROSS = 1'b1;
                            BoundarySwitch = 0;
                        end
                        else
                        begin
                            NEXT_ADDR(BurstAddr,BurstSec,SecSi);
                            CHECK_END(RdCnt,RD_MODE==LINEAR_NO_WRAP
                                                                ,BURST_END);
                            RDY_temp = 1'b1;
                        end
                        if ( BURST_END )
                            RDY_temp = ConfReg0[8];
                    end
                end
                else
                begin
                    if ( ~OENeg)
                        $display( " More wait states should be programmed ");
                end
                if ( IN_W_ELAPSED )
                    DATA_DELAY = 1'b1;
                IN_W_ELAPSED = 1'b1;
            end
        end
        else if ( RD_MODE == SYNCR )
        begin
            if ( BurstDelay > 0 )
            begin
                BurstDelay = BurstDelay - 1;
                if (~OENeg)
                begin
                    RDY_temp = 1'b0;
                    DQS_temp = 1'b0;
                end
                if ( BurstDelay == 1 )
                begin
                    if (~ConfReg0[8])
                        RDY_temp = 1'b1;
                end
            end
            if ( BurstDelay == 0 )
            begin
                RDY_temp = 1'b1;
                DQS_temp = 1'b1;
            end
        end
    end

    //Burst data setup
    always @( OENeg or DOut_burst)
    begin
        if (~OENeg && ~CENeg && RD_MODE != NOSYNC && IN_W_ELAPSED )
            DOut_zd = DOut_burst;
    end

    //Output Disable Control
    always @(posedge OENeg)
    begin
        DOut_zd = 16'bz;
    end

    //Output Disable Control
    always @(posedge CENeg )
    begin
        DOut_zd    = 16'bZ;
        DOut_burst = 16'bZ;
    end

    //Output Disable Control
    always @(negedge RST)
    begin
        if(~RESETNeg)
        begin
            DOut_zd = 16'bZ;
            DOut_burst = 16'bZ;
        end
    end

    always @( negedge OENeg)
    begin: OutputBurstOE
         RDY_temp = 1'b0;
         DQS_temp = 1'b0;
    end

    always @( posedge CENeg)
    begin: OutputBurstCE
         #1 DQS_temp <= 1'b1;
         #1 RDY_temp <= 1'b1;
    end

    task READMEM;
    input integer Address;
    input integer Bank;
    input integer Sec;
    input SS;
    integer ReadData;
    begin
        if (~SS || Sec!=0)
        begin
            if (Mem[Address]!=-1)
                ReadData = Mem[Address];
            else
                ReadData = 16'bx;
        end
        else if( Address>=8'h00 && Address<=8'hFF )
        begin
            if( SecSiMem[Address] != -1 )
                ReadData = SecSiMem[Address];
            else
                ReadData = 16'bx;
        end
        else
        begin
            ReadData = 16'bz;
            // SecSi Address out of range
            $display  ("Address out of SecSi range.");
        end
        OutputD = ReadData;
    end
    endtask

    task READ_BURST_DATA;
    input integer   BAddr;
    input integer   BSec;
    input SS;
    begin
            if( ~SS || BSec>0)
            begin
                if( Mem[BAddr]!=-1)
                    DOut_burst = Mem[BAddr];
                else
                    DOut_burst = 16'bx;
            end
            else
            begin
                if( SecSiMem[BAddr]!=-1 )
                    DOut_burst = SecSiMem[BAddr];
                else
                    DOut_burst = 16'bx;
            end
    end
    endtask

    task NEXT_ADDR_LIN;
    inout integer BAddr;
    input integer Length;
    begin
        BAddr = BAddr + 1;
        if( BAddr % Length == 0 )
            BAddr= BAddr - Length;
    end
    endtask

    task CHECK_END;
    inout integer CNT;
    input Enable;
    output BEnd;
    begin
        if (Enable)
        begin
        CNT=CNT-1;
            if (CNT== 0)
                BEnd = 1'b1;
            else
                BEnd = 1'b0;
        end
        else
            BEnd = 1'b0;
    end
    endtask

    task NEXT_ADDR;
    inout integer BAddr;
    inout integer BSec ;
    input SS ;
    begin
        if( ~SecSi || BSec>0 )
        begin
            if( BAddr == MemSize )
            begin
                BAddr = 0;
                BSec = 0;
            end
            else
            begin
                BAddr=BAddr+1;
                if( BSec < (SecNum -3) && BSec > 3 )
                begin
                    if((BAddr % (SecSize64+1) == 0))
                        BSec= BSec + 1;
                end
                else
                begin
                    if( (BAddr % (SecSize16+1) == 0) )
                        BSec = BSec+1;
                end
           end
        end
        else
        begin
            if( BAddr == 8'hFF )
                BAddr = 0;
            else
                BAddr = BAddr+1;
        end
    end
    endtask

    task CheckBoundary;
    inout BusyBound;
    inout [15:0]CrossData;
    inout integer BurstAddr;
    inout integer BurstSect;
    integer BankCHECK;
    integer SectorCHECK;
    begin
        BankCHECK =
        ReturnBank((BurstAddr+1) % (MemSize+1));
        SectorCHECK =
        ReturnSectorID((BurstAddr+1) % (MemSize+1));
        BusyBound = 1'b0;
        if (BankCHECK == BankCFIAddr &&
         current_state==CFI)
        begin
            CrossData = 16'bz;
            BusyBound = 1'b1;
        end
        else if(((BankCHECK != BankCFIAddr && current_state==CFI) ||
              (BankCHECK!=PrgBank && current_state==PGMS) ||
              (BankCHECK!=PrgBank && current_state==PGSPS) ||
              (SectorCHECK!=WrBuffSec && current_state==PGS) ||
              (BankCHECK!=PrgBank && current_state==WR2BUFF_AB)) &&
              (ESP_ACT && ERS_QUEUE[SectorCHECK] ))
        begin
            CrossData = 16'b0;
            CrossData[7:0] = Status;
            CrossData[7] = 1'b1;
            BusyBound = 1'b1;
        end
        else if ( ERS_QUEUE[SectorCHECK] && current_state==ESP)
        begin
            Status[7] = 1'b1;
            CrossData = 16'b0;
            CrossData[7:0] = Status;
            BusyBound = 1'b1;
        end
        else if (ERS_QUEUE_B[BankCHECK] &&
         (current_state==SERS ||
          current_state==SERS_EXEC ||
          current_state==ESPS))
        begin
            if (ERS_QUEUE[SectorCHECK])
                Status[7] = 1'b0;
            else
                Status[7] = 1'b1;
            CrossData = 16'b0;
            CrossData[7:0] = Status;
            BusyBound = 1'b1;
        end
        else if (BankCHECK==PrgBank &&
         (current_state==PGMS ||
         current_state==PGSPS ||
         current_state==WR2BUFF_AB))
        begin
            CrossData = 16'b0;
            CrossData[7:0] = Status;
            if((BurstAddr+1) % (MemSize+1)==WrBuffAddr[0]
             || LOCK_ACT )
                CrossData[7] = Status[7];
            else
                CrossData[7] = ~(Status[7]);
            BusyBound = 1'b1;
        end
        else if (SectorCHECK==WrBuffSec && current_state==PGS)
        begin
            CrossData = 16'bz;
            BusyBound = 1'b1;
        end
        else if (BankCHECK==0 && current_state==PREL_PASS)
        begin
            if (LOCK_REG[2])
                CrossData = Password[0];
            else
                CrossData = 16'b1;
            BusyBound = 1'b1;
        end
        else if (BankCHECK==0 && current_state==PREL_LR)
        begin
            CrossData = LOCK_REG;
            BusyBound = 1'b1;
        end
        else if ((CFIExit == AS && BankCHECK == BankASAddr
          && current_state==CFI) ||
          (BankCHECK == BankASAddr && current_state == AS))
        begin
            CrossData = 16'h0001;
            BusyBound = 1'b1;
        end
        else if (SectorCHECK==0 && SecSi)
        begin
            CrossData = 16'bz;
            BusyBound = 1'b1;
        end
        BusyBound = BusyBound &&
          ( ReturnBank(BurstAddr) != BankCHECK ||
            ReturnSectorID(BurstAddr)!= SectorCHECK );
    end
    endtask

    function integer ReturnSectorID;
    input [HiAddrBit:0] SADDR;
    integer conv;
    begin
        conv = SADDR / 20'h10000;
        if ( conv == 0 || conv == 1)
            ReturnSectorID = SADDR / 16'h4000;
        else if (( conv >= 1 ) && ( conv <= 510 ))
            ReturnSectorID = 3 + conv;
        else
            ReturnSectorID = 514 + (SADDR - 25'h1FF0000)/16'h4000;
    end
    endfunction

    function integer ReturnBuffPage;
    input[HiAddrBit:0] PADDR;
    begin
        ReturnBuffPage = PADDR / 6'h20;
    end
    endfunction

    function[3:0] ReturnBank;
    input[HiAddrBit:0] BADDR;
    begin
        ReturnBank = BADDR / 24'h200000;
    end
    endfunction

    function integer sgsa;
    input integer i;
    begin
        if (i == 0)
            sgsa=25'h000000;
        else if (i == 1)
            sgsa=25'h010000;
        else
            sgsa=25'h1FF0000;
    end
    endfunction

    reg  BuffInOE, BuffInCE, BuffInADDRIN ,BuffInADDRPAGE,
                                  BuffInIACCZH ,BuffInIACCL;
    wire BuffOutOE, BuffOutCE, BuffOutADDRIN , BuffOutADDRPAGE,
                                  BuffOutIACCZH, BuffOutIACCL;

    BUFFER    BUFOE          (BuffOutOE      , BuffInOE);
    BUFFER    BUFCE          (BuffOutCE      , BuffInCE);
    BUFFER    BUFADDRIN      (BuffOutADDRIN  , BuffInADDRIN);
    BUFFER    BUFADDRPAGE    (BuffOutADDRPAGE, BuffInADDRPAGE);
    BUFFER    BUFIACCZH      (BuffOutIACCZH  , BuffInIACCZH);
    BUFFER    BUFIACCL       (BuffOutIACCL   , BuffInIACCL);

    initial
    begin
        BuffInOE        = 1'b1;
        BuffInCE        = 1'b1;
        BuffInADDRIN    = 1'b1;
        BuffInADDRPAGE  = 1'b1;
        BuffInIACCZH    = 1'b1;
        BuffInIACCL     = 1'b1;
    end

    always @(posedge BuffOutOE)
    begin
        OEDQ_01 = $time;
    end
    always @(posedge BuffOutCE)
    begin
        CEDQ_01 = $time;
    end
    always @(posedge BuffOutADDRIN)
    begin
        ADDRDQIN_01 = $time;
    end
    always @(posedge BuffOutADDRPAGE)
    begin
        ADDRDQPAGE_01 = $time;
    end
    always @(posedge BuffOutIACCZH)
    begin
        IACCZHDQ_01 = $time;
    end
    always @(posedge BuffOutIACCL)
    begin
        IACCLDQ_01 = $time;
    end

endmodule

module BUFFER (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
