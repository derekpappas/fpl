/*****************************************************************************
*  Copyright (c) 2002 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*
*  File name:      	HIP_RESET.v 
*  Date:           	Oct 6th, 2003
*  Description:		This CPLD design is used for on_board Reset control of HIP2 RESPIN.
*				This code do NOT support the HIP2. 
*  Name: 			Chad Forward
* 
*  Function:       	(1) PUSH_RST_ control logic
*				(2) PCI / PCIX reset control
*				(3) RIO reset control
*				(4) JTAG RSTn control
*
*  Change History:	Oct 6th, 2003	--	Creation
*				
*
******************************************************************************/

module hip_rst_int (RST_CPLD_CLK, PCI_CLK_OUT, PUSH_RST_, RST_OUT_, Y1_RIO_RST_, E1_SW_RST_,
					E2_SW_RST_, PCI_RST_, E1_HD_RST_, E2_HD_RST_, Y2_RIO_RST_, PMC_RST_,
					PCIX_SLOT_RST_, PCIX_CPLD_RST_, PCIX_HS_LED_, POWER_ON_RST_,
					Y1_JT_RST_, Y2_JT_RST_, E_JT_RST_, Y1_TRST_, Y2_TRST_, 
					E1_TRST_, E2_TRST_);
  
// Port Declaration
	// PCI and RIO Reset Control
	input RST_CPLD_CLK;			// System clock upto 100MHz, from Robo
	input PCI_CLK_OUT;			// Yeti PCI output CLK.

	input PUSH_RST_;		   	// Push button, hard reset
	input POWER_ON_RST_;		// Power On Reset
	input PCIX_HS_LED_;		// Yeti2 HS_LEDn input
	input PCIX_CPLD_RST_;  		// PCIX input reset used to control slot resets
	input RST_OUT_;			// Supports resets on the PPMC
	input Y1_RIO_RST_;		// Yeti1 RIO reset
	input E1_SW_RST_;			// Ewok1 SW reset
	input E2_SW_RST_;			// Ewok2 SW reset
	
	output PCI_RST_;			// PCI YETI reset
	output PCIX_SLOT_RST_;		// PCIX Slots reset
	output E1_HD_RST_;		// Ewok1 hard reset
	output E2_HD_RST_;		// Ewok2 hard reset
	output Y2_RIO_RST_;		// Yeti2 RIO reset
	output PMC_RST_;

	// JTAG Reset Control
	input Y1_JT_RST_;			// Yeti1 JTAG header input
	input Y2_JT_RST_;			// Yeti2 JTAG header input
	input E_JT_RST_;			// Ewok JTAG header input

	output Y1_TRST_;			// Yeti1 JTAG input
	output Y2_TRST_;			// Yeti2 JTAG input
	output E1_TRST_;			// Ewok1 JTAG input
	output E2_TRST_; 			// Ewok2 JTAG input


//------------1. Push button system reset generation with debounce logic-----------

	parameter PUSHRST_DELAY = 16'hFFF0; 	//system clock delay ? simulation
	//parameter PMC_DELAY = 16'hFFF0; 		//PMC reset delay
	reg [15:0] p_counter;				//pushrst control counter
	reg pushrst_, pmc_reset_;
	
	// Start of reset assignments
	assign PCI_RST_ = pushrst_ & (~POWER_ON_RST_);	//Set PCI_RST to Yeti1
	assign PMC_RST_ = pushrst_ & (~POWER_ON_RST_);	//Set PMC_RST to PPMC

	// RIO Reset (HD Reset) output of Yeti1 is used to set all other HD Resets
	assign E1_HD_RST_ =  Y1_RIO_RST_;	    // Y1_RIO_RST_ is released after PCI_RST_
	assign E2_HD_RST_ =  Y1_RIO_RST_;
	assign Y2_RIO_RST_ =  Y1_RIO_RST_; 
	
	
	// Debounce Logic for Push Button Reset
	always @(posedge RST_CPLD_CLK) begin
		if(!PUSH_RST_)
			begin
				pushrst_ <= 1'b0;			//set pushrst_ to Lo
				pmc_reset_ <= 1'b0;			//set pmc_reset_ to Lo
				p_counter[15:0] <= 16'h0000;	//clear the counter
			end
		else if (p_counter[15:0] < PUSHRST_DELAY)
			begin
				p_counter[15:0] <= p_counter[15:0] + 1'b1;
				pushrst_ <= 0;
			    	pmc_reset_ <= ~pmc_reset_;
			end
		else begin
				pushrst_ <= 1'b1;					//set PMC_RESET_ to Hi
			end
	end

//------------2. JTAG Reset Control Logic -----------

// JTAG RST assignments
	assign Y1_TRST_ = Y1_JT_RST_ & (~POWER_ON_RST_);		
	assign Y2_TRST_ = Y2_JT_RST_ & (~POWER_ON_RST_);		
	assign E1_TRST_ = E_JT_RST_ & (~POWER_ON_RST_);
	assign E2_TRST_ = E_JT_RST_ & (~POWER_ON_RST_);

	
endmodule
