// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from 
// Wipro Technologies.
// ------------------------------------------------------------------------------
// File Name : Common Defines 
// Version : <0.1>
// Status : <Module is Complete>
// ------------------------------------------------------------------------------
// Author : Ashlesha Gokhale 
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date :April, 08, 2004
// ------------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : April, 08, 2004
// ------------------------------------------------------------------------------
// Dependencies : None
// Description  : This file contains the timing parameters 
// Simulation Notes : To simulate with zero delay use switch ZERODELAY, 
//                    to use min timing values of 100MHz frequency, 
//                    use switch TMIN 
// Application Note : <Application note for the structures>
// Simulator : verilog xl 2.2, vsim 5.7d.
// Terms & concepts : NA
// Open issues and future enhancements : None
// References : <Details of the references>
// Revision History :
// Rev Author Phone Date Changes
// -----------------------------------------------------------------------------
// <Name> <number> <Date> <details>
// -----------------------------------------------------------------------------

/********************************************************************************
                           TIMING PARAMETERS                         
********************************************************************************/
                                                                              
             
//=======================================  0 delay  =============================
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
    parameter tOHZmin   = 0.0; // OE to High Z
    parameter tCD2   = 0.0; // Clock to data valid
    parameter tDC    = 0.0; // Data output hold after clock High
    parameter tCKHZ  = 0.0; // Clock high to output High Z
    parameter tCKHZmin  = 0.0; // Clock high to output High Z
    parameter tCKLZ  = 0.0; // Clock high to output Low Z
    parameter tSINT  = 0.0; // Clock to int set time
    parameter tRINT  = 0.0; // Clock to int reset time
    parameter tSC    = 0.0; // Address setup time
    parameter tHC    = 0.0; // Address hold time
    parameter tSAD    = 0.0; // Address setup time
    parameter tHAD    = 0.0; // Address hold time
    parameter tSCN    = 0.0; // Address setup time
    parameter tHCN    = 0.0; // Address hold time
    parameter tSCM    = 0.0; // Address setup time
    parameter tHCM    = 0.0; // Address hold time
    parameter tSRST    = 0.0; // Address setup time
    parameter tHRST    = 0.0; // Address hold time
    parameter tCA2     = 4.5; //
    parameter tCM2     = 4.5;
    parameter  tSCINTmin   = 0.0;
    parameter tRCINTmin   = 0.0; 
    parameter  tSCINT   = 0.5;
    parameter tRCINT   = 0.5; 

// Port to Port Delays
    parameter tCCS      = 0.0; // Clock to Clock setup time 
    parameter tRS       = 0.0; // Master Reset Pulse width
    parameter tRSS      = 0.0; // Master reset setup time
    parameter tRSR      = 0.0; // master reset recovery time
    parameter tRSF      = 0.0; // Master reset to Output inactive
    parameter tRScntint = 0.0; // Master reset to counter interrupt Flag reset time


//=======================================  150  =================================


