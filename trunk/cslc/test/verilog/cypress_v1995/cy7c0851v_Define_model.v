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
// File         : cy7c0851v.v
//
// Author       : Chandrakant Umate
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : This is a Verilog Behavioral timing model for
//                Cypress cy7c0851v, 64 K x 36 Synchronous Dual Port RAM.
//
// Notes        : First Release
//
// Datasheet    : Cypress cy7c0851v, 3.3V 64K x 36 Synchronous Dual Port RAM,
//                (January 22, 2001)
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


// size definitions
`define LAST_ADR           65535         // memory size => 64 K
`define AD_M               15            // addr width  => 16
`define DT_M               35            // data width  => 36
`define BT_M               3             // byte width  => 4
`define BITSPL             9             // Bits Per Line => 9
`define AD_S               16            // addr width  => 16
`define DT_S               36            // data width  => 36
`define BT_S               4             // byte width  => 4

`define UNMASK_ALL         16'hFFFF    // Unmask all bits of mask reg

// Reset definitions
`define START              1'b1               
`define STOP               1'b0

// Port names
`define LEFT               1'b1  
`define RIGHT              1'b0

// RAM array operations
`define READ               1'b1  
`define WRITE              1'b0

// Mask and counter register operations
`define NONE               4'h1              
`define MASKLD             4'h2              
`define MASKRD             4'h3              
`define CNTRST             4'h4              
`define CNTLD              4'h5              
`define CNTRD              4'h6              
`define CNTINC             4'h7              
`define CNTHLD             4'h8              
            