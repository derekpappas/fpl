
//Copyright 2005, Cypress Semiconductor Corporation
/*****************************************************************************/
//This software is owned by Cypress Semiconductor Corporation (Cypress) and is
//protected by United States copyright laws and international treaty provisions.
//Cypress hereby grants to Licensee a personal, non-exclusive, non-transferable
//license to copy, use, modify, create derivative works of, and compile the
//Cypress Source Code and derivative works for the sole purpose of creating
//custom software in support of Licensee product ("Licensee Product") to be
//used only in conjunction with a Cypress integrated circuit. Any reproduction,
//modification, translation, compilation, or representation of this software
//except as specified above is prohibited without the express written permission
//of Cypress.


//Disclaimer: Cypress makes no warranty of any kind, express or implied, with
//regard to this material, including, but not limited to, the implied warranties
//of merchantability and fitness for a particular purpose. Cypress reserves the
//right to make changes without further notice to the materials described
//herein. Cypress does not assume any liability arising out of the application
//or use of any product or circuit described herein. Cypress products described
// herein are not authorized for use as components in life-support devices.
//This software is protected by and subject to worldwide patent coverage,
//including U.S. and foreign patents. Use may be limited by and subject to
//the Cypress Software License Agreement.
/*****************************************************************************/

//Source File Information Header Template
// *******************************************************************
// File           : fullflex72s18_top.v
// Author         :
// Author s Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
//      This is the top level behavioral model and it consist all the 
//      sub-block are instantiated.
//
// *******************************************************************


`timescale 1ns/1ps

`include "fullflex72s18_definations.v"
`include "fullflex72s18_ioctl.v"
`include "fullflex72s18_memory.v"
`include "fullflex72s18_mbox.v"
`include "fullflex72s18_addracc.v"
`include "fullflex72s18_rstlogic.v"
`include "fullflex72s18_timing.v"

