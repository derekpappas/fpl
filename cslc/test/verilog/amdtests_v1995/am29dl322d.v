//////////////////////////////////////////////////////////////////////////////
//  File name : am29dl322d.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version: | author:         | % date: | changes made:
//    V1.0    J.Bogosavljevic   04 Apr 28  -Initial release
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           am29dl322d
//
//  Description:    32Mbit (4M x 8-Bit/2M x 16-Bit) Simultaneous Operation Flash
//                  Memory. Boot sector determined by TimingModel generic
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns

module am29dl322d
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
    wire  WPNeg_ipd ;
    wire  BYTENeg_ipd  ;

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

    reg [15 : 0] DOut_zd;
    reg [15 : 0] DOut_z;
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
            DQ0_z  } = DOut_z;

    reg RY_zd;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";
    parameter prot_file_name  = "none";
    parameter secsi_file_name = "none";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID     = "am29dl322d";
    parameter MaxData    = 255;
    parameter BankNum    = 1;
    parameter MemSize    = 22'h3FFFFF;
    parameter SecSize_l  = 16'hFFFF;
    parameter SecSize_s  = 16'h1FFF;
    parameter SecSiSize  = 16'hFFFF;
    parameter SecNum     = 70;
    parameter BootSecNum = 7;
    parameter HiAddrBit  = 20;
    parameter MinCfiAddr = 16'h10;
    parameter MaxCfiAddr = 16'h4F;

    //varaibles to resolve if bottom or top architecture is used
    reg [20*8-1:0] tmp_timing;//stores copy of TimingModel
    reg [7:0] tmp_char;//stores "t" or "b" character
    integer found = 1'b0;
    integer tmp = 0;
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

    //Sector Address
    integer SecAddr = 0;         // 0 - SecNum
    integer SA      = 0;         // 0 TO SecNum

    //Address within sector
    integer Address = 0;         // 0 - SecSize

    integer D_tmp0; //0 TO MaxData;
    integer D_tmp1; //0 TO MaxData;

    //A20:A11 Don't Care
    integer Addr ;         //0 TO 16'h7FF#

    integer LB_Ei [0:BankNum];
    integer BA_sel2 = 0;
    integer BA      = 0;

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
    integer SecSi[0:SecSiSize];

    //SecSi ProtectionStatus
    reg FactoryProt;

    // timing check violation
    reg     Viol = 1'b0;
    reg     vs;
    integer first_prot;

    integer WBData[0:1];
    integer WBAddr[0:1];

    integer cnt = 0;

    reg Sec_Prot_reg0  = 1'b0;
    reg Sec_Prot_reg1  = 1'b0;

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

    specparam           tpd_DQ15_DQ0           =1;
    specparam           tpd_DQ15_DQ1           =1;
    specparam           tpd_DQ15_DQ2           =1;
    specparam           tpd_DQ15_DQ3           =1;
    specparam           tpd_DQ15_DQ4           =1;
    specparam           tpd_DQ15_DQ5           =1;
    specparam           tpd_DQ15_DQ6           =1;
    specparam           tpd_DQ15_DQ7           =1;

    specparam           tpd_BYTENeg_DQ8           =1;
    specparam           tpd_BYTENeg_DQ9           =1;
    specparam           tpd_BYTENeg_DQ10           =1;
    specparam           tpd_BYTENeg_DQ11           =1;
    specparam           tpd_BYTENeg_DQ12           =1;
    specparam           tpd_BYTENeg_DQ13           =1;
    specparam           tpd_BYTENeg_DQ14           =1;
    specparam           tpd_BYTENeg_DQ15           =1;

     specparam           tpd_WENeg_RY            =1;
     specparam           tpd_CENeg_RY            =1;

// tsetup values: setup time
     specparam           tsetup_A0_OENeg         =1;

     specparam           tsetup_DQ0_CENeg        =1;
     specparam           tsetup_DQ0_WENeg        =1;

