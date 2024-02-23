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
// File         : cy7c0832v_Define_model.v
//
// Author       : Chandrakant Umate and Nandu Thakar
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : This file describes definitions required for modelling.
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

// size definitions
`define LAST_ADR           262143        // memory size => 256 K
`define AD_M               17            // addr width  => 18
`define DT_M               17            // data width  => 18
`define BT_M               1             // byte width  => 2

`define AD_S               18            // addr width  => 18
`define DT_S               18            // data width  => 18
`define BT_S               2             // byte width  => 2

`define UNMASK_ALL         18'h3FFFF    // Unmask all bits of mask reg

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
            
