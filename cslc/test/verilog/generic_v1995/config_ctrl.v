
/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      config_ctrl.v 
*  Date:           Sept. 8th, 1999
*  Author:         Walter Li
*  Function:       Switch Setting and PowerSpan Configuration Control
*  Change History: Sept. 16,99	WL,		MPC740 interrupt glue logic
				   Sept. 21,99	WL,		removed PS_CFG_EN jumper
				   Nov. 29,99	WL,		set default parameters
				   Apr. 14,00	PM,		changed clock distribution
				   May  15,00	WL,		clean up the code
				   May 	29,00  	PM,   	Bus_Mode[1:4] mod
				   Jun. 10,00	DM,		Power-on PLL control
******************************************************************************/
module config_ctrl (
		// Input Signals
			SWCPLD, BUSMODIN1, PORESET_, HRESET_, HEALTHY_, CLKIN, PS_CFG_EN, PS_DBG_EN,
			ATM_OUT, INT_OUT, INT_PB5, FRAMEn, IDSELn, P88, P89, P90,
		// Output Signals
            MODCLK, CLKCODE, CLK_SEL, FUTURE_OPT, P1_RST_DIR, PB_RST_DIR,
			P2_RST_DIR, PB_FAST, P1_M66EN, P2_M66EN, PLL_740_MODE,
			INV_ATM_OUT, CPLDLED1, CPLDLED2, busmode22, PSIRQ, INT_740, IDSELMODn, fixclk1, fakeout1);

  // Port Declaration
	input [4:1] SWCPLD;			//....4-bit DIP switch for selection of the setting
	input PORESET_;				//Power on reset
	input HRESET_;				//Hardware reset
	input CLKIN;				//Clock input ???MHz
	input HEALTHY_;				//From cPCI hot-swap controller
	input PS_CFG_EN;			//PowerSpan Configuration enable(active low)
								//neglected on Sept. 21.
	input PS_DBG_EN;	
	input BUSMODIN1;
	input [2:1] ATM_OUT;		//ATM output signals
	input INT_OUT, INT_PB5;		//Interrupt from MPC8260

	input FRAMEn, IDSELn;		//IDSELn PS bug fix
	input P88, P89, P90;		//fake input pins (FIX GND)


	output [3:1] MODCLK; 
	output CPLDLED1, CPLDLED2; 
	output [12:0] CLKCODE;		//clock driver setting
	output [1:0] CLK_SEL;		//clock select
	output [3:0] PLL_740_MODE;	//MPC740 PLL Mode setting
	output P1_RST_DIR, PB_RST_DIR, P2_RST_DIR;		//tristate
	output PB_FAST, P1_M66EN, P2_M66EN;				//tristate
	output [7:0] FUTURE_OPT;	//out. future option + P2 BUSMODE[1:4]
	output [2:1] INV_ATM_OUT;	//invert ATM_OUT
	output [5:0] PSIRQ;			//PowerSpan IRQ lines
	output INT_740;				//Interrupt to MPC740
	output busmode22;			// BUSMODE[2] = HIGH
	output IDSELMODn;				//IDSELn PS bug fix
	output fixclk1, fakeout1;	//testing phased clocks April 14, 2000

  // Wire Declaration
	tri [3:1] MODCLK;			//define tristate
	tri P1_RST_DIR, PB_RST_DIR, P2_RST_DIR;
	tri PB_FAST, P1_M66EN, P2_M66EN;
	tri [5:0] PSIRQ;

	reg [5:0] PSIRQ_inter;		//internal PSIRQ[5:0] line
	reg [7:0] countr;
	
	wire ps_cfg_, PSIRQ_oe;
	wire [3:1] MODCLK_inter;

  // Parameters Declaration/Integer Declaration--------------------------------
	parameter 	CLOCK_MODE1 = 3'b001,		//MODCLK[b3,b2,b1] = 0,0,1.
				CLOCK_MODE2 = 3'b010,		//MODCLK[b3,b2,b1] = 0,1,0.
				CLOCK_MODE3 = 3'b010,		//MODCLK[b3,b2,b1] = 1,0,0.
				CLOCK_MODE0 = 3'b000,		//MODCLK[b3,b2,b1] = 0,0,0.*
				PSAN_IRQ_para = 6'b111011,	//PSIRQ[5:0] = 1,1,1,0,1,1.

				P1RSTDIR_para = 1'b0,	//P1_RST_DIR = 0.
				P2RSTDIR_para = 1'b1,	//P2_RST_DIR = 1.
				PBRSTDIR_para = 1'b1,	//PB_RST_DIR = 1.

		//      PBFAST_sys = 1'b0, default 50MHz configuration
				PBFAST_sys = 1'b1,		//PB_FAST = 1. system level
		//      end mod

				P1M66EN_sys = 1'b0,		//P1_M66EN = 0.system level
				P2M66EN_sys = 1'b0,		//P2_M66EN = 0.system level
				PBFAST_pwup = 1'b0,		//PB_FAST = 0. power-up level
				P1M66EN_pwup = 1'b0,	//P1_M66EN = 0. power-up level
				P2M66EN_pwup = 1'b0,	//P2_M66EN = 0. power-up level
				
			//FUTURE_OPT = 8'b00001000,	
			//FUTURE_OPT[1] = 1'b0,
			//FUTURE_OPT[2] = 1'b0,
			//FUTURE_OPT[3] = 1'b0,
			//FUTURE_OPT[4] = 1'b1,	//bus_mode[2]=1
			//FUTURE_OPT[5] = 1'b0,	//bus_mode[3]=0
			//FUTURE_OPT[6] = 1'b0,	//bus_mode[4]=0
			//FUTURE_OPT[7] = 1'b0,
	
			//Peter Mankowski March 31, 2000 changed the MPC740 PLL_MODE
				MPC740_PLL_MODE = 4'b0101,	//MPC740 PLL mode[b3:b0]*

				CLOCK_SETTING0 = 11'b00100000101,
				//13'b0 0100 0001 0111*
				CLOCK_SETTING1 = 13'h1234,	//13'b test
				CLOCK_SETTING2 = 13'h1ABC,	//13'b test
				CLOCK_SETTING3 = 13'h1888,	//13'b test

				CLOCK_SELECT0 = 2'b00,		//50MHz CLK_SEL1 = 0, CLK_SEL0 = 0.*
				CLOCK_SELECT1 = 2'b01,		//66MHz CLK_SEL1 = 0, CLK_SEL0 = 1.
				CLOCK_SELECT2 = 2'b10,		//CLK_SEL1 = 1, CLK_SEL0 = 0.
				CLOCK_SELECT3 = 2'b11;		//CLK_SEL1 = 1, CLK_SEL0 = 1.
	//-------------------------------------------------------------------------

  // Concurent Assignment
		assign FUTURE_OPT[0] = ps_cfg_;	
		assign busmode22 = 1'b1;		//busmode[2] = HIGH
		assign FUTURE_OPT[7:1] = 7'b0000000;	//FUTURE_OPTION;test pointers
		assign INV_ATM_OUT[1] = ATM_OUT[1];	//no inversion required for Tundra RDK
		assign INV_ATM_OUT[2] = ATM_OUT[2];	//no inversion required for Tundra RDK
		assign INT_740 = INT_OUT & INT_PB5;			//Sept. 16
		assign CPLDLED1 = SWCPLD[1] & HRESET_;				 
		assign CPLDLED2 = SWCPLD[2] & PORESET_; 
		