// thold values: hold times
     specparam           thold_A0_CENeg          =1;
     specparam           thold_A0_WENeg          =1;
     specparam           thold_BYTENeg_WENeg     =1;

     specparam           thold_BYTENeg_CENeg     =1;
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
     specparam   tdevice_POB                     = 150000;
     specparam   tdevice_POW                     = 210000;
     specparam   tdevice_POU                     = 120000;
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
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ8) = tpd_CENeg_DQ8;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ9) = tpd_CENeg_DQ9;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ10) = tpd_CENeg_DQ10;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ11) = tpd_CENeg_DQ11;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ12) = tpd_CENeg_DQ12;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ13) = tpd_CENeg_DQ13;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ14) = tpd_CENeg_DQ14;
  if (~SWITCH || (SWITCH && FROMCE))
    (CENeg *> DQ15) = tpd_CENeg_DQ15;


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
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ8) = tpd_OENeg_DQ8;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ9) = tpd_OENeg_DQ9;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ10) = tpd_OENeg_DQ10;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ11) = tpd_OENeg_DQ11;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ12) = tpd_OENeg_DQ12;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ13) = tpd_OENeg_DQ13;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ14) = tpd_OENeg_DQ14;
  if (~SWITCH || (SWITCH && FROMOE))
    (OENeg *> DQ15) = tpd_OENeg_DQ15;


  if (~BYTENeg) (DQ15 *> DQ0) = tpd_DQ15_DQ0;
  if (~BYTENeg) (DQ15 *> DQ1) = tpd_DQ15_DQ1;
  if (~BYTENeg) (DQ15 *> DQ2) = tpd_DQ15_DQ2;
  if (~BYTENeg) (DQ15 *> DQ3) = tpd_DQ15_DQ3;
  if (~BYTENeg) (DQ15 *> DQ4) = tpd_DQ15_DQ4;
  if (~BYTENeg) (DQ15 *> DQ5) = tpd_DQ15_DQ5;
  if (~BYTENeg) (DQ15 *> DQ6) = tpd_DQ15_DQ6;
  if (~BYTENeg) (DQ15 *> DQ7) = tpd_DQ15_DQ7;

    (BYTENeg *> DQ8) = tpd_BYTENeg_DQ8;
    (BYTENeg *> DQ9) = tpd_BYTENeg_DQ9;
    (BYTENeg *> DQ10) = tpd_BYTENeg_DQ10;
    (BYTENeg *> DQ11) = tpd_BYTENeg_DQ11;
    (BYTENeg *> DQ12) = tpd_BYTENeg_DQ12;
    (BYTENeg *> DQ13) = tpd_BYTENeg_DQ13;
    (BYTENeg *> DQ14) = tpd_BYTENeg_DQ14;
    (BYTENeg *> DQ15) = tpd_BYTENeg_DQ15;

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

        $hold ( negedge WENeg, BYTENeg , thold_A0_CENeg, Viol);

        $hold ( negedge CENeg, BYTENeg, thold_A0_CENeg, Viol);
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
 parameter OTP             =6'd8;
 parameter OTP_Z001        =6'd9;
 parameter OTP_PREL        =6'd10;
 parameter OTP_AS          =6'd11;
 parameter OTP_A0SEEN      =6'd12;
 parameter C8              =6'd13;
 parameter C8_Z001         =6'd14;
 parameter C8_PREL         =6'd15;
 parameter ERS             =6'd16;//10
 parameter SERS            =6'd17;//11
 parameter ESPS            =6'd18;//12
 parameter SERS_EXEC       =6'd19;//13
 parameter ESP             =6'd20;//14
 parameter ESP_Z001        =6'd21;//15
 parameter ESP_PREL        =6'd22;//16
 parameter ESP_CFI         =6'd23;
 parameter ESP_A0SEEN      =6'd24;
 parameter ESP_AS          =6'd25;
 parameter PGMS            =6'd26;

    reg [5:0] current_state;
    reg [5:0] next_state;

    reg deq;

    integer sector_preload[0:MemSize];
    integer  sector_prot[0:SecNum+1];
