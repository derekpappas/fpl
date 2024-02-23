//*******************************************************************************
//  File Name            :  test_bench.v                                        *
//                                                                              *
//  Module Name          :  test_bench                                          *
//                                                                              *
//  Description          :  This module reads command(tc.pat) file and creates  *
//                          respective internal testvectors and apply           *
//                          stimulus to the model.                              *
//                          This test_bench is applied for hn29v1g91.           *
//                                                                              *
//  Rev. History         :  0.65                                                *
//                                                                              *
//  Date Last Modified   :  11-Nov-2003                                         *
//                                                                              *
//  Input Files          :  tc.pat                                              *
//                                                                              *
//  Output Files         :  Nil                                                 *
//                                                                              *
//  Compliance:                                                                 *
//  This Verilog model will be simulated using Cadence NC-Verilog simulator     *
//  Version 3.30                                                                *
//*******************************************************************************
//--------------------------------------------------------------------------------
//-- history : Rev 0.62  30_sep_2003
//--           Rev 0.64  11_Nov_2003
//--------------------------------------------------------------------------------

`timescale 1 ns / 1 ns

module test_bench;

//==============================================================================
//      TIMING PARAMETERS DECLARATION with respect to DEV_TYPE
//==============================================================================
parameter tCLS     =           0;
parameter tCLH     =           9;
parameter tCS      =           0;
parameter tCH      =           6;
parameter tWP      =          15;
parameter tWPCE    =          20;
parameter tALS     =           0;
parameter tALH     =           6;
parameter tDS      =           9;
parameter tDH      =           9;
parameter tWC      =          33;
parameter tWH      =          12;

parameter tR       =     100_000;
parameter tAR1     =          20;
parameter tAR2     =          30;
parameter tCLR     =           6;
parameter tRR      =          20;
parameter tRP      =          20;
parameter tWB      =         100;
parameter tRC      =          35;
parameter tREA     =          20;
parameter tCEA     =          25;
parameter tRHZ     =          10;      //'03.0827
parameter tCHZ     =           0;      //'03.0827
parameter tRHZmax  =          20;      //'03.0827
parameter tCHZmax  =          20;      //'03.0827
parameter tREH     =          10;
parameter tIR      =           0;
parameter tWHR     =          50;
parameter tRSTR    =      20_000;      //'03.0827
parameter tRSTP    =      70_000;      //'03.0827
parameter tRSTE    =     400_000;      //'03.0827
parameter tRSTEV   =      30_000;      //'03.0827
parameter tRSTDR   =     350_000;      //'03.0827
parameter tPON     =     200_000;
parameter tVRS     =      20_000;
parameter tVRDY    =      20_000;
parameter tBSY     =         100;

parameter tPROG    =   1_000_000;
parameter tCPROG   =   2_000_000;
parameter tCBSY    =       3_000;
parameter tCBSYmx  =   1_000_000;
parameter tDBSY    =       4_000;
parameter tBERS    =   2_400_000;
parameter tPEV     =      50_000;
parameter tBEV     =      70_000;

parameter tWWS     =          15;
parameter tWWH     =          15;
parameter tCSD     =         100;
parameter tWDSE    =     300_000;
parameter tRWDSE   =         100;

parameter tCHWS    =           5;      //'03.0827
parameter tWHCH    =           5;      //'03.0827
parameter tCHRS    =           5;      //'03.0827
parameter tRHCS    =           5;      //'03.0827

parameter tDRCtyp  =     890_000;      //'03.0827
parameter tDRCmax  = 100_000_000;      //'03.0827

//==============================================================================

parameter  CE_SETUP_TIME       = 5; // This is added to have a wave form
parameter  RE_PULSE_TIME       = 10; // used for re_n pulse time 
parameter  ALE_CLE_SETUP_TIME  = 0;  // This is added to have a wave form

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  parameter declaration for flash commands 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
parameter  READ_1ST               =  8'h00;
parameter  READ_RANDOM_1ST        =  8'h05; 
parameter  READ_RECOVERY_1ST      =  8'h06;
parameter  READ_2ND               =  8'h30;
parameter  MREAD_2ND              =  8'h31;
parameter  COPYBACK_READ_2ND      =  8'h35;
parameter  DATAOUTPUT_2ND         =  8'hE0;          
parameter  DATAINPUT_1ST_1        =  8'h80;
parameter  DATAINPUT_1ST_2        =  8'h85;
parameter  PROGRAM_2ND_1          =  8'h10;
parameter  PROGRAM_2ND_2          =  8'h11;
parameter  PROGRAM_CACHE_2ND      =  8'h15;
parameter  ERASE_1ST              =  8'h60;
parameter  ERASE_CONFIRM_2ND      =  8'hD0;
parameter  ERASE_PAGEVERIFY_2ND   =  8'hD2;
parameter  ERASE_BANKVERIFY_2ND   =  8'hD3;
parameter  STATUS_READ            =  8'h70;
parameter  MBANK_STATUS_READ      =  8'h71;
parameter  ERROR_STATUS           =  8'h72;
parameter  ERROR_STATUS_MBANK0    =  8'h73; 
parameter  ERROR_STATUS_MBANK1    =  8'h74;
parameter  ERROR_STATUS_MBANK2    =  8'h75;
parameter  ERROR_STATUS_MBANK3    =  8'h76;
parameter  RESET                  =  8'hFF;
parameter  RESET_STATUSMODE       =  8'h7F; 
parameter  IDREAD                 =  8'h90;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// output from test_bench to 1Gbit AG-AND model    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reg        cle_tb;     // Command latch enable 
reg        ale_tb;     // Address latch enable 
reg        ce_n_tb;    // Chip enable          
reg        re_n_tb;    // Read enable          
reg        we_n_tb;    // Write enable	      
reg        wp_n_tb;    // Write protect	      
reg        pre_tb;     // power on auto read enable  
reg        res_n_tb;   // Deep standby enable

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// input to test_bench from 1Gbit AG-AND model     
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wire       rb_tb;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// inout b/w test_bench & 1Gbit AG-AND model       
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wire [7:0] io_tb;                             
reg  [7:0] io_reg;

//-----------------------------------------------------------------------------
//                    Register and Other Declarations     
//-----------------------------------------------------------------------------
reg [7:0] data_read;   
reg id_read;
//==============================================================================

initial
fork
  begin
    `include "tc.pat"
  end
