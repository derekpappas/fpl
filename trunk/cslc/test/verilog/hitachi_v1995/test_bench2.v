//*******************************************************************************
//  Project Name         :  superAND                                            *   
//                                                                              *
//  File Name            :  test_bench.v                                        *
//                                                                              *
//  Module Name          :  test_bench                                          *
//                                                                              *
//  Description          :  This module reads command(tc.pat) file and creates  *
//                          respective internal testvectors and apply           *
//                          stimulus to the model.                              *
//                                                                              *
//  Author               :  M/s Tata Elxsi ltd                                  *
//                                                                              *
//  Rev. History         :  5.0                                                 *
//                                                                              *
//  Date Last Modified   :  28-May-2004                                         *
//                                                                              *
//  Input Files          :  tc.pat                                              *
//                                                                              *
//  Output Files         :  Nil                                                 *
//                                                                              *
//  Compliance:                                                                 *
//  This Verilog model will be simulated using Modeltech's Modelsim Verilog     *
//  simulator Version 5.4e and Cadence NC-Verilog simulator Version 3.30        *
//*******************************************************************************
//--------------------------------------------------------------------------------
//-- history : 28_May_2004   RJJ03C0028-0300Z Rev.3.00 (Japanase data sheet)
//--------------------------------------------------------------------------------

