/*****************************************************************************
*  Copyright (c) 2002 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*
*  File name:      	HIP_RESET.v 
*  Date:           	Oct 16th, 2002
*  Description:		This CPLD design is used for on_board Reset and Interrupt
*                   control of HIP.
*  Name: 				Chad Forward
* 
*  Function:       	(1) PUSH_RST_ control logic
*				(2) Interrupt control
*				(3) PCI reset control
*
*  Change History:	Oct 16th, 2002	--	Creation
*
******************************************************************************/

module hip_rst_int (RST_CPLD_CLK, PCI_CLK_OUT, PUSH_RST_, RST_OUT_, Y1_RIO_RST_, E1_SW_RST_,
					E2_SW_RST_, PCI_RST_, E1_HD_RST_, E2_HD_RST_, Y2_RIO_RST_, PMC_RST_, E1_INT0, 
					E1_INT1, E2_INT0, E2_INT1, INTA_, INTB_, INTC_, INTD_, PMC_INT0,
					PMC_INT1, PMC_INT2, PMC_INT3, PMC_INT4, PMC_INT5,
					PCI_SLOT_RST_);
  
// Port Declaration
	// Reset
	input RST_CPLD_CLK;			// System clock upto 100MHz, from Robo
	input PCI_CLK_OUT;			// Yeti PCI output CLK.

	input PUSH_RST_;		   	// Push button, hard reset  
	input RST_OUT_;				// Supports resets on the PPMC
	input Y1_RIO_RST_;			// Yeti1 RIO reset
	input E1_SW_RST_;				// Ewok1 SW reset
	input E2_SW_RST_;				// Ewok2 SW reset
	
	output PCI_RST_;				// PCI YETI reset
	//input PCI_RST_;
	output PCI_SLOT_RST_;			//PCI Slots reset
	output E1_HD_RST_;			// Ewok1 hard reset
	output E2_HD_RST_;			// Ewok2 hard reset
	//output Y1_RIO_RST_;			// Yeti1 RIO reset
	output Y2_RIO_RST_;			// Yeti2 RIO reset
	output PMC_RST_;

	// Interrupt
	input E1_INT0;				// Ewok1 interrupt signal
	input E1_INT1;	
	input E2_INT0;				// Ewok2 interrupt signal
	input E2_INT1;

	output INTA_;				// Standard PCI interrupts
	output INTB_; 				
	output INTC_;
	output INTD_;
	output PMC_INT0;			//Extra interrupts to PPMC
	output PMC_INT1;
	output PMC_INT2;
	output PMC_INT3;
	output PMC_INT4;
	output PMC_INT5;


//------------1. Push button system reset generation with debounce logic-----------

	parameter PUSHRST_DELAY = 12'h0AA; 		//system clock delay ? simulation
	parameter PMC_DELAY = 12'hF00;
	reg [11:0] p_counter;				//pushrst control counter
	reg pushrst_, pmc_reset_;

	// Start of reset assignments
	assign PCI_RST_ = pushrst_;		//Set PCI_RST to Yeti1
	assign PMC_RST_ = pmc_reset_;		//Set PMC_RST to PPMC

	// RIO Reset (HD Reset) output of Yeti1 is used to set all other HD Resets
	assign E1_HD_RST_ =  Y1_RIO_RST_;
	assign E2_HD_RST_ =  Y1_RIO_RST_;
	assign Y2_RIO_RST_ =  Y1_RIO_RST_; 
	//assign Y1_RIO_RST_ =  pushrst_; 

	always @(posedge RST_CPLD_CLK or negedge PUSH_RST_) begin
		if(!PUSH_RST_)
			begin
				pushrst_ <= 1'b0;			//set pushrst_ to Lo
				pmc_reset_ <= 1'b0;			//set pmc_reset_ to Lo
				p_counter[11:0] <= 12'h00;	//clear the counter
			end
		else if (p_counter[11:0] < PUSHRST_DELAY)
			begin
				p_counter <= p_counter + 1;
			end
		else if ((p_counter[11:00] >= PUSHRST_DELAY) && (p_counter[11:00] < PMC_DELAY))
			begin
				p_counter <= p_counter + 1;
				pushrst_ <= 1;
			end
		else begin
				pmc_reset_ <= 1;			//set PMC_RESET_ to Hi
			end
	end


endmodule
