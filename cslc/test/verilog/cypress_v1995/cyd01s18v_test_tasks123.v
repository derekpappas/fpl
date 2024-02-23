// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name :  cyd01s18v_test_tasks.v
// Version : 0.1
// Status : Module is Complete
// -----------------------------------------------------------------------------
// Author : Ashlesha Gokhale
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date : May, 12, 2003
// -----------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : May 12, 2003
// -----------------------------------------------------------------------------
// Dependencies :  cyd01s18v_test_defines.v
// Description  : This file contains tasks  require for test bench.
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl.
// Terms & concepts : 
// Open issues and future enhancements : None
// References : 
// Revision History :
// Rev  Author    Phone           Date           Changes
// -----------------------------------------------------------------------------
//0.1   Ashlesha  2933700.2074    12.05.2003       New file
//1.0                             16.05.2003       Added local variable rslt_reg in 
//                                                 fill_result_array task.                 
//1.1                             20.06.2003       Added function check_x_z to check
//                                                 if expected data is x or z                 
//-----------------------------------------------------------------------------

//************************************************************************************
// Task         : Initialization
// Author       : Ashlesha Gokhale
// Description  : This task initializes all the test bench variables
//                
//Modification:
//
//
//
//************************************************************************************


task initialize;
begin

    // This is initialization of all variable, inputs     
    `ifdef GENVCD
         $dumpvars();                          // This stores all the variables of the module and 
         $dumpfile("cyd01s18v.vcd");         //submodules to cyd01s18v.vcd file which can used to 
       
    `endif                                               // check the waveform  later.  
    
    clkl = 1'b0;                          //both clocks are inititalized to 0.
    clkr = 1'b0;     
    al_int = `AD_S'b0;                           // left port adddress is initialized to 0.  
    ar_int  = `AD_S'b1;                           // right port address initialized to 1.   
    dql_int = `DT_S'bx;                      // both data buses are tri-stated initially   
    dqr_int = `DT_S'bx;                       
    oe_nl = 'b1;                          // oe is inactive
    oe_nr = 'b1;
    r_w_nl = 'b1;                         // R/W_n is driven to 1 indicating read operation 
    r_w_nr = 'b1;
    b_nl= 'h0;                            //All byte are enabled 
    b_nr = 'h0;
    mrst_n = 1'b1;                        //Master reset initialized to 1. 
    rslt_wr_ptr_l = 0;
    rslt_wr_ptr_r = 0;
    rslt_rd_ptr_l = 0;
    rslt_rd_ptr_r = 0;
    test_control_reg = 41'h0;
    addr_cntrl_l = 1'b0;
    addr_cntrl_r = 1'b0;
    ce0_nl = 1'b0;
    ce1_l = 1'b1;
    ads_nl = 1'b0;
    cnten_nl = 1'b0;
    cntrst_nl = 1'b1;
    cnt_msk_nl = 1'b1;
    ce0_nr = 1'b0;
    ce1_r = 1'b1;
    ads_nr = 1'b0;
    cnten_nr = 1'b0;
    cntrst_nr = 1'b1;
    cnt_msk_nr = 1'b1;
end 
endtask // initialize


//************************************************************************************
// Task         : Master Reset
// Author       : Ashlesha Gokhale
// Description  : This task perform master reset operation
//                
//Modification:
//
//
//
//************************************************************************************


