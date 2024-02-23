//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2002 SPIKE TECHNOLOGIES INC.
//                          ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0451v.v
//
// Author       : Ashish Prabhu & Palaniappan
//
// Date         : Nov 20 2002
//
// Version      : 3.41
//
// Abstract     : This is the top level file for Verilog Behavioral timing model 
//                of Cypress cy7c0451v, 2.5M QuadPort Data Path Select Element
//
// Notes        : Third Release, Added some revised features and timings
//
// Datasheet    : Cypress cy7c0451v, 2.5M QuadPort DSE 
//                (Document No. 01-02117 Rev. **)
//
// Modification History:
// Date         By       Version     Change Description
// =============================================================================
// Dec 13 2001  ABP       0.1         Alpha Release
// Jan 29 2002  ABP       1.0         First Release
// Jan 30 2002  ABP       1.1         - Changed the path of included file
// Feb 13 2002  ABP       2.0         - Updated as per Rev.*B datasheet
// Feb 18 2002  ABP       2.1         - Timings changed as per Rev.*B[Feb 15'02]
//                                    - tCCS violations changes done as per 
//                                      customer's mail dated Feb 15'02
// Mar 20 2002  Shadab/   2.2         - Changed the realtime datatypes to real datatype.
//              Abhishek              - Changed the MRST_N from edge to level sensitive.
//                                    - Removed the hardcoded `include path.
// Mar 22 2002  Shadab /              - Modified the code and testbench to work for 
//              Abhishek  2.2           configurations viz., 64K x 40, 128K x 40 and 256K x 40
//                                      i.e.,CFG64K, CFG128K and CFG256K respectively.
// May 08 2002  CZU       2.3         - Updated X-handling for dq bus
//
// May 31 2002  SDO       2.4         - By default, turn off response file generation
//
// Jul 11 2002  JHX       2.5         - Altered Counter and Mask Readback so the Addr Bus
//										would not go undefined if the same value is read
//										for multiple clock cycles
//
// Jul 18 2002  JHX       2.6 		  - Updated Timing Parameters to current values
//										Uncommented memory contents initialization code
//                                      Changed Module and File Names from cy7c0452v to 
//    									cy7c0451v
// Sep 02 2002  PAL       3.0         - Third Release
//
// Sep 11 2002  PAL       3.1         - Updated as per the customer feedback mail dated
//                                      Sep 11'02
// Sep 21 2002  PAL       3.11        - Fix for counter Wrap Issue.
//
// Oct 10 2002  PAL       3.12        - tCCS violation changes
//                                      as per the customer feedback mail dated Oct 08'02
// Oct 15 2002  PAL       3.2         - OEb and cntintb changes
//                                      as per the customer feedback mail dated Oct 15'02
// Oct 16 2002  PAL       3.21        - cntintb changes and READYb changes
//                                      as per the customer feedback mail dated Oct 16'02
// Nov 01 2002  PAL       3.3         - tCCS/Overlapping violation changes
//                                      as per the customer feedback mails dated Oct 30'02
//                                      & Oct 31'02
// Nov 07 2002  NIS       3.31        - Negative tCCS violation changes, OE changes
//                                      as per the customer feedback mails dated Nov 05'02
//                                      & Nov 06'02
// Nov 13 2002  PAL       3.4         - tCCS/Overlapping voilation Issues
//                                      as per the customer feedback mails dated Nov 13'02
// Nov 20 2002  PAL       3.41        - tCCS/Overlapping voilation Display Issue
//                                      as per the customer feedback mails dated Nov 19'02
// ==============================================================================
//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------
// module:      cy7c0451v
//
// Description: Top level module for cy7c0451v behavioral model
//              It contains the following file
//              1. cy7c0451v_Task_model.v   - tasks and functions
//-----------------------------------------------------------------------------------------------


`timescale 1 ns/10 ps
//`define CFG32K
//`define FREQ100  

`ifdef CFG32K 
// size definitions
 `define LAST_ADR           32767         // memory size => 32K 
 `define AD_M               14            // addr MSB    => 14
 `define DT_M               39            // data MSB    => 40
 `define BT_M               3             // byte MSB    => 4
 `define AD_S               15            // addr width  => 15
 `define DT_S               40            // data width  => 40
 `define BT_S               4             // byte width  => 4
 `define UNMASK_ALL         15'hFFFF      // Unmask all bits of mask reg
`else
 `define LAST_ADR           65535         // memory size => 64K 
 `define AD_M               15            // addr MSB    => 15
 `define DT_M               39            // data MSB    => 40
 `define BT_M               3             // byte MSB    => 4
 `define AD_S               16            // addr width  => 16
 `define DT_S               40            // data width  => 40
 `define BT_S               4             // byte width  => 4
 `define UNMASK_ALL         16'hFFFF      // Unmask all bits of mask reg
`endif

// Reset definitions
`define START              1'b1               
`define STOP               1'b0

// Port names
`define port1         2'b00 
`define port2         2'b01
`define port3         2'b10 
`define port4         2'b11

// RAM array operations
`define READ               1'b1  
`define WRITE              1'b0

// Mask and counter register operations
`define NONE               4'h1              
`define MASKLD             4'h2              
`define MASKRD             4'h3              
`define CNTRST             4'h4              
`define CNTLD              4'h5              
`define CNTRD              4'h6              
`define CNTINC             4'h7              
`define CNTHLD             4'h8              
`define RETX               4'h9            

