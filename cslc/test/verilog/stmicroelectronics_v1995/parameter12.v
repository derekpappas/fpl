// Author: Hugues CREUSY
// FEBRUARY 2004
// Verilog model
// project: M25P80 40 MHz,
// release: 1.1



// These Verilog HDL models are provided "as is" without warranty
// of any kind, included but not limited to, implied warranty
// of merchantability and fitness for a particular purpose.





//`timescale  1ns/1ns

`define SIZE               4194304*2   // 8Mbit
`define PLENGTH            256         // page length 256 bytes
`define SSIZE              524288      // Sector size 512 kbits
`define NB_BPI             3           // number of BPi bits
`define SIGNATURE          8'h13       // electronic signature 13h
`define BIT_TO_CODE_MEM    20          // number of bit to code a 8Mbits memory
`define LSB_TO_CODE_PAGE   8           // number of bit to code a PLENGTH page

`define NB_BIT_ADD_MEM              24
`define NB_BIT_ADD                  8
`define NB_BIT_DATA                 8
`define TOP_MEM                     (`SIZE/`NB_BIT_DATA)-1

`define MASK_SECTOR        24'hFF0000   // anded with address to find first sector adress to erase

`define   TRUE    1'b1
`define   FALSE   1'b0


`define TC     25          // Minimum Clock period
`define TR     50          // Minimum Clock period for read instruction
`define TSLCH  5          // notS active setup time (relative to C)
`define TCHSL  5          // notS not active hold time
`define TCH    11          // Clock high time
`define TCL    11          // Clock low time
`define TDVCH  2           // Data in Setup Time
`define TCHDX  5           // Data in Hold Time
`define TCHSH  5          // notS active hold time (relative to C)
`define TSHCH  5          // notS not active setup  time (relative to C)
`define TSHSL  100            // /S deselect time
`define TSHQZ  9          // Output disable Time
`define TCLQV  9          // clock low to output valid
`define THLCH  5          // NotHold active setup time
`define TCHHH  5          // NotHold not active hold time
`define THHCH  5          // NotHold not active setup time
`define TCHHL  5          // NotHold active hold time
`define THHQX  9          // NotHold high to Output Low-Z
`define THLQZ  9          // NotHold low to Output High-Z
`define TWHSL  20          // Write protect setup time (SRWD=1)
`define TSHWL  100         // Write protect hold time (SRWD=1)

`define TDP    3000        // notS high to deep power down mode
`define TRES1  3000        // notS high to Stand-By power mode w-o ID Read
`define TRES2  1800        // notS high to Stand-By power mode with ID Read
`define TW     15000000    // write status register cycle time (15ms)
`define TPP    5000000     // page program cycle time (5ms)
`define TSE    3      // sector erase cycle time (3s)
`define TBE   20     // bulk erase cycle time (20s)
`define Tbase  1000000000  // time base for Bulk and Sector ERASE, delay function limited to signed 32bits values 