join

initial
begin

  cle_tb    <= 1'b0;   // Command latch enable
  ale_tb    <= 1'b0;   // Address latch enable
  ce_n_tb   <= 1'b1;   // Chip enable
  re_n_tb   <= 1'b1;   // Read enable
  we_n_tb   <= 1'b1;   // Write enable
  wp_n_tb   <= 1'bz;   // Write protect
  pre_tb    <= 1'bz;   // power on auto read enable  //'03.0827
  res_n_tb  <= 1'bz;   // Deep standby enable        //'03.0827
  io_reg    <= 8'hz;   // Data/Addr input output
  id_read   <= 1'b0;

end   

//------------------------------------------------
// assignment for bi-directional data bus                   
//------------------------------------------------
assign io_tb    = io_reg; 

//------------------------------------------------------------------------------
//                           1Gbit AG-AND Model Instantiation                    
//------------------------------------------------------------------------------
hn29v1g91    HN29V1G91_INST   (.cle(cle_tb),   .ale(ale_tb),     .ce_n(ce_n_tb), 
                               .re_n(re_n_tb), .we_n(we_n_tb),   .wp_n(wp_n_tb), 
                               .pre(pre_tb),   .res_n(res_n_tb), .io(io_tb),
                               .rb(rb_tb)
                              );
                                 
////*****************************************************************************
//                             Tasks
//*******************************************************************************

//------------------------------------
// PREN - Power On Auto Read Enable
//------------------------------------
task PREN;
input pre_en;
begin                 

  pre_tb    <= pre_en;

end                     
endtask  

//------------------------------------
// DSBY - Deep standby Entry/Exit
//------------------------------------
task DSBY;
input dsby_en;
begin                 

  res_n_tb   <= dsby_en; 

end                     
endtask    

//----------------------------------------------------------
// IDRD - This command takes a byte of address as input. 
// This command generates the Address Input Cycle 
// (with address specified as argument) required during 
// ID Read. After the address is given it generates two 
// read cycles to read the manufacturer ID and device ID.
//----------------------------------------------------------
task IDRD;
input [7:0] Addr_in;
begin                 
  
  id_read    = 1'b1;
  $display("\nAddress input : %h", Addr_in);
  DRIVE_ADDR(Addr_in);
  #(tWHR - tDH);
  $write("\nManufacturer code is :");
  READ_ID;

  #tREH;   // This delay is added to satisfy re_n high

  $write("\nDevice code is :");
  READ_ID;
  $write("\n");
  id_read    = 1'b0;
  #(tCHZ);

end                     
endtask

//------------------------------------
// READ_ID - command used to generate
// read cycle for ID read
//------------------------------------ 
task READ_ID;
begin

  ce_n_tb  <= 1'b0;
  #(tCEA - tREA);
     re_n_tb  <= 1'b0;
  #(tRP + RE_PULSE_TIME);
     re_n_tb  <= 1'b1;
     ce_n_tb  <= 1'b1;
end
endtask

