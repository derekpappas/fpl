/*******************************************************************************************************************************
**
**    Copyright © 1998..2002 Advanced Architectures
**
**    All rights reserved
**    Confidential Information
**    Limited Distribution to Authorized Persons Only
**    Created and Protected as an Unpublished Work under the U.S. Copyright act of 1976.
**
**    Project Name       : A2-Register Bus
**    Module Name        : A2-Register Bus TEST BENCH
**
**    Author             : RTT
**    Creation Date      : 2001/08/15
**    Description        : TEST BENCH -- 4 Master/Slaves, 1 Slave & 1 Sample Slave device
**                                       2 on a parallel segment and 2 on a serial segment
**
**    $Revision: 1.0 $
**    $Date: 2002-05-13 09:16:22-07 $
**    $ID: $
**
********************************************************************************************************************************
**    THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
**    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
**    BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
**    TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
**    AND ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
**    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*******************************************************************************************************************************/

`timescale 1ns/100ps
`define    tick 10
`define    tSU   1

`include "A2_common.cfg"
`include "A2R_common.cfg"

`define   A2R_EXTENSION_RETRY

module t
 #(
 `include "A2R_parameters.vh"
 );

parameter   DEBUG =  1;

reg         clock;
reg         reset;

reg  [A2R_width-1       :0]   m0_ad;
reg                           m0_read;
reg  [A2R_width-1       :0]   m0_wd;
reg                           m0_write;
wire                          m0_ready;
wire [A2R_width-1       :0]   m0_rd;

reg  [A2R_width-1       :0]   m1_ad;
reg                           m1_read;
reg  [A2R_width-1       :0]   m1_wd;
reg                           m1_write;
wire                          m1_ready;
wire [A2R_width-1       :0]   m1_rd;

reg  [A2R_width-1       :0]   m2_ad;
reg                           m2_read;
reg  [A2R_width-1       :0]   m2_wd;
reg                           m2_write;
wire                          m2_ready;
wire [A2R_width-1       :0]   m2_rd;

reg  [A2R_width-1       :0]   m3_ad;
reg                           m3_read;
reg  [A2R_width-1       :0]   m3_wd;
reg                           m3_write;
wire                          m3_ready;
wire [A2R_width-1       :0]   m3_rd;

wire [A2R_width-1       :0]   s0_rd;
wire                          s0_ready;
wire                          s0_retry;
wire                          s0_error;
wire [A2R_width-1       :0]   s0_ad;
wire                          s0_read;
wire [A2R_width-1       :0]   s0_wd;
wire                          s0_write;

wire [A2R_width-1       :0]   s1_rd;
wire                          s1_ready;
wire                          s1_error;
wire                          s1_retry;
wire [A2R_width-1       :0]   s1_ad;
wire                          s1_read;
wire [A2R_width-1       :0]   s1_wd;
wire                          s1_write;

wire [A2R_width-1       :0]   s2_rd;
wire                          s2_ready;
wire                          s2_retry;
wire                          s2_error;
wire [A2R_width-1       :0]   s2_ad;
wire                          s2_read;
wire [A2R_width-1       :0]   s2_wd;
wire                          s2_write;

wire [A2R_width-1       :0]   s3_rd;
wire                          s3_ready;
wire                          s3_retry;
wire                          s3_error;
wire [A2R_width-1       :0]   s3_ad;
wire                          s3_read;
wire [A2R_width-1       :0]   s3_wd;
wire                          s3_write;

reg         pe4;
reg         pe3;
reg         pe2;
reg         pe1;
reg         pe0;


reg  [A2R_width-1 :0]   s0_ram[0:255];
reg  [A2R_width-1 :0]   s1_ram[0:255];
reg  [A2R_width-1 :0]   s2_ram[0:255];
reg  [A2R_width-1 :0]   s3_ram[0:255];
reg  [A2R_width-1 :0]   s4_ram[0:255];

reg  [31-1 :0]   counter;
reg  [31-1 :0]   breakpoint;

wire        delayed_clock;
wire        setup_window;

a2r_hier_top  m (
    .clock(clock),
    .reset(reset),
    .pe4(pe4),
    .pe3(pe3),
    .pe2(pe2),
    .pe1(pe1),
    .pe0(pe0),

    .m0_ad(m0_ad),     .m0_wd(m0_wd),       .m0_rd(m0_rd),
    .m1_ad(m1_ad),     .m1_wd(m1_wd),       .m1_rd(m1_rd),
    .m2_ad(m2_ad),     .m2_wd(m2_wd),       .m2_rd(m2_rd),
    .m3_ad(m3_ad),     .m3_wd(m3_wd),       .m3_rd(m3_rd),

    .m0_read(m0_read), .m0_write(m0_write), .m0_ready(m0_ready), .m0_error(m0_error),
    .m1_read(m1_read), .m1_write(m1_write), .m1_ready(m1_ready), .m1_error(m1_error),
    .m2_read(m2_read), .m2_write(m2_write), .m2_ready(m2_ready), .m2_error(m2_error),
    .m3_read(m3_read), .m3_write(m3_write), .m3_ready(m3_ready), .m3_error(m3_error),

`ifdef A2R_EXTENSION_RETRY
    .s0_retry(s0_retry),
    .s1_retry(s1_retry),
    .s2_retry(s2_retry),
    .s3_retry(s3_retry),
