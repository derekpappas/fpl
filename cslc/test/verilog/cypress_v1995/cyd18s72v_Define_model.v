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
// Creation date :May, 06, 2003
// -----------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : May, 06, 2003
// -----------------------------------------------------------------------------
// Dependencies : None
// Description  : This file contains the model parameters such as data bus width, memory size
// Simulation Notes : <Any special simulation notes>
// Application Note : <Application note for the structures>
// Simulator : verilog xl.
// Terms & concepts : NA
// Open issues and future enhancements : None
// References : <Details of the references>
// Revision History :
// Rev Author Phone Date Changes
// -----------------------------------------------------------------------------
// <Name> <number> <Date> <details>
// -----------------------------------------------------------------------------

// size definitions
`define LAST_ADR           262143        // memory size => 256 K
`define AD_M               17            // addr width  => 18
`define DT_M               71            // data width  => 72
`define BT_M               7             // byte width  =>  8

`define AD_S               18            // addr width  => 18
`define DT_S               72            // data width  => 72
`define BT_S               8             // byte width  => 8



// Reset definitions
`define START              1'b1               
`define STOP               1'b0

// Port names
`define LEFT               1'b1  
`define RIGHT              1'b0

// RAM array operations
`define READ               1'b1  
`define WRITE              1'b0

`define BYTE_SIZE          9            
`define reset_count        5   

`include "cyd18s72v_Config_model.v"
//=====================================End OF File==================================================
