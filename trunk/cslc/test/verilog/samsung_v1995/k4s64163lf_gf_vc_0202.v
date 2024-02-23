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

`ifdef VCS  // VCS Release 6.0
//`protected
-Y>^JK[d#eb-I(BY)g&F8&9&8fQJ)9PX)YYJ1I(EAP8.KSE02WfX=>ZE-O#_)]Xe
D0T4R,6V.<gdSC]Eg(M8/Q5MNgNfA:A.M8DKWeWOdCC\;<YCI-f?&L#16@-b9+aG
8T&+B1\)_Ygdf@cY2Edb#YY.SD\X@)3=4(V7Ra)4BH+VVLV9ZCDJAORR2b60:P#<
9>30b?B)([A=W(PO8E]67#_Yg;a<=^.XS]F/Y[1O(PfY=2H,ZX.AH#HM3BJ3/8fN
J7Ya?WGRQEeQ@dB3WA@+^1@H5)60OI4)P4P0Bf7X6-5.3K39>>bLEBZ:N0JaVWc8
(W_#@Hd\@:NU)/>CVIWAD-<<-R>=#J,Pg-JYD[/&cIZ;6Q/Ga_#E_O#Be4f>T?<[
)/J<UF#=EE;0;>J8XCFA2X1R1L@bG.V>DDC)MC4,YcSD0S\3N#TK7U)faL4LX?ae
;Hg12:MZ2@7/Xg,(O^REb7G1b()R=>16)7V>33PD_V^V7)I<^]3?WTa))B/V+UfM
-0,Z;[+@+>8gH71cPUV:XM8@?H^V?35(-W[T[-M57b=1W:@F#)c=@J25@7C\NN4A
AC7ZG+9cR6fK]+>F=D1eZV4.\?JFJYB/d2Cd=>#@NUSYEObJGKS\G7Z42g/_5dA_
TeR&I7QKbMJ9LS31[H((_=cC4>_I]YgTJ9>+95+\?1?g,->LV0cCCXX[@P00;-^Q
T6C>\eH#)PNdWW<:0Z_6R1Y\XE1X>8K]]S4JccC)YLAd7/:,)\SI):+9_>aV3eRE
A0aa,ND2^6>8(A^AK:<^M<?Y90[Te2RRUg2O[9fS0D2f8I+VGE]E&G1>GdWU=+b3
:<HR]a\/NE=H3g:VcAbL0K/U#4JALf__KCN8#BWDPQ=0EfSAXF0<<PYF??I:ad?/
b+,dY@1BRTPT^MZPcWS>MW]a3N9G2#)f65R^QC0cU<b&QQ=-L]KJEV^ETU,Q_NfJ
,EZ;Yde63>J>^BJ^c;R<N9M2OK0M#7e2IP7.\=J:7YM41AFGD&RK,)L:EHTN=NK\
bTA-GCbf8U8gP/^+?XW0TS]7bcU-1Yab#-I6b\XE#Y4-XU3fB@8SUE?cG\Z8c#QG
3_eg8?G?4eBUf0S.P81A6UL)G()E#4CgQ98&;-_e7gZfVf7Od#AA7<g+M=4KN#G:
YX2g#.B:TW[4OR&?R\d)0L/:3@T<U&J:[2MHVLcY4S@-\FUb-9Ab89E;DcG_J(6C
K.2M71Z#+57#X[?)MIaW@4L+Bb,FZbg(4_BM#BF.A5=V7>1WL_SH:Naad0.N:MJO
0f?,cVA6-N@SCS/ASc#[[LRV,cN]adV,Xc3G12+6],4:V:FgeO((R[gM[)_49XSY
WC;5(I4-NKR14K/PE^a&#>Y-PX5J^-gU7eII:Q?/-aNV:=MU(^7O8WX?aB3P[/-<
YOF0APTD,(;\<+4JYT0N/\G(&cb&ZM@cAa(3GIL@<OVG67G6WIP/g@<L.&dK>UN\
/gES[BYO)OfH4_#29QcDb<fTZ)+O6MRKAVT@,CY&+D0OH[_A=\7_?)8TIHT-+2<3
-XCBB[@_S.08:R_TB/Y/KBXF<1gL>IbL;1#,?V(28ZT87f)L7JVJXcH.?2FX[?[M
Nb9P6[85I&Y9F_J.86,:)c46,XZJc&]eQX458[272DWe+\__VX:6U\;&/-9)Fg:;
#1A\&e8D#E6DPe+d3CRY@(D2,83MMUAfM4c9P(H5+2[IDZO\1J1N=3<Y<2GdgZW0
ZGAYS2UOI/#3^YI/[(?.4-[gObQdOWIfDgOL70-C:H/J2a[N)BV?VL72[dbE?_#[
a>2HOc,+>3+D@7T6AU@PJ\(B@BYBUcCV.0L3=#Y-N&?I#/d7[^3K0JIZa5=aTP@.
T\@;]?.f0[ce9#G3D1)7YN;:g:?/.LWN?$
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
6S\/Z1I\8<H=8S).8B\K,4RO8F/+<[8)8Mb,8c6_,#(=6)[aTGX0<PE89W978(GE
,[>RNO,RZ>;ba7@:WA.80W>20=L?DD?O;J(^D+6[&(EE7A#6N(bK15U7[MC89ZFT
Ke<^F2L&1d.^O==H63>81EWGRXYW7D8fX^EBCNb_C<M3T:)NBS;/+GW8&IR4^#+Q
V\8.MEG0JF3Je?QBJ0fWcf#B;cI/\=F7UL>Re]c5<ga4E@S9WV]0[GJ:]:FF\SZb
O86I^#:G#B6=Qa]P0#aJ+#0=0X>P\D7.ede2IERCYV<K=g#03H,:FL]S_B?(CS@?
&30XgSd3S6WN/>:O#LF8VLO1O\\KRYBJ&UH?c6D#OFaD?X33)H(1G2e56[OP/BWE
Y4E@J.gSND6SdUYQ(_)Xg5@F4Ce=Y-5[-N]-<aYL[)2DIM,GL&KD,W,gJ,NEcYSH
CXO4@dV)-AeSAD3cIaC34G7R8K7WSeHbf]]#4+c^&G+B@b#=PYaI[c=C#EaK.\;=
:R<N<Id27YN#d#MKG7c_YH1dfZ\E<Y6O4I&e<;^;0ZaB[(N1He=Q\KWV.1#1<]cA
8&_J+ec]b/S8+YE>#bJ[b;.I^-0,W;PY</S3Ef61W+)F-0Gg+W71FL/PQ9IJ^0;@
+a+80d[KO-I_MWE/C@V>:KUN\,8B+ED&;6a\64,\CTdg3+/d;9.2E:-+EdV/HV/U
QJP@6ELM7ACDd&]F>Q._D,7M_4TQ:&Y^\JEG[>1;^SZ#PT3YQQdG(=1V(AID:K92
)CTO?WG22,Nf,H-fOX6N1-:3>B\e;FD]\=(bBRGC,Aa4TD0K]@E/^.NA9JgDR?LL
7<(]/aAJ0Ee>I&d&\YHcED=R[1R[aA45EUF<.F@+S=Ff2X>Y5b^6@\2aGUD(DCVH
X4gYZdM>bH^T]](S((e(<HH]cf;[5(Zdg[bfJDSXbP)-6SK[(b<_GC+D:Z/DWa^O
SBO-]3(NQ^VWIWQ[_N5,\9OMeddf4TNCTGR<0O9YO>G\]EcZ>7L\-fYFQ&5S6S-L
E4H?=FedZ/>\2RZF]ALA&LbNFTXYRYG:LYD\DHPF6aT)IRE7[c+1PQJ6A#R=Z2Od
NTQ^7EL.-^:.QTbAHAP3]HDKA@[[FZX8Pb2M(Leg/J0RE21(dg)=3\CT(N0V_D-_
/a5Q[\S2DYcQSVR4+;-W=dXJ>#[JM<U.LFSMAHD@E8:[K@61/LTKR8ZZV880.>M5
+IYXJJfT]?#NCTDVaOESTc5@<(<3AW?L/P>TKIH(3XEY[d\GF3,2H[AQC74N,E<2
6/f+@P\-CZ9ba2>,<M92ZQC[F+/f/f-3G9)(9YH8_dX(KRDM#TDB#N\cCaKT?/33
N=H6G(0GZRf/=\,NObB/HW,P/@TgPSW1+D2PccE]\L#0D-[4a5gd6>3aFeUJ/_\J
]@H#UHZ8f-#:PFHN#M+-ZD7YIE2f+Ke6;+)&V1=S=a#SdOZ3+\KGXYDKL8EIFI8U
FP&99c9WAX729.[20d;Ne079([E?ORH=gMV-II<K2HWW;;>\LcEbR[eWJ#S4->Q]
(2_SH]9g5,S3,L08gb_IRaUJDWO(+ZZU5KL&L;\ZUUA5Nba8L,@Y4HF&+TU=e?=I
D_c.6\VW<QR:<1L_[C^9B)RT42bDR<2C?4CU-=8/PVK(;((ID)\3+SX^\5;C44;R
Dgcfa2,W/8ecI5D10A(DS<Xd@Q887f3=2U1<g8P=[ZNX(ZS4N&T-H(W7R#c,\&N.
dZ2aN;T>?<32TT&RW\#e9C+LM><F3D-dJNR0Q<8<af#<?:SZ:X+d:3_;e#)0IT(O
Tb?L4]7-9XLA[T)VTFH[c34(>#+db:@+=b=Y(>Q59Nc@C/b\:C)a<M&QFJeO-dAK
1@L[c7[ZNW+#SK8S4BN8PI/(U^aG/gc^ZLL3fMV&/EP4P9]3L?&]/;@)7=VMCBT8
#6b-U]U<727;15K/A290[e#/BJ[[U[S/1PcZb)J/e6OK(19MC4DHY1F,eE=H2DCT
R7A5Z9LPc@=HgVIY_)Fe8SG3TB9?G?a+,Z8\UD&/.,?5Z./:gBI(O]#/cH<(-W,?
7_?E^bG8M5W5cg-=X5F[V]XbcN+RHO-JS9W)9&X.2H;@6-UY-dPK@@XCSN#5@3)c
N\8ba0a>EWN-]&A]D?6&bN-@4UWd_._;Ug>M#.e,>)KeMV]ZZZg<&FDH#@3_J>B>
IO<-M^6Qd0]M#[QTHUe\XX;&.9IVdR3,,4=3+VNZacd2^+91^H)e4>HPS((@0^RM
//A#J[RP#[.,KaP^^+/aP:W/QXgGVT?1(N1DRM^]4MV-:F;LCCa6ZY6G)P^C#Y9A
YS]aI<9FYa9W/U+45Oa#9e?V8UaP<MU&79967Ecc1ZfM_Rb+WNZFf##)=9b^W(e+
#2731c)ga>E4ZQgcC&+?a2HV@,G4CCZ82U&&3OG^1?Q8d:Q0?T4P,X80_JYRODCH
/_0WG(?a90aJcECZ>U21KS(Ee&C@(Ug&dXV\]C\QFQeS0g&_LIQac5WaK_^B=/aW
UJD2H)=g1E:L>);4.OV2CgD>-IPbDFCIbON&YFKI=OD6M<e)=cTUC5X_LDBP((>X
T1-Jd]22Z7c7\Y(f/1-,<U+:;.^U&<+QQRRTJ#S[L:OHd[aHJVA]c\f,8DbSZP4B
K7Z)Rb<OZT-J^6Zg[ROb68^Q8@YTBd@[9IDF\Ig89g14&.eT[Q/LZ>e[9HWEA\d5
5X54YR=#?;=?5W^=Ya465,2#9#@\/;;5M81/^?_P.P04<0TO>0/2&B-B?[<7Sde8
8O&R>DQ.ccWIe0RC_VB\ec[^-C&>,Q_WTD\;:E>gc3&9aTW+QWdJ6D-,0-?N4[aL
JGcPZ59e+SY4[[=,UC/B&Rf0c[J0U9:--gO\(Q_cL3K>IKTM4R#K+V4:CWL,E)L8
KO0c@+dFD<=?V@]K06-/7I-Pd9fL)[#R0WTWQY;#]<[I^9bL=bU^RE_Y7TffC#64
0U^I=WW#@N7?0$
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
8I^R6)4BIJ)=,2I+=OLV-\K(=BU9=C@-(_6+<a?e8@ALaG4Xd<-&8_Pc,d_7<?=5
S,5Z:#ZBM,Y-9_JI:SfffL>C\-F7eJBN0/cCWQI2I7V_YYF_e2[[Q7JgR(/MDb8-
NY7SBQA4KEJ84(/R2?aZc7e8C1OUB@A2T_,VJaTD=KH0N3e6CO9e#3W2gP((E9eB
?SWOf2)=S#V9UC<WKL?,^e3ZULYX-@T>(:WX-<3gBF7NcT<Gg1[[=gUP5g:A;\S#
8V:HZK7T&65c(J,OXLK0C?VL2AN4]JUX03B0E5^G=?I&D)XbUga<0g\AR4Zc=J4?
S9\^AE/T=U0(@B?1aB,bHX31F/&[\_&9Z8b\YN?@aV;&V2SC+f[I(34g[3QS_).P
;1dXCL=OG/Xag4/5>P&69]>>HcZI\#MNM7=a:VeJD-FGU[\87UWOPGYU_.-A3PC0
XUK,\(L&5?;b7^MSc1Le_63N>(ZHLBQAX]437>;5fe0SU+,RB]S0b,_R?(/))M_e
g3AaRTFLM-E2[KZM&8A]FRSJf]f8Xc&aR8K6TRVcTWf@_+KCN_U3?EE\3bPGQ@VJ
c_GVUQ3d[^(/eR[Jd,9(c6DMe1U;-RaLOF;[?gRSf0W;g1V0?X#g?(T/2]Eg+6=O
)bf[M,2PCG:=;E65S]I64?;fe?31GM/5+KB,HZSBF<B^@(0=6cMJ)VF+c\[Z)(?V
6B\U;3V41S>Q?&a8(0G>b8KRccD1.@6SN4UeJDg22U61L>K-LN8N0>cFWL7_MM[B
2VL7I_6>NL.]PKNfcQL#G+G82XY3.>9M-@.OC/]U.(&L(/)IE@I&+Cd8#):AOXJI
@+\Hb2M?6>?Vd--b&VfL5:,?C80^7WN,2eT#MW,Te:IKH@^4;LU\M[aR[R;Ma/W8
2X=0g[V(Ga1_EH0&LG&eZG-DQ8UNDI6_1b0)#dI;+<a.#=Dc92bMNZa>O6&=eB&-
Qb(T,L,H/bB1&YK<;0TH@8OB90IcHV_@_V\eR#RUE]?<bXgPWF&-X>H]AUKRW-D0
[?5W(#^RKgL33eO_77AR6R/[6F\,ADU;RMf93d?;KW0(1PK+[SfUQJ1F>7f92@S:
Z?+GfB@8c>eY#^@>_[JAaRW/V-c\E]:KU<dAI1@J-,[Fa>b^?T\eYVL/QSV\QNBA
eEd&GP?0DabLFcUEb\5YEO(=YK+UDQ2#\VPGN=+N>8<Q,G]FHe<f6e.Sd5@Yb@18
8>2=KF:gbMCF:OZc&2@H-36FZ\TFK[VZ^SI^0[^[HYaV;\G6&94_JJS_HKU.\S\J
E7ObP/DQ,(.VQP))ZYJgE5U0e4/A7fU)O_Z9?)2PC>&4SH(cZ9gQ<JWKS9;dZV9e
/9MBTNBM?)4;T,X,dJZDII24.?AP;T1EX?@T9>R;3_IW[=GB1P8(@GW]#,8XD)aK
2.cG6SI77K@M<4/].g+@#b-Z9GU<KV5,)Y3_Q:bOD=aIb?/]/1SO_ZA/6+;@EQD=
9HCJCK.gZPgQF>dV69)]1fcT=;2C5#U^AB_IL:.KYE&aYD5>0]M8VMUSNPO0+[dL
T<(HM_Df:=)S;Z)EObI7B14N4gH47G@42A>>DT@dZc?J#eb0O/>F+(e(R6ID0/(Z
bVV=V/\Dc9@8eBZTbN+XGWET6#CIZK38\Vb=XRU\>RS+>?F4/d0]TEK^F7g1C4KQ
RVaCJFN^/[3#)7d/V_\3]PI9KMAB?L=TMS5^L]3-CQB5KF,WX#NE<N73=XOS^.b3
<@,^-&dH?X-Fgff4(6N;MQCJ\2_N&Y1FH)T.??VN7eF_B3,B)&U91DBM-]RB.0EO
+FU4_3>J=@WN.1H@3?]_0:6K8LTA)OV8&@9OW>#7BRKCX^\84OU8\]_-4[KZ:6Ie
:/F/gB7,O,e67]/7L/_G[(c;D]=\H85\C#=/G6ZbFW)H8Y>(TS0/&)NZ@(a3/g+f
5431.P,CZDO?dGgH35#fdUcZHG,V7aJ0L_KSR]@O(N<,dZ2fXaI95I)Zb7FfG(TW
,6=e_AMVDJ-(#B8<6543&P2Ue;T\):\N4b6BfS,g7;1NHKg1DDT4U[f@:K:@+--X
UXGJeUGK?He7Y_FW\&L]CPPSM,RYWcaKD8?a5Q2PF9Y,W,WMfL=2H26BF^I[M,g)
+41cYPIS4+)bOIZ_\+e7KPa;ZN#/B8RMe(EL#5<#176?b].YM1Y39J2gRU/1(QBX
JR,KH>X8+WVP8/)_WDWL6-(YDgF95MSFaU73GU&>[VK73)cb]X<c7gIAd((<;Id]
fZ+f5EZQ)#I].83fBM_#2Y[;d(&8D9U_=QQ&:-H:63O^;LNWbG/O1QaQTA7c15-K
6b:;EZP(2<@Y?:YB,LU^7]U#gM&Jd;Lg>WZ/cXL@Pc<,TN)ZNZ/aM^3T>aX>)=AZ
(2XHK?Rgb6RUZ@0T4b2?Q)SSUF#8TJ=4b-+T.)gK.eYT)3FffRBN?RUWH:#.HP#Z
>>L\LRfG:XOE4I]J([.UeU5+9<LFbE.L\)B=;c-4W6HBc?/_G9T[CWL5:ZSN1&C@
X0J0NG+[;U\O_&69RaO#Q?_G/8RU?3^[#@a6A10aD;R;ICfI[C-/@DKONcTP.:GM
\.3.-7W(\GZOY,VPcJR\bTZBB4N@>HU-#Ec122B.aUg\-K0XM_dCPc(b<J+KeBc)
:_4?6-;?eI2G#e38]d?+440+TIf&@]\,?VA^FI@b##S>M[ZAX>VZP#d(<JQIQ1GN
1:P3fH(bJAS[2Q1aYFGRLfFEX^9IA^7gFb@31d6L;9aUfY(>PM1TLM>PcX5bI1IR
>.0\716Kf7ff[SNACXfZ?Cg&A-b[I,.N(db\4QLF:bbK47GR+Q8P-D^Q[[4L+\6/
U[1X7BD62;U3X/FVDH^g5dEY\BcQ;[U0J&,^Sa1;3([TB5OJ6)KN>H.M@H+D62g+
.<KN]I>cRD+aDK>K47<X<T&FZW:DUQJQ9IQ;d7[=61CYSK,Z;=9JE[#S<8fg2^b)
SbQ#9^D:.U[QB^602Bg;]LY&P[MQc.=<cW_-0?E[3SNN@fB-<E#?DbQc2[NaZMfV
LA9W5^db7_Y##aX>(U,e7932Ae.W[/6_>:7C[#(]b/.KS6+&F5e?E(4W)7?f1c[I
^K).@4?1?I9>#fQYb>G]#+QJX&MT(;(R^WQe;#79QJ)Q@5C6SX_5e.R(5D_:+LR:
D7MbVgBc#4(/#\Waa+/9+VSBfbFb3)6ELH\U7B0Gfa,8#KCIBFF;.89+604a3d^6
\5T8]CN,W;;=_:(_:b0d]_.+Pg0HaM.OK[C5PZ26^WJ.G8\16(J51cSOWD&e9[D:
?7MSBC/W/L+DD4M3.QNaa:4,#;0V:#U1dQG\XN3/bIZM2111^bB32,C?#DXOPU+O
X](@)daa9L&HO>#\DV[VggQ+(.I&Z;8LOQCG6J38Nb6.e13bW3(_E4@>=?F)FdIL
9><8[7^6#SBONa0-eK:6RKPSIfae[+/5:KH=CC(4DHaS<?R)&^5MIG)bF^BRc20/
_>@H@M2C)^\P3a,D,RN?/FC/=XceDQE8aB.M<-d+Lec18[NS/MgZ&)<1&:Bd1]1T
49:-Y;+c]MKF=gO],f:Q#d+dHb=EOZ0#gd9IU_977Jc>KXd5-;@c7d7Hb?FVZZ2O
+&0Q0ebXW^^\+>^=M7F,T.cKf+F?[c8;8K89&G?:A1VB3[<.HJ)\_Z[_K\1?R:9?
8,78BA&5>NJ:56SH-QKWC3>M.)b4.+\;NdSgOV8c0TR6]5:_V]_^?M:a:8Q+9EQ@
44_b-/5H9V-[5(QIS-B;)7513#_&QgCS+;Z\;K(0,CI73Nf]c(8(#b,ANPJaJZ-4
a]&69OA\-#6>6,9.^/b,?;;=NIK?YZUa?G,8a81CXF0XY8McdYeE5K+CcA)L:YB^
d?^7Xc)Ze^L\GW5LK_C:&gK5c9;42W_9=ZBA&]\36VR9)V^AX]&Y4d_/cc)Wd+XD
P3g#U#=+\cN[.dWPFgE/DR]bFb[GX>c8JUNeNN4]9^?B&;6I)dNd7Y7H:&;dCg\A
KMda+8[&<8:89bQQ15XABe7MR5^XT>aRN92<f8>_A=DD9=8[78T..14a>S5#5N7_
O>Q1\4NLeZd>7U8@>FaH/2XaEdV)GUc8[&>4SGDD>0>^a:bP&CEME,#N_\PUcA1F
@5/8I1,0e8MLH[RE0J&8>Ycc3NI0\FIecS)B;1,)N0PLc[91BT4VEeEFSdf(d@,>
3Q=@C_XQP&73@.eV=c(\/b^@GCEQ56-P.c/_1YW,ggU[[2;OSg@,;ATGg?e6L_&^
acWXVC][>3<BOX^:VC6>^U^EOL_d73>dC&BGaa35eE,&D=)XA;XLUSN+0;9Q3-Bb
9c:)A/WHP2AF\W8,^J-f+1UXS\MdQ9\#F^2;d<9M+HOR#6GaXA[1#>R4>&Mfe5e,
K[a^ATGKDJ->3=+4#(cGYV/:KGTJ.R2(ZIR,_AEN^c:U.28I5VE]GU?B&VMQa)<^
<f;&9@a_d+\P,Q#2G.?>c?eP(b?P\<a^7ZGP2Gc[RL^9TKF:>A.aMVc+5J9D6LWR
O&&R4&C+3eH25B][^+C2:MC-(D-U1cIL\(bcE/?Ud/:2dGJ[Ngb];1UE-g-.GL[Z
O;7XKDI:#Qb_RC#d1[X?[1E,_#5FId_S[>Z(?=5LD+5+[BaVG43fZFZN8S&9\?7a
NSeGIfX2-K+@36+.E>ALUb#[AJTCKYI\9:>e9^<.@bX#\UQ2EgVOMONZ#7;1/VA,
6S5X[W5-W56X[HecAS]WZ5gA5B>EW&6c4g0d4_4)Lc,Kd/NF)UPD83bE15=\ILC(
&A(E99ZE@ED\I\aW#FKQ:.;F:Ad&K28FR7_ZJHAE.?DLE#ea\,B7YK)OP(KKOV/C
]72(QADNZIPBN>MD-P?WZGY^<=>FAP8#AD2M+)KPISe,g5c;MfV2_(>6eTB0I^cN
eU)3SdGdE5(b65)^BE\DgFdK@(JBCLJ8[/?McMDZ-UE:d@D^6=\=]K,I36/;He,f
SaP/NWS/0>e(<d7bEQ7/_.-X-O=I4a,ObbFWRKSHI;gR(ZTHMe)(L[6,G?cZRg\4
[9@TN[>S\fHBd:W+K?eP+O>?.P)+7;(/LC<Z2\FG;(HL@JYR8F/(KAaC?/:WJFG<
&3SB5#N7M.V&CU&9-?:d8DgCKM)H>-LacQfe#81?8:ea:3GPf[YS@(MM^U:VI)G9
<&_GYC?;_bPc27CA&ICCPN7]HZXRLAD]5+R3NO4W^-]F\1Z_2Q+IQ.:53R.]&C_?
NE&=P#,J_2QSAZ)MUY/5G>+M]AQfIQH8AHA-.^^MBe7eV4^Ig^ZFH7d@64Z,,;L&
P=f;M?8SeLS2P]I^Df=+&dTA,7Y]]V5.]L[a)R6Bb@A+L7c9NX(N+I1OZHW3+e=Q
AOCY\N;a90?Sb6)O^b6<bBJ[VAQ-,.I].EAH-V/Q[F\(eD,G,].1c>T9W=?(C6TL
_D/O<),L,W@ed2TdZK.K5c52VSdQV6N[Q0HMB:N=A)O[<(=Af#E]gUJ^gg-d#d;0
>PP)bLb?+Zc3[0bc9+MV>cgK0[^6;dI@VH)=IXSNL7H&8?#ba_PO9R4PIS09Q_W4
e7<]3X#-I4#[P-7<<R3UDM&CZ+D+d/cH1H78bcKc[&;&&34ANP(aE3]\F7L04IDN
FCT&O(P=:MDS)XU1+O>GR]9A3e4)2dY2/=+LS@((F8K:\XcIOcf@9F1^U4J/3c&V
L7,#[G^CB9KEX#IK53#M9ebHSfI+W^Xf;9I)6.BgDe(CdNBK(SJP;:>>M;HQg#7/
0afO)>aO4TB#;1H)YF@6-gAFIaLBJ\Z3((27KR#38B^GL0>\7K,Y]]/f,3CIaFUe
+P<5GbfI,:3#?g2V;b4>S3/H./@HE,^OL/IB[-PF;GG\&YN+WZDIRW-2E&JI.@C6
ReT=GfdA]\,O^9\0+/2W)U(4.P<bGB3UHZUGUb2;F/B[2=,6.S9dW(\]NUB4,_eW
MBQ)3Va)@R4,c;T6+:3fTeZ5-+H;;C.0_c1(\SY5Cc]UN_cS_4OS46MF8[9<P2#>
cNa^+?03\ULU/[]3\#ED5cV.8:MZ[&618)a&@FA:e-<MNSX2bI9(RN\La&E96\VD
RF85B7e2D+2I(N?S\?Qb7)BV+[W3N57.^@\\cKOXY^+&#J9Z#;5QI^GYZ]0K\PG1
e7AbMW]NHQGeH5K>T36a:)gXPWaM/E^e5JfQQTT7QWH90PDd,8+fU#<O-cKOf\aA
C9Q1SZb6(X@[M73X8V6]8L-^dB94Z&DLLP;E^C:5)@)d9>ND9KDW\9[H5011@/Y6
4]Xd9^&/KReGYC0Hdc6=P3K[7YgR&9>/Cf@\:UCWGOIXY<IVg8=&g5B7b-+Y6e:J
]FA@&JQDW4[b+/d/b[FOUVe?\Abe>Rc4M@a^Idg1QIe(cH4AVB9W@TaP&0RY5-HI
?98AWU<g]S6;YN0agO@P1//Cg.4YX(/L+9&2>]^AK/9HNdOf6=/0B5G>[Gd#6<U4
K:g&cA[994AW6Pc7@?,[U0#O(X9(P4ZBVCP(>AdVG?d030RdcNcf1eId9)_LY9J^
IaOE.&::-(4Q:f6)#<]^Q_XOcb^B10@AO]..Q2=@S2Mb=SM@R2f>g:3?,7e:>9X+
:]O@&R)\D<,g[/=bgQTK]T0C1KKcQVZ>:Z@I;^.g10(gF92]0S\E0\e-Q::101D@
.>)]9A,5MDZ2QFb#90ML2>-A#&/T;XC+7+b8/I6de2VGJ@KE(4@c3O^4M.Td;.CE
?4K=efD,6RdJBRJO]>+@8[/1D:W+c9Xc@0QFCGgIdg_2D>9@U1.@V^IdeQB)<RVG
V3eZKR2#9SC&.[cd3/]ZZX:G7/(>f=>NJ1DdGXBG^c<6/X65L,_TU)f@Y<?PRR#/
ZG>VA\P#B[e3c=bfOIZ][#Df4SF?]N::A5c2[[eM<UU\)bC39LdN+LAJ)NdbT5H\
N>PGR6Xg?3;]KIB]9SB/aZW\S.N2bc]]P_Td]Qb@LQ[]g@9S-MfO9@##BQHY,Z;e
d4Gf^aCPQ,W<3ZIJF7X(d5XLKP@2?b>H58;)8Laf(HPdRS.TeTXb9B##I$
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
M[/3X?SEH99e=;I8)>LA<V^Z=^J]);]Q)S^H->(NCe//8XW4?=QC=H]/9#.C)O]E
]3PME3AYTMWJcSHO;=.FHIFg3>b2D9Tb81:(L.&\:PNf5,4a1)<8.OO6g2)41<+G
dWLM_4&M<\K9B5(gJ]:^Q<2JRbV)+N_1\d\K[F+3BZ7YE;Lc8W)S_#2BI##D4-ec
@Z<49?W]X3HeYe8:LF=SA\?-F@#Q&(A=].:@d[,Ge;;9Q.MQ.IRS4QK12+N-F&N&
Vf^+VP_de)Y_@X]Eb>Hd)Ua4e._<g82YW)_:2cE\717@aMDc6MUX^2(=da?C(ZX(
G:T(RLHTELOdMIQeb?b\eY+>P_;Yc<J>ef,QIZbOVed(#O,?T4c\7J)c4+0L=@d6
G^&b86ZABb8&9@M.HMeGWAZBS,c;d3]I#+e5X8_QB<^D.RJ4JLH-]dM(O4X9M^bE
8Z=3eI8fKYTQbQVN8P&W#VDfWJNLB-0HJWTgGHgb5CZ7,1Y#PB_)QKD&Za8)+O^:
b,1V)0?M&4-XXK]YQRfL@4-@1ZNa?\:>O4@45;K8?0aLE:,1(J]D&0CdeUQTS=<g
OZ5)14Fb[.-bF@7PRcGVSd^0c21eL5aMXKdN.>,>Z^K&bf=S<>GfWW+Y/RJB?g,C
G@47&B?Y=O=:VNZd/-E#(PdU7:<MOD@J4RLT2J.[KN(J\),C>0eT/W_4d>c1-VFf
6NRfBf+MA0[L9<KaAK=@=RJE^?Sa9J[a4B=:--]222V9g&&I?c/9Q+XH]U;[(B4T
TMB9a;4\93>U/\_,C(Q:0:+g9G&VK.Z[B2];a9V:W-0Qf7HU@,#[.[W6X7A6;^]R
)3gV+C\=R+TAK>G0NCC9P]ULUO91LGQa^FVb1WJVfMSeQJHJU+/DK@7daXFf/DV<
W1J&],I<f2dgdX5CedP/0@bQQ]eY5eR8[JY^SE[9R&23dJBL:21O4Sd(Od>cN9^F
:2TY_KD\CHQ#>_F)8?HgQE)1I1<?\TG,aH>a\Z9baS#e4C-([@^4aBVHNMQ15?:?
]KJCSc<[E)\/M9CdED;TC=T4&;Q>fB8&aOC>8g(^^7&70OZfE##d\5e>(S:F>YLR
I;.V>F>d><RcF()&A33VbI.Z<aeE7)N5G6Fc3V=W5N7C]_SK-9(XgK);G?\QaJ34
R5;T.E^dHC,1c\+KM7CM5<1c^8g=11B8Pe9U)>/C&/=gJ>7X?>O?P2I2NcG2b[#d
NQ+G7T:O@[V#Kd0(]ECg#Ae)N9c#F&^P]/>&_^V)I]1H9,Y7c-Vd=FWJ-)\(fF\0
GfbHd:O_F:<Ff>4Ha,SB#EQ<g)MQ:?[NdPOGF9.W-F7I.#[4.427W0DBT9&_C7)a
]da\];g>TV7S8>/#Nf;>&2I^5;C>gMK9,/cRVL&6a;UH3[<S9R,B69F<M\=0H7BG
\JB+>KdJ4Te-:YH_>=.-:]-9gYVY9&5gRdF=B14b0437[B\/gT?DWBF/K3dF#\VT
<aRZWIOY7MD6(,,0-dL#:YB:#51)H8acK[^>YI24eCGKc:2-),U4N9_,)?Vg=Z;L
-<\CL<X00#af4ZDaB[I^f+-^75P++XE,2W&^87KNA/Yb/<gN&[/.858a?VCK,I_.
N/9Od-MfF_5@5&F1JJ93A-7X6+bf]\SWIdPR.F,(MGJ=]9H_.[H#<U:IOf2)#\-c
5#??RdUf/27<<J0b]B\T;=/Z#_4<\#OWGW1W8+dK<_gdc?dMBfffN2B(8UL5-+ZI
d&3dA?VJ,T?;/&EY>]FR.27><@X8(&+W=L-D2=FN#aaS\;LL3#.X:R:L#gB0b)H:
MW[CL.cQGbFI7L(4]G5MgU+-/gU]7dJ4MgM5B/(M^d1Q=11RER<QG&dYTNNe;,/G
_P6F&K588gB[?;KDS\de+/UgB?KdQNRG/2S<:aS<^.E-\T0(9c()d?PW(755)91D
=T5dBEZAXL;XXQ2bX:Rf2??DR-;E.2;FLZ;LO#HK2(VL_4?1O6Teg12c(D=d6]?4
fS4QBXS0RQH8H#^LOH[d24^aH)7OeU-OUPB?4W67S/.C01b+TbCTHDL8Y912&Zd&
/3X,Ogf.fW_R)F].MTFRYV-(@UP+KgQN.=3:Yg2L92?2.;,\Y13B3OTcX-Z8M013
\<93[OK8Xa[RbS\G_dAUVa+WBQO,+LGWAZ=Rc<0XD?KYN(\3)P/L1,Wg^IafZJW1
XaK<K4S7#ET7Bc-YID]4&50S9:]E9)T0_DBQ8((#NJ3L#>+BfJaU4@1L<5GZ&DcZ
DbVQ^:JgJ:P_GNFP&G/S7FQK-ReFPd@]#V-@9:RHbgMUIJUZb+G<.1AA:IeZV4R_
EYHG&X]aLc5\:IW77UT-T98@4;6SI_0X81&T66MK2G.JNCc/b@-4[N2RQ1U^;IBS
0E+1AU)?EO#PGgV2F=RI\\IAALS@\GAE-OM)bc_f<9U5dRb3e0R00;eddH#.Q;X;
X,3^H00)ZG?V4HC8c^dICUY_^\4</=<T;4)DfHT&Za,SD_G0<&)\U@_ZUKFB5C&c
>eYB)9GK@]8#?Lcf7.FNgMBE2dD-/R5dS+(d1V<_Jaf?@(\DEO\<CGTEI0J-WHGK
aPPSR5b)S&ebge4=1;aJJT?HI_9/HATd95EC?Ka>d/SA^@V;;;,UN:>G7^Mc4:aR
^,=)NV@fO\Qab6JLVDH;E/U0_;9eRLOD&CTOXgEDUE[KAUW;-F^&6a6#D+HAV2.=
Wd?;bBXHa\]279=](SF]L;;;-\@DbT69FP=O[3S.8ECF>Yg_?ed7KRWQ[9#,WAE?
C87UVEXQ>f@?MdX6aW]:cS_2?RT3OfcFN<>g-,:-_+HT]bLaLc)MJ,MZ)#>e^JC^
2_^B@+[VT(NII5A.5,SKJOL0D@PU\U3EX@3NE9=0WQY#F;cAZUd6e_MeZNL95S(N
D\K/3/,E:1#\5=D9]bV7@^feV;RNAI8UYMA+[[&_+G-=bK-(c<UO7cAH_,/WUJH>
/e;(94&E+WQCY337:4f+)Y[^9BVAI4A7+.\#,EZX)/_Q>G^GEJ[CKYV#8a7/W4)L
FNIW;MMI+@V0SN\@EgG8TgSf4[>G(NgM:\8b@A:8;@c5a\Y2&ZV\\M?RH_0.:O3F
0&KN#Bg:HGYa154W:#82:gcB+<ZX2HL<+DNdNLRREI1(3U\fJMTb,V?RP$
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
WHX>e^)2#M>E=KJf:GJ(8]<g8-7](dbA<:5-8NI_48a0.7\-H&C48VMK)LOf8A.0
7:8)&I>4Of@MATWIXJ6(L5V36#:J>QFE:)(TT[?JY)EBZ&I.3Sa(8LGaHV.N;AT;
#D6@K)JH9SgAfR(31SeHZOf\<AEYdYRF,&AdeLgBe3b:BV0+bSNAaa/M^)/7K?V-
=:<0=M?]0EXNZg:g-[fM8IT2C=K=LDZ-PQ;F)-YScG6?EG<F\IJV:6EA_K[R._[G
3(.F4A<P7B@[8J,=?_D8;O]-=T[>_VL>=Y8F>U^,F:YJ#U?]:D_DO(RE^)YI<Jd8
ZSX>M7L7KC<@4fZ>Mbf9:Fe/&\NU<TNSfYOLa=ZK0?G.95Nc]KJ/,.f?(1TU3d-W
NddZS4IcCG=^SS1@2OA44;NgQG:LaLFbeO<+1ZNU8ES:V?IC3U_J8JF>WE8C7X#8
ff?JT:[+UIUMW\;;?;8/(,L8gJ<c]0)1aJFDX06eMg1OF+<.?;C2ET:?L_cB75a+
\;ed_-D[U^c4HgNA4KU^Ba#,=/O7,93GO--IN/74V?2Ab?IOfc?,Yc60RGV<#gJR
T;MQ-#?JGf;eg9L)2]&QAe4W_DNPU_LEb896L0dg);eL\(Y24/H9=73TG_\_H@g5
eD)AaH1#J<2].+)W95YF?4:cU;-]TFPCS<F8YM99UIK[ZRPObL7O2#9]agS?cRXS
@VbN).@:[Y2M@G8CM?@WaK;.X4_1)1:PYI/5Y\bHAZ1-]3eECT7a?;@R/SL[[1d>
@W,S6.9C.1J\+eCGQMARQc2N9c&D-;)HK9LRN4:dD7QMPR62aGCI\Z+KS>dI(ELb
Z(3V.cD(L8L^PP8=?Q]Bb\=8E=CNH?W-&=LS)OeU=8V_BIRVc)[S,R^R0Zc)(6WP
;?.b1;,#]eJaFbGZ&PFJ_0RVeGF2\^&cHH]6[L[SW3f:JF(Y[VY^#DM<F,ZbESN,
b3]DHe\=XMR;e>90J/PH-PQ&NJYCQ0DBcGYg@HQ^aFZ^1KM@C\S\4V:+5SUNN00G
+_2.eUd:gCJeZ/)#e=c<[Z8AMH\M<VT8,Ce6FR)/U?YHNF]>PZ]09]Uf=?B_](K?
g&;B:4HF?.<XdU]YK=c2@-bHP#1eF;Q]F@N>+?RO#PM,P.78ZUgFGf/AJ2SP(3)Y
Y)9]GC1.2W6Z2I._PR+V#_D8dB#WC7GJ9K-K3#HOB5Z5CE3F4U<K,C^c&2SWac1Z
?&f-SQ^\-RSf=/?-GAc;N97SO2=J.>2W\De&Rgf@I?S,-bDE^e<_D=G.+-)7OIUJ
CPc-UGWa,#?J,;@J[P,U=W_b_&?H3XQHS\/B1LUI53K_.HRLU\0aH\BR^N:aH?EA
QPT\JMYP)b+R=#TOS\LQBa9fP@V3bMXAV)PFXL2Hd&#[eG?J6Y<a=A1QV0:/H3(H
<ZZK@TKIcg>c5A.1Z/@&g]GDT22W2_ff#U.=AAL[VZO_d<S^=XE4)IBRL8\bd^WW
):)c@]R=E_B:F1:TAYZc3L=P57/6[2)L@19YTg4&YSKYB78ALAC[5bW,TKW/:9B0
\HX4BY6EgUeD=I_55U^MgS?LL6Tc-T;OU.C/]a5Zag4H=6OZf#6<3;_2_9-dd9N,
=X/&.OPW0WMK_d;7G),0TJ>9U6AcL2+\NK_[K(NC-2f9BAL^Y;.e4^AF()F&3@2]
-5ZF9/f_gJ^NH3^ZA=cga@QYHOM9=0/37:>X2[:9QREM,a7)G?fBF;8,M0H;eZa5
L=-C<]4d0)VS@)7TJ\9d/RZ[XBKE4bMg7X@]K]NCMaUe4d>4Q[NZKEC1I/:+Vc(8
bH7_]OdAY=-Y@:c1-Z.OOYY239OLKX2P,^dX4bND34Mb[&\eED,e2E<PKLf+NF>;
g.K#/@YG6H=D?=X?e,CTbgEH:FQA8R1CY(6)TOP)?Y,9&aZ3]56+.<d<EO4^\V:H
3I\EeeF_Z#N.E/;X\9BY0E[BObZaEVI2O0_,]<#R#>AT/=NR\E5b5)M\,)ff#C^5
D4J\X\Ed7XHeW=O8[b[;O\gS=O4dB2_8AdVH@\_9He((d93#Y_\[Z,A)S]D;A4:N
2]4)XB54T]daY1;&PHY((1C7F,H-@V0#6=;+_@=GSc&SRJ(;.W5#@1.B6(dOCZTG
[S^?G8W\X<;6bW<,a,9aPVWg5W0;a;Ra,Z\;S\Lc->,N51@@9^H-TM09SC)&81CQ
<e58b16&6fA?.SC3-.2@X;ge;]83T@5^O]5E4c+LQ[cB78O[\=8KU,2&;M2+FS:E
Z9K0/<#[Fg)-cLKMND>d9@LMYU_7W6a]ON0.ZMZFJC04S3+a#_J(=BKP.H#\ASb2
0/RI)O-#Ga9?.I6J\4S3]_P+f0ZeDgD]]Q&<SDXcC,HdffH)GN4]2I,#U-G@W,M6
cR/:AcHU4L9^BgOI5E5QW^,H@-H(f;NINJU+eS-g6O2]O^NN5ZGHT8@CQ+#X[F0B
&.^;I1F/9J-MK0_48HMBXZVDI=R)I:KQUDJ?HY](E^fKb,^^c,,([GP/^]Gf&_^L
XXX=H9<KaYK4#Ud@@#._+I-)E;YE,3H\9EX\:CaRDZ3]_f1\cL28Y9\(S</L/9_8
V_YVQ9J)6WdbPZa#OcGa)1SW]B.S[#&@A\22UY2<d@SG=SYC\U>9B#f)M?/^25:g
8:4>N?/+dfX]D>7f#b&,H_Nc_=\c+B4;3=N)^4a-Pbg<R75R20fQf<A.GF:&LT,=
H_eQDN@J6aGBcDabB2Xgf)2-ac;[cW?[9P(C8PJ>8ZJT)RReZ^Z@Q_eM6G/)Wc??
+]60+FQVX:XdLdSe(KH^GFR4SKc)E]G)RcDMN(WNR/,gSU-4:5f:LGN=d2N-,A9U
g,^>XFY_R:2Y+C#K:17Z-Xf.&IF9;OH_a+gYH846eGA2>FL-E@MXM6I\DEL+a+?<
1g)WGCXQ77Y/:PXX(BV>XQIJ]K8P.g1/PNT_CFM8e.aGSD+3W\O]7F&(8HGTE=UG
Xc4SG,05W@KH[FP8</d0P.)6+?<)#0E?Q^[PYNE9X++-5cI?B3bG&=BQ^dLWcU&2
7GC@UHZD8529ebF<JK;J>fJDT@8B+,[CM[C<^Z-f)TB2a@-^YKVFKaYZH-:4<X^d
:)9?f<5F>fUYacIC-c3e4Qf]7Nd-^7)Cf=dQ5)Z0DS@?Ab:^/&Fc?O]d3I^egVSe
Jd[#GMIa2=#:/EeRHNC1A\OSWWAHed/T[42O046)QB(AfE/gH]1-\0S-+BSEd9I]
A._+,@T7EHe;PMI-\[X&3UKVN3H9cL/4[5PVO6&MH#B)P^(>K7RRbB(.eI;FRRZe
[032])J<_1We^^7)&IVa)Hdb,50F1DS8EWM+<g?e>IS(eR?@L9@9-9d&Ff>X;FZI
Ge?>^P#Q[SYYGDe>T]+K[8Jf3];<3_^\f&YQ?C=5;Qd9[bT,1A@S=FGJ_)ST/LO,
FaXQ&g^/^?,5.a5TY)&?=f@1bL0+^e@?dV2a:.@_;<-AU]c,Q?0Z_^7B@<C2P[R)
c<fg^NXOZT6]@LBL(5ZT)3\L6=0>dZIF9g=9@,f]HR;,cN=4Q0^^1;3RfFg<D&SJ
;(TOJ?1INK+HIBD>REE+7U[YRV+W\&GC<DHOc<_LU@(G2<W17RI0EgF2dd(feS4.
U[5B=5KXQ+H6DdLND4JSNEXf5Y54U6?I<C>@O+bdM+?&2A8T<;AF.DTOQ0#g[^13
)8dKMa\b_7J4&fYENU/_BF1MZ(ZaaWgOCO1RIB;Icg(9(I4OgOJO]bR:KR-?9VE8
SK;<:LXA@#gNK2PYW(@^f7F?C(:G6GSOb8bcQ?Pe@4MHO+IYLadK=TfB5#HW4C;T
J>J>b\,4Z;B1U:0X^2\6f32>5K7^a1:3QC]QA\\(^0(5(gRHG_NdUAA5;H]1C:fe
NQf-4bfCb7Ud7LC[)_)8>@&/F@])g=U^9b2[BKWcKTaWV+<0G<H&_QgIdYA463Df
Qb?_2K&)OaE8f34de3(GX&&S;M4&(Ke0]LTP1CQ)VVg<OAD\8Y5DfQUDM,Rb<(-Z
,Y\N<L[&G?U:6:,Xfe>(R#deFaA;ZDL<C57P\ELBgNZ]<Ja=/\6fXL^_[Y@)7QX/
;Pf>-/E(<X,]2[XY1cQ>TJ0SBJQ7,:7B>G+B-6?J5b:0Pf,XM6E,^HT_/:P+J#[K
aKR.487-CYGYg)Nb/ROAfOY=d^)aN@Q+1P[@:231R#5Q4W2&1L1d-Vg72IdQDO<9
;B#fbLE]]g(Yd6@HP[/HZCM782[KTTM9TX>fHJNHVeT^IS80@E7Re6gZ?Jdd55SF
>]be#9>68:H&OeWO>b0(V,COU<X1VW-Fg)-U^LC5VZd/b=CfM3H8b+U759g2g;@^
Wg/b_X:94,V<I1OEI4)&ALDL533fPB)5R+(H-^((=6UdJFfJJWA=G_M-.MRI(ASH
b\=dS,gf]<3>c]cKVN-G0BN/KEYHJH3(<@c,_>2W].dQTQDONELgb^<1Kf[GZB;V
.E<M_\3W/D5[ObSWNM;ZR5=<7[<R#)#2CfAX_71_5VO(<V.FYC0+>:IN@16^gD:V
<#S]F+O\HQ--587+Z7]cfN1:8853LT<ZZ@(1;8,]COE7J7:FA8^5]+V4C^B1gc(b
G\Q@G=U2^)Q&QU.9)5=Q,S4#UHdgN^Yc1ggXeX=JQ3Qd0Y2NXG-\SgI&#+EJI:6C
-,U6RR16;\&3M4;VKeAb@@VfQKc&Teg/R.\:4@[K)7)gG-^QHf(=;=8Ged(NTRWS
183a:-f1b,\@6HS[9W^@?+&5L)T6OE,#<LT7.L1K2(gcX.?Y4D&c8)UK-e[??Sgf
Ma8/VO((#:.f?5Y+-Zfb>C=@dbAG/JLG7W6c4;5gEY20=?^M-d30[.6K8YbU3]81
5NZd+Q:;8?4;Q1LFZ,ed-YW<dGD.]COGTJ,3,AINV?A/f&27,U/AG\9ga:S@L5[g
\Z7[S/70Y<Vc85G72b(;T(3/YS(3SX,A[GU6/A1Y2Z/V#8;B?Ya)X^[(YJ0gRB2)
R)AadV)_]Nf^,g,2Q^D,6<gS+CVgMAc&/HX84YQA(_;f1P5N<2Q+HT\^-D9,-V\5
)<1^YHDU;.\/9FYG1ceHISM2bUMBXPCg/ddFc.b&^2e6Cb81HUK8=;M.[I)XA:?=
6#O@/&=-VL6S(eNH^_.eCPC37@S?9<_;.&/QAE\CGZXFLA8GfS,5FPR6IM[de84Q
A/+-K;B/M11RTW^ANVDMe-7g5PYbXGC4MYb#3W@7HJ&C&^-1(2/.GCZ-IPO5Dcc0
3XS:0\GRMF^0;QcGU^H)WRF?TP4/>QH/FIH@1)-/W12[A/@S&DS(OB3fFIS\K1G[
-cZ36&DMFX7XMQ0CS]D@#\OHagZK+>E^(S,)[6E)F[b30#?7,)]Y8>)21?+PW,gA
Z>6gG?S^QbQP(W)bXP9\Jce7Ng,#1/]SHG\P(]g@^/)b0>)HZ=GX0Bb9XAeTV]]E
fA&M:83Bg3gP>SDJ6X7^2.M;3\N.=SdF&\Eb:+KVA_A]?dF8<Z7M=dK&[\]:^[cW
F:<P(gPWD]PX5fMb4SO2f1,6T_UVQBC]S?gQ)#IQ]-K3_GT]T=XE_ME[OZf2#KHA
WT+XWaH<9/:94PXNNMYT-#S8^RT/ZCVXNUKDgG(1W[,Z/+E],PLH?b(/0&=DCG2Q
dLZ7@aOR:+9UFN.P?7#L3.XY-#(3/>JMR@4WUSV<<^6NHQG4#5+SZMNf&Vd)KU&F
GFUGD##eY0CE2W\)c7eYI_YQgN5^P=G3LV@6eRKZ>V]Ac3]=W6]JV_64RDd@:COL
3?Ng0GQ^(7U;:F2g,fc/61E>bU[YZ^ZP@J]@^=[C+M:N25EA(DVR_,IZ?DC?>NHL
OL_ITa/8:/g-3Tb,)TG#TCHXS..?EegOP35ZS]?9>gUT^ZATXY,OG^5&V1FCB[[=
>4=YKd+-cK]\bA_Z/4BB@-(2>Ob^R(eU&5aVg9d]Wg\dR-FXeQ_:66GS&8fZQeWP
7bI<a?gB_CPc>2bLQ<,L.A^2DM<^K)7>+ISNQfDH4G_Oa0<IQ#JaeK;(gHO>^.&A
5WDWV+Y)+[B_e9BQL6DU;dCKcK?FcE\ELRa-Hg3FTHeQX?EMMbZM[^K(@ZJ5dGQB
R2gL:M/:P3]f\FRT(H6bgOBX,f.=VA83.]MJc\Wc@aFb43DW6Q;#f5cB#a^d7Z=T
(LF8/F78<BAdRHF.9-JG7)3?BD4GPN/aK#-W)SKE/]J4GG#a_IFZAcJK.H[?4[V[
&J5eTZ8S\N)&Z19XBM9R@J4>O9>g[&BAL9Vc<B:U)_e.Q^7,WIG_,]H.V(E9X4P+
-LV2]0=cOV&KWLT)df0[L)1=)VO73;I7(3T+(H^ED&LOG@KC1b;L05?KW5SCe>#b
Q)/d\C1<3ODACW]9U4^V8TZ5CFPgT8Q-S))=@W4=X8^+F(8E#F&,<GI3RX<Ld0T9
JJY(YF_\4D6MQ4_Xc3Cb\J9/&3\gO))T8DGbQ.2/C)SALc<_9=N496KSV>c.KY,0
&DI>3g9C:(0Y;beETFZ7d\a>^2O/KK(8aC7I?CeM83.#YOHR20.AI_1\L[,.\]87
SPKcX&b0<aDeJ/XAJ-Q9F91713[/@g:b.<F#===KR&:e3X.U9?=H=:G,Ob\3D)&b
0@Nd[,XZ5Q&GTQA,V1?:?UdP=a^Xe,-(,P;PF85:a:+TDZLEeBKADK0DHbL&eZ3(Q$
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
LJR?:W5.HeAZ8/7>,9g>9@T<9d5/)DL7=><;<OD<G&eB)SOSca>A,QF79SBe8O)d
[26?)<c(:AZ.,39G52Keg:1\/E/[c5HB.47DS2C<4J6#4G[#28-//KY@.7LPKK/B
e:23V(T+C]&cPI2]9T.7K9a/HT65Q8CGAPEf;.O[AO-1,H,<F]RGL.5JJdgY265f
W/8.H2REJ989Q3-1^2DD3S[.6.e_O=L2]3G/UZEJD]LBD[-K?Y2)Cba,UaDbC2.W
2OV?eH][Kd<X)aIKae65g<ZHEaM\8XX?7MG6CQ&<_@@+3eL#AB:3N2\/Sb9R8RYF
E3Q=fQF]baEgGMYc:aCU#P^=PLe:UT./7;3#Ua(,MD(SGDEJ(fP>R=,:FCIN36@(
@UT:@N_U7d@-a92E00S1VJ&V[U&(,A]<AQP<I&[YM+e=NRGKL2.R@AI2<3NBN,e3
^[#=Z=:(7S[a3A;S11NMP\T<?e?>K,I?MCK#=fdGL+Nda6Y9V_#4.gI/[#9\0PYE
2WXENX-<E_gO4f6H#d74B8Q@UWOWAcaY=g;.::V]f\4+T1_B/>M+1E1M,6-U:;b(
\O45UTg?S^Z&ReU-E?A99;6I0P2/CPR]=#fPR#WERBSD)5/#;T_C4M\^C>UT]ZI0
,U]B3C#6SZdTX+FR5\1f,V?1e0+,15S.4S75RT41@Ag2&36OBd7;(ZH_aZJ,J;]Z
f1fC.2WFDRD1^<VV238B9;[_R+V3Ag6#E<>)Y4/:[+[:/@UA.B;4O.[Qa8QTP5fc
@W[b-/e.=g0-Tc0(33e&5[b.R8UX&DRA1H^4dAT\KKF8TXMD;TJ,KN39HR2Q^NYM
:R_-9EfKM#e1a<W\>=T78Y?13:A;G9XQ#g^AC+f9UOF/<3TbH(_I2J0RAEN)9C[7
[Be7R^G\8^B2[JG0PbQ-+#[IA1D\R?/>D)5#().3G^MEBfJ@dI?BgIT7J=M:-Z^S
0=FTJ+PD,M-KF_=]2.>PZf5\(.]PRFeD92\+</QUBK,-1Ufd7dX\b04bQc?FO-fA
a<GPPZO#,;5AW&]/aAd>TPc=b1MD22G?K#QMb06(cHKB,L?,E;KK[[C71-=2^;-#
X:bGOTH?TA9/WKe4@V__2T<RE(I?V,K.>G(ZW9UgK,FH/XLQ=\FDQPC1@0fb;>Q3
L6:g0_0U2dTHNG2UM5X00&S2WI54;Xga66>JZg)V<PXZ@aOa:UUGdH5H[QFZQLd>
(JU,<;/VU7SUf(13M5>9>Mb(E[g,5g(1IJ58cQ8P,W2XRgW_\bSe7G_^B=]C5UO\
#:962K_CO;NNNF8UMe)6_BF_W2?RMQdF22f]S+3[UR?YbSWQcg7AF72CL4&UT)XG
R4((HHEa=7>;]OZO58N/_J_fHS9e,<2D/B^5@4dIAK=3PQ._b1cG9)A,?f)3g4?_
aY_1R7F,dM_AeG6QG_aHXb+\(8g#8=6>WGAES&:,Y#W-C+<c^Df+7[NQM3TG7.H;
OcZ[1<J\9(:>]Q]Y(7IWS]M0Z;cO>FE.#Ee1=0G&(/eaN0WFE+^NTEXf7,+?1P8a
ZO/>Z(Ld:AZeABa:fVd6,:MQ1==e[H_bX3A\\U^A8ULbVfA3^87SG-(ZF]QTYK&:
<a#IR]/Tfcf#cVKdQ\c=Bf(\d7a4ad,WLF]W&-FKV8&D&3G::aVUaNDCA/SX2L6<
FC&<WRb9I.JeOf7Mcd[V]>JAS53]cB>TGb,;[35YD3I<OH4,b_#7KTN[O]W)NWdH
d..G47_B2MC>IDCEHI7M:8^W)9ON3&SI3Q[f/1=#V;N8c\@d&RM0Ydc,cE#[3U3g
?B,Z_5^&FZ3,).[@cNa^]V>[GHVF8Q.,aDK7#HL)-S8.=I2f#2X<F>37J.HD528#
Z[cOK-D\NK=)A>WR:/H>]??+DJSA-4OKbba0EBJZ/3(U@.7X]Q3b.[;.OdB[/3\8
QeF\AETW)OV4,:DZ9d,=dEOR=TM[:A_I+F(.#IAX28<7D.(^2GZQPS:(Q7=]NZ25
_KQZ-g?8fQ?V8\\;_0@OYgVNQF/?fYCD6&AbCUE(,a.+3dXE6D+]aO)P3>9OH^6g
e,P&V=f8^R,FGBg/P]d7XXUG\8QSfDf6JW4\O<?#\c38JR#6C,51DNO=KA8QC9cY
8BAW3M7RC]&LVHGKFQH9Y9O@//fW#J/+3c7,g99g[;H^c,<Z#=9@J4EDZ\R\)L,S
ZaX9(_7IFeXR:CEZ:-C/G1BE#0LNAS/6:SJGD\]O;QA?4US18N/@<\H4f=3@g3dK
F1\-]R#=F:e4H)bBJ[RTQ3WV\U0]^A&3PQd:3bHZd;\\0FI^bG8eHZGWJ,;G\(b9
_fG>IJ(85/5dgP5JCdXe>8eI)a+,b=W4_+8L\^FCUCQ;-LfP>1^F:++7^WPET.Ab
E\ReR&><5E@<NZCD]<N:g:I>IO0F6TY=4\egO;W1M9VXf1)K87IV7aAJLRKA?_&I
=Z14>,+SfE+6V5VGC#3\,Y5=?GQA]RCgF_VA2O[YYW7;_HP.SPM:PdQ?ZW,#W<YU
BaC4D&6YMKLZ+EFa&H=ef<?JH5-LTFS\Y6^#P1;f^L0NJ(52@JIe^a_<[JLD:1Ea
#0B.[3+(=+bEQ:1:d8d)1->\>(DDX4Vec1RQgW=5fbBN,e-e69HRPH;OQL<GYbeH
gH67@=c\8&]f(Ue9^F),<[J__1#/P4PA/:T9\a,DA[VU/,=fdRW?gS:1O49[[<b@
XV@5:O<_)M=B0Kf]XWHfN/)^DM(>M3c3AdM?/TE12Z;5)H2&Q^aJ3<3HA-BAY1+[
ea-G-CS88-L/@T3GE32c.+-b6ba]N>>,Rb2QMaE]gHG;#MEa^9<U;c+/R9>+a)3I
6J0QI>8[M/=<aD7eY>],YD#>73d,SEVZ=7.5K#[B8MXFA81O2Z]DF_]/<7c4&,U_
5TdG6IA>GXBZ>OcCT1OTA#GW2DH]2RH+<:43[[))I&YFQ9.]SXH9eC<b32F90eDJ
@K1XP#\LGJ66WDQUd]Q0JadN)c<gQCHGJD;0^ZN..=cg[N/f;=P:(2?FQef,Z=;T
ga3WPS3d6Bb:C]RS4+&<Fe9D&8/]]&AP:\eaB)a)ef;bHJUX@:/&=T#SbY-eO^4+
FX+5Wg=-,FHeXeVS8cGc&1/>A24QL\=0cPAdbKeeZW4)ELX#PdGc,QH;@f8WQHe<
196J9;NL(VAS2F_RNaFB1f]WU-AEYB7Z5ILZE5R3)+bW\(JVQR+43?G[Z<bA(&e)
M@N)QGB_)fMbBFSOY^[L(I0R7I>1)8XceAdVWcAXO<L/R6#/dLTB[HUeDbDdOZaK
@5;6d&>LE,Bb7J:KOP\4&7L7=/c(\JTbc2W6<A[\O<1:Z-Z;.4]7Y<PA)HEeUWc=
TQEH5[c@X1@T?]@f81B&:X,5=,N^#5_D[&bbM55J>POYPYUJ2P#^9XPAL$
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
C(H+L=-4DM[Z=:SV9HB\=6,D9g#G8]XK,4g_<8O;7=#6[8K;A(Q<)QLZ,W2I<TOU
c2I;Ud:S-2JD.-I/^ZPKX,V]e3F-Wg_G\7g-+a0PF.=YSYB7.fZQ2M]7]@7?O(6;
M(@N1W&d-8)(=@8Bb]]1A3dG4d7cO[/5eC#OO-Y_]^R&6:eN=U^A:\0)f.1Y7LHG
(AIN9O5,E7J@O,==^PgdJ3-.-cfPA9;DLHF8[U:c13<&U_C<J)CE&Yd=f=S[\XWb
Z5C&>[#bV-9HQ;RGWNK3f@;HB-<2\)5AVb3>QY3ZA/.02R2OK+e=]>B?,BZbMHR.
V;.S=#L7Gg5U::&b;I5W<b<HJ,1+._#^,G45C7cgKIEEdUX6)3+KBXB^5?c9TMc^
=<-4HZ.BL#N:>L]gMWd.R3(-,7MMfbc+:8=.0;(O:C+<(J7YER?5QVMYa(69?fE@
_QS>^.U3,)?63>C3WB)a(G7c+)LCALd#=,<&-05R8;B<W1TX@P[e.<K])7;T3S&g
+&=d;(eI[LS=O#EM,3E82d?A6R/T39I[/B@-b]Fd^Q_),0;-g/:Gg8UB3+)cG,HC
Lb@P<,>A_c(I<-Q^N;]J7_+=(Ef\/9I:-8W=Ha5Te5[b5]WD@a<KYA7D+CWA2:0f
B.9Y3W:MB9aS3GB0N6:.-7BM7(I]\Vd>.<MDW^Q(aD=?GCBc4MHRJ0[bXD&8G=6V
Tbf>d1dCB?##SUCO;OA[<g7U_0E:QPT&R;4C99^M9_?&#3P^5/eG.ZSC3>9\c34R
>KAOI@6(UYW2QM]^E5F\=W<7O49)HJZ3J]?\d/4PJR#B7b)^3IPI?U0);1DC5(,A
.F^3(GXX(WC860T1?JV\g-b3^Y&OPeU.PgY\,^[^Q]49#NC5F#LQ[7O/)MWB)3HT
1UeP2@>5?;/8+U/eA.8)]7[G48:<&e4ZWT^aa8U]>Paa.8Qg\GH(/:+gVTIM^17+
<)1V)]A0b-P:D2&QN:GXX5/+NQ#ZLEV0U4,+[NfVV+F#^ae4=^9/_Y0/a=)>2+&+
_QT4;Z&SD61Pg@X5J5BZW9gYT4bOW[PU6YH8TB5f/E4WPZ#(]33<VY=X>D&3=JY8
EC,fU[[J2URUD0YE\))d4/cE]a??74(/X[O/5-K2/B5b-5X>(C/,JEb=c,f)\aIb
]T&5SgQK3#4]I=?+)9>aRDHHeBF^I?>O4V6WW\LQ0[:7LRg\/#:]5g4I8N&\+3-J
,//W&/0XN2O+@2&e-e7LA6LY>Ea@[:13b+4CSWeDB.7K;AA_M3<_+F0)=)K<;)/Q
HD(:ZDW\VQ1G)f&F[I2JFYE@?fG/;>N#QbZV^(34PDMCA9a3QdBg1L[]HE5H3D7^
[g(+=HY1@M5[0.K/eGES9cY,GLd&fSC.a0>&V6->071L/C)2HD;A3?O<WbfMEM\e
V,;:fK?8H>0YVD>]P]3d)LK:_1/B+DF3,]4=JRWfOeUKf8I==[a=R85RVd?OXHd[
7I^>5/KDOb\5d7@DcE#Y6SH]c@Pf5=f2=)4D[13.U0&U<HdW+M1NMJNGb9SZgU8D
/GeD2OA,NAIJ:f\[;g<T)Kf8CVZ;=B2:cf(Q]E#Z\:6&R@VQUB(.?E-G>9:W3WLb
7dA6F:Y@M8&#HB<7+<AI[FDM=O(Q8P&1DTFMCfdA@aD<CS\=QL9Ne68_.>@QW=3c
;_fWf@7WeJV?3)Da2NA0Yg&E,PC26UZFCIOE(&f8A/3=XL>_QXa\#)+?PNBWLN=M
N93\Y7:SFX8,ZHUPWP8Y#N-;_P[=/&bAfY(6F[J=W1_[#D&(+;.gS<Ca70;5BFV9
7-3+)]N/TI9d&W;#_Uc>/H(>&FeQf3DF#9.11):QZ:8GKS<N[]5K:+2VE9=-7MG(
PI88T\3Z/CdgPV0/TO^#LX:WQKaI5M&.a)UbHPC4(:a,=c^cC1A\aTW<f&,D_cP@
N]W]CEcZ5)OU4E>?WIUeHYbc+?KHL;B?1Db[12c_]]/RC1:R]IY2-&+9297ce9#-
3]0_+_62I0DBSEga2&,KaTY]@,HL&/DA(((A;&>,1@U5@:^,,6B]2R=UWUf+d)R5
0+7\:+#I\JHVZc6<2Z9/a.D0/&N0QJ_H.O66?0Hd>6g@_U@c]d3=O;OJVcK\XV\,
93)Cf-\-a@N66K1XFZE>U^e.,Lc&<#V:6++/,]G-W:CUMEDQP8H^O6,ge2&WJ@Q6
/>Q5cgK@9Je0+]73:\R6/Y18eg-AL7W6^1/9[8cY5DeV886ITL5c=N[.PZ<g4Q?]
27^LZD9&<Y0Od1KcT8+-1GT[&7+a8I34e:6R<3[\RfD[3IaY[6[QJ(@NZ#Y9/0].
fBRe3Q9K;^U-J)ZdGK1U@2JA6W;=\>>EXEUSg55c&/1UFadVfUO);32;CNM@-Ld)
NF9DLefZ5[Cf+7M9L1+9GEgBfe3+AEK+VFN8SGZETDKI0&^09@2@U?EYfbM7G5F(
D-&C@[4,L4O4WOYL.O^^W9EHPQ6<Zee>)dP-6(#MB7dbK_dI;HNP@[,BQ,QYdB5)
KBI)fCU97NT9PC=f_]V;@74IA6D,:[K^-3\?,;<DZR<bC$
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
&6.<[WGJYFFG=SH\<#JM()&2=]g(87N@(,-\=KH/F[S3<NcQ8&#X<INK(GD19X5L
G_Z8@Z0eO5D?Q5NF\8MP0O^a+^R&MS.)U4GRaV<bQcB))d.W]W@KJ4INR3U3.U+.
W@0RAP;B>Kf#I^@/D5C&e8_TBVT\4EG.A4K9],VS##>W^WX9.G@YG>KHK<DL2a1E
WK]7[WWG8MF+DQDN6KMTf98)f3R1MaT;e)&RH1UDL93Q6@4N)3U;RZ]J3Y(05f[8
?eK@V+Ib8CLO1aW_^:PFZRHGc;Aa/G90-JfeHL@IUg0;)>QU[b635Z,_@(<IW.>O
MJ+^63WH[1MK+Ze-<EVe-8EF8-[(0CMAgEgb6eYKVU<2:A-6YP0VdMXE.49[aDSI
?+D^2KP5C_V2E:LDBf@MfR\8LDTgRMFc>F35;VGP7M&[8gBY;YCT4Nd]JU^2Ye3S
@+-QTA:7#3O.B9bPM9?dd6c;0>Y7-EeeO0+:;@BYVJ2K/DHH\Z(TegB39cF9<A(]
Z58X9LM7N+f;MGM)GO6-R(FKLfY+TL1eGgOBW8UEeQ]eW9P:1.D/M=dg)30_8gc0
V4eY4,bB-0fQ5UWJ(<D0F7HW<R9[=fY3+6AX>UB[EULWc\M3BU71N-7f7ga5J5:T
UPSdU[b;Q0Z73VJTFe)QROT6Z#+-Q/eALD=5?N&:@3#Y:^Jd0Mc:g_f=(E93/D#E
82]:[7XUGXFeQ.T=IBTQQZRE(95C1U)=CP&5DE@\Xde\FTg6S/S>[TMOaV&geKO5
U/aeN81NA=3Wb;C:04K9L]-g(WZ=Xf/VU\OgBf3g:U/-9bfY:LSU.1_b&4>99(?D
8T0&CE80S;eH=aW8_I\9CD^\F(.+(R&G:U\AK5c,YU#^/,Z=,+?-U_5W+d?3eAZg
N)I?BU6S6<<_<ZbTaPDMG-GEUXH4_-)ZAU+P=S0FV_B4Oa&:#S94bU_>d@DDU8VS
].I^+D];CN:WJP22<V2\NAJA(=&J71-N]UJ1Be@,B9=c=P/S</S9]P[CaZB0ffH[
P\??JWM:#0@7H.\)P4&g(g._ZFLG5V/YKMKXM51bK@K\B90(+Z[2W_TDZET/U@8#
SM[??WBN73-2N7@KQcZJTXP1Y>dXK#9?e/^DN\0+_>NB>\8Qg+\<LI5TD=#G,6bB
&6:M+\L;0G]OJg;:\^ES3b.3N(Y?^+9N]bFPD1,LI&>@3GX)F;#CQV#T]bQUQc1X
)CR4>^E?/E;9:gcVOdK8I=[K1/UO<agWY]8:_)=C2N=P_,cJ>=Lf=c;GF.(?BUfQ
WL9PN9/EOX_TcPFeWL,QL4,ObTK#9/QVJB44JFe^>C((_e1RUO18ISC6QB;GD<5_
R2:VE)COR:eYK#6#O]dMC\A@-:V:]T<dV3fTH+c9?PZR-EXAH5WRT9BVNVPF;QD3
ZYC+P;RYZeb6KeG#5G0A#TZ2J,_#a/H5&dF0(N70SgYHA=298dT8e[\f\bPCUEMX
A0&d=1Y0ebeO+&@:+PaEfO:CC;+1PZc6)E\(HbB-NBT=,1Sa;N/[XXcPB3FD#Pee
?#RD>f_OdKG@H+UNbe6(POMM#5Q1OQ#-5+;U=4_YCfcT,W2dR7LVWO6Jaa&EOEbY
A7d&R=AWFcI_H6?P+WTg(-_9+O>]6SZOFbbG?S&-gGM@9\SIBJ@^JK=T-JU[(7;c
Dc4&J6B.(>KL&8[7C;C6?=,XS+8QaVc9gJ)<521KKWEgSdcf/4__^O[<S:=>;I<3
RK3A7AZ0^R[aGZC3Aa&_&6+53)XPMDHEVB?78>GJZbSZ2J@F-RP8:DCe-a]\&2Y0
F^eO/)1O(9ee)=>I;(QQBBTJ?UTPf;O,bVM8JgD.R>=GE@5e[b/5J&LN2KfQ_4I1
HSe7QY-bC#ed+0,UGS2a&LNb<e<@G,K8Y5(eb,:GZY3Z(9>0&D0>V;Q,B@7cJJJ:
4Xc]M/2<bXZLBfFEa0P=X8.EBKL3?<e+JHD/PaH6Qe7fJ:4WZ()+O41+(_IBIWf.
&GJe2W<da=?2Paf#LUZg)P2b?-3^?_I4D@L9I:21G5E9[PYJW?b(YVX&43Vg^6BO
Z(/Q63aN?^6^>;O,8Z6J<1[+>X-)IGAY@;g&,J@NP<JU6M6X86#(B^WZ;5+)?X25
K:KRJL-?K[T5?f5YT651>(4Y\A@Kg9HeS\P5/O1)+D_OKMVa+XZ:/(C/f9gg.)-M
bc_)6[<Ze-,dV\eX6Uc_W^g2fO@LU\(&.I_<\8(RH[W1L^P/^0-TdTY&,TRfR#86
37@C@e4QOEY5Ne3A3Se#LIeD/I,UaN)TJIcde8SeX+B))ebUP:=M:MZ#L0N;6<BU
W0;YWYYX=,2cL4QASC-g_b2HLa5)gX>-@(>H:c-GYAC9aO;Q_CMg6RY.7cf;\+\e
,K&X?1LW-2^Ycb)=X,O7bX^VT=]9OX(]\H;]\EP#D.4eb@3bIE299[#O+8Sc5R_R
Qaa]Q)CM@,R?>EcJS\F^ab&\#84BYWKS=GYC\KecK54_?3:a7_+&bD4#_Q8@^eCd
70c8]3?6.//3g\IG35>-T_>f,]6::WW^a9Od3WEf4a8a3+beb.8N;S_Q&V=?Fd6f
XABS7:HGc0>X1\ObB]RQ@=1a73CdGKOR8Gg8W]#@/dP?8Ce#DI1[G7+7@)-CIa3e
YQXT(SKXJ2K9LV]_=RQ#LN/EZJ9\3XZHHb(^_HE0GX_P5^3C>g)_?_<9Id6I7>X(
8KEXF&DD1KW_#U@>JT1\S=b5U->MW9G2PbI_g(:EIB)[],57B;=3f1[O_aLQ2+1U
Z2C3E20=.M_WSB1KIM++>a,cW?GSUA.&4(E_8,b++JR0;<H0Cc/ZZ0:BTQVX,JWD
.?V4,&b7gM>a),XWd>M6-@2)E]X43E+QZU+H+VK58U#ZgKP\JB0Bb-5\[;Oc_/3T
3<,;#?)TTHPDU;(dJ>OFX:8\#.+=\(^f;3gF+QLUM,OJE>Q=@D)RLJ.2D)CY;)ZA
^:(HOLZM/K4L9\@LM6X[48[^[AV9C<WK5e0)aTK/SBGKa6ff9>gDLX=@1<UY+bQX
UfF(N8#P-HIOZ^KTd0.[Q]_gDF?KHaVK9T@4QT@>)V2>?S0L(H[C/;6XVS9([;1c
RXCg<[KF>6d0TRB]8#D/Z,_3WK=GN;b&_+0J:C^J<V(L?KO]<<H<UccPNJBdRI[F
<5LHa8C47f,;M>J@/cFXbDb.9@?K11/OggOgX[&V:^B(.RX<b)H<]Z-9EI^]^J]9
E8gGM#0QLD4UeGIe<@CE]B@b@K=J)a^^H<C^bV0ATCK28JR@<6c2BH8?eXA6g95Y
W=HX/fMWa/;]3_e-SCS1aH8]ea==7&.Ka[F;([R1\NQdg,SFTH0V;BLNfN)+=QL?
J^/TPN0=C;&X\,KUE-ZT)N]-/24-E4]^11ZW+Q#TODBZbEL]]e#[>=FB?A;gXX(a
A[7P-ZS5+/?3@ca8DRAgSE:4[)P6f7RQWKP8X;?eV^Z]7;Y1RBO7,K0LfPW]^4Sc
egS].e:,\ZI8QQdcJGH_7IZNe1:YPCLV12+F_0R@+SbUf:<_.f-0.b@B;47B?<_&
B8\d+RK:Q)^P_[:77TG)Z&/M:@cQ[6FdecA8<V]=L.=_TE@EVb67N[=W2UJF<2D7
(I=G+/F03RCDJ+IF<\B-SN-UeAJc>V1)?e:f)YW6(?3M,_[d\>dMEL^ba;<92.5N
95Y:SHgEV;7Ybc&[3EEVQH/L.QW\ZE\Gc)(edaTY1g]N2H.U8@DebJ+BVgI(49F5
@@3IQSW^c-BHeOeHO4ZRgJ.T9]^-_K_7=D]2HZ#<&ZagB75gH4RPMVOcg[+LJUf5
CHc7.T6D]L5U]J[LN-[Y)VKI>>N@).2;L(1d=C53Qg:?fE^&N)GE00&<L)WeY7fI
P;g0:M1#<ND#2AE/RY&[T3]#3KY(c3J&N])D[@aN#aLNS@/cU(5E=+BHfX-;TDg>
A2]d;</d)Q11G3E(+;8H4Qg[,2&<P@,2->KTYUZ2gL/b)D02gdJ:UPDVK&].B33b
K:)^,MYg7(Q\?U=NQeVYT08_cb\Lb0)M\82R?,.,A2EZ@[)Va5UMY>YLTDbZ)8&E
aJG-PO/@V^>bZKM^]0f[I36Cd@#QbBR6_Yf(Oe[NFOOd3N->)C,9[:QV\PE&fY08
-=A2QJ6+78,7X:[_ID@B=]Kd/1F()G&71AgWTR^T&G,&&+8IH^&MM+.5IWTJ0ZNL
F+ZG&YHV5/B_fTM3C<&[C6dM/dLg&HI#A&W)K^bNW\XgVe>STK,(75(Z7435HA-e
OU=U-HBPSM-7JfAP<TVN+5<c?H+(&WDc7I#dVH3/DEL=Q-IHa)CK(bfaX=3@)=:[
@4]D-E,bH(f,8FEO7cX4\a(1abI7/,-)Z4I;OIaY]59XSH=[/Nf2E2_)WSKPST9/
)Pd,/-/C;?a;+96<Ca6XN9<J&dPI[@.f\Y[(NCN>39BK149BE_gXAg=b<;NY]U9\
DV0^1eEV,SeTH.90=MD[CPGgbc)?(_/bWMNaEcJ0NBEXcAbbg+f\;MG:bZXTeP?a
RL9B1X4+@6\aD2ZEXeA2:a9A^)U?EP,4d=f#6U>M)9@R,^S;ae?RAC&6-=eHQGL1
4>R\\0FF^0Q(P9R<ASOOB.UPQ9MBP4bA8]V=V/UYX<4&aWE)<FMEV^+d4X&&DQ-W
UO#()RHaD/3EdPJ>XL^:N\e/39A;f2I.>^7(R.@KL?O2@_BV-,f@Iggf>a.RBU.0
XV5\UVU4W#a&e5.U5Q>bc;S20?;JPg]SEW1]Y&4?66:,C])KT@[J9ePFXLX3.F<&
MTAPNN5COJ?->#ASS3J]&8be2F6cE]3XaVaS+O8HSEH]2H[CC[cc/UM-,gaFS3^(
>Y,0\>_U^>8X\FP53b^XGV+\I]T=<:QDJ+KGD+GB^76=&C-4@0@BMTQ(b]EQ(@#a
A3@ZZCd?.]//HUY@,W1fW:Y3<[YL1g5N#R-0affE\ea=6?KC&c:D5Wc>aT(=6(9T
F,cJ_GX:LAOO4&>B;K9#).(7:3bE;KfF&2(4SC25MZeRWF_G\<3DaN#12Ib](Ge<
/Q1H?g4?aJ)Q]7--R85/aBKRQH@IAR^,LUc3MSG3[RB3,3UM;M2O[aQf5MGOTG6J
I)32N[VN[HS,IBV<)V1;2WJRZ(_Gf@M5_=VCXBdS)>F\:HV+ZQN2,WBDNTd;e>VG
(R)U]@DWAJILH7E51S&J?,7HVK35U:a@.&)ZQKVC0C9CJ^L5Q86L,b4F65DPb#=Q
g\Z7:K762MK8NgeN0PO::fG+@,,^)Cd2A_b3U5Vd5JB[&T\QSUY1(XJ(ccCc:b/A
PW7]?Aa34W60R)Rg95V9gZ;XCB7PQHgA[FXY+JPdY._eG?OUZQY6[^DHNb.S(2W8
bVSD)E451c8S+#0B0:S-b)D_4B1g(WYY4(V98)#.:BaD]QG9UA02JAM#9ZdELML7
W?d4TJHK?;5+^g347^E=4=4FQBDIKY4@&(-gd?2:2#=b_P3d@SfAR8#]/9LbCN(W
&.gPP\c2]#5T4259;]_gCECKYDeM368aP[G-,@3E9>MHYTg\[+e9;UaU_:(DagSR
MD^O^cfS=[V2(ZP,bP0.Bffc8fI:gA+fg8GC>e.9Z+&VJI75-CKIG>fOC-T#=J5:
]7ESS,=UB9WI22)JcUF_OI6?:#NZVg7T?YC5f2PQE]HUJY^Nag<[=MO7CgGFVF30
BLTe;\8fYdR[N:>?7B_R]Ta18Y^0g,]P)@LAc[1A[]=#8KGHST7NOfT)LLgS(:c6
6T.4&H6M.09TAaM.3?<5c7J64U+)JbZ#3OAOL]7,_d=5@(GeYHYL__T)J$
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
52;dDA3@PPF?=D=g)4Nb<L(X9;Y3=0RZ-AZ](dE=,_.cFWfL>\Sb8]4g(efe,fT:
\I;]-<Q4VV0>#Ee>+[CO\,P60&.fRE5OG.J.B6\R&Z)I.)cL629\dH6cZ:/I.H@]
X[19FSYKJ4f2c+V^NR,D[\2+EG9FH=K5d5bJ-QIT^7D]E8H<IRabJ&/E&=fI2?]<
[S0-3Z0_)M8I\3@-_AXM]3J5V20?8Le^&-_fB6ACLAIaWJEe[IH\(#@fZB7PD?CS
J=::TMg+8\M3a2>-^^Cc7YN_=59Se/5f2;e2+038]=40B[CfNWL5c#F/@g5Q.cO2
9[>4UT\.@#8e73.>2&>+:2N?A[5.Q3b_>a)X&aVfKbF&>G_>IYAQa/(@\NE1^OLC
g0;KS.(S<==aCP_GWR3c2d/:S<MY5.HY?gK-[eUV[,3)9d7&7Jbf[-ReBOC1F>\9
,2P23W21aB([5.;,-cGF1#/SA>;Q@+.C-B,SRP^_1CN/3fGId?9P1DPe.0MVfBX3
QbYAgUbY-R0fRc9AA7.M&1MGY@M^[&>a\1:SUI\e6+:WL5L(G;#-,9H3bE87d\^-
<88J5V#3KF5FDWQ8[7^b=KHO#W0+9>ca#N1RAO\?=1LS&A65V@=TGH?@Ma4Rf+a@
I9H0(26>cCU^BOM[OMZBE9?]B/5^0dC(ISNQ]>5;XM.RRWQD5]Y8O>IK-Y.VC_[7
W-8/g)6=HQP&IBGFP_F_M?TXO9#XG.@]RQ4f#OQHZ?ZKWR4KfK/A>bXLO/:^SF6V
eI=K.MUUbIV:Pe,2@40>ZH.OP2&_7a\9E/M#He,.(D7[_W]3N40)7Qd;@^_WID)f
J_.+(0Z?gI@/,U+>Z[5e]MC/#IA,)7[&S-;ST^CS;4O67<VgaE7ZJ.>,8-Q-5=N@
PN\EcPWO#(fZSCNd^7L@:4A7YFe0T/SA9TQ35M48gHHYK_bLARX4G.X[_U2ZbPUD
Y+I0P7Ob;9GaY>)C?GGb7HX7L#VOf<7Nb9a3FS7J:/R,J?_@,?:GDTW]=GP4a<HX
bg\0OXgROT4.f9;RE]1JK:8b:[=BQCCHC1F;^#3L1T6/R4eK^H4V^8aN1ZBB>N0b
@QH0QX2)_DL;G]Le@#IGU,336AYG1HX20>O_\3<T2^3ATC+d+0IH#NBTD4<Cb6cP
XT0IOX__S8VAP/>@>@+?P3@8<Ua[GVI\GMM>a?)5fR;cGB,>I@,g1b#J(S>3GKHC
=.N6>:Z.A[YEbf9NdG0^P\VM?J[/7]9[U141SXWUZOf@JbCb:fX/eF97a=DJLO=0
B4.:)b)6(]\KgAgJIWB>ER9bGET_LYX,F4bM0S5X6MZP]#S;&96UQYG?T+:A^6&T
O+T1;X-0+JFBOQ6LK+&Q]Xdd(b81@OT0@2]+++9JB&P]5<VW1TBNFgH@a(,D/4/c
EGYX+K8JgSJ@+I;f<CETKJfaS,67RW\^66YFQRdbH9EJJDZY@4@5KaCA?D^1f-T5
,ORRb9d#:JXG@15.a]+(^QG^L6bSd0gT+?-Be2@4]FJ^&Y]9M+/Eaec\&=3U^9YA
dH+:&3G;A@R[.;1_f@HN=e?I>6N]1AA.a_<,e(5M+PLNQeBa2S:75;@)04_=,=:b
,Q_ae+cf5ZaZ\;H:+g6W+W_.QN0M^5T#SD<af);.AdCM2MAe0/&5&UC+I?#Pf[+:
FC&C(UGZL1_g/Q)YdS_0D_3X<;Y&0QMb/ae9Z[_711:U95eZC12C8K8ZTE/_)QLY
bf9\#&=SMb^9=Z5WH4=J=8/HF_dD.&PVaaR^87=?L;[OcQJ0aR5bK-G@d(5f//eC
3A=#/eZ:_RJ=>9EaQ6.9@-eG/fA/L>ZOV.Q#(/(>F/>aL8B)<LO](gcM3]X,)FX^
I?YZL-U^+R@Ed9A&#QLS0&1&<Z-+0eDCKP==#=dGQ(3;BOB77YF/GBd@=,8)4]VU
BI&A;Ue40-H&TQ7e#L1BBQ-=)Q?Q=3]_B@N,CSSgIH[H9(JN2Z^=UP)]IWTM15ca
bL[gaG,5V0S7;]DDIdA)LP1K2\/K\&gJcK=>bIZ<#)&gI^WUU<\LSCV^AV=L8^N-
;E:gYRM;L20GKQRO_7&T>e:9W4LSe=+/R0bI#IEg-E(-;;#-8gc2cG&C1aH[+HP7
?L/AF@L(cCTWBU&1T+NW6T]H]f43RW+Q:e-@PXRA-UHg1g_QK1?f[PI02;M/+AP0
V[PI0&Z.G==(1:G8U^V6;Y163@T2g81+4DA1TS6RW0F.M_ag:7bUWC-IBF5SN]g>
E3#DY,4W;+C(0$
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