`endif

    .s0_ad(s0_ad),     .s0_wd(s0_wd),       .s0_rd(s0_rd),
    .s1_ad(s1_ad),     .s1_wd(s1_wd),       .s1_rd(s1_rd),
    .s2_ad(s2_ad),     .s2_wd(s2_wd),       .s2_rd(s2_rd),
    .s3_ad(s3_ad),     .s3_wd(s3_wd),       .s3_rd(s3_rd),

    .s0_read(s0_read), .s0_write(s0_write), .s0_ready(s0_ready), .s0_error(s0_error),
    .s1_read(s1_read), .s1_write(s1_write), .s1_ready(s1_ready), .s1_error(s1_error),
    .s2_read(s2_read), .s2_write(s2_write), .s2_ready(s2_ready), .s2_error(s2_error),
    .s3_read(s3_read), .s3_write(s3_write), .s3_ready(s3_ready), .s3_error(s3_error)
    );


// SET PIPELINING ==============================================================================================================

initial begin
   pe4         =  A2R_pipe_settings[4];
   pe3         =  A2R_pipe_settings[3];
   pe2         =  A2R_pipe_settings[2];
   pe1         =  A2R_pipe_settings[1];
   pe0         =  A2R_pipe_settings[0];
   end

// GENERATE CLOCK ==============================================================================================================

initial begin
   clock     = 0;
   counter   = 0;
   forever begin
      #(`tick/2); clock = 0;
      #(`tick/2); clock = 1;
      end
   end  //

assign   #((`tick/2)-`tSU)  delayed_clock  = ~clock;
assign                      setup_window   = delayed_clock & ~clock;

always @(`ACTIVE_EDGE clock) counter = counter + 1;

// MANAGE SLAVE MEMORIES =======================================================================================================

always @(`ACTIVE_EDGE clock) begin
   if (s0_write) s0_ram[s0_ad[7:0]] <=  s0_wd[A2R_width-1 :0];
   if (s1_write) s1_ram[s1_ad[7:0]] <=  s1_wd[A2R_width-1 :0];
   if (s2_write) s2_ram[s2_ad[7:0]] <=  s2_wd[A2R_width-1 :0];
   if (s3_write) s3_ram[s3_ad[7:0]] <=  32'hEEEEEEEE;   // s2_wd[A2R_width-1 :0] ^ 32'h5555_5555;  // Inject errors
   end

assign   s0_rd    = s0_ram[s0_ad[7:0]];
assign   s1_rd    = s1_ram[s1_ad[7:0]];
assign   s2_rd    = s2_ram[s2_ad[7:0]];
assign   s3_rd    = s3_ram[s3_ad[7:0]];

assign   s0_ready = s0_read | s0_write;
assign   s1_ready = s1_read | s1_write;
assign   s2_ready = s2_read | s2_write;
assign   s3_ready = s3_read | s3_write;

assign   s0_retry = FALSE;
assign   s1_retry = FALSE;
assign   s2_retry = FALSE;
assign   s3_retry = FALSE;

assign   s0_error = FALSE;
assign   s1_error = FALSE;
assign   s2_error = FALSE;
assign   s3_error = s3_read | s3_write;  // All accesses to slave 3 return an error

// TESTS =======================================================================================================================

