/////////////////////////////////////////////////////////////////////////////////////////
//
// File:           - M45PE10_Macro.v
// Date:           - July 2004
// Author:         - Xue-feng Hu at MPG Memory Competence Center of China
// Description:    - Define macro regarding characteristics of M45PE10 SPI flash memory 
// Revision:       - Version 1.3
// Quotation:      - No bugs, all are features. 
//
/////////////////////////////////////////////////////////////////////////////////////////
// Revision History     Description
//             0.9:     2004/3/15 1st Release
//             1.0:     2004/3/26 build a new "Macro" file for M45PE10
//             1.1:     2004/4/30 modify the behavior of "PAGE_WRITE" and "PAGE_PROGRAM"
//             1.2:     2004/5/28 correct the behavior of "RESET"
//             1.3:     2004/7/28 update the "Sector Erase Cycle Time"
//
/////////////////////////////////////////////////////////////////////////////////////////
//
// LIMITATION OF LIABILITY: 
// NEITHER STMicroelectronics NOR ITS VENDORS OR AGENTS SHALL 
// BE LIABLE FOR ANY LOSS OF PROFITS, LOSS OF USE, LOSS OF
// DATA, INTERRUPTION OF BUSINESS, NOR FOR INDIRECT, SPECIAL, 
// INCIDENTAL OR CONSEQUENTIAL DAMAGES OF ANY KIND WHETHER 
// UNDER THIS AGREEMENT OR OTHERWISE, EVEN IF ADVISED OF THE 
// POSSIBILITY OF SUCH DAMAGES.
//
// Copyright 2003, STMicroelectrons Corporation, All Rights Reserved.
//
/////////////////////////////////////////////////////////////////////////////////////////
//modiffications by GabrielD at BigSurSoftware
//`timescale 1ns/1ns

//=======================================================================================
//                          M45PE10(*)      M45PE20         M45PE40         M45PE80
//=======================================================================================
//MEMORY_SIZE               128KB           256KB           512KB           1MB
//MEM_ADDR_BITS             17              18              19              20
//PAGES                     512             1024            2048            4096
//PAGE_SIZE                 256B            256B            256B            256B
//PAGE_ADDRESS              9               10              11              12
//PAGE_OFFSET_BITS          8               8               8               8
//SCETORS                   2               4               8               16
//SECTOR_SIZE               64KB            64KB            64KB            64KB
//SECTOR_ADDR_BITS          1               2               3               4
//SECTOR_OFFSET_BITS        16              16              16              16
//=======================================================================================
`define DATA_BITS           8
`define MEM_SIZE            131072          //1M bits = 128K bytes
`define MEM_ADDR_BITS       17              //memory address bits
`define PAGES               512             //512 pages
`define PAGE_SIZE           256             //256 bytes in each page
`define PAGE_ADDR_BITS      9               //page address bits
`define PAGE_OFFSET_BITS    8               
`define SECTORS             2               //2 sectors
`define SECTOR_SIZE         65536           //64K bytes in each sector
`define SECTOR_ADDR_BITS    1
`define SECTOR_OFFSET_BITS  16

//////////////////////////////////////////
//Power-Up Timing
//////////////////////////////////////////
`define tVSL                30000           //Vcc(min) to /s low is 30us
`define tPUW_MIN            1000000         //Time delay before the first Write, Program or Erase instruction; Min. is 1ms
`define tPUW_MAX            10000000        //Max. is 10ms

//////////////////////////////////////////
//AC Characteristics
//////////////////////////////////////////
`define tC                  40              //Clock cycle for all instructions except read instruction
`define tCH                 20
`define tCL                 20
`define tR                  50              //Clock cycle for read instruction
`define tRH                 25
`define tRL                 25
`define tSLCH               10              //S Active Setup Time(relative to C)
`define tCHSL               10              //S Not Active Hold Time(relative to C)
`define tDVCH               5               //Data In Setup time
`define tCHDX               5               //Data In Hold time
`define tCHSH               10              //S Active Hold Time(relative to C)
`define tSHCH               10              //S Not Active Setup Time(relative to C)
`define tSHSL               200             //S Deselect Time
`define tSHQZ               15              //Output Disable Time
`define tCLQV               15              //Clock Low to Output Valid
`define tCLQX               0               //Output Hold Time
`define tRLRH               10000           //Reset Pulse Width is 10us
`define tRHSL               3000            //Reset Recovery Time is 3us
`define tSHRH               10              //Chip should have been deselected before reset is de-asserted
`define tWHSL               50              //Write Protect Setup Time
`define tSHWL               100             //Write Protect Hold Time
`define tDP                 3000            //S to Deep Power Down
`define tRDP                30000           //S High to Standby Mode
`define tPW_MAX             25000000        //Page Write Cycle Time
`define tPP_MAX             5000000         //Page Program Cycle Time
`define tPE_MAX             20000000        //Page Erase Cycle Time
`define tSE_MAX             5e9             //Sector Erase Cycle Time
