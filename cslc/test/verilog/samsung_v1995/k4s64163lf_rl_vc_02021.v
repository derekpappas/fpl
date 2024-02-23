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
/RZ)F_L_Q?2T<Rg#8,;b8_8V=4>7,WY_<_T#)4WS@7<g/a9[f_?E)&@D-P848;1T
,dD8fR&TTPMF86OS=JbP#gDJc/,TE#b44+cT]#G^&MG.g7M@eb3g.><b@MLF1WAQ
IYbD[6agJD&,YM6edTf[,DDb/E02?GJVa5R=K1_+&YOf]KOFQbTGa5<@6W(?>I;_
8I-SSSCcVd\cTT5-I53M<F0XMWRCbX4F(MHQgW<)I>+TIB]aA0Cd=ZI7?+4-(f,V
/S+L)Q(IGQ[9)TQ)K@O;,R]7G2T6W8)+HK7001@]_2Q^9,c>f&]a:>[84_YQH##[
#W?<]VdQJZ<WPOe@Z,4N9[M7R&I??@T7T3[Y?IXIX?8C>)4\]eFXfeRRXAT<,N1I
,)2Q@>R04^S+;Q4<E[B1FSM::WZC[C7H0V&B0M+N9EX_IJDMT9cPZNC&S:F/8HgD
L-]IbU)Z<e(dS/ecD_&+SJ8Q[CKS75S6,,#]/O>)NBC2#RZ8-BD-dW^gOeFH4D9/
UUPUS5RcW_aaQg@>0Cg5OO:DGXX?<gFDGO0X4P/VRbP;\Oa6[4.-e3K\IeMBBIET
=:WNMIMSA,ba)PCI)He\(6MD_I.fC-JfMYBV58YKL_-:JWdK8;L7C6eQV+KT)5II
,?2:H7/e7PRL3H/-(IPQ4J19bPeaXUb(_C3eNL=9&@e,VTRFSB&B(2gSGP)4Z4L.
Z)I&\T-F&b.NSa;<^^O6;R+7T>C_Q+@[W]@-[VDCE-g(A6BQSYb8(LH)4gaK-92H
J2>@1PWSa(#[U;>2,E0.^L93HF,92<8D@?<>UD1<>V+PHS()5.KL(_1P(fHI)+<L
TEA[SWKA?]9Z1-T&4;)4CSgWUL)FT_DEGM[,W0\[T(F]BbT#:)e)49-cWK>\0f5-
?-V^429gBJfM=7f2?A#IPg[GHPP:0^DbA?=;M6NJE;Q>::E&@Z#gD_)+&^:LA>ZT
cSV<6I9\-@KfB8R[=PHJW0aYAaOLZI^>-3,MG2SZ?Ag0dd&M(SFJe67?D4;WNOF\
)X=OYXM+X2Qc9=5\3Q1aK-AM(-Z292,A#f49O>&gO06FgO8&E_B(d=A>JHgJ40.9
d5.57C7g\=23TI?VL4SdD-]d/RTUL^Z-2.c0QB>U-VZ7UOJ_-RA4=93-@+-O&?_@
eSQRbac@<Z:#E8D:]4Gc9-)DbQ2D^Gd0Xg[^Ng>U7fB(TH65(S+(TD3Rc1>\@7R:
-A[6&BfV+FJJ[:\:RD0K]:&IZcU#D]0KC6R2O/AYHE0]C?FB(_gAfB2KCFIO\]V]
bObF(;K4N9RfEFD?/[U,Q6][NSN\8;Y\0eD+U_9Q@K9Z,G<K:?V5IDOUF/:D@cY,
^\CYb(aPVXKX.]L7/SF9Q/QV&eK5.G/2\e<L32.OH>F&4Y=:Z4X4&R^6?.WMCf<Y
YeX.,E[e:OLCCfHY,L[2Ad@&K\IS-IDJEJ9/d_0aECG?B??K2<7E[&:WH(a962Y6
RH/URZ/HeL.N80-O\K>&2.cCKP?D<<gH;A\^PD:;N/YE2TQe]AYS2Pe@E/G<+Fg_
W)9bZV#6R2=HT0ffI\_D=T^\0<Zg11f4-25&>U)VXR=9#e.FD@JE<54[bOXgI3/4
X&CVfY92FcQJ[g&64F-Cf93_f\H(:GZ]G^J]D[:?U=UaU--?G)/d<UZWQ5WU-0P,
PT@#27E;TJW6XV:-1V1#JLX&d^7E7FZ/H1I6>T<1K9I+8=K?+0NfUY29b&BTP/e7
AX5UMHc1>70Od(K^Ff2?J3CZ2aN;bCO)/AC1R4_9\F#=77fMfQIBK<;0cDYcO/1;
&1O&b;-:22H@;S>CdBPY;.]V]8L#N<489LZAS5D315#^BWHCTfV0;V6SOW5LTbQ?
8)d9-U>1+29fJ0cJ0?9VOMfa.UME)=R>?$
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
9H7R1E8P-U.T(I/?)ZJR-0Wb9fA;(@8R-aa-=/RL<?85QI4V9HBG9#DW(a-M=2/-
d)-bMcc0IUB(>e-CPT34\^.8N[)E&gUYHL3W-Wc4:V0Wf5#dRgGX9RF\)ISd,b0e
a>]#MIZ;MKS_LcPVA^74@X/\9=LLV#X85XF&Hag7+3#&RZ_L^U@gFH<NY5dU+U8#
@1DPGD:F79@UT;4H,WaR,M.BDI8C8Z@fZ=5627fN(^RJW>PV=3(G4+9E&;Z/.=CQ
-\acCOgefaP9E[ZI^KgCS;QX0_SVQE_XG?VSe^THU[O(W#3EN)#VERG.8NTHCTdb
YZ\2\;2_D8DIJF(;#;5+:b)GDGc3EE[A9c85DG[5/E2;S?NNeZEJXQ<3QX9N7JD)
Y]?9:\5ZfEBe1][9THD72T:85_)T:WDf<MaAUUK4;S#AQK:0NYZ&OVAXPDEEJ=6.
G)BL04e6ISDW/f26MRZZ>96LJ.f(Pa^((WJ;?IZT:e0+eEX@ER<e4TLZ8<N_JPB_
.LW4b5J-]4#>gVFEfJN=8)G7)\?KMKd6921Jc1W-Xc6_P;6P#c-3IW+-?d\d(N46
L^Z?-M[ZfO,L/;85DM?I=XHRRS6AW(83Va=&,MCZ5I#R&U0b#;7F@==Bf9]eG)4N
eGPX4cJ2d=[E[Y<g--=]1L(f-_=.P;5>EZC>8YWP-84CeM0dP6-UX3C\8b?_+F^e
9/(O<F0c6)960[_N>F;b3Sc?P3a^VO/YdbgI,1:^a<g)70GGP15>e]@;)G1/.&\.
.+VGV=PR]<VCYV7?SC#H2Z>DX9g,<2MBTNXNbW;R<\&@WNA;P7=1^;DgJBQZ>_dU
=ERRDa.?(dX4OEbBP.G-f]cUO7+J<gY<54:3DYOK^70?E0K6^:/\^2=;3BU<K\4?
A7(W?<M0&SZ6M9;Q3I^G;7M?^E;29^3XKS=e>aC/[)a<;YHBY6>6a2FPT&7F4^e;
g\B5fcaNX?D5]D&-2M&=GSE3B-)7T@K&g-7\ObG3U-RR(THP/c(5=G&C0O>>[4eL
4US][6[,f]aR=1XAQU-2#_=5;X\cNgLOF+LZ62#G+#<;8@_Wa,GZ4Q:W#CO\E+\Q
EF[FBW[:XB/&06Ub/(L84MeEAY@D@X73bPPV=9CE2cNb(SSZU_(DFTR[1GI7WGRV
_5-H_?GWGcg8VdNa_HdL34-5>-^2Vg1f>__7#d(YW1;6(aGgeaA4AYNBaBZ;f,HH
;6,CEO=CL+V:^+d&2J=-TY4P-XCH[\g/M.;@#-8^+T_C#-YMg23a8^a9/4QR+X>K
5==\^ZPWf/>:7S6A_dJ6HW\K:NRB=DB&D;(a]3=B;R)T7<AfPF3[\T4C6A=(:[]_
-U:TKD;&=1]V3=-1@40Bg]954fTe?2L&D_7,MTSg;VO86AV><J^3LLB[[D9,Og,9
0RG<_/1[b-&N[W[\L]BTTO_ZWC;aIa+,fSOKe+6(]Q,&b3UR-RGTN8g)+^;P+Y4/
<1bg5>D0:SH_S]Z#;5ZEN-1O[;-EdM&dCT[,;K/(@JD]MIDH.O5>2MU+/_N[PEF-
9\P4QP51A]Fd5H09]cPDdSM>\WN3MY-8Z4H<..1-UdDbAP:B,]R\&5a1BSMPBU16
E.GFQcR8P[8b--NfYAEcH[f7e=9>&D^F^Vag,#g/-418JHY2#@G8R-J2[7_5K\Jc
E31@KB5fHV1NCf5ZTK5QO3gd[G=^fW;808AY1bB(+QJ<]\@8BVV[R::E[2L(^XXf
\b6?:^G.#1YRa+L6F01)3<AA/M6:@)<Ef+9J@K]RR&deXa4GLaQ^3)[LQ]DEMF-[
b[@4O(ed7_ggE3faFea5aU8=Z=R#WD,>L=_^b-QRINaDEZ=d2&-Z5L&]QcagY/VL
DU:6bA8H7PMb&J?FR;K)W31=7FIgMV##&K&.&fIXK3GA:&N6OcL+FQ:D:g8@>=W\
b,993)D&\7.CRXg.Gd=TgJYg.Y)3RHa@(2f4-I.Q^D.K?E>bU@G2HZX.DfCMZ>W?
P=WEHY>GKCI#=f(IHNf,O?YC[/[U-/&9@]+U93YX9I+(9(3FK=^cB/]FTMZRFg,(
,ba[U9XQR[+_(7?=:?27T&5CW#N,Ra>b8-FPRa?EOGbIcC\bW1U_VDXL15]OL;5d
\O<RU914R[O34#=]\d4]gG73/+VL0<&<X>EDA[7-IAd>X^fTg+0]3YSaSK_OP8@H
ef6L\B[<ef?3VFMHB>_(IKbeW[SDTHZQ(1=HJ3C4D,G/MPR)OWZ@VIc4+S_KZ#3@
U8Qa>K5,,/T^C)?M&ST.-I@]G+@E<+(b;]g@IN4BI=5QA,DL=MACZPFd4W58H_UY
87N/X_c_E#LV9EX(+^4gKfC7HI,A9\4Z[#5gYFC#g;cPY8Y\KN[?IC\cF>N(EF30
FLG;61)B)gG2f9;Eg^[LH&VA(VZ<Y<YN=C-+CT[-#B53;b[f>Ufafc+1gOZb[=@K
_DA\HUA7R@B-]-\AW#>gGfYW#0Bg)R9)eA;^O.XdV9a(XMeC-P4c.S6<Z?Sb94;<
D-dG#^.SJe@[9bc_0Ad8G=8:M90,=B-?EUCHF3Z]GE0A)CSBY0aN5K)f4]3PJ>Z>
P/(445gZAf_K[D@N:SO#]ZO;D#1R.-MHdbNHf7\:gc8O+2O_:)=MX85KCaD[\]&8
7Vg.#.@K/+Kg6b]1Q/V^^;(eQ?eLP^_BfYF^,b,?FCb/+aE,UI[:@0D4#\:X7I^d
H846BdY0]/d+;(+?^SE>]CA5a-#PZ.\MMIL]XOa2DV6^3NO<d)\+?L7ZGL[.#U9:
,MXGH#_IK#dJ_ZaK9D0CL0YXKUKc,LW^/6R-8BZ8cfG>E#]>NE>>;10A^,(E^Q7I
DZHDEHH#Lb:F>OQ\T:&PE&WcF@:WZ69DK,1&TY0DFH^.X>Gb@V[<b@cYY->74G:c
]dA2<.:XWBg+d)AKPDQA&O5I6+<9&),@=7e36;>@&O3VR]EZ0J@5J8_,JKKHJ-SY
d3]C,VJV_&J+0$
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
cI::MG[44O4d<.7K9OC\8F]D(6UY)GQd<_Rc(?aK/4V]LF=@PQVc)Q?J-PL@-OE@
61E:Sc#0;@M_@.O.H>OR;X?BFW7513\.V34_>O:-8g,^22_LE.WYBC\cHHX)[-Mf
9HgA,YDCCU@QC@NF5;UKb,@5+C0.?PJ:6#P)];NO<,;GZH8M2-EV#[3+.PN=QIS0
QE0#F;fX@K8FVOLO>AU2P+A]X0XdCd1]<3ZgHIV,2F5f4^S+cG0.O0?U_P(N6Fdb
(0>\)2^,>dZCeJ<Pa+b,bG:c<JBA)=;00^MDc@;V3Y-1EGB:IHH=<(TO@4Xc^S-c
.>Pe\E<\K-7.=#[0=^OHAMTTURZGT^f1fB)?Z,JO6-GI7;(CgV1.dZCF^DYWb;aP
3BcOA5#;4CJ?AXCFD\W6SX^1[9]2YV6D,Z6Q4/cG_X&HXb#2N6CI__:-T7YH2H(d
).D8EGa=[5PMg1V]JK)Q5NG=E-PZEG=M+JA?<WgKV:_H]Ad3g/7:\_Q7S+(acEb&
+H_Z>).=:,7IVPIUHBbZ;XQF;3a&_9-QE@6Q.b,KQ6[U_5=49CS#>6(=.L_.f(=2
7+OIT8^c,FYJMN4JCDfFP(cR?+/9D[,OC<SGVIX)<YG0^g2EP^dY_1I-.f53??,:
L^?.XKB..OR^;=-6=S>7-3f,DUJL0C]H(9[6YO>?WC#9\4B?N[\0gF0:=VbOf<+:
1TBA>^+S#VH-D1>:=56aDM4@^TGK>-f##;8Y/=Yb&(@3>47DTRd[XJe)JH<\a-+F
6H]8(3(-bMaNWAO/f==;_;<;c7?2C/^4G;81ECb-c&;d\-cK;T\J?>X^H^ADZ9DF
TbLLGA+X[VD48[ZPH[>^.@4#U34D/#?6#.KJ]W11VM]<,G(I]#YJQP8Q2];WAdWQ
4U(6A?@C\H\2F_ULY;M6_LK&ff5_aU[PLZ1]+)(I&D?EEH7eCbN]MC5E=GE>PU0K
b1=8-)6?cV376=cN-?E&@M<9f63<Gg#\(L:Je:H^2TDXN>c++SaRV[<@_Z)&B3?0
Fb#OI8Q9dZT73-S#BEH/2P5fa@48eU=YIe7EFJe-RN\4)Zd_6R0]Z2T.\_=>#]52
-#WU9g,/fM?AF[ReWZ@e4XM:EaNQ-^R[D,^9PH&O^0I3>+]IZ8E:W#LCZXX.#AcM
#<5V1-GCB=9F10.RIG+dR1/X;CggaBA&UAMe,4d16a/=:1QP.B;B),.9J6)8+EX5
>2RC(E;GfUY:NZKX4A6USQWX,77Z.6d))U2b7cR80^ODFQL?T\=bcTV:&+Y41[5-
HNFO=bgA1G#B(BPU@\CS]7-1WZ:S6=E7Wd1/=0=&XM9,5#OC(Q4-=3=,J_791=-,
:/^@YgR&.LGN6CgY]O1fW[/<\6_G:WU1.4/6BSS^D-0-&]]eX4J39VFd@T<O)X;S
SN/&+;^EBFe;a3CdVb44EM1,I?U?@ZMR.fC5;+dNOE7)c1>1^[I6^2f_\8eK=f6;
?<<0_bZFA^DeXN-(&2H>He-PULMWX2WUM3@,<#RXLc@27JM1?MLg/S)gA]AVc\P0
K(A?N\(RYK9U>_JTSCFcd3Ne]CQHg(=\&]gD0Q=aT^cWD4dADP^c&H9(S4PN-4[^
S/Ze/79WCNUO7<<-^a6]GSRb75U,f0=#RVeKX]/I[[X.>&?C27X,84B;aB=ZIJ9>
7GbV8A;4BOd&F>(4Pecd/E_VQ218XCc;XOJ#45-=O^V(ILYM\Z,,?gNIA3]X@+],
,dU/K)X&)84S]dVG#dLM4^aVZfbFcP:<81M>+PdWeKP4./)54PFQ,0K>\\cAX_UA
(&<ZDc]MP;V1X=A[::>))#Z<HO2Ec/9>?Ja(8JUW]g)KM@0bIN)QX@+G^ON@F1.R
R8c0QV]g]8^WVBd[WDE7R:8X2V:a(>7dB6#STDNW]&.HV2QVM.I.g39?X>W)TWGW
1Q6.5e&@QBeNLF>Yf@]\[WCXaKfHK0C7XQVW0#P=TBF)g8O+T,XK-1>Sc4B.d7Ca
^cYT4(J@?5N(6>QOGQF&Ea.@B&YBW]dNO0fZYTE]06B,QA[E>G8D<=95Z(-/dWI?
gQ0M\?ZRHV44f9T>J)<VdYND;6X]/4:R-X?1c(,7=?S5[3Y1ZAI#:3#6e]GeKI1N
R4.;gRd33+KeKP8G#Q:U@O#R.Ue(Td5)3)<1SSYY7?PCd0ZF<R][6R[F#>((X2c)
751XZ<:EZ_bQVK3Nd1b8LX/7(HYIGU/N@&7(M(O.4V>e+d4<J+R)EA79[8>DJQ5a
,^2/W.H?R=RG<3FW6)W>AR:8[PLLT+\N_=PUQ.,?,D2C+3+BUSBD-G4gXO234N]9
U6Q#?43#P:Q#B?b=ePY/QVdb5-WR;3-.KMH][gM?)>[X<6dQ?);&Y=DZ:^e0b+Z4
4QGV8EP#a6>NHP9;#-A<[Z^;6eD1YU)R-,NIFGA(M@3Ze6R<)FbM:OW8aRg_\42_
;B>X&_6YFI.I>_UY_?L/)\-MTC=S[@S\MKB\AZT(O8cZ-)H<cK3eXBAa^@:.cgO<
?F<<E;-W?:6(M6KC;@8=SQC65KF]\=V5,>I:^(c;6SN^AJ8V3K,Dg<cdE0/X5BM1
ML;Yg?R5W[DM4?D1IdN2[@LS-gfWCU2@J@(0^PE62H@CU[>M-;_OT,3H=>EV?7O)
WgP^MgH&c?0/0@:4IUG]@46Ie/+\d4BG))83:P;fANTD\U#4@cA@Nf9>WX2Z]:O;
D]?/EH4U43<D?d5+EgSI974b:?#e):WI4<29ME]SC,V]3(E;]d\T4@aD1P:RXSf4
V@X\X],T+^FZ._@0)/GI=A=9;3,,;7&ML#8D?XK>Y+e)UR//(Y3@7+f[&:&+dRca
YgRY#.\SAId@^?ZYI#1a^?1AWf5TC4T]XI)AJEVQJQ_V:&+\<J79C]S0?L-IcU/c
::&](^EVcRP2e6,V,?HHBDa3XQ(L,CW\I+(84S.c1/#=SHSRF]Dc_-\,^Wg&H)JB
Q6?e&LfHWTP(&,YVHK4b]MER/GBLgNc)]]DDLAF_EgdS>Q:[fP_IO&FE4f<A;@_/
PCP)eX6=dHZ?Ke]cP=<G7>(01IHVH3QYbRMYHd=F<>/S#Z[G^2G67B\1ZHd?;:P=
<ER(;^g_OQX7OLQ)-g-3.\2aA[1V:97+@\;\<:Z;H2PC3RP)3c/0V,E/CVA@0X9G
A;eA6J;8IdUSFY>gNB_F->4-CNW-8(f-9g0J7@^L[L)dJ7U;-NZKNJ<eH\1#>_Rb
eYbcZ(MY8XZfT#4XZ;DW18Q&]G(N?0JSL0C78T:AHJ4Q1[dTcd)Jb#)ZcA=G)Gf]
VMEGDI5^GFF3UaY-Id9B.3PF&O0>S/U45-A_056BcECd-6=TZIa8e5X0?OA6NE^A
45.:)O<JIRf/GQ(.QAXYQR6&aUD1-F@KI->&AA47K<;^8Y;[;SU>\LX3<&,]IO>Z
#BQ39A4>.^VXB1>&fP:E:WCO#9/LPHBZW]Z/1@I8HMX7?+fNISD_FC?]Q/8c.[dR
,>E4-V4P()D/AQ^#[GXH.XFcPZ#TNP&BQ[(D&KgDLeV:U8Fg8D<ZD_WgTXE9A-R4
b>)cccg]1MP=e>1ZV)HO.R5KgIPJeTSbO3:KJ^R&>TLKS0a6GTc1c@<FS/d/[P?S
d6d/JV_fP\I4NNd(9eB+N>-8b9#1^^,;C0)LC&>MR4)(/O]@UT4;Y]O06S-3)R;[
e]fLC\[K9BQ4NbGX,U)&VB>XI2CG>=2,+S1,e=2NNUb;UcQ^XN&V0P=H3H+W4a7C
7:+704?N35^FLS+F^a1RY0D56#S#+\]Pfc=[V=Q4R:FQ-&Cd=\Rg+E4d=cJ]I7Q\
\OJ71MA2-:bE]6SeF:/(Z:eI(I]LTW1Bf)+T&?ObV^3_,dIa#-6[LDR65SWdS9F&
?O@E]1bEUOdBD<_H.Y\=0XSF<P3Ye4eVBccL99Q,\MQQRD66<S.DPEFKV<YY+^T=
=L9C^f18De@c?Y8XPfEJPbP-&90>;eKB_HV6D?+c@ZHgJgf3\A-BfF:@a/Eb5]D9
;c++S.(V@6[,_bVE=4eS[=0K2&]?SFXW\RZEI[7d#a;(2SZW3RO[I00^M4>N;<ZN
C0]cVR.89SZPbbcL\K(B^,#4OF;G^)-915^IO1T.A1KB5]Qb.5DQ9))9T6ET;349
FMUfR2,VC[_f9JZML0OaFJIC-F6/8N,9=09fURS9^b0BZ[28VKE]X8b\AG(T<-7E
QfJQ_b22d1JPV(EXV_(2U\D9Z#88==FDB0QD5PbKX,>N5C[&K@Gf3AcbVLY:/]9#
KYFO+-G#D1E7-TUDB,Q2<U59;X\LZaH&_X8WcDgB?61ILKDBF3(0?@\UUN-P@IHg
P,aHXE4OcX4gG)MWe0fE(^LC,1R\SODXRd,#=dgRCK-gDg#KSSCM97)(C/5/3T?>
+^07ZKPC@M[@cL.3I.#]R(H\ES4Rc=5CC#@Z8II<--,DY#U;Z[Pf/8\3N)fT;ED/
&ACB?g4T-Z9cD<g/C@)&#R5D.)SM=F/O.OBD8a)UCGBVNZb+@[Uedfa#EZ5LC/);
GB>SXLQ;>cf(R4[>8\8NUF]@<9f3DQ/Z09_\,gQYB,\)7H#cS_@-T)A>P8H#)&M1
BX=V+.FfWIE@ZG[UMK8U&HCc,TA(I#J6GZHK8+gT<S2Q=F=OMggUMd-IQ;=^S-K)
H@.NN:a/\f<ZHHTL,CBCOO423B)85IL/P#c5Cg(I2Q))N;/5[RL9=3S40T:P\\Q]
-GWYD<0-&9HIe=+=Td5SBaXX013KDc-/Ud?#W3cR.AS]-:1H^J,V715K6+Sd@K,.
)]B-b7bZVQ>#_D\S=&,W-Ne/M@BJS4D;3Rc:=a\0ALZIWR=+L_2EZ0)a?@da#MRN
+^Q]DXc[(P_BPY(F/aFS56a&^b,K:=5B1P:_80aND5&OMe_<J)7+CQ[DZZI\S(Ob
?A[)1aS-MP=9)&Q?f^;]C:X57V7CL@d4+9@==PeL(be&EL3E=V]T=+.P3;7W0/.g
TXT-aCUE_RQ@F&61O]dT]]_K(UaYYf-S5H4#NC#:TP9XfCKE]9>fYLde,g:TRdAU
^<@&T/V]QV9AHdP0Uc,:(;U#f_A5OLQ=YO-AJdMZ_L^ZFMce31/.Q<fGHS,BIZB0
(YU>W3bOL3>Md+JLY/:5]<IW860#S^/G#.Kg47M(3AIL:/BJANc9&==Z>O5I[##V
5ZSI.D?]O.d&R@=IPX_PFK-RcN,P9K]#b/E11#_^V&-_G:3-&&F)])K6AF_3+S-b
WeM@:Te_G&IHXWBTZ)e&57)a^94\<W,#6WLW#,&+/Y2^cbRYP]c&IRL;).=4/ZBV
ZC>[E(X[?S7FDNRfD8Z^[f&QV^B/GM8Y^_6QTFa[RG=.ac=ZLEI1+FAG=JNf\Ff+
A)(d<ZTb)?S;AaWBaRLb>2=YCL1TUMU(::_J-JO4:UAFRV8e\C)6IRG9MD2AVaG<
cZK=SD9[S.E-^-00,=EVdBT#:^a9]5/<L-Q;^g#N?J&6C48:3a2[Zc=\D&J75&PD
-D578KDN+\AC.8K[@QfW7aR<B\:g&+OR8B#F_--+aH1^gV/\6C_ba[ZA#BT2>@\;
+/PUGf,IFOELIES6gdK\<a+CQ)gc2]aQN0,^e;9@<)0e&,UL>3HO42Z=P_V\6\PF
Y<Hfe[6ggK?5P&;/P6b<BXAP0(;?0(.)_dc/.3W&1)1PPQ)7+]TbR/3a6db=D5a_
I,(J[G;9,e81:6BcaE.;>_93Mf1L?Sc6,H_RK-XNDb9ML(Ue1-VM0Y2:X08ZV]=:
=#HS5I<Z52_[E.2]BSE1\6DMg,?0#CfN6<5DUV2=4@3\7:5\gXY+-O/?)<\5]??G
IQPG9,1>fT,d&[\3G\\NaHASHRe[=WK.H?XG@554JW+#ed;0f5F\-ZJP4Pc,_U55
Fe(QVU]/9AgKOG(>VMY3,&0^bL5+2C:=aXG-_8[.B5D)eW.Z5@#A,0OJ3HXM0DcP
@HLUFR#/I?Pe[,]YeK;U[8;4U)eS([fZUe/>=RO#SM6U2\SA4)CVD90Q(R=I&1_f
V-H[;Z=X#T-:F/N\74C.\Q.1A?9a3[YC0XV]WM#6?/5c0+E22eH,H=+\SU@O&NP^
H_=JEgVPG6[>M-[WFH]c_TVD>-&MIVTY[XfNa(bPV>[ZM:.5W(TDI\2,V397\1P2
I\P&Ag,S35E5f/LQfSN.:65EF=V>Y&&)Y:2^Kb6T\KP_^#6>MLa2B=;,MC1d=):O
AVD5(aI/aNN2K[c1C]<?V6.,bPEZY5JCa[)2HDM&PL1F&A=X=a]d_f=\g(3&ZFTC
=L[1&+(EX1_^#&]X.^TZ/g-QC&&Ta-&T;RA_2BeQ3f?L>Y3[(BXg>eWb?[HeDgG5
-27AYZF4d;5+5M3>57V>S>(:LUX5+-L+O_0W8YK(P-<Td<0(G<.P+\geO=2]X)SO
/7gcaO0LVU5_6=S;8UQQg_g0abO81+5f6V]58c0ee,][dH]I4B8I#9P\Ub9dSa+)
A6gg2a^XYB)4NfY4C,4NB-MBSgfC@^ReVOTS8#JPaVPDFT-HKJ&g^[FJ<_4cc((c
N<Pd5E^S^K9IOX9]@/K\A9Z,Qb+5&V2S[B-QgN0(AQB?8>>4aXYb_I-&[QbM,^:C
TO)@#53).fS_,EY2<5@fbI#aLAK+FG:2B8FH7XfU2](N.8&g4#ZBD0]@RN\=>;?V
O:=O;#@JC9&c\O_P)&18Fe9?9LE+@Z9d,Y/;e:>6T,aZHAH\(?)5C-JXB]Jb/R,>
>/K:bF8>TX2^T\TFEDVf2),K(DQ0G..PFC&5N)RV:OGTCCCR[7R4N][fe;HV+_2b
\O@5S2]UF/:-JQM0GAVZW)NA>MW)LVB&ebHO2c54B,C)6^>#Sc6:ND8UAMF;a#ee
.N9M.,9(,V1VHCKe1VH?X.(@\.SN@6XT)c-UTPS3N(6&D\MQAW@>2\e+;/]7Ea;X
dPccYGg_c-;==8(.dM8R3b^ZD8fN]:U:QC^FRX<C6NO/0+4.F)f(Te)61^a0P#[e
E.SL1DSN28A^)g&X>6&eZPc9WOUZc5CP_XAM6ES8OfR=#G5A48)KD6)6I$
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
,b_E\-@aY8cd,gO6<O53<P7M)-AA-_D^863H(0F<2c&8W(/BGBFY8\Za)&M_=(,g
(g/8,UR+K_#dc&RdfaC8^T<b1O@1FWI>#25]B=G+6&&UJ,6_?A,#L?F).\P>)CX\
3g3K7NgM?5#]0ZGFM>b1,ZU&&X[X:d_)YUdMg2@D5;3XDUU3^V[.0[B_WbGe9L.A
.d;43LCTH^IHS>1J6@N:[gUf,1IH]L(@@RRB=JME.@,CG.AUFB6HN\<8[.\I4[51
3<KCT(4CSKF9HgFG(a)J?PMdIGe\>->Y>:D:Q_367S/TP(+W;6S;)F^#b3RXY;(Q
Qec);@+R6&KQ/XB@Q8\-M--UB>Sebf0XYSJL:Ue:8<LG&g@2BZZZg(9D^CJZ-f5>
U8RfMd4=.8;d[GgZA>5_R+[-<OAa]OA2^fb,CXACP.MZ(A>V4CG@aG?XaX64.48R
4d:B,#^A?bJTgJI#G<R7SC:@09?H&7e[D@H&g@E7^M/1WWa6E.UC+/K9+->#5b;B
B?[^;C3AFUYM]1Q8^/-bFGEPcc&Ed)4>Fa247A@:86ICa:#1-N#NN]<Z);V@I;@O
P=72PV6^4.YKBEb^f[6BQV3a9eb5QJ1H=SWXgPP9G)3_^^d_M]WVUK:Qe<QP=6X#
agI4_4WT6@T1QI<[Bb;^HMa9(b;I3LU=)c3:(]Gg;(Nb)D,f=]<=#<08LM1OT,,D
CZPKM[:eG=##0O9B]f/D8Nb,d9=U[&fS:?8<J8/?9/G;02:K#(YCT4SLCD9=)T26
YKY6Dd^f/V#H<O7MI1d<gD]X<C/,3,CE8Q5]_@KWDTV4Z;+ZfOPfU\[/f2NWTOJR
#+cHaYeM+4/<_(NL_3N(7(P.g;9ZGV?M+gf6W1Qf2_]?;c2PN-FBJeUK5:>c^CN&
e1J.X0SSJ7ca2c\^52c=0\g2aC8eN<8N9W9;(3)7W??CZ0/\cg\+70+A9&\^#)P(
fB:DX-N\b8FB0AX-P@J4@P?1QE?gF&8VDEQIFE5[8gL(95WZ(c@]A(MXD9FUd2J\
bWbU)1Ig)dABOf8G;O7W\f,;JPK7f;\DFI8S7S_U4J,VfF^Wf?\g3g.-M_,;,O8-
H2M7L\B^\d>]cWeB)EER.I]X6fZ3;61:<[B:2V2UO8,3Zg7?JSG:O[/6Mc:G037f
_DL>IUE,@LgS:9EKQ;&/)_MX<CR?Z[TF-7+77WET@a:JQdR]LF_N?5GEIY75AC^M
2+W9:QO.Ne?=P^1F:CXOYJ\8.Z;9)UMO^,IM5:7f\.Y6Ja@XL,HY&C1,d7KSWEBO
:LE)c#+(Je(S.(b);gAC&.X;T1:DYGA4,UQ</gKWH:a,GLJe^L(bdbX&:=c(<NU(
9G@,(0Ya/PO:_=PSYbOK&E@<?2\Td_S,3EG?Sc&W,&XeU]#I>AZ_)]#G3O=a3<0N
^3gL091NdQPFC<U+_0,?1?G?_2&Aa.2B=(@_)BLMGg-61Tf4.PK#.@)cM0f+d2\S
fLdc(\W1\IHD6;@^)2I?[5#DRJ-[d@WcLK+d\ZNf?F9&SUP33<OH0DG#GIE(W8eL
+3;-X./&;(bEG>FId<?2J,31CF74LOc3C^#V\1C@DI8((P:YK/3Kb+.JD>O\(@+W
+ZSO+a-JbK4#I;0IbI,Y=AJQ,5Q8^Z>8L?\/>FIbY=GMU7?14QgI#O>6Jb(g<9c1
A.+(-W5_[O6g^>29&0NCcK]^&FPWXc7BISSKO73+[U:[Z0@4N3@/.[,^Hf)>GTX@
3_HdZFeWPB](WgSd];+g-Kf)CX5=AHSZBSX)c0(73>bW?^H#K8U]-ISPAH9F?NO[
\SQ4f)[F+IU#J,28d&8W-efW-=f+(>VW1PaJ)b=<LGeeAY<5gTd+5-PULa]EcZNe
P#dPB9[J;)-a5Z=;J&=#3+<@1EEW(MdCRg:N<IZ>@4L-+>P2N3YPI>4.HM01+\(F
C)O?Q6CP^_\O\RQXNGdAfV-&;9,TD]F5;_2DX28Z4VRI=_J4CD0PJbQTcRY_X3CW
;?(I\_BN_D]29>95C#6>[LN(.=?bD\&9@GC=M&<g[9GP2<aJL,OJ@]3)&EJ@OWRO
[HPdMHOc=W>TD.#ZbA5]\a5gH;J(B4VaPe4JV1AI4/(?&/[EAU1>,CS@PA&g70[Q
)T19S5=d&27AT,dUd:W>9H<,bX/5K+edPO925U.83cegbcN6HL8A>TU</X6+7,B/
J?7U.)X[=PZ6J,Ga0^ELHO.)HXXZ;)C85GC85@:a:Z7/^M,YUV0O=74XA1bTUAPF
1I\:035]JJLW=Q-;V^3JUg>DLaRVSS-4a?&gG[<HZ=46:M,Hb1_?2#+;?aZ,XLFB
K1B18BQQ:-.cTNMFY0YW,V[^bU<-\?YRZEULbS415/;&+7T&\T4.>_c_YX6^a0A&
TSK^H#g3b/<G1/PU82\2=Y@#HH3GZ@P)aSR=N:fS+@UcH1-BE&[B6,a0G11:Q_=+
T.7.H?(E(c#A5X2)+QU-RbXIUTG8FK.a.0N?df>D3)O?eb9O/Y_\M9^ObN3g3?Zf
dTc6[NG7R2=T;TGCDN9fGURB.0\JY-ZdI5f6OMaW2)b4(Ne:M?G1C]=#T=efIbL/
+RZ5^RcB<U7UCUK5f6W^/W;9#25A,L6+K,Ie=+)&,@B3GP7[DU4,WaOcX#KK/ATa
Hg2;>Z5.dd^M8C)9.d[F]V#RFKUAaU+YZ[Rgc\[.eMZFUE>fb8PTBa=\R71e2dSG
XVKX[[W;<6:),UB2WS2/[YN]VG3>ZX_U]:5de3I7f/&@JN0CcJQ4)d<J@1;=QDc5
DOdWKS5?+KfLK2B.eeI:9d-H4L=[,d45E-Y5QdBP.Lf_PEX39P6<GS=UL]-g/;?Q
\cW37.A=JWd;@KBd_/Y)4?0B^K/:H6XE\8D3b5&#[6Sf#@.ed]b-?71R/0gQ@D5_
aMVW;UP3I>b#B0G@dV\G&IEZK8)V;#]=>RKBaHHY(U/CW[)XK5O1a;d=JdgD>bAG
JdTe?8#YQ.R;ES_^bfDd5QDb3BK(L[Nb#e5Vd@C83R--->^:[JF#>2OMe--\.;+O
K#<>-&a_IYCXHK314Y\5J)(;TYYQe[>DOP.+@,@YZDd<SF<WN0E?&=4X-I_#TE,0
L@I(TBXK_HfRAKD).Y6GGO#A>5&/<>;&6d21Xg5JM9K=_HaZSQ\VZ04XP$
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
.&28NO.BA_)Y,@Z0=M2J)3N))?>-,8F<(Xgd-;d;9I)\&8;<[@T;9BCf<,AO,6:R
\QO0,Dd6CX:M6)[F?1;2Wf1U@fAc#J)ggdC&\?BX-Af7[?BN5M@e9@C7,PG\?Y&F
e)8P<Y3U-=Df6b]L1AfcJd)<Rg/,64Ud)cMR?T7g]HTBN=DK8bIZ]RWSc0NW.-_e
=Q0-),F:e26Ke@g+_HD0E-K:NPc?0=f9;#.:+N6C,LJ<M2,SO=<OcF@dP75,>:f4
VOe199?1;8eITRgZbDS+9()&)):^NA@&UI3660SB1MJ1;AaZG4-dWJM(GZ/RFWDb
P&g;\QLI0R<>MWCAOSU?aWQ:1+XTIeNRX<d4Gd,eS\<:[\<;=gJ<K817DQAP+_J<
\+/QYQcEWIT@d54_e=28:5<<)D_2Y,[N^S0g.<Tdg7,M9Y5OF]A,eN3<Y4<9?7AI
B4BFaLC98]36<DH4,L&UbH[b/3bJd[eB9McD3@/)?XB_U&Mf)a31(W(9>64QQ<1.
J-ffO[WI5R51\C\:9D52/[S6Zae\);\0<KC>)V;ZE0T>L0e?KMe2CBF.:bDR/+bF
F][XRX,[FD0Y67)9CWD.YLbKL:5-T+E8SDQ9B1SS4P;1C(IM2C9=1f\03LfS=K<:
]O0CI&+9e0^d5=ZEW+Z[:2:P4KdKZO5cd)_@A?T.Y_Qba8RMMD#])SQ0aV#;DS48
R0BW8]HP_VdggDX(/]DT6TEg.[WYg\_bI4cG0=\6^3A23Q.5UfYS[R?&->Hf;ZSP
4;O<)a.282^GH.D6K.:V)JX79:dR6Mb4dJ;CCCUX:aS^36S@=eB?g_.XIPc]2+>>
0g9P)4.<A?Q)Q8M<]>G@aE_P;(b8/8JR[CDI6/F^(Z6?:>DI2gfICSPF@#.MZfQa
.J/8./JYA)&&GAIg4L3KSAdZYc\X=)/J>Qd^3eGC=;AOg@f\DW.+3JbYfOIP7e-+
:+(dc?S^=EU/X#DQCO](=[+:PD=<4,J>,K,D@V,M7)/NQJRJDb+,/-.1C9P9J<QP
S<eMQS:3?5fd[@FQYDLJY+N4LNB)YbQZ_2e4&1g=98\,/F+XV(e<YB&CgBY(/(cJ
@LSe>d[b/5^<Pd#SI_KX(O1L2fLAF[/CGLBWA6+:3YU7gOS.HG]8A]&Lc=GBUbG2
^T)SIWc128:F,KTaf46\YK&5;f2T&CXFfMN.EKdT)=:>fT;dMd\(Y(B2IH-NT8>^
?=Yeg;c1EXM]3_1OBEda&56CVg4XV17PG/)VZWLASWfIJbBE3=gXAFJ+,<E.LOQX
O7BaZ@SH_R4(7_8>B^=H6C;>6:MU5RGL,(FMGAQ4F.]d:fWgF\UZbU.1,UcBD+])
0JI(a^d-W:a)&aaLLaJ70=eeWZ.WJQ3c4D.F8-(2QJ&:WE&5J@EU-Ug&g5D772.7
K+UF6O@ba7&29IL3MCT9]O:U^((5@c3e\[@&/N#PTNBcRJR+_9)<507Q)9/2DQMg
QVd#?+@C1LCMD8CPGDaLa]&7J@+:R_HeQX1XC&(7<-W(]8XQ=12:bK,.f9[ECGF3
/S73(aMa4YY+(O5K(W)/:]BHXG5ZAD&FH87Y]UO;NfN8(OBA(?DOL8gY\4?CADe/
WI>0Heg?A^NQME4:X-VgC.NGVe.BW/OVSN(K,QM[c-bEQX?MEH:Q,TX?cAZQY5H/
M1H+G;\W6[RIdXP8HDQL(^)\Y>d:Y4EY;W/URZR=DA.HC:XBB>Gd6VN@C>&\CS&d
PXRKV19URAHJ49)]ZQgeXH)DZP,7XU#>f>7X/2?]XMT2HDFea^TZHba;\0/NN)G+
b9P1+,]\,e/U0^9I;DOU._c\U&\94NgQR8Y+CZ5c5L^Z[<P]_Pd+N)G-3e+J7a.<
WK4#Xc.0.gWSV5+?,9/E:a+@XV((e]G?K<U,Da\g9eQM>9a9(7(SOS3PcIP^[gY,
Y>E[+JEXTTQ#.O:bNH2fRGRZcDSGFO)Tf.[=9c5Z1S5,B3DKeTPXVN/8X0\HdFRV
31<cR_fQ#RYWB(BU@HUcEKN\f5^0G,(,S)2=4NLPa<[Lb2,NWU,#J7[8@IfI4.HF
YeCR@(3VBAR_?5Hg8&?N3D4\>#+.fG9/2#8YI_6;@+\(IF)B6\K>If1P_7Q-e;?>
>5aYTfD1XL/.WPFEC0Z#3<D/6TUVL[3EVRcZ2XK7<[6_=d:[8A<0>LDG]?TJ=gL<
CMcQ4=-+ZNM?GG^[;^&Gg=eGMG5G]:2U;52dF\0b=#ZXIOe9Rd]EV3W1+_2_L431
_#2<-?d9YJ^MW(9BMAH[HY)80MG#>HVfET#J+VgVGaW@4gBJAD?Y]Y1VRZ:VPVP_
FVL.RT=SJ2T(Q9=F\gdD3M)6P./W2(\84X4X-dFB9;^Kd/5b:--3W?U,7#)fA0]A
3&Q2cCc:985G[d8U<^&gE7F:Z@:6[?)c>9VeM1K\/\&]/b055U=++,,4(QE++U0R
SWc;U(S:?Q3I9,?K0<88H\-L?65+D_#1V-/9[LZRKbd0+_C?)?<bHERR/f-fP=TI
ad7V7VBRSQZR@CL-WM&;IY\D?/]?G#Ye-fHAYI#&GaW^C2?a:_5MO0MSeROc97F,
5#F?T/H,b]WSQe=S@LTXEK&6Bff.9HBZE^-2fAZ+,G#L/H24e58J(d9fI?ce=.X=
/(5TF];KN5W_PWcfJc6>/WYZEG/;3LUZ/>fXL\K_U#7O:371c,WQID2/GeW#IcH9
g\FWce/JMY/e)0)d<NIB.#6J>9)&OQ)8bQcc.\FF\c<HPNLXD5B?W>?=2_T=?gEE
.-<d\L;GB5--e?YWOcfT<;abEA\>>GV/9aL\]:65_]3H<(6KF4\2/^HIbSKfA-)/
e6b4_;0UA[DBNJT62C8bL[eH?eEOK1GUJ=&6A6dBN[&YHD#d]6V^Z^+F42TSE(:[
\3;:OC;7aD[1\0L<H969<@DNV3cO+<ZSb>(8VKR<IMKN&5Oe.>>1#T[g8FUNQ?5B
B.&M,GR[#R^2TH[#>[Ye[@:N22DSP-5KR)LY)3f4.e.=?>XM1GYOYe^acDgSR4-0
\-:7Id,BZg3a0CbZ<I_GT9Q(OX>TKL.72>X8(3MZf@LAd[&<?X68C9+G2-)7<I@0
3<N^O7_LUY9T6bF)3[?NdH?U0Z\@V,VUO>+\GV>HN#4Ca?RI\c_FbKX(C9DgKQQI
BVU(S>6IVK8\Xe1^eVESfF5?U1YXIY(O(c+.[Na<W=9EQf1^\8M6e#1M^ATN+/g(
c7+12U@2DS(>3)1/5P5HTCTPOOZG6])9[1Qe5#_HNQ^6E&YS7bTLg?b9-d/a7-F\
Q&2bE_/B?eD.0YIdG79?5?V;\^5/_R^.R.U.^X_aRfH<fDA;0cc?,\U.R2Iec;W<
9-FIH9J7)91;>)>3]HSaZY_YI6&H3>,Q\b;Ve:YAIAQX/b0G;(Aa8He]<:VI:f_N
0NcW>JFf:MQ/D4OQSeD8_HdSbN.HY?2O>UbZaZcV4S2&H9#PFcb;VK1QK;LZ9&^,
1L1V:OM.e?7.fbW?\G)WO&>BC0T9gAJ&^<a,N<.V;KK^=GGAW21193d2BDK4LC:L
(9M-R#@)d1WaL/;SRSL1K8[M+--Ib\\Nf[C&5TM]H>I?6/c99E(DB#B/1ec9dS)S
HaNTMd,a>GP=J.BE5X[#A\KC>&YHc&fC\(S5E>-L),7JBc5WY6c0=:YM),cUL?eg
X,4gVJEV<,CL;6DQ\SZ6NV/(3-<8HR.bbF&LT8aHU)V6\Q4&ga=>30-QMKGJ:DdI
V@=N#+V3<>W\5,+E+#K;>YL+/gC^OQ)=.;faQ1gY98[K(9LCWQ6I>]PPNL[=N:_1
4,>d#67O6N.9T8OIMK:>=04=Z;BR0I&4KRgOYL9_Z?(9^:2-82>Q2[(4T#/.#.OD
;B:X/f@,HBEQ8WfM07.6)JN]\X^_C=\XCJLO7E9Q,?1^^5d:2K8,#9[I7OV]UPc#
#bD8P\_)bc)E:3fbSAK@3)&[16+(1JU8)BaVLU\e3(Fd=W]T^>,P;+1-][c(fKYV
R?4b+^A&c,1AW^)IVYIe2/U=S&DS.GLS>=UWQ#3/Jb@A^)EFE-W-Z]Fb[(]U/eDP
adLGJR70V=G<>\)T31&K_Bg>U)>YL_BOb&,7[A2+CDgJRS7cI,5SH[<_QVXB:eYP
02(X)+QQ75c-:b;TgDf6fMf>6^:3T;B_L032T?S6LSI-dRU.E23D>eZYJ(F,[.;Q
_.PDf4QME[T^J2DN.Z#-#OLXJdPEFBB[G>J<N/RMINYN/]Y^0fCHWUg7#Bc8g&d1
1U<4=22C83)1U[EAXT(=KJPOg92Tf8F;SdP>M>HKcZ&DUgSTS(U(9MPK##O)Z-_R
2&_3=V7gEL8_eN63AWG35eBCD=K7J5)f\;CY7-SD471ge7-GOe;R=LaOV6/a8:S1
,.0&3\:O=4=?;E\)8<c26Q5c=[2FC\K[IRXdU<dL^VZUUZQY/[3;b(Ua0;?:=IZ@
\G^c(I0EgMI#[X2E(D.L__O<(WC2ESVC,F3)B+O+@K]-R7CVK53/KI)]P7N/H,7X
T8Ta5668SJD(&/JbJVA;<?D6G7SE_+A]4fMO@J=;0C@SA&VJ<cLDNJcgcbT.\bVA
@FYSa3f,0&>E344JgfE?_6ABY^,R8_/C?EV)d3TN,7LM_Rc_g)b0d@41bZ49cDAb
[^T7=WJW.S?bAab4V48C6Te@Lc]FP3C/cFVdAP[L?dU5HDQHNGb[->L4HfJa,,FO
De=dLMZMV0XRPAaYR1CQ^4(H<_/f7&81U?NO<IL]U1W6eP^8?>ZL;9(X+QO>Kc<^
L33g]5dAIe<L-I095#.?@RQ.]g_-8)KAO0B\\E+?SBPYT6?,0.?2P@@L1DL]8Ed7
[A24L<O6Y@.S3\(eg#_P8HG-,H1MXX7X5<TJ,8QCI,Fe.b=\P&-E^<9C5HAJ/]>4
0F&][gUE+US/V.E)IX;V_\,28KbRO:8+C_TF-E:WJ6A[Gc(1>g>?<Ug5X^]^]Qa-
CC^P.?5KfEG3-f)]Ve3PS;=4W&?D(HYMTXbdS\2SD0eE=L1d?D;IH+2/]@H5\8/G
5g/<&)WGN>)U)f<IdN(WZ+8O\f@;(1?P_?0bb7[-aUTFG^\WAJH(=UE0_g+3B3cQ
-1Tbe-d3HNUN3=Pc6-=f/[603Rc/KEd]N)AX?FPX#B?/Z2E)<K5We]8Mc#,58DD[
S.85K\C/M,&CE8I51<O<;DBOOV(D=^PX#[MUY/F3;U/#Pa0eag73+#e;H?;M63?4
@b#^DJ7JDK=8]cLKO#=F;1Fg9d_e8=+/0K>DCF:-JGUd8HER_H-:IGeTb2(SD\Q@
8/M319S4R0N_K.,#YI6K?,>#C0+3O@GQ,7LPabRV-X,L_[g).DFIUR,\Y&]#PHTL
&CUb#56?L-4KNa:c=YKa?6\ZPV=BCYPcNJ;Z1eEMRd=DJ+=)@\YG6EI=Q1g9VK_T
)2,=YFS+6O>fU#ccE4<@2fGbK,d?+<6O<F7ML+6D_g_+QbKa[?1DQW2RM:B3aND:
fZ-+IFZgg5B42+geHUAJ.(;HW=;>RB-6D?N3.@8Q@KT4N:3U>B:G&RBPAA7K1fYV
F:N,bJ>OF5&9]K=A@a-Dc_Xe[\c4-Hc1BDLEY77^C(2G>3F5L:UL&APc;B5]WFT/
&RFPHg[;5eAgdc5O_YG6D:N;K7F7<)AJS^Ra.15,W<07\6I,8MZLCLb/dQ<\331(
fW1CCT=^IcU@V<;.2KY=40&cJdZ=<V?7AQV1CGP^)MZaV[f?BT1?D:E=+IZW=@.&
cI9cJ)T,VYaK5BMW;f7BdHFQ+ZZD>UKbFT0C.^#W[NK20W]a.F_I#[BQKdVCeV\d
JZg:Y<QN.<>A]JLb(FP^\GMaOQ4^14V5=GYC#-gH>F<[b5T<M+.OYL-8UM,I]6FD
RUabC9[D[-_JF?(.LRaC)G?SacCA+&-3L^@^@\gVQON.\e-W\&VW>\5T4T\KaGf1
DgDJ70+Y(+)]TDfAJML3F#?2@;fF>[5.=DFFUN3Q[T1A1GL\(N]IPMG/CcaQ0X=_
8>0\LaK31_L.D)\NLK5?5@G@A>>Og^Se;;4.1QTG(RAZ9,8aX;cSY5f3PSE.^)[X
P#3=I99H?RR0QP>]Mb3ME1f3?cH7R5N6U@]Rg7-^8NS1bT.eSP_b6a^dg5)W=?\3
YHIF0YKBFQ9JR:KFZHT:N4=84\CbJc,&6KJg#Ydd-NUWSDeI-Y::RcI.cIQcbV(T
RF9SVS3:XL/#\KCbPXea?CaVWRc=U\;3TA5V2[@Vcf+PYBg,)&c-?)6bQ25K<.EY
?LYJXaBU>1^CEC#]G#X53TBY17E:^]H@aXVCC?VI@YMBD\##,#NZ0O#4<F9g1TZ&
OAMPDK_T7<&N;:1H4-16J=9/KUM-(e]U3_1e2[3ST23bM:M8[4P)6Z):&R\^B[1;
#.\gK#0=@B>_)FPWQ<31FPQV-0g?>T0-^MW_1C&TSXL[-.+F8/<ST?5^(&PbLTMF
M75V)af/\9W=6@<A9<+W(PdP9S\2PG<Ag]b<5C6WTH+[S\)@/V<\UgH2aB68&f]U
^+/VQ#=dS(d/QNHGg0=?B8\f#]MJdCDH5]/Y;4[E5MaK2;P])#3K-MDXI64_I2/K
0E=6Ge,Q[ed0L84BCI4.L;TO21CM6c9UDKA-HfR4e1(e#MTQ4AV2ND\K],eZB7[]Q$
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
7H;4[2:#@X6?8:[38<_#8_Y5,XJ-9G38<Z7R9TPg-aCbV2#Ja0g-83;:8XeR=c5X
VM)f:XB/Q<]8]1EGc=)?COTf(&O-WKeZ/RVV02\>^Y-L+BCZ9?E>HMOD#>Q4/YGQ
.UYBOdI#<+HY3,]K8d.9([@0c]I0CWb(Y@//Z:,5,FQ^dPW5b+a;e@1RY4BJ@@KA
fI#acOb)UB)ec-(?eB;geKK6BQ9F\3gQ&^X?NX^KLKUfNDT3FH=F?g;?APR)L6bA
./gQ[6SSXg_X](-6K7>EZVcR+,13YVTfTE>KCa(Tgf)CbQ9Y=?EPU+2Y3>3MNFA.
<,DgO0G6R>);[++)DEe5-:5I4JQ4<6VUb:P;_PA-BgE.?e/D6;7b:()R97KJW@Le
#3QJHLd20gT_ZbOb\]f/,06V4RDGJ6]MN2ec;Z2\A>7PTL9DBO@ANLQUL)YD27=9
DEc4g-F&-T.VWR/A_N&BHK>/8&>L_X-LSb@YSMb:#XOVX?[>M?2?T=g<G=NS/-?]
)UaKD43[1]U4QTQ^d5N@AFBO6dJ1ES^AT^dO/\5a=]/:f^?VA_0g+eXR+Y,=Z4VZ
&eLIY;f1[I22b]-3#6,4MB.++0S:\R@f\9>SFX2HW>8#ALJ36IX/^f4GFX47]46I
bU-1XOJ5D89YAH]Q-15N=?)C1F_VJ8JW88.CD2b5P&A7YN,0)Q2KQC)MBL=Yd_9Z
RF0Y1EbKLI#[H7<Be8P[_H>dTZOEU&YIV-cJZGc,2S=[Q^SUBDQf;M/bRG4#-D5X
P>4CPORY?YK2Se[QUUL]Sa^]GDDD&SL./f\O@(-N-N0^VM2KbND)2@&F@VB#2+<9
AHO[@&YK,aW,15UP;=(f&ZE[eOHKUK/8O=G)-+RP3R@bW?Z]QZ&I2?BgOB57XG9<
,;Y/g>OG3\b@Ta/LZNK5UN?\Q?):=2QK>,Xc23Xe;?7MA8S0^H5BK;O;L-N+EJ8A
7;=(T7Q=;d)UEJ;+c.N+V^GGa?<MDDW7VM_cC:6cG.CROM#@05UKaf&@PYO.N<DW
L-Ac;Ib\aJdgf]DA[&05XF7:&Sc]V-)A1FIFRXFO7gMSf9#&B:\10(K\[L6A[:_?
=2T<,.8:/@g]K\62HWdKCE^)YMY_7XXN)U?TbcPW8O[-8(Jc9/]J_=d=.#ff9+dB
B7YJ3KGbKDf9=L(>;3d&@3.gF/AQQP\UWcB;:R>+9W(.]c0--1_50W60?:9AM6R,
,b@>UC,K[A1e6fJ]Z^b@Wf&9KX=eX:HD?bZ[U7a1#dd&D4I+PNeTV7TN)A,dTbG?
9&5)R6e=9E-NF-g\L5XM(g>AX,Q1&8SU<=-15U1;Gb/\2^AD50;84N.P3VPDU<=P
>Z&d52d\8?QN^Y]RAcRSH-g5@J[d1=9/Q<=@FU)IH[g3)4LD4X\.:C5/@;YEc:W5
aCAV>H+KK#,PfC0/0R<<QVGCKH4ZK&#ZD0/:Uafd,M<?_d7M>Z\d?S@8M3B9bZe/
Pc&L.e0ZDW<8CTT4N1#c:]KCWIA3^OPb[U,a&20)&+ELaJ4dQQZe7,>9=\^@BQBY
B9(>Hb6I(?+Sc8IG+ZJ/eX1:U4@?C.Gba&2KY;65H><gT.R_+#^@@OCL63+5\\<d
9@g\?SCSaLO0MD/ZGYGfEKX_>;XDXM90X>[1IZD[@8CIZ[EGG?+&]-][9KF-/A@6
?V<e[IU-YP=VgB7=Wa5/ZL4WeCV8098c^GQ9A&aG<6a50O-XeN.&5>,bL9N=gIJ;
3LFI;O3#VgKXOYTA4_U]cb?ZYd9_XM=B;/F:bQ-c1P>9SCeTWTLQJYTe3c,]?H)L
R;3/83O^8&-Q&JLcMB@)6P+0I),a31OIdbgf(FL?46GbVM)>9B&#FfCAQG0ND0H.
f1g#Wb]60[C[0)Of10?g?EL]a36;=9=V<acF^YaUMYc-#</(eX66X_EQ6HPb2L+U
J9;(>BJ:SJfV3U_:@cOEcLXXLFNM]DER&KNYgJBZFL<HL&PK,P817T92(fD^>_EV
PNCS^0^4GZ.3629+U(FHKRN8Z;]7FMK@8R2##.O+TLf>GT7^fYQ3UJ#)deX)39=N
X:VCNHaMT\VcT-+CVU7N#&MKCRMT#K7_J8fdMg9AW\@O#K?,D/,6^?)U<AEE5&+b
gMP^9[>-AV#N.H^;9=>6Q[c^C>)H:DB18KDLJ=][W.57d.aO=:=,S#8>N@ENB,9U
9GEc+6(+d3NWHHAKU[KcDDGf9)Dg3VS^+@1R=RUJ@S8UKC;B4PB(YZC^61V5T_T&
L7-\[?3dE:;>,E3^B@B^J9#-S=:c]L#.<[<MW+4]-7C_19&)5H@:QWDac@QG.VGe
4Re>d^2G0M<+#<VQLO#M)7C0,GDU:WN/E@U(5Qb?]>@&d-YKE+_c-B2N@[9R_g4<
7+@DTDd]af22:)8TXY8OX669JY;CD62_+W9MDZBOV\]Z(IM>8KK9La[8U_A<3_[>
8:CISK@7+\6V15Fg0K_(H<,YW?c-(9J0711RKF]:<8\AZ/9,\FZd@XQ)Zb@fLNF_
ec(cA9C^Y3]g.6Y.5?W8>YXF>[BLc]@<Q8b9JgL?3TBFJ)NL\I7@L]D0M,c^_5^J
IIN_LXG7JV2b>-]F&GXR.J)PCYA,b(UNDO#@T>Md7T5K_JPa=?=cG8ZE0HD;FH=Z
X]E,)cAJ-;@95S=f/[0_cWf&2Y=_P3&-]THE)T_J(Tf@[bE2W\7[GT_(G\-A6W:R
<XCXM>W7]RT&+AC+faK,B2@=>:P;@bfF^WPHOaJ2.CPCJ[6^7Y)Z8XYaO9CAN6XW
8CG]DBV(N^JOTa8(6CD48fdgJ/M=@\;P<Q]_<79T:0XXUMO92LfFY8dFAEYGc_=4
7PEEI[M(R\dC5>1TAf-Q>P3M/YE\M(c/_,Z=W=?29^g[2bWMT5VZLDDEK8da.+cS
IAI-QU.2S)J)+QGWHOJE\eF+]0=SI@874+J)NAf>@bTgaSFU?LR#[V.N<M-Q\<5V
K=J./4ga(3OcUAA:JMU/OBG^?#RY8L7a8,-f-Pg([/&^I<5F6A<PVA#+C_26@S\0
VE5EAX.GL>@V2?1I@+^N3AHJaWTd_7:+#e-a6.G8-N(-</-@6QX>7Z]YPI9_V[8[
#R3IEVX/DbRBG#=8Q8f&).LTdDHQIXJ7C?9982Ea6J]_<K,+@34f1KD7W&3JU)5T
81A<1SO:c@F4;++J;H)3^CEL-(-?TN:./\-g7O_:&XLCRH-QB-^IZY-[:g7EQ<f/
#:DSR)\4_G^c<g([/&GSb3ZD?]\;BY2ccQX^+SN-M_dE?9FB&EK:FQeb<I\[1,ef
+f=(MG2Q2I)dfD7,Y-J=;OZ4Dd=[9@dE:?PI<G[;QFLAK)d=C^&\.OGaTJe6HD:?
?5JAG3H1c4J\+&31,&c#7ePB&,(e@EI+SM,Z66a;H/4)-aI-Zc/PN+GaL$
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
?e1cE?\Y,Z:S(]KW9aAW9W)G)16=-^^\9HaP<;^1=5CCU4&d<aC(9],b)B2_-\#K
:aE,I\(eS4Q#E)eA1UgL).#<N]A7CWVO(Fe=L<dNAf_=<\><)=\(]&J]Gaa:>[Q-
)7Cd^_3-YK+?GP3^-ZK^E]\RCA]V2BJ90c#WRDN5CgcVST5UbD-57I5KM:_C_JVW
b,C<T=JGPAScS+2EMB84<)7FE,41;VMQHN>eV<IXA#J#EaJ6RHe4c,?f=3>Q@F#=
d^,UD8dc8H,R;.BM;^b&ER9>ab^6.\#DTX2Gf7b[J(TRgC/UVWI3:C.HJZ+N+eFa
C4[S&.+g]P<_M-LE@TX#0W4&(c@f&^D(B-@M6dO]f>&[7EMKR/ec>E\/2H6<<BB;
(@B<a1_VaOVB\7cUPLBJ@G=D,4EE79:_#;ee8:L<NFXGe1_1]C37+@cO8[2=W=KG
R@aGTVHdFS>DLL3HD&J&2L3XUZ8\g-G5g,[(d@I)Z3)7(DW<K9D2P-)JJ6^WJSMR
TQY8TA-/@9WbD#4TTaOXdMWNA(KCH4aWfJNIe98.Gf<UO>KU_C>c>c)+gEIgefN3
GTL9S?a;9c#9Q_;=3&8I:W2fFR;:Q0CM6DL1HY+E97;g#W<)RHUV:EG,@06PNf:Y
Ke@;[N66D?6@U>IN+#2MU8;g-FAR/b[QCYU[]I8e58(MeFU^4>AAZ1,\Z90ELI;d
f(d[dBS\0gg1/A&1UMA#WZR+-=;VZbV?0,SLXH-?-W1.6IAH(N(IDEA\g4UWDdA&
+eG9[FaGaKZ#<D?^XA@8G>MI[PP^-5NL7BdVUC5L^@f[@V:0QF;OG;<0Od6@gSY.
Y_Ib4,#O&[7f?YRA>.-^XQWYa7=9.I<4W/e7SKe;9N,OY&G78CR<=]d[2eBPD\S,
\+SS0W775&]IMVO;##@&>7Tg>5LHN:TVWS-Y>6<dM()9N)0BSJ=)d3#JA,0(@,:.
NJ2YUR;GZBHCDe\;Z@[=fXbA)TM)#VI3KEA,2JN26cV>#_JH-.\/8A(L.@.=)5XH
/C:<CDTe4OC<.2<:ccC,.:]C9cDG-]9]K4UXD24;;32D&c]L3]fU+WOcJ\NM(<=e
Q^dW\-^G-K3A70--DEQ<^0YH_(97?^F>ee7.>L<Bb2/Y4WD:O=:H-5b6W_=2(X=D
C(1EO7F7;IRV(aY1d0&&X32bP4FIeNdG>a]AL/,gCaJNH:V2&RN^5MPfD_-^)VU(
U3-R[X3U,3_VW?IA-=<Hf40)^IUBF35g1.4Y&9J8.@F]LSG8=7\J_LDN.\L,RN-T
?CWV<),I&BQ\B#Q#KPg^VH@[-7TLZ)C/G_AeCJXc)&O1;?YI+#155VJ;E9>5(R2Q
555f^eeFcZDHR8J2>62F-cD_20eLIID:R<AOFV^93Eg:;QW-(aNff=ZdV29c@>2(
1g[^S@G0-M4@:2>fV3@C-c=Z^H1[^-cU;A?G9TE&?N&Zf(440PVW^@T=CF0:.YH>
3RWQdHMEaP,gBdS->IYKbTbHeC2WReOdfKYf0WbbIQ++T/BCI0QF:[O?bC#BDL,(
FEb8=:J?6Y\G=,a+1GXdS:62+CTZ8QO/HZHKc8R8,0UY&O1=cO8+Kc./ENbdFD]T
,2P1K7J3UA/G1Q8[1a2U1.)FJdJRR0\L:L[\ad=-^dO6<)QZW+)OR,+>eP>ffH=0
A-Q.&G/C,)3]\XN3KQQHDJ+F01b<T>-;RHTPFI[g^IIaB?AZf\6QA@\,_]R;[N=J
ea_AV?[EV/D/N<BMQ(YVc@07C[g;g-SV9dU7,&(N<\UMZX\5)M&6((4baAXBH[AB
dJEF?Xg[_eG_^?+&I,b/0Q#Nd\LVVD>A(Z6;M3AH#-e/A?C7eT7S+Fg<QKR,]>88
XRD);d0Xe@#@SP5ZF1ScN[3^+UFRWAa33+JVFf,?Y@G&Q^BL0+cYM4V_cWF&H8UF
f?FS=19#ARC\OXOH6D^WA/\,;ROBUMU53+\a=VbWb)=Db2/C&<d/I@PDZP+ISR(_
H?+/b@(G1bQ&BY=4,gULXc>KRcFO[1N)0-7;EIYSJ?XX+G-->8D,A&>LW_1?DXOc
<A72E0Cf4Q6+4BR.6<HeSJ(FWDcb;&Z[gZ709)5_+2JO4TCK5dJ]]KQCC(00bH_6
VS<Y\=c;feN;EN(8gKBHF=GN#MG)+8eQD-36NS_XD^TXWJf;F93+G?YS6BT4X76b
YgBM1M4g.IGR]&ME9T5R/[XSK8KY[47-C;2>[)UbbQXC0#e0D#J@TXZLWSXGf/;-
.(RNX>gCB8G^75cCM/QNKD_[H2WH6QX5YeX3?eQG-<5WS@G_&XSYV?\CUV\Z<.,\
WF(<EUU&RXR,6F63T_-GPHK0aH7N6>f:JIAPR\@CLQ0c_7NKM:86Q/8/@QaJE<AG
2OC2Ngg+Y9LHE0KX&aa_V:34U#RKNc<Kd.6-/(&gd6IH#&,1L.Z.X4&WH0Y6AbN5
^?c),JaCY6R51/-_7WaX#Vg-9ES+c=.\9.Bd)@+^(ed(,,]L2TO1W3\T&#+#a8\O
5g=R:X@MLTS@PE<J)_Q6OaM7BOEgVD02EL^NR@ec#01(C$
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
#Qc&0S&@MOc)-Ed]8aO;,JAH,_9P=9#S92&N<K3---L\2@U=-H.#(@1Y=a.+9^NB
C11dcZUdcAT_6]K(a&78,\O-O?+9Y-Y2)C.MAR_6+30#WDeg+RS6b</1KJ5MZV(c
^g5bI&cK^4J7KF0BdBC6DW<;V-=EcFP^V^02&R=&#eaC=15+CDUdd5dC9&Q_(I_K
0KMC^4CY7\S\eUD^^A4_[HSK&Oe\THd/3:VgK&#Y/8?<;gOFN8OEaK<]TU4eEWJ1
+eN<L7,b4_=.P#Q[;&\3?^3\T217=&TDFDQ<E;gM^-U6g0CTH(ZQ,#2E_R>YQe&Q
ZH4=E+&,\F8cH6T]3#dE/TaAL3I6,]FU=2];+#@8EGcMK-e&^T#,0+V,))A@L=Z\
HQ7[8BATNA0?<C;&3I/FU:4_,GA2dc_&ceIg0WPCW:-aDbV=:?B0RZ\O>.5G=Y?C
d.8H.JNgPXGIa3X+7[+MW]UR?8K5(+Df3,;OHH-YAYK2SdT;.8KAF-(;,0\LX8@2
..\9g:IICCWS.N1#A=d[01B:(JXPDN?B.OaQX)IY;1dID<<0-C;c=?)N1bf@AT.#
JH?\A765]V6LR&=#K.g[:P:V9NBNMI\:::B0e=I.gQ4.TN<<\\Z9E-d;LO4eXQ8Z
_,BPdMHHU-VU7PUB4A\;LE]-Z(]^_Jc5-.)T#I80_E+R56J-2<L^S<-BRKPe4<YI
V<N[9:egG.U?CHOGQ\6g2+)Z73EKG9T;[BJTQZa?)6+?FfSN[BO68#.Ug6HZGF_T
1-A.8\.@YRa8]>b@Da<DcL;ECRF8dX4I;+6R)5Mc7MN[aLH8f3fDc&G=DK@0=<IB
f.Oe<ecUV?=5.e41dUe3HS6:B0MCN@[eB3_A1HLHIcbV]ZCd/0LN1#CW1a_TSd]^
F?N33M8I_&<W6G?d:He5-^7PY#=^5=JJfSIMNPHI?78RF/X]9ZTBN>&^)7ZbEeI=
)Y]SR63GA9FSKa&YK9@JGfRfF^B[WA&XY=;b+>Hg5?DB5,Z^a[]IJ=^2:EX-J0A7
=;Y3PWB.+/FAXOQ8#GF?HgZJL65\3S7A6Rg-)aLZ^-9O=g0,@g_(1M<+<fZKg9eQ
76HBa>DSR+EP4^2-/YE?S?KB@V)=N(#(D?2e<7<5g.dARHU-a(J^egYC+NR\@g32
IdXe.9VB0;K;X80)NN42We?L;eJcWZT9/?>C-5>9b]E^<PdH[3F>6;SQc^)]Yg-d
XKXJIP^Gd,8#H,RF[:TMSSM</AVG_KILJ).gR#XWf)GF9A\P_Pda7TTU+cSMF8\H
6MF[V@7gLMC)6H8.SQc.P/<a;GLJ<aC2WY,Y.DLE<IQ/OKOA<ZEWa>R^OG>4926V
CWSOd;&f[fDZOG^?_Af/S>b&65+P#Tf@JDF<(.>K9:WEe->9Y&H)Pfd8NP@:BB_(
E)YD:A23F9D\6N#O9<KGSMZH=T<LC,SQP2T?DdW#?+F8c5GE4(X[_R8:.bYBIB@g
)>X8f2GNTbTd^2K7TE+5FW\^WIB23a_@@_64(_/3:4&W8]?Y06S1BQA;8C_0?++S
W(<RdH#6Q4LQNG0JL8TaESeBO2@56@B/.efE2GeK4(S/SV[CPH=;=6&U@8Xb]Mad
>7=dG;JdZZF_Oe.UOGa#7S)#2G&9XNX94Z_gN4#DO;da5NMZ6LJ9<Q1B@@>8G>)G
#d7WGGK=)TY6PD@Na2UbPDgg/53.0dfZAY^@VBX4J8&Ia?/GP0I<P#f[f)MHg8fT
E8-TU12@V\/8/TfVSK9H-aeB<9(EO:,eF=I(O=HF-NI2=#&d5d/e[7fF^Oc:VA6(
^F&Df9W,5+?8P=&b[(10If-UIe418D\S)#X@g<EEXW)c1b_Sb#:eJSHg(K-2&Rf/
#]Lg=@NcH]J[L\(>-5^F7&g+_GTGEQF,cP2W84QF4].dQD&CH==QEN#M;N/\]V<C
Y1&2P;1W1O(,HRGf-4(abM\KB=gcTeGY8F<E=APEASWD68UQ3>W?>:R:F)K-[fN7
e+_;>d[Rg(UD<QBSTT^gD,3C68N]ZHe;@;FL5<JR/ZY7H42EZ4RaAX<M.9/XB?fX
9]gEdS4VIT9YIK58b,Z\HI.SFJOA_K3KBDcJW-;)G;bDCLGP_TJXd?,(E3/G_)^Z
K@/MT+Q,C#^:33-+QcAZFQ;YJ=E,MBGIGcDb<[E-)#_30-?24SQ/VH)Z95IaF8[@
NA&P<0]7-NOa5.G#6OR6_V7eQ-?a2F^>1)F@_(g9V__A(/Qe\NB^b\TS:_TP_FY#
1#9U\4F+H8-VL>#\0#Lce5?2ORJN5#/;.I8EUdQ0KcT3aAA01>bO#UE?X>Rc\3<J
ZB#2d8K8WT5MdPZBC)HJC&&[Q?QaGOQ</6KM8a1P+O3+[L:I8-d/PZ_,f/[9d/K\
?FMY1PD&:^g8=1ABD@I8>\5UW3\EOQQ]A1L&B=Z^bNR;RGC]?Ge\HAQN;EYXS&RX
]&PH[6c6+IdVUdF9UWWTEF59gZ7+?:.MafE0Fgc3:RP]2.:b/6@6&fCJPZY]WgB+
AdIaRaH/:5B<(X@X5>XYaa[Z]O7CgONYLM[S1aSHQLJ@f[_W0ZDWAE]H(+:>#VE#
ePM\X)5:)]14?d:eXY.7Me>18I5[M+];2\<)F=HRd2Qge_\.K[Pa6C?(?R&bP:KN
\c[NDWIM.Tcg^)VBX9)ea(9SQ(0@^9^\K;#A7BAYE5KF.(eeOK@@W,^gIKV88F26
@4@,I>M6^G31FBHC\1_(HONAXKeRIg;+4]/^T&Yd725U]SG]&2U&:.JI@S5@?f:M
V0WOJBY/(cKg_MLOWAcH^-J[[T_76K4+9FUO=R/4aN]0D>aV3[I/c&^60)UPAb+I
c/M(/6DT:_Q2)U&N]Fc&Q=,.Ha-^R&6BaOe6T2MX4bU5dJ<J;[Z@QeE<S@b+:^[_
-()&R+=]-9>C?2(QI\4[__CcS?a=R)ESS8,_a,=?Q_4ONXN]Q[OHK,(8>f<gQcED
_\e7bF\Z^3@3[Wc[WQ-07^9NQ^0bMND:(5a)4Q\<bTDLbVSI_KS[?<.;YOY1/(:-
X&C]]84c6<FbXgdTS24-=M2MZ@e8=BJeM#AZ@LSEMO\/]<3\G6E0\K^-X_Ze^7HA
L9XUI.,CUBK/FeD^J34S\WdY<#M++Ka#\1.XP1OYFP.^e(++6^HGK;,.+b,;PacT
&)@AA4;[]A;/.LKL=#c<U\P/b@[FDPO1C/_1F6Z1gb#LcI;I33.7ZTRE\3Q+E8Ef
/+-P)?RdA&MR8:69M_cTfF9C_O)&I2CO8_)2&:g@,F?ALXT):)F.IWP7QB8CaRWY
^KeSC(KK9L9S)VNPQc?adO&)D),PTK++a=7a60_;:6g9AR\DRP-Y<>c+&NOb,)-3
c(F-Vb;5:f.&agA==#F^bU4>V1Hg9AZ]7XL^E.TE20XYMe5]@_:FG-#;A#0A(5ZL
G#EdK/U_dAOTIO97^1N&4M6dB+Xb1TbP)2,3e>=+eEfPO;S>,4[b+?Y:FL=XNa?B
&XZ0\,0O8#TE^F1TIV_O-bHfF8,<S&225@9>X+_S=Se&^9&T?X[FgXb0F#8D<gE(
BY-;3&(O9(/MI<3Dc?A<g2W@08\fL,L&HT5H<TJcRHQT)ZNB\WSDf49#_<6fISN2
ETW5WUQ,QZ)/DU-NJ;MB1bGR+e=FWIPI\3\)4^>AB+He2bJ/&_/JHZLZ59^1IZa,
ZT4?:a66=#TT2A/eL1?Y@1^0NTDDAG6\HD<H?)>+Q5OUEA:LZ(.f7g&U/:eI<?V2
,2QVEE/Z(&U(6?/B<PCgRIIO:a7c>cEW<BaT9J5]/\Q[;\9+?REb:@&2<DA+gVGT
gZ@7V\7)1cZB_\6_;J3T\;]d[MDBCS(D>5af4TD)f=S0T:(f(84T-]SFaXecB?=Z
f+(A)^A]K3U#:3E_FG-_]U#?<754[\b7,52g2]MafTU;+/.=e(2Of_50ZG.5fLBb
c]+1^-2XJFD.c,.7#4=R+CF;+bU?CIRa+)3[7X6:6(K66.^&2EG?5D?U@(H.VNRD
[dSOY#A]<:FK?H,V&dG:fI+2;>EB8AL5I_ZVC<@1SC+Ja7eaP]cYL1&<5D_?MYf6
L6Z1&b#DbQ#WZNeG>FRB[?N50T-MJAEU7E)Nf=3>&\)#<YY/5;2&c8#g\C7]gD-H
+>BGU,;b@P?YE08SVab2XW(V\FH[Z;J7Z:A]/bgFYOd;A-NG7KUPSTM+@d-aE4bO
ggFF)8ZZ>]_O>A)(b+Ra.USN8Ff9+fE=6P?/4RPeZ(0^X?_1?OX1:H(A=@C./8L.
Q[(/6TCFF(NL?(FVLa3D4a)LIW9=VIU4c0&UGeS&STg-.,)d(2c1gV=,.G/[9@+4
?0SKJa,2ga1_99&.YSIQ3U^A6[K6KE@UY#C>Bd4<1@ZV1ZHLL;bA9D3KJec)(F9<
_#1AK2fbJ>+6/:<Q-0[>5].QXKT/)aKC_Lea]&YBR<(@FQ\M59=9P6/QF,Q])W09
e7C#HdbXeXUJ+,e=eU-b-7?4/3?SY5eLJ/&GN?#:Y(b]4^BY<1C<+b+&CHOPHL_E
:E@KIVJSQX6RAYG>9Y3dJSC=N[4-cg3KGNDY]V+DH0X2\U1U8R^=/eY#Fc=YY3;O
BWI^@?[^QV=Cd8(WY,T/^d6;HIHQd0V+>^NY]6[SND\4);4;ZJ9HT],5FD]?L&W&
EVRgST>WI07.J&cgW#.>>99VfeZ;PBT^dE=0V4^0H/.?2^1_>D/P\E8E:QE+J3Cd
&aJ9GN@88=Q4F&cGC#]KQ/5BTB]K=^bY>9/fI_f.:7\&CKb)eRP78DTFNg&JANI6
5QU65ZBg(9.]=[ZeWW#GY)4UA([acc8X/G4=Z(>\&M7YQV7Oe3T9Jg1cCDNg?0#_
I249\H@EOGa<D;.dNH]Q_2JE04#0D99B28(2WRb@AcG93IDE&-(9gP2-@JJW;ZZF
VIbG0A@#UNPN)ZLIH:YNg?HM[M.?7/\I+OQ\e_=Y0bPW716XX7(DfM=fQGAWNI+@
?:99JJ/dVAWHUTG.?Q3:YY6[^7.:5:03)3CFN(HZX2:3ZG4+#DQ=K2Y7\L?[ZXT>
;YdN/Xb(OPT;UB0^a7#M9N8gY-9&6bM_d&M#gM3B<J,_;Q@Y02M<\UdF?f56deDW
O[PUM1_?Zbe=D5,TK\-PGFN#Q7[.A2DXJScAeIE8VXG,3@D=2(/7?V8d,f<6;@b;
SEHgQTJ4\Q_1d.XHeC0<44>g6E?aa3@@ZOH\-cE.R0CMQQ#ZF\HGO(GIWC@Y3B6U
G\2RP^5CCgBY..fT6(73T>d3Rf2<X2V+2fc(^>@g6OFTC;YG@:\-ORc:6]5;RGg-
R.1TKSAKVMSD)H>]8<P0814CHGf(QH2<9_5cWQ<XaLBCN349<I)Pf^7,@eb-]@/+
=2DSB3T30SadQX\-a^ABY>_DYa0?AB)[)4S@aA2]G+VYHHcLH23:CY8Hc+6VW>#^
/d)Gg-#A3?_MgJ21KV^8cSDXI.Y59TBY6edU:_HMP6<4.4RJ5;&0]6U)<e)PEaD8
/_bIOSZ,IVB0V_HIEXVV+\3>Z5V-8b5JA6Ob<^V7:,.F]W\#7.Y1JBP7Kg1,cL2D
4PP7==W#d2[,3R4D^N5aEY,-UfG2gH6,^3B)?Lg)&aBJ)X_Fg==(a0,\V)4,I;dJ
RX]WSM-59]PXHUVHH2)R4g--\L)MA7D]]=LXBE\YT/2<ad74cX-M#NA)8A<6g_g6
_Q+]D_N&W^c9[QCbf_9ML9;+BgWO(QN\=+SK[[]^DZ8MeL1Lc?BJ2,D3dT:d\L5J
eAcBXNdJFTEDMad7]E6=b+#/LR[A+C4@3SD&dT)f09/d.5f1gg@L2ND3J$
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
e3dJ8\OQ9+b;<63D9RB[8\[;,_9b<K)5(<,@9MV]7a1//(_J39J(9;&a8^9<=I2-
<)Ig54V:+_.ZT)FW58TV0PaO:H<YC@=PUIJFFWJQ5+OfFF@?;NA/2\@H02C;</O;
;BfZO(3Vf87Z3T/YJWSDeLD6AB#V2\T@.A3WKc_&ed]NT2@QX,7R>#Z;+^JDXO]E
85a,O@\XP,A8OW[,NB\#XJ8C[NO3HZgN[@HRaA_S+2#cPQYQER:<_DDR3e4aBZ+-
-TCG;NOdY.U]DYf-4eg>8(A0gY&L(?b;dgdRF2,g9^JC@=A<L8KJf3E[DP6(?+:1
aH\^R:,bWa->;.X+>^,#?+&SgG1^/]U.P=0O//FA-EPGa@B)Y4^3172X-SK-[\=(
Zf>ME]:&HF]/.JQ;=J=c-[<cFSH9D?S\R8VM9ZW/VfD)2^=SbNH#La#=dWMaL.J6
B/6::[c?HefgdeX+[W&:+^W<(F5AA@_7-+ULPGESS4OH:6)NH+ZbS-PM6AN,6-&(
MF(->B69_IRf(#WXC+EJXRW/<b/?1U(CTV#eE2f7O;G(8N#),c?(+[fU(7)EKcC4
;ZcU3g&Y5\HA#Hf^H>-Z3[d0^(F9P=FPO(6E07YgUIUK#_PS8@gb7VVS=P-e.?U2
):XI0:#Y&_+-a4-;-f.XZT]5GB9.^gN)7P5=VE7-N4OdY<Hb=0SY>e5DMGL>^H>J
&(K:]P)@J?@=VJW;08??;ebA0V-^S)K9T_?]QI+1DK?dC@-d/c&;c(KObSP<A[,1
SA?HH.LS/C[NGc>\NOECLYZP/<g3e:3,R=58VQF6?H@3+V]6FE1DP@KO[,gGE&HU
8:Yg^f)MO,083e9PUH7X(D\@]Q>1F^+FOb;&P5#3[dedd1@e^=O>,MCb:O2S(KZV
)2eHe#ZS:G[Q9G/65_+>)Qb41+L_CTQW3Q=N+_bBHVBE2bg7FP<PB2)EbdN+g<[?
D\B9R:?O;YVD]WHH,3]2PV/C=TR#5LHXRCB,S/X(Hg?a/RV^,/YCP++?U4JA(=G2
fDYfN41@dG)f=6@9@LJDKVL-aO4_gg;#TA_.0a[a6fX9aPIG8QB_I\VN/(&a&H<&
gP<LY?.M@LBR\K(eXBNZ__)\#_H^]6KID.G^.0SB\?PA.#c\?LKD.BaH5I<O&I+Y
HZJR<\]^C1MO4fI]#J>2662@Y2LTdL4gNdC(Z9,QFOX<Zd)YX5XOT&Q)MOYc:CI#
Z38:1K_,)BL/I:U+@RSZ49Y+J34G)WJCCf-fJc]Mee8H3R,@NY2Q6GLUL\.gg/CK
S8W]?Q#/PYQ)PIY0AEI4VUab:A0R4]WV9@_9\7\^LWB4YcNF9^X,a@&E55;RF=;V
)bG6=1-a/O#<6M30Z+D^gCU8=)Se4HRP?7bP_?);e:JSG=^IWIbg=0/6Y@6(>.)H
:V.23,7))(DGIcOTP=SbdOcV,_5,@]8N]b5Z_H5_WSHIMG83_._+D2dSFWb5O:G3
QP13Q1_a>>ed7KEf0[(\),6.cFa<?D&IVX)&]UKKa;Uc]&aBb&gg>RcPPV1?E<SN
6Z<4d\(c;#Y7,_4Q_M[>b/KJJOL4F[Hf6SbId\LWTJP,9Ag^?A)ZXTVH3]g^]T]\
c-ge6T3MWB5(PdZPKQ5;JUS7M@Pf(8gJePbQ4R:L-S/YG@)B#bAD>VI[gP],?#T4
1>LedVLB2A==SHbW(.d_&\D_:TAD;C:?FT8ZSgGXA&aFSPQ7Df^JK7-3:@ZS[\P:
_JJeR]VXO=K+9P:W5.O3U^fbVP4.:A+KU10+Y]W_(P^>M+Ab#^Wg7LSc;#<\dO10
?Y;+42:QFFae5T<&;.-]Lb1U_691\g2L#YC9I@Fee)&Ja2T;/\MEKL@&Nf7f73MZ
-Ta#I5e&d1O9eST.[@P=>N;Nae3P58-</]1e(_NU)?SefN;geaM/cgNP>70?;K?T
4O/J@:R4>AfE##FR.]2^ZWI\>O2I\)BU.6Of?[2M:@0/8((,QL;9dg[:fdQVEJ8,
--7=6GBQOI)c8[927=Oe]XCUDOI4H8N7)NNH+EKdb(4)X6+#)\-Xf0)J;>V>6P8_
0UAAO35A7I8HTR9-R=<Q38,@c#,d0LEOMMOaXCO(_D.F+2b)T_AU?eF(/?;,=5Y;
4ffJUC=S\EW6V[G>:7T^H<NA?V?&@PO84L#Jf/ggAXaPHNH9dbUE&M[(B)DeUX(P
RJ/27W4F]64@P35gX_AI:=5]g6W>,&-^7L=I]8>BU6V]J@SJ\5e3Qe7S)O-)e+_K
T8R2^HN91Q^@0$
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