task MasterReset;
reg[145:0] rslt_reg;     
begin
    `ifdef TSTDBG 
        $display(" Task Master Reset  Started  at time %t", $realtime);     
    `endif
    rslt_wr_ptr_r = 0;                                 
    rslt_wr_ptr_l = 0;
    rslt_rd_ptr_r = 0;                                 
    rslt_rd_ptr_l = 0;                                 
    for (i= 0; i <= 15; i = i+1)
        rslt[i] = 145'bz;
    // Cheks all outputs at inactive state after the reset
    if (power_on_reset) begin  
        rslt_reg[`LEFT_DATA] = `DT_S'hz;
        rslt_reg[`RIGHT_DATA] = `DT_S'hz;
        rslt[rslt_wr_ptr_l] = rslt_reg;
        rslt_wr_ptr_r = rslt_wr_ptr_r +1;                                       
        rslt_wr_ptr_l = rslt_wr_ptr_l +1;
    end
    test_control_reg[`LEFT_INTR] = 1'b1;
    test_control_reg[`RIGHT_INTR] = 1'b1;
    x_event_f = 1'b0;
    get_next_data = 1'b1;
    x_event_f_r = 1'b0;
    get_next_data_r = 1'b1;
    
    
    #`RESET_SETUP_TIME;                   // Wait for time more than required reset setup time 
    mrst_n = 1'b0;                        // Master reset is asserted
    dql_int = `DT_S'bz;
    dqr_int = `DT_S'bz;
    reset_over_test = 1'b1;                   // reset_over flag is set to indicate completion of
    #`RESET_PULSE_WIDTH;                  // wait for time greater that required reset pulse width
    
    //repeat(`RESET_PULSE_WIDTH)
    // @(posedge clkl);     
    mrst_n = 1'b1;                        // Master reset is de-aaserted
    
    #`RESET_RECOVERY_TIME;                // wait for reset recovert time.     
    `ifdef TSTDBG 
           $display(" Task Master Reset Ended at time %t", $realtime);     
    `endif
       
end   
endtask // master_reset


//************************************************************************************
// Task         :WriteLeft
// Author       : Ashlesha Gokhale
// Description  :
//Modification:
//
//
//
//************************************************************************************

task WriteLeft; 
input [`AD_M:0] address;
input [7:0]  byte_enable;
input [`DT_M:0] data;
reg  [145:0] rslt_reg; 
begin
    `ifdef TSTDBG 
     $display(" Task WriteLeft Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif
  
    @(posedge clkl);
    fork
        begin
            wait_drive_time(`CE_L);
            ce0_nl =  1'b0  ;
        end 
        begin
            wait_drive_time(`ADS_L);
            ads_nl =  1'b0 ;
        end 
        begin
            wait_drive_time(`CNTEN_L);
            cnten_nl =  1'b0 ;
        end  
        begin
            wait_drive_time(`CNTRST_L);
            cntrst_nl =  1'b1 ;
        end
        begin  
            wait_drive_time(`CNT_MSK_L);
            cnt_msk_nl=  1'b1 ;
        end  
        begin
            wait_drive_time (`CE_L);
            ce1_l =  1'b1 ; 
        end  
        // driving Rd/Wr signal for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1)
            r_w_nl = #`HOLD_VIOLATION_TIME 1'b0;
        else if (test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            r_w_nl = 1'b0;                         
        end else begin
            #`SAFE_TIME;   
            r_w_nl = 1'b0;                         
        end 
        // driving Address for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
            al_int = #`HOLD_VIOLATION_TIME address;
        else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            al_int = address;
        end else begin
            #`SAFE_TIME;
            al_int = address;
        end  

        // driving Byte Enable signal for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
            b_nl = #`HOLD_VIOLATION_TIME byte_enable;
        else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            b_nl = byte_enable;
        end else begin
            #`SAFE_TIME;
            b_nl = byte_enable;
        end    
        // driving Data for normal condition, setup violation, hold violation
        begin
            if (oe_nl == 1'b0) begin // if oe is low, wait till data bus is tri-stated
                @(posedge clkl);
                @(posedge clkl);
            end 
            if (test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1)
                dql_int = #`HOLD_VIOLATION_TIME data;
            else if (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1)  begin
                #`SETUP_VIOLATION_TIME;
                dql_int = data;
            end else begin
                #`SAFE_TIME;
                dql_int = data;
            end
        end

   join    
   if (address == `LAST_ADDRESS)
       test_control_reg[`RIGHT_INTR] = 1'b0 ; 
   `ifdef TSTDBG 
        $display(" Task WriteLeft Ended at time %t", $realtime);     
   `endif
end   
endtask//write_left

//************************************************************************************
// Task         : WriteRight
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************
task WriteRight; 
input [`AD_M:0] address;
input [7:0]  byte_enable;
input [`DT_M:0] data;
reg [145:0] rslt_reg;
begin
    `ifdef TSTDBG 
        $display(" Task WriteRight Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif

    @(posedge clkr);
    fork
        begin
            wait_drive_time(`CE_R);
            ce0_nr =  1'b0  ;
        end 
         begin
             wait_drive_time(`ADS_R);
             ads_nr =  1'b0 ;
         end 
         begin
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b0 ;
         end  
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b1 ;
         end
         begin  
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b1 ;
         end  
         begin
             wait_drive_time (`CE_R);
             ce1_r =  1'b1 ; 
         end  
        // driving Rd/Wr for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1)
             r_w_nr = #0.2 1'b0;
         else if (test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1) begin
              #`SETUP_VIOLATION_TIME;
              r_w_nr = 1'b0;                         
         end else begin
              #`SAFE_TIME;   
              r_w_nr = 1'b0;                         
         end 
    
         // driving Address for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
             ar_int  = #0.2 address;
         else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             ar_int  = address;
         end else begin
             #`SAFE_TIME;
             ar_int  = address;
         end  
    
         // driving Byte Enable for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
             b_nr = #0.2 byte_enable;
         else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1)begin
             #`SETUP_VIOLATION_TIME;
             b_nr = byte_enable;
         end else begin
             #`SAFE_TIME;
             b_nr = byte_enable;
         end    
         
         // driving Data for normal condition, setup violation, hold violation
         begin 
             if (oe_nr == 1'b0) begin
                 @(posedge clkr);
                 @(posedge clkr);
             end    
             if (test_control_reg[`HOLD_VIOLATION_DATA_R] == 1'b1)
                 dqr_int = #0.2 data;
             else if (test_control_reg[`SETUP_VIOLATION_DATA_R] == 1'b1) begin
                 #`SETUP_VIOLATION_TIME;
                 dqr_int = data;
             end else begin
                 #`SAFE_TIME;
                 dqr_int = data;
             end
         end
     join    

     if(address == (`LAST_ADDRESS -1) ) 
        test_control_reg[`LEFT_INTR] = 'b0;
     `ifdef TSTDBG 
         $display(" Task WriteRight Ended at time %t", $realtime);     
     `endif
end   
endtask//write_right

//************************************************************************************
// Task         : ReadLeft
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************

task ReadLeft; 
input [`AD_M:0] address;
input [`BT_M:0]  byte_enable;
input [`DT_M:0] data;      
reg [145:0] rslt_reg;
reg [`DT_M:0]  datax; 
begin
    `ifdef TSTDBG 
        $display("Task ReadLeft Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif
    @(posedge clkl);
    fork
        begin
            wait_drive_time(`CE_L);
            ce0_nl =  1'b0  ;
        end 
        begin
            wait_drive_time(`ADS_L);
            ads_nl =  1'b0 ;
        end 
        begin
            wait_drive_time(`CNTEN_L);
            cnten_nl =  1'b0 ;
        end  
        begin
            wait_drive_time(`CNTRST_L);
            cntrst_nl =  1'b1 ;
        end
        begin  
            wait_drive_time(`CNT_MSK_L);
            cnt_msk_nl=  1'b1 ;
        end  
        begin
            wait_drive_time (`CE_L);
            ce1_l =  1'b1 ; 
        end  
        // driving Data for normal condition, setup violation, hold violation
              
       if ((test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1) ||(test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1))
            dql_int = #0.2 `DT_S'bz;
       else if (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1)begin 
            #`SETUP_VIOLATION_TIME;
            dql_int = `DT_S'bz;
       end else begin
            #`SAFE_TIME;
            dql_int = `DT_S'bz;
       end

       // driving Rd/Wr signal for normal condition, setup violation, hold violation
       if ((test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1) || (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1)) begin
           #(`SETUP_VIOLATION_TIME + 0.1);
           r_w_nl = 1'b1;           
       end else if (test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1)begin
            r_w_nl = #0.3  1'b1;              
       end else begin
           #`SAFE_TIME;   
           r_w_nl = #0.1 1'b1;                         
       end 

       // driving address for normal condition, setup violation, hold violation
       if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
           al_int = #0.2 address;
       else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) begin
           #`SETUP_VIOLATION_TIME;
           al_int = address;
       end else begin
           #`SAFE_TIME;
           al_int = address;
       end  

       // driving Byte Enable signal for normal condition, setup violation, hold violation
       if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
           b_nl = #0.2 byte_enable;
       else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1)begin
           #`SETUP_VIOLATION_TIME;
           b_nl = byte_enable;
       end else begin
           #`SAFE_TIME;
           b_nl = byte_enable;
       end    
   join    
   //filling expected result array
   if(address == (`LAST_ADDRESS -1) ) begin
      test_control_reg[`LEFT_INTR] = 1'b1;
   end 
   fill_result_array(pleft_data, data, rslt_wr_ptr_l);       
   // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
   if (test_control_reg[`BACK_TO_BACK_L] == 1'b0)  begin   
       repeat(2) 
       @(posedge clkl);
       //driving OE in Normal condition   
       if (test_control_reg[`LATE_OE_L]== 1'b0) begin
           oe_nl = #`OESKEW 1'b0;
       end else begin
           // @(posedge clkl);
           oe_nl = #`OESKEW 1'b0;
       end 
       @(posedge clkl);
       oe_nl =#`OESKEW 1'b1; 
       if (data!== `DT_S'bx )begin
           mask_result_x(data, datax);  // when few data bytes  are disabled.
           fill_result_array(pleft_data, datax, rslt_wr_ptr_l);       
       end  
       fill_result_array(pleft_data, `DT_S'hz, rslt_wr_ptr_l);       
   end else if  (oe_nl !== 1'b0) begin
       repeat(2)
      @(posedge clkl);
     oe_nl =#`OESKEW 1'b0;
   end 
   `ifdef TSTDBG 
     $display(" Task ReadLeft Ended at time %t", $realtime);     
   `endif
 
end   
endtask//read_left


//************************************************************************************
// Task         : ReadRight
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************

task ReadRight;
input [`AD_M:0] address;
input [7:0]  byte_enable;
input [`DT_M:0] data;      
reg   [`DT_M:0] datax;      
reg [145:0] rslt_reg;
begin
    `ifdef TSTDBG 
        $display(" Task ReadRight Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif

    @(posedge clkr);
    fork
        begin
            wait_drive_time(`CE_R);
            ce0_nr =  1'b0  ;
        end 
        begin
            wait_drive_time(`ADS_R);
            ads_nr =  1'b0 ;
        end 
        begin
            wait_drive_time(`CNTEN_R);
            cnten_nr =  1'b0 ;
        end  
        begin
            wait_drive_time(`CNTRST_R);
            cntrst_nr =  1'b1 ;
        end
        begin  
            wait_drive_time(`CNT_MSK_R);
            cnt_msk_nr=  1'b1 ;
        end  
        begin
            wait_drive_time (`CE_R);
            ce1_r =  1'b1 ; 
        end  

       if ((test_control_reg[`HOLD_VIOLATION_DATA_R] == 1'b1) || (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1))
            dqr_int = #0.2 `DT_S'bz;
       else if (test_control_reg[`SETUP_VIOLATION_DATA_R] == 1'b1)begin 
            #`SETUP_VIOLATION_TIME;
            dqr_int = `DT_S'bz;
       end else begin
            #`SAFE_TIME;
            dqr_int = `DT_S'bz;
       end

       // driving Rd/Wr signal for normal condition, setup violation, hold violation
       if ((test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1)|| (test_control_reg[`SETUP_VIOLATION_DATA_R] == 1'b1)) begin
           #(`SETUP_VIOLATION_TIME + 0.1);
           r_w_nr = 1'b1;           
       end else if (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1)begin
            r_w_nr = #0.3  1'b1;              
       end else begin
           #`SAFE_TIME;   
           r_w_nr = #0.1 1'b1;                         
       end 

 
        // driving address for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
            ar_int  = #0.2 address;
        else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            ar_int  = address;
        end else begin
            #`SAFE_TIME;
            ar_int  = address;
        end  
 
        // driving Byte Enable for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
            b_nr = #0.2 byte_enable;
        else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            b_nr = byte_enable;
        end else begin
            #`SAFE_TIME;
            b_nr = byte_enable;
        end    
    join    

    //fillling expected data array

    if(address == `LAST_ADDRESS)
        test_control_reg[`RIGHT_INTR] = 1'b1;
    fill_result_array(pright_data, data, rslt_wr_ptr_r);       

    // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
    if (test_control_reg[`BACK_TO_BACK_R] == 1'b0)  begin   
        repeat(2) 
        @(posedge clkr);
        //driving OE in Normal condition   
        if (test_control_reg[`LATE_OE_R]== 1'b0) begin
            oe_nr =#`OESKEW 1'b0;
        end else begin
        @(posedge clkr);
        oe_nr =#0.1 1'b0;
    end 
        @(posedge clkr);
        oe_nr = #`OESKEW 1'b1; 
        if (data!== `DT_S'bx )begin
            mask_result_x(data, datax);  // when few data bytes  are disabled.
            fill_result_array(pright_data, datax, rslt_wr_ptr_r);       
        end  
        fill_result_array(pright_data, `DT_S'bz, rslt_wr_ptr_r);       
    end else if (oe_nr !== 1'b0) begin
        repeat(2)  @(posedge clkr);
        oe_nr =#`OESKEW 1'b0;
    end
    `ifdef TSTDBG 
         $display(" Task ReadRight Ended at time %t", $realtime);     
    `endif

end   
endtask//ReadRight

//************************************************************************************
// Task         : ReadLeftBurst
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************

task ReadLeftBurst; 
input [`AD_M:0] address;
input [`BT_M:0] byte_enable;
input [`AD_M:0] burst_count;
input [`AD_M:0] offset;
input [`DT_M:0] data;      
input [`DT_M:0] max_count;
reg [145:0] rslt_reg;
reg [`DT_M:0]  datax; 
reg [`DT_M:0]  temp_data;
begin
    `ifdef TSTDBG 
        $display("Task ReadLeft Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif
     temp_data = data; 
     @(posedge clkl);
     fork
         begin
          wait_drive_time(`CE_L);
          ce0_nl =  1'b0  ;
         end 
         begin
          wait_drive_time(`ADS_L);
          ads_nl =  1'b0 ;
         end 
         begin
           wait_drive_time(`CNTEN_L);
           cnten_nl =  1'b0 ;
         end  
         begin
           wait_drive_time(`CNTRST_L);
           cntrst_nl =  1'b1 ;
         end
         begin  
           wait_drive_time(`CNT_MSK_L);
           cnt_msk_nl=  1'b1 ;
         end  
         begin
           wait_drive_time (`CE_L);
           ce1_l =  1'b1 ; 
         end  
         // driving Data for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1)
             dql_int = #0.2 `DT_S'bz;
         else begin
              #`SAFE_TIME;
              dql_int = `DT_S'bz;
         end

         // driving Rd/Wr signal for normal condition, setup violation, hold violation
         if (test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             r_w_nl = 1'b1;                         
         end else begin
             #`SAFE_TIME;   
             r_w_nl = #0.1 1'b1;                         
         end 

         // driving address for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
             al_int = #0.2 address;
         else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             al_int = address;
         end else begin
             #`SAFE_TIME;
             al_int = address;
         end  
         // driving Byte Enable signal for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
             b_nl = #0.2 byte_enable;
         else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1) begin
              #`SETUP_VIOLATION_TIME;
              b_nl = byte_enable;
         end else begin
             #`SAFE_TIME;
             b_nl = byte_enable;
         end    
         begin
            @(posedge clkl);   
            wait_drive_time(`ADS_L);
            ads_nl =  1'b1 ;
         end   
         
     join    
     //filling expected result array
     if(address == (`LAST_ADDRESS -1) ) begin
         test_control_reg[`LEFT_INTR] = 1'b1;
     end 
     fill_result_array(pleft_data, data, rslt_wr_ptr_l);       
     data= data+offset;
     // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
     
     fork 

         begin     
//             @(posedge clkl);
             oe_nl =#`OESKEW 1'b0;
             for (i = 0 ; i <= burst_count; i = i+1)begin
                 fill_result_array(pleft_data, data, rslt_wr_ptr_l);       
                 data= data+offset;
                 if (data > temp_data+ (max_count * offset)) data= temp_data;        
                 @(posedge clkl);           
             end 
              
                 
             
             `ifdef FREQ100
                   cnten_nl = #`SAFE_TIME 1'b1; 
              `endif          
             `ifdef FREQ167
                   cnten_nl = #`SAFE_TIME 1'b1;
                  // @(posedge clkl);
              `endif          
              `ifdef FREQ133
                   cnten_nl = #`SAFE_TIME 1'b1;
                 //  @(posedge clkl);
              `endif          
             mask_result_x(data, datax);  // when few data bytes  are disabled.
             fill_result_array(pleft_data, datax, rslt_wr_ptr_l);       
             fill_result_array(pleft_data, `DT_S'hz, rslt_wr_ptr_l);       
           
              @(posedge clkl);           
           
              @(posedge clkl);           
              @(posedge clkl);           
              @(posedge clkl);           
              oe_nl =#`OESKEW 1'b1; 
         end
     join
 
     `ifdef TSTDBG 
          $display(" Task ReadLeftBurst Ended at time %t", $realtime);     
     `endif
end   
endtask//read_left



//************************************************************************************
// Task         : ReadRightBurst
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************

task ReadRightBurst; 
input [`AD_M:0] address_r;
input [`BT_M:0] byte_enable_r;
input [`AD_M:0] burst_count_r;
input [`AD_M:0] offset_r;
input [`DT_M:0] data_r;      
input [`DT_M:0] max_count_r;
reg [145:0] rslt_reg_r;
reg [`DT_M:0]  datax_r; 
reg [`DT_M:0]  temp_data_r;
begin
    `ifdef TSTDBG 
        $display("Task ReadRight Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address_r, byte_enable_r, data_r, $realtime);     
    `endif
     temp_data_r = data_r; 
     @(posedge clkr);
     fork
         begin
          wait_drive_time(`CE_R);
          ce0_nr =  1'b0  ;
         end 
         begin
          wait_drive_time(`ADS_R);
          ads_nr =  1'b0 ;
         end 
         begin
           wait_drive_time(`CNTEN_R);
           cnten_nr =  1'b0 ;
         end  
         begin
           wait_drive_time(`CNTRST_R);
           cntrst_nr =  1'b1 ;
         end
         begin  
           wait_drive_time(`CNT_MSK_R);
           cnt_msk_nr=  1'b1 ;
         end  
         begin
           wait_drive_time (`CE_R);
           ce1_r =  1'b1 ; 
         end  
         // driving Data for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_DATA_R] == 1'b1)
             dqr_int = #0.2 `DT_S'bz;
         else begin
              #`SAFE_TIME;
              dqr_int = `DT_S'bz;
         end

         // driving Rd/Wr signal for normal condition, setup violation, hold violation
         if (test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             r_w_nr = 1'b1;                         
         end else begin
             #`SAFE_TIME;   
             r_w_nr = #0.1 1'b1;                         
         end 

         // driving address for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
             ar_int = #0.2 address_r;
         else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             ar_int = address_r;
         end else begin
             #`SAFE_TIME;
             ar_int = address_r;
         end  
         // driving Byte Enable signal for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
             b_nr = #0.2 byte_enable_r;
         else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1) begin
              #`SETUP_VIOLATION_TIME;
              b_nr = byte_enable_r;
         end else begin
             #`SAFE_TIME;
             b_nr = byte_enable_r;
         end    
         begin
            @(posedge clkr);   
            wait_drive_time(`ADS_R);
            ads_nr =  1'b1 ;
         end   
         
     join    
     //filling expected result array
     if(address_r == (`LAST_ADDRESS -1) ) begin
         test_control_reg[`LEFT_INTR] = 1'b1;
     end 
     fill_result_array(pright_data, data_r, rslt_wr_ptr_r);       
     data_r= data_r+offset_r;
     // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
     
     fork 

         begin     
            // @(posedge clkr);
             oe_nr =#`OESKEW 1'b0;
             for (i = 0 ; i <= burst_count_r; i = i+1)begin
                 fill_result_array(pright_data, data_r, rslt_wr_ptr_r);       
                 data_r= data_r+offset_r;
                 if (data_r > temp_data_r+ (max_count_r * offset_r)) data_r= temp_data_r;        
                 @(posedge clkr);           
             end 
              
                 
             
             `ifdef FREQ100
                   cnten_nr = #`SAFE_TIME 1'b1; 
                   //@(posedge clkr);
                   
              `endif          
             `ifdef FREQ167
              
                   cnten_nr = #`SAFE_TIME 1'b1;
              //     @(posedge clkr);
              `endif          
              `ifdef FREQ133
                  // fill_result_array(pright_data, data_r, rslt_wr_ptr_r);        
                   cnten_nr = #`SAFE_TIME 1'b1;
                //   @(posedge clkr);
              `endif          
             mask_result_x(data_r, datax_r);  // when few data bytes  are disabled.
             fill_result_array(pright_data, datax_r, rslt_wr_ptr_r);       
             fill_result_array(pright_data, `DT_S'hz, rslt_wr_ptr_r);       
           

               @(posedge clkr);           
               @(posedge clkr);           
               @(posedge clkr);          
             oe_nr =#`OESKEW 1'b1; 
         end
     join
 
     `ifdef TSTDBG 
          $display(" Task ReadRightBurst Ended at time %t", $realtime);     
     `endif
end   
endtask//readrightburst





//************************************************************************************
// Task         :WriteLeftBurst
// Author       : Ashlesha Gokhale
// Description  :
//Modification:
//
//
//
//************************************************************************************

task WriteLeftBurst; 
input [`AD_M:0] address;
input [7:0]  byte_enable;
input [`AD_M:0] burst_count;
input [`DT_M:0] data;
input [`DT_M:0] offset;
reg  [145:0] rslt_reg; 
integer i;
begin
    `ifdef TSTDBG 
        $display(" Task WriteLeftBurst Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif
  
     @(posedge clkl);
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl=  1'b1 ;
         end 
         begin
             wait_drive_time(`ADS_L);
             ads_nl =  1'b1 ;
         end
         begin 
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b0 ;
         end
         begin 
             wait_drive_time(`CNTRST_L);
             cntrst_nl =  1'b1 ;
         end
         begin 
             wait_drive_time(`CE_L);
             ce0_nl =  1'b0 ;
         end
         begin 
             wait_drive_time(`CE_L);
             ce1_l =  1'b1 ;
         end 
         // driving Rd/Wr signal for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1)
             r_w_nl = #`HOLD_VIOLATION_TIME 1'b0;
         else if (test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1)begin 
              #`SETUP_VIOLATION_TIME;
              r_w_nl = 1'b0;                         
         end else begin
             #`SAFE_TIME;   
             r_w_nl = 1'b0;                         
         end 

         // driving Address for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
             al_int = address;
         else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             al_int = address;
         end else begin
             #`SAFE_TIME;
             al_int = address;
         end  
         // driving Byte Enable signal for normal condition, setup violation, hold violation
         if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
             b_nl = byte_enable;
         else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1) begin
             #`SETUP_VIOLATION_TIME;
             b_nl = byte_enable;
         end else begin
             #`SAFE_TIME;
             b_nl = byte_enable;
         end    
     
         // driving Data for normal condition, setup violation, hold violation
         begin
             for ( i = 0 ; i <= burst_count; i = i+1) begin
                 if (test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1)
                     dql_int = data;
                 else if (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1) begin
                     #`SETUP_VIOLATION_TIME;
                     dql_int = data;
                 end else begin
                     #`SAFE_TIME;
                     dql_int = data;
                 end
                 data = data + offset;
                 @(posedge clkl); 
             end    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b1 ;
         end
     join    
     if(address == `LAST_ADDRESS)
        test_control_reg[`RIGHT_INTR] = 1'b0 ; 
     `ifdef TSTDBG 
          $display(" Task WriteLeft Ended at time %t", $realtime);     
     `endif
end   
endtask//write_left

//************************************************************************************
// Task         :WriteRightBurst
// Author       : Ashlesha Gokhale
// Description  :
//Modification:
//
//
//
//************************************************************************************

task WriteRightBurst; 
input [`AD_M:0] address;
input [7:0]  byte_enable;
input [`AD_M:0] burst_count;
input [`DT_M:0] data;
input [`DT_M:0] offset;
reg  [145:0] rslt_reg; 
integer i;
begin
    `ifdef TSTDBG 
         $display(" Task WriteLeftBurst Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif
    @(posedge clkr);
    fork
        begin
            wait_drive_time(`CNT_MSK_R);
            cnt_msk_nr=  1'b1 ;
        end 
        begin
            wait_drive_time(`ADS_R);
            ads_nr =  1'b1 ;
        end
        begin 
            wait_drive_time(`CNTEN_R);
            cnten_nr =  1'b0 ;
        end
        begin 
            wait_drive_time(`CNTRST_R);
            cntrst_nr =  1'b1 ;
        end
        begin 
            wait_drive_time(`CE_R);
            ce0_nr =  1'b0 ;
        end
        begin 
            wait_drive_time(`CE_R);
            ce1_r =  1'b1 ;
        end 

        // driving Rd/Wr signal for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1)
            r_w_nr = 1'b0;
        else if (test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            r_w_nr = 1'b0;                         
        end else begin
            #`SAFE_TIME;   
            r_w_nr = 1'b0;                         
        end 
        // driving Address for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
            ar_int = address;
        else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            ar_int = address;
        end else begin
            #`SAFE_TIME;
            ar_int = address;
        end  

        // driving Byte Enable signal for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
            b_nr = byte_enable;
        else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            b_nr = byte_enable;
        end else begin
            #`SAFE_TIME;
            b_nr = byte_enable;
        end    
        begin
            for  ( i = 0 ; i <= burst_count; i = i+1) begin
                 if (test_control_reg[`HOLD_VIOLATION_DATA_R] === 1'b1)
                     dqr_int = data;
                 else if (test_control_reg[`SETUP_VIOLATION_DATA_R] === 1'b1) begin
                      #`SETUP_VIOLATION_TIME;
                      dqr_int = data;
                 end else begin
                     #`SAFE_TIME;
                     dqr_int = data;
                 end
                 data = data + offset;
                 @(posedge clkr); 
            end    
            wait_drive_time(`CNTEN_R);
            cnten_nr =  1'b1 ;
        end
    join    
    if(address == `LAST_ADDRESS)
        test_control_reg[`RIGHT_INTR] = 1'b0 ; 
    `ifdef TSTDBG 
         $display(" Task WriteRightBurst Ended at time %t", $realtime);     
    `endif
end   
endtask//write_rigth_burst


task drive_byten;
input[4:0] portname;
input[`BT_M:0] byte_enable;
output[`BT_M:0] byte_out;   
begin
     if (test_control_reg[`HOLD_OFFSET+portname] == 1'b1)
         byte_out= byte_enable;
     else if (test_control_reg[`HOLD_OFFSET+portname] == 1'b1) begin
         #`SETUP_VIOLATION_TIME;
         byte_out = byte_enable;
     end else begin
         #`SAFE_TIME;
         byte_out = byte_enable;
     end    
end
endtask

task drive_data;
input  [4:0] portname;
input [`DT_M:0] data;
output [`DT_M:0] data_out;
begin
    if (test_control_reg[`HOLD_OFFSET+portname] == 1'b1)
        data_out = data;
    else if (test_control_reg[`SETUP_OFFSET + portname] == 1'b1)    begin
        #`SETUP_VIOLATION_TIME;
        data_out = data;
    end else begin
        #`SAFE_TIME;
        data_out = data;
    end
end
endtask

task drive_address;
input [4:0] portname;
input [`AD_M:0] address;
output[`AD_M:0] address_out;
begin
    if (test_control_reg[`HOLD_OFFSET+portname] == 1'b1)
        address_out = address;
    else if (test_control_reg[`SETUP_OFFSET + portname] == 1'b1)begin 
        #`SETUP_VIOLATION_TIME;
        address_out = address;
    end else begin
        #`SAFE_TIME;
        address_out = address;
    end
end
endtask

task wait_drive_time;
input[4:0] portname;
begin
    if (test_control_reg[`HOLD_OFFSET + portname] == 1'b1)
        #0.2;
    else if (test_control_reg[`SETUP_OFFSET + portname] == 1'b1) begin
        #`SETUP_VIOLATION_TIME;
    end else begin
        #`SAFE_TIME;   
    end 
end
endtask

task load_counter_mask_l;
input[`AD_M:0] counter_mask;
begin

    fork
        begin
            wait_drive_time(`CNT_MSK_L);
            cnt_msk_nl=  0 ;
        end
        begin 
            wait_drive_time(`ADS_L);
            ads_nl =  0 ;
        end
        begin 
            wait_drive_time(`CNTEN_L);
            cnten_nl =  0 ;
        end
        begin 
            wait_drive_time(`CNTRST_L);
            cntrst_nl =  1 ;
        end 
        begin    
            wait_drive_time(`ADDR_L);
            al_int = counter_mask;
        end    

    join    
    @(posedge clkl);
end 
endtask// load_counter_mask_l


task load_counter_mask_r;
input[`AD_M:0] counter_mask;
begin
    @(posedge clkr);
    fork
        begin
            wait_drive_time(`CNT_MSK_R);
            cnt_msk_nr=  1'b0 ;
        end   
        begin 
            wait_drive_time(`ADS_R);
            ads_nr =  1'b0 ;
        end
        begin    
            wait_drive_time(`CNTEN_R);
            cnten_nr =  1'b0 ;
        end    
        begin
            wait_drive_time(`CNTRST_R);
            cntrst_nr =  1'b1 ;
        end
        begin    
            wait_drive_time(`ADDR_R);
            ar_int = counter_mask;

        end    
    join    
    @(posedge clkr);
    fork
        begin
            wait_drive_time(`CNT_MSK_R);
            cnt_msk_nr=  1'b1 ;
        end   
        begin 
            wait_drive_time(`ADS_R);
            ads_nr =  1'b1 ;
        end
        begin    
            wait_drive_time(`CNTEN_R);
            cnten_nr =  1'b1 ;
        end         
    join     
    @(posedge clkr);
end
endtask// load_counter_mask_l

task reset_counter_mask_r;
begin
     fork
         begin
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b0 ;
         end   
         begin 
             wait_drive_time(`ADS_R);
             ads_nr =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b0 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b0 ;
         end
     join    
     @(posedge clkr);

end
endtask// reset_counter_mask_r

task reset_counter_mask_l;
begin
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl=  1'b0 ;
         end   
         begin 
             wait_drive_time(`ADS_L);
             ads_nl =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b0 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nl =  1'b0 ;
         end
     join    
     @(posedge clkr);
end
endtask// reset_counter_mask_l



task reset_counter_r;
begin
     fork
         begin
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_R);
             ads_nr =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b0 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b0 ;
         end
     join    
     @(posedge clkr);

end
endtask// reset_counter_r

task reset_counter_l;
begin
     @(posedge clkl);
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl =  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_L);
             ads_nl =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b0 ;
         end    
         begin
             wait_drive_time(`CNTRST_L);
             cntrst_nl =  1'b0 ;
         end
     join    
     @(posedge clkr);

end
endtask// reset_counter_l

task readback_counter_r;
input[`AD_M:0] counter_val;
begin
     @(posedge clkr);
     fork
         begin
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_R);
             ads_nr =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b1 ;
         end
         begin
            wait_drive_time(`ADDR_R);
            ar_int = `AD_S'hz;
         end
     join    
     addr_cntrl_r = 1'b1;
     @(posedge clkr);
     fork
         begin
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_R);
             ads_nr =  1'b1 ;
         end
         begin    
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b1 ;
         end
     join    
     @(posedge clkr);
     #5
     if (ar !== counter_val) begin
       $display("%t Test Failed for counter read back.", $realtime);
       $display("%t Expected ar = %h Actual ar = %h", $realtime, counter_val,ar );
     end  else begin
      `ifdef TSTMSG
           $display("%t Test Passed for counter read back.", $realtime);
           $display("%t Expected ar = %h Actual ar = %h", $realtime, counter_val,ar );
      `endif
     end
     addr_cntrl_r = 1'b0;        
end
endtask// readback_counter_r

task readback_counter_l;
input[`AD_M:0] counter_val;
begin
     @(posedge clkl);
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_L);
             ads_nl =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_L);
             cntrst_nl =  1'b1 ;
         end
         begin
            wait_drive_time(`ADDR_L);
            al_int = `AD_S'hz;
         end
     join    
     addr_cntrl_l = 1'b1;
     @(posedge clkl);
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_L);
             ads_nl =  1'b1 ;
         end
         begin    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_L);
             cntrst_nl =  1'b1 ;
         end
     join    
     @(posedge clkl);
     #5
     if (al !== counter_val) begin
       $display("%t Test Failed for counter read back.", $realtime);
       $display("%t Expected al = %h Actual al = %h", $realtime, counter_val,al );
     end  else begin
      `ifdef TSTMSG
           $display("%t Test Passed for counter read back.", $realtime);
           $display("%t Expected al = %h Actual al = %h", $realtime, counter_val,al );
      `endif
     end
     addr_cntrl_l = 1'b0;        
end
endtask// readback_counter_l


task readback_mask_l;
input[`AD_M:0] mask_val;
begin
     @(posedge clkl);
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl=  1'b0 ;
         end   
         begin 
             wait_drive_time(`ADS_L);
             ads_nl =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_L);
             cntrst_nl =  1'b1 ;
         end
         begin
            wait_drive_time(`ADDR_L);
            al_int = `AD_S'hz;
         end
     join    
     addr_cntrl_l = 1'b1;
     @(posedge clkl);
     fork
         begin
             wait_drive_time(`CNT_MSK_L);
             cnt_msk_nl=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_L);
             ads_nl =  1'b1 ;
         end
         begin    
             wait_drive_time(`CNTEN_L);
             cnten_nl =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_L);
             cntrst_nl =  1'b1 ;
         end
     join    
     @(posedge clkl);
     #5
     if (al !== mask_val) begin
       $display("%t Test Failed for counter read back.", $realtime);
       $display("%t Expected al = %h Actual al = %h", $realtime, mask_val,al );
     end  else begin
      `ifdef TSTMSG
           $display("%t Test Passed for counter read back.", $realtime);
           $display("%t Expected al = %h Actual al = %h", $realtime, mask_val,al );
      `endif
     end
     addr_cntrl_l = 1'b0;   
end
endtask// readback_mask_l


task readback_mask_r;
input[`AD_M:0] mask_val;
begin
     @(posedge clkr);
     fork
         begin
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b0 ;
         end   
         begin 
             wait_drive_time(`ADS_R);
             ads_nr =  1'b0 ;
         end
         begin    
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b1 ;
         end
         begin
            wait_drive_time(`ADDR_R);
            ar_int = `AD_S'hz;
         end
     join    
     addr_cntrl_r = 1'b1;
     @(posedge clkr);
     fork
         begin
             wait_drive_time(`CNT_MSK_R);
             cnt_msk_nr=  1'b1 ;
         end   
         begin 
             wait_drive_time(`ADS_R);
             ads_nr =  1'b1 ;
         end
         begin    
             wait_drive_time(`CNTEN_R);
             cnten_nr =  1'b1 ;
         end    
         begin
             wait_drive_time(`CNTRST_R);
             cntrst_nr =  1'b1 ;
         end
     join    
     @(posedge clkr);
     #5;
     if (ar !== mask_val) begin
       $display("%t Test Failed for counter read back.", $realtime);
       $display("%t Expected ar = %h Actual ar = %h", $realtime, mask_val,ar );
     end  else begin
      `ifdef TSTMSG
           $display("%t Test Passed for counter read back.", $realtime);
           $display("%t Expected ar = %h Actual ar = %h", $realtime, mask_val,ar );
      `endif
      
     end
     addr_cntrl_r = 1'b0;  
end
endtask// readback_mask_r


task fill_result_array;
input rslt_field;
input[`DT_M:0] rslt_value;
inout [31:0]  ptr;
reg  [145:0] rslt_reg;       
begin
    rslt_reg =  rslt[ptr];
    case (rslt_field)
        pleft_data:
            rslt_reg[`LEFT_DATA] = rslt_value;
        pright_data:
            rslt_reg[`RIGHT_DATA] = rslt_value;
        pleft_intr:
            rslt_reg[`LEFT_MAILBOX_INT] = rslt_value[0];
        pright_intr:
            rslt_reg[`RIGHT_MAILBOX_INT] = rslt_value[0];
    endcase
    rslt[ptr] = rslt_reg;
    ptr = ptr+1; 
end
endtask//fill_result_array;

task create_mask;
input[`BT_M:0] byte_enable;
output[`DT_M:0] mask;
integer i;
begin
    if (byte_enable[0] == 1'b0)
        mask[8:0] = 9'h1ff;
    else   
        mask[8:0] = 9'h00;    
    if (byte_enable[1] == 1'b0)
        mask[17:9] = 9'h1ff;
    else   
        mask[17:9] = 9'h00;    
    if (`BT_S > 2) begin 
      if (byte_enable[2] == 1'b0)
        mask[26:18] = 9'h1ff;
      else   
        mask[26:18] = 9'h00;    
   
      if (byte_enable[3] == 1'b0)
          mask[35:27] = 9'h1ff;
      else   
          mask[35:27] = 9'h00;    
    end      
    if (`BT_S == 8  ) begin
      if (byte_enable[4] == 1'b0)
         mask[44:36] = 9'h1ff;
      else   
         mask[44:36] = 9'h00;    

      if (byte_enable[5] == 1'b0)
         mask[53:45] = 9'h1ff;
      else   
         mask[53:45] = 9'h00;    

      if (byte_enable[6] == 1'b0)
         mask[62:54] = 9'h1ff;
      else   
         mask[62:54] = 9'h00;    

      if (byte_enable[7] == 1'b0)
         mask[71:63] = 9'h1ff;
      else   
         mask[71:63] = 9'h00;    
    end
           
end
endtask//

task get_result;
input[`DT_M:0] data1, data2;
input[`BT_M:0] byte_enable;
output[`DT_M:0] result;
reg[`DT_M:0] mask_reg; 
integer m;
begin
    create_mask(byte_enable,mask_reg);
    for (m = 0; m <= `DT_M; m= m+1)
         if (mask_reg[m] == 1'b1)
             result[m] = data1[m];
         else
             result[m] = data2[m];

end
endtask//

task mask_result_x;
input[`DT_M:0] datax;
output[`DT_M:0] data_masked;
integer i;
begin
    for (i = 0; i <= `DT_M; i = i+1)
        if (datax[i]=== 1'bz) 
            data_masked[i] = 1'bz; 
        else
            data_masked[i] = 1'bx;
end
endtask

function check_x_z;
input[`DT_M: 0] data;
reg[`DT_M:0] result;
integer i;
begin
    result = 1'b1;
    for (i = 0 ; i<=`DT_M; i= i+1)
        if ((data[i] === 1'bx ) ||   (data[i] === 1'bz ))
            result[i] = 1'b0;
        else begin
            result[i] = 1'b1;
        end
    if (result == `DT_M'b0)
        check_x_z = 1'b0;
    else
        check_x_z = 1'b1;
end
endfunction

task check_x;
begin

end
endtask


//==============================End OF File==================================================




























