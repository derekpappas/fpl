//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2001 SPIKE TECHNOLOGIES INC.
//                          ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0832v_Timing_model.v
//
// Author       : Nandu Thakar and Chandrakant Umate
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : This is timing parameters file 
//
// Notes        : First Release
//
//
// Modification History:
// Date         By       Version     Change Description
// ==========================================================================
// 03/09/2001  CZU       1.0         First Release
//
//
//
// ==========================================================================
//------------------------------------------------------------------------------

/**********************************************************************************************************
 *                                     TIMING PARAMETERS
 *********************************************************************************************************/

//=======================================  0 delay  =========================================================
`ifdef ZERODELAY

// Timings for -100_zero

parameter fMAX2  = 100; // Maximun operating frequency
parameter tCYC2  = 10.0;// Clock cycle time
parameter tCH2   = 0.0; // Clock high time 
parameter tCL2   = 0.0; // Clock low time
parameter tSA    = 0.0; // Address setup time
parameter tHA    = 0.0; // Address hold time
parameter tSB    = 0.0; // Byte select setup time
parameter tHB    = 0.0; // Byte select hold time
parameter tSC    = 0.0; // Chip enable setup time
parameter tHC    = 0.0; // Chip enable hold time
parameter tSW    = 0.0; // R/W Setup time
parameter tHW    = 0.0; // R/W Hold time
parameter tSD    = 0.0; // Input Data setup time
parameter tHD    = 0.0; // Input Data hold time
parameter tSAD   = 0.0; // ADS setup time
parameter tHAD   = 0.0; // ADS hold time
parameter tSCN   = 0.0; // CNTEN Setup time
parameter tHCN   = 0.0; // CNTEN Hold time
parameter tSRST  = 0.0; // CNTRST Setup time
parameter tHRST  = 0.0; // CNTRST Hold time
parameter tSCM   = 0.0; // CNT/MSK Setup time
parameter tHCM   = 0.0; // CNT/MSK Hold time
parameter tOE    = 0.0; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 0.0; // OE to High Z
parameter tCD2   = 0.0; // Clock to data valid
parameter tCA2   = 0.0; // clock to counter address valid
parameter tCM2   = 0.0; // clock to mask register readback valid
parameter tDC    = 0.0; // Data output hold after clock High
parameter tCKHZ  = 0.0; // Clock high to output High Z
parameter tCKLZ  = 0.0; // Clock high to output Low Z
parameter tSINT  = 0.0; // Clock to int set time
parameter tRINT  = 0.0; // Clock to int reset time
parameter tSCINT = 0.0; // Clock to CNTINT Set time
parameter tRCINT = 0.0; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 0.0; // Clock to Clock setup time 
parameter tRS       = 0.0; // Master Reset Pulse width
parameter tRSS      = 0.0; // Master reset setup time
parameter tRSR      = 0.0; // master reset recovery time
parameter tRSF      = 0.0; // Master reset to Output inactive
parameter tRScntint = 0.0; // Master reset to counter interrupt Flag reset time


//=======================================  150  =========================================================
`else
 `ifdef FREQ150
  `ifdef TMIN

