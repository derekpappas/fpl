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
ZDbMVSQH5DT^<Y?hDHSTHdYlDiCAP`NjRQpcnO1dA\O3AaQTN79iiKOjK0i1Ho^l
@^XAl1AF^ZH2SboM=I;GH_J@_Q;b0poS3@=8Vf[Ld1acQF<PFSl`pho1kn4pgW1;
?6pVoXH`UVqCi=@o>`]36J`gZ=X12`qT3U1GXWE^1m;E[7J3o]0C9DWLFB3[fTF<
cT4?ISX=3CNmdcl=\jo;ojZ57Wp80?KSh8SC6gXe:C8=mC_7;`E7P>6>UmU`CPjb
4p63Umn[okQ2XO^0NP6P`8L8L:=bQkJLNneLp[UjcmL;\jAiC2Tj;IZIe]TfL0ZP
^4iZO^mB@ZIGc[c2pJE6J>XO[ChYY_Z;;19RCN:8JaeYBE5?4jk\;>;kMO1op1G:
;4dYW78[a7GVQk01;GT_D@<:;h:^Mq:`_kBc9Ak`E>o:0;KEfaWllfjBKFPl2U]1
q@8^=4a_To_RF8N0dP\DDHI8JjAa1m?gq8<G6B@>TQ1VYWb6]EE[nK1BFKbqG@_4
9Ub5:a3T;ILKIK8SnoZCe>8e1:Beh?mMlCK\7LLfdnJSJTS?0OK7Ljp<WXJ[^[pm
lCC_OYGHC`HU@JH>e7MQkPH^5K[PJD@LgJbqdCk4??f>RaNLfChKPb3WLdU:[NJb
G`dSL8>2nOBM97>:qP=NUEAIpUa<5fR>;N^9gZGP8O0LTVb[F9@:iq3h3F?]M9KT
ZFo0oY81_;JondlY7^co<IR;[TmH1VH13SL@ih3mP4Q5ohqlQMbG:KN5:=C6CIAi
>kC1>Ih:b_CEEZlYaq^PDPbNWp=4EaHI:LYcT^:@DU7g=:UX]K8R3fnE\=9]5U[@
_HKcF>HM2DU;CcJV8SJ>Hc8EBC8@pN?6`QK4qWn<fkk=?5DhgS[4<mTn\;nROhOf
56?[B=WTB^8OH5nGXJT6=iYJ`073U`g9RJG;RobP3dP:127olUB3?@omFeMJlgY:
Zkflo6dSInb=k;=`Ejl7;W@q8MZ2O_R[6K`5TXTBP\3E:D:@BT@EPkkfY=:6=@i?
EnP_OMU=h]X=>MT1DjoRp;n`8i`5W1XOFnKfND>Ua=VN4FXO<Dl`8J@?E=0PX]RD
AC:UOf7p1QWKYV34STh@?M;KBB>kP:oIVdW9^0faW;VMb=^l>O?\oiAMfXo_pNim
`34<NV73T3[JU9YCq?j@NkY[Flbb<E5Y3dBS77W<SnYRQAg7<NIQN16;Gi5Q;d59
;CI3iE2FMIfZ=AX?\qEDJhXThEG[ZooOiM3Sk9F[RlgJ[QAb?gTT1J=mHCM1iiHa
Gg:o_B`HU@[[dpVQZT93o@EJD:9oO6@TlNWV>4:UEb@2eRZ9gg10boCelJfZC1g`
W=H3>^0X>RQU]>e]1G<dk00:N=P_3;PnpoK40BhQD1KG[oE7M^TcXW@cTeSR_EdK
RO:;N2Vo;]PnNME9B4QZoXRB:clgVd];@PXoMOQEGTkf4nN7c;>BGhd<V_4=c2V2
6jC1\_`^R:Jc>n4bq:[iO^:3G>IYCgN5QBR40@gN3g7\?GD:CA6WlnK6_AK_J>2O
7o>AY8QCmhh`Y>D5[pTeao^LCY66aoaE4SS:<]WnoSPGLhl[[ebQJ_I3pd`0eVX\
QhR\TC`?23<DaH2Ep6cXZ\16@Md=_S_6BE`9T1MdTFUk@gWc@0\;^TH^Qm<0C5n[
1T\VjD8gO5P43[?e=kD8Sc\T4i04KYWj7jPK3>d_NCZeee;X[JF:^SOpOoE\1A^L
hUm40H3eeIf\dJa]8NlMgM8Z]A0jMi3ZJ71BYgTWBC`CG_n3oJ_5`9AFBH\dYJ4Z
\BqgGQU6;lZ06I_f73pc@d16HNSaXjD^70:VRO;GLR0DAXd9X;P7^C>hcp9:RINF
9C0KaB1l><YkI`\BN@?Ro17H8^mdN6DddpSM]1_=d?kCfj[M8]7;\jL;pCa[g4n=
>`6@lY]0SJ5T9o^CqHGh]5e`a1iOP5=5OR^dGdOH2<oUilBP>H8^CQ8H86@aQIEn
AkIbm?=pJHJfcZEA9a[Fg6QkE0aiS6Mel_7aq=8ABkL0UcEX^Pek]C7I4O:G<c`8
:iY@\3Bpj7;[JneeBR2P8_U0QgpUAVUZg<P@a1:W=oX4E<qK_@TPXBoFB6CGEan2
@]R11B7;]YIdgRCgcmq7`o0Q]08l:]D[97gA<iA`R7XcCk[Xjkf^]9B8LW2=_<oQ
1UA=YD@]fG1fIlM2=Kb9noKND02iFS\8DpGcg>NO4_6]enmk7^JQla[?I=RCZCi_
?_O0bOUEWha=7:@i`SPDX2B6P\gT`SikMDGj<lNI$
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
=T=N?SQd5DT^<a6lckec0YNo6eZ>D\kdC5WB[iI@cicSHZW^WHnG0f?M_k__pgaF
\E]cH=?WO94`o>6bj_Cd26E:6X8n8DOm^`];OREn6h_:;iR6p8]fj62f^^5h]e`\
EkGfZE;VUeGpbEV4aDqGdT6R_LY>GJ7`BhBDGNedE:qae9b4GDFJL9i[]:c[n1`8
mLKhAie7Thhof7dZR1kSHh_4Enp=J4BR;=f<RYoSa<2`ZQY1[14eUnE;Ul==1;fS
1q6[=8d^p<]HX_i\Z5Ti@giCP?>bBF^U0@e\q^=UbNZn=nEV9>j2p7?g5?XdfPb;
_GRemAc:6<OCidH>fUa23^l]0I^qS7cde2feL`7:APTHF@D]l=O3>;gWLJfB`G9A
RV9nL3@O]IX9Sh5CNE5O6\?k0^[pcGKjQ4d\`aF<@^FK7NbMm3AYhO_S9Db3O7AA
p^kMJOeRpjTX?KZVi]mFPcCgAZEGCETd?55IoZB4OV:V]Ie28L:3E[Pc6igkTL3L
cRT?l[?hp5hHa8aq;[@RMlQJC\TBN3iEd:Z\6n<Y`7AN_eepnd3b8[[a=a8I;bPn
go>[m6]D9IPmSR11TU04kK0qUDZed]ENEeHY^5bCJaJWOA6;J98[<e]Mp@N^:eGq
\P4M>l?`[k>^@A1ISd@BO@^cq2hiAJ9j]YN?RB<mI@jN0>D3Yb;DWcCnK3?QYo_T
9pn=ZLCi9h>h1cE1a2iCWXiPGC3<K<i566DRid\L<I1JEW9XkTANY;7QqO?;@8^c
^ObC8GQGG;lZQNS8cVaLUTKQZ1Rmq>e0;keqL<35a\iqRS0BDJa1kDIa3D6\CITR
I``ab]^X>fU0i??I@A8\GJ@NgYAK;gM5<5pgfQ9gYGL6G4Q@PO14lKV:ji[\S:EM
OZATnAZV5N>8YaVCL;bp?R9APH6kO:O\6P@Y9a;b]1q_J30UV7VjmP@RoT7Xd^dQ
>\peAAf7_>PCjiR9J@N3BmTA^kp62WZlaMPE`[deh]oAGWdF1CpJZeGdcjTjT7:7
G:lHA=PZCq=g`SLc6jlOJY1?PEJ5SGk1q5C:U<B[hQmm4Gdlafj;A^jqmBN221:c
Ab:W;<fg\ODbDHYo]9knh^V[GYPdm;dWmjWLNQ=nbn>1XA]iMan1^Q]3qGaid\Km
o5Qk>@[3Z_@9kB?CJR:]pHh0P79l\8cJJ=AhEF3Z:N5>k]Y4p0WBdd77=PdKH=hN
K7QliM14k`oBapRPji1MHVI2O9jf_c^D9oA4A4mcZ:pY<=^0DT1`EOC1n@;CCMg8
cAATY0poKPK7U1=C]c?5lFkJRQOMI:71D_=>PmpIWMj:Rl4F]n3<_\fK[6KZUJTO
N1FZZ\Qp3=k9cnTQgDU;L[\5lj6jWV[Jg;=]pG42AoSi7Ajg;Kj47EIYRB3;Zoce
\NY]=aWh7cDUWdn0[d4h8>Q\LXa3<\6qk[mj>DJZ6oYAV@Q3W9_1o_o??ZNY_Z88
Zbd2T=5PQldL5?YbUREq`?j:UXFSY=[ZhJ``_NkB[;nCe1N\1F<E1YpQ1?cD5qJi
=7L6pZna?A0pBT`lFVpQB;UjSZdSQFhLn_3H;f?mY:okmi?bkWqlC2T_?cOh@<So
XbE3^dTbN9878:1n>]31<MhcCDRXe[n;c\^RiG928mlJRPqbUAMkH4TCmN9EnD4B
_c5ZQk3\Z2gGLhqfK8^NUB<h`>f\WCbaT[8aHh1SIW;6`qNBl]<P@[Je88^8RGV<
a7J?4:4?EZc^q=WN>=RI2?fncUB]K4P<pLhWIn>p3oNa_Mp0Df]DHq[Q;kfGp>A[
ThU3XM>6>blidDoSLf7Wc4FG]Xdk=k_Tf>oAqhj=D?VMEc_bTR410KgQ<H9e2mQE
h\@ApjGJ3f@8f_dnUCO;L5@`QmN]4`<@cWO`qBiiDgUCPEj1>l?\Qo]O0Je>PgMi
M:kpjgAW>P[WV>GNn403C]K@T58^>UJGTep?FYV]0hfqffX^6:gp4>NUbDq=GEHh
iiq5hl10;D?L:<Q:h`jXD=pA19\8?GZGBSk1B:T4=Djc8Z3K:g:5_6qPSgMYm_6C
ei073QjY0h>YZ@Ml@Ql88[pmO3l6\mfR<DSYD2]DB@G`;g]`\5D38paX?V:Vde2Z
c``>;INmi@3d;b>bd=N@CMB?RId01HFkk^3>hTIUc<=apgHFZQT1Rd]:R6Jc0cIc
28Cj9HKcgT=pgI?5^`:p<[]g?cqL1Q4eKNp?`TIaNJm8\R>@cJCOHZa>IkAq1a7\
5FH<U9InUM`ecO=h7ID7:M=GU^qMWg7m4`j6VfJJ`OYQ;\YTO:MHRLa[ZU:cEpoM
ibB6V:\eP5Kgkc:5TVBBZTg1?:2iI3p6fJ^B7=9lUW[@02qh?>dMl3h9\>G[600l
4DJ^MEd8Q:=35LX:fQ1=U8qiS]eU`:3T]7>3^jEnUSZJGLJdLY>T>3O?PjQMbBcp
K`3d3ja[:^:D6\C4UbB92?Z?eg<1EFcoDo_4qMZ_SafWYl@`7M1oBR4NGoigJgLd
gHIdVOlZ6qF4?Me@O@dB`C:7nS1fn^`FC<]6^;TfJi@9OXqWliTRdHFb_dAQGlCp
ggIPY=fTYN@@998^mhiZ[UPg[BCBW<Cc@aGpNMmIHfU9`5Dl[ljCQMl:5a7ViZP:
l49gD<QdGlUW?V19[8C7j`coUo\]Tnq?BZI4]7@1H=b?Ih7SoS990?a]O_Jl1miM
G@qA:3<CYMpnmV@`kRRF2b8X@>Y]CqR1WG`SI[l`_XFopCoh<mEeLQ9Kllng3e<B
JW9AkVfPac`qfo7k>UeIkLSS>F0UBkaS<h4>l1`=Ye7pU76NC_OacV5cYbH?j8mb
PTb:1cGX2d6pFZ26o^Pp2:OX5VMVH6Q?7:IYmj4E@:]gGR=NEEo2B1WBQ7Yo5_[f
<JalEgZkf0al`]l14_Tp08cliHO1OJi]eWpYGP:fd45Zo^Y[DQe_@nObn9V9=`]^
d7N\ogqZX?@1IhU^Kg;^mJ1KONhgW^8dQ43=elEJ:77p2f`c^^VBBoH[81S]STEa
`3f2kJKKVJ>0q^hP_i`:qUA:<o3AL=g3go=kgV`aigQg1GL>@kMDHBF`qEHO<OI_
pd:USW42a0i0R7f8eVM23Y5?8cF1HhbRBGD`LZ\[OP2IXf8eMAb04k3?qhRleFE@
P1K\mU]dK>T3S:h49I^^>m<3ePF6\WoB\;9^Ydk]ME0Rng@NXO7PZT8lQ:BFU;EV
>>Y\YUeJG^jTi]0\ap?EZLhV9eiC4GlGC6VSN:e^p=\Z?VBIa@8_FdWkgSQo:1?C
8h[K9pOc<^9aa?>G?\ZK0FR>qJAl]\RY=P@UjkN[aK4?lULFDkn7FRjEHJh0p;F5
OYJ07@CnVNc6gcJ_oP<b1gfM^8dmYCIe:\^Bg^TWk<1Ic288b7`G]lkOk`l_HnTd
`HBp8CCGU=AKN:3c^:`2Cj^_d^T6cnkHYI\jXKG>cCdQGg8;N4X7m13HZa;gFUNZ
@\KW;MkpV`4cZNQp^4=ILE=j8\[88Co`PdY\gc0RhVXMf:mcFQ[8k?O5pY62iS7A
qhLX<ehM]Ko_WDMa[BIR=`XcKBAMYBB9[G5?BbRMlHhOZo_SWlBAAkhTminLMJ?p
i2f>\E;p1`SaRX]oD5cW4\Vil6i[bTj>p_VW`<<EH45YW=EZ8mDkZ9L3EV<KKEF7
f7S7i<J@D8=W7JEfK]]YmSAok:V^DSJ8d`DL:G`UIJI3H8`l>Y\A@hUMSZRAI=_S
kG9pTYSdYegqd;YUAY];;@b38Okddj7opck9lB>@FSL7POcj8O9k@flB>B533mj1
9=P8_PG6:pEBg4L]R1`Yo\=1]8UQ`W7SF<2MJfHkfb<fanNc[NF\A;4`5c9SI1`n
g:JKdm_omJVa:FGg4>fn5`T5Meq9ag1_6\p;`bS<f:G`NdqS?oKGYJp6O:L;\\NM
W:@;G]8GKdEob?5LX8\dKO3QN<[gj?pI4K69BXfe]G3oM[aVK4<FIK<M9CRFU9$
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
8Kl:3SQ:5DT^<NBaCQ[3QnK60W]dqhm5m\Ac;TF8C9YaZfV\Oq@G;7=dc?4m^WXH
oI3CDDkJp\`m@gnpI6:D?U?A`BZDI:OI6Oj<l<Pn8_Xk:V90WAIi2PlmkQ6o0c[9
0323dUlK?gqTcA;GLT<]INa3h`1PIhK82ORhM2SDM__W]QX5_QcJ:Hi6dmgVM9h4
c30O;n\H4M73Rb^l]f8[l_p=YeUfLT4<Gim0Und0FgOTXq;>gA7YFbY=SPnlbZUG
[:[N51aNIe2U;F]48iD@j66c`\G;PYj31miGDpk5DVe2Gc9AZ;[US@KkIFG6cCP1
Y00ZSo84dm;c?I`IeoHTWKA0L3?HVh[Caj:I6hYN4GUTo_AnEU5g=1@H]qV;fN1`
f1hbldJM^9[kiCTEHWD`9m9]IfGZ98lYV2jRA_b0iY5>amJP\iWPUL:UhY<BW?cZ
eqJWJAbDXpaR8`NC5ifefX<Z\D8fTV;6c[>C[1p`Q_<B_>XXn:7]jlLnS5E4DLNe
GO=YLD2mCq^N0GG8Rgb1YQgmEP=C\<JioolC9LL`phb6[TEPp0=jn4VN3lFfe^\7
W[:V^d9le2;cjQVQ6WiP`ECi_NA=iLJn]DC`WF=VXpQ1VbTLF6NV^GeDPD08;jde
OXIJmdo2?lVP`JdDbK;VTYF_;Bmj1YIK37EP:W^ClkW@V>6iH>F49Q>i=XF\<CqW
\F1Cmoqh??dbIQ>CY99njV4M8C\YFNT>BmbXo]pAF=1LMjjEdX`VdHR1S7jHk?C9
Q?@SW3W=M3@>oCJGUeZ[d=SK0bgmobcpG9Hhim>l=gn7VoXOIDB1\^<]`f;Q1eU8
^Cj2U[C;Ofi04dD<LD@W>hMp\Q@<K_l\lHJN@4M^X6bVl[9nRk5CiEUQAYEj@N2G
n\cZN[j2YNN_381V`lR3]kggFB4@8`g^C:5aK<EQeY<]p9T16B`0ph3kN7V;R=W7
>jRD0hHdcQ0FXi^ABf5=plSVO^lp]kh?3cPFPSVc3clQWf=gfDCDgQ1>C=RkNY`e
1\oK@=\:@CGcj3ES`4:p\kjN5T;Y^;B0]cnpRAcSVG@k]fUi;h\6=:WY9hSelRSS
j`I@j=l?>gbAIPCE6AFH3bUOKmS>[<22L9D:OHG0XRoEPK=^EY8XlJ=qJ;\5]_fq
@UnGjT4Y`XWfO[ilBTTBNZUBGV5;p2A?>DlnGSnC^caEo0V=ob]A6O^U2@K3S^jQ
p4LU6ic1pn;^nk9;YojiY_4fml4hhKPSXWgm`dWc[_IZYQ?NafBQVhCY=REWQ]A7
^`?kapa_4nJdcFKnkNMSI?=j]Qf5cOKA>B\SeeLg7BdUl7GN^jA2;c5M>]8[NlY\
<Y>iATLA?fn:P4\P2gRap1oZVa8PGhGg[If]kL2<Bbn?9I9Tnn8ASMOk[FG=Zk0R
89lA0DRZdg:UPf7VOcgIR1?o>7nWGXPCDbXSPb;b\L7V1mHD<lJpAABgbc3oNo8;
`_K^1@KEG`mVM0=ek=ZGM7>1:ApOb]i4[MK_BpYn`N`m7W=?5>bbkEZo2P]YAI`D
7T]8l=V>LIPRLq7mf>R3ND10U_3mXTGd;V?`_0chh:hA14_68XqbcDhLoCg@[_BR
LeMd1F`[J;Uf\Tl=gbbYMFB@ULTW:2MpUj^gZ0Pq68Sf6EWq]W\<K4>q7nA0;mnD
:XoLN7g5AHaa>782oD825M5bpl86MQJ:pP@<bEQ8FmZn6Y=N^RK=RM<;pHKDlHQB
R;QAdd<VNak0c`i4CR6V@feI=5fhRAf;WYg`EG^GpT<7l>PliQmk^n3>\OaEI[[4
_;g=NqYZ9Bd0@0bM[RWZ]S>GZT<gpmR@Wj]BN1QRaDm`H6>9Zq7S6A4KJ6SkQRSP
E:J3077K613c:6B^TR>epXLESQGIaDTToj=Dja^2\]Ub5To_5NV0e[9pP7a;fLEJ
f50:cXn]Z@fYObng2oHTkJ68hGlFBioJN5^NUWSc\0\@@[eG[mqVFUBVH>U<QIBW
oNQ>]8A@1g2JM`p<am<fXQZn;aBWDYaH4\bj=cP?=7KlA47hdqQ[mc>i>pjhEDaI
e4ha4MLJUJ3XHlelMF<P=U9nqbB<NZCi]n2c:94L7C;4ipfcEhb=K;>:895L52KJ
d72lMZ_l7a`_fU_4E[W=on@D[I1SY?\:ZNgTDCaD5<I8idbYcRO[:\K_hMD?52c:
imohH<qC4aGOAQ8SCO_H1aA_B<YcoB`UnpQ6FHUi=qGkVg4NWW>IUQXZn9d<VbZO
hO5g]m21_21j=::UAdf>@HjbZ0gTfW;YWepKcABemE^@iBTLfZ>g0>e5:l93hi@H
R`R]dISa4oN?ndL?b[>Nh[mn4c?Xh7ZKI?SQgKEFcf1F>]EONLkaE]IWMJ2pAd]<
OEHh`R@1S5:Y@\6_>VZ5`i3bCOK;K9=8d\Jp1?<jBDY^540>hG7jSQq:Eh?g_XCb
2bNLkbf3[mjNjlS75qL5@LJVddWb_US0k3XNGi^dN^BeY\^ejGb;`>;mkM]ghmH0
mC4dn5EO_Z_l`H=WUWL8n@a]:EpB5IV_m5pmLckeQ;X3Z>XXOmS8WLiWeMa>5W32
43f73UeMXLoFm7nYYL1hVKL:<6F=Z\8bW89EM^V^1GBa83oEFicMBPY1V2A5c^>m
T:l@=AlJL22@Cp\6BU0MUUHK_l_2?RYKlP214GSJqS4J>:b0qk0>2a4Rg3gc5L4D
JChMUiA<q<RgNL]=OR;9oSeqJ?alK<2eFO_:7?2CNnXMXkIT<T=iAX[348Vd1K>M
q?YEZOYU@Q;kGHdkne:@6EB7WA6fo94iA5@eBO[anDO=BNmFBI8gNnh=EdUcgGYZ
=gS17bOXLDD?E9PE5eK;CO^1Lj6WCDVT`RRhAnka`l1WR1aqdVcM7f8R8?4L<5dB
YTX<3H59ABq3[d9^KopG2M3;eoMi^0i_PRWPF=^2MLWk[0QK6np<3hA7Z\]Q;W53
^bMLVFo3^^R86Vcc1R?j_\ZEGoqD;LLbUHd6mc6Ualf0HN`JlPqFZB6Ff3F57Xj:
O?[QGehd95=EBSilo9Jm5c137?9lPhEPP9S;Sl2dfaBci89[N[CU>B>0oo96KqM@
XcJ6KKT0^N13IOn>n=[CTjJJ1\qk4]2@;lG@[2NAIl`8>IpF[n`9P2la>MU[Y<OL
hXV_I_Kk;U\S>EU8;^pJ_=7g:HV4kNSn0K1h\i[`5PY00=>0N<h]P7n^VlJh58hD
]OnVX7p?D[ebQJ6q[OlbIE`5^W>oiY:TI\Tp7GjH2gLEJc^NgKTmFafYXj7VKI\S
`E:EbM`47U8;\@p75aE19>aJFID`A9:`4L`10DoBDIOmO_o=\_X@4:FIWqVjmDM0
NFjXU156BMYh^5gW=1?0c1jKgGm_Yp_PhZI]Q0jQ=g>UYiFfSUbZO6V<fdW7a0hX
Bg5]i1IlNan9<XBN`plJTlmL5Zq;G0Uc@6<q2X5U804_1mW:R[jN=DKSc>?2e<gM
UN07qP9PeT;HH6T[@R`L5QXPJbkq`U`JDHZpT=J4lRPeonRaB;D=VL[<q\5BbEC[
:FC`8Y=ZgYgN[c3_@CO3oHN<B7DOQJGFfN1G0?>3ZQT8EhkBKcKmmHljd>Q`XI=Z
l3?SiK=adQ3?@c?No3i=BI9O6MdHn2ajnb=R9MnMHLoQ8OP58533L61q<`W;VC9p
TUJQI:WX4h=CPUW[2hBfo?k>_ik^jTSojPH8aHP3RmmnTo6MW=X370UUjV4bUdTG
TKDdaUIqLOnFnKJc\7n^Tem5B1@59m;Td5=HENi_;Ii]Lg7kjG`YdaVW]IfV>7fF
k6DYQ^6jKbd7Q7c78?YGm8D<i2q0CU58IFSiZ>FgPbGNaDW^Mm]SC_6[7haCLk=C
UjglmCEMFR:M18hG>q=RD507a?\F1i6QJQUJU9V`Gnq_iRRj^>pa97CgMa[P>75n
<;k\kEY<WE4iX4BbUS>FdnA`T0I0OSY9mk94QkohIC7@=]FC6>0R2997h68@R^_<
7]?\jHaM6:nR?=C;]S>h@>5J<m1UiYZ>mfTFe\IO9c^X=`RF4BRVLgpi3oZ4X?pQ
Ud8?L_@c4Ok;U3]F^DiKl;m2>fpZ<Il`fjMlKjGS:AA;C5ZK?d[gDNZU_DXYEm6J
=ZP7mq`R?ikfj\=m2;kIJnal62XFjcl3TSM6niD37n<SWEInOXLCAF3VQL08He:9
3Zab@SdG?aI0Q5L1qMhjGCNOCD96Qa\CcH=5fh9Fan7\<VTiW2o:>p`D^n<W<]B0
H7HXU2WXZ@IS>2`1`NhBH;q`lIcoY<NZ7PDP;@U>DfpSiP[bUOq@RZjUGbGI7IHL
>=_TVoSJckK_=`[d\m;0DOD>jKDp\TT^4e]F;5f_\j_5JEJ>kGA\RAU9O7Rg4@Kd
KSDK=23B[;FH_MYo]BYOkb[SPjJY`gWhY9^m^E2]difoD5l<pM<0eVN5JCM_TmaF
[_OSQ`LD>q3?M@Wh`pDZR]d0bA4[89k3FbnaE^:0FhB6jn5ef`Kb;26m?<M85E=1
8]4A2=VmIKk5jQI9U^C0X4HmGQB@@9_d6UeZh[ii2=BO;i;^Dj7TB_lAN6]eFOd1
8F`O3_J;3TYQE0p0D<OGP5qkcQhTi8qnmdTcSp@3:B]iVV;GNKf[LI[XK`;d;Sbc
8FN`mOd7_?7;X3Ba>N9g[Kf1fYMCimUGG9\A<PX:_[=7aZp\8>engAqL;R?2UjRH
adlNX=j]9IhBWZV9>P4p30R3>AG@?3J<1d^k<80ObDlL8:QcO3n^plC1\MYNqlm;
GCBZjB9Wl\K>2hWbb]neN38b2D69iVcXhVdi78[I_Xomc7SGEXeaFnBp=[U0FIBH
e=LV]5CdpVf]AYEApOPDCQC@d^bNacQCLP47>O<7OZJ1epba:45J8dMT]F:hfmDn
jkEkjKEQii9P_`[38FA15C7IV2oPMcp^2ng\7nc=eZKXYD@@RAp2BQ<LB\LkA0mT
XJmE\H_1UCPLnF4RTj9oAWqMi`WWfCf?j8Cfg`@8_[8o[V9RNd=EjZ[dkR@Cgj:T
bN4JWl@aTTpAaYUZDadqmJaQK2gEK=O:]Me82m>pk5JdGUj^;Y;8VTO`ATH81i>j
ADlo4lFYejHD:nD;77p2<S?11JWbiQ1]=k_S7T92da`gin@G1[^<H;na1l^aR7jI
bGhUEYP_imT?:LlhH8aGdKQG1VQq]>[Xc5fncEE<^lUeT[]SHI1jkGi`hD>kRnA3
WK]Bg`qSk1>>1M3JbgS60aG0`FABGZkXHB3dJZZOD0;FT`8mPJKVB@?MJaq>63o0
B@Xqf1O<X4mPq5GLI_12]m71Y_G<pJ@Bhd]flgY0O`ZSB_?R:dWA94k>[\`6N>nf
Rl>b3cM^PW6qd[kWKag;pWLc7a1gJQ<WRMG^7W?fLaIq5OSd?nJp4\WUcE?c7beE
4<9VFTl`2<^K=aKDWJ9M5S<>>Y<S1J>A12p24NUYhG4=LcTJm4kqAfdAWXd:UhZ^
dO@5QoqS[n:UgMp^XGBCX9;DREl4HR[FH;GW9?TR[Xa84lBU\\U0de5ejDq]QG7;
M4NNc]G]Q`LbTef@<D7q@gUog]LpZ`EekJ15_jYL1dYAq]KQNjeQ4LDBNWk130Y9
LV9;8>0Uo>1aOI;<T\IeIJ7e_;i6p3eFAkkDqon3NR]`XRnHX`]N8KF;f3C\OQ1T
nQmk?=7p]XaS@Hj^YH?VdUM6I2hq_^;LJfG2M@?H>T61fQ3Boc3RQ2d8WKEYpb51
1:m\pL]`1IBal^l=kZSh>nC_4dAlLd4ET;Ln<gY@7JVgGCcj;n71iWFa6J3ZXnLS
e=@ACj`mPpenla9L6QSk_eI?@9?l\pNSmCHaealYcan6FK`25A80mj2=pA6dEc`i
qfEo6nDfqB3C8n45\5T]mX1^YDSG1dc4>T\aDFSffAgoBd<Z5>a8;KEJAb5Vj_O@
aoiBfQMF?cR<[BW0ZJAA6_TP\?`ib\aIldOA]Sef6heQ7a_BS3;[pW<M5VkMqZ77
H?7q>_Q@C>>X\`Cq1NW<^iDQDJgW?i?QTb1^9L;B?\JAOZF=XQPU<_c:]V[faeoW
`j\^_F6Xe@N3ZRVC]?`@C4W;ON`Q5gI_ZbU9RMd8X\d[41[^dFbIPAbJ]STeInoq
dAQ@Al;NH5N[D\5<JmQYV^]mbnO398G@@oUVo3lQ2k`VSWKjHTo6ZAeVB9^>qQOk
KSemqdbC;jemqJ]In=fPk\>L6[QAW:T3b[9gT0BpAY0Y;Pnp45ecmEop42@2`KFK
BJBEK2[IN^:c25ofS@I2fBa:qGn82[4_KmE_Qdme=XfcbB8R=;nQimYhnXlc2eL[
V[;7\kT>>Efh784gGp1aZNC8nk>Y4B2I8JqJUPV3SSORLI<_D>om5L2;fP5cXHgI
:UW?Q@_8A:jCSGA`anC8\dO;7?]?Z]p<\RZSkiq^3NhMV[=i]nIJn:EUAcm:3?e]
m?UeaTP=7qlCIl9PL>cIYVeOUA73hp>F8l^dX7MNH^Xkd0cfHeSV3l32FT>TYOpk
Fl:P:9q_@n0J[BnVbC:BE>_WZmpmn`OB<E[Y91PYVf@DGId10SX6mphnP4<=lqXI
V=3L1pi]^YdCUfE81M`1E`ZiI<D<[aMW@k0\im8Oq;`_Kk86F4h0n<nT`hC\6OWg
i<HoB=g7jldLUd0?GeG<o^m\2=n?cQ`TbPFS6O`Mb]J2A:1NP<7N>aNIRPf^CDTd
5GC9jk:7gTMM5j1lhlhVpCaa^Kc0qPgTA0W6A<Pnc1>h:qK0>W8U`pO2\<ZJcehY
`IJaLTC4ELoY7`>1j<NJ5n]npnAgf8>AKTZ3l]KVU6F1dWQadh`K<?HQ[aN9d@`n
CE0mTLJ[AY\=0XnqaW5WXQOq;Y>WQCA8Zd]V=bYK<j5faf]0=P0_maGgAX`36IoV
K@7p:Ife7FldoHooEGkUMVcSGH\S8[TW=0aIjhKhp2S6hm3hD\1;70O7Y\4iem^`
jbK>a=W2VJA5h8552p]KcbJgA5;bP[Gf:`OLP]UIoMZT61JA_2ZWTnV47jTjN@9T
;XR1[F1SJbAhS33bOB]E4KnEgP26kO11Q]P[Dg=i>nUHM_P;Gfm@kKS=N3G4OLa]
IcAoqgV\0=\FqNC3\n;BG@`2j;^HTY<p:3^`WRingkNT?NfNDAUmo;9Q8@j3Q`gc
JH[2AZDqCE[o5?hpGNhI6C3hkeVLZMj8biLJ?nJ26GcniV@Y\2pEV;aNV4_mO]Zc
dGXF?U?`BM9SS27GgoK2MYP2=4CXBDPf4@V1VZ4RW]Sf7E84@KD^A7`2]A7_W[j=
77EE0I<kVhLhR5>1gI:H4Ui1GH0?^pS[e;<m67JEc7T;oeS_U<Um_kH;`20lbCmh
Pb48L3oX^E9Dp3aNNg_DmlGK[Oa^MMlGF`5ci0mETXgeBpF_CKC_h^i419SdU1?;
ajjJM[eMMD70OTFOMEI<3SlON]Yoe[S6I4gJg[CkA]EUi\J6=NRZGgVV;h0Tb7W=
nlEj1N77]fZH1^I]S7QMN;O6WUFci^3Bcl6O\8HB]<c@=YYb7pCDX[bm;$
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
^E9k4SQd5DT^<`HYX0HmXZb`H[E^;A[bK?14KjTgdLkJh2i96=dgEkPqaW]6NFQ@
9a<gi>3`q3]jeAFDfU]?aM^99pT@D@60p4?;hfe1;X4?Soi<C0ATJMbFm=oe2VV@
E;OfBf>PL5QV<q_oc@3S\p_^;LJfG2M@?H>Tfmf972KWXJIY]:O\__CZcgq:]1:>
UipfhJ0PX_12OkTFh8cZ6VCB`?iUmTKPWqjQFoV>nB4I;LWCGG?05Faa22`iYc_W
P:6^_B[\[i>KF<W7_]Z9O:QgRf_3VKZmhOiQmaMMCW1ee6VO1]qG0[`iJUTL]]_E
UFi7[4BF9YIU;D3h]Um@fd;;03RaBkaM7q:1=Ue7mH2fWSXMV;fifFMeWD[376Qk
AeX91<RJi:ie1KqBOkZ97Be4Ff>dEXZHE=[;ZUQ3C_nVR<qalO8kL;q?=Hl:\@q8
^;bO_IFPFZdaiAT:o`\f]\OW2nDFoAbqHl^\kVTanoll8HOc:n5;eeIWfFF;i<Gb
jE2hbRSE?DWGidl0mdPPPXq_@Nme2=He\VND1hl\LMl]GT`XEca9FKZ9\hdfX0nR
78oj3[<7Qh<AX;m2j8=7^1q059jje]BBd2?VfEZ6fFi2U6Q;Ro@c5[p_khYBU@qV
2_6Xc27E;fV6SWL5Kil]A\bCo<<JTIZRD;WIcp;2Ae3d^qQT\KfTkg:U=eihVN>F
5IT6c@<Eg0n:p6]02J2W[612b=_aY?AXi9AP@m80f`D2Z\bWHO3KdX_6lWdBBDTi
F7SUBR:K2KMnVXk4fbZ`m1nX:Q=8UpkVR`GW[n@d82?9XMi;4?GEL][]K@pH^8io
Gm2o3^Z[@fnm]=fchi0T_Y=g`THNL[>R1>TVa[[g0qZf^T6imXDYfJJO<6Vbek^\
0^YUj;YhRA6`qBfILSbJFXGY13Vc[HQXnPN]k?EjYi9>7qgI?5^`5ql1oTi3\<5G
qTE__LHT_oCFaec?GcV@eHh2MQGBY9V\F;ObED?Vonk1]p>h0\bJl@iE7RhUjX03
X59@=;EWcocWRpmhPVH^<pDJF>l`OqOo:hPY@pfX^9la5W:7<?loX7S@CTo^M48b
I2W?^qSm@99JbGXHbAeFaGFC0b78QkSm8P38BCM=pl7>jdce9bMagO;BegeV7\o;
fGaq>Pa]H8IqdRm38:?a_aFK2H?01ZH_8IA[QX0TnJb;I3Up`R^l?5M>bWIkH[W_
h3BQ`\0V0CQVH1j2C42N7]MhZ0C=PbBiIa\TDMgpf]gf>BeQ09`fZnRc<EP8?d3L
6QIfeoCUl9>5cG?G59m3n?Ej^;i8ZMffM8=mmWfEU:[V9DSq?59^Eh>bRT<?R_Q2
4BB3B6n;Odl_QeaP82V]cYmKLR@lT_7WAITjGn<d?KffMI6`a\Nn2JRHK5D=O^D@
@4:p3i\2_ncqc:Jd=>AUeV4o7<U?j@18ooYj6<`44hJUJJQ7JWG69OcF?9]<2ZX6
UT@9U2ZN]@0lZI[p=_]nLBGUEA2MCT@?e?m@1:<X?IqiW6iDiTn0nL>;WF3WKSHc
:G0NCA`hZkI0_G[nY?UBRq>84bTI=HclHH]^=78_8jXPneXie6E@^kebC41lQ@FJ
pWQODZ<qG>?1dH6CSE3NJT5V;\Ih9H^Eh7SaY^KO02pR:U5blQKjX8NIZQY8UD>>
?ngNBKqmQBeU5cXaFN[6AloOCeRF<e@\Y>FXdO\oLc?eb:FU>2\pk>@Y20Pq9X1Z
0iJpcRQXIhaD[maA6NhQ5ga?g:4<:jgq>7HcgYRX9GEY_d`aQMFLj4MOWj133mIe
Gj><K?nCA9E<H\0=LQXMZ@a<6HNaC]m@AChhOED57kl@Zoi0d\m3VQ`6Ohc<TlIe
\GV`>S0g55^bpLWoNhmpSXnYg\Ipk63O1n\GH^WWjZ3:p:QST=0BALJN4hRZB5PO
__ClYB?q@=]mYK>JSU6nZ`qJl]QacEIJ>H]MdT9\:WYeXXbJGG[@XTp:6LDUb?W?
LNe]mXUWG5Ralh;CXAq6X=4Ge1LPW`ZN\2CjIm]i_:>OBaVTnm`JM9RcG0_WCT<j
HV:mQ9pGo_RR6Nll<4TLT2dJ;ILJCAX:76ddNGfp]?QaXmiq8kPhB7ZqeH\nXjm;
h@G\D3Y[k;S8891PH]oBSf>Foaljk3TWe7aApS1:8?J6q7LC<AP]7T>f=6RZEk2I
^<\:4:a?7ha<o7G=kqB5Q@X2>q@A;gB_>lRYO6ak\49gG`che4YJ8fa:?deY=N`>
DBYE4`o220EDkMD<BYF9pH?3CIE4Ggb9<BRb_l[\A>VO>L^IdM];LpaO[d[VO[9i
lQ2^m?:i8OJY74W_T^FK\bl2kHc_9o88;i2@g0_jKMSF4lJ5Hcj5WHS\QRi`9H[Y
b5IYlSq;NXjM:SpZXV5K9mQE\1f6XZWjhD=ZRU`9feJI;4LpLmQ?0o8N_7KaDlf?
CGdX2BQfpNc4f0]?qX6bQ=IHVMR?aCQY^=ajO;`4460PU6H@_:gM4L>\q;j]7=GO
eFFFRnTEFPeCk_`WHLIii7R_<LQ<ZPX;Tf@737?0amlfDpj`9EV8_p=J7=:?pVSL
Z9>b4;MU8co=NQBVSNJnb[LkYK\id82JEDo3>L;?oPZTjFbZJk]US8E=kiFj7=Kb
b?=BlENXXW@2hpVQM3K[hq6lXeT_7obEFa7[P2ZO=[dnJJ91qg?L`k71PWUDWZWP
K\;BPbhP8<B[MT3V9El87HIW]1mpGbmB1Wmi]HFRDceLd8>ZIah;;]?UGT4OaWA5
X`@lAXC79UO;p05B0A:@BpJj[e3E;n[CCeCGiMRaS<VjSM8:0=2=jC@Cpm`:2;1c
8q9SQeBgB_Dj3180<?@^9hYd7oRkp0kEjhFGk1m5^j9`eNlEAVhSYo_3;fNj4W?=
150=YJ4cak`]4]TPJSTXG:In6Jo]54h7e357pj_72XX=q>I^ONXl[YfB79fm@ilQ
0P20]94;kml:?h]FZaoa]=2`Fg7H6=]`LGRP98jSnGP?hSeIqH7l9VBGqge94`YN
U?;WRW7<7p`YaJ9S=$
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
>>hK\SQ:5DT^<h=`7mb\Tnqj[^6Kb<0e\5J@OZ`cK1^dQ3i7e7X<C35jZDp9n6c3
5U9B8Gk6GA\5I25PLd5Tff19_:ip^eD6i=p7cm6N73`B3_<Xc@je8JplB=X>=SMk
PdkdYgYW3q3QMj^6nhY3bWejQhF;M?9e9fqiTmhAK78lP6mbZ17@kUNK7q9dFa_<
Yh;o;X30[C1b2HAJ3RqG];0lgfO<]d1RYD>o@T3Wa;G\n2<DH9XL`J6bX2UMkL<a
V`dVB=FWAM<BEk6Wa:pYPje`j_qnjh8815N`C5qd8ZAC6YqKlIfgKcqB^O4Z6TqE
ERITJYqWABUY6iWlDNce\IGi\>qhgRbM3UNN?@b8hbMRP3<YNkKT=9Q;ZNAfhqdd
4^?164<T>X<ifj_F4XqE6LFL[`n4Lc92LY5BIMSSO=3mLkNWlZ9Dg\8TWHOEPA`R
oYoEiBhA5p<fhW:ik8[kpLnQ731WMCMWGB\2AC6QH7770KLU0<RD1bXJOd;l:YBV
4@mJo3YNZ@YV8mG;I3>H[h7Tla_h`c2c53Ta_KCa<8Z7>ONXH^VpDCPG291q@OIP
bXcqLl;l05llakZm^Wc3N5OVVBO\f=g=bHR]U^AQ\3X5gd?@Z=k2;bDiHQcEU1=D
AnpH3[joe2dAL?50YmL0COGq:WFHG>ZUY6jcoHXl2_`V5FG0Ie]ITS:3bEq^QEmQ
XO^?nBaf5\UNF9[nbdVY38_=N2dnlO?faqAUMXB6hq5HL_PljG:dg>lGXAEGMP4i
B7LbpX18?Bi`0WB_A[ZMiXKmRTBjLo\5ZTT_IQdEbOb;6B@BNY8:UfJG]E5OY6Hf
1J:9USoCER_2WQ5>aklG`HXddp<cRSOL[p=NBLO9fMoN>Ed3\l1=6lGfn2c5DRFe
gjeH[>i<1q:P1VE0H<nU45cA6H^c;>KM1IRVfXH:3p1Nnb1No42IiC>Ok@IM7TOM
DV1n?R[=\qFa6HEXVqmFS9]LHqT97Jb0nP=LqH48;_U=:FF7992TRiQ]E\>f`6;B
jhKQJDXQ?44fBF]cCXQjf[?Zjb;:OmWY3U_mB[G[ECncBj^T`[2F>nH];VSfookc
kC?p0?]4cgHqOkgG47Aq[b`>10>E26IfR5=`a\oAbZNCi?n3OROPI^94:I@3Bl11
Zd=Tn:hopZaQVoARpVa\YaBXmiE52b;kU_6`kdPmpA<R9C?`^<HVVKDd1P^n`N7k
oNVEY7cSjG8WW3;l=RPV7gF]MJPVTDkai:kLSf@LGZIjA:9o;cHUjK2nJiATHilA
P8<f32i1k[fi6<1nV9c<4XCpFo@gAf@ql0o@FLUPEH`8JOE1VBhS5[K9=KK2F<AH
GPp>j;hQnUp_@L3c5=UK:jYMO;mK5<S5DLQ?HJ37Z[7U;NCX@VHVi@ZC`AWU6=ho
eXIL=nnlg8dDlAZfCQRK>0JFnqQaZCNn`4[TglF9KWbfFE^nLT9`D\DhaLM6N0@X
4SIJ?EkRWcLJCD@lpe_G]Tm4p0^N4MG]jj8MdbAX4>UW[eERC2n2QR=J:<7M?Ulp
ac<oRnJpb<GEc0DE1;5QChZN7C5Uh@RKYVFE:=4@jaB@94\Ym6RpDVCBUXLq`P`m
aLZq?]1SUJg^ga;bL=@05bK;UAHb;5]h]<G@]RGOE;R3Xa^=CIO:`nc39\PiP862
HTC2<^V;[dQHDbZAdf@`9[fQn5qKa:?kZQA5@ec74Ed::?fhF]lTG=f6fJNdLWL_
0fW@;hVpZI0ElAXq?JeeB`D3mN2Tf_=@;_`cD:FD3oNkPoNJa1KqKHD89EHpOS^=
[aaqFR0M08Ig]4EeHIb2T1F[4Hq\j6:Od;OWAe<<FWn^m0>^P1e1g>Qpk[aLW:9p
E^5W=EG?]neI8@D4U2EdAi]3::5l9gH?oa<qclORBh8e\K]36aI4U4IgT8@EKeI[
D1o=Z`ReTUQQXBdbboaa@NBK3g==:Xq=7ZGBNL>=BY4Q^5Nb1qYS=8hYG;96F8Kk
n7:1g:EAT[@:O[R95n5@=??3=iePU>U?X=LMY=I\MnZo4`UZ3XWPaA<0h`DQbq7a
[^JLKH9MP?ZbECVN6XefhH5o?6J\W5pcN5R4]9q3LT4[D\id9Z2<`bWqX_9Zl1>`
Od51ibKo5DR5aEU57FZCP^RC1m1nNK>Mo@`L@8=q\]0Qnh5pWIkg==EFEkT11iJn
3^AL5dHdEJ]bRWgOiN8qlWelGgb;Wol]4UU1DfMEgIO_>nICpMNHH?4=Xc7@AfD_
G5ZTY@E8`OkMU4FI[D0g`=kf1[5flgP`2=hfEDA\JBf8;c]0>Me<d8E1Z?JG9@Yk
8W]dd@j6b612g`0pXZ?RNGl=iH6I:H1?:0UcHA>XeIO74^fRXLc4MK@[9`4jH`1l
dF[i@m=\j`ob;2gcF^dBLoM]HLODjFhBfNp0gOW[ka;5W^:j3?Q14HZ<m^8;e`HU
RpL_f@TC<l7<El=o>\EoDZ3\`=lP0aEb1>4L@4HZ0=m^Sb]g9ET8`6MSG=eed:JR
YfARqB_M7:<7OO1]G1gnNCnOb9JA_\DgRd7q:`:=aA=2O0M6S_^Ni8cbVHSNW9SA
6?pKgPZ?m5p:;5RKiTfED_eFRDae^pifn7c^4qR[6XkUn=iD7e0R0S2LnMbEZ<FW
K92m52R4YpDQ>c@nFYE43MfHmH`E?cjB6nHB^c\lOEIH89nn9EM^C:HYTP8]miaR
XoN1:=TjE=f^>TM^l6_f<pMN\112Q>R2CPCZEcVHELeff^cF3WE1Y<g70;dh:9nY
CiRGl;57Ho]3f<YWq=O:fS8bWJjKSDTXGi\Oce3]cEj68F0H5M]_qiMbe=m:ib;>
_H@Md]lJ_^;aGCB4=7i9;<=Y<bKFmWX:_DU`6>FTK1We=4^d==c:Ae606l=RGTD1
Ba1ZGnAOM7jDp?g;3abUL0DZES?:S=@cRKnBo=VmlL8Qp<CHF4h`p@li4Bgd?coo
>8VJIMb?T1i^Z]>N73JGgleNpa953lO1pF]e<=^AK^IGI0O>iCOLo_QYJSW_[VaB
4eEXpd5Ffl0<Z?ommgA1j02_U\g?M[OFl9_O6C[KhGRemD:l0O4\3g`1khBqeonF
X<W=``7m:_FFSa;J3Tkd0dMbhG7X59NVE_m6mlH[XP<Sgep@lOb98@b\PLk6cZoB
eMYLSG3]1\knS]gEkOFl<n:JNXa\ed;B:l[M]ZX<BIWO`m5ncUFAGc9ZIfbIElpm
;dF>NM:AFcD89KN@^5hj_:O:fbGho849:AJkLQWB=kOb5XOkY0?jIjgXDZJnGUh1
K=nA90_j>3ibYQkLNYp3U>A`?2Yl[;TJ?@Jq]M8PlT[560ioOPKJlP[OCgLlT_3\
R_GpHhAf2WCXF[B`iZT9I7P?KU`PYHH10C_pHfJVRoRV1[1\IooIeenYcnSBWhbG
1DGOp8_QA?_@pXE:`34Q5fg4Kg>I1a_[PPMTgUfokb8TBeh:p`^;liPXp2b:ZlCo
M8L7kHHemJ<O34:[Qh;9IaWQ5>YHpIaVLd2X@oRk[[Pg46BaQWRbR\9^@Rmdn7SH
Sk_alRJao[Wd7B_2QQXpg9BP1c`FN5K=<A?@BI;;Af=mb4DkofTDP?dnGSZh@@V:
AcdA_K6P`_n]d><bCfC3W=MWCA]^dI@lSR2pjgKSjcdC<[CMbKhDB_6k<=2?YMM5
B5QBAY8A6fE443Bn^IBW>L`>`b;eSXRld`6FXRcc?]XOcEBU2W<ghhPq3]TndC[`
3HES[@nfDhC1:`OV3Of;38O1XY:L[1[3FDWHmEp;D=jdjbjMIlCfBS9p\@7I9RRA
<Oj0TCe_bQjQ7g0CS8V>Z;5pQKB^OdO62UDQmPcRg>6A07Ak6cfDUbUqSiedcOCq
F]>GgiEc;T@F>T\1U^Y>A]UIhlI\;g5UpES>dIg0qI`22HoLC7f20BA29\cel8J1
PT?Ng\KVKZULqX>]0lV3g>ScN1ZQC?4qSVW?ffG5eMWX5@BEHWcp:k:;<LmIl8?5
E^mcE:;gYeZe6BVE65D5]YN;MWnmjm2Da^RV_iQZOFK8W55P4d?9M;QWqgUoW?4>
SdVTH8_VAB`ePdmm:noC`2Ck8HdcbP\Uf71;dS0PQXB;@hmP@MgM?b8FD<g[Lh`P
Q^]_DKeUm\BG<dG_TPJ>K`?1E\dfpA5:h;;T`73;2@0lJj3=ndaM?Pf9<g:`k=:B
jVRWenNE=?`Qj^9jY;Z5B:8Q9aY@hC=<IEF=?J[jagl;;h=qaP]<@jHXFd`mS3`m
RJGA3S@j3A0DPJpegc:gHRqWEOgSGDQWINH8\Nk:mR5Eo8fIFH5^NI[4OblE_92`
D5V?ak@7l;9=DORi;KGADfFqF3N3JAdIS4O:[Tcb425[ITOITOmi@jBWqMf1]J6;
pGhN\dS8QeA:MhH`K0fUYW=7`]1B=j?kdSS]pDANkddPId4SkU<S;NInLHL^:8ND
;a?h>iBN=]=c81VEcV\dcEW1AgYp3PT>Q0]?`NVKAaDbdmM?aEM<mBoZZ2QS2=T]
8A<H;Xj1Ubd]f`gF6@K>BDSekFh8g<mNEj_OS1MnYk7qRO9bWa0a`564_b6G4bg^
@T`eS5d<Q8>5TbQk5hiOg=GSl=X6\h9JC1RIGDbSLV0``hRfn0TYc<ali_1oP>pi
a[@V>MCX19hL35p@6=<]GGOAj4VgNO`8lh5mCAbfmPEkRqkn_?RXDp=ER<Q?1e8Q
8TL]eETV@;UW70Id:1aUR?4c`gFUb^KZioeicp0^H_`XLdOVkNGVVFFnAVCA_ECD
bIq[ek9]ViYXc^obV83BL_X?^1;^RWe6Dp\iYZA==qOH8m6PRUBFbhcgZIq21_JT
[BpS_P3dn@9QHVglCBMkW4Ob7jEJ?Wpm<\Y<JX[lnkjAFhg;8<9cm:k]E5XLXA0P
Y_ZbEFq<AJnZh_q2=mc1jI7TMnTa[lEW?>kPmhj4PaG`7g1=EQp7UN[61iZ:cAGb
2W>?WaNA:gPhnhN3MUI<dA;GM;MfZjNYUE4;^DiG?`njgpcb?AmFRMPZijcU;obc
ABVo]L_eOPVWPJ0QYKaTbd36HgBSoE^<NHmKKRU]AL88kD\_VU]Hdcg08Ya<I7d0
q;fe1TPSpSBmM1=\h@gWo`=N2<;ne6n`a7_DI3aq9D4Dc?9cVcg1^dgg^7^1Hapc
a:Ug@EpOXGmfN9Pa^LL]=hK2D3q=>T]:::>Z5c5;IDGWK2D;DfGVm0e<MAj0UipL
6cFaB:>aX80>M?P4Q8El3oL=BUp0LEjdWlnhhe0cU\_G^e31Z4mMbCkn@4hf_Uek
XL7@0;C5S[1\ZlEY9V6ZEN^piod\aIof;I=CJ59EnY6l=l=RmB_^F\82]]SjPM34
<VW0E]gQaVmQ4Xfc<WaK?OGP[\oL^=5RmI7=cBpm?Y;g39?0]bXO?f;ZG_CUJ`\0
>29dKF3f[TK_AgjaWUMCgIcnQ4:b109PYm\LMRoKeoig?GSf22MAQf6F6>XJ76V4
OjmpP2<<3PGP\Eb4a_LBW6k^VlG5\0nBDXHXiA45>PD\9=CEDVP9b<J\pGQKcUdX
:U`ME`iU^]0=Y@B7ECjQCBJ[oe4g@nLT:fJS751aOAE>Rdo:d5MTpH[\_>\iq]o;
]6]p@4;lm4q02S`]Yiq5:bIldU:RLHh]ol4]=q]>^0k[VK=>2QSUegm3li157A;\
W[p4FjMgh>FldWHd@c`km@;M^6[qnfQ:Z0Tfigl7hlJ474oP277Tc^qVoV3C:Pp<
K5VEV8VH8?4mCBq370X;G6gTLOZYiZVGU1L3UMBdkIoYj_Mf0[OEa3LjAXOD6N8Y
8Y^Q7WpAmfGOR@pGB255B=L?SIEAe7_?YT_TSD2fV<n_VVj<AEM`BDBlUJ<pSfWI
7EC9OaZE9Q[RM39;S>MJjC5PqB0REbmUq^65GfhcCfe0b1@k:;aYNg1nm?kdikY7
o045=2BVnOUnP[M:e@1mV@BofO;m`kg:k7?am[>^]pEf=iZ^KpNReob20qMOghOB
>q8DMYnJIaHi8]mg^4T;@[dGZ:IP58Yn0qMNJ=iVe\6?E;R_Y]WLlK4E_YMk`qLE
gc?>8jgSI]4NO0]6_EeMkKGdZE]8CmI47DY7Tl^@V\bRZYm[I>0c@N=\SDpAYj]X
k@fOh=?]6O=;Y;RcCM]nFQ=D457qMPD\U2k;4L15XmSG=BD0VeFINWSPVaqK_[TL
EWc;TPjO6U=dSiekMa_hj1Ch2n:j43n3og96m`DE^?]Ff>mMW6oMWZgQBPE@ZI>O
ff4^>p[@;=>j7p5C=`<e>pAk[RdJ5n>0>7BHLl?hXmTN5qYD\a^EZpV1o=Z^>bjc
Qe`Q7oTkdR\RpB;:0MV`2]e6>0UQW0\<<pZCcm^QE37\G>f>eJY3ocmJWJeGUfVn
@E:RfH]XnnbAfG\Qq;I:;XHmq7TKjYUmfY6FIJeagB78hZPW92ZknaKdLV>@hk[Z
;8oNEabXGOmgYUSHQhNPc:;MbMcg_]m]6jb9n1<8DP00G@^M=<1<jM0WZ;Q7P[hb
a3h1Ppc<573L:8EnAU?kYRO<gp8Q\Q2?ZqMR]L[E_b3gTSgJ\3GlC0V\D0j3moG1
icpk<oHm;dea5a0Y]5P1?W]Qf:PN`=GQTaLW;5cT;kNpVY1:TiS?CT298ZMg@=Tk
47e;;o\]U5T:l8QmAE=HoVnGCgJSbAPH59HT<@YLiF1hP<`CJEDeqO=UnfJiq6bm
5a`Sp>m`;f[7`Q<i_2SPHgNo>:W_@jCk:ef3BONoPGhc:L:<QkVRS>G>DSkXWhZI
D7LnU9cPC__mb?EE_cCFi7hqWJ41]b37UA?D8Qok@lbpUh5a7mnqY^W3B3SEkmh@
QI6]CoSAcJF0]XG6BDpO?H[9O5diaOealc5[ckT;QH7I2iDomljk]9^U`a1Zc[T1
0NYAhpQIdblKMp\;FOn8bh[H01a`DSqRnJY5U`qXd;lLXB`GP_QM``?0bCGoJdAP
EC:qZ3Q\Io0E7VH^H:O3mM\9p020Da_VE=kJdojTGMW7p6FQjO[;?K?=hmd00L=c
\qm><CnWXFejRIefgl>g55D<G^fiYEc8bBXB`\R2_;kIQQ`=eUq=6E\6aAp7?EVj
A;KEE6oM?jGWFBFck[lU2^GZVK=^BYQgifFA9RPp5Q?o5Xi<TXJnKAcKYfNmq[XT
Ddj]IFEgeA1Kb<Ylq_V1]N2YA[W=[L7KnRI]gq>j84j:5n3KGfdo2N:h4hjeb;lS
\acjOMgKhNUWTgXNh7kFnGqFRePe4>pNZUiU@K2M7`KFgGlkoKWpmB^09FWBDQ0Z
3=?:3Q@p70OndjFW=1>QmL228:LmaCA^:SCDe]L3nFkUCWdfBa41a_ni4OF2UfHM
aY8Oi?Kq8Mc0?^4]]GN`XFS`IA0Bp[hO0FC2?]5D];V`MMZ=gRR;87NK@XOI:;m\
hf3dnB:Hk_LicqZ_UbTiWp>BZgm]d^Yb=Om]LBmITRq1Dg<8TG3nP9D_L0H_h3qe
9KHeh7X8fnR:PL2bQIoq^m9H:0d`?GEBGLPLFN<Gfm1jgU<WWZ0LAPbC^A??0j[_
I5jUqB_?Ki2Gp2mondMR81?E7cB`V5Cb?5MipOn>8bGh[Z8PckD=YQ^XPp@h6Cfh
_66FD]ggB3S`5?AemI`8;4qUSoOG4=Z?=lH?KUH5bh7`hU6UZ8d\kqgZTY=CVj<@
9XY<8EAW:^]3^B6om_LjR`DZZAI_R3\`h^bdgYFhL:@4P_Vj`?n1WcfWpkQD@@[e
q]He<Z?I?MPQN7jeXf=YRgTeW`oYeQCJ]=Tcg`6d2CChcaPBH;ncTImQ2XATcPDB
G0opL3S\a\l$
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
ZfW3MSQH5DT^<cNXaHPJ_QNlaV;0I48a7\IP0fi;X\i???nKpVV9XcBhmPI\3]m7
;6>jhT=qCVIg;<M447R_6oI>6d;;NT=`K39ohKJTCjkS@9GI@DheO2mU_ZZi7jA3
37>4aVZDB^jCNdp=>mHXjqo\3;=7S2K6oa?If1XYZgpPMU2fZb]j]TQh4iIg:HTn
g`lp[GJiR2\LYBi0L1FW9bUCpn:m57AVi>hQhgBq^6Le]kf4UUm_K]\J:6kd4D\_
bWjZlhPW>7poXTdQHknTeoA=@aaY?PMnVd=P8eGPOGR7@0_0eXh7bND40m7MQgRA
P8=qWA;1;`@qiQQVR3MmdD05RHGXcI9hg<2Z67Uf8`hR]5eo1^bCm:Ff:SGJH?Pk
Im8YPmfF@9K>41QkkDEMookoq=]J`ZGABoKD48DgN6=4FZohF]Hh5o[cTRhB0S<A
TN55>f1RFpgMXX4LT6f=lheVYD;^8^7_Zp0Y3]1mnq[GNa;Ef8@\6a>`E^h2g<gR
_X<@jb2?Iqk]AUJ`ed:S^9UM>IU\Gf\>H18kWFf^Do2EiKLeB;]9\qIF4NH<l7k;
BMNBRh\USNFLm34DDnfMk1\2cHp4WM<:nqX^nmS^7D0=R5[mQX[JJiD:4]8SXnKa
O8W1Bc]`B_oNU3:[<dULn1HV3FlYnm1DnVJ]2>TeoSmc3ZI]9\nLB8`<[pJ4GPK3
9^47PgoPj3o_ibn>5i@E?[e6ZE:M:1<0k>6iKfVOlU;jaXbjKJ9FGCmAPL`aR88C
O:Ql]53Wfe?T3q54bIPU=i6Xn]Tn2GAgoWj5ZQF\kM;k1ok:Q[@oJf1kjSS9Q[f[
D]VC:?9\UGj\JhZW=Q:FXjQLZo:@Ab\;iqh5nPN`XOVmBU5m1H[?BQP\Z7POGC4K
BkFFPJI]Q18RDb]G;7YPaIHR;W[ODFm>okqY14W[c_JP0D?Lnc@`4KHh6U>c^]BR
?L]]B[E4;cQ\CXoDI>EXKgFKhnJM;RjL[[\Y:@YiT:MkUO>fmP3?lp5CejKV:qO8
1ZJLQm@?`TdA=Y:n54bhicnb15VDFW2[5G<H_<3H9_N[a6ImLLIcgc7nnmHIkInk
6AB=j3OkRqWT7Ul]@JWC=_NFll[<^5^>>qR4<1@JiqGj0dgdp<8kgA?Dig<Wm>>n
J:n`^ocXUhhZ`kcSOYKlKO30\d=?;;nE]OKfMYB2@k=BFZ4]U<Tkg26L0M2jmbAZ
aoQ<m=T=`p7X2M6Rk=3h;17fMBE4[`>a`o6o<0[HnCR]2RT`fe<<;]eb:1Am1`RL
[1fd7opY@MiidJJKNe6:UUVdHU0i9`22SJ9FNG4X44J_N6G3nJP?`A>bX8iW;E\:
C]^n?^8Y4MKeG\D:f5GG_9j07fcq]hlOdZH99PoAVJ]]FF`?0JjSZd86f4eGmiRQ
o6[5j5aNTDX:Gd_J[kOY_fiW_d?>]^ljKkE6DmRm6n`LZdTCqWm_SHSP6n]0h_I9
l;QZ`hcco2?NQ`fgeiQXQ\CN2UUha[?^glh=TGaPgZdo?:V5QB7@e<Z_3l@_9@Mi
ciVPpS5ld:RVq;?NA226_I1SKm@MaFB5cd4bAJc=leES1kdUJ:^f=iam8UTe^49i
2a7G6O;QG1o^YS@oZj>a[=`4pL6ZClh=1Gb=MiPe>FaaK:?;qJka_C9kpP2E15Il
7V0QA:IG;R3_eT9kIUG?_[C9RfXOe42mqbo1:Th]hi@0T>kYdO6JSb^D\:1XN<]X
AD\EDYbWnpU?i@gS:qj5cI\:mn48T3I=;m;<\R3iTI>mYYi[=ALklF^UE1I^EbZ7
TKBkVBA<0Mm`kTh2WMj8bZJ70QimQBk?1F?16348S>`n=U6ELd9K\NJ<1_k>^`Ra
=1n`pMNbBjKcpkD0OmEXqPfk]bjbNZcj1GELK6mSRM;Cnc[AFd]Jf5>>XE4Z\CV2
6hc1`<Bnn=;\@fFmg^IcL9Cp5a58ZAGq?T9AA[`hC4lGB\XhF5dADhm[O0STIK^\
Xj5;<W>ZpZXC@cDKN^09iO[OI@>ImnH;bNQ5eDoS@YioK]gBYEBlkHEnTY5W?D?j
6m[<GeiXZ7[Y>=@EG_g<`W95XqD9eL]Z]pPnU<^gq=8mS0]7U;4CfTk6SIBU]p:i
FW96ZK=hEQIkA90:DC==8cSd:GHaS\e=P4l?Y?Vd6p1KoT?:e`VfL^j0k\\iEa_W
q7g7K\E1kPmgO=iY]AOU2n^ang<A\Tf[2Himb^fmiTQ]pcVD:N33Cj>>RJX0nh1J
<fbGh=cFXAbXmIX_OoVZ?HJDq6lTEE]I1nm09HUkdPno0\e[VDRJScmSH2oWFZND
9AU2pKU0O9:1q?ac[U<R;1]IdOA0C4g@aT99QYOkY5;E2]YD5_kUF\iICEoHK=F`
\5@4lhNb?pN@<`3^^f4Z[ImB?JGCL<CRd=p3:V@bXVqAG6<D=peFOPLCaSZ825b0
FRSl>Rp4FkgCm1Yk][lRT^]Ji4b_UN`AkkEGSdeDffSi2]SKFfq\1nbo7XPoP9V^
@^G_Jl8I_XoP15VX::=mNmmg3m<^D[qdF;ogimX3fU`28V113eR3_i`SFGMj0FID
68VVlZRelWpQPDk`_T6kea3gnkGicJ9bELhO:[IL7:X]J\3V[@JNUZq6HmN^o49^
SXfR[EY^ZRWaQ?C1no>G^;SOe86OhM>]KgqbVZ66VHpLTlSLPgS2<IMiCEbAFd0J
oPlD4[=Y@nUG0<fImF_efVRBGEX9dTZDJ7i[\[O[_Zoh97p@;Pch3UZ7TT:KmP@1
[k?gBG<ZD`=@=bgqHMC[hNlpOV50ZNHI8i12U\Mm1aq4ZFf?2<n88gZ^41n^IcSm
lO6pNl[[D\aUR?gc`lKVae57a0VZQ=fBOibaCeZ`BVHgoh5WEG=nRMF0e8ciNaWW
g[^mG3@dT6Tq7_i8A^k[^XmP:icDBdOQpEaW;G2g7`M>63OgkAL20m=Eo^?9MK]?
F0lqXK76<oSO18Vol^\iFfXVIf>B]B0lIb5U0=Xk0@>H1=@NBG94aPkB\o[:qPHC
9nH6p?@[@P9QadE>lNKH4X?9;P>6I^2n8X<:Ned\MfaCVLQoDo8gLBk6aOPh;S@l
8m\o_cM:a]Wb^1U9npcCkYI_NF8DFNJOJ2``60kC>QG[eGhFI=U@MUTS8da=bqE5
jWXln8RNC6Oo7Wl^CmZ5<4q8maj;4EpmN@RGLI?hK2kIehnHVKBp53gA0io?fKUH
3mf^:oj;FQkDecZ74F?@j_HCQ4`0pfDX@RaB@BXj]]n^0@1@>117<MS0Ff39naDk
8KLagPo]hgif^H?<6affCW?0da\oR\aFmUo4[pbIaFC=YPpY[F5nhm=a7=I7eHk2
hcGpNM?^TBRUd>e\JHe2G_7?R3>4hAjSJOmJ8BA[6[1UBnOX\7WXnAB`?D`iTWSG
l4LWD7pNh<2NRoK`d8^@PaD3cTZ\^YifWaqdNBQ1PBBp]\XX\aBMXQhi1J5n0N<h
XJn0@P?pdXaKHP@aHdgVmbo?C51cD>C\laQl0L0b`hJOJFDSPT8\?7cPMhV82TgE
P9NUbc:Y?DpSmHYkB63pP^@=T3V^;N2Qa6e0VX8<?LTP<jMa8N[\8HU9A>qVdi]a
YE`q7cgF`cbKpc^f0>VU=lCfiGg3>pHESAUh?=qM]j36P\>Me3i18PW3d6fPU1JN
NQDBj4p2O]PRkB[]CnILc4VfiMS0hQm?`0U^G74Aa?dQiEA>d6p9::EMIR@G_`M=
9UcBA2PJ]dflnfCPWRkMG6`qT7bh\1qL=VbcB6^\GdYLWTe66XQX\\dcicQf<KMo
KFTmI096[4`l]HNhc;36_XgkEHcB[1DVFTHd7bMHTG\Xcm\\c;O[<55FIp9UXTJl
UVRd4oi_jeVDBKf[1_e;jN4k;hDo\eePIEcTbR2kl8kJl=T6heO`a5E345=Mn?eZ
ZQeDZAS?R\DI@SP4pZ]a^kITmDlOcG9POR:2DkQOYi0S?XSJWWWDO=Jo5n^qF;B]
T?]?bOmXSi1iG>`Kn8JG1l7NNX]Z@GGi]R4FB5]i?4`Wd`ol]LK;jnDS?dm;?\nT
^2haH3:f9iInc1`58:qCEDfSg2H>E`Po`?IK]Pi_FgVF0dC3\X\RkLQ2YFmKYN@C
SPbAoW5K2?\`@Gki\VLCM@fd0NH:X4X3Vc`5=\Apnj?0P;8paAdGE>?Q?N]14AHR
BmiYBG4XY0W16bMU2FQIJ_odEV3RNLZLF:BS4H\cmM6YKBYCfVD1AedPeQLapa5n
7^TE^h]4^Ghhk26\[VKVE3b8_6HSTg3^4jHFm_>^^[N;q2B1<5eBaV;:OdlYdgh2
7hJ2]q2;[GSYIp]R2aak1_>odSTo6Ih@ho]S0R1>gCA^>\lOCTCEC=ddGB$
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
nOINHSQH5DT^<PF]NJ\_hN?gNPlPN8@OEV1GbTBnCL\UXm@fo09SHn<;=_DSG@]P
Zh2AV7=WEbQp\<4=f4\[W4>Johe;MCV3jTEY939a5g1[Ilac4mSoIoOGQ@lV5Ro7
5L>qD_XO2Ph2i2L4JY@glFadEHBViNn6W3mMaQqG7mTgTqe1ZLllaaI87b;jI?V<
41ahg2T_7pg8e\F2VqbQ5d[0]<@ldKn3Z>jb430:i_b`pemXAdW6:>7UHPTKQGTD
LbA<9iZdip]POQ<_;p[O=^;<G<9jQj0>o`7ieZ6E9IP5b<F=pkX=loARp;<RVf1B
Qc6L86b6f`FlWgj3T3=LpXUIEjRRe]j@4W5kglM\Vk>YA<Mh]8f^5lU`lGOd\V23
Nq;Ja<jbgcbbAW95KI?ZFUP9pRC3=NUMka^8AAEgL63ddYkDgP4iC`WW0MY9[Le7
K5k=I6Xn;8MCcP:;Lqi2YBc^HpDC\\[I6lLk?EFbP:_lZTN^5<JSU7TBG?C>S_TM
RcOOG>mD2>ZlLIPU97m7Zl_mC]pOO]_0\c8TgLHDCA_VQ=Q2FLgBVN1kBgEQ[FOO
]Th6ko9hmKZI:G;iE@D?H3_DeHho:<1flBjljOj8cBG91OBA\AqeiJUg2j39eH74
4XDOUM1qB2;J[Ehpn9jB3FK]\g]\8AgOQ4g;8K3gB2ce3EOo7olqJP8WC:LbXIbS
j]ZjFEC?AgaK[>V>ZI3nJBdcI6KRCC`iXW:FSeT64D165SggX9kSNCm2B1Zc1b6G
UB4hDYL]^R0pf>=4d^O06PU6@?FLg8X=[WNUiYjMmN2mkSTV[=8K1Y15H60o]jXI
FR4<FIG;SF^pT`]S;OSlYRVglilhEXcYpgjC:V4Ep0?;LZXLi4PIaWb\3DS^<\VA
U[haBj<RQa9jp4Qai^f76b1dqPd<eY[R`2Rbb>eGl1deX55@:EdiB=e_G[27WMlN
YT1g33E6m5^@3>MVXkXI\JYNFae]1IoE=pHgeH3ckp=W<gR:US_nHVb0aOAMRn5O
[lOTCJ;ke`E4lk:jGd0IAWZRgp0eXmG;9q=?f3aPeeIG@coDmYi1L\m@bk>cY0eA
ghbOEOLjKO<_RlXkiSQAfZoKqSlXFc\>=7581J:jh0_6VbOfeE`FqL:o\TgDR@Ae
@l8cnC:9gP9q<GkcQO^R=>78[W6gf\gPbo=PADH4mEAm`>[qHd?[EB4ld=3@=7LZ
[_l1B>OeDIk>MjD>A>IqY\Y4JLQ0AKLpdW@D_?:W9fHI7\n@q_T@<HPK:iccRkRB
hRgLLGDM67`8d;TijK]f4Snq4@oiF^^P>K\I_Memi:^HTX6lOdfDVlW;;Zg5Gm3o
SB4<;OX9AkMgbbIM>Dof`]X0WO\TDfo5:CbDG62O;A]1Rl?nRmOqo1mbd:65abm@
mWh?5PBo@a1\ani^LBBI2LlkT>FbpnacSF0We0N>Z=jdZnWRS;mWR9YaoQVmLP^7
cT;Y8kC=Z]bep2EJ]MVFK\`5HCYD5n_K8VdAnB9U>=3QdS]UF\QT3N^VJhMfB0FJ
kP7^39?ifV`7k_[Xj]6?3Dconlm>4gAkZdgWR2<Fq\<AjEnIpKnLdYZfp2b@iIMN
Rinb;_nha36pOm8l0A4fVMG<D4k=bN4<CY1eQn=6`E0NbQq\i[OY<MKmf9Q5Skb5
FZj<Je^k:XdG8PHnLRk;?MXkEfHMB_kFKaW4ViB8BaY0iS:ELZ4?2ZM>C:TTX4Qj
76H7A\OK2X_Z6[iFQn7o^HqE>Sdj16PJ8NKd=C0kJVAU?pTNmnA0B3T^;LY:08dJ
4WgD0nSXSQIgG\2T;gpW^?=_G`bBdHO<>WIZFYZ;lW^N2@W:FH]XRA6X1U13G`Kc
B7AMV3YKfOBKon1gDiDf^79AhbE>NE>GA\:0Z;5h\jiIa<]1`6RRW;OS[_pISgeC
>KLI7hFS0l83;V\A2K8TK0^`5A08:Fep2JgV8bJdI_1a7dG_>fK3>2e62R\NSc2H
gaA?DZ9@DG]iW@5D:?2:0X[OH8XO6Y<nbA:o:[nCM;V3WCfbiPeD>[hF`Q8XeKL<
h?mGDF1pNPPafoCp9ZK@2Pljk0i0k4:LZmb6pJcPd?91qIdRT:CU<Vemd@eDi:eR
N>=iZV2I6i4Hl73cZ4hC:R_bQ1CT4VSPfb:DhQiZ;>8W3QVT^\H@`;oJJZkQiPdR
qdlYYUYBpa@=M202jPF\PB8SYlHh<U]acHVJV`[2pBWb>j]dq@mmoS<Ve8cTgbC0
?fGS:7_BJce7YRBD`07H:Di3^HZ6]LRV6bnQko1YHp5d6f`=I]m3qfe[YYR^m1BW
Y>MnY]AFS9b`Y`Wb2B64^SWY06oTd4Z9J?IOZS6ZT@c;W_4Vjh0;Ff8Z4aoc:0K?
[6;K>4mblKiMKLjba@@pGEi9[9T;F<dGL8SUoRFdqAMcV[^6qa]MLH0d0b1YKlEQ
336J24V74F[Z:6V`\LSdd?JED^Uk<I7UmlWFY21p^VT9Fj^ANC<K<C<p_E5llEHp
:WcREmqG\Bi0Qf2OaDU24:HIZEkI0mGB3F@d2f7lTWRQ6cLofOIWH9KfF8lRT?g\
6YH3\m`G=Bn224]gRg2e=RfpNI0ZkJSET=bO>FGE^>YB9l=7Pe78F`c@VXD`28Wc
MKFkLD2eVOgXm3f_eA1Xn^[CNX0o4gDdolekq;3i4iQecjnT@AQ@15:RAlWcR9YV
`^mP;8dTJe8j2WI<;DEL?b4>Vkod<AA1JMELV;li476f;JQB`q@B:gO?20J9]fF]
0_I2L=VGhf?E9IFh5[iD`MNe>BWPXa<]c1ddXVeUgl[8ciZJ82:P0==3<o\dEqUf
:OBHEAobPBW3YGHNF<Zj3WX_a94?0WDZeZ[kfFGMPPVkZ0kMU]^nE_Vm<3LH\`4d
5B17Rce2qPD8`E2EX;n]D^X1UO=mV<?CF9CU>SCG4VgA5AiaWoIoDgVl]\n<?GYo
50hqB_e5@:apfN?1B2eqCL;<7?C<>[:lCbhmhff75P;lCKpK^O=;2CXiTRigfPV_
GXjLTkP8MQgDRbZRZUo]dhVKeVg:a34km`l6Fl@>eg^>^^pP`Y=A^FSf;I;;jAXn
G58KB6EMgWa0;WZq<6g>E>Pf?PGIfMhLOS?FFTXGDN`jG8^MCRP8j20UBPE@EMLq
5O2Ya0$
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
]mdD0SQd5DT^<7glW^FVP6[H:]0IG>JdImJIIdP5oH^qfL3JM9n7MoGKZhJn?HcK
J\Hg7GLTn0aF6`^XbRUn<;TD]ZJOVU8[p1gfkn<SWJJ7ijgn;VgJbV4G;TFER6PJ
P3_6T_L[MTlqJ=<EgTqFBEYEoX<AXZ`YT;^4:KCQ9GJSF\bPBV\iZSU8=EbIBqT^
3TW^4p;1X`O:DLo\Jeh`Q8E470gNLVe9M5`=>>Wnbc9?F0h@EpYT`Uk[?q@4BL>=
p2Ub\P;ZXadTSR>ZSa]7?N^jM]bC=>ZR?YQ_oog@O`QdCVkU2d0`Q4_YU=M2eT=_
fhU6e;4A@onXY_a<@nfAGl3lK=<0Qh9pM8VaS?GKjb>O=a[RPH`i@R:3QablomHA
=3MjRmo>2l0ZYN02cP[Q[=0;LQ7[mA`nX`]P499OPASBoW=0BYH[B[ijl;pgRZe2
][M<Jl<8YfRUToCL0J5k:fmLTI2]@H:^L91A5Z3X3?HK3jEh;8`A[mg<NqKeDfRH
;DF^ma\9Fm?MHZP7`aCEYl@Do1o>WZ:VMX3R<m2l9DhUTKcZ]=OaDO2RShSlm@]J
M5M=iGlnZ;5jjhkbeZPYqCHGGh40_M`?JnEeM0[>3ggW>4Y4K<JeTjEXCSCSQ?Xn
FHIjO`Y[DU;<64nc^73LFMHP51eK]7K=;PSP==WdVig@WpCH]Y:31q0J<jG\4fL_
hL77B4F14R]6TlZ0<AkIW:lX;UFg0mQ3DCA>@Ui93>?c117^]Lh7O@o`D[P?<kl`
bFeX\16@Vk?g^n1m:nV11MU4pAfN\Gh7X1AUX`45<<>gUgj3kX_eeF6qml7X2Wec
^NCMjJ:T<i9m`Lp6P>M>Blp6YQIEjpc`jJm]71?ZXW`L>G38=DG7=4TJGT=Sl>fL
;3aKSPnP;QmYlL5L^Zl4J?1M99D;<<KM>0WLA<5<l\XJ\bB:MmdLfWHj`aj^cTnm
T\Nc4IGS^CUDG2HZ<8OV>P4kVOSm[FcZi[d_^ph4;TL:?XRKj3n3ZFQSNH\0\O_c
2L^bOSX_MAHOX_fABk;[:5b=ISLfWDYbcX0_GZ[RU`<5ljFH1n;hBniWQS8@4^C?
qSj=T:fj25a>=UN5i62nQTb0B_W=bBBq4iNSkL`kCTK\WLN81OiHjKQ9jmfB2oW[
Zn;J>ZUNFn9N@l`hR6k43g[Z3\OEnC>XFL9N>h\I1:Z?gDRLJ\64QVIJLCpU?J3F
SMND6Fh==4=LcS:QQKWSCQ?ahgc9?G56VCbR_ZQgU6oDYR;^Y^4hOSBh80DL2eTi
1F\J9Yc=Pm90bm0P8?[W:q=oFIOZ=G?i_bQ]U5?kGbnVheK6NI:U4GIW3G`]U[DG
eJc:Tl]WVgH?fRb_P<ZABLiI^374Z0Pa]d@jZABf91AP;DDjl524H;9Gp0NCF_Fh
MSPD?jbM4BaaJ3njX8KVXK59POJ5DIMK7jekgf^qDX7<9e\1M2\g@72hdPkn_5qg
]M96@8]Lmic?jJMifb30h7nJ=PI=H=npL8X4\>?V=>7hHO\cQVak@DqgCbVI3hfN
85^::V9__fDAWqn[=4D6\<\hYmCiP5=aZQK?BWm]no^oQ3o\S>^A\U5AaQHNYUGG
:BXDXM2hSi05od6CPoSe\WUdGM7CP5=PiWkAXpU`7]58_p5V6<aJ:pULnC^iQpPk
1j>@Ape:=ac2EoC]D@NFQI[R5XY?:L7J961db2c_:Zl[4<;393lLKXoDM2OjU5OI
[@3dQRY??F4f3Del?IbX4oMHRfA^H4bQQG2nOKVXpkI64CKcq7oT0Z?lIH_U:YYW
;XJW<OmqdCf\`WDGn:cEV9Q:eAh_Sf`fk>I>EMN;h_B^6m8a=TQMaERDd@VZ`?0e
a[fJRSWpQa7B3?EqMS4S:2J@e0]>F0XZ_1DmdY9egEKfo<<249`Dka`[[DgOUe6U
gY>qEi;?:joTC04hCaONHb4n40<F4EFgS\@nB>^p;j0TQNgaWF`^01PlPh[TjI<2
:Vek9lGoJ<iqCeT<VcM33hLnn3>eOAA1nOR_?GXFF<jRNgF`o2Gj[1TW3Cp?4UnE
6p2E:PASG7M3AQ3XigjCgEp?ONnQfMF`;NY<[3o8\H48BoDIaIGD;P>[SakW4TlN
npDcDcG6ADJfgYg@\B_JTD<?SG23DbjM84h?XaEaN_gapYD85>[27g>ZgB>=ic\l
VJPAU8IkXiibWEJMH]KAgpIi;@Io?:k?AJfM7^nNg]76C_hT;CUI[<hOa3S^^ma4
p>1hj_j;MI3cdD]U<BEAkdHDj[gN03H6LkinX`9d>oQq2jhaW4NqHYI7RY>qK7]^
D8qJjj15\Kp@M\GfDVpI8gFRjH?Rn5d0]A9M<fHQ6RbQ`XW\FGO@3_RGHV1i<j6i
e6F7ORlpSU5FAlYpU;>VjIH;HF<59Mc]ZINAQRH?U[M3n;f]J>YHjck_@2eL6Mfq
V7SE6fXb>gVkV;^TeJYQ:D[ACV]K=aBCoHLQ[W^F]W_BdIhA^Tl8Oe[q1VDDD]jq
4SCMIdFD]KNgpAoOSX6>4\;43^dqj\`\f6M9[nZZG\U?J]hC1<>Fl4L^LOp`j=`g
_eG<e9_9gpl\nh70n>3Ogiif^4ik5DUa:BUl^<ZjYeC8GNeckTn3e?BCE<\ZQV=>
iO@89]pag7M<N_XcEh7JFYGo>GJM6;T9bFkIBqHM[bUNnWSeWeePp:d6eVQo5FL6
c9X;In[O<QVD>=JSfMJp1EK_Li\8_24OQ[pYmPNA6J@US>Eg24^k4Y69;\GW=cjD
9pZPg;Z73R?XpHkN>bS^k@^]I>BI8Z<HLjSCL8S[d]FoqQc^KY6^c^QKJl@e;7Uh
Apol^bV\Dq\Sja9aq]Jdg<4M=C[I?ebU4TC]L2T:T=ilTOHbZ6KC3Q<b[UXdH0E\
@_S`XZX:=fJ^M4fJ2YC4P]?AhFeCXh4A0OZkTVS7DC==5oH=ng0L_7aCVJP9\VEc
1=Xk2qP5lWRHCDK;QgW<VSm8dG@GQiJX5hBo=nXg1R9@9MJn0M[H<0HWRF>DVnic
RHOe6a5IXAgMXZVL=jeOL1f2p:HQ9CFf;GiSCCS7R:;hGYMH=<CoUKVQHhI7F[PI
J8n3\HDAAWVOfBk];m2VEbC^8K4EkW^g3CK<=cY551oqKg\<nA0jocLL\BLCHY^9
ddZJVeW4:l90N?4hUSUQBHd]Q@0jmE99=\Pdg0IomU0:BfeP9cH3h]flPJ:bHnpl
C2e`E[q0OBKA8PEfgNn`gkaP?q@g24<JD3:iE=:Z\J:O0<4W[^OlhH_808PM9bQQ
jR]o5VX3Bjlf@nbmZD>7:Cl@X:BNV1K<8[cOFaM<=GMMGlgF@nK=g@X2;9P^b5p4
>^3d_oEga9nb::U@l\D<oq3c87HXLpHbIknZq]leRcnUP\j`EmP?<PZbEhiQn8l2
ARXb\Y`df^]VcJ_K2BoK_2S9RAO>91>j2HI53aG>B0WUgCD9I?USLX[7Fh4iR_ln
\18UnfBH6Cn>_o^KT9;elY_>Z[n@>ggcmHX5HeVI2<Z;RdY9S?[jC4LD9qmKd8cQ
M5K\Fo3FHQ2mIjMm9W5PDCTXH>;LO>;c<NdgeDZO`U[aS;cFETA?g67C[aZik1P2
?657NC;;OImTqP>KDFT=7\9g`i:ja9gbTJB`8:1HWe6\2i9K5WiFKcH\TD;hc?81
NQD?V\54FA8`XfVZVMIU>X^en205OQ9p1jQlIM1o5M0Wg7>iJ]R]99e\He4OkV;J
SBFXfLASP8SMkAbVh8XJgcSF>KH1=XglRNI89bNgnSkkm?IRXSqFcT023dF;9FdN
22UMN8Wfk4d<FKPhE?aMX3nDX=lKC06RDH;9CoZNEfnPND^`mgcX@g1i@I`@9I1D
fPkSWIDU4b1kj21<I6PMieEpaSU`?0P?J`TRQHiO=`VZEBm<LX]?QEVUeAKLIK3:
gdfnp^4N;6>ORT6Xg1W;VAD@eT^2PM]25nI]_?g[gJmq`:JHnV3]a[1\BD2CKL[i
cL0jFLjUj_XBp<eH_L_Y06Y6D7GI>LF[3HgBSjjle_]_Kk;U\S>EUIOKpbm9EGdW
>2NdalTPaO8mKbT_2oG``qn6]4L?qQ56VR<^P?Q^WpUMEbdfM:Rh2I=V>YQW^P^Y
7`>lbJN\iLlLH=E1i5T?qoE78I=iVML0AULG^P=Sk?cYK]Cii<f\;;]21d9EG<=p
iM8[oakHK_=<FOM1d2a2UAn4PCc2d6mOo\N2]f`6nCp:Z^_@RDDUPNA:DnTJ[79D
46HHAc6bB[W99LB3e]E\PpeYGn7]0pm>]k`ofRcO>7@b2V4A]DYPI?>5ZkF]niEl
Oc_9q88_U2]6qWI^V\a4gfSG:jO:?2420_LgPd2E<PW6WPW__m1^AYIiKOXLDf<l
0Ig0HaU2;RIa_AknGX[6lq>4glFlq`SDAjLcjo2a:?>_5DV5ph\J?CdXZW_]f?[A
`<\:\D<jBInk7_S7l>Z_H3<LG9AQZL27AGRThb<I@;I`BO_Y;g3U1<VDlnN5nBhh
3f1T[f^HS2bCqcB>hR6kqhd@=T;MepJEl?7Zi^4l>bDfC6]?Ni[`eIc7AH>6<a4@
[5WEqJ]38AX2g<\IXg=C88PmpREKO[Le5LHcBJk^<QlDWAS^o?IjX0Sg6P4Na?R3
1T]iPWbO0G48adNnEZc2IRSG60n=95ameFePlgXZh3_6hYmJ@cjj6;]W@:aqmeAQ
f^;pV1;[g95ZF^N2F`a7_\c[66bnTaLHJR@icOob;lGm^YL[mfY0`62V;i\kQ?q@
`D@^6XZq?0jRi1>q8@bFgLHqC3E<S>:SX^@e@3B45f8;j<2YS1QF:3_Mah`]FnM0
3b`:QdS[8GW6kcGTjcg4eA02fhKep\MUCJOQpH6QZNKg@BMcIW44UFVNcQ^eOio6
[L:FoN?=J3cYN1[XOPM`6e<1?FK6=GU9n:m7Aan1]a>F6N]<3M;faBLnI=7=PP4`
EI6D<DmqSSe<7X:q0;;1W7Yc<6fWB3YQ]VdAV6p:7blgiiqI`;ic1S5Hfe2oR8Vh
GH<c>5de9kGlKVK?O@q4MPKa32RXM@_o^`DI;=]^U;dX_2>?V1l>:dqL7TfPZMa:
UYc7e]C\J_o=f080[k[G9LL`dA57\X_<e=]cJWZCE6;Q;HnWTb8?kpM1N;9P>q3Q
OnI2_AWoW2hI1jcJ@YaNGCgb^Hb`pcIWX[b7$
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
6^EALSQH5DT^<lTaa8f]DMB7nh4Pa5d0<aS<No6[?cdfk1^[JUo4cYlaN_2oa<EH
^aGIZAp294M<`:8Rj[Rk[f^E2:cd5>[cMi?53AO4DBopPXXWQ\S3Yj8=A:UU\ofS
Jg=kEV?WV`0SDcH6m4khfiQ]Sh4RM7bV0:\Wg@P?>dpe3@_@>qh03:BD8;VRi6W:
01`QZ87<^UIoO_CRALq>;?_gkcRcR\i38L3OG@8O<p8<Tf@M?SifSSSo^N[iP4q7
bbUdMCi6:nUg_gHj1Y^0BVPj]?Qm<`j]jqN`GUj0d`mPknJ15_@eK;8]_@]inP:?
d8g1b;pgc0VIQmqC^fo;B2g1aBfi\iH;B2lPZUFGG?[em\>gA9nIUDDWSHimZ99E
gBTck1pXmKkgEE_=HgY_eba1\dbS?;HI2b8q@R0VdANAJIYHVA[OCL;F21o`DXj6
X?U0CTj16Z\c:1nShbVTpab?n]OM0?P<PgIKC80D\bPS4PY52ocOJQlH1H70\m=0
p`HZgLa7qgQ0Uk=bV6ldUMgN>;=O>5c8BGR4DXS?JeA=;boN^n^O9bWla03?8TkM
<7;@_=iMkI7Uc1Nh;mReBA@Y?WYMN?>pENiPL2WpFN2PK\^H9d9aCBCmQ^FU<2@1
3=Oe4jEVqZI[V9m52?foUUd4;qf[]YHP@LB>8m64V_aLjCNg0;qm_eUHJRqj7@ZZ
mPqmI9D>@KgWH9mMZM9fJ9VIcE?Bl4X0H`[CJ`H4ApPl_SP>bS?cbG6HeeofMjc^
:8mDYJMn]U7GY?]XT^S<ci64_Fp@]ofFB4qF997RZi3M=KLalC<0:iZYJUi9XF12
i`XD<=Cie\blaJIWTX=?J>Fj2>pd1LK1ERmC]M\>DUA;NFI^C?TodFoUXJ25[c>b
H2V2;[OiRlMpg>QQ<C8nO7l?Gh2[k]B;K8:MK>KSh7iL\8gSVP`a`MTqNNeHRm5q
X^XK2D2U?^WAD@C;@\Z6XI:F6m?^\C=ZN>L_=Y8E\4L3:SKT5A^=CD95?hQIaTX0
EfhMXQlbS3R]eXC4YM>Ma]1q0\m8M`@q67C>=B1iAdQkb:>MeYgQmLVL6==BbGnc
bYGG^aHaH1[@cN[7VD7JnXTOV`a]K6M6JUCN^eBUB9>C5>5A4@<dqgWjZhLEmF^I
IImQ[G003pXC8ZTo]g<if6n\1n:@iDSCUUgB=c?CXBN\6pgfB0B2aeiRoVYSVI=A
V7Q2T>:ACIf^mgaX6VXdD[ZO4GbK>Ya68l>H9Af_2JHhI04Ch0U_8jiSL8\BqlXK
j7D=qCnBiBn0G9O7Q=B4D_``4p?dn9e91qFncEDVo82Ch6f2ZF1;?PWcC\inqb@:
8jF`pYh:4Lj9:;9@O:aFiF3B3a>O<S3S013eFV\pGdI]L:U6P]Kb6OXnG@^ZR5KS
QSpA=hMV:?qkNhn@U_q<\14TA;q@PVO7m[5T\4JD\G5lc\Z4]aN[gn]7Zc^B=LFW
B6qVFC1NL`]8kBIK2^19Q`j8UDdSA[i^PjlTG9V^\=Lq:c6DcP]NXlAF9iPE8NPo
9BoZI5MaLA58Bk2F7?19`N3=qknW6HKi\TI3fHdngiiTnBP]]NB8:6Qnlfc?CFUY
<[MIP^FIRlL<oS\5TqEXGTCDS8^hEbLG:@]H29;3Y5g]D`I4hcdSBGPlbXC3[1IX
e2@:LWbQ\`T@NFq>f>VFiJpIci11a9L61qSak[?RUQQ?gP9bW:;kOf<HoH;ADbJj
`o1JKGV3^8hn7UMXjNqh4BJU?=JDLO`ZA45[;Z5:WGHNYGHPmMah4D_KBXb0jNTM
9a2a<<FmRXR4]TJe2MB38P3>FGp@`_ma`@pG7_J4Q\HL<RfG?7eSYAI4HGRp]<_G
KCpb@oa4EODb;ZPW74B0MMZ;mDJF_KQ>iI^jn5ho2jN8C18q8;953\\D=]R0:gP\
27P[2`[OmfBnSZ4Uf]M5SfNjI9>\pT`f?JlNYE3LWkK>cn8l`iUlfn0b=OJOS1jT
29;YX@LZ4@4:NXGiJ;SRUpf=X`>f\99=H1GFYm5me;W4]U2RInmm1lPNad8ki^;9
8hT5oC9FG:1`1M8MRDp<XlSm5=pEcl@J4I^Pmq5j;Tb5?ceg4:]bWjVmaj[W7Ra8
adP>9c<o?K:\8Y`mkDD]Z_?lM0q6`9o:>@d>KS>E6>PKdlj3C>;Cc[e`UbIB]0e[
;`fKNlqB;LFOf0WfMl8_7MP@2WaiGn3<0g3OCWR5YM>ok;SM3Xb0Y[8g\F75184@
MKSIi06B\]J\7C:8d?pOJfOd5YpV\Z=0Vqo_\<03mOR2aMlkVEPeMf?7?>A;P5nO
a<?;d6IjABAgh4pH5c;NF_Jd\95^[`ac_Yg6KL]3F<7XAijH?TbDM]n0e>kqCKV<
eOTF>kUQ6dP=mS9bnc0dOFBljPVP4f6j>eMn^SO:d]05TN7FgfmQq[1d7Q8_Mk_G
2GkHS\BYUl2BAVA]=Pd7h1mO;NQo]PeAOLU0JdX1dnF_KkM^MpmTNVmXfpm7::FR
XY:m6m8DRj6N5Tn\GnG]43SFQXlNlGhhjG5j>JXZ;>@1=BcR[R5WRk:B^a7Oq^Wi
hLimbV?p[DYo2`DT^SJ6dbnl5YgM=M4F_1;K<Wl0I061PB8@1<OSQ<2d>PO9pU]\
I[7>WdY8YWD`20TQA@C5@XE\2oNDk1k`DAc>mFLg5g>B\6GV=^NdF2fMkdb=lLWb
[Am6FWe=p?a1hbVKK@Ib0T3XOGa1INglLP7d`LND5RWAR]fmd[NZZ5Zj8`QNMGRP
0@3R67g4N4FW:lkq51AmE?;pCFUO6:$
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