//******changed by Peter M. for SDRAM Testing ******************
		assign fixclk1 = !CLKIN;

		assign fakeout1 = (!P88 && BUSMODIN1 && !P90 && ATM_OUT[1] && (!P90 && CLKIN) && HRESET_ && !PORESET_ &&
						SWCPLD[1] && !SWCPLD[2] && !SWCPLD[3] && !SWCPLD[4]);		

		assign	CLKCODE[12:2] = CLOCK_SETTING0;		//Initial Debugging*
		assign	CLKCODE[1] = (countr == 199);
		assign	CLKCODE[0] = 1'b1;

//******* Changed by Dave.M for Power-on PLL control
// SWITCH SW3 will start controlling the 60X bus frequency + PB_fast
//assign CLK_SEL[1:0] = CLOCK_SELECT1; //66MHz config
//assign CLK_SEL[1:0] = SWCPLD[4:3]; //high 66MHz

		assign CLK_SEL[0] = 1'b1;
		assign CLK_SEL[1] = !(countr == 199);

		always @(posedge CLKIN) begin
									if (countr == 199)
										countr = 199;
								else 
										countr = countr + 1;
								end 

		assign	MODCLK_inter[3:1] = CLOCK_MODE0;	//MPC8260 clock mode

		assign MODCLK[3:1] = (!HRESET_ ? MODCLK_inter[3:1] : 3'bz);
		assign PLL_740_MODE[3:0] = MPC740_PLL_MODE;

// *****  PowerSpan configuration and PowerSpan debug mode control*****
	assign ps_cfg_ = !HEALTHY_ & PORESET_; 	//generate control signal
											//removed PS_CFG_EN; so whenever
											//the PORESET is asserted, this
											//CPLD will dirve PB MUX pins.									
		assign P1_RST_DIR = P1RSTDIR_para;	//always driving
		assign P2_RST_DIR = P2RSTDIR_para;	//always driving
		assign PB_RST_DIR = PBRSTDIR_para;	//always driving

		assign PB_FAST = (!ps_cfg_ & PBFAST_sys) |			//system level
								(ps_cfg_ & PBFAST_pwup);	//power-up option
		assign P1_M66EN = (!ps_cfg_ & P1M66EN_sys) |		//system level
								(ps_cfg_ & P1M66EN_pwup);	//power-up option
		assign P2_M66EN = (!ps_cfg_ & P2M66EN_sys) |		//system level
								(ps_cfg_ & P2M66EN_pwup);	//power-up option

	always @(ps_cfg_ or PS_DBG_EN) begin
		if ((PS_DBG_EN == 1) && (ps_cfg_ == 0))
	  		begin
	   			PSIRQ_inter[5:0] = PSAN_IRQ_para;
	 		end
		else if ((PS_DBG_EN == 0) && (ps_cfg_ == 1))
	  		begin
	    		PSIRQ_inter[3:0] = SWCPLD[4:1];
				PSIRQ_inter[5:4] = 2'bz;
	  		end
		else
	  		begin
	    		PSIRQ_inter[5:0] = 6'hz;
	  		end
	end 	// end of always
	
	assign PSIRQ_oe = ((PS_DBG_EN == 1) && (ps_cfg_ == 0))
							|| ((PS_DBG_EN == 0) && (ps_cfg_ == 1));
	assign PSIRQ[3:0] = (PSIRQ_oe ? PSIRQ_inter[3:0] : 4'hz);
	assign PSIRQ[5:4] = ( ((PS_DBG_EN == 1) && (ps_cfg_ == 0)) ?
							PSIRQ_inter[5:4] : 2'bz);

assign IDSELMODn = (!FRAMEn && IDSELn);	//PS SILICON BUG FIX
		
endmodule

