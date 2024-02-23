//*********************************************************************************
//* Project Name           : superAND                                             *
//*                                                                               *
//* File Name              : hn29v128a1a.v                                        *
//*                                                                               *
//* Module Name            : hn29x128axa                                          *
//*                                                                               *
//* Description            : This file is a simulation model of RENESAS's         *
//*                          128Mb superAND Flash Memory (8192 x 2048 x 8-bit)    *
//*                          HN29A128A1A, HN29V128A1A and (8192 x 1024 x 16-bit)  *
//*                          HN29A128A0A, HN29V128A0A.                            *
//*                          This module supports all Functional and AC Timing    *
//*                          of the RENESAS's 128Mb superAND Flash memory.        *
//*                                                                               *
//*                          Copyright 2003 -     Renesas Technology Corp.        *
//*                                               All rights reserved.            *
//*                                                                               *
//*                          This models are provided "as is".                    *
//*                          Renesas Technology Corp. is not responsible for any  *
//*                          problems this models may cause to the customers.     *
//*                                                                               *
//* Author                 : M/s Tata Elxsi Ltd.                                  *
//*                                                                               *
//* Date Last Modified     : 31-Aug-2004                                          *
//*                                                                               *
//* Rev. History/Version   :                                                      * 
//*                          Ver 5.1  31-Aug-2004                                 *
//*                              The timing error of tWHR and tWHRS is revised.   *
//*                                                                               *
//*                          Ver 5.0  21-May-2004                                 *
//*                              Based on datasheet RJJ03C0028-0300Z Rev.3.00     *
//*                                                         (Japanese data sheet) *
//*                              The specification of stop command input timing   *
//*                              in sequential read was changed.                  *
//*                                                                               *
//*                          Ver 4.0  02-Sep-2003                                 *
//*                              Based on datasheet RJJ03C0028-0200Z Rev.2.00     *
//*                                                        (Japanese data sheet)  *
//*                              Based on datasheet REJ03C0031-0200Z Rev.2.00     *
//*                                                        (English data sheet)   *
//*                              The followings AC spec is added                  *
//*                                (1) tSRB : /RE hugh to Busy output time        *
//*                                                    in Sequential read cycle   *
//*                          Ver 3.2  11-July-2003                                *
//*                              Based on datasheet RJJ03C0028-0100Z Rev.1.00     *   
//*                                                        (Japanese data sheet)  *
//*                                                                               *
//* Input Files            : init.mem                                             *
//*                                                                               *
//* Output Files           : dump.mem                                             *
//*                                                                               *
//* THIS MODEL OPERATION IS CONFIRMED ON "CADENCE NC-VERILOG SIMULATOR "          *
//* (VER.3.3)                                                                     *
//*********************************************************************************

`timescale 1ns/1ns
`define NUM_OF_SECTORS_HASH 32

module hn29x128axa (
                     io,
                     cle,
                     ale,
                     ce_n,
                     re_n,
                     we_n,
                     wp_n,
                     rb,
                     pre,
                     mres_n,
                     dse_n,
                     dump
                    ); 
//================
//  INPUT PORTS
//================
input cle;         // Command latch enable
input ale;         // Address latch enable
input ce_n;        // Chip enable
input re_n;        // Read enable
input we_n;        // Write enable	
input wp_n;        // Write protect	
input pre;         // power on read enable	
input dse_n;       // Deep standby enable	
input dump;        // Memory dump 

//=================
//  OUTPUT PORTS
//=================
output rb;         // Ready / Busy	
output mres_n;     // Master reset output	
//================
//  INOUT PORTS
//================
inout [15:0] io;   // io[ 7:0] => Command, Address, Data input/output
                   // io[15:8] => Data input / output

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//===============================================
//    Device version parameter declaration
//===============================================

// parameter to select one out of 4 devices
parameter  DEV_TYPE             = 2'b00;      // 00 - HN29V128A1A (3.3v, x8)
                                              // 01 - HN29A128A1A (1.8v, x8)
                                              // 10 - HN29V128A0A (3.3v, x16)
                                              // 11 - HN29A128A0A (1.8v, x16)

// This parameter tells whether the device is 3.3V or 1.8V
parameter  DEV_3_3V             = !DEV_TYPE[0];

// This parameter tells whether the device is x8 or x16
parameter  DEV_X16              = DEV_TYPE[1];

// parameter for Manufacturer Code
parameter  MANUFACTURER_CODE    = 8'h07;

// parameter for base device code. This is for x8, 3.3V device (Ref data sheet 16)
parameter  BASE_CODE            = 8'h51;