initial begin
               reset       = `reset_OFF;
               breakpoint  =  32'h0000_1200;
   #(`tick/3)  reset       = `reset_ON;
   #(`tick*30) reset       = `reset_OFF;
   end

// MASTER 0 ------------------------------------------------------------------
initial begin
               m0_ad    =  0;
               m0_wd    =  0;
               m0_write =  FALSE;
               m0_read  =  FALSE;
   wait(reset == `reset_ON);
   wait(reset == `reset_OFF);
   repeat (18) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h1200_0034, 32'h5555_5555);
   write_m0 ( 32'h1300_0000, 32'haaaa_aaaa);
   read_m0  ( 32'h1200_0034, 32'h5555_5555);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h0000_00ff, 32'hffff_ffff);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h0100_00ff, 32'hffff_ffff);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h1200_00ff, 32'hffff_ffff);
   repeat (5) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h1300_00ff, 32'hffff_ffff);
   repeat (5) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h1400_0000, 32'hffff_ffff);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m0  ( 32'h0000_00ff, 32'hffff_ffff);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m0  ( 32'h0100_00ff, 32'hffff_ffff);
   repeat (7) @(`ACTIVE_EDGE clock);
   read_m0  ( 32'h1200_00ff, 32'hffff_ffff);
   repeat (3) @(`ACTIVE_EDGE clock);
   read_m0  ( 32'h1300_00ff, 32'hffff_ffff);
   repeat (3) @(`ACTIVE_EDGE clock);
   read_m0  ( 32'h1400_0000, 32'hffff_ffff);
   // Sync up all masters for all at once test!
   wait (counter == breakpoint);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m0 ( 32'h1200_0000, 32'h8888_8888);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m0  ( 32'h1200_0000, 32'h8888_8888);

   repeat (400) @(`ACTIVE_EDGE clock);
   $display("\n\n\n\n All Tests Completed\n\n\n\n");
   $stop;
   $finish;
   end

// MASTER 1 ------------------------------------------------------------------
initial begin
               m1_ad    =  0;
               m1_wd    =  0;
               m1_write =  FALSE;
               m1_read  =  FALSE;
   wait(reset == `reset_ON);
   wait(reset == `reset_OFF);
   repeat (18) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h1200_1070, 32'h5a5a_5a5a);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h1200_1070, 32'h5a5a_5a5a);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h1300_1071, 32'h1234_5678);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h1300_1071, 32'h1234_5678);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h1400_0001, 32'h4444_5678);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h1400_1111, 32'h4444_5678);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h1200_1072, 32'h8765_4321);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h1200_1072, 32'h8765_4321);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h0100_1073, 32'h0102_0304);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h0100_1073, 32'h0102_0304);
   repeat (8) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h0000_1074, 32'ha5a5_a5a5);
   repeat (2) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h0000_1074, 32'ha5a5_a5a5);
   // Sync up all masters for all at once test!
   wait (counter == breakpoint);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m1 ( 32'h1200_1001, 32'h7777_7777);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m1  ( 32'h1200_1001, 32'h7777_7777);
   end

// MASTER 2 ------------------------------------------------------------------
initial begin
               m2_ad    =  0;
               m2_wd    =  0;
               m2_write =  FALSE;
               m2_read  =  FALSE;
   wait(reset == `reset_ON);
   wait(reset == `reset_OFF);
   repeat (18) @(`ACTIVE_EDGE clock);
   write_m2 ( 32'h0100_2030, 32'haaaa_5555);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m2 ( 32'h1200_2030, 32'h5555_aaaa);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m2  ( 32'h0100_2030, 32'haaaa_5555);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m2  ( 32'h1200_2030, 32'h5555_aaaa);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m2 ( 32'h0000_2031, 32'h7654_3210);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m2  ( 32'h0000_2031, 32'h7654_3210);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m2 ( 32'h1300_2031, 32'h0123_4567);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m2  ( 32'h1300_2031, 32'h0123_4567);
   // Sync up all masters for all at once test!
   wait (counter == breakpoint);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m2 ( 32'h1200_2002, 32'h6666_6666);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m2  ( 32'h1200_2002, 32'h6666_6666);
   end

