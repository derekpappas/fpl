`include "inc.h"

//*******************************************************************************
//  S Y N T H E Z I A B L E      S D R A M     C O N T R O L L E R    C O R E
//
//  This core adheres to the GNU Public License  
//  www.cmosexod.com 
//
//  This is a synthesizable Synchronous DRAM controller Core. 
//
//  2Mbyte Version
//      512K x 2 banks x 16
//
//  The core has been carefully coded so as to be "platform-independent".  
//  It has been successfully compiled and simulated under three separate
//  FPGA/CPLD platforms:
//      Xilinx Foundation Base Express V2.1i
//      Altera Max+PlusII V9.21
//      Lattice ispExpert V7.0
//  
//  The interface to the host (i.e. microprocessor, DSP, etc) is synchronous
//  and supports ony one transfer at a time.  That is, burst-mode transfers
//  are not yet supported.  In may ways, the interface to this core is much
//  like that of a typical SRAM.  The hand-shaking between the host and the 
//  SDRAM core is done through the "sdram_busy_l" signal generated by the 
//  core.  Whenever this signal is active low, the host must hold the address,
//  data (if doing a write), size and the controls (cs, rd/wr).  
//
//  Connection Diagram:
//  SDRAM side:
//  sd_wr_l                     connect to -WR pin of SDRAM
//  sd_cs_l                     connect to -CS pin of SDRAM
//  sd_ras_l                    connect to -RAS pin of SDRAM
//  sd_cas_l                    connect to -CAS pin of SDRAM
//  sd_dqm[1:0]                 connect to the UDQM and LDQM (respectively) pins
//  sd_addx[10:0]               connect to the Address bus [10:0]
//  sd_data[15:0]               connect to the data bus [15:0]
//  sd_ba                       connect to BA pin of SDRAM
//   
//  HOST side:
//  mp_addx[20:0]               connect to the address bus of the host. 
//                              21 bit address bus give access to 2Mbyte
//                              of the SDRAM, as byte or half-word (16bit)
//  mp_data_in[15:0]            Unidirectional bus connected to the data out
//                              of the host. To use this, enable 
//                              "databus_is_unidirectional" in INC.H
//  mp_data_out[15:0]           Unidirectional bus connected to the data in 
//                              of the host.  To use this, enable
//                              "databus_is_unidirectional" in INC.H
//  mp_data[15:0]               Bi-directional bus connected to the host's
//                              data bus.  To use the bi-directionla bus,
//                              disable "databus_is_unidirectional" in INC.H
//  mp_rd_l                     Connect to the -RD output of the host
//  mp_wr_l                     Connect to the -WR output of the host
//  mp_cs_l                     Connect to the -CS of the host
//  mp_size[1:0]                Connect to the size output of the host
//                              if there is one.  When set to 0
//                              all trasnfers are 16 bits, when set to 1
//                              all transfers are 8 bits. If you want the
//                              data to be lower order aligned, turn on
//                              "align_data_bus" option in INC.H
//  sdram_busy_l                Connect this to the wait or hold equivalent
//                              input of the host.  The host, must hold the
//                              bus if it samples this signal as low.
//  sdram_mode_set_l            When a write occurs with this set low,
//                              the SDRAM's mode set register will be programmed
//                              with the data supplied on the data_bus[10:0].
//
//
//  Author:  Jeung Joon Lee  joon.lee@quantum.com,  cmosexod@ix.netcom.com
//  
//*******************************************************************************
//
//  Hierarchy:
//
//  SDRAM.V         Top Level Module
//  HOSTCONT.V      Controls the interfacing between the micro and the SDRAM
//  SDRAMCNT.V      This is the SDRAM controller.  All data passed to and from
//                  is with the HOSTCONT.
//  optional
//  MICRO.V         This is the built in SDRAM tester.  This module generates 
//                  a number of test logics which is used to test the SDRAM
//                  It is basically a Micro bus generator. 
//  
/*
*/ 

module hostcont (
                    // system connections
                    sys_rst_l,            
                    sys_clk,

                    // microprocessor side connections
                    mp_addx,
                    mp_data_in,
                    mp_data_out,
                    mp_rd_l,
                    mp_wr_l,
                    mp_cs_l,
                    sdram_mode_set_l,
                    sdram_busy_l,
                    mp_size,

                    // SDRAM side connections
                    sd_addx,
                    sd_data_out,
                    sd_data_in,
                    sd_ba,

                    // SDRAMCNT side
                    sd_addx10_mux,
                    sd_addx_mux,
                    sd_rd_ena,
                    do_read,
                    do_write,
                    doing_refresh,
                    do_modeset,
                    modereg_cas_latency,
                    modereg_burst_length,
                    mp_data_mux,
                    decoded_dqm,
                    do_write_ack,
                    do_read_ack,
                    do_modeset_ack,
                    pwrup,


                    // debug
//                    rd_wr_clk
                    reg_mp_data_mux,
                    reg_mp_addx,
                    reg_sd_data,
                    reg_modeset

             );


// ****************************************
//
//   I/O  DEFINITION
//
// ****************************************

// system connections
input           sys_rst_l;          // asynch active low reset
input           sys_clk;            // clock source to the SDRAM

// microprocessor side connections
input   [20:0]  mp_addx;         // ABW bits for the addx
input   [15:0]  mp_data_in;      // DBW bits of data bus input (see INC.H)
output  [15:0]  mp_data_out;     // DBW bits of data bus output (see INC.H)
input           mp_rd_l;            // micro bus read , active low
input           mp_wr_l;            // micro bus write, active low
input           mp_cs_l;
input           sdram_mode_set_l;   // acive low request for SDRAM mode set
output          sdram_busy_l;       // active low busy output
input   [1:0]   mp_size;

// SDRAM side connections
output  [10:0]  sd_addx;            // 11 bits of muxed SDRAM addx
input   [15:0]  sd_data_in;
output  [15:0]  sd_data_out;
output          sd_ba;              // bank select output to the SDRAM
input           pwrup;

// SDRAMCNT side
input   [1:0]   sd_addx10_mux;
input   [1:0]   sd_addx_mux;
input           sd_rd_ena;
output          do_write;
output          do_read;
input           doing_refresh;
output          do_modeset;
output  [2:0]   modereg_cas_latency;
output  [2:0]   modereg_burst_length;
input           mp_data_mux;
output  [1:0]   decoded_dqm;        // this is the decoded DQM according to the size. Used during writes
input           do_write_ack;       // acknowledge signal from sdramcont state machine
                                    // saying that it is now ok to clear 'do_write' signal
input           do_read_ack;        // acknowledge signal from sdramcont state machine
                                    // saying that is is now ok to clear 'do_read' signal
input           do_modeset_ack;


//debug
//output          rd_wr_clk;
output  [15:0]  reg_mp_data_mux;
output  [20:0]  reg_mp_addx;
output  [15:0]  reg_sd_data;
output  [10:0]  reg_modeset;

// ****************************************
//
// Memory Elements 
//
// ****************************************
//
wire    [20:0]  reg_mp_addx;
reg     [15:0]  reg_mp_data;
reg     [15:0]  reg_sd_data;
reg     [1:0]   decoded_dqm;
reg     [10:0]  reg_modeset; 
reg     [10:0]  sd_addx;
reg             do_read;
reg             do_write;
reg     [2:0]   do_state;
reg             do_modeset;
reg             sd_ba;
reg             busy_a_ena;

//wire  [31:0]  sd_data;
wire    [15:0]  sd_data_buff;
wire    [15:0]  reg_mp_data_mux;
reg     [15:0]  mp_data_out;
wire            busy_a;
wire            mp_data_ena;
wire            do_read_clk;
wire            do_read_rst_clk;
wire            do_write_clk;
wire            do_modeset_clk;
wire            do_modeset_rst_clk;
wire            clock_xx;
wire            modereg_ena;
wire            read_busy;
wire            write_busy;
wire            refresh_busy;
wire            modeset_busy;
wire            do_write_rst;
wire            do_read_rst;
wire            do_modeset_rst;
            

assign mp_data_ena  = ~mp_rd_l;
assign modereg_cas_latency  =  reg_modeset[6:4];
assign modereg_burst_length =  reg_modeset[2:0];

assign read_busy    = do_read  | (~mp_rd_l & busy_a_ena);
assign write_busy   = do_write | (~mp_wr_l & busy_a_ena);
assign modeset_busy = do_modeset;
assign refresh_busy = `LO; 

