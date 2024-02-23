/*=============================================================================
* Copyright(c) Samsung Electronics Co., 1997,1998. All rights reseved.
*
* Verilog Behavioral Model of Synchronous Mobile SDRAM
*
* Description : This is a synchrounous high data rate DRAM,
*               fabricated with SAMSUNG's high performance
*               CMOS technology.
*
* Revision No. : V4.5
* date         : Jan. 21. 2002
*
*===============================================================================*/

`define M64
`define MOB30V
`define LVTTL
`define NBANK4
`define X32


`ifdef MOB25V  //2.5V Mobile 
    `ifdef LVTTL //M64+G7
	`ifdef S75 //M64+G7+LVTTL
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSAC1   16			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   16			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S75
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`ifdef S15 //M64+G7+LVTTL
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3.5			// input setup time	
	    `define tSH     2			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif //end of LVTTL
`endif //end of MOB25V
`ifdef MOB30V  //2.5V Mobile 
    `ifdef LVTTL //M64+G7
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S75
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of LVTTL
`endif //end of MOB25V
`ifdef D19X32
     `ifdef X32
	`ifdef LVTTL
	`ifdef V30
	`ifdef S70 
	    `define tCCmin  7			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     1.75		// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    21			// ras to cas delay(min)
	    `define tRP     21			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7			// col. address to col. address delay:
	    `define tSAC3   5.5			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   5.5			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S70
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     80			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S80
	`ifdef S10 //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     100			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S10
	`endif //end of V30
	`ifdef V25 //
	`ifdef S70 //
	    `define tCCmin  7			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     1.75		// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    21			// ras to cas delay(min)
	    `define tRP     21			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7			// col. address to col. address delay:
	    `define tSAC3   5.5			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   5.5			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S70
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     80			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S80
	`ifdef S10 //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     100			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S10
	`endif //end of V25
	`endif //end of LVTTL
	`endif //end of X32
`endif //end of D19X32
`ifdef DDP
    `ifdef LVTTL
    `ifdef M128
   	`ifdef X32
	`ifdef S70 //
	    `define tCCmin  7.0			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.0			// clock minimun cycle time at cas latency=3
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    14			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 49			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	`endif //end of S70
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.5			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S75
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     3			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     3			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of X32
	`endif //end of 128M
   `ifdef M512 //
	`ifdef X32 //
	`ifdef V25 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1L //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1L
	`ifdef S15 //
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3.5			// input setup time	
	    `define tSH     2.0			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif //end of V25
	`ifdef V30 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of V25
	`endif //end of X32
	`ifdef X16 //
	`ifdef V25 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1L //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1L
	`ifdef S15 //
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3.5			// input setup time	
	    `define tSH     2.0			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif //end of V25
	`ifdef V30 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of V25
	`endif //end of X16
	`endif //end of 512M
	`endif //LVTTL
`endif //end of DDP
`ifdef MSD //1.8V D17
	`ifdef LVTTL
	`ifdef NOR
	`ifdef S1L //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`ifdef S15 //
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     4			// input setup time	
	    `define tSH     2			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif // end of NOR
	`ifdef NOK // for NOKIA
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	`endif //end of S75
	`endif //end of NOK
	`endif //end of LVTTL
`endif //end of MSD

	
	
	
/*==================================================================
 * Copyright(c) Samsung Electronics Co., 1997,1998. All rights reseved.
 *
 * Verilog Behavioral Model of Synchronous DRAM 
 *
 * Device: -  16M SDRAM(2nd Gen., 3rd Gen., 4th Gen., 5th Gen.) 
 *	   -  64M SDRAM(2nd Gen., 3rd Gen., 4th Gen., 5th Gen.)
 *	   - 128M SDRAM(1st Gen., 2nd Gen.,)
 *	   - 256M SDRAM(2nd Gen.)
 *
 * Description : This is a synchrounous high data rate DRAM, 
 *		 fabricated with SAMSUNG's high performance  
 *               CMOS technology.                                
 *
 * Developer   : Jae-Ha Kim.
 *  		 CAE Team. Semiconductor R&D Centor. 
 *		 Semiconductor Division. Samsung Electronics Co.
 *
 * Revision    : Yong-Cheol Bae. ( e-mail: jjbae@samsung.co.kr )
 * 1.0~2.3	 DRAM2 Design. Semiconductor R&D Centor. 
 *		 Semiconductor Division. Samsung Electronics Co.
 * Revision    : Kyung-Woo Nam. ( e-mail: aboverim@samsung.co.kr )
 * 3.0~		 DRAM2 Design. Semiconductor R&D Centor. 
 *		 Semiconductor Division. Samsung Electronics Co.
 *==================================================================
 * Revision No. : V2.3 
 * date		: Aug. 20. 1997
 *		: Oct. 22. 1997
 *		: Jan. 15. 1998   - 16M 4Gen. & 64M 3Gen. spec update
 *		: Jun. 30. 1998   - 16M 4Gen. & 64M 3Gen. & 2Mx32 & 
 *		                  128M 1Gen. & 256M 2Gen. AC spec update
 *		: Oct. 08. 1998   - all-bank precharge revision
 *		                  bank note change: ba0=MSB,ba1=LSB @ 4banks
 *		: Nov. 18. 1998   - option set for verbose (e.g. +define+v )
 *		                  128M 2Gen. AC spec added. 
 *                                conformed model through verilog-XL 2.6.27 
 * Revision No. : V3.0 
 * date		: Apr. 07. 1999   - tRDL=2
 *			1. parameterize auto-precharge address : ADDR_AP
 *			2. divide auto-precharge process read/write
 *			3. divide precharge_flag_kill process normal/read_autopre/write_autopre
 *			4. generate wr_autoprecharge2 process excuting when tRDL=2
 *			5. modify same-bank-autoprecharge-disable function
 *			   (disable gapless, other bank interrupt case)
 * Revision No. : V3.1 
 * date         : May. 19. 1999  
 *			1. Add 16M 5th Gen. LVTTL(-10,-8,-8.7,-7,-6)
 *			2. Modify 2Mx32 5th Gen. tSAC value
 * Revision No. : V3.2 
 * date         : Jun. 11. 1999  
 *			1. Modify -A AC parameter(64M 5th, 128M 2th, 256M 2th)
 * Revision No. : V3.3 
 * date         : Jun. 24. 1999  
 *			1. After 64MSD3, auto_flagx signal is not used, 
 *			   let auto_flagx be not enabled to device which is after 64MSD3
 *			2. compile new versions 
 *			   verilog-xl : 2.7.17, NC-verilog : 2.1., VCS : 5.0.1a
 * Revision No. : V3.4 
 * date         : Jul. 12. 1999  
 *			1. To prevent roundoff error in AC parameter violation check procedure,
 *			   define MARGIN paramter. (MARGIN=0.1ns now)
 * Revision No. : V3.5 
 * date         : Sep. 28. 1999  
 *			1. Warning message 'tCCmax violation' is appeared during self refresh operation.
 *			   When self refresh or precharge-power down, clk can be don't care state. (can stay 'low' or 'high'-level)
 *                         Therefore tCCmax violation should not be checked during self refresh or prech. power down.
 * Revision No. : V3.6 
 * date         : Dec. 14. 1999  
 *			1. Make MODELSIM version and add partial REF./VREFi change function for NOKIA
 * Revision No. : V3.7 
 * date         : Jul. 11. 2000  
 *			1. Add dynamic memory allocation function using VERILOG-XL PLI,
 *			   then you must build verilog-XL excutable file containing PLI, and use +define+DYMEM option.
 * Revision No. : V3.8 
 * date         : Jul. 13. 2000  
 *			1. Add 128M SDRAM 3rd/4th Gen., 256M SDRAM 3rd Gen.
 * Revision No. : V3.9
 * date         : Feb. 5. 2001
 *                      1. remove CL2 parameter at -A, -7,... when violated, error messages are printed.
 * Revision No. : V4.0
 * date         : Jun. 11. 2001
 *                      1. 128M SDRAM X32 MCP (64M SDRAM X16 7th) parameter added
 * Revision No. : V4.1
 * date         : Jun. 23. 2001
 *                      1. 256M SDRAM 4th parameters are added
 * Revision No. : V4.2
 * date         : Jul. 31. 2001
 *                      1. because array of reg is not work at vcs 6.0, change array of reg to real variable (TRAS_PP, TPRE_P)
 * Revision No. : V4.3
 * date         : Aug. 09. 2001
 *                      1. There is an error that use "<" instead of ">", in tRASmax violation check routine.
 * Revision No. : V4.4
 * date         : Oct. 05. 2001
 *                      1. Add 128M Mobile SDRAM 5th Gen. (8Mx16, D-die)
 *                      2. Add 64M Mobile SDRAM 7th Gen. (2Mx32, F-die)
 * Revision No. : V4.5
 * date         : Nov. 23. 2001
 *                      1. Add mobile function (EMRS:PASR/TCSR/DSC, DPD:pin/cmd control)
 * Revision No. : V4.6
 * date         : Jan. 15. 2002
 *                      1. Add 512M SDRAM
 *==================================================================
 */

`timescale    1ns / 10ps
 
`define K1	1024
`define M1	1048576
`define BYTE	8
    

