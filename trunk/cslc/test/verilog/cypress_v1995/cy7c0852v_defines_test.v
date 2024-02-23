//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2000 SPIKE TECHNOLOGIES INC.
//                           ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0852v_defines_test.v
//
// Author       : Archana
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : Definitions file for testbench 
//
// Notes        : First Release
//
// Modification History:
// Date              By       Version     Change Description
// ==========================================================================
// 03/09/2001      Archana      1.0         First Release
//
//
//
//
// ==========================================================================


// variables for the master reset timings.
// *************************************************************************
`define INIT_RESET 10
`define tRS        10         //Master reset pulse width 
`define tRSF       8.2 //8         //Master reset to outputs inactive
`define tRSS       8.5       //Master reset set-up time
`define tRSS_1     7.5       //Master reset general test time
`define tRSR       10        //Master reset recovery time
`define tRSR_1     8        //Master reset recovery time
`define tRScntint  8   //Master reset to counter interrupt flag reset time
// *************************************************************************
// varibles for the read cycle
`define tSC   3.0 
`define tHC   0.5
`define tSB   3.0
`define tHB   0.5
`define tSW   3.0
`define tHW   0.5
`define tSA   3.0
`define tHA   0.5

`define tSD   3              //input Data setup time
`define tHD   0.5            //input data hold time
`define tSAD  3             //Address strobe setup time 
`define tHAD  0.5           //Address strobe Hold time 
`define tSCN  3             //#CNTEN Setup time
`define tHCN  0.5           //#CNTEN Hold time
`define tSRST 3            //#CNTRST setup time  
`define tHRST 0.5          //#CNTRST Hold time     
`define tSCM  3            //CNT/#MSK setup time
`define tHCM  0.5          //CNT/#MSK hold time
`define INIT_DELAY_OE  4

`define tSCINT  6.8  
`define tRCINT  6.8       

`define tCYC2 10 //
`define tCH2  5.0 //4.0
`define tCL2  5.0 //4.0 
`define tSC_1 2.8 
`define tHC_1 0.4
`define tSB_1 2.8
`define tHB_1 0.4
`define tSW_1 3.1
`define tHW_1 0.4
`define tSA_1 3.1
`define tHA_1 0.4
`define tSD_1 3.1            //input Data setup time
`define tHD_1 0.4            //input data hold time
`define tSAD_1  3.1          //Address strobe setup time 
`define tHAD_1  0.4          //Address strobe Hold time 
`define tSCN_1  3.1          //#CNTEN Setup time
`define tHCN_1  0.4          //#CNTEN Hold time
`define tSRST_1 3.1          //#CNTRST setup time  
`define tHRST_1 0.4          //#CNTRST Hold time     
`define tSCM_1  3.1          //CNT/#MSK setup time
`define tHCM_1  0.4          //CNT/#MSK hold time
`define MSGDLY  20            // delay message delay.

`define ADDR_MSB        16
`define ADDR_MSB_1      17
`define DATA_MSB        35




`define DATA_MSB_1      36
`define BYTE_MSB        3
`define BYTE_MSB_1      4
`define BYTE_1          9
`define BYTE_2          18
`define BYTE_3          27
`define BYTE_4          36
`define CHECK_ADDR_DATA 4'b0001
`define CHECK_DATA      4'b0010
`define CHECK_RDnWR     4'b0011
`define CHECK_CE0       4'b0100
`define CHECK_CE1       4'b0101
`define CHECK_ADS       4'b0110
`define CHECK_CNTEN     4'b0111
`define CHECK_CNTRST    4'b1000
`define CHECK_CNTINT    4'b1001
`define CHECK_OE        4'b1010
`define CHECK_CNTnMSK   4'b1011
`define CHECK_ALL       4'b1100
`define RIGHT_PORT      2'b00//cahnge aug 20
`define LEFT_PORT       2'b01//cahnge aug 20
`define COLLISION       2'b10//cahnge aug 20

`define LEFT_T          1'b0
`define RIGHT_T         1'b1
`define READ_T          1'b0
`define WRITE_T         1'b1
  `define tDC  1.1  
`define tSINT  7.5          //CLK to /INT Set time
`define tRINT  7.5          //CLK to /INT Rset time
`ifdef ZERODELAY

// delays made zero here...
 `define tOHZ 0.1  
 `define tOLZ 0.1 
 `define tOE  0.1  
 `define tCM2 0.1  
 `define tCA2 0.1  
 `define tCD2 0.1  
 `define tCKLZ 0.1 
 `define tCKHZ 0.1 
 `define tCCS  0.5

`else

 `define tOHZ 5.1
 `define tOLZ 0.1
 `define tOE  5.1
 `define tCM2 5.0
 `define tCA2 5.0
 `define tCD2 5.1
 
 `define tCKLZ 1.1
 `define tCKHZ 5.1
 `define tCCS  8.0
`endif












