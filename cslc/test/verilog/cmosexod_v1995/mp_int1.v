
//
// MP_INT.v
//
// Microprocessor Interface module
// This module provides the interface between
// the uart receiver and transmitter and the 
// the microprocessor bus
//
// log:
// 8/7/01  Added more registers
//

module mp_int (
			// system connection
			sys_rst_l,
            uart_clk,
			mp_clk,

			// micro processor conenction
			mp_cs_l,
			mp_addx,
			mp_data_to_uart,
			mp_data_from_uart,
			mp_rd_l,
			mp_wr_l,
            mp_int_l,

			// to / from internal modules
			baud_rate_div,

            // from uart XMITTER
            start_pulseH,
            xmit_doneH,
			reg_xmit_dat,
			xmit_busyH,

            // uart RECEIVER
            rec_dataH,
            rec_readyH

            ,
            xmit_busy_rstH,
            stat_xmit_emptyH,
            stat_rec_dataH,
            wr_done_pulseH,
            sel_xmit_datH
			);

`include "uart_inc.h"

// 
// Register Map
//
// Address  Mode  Name             Desc
// 000      W     XMIT_DAT_REG     When data is written to this reg,
// 000      R     REC_DAT_REG
// 001      R/W   BAUD_REG_LO
// 010      R/W   BAUD_REG_HI
// 011      R     STAT_REG         0 = Xmit Busy. 
//                                     Set when new data is written to the
//                                     transmit data register.  Cleared when
//                                     transmitter is done transmitting.  
//                                 1 = Rec Data Available. Set when new data is 
//                                     received from receiver. Cleared when MP
//                                     reads from the read register 
//                                 2 =
//                                 3 =
//                                 4 =
//                                 5 =
//                                 6 =
//                                 7 =
// 100      R/W   INT_STAT_REG     Interrupt status register
//                                 Write 1 to clear the specific bits
//                                 0 =
//                                 1 =
//                                 2 =
//                                 3 =
//                                 4 =
//                                 5 =
//                                 6 =
//                                 7 =
// 101      R/W   INT_ENA_REG      Interrupt enable register
//

input			sys_rst_l;
input			mp_clk;
input           uart_clk;
input			mp_cs_l;
input	[2:0]	mp_addx;
input			mp_rd_l;
input			mp_wr_l;
input	[7:0]	mp_data_to_uart;
output	[7:0]	mp_data_from_uart;
output	[15:0]	baud_rate_div;
output          start_pulseH;
input           xmit_doneH;
output          xmit_busyH;
output  [7:0]   reg_xmit_dat;
input   [7:0]   rec_dataH;
input           rec_readyH;
output          mp_int_l;

//debug
output          xmit_busy_rstH;
output          stat_xmit_emptyH;
output          stat_rec_dataH;
output          wr_done_pulseH;
output          sel_xmit_datH;


reg		[7:0]	reg_baud_rate_div_lo_in;
reg		[7:0]	reg_baud_rate_div_hi;
reg     [7:0]   reg_baud_rate_div_lo;
reg		[7:0]	reg_xmit_dat;
reg     [7:0]   reg_int_ena;
reg             xmit_busyH;
reg             xmit_busy_rstH;
reg     [7:0]   mp_data_out;
reg             stat_rec_dataH;
reg             stat_xmit_emptyH;
reg             rec_new_dataH;

wire	[7:0]	mp_data;
wire			sel_baud_regLoH;
wire			sel_baud_regHiH;
wire 			sel_xmit_datH;
wire            sel_int_maskH;
wire            wr_done_pulseH;
wire            xmit_busyH_sync;
wire			start_pulseH;
wire            xmit_doneH_sync;
wire	[15:0]	baud_rate_div;
wire            xmit_busy_rstL;
wire            mp_data_out_enaH;
wire            rec_readyH_sync;
wire            rec_ready_pulseH;
wire            sel_int_stat_regH;

assign mp_data           = mp_data_to_uart;
assign mp_data_from_uart = mp_data_out;

assign baud_rate_div = {reg_baud_rate_div_hi,reg_baud_rate_div_lo}; 

assign sel_baud_regLoH = ~mp_cs_l & (mp_addx == SEL_BAUD_REG_LO);
assign sel_baud_regHiH = ~mp_cs_l & (mp_addx == SEL_BAUD_REG_HI);
assign sel_xmit_datH   = ~mp_cs_l & (mp_addx == SEL_XMIT_DAT);
assign sel_int_maskH   = ~mp_cs_l & (mp_addx == SEL_INT_ENA_REG);
assign sel_int_stat_regH  = ~mp_cs_l & (mp_addx == SEL_INT_STAT_REG);

//
// Register File
// Accessible by the host micro
//
always @(posedge mp_clk or negedge sys_rst_l)
 if (~sys_rst_l) begin
   reg_baud_rate_div_lo <= 0;
   reg_baud_rate_div_hi <= 0;   
   reg_xmit_dat         <= 0;
   reg_int_ena         <= 0;
 end else begin
   if (~mp_wr_l) begin
     if (sel_baud_regLoH) reg_baud_rate_div_lo_in <= mp_data;
     if (sel_baud_regHiH) begin
           reg_baud_rate_div_hi <= mp_data;
           reg_baud_rate_div_lo <= reg_baud_rate_div_lo_in;
     end
     if (sel_xmit_datH)   reg_xmit_dat  <= mp_data;
     if (sel_int_maskH)   reg_int_ena   <= mp_data;   
   end
 end


// output mux
always @(mp_addx or rec_dataH or reg_baud_rate_div_lo or 
         reg_baud_rate_div_lo or stat_rec_dataH or stat_xmit_emptyH or 
         reg_int_ena )
begin
  case (mp_addx)
    SEL_REC_DAT:     mp_data_out = rec_dataH;
    SEL_BAUD_REG_LO: mp_data_out = reg_baud_rate_div_lo;
    SEL_BAUD_REG_HI: mp_data_out = reg_baud_rate_div_hi;
    SEL_STAT_REG:    mp_data_out = {rec_new_dataH,xmit_busyH};
    SEL_INT_STAT_REG:mp_data_out = {stat_rec_dataH,stat_xmit_emptyH};
    SEL_INT_ENA_REG: mp_data_out = reg_int_ena;
    default:         mp_data_out = 8'hxx;
  endcase

end

// Interrupt generation
//
// Interrupt is generated only if the 
// associated status signal is on and the enable bit is 
// set.  Once the interrupt is generated, it can only
// be cleared if all of the status bits (anded with its enable) 
// are cleared 
//
assign mp_int_l= ~( ( stat_xmit_emptyH & reg_int_ena[0] ) |
                    ( stat_rec_dataH   & reg_int_ena[1] )   );


// rec_new_dataH bit generation
// this is a bit which is set whenever a 
// new data has been received from the UART receiver
// it is clered when the host reads from the 
// read data register.
// Note that this is different from the stat_rec_dataH 
// which is set when thre is a new read data, and cleared
// by the host.
always @(posedge mp_clk or negedge sys_rst_l)
  if (~sys_rst_l) rec_new_dataH <= 0;
  else if (rec_ready_pulseH)        rec_new_dataH <= 1'b1;
  else if (sel_xmit_datH & mp_rd_l) rec_new_dataH <= 1'b0;
  

// Status register
always @(posedge mp_clk or negedge sys_rst_l)
  if (~sys_rst_l)  begin
     stat_rec_dataH   <= 1'b0;
     stat_xmit_emptyH  <= 1'b1;  // by default there is no data
  end else begin
     // the xmit_empty is set when the UART transmitter has
     // finished transmitting data.  It is cleared by the
     // micro
     if (sel_int_stat_regH & ~mp_wr_l) stat_xmit_emptyH <= mp_data[0];
     // set the flag, when the UART xmit is done
     else if (xmit_busy_rstH) stat_xmit_emptyH <= 1'b1;
     // cleared when a new data is sent to the UART
     else if (sel_xmit_datH & ~mp_wr_l) stat_xmit_emptyH <= 0;

     // the stat_rec_dataH is set whenever a new data is received
     // from the UART receiver.  It is cleared by the MP     
     if (sel_int_stat_regH & ~mp_wr_l) stat_rec_dataH <= mp_data[1];
     else if (rec_ready_pulseH) stat_rec_dataH <= 1'b1;

  end


assign xmit_busy_rstL = ~xmit_busy_rstH;

// instantiate a one-shot 
one_shot OS_WR (.clk_in(mp_clk), 
                .d(mp_wr_l),
                .q(wr_done_pulseH) );

// generate xmit_busyH
// this 'xmit_busyH' is set whenever a write to
// the xmit regiter is made.  It is then cleared when
// the uart trasmitter has finished its transmission
wire rst = sys_rst_l & xmit_busy_rstL;
always @(posedge mp_clk or negedge xmit_busy_rstL)
  if (~xmit_busy_rstL) xmit_busyH <= 0;
  else if (wr_done_pulseH & sel_xmit_datH)
     xmit_busyH <= 1;

// synchronizer
sync SYNC_WR (.clk_in(uart_clk),
              .sys_rst_l(xmit_busy_rstL),
              .d(xmit_busyH),
              .q(xmit_busyH_sync) );

// one - shot 
one_shot OS_WR2 (.clk_in(uart_clk),
                 .sys_rst_l(sys_rst_l),
                 .d(xmit_busyH_sync),
                 .q(start_pulseH) );


// ----
// 
sync SYNC_WR2 (.clk_in(mp_clk),
               .sys_rst_l(sys_rst_l),
               .d(xmit_doneH),
               .q(xmit_doneH_sync) );
               
// one shot 
one_shot OS_WR3 (.clk_in(mp_clk),
                 .sys_rst_l(sys_rst_l),
                 .d(xmit_doneH_sync),
                 .q(xmit_busy_rstH) );


//
// Synchronizer  and one shot for RECEIVE DATA READY signal
//

// dual rank synchronizer
sync SYNC_RECDAT (.clk_in(mp_clk),
                  .sys_rst_l(sys_rst_l),
                  .d(rec_readyH),
                  .q(rec_readyH_sync) );

// one shot
one_shot OS_RECDAT (.clk_in(mp_clk),
                    .sys_rst_l(sys_rst_l),
                    .d(rec_readyH_sync),
                    .q(rec_ready_pulseH) );

endmodule
