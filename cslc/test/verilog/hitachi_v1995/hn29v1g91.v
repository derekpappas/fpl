//********************************************************************************
//* File Name     : hn29v1g91.v                                                  *
//* Module Name   : hn29v1g91                                                    *
//* Description   : This file is a simulation model of Renesas's                 *
//*                 1G AG AND Type Flash Memory (128-Mword x 8-bit).             *
//*                 HN29V1G91                                                    *
//*                                                                              *
//*                 Copyright 2003       Renesas Technology Corp.                *
//*                                      All rights reserved.                    *
//*                                                                              *
//*                 This models are provided "as is". Renesas Technology Corp.   *
//*                 is not responsible for any problems this models may cause    *
//*                 to the customers.                                            *
//*                                                                              *
//* Revision                                                                     *
//* Rev.0.66      : Based on Data-sheet RJJ03C0039-0200Z Rev.2.0                 *
//*                                                      (Japanese data-sheet)   *
//*                          Data-sheet REJ03C0056-0200Z Rev.2.0                 *
//*                                                      (English data-sheet)    *
//*                                                                              *
//*                    The parameter was changed.                                *
//*                        Since "erase error"and" program error" was generated  *
//*                        by two or more independent pages, the parameter was   *
//*                        changed.                                              *
//*                        Deleted parameter : "param_error_en"                  *
//*                        Add     parameter :                                   *
//*                           "erase_err_page",                                  *
//*                           "erase_err_ecc_en",  "erase_err_ecc_page",         *
//*                           "prog_in_erase_err", "prog_in_erase_page"          *
//*                                                          : '04.02.09 H.Tamai *
//*                                                                              *
//* Rev.0.65      : Based on Data-sheet RJJ03C0039-0100Z Rev.1.0                 *
//*                                                      (Japanese data-sheet)   *
//*                          Data-sheet REJ03C0056-0100Z Rev.1.0                 *
//*                                                      (English data-sheet)    *
//*                 + changed:                                                   *
//*                    (1) The method of generating program error and erase      *
//*                        error was changed by selection of parameter.          *
//*                        The program error and erase error are able to         *
//*                        generate separately.                                  *
//*                                                                              *
//*                      1-1 The name of a parameter was changed as follows.     *
//*                           "program_error_en" ->  "param_error_en"            *
//*                           "erase_err_en"     ->  "erase_err_1t_en"           *
//*                           "erase_err_page"   ->  "erase_err_1t_page"         *
//*                      1-2 Moreover, the following parameters were added.      *
//*                           "erase_err_en",  "program_err_en"                  *
//*                    (2) When the command "11h" was issued at Program data     *
//*                        input in Erase Busy, the specification of tDBSY was   *
//*                        changed.                                              *
//*                 + correction                                                 *
//*                     The address register of internal model was changed so    *
//*                     that value of address might be cleared after data        *
//*                     program is finished.                                     *
//*                                                        :'03.12.24 H.Tamai    *
//*                                                                              *
//* Rev.0.64      : Based on Data-sheet RJJ03C0039-0002Z Rev.0.02                *
//*                                                      (Japanese data-sheet)   *
//*                          Data-sheet REJ03C0056-0002Z Rev.0.02                *
//*                                                      (English data-sheet)    *
//*                 + correction                                                 *
//*                    (1) The operation of "11h(Busy) - 10h(Ready)" was         *
//*                         corrected at "Program Data Input in Erase Busy".     *
//*                    (2) The operation of reset after Multi Bank Program       *
//*                        was corrected.                                        *
//*                    (3) The spec. check of tRSTP/tRSTR/tRSTE/tRSTEV/tRSTDR    *
//*                        was added.                                            *
//*                    (4) The dse_n of signal name was changed to res_n.        *
//*                                                        :'03.11.11 H.Tamai    *
//* Rev.0.63      : + correction                                                 *
//*                    (1) Issued "FFh" command during " POWER-ON-AUTO-READ-MODE"*
//*                    (2) Model operation after issuing "11h" command just      *
//*                        before "tBERS" end.                                   *
//*                                                        :'03.10.16 H.Tamai    *
//*                                                                              *
//* Rev.0.62      : + Changed:                                                   *
//*                    (1) Based on Data-sheet RJJ03C0039-0002Z Rev.0.02         *
//*                                                       (Japanese data-sheet)  *
//*                    (2) The following model parameters were added.            *
//*                           "deplete_bank0_en", "deplete_bank1_en",            *
//*                           "deplete_bank2_en", "deplete_bank3_en",            *
//*                           "deplete_bank0", "deplete_bank1", "deplete_bank2", *
//*                           "deplete_bank3", "erase_err_enable",               *
//*                           "erase_err_page", "non_stop_sim_en"                *
//*                    (3) When column address becomes 840h or more,             *
//*                           the value of output data is set to "xx".           *
//*                 + Bag correction :                                           *
//*                    (1) True-Ready/Busy of Cache program                      *
//*                    (2) Error check when CE is negated.                       *
//*                                                        :'03.09.30 H.Tamai    *
//*                                                                              *
//* Rev.0.53      : The coding style of timing check was changed.                *
//*                                                        :'03.07.04 H.Tamai    *
//*                                                                              *
//* Rev.0.52      : Based on datasheet RJJ03C0039-0001Z Rev.0.01                 *
//*                                               (Japanese data sheet)          *
//*                                                        :'03.06.27 H.Tamai    *
//*                                                                              *
//******************************************************************************** 