// SDRAM BUSY SIGNAL GENERATION
//
// The BUSY signal is NOR'd of READ_BUSY, WRITE_BUSY and DUMB_BUSY.
// READ_BUSY is generated while the SDRAM is performing a read.  This 
// does not necessarily have to he synchronous to the micro's read.  
// The WRITE_BUSY is generated while the SDRAM is performing WRITE.
// Again, due to the "dump-n-run" mode (only in SMART_H=1) the micro's
// write bus cycle does not necessarily align with SDRAM's write cycle.
// DUMB_BUSY is a signal which generates the BUSY at the falling edge of
// micro's SDRAM_CS.  This is used for those microprocessors which 
// require a device BUSY as soon as the address is placed on its bus.  For
// example, most Intel microcontrollers and small processors do have this
// requirement.  This means that one will fofeit on the dump-n-go feature.
// 
assign sdram_busy_l = ~(  read_busy                |
                          write_busy               | 
                         (doing_refresh & ~mp_cs_l)| 
                         (modeset_busy  & ~mp_cs_l) 
                       );


// MP ADDRESS LATCH
// Transparent latch
// Used to hold the addx from the micro. Latch on the falling edge of
// do_write.
// BAsed on the way "do_write" is generated, we only need to latch on the writes
// since the write can be queued, but since all reads are blocked, the latch
// will not latch the addx on reads.  
assign reg_mp_addx = mp_addx;