//------------------------------------
// CMND - Command input sequence
//------------------------------------ 
task CMND;
input [7:0] cmd_in;
begin

  CommandDisplay(cmd_in);
  ce_n_tb      <= 1'b0;
  cle_tb       <= 1'b0;
  ale_tb       <= 1'b0;
  we_n_tb      <= 1'b1;
  re_n_tb      <= 1'b1;
  io_reg       <= 8'hz;

  #(tCS - tCLS - ALE_CLE_SETUP_TIME);
     cle_tb       <= 1'b1;
  #(tCS + CE_SETUP_TIME);
     we_n_tb      <= 1'b0;
  #(tWP - tDS);
     io_reg       <= cmd_in;
  #tDS;
     we_n_tb      <= 1'b1;
     io_reg       <= #tDH 8'hz;
     cle_tb       <= #tCLH 1'b0;
  #tCH;
     ce_n_tb      <= 1'b1;
end
endtask

//------------------------------------
// DRIVE_ADDR - Task to derive 1 byte 
//              address on to io bus
//------------------------------------ 
task DRIVE_ADDR;
input [7:0] addr_to_be_driven;
begin  
  
  ce_n_tb      <= 1'b0;
  cle_tb       <= 1'b0;
  ale_tb       <= 1'b0;
  we_n_tb      <= 1'b1;
  re_n_tb      <= 1'b1;
  io_reg       <= 8'hz;
  
  #(tCS - tCLS - ALE_CLE_SETUP_TIME);
     ale_tb       <= 1'b1;
  #(tCS + CE_SETUP_TIME);
     we_n_tb      <= 1'b0;
  #(tWP - tDS);
     io_reg       <= addr_to_be_driven;
  #tDS;
     we_n_tb      <= 1'b1;
     io_reg       <= #tDH 8'hz;
     ale_tb       <= #tALH 1'b0;
  #tCH;
     ce_n_tb      <= 1'b1;
end
endtask

//---------------------------------------
// RADD - Row address input sequence
//--------------------------------------- 
task RADD;   // input 16 bit row address
input [15:0]row_addr;
begin

  $display("Row Address : %h",row_addr);
  $display("Bank No.    : %h",row_addr[1:0]);

  DRIVE_ADDR(row_addr[7:0]);
  #tWH;
  DRIVE_ADDR(row_addr[15:8]);

end
endtask

