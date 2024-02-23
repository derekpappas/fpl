// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// ----------------------------------------------------------------------------------------
// File Name : Common Defines 
// Version : <0.1>
// Status : <Module is Complete>
// ----------------------------------------------------------------------------------------
// Author : Ashlesha Gokhale 
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date :May, 06, 2003
// ----------------------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : May, 06, 2003
// ----------------------------------------------------------------------------------------
// Dependencies : None
// Description  : This file contains the timing parameters 
// Simulation Notes : To simulate with zero delay use switch ZERODELAY, 
//                    to use min timing values of 100MHz frequency, use switch TMIN 
// Application Note : <Application note for the structures>
// Simulator : verilog xl.
// Terms & concepts : NA
// Open issues and future enhancements : None
// References : <Details of the references>
// Revision History :
// Rev Author Phone Date Changes
// ----------------------------------------------------------------------------------------
// <Name> <number> <Date> <details>
// ----------------------------------------------------------------------------------------

/*******************************************************************************************
                                      TIMING PARAMETERS                                    
*******************************************************************************************/
                                                                                           
//=======================================  0 delay  =======================================
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
parameter tSW    = 0.0; // R/W Setup time
parameter tHW    = 0.0; // R/W Hold time
parameter tSD    = 0.0; // Input Data setup time
parameter tHD    = 0.0; // Input Data hold time
parameter tOE    = 0.0; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 0.0; // OE to High Z
parameter tCD2   = 0.0; // Clock to data valid
parameter tDC    = 0.0; // Data output hold after clock High
parameter tCKHZ  = 0.0; // Clock high to output High Z
parameter tCKLZ  = 0.0; // Clock high to output Low Z
parameter tSINT  = 0.0; // Clock to int set time
parameter tRINT  = 0.0; // Clock to int reset time

// Port to Port Delays
parameter tCCS      = 0.0; // Clock to Clock setup time 
parameter tRS       = 0.0; // Master Reset Pulse width
parameter tRSS      = 0.0; // Master reset setup time
parameter tRSR      = 0.0; // master reset recovery time
parameter tRSF      = 0.0; // Master reset to Output inactive



//=======================================  150  =============================================


`else                   // By default model's operating frequency is 100 MHz

`ifdef FREQ133

// Timings for -133_max
parameter fMAX2  = 133; // Maximun operating frequency
parameter tCYC2  = 7.5;// Clock cycle time
parameter tCH2   = 3.0; // Clock high time 
parameter tCL2   = 3.0; // Clock low time
parameter tSA    = 2.5; // Address setup time
parameter tHA    = 0.5; // Address hold time
parameter tSB    = 2.5; // Byte select setup time
parameter tHB    = 0.6; // Byte select hold time
parameter tSW    = 2.5; // R/W Setup time
parameter tHW    = 0.6; // R/W Hold time
parameter tSD    = 2.5; // Input Data setup time
parameter tHD    = 0.6; // Input Data hold time
parameter tOE    = 4.7; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 4.7; // OE to High Z
parameter tOHZmin   = 0.0; // OE to High Z
parameter tCD2   = 4.7; // Clock to data valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZmin  = 0.0; // Clock high to output High Z
parameter tCKLZmin  = 0.0; // Clock high to output Low Z
parameter tCKHZ  = 4.7; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINTmin  = 0.5; // Clock to int set time
parameter tRINTmin  = 0.5; // Clock to int reset time
parameter tSINT  = 7.5; // Clock to int set time
parameter tRINT  = 7.5; // Clock to int reset time


// Port to Port Delays
parameter tCCS      = 6.0; // Clock to Clock setup time 
parameter tRS       = 5.0; // Master Reset Pulse width
parameter tRSS      = 6.0; // Master reset setup time
parameter tRSR      = 5.0; // master reset recovery time
parameter tRSF      = 10.0; // Master reset to Output inactiv
parameter tRScntint = 8.0; // Master reset to counter interrupt Flag reset time



`else
// Timings for -100_max
parameter fMAX2  = 100; // Maximun operating frequency
parameter tCYC2  = 10.0;// Clock cycle time
parameter tCH2   = 4.0; // Clock high time 
parameter tCL2   = 4.0; // Clock low time
parameter tSA    = 3.0; // Address setup time
parameter tHA    = 0.6; // Address hold time
parameter tSB    = 3.0; // Byte select setup time
parameter tHB    = 0.6; // Byte select hold time
parameter tSW    = 3.0; // R/W Setup time
parameter tHW    = 0.6; // R/W Hold time
parameter tSD    = 3.0; // Input Data setup time
parameter tHD    = 0.6; // Input Data hold time
parameter tOE    = 5.0; // Output Enable to data valid
parameter tOLZ   = 0.0; // OE to Low Z
parameter tOHZ   = 5.0; // OE to High Z
parameter tOHZmin = 0.0; // OE to High Z
parameter tCD2   = 5.0; // Clock to data valid
parameter tDC    = 1.0; // Data output hold after clock High
parameter tCKHZmin  = 0.0; // Clock high to output High Z
parameter tCKLZmin  = 0.0; // Clock high to output Low Z
parameter tCKHZ  = 5.0; // Clock high to output High Z
parameter tCKLZ  = 1.0; // Clock high to output Low Z
parameter tSINTmin  = 0.5; // Clock to int set time
parameter tRINTmin  = 0.5; // Clock to int reset time
parameter tSINT  = 10.0; // Clock to int set time
parameter tRINT  = 10.0; // Clock to int reset time


// Port to Port Delays
parameter tCCS      = 8.0; // Clock to Clock setup time 
parameter tRS       = 5.0; // Master Reset Pulse width
parameter tRSS      = 8.5; // Master reset setup time
parameter tRSR      = 5.0; // master reset recovery time
parameter tRSF      = 10.0; // Master reset to Output inactive



`endif 

`endif // !ifdef ZERODELAY

//===============================End OF FILE ===========================================//
