`timescale 1 ns / 1 ns

module test_bench;

//==============================================================================
//    Device version parameter declaration
//==============================================================================

// parameter to select one out of 4 devices
parameter  DEV_TYPE             = 2'b10;      // 00 - HN29V128A1A (3.3v, x8)
                                              // 01 - HN29A128A1A (1.8v, x8)
                                              // 10 - HN29V128A0A (3.3v, x16)
                                              // 11 - HN29A128A0A (1.8v, x16)

parameter  BUSY_MAX_EN         = 1'b1;   // '1': ENABLE  => BUSY time is given as maximum value.
                                         // '0': DISABLE => BUSY time is given as minimum or typical value.



// This parameter tells whether the device is 3.3V or 1.8V
parameter  DEV_3_3V             = !DEV_TYPE[0];

// This parameter tells whether the device is x8 or x16
parameter  DEV_X16              = DEV_TYPE[1];

parameter  BUSY_TYP            = !BUSY_MAX_EN;

//==============================================================================
//      TIMING PARAMETERS DECLARATION with respect to DEV_TYPE
//==============================================================================
parameter  Tcls     = DEV_3_3V ?         0 :         0; // CLE setup time
parameter  Tclh     = DEV_3_3V ?        10 :        20; // CLE hold time
parameter  Tcs      = DEV_3_3V ?         0 :         0; // CE setup time
parameter  Tch      = DEV_3_3V ?        10 :        20; // CE hold time
parameter  Twp      = DEV_3_3V ?        25 :        65; // Write pulse width
parameter  Tals     = DEV_3_3V ?         0 :         0; // ALE setup time
parameter  Talh     = DEV_3_3V ?        10 :        20; // ALE hold time
parameter  Tds      = DEV_3_3V ?        20 :        50; // Data setup time
parameter  Tdh      = DEV_3_3V ?        10 :        20; // Data hold time
parameter  Twc      = DEV_3_3V ?        50 :       100; // Write cycle time
parameter  Twh      = DEV_3_3V ?        15 :        35; // WE high hold time

parameter  Trr      = DEV_3_3V ?        20 :        20; // Ready to RE fall time
parameter  Trp      = DEV_3_3V ?        35 :        80; // Ready to RE fall time
parameter  Trc      = DEV_3_3V ?        50 :       100; // Read cycle time
parameter  Trea     = DEV_3_3V ?        35 :        80; // Read access time (Serial read)
parameter  Treaid   = DEV_3_3V ?        35 :        80; // Read access time (ID read)
parameter  Toh      = DEV_3_3V ?        10 :        10; // Output data hold time
parameter  Trhz     = DEV_3_3V ?        30 :        80; // RE high to output high-Z time
parameter  Tchz     = DEV_3_3V ?        30 :        80; // CE high to output high-Z time
parameter  Treh     = DEV_3_3V ?        15 :        20; // RE hold time
parameter  Trsto    = DEV_3_3V ?        35 :        80; // RE access time (status read)
parameter  Tcsto    = DEV_3_3V ?        45 :       100; // CE access time (status read)
parameter  Twhc     = DEV_3_3V ?        30 :        50; // WE high to CE low time
parameter  Twhr     = DEV_3_3V ?        30 :       100; // WE high to RE low time
parameter  Tar1     = DEV_3_3V ?       100 :       100; // ALE low to RE low time(ID Read)
parameter  Tcr      = DEV_3_3V ?       100 :       100; // CE  low to RE low time(ID Read)
parameter  Twb      = DEV_3_3V ?       200 :       200; // WE high to busy output time
parameter  Tar2     = DEV_3_3V ?        50 :       100; // ALE low to RE low time(Read cycle)
parameter  Tcea     = DEV_3_3V ?        45 :       100; // CE access time
parameter  Trmres   = DEV_3_3V ?        50 :       100; // Ready to MRES high time
parameter  Tdbsy    = DEV_3_3V ?    300000 :    500000; // Deepstandby state to standby state
parameter  Tarbsy   = DEV_3_3V ?   1000000 :   1000000; // Auto read busy time
parameter  Tpre     = DEV_3_3V ?        50 :       100; // PRE pulse width
parameter  Taras    = DEV_3_3V ?    300000 :    500000; // PRE low to busy time (300us/500us)
parameter  Twps     = DEV_3_3V ?       100 :       100; // WP set up time
parameter  Twph     = DEV_3_3V ?       100 :       100; // WP hold time
parameter  Tdes     = DEV_3_3V ?        50 :        80; // "dse_n" going low till DSE low data pattern on "io" bus

//--DS Rev02 new parameter (April '03)
parameter  Tceh     = DEV_3_3V ?       15 :         25; // CE high hold time
parameter  Trhw     = DEV_3_3V ?       50 :        100; // RE high to WE low time
parameter  Trhws    = DEV_3_3V ?     1000 :       2000; // RE high to WE low time in Sequential read cycle
parameter  Tdse     = DEV_3_3V ?        0 :          0; // Power on to DSE high time
parameter  Tpd      = DEV_3_3V ?       50 :         50; // DSE high to PRE high delay
parameter  Tdb      = DEV_3_3V ?  5000000 :    5000000; // DSE high to busy time
parameter  Tchws    = DEV_3_3V ?        5 :          5; // CE high to WE low setup time
parameter  Twhch    = DEV_3_3V ?        5 :          5; // WE high to CE low hold time
parameter  Tchrs    = DEV_3_3V ?        5 :          5; // CE high to RE low setup time
parameter  Trhch    = DEV_3_3V ?        5 :          5; // RE high to CE low hold time
parameter  Tcehs    = DEV_3_3V ?      500 :       1000; // CE high hold time in Sequential read cycle

parameter  Tsrb     = DEV_3_3V ?      200 :        500; // RE high Busy output time in Sequential read cycle
parameter  Trws     = DEV_3_3V ?     5000 :      10000;

parameter  Tr       = DEV_3_3V ? (BUSY_TYP ?   80000 :    250000) : (BUSY_TYP ? 150000 :     400000); // start address access from memory cell array
parameter  Tbsy     = DEV_3_3V ? (BUSY_TYP ? 5000000 :  30000000) : (BUSY_TYP ? 5000000 :  50000000); // power on busy time
parameter  Trstp    = DEV_3_3V ? (BUSY_TYP ?       0 :    250000) : (BUSY_TYP ?       0 :    400000); // Read stop time
parameter  Trewrite = DEV_3_3V ? (BUSY_TYP ? 2200000 : 100000000) : (BUSY_TYP ? 3500000 : 150000000); // Rewrite Time
parameter  Ters     = DEV_3_3V ? (BUSY_TYP ? 2200000 : 100000000) : (BUSY_TYP ? 3500000 : 150000000); // Erase Time
parameter  Tprog    = DEV_3_3V ? (BUSY_TYP ? 1200000 :  30000000) : (BUSY_TYP ? 2000000 :  45000000); // Programming Time

//==============================================================================

parameter  CE_SETUP_TIME       = 10; // This is added to have a wave form
                                     // similar to one in data sheet

// used for re_n pulse time 
parameter  RE_PULSE_TIME       = DEV_3_3V ? 10 : 20;

parameter  ALE_CLE_SETUP_TIME  = 5;  // This is added to have a wave form
                                     // similar to one in data sheet

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  parameter declaration for flash commands 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
parameter  DATAINPUT           =  8'h80;
parameter  READMODE            =  8'h00;
parameter  SEQ_READ            =  8'h0F;
parameter  AUTOPROGRAM         =  8'h10;
parameter  AUTOERASE           =  8'h60;
parameter  AUTOREWRITE         =  8'h1F;
parameter  STATUSREAD          =  8'h70;
parameter  IDREAD              =  8'h90;
parameter  DSBYSETUP           =  8'hC0;
parameter  DSBYRELEASE         =  8'hC1;
parameter  ERASECONFIRM        =  8'hD0;
parameter  READSTOP            =  8'hF0;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// output from test_bench to superAND model    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reg        cle_tb;     // Command latch enable 
reg        ale_tb;     // Address latch enable 
reg        ce_n_tb;    // Chip enable          
reg        re_n_tb;    // Read enable          
reg        we_n_tb;    // Write enable	      
reg        wp_n_tb;    // Write protect	      
reg        pre_tb;     // power on auto read enable  
reg        dse_n_tb;   // Deep standby enable
reg        dump_tb;    // Memory dump

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// input to test_bench from superAND model     
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wire       rb_tb;
wire       mres_n_tb;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// inout b/w test_bench & superAND model       
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wire [15:0] io_tb;                             

reg  [15:0] io_reg;

//-----------------------------------------------------------------------------
//                    Register and Other Declarations     
//-----------------------------------------------------------------------------
reg [15:0] data_read;   
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
  wp_n_tb   <= 1'b1;   // Write protect
  pre_tb    <= 1'b1;   // power on auto read enable       //'03_Apr_28
  dse_n_tb  <= 1'b0;   // Deep standby enable             //'03_Apr_28
//  pre_tb    <= 1'b0;   // power on auto read enable
//  dse_n_tb  <= 1'b1;   // Deep standby enable
  dump_tb   <= 1'b0;   // Memory dump
  io_reg    <= 16'hz;  // Data/Addr input output
  id_read   <= 1'b0;

end   


//------------------------------------------------
// assignment for bi-directional data bus                   
//------------------------------------------------
assign io_tb    = io_reg; 

//------------------------------------------------------------------------------
//                               superAND Model Instantiation                    
//------------------------------------------------------------------------------

hn29x128axa  #(DEV_TYPE) 
             HN29X128AXA_INST (.cle(cle_tb),   .ale(ale_tb),     .ce_n(ce_n_tb), 
                               .re_n(re_n_tb), .we_n(we_n_tb),   .wp_n(wp_n_tb), 
                               .pre(pre_tb),   .dse_n(dse_n_tb), .io(io_tb),
                               .dump(dump_tb), .rb(rb_tb),       .mres_n(mres_n_tb)
                              );
                                 

////*****************************************************************************
//                             Tasks
//*******************************************************************************

task init_pwr_dis;                                    // '03_May_21
begin

  cle_tb    <= 1'b0;   // Command latch enable
  ale_tb    <= 1'b0;   // Address latch enable
  ce_n_tb   <= 1'b1;   // Chip enable
  re_n_tb   <= 1'b1;   // Read enable
  we_n_tb   <= 1'b1;   // Write enable
  wp_n_tb   <= 1'b1;   // Write protect
  pre_tb    <= 1'b1;   // power on auto read enable
  dse_n_tb  <= 1'b1;   // Deep standby enable
  io_reg    <= 16'hz;  // Data/Addr input output
end
endtask

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

  dse_n_tb   <= dsby_en; 

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
  #Twhc;
  $write("\nManufacturer code is :");
  READ_ID;

// '03_May_20   #Treh;   // This delay is added to satisfy re_n high
  #Tceh;   // This delay is added to satisfy ce_n high   '03_May_20

  $write("\nDevice code is :");
  READ_ID;
  $write("\n");
  id_read    = 1'b0;

end                     
endtask

//------------------------------------
// READ_ID - command used to generate
// read cycle for ID read
//------------------------------------ 
task READ_ID;
begin

  ce_n_tb  <= 1'b0;
  we_n_tb  <= 1'b1;
  
  #Tcr;
  re_n_tb  <= 1'b0;
  
  #(Trp + RE_PULSE_TIME);
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
  cle_tb       <= 1'b0;
  ale_tb       <= 1'b0;
  ce_n_tb      <= 1'b0;
  re_n_tb      <= 1'b1;
  we_n_tb      <= 1'b1;
  io_reg       <= 16'hz;

  #(Tcs - Tcls + CE_SETUP_TIME - ALE_CLE_SETUP_TIME);
  cle_tb       <= 1'b1;

  #(Tcls + ALE_CLE_SETUP_TIME);
  we_n_tb      <= 1'b0;

  #(Twp - Tds);
  io_reg       <= {8'hzz,cmd_in};

  #Tds;
  we_n_tb      <= 1'b1;

  io_reg       <= #Tdh 16'hz;

  cle_tb       <= #Tclh 1'b0;

  #Tch;
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
  io_reg       <= 16'hz;
  
  #(Tcs - Tcls + CE_SETUP_TIME - ALE_CLE_SETUP_TIME);
  ale_tb       <= 1'b1;
  
  #(Tcls + ALE_CLE_SETUP_TIME);
  we_n_tb      <= 1'b0;
  
  #(Twp - Tds);
  io_reg       <= {8'hzz, addr_to_be_driven};
  
  #Tds;
  we_n_tb      <= 1'b1;
  
  io_reg       <= #Tdh 16'hz;
  
  ale_tb       <= #Talh 1'b0;
  
  #Tch;
  ce_n_tb      <= 1'b1;

end
endtask

//---------------------------------------
// SADD - Sector address input sequence
//--------------------------------------- 
task SADD;   // input 13 bit sector address
input [12:0]sector_addr;
begin

  $display("Sector Address  : %h",sector_addr);

  DRIVE_ADDR(sector_addr[7:0]);
  #Twhc;
  DRIVE_ADDR(sector_addr[12:8]);

end
endtask

//---------------------------------------
// CADD - Column & page address 
//        input sequence
// This task takes a 11 bit value consisting 
// on page address & column address & drives 
// the io bus in second cycle according to 
// the type of device i.e. x8 or x16
//--------------------------------------- 
task CADD;   // input 11 bit address
             // column + page address
 
input [10:0]page_col_addr;
begin

  if(DEV_X16 === 1'b1) 
  begin
  
    $display("Column Address : %h",page_col_addr[7:0]);
    $display("Page Number : %h",page_col_addr[9:8]);
  
  end
  else
  begin
  
    $display("Column Address : %h",page_col_addr[8:0]);
    $display("Page Number : %h",page_col_addr[10:9]);
  
  end
  
  DRIVE_ADDR(page_col_addr[7:0]);
  #Twhc;
  
  if(DEV_X16 == 1'b1)
    DRIVE_ADDR({6'h00,page_col_addr[9:8]});
  else
    DRIVE_ADDR({5'h00,page_col_addr[10:8]});

end
endtask

//--------------------------------------
// DATA -  Drives data on the data line  
//--------------------------------------
task DATA; // Inputs Start Data, Nummber of cycles.

input [15:0] data;
input num_of_cycles;

reg [15:0] data_temp; 
integer num_of_cycles,i;

begin

 if(num_of_cycles > 'd0) 
 begin

   ce_n_tb      <= 1'b0;
   we_n_tb      <= 1'b1;
   re_n_tb      <= 1'b1;
   io_reg       <= 16'hz;
   data_temp    <= data;

   #(Tcs - Tcls + CE_SETUP_TIME - ALE_CLE_SETUP_TIME);
   cle_tb       <= 1'b0;
   ale_tb       <= 1'b0;
   
   #(Tcls + ALE_CLE_SETUP_TIME);
   we_n_tb      <= 1'b0;

   $display("\n###################################################");
   $display("Data written is : ");

   for(i = 0; i < num_of_cycles; i = i + 1)
   begin
     
     if(i > 0)
     begin
     
       #Twhc;
       ce_n_tb   <= 1'b0;
       #(Tcs + CE_SETUP_TIME);
       we_n_tb   <= 1'b0;

     end

     #(Twp - Tds);
     if(DEV_X16 === 1'b1)
       io_reg    <= data_temp;
     else
       io_reg    <= {8'hzz,data_temp[7:0]};

     #Tds;
     we_n_tb     <= 1'b1;
     
     #Tdh;
     io_reg      <= 16'hz;
     
     #(Tch - Tdh);
     ce_n_tb     <= 1'b1;
     
     if(i % 16 == 0) 
        $write("\n");
     
     if(DEV_X16 === 1'b1)
       $write("   %h", data_temp);
     else
       $write("   %h", data_temp[7:0]);
     
     data_temp  = data_temp + 16'h0001;

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
input dse_n_drive,pre_drive  ,cle_drive  ,ale_drive;
input dump_drive; 
input [15:0] io_drive;

begin

  /* at T0 the following values are assigned to the control pins */
  ce_n_tb    <= ce_n_drive; 
  we_n_tb    <= we_n_drive; 
  re_n_tb    <= re_n_drive; 
  wp_n_tb    <= wp_n_drive; 
  dse_n_tb   <= dse_n_drive;
  pre_tb     <= pre_drive;  
  cle_tb     <= cle_drive;  
  ale_tb     <= ale_drive;  
  dump_tb    <= dump_drive; 
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
//      #Treh;          // Treh time when more than 1 cycle of read is generated
      #Tceh;          // '03_Apr_24

    ce_n_tb  <= 1'b0;

    #(Tcea - Trea);
    re_n_tb  <= 1'b0;

    #(Trp + RE_PULSE_TIME);
    re_n_tb  <= 1'b1;
    ce_n_tb  <= 1'b1;

    if(loop_cnt % 16 == 0)
       $write("\n");

  end
  $write("\n");
end
endtask

//-----------------------------
//    DUMP - Dump task
//-----------------------------
task DUMP;	  // No Inputs
begin

   dump_tb    <= 1'b1;
   dump_tb    <= #10 1'b0; //Signal is asserted high for 10ns.

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
   READMODE     : $display("#  00 : READ MODE");
   SEQ_READ     : $display("#  0F : SEQUENTIAL READ");
   AUTOPROGRAM  : $display("#  10 : AUTOMATIC PROGRAMMING");
   AUTOREWRITE  : $display("#  1F : AUTOMATIC REWRITING");
   AUTOERASE    : $display("#  60 : AUTOMATIC ERASE");
   STATUSREAD   : $display("#  70 : STATUS READ");
   DATAINPUT    : $display("#  80 : DATA INPUT");
   IDREAD       : $display("#  90 : ID READ");
   DSBYSETUP    : $display("#  C0 : DEEP STANDBY (SETUP)");
   DSBYRELEASE  : $display("#  C1 : DEEP STANDBY (RELEASE)");
   ERASECONFIRM : $display("#  D0 : ERASE CONFIRM");
   READSTOP     : $display("#  F0 : READ STOP");
   default : $display("# WRONG COMMAND PASSED");
 endcase

end
endtask

//-----------Always block to read data from data line-----------
always @(io_tb) 
begin

  if(re_n_tb === 1'b0 && ce_n_tb === 1'b0 && we_n_tb === 1'b1)
  begin 
    
    if(DEV_X16 === 1'b1 && (^io_tb !== 1'bz && ^io_tb !== 1'bx))
    begin
       data_read    = io_tb;
       if(id_read === 1'b1)
          $write("   %h",data_read[7:0]);
       else
          $write("   %h",data_read);
    end
    else if(^io_tb[7:0] !== 1'bz && ^io_tb[7:0] !== 1'bx)
    begin
       data_read[7:0]    = io_tb[7:0];
       $write("   %h",data_read[7:0]);
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
