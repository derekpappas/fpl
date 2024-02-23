
/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      sdmux_v.v 
*  Date:           Aug. 8th, 1999
*  Author:         Walter Li
*  Function:       1)	SDRAM address multiplexer
8				   2)	The 60x_bus transciver control
*  Change History: 
*  Jan. 2nd, 2000, Multiplexing strategy changes, by: Peter Mankowski
*				EDIT.1 - REVERSED "SDMUX POLARITY" CORRECTION
*				edit.2 - ONLY TWO bksel BEING USED[0:1]
*  Jan. 11, 2000, "Buffer Control" edit, by: Peter Mankowski
*				pin.63 "DBUFENn" has been defined as an output that controls data
*				transceivers on the 60x bus.
*				Edited function is an equvalent of equation below:
*				DBUFENn = (8BITFLASHCHIPSELECTn AND 64BITFLASHCHIPSELECTn 
*							AND CPLDCHIPSELECTn)
*  Feb. 14, 2000, Clean up Verilog code, by: Walter Li
******************************************************************************/

module sdmux_v ( BADDR[6:28], PSDAMUX, PSDA10, BANKSEL[0:2],
					ALE, RAS_, CAS_, SD_CS_, SD_WE_, SD_CLKIN,
					HRESET_, CSN[3:0], BCTL[1:0], OPTION_IN, PORESET_,
                       SD_ADDR[13:0], OPTION_OUT, RSV[5:0], TRAN_DIR, TRAN_OE_);

  // Port Declaration
	input [6:28] BADDR;		// Buffered 60x_bus is big endian 
	input [0:2] BANKSEL;	// BANKSEL[0:2] is big endian
	input PSDAMUX, PSDA10;
	input ALE, RAS_, CAS_, SD_CS_, SD_WE_, SD_CLKIN;
	input [3:0] CSN;		// ATM_CS, Flash_8bit, Flash_64bit, Board Controller
	input [1:0] BCTL;		// 60x bus buffer control from MPC8260 mem_controller
	input PORESET_, OPTION_IN, HRESET_; 

	output [13:0] SD_ADDR;	// SDRAM address is little endian
	output OPTION_OUT;		// for future purpose
	output [5:0] RSV;
	output TRAN_DIR, TRAN_OE_;	// 60x_Bus transceiver control

  // Wire Declaration
	reg [13:0] SD_ADDR;
	
  // Integer Declaration

  // Concurent Assignment
	assign OPTION_OUT = OPTION_IN;	// for test purpose

	assign RSV[0] = ALE;			// for test purpose
	assign RSV[1] = RAS_;
	assign RSV[2] = CAS_;
	assign RSV[3] = SD_CS_;
	assign RSV[4] = SD_WE_;
	assign RSV[5] = SD_CLKIN;

// The 60x_Bus transceiver control
	assign TRAN_DIR = BCTL[0];		
	assign TRAN_OE_ = CSN[0] & CSN[3] & CSN[1];	//the transciver is open
												//when the devices which is 
												//behind of the 60x_bus are 
												//asserted.

  // Always Statement
	always @(PSDAMUX)  begin
		if (PSDAMUX)
		  begin
		    SD_ADDR[8:0] = BADDR[11:19];	// RAS_ is asserted		
		  end
		else
		  begin
		    SD_ADDR[8:0] = BADDR[20:28];	// CAS_ is asserted
		  end

//Other most significant SDRAM address
			SD_ADDR[9] = BADDR[10];
			SD_ADDR[10] = PSDA10; 			 			
			SD_ADDR[11] = BADDR[8]; 
	
			SD_ADDR[12] = BANKSEL[1];  
			SD_ADDR[13] = BANKSEL[0]; 
	end	// end of always 
	
endmodule


