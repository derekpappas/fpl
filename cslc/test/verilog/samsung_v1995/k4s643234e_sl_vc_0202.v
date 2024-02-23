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
`define D19X32
`define V25
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
    `ifdef 128M
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
   `ifdef 512M //
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

`ifdef VCS  // VCS Release 6.0
//`protected
HNAQOT_.,<fC)Kg9(.Jc(ZL.-[2X9&NI(e^S-8U]CPA7_J(YAa.d8:Ig=@<W-a#W
526+LZOgU,7)GK-J_Q^R-=C]4>44H4Q]?(V5GJ;2FI^L&dR7#,]0:3]b3XfaWcKc
:OH9EZOYX#AF4\B62I_dN?RPBLKD9@OJ<9_Ng;62,^,Xf@[Qg7MM#SZT#_f(9HO8
8-gDaFK&4);3g./=?R+;MYX+3=83<CP2K41DZK#Ke0Kc)+Q#:D3[S2efA-\B_A_7
EWgEbaS>D<T+EOe39OOe2LF8B6RE@PLcbCMC0&W;^NP67Q9LR\I/VD5Ug?b7DcC,
@CA9&35)>a2U@7?R8176RS?>G_XZea9]eL.geb1YGdCaGG>:GP)5]\W0]JeR<PE9
57UFa-PNO6f2dN-f,,)3<9&\#M#/HA]E6:Z?Y):DEdAH+E&]IPC@afX5YRDXdP;>
KRPU-LH;1Q@B3d.#@GEPUa5f22L)L,GWS7S^I10\IK_<E.8SF3fN#&;-IA1-CbBf
Y_4_Z8@11#@4_G4Ab+G^IG;DIW6N&7a25V-(&V?HZRPQBK]\?H,\#06GB.d(1AFL
ZNA<Xc.[?B<\2R;^)RJ2^,d11\S.E7/9E7ff-=R(OY(;.?8RU@LP;0.&<NJ6N9J&
-dZ;F-O;Cd#6)7YE(PJN^FGcOD68NgHMfbK:L[Y1c3KS#0\U-6PLM8L:[&/?6FO/
K6[>RKf(_cQ3RI+6N7MGJ=N47/2gYMOgC-.C&+a\C7K,EFR\@/cBD=A,a1Q>>g&4
.Me.bd\Z<.+DP\+NDXb=WVd+@\0G9XZZ/\T(HNZX&IPdX3EbFET=^Ga5S546EA)A
I\+1fWf1Te-aa9&9P=N5f>+dOVV4bLPI&dSLV9YEI_HI].DO#eN2bB/VJZJN<Fcc
5eZ6XK(^N1/b]FKHK7L)X3>HX5)H?fe=>f?be7(DbeU=?SOY/VZ&2.XOQP(IWIWP
?&\JSZT=;THME8&T9PaHJQ>5b4Z]>bPF]_Y71V3?CD@D,-FZ0PIHQ:eB-3Fd@IRb
##6);b>UA&VCJBC9FGfPZA/9^3;2:(S4W:R7W[ZAN0=b)-DSg^<3OeF6cE>=6YO>
LS.Z[HgW4d3<;<]2<[CQ8KfK-c:V,,B=(&(d(4M9/@L,22I80FE]@bO4]6?&N=2>
9XgDZ,72Ic:3Z?C>GId?92\T34dF9cWQ?d@1KP7#YMd&I?@M]Q2N8U[V&cJI;e.>
,OPYXaZOTE&4SLdfJ(GFXPET>&^S5BZB#/._<N,a7E))_0UW]<(QB?eB]O=Y;RX+
Y-+cP6U?gZMP0S[-/^YXT\^0(KcQB6<)b9H26NWPSe5OBeE\Ld</:6/QcJ[T:;e8
,JUI/;_1+7SfE_,@88#.WNa>X1-@=LAX)U^VYSb0??ZR<Q.;?\4R^&OM2=^22D0\
-\fBL@\J\VHc)\+P16<-MHUAdT;V^T^_JO]3FE)7ObTAgaTB8MX04)V:.RH2Q=_E
^W)1JNWX=>10DIZ=Y+]LEWNQ[H])S#11JF.NQ,f]3Mf4dBU,C<-.2<c/9N19gc?8
O&H:1:9[(:6U2.gZS+B;VNTBQ=F#fNW\9.<Cd4,f#S/E-:Y>9:dGFW_TT]>P7_DZ
U.eg8E:?(GQc>G33RVD-e#40bEOb7e?g?D[95:cAW/1^LM]ND8,DNb3FS9^YWQ#V
(@<IbAeL_F+<8W^685B.ZfH,VBAQgYe,&Rd6MO;FX.,_O28O_GVB-:@E5,eY=Z92
68>+AcURHOC?/J7SgAPbM47/dR-<G)_DP\bbV^\X9US)\C[7D2b:Zc?7ER6(E/^S
A;cg5]S-K;b-;W9D:783GRR..E@6MO7B,0f=R?,49..5#/?@2[PJ8CN&,?IESPa>
Yc3Q=T\B6_[O1.LN+9AdZ1D;A)51b4,+?$
`endprotected
`endif


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

`ifdef VCS  // VCS Release 6.0
//`protected
1N@@+d5d\],>-Q]8(C0.91I4,H6O-,BT<9/1=Z\c?QDX7B8Ue]WO)gD&,A?B-DRU
6>,cWM8)cZR9Md/SQ&[HV_E_CN90IXK8_^(ZE]6&V&]PZZe_bV5H4S95F<ZP6M@c
?]RC2SV?f9:KH4((BJ_0SA0dUeU-f];&,V07S9B,G@E1@4.ZUZ;g=[8\)PGXZ-?f
99-[Z=Tc=@K59&@)#/LWQ_X,8fH0W4NK;+Ue-@&dgNH&feg_gM=b[51AKZ4]1fT4
?G/OHfeMS,T?A=fO9,Yc_TF(=\J7LK.L/4L].?0D:9_<3fQFGM5/dKL]X^bSRXQ]
_HY0?A,-WD&(D\&))G-^W5V13-83_04RAACXXCeJX+<F,=eK&UFNXE^bF]6N@FB[
#Y.]J,TLbY4_;Eg;)YU[(]I7L-P,=O;X?74\]=F>Z0DW14GW+bG_EH-X>fagKd3/
2\/1FWVAd);U.3MZ?Oa>fXJZA0a_AO.[+?-4M])K0JR,Uf&]_Q,/K?R7]d72=?K[
]SPC6)2eSWGK47>A1G@8&)-5?0]Pb#SX#B0b>H\aY)1Q5G<2&B4>aO3+NHEY_7XC
W[d@>g+8OBS.=]:YS7=+LA.=C]MYg5E^:6+3A&^6(JNX-V/Q:TP20Zc\;7G&Ra\8
A^I]IPWYgTg)bI2(WfZ,Ge>[NPea_XU4:;(U7EJO8;7#W=SdNAQ:A/(C;:XYKMcf
GEQOMgecQK79GC];VIgE&;Z5IfdZdQIUW)IV8X5c0)(,(DW4(MBfC^5QYZXGW14\
eXL.51NS^1QGcQ(.JWN\1dB\EH_cL\67;Gd6b/H)VD3:^_)_XO;-[:QO-NED)Jg[
GLU(Z&3\.)F?T2<dB_L2?N+@-Y&3?R@Pg2;fZI0f^a<dZD.R8cC]OH2XB)5)LD4e
YXNO\eePG#QI=3fO?(:RL,D02#>?O+)G^Q<F2gU]#N?+)[aIee&WR.O;f_6P4AfW
<E.<6OCL/c@Q+LM@W#X92N)?Me]b\(4.4TSRbZEL;B(KV_[cW8bGLIXOERC0N9SN
LZ,ZW0W?J9N-R)70]c50SXGY]YP_85I(KD^.6AR?a@@Q6DgZ/]GL5CS+)LQLOG<G
62X9Z-fdD5GbDW&QD?-F,f^(dZIB6]U37U2JMX;&(S77P]Jc+N+c/\GTB]YH;Jd1
+7A#^ITV,-+@B?4+S6/cW7CK5COAdU=Y.Wf0T0-U;A+Z:W;V8ER8:OE.E)\MX.(S
f_#T._]f7@USD-U;ND6BgaIURT./g?#LQ+LYF+b@LU0?3+UGB6e@dcYeP._R2&/T
4c:-fMb++2)^@YY2dNWTSH1DW3)>JAPS5F/B)EUK[+/VO,4PMHd2bJfV]EeD)cHc
I1)1eY(>/_f?T4f;\JebYL.GN@XA510ZXMWJ1&?WV2E=ccS,WcBb:&V-Pf=>&b/L
9?052OMB)1/e(GQUZZ82NJaW._<WLY_Vac8G(F95),Ubc+#UfZIK=VM9[LTe.X.N
TS.D/DW[\>?.@U0D@>P=W;5IS^LXEbcY)=YOM>M7IfdL:SQICa&/P)2VE-YBH.C,
N66,If#_PHHUJJ1fEGGgYH0/RRR2b/-c]:.Vb:/TQ9Y+b;WEM-:McAf1G2cXOTC7
]gJ47(^J;+A#U^R37H?gfE+A/.SI3H580HJ1/<d=PI)5KB))6;fZ?TYIC4#GE?_T
Pc?eJM2V[P?ba_ER_2MRQe+<1=RXX7V&MY;HWCC?[7Qg&D((Q]>Z,[b=L;9Y/]@-
F+C.1H6)GP&[E8)9Ec=70L2;gUN8-G\@OVOdJCC1)T@9.HH8dF6CWO\+RMAb:aRY
&dHL_IJfG#:9b.ARNeRL:8:)5(]^^3^()N;8bPgE6WA54)57GWXcY1ED[cHUTd88
T/VI2M9]TUA(g1[8LH+c:PU]17DOK\Ub@>eA;Fee/<1+GRP.c?>GJ:HTQ<KQ1I3^
cCW#4C9[EDJbOJ=JAS<PJ<_eg_4IACc)61^87NZ8CB0d<R\?/.&AHA^,Rc>Y<F@,
A7)_1_<-WI?8/>@#MJ07+A4Nc3e/R@ALJ9BdOE\_)023JK))U6)BR-K:T/Q&BS3g
g0[2&[e6_W/)cf@9:J>eaMOYM4eQ?d[d<O()YGO2B[8GU1X3aT3=7SL]dDI[DBgK
2:g]RO(RL@D0@D30fHBb@0#\IB5EXYN2]O@JE3cN=#dD6:0DW,R&7?b4a8O<A/Vd
4f]2,F(5XY[fc?&;WDNNI^#YFNEMg?,Ze,])CBUV=DG1g@(Ze^2a09-G+fT]]/GE
0GUO]IE9S+WQb6VNN[A/aB;XUXL4TOU^EB7-:GgIbTJC^\X_Gf2FL28PUW^CH#^1
->\9FIe7a>(H2^E5_MO)-<e)THNMM,#.PEM6d3W)W_3O@:(,.&6&GHMPC)HWW.IP
XHR,+M&9\-<G9RBO8WDYSG9OQ^(30R4dW<RTg^d6Y05,RV&7EW=OEA;e]WY?\>bK
ZZMT9C.KAV5MCICC>2/fg]EJ/cI8ZQ:[,;).YdLJVVMaB[J).g-:e]1W/<?dP@<(
22BH0QB9TJQ.FIcWF]EFID-YZgK::AH8L(gXe_W)LQEO1)F@/_,gCTLA12:+.X;R
_<b9M^CNac&M++B7F,W5b+5V#3@:TKH<G//ZW7^DQM)+8LEP6-DRJ<T)&)0:3g>=
Ib9.J5=7E<Mg3b?)Y3bMK3g\,EMYM9U:9d#3(eJOIDQQ;_bKd+b75TD4BeZYe:>,
JZaA.9d(1Y&5O<.V_E(^BgWN2WGMS9.-)YL\-AMCgcDc6I:H&:RRgOW2(X)ZTdb5
Q>0Y_9P.@Ub>WcHJ6f+I,>FI5)X](eB6)#YQ:2L#fK-,L:T7/Qc:VF,DEDQEI3C&
[/S.>0S9bB@98a[B[)F#L#\,L@9/_P(ISFB/J(SIN8?+93I^1P1<_6Cf=_F1\1/@
M/cH=>S/Ga]HLS(DX/[GSUe/aY:eB=9<1)ZJ@_U,MZ7d)2[ARQZ:BgY[.&Q/6UF#
0U937NP[S13H0$
`endprotected
`endif

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
`ifdef VCS  // VCS Release 6.0
//`protected
Q098N3>^dL(,,/H[-&@V9SPH-4^0(J6&)4bc91EV3SLa1\@1Ra3#,SCM,@@8<F;D
B80Ic^LSTP,7/UU5\AB)aIX<4+B:T.;;ZM28K;,L\2#d^ZLBZ@gIbG>1_^9,U;2]
[4)3LSE1dcCRc5.-ZU\7@>J;#Dc9#JAQf(R]32_EBR8-Fc)fI,P88P:,X)K\,.g4
U(QbHH<L/S=c,<Q5QTK,<V?5FM3_@=DQ>^cQeb0G-S^fZPXO_eW7WHC;0,C+KG#E
,FUL[,>KTY?/[=c0-YFbAUH^GXMZ-Yb&c(QLQ,9-T2=aI=-=AR7=3XTGRgG/92]c
?13V7/Y:<<Vb=PY+59)aK+2ag)1cLNcO-W/W]BR(A3]JANM_FQ=3G+c>_gg3++?,
SL7&ZVc3Feb:?gK[3UgZ.XRN=EAP,b6S@),,7.?ge1@:OX?d@Y1BEaOCc.X:LGK5
UE.dXR)XXI5(^YQIOGF,Y.Y]=D@\S+Z/&;->G.?_7BVG]_@VdN.;TdW<)SfQ]6PF
0V8QdV&7fM>>3/dNgX>)<<\O>PJ1eeM6[MMS/S-SZ\[S#<L4)I#I))49RLHIe;_L
PPfN3=IVHf\6cebR;d6J0-7QBd@^ZNSA+Igd5Pd8W@dT><Hb-U?_Sb=TC97dd.B@
0TV#S9_]F>T(-^eaV-8E@3SaGGHH5S_62AL?]#b-_X4@1K]3Z+JMgG^-EMHJ313S
YA0;UVVPaQ.4@=b>Y/[,cFV72(CE6LTHE][[W?;0Ng4-9,8+d?8GIO=,c-S6.9dV
Td=(gQa[7eOfG&PYUL,SS8;XBbSH_Q?T-N_=-J3c-Z+c=>?Q0Y^=;#C-9OBOVZTH
B;TUH3O^DQV:NV[VNR-L;S8gB2(.\:U_2@QR0<+b@aACP(9RVf7+RBcDQ\_A]:KH
_TP:T@Y,cVR(1U]>A@d0?6K(Y0KJCa2B9:/e4O60DS<(_(gS9Y4(_,>38;=QM7J;
SMc3K7SQa:4I#H4O[I[5J6@UME2&2:D@fCFHZ)LI3V;#K8a/I;;A>:5>]7-fEMdC
B1@Og.0-V9CSL2,3f5?e/N78M=P;,L.,+&T#N:eceMDb;DQ9TL0H#/\3]#>@3Yb5
EYf9f]VONUJ?&I.:VV-Sb(EA3?#eLVRN>:/QC]ORSa;TRY_J53E@;.]7@bH=@J[9
:T1]/BZ20b6V-,fC>#1fW0gJTR/-T)H8\M;)0<>ge;ga)I>E[F-[/-=:\6]#?)^W
BJfODXNV:ONZ7d2dIaJUZ;3b[8)f&3)3M-JT<^]_e#dW]BaMe:IS?N(65+YULD,G
Y2<1E@F7O)OgJI;>a#a&G8KJ2+H@>QK?]gP0a,<UAS^36CX2E=^&23NX/#C@8V>@
Q8TA2[:H568ZfXgTE@bJ_70^N?\:/g:NJd-d-WF=V/[RI(D0;=8ZH^SP.8T8N700
aa/(&N7gPbgXC)TX]eQGKQ&T>OWE6E]#[S-<SD;gDb@aV@UQW]3c&;g9Z^Aa&34A
J)&R,geVD(<a^9:KX@GN<Fee?L1=(@ZD,)PJ^<1]E<YJS5U)(RaZJT-73)aQQ#?1
N+U4dcdB[GSSU19)8G4/1>-4e9./Sb6,Rad8=Y7PAIBJ6KPO8S5\e[G^F:\,&B#X
2X&+a,Egc[LKYGOTD-RUD[/)bMR25#YR6W:U^><S^]4[X_Ne:U7ec,-TT4_GcLLA
a4bL<WDaB0=UF<6S@Qf=[7T(+.a=eWeCMVB([+XGWREe1J;f&<:_K/^Sa0cR\-@0
[CZW0PCNF&6X3GfUBb_/APd7-XbE><@O4G@RI1TM\ceW5+S_LT+4b\bRWG)3Kf#C
6E6cP(:98>^@[B+Wc_95T=6U/.#(<_PQXXY&<9LDPR/F#U?fHDd3M>4HcLI3J<J^
@8N_SZ[<SAG.W7;C^ECE4CB8;HOZY[[O/C]UXLW@MH>R&?,&5ICHL4F9&?_\(=-3
)]D;CFdaVRIe@2AD)L[EW6=DIN-MCZ31DP^K>cH,@YN^?M#>,WKW)1X^;^g.^&1E
c8ID^3CA<5?;IXG8TVBf>JQ^6()[I47UXPS2@KSgeK:7W:YOZ4L5Y5HM+;QSL^fK
(,@2C?KdG4->)-AOE,TR;NP-.c/N2RFU.+M8Q6Nb,c5ec4G^TY.\Z?JSd6X1AO3Q
_V,:Y0cXK)aKM[DA>@836=cUZY?W?+SB/EE6d@T/K:3/DFK6.T4-.V,6D?]JZ@WK
dZVV5G.?T1&GV5>V19OQUZQgN?HTBXO(OWA,-29W/_\<-\eA;+7>@,1P(Z:MWN,#
:H/_J5ACdUe\6,;]FObOd)]]3]P@:F4Y45:C-_8bD.LLU(@Z)^VS6-P;3a3<)SC[
]fTE8)=&>gc4f8_;?<2Y6LH-Q=]gAO/@5:^=&V>=2?HF+N?8ff=4132gS22M#[)U
&cNf)]b.@EW/3^KTT)HFA;Q\(#9/99Ue0IC^&:8<?U)H.7PbcX9Z^N(MR65J=LF7
2Jc_b>QQ+F;NKbX/C_)7G561GSaQPC[22(7FR7(+W1=eZcXgcf<)FW[8&?/E53e^
M1OV61?>+RX=_?5Y2dME3g:EMAc/fb:O2OY6e<Z(2f^:9CW5I3cG_eF\AJ(DK#/[
NK]^&[471BTbCU<3d2L)P-,fId1O)AEX5EIdB3(P3<\T6AG+79)X2c_+6H2&g1+>
bO8\bA9=ZE5C2RNXD/C)O]=bX:KE?_:<X47^2LMU.WAZOS71g6CHZ/J-LdJOAa-a
?C8B8\2/(Q)22)#CY2Ia@+1Y_S2^N.F9LYc,YDa?7O]GV1((TKA;RI?-QZMAe<Y^
c<N;>4dETQIN^@YHJ\FCXZ)O7\Kd#TH6FXNF_B3B/(_<M4:]3=bd)5JNIGMV@;63
_,4b5]PIa,7PJEIC3fQ+<33.f;[)R3?YUHGd2eC_Uf1E8ICKN#DW@;bN[(3Z5NU0
W5VaPKf]#KD.[91J,;D]2X#JS8=NM3IL;BK.BL]4=E+@^CULeFWTL0d(Q:3[I);5
:?W6#8:@&]dV]XS2b9B[],K?>?gW]T[XDEDT+fa87c#Z7K<N-(cJd&ccEQ<9Z9Sd
XMVI.1^Pa&cU<G<JZ>X2g\69MX/+68dS^d&OI#2#_O&&TV3cDWUb+-6B_;d1FS(-
8KH0f+dGf\:C,YE\Pag@1F_M0V.fea8:EM@M=.XG]Jc/,3BMNgJ8M(F@1a,/YUMH
,R:GS2//e+a9fOD+ZDb+H+O60FaGFb(g,\,\[(]=?F]1\8<-9AE]>#_c=a&,^WW/
-(1g6;6+=U[X(65RR_9AH<NRBEc.11;-UfDQE@&Gf?c&5Y]IdOG)_.&e0bU+BRBS
IG5dO=?\?KPOA,TZ5&0,[SAQLOeO(KdKdM_<_SL5Sg&@JZ=]e]bAg,>6dR[BU7A)
)e\=I>Tcb[:f<\7M#b/R8_a??>&7K68(697eUQS]T</=TIWDI=0XS3Q)b.<\Z=9O
>[L0Of[J_TGaTCQTY?bXgL#LPI#3_[\5R)E3,;-&I6KGgO;FAWIW<ZOG@1,HQ?JA
_DDb(g0Z;CCI9-EFM1CTba1?(<-W5#5NLD[QQWc[gX7I0<eN<(^3E;B834,\I)TI
aM^Oc2@-1:1<\,EIC9Z]ID#SZCPCfEFZP,Qc6^T1@8GB.L_J3g3/OEBMfCF(17f<
ETFQW.H^9JVCP8OGU)/FAaKL[O],P^WPAUQ>f]RGgF72@^>8A\cBV,;21JT02HOd
J(4Eec^H[+3(b>=f]5PE9D0MWG:[/L?AI2MfDE<IIHPLFaf<aeU7D#=RA/Z&C=?5
B>+D.O<;OD_f&N>^+EK>cO=?MO(OS/R]^LW#^M?SERc>OQ(.>eCMSg\IJ5Qc)K-4
OS41Y^V7?BV+8AMU?ME-CN-<(^LcV;JA=g]:-DFGQQ;B=/.H&aIa)VH)^:>Q4d&7
_F_T8C>R=_g9P[S>.K3G=7P10__--JZFE;Y6+84&A4G/E@D@[T5]+Ub5@^LHWX+4
RWIRX3-Dd5Z<d?@9E#/agAe:SP&YT[]AB0>&<Fd.(6aSK6)PD@b.RH#M&6(VD5OE
JU^B=gfWOM?4b7d,e>dHQDbX:geQ@8Y>5GL?7IV,L,fa#359]=CESQ8Ug5a@d2=0
2CRagb6](:&-FCWGJgLg?eKXV]EX=32b.<1>c]]W[^gMG6c+&N3fF=(RP7L&AK4a
e)Z-.c+HN&BZf?3?T(DS[;ONIF<Ca]RJZR.AGaeL4QPJVT(PHU2(^/.GK^8HUH>_
faXQ3g.M5W8L81]dd[C+U01MM_2d;d2XP>B:EY+@Z8IF/[=F_X;eK9F?2c5+?G8_
HD-PHT202\:USaPce??N^?3d^&EG8LI(KGb(713e53d93G-8I/EI[K(;(dN[P)>c
T.cXEb)Ha8HG&c=e?,<E#K1g:QF;f)bEXX]5+7@0+H,;eXb0G,&;cH-?M_XNG_#)
9fL)X@;Q;]9afdO3@I:Y<?.LYV2U:31Z+,KSDF@T(=EAX#(RAH#KfS9DI<1=6MQ4
6&(gOde?I7e2bFO1J\WROHODH#6LYTU5#:fEeAL/D)7fa3Ma\VXLB=V1O=4#_^c<
JM0.>ZPW/A\E&/=ZURgY+5Rf&[7af@ME;d\g.(<66g_.56]7LfQ5c4a5.CJ4_LV;
=Ma9M/+2LP2=EAOGG[IGQ1e1/LeNMJWH-fKV^b0;-fHXV:G^^g>(f#UcG@:c0D_O
._X19V.\H0__^JI31)RTP^D^OU;A,IY>4N/FVggKQO+cJG;bTV=>JVPPNJ>=fCB1
H+1g#aZ5]@X,cS-5J+^g)6=59Z;g4R8f=RA3bM.]WT@IGT0O2A\Qd)Oa_EagO4W3
/&fZ^gR+QFc.L^:Z-DB+WG&FMCVBRW^51c9PNa+<7DLQMc;cb0PZW;64QT0HbF2/
QJ)ATJC9AA?SGPg7[6H;bZ=A?\->2BC^cQ@b-Lb&fQ/7Te@#0bSR<4H]@JKNN=YI
gSS9UbULdWfYU9GYEb@3&KMIKN?b5+G7H4H:/)L7A],@8+)@Q]T[E6ed)G.\gL+B
H.b7:7H6F(dW>TSZL#JW)B(c)+>Y6(TeREN>+DY70V8VD:UPKe9IRaL5OQH#gN72
-3aRHVBTO_5>X,FE3B2ZEcG41Z#YJ76QB6-D<5?&TG<,d-V5&/\@=0-aI<f<=0#L
/e?D<OR4/78;B102U1XDBe[,>/T=_]c/#CS/U#E>=I2H:AMWP5E+QfV=;aK59CH:
_H59aBfgVb:A<D[(aLZ949=>2RA>P8L<RUMa6?QF@9V8#<-WX&4_K4.CEHP892>)
8dADd+;7>MS6?84AG76/g05?CJBSN/0PM=I_;CD<>:YGEXHCY8bI1V35^,9_GZEU
-:G#7D/DZPK7:g;L?DO:X[O?,08H624UQD[/X\@Y1W6C&(&Z<<+/9TH.F_B,&MZW
=,]:__VdgS.[(BKG]aC(.G#N5HO_8)-E_1dQ1\I=3eE:&6875#fC;Da:O+fJ..MJ
6(D#U@T\H<]P,W0HE;M9(3PAdE^XE<#7PWWV>d_(P#IM>fY+8U):a=233W.fHLC-
_U&H;16:+V6QH(MYJF.OQW1.N)6X;R::J]J+eE5(223QOGZBX:N_N:OTWS61[S+G
283-]N:6<@[&XY^WF)3=R]:<Sg\E/bRg^7[2@Vg_C#QF/4DL:&M^F_QVY@4LPX,S
g&T80^A=Yd\R]#GWeT[(,D>4.f?(FHCE6<8a]I//)c[-BSF53[P?C[bVPS]EED(4
#cD@U1,TZ?2AU9KBI<aMAe60D6#ZONKS^^C)SH)KI-UA[JUKG,UU(;]+\_:#,g=Y
EDaN7;,[FeU\DEd@I;=E?1WVZ=&(1S<P>W#LH:Fd#-A+Q][(c;GgTODC+K)GZ/P/
7^7(7d@>L6/<QY</D4CAc4cI[GX_P=\a3C3SHf@aJ\X7.C.P,&EdANeEa_)/3T&W
W<=IO_9,)&#&,,gG.)BSM@b9WB5CLDNU+X1>[J.#Q_f)eU.Y>?]?YYGVB?J>Y@a.
B#I=e,^X4\AgL[?<=dW<a/dCe0NFY/IFL-LNfZFY&\IPG.-BQ7&XOcVeaP2cfH]U
aYAJ<YLXX?Fd7F\YM1K0Y-\\:gR\U=I7DdLYCZH(gR4Nb0,WC-BH4_>T]50\b=Z3
\CW?e-O#]GbO^eRB>2+)DcJ+GG.aOEf;@;66/FXO[\#Rg(g[_RA4e0>^^YAf;gZ)
<)O:YTDHfOZ<8d)H2@WQEY1-3]5X;UO?PTLg03HW1()@QHB-dXggO>N-<LPQIBKd
=/:Qb#=W@R#T.XK1Y[)NX.#d]b5\A=#I[^N+Fd=TL;EOC]&K1OGN+fbNF[5?Qe2U
,;#5ZA1Qc46b7eKWd]<3K;J>[#a?[:5@<=IZE,@3g.#N2I\7Q;\UQ,^^.aIf8.2L
D+Bd/[>Je/CFH-QQ1@PT<>RGb2SF._F)1?^g(1&<c5LW4;#Q#I=8GUP[X)FPYLMS
A\W67[+39#\_C/V.5506dSGbP(R,\2[;#G3IGVdR4[F5ORU[(7QY60Zg#bE/PH2I
\+#+=1W7dC6=@[WQd:<gZ@(J[+aU1>PK>[E<9Z0RR.S<a_J5I[KVMUND1C+&RZFb
=][-1L+Z>H@2f;g/gcbBc3OK=2bA:6#^CV([:27W1-WSCCIXA<]gW1RL6R04@XRf
O9N-ULO2;Y;<5QSbXgJE1e@J#6IY08H)8KA:<WD0C9)\Z[7?c,2EYH0HGZ>^D:1C
2Z=#M7:R+=6U7RH/[a8^/N)BY]_LPY-ZbIAV:M]J\E6f\@d<RSU4;K^2XW(&@?P-
MfZV/VD-eCWW>QOfW61<M3I\;UFRK\H))M+GW5K]Y_MLNUJd]UX=eIF1]ZQb&63.
SLM(:L#L^HR_P4<Q,0.:cOB]BaI:cBZNP/T#Y_D2Y5<)DZ+(N:V2/WLU&3^R[)6\
deD4Sd@]3\518aB&_?S7W4@\9G]JE+4d1K):643[c:2SF,)0Y8P_CW3:f=.PG3PW
0XDB&TM6[c7f3F\]c-cUVA-,)eNV)Y6aeCIZ([8.-L:f\JFF;aWT1?8IR[(B3V]1
bR@4Dc7J2X)4[F3aU<8e=L5@LdTUKbf1b>&13.1g))I/HN56?FH0a28II$
`endprotected
`endif

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
`ifdef VCS  // VCS Release 6.0
//`protected
R\P1aVd#A[LV(NS1=HB2-&A==]^:-ScD8.J@8IL^A9<aI?I/RTQZ)3@\8OZX9@^A
+B#,7<5)-M@X^(\L^;E9[[\P96<SZ-bMTPg(#I8BVfCK7d@&@dX7e)BY&2Vg^W^6
X_3f/.ZC<Q,Fg:HZ^aQFfZVG-SN6>LA71<-LOF2()Ld#AX=4)&1fK_]+G7gXdJAf
_DY+NUc>I(IRcWN>E2Edb^\b>(#GH8QRWF&e=[V]F1\PRU>647DNXaRg@UbbSS6N
JJ\MR8e@WXe@Kg4Q/9TVcHLa9BcS)W_c;P&SGcCOf+g#+OVdLaa)SI/P8[<Keb/=
4RP@C)5E1=O9V\gb+VUA[c?)C6#BKL=,.7g.;>e6PED8FB/Z5)IVPV1V#g_8S;8C
@B[8?N>OOJVD:8&]5)1I1Yf@X:,8^+^]C4\1SLOcRGP=;D-B>2)SDB7@X7d;V?28
7\8B)-45ATXBI<07J:,]IfJbFE_#./SE;N((1+O@)D5_[80Xf:.(b_D.G\6cgHX4
+5[HNT2UfR-Q@afU6AHF(_A.1V9b#D&TP+<:L_[RQ3116D4+,/0-/LQ&@P>X2<8E
fDPR0^ge=4JdGFRRUc-bE:?4H0Nb(.>+B4YS\0>NWEgHW-Qaa=4X-]T5f9[QV4FA
75?/.<V-U@8?PTYFOed#W4V<EY_Y6KCU&S-OYU:7e);Y0@[_&<0XE#Z97V.aH1-V
KeK^:0ZH1/7^aEP\5dQf?6##>gS:J2#C\KbKS@3aU<UIZCe<Ge+/[QCUS=GKM),L
,#\IN?#(S.NSR[@@?ROb?007K7+A:,J[M5QSOH3JZ<:4^8]0=&@UaI2e#Uc.Z?M#
W-Q,be?612F=TU+g3aW^9d;OeKGD37M6Y#OVBUEA_,U>Zd-\(W=-_Ig]#[fI0_AQ
/79_-UG[eZgd)]4,^(5(gfS<_JTS5/;]MUW/R<+Jb+D.U=c?:JK1R/CcF:Cf&@VA
7AH?98;0fVAM1a[3:]9O[\ec6b-]Sfg0[4d0RZ-W?Y\70eOGY0PANC-LKN@^VD#V
BO(\bMLX7b;&,a@TA]6MWb_T2]+C,J8QH0OLM]H>1J7@gWW+PL<JL>aKHDC(73e>
?.)UY&L&<FF;DD4dI-4/)1fZg6#P)BWLKPP)ed7Q4X]f=/3/J<g;,ZBF6fELFXOC
VbXfU\JT2((0BN19SV<Vg6Q>R]NP;63T3X.-PVSGb.,SC;5,4O+e^KD@e73O-ICL
3MLeT?d8:LIMfD/S+RI)FTK614YJd[3[I.60)G69aX2K#MKWYSRaBWgf>gbYGP#\
g65UL0Sb5-VgX@g9C:PL2e#=<H7E^Eg\/P[3)#P\<32B181^[M)f)e+4g2>YV;O<
-+36]9[J#>+T@:-.SU5O6dL0JOcS1IQUdHc1HG6+Ibg@Wg[d>LZcFX8@M;fdZaV=
7B24BA,2\4K1<A[4JMEJ^:\(GJ?;dBUJH2cS.Cd4c<N-UM]>)5d>H[.6Q^Sa118-
X7)Y7N7.b4];:?(7^Z=_b+;-/T+#ODY(E[K?SO-QTWTEgeEYGU/N5[[c\A)0KT-B
_&;;cUb)(N1Xb5]cDK=GYMM7(V6[_+;<+VP8P.-ZD3?E[:d1L+;TW^+VR()We8<O
.YY==.KMGQ;8.e43FHZQSDCaK9P],<Vd@)/b).gYe8b/7U)9a-)3E+<POWe\9c><
2Y2H&-c7(=XQd+>T+IEQ;NfefVHG.5U5#dWJH)V->H67HV3;QX3aX[<GDe:LNX#B
]3bT_#g[c@MJU1TCG\3M511I2QCOI(BH,,,[.OWJKQ1-SL+A9K?YO1.^9L>aB93.
<[BY=eF?7LKKg/R^b1HZa/N;MQ9I[(Qa<Y>6+4:TRf(C1R0>F>TaJ=ZR(:-Lc/HV
eJ=M1;-^H+F=fLYIA-cB>S^A;,Q,:1f1g4@>+362M4;/IJ_d\_4A1Z4Z)@,UKA:g
4=?T<R5?=W/APH8fK=^c8ZY7_LJDM+B+=IHOB+KD7GE=_NMP,a9e0S@XY+@YZ#0b
2PF)gbQ_\2O#aD-F)SPXQ_LQ@69Lf3KbQN,5JM4B&f<-&H1@9J+X:,;7<]^GZeSS
NX(7X,(ge^)@Z;.9[MM\TKT<WB6YeU9(RA?([658>5SY[@W-5Tf0TF\JH>1BXA<T
[bgFHFbGT_[]aB,2^C/FAMKUV.@(X4fZJ+48>>LWT,797&H9OUE^4+8_UZ2d>L?>
;12CR=39O(Q]U8=\.?RIEC4<MOK#K=J)>Na14(W4(@R,Q@0+-OA.&V)ZZN?GeDPN
?##5BO/ONCe[;Pa#_?#L@KCJ6L]XYGb?U5C=e+&M,W3+::X1AGE8=6U?B]23A&6C
L\d;DH)56:-B3H3LUSg#H3P&XQZHKVNOB@IX>_=)T(E5PPD#7@0LL60ZIO20.-;Q
^CWT3.7d^:85N5cFZMBR3M_gVHP1?eg9?)N8.KN?J]L+8^?f8?SUNQY@<7-^\6#,
Y;FVJaYZ(;(1(\-ZWZE@9-a&T#BB5S&V<&Y8a7ZA9V\@G1QG>?/-3PHbH0<,R<QE
D:3]V,GDHS3T0,=P5&85MfBHVUK4_J.b0Za#A(08/X?D7AT7=cDg7Y(E51Yc1?T^
\4A67bYG6NeR3b_,K>:-6_J80U(e&)6/BG>C.LO2O6&2L7;I>O,;GbZ/cN1eLb3L
cI?0TTOOHYX-AUV4Y:6ZDSLD(E6^9f.,aYZEV0G;=FS-F,0g:EWT(G\X^WKd&0aJ
f/7.K]RUP^6705dTDXCE,7BIFT(NXQ-ddT3?2RK/7&df#P0-N36\@:4e<H^6@E)0
5MgYY_dNLd3aP0N<<]c[^6T[4Q-8]5W3TIYfMZ#H@A,P^+E.<ZB98&O6-Xd/.-;G
Q<G<d@,7))C2>5eL:I@3M2N;&W+9DF]_I;&eeA^DPSW\^,LW6=U#;FP+;R_4/P>2
_EK14\g5>N5g,5/9)7g(SG0OC)+T[/YCB+[X7J>4_bO1/5>]7#^6dA=I0IUX.)E:
QIW;.MA8PJ0-A@[aU+^S/[]c_YdP]Cd@<FE5__Vb;LE8GN@J5_I\PYE;c(=->P@A
QU[10?S6XV]?F@:<,[&VPS:e?T:5PO1>(MXZ;\9&RgLQ.fKc0=;KHaYGcR2d5fDF
5AGD=.?#.5La[BM9#VZf++4=D?cN4cJFf_2FR+UM+?g9577F[<Y)(UYGP$
`endprotected
`endif

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
`ifdef VCS  // VCS Release 6.0
//`protected
83BCZ\,[)Ieg<D[085O2<D4N<LH39]87,RY?-DJd91A?DMDZCVfa8B55<N,P)97,
QNL<=4XAe;49XH5JC5=S[RZ;)0cKX(QJ:3N-6M7/(f)P06/R2A3]A2FAJ\S-F&Wb
@NCWcaAPM24/g7e5e+:.>T<7XZ^eL1/-#ff7\/=..NOb[CR@[S,WEP6&POH6faVG
d==MW=T[F:d0X171>+BJ#P[/^dg5+(_5IPAE(dHAfcK3F^589NU]Gg-+2_aNX=6#
e895X0S[4TUU80^139P/[aYA;/1X3,(aF+.OdVU:4EbVJDGgg>0CGKaVK^-f[64P
3O-_=T3V[gC-]I8)S<\ZGMaW-Z-(B5S9Ff42@VG4O8_4RMG[S:OB#=U++:aS5gB@
3-V9HGB?/,&(>M>WeJITN.9[,f]69N-C^JQR5V.?IJB-QI2d4M+/N649ZgHcYN_S
N&HSV17HQ2L?79B&+_<WC#?_0b]eU7OW.K9d5>23RORWH3\bO1P-+R6&Z.=gFYOd
1SWQNMOaTX8O2AGSER94?YZ_QFR/_J5^RT07J^:UQY^C9C3<ag@a?W1O(:H[F5T6
AGTX\AEIe2a-V+d1-Ze>CHB89HWcQS6Jd:dH=Y9R([5:11N\(b/U\Dd=aUePJg(,
8(_]b2]de\VdQT)S(cASGB65)Ba4FGC3L#<]X#/F+?JAUUX]/?aF[8>DS\1F3\-:
IFdM9cE[/-VE^J_7R1MD8.K;:2Y5<P4#gW:>U78?L8_JKR,B^8P1(HKfBOQV3Fg7
8eNY<2@QK?7a]IZ/.7O<F:_3eg;MA(Z5aF5:gAZD)GYS,2/;?a/=??RDKe#C]Y?T
#Z:3e@D+SZ=KKCU.@/e4\K<3:1>A84b]P/T8D,-_PG:/E/D;01BR3H8:W9S46OID
6IO>PZ;ID0&MV-?;)dU=Wg4J6cTe/L,[9=5W4D/=)8YAQWG0(U;C&CSgFHEHN218
GS00faWNM/P#;+e-R0I)UI0aQ?7><-1CcO+GT2:Q9<1GDOW;fJGY[3-GF7K+0JbE
>dYX0DfWEQ56R/F\ZL#B1)KAS4d2Y,X6<V#Y_JZGFQ;3>TU6Me1ac=5<UI6/4#L1
.9BeBc\,[.+>@OgbfV@AU[0<F5LJVV.^O^7WGUa6Z.\\Q7J-+.O;Q3^_cfW1Hg\[
0BRP\?)0>-Oa0KD3cB)EM4HZ2>?N[4FF8MDR:-(/7+HLUcHWKT)]B&5\=R7HOR.;
^V&a[,P^RfgB[0WK[RVF6a^(8&f4W,RDaN@<:Zea8&>HJ/9B8:5bCdZcUP78cG;3
Ug0O0^,21?+;QcB#C=,5fW3>L?L1RFAV4NRZI&0N<5WSKGB,Va0\][I.0--,[,IP
18]@(Y-@LgAd-P2;(/6fUW894:/H+/7GZAS(JVg:&A0A:G>8?UH1@/fW/Z@8aB0?
e1YH&Y@N.E+A\\VON<af39-/4K))\HH+VM<b>QF[)Ya7EK[+fNZA6PO.]:&&.[74
HUT-;]RNgU)I2=@?2;\A_,[Ca3CS+DWYTaNPHX]YH<+;81-,U?^-00-FH>BWAODC
XR2YAf1NINg.9&V]/fGP;Sg6ZSVQ2K:,>)0Z(gRK-V116dAaF7\=(-UJ(Yc^=F.)
-d;)]d_:-BOTC(YH4J&#[Yfb2S^e43aK1c93_5/adaW66^A6LB7SbZ,W_AaGH_1B
LDR^=g\JU3E+?^FQ1M+UdB+FA:e_J8JC/IS:F::D67(U/eZVU6eKN9bK+J?EGMS.
&87LR>H2_ScO+XJ<5YCH)[EQ7X=L?aeSQe7U)-,D_G;<cE<3^\,6bLD/9T5&KZPg
K_#eUN_0dX,gc1I7:V?We:K[D>.&0b.Vb[Q;M8bF0(NFQI\L5/Q_f[]EEDW^@aaH
V^)B[fV/D=CFIFa:e&OS:f,]^2[bJBTXWTZ)PJc\U;g8.7e6^+JH.._-8\^7e?(;
f#b3e&aKD,05f=3@-:HM?5/f=bHHI5XZM[IZL?bMMD/Fe(?IRa8TDUG-ZOXBJ&5@
7Z<Xd743W4NK&e1X[R3H?IVc=.b];d[aN(7d6NPHR.@gBP6B-+5f+V/GYSG.N.b-
?IK5KaegO]/HX(448<,6dG;0ddNg;eR1=<U4ag8MSM.VXJ9X>>Oa+g#_PPHbO3\g
(HeCPY\88VN6<M6S9-)FVNK[0=@/AP[dCZVB?6(gK/d46^DcXNI^=J]8V24?;fR/
0-ff4b:;NGC@]+GKIM7OSaPI9NQGYIN_@/-JI]6P@F:QfAZZK+XfIS+\M7?V:#7e
;@.g2+MSfJ?8\gZOE3.=,=XZ1?5,WL&.I<aAcf/+9?d[&.8O3bP5aJf8A60bEMWa
I&FV^BH+c@(AZcBcAGACRG5>@L#b5M7bKQWLZ2F+KWGg2_QL5/^8>fO,g?,6&4g1
e)--MCXV]9-T-7=3)<2G2]MdfTP4Y1fQ^ZI7e5S4<-M+AX__LAYZ&;FbJTW\7U4;
WD;M]L.N5S/;LR10EW/0dM7ECV3eZ)5cfKHSaY2K0Pb@.&9O;+:\3+a\>/@[8:J:
/324MWc]7/3LbeAH3MT,\fMDGW0Y8A_2fS?#V8OKg3W2FKVNL_LH(NBdb=W8bYW/
Z9cG16W97+(WX4?_><c]5OK8GGFXeC)QK_<^Zb._@INQBNC)VcUSK9EC7V@&SJDC
7PVFRd^#^Y2KL6A4@RRLYAJ=UGLBJP/a4(QE)R9MSf5+D4eGT#YPNZBd/bATHXa)
D1YN+B9EO)QSH/C7\,a)..1,YbPMOUD+fc6OSE?6@-.D-f1D?ed-B3#]&[b4YAa/
5=_C^/QD5:2-VM2S^@:I[Ad62>A_:4C9W[_AQA5YTR>Y?S5A<,9]PGF+EK]]QO>2
.#5CFR[:KNLRIRD\fZ[:?c#/\AcPVO-?GPTFLfA,+c++<N5La(C&.I?6c^=9f#4-
US(d&@..M:?1@=T.]J2R<-,-g]NO9=,3e0WED0VUTN,\c]-_VWVW7?S36DW.:@^Q
_]:0;16M#YCd?a:@M<I-f1>3P1U,1D:71K7?^JOFd6>/FNP&E,S)D0PWf4[@6[=A
JGbb>a#0-3=B;9W;6^U,@@L2;5.L27YL/b&].X\-7Z?aI:b[-K.]<(WBdA@AQ;1C
0.fXRdD8/C;+PJC43F6M3A=\URL3GIF56596^RG\(<S8?Nf5;0eJe.\83G^Uc2@.
)5^2J6F3^c^2LI(=[b[H;S\R1OXWEUZ<.C2>+eNM[3&M=FK)bHdF;/U.NX;6P>QC
g-EbT2^8\8HBP7@B-8+(L>+dWN3X+3D=^eb?f25:dgDY5gbS_g1)EJ3cIU,cKDZd
@6J@J7cK2bbed>I1/P]NN:;fV[?0VX=BU+GS5-;GS47L.+UCf&H\D=^0S\A-2-=(
,=3K4fLZ;;>X5CS3Ke5\FH)39=6Y^<21GPI-EQX,Q>)GA.g@]W2D+RLf<RNO9GA)
=ZegH3Y2RN.C-aZf6T8H.5[]7>(4RC/464&(I,LLLO],JXfZUTb\f;IRG(K:K1,U
+2(_12T@g->.d#2<\D8bSJgBT<#0Tb_^B@:C.^M4Z\Sb(6EASP/Sg#JSKH4g9&=+
6\YeW:\=3FRD=#M&@Ce9dU:[JO^bbUS^_+HSK)&0/5^(#L,Q&F_SY5gPQ.8EfJ=2
Y=+5e&S&dFAWe+,2eV_.aC7\T3(\>43VO(Q;FKIU.GEKbP]b_SDc9aQd^\TEUAQO
\GU^#+NVH:Y4T(AYOe#5#BA+7VT>>G]dNU/R/HKT@<K3X9a3A=]^WF1#N/T@.<MV
/;)XTVa5JN5L:AbMJJ1aag4eB#bF@[NT1=DeI[DSNQ#JBKbJ3MBVZD_&2:4MD(HA
8]/@a6P>DcecE2^Wf&c0dG,?e9&TIS\N:CSKOf[K.#><:FZ[2[-4PPU8:>^aZg3?
8&gD/9QCHeg7.f>0g.dY(?Pd+;0\DPR2?cM\72F5^_.UH^T>)gcgd5b(IV,Af8@M
4Z]CW]d13^0-dZ/V082-[Ta2AED3VSR>)O[9BR,\Ed6HX#e9fKa#^#d5J>ZJT^3e
&LK[2gcJCXJcde<MX,=561.cJ\+cD@=E-bO9MPc[Z9C9URH^7.RM^gg/3\.c6D=,
R,6/.T#K+X364C52T4>K@^>-P?GHW#Y[9&a7YLL^@4.?64Td1aK:_TXJ2@.K8),O
.3KA:C1#O\g?B\KccSB=acQ^D\B?8W,H<9PE9/GPPZ_6bR;XBBcad/QJG#)fgRV[
,ZAf.#EH6LNf##AF#XH:9/\AOS+5bB,U[OcQdW\XX6/N>BH=F5_C\GQ.^GfB+_1M
=ReOf?IT&g?XP.5]57)]YCH80J&B(R7\>VQ44FM:P7,N3&C](UW1MbHW?QR5W@JO
9N)N7VMSME,O4bE65CF,2(98-,[G)E/ad350C+S&A1>99dT,?:c=F]gL+GE&B?&G
04gQ9MV@R8[U^,9FD/+W&_>CF##RDe\Z=IFN,3Z4,/Qab\DWaTHaRX#9TNLg:TSd
#JWQ@N>T2>C3F;f50FRYR@8-G4Cf4HW:N]fS=6fH2Od\LX0cJVaMYBM_]9?Q-#QR
bX1J--ZPd42Z)7VVcO#GSOF8]M)LAT=gTF,V==5gC7S^#)Xecc<5-,7&<2Kb=G#+
KLJb3.3#H@LKe&)-9XMgb>Z&-T2D;?;:/g1c[Eff0AJ?/6E_BKKQJ.gL(=4f8B^?
]N5WAd-W)Bb5O)#>_;@d4RWKQA9BQ+LbYLL4DC&)J.EB7^&gVT74NK5KO)(O+9S]
?-gC\KD@SMU#-BNcP/^_Td;UL4VS&7/M,,VM)]W+@eMG2D[.8?_SRPDD(>&g5?-5
=:beR@K#HO[Oe/2Y@I>0]BOHcAfGdO5B+Hd<3;I1>)&VS@Aa?Xf.Ia@Oa0g^N&?8
)IP,ZC+f_FJ(3QcOPL)cbffK1#X7KTc&fA03G0ObK1SW.e)OgY<@TBRUVa5Q64=S
1JA9EX<XcC:L>d9#=\fX002;BZS]SL5,F;8K^]6);&If1HF[O,ac4eB@P2BN/GU1
-]:=-d;V&a4R(fYHQbHSEM(D]HEN&0PcV_DRNf<b&R@\&MZ+5)bEASE]K7FYK^V6
KeBI<_?^M+W;fe8D8O7ICC67B9,e_7C>E#V,36QS#DG4N5Qg0+\,0&,RY5e]HMF&
KQ7+2?E51/=-,HYOVYE,PLSRBIf68(EaN=O8Q_AG\Z,OPXZ0R+R>>+AX^S\I.FQZ
U:U8LTbZPcJ[?1f[U.XDC9c_.X\f/_?^4H>fF]<.CX)]G7YQe59F-4-dYf1:A],:
C).:M6_Rf?+S<&+1HZ6)>0CB0.d)6C_9IKP33ca9032YgGRGW+JcMGP&KP?)-K.R
HgS3^S@2L_Q/0K>>a?0_4;=@N1e62GZC+<P3N^4A]QU+b<+&[ACB1W(TVXGR-LY8
=FDCaJB_M57DC(-HKA9H2#f]+-5[[K9PCDT-#,\a=[/&1,,JM#d>c=O]L(?BR1@V
@TcQbS212PdeaOLQ\;7eKBU-1Sb5G4?^W4gH.Og@Z<97b_4gF^KRGc0#SCa/6=-7
(#KeWa>_Ae0:C_4;)N+YBJ@)A5M-/JJ#:?,Id5];OT(cNR<^AOf;g0XNJ3gOFLfg
F[D)ABC(#V[D0d=eeA0T.O?cPa5Nb5+J0,f&MUc>>=+=1;///@]b?&RO1X(GF_(W
W^^@L46TTYI(L.3&BP@3&<(2N?RE38V+T;2L>?.=Q<_Wf^?L2P__CD.g8Z&9YA9J
Wbfd+JLU9?MZJHIVV):J7E2:IS?(PPRRAg(eV.^L&EQLEI.AYd:SG(d[#^,M]a8E
W1WH/W9gKTf5^K47=P?S?GAY\TZ(bIHe>Y11KSgaY2a8Se+18P0N>)2ZP5aIDL\0
/1R#2PHAS=O\bLaT0:Uf(e;fXWPGC3W@_e/^+5,M(DLWB1K^&be.;KN30Q2M5c)R
C+Z3@B?-g=g_0ZaT3[.2ddee.P0TGK0cB>HT#?A),VXF-,e6A;>WF/dIJRCJE[LK
OQR::0:QNJ&HT0/HH;XGKL#Yb34&fU@+/4^3cNc]+O:X=+G4UggaA2^D+90F9baA
HFaB_bV5)[@F_Yb#T/>Q.e-60B&V8HgLM[H1SS#N:c4]@55AaNLSY;)<^<FAVC#E
_MfFEEGCB9J#G\F0.\?\bETHC/=FH&.:fTXcbP1/e)Lf5/Y<:GWVFT,gQ8X5fUJ0
5)L&SJf7C7dD?fR\TO9WTZRHS-Q<9^/V_)b4D4=_e7^1^O\<4VCJV?e7[4LNOH&7
0,M=&gaB&1Z=,5A@G)]8.8T-R]OODHNW3[U>4ebQJH5J4?_/H(P\Pe7-C[E4ZY18
,B90(AXG2cMF[N5PW+Y=E7^cJfX&-GHe9>R=aS>.3LCOY?A;c3[@O5WYMT<LceUE
UFI4eC[6WaCDa2&6W;(T3NW(4<3fFE@Hb6Q<#6&9[DGL^=;&G;OP\H]H.OH@EUY6
F-N#H.XaS0-2Q5:&(c5A(\T;(@#g.L9DM21IU.>I,aDRgf(MDc&_V[9VTN+S_L.\
KFLAK(XNc722]RU0;<9)X2dI]KNJ=9B\X).-W;1&OaDQ6H;g,TJ7V&SR<,U7MgCN
^_IB+SIKBKB>\ZU8[Qa\]/^+GVc6IRGC1+3E6X<FDFg52EOTG00db]C^^4RT5@F2
-Zc3I)U=1.<8KND=:2GRY5_@8U>Jbcd+RA.M[U,<;18A\9&cQ0NV/e^;_)aT_XU:Q$
`endprotected
`endif

	
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

`ifdef VCS  // VCS Release 6.0
//`protected
H7^&_GED8EW9=,8F=@\08bJ1<[_3<ReB=+4D=/EZ9E>^=SF0\1<Z9\.Z<:/),4O:
VJ/1]?/XUZ(Y9NdRRP3:9K#F&b27_c:2,G+=(f/9@NC>@#BLG,/)LE9d3Yd/X+c]
@-&J4NHTeY+a8^X2Y7;3Ia#a34d.F,;)9T)F=CP]K?/)4@f))J^1;aH]Hf,J<AVC
-IQ^-B<U<,)5cdYA[FBB)fY]8KN.dEeO2;]2A.9_Vf@2C,1A@cUd,+GE\]D7&c7a
\Wg@ff8Hf/6A>>+V_f<d(K<W=5T7A,E,J,ceQ(d,6_eeS,#O.M([.CB(;7K27KE-
DL0>Mbd87aCE0506UV::Ne,,+N(QIcXJQ^ZO/DFf+gZeN3D=CE6dfCO:d>9I;@J7
-K5U&+KJTO+Ja+g;AV]C_U;<DN/]?g^8UL8GK3?HUHcd=C]9?Ya;PHL1:Q3[dS=c
C^U6L<V5VQ\LA:C)#-#LUKag?ONZA:9dX.TTVP]4U#:8cMUf+D<cXK:cd8aeM0_#
RDTQ>a,H)(?PW5LTG3>>^/^Fg_KK(I&JJAd02Wa/NKKJYb]EYfNDLA052G=<=;0@
<0gE\aa7e)=<[dE[1Gf6L/WfKUD>RVc#X9WKFDDP1-2J2cPK?2<+>S]@<BS@N:T?
:XHRaC>EF(^f)./WX9W4_1TH,3,Y?bK\J99YD7VW)ZBB7^\;BbE9]2[&8ZE@eZ/^
NI2a9cW/TU0L(5J,\EVPFF[?V[R/=IK)e,QE52I=Me(TDA)3S8K>Z90CJgQ+B?\]
.E\7ZZ#YNRIWBR+7Z9eT3.X](7eK5dTG2HTL7RRRS4cT@Agf3.^,RPBEGFDCKUZ:
=,OJ/RMcQ5-JCc?_fYLTG\Z5V^fgNI-0055\.CF(M.L+,NM-34I\]+:Z^;R>3),@
-K.S9.GX-EgbDU);e^3.PS)D-b&g/WcTVN]SEC5Q/Q)>,0&DR?]5.1&0AC-U\;db
4a^e<0IP?g80;@./I9PJGM-L>HZ5JWT),8(T7d6(_31SQec[9.#;@;P2V@4F4</B
-,87:R_Y^<]-UK,a2Z#YC?b@WT+<Ae8I>8I.Q;66(</K;Y)1/F_=O-3,W;Z>_G&?
g:/9/>M#_)65BNcSbG_5e9.K^6/-)g:QCL7g@-3\f_EMM[#^eJRBT#aN)&W(0?HS
_I8S-)[^QIP[/&[@D<J>XCO1&MT,O0M)d\_I?JTN5//VVKG@+Gb];J3ZG5-X>N\(
Ta8\?9^?>b+&VbXg7MdV5YKD(8WeIbAPM23T5TM.VZ&A\.6J<]DI0\cXeOC0\W7.
;N11T/2B[=SGM^M/B729D:.\-PW9\7cS>Q,J5?A(3f@?^AW]QA1\#KI;&db\\YJC
B=>9:e#7/.H[cZUaR0cKTY8O4KUHLT(H+P5AH00JLT@\/UTAJ^-dfG=/VB<66QaM
/JM1f+d+f0@E=W-^S.2>K9U4(0]/T7:A<30>GNDBBT#_,W9Z171BUcN&4/#7Q_DG
9EEgdC^,,8:f3[\EDc69U/(\FN=.Kea_J,R,C&W[2-=Id:d0C?8@OJ;T##W3.(:,
+&0_gW6^DI34Se[=ZYFNV5DE>/)#8+WMJ:DW7/EM1IDC@)^0;aWIV-IZ^GE?<0b>
.7<):E=bGOeFSW1D^QG<60OcI\KI@d#c7]236>CO<.J>N^c5E,N7#3HLMaHU6\dT
H\0(LgI9R<c42]ZBTQXJ;<JM&^V4W;YDHM-2BLGQ3.SX&;TM4/RVOf(,UVgb8,(N
BUS6<B\KJ(FJdORQbPTU50^]^ab_ZSL>b5-5IKM,EI\BaFL5>U@aL)&+9?_d#F^1
8LJK-Jc9(&a[Z:O1Va:A?7+B.-=Q])&9gG=R_)c_Ya8,b#PNGOJ-(4[2,6bE?2:^
)X:VY.>1OBH8NYX6M7PK8BTfgG7-YFU@,LWS?EZ9]7b3W](@=]7#X=A)4^X.:#+>
8[CVK;PR6-DX4ERP/06V#3U3c-bD82/3c,1P&G3DSfK+)).\+G/LN:M#IVAT7H9H
XPDW/ZG=(HO^X?C6QYIK=P8Sa1bBY<7ISNd,ZQZNJQL30cNd-2,ef@+>]IYQ[^)3
?L@AfNCAd,3fF4GBF)8Gg\dKJGDTbeVe)V5^ABgB2^L50BV^A,HacW^T5=7C1b9a
HZR>aO(_6Y-]QP/=N&&\10MBD\E10XPO1Q1Q[W\T6b+ILP/@?G7FZ<S]G9F\X?96
E=3D2B:UbF0^L;0P/94dH/RKKe<7ZH;f+OeCeRcAF(aT)M)EVS/]B4QMN<SM;2cN
UPTO/@ME0ETIf6Hf:1<>>cMHeT(gK:=.Bd??6SWWR2P^96ePOI0=Ce,I5?C)F;?c
2=FGGGdPO3X3c6Rg/eA+==R7CZALDMe;U+UY4c?=NeG?2)e;TA[d5[gEZ^-#]IU5
dRF^:Hd^-C8K5J+8Y?&<3,RHZ^0>d]).Y4;8TeIW5aW4#cXYdPa?E^ZM27-Qc\KI
aX:H8Nc&3390T/+c+9@7W/Ja6XSZB1ffMWJ0dGTLAYQZEg,db9WVO+<ASX.&R/S,
_D4JP<>(PM:cXYYbH0^>V6#KbAO4(AF^61;+a<PM?^c[?b_I,d/CJBJ_.WI;?ABX
1P);3T16_a_;I/).a?bcQ&2_NW+e@JR^cGI1c7U2C,-9a(B[0G=]U^>X>O9Scd_:
ce1Md7;UBZO&e5OA_FQRTC3MXa73>\DQK,a,Jc0:=c3cTQ\]]MP3DM-Z=Z6V,[\-
I\3.#[BFIV9V<P5UDT4KDeS#ZCBB-.NfAZNg/YU\7=Q],JG_SM0[1>:bH60=YAD<
g1>A^J#<3[A(QEOeb,P\.g_/Q_,0:e^(-b51\VMK<QTA>@5^;6A+RO2ZO\@:U[IK
3+ZIR4HRZ0Rf.\X(ETAK#6Qg(>XY<=Z?BYG)8W+8bN,4J4^dY(Pd+Z9eCZRIPUGI
UgWe@eafH.YK_dbVDF12Qc/)]R0#:@6IfERQ;)ag@)@F@WgOG@,;6>PQTdN^V<7@
3H_3eKKAHPgF-JO@>V1HT:.LMGH\V=OK8&M_S@H<+([M-gSFHD2UXMHcGH2@?])N
9+FAGCH\,,2U_BaTV+_E6\#TQ^BdU?3R471^JeSN+H_?[XU.[Cb0,;[cAS#N?/^B
(<[fUE&</M8?Ea5D^<>.WZ8II,#f^5&.(XL0,7M7cB,1FD,UFNZ;cFb,FR5^)N)-
TS+--,eCe@RMd(d1->SI1\PN9^&]9FQO.I6.95V1]S^X#-=34)4;[a:d5,/XVZW)
T;?b)=:7=6E#P:P3,Z7_VbYe-L.BdU_1;N8]?JNK.Y@1eNTaY0T0gTU)?N(2<1RT
TKAJXDX+;c\WR6V8dDbJI75W52KA#3DdC+C(QR)O:QD.YJZ+dD,IEGe.ab0-BP^Q
+LL[W]VQ)S[A+PP(TAbHKNd6#[Nd?Y<?cgSLSFOcF#UCC&JK/\<aeQe.L$
`endprotected
`endif


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

`ifdef VCS  // VCS Release 6.0
//`protected
MB#\PRWPI[1(,2U)-ILC8K=f=Qf;<D-d,6D2<L@T:&RM:.9M-(3-<EW=8BD[-CFC
^e0=ZHLERYZON4;(fScMG=N,@]Q0(_UZN^XYHeO^\ea106XQ>(NA)XZ/XFU6gH+5
V;.S3K,@2)N9C8R8b,SDO?DP6GD2Q->=X-0>3f0<;aOVO&MK,X+4-[We:2>5B>Yd
02SYT(I9RGH\b0bT7I&c@ONE,A98LbUbYeX\H.+@FOgYM=,R0+3W78K1FX[24:dW
T;KfGD+Bb[P9H/[Y^(fVHHF5D+IKZJF9d]IX;5&6E04+<[[7I7<g3=ADNIe#FVCA
AKTCB>b^b8]E3b]@_Y)?VJ8D=,THCdDP0R#:a?<c;9U[dRMOaDKd@G5X?G^I#BLS
K_Ad8.f13If,F/7Td#.>bGTGIGGEJY4cg8&N06=H#MeJ?8,5AZ5HO076g]TVffM:
Ud+#RGb7\65QCRB6]TCc8Y^+c\Q3Q(c:05e[:,gd92Hg?RDGOBNX@<\E5Y+E1G(^
OS7-OJEVGRUO.LGJYK/f#HOYL^PWWS5&gTI41.GPc///9\g0,V,=ZL@5RVF<=)d:
M\8-YFPXP8^=L3^9:0=3/4bS\bJ9<49^(V=7MD=F>-BN0M@AK?0>GN;9DcWf:N+2
>?Q@Bf,46HG1\?ASL^@B/aQA#NHX@[O-_?=^bJ[2C=))H<-=D0D6\]@>eE:I9S0C
89)1WaX&I\E.U1YfJ[FXH?M;K83\1]E,JD+=4;9@+X_-(fL0OT2dI\4X>461>=]:
&gP\WFDD><SF1^NU,ZBHJ-RH/8SD<FgL)@?I.,bD-K>IJ8<gH1S]Z2F@(2.f+6Y-
?3Z@HX.@7E52QJAba]U3-ZK&[4.?8a2PSQ\1>(8=I>M:Y.2&2,=]Ga;SB[8S@F+X
\;>2_d;K,15X7M\5eV1@X);T]0GM-2]FAX_M#X:dT9b@Ta&ZB&/Tg:;#(9bde;P(
fNG<1A#PSB_Kg+-HG?9HXI0d\-/df_f^5_c/7&5)0>?82.#@cKNV-dOSC^FG&K-M
BV[@N9ACMDa\Z(,d/EYX<.]3A=9eaR5FQdcb;&d@IZYYVYfg\[fa6RGYIQH.aQX.
:EMa8UZ5Mf1&>^G=-<C:b3Y^F8G^QQNBA^I3U]PEGF=c_O37&15)B?80YOO,WN,.
767Md[GAE6O1HV-IJ);][NS0_GHbM?G>V^/?Ed=9WCaB@R)#d-aCNE:>/CQ#B03K
X6KFO9PB;D,,X/#J]M+Nc02:-2e0PFL&WU7g0?=64XLS/5<>DAIP0P78IGLD@:#a
Lf\V]aK-<a/P;7FE8F<)B3#QY,34N+27IcC5\^YcDX^^(7HD@ET.&c@I5?9]EV,9
#^&V_Vge3adV0W=[I:K@>HTIB9dWf.:^Ya\RCC?EGHM8\A.Z;7Q^9,g4A-6[-GJD
/FC)VU)&:8A:37XEg):X?^a/^T9.49;W5MY]:c,f&8WHG:,K.YBFO+>Y9V>-QJOX
0R<=EEI9Je[^W=\)Q);57b\V>IFJJ\769Y]&RQ:]PMcX#:JWFEKLJU[Ed,P8Z8#I
T_HU6?D?g[b[782Q9<If&FPCOCLSA?/KC[]:<F+W,M9R/I\P>PV7aV&d?L[JD\0?
L-c;(X6g.<-G164N:8M@Zg<-ad=7)/1O]Me0OT=e./49&a&<1J1SCUR)Q(f,TMV_
8\O2]]DC/Zc9WgH+/3\T_3PHe?;)C<B&O,+=Y@A/&\95-F7eg>FU=\H(7b.6cdNU
75](>e/&dXK7DCU#gA4QU6IHU<.L43Le^8=YHbSQA\RQRa&2RWC8<1>FZgJ0QBL8
c9C.fg)@0RW>_HfX.bIV7BPZ7ED>P6-ZGb)A(P\T@Z:X;?_f^23PdG6Q^=P^DAXa
VXAAe\\?CUa?6Ob4:TNT.UeU/8#2C_S5QGReA[BMJ.S/dE-d^HNCf(.PXE=B\&(1
\AO&Q\G=WJ_3=V<AIM\W]E>\5CO0dA[AFYH;@e58:fBfV5/-BHgbS=cM_-ZR64R=
bOA=C]Of4.9GFO?CV4/b8QI74:0B^U+83dMBLWa5L_0_+BV&b]JZ,cRP];GcU5=e
[^3OGQ8=[1;WNW3^,WP<FZ@eMK_2>X<Y3a:G>AS#FgDI<^MaPE08:O2B9:@NG24M
5+^-fO/0JYVK&c5?8[>==3>-Z#b#&cO5KASCEdKf+R/=7UeJQ(fb@ce/F<V94/cJ
,^[IR)8M9_W\+e?_3<@8bVcXg]]DDb[>9IJ)f6,FbfAI=(QUbE3,P>A_?D\X+;&.
:CYVYa-ea@S?1Y:O@f^\]B(R#\=.71Yg4Sg+]@43X:ScaK\M-SK;Z]8\F&\&RQ[T
P4DZcdd5-WD_GEH-AG(VcPJTCH<,Fdf=XJ780S=(QN/;2[5AWbH1B3E<>8]@:==\
JCRXVWe\gCQ4^QHKS)5M;,HDXaLd/H6A.)_=J.C_TR,4STUg./4[H0,2_)BX<SKK
.EK,8@I+&P7aCVBJGfZA:P6_CfYdIQHd9#^M]H8+^UV^\A#^]3R1cPEVQ9?Y-O>Q
IXE]3^.6ge\E?@Dd?9S@VN+f<K823]e9;]3(E733bYX^C$
`endprotected
`endif


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
`ifdef VCS  // VCS Release 6.0
//`protected
eQ@?Z8.f5bXa)c8g=J?L9X/E9(.<<96c(.@:=gIR5NU@7PW]C>GZ,@MR(QBZ-U,S
GJI>KS?.7]<T^NS6=fR6#,LD0B)6#Y3C._M]9+e#G=BW)\7&@RGR9b=+1]R+@C:I
gQ(YE6(UYQ^<=4PL=6G@_d[M<c>&6YU0EEF1:>(acbI]7GOd]Zf,aT,J58W&13LS
HKEX6MAYg.^0@1H=Z_[&1/=5B^6U(f)EIQdWZ4_>B0N>C<>P)7NG5)-(Z]b[+Z_-
X(J&?<18AAc)7>0[If0BL<)[Q>)-DIUU_7_UBF><Z+#+YcE#-WN:BD[a10P?U(:G
@TTSM-(7??]Yab:1,AXR<&&ZY;RL1/,T<_&]#Q)O;b/N18ZYa4B;LA-0bX1X4171
=<6;@B&@Hd:S==M+E.JPgAT63f9fYaf>)RMX/e#I@A6>Be^\fIaDO4=ROGBCM-cP
G5D6RW=QaMJU=M,4(<0,bPQ<(5L(TO^4@GXfNEKH70CLU=TU]L__bYNN=EHIg1I/
E4,=0fS/)Gc[?-QP4.C<?Y9EDgO)X09g9Ae:P,UgcVD-54\CXDZaRK)@PK1DM2<M
f9Wd=+Le#1F(RbXVGS,B7=6McYW+^ZFA60d4d\)4(AAcY?gY9I@T-FU#5DC+Q&-M
?M:+2O89<Q(I_:X7bX]FU8+H7W(&F^Ta]U<YKI^:NZcH6/IC1UXG]d01:FBXgbPL
\,09S#Ed5>eddCTWVY]<^OPRW=aa?AQHfX)@J60ZN;6VD1/03c#0f]&X@g]3VZRJ
JMN[8P.U3=;#^FagE6F.S4\GTb==O5B<Y@BCLK9)S(H:4F(\F(])I8(Dc=de(:0G
<YP_[A?QRJ9CZ?2@]X5cC3OFEYY<@cY/F,.<6e.:UF92LTX19H\AUUH/FSWN]S?L
A1g<AYDE]N.BB8#(:8&?ZZgd+_?KR^EG4;9b.,dfR)U;Q+Q]=D58CW^Z35If;9WR
^][,]?#-<DWO.cM0gI#.bGBWZX)]BcXY?a\DTYK<C4334_;?#S?NZbN3\gLNX#-f
_,S7<B_7\2e.2LKeQa;S8XX,T<KXL:JD5;3+MW#TTZUf.ZCb&O6#-B2aY-QWBDSC
@24]SH8AFQG.d>2I)IIN(AJ>=,4A:1\f<dC@Ue977f589B#/BU6)?4VfQ2A&MY)G
&WG).<.dLBX1R\KS5767\3\&J.;K:;(1X8XcXZ=a=RF.0)f6:aA.:_OQHCLP[NDg
_1Z=3+LYSE9c?Yf(^\aZ04RaJ\0+&SbHK1WSaYg(@:G_)?#<-B#DZeWZN@#U:196
A&:NQ##RX_I\RfX)+Q\/Nf;Q0S#43TTZ77O=<I?E#2I1O\Rg.-S9B#PL.aNU7T&;
<A9&+/MEOMC1H0XF6&U[FI:?IO/P-d>W:e/gDY88I=]9)C/1>)47]-C_V=dDYfa.
E/TU7PDC2]YM8U?dVFD<3COWSO<fLG,P=37Me@2U.D06Q^]QK<X/]<QNFKG(D)(Q
&Sd?<9WeIIb^L>V^P)=8==5e7KTIA:77&)bMC@H5bPf^)2dUB&Oe-E.QECN1MGRZ
/)f0D<T[M9[8H#Lc]B:;MKU9X-,c_N_7N#;NFZW4P@0NC7Cc=YE2>Kc:XVB+e[+@
5MVUA<a5dd?;bZeS4:H[XRJ4cD^Z+Q1TDfc4WfWYVA8^)eE-UBPIY+N?N/F+E#C>
SPe_f&f.-KBX:Q#_--J;^gbgV/HdeA83@G,&C4fD>JSK(aA\R1DeL/d_F(->D<4U
:SAOgTJ[OK(ZaEW3^UU6W&Z,Q5Y[-QSPV>C2)GL/#B:2?f]HOOVd6]4OHPcHS]Yd
,0>)2+,H;]g8@fQ&5R16ZIGg0[JW)?&fF+T9])2Q4\J:YT@c8^A2_AgG,EVG2gU(
XP8ES+NREO,V0DQNN4&0d>AE8OfFRbdc?PSce1b7;GJ,CcbWcZ3NQ/DZUfG^_]T+
5CN-T_@Z^]^-N9_]+(L?1F00g&6526=-bTTHLA7SG:SQ58WOE9TK[Se95LCd0/-2
T,/1&:1FK1DEdFND];+>_T@Ja#D=dXXS935eg)9@fY-TSE&g12K&<AP@L3Ac:5B(
;?d&8ZIT=_WR&aSZ#_ecc_<Y0M;)_[Oa00;)U(8];I\YO5.9B7H=;L[HLPOFQ]G1
cILV7?2;E?TJ(F4H9_QgR)SE?\J-;3,U12G=M]3MF2E]PK=G&VBD_Y6f(-[AH20]
JUIIRYNB89[aID,4:_?RP^T4F_C.DW-c_0I-)C4R,#8Q/;:_[]/fW3#a6X9/=>a)
/a0K,/#[C,Gb>8:#P=a0Z02eTJ58YD+@0KC(FF1Tg+d7EH#bf(&&QQU(#22\eQLe
I8CbYK2-\dLTZ^>GE4UfV)#KbETR@=9_/)4_W\L?LXK(2HTa927\M8@aR(DRb27?
a>5?ZA5X]TTV>@4HaEaQ8&Q),)H=JW#7#Z(6V4[^b[bPbCJ55#^^;R&S8Of=D[VD
#eYD6(P+ad2_R:_eFXHDf0?]YCPPB-B^MB,b-PYJY(4U?,..=7LOdO.WKYE=8/\&
Gb<LD:C?-,GaTC.Lc0c#+PY94\WKAe/XB7T+Zf[E1_RJ?[gDC1NY,)<_]V@][(^T
A6.IRF?#)PXdCHL8GQ&OB6)#.)[KNV7?a=)CaGX7fITW(-ZdMbXLWbVb+,CFb&[R
7@#+:.VJ<e>c(XZL+S/Yfg_BBE[9L#8V7.;Y57BY][I6,N;0V@H63#;MOf_W0\/S
QN8&>SMM2TZ.,a&gO^NI6DG,0,8.@?LcOL(LFTC3d0M:WJS4O=5]KTA5>e\,,?.Y
-CPOa&J70Nf^eafXf<[ONC>^9A4bQ70/gY00VE0_GC6M9.B[DN#41U,5I1H[U(\2
VXYLH1&.fA2cGZW,<#7VHbMOL@,fg>(_]T)f;77UGBGdU[-QEPXSL=Z^D(dNX(EX
5@I]d),[UU/V,SU\7WL48?8(82B?-CD18<a9R5P3bT/eHXE-?VF\Q.8,I.3b]QMO
Def<^4-2E#3)a?4(c,2,H;+UI]51]eU=f-g]Qb3cRV9]R:M9;c&T#c(^2ZSI0\>+
X&WHUSeH189YDe2c.=)BZ<5b/##,FfIg;I3fA3cgWK)75J#6)?#@EfG;Z.9HI=a=
4TA-D-[6L?JVG45c&)@c\/0KcJe<cd6aG]QMPAKI@AVWII80N>L]4a?=:[URYJQZ
KNa.54H?>VNT]GPTQ=^EO49gBE;N]]XY]B@7dY1CY9^@9N9\5c)a2Ja6a-9g6418
ZO-/.-W8^N33DZ&IH]@J.@HAYXIFbF@9f#N)bAa=Vd-HP39E\58&>[PTI,-]VEH,
A&=BKLI?)R8,:gdL7;?M83VWW=-:/@dK?,TCYRNcCfA7_M=UeZHR-c(5g@GW?aeZ
&_PaA-&Y(WU^\(V84IK,K9PPC2C_4\0AbPe_DA,[b+ec7?ITbKVE<c:?A-1:6J8T
-YH2\N(]O#6d3Y+T<ec9.LV9.7M)PP>b&DVc,8+c\^3\0WP=3c]2cB<;6SWCTVB#
OF+ZH6[]_BL3,US(\+ETP4MX6/3DS8XQ^VE6/_=8U+(T/]SOQO39+43P.]I7@X(R
]PH)HA[5&:^g3<M-PG-H+4YX-NX,<ML.[P6+D7K\d[M#DI\XOQVCZC(B\EQLaJZ=
4g[f;bU29U5C:)]SC6(2=D]+P7#2.Pgd5b)(QGR>Q_2c1R\TB>;=@/W309RVJKg_
-W/M1eV[5eS_OBP###[a:0;5.F=B5@DGEW.@c7Jc61Gb3:eF/B;J^+>(A\O](\?5
;TY5[d#HCVE1N3SM0#[dYd)eT>&E6Y9b_+13eH]7P3MF6fNQaCaH)-:57S,35g.&
4TfW@OPY&J/R\aSWY::Ce)XG&E_#7-BgH@\c,&S1-)L5eME#F2@6DfU]@ffFL=>M
^4[4>H0QIT;@@(229..=gaP@KGbD.:JQ8TEWV;ZV7[8^9fGB0^98MGN@4b<4&ARa
SO0]<4Y<JZCN^@\D?@(Eae\8e[GeW-D)&ZUe+[8/8E7+&BgUd>N+C-,;];2OQC6X
^CD+Fd.#gJ>7\BB2:_5\.))>c5=KNHg2Q.WG@aD/W6C7A>IN\;S0NKFMUa\ZZ#Wa
]H0\9M6T1eCBAfQ\M-S?6UW4?RKAP@YAU<OQ\K1YB64UZ[,C=VXeBU#0XY#YS_?4
8JTM2P4U7Y)eQ1gQJH<7(F6/S0UQ,E;cD5O/C7(\,L@+C+EVGUXQBU:V,NARYd/K
2BSG9;5N=JO(@J)FDJf5&1MXdG54#TX3aPHaLD9L<QE@M]Wg;NGJ:,MM+M>?^-3J
SRQ[X4SAX?B1.?2BU[PRJ4Gg+AXU=#Me,d(@DFM);9N2a1R-#?LV.MPI;,BC:M<_
e072:GCGAVJT\F,Gf&05IdBAQGZ&][Z6(IF?bD;>QUf--:H9MbG^;eIWEZ][PMTG
e5dDJBP3MC?Z9fe6TEP1M@DfCe1ZLTSMP9O3PKWBU1\bIJUXId>VeHTT2ILW5W@4
TN/S6g:@V\TB^\-/,_;dHc:Z+QB],c[0UbN(?X,BWFgQ=MC6b6>;YV)(S41)W:&9
-2_d(M+X3;\X;?B]F:Te;)_Wg9H^B8CC>FI)MHg+f\AafOa/<[HR_M#13/:F-@NY
#^C)VcgEY.cd9&FB]d,_JfVLL5)]FCV382L+T6cQ=DLaVMYL,+IS\)6,)/4T<afZ
X6T7.4A)0DeJ)UUHZJYA^-e]JVW=@GO09Q#MI/e#gW/:_0e?dVT49MW30G;IeJY+
^WXOS&C-S8d0._(7?cGdLYaL7^ef2\OR,gEIU<Z\<8X-GWec\E(bcM;<b.\;2F2H
;Bc<aDBdeP&FT.DNGAg@,EIL6/DW-4&C,@OO@YZgBe/&CRS\6@T6O^0G0EGMIC>E
@1B_8Q.PYE@\BBCE1dVRf2/YaO;LO0/+^=G]=WNF/2[5^X?T=XMc/=<J<NJTXJ2#
WAPE\T/)c@<>WZeB^^b7@T6gTXb8VDg^FH)W4b<.5Ea=?3LORfJS06eedDRC;#Q&
5Uf7RSf2/:7.S.5adB1;S=ZZFIc#[,0f+78-U>8N:ZW=^fRPgB(^.6e-fLFGZcdB
Q;MedL7MV-5;W3K^F<+-+0N.E\Of^3Re?d]O\&N;7R8H]TZL3Q:;2bQ#Y8DU@@&=
3H&L]VdPAX)F-U=NUCZ0<bU)LM)4WOQ0aV/_4)Pac=e/VG(A57HfWU:J.#8V&\+A
de7W(-[aT.3;==Q>gS5KA0FKAgfGF_=PR<9P=]R;Id_FB9-Je-M]9cY)0N>^OZI[
L3<&.?<4?]/_b4^T3IacMP_3aRL(g/@HR4Rf@e#XbfD@-DE8,:&9Y93a=B<D-f)H
WI@0dWATLFGd=J]\(g7Sd2O=M@B/KYg8Ng:P,B)[AY7:(C[b_4+CDCYXKT>U;d@]
6>Q=d/&EG?T8,#T1;:_E2S28Q2[UQUc_BAWbE_@HU@(AfO&CDN<W4EH?d@7HA4LZ
dLYbTU,8P=/79ZEdO_DcELf_C5PWPIMHQP#L-9-.]B6V+5Wa/WW&-S3=.DTVM;Lg
bA>A;59]N&]_?7T>I(1<,@0e&1d,23Daa#0+I-:W83bL.=DK;W?db8[]O:O&SPG)
>)(/W+/WXYW:9SV/TJUcdO]7PB&O9]I&8QA][D\E79P)-b#8&0QTQ#dTc50I54Y?
-]Je.6C,_R+@JJe4^F;+O_>Qg,dX^[MF3)))\:\P5D0-HI:VP/S_?Ra8NFO]<RVN
C=fY&(>UXSO?eZXdHR)RD#f:c]]a[8+F^H,?@3fAMS6F8J&++[OKY1>6+0V#M&M]
.,6YEWKH\e7J/8:ZO-;_7[&]eH0DDK3ZPZbR9f8(E>3[DS5-LK#7I->6J$
`endprotected
`endif


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

`ifdef VCS  // VCS Release 6.0
//`protected
\WR5f;FF<da1)?X4)+eF(F=Q,#)/=<Xb)cC-=aNQ8&\YN2+e2&.#=X.^=bJd(GG:
b6A9U#J40W6;4cY)Y-)=.I-ULUP/ZagPg?gQE#7=]MMR2gAW_:24=[<UF&M-g]A)
G+40&VCbOG+\Y[#[B4D<G1(G,C6_[Lb/J+\8H@L9a[B>01fUO\M8P(TG/V-38<3-
7,A+^:3(D+<#EOc2:Q<^dRO^V+Rd191[G)EZ=TfB(Kg/8V[B<?af^A8E(dEUS94Z
6ET^gN5S<5AX=A-S_.E4T5RE@8OH1OVJc8PUAH[9QE\PC_XTE]7?F/Kd1<3CQRF#
K&;,UW9>;g.^;)VODb.F=THY5<_1@g8-GAUgYL<T.B91ON9aC[XE^+9BBg\)?Fc,
]c\YcRW2:eb^Kb=GbUS)@5U9TG2OcZeUCQ\8c9I=BbOf);&VNWQ2<-,UI_VQf?9N
)+6;(#2bEDKaGXJAC)TN0)P>:E)O>X7-SRD\dRZ7HXLTR9<3AXA7c^.22M2US0bC
OC76,Lb??-=H>;@28g>ZbBYU[-)[9+25J^UT@KTdD96G6==<E=OO,&gg<?]NV6[9
9#5d_<QO=P3O)BAK4&8fA(],-fIL6F2X@-WO[Y_HXWM1+@gWD#Ef8NWJcSX+QP#=
aEg-.d&-0c@G)@&,]>G\6fOZIBdGOLWJ2C?b;24=0>RJ&IENg^OM0.?M<7@Za:=#
BP.(Ig?5a-CJ@?A<S4C2FR1eW&ZBDIg8ab+DTX.2A(#)H)3WO\;N^gA30dY\>T=Y
0GM+A3B90ba)-W.K\@=GL0^Z2B/75F_7=0R+RgZ>Q5E+HFM2.]3QK1=-KdM&E@]Y
^MUbI+_9gS1@SYVP,9^-/c0^473+fLY8_)63J5LdWU/LA&Z8#(c65L@AGM;_54EU
bBg#+N;.^J@3/P;c+TJ_3CU-6#e5b^YD^@+=]eBEe_;R\GN1&e;b\?R[;68M/Wb7
^94P4[2_=3Dd(b/KZD[:Ge-C&M.IAW0)SZbO?RI]F1/J]Y:EBQ^JA)WAV?.]R^&V
,TLZT&&(]54OIZ5:,\be=0aObN8E0</b_S_^5CH7+O>CEYE4OJQ<>W^5YANB5ZRf
He5UgD>?6#+=LFLP<CQRF?9+=H&SG^Pfb=WK\#(bb-/,F5<?8=ZKV&?MO7S,688c
XAZG9M?H__AgX=]KTE01=RH9L;@_Z7#Q&9c05DV^@+LR,b=L&a&@@Z@#R)CIb6XI
I/^XGL0P0ePAFO6.0IWJeNb[MG8>bF_eH=O\NR?A#+)WCNRT,gO^4I3T[=@IScV-
^SB+H0>_I3L#:#bXTV2f76,dE0c65C).(D8gH6>D&,IIYN<;-b6Y,Eb[R4P6c:Sg
OP-JbQRd0=_^XXFegLU18-A\;.@CTX_E<69<]DW>cL^=DCL_&NCG-UTQSf86/[@?
4CIJ9OOYJ>_/C?+.[D0&E5=H_/R(Kc\P/Ad02G08.0]?\KKL-OFJH)7=,HUa^J6[
/5g=dYb,#]-1g@bDJL)#)L,N<-E2\HU=AfG2<=)eGH4R3;U(a1,f9e\\f4,G-K+\
5YD5VEJ,B>)Za/^I)d7ZA><#=DdYVWNMNgK.UTMd<]RcJ_5PVQ^#P,)4,\7cddYA
[?8)>g#A+X#-T#\dT4;-eA+c[2FgMQBH9E\He>[[D#>^64dMaLeHb8#5^@_[-&H^
((C3>OR@=OaLX5Y<\-1=;_Q#EQ#]NSQV_aP3L>=B,aV(\?M(DV9X;KKE0IQ^U;F\
,CJ/T,Yda6[aMaa8E\\Yd9DM+KGgLM_6I<_L:@ANPMY>^7N\^_14#4NSaU59RMcT
G:WF:QO[)X_b=[HSY89.bbR6I-OAO^B)\W+X;eC^JM@6(<<H7=XC4]8/OZQ/,O+#
#8(-9PB3>U&>#B5;gI]<4A#;^:0\\Ugf;3(FDZ+<BZYHY@6#XDd[1#f#BY<).2H7
RPK7#,M_N&5F=V2e>+:E,@IId6-S)#30;H==_N)XDCH1QT&2G;L[9I]H,&NCDC#S
Y/+/[A0.;:>8T3954^K,[dE=R>_7XgA6.O5ceZc&83]G035HL8A-;Y_5ENUUN[LK
=XbAbA)63O]DVL[gc79&PZW0EB.6),c0SF7/XK9f;FWPfQ4TNQFWa;<VO(:B^JO6
<Z)fQ>?NVeG(GaEASU[UWYA):\c-A.ZQH7.[ba0(.g7V^8E38ZP,MPJ)7^@9V8=C
P((6\VL/&W#P[-8AMM;.<.)T3FJCT/UU+C.bWU7e3M4fQ8/a(TUB8gWTW86J&GIH
3,4aFBc(B?JP0$
`endprotected
`endif


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