//
// DECODED DQM LATCH
// generate the proper DQM[3:0] or DQM[1:0] masks based on the address and on 
// the mp_size 
//
always @(do_write or sys_rst_l or mp_addx or mp_size)
    // 32 bit masks
    // all masks are enabled (LOW)
    if (mp_size==2'b00)
       decoded_dqm <= {2{1'b0}};
    // 16 bit masks
    // enable the masks accorsing to the half-word selected
    // FOR THE CASE OF 16 BIT BUS, THIS SELECTS UPPER/LOWER BYTES
/*
    else if (mp_size==2'b10)
       case (mp_addx[1])

          `LO:      decoded_dqm <= 4'b1100;     // lower half-word enabled
           default: decoded_dqm <= 4'b0011;     // upper half-word enabled

       endcase
*/
    // 8 bit masks
    // enablethe masks according to the byte specified.

    else if (mp_size==2'b01)
/*
       case (mp_addx[1:0])
       2'b00:   decoded_dqm <= 4'b1110;
       2'b01:   decoded_dqm <= 4'b1101;
       2'b10:   decoded_dqm <= 4'b1011;
       default: decoded_dqm <= 4'b0111;
       endcase
*/
       case (mp_addx[0])
          `LO:  decoded_dqm <= 2'b10;
          default: decoded_dqm <= 2'b01;
       endcase

    else
        decoded_dqm <= {2{1'bx}};


// MP DATA LATCH
// Used to hold the data from the micro.  Latch on the rising edge
// of mp_wr_l
//
`ifdef align_data_bus
always @(mp_data_in or reg_mp_addx)
    // 32 bit writes
    if (mp_size==2'b00)
       reg_mp_data <= mp_data_in;
    // 16 bit writes
/*
    else if (mp_size==2'b10) 
       case(reg_mp_addx[1]) 
            `LO: reg_mp_data[7:0] <= mp_data_in[7:0];
            default: reg_mp_data[15:0] <= mp_data_in[7:0];
       endcase
*/
    // 8 bit writes

    else if (mp_size==2'b01)
/*
       case(reg_mp_addx[1:0])
            2'b00:   reg_mp_data[7:0]   <= mp_data_in[7:0];
            2'b01:   reg_mp_data[15:8]  <= mp_data_in[7:0];
            2'b10:   reg_mp_data[23:16] <= mp_data_in[7:0];
            default: reg_mp_data[31:24] <= mp_data_in[7:0];
       endcase
*/
       case(reg_mp_addx[0]) 
            `LO: reg_mp_data[7:0] <= mp_data_in[7:0];
            default: reg_mp_data[15:0] <= mp_data_in[7:0];
       endcase


//---------------------------------- if data aligning is not desired -------------------
`else
always @(mp_data_in)
     reg_mp_data <= mp_data_in;
`endif


//
// MODE REG REG
//
`define default_mode_reg {4'b0000,`default_mode_reg_CAS_LATENCY,`defulat_mode_reg_BURST_TYPE,`default_mode_reg_BURST_LENGHT}
 always @(posedge sys_clk or negedge sys_rst_l)
    if (~sys_rst_l)
        reg_modeset <= 10'h000;
    else
    if (pwrup)
        reg_modeset <= `default_mode_reg;
    else 
    if (~sdram_mode_set_l & ~mp_cs_l & ~mp_wr_l)
        reg_modeset <= mp_data_in[10:0];

// SD DATA REGISTER
// This register holds in the data from the SDRAM
//
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
    reg_sd_data <= {16{1'b0}};
  else if (sd_rd_ena)
    reg_sd_data <= sd_data_buff;


//
// SD DATA BUS BUFFERS
//
assign sd_data_out  = reg_mp_data;
assign sd_data_buff = sd_data_in;



// SDRAM SIDE ADDX
always @(sd_addx10_mux or reg_mp_data or reg_mp_addx or reg_modeset)
  case (sd_addx10_mux)
/*
    2'b00:   sd_addx[10] <= reg_mp_addx[20];
    2'b01:   sd_addx[10] <= 1'b0;
    2'b10:   sd_addx[10] <= reg_modeset[10];
    default: sd_addx[10] <= 1'b1;
*/
    2'b00:   sd_addx[10] <= reg_mp_addx[19];
    2'b01:   sd_addx[10] <= 1'b0;
    2'b10:   sd_addx[10] <= reg_modeset[9];
    default: sd_addx[10] <= 1'b1;
  endcase

always @(sd_addx_mux or reg_modeset or reg_mp_addx)
  case (sd_addx_mux)
/*
    2'b00:   sd_addx[9:0] <= reg_mp_addx[19:10];               // ROW
    2'b01:   sd_addx[9:0] <= {2'b00, reg_mp_addx[9:2]};        // COLUMN
    2'b10:   sd_addx[9:0] <= reg_modeset[9:0];
    default: sd_addx[9:0] <= 10'h000;
*/
    2'b00:   sd_addx[9:0] <= reg_mp_addx[18:9];               // ROW
    2'b01:   sd_addx[9:0] <= {2'b00, reg_mp_addx[8:1]};        // COLUMN
    2'b10:   sd_addx[9:0] <= reg_modeset[9:0];
    default: sd_addx[9:0] <= {10{1'b0}};
  endcase


// SD_BA
always @(sd_addx_mux or reg_mp_addx)
  case (sd_addx_mux)
/*
    2'b00:    sd_ba <= reg_mp_addx[22:21];     
    2'b01:    sd_ba <= reg_mp_addx[22:21]; 
    default:  sd_ba <= 2'b00;
*/
    2'b00:    sd_ba <= reg_mp_addx[20];     
    2'b01:    sd_ba <= reg_mp_addx[20]; 
    default:  sd_ba <= 1'b0;
  endcase



// Micro data mux
assign reg_mp_data_mux = mp_data_mux ? {16{1'b0}} : reg_mp_data;

// MP_DATA_OUT mux
// ------------------------------- do this only if the DATA aligning is desired -------
`ifdef align_data_bus
always @(mp_size or reg_sd_data or mp_addx)
  case (mp_size)
     // 32 bit reads
     2'b00:  
         mp_data_out <= reg_sd_data;
     // 16 bit reads
//     2'b10:
     2'b01:
         if (mp_addx[0])
//            mp_data_out[15:0] <= reg_sd_data[31:16];
            mp_data_out[7:0] <= reg_sd_data[15:8];
         else
//            mp_data_out[15:0] <= reg_sd_data[15:0];
            mp_data_out[7:0] <= reg_sd_data[7:0];
     // 8 bit reads
     default:
/*
         case (mp_addx[1:0])
             2'b00:   mp_data_out[7:0] <= reg_sd_data[7:0];
             2'b01:   mp_data_out[7:0] <= reg_sd_data[15:0];
             2'b10:   mp_data_out[7:0] <= reg_sd_data[23:16];
             default: mp_data_out[7:0] <= reg_sd_data[31:24];
*/ 
       mp_data_out <= {16{1'bx}};
        endcase
  endcase       
`else
//---------------------------------- if data aligning is not desired -------------------
always @(reg_sd_data)
  mp_data_out <= reg_sd_data;
`endif

//
// DO_READ   DO_WRITE   DO_MODESET
// signal generation
//

always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin
    do_read  <= `LO;
    do_write <= `LO;
    do_modeset <= `LO;
    do_state <= 3'b000;
    busy_a_ena <= `HI; 
  end
  else 
    case (do_state)
        // hang in here until a read or write is requested 
        // (mp_rd_l = 1'b0) or (mp_wr_l = 1'b0)
        3'b000: begin
            // a read request
            if (~mp_rd_l & ~mp_cs_l) begin          
                do_read <= `HI;
                do_state <= 3'b001;
            end
            // a write request
            else if (~mp_wr_l & ~mp_cs_l & sdram_mode_set_l) begin
                do_write <= `HI;
                do_state <= 3'b001;
            end
            // a mode set request
            else if (~mp_wr_l & ~mp_cs_l & ~sdram_mode_set_l) begin
                do_modeset <= `HI;
                do_state <= 3'b001;
            end
            else
                do_state <= 3'b000;         
        end
        
        // This cycle is dummy cycle.  Just to extend 'busy_ena_a' 
        // to a total of 2 cycles 
        3'b001:
            begin
                busy_a_ena <= `LO;      // disable busy_a generation
                if (do_write)
                   do_state <= 3'b011;
                else if (do_read)
                   do_state <= 3'b010;
                else if (do_modeset)
                   do_state <= 3'b110;
                else 
                   do_state <= 3'b001;
            end

        // hang in here until the sdramcnt has acknowledged the
        // read
        3'b010:
            if (do_read_ack) begin
                do_read <= `LO;
                do_state <= 3'b100;
            end
            else
                do_state <= 3'b010;

        // hang in here until the sdramcnt has acknowledged the 
        // write
        3'b011:
            if (do_write_ack) begin
                do_write <= `LO;
                do_state <= 3'b101;
            end
            else
                do_state <= 3'b011;

        // wait in here until the host has read the data
        // (i.e. has raised its mp_rd_l high)
        3'b100:
            if (mp_rd_l) begin
                busy_a_ena <= `HI;      // re-enable busy_a generation
                do_state <= 3'b000;
            end
            else
                do_state <= 3'b100;
                
        // wait in here until the host has relinquieshed the write bus
        // (i.e. has raised its mp_wr_l high)
        3'b101:
            if (mp_wr_l) begin
                busy_a_ena <= `HI;      // re-enable busy_a generation
                do_state <= 3'b000;
            end
            else
                do_state <= 3'b101;

        // hang in here until the sdramcnt has acknowledged the 
        // mode set
        3'b110:
            if (do_modeset_ack) begin
                do_modeset <= `LO;
                do_state <= 3'b101;
            end else
                do_state <= 3'b110;


    endcase
                



endmodule

