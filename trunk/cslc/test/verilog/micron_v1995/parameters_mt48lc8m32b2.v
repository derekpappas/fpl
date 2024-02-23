/****************************************************************************************
*
*   [Disclaimer]    
*   This software code and all associated documentation, comments
*   or other information (collectively "Software") is provided 
*   "AS IS" without warranty of any kind. MICRON TECHNOLOGY, INC. 
*   ("MTI") EXPRESSLY DISCLAIMS ALL WARRANTIES EXPRESS OR IMPLIED,
*   INCLUDING BUT NOT LIMITED TO, NONINFRINGEMENT OF THIRD PARTY
*   RIGHTS, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS
*   FOR ANY PARTICULAR PURPOSE. MTI DOES NOT WARRANT THAT THE
*   SOFTWARE WILL MEET YOUR REQUIREMENTS, OR THAT THE OPERATION OF
*   THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE. FURTHERMORE,
*   MTI DOES NOT MAKE ANY REPRESENTATIONS REGARDING THE USE OR THE
*   RESULTS OF THE USE OF THE SOFTWARE IN TERMS OF ITS CORRECTNESS,
*   ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT
*   OF USE OR PERFORMANCE OF THE SOFTWARE REMAINS WITH YOU. IN NO
*   EVENT SHALL MTI, ITS AFFILIATED COMPANIES OR THEIR SUPPLIERS BE
*   LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR
*   SPECIAL DAMAGES (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS
*   OF PROFITS, BUSINESS INTERRUPTION, OR LOSS OF INFORMATION)
*   ARISING OUT OF YOUR USE OF OR INABILITY TO USE THE SOFTWARE,
*   EVEN IF MTI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
*   Because some jurisdictions prohibit the exclusion or limitation
*   of liability for consequential or incidental damages, the above
*   limitation may not apply to you.
*   
*   Copyright 2005 Micron Technology, Inc. All rights reserved.
*   
****************************************************************************************/

// Timing parameters based on Speed Grade

                                          // SYMBOL UNITS DESCRIPTION
                                          // ------ ----- -----------
`ifdef sg6                                //              Timing Parameters for -6 (CL = 3)
    parameter tAC3 =   5.5;	
    parameter tAC2 =   7.5;     
    parameter tHZ3 =   5.5;
    parameter tHZ2 =   7.5;
    parameter tOH  =   2.0;
    parameter tMRD =   2.0;     // 2 Clk Cycles
    parameter tRAS =  42.0;
    parameter tRC  =  60.0;
    parameter tRCD =  18.0;
    parameter tRFC =  60.0;
    parameter tRP  =  18.0;
    parameter tRRD =  12.0;
    parameter tWRa =   6.0;     // A2 Version - Auto precharge mode (1 Clk + 7 ns)
    parameter tWRm =  12.0;     // A2 Version - Manual precharge mode (14 ns)
`else 
`ifdef sg7                          //              Timing Parameters for -75 (CL = 3)
    parameter tAC3 =   6.0;
    parameter tAC2 =   8.0;
    parameter tHZ3 =   6.0;
    parameter tHZ2 =   8.0;
    parameter tOH  =   2.5;
    parameter tMRD =   2.0;     // 2 Clk Cycles
    parameter tRAS =  42.0;
    parameter tRC  =  70.0;
    parameter tRCD =  20.0;
    parameter tRFC =  70.0;
    parameter tRP  =  20.0;
    parameter tRRD =  14.0;
    parameter tWRa =   7.0;     // A2 Version - Auto precharge mode (1 Clk + 7 ns)
    parameter tWRm =  14.0;     // A2 Version - Manual precharge mode (14 ns)
`endif 
`endif 