// Timings for -150_min
parameter fMAX2  = 150; // Maximun operating frequency
parameter tCYC2  = 6.7; // Clock cycle time
parameter tCH2   = 2.7; // Clock high time 
parameter tCL2   = 2.7; // Clock low time
parameter tSA    = 2.3; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 2.3; // Byte select setup time
parameter tHB    = 0.5; // Byte select hold time
parameter tSC    = 2.3; // Chip enable setup time
parameter tHC    = 0.5; // Chip enable hold time
parameter tSW    = 2.3; // R/W Setup time
parameter tHW    = 0.5; // R/W Hold time
parameter tSD    = 2.3; // Input Data setup time
parameter tHD    = 0.5; // Input Data hold time
parameter tSAD   = 2.3; // ADS setup time
parameter tHAD   = 0.5; // ADS hold time
parameter tSCN   = 2.3; // CNTEN Setup time
parameter tHCN   = 0.5; // CNTEN Hold time
parameter tSRST  = 2.3; // CNTRST Setup time
parameter tHRST  = 0.5; // CNTRST Hold time
parameter tSCM   = 2.3; // CNT/MSK Setup time
parameter tHCM   = 0.5; // CNT/MSK Hold time
parameter tOE    = 3.8; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 0.0; // OE to High Z
parameter tCD2   = 3.8; // Clock to data valid
parameter tCA2   = 3.8; // clock to counter address valid
parameter tCM2   = 3.8; // clock to mask register readback valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZ  = 0.0; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINT  = 0.5; // Clock to int set time
parameter tRINT  = 0.5; // Clock to int reset time
parameter tSCINT = 0.5; // Clock to CNTINT Set time
parameter tRCINT = 0.5; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 5.2; // Clock to Clock setup time 
parameter tRS       = 7.0; // Master Reset Pulse width
parameter tRSS      = 6.0; // Master reset setup time
parameter tRSR      = 6.0; // master reset recovery time
parameter tRSF      = 6.0; // Master reset to Output inactive
parameter tRScntint = 5.3; // Master reset to counter interrupt Flag reset time


 `else // !ifdef TMIN

// Timings for -150_max
parameter fMAX2  = 150; // Maximun operating frequency
parameter tCYC2  = 6.7; // Clock cycle time
parameter tCH2   = 2.7; // Clock high time 
parameter tCL2   = 2.7; // Clock low time
parameter tSA    = 2.3; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 2.3; // Byte select setup time
parameter tHB    = 0.5; // Byte select hold time
parameter tSC    = 2.3; // Chip enable setup time
parameter tHC    = 0.5; // Chip enable hold time
parameter tSW    = 2.3; // R/W Setup time
parameter tHW    = 0.5; // R/W Hold time
parameter tSD    = 2.3; // Input Data setup time
parameter tHD    = 0.5; // Input Data hold time
parameter tSAD   = 2.3; // ADS setup time
parameter tHAD   = 0.5; // ADS hold time
parameter tSCN   = 2.3; // CNTEN Setup time
parameter tHCN   = 0.5; // CNTEN Hold time
parameter tSRST  = 2.3; // CNTRST Setup time
parameter tHRST  = 0.5; // CNTRST Hold time
parameter tSCM   = 2.3; // CNT/MSK Setup time
parameter tHCM   = 0.5; // CNT/MSK Hold time
parameter tOE    = 3.8; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 3.8; // OE to High Z
parameter tCD2   = 3.8; // Clock to data valid
parameter tCA2   = 3.8; // clock to counter address valid
parameter tCM2   = 3.8; // clock to mask register readback valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZ  = 3.8; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINT  = 5.0; // Clock to int set time
parameter tRINT  = 5.0; // Clock to int reset time
parameter tSCINT = 4.2; // Clock to CNTINT Set time
parameter tRCINT = 4.2; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 5.2; // Clock to Clock setup time 
parameter tRS       = 7.0; // Master Reset Pulse width
parameter tRSS      = 6.0; // Master reset setup time
parameter tRSR      = 6.0; // master reset recovery time
parameter tRSF      = 6.0; // Master reset to Output inactive
parameter tRScntint = 5.3; // Master reset to counter interrupt Flag reset time

 `endif // !ifdef TMIN

//=======================================  133  =========================================================