// MASTER 3 ------------------------------------------------------------------
initial begin
               m3_ad    =  0;
               m3_wd    =  0;
               m3_write =  FALSE;
               m3_read  =  FALSE;
   wait(reset == `reset_ON);
   wait(reset == `reset_OFF);
   repeat (18) @(`ACTIVE_EDGE clock);
   write_m3 ( 32'h0000_3010, 32'ha5a5_a5a5);
   read_m3  ( 32'h0000_3010, 32'ha5a5_a5a5);
   write_m3 ( 32'h1400_3333, 32'haa55_aa55);
   read_m3  ( 32'h1400_0003, 32'haa55_aa55);
   // Sync up all masters for all at once test!
   wait (counter == breakpoint);
   repeat (1) @(`ACTIVE_EDGE clock);
   write_m3 ( 32'h1300_0003, 32'h5555_5555);
   repeat (1) @(`ACTIVE_EDGE clock);
   read_m3  ( 32'h1300_0003, 32'h5555_5555);
   end

///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////


task  write_m0;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   write_data;
   begin
   #2          m0_ad    =  address;
               m0_wd    =  write_data;
               m0_write =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m0_ready || m0_error));
   if (address[31:24] != 8'h13 && m0_error)
      $display("\n%d ERROR  A2R Master 0 Error Response from address %h during write of %h\n",$time, address,write_data);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 0 write to address %h of %h",$time, address, write_data);
   @(`ACTIVE_EDGE clock);
   #2          m0_ad    =  32'h 0;
               m0_wd    =  32'h 0;
               m0_write =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task  write_m1;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   write_data;
   begin
   #2          m1_ad    =  address;
               m1_wd    =  write_data;
               m1_write =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m1_ready || m1_error));
   if (address[31:24] != 8'h13 && m1_error)
      $display("\n%d ERROR  A2R Master 1 Error Response from address %h during write of %h\n",$time, address,write_data);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 1 write to address %h of %h",$time, address, write_data);
   @(`ACTIVE_EDGE clock);
   #2          m1_ad    =  32'h 0;
               m1_wd    =  32'h 0;
               m1_write =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task  write_m2;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   write_data;
   begin
   #2          m2_ad    =  address;
               m2_wd    =  write_data;
               m2_write =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m2_ready || m2_error));
   if (address[31:24] != 8'h13 && m2_error)
      $display("\n%d ERROR  A2R Master 2 Error Response from address %h during write of %h\n",$time, address,write_data);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 2 write to address %h of %h",$time, address, write_data);
   @(`ACTIVE_EDGE clock);
   #2          m2_ad    =  32'h 0;
               m2_wd    =  32'h 0;
               m2_write =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task  write_m3;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   write_data;
   begin
   #2          m3_ad    =  address;
               m3_wd    =  write_data;
               m3_write =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m3_ready || m3_error));
   if (address[31:24] != 8'h13 && m3_error)
      $display("\n%d ERROR  A2R Master 3 Error Response from address %h during write of %h\n",$time, address,write_data);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 3 write to address %h of %h",$time, address, write_data);
   @(`ACTIVE_EDGE clock);
   #2          m3_ad    =  32'h 0;
               m3_wd    =  32'h 0;
               m3_write =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task read_m0;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   expecting;
   begin
   #2          m0_ad    =  address;
               m0_read  =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m0_ready || m0_error));
   if (address[31:24] != 8'h13 && (m0_rd !== expecting || m0_error))
      $display("\n%d ERROR  A2R Master 0 rxd %h expecting %h at address %h\n",$time, m0_rd, expecting,address);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 0 read from addrss %h of %h",$time, address, m0_rd);
   @(`ACTIVE_EDGE clock);
   #2          m0_ad    =  32'h 0;
               m0_read  =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task read_m1;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   expecting;
   begin
   #2          m1_ad    =  address;
               m1_read  =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m1_ready || m1_error));
   if (address[31:24] != 8'h13 && (m1_rd !== expecting || m1_error))
      $display("\n%d ERROR  A2R Master 1 rxd %h expecting %h at address %h\n",$time, m1_rd, expecting,address);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 1 read from addrss %h of %h",$time, address, m1_rd);
   @(`ACTIVE_EDGE clock);
   #2          m1_ad    =  32'h 0;
               m1_read  =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task read_m2;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   expecting;
   begin
   #2          m2_ad    =  address;
               m2_read  =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m2_ready || m2_error));
   if (address[31:24] != 8'h13 && (m2_rd !== expecting || m2_error))
      $display("\n%d ERROR  A2R Master 2 rxd %h expecting %h at address %h\n",$time, m2_rd, expecting,address);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 2 read from addrss %h of %h",$time, address, m2_rd);
   @(`ACTIVE_EDGE clock);
   #2          m2_ad    =  32'h 0;
               m2_read  =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask

task read_m3;
input [A2R_width-1 :0]   address;
input [A2R_width-1 :0]   expecting;
   begin
   #2          m3_ad    =  address;
               m3_read  =  TRUE;
   @(`ACTIVE_EDGE clock);
   wait(setup_window && (m3_ready || m3_error));
   if (address[31:24] != 8'h13 && (m3_rd !== expecting || m3_error))
      $display("\n%d ERROR  A2R Master 3 rxd %h expecting %h at address %h\n",$time, m3_rd, expecting,address);
   else if (DEBUG)
      $display("%d ACCESS A2R Master 3 read from addrss %h of %h",$time, address, m3_rd);
   @(`ACTIVE_EDGE clock);
   #2          m3_ad    =  32'h 0;
               m3_read  =  FALSE;
   repeat (4) @(`ACTIVE_EDGE clock);
   end
endtask


endmodule // t