//---------------------------------------
// CADD - Column & page address input sequence
//--------------------------------------- 
task CADD;   // input 12 bit column address
input [11:0]page_col_addr;
begin
  
  $display("Column Address : %h",page_col_addr[11:0]);
  
  DRIVE_ADDR(page_col_addr[7:0]);
  #tWH;
  DRIVE_ADDR({4'h0,page_col_addr[11:8]});

end
endtask

//--------------------------------------
// DATA -  Drives data on the data line  
//--------------------------------------
task DATA; // Inputs Start Data, Nummber of cycles.
input  [7:0] data;
input   num_of_cycles;
reg    [7:0] data_temp; 
integer num_of_cycles,i;

begin

 if(num_of_cycles > 'd0) 
 begin
   ce_n_tb      <= 1'b0;
   we_n_tb      <= 1'b1;
   re_n_tb      <= 1'b1;
   io_reg       <= 8'hz;
   data_temp    <= data;

   #(tCS - tCLS - ALE_CLE_SETUP_TIME);
      cle_tb       <= 1'b0;
      ale_tb       <= 1'b0;
   #(tCS + CE_SETUP_TIME);
      we_n_tb      <= 1'b0;

   $display("\n###################################################");
   $display("Data written is : ");

   for(i = 0; i < num_of_cycles; i = i + 1)
   begin
     if(i > 0)
     begin
       #tWH;
          ce_n_tb   <= 1'b0;
       #(tCS + CE_SETUP_TIME);
          we_n_tb   <= 1'b0;
     end
     #(tWP - tDS);
        io_reg    <= data_temp[7:0];
     #tDS;
        we_n_tb     <= 1'b1;
     #tDH;
        io_reg      <= 8'hz;
     #(tCH);
        ce_n_tb     <= 1'b1;
     if(i % 16 == 0) 
        $write("\n");
     $write("%h   ", data_temp[7:0]);
     data_temp  = data_temp + 8'h01;

   end // End of for(....)
 end // End of if(num_of_cycles > 'd0)   
 $display("\n");
end
endtask

//--------------------------
// DRIV - Drive command 
//--------------------------
task DRIV;	 
input ce_n_drive ,we_n_drive ,re_n_drive ,wp_n_drive;
input res_n_drive,pre_drive  ,cle_drive  ,ale_drive;
input [7:0] io_drive;

begin

  /* at T0 the following values are assigned to the control pins */
  ce_n_tb    <= ce_n_drive; 
  we_n_tb    <= we_n_drive; 
  re_n_tb    <= re_n_drive; 
  wp_n_tb    <= wp_n_drive; 
  res_n_tb   <= res_n_drive;
  pre_tb     <= pre_drive;  
  cle_tb     <= cle_drive;  
  ale_tb     <= ale_drive;  
  io_reg     <= io_drive;  

end
endtask

//--------------------------------------------------------------------
//    READ - Task to generate Read cycles & Read data 
//    that is present on the io bus
//--------------------------------------------------------------------
task READ;      // Input : Number of read cycles to generate
input num_read_cycles;

integer num_read_cycles;
integer loop_cnt;
begin

  $display("\n###################################################");

  $display("\nData Read is : ");
  we_n_tb  <= 1'b1;
  cle_tb   <= 1'b0;
  ale_tb   <= 1'b0;

  for(loop_cnt = 1; loop_cnt <= num_read_cycles; loop_cnt = loop_cnt + 1)
  begin
    
    if(loop_cnt > 1)  // This is added to take care ao as to not violate
      #tREH;          // Treh time when more than 1 cycle of read is generated

    ce_n_tb  <= 1'b0;

    #(tCEA - tREA);
       re_n_tb  <= 1'b0;
    #(tRP + RE_PULSE_TIME);
       re_n_tb  <= 1'b1;
       ce_n_tb  <= 1'b1;

    if(loop_cnt % 16 == 0)
       $write("\n");

  end
  $write("\n");
end
endtask


//-----------------------------------------------------------------------------
//                     Display Command
//-----------------------------------------------------------------------------
task CommandDisplay ;   
 
input [7:0] command;

begin  

 $display("\n################################");
 $display("Command applied is :");

 case(command)
   READ_1ST             : $display("00H :  READ MODE");
   READ_RANDOM_1ST      : $display("05H :  RANDOM DATA OUTPUT MODE"); 
   READ_RECOVERY_1ST    : $display("06H :  PAGE DATA / DATA RECOVERY READ MODE");
   READ_2ND             : $display("30H :  READ");
   MREAD_2ND            : $display("31H :  MULTI BANK READ");
   COPYBACK_READ_2ND    : $display("35H :  READ FOR COPY BACK");
   DATAOUTPUT_2ND       : $display("E0H :  DATA OUTPUT [Random/Page/Recovery_read]");
   DATAINPUT_1ST_1      : $display("80H :  DATA INPUT [Page/Multi_bank_page/Cache]");
   DATAINPUT_1ST_2      : $display("85H :  DATA INPUT [Copy_back/Multi_bank/Data_recovery/Random]");
   PROGRAM_2ND_1        : $display("10H :  PROGRAM [Copy_back/Data_recovery/Page]");
   PROGRAM_2ND_2        : $display("11H :  PROGRAM [Multi_bank_copy_bak/Multi_bank_page]");
   PROGRAM_CACHE_2ND    : $display("15H :  CACHE PROGRAM");
   ERASE_1ST            : $display("60H :  ERASE");
   ERASE_CONFIRM_2ND    : $display("D0H :  ERASE CONFIRM");
   ERASE_PAGEVERIFY_2ND : $display("D2H :  PAGE MODE ERASE VERIFY");
   ERASE_BANKVERIFY_2ND : $display("D3H :  BANK MODE ERASE VERIFY");
   STATUS_READ          : $display("70H :  READ STATUS");
   MBANK_STATUS_READ    : $display("71H :  READ MULTI BANK STATUS");
   ERROR_STATUS         : $display("72H :  READ ERROR STATUS");
   ERROR_STATUS_MBANK0  : $display("73H :  READ MULTI BANK ERROR STATUS [Bank0]");
   ERROR_STATUS_MBANK1  : $display("74H :  READ MULTI BANK ERROR STATUS [Bank1]");
   ERROR_STATUS_MBANK2  : $display("75H :  READ MULTI BANK ERROR STATUS [Bank2]");
   ERROR_STATUS_MBANK3  : $display("76H :  READ MULTI BANK ERROR STATUS [Bank3]");
   RESET                : $display("FFH :  RESET");
   RESET_STATUSMODE     : $display("7FH :  STATUS MODE RESET");
   IDREAD               : $display("90H :  READ ID");
   default : $display("WRONG COMMAND PASSED");
 endcase

end
endtask

//-----------Always block to read data from data line-----------
always @(io_tb) 
begin
  if(re_n_tb === 1'b0 && ce_n_tb === 1'b0 && we_n_tb === 1'b1)
  begin 
    if(^io_tb[7:0] !== 1'bz && ^io_tb[7:0] !== 1'bx)
    begin
       data_read[7:0]    = io_tb[7:0];
//       $write("   %h",data_read[7:0]);
       $write("%h   ",data_read[7:0]);
    end
  end
end

//-----------------------------------------
// STOP : task to stop the simulation.
//-----------------------------------------
task STOP; // No Inputs
begin
  
  $display("\n###################################################\n");
  $finish;

end
endtask

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
endmodule