`else 
 `ifdef FREQ133
  `ifdef TMIN

// Timings for -133_min
parameter fMAX2  = 133; // Maximun operating frequency
parameter tCYC2  = 7.5; // Clock cycle time
parameter tCH2   = 3.0; // Clock high time 
parameter tCL2   = 3.0; // Clock low time
parameter tSA    = 2.5; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 2.5; // Byte select setup time
parameter tHB    = 0.5; // Byte select hold time
parameter tSC    = 2.5; // Chip enable setup time
parameter tHC    = 0.5; // Chip enable hold time
parameter tSW    = 2.5; // R/W Setup time
parameter tHW    = 0.5; // R/W Hold time
parameter tSD    = 2.5; // Input Data setup time
parameter tHD    = 0.5; // Input Data hold time
parameter tSAD   = 2.5; // ADS setup time
parameter tHAD   = 0.5; // ADS hold time
parameter tSCN   = 2.5; // CNTEN Setup time
parameter tHCN   = 0.5; // CNTEN Hold time
parameter tSRST  = 2.5; // CNTRST Setup time
parameter tHRST  = 0.5; // CNTRST Hold time
parameter tSCM   = 2.5; // CNT/MSK Setup time
parameter tHCM   = 0.5; // CNT/MSK Hold time
parameter tOE    = 4.5; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 0.0; // OE to High Z
parameter tCD2   = 4.2; // Clock to data valid
parameter tCA2   = 4.2; // clock to counter address valid
parameter tCM2   = 4.2; // clock to mask register readback valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZ  = 0.0; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINT  = 0.5; // Clock to int set time
parameter tRINT  = 0.5; // Clock to int reset time
parameter tSCINT = 0.5; // Clock to CNTINT Set time
parameter tRCINT = 0.5; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 6.0; // Clock to Clock setup time 
parameter tRS       = 7.5; // Master Reset Pulse width
parameter tRSS      = 6.0; // Master reset setup time
parameter tRSR      = 7.5; // master reset recovery time
parameter tRSF      = 6.5; // Master reset to Output inactive
parameter tRScntint = 6.5; // Master reset to counter interrupt Flag reset time


  `else

// Timings for -133_max
parameter fMAX2  = 133; // Maximun operating frequency
parameter tCYC2  = 7.5; // Clock cycle time
parameter tCH2   = 3.0; // Clock high time 
parameter tCL2   = 3.0; // Clock low time
parameter tSA    = 2.5; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 2.5; // Byte select setup time
parameter tHB    = 0.5; // Byte select hold time
parameter tSC    = 2.5; // Chip enable setup time
parameter tHC    = 0.5; // Chip enable hold time
parameter tSW    = 2.5; // R/W Setup time
parameter tHW    = 0.5; // R/W Hold time
parameter tSD    = 2.5; // Input Data setup time
parameter tHD    = 0.5; // Input Data hold time
parameter tSAD   = 2.5; // ADS setup time
parameter tHAD   = 0.5; // ADS hold time
parameter tSCN   = 2.5; // CNTEN Setup time
parameter tHCN   = 0.5; // CNTEN Hold time
parameter tSRST  = 2.5; // CNTRST Setup time
parameter tHRST  = 0.5; // CNTRST Hold time
parameter tSCM   = 2.5; // CNT/MSK Setup time
parameter tHCM   = 0.5; // CNT/MSK Hold time
parameter tOE    = 4.5; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 4.2; // OE to High Z
parameter tCD2   = 4.2; // Clock to data valid
parameter tCA2   = 4.2; // clock to counter address valid
parameter tCM2   = 4.2; // clock to mask register readback valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZ  = 4.2; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINT  = 5.7; // Clock to int set time
parameter tRINT  = 5.7; // Clock to int reset time
parameter tSCINT = 4.8; // Clock to CNTINT Set time
parameter tRCINT = 4.8; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 6.0; // Clock to Clock setup time 
parameter tRS       = 7.5; // Master Reset Pulse width
parameter tRSS      = 6.0; // Master reset setup time
parameter tRSR      = 7.5; // master reset recovery time
parameter tRSF      = 6.5; // Master reset to Output inactive
parameter tRScntint = 6.5; // Master reset to counter interrupt Flag reset time

  `endif // !ifdef TMIN
  
//=======================================  100  =========================================================

`else                   // By default model's operating frequency is 100 MHz
 `ifdef TMIN

// Timings for -100_min
parameter fMAX2  = 100; // Maximun operating frequency
parameter tCYC2  = 10.5; // Clock cycle time
parameter tCH2   = 4.0; // Clock high time 
parameter tCL2   = 4.0; // Clock low time
parameter tSA    = 3.0; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 3.0; // Byte select setup time
parameter tHB    = 0.5; // Byte select hold time
parameter tSC    = 3.0; // Chip enable setup time
parameter tHC    = 0.5; // Chip enable hold time
parameter tSW    = 3.0; // R/W Setup time
parameter tHW    = 0.5; // R/W Hold time
parameter tSD    = 3.0; // Input Data setup time
parameter tHD    = 0.5; // Input Data hold time
parameter tSAD   = 3.0; // ADS setup time
parameter tHAD   = 0.5; // ADS hold time
parameter tSCN   = 3.0; // CNTEN Setup time
parameter tHCN   = 0.5; // CNTEN Hold time
parameter tSRST  = 3.0; // CNTRST Setup time
parameter tHRST  = 0.5; // CNTRST Hold time
parameter tSCM   = 3.0; // CNT/MSK Setup time
parameter tHCM   = 0.5; // CNT/MSK Hold time
parameter tOE    = 5.0; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 0.0; // OE to High Z
parameter tCD2   = 5.0; // Clock to data valid
parameter tCA2   = 5.0; // clock to counter address valid
parameter tCM2   = 5.0; // clock to mask register readback valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZ  = 0.0; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINT  = 0.5; // Clock to int set time
parameter tRINT  = 0.5; // Clock to int reset time
parameter tSCINT = 0.5; // Clock to CNTINT Set time
parameter tRCINT = 0.5; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 8.0; // Clock to Clock setup time 
parameter tRS       = 10.0; // Master Reset Pulse width
parameter tRSS      = 8.5; // Master reset setup time
parameter tRSR      = 10.0; // master reset recovery time
parameter tRSF      = 8.0; // Master reset to Output inactive
parameter tRScntint = 8.0; // Master reset to counter interrupt Flag reset time


 `else                  // By default model considers MAXimum timing templates