// mail box
`define MAILBOX_NONE 3'b000
`define MAILBOX_1    3'b001
`define MAILBOX_2    3'b010
`define MAILBOX_3    3'b011
`define MAILBOX_4    3'b100

module cy7c0451v (
                  ap1,         // Address input port1
                  ap2,         // Address input port2
                  ap3,         // Address input port3
                  ap4,         // Address input port4
                  ce0_np1,     // Active low chip enable input port1
                  ce0_np2,     // Active low chip enable input port2
                  ce0_np3,     // Active low chip enable input port3
                  ce0_np4,     // Active low chip enable input port4
                  ce1p1,       // Active high chip enable input port1
                  ce1p2,       // Active high chip enable input port2
                  ce1p3,       // Active high chip enable input port3
                  ce1p4,       // Active high chip enable input port4
                  cpp1,        // Clock input port1 +ve 
                  cpp2,        // Clock input port2 +ve
                  cpp3,        // Clock input port3 +ve
                  cpp4,        // Clock input port4 +ve
                  cnp1,        // Clock input port1 -ve 
                  cnp2,        // Clock input port2 -ve
                  cnp3,        // Clock input port3 -ve
                  cnp4,        // Clock input port4 -ve

                  cntrst_np1,  // Counter reset input port1
                  cntrst_np2,  // Counter reset input port2
                  cntrst_np3,  // Counter reset input port3
                  cntrst_np4,  // Counter reset input port4
                  mkld_np1,    // mask register load input port1
                  mkld_np2,    // mask register load input port2
                  mkld_np3,    // mask register load input port3
                  mkld_np4,    // mask register load input port4

                  cntld_np1,   // Counter register load input port1
                  cntld_np2,   // Counter register load input port2
                  cntld_np3,   // Counter register load input port3
                  cntld_np4,   // Counter register load input port4
                  cntinc_np1,  // Counter register incr input port1
                  cntinc_np2,  // Counter register incr input port2
                  cntinc_np3,  // Counter register incr input port3
                  cntinc_np4,  // Counter register incr input port4

                  cntrd_np1,   // Counter register read input port1
                  cntrd_np2,   // Counter register read input port2
                  cntrd_np3,   // Counter register read input port3
                  cntrd_np4,   // Counter register read input port4
                  mkrd_np1,    // mask register read input port1
                  mkrd_np2,    // mask register read input port2
                  mkrd_np3,    // mask register read input port3
                  mkrd_np4,    // mask register read input port4

                  wrp0_np1,    // counter reload control pin port1
                  wrp0_np2,    // counter reload control pin port2
                  wrp0_np3,    // counter reload control pin port3
                  wrp0_np4,    // counter reload control pin port4

                  retx_np1,    // retransmit control pin port1
                  retx_np2,    // retransmit control pin port2
                  retx_np3,    // retransmit control pin port3
                  retx_np4,    // retransmit control pin port4

                  dqp1,        // Data bus input/output port1
                  dqp2,        // Data bus input/output port2
                  dqp3,        // Data bus input/output port3
                  dqp4,        // Data bus input/output port4
                  oe_np1,      // Output enable input port1
                  oe_np2,      // Output enable input port2
                  oe_np3,      // Output enable input port3
                  oe_np4,      // Output enable input port4

                  int_np1,     // Mailbox interrupt flag output port1
                  int_np2,     // Mailbox interrupt flag output port2
                  int_np3,     // Mailbox interrupt flag output port3
                  int_np4,     // Mailbox interrupt flag output port4
                  cntint_np1,  // Counter interrupt output port1
                  cntint_np2,  // Counter interrupt output port2
                  cntint_np3,  // Counter interrupt output port3
                  cntint_np4,  // Counter interrupt output port4
                  r_w_np1,     // Read/Write Enable input port1
                  r_w_np2,     // Read/Write Enable input port2
                  r_w_np3,     // Read/Write Enable input port3
                  r_w_np4,     // Read/Write Enable input port4
                  b_np1,       // Byte select inputs 
                  b_np2,       // Byte select inputs 
                  b_np3,       // Byte select inputs 
                  b_np4,       // Byte select inputs 

                  doff_np1,    // clock referance pin port1
                  doff_np2,    // clock referance pin port2
                  doff_np3,    // clock referance pin port3
                  doff_np4,    // clock referance pin port4

                  ready_np1,   // Ready Pin gives the status of internal DLLs
                  ready_np2,   // Ready Pin gives the status of internal DLLs
                  ready_np3,   // Ready Pin gives the status of internal DLLs
                  ready_np4,   // Ready Pin gives the status of internal DLLs
                               
                  mrst_n       // Master reset input
                  );

   inout [`AD_M :0] ap1,       //Address input/output port1
                    ap2,       //Address input/output port2
                    ap3,       //Address input/output port3
                    ap4;       //Address input/output port4

   input            cpp1,      // Clock input port1 +ve 
                    cpp2,      // Clock input port2 +ve
                    cpp3,      // Clock input port3 +ve
                    cpp4,      // Clock input port4 +ve
                    cnp1,      // Clock input port1 -ve 
                    cnp2,      // Clock input port2 -ve
                    cnp3,      // Clock input port3 -ve
                    cnp4,      // Clock input port4 -ve
                    
                    ce0_np1,
                    ce0_np2,
                    ce0_np3,
                    ce0_np4,
                    ce1p1,       // Active high chip enable input 
                    ce1p2,       // Active high chip enable input 
                    ce1p3,       // Active high chip enable input 
                    ce1p4,       // Active high chip enable input 
                    cntrst_np1,  // Counter reset input 
                    cntrst_np2,  // Counter reset input 
                    cntrst_np3,  // Counter reset input 
                    cntrst_np4,  // Counter reset input 
                    mkld_np1, 
                    mkld_np2, 
                    mkld_np3, 
                    mkld_np4,
                    cntld_np1,
                    cntld_np2,
                    cntld_np3,
                    cntld_np4,
                    cntinc_np1,
                    cntinc_np2,
                    cntinc_np3,
                    cntinc_np4,
                    cntrd_np1,
                    cntrd_np2,
                    cntrd_np3,
                    cntrd_np4,
                    mkrd_np1,
                    mkrd_np2,
                    mkrd_np3,
                    mkrd_np4,
                    wrp0_np1,   
                    wrp0_np2,   
                    wrp0_np3,   
                    wrp0_np4,   
                    retx_np1, 
                    retx_np2, 
                    retx_np3, 
                    retx_np4;
   
   inout [`DT_M :0] dqp1,        // Data bus input/output 
                    dqp2,        // Data bus input/output 
                    dqp3,        // Data bus input/output 
                    dqp4;        // Data bus input/output 

   input            oe_np1,      // Output enable input 
                    oe_np2,      // Output enable input 
                    oe_np3,      // Output enable input 
                    oe_np4;      // Output enable input

   output           ready_np1,
                    ready_np2,
                    ready_np3,
                    ready_np4;
   
   output           int_np1,     // Mailbox interrupt flag output 
                    int_np2,     // Mailbox interrupt flag output 
                    int_np3,     // Mailbox interrupt flag output 
                    int_np4,     // Mailbox interrupt flag output 
                    cntint_np1,  // Counter interrupt output 
                    cntint_np2,  // Counter interrupt output 
                    cntint_np3,  // Counter interrupt output 
                    cntint_np4;  // Counter interrupt output 

   input            r_w_np1,     // Read/Write Enable input 
                    r_w_np2,     // Read/Write Enable input 
                    r_w_np3,     // Read/Write Enable input 
                    r_w_np4;     // Read/Write Enable input 

   input [`BT_M : 0] b_np1,       // Byte select inputs 
                     b_np2,       // Byte select inputs 
                     b_np3,       // Byte select inputs 
                     b_np4;       // Byte select inputs 

   input             doff_np1,
                     doff_np2,
                     doff_np3,
                     doff_np4;
   
   input             mrst_n;     // Master reset input

   //====================================================================================================
   // variables
   integer           rsp_fv;
   integer           cnt_doff1,
                     cnt_doff2,
                     cnt_doff3,
                     cnt_doff4,
                     cnt_stb_set_p1,
                     cnt_stb_set1_p1,
                     cnt_stb_set_p2,
                     cnt_stb_set1_p2,
                     cnt_stb_set_p3,
                     cnt_stb_set1_p3,
                     cnt_stb_set_p4,
                     cnt_stb_set1_p4;

   reg               doff_flag_p1,
                     doff_flag_p2,
                     doff_flag_p3,
                     doff_flag_p4,
                     ddisp_flag_p1,//ver 2.0 Palani
                     ddisp_flag_p2,
                     ddisp_flag_p3,
                     ddisp_flag_p4;

   reg               clk_stb_p1, 
                     ready_set_p1,
                     clk_stb_p2, 
                     ready_set_p2,
                     clk_stb_p3, 
                     ready_set_p3,
                     clk_stb_p4, 
                     ready_set_p4;

   reg [`DT_M : 0]   mem[0 : `LAST_ADR]; // define memory array size

   reg [`AD_M : 0]   cntp1_reg,
                     cntp2_reg,
                     cntp3_reg,
                     cntp4_reg,
                     cntp1_reg_p1,
                     cntp2_reg_p1,
                     cntp3_reg_p1,
                     cntp4_reg_p1,
                     cntp1_reg_p2,
                     cntp2_reg_p2,
                     cntp3_reg_p2,
                     cntp4_reg_p2,
                     cntp1_reg_p3,
                     cntp2_reg_p3,
                     cntp3_reg_p3,
                     cntp4_reg_p3,
                     temp_msk_p1,//ver 3.3 PAL
                     temp_msk_p2,//ver 3.3 PAL
                     temp_msk_p3,//ver 3.3 PAL
                     temp_msk_p4,//ver 3.3 PAL                 
                     mkp1_reg,   //ver 3.3 PAL
                     mkp2_reg,   //ver 3.3 PAL
                     mkp3_reg,   //ver 3.3 PAL
                     mkp4_reg,   //ver 3.3 PAL
                     cnt_p1,     //ver 3.3 PAL
                     cnt_p2,     //ver 3.3 PAL
                     cnt_p3,     //ver 3.3 PAL
                     cnt_p4;     //ver 3.3 PAL

   reg               mrstedge_flag_p1,//ver 2.0 palani
                     mrstedge_flag_p2,                          
                     mrstedge_flag_p3,
                     mrstedge_flag_p4,
                     rst_disp_flag;
                        
   reg [`BT_M : 0]   rdp1_en_p1,     // Indicates current read operation
                     rdp2_en_p1,
                     rdp3_en_p1,
                     rdp4_en_p1,
                     rdp1_en_p2,     
                     rdp2_en_p2,
                     rdp3_en_p2,
                     rdp4_en_p2,
                     rdp1_en_p3,     
                     rdp2_en_p3,
                     rdp3_en_p3,
                     rdp4_en_p3,
                     rdp1_en_p4,     
                     rdp2_en_p4,
                     rdp3_en_p4,
                     rdp4_en_p4;
   
   reg               rdp1_con_p1,//ver 3.0 PAL
                     rdp2_con_p1,//ver 3.0 PAL
                     rdp3_con_p1,//ver 3.0 PAL
                     rdp4_con_p1,//ver 3.0 PAL
                     rdp1_con_p2,//ver 3.0 PAL
                     rdp2_con_p2,//ver 3.0 PAL
                     rdp3_con_p2,//ver 3.0 PAL
                     rdp4_con_p2;//ver 3.0 PAL
   
   reg [`BT_M : 0]   wrp1_en_p1,//ver 3.0 PAL
                     wrp2_en_p1,//ver 3.0 PAL
                     wrp3_en_p1,//ver 3.0 PAL
                     wrp4_en_p1,//ver 3.0 PAL
                     wrp1_en_p2,//ver 3.0 PAL     
                     wrp2_en_p2,//ver 3.0 PAL
                     wrp3_en_p2,//ver 3.0 PAL
                     wrp4_en_p2;//ver 3.0 PAL

   reg               wrp1_flag_p1,//ver 3.0 PAL
                     wrp1_flag_p2,//ver 3.0 PAL
                     wrp2_flag_p1,//ver 3.0 PAL
                     wrp2_flag_p2,//ver 3.0 PAL
                     wrp3_flag_p1,//ver 3.0 PAL
                     wrp3_flag_p2,//ver 3.0 PAL
                     wrp4_flag_p1,//ver 3.0 PAL
                     wrp4_flag_p2;//ver 3.0 PAL
      
   reg               rdp1_tDC_p1,
                     rdp2_tDC_p1,
                     rdp3_tDC_p1,
                     rdp4_tDC_p1,
                     rdp1_tDC_p2,
                     rdp2_tDC_p2,
                     rdp3_tDC_p2,
                     rdp4_tDC_p2,
                     rdp1_tDC_p3,
                     rdp2_tDC_p3,
                     rdp3_tDC_p3,
                     rdp4_tDC_p3,
                     rdp1_tDC_p4,
                     rdp2_tDC_p4,
                     rdp3_tDC_p4,
                     rdp4_tDC_p4,
                     rdp1_tDC_p5,
                     rdp2_tDC_p5,
                     rdp3_tDC_p5,
                     rdp4_tDC_p5;

   reg               rdp1_violation_p1,//ver 3.0 PAL
                     rdp1_violation_p2,//ver 3.0 PAL
                     rdp2_violation_p1,//ver 3.0 PAL  
                     rdp2_violation_p2,//ver 3.0 PAL
                     rdp3_violation_p1,//ver 3.0 PAL
                     rdp3_violation_p2,//ver 3.0 PAL
                     rdp4_violation_p1,//ver 3.0 PAL
                     rdp4_violation_p2;//ver 3.0 PAL
   
   reg               rdp1_tAC_p1, //ver 2.0 Palani
                     rdp2_tAC_p1,
                     rdp3_tAC_p1,
                     rdp4_tAC_p1,
                     rdp1_tAC_p2,
                     rdp2_tAC_p2,
                     rdp3_tAC_p2,
                     rdp4_tAC_p2,
                     rdp1_tAC_p3,
                     rdp2_tAC_p3,
                     rdp3_tAC_p3,
                     rdp4_tAC_p3,
                     rdp1_tAC_p4,
                     rdp2_tAC_p4,
                     rdp3_tAC_p4,
                     rdp4_tAC_p4,
                     rdp1_tAC_p5,
                     rdp2_tAC_p5,
                     rdp3_tAC_p5,
                     rdp4_tAC_p5,
                     rdp1_tAC_dis,
                     rdp2_tAC_dis,
                     rdp3_tAC_dis,
                     rdp4_tAC_dis;

   reg [`DT_M : 0]   dqp1_p3,
                     dqp1_p4,
                     dqp2_p3,
                     dqp2_p4,
                     dqp3_p3,
                     dqp3_p4,                        
                     dqp4_p3,
                     dqp4_p4;

   reg [`DT_M : 0]   dqp1_w1,//ver 3.0 PAL
                     dqp1_w2,//ver 3.0 PAL
                     dqp2_w1,//ver 3.0 PAL
                     dqp2_w2,//ver 3.0 PAL
                     dqp3_w1,//ver 3.0 PAL
                     dqp3_w2,//ver 3.0 PAL
                     dqp4_w1,//ver 3.0 PAL
                     dqp4_w2;//ver 3.0 PAL
   
   reg               msk_disable_p1,
                     msk_disable_p2,
                     msk_disable_p3,
                     msk_disable_p4,
                     mkp1_rd_en_p1,
                     mkp1_rd_en_p2,
                     mkp1_rd_en_p3,
                     mkp1_rd_en_p4,
                     mkp1_rd_en_p5,//ver 3.0 PAL                     
                     mkp2_rd_en_p1,
                     mkp2_rd_en_p2,
                     mkp2_rd_en_p3,
                     mkp2_rd_en_p4,
                     mkp2_rd_en_p5,//ver 3.0 PAL                                          
                     mkp3_rd_en_p1,
                     mkp3_rd_en_p2,
                     mkp3_rd_en_p3,
                     mkp3_rd_en_p4,
                     mkp3_rd_en_p5,//ver 3.0 PAL                                          
                     mkp4_rd_en_p1,
                     mkp4_rd_en_p2,
                     mkp4_rd_en_p3,
                     mkp4_rd_en_p4,
                     mkp4_rd_en_p5,//ver 3.0 PAL 
                     mkp1_rd_con_p1,//ver 3.0 PAL
                     mkp1_rd_con_p2,//ver 3.0 PAL
                     mkp1_rd_con_p3,//ver 3.0 PAL
                     mkp1_rd_con_p4,//ver 3.0 PAL
                     mkp2_rd_con_p1,//ver 3.0 PAL
                     mkp2_rd_con_p2,//ver 3.0 PAL
                     mkp2_rd_con_p3,//ver 3.0 PAL
                     mkp2_rd_con_p4,//ver 3.0 PAL
                     mkp3_rd_con_p1,//ver 3.0 PAL
                     mkp3_rd_con_p2,//ver 3.0 PAL
                     mkp3_rd_con_p3,//ver 3.0 PAL
                     mkp3_rd_con_p4,//ver 3.0 PAL
                     mkp4_rd_con_p1,//ver 3.0 PAL
                     mkp4_rd_con_p2,//ver 3.0 PAL
                     mkp4_rd_con_p3,//ver 3.0 PAL
                     mkp4_rd_con_p4,//ver 3.0 PAL
                     mkp1_ld_en_p1,//ver 2.0 Palani
                     mkp1_ld_en_p2,
                     mkp1_ld_en_p3,
                     mkp1_ld_en_p4,
                     mkp2_ld_en_p1,
                     mkp2_ld_en_p2,
                     mkp2_ld_en_p3,
                     mkp2_ld_en_p4,
                     mkp3_ld_en_p1,
                     mkp3_ld_en_p2,
                     mkp3_ld_en_p3,
                     mkp3_ld_en_p4,
                     mkp4_ld_en_p1,
                     mkp4_ld_en_p2,
                     mkp4_ld_en_p3,
                     mkp4_ld_en_p4;
   
   reg               cnt_disable_p1,
                     cnt_disable_p2,
                     cnt_disable_p3,
                     cnt_disable_p4,
                     cntp1_rd_con_p1,//ver 3.0 PAL
                     cntp1_rd_con_p2,//ver 3.0 PAL
                     cntp1_rd_con_p3,//ver 3.0 PAL
                     cntp1_rd_con_p4,//ver 3.0 PAL
                     cntp2_rd_con_p1,//ver 3.0 PAL
                     cntp2_rd_con_p2,//ver 3.0 PAL
                     cntp2_rd_con_p3,//ver 3.0 PAL
                     cntp2_rd_con_p4,//ver 3.0 PAL
                     cntp3_rd_con_p1,//ver 3.0 PAL
                     cntp3_rd_con_p2,//ver 3.0 PAL
                     cntp3_rd_con_p3,//ver 3.0 PAL
                     cntp3_rd_con_p4,//ver 3.0 PAL
                     cntp4_rd_con_p1,//ver 3.0 PAL
                     cntp4_rd_con_p2,//ver 3.0 PAL
                     cntp4_rd_con_p3,//ver 3.0 PAL
                     cntp4_rd_con_p4,//ver 3.0 PAL                     
                     cntp1_rd_en_p1,
                     cntp1_rd_en_p2,
                     cntp1_rd_en_p3,
                     cntp1_rd_en_p4,
                     cntp1_rd_en_p5,//ver 3.0 PAL                             
                     cntp2_rd_en_p1,
                     cntp2_rd_en_p2,
                     cntp2_rd_en_p3,
                     cntp2_rd_en_p4,
                     cntp2_rd_en_p5,//ver 3.0 PAL                                          
                     cntp3_rd_en_p1,
                     cntp3_rd_en_p2,
                     cntp3_rd_en_p3,
                     cntp3_rd_en_p4,
                     cntp3_rd_en_p5,//ver 3.0 PAL                                          
                     cntp4_rd_en_p1,
                     cntp4_rd_en_p2,
                     cntp4_rd_en_p3,
                     cntp4_rd_en_p4,
                     cntp4_rd_en_p5;//ver 3.0 PAL                  
   
   reg [`AD_M : 0]   mkp1_rdbk_p4, 
                     mkp1_rdbk_p3, 
                     mkp1_rdbk_p2, 
                     mkp1_rdbk_p1,
                     mkp2_rdbk_p4, 
                     mkp2_rdbk_p3, 
                     mkp2_rdbk_p2, 
                     mkp2_rdbk_p1,
                     mkp3_rdbk_p4, 
                     mkp3_rdbk_p3, 
                     mkp3_rdbk_p2, 
                     mkp3_rdbk_p1,
                     mkp4_rdbk_p4, 
                     mkp4_rdbk_p3, 
                     mkp4_rdbk_p2, 
                     mkp4_rdbk_p1;
   
   reg [`AD_M : 0]   cntp1_rdbk_p1,
                     cntp1_rdbk_p2,
                     cntp1_rdbk_p3,
                     cntp1_rdbk_p4,
                     cntp2_rdbk_p1,
                     cntp2_rdbk_p2,
                     cntp2_rdbk_p3,
                     cntp2_rdbk_p4,
                     cntp3_rdbk_p1,
                     cntp3_rdbk_p2,
                     cntp3_rdbk_p3,
                     cntp3_rdbk_p4,
                     cntp4_rdbk_p1,
                     cntp4_rdbk_p2,
                     cntp4_rdbk_p3,
                     cntp4_rdbk_p4;
   
   reg               cntintp1_en_p1,
                     cntintp2_en_p1,
                     cntintp3_en_p1,
                     cntintp4_en_p1, 
                     cntintp1_set,//ver 3.2 PAL                    
                     cntintp2_set,//ver 3.2 PAL
                     cntintp3_set,//ver 3.2 PAL
                     cntintp4_set,//ver 3.2 PAL
                     cntintp1_en_p2,//ver 3.0 PAL                                          
                     cntintp2_en_p2,//ver 3.0 PAL                     
                     cntintp3_en_p2,//ver 3.0 PAL
                     cntintp4_en_p2;//ver 3.0 PAL

   reg               mirrorp1_loaded_en,
                     mirrorp2_loaded_en,
                     mirrorp3_loaded_en,
                     mirrorp4_loaded_en,
                     mirrorp1_load,//ver 3.11 PAL
                     mirrorp2_load,//ver 3.11 PAL
                     mirrorp3_load,//ver 3.11 PAL
                     mirrorp4_load;//ver 3.11 PAL
   
   integer           no_of_mask_p1,no_of_mask_p2,no_of_mask_p3,no_of_mask_p4,//ver 3.3 PAL
                     k1,k2,k3,k4;                                            //ver 3.3 PAL

   reg [3:0]         opernp1_type,
                     opernp2_type,
                     opernp3_type,
                     opernp4_type,
                     opernp1_type_p1,//ver 3.2 PAL
                     opernp2_type_p1,//ver 3.2 PAL
                     opernp3_type_p1,//ver 3.2 PAL
                     opernp4_type_p1;//ver 3.2 PAL

   reg [`AD_M : 0]   mirrorp1_reg,
                     mirrorp2_reg,
                     mirrorp3_reg,
                     mirrorp4_reg;
   
   reg [2:0]         debug;
   reg               DmsgOn,
                     XmsgOn,
                     TmsgOn;

   reg               setup_hold_chk;

   reg               tRS_f;
   reg               reset_over;

   reg               oep1_int,   // internal pin for oe low to high transition
                     oep2_int,   // internal pin for oe low to high transition
                     oep3_int,   // internal pin for oe low to high transition
                     oep4_int,   // internal pin for oe low to high transition
                     tOEp1_int,  // internal pin for to avoid old data out by oe low in read operation
                     tOEp2_int,  // internal pin for to avoid old data out by oe low in read operation
                     tOEp3_int,  // internal pin for to avoid old data out by oe low in read operation
                     tOEp4_int;  // internal pin for to avoid old data out by oe low in read operation

   reg               last_opernp1_p1,
                     last_opernp1_p2,
                     last_opernp1_p3,
                     last_opernp1_p4,
                     last_opernp2_p1,
                     last_opernp2_p2,
                     last_opernp2_p3,
                     last_opernp2_p4,
                     last_opernp3_p1,
                     last_opernp3_p2,
                     last_opernp3_p3,
                     last_opernp3_p4,
                     last_opernp4_p1,
                     last_opernp4_p2,
                     last_opernp4_p3,
                     last_opernp4_p4;

   reg               last_access_type_p1,//ver 3.3 PAL
                     last_access_type_p2,//ver 3.3 PAL
                     last_access_type_p3,//ver 3.3 PAL
                     last_access_type_p4;//ver 3.3 PAL

   reg [`AD_M : 0]   last_addr_p1,       //ver 3.3 PAL
                     last_addr_p2,       //ver 3.3 PAL
                     last_addr_p3,       //ver 3.3 PAL
                     last_addr_p4;       //ver 3.3 PAL
   
   reg [1:0]         last_port;//ver 3.12 PAL
   reg [`AD_M : 0]   temp_reg1,//ver 3.3 PAL
                     temp_reg2,//ver 3.3 PAL
                     temp_reg3,//ver 3.3 PAL
                     temp_reg4,//ver 3.3 PAL
                     tempA_reg1,
                     tempA_reg2,
                     tempA_reg3,
                     tempA_reg4;
   
   reg [`DT_M : 0]   tempD_reg1_p1,//ver 3.3 PAL
                     tempD_reg2_p1,//ver 3.3 PAL
                     tempD_reg1_p2,//ver 3.3 PAL
                     tempD_reg2_p2,//ver 3.3 PAL
                     tempD_reg1_p3,//ver 3.3 PAL
                     tempD_reg2_p3,//ver 3.3 PAL
                     tempD_reg1_p4,//ver 3.3 PAL
                     tempD_reg2_p4;//ver 3.3 PAL

   reg               no_use,
                     unknown_cntint_p1,//ver 3.3 PAL
                     unknown_cntint_p2,//ver 3.3 PAL
                     unknown_cntint_p3,//ver 3.3 PAL
                     unknown_cntint_p4;//ver 3.3 PAL

   // Registers for Output ports
   reg [`AD_M :0]    ap1_r,ap2_r,ap3_r,ap4_r;
   reg [`DT_M :0]    dqp1_r,dqp2_r,dqp3_r,dqp4_r;

   reg               int_np1,
                     int_np2,
                     int_np3,
                     int_np4,
                     cntint_np1,
                     cntint_np2,
                     cntint_np3,
                     cntint_np4,
                     ready_np1,
                     ready_np2,
                     ready_np3,
                     ready_np4;

   // Timing violation check variables
   //changed realtime to real by shadab Rel 2.2
   real              tRS_chk;
   real              tCCS_chk;
   real              tCCS_chk_w1,
                     tCCS_chk_w2,
                     tCCS_chk_w3,
                     tCCS_chk_w4;
   real              tOEp1_over_chk,          tOEp2_over_chk,
                     tOEp3_over_chk,          tOEp4_over_chk;
   real              oep1_pulse_chk,          oep2_pulse_chk,
                     oep3_pulse_chk,          oep4_pulse_chk;
   
   real              rising_edge_clk_p1,      rising_edge_clk_p2,
                     rising_edge_clk_p3,      rising_edge_clk_p4;
   real              falling_edge_clk_p1,     falling_edge_clk_p2,
                     falling_edge_clk_p3,     falling_edge_clk_p4;
   real              addr_last_change_p1,     addr_last_change_p2,
                     addr_last_change_p3,     addr_last_change_p4;
   real              byte_sel_last_change_p1, byte_sel_last_change_p2,
                     byte_sel_last_change_p3, byte_sel_last_change_p4;
   real              ce0_last_change_p1,      ce0_last_change_p2,
                     ce0_last_change_p3,      ce0_last_change_p4;
   real              ce1_last_change_p1,      ce1_last_change_p2,
                     ce1_last_change_p3,      ce1_last_change_p4;
   real              rw_last_change_p1,       rw_last_change_p2,
                     rw_last_change_p3,       rw_last_change_p4;
   real              dq_last_change_p1,       dq_last_change_p2,
                     dq_last_change_p3,       dq_last_change_p4;
   real              cntrst_last_change_p1,   cntrst_last_change_p2,
                     cntrst_last_change_p3,   cntrst_last_change_p4;
   real              cntinc_last_change_p1,  cntinc_last_change_p2,
                     cntinc_last_change_p3,  cntinc_last_change_p4;
   real              cntrd_last_change_p1,  cntrd_last_change_p2,
                     cntrd_last_change_p3,  cntrd_last_change_p4;
   real              cntld_last_change_p1,  cntld_last_change_p2,
                     cntld_last_change_p3,  cntld_last_change_p4;
   real              mkld_last_change_p1,  mkld_last_change_p2,
                     mkld_last_change_p3,  mkld_last_change_p4;
   real              mkrd_last_change_p1,  mkrd_last_change_p2,
                     mkrd_last_change_p3,  mkrd_last_change_p4;
   real              wrp0_nlast_change_p1,  wrp0_nlast_change_p2,
                     wrp0_nlast_change_p3,  wrp0_nlast_change_p4;
   real              retx_last_change_p1,  retx_last_change_p2,
                     retx_last_change_p3,  retx_last_change_p4;
   real              rising_edge_mrst,       falling_edge_mrst;

   real              rising_edge_doff_np1,      falling_edge_doff_np1;//ver 3.0 PAL
   real              rising_edge_doff_np2,      falling_edge_doff_np2;//ver 3.0 PAL
   real              rising_edge_doff_np3,      falling_edge_doff_np3;//ver 3.0 PAL
   real              rising_edge_doff_np4,      falling_edge_doff_np4;//ver 3.0 PAL   
   
   real              tDC_DLL_p1, //ver 2.0 palani
                     tCD_DLL_p1,
                     tDC_DLL_p2,
                     tCD_DLL_p2,
                     tDC_DLL_p3,
                     tCD_DLL_p3,
                     tDC_DLL_p4,
                     tCD_DLL_p4,
                     tCKLZ_DLL_p1,
                     tCKHZ_min_DLL_p1,
                     tCKHZ_max_DLL_p1,                     
                     tCKLZ_DLL_p2,
                     tCKHZ_min_DLL_p2,
                     tCKHZ_max_DLL_p2,
                     tCKLZ_DLL_p3,
                     tCKHZ_min_DLL_p3,
                     tCKHZ_max_DLL_p3,                     
                     tCKLZ_DLL_p4,
                     tCKHZ_min_DLL_p4,                     
                     tCKHZ_max_DLL_p4;
   
   reg               mrst_n_event,
                     dqp1_event, dqp2_event,
                     dqp3_event, dqp4_event,
                     clkp1_event, clkp2_event,
                     clkp3_event, clkp4_event,
                     ap1_event, ap2_event,
                     ap3_event, ap4_event,
                     ce0_np1_event, ce0_np2_event,
                     ce0_np3_event, ce0_np4_event,
                     ce1p1_event, ce1p2_event,
                     ce1p3_event, ce1p4_event,
                     cntrst_np1_event, cntrst_np2_event,
                     cntrst_np3_event, cntrst_np4_event,
                     cnt_mk_np1_event, cnt_mk_np2_event,
                     cnt_mk_np3_event, cnt_mk_np4_event,
                     oe_np1_event, oe_np2_event,
                     oe_np3_event, oe_np4_event,
                     r_w_np1_event, r_w_np2_event,
                     r_w_np3_event, r_w_np4_event,
                     doff_np1_event,doff_np2_event,//ver 3.0 PAL
                     doff_np3_event,doff_np4_event,//ver 3.0 PAL
                     doff_event_p1,doff_event_p2,//ver 3.0 PAL
                     doff_event_p3,doff_event_p4,//ver 3.0 PAL
                     doff_np1_pos_event,doff_np2_pos_event,//ver 3.0 PAL
                     doff_np3_pos_event,doff_np4_pos_event;//ver 3.0 PAL
   
   reg [`BT_M : 0]   b_np1_event, b_np2_event,
                     b_np3_event, b_np4_event;
   
   reg               retx_np1_event,    // retransmit control pin port1
                     retx_np2_event,    // retransmit control pin port2
                     retx_np3_event,    // retransmit control pin port3
                     retx_np4_event;
   reg               cntld_np1_event,
                     cntld_np2_event,
                     cntld_np3_event,
                     cntld_np4_event;
   reg               cntrd_np1_event,
                     cntrd_np2_event,
                     cntrd_np3_event,
                     cntrd_np4_event;
   reg               mkld_np1_event,
                     mkld_np2_event,
                     mkld_np3_event,
                     mkld_np4_event;
   reg               mkrd_np1_event,
                     mkrd_np2_event,
                     mkrd_np3_event,
                     mkrd_np4_event;

   reg               cntinc_np1_event,
                     cntinc_np2_event,
                     cntinc_np3_event,
                     cntinc_np4_event;

   reg               oep1_int_event,
                     oep2_int_event,
                     oep3_int_event,
                     oep4_int_event,
                     tOEp1_int_event,
                     tOEp2_int_event,
                     tOEp3_int_event,
                     tOEp4_int_event;
   reg               wrp0_nnp1_event,wrp0_nnp2_event,
                     wrp0_nnp3_event,wrp0_nnp4_event;

   reg               mrst_n_pv;

   reg               doff_np1_event_pv;//ver 3.0 PAL
   reg               doff_np2_event_pv;//ver 3.0 PAL
   reg               doff_np3_event_pv;//ver 3.0 PAL
   reg               doff_np4_event_pv;//ver 3.0 PAL
   reg               doff_p1_pv;//ver 3.0 PAL
   reg               doff_p2_pv;//ver 3.0 PAL
   reg               doff_p3_pv;//ver 3.0 PAL
   reg               doff_p4_pv;//ver 3.0 PAL

   reg               negp1_flag;//ver 3.0 PAL
   reg               negp2_flag;//ver 3.0 PAL
   reg               negp3_flag;//ver 3.0 PAL
   reg               negp4_flag;//ver 3.0 PAL
   reg               posp1_flag;//ver 3.0 PAL
   reg               posp2_flag;//ver 3.0 PAL
   reg               posp3_flag;//ver 3.0 PAL
   reg               posp4_flag;//ver 3.0 PAL
   
   reg               retx_np1_pv,    // retransmit control pin port1
                     retx_np2_pv,    // retransmit control pin port2
                     retx_np3_pv,    // retransmit control pin port3
                     retx_np4_pv;
   reg               cntld_np1_pv,
                     cntld_np2_pv,
                     cntld_np3_pv,
                     cntld_np4_pv;
   reg               cntrd_np1_pv,
                     cntrd_np2_pv,
                     cntrd_np3_pv,
                     cntrd_np4_pv;
   reg               mk_ldp1_pv,
                     mk_ldp2_pv,
                     mk_ldp3_pv,
                     mk_ldp4_pv;
   reg               mkrd_np1_pv,
                     mkrd_np2_pv,
                     mkrd_np3_pv,
                     mkrd_np4_pv;

   reg               cntinc_np1_pv,
                     cntinc_np2_pv,
                     cntinc_np3_pv,
                     cntinc_np4_pv;
   
   reg [`DT_M:0]     dqp1_pv, dqp3_pv,
                     dqp2_pv, dqp4_pv;
   reg               clkp1_pv, clkp2_pv,
                     clkp3_pv, clkp4_pv;
   reg [`AD_M:0]     ap1_pv, ap3_pv,
                     ap2_pv, ap4_pv;
   reg               ce0_np1_pv, ce0_np3_pv,
                     ce0_np2_pv, ce0_np4_pv;
   reg               ce1p1_pv, ce1p3_pv,
                     ce1p2_pv, ce1p4_pv;
   reg               cntrst_np1_pv, cntrst_np3_pv,
                     cntrst_np2_pv, cntrst_np4_pv;
   reg               cnt_mk_np1_pv, cnt_mk_np3_pv,
                     cnt_mk_np2_pv, cnt_mk_np4_pv;
   reg               mkld_np1_pv,mkld_np2_pv,
                     mkld_np3_pv,mkld_np4_pv;
   reg               wrp0_np1_pv,wrp0_np2_pv,
                     wrp0_np3_pv,wrp0_np4_pv;
   
   reg               oe_np1_pv, oe_np3_pv,
                     oe_np2_pv, oe_np4_pv;
   reg               r_w_np1_pv, r_w_np3_pv,
                     r_w_np2_pv, r_w_np4_pv;
   reg [`BT_M:0]     b_np1_pv,
                     b_np2_pv,
                     b_np3_pv,
                     b_np4_pv;
   
   reg               oep1_int_pv,
                     oep2_int_pv,
                     oep3_int_pv,
                     oep4_int_pv,
                     tOEp1_int_pv,
                     tOEp2_int_pv,
                     tOEp3_int_pv,
                     tOEp4_int_pv;

   integer           i;
   integer           j;
   reg               temp_f1,temp_f2,temp_f3,temp_f4;//ver 3.3 PAL

   reg               mailintp1_en_p1,
                     mailintp1_en_p2,
                     mailintp2_en_p1,
                     mailintp2_en_p2,
                     mailintp3_en_p1,
                     mailintp3_en_p2,
                     mailintp4_en_p1,
                     mailintp4_en_p2;

   reg [2:0]         mailbox1_by,
                     mailbox2_by,
                     mailbox3_by,
                     mailbox4_by;

   reg               cnthldp1_en_p1,
                     cnthldp1_en_p2,
                     cnthldp1_en_p3,
                     cnthldp1_en_p4,
                     cnthldp2_en_p1,
                     cnthldp2_en_p2,
                     cnthldp2_en_p3,
                     cnthldp2_en_p4,
                     cnthldp3_en_p1,
                     cnthldp3_en_p2,
                     cnthldp3_en_p3,
                     cnthldp3_en_p4,
                     cnthldp4_en_p1,
                     cnthldp4_en_p2,
                     cnthldp4_en_p3,
                     cnthldp4_en_p4;

   reg               tOHZ_overp1_f, 
                     tOHZ_overp2_f,
                     tOHZ_overp3_f, 
                     tOHZ_overp4_f;	
					 
   reg               p1_2,p1_3,p1_4,//ver 3.41 PAL
                     p2_1,p2_3,p2_4,//ver 3.41 PAL
                     p3_1,p3_2,p3_4,//ver 3.41 PAL
                     p4_1,p4_2,p4_3;//ver 3.41 PAL
       
   reg               p1_2_w,p1_3_w,p1_4_w,//ver 3.41 PAL
                     p2_1_w,p2_3_w,p2_4_w,//ver 3.41 PAL
                     p3_1_w,p3_2_w,p3_4_w,//ver 3.41 PAL
                     p4_1_w,p4_2_w,p4_3_w;//ver 3.41 PAL
       
   reg               cypress_rsp;  // ver 2.4 SDO 
   
   //================================================================================================
   //Timing Parameters //ver 2.0 palani
   // Timing Parameters updated - ver 2.6 JHX 
`ifdef ZERODELAY
   parameter         fMAX       = 167; // Maximum operating frequency of clock
   parameter         tCYC       = 6.0; // C Clock cycle time
   parameter         tCH        = 2.7; // C Clock high time 
   parameter         tCL        = 2.7; // C Clock low time
   parameter         tr         = 0.6; // C Clock rise time 
   parameter         tf         = 0.6; // C Clock fall time
   parameter         tSD        = 0.0; // Input Data setup time
   parameter         tHD        = 0.0; // Input Data hold time
   parameter         tSA        = 0.0; // Address setup time
   parameter         tHA        = 0.0; // Address hold time
   parameter         tSB        = 0.0; // Byte select setup time
   parameter         tHB        = 0.0; // Byte select hold time
   parameter         tSC        = 0.0; // port enable setup time
   parameter         tHC        = 0.0; // port enable hold time
   parameter         tSW        = 0.0; // R/W Setup time
   parameter         tHW        = 0.0; // R/W Hold time
   parameter         tSCLD      = 0.0; // CNTLD Set-Up time
   parameter         tHCLD      = 0.0; // CNTLD HOLD time
   parameter         tSCINC     = 0.0; // CNTINC Set-Up time
   parameter         tHCINC     = 0.0; // CNTINC HOLD time
   parameter         tSCRD      = 0.0; // CNTRD Set-Up time
   parameter         tHCRD      = 0.0; // CNTRD HOLD time
   parameter         tSRST      = 0.0; // CNTRST Setup time
   parameter         tHRST      = 0.0; // CNTRST Hold time
   parameter         tSMLD      = 0.0; // MKD Setup time
   parameter         tHMLD      = 0.0; // MKD Hold time
   parameter         tSMRD      = 0.0; // MKRD Setup time
   parameter         tHMRD      = 0.0; // MKRD Hold time
   parameter         tSWRP      = 0.0; // WRP0 Setup time
   parameter         tHWRP      = 0.0; // WRP0 Hold time
   parameter         tSRT       = 0.0; // /RETX Setup time
   parameter         tHRT       = 0.0; // /RETX Hold time
   parameter         tOE        = 0.0; // Output Enable to data valid
   parameter         tOLZ       = 0.0; // OE to Low Z
   parameter         tOHZ_min   = 0.0; // OE to High Z
   parameter         tOHZ_max   = 0.0; // OE to High Z   
   parameter         tCD        = 0.0; // Clock to DQ valid
   parameter         tCD2       = 0.0; // Clock to DQ valid with DOFF# = 0
   parameter         tCA        = 0.0; // clock to counter address readback valid
   parameter         tAC        = 0.0; // addr o/p hold after clock 
   parameter         tCM        = 0.0; // clock to mask register readback valid
   parameter         tDC        = 0.0; // DQ/A output hold after clock High
   parameter         tDC2       = 0.0; // DQ/A output hold after clock High with DOFF# = 0
   parameter         tCKLZ      = 0.0; // Clock high to DQ/A output Low Z
   parameter         tCKHZ_min  = 0.0; // Clock high to DQ/A output High Z
   parameter         tCKHZ_max  = 0.0; // Clock high to DQ/A output High Z
   parameter         tCKLZ2     = 0.0; // Clock high to DQ/A output Low Z with DOFF# = 0
   parameter         tCKHZ2_min = 0.0; // Clock high to DQ/A output High Z With DOFF# = 0
   parameter         tCKHZ2_max = 0.0; // Clock high to DQ/A output High Z With DOFF# = 0
   parameter         tCKLZA     = 0.0; // Clock high to A output Low Z
   parameter         tCKHZA_min = 0.0; // Clock high to A output High Z
   parameter         tCKHZA_max = 0.0; // Clock high to A output High Z   
   parameter         tCCS       = 5.8; // Clock to Clock setup time
   parameter         tSCINT     = 0.0; // Clock to CNTINT low
   parameter         tRCINT     = 0.0; // Clock to CNTINT high
   parameter         tSINT      = 0.0; // Clock to INT low
   parameter         tRINT      = 0.0; // Clock to INT high
   parameter         tRS        = 24.0; // Master Reset Pulse width
   parameter         tRSR       = 18.0; // master reset recovery time
   parameter         tRSF       = 0.0; // Master reset to Output inactive /HiZ
`else // !ifdef ZERODELAY
 `ifdef FREQ133
   parameter         fMAX       = 133; // Maximum operating frequency of clock
   parameter         tCYC       = 7.5; // C Clock cycle time
   parameter         tCH        = 3.4; // C Clock high time 
   parameter         tCL        = 3.4; // C Clock low time
   parameter         tr         = 0.6; // C Clock rise time 
   parameter         tf         = 0.6; // C Clock fall time
   parameter         tSD        = 2.3; // Input Data setup time
   parameter         tHD        = 0.7; // Input Data hold time
   parameter         tSA        = 2.3; // Address setup time
   parameter         tHA        = 0.7; // Address hold time
   parameter         tSB        = 2.3; // Byte select setup time
   parameter         tHB        = 0.7; // Byte select hold time
   parameter         tSC        = 2.3; // port enable setup time
   parameter         tHC        = 0.7; // port enable hold time
   parameter         tSW        = 2.3; // R/W Setup time
   parameter         tHW        = 0.7; // R/W Hold time
   parameter         tSCLD      = 2.3; // CNTLD Set-Up time
   parameter         tHCLD      = 0.7; // CNTLD HOLD time
   parameter         tSCINC     = 2.3; // CNTINC Set-Up time
   parameter         tHCINC     = 0.7; // CNTINC HOLD time
   parameter         tSCRD      = 2.3; // CNTRD Set-Up time
   parameter         tHCRD      = 0.7; // CNTRD HOLD time
   parameter         tSRST      = 2.3; // CNTRST Setup time
   parameter         tHRST      = 0.7; // CNTRST Hold time
   parameter         tSMLD      = 2.3; // MKD Setup time
   parameter         tHMLD      = 0.7; // MKD Hold time
   parameter         tSMRD      = 2.3; // MKRD Setup time
   parameter         tHMRD      = 0.7; // MKRD Hold time
   parameter         tSWRP      = 2.3; // WRP0 Setup time
   parameter         tHWRP      = 0.7; // WRP0 Hold time
   parameter         tSRT       = 2.3; // RETX Setup time
   parameter         tHRT       = 0.7; // RETX Hold time
   parameter         tOE        = 6.5; // Output Enable to data valid
   parameter         tOLZ       = 1.0; // OE to Low Z
   parameter         tOHZ_min   = 1.0; // OE to High Z
   parameter         tOHZ_max   = 5.5; // OE to High Z   
   parameter         tCD        = 4.0; // Clock to DQ valid
   parameter         tCD2       = 6.0; // Clock to DQ valid with DOFF# = 0
   parameter         tCA        = 7.5; // clock to counter address readback valid
   parameter         tAC        = 1.0; // addr o/p hold after clock 
   parameter         tCM        = 7.5; // clock to mask register readback valid
   parameter         tDC        = 1.0; // DQ/A output hold after clock High with DLL
   parameter         tDC2       = 1.0; // DQ/A output hold after clock High DOFF# = 0
   parameter         tCKLZ      = 1.0; // Clock high to DQ/A output Low Z
   parameter         tCKHZ_min  = 1.0; // Clock high to DQ/A output High Z
   parameter         tCKHZ_max  = 4.0; // Clock high to DQ/A output High Z   
   parameter         tCKLZ2     = 1.0; // Clock high to DQ/A output Low Z With DOFF# = 0
   parameter         tCKHZ2_min = 1.0; // Clock high to DQ/A output High Z With DOFF# = 0
   parameter         tCKHZ2_max = 6.0; // Clock high to DQ/A output High Z With DOFF# = 0   
   parameter         tCKLZA     = 1.0; // Clock high to A output Low Z
   parameter         tCKHZA_min = 1.0; // Clock high to A output High Z
   parameter         tCKHZA_max = 7.5; // Clock high to A output High Z   
   parameter         tCCS       = 6.5; // Clock to Clock setup time
   parameter         tSCINT     = 6.0; // Clock to CNTINT low
   parameter         tRCINT     = 6.0; // Clock to CNTINT high
   parameter         tSINT      = 9.0; // Clock to INT low
   parameter         tRINT      = 9.0; // Clock to INT high
   parameter         tRS        = 30.0;// Master Reset Pulse width
   parameter         tRSR       = 22.5;// master reset recovery time
   parameter         tRSF       = 22.5; // Master reset to Output inactive /HiZ
 `else // !ifdef FREQ133
  `ifdef FREQ100
   parameter         fMAX       = 100; // Maximum operating frequency of clock
   parameter         tCYC       = 10.0; // C Clock cycle time
   parameter         tCH        = 4.0; // C Clock high time 
   parameter         tCL        = 4.0; // C Clock low time
   parameter         tr         = 0.6; // C Clock rise time 
   parameter         tf         = 0.6; // C Clock fall time
   parameter         tSD        = 3.0; // Input Data setup time
   parameter         tHD        = 0.7; // Input Data hold time
   parameter         tSA        = 3.0; // Address setup time
   parameter         tHA        = 0.7; // Address hold time
   parameter         tSB        = 3.0; // Byte select setup time
   parameter         tHB        = 0.7; // Byte select hold time
   parameter         tSC        = 3.0; // port enable setup time
   parameter         tHC        = 0.7; // port enable hold time
   parameter         tSW        = 3.0; // R/W Setup time
   parameter         tHW        = 0.7; // R/W Hold time
   parameter         tSCLD      = 3.0; // CNTLD Set-Up time
   parameter         tHCLD      = 0.7; // CNTLD HOLD time
   parameter         tSCINC     = 3.0; // CNTINC Set-Up time
   parameter         tHCINC     = 0.7; // CNTINC HOLD time
   parameter         tSCRD      = 3.0; // CNTRD Set-Up time
   parameter         tHCRD      = 0.7; // CNTRD HOLD time
   parameter         tSRST      = 3.0; // CNTRST Setup time
   parameter         tHRST      = 0.7; // CNTRST Hold time
   parameter         tSMLD      = 3.0; // MKD Setup time
   parameter         tHMLD      = 0.7; // MKD Hold time
   parameter         tSMRD      = 3.0; // MKRD Setup time
   parameter         tHMRD      = 0.7; // MKRD Hold time
   parameter         tSWRP      = 3.0; // WRP0 Setup time
   parameter         tHWRP      = 0.7; // WRP0 Hold time
   parameter         tSRT       = 3.0; // RETX Setup time
   parameter         tHRT       = 0.7; // RETX Hold time
   parameter         tOE        = 8.5; // Output Enable to data valid
   parameter         tOLZ       = 1.0; // OE to Low Z
   parameter         tOHZ_min   = 1.0; // OE to High Z
   parameter         tOHZ_max   = 8.5; // OE to High Z   
   parameter         tCD        = 4.5; // Clock to DQ valid
   parameter         tCD2       = 7.0; // Clock to DQ valid with DOFF# = 0
   parameter         tCA        = 10.0; // clock to counter address readback valid
   parameter         tAC        = 1.0; // addr o/p hold after clock 
   parameter         tCM        = 10.0; // clock to mask register readback valid
   parameter         tDC        = 1.0; // DQ/A output hold after clock High with DLL
   parameter         tDC2       = 1.0; // DQ/A output hold after clock High DOFF# = 0
   parameter         tCKLZ      = 1.0; // Clock high to DQ/A output Low Z
   parameter         tCKHZ_min  = 1.0; // Clock high to DQ/A output High Z
   parameter         tCKHZ_max  = 4.5; // Clock high to DQ/A output High Z   
   parameter         tCKLZ2     = 1.0; // Clock high to DQ/A output Low Z With DOFF# = 0
   parameter         tCKHZ2_min = 1.0; // Clock high to DQ/A output High Z With DOFF# = 0
   parameter         tCKHZ2_max = 7.0; // Clock high to DQ/A output High Z With DOFF# = 0   
   parameter         tCKLZA     = 1.0; // Clock high to A output Low Z
   parameter         tCKHZA_min = 1.0; // Clock high to A output High Z
   parameter         tCKHZA_max = 10.0; // Clock high to A output High Z   
   parameter         tCCS       = 9.0; // Clock to Clock setup time
   parameter         tSCINT     = 7.0; // Clock to CNTINT low
   parameter         tRCINT     = 7.0; // Clock to CNTINT high
   parameter         tSINT      = 10.0; // Clock to INT low
   parameter         tRINT      = 10.0; // Clock to INT high
   parameter         tRS        = 40.0;// Master Reset Pulse width
   parameter         tRSR       = 30.0;// master reset recovery time
   parameter         tRSF       = 30.0; // Master reset to Output inactive /HiZ
  `else // !ifdef FREQ100
   parameter         fMAX       = 167;  // Maximum operating frequency of clock
   parameter         tCYC       = 6.0;  // C Clock cycle time
   parameter         tCH        = 2.7;  // C Clock high time 
   parameter         tCL        = 2.7;  // C Clock low time
   parameter         tr         = 0.6;  // C Clock rise time 
   parameter         tf         = 0.6;  // C Clock fall time
   parameter         tSD        = 1.9;  // Input Data setup time
   parameter         tHD        = 0.7;  // Input Data hold time
   parameter         tSA        = 1.9;  // Address setup time
   parameter         tHA        = 0.7;  // Address hold time
   parameter         tSB        = 1.9;  // Byte select setup time
   parameter         tHB        = 0.7;  // Byte select hold time
   parameter         tSC        = 1.9;  // port enable setup time
   parameter         tHC        = 0.7;  // port enable hold time
   parameter         tSW        = 1.9;  // R/W Setup time
   parameter         tHW        = 0.7;  // R/W Hold time
   parameter         tSCLD      = 1.9;  // CNTLD Set-Up time
   parameter         tHCLD      = 0.7;  // CNTLD HOLD time
   parameter         tSCINC     = 1.9;  // CNTINC Set-Up time
   parameter         tHCINC     = 0.7;  // CNTINC HOLD time
   parameter         tSCRD      = 1.9;  // CNTRD Set-Up time
   parameter         tHCRD      = 0.7;  // CNTRD HOLD time
   parameter         tSRST      = 1.9;  // CNTRST Setup time
   parameter         tHRST      = 0.7;  // CNTRST Hold time
   parameter         tSMLD      = 1.9;  // MKD Setup time
   parameter         tHMLD      = 0.7;  // MKD Hold time
   parameter         tSMRD      = 1.9;  // MKRD Setup time
   parameter         tHMRD      = 0.7;  // MKRD Hold time
   parameter         tSWRP      = 1.9;  // WRP0 Setup time
   parameter         tHWRP      = 0.7;  // WRP0 Hold time
   parameter         tSRT       = 1.9;  // RETX Setup time
   parameter         tHRT       = 0.7;  // RETX Hold time
   parameter         tOE        = 5.5;  // Output Enable to data valid
   parameter         tOLZ       = 1.0;  // OE to Low Z
   parameter         tOHZ_min   = 1.0;  // OE to High Z
   parameter         tOHZ_max   = 5.5;  // OE to High Z   
   parameter         tCD        = 3.5;  // Clock to DQ valid
   parameter         tCD2       = 4.7;  // Clock to DQ valid with DOFF# = 0
   parameter         tCA        = 6.0;  // clock to counter address readback valid
   parameter         tAC        = 1.0;  // addr o/p hold after clock 
   parameter         tCM        = 6.0;  // clock to mask register readback valid
   parameter         tDC        = 0.5;  // DQ/A output hold after clock High with DLL
   parameter         tDC2       = 1.0;  // DQ/A output hold after clock High DOFF# = 0
   parameter         tCKLZ      = 0.5;  // Clock high to DQ/A output Low Z
   parameter         tCKHZ_min  = 0.5;  // Clock high to DQ/A output High Z
   parameter         tCKHZ_max  = 3.5;  // Clock high to DQ/A output High Z   
   parameter         tCKLZ2     = 1.0;  // Clock high to DQ/A output Low Z With DOFF# = 0
   parameter         tCKHZ2_min = 1.0;  // Clock high to DQ/A output High Z With DOFF# = 0
   parameter         tCKHZ2_max = 4.7;  // Clock high to DQ/A output High Z With DOFF# = 0   
   parameter         tCKLZA     = 1.0;  // Clock high to A output Low Z
   parameter         tCKHZA_min = 1.0;   // Clock high to A output High Z
   parameter         tCKHZA_max = 6.0;   // Clock high to A output High Z   
   parameter         tCCS       = 5.8;  // Clock to Clock setup time
   parameter         tSCINT     = 4.7;  // Clock to CNTINT low
   parameter         tRCINT     = 4.7;  // Clock to CNTINT high
   parameter         tSINT      = 7.5;  // Clock to INT low
   parameter         tRINT      = 7.5;  // Clock to INT high
   parameter         tRS        = 24.0; // Master Reset Pulse width
   parameter         tRSR       = 18.0; // master reset recovery time
   parameter         tRSF       = 18.0;  // Master reset to Output inactive /HiZ
  `endif // !ifdef FREQ100
 `endif // !ifdef FREQ133
`endif // !ifdef ZERODELAY
   //=======================================  167  =========================================================   
`include "cy7c0451v_task_model.v" //Abhishek Rel 2.2

   //====================================================================================================
   assign            dqp1 = dqp1_r;
   assign            ap1  = ap1_r;
   assign            dqp2 = dqp2_r;
   assign            ap2  = ap2_r;
   assign            dqp3 = dqp3_r;
   assign            ap3  = ap3_r;
   assign            dqp4 = dqp4_r;
   assign            ap4  = ap4_r;
   
   initial begin
      : INIT
      $timeformat (-9, 1, " ns", 12);
	  // ver 2.6 JHX
      $readmemh("qpram_array.txt", mem); //Abhishek Rel 2.2		
	  cypress_rsp = 1'b0;  // ver 2.4 SDO 

      tOHZ_overp1_f = 1'b0; 
      tOHZ_overp2_f = 1'b0;
      tOHZ_overp3_f = 1'b0; 
      tOHZ_overp4_f = 1'b0; 
      
      rst_disp_flag = 1'b0;
      
      cntp1_reg = `AD_S'h0; //Changed from `AD_S'h00000 to `AD_S'h0 
      cntp2_reg = `AD_S'h0;
      cntp3_reg = `AD_S'h0;
      cntp4_reg = `AD_S'h0;

      cntp1_reg_p1 = `AD_S'h0;
      cntp2_reg_p1 = `AD_S'h0;
      cntp3_reg_p1 = `AD_S'h0;
      cntp4_reg_p1 = `AD_S'h0;
      cntp1_reg_p2 = `AD_S'h0;
      cntp2_reg_p2 = `AD_S'h0;
      cntp3_reg_p2 = `AD_S'h0;
      cntp4_reg_p2 = `AD_S'h0;
      cntp1_reg_p3 = `AD_S'h0;
      cntp2_reg_p3 = `AD_S'h0;
      cntp3_reg_p3 = `AD_S'h0;
      cntp4_reg_p3 = `AD_S'h0;

      mkp1_reg = `UNMASK_ALL;
      mkp2_reg = `UNMASK_ALL;
      mkp3_reg = `UNMASK_ALL;
      mkp4_reg = `UNMASK_ALL;
      
      rdp1_en_p1 = 4'b0000;
      rdp2_en_p1 = 4'b0000;
      rdp3_en_p1 = 4'b0000;
      rdp4_en_p1 = 4'b0000;
      
      rdp1_en_p2 = 4'b0000;
      rdp2_en_p2 = 4'b0000;
      rdp3_en_p2 = 4'b0000;
      rdp4_en_p2 = 4'b0000;

      rdp1_con_p1 = 1'b0;
      rdp2_con_p1 = 1'b0;
      rdp3_con_p1 = 1'b0;
      rdp4_con_p1 = 1'b0;
      rdp1_con_p2 = 1'b0;
      rdp2_con_p2 = 1'b0;
      rdp3_con_p2 = 1'b0;
      rdp4_con_p2 = 1'b0;

      rdp1_tDC_p1 = 1'b0;
      rdp2_tDC_p1 = 1'b0;
      rdp3_tDC_p1 = 1'b0;
      rdp4_tDC_p1 = 1'b0;
      rdp1_tDC_p2 = 1'b0;
      rdp2_tDC_p2 = 1'b0;
      rdp3_tDC_p2 = 1'b0;
      rdp4_tDC_p2 = 1'b0;
      rdp1_tDC_p3 = 1'b0;
      rdp2_tDC_p3 = 1'b0;
      rdp3_tDC_p3 = 1'b0;
      rdp4_tDC_p3 = 1'b0;
      rdp1_tDC_p4 = 1'b0;
      rdp2_tDC_p4 = 1'b0;
      rdp3_tDC_p4 = 1'b0;
      rdp4_tDC_p4 = 1'b0;
      rdp1_tDC_p5 = 1'b0;
      rdp2_tDC_p5 = 1'b0;
      rdp3_tDC_p5 = 1'b0;
      rdp4_tDC_p5 = 1'b0;

      rdp1_tAC_p1 = 1'b0;//ver 2.0 Palani
      rdp2_tAC_p1 = 1'b0;
      rdp3_tAC_p1 = 1'b0;
      rdp4_tAC_p1 = 1'b0;
      rdp1_tAC_p2 = 1'b0;
      rdp2_tAC_p2 = 1'b0;
      rdp3_tAC_p2 = 1'b0;
      rdp4_tAC_p2 = 1'b0;
      rdp1_tAC_p3 = 1'b0;
      rdp2_tAC_p3 = 1'b0;
      rdp3_tAC_p3 = 1'b0;
      rdp4_tAC_p3 = 1'b0;
      rdp1_tAC_p4 = 1'b0;
      rdp2_tAC_p4 = 1'b0;
      rdp3_tAC_p4 = 1'b0;
      rdp4_tAC_p4 = 1'b0;
      rdp1_tAC_p5 = 1'b0;
      rdp2_tAC_p5 = 1'b0;
      rdp3_tAC_p5 = 1'b0;
      rdp4_tAC_p5 = 1'b0;

      dqp1_p3 = `DT_S'hx;
      dqp2_p3 = `DT_S'hx;
      dqp3_p3 = `DT_S'hx;
      dqp4_p3 = `DT_S'hx;
      dqp1_p4 = `DT_S'hx;
      dqp2_p4 = `DT_S'hx;
      dqp3_p4 = `DT_S'hx;
      dqp4_p4 = `DT_S'hx;

      mkp1_rd_en_p1 = 1'b0;
      mkp1_rd_en_p2 = 1'b0;
      mkp1_rd_en_p3 = 1'b0;
      mkp1_rd_en_p4 = 1'b0;
      mkp2_rd_en_p1 = 1'b0;
      mkp2_rd_en_p2 = 1'b0;
      mkp2_rd_en_p3 = 1'b0;
      mkp2_rd_en_p4 = 1'b0;
      mkp3_rd_en_p1 = 1'b0;
      mkp3_rd_en_p2 = 1'b0;
      mkp3_rd_en_p3 = 1'b0;
      mkp3_rd_en_p4 = 1'b0;
      mkp4_rd_en_p1 = 1'b0;
      mkp4_rd_en_p2 = 1'b0;
      mkp4_rd_en_p3 = 1'b0;
      mkp4_rd_en_p4 = 1'b0;

      mkp1_rd_con_p1 = 1'b0;//ver 3.0 PAL
      mkp1_rd_con_p2 = 1'b0;//ver 3.0 PAL
      mkp1_rd_con_p3 = 1'b0;//ver 3.0 PAL
      mkp1_rd_con_p4 = 1'b0;//ver 3.0 PAL
      mkp2_rd_con_p1 = 1'b0;//ver 3.0 PAL
      mkp2_rd_con_p2 = 1'b0;//ver 3.0 PAL
      mkp2_rd_con_p3 = 1'b0;//ver 3.0 PAL
      mkp2_rd_con_p4 = 1'b0;//ver 3.0 PAL
      mkp3_rd_con_p1 = 1'b0;//ver 3.0 PAL
      mkp3_rd_con_p2 = 1'b0;//ver 3.0 PAL
      mkp3_rd_con_p3 = 1'b0;//ver 3.0 PAL
      mkp3_rd_con_p4 = 1'b0;//ver 3.0 PAL
      mkp4_rd_con_p1 = 1'b0;//ver 3.0 PAL
      mkp4_rd_con_p2 = 1'b0;//ver 3.0 PAL
      mkp4_rd_con_p3 = 1'b0;//ver 3.0 PAL
      mkp4_rd_con_p4 = 1'b0;//ver 3.0 PAL

      mkp1_ld_en_p1 = 1'b0;//ver 2.0 Palani
      mkp1_ld_en_p2 = 1'b0;
      mkp1_ld_en_p3 = 1'b0;
      mkp1_ld_en_p4 = 1'b0;
      mkp2_ld_en_p1 = 1'b0;
      mkp2_ld_en_p2 = 1'b0;
      mkp2_ld_en_p3 = 1'b0;
      mkp2_ld_en_p4 = 1'b0;
      mkp3_ld_en_p1 = 1'b0;
      mkp3_ld_en_p2 = 1'b0;
      mkp3_ld_en_p3 = 1'b0;
      mkp3_ld_en_p4 = 1'b0;
      mkp4_ld_en_p1 = 1'b0;
      mkp4_ld_en_p2 = 1'b0;
      mkp4_ld_en_p3 = 1'b0;
      mkp4_ld_en_p4 = 1'b0;
      
      cntp1_rd_en_p1 = 1'b0;
      cntp1_rd_en_p2 = 1'b0;
      cntp1_rd_en_p3 = 1'b0;
      cntp1_rd_en_p4 = 1'b0;
      cntp2_rd_en_p1 = 1'b0;
      cntp2_rd_en_p2 = 1'b0;
      cntp2_rd_en_p3 = 1'b0;
      cntp2_rd_en_p4 = 1'b0;
      cntp3_rd_en_p1 = 1'b0;
      cntp3_rd_en_p2 = 1'b0;
      cntp3_rd_en_p3 = 1'b0;
      cntp3_rd_en_p4 = 1'b0;
      cntp4_rd_en_p1 = 1'b0;
      cntp4_rd_en_p2 = 1'b0;
      cntp4_rd_en_p3 = 1'b0;
      cntp4_rd_en_p4 = 1'b0;
      
      cntp1_rd_con_p1 = 1'b0;//ver 3.0 PAL
      cntp1_rd_con_p2 = 1'b0;//ver 3.0 PAL
      cntp1_rd_con_p3 = 1'b0;//ver 3.0 PAL
      cntp1_rd_con_p4 = 1'b0;//ver 3.0 PAL
      cntp2_rd_con_p1 = 1'b0;//ver 3.0 PAL
      cntp2_rd_con_p2 = 1'b0;//ver 3.0 PAL
      cntp2_rd_con_p3 = 1'b0;//ver 3.0 PAL
      cntp2_rd_con_p4 = 1'b0;//ver 3.0 PAL
      cntp3_rd_con_p1 = 1'b0;//ver 3.0 PAL
      cntp3_rd_con_p2 = 1'b0;//ver 3.0 PAL
      cntp3_rd_con_p3 = 1'b0;//ver 3.0 PAL
      cntp3_rd_con_p4 = 1'b0;//ver 3.0 PAL
      cntp4_rd_con_p1 = 1'b0;//ver 3.0 PAL
      cntp4_rd_con_p2 = 1'b0;//ver 3.0 PAL
      cntp4_rd_con_p3 = 1'b0;//ver 3.0 PAL
      cntp4_rd_con_p4 = 1'b0;//ver 3.0 PAL

      mkp1_rdbk_p1 = `AD_S'b0;
      mkp1_rdbk_p2 = `AD_S'b0;
      mkp1_rdbk_p3 = `AD_S'b0;
      mkp1_rdbk_p4 = `AD_S'b0;
      mkp1_rd_en_p5 = 1'b0; //ver 3.0 PAL                          
      mkp2_rdbk_p1 = `AD_S'b0;
      mkp2_rdbk_p2 = `AD_S'b0;
      mkp2_rdbk_p3 = `AD_S'b0;
      mkp2_rdbk_p4 = `AD_S'b0;
      mkp2_rd_en_p5 = 1'b0;//ver 3.0 PAL                                 
      mkp3_rdbk_p1 = `AD_S'b0;
      mkp3_rdbk_p2 = `AD_S'b0;
      mkp3_rdbk_p3 = `AD_S'b0;
      mkp3_rdbk_p4 = `AD_S'b0;
      mkp3_rd_en_p5 = 1'b0;//ver 3.0 PAL                                 
      mkp4_rdbk_p1 = `AD_S'b0;
      mkp4_rdbk_p2 = `AD_S'b0;
      mkp4_rdbk_p3 = `AD_S'b0;
      mkp4_rdbk_p4 = `AD_S'b0;
      mkp4_rd_en_p5 = 1'b0;//ver 3.0 PAL                                 

      cntp1_rdbk_p1 = `AD_S'b0;
      cntp1_rdbk_p2 = `AD_S'b0;
      cntp1_rdbk_p3 = `AD_S'b0;
      cntp1_rdbk_p4 = `AD_S'b0;
      cntp1_rd_en_p5 = 1'b0;//ver 3.0 PAL                           
      cntp2_rdbk_p1 = `AD_S'b0;
      cntp2_rdbk_p2 = `AD_S'b0;
      cntp2_rdbk_p3 = `AD_S'b0;
      cntp2_rdbk_p4 = `AD_S'b0;
      cntp2_rd_en_p5 = 1'b0;//ver 3.0 PAL                                 
      cntp3_rdbk_p1 = `AD_S'b0;
      cntp3_rdbk_p2 = `AD_S'b0;
      cntp3_rdbk_p3 = `AD_S'b0;
      cntp3_rdbk_p4 = `AD_S'b0;
      cntp3_rd_en_p5 = 1'b0;//ver 3.0 PAL                                 
      cntp4_rdbk_p1 = `AD_S'b0;
      cntp4_rdbk_p2 = `AD_S'b0;
      cntp4_rdbk_p3 = `AD_S'b0;
      cntp4_rdbk_p4 = `AD_S'b0;
      cntp4_rd_en_p5 = 1'b0;//ver 3.0 PAL                     
      
      cntintp1_en_p1 = 1'b0;
      cntintp1_en_p2 = 1'b0;//ver 3.0 PAL
      cntintp2_en_p1 = 1'b0;
      cntintp3_en_p1 = 1'b0;
      cntintp4_en_p1 = 1'b0;
      cntintp2_en_p2 = 1'b0;//ver 3.0 PAL
      cntintp3_en_p2 = 1'b0;//ver 3.0 PAL
      cntintp4_en_p2 = 1'b0;//ver 3.0 PAL

      mirrorp1_loaded_en = 1'b0;
      mirrorp2_loaded_en = 1'b0;
      mirrorp3_loaded_en = 1'b0;
      mirrorp4_loaded_en = 1'b0;

      opernp1_type = `NONE;
      opernp2_type = `NONE;
      opernp3_type = `NONE;
      opernp4_type = `NONE;

      mirrorp1_reg = `AD_S'h0;
      mirrorp2_reg = `AD_S'h0;
      mirrorp3_reg = `AD_S'h0;
      mirrorp4_reg = `AD_S'h0;

      debug = 3'b110;
      TmsgOn = debug[2];
      XmsgOn = debug[1];
      DmsgOn = debug[0];

      setup_hold_chk = 0;

      tRS_f = `STOP;
      reset_over = 0;

      oep1_int = 0;
      oep2_int = 0;
      oep3_int = 0;
      oep4_int = 0;
      tOEp1_int = 0;
      tOEp2_int = 0;
      tOEp3_int = 0;
      tOEp4_int = 0;

      last_opernp1_p1 = 1'bx;   // x defines no read or write operation
      last_opernp1_p2 = 1'bx;
      last_opernp1_p3 = 1'bx;
      last_opernp1_p4 = 1'bx;
      last_opernp2_p1 = 1'bx;
      last_opernp2_p2 = 1'bx;
      last_opernp2_p3 = 1'bx;
      last_opernp2_p4 = 1'bx;
      last_opernp3_p1 = 1'bx;   // x defines no read or write operation
      last_opernp3_p2 = 1'bx;
      last_opernp3_p3 = 1'bx;
      last_opernp3_p4 = 1'bx;
      last_opernp4_p1 = 1'bx;
      last_opernp4_p2 = 1'bx;
      last_opernp4_p3 = 1'bx;
      last_opernp4_p4 = 1'bx;
      
      last_access_type_p1 = `READ;//ver 3.3 PAL
      last_access_type_p2 = `READ;//ver 3.3 PAL
      last_access_type_p3 = `READ;//ver 3.3 PAL
      last_access_type_p4 = `READ;//ver 3.3 PAL      
      
      last_addr_p1 = `AD_S'hx; // X can't be previous valid address.
      last_addr_p2 = `AD_S'hx; // X can't be previous valid address.
      last_addr_p3 = `AD_S'hx; // X can't be previous valid address.
      last_addr_p4 = `AD_S'hx; // X can't be previous valid address.      
      last_port = 2'bxx;//ver 3.12 PAL
      tempA_reg1 = `AD_S'h0;
      tempA_reg2 = `AD_S'h0;
      tempA_reg3 = `AD_S'h0;
      tempA_reg4 = `AD_S'h0;      
      tempD_reg1_p1 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg2_p1 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg1_p2 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg2_p2 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg1_p3 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg2_p3 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg1_p4 = `DT_S'h0;//ver 3.3 PAL
      tempD_reg2_p4 = `DT_S'h0;//ver 3.3 PAL
      
      ap1_r  = `AD_S'h0;
      dqp1_r = `DT_S'h0;
      ap2_r  = `AD_S'h0;
      dqp2_r = `DT_S'h0;
      ap3_r  = `AD_S'h0;
      dqp3_r = `DT_S'h0;
      ap4_r  = `AD_S'h0;
      dqp4_r = `DT_S'h0;

      cnt_doff1 = 0;
      cnt_doff2 = 0;
      cnt_doff3 = 0;
      cnt_doff4 = 0;
      doff_flag_p1 = 1'b0;
      doff_flag_p2 = 1'b0;
      doff_flag_p3 = 1'b0;
      doff_flag_p4 = 1'b0;
      ddisp_flag_p1 = 1'b0;//ver 2.0 palani
      ddisp_flag_p2 = 1'b0;
      ddisp_flag_p3 = 1'b0;
      ddisp_flag_p4 = 1'b0;
      
      cnt_stb_set_p1  = 0;
      cnt_stb_set1_p1 = 0;
      cnt_stb_set_p2  = 0;
      cnt_stb_set1_p2 = 0;
      cnt_stb_set_p3  = 0;
      cnt_stb_set1_p3 = 0;
      cnt_stb_set_p4  = 0;
      cnt_stb_set1_p4 = 0;
      
      clk_stb_p1   = 1'b0;
      ready_set_p1 = 1'b0;
      clk_stb_p2   = 1'b0;
      ready_set_p2 = 1'b0;
      clk_stb_p3   = 1'b0;
      ready_set_p3 = 1'b0;
      clk_stb_p4   = 1'b0;
      ready_set_p4 = 1'b0;
      
      int_np1 = 1;
      int_np2 = 1;
      int_np3 = 1;
      int_np4 = 1;
      cntint_np1 = 1;
      cntint_np2 = 1;
      cntint_np3 = 1;
      cntint_np4 = 1;
      ready_np1 = 1;
      ready_np2 = 1;
      ready_np3 = 1;
      ready_np4 = 1;

      tRS_chk = 0;
      tCCS_chk = 0;
      tCCS_chk_w1 = 0;
      tCCS_chk_w2 = 0;
      tCCS_chk_w3 = 0;
      tCCS_chk_w4 = 0;
      oep1_pulse_chk = 0;
      oep2_pulse_chk = 0;
      oep3_pulse_chk = 0;
      oep4_pulse_chk = 0;
      tOEp1_over_chk = 0;
      tOEp2_over_chk = 0;
      tOEp3_over_chk = 0;
      tOEp4_over_chk = 0;

      i = 0;
      j = 0;
      mailbox1_by = `MAILBOX_NONE;
      mailbox2_by = `MAILBOX_NONE;
      mailbox3_by = `MAILBOX_NONE;
      mailbox4_by = `MAILBOX_NONE;

      mailintp1_en_p1 = 0;
      mailintp1_en_p2 = 0;
      mailintp2_en_p1 = 0;
      mailintp2_en_p2 = 0;
      mailintp3_en_p1 = 0;
      mailintp3_en_p2 = 0;
      mailintp4_en_p1 = 0;
      mailintp4_en_p2 = 0;

      cnthldp1_en_p1 = 0;
      cnthldp1_en_p2 = 0;
      cnthldp1_en_p3 = 0;
      cnthldp1_en_p4 = 0;
      
      cnthldp2_en_p1 = 0;
      cnthldp2_en_p2 = 0;                       
      cnthldp2_en_p3 = 0;
      cnthldp2_en_p4 = 0;

      cnthldp3_en_p1 = 0;
      cnthldp3_en_p2 = 0;
      cnthldp3_en_p3 = 0;
      cnthldp3_en_p4 = 0;

      cnthldp4_en_p1 = 0;
      cnthldp4_en_p2 = 0;
      cnthldp4_en_p3 = 0;
      cnthldp4_en_p4 = 0;
      event_reset;
      pv_reset;
	  
	  if (cypress_rsp == 1'b1) begin  // ver 2.4 SDO
         //create a response file. using a c-shell script compare this file against gold file//
         rsp_fv = $fopen("cy7c0451v.rsp");

         $fdisplay(rsp_fv, "\t                Cypress cy7c0451v Memory Model Tests Response                                  ");
         $fdisplay(rsp_fv, "\t------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
         $fdisplay(rsp_fv, "\tTIME       M C C C ADRP1 B R O DATA_P1    C C M C M C R C I R | C C C ADRP2 B R O DATA_P2    C C M C M C R C I R | C C C ADRP3 B R O DATA_P3    C C M C M C R C I R | C C C ADRP4 B R O DATA_P4    C C M C M C R C I R |  ");
         $fdisplay(rsp_fv, "\t           R L E E       Y / E            N N A N A N E N N E | L E E       Y / E            N N A N A N E N N E | L E E       Y / E            N N A N A N E N N E | L E E       Y / E            N N A N A N E N N E |  ");
         $fdisplay(rsp_fv, "\t           S K 0 1       T W |            T T S T S T T T T A | K 0 1       T W |            T T S T S T T T T A | K 0 1       T W |            T T S T S T T T T A | K 0 1       T W |            T T S T S T T T T A |  ");
         $fdisplay(rsp_fv, "\t           T P | |       E | N            R I K R K R X I | D | P | |       E | N            R I K R K R X I | D | P | |       E | N            R I K R K R X I | D | P | |       E | N            R I K R K R X I | D |  ");
         $fdisplay(rsp_fv, "\t           | 1 N P       | N P            S N | | | | P N N Y | 2 N P       | N P            S N | | | | P N N Y | 3 N P       | N P            S N | | | | P N N Y | 4 N P       | N P            S N | | | | P N N Y |  ");
         $fdisplay(rsp_fv, "\t           N   P 1       P P 1            T C L L R R 1 T L | |   P 2       P P 2            T C L L R R 2 T L | |   P 3       P P 3            T C L L R R 3 T L | |   P 4       P P 4            T C L L R R 4 T L | |  ");
         $fdisplay(rsp_fv, "\t               1         1 1              P P D D D D   | | N |   2         2 2              P P P D D D   | | N |   3         3 3              P P D D D D   | | N |   4         4 4              P P D D D D   | | N |  ");
         $fdisplay(rsp_fv, "\t                         1                1 1 P P P P   N N P |                              2 2 P P P P   N N P |                              3 3 P P P P   N N P |                              4 4 P P P P   N N P |  ");
         $fdisplay(rsp_fv, "\t                                              1 1 1 1   P P 1 |                                  2 2 2 2   P P 2 |                                  3 3 3 3   P P 3 |                                  4 4 4 4   P P 4 |  ");
         $fdisplay(rsp_fv, "\t                                                        1 1   |                                            2 2   |                                            3 3   |                                            4 4   |  ");
         $fdisplay(rsp_fv, "\t------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
         //strobe essential
         $fmonitor(rsp_fv, "%t : %b %b %b %b %h %h %b %b %h %b %b %b %b %b %b %b %b %b %b | %b %b %b %h %h %b %b %h %b %b %b %b %b %b %b %b %b %b | %b %b %b %h %h %b %b %h %b %b %b %b %b %b %b %b %b %b | %b %b %b %h %h %b %b %h %b %b %b %b %b %b %b %b %b %b",$realtime,mrst_n,cpp1,ce0_np1,ce1p1,ap1,b_np1,r_w_np1,oe_np1,dqp1,cntrst_np1,cntinc_np1,mkld_np1,cntld_np1,mkrd_np1,cntrd_np1,retx_np1,cntint_np1,int_np1,ready_np1,cpp2,ce0_np2,ce1p2,ap2,b_np2,r_w_np2,oe_np2,dqp2,cntrst_np2,cntinc_np2,mkld_np2,cntld_np2,mkrd_np2,cntrd_np2,retx_np2,cntint_np2,int_np2,ready_np2,cpp3,ce0_np3,ce1p3,ap3,b_np3,r_w_np3,oe_np3,dqp3,cntrst_np3,cntinc_np3,mkld_np3,cntld_np3,mkrd_np3,cntrd_np3,retx_np3,cntint_np3,int_np3,ready_np3,cpp4,ce0_np4,ce1p4,ap4,b_np4,r_w_np4,oe_np4,dqp4,cntrst_np4,cntinc_np4,mkld_np4,cntld_np4,mkrd_np4,cntrd_np4,retx_np4,cntint_np4,int_np4,ready_np4);
	  end
   end // initial begin

   always @( mrst_n or cpp1 or ce0_np1 or ce1p1 or ap1  or b_np1  or r_w_np1 or oe_np1 or dqp1 or cntrst_np1 or cntinc_np1 or mkld_np1 or cntld_np1 or mkrd_np1 or cntrd_np1 or retx_np1 or cpp2 or ce0_np2 or ce1p2 or ap2  or b_np2 or r_w_np2 or oe_np2 or dqp2 or cntrst_np2 or cntinc_np2 or mkld_np2 or cntld_np2 or mkrd_np2 or cntrd_np2 or retx_np2 or cntint_np2 or cpp3 or ce0_np3 or ce1p3 or ap3  or b_np3 or r_w_np3 or oe_np3 or dqp3 or cntrst_np3 or cntinc_np3 or mkld_np3 or cntld_np3 or mkrd_np3 or cntrd_np3 or retx_np3 or cpp4 or ce0_np4 or ce1p4 or ap4  or b_np4 or r_w_np4 or oe_np4 or dqp4 or cntrst_np4 or cntinc_np4 or mkld_np4 or cntld_np4 or mkrd_np4 or cntrd_np4 or retx_np4 or oep1_int or oep2_int or oep3_int or oep4_int or tOEp1_int or tOEp2_int or tOEp3_int or tOEp4_int or doff_np1_event or doff_np2_event or doff_np3_event or doff_np4_event) begin
      event_chk;
      timing_chk;
      //-------------------
      // ver 3.0 PAL
      //-------------------
      if (mrst_n === 0) begin              //added by shadab Rel 2.2
         if (DmsgOn) $display("%t Model := Reseting the Device", $realtime);
         // -- Register and counters
         if ($realtime > 0) setup_hold_chk = 0;
         rst_disp_flag = 1'b0;
         reset_over = 0;
         mrstedge_flag_p1 = 1'b1;//ver 2.0 palani         
         mrstedge_flag_p2 = 1'b1;
         mrstedge_flag_p3 = 1'b1;
         mrstedge_flag_p4 = 1'b1;
         doff_flag_p1 = 1'b0;
         doff_flag_p2 = 1'b0;
         doff_flag_p3 = 1'b0;
         doff_flag_p4 = 1'b0;
      end 
      if ((mrst_n === 0)|| ((doff_np1_event === 1'b1) && doff_np1_pos_event) || ((doff_np2_event === 1'b1)&& doff_np2_pos_event) || ((doff_np3_event === 1'b1) && doff_np3_pos_event) || ((doff_np4_event === 1'b1) && doff_np4_pos_event)) begin
         i = 0;
         j = 0;
         tRS_f = `START;
         last_port = 2'bxx;      //ver 3.12 PAL
      end      
      
      if((mrst_n === 0) || ((doff_np1_event === 1'b1) && doff_np1_pos_event)) begin   
         tempA_reg1 = `AD_S'h0;
         tOHZ_overp1_f = 1'b0;
         cntp1_reg = `AD_S'h0;
         mkp1_reg = `UNMASK_ALL;
         wrp1_flag_p1 = 1'b0;
         wrp1_flag_p2 = 1'b0;
         rdp1_violation_p1 = 1'b0;
         rdp1_violation_p2 = 1'b0;
         rdp1_tDC_p1 = 1'b0;
         rdp1_tDC_p2 = 1'b0;
         rdp1_tDC_p3 = 1'b0;
         rdp1_tDC_p4 = 1'b0;
         rdp1_tDC_p5 = 1'b0;         
         rdp1_tAC_p1 = 1'b0;//ver 2.0 Palani         
         rdp1_tAC_p2 = 1'b0;
         rdp1_tAC_p3 = 1'b0;
         rdp1_tAC_p4 = 1'b0;
         rdp1_tAC_p5 = 1'b0;
         dqp1_p3 = `DT_S'hx;
         dqp1_p4 = `DT_S'hx;
         mkp1_rd_en_p1 = 1'b0;
         mkp1_rd_en_p2 = 1'b0;
         mkp1_rd_en_p3 = 1'b0;
         mkp1_rd_en_p4 = 1'b0;
         mkp1_rd_con_p1 = 1'b0;//ver 3.0 PAL
         mkp1_rd_con_p2 = 1'b0;//ver 3.0 PAL
         mkp1_rd_con_p3 = 1'b0;//ver 3.0 PAL
         mkp1_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp1_ld_en_p1 = 1'b0;//ver 2.0 Palani
         mkp1_ld_en_p2 = 1'b0;
         mkp1_ld_en_p3 = 1'b0;
         mkp1_ld_en_p4 = 1'b0;
         cntp1_rd_en_p1 = 1'b0;
         cntp1_rd_en_p2 = 1'b0;
         cntp1_rd_en_p3 = 1'b0;
         cntp1_rd_en_p4 = 1'b0;
         cntp1_rd_con_p1 = 1'b0;//ver 3.0 PAL
         cntp1_rd_con_p2 = 1'b0;//ver 3.0 PAL
         cntp1_rd_con_p3 = 1'b0;//ver 3.0 PAL
         cntp1_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp1_rdbk_p1 = `AD_S'b0;
         mkp1_rdbk_p2 = `AD_S'b0;
         mkp1_rdbk_p3 = `AD_S'b0;
         mkp1_rdbk_p4 = `AD_S'b0;
         mkp1_rd_en_p5 = `AD_S'b0;         
         cntp1_rdbk_p1 = `AD_S'b0;
         cntp1_rdbk_p2 = `AD_S'b0;
         cntp1_rdbk_p3 = `AD_S'b0;
         cntp1_rdbk_p4 = `AD_S'b0;
         cntp1_rd_en_p5 = `AD_S'b0;         
         cntintp1_en_p1 = 1'b0;
         cntintp1_en_p2 = 1'b0;//ver 3.0 PAL
         mirrorp1_loaded_en = 1'b0;
         opernp1_type = `NONE;         
         mirrorp1_reg = `AD_S'h0;
         oep1_int = 0;
         tOEp1_int = 0;
         last_opernp1_p1 = 1'bx;   // x defines no read or write operation
         last_opernp1_p2 = 1'bx;
         last_opernp1_p3 = 1'bx;
         last_opernp1_p4 = 1'bx;
         cnt_doff1 = 0;
         ddisp_flag_p1 = 1'b0;//ver 2.0 palani
         cnt_stb_set_p1  = 0;
         cnt_stb_set1_p1 = 0;
         mailbox1_by = `MAILBOX_NONE;
         mailintp1_en_p1 = 0;
         mailintp1_en_p2 = 0;
         cnthldp1_en_p1 = 0;
         cnthldp1_en_p2 = 0;
         cnthldp1_en_p3 = 0;
         cnthldp1_en_p4 = 0;
         last_access_type_p1 = `READ;
         last_addr_p1 = `AD_S'hx; // X can't be previous valid address.         
      end // if ((mrst_n === (0) || (doff_np1_event === 1'b1)) && doff_np1_pos_event)
         
      if((mrst_n === 0) || ((doff_np2_event === 1'b1) && doff_np2_pos_event)) begin   
         tOHZ_overp2_f = 1'b0;         
         cntp2_reg = `AD_S'h0;
         mkp2_reg = `UNMASK_ALL;
         wrp2_flag_p1 = 1'b0;
         wrp2_flag_p2 = 1'b0;
         rdp2_violation_p1 = 1'b0;
         rdp2_violation_p2 = 1'b0;
         rdp2_tDC_p1 = 1'b0;
         rdp2_tDC_p2 = 1'b0;
         rdp2_tDC_p3 = 1'b0;
         rdp2_tDC_p4 = 1'b0;
         rdp2_tDC_p5 = 1'b0;
         rdp2_tAC_p1 = 1'b0;
         rdp2_tAC_p2 = 1'b0;         
         rdp2_tAC_p3 = 1'b0;
         rdp2_tAC_p4 = 1'b0;
         rdp2_tAC_p5 = 1'b0;
         dqp2_p3 = `DT_S'hx;
         dqp2_p4 = `DT_S'hx;
         mkp2_rd_en_p1 = 1'b0;
         mkp2_rd_en_p2 = 1'b0;
         mkp2_rd_en_p3 = 1'b0;
         mkp2_rd_en_p4 = 1'b0;
         mkp2_rd_con_p1 = 1'b0;//ver 3.0 PAL
         mkp2_rd_con_p2 = 1'b0;//ver 3.0 PAL
         mkp2_rd_con_p3 = 1'b0;//ver 3.0 PAL
         mkp2_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp2_ld_en_p1 = 1'b0;
         mkp2_ld_en_p2 = 1'b0;
         mkp2_ld_en_p3 = 1'b0;
         mkp2_ld_en_p4 = 1'b0;
         cntp2_rd_en_p1 = 1'b0;
         cntp2_rd_en_p2 = 1'b0;
         cntp2_rd_en_p3 = 1'b0;
         cntp2_rd_en_p4 = 1'b0;
         cntp2_rd_con_p1 = 1'b0;//ver 3.0 PAL
         cntp2_rd_con_p2 = 1'b0;//ver 3.0 PAL
         cntp2_rd_con_p3 = 1'b0;//ver 3.0 PAL
         cntp2_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp2_rdbk_p1 = `AD_S'b0;
         mkp2_rdbk_p2 = `AD_S'b0;
         mkp2_rdbk_p3 = `AD_S'b0;
         mkp2_rdbk_p4 = `AD_S'b0;
         mkp2_rd_en_p5 = `AD_S'b0;         
         cntp2_rdbk_p1 = `AD_S'b0;
         cntp2_rdbk_p2 = `AD_S'b0;
         cntp2_rdbk_p3 = `AD_S'b0;
         cntp2_rdbk_p4 = `AD_S'b0;
         cntp2_rd_en_p5 = `AD_S'b0;         
         cntintp2_en_p1 = 1'b0;
         cntintp2_en_p2 = 1'b0;//ver 3.0 PAL
         mirrorp2_loaded_en = 1'b0;
         opernp2_type = `NONE;
         mirrorp2_reg = `AD_S'h0;
         oep2_int = 0;
         tOEp2_int = 0;
         last_opernp2_p1 = 1'bx;
         last_opernp2_p2 = 1'bx;
         last_opernp2_p3 = 1'bx;
         last_opernp2_p4 = 1'bx;
         tempA_reg2 = `AD_S'h0;
         cnt_doff2 = 0;
         ddisp_flag_p2 = 1'b0;
         cnt_stb_set_p2  = 0;
         cnt_stb_set1_p2 = 0;
         mailbox2_by = `MAILBOX_NONE;
         mailintp2_en_p1 = 0;
         mailintp2_en_p2 = 0;
         cnthldp2_en_p1 = 0;
         cnthldp2_en_p2 = 0;
         cnthldp2_en_p3 = 0;
         cnthldp2_en_p4 = 0;
         last_access_type_p2 = `READ;
         last_addr_p2 = `AD_S'hx; // X can't be previous valid address.         
      end // if ((mrst_n === (0) || (doff_np2_event === 1'b1)) && doff_np2_pos_event)

      if((mrst_n === 0) || ((doff_np3_event === 1'b1) && doff_np3_pos_event)) begin            
         tOHZ_overp3_f = 1'b0;
         cntp3_reg = `AD_S'h0;
         mkp3_reg = `UNMASK_ALL;
         wrp3_flag_p1 = 1'b0;
         wrp3_flag_p2 = 1'b0;
         rdp3_violation_p1 = 1'b0;
         rdp3_violation_p2 = 1'b0;
         rdp3_tDC_p1 = 1'b0;
         rdp3_tDC_p2 = 1'b0;
         rdp3_tDC_p3 = 1'b0;
         rdp3_tDC_p4 = 1'b0;
         rdp3_tDC_p5 = 1'b0;         
         rdp3_tAC_p1 = 1'b0;
         rdp3_tAC_p2 = 1'b0;
         rdp3_tAC_p3 = 1'b0;
         rdp3_tAC_p4 = 1'b0;
         rdp3_tAC_p5 = 1'b0;
         dqp3_p3 = `DT_S'hx;
         dqp3_p4 = `DT_S'hx;
         mkp3_rd_en_p1 = 1'b0;
         mkp3_rd_en_p2 = 1'b0;
         mkp3_rd_en_p3 = 1'b0;
         mkp3_rd_en_p4 = 1'b0;
         mkp3_rd_con_p1 = 1'b0;//ver 3.0 PAL
         mkp3_rd_con_p2 = 1'b0;//ver 3.0 PAL
         mkp3_rd_con_p3 = 1'b0;//ver 3.0 PAL
         mkp3_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp3_ld_en_p1 = 1'b0;
         mkp3_ld_en_p2 = 1'b0;
         mkp3_ld_en_p3 = 1'b0;
         mkp3_ld_en_p4 = 1'b0;
         cntp3_rd_en_p1 = 1'b0;
         cntp3_rd_en_p2 = 1'b0;
         cntp3_rd_en_p3 = 1'b0;
         cntp3_rd_en_p4 = 1'b0;
         cntp3_rd_con_p1 = 1'b0;//ver 3.0 PAL
         cntp3_rd_con_p2 = 1'b0;//ver 3.0 PAL
         cntp3_rd_con_p3 = 1'b0;//ver 3.0 PAL
         cntp3_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp3_rdbk_p1 = `AD_S'b0;
         mkp3_rdbk_p2 = `AD_S'b0;
         mkp3_rdbk_p3 = `AD_S'b0;
         mkp3_rdbk_p4 = `AD_S'b0;
         mkp3_rd_en_p5 = `AD_S'b0;         
         cntp3_rdbk_p1 = `AD_S'b0;
         cntp3_rdbk_p2 = `AD_S'b0;
         cntp3_rdbk_p3 = `AD_S'b0;
         cntp3_rdbk_p4 = `AD_S'b0;
         cntp3_rd_en_p5 = `AD_S'b0;         
         cntintp3_en_p1 = 1'b0;
         cntintp3_en_p2 = 1'b0;//ver 3.0 PAL         
         mirrorp3_loaded_en = 1'b0;
         opernp3_type = `NONE;
         mirrorp3_reg = `AD_S'h0;
         oep3_int = 0;
         tOEp3_int = 0;
         last_opernp3_p1 = 1'bx;
         last_opernp3_p2 = 1'bx;
         last_opernp3_p3 = 1'bx;         
         last_opernp3_p4 = 1'bx;
         tempA_reg3 = `AD_S'h0;      
         cnt_doff3 = 0;
         ddisp_flag_p3 = 1'b0;
         cnt_stb_set_p3  = 0;
         cnt_stb_set1_p3 = 0;
         mailbox3_by = `MAILBOX_NONE;
         mailintp3_en_p1 = 0;
         mailintp3_en_p2 = 0;
         cnthldp3_en_p1 = 0;
         cnthldp3_en_p2 = 0;
         cnthldp3_en_p3 = 0;
         cnthldp3_en_p4 = 0;
         last_access_type_p3 = `READ;
         last_addr_p3 = `AD_S'hx; // X can't be previous valid address.         
      end // if ((mrst_n === (0) || (doff_np3_event === 1'b1)) && doff_np3_pos_event)

      if((mrst_n === 0) || ((doff_np4_event === 1'b1) && doff_np4_pos_event)) begin   
         tOHZ_overp4_f = 1'b0;
         cntp4_reg = `AD_S'h0;
         mkp4_reg = `UNMASK_ALL;
         wrp4_flag_p1 = 1'b0;
         wrp4_flag_p2 = 1'b0;
         rdp4_violation_p1 = 1'b0;
         rdp4_violation_p2 = 1'b0;
         rdp4_tDC_p1 = 1'b0;
         rdp4_tDC_p2 = 1'b0;
         rdp4_tDC_p3 = 1'b0;
         rdp4_tDC_p4 = 1'b0;         
         rdp4_tDC_p5 = 1'b0;
         rdp4_tAC_p1 = 1'b0;
         rdp4_tAC_p2 = 1'b0;
         rdp4_tAC_p3 = 1'b0;
         rdp4_tAC_p4 = 1'b0;
         rdp4_tAC_p5 = 1'b0;
         dqp4_p3 = `DT_S'hx;
         dqp4_p4 = `DT_S'hx;
         mkp4_rd_en_p1 = 1'b0;
         mkp4_rd_en_p2 = 1'b0;
         mkp4_rd_en_p3 = 1'b0;
         mkp4_rd_en_p4 = 1'b0;
         mkp4_rd_con_p1 = 1'b0;//ver 3.0 PAL
         mkp4_rd_con_p2 = 1'b0;//ver 3.0 PAL
         mkp4_rd_con_p3 = 1'b0;//ver 3.0 PAL
         mkp4_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp4_ld_en_p1 = 1'b0;
         mkp4_ld_en_p2 = 1'b0;
         mkp4_ld_en_p3 = 1'b0;
         mkp4_ld_en_p4 = 1'b0;
         cntp4_rd_en_p1 = 1'b0;
         cntp4_rd_en_p2 = 1'b0;
         cntp4_rd_en_p3 = 1'b0;
         cntp4_rd_en_p4 = 1'b0;
         cntp4_rd_con_p1 = 1'b0;//ver 3.0 PAL
         cntp4_rd_con_p2 = 1'b0;//ver 3.0 PAL
         cntp4_rd_con_p3 = 1'b0;//ver 3.0 PAL
         cntp4_rd_con_p4 = 1'b0;//ver 3.0 PAL
         mkp4_rdbk_p1 = `AD_S'b0;
         mkp4_rdbk_p2 = `AD_S'b0;
         mkp4_rdbk_p3 = `AD_S'b0;
         mkp4_rdbk_p4 = `AD_S'b0;
         mkp4_rd_en_p5 = `AD_S'b0;         
         cntp4_rdbk_p1 = `AD_S'b0;
         cntp4_rdbk_p2 = `AD_S'b0;
         cntp4_rdbk_p3 = `AD_S'b0;
         cntp4_rdbk_p4 = `AD_S'b0;
         cntp4_rd_en_p5 = `AD_S'b0;         
         cntintp4_en_p1 = 1'b0;
         cntintp4_en_p2 = 1'b0;//ver 3.0 PAL
         mirrorp4_loaded_en = 1'b0;
         opernp4_type = `NONE;
         mirrorp4_reg = `AD_S'h0;
         oep4_int = 0;
         tOEp4_int = 0;
         last_opernp4_p1 = 1'bx;
         last_opernp4_p2 = 1'bx;
         last_opernp4_p3 = 1'bx;
         last_opernp4_p4 = 1'bx;
         tempA_reg4 = `AD_S'h0;      
         cnt_doff4 = 0;
         ddisp_flag_p4 = 1'b0;
         cnt_stb_set_p4  = 0;
         cnt_stb_set1_p4 = 0;
         mailbox4_by = `MAILBOX_NONE;
         mailintp4_en_p1 = 0;
         mailintp4_en_p2 = 0;
         cnthldp4_en_p1 = 0;
         cnthldp4_en_p2 = 0;
         cnthldp4_en_p3 = 0;
         cnthldp4_en_p4 = 0;
         last_access_type_p4 = `READ;
         last_addr_p4 = `AD_S'hx; // X can't be previous valid address.         
      end // if ((mrst_n === (0) || (doff_np4_event === 1'b1)) && doff_np4_pos_event)

      if ((mrst_n === 0)|| ((doff_np1_event === 1'b1) && doff_np1_pos_event) || ((doff_np2_event === 1'b1) && doff_np2_pos_event) || ((doff_np3_event === 1'b1) && doff_np3_pos_event) || ((doff_np4_event === 1'b1) && doff_np4_pos_event)) begin
         if (mrst_n_event) begin //added by shadab Rel 2.2
            tRS_chk = $realtime;
            tCCS_chk = $realtime;
         end
         
         if((mrst_n_event) || ((doff_np1_event === 1'b1) && doff_np1_pos_event))begin
            // addr and data outputs
            ap1_r  <= #tRSF `AD_S'hZ;
            dqp1_r <= #tRSF `DT_S'hZ;
            // Interrupt flags
            int_np1    <= #tRSF 1'b1;
            cntint_np1 <= #tRSF 1'b1;

            ready_np1 <= #tRSF 1'b1;
            
            tCCS_chk_w1 = $realtime;
            oep1_pulse_chk = $realtime;
            tOEp1_over_chk = $realtime;

            clk_stb_p1   = 1'b0;
            ready_set_p1 = 1'b0;
         end
         
         if((mrst_n_event) || ((doff_np2_event === 1'b1) && doff_np2_pos_event))begin            
            // addr and data outputs
            ap2_r  <= #tRSF `AD_S'hZ;
            dqp2_r <= #tRSF `DT_S'hZ;
            // Interrupt flags
            int_np2    <= #tRSF 1'b1;
            cntint_np2 <= #tRSF 1'b1;

            ready_np2 <= #tRSF 1'b1;
            
            tCCS_chk_w2 = $realtime;
            oep2_pulse_chk = $realtime;
            tOEp2_over_chk = $realtime;

            clk_stb_p2   = 1'b0;
            ready_set_p2 = 1'b0;
         end

         if((mrst_n_event) || ((doff_np3_event === 1'b1) && doff_np3_pos_event))begin   
            // addr and data outputs
            ap3_r  <= #tRSF `AD_S'hZ;
            dqp3_r <= #tRSF `DT_S'hZ;
            // Interrupt flags
            int_np3    <= #tRSF 1'b1;
            cntint_np3 <= #tRSF 1'b1;

            ready_np3 <= #tRSF 1'b1;
            
            tCCS_chk_w3 = $realtime;
            oep3_pulse_chk = $realtime;
            tOEp3_over_chk = $realtime;

            clk_stb_p3   = 1'b0;
            ready_set_p3 = 1'b0;
         end

         if((mrst_n_event) || ((doff_np4_event === 1'b1) && doff_np4_pos_event))begin
            // addr and data outputs
            ap4_r  <= #tRSF `AD_S'hZ;
            dqp4_r <= #tRSF `DT_S'hZ;
            // Interrupt flags            
            int_np4    <= #tRSF 1'b1;
            cntint_np4 <= #tRSF 1'b1;

            ready_np4 <= #tRSF 1'b1;

            tCCS_chk_w4 = $realtime;
            oep4_pulse_chk = $realtime;
            tOEp4_over_chk = $realtime;

            clk_stb_p4   = 1'b0;
            ready_set_p4 = 1'b0;
         end
      end //added by shadab Rel 2.2
      //-------------------
      // ver 3.0 PAL
      //-------------------
      else if ((mrst_n_event) && (mrst_n === 1)) begin
         if (DmsgOn) $display("%t Model := Reset operation over", $realtime);
         if (tRS_f == `START) begin
            tRS_f = `STOP;
            reset_over = 1;
            if ($realtime > 0) setup_hold_chk <= #tRSR 1;
         end 
      end
      else if ((!mrst_n_event) && (mrst_n === 1)) begin
         if (reset_chk_fn(no_use))begin
            //********************************************************
            // Ver 3.3 PAL
            //********************************************************
            fork
               begin
//********************************************************************************************************
// PORT 1 
//********************************************************************************************************
                  if (!((doff_np1_event === 1'b1) && doff_np1_pos_event)) begin
                     if ((clkp1_event) && (cpp1 === 1)) begin // Port one clock Active
                        cntp1_reg_p3 = cntp1_reg_p2;//ver 3.0 PAL            
                        cntp1_reg_p2 = cntp1_reg_p1;//ver 3.0 PAL
                        cntp1_reg_p1 = cntp1_reg;//ver 3.0 PAL

                        mirrorp1_loaded_en = 1'b0;                  
                        cntintp1_en_p2 = cntintp1_en_p1; //ver 3.0 PAL
                        cntintp1_en_p1 = 1'b0;
                        
                        dqp1_w2 = dqp1_w1; //ver 3.0 PAL
                        
                        wrp1_en_p2 = wrp1_en_p1; // pipeline write enable signal //ver 3.0 PAL
                        
                        opernp1_type_p1 = opernp1_type; //ver 3.2 PAL
                        
                        wrp1_flag_p2 = wrp1_flag_p1;//ver 3.0 PAL
                        wrp1_flag_p1 = 1'b0;        //ver 3.0 PAL
                        
                        rdp1_violation_p2 = rdp1_violation_p1;//ver 3.0 PAL
                        rdp1_violation_p1 = 1'b0;             //ver 3.0 PAL
                        
                        dqp1_p4 = dqp1_p3;       // pipeline data
                        dqp1_p3 = `DT_S'hx;      //ver 3.0 PAL
                        
                        rdp1_en_p4 = rdp1_en_p3; // pipeline read enable signal
                        rdp1_en_p3 = rdp1_en_p2; // pipeline read enable signal
                        rdp1_en_p2 = rdp1_en_p1; // pipeline read enable signal
                        
                        rdp1_con_p2 = rdp1_con_p1;//ver 3.0 PAL
                        rdp1_con_p1 = 1'b0;       //ver 3.0 PAL
                        
                        rdp1_tDC_p5 = rdp1_tDC_p4; //pipeline of control signal for tDC
                        rdp1_tDC_p4 = rdp1_tDC_p3; //pipeline of control signal for tDC
                        rdp1_tDC_p3 = rdp1_tDC_p2; //pipeline of control signal for tDC
                        rdp1_tDC_p2 = rdp1_tDC_p1; //pipeline of control signal for tDC
                        rdp1_tDC_p1 = 1'b0;
                        
                        rdp1_tAC_p5 = rdp1_tAC_p4; //pipeline of control signal for tAC//ver 2.0 Palani
                        rdp1_tAC_p4 = rdp1_tAC_p3; //pipeline of control signal for tAC
                        rdp1_tAC_p3 = rdp1_tAC_p2; //pipeline of control signal for tAC
                        rdp1_tAC_p2 = rdp1_tAC_p1; //pipeline of control signal for tAC
                        rdp1_tAC_p1 = 1'b0;
                        rdp1_tAC_dis <= #tAC rdp1_tAC_p5;
                        
                        tOEp1_over_chk = $realtime;
                        
                        last_opernp1_p4 = last_opernp1_p3;
                        last_opernp1_p3 = last_opernp1_p2;
                        last_opernp1_p2 = last_opernp1_p1;
                        last_opernp1_p1 = 1'bx;
                        
                        mkp1_rd_en_p5 = mkp1_rd_en_p4;            
                        mkp1_rd_en_p4 = mkp1_rd_en_p3;
                        mkp1_rd_en_p3 = mkp1_rd_en_p2;
                        mkp1_rd_en_p2 = mkp1_rd_en_p1;
                        mkp1_rd_en_p1 = 1'b0;
                        msk_disable_p1 <= #tCM mkp1_rd_en_p4;
                        mkp1_rd_con_p4 = mkp1_rd_con_p3;//ver 3.0 PAL
                        mkp1_rd_con_p3 = mkp1_rd_con_p2;//ver 3.0 PAL
                        mkp1_rd_con_p2 = mkp1_rd_con_p1;//ver 3.0 PAL
                        mkp1_rd_con_p1 = 1'b0;          //ver 3.0 PAL
                        
                        mkp1_ld_en_p4 = mkp1_ld_en_p3;//ver 2.0 Palani
                        mkp1_ld_en_p3 = mkp1_ld_en_p2;
                        mkp1_ld_en_p2 = mkp1_ld_en_p1;
                        mkp1_ld_en_p1 = 1'b0;
                        
                        cntp1_rd_en_p5 = cntp1_rd_en_p4;            
                        cntp1_rd_en_p4 = cntp1_rd_en_p3;
                        cntp1_rd_en_p3 = cntp1_rd_en_p2;
                        cntp1_rd_en_p2 = cntp1_rd_en_p1;
                        cntp1_rd_en_p1 = 1'b0;
                        cnt_disable_p1 <= #tCA cntp1_rd_en_p4;
                        cntp1_rd_con_p4 = cntp1_rd_con_p3;//ver 3.0 PAL
                        cntp1_rd_con_p3 = cntp1_rd_con_p2;//ver 3.0 PAL
                        cntp1_rd_con_p2 = cntp1_rd_con_p1;//ver 3.0 PAL
                        cntp1_rd_con_p1 = 1'b0;           //ver 3.0 PAL
                        
                        mkp1_rdbk_p4 = mkp1_rdbk_p3;
                        mkp1_rdbk_p3 = mkp1_rdbk_p2;
                        mkp1_rdbk_p2 = mkp1_rdbk_p1;
                        mkp1_rdbk_p1 = `AD_S'hx;
                        
                        cntp1_rdbk_p4 = cntp1_rdbk_p3;
                        cntp1_rdbk_p3 = cntp1_rdbk_p2;
                        cntp1_rdbk_p2 = cntp1_rdbk_p1;
                        cntp1_rdbk_p1 = `AD_S'hx;
                        
                        cnthldp1_en_p4 = cnthldp1_en_p3;
                        cnthldp1_en_p3 = cnthldp1_en_p2;
                        cnthldp1_en_p2 = cnthldp1_en_p1;
                        cnthldp1_en_p1 = 1'b0;
                        
                        mailintp1_en_p2 = mailintp1_en_p1;
                        
                        //priority for the input signals  
                        casez ({cntrst_np1,mkld_np1,cntld_np1,retx_np1,cntinc_np1,cntrd_np1,mkrd_np1})
                          7'b0??????: begin //resets unmasked burst counter bits
                             if (DmsgOn) $display("%t Model := Reseting Counter at Port One ", $realtime);
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp1_reg[i] == 1'b1)begin // Reset only unmasked region 
                                   cntp1_reg[i] = 1'b0;
                                end
                             end
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             mirrorp1_reg = cntp1_reg; 
                             opernp1_type = `CNTRST;
                          end
                          7'b10?????: begin //load mask register
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             if (chk_x_a("A_P1", ap1)) begin
                                mkp1_reg = `AD_S'hx;
                                opernp1_type = `MASKLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Mask Register at Port One ", $realtime);
                                mkp1_reg = ap1;
                                mkp1_ld_en_p1 = 1'b1;//ver 2.0 Palani
                                cnthldp1_en_p1 = 1'b1;
                                rdp1_en_p1 = 4'b0000;
                                rdp1_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd//ver 2.0 Palani
                                opernp1_type = `MASKLD;
                             end
                          end
                          // -------------
                          // ver 3.0 PAL
                          // -------------
                          7'b110????: begin //load counter with address
                             if (chk_x_a("A_P1", ap1)) begin
                                cntp1_reg = `AD_S'hx;
                                opernp1_type = `CNTLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Counter with Address at Port One ", $realtime);
                                cntp1_reg = ap1;
                                mirrorp1_reg = ap1;
                                opernp1_type = `CNTLD;
                             end
                          end
                          7'b1110???: begin //load counter with mirror register value
                             
                             if (DmsgOn) $display("%t Model := Loading Counter with Mirror Register at Port One ", $realtime);
                             cntp1_reg = mirrorp1_reg;        // load mirror reg into counter reg for Retx
                             opernp1_type  = `RETX;
                          end
                          7'b11110??: begin //counter increment
                             if (DmsgOn) $display("%t Model := Counter Increment at Port One ", $realtime);
                             // -------------
                             // ver 3.11 PAL
                             // -------------
                             temp_f1 = 1'b1;
                             temp_msk_p1 = mkp1_reg;
                             
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp1_reg[i] == 1'b1)begin
                                   if(temp_msk_p1[i] != cntp1_reg[i]) temp_f1 = 1'b0;
                                end
                             end
                             if (temp_f1 == 1'b1) begin
                                mirrorp1_load = 1'b1;//ver 3.11 PAL   
                             end
                             
                             if (mirrorp1_load == 1'b1) begin//ver 3.0 PAL//ver 3.11 PAL//ver 3.2 PAL   
                                mirrorp1_load = 1'b0;//ver 3.11 PAL   
                                mirrorp1_loaded_en = 1'b1;       // Don't increment cnt on the same edge of clk
                                if((chk_x_wrp0("WRP0_NP1",wrp0_np1)) == 0)begin
                                   if (wrp0_np1 == 1'b1) begin 
                                      cntp1_reg = mirrorp1_reg;     // load mirror reg into counter reg after reaching max value
                                   end else begin
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                      for(i = 0; i < 16; i = i + 1)begin
                                         if(mkp1_reg[i] == 1'b1)begin // Reset only unmasked region 
                                            cntp1_reg[i] = 1'b0;
                                         end
                                      end
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                   end
                                end
                                else begin
                                   cntp1_reg = mirrorp1_reg;     // load mirror reg into counter reg after reaching max value
                                end
                             end
                             
                             if (cntp1_reg !== mkp1_reg)begin
                                if (mirrorp1_loaded_en == 1'b0) begin
                                   // Increment unmasked region only
                                   tempA_reg1 = cntp1_reg;
                                   cnt_p1 = `AD_S'h0;
                                   no_of_mask_p1 = 0;
                                   k1 = 0;
                                   for (i = 0; i < 16; i = i + 1) begin
                                      if(mkp1_reg[i] == 1'b1)begin
                                         cnt_p1[no_of_mask_p1] = cntp1_reg[i];
                                         no_of_mask_p1 = no_of_mask_p1+1;
                                      end
                                   end
                                   cnt_p1 = cnt_p1 + 1;
                                   
                                   for (j = 0; j < 16; j = j + 1) begin
                                      if(mkp1_reg[j] == 1'b1) begin
                                         tempA_reg1[j] = cnt_p1 [k1];
                                         k1 = k1 + 1;
                                      end
                                   end
                                   cntp1_reg = tempA_reg1;
                                end
                             end
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             opernp1_type = `CNTINC;    
                          end
                          7'b111110?: begin //counter readback
                             if (DmsgOn) $display("%t Model := Reading back the counter at Port One ", $realtime);
                             cntp1_rd_en_p1 = 1'b1;
                             cntp1_rdbk_p1 = cntp1_reg;
                             if(cntp1_rdbk_p2 == cntp1_rdbk_p1) cntp1_rd_con_p1 = 1'b1;//ver 3.0 PAL       
                             rdp1_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp1_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd
                             rdp1_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp1_type = `CNTRD;
                          end
                          7'b1111110: begin //mask register readback
                             if (DmsgOn) $display("%t Model := Mask Readback operation at Port One ", $realtime);
                             mkp1_rd_en_p1 = 1'b1;
                             mkp1_rdbk_p1 = mkp1_reg;
                             if(mkp1_rdbk_p2 == mkp1_rdbk_p1) mkp1_rd_con_p1 = 1'b1;//ver 3.0 PAL
                             rdp1_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp1_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                             rdp1_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp1_type = `MASKRD;
                          end
                          7'b1111111: begin //counter hold
                             cnthldp1_en_p1 = 1'b1;
                             opernp1_type = `CNTHLD;
                          end
                          default: begin
                             cnthldp1_en_p1 = 1'b1;
                             opernp1_type = `NONE;
                             no_use = chk_x_cntrst("CNTRST_NP1",cntrst_np1);
                             no_use = chk_x_mkld("MKLD_NP1",mkld_np1);
                             no_use = chk_x_cntld("CNTLD_NP1",cntld_np1);
                             no_use = chk_x_retx("RETX_NP1",retx_np1);
                             no_use = chk_x_cntinc("CNTINC_NP1",cntinc_np1);
                             no_use = chk_x_cntrd("CNTRD_NP1",cntrd_np1);
                             no_use = chk_x_mkrd("MKRD_NP1",mkrd_np1);
                          end
                        endcase // casez({cntrst_np1,mkld_np1,cntld_np1,retx_np1,cntinc_np1,cntrd_np1,mkrd_np1})
                        //------------
                        //ver 3.2 PAL
                        //------------
                        //chk for cnt interrupt
                        if(mkp1_reg !== `AD_S'h0)begin
                           temp_reg1 = `AD_S'h0;
                           cnt_p1 = `AD_S'h0;
                           no_of_mask_p1 = 0;
                           k1 = 0;
                           for (i = 0; i < 16; i = i + 1) begin
                              if(mkp1_reg[i] == 1'b1)begin
                                 cnt_p1[no_of_mask_p1] = mkp1_reg[i];
                                 no_of_mask_p1 = no_of_mask_p1+1;
                              end
                           end
                           cnt_p1 = cnt_p1 - 1;
                           
                           for (j = 0; j < 16; j = j + 1) begin
                              if(mkp1_reg[j] == 1'b1) begin
                                 temp_reg1[j] = cnt_p1 [k1];
                                 k1 = k1 + 1;
                              end
                           end
                           
                           temp_f1 = 1'b1;
                           temp_msk_p1 = temp_reg1;
                           unknown_cntint_p1 = (^cntp1_reg) ^ (^mkp1_reg); //ver 3.21 PAL
                           
                           if((unknown_cntint_p1 == 1'b1) || (unknown_cntint_p1 == 1'b0)) begin //ver 3.21 PAL     
                              for(i = 0; i < 16; i = i + 1)begin
                                 if(mkp1_reg[i] == 1'b1)begin
                                    if(temp_msk_p1[i] != cntp1_reg[i]) temp_f1 = 1'b0;
                                 end
                              end
                              if (temp_f1 == 1'b1) begin
                                 cntintp1_en_p1 = 1'b1;
                              end
                           end else begin           //ver 3.21 PAL
                              cntintp1_en_p1 = 1'bx;//ver 3.21 PAL
                           end                      //ver 3.21 PAL
                        end
                        //------------            
                        //ver 3.2
                        //------------

                        if (!((opernp1_type == `MASKRD) || (opernp1_type == `CNTRD) || (opernp1_type == `MASKLD))) begin//ver 2.0 Palani
                           // Drive Data outputs from this block only when mrst_n is high
                           if ((ce0_np1 === 0) && (ce1p1 === 1) && (r_w_np1 === 1) && (ready_set_p1 == 1'b1)) begin  // Read operation
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 case (b_np1)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1111;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1110;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b0010: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1101;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   4'b0011: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1100;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1011;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b0101: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1010;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   4'b0110: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1001;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b1000;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b1000: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0111;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   4'b1001: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0110;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0101;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b1011: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0100;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   4'b1100: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0011;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0010;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b1110: begin
                                      if (DmsgOn) $display("%t Model := Port1 Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0001;
                                      rdp1_tDC_p1 = 1'b1;
                                      if (cntp1_reg == `LAST_ADR)  mailintp1_en_p1 = 1'b0;// Mailbox interrupt Ack for Port1
                                   end
                                   
                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port1 No Byte Read Operation", $realtime);
                                      rdp1_en_p1 = 4'b0000;
                                      rdp1_tDC_p1 = 1'b0;
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP1",b_np1);                       
                                      rdp1_en_p1 = 4'b0000; // disable outputs
                                      rdp1_tDC_p1 = 1'b0;
                                   end
                                 endcase // case(b_np1)
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if ((ce0_np1 === 0) && (ce1p1 === 1) && (r_w_np1 === 0)) begin // if ((ce0_np1 === 0) && (ce1p1 === 1) && (r_w_np1 === 1)) //write operation//ver 3.21 PAL
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 
                                 rdp1_en_p1 = 4'b0000;
                                 rdp1_en_p2 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp1_en_p3 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp1_en_p4 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp1_tDC_p1 = 1'b0;
                                 rdp1_tDC_p2 = 1'b0;
                                 rdp1_tDC_p3 = 1'b0;
                                 rdp1_tDC_p4 = 1'b0;
                                 rdp1_tDC_p5 = 1'b0;

                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                                 case(b_np1)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0000;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0001;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b0010:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0010;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b0011:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0011;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end
                                   
                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0100;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b0101:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0101;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b0110:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0110;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b0111;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1000:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1000;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1001:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1001;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1010;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1011:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1011;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1100:begin
                                      if (DmsgOn) $display("%t Model := Port1 Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1100;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port1 Upper Byte Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1101;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1110:begin
                                      if (DmsgOn) $display("%t Model := Port1 Upper Byte Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1110;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                      if (cntp1_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_1;
                                      end
                                      else if (cntp1_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_1;
                                      end
                                   end

                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port1 No Write Operation", $realtime);
                                      wrp1_flag_p1 = 1'b0; //ver 3.0 PAL
                                      wrp1_en_p1 = 4'b1111;//ver 3.0 PAL
                                      dqp1_w1 = dqp1;      //ver 3.0 PAL
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP1", b_np1);
                                   end
                                 endcase // case(b_np1)
                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if((ce0_np1 === 0) && (ce1p1 === 1) && (r_w_np1 === 1) && (ready_set_p1 == 1'b0)) begin//ver 3.21 PAL
                              if (DmsgOn) $display("%t \t Model ERROR := READ operation is not allowed when the READY_NP1 is deasserted", $realtime);
                           end else if ((ce0_np1 === 0) && (ce1p1 === 1)) begin // if ((ce0_np1 === 0) && (ce1p1 === 1) && (r_w_np1 === 0))
                              no_use = chk_x_r_w("R/W_NP1",r_w_np1);
                           end else if (!((ce0_np1 === 0) && (ce1p1 === 1))) begin // if ((ce0_np1 === 0) && (ce1p1 === 1) && (r_w_np1 === 0))
                              if (DmsgOn) $display("%t Model := Port1 Deselected", $realtime);
                              wrp1_en_p1 = 4'b1111;//ver 3.0 PAL
                              wrp1_flag_p1 = 1'b0;//ver 3.0 PAL
                              rdp1_en_p1 = 4'b0000;
                              rdp1_tDC_p1 = 1'b0;
                           end
                        end // if (!((opernp1_type == `MASKRD) || (opernp1_type == `CNTRD)))
                        // Driving the outputs
                        if (reset_over == 1) begin
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           if(rdp1_tDC_p2 == 1'b1)begin
                              last_addr_p1 = cntp1_reg_p1;
                              last_opernp1_p1 = `READ;

                              #0;
                              rdp1_violation_p1 = read_tCCS_chk_fn(`port1);
                              last_port = `port1;//ver 3.12 PAL
                           end
                           if(rdp1_tDC_p3 == 1'b1)begin
                              dqp1_p3 = read_data_fn(`port1);
                              if((cntp1_reg_p3 == cntp1_reg_p2) && (dqp1_p4 == dqp1_p3))begin
                                 rdp1_con_p1 = 1'b1;
                              end else begin
                                 rdp1_con_p1 = 1'b0;
                              end
                           end
                           // Pipelined Write Operation
                           if(wrp1_flag_p2 == 1'b1)begin
                              case(wrp1_en_p2)
                                4'b0000: begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   #0;
                                   mem [cntp1_reg_p1] = write_data_and_tCCS_chk_fn(`port1);
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0001:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];                    // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M:(`DT_S)/4] , tempD_reg1_p1[((`DT_S)/4 - 1):0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0010:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M:(`DT_S)/2] , tempD_reg1_p1[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p1[((`DT_S)/4 - 1):0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0011:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M:(`DT_S)/2] , tempD_reg1_p1[((`DT_S/2) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0100:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M:(3*(`DT_S/4))] , tempD_reg1_p1[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p1[((`DT_S/2) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0101:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M : (3*(`DT_S/4))], tempD_reg1_p1[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p1[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p1[((`DT_S/4) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0110:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M : (3*(`DT_S/4))], tempD_reg1_p1[(3*(`DT_S/4) - 1) : (`DT_S/4)],tempD_reg2_p1[((`DT_S/4) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b0111:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg2_p1[`DT_M : (3*(`DT_S/4))] , tempD_reg1_p1[(3*(`DT_S/4) - 1) :0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1000:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (3*(`DT_S/4))],tempD_reg2_p1[(3*(`DT_S/4) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1001:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (3*(`DT_S/4))],tempD_reg2_p1[(3*(`DT_S/4) - 1) : (`DT_S/4)]  , tempD_reg1_p1[((`DT_S/4) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1010:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (3*(`DT_S/4))],tempD_reg2_p1[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p1[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p1[((`DT_S/4) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1011:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (3*(`DT_S/4))],tempD_reg2_p1[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p1[((`DT_S/2) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1100:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (`DT_S/2)], tempD_reg2_p1[((`DT_S/2) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1101:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (`DT_S/2)],tempD_reg2_p1[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p1[((`DT_S/4) - 1) : 0] };
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                4'b1110:begin
                                   last_addr_p1 = cntp1_reg_p1;
                                   last_opernp1_p1 = `WRITE;            
                                   tempD_reg1_p1 = mem[cntp1_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p1 = write_data_and_tCCS_chk_fn(`port1);// save the current data temporarily
                                   mem[cntp1_reg_p1] = {tempD_reg1_p1[`DT_M : (`DT_S/4)],tempD_reg2_p1 [((`DT_S/4) - 1) : 0]};
                                   last_port = `port1;//ver 3.12 PAL
                                end
                                default: begin
                                   last_addr_p1 = 16'hX;
                                   last_opernp1_p1 = `WRITE;            
                                   last_port = `port1;//ver 3.12 PAL
                                end
                              endcase // case(wrp1_en_p2)
                           end // if (wrp1_flag_p2 == 1'b1)
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           // -----------------------------------------------------------------------------
                           // Drive Address outputs from clk edge
                           if (mkp1_rd_en_p4 == 1'b1) begin
			                  if (mkp1_rd_con_p4 !== 1'b1)begin  //ver 3.0 PAL
                                 ap1_r <= # tCKLZA `AD_S'hX;
                              end
                              ap1_r <= # tCM mkp1_rdbk_p4;
                           end else if (cntp1_rd_en_p4 == 1'b1) begin
			   	              if (cntp1_rd_con_p4 !== 1'b1) begin //ver 3.0 PAL
                                 ap1_r <= # tCKLZA `AD_S'hX; 
                              end
                              ap1_r <= # tCA cntp1_rdbk_p4;
                           end else begin                  //ver 2.0 Palani
                              if(rdp1_tAC_p5 == 1'b1)begin
                                 ap1_r <= # tAC `AD_S'hX;
                                 ap1_r <= # tCKHZA_min `AD_S'hx;
                                 ap1_r <= # tCKHZA_max `AD_S'hZ;
                              end else begin
                                 if((mkp1_rd_en_p5 == 1'b1) || (cntp1_rd_en_p5 == 1'b1))begin
                                    ap1_r <= # tCKHZA_min `AD_S'hx;
                                    ap1_r <= # tCKHZA_max `AD_S'hZ;
                                 end else begin
                                    ap1_r <= `AD_S'hZ;
                                 end
                              end
                           end
                           
                           // Drive Cntint interrupt pin from clk edge
                           if (cntintp1_en_p2 == 1'b1) begin
                              cntint_np1 <= #tSCINT 1'b0;
                              cntintp1_set <= 1'b1;//ver 3.2 PAL
                           end else if (cntintp1_en_p2 === 1'bx) begin//ver 3.21 PAL
                              cntint_np1 <= #tSCINT 1'bx;             //ver 3.21 PAL
                              cntintp1_set <= 1'b1; //ver 3.21 PAL
                           end                                        //ver 3.21 PAL 
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           if(((cntintp1_set == 1'b1) && !(((cntintp1_en_p1 == 1'b1) && (cntintp1_en_p2 == 1'b1))|| (cntintp1_en_p2 === 1'bx))) && ((opernp1_type_p1 == `CNTINC) || (opernp1_type_p1 == `CNTRST) || (opernp1_type_p1 == `CNTLD) || (opernp1_type_p1 == `MASKLD))) begin//ver 3.21 PAL
                              cntint_np1 <= #tRCINT 1'b1;
                              cntintp1_set <= 1'b0;//ver 3.2 PAL
                           end
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           
                           // Set port two,three,four Mailbox interrupt pin from clk edge with one clk latency
                           if ((mailintp2_en_p2 == 1'b1)      && (mailbox2_by == `MAILBOX_1))begin
                              int_np2 <= #tSINT 1'b0;
                              mailbox2_by = `MAILBOX_NONE;
                           end
                           else if ((mailintp3_en_p2 == 1'b1) && (mailbox3_by == `MAILBOX_1))begin
                              int_np3 <= #tSINT 1'b0;
                              mailbox3_by = `MAILBOX_NONE;
                           end            
                           else if ((mailintp4_en_p2 == 1'b1) && (mailbox4_by == `MAILBOX_1))begin
                              int_np4 <= #tSINT 1'b0;
                              mailbox4_by = `MAILBOX_NONE;
                           end
                           //Reset port one mailbox interrupt pin from clk edge with one clk latency
                           if (mailintp1_en_p2 == 1'b0) begin
                              int_np1 <= #tRINT 1'b1;
                           end
                        end

                        //-----------------------------------------
                        //X-handling
                        no_use = chk_x_ce0("CE0_NP1",ce0_np1);
                        no_use = chk_x_ce1("CE1_P1",ce1p1);

                     end // if ((clkp1_event) && (cpp1 === 1))
                     // Drive Data outputs from this block only when mrst_n is high
                     if ((oe_np1_event) && (oe_np1 === 0)) begin            // outputs from oe low event
                        oep1_pulse_chk = $realtime;
                        tOEp1_over_chk = $realtime;
                        tOHZ_overp1_f = 1'b0; 
                        tOEp1_int <= #tOE ~tOEp1_int;
                        
                        if (DmsgOn) $display("%t Model := Drive Port One Data outputs from oe", $realtime);
                        case (rdp1_en_p4)
                          4'b0000: begin
                             dqp1_r <= #tOLZ `DT_S'hZ; // This is reqd only during initialization of model.tOLZ is min.
                          end
                          4'b0001: begin
                             dqp1_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0010: begin
                             dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b0011: begin
                             dqp1_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b0100: begin
                             dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                          end
                          4'b0101: begin
                             dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                             dqp1_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0110: begin
                             dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tOLZ 20'hX;
                          end
                          4'b0111: begin
                             dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #tOLZ 30'hX;
                          end
                          4'b1000: begin
                             dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                          end
                          4'b1001: begin
                             dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp1_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1010: begin
                             dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b1011: begin
                             dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp1_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b1100: begin
                             dqp1_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                          end
                          4'b1101: begin
                             dqp1_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                             dqp1_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1110: begin
                             dqp1_r[`DT_M : (`DT_S/4)] <= #tOLZ 30'hX;
                          end
                          4'b1111: begin
                             dqp1_r <= #tOLZ `DT_S'hX;
                          end
                        endcase // case(rdp1_en_p4)
                     end // if ((oe_np1_event) && (oe_np1 === 0))
                     else if ((oe_np1_event) && (oe_np1 === 1) && (!oep1_int_event)) begin // outputs from oe high event
                        oep1_pulse_chk = $realtime;
                        oep1_int <=  ~oep1_int;
                     end
                     else if (!((oe_np1_event) && (oe_np1 === 0)) && (oep1_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port One Data Outputs High-Z", $realtime);
                        tOHZ_overp1_f = 1'b1; 
                        dqp1_r <= #tOHZ_min `DT_S'hx;               
                        dqp1_r <= #tOHZ_max `DT_S'hZ;
                     end
                     else if (!((oe_np1_event) && (oe_np1 === 0)) && (tOEp1_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port One Data outputs from oe", $realtime);
                        if (($realtime - tOEp1_over_chk) >= tOE) begin
                           case (rdp1_en_p4)
                             4'b0000: begin
                                dqp1_r <= #0 `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
                             end
                             4'b0001: begin
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #0 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0010: begin
                                dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp1_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                dqp1_r[((`DT_S/2) - 1) : 0] <= #0 dqp1_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp1_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp1_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #0 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #0 dqp1_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #0 dqp1_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #0 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                                dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp1_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                                dqp1_r[((`DT_S/2) - 1) : 0] <= #0 dqp1_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                dqp1_r[`DT_M :(`DT_S/2)] <= #0 dqp1_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                dqp1_r[`DT_M : (`DT_S/2)] <= #0 dqp1_p4[`DT_M : (`DT_S/2)];
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #0 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                dqp1_r[`DT_M : (`DT_S/4)] <= #0 dqp1_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                dqp1_r <= #0 dqp1_p4;
                             end
                           endcase // case(rdp1_en_p4)
                        end // if (($realtime - tOEp1_over_chk) >= tOE)
                     end // if (!((oe_np1_event) && (oe_np1 === 0)) && (tOEp1_int_event))
                     else if ((!oe_np1_event) && (oe_np1 === 0) && (clkp1_event) && (cpp1 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port One Data outputs from clk ", $realtime);
                        if (!((cnthldp1_en_p4 == 1'b1) && (last_opernp1_p3 === `READ) && (last_opernp1_p4 === `READ))) begin
                           case (rdp1_en_p4)
                             4'b0000: begin
                                if ((cntp1_rd_en_p4 == 1'b0) && (mkp1_rd_en_p4 == 1'b0) && (mkp1_ld_en_p4 == 1'b0)) begin  // In mkrd and cntrd modes outputs should go to High-Z only and not the Low-Z.//ver 2.0 Palani
                                   if(rdp1_con_p2 !== 1'b1) begin
                                      if (rdp1_tDC_p5 == 1'b1) begin
                                         dqp1_r <= #tDC_DLL_p1 `DT_S'hX;
                                      end
                                   end
                                end
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r <= #tCKHZ_min_DLL_p1 `DT_S'hx;
                                end
                                dqp1_r <= #tCKHZ_max_DLL_p1 `DT_S'hZ;
                             end
                             4'b0001: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_min_DLL_p1 30'hx;
                                end
                                dqp1_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_max_DLL_p1 30'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/4)-1) : 0];
                             end
                             4'b0010: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_min_DLL_p1 20'hx;
                                   dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p1 10'hx;                    
                                end
                                dqp1_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_max_DLL_p1 20'hZ;
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : (`DT_S/2)] <= #tCKHZ_min_DLL_p1 20'hx;
                                end
                                dqp1_r[`DT_M : (`DT_S/2)] <= #tCKHZ_max_DLL_p1 20'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                    
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p1 20'hX;
                                   end else begin
                                      dqp1_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p1 20'hX;
                                   end
                                end
                                dqp1_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p1 10'hx;
                                   dqp1_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p1 20'hx;
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p1 10'hZ;
                                dqp1_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p1 20'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                    
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p1 dqp1_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p1 10'hx;
                                   dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p1 10'hx;
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p1 10'hZ;
                                dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                    
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p1 dqp1_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p1 10'hx;
                                   dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p1 10'hx;
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p1 10'hZ;
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tDC_DLL_p1 20'hX;
                                   end else begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p1 20'hX;
                                   end
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCD_DLL_p1 dqp1_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p1 10'hx;
                                end                       
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #tDC_DLL_p1 30'hX;
                                   end else begin
                                      dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p1 30'hX;
                                   end
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #tCD_DLL_p1 dqp1_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p1 30'hx;
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p1 30'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p1 20'hx;
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p1 20'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/4) - 1) : 0]  <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/4) - 1) : 0]  <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                                dqp1_r[((`DT_S/4) - 1) : 0]  <= #tCD_DLL_p1 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                if (rdp1_tDC_p5 == 1'b1) begin
                                   dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p1 10'hx;
                                   dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p1 10'hx;
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p1 10'hZ;
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p1 20'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p1 20'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                                dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p1 10'hx;
                                end
                                dqp1_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p1 20'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p1 10'hX;
                                      dqp1_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p1 20'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (3*(`DT_S/4))];
                                dqp1_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p1 20'hx;
                                end
                                dqp1_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p1 20'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p1 20'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p1 20'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                    
                                   dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p1 10'hx;
                                end
                                dqp1_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p1 20'hX;
                                      dqp1_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p1 10'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p1 20'hX;
                                      dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p1 10'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (`DT_S/2)];
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p1 dqp1_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                if (rdp1_tDC_p5 == 1'b1) begin                                           
                                   dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p1 10'hx;
                                end
                                dqp1_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p1 10'hZ;
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r[`DT_M : (`DT_S/4)] <= #tDC_DLL_p1 30'hX;
                                   end else begin
                                      dqp1_r[`DT_M : (`DT_S/4)] <= #tCKLZ_DLL_p1 30'hX;
                                   end
                                end
                                dqp1_r[`DT_M : (`DT_S/4)] <= #tCD_DLL_p1 dqp1_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                if(rdp1_con_p2 !== 1'b1) begin                                        
                                   if (rdp1_tDC_p5 == 1'b1) begin
                                      dqp1_r <= #tDC_DLL_p1 `DT_S'hX;
                                   end else begin
                                      dqp1_r <= #tCKLZ_DLL_p1 `DT_S'hX;
                                   end
                                end
                                dqp1_r <= #tCD_DLL_p1  dqp1_p4;
                             end
                           endcase // case(rdp1_en_p4)
                        end // if (!((cnthldp1_en_p4 == 1'b1) && (last_opernp1_p4 === `READ) && (last_opernp1_p5 === `READ)))
                     end // if ((!oe_n1_event) && (oe_n1 === 0) && (cpp1_event) && (cpp1 === 1))
                     //--------------------------------------------            
                     else if ((!oe_np1_event) && (oe_np1 === 1) && (tOHZ_overp1_f == 1'b0) && (clkp1_event) && (cpp1 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port One Data outputs from clk when OE is high", $realtime);
                        if (!((cnthldp1_en_p4 == 1'b1) && (last_opernp1_p3 === `READ) && (last_opernp1_p4 === `READ))) begin
                           dqp1_r <= #tCKHZ_min_DLL_p1 `DT_S'hZ;   
                        end
                     end // if ((!oe_np1_event) && (oe_np1 === 1) && (tOHZ_overp1_f == 1'b0) && (cpp1_event) && (cpp1 === 1))
                     else if ((!oe_np1_event) && (oe_np1 === 1) && (tOHZ_overp1_f == 1'b1) && (clkp1_event) && (cpp1 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port One Data outputs to High-Z from clk when OE is high", $realtime);
                     end else if((oe_np1_event) && (oe_np1 == 1'bx)) begin
                        no_use = chk_x_oe("OE_NP1",oe_np1);
                     end
                  end // (if (!(doff_np1_event === 1'b1)) && doff_np1_pos_event)
               end
//********************************************************************************************************
// PORT 2 
//********************************************************************************************************
               begin
                  if (!((doff_np2_event === 1'b1) && doff_np2_pos_event))begin
                     if ((clkp2_event) && (cpp2 === 1)) begin // Port Two clock Active
                        cntp2_reg_p3 = cntp2_reg_p2;//ver 3.0 PAL            
                        cntp2_reg_p2 = cntp2_reg_p1;//ver 3.0 PAL
                        cntp2_reg_p1 = cntp2_reg;//ver 3.0 PAL
                        
                        p2_1 = 1'b0;//ver 3.41 PAL
                        p2_3 = 1'b0;//ver 3.41 PAL
                        p2_4 = 1'b0;//ver 3.41 PAL
                        
                        p2_1_w = 1'b0;//ver 3.41 PAL
                        p2_3_w = 1'b0;//ver 3.41 PAL
                        p2_4_w = 1'b0;//ver 3.41 PAL
                        
                        mirrorp2_loaded_en = 1'b0;
                        cntintp2_en_p2 = cntintp2_en_p1;//ver 3.0 PAL
                        cntintp2_en_p1 = 1'b0;
                        
                        dqp2_w2 = dqp2_w1; //ver 3.0 PAL
                        
                        wrp2_en_p2 = wrp2_en_p1; // pipeline write enable signal //ver 3.0 PAL
                        
                        opernp2_type_p1 = opernp2_type; //ver 3.2 PAL            
                        
                        wrp2_flag_p2 = wrp2_flag_p1;//ver 3.0 PAL
                        wrp2_flag_p1 = 1'b0;        //ver 3.0 PAL

                        rdp2_violation_p2 = rdp2_violation_p1;//ver 3.0 PAL
                        rdp2_violation_p1 = 1'b0;             //ver 3.0 PAL

                        dqp2_p4 = dqp2_p3;       // pipeline data
                        dqp2_p3 = `DT_S'hx;     //ver 3.0 PAL       
                        
                        rdp2_en_p4 = rdp2_en_p3; // pipeline read enable signal
                        rdp2_en_p3 = rdp2_en_p2; // pipeline read enable signal
                        rdp2_en_p2 = rdp2_en_p1; // pipeline read enable signal
                        
                        rdp2_con_p2 = rdp2_con_p1;//ver 3.0 PAL
                        rdp2_con_p1 = 1'b0;       //ver 3.0 PAL
                        
                        rdp2_tDC_p5 = rdp2_tDC_p4; //pipeline of control signal for tDC
                        rdp2_tDC_p4 = rdp2_tDC_p3; //pipeline of control signal for tDC
                        rdp2_tDC_p3 = rdp2_tDC_p2; //pipeline of control signal for tDC
                        rdp2_tDC_p2 = rdp2_tDC_p1; //pipeline of control signal for tDC
                        rdp2_tDC_p1 = 1'b0;
                        rdp2_tAC_p5 = rdp2_tAC_p4; //pipeline of control signal for tAC//ver 2.0 Palani
                        rdp2_tAC_p4 = rdp2_tAC_p3; //pipeline of control signal for tAC
                        rdp2_tAC_p3 = rdp2_tAC_p2; //pipeline of control signal for tAC
                        rdp2_tAC_p2 = rdp2_tAC_p1; //pipeline of control signal for tAC
                        rdp2_tAC_p1 = 1'b0;
                        rdp2_tAC_dis <= #tAC rdp2_tAC_p5;

                        tOEp2_over_chk = $realtime;
                        
                        last_opernp2_p4 = last_opernp2_p3;
                        last_opernp2_p3 = last_opernp2_p2;
                        last_opernp2_p2 = last_opernp2_p1;
                        last_opernp2_p1 = 1'bx;

                        mkp2_rd_en_p5 = mkp2_rd_en_p4;
                        mkp2_rd_en_p4 = mkp2_rd_en_p3;
                        mkp2_rd_en_p3 = mkp2_rd_en_p2;
                        mkp2_rd_en_p2 = mkp2_rd_en_p1;
                        mkp2_rd_en_p1 = 1'b0;
                        msk_disable_p2 <= #tCM mkp2_rd_en_p4;
                        mkp2_rd_con_p4 = mkp2_rd_con_p3;//ver 3.0 PAL
                        mkp2_rd_con_p3 = mkp2_rd_con_p2;//ver 3.0 PAL
                        mkp2_rd_con_p2 = mkp2_rd_con_p1;//ver 3.0 PAL
                        mkp2_rd_con_p1 = 1'b0;          //ver 3.0 PAL

                        mkp2_ld_en_p4 = mkp2_ld_en_p3;//ver 2.0 Palani
                        mkp2_ld_en_p3 = mkp2_ld_en_p2;
                        mkp2_ld_en_p2 = mkp2_ld_en_p1;
                        mkp2_ld_en_p1 = 1'b0;

                        cntp2_rd_en_p5 = cntp2_rd_en_p4;
                        cntp2_rd_en_p4 = cntp2_rd_en_p3;
                        cntp2_rd_en_p3 = cntp2_rd_en_p2;
                        cntp2_rd_en_p2 = cntp2_rd_en_p1;
                        cntp2_rd_en_p1 = 1'b0;
                        cnt_disable_p2 <= #tCA cntp2_rd_en_p4;
                        cntp2_rd_con_p4 = cntp2_rd_con_p3;//ver 3.0 PAL
                        cntp2_rd_con_p3 = cntp2_rd_con_p2;//ver 3.0 PAL
                        cntp2_rd_con_p2 = cntp2_rd_con_p1;//ver 3.0 PAL
                        cntp2_rd_con_p1 = 1'b0;           //ver 3.0 PAL 
                        
                        mkp2_rdbk_p4 = mkp2_rdbk_p3;
                        mkp2_rdbk_p3 = mkp2_rdbk_p2;
                        mkp2_rdbk_p2 = mkp2_rdbk_p1;
                        mkp2_rdbk_p1 = `AD_S'hx;

                        cntp2_rdbk_p4 = cntp2_rdbk_p3;
                        cntp2_rdbk_p3 = cntp2_rdbk_p2;
                        cntp2_rdbk_p2 = cntp2_rdbk_p1;
                        cntp2_rdbk_p1 = `AD_S'hx;
                        
                        cnthldp2_en_p4 = cnthldp2_en_p3;
                        cnthldp2_en_p3 = cnthldp2_en_p2;
                        cnthldp2_en_p2 = cnthldp2_en_p1;
                        cnthldp2_en_p1 = 1'b0;

                        mailintp2_en_p2 = mailintp2_en_p1;

                        casez ({cntrst_np2,mkld_np2,cntld_np2,retx_np2,cntinc_np2,cntrd_np2,mkrd_np2})
                          7'b0??????: begin //resets unmasked burst counter bits
                             if (DmsgOn) $display("%t Model := Reseting Counter at Port Two ", $realtime);
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp2_reg[i] == 1'b1)begin // Reset only unmasked region 
                                   cntp2_reg[i] = 1'b0;
                                end
                             end
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             mirrorp2_reg = cntp2_reg; 
                             opernp2_type = `CNTRST;
                          end
                          7'b10?????: begin //load mask register

                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             if (chk_x_a("A_P2", ap2)) begin
                                mkp2_reg = `AD_S'hx;
                                opernp2_type = `MASKLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Mask Register at Port Two ", $realtime);
                                mkp2_reg = ap2;
                                mkp2_ld_en_p1 = 1'b1;//ver 2.0 Palani
                                cnthldp2_en_p1 = 1'b1;
                                rdp2_en_p1 = 4'b0000;
                                rdp2_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd//ver 2.0 Palani
                                opernp2_type = `MASKLD;
                             end
                          end
                          // -------------
                          // ver 3.0 PAL
                          // -------------
                          7'b110????: begin //load counter with address
                             if (chk_x_a("A_P2", ap2)) begin
                                cntp2_reg = `AD_S'hx; 
                                opernp2_type = `CNTLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Counter with Address at Port Two ", $realtime);
                                cntp2_reg = ap2;
                                mirrorp2_reg = ap2;
                                opernp2_type = `CNTLD;
                             end
                          end
                          7'b1110???: begin //load counter with mirror register value
                             if (DmsgOn) $display("%t Model := Loading Counter with Mirror Register at Port Two ", $realtime);
                             cntp2_reg = mirrorp2_reg;        // load mirror reg into counter reg for Retx
                             opernp2_type  = `RETX;
                          end
                          7'b11110??: begin //counter increment
                             if (DmsgOn) $display("%t Model := Counter Increment at Port Two ", $realtime);
                             // -------------
                             // ver 3.11 PAL
                             // -------------
                             temp_f2 = 1'b1;
                             temp_msk_p2 = mkp2_reg;
                             
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp2_reg[i] == 1'b1)begin
                                   if(temp_msk_p2[i] != cntp2_reg[i]) temp_f2 = 1'b0;
                                end
                             end
                             if (temp_f2 == 1'b1) begin
                                mirrorp2_load = 1'b1;//ver 3.11 PAL   
                             end
                             
                             if (mirrorp2_load == 1'b1)begin //ver 3.0 PAL//ver 3.11 PAL//ver 3.2 PAL          
                                mirrorp2_load = 1'b0;//ver 3.11 PAL   
                                mirrorp2_loaded_en = 1'b1;       // Don't increment cnt on the same edge of clk
                                if((chk_x_wrp0("WRP0_NP2",wrp0_np2)) == 0)begin
                                   if (wrp0_np2 == 1'b1) begin 
                                      cntp2_reg = mirrorp2_reg;     // load mirror reg into counter reg after reaching max value
                                   end else begin
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                      for(i = 0; i < 16; i = i + 1)begin
                                         if(mkp2_reg[i] == 1'b1)begin // Reset only unmasked region 
                                            cntp2_reg[i] = 1'b0;
                                         end
                                      end
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                   end
                                end
                                else begin
                                   cntp2_reg = mirrorp2_reg;     // load mirror reg into counter reg after reaching max value
                                end
                             end
                             
                             if (cntp2_reg !== mkp2_reg)begin
                                if (mirrorp2_loaded_en == 1'b0) begin
                                   // Increment unmasked region only
                                   tempA_reg2 = cntp2_reg;
                                   cnt_p2 = `AD_S'h0;
                                   no_of_mask_p2 = 0;
                                   k2 = 0;
                                   for (i = 0; i < 16; i = i + 1) begin
                                      if(mkp2_reg[i] == 1'b1)begin
                                         cnt_p2[no_of_mask_p2] = cntp2_reg[i];
                                         no_of_mask_p2 = no_of_mask_p2+1;
                                      end
                                   end
                                   cnt_p2 = cnt_p2 + 1;
                                   
                                   for (j = 0; j < 16; j = j + 1) begin
                                      if(mkp2_reg[j] == 1'b1) begin
                                         tempA_reg2[j] = cnt_p2 [k2];
                                         k2 = k2 + 1;
                                      end
                                   end
                                   cntp2_reg = tempA_reg2;
                                end
                             end

                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             
                             opernp2_type = `CNTINC;    
                          end
                          7'b111110?: begin //counter readback
                             if (DmsgOn) $display("%t Model := Reading back the counter at Port Two ", $realtime);
                             cntp2_rd_en_p1 = 1'b1;
                             cntp2_rdbk_p1 = cntp2_reg;
                             if(cntp2_rdbk_p2 == cntp2_rdbk_p1) cntp2_rd_con_p1 = 1'b1;//ver 3.0 PAL
                             rdp2_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp2_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd
                             rdp2_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp2_type = `CNTRD;
                          end
                          7'b1111110: begin //mask register readback
                             if (DmsgOn) $display("%t Model := Mask Readback operation at Port Two ", $realtime);
                             mkp2_rd_en_p1 = 1'b1;
                             mkp2_rdbk_p1 = mkp2_reg;
                             if(mkp2_rdbk_p2 == mkp2_rdbk_p1) mkp2_rd_con_p1 = 1'b1;//ver 3.0 PAL              
                             rdp2_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp2_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                             rdp2_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp2_type = `MASKRD;
                          end
                          7'b1111111: begin //counter hold
                             cnthldp2_en_p1 = 1'b1;
                             opernp2_type = `CNTHLD;
                          end
                          default: begin
                             cnthldp2_en_p1 = 1'b1;
                             opernp2_type = `NONE;
                             no_use = chk_x_cntrst("CNTRST_NP2",cntrst_np2);
                             no_use = chk_x_mkld("MKLD_NP2",mkld_np2);
                             no_use = chk_x_cntld("CNTLD_NP2",cntld_np2);
                             no_use = chk_x_retx("RETX_NP2",retx_np2);
                             no_use = chk_x_cntinc("CNTINC_NP2",cntinc_np2);
                             no_use = chk_x_cntrd("CNTRD_NP2",cntrd_np2);
                             no_use = chk_x_mkrd("MKRD_NP2",mkrd_np2);
                          end
                        endcase // casez({cntrst_np2,mkld_np2,cntld_np2,retx_np2,cntinc_np2,cntrd_np2,mkrd_np2})
                        //------------            
                        //ver 3.2 PAL
                        //------------            
                        //chk for cnt interrupt
                        if(mkp2_reg !== `AD_S'h0000)begin
                           temp_reg2 = `AD_S'h0;
                           cnt_p2 = `AD_S'h0;
                           no_of_mask_p2 = 0;
                           k2 = 0;
                           for (i = 0; i < 16; i = i + 1) begin
                              if(mkp2_reg[i] == 1'b1)begin
                                 cnt_p2[no_of_mask_p2] = mkp2_reg[i];
                                 no_of_mask_p2 = no_of_mask_p2+1;
                              end
                           end
                           cnt_p2 = cnt_p2 - 1;
                           
                           for (j = 0; j < 16; j = j + 1) begin
                              if(mkp2_reg[j] == 1'b1) begin
                                 temp_reg2[j] = cnt_p2 [k2];
                                 k2 = k2 + 1;
                              end
                           end
                           
                           temp_f2 = 1'b1;
                           temp_msk_p2 = temp_reg2;
                           unknown_cntint_p2 = (^cntp2_reg) ^ (^mkp2_reg); //ver 3.21 PAL
                           
                           if((unknown_cntint_p2 == 1'b1) || (unknown_cntint_p2 == 1'b0)) begin //ver 3.21 PAL     
                              for(i = 0; i < 16; i = i + 1)begin
                                 if(mkp2_reg[i] == 1'b1)begin
                                    if(temp_msk_p2[i] != cntp2_reg[i]) temp_f2 = 1'b0;
                                 end
                              end
                              if (temp_f2 == 1'b1) begin
                                 cntintp2_en_p1 = 1'b1;
                              end
                           end else begin           //ver 3.21 PAL
                              cntintp2_en_p1 = 1'bx;//ver 3.21 PAL
                           end                      //ver 3.21 PAL 
                           
                        end
                        //------------            
                        //ver 3.2 PAL
                        //------------            
                        
                        if (!((opernp2_type == `MASKRD) || (opernp2_type == `CNTRD) || (opernp2_type == `MASKLD))) begin
                           // Drive Data outputs from this block only when mrst_n is high

                           if ((ce0_np2 === 0) && (ce1p2 === 1) && (r_w_np2 === 1) && (ready_set_p2 == 1'b1)) begin  // Read operation
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 case (b_np2)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1111;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1110;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b0010: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1101;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   4'b0011: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1100;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1011;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b0101: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1010;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   4'b0110: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1001;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b1000;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b1000: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0111;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   4'b1001: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0110;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0101;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b1011: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0100;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   4'b1100: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0011;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0010;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b1110: begin
                                      if (DmsgOn) $display("%t Model := Port2 Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0001;
                                      rdp2_tDC_p1 = 1'b1;
                                      if (cntp2_reg == `LAST_ADR - 1)  mailintp2_en_p1 = 1'b0;// Mailbox interrupt Ack for Port2
                                   end
                                   
                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port2 No Byte Read Operation", $realtime);
                                      rdp2_en_p1 = 4'b0000;
                                      rdp2_tDC_p1 = 1'b0;
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP2",b_np2);
                                      rdp2_en_p1 = 4'b0000; // disable outputs
                                      rdp2_tDC_p1 = 1'b0;
                                   end
                                 endcase // case(b_np2)
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if ((ce0_np2 === 0) && (ce1p2 === 1) && (r_w_np2 === 0)) begin // if ((ce0_np2 === 0) && (ce1p2 === 1) && (r_w_np2 === 1)) //write operation//ver 3.21 PAL
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 rdp2_en_p1 = 4'b0000;
                                 rdp2_en_p2 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp2_en_p3 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp2_en_p4 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp2_tDC_p1 = 1'b0;
                                 rdp2_tDC_p2 = 1'b0;
                                 rdp2_tDC_p3 = 1'b0;
                                 rdp2_tDC_p4 = 1'b0;
                                 rdp2_tDC_p5 = 1'b0;

                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                                 case(b_np2)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0000;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0001;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b0010:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0010;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b0011:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0011;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end
                                   
                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0100;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b0101:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0101;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR)  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b0110:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0110;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b0111;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1000:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1000;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1001:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1001;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1010;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1011:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1011;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1100:begin
                                      if (DmsgOn) $display("%t Model := Port2 Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1100;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port2 Upper Byte Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1101;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1110:begin
                                      if (DmsgOn) $display("%t Model := Port2 Upper Byte Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1110;//ver 3.0 PAL
                                      dqp2_w1 = dqp2;      //ver 3.0 PAL
                                      if (cntp2_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_2;
                                      end
                                      else if (cntp2_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_2;
                                      end
                                   end

                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port2 No Write Operation", $realtime);
                                      wrp2_flag_p1 = 1'b0; //ver 3.0 PAL
                                      wrp2_en_p1 = 4'b1111;//ver 3.0 PAL
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP2", b_np2);
                                   end
                                 endcase // case(b_np2)
                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if((ce0_np2 === 0) && (ce1p2 === 1) && (r_w_np2 === 1) && (ready_set_p2 == 1'b0)) begin//ver 3.21 PAL
                              if (DmsgOn) $display("%t \t Model ERROR := READ operation is not allowed when the READY_NP2 is deasserted", $realtime);
                           end else if ((ce0_np2 === 0) && (ce1p2 === 1)) begin // if ((ce0_np2 === 0) && (ce1p2 === 1) && (r_w_np2 === 0))
                              no_use = chk_x_r_w("R/W_NP2",r_w_np2);                  
                           end else if (!((ce0_np2 === 0) && (ce1p2 === 1))) begin // if ((ce0_np2 === 0) && (ce1p2 === 1) && (r_w_np2 === 0))
                              if (DmsgOn) $display("%t Model := Port2 Deselected", $realtime);
                              wrp2_flag_p1 = 1'b0; //ver 3.0 PAL
                              wrp2_en_p1 = 4'b1111;//ver 3.0 PAL
                              rdp2_en_p1 = 4'b0000;
                              rdp2_tDC_p1 = 1'b0;
                           end
                        end // if (!((opernp2_type == `MASKRD) || (opernp2_type == `CNTRD)))
                        //-----------------------------------------
                        // Driving the outputs
                        if (reset_over == 1) begin
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           if(rdp2_tDC_p2 == 1'b1)begin
                              last_addr_p2 = cntp2_reg_p1;
                              last_opernp2_p1 = `READ;            

                              #0;
                              rdp2_violation_p1 = read_tCCS_chk_fn(`port2);
                              last_port = `port2;              //ver 3.12 PAL
                           end
                           if(rdp2_tDC_p3 == 1'b1)begin
                              dqp2_p3 = read_data_fn(`port2);
                              if((cntp2_reg_p3 == cntp2_reg_p2) && (dqp2_p4 == dqp2_p3))begin
                                 rdp2_con_p1 = 1'b1;
                              end else begin
                                 rdp2_con_p1 = 1'b0;
                              end
                           end
                           // Pipelined Write Operation
                           if(wrp2_flag_p2 == 1'b1)begin
                              case(wrp2_en_p2)
                                4'b0000: begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   #0;
                                   mem [cntp2_reg_p1] = write_data_and_tCCS_chk_fn(`port2);
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0001:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];                    // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M:(`DT_S)/4] , tempD_reg1_p2[((`DT_S)/4 - 1):0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0010:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M:(`DT_S)/2] , tempD_reg1_p2[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p2[((`DT_S)/4 - 1):0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0011:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M:(`DT_S)/2] , tempD_reg1_p2[((`DT_S/2) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0100:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M:(3*(`DT_S/4))] , tempD_reg1_p2[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p2[((`DT_S/2) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0101:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M : (3*(`DT_S/4))], tempD_reg1_p2[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p2[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p2[((`DT_S/4) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0110:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M : (3*(`DT_S/4))], tempD_reg1_p2[(3*(`DT_S/4) - 1) : (`DT_S/4)],tempD_reg2_p2[((`DT_S/4) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b0111:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg2_p2[`DT_M : (3*(`DT_S/4))] , tempD_reg1_p2[(3*(`DT_S/4) - 1) :0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1000:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (3*(`DT_S/4))],tempD_reg2_p2[(3*(`DT_S/4) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1001:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (3*(`DT_S/4))],tempD_reg2_p2[(3*(`DT_S/4) - 1) : (`DT_S/4)]  , tempD_reg1_p2[((`DT_S/4) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1010:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (3*(`DT_S/4))],tempD_reg2_p2[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p2[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p2[((`DT_S/4) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1011:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (3*(`DT_S/4))],tempD_reg2_p2[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p2[((`DT_S/2) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1100:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (`DT_S/2)], tempD_reg2_p2[((`DT_S/2) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1101:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (`DT_S/2)],tempD_reg2_p2[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p2[((`DT_S/4) - 1) : 0] };
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                4'b1110:begin
                                   last_addr_p2 = cntp2_reg_p1;
                                   last_opernp2_p1 = `WRITE;            
                                   tempD_reg1_p2 = mem[cntp2_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p2 = write_data_and_tCCS_chk_fn(`port2);// save the current data temporarily
                                   mem[cntp2_reg_p1] = {tempD_reg1_p2[`DT_M : (`DT_S/4)],tempD_reg2_p2 [((`DT_S/4) - 1) : 0]};
                                   last_port = `port2;//ver 3.12 PAL
                                end
                                default: begin
                                   last_addr_p2 = 16'hX;
                                   last_opernp2_p1 = `WRITE;            
                                   last_port = `port2;//ver 3.12 PAL
                                end
                              endcase // case(wrp2_en_p2)
                           end // if (wrp2_flag_p2 == 1'b1)
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           // Drive Address outputs from clk edge
                           if (mkp2_rd_en_p4 == 1'b1) begin
				              if (mkp2_rd_con_p4 !== 1'b1) begin//ver 3.0 PAL
                  	             ap2_r <= # tCKLZA `AD_S'hX; 
                              end
                              ap2_r <= # tCM mkp2_rdbk_p4;
                           end else if (cntp2_rd_en_p4 == 1'b1) begin
			                  if (cntp2_rd_con_p4 !== 1'b1) begin  //ver 3.0 PAL
                                 ap2_r <= # tCKLZA `AD_S'hX;
                              end
                              ap2_r <= # tCA cntp2_rdbk_p4;
                           end else begin //ver 2.0 Palani
                              if(rdp2_tAC_p5 == 1'b1)begin
                                 ap2_r <= # tAC `AD_S'hX;
                                 ap2_r <= # tCKHZA_min `AD_S'hx;
                                 ap2_r <= # tCKHZA_max `AD_S'hZ;
                              end else begin
                                 if((mkp2_rd_en_p5 == 1'b1) || (cntp2_rd_en_p5 == 1'b1))begin                 
                                    ap2_r <= # tCKHZA_min `AD_S'hx;
                                    ap2_r <= # tCKHZA_max `AD_S'hZ;
                                 end else begin
                                    ap2_r <= `AD_S'hZ;
                                 end
                              end
                           end
                           
                           // Drive Cntint interrupt pin from clk edge
                           if (cntintp2_en_p2 == 1'b1) begin
                              cntint_np2 <= #tSCINT 1'b0;
                              cntintp2_set <= 1'b1; //ver 3.2 PAL                 
                           end else if (cntintp2_en_p2 === 1'bx) begin//ver 3.21 PAL
                              cntint_np2 <= #tSCINT 1'bx;//ver 3.21 PAL
                              cntintp2_set <= 1'b1; //ver 3.21 PAL
                           end                   //ver 3.21 PAL
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           if(((cntintp2_set == 1'b1) && !(((cntintp2_en_p1 == 1'b1) && (cntintp2_en_p2 == 1'b1)) || (cntintp2_en_p2 === 1'bx))) && ((opernp2_type_p1 == `CNTINC) || (opernp2_type_p1 == `CNTRST) || (opernp2_type_p1 == `CNTLD) || (opernp2_type_p1 == `MASKLD))) begin//ver 3.21 PAL
                              cntint_np2 <= #tRCINT 1'b1;
                              cntintp2_set <= 1'b0; //ver 3.2 PAL                    
                           end
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           
                           // Set port one,three,four Mailbox interrupt pin from clk edge with one clk latency
                           if ((mailintp1_en_p2 == 1'b1) && (mailbox1_by == `MAILBOX_2))begin
                              int_np1 <= #tSINT 1'b0;
                              mailbox1_by = `MAILBOX_NONE;
                           end                                                              
                           else if ((mailintp3_en_p2 == 1'b1) && (mailbox3_by == `MAILBOX_2))begin
                              int_np3 <= #tSINT 1'b0;      
                              mailbox3_by = `MAILBOX_NONE;                                 
                           end            
                           else if ((mailintp4_en_p2 == 1'b1) && (mailbox4_by == `MAILBOX_2))begin
                              int_np4 <= #tSINT 1'b0;      
                              mailbox4_by = `MAILBOX_NONE;                                 
                           end
                           //Reset port two mailbox interrupt pin from clk edge with one clk latency
                           if (mailintp2_en_p2 == 1'b0) begin
                              int_np2 <= #tRINT 1'b1;
                           end
                        end

                        //-----------------------------------------
                        //X-handling
                        no_use = chk_x_ce0("CE0_NP2",ce0_np2);
                        no_use = chk_x_ce1("CE1_P2",ce1p2);
                        
                     end // if ((clkp2_event) && (cpp2 === 1))
                     //---------------------------------------------------------------------------------

                     // Drive Data outputs from this block only when mrst_n is high
                     if ((oe_np2_event) && (oe_np2 === 0)) begin            // outputs from oe low event
                        oep2_pulse_chk = $realtime;
                        tOEp2_over_chk = $realtime;
                        tOHZ_overp2_f = 1'b0; 
                        tOEp2_int <= #tOE ~tOEp2_int;
                        
                        if (DmsgOn) $display("%t Model := Drive Port Two Data outputs from oe", $realtime);
                        case (rdp2_en_p4)
                          4'b0000: begin
                             dqp2_r <= #tOLZ `DT_S'hZ; // This is reqd only during initialization of model.tOLZ is min.
                          end
                          4'b0001: begin
                             dqp2_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0010: begin
                             dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b0011: begin
                             dqp2_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b0100: begin
                             dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                          end
                          4'b0101: begin
                             dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                             dqp2_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0110: begin
                             dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tOLZ 20'hX;
                          end
                          4'b0111: begin
                             dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #tOLZ 30'hX;
                          end
                          4'b1000: begin
                             dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                          end
                          4'b1001: begin
                             dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp2_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1010: begin
                             dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b1011: begin
                             dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp2_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b1100: begin
                             dqp2_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                          end
                          4'b1101: begin
                             dqp2_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                             dqp2_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1110: begin
                             dqp2_r[`DT_M : (`DT_S/4)] <= #tOLZ 30'hX;
                          end
                          4'b1111: begin
                             dqp2_r <= #tOLZ `DT_S'hX;
                          end
                        endcase // case(rdp2_en_p4)
                     end // if ((oe_np2_event) && (oe_np2 === 0))
                     else if ((oe_np2_event) && (oe_np2 === 1) && (!oep2_int_event)) begin   // outputs from oe high event
                        oep2_pulse_chk = $realtime;
                        oep2_int <=  ~oep2_int;            
                     end
                     else if (!((oe_np2_event) && (oe_np2 === 0)) && (oep2_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port Two Data Outputs High-Z", $realtime);
                        tOHZ_overp2_f = 1'b1; 
                        dqp2_r <= #tOHZ_min `DT_S'hx;                           
                        dqp2_r <= #tOHZ_max `DT_S'hZ;
                     end
                     else if (!((oe_np2_event) && (oe_np2 === 0)) && (tOEp2_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port Two Data outputs from oe", $realtime);
                        if (($realtime - tOEp2_over_chk) >= tOE) begin
                           case (rdp2_en_p4)
                             4'b0000: begin
                                dqp2_r <= #0 `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
                             end
                             4'b0001: begin
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #0 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0010: begin
                                dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp2_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                dqp2_r[((`DT_S/2) - 1) : 0] <= #0 dqp2_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp2_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp2_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #0 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #0 dqp2_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #0 dqp2_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #0 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                                dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp2_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                                dqp2_r[((`DT_S/2) - 1) : 0] <= #0 dqp2_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                dqp2_r[`DT_M :(`DT_S/2)] <= #0 dqp2_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                dqp2_r[`DT_M : (`DT_S/2)] <= #0 dqp2_p4[`DT_M : (`DT_S/2)];
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #0 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                dqp2_r[`DT_M : (`DT_S/4)] <= #0 dqp2_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                dqp2_r <= #0 dqp2_p4;
                             end
                           endcase // case(rdp2_en_p4)
                        end // if (($realtime - tOEp2_over_chk) >= tOE)
                     end // if (!((oe_np2_event) && (oe_np2 === 0)) && (tOEp2_int_event))
                     else if ((!oe_np2_event) && (oe_np2 === 0) && (clkp2_event) && (cpp2 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Two Data outputs from clk ", $realtime);
                        if (!((cnthldp2_en_p4 == 1'b1) && (last_opernp2_p3 === `READ) && (last_opernp2_p4 === `READ))) begin
                           case (rdp2_en_p4)
                             4'b0000: begin
                                if ((cntp2_rd_en_p4 == 1'b0) && (mkp2_rd_en_p4 == 1'b0) && (mkp2_ld_en_p4 == 1'b0)) begin  // In mkrd and cntrd modes outputs should go to High-Z only and not the Low-Z.//ver 2.0 Palani
                                   if(rdp2_con_p2 !== 1'b1) begin                                           
                                      if (rdp2_tDC_p5 == 1'b1) begin
                                         dqp2_r <= #tDC_DLL_p2 `DT_S'hX;
                                      end
                                   end
                                end
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r <= #tCKHZ_min_DLL_p2 `DT_S'hx;
                                end
                                dqp2_r <= #tCKHZ_max_DLL_p2 `DT_S'hZ;
                             end
                             4'b0001: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                                        
                                   dqp2_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_min_DLL_p2 30'hx;
                                end
                                dqp2_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_max_DLL_p2 30'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                    
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/4)-1) : 0];
                             end
                             4'b0010: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_min_DLL_p2 20'hx;
                                   dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_max_DLL_p2 20'hZ;
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                                        
                                   dqp2_r[`DT_M : (`DT_S/2)] <= #tCKHZ_min_DLL_p2 20'hx;
                                end
                                dqp2_r[`DT_M : (`DT_S/2)] <= #tCKHZ_max_DLL_p2 20'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p2 20'hX;
                                   end else begin
                                      dqp2_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p2 20'hX;
                                   end
                                end
                                dqp2_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                                        
                                   dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p2 10'hx;
                                   dqp2_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p2 20'hx;
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p2 10'hZ;
                                dqp2_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p2 20'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p2 dqp2_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                                        
                                   dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p2 10'hx;
                                   dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p2 10'hZ;
                                dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p2 dqp2_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                                        
                                   dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p2 10'hx;
                                   dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p2 10'hZ;
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tDC_DLL_p2 20'hX;
                                   end else begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p2 20'hX;
                                   end
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCD_DLL_p2 dqp2_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                if (rdp2_tDC_p5 == 1'b1) begin
                                   dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #tDC_DLL_p2 30'hX;
                                   end else begin
                                      dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p2 30'hX;
                                   end
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #tCD_DLL_p2 dqp2_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                if (rdp2_tDC_p5 == 1'b1) begin
                                   dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p2 30'hx;
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p2 30'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p2 20'hx;
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p2 20'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/4) - 1) : 0]  <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/4) - 1) : 0]  <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                                dqp2_r[((`DT_S/4) - 1) : 0]  <= #tCD_DLL_p2 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p2 10'hx;
                                   dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p2 10'hZ;
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p2 20'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p2 20'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                                dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p2 20'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p2 10'hX;
                                      dqp2_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p2 20'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (3*(`DT_S/4))];
                                dqp2_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p2 20'hx;
                                end
                                dqp2_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p2 20'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p2 20'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p2 20'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p2 10'hZ; 
                                if(rdp2_con_p2 !== 1'b1) begin                                       
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p2 20'hX;
                                      dqp2_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p2 10'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p2 20'hX;
                                      dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p2 10'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (`DT_S/2)];
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p2 dqp2_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                if (rdp2_tDC_p5 == 1'b1) begin                    
                                   dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p2 10'hx;
                                end
                                dqp2_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p2 10'hZ;
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r[`DT_M : (`DT_S/4)] <= #tDC_DLL_p2 30'hX;
                                   end else begin
                                      dqp2_r[`DT_M : (`DT_S/4)] <= #tCKLZ_DLL_p2 30'hX;
                                   end
                                end
                                dqp2_r[`DT_M : (`DT_S/4)] <= #tCD_DLL_p2 dqp2_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                if(rdp2_con_p2 !== 1'b1) begin                                        
                                   if (rdp2_tDC_p5 == 1'b1) begin
                                      dqp2_r <= #tDC_DLL_p2 `DT_S'hX;
                                   end else begin
                                      dqp2_r <= #tCKLZ_DLL_p2 `DT_S'hX;
                                   end
                                end
                                dqp2_r <= #tCD_DLL_p2  dqp2_p4;
                             end
                           endcase // case(rdp2_en_p4)
                        end // if (!((cnthldp2_en_p4 == 1'b1) && (last_opernp2_p4 === `READ) && (last_opernp2_p5 === `READ)))
                     end // if ((!oe_n2_event) && (oe_n2 === 0) && (cpp2_event) && (cpp2 === 1))
                     //--------------------------------------------            
                     else if ((!oe_np2_event) && (oe_np2 === 1) && (tOHZ_overp2_f == 1'b0) && (clkp2_event) && (cpp2 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Two Data outputs from clk when OE is high", $realtime);
                        if (!((cnthldp2_en_p4 == 1'b1) && (last_opernp2_p3 === `READ) && (last_opernp2_p4 === `READ))) begin
                           dqp2_r <= #tCKHZ_min_DLL_p2 `DT_S'hZ;   
                        end // if (!((cnthldp2_en_p4 == 1'b1) && (last_opernp2_p4 === `READ) && (last_opernp2_p5 === `READ)))
                     end // if ((!oe_np2_event) && (oe_np2 === 1) && (tOHZ_overp2_f == 1'b0) && (cpp2_event) && (cpp2 === 1))
                     else if ((!oe_np2_event) && (oe_np2 === 1) && (tOHZ_overp2_f == 1'b1) && (clkp2_event) && (cpp2 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Two Data outputs to High-Z from clk when OE is high", $realtime);
                     end else if((oe_np2_event) && (oe_np2 == 1'bx)) begin
                        no_use = chk_x_oe("OE_NP2",oe_np2);         
                     end
                  end // (if (!(doff_np2_event === 1'b1)) && doff_np2_pos_event)
                  
               end // fork branch
               //********************************************************************************************************
               // PORT 3 
               //********************************************************************************************************

               begin
                  
                  if (!((doff_np3_event === 1'b1) && doff_np3_pos_event)) begin
                     if ((clkp3_event) && (cpp3 === 1)) begin // Port Three clock Active
                        cntp3_reg_p3 = cntp3_reg_p2;//ver 3.0 PAL            
                        cntp3_reg_p2 = cntp3_reg_p1;//ver 3.0 PAL
                        cntp3_reg_p1 = cntp3_reg;//ver 3.0 PAL

                        p3_1 = 1'b0;//ver 3.41 PAL
                        p3_2 = 1'b0;//ver 3.41 PAL
                        p3_4 = 1'b0;//ver 3.41 PAL

                        p3_1_w = 1'b0;//ver 3.41 PAL
                        p3_2_w = 1'b0;//ver 3.41 PAL
                        p3_4_w = 1'b0;//ver 3.41 PAL

                        mirrorp3_loaded_en = 1'b0;
                        cntintp3_en_p2 = cntintp3_en_p1;//ver 3.0 PAL
                        cntintp3_en_p1 = 1'b0;

                        dqp3_w2 = dqp3_w1; //ver 3.0 PAL
                        
                        wrp3_en_p2 = wrp3_en_p1; // pipeline write enable signal //ver 3.0 PAL

                        opernp3_type_p1 = opernp3_type; //ver 3.2 PAL            

                        wrp3_flag_p2 = wrp3_flag_p1;//ver 3.0 PAL
                        wrp3_flag_p1 = 1'b0;        //ver 3.0 PAL

                        rdp3_violation_p2 = rdp3_violation_p1;//ver 3.0 PAL
                        rdp3_violation_p1 = 1'b0;             //ver 3.0 PAL
                        
                        dqp3_p4 = dqp3_p3;       // pipeline data
                        dqp3_p3 = `DT_S'hx; //ver 3.0 PAL
                        
                        rdp3_en_p4 = rdp3_en_p3; // pipeline read enable signal
                        rdp3_en_p3 = rdp3_en_p2; // pipeline read enable signal
                        rdp3_en_p2 = rdp3_en_p1; // pipeline read enable signal

                        rdp3_con_p2 = rdp3_con_p1;//ver 3.0 PAL
                        rdp3_con_p1 = 1'b0;       //ver 3.0 PAL
                        
                        rdp3_tDC_p5 = rdp3_tDC_p4; //pipeline of control signal for tDC
                        rdp3_tDC_p4 = rdp3_tDC_p3; //pipeline of control signal for tDC
                        rdp3_tDC_p3 = rdp3_tDC_p2; //pipeline of control signal for tDC
                        rdp3_tDC_p2 = rdp3_tDC_p1; //pipeline of control signal for tDC
                        rdp3_tDC_p1 = 1'b0;
                        rdp3_tAC_p5 = rdp3_tAC_p4; //pipeline of control signal for tAC//ver 2.0 Palani
                        rdp3_tAC_p4 = rdp3_tAC_p3; //pipeline of control signal for tAC
                        rdp3_tAC_p3 = rdp3_tAC_p2; //pipeline of control signal for tAC
                        rdp3_tAC_p2 = rdp3_tAC_p1; //pipeline of control signal for tAC
                        rdp3_tAC_p1 = 1'b0;
                        rdp3_tAC_dis <= #tAC rdp3_tAC_p5;
                        
                        tOEp3_over_chk = $realtime;
                        
                        last_opernp3_p4 = last_opernp3_p3;
                        last_opernp3_p3 = last_opernp3_p2;
                        last_opernp3_p2 = last_opernp3_p1;
                        last_opernp3_p1 = 1'bx;
                        
                        mkp3_rd_en_p4 = mkp3_rd_en_p3;
                        mkp3_rd_en_p3 = mkp3_rd_en_p2;
                        mkp3_rd_en_p2 = mkp3_rd_en_p1;
                        mkp3_rd_en_p1 = 1'b0;
                        msk_disable_p3 <= #tCM mkp3_rd_en_p4;
                        mkp3_rd_con_p4 = mkp3_rd_con_p3;//ver 3.0 PAL
                        mkp3_rd_con_p3 = mkp3_rd_con_p2;//ver 3.0 PAL
                        mkp3_rd_con_p2 = mkp3_rd_con_p1;//ver 3.0 PAL
                        mkp3_rd_con_p1 = 1'b0;          //ver 3.0 PAL
                        
                        mkp3_rd_en_p5 = mkp3_rd_en_p4;            
                        mkp3_ld_en_p4 = mkp3_ld_en_p3;//ver 2.0 Palani
                        mkp3_ld_en_p3 = mkp3_ld_en_p2;
                        mkp3_ld_en_p2 = mkp3_ld_en_p1;
                        mkp3_ld_en_p1 = 1'b0;

                        cntp3_rd_en_p5 = cntp3_rd_en_p4;            
                        cntp3_rd_en_p4 = cntp3_rd_en_p3;
                        cntp3_rd_en_p3 = cntp3_rd_en_p2;
                        cntp3_rd_en_p2 = cntp3_rd_en_p1;
                        cntp3_rd_en_p1 = 1'b0;
                        cnt_disable_p3 <= #tCA cntp3_rd_en_p4;
                        
                        cntp3_rd_con_p4 = cntp3_rd_con_p3;//ver 3.0 PAL
                        cntp3_rd_con_p3 = cntp3_rd_con_p2;//ver 3.0 PAL
                        cntp3_rd_con_p2 = cntp3_rd_con_p1;//ver 3.0 PAL
                        cntp3_rd_con_p1 = 1'b0;           //ver 3.0 PAL


                        mkp3_rdbk_p4 = mkp3_rdbk_p3;
                        mkp3_rdbk_p3 = mkp3_rdbk_p2;
                        mkp3_rdbk_p2 = mkp3_rdbk_p1;
                        mkp3_rdbk_p1 = `AD_S'hx;


                        cntp3_rdbk_p4 = cntp3_rdbk_p3;
                        cntp3_rdbk_p3 = cntp3_rdbk_p2;
                        cntp3_rdbk_p2 = cntp3_rdbk_p1;
                        cntp3_rdbk_p1 = `AD_S'hx;
                        
                        cnthldp3_en_p4 = cnthldp3_en_p3;
                        cnthldp3_en_p3 = cnthldp3_en_p2;
                        cnthldp3_en_p2 = cnthldp3_en_p1;
                        cnthldp3_en_p1 = 1'b0;

                        mailintp3_en_p2 = mailintp3_en_p1;

                        casez ({cntrst_np3,mkld_np3,cntld_np3,retx_np3,cntinc_np3,cntrd_np3,mkrd_np3})
                          7'b0??????: begin //resets unmasked burst counter bits
                             if (DmsgOn) $display("%t Model := Reseting Counter at Port Three ", $realtime);
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp3_reg[i] == 1'b1)begin // Reset only unmasked region 
                                   cntp3_reg[i] = 1'b0;
                                end
                             end
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             mirrorp3_reg = cntp3_reg; 
                             opernp3_type = `CNTRST;
                          end
                          7'b10?????: begin //load mask register
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             if (chk_x_a("A_P3", ap3)) begin
                                mkp3_reg = `AD_S'hx;
                                opernp3_type = `MASKLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Mask Register at Port Three ", $realtime);
                                mkp3_reg = ap3;
                                mkp3_ld_en_p1 = 1'b1;//ver 2.0 Palani
                                cnthldp3_en_p1 = 1'b1;
                                rdp3_en_p1 = 4'b0000;
                                rdp3_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd//ver 2.0 Palani
                                opernp3_type = `MASKLD;
                             end
                          end
                          // -------------
                          // ver 3.0 PAL
                          // -------------
                          7'b110????: begin //load counter with address
                             if (chk_x_a("A_P3", ap3)) begin
                                cntp3_reg = `AD_S'hx; 
                                opernp3_type = `CNTLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Counter with Address at Port Three ", $realtime);
                                cntp3_reg = ap3;
                                mirrorp3_reg = ap3;
                                opernp3_type = `CNTLD;
                             end
                          end
                          7'b1110???: begin //load counter with mirror register value
                             if (DmsgOn) $display("%t Model := Loading Counter with Mirror Register at Port Three ", $realtime);
                             cntp3_reg = mirrorp3_reg;        // load mirror reg into counter reg for Retx
                             opernp3_type  = `RETX;
                          end
                          7'b11110??: begin //counter increment
                             if (DmsgOn) $display("%t Model := Counter Increment at Port Three ", $realtime);
                             
                             // -------------
                             // ver 3.11 PAL
                             // -------------
                             temp_f3 = 1'b1;
                             temp_msk_p3 = mkp3_reg;
                             
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp3_reg[i] == 1'b1)begin
                                   if(temp_msk_p3[i] != cntp3_reg[i]) temp_f3 = 1'b0;
                                end
                             end
                             if (temp_f3 == 1'b1) begin
                                mirrorp3_load = 1'b1;//ver 3.11 PAL   
                             end

                             if (mirrorp3_load == 1'b1) begin  //ver 3.0 PAL//ver 3.11 PAL//ver 3.2 PAL        
                                mirrorp3_load = 1'b0;//ver 3.11 PAL                       
                                mirrorp3_loaded_en = 1'b1;       // Don't increment cnt on the same edge of clk
                                if((chk_x_wrp0("WRP0_NP3",wrp0_np3)) == 0)begin
                                   if (wrp0_np3 == 1'b1) begin 
                                      cntp3_reg = mirrorp3_reg;     // load mirror reg into counter reg after reaching max value
                                   end else begin
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                      for(i = 0; i < 16; i = i + 1)begin
                                         if(mkp3_reg[i] == 1'b1)begin // Reset only unmasked region 
                                            cntp3_reg[i] = 1'b0;
                                         end
                                      end
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                   end
                                end
                                else begin
                                   cntp3_reg = mirrorp3_reg;     // load mirror reg into counter reg after reaching max value
                                end
                             end
                             
                             if (cntp3_reg !== mkp3_reg)begin
                                if (mirrorp3_loaded_en == 1'b0) begin
                                   // Increment unmasked region only
                                   tempA_reg3 = cntp3_reg;
                                   cnt_p3 = `AD_S'h0;
                                   no_of_mask_p3 = 0;
                                   k3 = 0;
                                   for (i = 0; i < 16; i = i + 1) begin
                                      if(mkp3_reg[i] == 1'b1)begin
                                         cnt_p3[no_of_mask_p3] = cntp3_reg[i];
                                         no_of_mask_p3 = no_of_mask_p3+1;
                                      end
                                   end
                                   cnt_p3 = cnt_p3 + 1;
                                   
                                   for (j = 0; j < 16; j = j + 1) begin
                                      if(mkp3_reg[j] == 1'b1) begin
                                         tempA_reg3[j] = cnt_p3 [k3];
                                         k3 = k3 + 1;
                                      end
                                   end
                                   cntp3_reg = tempA_reg3;
                                end
                             end

                             // -------------
                             // ver 3.0 PAL
                             // -------------

                             opernp3_type = `CNTINC;    
                          end
                          
                          7'b111110?: begin //counter readback
                             if (DmsgOn) $display("%t Model := Reading back the counter at Port Three ", $realtime);
                             cntp3_rd_en_p1 = 1'b1;
                             cntp3_rdbk_p1 = cntp3_reg;
                             if(cntp3_rdbk_p2 == cntp3_rdbk_p1) cntp3_rd_con_p1 = 1'b1;//ver 3.0 PAL     
                             rdp3_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp3_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd
                             rdp3_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp3_type = `CNTRD;
                          end
                          7'b1111110: begin //mask register readback
                             if (DmsgOn) $display("%t Model := Mask Readback operation at Port Three ", $realtime);
                             mkp3_rd_en_p1 = 1'b1;
                             mkp3_rdbk_p1 = mkp3_reg;
                             if(mkp3_rdbk_p2 == mkp3_rdbk_p1) mkp3_rd_con_p1 = 1'b1;//ver 3.0 PAL             
                             rdp3_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp3_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                             rdp3_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp3_type = `MASKRD;
                          end
                          7'b1111111: begin //counter hold
                             cnthldp3_en_p1 = 1'b1;
                             opernp3_type = `CNTHLD;
                          end
                          default: begin
                             cnthldp3_en_p1 = 1'b1;
                             opernp3_type = `NONE;
                             no_use = chk_x_cntrst("CNTRST_NP3",cntrst_np3);
                             no_use = chk_x_mkld("MKLD_NP3",mkld_np3);
                             no_use = chk_x_cntld("CNTLD_NP3",cntld_np3);
                             no_use = chk_x_retx("RETX_NP3",retx_np3);
                             no_use = chk_x_cntinc("CNTINC_NP3",cntinc_np3);
                             no_use = chk_x_cntrd("CNTRD_NP3",cntrd_np3);
                             no_use = chk_x_mkrd("MKRD_NP3",mkrd_np3);
                          end
                        endcase // casez({cntrst_np3,mkld_np3,cntld_np3,retx_np3,cntinc_np3,cntrd_np3,mkrd_np3})
                        //------------            
                        //ver 3.2 PAL
                        //------------            
                        //chk for cnt interrupt
                        if(mkp3_reg !== `AD_S'h0000)begin
                           temp_reg3 = `AD_S'h0;
                           cnt_p3 = `AD_S'h0;
                           no_of_mask_p3 = 0;
                           k3 = 0;
                           for (i = 0; i < 16; i = i + 1) begin
                              if(mkp3_reg[i] == 1'b1)begin
                                 cnt_p3[no_of_mask_p3] = mkp3_reg[i];
                                 no_of_mask_p3 = no_of_mask_p3+1;
                              end
                           end
                           cnt_p3 = cnt_p3 - 1;
                           
                           for (j = 0; j < 16; j = j + 1) begin
                              if(mkp3_reg[j] == 1'b1) begin
                                 temp_reg3[j] = cnt_p3 [k3];
                                 k3 = k3 + 1;
                              end
                           end
                           
                           temp_f3 = 1'b1;
                           temp_msk_p3 = temp_reg3;
                           unknown_cntint_p3 = (^cntp3_reg) ^ (^mkp3_reg); //ver 3.21 PAL
                           
                           if((unknown_cntint_p3 == 1'b1) || (unknown_cntint_p3 == 1'b0)) begin //ver 3.21 PAL     
                              
                              for(i = 0; i < 16; i = i + 1)begin
                                 if(mkp3_reg[i] == 1'b1)begin
                                    if(temp_msk_p3[i] != cntp3_reg[i]) temp_f3 = 1'b0;
                                 end
                              end
                              if (temp_f3 == 1'b1) begin
                                 cntintp3_en_p1 = 1'b1;
                              end
                           end else begin           //ver 3.21 PAL
                              cntintp3_en_p1 = 1'bx;//ver 3.21 PAL
                           end                      //ver 3.21 PAL 
                           
                        end
                        //------------            
                        //ver 3.2 PAL
                        //------------            

                        if (!((opernp3_type == `MASKRD) || (opernp3_type == `CNTRD) || (opernp3_type == `MASKLD))) begin
                           // Drive Data outputs from this block only when mrst_n is high
                           if ((ce0_np3 === 0) && (ce1p3 === 1) && (r_w_np3 === 1) && (ready_set_p3 == 1'b1 )) begin  // Read operation
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 case (b_np3)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1111;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1110;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0010: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1101;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0011: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1100;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1011;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0101: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1010;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0110: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1001;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b1000;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1000: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0111;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1001: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0110;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0101;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1011: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0100;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1100: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0011;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0010;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1110: begin
                                      if (DmsgOn) $display("%t Model := Port3 Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0001;
                                      rdp3_tDC_p1 = 1'b1;
                                      if (cntp3_reg == `LAST_ADR - 2)  mailintp3_en_p1 = 1'b0;// Mailbox interrupt Ack for Port3
                                   end
                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port3 No Byte Read Operation", $realtime);
                                      rdp3_en_p1 = 4'b0000;
                                      rdp3_tDC_p1 = 1'b0;
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP3",b_np3);                       
                                      rdp3_en_p1 = 4'b0000; // disable outputs
                                      rdp3_tDC_p1 = 1'b0;
                                   end
                                 endcase // case(b_np3)
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if ((ce0_np3 === 0) && (ce1p3 === 1) && (r_w_np3 === 0)) begin // if ((ce0_np3 === 0) && (ce1p3 === 1) && (r_w_np3 === 1)) //write operation//ver 3.21 PAL
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 rdp3_en_p1 = 4'b0000;
                                 rdp3_en_p2 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp3_en_p3 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp3_en_p4 = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp3_tDC_p1 = 1'b0;
                                 rdp3_tDC_p2 = 1'b0;
                                 rdp3_tDC_p3 = 1'b0;
                                 rdp3_tDC_p4 = 1'b0;
                                 rdp3_tDC_p5 = 1'b0;

                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                                 case(b_np3)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0000;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0001;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0010:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0010;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0011:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0011;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0100;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0101:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0101;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR)  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0110:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0110;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b0111;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1000:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1000;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1001:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1001;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1010;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1011:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1011;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1100:begin
                                      if (DmsgOn) $display("%t Model := Port3 Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1100;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port3 Upper Byte Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1101;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 2)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1110:begin
                                      if (DmsgOn) $display("%t Model := Port3 Upper Byte Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1110;//ver 3.0 PAL
                                      dqp3_w1 = dqp3;      //ver 3.0 PAL
                                      if (cntp3_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 2)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_3;
                                      end
                                      else if (cntp3_reg == `LAST_ADR - 3)  begin
                                         mailintp4_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox4_by = `MAILBOX_3;
                                      end
                                   end

                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port3 No Write Operation", $realtime);
                                      wrp3_flag_p1 = 1'b0; //ver 3.0 PAL
                                      wrp3_en_p1 = 4'b1111;//ver 3.0 PAL
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP3", b_np3);
                                   end
                                 endcase // case(b_np3)
                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------                                          
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if((ce0_np3 === 0) && (ce1p3 === 1) && (r_w_np3 === 1) && (ready_set_p3 == 1'b0)) begin//ver 3.21 PAL
                              if (DmsgOn) $display("%t \t Model ERROR := READ operation is not allowed when the READY_NP3 is deasserted", $realtime);
                           end else if ((ce0_np3 === 0) && (ce1p3 === 1)) begin // if ((ce0_np3 === 0) && (ce1p3 === 1) && (r_w_np3 === 0))
                              no_use = chk_x_r_w("R/W_NP3",r_w_np3);                  
                           end else if (!((ce0_np3 === 0) && (ce1p3 === 1))) begin // if ((ce0_np3 === 0) && (ce1p3 === 1) && (r_w_np3 === 0))
                              if (DmsgOn) $display("%t Model := Port3 Deselected", $realtime);
                              wrp3_flag_p1 = 1'b0; //ver 3.0 PAL
                              wrp3_en_p1 = 4'b1111;//ver 3.0 PAL
                              rdp3_en_p1 = 4'b0000;
                              rdp3_tDC_p1 = 1'b0;
                           end
                        end // if (!((opernp3_type == `MASKRD) || (opernp3_type == `CNTRD)))
                        //-----------------------------------------
                        // Driving the outputs
                        if (reset_over == 1) begin
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           if(rdp3_tDC_p2 == 1'b1)begin
                              last_addr_p3 = cntp3_reg_p1;
                              last_opernp3_p1 = `READ;            
                              #0;
                              rdp3_violation_p1 = read_tCCS_chk_fn(`port3);
                              last_port = `port3;              //ver 3.12 PAL
                           end
                           if(rdp3_tDC_p3 == 1'b1)begin
                              dqp3_p3 = read_data_fn(`port3);
                              if((cntp3_reg_p3 == cntp3_reg_p2) && (dqp3_p4 == dqp3_p3))begin
                                 rdp3_con_p1 = 1'b1;
                              end else begin
                                 rdp3_con_p1 = 1'b0;
                              end
                           end
                           // Pipelined Write Operation
                           if(wrp3_flag_p2 == 1'b1)begin
                              case(wrp3_en_p2)
                                4'b0000: begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   #0;
                                   mem [cntp3_reg_p1] = write_data_and_tCCS_chk_fn(`port3);
                                   
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0001:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];                    // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M:(`DT_S)/4] , tempD_reg1_p3[((`DT_S)/4 - 1):0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0010:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M:(`DT_S)/2] , tempD_reg1_p3[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p3[((`DT_S)/4 - 1):0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0011:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M:(`DT_S)/2] , tempD_reg1_p3[((`DT_S/2) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0100:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M:(3*(`DT_S/4))] , tempD_reg1_p3[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p3[((`DT_S/2) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0101:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M : (3*(`DT_S/4))], tempD_reg1_p3[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p3[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p3[((`DT_S/4) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0110:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M : (3*(`DT_S/4))], tempD_reg1_p3[(3*(`DT_S/4) - 1) : (`DT_S/4)],tempD_reg2_p3[((`DT_S/4) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b0111:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg2_p3[`DT_M : (3*(`DT_S/4))] , tempD_reg1_p3[(3*(`DT_S/4) - 1) :0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1000:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (3*(`DT_S/4))],tempD_reg2_p3[(3*(`DT_S/4) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1001:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (3*(`DT_S/4))],tempD_reg2_p3[(3*(`DT_S/4) - 1) : (`DT_S/4)]  , tempD_reg1_p3[((`DT_S/4) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1010:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (3*(`DT_S/4))],tempD_reg2_p3[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p3[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p3[((`DT_S/4) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1011:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (3*(`DT_S/4))],tempD_reg2_p3[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p3[((`DT_S/2) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1100:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (`DT_S/2)], tempD_reg2_p3[((`DT_S/2) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1101:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (`DT_S/2)],tempD_reg2_p3[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p3[((`DT_S/4) - 1) : 0] };
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                4'b1110:begin
                                   last_addr_p3 = cntp3_reg_p1;
                                   last_opernp3_p1 = `WRITE;            
                                   tempD_reg1_p3 = mem[cntp3_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p3 = write_data_and_tCCS_chk_fn(`port3);// save the current data temporarily
                                   mem[cntp3_reg_p1] = {tempD_reg1_p3[`DT_M : (`DT_S/4)],tempD_reg2_p3 [((`DT_S/4) - 1) : 0]};
                                   last_port = `port3;//ver 3.12 PAL
                                end
                                default: begin
                                   last_addr_p3 = 16'hX;
                                   last_opernp3_p1 = `WRITE;            
                                   last_port = `port3;//ver 3.12 PAL
                                end
                              endcase // case(wrp3_en_p2)
                           end // if (wrp3_flag_p2 == 1'b1)
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           // Drive Address outputs from clk edge
                           if (mkp3_rd_en_p4 == 1'b1) begin
			                  if (mkp3_rd_con_p4 !== 1'b1) begin//ver 3.0 PAL
                                 ap3_r <= # tCKLZA `AD_S'hX;
                              end
                              ap3_r <= # tCM mkp3_rdbk_p4;
                           end else if (cntp3_rd_en_p4 == 1'b1) begin
			                  if (cntp3_rd_con_p4 !== 1'b1) begin  //ver 3.0 PAL
                                 ap3_r <= # tCKLZA `AD_S'hX; 
                              end
                              ap3_r <= # tCA cntp3_rdbk_p4;
                           end else begin //ver 2.0 Palani
                              if(rdp3_tAC_p5 == 1'b1)begin
                                 ap3_r <= # tAC `AD_S'hX;
                                 ap3_r <= # tCKHZA_min `AD_S'hx;
                                 ap3_r <= # tCKHZA_max `AD_S'hZ;
                              end else begin
                                 if((mkp3_rd_en_p5 == 1'b1) || (cntp3_rd_en_p5 == 1'b1))begin                 
                                    ap3_r <= # tCKHZA_min `AD_S'hx;
                                    ap3_r <= # tCKHZA_max `AD_S'hZ;
                                 end else begin
                                    ap3_r <= `AD_S'hZ;                        
                                 end
                              end
                           end
                           
                           // Drive Cntint interrupt pin from clk edge
                           if (cntintp3_en_p2 == 1'b1) begin
                              cntint_np3 <= #tSCINT 1'b0;
                              cntintp3_set <= 1'b1;//ver 3.2 PAL                  
                           end else if (cntintp3_en_p2 === 1'bx) begin //ver 3.21 PAL
                              cntint_np3 <= #tSCINT 1'bx;              //ver 3.21 PAL
                              cntintp3_set <= 1'b1;                    //ver 3.21 PAL
                           end                                         //ver 3.21 PAL 
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           if(((cntintp3_set == 1'b1) && !(((cntintp3_en_p1 == 1'b1) && (cntintp3_en_p2 == 1'b1))|| (cntintp3_en_p2 === 1'bx))) && ((opernp3_type_p1 == `CNTINC) || (opernp3_type_p1 == `CNTRST) || (opernp3_type_p1 == `CNTLD) || (opernp3_type_p1 == `MASKLD))) begin//ver 3.21 PAL
                              cntint_np3 <= #tRCINT 1'b1;
                              cntintp3_set <= 1'b0;//ver 3.2 PAL                     
                           end
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           
                           // Set port one,two,four Mailbox interrupt pin from clk edge with one clk latency
                           if ((mailintp1_en_p2 == 1'b1)      && (mailbox1_by == `MAILBOX_3))begin
                              int_np1 <= #tSINT 1'b0;
                              mailbox1_by = `MAILBOX_NONE;
                           end                                                              
                           else if ((mailintp2_en_p2 == 1'b1) && (mailbox2_by == `MAILBOX_3))begin
                              int_np2 <= #tSINT 1'b0;                                       
                              mailbox2_by = `MAILBOX_NONE;                  
                           end                                                              
                           else if ((mailintp4_en_p2 == 1'b1) && (mailbox4_by == `MAILBOX_3))begin
                              int_np4 <= #tSINT 1'b0;
                              mailbox4_by = `MAILBOX_NONE;                  
                           end
                           //Reset port two mailbox interrupt pin from clk edge with one clk latency
                           if (mailintp3_en_p2 == 1'b0) begin
                              int_np3 <= #tRINT 1'b1;
                           end
                        end

                        //-----------------------------------------
                        //X-handling
                        no_use = chk_x_ce0("CE0_NP3",ce0_np3);
                        no_use = chk_x_ce1("CE1_P3",ce1p3);
                        
                     end // if ((clkp3_event) && (cpp3 === 1))
                     //---------------------------------------------------------------------------------

                     // Drive Data outputs from this block only when mrst_n is high
                     if ((oe_np3_event) && (oe_np3 === 0)) begin            // outputs from oe low event
                        oep3_pulse_chk = $realtime;
                        tOEp3_over_chk = $realtime;
                        tOHZ_overp3_f = 1'b0; 
                        tOEp3_int <= #tOE ~tOEp3_int;
                        
                        if (DmsgOn) $display("%t Model := Drive Port Three Data outputs from oe", $realtime);
                        case (rdp3_en_p4)
                          4'b0000: begin
                             dqp3_r <= #tOLZ `DT_S'hZ; // This is reqd only during initialization of model.tOLZ is min.
                          end
                          4'b0001: begin
                             dqp3_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0010: begin
                             dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b0011: begin
                             dqp3_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b0100: begin
                             dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                          end
                          4'b0101: begin
                             dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                             dqp3_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0110: begin
                             dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tOLZ 20'hX;
                          end
                          4'b0111: begin
                             dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #tOLZ 30'hX;
                          end
                          4'b1000: begin
                             dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                          end
                          4'b1001: begin
                             dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp3_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1010: begin
                             dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b1011: begin
                             dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp3_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b1100: begin
                             dqp3_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                          end
                          4'b1101: begin
                             dqp3_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                             dqp3_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1110: begin
                             dqp3_r[`DT_M : (`DT_S/4)] <= #tOLZ 30'hX;
                          end
                          4'b1111: begin
                             dqp3_r <= #tOLZ `DT_S'hX;
                          end
                        endcase // case(rdp3_en_p4)
                     end // if ((oe_np3_event) && (oe_np3 === 0))
                     else if ((oe_np3_event) && (oe_np3 === 1) && (!oep3_int_event)) begin   // outputs from oe high event
                        oep3_pulse_chk = $realtime;
                        oep3_int <=  ~oep3_int;
                     end
                     else if (!((oe_np3_event) && (oe_np3 === 0)) && (oep3_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port Three Data Outputs High-Z", $realtime);
                        tOHZ_overp3_f = 1'b1; 
                        dqp3_r <= #tOHZ_min `DT_S'hx;
                        dqp3_r <= #tOHZ_max `DT_S'hZ;
                     end
                     else if (!((oe_np3_event) && (oe_np3 === 0)) && (tOEp3_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port Three Data outputs from oe", $realtime);
                        if (($realtime - tOEp3_over_chk) >= tOE) begin
                           case (rdp3_en_p4)
                             4'b0000: begin
                                dqp3_r <= #0 `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
                             end
                             4'b0001: begin
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #0 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0010: begin
                                dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp3_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                dqp3_r[((`DT_S/2) - 1) : 0] <= #0 dqp3_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp3_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp3_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #0 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #0 dqp3_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #0 dqp3_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #0 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                                dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp3_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                                dqp3_r[((`DT_S/2) - 1) : 0] <= #0 dqp3_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                dqp3_r[`DT_M :(`DT_S/2)] <= #0 dqp3_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                dqp3_r[`DT_M : (`DT_S/2)] <= #0 dqp3_p4[`DT_M : (`DT_S/2)];
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #0 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                dqp3_r[`DT_M : (`DT_S/4)] <= #0 dqp3_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                dqp3_r <= #0 dqp3_p4;
                             end
                           endcase // case(rdp3_en_p4)
                        end // if (($realtime - tOEp3_over_chk) >= tOE)
                     end // if (!((oe_np3_event) && (oe_np3 === 0)) && (tOEp3_int_event))
                     else if ((!oe_np3_event) && (oe_np3 === 0) && (clkp3_event) && (cpp3 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Three Data outputs from clk ", $realtime);
                        if (!((cnthldp3_en_p4 == 1'b1) && (last_opernp3_p3 === `READ) && (last_opernp3_p4 === `READ))) begin
                           case (rdp3_en_p4)
                             4'b0000: begin
                                if ((cntp3_rd_en_p4 == 1'b0) && (mkp3_rd_en_p4 == 1'b0) && (mkp3_ld_en_p4 == 1'b0)) begin  // In mkrd and cntrd modes outputs should go to High-Z only and not the Low-Z.//ver 2.0 Palani
                                   if(rdp3_con_p2 !== 1'b1) begin
                                      if (rdp3_tDC_p5 == 1'b1) begin
                                         dqp3_r <= #tDC_DLL_p3 `DT_S'hX;
                                      end
                                   end
                                end
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r <= #tCKHZ_min_DLL_p3 `DT_S'hx;
                                end
                                dqp3_r <= #tCKHZ_max_DLL_p3 `DT_S'hZ;
                             end
                             4'b0001: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                                        
                                   dqp3_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_min_DLL_p3 30'hx;
                                end
                                dqp3_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_max_DLL_p3 30'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/4)-1) : 0];
                             end
                             4'b0010: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_min_DLL_p3 20'hx;
                                   dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_max_DLL_p3 20'hZ;
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                                        
                                   dqp3_r[`DT_M : (`DT_S/2)] <= #tCKHZ_min_DLL_p3 20'hx;
                                end
                                dqp3_r[`DT_M : (`DT_S/2)] <= #tCKHZ_max_DLL_p3 20'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p3 20'hX;
                                   end else begin
                                      dqp3_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p3 20'hX;
                                   end
                                end
                                dqp3_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                                        
                                   dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p3 10'hx;
                                   dqp3_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p3 20'hx;
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p3 10'hZ;
                                dqp3_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p3 20'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p3 dqp3_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p3 10'hx;
                                   dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p3 10'hZ;
                                dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p3 dqp3_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                if (rdp3_tDC_p5 == 1'b1) begin
                                   dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p3 10'hx;
                                   dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p3 10'hx;
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p3 10'hZ;
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tDC_DLL_p3 20'hX;
                                   end else begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p3 20'hX;
                                   end
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCD_DLL_p3 dqp3_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #tDC_DLL_p3 30'hX;
                                   end else begin
                                      dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p3 30'hX;
                                   end
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #tCD_DLL_p3 dqp3_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p3 30'hx;
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p3 30'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p3 20'hx;
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p3 20'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/4) - 1) : 0]  <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/4) - 1) : 0]  <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                                dqp3_r[((`DT_S/4) - 1) : 0]  <= #tCD_DLL_p3 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                if (rdp3_tDC_p5 == 1'b1) begin
                                   dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p3 10'hx;
                                   dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p3 10'hZ;
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p3 20'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p3 20'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                                dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p3 20'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p3 10'hX;
                                      dqp3_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p3 20'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (3*(`DT_S/4))];
                                dqp3_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p3 20'hx;
                                end
                                dqp3_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p3 20'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p3 20'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p3 20'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p3 20'hX;
                                      dqp3_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p3 10'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p3 20'hX;
                                      dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p3 10'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (`DT_S/2)];
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p3 dqp3_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                if (rdp3_tDC_p5 == 1'b1) begin                    
                                   dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p3 10'hx;
                                end
                                dqp3_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p3 10'hZ;
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r[`DT_M : (`DT_S/4)] <= #tDC_DLL_p3 30'hX;
                                   end else begin
                                      dqp3_r[`DT_M : (`DT_S/4)] <= #tCKLZ_DLL_p3 30'hX;
                                   end
                                end
                                dqp3_r[`DT_M : (`DT_S/4)] <= #tCD_DLL_p3 dqp3_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                if(rdp3_con_p2 !== 1'b1) begin                    
                                   if (rdp3_tDC_p5 == 1'b1) begin
                                      dqp3_r <= #tDC_DLL_p3 `DT_S'hX;
                                   end else begin
                                      dqp3_r <= #tCKLZ_DLL_p3 `DT_S'hX;
                                   end
                                end
                                dqp3_r <= #tCD_DLL_p3  dqp3_p4;
                             end
                           endcase // case(rdp3_en_p4)
                        end // if (!((cnthldp3_en_p4 == 1'b1) && (last_opernp3_p4 === `READ) && (last_opernp3_p5 === `READ)))
                     end // if ((!oe_n3_event) && (oe_n3 === 0) && (cpp3_event) && (cpp3 === 1))
                     //--------------------------------------------            
                     else if ((!oe_np3_event) && (oe_np3 === 1) && (tOHZ_overp3_f == 1'b0) && (clkp3_event) && (cpp3 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Three Data outputs from clk when OE is high", $realtime);
                        if (!((cnthldp3_en_p4 == 1'b1) && (last_opernp3_p3 === `READ) && (last_opernp3_p4 === `READ))) begin
                           dqp3_r <= #tCKHZ_min_DLL_p3 `DT_S'hZ;   
                        end // if (!((cnthldp3_en_p4 == 1'b1) && (last_opernp3_p4 === `READ) && (last_opernp3_p5 === `READ)))
                     end // if ((!oe_np3_event) && (oe_np3 === 1) && (tOHZ_overp3_f == 1'b0) && (cpp3_event) && (cpp3 === 1))
                     else if ((!oe_np3_event) && (oe_np3 === 1) && (tOHZ_overp3_f == 1'b1) && (clkp3_event) && (cpp3 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Three Data outputs to High-Z from clk when OE is high", $realtime);
                     end else if((oe_np3_event) && (oe_np3 == 1'bx)) begin
                        no_use = chk_x_oe("OE_NP3",oe_np3);         
                     end
                  end // (if (!(doff_np3_event === 1'b1)) && doff_np3_pos_event)
               end // fork branch
               //********************************************************************************************************
               // PORT 4 
               //********************************************************************************************************
               begin

                  if (!((doff_np4_event === 1'b1) && doff_np4_pos_event))begin
                     if ((clkp4_event) && (cpp4 === 1)) begin // Port Four clock Active
                        cntp4_reg_p3 = cntp4_reg_p2;//ver 3.0 PAL            
                        cntp4_reg_p2 = cntp4_reg_p1;//ver 3.0 PAL
                        cntp4_reg_p1 = cntp4_reg;//ver 3.0 PAL

                        p4_1 = 1'b0;//ver 3.41 PAL
                        p4_2 = 1'b0;//ver 3.41 PAL
                        p4_3 = 1'b0;//ver 3.41 PAL

                        p4_1_w = 1'b0;//ver 3.41 PAL
                        p4_2_w = 1'b0;//ver 3.41 PAL
                        p4_3_w = 1'b0;//ver 3.41 PAL

                        mirrorp4_loaded_en = 1'b0;
                        cntintp4_en_p2 = cntintp4_en_p1; //ver 3.0 PAL
                        cntintp4_en_p1 = 1'b0;
                        
                        dqp4_w2 = dqp4_w1; //ver 3.0 PAL
                        
                        wrp4_en_p2 = wrp4_en_p1; // pipeline write enable signal //ver 3.0 PAL

                        opernp4_type_p1 = opernp4_type; //ver 3.2 PAL            

                        wrp4_flag_p2 = wrp4_flag_p1;//ver 3.0 PAL
                        wrp4_flag_p1 = 1'b0;        //ver 3.0 PAL

                        rdp4_violation_p2 = rdp4_violation_p1;//ver 3.0 PAL
                        rdp4_violation_p1 = 1'b0;             //ver 3.0 PAL
                        
                        dqp4_p4 = dqp4_p3;       // pipeline data
                        dqp4_p3 = `DT_S'hx;//ver 3.0 PAL
                        
                        rdp4_en_p4 = rdp4_en_p3; // pipeline read enable signal
                        rdp4_en_p3 = rdp4_en_p2; // pipeline read enable signal
                        rdp4_en_p2 = rdp4_en_p1; // pipeline read enable signal
                        
                        rdp4_con_p2 = rdp4_con_p1;//ver 3.0 PAL
                        rdp4_con_p1 = 1'b0;       //ver 3.0 PAL
                        
                        rdp4_tDC_p5 = rdp4_tDC_p4; //pipeline of control signal for tDC
                        rdp4_tDC_p4 = rdp4_tDC_p3; //pipeline of control signal for tDC
                        rdp4_tDC_p3 = rdp4_tDC_p2; //pipeline of control signal for tDC
                        rdp4_tDC_p2 = rdp4_tDC_p1; //pipeline of control signal for tDC
                        rdp4_tDC_p1 = 1'b0;
                        rdp4_tAC_p5 = rdp4_tAC_p4; //pipeline of control signal for tAC//ver 2.0 Palani
                        rdp4_tAC_p4 = rdp4_tAC_p3; //pipeline of control signal for tAC
                        rdp4_tAC_p3 = rdp4_tAC_p2; //pipeline of control signal for tAC
                        rdp4_tAC_p2 = rdp4_tAC_p1; //pipeline of control signal for tAC
                        rdp4_tAC_p1 = 1'b0;
                        rdp4_tAC_dis <= #tAC rdp4_tAC_p5;
                        
                        tOEp4_over_chk = $realtime;
                        
                        last_opernp4_p4 = last_opernp4_p3;
                        last_opernp4_p3 = last_opernp4_p2;
                        last_opernp4_p2 = last_opernp4_p1;
                        last_opernp4_p1 = 1'bx;
                        
                        mkp4_rd_en_p4 = mkp4_rd_en_p3;
                        mkp4_rd_en_p3 = mkp4_rd_en_p2;
                        mkp4_rd_en_p2 = mkp4_rd_en_p1;
                        mkp4_rd_en_p1 = 1'b0;
                        msk_disable_p4 <= #tCM mkp4_rd_en_p4;

                        mkp4_rd_en_p5 = mkp4_rd_en_p4;
                        mkp4_rd_con_p4 = mkp4_rd_con_p3;//ver 3.0 PAL
                        mkp4_rd_con_p3 = mkp4_rd_con_p2;//ver 3.0 PAL
                        mkp4_rd_con_p2 = mkp4_rd_con_p1;//ver 3.0 PAL
                        mkp4_rd_con_p1 = 1'b0;          //ver 3.0 PAL
                        
                        mkp4_ld_en_p4 = mkp4_ld_en_p3;//ver 2.0 Palani
                        mkp4_ld_en_p3 = mkp4_ld_en_p2;
                        mkp4_ld_en_p2 = mkp4_ld_en_p1;
                        mkp4_ld_en_p1 = 1'b0;            

                        cntp4_rd_en_p5 = cntp4_rd_en_p4;                        
                        cntp4_rd_en_p4 = cntp4_rd_en_p3;
                        cntp4_rd_en_p3 = cntp4_rd_en_p2;
                        cntp4_rd_en_p2 = cntp4_rd_en_p1;
                        cntp4_rd_en_p1 = 1'b0;
                        cnt_disable_p4 <= #tCA cntp4_rd_en_p4;            
                        cntp4_rd_con_p4 = cntp4_rd_con_p3;//ver 3.0 PAL
                        cntp4_rd_con_p3 = cntp4_rd_con_p2;//ver 3.0 PAL
                        cntp4_rd_con_p2 = cntp4_rd_con_p1;//ver 3.0 PAL
                        cntp4_rd_con_p1 = 1'b0;           //ver 3.0 PAL

                        mkp4_rdbk_p4 = mkp4_rdbk_p3;
                        mkp4_rdbk_p3 = mkp4_rdbk_p2;
                        mkp4_rdbk_p2 = mkp4_rdbk_p1;
                        mkp4_rdbk_p1 = `AD_S'hx;

                        cntp4_rdbk_p4 = cntp4_rdbk_p3;
                        cntp4_rdbk_p3 = cntp4_rdbk_p2;
                        cntp4_rdbk_p2 = cntp4_rdbk_p1;
                        cntp4_rdbk_p1 = `AD_S'hx;
                        
                        cnthldp4_en_p4 = cnthldp4_en_p3;
                        cnthldp4_en_p3 = cnthldp4_en_p2;
                        cnthldp4_en_p2 = cnthldp4_en_p1;
                        cnthldp4_en_p1 = 1'b0;

                        mailintp4_en_p2 = mailintp4_en_p1;

                        casez ({cntrst_np4,mkld_np4,cntld_np4,retx_np4,cntinc_np4,cntrd_np4,mkrd_np4})
                          7'b0??????: begin //resets unmasked burst counter bits
                             if (DmsgOn) $display("%t Model := Reseting Counter at Port Four", $realtime);
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp4_reg[i] == 1'b1)begin // Reset only unmasked region 
                                   cntp4_reg[i] = 1'b0;
                                end
                             end
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             mirrorp4_reg = cntp4_reg; 
                             opernp4_type = `CNTRST;
                          end
                          7'b10?????: begin //load mask register
                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             if (chk_x_a("A_P4", ap4)) begin
                                mkp4_reg = `AD_S'hx;
                                opernp4_type = `MASKLD;
                             end else begin
                                if (DmsgOn) $display("%t Model := Loading Mask Register at Port Four ", $realtime);
                                mkp4_reg = ap4;
                                mkp4_ld_en_p1 = 1'b1;//ver 2.0 Palani
                                cnthldp4_en_p1 = 1'b1;
                                rdp4_en_p1 = 4'b0000;
                                rdp4_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd//ver 2.0 Palani
                                opernp4_type = `MASKLD;
                             end
                          end
                          // -------------
                          // ver 3.0 PAL
                          // -------------
                          7'b110????: begin //load counter with address
                             if (chk_x_a("A_P4", ap4)) begin
                                cntp4_reg = `AD_S'hx; 
                                opernp4_type = `CNTLD;
                             end else begin
                                
                                if (DmsgOn) $display("%t Model := Loading Counter with Address at Port Four", $realtime);
                                cntp4_reg = ap4;
                                mirrorp4_reg = ap4;
                                opernp4_type = `CNTLD;
                             end
                          end
                          7'b1110???: begin //load counter with mirror register value
                             if (DmsgOn) $display("%t Model := Loading Counter with Mirror Register at Port Four", $realtime);
                             cntp4_reg = mirrorp4_reg;        // load mirror reg into counter reg for Retx
                             opernp4_type  = `RETX;
                          end
                          7'b11110??: begin //counter increment
                             if (DmsgOn) $display("%t Model := Counter Increment at Port Four", $realtime);
                             
                             // -------------
                             // ver 3.11 PAL
                             // -------------
                             temp_f4 = 1'b1;
                             temp_msk_p4 = mkp4_reg;
                             
                             for(i = 0; i < 16; i = i + 1)begin
                                if(mkp4_reg[i] == 1'b1)begin
                                   if(temp_msk_p4[i] != cntp4_reg[i]) temp_f4 = 1'b0;
                                end
                             end
                             if (temp_f4 == 1'b1) begin
                                mirrorp4_load = 1'b1;//ver 3.11 PAL   
                             end

                             if (mirrorp4_load == 1'b1) begin //ver 3.0 PAL//ver 3.11 PAL//ver 3.2 PAL   
                                mirrorp4_load = 1'b0;//ver 3.11 PAL                       
                                mirrorp4_loaded_en = 1'b1;       // Don't increment cnt on the same edge of clk
                                if((chk_x_wrp0("WRP0_NP4",wrp0_np4)) == 0)begin
                                   if (wrp0_np4 == 1'b1) begin 
                                      cntp4_reg = mirrorp4_reg;     // load mirror reg into counter reg after reaching max value
                                   end else begin
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                      for(i = 0; i < 16; i = i + 1)begin
                                         if(mkp4_reg[i] == 1'b1)begin // Reset only unmasked region 
                                            cntp4_reg[i] = 1'b0;
                                         end
                                      end
                                      // -------------
                                      // ver 3.0 PAL
                                      // -------------
                                   end
                                end
                                else begin
                                   cntp4_reg = mirrorp4_reg;     // load mirror reg into counter reg after reaching max value
                                end
                             end
                             
                             if (cntp4_reg !== mkp4_reg)begin
                                if (mirrorp4_loaded_en == 1'b0) begin
                                   // Increment unmasked region only
                                   tempA_reg4 = cntp4_reg;
                                   cnt_p4 = `AD_S'h0;
                                   no_of_mask_p4 = 0;
                                   k4 = 0;
                                   for (i = 0; i < 16; i = i + 1) begin
                                      if(mkp4_reg[i] == 1'b1)begin
                                         cnt_p4[no_of_mask_p4] = cntp4_reg[i];
                                         no_of_mask_p4 = no_of_mask_p4+1;
                                      end
                                   end
                                   cnt_p4 = cnt_p4 + 1;
                                   
                                   for (j = 0; j < 16; j = j + 1) begin
                                      if(mkp4_reg[j] == 1'b1) begin
                                         tempA_reg4[j] = cnt_p4 [k4];
                                         k4 = k4 + 1;
                                      end
                                   end
                                   cntp4_reg = tempA_reg4;
                                end
                             end

                             // -------------
                             // ver 3.0 PAL
                             // -------------
                             opernp4_type = `CNTINC;    
                          end
                          7'b111110?: begin //counter readback
                             if (DmsgOn) $display("%t Model := Reading back the counter at Port Four", $realtime);
                             cntp4_rd_en_p1 = 1'b1;
                             cntp4_rdbk_p1 = cntp4_reg;
                             if(cntp4_rdbk_p2 == cntp4_rdbk_p1) cntp4_rd_con_p1 = 1'b1;//ver 3.0 PAL
                             rdp4_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp4_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd
                             rdp4_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp4_type = `CNTRD;
                          end
                          7'b1111110: begin //mask register readback
                             if (DmsgOn) $display("%t Model := Mask Readback operation at Port Four", $realtime);
                             mkp4_rd_en_p1 = 1'b1;
                             mkp4_rdbk_p1 = mkp4_reg;
                             if(mkp4_rdbk_p2 == mkp4_rdbk_p1) mkp4_rd_con_p1 = 1'b1;//ver 3.0 PAL
                             rdp4_en_p1 = 4'b0000;   // for mk read operation dq goes High-Z in the next clk cycle
                             rdp4_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                             rdp4_tAC_p1 = 1'b1;//ver 2.0 Palani
                             opernp4_type = `MASKRD;
                          end
                          7'b1111111: begin //counter hold
                             cnthldp4_en_p1 = 1'b1;
                             opernp4_type = `CNTHLD;
                          end
                          default: begin
                             cnthldp4_en_p1 = 1'b1;
                             opernp4_type = `NONE;
                             no_use = chk_x_cntrst("CNTRST_NP4",cntrst_np4);
                             no_use = chk_x_mkld("MKLD_NP4",mkld_np4);
                             no_use = chk_x_cntld("CNTLD_NP4",cntld_np4);
                             no_use = chk_x_retx("RETX_NP4",retx_np4);
                             no_use = chk_x_cntinc("CNTINC_NP4",cntinc_np4);
                             no_use = chk_x_cntrd("CNTRD_NP4",cntrd_np4);
                             no_use = chk_x_mkrd("MKRD_NP4",mkrd_np4);
                          end
                        endcase // casez({cntrst_np4,mkld_np4,cntld_np4,retx_np4,cntinc_np4,cntrd_np4,mkrd_np4})
                        //------------            
                        //ver 3.2 PAL
                        //------------            
                        //chk for cnt interrupt
                        if(mkp4_reg !== `AD_S'h0000)begin
                           temp_reg4 = `AD_S'h0;
                           cnt_p4 = `AD_S'h0;
                           no_of_mask_p4 = 0;
                           k4 = 0;
                           for (i = 0; i < 16; i = i + 1) begin
                              if(mkp4_reg[i] == 1'b1)begin
                                 cnt_p4[no_of_mask_p4] = mkp4_reg[i];
                                 no_of_mask_p4 = no_of_mask_p4+1;
                              end
                           end
                           cnt_p4 = cnt_p4 - 1;
                           
                           for (j = 0; j < 16; j = j + 1) begin
                              if(mkp4_reg[j] == 1'b1) begin
                                 temp_reg4[j] = cnt_p4 [k4];
                                 k4 = k4 + 1;
                              end
                           end
                           
                           temp_f4 = 1'b1;
                           temp_msk_p4 = temp_reg4;
                           unknown_cntint_p4 = (^cntp4_reg) ^ (^mkp4_reg); //ver 3.21 PAL
                           
                           if((unknown_cntint_p4 == 1'b1) || (unknown_cntint_p4 == 1'b0)) begin //ver 3.21 PAL     
                              
                              for(i = 0; i < 16; i = i + 1)begin
                                 if(mkp4_reg[i] == 1'b1)begin
                                    if(temp_msk_p4[i] != cntp4_reg[i]) temp_f4 = 1'b0;
                                 end
                              end
                              if (temp_f4 == 1'b1) begin
                                 cntintp4_en_p1 = 1'b1;
                              end
                           end else begin           //ver 3.21 PAL
                              cntintp4_en_p1 = 1'bx;//ver 3.21 PAL
                           end                      //ver 3.21 PAL 
                        end
                        //------------            
                        //ver 3.2 PAL
                        //------------            

                        if (!((opernp4_type == `MASKRD) || (opernp4_type == `CNTRD) || (opernp4_type == `MASKLD))) begin
                           // Drive Data outputs from this block only when mrst_n is high
                           if ((ce0_np4 === 0) && (ce1p4 === 1) && (r_w_np4 === 1) && (ready_set_p4 == 1'b1)) begin  // Read operation
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 case (b_np4)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1111;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1110;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0010: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1101;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0011: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1100;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1011;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0101: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1010;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0110: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1001;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b1000;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1000: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0111;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1001: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0110;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0101;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1011: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0100;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1100: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0011;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0010;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1110: begin
                                      if (DmsgOn) $display("%t Model := Port4 Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0001;
                                      rdp4_tDC_p1 = 1'b1;
                                      if (cntp4_reg == `LAST_ADR - 3)  mailintp4_en_p1 = 1'b0;// Mailbox interrupt Ack for Port4
                                   end
                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port4 No Byte Read Operation", $realtime);
                                      rdp4_en_p1 = 4'b0000;
                                      rdp4_tDC_p1 = 1'b0;
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP4",b_np4);                       
                                      rdp4_en_p1 = 4'b0000; // disable outputs
                                      rdp4_tDC_p1 = 1'b0;
                                   end
                                 endcase // case(b_np4)
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if ((ce0_np4 === 0) && (ce1p4 === 1) && (r_w_np4 === 0)) begin // if ((ce0_np4 === 0) && (ce1p4 === 1) && (r_w_np4 === 1)) //write operation//ver 3.21 PAL
                              if ((reset_chk_fn(no_use)) == 1) begin
                                 rdp4_en_p1  = 4'b0000;
                                 rdp4_en_p2  = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp4_en_p3  = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp4_en_p4  = 4'b0000; // for write operation dq goes High-Z at the same clk cycle
                                 rdp4_tDC_p1 = 1'b0;
                                 rdp4_tDC_p2 = 1'b0;
                                 rdp4_tDC_p3 = 1'b0;
                                 rdp4_tDC_p4 = 1'b0;
                                 rdp4_tDC_p5 = 1'b0;

                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                                 case(b_np4)
                                   4'b0000: begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0000;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b0001:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0001;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b0010:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0010;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b0011:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0011;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end
                                   

                                   4'b0100:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0100;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b0101:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0101;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR)  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b0110:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0110;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b0111:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b0111;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1000:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1000;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 4
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1001:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1001;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1010:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1010;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1011:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1011;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1100:begin
                                      if (DmsgOn) $display("%t Model := Port4 Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1100;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1101:begin
                                      if (DmsgOn) $display("%t Model := Port4 Upper Byte Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1101;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1110:begin
                                      if (DmsgOn) $display("%t Model := Port4 Upper Byte Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b1; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1110;//ver 3.0 PAL
                                      dqp4_w1 = dqp4;      //ver 3.0 PAL
                                      if (cntp4_reg == `LAST_ADR )  begin
                                         mailintp1_en_p1 = 1'b1; // Mailbox intr Gen for port 1
                                         mailbox1_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 1)  begin
                                         mailintp2_en_p1 = 1'b1; // Mailbox intr Gen for port 2
                                         mailbox2_by = `MAILBOX_4;
                                      end
                                      else if (cntp4_reg == `LAST_ADR - 2)  begin
                                         mailintp3_en_p1 = 1'b1; // Mailbox intr Gen for port 3
                                         mailbox3_by = `MAILBOX_4;
                                      end
                                   end

                                   4'b1111: begin
                                      if (DmsgOn) $display("%t Model := Port4 No Write Operation", $realtime);
                                      wrp4_flag_p1 = 1'b0; //ver 3.0 PAL
                                      wrp4_en_p1 = 4'b1111;//ver 3.0 PAL
                                   end
                                   default : begin
                                      no_use = chk_x_b("B_NP4", b_np4);
                                   end
                                 endcase // case(b_np4)
                                 //-----------------------------------------------------------------------------
                                 // ver 3.0 PAL
                                 //-----------------------------------------------------------------------------
                              end // if ((reset_chk_fn(no_use)) == 1)
                           end else if((ce0_np4 === 0) && (ce1p4 === 1) && (r_w_np4 === 1) && (ready_set_p4 == 1'b0)) begin//ver 3.21 PAL
                              if (DmsgOn) $display("%t \t Model ERROR := READ operation is not allowed when the READY_NP4 is deasserted", $realtime);
                           end else if ((ce0_np4 === 0) && (ce1p4 === 1)) begin // if ((ce0_np4 === 0) && (ce1p4 === 1) && (r_w_np4 === 0))
                              no_use = chk_x_r_w("R/W_NP4",r_w_np4);                  
                           end else if (!((ce0_np4 === 0) && (ce1p4 === 1))) begin // if ((ce0_np4 === 0) && (ce1p4 === 1) && (r_w_np4 === 0))
                              if (DmsgOn) $display("%t Model := Port4 Deselected", $realtime);
                              wrp4_flag_p1 = 1'b0; //ver 3.0 PAL
                              wrp4_en_p1 = 4'b1111;//ver 3.0 PAL
                              rdp4_en_p1 = 4'b0000;
                              rdp4_tDC_p1 = 1'b0;
                           end
                        end // if (!((opernp4_type == `MASKRD) || (opernp4_type == `CNTRD)))
                        //-----------------------------------------
                        // Driving the outputs
                        if (reset_over == 1) begin
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           if(rdp4_tDC_p2 == 1'b1)begin
                              last_addr_p4 = cntp4_reg_p1;
                              last_opernp4_p1 = `READ;                        
                              #0;
                              rdp4_violation_p1 = read_tCCS_chk_fn(`port4);
                              last_port = `port4;              //ver 3.12 PAL
                           end
                           if(rdp4_tDC_p3 == 1'b1)begin
                              dqp4_p3 = read_data_fn(`port4);
                              if((cntp4_reg_p3 == cntp4_reg_p2) && (dqp4_p4 == dqp4_p3))begin
                                 rdp4_con_p1 = 1'b1;
                              end else begin
                                 rdp4_con_p1 = 1'b0;
                              end
                           end
                           // Pipelined Write Operation
                           if(wrp4_flag_p2 == 1'b1)begin
                              case(wrp4_en_p2)
                                4'b0000: begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   #0;
                                   mem [cntp4_reg_p1] = write_data_and_tCCS_chk_fn(`port4);
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0001:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];                    // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M:(`DT_S)/4] , tempD_reg1_p4[((`DT_S)/4 - 1):0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0010:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M:(`DT_S)/2] , tempD_reg1_p4[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p4[((`DT_S)/4 - 1):0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0011:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M:(`DT_S)/2] , tempD_reg1_p4[((`DT_S/2) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0100:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M:(3*(`DT_S/4))] , tempD_reg1_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p4[((`DT_S/2) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0101:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M : (3*(`DT_S/4))], tempD_reg1_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg2_p4[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p4[((`DT_S/4) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0110:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M : (3*(`DT_S/4))], tempD_reg1_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)],tempD_reg2_p4[((`DT_S/4) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b0111:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg2_p4[`DT_M : (3*(`DT_S/4))] , tempD_reg1_p4[(3*(`DT_S/4) - 1) :0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1000:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (3*(`DT_S/4))],tempD_reg2_p4[(3*(`DT_S/4) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1001:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (3*(`DT_S/4))],tempD_reg2_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)]  , tempD_reg1_p4[((`DT_S/4) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1010:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (3*(`DT_S/4))],tempD_reg2_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p4[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg2_p4[((`DT_S/4) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1011:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (3*(`DT_S/4))],tempD_reg2_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)],tempD_reg1_p4[((`DT_S/2) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1100:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (`DT_S/2)], tempD_reg2_p4[((`DT_S/2) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1101:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (`DT_S/2)],tempD_reg2_p4[((`DT_S/2) - 1) : (`DT_S/4)],tempD_reg1_p4[((`DT_S/4) - 1) : 0] };
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                4'b1110:begin
                                   last_addr_p4 = cntp4_reg_p1;
                                   last_opernp4_p1 = `WRITE;            
                                   tempD_reg1_p4 = mem[cntp4_reg_p1];             // get the previous data
                                   #0;
                                   tempD_reg2_p4 = write_data_and_tCCS_chk_fn(`port4);// save the current data temporarily
                                   mem[cntp4_reg_p1] = {tempD_reg1_p4[`DT_M : (`DT_S/4)],tempD_reg2_p4 [((`DT_S/4) - 1) : 0]};
                                   last_port = `port4;//ver 3.12 PAL
                                end
                                default: begin
                                   last_addr_p4 = 16'hX;
                                   last_opernp4_p1 = `WRITE;            
                                   last_port = `port4;//ver 3.12 PAL
                                end
                              endcase // case(wrp4_en_p2)
                           end // if (wrp4_flag_p2 == 1'b1)
                           //-----------------------------------------------------------------------------
                           // ver 3.0 PAL
                           //-----------------------------------------------------------------------------
                           // Drive Address outputs from clk edge
                           if (mkp4_rd_en_p4 == 1'b1) begin
			                  if (mkp4_rd_con_p4 !== 1'b1) begin //ver 3.0 PAL
                                 ap4_r <= # tCKLZA `AD_S'hX; 
                              end
                              ap4_r <= # tCM mkp4_rdbk_p4;
                           end else if (cntp4_rd_en_p4 == 1'b1) begin
			                  if (cntp4_rd_con_p4 !== 1'b1) begin  //ver 3.0 PAL
                                 ap4_r <= # tCKLZA `AD_S'hX; 
                              end
                              ap4_r <= # tCA cntp4_rdbk_p4;
                           end else begin //ver 2.0 palani
                              if(rdp4_tAC_p5 == 1'b1)begin
                                 ap4_r <= # tAC `AD_S'hX;
                                 ap4_r <= # tCKHZA_min `AD_S'hx;
                                 ap4_r <= # tCKHZA_max `AD_S'hZ;
                              end else begin
                                 if((mkp4_rd_en_p5 == 1'b1) || (cntp4_rd_en_p5 == 1'b1))begin                 
                                    ap4_r <= # tCKHZA_min `AD_S'hx;
                                    ap4_r <= # tCKHZA_max `AD_S'hZ;
                                 end else begin
                                    ap4_r <= `AD_S'hz;
                                 end
                              end
                           end
                           
                           // Drive Cntint interrupt pin from clk edge
                           if (cntintp4_en_p2 == 1'b1) begin
                              cntint_np4 <= #tSCINT 1'b0;
                              cntintp4_set <= 1'b1;//ver 3.2 PAL                  
                           end else if (cntintp4_en_p2 === 1'bx) begin //ver 3.21 PAL
                              cntint_np4 <= #tSCINT 1'bx;              //ver 3.21 PAL
                              cntintp4_set <= 1'b1;                    //ver 3.21 PAL  
                           end                                         //ver 3.21 PAL
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           if(((cntintp4_set == 1'b1) && !(((cntintp4_en_p1 == 1'b1) && (cntintp4_en_p2 == 1'b1))|| (cntintp4_en_p2 === 1'bx))) && ((opernp4_type_p1 == `CNTINC) || (opernp4_type_p1 == `CNTRST) || (opernp4_type_p1 == `CNTLD) || (opernp4_type_p1 == `MASKLD))) begin//ver 3.21 PAL
                              cntint_np4 <= #tRCINT 1'b1;
                              cntintp4_set <= 1'b0;//ver 3.2 PAL                     
                           end
                           // -------------
                           // ver 3.0 PAL
                           // -------------
                           
                           // Set port one,two,three Mailbox interrupt pin from clk edge with one clk latency
                           if ((mailintp1_en_p2 == 1'b1) && (mailbox1_by == `MAILBOX_4))begin
                              int_np1 <= #tSINT 1'b0;                                       
                              mailbox1_by = `MAILBOX_NONE;                  
                           end                                                              
                           else if ((mailintp2_en_p2 == 1'b1) && (mailbox2_by == `MAILBOX_4))begin
                              int_np2 <= #tSINT 1'b0;                                        
                              mailbox2_by = `MAILBOX_NONE;                  
                           end                                               
                           else if ((mailintp3_en_p2 == 1'b1) && (mailbox3_by == `MAILBOX_4))begin
                              int_np3 <= #tSINT 1'b0;
                              mailbox3_by = `MAILBOX_NONE;                                    
                           end
                           //Reset port Fourmailbox interrupt pin from clk edge with one clk latency
                           if (mailintp4_en_p2 == 1'b0) begin
                              int_np4 <= #tRINT 1'b1;
                           end
                        end

                        //-----------------------------------------
                        //X-handling
                        no_use = chk_x_ce0("CE0_NP4",ce0_np4);
                        no_use = chk_x_ce1("CE1_P4",ce1p4);
                        
                     end // if ((clkp4_event) && (cpp4 === 1))
                     //---------------------------------------------------------------------------------

                     // Drive Data outputs from this block only when mrst_n is high
                     if ((oe_np4_event) && (oe_np4 === 0)) begin            // outputs from oe low event
                        oep4_pulse_chk = $realtime;
                        tOEp4_over_chk = $realtime;
                        tOHZ_overp4_f = 1'b0; 
                        tOEp4_int <= #tOE ~tOEp4_int;
                        
                        if (DmsgOn) $display("%t Model := Drive Port Four Data outputs from oe", $realtime);
                        case (rdp4_en_p4)
                          4'b0000: begin
                             dqp4_r <= #tOLZ `DT_S'hZ; // This is reqd only during initialization of model.tOLZ is min.
                          end
                          4'b0001: begin
                             dqp4_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0010: begin
                             dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b0011: begin
                             dqp4_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b0100: begin
                             dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                          end
                          4'b0101: begin
                             dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tOLZ 10'hX;
                             dqp4_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b0110: begin
                             dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tOLZ 20'hX;
                          end
                          4'b0111: begin
                             dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #tOLZ 30'hX;
                          end
                          4'b1000: begin
                             dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                          end
                          4'b1001: begin
                             dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp4_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1010: begin
                             dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tOLZ 10'hX;
                          end
                          4'b1011: begin
                             dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tOLZ 10'hX;
                             dqp4_r[((`DT_S/2) - 1) : 0] <= #tOLZ 20'hX;
                          end
                          4'b1100: begin
                             dqp4_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                          end
                          4'b1101: begin
                             dqp4_r[`DT_M : (`DT_S/2)] <= #tOLZ 20'hX;
                             dqp4_r[((`DT_S/4) - 1) : 0] <= #tOLZ 10'hX;
                          end
                          4'b1110: begin
                             dqp4_r[`DT_M : (`DT_S/4)] <= #tOLZ 30'hX;
                          end
                          4'b1111: begin
                             dqp4_r <= #tOLZ `DT_S'hX;
                          end
                        endcase // case(rdp4_en_p4)
                     end // if ((oe_np4_event) && (oe_np4 === 0))
                     else if ((oe_np4_event) && (oe_np4 === 1) && (!oep4_int_event)) begin   // outputs from oe high event
                        oep4_pulse_chk = $realtime;
                        oep4_int <= ~oep4_int;
                     end
                     else if (!((oe_np4_event) && (oe_np4 === 0)) && (oep4_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port Four Data Outputs High-Z", $realtime);
                        tOHZ_overp4_f = 1'b1; 
                        dqp4_r <= #tOHZ_min `DT_S'hx;
                        dqp4_r <= #tOHZ_max `DT_S'hZ;
                     end
                     else if (!((oe_np4_event) && (oe_np4 === 0)) && (tOEp4_int_event)) begin
                        if (DmsgOn) $display("%t Model := Drive Port Four Data outputs from oe", $realtime);
                        if (($realtime - tOEp4_over_chk) >= tOE) begin
                           case (rdp4_en_p4)
                             4'b0000: begin
                                dqp4_r <= #0 `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
                             end
                             4'b0001: begin
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #0 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0010: begin
                                dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp4_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                dqp4_r[((`DT_S/2) - 1) : 0] <= #0 dqp4_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp4_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #0 dqp4_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #0 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #0 dqp4_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #0 dqp4_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #0 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                                dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #0 dqp4_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #0 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                                dqp4_r[((`DT_S/2) - 1) : 0] <= #0 dqp4_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                dqp4_r[`DT_M :(`DT_S/2)] <= #0 dqp4_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                dqp4_r[`DT_M : (`DT_S/2)] <= #0 dqp4_p4[`DT_M : (`DT_S/2)];
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #0 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                dqp4_r[`DT_M : (`DT_S/4)] <= #0 dqp4_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                dqp4_r <= #0 dqp4_p4;
                             end
                           endcase // case(rdp4_en_p4)
                        end // if (($realtime - tOEp4_over_chk) >= tOE)
                     end // if (!((oe_np4_event) && (oe_np4 === 0)) && (tOEp4_int_event))
                     else if ((!oe_np4_event) && (oe_np4 === 0) && (clkp4_event) && (cpp4 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Four Data outputs from clk ", $realtime);
                        if (!((cnthldp4_en_p4 == 1'b1) && (last_opernp4_p3 === `READ) && (last_opernp4_p4 === `READ))) begin
                           case (rdp4_en_p4)
                             4'b0000: begin
                                if ((cntp4_rd_en_p4 == 1'b0) && (mkp4_rd_en_p4 == 1'b0) && (mkp4_ld_en_p4 == 1'b0)) begin  // In mkrd and cntrd modes outputs should go to High-Z only and not the Low-Z.//ver 2.0 palani
                                   if(rdp4_con_p2 !== 1'b1) begin
                                      if (rdp4_tDC_p5 == 1'b1) begin
                                         dqp4_r <= #tDC_DLL_p4 `DT_S'hX;
                                      end
                                   end
                                end
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r <= #tCKHZ_min_DLL_p4 `DT_S'hx;
                                end
                                dqp4_r <= #tCKHZ_max_DLL_p4 `DT_S'hZ;
                             end
                             4'b0001: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                                        
                                   dqp4_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_min_DLL_p4 30'hx;
                                end
                                dqp4_r[`DT_M : ((`DT_S)/4) ] <= #tCKHZ_max_DLL_p4 30'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/4)-1) : 0];
                             end
                             4'b0010: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                                        
                                   dqp4_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_min_DLL_p4 20'hx;
                                   dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[`DT_M : ((`DT_S)/2)] <= #tCKHZ_max_DLL_p4 20'hZ;
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b0011: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                                        
                                   dqp4_r[`DT_M : (`DT_S/2)] <= #tCKHZ_min_DLL_p4 20'hx;
                                end
                                dqp4_r[`DT_M : (`DT_S/2)] <= #tCKHZ_max_DLL_p4 20'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p4 20'hX;
                                   end else begin
                                      dqp4_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p4 20'hX;
                                   end
                                end
                                dqp4_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b0100: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p4 10'hx;
                                   dqp4_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p4 20'hx;
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p4 10'hZ;
                                dqp4_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p4 20'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p4 dqp4_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                             end
                             4'b0101: begin
                                if (rdp4_tDC_p5 == 1'b1) begin
                                   dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p4 10'hx;
                                   dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p4 10'hZ;
                                dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tDC_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKLZ_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCD_DLL_p4 dqp4_p4[(3*(`DT_S/4) - 1) : (`DT_S/2)];
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b0110: begin
                                if (rdp4_tDC_p5 == 1'b1) begin
                                   dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p4 10'hx;
                                   dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p4 10'hZ;
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tDC_DLL_p4 20'hX;
                                   end else begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p4 20'hX;
                                   end
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCD_DLL_p4 dqp4_p4[(3*(`DT_S/4) - 1) : (`DT_S/4)];
                             end
                             4'b0111: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #tDC_DLL_p4 30'hX;
                                   end else begin
                                      dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p4 30'hX;
                                   end
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #tCD_DLL_p4 dqp4_p4[(3*(`DT_S/4) - 1) : 0];
                             end
                             4'b1000: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p4 30'hx;
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p4 30'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                             end
                             4'b1001: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p4 20'hx;
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p4 20'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/4) - 1) : 0]  <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/4) - 1) : 0]  <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                                dqp4_r[((`DT_S/4) - 1) : 0]  <= #tCD_DLL_p4 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1010: begin
                                if (rdp4_tDC_p5 == 1'b1) begin
                                   dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p4 10'hx;
                                   dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p4 10'hx;
                                end                       
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p4 10'hZ;
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tDC_DLL_p4 20'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKLZ_DLL_p4 20'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                                dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/2) - 1) : (`DT_S/4)];
                             end
                             4'b1011: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[(3*(`DT_S/4) - 1) : (`DT_S/2)] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tDC_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/2) - 1) : 0] <= #tDC_DLL_p4 20'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCKLZ_DLL_p4 10'hX;
                                      dqp4_r[((`DT_S/2) - 1) : 0] <= #tCKLZ_DLL_p4 20'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (3*(`DT_S/4))] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (3*(`DT_S/4))];
                                dqp4_r[((`DT_S/2) - 1) : 0] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/2) - 1) : 0];
                             end
                             4'b1100: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_min_DLL_p4 20'hx;
                                end
                                dqp4_r[((`DT_S/2) - 1) : 0] <= #tCKHZ_max_DLL_p4 20'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p4 20'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p4 20'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (`DT_S/2)];
                             end
                             4'b1101: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[((`DT_S/2) - 1) : (`DT_S/4)] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (`DT_S/2)] <= #tDC_DLL_p4 20'hX;
                                      dqp4_r[((`DT_S/4) - 1) : 0] <= #tDC_DLL_p4 10'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (`DT_S/2)] <= #tCKLZ_DLL_p4 20'hX;
                                      dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKLZ_DLL_p4 10'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (`DT_S/2)] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (`DT_S/2)];
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCD_DLL_p4 dqp4_p4[((`DT_S/4) - 1) : 0];
                             end
                             4'b1110: begin
                                if (rdp4_tDC_p5 == 1'b1) begin                    
                                   dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_min_DLL_p4 10'hx;
                                end
                                dqp4_r[((`DT_S/4) - 1) : 0] <= #tCKHZ_max_DLL_p4 10'hZ;
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r[`DT_M : (`DT_S/4)] <= #tDC_DLL_p4 30'hX;
                                   end else begin
                                      dqp4_r[`DT_M : (`DT_S/4)] <= #tCKLZ_DLL_p4 30'hX;
                                   end
                                end
                                dqp4_r[`DT_M : (`DT_S/4)] <= #tCD_DLL_p4 dqp4_p4[`DT_M : (`DT_S/4)];
                             end
                             4'b1111: begin
                                if(rdp4_con_p2 !== 1'b1) begin                    
                                   if (rdp4_tDC_p5 == 1'b1) begin
                                      dqp4_r <= #tDC_DLL_p4 `DT_S'hX;
                                   end else begin
                                      dqp4_r <= #tCKLZ_DLL_p4 `DT_S'hX;
                                   end
                                end
                                dqp4_r <= #tCD_DLL_p4  dqp4_p4;
                             end
                           endcase // case(rdp4_en_p4)
                        end // if (!((cnthldp4_en_p4 == 1'b1) && (last_opernp4_p4 === `READ) && (last_opernp4_p5 === `READ)))
                     end // if ((!oe_n4_event) && (oe_n4 === 0) && (cpp4_event) && (cpp4 === 1))
                     //--------------------------------------------            
                     else if ((!oe_np4_event) && (oe_np4 === 1) && (tOHZ_overp4_f == 1'b0) && (clkp4_event) && (cpp4 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Four Data outputs from clk when OE is high", $realtime);
                        if (!((cnthldp4_en_p4 == 1'b1) && (last_opernp4_p3 === `READ) && (last_opernp4_p4 === `READ))) begin
                           dqp4_r <= #tCKHZ_min_DLL_p4 `DT_S'hZ;   
                        end // if (!((cnthldp4_en_p4 == 1'b1) && (last_opernp4_p4 === `READ) && (last_opernp4_p5 === `READ)))
                     end // if ((!oe_np4_event) && (oe_np4 === 1) && (tOHZ_overp4_f == 1'b0) && (cpp4_event) && (cpp4 === 1))
                     else if ((!oe_np4_event) && (oe_np4 === 1) && (tOHZ_overp4_f == 1'b1) && (clkp4_event) && (cpp4 === 1)) begin  // outputs from clk
                        if (DmsgOn) $display("%t Model := Drive Port Four Data outputs to High-Z from clk when OE is high", $realtime);
                     end else if((oe_np4_event) && (oe_np4 == 1'bx)) begin
                        no_use = chk_x_oe("OE_NP4",oe_np4);         
                     end
                  end // (if (!(doff_np4_event === 1'b1)) && doff_np4_pos_event)
               end // fork branch
            join
            //********************************************************
            // Ver 3.3 PAL
            //********************************************************
         end // if (reset_chk_fn(no_use))
      end // if ((!mrst_n_event) && (mrst_n === 1))
      pv_assign;
      event_reset;
   end // always @ ( mrst_n or cpp1 or ce0_np1 or ce1p1 or ap1  or b_np1  or r_w_np1 or oe_np1 or dqp1 or cntrst_np1 or cntinc_np1 or mkld_np1 or cntld_np1 or mkrd_np1 or cntrd_np1 or retx_np1 or cpp2 or ce0_np2 or ce1p2 or ap2  or b_np2 or r_w_np2 or oe_np2 or dqp2 or cntrst_np2 or cntinc_np2 or mkld_np2 or cntld_np2 or mkrd_np2 or cntrd_np2 or retx_np2 or cntint_np2 or cpp3 or ce0_np3 or ce1p3 or ap3  or b_np3 or r_w_np3 or oe_np3 or dqp3 or cntrst_np3 or cntinc_np3 or mkld_np3 or cntld_np3 or mkrd_np3 or cntrd_np3 or retx_np3 or cpp4 or ce0_np4 or ce1p4 or ap4  or b_np4 or r_w_np4 or oe_np4 or dqp4 or cntrst_np4 or cntinc_np4 or mkld_np4 or cntld_np4 or mkrd_np4 or cntrd_np4 or retx_np4 or oep1_int or oep2_int or oep3_int or oep4_int or tOEp1_int or tOEp2_int or tOEp3_int or tOEp4_int)

   //------------------------------------------------------------------
   // ver 3.0 PAL
   //------------------------------------------------------------------
   always @ (doff_np1)
     begin
        if (reset_over === 1'b1)begin
           if(doff_np1 === 1'b0)begin
              falling_edge_doff_np1 = $realtime;
              negp1_flag = 1'b1;
           end else if ((doff_np1 === 1'b1) && (negp1_flag === 1'b1)) begin
              rising_edge_doff_np1 = $realtime;
              posp1_flag = 1'b1;
              negp1_flag = 1'b0;
           end
           if(posp1_flag === 1'b1)begin
              posp1_flag = 1'b0;
              if(rising_edge_doff_np1 < (tRS + falling_edge_doff_np1))begin
                 doff_np1_event = 1'b1;
                 if (TmsgOn)$display ("%t \t Model WARNING := DOFF_NP1 Reset Pulse Width - tRS violation.",$realtime);
              end else if (rising_edge_doff_np1 == (tRS + falling_edge_doff_np1))begin
                 doff_np1_event = 1'b1;
              end else
                doff_np1_event = 1'b0;
           end else
             doff_np1_event = 1'b0;
        end
     end
   
   always @ (doff_np2)
     begin
        if (reset_over === 1'b1)begin
           if(doff_np2 === 1'b0)begin
              falling_edge_doff_np2 = $realtime;
              negp2_flag = 1'b1;
           end else if ((doff_np2 === 1'b1) && (negp2_flag === 1'b1)) begin
              rising_edge_doff_np2 = $realtime;
              posp2_flag = 1'b1;
              negp2_flag = 1'b0;
           end
           if(posp2_flag === 1'b1)begin
              posp2_flag = 1'b0;
              if(rising_edge_doff_np2 < (tRS + falling_edge_doff_np2))begin
                 doff_np2_event = 1'b1;
                 if (TmsgOn)$display ("%t \t Model WARNING := DOFF_NP2 Reset Pulse Width - tRS violation.",$realtime);
              end else if (rising_edge_doff_np2 == (tRS + falling_edge_doff_np2))begin
                 doff_np2_event = 1'b1;
              end else
                doff_np2_event = 1'b0;
           end else
             doff_np2_event = 1'b0;
        end
     end

   always @ (doff_np3)
     begin
        if (reset_over === 1'b1)begin
           if(doff_np3 === 1'b0)begin
              falling_edge_doff_np3 = $realtime;
              negp3_flag = 1'b1;
           end else if ((doff_np1 === 1'b1) && (negp3_flag === 1'b1)) begin
              rising_edge_doff_np3 = $realtime;
              posp3_flag = 1'b1;
              negp3_flag = 1'b0;
           end
           if(posp3_flag === 1'b1)begin
              posp3_flag = 1'b0;
              if(rising_edge_doff_np3 < (tRS + falling_edge_doff_np3))begin
                 doff_np3_event = 1'b1;
                 if (TmsgOn)$display ("%t \t Model WARNING := DOFF_NP3 Reset Pulse Width - tRS violation.",$realtime);
              end else if (rising_edge_doff_np3 == (tRS + falling_edge_doff_np3))begin
                 doff_np3_event = 1'b1;
              end else
                doff_np3_event = 1'b0;
           end else
             doff_np3_event = 1'b0;
        end
     end

   always @ (doff_np4)
     begin
        if (reset_over === 1'b1)begin
           if(doff_np4 === 1'b0)begin
              falling_edge_doff_np4 = $realtime;
              negp4_flag = 1'b1;
           end else if ((doff_np4 === 1'b1) && (negp4_flag === 1'b1)) begin
              rising_edge_doff_np4 = $realtime;
              posp4_flag = 1'b1;
              negp4_flag = 1'b0;
           end
           if(posp4_flag === 1'b1)begin
              posp4_flag = 1'b0;
              if(rising_edge_doff_np4 < (tRS + falling_edge_doff_np4))begin
                 doff_np4_event = 1'b1;
                 if (TmsgOn)$display ("%t \t Model WARNING := DOFF_NP4 Reset Pulse Width - tRS violation.",$realtime);
              end else if (rising_edge_doff_np4 == (tRS + falling_edge_doff_np4))begin
                 doff_np4_event = 1'b1;
              end else
                doff_np4_event = 1'b0;
           end else
             doff_np4_event = 1'b0;
        end
     end
   //------------------------------------------------------------------
   // ver 3.0 PAL
   //------------------------------------------------------------------
endmodule // cy7c0451v
/******************************************************************************************************/