`ifdef CS2
    `ifdef DPD_PIN
        module sdram_cs2(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
    `else
        module sdram_cs2(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi);
    `endif
`else
    `ifdef DPD_PIN
        module sdram(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
    `else
        module sdram(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi);	//default port name
    `endif
`endif

    `ifdef M16
	`define TBITS	16*`M1
	`define nBank	2
        `define ADDRTOP	10
	`define	ADDR_AP	10
        `ifdef G2
                `define M16G2_M641G
	`else
                `define M16G3_M64G2
                `define M64G3_M128_M256
        `endif
    `endif

    `ifdef M64
	`define TBITS		64*`M1
	`define	ADDR_AP	10
    	`ifdef NBANK2
      	    `define nBank	2	
	    `ifdef X32
	    	`define ADDRTOP	11
	    `else
            	`define ADDRTOP	12
	    `endif
    	`endif
        `ifdef NBANK4
     	    `define nBank	4	
	    `ifdef X32
            	`define ADDRTOP	10
	    `else
	    	`define ADDRTOP	11
	    `endif
    	`endif
                `define M64_M128_M256    // for prech_reg 
        `ifdef G1
                `define M16G2_M641G
        `else
        `ifdef G2
                `define M16G3_M64G2
        `else
                `define M16G4_M64G3
                `define M64G3_M128_M256
        `endif
        `endif
    `endif

    `ifdef M128
	`define TBITS	128*`M1
	`define nBank	4
        `define ADDRTOP	11
	`define	ADDR_AP	10
        `define M64_M128_M256    // for prech_reg 
	`define M128_M256        // RFU, c_addr 10->11 
        `define M64G3_M128_M256  // from M64G3
        `define M16G4_M64G3
    `endif
    `ifdef M256
	`define TBITS	256*`M1
	`define nBank	4
        `define ADDRTOP	12
	`define	ADDR_AP	10
        `define M64_M128_M256    // for prech_reg 
	`define M128_M256        // RFU, c_addr 10->11 
        `define M64G3_M128_M256  // from M64G3
        `define M16G4_M64G3
    `endif

    `ifdef M512
	`define TBITS	512*`M1
	`define nBank	4
        `define ADDRTOP	12
	`define	ADDR_AP	10
        `define M64_M128_M256    // for prech_reg 
	//`define M128_M256        // RFU, c_addr 10->11 
        `define M64G3_M128_M256  // from M64G3
        `define M16G4_M64G3
    `endif

`ifdef M512
    `ifdef X4
	`define M512_X4
        `define B		4
        `define nCOL		12
        `define	PAGEDEPTH	4096
        `define nDQM		1
    `endif
    `ifdef X8
	`define M512_X8
        `define B		8
        `define nCOL		11
        `define	PAGEDEPTH	2048
        `define nDQM		1
    `endif
    `ifdef X16
        `define B		16
        `define nCOL		10
        `define	PAGEDEPTH	1024
        `define nDQM		2
    `endif
`else
`ifdef M128_M256
    `ifdef X4
    	`define M128_M256_X4			// 98.6.30 BYC
    	`define B		4		// number of bit(x4)
    	`define nCOL		11
    	`define PAGEDEPTH	2048
	`define nDQM		1
    `endif
    `ifdef X8
        `define B		8		// number of bit(x8)
    	`define nCOL		10
    	`define PAGEDEPTH	1024
    	`define nDQM		1
    `endif
    `ifdef X16
    	`define B		16		// number of bit(x16)
    	`define nCOL		9
    	`define PAGEDEPTH	512
	`define nDQM		2
    `endif
    `ifdef X32
    	`define B		32		// number of bit(x32)
    	`define nCOL		8
    	`define PAGEDEPTH	256
	`define nDQM		4
    `endif
`else
    `ifdef X4
    	`define B		4		// number of bit(x4)
    	`define nCOL		10
    	`define PAGEDEPTH	1024
	`define nDQM		1
    `endif
    `ifdef X8
        `define B		8		// number of bit(x8)
    	`define nCOL		9
    	`define PAGEDEPTH	512
    	`define nDQM		1
    `endif
    `ifdef X16
    	`define B		16		// number of bit(x16)
    	`define nCOL		8
    	`define PAGEDEPTH	256
	`define nDQM		2
    `endif
    `ifdef X32
    	`define B		32		// number of bit(x32)
    	`define nCOL		8
    	`define PAGEDEPTH	256
	`define nDQM		4
    `endif
`endif
`endif

`ifdef tCC1
`else
	`define NO_CL1
`endif
`ifdef tSAC1
`else
	`define NO_CL1
`endif
`ifdef tSHZ1
`else
	`define NO_CL1
`endif
`ifdef tCC2
`else
	`define NO_CL2
`endif
`ifdef tSAC2
`else
	`define NO_CL2
`endif
`ifdef tSHZ2
`else
	`define NO_CL2
`endif
`ifdef tCC3
`else
	`define NO_CL3
`endif
`ifdef tSAC3
`else
	`define NO_CL3
`endif
`ifdef tSHZ3
`else
	`define NO_CL3
`endif

`ifdef	tRDL
`else
	`define	tRDL	1
`endif

`ifdef DPD_CMD
	`define DPD
`endif
`ifdef DPD_PIN
	`define DPD
`endif

  `define HB		`B/2
  `define BIT		`B-1:0
  `define BIT_C		`nCOL-1:0
  `define BIT_T		`nCOL+`ADDRTOP:0
  `define nWORD		`TBITS/`B/`nBank
  `define WORD		`nWORD-1:0
  
  inout   [`BIT]  dqi;
  input   [`nBank/2-1:0] ba;
  input   [`ADDRTOP:0]  ad;
  input   rasb,casb,web;
  input   clk,cke,csb;
  input   [`nDQM-1:0] dqm;
`ifdef DPD_PIN
  input   dpdb;
`endif
  
/*
  `ifdef M64
    	`include "m64.ac"
  `endif
  `ifdef M16
    	`include "m16.ac"
  `endif
  `ifdef M128
    	`include "m128.ac"
  `endif
  `ifdef M256
    	`include "m256.ac"
  `endif
*/

  parameter       pwrup_time = 200000, pwrup_check = 0;

wire     [`nBank/2 + `ADDRTOP : 0] addr;
assign addr = {ba, ad};

wire	[`BIT]	dqi;
`ifdef DYMEM
initial begin
	$damem_declare("mem_a", `B-1, 0, `nWORD-1, 0);
	$damem_declare("mem_b", `B-1, 0, `nWORD-1, 0);
end
`else
reg		[`BIT]	mem_a[`WORD];	// memory cell array of a bank
reg		[`BIT]	mem_b[`WORD];	// memory cell array of b bank
`endif
`ifdef NBANK4
`ifdef DYMEM
initial begin
	$damem_declare("mem_c", `B-1, 0, `nWORD-1, 0);
	$damem_declare("mem_d", `B-1, 0, `nWORD-1, 0);
end
`else
reg		[`BIT]	mem_c[`WORD];	// memory cell array of c bank
reg		[`BIT]	mem_d[`WORD];	// memory cell array of d bank
`endif
`endif

reg 	[`BIT] 	dqo, t_dqo;	// output temp. register declaration
reg		[`ADDRTOP:0]	r_addr_[`nBank-1:0];
reg		[`ADDRTOP:0]	r_addr;
reg		[`BIT_C] c_addr;	// column address
reg		[`BIT_T] m_addr; 	// merge row and column address 
reg 	[`BIT]  dout_reg[`PAGEDEPTH:0];
reg 	[`BIT]  din_rega[`PAGEDEPTH:0];	// din register for a bank
reg 	[`BIT]  din_regb[`PAGEDEPTH:0];	// din register for b bank
`ifdef NBANK4
reg 	[`BIT]  din_regc[`PAGEDEPTH:0];	// din register for c bank
reg 	[`BIT]  din_regd[`PAGEDEPTH:0];	// din register for d bank
`endif
reg 	[`BIT]  clk_dq;				
reg		ptr;

reg		[`BIT]	ZDATA;
reg		[7:0] ZBYTE;


// define mode dependency flag
`define INITIAL 0	// no bank precharge
/*
`define IDLE_AB	1	// both bank precharge
`define ACT_A   2	// a bank active and b bank precharge
`define ACT_B   3	// b bank active and a bank precharge
`define ACT_AB  4	// a & b bank active
`define IDLE_A  5   // only a bank prechage
`define IDLE_B  6   // only b bank prechage
*/

`define TRUE   1
`define FALSE  0
`define HIGH   1
`define LOW    0
`define	MARGIN	0.1

//parameter	pwrup_time = 200000, pwrup_check = 1;

/*
 *-----------------------------------------------------
 *	We know the phase of external signal 
 *	by examining the state of its flag.
 *-----------------------------------------------------
 */

reg		r_bank_addr;				// row bank check flag	
reg		[`nBank/2-1:0] c_bank_addr;				// column bank check flag	
reg		[`nBank-1:0] auto_flag;					// auto precharge flag
reg		burst_type,					// burst type flag
		auto_flagx,
		self_flag;					// auto & self refresh flag
integer	kill_bank, wr_kill_bank, rd_kill_bank;
integer	k;
reg		[`nBank-1:0] precharge_flag;			// precharge each bank check flag
reg		[`nBank/2:0] prech_reg;		// precharge mode (addr[13:12] && addr[10])
reg		[`nBank/2-1:0]	rd_autoprech_reg;
reg		[`nBank/2-1:0]	wr_autoprech_reg;
reg		[`nBank/2-1:0]	wr_autoprech_reg2;
reg		[`nBank/2-1:0]	prev_ba;		// bank address of previous command
reg		pwrup_done;
reg		[`nBank-1 : 0]	first_pre;
//reg		[8*8 : 1]	str;
integer auto_cnt;
integer i;

`ifdef M16
	wire	[3:0]	RFU = {addr[11:10], addr[8], addr[7]}; 
`endif

`ifdef M64
  `ifdef NBANK2
	wire	[3:0]	RFU = {addr[11:10], addr[8], addr[7]}; 
  `endif
  `ifdef NBANK4
	`ifdef X32
	  wire	[4:0]	RFU = {addr[12:10], addr[8], addr[7]}; 
	`else
	  wire	[5:0]	RFU = {addr[13:10], addr[8], addr[7]}; 
	`endif
  `endif
`endif

`ifdef M128 // 98.6.30 BYC
	wire	[5:0]	RFU = {addr[13:10], addr[8], addr[7]}; 
`endif

`ifdef M256 // 98.6.30 BYC
	wire	[6:0]	RFU = {addr[14:10], addr[8], addr[7]}; 
`endif

`ifdef M512 // 98.6.30 BYC
	wire	[6:0]	RFU = {addr[14:10], addr[8], addr[7]}; 
`endif

reg [`nBank-1:0] Mode;			// check mode dependency
reg 	[`nBank-1:0] md;
reg		rd_reautoprecharge, wr_reautoprecharge;
`ifdef NOKIA
	reg	REF16M_MODE, REF32M_MODE;
`endif
`ifdef DPD
	`define	tDPDEXIT	200000
	reg	D_POWERDOWN, D_PDOWN_EXIT;
	integer	PROC_DPDEXIT;
`endif
`ifdef MOBILE
	reg	REF4BANK, REF2BANK, REF1BANK;
`endif
integer	BL, WBL, CL;	// burst length & cas latency
real 	tSHZ;			// clk to output in hi-Z
real	tSAC;			// clk to valid output
reg	write_event;//KyW ... 0408 for VCS

event
	active,		// main operation of SDRAM
	modeset,
	read,
	dqo_event,
	write,
	flush_write,
	precharge,
	rd_autoprecharge,
	wr_autoprecharge,
	wr_autoprecharge2,
	precharge_start,
	precharge_flag_kill,
	wr_precharge_flag_kill,
	rd_precharge_flag_kill,
	autorefresh,
	autostart,
	selfrefresh,
`ifdef DPD
	deeppowerdown,
	d_pdown_exit,
`endif
	selfexit;

//`protected
3<9P0SQd5DT^<Gkh];b5Jkfa7A6TH]MM2\[:g28=F^39;ldjbm^YcfoSRbMB7h:G
pcA7KLAVQD3cFcW8fZBW9OfIGKFd@[=\L4L_EbXn0KQLN@HUho;;FbCi0>jnNpe^
2Q2K?ellD@CD8Q=6ZS8YcDdj50>@^<Ejda[[8gNDS9k\\ONmi>RnEKG6@0if77M1
qCA75L^qX^k?IOpd99?DcEq0gI_kohmcaS:P9ObQ^VP5P<QGOEa_J7EM6XAVC6;^
o>U<MdZbQd]>g?KXX`p?g_ca_]>4c5U7^W\G3YE;FQ77l13;Q?MUi7CIo<pKPIl[
TKi`8OkBQS\FkOmi=E>I3D?iPf>QB7FlWp2@55@b[6IBD=9nF8L;6JD9lYhHmN;Y
jF7CqYf\8CeJCIV^XAKZb0Pn8aHLd:PRNTTde=KUL;6N8Q<[p6c_FbQR8]Mk\5iF
Sj6TdQK2lT5_;PXIgf:jMIRY_GW7pdKmJ2gHRGN=3gChA6o\=6PZQD782YWG5p=f
LNa=BihRaPUk5RXCXXj;80?SIW@IEb62q>T]kb44A5iH826h3W1l?[3I=P<N:jo^
pBSMD?@n=LhD]EGfE=bdP4n^GZep[J`eIlPnDO0WP@\nLFZk;M9JNd]2@cXkM_kP
hAfnGRNAaYTTBFI]CXi?<^pngi_@OCp[Ucni5`;YTTiE^44j8OSklb4W9h?[`fO[
KlUp:RDi;Ym19GHdXF;_5fA:PLG;CQP<JGPDF_PMNDCWF>hHq2BQc9Nfq@58a;N2
oo]lY5kD_I6<a\hN_?L8?p`f`>h[_W;=NHZe2CS7[6b<bZ8dA9A2gb98\?3kQ@HC
2;jhogBTeD^^HIpd^WFCna`:Y>XhE>E2@gh:ZNlm\:3F0fX3OphHoa<SjCbcLli2
m_lYIh[^JRIRe87H2C191fm227@V1:>=_;kQMgDTbpAmiT`a@pC;WZ@S@q33_fga
cQSH4aHO[g_;4Ymc84A<5DSmT[j8G:VYXM98SHYV3[?][6MDNBF>JWY882V3MY`1
<n@DnE;90``D\K1JAJL_PR@92\ii7mA>[2f^A=KQ:31`pkPnmV>kN:=NlF:k@hO>
DBMn5[g\TF4QM4FHm>GgGbKoh^T8\KR38d[A_9kJ0p3V6l8?K`@jMYEfLP=2S;1G
CFH?`9Hm<qg4^A?02FMmRVXR7K@PL_TPYhF`2gRT69VV;Y0K>8JC7HODTG<9piZ0
D9[B_=@B69T9_FB7HOIg?@VQ5Y8gS=7R>TkKodokBEI@j4RmFpUWMfNZ]L]l?;e:
]WTHHkNh=W=hU`AQdZ]oY^n8`9F<flS3S;U223C4^R]DSm_iAjpH9n9Mf[M7WVoj
YQ7<E0iA]1QCW`5dhW4F6i@X6g`0C79^k9[V]kmeTFU[fDqX6ghHOaX2:j4S2<[a
<9laJkEEX88ZhYHUBL_:C0N3>F\bGFD>CNe>KAbdW@eD2X8cH_9kMb[Q[[KG2chI
JpH<mnc8>dk5@[k;a816ohbgRPO=PRGHQ;DIWg7PPfJEI>@74[H:6^aRL45oLcm1
7::]Za;dH>I]KZSVaHH]N2j1]dC]iQ]4]DJ_CcDEg2S94M=4^p`caA3jffUAHTL^
7iXB;V=l0ef3l7;K^2JGJefbLWO=QD>8Nag1QhFol3BllAHapDY^T_Jl432G96Eo
`?>NObCWNoVD2GeGW?cnFQIoCPR@?Z3OMQaDXWo?8JZ?XC9H\qPVP;I=oNcd:Hh0
BojgP8[WkpYi`;f^Bm_FdjOflbPn7PC5Vkb1nU8i0Nhn_Qf>2F=]ooi5TP9f>FlJ
DL`L5Smk?g?OQTb6nbKf:\2T58h<fg8;?c7fm]SoVBeY:>>dql@aPjlDiQ9P_C[I
5Y;G5mFWml[f7hj6UbcjM53m94[IfG1`;9Q1^QD]oiYi0haU]8fLUBJWOWlpH^`O
FgPf2MFWSP8mH__`CkEa3XFbV`d9^5WoUK2M]:`?XSiN??RWpje[ojH>OmdHUI6D
qG^h=QXlL9?5<cl=hF?ka0B17ZDQ^5<VRG8ifAapkZR>?gBKa<9ffMPLljDkW\[P
[255oJ]_f`9lj1Wq:iMU@KTd:SLZjg6SLnG4ThqiEFg>NB\V?M;E0DDl@jZ4dWpG
VTEfc<DJb?CKU5WZC]:M:i>8D?=qO3UT>U\iP00M1N>\8cID:HSD8kZQK0_=^9p4
R9W4D\YlFdK^[moQf`T1OBb0Be_qaC^27`eJnhl9RNe`mBp=<_kY0e;=FD:iAZ_l
DPp`J\l6<IJ0J^LMm^;L\X]5@P]c^FLcZ`lJXUqGL>Y93FU4KQ\APA\>cAaFUCL;
>IB5kO0JQe9o=;Yja7D_F:6^UCZaITEeZWf>0\jdl:`Y[U7`0N874q0Rj9FmUY97
Sga__?H:dUJelZM^0^_YWWCoYLdCVRGNfGPgbR:6^HMoB\I4j\efJj0CSUd3$
`endprotected

`ifdef X32
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:`B-8]= ( data_read & ~dqm_r[3] & ~rw_dqm)?dqo[`B-1:`B-8]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`B-9:`B-16] = ( data_read & ~dqm_r[2] & ~rw_dqm)?dqo[`B-9:`B-16]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`B-17:`B-24]= ( data_read & ~dqm_r[1] & ~rw_dqm)?dqo[`B-17:`B-24]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`B-25:0] = ( data_read & ~dqm_r[0] & ~rw_dqm)?dqo[`B-25:0]:ZBYTE;
`endif
`ifdef X16
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:`B-8]= ( data_read & ~dqm_r[1] & ~rw_dqm)?dqo[`B-1:`B-8]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`HB-1:0] = ( data_read & ~dqm_r[0] & ~rw_dqm)?dqo[`B-9:0]:ZBYTE;
`endif
`ifdef X8
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:0] = ( data_read & ~dqm_r & ~rw_dqm)?dqo[`B-1:0]:ZDATA;
`endif
`ifdef X4
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:0] = ( data_read & ~dqm_r & ~rw_dqm)?dqo[`B-1:0]:ZDATA;
`endif

//`protected
IgBB_SQV5DT^<8E`IA<W_7clX=\:?ZFbR>?7:LS5USi_A]:BK@ol1>4VX<coC\Pq
V48Q6C3El<W2c4G8[Jo4V[5EMmZKc5;3:gGj\P1iNlAd<H\3TBWAA<bnHd:7]S<q
okHLNW;G<oNE=G]4bXGFUl:ggeEHQ`ei8c_m5OTk4Mm\hPfh?HV@SdI1RNjQWAAp
HE_aL^pR7ihnTJcdb=^90_1Ui1SKkdp=L5Bc4WkS<DMLK<a88;HM]3L8OZ_WIVe>
VM2U715Wm]o;jhpN227;HHd:FJ\h^l;]dL2>SNc7k@F0fkZ3k1>o=q7802hnpT`0
C38cKGLDaM_c0ZKk0OD7K]g[qbM6hOUTYYN9leX<p2?9[E:^EdEILKMmZ8B6<L@l
;eE4=?SY6Gb:X1[q\[dP`FG3>i^QllOGH3=hRQJa9FecH>K^`dVKWZE<nKSjY>4c
kK64?FS<Hol6bbLl@GokqL`lC:injl27Bh@f_Uc>119;o?lCfD<kJ[5Y:=<:Zl3;
bc4_7JeQ_U4DoTH@`30nqgnJl^Dlq^4a3988i^PQUfN?10GQ9T><=>9gaA3b84Y?
`gmVXKOBfFHIZD8dhfGH0PB2m:Khq\D5Wa<pdEI1ohm?ShC?58aDb5n7V@d_khdH
n`Pqlg5TZW]aN:U>1QdQID>GnS8f@3DB0=`]BbnHVe<qf[[?oH`5EaY9h<j^Jj_=
bPmnZoMHXNdBp[h2R@AfIPHH7`;d;cDBHXf6B6AdX_Kf^UX;;<X_lGfMWQ5RiamF
hc[SkMiF\S?q\C]iIApJ\SYWLh4S?dA5gD<f^4QQk7iqWM=bacWfZo7m28LBD`95
PdU6d0aW5KRd\;edA;m7AnIATP>cPI4EONqm:]6oKK1UbJ[<Knp2Cn8M[cC?a^?U
V7_egbFADJhLnWjdiojdGKqbf`fLmqRoocVMFqI<TDZKU\V0FK9T:O0ZFQ6iT:>o
m0I@g@NhB0[bC_E8hejKQT7f>\ICp3JlcKDl?KSVn^oFa:OHOP<p[B<FQ6e>i6We
69=<Z];R6M6pKIX=lWRUeTo<6cnZDFPeD]TqoKgS_h_lNMMeKGRUcIM1Qj;pCLHD
?BYj=KW9B?hG=FTC0Ij;MdQQRl0?WRB2mCMNH]4>AB<eHbcEnf=8pf?eG]Z>FheH
0JoQF0KD^79qF`TBJ8>4V8c0mS1hFOH2VDq_;VY`5bYfb9=oUejLTS@V7qHEX2iL
]MMi`<D]I^V=n]6mRQ\4jqlCk9h18^lRlh[A8<[eBUi=\:aICC3VT>p]Rf\VDiQh
X>UA:^7SPJ^Xe4k_Paph[3B[3WA`M=2@h>C<\of4BMbbEKGqJo:7>OU_@HHXZUe0
ZU^i6l@8Y@iGpFU?7goO50TN<HJ6oMI>WS46J3`Yq\JHZf2FkV>^`lJU];3nL]VF
4;BibE_dq6<S97f5NSGX>5=I6AF<?^?R_j>::N89HpS0jBjoYQm]d5HLBI5Uo2W2
aPEiKOpmR4MkiB42lDbW;Fo;Ld9ig@:@?:cf2fBM^TUA<SkW3lZ`7;:f;?;RFSRB
npLLThjelAFTP\eX4dJcan1Vb5@]og@3mlhc]PM0m7pBK?G]6W69P`DN3>5:[l\Y
oF<mP?nKG4=K=p;5beSgqOf[?N<pIXi2<<q7LBS:6pUE\mKdQYOGYblA:6@64lI6
FbBP20>kfqhYc?_;f<TdW4H6lJcX]@G`[Uhi1PaOCpb6Cg64B8inH7TlP>o4`=>\
EV;WEi:MqWh:[20Nke];4fi3cW5H;7F:Kd8OD[<Sq<8VgaP\[b^AkjgP<N?CFh93
@9m_ieSqTQk6T\[d_n9JSbm5YZ4qDGLM\1q2CiPN1ph@G\Z^qY:DAZQpbEN3W^[^
kBl5Z1k:d=mFh_DmD8l^:nYp6Wmbdk6k4San>`6?;WQk\_AR`5H?A`<c2AUKGUnA
I3?ggap]FjbFLKbb@>1?klUN1^aRnRg]H38V<>pa3oNEaMAY]cRi`YED\F;c92^_
S3D89p[L;KCgad;<C<BWl;@8jY>6`7@:DYkTpJ;OMkn]nqLMWHC=`p5WglT9qb8[
SEL;pJY0[KB0>WaS=M;CKN@?L@_CPWVXJa`?qU=HGecC=ca^ngQUK<>:o62\h>F0
E^^XAkiiQ]:>>]X[^R^VPCS5\2?BqP<:o4=N4_5lDWYU1PI`bfUiG[Q7VK<hqSkN
J11Y[mZ_`E6^ElD7gJG6SZoM2eCqZ5fkL5j5\9GEmWaRFEH9f?2<2]nM0mpAXYZ2
keqBecfd5Fe>JSO]YQLn1:dcejL1k?qjOC=4^pjF5hUi=pSOl3lN^lL`?M`1Beme
GR89LjqE`hV=Dk]CCRamG6Q2OA2e@6CnEOXn:qd\e<=lFliG_hald5h\08a7R5<b
i8YKNGL0q_[`1LeD3I8B<F=Y<FlTjOomN4HcV8U06LF7Z8H4KH_38^d^I3kZOEFn
>QL7FlN2qBoie73\@3S??34:o^KCSQ]:\NT68JWHOphjDH:b8@ZhTd;86JCcLMhA
7UB1il5UTASCQn1k1q5MkB]>hOdMgS0CLZj[=Pe[6TLl0\^47XkXiRkLbRqhhoXZ
KGTZFM?CeD1YoR5SbXEO<bVSY[4DYQWq^l?hPKUnlAJCCG03OCAXB4GIgEN1d5lY
Y;ckqe;QP2:;191YBiXF[QMg0<QmSQVPhM_VXQl?lqYW<V]6[]n5dUImQUpW9iG\
bcJYd\cIS]6]RKa1BPdb>=>3\bqPR:30c4QAd>DScD?_C65Yla^1VSc=]9TYJ_p9
\07oPYnAYB;hmDUl4R`oA9Zl;OCW[Z0aRHq8Bc6oHRp9Z6VDPDI\8C>A?4?>Jpnh
U?6BaG8WhVFP3Ve4G210W4jMbJ<Bp9>EPR9I=iLEQ4IOcOaU`6W?Fao=c3\>qFS9
BR=NGeAKc4G<YjIhh@<;Ghg\;g8LpR@XKW:9V_mZ<4GcE@VeiEUL;0l[c;1eNnB]
:^3jORiYj[iDWEKe82@CpHAZ4;d<qEDNAjH^kBd:3Jdq^3L4VUHIg0n5j10ZL6]a
8^e9ba192n1YJanp^HFeSEZASXXPMG6mjFoWk^cNIeN^9@ca3`1cai2SH3eHlg>D
bmF8a72]AjnfAE\oR5>CqI>Z3hoVC=:eYZ_9;;LJLg9cK4lHFW>I65O>Wq\1?YF:
0O>J?AbfUE59\Q0IU6DYi6_WGnpeFAD3`WqFbL8BgYQWSLlF9IZRO:V4Q8o8=dBn
Q0<0g9qf_cBN`7qNjW>\3n2ZG?;C9W;niIgVV7o8SLEF<`6d@B^<J8<P76Pljo2U
[Fe`0YQ6UA1`bf`W^WFI3V2:R?QCja92LO1V27Vq?PC[ZQ3X]U=iEl0Qgkg?O]qI
^m[Ae><h95Vj<dWB2_GG[JVXolIp5<UYJ[5Jl;@d43_[o=Nf?bU_l>BN6k0>J5a_
ahHg5?87?QfN=PNlp;Oeg2`?R>hCW?Ei]VbqVea9XR3[NZ>9Bg\L45^`@h^In\H_
bjCmRlRqNcG1UU6W;l=_=[A^dRgci<mTXQH]Si;2kVBDOHOU:GEUmBY8V383?O?l
6LhXLI<iEj[L<>p2`Q;MY1qiJ=58APSLX8M?O\RS<IL9[>E_h@[?YLOdPeK?BG\p
^edcNnAqaaj2WV=3<Tc]OME3IaE;EmOT3CjZeg[SAG^a3LkTKCjV@ddV9aia32DC
XdKH1Cq1Vh[;AZpjT\OK5>K7:IA<deRmhLk]kEd?blfo?<?4LVgV==@<=LP<FXIZ
gHFPeH57mjY9X0<ao?81ig84jOlD>\[4hQj6M_R3mC<=IU>6;qPRAj`gh=UR5<50
VXW8Eh`9caVaJ_0o]q]l3Rm6NqO5GcCSHbG]3oeKUY46mJplX2NJ93\OSY_Wj\]o
A1cm5SC@J:SC_lGAhHfc<F27B8LLWme`A;W28[9DB6]L:Go\Yo[kAe`[WZ7CXiUq
P8IY^a1qj13Jchg]Dd^q@:CLa:?pZhFcV=O4Mbl`aVTnc;XWg7:8g@X8DEGiE4R3
ooSpE8lJWiCGLbD8[Rfbh@M:K?iX\R]`A@a$
`endprotected
				`ifdef M16G2_M641G
				  pcke <= repeat (1) @(negedge pclk)  cke;
				`else
				  #0 pcke = cke;
				`endif
				
			end
`ifdef DPD
			else if (D_POWERDOWN == `TRUE)
			begin
				->d_pdown_exit;
`ifdef v
		$display(">> deep power down exit at 	%t", CUR_TIME);
`endif
				POWERDOWN_MODE = `FALSE;
				CKE_FLAG = `FALSE;
			end
`endif
			else
			  begin
				`ifdef M16G2_M641G
				  if (CUR_TIME - TCKE >= `tPDE-`MARGIN)
				`else
				  if( CUR_TIME - TCKE >= `tSS-`MARGIN )
				`endif
				begin
`ifdef v
			$display(">> power down exit at 	%t", CUR_TIME);
`endif
					POWERDOWN_MODE = `FALSE;
					CKE_FLAG = `FALSE;
				    pcke <= repeat (1) @(negedge pclk)  cke; 
				end
				else
				begin
					`ifdef M16G2_M641G
					  $display("Warning: tPDE violation at %t", CUR_TIME);
					`else
					  $display("Warning: tSS Precharge Power Down Exit Setup Violation at %t",CUR_TIME);
					`endif
					disable main;
				end
			end
		end

		if( POWERDOWN_MODE == `FALSE)
		begin
			if( CUR_TIME - TCKE < `tSS-`MARGIN )	// check cke setup timing
				$display("Warning: CKE setup violation at %t", CUR_TIME);
			else if( cke && SUSPEND_MODE == `TRUE )
			begin
`ifdef v
		$display(">> clock suspension exit at 	%t", CUR_TIME);
`endif
				SUSPEND_MODE = `FALSE;
				pcke <= @(negedge clk) cke;
			end
			else
				pcke <= @(negedge clk) cke;
		end

// clock timing check

			TCC_P = CUR_TIME - TCLK_H;  // saving current clock period

			if( CUR_TIME - TCLK_H < `tCCmin-`MARGIN && POWERDOWN_MODE1 == `FALSE)//KyW ... 0928 for NOKIA claim
				$display("Warning: tCCmin violation at %t", CUR_TIME);

			if( CUR_TIME - TCLK_H > `tCCmax+`MARGIN && POWERDOWN_MODE1 == `FALSE)//KyW ... 0928 for NOKIA claim
				$display("Warning: tCCmax violation at %t", CUR_TIME);
//`protected
?li<CSQd5DT^<B5:c`b^i@a6m`>XTN<\Y`o;?hcU2ROg;Z5B1?kM0f?M_L_`qTZV
Em;<?KBZaDQG^\aEXc?qXGKa_NMLN]6S<kLLFZ^<M`cXM8cmlYbKI`C61cWPPeTh
8^bML:7AG]fCCSUf96Le06:[\ahpEK]cXjq^GY>Ab@G8J:9S@mLOXFNIBjLI3kX5
IG`g72AE8[imdGUo6_=0ACC_6=ce3qgle3K5gFg2:ajYZ<C?Chhl6;aJa>:?M@If
2]5=M4:FZaON>PQI7NRD=SUnaLGCk5lGoK<KSd^IRp[]kOBfQ[VjiQH2VgUUb2B`
qW6DmG3eVHTU[O6i;Af6i7D^KHBh9LPaQc:bJcf3N8@FOcN<\>L0kCkqANm3[?_C
i[UoHOL^2ejTa:0ljLOb:1_i8m;ChOELljYXHLm88UG1I;fq1\\nNPmmN_XP8:LL
d<S@:l7Xg<CT@mUR9:_?>`?XU\bYR1h6T\=MRcaIFe]n[DaZ@b66?iZ3@SXS1X9X
Jj6p6>?i>N]pQZY\?ABX?ZF\JUC?2ljOUA]B;ec6qD^Y=4b7>58NE?X3jaIjJO>d
h8nbj>0X<[_qa_Q]1C9q2f:<jd>K61IaQWFFgjdUjIQGYO:`Jdb^TQUACe4_nY90
;QU\Wl_Un9JOpT<QPe;]04lW@5Vi?hoB9:U2_EUAe:5IWoFS;OF?eN`3m`@WanF[
_6gpYK45KQj[?GB][eKPlOV>X0V3ck]d8^>?333WZN<Yg3C`fb^]hbfXRoZ@^JdJ
ZGZkaXHW@N>d`FL=@gOQPBN9ql<E;jBfpn1Do?LOjjUJ_SA1:SVbFBB_=8YMR0ho
pJV7?S0I4l?9FS?=k:9>6UKGOV3FC0SjDeT@lJI\i6jL^M3OK2BVF[6:>qM`YDGf
[g1blA8Q5ZEfNEOR6HL^b1SMP^\jZCW6?^[8WX?<FMAf;9Nfo5jGFH3N69i[5KcQ
AYZ2CjoTOfOXHepiX[DF]YqXOZUZn<?87Ei[enYW5DJ]eCdo5bME^_p^RBUCSpib
bXPgH::2mok_a9<OKHE;^g]_]6HBWI_VjWXl5ZWVf5M9?T3D]mHJWjoR@<eOW5`@
qW1i^LkEJT5W7=AdI<d<Mo@MH>L1Cd4ISkZH_:=P32cVM6]kcR>dliD9p4mM3F[i
`TSb]:CH2kXVEgm;Hg;kjU[^REo?V=IK<V`\]0Si6o=o=iI=DocF0Qm[Cl7@_W9h
^NZe8mX_2G_0p04m[B5<pmAkfDgo<^B0_Rd`QXR>NHaN]XX7WpM=XJJi=p\\d?ZS
\;Xj^NL9Q;@kbhNGglL<1hVfPMjKm=eN>8T8fIA=`??>F<V\VGJ[7hq?ngc]^Q[\
U6P^XEM9[BnX5MfC<3A;=Ai:HI\3k7K_DoQpjQGFW2:YIJfXN?g<f[`9KXTLgVm<
iob?G_kE]Z\AFE8J?_GM`ag>J]b8o=Tk?bo?\`4@>ScN1dhRnNq0M;jlkdiNXC;E
7QQJ;ETcO1Hi\52Q?2@3Mf4IF3JIU>[m\6NLeM_c7DR_M8^j\WB0g[SZa^ZiW]Ql
hXk9NoR=752ZZfi6Bplao2^QRZm8q766EL=8V7e_i\8I=cVGUME1>Y>YeKZFphVR
kc;[JM5BmP8g0Q7QLM7bP_VlKoPTHcn@>jZSpY0cZ^Rj04LHIB_32ZHlCOWn7N^Z
L62Y2BVSYqQ;D_KLAqVPDW9aFpjgT<MP[3R`RfCl>^@N1fAJ2XCAo]b18iHOifXM
X\GnmglYAL^bYJN6pM:nXS]Yqc@A\?`LV8YUS[H0h36=fAFTR3ZBTHB`Cq2B5W<M
3p4:2R0Uhea5UFJ9WP@a_144A4`9G:fK1XBmUcQJk?PbUZD4@d\D;Fpg>2?KJ\1_
J5PmBn_4XVjikjq8kcW56A2n@HV;@<`=nSdjPGh25DNpomc^liPTn_jPHMndKinb
E9qQMBbLWeO^J5Jj7]Z\_N\DoA_8iGcad?TgOdbRRYld1HQPHhdYY0\]F8keMBQH
Vpb<7@XNV3jZ3;2m^[KFc2qTMi[IQ48Ej8aYJJ5dR6:>1FDEIJ^`<`RcVpLl]ASd
cSSHcOCi2n:9MiYOb_3W^=F2dWe]qB3O9=Kb5WLj=b>QHB^8BP]>:QeXq>^i63Z_
mV5Ncg^6^K5HDGni1W7]5^R9iJTADHD^??MP6Oh;OKa@KJXGloW;3mjk2[]Dp<`l
AnD\NWEoADlUPT=:kRm>eWdWH5@\0:nqN21n6cXpn><=\?HG=4OS4Dd39LH0pK4=
9]hb=hk4UJLh:n\<SgjQ91nIknIkTTJQdUVSLD:K;YY9KHbRHlcm[TKCITo5@e?k
O8]LY]G_GLhha3IEcjWRgp9dNRTfW9g1VWL_>4m6[MKIa<^4qGUdb43BqZYi5Lf2
g>h5RVm7mAWc`QX;Tdg[E9j4i78?8o:R3]>TLdQ[YL9DIlI9npWJSddKUb?b<gUc
17KZTda4M[W9\fdIOXGVJMXhGm9aCQi6j8Qn\:@gh[>mj@Li236J4kSYN9b\;Vf4
ZM?R@8j<oaqioj3e>3lOMX_L_VIqCAAFjAYZbBkffh`lUBpj2Cn\imG[W@K7P0CZ
UX<X`bkompfNMJFGnKA4RJhTg7JaeSLNl[Dk9m<HR\i@na13?7Slc]W2CCHha9Fh
1Eg1QH6?E2fI0J@?9[qcY@id0=pgU;1N@^0bNkLNg1Qn88O?\\`ZB0o^FgZ@@\DT
?:2M:Nd;o4kR@n:9bPSGAF1E6:`4ln8i13TM9FdYOY93MN>26P0cMoNCJ6[=W[6I
<8FC^p:6kO^^10R]=@Vk4;jC`CbTcH[dpEgG:Cda0bOWXZDW]cD9J85UZnJeZoOY
8Mh_L\G62Oo>UfS]e7amPnBBJ[E<[Kd<8Ujcd^>IUpG0Qj:8aqAaXUlLYUmg\6B]
p:9ANFjk?dSO83A3E7I`=^gk_?30mo>D09NYFH@EDq>gR8_FPdmX@BFeW=2iBVd;
S=@@>Q[=[>JZ2YXCmWfd4YGI4@6O@JM7WF:_07A0;9G``SLHR4TaXQK>fo2\@5eY
ame@<7dWAFM5P7Oamo0;VMKVqLH7`hM\Uj=V0T3TYH?\`6@KK`<q668>9^Lqj69?
2nDVfLN6Bi]1d=V=V0c=1FfkC4<q6lK]d6b=X3OOCG:G@JiKK7=:QLTBWWdVU0_[
8\JqQ4Lhj6HhS]AQPGD^\Pfj?oAfQ[?7;QY1=jnXRT`7SUQBH[PU35`1`4IIn2\=
;9hi@aLF38IaTWqh9aB[n1EBc@KGg@\VC@WNmTTn2C6BjW]g=F6XoZ@RnP^^DIBm
<=H[QEZO1pcDE\<VM_>^Hd6b?=D:jY4mJ7]Y6PqkYgVLD5[ZO=fXhT]O^VqI]OcB
dg2=_51oI;gCPEb_=Ia^:FEJjM_8G`p`jHNRgYV\FMfE3e7jA5E`g:17\RUY=>QG
iCYnolagbCgb7`?m^Zq6>5SfV25P]C3gm8Y@lfNL1kLV8_4G_M[aaKT@AoQLcSVa
GF2peD8BYCVLp^D_a_IN7=1UX]8LTSdXq2PbY<B;jV\OGUMkW7\;NGI<g7MX^_YA
^VWLW9l\ID1qh]onaQX=4_\NLg6^7GCk4iSj?5?7`i1ig?^Fo_IK39pKC^I3WmRd
b0TLPJKE;>nO=dK<??@SEk5YfJmWAW;oWg_dOI53<4pj=70Y3J6pm9RVeY@=q;Zd
jb@8c;ShT[aLJm[QZS<?2e[e<hS=4n>`LIOlY]YNW`_XFk=jJGW]4dM9UN1qH]D`
YHG:5EXljJAHmUg3fL`ffV]046>fqI^PdIlAQhTE=2=eniJ70MWpYH1K<Z=plS4F
6jUQHbW;bGbCL1]a^nOURW`lY>M@JZN5_H:BJdm7@_g2WFZNnH2`>1_>56CV<1<8
If??Wi<^nGM=eK<[^E3VOcb9fN26l<dV=iBJ\4DE9oAH18J>Ijg62k]SE>p>n_3J
IG25Vgl^dmOKJT`JSE`IJI<j1Kfa7XdRWIn3fnVlEWQEKhp>Ff^7kipU\a2LJFdK
kLm\WbQbfb3hCi1S11kafCkjVRCfOSidMNF62iG?iH?aGhHUoR0ebAhUS\2Vfip3
0^?U`lE4[^[_gF6Z`CRlF[R^0U=[hXgb4P?iCDF__12>P7QQXEKgJhR0\\>eYVeK
NYjdj;0_>g`a[V4mlqHIAkR8dc2B1X`]HBE\A77oA<\8IUJDH?NLVTcM3<ZdLD^`
Zbd7o2WBp29kYoZ]VchgFJIGYAFD<>f_Cp<0>Y`?4ql75R4@L5`?c6^MQleaGUQ;
CZJZ0ikn73XIG;VHb3XAHl71V7qA\^YF6=jXFibb?jHZVa9_cQEb7=VX25`bTh>B
n?E^cWJXgFFEGLcRL7_DCf@EdlJ4YDjm^1`Tn^1:7ilZ2kJa]ECTX[[Mn52?jEN2
n<5]:<i3a483c31`\[a:CK;ThYf[J^pWkk4NBGpn5nd4o=dN]lkD_8KFVBm1n:PA
G]bP]jE`6k96S8Y:nphQnVj0`NLKH]k7h`^5oNJ;d]ABD=]D@l_<^]ci^bUS0Dfa
Z]g80Dlf2UNAM7bR=?1InGAU6ZaKq<mdAKDkUjSL6ab^oUob?Zfih3i\DI>SHTG:
Vqf<AP3[N8D=>V:VUJd;;SYoM0oaPcAE_XqO8JD4IS`Dm7XC4;;b<WqZLC9@iK\V
YR6U8D`]j]\>1bJqHl_M:LXqQ`jdiS9f`GLUIg4?S5LaH^C3PD3=k8hDX>B=016_
Y_om2jVNWSXi2gi3ER;kLhA=5=Q`Kdi\U6n]^^A2=5WYq_=^8M:XWm6SS[<SZUYS
BcCgJpO96X88_q`c`L<BE^2=R9?gX>1S>3E>;AoJCZ>XKT2Ao[0F7pPk<^aMoT``
jJ=iY3=\WaIkc^leFeYF5GLk7^]@W819oKWCDNQG\AahA=`V[0]hiA^gma?=jOjj
>1mHIWC^`e0VfalC7B2I>]=V@2_G7o`cdFRCDnN@lib\IV5X`Kpl5jfBCLq9NcNn
KeqcnANKlqDD5D[D`pNfTA6Mge<_OK5k3T^eTneVlDhJCZqB2O[^=RQQKSXQ8i`l
c`B^jW3mTZ`R^2mpW82KfgGq0?c=NJgaOCe5C8BOY^oQE;7DnbQna3>1DDmB>j@3
fQNGFSV^9<b;WO>E^cq1EiV;^@KChiVNGRgHQJS2JBAWbHAoGOga>q@WB;82^JEW
W3Od3Lpl:8_;iCq>;FLNNl6\;IT0QQ?Ehjd6jIo56:[q04_?^iaSZe_N7d`I6Neq
A1HVYN0?I\8nFAN<mIC]IHAmZ5AY_<ji[31pZbR8AWZk6g66n[?5NOZMa;g\Qdaa
gIOfL0]lTRZ[0R3Y6n?nI5C0\>MHTK1pFFH2XZOZ?1Qif=HC?KAcf2o]][m_Gb^_
lBYEg92Y>@7AS\FQa3]q15JWeB:kq;CHKX@@GHKkJ=CGE=lfp45mlV83o>KSCOT\
@=\CM[@M4Xk><3>a49LYPg7?f`kp6P_^5OkjJ]LEcG^:ANDHo`VP44e_mTlCFa=0
4ghFS5qFbA2VoBG1\N[ddK?MU^;XEZdXh7T\;dE0>nEmBa9[H`?jaP2P[jq^X5DE
j9YE?WUb9EU3S7TCJ15O4o?MJFkUGJ`Ye6AB4B1qISW`ZiEPp?hUhb@_Lp_oFCBd
`F>UbIaVEpOcjS\0@7Q9[_BZQ[1VCFBmI`]S4[KK\LBBniMnL2QWocOgpX;W:3dm
bp\13Y:idJ7bKC7;:I5=S;N3poc:H`\IpBn70S2S70;9KkJ0UpK6PU>IeJWcG[>2
YQ1ce<KAHC\VnIkBTX5;[1^BRXIhJP6dA]S8gh2Jqc4ReB;7Ej]=h<o24[9qgL`a
]^[q1S]j=[C]<LJlcfPP;Rg4^>n8K^<DGn\;dB_:_de2nKZq^OX^WigKR8koIU^6
]o5=jQC2p<;SDOYaq=dnK2`TKDY0FMYK0qK2W^[XbqAP>Hh16l>0T`_LEZLU0HXW
XcC3G_;fLGY9p[F[8B^=Q8`0nZXBA<VVpaS1Sn5bK8F6WUaR7g6RqM[VaII`cYj_
]bG7fM@<TWMan[U0km7R7qQFngC_oq1<BK=M40l<]1^FKEOY<qaE3^k:1_G@iP@Q
lIF<IKBRd3eKqC<gL2nlpK_cGNN^pR;RY8AHYElM]2^l_6bSNQe`LL<jWAAZeH=K
NDk9[Fn8<DX2V:V7k1KnHO9[T<SGT2>[km>QB1@>J8ebD;RMC9H^ZKZ5a]NZIlo2
Z=H=>>ODpUfJn^@Pf6FdiBMLXGI_Pc7DOd=TOC2>8L8?7Oo[eYTW6QQERgjYgdZ?
<GWIh7TMp;;;FHZWqdmHH6^qoaF]PVabm73q>BLo8>bcGNA0:aaYMca2K=F?F8;;
E;9Z]A8gV2mmK1L:=kR`B\Y8`7Ji7J=a:]gUUeKJLo0cV=j\FZF\McK;m1M2dEQS
WW<3jf?E>OkDK6?Fd^:qDLJJ2DYq4Y?0WZTqS`VOoG^ZO5J_7jH5fm5N`RJ]j=q`
g3m@MglglgQafIa@nnhDmP0<TCIdK0ADZ558?d5GnTBcjq4JI5N`[pe_A^R_@q>3
^V>2;a8oSK98SdS^6^Hc0BUh2A9>0KpPf@`mPdl@2k8k>>jUoSAi2R_kRH70QE]f
c1H8RV@nQNX0hiV<\7I>QbdpfB;6A^4MCBc<F:65AWROJXG>ni_cpfh?jn80Qk^?
E8?M^pT19F^OEpQfBLaeEd3AgV@N?f65[06Mc\BgBUQW24SmpM2bB;cTI2`mFWP8
8S34MpYZZ\R6^6QXIlUl<\eTZq@B1<J2KXR=8F;2Kbb2nYdgPKkl:\]ll6p7ojWI
oCqVKTLRZAIkjkn=of3\VlpB@VX>^O24\1I997lj[fN035Z2np]9WD7b<qh=n^lj
6paA8ThdSdhWbaf[N?IL4Lq29=@;G>Bg@YRV<gl8G73m=ECi]ej5Pi3Zh4QN8IRi
;iPL438oQelXXCgiQ^1SEMVRX^6f?bGQYAUR2?3]7ebKgla<;Elg^ic=SAQToe<X
5QplD^^L;epDdO2fQgII;6]U`YOpBeLEol2qc6i2oo830ic9iXDI[YKUR7Nof1;3
MLd>K0qo?bUCEN`?fZ3QO]hWMIH`3Q9b[UTHDW483[67?`ciL6qbZ>LnUSq3GI_Z
XNM4m[Q2o[R6n2]<O`R9GB25N\0M;5>V2JJWgfq3@H<4bYjJ[OK8T4Alh7:cYc2`
n]:2aLEIlSNqQhTY<]T7iGMU[bF9o=jJFH=4_E7g7O:ZgQ5BbKG@pH[IDKfHldQ2
Cf7O>eCHM;maB4DNZXZJR[3De5=4YV]aOM@q?D1E5P_Ff2A=;lOXlNSX0blO=05:
BfUo5Y@@Qb^J^GL51S5[AiHTK5^YdVTbJcR>?e8cPa2Id78No_7g4_J44EME0hjM
D5fXCeUjND2A0AMUd^Ri\6q6J__FmbqfLXeEF^3A5]jIE9E5PpfWd1cO:p5<dI=\
=ON[<?Qi7BhFOJ\P;iiGW[`iNUAcpkEOm=82LCJD^]:FJiYE>Sdd<Y46i0;WG@IJ
CF^ZZC>66@P^J\[l9L?Cd?1jAW00QBl>kGJdeaeI::FTUlEGEnSLSgTSYd;ZXLjn
gdbKR2lqeO3^;D24<OGJGjeBK`Um>97P[\BDF7LEp_KWZ@BfmF7]JI_MU<gUa2B8
8:930Z1[`31YnNck]4D=UE[ckVK1UZWFiSoNV0Ki4ADFPLk65422^IfJ<eYJZX`G
lE>k^;oNJS?]X;UIV2=f:eF7c]o0V:_Sl1GZ2`43>LAIpD6Nl`J3$
`endprotected
			'b101 :
				begin	// read command
					bank_id = BankSelect(ba);
					str = PrintBank(ba);
                    gapless = (pclk_high == last_rw && auto_flag[bank_id]) ? 
								`TRUE : `FALSE;
					`ifdef M16G4_M64G3
					  if (precharge_flag[bank_id])
					    begin
						  $display("Warning: Illegal command in precharge operation at %t",CUR_TIME);
						  disable command_sel;
					    end
					`else
					  if( auto_flagx )
					    begin
						  $display("Warning: Illegal command in auto-precharge command at %t",CUR_TIME);
						  disable command_sel;
					    end
					`endif
					else if( Mode[bank_id] == `TRUE)
					begin
						if( READ_MODE == `TRUE)
						begin
`ifdef M64G3_M128_M256
							if (auto_flag[prev_ba] == `TRUE && prev_ba != bank_id) begin
								rd_autoprech_reg = prev_ba;
								->rd_autoprecharge;
							end
`endif
							READ_MODE = `FALSE;
							#0 disable read_block;
						end
						if( WRITE_MODE == `TRUE)
						begin
`ifdef M64G3_M128_M256
							if (auto_flag[prev_ba] == `TRUE && prev_ba != bank_id) begin
//`ifdef RDL2
								if (`tRDL == 2) begin
									wr_autoprech_reg2 = prev_ba;
									->wr_autoprecharge2;
								end
//`else
								else begin
									wr_autoprech_reg = prev_ba;
									->wr_autoprecharge;
								end
//`endif
							end
`endif
							WRITE_MODE = `FALSE;
							disable write_block;
						end
                        last_read = CUR_TIME;
                        prev_com = {RASB_FLAG,CASB_FLAG,WEB_FLAG};
			prev_ba = ba;
                        rw_dqm <= `FALSE;
						#0 ->read;
					end

					else
						$display("Warning: Illegal read (%0s is not acitve) at %t",str,CUR_TIME);
				end
			'b100 :
				begin	// write command
					bank_id = BankSelect(ba);
					str = PrintBank(ba);
                      if (prev_com == 3'b101) begin
                        if (clkh_dq !== `B'bz && data_read_delay == 1'b1) // 98.6.29 BYC
                            $display("Warning: HIZ should be issued 1 cycle before write op at %t", CUR_TIME);
                      end
					`ifdef M16G2_M641G
					`else
                      gapless = (pclk_high == last_rw && auto_flag[bank_id]) 
								? `TRUE : `FALSE;
					`endif
					`ifdef M16G4_M64G3
					  if (precharge_flag[bank_id])
					    begin
						  $display("Warning: Illegal command in precharge operation at %t",CUR_TIME);
						  disable command_sel;
					    end
					`else
					  if( auto_flagx )
					    begin
						  $display("Warning: Illegal command in auto-precharge command at %t",CUR_TIME);
						  disable command_sel;
					    end
					`endif
//`protected
Z0FeFSQH5DT^<K:`[cnb3i?Qh1P6U?>nE1>9gHfFDZLPLg@U5df4CZJ94k=q_:mR
HPaI:^02aT5SBe3@T]lWQ6XFO>^DMd>qS[higIcN7USIA=TVYULGA2C?0Q\TlWMI
_jcmMQHA^7TfTFn]@A;B_KWU_blJBN9<hN?Q>YqGZWQI?qY;RXZ^LB_6N3XaHUTY
Fc60JaId3ai^lP0<h^Oc6]Sl1Fpe;9V;n:pfOSKM];FcbN1HmA2B^8>F>1mb85g2
2AZQi[TqUeF8KOTp:a5P6b8L:B>cT6SI3Fdh@908FA_fbmqj3[^hkBFfeJJ>NXBh
P7c4XLQV>7PUAaiElad=c`oKHfegfKF^T>_UdMHGj1B>:RLKb\SMD7R?Vg3Pnlcp
HEYCDFV3<K^]h0mjCd200U<M7YIAX[:J^OeSJ5`O\adCqmTAbk81Un6CXcNbp\QI
5o3gbglTPMa[Q]nK?SMJBgm4N>k;q8ZlGcn;qWkPgN5Nq\B=eR5@XC6[2^9XnIAb
fSOIR_]VE9CbMpgW2mVVj967YM^J_3GW>ZU=g71g^j>\iTG1YnGgoLNemVbcJFme
Zf:Gp]E_1F26VA\EVJh[C_EOCgm^djVdBMSKp[EAHAKa6oYm=TVYO6hQjjok;JTU
;dl:R=n1dBZPCI0[CUP2`fWap6;\PY`Kp?`iZ>CO>IB:]T9j?]QPLAD9b^41QS@V
?[j1ck:qLI`l\Pnq;A8oW:E=n@49OK\[l^oP3A;W=J1mBEpM:1ndAJ]C=f8PZYCI
Sh[_^@X<YeEZR:kk1[Bhc1Oq;LmhY@RThKd9oP`^k=2H?ka6md;dnYTm9NlO:`>c
ELAYD_94F9QNG_]EAo]=QJe9YKFUZkaH2KO7hLfGpO_CjR[G9@8HK<bbYOZ5?g^i
>mbOGp:7HR5=1\ee;an\XEH<W3IkdWNdg3`oP6o5f\k][\b[>4J0pP0>C3@I]VDc
Mi=gd^P:d1kDHS^n]IccmqWM08c2VqCBGXhkM=c1qJ>jgai=QJ9NXloUh`2D\YV;
gl?J4id3NkR8La\f5e7^^p:Q:oTZ?[@@AmgL38\aT?lb8aF5Fl\Y>q@_h92DePin
O\T=Y<^dh0_Ue<oB:=qAK[gbB@qEJkM@X:q>9a8IL;pM`g@aogjP6h0UVE<cE9eU
dgH<hq7>VSK:]?C4aiEZl]k[g1e?JUi@7S7jmQPCq9lOXgEcSNd]oG@<eN^1:=SL
B7Cp^I>inHMqm6d48GLRAb^@bHFKaFoBPHY;[ag]2fDh<_Cpd6eE^i?J1VRH0RnG
ieign1\AZfgc41YE^^PE7dDYkEgPXneA^]1Lb>_p]RN6HfhRj820d3Fo_Q:HUjU9
9TQD9[`6oE`W<lI_hFl6:C_0S;ccbA0n3H8oFH^;d<\`<?F1>58FBcF:YeTq[?iB
>6kqV1NPT8Zg;RoKGN\?Hm:e[k27SU7GCE34;^^R]:Od<OYMEi0\8UJZnlc:IV85
QhAp40V2Tf:6_g[>hQ?G5`ci[@b>;jBH::OcP_T[\TDlbS0nUnU4:UjoH54S:L:I
G?UD3>9pB77AMYInZ?E`11CYZ98_Z8;6e^q0ADUl\2[GA<h?J`AD=RR\K5I`nV0<
TU\acecf:cB<Rq]m=?o^YP:cHh6KHDW>YU9mh@SE`=@K\:Z;:DKcO?e5p50dI_6p
<<^eR6Vl\_j[3=Jc8UD]h7RHW8nAi<bTpJc2UQmhMaI`MAX0<Ll3ABg0NS1B2co;
E=GqP2Vc[AMB;=;4A@;Coho<>Bm[YWXT<BA^9Xh;TD98GPXYqnMacjCjqBXjSB_`
pKcX1aGn646<mi8IMYfOAi?I41LWW2dbFL<;_^f61D5BZFd7TOgaH;B6RFmjXDma
U63a;M`oYF:nj=clAY7PFoGNk4^i[FlbLmJf=REdK]^\MqPXFak3qOBTmF`iqj`H
7f[lnf6lFWKj<qWK;k7b3eABiN`7pBNMoOobe]H@^@bIk0odI;apm5]iYR]LGI5=
0]PL2GE7EO02Vl5nFCdp^U3?hERB4:P@CCPS8IT9N:FMcO1p;:D@L:JM[60Y@Y1\
=fPk?:dN7fcElEkep<g[S7e_qZ[X_`ejp\A<NLXH]\44gh]BgBVN1>LJJJgenH9L
jP4;UWS7<2oRop\MULXSipSbg164Z8Z^S0fg9YQk6@6]2lNV>P]E_^ZHM7VE<QTZ
b1IoCf\AiTCodJn[CZLTPp6je^iCQQ>\S8L==kA3gkWk:=kG=1TYcBj04bp0K1Z]
Y=p]ARch5VDKD]STTF;C]je9]H:iOTQa9M:qNKYTL_6Yl39Dl67C9jNdRMDA8;@N
Kf[LTSIXQNMfi@6`11MK2>dJ?>8T]d>TZ[[M>hQX8GaL0D[H;_IMqYdRQoMbp0Q<
K_>Q:IIEA@=fcfJmGRicVqR\HKVZOqnkYA9AgOQMJSBLa5MSPdXL[V;83q\9KZhV
alO`VA^DlA=V[ISHA]G9gfof26]eLjbg1p@da:EGhp^94YjRqYOGo7GVP92g1Y_h
BkQ=S^`d4GT:Qe=6=TBm7f4j[Eb`kbLZ\H5;:\f5DGC=]F<f1o16\l7:nNJN8TNB
>pefPjA9eq_Ng_VfIB_DWU?_P2^_a[A12T58pCjQ<RMDO[GND`JN=jOUDC7KmDi=
GU>V91gU;W>ACdFdOT[lDpScg:H1c]qLh79lkF\eZYoa@b3;IIYC6RG[mF@aXXeS
mp8<aj=Mccfj\S0GM_lc7jnmGkGlY^bA57PP?]VZdM;nnNBhp]dYfk3O\pb9J\]0
1g>Ko8B3R1P\>?JENT@apg9QIl:JpFllZ5C<aC<B31A_;NL>LB=UdSjPU`\D=o=X
X5468aSFHZnOk[cF;lKcSGKUBP>U?aigpH<lgM]jje8Z5]DX?j]4;ZlJX^?TMEiX
Q:N\CA:On`D`qLa6B8]Hq7fL=D2iOG431le3jqVO7;=d>$
`endprotected
				`ifdef M16G4_M64G3 //KyW ... 0624 : rev 3.3
				`else
					if(auto_flagx == `TRUE && (addr[`ADDR_AP] || ba == c_bank_addr))
					begin
						$display("Warning: Illegal command in auto-precharge command at %t",CUR_TIME);
						disable command_sel;
					end
				`endif
					`ifdef M64_M128_M256
					  `ifdef NBANK2
					    prech_reg[1] = ba;
					    prech_reg[0] = addr[`ADDR_AP];
					  `endif
					  `ifdef NBANK4
					    prech_reg[2] = ba[1];
					    prech_reg[1] = ba[0];
					    prech_reg[0] = addr[`ADDR_AP];
					  `endif
					`endif
					`ifdef M16
					  prech_reg = addr[11:10];
					`endif
					->precharge;
				end
//`protected
f@kN_SQH5DT^<lFD<1bGW1B8kT2V5=J]^`Wm;_O>]R9l^kHfWe<f4JfIq=cEN48J
JEa5?:4aVhXQZ<2TXFWcX[4NM=n0JYXC4V;BUP8mFKBpUnmgP1k9h<2^7OdNfg6b
OkYp4MbXngp@TT3di3HV=LOQE]I3GYpfm2H@QJ2SQinJZWaZGp76;022`SUmROY=
IgkiH0RK`ep4emIiZA>h?AahRCnOYf]]@qcKJ4FFEnEXSUF4gchgGA]\D2q`PHnf
]jpCAZ`F[CFK3DM47N3E1C:P=Dn:ICGZNKUb\k_ja2]991cRB9jSKZpRYAU0:^OV
ETpOEicF6nq7o\L\JYqSI;9QAjq4]PnPoXqW4iX5cGHfIcU56\MncWemYm6LbdKD
Z5`aepNm1njAGCahBTiiF:C[mqLFNbnAMM14Bn@XYd_=dmq\Mk5dCN^H80c:ihSG
;93cDS2IFBDaG_a7;;_nb=ha8ZFH>?_5n[?01pWkfiJ\FO?:pKk7<2Q80bC718cK
MW7pe]L>NFbA4>JOVi@]KQ_NLUk1>0LbZm6J;>@Aem[UmAK?KiiO8K2JWWJ1<73<
A@`n6I6K:_hlhFkFgS:7gO:gABkjaL_10Ap7V][\a`qKg<<nbDp6]j6OMk:BC^0j
_[5?OO7qROPX9FW^iFa`;E1iUn@2bdhTAca7gocWOhp<?Wj_K^PoV=W2[RgoR@1i
X?]g9eJX67LlO?[GWq]<nOFIU;P5Z@hMOQ]]>MHEoZFW`6N11ICIdUg33N;<H<g3
2X[3ImGJ<Ka;J\<Mj`]53pLj]PBD`qWFDZF<VokRDchFDhhKQ4fDbcLAqd7od[C5
H7k2fL=RoEI^1>[?m<`UP2GZogbQOgVMKIl_k?GQcgWglc?0mO6T6<al0H6ER;TU
TZOe3Y>BMk:6nqTcYY^YmqMnZmdC\jZg?]SB_Z>aanm\IAg<S1U?<VZblP1jTp;R
l<1afMG70h_LWB7\`cHIWbAC@TdUaq]Y^ZE\<7f1]71YMB:m`[7k]UVan48j[QbR
?[QPlAWAV4md^Goc:7qZM7fUEZp[^n9Km5q565XCOMGKHpUGWPAYogk@JfgP27hC
dTM`LZd3Mo82VDViemSULm6i^k1NbSo<lZZAA6`hfa70S_M9_A\kX5AfKJ0<2k64
YPhVL]ReU00WqS1`ba0Gq?9Sb?E;pP2GS8Q8qNki`>dY@K8HM\:6BbLgERWkhjP=
h4LTQ>EQpIgNfc?J;Ci4U8SVk>N4YJhEqFU[nK\m<41gFX=6g\Too]A2XB7E]gV<
\;E:bEg`aHVl3kMRCZDe59mLDoU4jHc`Ld@=QH9BV31bLXLi;b;F7TbaKNBo4lRi
M`Gg7ocAkiF3gW2qS:cI`0jpC9\YK;n]e@:k4JT3n4;S8:ehZ^WLmi?DCW1=lHYG
P<A:p5;n@<nD:TN_SM[_@\IJPZA7B<B8YB]RW`SpNbeF`F>p;1bZ>o7j6oPA<^@B
T@ZLdF6WCNJ=`bMKMFA;[OH7ndoZA5OBjXF13A8GI]WNL=2c44fMmc;f6cj25npM
GJ?@J2qQga4]W<T`UMbk9AVDTI:=GgPha_l:?SF[]Qee0qJPYAjX[qT^8AfE1p2M
E3>dKl]HF2J?0YMlZVh\gCdWb_Th^Nj]f^nRpaoNLiDgqZ:=cZ89T:3\LMbfae41
NONBU>gO\NZYK3]8a1Z>JjUjS0`4Xl=RRGn]@iWn3Oe3de0oa?S4Th8e^l:8;9nG
QZaphOR@oXgpHf3EQ_<S^GN^b8BRX2]0Zndll1E@[O<IfbZpGQ<LY0J=E>4I4RmC
gnc3fW5YDcWK8cI2ob3Pi6G?273q<NAZ;?6p2U2\l_ZpXECiT;71SKO2mbe8oha;
>BqIjEP5WX^cXS]7H?lfOI3[g=7I@7EpnH;I6Hap9@X;8gOo`b6j483NdkjGb[`R
Q@7bCL@3C>_pF^NTgNY2D=]S3mdYPPUc2RH46c@TT@o@]OEgWUdBIL6J8_bHUToA
2iR<8BpEY0jQPGm0a6]N^ZO:JqKcad3K@l[BHI@31m6nL?B22?MK6VK]_TUL=[JM
4cb3LE3[nVSI5_GnJl[lK;9l^Kh`LeW_]_1meqeni:WKo_TXTT[HXD^0EJgEZ7\B
[UFd;Wq:@I\Z6^p`_De6l?\jdI?Om7Eq8G61\EnqoB9JUV\Zo<bW8iGScKAZNonB
ISnHaW0O^jipIjZnBOiW8;BX^dljRC_@XRfFPLkcpLQ5_3dM]g^K_de^LTQGb8hh
E1BM;5DF=n0;14_?0o9TbQBka^Po[m_j^RUK6L;6VL@12d?nnRdEU_9@_8]Q=_Zm
BaS5k6\qV<cAJ09cG`mA2ULQ@a7C6I8dNe38mni70[Om9<qX7jI@X;jZI<l18IK@
i2jF7mXYD8QA:on^=S>TVV1^od]UjjA3C`gNf[Dd@GDNb<Yn6iLNF9=@O@l?B2oH
cpJ8P4UGldf[EPAMhlLLA>0R[@J4P@j[MMh2\MUN9]eMP3C6kSl@c<2TGBgH<NmY
[5MbpGFBDbg85Xl<no:X45>Y31LJ4@PW8[CqA3]5dBo[SVU5[E]Qd=V<OA8BDB;9
a=>iM<]Y<W\oleUJhAmV<QpdQEgK@ZF=8STbSWki1m>Hb8B^4o4<Gp7UE>Obnq`m
2XdI3b8?:DH^KA?GqMW:l__ep`7AYZ9hI6njl:d430d[Em`6;cSD]Df@WBQ@pOYM
oW9mNL^QP0]2c>PZ8QK8MVLo5FUjS;kYP5c\hP=lZ_8_6O8cPFN0qULVmc]HMOS7
]EO>eC7hfbjm1@e5KiEW_S^T=DiI_2T`QHA`J=B\Aa;:L`0n14FW;jKVnCP2UTSP
qNdJl1dk1JF3Z^mmVD]V>0?PGmUEc:LmBCD9bAXFTjM\O2_gOW\F8\N\`e8pU^JU
EWRThUQZabljJb46n]EL]RAbQ4UARk<C6Y2<LAEk@Vc\H`J[D]K\Qh=DoiZEjaXm
nCf\VHlUZUe0nDMh:QJq8iDl_doYRm>R5k[OXUSC?@1SG4UEB@gpOa=WFD6qLn5?
>j]^d<l=eP=INQ3EQ:nZ>:dOKh6a214<]l:CAU?blN8bfhLAJ9mlEg4N4F5D_cq[
oDh`lHTin<8OdXeP>S638L]GiR3RDO[4^LpZg8h`DjqbkjERQPSX=hKikPPC0o2>
il<]2WS3KTCR8Ppji[HI7^g5NHEXW0Sj2_N[A;IchdVk@eG9H>JT<T782_E5Ok1O
9J=XPp1mF\Y0>\[l:E2H[fT9b86jc?1I5geJ<1WC]6OF9<62YG2KYEd?l=iUmkNY
q\:4[IcUkA1@E:H\MWHEIUAVTCX]fQPh0JdE2?oPndhb<G3ALPH8UK1m`Rg_PHYS
d3Bh3>b:hQ7d@hjYplTkC[<7nhnVIFFe@ac5>jdf?=TGcT:43HF3?^PNBb7g_FIS
74^Xd`B8m1i;B[3aIl96fiJIIOGPU6nEMS?`q\?5QQb6>Dm<b`mB;qeOM26XX7lk
:iM8N`V1ic2;ec9oE]K6XOcd6I]agkom2oCDN@E:8G<A=Z=b8Pd5JMqI\FZDIC;H
5mjM;NOWe3a>Hj`WQZK=87pjdC`2Ncl7`QPmmOITfk0b1adN1=RB`Sq?COGBmmq8
2?nT=:I]ZhCi37V60aH[^@BHoi7I43n:7XpI3fF^NapB;ZN:;Te;7[O5h6GbeUVY
\A>[W65gn3_\87pdCm<2SN8=?`J:]SJ8[0C8kSEDDU@kOH1kf[1lCeQ0kWeglq;:
j9a8^B>>`gKB_gEhX;<[4gSJ=1^AoE\Hc]oodD7ngiP98idI;B?Kq\j6_on[\^j<
RmoRZT6Qb_:e92kFTFi`aaN1>e01M9VBBL5K>2a`lC>C;A^QRaaG:Fh4`X651M>_
?XU1q>_;=oTNDBe?:0=MX`B][em1XgBBlC9>Dc1gdchNU?eUGo<1HJ:Sfl2:]OF\
cUHYTYV0=h:aJK?ZWR:m[_1Jq_0LPCFbC3lJTHi[YqO:<n?l^8d5MVd]Ma`LT;k`
_lA@QJF_5pH^XR>X<]IHGVgK1m3naf]a26bKf_[;2pRQd80g\ql;7o^\DKg9Sa3B
[OZ]ZCHo]Jm@GhKCcCb9PbanP\:\Jon:Yj?3g`GCS<BnOqi>^VONiVfh94:0Z;\F
H>@WhP;G9nOF7hp0DF4VB=qK2A]76jhdX\^0e_0WGJGfGnD[mR]S?2l3c7qcJA2\
HQAW10>5fR:d^pK`od9?cTj8\Tfln\G<[hg:^cW9;\@2G[=8c;TcB<Zc0I1JLTb<
SGlX>NglES:ofSPnE^qZjDB9f@j8i7^DAEH5W16mi?:hW14ij5]iei7bhSCfPC6l
H:mGUe5a`B?3_U]LQB;[4e>VBQ_?TgFLU4i2^e8m?\_O1?YCAcA<=`pkHQ;9e`CN
47PB2EXJNWQL<[RLGGl[VS5O\[adOkA\YmjT=lN`RV<3VG[1IlO8iUg8kKBkkah`
6FAP1bZJapQG1B7c5f8]31`idTHgG:K\_Hq;5koe\4TiE45TWi=[`cb2Z>Xj=5W8
Cp1Na85K[qA=QT]2UFeBdF\DC1>dA=KbD00jU[U?:QqPg>;3^a1;0n>_kcAXDN5?
I]:?7`iCEIhY:@9E[2A;XedjSpFF0EcKlqO_>g?1c@IOhVPgQifUdm8@oc[hNd_:
o3?eWpTQfQYL;men5bb4lnlM[lFPG@:_Cg9T8V<T]i3^X9jmV?E`f>\gH]R:q@Ra
:Al8@aF=aahW;dM8;i`GO^ZibeXg1aLj\2kdU<AhKNCShb\UTk>hXoH06i?JiD\A
DG@XKPaJXBOJp0A`SdlW]TEmK[<M^9@1F^Nf;J56Ig[?=Zd?<HSP?WIbS[V1fE`e
?Z2qeEGO1n^YRhh9b9eBG6a08Q0cnfIeSl^4eSm1PaSmN`oBNXH6>G0f1>]>;2bj
kZR91_aniAPWcL7k9PcEL^p<J=dGX7040`RWYWpkM<C8VDlZioFa5M51gAS_@f`d
\R4_?p[FK;k^BqbDEEdE7A\n1SG@C2Yk`EjGMcBCebqkcb[Kbi@Y^o_=D[d4@]Xi
o?I2iCJ_^qGO^@n>eqZ96jLk3gK__FWY;BpHbT;m3`TT09=;0[MW7po[MSe65pXD
3?^BNfV;h=fC;<geT\d^4ilbQpGRRPo?nqbZS^d_K\_kL4hV^KKPPD;_EjX2ZAV`
:_NlEp?5Oj?J]XloGbiQ^WF5I=HfdPJVDGFg^:XMUR3k8]KFe[7G?nBg6hiE\k[m
p72U2<TWS4[SXdC_=X@VI_>^3UeCRA0ZO@`R=;\7j6eQhYiZ>P9Jh]6aN?ebF3_;
S2Vg`V^V\XImm`On9H>qdPXMUH`qMibShN2l;?bcNW;_9[IjQ9Ag>ZZDeXqHa<X5
:EpPV4<i5n7FE;;FT\_R[`@P@I>^2=eLMmp=EJQFNImRGB9A?DG]oIqGhg3S>[@B
j\V3ZYLWI04V22]iEQD>hFPOFBqH=TC\U>`jcIXTnK_<8@AeA?PX:Iq9Ll1QnoCL
ZHb4cR0Uh\RfQd]Fo^nUkmV1_QDXM_O>fPkclZMCXakVTJeEWEGp73L@SRj9d7hA
:OHI5HdUoh_?Q@jaLj`WG>VMhU2_\ZY0W1Jh0WZ766Llcm1YYJ7=D2SGV[CSX7ki
U<qU@E7>]4C>kl1RAooZl9LqZFhdO5=HYXK3VDJX@@H[^W<nD0iMLQ;dA66200Ld
aWKJM2b:`G?gHYL6_BcL6N9`ALQWQdUng_5<8]T?ON:dk62e=:WcpMSbic4VKN69
\GBc2EJbT^=co:RR>mUjllOhQf<2DX<AJ7RbPY3H]pB=Md8dnq8FZfWoSFDE=d9M
]:k<b>fKeGXB0[@6lkF=p5aRKX1q:MFZDCpnfiX7aRq1?C\hJ9aE2<9Lah6ZEl<<
XaYZ3hGpNW:fDckOCAPO:l0m15igITXcpl?4<iC\bVnT5QD^mKUe^O7`hl[qbg<D
3b2peCOmDCiYQ\hECT>cTfGLKAF=RLf4c7c2K]8^6_5bTYdmh0SL^:Q;qd;^KiO]
cPL4B;S2NH2FI;<X4d@`\i92W3nU[L:\<cZ[]L;<7k:V:ma4qcf@GA?cqoh8]7gD
8PdE?^5LdSg4=_NXA3dVGE;TlC>cF8U8fiNoPpB>Q>M4V13M\o9@LJnYTjU=DDZC
EYqS85GG\]qlIk_JDNpDV3a0m0EjVe8H>0Nl9HD;JS0dZmFE]\f21N@TbSRFQOk_
ekk0]q`<84]5Pqh5ld;Kdq[AjFeU94eFR]EP5UXZ7<T611OY24k=6q\b]N7E@T?`
OiSik7:UBIOKSoM74pNNmT9j_G[:2J`F5W>fbSmek4FJkc@nY>qEVncnlNeE:_fk
I`T__=k_21@>CGMq5M1PFjW4V7ibHbHU6E:n0CdB]C=[QPp?e`Q]=NdK`bE0MlU5
b?KL<BIjR\OHWRHdM5LEV?m3FQBcP8CWI2ja31AEjn23RiQ;\>b8i_FDmq4A_f`J
:qJ?<XMiQpelf=O@ZqnO_IfNhB0l0W?[U^>eB=G^qF5Z_9SW]XmgCNc_Q=8Zfp@I
FD`5]Wkj@VB`o`BY6YR`9]L@2j2Hh6@6]L6H]E;j<je=pEN?]F^hqMbY@5nEYaoo
9kXBAKTVg?Z7m`cEEA[XCDJ`?\k5q0A?lGOCkbn:h49mgi@8fT`OI]Hm71aCa`0O
c:4WD07VkmM>;8fMjPP@:2kkh7S3SQBF`Aoa4P7WF;KCh6l=V=\<SM69c3eWAc2;
V_V`HQeQFpC@_M?`\@5i=C`aiAM]>q2;[GSYIqm4DL2bRI6bHHRi\ni8@1Ci1;Xk
oOGCYfpDBP_mNdSPKVVicM]_Dc;EQ3S_2VJ`l5Vj4We5`gbdB7P]8UBk1]_5c7ab
>4b4BUHWUAZMXOXqLeI^?MJd<lcTk\1?^Mf=1V2\AcQR<159`Ep^HakCAeqJM@[E
LRqKlPV?U;7c?gX<k`P39IA^TLb9ooT\Bk7Jl0M=dY\0]QNeU1G[RWRX[PM:8cnV
9YC^cXjiIK00gSMiM7@?>pjf<Vl?bg5lXTh@WJ@P_pfOm0XETp?R_[i[iET`oIYH
=L^Z;p21d^LoRPP_8A]M5h>b[d6UK;]Q]jdaqfg18`^GpTGCfj68Zc?W2_ZHSq1_
Y:=cTqPN5YZCc40bRdYjb<2Blem;>KO=O:p__1n\@40?lnDkXD3lQ4XqGMUN<om]
5PS<B_JPk5=p\LaRQFm@_3=YnZ\GHOk]D[mZJC@Ta<OY^EeXCUTbDK3i8TN@DSLW
JZdP\X:VR;Y1_S4P4=3ap[QPcTX<cdLU4L0<6jAe2qLjb[2PGoYOPS<\LK:h^keo
BQ@`nBWPMhSATjbdZ6b\?JCVG;q@[of]B8qOQ;d8T]R3I6KSfADEjOZpdZHdSe0@
K^DiMhLEOZTqhec`7B0m1dT2Y@id9C:ZpYX3W;<E3:2fMbLM_VDm1g1h;\W3f:Yk
>bb>XeAj1jO>aNFRmp6D?X[0bq<`N_g>4c3?mVg0RCSoU[1j;e2o\JY?G4NBIk81
oC^LVCVXWaQ::5qIA\QQ^07Ra[[nPYF>KG=q^iaH2iH5LZ@WJ01][P6q>6<LKTh2
Fk`mm`c0Y@dFqRAl2:o^MA95BA5kmb`iWdP?C=b7aX244;n?dS:<e2BW1d<>2pm:
X:ai1p^1h]dTh^<OO6_3?S<LCap5NSAAR4<WO;Re6iTc9[pK6@@VcM:PWL0UYHDM
0PPqcnQ0?DAB^?o]O?EF9ckbh@?2iM^USc_57lCCmaoa_`;THmqoM8bSKg2N;o\h
K<hLIlFT5BNbNTc:JhRME9Ccnon<h<X2K:9q]Ul8NDKq_aCM?W1Xn[AJiTnibjS9
q;;8akdL_cZ<K7C>54QkMY:Zf]?1UKZ`qHEHiCFmYPaIBSdjMbHX69HmDZ8CHqG6
7IV@Rd]CL:_W0??;0JaQOCboCYY@qZA2Z]ea2W>KHW>=E]CShUol4d>Eli0k8jdR
ldo>k]aQ6f^8g=HEQ:Ei9XdZKF`dUk0qa[:1>m]q:[[_11]JMEfo9lED_MRRoJSQ
MbNN\5@koc4=CDWLO<W^cXBG_3oOT@K7l3:2WohW>SqOaPkZaY$
`endprotected
	
				if(addr[3] && BL != `PAGEDEPTH)		// burst type  programming
				begin
					burst_type = 1'b1;   
					$display("-- burst type   = interleave.");
				end
				else
				begin
					`ifdef M16G4_M64G3		// jhkim(8.14)
						if (addr[3] && BL == `PAGEDEPTH) begin
						    $display("Warning: interleave mode does not support Full page Mode");
							$display("         interleave mode will be changed to sequential mode");
						end
					`endif
					burst_type = 1'b0;
					$display("-- burst type   = sequential.");
				end
	
				case(addr[6:4])		// CAS latency programming
					3'b001:begin	
					`ifdef NO_CL1
						  $display("Warning: cas latency 1 is not supported in 16M 4Gen. & 64M 3 Gen.");
					`else
						tSAC = `tSAC1; CL=1; tSHZ = `tSHZ1; 
						if( TCC_P < `tCC1-`MARGIN )
							$display("Warning: clock minimun cycle violation at cas latency=1");
						  $display("-- cas latency  = 1");
					`endif
					end 
					3'b010:begin
					`ifdef NO_CL2 //KyW
						  $display("Warning: cas latency 2 is not supported in this device.");
					`else
					   tSAC = `tSAC2; CL=2; tSHZ = `tSHZ2; 
						if( TCC_P < `tCC2-`MARGIN )
							$display("Warning: clock minimun cycle violation at cas latency=2");
					   $display("-- cas latency  = 2");
					`endif
					end
					3'b011:begin
					`ifdef NO_CL3 //KyW
						  $display("Warning: cas latency 3 is not supported in this device.");
					`else
					   tSAC = `tSAC3; CL=3; tSHZ = `tSHZ3; 
						if( TCC_P < `tCC3-`MARGIN )
							$display("Warning: clock minimun cycle violation at cas latency=3");
					   $display("-- cas latency  = 3");
					`endif
					end
					default	$display("Warning: Invalid CAS latency!");
				endcase
	
				if(addr[9])
				begin
					$display("-- Burst read single bit write mode");
					WBL = 1;
				end
`ifdef NOKIA
				REF16M_MODE = `FALSE;
				REF32M_MODE = `FALSE;
`endif
`ifdef MOBILE
				REF4BANK = `TRUE;
				REF2BANK = `FALSE;
				REF1BANK = `FALSE;
`endif
			end 
`ifdef NOKIA
			else if (addr[8:7] === 2'b01) begin
				if (addr[6:4] === 3'b000) begin
					if (addr[3] === 1'b0) begin
						$display("-- Partial Refresh mode (16M)");
						REF16M_MODE = `TRUE;
						REF32M_MODE = `FALSE;
					end
					else if (addr[3] === 1'b1) begin
						$display("-- Partial Refresh mode (32M)");
						REF32M_MODE = `TRUE;
						REF16M_MODE = `FALSE;
					end
				end
				else if (addr[4] === 1'b1) begin
					if (addr[2] === 1'b0) $display("-- VREFi is set to 1.4V");
					if (addr[2] === 1'b1) $display("-- VREFi is set to 0.9V");
				end
			end
`endif
`ifdef MOBILE
		else if (ba[1] === 1'b1 && ba[0] === 1'b0) begin //Extended MRS for Mobile DRAM
			case(addr[6:5]) // Drive Strength (DSC)
					2'b00:
						$display("-- Full drive strength");
					2'b01:
						$display("-- Half drive strength");
					default	$display("Warning: Invalid drive strength address!");
			endcase
			case(addr[4:3]) // TCSR
					2'b00:
						$display("-- TCSR (46'C~70'C) mode");
					2'b01:
						$display("-- TCSR (16'C~45'C) mode");
					2'b10:
						$display("-- TCSR (-25'C~15'C) mode");
					2'b11:
						$display("-- TCSR (71'C~85'C) mode");
					default	$display("Warning: Invalid TCSR address!");
			endcase
			case(addr[2:0]) // PASR
					3'b000: begin
						$display("-- PASR (4 banks) mode");
						REF4BANK = `TRUE;
						REF2BANK = `FALSE;
						REF1BANK = `FALSE;
					end
					3'b001: begin
						$display("-- PASR (2 banks) mode");
						REF4BANK = `FALSE;
						REF2BANK = `TRUE;
						REF1BANK = `FALSE;
					end
					3'b010: begin
						$display("-- PASR (1 banks) mode");
						REF4BANK = `FALSE;
						REF2BANK = `FALSE;
						REF1BANK = `TRUE;
					end
					default	$display("Warning: Invalid PASR address!");
			endcase
		end
`endif
			else
			begin
				$display("-- reserved for future use !!");
				$display("-- check address: [11,10,8,7] = %b",RFU);
			end

			`ifdef M16G4_M64G3
			  MRS_SET <= repeat (2) @(negedge pclk)  `TRUE; // From 3 -> 2
			`else
			  MRS_SET <= repeat (2) @(negedge pclk)  `TRUE; // From 3 -> 2
			`endif
		end 
	end

//`protected
m9B7ISQV5DT^<2PKc[_;63D\5M_[G?g8bmhZ1[bbUofGP@i46=dgNi6pGMB^@LGT
dI]i2]iSH^PcT[LZNSU20CVVWk\W:LJnH_6c>GO=k3oGhl^7q:5kZ`@WfZmL65`o
=]AmVAVY51lnEfB9MDimc8<Vfqn1a;h`pL2e@>ljAMa0ECbW6ZPlEq<idNS@J\cc
i?dka2\kg1@fk0p_j`II3G@[@jMhlZW4_:bpiQYL?0Z?@b0Q6GQ56KWJA8dAjkLP
BcWkN7qJa^MhUCA>9VgK7g3]ol0n70gQ8=6Q][DKKRO986]YDlYLN_K?Rnd9o?<q
WAc>?ofq:okF>i]i6>W=BF6ZH01W;Q^MYoUaD18PIgmZ>=pD_BAh53g::Si<=7B^
BV3MF5=@[V4N9K>^`=mb=bVKl4c?jfDnQ8H<JbQW_X_:OTKg3`<QNO>cd?`q03j>
Og<oA<@NBB:<T_VOC?ep3jhBA`=qmRMX>L\XC0V2g7EDG?C`:UUaal3`mW0pibK^
j^nnL4Yh_oH>[\YHZYCP43F;dj>AIAO\]@jO>f=6XBkljn0QK64O?JBak9:Q<UF7
p_0fdYYn077XU2L\f\=FgjQ2iE7`RNb?bIU`oQ1]9SS1q8P<?nVH08jk=m7_IfTL
TW:XZ]2Yc>0c1h6b`q3G]OKepi<JgSRQ1f9>4D9MHQknnlVIo6YcOdWY5ZJ<Z9^Z
naQbH<B3K<jcGkKY54g@ZPL9K2:Y7HLTOWYYi>d_a:8WedXhq8mTHUMWEU;KoT[e
MWh:NBQS3HD?R7Ic=RaAb^A?MFTo>d9DoHcC_9iE8:4hl09l=aClnWl=c60iQBdT
e]hXq=o43Rg4d;j7TGIlR\[?VFA[5cbNegAANfh;I=Lg@dP8oPNn=i9kfmiekUSN
YL>=UAc1M1F@cg1j?T4Q[d4kpF8hYM0V:NOMi@M6:f5ilc>hJioGc93V=3\bb21N
jd1[kFDBi^gpXY4ZWaW`L6TR[_8B_QY1JOFh>TWT7DmMmf^FSa4nEoERkSHW^3?L
BHNo:clUE;W2X1]@`76C]NZ?Q11?DkqMI7OKE[pjREQG5f7CVE;G`GTVCR@289nW
e841aQGANRB1I\eCcOJI<UdAB`cZ8Tn>SK>[k?09aR>cm]oC:bq05F:?ZWhlI?IZ
UdG_VkhRHUp0QAZAYGpbFA[7Tp`=lgoek`>95F>o2^k_UcK?NaVajlY>TdXhUCii
f;5k@M621PAj:Ob14;P0Y[264dKhJ\<0h[p^GNj8l2g:<dd2FPUQ3_7gF=G4adD\
YSU2hY=DFAdekHl3:dcknZl8VP4>X4@=kTo^RNkX5_i=J2cZV^Do?Qe07F7pIX5h
RU[IU5<gS42Qni``[<A0\Co]T33fYCd^e:h9bOfYXBSdi[Ni\P>ZVEY>Aa:nI55h
?cjLY\2Z4j4i0M^1pJ]]J^35MGiiE]AAQ8R`lici=BA[_ODGGRi1Qh>W5X?5ToZN
C\g5n:o^4ZgUP:?\@JY]bh<JHSPBA=Njjf0PiqgJ00FA52f=dY9]0E^=e]]V[C;0
JC==Ona`:`6^lon>Zfd9193KDjKgdl`<Z12ePK4=6\hZ:UGWEMdQWnIT9qb[]o^n
>qFYL4n6I>Y[B^L<0D>1\OhIlJ9EiUfZf?c=iTgHT7[6B;53JOOVJgH^kECUO8BH
kgQKDL5ZP]?[Kql>7_j6889d;3OG<1X_TKnbVpC9Nd0LCp60?EJjSgTT9bTGJPmj
VlED5W`4Lmo5Xg8WSL@9elph:`BQHaRKQJ^XPfn5i24[UZ7M8UcTaGSg2AMjWg87
B\Aj?h1pOcG7@>3plT1HX2P3HJ11J[1A:R=jDlYKZ[a:Ke8315hS??CRY5diTk0]
7^K3XnHgUJO\84ESl`12<>D7\1OhLJ?FQIkMC\3H2iFb5MdI=<mo@]^4n6ZP259d
Q4ph;eeCjoqPiN7HZ1pC>C0onUpFb:?L`]1HE^?@XJT^@6CmD]^V2DjL:f7eH>X0
<7cqTgELEiQ2R]JJ]=F?_QCcPZH;\1gS<2@6dF?^A=g^6BO?^@Q]mX15Da`>961O
EOA048TQBgX2L6Y>@iObq;YS3\2eq^jaDa6R2DY42Kgja9JE^G^MNJ>Zc930nLEk
2fQPgZ]fClAB]nbQJ:Ym5Z2U8?@lpUQ[Q>4pb>CkjV_Dl@kZI7F5MFlTpmZo]_PO
8Boo[Q:_TknlM]H9;<<j:oF<D3[hERQ\4SX;pT37I\XV6TbIn78C[`jIH8d?T5CY
cmAbSbda6K>1MBNGpBQA7^IYiU_@mPNK1ga=Q:;R5XCDge1hFh8bJK;OFqmj]@6N
[?=YCRJL9T<6g777<D2]_]cHQl7I`fO_g?^_OpOC:M_97aJQV7[_QI`0<241ZC=Q
kmH<OU@XIUH]f]NILp^5fBIi^qfCR]>QU07mZ0fgj\]]RP>k6iXm03YBRBb`PK21
7WfcYIFB`<iLGI:n?^9Zj`pcG7iS^GqoYAC:7pbMBK89<EeJ?Ac]VULiT2p2Mb=9
=Wd_OX\PfIhX^>0X8l:iJcUokKl85P7Tn`NAF3qOemE\=<Fon:aelqd=29IAKMNY
XNkVaJbj1:TT?Qc:SO[n?=9^M@bMS_nW@qS2e6GJ?c]KSY@W7E`=<n1_]>]H\QGY
f<Kdb_9D>P]27qShJH@Ia=\g7OJ_VnZ@l?U3ChOLIN[742eR]MMjmf5c>q\fAUaS
0q>hOb>HAdEOYlV>HP2h]hoVG0f:4:i34mp2PHlW[]qZ35CJ9N0]7]0V8lRCFVDf
FOLF0B@<eJ]piGZWf@biiDgZ4IM^mmq:4n:;iAO@biZN^IMcGLlNWM`pboc0cJ>4
aAoA;Mh\\T`Xp_fokn[j@AD]Yn3W;QEYo6eMndMekICM^@2pYiSGZ8TKalJB6\k\
Ta\MNT=YMUm`T@mK5Ifj?AKaIXOdUcc6J;6D9ARhpd5PdQ\]p_Y]2SDTcJ7SBPc3
X;9nYMX^X;[B`Q]\Yf21_9_IJ@I^4A1if9X[eb1RkE[U?2b;a96]ndYm342mApmB
nmD06LG3gMfCOTH;3H8^`0pNb0I4l]qSiVgZZZ0m?UeIYUl?fUP3j0R@lkTjnM9f
ZNp`K8gbK7Ai=K<9Zj?_>2QqCW8YS:RSk:dVjb;oRkX42cfhhigR5aLilli33J\Y
QTI?DV\IOX:NP28`VEE2g]WHHN4M@L4[pjQ7TJG9Vpcb5K^S5cX=N\R48`Y438qV
_]cLk9:_5;3<]da90nbBM0UI@@p304\Y\W^EOaW\UkJ[iACDV8Vl6[igfP:<Io7\
o99B]>4:4_\fDK^<NkX;6?gjGY1\Tq?AIXRjf]qIUITSl[k`MKMGAQK>4=5YN;2P
1[qNToL>aZVQGIhBGEJ?e>]11TW2V`h1WEL[YX3ITNS2E4]nm1?2n1LcbGlEiTl5
Q66[[pK<V5\I>d]GBUQQL?^`E_V3LFI8a<FSjlO7IZcIRpA8i_SX2ApiLLgoC=i4
K\9W;7?lYUMWF6_QQ]]YGF`@lV7Shp1C<H^[Ydq0T]bNHLdqceJLT>DepYPm2_oS
ebZ3i3SCiHfCWB1\i;\m<ShBqToWYU5W[FUmIDR?NST:H1<cYUlmEihbOP<Db[>6
ngEnqmYjmZO`gQ9F<YaYS98FgnVkj2YE`V=U1PlCMn63Na1o5nMWnfT79=57GeWO
[=AHESDgpF3UU`<RJ3Y4QPmMIaHJ=Z?:O:3:UQ=QDgBLXq_9K\6\qi7hNAeHcRjR
28KKK7LEh_Ai\2ogVGfS@\T_jNSMlWN3<8E5R520R1_bWGB[lUAn3PSTE7Hah4:m
jTJ\_H1kT4Ng122pfeMJm@k=diFSP\?kQ:6WflbkXXnKB88V?JfP9NVV?9?[[mO_
mPOMIOaD]WW\f0;AQ^i\hSgkR^f?B=fYb1n555q2TUacUmg23@cbalEO^@<h>Q;?
5IICDm^P[m?CH5XM?IoNWKd0A0f_bLDM_gRf<`<<T`\lj5b?1^LFZPLRg<?_Mq9E
ejLL`64SX_=gdd3WEi^:kY5CaJJ<m[X>DaecfU5YSQgnd3HglkRXo5G^a^HE3b92
QIT8\nT15k7aCkmDG;pJVBCW6\qEI`<Q_`Mc4\BGG<FVa6SkSiSCciIKWbiQSS>I
>ZUDgbmP5]^BTW[3>fXBVGj4;j9A;[p^WUdFTo>d9DoHcC_Z:TN_3^hcDln]5eYP
JAf[\]UUamNXO`Qob]e4=0ooEYU:IFZL^`=iKD6E=Eaqf]SA`?nUc;:8`7_cmPNg
BNm4qN]0;Xa0q61L\J84GdfSigj><_F?hk8@glY6_62l_G]2h]Y4hd\UW$
`endprotected

		if(Mode[bank_id] == `TRUE)
		begin
		    if( addr[`ADDR_AP] == `TRUE)
		    begin
`ifdef v
		$display(">> read with auto precharge(%0s) at 	%t",str,CUR_TIME);
`endif
				auto_flag[bank_id] <= @(negedge pclk) `TRUE;
				rd_autoprech_reg <= @(negedge pclk) ba;
			end
		    else begin
`ifdef v
	    $display(">> read (%0s) at %t ",str,CUR_TIME);
`endif
				auto_flag[bank_id] <= @(negedge pclk) `FALSE;
			end
		end 

		else begin
`ifdef v
	$display("Illegal Read %0s is not activated",str);
`endif
			disable read_block;
		end

		READ_MODE = `TRUE;	// read operation start
		TCAS_P = CUR_TIME;

		m_addr = {r_addr, c_addr};

		if(~burst_type)
			increment_read;
		else	
			interleave_read;

		`ifdef M16G4_M64G3
		`else
		  if( auto_flag[bank_id] )
		  begin
			if( BL != 1)	
 				auto_flagx <= @(negedge pclk) `TRUE;
			->autostart;
		  end
		`endif

		read_task;			// task call

		READ_MODE = `FALSE;   // read operation end.
//        last_rw = CUR_TIME;
		last_rw = TCLK_H;

		if( auto_flag[bank_id] )
		begin
//			rd_autoprech_reg = c_bank_addr;
			if ({CSB_FLAG,RASB_FLAG,CASB_FLAG} == 3'b010 && bank_id === ba)
				$display($time, " Warning: For actual device, this gapless command would be illegal");
			else
				->rd_autoprecharge;
		end
	end

/*
 *-----------------------------------------------------
 *	 WRITE command									 
 *-----------------------------------------------------
 */

//always  @(write)
always  @(posedge write_event)//KyW ... 0408 for VCS
	begin:write_block 
		integer bank_id;
		reg		[8*8:1] str;

		if(CUR_TIME - TCAS_P < `tCCD-`MARGIN)
		begin
			$display("Warning: tCCD violation at %t", CUR_TIME);
			disable write_block;
		end

	`ifdef M512_X4
		c_addr = {addr[12:11],addr[`nCOL-3:0]};
	`else
	`ifdef M512_X8
		c_addr = {addr[11],addr[`nCOL-2:0]};
	`else
	`ifdef M128_M256_X4 // 98.6.30 BYC
		c_addr = {addr[11],addr[`nCOL-2:0]};
	`else
		c_addr = addr[`BIT_C];
	`endif
	`endif
	`endif
		c_bank_addr = ba;

		bank_id = BankSelect(ba);
		str = PrintBank(ba);
		r_addr = r_addr_[bank_id];

		//if(CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) < `tRCD-`MARGIN)
		if ((bank_id == 0) && (CUR_TIME - TRAS_PP0 < `tRCD-`MARGIN) ||
			(bank_id == 1) && (CUR_TIME - TRAS_PP1 < `tRCD-`MARGIN) ||
			(bank_id == 2) && (CUR_TIME - TRAS_PP2 < `tRCD-`MARGIN) ||
			(bank_id == 3) && (CUR_TIME - TRAS_PP3 < `tRCD-`MARGIN))
		begin
			$display("Warning: tRCD violation at %t", CUR_TIME);
			disable write_block;
		end

		if(Mode[bank_id] == `TRUE)
		begin
			if(addr[`ADDR_AP]) 
			begin
`ifdef v
		$display(">> write with auto precharge( %0s ) at 	%t",str,CUR_TIME);
`endif
				auto_flag[bank_id]  <= @(negedge pclk) `TRUE;
//`ifdef RDL2
				if (`tRDL == 2)
					wr_autoprech_reg2 <= @(negedge pclk) ba;
//`else
				else
					wr_autoprech_reg <= @(negedge pclk) ba;
//`endif
			end
			else begin
`ifdef v
		$display(">> write ( %0s ) at 	%t",str,CUR_TIME);
`endif
				auto_flag[bank_id]  <= @(negedge pclk) `FALSE;
/*
				if (auto_flag == `TRUE && autoprech_reg == ba)
				  auto_flag = `FALSE;
*/
			end
		end
		else 
		begin
			$display("Warning: Illegal write command at %t",CUR_TIME);
			disable write_block;
		end

		WRITE_MODE = `TRUE;
		TCAS_P = CUR_TIME;

		m_addr = {r_addr, c_addr};

		`ifdef M16G4_M64G3
		`else
		  if( auto_flag[bank_id] )
		  begin
			if( WBL != 1)	
 				auto_flagx <= @(negedge pclk) `TRUE;
			->autostart;
		  end
		`endif

		write_task;

		WRITE_MODE <= #(`tSH) `FALSE;
        	last_rw = CUR_TIME;

		@(posedge pclk);
		if(auto_flag[bank_id]) begin
			if ({CSB_FLAG,RASB_FLAG,CASB_FLAG} == 3'b010 && bank_id === ba)
				$display($time, " Warning: For actual device, this gapless command would be illegal");
			else begin
//`ifdef RDL2
				if (`tRDL == 2)
					#0 ->wr_autoprecharge2;
//`else
				else
					->wr_autoprecharge;
//`endif
			end
		end
	end

//`protected
ZJaODSQd5DT^<kE]LAOYk4MTg;8_0OlKMaY6P2:CVUFZMYc?mRF[p@=N5jb??ae@
;C4WQYCLDAU@IK2;LkInCZU;73`Bhf3m:hDNdX^Vi<XeR`NSPh^p66FX4O66RKcA
n6Yp0i9VXjqd5mXF^:=@WJgGao3@5mM[jl1RgYq@P?hQ2YqEh]aiM:CZhME5nUaX
g;`]Qi9d@p9IgPYMEfTQc7iK<0nA:[WN8jeACTp[c5NO^X3LEQbc9S3Qa1^lVJ@Z
eJYe5iBkOgke3TDKUFHoJ\MEjMoPi`g40`qWlJn[Kcp`BO@WICd[O[RFSG:Q582U
SZEa0CL:kp@^<8TQ8qV2eo1dJa=aH^5S`AWBVflfEgWKmpO1IUoc5EW:TY2[ZIoY
LHE=pgE?iWD6E60\2G9hmh[fQaUk;Khn[9oENjDgWNK]58UH]R2<QT::4H?;:pQ4
7D?UApj6U[cKcd\e^fXZ><7L4DdWV<8niE4fgM?<2<]080GJKBEO:<_cj8F;f]jJ
7?^_Ok<6lK^k0Paa8i5CP8VC=B1[^p_B1n1kZK4khl3b;i9cQHq\XT\Jh6R_HYQd
NEL`dARqPP<gIKlp[JU9Y];FNJB0SoJC5Q2P4S29ZdQ<S<S>>OWqS_aa\5jkVY\Q
IKFXK6AnQmUKY<dfVai^6An^mo5@Gl1l8SDfCKaQdSH4hk8]<J=SeZ2UYDPEC_:m
25D2h6Z<9DUqRRW^[i@>WSYYDk;EGNm4p1?;S46OqUT`U<N]1Jldf7KQ=OLA9l;[
o@bZUH6310AQpo66kAkW@=:898Jf5AZHE5P9Ri7XNn;6]_GF3C]6?11eqAee9OIN
[9dmp8blCg=h_=5^dcB_`ba4VmTIU2hZJR?`>R^C?;Z^1\[OfE@^gISN_j?`@05I
ZRQ:2TP9S=Qbdp4MIHlhJqG\H^<Y`<^h^:EPmmkMN:KUcG`Fk:X04J4O0b7X>nJ8
57_MepU^fHY7X6BaN\[O8kSI?;P@ql`iLK^fpmjf]Yo]WT51^IFm`H4?YgW<[^4_
qD2Xk@i`ic5h;<`f0m>SQHZq^<c7ILgQH9hVgZ@1oZjP^U[7Z14hT>o<gW>pXBEh
F\]jh]PKoB_:`@[mM6]`7DV6A2WeIomqoM6ngMoF]`fpdnH6YWh3oJ]QdWY2qjJQ
\Bc^AWP_EIAg_3C[ebgcEK^b@IX5cM:edMCpY2;7IFRjb]\XPnlURHZqTFimom6A
T^4:ehIi[N2EVQoj6WPMKI6PUV4ea?RY>gIAm77A=Qi[edISBo@SIAUYGI1B7K4O
6WX^iXk>DZb61E=ZMm6q_0FdJ@L:1mkdZYPLi^B@RY^PMSWCHXMXdS0d4iSjqnWO
Vln6O7S`4@iN<EKlGlS92al>6Sf_F4U1`CeV8UKQmhKT>W3lC:k_L]Umj9P]g@Tc
lC4Dl]T_XVc4DB;]WXnA@ZY=p3olF1c>p6b?o>6Uq`6DHcHiWGmiI^4kE46aZcIo
Hl]MP\SqaLXAdH_PQH<;5?OVCipL<bokjVVk9Mf>ZQ_0?[K\oVkgS@30A;8lWqE^
diGG2Y7ffhOTI`OLCYWRdVMaWF`_8MhO1ng5cY5KX\^j7moLW_7fBX_9DHRWTSLH
oTi=K2`Zhd^5kF[Nd89m<R7<E0Ej6fgaP4[Y3pbL_>DMdmgg8^PgmP:Ojonaof]6
UV46jPQ74iq@[iYFoH<g3ZMU7_8<8I_:>S5LblS`U1[j1i0bML514=WWNHSQUj[k
;CfoWZ`LQUU_`mSBZf1HlTo?fNO4P2]U??DcH84i\G0olXj1fAp8>FF0]Yo`kWPm
G]6E9;JCfe_URdgXIJ8XW;Rp_fnJ52K7nND[nB0BZd@bl?NbQ0JikE1@>XHGe1IR
HM93K>U[QLW@^8Ml>ehWIJoYN1J\GfE[OLG22:lg5OJ7eRN9YPjNcGV]6hMH2@oq
jBJ:9oFKG6S^98FfLok]8g<C;5::=cV9KMRn`K^TYJ7FO3R=mmGJM?OWTmBqb^[h
oLUq6K0^\6QqN<oLZnCRffPF`N@fh]HAD_gK2_TcdSb2;Uf0SAU_C]R4?OS<>Y6:
SiBfX3Tj_FjZIdXWJhhVU9@kP\<Id;^pWV02kgTqnfIEd?gWR;bTfId69Va?kfAM
_nDPTY4qP?g6PUUDg9ARlfVDaY`fEIiN;AR9\YOLmo`hC0M20jqO_<g?DKqgJ@>0
V<KVKpl7?aTdJGNG1kG^CSAD8X1PE8OTY9d\Uj00WGkY]`_\^XILS9\ih426GgO5
\GO\>[lfNTnaJ;;01Ga?[_QfJ>1Aa<VcQ?`3p12CPHfoMIcMcl`O84agLpLjV7@M
MLm[kdl4<V0K^K8O`:c[[3\NJ`JiSk6VlZQ2q_@M\062q?;@i[F7Hg=mZNmQU5@U
_QjiA:5LhRB^FKf=OGlJROe?NSW\jim<UgYpE4=AfAhqi^Wo7?qVNk2MhSVikA@H
XJ4aMBDKkN_:P`ZkhLHZlZL<[[cHT8U3IdOE=:bMnjYf]20MoC<VVk_iaUf6;;AL
M3]pdC?RD3j1C_WVa`BoBBZCaiUSLBCU_EQF:lk06@FfXdI9@FF3[8WnaY7LZ[jU
^Kaido?W5T@d@nGeqZBgFeN>LRJ[X50dc[AXKc>cJLGGZB74ECX>f]G8:C\Mj@;>
B@iTJc`n`d]7>2n;hZ0g<>79T@\mEpgl`fk?NjD@kg@ARog5PlE9G9WMg>2jK]m[
P>?`odJ9`Q5_e`k::iSbdaDLVD61=QBMOaW`UQqMg7?]\B=A0]XKTB?IN@cb1?P]
ohV2=PJYWJIdA=Wh_joR=58SikIJLVKk?d?8UCE\VU2>`l2e]:pSS6`hMA>S8b13
L7I^d3_<hKXQN<hekTZi[;0Nj<i7KFAF5Smg7:Q\B]l7QFc]ekfOcj@8DCho[pEM
Fdhb7qhYDLJm3o;RSLa;CZL:CXdJcOkLM`o:ci7]l03=[Xk2;O>`kC=L?OQ1?oj3
XTO_[UEA@7Q3ClpK5Fo2ZYp@I56_^6<5m[nGH_13:==_R:63EqLCf=FYV;=@nF^9
O>bEEUHiVShT0<1>AmpfD=iW=X1a7R6?mO:oLMJIB]5mH[m6jTCWDm<eCeiIN]4R
>^pTT0ASQ$
`endprotected

/*
 *-----------------------------------------------------
 *	 PRECHARGE command								 
 *-----------------------------------------------------
 */

// precharge command performs to disable active operation.

always	@(precharge)
	begin : prech_op
		integer bank_id;
		integer i;
		reg		[8*8:1] str;
		reg		[8*8:1] str1;

		`ifdef NBANK4
		  bank_id = BankSelect(prech_reg[2:1]);
		  str = PrintBank(prech_reg[2:1]);
		`endif
		`ifdef NBANK2
		  bank_id = BankSelect(prech_reg[1]);
		  str = PrintBank(prech_reg[1]);
	    	`endif
//`protected
?d_1nSQH5DT^<G>lkij71ONdQI9W6APVh]hcH<dmhKBf>YV;:\MpSD;3X8Kdd<47
:_g><3HS9Y=Zd@YpCSa;AI2fQdLM663GX>dX>;hq7`R?7?pPP2JN5VGeFhg4ONgE
RI9@oZJ@8k\1=HVMFVF7JJjUQqjW0?K:Pq;caPLK^L0SoeLW`[`Ji<c^d@abi31K
m4XId3j:H6DI_pJY`M@<cp_;d[2?q;JA8Ufh[bi]=5me5I@o6BF=gA@WZleCDaN4
HT@]59@GD18L8bRkj2VdFl5JGmB6GG6lUZUdQ2jk5\9C^gUa9RdG[E]k\02p?Y>Y
iVM<WSO8S\P2hjnX9R607CN60;`Z6B9fibTLSW92T@:A7_nf[cOg3GhN?YP?hBEo
lUj\:C3LaJ]54KNdLSS=S6pX8ZHZR:4cHZ]9e>caXj:T>BOU@4H8Tb^GFBX4mM4Z
SI]k2KFRCpHO41LFn0o2g2E7fkMf6>[UNMk]KPC65[XEH7IGh`77TLCb1i;<W?PE
UcKia86l:nR:e2ZQXA<eMYKY8:U3L71kok9Xpe``GEB5<UnifAjFZ58d<a^?n04J
?30_[]2O7id`RC2lL@Q:g_HfGNXUW[5:E9a;Wn:TO]]c@2i0hEUMCM8:J<nE\pgS
cgGEhq[k]aJjKUFTb?02h^SkhAS[_`eBTOd3J1DnQ8f:j0X[7;OEY]giSk`_6;Sb
gaag4SD@mH?K91LcZBIj@G`74\e^HcHF<M\Di`QopG1[<FR9j=b8gK13S6h?qKCZ
V45ljR<4M?^dHg1B92Qqk;6oG`<qlFXa_Wq@Wa1=\jPX7Ih;fHLW\ODE:c_n=DCL
ZBL\X0S5GhKOd[UdYdR:0_[\RO2DcfY6I;=ghbK?49N:hPWnZ;8D0alQDX`4[4ed
A_Rm1Z1ZM_m4M=JNWe0WZ3\2Do`WBXV>IK]@ES<TY4pf]8L>`?bR1::b=jI;A5Pa
A\d7egP0661@:=Mm@34h;fITW;VOgoQbPCW6GLleTS_84bX>gfafZhlSTS7166Oo
hYNIlp=aPEih`7Of8gVcCW1W;7nnB[@>^@_lJ;X?01?T3M8glR^2n`k`F81P`@iI
pFBb9j\]X>O>N?S8Xh[PZgO0FQSg\_Lhn_a0^aTo54Z=]d8FUYYIJJXFUCa\M5Vc
96C]WfH9e8?[TgLg;Pi`eW3TTOBpXPbN[n0_5Ik@;f?bB:BXeLcXBXVG\=iI7`Ei
3S]k:W788CIUZ=1EY6<4Nob9_1AgUTND5j8Kf^AdomPLWZPBC>\@bhpCV0@I=nAN
?aD988=WJDijHD4`bE<a`3GVbO@^nLK;9[R<MNME=O=oZfaeVkmMI>;9jDf>P6T6
2]@2n14^jQD]AL7XPP7lmLUo2p?6c@GMHF9D>3l=dT\V1d3KlRSkBJT[:`4dP;Ha
XQEQ1gDnpO??L6Rk9EigS7mI54_Ykem_8JJFl;EB^qjj1lIRZEnb1>RkgbMW^0cY
q[Q<JeNka[@ETOU]GGH]i]`fNbEadO8HXpYU^bNIkSMO]JIEFKmEWgI8q19hjU8F
0P_BRG^I2ZQ]0651<Y;j04GB[baJ4lcm^0=i[SjlD]SJ1c5?Kk115nJEA=T3BbQj
VnD;@fII1ZDW2;FVqIIn0U\8q]N79VmFqknI2l`fp\C[UTSh5QBoeaV]c=DWfU8:
W6LR;<PdB2HpCelL7bFqSJek8\?XmCkQ3O3;E>=<K\^<cB9^BXeOG`n2h6V0gag<
bd?H\_3]1aWjoUdACgChUdRLdj8\iD]hTcaKVViTS6mTjL;`:O7\dSpk0L7CXIpP
^J76Jf7Fce=LDM_Ef<j^jqKcM2i`ApN>ecc:1P4hY9BK`j4E2eYR48?g>ic9C3VG
^5LGAn;Pp6]3SNJREK`gLD2[9WL6?7]5G=h?hoMiR6_`[>cgk]i84[anIo?1q8kD
O6chG\9`>XnTUbgUg8VJ@=]4nPeQBK>Ep9bm4>M<Skn\02`nfDHVn0>LW1^;c7M<
Df5WqlnOjk2q;__S9:a7mOl4VbY?4o11pgX`LT`YdI=9_YV4:]\;8?k7QFnFm2:\
d4AYOAg06>apim83eI_kN^2B96=;8D8>XiAo>nRjDR>eB9CC]eNTXJP9K4`FZ_3c
_flJL@JlAHjWd01Zqb7k:g8D[bQZ3IM9e8HDBPbPkVJMHkM:AQ7XWV<=dl6pBW;O
1;3>CREnnNHYMFPeT\66;7MW]P5lK1L\N9Ge82q6ZV?8LhX<8QiCiT=Tm7hN5O?J
28J^^5C81NWN<E1X4pP_?`Kh?`1;C>JRVVTkA=?l<:D0k@33HoT_IVZ^d7ECH>5n
?NLE9d\jS9IRJ<@RbqCH\;9VlpnCmM3]6qLcamLKpRgjBAeTpXkXolK3q0jT7`e8
]UZCIemGk8jQn1ceTAON2S\<=h6BD:Q3G?Q:LoRP]l`b]pV`k0PLHpc2R[\U_LDS
4_1Ah1CHH2Ggdja18P8==e:C_jqC6?QWL19C\@FUOWYEK]R55`dSE>K3OCMSRV@I
Rn2N`n2T8CFVfW`O<^plQN6kFfpY?LE3F@PnKEYqUkk6TfF4Xb=?1QRcR8kSgD0N
?HaKI]LYJ3=GfLpIJg0Y9Rlc;be>nphBV[fen[GDcCGkb7;\5b`i?UPlfhg=qi=m
gLaB3U>@4;Cqm_b60bfWT;SJHigX=aW:\DlR\cp1NeMbc5MT2>^c<>YO=AEHZnEK
iI<9TpeMQTlFBLNRe_@;p[aaKOim4E9\n@29=>]TZ?J<IG]0MWmp]_L5<;ed96=5
;lpnHdG7<aRI]`PWI^aD?bOaF^2?XEc^`pC2aQA4Z2idp:FBED]_R<noYmJ3Z3Q?
23OkYTj]\8c6pBG3A1bVpNmPR>8aDMK^dkW1`8[2I;MOGOHcOIooHAJ>_m_Yj4]a
0JY]PPM<n:JUL[jg0;6^=0iJnm<JIqA>b>Laq_F5J_8JdN1HE5Y5WWO[I4fg<3UC
ChCXD[A43YZ9T?TOmHPbTgG4DZZmNW:B0]TlOZf5m7L9^C16GAQW\oJBlYG_C[gC
F<F6AUYBdYimO4[cN]P=4h9S4p^N5@1WB^>GnnjDb=RUcOR2]Y^39iGbHDWl:aml
e1^;OBGP>Vl6J2PMEUelC^Oomj@<9`_l9^P3>b69`K?oqlRCQhQ6O2^U@:2iN[bd
a_H=^[1NbPn\W^QEom@PddX:hZb4?^[Fl^4m0_EH<jCQG5X[VWRa[T]>m1V]9LZq
1E>cBJ\XB2`<G`]lVD5KX>R3bi1gdnYoN=1Z_ER7XmdSoNK=`1Z3;fhT^c<nbEfe
nGDFhD173CJ<`;:1nmpSgWN\AaqlY]VEC^7]?dM;Na^Y3e:BdhMfVbRmN0]JWI2<
\7H`1O1Y<gO`GG<K`8pESLL0HJAdnP1n_lM`NMZT<fj7L]ORo4U8I;i:Cd\R^ifH
:8nI?__GcPcGO[51lL:5]VoWEl^4f_5[OTb3=o4EJP2YW;F4Ccf8EA;q_6TSZDWm
o;i\92TjC6;b3Uq]AjSSAMpQZ98k;q84b6JGReD54_aTYdo:J`_Mfo<N_T987T\H
NTL_kQl7H1n@a]f2FU]o\0Si]<^NJ?o:AKGkQp0a3P`ePM@>D>P@<YKeWea>okBF
RilZ`kHKQNJ5Bi;9aCSd9:7e=Xl`;BM^?__E9me[RcD`^1fR^DoKmo4:GmaN\0gF
Bh?8bZ6bPWMlf^7\AUCm9R=Q7TZAEEGY:A_P9m3JM]VaI:V^^cok7d<ihVpMBn0O
:ghjmeARmO4\n;6lR9b^6o<^G?BjN>cPO2[ZA=b2=bdkcMo9k56dAIHY15:\cQPf
MST2iVVX5N9ekqRa?cMD8Tk4:U5PXR;o_5eKV<0L\8NfB9[V`N=nLG5Yb`K]6QIT
j4[jRK4h=ekK\U\eJN0d8CL;DiGfFgTopP0H451`Y]=[OoXb1eI8o`\bolLS]lI^
]N0g\6A?o[\=L?fDei?a\Ah::^U0<Om>`Xbn1KmD[UK0o:_3QJlqOP\X[kfh39l9
T5``^aP6nXHFlHPUa3h\5Z]EVaa[6UVQ6e`m]0UddTG[lB:CILRB=NW6_0=9eT\^
XDUe66aTC]]>0XEl79QD5843qR12miB1<ih8=;ZWM:>J76L<3f<A`YQV:BEEf_1q
CC7a8XmCF@Z=MfFaMMXeYPo9a\Sh1<WEpL_n:1a3iA3BI>N`liRRI6INZ<0=X1=5
5]^IOgVLb0;1q152Ij7p=oS4C788Xfh5e=q@WHB1njAHX5=pdjA^CG>h>_OS\GE2
k9kO_e`YH83HhT2:7lR]H`R[h4pK@JGZXTd`a^VNS=o8ig=e^20f\J5[G?2iTZ]@
Y0NV9pPlPP[0K=El`KZ=`4f`nb=1>Q4];_g:mS>b<5?mk]NlqP^=71ZVHoED_8DM
>Zm_b6IYRgWV[mB<kdj;Xd?nGH>qJmo[ZBmqXVoiOJ4N`K?e\Nd\`9HJ[17Sa]JC
3[=kJW@g>aqNf8FMDoq6anR\?dl;OX;FIC<2:Lk06<KGMmK=3LbOHWb]o^ha\H[Y
Em?G10>\7<Of4=1QhDpX<W=Daqf40?ZWjg\BF55LOUPcWq]UC]CN\Fef_n?MAh6[
f3dKDjLgQgVfjm?WKClSIg]REeMKLlMP2llQk^oXBXKf7_;`W85LX=dXL\lHnR=B
K\Sc2LTY0p]e^jT_gp>m=7Sd9[q=S=WV:E@6RcU[[kXJUcq\3hU1cBMY2fmM0N]1
iKC?JDMoC3AeCZ6kE_F7_]b`BgDoanM:`hNmb6UB;E?0l^1Gk8bO?N;3;dG`fmVk
eiGEac=XI3\o0XZZQpBR4QKl3qS3G]P^ifqUe0<X<Q[jHh0Y;XZc?m\b>qXfRN5H
ap:IEB:>?qKcVPOj<p[3RRHba;1GhmT<=jihPmiQ2Z;ET[A`C<EOO^VH3mDo8JJS
^fDe=:m1GQC[g2H@SYk]EdPZ8f`c5ZnAk<ndQMKEbm7oONM>2OH0q9HMZojfqiP:
iU]e=QW>hV@FmWa\W5Oq6>]V71W=Z2C_^kXYd1HDb7q3=Z9G9aqmDR5?J2NhEi4g
7>>AV5E`]mOPMB1li]Qincp@XF^W;ch71Cf_G\2\T5j0U1DgXBaI4[a_K6pPNRSk
3jp4?ng757V`PH>l=hPJ9UGH@A3_YWeihpe0QV`]b$
`endprotected

/*
 *-----------------------------------------------------
 *	 tRDL=2 AUTO PRECHARGE command	 
 *-----------------------------------------------------
 */

always @(wr_autoprecharge2) begin
	wr_autoprech_reg = wr_autoprech_reg2;
	@(posedge pclk);
	if ({CSB_FLAG,RASB_FLAG,CASB_FLAG} == 3'b010 && wr_autoprech_reg === ba)
		$display($time, " Warning: For actual device, this 1-clk-gap command would be illegal");
	else
		->wr_autoprecharge;
end

/*
 *-----------------------------------------------------
 *	 READ AUTO PRECHARGE command								 
 *-----------------------------------------------------
 */

always	@(rd_autoprecharge or posedge rd_reautoprecharge)
begin : rd_autoprech_op
real difftime;
integer bank_id;
reg		[8*8:1] str;
reg		tmp_reauto;
integer	prev_bank;
integer tmp_bank;

	tmp_reauto = `FALSE;
	bank_id = BankSelect(rd_autoprech_reg);
	if (rd_reautoprecharge == `TRUE) begin
		rd_reautoprecharge = `FALSE;
		tmp_bank = prev_bank;
	end
	else
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);
	//difftime = $realtime - $bitstoreal(TRAS_PP[tmp_bank]);
			case(tmp_bank)//TRAS_PP
				'd0:	difftime = $realtime-TRAS_PP0;
				'd1:	difftime = $realtime-TRAS_PP1;
				'd2:	difftime = $realtime-TRAS_PP2;
				'd3:	difftime = $realtime-TRAS_PP3;
			endcase//TRAS_PP
	if(difftime < `tRASmin-`MARGIN)
	begin
	  `ifdef M64G3_M128_M256
		//auto_flagx <= `TRUE;				// KyW ... 0624 : rev 3.3
		//auto_flagx <= #(`tRASmin-difftime) `FALSE;	// KyW ... 0624 : rev 3.3
		  prev_bank <= #(`tRASmin-difftime) tmp_bank;
		  rd_reautoprecharge <= #(`tRASmin-difftime) `TRUE;
		  tmp_reauto = `TRUE;
`ifdef v
  $display(" Info: Staring Auto precharge (%s) delayed by tRASmin violation at %t", str, $time);
`endif
//		  #0 disable rd_autoprech_op;
	  `else
		rd_reautoprecharge = `FALSE;
		$display("Warning: tRASmin violation at %t", $realtime);
		disable rd_autoprech_op;
	  `endif
	end
	if(difftime > `tRASmax+`MARGIN)
	begin
		$display("Warning: tRASmax violation at %t", $realtime);
	end

	`ifdef M16G4_M64G3
		if (tmp_reauto == `FALSE) begin
	`endif
`ifdef v
$display(">> auto precharge ( %0s) at	%t", str, $realtime);
`endif
	Mode[tmp_bank] = 0;

	precharge_flag[tmp_bank] = `TRUE;
	rd_kill_bank = tmp_bank;
		->rd_precharge_flag_kill;
	//TPRE_P[tmp_bank] = $realtobits($realtime);
			case(tmp_bank)//TPRE_P
				'd0:	TPRE_P0 = $realtime;
				'd1:	TPRE_P1 = $realtime;
				'd2:	TPRE_P2 = $realtime;
				'd3:	TPRE_P3 = $realtime;
			endcase//TPRE_P
	`ifdef M16G4_M64G3
		end
	`endif
end

/*
 *-----------------------------------------------------
 *	 WRITE AUTO PRECHARGE command								 
 *-----------------------------------------------------
 */

always	@(wr_autoprecharge or posedge wr_reautoprecharge)
begin : wr_autoprech_op
real difftime;
integer bank_id;
reg		[8*8:1] str;
reg		tmp_reauto;
integer	prev_bank;
integer tmp_bank;

	tmp_reauto = `FALSE;
	bank_id = BankSelect(wr_autoprech_reg);
	if (wr_reautoprecharge == `TRUE) begin
		wr_reautoprecharge = `FALSE;
		tmp_bank = prev_bank;
	end
	else
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);
	//difftime = $realtime - $bitstoreal(TRAS_PP[tmp_bank]);
			case(tmp_bank)//TRAS_PP
				'd0:	difftime = $realtime-TRAS_PP0;
				'd1:	difftime = $realtime-TRAS_PP1;
				'd2:	difftime = $realtime-TRAS_PP2;
				'd3:	difftime = $realtime-TRAS_PP3;
			endcase//TRAS_PP
	if(difftime < `tRASmin-`MARGIN)
	begin
	  `ifdef M64G3_M128_M256
		//auto_flagx <= `TRUE;				// KyW ... 0624 : rev 3.3
		//auto_flagx <= #(`tRASmin-difftime) `FALSE;	// KyW ... 0624 : rev 3.3
		  prev_bank <= #(`tRASmin-difftime) tmp_bank;
		  wr_reautoprecharge <= #(`tRASmin-difftime) `TRUE;
		  tmp_reauto = `TRUE;
`ifdef v
  $display(" Info: Staring Auto precharge (%s) delayed by tRASmin violation at %t", str, $time);
`endif
//		  #0 disable wr_autoprech_op;
	  `else
		wr_reautoprecharge = `FALSE;
		$display("Warning: tRASmin violation at %t", $realtime);
		disable wr_autoprech_op;
	  `endif
	end
	if(difftime > `tRASmax+`MARGIN)
	begin
		$display("Warning: tRASmax violation at %t", $realtime);
	end

	`ifdef M16G4_M64G3
		if (tmp_reauto == `FALSE) begin
	`endif
`ifdef v
$display(">> auto precharge ( %0s) at	%t", str, $realtime);
`endif
	Mode[tmp_bank] = 0;

	precharge_flag[tmp_bank] = `TRUE;
	wr_kill_bank = tmp_bank;
		->wr_precharge_flag_kill;
	//TPRE_P[tmp_bank] = $realtobits($realtime);
			case(tmp_bank)//TPRE_P
				'd0:	TPRE_P0 = $realtime;
				'd1:	TPRE_P1 = $realtime;
				'd2:	TPRE_P2 = $realtime;
				'd3:	TPRE_P3 = $realtime;
			endcase//TPRE_P
	`ifdef M16G4_M64G3
		end
	`endif
end

/*
 *-----------------------------------------------------
 */

always @(autostart)
	begin
		if( READ_MODE )
		begin
			auto_flagx = repeat (BL) @(negedge pclk) `FALSE;
		end
		else if( WRITE_MODE )
		begin
			auto_flagx = repeat (WBL) @(negedge pclk) `FALSE;
		end
	end
/*
 *-----------------------------------------------------
 *	 DEEP POWER DOWN
 *-----------------------------------------------------
 */
`ifdef DPD
always	@(deeppowerdown)
	begin : d_powerdown
		if (|Mode == 1'b0) begin
			D_POWERDOWN = `TRUE;
`ifdef v
			$display(">> Deep power down enter at         %t",CUR_TIME);
`endif
		end
		else begin
			$display("Warning: Illegal deep power down command at %t",CUR_TIME);
			disable d_powerdown;
		end
	end	

always @(d_pdown_exit) begin
	D_POWERDOWN <= #(`tDPDEXIT-`MARGIN) `FALSE;
	D_PDOWN_EXIT <= #(`tDPDEXIT-`MARGIN) `TRUE;
end
`endif

/*
 *-----------------------------------------------------
 *	 move memory data to dout register				  
 *	   by sequential counter
 *-----------------------------------------------------
 */

// This task models behavior of increment counter
// Simply, address is increased by one and one.

task	increment_read;
	begin:ir
		integer j,s,t;
		integer	bank;
        reg [`BIT_T]  maddr;
		reg [`BIT_C] check_111;

		bank = BankSelect(c_bank_addr);

        maddr = m_addr;
		for(j=0; j<= BL-1; j=j+1) begin

			case(bank)
				'd0: begin
				`ifdef DYMEM
					$damem_read("mem_a", maddr, dout_reg[j]);
					$damem_read("mem_a", maddr, din_rega[j]);
				`else
					dout_reg[j] = mem_a[maddr];
					din_rega[j] = mem_a[maddr];
				`endif
				end
				'd1: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_b", maddr, din_regb[j]);
				`else
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_b[maddr];
					`else
						dout_reg[j] = mem_b[maddr];
					`endif
					din_regb[j] = mem_b[maddr];
				`endif
				end
				`ifdef NBANK4
				  'd2: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_c", maddr, din_regc[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_c[maddr];
					`else
						dout_reg[j] = mem_c[maddr];
					`endif
					din_regc[j] = mem_c[maddr];
				`endif
				  end
				  'd3: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_d", maddr, din_regd[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_d[maddr];
					`else
						dout_reg[j] = mem_d[maddr];
					`endif
					din_regd[j] = mem_d[maddr];
				`endif
				  end
				`endif
			endcase

			case(BL)
				'd1: begin
				end
				'd2: maddr[0] = ~maddr[0];
				'd4: begin
					check_111 = m_addr + j+1;
					maddr[1:0] = check_111[1:0];
				end
				'd8: begin 
					check_111 = m_addr + j+1;
					maddr[2:0] = check_111[2:0];
				end
				`PAGEDEPTH: begin    // case 256
					check_111 = m_addr + j+1;
					maddr[`BIT_C] = check_111[`BIT_C];
            	end
				default: begin
					$display("Warning: burst length is out of spec");
					disable increment_read;
				end
			endcase
		end // end of for loop

	end	
endtask

/*
 *-----------------------------------------------------
 *	 move memory data to dout register				  
 *	   by interleave counter
 *-----------------------------------------------------
 */

// Interleave counting mechanism is different from 
// sequential method. Counting step could be varied with
// initial address.(refer to data sheet)

task	interleave_read;
	begin:ir1
	integer j;
	integer bank;
    reg [`BIT_T] maddr;

		bank = BankSelect(c_bank_addr);
        maddr = m_addr;
		for(j=0; j<=BL-1; j=j+1) begin
			case(bank)
				'd0: begin
				`ifdef DYMEM
					$damem_read("mem_a", maddr, dout_reg[j]);
					$damem_read("mem_a", maddr, din_rega[j]);
				`else
					dout_reg[j] = mem_a[maddr];
					din_rega[j] = mem_a[maddr];
				`endif
				end
				'd1: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_b", maddr, din_regb[j]);
				`else
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_b[maddr];
					`else
						dout_reg[j] = mem_b[maddr];
					`endif
					din_regb[j] = mem_b[maddr];
				`endif
				end
				`ifdef NBANK4
				  'd2: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_c", maddr, din_regc[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_c[maddr];
					`else
						dout_reg[j] = mem_c[maddr];
					`endif
					din_regc[j] = mem_c[maddr];
				`endif
				  end
				  'd3: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_d", maddr, din_regd[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_d[maddr];
					`else
						dout_reg[j] = mem_d[maddr];
					`endif
					din_regd[j] = mem_d[maddr];
				`endif
				  end
				`endif
			endcase

			case(BL)
				'd1:begin
				end
				'd2: 
						maddr[0] = ~maddr[0];
				'd4: begin
					if( j == 0 || j == 2)
						maddr[0] = ~maddr[0];
					else 
						maddr[1:0] = ~maddr[1:0];
				end
				'd8: begin
					if(j == 0 || j == 2 || j == 4 || j==6)
						maddr[0] = ~maddr[0];
					else if(j == 1 || j == 5)
						maddr[1:0] = ~maddr[1:0];
					else
						maddr[2:0] = ~maddr[2:0];
				end
				default: $display("Warning: burst length is out of spec.");
			endcase
		end
	end
endtask

/*
 *-----------------------------------------------------
 *	 move memory data to din register array			 
 *	   by sequential counter
 *-----------------------------------------------------
 */

task	increment_write;
	begin:iw
		integer j,s,t;
        reg [`BIT_T] maddr;
		reg [`BIT_C] check_111;
		integer bank;

		bank = BankSelect(c_bank_addr);
        maddr = m_addr;
		for(j=0; j<=WBL-1; j=j+1) begin
			case(bank)
				'd0:
				`ifdef DYMEM
					$damem_write("mem_a", maddr, din_rega[j]);
				`else
					mem_a[maddr] = din_rega[j];
				`endif
				'd1:
				`ifdef DYMEM
					$damem_write("mem_b", maddr, din_regb[j]);
				`else
					mem_b[maddr] = din_regb[j];
				`endif
				`ifdef NBANK4
				  'd2:
				`ifdef DYMEM
					$damem_write("mem_c", maddr, din_regc[j]);
				`else
					mem_c[maddr] = din_regc[j];
				`endif
				  'd3:
				`ifdef DYMEM
					$damem_write("mem_d", maddr, din_regd[j]);
				`else
					mem_d[maddr] = din_regd[j];
				`endif
				`endif
			endcase
			case(WBL)	
				'd1: begin
				end
				'd2: 
			 		maddr[0] = ~maddr[0];
				'd4: begin
					check_111 = m_addr +j+1;
					maddr[1:0] = check_111[1:0];
				end
				'd8: begin 
					check_111 = m_addr +j+1;
					maddr[2:0] = check_111[2:0];
				end
				`PAGEDEPTH: begin 
					check_111 = m_addr +j+1;
					maddr[`BIT_C] = check_111[`BIT_C];
            	end
				default: begin
					$display("Warning: burst length is out of spec");
					disable increment_write;
				end
			endcase
		end
	end	
endtask

/*
 *-----------------------------------------------------
 *	 move memory data to din register array			 
 *	   by interleave counter
 *-----------------------------------------------------
 */

task	interleave_write;
	begin:iw1
	integer j;
	integer bank;
    reg [`BIT_T] maddr;

	bank = BankSelect(c_bank_addr);
    maddr = m_addr;
	for(j=0; j <= WBL-1; j=j+1) begin
			case(bank)
				'd0: 
				`ifdef DYMEM
					$damem_write("mem_a", maddr, din_rega[j]);
				`else
					mem_a[maddr] = din_rega[j];
				`endif
				'd1: 
				`ifdef DYMEM
					$damem_write("mem_b", maddr, din_regb[j]);
				`else
					mem_b[maddr] = din_regb[j];
				`endif
				`ifdef NBANK4
				  'd2: 
				`ifdef DYMEM
					$damem_write("mem_c", maddr, din_regc[j]);
				`else
					mem_c[maddr] = din_regc[j];
				`endif
				  'd3: 
				`ifdef DYMEM
					$damem_write("mem_d", maddr, din_regd[j]);
				`else
					mem_d[maddr] = din_regd[j];
				`endif
				`endif
			endcase
			case(WBL)
				'd1:begin
                end
                'd2:
                        maddr[0] = ~maddr[0];
                'd4: begin
                    if((j % 2) == 0)
                        maddr[0] = ~maddr[0];
                    else
                        maddr[1:0] = ~maddr[1:0];
                end
                'd8: begin
                    if((j % 2) == 0)
                        maddr[0] = ~maddr[0];
                    else if(j == 1 || j == 5)
                        maddr[1:0] = ~maddr[1:0];
                    else
                        maddr[2:0] = ~maddr[2:0];
                end
				default: 
				begin
					$display("Warning: burst length is out of spec.");
				end
			endcase
		end
	end
endtask

//`protected
[VYY>SQH5DT^<E>X9mfi`QS\WQh4>Z@lW86?P\IBX\i??nnIqXDPg9O572daa[0I
SVKJ1cF2goFdKQ_Mq1PE3TbGaWm2f]21F8;iFg341<lhE`@Pq2hLPNcq\LkOBgLI
X9cWPPbMDbA87oG]E7i8LC;PqmbaVU2MMi>;WM[T5nJ`7E1plSS[eHQ__?IOA]VA
T3_=q38a;_g5B^2KneK;ah<4N@T9E3EcNlh[ALCq[nK_Y@;kcZ\N6?E5a;X_hcmc
3Zf1mD3<2[0kpbQhh6m<q768F1RaoQc0d]o;3:P96=0An6CWj2fj6\ona5M=RWkO
75^bnQ]1ficMpolDjYOW\a[C2O_7D:?lTc[E@ORN<@74:j5P1=>>qekWG6^ZfLW8
YjN\^Io9Uf]OR;Ej=ZONWEV^5[7loCdN@7DlopFobE;2W=Y[Go0\?Y6C5Hfa?gmD
<f4KdGLn0H^P8Yl\ipjjC]ek^qfVoE=<TOKj=Bi7lS904F^>oJBCFSjU0Za`SjYc
TK3g8:P_8``:O<3G>@>PBC]eZVI[C]MLi4C6eMjd\5]:eJ_Xqn@\En2?qhi79o>O
M0b1NUXTHbYcZJ^]Ig@H]6i>WpE4BoeO^^j9fddC7lUL;J_8U1pA3m]GiBq4:ejS
eV@;QUe7djCB5eIQUBY6K77<?8NWo5bpUj>aV0cqm1VVD]mYC1jDFoe42LULZc59
7]Yod:Q6cccdhgq>IE?1>YpTgVZSc^[22k;HUM2QBB0`IH:]CSSl3=hQFHS?^eoZ
kD0LYF`XRHX5olpm8=CH]4DX:JM>el@JaECePFMJ:f0D:_YjVS3aPN]<6?bHPjHq
3\7VJ<:W_L2cQF<DNkJ=P\Ri5?fKn]PR7FN1V:WDjWK30hN?inia=\Q@S8?<A<=c
=JAMi1i8q5DSAacn]RJR8i^1FUcY`nCoe<J4DJliDjcdGHU`KO`AqFBlPMXapNK^
V6[LH3=AZSe>LOJRjRUeROR<3l:LA3eVAYo8ngAmalIC=Jfd\@Z5_cOY=G35fI=2
jSI@]6mh]Q2_[k0WMm80pe=fAaX:p\FWEN0e6[9Bc4Kn>[6N5032LUIEk_JM<XDQ
YP4Mld?IgBcP[7^L;Z;[AYV09S\f8[E?m^TFAFJLKYC6NZ67UpB0o9Jc@dMklDca
=23i]Ik<NOANC102lBb>CpmbY[ND4ijEn^_I>6LAW;D6d>CJJBJaDb912A;n]4YC
n`Af8NHeJG<UgmSFJkcmoN=`P4fa]Aj68V11q3M9O6i`p>]=T?T[h4KoYO@@ALZV
Tq9R6K]6k8elfZ>1Z[DeS^QR_i@10n`fcKWS1:aVq2FA=;Lapi]ol:L2qEfeW^cd
UL1F4fiYm>_;S5P01QRkD00>hVApR\Qa_Gb?KWYhP0ldfUISkSVML6qUFM;[;eqV
ngIBkRpOO^adOiVKj6[mXNiD?kHTSL;6]n2]57IoTfjW@Vff2<QMMHjGdTPqY2_M
IhZpNE8n\gi=WOPX1;JOYJP;c<WE@nWdh[<?g9<Eh;Eeq9<DZQFg7OGe727mTOL<
Ea5n54O[3C=fb=g026L[UYV_5qIjQYQF2=c7Li7W0@oY_cJChAh^\B=M\W4422?C
IeRkW@<\?L?O2e08P8qSFG4Pb3`beQBENMC7e8To32i?m=XjPa9JZ?hD5c4O<ZK\
3WTiYDkdComL]FVq008HO2<q[hgnACB6O1p6ZROS;B3A]\APQ<[G>_b^`GS=7aE8
Z4Y\Q9W>6Nf[V68AOAeqoe;;]75DdlPoHR^aIoKiVndA`dC3^^>a=BbPh6h[4^BI
0[^?fY@gTP36e4SRh0c<7lo]nIGp\Y09`CjSK\EaZK89>Hg<Yd\C1M:AjWmEl>N8
<WXD\JpanfBJE:qZZHID=q[Wj^Dl2b\5XiSAN>_?UhM3h2G3MQ:5a:1hAJJXfLj2
MPqbccNGD57j=CK_;TRTFZ0gMi7_J38gY5FPMZZmgni]j8UqLL@n_omgV6E`44CD
MbUP[4RJMDC>QV^M8TeI:R15G^9;=3gQ:JBWG]79qj;@3^Wk:B1_^`6klPbK=C16
B36[_R6lSdiR1T`jFb7;6B_Wo9lbKZdZ4`9e1p;IJJoOiq58<kl>F;PTSAddZPj:
eEZh5bnkIUm2?5qaGf0emC:YmpFeUhgekof`4f>j1jN2meL^8G0a?=<YJ[k@5E7O
b7TeLC6B<gJ58NqCGnfC8m14<7JZDV^<2SC@O81?HCZTR>f=Po7o^^l<cnElZFmF
>_a8I<_Th\cY5AEH;Xh;U6mCiYpPlEVUXi4=Z]Oo9=Oa\>TMM?eV8LHc3^ZEUL_;
D\IK@FY7BmEck=;6m:c6<U6R5p]So6h59qTWh`KQpO0gWZF`>k5IDl0N<ASGg83_
7VWXX?Ag1YTfkiZ@>Y14Rq4GfF8JkS`AV_@oWTA;NZ@PafV9d7H8\S9b^20Y@642
Lcq;7iaimG:?oU_]^8d3HO]hOL3WH?;lW]_R`@c^\YA08NG^5:91d8VF:X<p5i55
RGnQWcb`TFFBk7I:NaXlLU^SQaWfNn0=Sn:DHPokX0FN5SbbK3?fdo?9qJSo[dC@
p4onUBgO2h<pl?fi;2=jkZMU1iEPWcB1f?DC[KAoc:\cb:=hkd@k\jCSTP1[[f1M
qP=YJ<U;X:DoL7B2AEDWgM8>pV;<>Tkk`l2=B\4Md9Q`=8kj?bfn3Zd5iTVMF2a5
^a<EE9DliFfJ9NQFD6fJDXe_g^2WFEDLn[R]pheSgYS4p?HFN46$
`endprotected

/*
 *-----------------------------------------------------
 *	 read task 
 *-----------------------------------------------------
 */

task read_task;

	begin

		begin: read_op
			integer i;
	
			for( i=0; i < BL; i=i+1 )
			begin
				t_dqo = dout_reg[i];
				->dqo_event;
				@(posedge pclk);
				`ifdef M16G4_M64G3	// jhkim(8.14)
					if( i == `PAGEDEPTH - 1 )  
						i = -1; 			// full page wrap around
				`endif
			end
		end

	end
endtask

/*
 *-----------------------------------------------------
 *	 write task
 *-----------------------------------------------------
 */

task write_task;
	begin
		begin: write_op
			integer    i, j, k;
			reg [`BIT] tmp_reg;
			integer bank_id;
			reg		[8*8:1] str;

			if(~burst_type)
				increment_read;
			else
				interleave_read;

			begin: write_seq
				for(i = 0; i < WBL; i = i+1)
				begin  // { for loop
					begin
						bank_id = BankSelect(c_bank_addr);
						str = PrintBank(c_bank_addr);
						if(precharge_flag[bank_id] == `TRUE)
							disable write_seq;
						case (bank_id)
							'd0: tmp_reg = din_rega[i];
							'd1: tmp_reg = din_regb[i];
							`ifdef NBANK4
							  'd2: tmp_reg = din_regc[i];
							  'd3: tmp_reg = din_regd[i];
							`endif
						endcase

						
						for (k = 0; k < `nDQM; k = k + 1) begin
						  if (dqm[k] == 1'b0) begin
							for (j = k*`BYTE; j < (k+1)*`BYTE; j = j + 1) begin
							   tmp_reg[j] = (dqi[j] == 1'b1 || dqi[j] == 1'b0)?
										    dqi[j]:1'bx;
						     end
						   end
						end

						case (bank_id)
							'd0: din_rega[i] = tmp_reg;
							'd1: din_regb[i] = tmp_reg;
							`ifdef NBANK4
							  'd2: din_regc[i] = tmp_reg;
							  'd3: din_regd[i] = tmp_reg;
							`endif
						endcase
					end

					m_addr = {r_addr, c_addr};
					#0 ->flush_write;

					`ifdef M16G4_M64G3    // jhkim(8.14)
						if( i == WBL-1 && WBL !== `PAGEDEPTH )   
                        				disable write_seq;
					`else
						if( i == WBL-1 && i != `PAGEDEPTH )
							disable write_seq;
					`endif
					@(posedge pclk);
					#0.1; //KyW ... 0408 for VCS
					if( |dqm === 1'b0 ) begin // 98.6.26 BYC
					if( CUR_TIME - TDQI < `tSS-`MARGIN )
						$display("Warning: DQi setup violation at %t", CUR_TIME);
					end
					`ifdef M16G4_M64G3    // jhkim(8.14)
						if ( i == `PAGEDEPTH -1) 
							i = -1; // full page wrap around
					`endif

				end  // } for loop end
			end  // write_seq

//			m_addr = {r_addr, c_addr};
//			->flush_write;

		end

	end

endtask 

`ifdef NBANK2
function integer BankSelect;
input	 	c_addr;
integer		bank;
begin
	case(c_addr)
		1'b0 :
			bank = 0;
		1'b1 :
			bank = 1;
		default :
			bank = -1;
	endcase
	BankSelect = bank;
end
endfunction
function [8*8 : 1] PrintBank;
input				bs;
reg		[8*8 : 1]	s_bank;
begin
	case(bs)
		1'b0 :
			s_bank = " A Bank";
		1'b1 :
			s_bank = " B Bank";
		default :
			s_bank = "Bad Bank";
	endcase
	PrintBank = s_bank;
end
endfunction
`endif

`ifdef NBANK4
function integer BankSelect;
input	[1:0] 	c_addr;
integer			bank;
begin
	case(c_addr)
		2'b00 :
			bank = 0;
		2'b01 :
			bank = 1;
		2'b10 :
			bank = 2;
		2'b11 :
			bank = 3;
		default :
			bank = -1;
	endcase
	BankSelect = bank;
end
endfunction
function [8*8 : 1] PrintBank;
input	[1:0]	bs;
reg		[8*8 : 1]	s_bank;
begin
	case(bs)
		2'b00 :
			s_bank = " A Bank";
		2'b01 :
			s_bank = " B Bank";
		2'b10 :
			s_bank = " C Bank";
		2'b11 :
			s_bank = " D Bank";
		default :
			s_bank = "Bad Bank";
	endcase
	PrintBank = s_bank;
end
endfunction
`endif

endmodule

`ifdef CS2
`ifdef DPD_PIN
module sdram(clk, cs0b, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
`else
module sdram(clk, cs0b, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi);
`endif
  inout   [`BIT]  dqi;
  input   [`nBank/2-1:0] ba;
  input   [`ADDRTOP:0]  ad;
  input   rasb,casb,web;
  input   clk,cke,cs0b,cs1b;
  input   [`nDQM-1:0] dqm;
`ifdef DPD_PIN
  input   dpdb;
`endif

`ifdef DPD_PIN
sdram_cs2 i0(clk, cs0b, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
sdram_cs2 i1(clk, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
`else
sdram_cs2 i0(clk, cs0b, cke, ba, ad, rasb, casb, web, dqm, dqi);
sdram_cs2 i1(clk, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi);
`endif
endmodule
`endif