// Timings for -100_max
parameter fMAX2  = 100; // Maximun operating frequency
parameter tCYC2  = 10.0;// Clock cycle time
parameter tCH2   = 4.0; // Clock high time 
parameter tCL2   = 4.0; // Clock low time
parameter tSA    = 3.0; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 3.0; // Byte select setup time
parameter tHB    = 0.5; // Byte select hold time
parameter tSC    = 3.0; // Chip enable setup time
parameter tHC    = 0.5; // Chip enable hold time
parameter tSW    = 3.0; // R/W Setup time
parameter tHW    = 0.5; // R/W Hold time
parameter tSD    = 3.0; // Input Data setup time
parameter tHD    = 0.5; // Input Data hold time
parameter tSAD   = 3.0; // ADS setup time
parameter tHAD   = 0.5; // ADS hold time
parameter tSCN   = 3.0; // CNTEN Setup time
parameter tHCN   = 0.5; // CNTEN Hold time
parameter tSRST  = 3.0; // CNTRST Setup time
parameter tHRST  = 0.5; // CNTRST Hold time
parameter tSCM   = 3.0; // CNT/MSK Setup time
parameter tHCM   = 0.5; // CNT/MSK Hold time
parameter tOE    = 5.0; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 5.0; // OE to High Z
parameter tCD2   = 5.0; // Clock to data valid
parameter tCA2   = 5.0; // clock to counter address valid
parameter tCM2   = 5.0; // clock to mask register readback valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZ  = 5.0; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINT  = 7.5; // Clock to int set time
parameter tRINT  = 7.5; // Clock to int reset time
parameter tSCINT = 6.8; // Clock to CNTINT Set time
parameter tRCINT = 6.8; // Clock to CNTINT Reset time

// Port to Port Delays
parameter tCCS      = 8.0; // Clock to Clock setup time 
parameter tRS       = 10.0; // Master Reset Pulse width
parameter tRSS      = 8.5; // Master reset setup time
parameter tRSR      = 10.0; // master reset recovery time
parameter tRSF      = 8.0; // Master reset to Output inactive
parameter tRScntint = 8.0; // Master reset to counter interrupt Flag reset time

 `endif // !ifdef TMIN
`endif // !ifdef FREQ133
`endif // !ifdef FREQ150
`endif // !ifdef ZERODELAY

//==========================================================================================================