// parameter for Device Code
parameter  DEVICE_CODE          = (BASE_CODE + {6'h00, DEV_TYPE});

//===============================================
//      Model User Interface Parameters	
//===============================================
parameter  FULL                = 1'b0;
parameter  HASH                = 1'b1;
parameter  ENABLE              = 1'b1;
parameter  DISABLE             = 1'b0;

//parameter  MEMORY_TYPE         = HASH;
parameter  MEMORY_TYPE         = FULL;

//parameter  PWRUP_EN            = DISABLE;
parameter  PWRUP_EN            = ENABLE;

parameter  ERROR_MSG_EN        = ENABLE;

//parameter  NON_STOP_SIM_EN     = ENABLE;
parameter  NON_STOP_SIM_EN     = DISABLE;//  DISABLE => Stop Simulation on Error
                                         //  ENABLE  => non stop simulation

//parameter  NO_WARNING_EN       = ENABLE;
parameter  NO_WARNING_EN       = DISABLE; // DISABLE => Indicate warning at standby & deepstandby when ce_n is high 
                                          // ENABLE  => No Indicate waring at standby & deepstandby when ce_n is high 
parameter  TIME_CHECK_EN       = ENABLE;

parameter  BUSY_MAX_EN         = ENABLE;
//parameter  BUSY_MAX_EN         = DISABLE; // ENABLE  => BUSY time is given as maximum value.
                                          // DISABLE => BUSY time is given as minimum or typical value.
//parameter  INIT_MEM_EN         = ENABLE;
parameter  INIT_MEM_EN         = DISABLE;//  ENABLE  => Initializes Memory from "init.mem" or "dump.mem"
                                         //  DISABLE => Does not Initialize Memory   

parameter  FRESH_OR_USED_CHIP  = ENABLE; //  ENABLE  => Fresh chip and Initializes Memory from "init.mem"
                                         //  DISABLE => Used chip and Initializes Memory from "dump.mem" 


parameter  DUMP_MEM_EN         = 1;      //  0  => Full Memory Dump, 
                                         //  1  => Partial Memory Dump  
// For Partial Dump following will specify the start and end adddress.
parameter  DUMP_START_ADDR     = 0;      //  Start address for Partial dump
parameter  DUMP_END_ADDR       = 4096;      //  End address for Partial dump


parameter  SRD_IO1_FAIL        = 1'b0;   //  0 - PASS
                                         //  1 - FAIL

parameter  DSE_WRITE_DATA      = (DEV_X16 == 1'b1) ? 16'h0F0F : 8'h0F;
parameter  ERASE_DATA          = (DEV_X16 == 1'b1) ? 16'hFFFF : 8'hFF;
parameter  DONT_CARE           = 16'hxxxx;
parameter  HIZ                 = 16'hzzzz;
parameter  DSE_READ_DATA       = (DEV_X16 == 1'b1) ? {8'hZZ,8'b1110_111Z} : 8'b1110_111Z;
parameter  NO_VALUE_DATA       = 16'h0080;
parameter  ANY_DATA            = 16'h0080;

parameter  NUM_OF_SECTORS_FULL = 8192;

parameter  BUSY_TYP            = !BUSY_MAX_EN;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  parameter declaration for flash states
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
parameter  st_power_on_off     =  5'b00000;  // POWER ON OFF STATE
parameter  st_deepstandby      =  5'b00001;  // DEEP STANDBY STATE
parameter  st_cmnd_deepstandby =  5'b00010;  // COMMAND DEEP STATNDBY STATE
parameter  st_standby          =  5'b00011;  // STANDBY STATE
parameter  st_autoread         =  5'b00100;  // AUTO READ STATE
parameter  st_setup            =  5'b00101;  // SETUP STATE
parameter  st_column_addr      =  5'b00110;  // COLUMN ADDRESS STATE
parameter  st_sector_addr      =  5'b00111;  // SECTOR ADDRESS STATE
parameter  st_program_datain   =  5'b01000;  // PROGRAM DATA INPUT STATE
parameter  st_idread_addr      =  5'b01001;  // ID READ STATE
parameter  st_program_start    =  5'b01010;  // AUTO PROGRAMMING STATE
parameter  st_rewrite_start    =  5'b01011;  // AUTO REWRITE STATE
parameter  st_erase_start      =  5'b01100;  // FLASH ERASE STATE
parameter  st_data_read        =  5'b01101;  // SERIAL SECTOR READ STATE
parameter  st_sector_read      =  5'b01110;  // SERIAL DATA READ STATE
parameter  st_srd_setup        =  5'b01111;  // STATUS REGISTER READ STATE
parameter  st_seq_read_busy    =  5'b10000;  // SEQUENTIAL READ BUSY STATE
parameter  st_seq_read_srd     =  5'b10001;  // SEQUENTIAL READ STATU READ STATE 
parameter  st_read_stop        =  5'b10010;  // READ STOP STATE
parameter  st_stop_cmd         =  5'b10011;  // READ STOP COMMAND INPUT
parameter  st_power_on_wait    =  5'b10100;  // POWER ON WAIT STATE
parameter  st_seq_read_stop    =  5'b10101;  // SEQUENTIAL READ STOP STATE

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

//==================================================================  
// Parameters for declaring Buffer to hold data
//==================================================================  
parameter  SECTOR_SIZE         = DEV_X16 ? 1024 : 2048;
parameter  PAGE_SIZE           = DEV_X16 ?  256:   512;
parameter  DATA_WIDTH          = DEV_X16 ?   16 :    8;
parameter  ALL_X               = 13'bxxxxxxxxxxxxx;

parameter  SECTOR_START        = DEV_X16 ?   22 :   23;
parameter  SECTOR_END          = DEV_X16 ?   10 :   11;
parameter  COLUMN_START        = DEV_X16 ?    7 :    8;
parameter  COLUMN_END          = DEV_X16 ?    0 :    0;
parameter  PAGE_START          = DEV_X16 ?    9 :   10;
parameter  PAGE_END            = DEV_X16 ?    8 :    9;
parameter  NUM_OF_PAGES        = 4; 

parameter  NUM_OF_SECTORS      = (MEMORY_TYPE == FULL) ? NUM_OF_SECTORS_FULL
                                                       : `NUM_OF_SECTORS_HASH;

parameter  MEMORY_SIZE         = (NUM_OF_SECTORS_FULL * SECTOR_SIZE);
//==================================================================
//  parameter declaration for Address cycles
//==================================================================
parameter  CA1                 = 2'b00;
parameter  CA2                 = 2'b01;
parameter  SA1                 = 2'b10;
parameter  SA2                 = 2'b11;

//==================================================================
//      TIMING PARAMETERS DECLARATION with respect to DEV_TYPE
//==================================================================  

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

//--DS Rev2.00 new parameter (Sep '03)
parameter  Tsrb    = DEV_3_3V ?       200 :        500; // RE high to Busy output time in Sequential read cycle
//--DS Rev3.00 new parameter (May '04)
parameter  Trws    = DEV_3_3V ?      5000 :      10000; // R/B high to /WE setup time in Sequential read cycle 

parameter  Tr       = DEV_3_3V ? (BUSY_TYP ?   80000 :    250000) : (BUSY_TYP ? 150000 :     400000); // start address access from memory cell array
parameter  Tbsy     = DEV_3_3V ? (BUSY_TYP ? 5000000 :  30000000) : (BUSY_TYP ? 5000000 :  50000000); // power on busy time
parameter  Trstp    = DEV_3_3V ? (BUSY_TYP ?       0 :    250000) : (BUSY_TYP ?       0 :    400000); // Read stop time
parameter  Trewrite = DEV_3_3V ? (BUSY_TYP ? 2200000 : 100000000) : (BUSY_TYP ? 3500000 : 150000000); // Rewrite Time
parameter  Ters     = DEV_3_3V ? (BUSY_TYP ? 2200000 : 100000000) : (BUSY_TYP ? 3500000 : 150000000); // Erase Time
parameter  Tprog    = DEV_3_3V ? (BUSY_TYP ? 1200000 :  30000000) : (BUSY_TYP ? 2000000 :  45000000); // Programming Time

//==============================
//  TIME VARIABLES DECLARATIONS
//============================== 

// These variables are stamped at the rising or falling 
// edges of respective signals 
time ce_n_fall_t;
time ce_n_rise_t;
time ce_h_we_n_rise_t;
time ce_h_re_n_rise_t;

time we_n_fall_t;
time we_n_rise_t;

time re_n_fall_t;
time re_n_rise_t;

time pre_fall_t;
time dse_n_rise_t;

time wp_n_fall_t;
time wp_n_rise_t;

time cle_fall_t;
time cle_rise_t;

time ale_fall_t;
time ale_rise_t;

time io_change_t;     // Should be stamped when io changes
time output_highz_t;  // Should be stamped when "io" changes to high-Z

time rb_rise_t;
time rb_fall_t;

time data_output_time;
time busy_start_t;
time dsby_ar_start_t;
time read_start_t;
time read_end_t;
//==============================================

//==============================================
reg [DATA_WIDTH - 1 : 0] memory [(NUM_OF_SECTORS * SECTOR_SIZE) - 1 : 0];

reg [(NUM_OF_SECTORS * NUM_OF_PAGES - 1) : 0]page_programmed;

reg [12 : 0]sector_address[(`NUM_OF_SECTORS_HASH - 1):0]; // contains the address of the sector number to check
reg [0 : 0] sector_state [NUM_OF_SECTORS - 1 : 0];

//========================
//  INTEGER  DECLARATIONS
//========================                      

integer i, j;
integer dump_mem_ptr;
integer dump_start_addr_flash;
integer dump_end_addr_flash;
integer dump_addr;         // Used for the loop count while dumping memory

integer write_buff_count;  // Used for programming and rewrite operations
integer sector_addr;       // Flash sector address input
integer column_addr;       // Flash column address input
integer page_addr;         // Flash page address input
integer page_num;          // Page number in the flash
integer addr_index;        // Used for programming,rewrite and erase operations
integer buff_index;        // Used for programming,rewrite and erase operations
integer index_offset_hash; // Used for finding the index in case of hash memory
integer dse_came_count;    // Used to count number of times dse_n has gone low during busy
integer dse_came_ar_count;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Variables used for generating edge detected signal
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-------- Command Latch Enable --------
reg prev_cle;
reg cle_risingedge;
reg cle_fallingedge;
//-------- Address Latch Enable --------
reg prev_ale;
reg ale_risingedge;
reg ale_fallingedge;
//------------- chip Enable ------------
reg prev_ce_n;
reg ce_n_risingedge;
reg ce_n_fallingedge;
//------------- Read Enable ------------
reg prev_re_n;
reg re_n_risingedge;
reg re_n_fallingedge;
//------------ Write Enable ------------
reg prev_we_n;
reg we_n_risingedge;
reg we_n_fallingedge;
//-------- Write protect Enable --------
reg prev_wp_n;
reg wp_n_risingedge;
reg wp_n_fallingedge;
//----- power on auto read Enable ------
reg prev_pre;
reg pre_risingedge;
reg pre_fallingedge;
//--------- Deep Standby Enable --------
reg prev_dse_n;
reg dse_n_risingedge;
reg dse_n_fallingedge;
//-------------- Input/Output-----------
reg [15:0]prev_io;
//-------------- Dump Enable -----------
reg prev_dump;
reg dump_risingedge;
reg dump_fallingedge;     
//---------- Ready busy signal ---------
reg prev_internal_rb;
reg internal_rb_risingedge;
reg internal_rb_fallingedge;
//-------- program start ---------------
reg prev_program_start;
reg program_start_risingedge;
reg program_start_fallingedge;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reg valid_command;            // Indicates valid command condition
reg valid_address;            // Indicates valid address condition
reg valid_datain;             // Indicates valid program data input condition
reg valid_read;               // Indicates valid read condition
reg [ 7:0]command_reg;        // To hold the command received
reg [ 7:0]prev_command_reg;
reg [23:0]flash_addr;         // To hold the flash address
reg [ 4:0]flash_state;        
reg [ 4:0]prev_flash_state;
reg [20*8 : 1] flash_state_string;

// To hold the data received during programming or rewrite operations 
reg [(DATA_WIDTH - 1) : 0]write_buff[(SECTOR_SIZE - 1) : 0];
reg [15 : 0] io_reg;          // io buffer register used for driving io bus
reg [15 : 0] data_buff;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Flags and other declarations

reg page_checked;
reg pwr_auto_r_flag;
reg first_sa;                // Indicating that first sector address cycle is over
reg first_ca;                // Indicating that first column address cycle is over
reg internal_rb;             // Used for driving the "rb" pin
reg internal_mres;           // Used for driving the "mres_n" pin
reg rb_high;                 // set when rb scheduled to high in case of busy
reg rb_high_ar;              // set to high when rb is scheduled to high in case of Auto read
reg rb_high_rd;              // set to high when rb is scheduled to high in case of normal read
reg rb_low;                  // set when rb scheduled to low in case of program / rewrite / erase
reg rb_scheduled;            // set to indicate that rb is scheduled to high
reg data_output;             // set to high when data is suppose to be sent on "io"
reg data_scheduled;          // set to indicate that data is scheduled
reg pre_came;                // set when pre signal becomes low during prog/rewrite/erasse busy
reg pre_came_rd;             // set when pre signal becomes low during read busy
reg dse_came;                // set when dse_n signal becomes low during busy
reg dse_came_during_twb_taras;
reg dse_came_ar;             // set to indicate that dse_n signal became low during auto read busy
reg dse_came_rd;             // set to indicate that dse_n signal became low during read busy
reg dse_n_risingedge_came;   // set to indicate that rising edge of dse_n has come
                             // so that the state can be changed to standby from
                             // deepstandby
reg write_error;             // set to avoid programming in case there is error in
                             // hash type memory
reg program_start;           // set to indicate that programming should take place
                             // at the instace when it is high
reg page_programming_over;   // set to indicate that programming of a page is completed

reg read_over;               // set to indicate the page end
reg search_over;             // set to indicate that hash memomry search is over once.
reg search_success;          // set to indicate that hash memomry search is successful.  
reg data_output_over;        // set to indicate that re_n has become low & data is output
reg from_deepstandby;        // set to indicate that it has entered Auto read 
                             // from deepstandby state
reg read_condition;          // set to indicate that a read condition has come in 
                             // status read case

reg manufacturer_code_read;  // set to indicate that read of manufacturer code is
                             // over in case of ID Read

reg make_mres_n_high;        // set to indicate that rb_n has become high &
                             // mres_n can be made high when pre becomes high
reg make_io_z;
reg neglect_data;
reg wp_n_status;             // This will hold the value of "wp_n" when first command
                             // (60H or 80H) comes & is checked during confirm command
                             // like DOH or 10H or 1FH.
reg dev_not_wp;              // To update the write protection status of device
reg tww_violation;           // Flag to indicate that there is tWW violation
reg send_no_value_data;      // Flag to indicate that NO_VALUE_DATA to be sent

reg rb_high_stp;             // 
reg autoread_flag;           //
reg autoread_flagx;          //
reg seqread_trhws_err;       // tRHWS error flag
reg seqread_trws_err;        // tRWS error flag
reg seqread_stop_cmd_flag;   //
reg seq_last_read_flag;      // when accessing the last column address of last sector for sequential read
reg seq_last_col_flag;
reg srd_io1_dse;             //
reg read_srd_err_flag;

//==============================================================================
//                             CONTINUOUS ASSIGNMENTS
//==============================================================================

assign io     = (DEV_X16 == 1'b1) ? io_reg : {8'hzz, io_reg[7:0]};
assign rb     = (internal_rb   == 0) ? 0 : 1'bz;
assign mres_n = (internal_mres == 0) ? 0 : 1'b1;

wire [7:0]status_reg = {dev_not_wp, internal_rb, 5'b00000, (SRD_IO1_FAIL || srd_io1_dse)};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 1) Name        : display_error
//    Purpose     : Procedure to display error messages on the screen 
//                  and simulation is controlled by parameter NON_STOP_SIM_EN
//    Arguments   : Inputs : string  (Message that is to be displayed)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task display_error;
input [1:8*100] message;
begin
  if(ERROR_MSG_EN == ENABLE)
  begin 
    $display("\n#############################################################");
    $display("\n %m : %0s at time %0t ",message,$realtime);           
    $display("\n#############################################################");
  end 
  if(NON_STOP_SIM_EN == DISABLE)
    $finish;
    //$stop;
end
endtask // end of display_error task

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 2) Name           : edgedetector
//    Purpose        : Procedure to detect the edge detection  
//    Arguements     : Input  : prevval (Previous value of the signal)
//                              currentval (Current value of the signal)
//                     Output : risingedge (TRUE when there is risingedge)
//                              fallingedge(TRUE when there is fallingedge)
//    Note           : this procedure will detect the edge on the input pin 
//                     convention   
//          0       --->   (x or z or 1)   : rising edge 
//                    
//    (x or z or 1) --->        0          : falling edge
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task edgedetector;

inout  prevval;
input  currentval;
output risingedge;
output fallingedge;

begin 
  if(currentval !== prevval)
  begin
    if (prevval === 1'b0 )
    begin
      risingedge     = 1;
      fallingedge    = 0;
    end   
    else if (prevval === 1'b1)
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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 3) Name           : addr_check
//    Purpose        : Procedure to check whether the address on the I/O line in
//                   : valid
//    Arguements     : Input  : Address input cycle
//                     Output : None
// If the address is found invalid this task will prompt an error & the simulation
// is stopped in case if 'X' or 'Z' is found
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task addr_check;
input [1:0]addr_cycle;  // 00 - Column Address 1,  01 - Column Address 2
                        // 10 - Sector Address 1,  11 - Sector Address 2
begin

   if(^io[7:0] === 1'bx || ^io[7:0] === 1'bz)
      display_error("Invalid Input 'X' or 'Z' on I/O lines during Address Input");

   case(addr_cycle)
      CA1 : begin end
      CA2 :
      begin
         if(DEV_X16 == 1'b1 && io[7:2] !== 6'b000000)
            $display("\nWarning : I/O lines 8 to 3 should have all be LOW at time : %0t ",$time);
         else if(DEV_X16 == 1'b0 && io[7:3] !== 5'b00000)
            $display("\nWarning : I/O lines 8 to 4 should have all be LOW at time : %0t ",$time);
      end
      SA1 : begin end
      SA2 :
      begin
         if(io[7:5] !== 3'b000)
            $display("\nWarning : I/O lines 8 to 6 should have all be LOW at time : %0t ",$time);
      end
   endcase
end
endtask   

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 4) Name           : to_finish_read
//    Purpose        : Procedure to complete the read operation
//    Arguements     : Input  : None
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task to_finish_read;
begin
   data_output_over  = 1'b0;
   data_buff        <= #Toh DONT_CARE;
   data_output      <= #Toh 1'b1;
   data_output      <= #(Toh + 1) 1'b0;
   read_end_t        = $time;

   if(re_n_risingedge == 1'b1)
      data_output_time  = Trhz;
   else if(ce_n_risingedge == 1'b1)
      data_output_time  = Tchz;

   data_buff        <= #data_output_time HIZ;
   data_output      <= #data_output_time 1'b1;
   data_output      <= #(data_output_time + 1) 1'b0;

end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 5) Name           : hash_memory_read
//    Purpose        : Procedure for hash memeory read operation
//    Arguements     : Input  : 1 => State information
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task hash_memory_read;
input state_info;   // 1 => st_data_read 0 => st_sector_read
integer Read_size;
begin
   if(state_info == 1'b1)
      Read_size  = PAGE_SIZE;
   else
      Read_size  = SECTOR_SIZE; 
      
   if (search_over == 1'b0) 
   begin : search_data_address
      for (i = 0; i <= `NUM_OF_SECTORS_HASH; i = i + 1)
      begin
        if ( i == `NUM_OF_SECTORS_HASH)
        begin
            search_success = 1'b0;
            search_over    = 1'b1;
            disable search_data_address; 
        end 
        else if (sector_address[i] === sector_addr)
        begin
          index_offset_hash  = i; 
          search_success     = 1'b1;
          search_over        = 1'b1;
          if(state_info == 1'b1)
             addr_index      = index_offset_hash * SECTOR_SIZE + 
                                  (page_addr * PAGE_SIZE + column_addr);
          else
             addr_index      = index_offset_hash * SECTOR_SIZE;
          disable search_data_address;
        end
      end // End of for loop
   end // End search_data_address1
      
   if (search_success == 1'b1)
   begin
      if((addr_index + 1) % Read_size == 0)
      begin
         data_buff     <= #data_output_time memory[addr_index];
         read_over      = 1'b1; 
         search_success = 1'b0;
      end
      else
      begin
         data_buff     <= #data_output_time memory[addr_index];
         addr_index     = addr_index + 1;
      end
      if(addr_index % PAGE_SIZE == 0)
         page_addr = page_addr + 1;
   end
   else 
   begin
      if((addr_index + 1) % Read_size == 0)
      begin
         data_buff     <= #data_output_time ERASE_DATA;
         read_over      = 1'b1;
      end
      else
      begin
         data_buff     <= #data_output_time ERASE_DATA;
         addr_index     = addr_index + 1;
      end
   end
   // -- call task to schedule data on the "io" bus
   schedule_data;
end
endtask 

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 6) Name           : hash_sector_search
//    Purpose        : Procedure used for searching the sector address array in 
//                     case of hash memeory for programming and rewrite operations
//    Arguements     : Input  : State
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task hash_sector_search;
input [4:0] state;
begin
   begin : search_sector_addr1
     for (i = 0; i <= `NUM_OF_SECTORS_HASH; i = i + 1)
     begin
       if ( i == `NUM_OF_SECTORS_HASH)
       begin
         case(state)
            st_program_start, st_rewrite_start :
            if(dse_n === 1'b0)
               display_error("DSE has gone low while Trying to Program more sectors than declared using \"`NUM_OF_SECTORS_HASH\" ");
            else
               display_error("Trying to Program more sectors than declared using \"`NUM_OF_SECTORS_HASH\" ");
            
            st_erase_start :
            if(dse_n === 1'b0)
               display_error("DSE has gone low while Trying to Erase more sectors than declared using \"`NUM_OF_SECTORS_HASH\" ");
            else
               display_error("Trying to Erase more sectors than declared using \"`NUM_OF_SECTORS_HASH\" ");
         endcase

         if (NON_STOP_SIM_EN == ENABLE) // when simulation is not stopped because of this flag.
           write_error = 1'b1;          // write_error is set to avoid programming 
       end 
       else if (sector_address[i] === sector_addr)
       begin
         index_offset_hash  = i;
         disable search_sector_addr1;
       end
       else if (sector_address[i] === ALL_X)
       begin
         index_offset_hash  = i;
         sector_address[i]  = sector_addr;
         disable search_sector_addr1;
       end
     end
   end
end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 7) Name           : hash_warning
//    Purpose        : Procedure to display warning in case of number of 
//                     sectors declared less than that used
//    Arguements     : Input  : None
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task hash_warning;
begin
   $display("##########################################################");
   $display("\n WARNING!!! : Please Change `NUM_OF_SECTORS_HASH"); 
   $display("##########################################################");
   display_error("Data not programmed as memory array declared is insufficient");
   write_error     = 1'b0;
end 
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 8) Name           : write_to_flash_dse_low
//    Purpose        : Procedure to write data into flash when dse is low
//    Arguements     : Input  : State
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task write_to_flash_dse_low;
input [4:0]state;
begin
   if(MEMORY_TYPE == FULL)
   begin
      addr_index  = sector_addr * SECTOR_SIZE;
      page_num    = sector_addr * NUM_OF_PAGES;

      for(i = 0; i < SECTOR_SIZE; i = i + 1)
         memory[addr_index + i] = DSE_WRITE_DATA;

      for(i = 0; i < NUM_OF_PAGES; i = i + 1)
         page_programmed[page_num + i] = 1'b1;
   end
   else // Hash Memory
   begin
      //--------------------------
      hash_sector_search (state);
      //--------------------------
      if(write_error == 1'b0)
      begin
         addr_index  = index_offset_hash * SECTOR_SIZE;
         page_num    = index_offset_hash * NUM_OF_PAGES;

         for(i = 0; i < SECTOR_SIZE; i = i + 1)
            memory[addr_index + i] = DSE_WRITE_DATA;

         for(i = 0; i < NUM_OF_PAGES; i = i + 1)
            page_programmed[page_num + i] = 1'b1;
      end
      else
      begin
         hash_warning;
      end
   end
end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 9)Name            : schedule_data
//    Purpose        : Procedure to schedule some flags in case of data reading
//    Arguements     : Input  : None
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task schedule_data;
begin

   data_output       <= #data_output_time 1'b1;
   data_output       <= #(data_output_time + 1) 1'b0;
   data_scheduled    <= 1'b1;
   read_start_t       = $time;
   data_output_over   = 1'b1;

end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 10)Name           : dse_low_read
//    Purpose        : Procedure to set flag to neglect data & schedule "io" in
//                     case "dse_n" becomes low while reading data or status or ID.
//    Arguements     : Input  : None
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task dse_low_read;
begin

   prev_flash_state = flash_state;
   flash_state      = st_deepstandby;
   internal_rb     <= 1'b1;
   internal_mres   <= 1'b1;

   if(data_scheduled == 1'b1)
   begin
      io_reg          <= #Toh DONT_CARE;
      if(data_output_over == 1'b1 && ($time - read_start_t) <= (data_output_time - Toh))
         neglect_data  = 1'b1;
      else if(data_output_over == 1'b0 && ($time - read_end_t) <= (data_output_time - Toh))
         neglect_data  = 1'b1;
   end
end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 11)Name           : pre_low_read
//    Purpose        : Procedure to set flag to neglect data & schedule "io" in
//                     case "pre_n" becomes low while reading data or status or ID.
//    Arguements     : Input  : None
//                     Output : None
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task pre_low_read;
begin

   if(data_scheduled == 1'b1 && re_n === 1'b0)
   begin
      if(data_output_over == 1'b1 && ($time - read_start_t) <= (data_output_time - Toh))
         neglect_data  = 1'b1;

      data_buff           <= #Toh NO_VALUE_DATA;
      data_output         <= #(Toh) 1'b1;
      data_output         <= #(Toh + 1) 1'b0;
      send_no_value_data   = 1'b1;
   end
end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//===================
//  INITIAL  BLOCK
//===================

initial
begin
   flash_state               = st_power_on_wait;
   prev_flash_state          = st_power_on_wait;
   
   prev_cle                  = 1'bx;
   cle_risingedge            = 1'b0;
   cle_fallingedge           = 1'b0;

   prev_ale                  = 1'bx;
   ale_risingedge            = 1'b0;
   ale_fallingedge           = 1'b0;

   prev_ce_n                 = 1'bx;
   ce_n_risingedge           = 1'b0;
   ce_n_fallingedge          = 1'b0;

   prev_re_n                 = 1'bx;
   re_n_risingedge           = 1'b0;
   re_n_fallingedge          = 1'b0;

   prev_we_n                 = 1'bx;
   we_n_risingedge           = 1'b0;
   we_n_fallingedge          = 1'b0;

   prev_wp_n                 = 1'bx;
   wp_n_risingedge           = 1'b0;
   wp_n_fallingedge          = 1'b0;

   prev_pre                  = 1'bx;
   pre_risingedge            = 1'b0;
   pre_fallingedge           = 1'b0;

   prev_dse_n                = 1'bx;
   dse_n_risingedge          = 1'b0;
   dse_n_fallingedge         = 1'b0;

   prev_dump                 = 1'bx;
   dump_risingedge           = 1'b0;
   dump_fallingedge          = 1'b0;

   prev_internal_rb          = 1'bx;
   internal_rb_risingedge    = 1'b0;
   internal_rb_fallingedge   = 1'b0;

   prev_program_start        = 1'bx;
   program_start_risingedge  = 1'b0;
   program_start_fallingedge = 1'b0;

   command_reg               = 8'hFF;
   prev_command_reg          = 8'hFF;
   io_reg                    = HIZ;
   data_buff                 = HIZ;
   flash_addr                = 23'h0;

   internal_mres             = 1'b1;
   rb_high                   = 1'b0;
   rb_high_ar                = 1'b0;
   rb_high_rd                = 1'b0;
   rb_low                    = 1'b0;
   rb_scheduled              = 1'b0;
   data_output               = 1'b0;
   data_scheduled           <= 1'b0;
   pre_came                  = 1'b0;
   pre_came_rd               = 1'b0;
   dse_came                  = 1'b0;
   dse_came_during_twb_taras = 1'b0;
   dse_came_ar               = 1'b0;
   dse_came_rd               = 1'b0;
   dse_n_risingedge_came     = 1'b0;
   valid_command             = 1'b0;
   valid_address             = 1'b0;
   valid_datain              = 1'b0;
   valid_read                = 1'b0;
   pwr_auto_r_flag          <= 1'b0;
   write_error               = 1'b0;
   page_programming_over     = 1'b0;
   read_over                 = 1'b0;
   search_over               = 1'b0;
   search_success            = 1'b0; 
   data_output_over          = 1'b0;
   from_deepstandby          = 1'b0;
   read_condition            = 1'b0;
   manufacturer_code_read    = 1'b0;
   make_mres_n_high         <= 1'b0;
   make_io_z                 = 1'b0;
   neglect_data              = 1'b0;
   page_checked              = 1'b0;
   wp_n_status               = 1'b1;
   tww_violation             = 1'b0;
   dev_not_wp                = 1'b1;
   send_no_value_data        = 1'b0;

   autoread_flag            <= 1'b0;
   autoread_flagx           <= 1'b0;
   seqread_trhws_err        <= 1'b0;
   seqread_trws_err         <= 1'b0;
   seqread_stop_cmd_flag    <= 1'b0;
   seq_last_read_flag       <= 1'b0;
   seq_last_col_flag        <= 1'b0;

   sector_addr               = 0;
   column_addr               = 0;
   page_addr                 = 0;
   page_num                  = 0;
   addr_index                = 0;
   buff_index                = 0;
   index_offset_hash         = 0;
   write_buff_count          = 0;
   dse_came_count            = 0;
   dse_came_ar_count         = 0;

   srd_io1_dse               = 1'b0;
   read_srd_err_flag         = 1'b0;
   rb_high_stp               = 1'b1;

// stamped time variables Initialization
   ce_n_fall_t               = -1 * Tcs;
   ce_n_rise_t               = -1 * Tch;
                             
   we_n_fall_t               = -1 * Twc;
   we_n_rise_t               = -1 * Twhc;
                             
   re_n_fall_t               = -1 * Trc;
   re_n_rise_t               = -1 * Treh;
                             
   pre_fall_t                = -1 * Tpre;
                             
   wp_n_fall_t               = -1 * Twps;
   wp_n_rise_t               = -1 * Twps;
                             
   cle_fall_t                = -1 * Tclh;
   cle_rise_t                = -1 * Tcls;
                             
   ale_fall_t                = -1 * Tar1;
   ale_rise_t                = -1 * Tals;
                             
   io_change_t               = -1 * Tds;
   output_highz_t            = -1 * Tdh;
                             
   rb_rise_t                 = -1 * Trr;
   data_output_time          = 0;
   busy_start_t              = -1 * Twb;
   dsby_ar_start_t           = -1 * Tdbsy;
   read_start_t              = -1 * Tcea;
   read_end_t                = -1 * Trhz;

//----------------- Write Buffer Initialization  ---------------
  for ( i = 0; i <= (SECTOR_SIZE - 1); i = i + 1)
     write_buff[i]    = ERASE_DATA;

//----------------- Memory initialization ----------------------
   for(i = 0; i < (NUM_OF_SECTORS * SECTOR_SIZE); i = i + 1)
      memory[i]       = ERASE_DATA;
    
//----------------- Page erase status initialization -----------
   for(i = 0; i < (NUM_OF_SECTORS * NUM_OF_PAGES); i = i + 1)
      page_programmed[i] = 1'b0;

//----------------- Sector address array Initialization --------
   for (i = 0; i < `NUM_OF_SECTORS_HASH; i = i + 1)  
      sector_address[i]    = ALL_X;

   
   //=========  Initialization of Full Memory with 'init.mem' file ================
   
   if ((INIT_MEM_EN == ENABLE) && (MEMORY_TYPE == FULL))
   begin
      case(FRESH_OR_USED_CHIP)
         ENABLE  : $readmemh("init.mem",memory);
         DISABLE : $readmemh("dump.mem",memory);
      endcase
      
      for(i = 0; i < NUM_OF_SECTORS * NUM_OF_PAGES; i = i + 1)
      begin
         j             = i * PAGE_SIZE;
         page_checked  = 1'b0;
         while(page_checked == 1'b0)
         begin

            if(memory[j] !== ERASE_DATA)
            begin
               page_programmed[page_num] = 1'b1;
               page_checked              = 1'b1;
            end
            
            j = j + 1;
            if(j % PAGE_SIZE == 1'b0)
               page_checked    = 1'b1;
         end
         page_num    = page_num + 1;
      end
      page_num    = 0;
   end

   for (i = 0; i < NUM_OF_SECTORS; i = i + 1)
      sector_state[i] = 1'b0;

end // End of initial block

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     ALWAYS BLOCK USED FOR DISPLAYING THE CURRENT FLASH STATE
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
always @(flash_state)
begin
   case(flash_state)
      st_power_on_off      : flash_state_string = "power on off";
      st_deepstandby       : flash_state_string = "Deep standby";
      st_cmnd_deepstandby  : flash_state_string = "Command Deep standby";
      st_standby           : flash_state_string = "Standby";
      st_autoread          : flash_state_string = "Auto Read";
      st_setup             : flash_state_string = "Setup";
      st_column_addr       : flash_state_string = "Column Address";
      st_sector_addr       : flash_state_string = "Sector Address";
      st_program_datain    : flash_state_string = "Program Datain";
      st_idread_addr       : flash_state_string = "IDRead Address";
      st_program_start     : flash_state_string = "Program Start";
      st_rewrite_start     : flash_state_string = "Rewrite Start";
      st_erase_start       : flash_state_string = "Erase Start";
      st_data_read         : flash_state_string = "Data Read";
      st_sector_read       : flash_state_string = "Sector Read";
      st_srd_setup         : flash_state_string = "Status Read";
      st_seq_read_busy     : flash_state_string = "Sequential Read Busy";
      default              : flash_state_string = "Default";
   endcase
end 

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     ALWAYS BLOCK USED FOR MAIN FLASH FUNCTIONALITY
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//----------------------state transaction starts from here -----------
always@(io or cle or ale or ce_n or re_n or we_n or wp_n or pre
        or dse_n or dump or internal_rb or program_start)

begin

   //============ FINDING THE TRANSITONS (RisingEdge or FallingEdge ============
   edgedetector(prev_cle,    cle,    cle_risingedge,     cle_fallingedge);
   edgedetector(prev_ale,    ale,    ale_risingedge,     ale_fallingedge);
   edgedetector(prev_ce_n,   ce_n,   ce_n_risingedge,    ce_n_fallingedge);
   edgedetector(prev_re_n,   re_n,   re_n_risingedge,    re_n_fallingedge);
   edgedetector(prev_we_n,   we_n,   we_n_risingedge,    we_n_fallingedge);
   edgedetector(prev_wp_n,   wp_n,   wp_n_risingedge,    wp_n_fallingedge);
   edgedetector(prev_pre,    pre,    pre_risingedge,     pre_fallingedge);
   edgedetector(prev_dse_n,  dse_n,  dse_n_risingedge,   dse_n_fallingedge);
   edgedetector(prev_dump,   dump,   dump_risingedge,    dump_fallingedge);
   edgedetector(prev_internal_rb,    internal_rb,
                internal_rb_risingedge, internal_rb_fallingedge);
   edgedetector(prev_program_start,  program_start,
                program_start_risingedge, program_start_fallingedge);

//==============================================================================
//                    FLASH TIMING CHECK STARTS HERE
//==============================================================================

   if(TIME_CHECK_EN == ENABLE)
   begin
      if(we_n_fallingedge == 1'b1)
      begin
        if($time - we_n_fall_t < Twc)
           display_error(" Write cycle time (tWC) violation");
        if(ce_n == 1'b0)
        begin
             we_n_fall_t      = $time;
        end
        if($time - we_n_rise_t < Twh)
           display_error(" WE high hold time (tWH) violation");
        if(ce_n === 1'b0)
        begin
           if($time - wp_n_fall_t < Twps || $time - wp_n_rise_t < Twps)
              display_error(" WP set up time (tWPS) violation");
           if($time - re_n_rise_t < Trhw && (prev_flash_state !== st_power_on_wait 
           || prev_flash_state !== st_power_on_off ))
              display_error(" RE high to WE low time (tRHW) violation");
           if(ce_n == 1'b0 && $time - re_n_rise_t < Trhws && command_reg == SEQ_READ
           && flash_state == st_data_read && prev_flash_state == st_seq_read_busy)
              seqread_trhws_err <= 1'b1;
           if($time - rb_rise_t < Trws && ((command_reg == SEQ_READ && flash_state == st_data_read)
           || (prev_command_reg == SEQ_READ && flash_state == st_stop_cmd)) && ce_n == 1'b0
           && (seq_last_col_flag == 1'b1 || seq_last_read_flag == 1'b1))
              seqread_trws_err  <= 1'b1;
        end
        if($time - ce_n_rise_t < Tchws)
           display_error(" CE high to WE low setup time (tCHWS) violation");
      end

      else if(we_n_risingedge == 1'b1 && ce_n === 1'b0)
      begin
        we_n_rise_t      = $time;
        if($time - io_change_t < Tds)
           display_error(" Data setup time (tDS) violation");
        if($time - we_n_fall_t < Twp)
           display_error(" Write pulse width (tWP) violation");
      end

      else if(we_n_risingedge == 1'b1 && ce_n === 1'b1 )
      begin
        ce_h_we_n_rise_t      = $time;
      end

      if(ce_n_fallingedge == 1'b1 && ce_n === 1'b0)
      begin
        ce_n_fall_t      = $time;
        if($time - we_n_rise_t < Twhc)
           display_error(" WE high to CE low time (tWHC) violation");
        if($time - ce_n_rise_t < Tceh)
           display_error("CE high hold time (tCEH) violation");
        if($time - ce_h_we_n_rise_t < Twhch)
           display_error("CE high WE low hold time (tWHCH) violation");
        if($time - ce_h_re_n_rise_t < Trhch)
           display_error("CE high RE low hold time (tRHCH) violation");
        if($time - ce_n_rise_t < Tcehs && flash_state == st_seq_read_stop)
           display_error("CE high hold time in Sequential read cycle (tCEHS) violation");
        if(ce_n_fall_t - we_n_fall_t > 0 &&  we_n == 1'b0)
           display_error(" CE setup time (tCS) violation");
      end

      else if(ce_n_risingedge == 1'b1)
      begin
        ce_n_rise_t      = $time;
        if($time - we_n_rise_t < Tch)
           display_error(" CE hold time (tCH) violation");
        if(we_n == 1'b0)
           display_error(" CE should not be changed in WE pulse width");
      end

      if(cle_fallingedge == 1'b1 && ce_n === 1'b0)
      begin
        cle_fall_t       = $time;
        if($time - we_n_rise_t < Tclh)
           display_error(" CLE hold time (tCLH) violation");
        if(we_n == 1'b0 && ce_n == 1'b0)
           display_error(" CLE setup time or hold time violation");
      end

      else if(cle_risingedge == 1'b1)
      begin
         cle_rise_t       = $time;
         if($time - we_n_rise_t < Tclh)
            display_error(" CLE hold time (tCLH) violation");
         if(we_n_fall_t !== cle_rise_t && we_n == 1'b0 && ce_n == 1'b0)
            display_error(" CLE setup time or hold time violation");
      end

      if(ale_fallingedge == 1'b1 && ce_n === 1'b0)
      begin
        ale_fall_t       = $time;
        if($time - we_n_rise_t < Talh)
          display_error(" ALE hold time (tALH) violation");
        if(we_n == 1'b0 && ce_n == 1'b0)
          display_error(" ALE setup time or hold time violation");
      end

      else if(ale_risingedge == 1'b1)
      begin 
        ale_rise_t       = $time;
        if($time - we_n_rise_t < Talh)
           display_error(" ALE hold time (tALH) violation");
        if(we_n_fall_t !== ale_rise_t && we_n == 1'b0 && ce_n == 1'b0)
           display_error(" ALE setup time or hold time violation");
      end

      if(re_n_fallingedge == 1'b1 && ce_n === 1'b0)
      begin
        if($time - re_n_fall_t < Trc)
           display_error(" Read cycle time (tRC) violation");
        re_n_fall_t      = $time;
        if($time - re_n_rise_t < Treh)
           display_error(" RE high hold time (tREH) violation");
        if($time - ce_n_fall_t < Tcr && flash_state == st_idread_addr)
           display_error(" CE low to RE low time (ID Read) (tCR) violation");
        if($time - ale_fall_t < Tar1 && flash_state == st_idread_addr)
           display_error(" ALE low to RE low time (ID Read) (tAR1) violation");
        if($time - ale_fall_t < Tar2 && flash_state == st_data_read)
           display_error(" ALE low to RE low time (Read cycle) (tAR2) violation");
        if($time - rb_rise_t < Trr && command_reg !== STATUSREAD)
           display_error(" Ready to RE fall time (tRR) violation");
        if($time - we_n_rise_t < Twhr)
           display_error(" WE high to RE low time (tWHR) violation");
      end

      if(re_n_fallingedge == 1'b1 && ce_n == 1'b1) 
      begin
        if($time - ce_n_rise_t < Tchrs)
           display_error(" CE high to RE low setup time (tCHRS) violation");
      end

      else if(re_n_risingedge == 1'b1 && ce_n === 1'b0)
      begin
        re_n_rise_t      = $time;
        if($time - re_n_fall_t < Trp)
           display_error(" Read pulse time (tRP) violation");
      end

      else if(re_n_risingedge == 1'b1 && ce_n === 1'b1)
      begin
        ce_h_re_n_rise_t      = $time;
      end

      else if(wp_n_risingedge == 1'b1 && flash_state != st_power_on_off )
      begin
        if($time - we_n_rise_t < Twph && flash_state != st_power_on_wait)
           display_error(" WP hold time (tWPH) violation");
      end

      if(dse_n_risingedge == 1'b1)
      begin
        dse_n_rise_t      = $time;
      end

      if(pre_risingedge == 1'b1)
      begin
        if($time - pre_fall_t < Tpre)
           display_error(" PRE pulse width (tPRE) violation");
        if(flash_state == st_power_on_off && $time - dse_n_rise_t > Tpd)
           display_error(" DSE high to PRE high delay (tPD) violation");
      end
      else if(pre_fallingedge == 1'b1)
        pre_fall_t       = $time;

      if((DEV_X16 == 1'b1 && io !== prev_io) || (DEV_X16 == 1'b0 && io[7:0] !== prev_io[7:0]))
      begin
         
         io_change_t     = $time;
         if((DEV_X16 == 1'b1 && io === 16'hzzzz) || (DEV_X16 == 1'b0 && io[7:0] === 8'hzz))
            output_highz_t  = $time;
         if(ce_n === 1'b0)
         begin 
            if($time - we_n_rise_t < Tdh)
               display_error(" Data hold time (tDH) violation");
         end
      end

      if(internal_rb_fallingedge == 1'b1)
         rb_fall_t       = $time;

   end // End of if(TIME_CHECK_EN == ENABLE)

//======================== END OF TIMING CHECKS ================================

   if(internal_rb_risingedge == 1'b1)
   begin
      rb_rise_t    = $time;
      if(seq_last_read_flag == 1'b1)
         seq_last_read_flag  <= #(Trws) 1'b0;
   end

   if(wp_n_fallingedge == 1'b1)
      wp_n_fall_t  = $time;
   else if(wp_n_risingedge == 1'b1)
      wp_n_rise_t  = $time;

   if(we_n_fallingedge == 1'b1)
   begin
      if(($time - wp_n_fall_t) < Twps || ($time - wp_n_rise_t) < Twps)
      begin
         tww_violation   = 1'b1;
         wp_n_status     = !wp_n;
      end
      else
         tww_violation   = 1'b0;
   end

   // This check is done so that user may not change ce_n/cle/ale when we is low.
   if(we_n === 1'b0 && re_n === 1'b0 && ce_n === 1'b0)
         display_error( "Both WE and RE cannot become low at same time");

   if(re_n_fallingedge == 1'b1)
   begin
      if(internal_mres === 1'b0 && command_reg !== STATUSREAD && ce_n === 1'b0)
      begin
         $write("\nWarning : RE transition is illegal when /MRES is low ");
         $display("at time : %0t ",$time);
      end

      case(flash_state)
         st_srd_setup, st_program_start, st_rewrite_start, 
         st_erase_start, st_autoread :
            data_output_time   = (($time - ce_n_fall_t) >= (Tcsto - Trsto)) ? Trsto : (Tcsto - ($time - ce_n_fall_t));
         default :      
            data_output_time   = (($time - ce_n_fall_t) >= (Tcea - Trea)) ? Trea : (Tcea - ($time - ce_n_fall_t)); 
      endcase

   end

   if(dse_n_fallingedge == 1'b1)
   begin
      if($time - busy_start_t < Twb && flash_state != st_seq_read_busy) 
         dse_came_during_twb_taras    = 1'b1;
   end

   if(cle === 1'b1 && ale === 1'b1 && ce_n === 1'b0)
      display_error("Both ALE and CLE cannot be made high at same time");

   if((wp_n_fallingedge == 1'b1 || wp_n_risingedge == 1'b1) && 
      (command_reg === AUTOERASE || command_reg === DATAINPUT))
   begin
      $write("\nWarning : WP should not be changed in between operation. ");
      $display("Transition Ignored at time : %0t ",$time);
   end

   //--------------------------------------------------------------------------
   if(pre === 1'bx) begin
      $write  ("\nERROR : pre = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(wp_n === 1'bx) begin
      $write  ("\nERROR : wp_n = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(dse_n === 1'bx) begin
      $write  ("\nERROR : dse_n = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(ce_n === 1'bx) begin
      $write  ("\nERROR : ce_n = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(re_n === 1'bx) begin
      $write  ("\nERROR : re_n = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(we_n === 1'bx) begin
      $write  ("\nERROR : we_n = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(cle === 1'bx) begin
      $write  ("\nERROR : cle = X input");
      $display("%s %0t ","  at time",$time);
   end
   if(ale === 1'bx) begin                 
      $write  ("\nERROR : ale = X input");
      $display("%s %0t ","  at time",$time);
   end

   //===========================================================================

   valid_command = we_n_risingedge  && !ce_n &&  cle  && !ale && re_n;
   valid_address = we_n_risingedge  && !ce_n && !cle  &&  ale && re_n;
   valid_datain  = we_n_risingedge  && !ce_n && !cle  && !ale && re_n;
   valid_read    = re_n_fallingedge && !ce_n && !cle  && !ale && we_n 
                                    && (internal_mres || command_reg === STATUSREAD);

   //--------------------- valid address check ---------------------------------
   if (valid_address === 1'b1)
   begin
      case(flash_state)
         st_setup, st_sector_addr, st_column_addr : begin end
         default :  
         begin
            $write  ("\nWarning : Illegal Address input in ");
            $display("%0s %s %0t ", flash_state_string, "state at time" ,$time);
         end
      endcase
   end

   //---------------------- valid data input check -----------------------------
   if (valid_datain === 1'b1)
   begin
      case(flash_state)
         st_sector_addr, st_program_datain : begin end
         default :  
         begin
            $write  ("\nWarning : Illegal Data input in "); 
            $display("%0s %s %0t ", flash_state_string, "state at time" ,$time);
         end
      endcase
   end

   //---------------------------- valid command  check -------------------------  
   if (valid_command === 1'b1)
   begin
      if(internal_mres == 1'b0 && io[7:0] !== STATUSREAD)
         display_error("Command input is illegal when /MRES is low");

      case(flash_state)
         st_deepstandby, st_setup, st_column_addr,
         st_idread_addr :
         begin
            $write  ("\nWarning : Illegal Command input in "); 
            $display("%0s %s %0t ", flash_state_string, "state at time" ,$time);
         end
         default : begin end 
      endcase
   end 

//==============================================================================
//                   superAND STATE MACHINE STARTS HERE
//==============================================================================
                                                                                    
   case(flash_state) 
                     
   //~~~~~~~~~~~~~~~~~~~~~~~
   //  POWER ON WAIT STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_power_on_wait    :
      begin
         program_start       <= 1'b0;
         if(dse_n_risingedge == 1'b1 && PWRUP_EN == ENABLE)
         begin
            if (pre == 1 || pre_risingedge == 1'b1)
            begin
              prev_flash_state = flash_state;
              flash_state      = st_autoread;
              rb_high_ar      <= #(Tdb + Tbsy) 1'b1;
              rb_high_ar      <= #(Tdb + Tbsy + 1) 1'b0;
              rb_scheduled    <= #(Tdb + Tbsy) 1'b0;
              pwr_auto_r_flag <= 1'b1;
              autoread_flag   <= 1'b1;
            end
            else
            begin
              prev_flash_state = flash_state;
              flash_state      = st_power_on_off;
              internal_rb     <= #(Tdb + Tbsy) 1'b1;
              rb_scheduled    <= #(Tdb + Tbsy) 1'b0;
              internal_mres   <= #(Tdb + Tbsy + Trmres) 1'b1;
            end
         end 

         else if(PWRUP_EN == DISABLE && (pre == 1'b1 || pre == 1'b0))
         begin
            prev_flash_state= flash_state;
            flash_state     = st_standby;
            internal_rb    <= 1'b1;
            internal_mres  <= 1'b1;
            rb_scheduled   <= 1'b0;
            program_start  <= 1'b0;
            if(pre_risingedge == 1'b1 || pre == 1'b1)    autoread_flag  <= 1'b1;
            else if(pre === 1'bx)                        autoread_flagx <= 1'b1;
            else                                         autoread_flag  <= 1'b0;
         end

         else
         begin
            internal_mres           <= 1'b0;
            internal_rb             <= 1'b0;
            internal_rb_fallingedge  = 1'b0;
            rb_scheduled             = 1'b1;
            flash_state              = st_power_on_wait;
         end

         if($time <= 0 && dse_n !== 1'b0)
            $display("\nWarning : DSE should be LOW in power on setup at time %0t ",$time);
      end  // End of st_power_on_wait

   //~~~~~~~~~~~~~~~~~~~~~~~
   //  POWER ON OFF STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_power_on_off    :
      begin
         //--pre checking during power on time
         if (pre_risingedge == 1'b1)
         begin
            if($time - dse_n_rise_t <= Tpd)
            begin
               prev_flash_state = flash_state;
               flash_state      = st_autoread;
               pwr_auto_r_flag <= 1'b1;
               autoread_flag   <= 1'b1;
            end
         end

         //-- Device ready during power on time
         program_start     <= 1'b0;

         if(internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_standby;
            rb_scheduled    <= 1'b0;
         end

         if(dse_n_risingedge == 1'b1 || dse_n_fallingedge == 1'b1)
            display_error(" DSE should not be changed during power on ");
      end // End of st_power_on_off

   //~~~~~~~~~~~~~~~~~~~~~~~
   //    STANDBY STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_standby         :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if((pre == 1'b1 || pre_risingedge === 1'b1) && autoread_flagx == 1'b1)
         begin
            autoread_flag  <= 1'b1;
            autoread_flagx <= 1'b0;
         end
         else if(pre == 1'b0 && autoread_flagx == 1'b1)
         begin
            autoread_flagx <= 1'b0;
         end
         if(dse_n_fallingedge == 1'b1)
         begin
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state       
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin
            prev_flash_state= flash_state;
            flash_state     = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low         <= #Twb 1'b1;
            rb_low         <= #(Twb + 1) 1'b0;
            internal_mres  <= 1'b0;
            rb_high_ar     <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar     <= #(Twb + Tarbsy + 1) 1'b0;
            busy_start_t    = $time;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_command === 1'b1)
         begin     
            prev_command_reg = command_reg;
            case(io[7:0])
               DSBYSETUP  : 
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_cmnd_deepstandby;
               end
               READMODE, SEQ_READ, IDREAD  :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_setup;
               end
               DATAINPUT, AUTOERASE :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_setup;

                  if(tww_violation == 1'b1)   dev_not_wp  = wp_n_status;
                  else if(wp_n === 1'b1)      dev_not_wp  = 1'b1; 
                  else                        dev_not_wp  = 1'b0;
               end
               STATUSREAD :       
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_srd_setup; 
               end                                            
               default    : 
                  $display("\nWarning : Illegal Command input in Standby state at time : %0t ",$time);
            endcase
         end
         else if(valid_read === 1'b1)
         begin
            if(ce_n == 1'b0)
            begin
               if (prev_flash_state == st_read_stop && command_reg == STATUSREAD)
               begin
                  data_buff   <= #data_output_time {8'h00, dev_not_wp, internal_rb, 5'b00000, SRD_IO1_FAIL};
                  schedule_data;
               end
               else begin
                  $display("\nWarning : Illegal Read condition in Standby state at time : %0t ",$time);
                  data_buff   <= #data_output_time ANY_DATA;
                  schedule_data;
               end
            end
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(make_io_z == 1'b1)
            begin
               make_io_z     = 1'b0;
               if(re_n_risingedge == 1'b1)
                  io_reg    <= #Trhz HIZ;
               else
                  io_reg    <= #Tchz HIZ;
            end
            else if (data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
         from_deepstandby   = 1'b0;
      end // End of st_standby

   //~~~~~~~~~~~~~~~~~~~~~~~
   //    AUTO READ STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_autoread        :
      begin
         command_reg = 8'hFF;
         dev_not_wp  = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)   
         begin
            if(prev_flash_state == st_power_on_off || prev_flash_state == st_power_on_wait)
            begin
              display_error(" DSE should not be changed during power on ");
            end
            else
            begin
               $display("\nWarning : DSE should not be changed during AutoRead state at time : %0t ",$time);
               dse_came_ar      = 1'b1;
               dse_came_ar_count= dse_came_ar_count + 1;

               // call task to find the whether data is to be neglected & schedule DSE Data
               dse_low_read;
            end
         end
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_command === 1'b1)
         begin
            case(io[7:0])
               STATUSREAD :
               begin
                  command_reg        = io[7:0];
                  prev_flash_state   = flash_state;
                  flash_state        = st_srd_setup;
               end
               default    :
                  $display("\nWarning : Illegal Command input in auto read state at time : %0t ",$time);
            endcase
         end
         else if(internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state   = flash_state;
            flash_state        = st_sector_read;
            search_over        = 1'b0;
            search_success     = 1'b0;
            addr_index         = 0;
            sector_addr        = 0;
            pre_came_rd        = 1'b0;
            rb_scheduled       = 1'b0;
         end
         else if(re_n_fallingedge && !ce_n && !cle  && !ale && we_n)
         begin
            $write("\nWarning : Illegal Read condition in AutoRead ");
            $display("state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end // End of st_autoread state

   //~~~~~~~~~~~~~~~~~~~~~~~
   //  DEEP STANDBY STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_deepstandby     :
      begin
         if((pre == 1'b1 || pre_risingedge === 1'b1) && autoread_flagx == 1'b1)
         begin
            autoread_flag  <= 1'b1;
            autoread_flagx <= 1'b0;
         end
         else if(pre == 1'b0 && autoread_flagx == 1'b1)
         begin
            autoread_flagx <= 1'b0;
         end
         if(dse_n_risingedge == 1'b1) 
         begin
            internal_rb              <= #Twb 1'b0;
            internal_rb              <= #(Twb + Tdbsy) 1'b1;
            dse_n_risingedge_came     = 1'b1;
         end              
         else if(dse_n_risingedge_came == 1'b1 && internal_rb_risingedge == 1'b1)
         begin
            dse_n_risingedge_came     = 1'b0;
            prev_flash_state          = flash_state;
            flash_state               = st_standby;
            data_scheduled           <= 1'b0;
            pre_came                  = 1'b0;
            pre_came_rd               = 1'b0;
            dse_came_rd               = 1'b0;
            neglect_data              = 1'b0;
            dse_came_during_twb_taras = 1'b0;

            if(ce_n === 1'b1 || re_n === 1'b1)
               io_reg    = HIZ;
            else
               make_io_z = 1'b1;
         end
         else if(dse_n_fallingedge == 1'b1)
            display_error("DSE should not be changed when Device is recovering from DEEP STANDBY state");
         else if(valid_read === 1'b1) 
         begin
            if(ce_n == 1'b0)
            begin
               $display("\nWarning : Illegal Read condition in Deep standby state at time : %0t",$time);
               data_buff   <= #data_output_time DSE_READ_DATA;
               schedule_data;
            end
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1) 
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end // End of else if(data_output_over....
         end
         rb_scheduled    = 1'b0;
      end // End of state st_deepstandby

   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // COMMAND DEEP STANDBY STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_cmnd_deepstandby     :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE pin became valid during Command Deep standby state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------

            if($time - dsby_ar_start_t < Tdbsy)
               dse_came_during_twb_taras = 1'b1;
            if(rb_scheduled == 1'b1)
               dse_came    = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin   
            from_deepstandby   = 1'b1;
            if(rb_scheduled == 1'b0)
            begin
               prev_flash_state= flash_state;
               flash_state     = st_autoread;
               rb_low         <= #Tdbsy 1'b1;
               rb_low         <= #(Tdbsy + 1) 1'b0;
               dsby_ar_start_t = $time;
               rb_high_ar     <= #(Tdbsy + Tarbsy) 1'b1;
               rb_high_ar     <= #(Tdbsy + Tarbsy + 1) 1'b0;
            end
            else
               pre_came        = 1'b1;

            internal_mres  <= 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_command === 1'b1)
         begin 
            prev_command_reg = command_reg;
            if(io[7:0] === DSBYRELEASE)
            begin
               command_reg   = io[7:0];
               rb_low       <= #Twb 1'b1;
               rb_low       <= #(Twb + 1) 1'b0;
               busy_start_t  = $time;
               rb_high      <= #(Twb + Tdbsy) 1'b1;
               rb_high      <= #(Twb + Tdbsy + 1) 1'b0;
               rb_scheduled  = 1'b1;
            end
            else      
            begin
               $write("\nWarning : Illegal command input in ");
               $display("Command Deep standby state at time : %0t ",$time);
            end
         end
         else if(valid_read === 1'b1)
         begin
            if(ce_n == 1'b0)
            begin
               $display("\nWarning : Illegal Read condition in Command Deep standby state at time : %0t",$time);
               data_buff   <= #data_output_time DSE_READ_DATA;
               schedule_data;
            end
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end

         if(internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_standby;
            rb_scheduled     = 1'b0;
         end
      end // End of state st_cmnd_deepstandby

   //~~~~~~~~~~~~~~~~~~~~~~~
   //    SETUP STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_setup    :               
      begin
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during Address setup state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low          <= #Twb 1'b1;
            rb_low          <= #(Twb + 1) 1'b0;
            busy_start_t     = $time;
            internal_mres   <= 1'b0;
            rb_high_ar      <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar      <= #(Twb + Tarbsy + 1) 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_address === 1'b1)
         begin
         //-- Checking the validity of address depending on the previous command
            case(command_reg)
               AUTOERASE  :
               begin
                  prev_flash_state = flash_state;
                  flash_state      = st_sector_addr; 
                  //-- First sector address cycle
                  first_sa         = 1'b1;
                  addr_check(SA1);
                  if(DEV_X16 == 1'b1)
                     flash_addr[17:10]    = io[7:0];
                  else
                     flash_addr[18:11]    = io[7:0];
               end
               READMODE, SEQ_READ, DATAINPUT  :
               begin
                  prev_flash_state  = flash_state;
                  flash_state       = st_column_addr;
                  //-- First column address cycle
                  first_ca          = 1'b1;
                  addr_check(CA1);
                  flash_addr[7:0]   = io[7:0];
               end
               IDREAD     :
               begin               
                  //-- ID read address cycle
                  if(io[7:0] === 8'h00)
                  begin
                     prev_flash_state       = flash_state;
                     flash_state            = st_idread_addr;
                     manufacturer_code_read = 1'b0;
                     data_output_over       = 1'b0;
                  end
                  else
                     $display("\nWarning : Address input for ID Read should be 00H at time : %0t ",$time);
               end
               default    :  begin   end
            endcase
         end
         else if(valid_read === 1'b1)
         begin
            $write("\nWarning : Illegal Read condition in Setup ");
            $display("state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end // End of st_setup

   //~~~~~~~~~~~~~~~~~~~~~~~
   //  COLUMN ADDRESS STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_column_addr :         
      begin
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during Column Address state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low          <= #Twb 1'b1;
            rb_low          <= #(Twb + 1) 1'b0;
            busy_start_t     = $time;
            internal_mres   <= 1'b0;
            rb_high_ar      <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar      <= #(Twb + Tarbsy + 1) 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_address === 1'b1)
         begin
            //--- Waiting for the second column address cycle.
            if(first_ca == 1'b1)
            begin    
               first_ca    = 1'b0;
               addr_check(CA2);
               if(DEV_X16 == 1'b1)
                  flash_addr[9:8] = io[1:0];
               else
                  flash_addr[10:8] = io[2:0];
               
               //---- storing the total column & page address ------
               column_addr  = flash_addr[COLUMN_START : COLUMN_END];
               page_addr    = flash_addr[PAGE_START : PAGE_END];
            end
            else //-- First sector address cycle
            begin
               first_sa    = 1'b1;
               addr_check(SA1);
               if(DEV_X16 == 1'b1)
                  flash_addr[17:10]    = io[7:0];
               else
                  flash_addr[18:11]    = io[7:0];
               
               prev_flash_state = flash_state;
               flash_state      = st_sector_addr;
            end
         end
         else if(valid_read === 1'b1)
         begin
            $write("\nWarning : Illegal Read condition in Column ");
            $display("Address state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end // End of st_column_addr

   //~~~~~~~~~~~~~~~~~~~~~~~
   //  SECTOR ADDRESS STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_sector_addr :
      begin
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during Sector Address state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
            if(rb_scheduled == 1'b1)
               dse_came_rd   = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)  
         begin
            if(rb_scheduled == 1'b1)
            begin
               if($time - busy_start_t < Twb)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else
               begin
                  rb_high_ar   <= #Tarbsy 1'b1;
                  rb_high_ar   <= #(Tarbsy + 1) 1'b0;
               end
               pre_came_rd      = 1'b1;
            end
            else
            begin
               // To take care of a condition when dse_n goes low during Twb
               rb_low          <= #Twb 1'b1;
               rb_low          <= #(Twb + 1) 1'b0;
               busy_start_t     = $time;
               rb_high_ar      <= #(Twb + Tarbsy) 1'b1;
               rb_high_ar      <= #(Twb + Tarbsy + 1) 1'b0;
            end

            prev_flash_state    = flash_state;
            flash_state         = st_autoread;
            internal_mres      <= 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_address === 1'b1)
         begin
            //---Second sector address cycle.
            if(first_sa == 1'b1)
            begin    
               first_sa    = 1'b0;
               addr_check(SA2);
               if(DEV_X16 == 1'b1)
                  flash_addr[22:18] = io[4:0];
               else
                  flash_addr[23:19] = io[4:0];
               
               //------ storing the total sector address ---------
               sector_addr = flash_addr[SECTOR_START : SECTOR_END];

               //---Model is in busy state after receiving the 
               //---sector address for read operation
               if(command_reg === READMODE)
               begin
                  // To take care of a condition when dse_n goes low during Twb
                  rb_low          <= #Twb 1'b1;
                  rb_low          <= #(Twb + 1) 1'b0;
                  srd_io1_dse     <= #Twb 1'b0;
                  busy_start_t     = $time;
                  rb_high_rd      <= #(Twb + Tr) 1'b1;
                  rb_high_rd      <= #(Twb + Tr + 1) 1'b0;
                  rb_scheduled     = 1'b1;
                  addr_index       = (sector_addr * SECTOR_SIZE) + 
                                     (page_addr * PAGE_SIZE) + column_addr; 
                  search_success   = 1'b0;
                  search_over      = 1'b0;
                  read_over        = 1'b0;
               end
               // Sequential Read.
               else if(command_reg === SEQ_READ)
               begin
                  // To take care of a condition when dse_n goes low during Twb
                  rb_low          <= #Twb 1'b1;
                  rb_low          <= #(Twb + 1) 1'b0;
                  busy_start_t     = $time;
                  rb_high_rd      <= #(Twb + Tr) 1'b1;
                  rb_high_rd      <= #(Twb + Tr + 1) 1'b0;
                  rb_scheduled     = 1'b1;
                  addr_index       = (sector_addr * SECTOR_SIZE) + 
                                     (page_addr * PAGE_SIZE) + column_addr; 
                  search_success   = 1'b0;
                  search_over      = 1'b0;
                  read_over        = 1'b0;
                  prev_flash_state = flash_state;
                  flash_state      = st_seq_read_busy;
               end
            end
            else
            begin
               $write("\nWarning : Illegal Address input cycle in ");
               $display("Sector address state at time : %0t ",$time);
            end
         end
         //-- After the read busy time "Tr" model enters into the Data read state 
         else if(internal_rb_risingedge == 1'b1 && command_reg === READMODE)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_data_read;
            rb_scheduled     = 1'b0;
            if(sector_state[sector_addr] == 1'b1)
               srd_io1_dse = 1'b1;
            else
               srd_io1_dse = 1'b0;
         end
         else if(valid_command === 1'b1)
         begin
            prev_command_reg = command_reg;
            if(first_sa == 1'b0)
            begin
               //-- Based on the previous command checking the validity of 
               //-- ERASECONFIRM and STATUSREAD commands. 
               case(command_reg)
                  AUTOERASE : 
                  begin
                     if(io[7:0] === ERASECONFIRM)
                     begin
                        command_reg      = io[7:0];
                        if(dev_not_wp == 1'b0)
                        begin
                           $write("\nWarning : Memory is write protected, ");
                           $display("Sector not erased at time : %0t ",$time);
                           prev_flash_state     = flash_state;
                           flash_state          = st_standby;
                        end
                        else
                        begin
                           prev_flash_state     = flash_state;
                           flash_state          = st_erase_start;
                           // To take care of a condition when dse_n goes low during Twb
                           rb_low              <= #Twb 1'b1;
                           rb_low              <= #(Twb + 1) 1'b0;
                           busy_start_t         = $time;
                           rb_high             <= #(Twb + Ters) 1'b1;
                           rb_high             <= #(Twb + Ters + 1) 1'b0; 
                           program_start       <= #(Twb + Ters - 1) 1'b1;
                           program_start       <= #(Twb + Ters) 1'b0;
                           rb_scheduled         = 1'b1;
                        end
                     end
                     else     
                     begin
                        $write("\nWarning : Illegal command is input while waiting for ERASE");
                        $display(" CONFIRM command in Sector Address state at time : %0t ",$time);
                     end
                  end

                  READMODE  :
                  begin
                     if(io[7:0] === STATUSREAD) 
                     begin
                        if(sector_state[sector_addr] == 1'b1)
                           read_srd_err_flag = 1'b1;
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        flash_state      = st_srd_setup;
                     end
                     else
                     begin
                        $write("\nWarning : Command other than status read is ");
                        $display("illegal in data read busy time : %0t ",$time);
                     end
                  end

                  //--- Program or Rewrite confirmation commands without 
                  //--- inputting the program data
                  DATAINPUT :
                  begin
                     if(io[7:0] === AUTOREWRITE || io[7:0] === AUTOPROGRAM)
                     begin
                        $write("\nWarning : Confirm Command is given while ");
                        $display("waiting for data at time : %0t ",$time);
                     end
                     else
                     begin
                        $write("\nWarning : Illegal Command input in ");
                        $display("Sector Address State at time : %0t ",$time);
                     end
                  end

                  default :
                  begin
                     $write("\nWarning : Illegal Command input in ");
                     $display("Sector Address State at time : %0t ",$time);
                  end
               endcase
            end
            else
            begin
               $write("\nWarning : Command is input while waiting for ");
               $display("Sector address at time : %0t ",$time);
            end
         end
         else if(valid_datain === 1'b1)
         begin
            //-- After receiving the full sector address
            //-- loading data into the write buffer 
            if(first_sa == 1'b0)
            begin
               if(command_reg === DATAINPUT)
               begin
                  write_buff_count             = (page_addr * PAGE_SIZE) + column_addr;
                  buff_index                   = write_buff_count;
                  write_buff[write_buff_count] = io[(DATA_WIDTH - 1):0];
                  prev_flash_state             = flash_state;
                  flash_state                  = st_program_datain;
               end
               else
                  $display("\nWarning : Illegal Data input in Sector address at time : %0t ",$time);
            end
            else
            begin
               $write("\nWarning : Data is input while waiting for ");
               $display("Sector address at time : %0t ",$time);
            end
         end
         else if(valid_read === 1'b1)
         begin
            $write("\nWarning : Illegal Read condition in Sector ");
            $display("Address state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end // End of st_sector_addr

   //~~~~~~~~~~~~~~~~~~~~~~~~~~
   // PROGRAM DATA INPUT STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_program_datain  :
      begin      
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)     
         begin
            $display("\nWarning : DSE should not be changed during Data input state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)  
         begin
            prev_flash_state = flash_state;
            flash_state      = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low          <= #Twb 1'b1;
            rb_low          <= #(Twb + 1) 1'b0;
            busy_start_t     = $time;
            internal_mres   <= 1'b0;
            rb_high_ar      <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar      <= #(Twb + Tarbsy + 1) 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_datain === 1'b1)
         begin
            //-- collect data into write buufer till the sector boundary is reached
            if(write_buff_count < (SECTOR_SIZE - 1))
            begin
               write_buff_count             = write_buff_count + 1;
               write_buff[write_buff_count] = io[(DATA_WIDTH - 1):0];
            end
            else
               $display("\nWarning : Data input buffer is full at time : %0t ",$time);
         end 
         else if(valid_command === 1'b1)
         begin
            prev_command_reg = command_reg;
            //-- Based on the command changing the state to 
            //-- programming start or rewrite start.
            case(io[7:0])
               AUTOPROGRAM :
               begin
                  command_reg    = io[7:0];
                  if(dev_not_wp == 1'b0)
                  begin
                     $write("\nWarning : Memory is write protected, ");
                     $display("Data not programmed at time : %0t ",$time);
                     prev_flash_state     = flash_state;
                     flash_state          = st_standby;
                  end
                  else
                  begin
                     prev_flash_state     = flash_state;
                     flash_state          = st_program_start;
                     // To take care of a condition when dse_n goes low during Twb
                     rb_low              <= #Twb 1'b1;
                     rb_low              <= #(Twb + 1) 1'b0;
                     busy_start_t         = $time;
                     rb_high             <= #(Twb + Tprog) 1'b1;
                     rb_high             <= #(Twb + Tprog + 1) 1'b0;
                     rb_scheduled         = 1'b1;                      
                     //-- programming is done at the rising edge of program_start
                     program_start       <= #(Twb + Tprog - 1) 1'b1;
                     program_start       <= #(Twb + Tprog) 1'b0;
                  end
               end

               AUTOREWRITE :
               begin
                  command_reg    = io[7:0];
                  if(dev_not_wp == 1'b0)
                  begin
                     $write("\nWarning : Memory is write protected, ");
                     $display("Data not rewriten at time : %0t ",$time);
                     prev_flash_state     = flash_state;
                     flash_state          = st_standby;
                  end
                  else
                  begin
                     prev_flash_state     = flash_state;
                     flash_state          = st_rewrite_start;
                     // To take care of a condition when dse_n goes low during Twb
                     rb_low              <= #Twb 1'b1;
                     rb_low              <= #(Twb + 1) 1'b0;
                     busy_start_t         = $time;
                     rb_high             <= #(Twb + Trewrite) 1'b1;
                     rb_high             <= #(Twb + Trewrite + 1) 1'b0;
                     rb_scheduled         = 1'b1;
                     //-- rewrite is done at the rising edge of program_start
                     program_start       <= #(Twb + Trewrite - 1) 1'b1;
                     program_start       <= #(Twb + Trewrite) 1'b0;
                  end
               end
               default :
               begin
                  $write("\nWarning : Illegal Command input in Data ");
                  $display("input state at time : %0t ",$time);
               end
            endcase
         end 
         else if(valid_read === 1'b1)
         begin
            $write("\nWarning : Illegal Read condition in Program ");
            $display("Datain state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end // End of st_program_datain

   //~~~~~~~~~~~~~~~~~~~~~~~~
   // AUTO PROGRAMMING STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~
      st_program_start   :
      begin
         srd_io1_dse = 1'b0;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)     
         begin
            $display("\nWarning : DSE should not be changed during Program state at time : %0t ",$time);
            //----------------------------------------
            //-- calling the task for writing "0F/0F0F"
            write_to_flash_dse_low (st_program_start);
            //----------------------------------------
            dse_came                  = 1'b1;
            dse_came_count            = dse_came_count + 1;
            sector_state[sector_addr] = 1'b1;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)  
         begin
            pre_came        = 1'b1;
            internal_mres  <= 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_command === 1'b1) 
         begin
            prev_command_reg = command_reg;
            //-- Only status read command is accepted in this state
            if(io[7:0] !== STATUSREAD)
            begin
               $write("\nWarning : Illegal command in Program Start ");
               $display("state at time : %0t ",$time);
            end
            else
               command_reg        = io[7:0];
         end
         else if(valid_read === 1'b1)
         begin
            //-- Reading the status register data 
            if(command_reg === STATUSREAD)
            begin
               data_buff         <= #data_output_time {8'h00, status_reg};
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else
            begin
               $write("\nWarning : Illegal Read condition in Program ");
               $display("Start state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end   
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //----------------------------------------
               //-- calling the task for completing the read operation
               to_finish_read;
               //----------------------------------------
            end
         end
         else if(wp_n_fallingedge == 1'b1)
            $display("\nWarning : Illegal wp_n transition during Program busy period at time : %0t ",$time);

         //-- Automatic Programming operations starts here 
         if(program_start_risingedge == 1'b1 && dse_came == 1'b0)
         begin
            //-- calculating the address index and page number
            //-- based on Full memory or Hash memory
            if(MEMORY_TYPE == FULL)
            begin              
               addr_index  =  (sector_addr * SECTOR_SIZE)
                              + (page_addr * PAGE_SIZE) + column_addr;
               page_num    =  (sector_addr * NUM_OF_PAGES) + page_addr;
            end
            else // Hash memory
            begin  
               //---------------------------------------------
               //-- calling the task to search the sector 
               //-- from the sector address array and to find
               //-- the index within the array   
               hash_sector_search (st_program_start); 
               //---------------------------------------------
               addr_index    = (index_offset_hash * SECTOR_SIZE)
                                     + (page_addr * PAGE_SIZE) + column_addr;
               page_num      =  index_offset_hash * NUM_OF_PAGES + page_addr;
            end
            
            if(write_error == 1'b0)
            begin
               //-- This loop will execute maximum of four times  
               //-- based on the number of data received
               while ( page_addr <= write_buff_count / PAGE_SIZE)
               begin
                  //-- Checking the status of page whether
                  //-- the page is programmed or not 
                  if(page_programmed[page_num] === 1'b0)
                  begin                                  
                     page_programming_over    = 1'b0;
                     page_programmed[page_num]= 1'b1;
                  
                     //-- Programming till the end of a page or 
                     //-- till the data count is reached.
                     while(page_programming_over !== 1'b1)
                     begin
                        memory[addr_index]    = write_buff[buff_index];
                        addr_index            = addr_index + 1;
                        buff_index            = buff_index + 1;
                        if(buff_index > write_buff_count || addr_index % PAGE_SIZE == 0)
                           page_programming_over    = 1'b1;
                     end
                  end
                  else
                  begin
                     $write("\nWarning : Trying to Program without ");
                     $display("Erasing the page is not Allowed at time : %0t ",$time);
                     page_programming_over    = 1'b0;
                      
                     //-- Programming till the end of a page or 
                     //-- till the data count is reached.
                     while(page_programming_over !== 1'b1)
                     begin
                        addr_index           = addr_index + 1;
                        buff_index           = buff_index + 1;
                        if(buff_index > write_buff_count || addr_index % PAGE_SIZE == 0)
                           page_programming_over    = 1'b1;
                     end
                  end
                  page_num    = page_num  + 1;
                  page_addr   = page_addr + 1;
               end
            end
            else
            begin
               hash_warning;
            end
            rb_scheduled         = 1'b0;
         end

         //-- After the successful completion of Autoprogramming 
         //-- operation model enters into Standby state
         //--  or Status Read Setup state if STATUSREAD command has come.
         if(internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state    = flash_state;
            if(command_reg === STATUSREAD)
               flash_state      = st_srd_setup;
            else
               flash_state      = st_standby;
         end
      end // End of st_program_start
      
   //~~~~~~~~~~~~~~~~~~~~~~~~
   //   AUTO REWRITE STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~
      st_rewrite_start   :
      begin
         srd_io1_dse = 1'b0;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)  
         begin
            $display("\nWarning : DSE should not be changed during Rewrite state at time : %0t ",$time);
            //---------------------------------------- 
            //-- calling the task for writing "0F/0F0F"
            write_to_flash_dse_low (st_rewrite_start);
            //----------------------------------------
            dse_came                  = 1'b1;
            dse_came_count            = dse_came_count + 1;
            sector_state[sector_addr] = 1'b1;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin
            pre_came            = 1'b1;
            internal_mres      <= 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end 
         else if(valid_command === 1'b1) 
         begin
            prev_command_reg = command_reg;
            //-- Only status read command is accepted in this state
            if(io[7:0] !== STATUSREAD)
            begin
               $write("\nWarning : Illegal command in Rewrite ");
               $display("start state at time : %0t ",$time);
            end
            else                         
               command_reg        = io[7:0];
         end
         else if(valid_read === 1'b1)
         begin                                    
            //-- Reading the status register data 
            if(command_reg === STATUSREAD)
            begin
               data_buff       <= #data_output_time {8'h00, status_reg};
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else      
            begin
               $write("\nWarning : Illegal Read condition in Rewrite ");
               $display("Start state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
         else if(wp_n_fallingedge == 1'b1)
            $display("\nWarning : Illegal wp_n transition during during Rewrite busy period at time : %0t ",$time);

         //-- Automatic Rewriting operations starts here 
         if(program_start_risingedge == 1'b1 && dse_came == 1'b0)
         begin
            //-- calculating the address index and page number
            //-- based on Full memory or Hash memory
            if(MEMORY_TYPE == FULL) // Full Memory
            begin              
               addr_index   = (sector_addr * SECTOR_SIZE)
                               + (page_addr * PAGE_SIZE) + column_addr;
               page_num     = sector_addr * NUM_OF_PAGES + page_addr;
            end
            else // Hash memory
            begin 
               //---------------------------------------------
               //-- calling the task to search the sector 
               //-- from the sector address array  
               hash_sector_search (st_rewrite_start); 
               //---------------------------------------------
               addr_index    = (index_offset_hash * SECTOR_SIZE)
                               + (page_addr * PAGE_SIZE) + column_addr;
               page_num      = index_offset_hash * NUM_OF_PAGES + page_addr;
            end
               
            if(write_error == 1'b0)
            begin
               //-- This loop will execute maximum of four times  
               //-- based on the number of data received
               while ( page_addr <= write_buff_count / PAGE_SIZE)
               begin
                  page_programming_over    = 1'b0;
                  page_programmed[page_num]= 1'b1;
                  //-- Programming till the end of a page or 
                  //-- till the data count is reached.
                  while(page_programming_over !== 1'b1)
                  begin
                     if(sector_state[sector_addr] == 1'b1)
                     begin
                        if(column_addr == 0 && (write_buff_count - column_addr) % (SECTOR_SIZE - 1) == 0)
                           memory[addr_index]    = write_buff[buff_index];
                        else
                           memory[addr_index]    = DSE_WRITE_DATA;
                     end
                     else
                        memory[addr_index]    = write_buff[buff_index];
                     addr_index            = addr_index + 1;
                     buff_index            = buff_index + 1;
                     if(buff_index > write_buff_count || addr_index % PAGE_SIZE == 0)
                        page_programming_over    = 1'b1;
                  end
                  page_num    = page_num  + 1;
                  page_addr   = page_addr + 1;
               end
               if(column_addr == 0 && (write_buff_count - column_addr) % (SECTOR_SIZE - 1) == 0)
                  sector_state[sector_addr] = 1'b0;
            end
            else
            begin
               hash_warning;
            end
            rb_scheduled         = 1'b0;
         end

         //-- After the successful completion of Autorewrite 
         //-- operation model enters into Standby state
         //--  or Status Read Setup state if STATUSREAD command has come.
         if(internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state    = flash_state;
            if(sector_state[sector_addr] == 1'b1)
            begin
               $write("\nWarning : Since the data of this sector is already destroyed, ");
               $display("the rewriting should perform 1024 words or 2048 bytes. at time : %0t ",$time);
               srd_io1_dse = 1'b1;
            end
            else
               srd_io1_dse = 1'b0;
            if(command_reg === STATUSREAD)
               flash_state      = st_srd_setup;
            else
               flash_state      = st_standby;
         end
      end // End of st_rewrite_start
      
   //~~~~~~~~~~~~~~~~~~~~~~~~
   //   FLASH ERASE STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~
      st_erase_start     :
      begin           
         srd_io1_dse = 1'b0;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)    
         begin
            $display("\nWarning : DSE should not be changed during Erase state at time : %0t ",$time);
            //-----------------------------------------  
            //-- calling the task for writing "0F/0F0F"
            write_to_flash_dse_low (st_erase_start);
            //-----------------------------------------
            dse_came                  = 1'b1;
            dse_came_count            = dse_came_count + 1;
            sector_state[sector_addr] = 1'b1;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin
            pre_came            = 1'b1;
            internal_mres      <= 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end 
         else if(valid_command === 1'b1) 
         begin
            prev_command_reg = command_reg;
            //-- Only status read command is accepted in this state
            if(io[7:0] !== STATUSREAD)
            begin
               $write("\nWarning : Illegal command in Erase Start ");
               $display("state at time : %0t ",$time);
            end
            else
               command_reg     = io[7:0];
         end
         else if(valid_read === 1'b1)
         begin
            if(command_reg === STATUSREAD)
            begin
               data_buff       <= #data_output_time {8'h00, status_reg};
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else
            begin
               $write("\nWarning : Illegal Read condition in Erase ");
               $display("Start state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
         else if(wp_n_fallingedge == 1'b1)
            $display("\nWarning : Illegal wp_n transition during Erase busy period at time : %0t ",$time);

         //-- Automatic Erase operations starts here 
         if(program_start_risingedge == 1'b1 && dse_came == 1'b0)
         begin                                
            //-- calculating the address index based on 
            //-- Full memory and erasing the sector
            if(MEMORY_TYPE == FULL) // Full Memory
            begin
               addr_index   = sector_addr * SECTOR_SIZE;
               page_num     = sector_addr * NUM_OF_PAGES;
               for(i = 0; i < SECTOR_SIZE; i = i + 1)
                  memory[addr_index + i] = ERASE_DATA;
               
               for(i = 0; i < NUM_OF_PAGES; i = i + 1)
                  page_programmed[page_num + i]  = 1'b0;
            end
            else // Hash memory
            begin
            //-- calculating the address index based on 
            //-- Hash memory and erasing the sector
               begin : search_sector_address4
                  for (i = 0; i <= `NUM_OF_SECTORS_HASH; i = i + 1)
                  begin
                     if ( i == `NUM_OF_SECTORS_HASH)
                       display_error("Trying to Erase a sector that is more than declared using \"`NUM_OF_SECTORS_HASH\" ");
                     else if (sector_address[i] === sector_addr)
                     begin
                        addr_index   = i * SECTOR_SIZE;
                        page_num     = i * NUM_OF_PAGES;
                        for(i = 0; i < SECTOR_SIZE; i = i + 1)
                           memory[addr_index + i] = ERASE_DATA;
                        
                        for(i = 0; i < NUM_OF_PAGES; i = i + 1)
                           page_programmed[page_num + i]    = 1'b0;
                        
                        disable search_sector_address4;
                     end
                     else if (sector_address[i] === ALL_X)
                     begin
                        sector_address[i]  = sector_addr;
                        disable search_sector_address4;
                     end
                  end
               end
            end
            rb_scheduled              = 1'b0;
            sector_state[sector_addr] = 1'b0;
         end
 
         //-- After the successful completion of Autoerase 
         //-- operation model enters into Standby state
         //--  or Status Read Setup state if STATUSREAD command has come.
         if(internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state    = flash_state;
            if(command_reg === STATUSREAD)
               flash_state  = st_srd_setup;
            else
               flash_state  = st_standby;
         end
      end // End of st_erase_start

   //~~~~~~~~~~~~~~~~~~~~~~~~
   // SERIAL DATA READ STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~
      st_data_read       :
      begin               
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            seq_last_col_flag  = 1'b0;
            if(command_reg == READMODE)
               $display("\nWarning : DSE should not be changed during Data Read state at time : %0t ",$time);
            else if(command_reg == SEQ_READ)
               $display("\nWarning : DSE should not be changed during Sequential Read state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin
            seq_last_col_flag  = 1'b0;
            prev_flash_state   = flash_state;
            flash_state        = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low            <= #Twb 1'b1;
            rb_low            <= #(Twb + 1) 1'b0;
            busy_start_t       = $time;
            internal_mres     <= 1'b0;
            rb_high_ar        <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar        <= #(Twb + Tarbsy + 1) 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_read === 1'b1)
         begin
            seq_last_col_flag  = 1'b0;
            //-- Full memeory Page read operation starts here ---
            if(MEMORY_TYPE == FULL)
            begin 
               if((addr_index + 1) % PAGE_SIZE == 0)
               begin
                  data_buff    <= #data_output_time memory[addr_index];
                  read_over     = 1'b1;
               end
               else
               begin
                  data_buff    <= #data_output_time memory[addr_index];
                  addr_index    = addr_index + 1;
               end
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else // Hash memory
            begin
               //-- Hash memeory Page read operation starts here ---
               //-- state_info  1 => st_data_read 0 => st_sector_read
               if(command_reg == SEQ_READ)
                  hash_memory_read (1'b0);
               else
                  hash_memory_read (1'b1);
            end
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if (data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
               if(read_over == 1'b1)
               begin
                  if(prev_flash_state == st_seq_read_busy)
                  begin
                     addr_index        = addr_index + 1;
                     if(addr_index >= MEMORY_SIZE)
                     begin
                        prev_flash_state    = flash_state;
                        prev_command_reg    = command_reg;
                        flash_state         = st_seq_read_busy;
                        seq_last_read_flag  = 1'b1;
                        rb_low             <= #(Tsrb) 1'b1;
                        rb_low             <= #(Tsrb + 1) 1'b0;
                        busy_start_t        = $time;
                        rb_high_rd         <= #(Tsrb + Tr) 1'b1;
                        rb_high_rd         <= #(Tsrb + Tr + 1) 1'b0;
                     end 
                     else
                     begin
                        column_addr    = 0;
                        page_addr      = (page_addr + 1) % NUM_OF_PAGES;
                        if(page_addr == 0)
                        begin 
                           sector_addr       = sector_addr + 1;
                           prev_flash_state  = flash_state;
                           flash_state       = st_seq_read_busy;
                           seq_last_col_flag = 1'b1;
                           rb_low           <= #(Tsrb) 1'b1;
                           rb_low           <= #(Tsrb + 1) 1'b0;
                           busy_start_t      = $time;
                           rb_high_rd       <= #(Tsrb + Tr) 1'b1;
                           rb_high_rd       <= #(Tsrb + Tr + 1) 1'b0;
                           rb_scheduled      = 1'b1;
                           search_success    = 1'b0;
                           search_over       = 1'b0;
                           column_addr       = 0;
                        end
                     end
                  end
                  else
                  begin
                     prev_flash_state  = flash_state;
                     flash_state       = st_stop_cmd;
                  end
                  read_over            = 1'b0;
               end
            end
         end
         else if(valid_command === 1'b1)
         begin
            prev_command_reg = command_reg;
            if(prev_flash_state == st_seq_read_busy && io[7:0] !== READSTOP) 
            begin
               case(io[7:0])
                  STATUSREAD : begin
                     seqread_trws_err = 1'b0;
                     command_reg      = io[7:0];
                     flash_state      = st_seq_read_srd;
                  end
                  default : begin
                     $display("\nWarning : Illegal Command input during Sequential Read Mode at time : %0t ",$time);
                  end
               endcase
            end
            else begin
               //-- DATAINPUT, READMODE, AUTOERASE, IDREAD and
               //-- STATUSREAD, SEQ_READ commands are valid in this state.
               case(io[7:0])
                  READMODE, SEQ_READ, IDREAD  :
                  begin
                     seqread_trws_err = 1'b0;
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_setup;
                  end
                  DATAINPUT, AUTOERASE :
                  begin
                     seqread_trws_err = 1'b0;
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_setup;
                  
                     if(tww_violation == 1'b1)   dev_not_wp  = wp_n_status;
                     else if(wp_n === 1'b1)      dev_not_wp  = 1'b1;   
                     else                        dev_not_wp  = 1'b0;
                  end
                  STATUSREAD :
                  begin
                     seqread_trws_err = 1'b0;
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_srd_setup;
                  end
                  READSTOP  :
                  begin
                     command_reg      = io[7:0];
                     srd_io1_dse      = 1'b0;
                     prev_flash_state = flash_state;
                     if(prev_command_reg == SEQ_READ)   flash_state = st_seq_read_stop;
                     else                               flash_state = st_read_stop;
                     search_success    = 1'b0;
                     search_over       = 1'b0;
                     read_over         = 1'b0;
                     if(BUSY_MAX_EN == 1'b1)
                     begin
                        rb_low           <= #Twb 1'b1;
                        rb_low           <= #(Twb + 1) 1'b0;
                        busy_start_t     <= $time;
                        rb_high_rd       <= #(Twb + Trstp) 1'b1;
                        rb_high_rd       <= #(Twb + Trstp + 1) 1'b0;
                        rb_scheduled      = 1'b1;
                        rb_scheduled     <= #(Twb + Trstp) 1'b0;
                     end
                     if(seqread_trhws_err == 1'b1)
                     begin
                        display_error(" RE high to WE low time in Sequential read cycle (tRHWS) violation");
                        seqread_trhws_err <= 1'b0;
                     end
                     if(seqread_trws_err == 1'b1 && seq_last_col_flag == 1'b1)
                     begin
                        display_error(" R/B high to WE low time in Sequential read cycle (tRWS) violation");
                        seqread_trws_err  <= 1'b0;
                     end
                     seq_last_col_flag <= 1'b0;
                  end
                  default    :
                  begin
                     $write("\nWarning : Illegal Command input in Data read ");
                     $display("state at time : %0t ",$time);
                  end
               endcase
            end
         end
      end // End of st_data_read

   //~~~~~~~~~~~~~~~~~~~~~~~~~~
   // SERIAL SECTOR READ STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_sector_read       :
      begin               
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1) 
         begin
            $display("\nWarning : DSE should not be changed during AutoRead state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low          <= #Twb 1'b1;
            rb_low          <= #(Twb + 1) 1'b0;
            busy_start_t     = $time;
            internal_mres   <= 1'b0;
            rb_high_ar      <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar      <= #(Twb + Tarbsy + 1) 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_read === 1'b1)
         begin              
            //-- Full memory Auto (sector) read operation starts here ---
            if(MEMORY_TYPE == FULL)
            begin
               if(addr_index == (SECTOR_SIZE - 1))
               begin
                  data_buff    <= #data_output_time memory[addr_index];
                  read_over     = 1'b1;
               end
               else
               begin
                  data_buff    <= #data_output_time memory[addr_index];
                  addr_index    = addr_index + 1;
               end
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else // Hash memory
            begin                                                        
               //-- Hash memory Auto (sector) read operation starts here 
               //-- state_info  1 => st_data_read 0 => st_sector_read
               hash_memory_read (1'b0);                             
            end
         end
         else if(re_n_fallingedge && !ce_n && !cle  && !ale && we_n)
         begin
            $write("\nWarning : Illegal Read condition in Sector Read ");
            $display("state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if (data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
               if(read_over == 1'b1)
               begin
                  //-- Change the state to command deep standby state
                  //-- if it has come from command deep standby state
                  //-- after completion of sector read.
                  read_over        = 1'b0;
                  prev_flash_state = flash_state;

                  if(from_deepstandby == 1'b1)
                  begin
                     from_deepstandby = 1'b0;
                     flash_state      = st_cmnd_deepstandby;
                  end
                  else
                     flash_state      = st_stop_cmd;
                  pwr_auto_r_flag  <= 1'b0;
               end
            end
         end
         else if(valid_command === 1'b1 && pwr_auto_r_flag == 1'b0)
         begin     
            prev_command_reg = command_reg;
            //-- DATAINPUT, READMODE, AUTOERASE, IDREAD and
            //-- STATUSREAD commands are valid in this state.      
            case(io[7:0])
               DSBYSETUP  :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_cmnd_deepstandby;
               end
               READMODE, SEQ_READ, IDREAD  :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_setup;
               end
               DATAINPUT, AUTOERASE :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_setup;
               
                  if(tww_violation == 1'b1)   dev_not_wp   = wp_n_status;
                  else if(wp_n === 1'b1)      dev_not_wp   = 1'b1;
                  else                        dev_not_wp   = 1'b0;
               end
               STATUSREAD :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_srd_setup;
               end
               READSTOP  :
               begin
                  srd_io1_dse      = 1'b0;
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_read_stop;
                  search_success   = 1'b0;
                  search_over      = 1'b0;
                  read_over        = 1'b0;
                  if (BUSY_MAX_EN == 1'b1)
                  begin
                     rb_low          <= #Twb 1'b1;
                     rb_low          <= #(Twb + 1) 1'b0;
                     busy_start_t    <= $time;
                     rb_high_rd      <= #(Twb + Trstp) 1'b1;
                     rb_high_rd      <= #(Twb + Trstp + 1) 1'b0;
                     rb_scheduled     = 1'b1;
                     rb_scheduled    <= #(Twb + Trstp) 1'b0;
                  end
               end
               default    :
               begin
                  $write("\nWarning : Illegal Command input in Sector read ");
                  $display("state at time : %0t ",$time);
               end
            endcase
         end
         else if(valid_command === 1'b1 && pwr_auto_r_flag == 1'b1)
         begin
            case(io[7:0])
               STATUSREAD :
               begin
                  command_reg      = io[7:0];
                  prev_flash_state = flash_state;
                  flash_state      = st_srd_setup;
               end
               READSTOP  :
               begin
                  srd_io1_dse      = 1'b0;
                  prev_command_reg = command_reg;
                  command_reg      = io[7:0];
                  pwr_auto_r_flag <= 1'b0;
                  prev_flash_state = flash_state;
                  flash_state      = st_read_stop;
                  search_success   = 1'b0;
                  search_over      = 1'b0;
                  read_over        = 1'b0;
                  if (BUSY_MAX_EN == 1'b1)
                  begin
                     rb_low          <= #Twb 1'b1;
                     rb_low          <= #(Twb + 1) 1'b0;
                     busy_start_t    <= $time;
                     rb_high_rd      <= #(Twb + Trstp) 1'b1;
                     rb_high_rd      <= #(Twb + Trstp + 1) 1'b0;
                     rb_scheduled     = 1'b1;
                     rb_scheduled    <= #(Twb + Trstp) 1'b0;
                  end
               end 
               default    :
               begin
                  $write("\nWarning : Illegal Command input in Sector read ");
                  $display("state at time : %0t ",$time);
               end
            endcase
         end
      end // End of st_sector_read

   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // STATUS REGISTER READ STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_srd_setup       :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)    
         begin
            if(rb_scheduled == 1'b1)
               dse_came_rd   = 1'b1;
            $display("\nWarning : DSE should not be changed during Status Read state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin
            if(rb_scheduled == 1'b1)
            begin
            //-- pre_came_rd is made '1' here b'coz rb_n would have 
            //-- been scheduled in sector address state
               rb_high_ar   <= #Tarbsy 1'b1;
               rb_high_ar   <= #(Tarbsy + 1) 1'b0;
               pre_came_rd   = 1'b1;
            end
            else
            begin
                // To take care of a condition when dse_n goes low during Twb
                rb_low       <= #Twb 1'b1;
                rb_low       <= #(Twb + 1) 1'b0;
                busy_start_t = $time;
                rb_high_ar   <= #(Twb + Tarbsy) 1'b1;
                rb_high_ar   <= #(Twb + Tarbsy + 1) 1'b0;
            end

            prev_flash_state = flash_state;
            flash_state       = st_autoread;
            internal_mres    <= 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_read === 1'b1)
         begin
            data_buff  <= #data_output_time {8'h00, dev_not_wp, internal_rb, 5'b00000, SRD_IO1_FAIL || srd_io1_dse};
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if (data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;               
            end // End of if (data_output_over.......
         end
         else if(valid_command === 1'b1)
         begin
            if(internal_rb == 1'b1 && internal_mres == 1'b1)
            begin
               if(prev_flash_state == st_autoread || prev_flash_state == st_sector_read
               || prev_flash_state == st_sector_addr || prev_flash_state == st_data_read)
               begin
                  case(io[7:0])
                     READMODE : begin
                        prev_command_reg = command_reg;
                        command_reg      = io[7:0];
                        if(prev_flash_state == st_autoread || prev_flash_state == st_sector_read)   
                           flash_state = st_sector_read;
                        else
                           flash_state = st_data_read; 
                     end
                     STATUSREAD : begin
                     end
                     READSTOP   : begin
                        srd_io1_dse      = 1'b0;
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        if(prev_command_reg == SEQ_READ)   flash_state = st_seq_read_stop;
                        else                               flash_state = st_read_stop;
                        search_success    = 1'b0;
                        search_over       = 1'b0;
                        read_over         = 1'b0;
                        if(BUSY_MAX_EN == 1'b1)
                        begin
                           rb_low           <= #Twb 1'b1;
                           rb_low           <= #(Twb + 1) 1'b0;
                           busy_start_t     <= $time;
                           rb_high_rd       <= #(Twb + Trstp) 1'b1;
                           rb_high_rd       <= #(Twb + Trstp + 1) 1'b0;
                           rb_scheduled      = 1'b1;
                           rb_scheduled     <= #(Twb + Trstp) 1'b0;
                        end
                     end 
                     default    : begin
                        $write("\nWarning : Illegal Command input in Status");
                        $display(" Read Setup state at time : %0t ",$time);
                     end
                  endcase 
               end
               else begin
                  prev_command_reg = command_reg;
                  case(io[7:0])
                     SEQ_READ, IDREAD  : begin
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        flash_state      = st_setup;
                     end
                     DATAINPUT, AUTOERASE : begin
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        flash_state      = st_setup;
                 
                        if(tww_violation == 1'b1)    dev_not_wp   = wp_n_status;
                        else if(wp_n === 1'b1)       dev_not_wp   = 1'b1;
                        else                         dev_not_wp   = 1'b0; 
                     end
                     READMODE : begin
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        flash_state      = st_setup;
                     end
                     STATUSREAD : begin
                     end
                     default    : begin
                        $write("\nWarning : Illegal Command input in Status");
                        $display(" Read Setup state at time : %0t ",$time);
                     end
                  endcase
               end
            end
            else begin
               case(io[7:0])
                  STATUSREAD : begin
                  end
                  default    : begin
                     $write("\nWarning : Illegal Command input in Status");
                     $display(" Read Setup state at time : %0t ",$time);
                  end
               endcase
            end 
         end
         else if(internal_rb_risingedge == 1'b1)
         begin
            rb_scheduled    = 1'b0;
            if(read_srd_err_flag == 1'b1)
            begin
               srd_io1_dse       = 1'b1;
               read_srd_err_flag = 1'b0;
            end
            if(prev_flash_state == st_autoread)
            begin
               addr_index  = 0;
               column_addr = 0;
               page_addr   = 0;
               sector_addr = 0;
            end
         end
      end // End of st_srd_setup
      
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   //      ID READ STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_idread_addr     :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during ID Read state at time : %0t ",$time);
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_autoread;
            // To take care of a condition when dse_n goes low during Twb
            rb_low          <= #Twb 1'b1;
            rb_low          <= #(Twb + 1) 1'b0;
            busy_start_t     = $time;
            internal_mres   <= 1'b0;
            rb_high_ar      <= #(Twb + Tarbsy) 1'b1;
            rb_high_ar      <= #(Twb + Tarbsy + 1) 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(valid_read === 1'b1)
         begin 
            //-- Outputting Manufacturer code in the first read cycle
            if(manufacturer_code_read == 1'b0)
            begin
               data_buff             <= #Treaid MANUFACTURER_CODE;
               manufacturer_code_read = 1'b1;
            end                                                      
            //-- Outputting device code in the first read cycle
            else
            begin
               data_buff             <= #Treaid DEVICE_CODE;
               manufacturer_code_read = 1'b0;
            end
            data_output_time          = Treaid;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if (data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
               if(manufacturer_code_read == 1'b0)
               begin
                  prev_flash_state    = flash_state;
                  flash_state         = st_standby;
               end
            end
         end
      end // End of st_idread_addr
      
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   //  SEQUENTIAL DATA READ BUSY STATE
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_seq_read_busy :
      begin
         dev_not_wp  = wp_n;
         srd_io1_dse = 1'b0;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            seq_last_read_flag  = 1'b0;
            seq_last_col_flag   = 1'b0;
            $display("\nWarning : DSE should not be changed during Sequential Read busy state at time : %0t ",$time);
            if(prev_flash_state == st_sector_addr && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;
            else if(prev_flash_state == st_data_read && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;
            
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
            if(rb_scheduled == 1'b1)
               dse_came_rd      = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1) 
         begin
            seq_last_read_flag  = 1'b0;
            seq_last_col_flag   = 1'b0;
            if(internal_rb == 1'b1)
            begin
               if(($time - busy_start_t) < Twb && prev_flash_state == st_sector_addr)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else if(($time - busy_start_t) < Twb)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else
               begin
                  rb_low       <= #Twb 1'b1;
                  rb_low       <= #(Twb + 1) 1'b0;
                  rb_high_ar   <= #(Twb + Tarbsy) 1'b1;
                  rb_high_ar   <= #(Twb + Tarbsy + 1) 1'b0;
                  busy_start_t  = $time;
               end
            end
            else
            begin
               rb_high_ar      <= #Tarbsy 1'b1;
               rb_high_ar      <= #(Tarbsy + 1) 1'b0;
            end
            prev_flash_state    = flash_state;
            flash_state         = st_autoread;
            pre_came_rd         = 1'b1;
            internal_mres      <= 1'b0;
            rb_scheduled        = 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(internal_rb_risingedge == 1'b1)
         begin
            if(sector_state[sector_addr] == 1'b1)
               srd_io1_dse = 1'b1;
            if(seq_last_read_flag == 1'b1)
            begin
               prev_flash_state   = flash_state;
               flash_state        = st_stop_cmd;
            end
            else begin
               prev_flash_state = flash_state;
               flash_state      = st_data_read;
            end
            rb_scheduled        = 1'b0;
         end
         else if(valid_command === 1'b1)
         begin
           prev_command_reg = command_reg;
           case(io[7:0])
              STATUSREAD :
              begin
                 command_reg      = io[7:0];
                 prev_flash_state = flash_state;
                 flash_state      = st_seq_read_srd;

                 if(seqread_trhws_err == 1'b1)
                 begin
                    seqread_trhws_err <= 1'b0;
                 end
                 if(sector_state[sector_addr] == 1'b1)
                    read_srd_err_flag = 1'b1;
              end
              default    :
                 $display("\nWarning : Illegal Command input in Sequential Read busy state at time : %0t ",$time);
           endcase
         end
         else if(valid_read === 1'b1)
         begin
            $write("\nWarning : Illegal Read condition in Sequential ");
            $display("Read busy state at time : %0t ",$time);
            data_buff   <= #data_output_time ANY_DATA;
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
         end
         // To complete read operation.
         if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end // End of st_seq_read_busy

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// STATUS READ STATE IN SEQUENTIAL READ
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      st_seq_read_srd :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during Sequential Read busy state at time : %0t ",$time);
            if(prev_flash_state == st_sector_addr && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;
            else if(prev_flash_state == st_data_read && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;

            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
            if(rb_scheduled == 1'b1)
               dse_came_rd      = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            if(internal_rb == 1'b1)
            begin
               if(($time - busy_start_t) < Twb && prev_flash_state == st_sector_addr)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else if(($time - busy_start_t) < Twb)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else
               begin
                  rb_low       <= #Twb 1'b1;
                  rb_low       <= #(Twb + 1) 1'b0;
                  rb_high_ar   <= #(Twb + Tarbsy) 1'b1;
                  rb_high_ar   <= #(Twb + Tarbsy + 1) 1'b0;
                  busy_start_t  = $time;
               end
            end
            else
            begin
               rb_high_ar      <= #Tarbsy 1'b1;
               rb_high_ar      <= #(Tarbsy + 1) 1'b0;
            end
            prev_flash_state    = flash_state;
            flash_state         = st_autoread;
            pre_came_rd         = 1'b1;
            internal_mres      <= 1'b0;
            rb_scheduled        = 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end
         else if(internal_rb == 1'b0 && valid_command === 1'b1)
         begin
            prev_command_reg = command_reg;
            if(io[7:0] == STATUSREAD)
               command_reg  <= io[7:0];
            else
               $display("\nWarning : Illegal Command input in Sequential Read state at time : %0t ",$time);                    
         end
         if(internal_rb == 1'b1 && rb_scheduled == 1'b0)
         begin
            if(read_srd_err_flag == 1'b1)
            begin
               srd_io1_dse       = 1'b1;
               read_srd_err_flag = 1'b0;
            end
            if(valid_command === 1'b1)
            begin
               prev_command_reg = command_reg;
               case (io[7:0])
                  STATUSREAD :
                  begin
                     command_reg        = io[7:0];
                     flash_state        = st_seq_read_srd;
                     seqread_trhws_err <= 1'b0;
                  end
                  READMODE   :
                  begin
                     command_reg        = SEQ_READ;
                     flash_state        = st_data_read;
                     seqread_trhws_err <= 1'b0;
                  end
                  default    :
                  begin
                     $display("\nWarning : Illegal Command input in Sequential Read state at time : %0t ",$time);
                     $display("\nWarning : Command should be input 00H");
                  end
               endcase
            end
         end

         if(valid_read === 1'b1)
         begin
            //-- Reading the status register data
            if (command_reg === STATUSREAD)
            begin
               data_buff   <= #data_output_time  {8'h00, status_reg};
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else
            begin
               $write("\nWarning : Illegal Read condition in Sequential ");
               $display("Read state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
         end

         // To complete read operation.
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
         else if (internal_rb_risingedge == 1'b1)
            rb_scheduled    = 1'b0;
      end // End of st_seq_read_srd


//~~~~~~~~~~~~~~~~~~
// STOP READ STATE
//~~~~~~~~~~~~~~~~~~
      st_read_stop :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during Read stop state at time : %0t ",$time);
            if(prev_flash_state == st_sector_addr && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;
            else if(prev_flash_state == st_data_read && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;

            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
            if(rb_scheduled == 1'b1)
               dse_came_rd      = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            if(internal_rb == 1'b1)
            begin
               if(($time - busy_start_t) < Twb && prev_flash_state == st_sector_addr)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else if(($time - busy_start_t) < Twb)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else
               begin
                  rb_low       <= #Twb 1'b1;
                  rb_low       <= #(Twb + 1) 1'b0;
                  rb_high_ar   <= #(Twb + Tarbsy) 1'b1;
                  rb_high_ar   <= #(Twb + Tarbsy + 1) 1'b0;
                  busy_start_t  = $time;
               end
            end
            else
            begin
               rb_high_ar      <= #Tarbsy 1'b1;
               rb_high_ar      <= #(Tarbsy + 1) 1'b0;
            end
            prev_flash_state    = flash_state;
            flash_state         = st_autoread;
            pre_came_rd         = 1'b1;
            internal_mres      <= 1'b0;
            rb_scheduled        = 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end

         if(valid_command === 1'b1)
         begin
            if(io[7:0] == STATUSREAD)
            begin
               //-- Only status read command is accepted in this state
               prev_command_reg = command_reg;
               command_reg      = io[7:0];
            end
            else begin
               $write("\nWarning : Illegal command in Read Stop ");
               $display("state at time : %0t ", $time);
            end
         end
         else if(valid_read === 1'b1)
         begin
            //-- Reading the status register data
            if (command_reg === STATUSREAD)
            begin
               data_buff   <= #data_output_time  {8'h00, status_reg};
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
            else
            begin
               $write("\nWarning : Illegal Read condition in ");
               $display("Read Stop state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
         end

         // To complete read operation.
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
         else if (internal_rb_risingedge == 1'b1)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_standby;
            rb_scheduled     = 1'b0; 
         end
         else if (BUSY_MAX_EN == 1'b0)
         begin
            prev_flash_state = flash_state;
            flash_state      = st_standby;
         end
      end // End of st_read_stop

   //~~~~~~~~~~~~~~~~~~~~~~~
   //    READ STOP COMMAND WAITE STATE
   //~~~~~~~~~~~~~~~~~~~~~~~
      st_stop_cmd         :
      begin
         dev_not_wp   = wp_n;
         flash_state  = st_stop_cmd;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            seq_last_read_flag = 1'b0;
            $display("\nWarning : DSE should not be changed during Read stop state at time : %0t ",$time);
            if(prev_flash_state == st_sector_addr && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;
            else if(prev_flash_state == st_data_read && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;

            dse_low_read;
            if(rb_scheduled == 1'b1)
               dse_came_rd      = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            seq_last_read_flag = 1'b0;
            if(internal_rb == 1'b1)
            begin
               if(($time - busy_start_t) < Twb && prev_flash_state == st_sector_addr)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else if(($time - busy_start_t) < Twb)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else
               begin
                  rb_low       <= #Twb 1'b1;
                  rb_low       <= #(Twb + 1) 1'b0;
                  rb_high_ar   <= #(Twb + Tarbsy) 1'b1;
                  rb_high_ar   <= #(Twb + Tarbsy + 1) 1'b0;
                  busy_start_t  = $time;
               end
            end
            else
            begin
               rb_high_ar      <= #Tarbsy 1'b1;
               rb_high_ar      <= #(Tarbsy + 1) 1'b0;
            end
            prev_flash_state    = flash_state;
            flash_state         = st_autoread;
            pre_came_rd         = 1'b1;
            internal_mres      <= 1'b0;
            rb_scheduled        = 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end

         else if(valid_command === 1'b1)
         begin
            prev_command_reg = command_reg;
            if(prev_command_reg ==  SEQ_READ)
            begin
               case(io[7:0])
                  READSTOP :
                  begin
                     srd_io1_dse      = 1'b0;
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_seq_read_stop;
                     if(BUSY_MAX_EN == 1'b1)
                     begin
                        rb_high_stp  <= #Twb 1'b0;
                        rb_high_stp  <= #(Twb + Trstp) 1'b1;
                        busy_start_t  = $time;
                     end
                     if(seqread_trhws_err == 1'b1)
                     begin
                       display_error(" RE high to WE low time in Sequential read cycle (tRHWS) violation");
                       seqread_trhws_err <= 1'b0;
                     end
                     if(seqread_trws_err == 1'b1)
                     begin
                        display_error(" R/B high to WE low time in Sequential read cycle (tRWS) violation");
                        seqread_trws_err = 1'b0;
                     end
                  end
                  default    :
                     $display("\nWarning : Illegal Command input in Read stop command input state at time : %0t ",$time);
               endcase
            end

            else begin
               case(io[7:0])
                  READSTOP :
                  begin
                     srd_io1_dse = 1'b0;
                     if(prev_flash_state == st_data_read)
                     begin
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        flash_state      = st_read_stop;
                        if(BUSY_MAX_EN == 1'b1)
                        begin
                           rb_low       <= #Twb 1'b1;
                           rb_low       <= #(Twb + 1) 1'b0;
                           rb_high      <= #(Twb + Trstp) 1'b1;
                           rb_high      <= #(Twb + Trstp + 1) 1'b0;
                           busy_start_t  = $time;
                        end
                     end
                     else if (prev_flash_state == st_sector_read)
                     begin
                        command_reg      = io[7:0];
                        prev_flash_state = flash_state;
                        flash_state      = st_standby;
                     end
                  end

                  READMODE, SEQ_READ, IDREAD  :
                  begin
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_setup;
                  end

                  DATAINPUT, AUTOERASE :
                  begin
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_setup;

                     if(tww_violation == 1'b1)   dev_not_wp   = wp_n_status;
                     else if(wp_n === 1'b1)      dev_not_wp   = 1'b1; 
                     else                        dev_not_wp   = 1'b0; 
                  end

                  STATUSREAD :
                  begin
                     command_reg      = io[7:0];
                     prev_flash_state = flash_state;
                     flash_state      = st_srd_setup;
                  end

                  default    :
                     $display("\nWarning : Illegal Command input in Read stop command input state at time : %0t ",$time);
               endcase
            end
         end
         else if(valid_read === 1'b1)
         begin
            if(ce_n == 1'b0)
            begin
               $display("\nWarning : Illegal Read condition in Read stop command input state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               schedule_data;
            end
         end

         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(make_io_z == 1'b1)
            begin
               make_io_z     = 1'b0;
               if(re_n_risingedge == 1'b1)
                  io_reg    <= #Trhz HIZ;
               else
                  io_reg    <= #Tchz HIZ;
            end
            else if (data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
      end

//~~~~~~~~~~~~~~~~~~
// SEQUENTIAL READ STOP STATE
//~~~~~~~~~~~~~~~~~~
      st_seq_read_stop :
      begin
         dev_not_wp = wp_n;
         //--- Model enters into deep standby state
         if(dse_n_fallingedge == 1'b1)
         begin
            $display("\nWarning : DSE should not be changed during Read stop state at time : %0t ",$time);
            if(prev_flash_state == st_sector_addr && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;
            else if(prev_flash_state == st_data_read && ($time - busy_start_t < Twb))
               dse_came_during_twb_taras = 1'b1;

            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule DSE Data
            dse_low_read;
            //----------------------------------------
            if(rb_scheduled == 1'b1)
               dse_came_rd      = 1'b1;
         end
         //--- Model enters into autoread state
         else if(pre_fallingedge == 1'b1 && autoread_flag == 1'b1)
         begin
            if(internal_rb == 1'b1)
            begin
               if(($time - busy_start_t) < Twb && prev_flash_state == st_sector_addr)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else if(($time - busy_start_t) < Twb)
               begin
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t)) 1'b1;
                  rb_high_ar   <= #(Tarbsy + Twb - ($time - busy_start_t) + 1) 1'b0;
               end
               else
               begin
                  rb_low       <= #Twb 1'b1;
                  rb_low       <= #(Twb + 1) 1'b0;
                  rb_high_ar   <= #(Twb + Tarbsy) 1'b1;
                  rb_high_ar   <= #(Twb + Tarbsy + 1) 1'b0;
                  busy_start_t  = $time;
               end
            end
            else
            begin
               rb_high_ar      <= #Tarbsy 1'b1;
               rb_high_ar      <= #(Tarbsy + 1) 1'b0;
            end
            prev_flash_state    = flash_state;
            flash_state         = st_autoread;
            pre_came_rd         = 1'b1;
            internal_mres      <= 1'b0;
            rb_scheduled        = 1'b0;
            //----------------------------------------
            // call task to find the whether data is to be neglected & schedule PRE Data
            pre_low_read;
            //----------------------------------------
         end

         if(valid_command === 1'b1)
         begin
            if(io[7:0] == STATUSREAD)
            begin
               //-- Only status read command is accepted in this state
               prev_command_reg = command_reg;
               command_reg      = io[7:0];
            end
            else begin
               $write("\nWarning : Illegal command in Sequential Read Stop ");
               $display("state at time : %0t ", $time);
            end
         end
         else if(valid_read === 1'b1)
         begin
            //-- Reading the status register data
            if (command_reg === STATUSREAD)
            begin
               data_buff   <= #data_output_time  {8'h00, status_reg};
            //----------------------------------------
            // -- call task to schedule data on the "io" bus
            schedule_data;
            //----------------------------------------
            end
            else
            begin
               $write("\nWarning : Illegal Read condition in ");
               $display("Read Stop state at time : %0t ",$time);
               data_buff   <= #data_output_time ANY_DATA;
               //----------------------------------------
               // -- call task to schedule data on the "io" bus
               schedule_data;
               //----------------------------------------
            end
         end

         // To complete read operation.
         else if(re_n_risingedge == 1'b1 || ce_n_risingedge == 1'b1)
         begin
            if(data_output_over == 1'b1)
            begin
               //-- calling the task for completing the read operation
               to_finish_read;
            end
         end
         if (ce_n_risingedge == 1'b1)
         begin
            seqread_stop_cmd_flag <= #Tcehs 1'b1;
         end
         else if (internal_rb_risingedge == 1'b1)
         begin
            rb_scheduled     = 1'b0;
            if (seqread_stop_cmd_flag == 1'b1)
            begin
               prev_flash_state       = flash_state;
               flash_state            = st_standby;
               seqread_stop_cmd_flag <= 1'b0;
            end
         end
         if (internal_rb == 1'b1 && seqread_stop_cmd_flag == 1'b1)
         begin
            prev_flash_state       = flash_state;
            flash_state            = st_standby;
            seqread_stop_cmd_flag <= 1'b0;
         end
      end // End of st_seq_read_stop

      default            :  begin  end

   endcase // End of Flash states

   //-- if "pre" is low after "rb_n" going high by Auto read --------------
   //-- then "mres_n" should be made high only after "pre" made high
   if(make_mres_n_high == 1'b1 && pre === 1'b1)
   begin
      if($time - rb_rise_t < Trmres)
         internal_mres    <= #(Trmres - ($time - rb_rise_t)) 1'b1;
      else
         internal_mres    <= #(Trmres) 1'b1;
      make_mres_n_high    <= 1'b0;
   end

   // ==================== Dump function ====================================
   if(dump_risingedge == 1'b1)
   begin    
      //==== The contents of the memory array are dumped into a 'dump.mem' file ====
      dump_mem_ptr    = $fopen("dump.mem");
      if(MEMORY_TYPE == FULL)
      begin
         if( DUMP_MEM_EN == 0) // Dump full memory
         begin
           dump_start_addr_flash     = 0;
           dump_end_addr_flash       = MEMORY_SIZE - 1;
         end
         else // Dump Partial Memory  
         begin
           dump_start_addr_flash     = DUMP_START_ADDR;
           dump_end_addr_flash       = DUMP_END_ADDR;
         end 
         
         if( dump_start_addr_flash <=  dump_end_addr_flash )
         begin
           if(dump_end_addr_flash > (MEMORY_SIZE - 1))
              display_error("Dump_end_addr_flash is exceeding the Memory Size ");
         end
         else
           display_error(" Dump_start_addr is more than Dump_end_addr ");
                  
         $display("\n#############################################################");
         $display("\n Dumping the Memory contents into dump.mem File, Please wait... ");  
         $display("\n#############################################################\n");
         
         $fdisplay(dump_mem_ptr,"// Contents of Memory at time : %0t ", $realtime);  
         $fdisplay(dump_mem_ptr," ");
         
         $fdisplay(dump_mem_ptr,"@%h", dump_start_addr_flash[SECTOR_START : 0]);
         
         // Dump the specified portion of the memory      
         for(dump_addr = dump_start_addr_flash; dump_addr <= dump_end_addr_flash; dump_addr = dump_addr + 1) 
            $fdisplay(dump_mem_ptr,"%h",memory[dump_addr]);

         $fdisplay(dump_mem_ptr," "); 
      end
      else
         $display("\nWarning : Memory can't be dumped in case of HASH memory at time : %0t ",$time);
      // Close the file pointer
      $fclose(dump_mem_ptr);
   end

   // ====================== End of Dump function ================
   prev_internal_rb    = internal_rb;
   prev_cle            = cle;
   prev_ale            = ale;
   prev_ce_n           = ce_n;
   prev_re_n           = re_n;
   prev_we_n           = we_n;
   prev_wp_n           = wp_n;
   prev_pre            = pre;
   prev_dse_n          = dse_n;
   prev_io             = io;
   prev_dump           = dump;
   prev_program_start  = program_start;
   valid_command       = 1'b0;
   valid_address       = 1'b0;
   valid_datain        = 1'b0;
   valid_read          = 1'b0;
end

//==============================================================================
//                Ready/Busy(rb) output Scheduling During busy
//==============================================================================

always @(posedge rb_high or posedge rb_low or posedge rb_high_ar or 
         posedge rb_high_rd or posedge data_output or rb_high_stp)
begin
   // rb_high will be scheduled in case of program/rewrite/erase cases. when
   // it goes high, "rb" will be made 1 depending on "dse" or "pre" has come
   // during busy period.
   if(rb_high == 1'b1)
   begin
      if(dse_came == 1'b1)
      begin
         if(dse_came_count == 1)
         begin
            dse_came       = 1'b0;
            dse_came_count = 0;
         end
         else
            dse_came_count = dse_came_count - 1;
      end
      else if(pre_came == 1'b1)
      begin
         pre_came             = 1'b0;
         prev_flash_state     = flash_state;
         flash_state          = st_autoread;
         rb_high_ar          <= #Tarbsy 1'b1;
         rb_high_ar          <= #(Tarbsy + 1) 1'b0;
      end
      else
      begin
         internal_rb     <= 1'b1;
         if(((pre === 1'b1 || flash_state == st_power_on_off) && flash_state != st_power_on_wait)
         && prev_flash_state != st_power_on_wait)
            internal_mres    <= #Trmres 1'b1;
         else if(flash_state != st_power_on_wait && prev_flash_state != st_power_on_wait)
            make_mres_n_high <= 1'b1;
      end
   end

   // rb_high_ar will be scheduled in case of Auto read busy. "rb" will 
   // be made 1 depending on whether "dse" came during busy period.
   if(rb_high_ar == 1'b1)
   begin
      if(dse_came_ar == 1'b1)
      begin
         if(dse_came_ar_count == 1)
         begin
            dse_came_ar       = 1'b0;
            dse_came_ar_count = 0;
         end
         else
            dse_came_ar_count = dse_came_ar_count - 1;
      end
      else
      begin
         internal_rb    = 1'b1;
         if(pre === 1'b1 || flash_state == st_power_on_off)
            internal_mres     <= #Trmres 1'b1;
         else
            make_mres_n_high  <= 1'b1;
      end
   end

   // rb_high_rd will be scheduled in case of read busy. "rb" will 
   // be made 1 depending on whether "dse" or "pre" came during busy period.
   if(rb_high_rd == 1'b1)
   begin
      if(dse_came_rd == 1'b1)
         dse_came_rd = 1'b0;
      else if(pre_came_rd == 1'b1)
      begin
         pre_came_rd     = 1'b0;
      end
      else
      begin
         internal_rb     <= 1'b1;
         if(pre === 1'b1)
            internal_mres    <= #Trmres 1'b1;
         else
            make_mres_n_high <= 1'b1;
      end
   end

   // scheduling of "rb" to low after tWB or tARAS
   if(rb_low == 1'b1)
   begin
      if(dse_came_during_twb_taras == 1'b0)
         internal_rb                <= 1'b0;
      else
         dse_came_during_twb_taras   = 1'b0;
   end

   // Data scheduling on "io" bus
   if(data_output == 1'b1)
   begin
      if(send_no_value_data == 1'b1 && data_buff == NO_VALUE_DATA)
      begin
         send_no_value_data   = 1'b0;
         io_reg              <= data_buff;
      end
      else if(neglect_data == 1'b1 && data_buff !== DONT_CARE)
         neglect_data = 1'b0;
      else
         io_reg      <= data_buff;
      if(data_buff === HIZ && re_n === 1'b1)
         data_scheduled   <= 1'b0;
   end

   // add read stop
   if(rb_high_stp == 1'b0)
   begin
     internal_rb   <=1'b0;
   end
end // End of always for scheduling.....

always @(posedge rb_high_stp)
begin
   if(pre_came_rd == 1'b1)
      internal_rb   <=1'b0;
   else if(command_reg == READSTOP)
      internal_rb   <=1'b1;
   else if ((flash_state == st_power_on_off || flash_state == st_autoread) 
   && prev_flash_state == st_power_on_wait)
   begin
      internal_mres    <= #Trmres 1'b1;
      make_mres_n_high <= 1'b1;
      internal_rb      <= 1'b1;
   end
end
//==============================================================================   
endmodule
