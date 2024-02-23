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
// File         : cy7c0832v_test.v
//
// Author       : Rakesh and Ashish
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : Main Test Bench for first phase.
//
// Notes        : First Release
//
// Modification History:
// Date              By       Version     Change Description
// ==========================================================================
// 03/09/2001     R & A       1.0         First Release
//
//
//
//
//
// ==========================================================================


// variables for selection of the check

//######################## TEST VECTORS ###################################################
//`define ZERODELAY                0
`define MRST_TEST                  1   //Test for master reset *
`define RD_OE_nl_TEST              2   // Read by left port with output enable*
`define RD_OE_nr_TEST              3   // Read by right port with output enable*
`define WR_l_TEST                  4   // Write by Left Port*
`define WR_r_TEST                  5   // Write by right port*
`define RD_l_be_01                 6   // Normal write and Read Back with Byte enable 01 (Left Port)
`define RD_l_be_10 		           7   // Normal write and Read Back with Byte enable 10 (Left Port)
`define RD_l_be_11 			       8   // Normal write and Read Back with Byte enable 11 (Left Port)
`define RD_r_be_01 			       9   // Normal write and Read Back with Byte enable 01 (Right Port)
`define RD_r_be_10			      10   // Normal write and Read Back with Byte enable 10 (Right Port)
`define RD_r_be_11                11   // Normal write and Read Back with Byte enable 11 (Right Port)
`define WR_l_be_01                12   // Write with Byte enable 01 and normal read back (Left Port)
`define WR_l_be_10                13   // Write with Byte enable 10 and normal read back (Left Port)
`define WR_l_be_11                14   // Write with Byte enable 11 and normal read back (Left Port)
`define WR_r_be_01                15   // Write with Byte enable 01 and normal read back (Right Port)
`define WR_r_be_10                16   // Write with Byte enable 01 and normal read back (Right Port)
`define WR_r_be_11                17   // Write with Byte enable 01 and normal read back (Right Port)
`define RD_l_2_TEST               18   // Two consecutive reads by left port*
`define RD_r_2_TEST               19   // Two consecutive reads by right port*
`define WR_l_2_TEST               20   // Two consecutive writes by left port*
`define WR_r_2_TEST               21   // Two consecutive writes by right port*
`define WR_l_RD_l_3FFFF           22   //Highest memory write and read by left port*
`define WR_r_RD_r_3FFFF           23   //Highest memory write and read by right port* 
`define WR_l_RD_r_3FFFF           24   //Highest memory write by left port,read by right port.* 
`define WR_r_RD_l_3FFFF           25   //Highest memory write by right port,read by left port.* 
`define WR_BOTH_TEST              26   // Write by both the ports (Different locations)*
`define WRITE_COLLISION_TEST      27   // Write by both the ports (Same location)*
`define WR_COLLISION_VIOLATION_TEST 28
`define WR_l_RD_r_TEST            29   // Write by left port, read by right port (Different locations)
`define WR_l_RD_r_SAME_TEST       30  // Write by left port,read by right port (Same location) 
`define RD_l_WR_r_TEST            31  // Read by left port,write by right port (Different locations) 
`define RD_l_WR_r_SAME_TEST       32   // Read by left port,write by right port (Same locations) 
`define RD_l_r_sam                33   //Read by both the ports at same location
`define RD_l_r_diff               34   // Read by both the ports at different locations
`define RD_l_TEST_WO_nCE_11       35   // Read left test with no chip enable
`define RD_r_TEST_WO_nCE_11       36   // Read right test with no chip enable
`define RD_l_TEST_WO_nCE_00       37   // Read left test with no chip enable
`define RD_r_TEST_WO_nCE_00       38   // Read right test with no chip enable
`define WR_l_TEST_WO_nCE          39   // Write left test with no chip enable 
`define WR_r_TEST_WO_nCE          40   // Write right test with no chip enable
`define WR_l_10_RD_l_10           41   //write to 10 consecutive (non burst mode ) from left port                                               
`define WR_r_10_RD_r_10           42   //write to 10 consecutive (non burst mode ) from left port
`define WR_l_10_RD_r_10           43   //write/read to 10 consecutive (non burst mode ) from left port
`define WR_r_10_RD_l_10           44
`define WR_RD_WR_l                45   //write to read to write from left port
`define WR_RD_WR_r                46   //write to read to write from right port
`define RD_WR_RD_l                47   //read to write to read left port
`define RD_WR_RD_r                48   //read to write to read left port
`define RD_L_VIOLATION            49   //Timing Violations
`define RD_R_VIOLATION            50
`define RD_l_r_sam_VIOLATION      51
`define RD_l_r_diff_VIOLATION     52
`define WR_l_TEST_violation       53
`define WR_r_TEST_violation       54
`define RD_l_TEST_WO_RST	      55
`define WR_RD_WR_l_oe             56
`define WR_RD_WR_r_oe             57
`define RD_r_WR_l_sam_violation   58
`define WR_r_RD_l_sam_violation   59 
`define MSK_RST_l                 60   //Mask Register reset left port
`define MSK_RST_r                 61   //Mask Register reset right port
`define MSK_LOAD_l                62   //Mask Load and Read Back left Port
`define MSK_LOAD_r                63   //Mask Load and Read Back right Port  
`define EVEN_COUNT_RDBK_l         64   //Even count Burst  Read Back left port
`define ODD_COUNT_RDBK_l          65   //Odd  count Burst  Read Back left port
`define EVEN_COUNT_RDBK_r         66   //Even count Burst  Read Back right port
`define ODD_COUNT_RDBK_r          67   //Odd  count Burst  Read Back right port
`define RETRANSMIT_l              68 
`define RETRANSMIT_r              69 
`define CNTR_RST_l                70   //Mask Register reset left port
`define CNTR_RST_r                71   //Mask Register reset right port
`define CNTR_LOAD_l               72   //Mask Load and Read Back left Port
`define CNTR_LOAD_r               73   //Mask Load and Read Back right Port  
                                 
`define BURST_L_PORT_TEST         74   //Write and Read Back Burst Left Port
`define BURST_R_PORT_TEST         75   //Write and Read Back Burst Right Port
`define CNTHLD_L_PORT_TEST        76   //Counter hold test left port
`define CNTHLD_R_PORT_TEST        77   //Counter hold test Right port
                                 
`define MAIL_BOX_INT_TEST_L2R     78    //Mail Box Interrupt Test Left Port 
`define MAIL_BOX_INT_TEST_R2L     79    //Mail Box Interrupt Test Right Port 
`define X_VIOLATIONS              80
`define TEST_ALL                  81    //Test All the test cases .            

//########################################################################################################
`include "cy7c0832v.v"
`include "cy7c0832v_defines_test.v"
module cy7c0832v_test;
   parameter      TESTCASE = `TEST_ALL;
   event          rd_l_r_sam,rd_l_r_sam_oe,rd_2_l_r_sam,rd_2_l_r_sam_oe,rd_l_r_sam_violation;
   event          collision_event,collision_event1,collision_violation_event,both_write_event;
   event          wr_l_rd_r_event,rd_l_wr_r_event_1,rd_l_wr_r_event,rd_r_wr_l_same_event,
                  wr_r_rd_l_same_event;
   event          wr_l_rd_r_same_event,rd_l_wr_r_same_event;
   event          wr_l_rd_l_1FFF,wr_r_rd_r_1FFF,wr_l_rd_r_1FFF,wr_r_rd_l_1FFF;
   event          wr_l_event,rd_r_event,wr_r_event,rd_l_event,chk_d_r1,chk_d_r2;
   event          chk_d_l1,chk_d_l2, rd_l_r_diff;

   reg [3:0]      vec;
   reg [17:0]     mem_test [1024:0];
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
   reg  [`DATA_MSB :0] dql_int,dqr_int;    
   reg  [`DATA_MSB :0] d_check_l,d_check_r;    
   reg                 oe_nl,  
                       oe_nr;  
   wire                int_nl, 
                       int_nr, 
                       cntint_nl,
                       cntint_nr;
   reg                 r_w_nl,r_w_nr;  
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
   assign              al  =  (ads_nl === 1'b0) ? al_int  : `ADDR_MSB_1'bz;
   assign              ar  =  (ads_nr === 1'b0) ? ar_int  : `ADDR_MSB_1'bz;
   assign              dql =  (r_w_nl === 1'b0) ? dql_int : `DATA_MSB_1'bz ;
   assign              dqr =  (r_w_nr === 1'b0) ? dqr_int : `DATA_MSB_1'bz;

`include "cy7c0832v_tasks_test.v"

   cy7c0832v model(
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
        vector       = 1;
        moveon       = 1'b0;
     end

   initial
     begin 
        $dumpvars();
        $dumpfile("cy7c0832v.vcd");
        clkl = 1'b0;
        clkr = 1'b0;     
        $readmemh("dpram_array.txt",mem_test);  
        if(TESTCASE == `TEST_ALL)
          begin
             init_and_reset;
             vector = vector + 1; 
             $display("\n----------- NON BURST WRITE WITH READ TRANSACTIONS  ------------");           
             $display("\n\t vec. %0d. LEFT PORT -  Test to Write and Read back \n ",vector); 
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00017;
             single_write_left1;                    // write from left port
             d_check_l = Data_l;
             read_l;
             #`MSGDLY
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Write and Read back \n",vector); 
             Addr_r =  `ADDR_MSB_1'h0fabe;
             Data_r =  `DATA_MSB_1'h00017;
             single_write_right1;                   // write from right port  
             d_check_r = Data_r;
             read_r;
             #`MSGDLY
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read from RIGHT PORT at different locations \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00001; 
             Data_r =  `DATA_MSB_1'h00017;
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00017;
             d_check_r = `DATA_MSB_1'h00001; 
             ->wr_l_rd_r_same_event;
             #`MSGDLY
               #`MSGDLY

              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read from RIGHT PORT at same location \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00067; 
             Data_r =  `DATA_MSB_1'h00015;
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00017;
             d_check_r = `DATA_MSB_1'h00017;
             ->wr_l_rd_r_same_event;
             #`MSGDLY
             #`MSGDLY
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at different locations \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00f10; 
             Data_r =  `DATA_MSB_1'h00015;
             Addr_l =  `ADDR_MSB_1'h00001; 
             Data_l =  `DATA_MSB_1'h00010;
             d_check_l = `DATA_MSB_1'h00001;
             ->rd_l_wr_r_same_event;
             #`MSGDLY
             #`MSGDLY
             #`tCCS
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at same location \n",vector); 
             Addr_r =  `ADDR_MSB_1'h000f1; 
             Data_r =  `DATA_MSB_1'h00010;
             Addr_l =  `ADDR_MSB_1'h000f1; 
             Data_l =  `DATA_MSB_1'h00010;
             single_write_right;
             d_check_l = Data_r;
             #`tCCS
             read_l;
             #`MSGDLY
             #`MSGDLY
             #`MSGDLY
               
               //-------------------------------------------------------
             vector = vector + 1;             //42
             $display("\n\t vec. %0d. LEFT PORT - Test to Write - Read - Write \n ",vector);
             WR_RD_WR_l_TASK;
             for(i=0; i<2; i=i+1)
             begin           
                #`MSGDLY
                  #`MSGDLY ;          
             end
             vector = vector + 1;             //43
             $display("\n\t vec. %0d. RIGHT PORT - Test to Write - Read - Write \n",vector);
             d_check_l =`DATA_MSB_1'hz; 
             WR_RD_WR_r_TASK;
             for(i=0; i<2; i=i+1)
             begin           
                #`MSGDLY
                  #`MSGDLY ;          
             end
             d_check_l = `DATA_MSB_1'h0f001;
             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT  - Test to Read - Write - Read  \n",vector);
             RD_WR_RD_l_TASK;
             for(i=0; i<2; i=i+1)
             begin           
                #`MSGDLY
                  #`MSGDLY ;          
             end             
             d_check_r = `DATA_MSB_1'h1ffbc;
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Read - Write - Read  \n",vector);
             RD_WR_RD_r_TASK;
             #`MSGDLY
             #`MSGDLY
               //-------------------------------------------------------------

             vector = vector + 1;

             $display("\n\t --------------  OUTPUT ENABLE TESTS ---------------\n");                     
             $display("\n\t vec. %0d. LEFT PORT -  Test to Write and Read back with OE CONTROLLED\n",vector);  
             
             Addr_l =  `ADDR_MSB_1'h05f01; 
             Data_l =`DATA_MSB_1'h00552;
             single_write_left;

             d_check_l = Data_l;  
             read_l_oe1;                            // read left with OE    
              #`MSGDLY
                #`MSGDLY             
                  vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Write and Read back with OE CONTROLLED\n",vector); 
             Addr_r =  `ADDR_MSB_1'h06f01; 
             Data_r =`DATA_MSB_1'h07552;
             single_write_right;
             d_check_r = Data_r;  
             read_r_oe1;                            // read left with OE    
             #`MSGDLY
              #`MSGDLY

              vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT -  Test to Write - Read - Write with OE CONTROLLED\n",vector); 
             Addr_l =  `ADDR_MSB_1'h16f01; 
             Data_l =`DATA_MSB_1'h17552;
             single_write_left;
             d_check_l = Data_l;  
             Data_l = `DATA_MSB_1'h1fff2; 
             read_l_oe2;                            // read left with OE    
             d_check_l = Data_l;  
             read_l;  
             #`MSGDLY
             #`MSGDLY


             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Write - Read - Write with  OE CONTROLLED\n",vector); 
             Addr_r =  `ADDR_MSB_1'h06f01; 
             Data_r =  `DATA_MSB_1'h07552;
             single_write_right;
             d_check_r = Data_r;  
             Data_r = `DATA_MSB_1'h0fff2; 
             read_r_oe2;                            // read left with OE    
             d_check_r = Data_r;  
             read_r; 
             #`MSGDLY
             #`MSGDLY
              vector = vector + 1; 

             $display("\n---------------------- BYTE ENABLE TESTS--------------------------\n");
             $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 01\n   ",vector); 
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00000;
             single_write_left;      
             Data_l =  `DATA_MSB_1'h15555; 
             writel_byte_enable_01;
             d_check_l =`DATA_MSB_1'h15400;
             read_l;
             #`MSGDLY
               #`MSGDLY
              vector = vector + 1;             //12
             $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 10 \n  ",vector); 
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00000;
             single_write_left;      
             Data_l =  `DATA_MSB_1'h15555; 
             writel_byte_enable_10 ;
             d_check_l =`DATA_MSB_1'h00155;
             read_l;
             #`MSGDLY
               #`MSGDLY
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 11 \n  ",vector); 
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00000;
             single_write_left;      
             Data_l =  `DATA_MSB_1'h15555; 
             writel_byte_enable_11 ;
             d_check_l =`DATA_MSB_1'h00000;
             read_l;
             #`MSGDLY
               #`MSGDLY
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT with byte enable = 01 \n  ",vector); 
             Addr_r =  `ADDR_MSB_1'h00068; 
             Data_r =  `DATA_MSB_1'h00000;
             single_write_right;
             Data_r =  `DATA_MSB_1'h15555; 
             writer_byte_enable_01 ;
             d_check_r = `DATA_MSB_1'h15400;
             read_r ;      
             #`MSGDLY
               #`MSGDLY            
                 #`MSGDLY
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT with byte enable = 10  \n ",vector); 
             Addr_r =  `ADDR_MSB_1'h00068; 
             Data_r =  `DATA_MSB_1'h00000;
             single_write_right;
             Data_r =  `DATA_MSB_1'h15555; 
             writer_byte_enable_10 ;
             d_check_r = `DATA_MSB_1'h00155;
             read_r ;      
             #`MSGDLY
               #`MSGDLY            
                 #`MSGDLY
               vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT with byte enable = 11  \n ",vector); 
             Addr_r =  `ADDR_MSB_1'h00068; 
             Data_r =  `DATA_MSB_1'h00000;
             single_write_right;
             Data_r =  `DATA_MSB_1'h15555; 
             writer_byte_enable_11 ;
             d_check_r = `DATA_MSB_1'h00000;
             read_r ;      
             #`MSGDLY
               #`MSGDLY
              vector = vector + 1;             
             $display("\n\t vec. %0d. Test to Read from LEFT PORT with byte enable = 01 \n  ",vector); 
             Addr_l =  `ADDR_MSB_1'h00101; 
             Data_l = `DATA_MSB_1'h17878;
             single_write_left1;
             d_check_l = `DATA_MSB_1'h17800;
             readl_byte_enable_01 ;
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from LEFT PORT with byte enable = 10  \n ",vector); 
             Addr_l =  `ADDR_MSB_1'h00111; 
             Data_l = `DATA_MSB_1'h17878;
             single_write_left1;
             d_check_l = `DATA_MSB_1'h00078;
             readl_byte_enable_10 ;
             vector = vector + 1; 
             $display("\n\t vec. %0d.Test to Read from LEFT PORT with byte enable = 11 \n  ",vector); 
             Addr_l =  `ADDR_MSB_1'h00100; 
             Data_l = `DATA_MSB_1'h17878;
             single_write_left1;
             d_check_l = `DATA_MSB_1'hzzzzz;
             readl_byte_enable_11 ;
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT with byte enable = 01 \n  ",vector); 
             Addr_r =  `ADDR_MSB_1'h01101; 
             Data_r = `DATA_MSB_1'h17878;
             single_write_right1;
             d_check_r = `DATA_MSB_1'h17800;
             readr_byte_enable_01 ;
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT with byte enable = 10   \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00110; 
             Data_r = `DATA_MSB_1'h17878;
             single_write_right1;
             d_check_r = `DATA_MSB_1'h00078;
             readr_byte_enable_10 ;
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT with byte enable = 11   \n",vector); 
             Addr_r =  `ADDR_MSB_1'h01021; 
             Data_r = `DATA_MSB_1'h17878;
             single_write_right1;
             d_check_r = `DATA_MSB_1'hzzzzz;
             readr_byte_enable_11 ;
             #`MSGDLY
             vector = vector + 1;  
             $display("\n------------------- CHIP ENABLE TESTS -----------------------\n ");
             $display("\n\t vec. %0d. Test to Read from LEFT PORT with /CE0 = 1 , CE1 = 1\n",vector);
             Addr_l =  `ADDR_MSB_1'h00065; 
             Data_l =  `DATA_MSB_1'h00015;
             rd_l_wo_nce;
             #`MSGDLY
             #`MSGDLY
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT with /CE0 = 1 , CE1 = 1\n",vector);
             Addr_r =  `ADDR_MSB_1'h00067; 
             Data_r =  `DATA_MSB_1'h00017;
             rd_r_wo_nce;
             #`MSGDLY
             #`MSGDLY
              vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from LEFT PORT With /CE0 = 0 , CE1 = 0\n",vector);

             Addr_l =  `ADDR_MSB_1'h00065; 
             Data_l =  `DATA_MSB_1'h00015;
             rd_l_wo_nce1;
             #`MSGDLY
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT with /CE0 = 0 , CE1 = 0\n",vector);
             Addr_r =  `ADDR_MSB_1'h00067; 
             Data_r =  `DATA_MSB_1'h00017;
             rd_r_wo_nce1;
             #`MSGDLY
             #`MSGDLY         
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT without Chip Enable \n",vector);
             $display("\n\t\t Writing to LEFT PORT with Chip Enabled ( /CE0 = 0 , CE1 = 1 )\n");
             Addr_l =  `ADDR_MSB_1'h00065; 
             Data_l =  `DATA_MSB_1'h00015;
             single_write_left1;
             $display("\n\t\t Writing to LEFT PORT without Chip Enabled ( /CE0 = 1 , CE1 = 1 )\n"); 
             Data_l =  `DATA_MSB_1'h0b015;
             wr_l_wo_nce;     
             d_check_l = `DATA_MSB_1'h00015;
             read_l;
             #`MSGDLY
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT without Chip Enable \n",vector);
             $display("\n\t\t Writing to RIGHT PORT with Chip Enabled ( /CE0 = 0 , CE1 = 1 )\n");
             Addr_r =  `ADDR_MSB_1'h00065; 
             Data_r =  `DATA_MSB_1'h00015;
             single_write_right1;
             $display("\n\t\t Writing to RIGHT PORT without Chip Enabled ( /CE0 = 1 , CE1 = 1 )\n"); 
             Data_r =  `DATA_MSB_1'h07715;
             wr_r_wo_nce;     
             d_check_r = `DATA_MSB_1'h00015;   
             read_r;
             #`MSGDLY
             #`MSGDLY


               //-----------------------------------------------------------------------

             vector = vector + 1; 
             $display("\n\t ------------ CONSECUTIVE READ/WRITE TEST ---------------\n"); 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from  LEFT PORT 10 DATAs consecutively \n ",vector);
             Addr_l = `ADDR_MSB_1'h00000;
             Data_l = `DATA_MSB_1'h00000;
             for(i=0; i<10; i=i+1)
             begin
                single_write_left;
                d_check_l = Data_l;
                read_l;
                #`tCYC2
                Addr_l = Addr_l + 1;                         
                Data_l = Data_l + 1;
             end
             #`MSGDLY
               #`MSGDLY
                 #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from RIGHT PORT 10 DATAs consecutively\n",vector);
             Addr_r = `ADDR_MSB_1'h00000;
             Data_r = `DATA_MSB_1'h00000;
             for(i=0; i<10; i=i+1)
             begin
                single_write_right;
                d_check_r = Data_r;
                read_r;
                #`tCYC2;
                Addr_r = Addr_r + 1;                         
                Data_r = Data_r + 1;
             end
             #`MSGDLY
               #`MSGDLY
                     
            //------------------------------------------------------------------
             vector = vector + 1;  
             $display("\n-------------------- WRITE/READ AT HIGHEST MEMORY LOCATION--------------------\n");
             #`tCCS 

               $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from RIGHT PORT at the Highest Memory Location 3FFFF \n",vector); 
             Addr_r =  `ADDR_MSB_1'h3FFFF; 
             Data_r =  `DATA_MSB_1'hzzzzz;
             Addr_l =  `ADDR_MSB_1'h3FFFF; 
             Data_l =  `DATA_MSB_1'h00017;
             d_check_r = `DATA_MSB_1'h00017;
             ->wr_l_rd_r_1FFF;
             for(i=0; i<5; i=i+1)
             begin           
                #`MSGDLY
                  #`MSGDLY ;          
             end
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from LEFT PORT at the Highest Memory Location 3FFFF \n ",vector); 
             Addr_r =  `ADDR_MSB_1'h3FFFF; 
             Data_r =  `DATA_MSB_1'h00017;
             Addr_l =  `ADDR_MSB_1'h3FFFF; 
             Data_l =  `DATA_MSB_1'hzzzzz;
             d_check_l = `DATA_MSB_1'h00017;
             ->wr_r_rd_l_1FFF;
             for(i=0; i<2; i=i+1)
             begin           
                #`MSGDLY
                  #`MSGDLY ;          
             end
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from LEFT PORT at the Highest Memory Location 3FFFF \n ",vector); 
             Addr_l =  `ADDR_MSB_1'h3FFFF; 
             Data_l =  `DATA_MSB_1'h00017;
             d_check_l = `DATA_MSB_1'h00017;
             ->wr_l_rd_l_1FFF; 
             #`MSGDLY
               #`MSGDLY
                 #`MSGDLY
             vector = vector + 1;             
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from RIGHT PORT at the Highest Memory Location 3FFFF \n",vector); 
             Addr_r =  `ADDR_MSB_1'h3FFFF; 
             Data_r =  `DATA_MSB_1'h00017; 
             d_check_r = `DATA_MSB_1'h00017;              
             ->wr_r_rd_r_1FFF;
             #`MSGDLY
               #`MSGDLY
               #`MSGDLY                 
             vector = vector + 1;             
             $display("\n\t vec. %0d. Test to Read from both the ports at different location \n",vector); 
             Addr_r = `ADDR_MSB_1'h00001;
             Addr_l = `ADDR_MSB_1'h00002;
             d_check_r = `DATA_MSB_1'h00001;
             d_check_l = `DATA_MSB_1'h00002;
             ->rd_l_r_sam;
             #`MSGDLY
               #`MSGDLY
                 #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read 2 Datas from both the ports at same location  \n",vector); 
             Addr_r = `ADDR_MSB_1'h00001;
             Addr_l = `ADDR_MSB_1'h00001;
             d_check_l = `DATA_MSB_1'h00001;
             d_check_r = `DATA_MSB_1'h00001;
             ->rd_2_l_r_sam;
             #`MSGDLY
               #`MSGDLY
                 #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read 2 Datas from both the ports at different location \n",vector); 
             Addr_r = `ADDR_MSB_1'h00001;
             Addr_l = `ADDR_MSB_1'h00002;
             d_check_l = `DATA_MSB_1'h00002;
             d_check_r = `DATA_MSB_1'h00001;
             ->rd_2_l_r_sam;
             #`MSGDLY
               #`MSGDLY
                 #`MSGDLY
                   #`MSGDLY
               vector = vector + 1;
             $display("\n\t vec. %0d. Test to Write to both the ports at same location without Violating tCCS \n",vector); 
             $display("\t\t Writing to LEFT PORT First \n");
             Addr_r =  `ADDR_MSB_1'h00f67; 
             Data_r =  `DATA_MSB_1'h00017;
             Addr_l =  `ADDR_MSB_1'h00f67; 
             Data_l =  `DATA_MSB_1'h15555;
             ->collision_event;
             #`MSGDLY
             #`MSGDLY
               `ifdef ZERODELAY
             d_check_r = Data_r;
               `else
             d_check_r = Data_r;
             `endif
             read_r;
             vector = vector + 1; 
             #`MSGDLY
             #`MSGDLY 
             #`tCCS
               $display("\n\t vec. %0d. Test to Write to both the ports at same location without Violating tCCS \n",vector); 
             $display("\t\t Writing to RIGHT PORT First \n");
             Addr_r =  `ADDR_MSB_1'h00067; 
             Data_r =  `DATA_MSB_1'h00017;
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h15555;
             ->collision_event1;
             #`MSGDLY
             #`MSGDLY
               `ifdef ZERODELAY
             d_check_r = Data_r;
               `else
             d_check_r = Data_l;
             `endif
             read_r;
             #`MSGDLY
             #`MSGDLY 
              vector = vector + 1;             
             $display("\n\t vec. %0d. Test to Write and Read back from both the ports at different location \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00065; 
             Data_r =  `DATA_MSB_1'h00015;
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h00017;
             ->both_write_event;
             #`MSGDLY
             #`MSGDLY
             #`MSGDLY
             d_check_r = Data_r;
             read_r;
              
             d_check_l = Data_l;
             read_l;
             #`MSGDLY
             #`MSGDLY           

           
             //-------------------------------------------------------------------

               
             $display("\n ---------- SIMULTANEOUS READ/WRITE WITH tCCS violation------------------\n");
             vector = vector + 1;              
             $display("\n\t vec. %0d. Test to Write to both the ports at same location Violating tCCS \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00067; 
             Data_r =  `DATA_MSB_1'h00000;
             single_write_right1;                   // write to right port  
             #`MSGDLY
             #`tCCS
             Addr_r =  `ADDR_MSB_1'h00067; 
             Data_r =  `DATA_MSB_1'h00017;
             Addr_l =  `ADDR_MSB_1'h00067; 
             Data_l =  `DATA_MSB_1'h15555;
             ->collision_violation_event;

             #`MSGDLY
               $display("\n\t\t Read back from the same location after collision\n "); 
             Addr_l =  `ADDR_MSB_1'h00067;
             d_check_l = `DATA_MSB_1'h00017;
             read_l;                               // read left without OE
             #`MSGDLY
             #`MSGDLY
             #`MSGDLY
             #`tCCS
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT and write to LEFT PORT at same location violating tCCS\n",vector); 
             
             Addr_r =  `ADDR_MSB_1'h0a058; 
             Data_r =  `DATA_MSB_1'h05515;
             single_write_right;
             #`MSGDLY
             Addr_l =  `ADDR_MSB_1'h0a058; 
             Data_l =  `DATA_MSB_1'h0aa17;
             d_check_r = `DATA_MSB_1'h05515;
             ->rd_r_wr_l_same_event;
             #`MSGDLY
             #`MSGDLY
             d_check_r = `DATA_MSB_1'h0aa17;
             read_r;
             #`MSGDLY
             #`MSGDLY
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at same location violating tCCS\n",vector); 
             Addr_r =  `ADDR_MSB_1'h0a5f1; 
             Data_r =  `DATA_MSB_1'h00011;
             Addr_l =  `ADDR_MSB_1'h0a5f1; 
             Data_l =  `DATA_MSB_1'h00010;
//             single_write_right;
             d_check_l = Data_r;  
             
             ->rd_l_wr_r_event;
             #`MSGDLY
             #`MSGDLY
             d_check_l = Data_r;  
             read_l;              
             #`MSGDLY
             #`MSGDLY
               
             vector = vector + 1;   
             $display("\n\t vec. %0d. Test to Read from both the ports at same location Violating tCCS \n",vector); 
             Addr_r = `ADDR_MSB_1'h00cc1;
             Addr_l = `ADDR_MSB_1'h00cc1;
             Data_l = `DATA_MSB_1'h0fdc1;   
             single_write_left;
             #`MSGDLY  
             d_check_l = `DATA_MSB_1'h0fdc1;  // as changed in simultaneous 
             d_check_r = `DATA_MSB_1'h0fdc1;
             ->rd_l_r_sam;
             #`MSGDLY
               #`MSGDLY
                 #`MSGDLY


             $display("\n ------------ SPECIAL FEATURE OPERATIONS ---------- \n ");              
             vector = vector + 1; 
             $display("\n ------------ MASK REGISTER OPERATIONS ---------- \n ");              
             $display("\n\t vec. %0d. LEFT PORT - Test to Mask Reset and Mask Read Back Operations\n",vector); 
             Addr_l = `ADDR_MSB_1'h0007f;
             load_mask_l;
             Addr_l = `ADDR_MSB_1'h3ffff;
             mask_reset_l;
             read_mask_l;         
             #`MSGDLY;         
             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT - Test to Mask Load and Mask Read Back Operations\n",vector); 
             Addr_l = `ADDR_MSB_1'h3ffff;
             mask_reset_l;
             read_mask_l;                  
             Addr_l = `ADDR_MSB_1'h0007f;
             load_mask_l;
             Addr_l = `ADDR_MSB_1'h0007f;
             read_mask_l;  
             Addr_l = `ADDR_MSB_1'h000ff;
             load_mask_l;                                       
             $display("\n\t\t Invalid loading of LEFT PORT Mask Register \n");              
             Addr_l = `ADDR_MSB_1'hx003f;
             load_mask_l;
             Addr_l = `ADDR_MSB_1'h000ff;
             $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);
             read_mask_l;                  
             #`MSGDLY;
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Mask Reset and Mask Read Back Operations \n ",vector); 
             Addr_r = `ADDR_MSB_1'h0007f;
             load_mask_r;
             Addr_r = `ADDR_MSB_1'h3ffff;
             mask_reset_r;
             read_mask_r;                  
             #`MSGDLY;
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Mask Load and Mask Read Back Operations \n ",vector);          
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
             Addr_r = `ADDR_MSB_1'hx003f;
             load_mask_r;
             Addr_r = `ADDR_MSB_1'h000ff;
             $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);
             read_mask_r;                  
             #`MSGDLY;
             $display("\n ------------ COUNTER REGISTER OPERATIONS ---------- \n ");         
             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT - Test to Counter Reset and Counter Read Back Operations \n ",vector);              
             Addr_l = `ADDR_MSB_1'h0007f;
             load_mask_l;                   
             Addr_l = `ADDR_MSB_1'h3983f;
             load_cntr_l;
             read_cntr_l;                  
             Addr_l = `ADDR_MSB_1'h39800;
             cntr_reset_l;
             read_cntr_l;                  
             #`MSGDLY;                

             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT - Test to Counter Reset, Counter Load and Counter Read Back Operations \n ",vector);              
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
             $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);
             read_cntr_l;                  
             #`MSGDLY;              
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Counter Reset and Counter Read Back Operations \n ",vector);                         
             Addr_r = `ADDR_MSB_1'h0007f;
             load_mask_r;                   
             Addr_r = `ADDR_MSB_1'h3ff3f;
             load_cntr_r;
             read_cntr_r;                  
             Addr_r = `ADDR_MSB_1'h3ff00;
             cntr_reset_r;
             read_cntr_r;                             
             #`MSGDLY;              
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Counter Reset, Counter Load and Counter Read Back Operations \n ",vector);
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
                          $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);
             read_cntr_r;           
             #`MSGDLY;                     

             vector = vector + 1; 
             $display("\n \t vec. %0d. Test to Burst Write and Read Back Operations \n ", vector);              
             // burst write left port
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             wr_burst_l_port_c;
             // burst read left port             
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             rd_burst_l_port_c;
             #`MSGDLY             
             #`MSGDLY
             // burst write right port
             Addr_r =  `ADDR_MSB_1'h2cd1a;
             Data_r =  `DATA_MSB_1'h5a012;
             wr_burst_r_port_c;
             // burst read right port
             Addr_r =  `ADDR_MSB_1'h2cd1a;
             Data_r =  `DATA_MSB_1'h5a012;
             rd_burst_r_port_c;
             #`MSGDLY             
             #`MSGDLY

              vector = vector + 1; 
             $display("\n \t vec. %0d. Test to Write and Read back Operations with Counter Hold \n ",vector); 
             // single write with cnt hold left port 

             Addr_l =  `ADDR_MSB_1'h00012;
             Data_l =  `DATA_MSB_1'h0bcdf;
             wr_cnthld_l_port_c;
             nop_l;
             // single read with cnt hold left port 
             Addr_l =  `ADDR_MSB_1'h00012;
             Data_l =  `DATA_MSB_1'h0bcdf;
             rd_cnthld_l_port_c;
             nop_l;
             nop_l;
             nop_l;             
             // single write with cnt hold right port 
             Addr_r =  `ADDR_MSB_1'h00005;
             Data_r =  `DATA_MSB_1'h0ce12;
             wr_cnthld_r_port_c;
             nop_r;
             // single read with cnt hold right port 
             Addr_r =  `ADDR_MSB_1'h00005;
             Data_r =  `DATA_MSB_1'h0ce12;
             rd_cnthld_r_port_c;
             nop_r;
             nop_r;
             nop_r;             

             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT  - Test to Write and Read operations with Even Address \n ",vector);                  

             Addr_l = `ADDR_MSB_1'h3ffff;
             mask_reset_l;
             read_mask_l; 
             Addr_l = `ADDR_MSB_1'h3fffe;
             load_mask_l;
             read_mask_l;                  
             #`MSGDLY             
             #`MSGDLY
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             wr_burst_l_port_c_count_2;
             nop_l;
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             rd_burst_l_port_c_count_2;                
             nop_l;
             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT  - Test to Write and Read operations with Odd Address \n ",vector);                  

             Addr_l = `ADDR_MSB_1'h3ffff;
             mask_reset_l;
             read_mask_l; 
             Addr_l = `ADDR_MSB_1'h3fffe;
             load_mask_l;
             read_mask_l;                  
             #`MSGDLY             
             #`MSGDLY
             Addr_l =  `ADDR_MSB_1'h35001;
             Data_l =  `DATA_MSB_1'h2ff77;
             wr_burst_l_port_c_count_2;
             nop_l;
             Addr_l =  `ADDR_MSB_1'h35001;
             Data_l =  `DATA_MSB_1'h2ff77;
             rd_burst_l_port_c_count_2;                               
             nop_l;
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT  - Test to Write and Read operations with Even Address \n ",vector);

             Addr_r = `ADDR_MSB_1'h3ffff;
             mask_reset_r;
             read_mask_r; 
             Addr_r = `ADDR_MSB_1'h3fffe;
             load_mask_r;
             read_mask_r;                  
             #`MSGDLY             
             #`MSGDLY
             Addr_r =  `ADDR_MSB_1'h05500;
             Data_r =  `DATA_MSB_1'h25523;
             wr_burst_r_port_c_count_2;
             nop_r;
             Addr_r =  `ADDR_MSB_1'h05500;
             Data_r =  `DATA_MSB_1'h25523;
             rd_burst_r_port_c_count_2;     
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT  - Test to Write and Read operations with Odd Address \n ",vector);
             Addr_r = `ADDR_MSB_1'h3ffff;
             mask_reset_r;
             read_mask_r; 
             Addr_r = `ADDR_MSB_1'h3fffe;
             load_mask_r;
             read_mask_r;                  
             #`MSGDLY             
             #`MSGDLY
             Addr_r =  `ADDR_MSB_1'h05501;
             Data_r =  `DATA_MSB_1'h25523;
             wr_burst_r_port_c_count_2;
             nop_r;
             Addr_r =  `ADDR_MSB_1'h05501;
             Data_r =  `DATA_MSB_1'h25523;
             rd_burst_r_port_c_count_2;                                     
             nop_r;
             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT - Test to Retransmit Operation  \n ",vector);                  

             Addr_l = `ADDR_MSB_1'h0000f;
             load_mask_l;
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             wr_burst_l_port_c_retransmit;
             nop_l;
             Addr_l =  `ADDR_MSB_1'h30000;
             read_cntr_l;                  
             nop_l;                  
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             rd_burst_l_port_c_retransmit;
             nop_l;                
             nop_l; 
             Addr_l =  `ADDR_MSB_1'h30000;
             Data_l =  `DATA_MSB_1'h2ff00;
             rd_burst_l_port_c_retransmit;
             nop_l;                
             nop_l; 
             Addr_l =  `ADDR_MSB_1'h30000;
             read_cntr_l;                  
             nop_l;                  
             vector = vector + 1; 
             $display("\n\t vec. %0d. RIGHT PORT - Test to Retransmit Operation  \n ",vector);
             
             Addr_r = `ADDR_MSB_1'h0000f;
             load_mask_r;
             Addr_r =  `ADDR_MSB_1'h3f000;
             Data_r =  `DATA_MSB_1'h3ff55;
             wr_burst_r_port_c_retransmit;
             nop_r;
             Addr_r =  `ADDR_MSB_1'h3f000;
             read_cntr_r;                  
             nop_r;
             Addr_r =  `ADDR_MSB_1'h3f000;
             Data_r =  `DATA_MSB_1'h3ff55;
             rd_burst_r_port_c_retransmit;                
             nop_r;                
             nop_r; 
             Addr_r =  `ADDR_MSB_1'h3f000;
             Data_r =  `DATA_MSB_1'h3ff55;
             rd_burst_r_port_c_retransmit;                
             Addr_r =  `ADDR_MSB_1'h3f000;
             nop_r;                
             nop_r; 
             read_cntr_r;                  
             nop_r;
             vector = vector + 1;                      
             $display("\n\t vec. %0d. RIGHT PORT - Test to MAILBOX Operations \n ",vector); 

             Addr_r = ~0;
             Data_r =  `DATA_MSB_1'h2ff00;
             Data_l =  `DATA_MSB_1'h2ff00;
             mailbox_int_chk_l2r;

             vector = vector + 1; 
             $display("\n\t vec. %0d. LEFT PORT - Test to MAILBOX Operations \n ",vector); 
             Addr_l = ~0 - 1;
             Data_r =  `DATA_MSB_1'h2ff00;
             Data_l =  `DATA_MSB_1'h2ff00;
             mailbox_int_chk_r2l;

             $display("\n ------------------ TIMING VIOLATION TESTS----------------*\n");
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from LEFT PORT With Setup/Hold Violations \n",vector); 
             Addr_l =  `ADDR_MSB_1'h00001; 
             Data_l = `DATA_MSB_1'h00001;
             single_write_left;
             d_check_l = Data_l; 
             read_l_violation;                              // read left without OE
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from RIGHT PORT with Setup/Hold Violations \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00020; 
             Data_r = `DATA_MSB_1'h00020;
             single_write_right;
             d_check_r = Data_r; 

             read_r_violation;                               // read left without OE
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Read from both the ports with Setup/Hold Violations  \n",vector); 
             Addr_l =  `ADDR_MSB_1'h00001;
             Addr_r =  `ADDR_MSB_1'h00001;
             d_check_l = `DATA_MSB_1'h00001;
             d_check_r = `DATA_MSB_1'h00001;
             -> rd_l_r_sam_violation;
             #`MSGDLY
             Addr_l =  `ADDR_MSB_1'h00001;
             Addr_r =  `ADDR_MSB_1'h00001; 
             d_check_l = `DATA_MSB_1'h00001;
             d_check_r = `DATA_MSB_1'h00001;
             -> rd_l_r_sam_violation;
             #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to LEFT PORT with Setup/Hold Violations  \n",vector); 
             Addr_l =  `ADDR_MSB_1'h00001; 
             Data_l =  `DATA_MSB_1'h00001; 
             single_write_left_violation;                    // write to left port
             d_check_l = `DATA_MSB_1'h00001;
             read_l;
             #`MSGDLY
               #`MSGDLY
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Write to RIGHT PORT with Setup/Hold Violations \n",vector); 
             Addr_r =  `ADDR_MSB_1'h00001; 
             Data_r =  `DATA_MSB_1'h00001;
             single_write_right_violation;                   // write to right port  
             d_check_r = `DATA_MSB_1'h00001;
             read_r;
             #`MSGDLY;
             #`MSGDLY;             
             vector = vector + 1; 
             $display("\n\t vec. %0d. Test to Check for Unknown Violations ---------- \n ",vector); 

             x_violate_l;
             x_violate_r;
                 if(failed_tests > 0)
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
          end                                   // at the same time
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

        // INDIVIDUAL OPERATION TESTING        
        else
          begin         
             if(TESTCASE == `MRST_TEST)
               begin
                  $display("\n\t vec. %0d. Master Reset Test  ",vector); 
                  init_and_reset;
               end
             else if (TESTCASE == `RD_l_TEST_WO_RST)
               begin
                  $display("\n\t vec. %0d. Test to Read from left port without Reset  \n",vector); 
                  Addr_l =  `ADDR_MSB_1'h00001; 
                  mrst_n = 1'b1;
                  d_check_l = `DATA_MSB_1'h00000;
                  read_l_wo_rst;                               // read left without OE
               end
	        else 
               begin
                  init_and_reset;
                  vector = vector + 1;
                  #`MSGDLY;
                  #`MSGDLY;
               end
             if (TESTCASE == `RD_OE_nl_TEST)
               begin
                  $display("\n\t vec. %0d. LEFT PORT -  Test to Write and Read back with OE CONTROLLED\n",vector);                                      
	              Addr_l =  `ADDR_MSB_1'h05f01; 
 	 	          Data_l =`DATA_MSB_1'h00552;
  	  	     	  single_write_left;
      		  	  d_check_l = Data_l;  
        	      read_l_oe1;                            // read left with OE    
               end
             else if(TESTCASE ==  `RD_OE_nr_TEST)
               begin
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Write and Read back with OE CONTROLLED\n",vector); 
                  Addr_r =  `ADDR_MSB_1'h06f01; 
                  Data_r =`DATA_MSB_1'h07552;
                  single_write_right;
                  d_check_r = Data_r;  
                  read_r_oe1;                            // read left with OE 
               end
             else if(TESTCASE ==  `WR_RD_WR_l_oe)
               begin
                  $display("\n\t vec. %0d. LEFT PORT -  Test to Write - Read - Write with OE CONTROLLED\n",vector); 
                  Addr_l =  `ADDR_MSB_1'h16f01; 
                  Data_l =`DATA_MSB_1'h17552;
                  single_write_left;
                  d_check_l = Data_l;  
                  Data_l = `DATA_MSB_1'h1fff2; 
                  read_l_oe2;                               
                  d_check_l = Data_l;  
                  read_l;  
               end    
             else if(TESTCASE ==  `WR_RD_WR_r_oe)
               begin
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Write - Read - Write with  OE CONTROLLED\n",vector); 
                  Addr_r =  `ADDR_MSB_1'h06f01; 
                  Data_r =  `DATA_MSB_1'h07552;
                  single_write_right;
                  d_check_r = Data_r;  
                  Data_r = `DATA_MSB_1'h0fff2; 
                  read_r_oe2;      
                  d_check_r = Data_r;  
                  read_r; 
               end    
             
             else if(TESTCASE ==  `WR_l_TEST )   
               begin
                  $display("\n\t vec. %0d. LEFT PORT -  Test to Write and Read back \n ",vector); 
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00017;
                  single_write_left;                    // write to left port
                  d_check_l = Data_l;
                  read_l;
               end 
             else if(TESTCASE ==  `WR_r_TEST )                              
               begin
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Write and Read back \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h0fabe; 
                  Data_r =  `DATA_MSB_1'h00017;
                  single_write_right;                   // write to right port  
                  d_check_r = Data_r;
                  read_r;
               end
             else if(TESTCASE == `WRITE_COLLISION_TEST )                              
               begin
                  $display("\n\t vec. %0d. Test to Write to both the ports at same location without Violating tCCS \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  Data_r =  `DATA_MSB_1'h00017;
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00055;
                  ->collision_event;
                  #`MSGDLY
                    #`MSGDLY 
                      d_check_r = Data_r;
                  read_r;
               end
             else if(TESTCASE == `WR_BOTH_TEST )                              
               begin
                  $display("\n\t vec. %0d. Test to Write and Read back from both the ports at different location \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00065; 
                  Data_r =  `DATA_MSB_1'h00015;
                  Addr_l =  `ADDR_MSB_1'h00061; 
                  Data_l =  `DATA_MSB_1'h00019;
                  ->both_write_event;
                  #`MSGDLY
                    #`MSGDLY 
                      d_check_r = Data_r;
                  read_r;
               end
             else if(TESTCASE == `RD_l_be_01 )                              
               begin
                  $display("\n\t vec. %0d. Test to Read from LEFT PORT with byte enable = 01 \n  ",vector); 
                  Addr_l =  `ADDR_MSB_1'h00101; 
                  Data_l = `DATA_MSB_1'h17878;
                  single_write_left1;
                  d_check_l = `DATA_MSB_1'h17800;
                  readl_byte_enable_01 ;
               end     
             else if(TESTCASE == `RD_l_be_10 )                              
               begin
                  $display("\n\t vec. %0d. Test to Read from LEFT PORT with byte enable = 10  \n ",vector); 
                  Addr_l =  `ADDR_MSB_1'h00111; 
                  Data_l = `DATA_MSB_1'h17878;
                  single_write_left1;
                  d_check_l = `DATA_MSB_1'h00078;
                  readl_byte_enable_10 ;
               end
             else if(TESTCASE == `RD_l_be_11 )                              
               begin
                  $display("\n\t vec. %0d. Test to Read from LEFT PORT with byte enable = 11 \n  ",vector); 
                  Addr_l =  `ADDR_MSB_1'h00100; 
                  Data_l = `DATA_MSB_1'h17878;
                  single_write_left1;
                  d_check_l = `DATA_MSB_1'hzzzzz;
                  readl_byte_enable_11 ;
               end
             else if(TESTCASE == `RD_r_be_01 )                              
               begin
                  $display("\n\t vec. %0d. Test to Read from RIGHT PORT with byte enable = 01 \n  ",vector); 
                  Addr_r =  `ADDR_MSB_1'h01101; 
                  Data_r = `DATA_MSB_1'h17878;
                  single_write_right1;
                  d_check_r = `DATA_MSB_1'h17800;
                  readr_byte_enable_01 ;
               end
             else if(TESTCASE == `RD_r_be_10 )                              
               begin
                  $display("\n\t vec. %0d. Test to Read from RIGHT PORT with byte enable = 10   \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00110; 
                  Data_r = `DATA_MSB_1'h17878;
                  single_write_right1;
                  d_check_r = `DATA_MSB_1'h00078;
                  readr_byte_enable_10 ;
               end
             else if(TESTCASE == `RD_r_be_11 )                              
               begin
                  $display("\n\t vec. %0d. Test to Read from RIGHT PORT with byte enable = 11   \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h01021; 
                  Data_r = `DATA_MSB_1'h17878;
                  single_write_right1;
                  d_check_r = `DATA_MSB_1'hzzzzz;
                  readr_byte_enable_11 ;
               end
             else if(TESTCASE == `WR_l_be_01 )                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 01\n   ",vector); 
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00000;
                  single_write_left;      
                  Data_l =  `DATA_MSB_1'h15555; 
                  writel_byte_enable_01;
                  d_check_l =`DATA_MSB_1'h15400;
                  read_l;
               end
             else if(TESTCASE == `WR_l_be_10 )                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 10 \n  ",vector) ;
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00000;
                  single_write_left;      
                  Data_l =  `DATA_MSB_1'h15555; 
                  writel_byte_enable_10 ;
                  d_check_l =`DATA_MSB_1'h00155;
                  read_l;
               end
             else if(TESTCASE == `WR_l_be_11 )                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT with byte enable = 11 \n  ",vector); 
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00000;
                  single_write_left;      
                  Data_l =  `DATA_MSB_1'h15555; 
                  writel_byte_enable_11 ;
                  d_check_l =`DATA_MSB_1'h00000;
                  read_l;
               end
             else if(TESTCASE == `WR_r_be_01)                                           
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT with byte enable = 01 \n  ",vector); 
                  Addr_r =  `ADDR_MSB_1'h00068; 
                  Data_r =  `DATA_MSB_1'h00000;
                  single_write_right;
                  Data_r =  `DATA_MSB_1'h15555; 
                  writer_byte_enable_01 ;
                  d_check_r = `DATA_MSB_1'h15400;
                  read_r ;      
               end
             else if(TESTCASE == `WR_r_be_10)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT with byte enable = 10  \n ",vector); 
                  Addr_r =  `ADDR_MSB_1'h00068; 
                  Data_r =  `DATA_MSB_1'h00000;
                  single_write_right;
                  Data_r =  `DATA_MSB_1'h15555; 
                  writer_byte_enable_10 ;
                  d_check_r = `DATA_MSB_1'h00155;
                  read_r ;      
               end
             else if(TESTCASE == `WR_r_be_11)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT with byte enable = 11  \n ",vector); 
                  Addr_r =  `ADDR_MSB_1'h00068; 
                  Data_r =  `DATA_MSB_1'h00000;
                  single_write_right;
                  Data_r =  `DATA_MSB_1'h15555; 
                  writer_byte_enable_11 ;
                  d_check_r = `DATA_MSB_1'h00000;
                  read_r ;      
               end
             //---------
             else if(TESTCASE == `RD_l_2_TEST)                              
               begin
                  $display("\n\t vec. %0d. two consecutive reads from left port \n",vector); 
                  Addr_l = 	`ADDR_MSB_1'h00001;
                  d_check_l = `DATA_MSB_1'h00001;
                  read_l_2;
               end
             else if(TESTCASE == `RD_r_2_TEST)                              
               begin
                  $display("\n\t vec. %0d. two consecutive reads from right port \n",vector);  
                  Addr_r = 	`ADDR_MSB_1'h00001; 
                  d_check_r = `DATA_MSB_1'h00001;
                  read_r_2;
               end
             else if(TESTCASE == `WR_l_2_TEST)                              
               begin
                  $display("\n\t vec. %0d. two consecutive writes from left port \n",vector); 
                  Addr_l = 	`ADDR_MSB_1'h00067;
                  Data_l =  `DATA_MSB_1'h00001;               
                  single_write_left;
                  Addr_l = 	Addr_l + 1;
                  Data_l = Data_l + 1;               
                  single_write_left;
                  Addr_l = 	`ADDR_MSB_1'h00067;
                  Data_l =  `DATA_MSB_1'h00001;               
                  d_check_l = Data_l;
                  read_l_2; 
               end
             else if(TESTCASE == `WR_r_2_TEST)                              
               begin
                  $display("\n\t vec. %0d. two consecutive writes from right port \n",vector); 
                  Addr_r = 	`ADDR_MSB_1'h00067;
                  Data_r =  `DATA_MSB_1'h00001;               
                  single_write_right;
                  Addr_r = 	Addr_r + 1;
                  Data_r = Data_r + 1;               
                  single_write_right;
                  Addr_r = 	`ADDR_MSB_1'h00067;
                  Data_r =  `DATA_MSB_1'h00001;
                  d_check_r = Data_r;                
                  read_r_2; 
               end

             else if(TESTCASE == `WR_l_RD_l_3FFFF)   //highest memory  write and read by left port.(consecutive)                         
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from RIGHT PORT at the Highest Memory Location 3FFFF \n",vector); 
                  Addr_l =  `ADDR_MSB_1'h3FFFF; 
                  Data_l =  `DATA_MSB_1'h00017;
                  d_check_l = `DATA_MSB_1'h00017;
                  ->wr_l_rd_l_1FFF;
               end
             else if(TESTCASE == `WR_r_RD_r_3FFFF)   //highest memory  write and read by right port.(consecutive)                         
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from RIGHT PORT at the Highest Memory Location 3FFFF \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h3FFFF; 
                  Data_r =  `DATA_MSB_1'h00017; 
                  d_check_r = `DATA_MSB_1'h00017;              
                  ->wr_r_rd_r_1FFF;
               end
             else if(TESTCASE == `WR_l_RD_r_3FFFF)   //highest memory  write and read by left port.(Simultaneous)                         
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from RIGHT PORT at the Highest Memory Location 3FFFF \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h3FFFF; 
                  Data_r =  `DATA_MSB_1'hzzzzz;
                  Addr_l =  `ADDR_MSB_1'h3FFFF; 
                  Data_l =  `DATA_MSB_1'h00017;
                  d_check_r = `DATA_MSB_1'h00017;
                  ->wr_l_rd_r_1FFF;
               end
             else if(TESTCASE == `WR_r_RD_l_3FFFF)   //highest memory  write and read by left port. (Simultaneous)                        
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from LEFT PORT at the Highest Memory Location 3FFFF \n ",vector); 
                  Addr_r =  `ADDR_MSB_1'h3FFFF; 
                  Data_r =  `DATA_MSB_1'h00017;
                  Addr_l =  `ADDR_MSB_1'h3FFFF; 
                  Data_l =  `DATA_MSB_1'hzzzzz;
                  d_check_l = `DATA_MSB_1'h00017;
                  ->wr_r_rd_l_1FFF;
               end 
             else if(TESTCASE == `WR_l_RD_r_TEST)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read from RIGHT PORT at different locations \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00002; 
                  Data_r =  `DATA_MSB_1'h00002;
                  Addr_l =  `ADDR_MSB_1'h00001; 
                  Data_l =  `DATA_MSB_1'h00017;
                  d_check_r = `DATA_MSB_1'h00002; 
                  ->wr_l_rd_r_same_event;
               end
             else if(TESTCASE == `WR_l_RD_r_SAME_TEST)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read from RIGHT PORT at same location \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  Data_r =  `DATA_MSB_1'h00015;
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00017;
                  d_check_r = `DATA_MSB_1'h00017;
                  ->wr_l_rd_r_same_event;
               end
             else if(TESTCASE == `RD_l_WR_r_TEST)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at different locations \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00065; 
                  Data_r =  `DATA_MSB_1'h00015;
                  Addr_l =  `ADDR_MSB_1'h00001; 
                  Data_l =  `DATA_MSB_1'h00010;
                  d_check_l = `DATA_MSB_1'h00001;
                  ->rd_l_wr_r_same_event;
               end
             else if(TESTCASE == `RD_l_WR_r_SAME_TEST)                       
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at same location \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00101; 
                  Data_r =  `DATA_MSB_1'h00ff0;
                  Addr_l =  `ADDR_MSB_1'h00101; 
                  Data_l =  `DATA_MSB_1'h00ff0;
                  d_check_l = Data_r;  
                  ->rd_l_wr_r_event;
               end
             else if(TESTCASE == `RD_l_TEST_WO_nCE_11)                              
               begin
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00017;
                  $display("\n\t vec. %0d. Test to Read from LEFT PORT with /CE0 = 1 , CE1 = 1\n",vector);
                  rd_l_wo_nce;
               end
             else if(TESTCASE == `RD_r_TEST_WO_nCE_11 )                              
               begin
                  Addr_r =  `ADDR_MSB_1'h00065; 
                  Data_r =  `DATA_MSB_1'h00015;
                  $display("\n\t vec. %0d. Test to Read from RIGHT PORT with /CE0 = 1 , CE1 = 1\n",vector);
                  rd_r_wo_nce;
               end
             else if(TESTCASE == `RD_l_TEST_WO_nCE_00)                              
               begin
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00017;
                  $display("\n\t vec. %0d. Test to Read from LEFT PORT with /CE0 = 0 , CE1 = 0\n",vector);
                  rd_l_wo_nce1;
               end
             else if(TESTCASE == `RD_r_TEST_WO_nCE_00 )                              
               begin
                  Addr_r =  `ADDR_MSB_1'h00065; 
                  Data_r =  `DATA_MSB_1'h00015;
                  $display("\n\t vec. %0d. Test to Read from RIGHT PORT with /CE0 = 0 , CE1 = 0\n",vector);
                  rd_r_wo_nce1;
               end
             else if(TESTCASE == `WR_l_TEST_WO_nCE)                              
               begin
                  $display("\n\t vec. %0d. Test to Read from LEFT PORT With /CE0 = 0 , CE1 = 0\n",vector);
                  $display("\n\t\t Writing to LEFT PORT with Chip Enabled ( /CE0 = 0 , CE1 = 1 )\n");                  
                  Addr_l =  `ADDR_MSB_1'h00065; 
                  Data_l =  `DATA_MSB_1'h00015;
                  single_write_left1;
                  $display("\n\t\t Writing to LEFT PORT without Chip Enabled ( /CE0 = 1 , CE1 = 1 )\n"); 
                  Data_l =  `DATA_MSB_1'h0bb15;  
                  wr_l_wo_nce;     
                  d_check_l = Data_l;   
                  read_l;
               end
             else if(TESTCASE == `WR_r_TEST_WO_nCE)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT without Chip Enable \n",vector);
                  $display("\n\t\t Writing to RIGHT PORT with Chip Enabled ( /CE0 = 0 , CE1 = 1 )\n");
                  Addr_r =  `ADDR_MSB_1'h00065; 
                  Data_r =  `DATA_MSB_1'h00015;
                  single_write_right1;
                  $display("\n\t\t Writing to RIGHT PORT without Chip Enabled ( /CE0 = 1 , CE1 = 1 )\n"); 
                  Data_r =  `DATA_MSB_1'h0bb15;   
                  wr_r_wo_nce;     
                  d_check_r = Data_r;   
                  read_r;
               end
             else if(TESTCASE == `WR_l_10_RD_l_10)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from  LEFT PORT 10 DATAs consecutively \n ",vector);
                  Addr_l = `ADDR_MSB_1'h00000;
                  Data_l = `DATA_MSB_1'h00000;
                  for(i=0; i<10; i=i+1)
                  begin
                     single_write_left;
                     d_check_l = Data_l;
                     read_l;
                     #`tCYC2
                     Addr_l = Addr_l + 1;                         
                     Data_l = Data_l + 1;
                  end
               end
             else if(TESTCASE == `WR_r_10_RD_r_10)                              
               begin 
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from RIGHT PORT 10 DATAs consecutively\n",vector);
                  Addr_r = `ADDR_MSB_1'h00000;
                  Data_r = `DATA_MSB_1'h00000;
                  for(i=0; i<10; i=i+1)
                  begin
                     single_write_right;
                     d_check_r = Data_r;
                     read_r;
                     #`tCYC2
                     Addr_r = Addr_r + 1;                         
                     Data_r = Data_r + 1;
                  end
               end
             else if(TESTCASE == `WR_l_10_RD_r_10)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to LEFT PORT and Read back from RIGHT PORT 10 DATAs consecutively\n",vector);
                  Addr_l = `ADDR_MSB_1'h00000;
                  Data_l = `DATA_MSB_1'h00000;
                  Addr_r = `ADDR_MSB_1'h00000;
                  ->wr_l_event;
                  ->rd_r_event;                
               end
             else if(TESTCASE == `WR_r_10_RD_l_10)                             
               begin
                  $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read back from LEFT PORT 10 DATAs consecutively\n",vector);
                  Addr_r = `ADDR_MSB_1'h00000;
                  Data_r = `DATA_MSB_1'h00000;
                  Addr_l = `ADDR_MSB_1'h00000;
                  ->wr_r_event;
                  ->rd_l_event;                               
               end
             else if(TESTCASE == `WR_COLLISION_VIOLATION_TEST)                              
               begin
                  $display("\n\t vec. %0d. Test to Write to both the ports at same location Violating tCCS \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  Data_r =  `DATA_MSB_1'h00027;
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00017;
                  ->collision_violation_event;
                  #`MSGDLY
                    #`MSGDLY;
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  d_check_r =  `DATA_MSB_1'h00027;
                  read_r;
               end
             else if (TESTCASE == `RD_r_WR_l_sam_violation)  begin             
                $display("\n\t vec. %0d. Test to Read from RIGHT PORT and write to LEFT PORT at same location violating tCCS\n",vector); 
                Addr_r =  `ADDR_MSB_1'h0a058; 
                Data_r =  `DATA_MSB_1'h05515;
                single_write_right;
                #`MSGDLY
                  Addr_l =  `ADDR_MSB_1'h0a058; 
                Data_l =  `DATA_MSB_1'h0aa17;
                d_check_r = `DATA_MSB_1'h05515;
                ->rd_r_wr_l_same_event;
                #`MSGDLY
                  #`MSGDLY
                    d_check_r = `DATA_MSB_1'h0aa17;
                read_r;
                #`MSGDLY
                  #`MSGDLY
                    #`MSGDLY;
             end       
             else if (TESTCASE == `WR_r_RD_l_sam_violation) begin
                $display("\n\t vec. %0d. Test to Write to RIGHT PORT and Read from LEFT PORT at same location violating tCCS\n",vector); 
                Addr_r =  `ADDR_MSB_1'h0a5f1; 
                Data_r =  `DATA_MSB_1'h00011;
                Addr_l =  `ADDR_MSB_1'h0a5f1; 
                Data_l =  `DATA_MSB_1'h00011;
                ->rd_l_wr_r_event;
                #`MSGDLY
                  #`MSGDLY
                    //single_write_right;
                    d_check_l = Data_l;
                read_l;              
                #`MSGDLY
                  #`MSGDLY;
             end
             else if(TESTCASE == `WR_RD_WR_l)                              
               begin
                  $display("\n\t vec. %0d. LEFT PORT - Test to Write - Read - Write \n ",vector);
                  WR_RD_WR_l_TASK;
               end              
             else if(TESTCASE == `WR_RD_WR_r)                              
               begin
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Write - Read - Write \n",vector);
                  WR_RD_WR_r_TASK;
               end
             else if(TESTCASE == `RD_WR_RD_l)                              
               begin
                  d_check_l = `DATA_MSB_1'h00001;
                  $display("\n\t vec. %0d. LEFT PORT  - Test to Read - Write - Read  \n",vector);
                  RD_WR_RD_l_TASK;
               end
             else if(TESTCASE == `RD_WR_RD_r)                             
               begin
                  d_check_r = `DATA_MSB_1'h00001;
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Read - Write - Read  \n",vector);
                  RD_WR_RD_r_TASK;
               end
             else if (TESTCASE == `RD_l_r_sam)
               begin
                  $display("\n\t vec. %0d. Test to Read from both the ports at same location \n",vector); 
                  Addr_r = `ADDR_MSB_1'h00001;
                  Addr_l = `ADDR_MSB_1'h00001;
                  d_check_l = `DATA_MSB_1'h00001;
                  d_check_r = `DATA_MSB_1'h00001;
                  ->rd_l_r_sam;
               end
             else if (TESTCASE == `RD_l_r_diff)
               begin
                  $display("\n\t vec. %0d. Test to Read from both the ports at different location \n",vector); 
                  Addr_r = `ADDR_MSB_1'h00001;
                  Addr_l = `ADDR_MSB_1'h00002;
                  d_check_r = `DATA_MSB_1'h00001;
                  d_check_l = `DATA_MSB_1'h00002;
                  ->rd_l_r_sam;
               end
             else  if (TESTCASE == `RD_L_VIOLATION)
               begin
                  $display("\n\t vec. %0d. Read from left port Test  \n",vector); 
                  Addr_l =  `ADDR_MSB_1'h00001; 
                  d_check_l = `DATA_MSB_1'h00001;
                  read_l_violation;                              // read left without OE
               end
             else if (TESTCASE == `RD_R_VIOLATION)
               begin
                  $display("\n\t vec. %0d. Read from left port Test  \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00001; 
                  d_check_r = `DATA_MSB_1'h00001;
                  read_r_violation;                               // read left without OE
               end
             else  if (TESTCASE == `RD_l_r_sam_VIOLATION)
               begin
                  $display("\n\t vec. %0d. Read from left port Test  \n",vector); 
                  Addr_l =  `ADDR_MSB_1'h00001;
                  Addr_r =  `ADDR_MSB_1'h00001;
                  d_check_l = `DATA_MSB_1'h00001;
                  d_check_r = `DATA_MSB_1'h00001;
                  -> rd_l_r_sam_violation;
               end
             // read left without OE
             else  if (TESTCASE == `RD_l_r_diff_VIOLATION)
               begin
                  $display("\n\t vec. %0d. Read from left port Test  \n",vector); 
                  Addr_l =  `ADDR_MSB_1'h00001;
                  Addr_r =  `ADDR_MSB_1'h00002; 
                  d_check_l = `DATA_MSB_1'h00001;
                  d_check_r = `DATA_MSB_1'h00002;
                  -> rd_l_r_sam_violation;
               end
             else if(TESTCASE ==  `WR_l_TEST_violation )   
               begin
                  $display("\n\t vec. %0d. write to left port Test  \n",vector); 
                  Addr_l =  `ADDR_MSB_1'h00067; 
                  Data_l =  `DATA_MSB_1'h00017;
                  single_write_left_violation;                    // write to left port
               end 
             else if(TESTCASE ==  `WR_r_TEST_violation )   
               begin
                  $display("\n\t vec. %0d. write to right port Test \n",vector); 
                  Addr_r =  `ADDR_MSB_1'h00067; 
                  Data_r =  `DATA_MSB_1'h00017;
                  single_write_right_violation;                   // write to right port  
               end
             else if (TESTCASE == `MSK_RST_l)
               begin
                  $display("\n\t vec. %0d. LEFT PORT - Test to Mask Reset and Mask Read Back Operations\n",vector); 
                  Addr_l = `ADDR_MSB_1'h3ffff;
                  mask_reset_l;
                  read_mask_l;                  
               end
             else if (TESTCASE == `MSK_LOAD_l)
               begin
                  $display("\n\t vec. %0d. LEFT PORT - Test to Mask Load and Mask Read Back Operations\n",vector);                   
                  Addr_l = `ADDR_MSB_1'h3ffff;
                  mask_reset_l;
                  read_mask_l;                  
                  Addr_l = `ADDR_MSB_1'h0007f;
                  load_mask_l;
                  Addr_l = `ADDR_MSB_1'h0007f;
                  read_mask_l;  
                  Addr_l = `ADDR_MSB_1'h000ff;
                  load_mask_l;                                       
                  Addr_l = `ADDR_MSB_1'hx003f;
                  $display("\n\t\t Invalid loading of LEFT PORT Mask Register \n");                                     
                  load_mask_l;
                  Addr_l = `ADDR_MSB_1'h000ff;
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);                  
                  read_mask_l;                  
               end
            else if (TESTCASE == `MSK_RST_r)
              begin
                 $display("\n\t vec. %0d. RIGHT PORT - Test to Mask Reset and Mask Read Back Operations \n ",vector);                                    
                 Addr_r = `ADDR_MSB_1'h3ffff;
                 mask_reset_r;
                 read_mask_r;                  
               end
             else if (TESTCASE == `MSK_LOAD_r)
               begin
                  $display("\n\t vec. %0d. RIGHT PORT - Test to Mask Load and Mask Read Back Operations \n ",vector);                            
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
                  Addr_r = `ADDR_MSB_1'hx003f;
                  load_mask_r;
                  Addr_r = `ADDR_MSB_1'h000ff;
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);                                    
                  read_mask_r;                  
               end
             else if (TESTCASE == `EVEN_COUNT_RDBK_l)
               begin
                  $display("\n\t vec. %0d. LEFT PORT  - Test to Write and Read operations with Even Address \n ",vector);               
                 Addr_l = `ADDR_MSB_1'h3ffff;
                 mask_reset_l;
                 read_mask_l; 
                 Addr_l = `ADDR_MSB_1'h3fffe;
                 load_mask_l;
                 read_mask_l;                  
                 #`MSGDLY             
                 #`MSGDLY
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 wr_burst_l_port_c_count_2;
                 nop_l;
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 rd_burst_l_port_c_count_2;                
               end
            else if (TESTCASE == `ODD_COUNT_RDBK_l)
              begin
                 $display("\n\t vec. %0d. LEFT PORT  - Test to Write and Read operations with Odd Address \n ",vector);                                   
                 Addr_l = `ADDR_MSB_1'h3ffff;
                 mask_reset_l;
                 read_mask_l; 
                 Addr_l = `ADDR_MSB_1'h3fffe;
                 load_mask_l;
                 read_mask_l;                  
                 #`MSGDLY             
                 #`MSGDLY
                 Addr_l =  `ADDR_MSB_1'h35001;
                 Data_l =  `DATA_MSB_1'h2ff77;
                 wr_burst_l_port_c_count_2;
                 nop_l;
                 Addr_l =  `ADDR_MSB_1'h35001;
                 Data_l =  `DATA_MSB_1'h2ff77;
                 rd_burst_l_port_c_count_2;                               
               end
            
             else if (TESTCASE == `EVEN_COUNT_RDBK_r)
               begin
                  $display("\n\t vec. %0d. RIGHT PORT  - Test to Write and Read operations with Even Address \n ",vector);                                    
                  Addr_r = `ADDR_MSB_1'h3ffff;
                  mask_reset_r;
                  read_mask_r; 
                  Addr_r = `ADDR_MSB_1'h3fffe;
                  load_mask_r;
                  read_mask_r;                  
                  #`MSGDLY             
                    #`MSGDLY
                      Addr_r =  `ADDR_MSB_1'h05500;
                  Data_r =  `DATA_MSB_1'h25523;
                  wr_burst_r_port_c_count_2;
                  nop_r;
                  Addr_r =  `ADDR_MSB_1'h05500;
                  Data_r =  `DATA_MSB_1'h25523;
                  rd_burst_r_port_c_count_2;                
               end
            
            else if (TESTCASE == `ODD_COUNT_RDBK_r)
              begin
                 $display("\n\t vec. %0d. RIGHT PORT  - Test to Write and Read operations with Odd Address \n ",vector);                                  
                 Addr_r = `ADDR_MSB_1'h3ffff;
                 mask_reset_r;
                 read_mask_r; 
                 Addr_r = `ADDR_MSB_1'h3fffe;
                 load_mask_r;
                 read_mask_r;                  
                 #`MSGDLY             
                 #`MSGDLY
                 Addr_r =  `ADDR_MSB_1'h05501;
                 Data_r =  `DATA_MSB_1'h25523;
                 wr_burst_r_port_c_count_2;
                 nop_r;
                 Addr_r =  `ADDR_MSB_1'h05501;
                 Data_r =  `DATA_MSB_1'h25523;
                 rd_burst_r_port_c_count_2;                          
               end
            else if (TESTCASE == `CNTR_RST_l)
              begin
                 $display("\n\t vec. %0d. LEFT PORT - Test to Counter Reset and Counter Read Back Operations \n ",vector);                  
                 Addr_l = `ADDR_MSB_1'h0007f;
                 load_mask_l;                   
                 Addr_l = `ADDR_MSB_1'h3ff3f;
                 load_cntr_l;
                 read_cntr_l;                  
                 Addr_l = `ADDR_MSB_1'h3ff00;
                 cntr_reset_l;
                 read_cntr_l;                  
               end
             else if (TESTCASE == `CNTR_LOAD_l)
               begin
                  $display("\n\t vec. %0d. LEFT PORT - Test to Counter Reset, Counter Load and Counter Read Back Operations \n ",vector);                     
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
                  $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);                  
             	  read_cntr_l;                  
               end
            else if (TESTCASE == `CNTR_RST_r)
               begin
                 $display("\n\t vec. %0d. RIGHT PORT - Test to Counter Reset and Counter Read Back Operations \n ",vector);                    
                 Addr_r = `ADDR_MSB_1'h0007f;
                 load_mask_r;                   
                 Addr_r = `ADDR_MSB_1'h3ff3f;
                 load_cntr_r;
                 read_cntr_r;                  
                 Addr_r = `ADDR_MSB_1'h3ff00;
                 cntr_reset_r;
                 read_cntr_r;                  
               end
            else if (TESTCASE == `CNTR_LOAD_r)
  	          begin
                 $display("\n\t vec. %0d. RIGHT PORT - Test to Counter Reset, Counter Load and Counter Read Back Operations \n ",vector);              
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
                 $display ("%t\t MESSAGE EXPECTED : Unknown values on Address bus",$realtime);                                  
             	 read_cntr_r;           
             	 #`MSGDLY;                     
              end
             
            else if (TESTCASE == `BURST_L_PORT_TEST)
              begin
                 $display("\n \t vec. %0d. Test to Burst Write and Read Back Operations \n ", vector);              
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 wr_burst_l_port_c;
                 
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 rd_burst_l_port_c;
              end
             
            else if (TESTCASE == `BURST_R_PORT_TEST)
              begin
                 $display("\n \t vec. %0d. Test to Burst Write and Read Back Operations \n ", vector);              
                 Addr_r =  `ADDR_MSB_1'h2cd1a;
                 Data_r =  `DATA_MSB_1'h5a012;
                 wr_burst_r_port_c;
                 
                 Addr_r =  `ADDR_MSB_1'h2cd1a;
                 Data_r =  `DATA_MSB_1'h5a012;
                 rd_burst_r_port_c;
              end
             
            else if (TESTCASE == `CNTHLD_L_PORT_TEST)
              begin
                 $display("\n \t vec. %0d. Test to Write and Read back Operations with Counter Hold \n ",vector); 
                 Addr_l =  `ADDR_MSB_1'h00012;
                 Data_l =  `DATA_MSB_1'h0bcdf;
                 wr_cnthld_l_port_c;

                 Addr_l =  `ADDR_MSB_1'h00012;
                 Data_l =  `DATA_MSB_1'h0bcdf;
                 rd_cnthld_l_port_c;
                 #`MSGDLY;
              end

            else if (TESTCASE == `CNTHLD_R_PORT_TEST)
              begin
                 $display("\n \t vec. %0d. Test to Write and Read back Operations with Counter Hold \n ",vector); 
                 Addr_r =  `ADDR_MSB_1'h00010;
                 Data_r =  `DATA_MSB_1'h01234;
                 wr_cnthld_r_port_c;

                 Addr_r =  `ADDR_MSB_1'h00010;
                 Data_r =  `DATA_MSB_1'h01234;
                 rd_cnthld_r_port_c;
                 #`MSGDLY;
              end                          

            else if (TESTCASE == `MAIL_BOX_INT_TEST_L2R)
              begin
                 $display("\n\t vec. %0d. RIGHT PORT - Test to MAILBOX Operations \n ",vector); 
                 Addr_r = ~0;
                 Data_r =  `DATA_MSB_1'h2ff00;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 mailbox_int_chk_l2r;
              end

            else if (TESTCASE == `MAIL_BOX_INT_TEST_R2L)
              begin
                 $display("\n\t vec. %0d. LEFT PORT - Test to MAILBOX Operations \n ",vector); 
                 Addr_l = ~0 - 1;
                 Data_r =  `DATA_MSB_1'h2ff00;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 mailbox_int_chk_r2l;
              end
             
            else if (TESTCASE == `X_VIOLATIONS)
              begin
                 $display("\n ------------ CHECKING UNKNOWN VIOLATIONS ---------- \n "); 
                 vector = vector + 1; 
                 x_violate_l;
                 vector = vector + 1; 
                 x_violate_r;
              end
             
            else if (TESTCASE == `RETRANSMIT_l)             
              begin
                 $display("\n\t vec. %0d. LEFT PORT - Test to Retransmit Operation  \n ",vector);  
                 Addr_l = `ADDR_MSB_1'h0000f;
                 load_mask_l;
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 wr_burst_l_port_c_retransmit;
                 nop_l;
                 Addr_l =  `ADDR_MSB_1'h30000;
                 read_cntr_l;                  
                 nop_l;                  
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 rd_burst_l_port_c_retransmit;
                 nop_l;                
                 nop_l; 
                 Addr_l =  `ADDR_MSB_1'h30000;
                 Data_l =  `DATA_MSB_1'h2ff00;
                 rd_burst_l_port_c_retransmit;
                 nop_l;                
                 nop_l; 
 
                 Addr_l =  `ADDR_MSB_1'h30000;
                 read_cntr_l;                  
                   
              end
            else if (TESTCASE == `RETRANSMIT_r)             
              begin
                 $display("\n\t vec. %0d. RIGHT PORT - Test to Retransmit Operation  \n ",vector);
                 Addr_r = `ADDR_MSB_1'h0000f;
                 load_mask_r;
                 Addr_r =  `ADDR_MSB_1'h3f000;
                 Data_r =  `DATA_MSB_1'h3ff55;
                 wr_burst_r_port_c_retransmit;
                 nop_r;
                 Addr_r =  `ADDR_MSB_1'h3f000;
                 read_cntr_r;                  
                 nop_r;
                 Addr_r =  `ADDR_MSB_1'h3f000;
                 Data_r =  `DATA_MSB_1'h3ff55;
                 rd_burst_r_port_c_retransmit;                
                 nop_r;                
                 nop_r; 
                 Addr_r =  `ADDR_MSB_1'h3f000;
                 Data_r =  `DATA_MSB_1'h3ff55;
                 rd_burst_r_port_c_retransmit;                
                 Addr_r =  `ADDR_MSB_1'h3f000;
                 nop_r;                
                 nop_r; 
                 read_cntr_r;                  

               end

//---------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------
             #`MSGDLY
             #`MSGDLY
             #`MSGDLY;
 
             if(failed_tests > 0)
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
          end        
        #200 $finish;
     end
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
      
        #`tCCS
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
        #(`tCYC2 + `tCYC2 -`tCCS) 
          read_l_signal;
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
   always@(wr_l_rd_l_1FFF)
     begin
        single_write_left;
     end
   always@(wr_l_rd_l_1FFF)
     begin
        #(`tCYC2 + `tCYC2)
          read_l;
     end
   always@(wr_r_rd_r_1FFF)
     begin
        single_write_right;
     end
   always@(wr_r_rd_r_1FFF)
     begin
        #`tCYC2 
          read_r;
     end
   //----------------------------------- simultaneous wr rd at 1FFF --------------
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
          Data_r = `DATA_MSB_1'h00000;
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
               d_check_r = Data_r;
               data_check_r <= #`tDC `DATA_MSB_1'hxxxxx;
               data_check_r <= #`tCD2  `DATA_MSB_1'hxxxxx;                                  
               data_check_r <= #(`tCYC2 )d_check_r;
               Data_r <= #(`tCYC2 -`tSD) Data_r + 1;
               Data_r <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxx;
            end
     end
   always@(chk_d_r2)
     begin
        @(posedge clkr)
          begin
             d_check_r =  Data_r;
             data_check_r <= #`tDC `DATA_MSB_1'hxxxxx;
             data_check_r <= #`tCD2 `DATA_MSB_1'hxxxx;                                  
             data_check_r <= #(`tCYC2 )d_check_r;
             Data_r <= #(`tCYC2 -`tSD) Data_r + 1;
             Data_r <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxx;
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
               Data_l = `DATA_MSB_1'h00000;
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
                
               d_check_l = Data_l;
               data_check_l <= #`tDC `DATA_MSB_1'hxxxxx;
               data_check_l <= #`tCD2  `DATA_MSB_1'hxxxxx;                                  
               data_check_l <= #(`tCYC2 )d_check_l;
               Data_l <= #(`tCYC2 -`tSD) Data_l + 1;
               Data_l <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxx;
            end
     end
   always@(chk_d_l2)
     begin
        @(posedge clkl)
          begin
             d_check_l =  Data_l;
             data_check_l <= #`tDC `DATA_MSB_1'hxxxxx;
             data_check_l <= #`tCD2 `DATA_MSB_1'hxxxx;                                  
             data_check_l <= #(`tCYC2 )d_check_l;
             Data_l <= #(`tCYC2 -`tSD) Data_l + 1;
             Data_l <= #(`tCYC2 + `tHD) `DATA_MSB_1'hxxxxx;
          end
     end
endmodule // cy7c0832v_test







