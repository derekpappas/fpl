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
// File         : cy7c0853v_tasks_test.v
//
// Author       : Sathya
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : Main Test Bench task file
// 
// Notes        : First Release
//
// Datasheet    : Cypress cy7c0853v, 3.3V 256K x 36 Synchronous Dual Port RAM,
//                (July 24, 2001)
//
// Modification History:
// Date         By       Version     Change Description
// ==========================================================================         
// 03/09/2001   Sathya    1.0         First Release.
//
//
//
//
// ==========================================================================         



task check_pin;
      input [80 : 0] pin_name;          
      input           pin_value;
      input           expected_pin_value;
      begin
         if (pin_value === expected_pin_value)
           $display ("%t %s PASSED :  Expected Value = %b Actual Value = %b ",$realtime,pin_name,expected_pin_value,pin_value);
         else                                                      
           begin
              $display ("%t %s FAILED : Expected Value = %b Actual Value = %b ",$realtime,pin_name,expected_pin_value,pin_value);
              failed_tests = failed_tests + 1;
           end
      end
endtask // check_pin




task check_addr_lines;
      input [120 : 0] disp;
      input [`ADDR_MSB  : 0] expected_Addr;
      input [`ADDR_MSB  : 0] actual_Addr;
      begin
         if (actual_Addr === expected_Addr)
           $display ("%t %s PASSED : Expected Address = %h Actual Address =%h  ",$realtime,disp,expected_Addr,actual_Addr);

         else                                                                  
           begin 
              $display ("%t %s FAILED : Expected Address = %h Actual Address = %h ",$realtime,disp,expected_Addr,actual_Addr);
              failed_tests = failed_tests + 1;
           end
      end
endtask // check_addr_lines


task check_data_lines_after_reset;
      input [120 : 0] disp;
      input [`ADDR_MSB  : 0] expected_data;
      input [`ADDR_MSB  : 0] actual_data;
      begin
         if (actual_data === expected_data)
           $display ("%t %s  PASSED :  Expected DATA = %h Actual Data = %h ",$realtime,disp,expected_data,actual_data);
         else                                                                  
           begin 
              $display ("%t %s  FAILED :  Expected DATA = %h Actual Data = %h ",$realtime,disp,expected_data,actual_data);
              failed_tests = failed_tests + 1;
           end
      end
endtask // check_data_lines_after_reset


task check_byte_enable;
      input [120 : 0] disp;
      input [`BYTE_MSB  : 0] expected_byte_enable;
      input [`BYTE_MSB  : 0] actual_byte_enable;
      begin
         if (actual_byte_enable === expected_byte_enable)
           $display ("%t %s PASSED expected_byte_enable  = %h actual_byte_enable = %h ",$realtime,disp,expected_byte_enable,actual_byte_enable);
         else                                                                                
           begin          
              $display ("%t %s FAILED expected_byte_enable  = %h actual_byte_enable = %h ",$realtime,disp,expected_byte_enable,actual_byte_enable);
              failed_tests = failed_tests + 1;        
           end 
      end
endtask // check_byte_enable

task initialisation;
      begin
         mrst_n <= 1'b1;
         r_w_nl    <= 1'b1;
         b_nl      <= `BYTE_MSB_1'b1111;
         ce0_nl    <= 1'b1;
         ce1l      <= 1'b0;
         cnt_msk_nl<= 1'b1;
         ads_nl    <= 1'b1;
         cnten_nl  <= 1'b1;
         cntrst_nl <= 1'b1;
         oe_nl     <= 1'b1;
         r_w_nr    <= 1'b1;
         b_nr      <= `BYTE_MSB_1'b1111;
         ce0_nr    <= 1'b1;
         ce1r      <= 1'b0;
         cnt_msk_nr<= 1'b1;
         ads_nr    <= 1'b1;
         cnten_nr  <= 1'b1;
         cntrst_nr <= 1'b1;
         oe_nr     <= 1'b1; 
      end
endtask

task single_write_left_violation; 
      begin
         
         @(posedge clkl)
           begin
              
              oe_nl <= 1'b0;                          
              r_w_nl    <= #(`tCYC2 - `tSW_1 ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB_1 ) `BYTE_MSB_1'b0;
              ce0_nl    <= #(`tCYC2 - `tSC_1 ) 1'b0;
              ce1l      <= #(`tCYC2 - `tSC_1 ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM_1 ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD_1 ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN_1 ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST_1 ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA_1 )  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD_1 )  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD_1 )`LEFT_PORT;
              #(`tCYC2) $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
           end
      end  
endtask // single_write_left_violation


task single_write_right_violation; 
      begin
         @(posedge clkr)
           begin
              
              oe_nr <= 1'b0;                          
              r_w_nr    <= #(`tCYC2 - `tSW_1 ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB_1 ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 - `tSC_1 ) 1'b0;
              ce1r      <= #(`tCYC2 - `tSC_1 ) 1'b1;
              cnt_msk_nr<= #(`tCYC2 - `tSCM_1 ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD_1 ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN_1 ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST_1 ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA_1 )  Addr_r;
              dqr_int   <= #(`tCYC2 - `tSD_1 )  Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW_1 ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB_1 ) `BYTE_MSB_1'b1111;
              ce0_nr    <= #(`tCYC2 + `tHC_1 ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC_1 ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM_1 ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD_1 ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN_1 ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST_1 ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA_1 )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD_1 )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD_1 )`RIGHT_PORT;
              #(`tCYC2) $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);
           end
      end  
endtask // single_write_right_violation


task reset;
      begin       
         mrst_n <= 1'b1;
         #`INIT_RESET ;
         mrst_n = 1'b0;
         $display ("%t\t Forcing MRST_N pin to %b ",$realtime,mrst_n); 
         change_time_ad_dt   <= 5'b00000;
         change_time     <= 5'b00000;
         mrst_n <= # `tRS 1'b1;

         oe_nl     <= 1'b0;
         r_w_nl    <= # (`tRS - `tRSS ) 1'b1;
         b_nl      <= # (`tRS - `tRSS ) `BYTE_MSB_1'b1111;
         ce0_nl    <= # (`tRS - `tRSS ) 1'b1;
         ce1l      <= # (`tRS - `tRSS ) 1'b0;
         cnt_msk_nl<= # (`tRS - `tRSS ) 1'b1;
         ads_nl    <= # (`tRS - `tRSS ) 1'b1;
         cnten_nl  <= # (`tRS - `tRSS ) 1'b1;
         cntrst_nl <= # (`tRS - `tRSS ) 1'b1;
         oe_nr     <= 1'b0;
         r_w_nr    <= # (`tRS - `tRSS ) 1'b1;
         b_nr      <= # (`tRS - `tRSS ) `BYTE_MSB_1'b1111;
         ce0_nr    <= # (`tRS - `tRSS ) 1'b1;
         ce1r      <= # (`tRS - `tRSS ) 1'b0;
         cnt_msk_nr<= # (`tRS - `tRSS ) 1'b1;
         ads_nr    <= # (`tRS - `tRSS ) 1'b1;
         cnten_nr  <= # (`tRS - `tRSS ) 1'b1;
         cntrst_nr <= # (`tRS - `tRSS ) 1'b1;
         //x  values
         r_w_nl    <= # (`tRS + `tRSR ) 1'b1; 
         b_nl      <= # (`tRS + `tRSR ) `BYTE_MSB_1'b1111;
         ce0_nl    <= # (`tRS + `tRSR ) 1'b1;
         ce1l      <= # (`tRS + `tRSR ) 1'b0;
         cnt_msk_nl<= # (`tRS + `tRSR ) 1'b1;
         ads_nl    <= # (`tRS + `tRSR ) 1'b1;
         cnten_nl  <= # (`tRS + `tRSR ) 1'b1;
         cntrst_nl <= # (`tRS + `tRSR ) 1'b1;
         r_w_nr    <= # (`tRS + `tRSR ) 1'b1;
         b_nr      <= # (`tRS + `tRSR ) `BYTE_MSB_1'b1111;
         ce0_nr    <= # (`tRS + `tRSR ) 1'b1;
         ce1r      <= # (`tRS + `tRSR ) 1'b0;
         cnt_msk_nr<= # (`tRS + `tRSR ) 1'b1;
         ads_nr    <= # (`tRS + `tRSR ) 1'b1;
         cnten_nr  <= # (`tRS + `tRSR ) 1'b1;
         cntrst_nr <= # (`tRS + `tRSR ) 1'b1;
//-----  
         expected_data_l <= # `tRSF `DATA_MSB_1'bz;
         expected_Addr_l <= # `tRSF `ADDR_MSB_1'bz;
         expected_data_r <= # `tRSF `DATA_MSB_1'bz;
         expected_Addr_r <= # `tRSF `ADDR_MSB_1'bz;
         change_time_ad_dt <= # `tRSF `CHECK_ADDR_DATA;
         expected_CNTINT_l <= # `tRScntint 1'b1;
         expected_CNTINT_r <= # `tRScntint 1'b1;
         change_time     <= # `tRScntint `CHECK_CNTINT;
// Expected inactive values
         expected_CNTINT_l  <= # `tRS 1'b1;      
         expected_CNTINT_r  <= # (`tRS - `tRSS) 1'b1;
// Expected active values
         expected_data_l    <= # (`tRS + `tRSR ) `DATA_MSB_1'bz;
         expected_Addr_l    <= # (`tRS + `tRSR ) `ADDR_MSB_1'bz;
         expected_CNTINT_l  <= # (`tRS + `tRSR ) 1'b1;
         expected_data_r    <= # (`tRS + `tRSR ) `DATA_MSB_1'bz;
         expected_Addr_r    <= # (`tRS + `tRSR ) `ADDR_MSB_1'bz;
         expected_CNTINT_r  <= # (`tRS + `tRSR ) 1'b1;
         change_time_ad_dt  <= # (`tRS + `tRSR_1) 5'b00000;

         #`tRSR;
         # 0.1 $display ("%t\t Forcing MRST_N pin to %b ",$realtime,mrst_n);          
      end
endtask // reset


task read_l_violation;//single read to left port
      begin
         @(posedge clkl) begin
            vec     = vec + 1;
          read_l_signal_violation;
         end
         check_read_l_data;
      end
endtask // read_l_violation



task read_l_signal_violation;
      begin
         ce0_nl <= # (`tCYC2 - `tSB_1) 1'b0;
         b_nl   <= # (`tCYC2 - `tSB_1) b_nl_reg;
         r_w_nl <= # (`tCYC2 - `tSW_1) 1'b1;
         ce1l   <= # (`tCYC2 - `tSC_1) 1'b1;         
         ads_nl <= # (`tCYC2 - `tSW_1) 1'b0;         
         cnten_nl  <= #(`tCYC2 - `tSCN_1 ) 1'b0;
         cntrst_nl <= #(`tCYC2 - `tSRST_1 ) 1'b1;
         cntrst_nl <= #(`tCYC2 + `tHRST_1 ) 1'b1;
         cnt_msk_nl<= #(`tCYC2 - `tSCM_1 ) 1'b1;
         al_int <= # (`tCYC2 - `tSA_1) Addr_l;
         ce0_nl <= # (`tCYC2 + `tHC_1) 1'b1;
         b_nl   <= # (`tCYC2 + `tHB_1) `BYTE_MSB_1'b1111;
         r_w_nl <= # (`tCYC2 + `tHW_1) 1'b1;
         ce1l   <= # (`tCYC2 + `tHC_1) 1'b0;         
         oe_nl <= 1'b0;                          
         ads_nl <= # (`tCYC2 + `tHW_1) 1'b1;         
         cnten_nl  <= #(`tCYC2 + `tHCN_1 ) 1'b1;
         cnt_msk_nl<= #(`tCYC2 + `tHCM_1 ) 1'b1;
         al_int <= # (`tCYC2 + `tHA_1) `ADDR_MSB_1'hz;
      end
endtask // read_l_signal_violation

task read_r_violation;//single read to right port
      begin
         @(posedge clkr) begin
            vec     = vec + 1;
            read_r_signal_violation;
         end
         check_read_r_data;
      end
endtask // read_r

task read_r_signal_violation;
      begin
         ce0_nr <= # (`tCYC2 - `tSB) 1'b0;
         b_nr   <= # (`tCYC2 - `tSB) b_nr_reg;
         r_w_nr <= # (`tCYC2 - `tSW) 1'b1;
         ce1r   <= # (`tCYC2 - `tSC) 1'b1;         
         ads_nr <= # (`tCYC2 - `tSW) 1'b0;         
         cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
         cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
         cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
         cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
         ar_int <= # (`tCYC2 - `tSA + 0.1) Addr_r;
         ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
         b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
         r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
         ce1r   <= # (`tCYC2 + `tHC) 1'b1;         
         oe_nr <= 1'b0;                                
         ads_nr <= # (`tCYC2 + `tHW) 1'b1;         
         cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
         cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
         ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
      end
endtask // read_r_signal_violation



task read_l_signal;
      begin
         ce0_nl <= # (`tCYC2 - `tSC) 1'b0;
         b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
         r_w_nl <= # (`tCYC2 - `tSW) 1'b1;
         ce1l   <= # (`tCYC2 - `tSC) 1'b1;         
         ads_nl <= # (`tCYC2 - `tSW) 1'b0;         
         cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
         cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
         cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
         al_int    <= # (`tCYC2 - `tSA) Addr_l;
         cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
         ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
         b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
         r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
         ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
         oe_nl  <= 1'b0;                               
         ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
         cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
         cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
         al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
      end
endtask // read_l_signal

//----------------------- write-to-read-to-write task------------
event chk_WR_RD_WR_l,chk_WR_RD_WR_r,chk_RD_WR_RDl1,chk_RD_WR_RDl2,chk_RD_WR_RDr1,chk_RD_WR_RDr2;
//left port
task WR_RD_WR_l_TASK;
      begin
         Addr_l = `ADDR_MSB_1'h0aa01;
         Data_l = `DATA_MSB_1'h05501;
         d_check_l_reg = `DATA_MSB_1'h05501;
         single_write_left;
         single_write_left;
         @(posedge clkl)
           begin
              read_l_signal;
              @(posedge clkl)
                begin
                   ->chk_WR_RD_WR_l;
                   read_l_signal;
                end
           end
         
         Addr_l_b = `ADDR_MSB_1'h0cdcd;
         Data_l = `DATA_MSB_1'hzzzzzzzzz;
         
         @(posedge clkl)
           begin

              oe_nl <= 1'b0;                          
              r_w_nl    <= #(`tCYC2 - `tSW  ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) `BYTE_MSB_1'b00;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l_b;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b11;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD )`LEFT_PORT;
              #(`tCYC2) $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l_b,Data_l);
           end
          
         Addr_l = `ADDR_MSB_1'h0dc01;
         Data_l = `DATA_MSB_1'h0ab01;
         single_write_left;
      end
