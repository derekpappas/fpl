
//
//
// PROG_INC.H
//
// This is the configuration file for the FPGA
// programmer
//

// AN = address bus width.
// 2^AN is the total configuration memory
// required by your FPGA.
// For example:
//     DEVICE         CONF MEM SIZE  AN
//     Altera 10K20     32KByte      15
`define AN  15 


// CD = Clock divider
// Define CD such that:
//  ( main_system_clock / 2^CD ) < 1MHz
// For example, if the main sys clock 
// is 25MHz, then CD is 5, since
// 25MHz/32 < 1MHz 
`define CD 5