`timescale    1ns / 10ps


module hn29v1g91 (io, cle, ale, ce_n, re_n, we_n, wp_n, rb, pre, res_n );

//=======================
// PARAMETER DECLARATION
//=======================
//-- control parameter
parameter memory_alloc       = 1;         //-- memory allocation mode
                                          //--   0: all page, 1: no_of_page_alloc
parameter no_of_page_alloc   = 16;        //-- page allocation size (2-65536)
parameter error_msg_en       = 1'b1;      //-- error message on/off  0: off, 1: on
parameter non_stop_sim_en    = 1'b0;      //-- 0: Stop simulation on error, 1: non stop simulation
parameter power_on_skip      = 1'b0;      //-- tPON skip mode  0: disable, 1: enable
parameter init_mem_en        = 2'd0;      //-- memory array init
                                          //    0: disable, 1: page 0&4, 2: any page
                                          //    1: "page0.mem", "page4.mem"
                                          //    2: "mem_array.dat", "row_array.dat"
parameter init_page_stat     = 1'b0;      //-- read bad page control file
                                          //    0: disable, 1: enable
                                          //    control file: "init.stat" 
parameter erase_err_en       = 1'b0;      //-- when this value is set to '1'b1',
                                          //   erase error occur(ECC available).
parameter erase_err_page     = 16'hfff1;  //-- erase error page (ECC available).

parameter erase_err_ecc_en   = 1'b0;      //-- when this value is set to '1'b1',
                                          //   erase error occur(ECC not available).
parameter erase_err_ecc_page = 16'hfff2;  //-- erase error page (ECC not available).

parameter prog_in_erase_err  = 1'b0;      //-- This parameter used when the page of "erasing"
                                          //   and "programing" is the same at "Program data
                                          //   input in erase busy".
parameter prog_in_erase_page = 16'hfffa;  //-- if prog_in_erase_err  = 1'b1, erase & program
                                          //   error occur in this page

parameter program_err_en     = 1'b0;      //--  when this value is set to '1'b1',
                                          //    program_error occur.

parameter bad_page           = 16'hfffb;  //-- 100-bit error page (Bad page)
parameter err_page_1         = 16'hfffc;  //-- 1-bit error page   (Ecc available)
parameter err_page_2         = 16'hfffd;  //-- 2-bit error page   (Ecc available)
parameter err_page_5         = 16'hfffe;  //-- 5-bit error page   (Ecc available)
parameter err_page_100       = 16'hffff;  //-- 100-bit error page (Ecc Not abailable)
parameter rand_seed          = 12345;     //-- random seed

parameter erase_err_1t_en    = 1'b0;      //-- only when init_page_stat == 1'b0
                                          //   one times erase error  0: disable, 1: enable
parameter erase_err_1t_page  = 16'h01f0;  //-- one times erase error page

parameter deplete_bank0_en   = 1'b0;      //-- deplete eneble (bank0) 0: disable, 1: enable
parameter deplete_bank0      = 16'h7ff8;  //--   deplete block No. (bank0) 0,4, .. 7FFC
parameter deplete_bank1_en   = 1'b0;      //-- deplete eneble (bank1) 0: disable, 1: enable
parameter deplete_bank1      = 16'h7ff9;  //--   deplete block No. (bank1) 1,5, .. 7FFD
parameter deplete_bank2_en   = 1'b0;      //-- deplete eneble (bank2) 0: disable, 1: enable
parameter deplete_bank2      = 16'h7ffa;  //--   deplete block No. (bank2) 2,6, .. 7FFE
parameter deplete_bank3_en   = 1'b0;      //-- deplete eneble (bank3) 0: disable, 1: enable
parameter deplete_bank3      = 16'h7ffb;  //--   deplete block No. (bank3) 3,7, .. 7FFF


//-- fixed parameter
parameter bank_width = 2;
parameter erased_dat       = 8'b11111111;
parameter broken_dat       = 8'b1110111z;
parameter col_max          = 12'd2111;
parameter size_of_page     = 2048 + 64;
parameter no_of_page       = 65536;
parameter memory_size      = no_of_page * size_of_page;
parameter manufa_code      = 8'h07;
parameter device_code      = 8'h01;
parameter page_alloc       = (memory_alloc==0)?no_of_page:no_of_page_alloc;
parameter memory_size_alloc = page_alloc * size_of_page;
parameter deplete_dat      = 8'b11111111;
parameter deplete_recovery_dat = 8'b00001111;

//==================== 
// INPUT/OUTPUT PORTS
//==================== 
//----- INOUT ports
inout [7:0] io; //-- address/data/command

//----- INPUT ports
input cle;      //-- command latch enable
input ale;      //-- address latch enable
input ce_n;     //-- chip enable
input re_n;     //-- read enable
input we_n;     //-- write enable
input wp_n;     //-- write protect
input pre;      //-- power-on read enable
input res_n;    //-- deep standby enable

//----- OUTPUT ports
output rb;      //-- ready/busy

wire rb;


//====================== 
// COMMAND TRIGGER TYPE
//====================== 
parameter cmd          = 0;
parameter addr         = 1;
parameter data         = 2;
parameter bank_ready   = 3;

//====== 
// FLAG 
//====== 
parameter f_disable    = 0;
parameter f_enable     = 1;
parameter f_erase      = 1;
parameter f_noterase   = 2;
parameter f_page       = 1'b0;      // for erase verify flag
parameter f_block      = 1'b1;      // for erase verify flag

//==============
// PAGE STATUS
//==============
parameter pg_good              = 4'b0000;
parameter pg_bad               = 4'b0001;
parameter pg_err1              = 4'b0010;
parameter pg_err2              = 4'b0011;
parameter pg_err5              = 4'b0100;
parameter pg_err100            = 4'b0101;
parameter pg_erase_err         = 4'b0110;  // solid erase error(ECC may be possible)
parameter pg_erase_ecc_err     = 4'b0111;  // solid erase error(ECC impossible)
parameter pg_prog_in_erase_err = 4'b1000;  // erase & program error
parameter pg_1erase_err        = 4'b1001;  // one time erase error(ECC impossible)

//=================== 
// STATE DECLARATION
//=================== 
//-- bank state
parameter bk_reset     = 4'bxxxx;
parameter bk_ready     = 4'd0;
parameter bk_read      = 4'd1;
parameter bk_prog      = 4'd2;
parameter bk_erase     = 4'd3;
parameter bk_erase_dis = 4'd4;
parameter bk_erase_ver = 4'd5;
parameter bk_cache_trn = 4'd6;
parameter bk_cache_prg = 4'd7;
parameter bk_dep_recov = 4'd8;

//-- buffer state
parameter bf_invalid   = 1'd0;
parameter bf_valid     = 1'd1;

//-- address latch state
parameter prohibition  = 0;
parameter full_addr0   = 1;
parameter full_addr1   = 2;
parameter full_addr2   = 3;
parameter full_addr3   = 4;
parameter col_addr0    = 5;
parameter col_addr1    = 6;
parameter row_addr0    = 7;
parameter row_addr1    = 8;
parameter addr00       = 9;
parameter ignore       = 10;

//-- read control state
//        prohibition  = 0  <-- share (address)
parameter data_out     = 1;
parameter status_70    = 2;
parameter status_71    = 3;
parameter status_72    = 4;
parameter status_73    = 5;
parameter status_74    = 6;
parameter status_75    = 7;
parameter status_76    = 8;
parameter id_man_out   = 9;
parameter id_dev_out   = 10;

//-- main state
parameter init_state        = 0;
parameter ready             = 1;
// read
parameter read_addr_in      = 2;
parameter read_2nd_cmd      = 3;
parameter read_data_trans   = 4;
parameter read_mb_addr_in   = 5;
parameter read_mb_cmd       = 6;
parameter read_col_in       = 7;
// erase
parameter erase_row_in      = 8;
parameter erase_2nd_cmd     = 9;
parameter erase_verify      = 10;
// program
parameter prog_addr_in      = 11;
parameter prog_data_in      = 12;
parameter prog_col_in       = 13;
parameter prog_mb_bsy       = 14;
parameter prog_bsy          = 16;
parameter prog_cache_bsy    = 17;
parameter prog_cache_next   = 18;
// read id
parameter id_addr_in        = 19;
// deep standby
parameter deep_standby      = 20;
// deplete recovery
parameter deplete_recovery_bsy = 21;

//================= 
// NET DECLARATION
//================= 
wire [7:0] io;
wire cle, ale, ce_n, re_n, we_n, wp_n, pre;


//====================== 
// REGISTER DECLARATION
//====================== 
//----- memory array
reg [7:0] mem_array [(memory_size_alloc-1):0];
reg [15:0] row [no_of_page:0];

//----- good/bad page status
reg [3:0] page_status [(no_of_page-1):0];

//----- page program counter
reg [3:0] page_program_count [(no_of_page-1):0];

//----- deplete enable, deplete block address
reg [3:0] deplete_en;
reg [15:0] deplete_block [3:0];

//-- page buffer(bank)
reg [7:0] page_buffer [((size_of_page)*4 -1):0];

//-- buffer address, erase address, work address
reg [27:0] bank_address [3:0];
reg [27:0] program_address [3:0];
reg [27:0] erase_address [3:0];
reg [27:0] last_cache_address [3:0];
reg [27:0] work_address;
reg [27:0] ret_work_address;

//-- bank mem_array & buffer state
reg [3:0] bank_state;
reg [3:0] buf_state;

//-- program bank counter, last bank
reg [2:0] prog_count;
reg [1:0] prog_bank;

//-- error code, status code
reg [7:0] output_status70;
reg [7:0] output_status71;
reg [7:0] output_status72;
reg [7:0] output_status_bk [3:0];
reg [7:0] output_status_bk0;
reg [7:0] output_status_bk1;
reg [7:0] output_status_bk2;
reg [7:0] output_status_bk3;
reg prev_status_bk0;
reg prev_status_bk1;
reg prev_status_bk2;
reg prev_status_bk3;
reg last_page_stat;

//-- output reg
reg [7:0] output_data;
reg [7:0] io_reg;

//-- ready/busy output register
reg rb_reg;
reg rb_reg_11h;

//-- I/O register
reg out_gate_ce;
reg out_gate_re;

//-- now/prev command
reg [7:0] command_reg;
reg [7:0] prev_command_reg;

//-- work
reg [7:0] work_reg;
reg [27:0] tmp_addr;
reg [3:0] pstat;
reg [3:0] pcount;
reg [31:0] rand_data;
reg [3:0] address_in;

//-- Variables used for generating edge detected signal
reg prev_cle;
reg prev_ale;
reg prev_ce_n;
reg prev_re_n;
reg prev_we_n;
reg prev_wp_n;
reg prev_pre;
reg prev_res_n;
reg prev_rb_reg;
reg [7:0]prev_io;

reg cle_risingedge;
reg ale_risingedge;
reg ce_n_risingedge;
reg re_n_risingedge;
reg we_n_risingedge;
reg wp_n_risingedge;
reg pre_risingedge;
reg res_n_risingedge;
reg rb_risingedge;

reg cle_fallingedge;
reg ale_fallingedge;
reg ce_n_fallingedge;
reg re_n_fallingedge;
reg we_n_fallingedge;
reg wp_n_fallingedge;
reg pre_fallingedge;
reg res_n_fallingedge;
reg rb_fallingedge;


reg res_rb0_flg;
reg res_rb1_flg;
reg wait_1u_flg;
reg wait_tDBSY_flg;
reg wait_tDBSY_err_flg;
reg idout_flg;
reg copy_back_flg;
reg data_recovery_flg;
reg cache_flg;
reg data_input_in_erase_flg;
reg verify_flg;
reg reset_flg;
reg prog_busy_flg;
reg read_busy_flg;
reg erase_busy_flg;
reg erase_verify_busy_flg;
reg deplete_recovery_busy_flg;
reg erase_err_flg;
reg erase_err_1t_flg;
reg prog_in_erase_err_flg;

//===================== 
// INTEGER DECLARATION
//===================== 
integer i, j, k, l;
integer rand_seed_val;

//-- state/flag
integer main_state;
integer ret_main_state;
integer addr_state;
integer re_state;
integer command_type;
integer data_input_en;
integer ret_data_input_en;
integer pre_en;
integer multi_bank;
integer program_start_en;
integer command_input_en;
integer command_latch_in_bsy;

//================== 
// TIME DECLARATION
//================== 
time bank_wait_time;
time b_cache_end;
time bk_cache_end [3:0];

//=================== 
// EVENT DECLARATION
//=================== 
//-- command check
event command_trigger;
event wait_bank;
event wait_1u;
event c_prg_start;
event erase_start;

//============================== 
// TIMING PARAMETER DECLARATION
//============================== 
//----- Program/Erase Characteristics
parameter tPROG_typ    =    600_000;
parameter tPROG_max    =   1000_000;
parameter tCPROG_typ   =    600_000;
parameter tCPROG_max   =   2000_000;
parameter tCBSY_typ    =      3_000;
parameter tCBSY_max    =   1000_000;
parameter tDBSY_min    =      1_000;
parameter tDBSY_max    =      4_000;
parameter tBERS_typ    =    650_000;
parameter tBERS_max    =  2_400_000;
parameter tPEV_max     =     50_000;
parameter tBEV_max     =     70_000;

//----- AC Characteristics for Operation
parameter tR_max       = 100_000;
parameter tREA_max     =  20;
parameter tRHZ_min     =  10;
parameter tRHZ_max     =  20;
parameter tCHZ_min     =   0;
parameter tCHZ_max     =  20;
parameter tWB_max      = 100;
parameter tCEA_max     =  25;
parameter tRSTR_max    =  20_000;
parameter tRSTP_max    =  70_000;
parameter tRSTE_max    = 400_000;
parameter tRSTEV_max   =  30_000;
parameter tRSTDR_max   = 350_000;
parameter tPON_max     = 200_000;
parameter tVRDY_max    =  20_000;
parameter tBSY_max     = 100;

//-- Deplete
parameter tDRC_max   = 100_000_000;
parameter tDRC_typ   = 890_000;

//----- AC Timing Characteristics for Command/Address/Data Input
parameter tCLS_min     =   0;
parameter tCLH_min     =   9;
parameter tCS_min      =   0;
parameter tCH_min      =   6;
parameter tWP_min      =  15;
parameter tWPCE        =  20;
parameter tALS_min     =   0;
parameter tALH_min     =   6;
parameter tDS_min      =   9;
parameter tDH_min      =   9;
parameter tWC_min      =  33;
parameter tWH_min      =  12;
parameter tRWDSE_min   = 100;
parameter tCSD_min     = 100;
parameter tVRS_min     =  20_000;

//----- AC Characteristics for Operation
parameter tCLR_min     =   6;
parameter tAR1_min     =  20;
parameter tAR2_min     =  30;
parameter tWHR_min     =  50;
parameter tRR_min      =  20;
parameter tIR_min      =   0;
parameter tRP_min      =  20;
parameter tREH_min     =  10;
parameter tRC_min      =  35;
parameter tWWS_min     =  15;
parameter tWWH_min     =  15;

//----- Add AC Timming '030825
parameter tCHWS_min     =   5;
parameter tWHCH_min     =   5;
parameter tCHRS_min     =   5;
parameter tRHCH_min     =   5;

//----- Time variables declations
time io_change_t; 
time cle_rise_t;
time cle_fall_t;
time ale_rise_t;
time ale_fall_t;
time ce_n_rise_t;
time ce_n_fall_t;
time re_n_rise_t;
time re_n_fall_t;
time we_n_rise_t;
time we_n_fall_t;
time wp_n_rise_t;
time wp_n_fall_t;
time rb_rise_t;
time rb_fall_t;
time pre_rise_t;
time pre_fall_t;
time res_n_rise_t;
time res_n_fall_t;
//time res_n_rb0_fall_t;
time re_n_rise_ce_h_t;
time we_n_rise_ce_h_t;

//** task *********************************************************************

//-----------------------------------------------------------------------------
// Name   : display_error
// Input  : message string  (80 char max)
// Note   : display error message and stop simulation
//-----------------------------------------------------------------------------
task display_error;
input [1:8*80] message;
begin
  
  if(error_msg_en)   
  begin 
    $display("\n*********************************************************************");             
    $display(" Error: ( %m )  time = %0t", $realtime);           
    $display("  %0s", message);           
    $display("*********************************************************************");      
  end 
  if(non_stop_sim_en == 1'b0)
     $finish;

end
endtask        // end of display_error task

//-----------------------------------------------------------------------------
// Name   : display_warning
// Input  : message string  (80 char max)
// Note   : display warning message
//-----------------------------------------------------------------------------
task display_warning;
input [1:8*80] message;
begin
  $display("\n---------------------------------------------------------------------");             
  $display(" Warning: ( %m )  time = %0t", $realtime);           
  $display("  %0s", message);           
  $display("---------------------------------------------------------------------");      
end
endtask        // end of display_error task

//-----------------------------------------------------------------------------
// Name   : edgedetector
// Input  : prevval (Previous value of the signal)
//          currentval (Current value of the signal)
// Output : risingedge (TRUE when there is risingedge)
//          fallingedge(TRUE when there is fallingedge)
// Note   : this procedure will detect the edge on the input pin
//-----------------------------------------------------------------------------
task edgedetector;

inout  prevval;
input  currentval;
output risingedge;
output fallingedge;

begin
  if(currentval !== prevval)
  begin
    if(prevval === 1'b0 )
    begin
      risingedge     = 1;
      fallingedge    = 0;
    end
    else if(prevval === 1'b1)
    begin
      risingedge     = 0;
      fallingedge    = 1;
      if (currentval === 1'bx)
         fallingedge = 0;
    end
    else
    begin
      //here prevval is either z or x.
      if(currentval === 1'b1)
      begin
         risingedge  = 0;
         fallingedge = 0;
      end
      else if(currentval === 1'b0)
      begin
         risingedge  = 0;
         fallingedge = 1;
      end
      else
         begin   end
    end
  end
  else
  begin
    risingedge       = 0;
    fallingedge      = 0;
  end
end
endtask // End of edge detector task

//-----------------------------------------------------------------------------
// Name   : edgedetector2
// Input  : prevval (Previous value of the signal)
//          currentval (Current value of the signal)
// Output : risingedge (TRUE when there is risingedge  (0->1) )
//          fallingedge(TRUE when there is fallingedge (1->0) )
// Note   : this procedure will detect the edge on the input pin
//-----------------------------------------------------------------------------
task edgedetector2;

inout  prevval;
input  currentval;
output risingedge;
output fallingedge;

begin
  if(currentval !== prevval)
  begin
    if(prevval === 1'b0 && currentval === 1'b1)
    begin
      risingedge     = 1;
      fallingedge    = 0;
    end
    else if(prevval === 1'b1 && currentval === 1'b0)
    begin
      risingedge     = 0;
      fallingedge    = 1;
    end
    else
    begin
      risingedge  = 0;
      fallingedge = 0;
    end
  end
  else
  begin
    risingedge  = 0;
    fallingedge = 0;
  end
end
endtask // End of edge detector2 task

//-----------------------------------------------------------------------------
// Name   : getmem
// Input  : address
// Output : memory data
// Note   : If the page is not writing in, 'erased_dat' is returned.
//-----------------------------------------------------------------------------
task getmem;
  input [27:0] addr;
  output [7:0] result;

  reg [15:0] rw;
  reg [11:0] cl;
  reg pg;
  reg [3:0] s0, s1;
  reg [1:0] bk;
  reg [14:0] dp;

  begin
    rw = addr[27:12];
    cl = addr[11:0];
    pg = addr[14];
    s0 = page_status[{rw[15:3],1'b0,rw[1:0]}];
    s1 = page_status[{rw[15:3],1'b1,rw[1:0]}];
    bk = addr[13:12];
    dp = deplete_block[bk];
    if( deplete_en[bk] === 1'b1 && dp[14:10] === addr[27:23])
    begin //-- deplete area
      result = deplete_dat;
    end
    else
    begin //-- normal block
      if(row[rw] === {16{1'bx}})
      begin
        //if(pg === 1'b0 && s0 !== pg_bad  && s1 !== pg_bad)
        if(s0 !== pg_bad  && s1 !== pg_bad)
        begin
          case( cl )
            12'h820 : result = 8'h1c;
            12'h821 : result = 8'h71;
            12'h822 : result = 8'hc7;
            12'h823 : result = 8'h1c;
            12'h824 : result = 8'h71;
            12'h825 : result = 8'hc7;
            default : result = erased_dat;
          endcase
        end
        else
          result = erased_dat;
      end
      else
        result = mem_array[(row[rw]*size_of_page+cl)];
    end
  end
endtask

//-----------------------------------------------------------------------------
// Name   : setmem
// Input  : address, data
// Note   : If mem_array is full, display error message and stop simulation.
//-----------------------------------------------------------------------------
task setmem;
  input [27:0] addr;
  input [7:0] dat;

  reg [15:0] rw;
  reg [11:0] cl;
  reg pg;
  reg [3:0] s0, s1;
  reg [1:0] bk;
  reg [14:0] dp;

  begin
    rw = addr[27:12];
    cl = addr[11:0];
    pg = addr[14];
    s0 = page_status[{rw[15:3],1'b0,rw[1:0]}];
    s1 = page_status[{rw[15:3],1'b1,rw[1:0]}];

    bk = addr[13:12];
    dp = deplete_block[bk];
    if(deplete_en[bk] === 1'b1 && dp[14:10] === addr[27:23])
    begin //-- deplete area
      display_error("Since there is a depleted bit in this area, it cannot program/erase.");
    end
    else
    begin //-- normal block
      if(wp_n !== 1'b0)
      begin
        if(row[rw] === {16{1'bx}})
        begin
          if(row[no_of_page] < page_alloc)
          begin
            row[rw] = row[no_of_page];
            row[no_of_page] = row[no_of_page]+1;
            //if(pg === 1'b0 && s0 !== pg_bad  && s1 !== pg_bad)
            if(s0 !== pg_bad  && s1 !== pg_bad)
            begin
              mem_array[(row[rw]*size_of_page+12'h820)] = 8'h1c;
              mem_array[(row[rw]*size_of_page+12'h821)] = 8'h71;
              mem_array[(row[rw]*size_of_page+12'h822)] = 8'hc7;
              mem_array[(row[rw]*size_of_page+12'h823)] = 8'h1c;
              mem_array[(row[rw]*size_of_page+12'h824)] = 8'h71;
              mem_array[(row[rw]*size_of_page+12'h825)] = 8'hc7;
            end
          end
          else
            display_error("Data set error. Please increase the value of 'no_of_page_alloc'.");
        end
        mem_array[(row[rw]*size_of_page+cl)] = dat;
      end
    end
  end
endtask

//-----------------------------------------------------------------------------
// Name   : clear_buffer
// Input  : bank_no
//-----------------------------------------------------------------------------
task clear_buffer;
  input [1:0] bank_no;

  integer i,j;
  begin
    for(i = 0; i < size_of_page; i = i + 1)
      page_buffer[ size_of_page*bank_no + i ] = erased_dat;
  end
endtask

//-----------------------------------------------------------------------------
// Name   : set_error_bit
// Input  : address
// Note   : 1-n error bits are set to a mem_array (page).
//-----------------------------------------------------------------------------
task set_error_bit;
  input [27:0] addr;
  input [7:0] n;

  reg [15:0] rw;
  reg [11:0] cl;
  reg [2:0] b;
  reg [7:0] tmp_dat;
  integer cnt;

  begin
    rw = addr[27:12];
    cl = {$random(rand_seed_val)} % size_of_page;
    b  = {$random(rand_seed_val)} % 8;
    for(cnt = 0; cnt < n; cnt = cnt + 1)
    begin
      tmp_dat = mem_array[(row[rw]*size_of_page+cl)];
      tmp_dat[b] = ~tmp_dat[b];
      mem_array[(row[rw]*size_of_page+cl)] = tmp_dat;
      cl = {$random(rand_seed_val)} % size_of_page;
      b  = {$random(rand_seed_val)} % 8;
    end
  end
endtask

//-----------------------------------------------------------------------------
// Name   : read_buf
// Input  : address
// Note   : address to col
//-----------------------------------------------------------------------------
task read_buf;
  input [27:0] address;
  output [7:0] result;
  reg [27:0] tmp_addr;
  begin
    tmp_addr = bank_address[address[13:12]];
    if(buf_state[address[13:12]] !== bf_valid)
      display_warning("There is no valid data in the buffer. The data outputted is invalid.");
    else if(address[27:14] !== tmp_addr[27:14])
      display_error("The specified address differs from the address transmitted to the buffer.");
    result = page_buffer[address[13:12]*size_of_page + address[11:0]];
  end
endtask

//-----------------------------------------------------------------------------
// Name   : dev_reset
// Note   : device reset
//-----------------------------------------------------------------------------
task dev_reset;
begin
  // operation cancel
  disable b_wait;
  disable p_wait;
  disable u_wait;
  disable e_wait;

  //-- register & work address
  output_data     = {8{1'bx}};
  out_gate_ce     = (ce_n == 1'b0)?1'b1:1'b0;
  out_gate_re     = (re_n == 1'b0)?1'b1:1'b0;
  work_address[i] = {28{1'bx}};

  //-- bank init
  for(i = 0; i < 4; i = i + 1)
  begin
    bank_address[i]       = {28{1'bx}};
    program_address[i]    = {28{1'bx}};
    erase_address[i]      = {28{1'bx}};
    last_cache_address[i] = {28{1'bx}};
//    clear_buffer(i);
  end
  last_page_stat  = 1'b0;
  prev_status_bk0 = 1'b0;
  prev_status_bk1 = 1'b0;
  prev_status_bk2 = 1'b0;
  prev_status_bk3 = 1'b0;
  prog_count = 0;
  //-- state/flag
  addr_state  = prohibition;
  re_state    = prohibition;
  buf_state   = {4{bf_invalid}};
  bank_state  = bk_reset;
  cache_flg   = 1'b0;
  b_cache_end = $realtime;
  bk_cache_end[0] = $realtime;
  bk_cache_end[1] = $realtime;
  bk_cache_end[2] = $realtime;
  bk_cache_end[3] = $realtime;
  address_in           = 4'b0000;
  pre_en               = f_enable;
  multi_bank           = f_disable;
  command_latch_in_bsy = f_disable;
  copy_back_flg           = 1'b0;
  data_recovery_flg       = 1'b0;
  data_input_in_erase_flg = 1'b0;
  idout_flg               = 1'b0;
  wait_1u_flg             = 1'b0;
  wait_tDBSY_flg             = 1'b0;
  wait_tDBSY_err_flg         = 1'b0;
  erase_err_flg           = 1'b0;
  erase_err_1t_flg        = 1'b0;
  prog_in_erase_err_flg   = 1'b0;
end
endtask

//** function *****************************************************************
//-----------------------------------------------------------------------------
// Name   : getbank
// Input  : address
// Note   : address to bank-no
//-----------------------------------------------------------------------------
function [(bank_width-1):0] getbank;
  input [27:0] address;
  begin
    getbank = address[13:12];
  end
endfunction

//-----------------------------------------------------------------------------
// Name   : getrow
// Input  : address
// Note   : address to row
//-----------------------------------------------------------------------------
function [15:0] getrow;
  input [27:0] address;
  begin
    getrow = address[27:12];
  end
endfunction

//-----------------------------------------------------------------------------
// Name   : getcol
// Input  : address
// Note   : address to col
//-----------------------------------------------------------------------------
function [11:0] getcol;
  input [27:0] address;
  begin
    getcol = address[11:0];
  end
endfunction

//-----------------------------------------------------------------------------

assign rb = rb_reg & rb_reg_11h;

//** init *********************************************************************
initial
begin
   prev_cle                = 1'bx;
   prev_ale                = 1'bx;
   prev_ce_n               = 1'bx;
   prev_re_n               = 1'bx;
   prev_we_n               = 1'bx;
   prev_wp_n               = 1'bx;
   prev_pre                = 1'bx;
   prev_res_n              = 1'bx;
   prev_rb_reg             = 1'bx;

   cle_risingedge          = 1'b0;
   ale_risingedge          = 1'b0;
   ce_n_risingedge         = 1'b0;
   re_n_risingedge         = 1'b0;
   we_n_risingedge         = 1'b0;
   wp_n_risingedge         = 1'b0;
   pre_risingedge          = 1'b0;
   res_n_risingedge        = 1'b0;
   rb_risingedge           = 1'b0;

   cle_fallingedge         = 1'b0;
   ale_fallingedge         = 1'b0;
   ce_n_fallingedge        = 1'b0;
   re_n_fallingedge        = 1'b0;
   we_n_fallingedge        = 1'b0;
   wp_n_fallingedge        = 1'b0;
   pre_fallingedge         = 1'b0;
   res_n_fallingedge       = 1'b0;
   rb_fallingedge          = 1'b0;

   res_rb0_flg             = 1'b0;
   res_rb1_flg             = 1'b0;
   wait_1u_flg             = 1'b0;
   wait_tDBSY_flg             = 1'b0;
   wait_tDBSY_err_flg         = 1'b0;
   idout_flg               = 1'b0;
   copy_back_flg           = 1'b0;
   data_recovery_flg       = 1'b0;
   cache_flg               = 1'b0;
   data_input_in_erase_flg = 1'b0;
   verify_flg              = 1'b0;
   reset_flg               = 1'b0;
   prog_busy_flg           = 1'b0;
   read_busy_flg           = 1'b0;
   erase_busy_flg          = 1'b0;
   erase_verify_busy_flg   = 1'b0;
   deplete_recovery_busy_flg = 1'b0;
   erase_err_flg             = 1'b0;
   erase_err_1t_flg          = 1'b0;
   rb_reg_11h                = 1'b1;


// stampted time variables Initializaton
  ce_n_fall_t               = -1 * tCS_min;
  ce_n_rise_t               = -1 * tCH_min;
  we_n_fall_t               = -1 * tWC_min;
  we_n_rise_t               = -1 * tWH_min;
  re_n_fall_t               = -1 * tRC_min;
  re_n_rise_t               = -1 * tREH_min;
  wp_n_fall_t               = -1 * tWWS_min;
  wp_n_rise_t               = -1 * tWWH_min;
  cle_fall_t                = -1 * tCLH_min;
  cle_rise_t                = -1 * tCLS_min;
  ale_fall_t                = -1 * tAR1_min;
  ale_rise_t                = -1 * tALS_min;
  io_change_t               = -1 * tDS_min;

  rb_rise_t                = -1 * tRR_min;
  pre_fall_t               = 0;
  res_n_rise_t             = 0;
  res_n_fall_t             = 0;

  we_n_rise_ce_h_t         = -1 * tWH_min;
  re_n_rise_ce_h_t         = -1 * tREH_min;

  deplete_en[0]    = deplete_bank0_en;
  deplete_en[1]    = deplete_bank1_en;
  deplete_en[2]    = deplete_bank2_en;
  deplete_en[3]    = deplete_bank3_en;
  deplete_block[0] = deplete_bank0;
  deplete_block[1] = deplete_bank1;
  deplete_block[2] = deplete_bank2;
  deplete_block[3] = deplete_bank3;
  main_state       = deep_standby;
  rand_seed_val    = rand_seed;
  rand_data        = $random(rand_seed_val);
  //-- memory array
  for(i = 0; i < memory_size_alloc; i = i + 1)
    mem_array[i]  = erased_dat;
  for(i = 0; i < no_of_page; i = i + 1)
    row[i] = {16{1'bx}};
  row[no_of_page] = 16'h0000;
  if(init_mem_en === 2'd1)
  begin //-- initialize page 0 & 4
    row[16'h0000]   = 16'h0000;
    row[16'h0004]   = 16'h0001;
    row[no_of_page] = 16'h0002;
    $readmemh("page0.mem", mem_array, 0, (size_of_page-1));
    $readmemh("page4.mem", mem_array, size_of_page, (size_of_page*2-1));
  end
  else if(init_mem_en === 2'd2)
  begin //-- initialize memory array & row index
    $readmemh("mem_array.dat", mem_array, 0);
    $readmemh("row_array.dat", row, 0);
  end
  //-- initialize good/bad page status
  if(init_page_stat === 1'b1)
  begin
    $readmemh("init.stat", page_status, 0, (no_of_page-1));
  end
  else
  begin
    for(i = 0; i < no_of_page; i = i + 1)
      page_status[i] = pg_good;
    if(program_err_en === 1'b1)
    begin
      page_status[bad_page]     = pg_bad;
      page_status[err_page_1]   = pg_err1;
      page_status[err_page_2]   = pg_err2;
      page_status[err_page_5]   = pg_err5;
      page_status[err_page_100] = pg_err100;
    end
    if(erase_err_en === 1'b1)
      page_status[erase_err_page] = pg_erase_err;
    if(erase_err_ecc_en === 1'b1)
      page_status[erase_err_ecc_page] = pg_erase_ecc_err;
    if(prog_in_erase_err === 1'b1)
      page_status[prog_in_erase_page] = pg_prog_in_erase_err;
    if(erase_err_1t_en === 1'b1)
      page_status[erase_err_1t_page] = pg_1erase_err;
  end
  for(i = 0; i < no_of_page; i = i + 1)
    page_program_count[i] = 4'd0;
  main_state = deep_standby;
  if(power_on_skip === 1'b0) #(tVRDY_max);
  else #0;
  dev_reset;
  output_status70     = {8{1'b0}};
  output_status71     = {8{1'b0}};
  output_status72     = {8{1'b0}};
  output_status_bk[0] = {8{1'b0}};
  output_status_bk[1] = {8{1'b0}};
  output_status_bk[2] = {8{1'b0}};
  output_status_bk[3] = {8{1'b0}};
  clear_buffer(0);
  clear_buffer(1);
  clear_buffer(2);
  clear_buffer(3);
  bank_state = bk_ready;
  pre_en = f_disable;
  if(res_n === 1'b1)
  begin
    rb_reg = 1'b0;
    main_state = init_state;
    command_type = bank_ready; -> command_trigger;
  end
  else begin
    rb_reg = 1'b1;
  end
end

//-- output control
assign io = ( res_n === 1'b1 &&
              out_gate_ce === 1'b1 &&
              out_gate_re === 1'b1 ) ? io_reg : {8{1'bz}};

always @(negedge ce_n)
begin
  if(res_n === 1'b1)
    #(tCEA_max) out_gate_ce = 1'b1;
end
always @(posedge ce_n)
begin
  if(res_n === 1'b1)
    out_gate_ce <= #(tCHZ_min) 1'b0;
  out_gate_re <= 1'b0;
end
always @(negedge re_n)
begin
  if(res_n === 1'b1 && ce_n === 1'b0)
  begin
    #(tREA_max);
    io_reg = output_data;
    out_gate_re = 1'b1;
  end
end
always @(posedge re_n)
begin
  if(res_n === 1'b1 && ce_n === 1'b0)
  begin
    #(tRHZ_min) out_gate_re = 1'b0;
    io_reg = {8{1'bx}};
  end
end

//*****************************************************************************
always@(io or cle or ale or ce_n or re_n or we_n or wp_n or pre or res_n or rb_reg)
begin
   edgedetector(prev_cle,    cle,    cle_risingedge,     cle_fallingedge);
   edgedetector(prev_ale,    ale,    ale_risingedge,     ale_fallingedge);
   edgedetector(prev_ce_n,   ce_n,   ce_n_risingedge,    ce_n_fallingedge);
   edgedetector(prev_re_n,   re_n,   re_n_risingedge,    re_n_fallingedge);
   edgedetector(prev_we_n,   we_n,   we_n_risingedge,    we_n_fallingedge);
   edgedetector2(prev_wp_n,   wp_n,   wp_n_risingedge,    wp_n_fallingedge);
   edgedetector(prev_pre,    pre,    pre_risingedge,     pre_fallingedge);
   edgedetector(prev_res_n,  res_n,  res_n_risingedge,   res_n_fallingedge);
   edgedetector(prev_rb_reg, rb_reg, rb_risingedge,      rb_fallingedge);

//---------------------------------------------------------------------------------
//  Timing Check
//---------------------------------------------------------------------------------
   if(we_n_fallingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      if(wait_1u_flg === 1'b1 && $time - tWB_max - we_n_rise_t >= 1000)
          wait_1u_flg = 1'b0;
      if(wait_tDBSY_flg === 1'b1 && $time - tWB_max - we_n_rise_t >= tDBSY_max)
      begin
          wait_tDBSY_flg = 1'b0;
          wait_tDBSY_err_flg = 1'b0;
      end
      if(wait_tDBSY_flg === 1'b1 && $time - tWB_max - we_n_rise_t < tDBSY_max
         && cle === 1'b1 && (io === 8'h80 || io === 8'h85) )
          wait_tDBSY_err_flg = 1'b1;
      if($time - we_n_fall_t < tWC_min)
          display_warning(" Write cycle time (tWC) violation");
      if(ce_n == 1'b0)
      begin
          we_n_fall_t      = $time;
        if( rb_reg === 1'b0 && erase_busy_flg == 1'b1)
          command_latch_in_bsy = f_erase;
        if( rb_reg === 1'b0 && erase_busy_flg == 1'b0)
          command_latch_in_bsy = f_noterase;
      end
      if($time - cle_fall_t < tCLS_min || $time - cle_rise_t < tCLS_min)
          display_warning(" CLE setup time (tCLS) violation");
      if($time - ce_n_fall_t < tCS_min || $time - ce_n_rise_t < tCS_min)
          display_warning(" CE setup time (tCS) violation");
      if($time - ale_fall_t < tALS_min || $time - ale_rise_t < tALS_min)
          display_warning(" ALE setup time (tALS) violation");
      if($time - we_n_rise_t < tWH_min)
          display_warning(" WE high hold time (tWH) violation");
      if($time - ce_n_rise_t < tCHWS_min)
          display_warning(" CE high to WE low setup time (tCHWS) violation");
   end
   else if(we_n_risingedge == 1'b1 && ce_n == 1'b0 && main_state !== deep_standby && main_state !== init_state)
   begin
      we_n_rise_t      = $time;
      if(cle == 1'b1 && ((command_latch_in_bsy === f_erase && io !== 8'h80 && io !== 8'h85
         && io !== 8'h11 && io[7:4] !== 4'h7 && io !== 8'hff) 
         ||(command_latch_in_bsy === f_noterase && io[7:4] !== 4'h7 && io !== 8'hff)))
         begin
          display_error(" WE should not be drived during BUSY.");
         end
         else
           command_latch_in_bsy = f_disable;

      if($time - io_change_t < tDS_min)
          display_warning(" Data setup time (tDS) violation");
      if($time - we_n_fall_t < tWP_min)
          display_warning(" Write pulse width (tWP) violation");
      if($time - ce_n_fall_t < tWPCE)
          display_warning(" (tWP) violation. The /CE setup time is shorter than 5 ns."); 
      if($time - wp_n_rise_t < tWWS_min || $time - wp_n_fall_t < tWWS_min)
          display_error(" Wp setup time to We high (tWWS) violation");
      if(wait_1u_flg === 1'b1 && we_n_fall_t - rb_fall_t < 1000
         && cle === 1'b1 && (io === 8'h80 || io === 8'h85) && io[7:4] !== 4'h7)
          display_error(" Wait time (1us) violation");
      if(wait_tDBSY_flg === 1'b1 && wait_tDBSY_err_flg === 1'b1 && io[7:4] !== 4'h7)
          display_error(" Wait time (4us) violation");
   end
   else if(we_n_risingedge == 1'b1 && ce_n == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
       we_n_rise_ce_h_t      = $time;
   end

   if(cle_fallingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      cle_fall_t       = $time;
      if($time - we_n_rise_t < tCLH_min)
          display_warning(" CLE hold time (tCLH) violation");
      if(we_n == 1'b0 && ce_n == 1'b0)
         display_error(" CLE setup time or hold time violation");
   end
   else if(cle_risingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      cle_rise_t       = $time;
      if($time - we_n_rise_t < tCLH_min)
          display_warning(" CLE hold time (tCLH) violation");
      if(we_n_fall_t !== cle_rise_t && we_n == 1'b0 && ce_n == 1'b0)
         display_error(" CLE setup time or hold time violation");
   end

   if(ce_n_fallingedge == 1'b1 && ce_n === 1'b0)
   begin
      ce_n_fall_t      = $time;
      if(ce_n_fall_t - we_n_fall_t > 0 &&  we_n == 1'b0)
         display_error(" CE setup time (tCS) violation");
      if($time - we_n_rise_ce_h_t < tWHCH_min)
         display_warning(" WE high to CE low hold time (tWHCH) violation");
      if($time - re_n_rise_ce_h_t < tRHCH_min)
         display_warning(" RE high to CE low hold time (tRHCH) violation");
   end
   else if(ce_n_risingedge == 1'b1)
   begin
      ce_n_rise_t      = $time;
      if($time - we_n_rise_t < tCH_min)
          display_warning(" CE hold time (tCH) violation");
      if(we_n == 1'b0 && main_state !== deep_standby && main_state !== init_state)
         display_error(" CE should not be changed in WE pulse width");
   end

   if(ale_fallingedge == 1'b1 && ce_n === 1'b0 && main_state !== deep_standby && main_state !== init_state)
   begin
      ale_fall_t       = $time;
      if($time - we_n_rise_t < tALH_min)
          display_warning(" ALE hold time (tALH) violation");
      if(we_n == 1'b0 && ce_n == 1'b0)
         display_error(" ALE setup time or hold time violation");
   end
   else if(ale_risingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      ale_rise_t       = $time;
      if($time - we_n_rise_t < tALH_min)
          display_warning(" ALE hold time (tALH) violation");
      if(we_n_fall_t !== ale_rise_t && we_n == 1'b0 && ce_n == 1'b0)
         display_error(" ALE setup time or hold time violation");
   end

   if(re_n_fallingedge == 1'b1 && ce_n === 1'b0 && main_state !== deep_standby && main_state !== init_state)
   begin
      if($time - re_n_fall_t < tRC_min)
          display_warning(" Read cycle time (tRC) violation");
      re_n_fall_t      = $time;
      if($time - re_n_rise_t < tREH_min)
          display_warning(" RE high hold time (tREH) violation");
      if($time - cle_fall_t < tCLR_min)
          display_warning(" CLE to RE delay (Read cycle) (tCLR) violation");
      if($time - ale_fall_t < tAR1_min && idout_flg === 1'b1)
          display_warning(" ALE to RE delay (ID Read) (tAR1) violation");
      if($time - ale_fall_t < tAR2_min && idout_flg === 1'b0)
          display_warning(" ALE to RE delay (Read cycle) (tAR2) violation");
      if($time - we_n_rise_t < tWHR_min)
          display_warning(" WE high to RE low time (tWHR) violation");
      if($time - rb_rise_t < tRR_min && command_reg[7:4] !== 4'h7)
          display_warning(" Ready to RE fall time (tRR) violation");
      if($time - io_change_t < tIR_min)
          display_warning(" Output Hi-Z to RE Low time (tIR) violation");
   end
   else if(re_n_fallingedge == 1'b1 && ce_n === 1'b1
           && main_state !== deep_standby && main_state !== init_state)
   begin
      if($time - ce_n_rise_t < tCHRS_min)
          display_warning(" CE high to RE low setup time (tCHRS) violation");
   end
 
//   else if(re_n_risingedge == 1'b1 && ce_n === 1'b0)
   else if(re_n_risingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      re_n_rise_t           = $time;
      re_n_rise_ce_h_t      = $time;
      if($time - re_n_fall_t < tRP_min && ce_n === 1'b0)
          display_warning(" Read pulse time (tRP) violation");
   end

   if(res_n_fallingedge == 1'b1)
   begin
      res_n_fall_t      = $time;
      if(ce_n == 1'b0 && rb_reg == 1'b1 && rb_reg_11h == 1'b1)
         display_error(" DSE should not be changed during CE = LOW");
      if($time - ce_n_rise_t < tCSD_min && rb == 1'b1)
      begin
         display_warning(" CE high to DSE low setup time (tCSD) violation");
         res_rb1_flg    <= 1'b1;
      end
      if(rb === 1'b0)
      begin
         res_rb0_flg    <= 1'b1;
      end
   end
   else if(res_n_risingedge == 1'b1)
   begin
      res_n_rise_t      = $time;
      if(ce_n == 1'b0 && main_state !== deep_standby && main_state !== init_state)
         display_error(" DSE should not be changed during CE = LOW");
      if($time - res_n_fall_t < tRWDSE_min && res_rb1_flg == 1'b1)
          display_warning(" DSE pulse width violation. The minimum pulse width should be 100ns.");
      if($time - res_n_fall_t < tRSTP_max && (prog_busy_flg == 1'b1 || cache_flg == 1'b1))
          display_warning(" DSE pulse width (tRSTP) violation."); 
      if($time - res_n_fall_t < tRSTR_max && read_busy_flg == 1'b1)
          display_warning(" DSE pulse width (tRSTR) violation."); 
      if($time - res_n_fall_t < tRSTE_max && erase_busy_flg == 1'b1)
          display_warning(" DSE pulse width (tRSTE) violation.");
      if($time - res_n_fall_t < tRSTEV_max && erase_verify_busy_flg == 1'b1)
          display_warning(" DSE pulse width (tRSTEV) violation.");
      if($time - res_n_fall_t < tRSTDR_max && deplete_recovery_busy_flg == 1'b1)
          display_warning(" DSE pulse width (tRSTDP) violation.");
//      if($time - res_n_rb0_fall_t < tWDSE_min && res_rb0_flg == 1'b1)
//          display_warning(" DSE pulse width violation. The minimum pulse width should be 300us.");
      if($time - ce_n_rise_t < tVRS_min && res_rb0_flg == 1'b1)
          display_warning(" Vcc setup time to Reset time (tVRS) violation");
      if($time < tVRS_min)
          display_error(" PowerON to DSE High time (tVRS) violation");
      res_rb1_flg       <= 1'b0;
      res_rb0_flg       <= 1'b0;
      data_recovery_flg <= 1'b0;
      copy_back_flg     <= 1'b0;
      command_reg       <= 8'hff;
   end
   if($time === 0 && res_n === 1'b1)
     display_error(" PowerON to DSE High time (tVRS) violation");

   if(rb_fallingedge == 1'b1)
   begin
      rb_fall_t         = $time;
      if(command_reg == 8'h10 || command_reg == 8'h15)
         prog_busy_flg  <= 1'b1;
      if(command_reg == 8'h30 || command_reg == 8'h31 || command_reg == 8'h35)
         read_busy_flg  <= 1'b1;
      if(command_reg == 8'hd0)
         erase_busy_flg  <= 1'b1;
      if(command_reg == 8'hd2 || command_reg == 8'hd3)
         erase_verify_busy_flg <= 1'b1;
      if(command_reg == 8'h38)
         deplete_recovery_busy_flg <= 1'b1;
      if(main_state == init_state)
        reset_flg               <= 1'b0;
   end
   else if(rb_risingedge == 1'b1)
   begin
      rb_rise_t                  = $time;
      prog_busy_flg             <= 1'b0;
      read_busy_flg             <= 1'b0;
      erase_busy_flg            <= 1'b0;
      erase_verify_busy_flg     <= 1'b0;
      deplete_recovery_busy_flg <= 1'b0;
      wait_tDBSY_flg               <= 1'b0;
      wait_tDBSY_err_flg           <= 1'b0;
   end

   if(wp_n_fallingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      wp_n_fall_t       = $time;
      if(command_reg === 8'h80 || command_reg === 8'h85 || command_reg === 8'h60 )
          display_error(" Wp should not be changed in this state.");
      if($time - we_n_rise_t < tWWH_min)
          display_error(" Wp hold time to We high (tWWH) violation");
   end
   else if(wp_n_risingedge == 1'b1 && main_state !== deep_standby && main_state !== init_state)
   begin
      wp_n_rise_t       = $time;
      if(command_reg === 8'h80 || command_reg === 8'h85 || command_reg === 8'h60 )
          display_error(" Wp should not be changed in this state.");
      if($time - we_n_rise_t < tWWH_min)
          display_error(" Wp hold time to We high (tWWH) violation");
   end

   if(io !== prev_io)
   begin
      io_change_t     = $time;
      if($time -  we_n_rise_t < tDH_min)
          display_warning(" Data hold time (tDH) violation");
      if(cle === 1'b1 && we_n === 1'b0 && io === 8'h10 && rb === 1'b0 && ce_n === 1'b0)
          display_error("Don't input '10' command during busy.");
   end

//-- error check
   if($time > 0 && we_n === 1'b0 && re_n === 1'b0 && ce_n === 1'b0
                        && main_state !== deep_standby && main_state !== init_state)
       display_error("Both we_n and re_n are set to Low.");
   if((pre_risingedge == 1'b1 || pre_fallingedge == 1'b1)
                      && res_n === 1'b1 && pre_en === f_disable && $time > 0)
       display_error("Don't change pre during operation.");
   if($time > 0 && main_state == init_state && re_n_fallingedge === 1'b1 && ce_n == 1'b0)
      display_error("It is in the state which can not be read.");
   if($time > 0 && main_state !== init_state && ce_n == 1'b0 && re_n == 1'b0)
   begin
      if(cle == 1'b1)
         display_error("cle should be set to '0' in read cyele.");
      if(ale == 1'b1)
         display_error("ale should be set to '0' in read cyele.");
   end
   if(res_n === 1'bz && main_state !== init_state && main_state !== deep_standby)
      display_error("res_n should not be set to 'Hi-Z'.");

   prev_cle            = cle;
   prev_ale            = ale;
   prev_ce_n           = ce_n;
   prev_re_n           = re_n;
   prev_we_n           = we_n;
   prev_wp_n           = wp_n;
   prev_pre            = pre;
   prev_res_n          = res_n;
   prev_io             = io;
   prev_rb_reg         = rb_reg;

end
   
//** read control *************************************************************

always @(negedge re_n)
begin
  #0; //-- evaluation order control
  if(res_n === 1'b1 && ce_n === 1'b0)
  begin
    case( re_state )
      prohibition : display_error("It is in the state which can not be read.");
      data_out :
        begin
          command_input_en = f_enable;
          if(work_address === {28{1'bx}})
            display_error("The address is not specified.");
          else if(work_address[11:0] >= size_of_page)
          begin
            display_warning("It is over the last address of a page.");
            output_data = {8{1'bx}};
//            read_buf({work_address[27:12], col_max}, output_data);
          end
          else
            read_buf(work_address, output_data);
        end
      status_70 :
        begin
          if(rb_reg === 1'b1 && rb_reg_11h === 1'b1 && b_cache_end < $realtime)
            output_data = {wp_n, (rb_reg & rb_reg_11h), 1'b1, output_status70[4:0]};
          else
            output_data = {wp_n, (rb_reg & rb_reg_11h), 1'b0, output_status70[4:0]};
        end
      status_71 :
        begin
          if(rb_reg === 1'b1 && rb_reg_11h === 1'b1 && b_cache_end < $realtime)
            output_data = {wp_n, (rb_reg & rb_reg_11h), 1'b1, output_status71[4:0]};
          else
            output_data = {wp_n, (rb_reg & rb_reg_11h), 1'b0, output_status71[4:0]};
        end
      status_72 : output_data = {wp_n, (rb_reg & rb_reg_11h), output_status72[5:0]};
      status_73 :
          begin
            output_data = output_status_bk[0];
            output_data[7:6] = {wp_n, (rb_reg & rb_reg_11h)};
          end
      status_74 :
          begin
            output_data = output_status_bk[1];
            output_data[7:6] = {wp_n, (rb_reg & rb_reg_11h)};
          end
      status_75 :
          begin
            output_data = output_status_bk[2];
            output_data[7:6] = {wp_n, (rb_reg & rb_reg_11h)};
          end
      status_76 :
          begin
            output_data = output_status_bk[3];
            output_data[7:6] = {wp_n, (rb_reg & rb_reg_11h)};
          end
      id_man_out : output_data = manufa_code;
      id_dev_out : output_data = device_code;
    endcase
  end
end

always @(posedge re_n)
begin
  if(res_n === 1'b1 && out_gate_re === 1'b1)
  begin
    case( re_state )
      data_out :
        begin
          work_address = work_address + 1;
          if(work_address[11:0] >= size_of_page)
            work_address[11:0] = size_of_page;
        end
      id_man_out :
        begin
          if(we_n_fallingedge == 1'b1)
             re_state = prohibition;
          else
          begin
             re_state = id_dev_out;
             idout_flg = 1'b0;
          end
        end
      id_dev_out :
        begin
          if(we_n_fallingedge == 1'b1)
             re_state = prohibition;
          else
             re_state = id_man_out;
        end
    endcase
  end
end


//*****************************************************************************
//-- command trigger (res_n)
always @(negedge res_n)
begin
  if($realtime > 0)
  begin
    clear_buffer(0);
    clear_buffer(1);
    clear_buffer(2);
    clear_buffer(3);
    work_reg         = 8'hff;
    erase_err_flg    = 1'b0;
    erase_err_1t_flg = 1'b0;
    command_type     = cmd; -> command_trigger;
  end
end

always @(posedge res_n)
begin
  if( $realtime > 0 )
  begin
    if(power_on_skip === 1'b0) #(tBSY_max);
    else                       #0;
    pre_en       = f_disable;
    main_state   = init_state;
    command_type = bank_ready; -> command_trigger;
  end
end

//-- command trigger (we_n)
always @(posedge we_n)
begin
  if(res_n === 1'b1 && ce_n === 1'b0 && $realtime>0)
  begin
    case( {cle, ale} )
      2'b00:
        begin //-- data latch
          if(addr_state === ignore) addr_state = prohibition;
          work_reg = io;
          command_type = data; -> command_trigger;
        end
      2'b01:
        begin //-- address latch
          case( addr_state )
            prohibition : display_error("Sequence is wrong. Don't input an address in this state.");
            full_addr0 :
              begin
                work_address[7:0] = io;
                addr_state        = full_addr1;
              end
            full_addr1 :
              begin
                if(io[7:4] !== 4'b0000)
                  display_error("The bit in which the column address remained is not Low.");
                work_address[11:8] = io[3:0];
                if(work_address[11:0] > col_max)
                  display_error("Illegal address. Column too large.");
                addr_state = full_addr2;
              end
            full_addr2 :
              begin
                work_address[19:12] = io;
                addr_state          = full_addr3;
              end
            full_addr3 :
              begin
                work_address[27:20] = io;
                command_type        = addr; -> command_trigger;
                addr_state          = ignore;
              end
            ignore : #0;
            col_addr0 :
              begin
                work_address[7:0] = io;
                addr_state        = col_addr1;
              end
            col_addr1 :
              begin
                if(io[7:4] !== 4'b0000)
                  display_error("The bit in which the column address remained is not Low.");
                work_address[11:8] = io[3:0];
                if( work_address[11:0] > col_max )
                  display_error("Illegal address. Column too large.");
                command_type = addr; -> command_trigger;
                addr_state   = prohibition;
              end
            row_addr0 :
              begin
                work_address[19:12] = io;
                if(main_state === erase_row_in)
                begin
                  if(data_input_in_erase_flg === 1'b1 && work_address[13:12] !== ret_work_address[13:12])
                    display_error("The different bank was specified. Please specify same bank.");
                end
                addr_state = row_addr1;
              end
            row_addr1 :
              begin
                work_address[27:20] = io;
                command_type        = addr; -> command_trigger;
                addr_state          = prohibition;
              end
            addr00 :
              begin
                if(io !== 8'h00)
                  display_error("Input addresses is not '00H'.");
                command_type = addr; -> command_trigger;
                addr_state   = prohibition;
              end
            default : display_error("Illegal state in Address Latch Cycle.");
          endcase
        end
      2'b10:
        begin //-- command latch
          if(addr_state === ignore) addr_state = prohibition;
          work_reg = io;
          if(command_reg[7:4] !== 4'h7)
            prev_command_reg = command_reg;
          command_reg  = io;
          command_type = cmd; -> command_trigger;
        end
      default:
        begin //-- error
          display_error("Both cle and ale were set to High.");
        end
    endcase 
    if((io[0] === 1'bz || io[1] === 1'bz || io[2] === 1'bz || io[3] === 1'bz || 
        io[4] === 1'bz || io[5] === 1'bz || io[6] === 1'bz || io[7] === 1'bz ||
        io[0] === 1'bx || io[1] === 1'bx || io[2] === 1'bx || io[3] === 1'bx || 
        io[4] === 1'bx || io[5] === 1'bx || io[6] === 1'bx || io[7] === 1'bx ) &&
        $realtime > 0)
      display_error("Don't input 'High-Z'.");
  end
end

//-- command trigger (bank wait)
always @(wait_bank)
begin : b_wait
  #(tWB_max);
  rb_reg = 1'b0;
  if(bank_state !== bk_ready)
  begin
    //output_status_bk[0] = 8'b00000000;
    //output_status_bk[1] = 8'b00000000;
    //output_status_bk[2] = 8'b00000000;
    //output_status_bk[3] = 8'b00000000;
    output_status71     = 8'b00000000;
    output_status72     = 8'b00000000;
    if(bank_state === bk_cache_trn || bank_state === bk_cache_prg)
    begin
      output_status70[1]  = last_page_stat;
      output_status70     = output_status70 & 8'b00000010;
      output_status_bk[0] = {6'b000000, prev_status_bk0, 1'b0};
      output_status_bk[1] = {6'b000000, prev_status_bk1, 1'b0};
      output_status_bk[2] = {6'b000000, prev_status_bk2, 1'b0};
      output_status_bk[3] = {6'b000000, prev_status_bk3, 1'b0};
    end
    else
    begin
      output_status70     = 8'b00000000;
      output_status_bk[0] = 8'b00000000;
      output_status_bk[1] = 8'b00000000;
      output_status_bk[2] = 8'b00000000;
      output_status_bk[3] = 8'b00000000;
      last_page_stat      = 1'b0;
      prev_status_bk0     = 1'b0;
      prev_status_bk1     = 1'b0;
      prev_status_bk2     = 1'b0;
      prev_status_bk3     = 1'b0;
    end
  end
  #(bank_wait_time);
  if(bank_state === bk_cache_trn)
  begin
    bank_state = bk_cache_prg; -> c_prg_start;
  end
  else
    bank_state = bk_ready;
  command_type = bank_ready; -> command_trigger;
  rb_reg = 1'b1;
end

always @(c_prg_start)
begin : p_wait
  #(tCBSY_max - tCBSY_typ);
  bank_state = bk_ready;
end

always @(wait_1u)
begin : u_wait
  #(1000);
  if(bank_state === bk_erase_dis)
    bank_state = bk_erase;
end

always @(erase_start)
begin : e_wait
  #(tWB_max);
  rb_reg      = 1'b0; -> wait_1u;
  wait_1u_flg = 1'b1;
  output_status70 = 8'b00000000;
  output_status71 = 8'b00000000;
  output_status72 = 8'b00000000;
  #(bank_wait_time);
  for(i = 0; i < 4; i = i+1)
  begin
    tmp_addr = erase_address[i];
    if(tmp_addr !== {28{1'bx}})
    begin
      output_status_bk[i] = 8'b00000000;
      k = 0;
      for( j = 0; j < 2; j = j+1) //-- 1 block (2page)
      begin
        tmp_addr[14]   = j[0];
        tmp_addr[11:0] = 12'd0;
        page_program_count[getrow(tmp_addr)] = 1'b0;
        pstat = page_status[getrow(tmp_addr)];
        if(pstat !== pg_1erase_err)
        begin
          for(l = 0; l < size_of_page; l = l+1)
          begin
            setmem( tmp_addr, erased_dat );
            tmp_addr = tmp_addr+1;
          end
        end
        if(pstat == pg_bad || pstat == pg_erase_err || pstat == pg_erase_ecc_err
                           || pstat == pg_prog_in_erase_err || pstat == pg_1erase_err)
        begin
          case( pstat )
             pg_bad               : display_error("The page is a bad page.");
             pg_erase_err         : rand_data = 1;
             pg_erase_ecc_err     : rand_data = 100;
             pg_prog_in_erase_err : rand_data = 1;
             pg_1erase_err        : rand_data = 1;
          endcase
          if(pstat !== pg_prog_in_erase_err && pstat !== pg_erase_err)
          begin
             set_error_bit( erase_address[i], rand_data );
          end
          k = k + rand_data; //-- error bit count
          output_status_bk[i]  = 8'b00010001;
          output_status72      = output_status72 | 8'b00010001;
          output_status70[0]   = 1'b1;
          output_status71[0]   = 1'b1;
          output_status71[i+1] = 1'b1;
          if(pstat == pg_1erase_err)
          begin
             erase_err_1t_flg     = 1'b1;
             page_status[getrow(tmp_addr)] = pg_good;
          end
          else if(pstat == pg_prog_in_erase_err)
          begin
             prog_in_erase_err_flg = 1'b1;
          end
          else begin
             erase_err_flg        = 1'b1;
          end
        end
      end
      if(0 < k && k <= 10) //-- ecc available
      begin
        output_status_bk[i] = 8'b00110001;
        output_status72     = output_status72 | 8'b00110001;
      end
    end
  end
  data_input_in_erase_flg = 1'b0;
  bank_state              = bk_ready;
  rb_reg = 1'b1;
end

//*****************************************************************************
//-- main
always @(command_trigger)
begin
  if(command_type === cmd && work_reg === 8'hff)
  begin //-- Reset command
    if(main_state === prog_data_in && work_address !== {28{1'bx}})
      program_address[getbank(work_address)] = work_address;
    pre_en            = f_enable;
    command_input_en <= f_enable;
    main_state        = deep_standby;
    if((rb_reg === 1'b0 || rb_reg_11h === 1'b0)
        && bank_state !== bk_read && bank_state !== bk_erase_ver 
        && bank_state !== bk_dep_recov && bank_state !== bk_ready)
      display_warning("Since it was among BUSY, the data in a page and a buffer is not guaranteed.");
    if(b_cache_end >= $realtime) // true ready
    begin
      bank_state = bk_cache_prg;
      rb_reg     = 1'b0;
      display_warning("Since it was among BUSY (true R/B = BUSY), the data in a page and a buffer is not guaranteed.");
    end
    output_status70     = {8{1'b0}};
    output_status71     = {8{1'b0}};
    output_status72     = {8{1'b0}};
    output_status_bk[0] = {8{1'b0}};
    output_status_bk[1] = {8{1'b0}};
    output_status_bk[2] = {8{1'b0}};
    output_status_bk[3] = {8{1'b0}};
    if(bank_state === bk_prog)
      begin
        for(i = 0; i < 4; i = i+1)
        begin
          tmp_addr = program_address[i];
          if(tmp_addr !== {28{1'bx}})
          begin
            tmp_addr[11:0] = 12'd0;
            for( j = 0; j < size_of_page; j = j+1 )
            begin
              setmem( tmp_addr, broken_dat );
              tmp_addr = tmp_addr+1;
            end
            output_status_bk[i]  = 8'b00010001;
            output_status70[0]   = 1'b1;
            output_status71[0]   = 1'b1;
            output_status71[i+1] = 1'b1;
            output_status72[3]   = 1'b1;
            output_status72[0]   = 1'b1;
          end
        end
        dev_reset;
        #(tRSTP_max);
      end
    else if(bank_state === bk_cache_trn || bank_state === bk_cache_prg)
      begin
        for(i = 0; i < 4; i = i+1)
        begin
          if(bk_cache_end[i] >= $realtime)
          begin
            tmp_addr = last_cache_address[i];
            if(tmp_addr !== {28{1'bx}})
            begin
              tmp_addr[11:0] = 12'd0;
              for(j = 0; j < size_of_page; j = j+1)
              begin
                setmem( tmp_addr, broken_dat );
                tmp_addr = tmp_addr+1;
              end
              output_status_bk[i]  = 8'b00010001;
              output_status70[0]   = 1'b1;
              output_status71[0]   = 1'b1;
              output_status71[i+1] = 1'b1;
              output_status72[3]   = 1'b1;
              output_status72[0]   = 1'b1;
            end
          end
        end
        dev_reset;
        #(tRSTP_max);
      end
    else if(erase_busy_flg === 1'b1)
      begin
        for(i = 0; i < 4; i = i+1)
        begin
          tmp_addr = erase_address[i];
          if(tmp_addr !== {28{1'bx}})
          begin
            tmp_addr[11:0] = 12'd0;
            for(j = 0; j < size_of_page; j = j+1)
            begin
              setmem( {tmp_addr[27:15],1'b0,tmp_addr[13:0]}, broken_dat );
              setmem( {tmp_addr[27:15],1'b1,tmp_addr[13:0]}, broken_dat );
              tmp_addr = tmp_addr+1;
            end
            output_status_bk[i]  = 8'b00010001;
            output_status70[0]   = 1'b1;
            output_status71[0]   = 1'b1;
            output_status71[i+1] = 1'b1;
            output_status72[4]   = 1'b1;
            output_status72[0]   = 1'b1;
          end
        end
        dev_reset;
        #(tRSTE_max);
      end
    else if(bank_state === bk_erase_ver)
      begin
        for(i = 0; i < 4; i = i+1)
        begin
          tmp_addr = erase_address[i];
          if(tmp_addr !== {28{1'bx}})
          begin
            output_status_bk[i]  = 8'b00010001;
            output_status70[0]   = 1'b1;
            output_status71[0]   = 1'b1;
            output_status71[i+1] = 1'b1;
            output_status72[4]   = 1'b1;
            output_status72[0]   = 1'b1;
          end
        end
        dev_reset;
        #(tRSTEV_max);
      end
    else if(bank_state === bk_dep_recov)
      begin dev_reset; #(tRSTDR_max); end
    else if(bank_state === bk_read)
      begin dev_reset; #(tRSTR_max); end
    else #0;
    rb_reg    = 1'b1;
    reset_flg = 1'b1;
    if(res_n === 1'b0)
    begin
      main_state = deep_standby;
    end
    else
    begin
      pre_en     = f_disable;
      main_state = ready;
    end
  end
  else
  begin
    case( main_state )
      deep_standby :
        #0;
      init_state :
        if(command_type === bank_ready)
        begin
          command_input_en = f_enable;
          if(pre === 1'b1)
          begin //-- Power On Read
            command_input_en   = f_disable;
            bank_address[0]    = 28'h0000000;
            bank_address[1]    = 28'h0001000;
            bank_address[2]    = 28'h0002000;
            bank_address[3]    = 28'h0003000;
            program_address[0] = 28'h0000000;
            program_address[1] = 28'h0001000;
            program_address[2] = 28'h0002000;
            program_address[3] = 28'h0003000;
            erase_address[0]   = {28{1'bx}};
            erase_address[1]   = {28{1'bx}};
            erase_address[2]   = {28{1'bx}};
            erase_address[3]   = {28{1'bx}};
            copy_back_flg      = 1'b0;
            data_recovery_flg  = 1'b0;
            for(i = 0; i < 4; i = i+1)
            begin
              tmp_addr       = bank_address[i];
              tmp_addr[11:0] = 12'h000;
              for(j = 0; j < size_of_page; j = j+1)
              begin
                getmem( tmp_addr, work_reg );
                page_buffer[ i*size_of_page + j ] = work_reg;
                tmp_addr = tmp_addr + 1;
              end
              work_address = 28'h0000000;
              buf_state[i] = bf_valid;
            end
            re_state = data_out;
            if(power_on_skip === 1'b0)
            begin
              rb_reg = 1'b0;
              #(tR_max);
            end
            else #0;
          end
          if(power_on_skip === 1'b0)
          begin
            rb_reg = 1'b0;
            #(tPON_max);
          end
          else #0;
          rb_reg     = 1'b1;
          main_state = ready;
         end
        else if($realtime > 0)
          display_warning("The signal was changed during a power-on.");
      ready :
        if(command_type !== cmd)
          display_error("Sequence is wrong. Please input a command.");
        else if(command_input_en === f_disable)
          display_error("It is Auto Read mode. First, no commands other than FF can be inputted.");
        else
        begin
          idout_flg = 1'b0;
          if(bank_state === bk_erase_dis && io[7:4] !== 4'h7)
             display_error("Illegal command. wait 1us.");
          if(bank_state === bk_erase && work_reg !== 8'h80 && work_reg !== 8'h85 && io[7:4] !== 4'h7)
             display_error("Illegal command. Only 80h/85h can used.");
          case( work_reg )
            // read array
            8'h00 :
              begin
                bank_address[0] = {28{1'bx}};
                bank_address[1] = {28{1'bx}};
                bank_address[2] = {28{1'bx}};
                bank_address[3] = {28{1'bx}};
                re_state   = prohibition;
                addr_state = full_addr0;
                main_state = read_addr_in;
              end
            8'h06 :
              begin
                if(buf_state === {4{bf_invalid}})
                  display_error("There is no data in bank-buffers.");
                else
                  re_state   = prohibition;
                  addr_state = full_addr0;
                  main_state = read_mb_addr_in;
               end
            8'h05 :
              begin
                if(buf_state === {4{bf_invalid}})
                  display_error("There is no data in bank-buffers.");
                else
                  re_state   = prohibition;
                  addr_state = col_addr0;
                  main_state = read_col_in;
              end
            8'h60 : // erase
              begin
                if(copy_back_flg === 1'b1)
                begin
                   copy_back_flg = 1'b0;
                   display_error("copy back program is not executed.");
                end
                erase_address[0]  = {28{1'bx}};
                erase_address[1]  = {28{1'bx}};
                erase_address[2]  = {28{1'bx}};
                erase_address[3]  = {28{1'bx}};
                re_state          = prohibition;
                addr_state        = row_addr0;
                ret_work_address  = work_address;
                ret_data_input_en = data_input_en;
                ret_main_state    = main_state;
                main_state        = erase_row_in;
              end
            // program
            8'h80 :
              begin
                if(reset_flg == 1'b0 && (data_recovery_flg === 1'b1 || copy_back_flg === 1'b1))
                begin
                   if(data_recovery_flg === 1'b1)
                   begin
                      data_recovery_flg = 1'b0;
                      display_error("data recovery program is not executed."); 
                   end   
                   if(copy_back_flg === 1'b1)
                   begin
                      copy_back_flg = 1'b0;
                      display_error("copy back program is not executed.");
                   end
                   program_address[0] = {28{1'bx}};
                   program_address[1] = {28{1'bx}};
                   program_address[2] = {28{1'bx}};
                   program_address[3] = {28{1'bx}};
                   // buffer clear
                   clear_buffer(0);
                   clear_buffer(1);
                   clear_buffer(2);
                   clear_buffer(3);
                   bank_state = bk_ready;
                   // flag clear
                   prog_bank  = 2'bxx;
                   prog_count = 0;
                   cache_flg  = 1'b0;
                   re_state   = prohibition;
                   addr_state = full_addr0;
                   main_state = prog_addr_in;
                end
                if(bank_state === bk_erase) data_input_in_erase_flg = 1'b1;
                else                        data_input_in_erase_flg = 1'b0;
                if(multi_bank === f_disable || (multi_bank === f_enable && reset_flg == 1'b1))
                begin
                  program_address[0] = {28{1'bx}};
                  program_address[1] = {28{1'bx}};
                  program_address[2] = {28{1'bx}};
                  program_address[3] = {28{1'bx}};
                  // buffer clear
                  clear_buffer(0);
                  clear_buffer(1);
                  clear_buffer(2);
                  clear_buffer(3);
                  bank_state    = bk_ready;
                  // flag clear
                  prog_bank         = 2'bxx;
                  prog_count        = 0;
                  cache_flg         = 1'b0;
                  copy_back_flg     = 1'b0;
                  data_recovery_flg = 1'b0;
                  reset_flg         = 1'b0;
                  re_state          = prohibition;
                end
                addr_state = full_addr0;
                main_state = prog_addr_in;
              end
            // copy back program & data recovery
            8'h85 :
              begin
                if(bank_state === bk_erase)   data_input_in_erase_flg = 1'b1;
                else                          data_input_in_erase_flg = 1'b0;
                if(prev_command_reg == 8'h35) copy_back_flg = 1'b1;
                if(prev_command_reg == 8'h10) data_recovery_flg = 1'b1;
                if(multi_bank === f_disable)
                begin
                  bank_state = bk_ready;
                  // flag clear
                  prog_bank  = 2'bxx;
                  prog_count = 0;
                  cache_flg  = 1'b0;
                  re_state   = prohibition;
                end
                addr_state = full_addr0;
                main_state = prog_addr_in;
              end
            // read id
            8'h90 :
              begin
                addr_state = addr00;
                main_state = id_addr_in;
              end
            // read status
            8'h70 : begin re_state = status_70; end
            8'h71 : begin re_state = status_71; end
            // read error
            8'h72 : begin re_state = status_72; end
            8'h73 : begin re_state = status_73; end
            8'h74 : begin re_state = status_74; end
            8'h75 : begin re_state = status_75; end
            8'h76 : begin re_state = status_76; end
            // status mode reset
            8'h7f :
              begin 
                if(prev_command_reg === 8'he0)
                  re_state = prohibition;
                else
                  re_state = data_out;
              end
            8'h10 : // program start
              begin
                if(prev_command_reg === 8'hd0)
                   display_error("Don't input 10H command after erase.");
                if(rb_reg !== 1'b1 && rb_reg_11h !== 1'b1)
                   display_warning("Don't input 10H command during busy.");
                else
                begin
                  if(wp_n === 1'b1)
                  begin
                    if(copy_back_flg !== 1'b1 || (address_in[prog_bank] === 1'b1 && work_address[12:11] === prog_bank))
                       program_address[prog_bank] = {work_address[27:14], prog_bank, 12'd0};
                    bank_state = bk_prog;
                    if(cache_flg === 1'b1)
                    begin
                       bank_wait_time = tCPROG_max;
                       cache_flg = 1'b0;
                    end
                    else
                       bank_wait_time = tPROG_max;
                    disable b_wait; -> wait_bank;
                    main_state = prog_bsy;
                  end
                  else
                    main_state = ready;
                end
              end
            default :
              display_error("Illegal command.");
          endcase
        end
// read
      read_addr_in :
        begin
          if(command_type !== addr)
             display_error("Sequence is wrong. Please input an address.");
          else
          begin
            bank_address[getbank(work_address)] = work_address;
            main_state = read_2nd_cmd;
          end
        end
      read_2nd_cmd :
        begin
          if(command_type !== cmd)
            display_error("Sequence is wrong. Please input a command.");
          else if(work_reg === 8'h00)
          begin
            addr_state = full_addr0;
            main_state = read_addr_in;
          end
          else if(work_reg === 8'h30) // single bank read
          begin
            bank_address[0] = {work_address[27:14], 2'b00, work_address[11:0]};
            bank_address[1] = {work_address[27:14], 2'b01, work_address[11:0]};
            bank_address[2] = {work_address[27:14], 2'b10, work_address[11:0]};
            bank_address[3] = {work_address[27:14], 2'b11, work_address[11:0]};
            bank_state = bk_read;
            bank_wait_time = tR_max - tWB_max; disable b_wait; -> wait_bank;
            copy_back_flg = 1'b0;
            main_state = read_data_trans;
          end
          else if(work_reg === 8'h31) // multi bank read
          begin
            bank_state     = bk_read;
            bank_wait_time = tR_max - tWB_max; disable b_wait; -> wait_bank;
            //work_address = {28{1'bx}};
            copy_back_flg  = 1'b0;
            main_state     = read_data_trans;
          end
          else if(work_reg === 8'h35) // copy back program with data out
          begin
            bank_state     = bk_read;
            bank_wait_time = tR_max - tWB_max;  -> wait_bank;
            copy_back_flg  = 1'b1;
            address_in     = 4'b0000;
            main_state     = read_data_trans;
          end
          else if(work_reg === 8'h38) // deplete block recovery
          begin
            if(work_address[27:12] !== 16'h0000)
            begin
              display_error("Sequence error. ROW address must be 0000h.");
            end
            bank_state = bk_dep_recov;
            if(deplete_en === 4'b0000)
            begin
              bank_wait_time = tDRC_typ - tWB_max; disable b_wait; -> wait_bank;
            end
            else
            begin
              bank_wait_time = tDRC_max - tWB_max; disable b_wait; -> wait_bank;
            end
            main_state = deplete_recovery_bsy;
          end
          else
            display_error("Sequence error. Illegal command.");
        end
      read_data_trans :
        begin
          if(command_type !== bank_ready)
          begin
            if(command_type === cmd)
              case( work_reg )
                // read status
                8'h70 : begin re_state = status_70; end
                8'h71 : begin re_state = status_71; end
                // read error
                8'h72 : begin re_state = status_72; end
                8'h73 : begin re_state = status_73; end
                8'h74 : begin re_state = status_74; end
                8'h75 : begin re_state = status_75; end
                8'h76 : begin re_state = status_76; end
                default : display_error("A command cannot be inputted when busy.");
              endcase
            else
              display_error("A command cannot be inputted when busy.");
          end
          else
          begin
            for(i = 0; i < 4; i = i+1)
            begin
              if(copy_back_flg === 1'b1)
              begin
                program_address[i] = bank_address[i];
              end
              tmp_addr = bank_address[i];
              if(tmp_addr !== {28{1'bx}})
              begin
                tmp_addr[11:0] = 12'd0;
                for(j = 0; j < size_of_page; j = j+1)
                begin
                  getmem( tmp_addr, work_reg );
                  page_buffer[i*size_of_page + j] = work_reg;
                  tmp_addr = tmp_addr + 1;
                end
                buf_state[i] = bf_valid;
              end
            end
            if (re_state == prohibition)
            begin
               re_state = data_out;
            end
            main_state = ready;
          end
        end
      read_mb_addr_in :
        begin
          tmp_addr = bank_address[getbank(work_address)];
          // address check
          if(command_type !== addr)
            display_error("Sequence is wrong. Please input an address.");
          else
          begin // valid address
            //if(getrow(tmp_addr) !== getrow(work_address))
            //   display_warning("Illegal row address.");
            bank_address[getbank(work_address)] = work_address;
            main_state = read_mb_cmd;
          end 
        end
      read_mb_cmd :
        begin
          if(command_type !== cmd || work_reg !== 8'he0)
            display_error("Sequence error. It is necessary to input E0 command.");
          else
          begin
            re_state   = data_out;
            main_state = ready;
          end
        end
      read_col_in :
        begin
          if(command_type !== addr)
            display_error("Sequence is wrong. Please input an address.");
          else
          begin
            main_state = read_mb_cmd;
          end
        end
// erase
      erase_row_in :
        begin
          if(command_type !== addr)
            display_error("Sequence is wrong. Please input an address.");
          //else if(bank_address[work_address[13:12]] !== {28{1'bx}})
          else
          begin
            if(erase_address[work_address[13:12]] !== {28{1'bx}})
              display_warning("The same bank was specified. This row address is valid.");
            if(wp_n !== 1'b0)
              erase_address[getbank(work_address)] = {work_address[27:12],12'd0};
            re_state   = prohibition;
            main_state = erase_2nd_cmd;
          end
        end
      erase_2nd_cmd :
        begin
          if(command_type !== cmd)
            display_error("Sequence is wrong. Please input a command.");
          else if(work_reg === 8'h60) // input other bank address
          begin
            addr_state = row_addr0;
            main_state = erase_row_in;
          end
          else if(work_reg === 8'hd0) // block erase
          begin
            if(wp_n !== 1'b1) // write protect
            begin
              data_input_en = ret_data_input_en;
              work_address  = ret_work_address;
              main_state    = ret_main_state;
            end
            else
            begin
              for(i = 0; i < 4; i = i+1)
              begin
                tmp_addr = erase_address[i];
                if(tmp_addr !== {28{1'bx}} && tmp_addr[14] === 1'b1)
                  display_error("Erase address must select lower address in the bank.");
              end
              bank_state     = bk_erase_dis;
              bank_wait_time = tBERS_max; disable b_wait; -> erase_start;
              work_address   = {28{1'bx}};
              //main_state = ready;
              data_input_en  = ret_data_input_en;
              work_address   = ret_work_address;
              main_state     = ret_main_state;
            end
          end
          else if(work_reg === 8'hd2) // page mode erase verify
          begin
            if(wp_n !== 1'b1) // write protect
            begin
              data_input_en = ret_data_input_en;
              work_address  = ret_work_address;
              main_state    = ret_main_state;
            end
            else
            begin
              bank_state     = bk_erase_ver;
              bank_wait_time = tPEV_max; disable b_wait; -> wait_bank;
              work_address   = {28{1'bx}};
              verify_flg     = f_page;
              main_state     = erase_verify;
            end
          end
          else if(work_reg === 8'hd3) // block mode erase verify
          begin
            if(wp_n !== 1'b1) // write protect
            begin
              data_input_en = ret_data_input_en;
              work_address  = ret_work_address;
              main_state    = ret_main_state;
            end
            else
            begin
              bank_state     = bk_erase_ver;
              bank_wait_time = tBEV_max; disable b_wait; -> wait_bank;
              work_address   = {28{1'bx}};
              verify_flg     = f_block;
              main_state     = erase_verify;
            end
          end
        end
      erase_verify :
        begin
          if(command_type !== bank_ready)
          begin
            if(command_type === cmd)
              case( work_reg )
                // read status
                8'h70 : begin re_state = status_70; end
                8'h71 : begin re_state = status_71; end
                // read error
                8'h72 : begin re_state = status_72; end
                8'h73 : begin re_state = status_73; end
                8'h74 : begin re_state = status_74; end
                8'h75 : begin re_state = status_75; end
                8'h76 : begin re_state = status_76; end
                default : display_error("A command cannot be inputted when busy.");
              endcase
            else
              display_error("A command cannot be inputted when busy.");
          end
          else
          begin
            // status init
            output_status70 = 8'b00000000;
            output_status71 = 8'b00000000;
            output_status72 = 8'b00000000;
            for( i = 0; i < 4; i = i+1 )
            begin
              //tmp_addr = bank_address[i];
              tmp_addr = erase_address[i];
              if(tmp_addr !== {28{1'bx}})
              begin
                output_status_bk[i]  = 8'b00000000;
                output_status71[i+1] = 1'b0;
                if(verify_flg === f_block)
                  tmp_addr[14] = 1'b0;
                tmp_addr[11:0] = 12'h000;
                pstat = page_status[getrow(tmp_addr)];
                if(pstat === pg_bad)
                  display_warning("The page is a bad page.");
                for(j = 0; j < size_of_page; j = j+1)
                begin
                  getmem( tmp_addr, work_reg );
                  if(work_reg !== erased_dat || (pstat === pg_erase_err && erase_err_flg == 1'b1)
                  || (pstat === pg_erase_ecc_err && erase_err_flg == 1'b1))
                  begin
                    output_status_bk[i]  = 8'b00010001;
                    output_status70[0]   = 1'b1;
                    output_status71[0]   = 1'b1;
                    output_status71[i+1] = 1'b1;
                    output_status72[4]   = 1'b1;
                    output_status72[0]   = 1'b1;
                    j = size_of_page;
                  end
                  tmp_addr = tmp_addr + 1;
                end
                if(verify_flg === f_block && output_status_bk[i] === 8'b00000000)
                begin
                  tmp_addr[14]   = 1'b1;
                  tmp_addr[11:0] = 12'h000;
                  pstat = page_status[getrow(tmp_addr)];
                  if(pstat === pg_bad)
                    display_warning("The page is a bad page.");
                  for(j = 0; j < size_of_page; j = j+1)
                  begin
                    getmem( tmp_addr, work_reg );
                    if(work_reg !== erased_dat || (pstat === pg_erase_err && erase_err_flg == 1'b1)
                    || (pstat === pg_erase_ecc_err && erase_err_flg == 1'b1))
                    begin
                      output_status_bk[i]  = 8'b00010001;
                      output_status70[0]   = 1'b1;
                      output_status71[0]   = 1'b1;
                      output_status71[i+1] = 1'b1;
                      output_status72[4]   = 1'b1;
                      output_status72[0]   = 1'b1;
                      j = size_of_page;
                    end
                    tmp_addr = tmp_addr + 1;
                  end
                end
              end
            end
            data_input_en = ret_data_input_en;
            work_address  = ret_work_address;
            main_state    = ret_main_state;
          end
        end
// program
      prog_addr_in :
        begin
          if(command_type !== addr)
            display_error("Sequence is wrong. Please input an address.");
          else
          begin
            if((program_address[work_address[13:12]] !== {28{1'bx}} || work_address[13:12] === prog_bank)
                 && copy_back_flg !== 1'b1 && command_reg == 8'h80 && cache_flg == 1'b1)
               display_error("The same bank was specified. Please specify different bank.");
            if((address_in[getbank(work_address)] === 1'b0
                 && program_address[getbank(work_address)] === {28{1'bx}}) && copy_back_flg === 1'b1)
               display_error("The different bank was specified. Please specify same bank.");
            if((address_in[getbank(work_address)] === 1'b0
                 && program_address[getbank(work_address)] === {28{1'bx}})
                 && prev_command_reg == 8'hD0 && command_reg == 8'h85 && erase_err_1t_flg == 1'b1)
               display_error("The different bank was specified. Please specify same bank.");
            if((program_address[work_address[13:12]] !== {28{1'bx}}
                 || work_address[13:12] === prog_bank) && copy_back_flg !== 1'b1 && command_reg == 8'h80)
               display_warning("The same bank was specified. This row address is valid.");

            prog_bank        = work_address[13:12];
            address_in[prog_bank]      = 1'b1;
            program_address[prog_bank] = {work_address[27:14], prog_bank, 12'd0};
            prog_count       = prog_count + 1;
            data_input_en    = f_enable;
            program_start_en = f_enable;
            main_state       = prog_data_in;
          end
        end
      prog_data_in :
        begin
          if(command_type === data)
          begin
            buf_state[getbank(work_address)] = bf_valid;
            if(data_input_en === f_enable)
              begin
              if(getcol(work_address) > col_max)
              begin
                display_warning("It is over the last address of a page.");
                work_address[11:0] = col_max + 1;
              end
              else
              begin
                page_buffer[(size_of_page*getbank(work_address) + getcol(work_address))] = work_reg;
                work_address = work_address + 1;
              end
              program_start_en = f_enable;
            end
            else
              display_error("Data cannot be inputted after a status check.");
          end
          else if(command_type !== cmd)
            display_error("Sequence is wrong. Please input data or a command.");
          else
          begin
            // normal program
            case( work_reg )
              8'h85 : // input colmn address
                begin
                  addr_state = col_addr0;
                  main_state = prog_col_in;
                end
              8'h11 : // multi bank program
                begin
                  if(rb_reg !== 1'b1 && data_input_in_erase_flg === 1'b0)
                    display_warning("Don't input 11H command during busy.");
                  else
                  if(program_start_en !== f_enable)
                    display_error("Please input one or more data after an address.");
                  else
                  begin
                    if(rb_reg === 1'b0 && data_input_in_erase_flg === 1'b1)
                    begin
                      wait_tDBSY_flg     = 1'b1;
                      wait_tDBSY_err_flg = 1'b1;
                    end
                    program_address[prog_bank] = {work_address[27:14], prog_bank, 12'd0};
                    if(data_input_in_erase_flg === 1'b1)
                    begin
                       rb_reg_11h <= #(tWB_max) 1'b0;
                       rb_reg_11h <= #(tWB_max + tDBSY_max) 1'b1;
                       bank_state = bk_erase;
                       main_state = prog_mb_bsy;
                    end
                    else
                    begin
                       bank_state = bk_ready;
                       bank_wait_time = tDBSY_max; disable b_wait; -> wait_bank;
                       main_state = prog_mb_bsy;
                    end
                  end
                end
              8'h10 : // program start
                begin
                  if(prev_command_reg === 8'hd0)
                    display_error("Don't input 10H command after erase.");
                  if(rb_reg !== 1'b1 && rb_reg_11h !== 1'b1)
                    display_warning("Don't input 10H command during busy.");
                  else if(program_start_en !== f_enable)
                    display_error("Please input one or more data after an address.");
                  else
                  begin
                    if(wp_n === 1'b1)
                    begin
                       bank_state = bk_prog;
                       if(cache_flg === 1'b1) bank_wait_time = tCPROG_max;
                       else                   bank_wait_time = tPROG_max;
                       disable b_wait; -> wait_bank;
                       main_state = prog_bsy;
                    end
                    else begin
                       main_state = ready;
                    end
                  end
                end
              8'h15 : // cache program
                begin
                  if(rb_reg !== 1'b1 && rb_reg_11h !== 1'b1)
                    display_warning("Don't input 15H command during busy.");
                  else if(program_start_en !== f_enable)
                    display_error("Please input one or more data after an address.");
                  else
                  begin
                    program_address[prog_bank] = {work_address[27:14], prog_bank, 12'd0};
                    if(prog_count > 2)
                      display_error("In cash program mode, 3 pages or more are not programmable.");
                    cache_flg = 1'b1;
                    if(wp_n === 1'b1)
                    begin
                      if(bank_state === bk_ready || bank_state == bk_cache_prg)
                      begin
                        if(b_cache_end < $realtime)
                        begin
                          bank_wait_time = tCBSY_typ;
                          b_cache_end    = $realtime + tWB_max + tCBSY_max;
                        end
                        else
                        begin
                          bank_wait_time = b_cache_end - $realtime - tWB_max;
                          b_cache_end    = b_cache_end + tCBSY_max;
                        end
                        for(i = 0; i < 4; i = i+1)
                        begin
                          if(program_address[i] !== {28{1'bx}})
                          begin
                            last_cache_address[i] = program_address[i];
                            bk_cache_end[i]       = b_cache_end;
                          end
                        end
                      end
                      else
                      display_error("Specified bank is busy now.");
                      bank_state = bk_cache_trn;
                      disable b_wait; disable p_wait; -> wait_bank;
                    end
                    main_state = prog_cache_bsy;
                  end
                end
              8'h60 : // erase
                begin
                  data_input_in_erase_flg = 1'b1;
                  erase_address[0]  = {28{1'bx}};
                  erase_address[1]  = {28{1'bx}};
                  erase_address[2]  = {28{1'bx}};
                  erase_address[3]  = {28{1'bx}};
                  re_state          = prohibition;
                  addr_state        = row_addr0;
                  ret_work_address  = work_address;
                  ret_data_input_en = data_input_en;
                  ret_main_state    = ready;
                  main_state        = erase_row_in;
                end
              8'h06 :  // page data out
                begin
                  if(buf_state === {4{bf_invalid}})
                    display_error("There is no data in bank-buffers.");
                  else
                    addr_state = full_addr0;
                    main_state = read_mb_addr_in;
                  end
              default :
                begin
                   case(work_reg)
                     // read status
                     8'h70 : begin re_state = status_70; data_input_en = f_disable; end
                     8'h71 : begin re_state = status_71; data_input_en = f_disable; end
                     // read error
                     8'h72 : begin re_state = status_72; data_input_en = f_disable; end
                     8'h73 : begin re_state = status_73; data_input_en = f_disable; end
                     8'h74 : begin re_state = status_74; data_input_en = f_disable; end
                     8'h75 : begin re_state = status_75; data_input_en = f_disable; end
                     8'h76 : begin re_state = status_76; data_input_en = f_disable; end
                     default :
                        if(data_input_in_erase_flg === 1'b1)
                          display_error("Illegal command. Only 85h, 11h, ffh can used.");
                        else if(rb_reg === 1'b1)
                          display_error("Illegal command. Only 80h, 85h, 11h, 15h, 10h, ffh can used.");
                   endcase
                end
            endcase
          end
        end
      prog_col_in :
        begin
          if(command_type !== addr)
            display_error("Sequence is wrong. Please input a colmn address.");
          else
          begin
            program_start_en = f_disable;
            data_input_en    = f_enable;
            main_state       = prog_data_in;
          end
        end
      prog_mb_bsy :
        begin
          if(command_type !== bank_ready)
          begin
            if(command_type === cmd)
            begin
              if(rb_reg_11h !== 1'b1 && io[7:4] !== 4'h7 && io !== 8'hff)
                 display_error(" The command cannot be inputted when busy.");
              case( work_reg )
                // read status
                8'h70 : begin re_state = status_70; end
                8'h71 : begin re_state = status_71; end
                // read error
                8'h72 : begin re_state = status_72; end
                8'h73 : begin re_state = status_73; end
                8'h74 : begin re_state = status_74; end
                8'h75 : begin re_state = status_75; end
                8'h76 : begin re_state = status_76; end
                8'h80 : 
                  begin
                     if(data_input_in_erase_flg === 1'b1)
                     begin
                        if(bank_state === bk_erase)
                        begin
                           if(multi_bank === f_enable && reset_flg == 1'b1)
                           begin
                              program_address[0] = {28{1'bx}};
                              program_address[1] = {28{1'bx}};
                              program_address[2] = {28{1'bx}};
                              program_address[3] = {28{1'bx}};
                              // buffer clear
                              clear_buffer(0);
                              clear_buffer(1);
                              clear_buffer(2);
                              clear_buffer(3);
                              // flag clear
                              prog_bank     = 2'bxx;
                              prog_count    = 0;
                              cache_flg     = 1'b0;
                              copy_back_flg = 1'b0;
                              reset_flg     = 1'b0;
                           end
                           addr_state = full_addr0;
                           main_state = prog_addr_in;
                        end
                        else
                        begin
                           display_error("Illegal command. wait 1us.");
                        end
                     end
                     if(data_input_in_erase_flg === 1'b0 && rb_reg == 1'b1 && rb_reg_11h !== 1'b0) 
                     begin
                        if(multi_bank === f_enable && reset_flg == 1'b1)
                        begin
                           program_address[0] = {28{1'bx}};
                           program_address[1] = {28{1'bx}};
                           program_address[2] = {28{1'bx}};
                           program_address[3] = {28{1'bx}};
                           // buffer clear
                           clear_buffer(0);
                           clear_buffer(1);
                           clear_buffer(2);
                           clear_buffer(3);
                           // flag clear
                           prog_bank     = 2'bxx;
                           prog_count    = 0;
                           cache_flg     = 1'b0;
                           copy_back_flg = 1'b0;
                           reset_flg     = 1'b0; 
                        end
                        addr_state = full_addr0;
                        main_state = prog_addr_in;
                     end

                  end
                8'h85 : 
                  if(data_input_in_erase_flg === 1'b1)
                    if(bank_state === bk_erase)
                    begin
                      //copy_back_flg = 1'b1;
                      addr_state    = full_addr0;
                      main_state    = prog_addr_in;
                    end
                    else
                      display_error("Illegal command. wait 1us.");
                8'h10 :
                  if(rb_reg == 1'b1 && rb_reg_11h == 1'b1 && prev_command_reg == 8'h11 && wp_n === 1'b1)
                  begin
                    if(copy_back_flg !== 1'b1 || (address_in[prog_bank] === 1'b1 && work_address[12:11] === prog_bank))
                       program_address[prog_bank] = {work_address[27:14], prog_bank, 12'd0};
                    bank_state = bk_prog;
                    bank_wait_time = tPROG_max;
                    disable b_wait; -> wait_bank;
                    main_state = prog_bsy;
                  end
                  else
                    display_error("A command cannot be inputted when busy.");
                default : display_error("A command cannot be inputted when busy.");
              endcase
            end
            else
              display_error("Illegal command.");
          end
          else begin
            multi_bank = f_enable;
            main_state = ready;
          end
        end
      prog_bsy :
        begin
          // status init
          output_status70 = 8'b00000000;
          output_status71 = 8'b00000000;
          output_status72 = 8'b00000000;
          if(command_type !== bank_ready)
          begin
            if(command_type === cmd)
              case( work_reg )
                // read status
                8'h70 : begin re_state = status_70; end
                8'h71 : begin re_state = status_71; end
                // read error
                8'h72 : begin re_state = status_72; end
                8'h73 : begin re_state = status_73; end
                8'h74 : begin re_state = status_74; end
                8'h75 : begin re_state = status_75; end
                8'h76 : begin re_state = status_76; end
                default : display_error("A command cannot be inputted when busy.");
              endcase
            else
              display_error("A command cannot be inputted when busy.");
          end
          else
          begin
            for(i = 0; i < 4; i = i+1)
            begin
              bank_address[i] = program_address[i];
              tmp_addr        = program_address[i];
              if(tmp_addr !== {28{1'bx}} && (copy_back_flg !== 1'b1 || address_in[i] !== 1'b0))
              begin
                address_in[i]       = 1'b0;
                output_status_bk[i] = 8'b00000000;
                tmp_addr[11:0]      = 12'd0;
                for(j = 0; j < size_of_page; j = j+1)
                begin
                  if(page_buffer[i*size_of_page + j] !== erased_dat)
                  begin
                    getmem( tmp_addr, work_reg );
                    if(work_reg !== erased_dat)
                      display_error("The page is not erased.");
                    work_reg = page_buffer[ i*size_of_page + j ];
                    setmem( tmp_addr, work_reg );
                  end
                  tmp_addr = tmp_addr+1;
                end
                pcount = page_program_count[getrow(tmp_addr)];
                if(pcount < 4'd8)
                  page_program_count[getrow(tmp_addr)] = pcount + 1;
                else
                  display_warning("This page was programmed 9 times or more, without erasing.");
                pstat = page_status[getrow(tmp_addr)];
                if(pstat !== pg_good && pstat !== pg_erase_err && pstat !== pg_erase_ecc_err && pstat !== pg_1erase_err)
                begin
                  if(pstat !== pg_prog_in_erase_err)
                  begin
                     output_status_bk[i]  = 8'b00001001;
                     output_status70[0]   = 1'b1;
                     output_status71[0]   = 1'b1;
                     output_status72[0]   = 1'b1;
                     output_status72[3]   = 1'b1;
                     output_status71[i+1] = 1'b1;
                  end
                  if(pstat === pg_prog_in_erase_err && prog_in_erase_err_flg == 1'b1)
                  begin
                     output_status_bk[i]  = 8'b00001001;
                     output_status70[0]   = 1'b1;
                     output_status71[0]   = 1'b1;
                     output_status72[0]   = 1'b1;
                     output_status72[3]   = 1'b1;
                     output_status71[i+1] = 1'b1;
                  end
                  if(pstat === pg_bad)
                    display_error("The page is a bad page.");
                  if(pstat === pg_err1 || pstat === pg_err2 || pstat === pg_err5
                        || (pstat === pg_prog_in_erase_err && prog_in_erase_err_flg == 1'b1))
                  begin
                    case( pstat )
                       pg_err1              : rand_data = 1;
                       pg_err2              : rand_data = 2;
                       pg_err5              : rand_data = 5;
                       pg_prog_in_erase_err : rand_data = 5;
                    endcase
                    output_status_bk[i] = 8'b00101001;
                    output_status72[5]  = 1'b1;
                  end
                  if(pstat === pg_err100)
                  begin
                    rand_data = 100;
                  end
                  set_error_bit( program_address[i], rand_data );
                end
              end
            end
            //- flag clear
            bank_state            = bk_ready;
            prog_bank             = 2'bxx;
            prog_count            = 0;
            multi_bank            = f_disable;
            main_state            = ready;
            copy_back_flg         = 1'b0;
            data_recovery_flg     = 1'b0;
            erase_err_1t_flg      = 1'b0;
            prog_in_erase_err_flg = 1'b0;
            program_address[0]    = {28{1'bx}};
            program_address[1]    = {28{1'bx}};
            program_address[2]    = {28{1'bx}};
            program_address[3]    = {28{1'bx}};
          end
        end
      prog_cache_bsy :
        if(wp_n === 1'b1)
        begin
          // status init
          output_status70 = 8'b00000000;
          output_status71 = 8'b00000000;
          output_status72 = 8'b00000000;
          if(command_type !== bank_ready)
          begin
            if(command_type === cmd)
              case( work_reg )
                // read status
                8'h70 : begin re_state = status_70; end
                8'h71 : begin re_state = status_71; end
                // read error
                8'h72 : begin re_state = status_72; end
                8'h73 : begin re_state = status_73; end
                8'h74 : begin re_state = status_74; end
                8'h75 : begin re_state = status_75; end
                8'h76 : begin re_state = status_76; end
                default : display_error("A command cannot be inputted when busy.");
              endcase
            else
              display_error("A command cannot be inputted when busy.");
          end
          else
          begin
            for(i = 0; i < 4; i = i+1)
            begin
              bank_address[i] = program_address[i];
              tmp_addr        = program_address[i];
              if(tmp_addr !== {28{1'bx}})
              begin
                address_in[i]       = 1'b0;
                tmp_addr[11:0]      = 12'd0;
                //output_status_bk[i] = 8'b00000000;
                for(j = 0; j < size_of_page; j = j+1)
                begin
                  if(page_buffer[i*size_of_page + j] !== erased_dat)
                  begin
                    getmem( tmp_addr, work_reg );
                    if(work_reg !== erased_dat)
                      display_error("The page is not erased.");
                    work_reg = page_buffer[ i*size_of_page + j ];
                    setmem( tmp_addr, work_reg );
                  end
                  tmp_addr = tmp_addr+1;
                end
                pcount = page_program_count[getrow(tmp_addr)];
                if(pcount < 4'd8)
                  page_program_count[getrow(tmp_addr)] = pcount + 1;
                else
                  display_warning("This page was programmed 9 times or more, without erasing.");
                pstat = page_status[getrow(tmp_addr)];
                if(pstat !== pg_good && pstat !== pg_erase_err && pstat !== pg_erase_ecc_err
                                     && pstat !== pg_1erase_err && pstat !== pg_prog_in_erase_err)
                begin
                  //output_status_bk[i]  = 8'b00001001;
                  if(i == 0)
                     output_status_bk[0]  = {6'b000010, output_status_bk0[0], 1'b1};
                  if(i == 1)
                     output_status_bk[1]  = {6'b000010, output_status_bk1[0], 1'b1};
                  if(i == 2)
                     output_status_bk[2]  = {6'b000010, output_status_bk2[0], 1'b1};
                  if(i == 3)
                     output_status_bk[3]  = {6'b000010, output_status_bk3[0], 1'b1};
                  output_status70[0]   = 1'b1;
                  output_status71[0]   = 1'b1;
                  output_status72[0]   = 1'b1;
                  output_status72[3]   = 1'b1;
                  output_status71[i+1] = 1'b1;
                  if(pstat === pg_bad)
                    display_error("The page is a bad page.");
                  if(pstat === pg_err1 || pstat === pg_err2 || pstat === pg_err5)
                  begin
                    case( pstat )
                     pg_err1: rand_data = 1;
                     pg_err2: rand_data = 2;
                     pg_err5: rand_data = 5;
                    endcase
                    //output_status_bk[i] = 8'b00101001;
                    if(i == 0)
                       output_status_bk[0] = {6'b001010, output_status_bk0[0], 1'b1};
                    if(i == 1)
                       output_status_bk[1] = {6'b001010, output_status_bk1[0], 1'b1};
                    if(i == 2)
                       output_status_bk[2] = {6'b001010, output_status_bk2[0], 1'b1};
                    if(i == 3)
                       output_status_bk[3] = {6'b001010, output_status_bk3[0], 1'b1};
                    output_status72[5]  = 1'b1;
                  end
                  if(pstat === pg_err100)
                  begin
                     rand_data = 100;
                  end
                  set_error_bit( program_address[i], rand_data );
                end
                if(output_status_bk[i] === 8'b00000000) //-- success
                begin
                  program_address[i] = {28{1'bx}};
                  clear_buffer(i);
                end
              end
            end
            output_status70[1] = last_page_stat;
            last_page_stat     = output_status70[0];
            output_status_bk0  = output_status_bk[0];
            output_status_bk1  = output_status_bk[1];
            output_status_bk2  = output_status_bk[2];
            output_status_bk3  = output_status_bk[3];
            prev_status_bk0    = output_status_bk0[0];
            prev_status_bk1    = output_status_bk1[0];
            prev_status_bk2    = output_status_bk2[0];
            prev_status_bk3    = output_status_bk3[0];
            //- flag clear
            prog_count            = 0;
            prog_in_erase_err_flg = 1'b0;
            main_state            = prog_cache_next;
          end
        end
        else
          main_state = prog_cache_next;
      prog_cache_next :
        begin
          if(command_type !== cmd)
            display_error("Sequence is wrong. Please input a command.");
          else
          begin
            case( work_reg )
              // read status
              8'h70 : begin re_state = status_70; end
              8'h71 : begin re_state = status_71; end
              // read error
              8'h72 : begin re_state = status_72; end
              8'h73 : begin re_state = status_73; end
              8'h74 : begin re_state = status_74; end
              8'h75 : begin re_state = status_75; end
              8'h76 : begin re_state = status_76; end
              // program
              8'h80 :
                begin
                  program_address[0] = {28{1'bx}};
                  program_address[1] = {28{1'bx}};
                  program_address[2] = {28{1'bx}};
                  program_address[3] = {28{1'bx}};
                  prog_count         = 0;
                  re_state           = prohibition;
                  addr_state         = full_addr0;
                  main_state         = prog_addr_in;
                end
              default :
                ;
            endcase
          end
        end
      id_addr_in :
        begin
          if(command_type !== addr)
            display_error("Sequence is wrong. Please input an address 00H.");
          else
          begin
            idout_flg = 1'b1;
            re_state = id_man_out;
          end
          main_state = ready;
        end
      deplete_recovery_bsy :
        begin
          if(command_type !== bank_ready)
          begin
            if(command_type === cmd)
              case( work_reg )
                // read status
                8'h70 : begin re_state = status_70; end
                8'h71 : begin re_state = status_71; end
                // read error
                8'h72 : begin re_state = status_72; end
                8'h73 : begin re_state = status_73; end
                8'h74 : begin re_state = status_74; end
                8'h75 : begin re_state = status_75; end
                8'h76 : begin re_state = status_76; end
                default : display_error("A command cannot be inputted when busy.");
              endcase
            else
              display_error("A command cannot be inputted when busy.");
          end
          else
          begin // deplete block recovery
            for(i = 0; i < 4; i = i+1)
            begin
              if(deplete_en[i] === 1'b1)
              begin
                deplete_en[i]   = 1'b0;
                tmp_addr[27:13] = deplete_block[i];
                tmp_addr[14:0]  = {1'b0,i[1:0],12'h000};
                for(j = 0; j < size_of_page; j = j+1)
                begin
                  setmem( {tmp_addr[27:15],1'b0,tmp_addr[13:0]}, deplete_recovery_dat );
                  setmem( {tmp_addr[27:15],1'b1,tmp_addr[13:0]}, deplete_recovery_dat );
                  tmp_addr = tmp_addr + 1;
                end
              end
            end
            main_state = ready;
          end
        end
      default :
        begin
        display_error("main_state is in the state where it cannot be.");
        end
    endcase
  end
end


endmodule   
