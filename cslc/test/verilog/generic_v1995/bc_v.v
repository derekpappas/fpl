
/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      bc_v.v 
*  Date:           Aug. 8th, 1999
*  Author:         Walter Li
*  Function:       Board Controller (Top Level)
*  Change History: 09/09/99, WL, 1) removed powerspan configuration control
								 2)	had RSV[5:0] drive LEDs
				   15/02/00, WL, Changed out[0:15] internal active level
								 For inner register, "0" means inactive or 
								 disable, "1" means active or enable. However,
								 for physical signal, "Hi" means inactive or
								 disable, "Lo" means active or enable. So, CPLD
								 internally handles the logic inversion.
******************************************************************************/
// Top level for board controller
 // Include files
	`include "registers.v"
	`include "drivers.v"
	`include "local_reset.v"
	`include "decoder.v"
	
module bc_v ( ADDR, BC_CS_, OE_, WE_, IN, ABORT, H_RST, S_RST, SRST_740_DIS, HRST_740_SEL,
			  HEALTHY_, PORESET_, BC_CLK, BCTL0, OPT_BUTN, HOST_RST, P2_CLK,
                   CE, OUT, HRST_740_, SRST_740_, RSV,
                       	DATA, IRQ0_SMI_, HRST_8260_, SRST_8260_);
  // Port Declaration
	input [3:0] ADDR;
	input [15:0] IN;
	input BC_CS_, OE_, WE_, ABORT, H_RST, S_RST, SRST_740_DIS, HRST_740_SEL;
	input HEALTHY_, PORESET_, BC_CLK, BCTL0, OPT_BUTN, HOST_RST;
	input P2_CLK;				// for future purpose

	output [15:2] OUT;			//out[8] out[9]
	output [7:4] CE;
	output [5:0] RSV;
	output HRST_740_, SRST_740_;

	inout [7:0] DATA;
	inout IRQ0_SMI_, HRST_8260_, SRST_8260_;

  // Wire Declaration
	wire [1:0] CE_WR;
	wire [3:0] CE_RD;
	tri [7:0] DATA;

   // Concurent Assignment 
	// For output control to drive LEDs
	// When OUT[*] is "Hi", i.e. RSV[*] is "Lo"; then LEDs is OFF.
	// When OUT[*] is "Lo", i.e. RSV[*] is "Hi"; then LEDs is ON.
	assign RSV[0] = !OUT[4];		//invert RS232_enable2
	assign RSV[1] = !OUT[5];		//invert RS232_enable1
	assign RSV[2] = !OUT[6];		//invert Fast_Ethernet_enable
	assign RSV[3] = !OUT[15];		//invert ATM_enable
	assign RSV[4] = !OUT[14];		//invert OUT[14]
	assign RSV[5] = !OUT[13];		//invert OUT[13]

  // Module Instantiations
	decoder decoder_0 (.addr (ADDR[3:0]), .bc_cs_ (BC_CS_), .oe_ (OE_), .we_ (WE_),
							.ce_wr (CE_WR[1:0]), .ce_rd (CE_RD[3:0]), .ce (CE[7:4]));

	registers register_0 (.data (DATA[7:0]), .ce_wr (CE_WR[1:0]), .pre_ (HRST_8260_),
							.out (OUT[15:2]));

	drivers drivers_0 ( .in (IN[15:0]), .out (OUT[15:2]),
						.irq0_smi_ (IRQ0_SMI_), .hrst_740 (HRST_740_), .ce_rd (CE_RD[3:0]),
                       		.data (DATA[7:0]));

	local_reset local_reset_0 ( .data (DATA[1:0]), .ce_wr0 (CE_WR[0]), .abort (ABORT),
								.h_rst (H_RST), .s_rst (S_RST), .host_rst (HOST_RST),
								.hrst_740_sel (HRST_740_SEL), .srst_740_dis (SRST_740_DIS),
                       				.hrst_740 (HRST_740_), .srst_740 (SRST_740_),
										.irq0_smi_ (IRQ0_SMI_), .hrst_8260_ (HRST_8260_),
										.srst_8260_ (SRST_8260_));

	
endmodule

