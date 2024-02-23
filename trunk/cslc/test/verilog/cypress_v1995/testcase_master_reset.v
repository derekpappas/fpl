
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
// File          : testcase_master_reset.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for verifying the master reset operation and
// master reset de-assertion operation
// *******************************************************************

 // READY# signal assertion checking for left port
 
 task test_ready_assert_l;

  integer count;
  begin

    if((ileft_cqen == 1'b0) && (ileft_zq == 1'b1) && (inleft_lowspd == 1'b0))
    begin
      for(count = 0; count <= TP.tLOWLOCKTIME;count=count+1)
      begin
        @(posedge ileft_clk);
      end
    end
    else
    begin
      for(count = 0; count <= TP.tHIGHLOCKTIME ;count=count+1)
      begin
        @(posedge ileft_clk);
      end
    end
      
    if(onleft_ready == 1'b0)
    begin
      if(nmsg == 1'b1)$display("TEST PASSED: Left port READY# asserted at proper time");
    end
    else
    begin
      if(nmsg == 1'b1)$display("TEST FAILED: Left port READY# not asserted");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end
  end
 endtask


 // READY# signal assertion checking for left port
 
 task test_ready_assert_r;

  integer count;
  begin

    if((iright_cqen == 1'b0) && (iright_zq == 1'b1) && (inright_lowspd == 1'b0))
    begin
      for(count = 0; count <= TP.tLOWLOCKTIME;count=count+1)
      begin
        @(posedge iright_clk);
      end
    end
    else
    begin
      for(count = 0; count <= TP.tHIGHLOCKTIME;count=count+1)
      begin
        @(posedge iright_clk);
      end
    end

    if(onright_ready == 1'b0)
    begin
      if(nmsg == 1'b1)$display("TEST PASSED: Right port READY# asserted at proper time");
    end
    else
    begin
      if(nmsg == 1'b1)$display("TEST FAILED: Right port READY# not asserted");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end
  end
 endtask


 // Testcase for testing the reset operation
 
 task basic_reset_test;

   integer count;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--              Basic Reset Testing                  --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;

    for(count = 0; count <= 1; count = count + 1)
    begin
      if(count == 0) 
      begin
        ileft_cqen  = 1'b1;
	iright_cqen = 1'b1;
      end
      else
      begin
        ileft_cqen  = 1'b0;
	iright_cqen = 1'b0;
      end
     
      #50;
      inmrst = 1'b0;
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #1;

      if(onleft_ready === 1'b1)
      begin
        if(nmsg == 1'b1)$display("TEST PASSED: Left Port READY# output De-asserted");
      end
      else
      begin
        if(nmsg == 1'b1)$display($realtime, " TEST FAILED: Left Port READY# output not de-asserted");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end

      if(onright_ready === 1'b1)
      begin
        if(nmsg == 1'b1)$display("TEST PASSED: Right Port READY# output De-asserted");
      end
      else
      begin      
        if(nmsg == 1'b1)$display("TEST FAILED: Right Port READY# output not de-asserted");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end    


      if(onleft_int == 1'b1)
      begin                        
        if(nmsg == 1'b1)$display("TEST PASSED: Left port interrupt signal de-asserted state");
      end        
      else
      begin                              
        if(nmsg == 1'b1)$display("TEST FAILED: Left port interrupt signal not de-asserted");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end

      if(onright_int == 1'b1)
      begin                              
         if(nmsg == 1'b1)$display("TEST PASSED: Right port interrupt signal de-asserted state");
      end            
      else
      begin                                    
        if(nmsg == 1'b1)$display("TEST FAILED: Right port interrupt signal not de-asserted");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end

      if(onleft_cntint == 1'b1)
      begin                                          
        if(nmsg == 1'b1)$display("TEST PASSED: Left port counter interrupt de-asserted");
      end
      else
      begin                                                
        if(nmsg == 1'b1)$display("TEST FAILED: Left port counter interrupt not de-asserted");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end    

      if(onright_cntint == 1'b1)
      begin                                                      
        if(nmsg == 1'b1)$display("TEST PASSED: Right port counter interrupt de-asserted");
      end
      else
      begin                                                      
        if(nmsg == 1'b1)$display("TEST FAILED: Right port counter interrupt not de-asserted");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end

      if(onleft_busy === 1'bZ)
      begin                                                            
        if(nmsg == 1'b1)$display("TEST PASSED: Left port busy signal tri-stated");
      end
      else
      begin                                                            
        if(nmsg == 1'b1)$display("TEST FAILED: Left port busy signal not tri-stated");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end

      if(onright_busy === 1'bZ)
      begin                                                                  
        if(nmsg == 1'b1)$display("TEST PASSED: Right port busy signal tri-stated");
      end    
      else
      begin                                                                  
        if(nmsg == 1'b1)$display("TEST FAILED: Right port busy signal not tri-stated");
        failed_flag       = 1'b1;
        failed_flag_local = 1'b1;
      end

      #60;                   
      inmrst = 1'b1;
    
      fork
        test_ready_assert_l;
        test_ready_assert_r;
      join
    end
    report_test_result("basic_reset_test");
  end
 endtask


 // Testcase for Counter Reset Reset Operation 
 // Upon Master Reset  For Left Port        

 task master_reset_counter_test_l;

  begin

    configure_device_sdr2;
    inleft_ce0  = 1'b1;
    ileft_ce1   = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Counter Reset Reset Operation      --");
    if(nmsg == 1'b1)$display("--             Upon Master Reset                     --");
    if(nmsg == 1'b1)$display("--               For Left Port                       --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_l;
    counter_readback_l;

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l({`CYP_ADDRWIDTH{1'b0}});

    @(posedge ileft_clk);

    #(TP.tHAC_l);
    randomdata_72bit(rand_temp_data);
    counter_load_l(rand_temp_data[`CYP_ADDRWIDTH-1:0]);

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    a_rw_l = `CYP_ADDRWIDTH'bZ;

    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    enable_readback_op_l;
    counter_readback_l;

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l({`CYP_ADDRWIDTH{1'b0}});
    inleft_ce0     = 1'b1;
    report_test_result("master_reset_counter_test_l");
  end
 endtask


 // Testcase for Counter Reset Reset Operation 
 // Upon Master Reset For Right Port   
 
 task master_reset_counter_test_r;

  begin

    configure_device_sdr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Counter Reset Reset Operation      --");
    if(nmsg == 1'b1)$display("--             Upon Master Reset                     --");
    if(nmsg == 1'b1)$display("--               For Right Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_r;
    counter_readback_r;

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r({`CYP_ADDRWIDTH{1'b0}});

    @(posedge iright_clk);

    #(TP.tHAC_r);
    randomdata_72bit(rand_temp_data);
    counter_load_r(rand_temp_data[`CYP_ADDRWIDTH-1:0]);

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    a_rw_r = `CYP_ADDRWIDTH'bZ;

    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    enable_readback_op_r;
    counter_readback_r;

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r({`CYP_ADDRWIDTH{1'b0}});
    inright_ce0     = 1'b1;
    report_test_result("master_reset_counter_test_r");
  end
 endtask


 // Testcase for Mask Register Reset Operation     
 // Upon Master Reset  For Left Port 

 task master_reset_mask_test_l;

  begin

    configure_device_sdr2;
    inleft_ce0   = 1'b1;
    ileft_ce1    = 1'b0;
    counter_hold_l;
    master_reset;

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Mask Register Reset Operation      --");
    if(nmsg == 1'b1)$display("--             Upon Master Reset                     --");
    if(nmsg == 1'b1)$display("--               For Left Port                       --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_l;
    mask_readback_l;

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l({`CYP_ADDRWIDTH{1'b1}});

    @(posedge ileft_clk);

    #(ileft_clk_period - TP.tSAC_l);
    mask_load_l({`CYP_ADDRWIDTH{1'b0}});

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    a_rw_l = `CYP_ADDRWIDTH'bZ;

    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    enable_readback_op_l;
    mask_readback_l;

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l({`CYP_ADDRWIDTH{1'b1}});
    inleft_ce0     = 1'b1;
    report_test_result("master_reset_mask_test_l");
  end
 endtask


 // Testcase for Mask Register Reset Operation  
 // Upon Master Reset  For Right Port  
 
 task master_reset_mask_test_r;

  begin

    configure_device_sdr2;
    inright_ce0   = 1'b1;
    iright_ce1    = 1'b0;
    counter_hold_r;
    master_reset;

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Mask Register Reset Operation      --");
    if(nmsg == 1'b1)$display("--             Upon Master Reset                     --");
    if(nmsg == 1'b1)$display("--               For Right Port                       --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_r;
    mask_readback_r;

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r({`CYP_ADDRWIDTH{1'b1}});

    @(posedge iright_clk);

    #(iright_clk_period - TP.tSAC_r);
    mask_load_r({`CYP_ADDRWIDTH{1'b0}});

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    a_rw_r = `CYP_ADDRWIDTH'bZ;

    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    enable_readback_op_r;
    mask_readback_r;

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r({`CYP_ADDRWIDTH{1'b1}});
    inright_ce0     = 1'b1;
    report_test_result("master_reset_mask_test_r");
  end
 endtask

 
 // Testcase for Mirrror Register Reset Operation 
 // Upon Master Reset For Left Port      

 task master_reset_mirror_reg_test_l;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Mirror Register Reset Operation    --");
    if(nmsg == 1'b1)$display("--               Upon Master Reset                   --");
    if(nmsg == 1'b1)$display("--                 For Left Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0   = 1'b1;
    ileft_ce1    = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};
    retransmit_1_l;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    enable_readback_op_l;
    counter_readback_l;

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l({`CYP_ADDRWIDTH{1'b0}});

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    randomdata_72bit(rand_temp_data);
    counter_load_l(rand_temp_data[`CYP_ADDRWIDTH-1:0]); 

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 


    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};  
    retransmit_1_l;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 

    enable_readback_op_l;  
    counter_readback_l;  
  
    @(posedge ileft_clk);  
    #(ileft_clk_period - TP.tSAC_l);  
    counter_hold_l;  
  
    @(posedge ileft_clk);  
    @(posedge ileft_clk);  
  
    compare_readback_result_l({`CYP_ADDRWIDTH{1'b0}});  

    @(posedge ileft_clk);
    #10;
    report_test_result("master_reset_mirror_reg_test_l");
  end
 endtask


 // Testcase for Mirror Register Reset Operation 
 // Upon Master Reset For Right Port 
    
 task master_reset_mirror_reg_test_r;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Mirror Register Reset Operation    --");
    if(nmsg == 1'b1)$display("--             Upon Master Reset                     --");
    if(nmsg == 1'b1)$display("--               For Right Port                       --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0   = 1'b1;
    iright_ce1    = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};
    retransmit_1_r;
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    enable_readback_op_r;
    counter_readback_r;

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r({`CYP_ADDRWIDTH{1'b0}});

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    randomdata_72bit(rand_temp_data);
    counter_load_r(rand_temp_data[`CYP_ADDRWIDTH-1:0]);

    @(posedge iright_clk);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};  
    retransmit_1_r;
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    enable_readback_op_r;  
    counter_readback_r;  
  
    @(posedge iright_clk);  
    #(iright_clk_period - TP.tSAC_r);  
    counter_hold_r;  
  
    @(posedge iright_clk);  
    @(posedge iright_clk);  
  
    compare_readback_result_r({`CYP_ADDRWIDTH{1'b0}});  

    @(posedge iright_clk);
    #10;
    report_test_result("master_reset_mirror_reg_test_r");
  end
 endtask



 //  Testcase for testing Reset operation violating
 //  master reset pulse width requirement
 //  This testcase is not self testing. Model will
 //  display the error message Reset pulse width
 //  is less than tRS. Model not reseted'
 
 task reset_violate_tRS;

  begin

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("-- Testcase for testing Reset operation violating  --");
    if(nmsg == 1'b1)$display("--      master reset pulse width requirement       --");
    if(nmsg == 1'b1)$display("--  This testcase is not self testing. Model will  --");
    if(nmsg == 1'b1)$display("--  display the error message Reset pulse width   --");
    if(nmsg == 1'b1)$display("--      is less than tRS. Model not reseted'       --");
    if(nmsg == 1'b1)$display("------------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    master_reset;
    
    #200;
    inmrst = 1'b0;
    #5;
    inmrst = 1'b1;
    #100;
  end
 endtask 