module fullflex72s18_top( inmrst     ,

                  //Left port signals                  
                  // Configuration signals
		  ileft_ftsel    ,
                  ileft_ddron    ,
                  ileft_cqen     ,
                  ileft_portstd  ,

                  // I/O control logic
                  ioleft_dq      ,
                  inleft_be      ,
                  inleft_ce0     ,
                  ileft_ce1      ,
                  inleft_oe      ,
                  ileft_zq       ,
                  inleft_rw      ,
                  oleft_cq0      ,
                  oleft_cq0_n    ,
                  oleft_cq1      ,
                  oleft_cq1_n    ,

                  //Address access logic

                  ioleft_a       ,
                  ileft_cntmsk   ,
                  ileft_ads      ,
                  ileft_cnten    ,
                  ileft_cntrst   ,
                  ileft_ret      ,
                  onleft_cntint  ,
                  ileft_clk      ,
                  ileft_clk_n    ,
                  inleft_wrp     ,
                  onleft_busy    ,
                  onleft_int     ,
                  onleft_ready   ,
                  inleft_lowspd  ,
                 
                  // Right PORT 
                  // Configuration signals

                  iright_ftsel   ,			  
                  iright_ddron   ,
                  iright_cqen    ,
                  iright_portstd ,

                  // I/O control logic

                  ioright_dq     ,
                  inright_be     ,
                  inright_ce0    , 
                  iright_ce1     ,
                  inright_oe     ,
                  iright_zq      ,
                  inright_rw     ,
                  oright_cq0     ,
                  oright_cq0_n   ,
                  oright_cq1     , 
                  oright_cq1_n   ,

                  //Address access logic

                  ioright_a      ,
                  iright_cntmsk  ,
                  iright_ads     ,
                  iright_cnten   ,
                  iright_cntrst  ,
                  iright_ret     ,
                  onright_cntint ,
                  iright_clk     ,
                  iright_clk_n   ,
                  inright_wrp    ,
                  onright_busy   ,
                  onright_int    ,
                  onright_ready  ,
                  inright_lowspd
                 );

 // User settable parameters
  parameter       CYP_ADDRWIDTH  = 18;
  parameter       CYP_DATAWIDTH  = 72;
  parameter       CYP_BYTEWIDTH  = 8;
  parameter       CYP_LASTADDR   = 262143;
  parameter       CYP_ISDDR      = 0;
  parameter       CYP_ISSDR      = 0;
  parameter       CYP_ISFREQ250  = 1;
  parameter       CYP_ISFREQ200  = 0;
  parameter       CYP_ISFREQ167  = 0;
  parameter       CYP_ISFREQ133  = 0;
  parameter       CYP_ISFREQ100  = 0;
  parameter       CYP_ISFREQ83   = 0;
  parameter       CYP_ISMINDEL   = 1;
  parameter       CYP_ISMAXDEL   = 0; 


 // Internal parameters 
  parameter       CYP_DDR_MULT =(CYP_ISDDR ? 2 : 1);

  input                     inmrst;

  // Configuration signals
  input                     ileft_ftsel;
  input                     ileft_ddron;
  input                     ileft_cqen;
  input [1:0]               ileft_portstd;

  // I/O control logic
  inout [CYP_DATAWIDTH-1:0] ioleft_dq;
  input [CYP_BYTEWIDTH-1:0] inleft_be;
  input                     inleft_ce0;
  input                     ileft_ce1;
  input                     inleft_oe;
  input[1:0]                ileft_zq;
  input                     inleft_rw;
  output                    oleft_cq0;
  output                    oleft_cq0_n;
  output                    oleft_cq1;
  output                    oleft_cq1_n;
      
  //Address access logic
  inout [CYP_ADDRWIDTH-1:0] ioleft_a;
  input                     ileft_cntmsk;
  input                     ileft_ads;
  input                     ileft_cnten;
  input                     ileft_cntrst;
  input                     ileft_ret;
  output                    onleft_cntint;
  input                     ileft_clk;
  input                     ileft_clk_n;
  input                     inleft_wrp;
  output                    onleft_busy;
  output                    onleft_int;
  output                    onleft_ready;
  input                     inleft_lowspd;
                 

  // RIGHT PORT SIGNALS
  // Configuration signals
  input                     iright_ftsel;
  input                     iright_ddron;
  input                     iright_cqen;
  input [1:0]               iright_portstd;

  // I/O control logic
  inout [CYP_DATAWIDTH-1:0] ioright_dq;
  input [CYP_BYTEWIDTH-1:0] inright_be;
  input                     inright_ce0;
  input                     iright_ce1;
  input                     inright_oe;
  input[1:0]                iright_zq;
  input                     inright_rw;
  output                    oright_cq0;
  output                    oright_cq0_n;
  output                    oright_cq1;
  output                    oright_cq1_n;
      
  //Address access logic
  inout [CYP_ADDRWIDTH-1:0] ioright_a;
  input                     iright_cntmsk;
  input                     iright_ads;
  input                     iright_cnten;
  input                     iright_cntrst;
  input                     iright_ret;
  output                    onright_cntint;
  input                     iright_clk;
  input                     iright_clk_n;
  input                     inright_wrp;
  output                    onright_busy;
  output                    onright_int;
  output                    onright_ready;
  input                     inright_lowspd;

  wire                     rstlogic_reset;

  // left port wires
  wire                     addracc_left_rdback_ind;
  wire                     rstlogic_left_ready;
  wire                     ioctrl_left_read_en;
  wire                     ioctrl_left_write_en;
  wire                     left_read_en_present;
  wire                     left_write_en_present;
  wire [CYP_DDR_MULT*CYP_DATAWIDTH-1:0] ioctrl_left_dq_int;
  wire [CYP_DDR_MULT*CYP_BYTEWIDTH-1:0] ioctrl_left_be_int;
  wire [CYP_ADDRWIDTH-1:0] addracc_left_addr;
  wire [CYP_ADDRWIDTH-1:0] left_addr_present_pipeline;
  wire                     n_memory_left_busy_int;
  wire [CYP_ADDRWIDTH-1:0] mem_busy_addr_left;

  //right port wires
  wire                     addracc_right_rdback_ind;
  wire                     rstlogic_right_ready;
  wire                     ioctrl_right_read_en;
  wire                     ioctrl_right_write_en;
  wire                     right_read_en_present;
  wire                     right_write_en_present;
  wire [CYP_DDR_MULT*CYP_DATAWIDTH-1:0] ioctrl_right_dq_int;
  wire [CYP_DDR_MULT*CYP_BYTEWIDTH-1:0] ioctrl_right_be_int;
  wire [CYP_ADDRWIDTH-1:0] addracc_right_addr;
  wire [CYP_ADDRWIDTH-1:0] right_addr_present_pipeline;
  wire                     n_memory_right_busy_int;
  wire [CYP_ADDRWIDTH-1:0] mem_busy_addr_right;

  wire                     oright_read_old_data;
  wire                     oleft_read_old_data;
  wire                     oleft_read_new_data;
  wire                     oright_read_new_data;
  wire                     oleft_read_cor_data; 
  wire                     oright_read_cor_data;
  wire                     oleft_mem_data;
  wire                     oright_mem_data;
  wire                     omemwr_cor_data;

  wire                     trigger_mem_clk_l;
  wire                     trigger_mem_clk_r;

  wire                     oleft_cq0;
  wire                     oleft_cq0_n;
  wire                     oleft_cq1;
  wire		           oleft_cq1_n;
  
  wire                     left_cq0_int;
  wire                     left_cq0_n_int;
  wire                     left_cq1_int;
  wire		           left_cq1_n_int;
  
  wire                     oright_cq0;
  wire                     oright_cq0_n;
  wire                     oright_cq1;
  wire		           oright_cq1_n;
  
  wire                     right_cq0_int;
  wire                     right_cq0_n_int;
  wire                     right_cq1_int;
  wire		           right_cq1_n_int;
  
  wire                     onleft_busy;
  wire                     nleft_busy_1;
  wire                     onright_busy;
  wire                     nright_busy_1;
  reg                      first_reset_complete;

  reg                      inmrst_event;        // change on inmrst pin 
  reg                      iright_event_ftsel;  // change on ftsel right pin
  reg                      iright_event_ddron;  // change on ddron right pin
  reg                      iright_event_cqen;   // change on cqen right pin
  reg                      iright_event_portstd;// change on portstd right port
  reg                      ioright_event_dq;    // change on dq right port
  reg                      inright_event_be;    // change on be right port
  reg                      inright_event_ce0;   // change on ce0 right port
  reg                      iright_event_ce1;    // change on ce1 right port
  reg                      inright_event_oe;    // change on oe right port
  reg                      iright_event_zq;     // change on zq right port
  reg                      inright_event_rw;    // change on rw right port
  event                    ioright_event_a;     // this event is get triggered
                                                // when address get changed and 
         	                                // readback is disabled 
  reg                      iright_event_cntmsk; // change on cntmsk right port
  reg                      iright_event_ads;    // change on ads right port
  reg                      iright_event_cnten;  // change on cnten right port
  reg                      iright_event_cntrst; // change on cntrst right porT
  reg                      iright_event_ret;    // change on ret right port
  reg                      iright_event_clk;    // change on clk right port
  reg                      iright_event_clk_n;  // change on clk_n right port
  reg                      inright_event_wrp;   // change on wrp right port
  reg                      inright_event_lowspd;// change on lowspd
	 		                        // right port
  reg                      ileft_event_ftsel,   // change on ftsel left port
                           ileft_event_ddron,   // change on ddron left port
                           ileft_event_cqen,    // change on cqen left port
                           ileft_event_portstd, // change on portstd 
	 		                        // left port
                           ioleft_event_dq,     // change on dq left port
                           inleft_event_be,     // change on be left port
                           inleft_event_ce0,    // change on ce0 left port
                           ileft_event_ce1,     // change on ce1 left port
                           inleft_event_oe,     // change on oe left port
                           ileft_event_zq,      // change on zq left port
                           inleft_event_rw;     // change on rw  left port
  event                    ioleft_event_a;      // this event is get triggered
                                                // when address get changed and 
        	                                // readback is disabled 
  reg                      ileft_event_cntmsk,  // change on cntmsk left port
                           ileft_event_ads,     // change on ads left port
                           ileft_event_cnten,   // change on cnten left port
                           ileft_event_cntrst,  // change on cntrst left port
                           ileft_event_ret;     // change on ret left port
  reg                      ileft_event_clk;     // change on clk left port
  reg                      ileft_event_clk_n,   // change on clk_n left port
                           inleft_event_wrp,    // change on wrp left port
                           inleft_event_lowspd; // change on lowspd left port
 

  // These registers are defined to store the previous 
  // values of the associated signal 
  reg                      inmrst_pv,
                           iright_pv_ftsel,
                           iright_pv_ddron,
                           iright_pv_cqen,
                           inright_pv_ce0,
                           iright_pv_ce1,
                           inright_pv_oe,
                           inright_pv_rw,
                           iright_pv_cntmsk,
                           iright_pv_ads,
                           iright_pv_cnten,
                           iright_pv_cntrst,
                           iright_pv_ret,
                           iright_pv_clk,
                           iright_pv_clk_n,
                           inright_pv_wrp,
                           inright_pv_lowspd,
                           ileft_pv_ftsel,
                           ileft_pv_ddron,
                           ileft_pv_cqen,
                           inleft_pv_ce0,
                           ileft_pv_ce1,
                           inleft_pv_oe,
                           inleft_pv_rw,
                           ileft_pv_cntmsk,
                           ileft_pv_ads,
                           ileft_pv_cnten,
                           ileft_pv_cntrst,
                           ileft_pv_ret,
                           ileft_pv_clk,
                           ileft_pv_clk_n,
                           inleft_pv_wrp,
                           inleft_pv_lowspd;
 
   reg [1:0]               ileft_pv_portstd, iright_pv_portstd;
   reg [1:0]               ileft_pv_zq, iright_pv_zq;
 
   reg [CYP_ADDRWIDTH-1:0] ioleft_pv_a,ioright_pv_a;
   reg [CYP_BYTEWIDTH-1:0] inright_pv_be,inleft_pv_be;
   reg [CYP_DATAWIDTH-1:0] ioright_pv_dq,ioleft_pv_dq; 

   // These variables are updated on the changes of the assoicated signals 
   realtime                rising_edge_clk_l,      rising_edge_clk_r;
   realtime                falling_edge_clk_l,     falling_edge_clk_r;

   realtime                addr_last_change_l,     addr_last_change_r;
   realtime                byte_sel_last_change_l, byte_sel_last_change_r;

   realtime                rw_last_change_l,       rw_last_change_r;
   realtime                dq_last_change_l,       dq_last_change_r;
   realtime                ret_last_change_l,      ret_last_change_r;
   realtime                cntmsk_last_change_l,   cntmsk_last_change_r;
   realtime                cntrst_last_change_l,   cntrst_last_change_r;
   realtime                wrp_last_change_l,      wrp_last_change_r;
   realtime                cnten_last_change_l,    cnten_last_change_r;
   realtime                ads_sel_last_change_l,  ads_sel_last_change_r;
   realtime                rising_edge_mrst,       falling_edge_mrst;

   // Verbosity settings registers
   wire                    nmsg;
   wire                    wmsg;
   wire                    emsg;
   reg                     nmsg_int;
   reg                     wmsg_int;
   reg                     emsg_int;

  // This module contains the timing paramenters.
  fullflex72s18_timing # (
                    CYP_ISFREQ250,
                    CYP_ISFREQ200,
                    CYP_ISFREQ167,
                    CYP_ISFREQ133,
                    CYP_ISFREQ100,
                    CYP_ISFREQ83,
                    CYP_ISMINDEL,
                    CYP_ISMAXDEL) 
 
                TP(
		   .inmsg(nmsg),
		   .iwmsg(wmsg),
		   .iemsg(emsg),
                   .ileft_ddron(CYP_ISDDR || ((CYP_ISSDR == 0) && ileft_ddron)),
		   .ileft_ftsel(ileft_ftsel),
		   .inleft_lowspd(inleft_lowspd),
                   .iright_ddron(CYP_ISDDR || ((CYP_ISSDR ==0) && iright_ddron)),
                   .iright_ftsel(iright_ftsel),
		   .inright_lowspd(inright_lowspd),
                   .inreset(inmrst),
		   .ileft_clk(ileft_clk),
		   .iright_clk(iright_clk)
                  );


  // Left I/O control logic
  fullflex72s18_ioctl #(
                    CYP_ADDRWIDTH,
                    CYP_DATAWIDTH, 
                    CYP_BYTEWIDTH,
                    CYP_LASTADDR,
                    CYP_ISDDR,
                    CYP_ISSDR,
                    CYP_ISFREQ250,
                    CYP_ISFREQ200,
                    CYP_ISFREQ167,
                    CYP_ISFREQ133,
                    CYP_ISFREQ100,
                    CYP_ISFREQ83,
                    CYP_ISMINDEL,
                    CYP_ISMAXDEL)
  
           IOCTL_L(.iport(1'b1),
		   .inmsg(nmsg),
		   .iwmsg(wmsg),
		   .iemsg(emsg),
		   .iftsel(ileft_ftsel),
                   .iddron(CYP_ISDDR || ((CYP_ISSDR == 0) && ileft_ddron)),
                   .icqen(ileft_cqen),
                   .iportstd(ileft_portstd),
                   .iodq(ioleft_dq),
                   .inbe(inleft_be),
                   .ince0(inleft_ce0),
                   .ice1(ileft_ce1),
                   .inoe(inleft_oe),
                   .inrw(inleft_rw),
                   .ocq0(left_cq0_int),
                   .ocq0_n(left_cq0_n_int),
                   .ocq1(left_cq1_int),
                   .ocq1_n(left_cq1_n_int),
                   .iclk(ileft_clk),
                   .iclk_n(ileft_clk_n),
                   .inreset(rstlogic_reset),
                   .ireadback_ind(addracc_left_rdback),
                   .inready(rstlogic_left_ready),
                   .oread_en(ioctrl_left_read_en),
                   .owrite_en(ioctrl_left_write_en),
		   .oread_en_present(left_read_en_present),
		   .owrite_en_present(left_write_en_present),
                   .iodq_int(ioctrl_left_dq_int),
                   .onbe_int(ioctrl_left_be_int),
                   .trigger_mem_clk(trigger_mem_clk_l)
                   );
                       
  // LEFT PORT ADDRESS ACCESS LOGIC
  fullflex72s18_addracc #(
	            CYP_ADDRWIDTH)

        ADRACC_L(  .iport(1'b1),
		   .inmsg(nmsg),
		   .iwmsg(wmsg),
		   .iemsg(emsg),
		   .inreset(rstlogic_reset),
                   .iclk(ileft_clk),
                   .iclk_n(ileft_clk_n),
                   .incntmsk(ileft_cntmsk),
                   .inads(ileft_ads),
                   .incnten(ileft_cnten),
                   .inret(ileft_ret),
                   .incntrst(ileft_cntrst),
                   .iddron(CYP_ISDDR ||((CYP_ISSDR == 0) && ileft_ddron)),
                   .iftsel(ileft_ftsel),
                   .inwrp(inleft_wrp),
                   .ibusy_addr(mem_busy_addr_left),
                   .inbusy(n_memory_left_busy_int),
                   .addr_o(addracc_left_addr),
	           .addr_present_pipeline(left_addr_present_pipeline),
                   .oreadback_ind(addracc_left_rdback),
                   .oncntint(onleft_cntint),
                   .ioaddr(ioleft_a)
                  );


  // RIGHT PORT I/O CONTROL LOGIC
  fullflex72s18_ioctl #(
                    CYP_ADDRWIDTH,
                    CYP_DATAWIDTH, 
                    CYP_BYTEWIDTH,
                    CYP_LASTADDR,
                    CYP_ISDDR,
                    CYP_ISSDR,
                    CYP_ISFREQ250,
                    CYP_ISFREQ200,
                    CYP_ISFREQ167,
                    CYP_ISFREQ133,
                    CYP_ISFREQ100,
                    CYP_ISFREQ83,
                    CYP_ISMINDEL,
                    CYP_ISMAXDEL)
 
       IOCTL_R(    .iport(1'b0),
	           .inmsg(nmsg),
		   .iwmsg(wmsg),
		   .iemsg(emsg),
		   .iftsel(iright_ftsel),
                   .iddron(CYP_ISDDR || ((CYP_ISSDR == 0) && iright_ddron)),
                   .icqen(iright_cqen),
                   .iportstd(iright_portstd),
                   .iodq(ioright_dq),
                   .inbe(inright_be),
                   .ince0(inright_ce0),
                   .ice1(iright_ce1),
                   .inoe(inright_oe),
                   .inrw(inright_rw),
                   .ocq0(right_cq0_int),
                   .ocq0_n(right_cq0_n_int),
                   .ocq1(right_cq1_int),
                   .ocq1_n(right_cq1_n_int),
                   .iclk(iright_clk),
                   .iclk_n(iright_clk_n),
                   .inreset(rstlogic_reset),
                   .ireadback_ind(addracc_right_rdback),
                   .inready(rstlogic_right_ready),
                   .oread_en(ioctrl_right_read_en),
                   .owrite_en(ioctrl_right_write_en),
		   .oread_en_present(right_read_en_present),
	           .owrite_en_present(right_write_en_present),
                   .iodq_int(ioctrl_right_dq_int),
                   .onbe_int(ioctrl_right_be_int),
                   .trigger_mem_clk(trigger_mem_clk_r)
                  );


  // RIGHT PORT ADDRESS ACCESS LOGIC
  fullflex72s18_addracc #(CYP_ADDRWIDTH)

        ADRACC_R(  .iport(1'b0),
		   .inmsg(nmsg),
		   .iwmsg(wmsg),
		   .iemsg(emsg),
		   .inreset(rstlogic_reset),
                   .iclk(iright_clk),
                   .iclk_n(iright_clk_n),
                   .incntmsk(iright_cntmsk),
                   .inads(iright_ads),
                   .incnten(iright_cnten),
                   .inret(iright_ret),
                   .incntrst(iright_cntrst),
                   .iddron(CYP_ISDDR || ((CYP_ISSDR == 0) && iright_ddron)),
                   .iftsel(iright_ftsel),
                   .inwrp(inright_wrp),
                   .ibusy_addr(mem_busy_addr_right),
                   .inbusy(n_memory_right_busy_int),
                   .addr_o(addracc_right_addr),
		   .addr_present_pipeline(right_addr_present_pipeline),
                   .oreadback_ind(addracc_right_rdback),
                   .oncntint(onright_cntint),
                   .ioaddr(ioright_a)
                  );


  // Dual Memory Block, Zero cycle latency for read and write
  fullflex72s18_memory #(
                    CYP_ADDRWIDTH,
                    CYP_DATAWIDTH,
                    CYP_BYTEWIDTH,
                    CYP_LASTADDR,
                    CYP_ISDDR,
                    CYP_ISSDR)
    
           MEMORY( .inmsg(nmsg),
		   .iwmsg(wmsg),
		   .iemsg(emsg),
		   .inreset(rstlogic_reset),
                   .ileft_clk(ileft_clk),
                   .ileft_ddron(ileft_ddron),
		   .ileft_ftsel(ileft_ftsel || ileft_ddron),
                   .ileft_ad(addracc_left_addr),
		   .ileft_addr_present_pipeline(left_addr_present_pipeline),
                   .ioleft_data(ioctrl_left_dq_int),
                   .inleft_be(ioctrl_left_be_int),
                   .ileft_read_en(ioctrl_left_read_en),
                   .ileft_write_en(ioctrl_left_write_en),
		   .ileft_read_en_present(left_read_en_present),
                   .ileft_write_en_present(left_write_en_present),
                   .onleft_busy(nleft_busy_1),
                   .onleft_busy_int(n_memory_left_busy_int),
                   .obusy_addr_left(mem_busy_addr_left),
                   .oleft_trigger_mem_clk(trigger_mem_clk_l),
                   .iright_clk(iright_clk),
                   .iright_ddron(iright_ddron),
		   .iright_ftsel(iright_ftsel || iright_ddron),
                   .iright_ad(addracc_right_addr),
		   .iright_addr_present_pipeline(right_addr_present_pipeline),
                   .ioright_data(ioctrl_right_dq_int),
                   .inright_be(ioctrl_right_be_int),
                   .iright_read_en(ioctrl_right_read_en),
                   .iright_write_en(ioctrl_right_write_en),
		   .iright_read_en_present(right_read_en_present),
                   .iright_write_en_present(right_write_en_present),
                   .onright_busy(nright_busy_1),
                   .onright_busy_int(n_memory_right_busy_int),
                   .obusy_addr_right(mem_busy_addr_right),
                   .oright_trigger_mem_clk(trigger_mem_clk_r)
                   );


  // Mail box 
  fullflex72s18_mbox # (
                    CYP_ADDRWIDTH,
                    CYP_LASTADDR)   

      MAILBOX(     .inreset(rstlogic_reset),
                   .ileft_clk(ileft_clk),
                   .iright_clk(iright_clk),
                   .ileft_addr(left_addr_present_pipeline),
                   .ileft_read_en(left_read_en_present),
                   .ileft_write_en(left_write_en_present),
                   .inleft_busy(n_memory_left_busy_int),
                   .iright_addr(right_addr_present_pipeline),
                   .iright_read_en(right_read_en_present),
                   .iright_write_en(right_write_en_present),
                   .inright_busy(n_memory_right_busy_int),
                   .onleftintr(onleft_int),
                   .onrightintr(onright_int)
                  );

  // Reset LOGIC
  fullflex72s18_rstlogic  RESET_LOG(
	           .iwmsg(wmsg),
	           .inmrst(inmrst),
                   .ileft_clk(ileft_clk),
                   .iright_clk(iright_clk),
                   .ileft_zq(ileft_zq),
                   .iright_zq(iright_zq),
                   .ileft_cqen(ileft_cqen),
                   .iright_cqen(iright_cqen),
                   .inleft_lowspd(inleft_lowspd),
                   .inright_lowspd(inright_lowspd),
                   .onreset(rstlogic_reset),
                   .onleft_ready(rstlogic_left_ready),
                   .onright_ready(rstlogic_right_ready)
                  );

  // Assiging the ready signals to output pin of the chip
  assign onleft_ready  = rstlogic_left_ready;
  assign onright_ready = rstlogic_right_ready;

  // BUSY# output assignment
  assign onleft_busy   = ((inmrst === 1'b0) || (first_reset_complete == 1'b0)) ?
	                 1'bZ : nleft_busy_1;
  assign onright_busy  = ((inmrst === 1'b0) || (first_reset_complete == 1'b0)) ?
	                 1'bZ : nright_busy_1;
  // Echo clock assignment
  assign oleft_cq0     = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : left_cq0_int;
  assign oleft_cq0_n   = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : left_cq0_n_int;
  assign oleft_cq1     = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : left_cq1_int;
  assign oleft_cq1_n   = ((inmrst === 1'b0) || (first_reset_complete == 1'b0)) ?
	                 1'bZ : left_cq1_n_int;
 
  assign oright_cq0    = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : right_cq0_int;
  assign oright_cq0_n  = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : right_cq0_n_int;
  assign oright_cq1    = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : right_cq1_int;
  assign oright_cq1_n  = ((first_reset_complete == 1'b0)) ?
	                 1'bZ : right_cq1_n_int;

  // Verbosity settings assignment
  assign nmsg          = ((inmrst === 1'b0) || (first_reset_complete == 1'b0)) ?
	                 1'b0 : nmsg_int;
  assign wmsg          = ((inmrst === 1'b0) || (first_reset_complete == 1'b0)) ?
	                 1'b0 : wmsg_int;
  assign emsg          = ((inmrst === 1'b0) || (first_reset_complete == 1'b0)) ?
	                 1'b0 : emsg_int; 
 		 
  // Internal variable initialization
  initial
  begin
    first_reset_complete <= 1'b0;

    `ifdef nmsg       // All messages ON
       nmsg_int <= 1'b1;
       wmsg_int <= 1'b1;
       emsg_int <= 1'b1;
    `else
    `ifdef emsg       // Error messages ON
       nmsg_int <= 1'b0;
       wmsg_int <= 1'b0;
       emsg_int <= 1'b1;
    `else
    `ifdef wmsg       // Warning and Error messages ON
       nmsg_int <= 1'b0;
       wmsg_int <= 1'b1;
       emsg_int <= 1'b1;
    `else
    `ifdef msgoff     // All messages OFF
       nmsg_int <= 1'b0;
       wmsg_int <= 1'b0;
       emsg_int <= 1'b0;
    `else             // Default Error messages ON
       nmsg_int <= 1'b0;
       wmsg_int <= 1'b0;
       emsg_int <= 1'b1;
    `endif
    `endif
    `endif
    `endif
  end


  // Reset operation
  always @(inmrst)
  begin
    first_reset_complete <= 1'b1;
  end
  
  // The following process will check the timing of the all the inputs pins
  // This process will find the even on the input and checks for the timing
  always@(inmrst or

     //Left port configuration signals
     ileft_ftsel or
     ileft_ddron or
     ileft_cqen or
     ileft_portstd or

     // I/O control logic
     ioleft_dq or
     inleft_be or
     inleft_ce0 or
     ileft_ce1 or
     inleft_oe or
     ileft_zq or
     inleft_rw or

     //Address access logic
     ioleft_a or
     ileft_cntmsk or
     ileft_ads or
     ileft_cnten or
     ileft_cntrst or
     ileft_ret or
     inleft_wrp or
     inleft_lowspd or

     // Right PORT Configuration signals
     iright_ftsel or
     iright_ddron or
     iright_cqen or
     iright_portstd or

     // I/O control logic
     ioright_dq or
     inright_be or
     inright_ce0 or
     iright_ce1 or
     inright_oe or
     iright_zq or
     inright_rw or

     //Address access logic
     ioright_a or
     iright_cntmsk or
     iright_ads or
     iright_cnten or
     iright_cntrst or
     iright_ret or
     inright_wrp or
     inright_lowspd
    )
  begin 
    if(inmrst==1'b0)
    begin 
       //event_reset;
       //pv_reset;
       pv_assign;
    end
    else 
    begin
       event_chk;
       timing_chk;
       pv_assign;
    end
  end

  // This block update the left port rising time variable  
  // at the posedge of left clock 
  always @(posedge ileft_clk)
    rising_edge_clk_l=$realtime;

  // This block update the right port rising time variable 
  // at the posedge of right clock 
  always@(posedge iright_clk)
    rising_edge_clk_r=$realtime;

  // This block update the left port falling time variable 
  // at the negedge of left clock 
  always@(negedge ileft_clk)
    falling_edge_clk_l=$realtime;

  // This block update the right port falling time variable
  // at the negedge of right clock 
  always@(negedge iright_clk)
    falling_edge_clk_r=$realtime;


  // This block get triggered when there is a change in input address bus of 
  // the left port .  This block check the timing and update the last 
  // addr change time to the variable addr_last_change_r

  always@(ioleft_event_a)
  begin
    if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
    begin
       if(wmsg == 1'b1)
	 $display ("%t  WARNING:CLK_L to A_L Hold time - tHAC violation.", $realtime);
       no_grnt_msg;
    end
    addr_last_change_l =$realtime;
  end


  // This block get triggered when there is a change in input addres bus of 
  // the right port .  This block check the timing and update the last addr 
  // change time to the variable addr_last_change_r
  always@(ioright_event_a)
  begin
     if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING: CLK_R to A_R Hold time - tHAC violation.", $realtime);
        no_grnt_msg;
     end
     addr_last_change_r = $realtime;
  end
 	
  `include "fullflex72s18_tasks.v"
endmodule






