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

//`protected
IH41^SQV5DT^<7iMJ[Amd0iA3`oW`@FS<1@]nBCR1lWR8ih2<MTMcjoAGBgb9oq>
e2NXAGB8[0Rd3V>SQ0B5]k[fJJ:<9jO2XdHoE@??El1eX505O8TSILV7@pOJSP_o
cX8EFU6BMKk8cRU25?dbYR9_M\]Wnad5n_T71\?^Z8U]e718HB3S;E@IZ>W>JNT8
QDpGG6mnlqCPRnSlp][>>23\qYR=l?bMW;IXI9_NDa=NFeM0M7i\0TMgg;_1`KSY
`PNQRS;nNBje>?l><H;GpbYLBaa1_Y9@oiDjnKmX0kSSKP6dmjdNZ=mYhl6p1ogS
?\9Oc`CRT8I2mVhceb@LA]Wd0e>S>Wq0Y:jJ6QNk7C:nQ:Cm:=95WG974Bb8IcoU
]8;b_jK^G<pHm]gMkjg310FT[HaD:D<Y3=om<NOH^=eS?4:TG;q3C^<;\?conIWj
\hooS_`JBRdah0JX65i^]201hMKoA^qKLR90[<Dgj:e_\fPB`Fd[:P=2]F2hfk[p
cc^TBc<EFQFLG2@4=ATJZXP=HillKVRj3hq^LHLUn61\hT;NjJno<5`_CF0N@bD\
;MpVho^_Z52RkYTn3l<D;LRjZA`=LSB^M\Zi^D5EQ7814X0IQIk0IaBB>[MTnpJ1
lEA64pbM?f[IB<>?UHbT2>foLkSSBE9\E<NfcgVhgcqWX_GL?TgbiJFhG]R9c<[Z
WDWoLI_LDK]?3B49g^W@PCV5^Z8qKb:kNJEgU0F`TDl_4^kgU=>o1<0Cjm4V0[C<
S1<a@cQVqjc[\QA4qddEof[8>MQN=i>BEFG=^Qe6VNGcHqi\Wb8Y_\INU_EYZ2nL
OhcoJ[4C@G5`d6ElX2Ubp9ImjScWO9Z\5h==ANgC:Wo7aiMbi;1j_jIN?9=<o]fN
\oRkaW]THCH7LpLH71W`5jm20ZNcQmjH_gG8lUWS^ISS_CY4pgXXa]B:ql@bcN]Y
p5INBESLHnd6g[_d0Md28Z@LLC3IRk5@K\`A8f:286iIV1R>i7`]XA4WAQ0B5AMj
_QaUDY5fA9OR?e?Gab]^QebRBWO4k5iU9b@E?J[N5n2VVP2ni`PpSY0BMkYBIYbW
<_3nKBZ1C]okXc01DnlQ<S`Bb38WW:aLHW0gc32:Pm_W7X7kp7><UIY>=DO]lf3F
0dOMp8kReH^]Jj<FWP;1YlSULCC_K7e>mClbHT\^\>TK7_E5[9lko^7p88QBJ5lh
=G_LhfdNMDjmalc8G?jgJLdAReeIAcY1S>lO8E866CP@q5mn5a_fNW>ffi6Nd=FK
NDN89lk2:2a[8S\K\SFQ_lPJ=@KhjGPCeYMDni82coP`:qFRSb6BLbGkRcfKSlHQ
]GWXd2Eh2e442C@:_9]`LS4<:10d6Id62<VkiQ^fbp?8L;?CDSWWn0M4]o[0Vk4f
@I1Ri0=X1?l^51k43DaCFUcKkPng]VnD7j_QamN75=\W<A<k\;9kb>NYVL^JqR5U
<To:bQAB>Y5m;V8`VpLbY?cYXABP>^D]4MLDWTB?W_:e?b9Ub8H?bYI`>;JCgHL<
PAJJnh5BQk=>JoA1PQWdTR?V>_e[8WMo4jAdn>O`:jI@VR3:@7AgXEBm3GE_io`C
jp1<[]Q2F755hmkj<Doc=TLZYaol3`9=kk@c]kfj_=C8>\]A3Jo?`ik]bcQEU5?`
O[p_6@ohn7WT5_Kj^o53ECe5Kjq3D8H6M0GaD]<c[0CcFO<MEnJL@JSWOoO3PC66
lZA2U<hXn:[ZEY;mnLcLUgQj5=iJC>\;YHhJe:Rd2KWM3mXXE43ge3>o8WQ<WJJ0
8pD]JG;e0UaEDfg7]3;LK;VLAmeIFQ8n6B0<oR5YXCIPa7;2HQ\fLHo=RFYBW^nP
N>d]:V5<??<kp3Y_oTBhKKZXXIQepG_JL51RWLh>X1Ph7PBRj:aMDIhE0;WDXOb7
9WTq_;S>RTMi:[PDf?VP679ULKeRJZN4L\A?Eo\eUa=qC8`mK2nm;^TMBdF69c16
\UDk1U8]hNlD^7DkOFoqbE=:CY;ck5iEnVa`^Oj:Q8p_X\C]kE6`;Q543c0BOkhB
Q[p:;RW]NdJbN[HcmJHDQCiKo_2=B0GpfScA4eB4<iE8fPohGR`7[2lg5D\HVYYC
`>qS05:ial1[Ka?h:k;>=qGY:Zc0C_7enEARc06<aq?9DQDKATiQW\OH[HH6OWg3
XN^RJOUIL]Z[PqhDA45_ooZ\oN1LX>3_V1WhFWCEQOcOQ1FLgCHhi8fd55jT<54O
n;?m\J2jOZA`_i_3BHcIj3RSoA7=qcV]UiO>dLJPBBDo9OIJMT60PN6^j`b:8X?7
cBj00^c9\\Rm:eQJm>L3bN=E>AANZcl3<K2$
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
ohg\NSQH5DT^<X`i9Q7<YC:IR@n=X9b=B4caGb8od4fKK6?HWe<f49iIpEm6O3Hg
O7;Bl01i`RTK3GcGpJmkK06_>0AH7VN1]P06I0aDmJ2p`HDo;=qDEO1:K:EMOHG:
4;48j<OS<hqg?KJLgFnV5G4lPckRbZ27T@4DU83bOC=:XBR@LFB;DA;kOJqOD2Aj
Je=[\kF37dafaI;GeUANZb9e8p;>GblM94eZ01PmHK^AFEk[CmlOdFS=WXJkJ\31
pRP<Lm8q^QehSB@OSk2UBfL?oC=OL8iM@eGq8mc?SYFWII?^Z3XpTVlZPYjNWJa0
Jo_Ib<Q4<6Z8C\I8C6D09\;`1eqFZFP5D;7Z\mY2U6aR=SnVlK85Pf4CUeE;BRac
7IFl6<?nim>lKM9U8\>9:Vg>Fjpg\C?EOTqZ9LMK6;SPeb>RK;G^Jm8nA1=6d=Kf
b^4;gkKVjRIc8V2j=F@m8Qa0`DEpKSR[hAHAQENhmI9]WjASNI1BTSAJET]b13\J
4kIJ?Hl`?Z^V6SIf8l0[8kDG3S:qVc`Gb<p@<B>XTAU]W4U4?AOROZ@XD3>_XKg?
VAqYU^b\<6GW4>fDUBbm3OA]mEfRQggYbkQ7ehQ4ihp[;K\>ZHW6VZj[QBDPS]8U
:U_EAEZX8R<<DR65`\CFZKaR7oKMAg>IH2=>ep<GeJGVGON`ME7WLdJmPNEC0QaM
j44?]Fq_8L8Pnq`L\fkXYH9@aLmQ95jIUJ:c=Yp3oL7FXb>d1LeNVd_W[`ZbU1=_
<Ec?b9UJOQo:C7=jTejJ\VT^_B19Jq2Of0N9^T5[LgeMaT`oMmK9ekkDaV2N=?nR
=pEWQ0UaqGNn7kA4qnNe31\=2YC`L`J>KdUcY3j9pKXnLURN7>=E>cfm70X;klJ1
I[PK\SM>7;h;k]eZLkjSCJYN=ggTa<1pmJ@Pdi]4olA=EV:2hO[T\:q_I;Sh6H?m
6b880D;nUP@eKKpT[]WJfKQ1oiAh3ZhI0]ho<@qOQFoV\dbOK=@KC5cn39bG>Spo
@=P\aAQE1W0]8Qci<fS?dqYTUd\a<92BBZ__N1YT]7[[m=?FJQFNAq43KSECWB71
<V7A=H9FMSN1p;h\OQ0C?\T^D]P0Sa7g3bOq1Bh5?2h>TdjFn3@Ng<eih1`9:i;q
>H:IFCUB=nD>WYR5C@;S5Y=l8JnCFX?4LX<ciHEBqjS2QoH4LIa;8FD<9^hQkL`]
bc_AqI9`mnA;M456j5E:bc[YbMS_V9c?fq_?F\2Q6o\]LhJB?6OSW7432gGa_NpX
\SY9VQc?kf7jFZY[1OdJSc12DNpn=:9j0OmD;9I\3@YX6a34FZj6Q<7\TPNR0M9l
[dm^37c65=U:_jU^:Kf?_B<qjdB]1PjmfUMNTNh64MBU7>:fa[O?VX2p:dd>n1L=
EL9INf@jObc7GSomfIUB7OUCp<]=f\dQ=@0DX3lc\L>QBY@?2eViTqNlJ]?N34oH
iH0Q5?Ce8THlHnj=omjHUom<8In:3QNST?>]4N6GKGE<e@AXpHkaL6[3KRfh@^7E
F4lOEg:7O2M1ElX0P4ApLWH@Z6pU0g^XZKIn0Pa^PmbG8doS0[QTASQAHBHT;Bb4
oPNQPf^[cLj2TEH^oHpC5lmZ<q@8HeZ^pe1HCHAp[D^2WjWcg@[3U52XY;@EC0?A
_mDFiN>pb9mgSi5C_aY[^d_[eV9C1TG?V`f4]:>qR[8QB0?;1liQ?[Y[00l=?1`Q
5GHjFHpVDVX9S`oU<j@HoSg=ikSihNGRCZbH1q2:Jb63iMRbT@nbR:c\jp@bWJfG
q=6]NK^4AGm`FnEFl=;;dO@nM??NHl_Qgi@B>WF>K249H=E4Z^^cUCnWmS`OTiIA
:<XXCDWikqnodA4mpQ_6Cemqoal1ZBp^MoZ;fT<BF3aoTocO\AanH?G9T8`]7PpB
jJbZVE1aQ6f>126_B]gHgEMI;\L;9Pqn]@?Cjdaf6T@EFO:9o;oWj_>jc`7nkpI[
PDTj>HVI9SS;LGajX4XkTQg4FPPCpa3Ol5ZSeoc8bUlloY;p[:j^C\]eq6150UU6
pdBVBDBqBXB_=\IqBUPMXZ2b4iBekSh^g[j8:SnmBBJKg_PqANf=Fk@8hEAB>Id<
<iZlII:1aT5CaB:qM^`3FaEhFd`cj]j;@=lK0Okd]Be`F6q<9iiZ3J?MT@87T1kS
_CG\?BTOUf7]<p>5IDSjmVe\JU6_oM;gcpm]6BmF^q]<;m81pehP4Gc1pgOOM`S2
]>6Q60L0E5US^jI8?pjRA@af<dDB^_hiQ^[cnW?ZVk5Bc]\jqfEWU<7a`8ekc:nT
8hVQ?OGkWBa8i\?\UY1pf`V_M[ohMk3\i_gHQCT;59ScU2cjZYolpK;@J6g]iRHD
h6Rk03g7]5>E;T[cgQ0oEK;?HLRcpjg8<7dZCm5>^2E:HI6K@Kl00P4\3LYmY37K
j^AB>p3Y1j5kfRLYK^mBXVbaI3hRg?58XVIK0KUAYF\PVS6EH<PH[QOgHllJ10IG
W;]1;Tpbh[<a_Q@FBLf>5E0LPcl=\eB@VeVcARJ5ZHgqlfDFikUnWAFICI9VdYb>
4P@O]Z4_ORY]Pna1qS7<5WkfNmAfkPNLA7cM9e7kb9Y`lJ90ELY:Nqoef@XKm=mK
F?am_EqN<L_24K1Q=FS^<NoAoGGVL[GYKfnKJQ6ZK5q8M2jkR:7VLeF8`M2J;]7V
l><iYG?A;;`c_lq498C__:q]=DOC_j6[P@2?4ISk1pIVU]aU?S@aVQ3bM6T2=lI6
agkGaJCn:EH3^nkZ1OW4ccJWaGR57gqf=A5UY:l2kDX^<5fN?ZX`CgaJ_<=Gkqa=
:5i`g_e`o^m\fEMJc^S[m1>8XYHeRqnM_DUC@i^E4;4W2WYYk:7U]@a6g6i;SqKD
HojYX3@]Y_ODE6aZDSn<UE;>FXmj?;89:lm^C`K[BPRe^BhO\o[e5RiKoc8Q`Rp6
M;dmPfpI6jQ9>nBlEJ2lBq1S^[h]D:]=U4I[]UNP:djQiMlG:El?A6<fiqVR@V=1
A]Y3n;67BAS=hfSV2ZPV]?BEi7?@0aq4M93?:]DAG514YWB?;<B_^051C0i\N`<p
L9<2VHAq49L>7dcW?Shhm9D3CfGb_eJGG76a?[8T;anqLNbGeW2_94g21l3IEZ5A
Xd:^qJ_48GXMq\V51jfmOJea1O67km_RleGHh]]PW1G;FE3=3d?LS3j;Fb<XPo7k
jRK6e]1Uk?[AkK>HGRfbO_Ca>O4W9iTd=aoheqPEfGF77hk^9Ik[YmNaWM>RqmYQ
IGC?aHHYRE5ZGDXW_8fBkIoD91]6BLPc``U^qHNm[E3D?D70[mhABjP0NgYc`Rb;
Tp\;Zid<<NZ]nEP4PSQ2qQOime7b:VD<FKLH`f\N`;aK:Pe6;9d<D`H<qJE7oh5j
f0bbB5m`[\PfE_ciG1H9g2P^g@F5\OkjI0FZWNDR5YSo=P]D3;7BLeVK2a`o3f6p
L9_9GajqM<5<T=m=>0?h=[[K\e;2>9GHX;96j44Dfmi]X6hpdBC4Bi?oEM_coE63
dZK>;Oa>5P6U63P?=85G8LVhq`oJkQdYpbR]KWZGIgXLO?XKN]j;kog\IkAS2\LC
Rn;655CIlfQd3k_SlJaB9jRmEdmQT9Ip:4QQ2JgqWM[63=8`WQA0C1;LeKJViWO2
gYPBm0G;^=?QDC29L\MihKNXi>??NffSm`nR206:NeCO@h>TLTHLoVD?V54QC8BZ
:2Mbn\BfQCq7935aX\p64>GQ`0N^SA[BM`qQ;WC<R;H>:^7IMi<?ZNWp6`lNZKPV
_P:C[lYe?W\=mQC@;HHK`cV_LU<Rnej6<[di54<bK4I[`U]P`X=^7T]:k4LC5:@9
j_G:5ZKWpa0XQk]Aph1m=h>fEOb4[Ldg45Fa3RhBa_To9<AFA`VpK4cF5]73H2`q
RXnXV>=qiibIc7P9i>CPPXSZ:cW?623RMnjDET0ZQ?0DkgLpQUC=3JRd_bbfXN<d
aRnGHgC^j=KS57>$
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
D7=FaSQd5DT^<JYXHh3T?ekAM7VCoA3@M^:X]]YnBmBo>YV;@liqDPo`TeJN:IF5
UZ1g[48^iLL;JLY7Vk46fXR5B8I4ndDJKI4G4BLp:D=eK\P766\e2jqiPV:4OqnF
4IU:Sh>h9mHUnDEXi];6?Rd\]36ePg<DN^71G22UC43IjeFh2>Ck1BiYq>6M3NU;
>\T;OmL4<7Qe<m[nFhcShf2_acJ332\2Ic3@JSJbDLJaaSQ`jY7Yd<MWE^oGDlmR
jGJfq?D\YL@^8=Wo7BiFBZ2T3o6pOVa^>aYV;U=3d6UN6_]GF5mclMKUFEZOlTo^
=\?KUlZbO3G]^oDdn\lq6<igV6H>A77LaH6Hc7@lXQ?doa1EEkhhK?DJnXgXS8M`
Z2TJBJO3UCJ11@eNkIiGh7KjPh>b=hL><VnPnXVpkE16iHSpMY0KI`nEMD^ZEiM?
ZXC:S;SVAef?q^Vm8ER2gLeo<ee>;ca;4i^^TDYoU`hclC`pi]RVYZYD8lI:J^C^
5LD?U77Xb5@d@QS[a<=9[592Rfcl]Ce`N6l=QF7mYSXZ@ZHQ>JBUbEqB7LCdg6qW
N>]`11XCk8^AR<fo;2`UWEX7=JRTPEB8E_Q?kQ?;J`HR0TNikF?gXN9qQIe\FM>S
KaZQQ8?<f3F<V]MVH<Rm4^T?SHR^R9Z]65A8OUPgbj0B5:V^EWSo^<i``C[UTbck
gQJ9>oJF9k88p5QSNYXEpFZ12X=Q<NUEb2R?@V8JMSn2OO=7jOALqnoNY:aaLXEZ
oGNK9B\PGe7;Lf7;hjURB2G1Aj:^VE`OBXGCVMEYXGYLMp[\UP4Lf=Z0;b90B55P
jDcGU5D[3@XZoCRcUDRhm9o\Sg=LL;PP1NbO9`1IHeXTWTlbck0UfQ2_K2AlDAU`
UYpJOaE@LHpbNa?<26@SWTf9CjWh5LE>6j:D7`EJRdY8@p3Fbl`hhEIdeFVeE_mM
51;`[6?fUGX4;qPCKD;1qL=7@n1jRm=n]7o<h5jegR=M_`3Jk4=fMG\UZhEVjKVK
Yl66D5bFAIR6pWj72FPb`5VYcI@S=L@?[ZhU;K[STACGeUT_:_1JHAc\fAdL;ZXF
jgePA^17W\1>n4Ab8]gQ@XV0AA[^15Rmp:\F`hgOqSa_2Z]?EGCb493FU4KQ\APA
\jIG<pIN=NWUAqO?\]QXlQ?_^XhBMA5\\U\Sfle_Iem>bVk54WoY_<JRg>oo5b2O
\6JE=EV@cTqLk=FAUO`W7lmiF39SO>H;M>\4mC1\0hVhY][>=5FkU5DaV9Bna86`
m?Q@VB6UO:nV?1>Kd2<gFQe`Ap`hc72I2=<EJJeg6K=JO=V_]Q2E7Oi?l2_Xaa@Y
QaD3QOgKb\2Q45q3;m]A<E2LQJTeSdLR020d2BT\MRF8EQ@D15\[XXiW5aHig1HO
ZgIViTU2[L?mdc73fcY>bo\A]5WZ[00fl5YWVVFY;<J?2p?OQjhh\diYq>W[[h7f
Z4B[TG4VJTZiR3J]m:\YfYbnKEC4QJeDpOUT2jUCXdD4n;Z=d`ABJCIa^6Ya?l8h
D\m>Rq>H?\Ym1pMNiO9gIpYOFS17Eq[JUfU^9Y]?@flLdU2lDq_J33T`:2]@3nB4
?kBJ:9A3^ajFkZ`jKKqH@HEmDJpXOFjMo9fRPo8=Cd>C>L48d0pA835^l>BCKAOZ
Mi5UN7i<V38B90Oq]hSd?n\bJH_]8]TOH_fj>lp\WQc=g:\A8L0;eP<MoUhpf^fX
ONdYeFYh`2aVK1C8_XO;bIf[5L]HQ6pHe\<:ETlWPGI69mfSdd02B4X^9Bp:jXNa
lnTedlf=j^C7SPkXbhb>YBal?9jgDq0V[I=_oV6UK88OAS9_Zf@@6mi6IqYJf2`d
e0ElRoc7ml3neHCTk3L6FLNml]XDp?=gca?EqB[=XlAmELfj`27[4DKgoq?RkHc]
H82MKTI^R?5hO7N0;IO<W_:Ah=WBiB74EAqMQ?@bhn?6IbC@imD;n`jbo^dNm`?^
:KDkV:C@1:??XTO03:3i3gh;C2k`QjHG=c2fVn:AM[<1WQYAVm`[PR[EK3]q]BQ:
B@=@3S>?X2cW4\ZB93fW9bpcoi[W1`pgC`m[2S?1DP1G0]g3gIkO^C1g0LiJONKG
;kaMLSGWBAWNFDV8n7^;DV5p^B1_T4;fBF8kEW6=aUGjW=KMTS<aKlnVbQLK_GaP
ZaK\B29cK\<\]H>nFVPoC?KTXa8MX1n@FQ6<9NfnhA>lff8CpHSVol\>eHIPelC1
PVVq]E6o?6Ua6f:JVe_B=D;ZQje5qmG[<m;9;d>UOJTdBGV>Fl;?mS<pch_=kL][
K3PMkd=4WZ]L0C:1ehi?a=EkhM?PJR32jceoO_a0^anQiP9e43?KdG0?ci0k?fL^
qP^V?gHHq<jZ8[EUD8_4_fF5Fo<LM^4V^PXjLDHX1_H69?iZ3nkZIbk[8gY31Y3D
PmX_O:iHIajAoR1E^[jJbT[JH:VFK0[8;`bm0N64dHY_EQRPb[Gp[o3_lA8UP2hI
MK@BgR9a<^Q\@=p[cd`@6PqBXDf96f1Och]6=p2ZdcPZ>T:g[mejoo0^h5BZVZ9T
?Im1DJT<;LiaeXqQ?45mcT1Q14PAM4dm:c4]W]S2Nf59`nBd[2XO[3]nlUS9QbLB
cC361b=BcIA]P5]p_6\8nM_bh?U`nW_:YZlYlabYGN\`GAM7DQnl5Xi9S9GaKk\k
LAd01jI0Xo3XgFHY?SYjIde3eeW?[3\?YIcjTBMB?NY1@cdVR1[dPViNg1[9jIq;
0=WnUakR@4Z`2kCGeU3RJe;=hqQ;1<He9qenB874LR`MEZoZBI@12HfQLI2AII6D
WZ]N4q73CES=bYDN[d@LlYG[8[[WZZT[@:OAJpMaR4CWgY3g8ojhU9jTZUAK4Mdj
Q5dT[<LQoBi@2pSfgDTj1=hRl46bnKm=hlLGP><W8C9SBG?V1kVCO9Yh\coBZDAo
HNLJB549]P@7GE^9g]M4oSh`pbCXWb>iQPY>ogco?549Ml`5<FYH;pe5eI9P@0nO
F53^Xb8C4phUmc0j:V``1jic1X>gjD`GfeOEe9[`Xcbbbp^Whi34R94A[GagS6`6
HdcLofm\_6aKNaKjiFJ]]Q:<R9e`:F_OLqmgi>Y=VWOjnP0a4af^Z`B^@1XPF\[R
[o8lgHIn2?X=R>BgjZ3B=i^n=mG6qbWQ7^KYUq^:N9c6eFSEf7^@B0Ql2p=d@<\E
iGn_GoDUBjI5eBaQ6cZJCQ\eio2l\V0H[cOXpchf1V^6An;P^aTe46G^L05G]lHe
=I[0[cHjgcm]Pa8pU=J5S`An?J8C?b9_=TOc_mKO=hiK==Rh6k@V:^Zd\68]TjGB
NH3pdhgnlhDHpd[kWLbgRqIHE8mb^?1S1cnaKY56Nm8XZ2kIZM=MoJqB^>DCNiUR
0]Q_2WWFU`5i_H@dZC25;EAMMdAE@6]^c:=gd9^]U;;Gj=0=@gNBmk0_kSdpLjLI
88J2>7ATmW[=fLV:0hpIW9[XmSqj\7Z>[IR0a`Fi3S3>0^CG:jnMDm3WHRKj?GmL
\<jQK73:b_jJ4oC_ojWb89d7TT^:f3_?@C>[XTW13Z=`eB<GIDYJYWSWj]lT1e5U
k82LdWPBcl\V2AN_LH`>E@F\`p9:Hd?miqaMP[]SE6eE4`JgG0Y?FV;7][K@W;7>
e<lcCCB2NI0=Y=kUSVXmKLIMFCL_Ym6Z^RaFC[?0WpfiYLDdZ<EF1\hN8_T:2qg3
]M_C?n[CX\WEMLen;8cO2B5m5Y=C@QEm@[1Z1I2[E\5NfS\b7UG8PnKa@R>Md0^n
\jkIZ@FZGG[ieK8hqojCS_O8oVG7Ul>oE?6]11D;F]Ej;>V8ZNFQIOXS;NTnnm0>
4:20FgWqiji5311TN]Z;Xo20E^Ee5E34qo1WeF^3p00@;S]Y2cG0IYhK3I9JH411
N4fZoZhiXiOQoGOOQKPpLm;H3SWWbeKgklk@J\KR;8\JmkjI>dOMc94`fmOH[4Sk
VCnYN<eg0g[g9474klFRIGVmhH\Y\^WPT7?JJ4WacC`BBE1R1AO0o0PMDO[UNE0Y
P8U@T3j48jNRm4S]20X0JK@pNfWmKc:qGUgaB7`nEPo[MAQDQ?2_L97I[aT4`_hI
X;VA7ERHcgpIkTZ>YnFBGWTK_63O:9;@Dh5NQSI3<AT8BbXQ@_nkAE441JN3nCN2
dD_:W4Ca\L_\QT8cZ;4aIqcPlfD6^QPNC[Iok<3<Jl05KLi0f@[<DXg1ThpCmbI5
eP@WMKVQJ5U4?h0dJnZ]\?ITi]jfRa2qlUo;ZHI>`U@KW;agm9>OI3[m<1<B;;>V
qhVgl`<jNk3Zi_mPbDC=qOUMhG[]qI@O17`MZBH<=QP]WB7?jFggQLDfW_BE;mMe
UW9MZhS_iYlngOjMbIHaJOjR10\^eg6a\oZKPMS]oAZ^H^GP[qLT`5cAD;d42bK=
>Q?GDMNne=qJk`85:?qfQAL@S9Xm:mTjNEZI;Vg;TCh_ES^pMTkh?B_0k^nGF73N
19SoiScHjA3C]`@DYc30SGYl7<7C_[?4\JYR?c:]VjGH9PSUMfI8fWXh@FFkFjNV
I\eM3P_0jXVLNW:n;^K2RlQgK:m5^[?4:M^6<C5GGcTcq9l_WNBUqK7f3MD1p:VY
fL6pX23hZahq>Rh@K4=NfO\1^WS0WdiXlG>6UAAGq;JFL2UH99W8GXKngaJDF3@B
AI8<YJgT=qA?76Nn>I1<jojVY^^@0EaWh6YfW@]96G5b2`fg>B\?^hp_ANm^eUpQ
ZCcNN5`2MHYX=;\I]<aABRZK6kC]GjN@EQBHZ1M9\16RU<Ej4G\gSW\X?q3h`\Xh
Qj?dWa4[S<p;ZFZZYhpdZWgd\DMI[hPSgGCef^`V_h5I1\5p:33DW]ChFfbX6kb?
igPqGf]@`PEhM1mk\4nQNJhmFG`_o_AiT<BemR5qa;mol7\?DP?IL\1QjoQ8;2lI
^6>i6<>;_gXUSfdPS`[ZNk[M[OZqNo?d5D7jpVd<DL[c>j>YGe;fPf2l^admo_nG
@D46BeMOK=3>B?cGpK0]`Gn1g=NSoW1U2@?gp\:3YRGUVXUL6Cc]C:NK]jmi>CGm
CHD>SXZ<P\_RA7dq:lj7WOo^BOWF>QVJdB:YK`Fi[joidc6RFHo?o6No<Pq413B3
obST7LV\74Y18LbLKUFO4gB<`DN]nRe_dRD_@=SI1ZJ9`0qoj@IJXQ0pfRIhf<Bm
pCBCFPT1N;9_[YSdqjRn;nfl3<1J@;:qB5hU>[2TS@Vc\e=mRZGI30JCh>=J6GGP
Ah[g5M?SgB5WJ>pi^nlBT^[p9l\L=L4GE5@aJ;WdMEg13Kq`D^=3k;p^DTF;[b7@
9XJkFT@pd9nC0c4oi8`0?S[GSVp?aoVN2kjVD```S7e\eRT4\eVaR]=bK?EVIJ`D
^d>W:V[DKNS4BAXBZFG8ep`UU05O2qdnR;B`o`\]=h^gV<V1lFNT0lbaOnCFTE^Z
;T7@<:lg2pLTQe[`j`XIDe9RDW9`hnNlTApd1BX;\MqB@P`aacikgHl:\1=qPRIh
LTXqBPGC6I;Y[ho9[_gd8Te55nHWZ4ej5JnN8Cq;:b;i@eaebf<4E9C56>pB;a6Q
FCGd5:5J^7o9R]oiL9QRP5RR]meE\Q\8L=Pf\n3lVXZBo>>Pj<6peBonoSVmGaNa
IjaTR[WRZ10>@QCj7:HQqVZN66^BqXkaFkWc1YiAI;g8W563pfV6hfWj3J`KHlLk
4`PYBeV_XMmpl9h7l]\p\a0LG=lpfDe9bD9YX6XBmW;<^G:<3[e\i=`9;0aomA<b
MCGle@5G1L4ZN1Z=0_@eUI1NK3c3<NV^:HHdFn0UG\D?6KO:cfYBgY1h5SaFN98F
B=@MD^9p3]`Z8Y<XgL=4]9Eg`7?VqPTR6[9>qBoKf9Jq@cj5D7]GLgLqUK`gLUmW
gc8=Rf>FB90jlDo>bdebEY<mG0P;N:Zh]LGdalf5bLj]dlk`gG_FUO=Cl8D7Q:[J
YVB2_gj919>UkNd^dZ<`UlHWY3k\lEOI]P9a2cSq9Bd:VOAq9:SdnP0VNPF:m78D
>28c<5XCOnJW_8>Yk=pCJk@f:bpaITeLYIDjB61UQbn;4daUJn1ECqLeCa>I_qU]
4c3a2qYA6feeYE2Ji@nc\3RFfY9Oe[7U4bZ7_hq]RMZL[55iX723B7Ni<Ig[[\_X
@3NG_:nZ3HnR[Gk^4@jcamSLnl2fE_EqXST<W;oWgaDF`:KnqYf83Jm5q\\;Yk8H
K1UlM\hJ8PVF0D21PPcncdNO31bfQF]di`SeA7m4q282cFDgMe>Ai[dV[J8TSAXL
e=4;jZR:;Hepo?m>aO`h_86<in`e2HNqlV=lRWK@1ADeKg\\m=Y?9j7OYd`>mWCb
pELP^7L:p<mAJ3g:Ghk8P<aK`Fcoq4[EG06NCH[UPfaZbaj8Qf]ZX?cqiLQdWjQp
2M?OhBPNDZjb:=@mR]5eee]?Dj]_WUONKiI7K5B3cKY\LN^621qd=a4F?Wq4e_8^
[bh;O7_nR@PUIa=JdiQB8C`=Jn0bYZGPWN=Nf?l1i<N;mY]`_MRW[cLR9k]>d4<G
SORHW^B:60Q^leA8IHeae37jCn`ojBOGm079B2qSCHVBiGpRGM_G]86J\R@XYCQq
@5VEAkYp<V`;^E=YDa50FA]l96;A3i5cQ>ii8:_MbapX?K7Ma9pQdT?2[Ho?kB=:
5dB?S\4cgLc_MhS<6dkTFHLRHV5OH4qC26_\\oL_MXX6YHUg?<gUOXQ9H;I3S9m^
4`Tp<a15jSaANPZlCe3@W`dS\fPf0>:g`4J4[_]OHQUW]k0mQjA[B38>VJpQ;B_m
iOo0dBb5LdKEW:3H9R>JOe>68WjM3[313]:qnY[79[m7BkXNiHPR]IKaQ`0kRWAj
EkTP^a[k34LT^h8lBLjZd\2MLZ_>eRbgWZ\UnkF8oE`1C1Hk3;Y@`d30hBDeU3WH
iMA@WoKQ2K3f5aS4=nTlT^pcNY3acXq<BK=Y[T<of7<C?b5keqKMgJEZ=pk<_5@>
bIjo3=4:G19_I=?UnE[ocDbcdILI:q0N341o>Ae[gAoKSM^R_UWHaL\_kELNUbR@
q^<[dM>Q3X394hTJGYkj5F>=FNO2X5QG`J7GN7Lil7C]ggPWn0FHbEJDKNY5Ydhi
NAM8Td`LfOl6L9;?_LBNVUE6E5od5gQIgAnZHF@^kNnplm;GEB_@2=cS4`gN@>BF
b5[=WRK]:Hd_pbY?Yc>2afTfe;S3f_H;nM[UDaWJb?nAk?QnD:`]lhh4W65UB2H^
YAjkMPZ7dgHeT@DnO5GDOTBNa3dVP=GY`X8NI;:lh0SO1@\Gi1SHk3GG8m@LIJ_<
o?Ui7T0PQ4dJmEcSqH?\=^7d$
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
Gob\lSQH5DT^<O^l]UO4ORVEL9GF_Qmki[8CRC\eTSemJIpCAiM<UIb6b9R7gNZ:
ni`HRCFD:8\dNa9aCqA6HA9`UYP3AZO;BH;Bk0[K^jHjniCo06=YeeMVQo2BF`jc
VahMlJV<5jWNf8VX4mi<3`6lqoc[PFbqkSRJK8]D5MiSXaXgd1?]GAn2;SCN>7bT
OH<lJWae[cK]q2oeZ^^Np`3RL=JGUA860dR^HJ\R1DD]j9EjTP34bdU8RLPji9:F
XMn3<@`mc::82idV9q^SH[\fCo_U85j4[5G=icaaaoa2HlU?IKTZYcqV?UEJl4pE
<8OPH?P`PQCGfon5SgSBW_PYEm9`6pdH18R5DPo^3gl@LAoGD<Va`oPA6A>G>loX
E?WQM6B67[U\J?`<lKC1ZFYhoKVlgKH]fn<bgL:7L760bGq;dfR1QRS3SUOn_5U8
Xk\kT11oITnJ6nmBZAfN607?P9C?7;ek:_:JO_cZgeO^DWRT\M8DHnFpMcbCVW?=
>OnB^lMgd6Z?0ka22<9PHKHGj2<`gUmAh<I7qXYo\A>NJoohjPaD]iPf>k<dD1d;
b?b2pF3UBgK_p@kSYQJeN7GJV>\bCUEX27S2F\V?XTeP`TBRdJO5Wm>^4C]fRi]@
;6g<2@mVO\>L]qW^jGbeMqCZ>MTlnQNgG27]f4=7a_QZd<Ye=AY<;6pnoRAIAPPj
Ei0Pi=M6S6`QO^3SKn>B5kkRI>LaZ5l`[g126Z:[@h[34qPBjTi`TA;S8>?Ul7g0
Q=\8=I?d4H@cXpb3gCFGbqn9h0RgW^lj_QG^X[Tm9Vn`6F[F[Pf_SDAK?K`kqdH3
VV]5pfGNTj9T>VQf=ZER[lCJ8a[WB:5gfQPqBF:Cd;cDE4?K;?9N^nE0Gj>eghb>
b>L@6bX<OnaL<nJ3CWjfN;1IH=\FkP=4le[0:O<a93k;BJ1\QIA>p1UmJ<^[@<dZ
60CXXQ_o]6MdQ;YJS<FfHKTNLIaX4k><`Lo9opFRI;W9mN2GIITjDmXI?a_Bm[Qn
ZPqgT<m?A0V7FNZYL>Wn63:k;]X_AK\cLG^`VfRcVBblW`JE>pN;US9VC:mJ>hDP
JXbZ3_F`OLX[@o?AbXpA1?1jOnqUKY3N?\81Pp^:2Mg9e;]SSEiCRm9g5GocR9\8
Tlm0oT1Lf?Ug]gWK6MqIOP`^`Hhd40@Lia<Na`0g_\D:FY:I8KECDlOZ2qYS6bL0
fcUVeXCE=QIc^I<FN0j?MgKUjq1h9=M4gq@NBcCiiqJ0Y<cX]pPl931_aPOT5KgS
@K9>g0mMBaNmgFn?=^I9q@2H4jHgK:n2ZU9g264nafH4VYepC9lPeYaY7W]N<7nQ
cl9F4<;VP2V42WhSPW:Pd4p<=?ml:`qaO6^]F>Hd3Kd@a^3@51e]UG8LkgMFj4e[
RZq7=5TJ8:@W^b7TC^IhfX_IBLj`kM?PlGYOM[<lRSGF6NFM9e0\\[G0UBq3lP;6
E85m:jeM7S_[mSAnV8\G]E;UdWhQ?VKB0k[>KePZnS\H3YaI7>J2\GYZ`2=JZ_QW
;a]J7U0bY0U4JJpI;0LM_UpPS>BP6^KI[5JEc:jETWDm<SE_h\Kk6=D@ZVfF`S\;
\0T??`B^61S2<UA<CHY:c3K6hmqYH2Bc3bjDB8HCGi[KdSmP6dCBJpW?:i9XWRSQ
?RJ;;lUMS`=X:oT47ZTg[`?Q@3<aQdkbp:U=i6a^jBRC8QVZA:efn6WB5RQono>d
c^ZJmUnC5j<ig[WRHi_F8hDn4cXe0U`OGpnWDVdglPN2EfT9\VBW\>Pk_Vai87HE
mBII>;<6TVLdq\U\B^XqMbO40GCnc\jN:Wc30URJ@_?@>LMW1dNaUBp>Ao3]0Bi<
GV]K3kXZ7>Y^Jd]Ki;m>9O@U:cEOLG1W`Seqnm?AAehpX@RCJjfpJTjjm?Wj3]>T
X7F[35jVboV^A^fo4SUd24_YFN<<hj<`q?hLB?icGIGd4QHkIA<11d?m0Hoo`MI9
G0JJoJOcb9R31;9hYL;;7=f6=Ab\gn[TFS?\iIC7h>[3lYVGEoaJTP7DnL[XfPX9
>L7acg\>fc]WRpZ7^U?7pmn\j`mZp^Q6BE6d:=^FN`F6TfH[E8UdG:[jpW2Q:X>1
G<dTlil63q\L8E3bZ6j[c<KdpGIU@1a30Tg\HK?OddUPBHDcnEl90N]BpgX@4X>6
Y4dhl\=247NZamnq;RED?oeU9`CjV8^4d=Y7cJbKBWWp@KjgZ]\;U?2:kXNZYMQ:
L<_aG><^FP\3pCCYGcYBqXDM4nkCpKC^Lkgn?07jcgB]?dhAN5TiWTN>VEfE;;hR
a8lBlL=XTp;?@?>K=pQPf37LC4AUR4=56o4PPf4n<aN`11[cHlUeB5q@SJ79OCq>
K2;1X\RmKG=\fk4D@PP9ibg3N^8IP3GX\FPJDmKcKN^8cSURKq>2h:IB>9iS<Y5^
7RDH:;TIU@IR16@UI@q20=dofH;HDF0RHhVoXHnj7C@cR9ib6f\BjaMbf<:<166o
VSCli<XK_3k9Tab?QDbTHaQA\>fdc=`4H`MpO8`OW`GqFPOhh^Kg>>7_ff9_3SaU
S7D9qJ@MTB1<Q12AH3K_6XfH=L?eoWQUe3DJ9Q^q]87E5gYp:JohAokkPNh=Ca7N
oaD33`ch3]VH:ligkC6kLk:pV>=Sjc3p`kH9?OpR\H?^KB56mgPN1YDn3B4T[o;S
<9`M=WCTb<7QlAc]Jj:LLUF3]n]4PM2Vo:\]?Glmhe@HSVq90iW::?oeS9o_oie>
74kN:85:GDO6efG2T0@LlA0:4coFd_V3:XgaGi7dV\F1U:6iQ213NkBg7XR>][6p
bK]3o@Ep?UglBmfQ8[6\\;cO<>mii4jc_9p6NP3KBnde;<1PGgekV8;40F3Bc_Yh
YUi_C<6POi9TiX7[h@KqHa2hK@cQp2A_G_Uo\9F^h0AVW1`eAjML^9bD>jk2Y?`p
R[?jlH6OpQ^CYN4mZjPfCkT\O2QYhYJ0hL9qmaK0`8DOjCTbVSceIgW=JOen_Kf=
c<Z5A=q<C>KN_lp]K\dGPi0YNei^;A45U3MbNI4Eb?FYH8\igAbMO78lLmQ>WlDa
2Q2Ac`;4HPWkc=13akqH?SP>7hq=Z=c3HM79];40FN9qjSIFlml$
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
S:njCSQ:5DT^<04Y3g^iDIH6\enj]>D2mOHnfB5cqLK=B2^OkdhBAJh\UNYdZY4^
`4S1?CBM<mi8kLM76RV;TKjk8c:iD68I\:]1@hn>4C89gfk2qh@k^o`abF\KCgfj
`d]SgBRI7gTLgl97Z]HLiR`XnbYfS9\Wfc>g5m\c=BG]BB=mHn^plV[?B`q`cc2l
l9VPaeY@3P;8HhphE2ZchaVXkm?Z3fR6@q>;S1bR3D>HZac[Si\2WOm\8DpGU^K8
fkX2AE8@d5b]Km=0Zq?n[9WIaBh@bLd>4M<cTqRKb=ce68FJA=]V1TcjK8b9;Opa
0M<CofpVThUmJ3iD3Eq?F;[]E;p<@bR54Bp:HjIH9@qdYPTAX]p?P3loC@lbSc2L
YQo2lpkgWOjJ;cIW9HP_B=_OKqE<1Hfo<8>cAUVa@Y4gddqm56UE5;iW4lXG3G<I
^9\mf17k0C5Cj4n5>VHQ6Qma7f1P<U@S>:UH1p^HG^=?VicHY94CAGW3D_`ioZj=
Z8a?qGC>hS6bWldq7e3jeK]_26KIDgABO5^V:10V;KAS77S:BUX@HINaHJ>I;M[7
h<Nn];Y=o[GoI@KX07Yb7A@5dbN0Rbk@aAV70301cZ:T@6qcFlAGUap=kLkagHqI
C>LA<B`765N[ZAbPf?C82_?InDOphA_G3<\R7`b6lGdI57W8qejWV[\L1BWBk]5:
J;FaZYLGZPJLE_bb:JBq<?Y3Mc9;H][c2@Zj<;6ZaW5B]fOV8E=o7Z_Joop;U`nG
4ZpkQlTFHK=Rh01gFXXV>WDc83F@Eqlg4XiNFHNn2DGLdl86?Bo\;DDb51Xm:Nfc
QkOl^llUKN]DnG^V1=VgGE:>DU7DZ0?fg=1\l7Kf]ckU<dLD_]qH]2EF?hqX8;AH
`afHb9W?U?g^=4a6iPTqhF7V4GB1c3MTE=Ng\C?7:H\l;[g@]_BGFgD91>8qK;ND
0\JmJ]a61G=nNZVGkOaD79EfnMYqAK[gbBbqEJkM@XRq\[H`U90=hG1DZ0HA4g8L
9Y=J3gT3_5oc^o7o[b0bV1]AQ8G]8A7?KciOC6Up[_7OUkWGk1q7=IBUORQ3K_=n
::D0FRhZ?AL1>mfjS7;;N1[8Q5YmDQIW`hFNWQgn`4iU8RZd7;J1=heW<g8]VMMa
gA7i6]]NeAk8mBF?lpccUoCAUqjEYk>?jU[gV;QSbq@>caE4mp:fYDP6aqJ>=YEc
dD_W6B:e?SH<f]T:mq?`6:A6mhAM6EgJU<1UKVBd^lZkj[i9niSjV`3DBN6@fmLD
HN2eE<oYOn_5E69\7Ii^@aCLALUM32gfO8aHlfPUSgFDb<>4@[<S<NcM6US2gT4l
qj<?\Q_>plRQ>91m[AW2i;jKcDeh5KHnA:XY2]aeK_GmUTjG=lj@`A48>:B2Ipd8
0^AP<LghngDjTPUoLW`Sll0F[37O8YEiqi]n30FKqB[7c\NRfQ`AaQHV3ZC\PgKk
9bia1Tk5lT?8DU7P4HHi9Yh9i946GF\M=g>S82@^X]>WgcXGBQAGJJepQ[VPUU@q
mjYQPiKc\[mg755AIFj:hAX=\O;O5^I=Qj9Sjcp8LLYQ_dq?BYFIeDp?41K\Xlp4
Zd`;n98OA59bLe2:iYQ5F`Y_7AUU_Y]W<IB78iXl36Z_ff?gA3d4eRMDXghJO3Qm
hRoIgFU<547jZ`MMF_EK3qT>Y2iIgCEUOPeVbi`IRX:l:HN20X2?2@lF7<@]LNX:
m@USBilT@e_0pGJLkRL=p`KQP]PXRMOc97JMfGGQGnTo]]OV9JdH4Be_p;h0]0DB
q6D?X[0Wq5\<A=T=R_46dkK=G52<XP`q1mXT@h7<Wff\BEG9W1UXEm]GnnU=p0Xm
\Gm\q<=T4oHdEc^IFmLWN7UZk7NI[4AN5DZ^KP7Pq\^jmX[lKE;MXjc9gq8?2RU=
<d]dKHd3=mY6CZe>TGc=T5gd5D;:JTCOn014d6F76^bUDQ=I^FX^q75g96gdXiCB
JSe`Dlm5D9anE6lLOM:h1o1gnQ:NG1EOHNBN=50Y>ma7]?Q1iJb4MhNcC78lUeO?
p09=9>;dhgbHoOjhX36cHfVmfgKCe>SEUpc7LJQ\EpBjP0HW]Ba84D3^1UqH>=OG
UApdQU[DiHW`7`BdE>\H334f6>cYflbP<cdjhBqBacgQSe78Xl2;V8CH^[BIPH?C
V:Np>ZR?HiCaNQ^H9kT[3^\90ZHe5f<SM6k<cfY6MT]BR4GSAlofQ9_oJgS450Wq
0OjYlh1=jZ:^hm\P8?A\lVgEm^P0d:[VFClejHYS2=mSKlCNZZJUeFoAQLIAGKcN
0@NUF>cOjOg_f>XWDV4Cj2^8=P4VQ2qI]bcLUn:0:8O_=ea7Wl;bAS>:53K4R4<n
GMchbf4IT0UB_h@R;H29iA]WnMN;@cbPgWLKcH]lZF8NKKZWkpdk=BKNF9;Jgb\Z
Ph`K:ek;^D2oM>R7DhPTb3f<:o8Si2Q?B[B]F_b;Ne6TnDL]7JG3pGGAJ8[FkbHK
h;U^9Pen<[E_E>O:WgMqAmke@@NgQ71b@S;3cF11]Pb7WBV5?cqFEN?;e8qK;5Pf
Ge>H@acnkI8<cph67R<G`qPUiSC0MkXT08=6TAn<OY=mA^]K0X`3_L:34q_mhH[f
<`_Nl\YOWi43?DNfO2pkOWV5A@MeBmJa;WcH1^=o6S^EJVD=a^l[PQ@U>Km1;`29
b6\DTfA4b]eWTiFm2BQ[UWbg1M4?]`pEQhf0NcnAQoXbGc<KdD5;gC`;`l6jWGS2
VZ9KC:18T<kJn[IX7hh3ie^W^pk>Bc8a]Tk^Ri=AOSMUGIj7]JXC?Kg16ICB[_Jh
ZdB[05K<`1gnW_9VVUkCJV1@eNkIiGh7KjPh>b=hL><VnPgN<pORDD`nI2_`gY^l
CiM]_`D0?7NlElO>dpAW@XFD9q3AaLB9mdVATQLE826>?odoWF<^27W5AiA;api;
j1`\dqb`ZTF7XcHNETOY[OlRmPjIRfjbK1A;FP]YU5QdB7MeUk:5J9XKKlkNOmeM
dU[Gq=e[eoFGmmZTOIdoQO:PFYDH94O_Qj>_8Q_KqTN2M3c@MT^;LYLj8K_iEh8X
QSi7<]O4K<]>\]Q3YeO4Jnk]IMSPbm9p6Im5KL9_>WR3l;^d3KAWdB8WPmTQ1_<C
`STojS?TEDeEa;AAH3`H_Dm[K6;WbiLiG@hed^HiOYA9lN4pYDoT\BaON>e<gl>Y
e5P_DhiAC;G?95<`@YB?8k3VCiDc]1?3TPFKe>ICJ\FF\^>L;];W38PooYdZSR@0
Zd4q`Om=?:N47fKM^n[lq=Y\C4`\bX;XA5n0V:Yo_2@Z[4WE6VYAqk3Q]83@UK_>
d_J6JP20D=R<;JHh0ogGpI>X46J;qgEjK[SABK56^H?jVS7eAeS4@d;omaDJAR4P
4CU^aWKbQUnN;W3oW5bAB\O_cHncNpke=B09<9gj\\o@ZD@Q>`eD?Bl\>;0Wa1<_
_qI04]RXIp5mCiNFWZZ`U@YA@KbKnVi\aH^G5FgJJCX:Qq`@IB6T<3bZO4Vj5Ilj
9H7K]ca\V]Ka6Q<9n5]:iTIC[AVU59hK]a1Jqk^=`1bZjhk]V[:28N1?`Gd4eIT1
?A1YBgo`CeXQ]^>33PV8LHTL:c\S\77;Skj1kj9N_N7S<Xj6^O^kp8L:Zi?OVES\
:81`TlC?o][]\;cAGhA8TRRKc]J\`\QI]7ip54gPlPA^^E9c^0A`gjO?fJREH\D>
BY8okWZ1H_F8[iKSMjfaC4:@hfPkkefiocZVhSOTkaB=7K:aQ:8[2<MqUU2Aohk<
Me;[T:8:pI1mg@VKfC\69<@H4Vbi^EXlXdhi]b8hq5_=<ZV5ZQ\ehNF[hgZiB4^j
\cHW0h49q\A7[g64q:FC8\fBkFC9W4kQ@ShOHa`H7LEEiV`:VqR@Pi\ndpk@j539
^5PF9=g_`iZ@=L>;dhgbHoOjf4NlhqHk`6>EjcUCmhZSbnD@pKmd]@T8VAKSHNiK
QneP0>7`4O?79_]@g`2@2G\H@nFOc4XWOgha^]O\=pd5n16gmYF^[MLXohnR:U`F
F]fZfPl>=eo3>Uk2=KB]0O9<Vn7W\a?JD;JLA:eH_EG=4Op]ienbW5?74<n?;If6
ld=4?:Jb5?@E:b[7d\MQ@OYdCVmRI7iV>GTm6cWaZCaKfCZ7V?L`>o`YM91\<PUI
U:M4NBA?G?MoIo@4]CpC_;0Mh9]h[;e1GlE@RGgH[4kK<3\gj1?^ZKFHl5n]8m]O
HajPamPaP@\BaBd2<O=GcFSIOWoRU5cE5URmIpbmc@iDc9=aJf=c2JV0kZ7M\fRc
[Oeeq5`heRXQU@iRECU^aH1HMBY[Wmge8EYFp_FC8OUOp@Q1VdH:TDjQmRdjnKi3
Qm6aF_cH;A^o=phC0][L]p01anl^=WW6YYGA\e^PiG4Id>UM[X`ED?g^;q6TnSRT
[hbE4L;3XG10GJbIIK@Va`H\Bf^4hg[RUc[`FRi15^FCnTlYq\fLMWMGJAOYf0nP
JK9;]meTS2JTBD]eO;HV;h@b=@1dB?m3Zn3\OQ1SX59nNQ1g_]jH;XmdJ\1L>::a
pmGZ:8kFDnj8[Q<:TS@4j>Z0kL_bBSAE`?D0X:iU<b8f11RC08D_N?TC>lDDK^3>
1?P_gI>NI?gD4fiA0Smp6]fL6ceWJMiAE31qa;PF9;[`YEG4O\6IRJEg\7f;KUCF
?:PQIRA\R4:ZMbNWq5G3@0GoCIBA9Z9:9h\KK<B;ecIA\jDpcbLlO\MpY;nl`j8e
PU_;B6NDMA[l216>e:HYpKamKCdoAbB=8U==DXjHd_597q\0ca@GVb@8=KY6E]IR
mWm`bf3g4c]3p_R^=On[poEWVSZ1lR2GVmI_Dp^:[=SoJpgdId_DaF2Qh5]E5C36
DCPYF:;aZp^^R;PL`qX_TGSAjWiLTDd;O\fM2dPaEH;18Xo:9f?I1pnPm=<T0f:B
OZK[8ga\;D9hD6X4IOKGAQ91hCTTked@FjcCZ8XOYH]Zb=dLp45=1\anMUCanfG_
QVZ>GB@a\K4idBAFW2R;ZAKYFVZH?<RgL?8FJC0PG2bBoDZF;<RIOFYU_?ZJc<I[
fDJph3`c6P5e^kjo7J6@7LcWm[>QII0D@ai]`dfI=1[Kp2`MlfCLpL3?e^[7RLG`
8EQIFG`D10D<L`J<lgKp28QVLgOp@]g7h_AU2JJ3TX9CFNfpEfRFm8:KjK_DTh8X
\F43NMlg_E23C4mQ>3Cq:4bn@[@9De1?[m]?pBd?7<JO^P1bS`;8bdRW\DhnC>P@
qKOG\g>2S^GD`FMl@k?<ngk4`Af1Vlm=fZ8`d4VbW5H3Cdah_dSFnBS?d3O>GqI1
AUoH@Oe0V[W6L;lBE[;>9[5m@KGYNR4=P?U>V1YL``DdWJ_I`eKAahhb@ZIJ[FUn
2PYY9P506;olqK@o7AE[[RV\Kc8=14lc=A36K4;[;I^5I^U6mW4hL?049Jm[72nZ
OHYS6MdT1Zok9:aD4L4dSOF7YDEU;_j?5bWNhCmdJq4UgPeG@d;[@?^ZMB@?EklB
:F6OeLX]GAPl;g9RNdJ<TnoW<E`f;Kq6DSn1C6pgC<>:RpDjZf_Nq4PVV\fLqEW;
mF8TQ4::KZAK=iYXgG@4N\kaZ37k?nN[2qlfQN[dloT_6fC@:5CgOj941n@h;Upb
2gAg_ONMIh;eROTX\5j>Q;9q?Z3Veo6>oBmedQ]lULkoEl>m06pi@iNIlgp>oISF
BY`0@W9DhV8>L`i^<^8MT=5m=MHe8GaCY:3p:OV3VBCincH;8jaj:m1VXIOGTSMa
\OTTi84_JE[`Ye:CNL6bXJIYdbXqX<8<CU7p5hldRP0AfD4m]KoO6aX[GG:MHW_@
>UVZdfPFfRFHW:f]q5`2B]LT7]PlEJ5D>i1NZ`U:GA=0:q\hAR6lSp=TZT`0hqBj
mK7i<qH3;W2nPqAM`VaYb]AKmLj7_^cZm0iai]J4:AQ=HqJjFOAhFa;]KnQ6^K:R
XlWG8HA5b?nXl\I0HhK3]159_IcoBeQXPP3A>qgOJU@oXSA64:5M3IVBjm_M`aL]
opMLZ]nfkQ4BfOJ<k9[M34^;GY>4f6;>HcqP0@]A=k30e3>QU`j9X[>H<o4jNk;b
`qL3VEIWk5W\7fi;M[iP90KN;k`kC5CM0lGSU?>HOQ0K3QgVOZSG:T3E3RT>WneA
@l0Oe^47]Uf6qP@j@?OiqgjceMjkK1j=dgQ@8?TciGTpN37RBUapQ0cXMA;p@LNK
;3dGjB6RNH^]NV^`^hq1\W4a6`aYTFT>4^CglTAqC`hQcK:9d?1OXOi>2dX8amgn
55K>i=:P:VAR3CKlaaSLh2q1hN<1UDqdX0GSGoRkmi@]WffWF9^H3\Q73TCb0`S3
f<SO\nU=TQ^2_RHWU@Ln6JAo;gA;2`Qk=lbX43SPdJPDZmaRKkD^n2<<7\T>U[UB
M^SKINEXgGUqMe]_4doSd81LRf42N83p36fJ3K`qK60D8T_PLi>[hVWGXEBPnaWW
]IXDo9\4KGUg]XjC`2Z=HeEDhTcd\LYU51:qf``2io]6Q1R^[jGO8==AjQHbY65I
U\6HpN6\Lai4ALDafc_[<7Af\\HFTGi?HjbF7RQbM`O]QQHeh[5C819JIg8<?KPT
`jlm\<\2dXnNFpd736HjfqUj3XeZSpGLFe<J2H1ij>aC<Y@4hcUbV^==[AZ^nYPM
bGn=gKjg^haTVj@L:PA]\aoZBNOFX_e6YdiKSdd\mIFV5CY8q8DJWiiU;6FH3Yka
5:aGpXb8>@]CpXf@e@ol^<Q^E]S65bCRS@\<_XmZ7>Jp>dkkC=AqAYF9]8XZdUOo
V:^F@:bC]g66<Lg\C493\O9H]_fO]:V1[7`OqPi7JiUMTj1KIHPW6p?J<RV\QpWd
7T;bJfKh1MUY=bDn00iTVndH:Kpj>Z:lP8G40e[YIDJBD0YqXF`?XMVkl4lB72Qe
Q3GqD___Ka^f_^b\o;7\>N0fqI?<W6AQ<>X?ITBZT8_Ah:an?FY=L>7H]:8kmE@^
kOhmURbjBpWQ7O538<>SokhEk?U6gJX76e9cFK10g_1An2S4A\3S1f1\:h@YZEQ4
7b>N8n1F0pj86<o\1qo`M`aGoAeVB_6AoWBSO^q[XdD1C\[I^;`<I]n=>6p8GZ;?
jLMab3o]BDch3Y^pe><FY[B>\lYf;PcZHX_e5DckKcickNOZeGMBL3f:l>QPW8Oc
p]EXjlNOqF6i]FYQ9OWQ[N94A>F4]SG8TWaH3HAC5\o_PGKGd?e^A4Abo8AglIHR
5ToqLaI5R812ef\STeoD\?Y4qlX5=9^UH<WfdnVjR@D?pUhOkSVdj:mYHNki5Wk\
IqVK=MYKk0:A6bcd<4aXmF>1d9]FgKfH=BD63eW@\>U`W54mlPpi>J3Y2<qUnSJ7
aiCWJAZL=JQ_L:6pjMaCcmD[U2ZVUb8fS3:p7SYHfNha6KF[BHUlS]CAWk5F3[;>
C<A_;\8X^0>\0f^<0O0?[J>9qYJEYW5WU1ZncJ]eA3T0LphUjc1d:i?`OOWJSk[R
FPSDYZPIAHZ_mkFF:fFMhiIG29HVMeqFXdd7JgqSf^=E2S6[g9ISQH\<F0opT?ih
T_cF4;;:mQC8c0YO^[<>4^CEpXA\0L26ec_EYBgl^g<=R9EXh6>@1nJq_Mo9NG9c
dD4iAkC9NhQdXc]T:ZBi]=c=?Me2KIR<PGTW[3BeWfG`6UJE=o0KR9ak6>qW=[g1
?Aq1IRSo4_?VR_@<dKBOZ;UIDCNKj3<66l1g>MC3GT=Ylf[0aC@;AgOA[q[dcOFf
kDkEDJRTgcH2KjTUEa_c>Q=V[:^O5KGFZl@GRI48:nbgBcJi[97]mWM@m]Dbq4;d
1d_W$
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
J56<5SQd5DT^<eVM>iK^_ZFBongXAh0^C7hpP[Re>YL`NTOOck;fO\db:o^i>HVN
4YeNSF6a:U8PNcJ`f`R?OGPjn:i_[GLJ93d]<MEKpJ9e=C9F_ED=JZdIN_O<ZX;R
WM^E^0b`gphROEO6qNFoG>4Cj^]Q07ico]S6fq9;J7g;a9hSU[RRfa_GJ@[K16pa
I:7IhTS?d5=Ded1WXF;paa_giYV^]@hjdMLFOoB<i^Gp9gS085DFPXBYQ=E^<4AX
D_EAVRO_A6XV>7qFRhJa\meL^^H3fSZ=?n>RgA2?\cL^I1fgP4YOWPDka6mf:VCf
Ba\D^[lqleMC@PSqcgcDUj2a\]hA;9eBnH@_`:=eRoOIfUdkMJoU7fPdN5?a<Onj
l>MjiaXea\@N\mZ?QT1>ElnKfXC:pV1UGG3@nYlcfo\ClJ9hRVe6YTd5=<^k<F0h
mjiXVIXAIBE_dX:Q7`jBE7mVC:TKpk=_e=Y[`@ON6:]bENQSKLYap48gcVl>pCSj
LA3DJAh@R2U<LKQ7Ea?DC\D<99BapBgRl64QJ1U1:IjIGffZ2SmLoaX5QB:mW[P<
eRdh<OJAS3GYg7MUoO5bd;JQc]F8keMkj_<qI2JIR[`eTUC=CM]`o3o50N[Sfj7H
UZ=3AMS115njg==q4KW@bf5Lb\K2nA[U`NUNaYP[f0Uh^\egB0]@qfA9MAIp71cB
]MY2AWC_JR1WgIEchS_>Uc0YFDg`<3_KJ2@1m0Tk6[G98O7Gm:gl\6X0_M_=NK4o
@jo`5_8l`NSM=LH7l[Tp;l?IONPd1gX<59NjheIQR4\ZkRO;A3O^U\I[RJ^l`i\U
oHAU\N`]Bhh96ae9?gZ^O6hg3\fg?_O1<LTh8iWqMh]Y5<XdFWGIaf92hhRGHec4
0D=l_`]_P32dl<GD9P`aV^qUn:]=e:?W92EI:neP:QSInlRCYfj@Ba\]AQ41@JET
NhHGb:lUEUC6JaJg=:FDWg1`F=HS0URO;g_;V^d]WZq^dQ:aZB90E_RCV`[NdD\D
MOb\f4Vm[cdfo6eRj5jMTDmaGd5D[knI_f<e_5R0]^Z^KkFTDmL]6n]]ZPPdkp1[
46B9[q>H3M0ISTVEn^LSQbJIJUENJLk=oYh9UVO`edV<;@9?R0n9i;:78f>[mf2g
L6TaEo:[Q`Pda[@_Cqe05NP;09Y`i=L5:mE4:R;ZjqE?lLfDZpCYUI<SK9G0GMF4
65hl=LehA<X=E]j@=H=mQIILIPBPEoU@BQXflP_^0jWKFpi_UP7XplRl7Q;3DY\5
Q<>BQ\kAJm`gY@j_^L;P^hWF@jhGG6ECFNei3A:mQioi6S`b85fJ2lLl7a`>O1Kl
k5VWjcgBe4N<CqR<Hi7SnIgPXV?6k4VmZ5;5a^PeiHE88lJZoFTG[P6X[fkbICK<
`M^B2Y2ELFZQUfRfH;]=3KI7=\`ORIj@daq04ZL\`26ED=;cn[aA@W[b9Up\=CAI
`fSNcLH^?Bi8;`3aVk6S`C8AR[^?7gTB>U=W?D=8hM2SX6GL6;E]eYF0@14\RCO=
f:UP9oDE\^6DJXjqKaBA;YTT]hDLS3e1bm[4<?24IPoHRf8hWBa<gJ\@NZG8bTKC
\bIB[_eaFF_=1ME0F]:U^G?YgJ^hjCm3;YRpe:_7QSJq0Y73h=WNUZXkdXTDTD7j
lohOGL\5;hGRB7WW?GKZ1SZUB6keW9CijWLVoB@mAV_9\UljHk\L9V`pA\n?FkSR
8eBSAO^CdfnLTD[pYFd6NL1p9:HM>bi`lYbZ8K:^43h6`Y8U2@M5hI0J:Pce\Ig3
71a6bVihm49b6Xq_d=6Maj;??5NDedBKaMklBoFA3^oREB]WJU<5M6Zp^_iDBX]q
EKhmF@;OOecd[L\@d@^hVikXQ6ML:]ZF?L>[e[Nmed<1==mlR0nCX]Uk;necaolC
E<JmgHYfK_H1Z6XF446Y74Z0Pa]d@jZABf91AP;DDjl52k7;j7qL_7dJi0q32nO_
\]p?<R8:n:p`h5Cmmoed0P8;oHFHi>C9TQ8aN[JU3E0^X]dbZaeqW]bTNMdZTHBI
m^_=O3OeiCHTGlm@gY8YgLmbiiHCo>V?;8H6c1`=IXGMo4e5K=LdkZ;X`_>OPWb7
[^]:qb3oeDI6>`W6[R4fIQ@MY\emKDh07>iYh_MZoq9CKom^ap6MbN^mpo^iaDoK
0_iN[jjlT02LWpk5\\Al:]n>T\?28H4LS^Bd:_C7M]^e19mkH3lAEXIfRqc;XXT^
HFjMkSm;@C3=U_Bb1_N2P:j<[\lOa76j<ON5ip3R`69fUo48Qc:bLbU\i8RHT=H5
EC[M:98RhODihIBKXpXnCXIQiEL_46\=dOIg62<fbjE<2fdeFO2UEUP]aEKJ`p<<
8VdZfpj_aFj<GQOlHGG?3=hjZMNT8>O8Lkg1:1q5W^cAEo\?mdMcWmT`[@AH?iDY
cBhPNM^TWGWla`k_=iD\4HR4cCYl[0<Qai`p?gZS?K_p[R_;KMqR`cZIBXU`4lRY
JckZ\7ZpdkC>8]kI\bc;G5aiBC2T[3h>6UdCQfeMOh`Dmjikk6bpg3[bQD]j1g83
6A8fb\[b6RgBX8>`ocHdaR6OMS_1E>5pn[5enbB`<k3>a_;Ve1]7;H0WTPngQCmi
TY=?<E_[?hQqn]m?WSE0Ub>>V?jjA=C[cjjJNR0gcTM23Z5a_MR2WLHpV:\Xd:op
lVBaPOLlgBjJ=9=V[XgZ>f9K;7_PL862q1AamI<i:n6A7CB[Z2`nbZgFQLijcBc[
0p:?67@]bpb`0:Cko>WBMWV82n`mp42APgk0?66NaKW``H@_>BK0OpT0nX@^;Zoc
XK^FG9L`Y6Il`hjgJ@f0a5FKdRSP]WfMGBqBmNS_?\<9c:lh@k0GV\jp3d?ooj:^
36U@RN7>\_A1S[f0eZle41\K9mp;4h:MA\<hbPJM?^BgOaJ\oNAiT5QIZL11mIfb
?PmLVU5\UVCWYJ;G[B`pJ2gQU4kqQl7J0H=V;0:i\1:Z>97aLW6a25EKBkASSG_G
g5a3MNgB2c<<=>NOWNWMeB@md9Eaj`GKi0nG_?hOqHif>>cj=g?SF6:gYYH^\I_d
ApOOj4OGLq>k2Ek9;O0?0ZaRS>caP2qRPVXaci_k<[;4ea>LK_OEI?>[HI\<la1Y
_3lA0<VRgQ2bD9k:R9DjGN95L\D]\nbP?C:IhL:pc`Unn]nYF8C;cJR5\l?dcc6O
6LhB=>92q1MQi[1?ZqY>U<LFd]g\]P=SES8S28qEQj?^PY=4>G=GIeJf_mU>Z25N
hcS`oO`fUe890Nd=LdnWgD:]c;E\P>nZ6nIR@a3mmq6AWRYa@kqQH:Pj_C0?SO8o
f5lJ2mbFbgL8Z8qn579kjODIcKF@>k9K7V]VJHODK3e^WmF^SfaeN5ZXB669NgX`
YcGklU6Bfj=\6Yk:Kp?jkBg[XJp>:BQ9=a=F_V>m<m1L7_UiURIPn^^^^CX<<8NH
;qTTbfaD9L;IJE8KBIXIn7NZjTUjdq`jV=Z;7^p9k4N2`ZKq^?XbDS]iq1`5_ibD
XjB36ciB@2^C3QC[nh2K[d@`pn=So\^;?2HRm0<3;Vlg;abXY2UETB`\]e_5jjK3
ULm:qB2VdhCdA^[h;;_>TG_B]J5CRbRo\`JP5Ta?MSY`YITVDfJmSKWNlGg@To>p
`1Z?TFLge=bT6KQIB>:L9F_K?8Hd_<DSI=0mpoH9AV[p\ZBFdm@:\k8VXS0=^`kg
b\RnQW1`dVP164>a9`Cl3ISY[V4H?JCbo<<jdAHN>M8S6PCJAZ99Wk`R_G7IS;::
lJL;mmpN^OGU7eB:BWCWgDQRkB]Bi?o0@K:B]T56C9BHXcdJcOFeON0R7hF7ZDM2
:VlLi8EAeaYeN7ATNb9?o7;V:5O96p=SE2\P2FbC:H`i?ml\4J0L_9bJ9h:]QgAN
FoaOT^0L0DWgXiSh=WQWQPa5P@ZR\TGVh5TacAC<nfCg<E5nc20epKGmjFo>D^;]
5AZQhNN?``6?b?@0ZC4HEFdDQP\3:e4SB?WNOGi<En3l`;gTWUBESK^ddUFe`6KE
XHoW5kVnXp=8i51DZp`Q;dBU@27^=nC81:lTHe:Ak9@cHlKHBi`^lQH<?AEE?l9I
gR=aFNn^aQ\;SkcjT1Fe:`\H:XkV4HqT\fnk[oR<Kl^h9_[CXgV7E2:qKOEAKjGR
h]]B5>5cGAROTHTgPDI6SMTk^J1>S[M3?E64gc9Ceail3dI8Valk=[pFjP<SaRp:
A1\idF9m:F4C4XlL6afQN9dBQffN<B1WFELM5L=\VLY$
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
aXCVJSQd5DT^<0@Y]Q`d67dIB5SVU=pVI:ZUnkoP?TEle48ZmNn_PUpn9h_f:`]8
kMPlMp`7:4_6pcj46:fXS\7GO<A3nem<<SP4AIDOq^1Aa56=pIlJd^3@3M<Z6Ld6
fJ^bY;YkLK?peQWk0VIVLbdH_AfZTf?GRT2YX`D2RbElF8=A]?p]9@0KjDKVihOK
JZBIVU__]B3^QV8qZg0;>OQqP=Qng^QjOWT]:?GKCZ8`TTJVYPPg`Yq;:F95mGqW
P405d^3U[DoVZ4S_KgJ0_VNd[hqT`1SBloJoUMl2J^l^j``bdW47QQe[:?B<LdlB
2C;i_Mh2g8a`i?RcRQWk:^B\T_4N;kJdGPpIam>c[BAJH<?EUgj2l0T7eq82hR6j
XT>>M\:^81<6:]=nD6b4:LBUY1hchmXmjk2mSCLe3DE]cYH@N5pZ9igWCfq>C8]k
?YO?40]DGgH_ZNRbej6`h1ONHm6e<QclRYh@WHP3o\4RIjIQlgC[FK^57oLVTVQi
W^N2dWIR2aSQ0efaC1qd[boefZ]m:RTg77UOeZbqf:TmLY=d\]RCY\dMaCN22RoV
LWGfY_q_6017:aqECl1BVCEVm9bnNVIbRO<ShTBn^]ND>]H?=ZqG5\=<@M^V;_4?
VI9N3o?7N]F\g?\C?R0GmnVa7`UDFj[fODL5ONVml:7f05Lga?jMPF8D1YkJW8KL
_k3GBA?>k3qk@S5dD;o<>YhR8mh5:jAqlfaRJ\GpKU3JIl75R`fkncMSH6dCE0`m
P00Q^M4^HAVpAS>V6SBGZkMpL^NmSbf`0S0UZRA[O>bb:eiFpMCG^c>o1Cg5F5dL
RACO<kB<;;eEZ2Qgf2HaTY`:X0HM8F9YH9n4?fZZBQI4S>E8EM54<[>J0pCS<A[h
Jp]NONXLPPJ42[KT;fminY_V[PGC4kMcENO;3Of\>\m_b25kJp^9c]V:PqFH3Lfg
:j2k?hI0jD^meDVQ6KI[@q3mP6\Hg?>YKaG\AR:e:_m0p^PkaA0nBdcR<4R`VQOc
n09CFU_YVSd4jd:Tp3IXWjVmIM\0mWlkiH4_jC?npMj2al]W?f2B5:SnFFSjL1dZ
O2h1OHj<d`\Dq?;]3CV?QDKGqUi@?dolainSlGR3<qCfhC:C9>jbSkon>SC@E=Y;
I41VE?QYbQbfLmjWqHDd>OSi^o[ZY=^3C3gR6<6U1lNUU7og]Ka[;QGCg<QanW7:
]DXm]4PI6i_=ZEN3d:eaT2?Nhh9Gk>1ecYaXS8PPJLccpL33G`X9ZWWII;o\ViNC
BD@7gnQmZ=mXV2gPJ1cAep>Tg6lGO0]kGgm79aJQ8m^8<NZ8e7\Se<<FidOmEl7h
EJ[4BMe:2A8f1LIRJN480?XcANXScTDaPdo7\A:?beQ25cB`Gq3R=;>Hc=<b\\B;
DId=]n?K2`WTKN>2jJiT8ZpRhd[\g<qm1anb7hq3SA\S;^>h:AfaK7Cl1qR9GkFD
J0ZH8;bWk67UIGPL2D3g>=`4ieh6pHXOW6ZF;:DUO:`Ik^IZ@jH>THI0_9PN2FUW
n8LOd8>d59@iSL7FCEghUFomiM\nSb6HS=^?e7bm6P]T3nj60WehZNQ6MAh@aZJc
lo\Lq18:V;Y]m8:cWOTfW<a_6haZ0;gJa_ZHIPICJp72U2<TWS4[SXdC_=K?L9Bc
g70bfZ5QNY39BHajD5m=Rb[GRn2=`B3O2@hJQUml;5gEdgJn\IQLR<\G[PU>BEeN
>lTe\5c?ZHZ_lE?UnqXA?aela2XO[K8kDbmLQn>6M_?FbaG?q0F>>LVMk]bLXCVm
2D4QQZnBT]VJIT7HY:[0QqRhDl`I<j9Tc`64n5LK8n4bYNm@;mC4CEG9270Vd8[D
<KAAne<OCKa0?ef1Lk0oEO:CH=0R=Dha8cHMG6KnN6NgnM31do7^GhY6ocWfVqo^
cbI:MpZgj>MD:p=m2h=G]m]CAKgYONeAA0\PZ?Y9=9SeK=SX^BYMmGUJ0kokBOXQ
=a^H1=3`6XChmq>BLoD0LINX:W_;`8D]]@`=de\Z>c;;cKVUCUZ<0G;51DJ0hgB\
eACLci\S=c2PT03X^Fj<8:AZX<3b4AMPGp1iYKh>bq\^Z9QT?eD2lnI<AiZcGQVm
3RlPGfD[>q>`YUE1CMgHCUn02TeFoCh7F^1=@ZNk=oc?YCn6OgAhkFQR;OoX;G9k
0ZBi?mNFdF0=VofETcp:Hce7dkp3>7`K@WbPIpj8Ph4QniVjh5aG^a:kb8SA<DmS
W0XfiH=E@oQAI9Sk9H5X1VKO?gGMa]9PQPMe;3j9a@>2EEB;D3mSNd0OND>R3nOj
V4oRp5=Dni[cW^:LP;=I6JCAXpUZjZ;NQpFOiXgWC@Ta:eaBVZW<^2g`U2nIClNF
KR@iU@6WPVEX__e22kC6\CDbqR0dSUKjq>RLl;=pBgTH4S4>5B\55^N8j=Xijodd
Y3lOT32IaV9K?TI3CUDZ_0P]fELE;0E:VZk\=mqPDd<iH\LPbm]`>]KWJ]dF]AW:
eeJIj]V2?4Eg__3E6ZAK1MgJn4\6ZM?;m<B^4YaPhdojT;7HV1knd]hphMCiB5C@
3ZK5KGFn^XINofRX5ZkLRolMZP07C^InGNeGfl1Sf8?_Bo?KWhT<>MUWhYC]cHOE
FGCbp8lJ1lE\99hPhOY5Q=U5IA0M`gJQ0Z;I99ccm29WOKLnd==WOXA5\h?Od[[6
1A5^^8WJNTK:lJC<JpUbdo946m?mP<[H[V`g[9bSKLT@N17QliM14kigWU7c]ZKL
PRGSg7^K:[3F6]]6BoBOQ7?A[NZn7pe>:nRgeL^n@?^\L<0MHWAPI:SXZG>1lAe1
j3WfK@^fj0G4oC3^\fS?3En55_0An5QFWh_YnWTTpNhFHZFbp@]QYVF`qlPYHH_>
`gYh^9D?3ZHaFkXPE@TOeYWQNZQW8j:SU32\d_dHiTIMk^8bc6ILDNW_4YEHCqQd
>BTOR\P1VV0bc4=C5dAnhFPhp2@SY?ZJWL@PKOF;5G9Y3OdQ[MK=90V\=p^]L@kC
^>YWDOUKfL8RbIlkWNekNJ@^4G6=b?M1kH1N2BJTLq@n<nD5$
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
D=Q^?SQd5DT^<NWbG51L7ac;KKq3Ojfb`WFCBWc63N5bC?0oh4<djAYH?E5d3lmc
:]cR6dMna@ac90_BLW8NQE?Yi]pS[G<g5<hQ6JNNgZ0m2q61g>D2p\__dH?K=5Ec
0RbZ6VXh7d8bU<fTJF@Bjj\>ZLF1k\?qUY\2B3=qYb18QnX\X;?YogQi7IQCG73F
8O\TWTg\GXQb54J<S74p2kbedJf0JWOYP>fRR;jGAG0@Y2<VlCOhiZ\Y\?8WC_R8
\R[6JeZqVj[m\]7p8BD=^Wq=n2g<@b@fF:JNB]<g3e[:l;7SgTXAg1^BE4DH11Tf
8:7]Ol>4;;KF8MWW6KXT2NCcCd=2<nIX<kYWfYG`\Fh8`6`LBb2lVpj4EF=Bm==U
\:6AX:PgXE18LP>?4OJ7i4p`Ji2MW2C8KUcjeBho]@B8Qgl4VS:VOXILXalPh>4l
a<O3U^A9059hVOGHd<>G5TO34Pg;jM5_jf9bd[k5HZmYGI2B7pmW:<e6TH_LX4if
Y;KlUFON`gGLL9V2hMCM2nNiZo3Ul?O7?6NNI`AcV1a\<9LQJ?DeI>_Yi<dJ6@mg
[GDRedAf`TNXp=XemTNWPVcoOhSoFN?eFIYb6eleO24d7GV7SBG?h`Vj`]m[f2k8
dg33E=]f4m`1cJK2LNme_B8]21\Z6AcPFk3l7pA[@dAQDp5\8=YRF8m;jVmaI4cN
XK8AbQHYIlCf23^UUc`oQ>FVm`iX@?@[CF=F\>`9hbeUjRLh:cikQgV0BUW9GB<T
PQhVB@CX;[4TOP[bqAMFm5lURK<@@]m9\8QWmIDpI<;;>:cq3`OcHApeVHe2SQkE
Df2S986DgKB^WFmOa@OLJi>:SSQd06BIWa3G1mXQfHndb5XaGIDKPCeXADRc>1AT
?7B577JEPBeOkQm6]VGH6`YJIUbAG9RnhZfIe<_nUUo2PdS[5Tkf:Ole`CNKAgq?
l6_;K6Y16N5f\mn\8Bi06Ng>KB8\H^od852S:iXXZF[`?kfTdiSakA8X;X>=BR0a
]\p_\QGQ]?OIo^7fi@g`H_5O\Dj1\liC=jYW6kCH3<h[A72JfU>2QQcig3G<n6;j
`PekaAhCY4i;bTEOGl\OZhRDK1^jXq^fHdn_3BI\;Cc6d@dAADdT^mC;]8]EgKFA
d0RZ8P4[oSi^<TnELjIm34^55[WeSR;fG=;\<=9FQhhdUcd[6gDAgIBcqX5Lh1dR
7<TAJlUUEfP>Q2N6U]cgT_@e[nmIeGo=m5<XLg3lKFf`I0b9iGN2<=e]a:A8hPIg
1ah_E;AlLlNkb7\cPP6qkIWIDU[K63f7GoT74NG369bTd7nZ7ln@i9Volkmdno_S
kS8B>_LP\k:;QHo;f1VO7mkZO=D=:`4`a=cK8dO?_?12SJ`F?4OeT4q`=MkHUY?V
k]6c\K]j7MRA`7G;1aAgONF=oq;:naQJO`m;Z[TL<TFm014`C1kF9m>GkLa7XfXk
D>nZLT@>qTU8303:dhG;F4cfeDf2ga6pJR1@SnPgNQok>RQV[6=]DbHMo?T:D4g9
ph@EQHPDY^>4:=RTP9hCEQQq6Oi>4gZO3@SIhZZXEcJG8@gpB\5kn>5?[CkOKT@<
Qm8D>KK\O?fd@5ZASD@_70Ff]bH_8`\hb]?`Y_Qg=dc8[0@5<]DaH:<m[^[[<n@?
Q6g1RKap@SaC32Kq]SJX5napeOXYCB8qTfG@5IYpE]<Fcn4l5F;E9hJbYQo9n>H2
kW0b1ToT9N^FQkSI8cCT=M>kJj[mCI7Oj==75L8kHGW`BGIf8_dWJQ]]GbcR72>l
bBN3nCi5Qdq?2BhU?nq=C]A97TY<h;lQMo3V[f3cUiIZ1cK`OfEGbSUca]9EdLK8
Idf<e^9K706p]gV7;d?_XU`DGiV=?XfDK;p13XOg\kpQLd;nCnCXMXTIZNG8UF6G
381mY]Wi]Tg3UX8miL@M9f0g=^AAP5pnHY=dQ5=CdD936`40R=<V8@=5De_<LO@d
?mqe^Nj7C[NRF:aH`IFLTFgI25\V3mEH2n0VL9qcbE<Flp8_OX\7]Y`VkC=jHk58
4KqFk\h1=dCoWbE\RDZc=VV@aT8j:QcJ5JhX8MgPc><chpC[adBY<79J<OXJ1HEO
^=aZ5H39knFOXadNk0n^VVN6pdRN2O<XmBGP:^fjdVe?]mJ=>T[EXWSWJP:9kg<P
3IBfZemiTGgioO^P0_6LpAgU<fMAD0HmW]@E^m?]QilTOUiJ6Q:EghAgPcRnIRep
=cQ5M<UHb:7RN]<dO7WCoe_;kA3=:<0>EhR5BD\N=JpGn`I_2cqakoML]5qU]??H
Ap9D]dBL[pAK@9K7gaD@FC00^C9;`C^kp^T6>8LcpN0Fm6R9i[YJE@ZIlfdLb_@8
g7dV39jEmO2YIo?M\C_Hje\Zegf2eqdDN3TdWqO^EB_^\2d25=`MIRiV]SA4a=og
H<E\VSB:DR@f<[1d?<[Bc?mkm_HGnpPEffaB8piB@9O7h\7LX`q2TBdf3N]l`@35
SqePF3clG@2_O7cm[SQk>]8I_2p_e\PfIUYRaLV5n\g>[b93HifK[B`e4qT0Xf?C
]SgC7^;1qWfTlbX4SY_LVkWR2e=k7n5e\n9Ri9lqkSVHLnk6;?7f>`qGO@L[c_PA
02Kc6]clK2^_M;lDWn@iDq<4;HmD6Y8AXU3JqP04gX1P419\gCV6_f3VU2KjXTBN
\e;qU4YlQ9cYVhq7J\l`oF[KA;4QF[1S<PVL3OlRHO6Y3;pOa`Um]?Y@\NMoCj<J
<9DKZ6j`\l_PBejIm^0g`pnGG5\X]pm`I3nlqm<4kVLee;@WAi?kX9]8\ifN<N=E
Qan23]AZaX?cTSkOFE4Uoe9nmeDnPL^1a<Im9Wab\8;aAW9k<SZm:=`Ib9WA?^JS
GBUA1BcQT=<S8O?X2S4]cBhUlpOA98N[19J<Kc?hA_?V:R`9FdQ:CH?GT>Q2Y03J
O4Fn[lFh1D;igA?0kD0jF?8Jf94Rf0R`[3OcjTelI>dMp2gTIl8PTimkOSmU5FHK
dj6Zf4nFOCY2FhaDYDiiIR3]gAbRU:ZIdo:e2LG_elB>K>P51M1b^R6U>N_;3FYp
^Ab:gQKY>iABHW;CU^?joQGW`EEU>32O<_U;NAKdgU5NIPMVmbbL2leN8Pcg2jF4
Be_T?JBl?869Kk6Z3aq6Bk0OYNqB2IRiSBEBLOkW7J^HL2`U8e1mnRE^1nQBkc=1
5>bAADLXYK>38kPl=P@FTSES>0EoH^T]f1cE^SoR\g\NHFXEgj;N4b3TK;GB`IAq
WKeaUf8GM2Z6]@0lH::g<lq8KbDlLN=24:k8Pj4O^ig:Gj`kgZ42C<5Rc3KHaApS
bJ52LgpX_PnkSqBi0I<QcCNLf7E3C=O=UGQkfX]U9m3:1dCl@[LD[FeX3Ie^J?6[
\h3FEX27Oe^YHcVnaHo]65_QM?6LU?M@SMQQ[QXUYlF=OFIm2=14lWgc\m47:eG_
n4e1^W<N91^GHc>SQ@neOI\RM?6CX@:;cDpFnU[P3S6WmbRYfBfUhJ[U@iZ@C<j:
1aDZM0JHbbA7VVVGGA^nMK1TC]?l9l_BFK9EQ[jllLU_Z91_<`ZEPqG`MV[Qa\8U
09bPJW9\l8=k85knT96h0VK7lSGlpj:H7D02j7CP5E4U8:ffNfObXK>nbNO;hn8T
3^GMHW<S6:1n7_]n1Io<E5;1Si\6kH;TYKL@cTCl0m\1081p9l_ZXjd@Q0PGWnZH
Vc1CV;`O38?ERL8`iQ?J>S\De[I\6oaEQdH4=m4B^a[ncW7l:7dan]BEKaKHMBf^
KapCS?MDigQkZ8Ql04PRLYeW7lI9ni3AaJ\N_>>k>o[ojU]SOiSRnef=KK;B?AB]
aiH<Xc7n9?^8l=Jo=`PVJenD5>eB<QI`\cJNck5qOBSn^c@l\L0XPfMXYP<MJX8[
B<Slkg37XM_U6cpPG90gR?6ZHn[N5`bMCCATi;gmfWTJaSCp067hIChm<O`?bM;^
L7^i3SKA`6bB6S34RSNRbiR^U<oeXA5ZBcnBHB7RQkiJ39[pVSTJSV_\aNL`j>8j
=a=`nA9j6RNDCB3o8:ajl0UQki4p1SR`c1p[0R4j_N_CCdWqmf7OW@f2Ja3;6YLJ
?PmCjD3d[Z>QE50a0@aeFdaTDjqM5j^8YgB\7g2N^3VUJHe\MbPPZH@C[cdJHH>>
1]6ZOD19SI\Ia8p:?2Zd2ojfM\<j]o79U0RZ2D`A7a<;?=dc7QK0ha409q663m00
=2X>eULd`679FFM6FgbkQEBfnQC_::H\L5IJpclX@KZfDjB>DOIhaLjVjdH3N;O8
lLl=GEK7:WkSGcdp>_LMI0_T_JeH1e>bmaFa]k?:QLo33bUfmjN8[gja:7<ZgkTa
k^Z62K[5@NGeV@kX^R4q^AliT?6q\UNTWMecF4[S>g66HmXUAF3L^9hg_Sjk_g?K
R_qS9f[Y_oq@IZnD6p^BOB=Df70\M[?Y;V_CXqTh\U6m8Pa17Y>[<SRSf5bFZJNM
HaUY5_q>LT4@M30W6<]?fYe@a>cahQUWU7?E:E_FkfIY;bCJS]cb:j9LGA>F;U=9
oPdO>m<4=^b9<nFFn1o2`:FQLWe>Y87K8opBFn:fEZp1iB<ja?hpA3?F7ln@aQb<
bIdgZ6UpHDd17mE`3=\ifg0IRFj7`CQRo;c5^h`bG5PO5D1gL@KCbDgjg88;T>?0
DlRgJaAk0OGaE<j_<1i5_[YEL:oKbgdKCTc3i87BleqFh?QBe8qkPXOeR\1BE\Go
[\DR5N3Kh6]?cGMJ4IDjdcDnop_oC`ADiLqYS^nZS_q:]S\hO?p0J2SS9lplNmdR
JX74ZAWnV_ZHkHJZSOgbSEQ=GDdkRM>Y4X=^7\HP[;HN7kZSAHdCkhZMB43:BCfG
g]L;\4BXCHL[4d8]YWQhccDoC0jP^qAO?`nckp91G0SY0GcC8hSljPETWZ;7q09>
e=Uo;`Vd\GKcKiH8?Vclp3I\9`7AqXT=<BTob7W23cDBFP?l>ha:Oe`NWO4a`6VL
q8nmFR51eJ<4Sk:MNd<<6B8D52Dcgdo05ZVIqHcR>=gOp0YZ\VcEcokC9nJL4HS<
h>8[_^dTMokq8[>T4Y7$
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
IRjJhSQ:5DT^<@H1`XXd26948lL5hkCUj_]h8kMBMPlKG7o@NCE1T;=XU2Mjblec
__WSoG1TGVO^ZGdRpBPK0baiPO?DoJ@=4SMZ`YIMEko<RHBKOTN\kFiQ[U[R<a34
28O[8P_QD48l@PBOOXmqBl;hY7GO6h\n3ece;Q=kKWkUa4TIRbKKT<q^8Pdc1q<D
YNa\;R@Oe5g>M[KdNXdN<4SI]SSW`0qlfWH6_j9g:Li;Z^E88hNXCqMkdPBjU50;
9EW4j:LRcQqaA@>R=DKUihbVOg:j_OQPZ`n@fCeXj9[blpa68UT?VQS9m6:@nnP]
5SGL6iQ9nLXXo=H1Tdpfg1dYiSq9k8@[<co5j`_2\VWl`ZCYFT2GNf:63d:oQ?<n
aIkBB4IGTdN<DFlP[;qi`RZdB9i4<AK4AP3YeBPI1ZhH\bb49dTVm]Fn6NE4\0JV
VCoqFSXdf]?PCH0;IeXW8mmj\OjKWijSdTPB_Ke<fUEMI06V\Y2qAQ=BRjXAT08R
?0:_297nUcQ>^iaJ8NRdm4H1=>hn2h>pkiCnCgHph;YSdfe7mZ7IW6D[_I`OD3Oh
i@o_a3@mCg;R`FWV2\A=SJiMHn3P;STZJNdf:D2PKBDUHV[XIc8gT5=6J[:^7NqZ
h;\@\=8\2lEhIc;=RFeWRnb\UNTWHmSMh3MCOF`TNU`^MYVOAD1SDH11m[KpQBiA
N:GqLXD8DZJ=o]G<Sm\33WDAJjmjgV=KP<DVqOQ8`R[1oeHhjH84:Z2XJRMAapid
@m<NOpQ34^Z3iqKOY4c@h[BXYf?Ud>b?^D>kMjcdD0m@66OJAC>QpnE[_^e3qH2M
aeYCd_W0mj<i3\Ol2`c7AJhlK>On5]?1HHg9Kmh[4n@_7CM1a[j7p1K?OE5`dnQb
\fTgm?8inb?e2RUNXdG;3EMOkFaoDS\4SR5H<N<Vif8`GE>:>>0e>q7`YnKU_Z[F
L9g9_E2SiZZFkdS9d1oA5GBlTFJ=a@h]l6oE>Ap3;hR>MQGRc@bB>HAb=b4X:9a4
S<KHFG9Dh81_^a@\S3p52`B1h_qdQEMY:XGnm9`:c@i>3_bo\k1cjE2R>RaCHgPa
HG@?lK]FhHQS3aLZha9nScF3LL\nD2FfIAdDJOnUda=3NE47dfq:HLoi4Xpg2ffd
[e6f1XniSIdL^TPhXKTgeK2<R6`^LD\o;Q4knC^goc8KPIT6>5g^jRdLFCTOg1gM
1i>37]BT83NP[b^qk6nn<Rkn\SL_;b<8<G=R?>g7PNjQ>QR2TY\qWEi@8V]OFdi@
iLRfGG`bSE][>h0D`2ReRggUVgh[hT=0=[LJnNjfU]@9<JUOA\[VMH303OljFRY@
EXpY9C30g5>:<\gMl`^n@lNAlVaqIFo\hl5pKh`j[ZXg\MC5_j2Ii_>ApYo<HYET
qO^ND<a4q^8Zn]4RTZ?NM;<R>]CN]H[e]6f4@WMdXcapl1[HR]oYl;WU\B@m<XXd
g4S_f4p?MB>VnhqDTo6INQqXYL^=hhJ7mK0XWI[PY1qj8fH5m]q5ae^2@Yj3=0Wc
ASfQSU?HCh6@U8jiSI[QK7Io0^Yp9Bo3>M6ODlFVCTfSml]=\515^jH]A>i[fMQ`
L^3X5L\QpEC1R0m8:EY>?mK;_3L6ZFYCY0cNm53Qe4_[K3<H9kTZ_akb2G0E=NJS
5qPLA2jkjm_De__=NIJW1a2b:JgG;[[OBOL0@Q[f6n18G6C@_V443U5XW:X;DWpV
Nn\:>jY9\bdMYqJD8oDXLp_TF^Mo4bJ6qKC:NfVS7a1kg?_707OJDNi\5?2]BBVf
o]5Ka7l>g0h6ULYjIpMZTF\K@oC5e@_PM@o@>Y5K9>nh;G1h;XcBdCF\OJUCnakb
V_Pai>oC`nmY]3o2H6oF_h7R8pP7Sh`4apdP;7U9qLC8<o8kWP>STgDIa=VMlGcS
c8>W90K?OPYH>V@\E5jBE_U;=;\lZkU[q\@oSGn_eFC_cYl?X1fnjEH4\6n9hDEE
i61iTILPW>H^PqGVHIE7eSdkE?8\eSZ3M1fS4\Zb?ZkYUmVbQ;noNjdlFhqCLcUN
E@Q7\3bNim`6c?2l^R_>K`1?Dm>gmI;k=Pc`N>Lhm>YSH1m=UG>qWa>8BZ@_I;ml
cE2Um7D8UkS?C5hlo?e7Q6C_[c<m7H5>;ke:VKk?:aCT\ai\p\L=^ZQnqfJjNXi;
QfE]Qn0MT@T@bR9MSY5oNCR:EBYACU0>]AeV?AVKR=7TiG9P3De;0Kie3@kRWA5h
_phF2R=mPRi@p<gS0CnTgE0NXEgSEWIeaUEmd82Wo;YiZB6<?9Q7fJNXB2^Rcln]
Sp<4;e`AVo_Z7LJYc\d_B5CXDNEXlgA2SF=m\@2GCIG^k<BFd0TBmFDLSfaf568`
[hdJkgljVSjIAp:DE0>jWjP:_f1\C5EcMT>ac4FHR7S?RlCb\B<Yje]9K]pL43dk
VNp5WHl^lqofmD?12kcb=S^9EI7__`IbRa7X0`V[?\CQWb>V^?XMVXq;\^^7o0ZA
mPU05_CecIQ7J1RY189GNZ1S9U4;NFP=dB:pf?Djl?aYdY`GGO4S2KhY1TIoaB4A
H:O7BOF[ol`KAS=0;6i?k_SHCf3Spl\99Gh4dTol]55ekFm8kEeYV0c>^CW:a_f=
5FJD8W<YVQhZQ`4DO;>;2\QI^q=>B6<7GpDQ5gUT:O`ZcDW[iCBk^]LIfpcS2EXO
;LJhpR^>WZX8A\`RBGd`fY;IJO\RaRBI]TTV510jmB?lPM5YeQdd]cel?pmI:_jc
[2H7ZK08<n]EocA^b><PQIg6UNeS@GDL@@e`UYM;Q5l1]`]JmXBi3ehSiD>jEN>k
e6aQ9pgLU6b5\l87g4HZ2bEWPlPjj\]kRF_@kTLAVQOX^jaMoU9EVB_>Iq4V0Y66
6pEET\\1$
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
