//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2000 SPIKE TECHNOLOGIES INC.
//                           ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0852v_test.v
//
// Author       : Archana
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : Main testbench file
//
// Notes        : First Release
//
// Modification History:
// Date              By       Version     Change Description
// ==========================================================================
// 03/09/2001      Archana      1.0         First Release
//
//
//
//
// ==========================================================================


// variables for selection of the check
//`define ZERODELAY                  0
`define MRST_TEST                 1   //Test for master reset *
`define RD_OE_nl_TEST             2   // Read by left port with output enable*
`define RD_OE_nr_TEST             3   // Read by right port with output enable*
`define WR_RD_WR_l_oe             4   //write to read to write from left port oe controlled
`define WR_RD_WR_r_oe             5   //write to read to write from right port oe controlled
`define WR_l_TEST                 6   // Write by Left Port*
`define WR_r_TEST                 7   // Write by right port*
                                       
`define RD_l_be_0001              8   //Read from left port with byte enable condition 0001
`define RD_l_be_0010              9   //Read from left port with byte enable condition 0010
`define RD_l_be_0011              10  //Read from left port with byte enable condition 0011
`define RD_l_be_0100              11  //Read from left port with byte enable condition 0100
`define RD_l_be_0101              12  //Read from left port with byte enable condition 0101
`define RD_l_be_0110              13  //Read from left port with byte enable condition 0110
`define RD_l_be_0111              14  //Read from left port with byte enable condition 0111
`define RD_l_be_1000              15  //Read from left port with byte enable condition 1000
`define RD_l_be_1001              16  //Read from left port with byte enable condition 1001
`define RD_l_be_1010              17  //Read from left port with byte enable condition 1010
`define RD_l_be_1011              18  //Read from left port with byte enable condition 1011
`define RD_l_be_1100              19  //Read from left port with byte enable condition 1100
`define RD_l_be_1101              20  //Read from left port with byte enable condition 1101
`define RD_l_be_1110              21  //Read from left port with byte enable condition 1110
`define RD_l_be_1111              22  //Read from left port with byte enable condition 1111

`define RD_r_be_0001              23  // Read from right port with byte enable condition 0001   
`define RD_r_be_0010              24  // Read from right port with byte enable condition 0010            
`define RD_r_be_0011              25  // Read from right port with byte enable condition 0011
`define RD_r_be_0100              26  // Read from right port with byte enable condition 0100
`define RD_r_be_0101              27  // Read from right port with byte enable condition 0101
`define RD_r_be_0110              28  // Read from right port with byte enable condition 0110
`define RD_r_be_0111              29  // Read from right port with byte enable condition 0111
`define RD_r_be_1000              30  // Read from right port with byte enable condition 1000
`define RD_r_be_1001              31  // Read from right port with byte enable condition 1001
`define RD_r_be_1010              32  // Read from right port with byte enable condition 1010
`define RD_r_be_1011              33  // Read from right port with byte enable condition 1011
`define RD_r_be_1100              34  // Read from right port with byte enable condition 1100
`define RD_r_be_1101              35  // Read from right port with byte enable condition 1101
`define RD_r_be_1110              36  // Read from right port with byte enable condition 1110
`define RD_r_be_1111              37  // Read from right port with byte enable condition 1111

`define WR_l_be_0001              38   //write to left port with byte enable condition 0001
`define WR_l_be_0010              39   //write to left port with byte enable condition 0010
`define WR_l_be_0011              40   //write to left port with byte enable condition 0011
`define WR_l_be_0100              41   //write to left port with byte enable condition 0100
`define WR_l_be_0101              42   //write to left port with byte enable condition 0101
`define WR_l_be_0110              43   //write to left port with byte enable condition 0110
`define WR_l_be_0111              44   //write to left port with byte enable condition 0111
`define WR_l_be_1000              45   //write to left port with byte enable condition 1000
`define WR_l_be_1001              46   //write to left port with byte enable condition 1001
`define WR_l_be_1010              47   //write to left port with byte enable condition 1010
`define WR_l_be_1011              48   //write to left port with byte enable condition 1011
`define WR_l_be_1100              49   //write to left port with byte enable condition 1100
`define WR_l_be_1101              50   //write to left port with byte enable condition 1101
`define WR_l_be_1110              51   //write to left port with byte enable condition 1110
`define WR_l_be_1111              52   //write to left port with byte enable condition 1111

`define WR_r_be_0001              53   //write to right port with byte enable condition 0001
`define WR_r_be_0010              54   //write to right port with byte enable condition 0010
`define WR_r_be_0011              55   //write to right port with byte enable condition 0011
`define WR_r_be_0100              56   //write to right port with byte enable condition 0100
`define WR_r_be_0101              57   //write to right port with byte enable condition 0101
`define WR_r_be_0110              58   //write to right port with byte enable condition 0110
`define WR_r_be_0111              59   //write to right port with byte enable condition 0111
`define WR_r_be_1000              60   //write to right port with byte enable condition 1000
`define WR_r_be_1001              61   //write to right port with byte enable condition 1001
`define WR_r_be_1010              62   //write to right port with byte enable condition 1010
`define WR_r_be_1011              63   //write to right port with byte enable condition 1011
`define WR_r_be_1100              64   //write to right port with byte enable condition 1100
`define WR_r_be_1101              65   //write to right port with byte enable condition 1101
`define WR_r_be_1110              66   //write to right port with byte enable condition 1110
`define WR_r_be_1111              67   //write to right port with byte enable condition 1111

`define RD_2_l_r_diff             68  // two reads from both ports at diff locations
`define WR_l_RD_l_1FFFF           70  //Highest memory write and read by left port*
`define WR_r_RD_r_1FFFF           71  //Highest memory write and read by right port* 
`define WR_l_RD_r_1FFFF           72  //Highest memory write by left port,read by right port.* 
`define WR_r_RD_l_1FFFF           73  //Highest memory write by right port,read by left port.* 
`define WR_BOTH_TEST              74  // Write by both the ports (Different locations)*
`define WRITE_COLLISION_TEST_L_FIRST     75 //collision test with left port first
`define WRITE_COLLISION_TEST_R_FIRST     76  // Write by both the ports (Same location)*
`define WR_COLLISION_VIOLATION_TEST  77   // collision test with violation
`define WR_l_RD_r_TEST            78   // Write by left port, read by right port (Different locations)
`define WR_l_RD_r_SAME_TEST       79  // Write by left port,read by right port (Same location) 
`define RD_l_WR_r_TEST            80  // Read by left port,write by right port (Different locations) 
`define RD_l_WR_r_SAME_TEST       81   // Read by left port,write by right port (Same locations) 
`define RD_l_r_sam                82   //Read by both the ports at same location
`define RD_l_r_diff               83   // Read by both the ports at different locations
`define RD_l_TEST_WO_nCE_11       84   // Read left test with no chip enable
`define RD_r_TEST_WO_nCE_11       85   // Read left test with no chip enable
`define RD_l_TEST_WO_nCE_00       86   // Read left test with no chip enable
`define RD_r_TEST_WO_nCE_00       87   // Read left test with no chip enable
`define WR_l_TEST_WO_nCE          88   // Write left test with no chip enable 
`define WR_r_TEST_WO_nCE          89   // Write right test with no chip enable

`define WR_l_10_RD_l_10           90   //write to 10 consecutive (non burst mode ) through left port
`define WR_r_10_RD_r_10           91   //write to 10 consecutive (non burst mode ) through right port
`define WR_RD_WR_l                92   //write to read to write from left port
`define WR_RD_WR_r                93   //write to read to write from right port
`define RD_WR_RD_l                94   //read to write to read left port
`define RD_WR_RD_r                95   //read to write to read left port
`define RD_r_WR_l_sam_violation   96   //Read from right port and write from left at samelocation with violation
`define WR_r_RD_l_sam_violation   97   //Read from left port and write from right at samelocation with violation
`define RD_l_r_sam_VIOLATION      98  // Read from both ports at same address with violation

`define MSK_RST_l                 100   //Mask Register reset left port
`define MSK_RST_r                 101    //Mask Register reset right port
`define MSK_LOAD_l                102  //Mask Load and Read Back left Port
`define MSK_LOAD_r                103   //Mask Load and Read Back right Port  
`define EVEN_COUNT_RDBK_l         104  //Even count Burst  Read Back left port
`define ODD_COUNT_RDBK_l          105  //Odd  count Burst  Read Back left port
`define EVEN_COUNT_RDBK_r         106  //Even count Burst  Read Back right port
`define ODD_COUNT_RDBK_r          107  //Odd  count Burst  Read Back right port
`define RETRANSMIT_l              108  //Left port retransmit write and read operation 
`define RETRANSMIT_r              109  //Right  port retransmit write and read operation
`define CNTR_RST_l                110  //Mask Register reset left port
`define CNTR_RST_r                111  //Mask Register reset right port
`define CNTR_LOAD_l               112  //Mask Load and Read Back left Port
`define CNTR_LOAD_r               113  //Mask Load and Read Back right Port  
                                  
`define BURST_L_PORT_TEST         114 // Burst operations on left port
`define BURST_R_PORT_TEST         115 // Burst operations on right port   
`define CNTHLD_L_PORT_TEST        116 // write and read operations with counter hold(left port)
`define CNTHLD_R_PORT_TEST        117 // write and read operations with counter hold(right port)

                                 
`define MAIL_BOX_INT_TEST_L2R          118 // Mail box test on left port
`define MAIL_BOX_INT_TEST_R2L          119 // Mail box test on right port
`define X_VIOLATIONS              120 //violation test


