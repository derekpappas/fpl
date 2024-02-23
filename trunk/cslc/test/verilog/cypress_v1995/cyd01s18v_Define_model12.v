// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name : Common Defines 
// Version : <0.1>
// Status : <Module is Complete>
// -----------------------------------------------------------------------------
// Author : Ashlesha Gokhale 
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date :April, 08, 2004
// -----------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : April, 08, 2004
// -----------------------------------------------------------------------------
// Dependencies : None
// Description  : This file contains the model parameters such as data bus width,
//                 memory size
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl 2.2 , vsim 5.7d
// Terms & concepts : NA
// Open issues and future enhancements : None
// References : <Details of the references>
// Revision History :
// Rev Author     Phone     Date            Changes
// -----------------------------------------------------------------------------
// 0.1 Ashlesha   22933700  April 8, 2004   New File
// -----------------------------------------------------------------------------

// size definitions

`include "cyd01s18v_config_model.v"

/*`define LAST_ADR           65535         // memory size => 64K 
`define AD_M               15            // addr width  => 16
`define DT_M               17            // data width  => 18
`define BT_M               1             // byte width  =>  2

`define AD_S               16            // addr width  => 16
`define DT_S               18            // data width  => 18
`define BT_S               2             // byte width  => 2
*/


// Reset definitions
`define START              1'b1               
`define STOP               1'b0

// Port names
`define LEFT               1'b1  
`define RIGHT              1'b0

// RAM array operations
`define WRITE              3'b000
`define READ               3'b001

  
`define COUNTERLOAD        3'b010
`define COUNTERREADBACK    3'b011

`define MASKRESET          3'b100
`define MASKLOAD           3'b101
`define MASKREADBACK       3'b110
`define NOP                3'b111

`define BYTE_SIZE          9            
`define reset_count        5   


//=====================================End OF File=============================//