//    reg [SecNum:0] Sec_Prot; //= SecNum'b0;
    integer secure_silicon[0:SecSiSize];

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
    //"am29dl322dt"
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
        tmp_char[j] = TimingModel[(i-9)*8+j];//bottom/top character is 10
        end                                  //characters right from first ("a")
    end
    if (tmp_char == "t")
    begin
          vs         = 1'b1;
          first_prot = SecNum - 1;
    end
    else if (tmp_char == "b")
    begin
          vs         = 1'b0;
          first_prot = 0;
    end

    // initialize memory and load preoload files if any

        for (i=0;i<=MemSize;i=i+1)
        begin
           sector_preload[i]=MaxData;
           tmp = i;
        end

        for (i=0;i<=SecNum+1;i=i+1)
        begin
            sector_prot[i]=0;

        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            Sec_Prot[i] = 0;
            Ers_queue[i] = 0;
        end

        for (i=0;i<=SecSiSize;i=i+1)
        begin
           secure_silicon[i]=MaxData;
            //SecSi[i]=MaxData;
        end

        if (UserPreload && prot_file_name != "none")
        begin
            //am29dl322d_prot  sector protect file
            //   //      - comment
            //   @sec    - <sec> stands for sector
            //             (sec is incremented at every load)
            //   d       - <d> is 1 for protected sector, 0 for unprotect.
            //   @71  - if d = 1 SecSi is factory protected
            //        - if d = 0 Secsi is customer lockable
            //   sectors are numerated for top architecture, if bottom architecture is to
            //   be used then sector 'i' stands for (secNum - i) protected sector
            //   top/bottom
            //   a0 ->a70
            //   a1 ->a69
            //   a2 ->a68


           //   If <aaa> > SecNum SecSi
           //   is protected/unprotected
           $readmemb(prot_file_name,sector_prot);
        end
        if (UserPreload && secsi_file_name != "none")
        begin

           //am29dl322d_secsi memory file
           //    /       - comment
           //    @aaaa   - <aaaa> stands for address within secSi
           //    dd      - <dd> is byte to be written at SecSi(aa++)
           //    (aaaa is incremented at every load)
           $readmemh(secsi_file_name,secure_silicon);
        end
        if (UserPreload && mem_file_name != "none")
        begin
           //am29dl322d.mem, memory preload file
           //  @aaaaaa - <aaaaaa> stands for address within Memeory
           //  dd      - <dd> is byte to be written at Mem(aaaa++)
           // (aaaa is incremented at every load)
           $readmemh(mem_file_name,sector_preload);
        end

        for (i=0;i<=1;i=i+1)
        begin
            WBData[i] = 0;
            WBAddr[i] = -1;
        end

        for (i=0;i<=SecSiSize;i=i+1)
            SecSi[i] = secure_silicon[i];

        for(j=0;j<=MemSize;j=j+1)
            Mem[j] = sector_preload[j];

        FactoryProt = sector_prot[SecNum+1];

        for (i = 0; i<= SecNum; i = i+1)
            Sec_Prot[i] = sector_prot[i];

        for (i=0; i<=SecNum; i=i+1)
            Sec_Prot[i] = Sec_Prot[GroupProtect(i)];

        if (vs == 0)
        begin
            Sec_Prot_tmp = Sec_Prot;
            for(i = 0; i <= SecNum; i = i+1)
                Sec_Prot[i] = Sec_Prot_tmp[SecNum - i];
        end
            Sec_Prot_reg0  = Sec_Prot[first_prot];
            Sec_Prot_reg1  = Sec_Prot[first_prot+1];
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

        Address             = 0;         // 0 - SecSize

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
     #(tdevice_CTMOUT - 5) CTMOUT = CTMOUT_in;
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
   always @(DIn[15])// or reseted)
    begin
        if (RESETNeg != 1'b0)
            if (BYTENeg == 1'b0)
            ADDR_event = $time;
    end

///////////////////////////////////////////
//open tristate buffers control
    always @(DOut_zd[15:0])
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
                TempData = DOut_zd[15:0];
                if(BYTENeg)
                begin
                    DOut_z[15:8] = 8'bx;
                    DOut_z[15:8] <= #(ADDRDQ_t - $time ) TempData[15:8];
                end
                DOut_z[7:0] = 8'bx;
                DOut_z[7:0] <= #(ADDRDQ_t - $time ) TempData[7:0];
            end
            else
                DOut_z[15:0] = DOut_zd[15:0];
        end
        else
        begin
            DOut_z[7:0] = DOut_zd[7:0];
            DOut_z[15:8] = DOut_zd[15:8];

            FROMCE = 0;
            FROMOE = 0;
            SWITCH = 0;
        end
    end

    reg  BuffInOE, BuffInCE, BuffInADDR, BuffInPOW, BuffInSEO ;
    reg  BuffCtrlOE, BuffCtrlCE;
    wire BuffOutOE, BuffOutCE, BuffOutADDR, BuffOutPOW, BuffOutSEO ;

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

//    //////////////////////////////////////////////////////////////////////////
//    //Latch address on falling edge of WE# or CE# what ever comes later
//    //Latches data on rising edge of WE# or CE# what ever comes first
//    // also Write cycle decode
//    //////////////////////////////////////////////////////////////////////////
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
                RestoreSectAddr(A, SA_tmp, A_tmp1, DIn[15], BYTENeg);
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
                RestoreSectAddr(A, SA_tmp, A_tmp1, DIn[15], BYTENeg);
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
                RestoreSectAddr(A, SA_tmp, A_tmp1, DIn[15], BYTENeg);
            end
            if (~OENeg_ipd)
            begin  
                SecAddr = SA_tmp;
                Address = A_tmp1;

                BA = ResolveBank(SA_tmp);
                Addr   = A_tmp;
	    end
        end
	end

   always @(A or BYTENeg)// or reseted)
	begin
        if (reseted)
            if (WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
                    -> MergeE;
	end

   always @(DIn)// or reseted)
	begin
        if (reseted)
           if (~BYTENeg && ~deg && WENeg_ipd && ~CENeg_ipd && ~OENeg_ipd)
		-> MergeE;

	end

   always @(MergeE)
   begin
                A_tmp  =  A[10:0];
                RestoreSectAddr(A, SA_tmp, A_tmp1, DIn[15], BYTENeg);
                SecAddr = SA_tmp;
                Address = A_tmp1;
                BA = ResolveBank(SA_tmp);
                Addr   = A_tmp;
   end

    always @(posedge write)
    begin
                SecAddr = SA_tmp;
                Address = A_tmp1;
                BA = ResolveBank(SA_tmp);
                Addr   = A_tmp;
    end


//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program/ Write Buffer Program Operations
//    // start/ suspend/ resume
//    //////////////////////////////////////////////////////////////////////////

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
                   (~Ers_queue[SA] || ~ESP_ACT )   &&
                   (~FactoryProt   || ~OTP_ACT ))
                begin
                    if (ULBYPASS)
                       duration_write = tdevice_POU;
                    else if (BYTENeg)
                        duration_write = tdevice_POW;
                    else
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

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    //////////////////////////////////////////////////////////////////////////
 integer cnt_erase = 0;      // 0 - SecNum
 time elapsed_erase;
 time duration_erase;
 time start_erase;
 integer bank1;
 integer bank2;

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
                bank1 = 0;
                bank2 = 0;
                if (OTP_ACT)
                begin
                    if (~FactoryProt)
                        cnt_erase = cnt_erase+1;
                end

                else
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        if ((Ers_queue[i]==1'b1) && (Sec_Prot[i]!=1'b1))
                        begin
                            cnt_erase = cnt_erase + 1;
                            if (bank1 || ResolveBank(i) == 1)
                                bank1 = 1;
                            if (bank2 || ResolveBank(i) == 2)
                                bank2 = 1;
                        end
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
                    if (DataLo==16'h90)
                        next_state = AS;
                    else if (DataLo==16'hA0)
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
                    if (BankLocked(BA_sel2, BA))
                        next_state = PGMS;
                    else
                        next_state = PREL_ULBYPASS;
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
                    else if (A_PAT_1 && (DataLo == 16'h80))
                        next_state = C8;
                    else
                        next_state = OTP;
                end
            end

            OTP_AS :
            begin
                if (~write)
                begin
                    if (DataLo==16'hF0)
                    begin
                        if (ESP_ACT)
                            next_state = ESP;
                        else
                            next_state = RESET;
                    end
                    else if (Addr == 16'h55 && DataLo == 16'h98)
                        next_state = AS_CFI;
                    else
                        next_state = OTP;
                 end
            end

            OTP_A0SEEN :
            begin
                if (~write)
                begin
                    if (OtpAddr(vs, SecAddr))
                        next_state = PGMS; //set OTP
                    else
                        next_state = OTP; //set OTP
                end
            end

            C8 :
            begin
                if (~write)
                begin
                    if (PATTERN_1)
                        next_state = C8_Z001;
                    else if (OTP_ACT)
                        next_state = OTP;
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
                    else if (OTP_ACT)
                        next_state = OTP;
                    else
                        next_state = RESET;
                end
            end

            C8_PREL :
            begin
                if (~write)
                begin
                    if (OTP_ACT)
                    begin
                        if ((DataLo==16'h30) && OtpAddr(vs, SecAddr))
                            next_state = SERS;
                        else
                            next_state = OTP;
                    end
                    else
                    begin
                        if (A_PAT_1 && (DataLo==16'h10))
                            next_state = ERS;
                        else if (DataLo==16'h30)
                            next_state = SERS;
                        else
                            next_state = RESET;
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
                        if (OTP_ACT)
                        begin
                            if ((DataLo==16'hB0) && OtpAddr(vs, SecAddr))
                                next_state = ESPS;
                            else if ((DataLo==16'h30) && OtpAddr(vs, SecAddr))
                                next_state = SERS;
                            else
                                next_state = OTP;
                        end
                        else
                        begin
                            if (DataLo == 16'hB0 && BankLockedForErs(BA))
                                next_state = ESPS; // ESP according to datasheet
                            else if (DataLo==16'h30 && BankLockedForErs(BA))
                                next_state = SERS;
                            else
                                next_state = RESET;
                        end
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
                    if (OTP_ACT)
                    begin
                        if ((DataLo==16'h30) && OtpAddr(vs, SecAddr))
                            next_state = SERS_EXEC;
                        else
                            next_state = ESP;
                    end
                    else
                    begin
                        if (ULBYPASS)
                        begin
                            if (DataLo == 16'h20)
                            begin
                            end
                            else if (A_PAT_1 && (DataLo == 16'hA0))
                                next_state = ESP_A0SEEN;
                            else if (A_PAT_1 && (DataLo == 16'h90))
                                next_state = ESP_AS;
                        end
                        else if (DataLo == 16'h30 && BankLockedForErs(BA))
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
                begin
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
              end


            ESP_A0SEEN :
            begin
                if (~write)
                begin
                    if (BankLockedForErs(BA))
                        next_state = PGMS;
                    else
                        next_state = ESP;
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
                    else
                        next_state = ESP_AS;
                end
              end

            AS_CFI :
            begin
                if (~write)
                    if (DataLo==16'hf0)
                        if (OTP_ACT == 1)
                            next_state = OTP_AS;
                        else if (ESP_ACT == 1)
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
                if (OTP_ACT)//valid only sro SERS_EXEC
                    next_state = OTP;
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
                begin
                    if (OTP_ACT)
                    begin
                        if (DataLo==16'hB0 && OtpAddr(vs, SecAddr))
                            next_state = ESPS;
                    end
                    else
                    begin
                        if (DataLo==16'hB0 && BankLockedForErs(BA))
                            next_state = ESPS;
                    end
                end
        end
    end


    always @(CTMOUT or reseted)
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
        BA_sel2 = 0;
        ResetBankForErs_All(i);
    end

    always @(posedge read)
    begin
          ->oe_event;
    end
    always @(Address or SecAddr or  BYTENeg)
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
                        if (BA_sel2 == BA)
                        begin
                            AsRead(DOut_zd);
                        end
                        else
                        begin
                            MemRead(DOut_zd);
                        end
                    end
            end

            OTP :
            begin
                if (oe)
                begin
                    //read SecSi Sector Region
                      SecSiRead(DOut_zd);
               end
            end

            OTP_AS :
            begin
                if (oe)
                    if (BA_sel2 == BA)
                        AsRead(DOut_zd);
                    else
                        SecSiRead(DOut_zd);
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
                    if (OTP_ACT)
                    begin
                        if (OtpAddr(vs, SecAddr))
                        begin
                        ///////////////////////////////////////////////////////
                        //read status - sector erase timeout
                        ///////////////////////////////////////////////////////
                            Status[3] = 1'b0;
                            DOut_zd[7:0] = Status;
                        end
                        else
                            SecSiRead(DOut_zd);
                            // HIZ is read, wrong secsi address
                    end
                    else
                    begin
                        if (BankLockedForErs(BA))
                        begin
                        ///////////////////////////////////////////////////////
                        //read status - sector erase timeout
                        ///////////////////////////////////////////////////////
                            Status[3] = 1'b0;
                            DOut_zd[7:0] = Status;
                        end
                        else
                            MemRead(DOut_zd[15:0]);
                    end
            end

            ESPS :
            begin
                if (oe)
                    if (OTP_ACT)
                    begin
                        if (OtpAddr(vs, SecAddr))
                        begin
                        ///////////////////////////////////////////////////////
                        //read status / erase suspend timeout - stil erasing
                        ///////////////////////////////////////////////////////
                        Status[7] = 1'b0;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        Status[2] = ~Status[2]; //toggle

                        DOut_zd[7:0] = Status;
                        end
                        else
                            SecSiRead(DOut_zd);
                            // HIZ is read, wrong secsi address
                    end
                    else
                    begin
                        if (BankLockedForErs(BA))
                        begin
                        ///////////////////////////////////////////////////////
                        //read status / erase suspend timeout - stil erasing
                        ///////////////////////////////////////////////////////
                        Status[7] = 1'b0;
                        Status[6] = ~Status[6]; //toggle
                        Status[5] = 1'b0;
                        Status[3] = 1'b1;
                        if ((Ers_queue[SecAddr]==1'b1) )
                            Status[2] = ~Status[2]; //toggle

                        DOut_zd[7:0] = Status;
                        end
                        else
                            MemRead(DOut_zd[15:0]);
                    end
            end

            SERS_EXEC:
            begin
                if (oe)
                    if (OTP_ACT)
                    begin
                        if (OtpAddr(vs, SecAddr))
                        begin
                            ///////////////////////////////////////////////////
                            //read status erase
                            ///////////////////////////////////////////////////
                            //%el should never hang
                            Status[7] = 1'b0;
                            Status[6] = ~Status[6]; //toggle
                            Status[5] = 1'b0;
                            Status[3] = 1'b1;
                            Status[2] = ~Status[2]; //toggle

                            DOut_zd[7:0] = Status;
                        end
                        else
                            SecSiRead(DOut_zd);
                            // HIZ is read, wrong secsi address
                    end
                    else
                    begin
                        if (BankLockedForErs(BA))
                        begin
                            ///////////////////////////////////////////////////
                            //read status erase
                            ///////////////////////////////////////////////////
                            //%el should never hang
                            Status[7] = 1'b0;
                            Status[6] = ~Status[6]; //toggle
                            Status[5] = 1'b0;
                            Status[3] = 1'b1;
                            if ((Ers_queue[SecAddr]==1'b1) )
                                Status[2] = ~Status[2]; //toggle

                            DOut_zd[7:0] = Status;
                        end
                        else
                            MemRead(DOut_zd[15:0]);
                    end
            end

            ESP :
            begin
                if (oe)
                begin
                    if (OTP_ACT)
                    begin
                        if (OtpAddr(vs, SecAddr))
                        begin
                            ///////////////////////////////////////////////////
                            //read status
                            ///////////////////////////////////////////////////
                            Status[7] = 1'b1;
                            // Status[6) No toggle
                            Status[5] = 1'b0;
                            Status[2] = ~Status[2]; //toggle

                            DOut_zd[7:0] = Status;
                        end
                        else
                            SecSiRead(DOut_zd);
                    end
                    else
                    begin
                        ///////////////////////////////////////////////////////
                        //read
                        ///////////////////////////////////////////////////////
                        if  ( Ers_queue[SecAddr]!=1'b1)
                            MemRead(DOut_zd[15:0]);
                        else
                        begin
                            ///////////////////////////////////////////////////
                            //read status
                            ///////////////////////////////////////////////////
                            Status[7] = 1'b1;
                            // Status[6) No toggle
                            Status[5] = 1'b0;
                            Status[2] = ~Status[2]; //toggle

                            DOut_zd[7:0] = Status;
                         end
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
                    begin
                        if (BA_sel2 == BA)
                            AsRead(DOut_zd);
                        else if (Ers_queue[SecAddr] != 1'b1)
                            MemRead(DOut_zd);
                        else
                        begin
                            Status[7] = 1'b1;
                            Status[5] = 1'b0;
                            Status[2] = ~Status[2]; //toggle

                            DOut_zd[7:0] = Status;
                        end
                    end
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
                    if (BA_sel2 == BA)
                    begin
                    ///////////////////////////////////////////////////////////
                    //read status
                    ///////////////////////////////////////////////////////////
                    Status[6] = ~Status[6]; //toggle
                    Status[5] = 1'b0;
                    //Status[2) no toggle
                    Status[1] = 1'b0;
                    DOut_zd[7:0] = Status;
                    end
                    else if (OTP_ACT)
                    //read SecSi Sector Region
                        SecSiRead(DOut_zd);
                    else if (ESP_ACT && (Ers_queue[SecAddr]==1'b1))
                    begin
                            Status[7] = 1'b1;
                            Status[5] = 1'b0;
                            Status[2] = ~Status[2]; //toggle

                            DOut_zd[7:0] = Status;
                     end
                    else
                        MemRead(DOut_zd[15:0]);
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
                OTP_ACT   = 1'b0;
                ESP_ACT   = 1'b0;

                if (~write)
                begin
                    if (PATTERN_1)
                    begin
                    end
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
                            BA_sel2 = BA;
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
                    if (DataLo==16'hF0)
                    begin
                    end
            end

            AS :
            begin
                if (~write)
                    if (DataLo==16'hF0)
                    begin
                        BA_sel2 = 0;
                        ULBYPASS  = 1'b0;
                    end
            end

            A0SEEN :
            begin
                if (~write)
                begin
                    if (BankLocked(BA_sel2, BA))
                    begin
                        BA_sel2 = BA;
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;

                            WBData[0] = DataLo;
                            WBData[1] = DataHi;
                        WBAddr[0] = Address;// % 32;
                        SA = SecAddr;

                        temp = DataLo;
                        Status[7] = ~temp[7];

                        if (BYTENeg)
                            WBAddr[1] = WBAddr[0] +1;
                        else
                            WBAddr[1] = -1;
                    end
                end
            end

            OTP :
            begin
                OTP_ACT = 1'b1;
                //ready signal active
                RY_zd = 1'b1;
            end

            OTP_Z001 :
            begin
            end

            OTP_PREL :
            begin
                if (~write)
                    if (A_PAT_1 && (DataLo == 16'h90))
                    begin
                        ULBYPASS = 1'b0;
                        BA_sel2 = BA;
                    end
            end

            OTP_AS :
            begin
                if (~write)
                begin
                    if (DataLo==16'hF0)
                    begin
                        OTP_ACT =1'b0;
                        BA_sel2 = 0;
                        if (ESP_ACT)
                            ULBYPASS  = 1'b0;//can not be accessed from ULBYPASS moda
                    end
                    else if (Addr == 16'h55 && DataLo == 16'h98)
                    begin
                    end
                    else
                        BA_sel2 = 0;
                end
            end

            OTP_A0SEEN :
            begin
                if (~write)
                begin
                        if (OtpAddr(vs, SecAddr))
                        begin
                            BA_sel2 = BA;
                            OTP_ACT = 1'b1;

                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;

                            WBData[0] = DataLo;
                            WBData[1] = DataHi;
                            WBAddr[0] = Address;
                            SA = SecAddr;
                            temp = DataLo;
                            Status[7] = ~temp[7];

                            if (BYTENeg)
                                WBAddr[1] = WBAddr[0] +1;
                            else
                                WBAddr[1] = -1;
                        end
                        else
                        begin
                            $display("NOTE: Invalid sector Address in SecSi");
                            BA_sel2 = 0;
                        end

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
                    if (OTP_ACT)
                    begin
                        if ((DataLo==16'h30) && OtpAddr(vs, SecAddr))
                            disable TCTMOUTr;
                            CTMOUT_in = 1'b0;
                            CTMOUT_in <= #1 1'b1;

                    end
                    else
                    begin
                        if (A_PAT_1 && (DataLo==16'h10))
                        begin
                            for(i=0; i<=BankNum; i=i+1)
                                LB_Ei[i] = i+1;
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
                            AddBankForErs(BA);
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
                        if (OTP_ACT)
                        begin
                            if ((DataLo==16'hB0) && OtpAddr(vs, SecAddr))
                            begin
                                //need to start erase process prior to suspend
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                ESUSP  = 1'b1;
                                ERES   = 1'b0;
                                //suspend timeout (should be 0 according to datasheet)
                                START_T1_in = 1'b1;///
                            end
                            else if ((DataLo==16'h30) && OtpAddr(vs, SecAddr))
                            begin
                                disable TCTMOUTr;
                                CTMOUT_in = 1'b0;
                                CTMOUT_in <= #1 1'b1;
                            end
                        end
                        else
                        begin
                            if (DataLo == 16'hB0 && BankLockedForErs(BA))
                            begin
                                //need to start erase process prior to suspend
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                ESUSP  = 1'b1;
                                ERES   = 1'b0;
                                //suspend timeout (should be 0 according to datasheet)
                                START_T1_in = 1'b1;///
                            end
                            else if (DataLo==16'h30 && BankLockedForErs(BA))
                            begin
                                //AddBankForErs(BA);
                                disable TCTMOUTr;
                                CTMOUT_in = 1'b0;
                                CTMOUT_in <= #1 1'b1;
                                Ers_queue[SecAddr] = 1'b1;
                            end
                            else
                                ResetBankForErs_All(i);
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
                    begin
                        if (OTP_ACT)
                        begin
                            if ((DataLo==16'hB0) && OtpAddr(vs, SecAddr))
                            begin
                                START_T1_in = 1'b1;
                                ESUSP  = 1'b1;
                            end
                        end
                        else
                        begin
                            if (DataLo==16'hB0 && BankLockedForErs(BA))
                            begin
                                START_T1_in = 1'b1;
                                ESUSP  = 1'b1;
                            end
                        end
                    end
                RY_zd = 1'b0;
            end

            ESP :
            begin
                if (~write)
                begin
                    if (OTP_ACT)
                    begin
                        if ((DataLo==16'h30) && OtpAddr(vs, SecAddr))
                        begin
                            ERES = 1'b1;
                            ERES <= #1 1'b0;
                        end
                    end
                    else
                    begin
                        if (DataLo == 16'h30 &&  BankLockedForErs(BA))
                        begin
                            //resume erase
                            ERES = 1'b1;
                            ERES <= #1 1'b0;
                        end
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
                    else if (A_PAT_1 && (DataLo == 16'h90))
                        BA_sel2 = BA;
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
                    if (BankLockedForErs(BA))
                    begin
                        BA_sel2 = BA;
                        ESP_ACT = 1'b1;

                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;

                        WBData[0] = DataLo;
                        WBData[1] = DataHi;
                        WBAddr[0] = Address;// % 32;

                        SA = SecAddr;

                        temp = DataLo;
                        Status[7] = ~temp[7];

                        if (BYTENeg)
                            WBAddr[1] = WBAddr[0] +1;
                        else
                            WBAddr[1] = -1;
                    end
                end
            end
                 
            ESP_AS :
            begin
                if (~write)
                    if (DataLo == 16'hF0)
                        begin
                        // resret ULBYPASS
                        ULBYPASS = 1'b0;
                        BA_sel2 = 0;
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
    		if (current_state==OTP) RY_zd = 1'b1;
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
        ResetBankForErs_All(i);
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
                if (OTP_ACT)
                begin
                    for (i=0;i<=SecSiSize;i=i+1)
                        SecSi[i] = -1;
                end
                else
                begin
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        if (Sec_Prot[i]!=1'b1 && Ers_queue[i])
                            for (j=0;j<=SecSize(i);j=j+1)
                                Mem[sa(i)+j] = -1;
                    end
                end

                if (EDONE)
                    if (OTP_ACT)
                    begin
                        for (i=0;i<=SecSiSize;i=i+1)
                            SecSi[i] = MaxData;
                    end
                    else
                    begin
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
    end

    always @(posedge PDONE or negedge PERR)
    begin: PGMS3
    if (current_state == PGMS)
        if (ULBYPASS != 1'b1)
            BA_sel2 = 0;
    end

    always @(current_state or posedge PDONE) // or PERR or PDONE)
    begin: PGMS2
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
                          old_int=Mem[sa(SA)+WBAddr[i]];
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
                        Mem[sa(SA)+WBAddr[i]] = -1;
                    else
                        SecSi[WBAddr[i]]   = -1;
                end

                if (PDONE && ~PSTART)
                for (i=wr_cnt;i>=0;i=i-1)
                    begin
                            if (OTP_ACT!=1'b1)   //mem write
                                Mem[sa(SA)+WBAddr[i]] = WBData[i];
                            else //SecSi write
                                SecSi[WBAddr[i]]   = WBData[i];

                        WBData[i]= -1;
                    end
            end
        end
    end


    always @(gOE_n or gCE_n or RESETNeg or RST or BYTENeg)
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
        if (~WPNeg)
        begin
            Sec_Prot_reg0 = Sec_Prot[first_prot];
            Sec_Prot_reg1 = Sec_Prot[first_prot+1];
            Sec_Prot[first_prot] = 1'b1;
            Sec_Prot[first_prot+1] = 1'b1;
        end
        else
            begin
            Sec_Prot[first_prot]  = Sec_Prot_reg0;
            Sec_Prot[first_prot+1]= Sec_Prot_reg1;
            end
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
            CFI_array[16'h44] = 16'h31;
            CFI_array[16'h45] = 16'h00;
            CFI_array[16'h46] = 16'h02;
            CFI_array[16'h47] = 16'h01;
            CFI_array[16'h48] = 16'h01;
            CFI_array[16'h49] = 16'h04;
            CFI_array[16'h4A] = 16'h38;
            CFI_array[16'h4B] = 16'h00;
            CFI_array[16'h4C] = 16'h00;
            CFI_array[16'h4D] = 16'h85;
            CFI_array[16'h4E] = 16'h95;
            if (vs)//top architecture
                CFI_array[16'h4F] = 16'h03;
            else
                CFI_array[16'h4F] = 16'h02;
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
    if ((vs && i >= 63) ||
        (!vs && i <= 7))
        SecSize = SecSize_s;
    else
        SecSize = SecSize_l;
end
endfunction

function integer sa;
input integer sect;
begin
    if ((vs && sect <= 62) ||
        (!vs && sect <= 7))
            sa = (SecSize(sect)+1)*sect;
    else if (vs && sect > 62)
            sa = (SecNum - BootSecNum)*(SecSize_l+1) +
                 (SecSize(sect)+1)*(sect-63);
    else if (!vs && sect > 7)
            sa = (BootSecNum+1)*(SecSize_s+1) +
                 (SecSize(sect)+1)*(sect-8);
end
endfunction

function integer ea;
input integer sect;
begin
    if ((vs && sect <= 62) ||
        (!vs && sect <= 7))
            ea = (SecSize(sect)+1)*(sect+1)-1;
    else if (vs && sect > 62)
            ea = (SecNum - BootSecNum)*(SecSize_l+1) +
                 (SecSize(sect)+1)*(sect-63+1)-1;
    else if (!vs && sect > 7)
            ea = (BootSecNum+1)*(SecSize_s+1) +
                 (SecSize(sect)+1)*(sect-8+1)-1;
end
endfunction

//RestoreSectAdde
task RestoreSectAddr;
input reg [HiAddrBit:0] A;
inout integer SecAddr;
inout integer Addr;
input reg D15;
input reg BYTENeg;
integer SA_tmp;
reg [15 : 0] A_tmp;
begin
    SA_tmp = A[HiAddrBit:15];
    if ((vs == 0 && SA_tmp == 0) ||
        (vs == 1 && SA_tmp == 63))
    begin
        SecAddr = SA_tmp + A[14:12];
        A_tmp = A[11:0];
    end
    else if (vs == 0 )
    begin
        SecAddr = SA_tmp + BootSecNum;
        A_tmp = A[14:0];
    end
    else
    begin
        SecAddr = SA_tmp;
        A_tmp = A[14:0];
    end
    if (BYTENeg == 0)
       Addr = {A_tmp, D15};
    else
       Addr = {A_tmp, 1'b0};

end
endtask

//////////
////////
//BANK FUNCTIONS
/////////////////
function integer ResolveBank;
input integer S_tmp;
begin
    if ((vs && S_tmp < 56) ||
        (!vs && S_tmp > 14))
            ResolveBank = 2;
    else if ((vs && S_tmp >= 56) ||
             (!vs && S_tmp <= 14))
            ResolveBank = 1;
end
endfunction


function integer BankLockedForErs;
input integer BA;
begin
    BankLockedForErs = 0;
    if (BA > 0)
        for (i=0; i<=BankNum; i = i+1)
            if (LB_Ei[i] == BA)
                BankLockedForErs = 1;
end
endfunction

function integer BankLocked;
input integer BA_sel2;
input integer BA;
begin
    BankLocked = 0;
    if ((BA_sel2 == BA )|| (BA_sel2 == 0))
        BankLocked = 1;
end
endfunction


task AddBankForErs;
input integer BA;
integer found;
integer i;
begin
    found = 0;

    for (i=0; i<=BankNum; i = i+1)
        if (LB_Ei[i] == BA)
            found = 1;

    i = 0;
    while ((i <= BankNum) && (found != 1))
    begin
        if (LB_Ei[i] == 0)
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
            LB_Ei[i] = 0;
end
endtask

task ResetBankForErs_All;
input integer m;
begin
    for(i=0; i<= BankNum; i=i+1)
        LB_Ei[i] = 0;
end
endtask

//////////////////////////
//PROTECT GROUP OF SECTORs
//////////////////////////
function integer GroupProtect;
input integer conv;
begin
        GroupProtect = 0;
        if (conv == 0)
            GroupProtect = conv;
        else if ((conv >= 1) && (conv <= 3))
            GroupProtect = 1;
        else if ((conv >= 4) && (conv <= 59))
            GroupProtect = 4 * ( ( conv ) / 4 );
        else if ((conv >= 28) && (conv <= 62))
            GroupProtect = 60;
        else if (conv > 62)
            GroupProtect = conv;

end
endfunction
///////////////////////
//Valid SecSi address
///////////////////////
function integer OtpAddr;
input integer vs;
input integer SecAddr;
begin
    OtpAddr = 0;
    if ((vs == 1) && (SecAddr >= 63) ||
       (vs == 0) && (SecAddr <= 7))
        OtpAddr = 1;
end
endfunction

/////////////////////////////////////
//Mem, SecSI, CFI, AS read functions
////////////////////////////////////
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

task SecSiRead;
inout [15:0] DOut_zd;
integer SecSiAddr;

begin
    if ((vs == 1 && SecAddr >= 63)
     || (vs == 0 && SecAddr <= 7))
    begin

        SecSiAddr = Address;// % (SecSiSize + 1);
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
    else
    begin
        DOut_zd[15:0] = 16'bz;
        $display ("NOTE: Wrong SecSI Address read");
    end
end
endtask

task AsRead;
inout [15:0] DOut_zd;
begin
    if (BYTENeg)
        if (Address == 2)
            DOut_zd[15:8] = 8'h22;
        else
            DOut_zd[15:8] = 0;
    else
        DOut_zd[15:8] = 8'bZ;

    if (Address == 0)
        DOut_zd[7:0] = 1;
    else if (Address == 2)
        begin
        if (vs == 1)
            DOut_zd[7:0] = 8'h55;
        else
            DOut_zd[7:0] = 8'h56;
        end
    else if (Address == 4)
        begin
            DOut_zd[7:1] = 7'b0;
            DOut_zd[0] = Sec_Prot[SecAddr];
        end
    else if (Address == 6)
        begin
            DOut_zd[7:0] = 1;
            if (FactoryProt)
                DOut_zd[7] = 1'b1;
        end
    else
    begin
        DOut_zd[15:0] = 16'bz;
        $display ("NOTE: Invalid AS address");
    end
end
endtask
task ReadCfi;
inout [15:0] DOut_zd;
begin
    DOut_zd[15:0] = 16'b0;
    if ((Addr>=MinCfiAddr)&&(Addr<=MaxCfiAddr))
     begin
        if (~BYTENeg)
             DOut_zd[15:8] = 8'bZ;
         DOut_zd[7:0] = CFI_array[Addr];
     end
     else
     begin
        DOut_zd[15:0] = 16'bz;
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

