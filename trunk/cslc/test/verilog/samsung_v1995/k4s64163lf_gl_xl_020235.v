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

//`protected
n=6nFSQH5DT^<59]i6LQ;2O2ca9FLlV?dQVbOT3Cn]Ui1I:Q:ZSDOL[3=QA68[X9
IEqXYZ_PEg6=i]DgN5`jENn=nkIKL3JW`GLmf[qHUAY6eYK0JLZ_F>g5CA0iG;ag
Z6a6_cT`^K;EbnYFS>Mg0a^JlO<AE;nY1Icp9O18LmpHd_hHmqOfe_H>jq^>T42h
hF@FZ_EMOFILZhGXLfHnQeS1_ig\ThKY=a4h>Eo9WE3cDVFB9_>a=qc4a:[O0<g4
;F9em?o;FXQO^?O?kV0CN7:o\hb4pG=0jN\hkl\UX_TORL\[JYl:Q4\4=;^9INC;
GDKiVm0\9F50p?86VFXGNXYT2iEcYY1V54Bad7Y5CF=K>fDq?3BDUK`jjHQX03d9
O_hcYMM8FTjm1ffTOViaP>DL@U:p;@1]n[VR>o=hZkR69=XWo7F;oAPjlLDUR`;?
iaN9d5=qWdJAU7Pg3_:67IciR8A2oD[aA9?W@TiUqcoLSQOD1nl2\2CHB6<m2Gf>
?hO6]:a=GcCp4fSJhS]CE5>DCE3KmV00Ud8QlRcR[e^q36g6@:ZY2<22YLPCe?W3
;JbNbU@\I<NH@]8PC[XQ193WlX1k^Qh\WO4jnQm4peITbYPcTQ@a5ME:5K?9ES^U
LA`TTm2fBF;dFX6h39=K;[dV_OkDmJJBh;gqm;Y\Y5PpE:Z@oZ1E0c_Tk^^Do@1J
7Zk0M<ILj5J7YZoDpo6o<9LYo<JD[kKm2^cf\89h3USS]\\^WW_TDT;O<1O]ep>[
25l_gq1<BRP?^e7nSBGo\=A;kHP6E9^dCmpo40h9b7?0JA6WNhfQFLh^IA\U[\lJ
PnEC1`;c>XGSQjOTJfNFL>=WD0Ep\o];iaQ]:_>iHX>7DA;oiCO`D>EnMF1HWIpW
PKjg`VqHA3^h;=<WS;Qi63Q[4>`@6PphX>?XDZql0=Ec?4fj81`10?8ohN?=?;aT
eXmI81P_]H5dRSBBdWMFV5S]4S5jEGfR_5ZdRdj11;iN`NUSW3Qje:`[8YGSI[Mn
Rj[amFaaYE=<2d]0iWfLhnbeBq7H8W<g=6_kNl;M2b3Xcgg7eBH]@Ib3T_dTV9K\
=Y::F?g]=nkj9EKBkWFPBNq6aW:Ih[dB`6Ah0kIR0L6lk<WCjEY;0WQPRk8XTN4`
7>[f_eb8Wq>0NXgKIb143n8[IhVk24T`AdM7HG9iXiKJAAiY^Ji4D?6mkjkT@WqC
H\Ii1<am^7eKS0H3jjaGgNkJGlhc0jRhZB3?:QG6moEhQc?\k2c;AC5LlK]UX?hp
:cefVOk=3j]n3OJQ?c^EDD?l8X@Aao<mgkP>Do`;77?a9lB2K9O_K[AO[[Wp7S98
oCdlPeB8;@DE61QQlM?dF>:0O^_4@]imSEInR1A=Ubb^h2AN[KN:m[MD:0CAlU`Z
daq=Ubl=7ocXkecnoOkhUX1RiIfCfSZo>X;hGY7^IIDh`BN2Uo4I?h:HG^JD3oHP
_T@mFUgf0\Fj0UPNnd_f=q<FEoh36_o;A=>:dGPE=R7li5WAF[mhhH]0dRRGmj@g
;^jl2I@1U_U27PZleELEj:j[jm4gN0E;?oIJdMBJOf20[\=R6_2PLbE;N1^>SAY\
MURXjqE5keZHj7FaBY@hZk96nZ=aj7a0hDoh_2SeG\;;OHHm>cj^[UnfFU4[=PH]
Qojn7lpB[OQB>RjV^ia8A4Ib[CCH]jphWP]iC6[c>A4aSkUdacodXWkDUmYGCoeh
WTLlcl1:?ma45Zolf[dRHY>1ESR4=IDXOWK>HPgXYRod^@nb2kkG@YBoU@T2?8BR
hF8EmpdCmN@\f1\:[VWhkYJJ7@_7<7VhL>8ehH;:f8G;Dj3?H=fjLShQhPX::aB@
\KK1ldORCa1bPf[hplRQ5`MLgK0B:Df0qFgR9Ka\UMFZ\7LWLaF4<MijbV@MS>JY
l3dj[Flq??H@glbEkSaKdUN5IClj0TAQDHEJ:QBRb=d7h9IpeQXXc`kRKa1MKbNF
a<f@l;RMO31h;8fg02Z3InDFjOn3leSoZRbBKI2RP@FhOAJ7@QB>ET`qmYMniNI?
CS5VS_GZY[>EYepRgGW6n7XB@1c;F98J?2TJ@BqOf1BO;X<E9Q4EHPoU_i;kbkCC
1JIpM>Vb`Kc6E7SnT`Y`?9k`lDAY2VJ:PoRoBhp^L7hnIG8@QfD`aQEc>pS5I7HB
1c>FAF\>AW\keq23\EanoeFcUU3BjNERaH[D6qKI;bC`3C0UFhQAERLQ6<FnPY8J
[cPooT=GOpTLiW4VKDeFZNKh97eG=S]a^9n]UBQOn2;F_\gc6egW=Zo1>9aGMN<f
^mFn@X4[mY2He?ocYWAOgFX6qA`9?NDk3E4o2Z81mn`E^KLY]mQ2YMZVgK=;:1Po
O<Xb9[fnRIM^SR0RW4_=HU\A2A3>635$
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
7h_5:SQ:5DT^<QD:RfV21jN3FY>[KmRA:O2jR?kLT[=lM1E3CCd>TI4fX<co0L;p
Dd5:@iLl28XMZ4^U7l=FDE]WfV0V;2LWYbKY<4iBg=OpO]<T9YCaeF9A1R56Dbql
_MS?6p5KbiQ>WY_2gga8jm0nE025epD9Cd3E9YN]hBMEV3JSA@9K0?]gKZBU:j`e
@LPm]e2?`XG9<q8k5NPPf\SZXN]@^<UB]FhJSLFIEG9S[jmdA]47pPLhPm8qHm3`
mkS4XD7\a5H[l5TT;4WAk?=q6Volk_o;gGBoV>BpGc6Uc?g3giKZa9DagOfOcYPK
M>SPFDIke1XT1mpAaCSCbJ4h^O3Q<d2ICV??LI`QCY7_JCch3dQV^X50m2Hp5bUB
D3\9Xf7dXDVlj2`V8:`<g0eCnQoo[`W?XE?:c[I[5Bkn:g<hiFmmHX^_AN0qf37E
YVRpJJ=Mg\8WgdnUPg9=I1`MY?TRb3gY`86W??R1RNKYU:MKMIY`_UlUbZm4DIgR
c9JqKG`DP5qC_og;lgdNl9BL\5i]a:0Z4Y2b78FZm5p=<]bT^Enl21bI>h8PO_[4
2:Ef@TH?1Of4kEl=0Cp;KPK>kfeiUbR<3V92Za^UoB8GP?amd_X6_lZn07XUFR]]
i@YdZnQ;I?d<15hqPi^1`UmM371lKCDjo62M:SgPhRoT:^@6qCR390EpBC87lB[Q
CAhikkkdaEkjmh\oqZVA;Vo?VAFo`ci<5FC:VMBdn`e;LOR9f:8XS0BQmD^NcCZ8
Oa0I7J=p[iK7K<XggVAmhJY^7HYAkXlFn0^f`2I2_`9q1NXEDM;ET1Fe:n\\4_KV
b=q8mlL]aqMl;m[`Dqbo54CGKJ?`5HPV^b0`35XMo[JjTJCTb`53ilTKU^O5Dc8^
7ZD5iOm<pH^kXBY:WBAWa4oTXbX3BT`p>1@cT_4N:LR<6AhMhL3nUmHg3n4Vl9VY
O:4dVJ38l[WHilApc<`BHGgkKTYTc5Q;miWWingpN8nB=5e:9bDI^YmOZ0`BdDAp
l8HLkcJ0>\8MXRHRDZj?Dn6pFAF\[c3;\41f?11<LKf02YpnCbSlj5nNEamC@DgZ
_ijegqc?MhPQ]Cif[^D=S[BLW=MRAaaNA?eWAXfT<VTmqjLVZG=LWfh849@U?CCG
J0CpAjbG[0c?YaS\67ZgGW_29^POVCHqe8gLh\ChHSm;TB056^V9GE4]3YAp2gR1
V7j[;>Wf=XRMojTlaXTdb3k;qXQD^:NCP`]kK=S=JgjnFIm23jR;lpl7i;F53Eb`
lOoOe;[N1TlBk?Z[;p0TGQfA]bTo3@:fTcO1ElMd]F^O<]2@IqLoDfeEO12^JGOT
EP6^;<fd0DUC6@N75cGD2T;?K5dh?^Ca6bAX;GFTpa2]e[BR]oC5UHPKHmYU:B7C
<4GGIkJ9Aq@\m6;>n96?K`W0?9^]9oZnaTRGHIpVjm@]mM^0EWV;eBKB9>CfoAkW
j0i4L>Q6SoFa:fhL9j_ScL[aE[GlnU3I[p@W?GLVRdVao:HPg=4[ilCliTVe\a1a
IlBWqYSD:nCqC_WeB2pC?1WE3q_:B9E6pD6^8Y:TGN6>i8QB7Z[k@JHo@i\`dO0O
qPAnVL1Sn^Y:<LI7jEgiUJdm]9`nn2PeB0E7L1i6[QAcb;_kdAE@WRMFYL6W:aMk
Ua9Wk9Hbq[T81[SBXMM;UfY_7IoWlGM4CAMfcG<oq;SehY3g@@LQ\4C\cQ3:D1Oj
f93aU05pM8Va@;[UUeT8H;fV^dcnmEOSRVG\@Kqd=`K[_d4U`lg8V2YF`_q`c6d?
6q9aOAB1p@J53EjpOcAkLmqag9=X<km@^?n7CRjVS>Z6B^JoC[>>89bEQ4_3]c\`
<dgM6?_@aQn7ZE:>i`dKnpg3igi1MTKJPSXHNY;@aXcI9kiYHfj8Yp2;5iWdUKge
Ok[PXB9]JIeXE^_lf3TH9qK;61<:dl[HI4SGe88ekPd4giP5SNbLqgKYWB`oLRe^
g5[Ka4BQaQ5HggWVMc6p^;gWM@>OqW0eOJh8p6dll\`ggXgd6O^Ug;MVYkCT=4?:
f_Z4X1?2@j[4j<\>Xm8npn86h;=pm`KYVN:p:E\F=MC2iTK?jQTIRTXa4Kh;NA^[
]j7pIHkQN\PaLSDeIc];91a]?3[fADF57o@q?FL>LGjklF7VmG8Z^XPX`\9dD?@a
07qTkmIoK[R3ES29U]2kf^cAk6Q50=kD]qaKJn<h`q5@``HR<jdk?_U6inW>5]OP
]?9n^p_68^_oq1i<2efoqo420I=S7d6C]KCNbT9L5YL>3qR18LQ]8f5Ek2iboV^X
Qe?PHn?Hl4_hp03TZiPA?e@jb7]cL;A\OXQgbP@g=O4MD?cpH_f1WoQYb<0F2>XO
:Ym^IZn2k?KS63[2M5YW[kD5c5R53hQj;OSdG8]Sf>Ug8e\qF>;APh_o6h1LPiNW
:LE=i<WSBEa9jf[2pkC4OS4Xm^A`P>NBi9g=Z0TKY48DY;^g`Pe4F_GRqfc:NR8;
58ai:3O\@Tg\ka6Bj0l3[4Y`;6hXAhnSIpoZ^IMKIDI6iTl]nil78Q`nVDQo9G]n
@I70gkq08Hf1WWXEWX0BUj=iNK>]M9@LY6YM2^:l[GSqR3IHd68kT7kB2>IF22;o
1b4e1f@nN]i2Ua2Pq?G4S[D1eRUaV=dC5qHULaSV<;SYIlWhMb5[;SQ67jRVg:MK
[96Ifq\ZWk^[Mie3V@Z3GjV0<YMY7N<B@o8n^@TCipYDmYGn5lW3idQ69UOG1He=
nL<hci9S]=UT\ll[hY7kV4liJ@>2H7Ko@RSMo_pEKOnk:iqg\IZjML]4F@YQ@cY\
mqIK5YJcgd2H]]:^:leKiT\^\USGlf8QqaEIPM;8_a\?b9^`PIU1gF0ZI6?`_?VM
p_kLVIQYgP4`PWjEXk33QT5<:MRP1@e9pP>_0i2Gq[]I1DEY8IDWkgCqFOV]lQYK
VMBQGAD;;:?aZOhb43:^`E3dlNmp3^4`\FI5K<oeVE8n`>O4g89ook]WgQ5<4eg7
pHQ^TR[HYa;C;L\JL6kS5^;VC`5K@S^Y8\EI=l8lXiR4mL^h3^3o0TO7QD1:XaaK
Hm\fgLNCp@JUBH:geCQQMDS_P1ORTciUn5d0SXZmEqMD3jj^QpB`ZIDoHEeeWo=N
JhPG=d<^7FOkXFa\OS1SJpfYXIVU@p^HAJ@Wd56F40EkAU13LZicOTolcR_fjP:P
6[[@RS\Mh:^=AYj]A0O39CR80;KJVTOMHK2W_L[<4BEV?40nJG^aPQqgCjBeB:Rc
O_BK=5``_D2bbq1`OKM1C^OheQMGIn6ac\c?f0[;=GpbRahBTo:onGHNSmoDApJY
3GUc?<T<0MYX:Be`m:PW\A;<WINh7WcMRqAPW3OV^O8K_TSSO3[[AP@?8efibS=Y
LDFZGoT^WKA2Zmc9EZGkIDR60p9g1g73HNG9AIg8]A=]D1Y7mZjXW>Kle_l2?Ghb
AS[KSicIG2]8IW<I_4eG@AZI;DFWSW<Cp2XHR@`5q\<\5J3aGRDY2XZ[d_@2RG6<
NOmj1[j?`^anH>K1hpBEUl>S[pV@`H7NEJJM:\c_U7DGjCVA0BU:;kY5[7XA\>WR
]4^P2:5b_\6Zei=\g1L>20PHqAS\_^lBh56Z35XFR7_P6fCVPV`a1onm7G_ijdmX
:176bmbJc:Ji=0`D0A?qanQb]l4pcQSH;lUC4kd7S@27Kd^M;Vj]MgKH7M\i>l2B
Pj[;bjNlOoOM_?0^h4ciafYKh3E_Fi=IY;S=J]@WKo:LOMJ95^[\SRXCNOKHM9qD
PS7b[dpd<RE4cM7X52ieadZQjTap^[khQE]9]I=Z]^ZL;GI1k\UO[<=3FoC[RJEO
>HNNlT[S2BERXP48\6W8EN_7mRIY>NVHnN\gE9DP9J=2qO7L\]aDqJXeQJ_9iCn6
pU4ob:8ap:=cn^ogGgJhnCMFh4Jn1hifYF7WI]39dY9H4\FmpjISHA_enQO@Qc]f
HB\K:NNm?FG8]j5>RNk9F=^0R49RCU\2nP4naQ<pn=k[3<9aGkcMmT8bQAnLG4\0
PB>K]Om$
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
ITonSSQd5DT^<2Wag]cIFQe6`eYg5HgD:j_=VQ0NTEiV1gNYKNXibjo4GBLF9oqW
eEEElLV[@`hZ?SjYfiI:JI22hGUq`m:FUTLideU]I5\Rk_E7o@`:_Eo1CbaZ>Rh:
7>=OIFMHAcSNH^9cqYUYBgTqFgIA5Vn@QJ;;iIe2]BNJ3k\1kd\Da4[dR7OdR^gK
7P4;>n1lb?CDc]V[R6qKkjAn1\4:Qd>NER=]m^2TfePM=kQQ_Nd9[i_iOe[I0?]5
G@TKQ\`fW@5?H?WY7h\HF9;XLN]g_Spbao=MHig\2PAV6WqWabbBSUDm3DBDk\m1
c8XmJpm^<3LZA0]i5N0>VKYPh><DfD7g8Kb629<V]QTjHlC?]>7<W5?3WicajpEY
61aZY8iUF]AK?D[ijBJ>m]0HAgg7?D3;iSJdVQF[?GD[]W_AYZFVZ484?PH:V<5T
KS>;A7iH4E?a`SEf4qc7f5YS4q]60\7PdJ9<:jc>L[=aEP6Fk?m:iOp]BikGoo@G
o1>IW>ZEG`5Z1>?EdodCMI:62q9bQI^F^pjPC]l?>=NcYgLG@STJiROV]h2ZhgKH
76TDNE9]k8nJD=TBK_k\[RmGk`q3Bcg`_Hc9BZ^O7FT=46GG]2_\fIjLNmSmf9Bm
EonGBjC0<c6MP8DCoUabj[>R\WOfT9?5P^RLYRO5aSOPl2cp>NBgAkGf5j1@0f1h
@Na3^;M;H?bbUKXQQgEUnKL0<\Ro^?5i1gdo0RiK:>YYF;K4K2p;^caLc^q;6CEl
09ZBB@Xf\IJXaTYQoZ^m4H>5g^q8YVP0iYN>C[o<nf`<n487JC5_B]DT520NQF^3
?55`cP<LgEXj00@ONg?p7J=AR9FV@`Y0:9A?=Hh0ESR]d]WEn17k\W=a0abBP4]a
R6hlmdW;`RCGTZZDgKmbjcXCUFh993M53i`aP=MHqc``Q9U8pG3PG>I^Z9PZNJ>G
JoOd29<do@\IoZaX>j@`GE:CLmo99IeQYGKNgHNk?qW^OP5X4jc@3YK`3iFeDe`:
aLK^SO8k3pbce7XlqNd1CcaBVPcIB@47Lg8_8dH=HR]cG?<g0dZ69?NZgfgH[9lo
6jF[=9[WpFhB9D`ED1Oa0jVWOG8^LfTPJ0Kk_0W:5e8Kdc>\Y=^Eh>RQb2R5BFOE
DVaNalNY60_dRZjm<ii?`PaO5UJ<pNlFTO=`p?<mljKG29GaVTlii9lB^f_IA^K9
Ap;K`7[6F3FWAJHY=0O;L]IRSn2M08_J6RBd6]^12\6JD?jIn\IJYnjb5Nc@4A1M
@_4KDp5^IaaUcqHi66A=LK_]_^Tnl<IIldHjcZ3JcUiZ@?Ubn3j>PecA?g8KJVR`
Y:4<8a[3Nmpk0U8QbM`7>0=>Zg>4:02R>JW52OZ;HIk>M]]QL8Ve9MY90N2U`<Q]
^UhD1lNQgDf5^_BifYMN95IVCqXV^JTDQ>k72^be6inFFIMm=Ul5?feV<hY_<35l
eP8d6XDi6eLP2\ODL;lgF\MkgRXc<bM53jP`FFhYGLA2^O;o`l6?gMOoqaldaYNh
lWHHeIjJP6YD?Aln>[BAC2IbaoKhT1^W2:\;PMDN<:73GMA_?mMGZpH@5oXgdoMk
p]FE]Oageh2?A`P`h]X_oMV`Xeh?DEeFkYOB9ioTqc@5:VH9Y?SY1d6SFa5<?g<\
fm3HD=N7k?0Q2p\11Q4gSqh8]G2JVNmT3eGTS8@JOXij4n4U<5ZgL?:K4U2OhUg@
_O6W@k1b:NmCae6\236U?Ip^G^1e\<q>^2S5DGq0^fiCUEcGlDJ5UX[T9;MRTA[]
^SXIhPTq55B5RiKp41GI_USX5@@ee`>DiK7><k^6XKG:J6\4JLh2BkLUgXbMpPP5
m7XNj0Bh1IObS=F8MdT`pnSm8dTkKcFTGm]ZRXSbhA8kBn2=kpeo\Vk<BXI_h6im
0dnM2Q]=qGQjbCm6__90>o\5Cc<F8pFG@\k:4a4k@EGk@Y<IJQMW8EGWeTI^4>PW
q;>gA==VIhk56NYaeniCH<YB[i9_jl;C:cdpP<MeIoM`Flia8S[jgC\;@=63d9W_
:AGFVo>WS`[GPNYXNoJJP8acl?dJZ`:b>:]d>0:pD2fI=RW6TQo0OPUBN?lDE^CY
5mHq`\0mGfFajo606cb7R;4o;68`T]ad3JFaXNpmHVJaGXqkij2_Qb\Neha]0cdN
oX7p@XWjRF6I2eoE`2m3`O0clN`qa2D[L38fGa0EJ]6X63aO9[hP=GlDSUf1`SfK
<n2MX47ODQJUMKkAV`>EohEK39mYA2g7^8BWB?6KBB6fWUD=7g=Tp07EL0c[;NHE
f=CYXkboiNIHZ]gp50Gl9f;qCPVc3aC;4T`\C7Cl?69O>QVGDf3c0[MU85E;>`J0
ZZBVNB_F[jjM3_DIqT6f7I5EBVGS_H;3;C43Q9GJdLjF66=RDDhdpJo\S?b[F1;k
]HGd?K@^[2:JZl_JAXFOXAD5CbocgC<Mc@dNd<:dXk;EV[h[2<96>J8hO^Tb?cJg
91d5J2]BF30kAqlc87n6?O?92J7VacVHp050;]0E1Z:N9<R2MNPH`5El6n?q:?ZZ
ChgF0\<@T@[H\QMJ7]5b9N;^2hm;kaSboWRa?RkBFG\Jm4Q4cTcdB3kI>>[O:_>Z
e:7LpLCQTHKhpob:8C7^_>4TiPmBeH`GE\2D3:;Glb@bH<V=T:@1\>l77Kbf[NVk
d>?H?QYKga@N\5lA^Zjm_aMeP6>mTD4RMM75JkN?2OT_Fe9MIGL?cihqPQNXO6YF
O60``R^0o9bEh94FeCpQl_21:aq300RmS6?8`;EoJqIJaDTDLfVNS`RB3Lp6IOBD
m:CBF0JTHSZ9O\^Af;lYK_b9jKCF8e<daKmqND0NSdK@3i5O7]Pljl>`lC]SGhjI
WP:mmmU]@UnLBk>d]DDE<PjJXPYG`X0^7ImA>3Bf0ibeGmCV9M\ijoDk@`:J^h4?
?^T:EQj=^1njQQh0b_qZ:E1`GiW62G@\e?FZ:lMTRQ[ZEqBYBfenJpM2OgP61HmU
@8T;1<1MYQaWQ`o0:97m`q<6MAZCJF79:E\0Pi]K[:\@E3ijD\NbK_]@=^\QWpKl
W8Qk^^iQ31C3To@H_o`mRO9Yg95RKM=3P3RcWZai@RMMEATe<_AKHPkj2dQCi2R?
W86Z0J;RqH@fKf^kc3S0f:XBFHnoO47SZOIdZpN5GLSW@;Cj<A<Q5ZJcOq2E6dMP
f^YiV6jlh@Pl^W?I[1X^B6W_F48BhI>i5W3HLaQfl\BWAK>M1i`GXOpn=30=T\_<
K??PR5LG3KDb:4D=h>AOLO183dpiF=ZjjN54XdXC`c3PBXk>;E5BA:2KElO^G=_B
Mki=Wi@SYR7N=bpXESIYi^Gp1h=oMMVZKW8ih9kJPCPc:eUmGmbW<2WXBeMkib3m
0@XiYR3g6T<]]RgW6fbYB;pQJ7<nKFQD1HIZIgMQKLqoW0bV2GogbIbYV>N;7?UD
KK?kIV23X5^K\o0?][8aUp_0?l[6L:FTU\40491j[[9;@TL<Tf=lZFKg1HGHH45h
qgKVR0P@JHFQiAWGNJ8RYSAI[9J^d50C?eHbH<a4RZo[9YFdc=DSq?jgAE6f1`OA
7P_PR<@d]aRC>Q7qDFWRPOS4pmo7AlXI:pP4L<U7WWgU1T>jS9Ye6`3eD8X`JYU`
[TqCS_f9^0ofl]m>2<bL05VFYqh6@ZDLRn\3MhH9;F6>J_PXYIGA<KP81[doD>@O
0B4_BX5nSn27OG=I8Vq7B7GEg<q9\LcUfl]Q;`:<Z0FW>7d?k4mU?32\8PL^^fJ9
Xc:MC0?\`\]1L:k7::Qg8Y3KIndATnJX:HNnRY2;Z[^?lBl?]<fjT8L1eU?e`?6m
R;>?>MYWdOD\l?ALcoEcL;jgApPNYjD3ipcOD<S3SJGO6Ic<E@`i>WO0C0U:o_F<
M>bF>X2A4lWfPKd0[HFFRTiClGIA[XN1D9cdRn3<1pRVP>JimEmbX2XB750SdbAX
;K>_2c]Q=L[H3dke4HoB:2cK_`N]WHK[HVKofM6\52KJCOiOOIMF3HVRCX=nq>N\
EkXNIa@OUCn@;cOP^ZBkL\e1o]`W`4Yg4lcG\he66:90AXb]TY7pgEe6CdAS[7_G
elKe:Q08keIgqGWo1n2Tq;IT^7\\7LFQlkKm1L;bgibP;Whfc_UU1e4AYnW>\Aad
jILbV[Q7l=]B]6L4kB7V6PYU:XbCUZ@VoYIS^LgT85bhfd^7^ZKUi;j8_>nXfm7H
QVINa_j0o7Cb_SLNoajg5Y3Aq?>8D\e3V>NJOYS7Jf]SJMXkeAiiHdjWOPkTO`[X
Q2R`DP`o^dGFbEffkKR:S?9V^6Cj6`Jp0GQk:Zmpm`_Am[CEJlg4S]YT0Yb9N[00
OIe8`\5DLXgi:hceEnpd?0[IPEhaUlaA@;N9HP^@_FTL2mRd@?a0MWNoWjK_nohU
b\R\D4Ob[61H\S\U45CV308B9_^Klpd57_48K4?H]of6b?CoOZlQZnUZG_[B>n2[
F6Z4[>6ip]=HlWMI0E?n:_f@AAeFRb[boD8C`9?B[MKe@qkOB]?;lJYLRKDS_ooe
N<6P>d<_QCU9mQq3iai]?RQW@GJ>SJR5ZnqEZR8LXLq^d2BD2OGNT=k7U@ZDZB@5
[<9C;aTXFhg^_R[WUY4^KgkYI]Cf::@>OU6L@Oh\0\O1Ui_X4?FU]ERdCe<>CQ_q
Z0Nh_;>M]fGOG3O6PBNTK<M3qZ1?SeDVq8^N=[_]9e6i6dgbi3]O_<Fb[?<3OC1P
BTj6]]jIS9ahBWPd;E>E=nf\b\;5<BX=K2<FCILMoLK5mWd5DJ=eX2=Qn?aY2:@9
oUbL4HAYU=fEO=PdE?K1QC8I9fG\5p_0MZ39eqf>U5jnDZ:ThF\kOVMmMJWDI2=E
EKVo[TEd]0>>gjBgPY^[;oc\>FUaIZVIHaV?p^ND@fm=pHDfD>=qk4HVg7AqKZMB
=Qi>9NLY8IXgfY<CblCGJh4Vp0Rb?0;[1U@c11fYX6Ucep`V]GQSgYhdcJHfj2Og
@38YMOhf]MTSm0q;T:A<B[qAno<X5g7SC?[;Af\B[`?YHDo>TL7JEQ\;Xg06kLc[
<Q8bSg7DVU0nJ37ghqaj6@6<?L?o>AUE\8pY\4gZcfq977D@LV\JBHM=8ceMaTYR
YM\gDWn8h8OD5EiDD4OXo@Gq]2gIFV^2<GiKSfOn=SZQ>FQZT]imqL^nRQNhYmXD
>k3e7Yo;qD0H1PiXM6l4kb4kA=:3k;m9J8Ggo]QN2TBaq2:V0^L`<K1<21I`MiK1
229KPnT:IJi^L1l<ENGXZigRc\CQN4bhp8^AaZO\hpSS?Xd>Si[_LV8>4aiDC8km
B1<i@56QY993fK[nq7Y3gAkcaRee>;gReaN9pLG830XQ;j5HZel<HOGTZF61NK6n
f>VIe03`28F<FgEpV]iA3O:;MXEgnoloRHdMLednh`Pb>5hfaVQ=\4Lb68p;2fXd
\40C<4LQ4HG67@UJhlkm=dEUR@gocj_C7Ci3k96N7J[5Mlpil773GfBZZDeab<n[
liMRK<SPT9WiNMOYelS[TkYLZEpRl<5@[f7qgMYNT]_>q<VnH7IRM0RRJc:RqmY9
b\d^>2ZF`g^g?E498Tk5WE<o91XD2EN62PL6L3U_a=5qYLEmQV4:q;ig@<9=GoOW
ZQ7;[ClDChHqG\P`l:np<>QmP3aomATlJ5^GpWncR?VhBYLmjM[0iY^pVO^H_FC5
90Zc5BLc8kO7:TGbX\gE6:o[lY<<XjKIc;]G92l^pU9?:GYoqfESN;KPiO?XPBMI
R=^O9d6Pm221cFJcUGZKLN]``L52q`BWaIDbfU7[CQ_AHXdQKfM8Gp7mDJ[;7i2G
NoU1K=B4TC\45:YmmJ?Q70]WqO5F:7_Qp9U?];4;jc5TQEjImpHC@H]2CpiCV;D0
8ID46DgFc_JiW1Q03_h2:cBaLLalqGm\;HF_Z:BM4]]IM>V?q>^?<RH]H6^2YGd>
>aMJTOeMJhhNm>@A7pYdjnljRpU3dLUg537E7FMKB?G7lqXb8MJ>HgF>XPg7k>Fk
Y=h:bd^X:IGHLdkh?odhk2h;T^nC6MJXBOSA^:b>TTUHM<JXEqESPQ6[jbEeH^LZ
^Wk1g88Lk=X2pdO0BNgnpGPKgmB0qgGXNg6<JhJ[FHSZ;FR]]`;lG>8\<<8H@mJM
ZeY4Q9G7N<X[\[dZ;l943PL^B2V725IY?Jf;0_nJ7S174`o^\KG=_h3QK;CH@<\d
;aYWI\2^p4;Ig2OOqEh07?IpZDg6JRBBb4hq1]<DaeLoFVXISDSeUanOQoAq42cd
KOB\2OAfLBQ[g[b4jA6TlJjiRbJnC9do7PQcVDe@nbideV0DSMGE5oCKlQ=iJ0EO
ND<jNJH:5aO0n[MifgT7Gb2H8Lk=9lg9iALXVN?oX:9pY:lk>4Tq]BEFLi9q3kn:
IZY6Uk^44VfHN@]M:[`H06pN\Ol5l;p67:o50Xq;KOh:kV;h>mHl>O:Td3[R[^:h
S<QlET4qR2Vi<g<3INKP_dj7WEO7PcF6NNQ;PT>:MRR2D7`@f^kAl;eR;8;iIYTG
qMmULITIo24]Umg1aP4qmeTdon4^_VgYVL`?q]Sa64LgqiAWfRc5>f4O_E3H2GPM
?O6IU7^Z=;V]D8OqVN:=;IRMRhH]<>KD[cZq`DYUhKXTjmlDGO1IVcc0?i2bTD7R
f8APq7X0D_i[pIK8Llc\CIDZ0`\8[BPmpeQRgBR87aMDl5>_M67oZBEhFV9pQa[n
nFIp8m2X2aR@8kig;FC_`Lh8bN6M\Q^ZXC1;jSNn6Yl:?IT1eCAeeLF^POCp`AC8
TcfpFTZAfHif00ZhEF_GoVb4@SROK\H^cFG]GNhEh=M3?Xc>K2IUS\J<8384a[Z^
bD[f[1c27PX?R5T4^4C3`dD1WhjDF\WPfJG8CT[2469c<2?q`=0BMD5q6NloZ@Q`
YF7JRXeMp]l^8O2IpkE9A3j26`A<NN1`_dM>PVVfiZeYUKbMVOhql6kNDa<pJ1iO
l<<eJ`_Fh?RImeV][P_G;<OaZLDbC^fXNNa:<FIqFNcP^53h>jNhaL5Y^\K0n2XJ
m\EF[Wk\RYlCQXkUm2BDeOchS_IhdjPQ1@R909:pRoBDP]2G45]Hm@`;^ZkVoFY2
JBad;TRoHdlVp6ZcZ1JC1DSLd<>gGIfSbD1AZ9U4LYGO983jkAdROqG5\=<@M^V;
_4?VI9N;o?M0fcV8]]`OlWBVH;CRT=QcGmfOP``moEXB]4O0O`RCU0Gmo[DEnb]P
802lM`6S\YjS]P@f7dO?4RUa>NNdIVaKA_lJKBI?q=4fZ3@Zq`28N1[C`[a8Jod=
3DlqdZfHT;fGEOCW3>iAK?padg8mc:q\hcd2[FV=9<iZ^BmDTk:bc26<[5e0iA[U
Yp:l@Cda43\f>KEmDj=17=hg:\?J0mgg6U9hEn5]CcI9?\\EYk\fViga:m>lV72h
0PeI\`D_4lEkb9b>I^CQcg@aTm1h@;Eg`kM8g:MjFJnPp;0OnBdYZ;J[<Hh]V2f1
RP<GO<<`n^SR;p7haB[C\_kmO=3Tj8LTcD?`MaFE81jEU^h]ofkfnUk^ID_kNlBR
SAS0l>HFeHd?:5Z[mMPlh^M\`@R`VHE5eE>[nh`I1N[L<Wl;f]gbI0d>K[mJRDhV
gU?TF:7Y\Mlb[n6STpUhYE_8NfWHn]J75W8O78F897<RhRLDiZD2_pTDfF=me$
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
[Q:NHSQ:5DT^<2hYX>MlBKmkAL=@4Tg]_d]N2ib0MVH@AS\iN5Z]0f?M_bDdpmDK
Pb2ZnoGa=M:YFNG?dDifAcbCBR83acH0;<]K?AX`\KQ>:K<@Pp[\F`b[IM@OeL[Z
dmM=nCGPg?[<25okhoG4_RaH?TX3G99=q_V?_gTqZbT0AjHm`6Y6Ol0l_d2iciBl
Q0`Z>kHH1dBIhn<C2FF8qh0aA43Pq@EUe3L?04Q5aTYUYX;[<IZRnJPgin00bjJX
g6f@@LAS<pULVmH`1IZS7]EOUja@:3FTo?E]leljBadIgcqfn3N97@pB3W;dmAU_
gARWCC[V]EU6`?PQ=6n;Jp\I=lS^dCjg`;AR^6jVcGb3:o`ZFjFg]Q[b1;q?;2Sl
]^A;iHol@f:1d7lhM>A5:PNiH9SELX]d39FJIDA`Hh_`V=c7T8GH>79[X[KfJEI9
FCHAAM:Mj3np:QY@<R3MRkGVV`o@UKCA1TK[8WJ]LQT;PCO8Sc?5DnWmp<Iof<1k
f>gOYM2IFg`_lghaE2aYAnO>p9kDB[\MkKGTO3GoRBlGp?jOEiEHq;bXWQfGqfXG
iC9C=;F3M^ZXE`56f3kAD=M0VAJPcq`BmdB2P]]lgmD4@[d1od=@Qo4G?USK?VS?
XidmCoN4:_j_<TQC6jXop_`Lm5\7\:M<4:a1ZWMHIm2ZBC`<?T^bqF@U4oNEqmeE
]5AjBE\;ge0e95UX7fJfTLg0niV61G@q=lNld7ZPO]CP8lJC8DKeCU?IKn46b4KV
UO@5anpXoDQd^GpJQZc\E9UFMk3e7I\X6LE=`<O_:ICZWp;IHAh;=QY`8bjn?Qi?
bh574YECfl=_eej4;7_1iVaCKKUB2L`:oD4=JJE@2:_TXMCP=>iRoB;VClh[8Spa
In4Ul`=?@Z3nEKDCJ]nnVcDTDB^6;M<?C8WEnU8BfXbOQkqc1XH1VR[aPRmNSQdm
59@`=FSQKIhqnin4cFGQ@GW3^>XA:ZEDH9F^4bl:8=VMLZfF;IGQ[HVKY1p7cV9L
XB=hYW39AbO]<oa8Q0BA?QB2Z9bqDOkGWj_pIIA`XmoGM74a9US^>ifCWjFdLYLi
c;2`:I1EH[ec_C?1]9pJW]JFTlA4VqXU:nXKWMEBRJmagnmCX@6nneS:6^XNhJXl
;0Xbj^QWj[p;UbAgBBS2i^fQA3PDV_V:88bTd]`cY9qfYTioNlp^;__P6ZpfFaIR
H0qfea8SPD3<Y2XT2ohCh[1\X?c^_`2Z@^G48qSdB`FU4_KP2RGU;kEiR`AJnUmA
Y^:9g`p<\khF0C90SA4FWHd5:ND6GJ5lXpcfRZA46qD4dCM9ggWXh=5gZZ;HW;O7
o3RGQ_dJX27?Yq3@mUB<JeLGGE>ijmOKWPQSl?Ojl1eBE_7mQJl<]662VNB:o@lD
@b82ApPPSVaXB@JA^<3c<[kgN5Fm9=B4OJDFUUcL:Qo?[Sc28>KPGU\3U1SNn:nK
VS9Fj9i^I2>?S]Si6m=2QQGi`p]1n9IEJp7cFkBnniKNNBDWYaVh[mf:;mL]6^<S
hoLQ:;J98_ljkRg5BUGADH;YM`hAAFYOTd=7Yq^g3gUgKQP?4\>NiEHXkD]U;S>A
pO6[@G1A=eVUL5lHI6W_]PG@0J;cm9Wqgdf8ZQJ^QJ0cP1LOg^P2:02DY=n2LW?[
<lKe:X`\^2qmh9Dd76;4E6\Bn_l^F7B@b[7AJVCCT=SN?F8U35O1oqMjMTEnqLaU
]LCYi9n[FChMQ_4<62d;T:;[jgDU12]B_`S3:]W5MDV810nRC82aa9ZpYGIi?C=g
W]7m3hagHDGcgQ5K>a_lK<U;LCqcQg]N@WD`UC7A]GnjSe043jGd1_OAgfIOEgcW
ej<jN>NqHLO^[6TqioWaJJBphIm9k_7h7iV^G>K]KCk<2>Eabjc;GPh953\f6CW0
gBOcF@R;gAdf_hl^53C8dF<7HSjV47Z[`>B?AN5ZI8idbYcRO[:\K_hMD?52c:im
oO7kp:V`hc9pQmQ5cVHq70NB8g`l0TfHoINKp<AC73[\k7G7oblFAJ2_Acl5T>Kh
@:C8hVabWpW<\W9dPSDR\[Q4qMYCLKBBmCS55\TXGIJV=`EX[eD2Aen8q^9`18EO
DNk^oA[5dHJ6RD=W5LmRqmV]N970@nRDOZD^36ome`:>Y@OdPE7?WpPMdGoDoqD]
_ROZBq:f7N10oiCd:>c9]cCFHAKSbO:dYSHN@5>^l0mg2P[k9Gp5T^8iYBfRQJoV
BTphU=iLcXqR@gMP8JGAhLP3]o2cfB;j]kDa@PCD3dnGo6bqNobg\32pkijA9:WY
LJAF^5dUkZBjnj41c@LLJYU_pW6@ejN2GHRjDP14neY>V_Znk9?VGlLO5><a@2Q]
<SM@ZKn0XMDk0`7NBUP`F9Nj;I]Cj_i`eBnadnblop`nn]K?Dpc=<8JKm2l:9iCC
9:a9m6nLC@q0]3lC4RpadhIf0EIFZeI^5MWh76=5\IZOaZ\VdD[Egjn9nApK=`Ai
kh4nm8j\emh@bqiG9CkXnqb3LTD=phA[B\5ogi8\a;5fg[Y5jNkdN8N0NX_]c;W2
7J>XfS`?1IaE912nm@U[b9\k39mhWj>jAe=nA70FB_IV]qIG3fQ6bpTWMnWl==K9
`gbTBIaaJV?aVR2^qSMPK\^XP[gdXZ]jO2LNZT=<k=P2DgTJjK7dI0;JYekaWDT8
?q797B^Oo[q0`]U^51\NP9EeSNLYP^Riom3nYG7I6S73Qa8L:N7FYbQ6BqHEV>ZI
ZU<l8E9`=^XYPZLNLl@BdI670j:Cpf8<b9ankp\hWOn1<X4fCRkU6R3Kod;GRbbU
qTj@hd]0qmb4SV<jAQ@NLA=Q>a]gG6Pfel`nY1<Ld0NBE09PELBJj>M>h8QQ7m>k
kM\lfC\@BhJ:q5[mh6[=MSL1bnS]mi;PedicbMXYPbDZfnW3T@G>0U\h=dCmgUR<
jBRD8jaX8Nmo:<o>p2^aZ8CRp_?1]KOXKYBMgU;2YqhF0K02e$
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
>4E0ASQV5DT^<`o:54P9a40[Sc@Xh:1h7kRQ7AdN^VFIUhIngcfQCZJ9j^mp86[X
_X]QnhU]JcoJC]Zl[9Hm@Cn<6:K<^M2j2F\hiUN<p[[W2JCOR\ofk>6h26mqgmlX
QOq_e7M`o]U^Zl]WdbU2P0pHhC[VES4lJWm>^o;3Gp_LU__]WKC>bEiSbI[VL_>F
jiqa@8SLcB9b^k^MTc@AR=7SBpbGO^O6CHo`=KK@EIZg^@onQ7pbjKG@2@pFo6=a
0L^I2<qii_[eQM:hRV4EXqS4IBlD=q17f>m>epE9`@XcApSYKk>V:q7eHf4Ee1Bc
\T^YBWKNYqeb@6jVKZ>2XT4nX;>F0Dq?@SaHlCX<onDl=H8MF2\>SQH3UJ@\X[0K
HfIT3X?>><eb3hoWME=IKp1lON>ciRTlq>Vi:meHfAeT2PiUQbcgTaBSTQYdCSa?
3BDkW1WdaTcH;P@2WZIge5_VNfmI^``3WLTA7Q?BQ7QS_f_nNUIXm3>SN`Ik:G:p
BfB3^2@Uh@PZeAPaJ3eC2V`de6CkGSJ]_cCUdi5fnP[eVIWVcf5QnnV5OiDROZ_h
A?@9pl?XZR:DpG2PKHg6pE[D5L\PPLfj\:PABRSI2paO6^]B9@ZP[GFhh4BRMR;2
G;L\g8=EX2E[q=BP2^b^CT^OJBP<9:SUgM;nAfKhfem@70Sc7A6qZVClljDqE85]
fHZj]ZoVQMf\Jm6oD\[Y2lqAM9@\T11XD:<MTRNAD893[3YUci`3ZNPd1Sg7IKEO
H5\TXRemo>Fn_Xf[3PgH<5kRHk4H]hl?<JARihXXe=5qA\T>ki5g9APg_lm\A]cX
@^M3;I@IZRPoLM0aVX64`<L7b65Z[XYqRUoV9LcpVYS:ZPCTUm6QKXGXI1FgT@[8
V]hM2K;DL4_F0I7pYmMoF?KM6<RS\:MT2b=HZ[a=j10[GcLp:S8?l:0qKm>KagYq
0Jf_;iWWfHp7Nnif1Hm86iJjOZSBhk;KL7;T0a3M3G7W5:Q39=T7<BAa=Lcfj?gb
?HleiH2aOlXR_D:e@UA\\h_ldmePOjhNn7HHXnh_4q@caR^XIq^XoNmdYq73NZkF
[omPGL?:[>:V9T2LPXYK6IB62_O4PGhN:mf_qJ0JA]L;qVaXeVPccUZNoWi^N_l^
9bK7pOB26HO7BRQL6S1U]U;MCGVo6iUZM]8^2O3CNnNcEXZ_NdD^jlcCP^_FTlKX
1]<a8PFTDc?]J<QhaSkBaSk2EbnQR_Q2a_eN]T@=Oc89XfCPXK4qn0d4j\bp=XPP
S]?PTe]i0aUkHYP:d`hAWofRb`q]2:acZW>@Q46;SYmP7Z2oW2eKG24V9I`61p@G
CgPEPq30T@V?ZRWj<U=M4fa;O]2dF4EW6Cgeg9NfRFQ<>8fFYb^dIUI=RDHQh7mo
?o;Uk4BJ\GBC0TW?>fH:p_JccV\]q;^US9jn1P3JdJ;E]_S5LgE5PPWMWRQGm@fP
M71p^oPI8Z=qF<?5inEp0\boVKQqOS[M?D^HIoJ_P89IP;E@88^DLP:^hiT9INOG
R95n[7GR^SQU`hKCkjLm6kV?T;CTmcc:?aChLaCAdQ9`9VmSF0qK`[@J`>iITS>W
P:naX_W;X[P\K:1P;fPi2?ABDTOpek^\4L:pej3X>iU5e1;]4lZVlb>fSB7[QgOD
Z>AC[VBq6;\PY`RqK@[3N]ao]Ga0DgZi]G=IH:6@3X37Ed>DPFbIoLkLC7nlf?=;
6jTh>48BV?Okn4LLYMdqC`2W@jFq<1iMiDRG]_8iN9W`O8UWAOqR=mcBoL_fe=o5
o5PY;5b?FEjVF=^p6kFiV^Nqj>_3@c`lFJlh@@0_GaM;JV6Plj_NcI@EmLnp<PJi
kTO3elH2GAfPe`\];n^b;ohL<DOC2Xe9MS:]ZfhU^UdQ5\=F5><B<Dqo8AdC58Xh
@<e>=ON2dF>GRAnjg36FUW=eUaZ661F9eVV<Xg<ig>7H[\[CaOPBlg`3CVYBe?O6
K]q8cB0Elbo?\9;F5WqYKOMcoQ]iJMocAl?k<JSiFNC:`2LM_bKp4ETIh`6pNRe5
_hhS5`_1AC3KpYi5kCe1VN5<=e7ndiL@M_Y2pB[O^Jlfp6TFWQ<:KS\=i9SDkL5C
OO5]CC=ZaI3N3H^BqMfg^[a=EY<DHe0EGgQ4>9_LkjXhVp[Ad?Ef^Le7c`AALYb@
]baT7:8GV4\BbU34MlMW5M;6OSTECG<`=2feRaWjkO;VF\[eN?W?lk8ZNECoa4P8
O3Z]4YTTS0S4qdoTV1EoBIP`FI4S^j5Pj;mSMC0G\PNoo6S;P[o_mk]i2G=968Vl
Gl=0lGDo;HnW>;AS_YdY0]iQlQh[H12qP\JMecJh>Ajkk2i_RV@kNc`P508Da>2U
5mAQ4d:Em\d8:_0H@G4XhHUe2VY\fJiniE81qQIle7NZ3iAERcmXc:a5]@Mn_GhY
L\_BcX^k3H^fl_mGc_gDA7H7`eP>l[]On4biK76pPefk@B>Rj\ib>ajMBgk;ITPW
k1E1UMqlC9lCXiM^UI>EV>:oW_8KgkQiMN==1p@NVO0@6p[NUAYKFZ<3O2AN]DSl
pP;lhG^eqm?9iU5TTJO:56CBd;]]4Lf]=LPWNjaC2\`Wq^dB`0940\\cXZKiG3FG
ZlZ\]5?5gLECJR8KLAWJ086`3G2PUEIK]4IK7J8@G\VlX:FBf76D8YLfqFg5XfLD
62]b=Q8lAk7eL@6e\G4R\LfL`1I_I^KRhDkh[XnGIn>c2eH^`4IqfhNF41n;NkBd
1Z7HI<[>0LV9Y\h[Jihdi5bLojG3;?37UWfM6fYlqM2TP?iINjfoR5Jo7of=BaR<
Vdb?\>M]EEaZ95^UoVG`JdI3RQZa<i``FB5aIXO1C9M>3Kj_?5R57Q_V@NIR1Pd:
pf7^US<KfZHe@mT]=SHa;1h\_WgCembEqTXbAJa<pIDc:\YojJT4Vc3_SlCHX0[c
hIKgYiSfdn_;qN\UgLC5qSR^gE3h<@YDJNDUSbb`?3VL9:0<`UOaTb@PqjV28_Do
VT[<1mR8ADUm=QbeXdi<:8>=oe0j@HXUaBQ?gZDl^<0^Lb>p;5UF7aGLV[]N\M_N
0=fT261?lFaIiHc5?[M=f3T0F:FA4D;D1Vo3]P]3J3_CLM?5DFYYibYDWHD[XPEp
R=ZG]<dMU0_W7FZ99YGXZ@Dk?[gb=9:6^bZ[=6_XAVbM?0En1mC:HHTILG82YIqL
`bTIS5KlIiI3Iif0_B5Jh\h<5Vjh6NL:b_Ann=C[;LngDmec^ki6^G?EQ@mKU5Eb
3ikXe]hfTFF2Z6VedBqNKBJWln1\hl<TPfGq1QL=B_gcj6X2S_`S73nJlJ3lFd6D
2eTqc53]39\k]kl7@5OlHmClNeji?FO8=f0p2fWo;@8<;GZDA54HMFk_Z?gRRg@D
[>]hV5lTb[S[VPZTG\21];l==ZLQ50B\`PLnfWfiR\`lpmQY:H9apKc@1VWN9C0M
;L=[[=S[>4668>F@8e66kGlZpOXim4CMpNeA10;A2498e0]fMAVEp1S]`nBMRhl;
B6QGUHY]UHbIW=PjcGkbm[L\q[\eJ7U=aE82Xnf7\hSF<SGei=P4oSZ1F@HTQO:_
a9I62cmDd:aLd4dp6HV7DNT\cF`m7@@m?n74>YjV4ET;L1R4WSe7=4o?2KkHHoV\
HK=_bFfiI>B>OOL9V_d=^:L0J5aX^7hpJCm0_[:;N[Pen]cJ8_a0Q2XmEh^cT`ii
>N4c[A_HJ8Gg4Y^oEC>nOcj`HmGCW^nMHHnZ;`j49Kn\e7>W=dNp34S5f0K?iXHn
[R9KpJA3j\G<e>bbRWW\eV1M6mDVaJo1:;Tnqd0UbVTE<0N2nf@9id4GMMbjZ;j4
mK57q_jMK;mPp^]2hDbNa?4nnGnB3agAgBYJZC@>aA0LPq<HiiEV5CfoCT;clS6R
qGD=<Kj3qXm^k690=>2FOLdZ^]]XB=Aid8FlHll^XJY2pT8SJYoHMV^T<JIeNC8q
D_HTCMl;8YDgLmTlbcBbWPSgN;QJLRWoSnfR2]0ch3V>@5[mI7n1nk2H6@:B0B64
8J7UqLEn;W0]3[?A@Z71E3C_HBd<hJWBPkK;DE@4Y?Hn@?2ceGg\d`CkWP83eBWX
jdoX\7>EOn9\Ba;hWX0nN?PZ?BXeh@E0BL9CI6^Zp;S0Ok5:W\eXe]2IOlOcW2<M
N\H0U9[kXdf0k@egJ2kAXlP>LikD;N=IKcb=FY35Xc1oa3;dgh=ZAg1E_m4qGC__
T0X[Yc4AnfiWTLk8i>dRg6`bU=pU>E`UE[qaYIjg;]ZGamHKH6MH>Do^YP7]Sck9
gCl^c`Rm2_akPDdh;2XlAZ_?`[q]fB0e3bVeFX3IG@5GCUbd[YA9cNHbJDepll0A
h2GpcS71>N;6?R`;ni^cYWQQ:n]W=_][YGkk>];poS`j0@FCeMa9`bQ>`?NgWlJ\
4f?laFCbYRPC>MbeSWH4[EHA>S\a`=q6FVPVZW^QK0Y8Y=9bH<IOVkckBI4LPh74
G3;BQej`h_eUh2h[`i<N_iJ;M2S7a0QdHWn1DbfJ5eU8n`pjdM8o9oJAe;7n4YTW
M186bNSk6a_n[3ioCbMN=9U\CBT`]KBRF9QU@]AK9GONUFITk3`1dR^ajOe;C1g4
hpCZB_C^ekMcmI[<LY?lqKA;\U3dCfMKUe6Apnk;A[o\eHeM;8@<Q?WB5f=SM8E2
lf2pmehYM84q=U]fhO1VN530WJWUkgM?eOTj49Z<pUed=lS]MDG=3_NSHEH^@]_R
mFXPdK>p<Y=Z9[8J]Z]ZP3oh\i_LF`PV_I>kE<n>n?q`_K\8_apR3Q1oVg3nU<^C
B?aqZTdXF5mp]^[4dmfOJkj8eB@dMTlgKKiSOMPqM>=WgS9qSOcY\^_J7O7k8R?m
P_GYY6oHJm569kf8fF[pT_L`acV`;nEHN]gdUC\PqUCnFY^Tc<CAjm2l5g]hdWnl
ZiZCc1G78bhG=6eP@M^oiLTG5Yb\;?4`C5mpA_R090bSih1B7^2?O\OZHh7cLd6>
]>Xj;:G[R_>1:_Fg9UObS@>R0:fT\`Y_M84Db320AeJaCGLTLdRZDkq<fMm_L;p]
Y3f26ES2[P@\5nU3hTKlFKh<J@b9PqaQ:SJ1AOGBk4ajGo:Zcac`\lPN__NISgG=
9bU:Di0J3O4991c21[fk9i0Zae9TapmQ`VLY7pK[S6f9kFe^3RGdG=5WRpgDf4Gm
ZTnl@]kS7;QYGRY1A_U]_I1@4jh?ZqX?1[8A?N9@dHDN[eGkTd[jP2UX`p3;OAQQ
kXILBUoKLA=jYba7PPigRZ_k=ZdoAJiZEd:754a6FbZ:P:b?M[HdmNqK8PJcC`oJ
`4a3[7Mjkd`^?\PcQY?cYOV:]c[MVg8C8B9ok<I=TTWF;?3o;O]PacU;D?lUU;bT
`h`BBq@XK9_]>]0dV51RBTV3Am?^8;UUGTK?H`hhKIhZG4:UU^392h90^nOEaR05
mFIieIM12k^TgXeXIF4=n7[43\LC[k<^TJpB6PnRCNfbIZXZNkY0?5h:6UeC8P6Y
KN8h16WVk4nh4MWL4nj^F;HqYg8C:D]pCmED[Xl4IRFVb39i\59`;T;MHXTI_Qp`
N<Je=q[;2FnJpG>G:h09pJ;hNmEYPW7NgBf2M>e52m;a<SAT;q3ERHP;^=h`1ThB
<ONSmWnC\IplM<O7I;=EAXe5hGUdD4]`Q8ZM1KLP7IW7icgqA<cMa197Bo]Gi\V;
XRW_X1_@C=p<@TKOn[qKomm3\<Po]38b2N<DoS;9n=fF]5kEfG6<VeFQge_l5_DU
>df;Ol=bk6pPUVABLOpHAEk7^O^bE1mBJoo0OZNNE<Wd]3<fG<VJTBConm<[<]Op
8VE1o7\Ig=eCXTQBEm]9N3BiDa@0plfaRJ\2qjnN\o7bFdh^5CNJRU6A=S<1E=:G
Wd9pAic8i^Pq_9Kn?F0p3e_NmI[qN<AgN1QKfK9\jYhU6fVfd9N3i8aS8Jnpal1k
W^3M>oBGF`o5jH_`H]4T^>=q?6c@B_2i=cCO`<C4I41ZN^YRF9mGS5MQqMOeo:BT
QY1A0>JJ]f2:]GGRnfCk;b6p@nm7K@i7cjMVP@ER77FnAD0Xo[K3\8BRH;iB17de
VgAg?jK8?ib@R[E7fP\I0>1o0?J7<fm]Qlp9CWHeX`m1jX4C54JTfNI^M[?7GDa_
_ge=lkhDhqV9KX^gnq8N25]7hqOfaW]^dq:R@=6E:TZa8Y:FHBIiU3Dnq7DMoNbF
m8E>f`MHPOImbqNPUIPCN71kTkoU>aXbE:1D==QciK2BLH43MH4EG@HT[AF8pQ`d
6i6ZKaY[h@4<IV55G5`_MmkGmV8piCNUDG=p^?FajV4Jcm4lTnB;CFT_YNfmBQ12
dgHiZUlLDD=7KK3XUJf>IN^PmUL<HWJSOMYDVT1L0EE<20:o_ZJ<NKEQO`>\LYOV
j4?ol93R=GjFH4PSqYN[lHkcCK^27KTUc]0Qq;WhjBanq4<__X5n7T_6=>WWC]nY
O8iL0bM\D5d_DpHCOfY0anMli`74X8q?jjAVe?JJ@PVo@l;m6i6Q:WQko03I^3^_
h5:2BC7ORRO<YHf6]PCH8j82:LmU0_9V^]Ha^D9p2a]7]6YqeZTAV0cpiA3Tfid>
:ck\XdLLQ;Ta[Q:5oZo1M0_Mf\<<[]Sj@\S>?RY?>7^`LYMh];9q?1Hi1cW=E@jo
S<HEL@`AeGL[efL1B\3I7EQ3\0NB=]nf7;8YPK6o[2N<9a3TKLBN8YYl6MImiMm]
]be>faq=Ke2_]40KJ@=A:`^567qQ`mKj;kp8@5hIB8aOZ5HNa_QYjRG3kD=K>@hb
bq2WFfEOApbO<CFRMk`Mdhe`4nqiJe4XA?JNbJaJRNSe3CM6d`Tc5j<A=pDfR^>_
Mq3D2cjOIaIA6i5R;Wf[5CmQRaGmC4pf>VRkX9_N;DkccmETbdXpK_KafTcNN1\i
`<K@V\Cqg\F:l<T:V6UGBlZIPkc=qdhYIMd7;Go=:PJi3NnBk?bJV4f2iFAmmQ?d
B]Q7L?_jK>EVgqc>L@j\0qC5nJ@D@Tn?P<A=f?Z0Rnp0>6X;g8hTo_YT>:Y:nTqC
n?cCFD<RYN4YHT6TGK>CBg6EFPH]WTA\ni614Bf[DiF;@F`QMqFm6Z3jAg>Za<[c
KmTGPCpO^?S2m80CEAWdGTBBBOY<@51Hl`@>dB3J5=Z2;J@Hi;F0`jkq8L3^^_aq
>^Ee8:YQD3@5`QfF?7dTqLek^49gD;:^[FNhJfcOpMoBlBCTHBYUGAOc3BQQX0N2
8S_^:XIH3H>Sa6X0h[UV8N2K6JQOcJ[bc?dq6AZG<nT`WLVDW^Iefn\_q>XKA@QA
?DML9Z0@aFidjXZYFnU7<TJMYcce=7FKIicnWgmQmqQIckA\TpUeVI]9iJ[[N_57
=XSV^UpGI3fDDhINc8jdPNjMaRp3ea]2dZUf?fBYIIlSi5Jq@XJ>mZof820@DYK\
M9@<M:[V]DDch6SlG3__TL8=bjBLbC7lpb]6`2>gqlI3@b`kbW>]ln<71A`L;qi6
>lV6CJ@SJ=dThOlN\TL[e_MH]J@JIeODTCLK0pH4XeihT1AbGITHL[3J\J2o]R[c
BfqdYJ]:SLIOgJ4>4Oh5ALWESdliU8RHnp=49ff9ZN0KaIHC@d5^[^UbXkja7EOF
IGcQfWGZYn\f7nJ`9ES0kEPa=5=VKMMLNa6mq3Y=>4@dB@`6obLJ[Gco[oc3C`Ve
4=E[l^m92MnXamPC1@nTHAjcld@6E:9@oRgmqPW;ZK6Xq8LZjcIGLC[ejdOTX8^=
@D<IOH@?k\SMBJT:>1P[57L;QPXQQKY7Yg4lCA71cOVnG[iqHKjb`ln$
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
\Ufb:SQV5DT^<DTaJgK<;PhoR]NHSdB[kLjGe;l=BA9knFMi@lQkjj49hYpK7\o;
bEQP1nWG1<DfaX`D^X8Kl]Yj;[lOTIoWM1F]LlB[nN=oE[@e9>;QaG6B:Op`HNHj
jaPlQ@S8YgWR1eelQA>AQC^P409EoWD=kPkD>QK19YEolS9QJcH=Gfff=EfqK]G8
:?pLh4H:S\^_?>OX>STa\P\p7;JnH12^JXgSm51J?Z=6\Lddp;R64=ZZLBQK11=W
O\\<Hq7@kjH7X@Dl7nP4;KDdNT6^iWfY<h>LSHM=pQja[6<nRL_dXAMKoK@SQIab
`k?1_T>Tg3SY:D[lTMejB<kDMcT^PZlcOq@=E:N9<pE>j9LM7goTUAJn6b\\_b4<
Tk3?l59bL3dioB\FmRVP_REB<:c;QC^:SnDX@9TT?l__8CpLe7K6AHaDo0?@:daO
i06K\`JJebLQ8[l6\1]KXRoPUnZLh[Yc1Ah=\Q8bIK?UVX9MY_LQE;MYGDmp`6om
UEQ49L03UIN3n49Lf@7pO4kI1:?pcHcJ\iNbh1=6L@\8LKEF<YLQ76fkS_;pId>R
IKcTehe@EcV`T?^>IMPSPNLG04CV]`7Ql`9V3E7q\Xd2EIAEYajbWT;gS0hTNkPc
4X3@OV`JQWc7pURK<V>fjeCC`7XjglP58e;^li06eXifY7egmX<[[U;^?dR86j[o
c_NkWG6pZbX\gIqD5OAIB6L<D229[5L3Dl:o7M=>4c_b2Medff808;RoOokZ[5[8
`X7llRB52XR_lG1a<PAUeR`CioZm7f:l5^mS]Wpdbg^]nP\I]C<RYhXOYIYgg6O1
3Qc1JW;N5QYdV?Y3Zjo\mFj6f@XkLWE?`PZkKIbXD<5C0BNJ2IMY]Qnf@XpMoK_A
A4R<EON\;G]?;H[5MkgdWQ@LdV@:h6m=fX<DFc@?i8i@dFNC5:n7_hcMiAMi@nfW
6SkU22]mn:BUJ8p:]1K:]G_GPRRW96d:c@o9iF_0<NEUaF7=9>O]hOSjTWEK:W:2
\1iO?NOULm[LnZH:8;b[SfW@`fW1XmM8Jp3;13HXapVhgG4lK55A=]<>TkPkd:M?
emVXNkl;El<I`XZg_]3B>7dRUf=5YB6YE\Fd0CQ<W^F@WGdCp>LRf:K=]lAV7BR6
b=Lh?IZoDC[]aeOQYk`obO9`h?;87c@COZ`5YU8RZdQVVRO_oafQiNfPIKOMqnXF
SXQ>nj4o;KFL=U5Pdm2Wq_`I`E0jp8O5kNdq<VB>A7=LEYKjaX=@b:R0?PnHC@^L
TQ\aTa=Fh@>Ii]caq<VBoYK:IPR2]aY>C0SDNEi=_?B[Q]>?CWoT2Z<fh0@D;@:]
eFHVQ?UoR58`0f3gJ<kBQe`2a2ZdN8?<Gg_E\TdKQqmh\Ag:6X17aaUdN=V2^03S
JcPNW@W7cSO8CLYohh;32OGGn:E]H77A0mZDZa1;XemF\:DO?NPF76HafglV^Qq8
9bcQkc5E7EC:O0RQFX0mZDIof3@R3H;Y>R^fdf:A:XV36i9S?:`W09@:oYVJ;kY8
FbEoIe_AFlDPo:VNEg\pC0lN\QR^<V;OIT_CA@9I\dBj0[mfaM4;OGAFPkmp:Om[
9A_FB^cIlS]RFOU?[Pf9^oaJ65[Oe@PFc=4NlF8<Ofca@=Pj0OMo;Xa8D4ik?MPj
gDJLm>n\9`I;C:?q83W3;^epG7g7ThB0O`Be5<:kH0dIZ?b63Z>mohhJT9n4g\>i
4R[j[93OlIicea;lPl5[Y]LULQWVg\6dT_iqUU\EL<f`T6k\WlR>oXZUeN?qm_CZ
VE?qb5nZA\iDij^52^VY44=`O2PM\Jp1K7EOCS4AX6RH=N5[0e3:nnL4TaJVOYnI
[6W:?FapMInD8][qg^]U3Y5Da0bXPD]geN`_HcD\X`d50[3;]kMgf_:0^eeNnoc;
Sb8B[BT7`FXeeE7`g2]aaDNRTiFQd]<Maof?Mb178[Xld1U=LgCbnUF9WIi7:NlJ
LBpiSPDIb<p^dG[Pj`q6k0Y3FKq@DWKO^<la>OTn@lmU8j:ZlGj[fM99Z8@GBbMV
1g9q7b7J`:hK1m7Hn^f]RkQ92kQ9c8YW3__dcWV=e;<hSR?oLNG7fhoG_^Sb82KD
@i:9h=TTqD^2;fLiWH?\6L>iMGe2<c^fK1b:P8?FW=Z7m`@Xig=fXo>[hQ8^SI5n
dQ3=bdM`_02LL`;Sj5FFI=KMCpkM_d_ZhpkHE6^WqG0YFGHXnHbJla1AImZZRqTk
VNX`nTiYPSEihMPXi8cBMAM24fTMh?h;A]b8@OiF2qicI:keYB\eA<<THkM3M1B1
9onbXZ<>ohiaMfNJZJB3UqVIm_iZN_=A;TKo9JQ7[XVTZnUKKicI6HJDQOF5cP1j
RpP^ObPg^cY;YU6_SHj8m^abQS9M5V:J=oY0OmP]`l3M>LqD\jkgY?U7ZUhVoFfo
K<[U4nTViSoBaCc<66mLGGh<ahpj9R0W?fq05a=iS6]=bn8n1>H9Zl15@k\Wk\Mj
T6dmNEN[\?;[cT782NWm@gnACLJMo<^p`o]I]VZHWmo7Y_mRm:_;;aOT52KiSAc0
L4iA51iK3mf^aXUp6PI08CLpWo^<C9pSIMJ:@NCSfj`f4Te@=JDpJ?Y_aG@3NPm8
G^eD@51mJnGkGNY7FYX90k^I`RR:_;=q1C7DC`e^Q\`56ColK61F==gg=^3U3l>4
Z;RHNLhkalQqKY<3QCa8IZdKDjdHgFOalmUhV@Eg0C?<6<hKXgahF4iq^BRiiWn=
lm91MJ:_Xmj86@X6]U=]odMZeQmHZ;ii6j`qEN1CYJja49B_05bNj@O2mdW`I2nk
_RjSSfcWj;[kNUNQ1AB;p];X04U9qaGWJ]`Z12K8ZB9SY3H1M3[hPB9OZLX\jqZQ
IL\LKp:HQ[nANG7Q1jF?jKTWp7VfVYo=1KXVhYUlc^jg?IV0fq`FeYgQ91DocC:O
:YgiMDKbq3ZL<\AR_KCFm_6MK\A5`qE:G4Gh><=U]]0NXP>g2iQ^O9PT>G6>P:V8
qADRAI<K:o<;kLA;VlHV<@I0UBDJ16BlHO5@R92E9o2U\1K6NWk2dQ?DIpJiRn@C
4q]3IjJN;hCCTh\ofH>lO^`b=LIQ99g;k<@6FNJBK@`a_DccSPDXmDFW6We_ETWb
WA_[iF2heaeVKVp<Dle?AbE>f?_3`jY5e0WGVSh2e6mXD0o@^jE_70<F`=kTRG91
>RXB^hZ5j_GH6qD2f@NKUP?76P2giFUGFig^^Ip08g;L3bqnCiMP;\D;SiH8=eRJ
0VAq4_o0iKn4oD0;Oj[Rc4N1fK>SDU@945]BIkYI<ME\<H\ff0_DW78:0BIG`4ad
LOckhfF^XDKZpfAQITQ[9qCd06fnBTMRKc6;n4f[h@p]ZIhgiKM0m0_cCi<d4PMf
NLR6BZOJ6??M7bKRg1fA>8`F2Z;N^WXlEnoc\U\oP`qWMlmFS>7jEN8OkkaHBMDM
=\Y:f995HKo`jg6gLR7:SV:>VLo9i\>EbhXJGLnVBcn8Dq9TTmLbD]pXLUWSkFji
^>Z3VF:c?hSR[b5UgoqMG6lG=:E\KBiSZF98B;3K`qL?92^Wh7Q0ii\8_MDD71cB
aoj_K]_18^n8@kEX9o5\`:ik17eB3B41bhHf\K`1o4><p;a?A24LSpHH?bKAf2Dl
34n;i<>E>nQTTNQAnS3YNJ@KJW=lqdlk588imp\el5b?m;qW`U1jRKNqg=7`^N11
C7^>g9aOMifWb5[6T0eLQ>Uqk:A\I:3><?7`m5Q=8GVH>d2d^[>@CBIG_l6=QR[=
mNKpk^6AbBOlcZ9DFk6C@3545NBK>b?:IjR_JV@Ap_T=b`N;E\5LnTJMFJL\p9K>
WL8qaan_OWHQQ1LBk\JQMf2mN0lG46i\be26[9YI?WOj_Q?<YCRX:7PCRYc[3`GB
Fo8N6hVeEVZVhXV6lK=J1lk<RO^2\3qFg:1gBW`EA\BWc:ehUhl8KcC`KGNK>eH_
BiG8LXE<>bDW;h7YQ_P^\DPFCNZWP7Ob_Zk]ldgP3;03]EPK?EaMGq79bEE]a1A8
QXML03<?hmV2U8i0Gg8gmQV<LS_m@PnN0cX0g^M?S4>HGVkGAhgbR_YeLi`B9Q=X
XV88]enYYS9hqW1IF]gRbE57hW8hR7\1=hH:G`P1PQXHLJ>:kEccK_l>SQ?7O`?E
5TR?lcTa37V49We94_QS1LNOPn@cI`[2DpDE^g8>2qYCJ<ZjM0a2lQ?enjWXV3U>
\jCGD@EA1Gcj[=U[eVKB^ZJO_hK;dKG@]lb@W1kh4PRM^b`OZ6UAV^qZAOeY\?VF
ZMQ2E9HKEe`FhaT9VnEHcVk3_a7YN1=`>CqZ=J\ZSWic2mLHFX]b\PfLlKTqfZ[l
6\DqE@JM1km9DI29C_dFj:9V>^^@S5QORo:NE99V3GL9]4F1$
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
2<[?RSQH5DT^<8HX=3D2]cWQDFYZl:b1m52ZQ`Fa4f=haYiS6=dg1U6phb4\3;\a
gbija?M>nFdA>^LQ:Sp1OTenNFK70ROHgBK7HWEgcXq2lD4APqJh94J[e`;:IVW2
n7J6`[MP_@Ik2qZDjaQXfp4SoFh4LT5Gl;M6GO0e6CEY<f0GqWK`EobYdb?>ISQT
FdaKJNDkgo6:PpM<i=oc:qSeSVD4]o2RSEJlcW\:65FEM0G2]gnBqoZLM_\3qgH=
SQaU[]cP4TN1@GDFZG8Q7_=XqHB;IP@8TU2e6?CmQn1qflbNma]79YkM<D>W_?<i
B`qgaTYQ0mT5NRLF2V5;M4OUU4URUC0bGEM31Um]AH=K:U_WNQ:54nId^R5q_3B1
9@4q>0RDVf141[4[^h2hG;LVBWmg80Q?G9oimFC[3V@1ekbG4VC4kLlX<C;^2d54
3nfK`MdU[g;gbjnY:329Ak5ZnKZqoA39H;ogk?ddn9CAlaCEq5c30UA<p@NMa8W^
N]4nHHBQ?lc<Cpg8AoAelo_]KHLU0oJhM=EkcH\mC`:KVWQ3DpDH;GhM;Gkma_\U
2@fZL\E1<SX8AL0jFTB37=9Q3MLXLZbVRGHni<VHBc>N@_if<?<XXoX8mlGebEf@
WgQ2ISkZ=q4NklJCZ35T9HJd\M@Wk4p1jRJWiJq<XYQMc9;H]dY20L_<Gd8FEK9J
TXnUcUaiYmp>0`mAaMnoC1p7GLW`a6Fi]V2_5fJPY?_8]`3^TeXJ4AYTPBkl^X2N
]qf?5^YCkXJjdG=P\FQ@S@mUEoE6g]aI=d6SS;C0]AZN9]LQk5_8WN7DQ[KJLEcY
e:b:Kd>999q;_HB9YiqkLl2E?QGg<E49jHX_ojfe;];jDl@CMB@V:FWVg3S^eeB6
iOq93lUPl3p2`KaO[M^Ti0lU<03eKdBjW3;8gZp1i8J9m^U?okk?7^OIPlj[7q[Y
o80kI;GJNX0<<JI[iH:F9l20CF27S4@emqZ5>GRH[W^RaWZN09TcQd^]M:8Z3dc;
QEVZMb:]716OpSQOMUVGjHokWnlR1?]C:@gBGCHdQ;KWfdOjqDQC685?_Vihp@Xk
O`2J97j_K[I\_pXl>?kOjTYN==^U120@^2?VgL_@dIYK?4nKlR0PphfAc64ZnfDo
3Sc\LPc2ZXhZ^?]9QS9mBOf<Zk3W>9CQfaWf5q5;Nf0=XjhLiVdKhFWcJ7058bN6
U3<=LJ=XL6IE^PGEk7oZ]VchgFWNTU[44ch;0o9dijd2I=D9SDVm_k3l]l_N:1hV
iq6NdiILS_i1e33RnJT2TbiZA\Hah\@KFKK>MHiLcPqPnGmN\>ZoQQ88V6^9A[dY
WGXMlMZPNM8nF3DVl:iU3dog0GL9Aokjma5o_ek5GhZ9WXQ9WjfgCh>^JTPa5h@E
1`hkocqh391nempGn[2IXWpI\Q]G49mOMagc@9eeZ[QbSC^]DRXD[]P=0Km_^7T?
gTYd;bjqk;W`];;LKM3ZQ_6MHNpT6ONc5;QmNkd>FD:MaDU3AZORLX>WRoXN8qLe
:\\h[PaGYGXe_D5[DM_XUYM=HG;QFH8I7o57[?6J?3`?R:]==b<K^ViX>h6Sb@6F
kjf6lkeXB`HBf50l3fIEoI]=M;0`<_2ca^ideqKLG\5V]SEXQ?\\f@kH;KA4aL72
IF3m7FX^Y0qj4Umd9;]N3\[mWg8T^9lPPULMGTXUaY_jB<<^``Y02oa4Mjo4QQNN
Dkn2mAX?O>19]lRcVWXYdXSRh?\PaJ>AD6Ji[[4Z386:=G8gQ:pfLFJDGh0?_0BA
WVP1E`CdQbqNfW>b>VZ@oe\I^Vha:]UiJP2h5TH_ofSbHKjph@40>7dTcn59Ma\R
nA1C2PD?kHiN7:D_c:M0mFH7=gjnO_kNhd`ZR[A>SeC6EKQa^jHh>j;RR<>[HFEX
HS>HgT:7@lL7N=`6okG>0U2p8Y4feiiqn[JP?XbqM3H^`]\U16kcnO[jBIYJh1p>
ObWhc0Y>iYalV\[k4O6WQh_OO[P9U8<XZ;b3\g`o`hBa7aVl[=9Lm`j;MhRaV4Y=
ALaam14>imohW1m_7mpMK85D\1po6Zccn@Sd1W3Ha=^B7T<GH8gl4MM8`QpGon]G
m4p<RJiXFE2TmqK_FH7O5fXXV5D0F2_n86iKIb[]]7WdiaITdH_[DA8E4cI^Q0F]
W`BQ`W:H7k0;8NKDm]T;l:4oROGfobNC>d:;jl8h^Q[3p9?b53iYYQci>]9SZ83V
Vp65L0[gAp5b5o`WlAgGNTE^^H1`oOPh5DY_=n?^LM7@k0O@nBFY4mSSh6N0R`j7
pA4hI^V`Vo1c3VX\W^>[qKRI\_]?pK1M]LKpfO5XE3?ARHO9<9S@g6OVJ68f=;W:
G<g5\3Se\5hiX:?10?bl;70JY7a\f@k\oZGRfU5XKEQ\WL_QPh^1pRI2cZ9QGVgZ
lFJEgK@@RMS<4[gA8lOcd7?hXmkHSiSJ=M_TN;SKcKTFhUVIWI9C\R[2cFJ@n0O\
1pe0WZ[Eb@OWcL>FGmA7E`iP4ZomFC81E^X]`BZfYBmOEN\Q\GfloX>NPbW7k4O=
cceHWZEch6Yj08pid3QVD6?A@cEGfV\EmDIPNfNI8H6NVka@gPUS??;QGE27KHRn
PC=`][3DWkPNVdXK?ScpZ3Mi0R1STY?ac0@cYeZ:E]CC=VE[:_Y_kX\mhjP6R7DZ
?Sa:bSQ9Q>UnSCCnfN;XK?jo`_NQ<D:qHlCLBKQhJGZXM6OcOKo<FcW6mF<Xk]UF
Mg=dB2EBg1WWe4N_MVoOGCVkWZ`io9LAnEK?2iREiEpMGYm?KMpQ9eE>Dop5?c]c
]gX1\U93T0]D5RbTPeWT\pJSC3^M0Y2OP^A<h9B2?JCo>:5c\@cV`Rp9a8NVH[V\
V4:37ZJOZWb4Z5^G;G[J?XGETc6@62?8XW>4S9p:>A]9JZcbEfLM8E<CiqUD2Ok9
$
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
4hIA`SQd5DT^<32]b2ST<1\NT7^>2_QD5ARcOD<BVXAQRK8oo;j[L6pEO5aGA3J\
;IO9bnfKcopA:dQUPDSkTIb9L>]5oZ^j367eVo1K=SFlGBk\7e44XKNSNSMPcXEp
WI`MmPpeDV;;5jWQK82mbCnaKFD<Dl@oj3`TIn<\1Q>9GZnLlq<<EGfAbqWG0FHX
;g\>g7eY=Im4Lh4oRCGP6dGG?=lO3\:Z@LS0C^o2hOf?F5[Ia3q=Q\LAo>ZXYKe?
aJi1DIAT3=VKFoZAiTA5U6`ASg?6@3pYR]Pn]TpER5X`Wp>VnOhmTGHfg?S:F26j
PUBMc<12H2Y:DRW2o?3DL1oSbi?:;L3`]Pj]DFZAcWCn8V5@gGD^L0E@9F4]QjRU
dN5Z8NBPYh6Pp<SL=gX:L;QN>5P<BQf@Hkl^2UTO2O3UZCR>[d7dn48aaRUOULb2
\:1dAi8<??<TceoFj?<La?h4UW=oLhl4m0ScBECp9I^IJ`mlRZKmjb@\dBC[F4g6
k^DZSOk2V^3NZdlSh58n3IEke6m6_Y5>2[U8MikIH>]UXg1E0c`]0`7:7d4I@[;<
K<pA35SU<5llEAU=lc<nN;ilOWH=?bWRL<kjh\XmO:TFNRIGkXX;1C1ck`7`eNQ^
[oPJOCX]4R6:BOdB>Xa>o9bPSF1q3cJk7eW6[YWa6eFnDUfl:4UN?;bIS=CYn5D\
=oZWF_A_4P8qN4@5UFYqQ@XF8CH`kRLQmUJ<?8VI_4P[AITn_dIkeP4`Bc60h_0\
88IjZgDnWTMVJIcZZbTaeI86@[Bb:MPUW:GoPi]ebf=7BT<c@C`J^Rp27i3\J4eM
:9K1?JhMiWnI2qFC5f<I3pBNDQK=pP\o8Ub;Znd^mH>]T=Yk6I_FCmFUP@aF334g
kZo@4W>Q]_Z@hhJWaT;Z=lKNl0YN_JNSVC97cYA^`DdD@]iK7Q5AIUZ^Y_Y0ORiQ
ed_EU6koBFgEo6W@5G=o3cP3XIBIHPWIf4KTqggRKAaMWLn6YTW9>XFQKf7Tb70F
>EF4oblH:3Nj>kOGGa>86jD0hJ9<3GZ^CU4ok<@EH8[R8OO\e[>VG9AMij[]ORmp
PH9Q=Sj185MN`?[fSLjUoj\l;JWnD6IL4oSWUXgTRLeHJ`0i;UHU[E@l`1e9c1nI
_7U92R=1[QQe_clL3JfZgCF:S6qF:Tf>eGI\FGZbKZl<5`\3`SD>QN]MDm`7Go?O
;KDI]IVJQ\GS9HH\0Odadgbpf62:21WWPk36i1lJY>hHRh7ER1Gc0a_6GcTb<mUP
iai<Q9bN78WU5bfo6=f^o>=`?8bH?JeNRfUA[ChHa0aEhVQS36pJOKBCV?LNW5QG
n`UkUBe@1cHoSR8gQ0SSbX3^Tm2<8:iiXo`]=B4DE1jDIb=3kUV7;UO2I\Z[cYSJ
CBZPN;oC:@JX60E@`bCb^pEJJKBAL]05240FL8<kRil38IoUdZj7[Jf0KC=hS^>f
JOj^p;oj;1[gBd\Da?>4<7_6b7YpY@@Pfe]cQ6gHAS9PW=QbYHZG6e2g:Eg:p<i5
EPm9SnA9ULBJh;;cN7]:9lR\[HK[2?43BMPFMKKK1OaY<2W@\k:?QRH@:]6A3XO5
:QMGpbW`2Aj>7I818S?<3bAn9;?qLB83E3VknlhZSO@mkLamMieT?I8=fP0KC1CH
E^ebf3WAZGMPOCiKGL0Fo45mVS`?IWf\l1>0iXH_gA@ik07;_ibpc4KP0:9pR`kJ
EFLq8X7cQ]fqEd7G4^SqN=KK[LW[NdIn185[nK]2UhCAE_HZ?`GdqE]h5XD>bSKL
=chPUJRja86ofQTRQGNDloKXdfjSl0@0HaQjZh\Q]o<WMj7fkjm0_\2LD`^_Y>2c
5akQ8NGJ[<<7PC[8gZ:dZ?npF`fim`ip46lWGkKi1DmfkJPiEE10aPp\H[m;UoqV
?eI>YPn05To?>_LBWS_R2eF4?<bBF`a[dBDmdQJqje[[J?`1fX4X`n@UW<N3^Vg7
_NQT3SJRW2D;L798FU^JdQa?nicqTjm8Bm8?2mdeNA9IbM[ZN4jA`T\eX]m17Mop
T7U^jSMiSWC@0jYLBi18SG5ZaF1`n<W^5APp]G<H?cqZIfSYP;g^`]7L[?iF6g;q
KfC9J\Dm^j_=`VCCXB7[EN2Q[id19U7]a]KhmW]dJWpd5Y`=k[lH[K;b86GiUXM\
g946^bj9SOfEaD5Q^7iS1qP:SFE1[^\Z[=8NmnIYOR[cAX8ETJQf\P5VdGH?0TYn
q6nB5^FSPX3@>VR7JUYJ\0T2jPGdZJBWQ2[?eU5`^?KOH?N4f0^Hm40DYS1IIqhh
D6Zo6EB9G?P@49K`<4<Pi1Z?G6VI9\b<J;Ha6eMMqFN]53\MpimKfISVp?;0lZ<q
53_f<W?c5I]HGo^>Pio<NGPUL23qgJcVacLpF18CU6Qq2hXU=`HKg^\VeAWCZl6X
gOfPN3dML5Se9_`O[ETi:`jkjJ<TPQ>_pNYS>^4>pU1V1L8B5e4=WnhM>jlSFJVU
V[a:_D6Fd26gVHP1lW=5m1cEejmVdbbLp_Q24HH1=6>T_Hlq\;H;LVfq39a`@Jcn
Ii8Lq`62Zf=>MVhV1h8pg>CkonhMMh_hXO<LFYGL[`5SMl<6>oqbiLA6LhGEHQ=k
CpKe_7;^LhoO18=iCdWCX:D_TXf35g6bq>MY6Y?dW?eK?nmZT5caqch4YCP^BSn9
h6Vq_LK5AKZ7gAmWDD5CT8mV`I12WcTPH=p\025[fk@?MT<fQpFYEZ1FTUYdXhKk
<W3d;F4ec?PUdhTJq`oKCC`Ef[kp`FMZFEE^<mPeHTVm^7N6aC5n5Q6DjkW^^<fd
HD5\59qUBBV4K9QCIQWkHPYc<gi0\2h@C3f_F[qS[^h5Z0pU3UHXWq;CNM@4l`Z1
8HL;C12W\VUQ<SHFKaA4hV\>a00j=g_?APnk[1S=5djD3hc;E:n7BMO3UnFV^6]A
?cC0_iM0Pk45BAQ;bSNLUL\0ZYO3C;hgf:nkhaR5]ap;T0F@FdIULlO@7Agf>if7
jQg>o^`7mLOjVXPLFioK?W6oEZ02DP7TQXIQQh`W1^B3Fcn[6@>;]j_UB9dnTpNa
YV6:SPaGDH6oo4BbHD6Yl9YXCCL5U3>`[5e<<^3;=n=g6?12C_8__XOHHam]Z=h[
[d?e9?K>iR=5oTG7qCSC68G][Ol6CDB]KKC<hFo4QkTg;hTjN[HX9giIMVH^32>1
^bP9X5<[1nNcCPid<i=\oJVWZl@DjS^REZgqH1oi3[IpTLX=b@RNM[K8LUaR@3F?
TB=UdnO3AR<XhAHHm;`nn\B;ZW6fScoLMdmCYCAiQU>;gTfoFS<8k50NOTnO:m_L
57W9WS5^mY^dh=Akp[nRWRnHKVY6>kFn];28m?J:2TEC4E36M`HILimo_>P`\Ibg
X4omTRT\Qp>g8M>6<9@SL^:jX_F\a^WWqgZRK@\<p>go=64q?;ogM>59R3YZ3N`V
JJHUiHXXU`H?^hLV2^aZM;ASV9?jVBEdVGGbG8NdIMHb?KkMVGe5SO`BQAN5DS>n
33U8i0e=L`SII9JD5Y5:iIH_b`:ST[@NM_D?E@B8bAOl?[kMIcK1HBNk:\N5D>[S
hCV4q_5g3?VeQkSlkiVf=TbTBMSWk594?FHooc5U:8>g9MTfTS;KN`QQN5HUn32k
5WA]lQRC]1`>I0i^[=bS0<Wpdi8U<QQi>hBmiZ?WcfR<2AN<pgHkfd^JOf617>G0
0PIGd2E\BnIilgkhTbf2\cI4ZN?B:h`h8U\ajJWU@lUlFKmM2GRKaG?OaIP:eFYD
g5Xp>5gXk@jG3_;ej^b>2BFHTK]`7gfD]=Ra[8ejalF=[kJUKEF?_coa5@83TI[H
5VTmeJK^8:fe^?[M5:\5EYqPG^9n>`Am`QW2P3aFk]W_`UfZ_]bjnHV]Z2b\`Sc0
LdAn6cUfRTdWg9VS6^GDFCF;XFic@da>1=bO]dI]EjKZC_[nc;J4l[g]?[?q1R_=
bXnYRa]2bQHU`a[04?EDlaEbLPUncF]O:RpAAkdS8?Zfi>jMML\KIH2B4VWGS`]c
j?Vq;LQ:]ZK;CncOicAIRo2JA`;]TJQ^e\e1;2l7I0Ho`BGqc`m]QOqmMoRlYF<Q
nTCp:lLJKbHG\c@kUTq75NeP1Bl^bKTfJ7Zd[Ym<5WeH`RRic@>GRnUM6BA7`qZQ
PRHD8j@0IKN=Io6DSQgj5gFG4<H6XXc32S84VZ<3qfYnXJCNciiBkl2T:aG2^E\P
;a[b094no7ca9=:WB:=p4LmbXg073JKl57^ZD2k9_TY_GQXgQ;c3FaZHAoXAHXq3
d>D5`ip`LMg\Qea0Mc:M]8Xm]SZYDE>9\8oLER_;Q_3fhqXgX>eFgqLSF7h7qjk5
]c<HcFLILXJq=9:d_iS9QJH1Y]B7NDfp_385<6V\MU`FBeSdI:T\F[Z;_>HU`@5Q
oNGZ2`2157RAV_`hF1KFF<D>21iMN9n^b=d>MXaHJ?C_>4ZAR1OLUYfLhK2qL?@@
fN]poOoUY5iBpQ>[=[O;l8?PL]F`b1STqVH;=3Ygmi:C=Ph;L0dBEO?b@I1L1c2<
ULgB7k9eDmoC?OE3ZK88bjb_PFaIe9=YXcfnJiBp::AJDmGDjGcGhWLeL25]ckKg
I9S9?E`ojmFE`g7B>:[0A0b_lHc:7@:fe`G[MARn>deU9CF@cm1KEoUClF4]Y=N7
a]S3bQf5P=qa[<P0UDpDI9dV^E9pdfg@`H4q>8mN4>`qH`BC0j>pH94l@WM<B\PN
E;h\\6c_jh;k7e=Jg[T65MB6KUIR@O93SQF\F:D8[Si3GmHO>TY2odFI6KIW\CTY
<F7W<EHXm=jZ053@CX;\HRp?@nPVe3qlS6DPlgH=e5m1eG1C=mI;AIZ14L:Bf\Ug
D?KHo_AA0c[SIIRUej6U3?S50qCTM@WK<@^RBBPhllgm<Ummp??\LCi0pjSmJX^R
2[?NTob@c\@[T=DUNada=cPdN`UkphdGG9XXNR4Ic1]biTFRmZo[0WK=O=i:>?40
qeC<;2>ep16Rl73YjX1l;@^JT_9JXLo89B`3YH6pAKQ_T5A$
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
6eT\;SQV5DT^<^ZKQG`kXT316B5XW6DEENDXF3_]:ZEZMYc?mOF=qWT_>?4]k3L^
XDIc@?`EB_0qMnOR>XQXaF^n6hPgLUVUGEC?e;5JeFBaGB8c7X3\M]l]LigW?Sec
g2pihU8l2q57Pd_fkjjmCfSh:=ioG8iik1E9HCoR23q4CoR<^W6^aKQWg89_JMo_
HpU3VPfH_1WOE28UNMJVVRpUceP5OUCYhJ2]mOn8WC70bE:hKoNObZL5BpX9ZGj7
:Kl7dgBi6Hd5`aOcGp_1F:Wb;d6XG;7=N`Ya:`ASU0<\FLE`X;4RfLpWD^6YZ\p7
5g9@8Pe;CGdekUMF3BTifGHTNL`N2hdWF2`\0il7V=7[MLf[HZTW;lp^e9?WRA@<
EOO^URIGV]2@O_A9\?9cC>H5oada\h7kN:UDgeAp]fiVBWA_E_5=2mET8GG@gYZF
GH5=O:@0b:<:=@il2aCp>TJMIL?qC]T::ChCW@aWHnUFa?ekIKoPC9>DgU>N>HAf
e?kVZ2IKRlJEJ`eY@d5`ZJ6h2:FSZM8kkjKWUhMGFF;ebe1GPhq30DIcJVA6TmE[
O=KiI@:bOXmVLoCc3GV7heL]On?IiD?_c``OD?SoPnX=dPA?L\9VW@V4b\?qS[<o
5\1qbji;P=bh<OjeYI=Bg;n0MWBDNL[n=X\4p=gJmQ[G65:`Kl>;FBhnKZ0eJp1k
=5cmlqk_3P]GWCf2QW_61JHb8PicqJbndgJ2qUW\?k;Z:Z?m9g`ilPR8o[d4^hPj
`FdWY_fJ=50qJZVQUaip:`3V]2TL=JT<1@BLb4Co[P7a2j=n>bh5AIVL8AB30\4\
O?L\[Z4`]UXqlM56G3VU[30lVN5ekl85f^CXm50b]c;4kEDd74f4GJ[`Th6QqEH?
ICcBLk8hl?GRkD@hcN3;Ioajl_jZ2MSGb`H\O^]BpSIKFAQTpJIH]4bSoo=fK87f
0mgLn?L2^=mMJ=VJYR]RJcMbRSPNVp?DFLjT86g;]ajh;CY\aE>?Q@[Rm\hfl[55
2J5mh4g63N5>Kf0M;o;Al5K^m3=h\d4Xon`7<X]9QQdUU]1Q5mei\q>EhO:^<p]Y
j6QfDSY5_g:;]`5ib@?3P?i?3OA^_dofTo3`_9PLAR2?_>7o^nAQXd?>HTi4h5RS
`ih<J;0FFW]]>JZn[epha6oO^>Bj3^3FYEILkngdRMLZG\jdi_EcO1pVloA_kWf>
dQ1n`FQH<Q?i7F3iEPiW0G;UoZWP8[Yf3kkKChm0BZFB2`B\<JO@b]I69EJ6?H=>
TRof9p:mNnjkeqTmBLJ87K`11DFP9bW1DZReKnec8?`GOj;XSOC9P\K2;:FCaY>2
:BlnQ\6WmQRAoWqfP@ZB4@90F?NPFZ:INYWpemF0Zc1ql]ChJVlpQOk5]DjaoZQ?
[?:V:E0ONTTISAljbj3h>ep7;9AnaT^GSlH7FYWAX9LPMEAbeq2;lJk`KqeWDeJ_
WqBSfZlj7qY58=f;Zn@ePheCeA:N?eLPlghd8j;8m2HM5]nHMlP5dT[>Q1OoDm4f
Bcj]K0g@aTjdboU30Xp8Z4a0S=]eO1@lNI?6@]XN^>jOf[KcL;?j[4gXlQ`qFgU<
nM]BJcbiWHmdkB1DYMNmZG26CFLD?Tm_O5Ei>7d`qJa;2lF8S`6F^a_<Ue<09Nf[
XMY?eoJK;5iGE_5`:Z@^9Z^DK<3h`ZZiWqbKd`J`cE`ZFL_3UG>T^^5V\NPHB9]Z
9TIjDD[][NVPE@]I@GjCd^mA4=M7TXq=_j8iFLp2]OC_Ji2k1pC9\ahBS9CKE[DP
kQEl_nhQ:P`<1[h1c?OTL?<<P]>AZB][<8q[POT1;SUDSZ5aA_i5Z<4bnI>2RW3]
Y9<^X<_I\^nI<K]GThSV4S>gd>kILFXbGV4D5MmT;6pRQl7E59Ck]U>lcWL3>M\T
J?B8_UoqHP\l1mmpZFQ<fJpRmG>:jT>^:MiHABjYXJo:lDHP6W`?;n4:ii3INV<Y
lV5qEehfBR@X^KHYnAW2GneKXG<?`6A2K?fWkfc>7^RYYRjfqoh[o6`M\Td\Q6k9
YG`a_4kleHAFoc=A3@DLaN;RNZMENDi07Rb7^UB=:pX87IW53aG02KVo88V[Q7JP
d\R=KeDA0c?THWle]ZCT9oi1?K1\jSU8PQK1HCqoHhFcSgpOdllZQC9N_p79dF1A
U1<a[A@VVa\`14YL[n2?3Bb@Z^C06W@1M4:Bd=AIFj2>ObqI][go?IUD`jF=Gc`o
>Fbd1MUe<QmX5FBT^F^=nc`1QM5JW^I:9`7XS`5SL:Jp76mUHBF_b8W[\dRj?i<P
0@eK6?J5GREelBjlFT9L6F>CSFP\aaM:jiECjh1l@43M5?Ok9e39WgUpHjEDe[Iq
eH^P>DqOG7RG8PfGdleT=`Fg>8k`9X`hE7Z1KaHkQAP;mN_Wk3npmAC:_E4i]Hh6
[ilIiEOAd2eooAXQC6f?LiV6VG@M_VbDqLnS`UVQX>QIWa^M8=LBhh2bZ^\bp_bQ
BFSYN<AWJPGgPhffAHHTj?ch`\obMFd9=H3PiaGN_[7@U<nW\IUH4q@F:2<@0CbW
R1n28ecQ7U7>0QIF71MoQM5TFjf0ZS3iL\Ze7eSUFiaTEDD@mNpl88L^i[q7:>:V
^dHb_DgG1h<T@CM7;JNGS:^ll\^oS?BNFifZgl[PZE<ATqWQ435cKGAJpS3Gf_9C
@i\Zg=G?neTZHkO?ZoGcLZ1a[DXQFG8B9UAmg@7\LoQY3qWdJAU7Pg3_:646\A65
B7MWiDFKJ=d>B@l]S4^0edSRf=K7VWaN`D1`a57;C9=`k35XG70SoS_`dpAj=Z4B
mpYdO?Ec$
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