endtask // WR_RD_WR_l_TASK


always@(chk_WR_RD_WR_l)
  begin
     @(posedge clkl)
       Addr_l = `ADDR_MSB_1'h0aa01;              
     data_check_l <= #`tCD2  d_check_l;                                  
  end
   
   //right port
   task WR_RD_WR_r_TASK;
      begin
         Addr_r = `ADDR_MSB_1'h03301;
         Data_r = `DATA_MSB_1'h0f001;
         d_check_r_reg = `DATA_MSB_1'h0f001;
         single_write_right;
         single_write_right;
         @(posedge clkr)
           begin
              read_r_signal;
              @(posedge clkr)
                begin
                   ->chk_WR_RD_WR_r;
                   read_r_signal;
                end
           end
         Addr_r_b = `ADDR_MSB_1'h03301;
         Data_r = `DATA_MSB_1'hzzzzzzzzz;
         
         @(posedge clkr)
           begin
              
              r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB ) `BYTE_MSB_1'b10;
              ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA  )  Addr_r_b;
              dqr_int   <= #(`tCYC2 - `tSD  )  Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b11;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`RIGHT_PORT;
              #(`tCYC2) $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r_b,Data_r);
           end
 
         Addr_r = `ADDR_MSB_1'h03301;
         Data_r = `DATA_MSB_1'h0f001;
         single_write_right;
      end
   endtask // WR_RD_WR_r_TASK
   
   always@(chk_WR_RD_WR_r)
     begin
        @(posedge clkr) begin
           data_check_r <= #`tCD2  d_check_r;                                  
        end
     end


   //----------------------- read-to-write-to-read task------------
   //left port
   task RD_WR_RD_l_TASK;
      begin
         Addr_l = `ADDR_MSB_1'h00001;
         Data_l = `DATA_MSB_1'hzzzzzzzzz;  
         @(posedge clkl)
           begin
              read_l_signal;
              ->chk_RD_WR_RDl1;
              @(posedge clkl)
                read_l_signal;
           end
         single_write_left1;
         Data_l = `DATA_MSB_1'h1ffbc;  
         single_write_left1;
         @(posedge clkl)
           begin
              read_l_signal;
              ->chk_RD_WR_RDl2;
              @(posedge clkl)
                read_l_signal;
           end
      end
   endtask // RD_WR_RD_l_TASK
   
   always@(chk_RD_WR_RDl1)
     begin
        @(posedge clkl)
          @(posedge clkl)
            begin
               data_check_l <= #`tCD2  d_check_l;                                  
               data_check_l <= #(`tCYC2 + `tCYC2 - `tSD)`DATA_MSB_1'hzzzzzzzzz;
               data_check_l <= #(`tCYC2 + `tCYC2 + `tHD) Data_l;                                        
               data_check_l <= #(`tCYC2 + `tCKHZ )`DATA_MSB_1'hzzzzzzzzz;
            end
     end
   
   always@(chk_RD_WR_RDl2)
     begin
        d_check_l_reg = Data_l;
        @(posedge clkl)
          @(posedge clkl)
            begin
               data_check_l <= #`tCKLZ `DATA_MSB_1'hxxxxxxxxx;
               data_check_l <= #`tCD2 d_check_l;                                  
            end
     end
   

   //right port
   task RD_WR_RD_r_TASK;
      begin
         Addr_r = `ADDR_MSB_1'h00002;
         Data_r = `DATA_MSB_1'hzzzzzzzzz;  
         @(posedge clkr)
           begin
              read_r_signal;
              ->chk_RD_WR_RDr1;
              @(posedge clkr)
                read_r_signal;
           end
         single_write_right1;
         Data_r = `DATA_MSB_1'h00001ffbc;  
         single_write_right1;
         @(posedge clkr)
           begin
              read_r_signal;
              ->chk_RD_WR_RDr2;
              @(posedge clkr)
                read_r_signal;
           end
      end
   endtask // RD_WR_RD_r_TASK
   
   always@(chk_RD_WR_RDr1)
     begin
        @(posedge clkr)
          @(posedge clkr)
            begin
               data_check_r <= #`tCD2  d_check_r;                                  
               data_check_r <= #(`tCYC2 + `tCYC2 - `tSD)`DATA_MSB_1'hzzzzzzzzz; 
               data_check_r <= #(`tCYC2 + `tCYC2 + `tHD) Data_r;                                        
               data_check_r <= #(`tCYC2 + `tCKHZ )`DATA_MSB_1'hzzzzzzzzz;
            end
     end
   
   always@(chk_RD_WR_RDr2)
     begin
        d_check_r_reg = Data_r;
        @(posedge clkr)
          @(posedge clkr)
            begin
               data_check_r <= #`tCKLZ `DATA_MSB_1'hxxxxxxxxx;
               data_check_r <= #`tCD2 d_check_r;                                  
            end
     end
   
   //--------------------------------------------------------------------------
   task read_r_signal;
      begin
         ce0_nr <= # (`tCYC2 - `tSB) 1'b0;
         b_nr   <= # (`tCYC2 - `tSB) b_nr_reg;
         r_w_nr <= # (`tCYC2 - `tSW) 1'b1;
         ce1r   <= # (`tCYC2 - `tSC) 1'b1;         
         ads_nr <= # (`tCYC2 - `tSW) 1'b0;         
         cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
         cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
         cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
         cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
         oe_nr <= 1'b0;                                
         ar_int <= # (`tCYC2 - `tSA) Addr_r;
         ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
         b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
         r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
         ce1r   <= # (`tCYC2 + `tHC) 1'b1;         
         ads_nr <= # (`tCYC2 + `tHW) 1'b1;         
         cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
         cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
         ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
      end
   endtask // read_r_signal
   

   task check_read_l_data_wo_rst;// one clock pule to be given before execution 
      begin
         @(posedge clkl)
           @(posedge clkl)begin
              data_check_l <= #`tCKLZ `DATA_MSB_1'h000000000;
              data_check_l <= #`tDC   `DATA_MSB_1'h000000000;                                  
              data_check_l <= #`tCD2  d_check_l;
           end
      end
   endtask // check_read_l_data_wo_rst
   

   task read_r;//single read to right port
      begin
         @(posedge clkr) begin
            vec = vec + 1;
            read_r_signal;
         end
         check_read_r_data;
      end
   endtask // read_r

   task read_l;//single read to left port
      begin
         @(posedge clkl) begin
            vec     = vec + 1;
            read_l_signal;
         end
        check_read_l_data;
      end
   endtask // read_l
   task read_l_wo_rst;//single read to left port
      begin
         @(posedge clkl) begin
            vec     = vec + 1;
            read_l_signal;
         end
         check_read_l_data_wo_rst;
      end
   endtask // read_l

   
   
   task read_l_oe1;
     begin
         @(posedge clkl) begin
            read_l_signal;
          end

         @(posedge clkl)
           @(posedge clkl)
                begin
                  data_check_l <= #`tCD2  d_check_l ;
                  oe_nl <= 1'b0;                          
                  #(`INIT_DELAY_OE ) 
                  oe_nl <= 1'b1;          
                  oe_nl <= #(`tOHZ + 3.2) 1'b0;
                  data_check_l <= # `tOHZ `DATA_MSB_1'hzzzzzzzzz;
                end 

     end
  endtask 

//----------------------------------------- RD_WR_RD OE controlled---------------------------------------
   task read_l_oe2;
     begin
         @(posedge clkl) begin
            read_l_signal;
          end

         @(posedge clkl)
           @(posedge clkl)
                begin
                   r_w_nl    <= #(`tCYC2 - `tSW  ) 1'b0;
                   b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
                   ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0;
                   ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
                   cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
                   ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
                   cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
                   cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
                   al_int    <= #(`tCYC2 - `tSA)    Addr_l;
                   dql_int   <= #(`tCYC2 - `tSD  )  Data_l;
                   r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
                   b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1111;
                   ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
                   ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
                   cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
                   ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
                   cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
                   cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
                   al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
                   dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
                   check_port <= #(`tCYC2 - `tSD )`LEFT_PORT;
                   
                   data_check_l <= #`tCD2  d_check_l ;
                   oe_nl <= 1'b0;                          
                   #(`INIT_DELAY_OE - 2.0)
                   oe_nl <= 1'b1;          
                   oe_nl <= #(`tOHZ + 8.5) 1'b0;
                   #(`tCYC2) $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
                end 
        
     end
   endtask 
   task read_r_oe2;
     begin
         @(posedge clkr) begin
            read_r_signal;
          end

        @(posedge clkr)
          @(posedge clkr)
            begin
               r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
               b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
               ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;
               ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
               cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
               ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
               cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
               cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
               ar_int    <= #(`tCYC2 - `tSA  )  Addr_r;
               dqr_int   <= #(`tCYC2 - `tSD  ) Data_r;
               r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
               b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
               ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
               ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
               cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
               ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
               cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
               cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
               ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
               dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
               check_port <= #(`tCYC2 - `tSD)`RIGHT_PORT;
               
               data_check_r <= #`tCD2  d_check_r ;
               oe_nr <= 1'b0;                          
               #(`INIT_DELAY_OE - 2.0) 
               oe_nr <= 1'b1;          
               oe_nr <= #(`tOHZ + 8.5) 1'b0;
               #(`tCYC2) $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);
               
            end 
        
     end
  endtask 

