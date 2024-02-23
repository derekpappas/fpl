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

//`protected
j_6edSQd5DT^<]3YI1DZj3@Ck5f67ZSi41j^_Y0Qc=:N>Eie6=dg5UnqkA_=a42V
TWAZ3EV2I>iBiioLg`;6No[p?h8S8bceJ:[T>3oT\cCqP`i87?q^__Xg2qPN?Rhi
opFf<4A>[=EbC6Z`CEeL]Ej:acK6OU2AKYQM3Z9?TIjj9fg8I>GlJOGM:QXIAqK@
cCenn[QbSHFfH6IS1<RMlaAM7F[H6MEmBDn<qM96`VelSD[e`_dof<Qa85K:RimK
`Ag?EJZpjC40HnhVTGNm6IM=`JA2Mf77l\8OA08=AQUn@>b`oWFqd;e`gNlNAo4@
?]JojSl[g6YdCfoLZ89iFh5SBGPd44[q88\Rm2gjH8hHeC6bQ]BGA7SWmc]ak[6]
Ta92M=2`doN<eg@\2A=S1Yc0<[SG]:bWCV0Gqkn;eAKPJZ>aK?4`l\3N:gg6I=Wa
?8=G9qG1l3Kl]6?WKA0^:5=?RPa5Od:hD8I:Ee;7pl5ZDKZ1QZo97@XWcbgURFko
;e40]H9NqhcQW`l^WOVEmM^cD?2>3naeCW<fAEaf8BRO@32d;<KgM=mkd\[Li4gf
2JepCG0Rb]_qV:XXmPiNPESa5h@oYLc0JAYC;kH8c;^co2>=q719m`3W;G`5o<jC
_W2Ifl0fb>f8a8b_35MDM<K^5JV>iq26eP8\hpQk\if@3Ija7PMR_Xf\og4V`7W8
Y8pRDmbA0J`bF]>Kl7<Zcfaj`]ZX8SD?`IP1o]n7H8eHhWRV7Iq6C66577;QTLIC
[PYFKWTf?A>J9kO`d8mNSi5`RPLmGc2_5Jj59oQ4onKq5Jb3nZ[3W5O5WSN_b<4;
2NcW@Y3BVYQhF2q2GI1<i[p^jCFV\^q\<Sl^e_hQ8@H?;0XW4^iX<0l>lo29>0Wn
heYd^EkR79VR6O@AYieTMZTKmE3@CmgNWE5`TE@RPUo@cKZVPZeWUMcPZoK^B]56
6F9KPJ@k8M@o\S5Y^qbU\mBM]\f]IIZOjclKRYZdeZO68Unm>nGD:dB@U]0_a_Nk
f`^0RdPUSXWaNlqIb@<Dd>d^J49U]30]l;MKN4U41AUahhb>[7TP];K^annkH>_o
OqJR1]9[4OX15K6VcioX>Q8G76G92QnkloW>VYGM48@N0ge^A;@XkXqRSbPEcEPm
I45AS@=5N1R?PMCbR1O:=4anXalWf:l<W=@TYjfb>VcOZ[9L]lGeI9GqS`mfog6V
8m@m?Un@H=9diEcDhP_2W_>cq73LCVCcbZTQMF?J5^>5d450N;:0BA@]nlRXjl[V
M__2:GAmU5?J^mE^]R9Mq=b@1X8m1amYGkhL10a>8L46oEF6JR\`3?Qf248:_J\;
1eJK]6PHAIdNMia:acOl<d2eG6[d6:eB\j68h0lqIDfm@4=G:kNDWHB7bBMkKegW
G34j08?Hm^SomLE>fm^5Rg7=6cH8=FU5A3N7d;T`QUIM2lkY7TjBVMBogjMb\a0X
k]?b@ld6<5RL\4=LL^?GG44pAH7Ucl:2gVL91UT?jb<MiLg^:kNb;R3WN;g^_Aa<
?Le_GJ:RQCCeAAUjdi]_`E?6p4`To1odTPG5]OZf]e5i^ZZ;qK12lVTlOJ>0PQCQ
<j8;4c@8oo@CV4?ei?30:73n@8WpgE=<d:8M^ZjG[L?c>l2W03i@dSJ6\7NnLgK;
fQWdTUSki9]G:\]UhNB?hCa87l7>Fj_EZEQ<0^lKKA_>VWVnja>Q5i]HO]IPhOB:
6=pniRdKJnL5XVo?]5FK_Omj^H@aP4<n_UFD0M0W_gB?WPoSB1l7T27JlkcMiGRY
laKdnO_d6A[YOp=\^`?5UD;535h[:q@K5Y5dOfE3bZ?:bFM@MHQRlgL9KR4j@@8V
AYFZplP>_[Qk`7H?3^R[bJmjYMZLX9d;d7lgT4\NfG6;qHeGa91LU8mRoQ;>TE_n
mcop0NmC\Mee<MIEfY4R4Q`16bWp2DFjN4J@U7TRNoeSIY`W4Sb80Z`Xqo`MBVdZ
R66H1==]NjJ@8]T:fVC9QHB6lUh[<0K\4ZTP@?`PUWf9?1Jqnofaf03G;?e7EJjW
NKnCmHnl>`G:h0`PUkqcVS[7<VGHgYB1dYCVIp`cK0hcGZAgX;gcnfa>;qbEYU>Z
XhdnLo>RfG8oUmVaad6_de^jN]hdgqJ]cI>jNIABNnG>Gk>@@Rm4Ej]\6[D:>2JT
kR?^Mo]=eNaK>WGgOG]=`OcPdbdMP=bY[\gm@aVE5Q4Eq_MR4[Kcl`<EimUPfRiV
[O^K0X<:N`[\FHFAnU9Q::jkX3_>k07ifhkM6LaO82T>U_n^B[a$
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
iO]01SQV5DT^<0_XmQSmL>KeS0:0E?UXd=JHIdP5_NJp`XTk1col_[Z^Ge9WdeXW
p^<hnEDD0<<k>emE7gN]_c2ZCakU\M7\?HnQKF\3U<:=7gPb=YEQmD6l2C;dkDY^
jihBC1=q=@JJXjp4R1OD1Ab4ClKMGf339^O4@8qZ<0R]Z[aTf<;CO?=`CaPN@MPL
[6T=N6TbXh9MDg5HiTlXFWp7AKhd69XcfHhFcC`>aC<BlYmYcF2FCZ:nE::4nq`R
9JLWp`BA0DFmdoRXG=SAMRIg6_bS93igqgk:I@B___1P>a3>p<]e1kCLLl10@beI
m3Wa=k=7m0IBHINb<_^0GVcqIPDP7QG\MkA\?4SWqNH?YNM?MDZ=CoFHgh[Df[G1
AGJH[MMdSeYi5l?<D_lZ2J?l9gBP;2_[S\?Qj@_CpGffZ522q]c<`ljVo\0NACUf
7We=AJJYTXDE\N5VUL:Vm1jfL[3if1V<MSK6CFPbWN\:5:V<pNG3GZJp46\<3AK^
;e=ZNo0U[TlTm2^>k;^h0KbqCS:PY:WAH]lBaZW3d72;3lNdll8ejWVmGL2@8M49
>5UHkgb:Y9J?PL2b7d5UJIcCXaU:>6p_bQcY9mhJ7X:N6>@IHY]2XM]c5edP:LmB
mMO:;Ip\l6PBFn];ZCB?QV0k;3fP@jHkFGeY]SOqb442dhp66X14aXPF\A`XHhQa
alg?JaYN2047X`QN3`1KBDZg0K8MgpAcSha]@j`ab@?d[<G8oF;NCSqVh]dO?>[G
aC\^I0iN1?eBg]ZDU1XeC`IVTekZR9DRIf5X302XjA\7SpZ00UEdAmGoSSNlkjDB
bTCUGCWFX??gGPGS3pGn_3>Dp3^lFTfEp]XE5R\hm[eBE2PSE3mh4BcKIDO1Yd[2
Z\aJbnYaVWOKi@n7LJ:mJRApS>MSo9Y=6O0Tb2`jFmc9_Tph][9>dIWG7E<G`VnT
_h9N`86biZW93hp7HL9<WHJ8kK]Q?_?6cZ83>[p\>J9]]]CZV]^eI1TMOV7[BTq^
U[4<I]m6_2h1d=bPY=6<GfqKbi_HB;ciEc2LM7jQ5>5OBp:Q]eRkm<;634gAV_f2
Fh2^q6L9K[fk<SNmVE1LXVcgX<opI9`iD3F?N]>g0CZB\a3B;A6nj^bq3`C4U^o`
:OoYoe;mX5NC0gNeXYeqJPk7GmSlBMPL9OaB^R99GUh_8bibpM_XAo_:C[`K1[d1
Ib`cA2I4KRHfQ6C9FaQ;Vb[V05k<lf?FJ`>\Vldo=PQZY^RC\qORX8h=hCPo0R7]
3iLhf]C7lQ:=3Kq6_^^;fW[6A1g2KX1FRHMgO_iLI7pbZ3?e1^]1;S__SNVD@mR@
>7M:H5;EK[pPUPcdEELCfo?>GCN42TdkTk91c=`]Ag>q89c?J3c5g_O;5RfHI]\G
g0;?bAa[qLC7o1hAf7o0<2T;YEXo=jdXKjV_`g;\0ECY^WcQTQ7Nl;_JEUGc9@XM
aLhqSnINB0LHCgWc@hR6i>ZalLD0o7NCM4]Q2eq2WJcY4pPfkmH@;JifkoW[`D2f
J4c9gIXoD]a<Y5d<R?Vj37]_ecqJ]Ifj9qTEi;7WpgFXkDjqA<b9KMCf=G6cdelW
i?=8G=1b`1LEQK;qmLU0fT>BEOMU][VUJ>__R=l`9i1S4HGql4[IlAL[EcCOC1Gn
S3AgV`nAa5aOS6q\KMbI6jL8REQFb`CBW4]>NRSVQ0^;Qpk[AJWFT3YnMkP_NEaj
9pe=emh<CCD\@PY=g7HRp63fOeDpcF99Z=p^1Cf`Mp:1Kidkq2>4M_A\_nbMH]me
O8B\B;>gk8@cWFL6q160nYMXXX@Qc_AmSo_<CZgHm>nld8E=h:L;27d=2cV<XLE^
M^20LSa05o@g]gbBm2c@aLBV_pUVbK_f2j0n]6j1ZJ@?CnLc5DWH[7Z;cq\8K\c4
;MVe^P``ekI`cUl8MNHBSTcOq`_Sj]fA;UTo`>:INAe0oZ`KHXHbLkbpZ5BNK7hh
p?DmZ<KHj@JFc?TCXk]h8Q2f^V:oF]D7iGXj=52C3HSWn0onT1cA8\:Rp559]G9Q
pGQN`YJqe<P]I^OqeA\fZMELOjF]cY<`OmTX[jh>8>IC@M_qG5=]Vd:6O_O@TIEm
=_oWlXML94G7_Q=qhFP<T>_3hAh;Kd@KKRiTWb0Zi92JMCpM=VlK7FJJCYb3]Vll
]?\_AF2AYZ67Dq4jeAfi=p2igd:PDW>08JjJe33DB?O]USb?M_YaZi[a3jakdQ:G
T<<PIC57>fL_<HpgRb1Z]pZk?AZU7q5TAZLQ3<XGVVh;CC90EX^@W8q?\:in5AL_
\9k7GO;n<kS^B?hDVXY`VqG7^3g@h5RSAGLN39<jeP]E6n`2aT>gQ>USq\oG<lMo
mUAX6jNNShm6H=``2V>mbkMZZqL`Vd1`BNnifXI>0\G7aZ[Y\TiUR\DKLhdUDUhY
Aj08;[qEQU[<mLNS?`kH=LY?_iXiN:Rg7=6HD3K\hdE7:[pAmab]LXU2VCg`WF^N
[=lDS8ZF^W[69I=\`n\3lSOpDB4\LUS<VUBEOP=j53_:1cMdJ]NNHKNkH78Lp_=;
cgiiJgLH>il3Gle`XGf4jeE<IKb41Z?5<8MUJ7Dm9M`c^k0RS;D2k=h<pgQCj_UX
RML0Ic2>:G96B[2e;1L@:KJAFJ]:Ipn:K]OWHT<_<MF?M\dm@PClJjLj[I==6kfo
JQq3:5BhI:Sg;=nAHQ5qfLLE[7LEGai1OLI3ffe6eD4Dm1Y\QY<Vo9ipA<:k`heN
bBUZKE>Chg?l2_5m;UUFZiDGT^3p??0[cQ5J426FgS>AW2eZkF^_:4^T_\d_\Lpb
UODCARpA59H\A9`:iYZk8HhB`q1:Wk<lRjg[JB0bE;n:R47\hd6TW;OeqU^O\0OZ
?Z:JX?@i5=YjB0\I@6V]g3HJqSDB2nf<5achWgXQ99i:b>`A533g[SYHpj2;O7Z:
qGgeGT7;A1R=4d4<[JKj@n>En`:\UN05X<_ZVVdVoqV_A=g4o\OPmTX4qegSfc:[
mB6SOI4WILe1=91^mY804^6W[^TJq;Qlga5flCGIF9MVNPSKVCWEhmJKU?M2NKcX
`p9]@Qm1MYBLPHD<c>A]PQ\WQgEc8`46>=qh0Y;FSM9BW4i`P:PGhoPHCS>qX\Fg
jZBpJ1LX;0dUPHmRSH>HC:_kC2BBcCUaQ0UCaa>qoB6NGkCp37N_U^n@F0EcaZIR
F]jQlU]>0]2d`KC9O7B7aW2mC1=2R`WQnCk`CHA1L\DP3[]4oF`[^^\_abEia7cI
H6PEa=mhqM5?icg1g35H\e3ZIGNK>mbpC\c\YNoJ;<9fBf26K>lh;W[J;RUAqfJo
Kn[6JZoF1E>JWJgpkT7jgN=@fODfH=FNecaMIJH::9_<W03^bjY[i`:j8\JYA`>L
:<jS7N_h`>X3pd?M_?DM==4JaElVeEYTC;9UgPLH>RAH]3eTpRgBAnJ\X]IkI0NW
`YF2[A\>OIU<2_C@j1>5XAeog`_N?g1G[R2gDQ:LTb<Cf<75glK6ei7qkGXJoE2p
7cOi7?1_;Jga2U;ncb96=4Xf53SXBXVnHP@Z:YY[qiD3BCYdj\i?jdF]IiO[^bdp
n5c?J?fp?`SZ[Z2=DbA798DPdK2DB1C40S:c7N9i4aFR`[_]:m]^YaH=HF4Z:Fn?
<_nFd^pA?M]6AjpVlm=P2YXmhML9j^D[U2Uc@k7^aVUT:h?If4mo>`idZGIXhS]J
:nnSonenFikS3AAPGC7VV7l]hK59UG2Kb`AGIV5ome_EGOP[Qql\4henApS8QN]A
OBBbHCHd>JKS\dpL5N29V\7PnCWbAK<TmiW95BL5e8nHI7i>;P`5G?aZP2QU>4bh
]7e<=nL[blXG1a[id]cXgAFJO7bIRDPp36SjKL6qJ3UEmcHdKYPK9ZjeqBf1d[EP
E2E:qelC:C:bq7H3YW]H?en;fchdZOTofVLCSdGflKLO?f9[CbK>phMYDH\3;Yfm
g^>TML7Q?bInh1fWf`0d$
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
Ki9ILSQH5DT^<]OH\P5K?[SIBaMn=RgpMnn0X@33<[4oB1;bd94WL67GkgCRDZW6
qSFQKn0gH\D5272>ISjfWWYJTEKH4q_J19dkqPYc;JlYZGF3ZD7BXXk<Xm5kHlH0
Y;BLYJN6@i[1SJa`7i:C<EU[Y@T^nJ<pMShOIafDYj^8WN@N@5Mgf_hll_M1Abl2
GkdHR9mfL>5VggfijZQU`7??^`bVc;Shm`TlgJMnJ70pBg=K78oH7I1TX@V@E8K:
8mp\X?:XnYAD2]eG2Y5;TmFJQ<L:\R:f292\59_1@M=aa7MRggWk1X=gYTpTOW`d
9L]81;cAZVDMj8AGaUPJh8h4CWeeC]6f3niZU[`kn[GmNS5><k8=^HZLY88XPK^6
I?W;:d:bd\[OLZq3I<`H`EC2h_;momAkZ[cYAKnp:oB]^6cpi4J0bJg^;_e4Q40>
Ch7aZ>13>c0mpV>;26ZU7]WU?2O>S>J:O?NEX=0I?i5KlG9qXO3?Xjoq3@WG4YNf
O[:jL=e:l;=l]IO<T??h5m^^^7M>\lC>YgLhlSYa9Z65g\\eR1Q4]4qc0CoSO3mG
3_\BY\jmNiCW4H=ZMCAHc_^KQ8akfj@4NTlM8:ghOf6Q?J9pcmU=24A;08?B\]9F
>RO1\h<@ka@?=k8SeiXlcGYLe;d5e46=dgAbVN`TB1C_09mgl?2\oDeD<_1IEX4S
QBEGp3>>j@6hpNYWRkN@[G1gIL6?ROk96U=he8`e3hbFp8K?Pn7j6e:7fXOSB[Vd
Z0`oHOh3j_I0C3eO]b^2kI6_5@=RUdb<d\Y1bpl?MHQf[oAgTA;=5W@AndGOd\V]
ibpF@OX;\nkh4eDZCX6K2=g@SR0k]9H3`CY=M6H<@<cBe]O]fg2hEDglT3E01^;B
583cn4nTf]KgVLL0JkLUH5OqYT7B00PqjLI6]DYVehXV@B^^8`<cQ:0hcmcRVieq
6iEmh`p>j<chC=jJFA=i`mab\L7oBA;UM4Sj>\Y:mWT[=@aISN?m_CQPWPiVKfp:
EJlLJ03[H\OnISl:MjNRONdRbTCU;CGNF1nF`J_1[^=6F=Bb1Log;NGX2<_QRI8A
F;U0_Ck=<iU@5<\WD:p6o7bH7@p:1Jc5\TV\W^JnNnZ]Rjg`7LBAQFCpC;g>cmff
XRFJXmnGdl>59UOKAMZkXTfmW<V1KIKme72q_fgDBGHp:JmSNQ9i7Kg8:^>SH_cW
6TfAG2<Ojoohl0^L4MTIbLO\NMdnDCG3gc;D[\4?pGeO0GC6hm[PYK7>2H=EG0RR
h9GLbPe@70aaE[Q44B0oSMV]Db3i3h_bJ``c383276bLA@nW?8md9H>qg6?oP]:]
KkHV0E_EOWb6XlDU7bRU\5de;Uea1hJdLk1HLZLU@eEP[_bDH^GJcCCig[k@YXae
NOl:Kf[4U=5iA_MF9fdoY=qJfNIRSGZMTpVnc@6FSKnDdYM\8EAKdk?nb3FU1hMm
@H_J=8p^m4Q;U]3L=XW<a2aGdRcMmGGm^n=KCJ\af6W@a6qH4G[JOCWZSA7J8HEi
f_Cib\ha38IOC7BO0V5pXnZ=gg1pFf8Y9o;@BJk7cSQOPd_0]QTdNn4R4@6LWVE8
K0p3n4o1\iqGbEa2mDpled;VfiAN^T2UaUj]JTKQ0Lf]f2\_W\Npa6_Q`6eqdNRJ
o`@[nLM5OZV3C3B?N@1q4cb?g[X1dEIhC>jFRQMfLh:iR1mfp8_gXo[2?:91L[mU
>@\_K>XqMP@hC\V38Rb<^L_oR8`KpZm6@B?RWdX=UTj@_SPASl5DXcW;SlD3QeWp
oCG>Zd?jh8dW[3bHpWhF7j=jInU3dnc9@fGMG?ZIZ`mQnZcP5cOpQ2=MgX;Mbk\Z
IfdTf1mU>dAD[@Apc]RmJl6KVNHOabab6G7[bm?mc_[fU[k1=aq[8KG^X]pWj[WP
X867BlQ^gkEF9YVplT1HEJHoYY8`kIDgL2XhCRj\gaa6DO2Z11ZQWL`Sg4ZlTk>;
0N:ROn[gGLg5<=D_S^J9mT4^XgFbCcDb_h6G`D4mqiaja[7_A`FA\BD95I4Y:;;G
792qTPGL3Qn;fGYCMX>pG@19PH_qQg;RVXf:A0^2nLY>S4^GY?44N1?o4>66he@Y
0ab59Q@_fWajfC0Z_9XlpaLY4cNll<?mCGIB4]24MKJgD2eahKQl9Pc>9]]oS2]:
KWG>@g>>?WZD>GMN01;52iMhS<=0732IUH0YTdd?@W\Pgqi2cbX7LmG`do2L8fVT
qi@bLj<h\b9P0j;nQ2_3hEdRdnWqF@QmZbDMOoV94mke6c2k8j]2goZgdGf5meTH
>3>>Y9_A2lH\W0S5^6MGB[nK5Rpe\gfmho5eaZN8gWZ?aW;_5m^eKV_^BEF]VGjB
@BlaV<H2ACfj`[a\Xbb571CZF[]e=mG4XVnp4afC3SIp3FO;MVNJA9^c8eR\H4d3
oJL_MH7Ai:D@4QCgPYO\E8b\L\H>i>k@J8fcnB:fH>CgeKIfHlO1^Y^3ZWEn3QUB
lO^HOhIbWdf8KBd<83E<:1q9f7_OVSlLco01@RI\<k?[=I^T]a_>EA@De\QG@B_i
XI@Y`RO31_H`OaflH<[]HFp2^O?Bggb^8QZZeZBiA8ZLL1gC3q<ZfQoePp7A[PA5
1=aDTVb6qo?<OGUj>7ngXUHIbE`1UKAKWXgQdeLqCEd7RJcXGG7kF5i=dn5^:ABa
BmCb[]bHbUI<O\hmqX@N2o\o0QNWCRLWOnoaOFIm0C1kBAQ86aELQ>gd6Fb4LMPf
9][ihJQ6c5a^A;G>FI:ZKhW3ileI9cS?[nGUI0a48c1XM1EUTMa2::Od::Wj]2kp
mjB0P`XKBC\OmeGMcY;kj5h12VqB;oXa0]qJ<9>EcQkl`UbBCgiZ=b3VAjiAjc8b
8nq?bbBTFGMK5]c8^OoH1h@D]k?lOB?G;a:nJVHKaJq=Q7cfk90LJ@7cXIQLn2Wo
<G5PI15Q0H@L@Qd0D:X0F:UIeg:QL5X\XBHl0NNDe0GAh7BO9DGMBqJ7g_4j?eA:
bXhHDVgh<WS_AQnXl;pR3aLYencIaVdKM6bAd^6D7gp5Ii^dlX2hT0_GGPg4:]pG
DKgjj6Rc38b?0QPgYnUTCh`4;P3oha<=jIp1fd<_K6Nmg27XoW1jiGEd^GX4P4;:
QMfX>FGfGS?FVf>`bZ;:lYq5C;<mfAi<@]YNY_cFFfh0n1WgJ6lQ1Y[pGA`Cj[lC
pgjRm8^nMZl^71>RoS[=q0aTHa]F3NV\`UaVYKCkE3o@l>1k>V8_iW_j2[1oBJ8p
0A82i^VWjjd8gTDH]0]L=5GgmE]N@5:iFbg^F;lT7CqgSn\dPGMnCilN1GZQ7a2M
OhPBWLelif3\Z9HqhVRk>PWV0QXejNamToW:]Z6BlT2eOihb3k_LR9]g_=lcPdkh
ENKp`NOO@\A6q2QYGB3hbqCh=P5lomYKMPgTA1ReQAK9<m6QWS45UY21J9gLP4]N
TjZ?P70=i@I`;?SGiodC>0>>L?qF:i5:=1`CInKNIkO46mSjARkoXA48^MGqZZO^
36dAVG5jUlQ;aX@OZ7q[:g^LmXqGUad78ki75Mi\M7DCUND;Hj5lP2^?]5j>^QZM
Tl^26G5[6THK<7Q`@6Be`XKoWkjVK3VUTDH8S<SbMAgTTEk;W6EX\=QeYTJ:[e;X
_J:X>;D77\dU[W9CGF`G3a[gnpTfRMRZYq^e^GgocKRme5;;aMAb^CYQHHA:]6BT
>f7Eja0F9CNCn>2<IAIadqc9@l9kNWc?j=^VVDMe5XXT[n5[\LZFLc]fUohZocaW
dVPVjH<04FUfX=Pn69J`>4cF<;C_8q_=Ogll=ho:2ge5=NQe8[Clbh1IkMZceh`0
jLNEH^_P3dEEFO0dC<nkBK?8h@62G;VVeXeDG^OU5\b=JG3@p<j@?gb]eb1\KFK;
I3_A@J1QLO>R;lCeB;JMDA5_R_cR4E>D8`DkYo<p>RVMC8<`n3c0868M7n116<_7
pS;0lHXRpkifEU<B0<;DC?3>K46LiSeSakKDn1hg[M?MoO>[I^aI=6`T02\dgQG_
]B5aeZC<Z_C?oHBXCh5O<Q_T>4f8n7<EFVna016gVioW\9PEkCOIMHcaV48^`j?Q
ce5_:N55fAk>qn35P3d`N1f^W]\2V\:gPPjCMj8I]HT;h_JkW`HTjNd;9?gG;:MX
EJCXO^FK`EjW@c=R0<Xnq]I=NF[>qe59TlmBNg?AaikOK1_n13X^A2HJmYH2Y>mZ
5IkemZ2pb8>i@WcE9Q3ZG1Z3B43\_^;WoJQT3nm[9GmfD`aiWKJ`Ie=W6<?Nj0QN
5SRFYN3><m>DIgdEBCq4Qi4\@K`D3F^dDca1LQ0C3gk?B@OS12`OSejpMB1DR_c8
U1\aR]IRB4W12<Z9oHI2FYlapkOc<0`a=ELUKVL@^`J=plJE9DB1qJPDDB3f@Kc@
h9g__hDTe8CPdAgIbb5g>GoNoi:WCLj7U1kPFnf4:]ZY?<Q<<`=aWP\LGc[@LVIe
nA^hQbEGipBH:YV1IYglGe@eA3EO]>>I;=KY8j@apN3aVmJ@=`k67d`KcC4=\]L9
hph^41SaMq6\5D@Lb@R;oI^HjjAR[BaeGc6eNBiGJ@m0Gc]]b06QKT=5ifAoGOfk
H^Ii2RbY>nMEBYaOf4`Yn2dkl6`K?l1H5N66`T5kJKiZ@XXgakB3lib5if=9OI8>
h64Y]DqeC0Y2\DpS@PJ[hLpdMfK5Qq[ah]G;`qE;1]TQhYjD@2=KdpX[0ibm<YjG
lFHG[_PCP[m8J6BQU<pNWHd?95A3hIeOmVSlcbf4Zok:3>GZSk]poTe14:HqI9[i
`^HVA8Tfm3oNl8jcb\HT?Zf58X?kZ0<Eem>d=B35QZ@RXGYdJ3lRZ=p^RHc0G1VG
N1OGnYcq]cKVWDGqIC3MHW`QUFgd9l4REhc39;eWPkZ7pO73G^W@@:aj\:9lJYC_
qLEai5SHQ02Y\3M3JleW3:1K_^GdaS:bQOo:0QSRDYn5ASQ1:lU00DfiXWf2RE@1
qf?4M;SkGI<O:gXOa=5K[JKJhVRF9ILO=\\?qVj0PR`O@;L:\^^<mJ@AJ\gB1=VK
_Wl1b:U:f5YQSibFl57O;`28pTFi=g[mdqGifb9KW[dWYZXkUA003pJX8X2i?o`Q
QX9YQS;W^:6N30i]WKF><G@><oP<BOTiqNYnC8EL=5IWEJ4A?Si7j6`_n3Rf4c3o
g=baI5[M==9iGAAWq\SBIZ=mPkdWg]3Z0no?HTOEC[5EfW6O:jGhPWVbhSIq]`bf
i7Zn9Z_T]AVE05=i^ZK;ck]d0kEdh66]=1Dh9hnfPEL]:Top?CWdfA5cq>4^^L]\
hqieO^C3>NDUNYUc9po=G9<5bJm;B:Tejq0SBaB=Uea:nW7gO50<@CNbNB8]Ja^X
8@R7<Ad=0]6c`NU]pCA`G_L_[q3<YHGG:BXDXM2hJkjP:cUAqZX0]D\[q_<@`7?L
]Q^NJPZ43XT\ckaoFG5j5LYA7;d`o7c^qb=LNi2S\gLY:TL4Gp8c]AgWga:_UAPn
HE`PpE=<^86fpb;MddEmhmGAJVUT7fnPR3mocf46XJ0W9>Meqn9@82RKVECn=e[3
7KkN_HE<OQhSYR<>70UCD77QX4MTpKWdAejU9g<LFa<oC_7aYGeI@p_G5eS2Lqjm
\XT\\CV2@Yi?gVpfS8Kf6bqdR;CZcAK@HJeY5dH2J?<?Lkejd[D;BHL[1q9m?0j1
:UFEAbARn`6lBqh0X=QS7POh>B4m7jEdU2Nh7[4bT_4Vi8p]Dc?6SIpZK\<IC?mK
URcY2;oHYTq3j=SSEKOLHn42@PZ7MmqM7>X6_5Gm0Ifc^Y:ROObdg6__;qnel1M^
KpfdCh_20p9jaA4<U1fPEBKYRCLYkhfj1CNg3R3QT0jnYFgkFkk2:NEAThKeG@\8
G^TAaY[=2e^I1L6Q:2VKg:iWABoNJ_gGk`V\b4X4T9Kc;@\egNOj2qP]_IeQ?p;J
5546qnd[MGcXSfT`qNK[B_NE19Z2IfXNZd98gWo3nDk1hm_Z@RPRXg7bCLL`Q8@h
_RO`V=SM7AkhCLMHaX?ck<E<YdXhmBPD4`9;n6><QWD=PPHAL>gI7?c_oLG8II2W
q?]B^6JOa0\YecK882308P^T?bm1[18MnH;gVkl:I8@0^pD_^T=?2pJ<BhSUXpN@
WUbda=FS4TPdiMo[Bk47kfKYqlQVU3k8H05BAZP`jJ\P9TZQQR1<<IeqjiEb9:bq
_Y4<@25qgm2:lk171Ym\X`nA2\3_i;E0@oZBO@a3pPM9ZC?k52iHZIk;:]A\7HTc
RYmJm;[4ck`XT4faX51^AhaMJEYJ6J`_Aqi6MOW<O5Gj@V:EZIY^iFEJW;oeO1gJ
j`C3Z>STPNK@V<[g^Z\1;KGl8cD;Ahpi8\gciI>\a[LbkmLpM_MOQ`Qq`[J6>\O>
Y1m70FfUKXMVjCAVLZ`EA7hC6Xq<aQh2adikm70fE:Z1[1FJPHqf@Rf5TZYlf`@L
Z7<Vj[qEQ5AeKdh;HMKhl:BD9keVV=A4KL]XX4XpHi]U3dYqHOXI<FbQ9Kn2;aTm
_l=qkLIZ_b7\Ib=^`NJH5NReQaS=6lq=6E\6aCqBjC=:>gqdYoU]c3=\N6Yjj5nc
XS\WCWL]oP6>lMb2e_MM9mcHRml5:0H?H[TTj:[aW<^<Vf9pJ>59bimkdkg5^8GJ
D<935[KeYC2RSXO86n_\g_9UknFB[]RU_:MCG?H<jPO[R2CHg>YT[IEH>XN8oIW:
IbjhKJ]PhUfU9TO1c6>`HU=RYh5p_]]Z[aVqR>4kDEcLK4G[n6eepOfO8GB:q9T@
_QhTXO7HidhQF]LTcRRQG]7iY`kCE4Kqk:[U<\Dq5SVI_NQ6]jk1V^bOe94f;n[a
F[IQC9=P5?_\g?<0n@AqG0PfQh;DP6XD`KL`fLS@f_k9lVTI0Y\7S;:Xp[7Tce3m
1:aW:lo2PDb9OnJ<Dm23g1A;po\;GgNiJ]LA;o1dcgcjLjB=HclK]N3D_L?e7I>9
5q@JR2Rdl>TkbG2L:i\dT]UeCA2n?U>S\@SI29[3j^]BJPIBOk=HgbC9HfGDbmP5
if@c9n\SL=8L`KEM740Djn_Mc?J1c4DJZc^\iG9PCd:KfQOi@4^npd8;YbX?q_KQ
PXjHPD4]@mdl12Mp[RA=68<p3^PGo^RH6Y\dYIlMJ4dDFRX2WZ:Zil>[J8p01E^6
CJ1HA9R:lqSf;`kSW:o7[;06aEBRICGiN0LZ5la=7IY4X6kU83nC>kCEFf7cLX[W
O?ZaS]Y?f@k\hCI>Q=a<Y`R0>omA>[?KDYN4bfN=7P;=8`amIn^7qeSJi@jGHFUM
\2LPHD^Ydg@jPDjYoW^aHpKGeMW43YRJj2P_Pkkc>^m?>28Q2PSHbC[HI2hgaLNl
nWeYOlZRb2KA?R6i_A8^BTl[=Bc0cR[?]9@gZeC0maEKJj0iGDnAW@R^Jn`mNlJI
aX\08A[^OHdR2@3g;`\AZL[G[q51LmUm:$
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
T<a4kSQH5DT^<ET:LoVM[Ka<X7iZd^<naCI2iI_:cDDN?jB:P8OhHPSaf<87XV9G
<EdN2AIfGVO^ZJeKpQ[]TlZ:Qf1Q34^dIeUU_[X4CCQ3H42_HmX0k[ha:f75GmQF
Che339?pB;P0iaI:jg^o?cEbAVRQLJ@UI:JM;SRWA^q7]0;?>qc4GJa^LP\;73Q?
ESGYZZ9fFIi]G@d\j3GU\khO\lQA\3pEn`aD]\pZdEe]Djbhbl`GVTnc;XWgEJHb
\hYBWL4<b>ep4D8<`efqmeKBdoiDAF<egOSJC9g>\1GlF0;MQ`p?gXn\6LM0Z]ID
9>;mS>2aoc\PNFTjU:RNg8C>jXAen5bb^LQ>Y@kgZBe:lWc>L@i11E[:4X58SNo\
5TJpm]AnjANWlNaiFdahjh<OEBbLlo8m=Xbo4iN=GMZ4_Y>\q?ghSkHE^cSAKMXS
ZGWQ1@8B07h9Aa@bpcPEk>BmM\akK`;c41UcjW\lX>U@Qg^o`>2ckaPPd@>p<Had
1F`pk]HcDbbpfck6@[L[@SKg2\8?UNSmP0Z?1K]XJ5V2qgl^XLVVlmFfXJ0V3_cO
KA\VDSb>ph4DQBP:ed=cE<[<hkdICL9g]E>UCHj^k^bV;:=LjA`NOCH06j2Ca3:p
;eNlBAQJ;`8Z3aVb2OUcWXPP^GPkcidqJ7e73n2p];k2lgGf;PGE6Z2MHVmNYYYS
KQL=_E7E^8h3GAp@3cOTnmp51eQP1:WA;KW5a9`DTEPh;38lI9BPDp_MOioU47eV
1lPH9`\oU`YR6Xa^<ZWe==NUBgI<k;EAS=b>lH8W<cjIk4QH;g:NbH_1eL9lnJc2
IU;oi:pL<Ybi\`l8DR5NYC>0ocT9Dni:Mf4eQ_X0Qlc^BR`dTjqYj9d`WUV8AW:<
UfcNWG37DG:I215pie?HWS`9@7;8UbbBkQO8WClTd?Y]:nJEWKKG?GM4;eaS@6pE
iG]_7E^Y4VAVGlKEPg;Om:58kK=4^9\qkbIZ:^hqb9gbN6X<KmpOiITT3G:Kb2GJ
\hDR[mY5l^gkh1YJ39@HEBCobSYbBgBp98W\BlU@@K2WYehd\SdRCfd`Wl`Q6[V\
766S3Vmj:kB8n^EC[kHOO[fPOWmf8iD<lE`pbQDcG@<FnQid<MSPHE65I0cFB1C<
39IpEJRcU3jqa^K0W:aqZJ5eU=`p=4mNhPRf;IEKbEbnpmPckVa1L_6<?:2o\Dm9
UfUH3aZ5;CZJCjmqm<mS?1@3N9b5<<4ORG_]B6\CW`pP:7BID=qK\mjbdSHnFJ1H
8[0X<h\2LU\fh8JV>RDRa_paX3^_9]NP:;l4?9d`?GWZB1j<<S:lGah44<ND6::\
J8]UP:k`:oUiLjqjklEI\:G_5j_gB?B\c;P1@S2>lGHFI\fA>bA=6<A3X=?;E_=S
4W@;JdFY5HgTg`=U]RH5dB4_2@4Z1B7^k]q[HGi>AoqJ>JD5<2D2:2VESHRi5HE<
eO1dlWX20c8ennU7a2W2jlgcNH7^iBXlVWcIAi3XLSgo82q]<1kV^E5\KVkIRg:?
FaQZ9lef@7mnH2VJH=O_KkmIRS6Ige?C7jIJK7o@i6g?ffPe7oSp8Qk2mUYblJoU
k9Q:R4aA[6Uf=QpCb`GhkfSJJH:j>3joANZmE^M@=GIJf7>NcE59dcQObqY?I7Mg
]ME][WEEoWmjHain6WYKC6?__n>iChg`fOOlqM2BcO6pSBeCc<GQLJJEDBXIRSJ@
iZjp5kY_MX`35gN`G?YV;HZOLIS?FnaQn\:YV4pRO?h:g:U]1LL?JTKe:LV=\`FS
<=>3HX`;Gl1MNTF2C5_q?nIY1\Tq]`0U\DkpOZk`n]8aECU3jBUh4STS:Ai:HQeH
NcfNY0n9e4nQWeAbTcH[]0X3:N0SfCScdZHVPgk?cRAX^_Hg7OE=\IO3\4YY@EZR
A<fI[3h3HAO3URWUqYL9PhJOnW?6;6b24AT2G90iL8>m2KQgq?V]a6kq]QkfO]Mq
kGE^EOUgJS\dF\2oqDmTPiWI=KMIJao^@p_Rh8aN_<WbY:Q4qF^NTQ_PWk4<<9K\
EA\UT`?HLa[doS^3p<^Kn?^]>G2bf4ag0Zi2bSOlWMaNp<JiOJIFRXA@6kBF<g[d
W;Z:0P\ZYed?QqO==MiDoq[D5LCZBpSdQ4PDSNcQ;9>_5NX_PW=E4]g>RPcLNTCM
1H^RPU0c9fpiA\TB?2qLeFc^UiKgkmI7B>ia^jf`6[gE00lgYc`W005q1>g1na=X
UG`cj?CF0Uo5CGLWa7mV:1]90jGT_n3l<`b`U_hPgYk7BLYM^YFHH>p0o;8496pc
3GBQhD2YM1D=6Ca36J3\mh;lbA`X;J6qSL_945TZ`6QjEZ2j:7Lj5\mKWXG[XAO[
?LT]WIBhhDJ82@0Fj1o4\d\R7W608nB=>]V:[:`gn6hkJei:qfjOi_\XqcE\N1nm
SSQSZa;^<C=hGChMAqY=I;CSJqSb^ePLj<G?=LO1O\a5@^3<Hh47AQUCdN`?fmGF
jp4CGU`CepLF9jlQOYGdWQ5NnNgdA8dC]BMb`4L8hb5X0mVOeK77=CUVem8:aJnY
IFBC[Sf?p?hSYm8pPP8W?0NNgH2Ue_A3S019g20]97fWP4L1ITc7^F3;\CTPnXRI
5fCQUT:]TK;d;A@1H4ZIa>g?WLl^LIf5pFFBc2L;p7iWJ3[PO?fHHZc:FI8bmDL9
9fE?1SB[D6:hlPhORWTp=cNd3:LIJ`oV\1@]>BnmfhNXjCq?XNRIG_]Hl5VToRa[
1hI9hXO?O\?8]M:138hUoZ]0aKX^BebqVf2BZWTlpCd6Z29H<k10`9`A8ZcVF>_D
:10LYRN<KWVpC3V1VaoUq`1Cm<P16[?a[S\n5^laHAT[79bq^6GSma0q<i8gd]Mi
?9cX<YYDnJ?DVQ\CW=Zf<[gC6h2=l?[[DVoSH^XM4<nNAFcNgQBm_i4=`@DUZT<p
3nXXGji2flA=V>c=\^Kakl1R=2WPjBK]5<2D2:2Vk=7<ReDZ3>_d4=CoX[m7f>f_
5C=qB[We<^dqWdPcBNEZBC<;=>]kqJR8BEX[$
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
ZPS?4SQd5DT^<Z[hO>O286Vj[0e?=Q5ZGBUCY;WAD9?f2N^BjnMQZoiPR`5GC\AF
H6^Iq25O[H[:EOBOl69;L7l5Qbl;Co<3ISRJm@TiiY3M=VAT4k;N;YaPOFab^D<O
UaZh^plD66?AD3GWCGa88o7G>g]LbIF>=FFdJl=Vb2hc5:I`@e\`=DkVSAfnaB]5
iGAla31mlmhmcXq]^LVV8q`3J]ZdDVUBZVL>^oOk8p=IGeJ4VLRBGmCITo81qGO4
n>[PnogB?H5Km4OWdgC:cpI^FWmW:m?Dm`3k8:B8oebCq\PighM7d`M8QY<WF1`5
9?^mNpSin]XJ`p2<ORdF=e4A:qP:mcYKfpRN2]FKOFL]HXWmD>RWbHeBE:<dNFQD
hKBDZ15N0pZdWGYaXqZB065SQqj=WCT3ZpUj_Lf>\03Ha>D]^\E\4p^ZjmbQ2OGC
6ie=OC;kc\qTe5Y3LR`DEoZQQ[NMYFie[7CZlhc0ildjh\ob3MLVLf<8_m<I?lAo
_pTi>E6iXmMZ152<_TgQ=nad?Adc==bDV9[N^;X[X]Ah@m]FJ7g34qIW51XYhhg:
qE2nM\Z^jM\\6T`o1eIRR06J78;\^6Q;_b0VT;2cabBFT6XbC7EUF=\`ffXghkTL
bMKTm>ZOkhQcF[@T895<fmWJ?=>^VGCp0iFb65Vq7dP=h;eq8KRX_fZg11W0C2GG
<@bV=XSSFjhT^[F83=>AAYpKV[d?6R<gfVnd1_@OM_2p0ZeE[J^5P<<J\e9bY5hS
RI>bREO;;W>_3eqakkD]BLN7Fff`Y3JBX9_UR37DY`@E_BLTQm1[=p^4`^02cq>i
44n@AM9W`J:;FNj@@aZ]CK_kq1<O_P>6nX5c`8M>3ZXM]T<]G\ghNDJEgMQNQZ7m
]P3b7`aUdaGG46;^K?X[7WUmW4X@X^:mIZ[ZD\7b`\G_3q9J33WI89d;X?A\4Cdf
ZH\>[A<S2GgCYm5cEmo>OkRUmB0:56b=A^;^SSE<gHUflpIh5C8:lq^Lc80Fc;Kh
WkK6D4B1OMg\EL\T7PEg=VS:1R]_lp^ZBRJ6_SJfL8\4N<7M3KY07W66;C=@nqEY
9Y\55p1jADRK8p?mX:EL>m:7p;mUc1J_[B7a^ZX9TUiUkO<8@CHWHSI6RZR:lhM>
ibf`Fd9dPTj7eQTHWZJf:dBI[K:7IGQHn17G0DB;>0md<0E8Idk@KP=q=XkPc=6q
7SdGRL]qJTXkgDF]VYMN:hK^n2FbW3N]n1I0<TPOJC0mJAP34jiLP2_aI4QRK0Op
T<2l8\QqGNF8@La:@7`E9Z:fQEfc_O9q`PG]1Kj9DliQZC>AZh:EQSSkkMBm52H=
7@`HKXd[l@HOo<h=OPZhl\TcX[3hR3T`<mS0?29IolcVZe<beic3X0^JLL7@Woa6
ma^bE?oB3PleP\qlmD`73^qH0_@Nm\X34K;7hg\RPDEKXiaY[d>ofF`[jqfXlm<^
dp9ca?AlVCLSDEIakUKY4h3fBfbiAjlJN[Xi`K`l?Tfb<ITlM8KIAG3n]Xc7ZnSl
mRdYIm\Y11LQ]C[kq=gI2YP<N4_QI67oGJP>fh0o?G]]gcBj[F<J5`iamTiUdO6p
l?j]3ZcqI?JVRIe@A@5dW`KNfEM6dN<K^_ZIOJjQ5OXX`kq@gUog]LqWSiUkUWq5
dT8h=^j]9IOJMEMqfW72`V1p64n\jeM5k0n1mnj=6flEA0F8POXZJ7Po@aSC6]Fg
S6M]@d3OMY_S727_lh\mnofc^XJ;Oc@31RQXd=f?dcXo91q>B[Nf_ZqcejBmhi5=
6[iYj>]lQCZ8OVC6:WV8RoNCZ@qSh[7O]aqcJ_Uh=lp9CgX@Hl]:`lNgeO5]N0:H
lq=hAA_\5BX524WVoB_4HdVoZFo]]mq>P>mFedMQLEbO;e=5K2?PdLPM^^p`k:VW
`ApfKG6XQGb@hOn2G=9JmT^C9aNK5klMYl6_1CqE\gUVNAk`Fe]`kI19OA?=V0MQ
bdZoT<`Jo`3mAHD\TKmPDY[<;93=R_2G2qD2a7`8ZEf7MgjSI^Xl<H3D7h<BnQ]L
\^2=`FeTCZcB4f0f8PQQR:<L0jhA=BBlf_;>DmeB`G2]5qLPfBK0TB_^GFFNk4g6
_lVlfMmBNMVD`]KBARA`:PS^ddVYpkBi3n1DJK^OP84>cV8a;<<34K@bGJNTOpl`
39b@>qn>^hZI^O1CmfQK[3qPc6BH^6p=JZgic;C>ocj?3GP75D>@78PVDMLJVCM0
alpGJLiRAGOK?[m5DlE2o?LINbT^YcXqlH]_mGl_LK5AYo2d3`BWTn>fC6Q^c7<f
@Ngg;9`^<Hd5YAF;:^RDAQYBPKKT6P1hlPRaciTRIhgj35S@oF92Qd5Q^e;N:Vqe
\9>05CmiEVgZCN8B<IL\7fC]@hN?RD6lfmAlIK^3PGA_5bE137\3TRO3XeBdL3LC
Y=kM_[j_PK@4=YCoApAD7@R;]HJEdCIkI<0U^pSR:?2n8BEHbW]FgGf;eL7PVNZ7
eQ7^o6bA0;KTJ1?a[\K<K8Y3Wh]fK@I0dlamNO9BqiGQd=9cj1Um8`B5V<eII]M1
16f\<ISp;;=mahTX0b`S\SKWf>E91T1j3g34YdpFi;djU>\fPNfk33a]RO41YIMf
KhAW_\40J_kOVH0V6qS:d<HLGp[1Ad0\CUd4dj;B`2B7pE:G\HK8pJ2T3jKQMkFJ
lBCS`>N9;U27<kS08=jf2=L>pJl]QS650@\BUHd<=?PlVSc[OBLh?SNi_AQao;L6
n\JDAR8bO5Zl4f90ULgC87[:J9O]G?eg7Laap2W9mVT_KoXWdQ\>T\hamGIj4k[[
0OIXi=_XD?]aG6SI_jf\ljhTbI4=aNCpCDAC[UVodReB;=Ab9mO0][CeJ^SgAUIG
9=NlK0XK0ACKIH\W[4\S=2WE<fG2TLO:ToT:SXa;^KgdOoS:iSYfXnSq<6E0N38X
EkR@bSf3iUN4dTHG2A@`hTSp\AFQM\2phl?=I<>n6:b;n4]=n3hSimqKa3PQ5D2o
[OMa@n=_TgHF8]Sae?[om?b@_iqJ2EeQXlqWj1PmFQZCW3cW[``UQN2L][HGF=jW
J>J8UFp3fI8cFMRmNkm`9oFIf2VH81c;<No[VL;[JWhfmCX:a8k2Z>hD_LcEJpJ?
a6mA:1XVOLY]A]]ReBh?32KTT^hG=UVj9Gf0AQjOkM[\Cda[?U=bHU5G?Qo>CVHn
8<q>C8h3fiZIF:c8D67mLiPL8d;dZ@Ki`<]IU?Ka[5EE?I<CXib>Qo>ZeS1JEh[R
n6LoTNENg>2dcI]?TYqn4aQJjc^Eh7dcNiF;4hQh]Vm0G@n;TlHnJ0cH?Nl=Cb6^
3SCcdV2<kMDYL<Y^6^2enCJSgje@bZ9;W8H;cTq7Bl`XORL]GHcR0;UqDN;Yk5l_
2Wm\FL>IJWlLB6N3_NLFGLapDTmog@PiY3nD3f=A2I]DO92[PWj?[YEpT1@beO;p
M_Xf[M;]dM6T`N8I?6MOR1jkFA=Jh:P=XTlql7:7A?4qCahJ`V0L=SYQF;:NVbSF
XeE4o2U1C:@\Nc7FX`9pi;hSIPe5o8TcRPPgFLo]0K?]DOUha2mEY:7pG<12PYR^
_NGn`R54gno@QfK8odiD^OCVe1VbQRQJo?59SijGD;Pan>qha_2gDN89QV0>47Bm
AljAcO4`V72E[6mSkAR\JoGd_Ddm1IkJZ3d;<QWdPeb]CB_N2n:G;ImLlCRmebq0
Eeo3\HXaURdF=58LjYn\@N7ae><>9hAS_DZUdmDKf3[;^GTf>ZR<N45JF84o39QU
>3mV6ZdKZYQW;MO1XSq[aZhAX?Fl8eI1?U@e8TF\0[UDi:j;h6:P^O8jT9OIoOV9
NXMkPm@\J3GLZcd4SIpDRTQRHRhU]?^Xj]<q@MWg0F@HK1ALZn\FmBMRX^hG0\i=
A[[pML=VH47KSM]1;G]AJPhISdhWHaS\DfipJTRBeVlp5bGMQJS5EYnl]P[J0:QE
fhU@hNOo9SOep9EQ<]\8pX90VIZTkikX9Q2Za=PMgoCPUPoem42GaWLiqOVZ:7l8
V\PO;VHHFMMq>]\JC8?5f>X5;mlego7<ag]Fc?Ke?Q2LKP4TE69kcE?<Mf?<U=mf
O8eB0T96A0>[Z^oJpf_EY`=W9lmQW9d]KBhJ?DOlSbd]OEG=5ibS06F3Ac>98iP:
VE=Pp_\@\:OC]oOih2BPh[hQL>F5SQ<:DG6Df[>jHX2@E:NQNki5fjCYHLC_2HmY
QG<d2cUk`VSR]hHcW9@FUWann>=WGSi1S][L<j[Eq;MJgPUGiNLWPljhE^>Mgb5V
EbKRb<NF\5H5:mEBHPa=gal9cU^cEEiIZFnEQ\QLd3[1TdJOlO5BZnbfWV;pTIdj
@J@g_Sd7K7kCTH;5hl6WN0V6=epH<N9dX3p:C^?[`?A>3m\2VUjjg0AJ1=@=PPo\
ZA>ph3Q9@:Rq19j>@5?aDWlXo]VLb@I2A7089BBHiE4G<OIq7Pe=oYHdPU\?6JYJ
qlVT=[Ulj_LV<JSln[2MGECPNgc:j]<Ui;`MVJVg@GWTdLC92fe0fDbp`nD16E9n
2RamFi42c5ioSkLaN1Ge:a<^ObOkB@RU@BkPiZCQ9?[>Z[ACk5^R@aolaoPmOI3c
f1?Q[=hqkh_eS6@oN>SX;9RNFZYTjjeaSURCJDJRR4hVUaG3DZZ8b663`X[2In2S
]KTnA\BEK9K?C0XHaL7m>D^ZUYp7UXL<=5NSjkUZM9p8^F;``3EA^Ikc]ZZ_hmBQ
[O10Ii706p;VcXnl3qZHI1Sk5c@G0YDhU<4hI6fBV2510[pD0QFfVjh8iHY[Cf?J
R9GTDbW5eK4@lqH1I\n7b9R8hJe4IR1[3_eJJd]U3ZhZC\Z31Up:QQ:8cjq6iPVm
gjW`7kEmaYLp_MkKC]jplLZSPZiEDI5XKdVEAOkJ7IZ7E29q?\mPf[?p>fJ^kPF_
YKXON0jP1^oSHM@VNKTJHXE2bBHpo>H8TIH7dM7m>Li3HkZLeIencVkl^ek;<S<W
6naHR>LpcW5Z;JQ[ePab`e3i?l\b<cG\Qo;g789V_I7DAKkZlohCb]^QDNHUWNn>
YlpldH72J2PO=`2gcTDbH1FfcW7h2^TmRSoE5=g=3<5QQO1Ma66Q2i9=a7f>n5no
<h_HU^M^4^ZjAbc9NkRjBqE5ni\kbq?_=C7?^8QM7h;oVL<H:Tm<4>SY68j6p^`P
mIaVpoNU_4WD_hXaj?^7=Oagp5HSFWA=jV`Z45fM>MYSFoWjfDCp5A67X5_YdmYB
7RB>:1no=`]i9>5T5[bP6C4pRoY`Y8[:RiB`QE]IX0jJL0XBei1q>G_`?[OD765Z
2^he5F>0GaF_He?0lO1l?a6U\]D7dQc]df1FaZ4URF2nf[05qYURCQ@;]cWVNaTY
dXD45<@60]<BBjd>V0dJ[dHJO19jn@cc6PR>>;W`>D1gbnhBYpl2bFg]:l?ECP;:
bhTN2ZeZgcPcQm35XPlCj5GVM@ZO;Jg33IQ;PIPo?942=aPBQfmYTEL1Yc<E;DM2
qQ96FJ8i\4TTa=]2M5R;fLnSM=iAND2V2VRIngaUg3\R_HC0YVRfnZNH2<kmTkh6
Gc>]JS4AAQL3RcoDN:Y]jmFg870fCpF0KTBFVEka0de@Vfbj:FMF_[:oAcU2`E[^
Kh9oX9c:<d^IjK2PV]p7aVDaHaqOkX<UPJY:nBVVST6o?[j42FCbaD>iZD<SR]E0
o]eT3gBm\Ra@eGUTGqIieinZp7APMd^pFPf[>MYqJe5][6g@jj1R2[D=`D1IVdU4
10aKq]_5E\n7a6YkKFMj<nbCDjG`TpiNjZN]_g1]XVhm;dgPB>iQgX]cq:nUe1m>
q[gG6fhBB6FL0i[L0gjg@ME7@i[LFeeDdUEQ`QlfA22GI0iDe8E^UCV`pUTERIU6
qJa:f:JZJlHg\obHqQ8>`Bf;0YR_j2Rk4aib_blc3lD8eSaEW2f_nJN?f@RXUqk\
H=8nm:bc;W3hfZPkjb\5ZjkUnFqBc0b<D=pbNQ^m0lqLT9n1EnpB1mhGQLG]eoLh
0F?L85?@ed1M9b>D7iGFZL8AS;kDib_0GL[Y]7gebJWQV??c[I]PPFEpJZn3K\ip
biPkZQNZc\:d7PW2cUG9AXd^bo4BTlVq[PK>ieKlBGcg5V:QD@Tgd2UmK:8qj8>F
4YGo_PQJahT62?AZg6:jG4YX?H^_pbHEMe1ZGN_elBPD:k:6f@=SamMa^OWpO[4m
52JikfJF:hCYJnX43]iRIUEE]LhTgPOYlPLCR1B4G0O:`BYl;H>4EG?HH;\<Vefa
H8Go77qk3CDBnhqlk:EoZWphccMohHHoQAnLK;G?3Zna77?`\[S5IT8[>513``N]
34FHCd79C2`1Gae?VS1=O6q=;79m6eq=hJG=:Ng\OD@UVgVc>5]Y5p0anT0WiR1h
YK=mB\Ta<0pkicQJ5MR_IDjHN`MUkXMKm[:L5L\[H2=_5U4oHXABe2OhXq12=4;g
TqA6CDW7Z1k?aJgmbhQoOA466BmBJJk;IlA6mI7iZm9V`N4oe4=5D^FGSh8BjHhO
i?:\]k6oXCA@ZFaOCIe26J@HVcK6W0kgYCHCiQiPTF;hWeqgcQKHASDoh\?Nh3fX
<5qo5_9N\IgG\<_i14Vb2c=?WS[l?KTFnDUXMCW?H5eM:qV3]igmmplE3F<a[a[_
aPfLWQjF]8c^IgfS3oWDE=qfR5T^_78[MBbO9H36fL7AQcJZS825DlIWNeT>UaVP
ZE@;gd4=ZZYJ`4_hIc>NJJV2H;:0eG^qd_I^\6^q`d]Tgj^pX35_cE7LjNQa]0PL
n60ekmC96amLI:@HB97=bOTaPLZI9@X<EEeDiIWjIObRGcCQ1Hh9dnAeSaU<S>oY
n1qnBMVbflBmS4DAZFmGNUpbZk1:DnhZQ\HK]Z7p9hbWQ>Dq=k`CTiP[o7[Z9@I3
\>TcgaIi`i084AqD<eF[dkpTg_;\Un6H6GjXhGjpd]SH]ohpdYF8K6AF2ba3;C;i
12\>6ZXfFQF[pX?i4a2ae7@LT;iO2m\_Oq;U?@0@8VkLkmWG36Xo3P2V4LalK\U6
Ee[akKQU6[OYLlFDp6IEIIG7AQ_QIJ6c]QZKpKkF2[NNEFQ230PRScXALqVLU;nA
ZClg5:^m]B_h;hg]DnD5YO9IGHW7JSf[\];BQSoCX<qi7D_1kmTl]To?SpE@D@1P
;q6k2`?OChTUdEV9AHIS`cpojP6]0:eFNc6mbBI6K3q3\1`3KDE17P]:0l<_H[hp
<Pl<ZEkZEbL^^bU1J]E<ONJEaEEn7H`E906H0dC?hE1I;YMhq07MEceIh\^`a]3\
^q6VS[k63qY07TB4QViW;cZF_AI32ZqHQd57Z[0N`\k7gN\[BYq@>AlGY85P4d3o
ig5SN;RpV[2BC94^WoHD:`NQ[ml:fQkn9aG9K>Vh>I9D5?`_aGkJ2F2Aqh5MmY:M
pYWDLPDJb8ae6iO0AiU7=q;LdeWE>07O[O_6<>Y;pZTQGlCZ<Z>Fg@XV5l39qQ`3
ff65kfBNGQ<MVYjhCq42Y`N]VKl8IQG=3f?PW?Q3k_GG[;AiiG5HAab@aFiN43h5
Tnpl88L^i?q5[5kl;U\Bg]07]diEQ_SpHLO_ZnC;DfQgklTGIIldLai3U1=HqS>K
]aR@<<CBNV<Le6J@_bQ1Y^gnDb2p=m:Q0gjLodg3]e0_@HBS:DJ591`40HT6@\Vj
6B<mh32aP4MYRfLf:cX?25J81jkiFgp_]G4Ng1>^VjoO\Y?D\;8WZ;d0l<BZHFQ?
_F6]j;m78G^>?>;`F_Z4jaGdM@aVD2qU>]12E1qnDoFi\=[:2Ab>:cCg]\;m\H5Y
bmI[_XVKVT4Dh@YBLm];UBIM[\XJ>Ub\`lkcbV5NIpe69;Bnh$
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
>;ceOSQ:5DT^<lO:1P`IlbVNOGf_CRL\M0fGLifPh`^=h:i84=C_@i:a271>I76a
WfNE238p84j]?;N?>R\A<cgCE6Bp4PVmmgm^@==o?iLc7QZYl<U]8Z_kGfh9:N3R
leNgFAMJJFi;_Fhm@gAI9ZBPg=UjB4]BpA2<e?>pMRI=nBKTn:5nXTC@3G>Hp=K6
nX:bDKN7WHh>O=IjKE1^Iq=Q>^fJkDSTj?91SaHZ@J;I0_n[:c3fco]X0WF60bTK
5?jmq3BkN:ScZI`]X1aJ@P;e;p@0\TJ6HjFml638nWJ7IGACBDmmNPf<W>7>pXO2
=l5ZGfC3@9ojT=\0kT7W0OHM`6m4=ecUGc@inD9P6Vh165[=3^KnYp5BnCPfmp>_
S7O9V`b1Z0^VAI59f0=Q0gF]=M]62RZc83JYane]H^DMgR\Cc_IjYH0DS18YD47o
<2bM1e6n7lp1QV89QGiNR>WX]WqE80RN6M2NS69JfIUDX>Bfc@p<od2``EqT9eT;
]d=lnfCD^[[nYQjH6lnba2JGPmp=A`14le6=cGi[98_[eleKm1lLBWlB=874VN1m
@:fGWXpImNJ?=CUmZ\B>8=QDk^ZWKKT\c0nUf8OC\P\pe><^@U56jDVf57I9LDC\
VLcOAbdqUe[?OmqM2WCieG64[<9^IO;_F=M2[_moP6YB?<:?g@S\HlIWn:WS@_US
lSkN8@QPaBYc=1]I[L<a7R`89@XT2h0MC=Pg?jq<o=\8_S5XQL_`6VOdUlZFiM4\
gNYnQ;]6OO@=oNLi@P\a@?;QS;WGJS@KKfC^dGUEaQNPe_63TUB5Sn9[[Pq2bl:e
O3J8@^eFJ]nP4bHHJo[0AojYHTV=\Y[[U?71a<kg778kZlUFUL1fN>7Vg;O[[82b
[ZClLAX_a0B6c8p9[b_SWF6;:DVKCjlRK3mm;NTo0agX9>hA935i1La9iTCh4]Pb
=63T8DXEoBgHEQh9GjNDiQJj6I5V0ccbmpC6j`mLfqd^?5]DLZYb3mP4Z_8V:jUT
]k8k5fEAc`ok_4DU_52fSJXARb_@LZlQHj0H`ap;Ofa\:lA[YH>9FAgb\T:V7;@e
>chCHaAf<M^X4P0EMckjjX2KX<2?7>F9EQR`?1Yja5=ljAahhapXAF4i4]cmA57N
G>I3`NOLd9pV6dA:2Gq^Gd14Wq0bGQf`VUaYh6QSaUAI451PHkLacFnkfF?^>=VB
0]mS]J?[C^g?hmn7c:6fMOWLX80fGQVIl\^i?l;5d_\NA9QeZ^qc@P:Hj0Bc4PTM
<oPf:YBCR@<OWA>KM5@g2hQ6d_8jdgUBS[S\A3J]4k6OVq_<4CjfW1639CUXdXaR
@n161XgRSKl_cD[S>Xd9:D^OKb::fc<J>j^R4d2EdYlmk=_:4N?Rh=SU5LNdb]8m
KaqOTAa?Ri`<`2Yj5FeVY:<KlKDR2lYH^9]49mSga]:kadBNEJ^=36XWBM7nG5EI
6XAOgA6l`l1PHmOF6nC1mXFpZRb@`aE:8X3I_N>@MPXaQei68Tm>;@;=:GF7dER_
1JXnd3dn7hNW3T00A3EP7U\Z9^TL1JT81@BLFY4gW\6q?2l0igIq\Gl0\j]AneiQ
>P?LJ@M8ZDXK:L]SMe`aH5eRe;jZL:IUNR?c_J?V1B6TZa0aPQ<OIC]::6AP1=9p
Hf;=<M;GCU:jO85d7lL6=OaqLVoT_C3pH;a7=b4=XnY<WDZJFMNko0HTUWThR>9i
;n[AGVKhp2[HkF<jqJhbl72LRLd_6>Ko`XKE4HY00:i8WL3qGhH3ROVf\VK=RS<V
A5cMNC0m3MfcWRTRO^8od4gkY8>HHAa_8Y[d[F^VM\S9E5YhGg8O<\Cbc1i?i35i
DPl1?123=llJ`FJneiG=>:S4QTm7cTBEE6pe=Je32CqI:jC`cgp2Di^HV5pZkKAX
k1MIOLFHKnUeWQkJiL:D<j8?D2k0baB5eaeqfAmNbmlVah57I6b[_SV3\YWAgX2[
]?h=;FM^Z8l:[]J01n>fZWh;`IVJeRSQg3PQbGlLe7W:ZeBT8I=6pCTFN@H`qb7@
6n<q8:oY9K:__7FE7hNi6>V^n5FTgaaYXY2AhUPMb`B1eQOn50Y<p;b^GKc:[ZTL
^>m0TQ=:KqIQ:P^jdKJJPQ;6Ncaf<^n>A1EYl^lWM:c4N8XR_66BjqLXL7=oAMiO
UGG>]<RBF1JA1CgOKhl3IcNhoUo:61aW6pNIL9nJ8OoKhTd\AdQaK`2PhbBJ>G>b
_MY^PG1nCTd`:pidIbkOCN16l`;=OOAGoL^LPSNRhFYiI>DV6MdS\_e8MmSWcVj<
@5TB36eb6P67cIpP@diT8VPFF`ikYY<L>PTOB2l_]g@EI3jD8D8f5U^Z>>q0n<Rd
Z[q>LD^4A>=kmk\f;K68J7XOSHF_5Kec0=9\Ee[@W0360OncEP7nL\=8Qdj=ADAq
cIXX0bYp`bEc>bqA>j`P85W7I:7lVk^7dVYqDBeGhR\g0f\bdR@N^W`TK^S@k5E`
eLT7QPaEGJOfNhAq\ZWkgBmNh3_ELM4=]GS?=oQTlEWV1n^_83enE];7kYkqa[S]
_hi1UQ[BkU6d2o5P>Dn0Y;QTEhJk;2bc>WG<geH<e7XoRZTp:7E5cOkZcKKWiO<_
hELbEMd4mB^[:9JYNW>dPjPA2M6p60Fi3GH]T07R8W5B\CijQnl3E9:KDQTGBA_i
A98dM`9q7SaUMcXqVA=VW`gNmK>Rg^[g<[e>TiA`L`daNgEDqDa^Ij6Ipg3]cXd=
TcagQg43]>lq6ZK7:>Ul3kYj;cAb[XkH_oF=Ymel9`SgJ4\f@N^<Y[[B3;DPX^6i
K4NK=d1R0iCDqm:HETmM]O[7W6`m1HSFWg7_HqWPX8DcJc4d6`hZ<2@JOTpJ[3L[
9;MN53Q`VQS79Z;6:_jGfMCNi9iUhp5_Zbdd?fO<RPVUenoN]R7]2gVC`51oQlF?
RR]`Q5A9^O6^n>N<?XIE9iqB9Yg<gJq<A:?Y7YmoJ=i_lm`Z;DNM06:8G9AgRknI
6>JI[D?KabPIC?F9H5qf4k_`]2B1EP<PD0lfQlEM16E`moVAFWIL3\k:KO?lmnBO
^g<lklDQ\cDa8fMXEejSjK2^K@HbY?LpDg;d8gTcL=@`=aPP2g_=niKVqF<]5:\L
pcD`X0Lk00YXM=9AU5@0jp4GlbbCR35Hm:boebQ79;1KjWd1f_c?pgj0N0D[7S=B
eKUD?SaCBFVF=ah>gQ_0]^gJZl6EbB=lEbnW9J\6<OdW]7hMHQ=cPH\al;b@5q]M
O7a3m9pBgVPMTC4lQ\lMLYgi7D5p4L3Hn3AYO>jQ8DDM3[ZZYj1:F?<403iN>AYl
;36A:>XJeKa50a\aaV2Tc0RSM9Ooa>p6_AfbbYh2TJk7EmFm9i\4DLXfEMhJdf=W
D8ekZbGibKd5Gg5Yf0:qHjT<FF4mqO0@L:R1N2009c4`D_XG[QAEJ1]<pAaQbKhD
lXC6C^EB=`<N><GP:9Jon[W_e>\V^@LiKPOH]2lJ4]FnE:EVeeQ[QK6FS[mp[N\k
Z_N\pCWEYYaBW^nE@=8aW;`jQFdBLhigR5>`_XokQC`qnMoGiE5Dq;09RLJ6cphd
L\gHIA=1XmiCY8YDP<161jN6hP=H5=3EJ55?bJ3A>h7PWpG;b6F\hFqP]VaTUaMJ
K_LA[BiNMSYdWCeJT@gNI8qC0^GJC`PTXE9Ml\4UMQ@F0_;A8=?cNE@G@;mW`bF1
52qn;5n654[5R;e6Vn[;kIPIJVU6VQM;Z9d`6]apcBg`X[pL583a1UPTbm3iZ_`Y
MTUDC]NWAe?1E_Mm6@?RMOAjQa?1gfLFcbiAK;96]<i[7;iUXISjVa>P`H9PR[]5
=gY=R9j\7qbDB1WlP5ePe@F3B7>GP=bUL:iX@Wgd:g?T<hmFHhXPDV9LYF1;b@ZV
emIdZH:C6U@8>4f?;;^o1@n\Af:3QZGaqCB]k01noSgm;^;=]_U011JHkmWNhZm1
GfObXCenPkO?G8nEf80H^=<VoaO:knJTVNN=0Bo]d@KgnG7jNABf>jnpc8bm@[:k
df<>KkKMgX7;3Re2hKkmZ@e`pWUbciS>[Rco2j;ed3@l5[O2?9O2JK:Y`[cD:@5H
6\mi^oi6:k@`KDHJ3F@Jb8_X`WU8kJlR`Qn@YUSHc>CK0qcaQ`PNGq^h<HOB89SB
jXK@K?e\5Q:3oNc7kGNegLjD;UAol<i0<MmNEh8l0YE\;[\[G\YYT=THX=>T3;ei
k<p9PXI`BDH\^8SgI7lS9^gKaIXqbjKG@2Gq[eVJi6I4kZ5GmnN1KINII`B@K1a`
I=UMWkbNO?P=39je$
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
6jfAjSQH5DT^<;E]R`XaE5]8^;UmNHH1Kcnci?P@WcN\Cb[\CbKeYjJh8FB99f=E
AJhHJeFfmgqJc8eFY@<4CTaG60G3egXYXFDL;7lF6nA;OC8ScS<V:A_LeE73hi7n
Q07FNfDp^ejSb]mnVbLEI4K9GZAg_cO:OFN]M:M7eTG>J5m?RbN8_AT=kPUD25mD
kgp33I4dlq7KT2Y^HRTeBd:aC]g7CF?9GNAOGq6^4cVLfp>?dRJ4fZl3Ad^Z7lch
9MD3oN>oqClb[oH2fYD_FldGgeo1;DCldWf2mpBO\b1`Aq18X0k]8<9:ZkkXVU5o
OQA:iC92hPSJqg4b<Rb0q5fPW2hh64Q5M1oSA0jH]kmWGJ]0pH4m?b`8VZ]Z3k;a
@X45?fHI:6``JcOlqHISmB\g\MeF@KaVC1RlDKTqe@c[khl;T=O2j_V]O4[:J<`J
<_4RjQil2nfmK2g`h3bgPRK7J6>nHmQ7qVE1>[;Wp;h<fKnQC4>IkBP<Q5AZVHEB
fR?>il0>g6^E269FnNVBWAR?lLe\HEUc01<AWXY9FO=aTi:^\j_PW[7lbhL6X6al
p`c>IGd5LZIcD6fFi2IhVqg4cW\U_q0^B[fVKd>>;36YY?>kHGMFMeX9ENJ`ik_c
OpK>7mkT3LfREUARcI:Cf]>6WNLZV:TUZifW]_4;`2\_bkI;foYQHmo\JKoPDQ\l
^ki\1O\IU6<kG^I:n4Q8UVPhOqgCLnlk8GhfTS@0qjk;UGY[hXG_5Ci29n><2q1Z
[^aSLqI^e_iAWg77jbm5;G=51a6_SO=96bX<NGR3Bp\g4F2UE>hc;pbjRSE@GS2@
8c6Y6ARhT0oBjTLn<M1OETH3BAV>nG7UI16jFJBn=WOTl;1^nek=]7jSo:;T6MpU
mJnTO?p<:H`NP7ZG^OMk[7NJl2e992IXb[<][4VLPS9GBp?jS5KGBGDRL]@\NgK^
TX;[S;>4CLFO0Sc_\15`nFB0LnbB8qYJlI>6Rq60k2Z>C7Ug];hLAAEmF<7fUX8=
5qS^e1PQU]Tinl=b3d>Vj>CaY>GnGUIX3]T4MR[_K]UObT:kD4TJ?B8noRp51M<:
gbRo<\^@AYHMUo=0CqTjh?4XQi?n56Mm:A5PDfL6Lb:1<d0menPcApA2ACeMKi@Z
fkQC>YcO5>3UWDQ=]1E_QTJcRqBijl<jQCaPaql@bZ4^XJjMmRJP^bqM<5WK05J_
:RYI6j3J\6gc2M;\L^9ReGOBJ4Wj<p?^0hIj:NQ8Enoc5[_UFgB4STQPq\l^e5`?
i9EbX@fbKlW82hY45BKL]=olFS9U\j>PiLN=@FWGbEo>PW;K]8NTGZ\Ohb6ck<@_
OMRK]d^N;QSKKmF9GV1=pnRoC3l:U\`b582BZ9;<EM3JV7]l]J:a1>W<X:YX;pW^
b967J3fYZCbJDjd2IXVlC:e^h8ZfN]V4F]A8TQX9o6\lBCmjLYPnnY96E_5U:1ln
5`@NPb=40LMM1jX@@fa;hH\HPqPR<`el@_d3@==7ZohZZNjga]QVM^gPTQKo7R2k
VWKFM3]0O^U2qGm_]S;7pZPFWmMTpQ65be2[h<Re9AS0mcMp>X8EAb_]Mm9KmKjZ
_UHQFDYm<SBVW2QX>5pPOELlXnbkLilOkceU:mfRkgD4doR<<h2eJ064jn=?MWBj
;C@\c?D?ofKko9?jTHZd\@faLD\KeA=T]hcV5h08dG=KAWZjWLaPG]WeO\pMF;R5
4lR:[h3MINPK4@?c\d5^`4M\d>UUDGjpQBFnG<en_<\P?ORn;X24AmG=;bCWj@I?
3j6>Y>F4J9k<bngIILjS20DOGHRcHk]Q7foNL`gC6`TojSCF:A8_4]MlNo;IUN[@
F]3hda9qS<0BV;T`dn6UNbh`g0dTn[1k0a:PTcUU;75MeT;iIjb31edIUa5><CfO
XFF_DPq07Ym>4Z_\5SKF3W_K>2jGTP[VkQoPPV@FUPGqU3Zh2<UQ2O;3GfQkQeAQ
=?NgmX9Gd_Q4QmZ3fiGc<bmL7T\l[a<c=RoA<m\_T^6^BN^I`O`nFG61;l=[]d=F
=_LdN3bLMc:CJgB2I^oq7LZOVc1q`W^k2O2pHR^[PC\9]J^24LnAFbl_o^Hfd`?<
_D_k8KQPd5FCBRXFk@;HZcQ1h>oLiUal=SNdPeQ9T>N1Q[UZU]B>knLqf13BW:^]
KB>F0=4Ulmd9Md`lIU[]V0q:R>X984q8@6RCIY4<7bY9T<?0Imj5XgUCPUA5_4p9
QHFYg1p76\2PoEoi2qS`o8DdYVZ:`m5B\Q@<Ba?mAhO7]U_1bIgR[]Rb50L4R;L_
n4L6_iLSifi8HdLV:MS>8`_foaEAE4YeY^JS^L@2@4Ih?F<Mqk?[Bc`<SU08g7Q<
bmoL4RoN;=I9@km4;R86BIm9^05IF6Weo[VBjUA824BFRXkUIg3q5=Dni[cW^:LP
;=I6JCA9pUZjZ;N>qFOiXgWC@Ta:eaBVZW<^2g`U2nIClNFKR@iU@6WPVEX__e22
kC6\CD>q3`TVGc7ZNgiT6A?>76>oQV^JcFNf9k;SK5DfNW[4QJ8TO`DIN:_?G=`@
3GKAhefkqGBQgDFIpQ5eY8`qNekb_1Ifail`X<n[KV8QMl_hMSJoFNPO:fOj5DLB
BnaSo2>QYTn_P:?OQ8KiaN0XNDk\EYZogFEjZMe:qkOXKWSW8OYiPFY_3dHkaV^R
[ZdqcALa2D6dic05feW3BfNSbFlmN^VG_?BbB<M]a]^lllHK0B1oYaB>7_K<9I<\
MMifc\L<X4N21439pGNn0gH1Tf7AC7kaIMLG<?ZfDhY`XW:2D37VDe``_6Q84GFP
OchHEIm:WUjhlW3N4GXn0`AA9^2VYqjOBeI69d10UFom16a7f^>bmX2PTMMHD\kC
dB]hVIECR[9cjlLgXLWMMc7mLOk\IHNc9Y:DTTPm>qoD18bMk]?fAf7H?1cYCcYf
PXQZK6IMoBIJj3\n6Rf=B9U8F?60K[?cK;ko>0E=3Rc2=HEm8Y4Pp[_BP4Gbp_CL
6a:;p2]@LN;n7Bk`2leLj:LF4[iV5b>qPMRMOi6k6M4YJQe9P6iIjQecJC=AVV:V
pM1UFYLof5okP[>6Z3jKmfkAhL7B=<^H<[Z5X3AEU3L[h4Sfi4Wmndo=EG=dnO71
q3:46TeGc4[m^UOBjW`Qnc0bHcl?eUPTBCdeF^nLigf2Y?c\p>MYTD=$
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
DAjFISQ:5DT^<La1cXgB\Z@RZCo<7XbSTINDce7;1<lUlO=0N^E>MP6dK]>Se`=;
VHUCiD0E_S7LpQj[YdQI4R8FPHG62N\VXIk0aI11m>7MhFjM]]Eq=Q=e\_dfn`kW
60]5NY[cPH\F\c?^aAnBnUIFBP\jqN6R1FbqMYFO1_8oc48=RfE?AHR45Wa=\jY2
;n0[j?\b`[9aJWqBo6e6?HqT:EO8c>6GoLiMAY8q=6o^NeSYJ>\aIoji\SnCi2MT
\31::gPnT\l4UZWYWSAp9fDdOY@p6T_aLWpSnfHF5>S_AGf8og^;3ieTU<mP=1IN
hR;8fP>2YEOT2]D:RIV7YKC;h3iRACH6]l:PdPnG[<N\Ld]f200G92XUiHJ`1fgJ
`qMgm>`PkM51[;^g:La>VQeUb[?ZYT4T;Ah2QN8Ai8CG7Ja;KQi51a4aRE[`U0K5
\QBTUSTQ^V1Y=Q3SP4ld`\gFiX:Jqdm?@:1nBJ@k;HaI;O?2UBM<fe47RSAZHM0e
3eZ>SXk7nc_OIS<0V;LbaoDeENJH;[38XCDi481M6BgL=H`HG]7GU\Xq6Z5]k3TH
;TG3Zj=]bj8ThY2QQ]1RQf3l0[@HP^i55>o>U0IUkVECFLS7j1bU]@QDOX@=;;<^
ED\7Oim4d>^KMcDKpm47GF7Wp9VXTDac@m6c^T721>]_c;CE`a8fEfBWLIn0@FQL
VGn7SQk7S6oKRjRiZ=NVPAkI`5W8hJf\6@0BSBCWch`9Pg?iS@:IMD[k9oYq5:MD
]^@a37A2\i2B>ln]o;AB9QI0<4_m323:FH06kVS>2LVKbIGf8]fREEphY>gQN0:7
o7Ee<kKT]:>`LpU<lHIBbqXkOBEjq_0daQW_j23\Nhae4K46T[T2LGA\`6aT4hCH
DDB4HA:Ria3:8`R_h:`o90>Wj4RET6eN_Pd`?9<gl\m8gY;mFZLb^I][8=2Yb]e?
S8QMQ]eC1@fhi<0W]6e12UU^2>;0O_b]9J_npXDIZ1dR7<TAJlUUEfP>Q2N6U]cg
T_@T[nmIeGo=m5<XLg3lKFf`I0b9iGN2<=e]a:APgPIg1ah_E;AlLlNkb7\jSC?q
>[@m154BmJma\>\_QG4gHWe5kBNGI@4RPQfd488DmGTinUdah>bj3kBI]LE`]_ap
5@L>0``ak72_D^>mZl]=KSagAMCPjOiKY]T2VXL_3d3>]YDa_YmPgJ;_F[=7ZQ1M
GSBQR0ho=[9^WSLbGGf>@FA8DdpLK\AlS6loAWUb\7UAPdRMgGX5<A7[>ca^5mY_
YOK382SH=2TTfUH:k@T`]jGF1jAQ`ZTVMnU^CfG668Tm[7VR08ZP6q\C_]SNUK@N
V3^C3\=3H^3[W9]KN?V;n?fJ[cWoXBOk\Ah]52I<K[M7Ag4b1bK1hNR=9oWkHD;F
h9;Xkm[`o\YPXT`U75UM>agcqmF2F`V8Wj=Nb@@TgZK5QjL3l[m5aSJo]F>:NQQ5
mkS`FPWpYMT[1R;9@kVk8g>`1D6:g8q@WLaB9O[U]CdiIEA7CK1587LBLVV6k]T<
]]9naKjZY>Yd2qlkm?c5TB@N77e1T`jkSXjGRZi6MkFJFFqj8DaPk=OE24F?PI06
HJY0DphEb`liWW\AO?83AQ9d[ACdle7Q:GKR;<:Q:_Bn`HG_7_PWm`e\1HV6hA:9
V:Bh3jdId<m=`l_S=VP6AQ96cBN<ep:a0Q\6FY<_8o\VSmVLOE9b>5JRbXdin[Q\
b=o7@DqN9OI8L[qCk]oVhPqW`Ql_\LqE@ZeFB2jI`9ijVZ>BN4\]YASUJK21Jm;6
26YAl91=Hqeh\V`h^qX?E:Q5_FA6FCX:BVWCm7Q9QRHXA6=8JHomB28IL4IKkP\c
EN]=I`l_Pec:7PLJdi<c4e181PgLVNmRF\j_l6Y:=6iXfJQ4fAW=pQnNETc@pkm;
hhad`d8XA46`4abV3;XpSn\kQF]pLGj@=<F_YY@]d_TCkQ>;D0ZTZAcKGX4B62PS
iPbHS:EJTf;\KVYpTal<n6j^MI4;@NYg;\\acmdPFJRje?E_ZV^p^32Zaf08hGUR
A\VNf_ARBYH:WjXHa6m[[cmqOLZO:npH\>NnY=e:7[N`e>qY0VAdMJBgS7h\c?AA
o?eqHdDok8OPdD?@iGR6VS5IX]YfUGE9i1d_HNjSjd`feoqThMb>CLU^QQe5MWig
U<P[dS[<egeNJh2Pn22BbO=i2qiSBAk[mQTjaa>HCKTV4@^_:[NCKM7CUJD7<<hg
CY1Wp5Ee=]Ae3aLkUK<Sjo^Q3@l]26_lW]<aFo[FiQA>?6SpG:13^V]pMa>C4Yi4
]GQ]5[B>H<;Vnhe]b9=lc4OiSnZkZ[]CA?Mk_jBG3ljo:m\O[nlg[okD?h<q\G0b
]DRqX9<ELmq:4?FRbYpV7?PDhSqIZ9X@<Cd8cfB>R886n5f285HPNl6n2ZNOSNbS
F1QBf565k:\1[R1q2`S]US@p>AJUn0kYFMkRWfIa]hd:;N>YZboFEZ6YQggCIDlI
^1?oLH`;ckGU;G2p`P3NhiKqROE[8[lTDBV;nfkcMT[bjUmOnRJ5b?ZXf_9Y6]WE
ab[n7OHpK>F6_6GG3F4OqCm87`L6F>cF>;Cqjg3m>Fb^BN]DnGSWgnXb5mC0R733
A^qlT0h?BXU<gY<6cpfnH=A65S2MPRGkDD1V:^\0=`NC8bNlq>5La9:hAOQ:CjIq
\V4d;H;J75<DWkKKdg3=HfQ3imeJanqj@64@e@oNNJJX4qNWadFMJHO2XUI;edE:
_=^iLBS_:]^`qBB8CKU^JL7A3nKIQG9Reh_F`JHV^V0VJdUhZU]<T[SN]l>pOYZ1
c>chP6qKmlPVN0hj\KgBk[4:FNgG\HkMVCCQ<aqh\eSkgnq38Sl2>q_FFUUKiWg?
_RJROR`UI;6g[?8e@cMWSV]W46RG:bODMohmbnl71KCJhDJ>5h[R`1J34JEPJ>W[
QE75`Z8F=BdeNP7\fGPaAJY12oNc674hFSgmMb?5Ldq]WnI<nBMG0?GjCn=8mThU
D>IUn:3;3Y_J\]]Mm>A`ZJO071P76_1Sl1IW9m3dBEK1lf52JB[KbmN?D22Pop`^
a<ZfG^@oBgZWS4_::e@>[473[X1CM77WlO^4Kl^JdB=9kJaXTF:afWS>LHAI]Y[;
6[lP>_`SJo=UU`oapEL7eZ?E`O_@f^KP_Rek<eD95N58Vm?3<H@=PWocN?8nIJDc
GJimMA6O5`gVkG2\XA;kO1TNZL@`5cgn=m6pfgeaPi5pbW7P9>7F_K`EDSDM?[1C
?L@2mQk4k1>4iQ\?0NKgnj8Cq9SN1^L^\5jil>U;M`TWb`@GR9TeDPHdfF=MLR^5
d33iNJd`Am_`][]>C<noWJKYhAclloOLC=91mGe<8CSVAT5IG<kiF`0F:FERLpXP
\_lk\=MEJm192P2SC53lq:Z=4mh9pbi6T8`pS90F9>KCG;oXaiWTbMA9T6eN4YOW
O^F_Gc;SLT]2Ig1?7391a`PPW>gLah=S5O_UW3Aaa>a]UT?eO2RmbMomTSmCjYbL
cHT=F6GkC`k`8;EWm]7<3_mT3_D=PG_i5^_B0dc\4lUXM`?`OkRVEITIpN;[I<=O
SNBNTTha>h3F[6`gF:B68Efi]XmZ2F1X[5:i9O[DV3`GTFlGQAcZTEC>SjGkHnkh
8MO:VD]@I<6qOUJMk]_M8OhICUaHH8dcWK@DEK4[YSg=:=Ne9HXDP\IZagMRlI=`
?F6[oL67k]Ni7XD?DoXZJ1D6Bj`RMYqAaYeXG[`]Y;CZR;hEYA:kehAPQnAm;iDP
@3OGEjlIAi;8aeC_X\FJE\aOdR]dM`WhKLU7N\8J:^NFE9=DJpOB5<HFMbcT9e\B
liE;h5Le48g7]H6GJSKmhLZ_[PXUaP0CbBY9OT:>7DY;R0DFhO^FA4XIO<7]5ai^
aO_VTRi9hmgYCgjoXMKon=qGIoc]0F6VfLTAHV=TZnYhRS>YPQ<;Z11Z6p?IP]HT
D@IBn7aRK]W[6NQR^<OCibB:98F87K]Gp8<L4LYknEFf_7>m_A83fVbU];4jc79A
CqIJY:eK?eIH;1CE=S\7Y0S84TUIW?lH[]OE1O2:QVM`nq8NA4bLMWi=OP_??^`D
:U]_6m0EflknDKXX_VH`e29R6OgfOUZd;L5<GYjjfJL]U>7;@p6UCBAoqV_dS0IJ
gEh3]qK6I?km860Ie=L3c4Ihb0c_3CnognO29;]Ef;7>>mI^p:[iOZj9M>L`[nRV
CGV`O2JN_ba69QV_kcFXeHcc4F7pXFIi6[0=g]fjXOgkj93Tj??cO^Ok9mOf;G]`
bimh:dp9jNaT>\`kO2;EMS\lChA2G6IIHZJWAbfSFfB2WPWXDp72:_7;1pCEbI:c
ckZNa<O[:MAWF@MXGF7UMP@TXlRHLGA>p2iH4\DCqTRme90GeBS5IKgZi^KB4S0<
CBRjN7=BU>4`dM<fClIB^PiC=Td0>XQ0RZa7pm^b>Niq?1c[Y=eR^;DEk@;C1N`q
F`cHC4;?7c<gQWjoNmE^RgU?]iXe\N5YXSFcm;mXRnS?_7OgAZUHMiBDY?]bd98[
QW7fN=Q]@PXBD@`]1T2JI[3CVX8pA?Il5F4qImSP`>mKqK6P8\L;i553=0J]ETE4
p>aV_?=_:^EnbQXM8OE1F@d7DTQ\SmF71^2WZ0lA0c8d59XXllNEUG^<nAO:43oR
3fk8D2;^GcAGm]::W=IFD<RK:><\RYZ=9Q6pjk2;o\gq@OPiLN^CQI`lkiWdYo]5
CD5<9@hqgdgNbl0nqD1LN;EWp\8EeZQTpd;EBCO3ponZ?e@H^jR]fK41B16Z4>iO
PAN9_X[Xl[j=Of6<2kC3;;WCH@VLUc3_N8JbUn4M0]OYOGf[2FP74ndciDY><P:1
f`@?4[V2;Klq2od5o>hqVg0fcg?@@_?7T`g7:n5LpLL2kd_e=4<5^cCXY079?j4q
RSB_b\\p>dcUkPle5:\GPg:jY5iFF0XgOjXI6JH?S=mpOMDbc9]]R3GYYCM`\gO2
CfNJF?b1<\AEo]IpZh:kWKfp9eEHE5mX>GT57;GOi38NBCHkZS:W3Cq2:JTPcX$
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
2YN7HSQH5DT^<OZRZo:aQLCL86S2K3><74Je?5b5\DA4aXOJg`alY>BlWO;iD9d0
9oSlQ3FAB;\kFF8qQA2K>6>8J=3:UNT`[RBSo4Y<f==84^E`h>PN9Mk27B\AjXV8
poBWkQGbE86R8CBj\eDRAm><DMB@NU`de1UdY5LG2P>f1>0;Xc<f`AL8W_WLO51I
hd;OPq?41IL?pC7lDk2SMMU1XHZ3Ld@\ALnBW8A9ZHY`9pQjWfEfmaMh[b5lN58F
SJbOq?dLE1YoIN7gDmj9bEL\\qVT_nc3G1FKSP1^@kPfh0TVWDIg6B:7SXYhqL`A
Il]bdkg=;VSnjCoW=62_@NDEfCFd7]OW_pQ507\BgqO?YfF\][dLR4d^0M=k_SbX
XRl7YHFLnGeI6@k0iJd?N=6X3gf_7kD28q\A<NCNZNj`IKgRFf0C?2>lL6J[Y;l9
USBV^BJS9574>Q4Sl7q5gT8PBf]mlA7>>nHiEn[0RZGNTYBSd3QRcc;U<al<Tee;
4S3h@a@UR><C4k;NTnjI_<OUApb1YQhggj3WbWo]i7MC`:bg_7g?C0Y]Oie;NOQ7
WbeSnp]3SVdVUqlh>h]IQ^PY0]ML8f0KL::PQ@Z1X;458n5N=g=Oo4O[mH6nA_FJ
Knc^;TbDZnnL>Z4IS4Pl]U\md>2P:?dPIM92pal7HI_Fpk^fO`XF;86F6L>jYVXT
ieGkD\0IYHRB>q4XX`jB6j<U>bg<Xd9Z]2?=AD<_bkMA3b1LU;?3^b89Mq@M8QR:
bPKUGGN@P_2]BH0_D@pMQPOB59qm`EY6K`qWQgRmMD5F\lWc=6No:H1^V:eGMbek
f5:n_iiaHpEd_OEUgqoO_eb^_BiToN7>8d^Vh7nkb8OeATNlBIK6Plmd5;Y05BRP
S_Td42XcYq>SAPH18j<Uf:18k::9>@965Z3Cdgm;gFF:o@C>OnbXbgTMj>pb`][]
6ClKQLC2O\a?T@Eb1C3Y1ci=?C;B=o8k^e<;C\qc<TdJA0m4=0dX4jA=dP[FXm_Y
1idbIgFG:]I09gb`EWU4G`@gB_d9FYZP^?0QZ\97lO6qM5\_ZGHqS`@O:\]i?<C8
<\7JH=^o>EMmblNjI3G;J]PJ?dbgA;J;[I6nh?LdNEVN8dN[P6<76a3EC74Bko:Z
;f[_YJW6MHaq4`8`Wj9qSnQ4gB_N]L:nK^nVM^>6CbS6bEX6C4GK[]h]GLAHOV:[
TOHf_j\DjNaJH_MOZ3mMKZTPbBaCHon3]4CA:9n=q`^Hl]G?TDH:[X2KkRE_jboJ
JS8_?FkX^<KWq9_cbhI;RLGj^niBAf`OG]Dfo:XHU8NYQE\Njf6P546QS0D`MZ>W
i`^e7QaBiNVYO>:^2Qia9LkQPo\pSV23LP5pj=5\YLdj?@oGdUk8NJ[3o7XNhe@4
mV0Qg<_gn5a_qYdoNNV^T6f`ah[@;Ug0Oq]^5O8fLqE=C1D^=qbRno\=[n\GmQJ?
VS_\lX8hCP?PTomBI6Fki]k>5;9EE5DdQUYDOp;g<<A1TJTWnl?;nK1IfGMIi[k1
k7D1`<TcqMVIBM:HNFYMi_Uh7AhGOd=ZgAIpTlEagJip6AOi]AXq[L?aSoJpFXA9
:g>G@a7OOV@8Ak3C]^b1kMA6_L0F=YD\\lFRq;h;8E6I_F\\@_UkUqNbn1o9T2n`
cRRhe]@IE^8=G>OVe5nabgT2a`nYHGbWMZp3]3D0Y;<b^94jVMFGHIL\=B^6^oIl
N2Ah<d@QC0mC\[n>\dAP3TR8HRYpD^T969UY=;;Sa@he<lfL_k3g\h>PT8OaI39X
3Oa04G:B7D\jJ[`@U9I^Mk1dqfkmXZ@2q<MNoiL@flJq2EQ]0e[SLbG;R?nLo_Fn
300l6I5hMiHbL3kCW1?UU@YY<\TPqkn;eAKPJZ>aKchfZl@9[Yh=OJQlZ<WHMOS@
Q]34hGc^E?KL5Cn7CO_DAfa`]ahSiJX@7`Q7pIJjcRiklLeTJQ;ePDlp`C4ATBSp
iMoTUcpJigk5Gd4InhE[^iWlNeIMGdJJ>XVJ0_PCR`j5dSkB@nJqeJd2]0\IZJjd
dO`33K>B7aU`G9KQMgDQYXgAAdUUXWc^qO>C<?R`1I\I^V?>bYU3fY^Cbc2fNMc4
2dn9UOS8D^[>:TI=XA5Vkb9^]`=pj59Tl\76Q:1^DdZVakEehU;UZl6LRjBJMV^b
M[k0k^k9eI3_PM3R02<kpC0k6F=`T0KGgF[Ck><[AU0^AEYe5lgCdBkePRQk]LFg
8dhM]h]`RMLCa\8iOqGHD>XcEp<iNO]dcQYWpHo=d7O?@b[3^YSTllFd<CIAVlJ]
3U5`g2fh1:gCN3i=aO[C;LUT6qPBBKmRU]`Pi=j]dhi45d8E`MijQJedg^b;UhR7
f^2@2E79ccF@SV_hHR_IUS\fSD:[hi2WS8E:_q;6_c6Y4qCnEFL?pZMHQVfMJZ1X
XO`21DG:a;^@Zmg3PGdZmKcmVAddl]cPF<@MBAThHKPakBhfq6`ALB0`dGNF3k2@
kUOG<2nJ0VcoCe6iWn`W@X9;<[9;=p^A:i??Ol0iK1hiLn_IAHVkZT_Z9oYS[5oi
[Cn3`S18Kophb1GFKaLQYCGc9UY;^6WB0RKQ8Od\PLNEbZ0Ld^CmDIX=ABRX0JVP
c3LqMh`=KG]5J<GK[BIoJFSgg9Mj9^6ahVoIC1^Uj<cAieY:P]8S9Nh=<XqWGY`C
91c9`HK=8RaU^JSbF>BdH]jVMnabA6E^egWiQdBBJ?;M\7V?_lUSk`7qFP=[MU`q
jdgN_77YYBqkmB?OoOK3UN0oa?kW^c;kiad^@AXaZ@0eK_NE3oea_f5X7BaNPSBq
YF8>k8Xja_:3SVCBIZhW6>M@j:b_H^ambG04MD_\FlFgnR_lhQ`oToM4fGenE80E
0iM`NhiO9oDq=mD[Kn@p_@>Dh6$
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
