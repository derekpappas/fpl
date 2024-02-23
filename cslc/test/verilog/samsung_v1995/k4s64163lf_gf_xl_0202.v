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
ke_kgSQH5DT^<hFYnD5CaA`J>aOcW4ka8<`OPbdVTSZ9hK8oo;8[L6q7:BW`IA8=
6?eD9`OO4BfJ1d4k@Tee;3d7\M2>Ulm[:4>mS51M5P5C`W[S=6dN>78IhO2p>XaG
R;l`g9f[jSWhK6d4FRiR1_e];NLfIW8f=WWLh>^1BcURFP?XBL0E9hiBkKfgn\YQ
VnqMYjU2^pbOaHF^pA<JBLIfpbG7aTnDddj6[m9cao4bcb:nHYXTko^WJll7;]o8
>G0UBieEI[Z4B<NdbRO3q\njc?]iodI8m?PG9Bfj<B[CEL46\Q_?egc?hBmq?47>
Xl9Cgc>O3D[8f5EeG1W5:Yo?[Jc;b9qCcIbVhBA;4gi7\nIk1eYXUJL71e=9lNHC
PD5GRi9OnUq@X2MV>8MCjka?_W8T6n:b[fdclB4nkE027VIMfki^UNpZlCg84:Sk
3Q4UIIR7Nj3jGTLY4VCMcIPqD\:ONKAPdULkRjFWjPe37UNXlIUVfC`eF6P0ldp<
_>cdh\3UGjRccdJV7gVGd2N84D5keWo;]pAf4J<YhZ]oao5]_WVfHLhldD?Rl3Ck
gp?<8D0_VoRG]NO>GXKc9MRWIDm<C@g<8CQZa4Q8oROaZFV46mhP_18H2mDSpH?0
S@=ap9n76Qj\S_`2]gU=eN[?^jiP<jS\WA`C7iC8Wp63Umn[okQ2XO^0cP3b=enS
9HfS8Lik=>ik50^[1IVV];q<55o84ZqTF]V`1H;cY6Fn?M\=FUZHUik5Ua9qK0K<
OiIRNg8?E<bfAU]ogmHeV^33FDJdRTNCpZD5i8NkfTnZ[C\XmgK9QEd]0lcm[L65
0gL^?<MeQ8JZPgH@RiJXiU_TGqGb8TOB3hEdeP?\_:[QYm2=VcbUCOFQ:f?3qEE9
EXioqc1:A`\DpJ^Ri:b?Ccfc604U0?Rj`@AD3`EeS?e=fUokO5EMGj=3[:<K^GX1
fn71J8l1<KUPYZDY^RXXBX05E9[@FLUajSPlf8n0[P>n8CGVZSiMo1UO=gSEoW^p
Kb7_Y`[AJ41OYWMD?8n8=e2G98o==0>?9Z=OLmHA3JO5F^C^WRbNZgWCkj@hpVUJ
Ekdjd4DlRT6OgA10Sk8^Q60Nho@T<Ge;IoCZj@a5NFL1dWkqkLim2oRP:CEVcJbN
LP]mNT>JoATGgCFZ=1@o>DndfF3LknMiY^QCq]2G37j`a^AeGbNgn^SnelS23TZn
cfPTNSCSQ;CN0`K8N4]GSU6RK7Y[q:`^H^8Q@;4Ebd2`g9V>\_Qkl>XcRPc:WW6X
9]UVFEaAEhXmjGm10F;1mI3YcN9^4qG2_1f2lM4gN16k@Pjh]MQG:8?IhL>FGhaj
56nOk]<\I=a02Q<3k[=d8f_fWqk0A7ohd=nUV^PAi>Kc9nmbQTaIcEmn<\@m5^2W
g89;j62^8aAFmB?P1YoSD\6UChnUDF3JYF]C9LP>3\D`q];6g97iTYd9lS=]BfNk
;]9POLik7C@ShX2Q^[WoJhgQ<J?AZSNVdfG=<hgf7=JP^ADmmFDlYo<Qgg0]]^2H
=GJeA;MX<V5KRE<nCO;Q[no^bZ_Pp6BNi8`B>YhXoH=SiBa6Q:\hHGD\35fMq[nD
XdNY5`OOSZo;JCIWBd_78kT_nWP]hK>DLN\bPYMB=n5NLiT]GX:H4eW?6`CP5q;h
kP^97WakUa[Ta8a00Oidgq??clj>iAHAJ41AO1odNHLlcm:NSn]nlX>9YIJ?B;Hi
KP0hQKSc7J>mD7D7iQb1=1Q\@1J@Ao4<GoI7`b9gCl>[3:A?Ped3AFFe_<RDpe@3
HIQ2`g`5D8NL1Aee>h9XOU]JQY]^Oh]2^mEUmgZj`99NP`fmUXiD=K<9IHR<gfOd
5^U9E8HqbjM]CmK0\X03G@8<9\Yb_R@CkZ6CXF?3]@IIf0?gN0naf;?JZ7pGXY_?
5DKP19C`E>qN:5IW3Uf:@^LgTA;eZ6KlZnhC2L8G0@jWG]eN=qKb6hRYe^OZQ`T@
hg^gYggg1fg6a7GiSoEP\j2ICq8gndWEUDNd@eGNjQLMUC>7p2I:3c8h<CGegd25
oG^[5>W6p;E7aIl:D;9\NmZA5m_V218Ld@ZB]pOM^c_;lAJ>?R76go0LUZlJh[P6
Bc`U<7^`pcXW3D4oRlf;1EK^KR`p0@[]D>KJ_P=?ej>G64bqYR3_TeXZXmcDbgT`
EY3;=G7]qn=0Noe_HWD0ZBg=QaOEnX<DSO1BUZL4IdU>pklb;=Ta\F;bh2O9hS:M
Ebm]0`6X^kG6AK;9WA`H7\^MJ_3VY>mk@LQdoB59WoX7odhGHZU^BfFe[]apjed\
j?gV8^_E4?<9>b3]CGT:6f32@EMCLY8A3kD6m;7;E7bTOMEcUIe?[T3RaVU`jh;J
<K$
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
IS>KeSQ:5DT^<RS`dJTU1`@=G6\]4P\f8m]GVIjKOcq[a`V`1B:C75>c=3;p<AWF
^E5mgaNkCP8o\O[RLUiJdg:>1`_g@K@@J9mZ:3OJ0<FS0PPG>RLRP[^]pWiR@4Oq
D<<kK[3h_=9;5<``@R=92e\qSog^HWM[DZ5USWc<g4^KH=fR0dio\P]d9jVbgQQF
_MmC=`=q5IS^8a<i2WcZ5gXniJF^L`PL5dqYNY=F8obbFbnKM0d^VIKYh^bF4MoT
glV\ml^k6pK:<9Xlqi[YPaPXjACPSRUOjOEH[EG]F<`?pbk5F`PiiM__hj5Uqa`G
oRG1PdfRHY^RDc2LaSBj9bhQ]bOGIS3R=cWpK?nJnAEhh\@2I<h1l`4SV]\DXVBg
S\0ZH?nDbfQ:a:0VDJA2h`<]=kHSG>bI4d2p1c6j;5^[7>VdE`11N;V?D;h^e^?6
NXQ\nPV4=?>^HF>6Z>Up;JFdl`6pkiYhbI_P72ceRdFeQ?gN4[69@Eh_?PGQ5Un9
EKF0_6X`]S]>4Sf<o[bfjKiC93]qiCF2H1p^8__gKKa=CCI47SgI:72@NINGUGo7
_Wqc83>\dSoNY_g4iCLn70CT3^PJgCPJ4aUD34G`mkqGKD=I:?gROCkBeTO\_SJ6
M:X\j0LFQ?bp_NE>h^pQIjIMU_D:lnERRI=06NOUIh]qQ9S`HA^^?_G<mHh@fJ^A
a7I6M[J2EUH:OS^`h]ciCVDH8V3UAP@4kDp[`>]QmlGoO_B=Yi4OI;>;5jmFJKC4
fQR]7mR`kiH<O?LFU<ceM:8FCWAVZZBk>IfN0qa`JbVQFRjIh;KXGm7]4TcYZ?Jf
0AG]cU6T^pfP19LKpo7?DOeUqXEQ?GC:7]>c<U5DEYfD1dol^6oA]i@?e\\\^@?]
Tk>LkVBYE5I3nWQpBgNF6YA3R2P0eTQT9OVX>XpK]VAC5Nh5Vi6CA_USim:]UhqN
RX]XgX`7;<?e1KlU^bb1]HpYCPfTGj>KGajfmh[V9X>Diop3JJVm4lB5@[3alR]d
9L`pa[PHZ\bJ?8m0_hg<`1]c^^q8Q;dKc`ifN25JXXjWaIK]1p6TL\G`>nGi]h`F
blk\9Eb6qJSRC6964>`E=fWZOoAQNRUBVmT@ph71YXVVMKKD6KT[[lWioaMPl^mO
p5BgXk9`DidX?hGeY0m43L;_XmcVfpfYWBY=>DGYlk>G0JR6\Fn[_`1:PjqCXjI@
]4oA@2VD=NS;e=djo72DENpfnW4nill\=mmXk0^J9IP1cZI[V_2B1?qON<VF<Hei
]570ekM9<\NPA]O8nA>7og6V<]a@XRECILPM\HK2nlga66kg0L_]PSN[mq4TAi^H
K8A:k]A8i;k]d8GCB5DLYI28EfqLmgCHF:VJ07V=O]38_Zda<8:;=0Ip2SPUPQgZ
6La[InnH]>\cRC\?Z3UIXnVDg^CLiO;K=Bc<Z[i23]R\[=kW@>p8mc?hDU\5c^EC
e]On3@:V4`Y`SQlc85hUbq3YD5NEq3hA8ESq4Ib7SQqkg@?nCpXE?EX1h<2;>Sa0
_Sd@CgSR<?MZLebSeQ;>?]A:N0h7iUfO8fIbJCqGko=1>80kgBHf[^kU6GBEhU?M
jmdB5Dp;9`AAW:`GRle2:53b\2[g]lUJ9I[ckfqO^[3eF]gV;@5_jVH>I0NU]AAO
NW<g7q;_Ya9h[kVR3RLJoh>96?^OI\Wd\nT`p[Mg]Pn]Zh?3XehMGD8Zp>i?<h=q
CKCkSK2o8g0;<9P5q<l[Z``qhoMZ?>pk5RJ::qe_icSkYObjdj]U??KBdMh]NC8_
<Zf6HqdkN_4UV;`4[T:Q5hlRF7o7:O<>56TOGp[^>\8NmNcl7Jc7;1q^6h:HK8m2
if=hLibjBX`K4CcAa[MG1qejADjXbTQ=6=@TN:_@hEGHJU@`H[>9q_=PB_NX>q39
fe3E[poDZkLPpRGW8VaCp]8=j4[8cDcbHiTmaDCUSD7H=jEociYapL?_YmjlPnk]
`lX6V>Wl3_e7^^`SB0SBpX]KdVBWl?TY_;;_PIe]12fHd[9;DY3LIZmqYUNMKgTb
4S8RVg8fO^>RY819`D6BPmp8hOloDWb@^[>A=2GYEZR]jF]FcE=d:pQOeVUXcp9T
b9[_JD^eK=Sn]6:R@m:T]nm=l]iQA2Q`4>1S6Pm@iI=<3NK[aJd]@93g>AD1C?qV
Ga>ZYqej4_;2?pOMPJ_?:\<]jTPkQd:0:dMh^^p\Co4>Hc@d4_B<LF<H3a4\gdm2
jWWbnpN]1960WMOOfQGh;[`_bMG61mnT_Dme^U6lqlK7^;<4j\CY1CQK9@JVkYTg
OkLcYpFa:jkAV8LkfNL=]>J63bfiQB;[H`UX<WqV6>_@@L=7=dhCMHRn=40jLHb<
XSRi5lYSU`ae=np2U=c=;HaG^SJDWBRgEd1;WM06RhR<?DQ5E=gjlm:q8:k2hIXQ
K2N6_Fd:Hl29hT8kCGXo[oj29K:gplB`Ym31kGR48\eQ06e_:XFX[2XHC?ab2eb:
Mp[bG8:W^Rj1d_C@U[WVbRgFcJB92K0YIPW4E8q1k\gc2`IF@>M2K8]q1=kbE=T^
kDW[OQX>2h]cUYgRI;7E@d[:69@piQ\L1G9K6U@>>oM3DK3V^XcE0ka@6X:^[\Xp
OjOEniVHbN_9YlAZdYCWHILMYGL_CSIoACK_\LqHOE59AUpgk5Y:cEZNdRAjbijR
mqc5UXHF1:DZ0WNnf0@TE<6hUEIZWA8QpBPVKGY4VVFMfd2;[QMEla[h\276:Y2M
q7JBffmoBNJge;UE>e_[ZB4X95T>AXCZp\5@hkVHq`dnl@<QDB?nH?DY1]iI@qR\
6=O@^BQ71KbKq738E>gc_1Gna:8;=B9a4fj5]8@eBWScmEG:pFZ]<<je;LSK0m;Y
]W4BjWXh1KWZS@5Z[`5]Uq;0Z5>oB9_bkZP7hjNkWeJ`j2eM`6gb;Jp@KDA_E6qZ
_]a`LD9aFSU;=Sjd@:FS:[5GoE02lmle1_p[7]7^EHqSFN?ZRgXGbWLilkGmQXO0
S`\bIjF=3ke?UW80X`2:TYVn2_Ao0C`kD5N7L`5oBiTRFL[;RS`E<W^ih>j0fZ>c
:]4qi_@0\Z^jS<IU3F_dD@dOTl^lRBN>ToC6QBKqO3XF1=hmXDHS`[neEd7aV6pX
J^degCIfhj>9:U=XFY2UDCKIj4Vpd`>hWg:1aD@UkSBEf5qHATX6OJEdKKNP?l4S
DUgZ7IY3^fonoS9c\DqjabTWX5?mEK6GR8AT:i:a_km]BEnhQnH1W]c5]JG[37Wj
Cg67EOoHn@_ZFH@bTL6RRaAg2q?m@NN\gpS;F85\=F`4Yd0\CAGK0OYmZGgBPT8G
8J4[PaH0i5q>ecV2cWpdC^WHB4iWLhGGY3^0Helnac58DHKB?c8^MDIG>];XEOTf
MXoh2?eV>`^OFYAF3q2Z5AOiU`l>HVgj\Y1hCa4L4Q[@:>RE@2jPaG5X[kK`>U6M
8I\;mAnTMFCdEeOe;XY?=9PHpHF^KT`fqF@4C7mZ<bEfUCK[[`J:Mh58?Pa<U`ZJ
eEEIS[RK<:Z856Am2AIfg1FUINg53eSaV[fH0nXSH9B:[93\`l]W8jRLem<DRhQQ
G57pX2TiTZQqX?oTK6BajJ?A\j_iP:6epWHbcncnEcd1TDHao53EVSoUf9Q;nJa@
LMCLR1k27a[Eo1a7Oh\aIZlnUGF[kQD1:SEiC9ReOF73RVIilqbCj:3e:<i6n30c
81=@ki2[Ffh6?f^W^fU[4[com;CMKYh?cTqhCKjDiCqT9ob6<Qdf5epA_D4^EHpb
Z5AH<^64n01<Tdi3^=J?MeL9<hVOYCGa\ggIPMphV^YaAP708WJ=^;P:?D@0cKCP
6aLLKe_VD[lG@m?2Cf_EEj`1jYZ8mV<pn<onTh]NXod;edkLX7PZb7^j14_Fi=Up
A\A3GZY4X@0HaQ^eR5UEN<HeaWCcKdIIdGkZmCSQG9GMMK2=WdRZOJ$
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
OQ_YaSQ:5DT^<h^:F:k@QnK60_7NqQ[@IE^O;0:;AE=7@J[Dm6OhI[eO1d;`Fd>L
J]cqnmW0fC\O@:YkTD^_RakLn6bk[bl[9@UeMS:SV?H@\2WfR0O<WaLBaP<8JYhE
\BUL84pSl;\EnqCR8[_>Iac0nb2j8fh@[?ZjoKQ7o\BMo@n<5S;k<=nbP2jODZ]U
Oee6^E7ZpkjX;I:H1]2dXLcEK0FH3CON6oS]HG;4gL858Z>OM^oXPNmMB4PO]dNA
e5=Hha=G3oL1;:^]JVN8qHYI^GIAI3_aJOF?nlXT804qZD2ZbciZb`LIo6E<UJ9k
^gI\VjIOd8m`:B^NYUTDn13;?b9B@E=[D]dqkMo=n[g0nJlKPAb\<TEmFG79k1\D
:LKD5O<2BY7l^eBE]Om8H>CJBIf_KcK68OCdmAAPPV7PY=>3]KS?@i3pR3>lF6Zp
NjKn3EG_EaOnjaT17\@_@=`CFRTOb^EnDGYaPT[l?DDd>Ek`c_HXGC1QfL5>Ib9F
k?TqXUm>hImL_UI]lYVdLHXe>e02R@7Fq1`4;7:D=;nIaDmAimVKhPOS=o3lbNa\
A`>p=:g`3mop:I:mE>ZUG1o]cJ``L>`dGDL?UWm2nkd`_Xmo;Vj1EbW_YKEfmb:>
G:OlpELf4O<WnCW:c5fX==Q6iMjYh>WTTD[CDAFdCDfC@SbQAU@i14QZRW?9]FN9
CUEOXm3R[WeX0<LGNSe^AXHR^p_7DnaLZpY7Tb_[VfC_Pm[ZZ]3?V0^[D0^n_;?\
hpVYknhUieZ`lP=4348`bgSmAJJ`F81P5XKKpLU]F1dIB9_l;e]dKE<[fPaG3P_o
1bY[DT7mf\`GEdcSi40joN<aIA>CGqV@?3DfLERjO[?NP@o1bl?9W7obeHnRL`kb
nQd=1=E[3mmBoi2;HP0mU^^@VSG@@gZEjFMaon1X@eQ[64_h04pB^4aQjFq`U`^8
<BJ]>COfKUW2;eIH`LO80K^KY3pK]ef]h?l;EWMoA6AeU8?Z]I0pClF2?Op`ScCi
5=>FWJ:92H8CeBGN4l1F?ZdSJ3QiH=dR2RYZL`VVWcYdNhLK1;qJb=]E]X?:T3;a
S0=AV=dQI2Uh80?=8Bf5N>X_YScZIJ3ENN92WD:a@`GI3T0<<`^\Ecn<21o2miDk
i;4TY`ph<P`E^4qf;NQ_mY<0Y6;XKW5j<_Pn=8WjYgkqln8AlhN4IaS<DHRbWPSe
<=?5Wjfi<RGf]iQV1@6l8=l6K2;3d7YYS]1c7;[p\mA6f0=pLP78bV;n>C5l6D_o
<MdZbQX]9f2^Z86DF8nPnNYb_T\?faDe@o4V3[Tibg4>p0Vl]P@9ZieT7b?jbOf<
14Pb3ViXZ30fBGM]=Fa:QKJ6[V4`RLf]:4CL>ZY0ciEV6M>m`Qd9^`J8cMnq2W4N
4bcG[B`FR4:e<K`P0W?Sam]ZOQfI:aR8BSEA4_g8GGPHeDh?WnAS<oh\`Ql>2GB7
fc\h=VFfP2bG[8fg0oHc0kHW>2p:R][A6iVd<\f8E@4f5pdS<78L5;kEp]P]91S7
1ED@``oYno[FGMmc2Y5k6VF3YAlG6g\Rq@\QP@^\T9kTT^977dRDWB7aEcL:b[5m
aoYkEq_T`7keRpCeYmd==6Xc5T6BXS[eAEhPA4qVngIBkiq@bJB8`VpYOboLRRHZ
d9GVEdP5P?]jmUFL]<Oj@O2pKl?LHL4<O`<bIha1[UNdU54dqDPN4`i0pW[\fkQ\
L`@ijQGIVD:oWcYjqc?<AA7N_LKVJN7SMUIAPV4;M?T8`pGg<G^QBH0RJ_BeZj7R
0O4ZqiejNnnEoc>GBbnhjLZkkqJbf`U=OZ2aMOY<QO7Z]Q<V0N2R^NTo2YI:qJ<\
[jG;J9QmX^IdWVTOYf;XH\fWi4l\3\hqLSbb;kJ<BeSFm9kO2HZaU1NQa@4:1SbI
e4L`I=G?fOU7gLDpb1CjU?9Xa_17TI\WXjRPN9lET=Qq;3Pd0A^a;2Fg>_II9O8\
d?\[2m29Tg@k2dqL_QBDYap0g94?9RBTJWFY8W6WSH5pd8lF3196[jO70Y:MZU1[
Be]O4F`GYb9UFVX4nWW6O]^Y]k0Hd0Ab<STD[cmVhLU1Xedn;4J[<811JT:9G=Z4
>\]1paeBME8:Po:i9o_4D?JjC9j<[Gapcl?c]]Bq<WfLhVBHkcL_eTDe9I>\IE]H
V4MIU\SlE5;Zhb34JbVnZC^G=\8[I:imp>]PV:k>m^hkfD`@9glbG^DVi1E`C5\1
qRHLiQ\hnT0o;`QjY]C\WWVkh=FiA0>Z0IHe6BCF<k7A\m]FfR<Rj_8\X`aFn_FC
;:oLMIPS:5iJ0HNQ4VbLePjNipMJLl;GjFVHFNffOIZ8p4^@0mj=MM?3D85o?NIH
cLAaLZDq>MAH7PR;j:KQ_SfEEjb1ATeDh6@l3egXAh?]0mXO^Q9T\n9e7@QHcdge
5eBg=9nh>XB7H>4AphPVf0O>q6FOh7dd<4Ug_8IL`KEDm[l_OJl87eM79[Sg>:5I
iYP^[:@fNRG`6L2Z8@_?iiVEQDOg`g8@LR;dVF`8=IMeEa>1K7Kk8nYL37d_OH9n
^]0qEXE;\O6f4]Il93\TGkP4=JD@K6q<f>iDEgC@b5^a7me\Z7UDbn5=:>5ja298
c5iQN:`cVoK9^YLUR@bIbRJ\KRXN6IqERhD9`@plNV3:S^NEAM1lQpB?1F3Y:cg^
NLHf_@[JI0f\omRegK?9ibQ_?o_HaMpOWUc9b27GGP<JWBo]hh;]g<nefnC`a;:S
<KM91DAR5g7aM1HbMkdHKBEoGL4omXqJQ_9PIS5YjBAkEDV`ETbI4O4Af9T:\FM:
:JSRZfm_]L2dfF57iL=mQPY7oCOiA;:c[l@hXbh4G0]UDlW`;Vk\m`[>fBHda\;N
^MHTkff:7]ZK_qU>YiY7o[kccOIiB`o=REbMc6NjpQ<iWTi=qdfeEl@j=4ec0FoI
8WM]b^l?n4@?N^BKqfNeICC70I9[44^2=a>G8OjY<\XRe<>BagBkWDRep^MoO[fA
SaUPlMXP_JALLckZhYFciX:1eKF7;mL^o5YFF]kGg:3a9k`dW1RTj0PX0>`o9JZ4
BM6qYUkhd>BmoMSO7A8:OR6O;Z=PIWdZpG8DGgka2Jg7SL>a:A83pIoLOdA727FZ
fUCLPLAM0aWm8TZB:do9?CHDpEaDRMgSA[b`F?3QoIT9A_a>Kqij0@Y6PL]YcgfS
jF[K;Xf2=>O8bK=[^o33iejGMoaTdBnOo2`YBpkOkD[n7bq`4<jX:_QdJC5F^F<@
koqH;a0Pb2jX]SDdXZ4X_I13PPa`g3?j2fSAW@GRN[dgmpYS9`njaHEDLnQ4]@\3
JPdkhC[n\781c:S]6pJ3[C:3L`PkSLV5<jW03[QaTnB29KLW6iYaS`cm5fhPq^oO
lh=I7K2eG3`XP8V[[^U:a3gP2KE\kN3aPF06RDm:9NoOm2:PqjeZaZ8\8pA[4Oc5
=7NN5b6=G9_6P?8`^Q^e]lP4q2DGNbOcPp@i>S<0go7D<ocVcY@H0iQ^CI<nEUXj
\9ql\`7JiQ=IkgC9^F=iTRd^Cp4QB5P0;qT=jlO`SdS^YSIF;1i=dGFIOH7PS]bT
hn>4m3UVZ\:WLleBNL@=[]3P23;UjokeGE`PI\EGefJ9l>lF\[@4IMFYcCE3kJFi
U;NmVAoS02V7c<`SIKL44SKoRESTAiNVq];DTNnEpekW8MDWD;2<jiRkUUaaW7:f
bi;=i]0CmB0=H\\;754@Sj[2`ZXWBe?6oo`HaR<]Qe@^>TL9p?2O<DESHGW;ZE_X
:=Q^E9XbhLm[\adgb`O4>]boLdKe3:B<Z:bgQ546dhS5MNI2ma]5dhE1@CK[[H9?
KZ@pFMFL@V358BTT]dE8mGWEE2NO2[:YMI1fO4i0XSKH=M=A[Y65Hn?]?^pMOFoB
iS4j14D=k@VVRd;NJbdaInl7TBq[aH@WIPDo]CR3m__XBc5[P09qbQ9j:m5qAR;N
KDYYP^]nUPmjS_4on_5[nQj`KXm=oac]mYT_>>>\aP<g3@>Z>?n>FfQSY5?eHT[e
X_Ic<>K[^2[3S1bC7JT8jfE1V]m2]?FXV<Xm30`Y;;?94O0gJIni_f^^e^U1PKLq
80<DOEfJZ[i2DWJ:`8@2>OTbLo:b`P1k6gUH:B`iAN\\@R6\pmLjTSBgpHWNmY9l
Y][hGB3C@:dK=bo=mbj5dlfiOAS]4@GhO;5q0KFeGI^PC4DQC\__2SS<PiJ215\\
`AdF8K4ejkEZN;;EZTCY;VL[BCmm8;gD`CJ@M?Fi2GbQLKqaL[]9A\Q`DD?]TK@7
d2Z2CblG>F3hd^a`XF\p]Y:oPRSZ?C0461Xb\1W9GV_OaQKi>LOdq;hSD9E7lAC5
]\D2`b?Kq2Va?jHBp`LR>=UjkYlo0d^2BSo?IJ7UL7;M;nBID7VN8PZ8cS;Uaca\
_T;]2afQogS8Wi_LBBKWb@>fdN5P^M7FQF\MkqTo?RJ`QejGTP:GC^>ji;iAYhpR
_YZCEH2Ckj_lBB7oeoXYQSRYO?FpcAfA7Dgq1PWl[XGHkHRhBNi>X<7jK\?ALbgb
L_K3Bm=<C]B3Gj1_TI>?e[Va>\eMc^WkZmd1cS<VkFd]<c5:_7UAbcBIdTbfL;7m
U9Nf39e@j1<?X3_ZkI>?i0j?ji;06\7PpeVe:LO>pCQYPZBbq;Anlj_B=7[nU<G^
ijk5ZH>DKKUGYg_1mL1MU2iER2dh4FnF@ikW3GnZY4OTg8\GRAH0JgjpG9IbIOq>
TDL[a@q]kR^fGk0][2j4flKd03in4]^Z[g3pa4XX1o9o1a;\dG9QcVamiKQ`__]G
=7IBHnd9^2@0:hL^EZ9hKb^Yoi:DiOq5m7eC2WYa386?KR4R3B[Z9ZS>Fg9ShM4p
3dmgQB[q3no?ALW@e6W=UkX:WNHQWE?3L;^2:OVF_SH7IDKJd5ahN2mX?7SoZKOd
ghpU1NB1gTh^370D6\opC?NjBa0qK3P]Sm:=o6CXQ]TIVh2VNO58jgghqMh;]mZK
LPUi^MJ4W^kPp8=\?OajP>NhdHfLloX:[2kgXhW3VFTC3Gf9A_`U3?ej:VX7q7ga
R7PI3>VfTd=KJIVR1\OKF^<L37m2<F:PpdDY_EMAod4TQc34I[a2^oMZfcPPXYY`
3T>G168LF88jd2glIB@6qW3kTk`2Tq73J9NOHDeKm2NX;eFVKq`XaBE`\JY_8>U?
\^S[5niJ2<nH:dE1D;g?BeL^RMmaq_0V?n1:QlOmEBhmMl=7]646N>:f3dMa=Z9d
T7NBjXEqik^S=6c<k9GM=3=Td5=2I@MUe4n:??:0LbFWC>bNLIB_36k=RVNqWI@K
YomOq^2A0HYG<pA0kLaW?[]5\e^@3[6RLTbGB:=WCJ3X=6c`fKLOWC94YWjTf\qF
XXmPjFljj3hmj=pdCZSC\m2AHIm9W9JbOoT=d^UX5dWG0<EKe:BN=g_mVC\iRqRS
;PZAAAqnoG=_:_oeeMcoc=2Oel>ZLpLi8e`bVh0ma@`0CAZ>F_S2_d`^Z^9\D`>R
B5W2gqEa`S?CjqfFBQ3D3cCWdV;<2opUBYJ:;fDWXN;`RSB<@ql;4hES[qnGWc:b
^a_`?N4e1<NQcQ:Me4\<oj[XLK``VQgX=d\PJQ3R@C1BhGkO2W^`2on^BjQYMQ88
7Hp6XJAU^@=fD4>0Z6Jh\YfaBlM>;AAEc=2bm90dQ<TDjTqLjXfn43d6o248K`B?
An2:_`5qMi66i9VpW0m]aI7N0hmBR8U^q6lE]_ICp9V93ogRW=VBja056aZ:3n3i
Ifc@S6?9A0dqcVk<6M4YfE0cMdEGSkPpf2=LNI1V672;Q3khRBG[H]dPV6WHBfYA
q6==XXX@OF\6Id`h@7b[]4MGm=R4S@cClaKMW;cQ6j0`588i\SFemW94pKY_=Ni:
q9[^FZX\68F6`>cP9Y1@qGme3I8Tk<5FMBD2ZafeYjbb`eCqX4M]8F>pgGl1F]_p
kc]MmCeMJ7^D]i]lbg7gZK>N08\MOfYQ_553CPQ;a3@JC7Cacai<0^SEgQo91OVG
o\2`]mGK;PbiR3?hWcCLOJg:\];30dYOMbJ?0UXZ>onqJ@9P:7=hRTDUi4R1?lqk
DFjAh2pL66>SQpl;J`@fS[:1Tpj;bk`dH5[6Fc<jm[H024CL\OV:OD3JYEWkU_=5
lU:08i=Shl_ZW:a3Dl:=1J:1lXCW_cD:S?NoNLLgC>Q0NHelf5^K3b@g0SW_R9Eg
Gd:a2oQBRqFW3337mqcVL3j\0>2=l0SJ]8DUm51moYG\m1643YU=lSD48]1JaiON
DR50l`M]SfD>3VQK6__no:aHTQpNF@hO>Ep5SKO=hV[IF0gHXmD=PDH^G<?91p0F
XZ^_`p5F>24m\q4L>W2jHSA=82Eg=3OC3;ilWDD\5==;_8qkX9HIoIB1cCCh_eF8
Shb7WL`_@C0k:BOam1I^DbG9cI?3]BdCibH8i5Xq1WYA790f@I[J3GB3qVChZj;X
qN^Mid?SFT^k3^3Bgok@WBdFP8NZZP27]P:?NBkj;BPoHlYiX]ZBHh;AkaPNeIBL
j2TEH<A_pAXLWOV6RoKPg\67aK4mV49;G1d`oVl2<eUq?9U71ZDM?a@a^OPFJP;p
c3\Tco\E19^58a[1oAaCaIPCf:aBLo4dqn5Mjh>]q`XYN@7NH>biWPLe`Ue46KW@
[JV@2Q]SMON]ReKU<kdCK;<gPmQXo=fITKG<D24hAU>:M<nTpVJ?>n>MXS`kSni<
QiS:p9<m[^mY:@6`J6ia7V]cBSc59R<pPD0iUmGqA><?49Jq?45?f<bh2BG3BmlD
g>\UKNeHY:Xncn>_9hEZ2JR^U>Sj?HobkMZA9G;eLKD7QV=fWOdi3A\XXGI\AeoM
lWk9iBU<fUjP=Z>hhV:UKA4A1l3pZX=EAnlq<[2kYBf=mW@5=g?^q:7BY2P5qDK;
gCiT3QVKDnCP<9J3V[hooT6=VPbQlaAqm<=H?OlOY6]iZ=YA[>R\d>@ZAS:M8L:m
ZkF:TeX<f7SWaEGHq_i52686qIU_K5TS[9`OODVW[S;H]F7ciF3E4OjZ6[aS]LiC
Rk:jpIckHOg_HEe;C9FnIV<VN7hT\XIoWeoE1X88hq8EPTlENadn\Wn]a?e_8_:0
fCe[n<VEZn_oR3^F1fq5AC3gj2GJT82ii4El=gKlIVhFeIm7;icXHk02LnS9AB94
5deX^`SBh9n3W]jdRHo5YaPe@njSZ`EJF@SBcLDUEJYV_[ah=MC?f<2<olX02BYY
cO>emqhf5Ul\_q]ZdTcT5]QNk>YIAi>nqmn]]k7Yq0b2NWY=_OYNFcE95Zhnnoh1
9I7=YEc?[aeqILOejPa2PHU0o_N;d]U9XlZj[f@>[6LiY>c:B]WL_MgA77p[lG@0
Jb^J92TAOMYKn^D9HFHU0M3>lUY^_Wk04k\GDm<KiWW2`62M<`HbGekS^]@60U[G
^03c\=gdTX2@LoVKb<VA?Ok^lUE>EUIbB\@ghqRXbEV2_mGaK?eYQfS1Xk3YRHFA
ZMb2e=p4@SDE^jZ<AgQKaF\8Bh?YZic8\I99aH;[mTZXnaGTHWmIK:EGj]dZP43h
?UYQYoD]m3;KfBkBLbDOf2@2k^ln6Z0`IXa:c^f05oeI^?F20OeJ4:bKF1c15dGk
BOCf9hbBSmpMcK?Oml$
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
a38D^SQ:5DT^<8iHZ>NDf0VhnmG^_32ZOLFTM<8\:NHOaeWooM;0jf8IVmAgX3\R
SECFiD0E_57LqTn]hNKoHNh]<l>0;DhRGCc]ciJ;P5^b;3AjqVFiD<4=^GDVe?Ia
I[JWl<Dijio3H2n0dJP]gO1KY?>A3Qn<KGYFk\^qMm8c:7pO9:N\4\YLG[Pll:UF
V\5bcV6]XJ9@1H^Blkm;4?8Z<QBp2GVVD63q9Tj95F[A=CbaaIf7][c<oPm4ZR3Q
^EEO9YBkpfGVK6dVGUU6LYXA6X<6GIO;SAbd8@<k4dK0PqCb6b?hCpN81<EI0oR0
S?RUo8h<bH3GFDF]YGeeq:]0;adI=90=lGdmL[2JQH;f::6T<8Si3H11\@5OnGiL
JJaiZ07om4Q_k=KnHF2UiXUj0EQ27^dkS6lQ6pL]Qb>F<hTdNTHkaIC<CmnnQ2M:
>l2QH6FdhfW:6mcD=7p`iO`CX]>IeMaob0\NkBK1WH?1QU<FkRpm[Bn[UcqnHTU7
X=q2gaAn15R;2mZ6GF8;F[0oWKag4Y79iqaeDbHIdOXkg7F_9<9JkT;[0cgOnSTS
T<q>Nk1JbnH1LZe?i85kM<CDoK3ObF3O^W9V`Z^K74B0hTkDXcON?K^m9pG10nVS
dM69hIfJ4Ri7L@jAb6gkHN@Y1qfek1Nk9pcHgV7_NLH^3S2FnlNIW=7\EaiVQJfT
c4^0\BfAq\`TVoLZpZG58LL?^KAfAKPM30_?@_<K?1fT_?<q\h7P^V`0eP4>7HXD
1_8ZdL`h[ed[=Q6_eRFVomWScLJIUik_bIbXak]l<J_e]7B[nDT;H;mj7\>F:<LI
q<?S8m6e^PNO47kLh`PpPGSFZWFZ9h4Qei\b8J6An5==f5QOqJY?0hH_U3B;PNhZ
W6^YFaD5\lO5@\AkOD>dFLXmgG@abJ0qmQRPdTL4OldS5WSbFACM?:PM@9ljAMY9
qLGh56@H1[f_ocb=iQE\>aDHcT1]3oIC[PkKJ?bVO[F<9D=9dLFITTFCfXbFY@[5
4EOPMpcUZO0iKqUG;F9776CYpI4Ha_>XX:MB9lAeX8\h6nl[7cFQ`jol2D4;>B`;
K2R:QpghnL^NH9R6`?0So072V_66N78?E3j_aqKMB<=G4qi:@9O:Oq5VN6W27pT5
KBMhj55]bnBCY=_12nNmd\[^3C\4OjJlp^g3XDfR3OV;PnZ<k=NbX^7cR_8lB`DN
k73d1kZ^6T4FUgOTqWUUIZ_jQDc622@NG2Z:L_>1;`<qg6IjF0jpKB]C5X]mXX[K
UF9e8<Kd\ceoea;C35T]CY[pj6P[l2P8<d<jFPlo;_;GF=lagk;XHJQa8=QV5dDS
GlBI8ULU[]jV6]hq:M7\PDakTnm@TnLIBJcdA1m5U`=cGMb_@cCn77@Mi@JJC;o3
DEZnSVka9EJ7>8eV5WO45eM^3M7E7Dg`LRRp5KR63J2p50fT\C_KUL<M6]=f1BB1
XTDn?_Q=??3KoCLP=jSigT4efX0BT>NBZ4Yj1Be:e@op1Rc0K;d0\SoZPal]]_4Y
k[TNbf4H94PZ8H^?ZoI<loV02mS>OPnJHQ]E;:SO28NP_JLqb`3fX\>hJ4C\jeB_
Vfa==_PX?cq]o]FIM0IdXS2HRF5=P?TS\dF;NA1YS_L4ZHRKFZ?dBqa<ZhEnYbP2
mh2c7\nN]<cHG2_mVME5`J`;c^m24iI^pjb8HFIXZWDfZ;g;H592kWNcj<`TkC50
E06_\>H=q@bOm_Mq6@UnHa8on;O3hm`STEe6jJ_m1C<PNcJZ\WqBWBoaFf[]YIF2
EXYY3T^P0IlD1f@U5iYJYWg?84G7_dFp_^=1M^7p^76JbLOp:<0Jcbb>m_4QFZ7b
QoUJ497Y?ZPdKBi5UoLVIHHHQhj^;JCfocF;<Sf[ABUaL;:<V?6F_QA6]8DXKMS;
00_h9iYB5RUV7ViKBAA4[Q4OEW__qDegmkCA[l>_H6ljnnT4N?G@J7hJGWYKfb7B
AbfM^]1mg>gl:IX[bcnRR6^epo5oh]Cpe27;0`>qOUDY>jUghGQ6ME>aqnb7X8X;
I@PGkChq9OmlkU2c4oc7k8]E5S]=:NNT>k07laoqeQKA2fin@TYHokI7omaUBP6\
ALAp77@3J@bZUiNG6NnCK87BhaU=V1L1;RA]padD2e^@pIPR_W\1qCVBa;FWMg8`
jS]Gm9:29e9ef:g<GBX^WpG0[b=;[3>90LaVS\1QNcJg_^Z[KD98kEi4Ga\gLXZZ
Riql[<dD;eq:^6V=8mWmmUYHTlZ2DKU=nfK`8<2mFKmCi3LpShkSoaMqo5]ZP`?]
Hm=GJGQTXho2fP;Z=`Sh^@_>pDNZ`C<HK7S051a<I?mcniVAAMg]]4hn<MjKH]Tb
ZjE\[ITd8ji^dU5VX<j3h95ccfi]lnQ115]OWdVWFqPA4Him@p?jKN[Y[?PcQ\=F
9oA>RQKoQFpOTWKa0PqTjJfTQ5_1_AC_KeZj2Dk0fKRT:oR_ebY[?ibg\G6dRmF`
];bqTG@QC\DENa2hjMa@V[h>G=MLl<?aO^P=9IQfCHTpVV^_>gTpha7RF^qEPE9^
KKh4HiMR<SM2iLfYBl<lBSTYG3c_LG4N1Y^T\oV^PiPR=qA<=;F0?alP]dJHj5L3
6n^\911DLm8<2YWmPbCDj9H7EWI`K0dUm<KGTa3d3EBAn]@RJA:6lmk3<YBRjOqY
AH:0Efp^i[GhT]0W]TN\KBce3V]9?P6=_qlD1SGMF<<iemhIm\YE@=8KkYRT[JkG
KQH[kPCMK^eS_IaVU[pE@iWP?]ZqiY2nBDcT:N\`U8K2PRJ3fWomTTK5abP;\dqZ
0BjXc`Sp>_ad3Pa`Re;Di0AHPK;6_]EXEmq\J`9lQ91;XRMTG\32TPj:VHPV[[ah
cO<ON?iOPaII\6TPnqQZ@F9FlpS1Ee4]]AS]^ACB\^9VOgQ@;N3P5;OG6SbZn5W3
Ae;dR5<Lc=34bgQ?e4Z00ChX8g`o0qPR?Qh=aqY^aMWDcBFM=ol<XTpgH:`Q7h$
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
i]kGlSQ:5DT^<8nMhO=0E\ege2TMLcHYR=OAX@FW5=0[c2SEiA8_h14dX<colE]q
ZUFH\JE6HT<[PC\iiQ?6BjMCf15Cnd`c?mEhWWhFBD?7R\8gnYN^an`aGFd8W1GS
XS3E1>pkUR[S[<Mg\5TobO8\^09=DSYnX`RjOTBoa5Ce7L]H@W:<m5B<T^KWY84k
R9cdYp4i^IfGpTT98gP:i@N_>X1gR[a7p@o2F^eBB614==?QbOSqMF>G\G4UCZe<
N7dd?_iJ2hP>q<1h\<dT4hYO7DgAFSQG?L6pW12JmMX1[`YIDk9qF2nD<kjW;fej
d^h^gek=0QE4p3AYU[mRqebPd4KPj_?[p0T?3oPSq;ZUo0E;qJ1i[^QmpdFQ`Y?N
qJ?cJA82Oa<\diXT0Wkp0@4:]hPQahY=O1i]S;op7HRCb_fd7[O?9cZ?0ggEq[HL
LMC>]@Nk6db0c2:idZ>A6`B9J2hjLVeMogO3UNG27H45j_Io7X`q4`GCXU^fGkqG
=IQD453E\dnTBHQ6=Y=8EJaIU:`nY96c0L`JlgWMdAKLWBOWecI5ZZ4;87ZKgG4T
QP62GC9lF<]Co1o3lJ4cNJbVT_MaBqW^YbQ2:f_TQV9QXpml^NZCbpn[eQ=Kopo;
H>_KBV<52JnBB9[IYOqM8k87o5;7QAPLGZCRk0X<\P2_h5D>>lGaEq;VaZEWnoaV
Rek:?A>J4Re^[0iedFoEe;`i09?6q?FjQ\_dphRhe_Ck41WZS;_Mg3e?b2[GFhcp
oZ38_VN:J6_1nM\k3D7??@3^UYIg=@82__;aYIEWObZI?XjK:V^@4GkIlXg2Abin
gQA[V0j6[^2Iodf]^?EoqYI2>bSLqelOG]5kZo8njd?3<k@GZQ<4_fXMZEB>k09Q
HU:M6Gh9N:h9jmnhMc>TH8H:k7bViQ\^\P;A_qfS6B3g=2C7`SGOZSW^R1Uj:ald
?EOd_?AOL^h0Qqd5V\ReDP6N=8D0EL?V5dh4h?@2hMJDapemi`1B8qig[lEIHqJM
BB<jgO4^q]@:]L@Y2nbK3eWeaR<_8ofCZEkXFmWg_;kJJSkc_1]Z232G=adm51Y5
0Bj]enf3QM]<KNZcD6H4fV9I_K>DNQOC;^PVdAZpmOfTISIp:_CYYBl`KAoSofJa
dAeW=IHG5ZbfA8[pjVlS>8:pMMGP`J`qNSfOH?NHN7KZCWj3DcH?B\AqAnRWCCS?
>[0fk[jGR^^I88IJ[g55G6ZaOiAEPGTZfSWEU6I14Ko?Fi0_Kc^8>?TJI?=kTfOi
e[OPkEA`2A27_RaR3f6T`]kgXJPES2ZoJf1A_Xp7VV<CmUqK0KhaZk`nIYjGV0go
nLXK>_ce^4JF30obbqd;EBCOIpMnZ>]>biAg;_\K02j338laMe_UfT\eYh6\FHme
[U:06Z<54`T_]i^aL=JKI`n4QLikXR7FB7AI^8DXpK1CP5cI[Qj0maFo@O:<0?QC
e``?J73<Um3]GXGR;iOMDoNm=12=acgnPJ0?O@b9mqCYZO@Ynp2BdUaI]`45S6oZ
TN9hNeB7b<IQ[>_J[XfA?PVap9E5\Cd^p5^IAA;epLIVAOJ3paY?P@[;8H3Z7Ejf
MQP0o`XQF9a4XNVIVCLAkMJ0U?:4\2Vo^K[L_ej=FBaplbOX0Whfj9[`2dMHS5?L
k82YQe8NfK\N^9CG05:So116T[hCX8Xel4nS8X7@C<Yk[Z2dhMe7j0o\a7CDn@\d
Q2q0RVbKUWqVKbV]L[a=oF6<?VgSHkC?27D3GCi?JWE7Adp:P:h9l_2?kdAZD3dL
e0>9OmlCfB2ZW54od@m>^bh7;?FgYlDqd8XNIioqkDFjAh_qY4FGTjW]cAKBIU_Y
9nY@\:q?0f6JN0OG9@gb9Y`<8H]7jo2E4f=qU8@P?CjqP`b]=ERfD`?6kJK[U^23
iCV>KJYAGV0=Q9hqS55P7Q\GNg>0@DmWe@T6n;GUYI182PG9TMZDYTeTQ`WojXnc
ODQ2J3bRCMpbE<C`h0Z<loojP_5;?l:LjYekQgASW8Y[jk3bOJma\jQjPhQJ>T0T
K5N1I_4Ahd6d@28^A[aJPop8cah1m20@6nSNa8`c182V61:4HF`gDbldIWpaV3OG
>\C`<62EQdMFjSf9@CbLb_@hj@bq\LJY\SQp?W[bJShOKfof3J`Zq>=MUYY7q`[k
DfJIn08EO^X:\5N26?AX2;AmQd7]I9[BpLa8O8l>C<GWPR^mM7DYM;knl2DQfqK4
c[eQ_1W5X<jQj\k2InPND3@:IGb\hE@m;A4iRS=BJ`PF]>OP9Mj_ifWm5QU`J\K2
KecT;OgT`3h6o7=BOdA=V>E_>fQ`qmjkEPLLk]dQV4aIjYbK3@V8EAeU[\3RA>O7
XGYW4[eKoO?3HJJdnX:>59ZhS8S__Qboloe_C<=]HX?WIMSp3XmRY8DNc;LOM=Ap
Hc>7][m<;I_EBNM6F3`33\;aKD>c1EdalTWKDNWAM_io1e2FTa5PIkJPb9]SJUjn
SRpiTNKOb?COTHaI?ZdRm^I>gF2b8IOeaqKDKiVN639^2ceRfj:SW`d`MQc=N`;0
pIVG4mgIpbF]:H28dg^ojG9I@a`fQ5n9bQLfJH@2C8lbZA<^oASI=2j2jkOBQV`@
e>GQ_n>lp\Cd=o<X3BETIi\TkP?q^i>cNL>q_VfB055[oFJG8h@J^ZiVhFNI=:f<
6^?9VB4pRFJYGY[d`Q:2l8g`dHblbe4Aod`c\<>h_CD21XK2[ULEgXXRdb0l?RQY
38_8bl_ldeJA2A2l<\Yq<IBmjBGC<aHWX3<?>T0NPLDcN8R8AUGM<JCGmOjGe6fk
GLiRmddEelUdO@pOOMB_]eAn8Q;Yg[JNeb9:XF3]L=n>]i@mL@[VW_75VQnRI8Eo
X91f1Tchl29JdN[chKDSJcU5Pc[@f9mH^Wh`RPp?kaHih9^2cnOD2jj``5oJ2:RR
`a_U^1q;1SOM[dqe1<R6QI>]HdbUG>ZA6bCj0I\3JLj><J;2Ofp?bol61i06e[iD
5Gd1:D7:8YIQ9CjeE^`NSALRAeqbfXI3DCpI_6M3?T86IY^J[bBGiHJZWP@LV`bk
dPbB0ap4NJmG7ALl8^\`66\TZZA_Wo3fYZE7lZgW4K9^85KBg2c`FXMN_RhaEqJl
0Y;iO5JnKE:]]V>LKobZKXg;Lj1OUDdf3mgkgA^FEP]LlELReUmKhK?QmDFSi_dQ
F3NQEZJAiFRc=pK0bDCcn<Da3E^VR;>BW@_lah]69b0R7[]o=7aF6F^SJ1905kSX
\=XCX<BgLW\5GPF>@ibC5Hf678HQ95M3Cp7_=m?L<:MVY`eL[`qlSgAS8US^BIlI
`?^HB>dH@^Ui_MKX_?qjMMC<J?\TH07hb=eF2[j>^bEHaPLR:8pV>?n38GR`d>IT
G8I>JpH^>JR^;pcjRQH9S8[T8Y4lF9E^NUniVkZcfbHT<T8Z3qWHA_^AFpTD;R5i
o[8^>KOmY2TEd53D@TU037D0?c^GKpSKa0V4K=B6\Pf[7fW]Af\l;2:iQj[DaSfG
U\hIo=K84Bc>VGHYA^JYp0IflAm7D3_0I?VgECCbdKX[;B2Z@oa>58>Dd0hcK]>i
3ElVcI<lB:\G`\eT>okUh85m\:OJOa=>l87@p]Uo7Z[c9:aZDe38ABnQcY\lVkb]
gTR`9EjYf62?T4@_=e>g_R99UQFKDYP8BE:c?@Sl:gldSRFHg6b?k0bUqZnnFT6G
`<=2:kDWA^IWd:bBMLGmbkQla0T[WeJ3<gk8fKgn7oH<eSeciqDMn>]`7eb[TMDc
]mp_TOgKiXSQ?1UgFA<[H4R\4H=beU20bIpOk;C`?4G\?T`JY\OA;gbo8eQ4EDBT
B`q=OTT=>bp>Y4fYZZ3>HL4^gTMl:OS?OlC3Ik7[Y2Fp;l>e7MBL61KP6i6HoBG;
jC><SLE^P4^hEN5DGYdoP_X3UeLnNm7QfG_@4f8^eXp<jNbTmNq?mX\6:N<FiBb]
]:HFd?AK<`9[d=>d0gPNGBp11:IA]ncd558>>@@ohqj_lL>WFfg=7D9cJ6BPa7lU
f1bNIm72ikLNYPS3DO20N:fO2@k9B^bfYK`?\_4NLfN?hBqm9Z<W=lLcGn9E[602
G>cV6`n6E0h5DYDnZHT9T]oS3TYJnbjfB_TlZbgm03_^5LeglFB0Y3N3\72;d:=Z
WM7VKKPEdQW52RhBDVqdhkYfi[C60Z7PPebnkcekL;UCBdkcXD\H]f\gn75`HA08
C=U_LO^0`@bMG01_VIH0c@=2fTYDI[\Y<Y\KZp8B;LW9`N5HH:NkPYSfY3[iKO`d
Jc=:DB>H9gIjD]FL8MphoBYa0Ik56^fb6gMSBRL7CO2KR=KZdq]QkfO]CpX<T\oI
VA0PZO]gGg:NOOHJ;1hbCNChInp[;>lBLGq62[VDeb1L7NX]4SB>kk1jJSc11ZRb
;UJXXnq5KH^PY9iJnh2@_D@@@QiMLVSeN4[PM95L1M:E;jGk]I6AH4?Vb@Rg7qi:
H:0hHcbFk[mPi3_iJ11IXCljT6CWhjaMMkdmiHPH0a4?<nA]>:S@BN5H=EgLZZT8
U5@Nc38TW0K<fqidE:2Dmh6dU8G]ZN0gOi=_mY32GEYT<PHfMN84Z4lBBHFRhC4X
ehD0i;ci3P@AUIVc8ggo[<?I<Oa^;Y;CpA`C:mS<;MM[^a5RUBgGGaJ6MDN0DS@5
WFg<E4B9eW_>>c^UaPbK04lVd5nNgV2cmHF_XC6EfpJlbS=n`FTQ1bT\^qUD^7RI
ff@_hkf`^6C>mEZUAmF:dD^[pdC5e>L0qiR_D>IBVI`hITbYG?hSeLQYhLQdT\__
HB46nfoFkB:h[R:pC\dIGlNR1MoJbdSa1aI4LQLgoi^Jqcb\c4`EPE0Ol1R7EJ\6
<N6?8ICn>TWqj`G`Lj1q>3EAD]`Fdb6H3K2VkV1p>AHjTU0N`b[RIFWEq4aGV::2
qcK]lZNhA\1[FEUjn?QcOCk?]XCnpZf6iH3hphRYmOT7oN4P`Le;_XiOfW_090R<
98o;lS:gqVYQeg7j0[VeEAkM8IFHJU8C?Kb^VXC<l2oQ2SWXVm3`1Q`_K8;LJAld
ldgqAS>mBF\laAKZg6W_E9hXJ11m4YlVQMV@<9k[f>OB0]09;VNa33iNdkklk=_<
S_2`HdSQ;C6Cl\G[_m:RHbqNCNb=VIh3MMVa=q^c@<kLCqL5GNBFe0^n>^kZHoOK
iXPf8e0nO5Pgpk=b0EiSpPCaDRbc\:aa5SJPGbo[p35Ubj3Y2=a5kFlW6J<kkf8S
3\EjMcbQCQ3mq6DGbj8B@`EoA?8dN:W^8Z;EUVW>q@diQS^D2IThKDl\0JBDll=N
PH5:RnjdqdVV31JXZ[:Xf;<Coj:b6L3_HY47DK`f0Kid>iVkI1L8d;>fDb[`ZoMI
7\`K4qAGG\UcMk[]2A<_oU>13[hh5EJ^KEiWF]KE=9a@0?c1:`FG;_O\BSXj0PN6
>\hiDg^2\`=Yn79]IaYVqLjG@l82Lk`GCZZZ[EMEJ^GcfkKn0C36FT\MV]YJaFW]
Voj7KZ33UYi^k1j:\9f3>Cl@>iADL7I9iCY2clh<@CnH0>FDap:QU<A62R=4o>5Q
[FhB^<<LiE@_TEai[Ac3TOaL?Y?>?;dceWll=]p4Za]amhq<8keC2pfOdaD5p5n>
Tja4qn?E698lk3?BD\U\Xa_DA0gU]_b7a:lSpZBK>]O5M]nEK;A4XJG5KL\c4a:o
npSV\fXKRca6El2]ogJ`m;BcN_p4@WSaBFP:^C`]A^ioSEK_Iold=qg<40aV1pJ5
Z6oLQ4TN:L9J>FL86oK;lJJQJZHBh1KK;J9`k@bGU;WGaWm4497KLpAMG33DJpZ`
UZZWYK:T<Jl3]Q:GC^>jb;=[883WT?k@A@Q8hh800kplDDH@@aU:hEi;ccU?`Zf3
VmC7AGhpUUTYjE9H3mgESLkIG;QEMEVcn=2I\0R217=VFQ<_7EW0\Y1[2S@A1`IF
@]jgaL?`TY8p`Ld5Mm<qL3;R<dnpK5RjOKXpF@Z<I6npHH1@j6_H]TNaZUTp3]>S
b;]CNQ2<Jc3?7=Y]b\]bElCZ[LOq>cAKLEGUGcBR9E5Ye6JQVUVWC>[q^[=5fMQo
UH\U5bV^:ogP[L4`4A?2ak5RpoZi2Vfi:IZf3eVVC<I;gDZe61TNAgUp;hLbJBQd
e4[IoLC`]OdEVYfFK1:Mnl[oLAfHXaXZ`[?V6_;l:SnLf457>c;BkNJ_eR<F]C9U
JBpnQ1iSEnqa;WCQQ?qm4hL2dIqk?UPL>[90WJVaGTpQL2H52b1NA>I4kgCT;Y>O
nqk^F;V=W09RUXjbSDO8UFpLB>a7dnm_1B2>=Z5>NR`YfeCKXo[n0YGdnNQ@n7;H
NT]hIplRbI12WqOaml1XAIeg0I[R41gb=Nma?7?bd01VCjID`hkC>a7kCC2Ri@_M
D>iZ2FCO^>l;0N=7;]1]\_CRbjendFT3eT;7AKC:;l;k[AT]LHR`^]ab>Up8@[DW
2ff8@YT9Cl814]p4_\BE3h_4K_c=Q<lZUHhU6qBXekn^<qQHWM6`i;mAJ\SV`]Z<
`5lO4<[jS[bG`BqCWXY61]YS7MgVI88A<bD?R3Y0JdCaD1]2_e=D9MBJ=^;MEMS>
5G6MBc^k=aB?DoM?59i@>4[qC_i0B?WqGIL^6XaqQJ>PG4a;3TmFW]\o8fJ3BWK@
n0ZXogEHeP05eE;Q66Q9J@UX1LjeoL]_=0T41cBGRlcFCVjahJG;2>IS4Mp9ITbI
cbd;HF4UXCAc]c\062iRdYg4gF8Ij\^MkHq1SI1@NAXnha7jGi>PkXqmVoB76_qo
gmh4Q8UQ6hD[6D17gRYQgGm;IX]9dpef\>XQ3q6U3dDZbT:0=loK>7qG6T_YE[pO
[gbS`4NE>YUH@I4fA8\]3^XD@H[qScK1CE[=AgN5M@c\iCUgHk^d^S5?hJPXp;RS
YP07[3Pg:i^5<NRPRqZI;MSnLAU0;>Ro:YJNCqeeS1ONn7R`J=:W64<JAFpkNS7f
9V_m?Gbb@3aI28o;Vhk0gfYPhkFM9QUb?me\CSS]K2YqMh`[b0jpJ<F^K[KX^blW
bOS7n7nDq1?C\dJW]Xi2JhL>Ol<BpHm\Ej=a^Uh3KKbWM4bDfqke_dJFlGPXjfA9
gW3hAioCH=:Sel1E8BMhb6G5VnM9pQSA<[ba2G_^fDR4R<WDL7F:c6nF_7fU2@B1
KRKVDAUB@ea=2q^:nGkX[q\@84>ab=[9oo4`Q3>lb6pORPS3l9RXFLTe`:IZ9Ppm
]Sm:6X7SlC2fG_mWXPfp5k=Ck8b[][:KfhO]ZOmoI1m4MGmIg4fmh<GSOEXbU24M
dnEJpZCJRP^>q6Z<hLZK;j5F^];O_KWeAIYa2<aj5AbC`Y`@qEAc:RcV5IoDaEk;
E]7PMp05F4j1h04Q7MoA1Rk]2qd0[bAmTA3@O`YfYREUMAp3@j[ko5@;ND@``WlK
dD_iHo[2=\2^AO4li^d3O]kO@[T]Nijpg03=iKJa18?IS>q;h^d[m:q4[D7Rdbf6
kkLSFB;2B@eq?`2EklXd>a@XU4^jkX`W8<cb\fI0p6PZl?kFjh>6VnIWSCH>_PF6
`ajoBC7CW8`QnM;en0^OHe5RDB]bp1j_`:eLd\ko;H\Rc@5P]bN8c\ofm^mpUeoT
5gdGhU\?j7I7NABD5PJPk<BU9lP<<ZH>VIEX1H:jD:ANG1W^_AVkT[PmHbl>>Pp\
f99kJgp13;lSRh>75JffVCPW1VJ6\l14njC;7\fJ=d518^Mj;1JVGcYaE\mf:fPE
^Z_cFR>R<poa8l0:I$
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
h0kXXSQd5DT^<@X`>IK;R2^J4:43bA0NYN`a?mgXnLBR>YV;:h4pYW[GWefP9lZD
i7IS9gmVn@L_?MW;d7oEbZR?g>b=MLPJQg0^m?XaDURU\7mgqh7Z5nRPM2]Uki_m
lqRmdSd6q_b;]J:eM^E9<`D;2g=`EpEXKdGm`TJj:EW<F?k^Ll2;RMpLkQ?_c`B^
SF8Xobc<8J9qd6ajZI[?F?B8?e5IKac\fe15a6_E0?1bNIb9gV605@NHXh_AoZfD
=M1mnMV1h2A\0>Ihpo\\DBB^^;_B6Z67SRI^HjhQ:MnM@;<[fhDphXPmNW;^IUi2
ZJQfILfbD3f2W=2WAU]5F=a>o7P3CQ5aAj4EZkR;Aa>Iqn=DlXa0q\FX1c>i>RL2
]5>?@NQed7YU1N=pIh4Y_FG4I;dc`D?9F=C2mMZ=dC[bN:ke]jAL@GQGV?QPd@AL
h:AiCSo?UH@[C;6MmUd[Z5P37<?3pbg_\GGjgVf;2C256Q?ULi4<qU^RGH_Gp>R_
9^3nWW4;d[3=f[:8H9OGYLGfiCOfpE5?W4\QI;SHLJRXfI7NDb373ZI`CkW5SmCh
SENdf6N2qLYNe=lZECLGo<6`B\Ko>cVTl24TWk<?Wi5PDpB^iUc1qiHHCjCdB^NP
Pm`bR0D\XO_DOdaoK_jFoZ>ACl>2Lin<_5R49A3U\PXHFThDXLa9X]2E7IQn@G?n
U7>M6bo\fN4hpkbFaZJh8;Y\GYi\C@9QHl>9KdJW8Ll0Fg=8N8A0KB5JU[[EF:GC
Rmg:LNEmaVmnCX_BkfhF>9XKdjG]ocUap3HeYA51N6E6@\6_UkZ;oBkF4Y8=pVR_
6R6[g`NH@9Z\7aTCof7i3VESaT7nWJg>240KP8:lONbe64I[f9g5JgN_XX0Y7oC7
N?9;KNaMT4k_?TUfqKoA900TJPE;^_h5DMWIge8lgYHMj@PdMbmFa?dQJZZ7Q^LQ
gMiKE>UQQZk@^G:K]KBPQM5ikF03CSI_1=MpEWG8X\jpRTSffn?=APlc^i7@YJaQ
TiBbjK2D[n0f0oieHDDO@>O3[jVhW[3<V1gb0CN8KiE^c`AY`aJ<IO\p_fCH76nR
Q?P@FUZ8>BYTNj3`Dh571OS?VZKYj5BMAbVJ=Fa2l;fgK_=@q;PPb`K_GCGm:Z^0
AJXC?R`<pO21SFfSqPH;OZJpVIAR?]B_\[ePciai=R3h?b_[]:bC9^PHcSPe59B?
K2MUdg?eV9@^Ma`OQm[YBmPdVIA8o\b51jn:hPeQ5=iN0c4lq@X257oQ0A1a:K3L
@ee=1>OK1mGVR^HOI6?Z=I6b?J:eMQ8GkJ>D\7S@Hng1`mmHC@b25lfSYo3DWl0M
k<9d`q7\S0MBT:Jn2Ki\6SRcCE3JD6lX1Y@U_e>D995Oh2VU_K;]l?EM6dfP98ef
JDOdVI7kSJo;K;PkZB`e5H`l2hp4CccUk4mMm2Po\gKW@L1l5`Q`kP@SkZHBL1m@
1=_\5f<Ekm1gKg<lBNOJhoOFM73baa779Gh=HZ9ZljH[b2p5gbPYITq1>h`gkFTZ
dgg[5O;99S^dV8UXV6;WcGX[2@N[LX^FNH^_ZJ[Za_;YUOc?[Uq8efL]X]0dF:T<
5nD3Z=^5hC^mPHd7RkF0aj:0<BaIdlS2M5J54I3lbI7Pg61[fdCUAgKkG^Ei8[pQ
cB_aSgG9>TQT=i8A^7SQKHpUZRMO>jp[[]AiZnAfmXakhn18DhEB3fVKA973X2VR
>i@XE:_q7eBhKcaqmJXYNGLi??TR9N\Y_gh5@5ZhM>b>d@5FS?]7b;>]YOIGNl:1
m\nLWcQ3jUoZkKn:m[h49Jbe0:idlNF<;LL3N@XHlIjW;?Jd@U8FRmR7FJ49B20n
RPqa4GL1:gqK?lieJip>P4@P`Tpi96D9cJ@E1@J>517?oM1U6jD224bagQR?gD2<
A\YQbokHBY9BdjYk35UN;C8PH9qoh7HHi@N6>kjkWjeFVnB3>Gd3F1RQkXN[Sb9<
mC@qG`odmTE<]iDcliILUWgB45>A>`40@L]:U0UPjfNX4F7\`<F6jn=>hCZ2I5hU
RcEAPW05Ja@UMkP;1<H^q004Tm_NqH>RDE6pfj=8@9o2[6<>Cg7R2cHXq6W;03`]
Pj]DFZAj=S8LL3]Zeb^SQ@NHe=kCiia?0R\np9\9]90dZ=0G6jK]7nl<_Rl>N?9^
L>ibCPb^Y4i\A6Ncpn3W]Kcek\bdf9CULbGf1H22NEf]h>]Rga_hgcSNO:@OpS44
I[:^jON:oIEHDQ4gVjMd8m9c\3V6N^KCjbd2egA=qSHaSP7IlFn;Hc2>QPiJ?g6Z
`ie:]HKACk9a6aQqRC71FL:qPPW[1RhlCd28_;8\eEekBN9:Xo2RlXlGKk[@knja
86QY]K=jJ8i0V8=ikIlIp]]<P>7VpPL<mD2pVXijQI^^7Ie=SU3EHb7Rq>kH4?]G
;93^bHeI_8dOK:=79R0X>cN;YE>ZK[aL@]H=q_cTh\Xnh_;>NcClJ9?`0Vb0I]:d
_PTfHPHX^VK^<Bohp\h^7O2>`Je[hgDcBGK5^2<`N[loHAV2>BAY\GQbnOm?pA8m
\Sb3fRi=3j028<:^187dU0mnT@KbChJ7NT0<:mE6l3[PWlOqnfb_2UaLToMl1IKh
6>IGmRJ[j@>QohfJ7C:foZ`QXS`p?X\4C`Sq?W`;Bcf5oNVK@Lofm\gEZOc6LWSX
7=PZpP`H3h][qU9=f5cKJiW?DnO8H:7qZo@aZBDi`]X\`a[LU^XIhn]gqoEcd6;D
bNn>;m_0=Gi?NpNe>R?g^17LA92JV=EHXdJ8FAXOI9oWfqFio>\HESZL0cW;9TMI
D:`N8N]0UDg5;Jm=q0[kRSQ2=aRfH`a2egYofMl9>cXFR5L1>4_bS``c383276bL
A@G`h[TLHq7mI0XmopN2YJk?@P@Jmf0<`UJTeO>oY<nA8K6hpVolOFNcBA3GkCH?
ol>c5LC9eRFTcTQfSIf[8UXC11WRI=3^JoK^8A9Y70Xl6HKPCO;WNX6YXOC^aqob
ZXaoXhcSZ_Vg=PNhDgTB9jpf`;RFlnqgCglJ3MEAn@lZcL6jU6Qqboc\ZlQ9H^Je
Qd7bGIpUobdg1hCD65Zm_KNcH4SdB<B?3YYe;bEKAmL=Wf=gm9fFmW@94jEHZf6m
^2NL0QQS?OWhZi@q[dQI1F:>q@=^@NiHKkI[obLkk[_Plp>\Zo:mU;XZLYCl0gNo
A2A5XL_B7o_LiiTVJ0>i\I]75F5V9?7;:;[SleJb;jp`9h[SY1@PYPW1@]DJ^X4@
=_m8QT_IhK?NRC8gN25FF2iF]SoSl=k5Qa>V^Pj2I3nLYpLnNM6[KPpPZDfIT=5<
dMJlIO7XF496ai9Qbfpcl3g=Ak^XXO4F?f]7Z1ndhMTEGm5T230Bh0YW>UUZlB1;
F3Hh8lf9Xkn^\h2k`4EFXq6ccO2deAqXe<iXejJQmZRJZN@ma`8JO]J[kSao6_5O
nR0Y:p?kJYN1Nj9U3gLIUA:WJE32_1=O3Q\dhS=c@fCR;<8Ug\k1[Bhfj[q6S6]G
\D@pUR>R[M@np=7RD@N^Rq2FUnP;HW^iQ=2OB:0>Ubld0J_89\EDIp\=gVc[2g7M
`=W]MGJd?CAZ<[D>O2S>4H;TQNZoI0;=apOD53Y4aR6E?[3YP@Bm65eRX9gji0IS
WSGGkRq4Bbcohq[3@2MMB??Kk1;UhEOn2dJHFANOMg=d_hilR:dIPj=PZ1biG`m;
CFSa;W?JQl\GIgZFZ=C=RBB6C8`??Y2hZLZobX8bpAb^IU?jbgj][0\l`SO`DC;:
T^_a8`Jkce\CPb6V:\:Nk:EBMhC<qS@j51@;6U;9>@XRc]\W6_mGigfZm83NoCTI
V2WZS:AQL5HB<8_nOhY]S@1BGZ^]@XJe147Sc0d5jO_5[IYm:22q=<NS:^\5P5:@
]YY66Pg44n4kVGO2hTQmNgH^H5cgVAHJh<S[O<8cKHDHGKDiJLl]ncG7L0nfXH?[
_7XVkMRWM5peoLDk1DV<5\mB0SR2\M[egPm9Ugk4M?5Mg8S^Qh]<R_iXe5Tb>emY
67a4?YPNh8ee6:8ccAgP`;hhG=WkT5=qnDK`ZF?qAESdV77i@hM6=KXoQn=H`^oJ
?njWd_6A9VBU:?Vf[;f[T]H^l\04^e]G?mHR5ZkF`5UFQOB@LEncp>ZkYmZN27j@
=gGANEQ8cmMZUpOVI9Y<i?T3::L[P@J\j262<Fq9ig;OMYpoaBfkU>^1lD?AJ0Ga
@NFo=c:5FCZ7NN=of3l5Bd9YnfS$
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
D4KRYSQ:5DT^<VeDNjWlbWfXhZP70Vj[3F;]SPq48oO__>NWA03Fi7J1R`XFE^G;
1;Fi\7<>ZQcoG5<@V8Kh2e\Jb_bl7=G5H2hlFOY^Aplk5iIcE44[RT1IbKYn\V7W
3_:JklEjLKqV@<AEjpm1WYEVkIdILOMW6RWli[lmT=ZC4qKB^Ll@AphA@h3[UEoU
VXlHqh[jN^Rk8`]fg?ZRO2MJkhgYcW8qGVT<8U^A[Zj6ok<j_=A>8^4>?eN2q9T^
>:6Tp^K6cQJVg:haK`\l3U9ebmYR]E=]<eGgf;ZBlpCh0PQH8>NQ=jd\>00KdIBM
hJOGohaDqVXEC4Q3pYJ3`S0aSiBE807370IEJ4NlO7@mqcdeS;;8\[L2okl_E^bL
I>hpK28EHShCO4<EI[<Y\M[NA^m9gjTPo:^LL`;LBA\MPAD1:<Z`@3W7Dd5WqgT8
Z8[]qmUK>J\\kO=8;HLY:Sjk[Q0c90AR>2j`Kf=Qd@R@bEdjgTaaS41EdA@_nb[^
Q=Tm7M>m<3SXRNQVmnl=]IT2YhYIpiO\^dhUUKF?VUO4G5iI^pagGllfGqS0B;@d
M6NP[TGD]<=a6q]37Di77c61efceWeG>k2HFZX<_a7HP\@ORQqkZNS9\[B>1F8HA
12]e_dY4=f?;;RSjm<FeXZN5ZR7Gimo91>lFjin?:XXl7fe0i2a:3iHY?>9LcRZ4
\g8ATk:Amp<9XK?`[em0=I`eCi9a[Jp?L=X=C7qJ8G2_M@M9GoaGITG^o2TFZ;:d
@j>hn?`W96qB1XmgETLGdLp<ef;eD1\o7A:idMg_:lE@USKFhFWR?m8AKo57_PBa
\`DcHeXf6Nm1hBlkK\4WU@IYcD3KHePq4dI8akiqTQFI4]9cmLS?d;=`J=a?lAOe
\eP38\HUVPdSD_L@oRCIfa7qAl1]ZF\=Kh[8:;2o<7cJ7GT;QNFAg6L?7ZdNBEUQ
98V2KXDofCqm1]S]S;phgTGMA6]lj[;cS3<@>^fDhh_83<pFmj`00WSW_:4Sd=a>
BNVZCql\`4g\oUADbGPMZfScD91^=gW4_AofJe^OhpP^iIJ[cdnH>^]Nogk>;;3V
H^\e9dm:\lE=opC<;6KnJ]Z18qSm\=8l:_G0<V?fM:p4`kA@0R<i0jjRU9:Gfe]_
IZAOO?c_DV:?0`Ug6fij_Q1h`3eU:0E8hlnEnaK2CQebP3qLhJH5;2:5S^mFEak_
mcTZh1E57l`b]YEfObc@9q8JP^F0I\Y1QQW8NARTW>di]EO0[WX3AO\Yh_>bUUXD
eYR>Bcl6Cfn3ni;oT=OhR?MR>m;[:OIWIUFPjaSRBXO>18dCCqcnk:4IaJkX_^eP
9V0o`GHX<9OH4N>LNLeNP<ZCOGqR?0UWk<R7_7EVH9`d0XOFM4=m4=HU`PeoR8ef
g33`mRGomOT^;`:COVf9Y;NhVdMkWbEM8]nXbo34WbMj9Kl6jIfbmHqc<NLk4Zql
9EEjBUq]CEN?bn;bkiO6O9g6RqkADN1=0ADM]VgV0;VbAmO\7?Z9L>n\`\Heq6WZ
2:1oL_i_h=;^bjBZZZmo84oG3;NJ_\`gMA^:H6Dmi2;4h\KboeYbPP8b>U<AJjaN
T]PR8RWafR5HoVMYQ?N4eSmikQB7X9]GmI6IqnoM15FlKejj1fnVB;@ZSN5qO86N
0>KEdo;cNm_Jece7;nNbohL]Pb<BBGN_qC;8M4I>YoWB^;ofjEUE_H_3iag;4DOH
cKnV30P?12ZYcY2fN>bAZk`O`m_NS;O3eKBJn=YPKe0QbM46GJ0TBihg8UEoRkJl
>[MeLR\;p60?EJjSgTT9bT5eKi;d8d6<]`l]j;XDVnD]4qT`deMBnQLnkAnVl3WA
Bo20;anG[=c_04K?nkDOoAMn\Y@]0A;hRa>>9YcWV>8dW7EZ_2qbaZdoPFXQ8X[R
OnQZJ_kIkmKnTPXZ2:^DKIaP@c_NhPG2[c=aU84@miZ1bediXD7]QeQFW[<HK<Z\
RI8CGBk\d7JJ?8HIa4lloPaM`Xq_O7fRK=q6T3Yf6^plj@_Y_iP4XbbRS>P11OKW
DIH3GT@OL2m[AYf=:>lb=1HdM0Z^hOMfGbP4MaM4NH\GK?f>X_cMYaT:KjDaBlqo
Z31a;O>8oTWCFe[@7efEk@aSOK=PiCDZFUQ?`lFcXKaefhgSP=HeC92qb07i>6:p
:dLHXI@X;>3A3C8[Ye`^JQ2]ihlX^aOqBm1ilnJpIPjT:P6R[9qJYPgVLS<fKBkh
9d8ZI4djmLYPZK55T==p4`RTdLbIheCY`jo0d2LEdWI`]P0fbCPj;BSn4O>V:UIA
@l@bh5e[J?ce;6Zn\oMf4hEUfOOlSXLZljDU`m8DihL9`LQ9Z2q6_E^A<fiFZ?n[
KV8_c]ipL54Ag`Dq6N@6lIUNZ=jMIX9H851^T7W:e7K0DY2gUnnV0`X^aX[jjU:9
X7`Nc^pYk1LiXfq:2EYLRnj`g;kHMC^L1G:?EU5f?o7lQT1]^KG5f?m@1KZZWFUc
:JK[m:WSRWjO<d]<HQ=1:Fkqg01>?OqHbZ`Rf^=AMO\PloHfaDNd`UH3]U_LAIgE
Lf1afRjLG_O_]2SgA65mOVc3VKU82nbHlZK<o1ed`dQo_i\p7S5^k=[CnD2LgBX[
Y2ZLRS<=51=;_MMg;lP]M@38W4C[<?3K<1eNod6_eZmC6PJ`7f506l7QG5Rbqi8I
_>J9Te01WUcqfg8G_381Kn\PS6o7\K>Q6_DJM\[X3c41bMa7`>P4cDT4MZKMU9nA
dAT\dDFTQ0UVfO8HZ40]?C]7q3>?FIN26]b;KKK6jU\ALdgBGgKl_Fd0IUPWAY60
HcQ]F9;24TAMJfKbFkfNaBlKDGfX`TnT[WDlqB@j7_IZ>74bT\\>lFOLc^AlF0Go
RMB9RBaRM0CXZlQHX0CJL_Ae5WCeJ=EA_\hHK9<]N99ZVdap?mRBj\4p__A=ZDKp
S=;Ul`gB0L4g]Ro<?PQ_2kfX=jp]YHjOiZoZJ=DFoUmVa5[h\F4DDTj54Z8qb:g[
;OKA\o0kX0T^8Q6ON<??V5aWgf]TA`E;^:;58S7g:G4Y59O2A75n\?iWjffq1k5;
Y;:Qla@H[4V^2]>M;PJWQIlD][_@\F8ke6:UMTDeH3jp6kcbIA$
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
5M@;FSQV5DT^<h5]o51L7aG@KKp_biMT?>m\@<RUGMo_Nnq@dG7IPOmaKVBSFC4Z
8Q1K0Tnn8RW0HgQN2ZI`F[p_9nG`WpIi0l^b8KQ8l3<mbM=m;1dU^9jCGhk:SahU
D6CAZ0UoqOI2AggKq4ITCMRhOo9Z1BD@@=4X1`MV7O<U_O_c2DZM<A2_kK\7pEi;
oG8_qk;bZI?pZD39@cW9AE13h_O>AOf[;a6gFRVb\Z8V1gbaUKR6E4@:oEn@i@D4
0E<C`VQBSPU\7H7hnegT<@:AZNao_A2U_GmO8@L290qRg[\Dhmo;2`SgUcNY_ZDI
kR2B0<dM5lJBUA_pXENLYXml\heHakFYXT8af1@\[?;2a8D9=a;kDZYdDGnH_>M6
jD<aZ;1_UiHBMhd=8ZM<iXW6EWES:l3mAf4egP\1i=qQi]9h1R_@PIc;:CWZGSG;
2eSH:LZN;[a?beFCAoK^j\gPKOZK<eRbNKRKR:=P\B9gI[o8WSKESJVcdB1d50:H
QfU[[pZ3A;BYel1KGDQidHO[HW<E:YinMP\\eL03KHmndGM=mKQ04g\@=QA8`_E=
E0QBNEn<_YY73TLlX9ifSZ@2fVXIe8po?5_BihgiVm[>75;:lOGbN32N7e?6UHl2
E6n1QnL2LP2N2SFjQb[Uep34><bdhqXhlQCmnJ>G<U5>adZeZIAPWEYRHoW43^5T
FXB8ZfCW1_??GdIE^AGgXL7D^CeJj^=i=MVRWILSfd3gY=<iJh?Q3FbGL4NJaY?5
ql1>6ZaAKWmZ3QJnDVdnK2Wq]USA5mVpWDMR>Dq8el8>\4D<gl`RER1;408SWbF7
XS@D<b>W;Kf`E8ed>Xm2IV1[A?Z83E^P0oCjDG7KEQm:nWVe8d8E>SnN3LW3@hE<
05`=E:5YO=Ol8X[3Ya@`B]30@^iXOAP:9TKP3@<8oDm=]ApW<Q4CXojYo\N>7;G6
8mek;ZG[cPlZoRAXg12Z5[bF1gFD1PO=clVAhaLn:RQ824C0TU_:TTQBEVkU;dho
65TC^C0H0qd8J<YUk_IToFTJUSjW]XXdJW2f=]DG]0GUY^\lXoYkBYVB<^PVEQaT
cH?n1WA;6BRkNH0m@W0>:\aQ5mC8a:c8ST`1qS2BNiZEa_6on53>D[F=K8lQIA1R
Wc6BMYCUiCRIL4S9ddYDT_\mL@QT4F[55CUZ87H1UEjAE\]]W7GbfhC8jh:a`97q
0=j0GhlgW3RM:3ZCiiEf^PS1Dk@Hb<qdHD]ebEN0aeZac4jT\G@4bSPH_GaYWZeh
]=dZEg_36GETY6`16D5X\6]k`JZhl[];_fk@K19TGUA^A=Y_I9]D[n`kYZM>a]1a
`pn^ajN`aJ;kI?N=Q>NiBdC?:U_j_N2W<hSoIjnmj5XYoP;<qPYEK:QKTFn_=@7Q
l0]LieEq763Pf@]m8^aWIbG[Kn:ES>;FYH]RGnI?pZZ0T0_SCoU?^:^WmXUSk3Np
H_RjUUG9ARTJibUI`o3eH@AaAbV_K4a5QODhHe_9XF3SaSn<fO>D9DXiDdhNc@S^
n17;1E=aaSfUM\U^`fP`YbPqBYUC0\ipA7X:iM[9IJ4jQnSB`:9RCMi9`ojmGYBG
Ji_X2RZ`?BXQObq`=O^36=pQTN\lJHqc0T\gmlpZbfRJ?6o11BZ^c3dMK[GGe]>L
<MBgc22Oc:6RQ1_RNOVg`XA?5UN14h5Lk@JZJ42BcWE?nP6mbd6Yde?_H4BPH05g
fD>AlaUa7qc]GJP:lpT8R5k>]hg<]0cNo8G8fL[Nk9JX6B;op>Ha]EdOL0`VYHGE
Eb_fSD3q@FN64efq3afN:Q=hlJRPYIZ`<3SD`?9RLbU5XN_5?KCn2h?GM\lSC\`:
mllqUT1PHhVXX5\A;hkGWNVbo8QPKLhOm63<g?1q7QLLWReY]R5LkkZ<:]MX=7MX
hg:K7E4D:IcM94;<R^VUD1R=Be87=mk7DR<2TEjbJaH>gJ:qJNULMV>MU`EJ60MF
GagT@78\Zl;94LQEId9ple4=d4qJ9O]_KZa;SK\<22cKo3=qVPFJM[Wl>RSkh94N
]Q^^E:C`@cdCWi=UAbedQ9TFEnqX9Lh9dl:fBWZgQXUCI<ha@N:K_=g1V9Ch1SYW
_@>IgQUJ\a4ReXq@TW9Y<@TMGW2jhaCL_?5bBlV9_<njTcS<ja`]JHM9iqh;;A_E
h]@haIIA552[8C969kH58@@JEjIc;bXDFG]cqe7\hZjXokDU@3>5l_Y\nY@:2gRO
oSTKLLUITZjNWc<q7`hTH_RY2\dViG@YW[EGPCj^a<_IA=0oHQo0UXXeJQVqAD7S
f:apOSF7>Dgq6L0AfopRQ]f9G3q0OH<3U2qAn5_LF_I04SGdWlNJ7Eagm5DK1:C7
Z]mMA1`N9b>k0=k^1I[^RATqIk4Z9cEq<NWNfbVbHLQ5P[YmB9Vj;S20U_Ng`PF^
N3<gQ3l3hga^j\NeaQeHdh@p=H2b>XapV:d@GKY82YT<QP35Z@C:mN^_Q4O7eUI[
j?pAkJVo8\ml@1hqS]fPg0?Z<?K^QOphGj1?d[W1ILcZSTkSC?K1ofOh09cPWq2^
^oSJm=095Fa=pd:B5d<OVg6ZQPiIX`d:M9?XT2BB@]1p9ef_<a[GJ:OaDiK^ZVd@
M^\oFjS]1>Zo28lk?0nLO?5opEFF9@XoJn4:S@<qLX>BRK2<U3kRYWXZZAn22Y=V
[[J?N=pVmBMfEP<3SK@`Jp0?3U6d0\TBA70Q0VTAjKo8;Q=aGME7p6FKBj]8X6ep
_9;chYU?nWdL4a1]SIV8\N3=^QG1>XbGV0a^9kYa_Z]Ke>P=a\E8ZN4T6kDPZkpn
1>iaX3?L_N<]KRPD`maC\bZnG@:O]5qL@Y7T0lqO9QAnEq>gogC>AhkmDiDhTfbZ
aV6bpFm]N=ENh4Uh53;@lo;d7C49<KOMkF:Qf1?jF_>SXH_hb1;J0Kdj\d?b?fF@
]c35IA6g8BG]:E?\gOGPLVPglHHk;M0Q5=fEagHE2TJmRWIG=l;Q0]J;Cq]JeEh6
i\mUIf8FeJ5Wej0NeDQKZV9;UMd0ZX>JePMRkL>BVSKS[c;]jBYlZEYMA2EF130i
bgPNV2RAo3`3qm_b>5EC^TXA1jgEV47NJ0jhJ?hWG<6<T0AO54a6XaUMdWPh6]kd
lG6\a0>XPDVJEaf9`WiaB\KC?@T5Icgp5<S9eX_EhBeB:XLbPSG8Wcd8L4ka6nQY
V]XqCM?iT:^W]<H<NX^kO\ADFN?7imG3fJ@6<XZl`JbM3<MZ=Mo0SiWfNV48VncL
4c2mnT\FZ08hFNfD1\9DMnp0XB\al5qK01dgBMd0hZOg84P\PHo1=K7@0inIHX?L
Ym=mP:@33oJdB7hFdmKAo8mZ<8ADJM;a>GFI@mV?iW;n6GcBb]LKGkAXm3b4jYUL
5h?q4nGgfDFD[Xo36`T3bAfMo6pE2n_J`@poMD:Jh@lnlkCHi@hZ?9H89WRn1fc3
]SPi9=88@2ITT0LHgQCL8eddX3Kg<Pn2Wpa^NAC=qUdd^`4;:GNoTPFS`XnF>_=D
c4S6go<01gl:j`H5X@>87iOPP1Y7L\QUTjAj3McnkWa@o5[:N6okbMS4RYC;W_O8
UESUf;hk=hUgCZ:kSnG9cL?RcN_o_3S3NOheaM2nlMRDZS7[cm7k>Mgl][^25pR=
NC<>4S5cUP@fO6_IIh2hcbKVIWbG\YkD[HA]_j8k5LHNAgOQh:CNMR`O5Ud:3HIi
[ik?7P0mdH`SSc;[p9TUESY_\R[_RI_Db_]dZMYBgOH\ad7L:WK4ZgZ2^Sc75hf]
I?i]XbHQ90JU;aeBOkdjSGg[W5aX@Qd3MAkq3I@<8eHCkT1h1V[n[G9==1Dg3Y7D
^TjY1D`J6ZT7V;KZSKUWN\Ng^T^<Cl<l<KiX`L:0oD<^PIJ6Kf[L?Wq<kh>>Q>RU
X\oK;^cM8Jeb8f4FO5fbmMcK`KkIUdUWU0GfQOfnTi?^W9n7=c9hCC_T]]dRi254
h\XFhJ6;Le@[_HPc:F:9YKeKBP1ph`aTFVfWk9?=G@8AL\`8;N<QD4`B5EFb5H^L
g4qZQhRZ?W;d]ZAd4IKJ^LFZA5S@@ob>E9cqEii]:;WCh5]Z2ZZN6^CUOn?`C?d@
Sg4A`^J78L>3njgqOTlRRlAQ:C\gP`oJLJ_F2T6AKQSn\g[DXbZ\qH79Ij3p`WfK
;e?70nBQqYmMo4fCBnLX_:;43VoT<4SoFM2jcSml>PR;oG3g2R9qPAo0`KKkRVSl
BQ:@U8=<i7=71<eb8ko48f?EK3^j9lqFO@Rh<k<:9_cTZ\CJV48;>l1B@QJ7LoSI
[E>LFaXD8pd<Y:bT]PDB4<GaFKcJ9K60g4Mbhm2T[FGGHWi6`Lodq]I8jam=qZ;4
=?5UlH3mm_kl\c>G`Ukh8UJomog^aW5Lb9_jGcE4dCN]1mZEh40dnSKaMo>qXl:Z
Y5:<9blPgng\NcCABAklIcWj>@>12nRN@mqj8_eBS=pZcoHNYpV9Sd:;7nLU\kD>
U_ec`p@8l\>BT9cc\W6O1TcmS@7iDT<GL1<5dCV1mW\3_VCdKi:cDHmGDjEcI9hT
nTPem5F@C1C`m^IBC:g=[6Nm58>>\clYXp@Pa`[:_pMiBMgegcpA7Cg=8S<?Nj]J
cEaa`Rp?YPMX3T0X\C5FOA6iHOL@H45Y6?Pkg8V2Pm2]NYjm=k_J]L]>eD:\iZVD
Uh2N>`nQ?@F9P:hC8eU;7AAKD\>e>iQE2?m0aRA@Kq9R7H8^]VKFjf>NjdS\Hkl2
H^9Mke2?47BXqUl5KZ??qJ0kmbMXeqfF7NbE>qJKl4?HnphBKFdFhpT8_\NF5^;^
e;Vm7`_>6<:EO==;SW80UaED69MKg4le0W@BE>M:Q_4hG[W=Oj>6Dh?`\U_N9Z\Z
8Ec?iYa?KamEDID`GP>UDB]0p3OWe?Rl77bJf:ZY_<PdbLjokHP=pf962>;Xqk[0
`:hkDl`1kYfbG\6=G:DqlTW<LiWpM]Udlea=88kJNKiF?7[XoHZmc_EBhF0`C90\
DLJ4kFnLJVCm;^L0qWFdb36UYCd_C^\hAJ1lI4VWY0C_e[_=hohmqSimPi@0W;VM
5RWeI6@3=e>joPadY7mN_]_CplFXnD\Pq3PG0lC6ih33@6<NT[@:bFNH?[R_ZB`p
6H7bh7E$
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
<F`R:SQd5DT^<G>lWXH0cXMmhY]b`hPI6DON_`LN]e_c^D6m9fN\=lZFnS=Sc5::
I9hXm1PNpY>R:UoSAR9[Z<G;l[RJ;Am0P[\:N1co8\?cO69O?hcP1[EF8?ff3_CQ
1T?`EfLGap>QAh@b6lL>\B8[7cJg223=V:3c6n;1[UX2Adkk9TD;ib@OLg5<aiCW
2DFFO[qi0c]dlqk0j_4AORj<k40dDMebFPK_K=YbT9h12_q?D?E]4gK<\YO29mlU
@O=N3qToa?6jEnJlPLO3QXl_0@qYKSG?m>HLB5e6>4<1KT^_Qfnj6>0AOF7LJqN4
XOI2B?H>8clfVUEd[2R_MJUEJHB^0E]EFnq^V1O1fRn\:\?eL`fA5OB^hO2[]DaN
<OW1SFT5_0^:D^kIb:8`8TeH?pkB@n]Y2q?@k<;2_CUeG2iTA?F?jB<mDCOR\Q?H
0NjACNUb<IQX>WJ40Db[iAU2Hp6L6Ka2T367A`KB:ML2MH;La[bPQIAIlK[><@5c
5J1QCmeGa4qW<Z`8DgILE?_8`q:9N]^0KjTAQL]DEdC;QdA4Qb7>bM<j[mAcC<8J
HAb7=pj3NC0U@qQgXbMd?gj:XOO93Xgl>\beJJie37h9KiB:1loHST8^?baMm@>Y
`^2fYR11hGh=:0gX6QXd1I7f1iA;oZFS;^jJqnHAU`LTq2CIcP9DD<dfFRkUYE<:
A\9o@9;f_ke]gpU8V5ifPcS[EZ;73dKm>B_7A<qDSK`KgGpIPWOENBU56ikBFf^>
L;7:;h2?12DmXlfAfMo;b@hO:DCeo8T>3qHi=BWV1qlmnlH^o_ja<1eT_WiQ]N@b
OMli[5Yk\GLmA8Zbp<INcgmXqBmhK3E0CReKl3Q_9nm3?gYic[;SAV9K1SBb9L`o
Z;JR:XB>VB5JXY4=gShTo\1JWHXO9peK626d^5\\=Y64RVfVUgcF`06T48<TONY;
Qn72JekdLZKo5PA]j6<1WpQbT=M3MX6V5`1KZJoN\AIf[mghF?=0I4<SmmTdU88:
`fS;mhq>^PMYl=1N=^QJ3PQ;Za5hN6[kLj[Qd2nlJ5=`O@<37PqnWTRB9[pS0]LV
=V?7LhJ\YH6WhQH@WEnjTGj=M]1JPUjRC0^5aLlHMVmQ^a3:G_KcgbF]KY^kY:UY
A=Ve]7Xn\n^jb5h@g>pTJcS_\IqB^E:Wf]F@5LiOHC4_nDc4CBeVhQ@86F8@6?J1
LcaO;?3aIHiALJ5d`o;47k663_oL:GY2Zc<gm=lARnh`3[LpX6=kc2<LL>GhKN`o
>KGiCUM_APBgX>U88l?pB]mOa7QJO5RT59MGAbD;FO]3qi@CCoNW_o3Nea37U2U4
<9^AX`o3R^dT>P^5FEePZgW\bYj;IdZiCZncBj^T`[2F>nH];VSfookekTnpDd;>
];dq<PhOI;LoBm3:79gUS]9HqmcD3cEopmFZ@RMmUl^lIS3`GpOS^=[a6p`ICoT[
1\=kdYCOTH:aeH0eeEB6H]B9^>8apbGc7aeSPH]=EoL@KG>SNG5SKT]qUe:o1OLq
L2jCVZOp@@Ln028qO47T9Sc0lL`=X;BKKmH]7EQHfE8]ABbEEB2M2B^7pbaiLQ[b
A=4lT3LkX`7f=Z0OE<?biFj6a1;a6ho80<@2TqgcIO1YB7AOV8C1lFO_IiUE8K8Q
JWn8G5G]PUZ]A5T^a<SUfCRMQM::?UqhYDc?fiETZ9C38]7fiCh4MGa:QMaLkV^0
KUS<bD2n?LRWe<E4A^JRMf9[L4eqd3gjjFfB_<VVP4P2>GF?m9E_O8L@JU@@]0TU
FAWc4A6fkJDXg]NQ12b=]cjXpS1EU]PXp0cFIC32=C9p^ae<CgS[W8dmo<\YjHoP
:W4BiT<YkFHEk1YL>bW8^Edc1]:PqLGb\fWiZBc53_?5<e_6LVK9Vcg`VcMNlo8:
b??<c7nc:BZ@1ddIRJkAC:6TkTU0IJZ1T7j>qTcU?`\Pp\k=<C1YZRS_UUT^igMo
2YI11[9\R^LYRGK6cYW2klhiMYN10fRmYO41WECQ2Hhq=V:QjXpFoKcT6U[i7J^N
n:2RfH4BOWI9Co\B5TVc=`K8V@V3_K@qX>M2`7<DMZNjS2G<imYAKb5mc996:QMP
W5UI7R3[5hX4qg\MKj?2cS[YMM<g<f\4d`?]T;3W?]BeWWQ^4[AKb:MiG5g[mgQU
=8\B]qYmeX3Sa43\]5H`V0Ol\hH>DB?9Zf\5XPhKK9U^q7o@ca]i=DLoC^?@koY4
P<;hAUj]FJChkUZ@dfKoQWb3B=?\nEjDaVWQ0kmZUpO:TMi3hq\mMaO<j<i8qnfe
62G6c@\;f>hGho[lSiH`Rih798=?>BR@BH]ZVfUj``[;6X:inqaACJD0c^Hhd\Vj
amm9=>CTlhn`W1S?^5`@LhF\dg>FW4AK;U6a?6nkC5fMUFFAjH3nYf57[mZ?XqN[
^Zo9epYL_cZmqVcA8?YH>aGEGV;@LHWiYYFPO:DmPDN8:?RP91QJ7XkC3pTDX\1b
^XMA4ol8^b_aHMlLcP@7N_J7oDNe<JVfA1h3jMqAWHkQ]:QOG3e?Kcm[I<O?BJB<
\]cfVYedZoIU1LIZI2WJ5_[<jcH>A>QCYBlp8M]P9ETXg1ede\gWaRBHb;5O9\?@
DWJ1D?6<dZ`Ido>;2EXcK7:6D2[0q;>]f`e6iQXd2aHooi;EZm0<:[9YiY]d7Gaf
>72JG=0[^mH5LemULC50F1gblpdR65b7Eq\Z;^^`Kd4nqbPBdU^@T5FWiCc3f2n4
_`Z0;Mnk5LG]7@EZi`]X0G:gL>AT83B<dpUSGVB7XkCTEXnG:3og\9C@2`Q[[jB@
0_Lm=SQYOjX2DaoTFJV3_N`8Uk9VI:X4Dg;_20aRjgq]HR8Mc6cXNg5^lNLo]`>O
VcnPIK<hNlTMXWBn<fdnBA`J9JZ0VM1Ro^IdI;FJ^UmhX_P2?W=f=4qQV?0dg0qO
PSe`Y$
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