//-------------------------------------------------------------------



  task read_r_oe1;
     begin
         @(posedge clkr) begin
            read_r_signal;
          end

         @(posedge clkr)
           @(posedge clkr)
                begin
                  data_check_r <= #`tCD2  d_check_r ;
                  oe_nr <= 1'b0;                          
                  #`INIT_DELAY_OE 
                  oe_nr <= 1'b1;          
                  oe_nr <= #(`tOHZ + 3.2) 1'b0;
                  data_check_r <= # `tOHZ `DATA_MSB_1'hzzzzzzzzz;
                end 

     end
  endtask 


   task read_l_oe;//single read to left with OE
      begin
         @(posedge clkl) begin
            read_l_signal;
         end
         @(posedge clkl) begin
            Addr_l = Addr_l + 1;
            read_l_signal;
            @(posedge clkl) begin
               Addr_l = Addr_l + 1;
               read_l_signal;           
               @(posedge clkl) begin
                  $display ("\t LEFT PORT READING WITH OE CONTROLLED\n");
                  Addr_l <= #`tCD2 Addr_l - 1;                                                               
                  data_check_l <= #`tCD2  d_check_l + 1;
                  oe_nl <= 1'b0;                          
                  #`INIT_DELAY_OE 
                    oe_nl <= 1'b1;          
                  oe_nl <= #(`tOHZ + 3.0 + 0.2) 1'b0;
                  data_check_l <= # `tOHZ `DATA_MSB_1'hzzzzzzzzz;
                  Addr_l <= #(`tCD2 + 0.2) Addr_l ;   
             	  data_check_l <= #(`tOHZ + 3.0 + 0.2 + `tOE)d_check_l + 2;
               end   
            end
         end              
      end
   endtask // read_l_oe


   task read_r_oe;//single read to left with OE
      begin
         @(posedge clkr) begin
            read_r_signal;
         end
         @(posedge clkr) begin
            Addr_r = Addr_r + 1;
            read_r_signal;
            @(posedge clkr) begin
               Addr_r = Addr_r + 1;
               read_r_signal;
               @(posedge clkr) begin
                  $display ("\t RIGHT PORT READING WITH OE CONTROLLED");
                  Addr_r <= #`tCD2 Addr_r - 1;                                                               
                  data_check_r <= #`tCD2  d_check_r + 1;
                  oe_nr <= 1'b0;                          
                  #`INIT_DELAY_OE
                    oe_nr <= 1'b1;          
                  oe_nr <= #(`tOHZ + 3.0 + 0.2) 1'b0;
                  data_check_r <= # `tOHZ `DATA_MSB_1'hzzzzzzzzz;             
                  Addr_r <= #(`tCD2 + 0.2) Addr_r ;   
                  data_check_r <= #(`tOHZ + 3.0 + 0.2+`tOE) d_check_r + 2;       
               end   
            end
         end 
      end
   endtask // read_r_oe

   always @ (data_check_l) begin
      check_data_lines ("LEFT PORT",Addr_l,data_check_l,dql);
   end
   
   always @ (data_check_r) begin
      check_data_lines ("RIGHT PORT",Addr_r,data_check_r,dqr);
   end
   
   task single_write_left1; 
      begin
         @(posedge clkl)
           begin
              
              oe_nl <= 1'b0;                          
              r_w_nl    <= #(`tCYC2 - `tSW  ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1111;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              #(`tCYC2) $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
           end
      end  
   endtask
   task single_write_left; 
      begin
         @(posedge clkl)
           begin

              oe_nl <= 1'b0;                          
              r_w_nl    <= #(`tCYC2 - `tSW  ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1111;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD )`LEFT_PORT;
              $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
           end
      end  
   endtask
   task write_l_2;
      begin
         @(posedge clkl)
           begin
              
              r_w_nl    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1111;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`LEFT_PORT;
              single_write_left;
           end
      end
   endtask
   task write_r_2;
      begin

         @(posedge clkr)
           begin
              
              r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA  )  Addr_r;
              dqr_int   <= #(`tCYC2 - `tSD  )  Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`RIGHT_PORT;
              single_write_right;
           end

         $display ("%t\t Right Port Writing at the Address %h, Data Written = %h BYTE EN = 00",$realtime,Addr_r,Data_r);
      end
   endtask
   task single_write_right1;
      begin
         @(posedge clkr)
           begin
              
              oe_nr <= 1'b0;                          
              r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA  )  Addr_r;
              dqr_int   <= #(`tCYC2 - `tSD  ) Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              #(`tCYC2) $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);
           end
      end
   endtask
   task single_write_right;
      begin
         @(posedge clkr)
           begin
              oe_nr <= 1'b0;                          
              r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA  )  Addr_r;
              dqr_int   <= #(`tCYC2 - `tSD  ) Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD) `RIGHT_PORT;
              $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);
           end
      end
   endtask
   //--------------------------------------collision tasks-----------------------------------
   task single_write_left_col; 
      begin
         @(posedge clkl)
           begin
              
              r_w_nl    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0;
              ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1111;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`COLLISION;
              #(`tCYC2) $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
           end
      end  
   endtask
   task single_write_right_col;
      begin
         #`tCCS
           @(posedge clkr)
             begin
                
                r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
                b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
                ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;
                ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
                cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
                ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
                cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
                cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
                ar_int    <= #(`tCYC2 - `tSA)  Addr_r;
                dqr_int   <= #(`tCYC2 - `tSD)  Data_r;
                r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
                b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
                ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
                ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
                cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
                ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
                cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
                cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
                ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
                dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
                #(`tCYC2) $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);
             end
      end
   endtask
   //---------------- with out chip enable------------
   task  mrst_wo_nce;
      begin
         mrst_n <= 1'b1;
         #`INIT_RESET ;
         change_time_ad_dt   <= 5'b00000;
         //         change_time_all   <= 5'b00000;
         change_time     <= 5'b00000;
         mrst_n <= 1'b0;
         mrst_n <= # `tRS 1'b1;
         $display ("  ************ ***NORMAL OPERATION**** ************");
         //inactive values
         oe_nl     <= # (`tRS - `tRSS ) 1'b1;
         r_w_nl    <= # (`tRS - `tRSS ) 1'b1;
         b_nl      <= # (`tRS - `tRSS ) `BYTE_MSB_1'b1111;
         ce0_nl    <= # (`tRS - `tRSS ) 1'b1;
         ce1l      <= # (`tRS - `tRSS ) 1'b0;
         cnt_msk_nl<= # (`tRS - `tRSS ) 1'b1;
         ads_nl    <= # (`tRS - `tRSS ) 1'b1;
         cnten_nl  <= # (`tRS - `tRSS ) 1'b1;
         cntrst_nl <= # (`tRS - `tRSS ) 1'b1;
         oe_nr     <= # (`tRS - `tRSS ) 1'b1;
         r_w_nr    <= # (`tRS - `tRSS ) 1'b1;
         b_nr      <= # (`tRS - `tRSS ) `BYTE_MSB_1'b1111;
         ce0_nr    <= # (`tRS - `tRSS ) 1'b1;
         ce1r      <= # (`tRS - `tRSS ) 1'b0;
         cnt_msk_nr<= # (`tRS - `tRSS ) 1'b1;
         ads_nr    <= # (`tRS - `tRSS ) 1'b1;
         cnten_nr  <= # (`tRS - `tRSS ) 1'b1;
         cntrst_nr <= # (`tRS - `tRSS ) 1'b1;
         //active values
         oe_nl     <= # (`tRS + `tRSR ) 1'b0;
         r_w_nl    <= # (`tRS + `tRSR ) 1'b1; 
         b_nl      <= # (`tRS + `tRSR ) `BYTE_MSB_1'b1111;
         ce0_nl    <= # (`tRS + `tRSR ) 1'b1;   
         ce1l      <= # (`tRS + `tRSR ) 1'b1;
         cnt_msk_nl<= # (`tRS + `tRSR ) 1'b1;
         ads_nl    <= # (`tRS + `tRSR ) 1'b1;
         cnten_nl  <= # (`tRS + `tRSR ) 1'b1;
         cntrst_nl <= # (`tRS + `tRSR ) 1'b1;
         oe_nr     <= # (`tRS + `tRSR ) 1'b0;
         r_w_nr    <= # (`tRS + `tRSR ) 1'b1;
         b_nr      <= # (`tRS + `tRSR ) `BYTE_MSB_1'b1111;
         ce0_nr    <= # (`tRS + `tRSR ) 1'b0;
         ce1r      <= # (`tRS + `tRSR ) 1'b1;
         cnt_msk_nr<= # (`tRS + `tRSR ) 1'b1;
         ads_nr    <= # (`tRS + `tRSR ) 1'b1;
         cnten_nr  <= # (`tRS + `tRSR ) 1'b1;
         cntrst_nr <= # (`tRS + `tRSR ) 1'b1;
         //-----
         expected_data_l <= # (`tRS - `tRSS) `DATA_MSB_1'bz;
         expected_Addr_l <= # (`tRS - `tRSS) `ADDR_MSB_1'bz;
         expected_data_r <= # (`tRS - `tRSS) `DATA_MSB_1'bz;
         expected_Addr_r <= # (`tRS - `tRSS) `ADDR_MSB_1'bz;  
         change_time_ad_dt   <= # (`tRS - `tRSS) `CHECK_ADDR_DATA;
         change_time_ad_dt   <= # (`tRS - `tRSS + `tRSF/2) 5'b0000;
         expected_data_l <= # `tRSF `DATA_MSB_1'bz;
         expected_Addr_l <= # `tRSF `ADDR_MSB_1'bz;
         expected_data_r <= # `tRSF `DATA_MSB_1'bz;
         expected_Addr_r <= # `tRSF `ADDR_MSB_1'bz;
         change_time_ad_dt   <= # `tRSF `CHECK_ADDR_DATA;
         expected_CNTINT_l <= # `tRScntint 1'b1;
         expected_CNTINT_r <= # `tRScntint 1'b1;
         change_time     <= # `tRScntint `CHECK_CNTINT;
         // Expected inactive values
         expected_CNTINT_l  <= # `tRS 1'b1;      
         expected_CNTINT_r  <= # (`tRS - `tRSS) 1'b1;
         // Expected active values
         expected_data_l    <= # (`tRS + `tRSR ) `DATA_MSB_1'bz;
         expected_Addr_l    <= # (`tRS + `tRSR ) `ADDR_MSB_1'bz;
         expected_CNTINT_l  <= # (`tRS + `tRSR ) 1'b1;
         expected_data_r    <= # (`tRS + `tRSR ) `DATA_MSB_1'bz;
         expected_Addr_r    <= # (`tRS + `tRSR ) `ADDR_MSB_1'bz;
         expected_CNTINT_r  <= # (`tRS + `tRSR ) 1'b1;
         change_time_ad_dt   <=# (`tRS + `tRSR_1) 5'b00000;
         change_time_ad_dt      <= # (`tRS + `tRSR) `CHECK_ADDR_DATA;
      end
   endtask
   task rd_r_wo_nce;//single read to right port
      begin
         @(posedge clkr) begin
            ce0_nr <= # (`tCYC2 - `tSC) 1'b1;        
            b_nr   <= # (`tCYC2 - `tSB) b_nr_reg;
            r_w_nr <= # (`tCYC2 - `tSW) 1'b1;
            ce1r   <= # (`tCYC2 - `tSC) 1'b1;         
            ads_nr <= # (`tCYC2 - `tSW) 1'b0;         
            cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
            ar_int <= # (`tCYC2 - `tSA) Addr_r;//`ADDR_MSB_1'h00001;
            ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
            b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
            r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
            ce1r   <= # (`tCYC2 + `tHC) 1'b1;         
            ads_nr <= # (`tCYC2 + `tHW) 1'b1;         
            cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
            ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
         end
         @(posedge clkr) begin
            @(posedge clkr) begin    
               check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
               #`tCKLZ check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
               #(`tCD2 - `tCKLZ )check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
            end   
         end
         @(posedge clkr)
           @(posedge clkr) begin
              #(`tDC ) check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
           end
      end
   endtask // read_r
   task rd_r_wo_nce1;//single read to right port
      begin
         @(posedge clkr) begin
            ce0_nr <= # (`tCYC2 - `tSC) 1'b0;     
            b_nr   <= # (`tCYC2 - `tSB) b_nr_reg;
            r_w_nr <= # (`tCYC2 - `tSW) 1'b1; 
            ce1r   <= # (`tCYC2 - `tSC) 1'b0;            
            ads_nr <= # (`tCYC2 - `tSW) 1'b0;         
            cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
            ar_int <= # (`tCYC2 - `tSA) Addr_r;//`ADDR_MSB_1'h00001;
            ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
            b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
            r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
            ce1r   <= # (`tCYC2 + `tHC) 1'b0;         
            ads_nr <= # (`tCYC2 + `tHW) 1'b1;         
            cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
            ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
         end
         @(posedge clkr) begin
            @(posedge clkr) begin    
               check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
               #`tCKLZ check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
               #(`tCD2 - `tCKLZ )check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
            end   
         end
         @(posedge clkr)
           @(posedge clkr) begin
              #(`tDC ) check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
           end
      end
   endtask // rd_r_wo_nce1
   





   task rd_l_wo_nce;//single read to left port
      begin
         @(posedge clkl) begin
            b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
            r_w_nl <= # (`tCYC2 - `tSW) 1'b1;
            ce0_nl <= # (`tCYC2 - `tSC) 1'b1;       
            ce1l   <= # (`tCYC2 - `tSC) 1'b1;         
            ads_nl <= # (`tCYC2 - `tSW) 1'b0;         
            cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
            al_int <= # (`tCYC2 - `tSA) Addr_l;//`ADDR_MSB_1'h00001;
            ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
            b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
            r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
            ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
            ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
            cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
            al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
         end
         @(posedge clkl) begin
            @(posedge clkl) begin    
               check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
               #`tCKLZ check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
               #(`tCD2 - `tCKLZ )check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
            end   
         end
         @(posedge clkl)
           @(posedge clkl) begin
              #(`tDC ) check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
           end
      end
   endtask // rd_l_wo_nce
   
   task rd_l_wo_nce1;//single read to left port
      begin
         @(posedge clkl) begin
            b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
            r_w_nl <= # (`tCYC2 - `tSW) 1'b1;
            ce0_nl <= # (`tCYC2 - `tSC) 1'b0;       
            ce1l   <= # (`tCYC2 - `tSC) 1'b0;       
            ads_nl <= # (`tCYC2 - `tSW) 1'b0;         
            cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
            al_int <= # (`tCYC2 - `tSA) Addr_l;//`ADDR_MSB_1'h00001;
            ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
            b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
            r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
            ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
            ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
            cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
            al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
         end
         @(posedge clkl) begin
            @(posedge clkl) begin    
               check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
               #`tCKLZ check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
               #(`tCD2 - `tCKLZ )check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
            end   
         end
         @(posedge clkl)
           @(posedge clkl) begin
              #(`tDC ) check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
           end
      end
   endtask // rd_l_wo_nce1

   task wr_l_wo_nce;      
      begin
         $display ("%t\t Left Port Writing without CE at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
         @(posedge clkl)
           begin
              oe_nl     <= #(`tCYC2 - `tSC ) 1'b1;
              r_w_nl    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b1;     
              ce1l      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nl    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nl      <= #(`tCYC2 + `tHB  ) `BYTE_MSB_1'b1111;
              ce0_nl    <= #(`tCYC2 + `tHC  ) 1'b1;
              ce1l      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dql_int   <= #(`tCYC2 +`tHD)   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`LEFT_PORT;
           end
      end  
   endtask // wr_l_wo_nce
   

   task wr_r_wo_nce;
      begin
         $display ("%t\t Right Port Writing without CE at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);
         @(posedge clkr)
           begin
              oe_nr     <= #(`tCYC2 - `tSC  ) 1'b1;
              r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 - `tSC ) 1'b1;   
              ce1r      <= #(`tCYC2 - `tSC ) 1'b1;
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA  )  Addr_r;
              dqr_int   <= #(`tCYC2 - `tSD  ) Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`RIGHT_PORT;
           end
      end
   endtask // wr_r_wo_nce

   task wr_l_wo_nce1;      
      begin
         $display ("%t\t Left Port Writing without CE at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
         @(posedge clkl)
           begin
              oe_nl     <= #(`tCYC2 - `tSC ) 1'b1;
              r_w_nl    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nl      <= #(`tCYC2 - `tSB ) b_nl_reg;
              ce0_nl    <= #(`tCYC2 - `tSC ) 1'b0; 
              ce1l      <= #(`tCYC2 - `tSC ) 1'b0;     
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              dql_int   <= #(`tCYC2 - `tSD)  Data_l;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`LEFT_PORT;
           end
      end  
   endtask // wr_l_wo_nce
   

   task wr_r_wo_nce1;
      begin
         $display ("%t\t Right Port Writing without CE at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);
         @(posedge clkr)
           begin
              oe_nr     <= #(`tCYC2 - `tSC  ) 1'b1;
              r_w_nr    <= #(`tCYC2 - `tSW ) 1'b0;
              b_nr      <= #(`tCYC2 - `tSB ) b_nr_reg;
              ce0_nr    <= #(`tCYC2 - `tSC ) 1'b0;  
              ce1r      <= #(`tCYC2 - `tSC ) 1'b0;  
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA  )  Addr_r;
              dqr_int   <= #(`tCYC2 - `tSD  ) Data_r;
              r_w_nr    <= #(`tCYC2 + `tHW ) 1'b1;
              b_nr      <= #(`tCYC2 + `tHB ) `BYTE_MSB_1'b1111;
              ce0_nr    <= #(`tCYC2 + `tHC ) 1'b1;
              ce1r      <= #(`tCYC2 + `tHC ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              dqr_int   <= #(`tCYC2 +`tHD )   `DATA_MSB_1'hz;
              check_port <= #(`tCYC2 - `tSD)`RIGHT_PORT;
           end
      end
   endtask // wr_r_wo_nce   

   event  wr_oe_l,wr_oe_r;

   task RD_WR_RD_OE_l_TASK;
      begin
         Addr_l = `ADDR_MSB_1'h00001;
         d_check_l_reg = `DATA_MSB_1'h000000010;   
         @(posedge clkl)
           read_l_signal;        
         @(posedge clkl)
           begin       
              ->wr_oe_l;   
              @(posedge clkl) 
                begin
                   $display ("\t LEFT PORT READING WITH OE CONTROLLED \ n");
                   data_check_l <= #`tCD2  d_check_l;
                   oe_nl <= 1'b0;                          
                   #`INIT_DELAY_OE
                     oe_nl <= 1'b1;          
                   oe_nl <= #`tOHZ 1'b0;
                   data_check_l <= #`tOHZ `DATA_MSB_1'hzzzzzzzzz; 
                end   
           end
      end
   endtask // RD_WR_RD_OE_l_TASK
   
  
   always@(wr_oe_l)
     begin
        Data_l = `DATA_MSB_1'h000001010;   
        d_check_l_reg = Data_l;
        single_write_left;
        @(posedge clkl)
          read_l_signal;
        @(posedge clkl)
          begin
             data_check_l <= #`tCD2  d_check_l;
             data_check_l <= #`tCKLZ `DATA_MSB_1'hxxxxxxxxx;
          end
     end
    

 
   
   task burst_read_l_signal;
      begin
         b_nl       <= # (`tCYC2 - `tSB) b_nl_reg;
         ce0_nl     <= # (`tCYC2 - `tSC) 1'b0;         
         ce1l       <= # (`tCYC2 - `tSC) 1'b1;         
         cnten_nl   <= # (`tCYC2 - `tSCN)1'b0;
         al_int     <= # (`tCYC2 - `tSA) Addr_l;       //`ADDR_MSB_1'h00001;
         cntrst_nl  <= # (`tCYC2 - `tSRST)1'b1;
         mrst_n     <= # (`tCYC2 - `tRSS)1'b1;         
         cnt_msk_nl <= # (`tCYC2 - `tSCM)1'b1;
         
        
         cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
         ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
         b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
         ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
         oe_nl <= 1'b0;                               
         ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
         cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
         cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
         al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;         
      end
   endtask // read_l_signal
      
   task burst_read_r_signal;
      begin
         b_nr       <= # (`tCYC2 - `tSB) b_nr_reg;
         ce0_nr     <= # (`tCYC2 - `tSC) 1'b0;         
         ce1r       <= # (`tCYC2 - `tSC) 1'b1;         
         cnten_nr   <= # (`tCYC2 - `tSCN)1'b0;
         ar_int     <= # (`tCYC2 - `tSA) Addr_r;       //`ADDR_MSB_1'h00001;
         cntrst_nr  <= # (`tCYC2 - `tSRST)1'b1;
         mrst_n     <= # (`tCYC2 - `tRSS)1'b1;
         cnt_msk_nr <= # (`tCYC2 - `tSCM)1'b1;
         
         b_nr       <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
         ce0_nr     <= # (`tCYC2 + `tHC) 1'b1;       
         ce1r       <= # (`tCYC2 + `tHC) 1'b0;         
         cnten_nr   <= # (`tCYC2 + `tHCN)1'b1;
         ar_int     <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
         cntrst_nr  <= # (`tCYC2 + `tHRST)1'b1;
         cnt_msk_nr <= # (`tCYC2 - `tHCM)1'b1;
      end
   endtask // read_r_signal
   

   task RD_BURST_L_PORT;
      begin      
         $display ("  ****** READ BURST MODE OPERATION FOR LEFT PORT ******");
         $display ("  *****************************************************");
         vec  = vec + 1;
         @(posedge clkl)
           begin             
              ads_nl    <= #(`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nl    <= #(`tCYC2 + `tHAD)1'b1;       
              r_w_nl    <= #(`tCYC2 - `tSW )1'b1;    // READ OPERATION 
              burst_read_l_signal;
              
              for (i=0; i<=10 ; i=i+1)
              begin            
                 @(posedge clkl)
                   begin                         
                      burst_read_l_signal;
                      Addr_l       <= Addr_l + 1;
                      d_check_l_reg    <= d_check_l + 1;
                      ads_nl       <= #(`tCYC2 - `tSAD)1'b1;      
                      ads_nl       <= #(`tCYC2 + `tHAD)1'b1;
                      data_check_l <= #(`tCYC2 + `tCD2) d_check_l;      // mem_test[Addr_l];   // #`tCD2 d_check_l;
                   end     
              end
           end
      end     
   endtask // RD_BURST_L_PORT


   task RD_BURST_L_2_PORT;
      begin      
         $display ("  ****** READ BURST MODE OPERATION FOR LEFT PORT ******");
         $display ("  ****** WITH MASK REGISTER SET FOR COUNT + 2 ************");
         vec  = vec + 1;
         @(posedge clkl)
           begin             
              Addr_l_2 = Addr_l;
              ads_nl    <= #(`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nl    <= #(`tCYC2 + `tHAD)1'b1;       
              r_w_nl    <= #(`tCYC2 - `tSW )1'b1;    // READ OPERATION 
              burst_read_l_signal;
              
              for (i=0; i<=20 ; i=i+1)
              begin            
                 @(posedge clkl)
                   begin                                             
                         burst_read_l_signal;
                         Addr_l_2          <= Addr_l_2 + 2;
                         ads_nl            <= #(`tCYC2 - `tSAD)1'b1;      
                         ads_nl            <= #(`tCYC2 + `tHAD)1'b1;
                         data_check_l      <= #(`tCYC2 + `tCD2) mem_test[Addr_l_2];                       
                         Addr_l            <= Addr_l_2 - 2; 
                              
                   end     
              end
           end
      end     
   endtask // RD_BURST_L_PORT



        

   task RD_BURST_R_2_PORT;
      begin      
         $display ("  ****** READ BURST MODE OPERATION FOR RIGHT PORT ******");
         $display ("  ****** WITH MASK REGISTER SET FOR COUNT + 2 ************");
         vec  = vec + 1;
         @(posedge clkr)
           begin             
              ads_nr    <= #(`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nr    <= #(`tCYC2 + `tHAD)1'b1;       
              r_w_nr    <= #(`tCYC2 - `tSW )1'b1;    // READ OPERATION 
              burst_read_r_signal;
              Addr_r_2 = Addr_r;
              for (i=0; i<=4 ; i=i+1)
              begin            
                 @(posedge clkr)
                   begin                                             
                      burst_read_r_signal;
                      Addr_r_2       <= Addr_r_2 + 2;
                      ads_nr         <= #(`tCYC2 - `tSAD)1'b1;      
                      ads_nr         <= #(`tCYC2 + `tHAD)1'b1;
                      data_check_r   <= #(`tCYC2 + `tCD2) mem_test[Addr_r_2 ];   // #`tCD2 d_check_l;
                      Addr_r            <= Addr_r_2 - 2; 
                   end     
              end
           end
      end     
   endtask // RD_BURST_L_PORT
//--------------------------------------------------

integer  retransmit_l,retransmit_r; 
  task RD_BURST_L_2_PORT_RETRANSMIT;
      begin      
         $display ("  ****** READ BURST MODE OPERATION FOR LEFT PORT ******");
         $display ("  ****** RETRANSMIT OPERATION ************");
         vec  = vec + 1;
         @(posedge clkl)
           begin        
              retransmit_r = Addr_r;     
              Addr_l_2 = Addr_l;
              ads_nl    <= #(`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nl    <= #(`tCYC2 + `tHAD)1'b1;       
              r_w_nl    <= #(`tCYC2 - `tSW )1'b1;    // READ OPERATION 
              burst_read_l_signal;
              
              for (i=0; i< retransmit_l ; i=i+1)
              begin            
                 @(posedge clkl)
                   begin                                             
                         burst_read_l_signal;
                         Addr_l_2          <= Addr_l_2 + 2;
                         ads_nl            <= #(`tCYC2 - `tSAD)1'b1;      
                         ads_nl            <= #(`tCYC2 + `tHAD)1'b1;
                         data_check_l      <= #(`tCYC2 + `tCD2) mem_test[Addr_l_2];   // #`tCD2 d_check_l;                    
                         Addr_l            <= Addr_l_2 - 2; 
                   end     
              end
           end
      end     
   endtask // RD_BURST_L_PORT
  
task RD_BURST_R_2_PORT_RETRANSMIT;
      begin      
         $display ("  ****** READ BURST MODE OPERATION FOR RIGHT PORT ******");
         $display ("  ****** WITH MASK REGISTER SET FOR COUNT + 2 ************");
         vec  = vec + 1;
         @(posedge clkr)
           begin             
              retransmit_r = Addr_r;
              ads_nr    <= #(`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nr    <= #(`tCYC2 + `tHAD)1'b1;       
              r_w_nr    <= #(`tCYC2 - `tSW )1'b1;    // READ OPERATION 
              burst_read_r_signal;
              Addr_r_2 = Addr_r;
              for (i=0; i<retransmit_r; i=i+1)
              begin            
                 @(posedge clkr)
                   begin                                             
                      burst_read_r_signal;
                      Addr_r_2       <= Addr_r_2 + 2;
                      ads_nr         <= #(`tCYC2 - `tSAD)1'b1;      
                      ads_nr         <= #(`tCYC2 + `tHAD)1'b1;
                      data_check_r   <= #(`tCYC2 + `tCD2) mem_test[Addr_r_2 ];   // #`tCD2 d_check_l;
                      Addr_r         <= Addr_r_2 - 2; 
                   end     
              end
           end
      end     
   endtask // RD_BURST_L_PORT



//------------------------------------------------




  
   task RD_BURST_R_PORT;
      begin      
         $display ("****** READ BURST MODE OPERATION FOR RIGHT PORT ******");
         $display ("******************************************************");
         vec  = vec + 1;
         @(posedge clkr)
           begin
              ads_nr    <= # (`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nr    <= # (`tCYC2 + `tHAD)1'b1;      
              r_w_nr    <= # (`tCYC2 - `tSW )1'b1;    // READ OPERATION 
              burst_read_r_signal;
              for (i=0; i<=10 ; i=i+1)
              begin    
                 @(posedge clkr)
                   begin
                      burst_read_r_signal;
                      Addr_r       <= Addr_r + 1;
                      Data_r       <= Data_r + 1;
                      ads_nr       <= #(`tCYC2 - `tSAD)1'b1;
                      ads_nr       <= #(`tCYC2 + `tHAD)1'b1;  
                      data_check_r <= #(`tCYC2 + `tCD2) mem_test[Addr_r];
                   end       
              end
           end
      end     
   endtask // RD_BURST_R_PORT
   
   
   
   task WR_BURST_L_PORT;
      begin      
         $display ("  ****** WRITE BURST MODE OPERATION FOR LEFT PORT ******");
         $display ("  ******************************************************");

         
         @(posedge clkl)
           begin             
              ads_nl    <= #(`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nl    <= #(`tCYC2 + `tHAD)1'b1;       
              r_w_nl    <= #(`tCYC2 - `tSW )1'b0;    // WRITE OPERATION 
              burst_read_l_signal;
              dql_int      <= Data_l;
              for (i=0; i<=10 ; i=i+1)
              begin            
                 @(posedge clkl)
                   begin                         
                      burst_read_l_signal;
                      Addr_l       <= Addr_l + 1;
                      Data_l       <= Data_l + 1;
                      ads_nl       <= #(`tCYC2 - `tSAD)1'b1;      
                      ads_nl       <= #(`tCYC2 + `tHAD)1'b1;
                      dql_int      <= #(`tCYC2 - `tSD )Data_l;
                      #`tCYC2 $display("%t\t LEFT PORT ADDRESS = %h DATA WRITTEN = %h ",$realtime,Addr_l,Data_l);
                   end     
              end
           end
      end     
   endtask // WR_BURST_L_PORT

   
   
   task WR_BURST_R_PORT;
      begin      
         $display ("****** WRITE BURST MODE OPERATION FOR RIGHT PORT ******");
         $display ("*******************************************************");
         vec  = vec + 1;
         Addr_r = 18'h00010;
         @(posedge clkr)
           begin
              ads_nr    <= # (`tCYC2 - `tSAD)1'b0;    // assert all the signal to start burst operation 
              ads_nr    <= # (`tCYC2 + `tHAD)1'b1;      
              r_w_nr    <= # (`tCYC2 - `tSW )1'b0;    // WRITE OPERATION 
              burst_read_r_signal;
              dqr_int      <= Data_r;
              for (i=0; i<=10 ; i=i+1)
              begin    
                 @(posedge clkr)
                   begin
                      burst_read_r_signal;
                      Addr_r       <= Addr_r + 1;  
                      Data_r       <= Data_r + 1;                  
                      ads_nr       <= #(`tCYC2 - `tSAD)1'b1;
                      ads_nr       <= #(`tCYC2 + `tHAD)1'b1;  
                      dqr_int      <= #(`tCYC2 - `tSD )Data_r;
                      #`tCYC2 $display("%t \t RIGHT PORT ADDRESS =%h DATA WRITTEN = %h ",$realtime,Addr_r,Data_r);
                   end       
              end
           end
      end     
   endtask // WR_BURST_R_PORT
   

//-------------------------------------------------------------------------------------------------------

task mask_reset_l;
begin
           @(posedge clkl)
             begin
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b0;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              #`tCYC2 $display("%t\t MASK RESET - Left Port",$realtime);    
            end
            
end 
endtask

task read_mask_l;
begin
             @(posedge clkl)
              begin 
               cnt_msk_nl   <= #(`tCYC2 - `tSCM ) 1'b0;
               ads_nl       <= #(`tCYC2 - `tSAD ) 1'b0;
               cnten_nl     <= #(`tCYC2 - `tSCN ) 1'b1;
               cntrst_nl    <= #(`tCYC2 - `tSRST ) 1'b1;
               cnt_msk_nl   <= #(`tCYC2 + `tHCM ) 1'b1;
               ads_nl       <= #(`tCYC2 + `tHAD ) 1'b1;
               cnten_nl     <= #(`tCYC2 + `tHCN ) 1'b1;
               cntrst_nl    <= #(`tCYC2 + `tHRST ) 1'b1;
              end
              check_mask_read_l;
end 
endtask
 
task load_mask_l;
begin
              @(posedge clkl)
              begin
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b0;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              #(`tCYC2) $display ("%t\t Mask Register Loaded With Address %h ",$realtime,Addr_l);
              end

end
endtask

task check_mask_read_l;
begin
  @(posedge clkl)
    @(posedge clkl) 
         Addr_check_l <= #(`tCM2 + 0.02) Addr_l;
      
end
endtask     


task mask_reset_r;
begin
           @(posedge clkr)
             begin
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b0;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              #`tCYC2 $display("%t\t MASK RESET -  Right Port",$realtime);
            end
            
end 
endtask

task read_mask_r;
begin
             @(posedge clkr)
              begin 
               cnt_msk_nr   <= #(`tCYC2 - `tSCM ) 1'b0;
               ads_nr       <= #(`tCYC2 - `tSAD ) 1'b0;
               cnten_nr     <= #(`tCYC2 - `tSCN ) 1'b1;
               cntrst_nr    <= #(`tCYC2 - `tSRST ) 1'b1;
               cnt_msk_nr   <= #(`tCYC2 + `tHCM ) 1'b1;
               ads_nr       <= #(`tCYC2 + `tHAD ) 1'b1;
               cnten_nr     <= #(`tCYC2 + `tHCN ) 1'b1;
               cntrst_nr    <= #(`tCYC2 + `tHRST ) 1'b1;
              end
              check_mask_read_r;
end 
endtask
 
task load_mask_r;
begin
              @(posedge clkr)
              begin
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b0;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA)  Addr_r;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              #(`tCYC2) $display ("%t\t Mask Register Loaded with Address %h ",$realtime,Addr_r);
              end

end
endtask



task check_mask_read_r;
begin
  @(posedge clkr)
    @(posedge clkr) 
         Addr_check_r <= #(`tCM2 + 0.02) Addr_r;
      
end
endtask     

//----------------------------- Counter -------------------------------------------------------

task cntr_reset_r;
begin
           @(posedge clkr)
             begin
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b0;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
            #`tCYC2 $display("%t\t COUNTER RESET -  Right Port",$realtime);
            end
            
end 
endtask


task read_cntr_r;
begin
             @(posedge clkr)
              begin 
               cnt_msk_nr   <= #(`tCYC2 - `tSCM ) 1'b1;
               ads_nr       <= #(`tCYC2 - `tSAD ) 1'b0;
               cnten_nr     <= #(`tCYC2 - `tSCN ) 1'b1;
               cntrst_nr    <= #(`tCYC2 - `tSRST ) 1'b1;
               cnt_msk_nr   <= #(`tCYC2 + `tHCM ) 1'b1;
               ads_nr       <= #(`tCYC2 + `tHAD ) 1'b1;
               cnten_nr     <= #(`tCYC2 + `tHCN ) 1'b1;
               cntrst_nr    <= #(`tCYC2 + `tHRST ) 1'b1;
              end
              check_cntr_read_r;
end 
endtask

task load_cntr_r;
begin
              @(posedge clkr)
              begin
              cnt_msk_nr<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nr    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nr <= #(`tCYC2 - `tSRST ) 1'b1;
              ar_int    <= #(`tCYC2 - `tSA)  Addr_r;
              cnt_msk_nr<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nr    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nr <= #(`tCYC2 + `tHRST ) 1'b1;
              ar_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              #(`tCYC2) $display ("%t\t Counter Register Loaded with Address %h ",$realtime,Addr_r);
              end

end
endtask

task check_cntr_read_r;
begin
  @(posedge clkr)
    @(posedge clkr) 
         Addr_check_r1 <= #(`tCA2 + 0.02) Addr_r;
      
end
endtask     

//------------------ left port-------------------------
task cntr_reset_l;
begin
           @(posedge clkl)
             begin
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b0;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              #`tCYC2 $display("%t\t COUNTER RESET -  Left Port",$realtime);
            end
            
end 
endtask


task read_cntr_l;
begin
             @(posedge clkl)
              begin 
               cnt_msk_nl   <= #(`tCYC2 - `tSCM ) 1'b1;
               ads_nl       <= #(`tCYC2 - `tSAD ) 1'b0;
               cnten_nl     <= #(`tCYC2 - `tSCN ) 1'b1;
               cntrst_nl    <= #(`tCYC2 - `tSRST ) 1'b1;
               cnt_msk_nl   <= #(`tCYC2 + `tHCM ) 1'b1;
               ads_nl       <= #(`tCYC2 + `tHAD ) 1'b1;
               cnten_nl     <= #(`tCYC2 + `tHCN ) 1'b1;
               cntrst_nl    <= #(`tCYC2 + `tHRST ) 1'b1;
              end
              check_cntr_read_l;
end 
endtask

task load_cntr_l;
begin
              @(posedge clkl)
              begin
              cnt_msk_nl<= #(`tCYC2 - `tSCM ) 1'b1;
              ads_nl    <= #(`tCYC2 - `tSAD ) 1'b0;
              cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
              cntrst_nl <= #(`tCYC2 - `tSRST ) 1'b1;
              al_int    <= #(`tCYC2 - `tSA)  Addr_l;
              cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
              ads_nl    <= #(`tCYC2 + `tHAD ) 1'b1;
              cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
              cntrst_nl <= #(`tCYC2 + `tHRST ) 1'b1;
              al_int    <= #(`tCYC2 + `tHA )  `ADDR_MSB_1'hz;
              #(`tCYC2) $display ("%t\t Counter Register Loaded with Address %h ",$realtime,Addr_l);
              end

end
endtask

task check_cntr_read_l;
begin
  @(posedge clkl)
    @(posedge clkl) 
         Addr_check_l1 <= #(`tCA2 + 0.02) Addr_l;
      
end
endtask     




always@(Addr_check_l)
check_msk_lines("LEFT PORT",Addr_check_l,al);


always@(Addr_check_r)
check_msk_lines("RIGHT PORT",Addr_check_r,ar);


always@(Addr_check_l1)
check_cnt_lines("LEFT PORT",Addr_check_l1,al);


always@(Addr_check_r1)
check_cnt_lines("RIGHT PORT",Addr_check_r1,ar);



//---------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------   

   task cnt_cmd;
      input port;
      input funct;
      input [30:0] mode_cnthd;
      input [`DATA_MSB : 0] databus;
      
      begin
         if (port == `LEFT_T)  begin // Left port
            ce1l       <= # (`tCYC2 - `tSC  )1'b1;
            ce1l       <= # (`tCYC2 + `tHC  )1'b1;
            ce0_nl     <= # (`tCYC2 - `tSC  )1'b0;
            ce0_nl     <= # (`tCYC2 + `tHC  )1'bx;
            b_nl       <= # (`tCYC2 - `tSB  )`BYTE_MSB_1'b0000;
            b_nl       <= # (`tCYC2 + `tHB  )`BYTE_MSB_1'bxxxx;            
            cnt_msk_nl <= # (`tCYC2 - `tSCM )1'b1;
            cnt_msk_nl <= # (`tCYC2 + `tHCM )1'bx;

            if (mode_cnthd == "HLD") begin           // counter hold
               cntrst_nl  <= # (`tCYC2 - `tSRST)1'b1;
               cntrst_nl  <= # (`tCYC2 + `tHRST)1'b1;                           
               ads_nl     <= # (`tCYC2 - `tSAD )1'b1;
               ads_nl     <= # (`tCYC2 + `tHAD )1'bx;                              
               cnten_nl   <= # (`tCYC2 - `tSCN )1'b1;
               cnten_nl   <= # (`tCYC2 + `tHCN )1'bx;
            end else if (mode_cnthd == "INC") begin  // counter increment
               cntrst_nl  <= # (`tCYC2 - `tSRST)1'b1;
               cntrst_nl  <= # (`tCYC2 + `tHRST)1'b1;                           
               ads_nl     <= # (`tCYC2 - `tSAD )1'b1;
               ads_nl     <= # (`tCYC2 + `tHAD )1'bx;                              
               cnten_nl   <= # (`tCYC2 - `tSCN )1'b0;
               cnten_nl   <= # (`tCYC2 + `tHCN )1'bx;
            end else if (mode_cnthd == "RST") begin  // counter reset
               cntrst_nl  <= # (`tCYC2 - `tSRST)1'b0;
               cntrst_nl  <= # (`tCYC2 + `tHRST)1'bx;                           
               ads_nl     <= # (`tCYC2 - `tSAD )1'b1;
               ads_nl     <= # (`tCYC2 + `tHAD )1'bx;                              
               cnten_nl   <= # (`tCYC2 - `tSCN )1'b1;
               cnten_nl   <= # (`tCYC2 + `tHCN )1'bx;
            end                                

            if (funct == `READ_T) begin               
               r_w_nl    <= #(`tCYC2 - `tSW )1'b1;    // Read 
               r_w_nl    <= #(`tCYC2 + `tHW )1'bx;
               data_check_l <= #((`tCYC2 * 2) + `tCD2)Data_l;
               #0.0001;
            end else begin
               r_w_nl    <= #(`tCYC2 - `tSW )1'b0;    // write
               r_w_nl    <= #(`tCYC2 + `tHW )1'bx;
               dql_int   <= #(`tCYC2 - `tSD )databus;
               dql_int   <= #(`tCYC2 + `tHD )`DATA_MSB_1'hz;
               #(`tCYC2) $display ("%t\t Left Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_l,Data_l);                              
            end

         end else begin // Right port
            ce1r       <= # (`tCYC2 - `tSC  )1'b1;
            ce1r       <= # (`tCYC2 + `tHC  )1'bx;
            ce0_nr     <= # (`tCYC2 - `tSC  )1'b0;
            ce0_nr     <= # (`tCYC2 + `tHC  )1'bx;
            b_nr       <= # (`tCYC2 - `tSB  )`BYTE_MSB_1'b0000;
            b_nr       <= # (`tCYC2 + `tHB  )`BYTE_MSB_1'bxxxx;            
            cnt_msk_nr <= # (`tCYC2 - `tSCM )1'b1;
            cnt_msk_nr <= # (`tCYC2 + `tHCM )1'bx;

            if (mode_cnthd == "HLD") begin           // counter hold
               cntrst_nr  <= # (`tCYC2 - `tSRST)1'b1;
               cntrst_nr  <= # (`tCYC2 + `tHRST)1'bx;                           
               ads_nr     <= # (`tCYC2 - `tSAD )1'b1;
               ads_nr     <= # (`tCYC2 + `tHAD )1'bx;                              
               cnten_nr   <= # (`tCYC2 - `tSCN )1'b1;
               cnten_nr   <= # (`tCYC2 + `tHCN )1'bx;
            end else if (mode_cnthd == "INC") begin  // counter increment
               cntrst_nr  <= # (`tCYC2 - `tSRST)1'b1;
               cntrst_nr  <= # (`tCYC2 + `tHRST)1'bx;                           
               ads_nr     <= # (`tCYC2 - `tSAD )1'b1;
               ads_nr     <= # (`tCYC2 + `tHAD )1'bx;                              
               cnten_nr   <= # (`tCYC2 - `tSCN )1'b0;
               cnten_nr   <= # (`tCYC2 + `tHCN )1'bx;
            end else if (mode_cnthd == "RST") begin  // counter reset
               cntrst_nr  <= # (`tCYC2 - `tSRST)1'b0;
               cntrst_nr  <= # (`tCYC2 + `tHRST)1'bx;                           
               ads_nr     <= # (`tCYC2 - `tSAD )1'b1;
               ads_nr     <= # (`tCYC2 + `tHAD )1'bx;                              
               cnten_nr   <= # (`tCYC2 - `tSCN )1'b1;
               cnten_nr   <= # (`tCYC2 + `tHCN )1'bx;
            end                                

            if (funct == `READ_T) begin               
               r_w_nr    <= #(`tCYC2 - `tSW )1'b1;    // Read 
               r_w_nr    <= #(`tCYC2 + `tHW )1'bx;
               data_check_r <= #((`tCYC2 * 2) + `tCD2)Data_r;
               #0.0001;               
            end else begin
               r_w_nr    <= #(`tCYC2 - `tSW )1'b0;    // write
               r_w_nr    <= #(`tCYC2 + `tHW )1'bx;
               dqr_int   <= #(`tCYC2 - `tSD )databus;
               dqr_int   <= #(`tCYC2 + `tHD )`DATA_MSB_1'hz;                 
               #(`tCYC2) $display ("%t\t Right Port Writing at the Address %h, Data Written = %h ",$realtime,Addr_r,Data_r);                              
            end            
         end
      end
   endtask // cnt_cmd
   
//-----------------------------

   task load_cnt;
      
      input port;
      input [`ADDR_MSB : 0] addrbus;
      
      begin
         if (port == `LEFT_T)  begin // Left port
            r_w_nl     <= # (`tCYC2 - `tSW  )1'b1;    // Read 
            r_w_nl     <= # (`tCYC2 + `tHW  )1'bx;    
            al_int     <= # (`tCYC2 - `tSA  )addrbus;
            al_int     <= # (`tCYC2 + `tHA  )`ADDR_MSB_1'hz;                 
            ce1l       <= # (`tCYC2 - `tSC  )1'b0;
            ce1l       <= # (`tCYC2 + `tHC  )1'bx;
            ce0_nl     <= # (`tCYC2 - `tSC  )1'b1;
            ce0_nl     <= # (`tCYC2 + `tHC  )1'bx;
            b_nl       <= # (`tCYC2 - `tSB  )`BYTE_MSB_1'b1111;
            b_nl       <= # (`tCYC2 + `tHB  )`BYTE_MSB_1'bxxxx;            
            cnt_msk_nl <= # (`tCYC2 - `tSCM )1'b1;
            cnt_msk_nl <= # (`tCYC2 + `tHCM )1'bx;
            cntrst_nl  <= # (`tCYC2 - `tSRST)1'b1;
            cntrst_nl  <= # (`tCYC2 + `tHRST)1'bx;            
            ads_nl     <= # (`tCYC2 - `tSAD )1'b0;
            ads_nl     <= # (`tCYC2 + `tHAD )1'bx;                              
            cnten_nl   <= # (`tCYC2 - `tSCN )1'b0;
            cnten_nl   <= # (`tCYC2 + `tHCN )1'bx;
         end else begin // Right port
            r_w_nr     <= # (`tCYC2 - `tSW  )1'b1;    // Read 
            r_w_nr     <= # (`tCYC2 + `tHW  )1'bx;    
            ar_int     <= # (`tCYC2 - `tSA  )addrbus;
            ar_int     <= # (`tCYC2 + `tHA  )`ADDR_MSB_1'hz;                 
            ce1r       <= # (`tCYC2 - `tSC  )1'b0;
            ce1r       <= # (`tCYC2 + `tHC  )1'bx;
            ce0_nr     <= # (`tCYC2 - `tSC  )1'b1;
            ce0_nr     <= # (`tCYC2 + `tHC  )1'bx;
            b_nr       <= # (`tCYC2 - `tSB  )`BYTE_MSB_1'b1111;
            b_nr       <= # (`tCYC2 + `tHB  )`BYTE_MSB_1'bxxxx;            
            cnt_msk_nr <= # (`tCYC2 - `tSCM )1'b1;
            cnt_msk_nr <= # (`tCYC2 + `tHCM )1'bx;
            cntrst_nr  <= # (`tCYC2 - `tSRST)1'b1;
            cntrst_nr  <= # (`tCYC2 + `tHRST)1'bx;            
            ads_nr     <= # (`tCYC2 - `tSAD )1'b0;
            ads_nr     <= # (`tCYC2 + `tHAD )1'bx;                              
            cnten_nr   <= # (`tCYC2 - `tSCN )1'b0;
            cnten_nr   <= # (`tCYC2 + `tHCN )1'bx;
         end
      end
   endtask // cnt_cmd
   
//-----------------------------   
   task wr_cnthld_l_port_c;
      begin      
         $display ("\n\t WRITE OPERATION WITH COUNTER HOLD FOR LEFT PORT\n");

         @(posedge clkl)
           load_cnt(`LEFT_T, Addr_l);
         @(posedge clkl)
           begin                         
              cnt_cmd(`LEFT_T, `WRITE_T, "HLD", Data_l);
           end     
      end
   endtask // wr_cnthld_l_port_c
   
//-----------------------------
      task rd_cnthld_l_port_c;
      begin      
         $display ("\n\t READ OPERATION WITH COUNTER HOLD FOR LEFT PORT\n");

         @(posedge clkl)
           begin                         
              cnt_cmd(`LEFT_T, `READ_T, "HLD", Data_l);
           end
         nop_l;
 
      end
   endtask // rd_cnthld_l_port_c
   
//-----------------------------   
   task wr_cnthld_r_port_c;
      begin      
         $display ("\n\t WRITE OPERATION WITH COUNTER HOLD FOR RIGHT PORT\n");

         @(posedge clkr)
           load_cnt(`RIGHT_T, Addr_r);
         @(posedge clkr)
           begin                         
              cnt_cmd(`RIGHT_T, `WRITE_T, "HLD", Data_r);
           end     
      end
   endtask // wr_cnthld_r_port_c
   
//-----------------------------
      task rd_cnthld_r_port_c;
      begin      
         $display ("\n\t READ OPERATION WITH COUNTER HOLD FOR RIGHT PORT\n");

         @(posedge clkr)
           begin                         
              cnt_cmd(`RIGHT_T, `READ_T, "HLD", Data_r);
           end
         nop_r;
 
      end
   endtask // rd_cnthld_r_port_c
   
//-----------------------------   

   task wr_burst_l_port_c;
      begin      
         $display ("\n\t BURST WRITE OPERATION FOR LEFT PORT\n");

         @(posedge clkl)
           begin
           load_cnt(`LEFT_T, Addr_l);
           end 
         begin: burst_loop1
            
            for (i=1; i<=30 ; i=i+1)
            begin            
                 @(posedge clkl)
                   begin                         
                      Addr_l = Addr_l + 1;  // needed for displaying the addr in msg
                      Data_l = Data_l + 1;
                      cnt_cmd(`LEFT_T, `WRITE_T, "INC", Data_l);
                   end     
            end
         end
      end     
   endtask // wr_burst_l_port_c

   task wr_burst_r_port_c;
      begin
         $display ("\n\t BURST WRITE OPERATION FOR RIGHT PORT\n");
         
         @(posedge clkr)
           load_cnt(`RIGHT_T, Addr_r);
         
         begin: burst_loop2
            for (i=1; i<=30 ; i=i+1)
            begin            
               @(posedge clkr)
                 begin                         
                    Data_r = Data_r + 1;
                    Addr_r = Addr_r + 1;  // needed for displaying the addr in msg
                    cnt_cmd(`RIGHT_T, `WRITE_T, "INC", Data_r);
                 end     
            end
            nop_r;
         end
      end     
   endtask // WR_BURST_R_PORT_C

  task wr_burst_l_port_c_count_2;
      begin      
         $display ("\n\t BURST WRITE OPERATION FOR LEFT PORT\n");
         @(posedge clkl)
           begin
           load_cnt(`LEFT_T, Addr_l);
           end 
         begin: burst_loop1
            
            for (i=1; i<=30 ; i=i+1)
            begin            
                 @(posedge clkl)
                   begin                         
                      Addr_l = Addr_l + 2;  // needed for displaying the addr in msg
                      Data_l = Data_l + 2;
                      cnt_cmd(`LEFT_T, `WRITE_T, "INC", Data_l);
                      
                   end     
            end
         end
      end     
   endtask // wr_burst_l_port_c_retransmit
   
   task rd_burst_l_port_c_count_2;
      begin      
         $display ("\n\t BURST READ OPERATION FOR LEFT PORT\n");         
         @(posedge clkl) begin
            load_cnt(`LEFT_T, Addr_l);
            Addr_l = Addr_l - 4 ; // needed for displaying the addr in msg
         end
         begin: burst_loop3
            
            for (i=1; i<=30 ; i=i+1)
            begin            
                 @(posedge clkl)
                   begin                         
                      Data_l = Data_l + 2;
                      Addr_l = Addr_l + 2;  // needed for displaying the addr in msg
                      cnt_cmd(`LEFT_T, `READ_T, "INC", Data_l);
                   end     
            end
            // needed for displaying the addr in msg
            #(`tCYC2);
            Addr_l = Addr_l + 2;  
            nop_l;
            nop_l;
            Addr_l = Addr_l + 2;              
            nop_l;            
         end
      end     
   endtask // RD_BURST_L_PORT_C_retransmit


  task wr_burst_r_port_c_count_2;
      begin      
         $display ("\n\t BURST WRITE OPERATION FOR RIGHT PORT\n");

         @(posedge clkr)
           begin
           load_cnt(`RIGHT_T, Addr_r);
           end 
         begin: burst_loop1
            
            for (i=1; i<=30 ; i=i+1)
            begin            
                 @(posedge clkr)
                   begin                         
                      Addr_r = Addr_r + 2;  // needed for displaying the addr in msg
                      Data_r = Data_r + 2;
                      cnt_cmd(`RIGHT_T, `WRITE_T, "INC", Data_r);
                      
                   end     
            end
         end
      end     
   endtask // wr_burst_l_port_c_retransmit
   
   task rd_burst_r_port_c_count_2;
      begin      
         $display ("\n\t BURST READ OPERATION FOR RIGHT PORT\n");
         @(posedge clkr) begin
            load_cnt(`RIGHT_T, Addr_r);
            Addr_r = Addr_r - 4 ; // needed for displaying the addr in msg
         end
         begin: burst_loop3
            
            for (i=1; i<=30 ; i=i+1)
            begin            
                 @(posedge clkr)
                   begin                         
                      Data_r = Data_r + 2;
                      Addr_r = Addr_r + 2;  // needed for displaying the addr in msg
                      cnt_cmd(`RIGHT_T, `READ_T, "INC", Data_r);
                   end     
            end
            // needed for displaying the addr in msg
            #(`tCYC2);
            Addr_r = Addr_r + 2;  
            nop_r;
            nop_r;
            Addr_r = Addr_r + 2;              
            nop_r;            
         end
      end     
   endtask // RD_BURST_L_PORT_C_retransmit


   task wr_burst_l_port_c_retransmit;
      begin      
         $display ("\n\t BURST WRITE OPERATION FOR LEFT PORT\n");
         @(posedge clkl)
           begin
              load_cnt(`LEFT_T, Addr_l);
           end 
         begin: burst_loop1
            
            for (i=1; i<=15 ; i=i+1)
            begin            
               @(posedge clkl)
                 begin       
                   	Addr_l = Addr_l + 1;  // needed for displaying the addr in msg
                    Data_l = Data_l + 1;
                    cnt_cmd(`LEFT_T, `WRITE_T, "INC", Data_l);
                    
 			        if(i == 14) 
    				  expected_CNTINT_l <= #(`tCYC2 + `tSCINT + 0.05) 1'b0;
        			if(i == 15)
             		  expected_CNTINT_l <= #(`tCYC2 + `tRCINT + 0.05) 1'b1;  
                 end     
            end
         end
      end     
   endtask // wr_burst_l_port_c_retransmit
   
   task rd_burst_l_port_c_retransmit;
      begin                 
         $display ("\n\t BURST READ OPERATION FOR LEFT PORT\n");
         @(posedge clkl) begin
      //      load_cnt(`LEFT_T, Addr_l);
            Addr_l = Addr_l - 2 ; // needed for displaying the addr in msg
         end
         begin: burst_loop3
            
            for (i=1; i<=15 ; i=i+1)
            begin            
                 @(posedge clkl)
                   begin                         
                     	 	Data_l = Data_l + 1;
                     		 Addr_l = Addr_l + 1;  // needed for displaying the addr in msg
      	              		 cnt_cmd(`LEFT_T, `READ_T, "INC", Data_l);
       				              			 if(i == 14) 
                        		   expected_CNTINT_l <= #(`tCYC2 *2 + `tSCINT + 0.05) 1'b0;
		                     			if(i == 15)
	                       		  expected_CNTINT_l <= #(`tCYC2 *2 + `tRCINT + 0.05) 1'b1;                        
                   end     
            end
            // needed for displaying the addr in msg
            #(`tCYC2);
            Addr_l = Addr_l + 1;  
            nop_l;
            nop_l;
            Addr_l = Addr_l + 1;              
            nop_l;            
         end
      end     
   endtask // RD_BURST_L_PORT_C_retransmit


  task wr_burst_r_port_c_retransmit;
      begin      
         $display ("\n\t BURST WRITE OPERATION FOR RIGHT PORT\n");
         @(posedge clkr)
           begin
           load_cnt(`RIGHT_T, Addr_r);
           end 
         begin: burst_loop1
            
            for (i=1; i<=15 ; i=i+1)
            begin            
                 @(posedge clkr)
                   begin                         
                      Addr_r = Addr_r + 1;  // needed for displaying the addr in msg
                      Data_r = Data_r + 1;
                      cnt_cmd(`RIGHT_T, `WRITE_T, "INC", Data_r);
                      
                       if(i == 14) 
                           expected_CNTINT_r <= #(`tCYC2 + `tSCINT + 0.05) 1'b0;
                       if(i == 15)
                           expected_CNTINT_r <= #(`tCYC2 + `tRCINT + 0.05) 1'b1;  

                   end     
            end
         end
      end     
   endtask // wr_burst_r_port_c_RETRANSMIT
   
   task rd_burst_r_port_c_retransmit;
      begin                
         $display ("\n\t BURST READ OPERATION FOR RIGHT PORT\n");         
         @(posedge clkr) begin
      //      load_cnt(`RIGHT_T, Addr_r);
            Addr_r = Addr_r - 2 ; // needed for displaying the addr in msg
         end
         begin: burst_loop3
            
            for (i=1; i<=15 ; i=i+1)
            begin            
                 @(posedge clkr)
                   begin                         
                      Data_r = Data_r + 1;
                      Addr_r = Addr_r + 1;  // needed for displaying the addr in msg
                      cnt_cmd(`RIGHT_T, `READ_T, "INC", Data_r);
                      if(i == 14) 
                           expected_CNTINT_r <= #(`tCYC2 *2 + `tSCINT + 0.05) 1'b0;
                      if(i == 15)
                           expected_CNTINT_r <= #(`tCYC2 *2 + `tRCINT + 0.05) 1'b1;  

                   end     
            end
            // needed for displaying the addr in msg
            #(`tCYC2);
            Addr_r = Addr_r + 1;  
            nop_r;
            nop_r;
            Addr_r = Addr_r + 1;              
            nop_r;            
         end
      end     
   endtask // RD_BURST_R_PORT_C_RETRANSMIT








//-----------------------------   
   task rd_burst_l_port_c;
      begin      
         $display ("\n\t BURST READ OPERATION FOR LEFT PORT\n");
         
         @(posedge clkl) begin
            load_cnt(`LEFT_T, Addr_l);
            Addr_l = Addr_l - 2 ; // needed for displaying the addr in msg
         end
         begin: burst_loop3
            
            for (i=1; i<=30 ; i=i+1)
            begin            
                 @(posedge clkl)
                   begin                         
                      Data_l = Data_l + 1;
                      Addr_l = Addr_l + 1;  // needed for displaying the addr in msg
                      cnt_cmd(`LEFT_T, `READ_T, "INC", Data_l);
                   end     
            end
            // needed for displaying the addr in msg
            #(`tCYC2);
            Addr_l = Addr_l + 1;  
            nop_l;
            nop_l;
            Addr_l = Addr_l + 1;              
            nop_l;            
         end
      end     
   endtask // RD_BURST_L_PORT_C
   

   task rd_burst_r_port_c;
      begin
         $display ("\n\t BURST READ OPERATION FOR RIGHT PORT\n");
         
         @(posedge clkr) begin
            load_cnt(`RIGHT_T, Addr_r);
            Addr_r = Addr_r - 2 ; // needed for displaying the addr in msg
         end
         begin: burst_loop4
            for (i=1; i<=30 ; i=i+1)
            begin            
               @(posedge clkr)
                 begin                         
                    Data_r = Data_r + 1;
                    Addr_r = Addr_r + 1;  // needed for displaying the addr in msg
                    cnt_cmd(`RIGHT_T, `READ_T, "INC", Data_r);
                 end     
            end
            // needed for displaying the addr in msg
            #(`tCYC2);
            Addr_r = Addr_r + 1;  
            nop_r;
            nop_r;
            Addr_r = Addr_r + 1;  
            nop_r;            
         end
      end     
   endtask // rd_burst_r_port_c
   

//---------------------------------------------------------------------------------------

   task nop_l;
      @(posedge clkl) begin
            r_w_nl     <= # (`tCYC2 - `tSW  )1'b1;   
            al_int     <= # (`tCYC2 - `tSA  )`ADDR_MSB_1'hz;
            ce1l       <= # (`tCYC2 - `tSC  )1'b0;
            ce0_nl     <= # (`tCYC2 - `tSC  )1'b1;
            b_nl       <= # (`tCYC2 - `tSB  )`BYTE_MSB_1'b1111;
            cnt_msk_nl <= # (`tCYC2 - `tSCM )1'b1;
            cntrst_nl  <= # (`tCYC2 - `tSRST)1'b1;
            ads_nl     <= # (`tCYC2 - `tSAD )1'b1;
            cnten_nl   <= # (`tCYC2 - `tSCN )1'b1;
      end
   endtask // nop_l

   task nop_r;
      @(posedge clkr) begin
            r_w_nr     <= # (`tCYC2 - `tSW  )1'b1;   
            ar_int     <= # (`tCYC2 - `tSA  )`ADDR_MSB_1'hz;
            ce1r       <= # (`tCYC2 - `tSC  )1'b0;
            ce0_nr     <= # (`tCYC2 - `tSC  )1'b1;
            b_nr       <= # (`tCYC2 - `tSB  )`BYTE_MSB_1'b1111;
            cnt_msk_nr <= # (`tCYC2 - `tSCM )1'b1;
            cntrst_nr  <= # (`tCYC2 - `tSRST)1'b1;
            ads_nr     <= # (`tCYC2 - `tSAD )1'b1;
            cnten_nr   <= # (`tCYC2 - `tSCN )1'b1;
         end
   endtask // nop_r
   

   task init_and_reset;
      begin
         `ifdef ZERODELAY
         $display("\t*******************************************************");
         $display("\t          START OF THE TEST BENCH                      ");
         $display("\t               FOR ZERO TIMING                         ");
         $display("\t*******************************************************");
         `else
         $display("\t*******************************************************");
         $display("\t       START OF THE TEST BENCH FOR 100 MHz CLOCK       ");
         $display("\t*******************************************************");
         `endif
         initialisation;         
         $display("\t-------- Master reset ---------\n");
         $display("\n\t vec. %0d. Reseting the device \n", vector);
         reset;                   // task for master reset. 
         #`MSGDLY;
         #`MSGDLY;
      end
   endtask


//---------------------------------------------------------------------------------------   

   
   task cmd_read;
      input port;
      input [`ADDR_MSB : 0] addr;
      input [`DATA_MSB : 0] data;
      input [`BYTE_MSB : 0] byte;
      begin
         case (port)
           `LEFT_PORT : begin
              @(posedge clkl) begin
                 dql_int <= #`tHD `DATA_MSB_1'bz;
                 ce0_nl <= # (`tCYC2 - `tSC) 1'b0;
                 b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
                 r_w_nl <= # (`tCYC2 - `tSW) 1'b1;
                 ce1l   <= # (`tCYC2 - `tSC) 1'b1;         
                 ads_nl <= # (`tCYC2 - `tSW) 1'b0;         
                 cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
                 cntrst_nl  <= #(`tCYC2 - `tSRST) 1'b1;
                 al_int <= # (`tCYC2 - `tSA) addr;
                 
                 ce0_nl <= # (`tCYC2 + `tHC) 1'b1;              //NOP command
                 b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'hx;
                 r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
                 ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
                 ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
                 cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
                 cntrst_nl <= #(`tCYC2 + `tHRST) 1'b1;
                 al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hx;
              end   
           end
           
           `RIGHT_PORT : begin
              @(posedge clkr) begin
                 dqr_int <= #`tHD `DATA_MSB_1'bz;
                 ce0_nr <= # (`tCYC2 - `tSC) 1'b0;
                 b_nr   <= # (`tCYC2 - `tSB) byte;
                 r_w_nr <= # (`tCYC2 - `tSW) 1'b1;
                 ce1r   <= # (`tCYC2 - `tSC) 1'b1;         
                 ads_nr <= # (`tCYC2 - `tSW) 1'b0;         
                 cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
                 cntrst_nr <= #(`tCYC2 - `tSRST) 1'b1;
                 ar_int <= # (`tCYC2 - `tSA) addr;

                 ce0_nr <= # (`tCYC2 + `tHC) 1'b1;              //NOP command
                 b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'hx;
                 r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
                 ce1r   <= # (`tCYC2 + `tHC) 1'b0;         
                 ads_nr <= # (`tCYC2 + `tHW) 1'b1;         
                 cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
                 cntrst_nr <= #(`tCYC2 + `tHRST) 1'b1;
                 ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hx;
              end
           end
         endcase // case(port)
      end
   endtask // cmd_read

   
   task cmd_write;
      input port;
      input [`ADDR_MSB : 0] addr;
      input [`DATA_MSB : 0] data;
      input [`BYTE_MSB : 0] byte;
      begin
         case (port)
           `LEFT_PORT : begin
              @(posedge clkl) begin
                 dql_int <= # (`tCYC2 - `tSD)data;
                 ce0_nl <= # (`tCYC2 - `tSC) 1'b0;
                 b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
                 r_w_nl <= # (`tCYC2 - `tSW) 1'b0;
                 ce1l   <= # (`tCYC2 - `tSC) 1'b1;         
                 ads_nl <= # (`tCYC2 - `tSW) 1'b0;         
                 cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
                 cntrst_nl  <= #(`tCYC2 - `tSRST) 1'b1;
                 al_int <= # (`tCYC2 - `tSA) addr;
                 
                 dql_int <= # (`tCYC2 + `tHD)`DATA_MSB_1'bz;  //NOP command
                 ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
                 b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'hx;
                 r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
                 ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
                 ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
                 cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
                 cntrst_nl <= #(`tCYC2 + `tHRST) 1'b1;
                 al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hx;
              end   
           end
           
           `RIGHT_PORT : begin
              @(posedge clkr) begin
                 dqr_int <= # (`tCYC2 - `tSD)data;
                 ce0_nr <= # (`tCYC2 - `tSC) 1'b0;
                 b_nr   <= # (`tCYC2 - `tSB) byte;
                 r_w_nr <= # (`tCYC2 - `tSW) 1'b0;
                 ce1r   <= # (`tCYC2 - `tSC) 1'b1;         
                 ads_nr <= # (`tCYC2 - `tSW) 1'b0;         
                 cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
                 cntrst_nr <= #(`tCYC2 - `tSRST) 1'b1;
                 ar_int <= # (`tCYC2 - `tSA) addr;
                 
                 dqr_int <= # (`tCYC2 + `tHD)`DATA_MSB_1'bz; //NOP command
                 ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
                 b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'hx;
                 r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
                 ce1r   <= # (`tCYC2 + `tHC) 1'b0;         
                 ads_nr <= # (`tCYC2 + `tHW) 1'b1;         
                 cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
                 cntrst_nr <= #(`tCYC2 + `tHRST) 1'b1;
                 ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hx;
              end
           end
         endcase // case(port)
      end
   endtask // cmd_write


   //-----------------------------------------------------------------------------------------------
   // task:        idle_l
   //
   // Description: Puts idle clock cycle at left port
   //-----------------------------------------------------------------------------------------------

   task idle_l;
      input num;
      integer num;
      begin
         repeat (num)
           @(posedge clkl);
      end
   endtask // idle


   //-----------------------------------------------------------------------------------------------
   // task:        idle_r
   //
   // Description: Puts idle clock cycle at right port
   //-----------------------------------------------------------------------------------------------

   task idle_r;
      input num;
      integer num;
      begin
         repeat (num)
           @(posedge clkr);
      end
   endtask // idle
   
   
   task mailbox_int_chk_l2r;
      begin      
         $display ("\n\t MAILBOX INTERRURT --  RIGHT PORT\n ");
         //cmd_write(port,    addr, data, byte);
         cmd_write(`LEFT_PORT, ~0,   1,     0);//Send Mail to RIGHT PORT
         //check_pin(pin, value, exp_value);
         int_check_r <=  #(1*`tCYC2 + `tSINT + 0.1) 1'b0;  // Check for interrupt  
         idle_r(1);

         //cmd_read(port, addr, data, byte);
         cmd_read(`RIGHT_PORT, ~0, 1,   0); //Read Mail
         int_check_r <=  #(1*`tCYC2 + `tRINT + 0.1) 1'b1;  //check for interrupt reset   
         @(posedge clkr)
           @(posedge clkr) begin
              data_check_r <= #(`tCKLZ ) `DATA_MSB_1'hx;
              data_check_r <= #(`tCD2  ) `DATA_MSB_1'h1;
                @(posedge clkr) begin                       //ashish
                   data_check_r <= #(`tCKHZ ) `DATA_MSB_1'hz;
                end
           end
         idle_r(3);
      end
   endtask // mailbox_int_chk_l2r
   
   task mailbox_int_chk_r2l;
      begin
         $display ("\n\t MAILBOX INTERRUPT --  LEFT PORT \n");
         vec  = vec + 1;
         //cmd_write(port,    addr, data, byte);
         cmd_write(`RIGHT_PORT, ~0-1,   2,     0);//Send Mail to RIGHT PORT
         int_check_l <=  #(1*`tCYC2 + `tSINT + 0.1) 1'b0;  // Check for interrupt  
         idle_l(1);

         //cmd_read(port, addr, data, byte);
         cmd_read(`LEFT_PORT, ~0-1, 2,   0); //Read Mail
         int_check_l <=  #(1*`tCYC2 + `tRINT + 0.1) 1'b1;  //check for interrupt reset   
         @(posedge clkl)
           @(posedge clkl)begin
              data_check_l <= #(`tCKLZ ) `DATA_MSB_1'hx;
              data_check_l <= #(`tCD2  ) `DATA_MSB_1'h2;
                @(posedge clkl) begin                         //ashish
                   data_check_l <= #(`tCKHZ ) `DATA_MSB_1'hz;
                end
           end
         idle_l(10);
      end
   endtask // mailbox_int_chk_r2l

   always @ (int_check_r) begin
      check_pin("INT_R", int_nr, int_check_r);
   end

   always @ (int_check_l) begin
      check_pin("INT_L", int_nl, int_check_l);
   end
   
//--------------------------------------------------------------------------------------------------

   //-----------------------------------------------------------------------------------------------
   // task:        cmd
   //
   // Description: General purpose task to apply any command.  
   //-----------------------------------------------------------------------------------------------

   
   task cmd;
      input port;
      input ce0_in;
      input ce1_in;
      input ads_in;
      input rw_in;
      input [`ADDR_MSB : 0] addr;
      input [`DATA_MSB : 0] data;
      input [`BYTE_MSB : 0] byte;
      input cnten_in;
      input cntrst_in;
      input cnt_msk_in;
      begin
         case (port)
           `LEFT_PORT : begin
              @(posedge clkl) begin
                 ce0_nl  <= # (`tCYC2 - `tSC) ce0_in;
                 ce1l    <= # (`tCYC2 - `tSC) ce1_in;         
                 ads_nl  <= # (`tCYC2 - `tSW) ads_in;         
                 r_w_nl  <= # (`tCYC2 - `tSW) rw_in;
                 al_int  <= # (`tCYC2 - `tSA) addr;
                 dql_int <= # (`tCYC2 - `tSD)data;
                 b_nl    <= # (`tCYC2 - `tSB) b_nl_reg;
                 cnten_nl    <= #(`tCYC2 - `tSCN ) cnten_in;
                 cntrst_nl   <= #(`tCYC2 - `tSRST) cntrst_in;
                 cnt_msk_nl <= #(`tCYC2 - `tSCM)  cnt_msk_in;
                 
                 ce0_nl  <= # (`tCYC2 + `tHC) 1'b1;
                 ce1l    <= # (`tCYC2 + `tHC) 1'b0;
                 ads_nl  <= # (`tCYC2 + `tHW) 1'b1;
                 r_w_nl  <= # (`tCYC2 + `tHW) 1'b1;
                 al_int  <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
                 dql_int <= # (`tCYC2 + `tHD) `DATA_MSB_1'bz;  //NOP command
                 b_nl    <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
                 cnten_nl   <= #(`tCYC2 + `tHCN ) 1'b1;
                 cntrst_nl  <= #(`tCYC2 + `tHRST) 1'b1;
                 cnt_msk_nl <= #(`tCYC2 + `tHCM) 1'b1;
              end   
           end
           
           `RIGHT_PORT : begin
              @(posedge clkr) begin
                 ce0_nr   <= # (`tCYC2 - `tSC) ce0_in;
                 ce1r     <= # (`tCYC2 - `tSC) ce1_in;         
                 ads_nr   <= # (`tCYC2 - `tSW) ads_in;         
                 r_w_nr   <= # (`tCYC2 - `tSW) rw_in;
                 ar_int   <= # (`tCYC2 - `tSA) addr;
                 dqr_int  <= # (`tCYC2 - `tSD) data;
                 b_nr     <= # (`tCYC2 - `tSB) byte;
                 cnten_nr    <= #(`tCYC2 - `tSCN ) cnten_in;
                 cntrst_nr   <= #(`tCYC2 - `tSRST) cntrst_in;
                 cnt_msk_nr <= #(`tCYC2 - `tSCM)  cnt_msk_in;
                 
                 ce0_nr  <= # (`tCYC2 + `tHC) 1'b1;
                 ce1r    <= # (`tCYC2 + `tHC) 1'b0;
                 ads_nr  <= # (`tCYC2 + `tHW) 1'b1;
                 r_w_nr  <= # (`tCYC2 + `tHW) 1'b1;
                 ar_int  <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
                 dqr_int <= # (`tCYC2 + `tHD) `DATA_MSB_1'bz;  //NOP command
                 b_nr    <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
                 cnten_nr   <= #(`tCYC2 + `tHCN ) 1'b1;
                 cntrst_nr  <= #(`tCYC2 + `tHRST) 1'b1;
                 cnt_msk_nr <= #(`tCYC2 + `tHCM) 1'b1;
              end
           end
         endcase // case(port)
      end
   endtask // cmd


   task x_violate_l;
      begin
         $display("\n\t CHECKING UNKNOWN VIOLATIONS FOR LEFT PORT PINS  \n ");
         //cmd(port, ce0, ce1, ads, rw, addr, data, byte, cnten, cntrst, cnt_msk)
         //rw = x
         cmd(`LEFT_PORT, 0, 1, 0, 1'bx, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1);
         //ce0_n = x
         cmd(`LEFT_PORT, 1'bx, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b11, 1, 1, 1);
         //ce1 = x
         cmd(`LEFT_PORT, 0, 1'bx, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b11, 1, 1, 1);
         //ads = x
         cmd(`LEFT_PORT, 0, 1, 1'bx, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 1'b1, 1, 1);
         //addr = x
         cmd(`LEFT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h3000x, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1);
         //data = x
         cmd(`LEFT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h00001202x, `BYTE_MSB_1'b00, 0, 1, 1);
         //byte = x
         cmd(`LEFT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'bxx, 0, 1, 1);
         //cnten = x
         cmd(`LEFT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 1'bx, 1, 1);
         //cntrst = x
         cmd(`LEFT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1'bx, 1);
         //cnt_msk = x
         cmd(`LEFT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1'bx);
         //oe = x
         cmd(`LEFT_PORT, 0, 1, 0, 1, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1);
         oe_nl <= #`tCYC2 1'bx;

         nop_l; // just to adjust the display msgs
         nop_l; // just to adjust the display msgs
      end
   endtask // x_violate_l

   task x_violate_r;
      begin
         $display("\n\t CHECKING UNKNOWN VIOLATIONS FOR RIGHT PORT PINS \n "); 
         //cmd(port, ce0, ce1, ads, rw, addr, data, byte, cnten, cntrst, cnt_msk)
         //rw = x
         cmd(`RIGHT_PORT, 0, 1, 0, 1'bx, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1);
         //ce0_n = x
         cmd(`RIGHT_PORT, 1'bx, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b11, 1, 1, 1);
         //ce1 = x
         cmd(`RIGHT_PORT, 0, 1'bx, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b11, 1, 1, 1);
         //ads = x
         cmd(`RIGHT_PORT, 0, 1, 1'bx, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 1, 1, 1);
         //addr = x
         cmd(`RIGHT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h3000x, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1);
         //data = x
         cmd(`RIGHT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h00001202x, `BYTE_MSB_1'b00, 0, 1, 1);
         //byte = x
         cmd(`RIGHT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'bxx, 0, 1, 1);
         //cnten = x
         cmd(`RIGHT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 1'bx, 1, 1);
         //cntrst = x
         cmd(`RIGHT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1'bx, 1);
         //cnt_msk = x
         cmd(`RIGHT_PORT, 0, 1, 0, 0, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1'bx);
         //oe = x
         cmd(`RIGHT_PORT, 0, 1, 0, 1, `ADDR_MSB_1'h30000, `DATA_MSB_1'h000012021, `BYTE_MSB_1'b00, 0, 1, 1);
         oe_nr <= #`tCYC2 1'bx;
         nop_r; // just to adjust the display msgs
         nop_r; // just to adjust the display msgs                  
      end
   endtask // x_violate_r
   
//-----------------------------------------------------------------------------------
`ifdef ZERODELAY
task check_data_lines;
      input [80 : 0] disp;
      input [`ADDR_MSB  : 0] actual_address; 
      input [`DATA_MSB  : 0] expected_data;
      input [`DATA_MSB  : 0] actual_data;
      begin
         if (expected_data === `DATA_MSB_1'hx) begin
         end
         else if (expected_data[8:0] === 9'hx) begin
         end
         else if (expected_data[17:9] === 9'hx) begin
         end

         else begin
         case (disp)
           "LEFT PORT" :  begin
              if (actual_data === expected_data) 
                $display ("%t\t Left Port Reading from the Address %h PASSED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
              else                                                                 
                begin 
                   $display ("%t\t Left Port Reading from the Address %h FAILED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
                   failed_tests = failed_tests + 1;
                end
           end
           
           "RIGHT PORT" :  begin
              if (actual_data === expected_data) 
                $display ("%t\t Right Port Reading from the Address %h PASSED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
              else
                begin 
                   $display ("%t\t Right Port Reading from the Address %h FAILED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
                   failed_tests = failed_tests + 1;
                end  
           end
           default :
             $display("%t\t Internal Error of Testbench", $realtime);
         endcase // case(disp)
      end
      end
endtask // check_data_lines
`else
   task check_data_lines;
      input [80 : 0] disp;
      input [`ADDR_MSB  : 0] actual_address; 
      input [`DATA_MSB  : 0] expected_data;
      input [`DATA_MSB  : 0] actual_data;
      begin
         case (disp)
           "LEFT PORT" :  begin
              if (actual_data === expected_data) 
                  if(actual_data === `DATA_MSB_1'hx)
                    #0.001;
                  else           
                    $display ("%t\t Left Port Reading from the Address %h PASSED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
              else                                                                 
                begin 
                   $display ("%t\t Left Port Reading from the Address %h FAILED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
                   failed_tests = failed_tests + 1;
                end
           end
           
           "RIGHT PORT" :  begin
              if (actual_data === expected_data) 
                  if(actual_data === `DATA_MSB_1'hx)
                    #0.001;
                  else           
                    $display ("%t\t Right Port Reading from the Address %h PASSED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
              else                                                                 
                begin 
                   $display ("%t\t Right Port Reading from the Address %h FAILED : Expected Data  = %h Actual Data = %h ",$realtime,actual_address,expected_data,actual_data);
                   failed_tests = failed_tests + 1;
                end  
           end
           default :
             $display("%t\t Internal Error of Testbench", $realtime);
         endcase // case(disp)
      end
endtask // check_data_lines
`endif   

task check_msk_lines;
      input [80 : 0] disp;
      input [`ADDR_MSB  : 0] expected_Addr;
      input [`ADDR_MSB  : 0] actual_Addr;
      begin
         case (disp)
           "LEFT PORT" : begin
              if (actual_Addr === expected_Addr)
                $display ("%t\t Left Port Mask Read Back PASSED : Expected Address = %h Actual Address = %h  ",$realtime,expected_Addr,actual_Addr);
              else                                                                  
                begin
                   $display ("%t\t Left Port Mask Read Back FAILED : Expected Address  = %h Actual Address = %h ",$realtime,expected_Addr,actual_Addr);
                   failed_tests = failed_tests + 1;
                end
           end
           "RIGHT PORT" : begin
              if (actual_Addr === expected_Addr)
                $display ("%t\t Right Port Mask Read Back PASSED : Expected Address = %h Actual Address = %h  ",$realtime,expected_Addr,actual_Addr);
              else                                                                  
                begin 
                   $display ("%t\t Right Port Mask Read Back FAILED : Expected Address = %h Actual Address = %h ",$realtime,expected_Addr,actual_Addr);
                   failed_tests = failed_tests + 1;
                end
           end
           default:
             $display("%t\t Internal Error of Testbench", $realtime);
         endcase // case(disp)
      end
      
endtask 

   task check_cnt_lines;
      input [80 : 0] disp;
      input [`ADDR_MSB  : 0] expected_Addr;
      input [`ADDR_MSB  : 0] actual_Addr;
      begin
         case (disp)
           "LEFT PORT" : begin
              if (actual_Addr === expected_Addr)
                $display ("%t\t Left Port Counter Read Back PASSED : Expected Address = %h Actual Address = %h  ",$realtime,expected_Addr,actual_Addr);
              else                                                                  
                begin 
                   $display ("%t\t Left Port Counter Read Back FAILED : Expected Address = %h Actual Address = %h ",$realtime,expected_Addr,actual_Addr);
                   failed_tests = failed_tests + 1;
                end
           end
           "RIGHT PORT" : begin
              if (actual_Addr === expected_Addr)
                $display ("%t\t Right Port Counter Read Back PASSED : Expected Address = %h Actual Address =%h  ",$realtime,expected_Addr,actual_Addr);
              else                                                                  
                begin 
                   $display ("%t\t Right Port Counter Read Back FAILED : Expected Address = %h Actual Address = %h ",$realtime,expected_Addr,actual_Addr);
                   failed_tests = failed_tests + 1;
                end
           end
           default:
             $display("%t\t Internal Error of Testbench", $realtime);           
         endcase // case(disp)
      end
      
endtask 

   task check_read_l_data;// one clock pulse to be given before execution 
      begin
         @(posedge clkl)
           @(posedge clkl)begin
`ifdef ZERODELAY
              data_check_l <= #`tCKHZ `DATA_MSB_1'hzzzzzzzzz;
              data_check_l <= #`tCD2 d_check_l;
`else
              
              data_check_l <= #`tCKHZ `DATA_MSB_1'hzzzzzzzzz;
              data_check_l <= #`tDC   d_check_l_x;
              data_check_l <= #`tCD2 d_check_l;
`endif
           end
      end
    endtask // check_l_data

    task check_read_r_data;
       begin
          @(posedge clkr)
            @(posedge clkr)begin
`ifdef ZERODELAY
               data_check_r <= #`tCKHZ `DATA_MSB_1'hzzzzzzzzz;
               data_check_r <= #`tCD2 d_check_r;
`else
               data_check_r <= #`tCKHZ `DATA_MSB_1'hzzzzzzzzz;
               data_check_r <= #`tDC   d_check_r_x;
               data_check_r <= #`tCD2  d_check_r;
`endif
            end
       end
    endtask // check_read_r_data
    task read_l_2_oe;// 2 consecutive read to left port with OE 
       begin
          @(posedge clkl) begin//1st read
             ce0_nl <= # (`tCYC2 - `tSC) 1'b0;
             b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
             r_w_nl <= # (`tCYC2 - `tSW) 1'b1;
             ce1l   <= # (`tCYC2 - `tSC) 1'b1;         //not given in the waveform
             ads_nl <= # (`tCYC2 - `tSW) 1'b0;         //not given in the waveform
             cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
             al_int <= # (`tCYC2 - `tSA) Addr_l;//`ADDR_MSB_1'h00001;
             ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
             b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
             r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
             ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
             oe_nl <= 1'b0;                               
             ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
             cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
             cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
             al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
          end
          @(posedge clkl) begin// 2nd read
             ce0_nl <= # (`tCYC2 - `tSC) 1'b0;
             b_nl   <= # (`tCYC2 - `tSB) b_nl_reg;
             r_w_nl <= # (`tCYC2 - `tSW) 1'b1;
             ce1l   <= # (`tCYC2 - `tSC) 1'b1;         //not given in the waveform
             ads_nl <= # (`tCYC2 - `tSW) 1'b0;         //not given in the waveform
             cnten_nl  <= #(`tCYC2 - `tSCN ) 1'b0;
             al_int <= # (`tCYC2 - `tSA) Addr_l;//`ADDR_MSB_1'h00001;
             ce0_nl <= # (`tCYC2 + `tHC) 1'b1;
             b_nl   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
             r_w_nl <= # (`tCYC2 + `tHW) 1'b1;
             ce1l   <= # (`tCYC2 + `tHC) 1'b0;         
             oe_nl <= 1'b0;                               
             ads_nl <= # (`tCYC2 + `tHW) 1'b1;         
             cnten_nl  <= #(`tCYC2 + `tHCN ) 1'b1;
             cnt_msk_nl<= #(`tCYC2 + `tHCM ) 1'b1;
             al_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;// this checks for the 1st read
             check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hz,dql);
             #`tCKLZ check_data_lines("LEFT PORT",Addr_l,`DATA_MSB_1'hx,dql);
             #(`tCD2 - `tCKLZ )check_data_lines("LEFT PORT",Addr_l,d_check_l,dql);
          end
          @(posedge clkl) begin
             // this checks for the 1st read
             #`tDC check_data_lines("LEFT PORT",Addr_l,d_check_l,dql);
             // given oe here
             $display ("\t LEFT PORT READING WITH OE CONTROLLED");
             data_check_l <= #`tCKLZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_l <= #`tDC   `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_l <= #`tCD2  d_check_l;
             oe_nl <= 1'b0;                          
             #`INIT_DELAY_OE
               oe_nl <= 1'b1;          
             oe_nl <= #`tOHZ 1'b0;
             data_check_l <= # `tOHZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_l <= # (`tOHZ + `tOLZ)`DATA_MSB_1'hxxxxxxxxx;
          end   
       end
    endtask // read_l_2_oe

    task read_r_2_oe;// 2 consecutive read to RIGHT  port with OE 
       begin
          @(posedge clkr) begin//1st read
             ce0_nr <= # (`tCYC2 - `tSC) 1'b0;
             b_nr   <= # (`tCYC2 - `tSB) b_nr_reg;
             r_w_nr <= # (`tCYC2 - `tSW) 1'b1;
             ce1r   <= # (`tCYC2 - `tSC) 1'b1;         //not given in the waveform
             ads_nr <= # (`tCYC2 - `tSW) 1'b0;         //not given in the waveform
             cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
             ar_int <= # (`tCYC2 - `tSA) Addr_r;//`ADDR_MSB_1'h00001;
             ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
             b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
             r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
             ce1r   <= # (`tCYC2 + `tHC) 1'b0;         //not given in the waveform
             ads_nr <= # (`tCYC2 + `tHW) 1'b1;         //not given in the waveform   
             cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
             ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
          end
          @(posedge clkr) begin// 2nd read
             ce0_nr <= # (`tCYC2 - `tSC) 1'b0;
             b_nr   <= # (`tCYC2 - `tSB) b_nr_reg;
             r_w_nr <= # (`tCYC2 - `tSW) 1'b1;
             ce1r   <= # (`tCYC2 - `tSC) 1'b1;         //not given in the waveform
             ads_nr <= # (`tCYC2 - `tSW) 1'b0;         //not given in the waveform
             cnten_nr  <= #(`tCYC2 - `tSCN ) 1'b0;
             ar_int <= # (`tCYC2 - `tSA) Addr_r;//`ADDR_MSB_1'h00001;
             ce0_nr <= # (`tCYC2 + `tHC) 1'b1;
             b_nr   <= # (`tCYC2 + `tHB) `BYTE_MSB_1'b1111;
             r_w_nr <= # (`tCYC2 + `tHW) 1'b1;
             ce1r   <= # (`tCYC2 + `tHC) 1'b0;         //not given in the waveform
             ads_nr <= # (`tCYC2 + `tHW) 1'b1;         //not given in the waveform   
             cnten_nr  <= #(`tCYC2 + `tHCN ) 1'b1;
             ar_int <= # (`tCYC2 + `tHA) `ADDR_MSB_1'hz;
             // this checks for the 1st read
             check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hz,dqr);
             #`tCKLZ check_data_lines("RIGHT PORT",Addr_r,`DATA_MSB_1'hx,dqr);
             #(`tCD2 - `tCKLZ )check_data_lines("RIGHT PORT",Addr_r,d_check_r,dqr);
          end
          @(posedge clkr) begin
             // this checks for the 1st read
             #`tDC check_data_lines("RIGHT PORT",Addr_r,d_check_r,dqr);
             // given oe here
             $display ("\tRIGHT  PORT READING WITH OE CONTROLLED");
             data_check_r <= #`tCKLZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_r <= #`tDC   `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_r <= #`tCD2  d_check_r;
             oe_nr <= 1'b0;                          
             #`INIT_DELAY_OE
               oe_nr <= 1'b1;          
             oe_nr <= #`tOHZ 1'b0;
             data_check_r <= # `tOHZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_r <= # (`tOHZ + `tOLZ)`DATA_MSB_1'hxxxxxxxxx;
          end   
       end
    endtask // read_r_2_oe
    task read_l_2;
       begin
          @(posedge clkl) begin
             read_l_signal;
          end
          @(posedge clkl) begin
             Addr_l = Addr_l + 1;
             read_l_signal;
          end
          @(posedge clkl) begin
             Addr_l = Addr_l - 1;
             data_check_l <= #`tCKLZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_l <= #`tDC   `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_l <= #`tCD2  d_check_l;
          end
          @(posedge clkl) begin
             Addr_l = Addr_l + 1; 
             data_check_l <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
             data_check_l <= #`tCKLZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_l <= #`tDC   `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_l <= #`tCD2  d_check_l + 1;
          end
          @(posedge clkl) 
            data_check_l <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
       end
    endtask // read_l_2

    task read_r_2;
       begin
          @(posedge clkr) begin
             read_r_signal;
          end
          @(posedge clkr) begin
             Addr_r = Addr_r + 1;
             read_r_signal;
          end
          @(posedge clkr) begin
             Addr_r = Addr_r - 1;
             data_check_r <= #`tCKLZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_r <= #`tDC   `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_r <= #`tCD2  d_check_r;
          end
          @(posedge clkr) begin
             Addr_r = Addr_r + 1;
             data_check_r <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
             data_check_r <= #`tCKLZ `DATA_MSB_1'hzzzzzzzzz;
             data_check_r <= #`tDC   `DATA_MSB_1'hxxxxxxxxx;                                  
             data_check_r <= #`tCD2  d_check_r + 1;
          end
          @(posedge clkr) 
            data_check_r <= #`tDC `DATA_MSB_1'hxxxxxxxxx;
       end
    endtask // read_r_2