`endif                   // By default model's operating frequency is 100 MHz

 `ifdef FREQ133

 // Timings for -133_max
     parameter fMAX2  = 133; // Maximun operating frequency
     parameter tCYC2  = 7.5;// Clock cycle time
     parameter tCH2   = 3.0; // Clock high time 
     parameter tCL2   = 3.0; // Clock low time
     parameter tSA    = 2.5; // Address setup time
     parameter tHA    = 0.6; // Address hold time
     parameter tSB    = 2.5; // Byte select setup time
     parameter tHB    = 0.6; // Byte select hold time
     parameter tSW    = 2.5; // R/W Setup time
     parameter tHW    = 0.6; // R/W Hold time
     parameter tSD    = 2.5; // Input Data setup time
     parameter tHD    = 0.6; // Input Data hold time
     parameter tOE    = 4.4; // Output Enable to data valid
     parameter tOLZ   = 0.0; // OE to Low Z
     parameter tOHZ   = 4.4; // OE to High Z
     parameter tOHZmin   = 0.0; // OE to High Z
     parameter tCD2   = 4.4; // Clock to data valid
     parameter tDC    = 1.0; // Data output hold after clock High
     parameter tCKHZmin  = 1.0; // Clock high to output High Z
     parameter tCKLZmin  = 0.0; // Clock high to output Low Z
     parameter tCKHZ  = 4.4; // Clock high to output High Z
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
     parameter tRScntint = 5.8; // Master reset to counter interrupt Flag reset time
     
     parameter tSC    = 2.5; // Address setup time
     parameter tHC    = 0.6; // Address hold time
     parameter tSAD    = 2.5; // Address setup time
     parameter tHAD    = 0.6; // Address hold time
     parameter tSCN    = 2.5; // Address setup time
     parameter tHCN    = 0.6; // Address hold time
     parameter tSCM    = 2.5; // Address setup time
     parameter tHCM    = 0.6; // Address hold time
     parameter tSRST    = 2.5; // Address setup time
     parameter tHRST    = 0.6; // Address hold time
     parameter tCA2     = 4.4; //
     parameter tCM2     = 4.4;
     parameter  tSCINTmin   = 0.5;
     parameter tRCINTmin   = 0.5; 
     parameter  tSCINT   = 5.7;
     parameter tRCINT   = 5.7; 

 `endif
 `ifdef FREQ167    
        // Timings for -167_max
     parameter fMAX2  = 167; // Maximun operating frequency
     parameter tCYC2  = 6.0;// Clock cycle time
     parameter tCH2   = 2.7; // Clock high time 
     parameter tCL2   = 2.7; // Clock low time
     parameter tSA    = 2.3; //1.3; // Address setup time
     parameter tHA    = 0.6; // Address hold time
     parameter tSB    = 2.3; // Byte select setup time
     parameter tHB    = 0.6; // Byte select hold time
     parameter tSW    = 2.3; // R/W Setup time
     parameter tHW    = 0.6; // R/W Hold time
     parameter tSD    = 2.3; //1.3; // Input Data setup time
     parameter tHD    = 0.6; // Input Data hold time
     parameter tOE    = 4.0; // Output Enable to data valid
     parameter tOLZ   = 0.0; // OE to Low Z
     parameter tOHZ   = 4.0; // OE to High Z
     parameter tOHZmin = 0.0; // OE to High Z
     parameter tCD2   = 4.0; // Clock to data valid
     parameter tDC    = 1.0; // Data output hold after clock High
     parameter tCKHZmin  = 1.0; // Clock high to output High Z
     parameter tCKLZmin  = 0.0; // Clock high to output Low Z
     parameter tCKHZ  = 4.0; // Clock high to output High Z
     parameter tCKLZ  = 1.0; // Clock high to output Low Z // let it as itis
     parameter tSINTmin  = 0.5; // Clock to int set time
     parameter tRINTmin  = 0.5; // Clock to int reset time
     parameter tSINT  = 6.7; // Clock to int set time
     parameter tRINT  = 6.7; // Clock to int reset time
     
     
     // Port to Port Delays
     parameter tCCS      = 5.2; // Clock to Clock setup time 
     parameter tRS       = 5.0; //7.0; // Master Reset Pulse width
     parameter tRSS      = 6.0; // Master reset setup time
     parameter tRSR      = 6.0; // master reset recovery time
     parameter tRSF      = 10.0; //2.0; // Master reset to Output inactive
     parameter tRScntint = 10.0; //5.8; // Master reset to counter interrupt Flag reset time
     
     parameter tSC    = 2.3; // Address setup time
     parameter tHC    = 0.6; // Address hold time
     parameter tSAD    = 2.3; // Address setup time
     parameter tHAD    = 0.6; // Address hold time
     parameter tSCN    =  2.3; // Address setup time
     parameter tHCN    = 0.6; // Address hold time
     parameter tSCM    =  2.3; // Address setup time
     parameter tHCM    = 0.6; // Address hold time
     parameter tSRST    = 2.3; // Address setup time
     parameter tHRST    = 0.6; // Address hold time
     parameter tCA2     = 4.0; //4.4; //
     parameter tCM2     = 4.0; //4.4; //
     parameter tSCINTmin   = 0.5;
     parameter tRCINTmin   = 0.5; 
     parameter tSCINT   = 5.0;
     parameter tRCINT   = 5.0; 

`endif 

 `ifdef FREQ100    
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
     parameter tRScntint = 10.0; // Master reset to counter interrupt Flag reset time
     
     parameter tSC    = 3.0; // Address setup time
     parameter tHC    = 0.6; // Address hold time
     parameter tSAD    = 3.0; // Address setup time
     parameter tHAD    = 0.6; // Address hold time
     parameter tSCN    = 3.0; // Address setup time
     parameter tHCN    = 0.6; // Address hold time
     parameter tSCM    = 3.0; // Address setup time
     parameter tHCM    = 0.6; // Address hold time
     parameter tSRST    = 3.0; // Address setup time
     parameter tHRST    = 0.6; // Address hold time
     parameter tCA2     = 4.4; //
     parameter tCM2     = 4.4;
     parameter tSCINTmin   = 3.0;
     parameter tRCINTmin   = 0.5; 
     parameter tSCINT   = 3.0;
     parameter tRCINT   = 5.0; 

`endif 



//===============================End OF FILE ==================================
















