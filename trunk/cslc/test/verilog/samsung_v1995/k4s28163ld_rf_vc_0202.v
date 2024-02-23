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

`define M128
`define MOB25V
`define LVTTL
`define NBANK4
`define MOBILE
`define X16


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
JK]<0U&89=>3(3X^9@gF<?g8,bB0,1O<=>g)<&Wg0P6C1VV=L69.(Q#4-6Q/=_Wd
B9F[;_E#-.^:)=:Z1N6WN0SGWZLIUAYQVCA.&/O?=@<.7Ne]c9#(J:f(Ta+I@(7N
ACW0XJX5LSIdY9aK76K]#6_MUAH6>;7I/PB/M&==R7ga7RZ46J]eSd4eQ_cGO:A>
T>JBXTB28D,S_.ZC^cQHYCPd_[f[b.92RXC3#@gIb/8@6#KLBZBB)^b\O@Fe7K@(
P3d)^_A..B))Zbg5HKZG(H0D.S#=FFY<?4.EU>MfcV8IY3VdW?=@(Q7^Jf>+LL[J
/?bG@EedHF5+?cN3a(W7:VS-8dQ.JSXQ_Z\ZB2F&NgYP:&NEZBgKR6;=:AQ9L;RA
&MKZa>4P5U.bA5)J\fb&aP&HH4aPdB>.&]6(EMNZb03YSP,7;[J2^V?XUX-Ua;I-
Pb#,&<ZLI[-a?P6EC7D0;R=8[P,32D2R0:(O17BW=E1\c6G/US^E80M(07=g8DQ?
B#G5=8_]Y2K4O>T_1T\9DDfCKM?&24eB:0UMYHL<??aA5[_3<cX>P1UTN;Y>NKcB
<+aTe(4POHS,OQ5#SZ7A1Q:\9EIYHKFGN#<abDW.C7G[(E_c:M58c,FPE5Z#FCd@
;_5K]?0@0J7D.\M)Z68ZD^T@R50&OQ,\>=#E&156<Z=T;/K2L.VW1f_e?,9AM<cE
a/F(VMF9\7#1f:3>YS_J0?\fBK6L)GaOF)UY6R;\V-YBL30-0S/1Q5VFJV1CIHDc
Lb5,/9TZ(7DHULT,\C)6F^=;bB#bCTLJa[CCB&D.421V0&&HQZW0IRI^:Q,:;\4_
\(IHFAS0DcZV+5USVIAB\G^SRR+=XJ^JM)[AVN0#^9.9DVX2\Ke6Kac4^Z#ag>NH
2YRLc>XM?b@V#=/Y?&9cR0cVSD2#<=]\]a#<E.G1IC3bNC6/b2A,)TB-\R,;S+J2
,U^;-H#\F<:RS>9\bDQ:CL=3Je^;K2N2Ae/PJP2\eQN?I-+24:fUV+,#eNGDMAPV
Y]/V1a\,HQQ(O:UWQONC87a^b]V.4RIE7J=VBO8)@00+P/DRg03IT=]=I7BLJ=AT
Ad#L7BRSVg)7(;5B>Xe6PT=YPbNVB8#-[P5b1f+L=),QB01AfF;(KY_O<)#IK&U.
Z2Ff-=)@0+W?afBXJ6fa=gU-HGM-E]W4[]Y,F1/(;S<IG<=gNd78bZNgB:c2SK;.
a;3-d=d;_R1NfF?>;?)3YL2W7-M5E3RfEU3&^4Q+(,EM>eE?V36#=IQS_DO24-#<
QNaB/Q92ZLBS?3+]:+^FKBS=4]\O0ZM9M&AaK\,.Z<\(;6KZLdOIdYP50]>MD9?H
E6-7F3KC(]D3PH2/Y0J61L/M[L]^3-\\Je58?DG1V08C0BbDbW?#0NS(=)N0=9,2
-9VE.YH6MDe&)V;5\)JG;??N8d^(_Va9?PKa,<bAQ0M=A\aEN@7/d@C/B\a;DK#I
UNeNDg@7[6X?,POBD)1[ME\26b@IA@HfKe5F<MV4bcYcD6JJR>XM;&2>VD<@b.Q0
\7>V8LV0&C]gfM5SdH);D^+NXLIM9GdLVK,H>LaA\4bUO4W7a(ABZ_W)._04eM#I
A2SReI.]QUP(Q_:\8=LEY;BW@#((_V(^3bc.J_/9JC/QXSG],CIUe;M)3d)J+:C;
UTU.BMT>UPIJ,e(Q8LZ?^Z;1FYVMOXE_bEgS<.ELaU/1cd^ZT934=U/QRe9L3G,/
7]4)QD6EUAH4?TABeQCZDUZH66_DK((>A7-I6K5T4;F]F(Y<HR@7H4Y;a&MEa\Z<
d^gdd<\Je0YK-4DfUMd_K,2#6[4>O?Z4YfCOSC=cA3ebaG?ANFF=-E6)_I9e5SSF
B514J+MVC_/6^E\(0T)2(P)Xb[G,5S66?$
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
gZ)PN41G5./e-#_U<?]\-77=,gXD1H(,(.)99^L/8/4:A7^gR?1W<:Y0(@dW)Rb+
6[>5DC<S60NGJS(.P49+?7D_-#.3N>C9N9N-.?Y1T0T3RAfI:L9MU\:TFO:,N^4A
(Q=eH)aYW]YYbM[S_R)KFGB;N3M[=?-;7P/XZ[1dcYe2>@2;TcW@88(ZIDASJ&E9
-#bDVJS&2Y/eENR>/Mb5+Rg<#gf,1&J;3=)eD>QT0D@#A5,[MHLdd&>^^L0Z039[
E]R5&eF@4SI7Q0TV?[41C6g1Q-I#ZPL@Q>:11YJ,ITD2?\IK8NB-CMT-0fBSF:OR
9-Y@MPdA.9XR.>:83/E95TY\VdEK.[JG&\SKU9P\?X@5BTOYYN<<T1?GG/?J4WK>
d&+B?FSRI28&C;G_NS_E4EG:6g5XYB:6Q?VHV<08[b8F3L]gBDSWDce.T7O+XUGW
RGg6IMKUSY-(3[[&#5e6KWLOTf20MJ].B1?S7[G@eL)cf3ZN;H:(@_Y-L_1f1+C_
MUK,IPZ7JYR0FM28/A3^+H6L[P-V4d).=U84KK?O@Q46GG:JNXB=bAO#G#(D3>Q-
Y,B=aY?fN\?D0>M5_39a0bFC[Ra;A:XNO63&(R\3@f1T6+d:?97:S&<XO8gJA4P@
Z(6LZZ/dTcPE?)NgL=E#:.);c2P9eGZUNec4=+c2#HXMTNY1DJ&5:gS.7(FeN4>-
T2QN(@_SX-8cT1P>ACR^:cJB<C:Mb^G1+_AHS60VHPCADFa&A#fFV(.)9&[H1W=4
&\5>IfUZ]QUN>.>]@GD>4UC.>8CZVW;UVd&XNd.-S<FN@Gb^OYXGae[f>AWcfDFU
ENU4O0/aKH#P+#YB2:K&B@@2>2X]&e#5aX8?g]_5:5e]?1SXT0O.GUb0fJ?+VcWg
E6Of0;OWeFNVYA2X)[+7?9O7bTLA-?Y]cKE:ZMGV>e,65-T6.+2^V3aIE(_79KM4
-Z##^>EEK+(?)a,^b2E=)M@T-#XWR]+.Q68K&O::R(/@eDc?E<gc#_<8H2,c)#A(
T^<RP7O#9\#B^<OQ[DH\V>I.G^+JdCg]V,HJ9)N#dBZ=Z.5PXTV:8dF[bH],b&WE
&1KNRFNQWTS_ZN<=;9@EGf;bX+8[Q-d&3=;J3ZV.c@U4G:E\,9:=6[W2g(#?Q4B1
(R^OV@EN@ZX)&O7D.5=F<bM(VG5664d+E/7LYI=(ON,>1KFY8FXTI-cd[d^JS2f#
V&_-(fARf7(YDQF;[AeEP.8,\K2_@144#c@ceJG68:8]PNa-\?4/ZI=:@Y5KYLH-
L4\\#Ma/:eKH]ee[8gK>/MMeN+:Q(3aeR+../BScG=CXXINCF.<Y7c#02L6=PO,]
-50[3g/g/1EX>>fP.N3H[f_.P5gL@BQ87]Lde+TN/E<a?54@f5ba),,0_d<TMK;A
^.?KZGCYN\L2CW>M[dPPL8a(N#TgAF98._67PR4:ff#FW=X7SJJP6?/[-UdAOPUP
[IBNLJ/@PT=GE/&>THb)3&QNaFB)6[=D]]NGVe.4GJa7BeNA_YPZL4LQ+(DR]f^Q
61V?0O)U36PAMF@BF96T3S@,.eGe_0PA1HG>C//#S)N8,.d[^dNO/CP7_S1g5&IZ
[4fOO3=5PQWNGG4Z(VA0NC27:gb/^eL.&U?^<N9;MGE.(N<Ed@c6B^)+EU8W>B\.
_G#M#^8^N7X#1Q;;.N<dW?/C1a:P0[QG_2:R<IQg86.365]>+4e@CF?4fD6Y;2K2
gb4[C+I33,C&2L/9ad^V\9/GL>8./U3;]c:Z-,S-5PL5-&2_+bK(4F(?>fU5KV]I
WYHP/<;;L1R3)T/?JVYQBL[JR[eE(WdLRW?CU)cJ@:D#T4G[AU@KIEK=QNH4g-V@
[fUM5P0bD(-8&(M7^;f-&7aDAE.]NQ&S5Ja&P>D-;(f_WJQ902WS[:Kc]NUMf_+@
2EJ38]<#S46C:^1M:T8JB=20+6.</M84&_gXXBQ/V7@SEb)4GAX<+NP6cOCY=+8K
]H^Kgf^:M(,ZN==^.Y2,g:8ODM?<:DU?4_STU:5.e3^ae>PTe5_ZMB9GF9PF<N#=
:fD4<5K234@K(361<;L9_6(NcXVG7G_]J2=a)bM\(PDJFeccYH6A:M9,L5P5W.5F
1M^bQ\4EWQgg)QO)[S@c+T-M]L^R<\cE<Q5<>/D)GTFVC[)77ILY-Na-;F2],=[G
YQL>QZ4I,3Ob4HX34V^L,#)g8@=M>L1R^GW37S+5ZfO_+#=4cIgGCG12@f=Q3+VN
\>YXUK<VSgc(725I.?47N(,P3SE?/RGedQT+XNeIO3NK;Md@6VPXfOISM]M9(H\:
6CN)N[BS>FTO?8?f<a=c0:O4[/CJ##SOXW<=9VU8A(JAN]?L1fZ,\/X<S?PT,U_C
]Qe.DgRW+0Y/=c/M0;\\9J/a7aMbG2<DI6#Y3Wf\&AFPB=g-IOYR=CQVZ[3ARP3V
V<]/S&]@]1cUB1_HXfX2U7WY_/V^Q7+fRGd8^.1/a_/F_4^^(d]eUU7+&&Mc>OO1
F335V?Pd:Z)bTIQQ]<\T8G/gQR9P[R1@3K75L+:M#M5&59f2.bNYLOOcbYfN:a^/
H<;SJ\>.==,/dGeg_<00gTDM>[D7P&5#/&,QQYX;e@gXTGMPF.67:7,4J(?449(:
EC@SD]V_6\;?DY>WdLE7;_\GYE:Lb5B\NK3WW),MGDZYO5&6.<b]T^P(a5;-?VcG
Y10)B;58LQcT3g;2E?E6.KYT=>1BT126f:6Z5FLA2)NR,P24RN-b=gC53D9(gQA@
@g?aNH;^P7_N1JD2T]QCH>a#gBK:DVY\<F=OWZ:>46R/NAHc?S9EO.0L?8PSK(^0
BB-HL9d/J.AIGeKZ5US&b0J7OU8&A;6#-+4#V9=#9@UNa;&WJ0W:@:KT^]DQ_[=6
YS5?3K6=(PFR&Q[c06HC9D0)a37HB51M0LODIM\\IedT]8+<4[2FN4>g<]BHR>RE
BJ+9#\II0ZDR0$
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
d1Q4E]Y/8:G4<,Ee9Je996^c(\Bb=FAU8,W_8O-X@ZP-7ebd7L1I)DA#<Z3T8[=3
3C[YT1[2MQgK1^:H7VY9F8WKA4>)gC1fg?R#1N4-]Q4/S?(>NaF;0Z=-+VNGUB\>
e//;X381/QAZ3&^IE(B?&OJ[;N]:bOaO__BZ8b<9VR(BBbC3=<.N;d;cb;abN-N4
CRQFCP-4e-(JdD3_^@<GS;-g5R.D8BF/2[SB\FW^8FD\D(=M5eAV/bCD7\b\QE49
4a@R+f+G1:?&Ve.MBRdGdMOTN?5?IPgNGY]E5X6VI(MfIIfJ;Sd0\AG]1>SLGK1G
92@ZKJW6/P(\8IC/8;<ZL[)a;b[]fUe[f/FXJ92C3()2N1_V&QU>ZVee<JC&-;Qc
^c<eYG373>X\[b:?CYKC5@(\EBF?YNQ=D7W&JMdeL&&MBEg5c:^J<P9O\f_fV,FP
?0+A3(V9]=MXdE-,UAS.)Z,Sb)[MD8g#([Y0fN6K5TXCTTVLK,eEGND8Ed:5TP94
QT+S?CW7fN23)^@)Z8G8;WE<-;dV3A2&E0D?<)J/^a4?;aY+;.5298?\7KTSU-Kg
ET;b&DB#YgV)Z0SbCce\UY/WDB0D1<gTe>#QN>)4,)R;bRFV@BYQ08534YPRf^SD
_MQ]N^+\),cK#J>Z[g>^0O@ICJ2(d>b>OOP3-,U6KH=H4GfRKfQHEc(.e3eU\BB-
)R1;c&fGP/&VN86(I0\1H4Fe)1X&NYDJ0X=KI&?P\V<J79>[3>?/AK>&K@2D]2FN
Z?4<WTNg-Q7bU4A6Qb]6eF1a>GTdS,H&=DOM[3G?a=K6b?<A,fOTS#V20a]Pa4LG
U,ZCWJA+_C3KSL_9bEMd(>:-Rfb9J,QV;dGQTDT[(2N4\M30)I/c\.KC55e8B.<&
I>IBM-..dEe0b9;&fGcFV@1RfL&L+G]54_fCBJ5&)D+bHDE18@<c+_=c#B9I.Q3N
_>.Q3MF\K,UK&aS5ID:&EaPd#(;+\g+IU)46RT@>[P;,,b?AD]83(Y^>W\7a+[J^
D_T2)G7;0<Pa.@,e/CROa3:GS#]D,9<g_3;3NZ)O\HK\XNfX0.L1)Ig&d66^7T.G
D)Y&38&b@3KHO1,DFG/=O7-VO[Q86eQB@HY#]-&40f#+4>:\5I><H8ZW-,3ARHJ(
Ve3SHAIQG@#_0+YJIdWcP#56c6(@WNN:<JIE9c.8I<+Vg6XW6NP-ZF->>U3@JI+J
K0BaE0/<>>_DcG7?:2Z#71N?E9VB:\YMO4/#+Z7J6c5^Yc/N8(1GaLOaPg#;G.^,
Z&^dQ,@#W;M)&bV([,D3DYU[EG9EZ>4G43A:(T>g+7^0.@cK]&/Q>A5a[AebMZHX
X&/Df4JXW\cc.daN+L81aV_>XOR[^Xf[2f5aZW@CdfCBP:c_<Gg0MULeR6>9)X6^
?c&a]aXJ:(g^^3DfK.HNX7b2151<DVHcP-f#SSA]e\a@NW4L1UcNcfCG73&()e.g
G:VTLKIL33bG=HgRbR8@@SJ.RbI/Fa];3b9@<c@G_8g+gU3PgCgP?QYF06>R\)d2
M6>9)?#d8/85FaT)89O,P^6S]bWc^1;@cVcG1fTO8KSc6K@^&JG.3,80YX#^6^HF
3V9S3dVe/+d_E5W>dVa_S7[2Ab417a.+_Vf0.[H-6Z\4+3>/+N;Z)a.W5bNb\<@5
/>XP_EI^J)9?L^C?O(3\,C[/dK1UK/U-8];62)^U(E?4JVP^bD;_X/VJ\\ZYV@5L
#PQK7feHbK/8FQ(CaMC73,Y]T9UE<J<3]3=15eUCI,7^CWQ5aD\=2ULN7-=>dP=?
3JW?B<V8:gP?AX2V>R1,CBe9&HM@&=@PH9V5N>?<D?BeE,cJ:JJ+A04Ja]Z]2Q+_
b\@<N15IIdba_H+bJSY=4NGe++NQ<Q]+2aD=XDT&KI[J5WM-\-.eMCD5Ba&V,0?G
6<LF(;9f2PCTR]I)/46^e>R;J^d1,CT.0@+JH36c+Z[Q9ggR[d3/)X5PXV7THYR?
CT=Dab0AQAOAFW:KBSd(bff@-8>SG#OSfRV9^gJNYKA?OPC/Q5JRg&M/f^\V71=3
3U45YPE;)VBE:<\BgSZZa\QYbUKXUQS^DHR?8(?_H3#327aBLOL]BT:H91@IAJ1d
WHIOPOGIe+aTTY_]3=ZBKeC&IWg8WMW(7f2UL.f\0]6;CBF)X?cVM6V^C/Q;D<V3
<;?XM=Q.dN]5./4;6a5CBU8:P4<HCdG9fTAYe,SFQ8Y_/2=I,.]B4;3f.W^cb3A^
@X\BL>;D#2c9e5Z\BbTOVHU[I9D@F[(FNZWUW1.-;)HdSN8BZRWQ3RIC>S=LBQ94
/ZRbV=0TaG=F@XA3(eNV_Ug6.b,?c4HI;g)#3OB>&G?Je&3S.O-#2fA/^>:-/3+e
AZLb>-89/T.K]L?V@SRG3?=]e;Gc1CEc#g8ddW@-U06_Nd3NF<2OW1XX5b+1GN2I
0Y;YV=97OGJ(I<3MK1?VC,O^JXG8#L.5?0EgDc;?<1P#Z6\8b1GJSLA<gLGB534E
0+A&&-\OGN7/3<0.N(3^PP\G/PR-)H<8cN8EN.c)?+K,#e3(S)S8U#/#:7;G;MJS
+GN.R?MIUAYJ3[#f-BZZ\,L+3JI>A[V^_#S0FVF<ab99gF?&^/MI#6gHd&>]@W;;
S3?&/1I8.gS763_3-N=a<#0N/@P8&[B]].bD4<Pb4LILE2=.VMc.T;+afK_ODOWg
bWYQ(dXJ[4,/YEA-c,a9BKA&g,a3DVCNLH(1(T7\/3F[fR,@JI.(e]L#T)g,L)[+
G]VCbeM>dXHGAYTgeI:RR[Xg5-XLBCM#b+LMD)afF(IgD?@AJ=(2BJ;8CU2)P/90
:PQ@g(SU50IW^5/]M(8@=M[X6CE-:_03Q8fg>X>BK2I,b+DA,;1-D64H[8-B9>^K
A0E0_4VD@-eGB9Q\Ta)WT@?R7S2?d,\.0;:FA72L^]2T6R#R<0bSU&;<FE#dQK=(
[:.P^=fCB>YX;D#Wd8X@F]e1@735-/f.7OBQB79XM(1U=IcQH:=<>N?fF+R^TF8>
ea]>@ECd],P3.EFUJe@eTDA;#71;3]OCKZg<NZ96E>Gg-C#6PC,2A4:KO7^SXW-5
(JFCJb#SAfS1U#\5##[F?S+dAd5c?9JfS]UXN/+Y&8S?QOL>)Z9K>W6D_?bCZ9[O
QC?NgHVITJ1+L[DM.R)QD>Wda1-7@(46O\7L6T&b.Ma=[]93Zb(5U)&a]-&_^VR\
51gX)gG<e?P26)1SU&F:,(_4a@)L#N+:169E0X1G64bEb]HbX>]/WPfH8?^65YUP
(D2/HB3cGLJ@2B5/LdeLe?.-J3&<QG]:K(GO6^T8E0W3^Q)E_5+17KX?-I&I#W.H
AIgKUADKG),VYg@gRJgaX9?fFQJ3(C^+=]e004..W&9c;7eH]/ZT=6,U+Fe9H6:d
QWLN_ER+,DgF@36>T8:g&@UA<XH,N4>)4P18]/7MC@1DC)@:c;bc_F:0G+eb>e82
HMUBZ=acRYW__;1E&OcXA7g<:DLAI>;R<UO5HVV1e6L0J](K2KHI3G,f+^/36/5Y
K2cB)cJ9/a3/HE&;/4WR8J-\MK,\_Kb@R3QZVY^](P\D.8&]?FP1S)6.#2_DINA>
Ce/?a_a<g+7F58T/4J<?A.)XP75LY0L7@Y4L&VS;)ZI5R3\BBcX1FTU@9P81KS(;
?=6aNMaVB)F]_OY4-Sc-f<CA_:Z>MVIb._@K>4I3&d6BXNUP:D2X8</-P1_S5=<\
93[;Y<QIS:_X(&D6UT-0=_AY/3?gcc\\G1N8a&D6;2CKB+[f\;=Nag\.J\>2gO+3
[<5]>9(fD4X=+Q[-M3aeFc60/VZ^/Z:]>?LV.D^I&ea^D8TO)B2S+K[IZ7K(>cYb
&;@5HFTJJcE87^+/9Q[Y4fI0,>fUEMb>)Y-#gX1d28QIQ2-JJg#QB:M86C(I&A#4
719H2fJH\CKG=><SP,,gXHZ<L].]4dUIM7a;@\PV-?2\\=J949QU7W8;g;IZe.Mc
+Q+\Ja^#-3W43K)e\-PM_YF8PL:N2^K2_LQcF=_DN9&(8DC+-ggfTR8SMD(J19U1
gF48R__2=<DcS]b),7)[5b/C^W+Q4;V+(L5^0Y^EDL.E+_Y-#E-J/b6OSR3&OZRQ
4(6W+U&gCC(eP9BSa^P3P,4[aD+M648;O#C0(-\-[]Y9ACdJT5()eJH.R)(_Ub9;
S4J5A&>d;JgUHUMCP)ACYWU4ON/8Z[\#WXdD;[,2S?X2D<SY2d6PYUOL#3gZ^B@;
4BgZKHgF)[H[S6-aP)4GHW\fYYQ@H38RO\T=2M;JCZ]\?V54H(9cJQ(@Q3I?MC2N
,\M>ZaL</=T,O&S9XPV0@/R#XBS#4\\OD3I@5K>1UQ?dbES;#L,_+BU_FF^A.MKb
:1PUF:Y6QYAE1.<MVbQ<7M:F[g:2dGV/_;Y]N?:,0bE\85(@-\/M\>QE4&>e=\51
-[e4Xg-;gcC7g>Wbf62KO/YQWMcbT]YRg5Jf=1DGQ:8S,09GL5a;E3+?ee9VD]A)
g56K[XEfE>1G)VIP2fef,-dV?6[<FY/:dBM0.YCKJYZS8eML)PGCdW=BN)SOa8Q-
NG>@S>E&WaOg)3FU&/TAAMJ&Q6\c2/,eS\cJBd:/0\<=<_\_XFf5423e@#=W(g]A
Q)9FOcB=5L\8A(1B=+.TgP+dgc360gb^EI.d(^[BCQbV(:W?959YE):)-P-IM=\-
40HNDJ_TSc)E.>LPD(2C+JM[8DXfRe(bH\PZ98@+.>Ob[N=(ea.JcBB#e;f-TOf&
NB4O:@2.0VdK>dU9RZQS1IV)gb:0UQ+R6E1A^#c.Y63LDHK7d5[#=2FG+PSX4@9E
dOP<KUG21&\M]E:JE&f2XW</CbA4EW-dRZH2]<<P#][gD,6-9^YWQ9Mg(W5+N<+&
\B=OU^@>0@T8MR9/fdGa7BaK,CB(9JOS/I>SEZQSNeYf9dc@;#A6D&^YB5[TR:1=
[Y@J5Xg?TG1RDMB^KV:,SM\=Lb6c6/N6<KE#QJX<Qd^<@5@:V1Sg)dD-bC2,cPM+
9(d#Ea:GeH_E(0/GM@U9Ie]0&BB>c=\V(Y>8d5QW0N(12\Q^L--)YaEZHDXG#e>B
NY:3LC.GHg543GJ\6Z:WBHZb@2f)dTOETI3N=G7\HVU1C2,GdY9N)9Z1GBB&TQ,R
;9/N,9Z7/,[:(6g2T]ZfCR_X4]Z5:84G7;c@9WX,/HXHB@Z#gR+1YM>-+]L,4c;=
ag,EO-R^#>[M#=(5.4NEQ/;ST2B:YPP#/13X:O:1H+@0aGSAP^[JQ2GCKEF.WYQH
AE1QW/0&7CPHWe<X<3F]^9)T089eGST8ZB7UXGXF?YR:@=W=:3dBb9E^g;aEYeKU
EdLVf(5SMcDJNCaF\9c9<SSd14g;AM#X^FL--7/PZ3)?_:Dd(,.N@RF_>TUEQ>#W
S1d8a[E:]A/<c-:Z7UZXFHE]Dg#0b\@8MZ/XEVP?Q?@CYHdMVS+8_B<&UKGJE<c&
?LKV:#=c&CeL0DD3/<>_SGN&66C@,7SPL2dTeC,VYP=FP(OV#+4YU-b_V8R0O8X7
=@.dB,P7d=N7cZE[8b=YJDC[;c6=@/\VSbNfQ;&7#T:IEGQQI^V;#W:ZNGWQ^CW;
VPVe)OPZ\#]</)@IO:L2RT->d8M?SV\GL@J+590Z9Jg5=R)W))Yb1QB656=KgW0:
Z5=T^ef[^&]]>DAM8=b2US]OWS3/-b,#IdH:DaE(2fR?W68#ZA#@V1[VK\cS;AHL
aKWVN#O/b>_6:f(9eZ&edE\&aeRc2KXR<F2UZX8I8WR0DXe(QM7IfP5S[U3gG[d.
O;HCAV0]9JA.;<+6+g]bggY^\P6?ZZBK:WI3:A95f2e]bX?aC8a/)cY)_9)GF2[U
YD3Ka3DU50)LD&bQ6gJMFU@:Ff6J3;Yb^@DOWU1g,d^K)^Q[0\48KTVF7DWIC@\g
X0VbJ27\F).<FW9bCQQ/#f,RTHJ>W6HfV3NeWHS3P.95+PQ^VMe_8LS+6dG2QN\D
KIgS?g<@41af2:6@9;(4cFcTE0BEd^5#<E_[G7@K:XISK)BdMgZ&&VE_<N8R8&U/
8SQcB>8U51bG-,S,69fU^eC(V,(61b89S)BVZZR]+,bI--fcNHgc6fYGa7Q=IFdR
X,YMTD3E1Xb-N\UMK\c/27:/Y@/?TG[Ac_XKLHV<R8B<=;33Og=OJeWcU2K_^VYB
A+1cBYUL2a@WFCHdXM^X>S/B;QP#:&d\@.6P5#L1(RLCaPad?[1.[UG+V3a+]bWb
:a970@19P8M=EA.d[TVf(<Kd-A(Y1TQ7d/KT(OU=R@XEbUZ#OfLJ^,e<H.GL0U^\
:d-E9C#I:f,Z>NS(G.c/QIgL)L.;bc-6-K=HY#<QL5,g5-#S^BF[+U+<9X.@DJ7Y
^ZH&HCS?WTN48Z\cXb<@C1WcH0@f:MDZCO^F:H0Lf4+A[-]93Y(A;L.5U07VaaEW
01UAMGgXI#D\Q/Q5.Vb4\gOc?cZ4FP9Y\H>/>8[\S8<I/eN^adD0PfD(^&@XP,Rg
O#(>QFDEW36cf9411M_52OV(?=P]#AKa-RA6M<a67d-TT5+X2OO,U1BGS#/8IF(^
.C1AFEEM?;)VeNTE\9d@cb[2X2Y9QC)-UXC2[_:R>X:JD#](XHQ0H5S;RSUDD\^<
PZ/I@H1&Xc2-:]>f0[eHA:CJWME;/YLW)W@/[RY<]W99a-ZYFAV4RHNAXV)cRMdB
H+9Z,0HG_B@5[XAe&U_G24ba7G2+X+d+eEb&12T-#X/JC8;QABX>/dUGV8CH,HYf
?^^N2F_HbYXL>Ja#QYF27K+fK,bABHLPfBD(.&;[MYNga7\6QY#Xdc[J-PSGDD#5
<1SUP_<AHST6U)PN54ed^Ya+,U/],9LV/BceD72^+8/Y^3&W1Bb),3#,Gf-+&W<I
)5?aMV2L,KeKA=+9TVQfe8@@IGXe62db@77.V]855A+d27^V^gE[<RaG&bKY&K-C
=V^-/Af,cXbZebF:)g,<Q+LaT3V]^A2W1W727,KY,6NH?AM<6eNF\WaGI$
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
eg#eHFd1P6I/-^)7,LP[<X?_8ESR,.VT8d8T<AR9(_UMK+<Zc00D-P,](),<,gUf
P-9YTA)U>#T]8/95^4N@;^7\=6XB\:eOR/8GM@I]\4PFc0+7Q(Z0BGV4GaN)>f3)
-X2QJ35>M7@T6;H&3bKTUbc2W?:D(K[>g8a#:K_01;7[4(H:O0(YX@g^_)MXO_>b
cQZ^5MS]F[XZ:?.d;a7NfVEBZ+X]Y2Z/+Tb-Wg&4XX4#DCP2PWF=g->P#QA04GgX
-:/<HeUgfSR\X:N4dP2dcbXF_:ZZ[/#,>\3Y/I@A&a2/\S?2G)L>T\AQR.:&\:7a
Oc@:9_?),V1&^[>Fc]79PD7NT6b]4b]g+YS&=/Zg4caf+g-aEcE6=BZgW1R?<?C=
[RaIGeU,dG9Y,4K5d)L,aJG;(WN0N;bT=Y16>a3?:aT2TAOOYX0c7U@ADQd6K^1I
.BI_AgX15]6X,-^YW<Z>:+RS0a[[RR,]R=C3)[>N(De;[agNS0<e/;YGOGg9II#?
?]0H3LUAdORYO92e4FDR=8G<IVfVU2QF@)YG&Ue870af,>S4FP/@RUM0T7bY7)AK
D>UccHPUEH\_a#J^PeP0<,.4>e@<)bXP\K@#4/Jd2YAKB5eHM,W=;.<@gHY(;W:3
[+W#bVMdMGT48T;.BSR]e;A_^?B29O(1Y1U9NHPF4:/ULb9dXV5.D3Kb#.UUa]-.
D,_a9g^9gT,.6Yb-Q)=@U;5LSLKEO=L.DOPf?.Z@6#Ab+]Z+X+O+[N<PIf#>/?UF
N=7X-e&4Dg=5L624V(>^7E9Q\@.P/3O<_G(T4A2;0[2N^U=6L:a7?+)GX/V\\_4T
()=EI/&1bd(LS9K>VP_Q?W^_;T8fDB&,ORK3L_^8&fd5:7N4)U4QeL_=FQHL(;J>
+&ZZE<??fGe=K:e8(=B2cU8,WBOG\-=B2Zd@FE:<A14e&IAYSH@3_5KEd5Y5BfNQ
+aL?71W9HgASC4@GL]c\NCg6+9?1VWM58N_^bPDG0^C:<9V5W58Q7AJdbJ3YTH00
Na[cf5:[dG:J(:K,]1SN8.U<>QS5X)fX\[50N?WY933USb8e<&CX3HH&d&f?Rg[Z
eWS]\RTd17NIKT0Z-(2:R+R5;K6([NbL39/DWD^TL9+F<JFCZ+093@(V2(82.Jeg
C5Le8ZYU25fX,G1.Z7W\cR@1FbXMXSc7V)0416C6F6[7Jc(1IL,G=T]RY;5Rdc)>
D&c/[FF7TYAJT38,24Gd(<g26NK<[B<#cSK/D]&O&)fMCH3D-(Tc8F3/fE_f9TSM
\0H8H0+1QJ(P?NZVK:-^F?)8G[bO;)aNd;GN0OL=U.W_&MD,ZQgAT7X4SS5K7c\B
Aaf:.+F:gYRZ518-FgP,U\JW^fXH8YQU,,S3#Mc4e7Ga(Z9cV8d(@PPX.>A]X96Y
Ib\\fGN;bYF^U>2XBA^^)EZ>dP3Y&1N/FDQJY7PAD:?128\92J2_BZ^RY-)=Z]ES
C,e0:Q5S&KR5=OJ[MB<[5Ua>:/0a6KN(,<AObH[#VEYS4+2E]1H&5YL>EeZLYZO,
O^8_KVWPYd&d2NR.&0@A83bG;>G_S9bIaVg\M\]QL5c_JAcETSWAOe@XJf.MAJ4@
V7(0U]&:]g,8[_DIEP#;LX)2X,TE>N2cD4+:TB&WXCMgYE36&gU]4SM=H^dEWZc_
G-:&I^RbA+@SHVYLS#HQ0c.-[41CM4=2];3[1e]W1>4.==>=M0?O5a?&\]a]A[:_
A6D)0NVg35a_W:[_L6NVaXVPRU6B?=D=,e1SSc,,e,J+XLZZ(:XKZY8:J9?.f,g>
W^3.3fdVbE7a6K.,)+BD0ONg79\g1OQC?V>W(Y]D7AA(&KH]GbX]1U59FR-(8ILA
UILFRCbBZC0<-f3&HXK@Z0V=0X\aVFC_@MB+Y53L5BRR._P\\Y3g<QJAUNF,N5CT
,Q[+Xb#-OPOb+/L08=SF3\#X8;=-;IU1I\:X:PNA2@X5]Q4_MGTBf6V7BM_R:(b]
LV=J#^aO&f3OATYOSd>Z_BNQ@Q3=Pa@N(Q^Qg.ZLVg=6JV>Y4Qd)HY277.17b#P]
:QX(D@/^_UQ5LKAD04f3:=?];#E2ODO;-a-GIS<8))^O+eVFVB0B_1KH+D9?6D;[
4aVfMTf(<2L^^U/?]6;&#DCRZSJA;E#e9cH&UP^P,PW;7-.#@?dNX:/G85YAAPbT
b4B-AG,&W#S@@)8;B>EUPK<:,H:O+;eIDZegXO37eaR4<2X1(Xee&]..P-/T9I3-
:S)B];;U>J?CUY>>fM7F;EeEL#;K:\EZ,4,bO[R3@P&)eV64WCM=&D(NXZ/&=XWH
^?J4#4(H3F7_1^WP^@4De.Sb08).<<3=b5UA2XZ9f4XeRUO16G0+U0gg?JR+]cV:
X5YGNBF3;JD&6E&/-6Gg/W^#WYDRYX?Bdg/8:C0GO^&07(&eXR>8JVA_gfg](b?f
25W6f=J0E-)D1B<706):LI9fEL1Q9J59bHN]fdL^HTaY1TVcS+1/R_,C=@LDa7+3
\NA_U^9dAM7Ge22#-Te_]M3>NKW;YT[0JgX7@B&Z@J2<]<@b<P9&YeMN(,6P<-)S
TSM:;WA(L4aOUTA4=8W(_X/4#ZD3]1g?_)[>e5+OR)Ke>]RZaH6R-Z4<6D#eFaPe
M4&?^:^TPRAa?:RB]+YBFI12K2XL-XKS:;Sd<,R>c:K.4@&,(P8fE\fc#,=JdE/Q
I=;I>H+68]5D^8SE[eE7WS&CXHXMZ,+GY+#<5d@&BdPS069(,MSLb.D33=YARB0E
CWBMC;Zb&g6[1D\X]3-cHZF,/Dg\E(J^RL^a@7_96SF&+YedQ\c)0/9/+Y=[.N<S
MRBY4.8N2QQ(CVP5L2/4R]S0-d;Yaf7I7Tg9ZeJ5O:2<<WFT5/Y#8\^34UR?.\B7
&Cf<<g+TZW4A),,6f#<.PSVDG;W5I;UMB]eRHPT[afB[K37-KLDR^_B93J:gPLY+
1>&g]3RN62a^KG.HH)+>X2+D+eKTRLL2V/3a=A^8NB,AH>3?\[QIdeXX;HfPa^Ic
I.A_.^NfJbad7PQ@[UWGA=Q6NH+bfB?KL-@g2cUG4][12/8a+7MGd+3aAb-3T]Ma
NT[PgJ@3EL#-@?RE;GfMeQ\CN)K=O4@RKEFfCUS@0@9PP4VVaJ(f4(3aP$
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
J4#PGD8Z]cbe=/+3=+/]))32)\8N-W8F(+7D(g>U6W73T=Y^S_&L,3JO83Z?9=T9
-EXY4d4K@]V2776<1OSbD>?3ZQ\@0R[LcH(afI8+b]6\K=UffgL_)7e4E#J+\?cM
P?cbP59K2d?K&=9<]_@FF9,-fd;];U8_D-IS?A?+PTcDO;.1&&<LJ:bN&S8b:G8@
0U7[(H?5&8fE,#WY3c^I1Xg8KXH\R@)g9._KbCN/IUUU/]F\c?N8Q?cQf+K>[U+_
Bf4PP5G\O3D\Ke^KBQOL9D(CdPN5ST&KDAQ]be:b?,CD2d8K,[-X[;ZG4ZAJW8WT
]ZZ\8]#9g3T@UVAFbT@4X]_V4_[c3KTT;A+RTZSH:0K0c=E05HQ)FTHT9=Z\ZD@N
>IPfcHAF.45T(BAI:&7.41fL&@WZ+UBdd5\cDOI1/OF^GDCeJ]7N7@=2PbB7VZMD
Q2RRg+7=TJe6PWERa=eK@Ub#J_HJTDBgY7GAFeAM/R/HCAU_1XS]?1F@0H.LGGAL
1CSJV;G63P,8UA6Ea+EQCLM.M3)#X4:@c@)D5?-g?87;f4aE<(_,L8:Z,Y==X6V\
-DTb)/_F8V]_+bVUM0HFZ0-JT?C<IW&cN6Z+@7QaNW4WSEeUb7]<N-S[eO,UZEbI
OB^^,?cSE;1UXe5gEa+e/^9S]\W\2D4S&Ae591.52AQ2e/a_3YE=NbHL[fc4^:HN
4)IE3P_6Ic96A@_,dfT:.gCc6S8X@YI4d+Z)cDaF\P.X(9,Ce<W=4R8F]0egH8>S
)]A/0HS0_M\M+CA^#=YYPQc7<R8f^A2YDHOLAZgPEOG,WdWa;^&IDd.M,4LLb+N)
fPeIEfHe-=b7JIHL[a),QO98ZAH8.aB4@deO6.]4U9Y9V1MEfZ[]S8_fPEUdPM9W
125MEJ,<]61K?I+DW?ULHSL1F3-W1gJ+ON[1C5)2cK0GN754KUg-d@W=4\#8b0Z@
ZcJ,,[;(O,3^CD(?Xd-:M3bI)Bge0F^S[-Q(?..Y-==+7DJ.QP]V]@K#)KcON:E=
4H4VKNe-Z.^TB6K]-&O.G7DE:(eO?P?LRS;/&E?f3#?]G@]UB_fAc)#BNJQL(Q/H
bDfS:gBPab..Q[d&Mc,6(Y7^V.bNOX]a35@/)E=O8b-##U)7,R9TCeNB/ccBGOO:
K<b\QZ835D6Dg/VH9_2+K0=H8OX_;KYT1ZM3EI3\f)d,-dKA@408@>XL+90QEICB
G?4.]U15=>7.&]+<X]:.C=VEd#F,;gSDQAPX0c+0LcgaffF:]M.YAD<JUGTSE:FN
Off:6E.V=N:?_W1@O\?7E9a<gI(E>(<7B1-&9bEO=)4)8=c.cZc+eCSa:8F#3Q[&
:MI+JU/,M@BC82L]WS&S@C=IaXX>-9g9+/7B4FV^\_[DYN?DR0U\ZB;U&d(e8TbQ
+6N+MXBVTCG=7LUB>6VW],T](\GDcT,;PCJLc60A9QF-ZK2SUMeQ;KSA7a73Z.VQ
5SG_=M:\+]ITNK)9?N[7fI.2&b-UBg#?GBd8&c,Qa,(EM?C3bCgef::03Te(KBJ=
LYGe+L=>#CICcG(fASEeB0Y4].NN&G#[.JFRF]G9_a<cPSXb_G+9KM]_OR;/Pa;3
B3-@M9C;:)fgR2T8X9.Uf,3WAVA3.OTH_H#eO^c>)2=7ga^CEeFG=5@7X=SY3LUJ
\G:2)IPX,+<0&7Q^9<Ag9K:15,=J7c8G6S7][0)Z6U5gg,=R[L_\FAODFX0b)^3D
VTQ=-=bP4dc+,5a=WD5XIa/M_T[0aZ<S&R2\Rd^7d=_I.c7Vd:4LXVac26gg[;G&
6KV:CO87IJ6?IB+A9>[RA2HB7Dg3HDe,Z9L0&VTMG1L6Hc2JJ##Ed(P1KYONWGSQ
VE:EfD[0TgA:.f1L;^<6c+-:B.e9?U.JEHPZFa>/1JP++/:M^g:TdS:;>3X;LOUa
VH/7,9:=+KEJM8O2LK8(]DdC8@/PQA\H);XeO=ADBXMQ+VPU45UfF5T(-WF:[^R<
f&OF1d2(:[Y=9<7F]=P>?=(Kc]SR-P#F3.C0./JXDgZUV0CY7V^+Z:/DDLJ_K^;C
OgXG2e##FdQ<9Nf)0aNgI]9&LTM>:X):LR&.6(&KR[I2-aH/1P6L>(g,2H0QW-VT
IF;@GYAFdKe_bYEgG-3+BH5?73d.40-=3?R4ee^W.02_9]]191eO>&eZ<6eKM:C1
;/9U<.5I7V75C&Z),6G/TZLM7AF=E^-O4((#O3+g8/<I]g\CSU2J#b_aKNIXR#]M
B8cT<P83Ig^a7)e/_VV^)Y0B(:.]eaAI3+_</S/IDN(KCH/<Ied9\;9O7RVeCfg_
cG^_\L@K&,G7^_;ffPV_W_,_b#3?KaI,9d88f@<&@d;R^5@^2Ig#2[,^cEZaFB8O
AFe<J<J1/<^@S=4^]CT#N&EJ2R<;S[(6\6J](05\c\=B65[5P@G-E?bIP)L3C0gW
[(LBQ&5;TcP=8(14_&bR3/bg89O>E3L=Z_H&RQ6^Y9ZD)QS^FY:E0M4)>QY(4FC9
G&35a28R0>_D8JG-0C0E:1]L5c;ZM/Y+1O&<52(B.L_eIZBc>aTf61Q>g34VY/XN
ATNV+-AHTSTT-Dg.XQXUDO(^;J-,&J(3D0a[b7P7Y?e\e\gX,L2)HKFJ=ZW:P&D^
L75)_^RU1^YPT,b-BTWKWT73FP9V/+J12[O&RLQ,=[/QIE=A\WH4:0c]=bG-,PM2
bR1X2[cY<#eAH/])UD8;,V.<b@>S;@?&W(L6.V/B4SF]_P]F;:@THWETg?GIT=/c
L-/5E0IAQ02ZS_9DE4[RbWUX#cgD3BAFW&^1>[\deDL&[QTQHULE>AN0D<]3f82\
bUgW43.=4E3@GK>5K>2&bK?Pf0_d.gFJNPYbb>E^bIF#,9O-adL)U/6K#R)+Bd2A
gf&bdHd2b5eC0DfKL^3L4W1&f<_I\M2-NMWXZ=:MD<2]VNV;0QIS=g\X<+41<H)[
ZAM)39SZH<&b2103Q3U9DZ#E2Ne;>^M(-O<GU)7]O.?N8^Le4H1=>/e>FTVA1KVF
F;/5f5e2ga3<[ZB(#f2U,GG;F;cEAd15D1dgL>@::SATKM+-+7G=;dOZY8=e?L=M
JZ2/[O<[LUPL;)VEg:J3LAV.AaK80?/35\\fI6RIF3\W+EfJ,;Kb6>O0,eQ)@<65
Xg,H),27gT&]=e0U3SE(^Q\(e^,L6-I,AUR5.a3;NV[7FSBBM)E]F0Y(XD8-DV6E
94S2T-UK(C(11GJ]8Q+-fQB<FO\>gbbB4^>gU)@GeF.7XZg#T@0(L\_Hf0_67/3d
NR^+,T7:.DROZG=4WJ:P_^-5-:)VL,WK6M.[9Qe65MZZaYT/M/R5NKgYb3T=N.SR
0Z>e<O<ZST9gQJ[>\^@E-\ZgH)3]9Sf&HBYH:#&_E78VD.&AK8QO2f^J:IZcI_LE
XH_fZ0gYC:><0TfM(+AF)O8^Q0>e);-R_-]bI#b+g)0Q8L1+=,<8LK<B->/K9db9
;=@7cY1UfW<9#AWIA9@M^[+1H9<S@X;-=:U9X[>IX#8R]C5S;GJ>O961:\=LR_F^
)]CJ)Z9?>EbY9efL@:dHfV[,Z94=aK8VV57J)NH1ZT933E-)K8_W7GW6+LY(WO()
EEAQL>cH<7&L\HX:(:.AU5FgIa/0;[CUFDKCOdH;872(MJ<J#]XJ.8c,2bK^ZWC\
WHV^bdLFI@F-+6OO,R&>ZNGL,^](;<TVXR(^,<IQ:7K@<#fQe#(V([;3a42Od8/U
/BL.22D<SSNB9-.U0gB<-G#>FU(M^cdN0+L),Q<XL&RO4W+G3g7<g\9;Y2>DREfR
TJO/6Q8#aA+d@DNB7fE4O]\+F2Z?WbcM9Ne_6c<8Xc5=H-ODAEAPH6fe[8D5VTGR
W<1\K@5W&d_CE&fTYP>,O+e\ALDG6bR]\aJJST)e/[]KJHN48];1TRI[bN_I_+KS
&#[^Z=NW-1eI0;fSR<SKPf(1aNBDFQ=Pb104\QL8^&;VR+Y7M;fHa5;M9_6TB8g\
)CB-[VV8@6ST7W6F[UJOH_fAWS/1g_WZR#=9N(G7RfXTa<HW</CV;W6#cV<ZC8FK
;D8TfYRR,FBZI/7B3#\PF\0SYZRA[/L?]]P1J-F#NI?VEYI-]HS5&@^P3A=H.7DN
<G4&dG0.3RUHfbC/#S0DCRG&M,WRYecc3_PHO/]bb/?)L\G)4S<BccP[<AV1f+Qf
4/c\AE_]J9a?<?LcW6gg#Y^bb>c4TGe(8UO;^=7/g^7F(g^8UA/a]@1WH45a<X#.
(XFTBNQX4?6MV6Gf7=TL7KdedQPR23(WBN\&CD5I?GK@&8NK)4F]2HUQM@F(c14[
T9&bOd^0D7cX,/.DNdR(VA80BXC6/O+[\T-RT0Fd9+1^YDO7(N07&NWb#><:gHV&
5aHEf(9CN0Z\YeX[:TNTP(4&[-g3MQI6MKZ-_<0VB\g/L(5Wd\B,;Y1:--ZFS,Z2
.;Kd(f&Ee,dLI@FYVRf\c53_M;Gd;O,DE0LZ^?#IME(Y\ff8-S,D;L_^^Q)/g6Va
OFOX)B)(b:N[5,JX9#[3cF2DW4ZV2GPQ2ZE.F?[?P28RG8??3ULBEYH>gWbVg([(
;?4(9.0T[ZGJ4W4<NW=M+F6c>S/Wa[LWCQ^=+[BaB)f1#<POId46?-Jf1g9:;>UA
]CMK^9J:&]J(]4Z#.IU[_a9Mgb@B+56&=84_:P2e(P^4cQR)@+_^C.PNf;A3R<S]
],X5H1N@UAHMHWL3Ze7B\EBTcd;?;TDG&eMCUL:547Db:PC(T8dH<40.-SU/GHNf
OCe9]45(8GAPLGV&36T;^]O,SBc<@Mb>M16<cFCW0\</7OfcL80JLOO-SENDK_][
9:C&\eg]AQ:a#I.=V8Ga&BEOZO5fZ]a9]fFY&ZGXPO(3Y(7)3d=QfCeV(b:/O:7O
&=a#^A^aE;NZd=3?3UU83#FZVJ^\+a.?H323T+RAAHW5<+N@<:JX?2IK&^NT<>2d
Z+f(:02)=<N3^YN+.b>N.bR5b7JG4X#OgC[BJO4KA\c:[9ZWeO9[YeHZUc[bBMM[
GP&:^O>@gVWI?12=g?=/7SMFZT./A^^N2_\Ff6,>g7^J7c;.KLY.3P@dVU=D@MH5
e9XCYWB70b74b=)5fg-+XR7H9:4G>A\_;eS/e6PQ.#5?=4[3VNbF,Ca@f[;+CF5@
&7\>G6P,+U.TAWMZ7&^08:QaD9+\\>J/7H.D+-21C?cP^&GY:Q>\RLVB[KO0eGPS
5Q#<ID\C/VDR/AQ,HJa-27,b8DSN;WV5??G&(A,C2Pd_VPF<R(R4M8e__.+OHC9J
Q#J:-N:H0e3.6-T:+7([+9aKQ_Uf;#[+Y5;00fIGH9R&M0daV_N0>]H]f.g?5YU@
3#[]2;]=aUOM1(SVK<SI&QO)VPg/HEE/ZQ3,PJKVZKH0AL[e@:>g#L\g=93]:GN&
JW[KQ[:R/W3Q(N,^C76-YIXE?XF805RYb]bX;YO?@\=9N<E[=^Z5NQ^\BP#Vg_Q#
Kc[PPeWc#:W)X/P,J;A-B:NOA8dY#/NJ_QM7b;.3KS>Q[,D=>4dB]XV+PMf0dKX6
]]8VFC]SJ&RTK:5Zc8BO27EO_KUH<\\>RX4FXHgb_SD)#NV6K-VQT:]]VK+bJ1B7
/<68BT99,Rf3CbOIc/>\H\FRB\e0;0?1P6Z,G?0MCZbGaQ?/X\YQ&D3;U]Fd87@^
H4\3IMYPJ^AE.EJIUZG,MOP4Q6fP7?CPf4V@:dQ,(g;FC0&U.L^Z4.^])\0^HZ&\
A:+[Jb=K7S1+ZGISM5cC+OIQ-gH9A<;A/@Paa2AZVdBLcFHBHBF&9/M]e>HP4/\K
9#V;B&Z#D6_:)/DcU(eb2V&[RHg5H.66E8Zd=].8\G,NUCJ[Z)g3]UQ&ZaI5=8BU
K/;b=EC\[>e^II(MS2)\d98T_]Od)U\:(?]4N^BDUU2:_\)U0_B^@cT<U3,5DVGJ
?2#)YDW0XH@SS>E0QW7;eO6,88J-2OI^c;C=_U_M=fXNIFI(f;42f2UGF7,([PTd
_S:T-g4N/WWJHN]I9]Tfe7c0]G+_.;d.8gL^8eOYPIf+WMUAccZ<bY.[<9(GORN;
V(150\MTWF]8]S0?&aVA1<>XD5/@J1fcFfcbR;=e\,<?KNLPNHT&TC,.gS@X(N=6
=EeD[;_1ZIE_)AH[J^HV309&V=1M9@e>>#)ZD/PR4I@J:I9NC+09(#X_@?XS>]>S
ZU<Lc+-?R>&4#D2A5.9099WL9N-/ZM@W,Xa885JC;HXbcIRR]6B\NZ^E/B[.MTBL
/K@P[@]0&.?6]PGcC;FWZ]@3a)>#?=ESS^2).^PG4bQ[29J6JLF+,_U]U^.0OI(?
c,2Q?EBL:V#[9b,gd1^WA+ef0U33/CgDNCF5R_IYPK+)G5-a@[1Re,Y@C889aReR
04,V]\4IBcQ]\e[</O(:.@520=8gNcUI;a3KfeZALT(V([-.A=KW(@@H.fFG?0Ce
3S)Z9c^2R]IDSRJfUQLUUQ,g#]ed9KM[;(CL00?<9.d:FKTVLFT;14VP/U>@VR=3
/6N63=<f_D;@S4[3^+<_S1L=/456@e+6cE^&ITR(N#)cJ-eL0^N<\dFabRG)@P4H
Zce&+gg=Q@Q-,/4HT5[JVF=R\g_2Sf;RTFKC@#,XOK#YML\+E1E(^8T1GREDF>R>Q$
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
3/WRUUFb]5O/9Z<Q(R^I8&U2-gAL<?^\8T,[83&-D:P&\eN7FDAZ9D7A80;29R1>
1_T98E,1.XI[[cUfR=b3?0PQb?8H1UWPf&[@,-7RbQ_6#]^OX)c_/1b@g=?f@3EH
34gC]0/HEgIdSP:CBbJTQR@YVabNcT5c&_;fW[c0cK=Kc3Z:g/1OL-PX#6J-PTN+
#5^51Xe<c;/X:N2?0aF[@4fCF>ZV7;UO[#/CVZXMV0aW=3HO@?U:eI,()_)O-=/0
Td]N_27Bea0KP66I88b48U_SPJ:9)17B4&+fWPH3=WFX@35=PS9)9;/-=F@3g8\Z
a7I@YG0+fC,F^LS,D(.FH^3=7-3&N.3E+(c9C7V-(W/V]BUZbM;aNe,(,NJPEWW0
>S_=V[GUD(J;a+:97P1:@L)N.83=+Qf5YNGPLW/R?OB4BOXV9)?&BD([NW9_f):5
1Tb]_1;87..fPEUFL[Ne/.&7)?/dKD].V[ON756EJRAE8,?0X-UZ:VPX,&(?)F8e
?M;g8Y:N_U3g<T3_AG4_?6?8b2Y(c75-Cf=R#\A#f?,NUI848[:^;NgW50>TF(HQ
74YMBB_d&#T#0dCAX)db)6<U#]DJV\/^2L^YJ8]7KNFaDaG<F.<SR:bOaPF,QdQ1
\)7RDM,6Y_\)9MZUC??cQGdSdWRYDG3cJ=e4L6d,HDaeIcN#(N#WK-]GU(PRU1e?
HH]fLOVNKNHT7Z+Qd#a+Uf5b/R(Fa83@V01S@fSHeV@=Oc51.B?1QX/cWBbRH9;R
>-1K,598?f=#)Ed#3dF1+CR<N-E[QE&&<\ZW:U8I@1H#>YBdBTDeUg4]HO<ADA\H
eLK+)U4I=aP-S2G&V?_C>A1S49HD@?HV?=4T=TXDOXED8O4M-ZAH,L/?3V)12^I,
#c4L/>#[Tb+00A&HbF-4(e&.GGZ+eCV(YZ1=4b.=+/EXGCK,F#V5f8_SVW2f_8.M
3K^dOI>R+,VY=7NUVZO[SM^)Z5\VgFLa;<&JYMUTL19g^Oc[)fBIO/.SFe[I4CLH
FVOX@/f=/)B<fdI_;=<0@:&Q=Q5W8AF98Waa[_A5&cNA=2_c>20WWI?UCVOf\BE)
e(OO,98D4\(ZY+>Y\JWR5fPH,bd@QD6=X,\Z&HS,&@_T5(F5TDCgJ2:]fDdWF:fe
@57M=NJBI=Z>Gc#a\G+Qg88fOb9X,NW[a2F3NE2&PX;e1)g#TIZMACBgV@6LZ,Mb
S8TPE0dT.JWBPDf86Ve]Z7LfV]);U7P>6,W>Id+_YL@0[I<356H3&2_eC>(^5cJO
:3[08H&310E=@](H/88(;[Ec-VM4/MDC33P[WKc,BLUQ)gRRGGZ9:Z.efS<5D87J
[gdXMNWC,fK:VQU\06]7I2R&>_HEKOIf:K:^@b.IXDd]YA/f<3]e0cJ9:_D2QSLH
TIML2HT9g-&^1JL<c?dRI?J1g:3MN_eaM=Q,TeW<>-J<87\V)S]#[TbSVeDAG8]W
e?V.a)G<C84@e=E6?,3YZ8,F^4V]S6=RCDWB4<QL7Q?1[@7)+?eCODR>g88e56eE
KI&Q/XM2TgDR@[F.]XOPSF^<I2G:N^cW9>.7+7?0G5VPHFAd+5bbQ<;H8_.@&I1O
PQVc\B1^&1ULE5H8?I^b27\9H7A0/=A,Y[YYg:?4QNaPQM[-H(_&^?>1NQ>?7]Q(
6O/@7//bVdb8MEI&3S0I+T]L5VQD_Gd.CX\?Y\/-^@8VgfNBb=g1GScLF<5EXF]Z
L@Ad@IGL]dA[Bc8gDZY?^<URB+75U/AIe+GNdcG&?I5^.ZDZEceR_IZ>52LX4A^T
g;1e3,?-YTOCe<bNeZG?;O+;573&Y;>]a]R17<4>)@8SYYW5HK5abKTZ:D@B?IaI
(PW1&<fC_-A]ARZEJ<?,+MEdBaf+a8@E>EE(X,2Z47(5c>g[>d@YK[C;P_OU--6[
d^(>#a(4^EN(&_MecMF-;@9&e.&6/?&TS70JARZe)4DD#dY573;788;=0]1afF9;
&g1IZgbe1D.2O5R.9QfD#C:R9LAaePY0K]=46;3)d5-6PRX;f;7F-J3.c@6]P2[1
8BLP&[T_]-?T0(TV81gbZ=R4(C]-[bM(GG]DM&b942]JBBadc-&77=eWd2@:bBcZ
L+KSC5AUCK6461\<DW&cZE_OV[R-VE-Q?O6.Oc7e3EB\3/KDG@>^E_IUHIDG:a<I
@VM?=AIRXTc13MfI(=84A6(L28BX=c&>Mc/I2)?Y.I5UB&XX.HCB4K81F7L^D,QA
7N.Vb:;4^H__Mb[e];4=)]/_T,##FYH-7_1S/Q]U&9>;&<</Z_:+31T&8ZAEWc1T
.]gI5Y=beKCNNLP?G#J3-8-fXI[YZ_L5WD1U>fTW?&6J^L.+5XQ.T+:#_X]^0@ZA
F7:AC\8a+/27b0?FU/EXALWdZFDgAFRCXcLD=c3\M&:cZf\TcCFZ&S+)I_ee:Z]G
d,#F6(P,F(fLM;@R(F3EdKI0S3N]V23F;)Mb<>a22FdS_[a;U^Pb&S=(c@1&--F+
[JHE?@@@G]JHBcT#Jf5S=1bL1&Z.4b)G7bd0960#NBe9RXD+V,7>/Y3d#S:RR6,+
Q=gYB]Kg62#IPJ6a4N^f:UY833S#feZ3Z=<-MT3&T@EGeTbW.OP3^=\2Y.SD((R6
>(@e:?,@acJg[7;EG,-0E#OQ];;;JS,6e[X>BATJCY)\K?J3IdgE\5CZgP71V,-d
IE,;LI[-Q4X8<f6X6bWLgY&Q9+8:7,&HRXb8UUZI4YH,W0+/ec;]H0XOPCL)+N6I
;HEF48E:/-54]IRKL0RET=fX4+UR_gLH<a\b\,EQ1-0b)>))026e:0;N0DU0c@Xg
V--VB#4g6^1Ue_)N?)KUOU?Y:cQI#=a&NW2IY6O4K(O?L/d+@-.FVfK1#YA[Y&G2
YQW+E.4NcQ78]D&AEY1^_C:LEJ-]XC0VC^e2=D;JLU_4]O0SbJG0QW;,[1]^.W@a
.D[;PR3F/Le@dC#cMe#:R95MV_25P,F-V8H-\E4&:3FQ4&>@@),F<RMK=NDCH(#W
6^FcJ8W+e0c13(2_WJ<>H_\HS.DH&M9J=(24QKTJD8-A6>Pd@>fCgT4b(gbdE-e=
0GIV/F&Vg/)Dgf1(+^MFH;bgH#FH6K2+Z\;g5_@R[+>Pc=PQRM+XS[A_,Q0<(?\N
NRPX\YSdLb_WZ?/KJf8D_W9&0.7G/K_?L;?3:^CACa2EaIR?GBG=6O5XFRJDI:-d
YW6+Y7YXX@UGX[=?e,^:2Ac:Pf0LURf>.g&9GR0WN.-,aaF&8#+7\b\&TYbJ)IJ8
&a)9U8F@?Pb@bg(1YTF,6OS]F#X6)e5_f[fb>IX=3OLYG>fcGJ=2bAO#S7gd[N0/
J(CO=319d=FE_0\6:1TF4cT#5GcKBXO#VH.XY67BcOX+RJ=a9TdAR<O#L$
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
Y:PNgM<+)6aAM(1e9DUd=,Ta=F8V9U4+=>4Y9cUN?0NG&A0ULI2L<.H/,[Fd,XA/
;f3SG^]gU0;:/.-<<HZ4N56>>e,[WD&1\X53ZDO_/1)0EBY(;._J3_FXgLZXI1LA
RV>/FA:66-4Q4c9AcHI:U1.FBQG[J^+dWL4Q],E/SPP^1_VN[OOOVLT+GfJ1LZ@.
51J-Zdg3RE1+HJEZ=AO6)XLbc_P5K>F=+fD_Tb[9??GNe04fKX[&]<)d5@ER]?:G
L-aG+1MIB+V_S\.L&OLT1&\e3BS9MU7Z7]V;4dJQ7&,-Zb0P4ZFTG/Pf(M<JFMHM
OB&QT9^IF5)K-I0C#e(VCbS34Q5=S#3SE-C8C\DA>e6NK4WV^[e?>U7V0g#9B>d@
F.+&(=b4P+V-?5A<Qg7eN@LgCI9CA]GHGLKK_VZP<<EQD8b6d:\SQ+ML/ZY(g^@<
PJ+<(?3EeHE;V5DFfKScgLdG&4E3<PBbT0aVV?Y]W=209S4FB@]3dI>^18,T6EbM
bWI2Feb(+XP#<CH]9#^BJ.5e>\>G+Jc8JbI6YW-,-[-DC6Z2X6cB42)&6b/YJU?.
gSV@=FR14eA&4Z_WR9PgM^gQAEV1EYIA5CRH2dHAId0KA0fKQNU/E>1VRcC599J2
>C8#86ZKUN)Og6)D@d3Ja9>E358TW))T#Q=4Y1LP3?C0OVSD.?R1G+>4T@XF]^4W
R<RYH-(6#8CS8eP6&YH-OPUE3WVUBc=AC_ID<FO_<<0FVMDN;KAcfga]S\54X6.Z
@e&@WUB4F7.SXE^cTT9ee555gL2DJNR<Wa_MCKK^((J5V6TSC[>D&[&A2/MfADB0
Z#3+^+M>J,H0J@CPdb:Vfe,fN9B32M#;7C1;;T9<dK\24ba?;BV<b#D#aW0H:\Og
aX)Xf#W0.EMcN2Z,^MaQ9X.2QZP]NUUM0C(S#F+P-S@](Nca]H:C4/5RN:C5gS]6
:BTBJeVC=/1G_&MYC2G+fLIFJPV1.]>(H..cgKgB1fg\Q<0I49M>\WVbFI83bf(:
I53<=9;_GK:@a;[7)A:6F;JI2HJ.=<1\H92)CVI;Dg.#H@@.&W>,@DaScUHP]<NI
e85dLEV2UCMgRB0M4PfEW&WDb::K79#YCIPLG6.R;R<f+UMI#T2dZaB@T/6=3HT#
<ba1+7a.)&6K0CCEH,c&1L;Q;<&eWFZZ8^=.bAGH8R=[<A)@I-4V5PC#)O)PdAOb
?Y]W]87Scf7dS]Z?+B_cG/(:9Tf@<7\HOZSG>JbI4PC>/F0EE)Y)R^LAF@3[a9DW
]8K81/\HCA9]/26&ZHUcUJ\R3D[Hd?;YF_^9f.4^]b<5D?@e@(2K5>P>7#(aMaVV
-KC?\5UPK1];;24W[^TM?K/,K\Xfa7+OC)54C?AQOdg2CQRWLfQ0;7_(g#<OCBTT
bW+>2LD.PXFgKO(fOBYFTTYEAfKJ4J=ZM_Q0)-X1X9[JC?TZ2Ea6.4e+6aS(WZRA
T<&:V-6Z&TV-_@/d-V)<PG9UfgXe[VT+M/[A2BAc9(>V+25BJYNdDIPe^M;G&D^+
W?^?^C;ba^W&?-7C]V:R/)e_^I6Vg4d4a\^^VF2&ZD#A-a5MC:XR]QTc:a?Nd7#b
)5VVKb81d8S[2342@J9<2[).<[-DM^VJd9=;^QTUQ#H6FWb1<JUH0/#^aIVBKT(X
c8<)W>A]E(3KK5eY8TTVH4#KE&@4^d+6TZLL3G>O-08#_D5IHCO[Y460?TU^&BIA
;eg4?1M2#8@-XADF;N.d<+[_PVUFdYKdPSAf+S7MWJ=.D#-X5\6?7@VF[J=Aa=Vd
6UUU8UG6J)eH^b(<-V&F6LeXGP90,UPM[6V83WJZ9eQLeLSSb+MAZ-4C#b-?0F&a
4J9BYBb:&/^MCf7MTQTb6BC5;@F@68fF-(HS.beFd;#Ib3]GL+HeI,@Y9fVfDVb=
gKNL_<_H&R:B#b\&1(1c_MPA5K;UOYDZ^(6Td,>9Y0]FEI8>9GVSO]>JF0eT:Qg3
/I<cMY_1JM802H<I_49e6dPT1F9VdBP-cc9IFJ:(&2abR6_A_?B;Y^9GGd/=,).I
_M>M4JNa]T,P3\=.;(OZSK(.Ia)D2YK@ZUGS52]I[.FK=9G9(VEgLW\DBeeIEVKY
M@-\B^cUQW#G+]9d^E;<P&_eA<B(D,&/fB]fLJIQN;EH5,a7M1EUVAJDK]^R.D>3
D,&Nd8AHIdL#[T3gS9C><APY]a(b1/CN0IIJFRL51f08cE9USUA?\TdH)\-.,gX#
>00e<f>LbfV6LR5dBRG4E-RVO<TL,dD6]QANc8>gCG=e.F0X.DT+AQBb8DVIB,MK
?E3I_2H,W[1.LBHM^=d+cK,?IT:/&.&F8X^DW9KY)e-K,O;N;PV&(\Na.Z:bI0W,
&;E-1VGEg604BZIULD.-PS:e87<6CbPN?Sg2COJDWTgC54c[L1I/H7L)([Z[0(O;
>&OY6@A6_[?.743JO<d?-L-b#X1Fe,LXY1g06^D,0L[K2cP]:+P3Y](9eO16JW7F
O=&)440RYBcIe=PGc+XKdMd4T=L\]93dS4CNNNUg0._KC$
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
;6E5=1>A<e[;(EN5=-;D9WD7)A-T<Q,9-#9^-WYc+[W@SL/T@_E+)>bS=?G&=LGB
G+N.@_C4INA77JC#-Q4e?)PUDMgefH@RTKcO40R+Y\?.=UY6I9)[([3&SDF<7>L9
bcE\@SY0;XF2c@S\+Z?FVg<\/&KO>G?b8VdF2:2b5(,F-,HFP1gYT^E7\f.2MMW0
g:;V_80H&TADLNGdc\fSd0#JHea-KXB=L23@R8PfbJ1O:,M(H&2W.QIJN:U>H(@#
.dg@Q1[TLV0b6B#G_e?XYb/./e@-#V<baRO^(4=G_,7B\\KM[E9<35U0e\;+[V[@
J0&6&6H+<b?DcK&W=S(]&;T@3U_,4#>/B?f;HVB=TX7(,I;08L/a#SBS0U2SO6eE
T,aK0-33F=5ZC=aV+QY>V&?N-Fc1@+A>7X<5.7[,T9.):K&Z-Be6AT,cD\KW-HYD
Q_Q9Z],d->//Hg,c1fYg@MC)W_4CY?31(P[4+(_K57[T3BVbM?P)HLSL2KULL.#4
[+Qg3<cX,6D(]N35?fND;P+^(00Ib::@PCV3>TK9VG]Z,HA3dL\MF3de.QKD3>ZO
/eHZ_^aPHOE]/VIb<D<g8?278NUTg_2QV(2Oc:7]C#JH:#_W)99bX2FC4D0<M2BH
=);K#fU/Pe8(:VZ>,g;>G_P@LZB>Y]1^UMN?\5-UDf-&),/]#+HM.b=0Sa9VA-(C
Zd^;eN_VFZUDZ/QG8.@b4-4CaW:3W-=ZPAM6+@Q_<>/[HV2J[LIYY^aTHU+K\/]d
]UO<;FM(X/:aKYAU/RO^aJQf_S#]K8X]\-bg5H4L=H49M/bT/X]/MAXb<KW+9a65
(WR+-35[gC\,V8KN^HHUA:?>]K^5:[?R->bT6FcNWTAWfWC1QdODM-_P@NPG=@CD
XfISAP/@0H(\R7VB=.dHSXO-,@JDQPYa6<R\Y26cUTYDU1:);R3baO[=cH\=GdW7
]8aX+IE?dCeTE_B>#AAd,A76HMLE5FI<F]AH@3K/0]?C_,UK7/2W.Zb7N-CA\=UW
+\H?^:9</ZF3NRaGNZ]41MDR-Sd,2^5IPHK_E^O@&DI/a](P2B#-?.R<?<c]K(FW
U-^2^CM0CJ;gc79@7QdY@&;#KaDLdJ12L5fYQ4>c63)NF&VV[LcLS<bS5T8f-K7?
]+YP_=GS>9gb3KTg=\53Z?0V2GVB\P9>3PF_-HF1/GEX/-5GV]V9]N8#9HU6b_[X
Q+cVLbM=.G3-XHVdS_E;P84;29J6gg;TSW-I]ab1M6d\K^D=@Q8UZ2><AD/[PE,2
ZW6)b57g:3/<H?^92fCBfde;A.,Af&(Sc=,^5=QPc:Ng#<R\bNRP@N&(F+a1]QQJ
Q)^<VOKGN\W,SMOc@@52a/J?<_a)PdXcX8&GSIX7AN2=N3AJGDOJ42.:F>PWd43d
6CUJEM>\;;Y;UM]ZC]W&Gc?(^9eeJ,/Le[==PQ)27?c=5&>J;g3@gZO>=d?4SX.^
3APY1=Vb_B-;<MYUN,gQ4#[?+gD(J-354Sg1>7MEVWN8]cgE]B:+MCUDEc.-IZ_K
=>90Sb3J.CV,Z#)\Yb[C#P[[N73<A7+NcCDA1.+:UTW[.a_Q6ETK@+^I\:==<&Te
R55?=S(;6Fd6G6QMR(F&]I=4Xb5Ka\CNFb13ZN3[0_,/JZ?&6V4;SCd8Y^OK5+QV
;<WcZ(g_4#,\S^O\>3Z_NAbQ)&QCYN)G\5;D;?3I69^?]b.,Y;(g+B.-[J5E5/T&
9X54Z?A;XNae:=(a@E:#EY5Pg&BQV8N/I7b&L)T@@4ZI]53/ed4fP[ReA^#:)0YZ
8E0ED[D]//B/3[N;.XHCgA/Je94YA2PA^XX7G)4N4FW9W&FR-5:UMOS.;,5-&Q?c
(D+2)?2Q,KM<_Rb^5(\fb+-EQE2afC.4aX[W?PO2[-->^9&Y3E0)He8H^e:&fA\d
5,e>9IV:EfI0A+HPK\;W:g8#bAA/8>/+QD8B1Z?)YB@f);E,#a6O&X?)e92/bKGb
F3SOaNf@HQO6.(4N?5XDgEdD[bVe1,fFEC>W/,Z,Z31MbL-.P<7d836?6QMf6N,8
+WbB#K5+C:#5>=W.#)d)W<@NBXR0#]GLZF^M&WXECQ@KIUP[fMG&SX+?2g-NB17g
?WB+dcEZB]8-2F6LbJ@=KV=^Gef6AFOV-)T5<GK8Q[5Zg&L9FCVP-_#ICCY.P@+Q
\eG]],W]Ug,<7)Y5d7J#8N<ZO<R]>F]<aD0@S1[Z;MV\0ZW=]WEa<A.)YS./NONX
ULM>Q??fSgNMS.F2d-<K_Z\&Od<gef@;O70_S?FLJZJJbK]+T=OXb(Q1C0ZOe(]2
HJa+JW@-B(ZgfXc>PIDR>RC@K(bXS#1FA)eU<:N6;VfJ0T93H-<EF20G;TZP^;BK
<@H#)^]&8K?I0>-[S,@GIe8<N(cbH&-Y_C@.Z<]56<3924SGQI[gb\9?S]3(8L]U
N:?R:_<cQ.K2cb1;RN=W5G>AGeNCAU(HUHTG.HH\TH25e.ePRZ#8@;2Q2+7f?G\g
&RNVI@_?eZ&);1;O\-Q;b##KROQ-MO_\(,#RH-UZ<0N-d.A1\^bK1J(SU?N;-a&+
=HA_PbKD#cL/6M&57A?^(/S@9=)ZIKc.Y8b4OC0I__f#SAFRG<Wa;:8,<YL.#;37
(aT2:a3<9NUD0>BAH[JQU^g5>99?f]4+)d9dJ,Z)Y43M_YSI\1)CAW[+gP1gT-D=
fZUKQZD[eEXB&e1LOG1^#HbO.:8Aa.f>J_AaS<./UE2C@JZ/b\JEXN6dV;GWg/T-
;J&9_PcH(M9dYWFBAKC3JFUR&H>S6DN2#8Ye2@R417BOU<8?8WFJ-1IRO^MH[J]1
A-K[=EZ(&[Xg^OD8^=,S?0;@K@?+14UAHDDZOOO=FRGe:>N1=TYgS>X#b_f.8X[P
a0#6TE;;-Je,H5K>:IOB);YWg:7OYT<,02&((gB(S;SG+EfK1X(BaNULP<>DZZVd
A8MS<Ba:WM=b^&FF>UaHF]+[M#54Ig1Y=O=CIAgJ&&QMXX8R.5A@Z>P_<\X;<8R:
7W^10D,#cXH@(bE=g<^K)6E9a@=E>H)A/,Y,V>=HYNW;\VZa:8fF6B5TS[V]H24^
X(acUQHWCWNR3FA1?6JbB30+3+J3PBYNLMaKF9bBP<:VU+/Xd6N8AUZG5]_J8/<E
-__Y/N?V^]cVQeTeSCA/H_1,GE+W3,[Rfc<P/BJSP.\W<AD0Y4=RNXcBf]?109D^
cSD,AWH=#c4F.cX7SRSee)@#QS.,0AIHgF-23=+DJ[Y+GEDH[cW[:f@I[98RLJJP
[^40;<b#Qf^4cPM6_:<_(/b#@5\506N8.2RO)L+G^;7_M/JD_e,61A0W7;S/S59[
]Q#K@<IMWV8/g:03f\-7;c_0Q&&gRIK1-][#_9K@G0NH9:JLEfK6=V:O^?.9YE17
f<(6K5BP>,2,^[:2TYd_^>XX#9,T62NXOJ-+d84N=F?Pc>/V]I0[>B<WE@Ua/Pg/
24@QGQLEQeN6K8fdX-Z9(U-\8C#&U,AR7R1g-/WS:b\KdX8,BFNfVV2CH=^@g1^2
&3016:FF4bf]TZ-:^R/gb^-L3+T9K1Z(AZ]43K4P7d5\-96c+MXSCS&G/1C7-:8d
3[-/eSTfJ4ZA4V<)3_XCXX=UI84_#70(bg<0[1gDa36bP[fF-;+eKgF)OR<YVX0b
5Kd<]54];)U4cXgLOA>[:ZS2D-eZ_-U5F8]1RQF2)=:32gT,Y>7]5BfT5G_WeC]@
;=BI)0Fc,UA9OZ43cYGP=6Vg)c0FU<#dAW6Y1Ic7[?C>B\[.ZXACT&?/G5OWSKYY
cG<:7VXT-,cJ;JCB(54]26b^PG0NHcY]JbfM/HAc0PTK><1:=>8?652O##KC.a1#
@F5T;[@)0c:1A/Oa1a2-3faZQcLDWL5PU@gNUa?NWQ4[B/_F_d<1GO\AMObfBP)C
8VDP#@#\d7,bDT@.=T-<E24BH7O@Q)bD?c61X)RaMf6I[<aD\:d;beY1>(2eGXe3
fV:KABS]:E^I-c3#\P0-;BId40f&-O9cW8:_G];g]6TW]SE<370V_7J1</T?>_cL
BG\<1BDf;#2\)-V.1ag<YHd)R_H1FT>I[7,C8Q)LE/O1F_4LQ07P4U]L4e43/aX,
S<(e3bM)++^^&G9\A(W^6GfK<4_8c9Pb:6>B>XV>\AD+L>T(J4fZ)Q=3eR[,)9U[
W3cK1=(\A8<W669>3@0VEO,P;V7a_?:=BR[\,Gd2S5&Z0((6-B]G:>^JG+aaVSKD
fFLg1fMa5BAI_[_@/b8VA]6Y79DK752??;f8Hg>_V8.^CB2fKQR7QY?T+M_f9A&#
&EfN?G^B>FcXP]1H.C#\eVI#9f/9?;L+D@98bXNV-3A[J)X96]e_3G^T:,/&4X>#
OJ+0W&[&HD<BL<3.;V^XQbAWG)g7?VeXH\bST^HgN00^VJK\OMF.;\ZfQ2]3JUee
-762R@?FQLf;&]b)KWKg.LF&]G(2.\&ZC&[\&_OR0[BGTURECRfJ.=:ReF_ZMNK#
)?=89]-g?^+-5H>HVS3OP3.BK<JZWV&CZeQT_5dSXE8Z<DdG-4R9\.>X4>FdWUUg
NBWH&GJW-N+HY1L1Cg^O=aB:Q/-K+)5[D#7B0W+A4\SNb?\O)(?W;#0C4<]KgcLg
c=@C,2U5V#<FHg84\[bC7#F_c9^2L8DA9OQ45XCON+RRX=0VLaX=@ccA-)/1L\K?
@J2E:LNS:U4X8]N6#7H;HeffSY__IE=(2RVYE5C=M/X7e;I<NYdK3X3S88\d>f3>
f[DbAc7(S<Z,;1J)01>JEAX=8JZ)^9[9FbbCM>CC(_>:3AK/C:A+(a.]Z.Mc:/UD
.RA1cJUe-J]<</F.1C2^_O43&Me80X>D9,8U3^<O=dMI-1[VEEFWNC13U_--6Y((
]#CB-<[C24#JTd462#f8XeG/+=3c)UB:KfS>T2&8_eCJ9E+-6SM^\WXO52\a2a:4
Rc)\:(Cg1.GWX82L<T8>&7dGEL8bQ97_[U2)2[YRdBF&GS:M9(#DI2,@3Y]^#A>6
VJB@Y<RBHg)ZKgCWga2;MIJB-e/__PaRa)X)+TLXSB<gOK[T>9VP6T#Cc9TW+G77
AU,6=fZ(e>4M_1I.a1^,O?(\@SP9J&83/aIa-UFW<Hb:/CAK+@9&T_[e(.;6-I_]
[GK^WO@DU4LV^)_QNa3RXTFXT^d;/D;@_C_&2_aH+>DM&N?3T,g<.SPeVP0c[edO
1H0AW?G00Vg?.Y2=J91df5ICe>97F0IEW.POa25PZ\dE(Zd3N8?1F4g\0bC]>,B\
^88_2,<2#\:?D0+Q//0OBA?B@1gLaB=CSGRR]>gD,29=29bI>1dB+_BS?G<#@>c#
C?I\2,\.POfedaM8WR,0e91JK5D:]M#?P5Gde5Q?-DHFdEd)^e5R)0;XLK\D4@Z5
?)Z;#D_.Lc@Q0H4Xb.^[7C@Pa/.F7/UTdg;X772Q-+WX[?=C>QWbdK/CYX_f85\U
09RL#E[,gTIeV@E.KH#Ia-HIf<\4F?]&K?_N?Z.NAF&L&NeF^J,f1UDQ,R(>0)03
=K+-S[6&&9G#@:34\>P:QI<.S<f,(T:Kf1EKM79_9H<)Cd>b5HB[g/&9\C<_(g-F
NA;bY[B^9Me?-fbHDC40N^#QY3PJ7Q7^eQX4V\+2P^A0.Pc.TV@O1NXYLB=eH8aN
#4U?5W>/BP=8^MSS/S:,2Nd81ff+4>^+UOeX-2PD=N/?V+I60/+85C8P\eKF,cH;
DNYNC)A0SG=,8O>71154gW\_9H,/JC^:6BM;DeZRM:XA=GFcgLXAe98PJ$
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
\J<UUY6,Te@;=MZC)02\(@+7<ZE]8=NP)cH<-[6B(.T[aNN2K+^a82D:=Jc28JE8
;ER139)C6+aJ>bSI29C,?Q:>5[:J8@(+^V\RLE_G8EE2+/^_+#1KJSW8Xa;2,-3E
M:=NVUTG1DUH2CWHR;/gN_40<)H,X(?Z<X.A:GbG+dC>O1]PZSC-I@GPZKHGR2_>
=/]O#KaZZT<<?,/b3PX/>e1?R/T3:2VRYde-egbN^/Fc#7LJ2DO35)g/ga5PF&KH
?g)Z]JU9-64;cJc^<P4__E/K3,I.Z6&:+AK629;H7DF/@BaN[GVS3:YGg]G,3SPL
<#cE4b1K@WNP\^#eFe;CeGU@TaE8^ZgMDgM2[:7a[13>e2MKE<YL#_J=&;+OdUb0
4-T@-3bKc8W3g:R0MN9bf,SVRaFQ]Z=a[Kb2NBgOFR9D]M2PL?aST]BZ7L^];AJ_
Y<>DIN=\OE-PO_SaV&U/c,59b\If(T_-Y=0_@O:b:E0]4RO;X_J-Q0>+dHaU5(7<
4-^#JJdT-CBEFBY-C?RY#EOSM\G2d9KZ-_35(_A?7\MA-J/<@H^^UG(<?Z[JXN:<
&SGP&bL=O9U)8#+-46Kc+HZD(&,@IcEfY,ec&Z[C8GH)0?OL]9?].(=+7.+VfUcB
T6MKa0I=Fd+W-POE(+b(P?Fgf3@/UVDCYSA?OWf\e]<85V>?@ES-F?B6LgHS0d0C
/W6a:A]B^eT]NCa^d6];A;PT.B_@6L]\7]O_&?1JL.,KADg_GI.(AA)Q[Y+E@a[a
(;[QI^gZaO))5KIK(_g9#XU]/e)LGf)A=2FP@IZbP6[:NR]Sd&?gI>I=X<GUfeg,
BbK&6e1X=#JN#>]bga:@g)?DUC.\L9)HZ>@Y,S&Q8RW9gA)X:0.34DHaaOD#=/GZ
5R5EKbT(eW3[NXNP24G2&;JTY1=J\UH1C>Z5-A<)dD4206^A@ecKY0>c.,3Vc1CN
BeT;PZbDg/T8B6=b91RJ@(g-4<V_d?adQb>=5X>3g?&WN&5GQf_Z#82U9d?#M>:F
Z7JHA&<<@4JIaZ^20g#a.Kg:247&V0##=gWWN<&(aRBBM#52#;#N#aNV;-&J7I]D
F]SP_dB+O=DL,TU&,(2W9F]9[7+:)2=f(Y3cQRK?V^-LW_/<\X]ROG6e3QaVM,ca
YGc1#CDc#:+D06]F&P)d?WBBV/^6V>#@R6_@#&IL)6@:U7B.VbdQG&9YJ.@LYN-2
0&I]<F#Xg45MC[^[PAd>a5.bLB9ePIC5XfEU_OE#/DE[^6]/bEMU>R1@0Z30Ve=<
X_e1HE2L=2PHJ7RNB3.?I+GTHOBQ&=&<QZ)<a&FHZVJ&LC-)&b20ZE>L]UPK+S?c
#gGB<;c=>B@.=/)[]\OO9:MF?5Zg3B2aXLTBgV9>ZHN.VTFL87F6HRDG7GZ>UKOT
H@\1U>BeZXEX5X^M@\Y5:3>9Qg?;I@(6K:V3+NZe\CH28fTffJT3S)GMO)5]HEVE
G/b5S1Q]e@+LO\b3#6@XJ84?O0Ma0@INL5PW#cXIa1R<JG9#9:;3#BPNa/AVIPJ?
.@W;TOY:[>^/,&_O<FWK/&_/P\TB8(3O>Z9.-S,3\I#T=YKg,_MG)(WF^-IX2FDf
LFTA]:5G=cSTPDcXDG5fe]87_,>OFM+d<>Y)1GP7RTcfY]V4.g<UaK&HEXbUR7+^
/B_)6_4?Y82aQ/(dK4OMMC,4;8eWT>C;C6LJQRT]+H?L1W[ZV#5?@X3=aC@TN)0b
f24IOJOC+OSUZa?2\GfPFMeUcK0V<I5Wg=e8.\^/-=GcMM2-PQ_S6N:>R)ad+1#X
_=acTXKWC>^7UWDLSIWE=ZR4<cMT_(K:PgVSO(>I>5328a-YaNfYNO,d(81,,^/Q
7/<(5;#)+a3Q#QT=L@06W\U>BJ^R<PG(7+CDOAV<)N^+)\a]PcQU.]WDf9fR[\UH
I?.\2c<Q?L.(_BF7KI#D6gD@1_W4@+]NIa<e7ON&:DU+22@IW&3VX3X,MX-MDCf7
:f@=8b44PMJ1<O@[S(\9Feb=UfJfbO2N0Y/(S&^Ad,S[C1]9ZY.Fg;f>>WC[70E\
1(XgKg\<X)b2Qe.WJeB/R)#AVeAOWP0I+b\Zaf9+BGb9W&<DRYV1_^27K[42f@eG
-WC^Y<CB#<Hf_^TWY7UNCQ;WE;80g.V_C512LU(aOSATC[RV?3d<IPWWU0#_KS[X
;G^c(53IIg8O7LLEY0#,Y.^f1U1_<H^,R[aSD;3.6#Fa@Y#=f-P3WP974Qb5M>F^
6KbY\05,1MeO0$
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