`define TEST_ALL                  121 // Test's all the above testcases             


//########################################################################################################
`include "cy7c0852v.v"
`include "cy7c0852v_defines_test.v"
module cy7c0852v_test;
   
   parameter      TESTCASE = `TEST_ALL;
   event          rd_l_r_sam,rd_l_r_sam_oe,rd_2_l_r_sam,rd_2_l_r_sam_oe,rd_l_r_sam_violation;
   event          collision_event,collision_event1,collision_violation_event,both_write_event;
   event          wr_l_rd_r_event,rd_l_wr_r_event_1,rd_l_wr_r_event,rd_r_wr_l_same_event, wr_r_rd_l_same_event;
   event          wr_l_rd_r_same_event,rd_l_wr_r_same_event;
   event          wr_l_rd_l_1FFF,wr_r_rd_r_1FFF,wr_l_rd_r_1FFF,wr_r_rd_l_1FFF;
   event          wr_l_event,rd_r_event,wr_r_event,rd_l_event,chk_d_r1,chk_d_r2;
   event          chk_d_l1,chk_d_l2, rd_l_r_diff;
   
   reg [3:0]      vec;
   reg [35:0]     mem_test [1024:0];          //change aug 20
   wire [`ADDR_MSB :0] al, ar; 
   reg [`ADDR_MSB :0]  al_int, ar_int;                        
   integer             i,j;
   integer             failed_tests,vector;   // Failed case count ,Vectors
   reg                 ads_nl,                // Address strobe left port (active low)   
                       ads_nr,                // Address strobe right port (active low)   
                       ce0_nl,                //Chip enable /CE0 left
                       ce0_nr,                //Chip enable /CE0 right
                       ce1l,                  //Chip enable CE1 left
                       ce1r,                  //Chip enable /CE1 right
                       clkl,                  //Clock left port
                       clkr,                 //Clock right port
                       cnten_nl,            //Counter enable /CNTEN left
                       cnten_nr,           //Counter enable /CNTEN right
                       cntrst_nl,          //Counter Reset /CNTRST left
                       cntrst_nr,          //Counter Reset /CNTRST right
                       cnt_msk_nl,
                       cnt_msk_nr;  
   wire [`DATA_MSB :0] dql,dqr;    
   reg [`DATA_MSB :0]  dql_int,dqr_int;    
   wire [`DATA_MSB :0] d_check_l,d_check_r;
   wire [`DATA_MSB :0] d_check_l_x,d_check_r_x;
   reg [`DATA_MSB :0]  d_check_l_reg,d_check_r_reg;
   reg                 oe_nl,  
                       oe_nr;  
   wire                int_nl, 
                       int_nr, 
                       cntint_nl,
                       cntint_nr;
   reg                 r_w_nl,r_w_nr;
   reg [`BYTE_MSB :0]  b_nl_reg,   
                       b_nr_reg ;   
   
   reg [`BYTE_MSB :0]  b_nl,   
                       b_nr;   
   reg                 mrst_n; 
   reg [4:0]           change_time_ad_dt,change_time_all,change_time;
   reg [1:0]           check_port;
   reg                 expected_OE_l;
   reg                 expected_RDnWR_l;
   reg [`BYTE_MSB :0]  expected_b_nl;
   reg                 expected_CE0_l;
   reg                 expected_CE1_l;
   reg [`DATA_MSB :0]  expected_data_l,expected_data_r,data_check_l,data_check_r,Data_l,Data_r;
   reg [`ADDR_MSB :0]  expected_Addr_l,expected_Addr_r,Addr_l,Addr_r,Addr_check_l,Addr_check_r,Addr_l_b,Addr_r_b;
   reg                 int_check_l, int_check_r;
   reg [`ADDR_MSB :0]  Addr_l_2,Addr_r_2,Addr_check_l1,Addr_check_r1;
   reg                 expected_CNTnMSK_l;
   reg                 expected_ADS_l;
   reg                 expected_CNTEN_l;
   reg                 expected_CNTRST_l;
   reg                 expected_CNTINT_l;
   reg                 expected_INT_l; 
   reg                 expected_OE_r;
   reg                 expected_RDnWR_r;
   reg [`BYTE_MSB :0]  expected_b_nr;
   reg                 expected_CE0_r  ;
   reg                 expected_CE1_r  ;
   reg                 expected_CNTnMSK_r;
   reg                 expected_ADS_r    ;
   reg                 expected_CNTEN_r  ;
   reg                 expected_CNTRST_r ;
   reg                 expected_CNTINT_r ;
   reg                 expected_INT_r;
   reg                 moveon;
   reg                 individual_tests;

   
   assign              al  =  (ads_nl === 1'b0) ? al_int  : `ADDR_MSB_1'bz;
   assign              ar  =  (ads_nr === 1'b0) ? ar_int  : `ADDR_MSB_1'bz;
   assign              dql =  (r_w_nl === 1'b0) ? dql_int : `DATA_MSB_1'bz ;
   assign              dqr =  (r_w_nr === 1'b0) ? dqr_int : `DATA_MSB_1'bz;
   
`include "cy7c0852v_tasks_test.v"

   cy7c0852v model(
                   .al         (al),         // Address input left
                   .ar         (ar),         // Address input right
                   .ads_nl     (ads_nl),     // Address strobe input left
                   .ads_nr     (ads_nr),     // Address strobe input right
                   .ce0_nl     (ce0_nl),     // Active low chip enable input left
                   .ce0_nr     (ce0_nr),     // Active low chip enable input right
                   .ce1l       (ce1l),       // Active high chip enable input left 
                   .ce1r       (ce1r),       // Active high chip enable input right
                   .clkl       (clkl),       // Clock input left
                   .clkr       (clkr),       // Clock input right
                   .cnten_nl   (cnten_nl),   // Counter enable input left
                   .cnten_nr   (cnten_nr),   // Counter enable input right
                   .cntrst_nl  (cntrst_nl),  // Counter reset input left
                   .cntrst_nr  (cntrst_nr),  // Counter reset input right
                   .cnt_msk_nl (cnt_msk_nl), // Address counter mask register enable input left 
                   .cnt_msk_nr (cnt_msk_nr), // Address counter mask register enable input right 
                   .dql        (dql),        // Data bus input/output left
                   .dqr        (dqr),        // Data bus input/output right
                   .oe_nl      (oe_nl),      // Output enable input left
                   .oe_nr      (oe_nr),      // Output enable input right
                   .int_nl     (int_nl),     // Mailbox interrupt flag output left
                   .int_nr     (int_nr),     // Mailbox interrupt flag output right
                   .cntint_nl  (cntint_nl),  // Counter interrupt output left 
                   .cntint_nr  (cntint_nr),  // Counter interrupt output right
                   .r_w_nl     (r_w_nl),     // Read/Write Enable input left
                   .r_w_nr     (r_w_nr),     // Read/Write Enable input right
                   .b_nl       (b_nl),       // Byte select inputs left
                   .b_nr       (b_nr),       // Byte select inputs right
                   .mrst_n     (mrst_n)      // Master reset input 
                   );

   initial
     begin
        failed_tests = 0;
        b_nr_reg     = 4'b0000;
        b_nl_reg     = 4'b0000;
        vector       = 1;
        moveon       = 1'b0;
     end
   
   assign d_check_l = (b_nl_reg == 4'b0000) ? d_check_l_reg :
                      (b_nl_reg == 4'b0001) ? {d_check_l_reg[35 : 9],9'bz}:
                      (b_nl_reg == 4'b0010) ? {d_check_l_reg[35 : 18],9'bz,d_check_l_reg[8 : 0]}:
                      (b_nl_reg == 4'b0011) ? {d_check_l_reg[35 : 18],18'bz}:
                      (b_nl_reg == 4'b0100) ? {d_check_l_reg[35 : 27],9'bz,d_check_l_reg[17 : 0]}: 
                      (b_nl_reg == 4'b0101) ? {d_check_l_reg[35 : 27],9'bz,d_check_l_reg[17 : 9],9'bz}:
                      (b_nl_reg == 4'b0110) ? {d_check_l_reg[35 : 27],18'bz,d_check_l_reg[8: 0]}:
                      (b_nl_reg == 4'b0111) ? {d_check_l_reg[35 : 27],27'bz}:
                      (b_nl_reg == 4'b1000) ? {9'bz,d_check_l_reg[26 : 0]}:  
                      (b_nl_reg == 4'b1001) ? {9'bz,d_check_l_reg[26 : 9],9'bz}:  
                      (b_nl_reg == 4'b1010) ? {9'bz,d_check_l_reg[26 : 18],9'bz,d_check_l_reg[8 : 0]}:
                      (b_nl_reg == 4'b1011) ? {9'bz,d_check_l_reg[26 : 18],18'bz}:
                      (b_nl_reg == 4'b1100) ? {18'bz,d_check_l_reg[17 : 0]}:
                      (b_nl_reg == 4'b1101) ? {18'bz,d_check_l_reg[17 : 9],9'bz}:
                      (b_nl_reg == 4'b1110) ? {27'bz,d_check_l_reg[8 : 0]}:
                      (b_nl_reg == 4'b1111) ? 36'bz:36'bz;
   
   assign d_check_r = (b_nr_reg == 4'b0000) ? d_check_r_reg :
          (b_nr_reg == 4'b0001) ? {d_check_r_reg[35 : 9],9'bz}:
                      (b_nr_reg == 4'b0010) ? {d_check_r_reg[35 : 18],9'bz,d_check_r_reg[8 : 0]}:
                      (b_nr_reg == 4'b0011) ? {d_check_r_reg[35 : 18],18'bz}:
                      (b_nr_reg == 4'b0100) ? {d_check_r_reg[35 : 27],9'bz,d_check_r_reg[17 : 0]}: 
                      (b_nr_reg == 4'b0101) ? {d_check_r_reg[35 : 27],9'bz,d_check_r_reg[17 : 9],9'bz}: 
                      (b_nr_reg == 4'b0110) ? {d_check_r_reg[35 : 27],18'bz,d_check_r_reg[8: 0]}: 
                      (b_nr_reg == 4'b0111) ? {d_check_r_reg[35 : 27],27'bz}:
                      (b_nr_reg == 4'b1000) ? {9'bz,d_check_r_reg[26 : 0]}:  
                      (b_nr_reg == 4'b1001) ? {9'bz,d_check_r_reg[26 : 9],9'bz}:  
                      (b_nr_reg == 4'b1010) ? {9'bz,d_check_r_reg[26 : 18],9'bz,d_check_r_reg[8 : 0]}:
                      (b_nr_reg == 4'b1011) ? {9'bz,d_check_r_reg[26 : 18],18'bz}:
                      (b_nr_reg == 4'b1100) ? {18'bz,d_check_r_reg[17 : 0]}:
                      (b_nr_reg == 4'b1101) ? {18'bz,d_check_r_reg[17 : 9],9'bz}:
                      (b_nr_reg == 4'b1110) ? {27'bz,d_check_r_reg[8 : 0]}:
                      (b_nr_reg == 4'b1111) ? 36'bz:36'bz;
                                               

   assign d_check_l_x = (b_nl_reg == 4'b0000) ? `BYTE_4'bx:
                      (b_nl_reg == 4'b0001) ? {`BYTE_3'bx,`BYTE_1'bz}:
                      (b_nl_reg == 4'b0010) ? {`BYTE_2'bx,`BYTE_1'bz,`BYTE_1'bx}:
                      (b_nl_reg == 4'b0011) ? {`BYTE_2'bx,`BYTE_2'bz}:
                      (b_nl_reg == 4'b0100) ? {`BYTE_1'bx,`BYTE_1'bz,`BYTE_2'bx}:
                      (b_nl_reg == 4'b0101) ? {`BYTE_1'bx,`BYTE_1'bz,`BYTE_1'bx,`BYTE_1'bz}:
                      (b_nl_reg == 4'b0110) ? {`BYTE_1'bx,`BYTE_2'bz,`BYTE_1'bx}:
                      (b_nl_reg == 4'b0111) ? {`BYTE_1'bx,`BYTE_3'bz}:
                      (b_nl_reg == 4'b1000) ? {`BYTE_1'bz,`BYTE_3'bx}:
                      (b_nl_reg == 4'b1001) ? {`BYTE_1'bz,`BYTE_2'bx,`BYTE_1'bz}:
                      (b_nl_reg == 4'b1010) ? {`BYTE_1'bz,`BYTE_1'bx,`BYTE_1'bz,`BYTE_1'bx}:
                      (b_nl_reg == 4'b1011) ? {`BYTE_1'bz,`BYTE_1'bx,`BYTE_2'bz}:
                      (b_nl_reg == 4'b1100) ? {`BYTE_2'bz,`BYTE_2'bx}:
                      (b_nl_reg == 4'b1101) ? {`BYTE_2'bz,`BYTE_1'bx,`BYTE_1'bz}:
                      (b_nl_reg == 4'b1110) ? {`BYTE_3'bz,`BYTE_1'bx}:
                      (b_nl_reg == 4'b1111) ? `BYTE_4'bz:`BYTE_4'bx;
   
   assign d_check_r_x = (b_nr_reg == 4'b0000) ? `BYTE_4'bx:
                      (b_nr_reg == 4'b0001) ? {`BYTE_3'bx,`BYTE_1'bz}:
                      (b_nr_reg == 4'b0010) ? {`BYTE_2'bx,`BYTE_1'bz,`BYTE_1'bx}:
                      (b_nr_reg == 4'b0011) ? {`BYTE_2'bx,`BYTE_2'bz}:
                      (b_nr_reg == 4'b0100) ? {`BYTE_1'bx,`BYTE_1'bz,`BYTE_2'bx}:
                      (b_nr_reg == 4'b0101) ? {`BYTE_1'bx,`BYTE_1'bz,`BYTE_1'bx,`BYTE_1'bz}:
                      (b_nr_reg == 4'b0110) ? {`BYTE_1'bx,`BYTE_2'bz,`BYTE_1'bx}:
                      (b_nr_reg == 4'b0111) ? {`BYTE_1'bx,`BYTE_3'bz}:
                      (b_nr_reg == 4'b1000) ? {`BYTE_1'bz,`BYTE_3'bx}:
                      (b_nr_reg == 4'b1001) ? {`BYTE_1'bz,`BYTE_2'bx,`BYTE_1'bz}:
                      (b_nr_reg == 4'b1010) ? {`BYTE_1'bz,`BYTE_1'bx,`BYTE_1'bz,`BYTE_1'bx}:
                      (b_nr_reg == 4'b1011) ? {`BYTE_1'bz,`BYTE_1'bx,`BYTE_2'bz}:
                      (b_nr_reg == 4'b1100) ? {`BYTE_2'bz,`BYTE_2'bx}:
                      (b_nr_reg == 4'b1101) ? {`BYTE_2'bz,`BYTE_1'bx,`BYTE_1'bz}:
                      (b_nr_reg == 4'b1110) ? {`BYTE_3'bz,`BYTE_1'bx}:
          (b_nr_reg == 4'b1111) ? `BYTE_4'bz:`BYTE_4'bx;
   
   
  
   initial
     begin 
        $dumpvars();
        $dumpfile("cy7c0852v.vcd");
        clkl = 1'b0;
        clkr = 1'b0;
        individual_tests = 1'b0;
        
        $readmemh("dpram_array.txt",mem_test);
        init_and_reset;
        
        #`MSGDLY;
        #`MSGDLY;
        
        if((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_TEST)) begin             
           vector = vector + 1; 
           $display("\n----------- NON BURST WRITE WITH READ TRANSACTIONS  ------------");           
           $display("\n\t vec. %0d. LEFT PORT -  Test to Write and Read back \n ",vector); 
           b_nl_reg = 4'b0000;
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000017;
           single_write_left1;                    // write from left port
           d_check_l_reg = Data_l;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           
           
        end   
  
        if((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_TEST)) begin             
           vector = vector + 1; 
           $display("\n\t vec. %0d. RIGHT PORT - Test to Write and Read back \n",vector); 
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h0fabe; 
           Data_r =  `DATA_MSB_1'h012100017;
           single_write_right1;                   // write from right port  
           d_check_r_reg = Data_r;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end

        if ((TESTCASE == `TEST_ALL) ||  (TESTCASE == `WR_l_RD_r_TEST)) begin
           vector = vector + 1;  
           $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read from RIGHT PORT at different locations \n",vector); 
           b_nl_reg = 4'b0000;
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h00001; 
           Data_r =  `DATA_MSB_1'h000000001;
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h234560017;
           d_check_r_reg = Data_r;
           ->wr_l_rd_r_same_event;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
                     
        end


 if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_RD_r_SAME_TEST)) begin
            
            vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read from RIGHT PORT at same location \n",vector); 
            b_nr_reg = 4'b0000;
            b_nl_reg = 4'b0000;
            d_check_r_reg = `DATA_MSB_1'h11110017;
            Addr_r =  `ADDR_MSB_1'h03067; 
            Data_r =  `DATA_MSB_1'h000000015;
            Addr_l =  `ADDR_MSB_1'h03067; 
            Data_l =  `DATA_MSB_1'h11110017;
            d_check_r_reg = `DATA_MSB_1'h11110017;
            ->wr_l_rd_r_same_event;
            #`MSGDLY;
            #`MSGDLY;

            
         end
                
         if ((TESTCASE == `TEST_ALL)|| (TESTCASE == `RD_l_WR_r_TEST))begin
            vector = vector + 1;
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at different locations \n",vector); 
            b_nr_reg = 4'b0000;
            b_nl_reg = 4'b0000;
            Addr_r =  `ADDR_MSB_1'h00f10; 
            Data_r =  `DATA_MSB_1'h000000015;
            Addr_l =  `ADDR_MSB_1'h00001; 
            Data_l =  `DATA_MSB_1'h000000010;
            d_check_l_reg = `DATA_MSB_1'h000000001;
            ->rd_l_wr_r_same_event;
            #`MSGDLY;
            #`MSGDLY;
            #`tCCS;
         

         end
 

        if ((TESTCASE == `TEST_ALL) ||(TESTCASE == `RD_l_WR_r_SAME_TEST)) begin  
           vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at same location \n",vector); 
           b_nr_reg = 4'b0000;
           b_nl_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h000f1; 
           Data_r =  `DATA_MSB_1'h000000010;
           Addr_l =  `ADDR_MSB_1'h000f1; 
           Data_l =  `DATA_MSB_1'h000000010;
           single_write_right;
           d_check_l_reg = Data_r;
           #`tCCS
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
   
        if((TESTCASE == `TEST_ALL)||(TESTCASE ==`WR_RD_WR_l))begin
           vector = vector + 1;             //42
           $display("\n\t vec. %0d. LEFT PORT - Test to Write - Read - Write \n ",vector);
           b_nl_reg = 4'b0000;
           WR_RD_WR_l_TASK;
           for(i=0; i<2; i=i+1)
           begin           
              #`MSGDLY;
              #`MSGDLY ;          
           end
        end
        if((TESTCASE == `TEST_ALL)||(TESTCASE ==`WR_RD_WR_r))begin       
           vector = vector + 1;             //43
           $display("\n\t vec. %0d. RIGHT PORT - Test to Write - Read - Write \n",vector);
           d_check_l_reg =`DATA_MSB_1'h232001234;
           b_nr_reg = 4'b0000;
           WR_RD_WR_r_TASK;
           for(i=0; i<2; i=i+1)
           begin           
              #`MSGDLY
                #`MSGDLY ;          
           end

        end
        if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_WR_RD_l))begin      
           d_check_l_reg = `DATA_MSB_1'h000000001;
           vector = vector + 1; 
           $display("\n\t vec. %0d. LEFT PORT  - Test to Read - Write - Read  \n",vector);
           b_nl_reg = 4'b0000;
           RD_WR_RD_l_TASK;
           for(i=0; i<2; i=i+1)
           begin           
              #`MSGDLY;
              #`MSGDLY ;          
           end             
        end
        

        if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_WR_RD_r))begin        
           d_check_r_reg = `DATA_MSB_1'h000000002;
           b_nr_reg = 4'b0000;
           vector = vector + 1; 
           $display("\n\t vec. %0d. RIGHT PORT - Test to Read - Write - Read  \n",vector);
           RD_WR_RD_r_TASK;
           #`MSGDLY;
           #`MSGDLY;
               
        end

        if((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_OE_nl_TEST)) begin             
           vector = vector + 1; 
           $display("\n\t --------------  OUTPUT ENABLE TESTS ---------------\n");                     
           $display("\n\t vec. %0d. LEFT PORT -  Test to Write and Read back with OE CONTROLLED\n",vector);  
           b_nl_reg = 4'b0000;
           Addr_l =  `ADDR_MSB_1'h15f01; 
           Data_l =`DATA_MSB_1'h111100552;
           single_write_left;
           d_check_l_reg = Data_l;  
           read_l_oe1;                            // read left with OE    
           #`MSGDLY;
           #`MSGDLY;

        end
        if((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_OE_nr_TEST)) begin             
           vector = vector + 1; 
           $display("\n\t vec. %0d. RIGHT PORT - Test to Write and Read back with OE CONTROLLED\n",vector); 
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h06f01; 
           Data_r =`DATA_MSB_1'h10007552;
           single_write_right;
           d_check_r_reg = Data_r;  
           read_r_oe1;                            // read left with OE    
           #`MSGDLY;
           #`MSGDLY;
        end
  
        if ((TESTCASE == `TEST_ALL)||(TESTCASE ==`WR_RD_WR_l_oe)) begin
           vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT -  Test to Write - Read - Write with OE CONTROLLED\n",vector); 
           b_nl_reg = 4'b0000;
           Addr_l =  `ADDR_MSB_1'h16f01; 
           Data_l =`DATA_MSB_1'h000117552;
           single_write_left;
           d_check_l_reg = Data_l;  
           Data_l = `DATA_MSB_1'ha221fff2; 
           read_l_oe2;                            // read left with OE    
           d_check_l_reg = Data_l;  
           read_l;  
           #`MSGDLY;
           #`MSGDLY;
        end
        
        if ((TESTCASE == `TEST_ALL)||(TESTCASE ==`WR_RD_WR_r_oe)) begin
           vector = vector + 1; 
           $display("\n\t vec. %0d. RIGHT PORT - Test to Write - Read - Write with  OE CONTROLLED\n",vector); 
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h06f01; 
           Data_r =  `DATA_MSB_1'hdcc007552;
           single_write_right;
           d_check_r_reg = Data_r;  
           Data_r = `DATA_MSB_1'hbac00fff2; 
           read_r_oe2;                            // read left with OE    
           d_check_r_reg = Data_r;  
           read_r; 
           #`MSGDLY;
           #`MSGDLY;
        end
         
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0001)) begin
           vector = vector + 1;           
           $display("\n---------------------- BYTE ENABLE TESTS--------------------------\n");
           
           $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 0001\n   ",vector);
           b_nl_reg = 4'b0000;
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0001;
           single_write_left;      
           d_check_l_reg =`DATA_MSB_1'h123456600;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0010)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 0010\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0010;
           single_write_left;
           b_nl_reg = 4'b0000;
           d_check_l_reg =`DATA_MSB_1'h123440189;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0011)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 0011\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0011;
           single_write_left;
           d_check_l_reg =`DATA_MSB_1'h123440000;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0100)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 0100\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0100;
           single_write_left;
           d_check_l_reg =`DATA_MSB_1'h120016789;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0101)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 0101\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0101;
           single_write_left;
           d_check_l_reg =`DATA_MSB_1'h120016600;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0110)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 0110\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0110;
           single_write_left;
           d_check_l_reg =`DATA_MSB_1'h120000189;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_0111)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 0111\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0111;
           single_write_left;
           d_check_l_reg =`DATA_MSB_1'h120000000;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1000)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1000\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1000;
           single_write_left;

           d_check_l_reg =`DATA_MSB_1'h003456789;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1001)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1001\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1001;
           single_write_left;
     
           d_check_l_reg =`DATA_MSB_1'h003456600;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end

  
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1010)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1010\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1010;
           single_write_left;
     
           d_check_l_reg =`DATA_MSB_1'h003440189;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1011)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1011\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1011;
           single_write_left;
           d_check_l_reg =`DATA_MSB_1'h003440000;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1100)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1100\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1100;
           single_write_left;      
           d_check_l_reg =`DATA_MSB_1'h000016789;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;            
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1101)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1101\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1101;
           single_write_left;      
           d_check_l_reg =`DATA_MSB_1'h000016600;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
  
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1110)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1110\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1110;
           single_write_left;      
           d_check_l_reg =`DATA_MSB_1'h000000189;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end

        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_be_1111)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to LEFT PORT with byte enable = 1111\n   ",vector); 
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000000000;
           b_nl_reg = 4'b0000;
           single_write_left;      
           Data_l =  `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b1111;
           single_write_left;      
           d_check_l_reg =`DATA_MSB_1'h00000000;
           b_nl_reg = 4'b0000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;            
           #`MSGDLY;
        end

        // for right port
       
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0001)) begin
           vector = vector + 1;           
           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0001\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0001;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h123456600;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0010)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0010\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0010;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h123440189;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0011)) begin
     
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0011\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0011;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h123440000;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0100)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0100\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0100;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h120016789;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0101)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0101\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0101;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h120016600;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0110)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0110\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0110;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h120000189;
     
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;

        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_0111)) begin
           vector = vector + 1;           
           
           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 0111\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0111;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h120000000;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1000)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1000\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1000;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h003456789;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1001)) begin
           vector = vector + 1;           
           
           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1001\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1001;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h003456600;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
  
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1010)) begin
           vector = vector + 1;           
           
           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1010\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1010;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h003440189;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1011)) begin
           vector = vector + 1;           
           
           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1011\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1011;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h003440000;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1100)) begin
           vector = vector + 1;           
           
           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1100\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1100;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h000016789;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1101)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1101\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1101;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h000016600;
     
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1110)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1110\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1110;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h000000189;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_be_1111)) begin
           vector = vector + 1;           

           $display("\n\t vec. %0d.Test to Write to RIGHT PORT with byte enable = 1111\n   ",vector); 
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           single_write_right;      
           Data_r =  `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b1111;
           single_write_right;      
           d_check_r_reg =`DATA_MSB_1'h000000000;
           b_nr_reg = 4'b0000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
        end
        //---------------------------------------------------------------
        // read with byte enable starts left port
        //---------------------------------------------------------------
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0001)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0001 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           #`MSGDLY;
           b_nl_reg = 4'b0001;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0010)) begin

           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0010 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
     
           b_nl_reg = 4'b0010;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0011)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0011 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;

           b_nl_reg = 4'b0011;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0100)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0100 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b0100;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0101)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0101 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b0101;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0110)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0110 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b0110;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_0111)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 0111 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b0111;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1000)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1000 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1000;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1001)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1001 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1001;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1010)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1010 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1010;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end

        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1011)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1011 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1011;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1100)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1100 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1100;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1101)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1101 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1101;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1110)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1110 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1110;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_be_1111)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 1111 \n  ",vector); 
           Addr_l =  `ADDR_MSB_1'h00101; 
           Data_l = `DATA_MSB_1'h123456789;
           b_nl_reg = 4'b0000;
           single_write_left1;
           d_check_l_reg = Data_l;
           b_nl_reg = 4'b1111;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end
        

        //--------------------------------------------------             
        // read byte enable ends here for left                           
        //--------------------------------------------------             
        //---------------------------------------------------------------                 
        // read with byte enable starts right port                       
        //---------------------------------------------------------------
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0001)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0001 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0001;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0010)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0010 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0010;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0011)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0011 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0011;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0100)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0100 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0100;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0101)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0101 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0101;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0110)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0110 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0110;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_0111)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 0111 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b0111;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1000)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1000 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1000;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1001)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1001 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1001;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1010)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1010 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1010;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1011)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1011 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1011;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1100)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1100 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1100;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1101)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1101 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1101;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1110)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1110 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
           b_nr_reg = 4'b1110;
           read_r;
           #`MSGDLY;
           #`MSGDLY;
        end
        if ((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_be_1111)) begin
           vector = vector + 1;             
           $display("\n\t vec. %0d.Test to Read from RIGHT PORT with byte enable = 1111 \n  ",vector); 
           Addr_r =  `ADDR_MSB_1'h00101; 
           Data_r = `DATA_MSB_1'h123456789;
           b_nr_reg = 4'b0000;
           single_write_right1;
           d_check_r_reg = Data_r;
            b_nr_reg = 4'b1111;
            read_r;
            #`MSGDLY;
            #`MSGDLY;
         end
      
         //--------------------------------------------------
         // read byte enable ends here for right port
         //--------------------------------------------------
      
        if((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_TEST_WO_nCE_11)) begin
           vector = vector + 1; 
           $display("\n----------- CHIP ENABLE TESTS ---------\n ");
           $display("\n\t vec. %0d. Test to Read from LEFT PORT with /CE0 = 1 , CE1 = 1\n",vector);
           b_nl_reg = 4'b0000;
           Addr_l =  `ADDR_MSB_1'h00065; 
           Data_l =  `DATA_MSB_1'h000000015;
            rd_l_wo_nce;
            #`MSGDLY;
            #`MSGDLY;
         end
         if((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_TEST_WO_nCE_11)) begin
         
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Read from RIGHT PORT with /CE0 = 1 , CE1 = 1\n",vector);
            b_nr_reg = 4'b0000;
            Addr_r =  `ADDR_MSB_1'h00067; 
            Data_r =  `DATA_MSB_1'h000000017;
            rd_r_wo_nce;
            #`MSGDLY;
            #`MSGDLY;
         end
         if((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_l_TEST_WO_nCE_00)) begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Read from LEFT PORT With /CE0 = 0 , CE1 = 0\n",vector);
            b_nl_reg = 4'b0000;
            Addr_l =  `ADDR_MSB_1'h00065; 
            Data_l =  `DATA_MSB_1'h000000015;
            rd_l_wo_nce1;
            #`MSGDLY;
            #`MSGDLY;
         end
         if((TESTCASE == `TEST_ALL) || (TESTCASE == `RD_r_TEST_WO_nCE_00)) begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Read from RIGHT PORT with /CE0 = 0 , CE1 = 0\n",vector);
            b_nr_reg = 4'b0000;
            Addr_r =  `ADDR_MSB_1'h00067; 
            Data_r =  `DATA_MSB_1'h000000017;
            rd_r_wo_nce1;
            #`MSGDLY;
            #`MSGDLY;
         end
         if((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_l_TEST_WO_nCE)) begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Write to LEFT PORT without Chip Enable \n",vector);
            $display("\n\t\t Writing to LEFT PORT with Chip Enabled ( /CE0 = 0 , CE1 = 1 )\n");
            b_nl_reg = 4'b0000;
            Addr_l =  `ADDR_MSB_1'h00065; 
            Data_l =  `DATA_MSB_1'h000000015;
            single_write_left1;
            $display("\n\t\t Writing to LEFT PORT without Chip Enabled ( /CE0 = 1 , CE1 = 1 )\n"); 
            Data_l =  `DATA_MSB_1'h00000b015;
            wr_l_wo_nce;     
            d_check_l_reg = `DATA_MSB_1'h000000015;
            read_l;
            #`MSGDLY;
            #`MSGDLY;
         end
         if((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_r_TEST_WO_nCE)) begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Write to RIGHT PORT without Chip Enable \n",vector);
            $display("\n\t\t Writing to RIGHT PORT with Chip Enabled ( /CE0 = 0 , CE1 = 1 )\n");
            b_nr_reg = 4'b0000;
            Addr_r =  `ADDR_MSB_1'h00065; 
            Data_r =  `DATA_MSB_1'h000000015;
            single_write_right1;
            $display("\n\t\t Writing to RIGHT PORT without Chip Enabled ( /CE0 = 1 , CE1 = 1 )\n"); 
            Data_r =  `DATA_MSB_1'h000007715;
            wr_r_wo_nce;     
            d_check_r_reg = `DATA_MSB_1'h000000015;   
            read_r;
            #`MSGDLY;
            #`MSGDLY;
         end


         //-----------------------------------------------------------------------
         if((TESTCASE == `WR_l_10_RD_l_10) || (TESTCASE == `TEST_ALL)) begin
            vector = vector + 1; 
            $display("\n\t ------------ CONSECUTIVE READ/WRITE TEST ---------------\n"); 
            $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from  LEFT PORT 10 DATAs consecutively \n ",vector);
            b_nl_reg = 4'b0000;
            Addr_l = `ADDR_MSB_1'h00000;
            Data_l = `DATA_MSB_1'h000000000;
            for(i=0; i<10; i=i+1)
            begin
               single_write_left;
               d_check_l_reg = Data_l;
               read_l;
               #`tCYC2
                 Addr_l = Addr_l + 1;                         
               Data_l = Data_l + 1;
            end
            #`MSGDLY;
            #`MSGDLY;
            #`MSGDLY;
         end
         if((TESTCASE == `WR_r_10_RD_r_10) || (TESTCASE == `TEST_ALL)) begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from RIGHT PORT 10 DATAs consecutively\n",vector);
            b_nl_reg = 4'b0000;
            b_nr_reg = 4'b0000;
            Addr_r = `ADDR_MSB_1'h00000;
            Data_r = `DATA_MSB_1'h000000000;
            for(i=0; i<10; i=i+1)
            begin
               single_write_right;
               d_check_r_reg = Data_r;
               read_r;
               #`tCYC2;
               Addr_r = Addr_r + 1;                         
               Data_r = Data_r + 1;
            end
            #`MSGDLY;
         
            #`MSGDLY;
         end
      
         if((TESTCASE == `TEST_ALL)||(TESTCASE == ` WR_l_RD_r_1FFFF))  begin
            vector = vector + 1;  
            $display("\n-------------------- WRITE/READ AT HIGHEST MEMORY LOCATION--------------------\n");
            #`tCCS 

               $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from RIGHT PORT at the Highest Memory Location 1FFFF \n",vector); 
            b_nr_reg = 4'b0000;
            b_nl_reg = 4'b0000;
         
            Addr_r =  `ADDR_MSB_1'h1FFFF; 
            Data_r =  `DATA_MSB_1'hzzzzzzzzz;
            Addr_l =  `ADDR_MSB_1'h1FFFF; 
            Data_l =  `DATA_MSB_1'h000000017;
            d_check_r_reg = `DATA_MSB_1'h000000017;
            ->wr_l_rd_r_1FFF;
            for(i=0; i<5; i=i+1)
            begin           
               #`MSGDLY;
               #`MSGDLY ;          
            end
         end
            if((TESTCASE == `TEST_ALL)||(TESTCASE == ` WR_r_RD_l_1FFFF))begin 
               vector = vector + 1; 
               $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from LEFT PORT at the Highest Memory Location 1FFFF \n ",vector); 
               b_nr_reg = 4'b0000;
               b_nl_reg = 4'b0000;
               Addr_r =  `ADDR_MSB_1'h1FFFF; 
               Data_r =  `DATA_MSB_1'h000000017;
               Addr_l =  `ADDR_MSB_1'h1FFFF; 
               Data_l =  `DATA_MSB_1'hzzzzzzzzz;
               d_check_l_reg = `DATA_MSB_1'h000000017;
               ->wr_r_rd_l_1FFF;
               for(i=0; i<2; i=i+1)
               begin           
                  #`MSGDLY;
                  #`MSGDLY ;          
               end
            end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `WR_l_RD_l_1FFFF)) begin         
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from LEFT PORT at the Highest Memory Location 1FFFF \n ",vector); 
                  b_nl_reg = 4'b0000;
                  Addr_l =  `ADDR_MSB_1'h1FFFF; 
                  Data_l =  `DATA_MSB_1'h000000017;
                  d_check_l_reg = `DATA_MSB_1'h000000017;
                  single_write_left;
                  #`tCCS
                    read_l;
                  #`MSGDLY;
                  #`MSGDLY;
                  #`MSGDLY;
               end          
               if((TESTCASE == `TEST_ALL)||(TESTCASE == ` WR_r_RD_r_1FFFF))  begin  
                  vector = vector + 1;             
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from RIGHT PORT at the Highest Memory Location 1FFFF \n",vector); 
                  b_nr_reg = 4'b0000;
                  Addr_r =  `ADDR_MSB_1'h1FFFF; 
                  Data_r =  `DATA_MSB_1'h000000017; 
                  d_check_r_reg = `DATA_MSB_1'h000000017;              
                  single_write_right;
                  #`tCCS
                    read_r;
                  #`MSGDLY;
                  #`MSGDLY;
                  #`MSGDLY;
               end
      
         if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_l_r_diff))  begin
            vector = vector + 1;             
            $display("\n\t vec. %0d. Test to Read from both the ports at different location \n",vector); 
            b_nr_reg = 4'b0000;
            b_nl_reg = 4'b0000;
            Addr_r = `ADDR_MSB_1'h00001;
            Addr_l = `ADDR_MSB_1'h00002;
            d_check_r_reg = `DATA_MSB_1'h000000001;
            d_check_l_reg = `DATA_MSB_1'h000000002;
            ->rd_l_r_sam;
            #`MSGDLY;
            #`MSGDLY;
            #`MSGDLY;
         end

         if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_l_r_sam))  begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Read 2 Datas from both the ports at same location  \n",vector); 
            b_nl_reg = 4'b0000;             
            b_nr_reg = 4'b0000;
            Addr_r = `ADDR_MSB_1'h00001;
            Addr_l = `ADDR_MSB_1'h00001;
            d_check_l_reg = `DATA_MSB_1'h000000001;
            d_check_r_reg = `DATA_MSB_1'h000000001;
            ->rd_2_l_r_sam;
            #`MSGDLY;
            #`MSGDLY;
            #`MSGDLY;
         

         end
         if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_2_l_r_diff))  begin
            vector = vector + 1; 
            $display("\n\t vec. %0d. Test to Read 2 Datas from both the ports at different location \n",vector); 
            b_nl_reg = 4'b0000;
            b_nr_reg = 4'b0000;
            Addr_r = `ADDR_MSB_1'h00001;
            Addr_l = `ADDR_MSB_1'h00002;
            d_check_l_reg = `DATA_MSB_1'h000000002;
            d_check_r_reg = `DATA_MSB_1'h000000001;
            ->rd_2_l_r_sam;
            #`MSGDLY;
            #`MSGDLY;
            #`MSGDLY;
            #`MSGDLY;
         end

        if ((TESTCASE == `TEST_ALL)||(TESTCASE ==`WRITE_COLLISION_TEST_L_FIRST)) begin 
           vector = vector + 1;
           #`MSGDLY;
           #`MSGDLY;

           $display("\n\t vec. %0d. Test to Write to both the ports at same location without Violating tCCS \n",vector); 
           $display("\t\t Writing to LEFT PORT First \n");

           b_nl_reg = 4'b0000;
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h00f67; 
           Data_r =  `DATA_MSB_1'h000000017;
           Addr_l =  `ADDR_MSB_1'h00f67; 
           Data_l =  `DATA_MSB_1'h000015555;
           
           
           ->collision_event;
           
           #`MSGDLY;
           #`MSGDLY;

           d_check_r_reg = Data_r;
           read_r;
           
        end
        
        if ((TESTCASE == `TEST_ALL)||(TESTCASE ==`WRITE_COLLISION_TEST_R_FIRST)) begin 
           vector = vector + 1; 
           #`MSGDLY;
           #`MSGDLY;
           #`tCCS;
           $display("\n\t vec. %0d. Test to Write to both the ports at same location without Violating tCCS \n",vector); 
           $display("\t\t Writing to RIGHT PORT First \n");

           b_nl_reg = 4'b0000;
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h00067; 
           Data_r =  `DATA_MSB_1'h000000017;
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h000025555;
           ->collision_event1;
           #`MSGDLY;
           #`MSGDLY;
           d_check_r_reg = Data_l;
           read_r;
           #`MSGDLY;
           #`MSGDLY;

        end

        if ((TESTCASE == `TEST_ALL)||(TESTCASE ==`WR_BOTH_TEST)) begin 
           vector = vector + 1;             
           $display("\n\t vec. %0d. Test to Write and Read back from both the ports at different location \n",vector); 
           b_nl_reg = 4'b0000;
           b_nr_reg = 4'b0000;
           Addr_r =  `ADDR_MSB_1'h00065; 
           Data_r =  `DATA_MSB_1'h0000a0015;
           Addr_l =  `ADDR_MSB_1'h00067; 
           Data_l =  `DATA_MSB_1'h0000b0017;
           ->both_write_event;
           #`MSGDLY;
           #`MSGDLY;
           #`MSGDLY;
           d_check_r_reg = Data_r;
           read_r;
           d_check_l_reg = Data_l;
           read_l;
           #`MSGDLY;
           #`MSGDLY;
        end


               if ((TESTCASE == `TEST_ALL) || (TESTCASE == `WR_COLLISION_VIOLATION_TEST)) begin               
                  $display("\n ---------- SIMULTANEOUS READ/WRITE WITH tCCS violation------------------\n");
                  vector = vector + 1;              
                  $display("\n\t vec. %0d. Test to Write to both the ports at same location Violating tCCS \n",vector); 
                  b_nr_reg = 4'b0000;
                  b_nl_reg = 4'b0000;
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  Data_r =  `DATA_MSB_1'h000000000;
                  single_write_right1;                   // write to right port  
                  #`MSGDLY;
                  #`tCCS;
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  Data_r =  `DATA_MSB_1'h000000017;
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h000015555;
                  ->collision_violation_event;
                  #`MSGDLY;
               
                  $display("\n\t\t Read back from the same location after collision\n "); 
                  Addr_l =  `ADDR_MSB_1'h00067;
                  d_check_l_reg = `DATA_MSB_1'h000000017;
                  read_l;                               // read left without OE
                  #`MSGDLY;
                  #`MSGDLY;
                  #`MSGDLY;
                  #`tCCS;
               end

               if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_r_WR_l_sam_violation))begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. Test to Read from RIGHT PORT and write to LEFT PORT at same location violating tCCS\n",vector); 
                  b_nr_reg = 4'b0000;
                  b_nl_reg = 4'b0000;
                  Addr_r =  `ADDR_MSB_1'h0a058; 
                  Data_r =  `DATA_MSB_1'h000005515;
                  single_write_right;
                  #`MSGDLY
                    Addr_l =  `ADDR_MSB_1'h0a058; 
                  Data_l =  `DATA_MSB_1'h00000aa17;
                  d_check_r_reg = `DATA_MSB_1'h000005515;
                  ->rd_r_wr_l_same_event;
                  #`MSGDLY
                    #`MSGDLY
                      d_check_r_reg = `DATA_MSB_1'h00000aa17;
                  read_r;
                  #`MSGDLY;
                  #`MSGDLY;
                  #`MSGDLY;
               end

               if((TESTCASE == `TEST_ALL)||(TESTCASE == `WR_r_RD_l_sam_violation)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at same location violating tCCS\n",vector); 
                  b_nr_reg = 4'b0000;
                  b_nl_reg = 4'b0000;
                  Addr_r =  `ADDR_MSB_1'h0a5f1; 
                  Data_r =  `DATA_MSB_1'h000000011;
                  Addr_l =  `ADDR_MSB_1'h0a5f1; 
                  Data_l =  `DATA_MSB_1'h000000010;
                  ->rd_l_wr_r_event;
                  #`MSGDLY;
                  #`MSGDLY;
                  d_check_l_reg = Data_r;
                  read_l;              
                  #`MSGDLY;
                  #`MSGDLY;
                  #`MSGDLY;
               end

               if((TESTCASE == `TEST_ALL)||(TESTCASE == `RD_l_r_sam_VIOLATION)) begin
                  vector = vector + 1;   
                  $display("\n\t vec. %0d. Test to Read from both the ports at same location Violating tCCS \n",vector); 
                  b_nr_reg = 4'b0000;
                  b_nl_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h00cc1;
                  Addr_l = `ADDR_MSB_1'h00cc1;
                  Data_l = `DATA_MSB_1'h00000fdc1;   
                  single_write_left;
                  #`MSGDLY;
                  d_check_l_reg = `DATA_MSB_1'h00000fdc1;  // as changed in simultaneous 
                  d_check_r_reg = `DATA_MSB_1'h00000fdc1;
                  ->rd_l_r_sam;
                  #`MSGDLY;
                  #`MSGDLY;
                  #`MSGDLY;
               
               end



               if((TESTCASE == `TEST_ALL)||(TESTCASE == `MSK_RST_l)) begin
                  vector = vector + 1;
                  $display("\n ------------ SPECIAL FEATURE OPERATIONS ---------- \n");  
                  $display("\n ------------ MASK REGISTER OPERATIONS ---------- \n ");              
                  $display("\n\t vec. %0d. LEFT PORT - Test to Mask Reset and Mask Read Back Operations\n",vector); 
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'h0007f;
                  load_mask_l;
                  Addr_l = `ADDR_MSB_1'h1ffff;
                  mask_reset_l;
                  read_mask_l;         
                  #`MSGDLY;
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `MSK_LOAD_l)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT - Test to Mask Load and Mask Read Back Operations\n",vector); 
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'h1ffff;
                  mask_reset_l;
                  read_mask_l;                  
                  Addr_l = `ADDR_MSB_1'h0007f;
                  load_mask_l;
                  Addr_l = `ADDR_MSB_1'h0007f;
                  read_mask_l;  
                  Addr_l = `ADDR_MSB_1'h000ff;
                  load_mask_l;                                       
                  $display("\n\t\t Invalid loading of LEFT PORT Mask Register \n");              
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'hx003f;
                  load_mask_l;
                  Addr_l = `ADDR_MSB_1'h000ff;
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Addr bus",$realtime);
                  read_mask_l;                  
                  #`MSGDLY;
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `MSK_RST_r)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Mask Reset and Mask Read Back Operations \n ",vector); 
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h0007f;
                  load_mask_r;
                  Addr_r = `ADDR_MSB_1'h3ffff;
                  mask_reset_r;
                  read_mask_r;                  
                  #`MSGDLY;

               end 
               if ((TESTCASE == `TEST_ALL)||(TESTCASE == `MSK_LOAD_r)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Mask Load and Mask Read Back Operations \n ",vector);          
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h3ffff;
                  mask_reset_r;
                  read_mask_r;                  
                  Addr_r = `ADDR_MSB_1'h0007f;
                  load_mask_r;
                  Addr_r = `ADDR_MSB_1'h0007f;
                  read_mask_r;                  
                  Addr_r = `ADDR_MSB_1'h000ff;
                  load_mask_r;                                       
                  $display("\n\t\t Invalid loading of RIGHT PORT Mask Register \n");
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'hx003f;
                  load_mask_r;
                  Addr_r = `ADDR_MSB_1'h000ff;
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Addr bus",$realtime);
                  read_mask_r;                  
                  #`MSGDLY;

               end 

            
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `CNTR_RST_l)) begin
                  $display("\n ------------ COUNTER REGISTER OPERATIONS ---------- \n ");         
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT - Test to Counter Reset and Counter Read Back Operations \n ",vector);              
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'h0007f;
                  load_mask_l;                   
                  Addr_l = `ADDR_MSB_1'h3983f;
                  load_cntr_l;
                  read_cntr_l;                  
                  Addr_l = `ADDR_MSB_1'h39800;
                  cntr_reset_l;
                  read_cntr_l;                  
                  #`MSGDLY;
               end

            
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `CNTR_LOAD_l)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT - Test to Counter Reset, Counter Load and Counter Read Back Operations \n ",vector);              
                  b_nl_reg = 4'b0000;
                  mask_reset_l; 
                  Addr_l = `ADDR_MSB_1'h00000;
                  cntr_reset_l;
                  read_cntr_l;           
                  #`MSGDLY;                     
                  Addr_l = `ADDR_MSB_1'h0003f;
                  load_cntr_l;
                  read_cntr_l;                  
                  #`MSGDLY;              
                  Addr_l = `ADDR_MSB_1'h0077f;
                  load_cntr_l;
                  Addr_l = `ADDR_MSB_1'hx003f;
                  load_cntr_l;
                  Addr_l = `ADDR_MSB_1'h0077f;
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Addr bus",$realtime);
                  read_cntr_l;                  
                  #`MSGDLY;
               end

            
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `CNTR_RST_r)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Counter Reset and Counter Read Back Operations \n ",vector);                         
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h0007f;
                  load_mask_r;                   
                  Addr_r = `ADDR_MSB_1'h3ff3f;
                  load_cntr_r;
                  read_cntr_r;                  
                  Addr_r = `ADDR_MSB_1'h3ff00;
                  cntr_reset_r;
                  read_cntr_r;                             
                  #`MSGDLY;
               end
            
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `CNTR_LOAD_r)) begin              
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Counter Reset, Counter Load and Counter Read Back Operations \n ",vector);
                  b_nr_reg = 4'b0000;
                  mask_reset_r;
                  Addr_r = `ADDR_MSB_1'h00000;
                  cntr_reset_r;
                  read_cntr_r;           
                  #`MSGDLY;                     
                  Addr_r = `ADDR_MSB_1'h0003f;
                  load_cntr_r;
                  read_cntr_r;           
                  #`MSGDLY;                     
                  Addr_r = `ADDR_MSB_1'h0077f;
                  load_cntr_r;
                  Addr_r = `ADDR_MSB_1'hx003f;
                  load_cntr_r;
                  Addr_r = `ADDR_MSB_1'h0077f;
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Addr bus",$realtime);
                  read_cntr_r;           
                  #`MSGDLY;                     
               end

            
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `BURST_L_PORT_TEST)) begin
                  vector = vector + 1; 
                  $display("\n \t vec. %0d. Test to Burst Write and Read Back Operations \n ", vector);                      // burst write left port
                  b_nl_reg = 4'b0000;
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  wr_burst_l_port_c;
                  // burst read left port             
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  rd_burst_l_port_c;
                  #`MSGDLY;
                  #`MSGDLY;
               

               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `BURST_R_PORT_TEST)) begin
                  //vector = vector + 1; 
                  //$display("\n \t vec. %0d. Test to Burst Write and Read Back Operations \n ", vector);

                  // burst write right port
                  b_nr_reg = 4'b0000;
                  Addr_r =  `ADDR_MSB_1'h2cd1a;
                  Data_r =  `DATA_MSB_1'h00005a012;
                  wr_burst_r_port_c;
                  // burst read right port
                  Addr_r =  `ADDR_MSB_1'h2cd1a;
                  Data_r =  `DATA_MSB_1'h00005a012;
                  rd_burst_r_port_c;
                  #`MSGDLY;
                  #`MSGDLY;
               end
            
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `CNTHLD_L_PORT_TEST)) begin
                  vector = vector + 1; 
                  $display("\n \t vec. %0d. Test to Write and Read back Operations with Counter Hold \n ",vector); 
                  // single write with cnt hold left port 
                  b_nl_reg = 4'b0000;
                  Addr_l =  `ADDR_MSB_1'h00012;
                  Data_l =  `DATA_MSB_1'h00000bcdf;
                  wr_cnthld_l_port_c;
                  nop_l;
                  // single read with cnt hold left port 
                  Addr_l =  `ADDR_MSB_1'h00012;
                  Data_l =  `DATA_MSB_1'h00000bcdf;
                  rd_cnthld_l_port_c;
                  nop_l;
                  nop_l;
                  nop_l; 
               end

               if((TESTCASE == `TEST_ALL)||(TESTCASE == `CNTHLD_R_PORT_TEST)) begin
               
                  // single write with cnt hold right port 
                  Addr_r =  `ADDR_MSB_1'h00005;
                  Data_r =  `DATA_MSB_1'h00000ce12;
                  wr_cnthld_r_port_c;
                  nop_r;
                  // single read with cnt hold right port 
                  Addr_r =  `ADDR_MSB_1'h00005;
                  Data_r =  `DATA_MSB_1'h00000ce12;
                  rd_cnthld_r_port_c;
                  nop_r;
                  nop_r;
                  nop_r;             
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `EVEN_COUNT_RDBK_l)) begin   
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT  - Test to Write and Read operations with Even Address \n ",vector);                  
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'h3ffff;
                  mask_reset_l;
                  read_mask_l; 
                  Addr_l = `ADDR_MSB_1'h3fffe;
                  load_mask_l;
                  read_mask_l;                  
                  #`MSGDLY;
                  #`MSGDLY;
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  wr_burst_l_port_c_count_2;
                  nop_l;
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  rd_burst_l_port_c_count_2;                
                  nop_l;
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `ODD_COUNT_RDBK_l)) begin       
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT  - Test to Write and Read operations with Odd Address \n ",vector);
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'h3ffff;
                  mask_reset_l;
                  read_mask_l; 
                  Addr_l = `ADDR_MSB_1'h3fffe;
                  load_mask_l;
                  read_mask_l;                  
                  #`MSGDLY;
                  #`MSGDLY;
                  Addr_l =  `ADDR_MSB_1'h35001;
                  Data_l =  `DATA_MSB_1'h00002ff77;
                  wr_burst_l_port_c_count_2;
                  nop_l;
                  Addr_l =  `ADDR_MSB_1'h35001;
                  Data_l =  `DATA_MSB_1'h00002ff77;
                  rd_burst_l_port_c_count_2;                               
                  nop_l;
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `EVEN_COUNT_RDBK_r)) begin           
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. RIGHT PORT  - Test to Write and Read operations with Even Address \n ",vector);
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h3ffff;
                  mask_reset_r;
                  read_mask_r; 
                  Addr_r = `ADDR_MSB_1'h3fffe;
                  load_mask_r;
                  read_mask_r;                  
                  #`MSGDLY;
                  #`MSGDLY;
                  Addr_r =  `ADDR_MSB_1'h05500;
                  Data_r =  `DATA_MSB_1'h000025523;
                  wr_burst_r_port_c_count_2;
                  nop_r;
                  Addr_r =  `ADDR_MSB_1'h05500;
                  Data_r =  `DATA_MSB_1'h000025523;
                  rd_burst_r_port_c_count_2;
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `ODD_COUNT_RDBK_r)) begin
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. RIGHT PORT  - Test to Write and Read operations with Odd Address \n ",vector);
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h3ffff;
                  mask_reset_r;
                  read_mask_r; 
                  Addr_r = `ADDR_MSB_1'h3fffe;
                  load_mask_r;
                  read_mask_r;                  
                  #`MSGDLY ;
                  #`MSGDLY;
                  Addr_r =  `ADDR_MSB_1'h05501;
                  Data_r =  `DATA_MSB_1'h000025523;
                  wr_burst_r_port_c_count_2;
                  nop_r;
                  Addr_r =  `ADDR_MSB_1'h05501;
                  Data_r =  `DATA_MSB_1'h000025523;
                  rd_burst_r_port_c_count_2;                                     
                  nop_r;
               end  

               if((TESTCASE == `TEST_ALL)||(TESTCASE == `RETRANSMIT_l)) begin        
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT - Test to Retransmit Operation  \n ",vector);
                  b_nl_reg = 4'b0000;
                  Addr_l = `ADDR_MSB_1'h0000f;
                  load_mask_l;
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  wr_burst_l_port_c_retransmit;
                  nop_l;
                  Addr_l =  `ADDR_MSB_1'h30000;
                  read_cntr_l;                  
                  nop_l;                  
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  rd_burst_l_port_c_retransmit;
                  nop_l;                
                  nop_l; 
                  Addr_l =  `ADDR_MSB_1'h30000;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  rd_burst_l_port_c_retransmit;
                  nop_l;                
                  nop_l; 
                  Addr_l =  `ADDR_MSB_1'h30000;
                  read_cntr_l;                  
                  nop_l;           
               end
               if((TESTCASE == `TEST_ALL)||(TESTCASE == `RETRANSMIT_r)) begin       
                  vector = vector + 1; 
                  $display("\n\t vec. %0d RIGHT PORT - Test to Retransmit Operation  \n ",vector);
                  b_nr_reg = 4'b0000;
                  Addr_r = `ADDR_MSB_1'h0000f;
                  load_mask_r;
                  Addr_r =  `ADDR_MSB_1'h3f000;
                  Data_r =  `DATA_MSB_1'h00003ff55;
                  wr_burst_r_port_c_retransmit;
                  nop_r;
                  Addr_r =  `ADDR_MSB_1'h3f000;
                  read_cntr_r;                  
                  nop_r;
                  Addr_r =  `ADDR_MSB_1'h3f000;
                  Data_r =  `DATA_MSB_1'h00003ff55;
                  rd_burst_r_port_c_retransmit;                
                  nop_r;                
                  nop_r; 
                  Addr_r =  `ADDR_MSB_1'h3f000;
                  Data_r =  `DATA_MSB_1'h00003ff55;
                  rd_burst_r_port_c_retransmit;                
                  Addr_r =  `ADDR_MSB_1'h3f000;
                  nop_r;                
                  nop_r; 
                  read_cntr_r;                  
                  nop_r;
                  vector = vector + 1;       
               end 

               if((TESTCASE == `TEST_ALL)||(TESTCASE == `MAIL_BOX_INT_TEST_L2R)) begin              
                  $display("\n\t vec. %0d. RIGHT PORT - Test to MAILBOX Operations \n ",vector); 
                  b_nr_reg = 4'b0000;
                  Addr_r = ~0;
                  Data_r =  `DATA_MSB_1'h00002ff00;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  mailbox_int_chk_l2r;
               end


               if((TESTCASE == `TEST_ALL)||(TESTCASE == `MAIL_BOX_INT_TEST_R2L)) begin       
                  vector = vector + 1; 
                  $display("\n\t vec. %0d. LEFT PORT - Test to MAILBOX Operations \n ",vector); 
                  b_nl_reg = 4'b0000;
                  Addr_l = ~0 - 1;
                  Data_r =  `DATA_MSB_1'h00002ff00;
                  Data_l =  `DATA_MSB_1'h00002ff00;
                  mailbox_int_chk_r2l;
            
            
              end

         
           if ((TESTCASE == `TEST_ALL)||(TESTCASE == `X_VIOLATIONS)) begin

              $display("\n ------------------ TIMING VIOLATION TESTS----------------*\n");
              vector = vector + 1; 
              $display("\n\t vec. %0d. Test to Read from LEFT PORT With Setup/Hold Violations \n",vector); 
              Addr_l = `ADDR_MSB_1'h00001;
              Addr_r = `ADDR_MSB_1'h00001;
              Data_r = `DATA_MSB_1'h00000001;
              Data_l = `DATA_MSB_1'h00000001;
              single_write_left;
              Addr_l =  `ADDR_MSB_1'h00001;
              Addr_r =  `ADDR_MSB_1'h00001;
              d_check_l_reg = `DATA_MSB_1'h000000001;
              d_check_r_reg = `DATA_MSB_1'h000000001;
              read_l_violation;
              #`MSGDLY;
              #100;
           
              vector = vector + 1; 
              $display("\n\t vec. %0d. Test to Read from RIGHT PORT with Setup/Hold Violations \n",vector); 
              Addr_r =  `ADDR_MSB_1'h00020; 
              Data_r = `DATA_MSB_1'h000000020;
              single_write_right;
              d_check_r_reg = Data_r; 
              read_r_violation;                               // read left without OE
              #`MSGDLY;
           
              vector = vector + 1;
             $display("\n\t vec. %0d. Test to Read from both the ports with Setup/Hold Violations  \n",vector); 
             Addr_l =  `ADDR_MSB_1'h00001;
             Addr_r =  `ADDR_MSB_1'h00001;
             d_check_l_reg = `DATA_MSB_1'h000000001;
             d_check_r_reg = `DATA_MSB_1'h000000001;
             -> rd_l_r_sam_violation;
             #`MSGDLY
               #`MSGDLY;                 
              vector = vector + 1; 
              
              $display("\n\t vec. %0d. Test to Write to LEFT PORT with Setup/Hold Violations  \n",vector); 
              Addr_l =  `ADDR_MSB_1'h00001; 
              Data_l =  `DATA_MSB_1'h000000001;
              single_write_left;
              Data_l =  `DATA_MSB_1'h111111111;
              single_write_left_violation;                    // write to left port
              d_check_l_reg = `DATA_MSB_1'h111111111;
              read_l;
              #`MSGDLY;
              #`MSGDLY;
           
              vector = vector + 1;
              
              $display("\n\t vec. %0d. Test to Write to RIGHT PORT with Setup/Hold Violations \n",vector); 
              Addr_r =  `ADDR_MSB_1'h00001; 
              Data_r =  `DATA_MSB_1'h000000001; 

              single_write_right;
              Data_r =  `DATA_MSB_1'h222222222;

         
               single_write_right_violation;                   // write to right port  
               d_check_r_reg = `DATA_MSB_1'h222222222;
               read_r;
               #`MSGDLY;
               #`MSGDLY;
        
           
              vector = vector + 1; 
              $display("\n\t vec. %0d. Test to Check for Unknown Violations  \n ",vector); 
 
              x_violate_l;
              x_violate_r;
          end
  
      if (failed_tests > 0)
        begin
           $display("\n--------------------------------------"); 
           $display("No. of TESTS Failed  = %d",failed_tests);         
           $display("--------------------------------------\n"); 
        end
      else
        begin
           $display("\n--------------------------------------"); 
           $display("           ALL Tests Passed             ");
           $display("--------------------------------------\n"); 
        end

        #200 $finish;
        
        end // initial begin


always @(rd_l_r_sam_violation)begin
   read_l_violation;
end
   always @(rd_l_r_sam_violation)begin
      read_r_violation;
   end
   always @(rd_l_r_sam)begin
      #`tCCS
        read_l;
   end
   always @(rd_l_r_sam)begin
      read_r;
   end
   always @(rd_l_r_sam_oe)begin
      read_l_oe;
   end
   always @(rd_l_r_sam_oe)begin
      read_r_oe;
   end
   always @(rd_2_l_r_sam)begin
      read_l_2;
   end
   always @(rd_2_l_r_sam)begin
      read_r_2;
   end
   always @(rd_2_l_r_sam_oe)begin
      read_l_2_oe;
   end
   always @(rd_2_l_r_sam_oe)begin
      read_r_2_oe;
   end
   always @(rd_l_r_sam_oe)begin
      read_l_oe;
   end
   always @(rd_l_r_sam_oe)begin
      read_r_oe;
   end
   always @(rd_l_r_sam_oe)begin
      read_l_oe;
   end
   always @(rd_l_r_sam_oe)begin
      read_r_oe;
   end
   always @(change_time_ad_dt) begin
      if (change_time_ad_dt == `CHECK_ADDR_DATA)begin
         check_addr_lines("ADDR_l",expected_Addr_l,al);
         check_addr_lines("ADDR_r",expected_Addr_r,ar);
         check_data_lines_after_reset("LEFT PORT",expected_data_l,dql);
         check_data_lines_after_reset("RIGHT PORT",expected_data_r,dqr);
      end
   end
   
   always @(change_time) begin
      if (change_time == `CHECK_CNTINT)begin
         check_pin("CNTINT_r",cntint_nr, expected_CNTINT_r);
         check_pin("CNTINT_l",cntint_nl, expected_CNTINT_l);
      end
   end

   always @(expected_CNTINT_l) 
     check_pin("CNTINT_l",cntint_nl, expected_CNTINT_l);

   always @(expected_CNTINT_r) 
     check_pin("CNTINT_r",cntint_nr, expected_CNTINT_r);


   always @(change_time_all) begin
      if (change_time_all == `CHECK_ALL) begin
         check_pin("OE_l     ",oe_nl     ,expected_OE_l   );
         check_pin("RDnWR_l  ",r_w_nl     ,expected_RDnWR_l);
         check_pin("CE0_l    ",ce0_nl    ,expected_CE0_l  );
         check_pin("CE1_l    ",ce1l      ,expected_CE1_l  );
         check_pin("CNTnMSK_l",cnt_msk_nl,expected_CNTnMSK_l);
         check_pin("ADS_l    ",ads_nl      ,expected_ADS_l    );
         check_pin("CNTEN_l  ",cnten_nl  ,expected_CNTEN_l  );
         check_pin("CNTRST_l ",cntrst_nl ,expected_CNTRST_l );
         check_byte_enable("BYTE_ENABLE  ",b_nl     ,expected_b_nl);
         check_pin("OE_r     ",oe_nr     ,expected_OE_r   );
         check_pin("RDnWR_r  ",r_w_nr     ,expected_RDnWR_r);
         check_pin("CE0_r    ",ce0_nr    ,expected_CE0_r  );
         check_pin("CE1_r    ",ce1r      ,expected_CE1_r  );
         check_pin("CNTnMSK_r",cnt_msk_nr,expected_CNTnMSK_r);
         check_pin("ADS_r    ",ads_nr      ,expected_ADS_r    );
         check_pin("CNTEN_r  ",cnten_nr  ,expected_CNTEN_r  );
         check_pin("CNTRST_r ",cntrst_nr ,expected_CNTRST_r );
         check_byte_enable("BYTE_ENABLE  ",b_nr     ,expected_b_nr);
      end
   end
   always begin
      #`tCH2 clkl = ~clkl;
   end
   always @(posedge clkl )begin
      #`tCCS clkr = 1'b1;
   end
   always @(negedge clkl )begin
      # `tCCS clkr = 1'b0;
   end

   //----------------- write collision -----------------------
   always@(collision_event)
     begin
        single_write_left;                    // write from left port
     end
   always@(collision_event)
     begin
        #`tCCS
          single_write_right;                    // write from left port
     end

   always@(collision_event1)
     begin
          `ifdef ZERODELAY        
          #(`tCCS + `tCYC2)
          `else
          #`tCCS
          `endif
          single_write_left;                    // write from left port
     end
   always@(collision_event1)
     begin
        single_write_right;                    // write from left port
     end


   always@(collision_violation_event)
     begin
        single_write_left;                    // write from left port
`ifdef ZERODELAY
`else
        $display ("%t \t MESSAGE EXPECTED : tCCS Violation ",$realtime);
`endif
     end
   always@(collision_violation_event)
     begin
        single_write_right;                    // write from left port
     end
   


   always@(check_port)
     begin
        if(check_port == `COLLISION)
          check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
     end
   always@(check_port)
     begin
        if(check_port == `COLLISION)
          check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
     end
   //--------------Simultaneous write--------------------------------
   always@(both_write_event)
     begin
        single_write_left;                    // write from left port
     end
   always@(both_write_event)
     begin
        #`tCCS 
          single_write_right;                    // write from left port
     end

   //-------------------------- simultaneous rd wr same location--------------
   always@(rd_l_wr_r_same_event)
     begin
        #`tCCS 
          read_l;
     end
   always@(rd_l_wr_r_same_event)
     begin
        single_write_right;
     end
   
   //------------------------- simultaneous wr rd same location---------------
   always@(wr_l_rd_r_same_event)
     begin
        single_write_left;
     end
   always@(wr_l_rd_r_same_event)
     begin
        #`tCCS 
          read_r;
     end
   //-------------------------- simultaneous rd wr different location--------------
   always@(rd_l_wr_r_event)
     begin
        if(TESTCASE == `TEST_ALL)  begin
          #(`tCYC2 + `tCYC2 -`tCCS);
        read_l_signal;
        end
        else
          begin
             @(posedge clkl)
               read_l_signal;
             end
     end
   always@(rd_l_wr_r_event)
     begin
        single_write_right;
     end
   
   always@(rd_l_wr_r_event_1)
     begin
        @(posedge clkl) 
          read_l_signal;
     end
   always@(rd_l_wr_r_event_1)
     begin
        single_write_right;
     end

   //------------------------- simultaneous wr rd different location---------------
   always@(wr_l_rd_r_event)
     begin
        single_write_left;
     end
   always@(wr_l_rd_r_event)
     begin
        #`tCCS 
          read_r;
     end
   always@(rd_r_wr_l_same_event)
     begin

        read_r;
     end
   always@(rd_r_wr_l_same_event)
     begin
        #`tCYC2
          single_write_left;
`ifdef ZERODELAY
`else
        $display ("%t \t MESSAGE EXPECTED : tCCS Violation ",$realtime);
`endif
     end

   //------------------------------------- wr rd at 1FFF consecutive -------------------
  /* always@(wr_l_rd_l_1FFF)
     begin
        single_write_left;
     end
   always@(wr_l_rd_l_1FFF)
     begin
        #`tCYC2 
          read_l;
     end
?*/  /* always@(wr_r_rd_r_1FFF)
     begin
        single_write_right;
     end
   always@(wr_r_rd_r_1FFF)
     begin
        #`tCYC2 
          read_r;
     end
*/   //----------------------------------- simultaneous wr rd at 1FFF --------------
   always@(wr_l_rd_r_1FFF)
     begin
        single_write_left;
     end
   always@(wr_l_rd_r_1FFF)
     begin
        #`tCCS 
          read_r;
     end
   always@(wr_r_rd_l_1FFF)
     begin
        single_write_right;
     end
   always@(wr_r_rd_l_1FFF)
     begin
        `ifdef ZERODELAY
           #`tCYC2
        `else
           #`tCCS 
        `endif
          read_l;
     end


   //------------------------------------------- Simultaneous tasks --------------
   always@(wr_l_event)
     begin
        for(i=0;i<10;i=i+1)
        begin
           single_write_left;
           Addr_l = Addr_l + 1;                         
           Data_l = Data_l + 1;
        end
     end
   always@(rd_r_event)
     begin
        #`tCCS
          Data_r = `DATA_MSB_1'h000000000;
        @(posedge clkr)
          begin
             read_r_signal; 
             ->chk_d_r1;
          end   
        Addr_r = Addr_r + 1;
        for(j=0;j<10;j=j+1)
        begin
           @(posedge clkr)
             begin
                read_r_signal;
                ->chk_d_r2;
             end
           Addr_r = Addr_r + 1;
        end    
     end
   always@(chk_d_r1)
     begin
        @(posedge clkr)
          @(posedge clkr)
            begin
               d_check_r_reg = Data_r;
               data_check_r <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
               data_check_r <= #`tCD2  `DATA_MSB_1'hxxxxxxxxx;                                  
               data_check_r <= #(`tCYC2 )d_check_r;
               Data_r <= #(`tCYC2 -`tSD) Data_r + 1;
               Data_r <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxxxxxx;
            end
     end
   always@(chk_d_r2)
     begin
        @(posedge clkr)
          begin
             d_check_r_reg =  Data_r;
             data_check_r <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
             data_check_r <= #`tCD2 `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_r <= #(`tCYC2 )d_check_r;
             Data_r <= #(`tCYC2 -`tSD) Data_r + 1;
             Data_r <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxxxxxx;
          end
     end
   //----------------------------------------------------------------------Write right read left--------------
   always@(wr_r_event)
     begin
        for(i=0;i<10;i=i+1)
        begin
           single_write_right;
           Addr_r = Addr_r + 1;                         
           Data_r = Data_r + 1;
        end
     end
   always@(rd_l_event)
     begin
        #`tCCS
          @(posedge clkl)
            begin
               read_l_signal; 
               ->chk_d_l1;
               Data_l = `DATA_MSB_1'h000000000;
            end   
        Addr_l = Addr_l + 1;
        for(j=0;j<10;j=j+1)
        begin
           @(posedge clkl)
             begin
                read_l_signal;
                ->chk_d_l2;
             end
           Addr_l = Addr_l + 1;
        end    
     end
   always@(chk_d_l1)
     begin
        @(posedge clkl)
          @(posedge clkl)
            begin
               
               d_check_l_reg = Data_l;
               data_check_l <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
               data_check_l <= #`tCD2  `DATA_MSB_1'hxxxxxxxxx;                                  
               data_check_l <= #(`tCYC2 )d_check_l;
               Data_l <= #(`tCYC2 -`tSD) Data_l + 1;
               Data_l <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxxxxxx;
            end
     end
   always@(chk_d_l2)
     begin
        @(posedge clkl)
          begin
             d_check_l_reg =  Data_l;
             data_check_l <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
             data_check_l <= #`tCD2 `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_l <= #(`tCYC2 )d_check_l;
             Data_l <= #(`tCYC2 -`tSD) Data_l + 1;
             Data_l <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxxxxxx;
          end
     end
endmodule // cy7c0832v_test















