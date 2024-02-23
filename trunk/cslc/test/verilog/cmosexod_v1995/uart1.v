// *********************************************
//
// UART.v
//
// www.cmosexod.com
// 8/27/2001 (c) 2001
// Jeung Joon Lee
// 
// Universal Asyhnchronous Receiver, Transmitter
// This is a reduced version of the UART.
// It is fully functional, synthesizable, ideal
// for embedded system.
//
// Update Log:
// 8/10/01  Added the microprocessor interface
//          module
// 7/30/01  The 'bitCell_cntrH' compare in r_WAIT 
//          state of u_rec.v has been changed from
//          the incorrect F to E.
//          The 'bitCell_cntrH' compare in x_WAIT 
//          state of u_xmit.v has been changed from
//          the incorrect F to E.
// 
//
//
// *********************************************
module uart	(	
            // system interface
				sys_rst_l,
				sys_clk,
				uart_clk,

			// micro processor conenction
                mp_clk,
                mp_cs_l,
                mp_addx,
                mp_data_to_uart,
                mp_data_from_uart,
                mp_rd_l,
                mp_wr_l,
                mp_int_l,

            // to from RS-232 UART driver
				uart_XMIT_dataH,
				uart_REC_dataH,

            // debug
                stat_rec_dataH,
                stat_xmit_emptyH

			);


`include "uart_inc.h"				

// system interface
input			sys_rst_l;
input			sys_clk;
output			uart_clk;

// microprocessor connection
input           mp_clk;
input           mp_cs_l;
input	[2:0]   mp_addx;
input	[7:0]   mp_data_to_uart;
output	[7:0]   mp_data_from_uart;
input           mp_rd_l;
input           mp_wr_l;
output          mp_int_l;

// to from RS-232 UART driver
output			uart_XMIT_dataH;
input           uart_REC_dataH;

// debug
output          stat_rec_dataH;
output          stat_xmit_emptyH;


wire 			uart_clk;
wire	[15:0]	baud_rate_div;
wire			xmit_start_pulseH;
wire			xmit_doneH;
wire	[7:0]	reg_xmit_dat;
wire            xmit_busyH;
wire	[7:0]	rec_dataH;
wire			rec_readyH;

// debug
wire            stat_rec_dataH;
wire            stat_xmit_emptyH;



// Instantiate the Microprocessor Interface
mp_int iMP_INT (
			// system connection
			.sys_rst_l(sys_rst_l),
            .uart_clk(uart_clk),
			.mp_clk(mp_clk),

			// micro processor conenction
			.mp_cs_l(mp_cs_l),
			.mp_addx(mp_addx),
			.mp_data_from_uart(mp_data_from_uart),
			.mp_data_to_uart(mp_data_to_uart),
			.mp_rd_l(mp_rd_l),
			.mp_wr_l(mp_wr_l),
            .mp_int_l(mp_int_l),

			// to / from internal modules
			.baud_rate_div(baud_rate_div),

            // from uart XMITTER
            .start_pulseH(xmit_start_pulseH),
            .xmit_doneH(xmit_doneH),
			.reg_xmit_dat(reg_xmit_dat),
			.xmit_busyH(xmit_bustH),

            // uart RECEIVER
            .rec_dataH(rec_dataH),
            .rec_readyH(rec_readyH),

            // debug
            .stat_rec_dataH(stat_rec_dataH),
            .stat_xmit_emptyH(stat_xmit_emptyH)

			);



// Instantiate the Transmitter
u_xmit  iXMIT(  .sys_clk(uart_clk),
				.sys_rst_l(sys_rst_l),

				.uart_xmitH(uart_XMIT_dataH),
				.xmitH(xmit_start_pulseH),
				.xmit_dataH(reg_xmit_dat),
				.xmit_doneH(xmit_doneH)
			);


// Instantiate the Receiver


u_rec iRECEIVER (// system connections
				.sys_rst_l(sys_rst_l),
				.sys_clk(uart_clk),

				// uart
				.uart_dataH(uart_REC_dataH),

				.rec_dataH(rec_dataH),
				.rec_readyH(rec_readyH)

				);


// Instantiate the Baud Rate Generator

baud iBAUD(	.sys_clk(sys_clk),
			.sys_rst_l(sys_rst_l),		
			.baud_clk(uart_clk),
            .baud_rate_div(baud_rate_div)
		);



endmodule
