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
1R.+,PB=PWB;)/3T8@?M(W2N9b:1)DSH)>D=(T\5+17D^(821XAA)>1/,HcB8cdO
SK5KJ](gQ=:eE-b#BDNM[#AcZaHagIcZWVfaY-=WK9g7-9:)60FJ&_PAV[F1):]&
#0MDdI.>K\dO^4^+dAK8?X\Y6\X1e+AR_G&_829-4ZZQ[EA@JWH\(7X6f>HE+0[_
QdQSC/+(&95>O)&b-J7+)YW#W\_B[g0HM&6DE#D+7?a&bZg^S:4Mgc+/.X-&G</Q
Y[g0b\)0fP,6B5Qb?L^3f>/>2EcLP[@e9V_4=-^:g0IS#\H0_6_g81]GAXHGfOM(
8@V:@H)S6SY^^VAPE=93DS>;=Bg26-RG#[_^(YD=N;3Hc^S(WT/QdZ(Y5+=#QVNU
1.\ZL7LEI>f)-ebAZH^Tc/XPCHdJef<2KcFB_=B2ZAPY+TLHQS]JO-5T],4AOX:^
[[1+KaO@,WHD8.(XD_&9N>C=-2cI0.8;,J(=.g;AREFbOS[;G_1_9D6\^HAN9gKO
eV.3dF9+U5-^gQ(aAHgVD4O,?V82,._@MX&f5TTF41g17ORF\<,V0T-d;+]8f<SK
1R@8DdZMe=6_VAdTcN0#]++&5J-e.[DC9NY)R)([MI6aC=NTfCL]@CM@J(,:Wb-_
IAJ=IQG1PQ>Rg>+Q@6)#AXMYJ&JEfD=fV<03_#(K6MXT<XHFaPO2C?.4\BMQ965[
cg0X7aDHSR>YfVgDYD2aDU0@(&<];[D0E:O=1S+:,0AAHaFOM5XE4](1FX4):;>-
c=G^e.YNU[LED(PQ^>>N5.YDGIR/M\:BQGB4=.1[NBMK7\F8c9I@5):&e08aB_Yd
>e-H5]9T-#1ANJ8[E^e1.&4#_bD=LC8=H2J&TU@+).@G7Z#f:DT.F38B;FN,^;HG
U[A59g4J4#XaHK97D2PRZ[2AHYKJ@,VW5YDD05NU0?J9]T4PAZABIQ2d@N;@8Vb3
;:2LO@E7b14FGgN?3APfXJ7<&B1+23+0E+HSc>?:)X[=.)-ADb58LVQ]>gKFWO8,
_L1R7S,fd/<]cf&.GVS\^9Ic7)T3YZ?[:TGJMgTSZ9c(e?#>5V58+0cHK,RD_3&[
D&997)]Bc0/[:@9YJfE3CQ_QWZ?3(ZQSc)GH[4-K+1VZg[W\BNLOMN\f=YR9-\bE
T3_>QN1,.TF+Y5Y=dDJaLg)J-LG@WP4eB0g.A=QIJ?^2JYb[J,Z(_db40]UX>&FO
VW0+eS:B()CSANDbCPT<OV-3;+fT=eb?AT?91NT6,_f#KGb?&\cX&1J:293gAN2M
4IGZFe2K/Va8,299GgT6&CDcg#2c.?2e(]8.7f.C=^^9AC09.IY><E5LRQF/V10?
/7SSa3Za[O=4G91Z,VM5.-P-,?9PP-Yd)X3b34.CHHTS</G,(BT)HE/:)^=&3I;K
UGM/)6HcaBGU#;K#ZD=ZU\gSa&bBRGX2[.bQV?]N(YBFQM(]L)>&?eYX0LU;SYWM
YM8bU,,UG)]DNZ<Z43D&WcW8a+d(K2\Rg0g16]G8/]LE8N]+D(E67e/G]Qb?GLCQ
1?XUYI@KfF,,20J<5/P6-4V]RK@XTOb,E2/K;,@cM?Ab>1DNIQ,L)/MDW2;U]a1]
.+:;;T-L8)XZB=#SL:QG->OBP3(2,1V.:W[,?=H[f@B0(X,CX:EK]UL&0+TR+&H[
ZI#c9PSVUaD9YASdfbaO<++Nd&QEFIa4/M6H/UI,b?C)DDfa&=dE@aZU3/[cU=,f
Y&cU)0+6WZTa7OR2DONa3)e?S+O/L#M@:8cOS4?.1QPL0YY9NF3)g(:J];@A(,7>
M/]NRV9a6KZSY_c5P4Td+NC?bdYM@=:>S:3d+@^)Qed3.(eKQcL(b+>2B]R+9.bH
FY>+\8=W6(U9d:F/#C4D<6K;O9P5G@If?$
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
dJ#?7;fe\DM<<?9I)4/7)+:3-K)99(5H),Y2->8DE7ZYF\@_-M,C)gcb9A[B85Tc
Ac]SS]<<5aOdC7<6:^4+&e5F]:OOE(KcJ?AbL^/;_C-a8HKA=>6+WD>5JfS3De6P
bf2IHIb&F>\HB(:5D=5V4=36BAC=YfeR9BE:-@PQAMJ>\3R\WUGMeXDR3[O+)g[Q
@],/8:VJgNMGM[6[Xb#ZT]c04&QJW+OBP-egESL[_KY#5ZP6\SaAXP/3CP^A15YQ
PO96(UH7)-U_(dJ#fYP?_MH=1@PB@Dc_HfDGe#JEBN9^R,X_3N4N+<[c0dG\H5I)
4L<TJaGH,LDa1OR<50(;7)7?[DI8ABX2[[NPRVZK@6G/(WO&DBM\KZc]PBD]:&4+
PC[0dEK;(AQ5(>QZ]F>TWg;1O5YN_=d-MC1BPWb]OHI;b94IO&Xgg,2^<:8>ARRU
ANHYTDL[8L[+\7H+=M3J+8_N=X.\ed;Z(#(?19dg^.c_67(&&^]a<J1U>6@K]N1F
\0Z[;Sd[&L8NaY8f^MHRa_]1QXJeLJ\KOQ6+M^X?1RSIaOIWYXb4US:TG^Q5]>bc
a0bUe/@=7ZJ?.Y[4MM@]^<,R>5Dff)48fANdS(E=.&&b+fW2NBKS_J?]O\gG)8R3
UBQ8aP\HC23(GC/;&7E:e2SF&.Y([\,dLT=?EC4>\J#7#^((f1^.O=)COY3>]V3#
+(S5S7(]=<)[XaM[TY]YJ@4+,@\WD<2Q\+NWf1>_W5=X0=@eEB=XA(@^g@?gfOe[
e)d2G?;AJ6B_VZ6X.X4cM[)J[HR?H4&_[U9-]Kc-RSF-NITY@H:K5Y/^(A]VQ0Jc
HMB;&d:3O0=B4A203_;JgPbXKTF.R57L2bb_gYG[TUJ\YU1NdT?XVPf]PNO<PDYD
XE5=)U?3&M?\<F8bQ=,KfT8b4\BfNU&DAX_8[3F,V4T,\0SF6YFa3GTQZ#d57[:G
M=.W,SE+g@Fg?W9[52E5\58Wd0)_J^90Za]1P]=[@]UfSSeF81/F0:gMFd\fU4NM
7R=\.7b95D5:f..bOFf^:I+XZ/2VL04H9)_O.WUREeW7dT)dO?O8.#@T304eH57J
(#LO@Ja6S4-#GS3S\5bV/3Z]UL\(DRPFe-9SbVDN,,,[e0O7e;Mc6POSgU@,YR?^
7g;RN-QfO&W5Z6:V2FHM8M?6HHC8]5@R-@RVY)c,b@1(FL=@Mg?\B@A-3_U_<-];
W@OTHc_Z9S\0#MHTBE&]-TA1-ATP<]L4R19.@F8g7KRf-:S@Yf^J8NcZEI5eP;0F
Q.XW+/REEaI\YJCI)9OE#5K61&S40d@EOK/N^J=&^[E5UJgF?a/>+ZZ>#gU-(U6L
4GK^E>.8&\Y5Q,]^AX+R6CG4W,Ld,W@X)X(4]fO.R#MMAK+Z.<10bY</L<?@PSZC
Ked0AS<0F6gR.cgP9=@CG2>77VUJ9-E6[9FX2ZYf-M7EfB60eJSQ=@YUgI.?Ie+Y
5>B;J@W3ABC]S=AYX4>=f^O]\;e=+2(SC_HJ8<,SANC4;_,D>0FVU)(&\G5cb4/P
V^Eg2Q@?c[K_e^-b7INW+d4;<L/>-KJGGO<^5HYWeFTd=:SD;7PB;=OAc+?OAa(^
J=7X#4YOXH3\V2cF?4Z5/f.U[J>T]OJ?VeQM\.T/B8X,4F[:Y-EN-?IdK.,d38G5
OA6T9bKBO&O2S981(;LL(ZNgb#DQ,fY64M2Wc&<f?E&[+a(N(+@HK+bE=8#[@+^B
G;7>-8HAfD@F;T^1feR.(Fg88=:Ya>.QSQRe>#O0PM];W#;[,6XN<P.KLCRVA(dD
<^@\A:>/fX/3\[1fC1b>1g82b\KUgRG9[&6JC#4^3TZcJID&U>W\\7RDfID)cWBA
R.+_)dg)CgQ;fD/]PbZU;?@8W#]AYM3b[def5fW&7BfS#&U-KbfEL>)59__K]eNB
BN]XN\XIV>CR&I9LK32]4]-<]a^<:\T#N1XNBN&B&afe)V2_<dG\X&KDg0:[DL(Y
TXSb5DGQ-W:/D#N0:=A3RU^>S]0S[IE(8gV\X1(8S16;]7]3:CTUIIFS]eB7PR+Z
=f=)>X7WA9;_2?N#MaBDf7ECG,S5G][aO=cM.[LSYKW?YMBR>7=W(:;+1I2c.A[b
b>fd/WO8MOgd:YJef,Ze.DA_08HFgQDFU-&dN?g^Y+,gP<JTd4]\K_Bf9_N2HUU5
N/[PG^CdZ;PfP<+6^]1?4:<a1E=[/S2.E^d;P,JXR=E_EW.+]?L.Q,7c>.0,S]g6
eTN/-bMFEI.+\/Q8D&]K..Z-58^XSd?JeY\M:bFcXJ6ZIAE&:]BR@.@=cBOVW+,J
K.O[38N>b..FDGA19GG5(^S@E4_EC9-4G2Vd[8YB]2dIU>?WHeQ31;53c\?Pf]E^
?XO.W:?[N/HA(<JD:,SU6_c-;951=ED<Q_84>:L5<,N-)]BN]]L[1[YZS7J?NdCf
+1eXfV43Hb17==PPXXZ0GfIPg6MfAdCNY/4^:/U2D,d<2F&UWWe2#e?MeJXSUMKA
\N<+&8<T?;AB8;W?3:BH16BJG[KC7cAWaXd;5e@^/#=>RY/=>MI2_:ccR5d9NJ,L
9W?TV/8HEH6^>NQ=H^02RgXN+Qb2bBeB2FLK[K4/:?@+P<D_+d(<O5WACFbDcc32
8I&26DaAK&LR0#8HG1b(?.C/.XU8eN=cTe(;8>;0<UHU:^XL=?V?7,;,V#AW^ZFZ
OFQ>cJN)bDCRQ.gJgCIf-V]?]_cJD]VY8KMg6H17_#aYbJTbLYU_J)T+VL>QB@JS
TLdde<UKR==;0d\FD/6U0H(EUK@<CdYS9;aEA,O\@1_WJWUX53fgH+cTIOV49(fK
R2GCb@<SBCN38^F8aATL5<S6?8W\,FY\4aO:;+H[;AKM)C25XW)7;:&MX^KPfR4Z
<-f,&.@G4R5d9LFL7RED.D+-@+GNL]a\U2+Xg0^]?D2O;6K(/MG)g[]&@.4PGGcV
XF?>_,:>Lb^d0$
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
-<WW2EJT\b/L93OI8&:Z=U7[8S=>,S62,CIS94[U9XE=3QR^/@f:=VO2)<5?8JZT
GH4&B5UI]8cLb4\A2BG@1BN[L9LK0^.K+A+1FYHfc\VDdMFM7:F:f^@:B@YZ[J&^
d7Q4>58B2HU(A=6feGP0ZeMTg35gD\QHB-C:P6NL5+YO-C)0\+<)bU:+8Q^7f-Zc
1;/]1-bcBS>(g+HW^/=44eQD+U\9+:(XQa?VW&d2V4JQMPY?<+Jg7gNT97NIc7I7
2SF(bbWY5g0XENED^;N>)(QP5dP;2Y;2_eA#OYHA^0X-U?>&QeX?9BY=gS/AQM82
Ic]bfX./F_5X&+ERa,MC)1F00@LO-Y)\7>XO0.d)J;/&(6^B_B-OC=f-+Mc\;Z0@
;O:2<4NB>0#L;&07Le.K5?7De@^TWV/_I5PeEMCa=7SOBRG6,2AY&7gF&0:O4E8R
OGHJ7WR_R^BAG/_/0,]@,[>gc@\58_K6EbG5dKI&eJ,A<2TgL,P8SZMLY=X?P-)5
FXBJ1#]3=E2Z].)#U(^/A:O#gN[W7J]XTU)E+J\YcLbS3-MWcFJ_BeH[EXYF82A>
>-6^:AWM&cQPXgVVNU0?;E:YR@U<3:.V4-d8egGOTO4L1RQ-]B5R[7K[1>?:XX,G
W@<+<0<QLRK,WD=b)2IK)CKePFf^.WBea>R78Md&8_bBXT;7OJ=8M,XWG>QC[8-+
U[\A-<J]X9FS]G#]:F+-_([AcV1X(a.NSAZ+.X&D07)>DJA_:7P0V1C6=8&\Sc,G
1RLRYK0<Xa86;_37-YL.#PIT;2SULD5fBSOV#Z6KLE(PQ8g.FO7_[J(.@0J=PHOa
?;&S>Xg)OVFbYVB?+,>S#AUbf:@55G0)Xf4F6X+ICg\EVgYF:N_NALe0N@_R5[eX
&)74==6D[IeOGUAEIGI1-G:D&I@8)HAUIV^8)0cIF/SQ[PUUK#:5e]>I^_S+6;.-
<R1LgLD)fB3<0R>?K(aAU]OLC]T?110CDR<E9B6-&URgW6I3V.+Ac+C-aO1X@75H
fI,IU0KI>PJRa6O]?U,.RBSDXd6bgNEO?YTMG(.X<g3/^gS>8X7BH/PP5+3\Q(4@
AW7,XVRX4.E5?[bOfM4X>Z=;LbSM<SW=Z7eQ>=-V\;8=DN5a[NHa5FRX1KEP;[DX
E<[]#OKVa9B&0>OWE)Z>9)5eWMBSe;6Z>9a4I/=[I]L6gg<M59&O2-ES->eE=UAR
g)Q(7X?0_23PLe_EgZ_AC)6;7dc7[0P+\Qb:A8VO@4+.J^6SM6bAd6P_W,Z2\e=d
D#dPeW#;UKU>9]\<NL2I_S;4Wcf(9e=JM+c#5H@K7SMN:ZI^V3QUX\1.9d2Y:<LX
>_J?/bPfY[,H5V=7)_@S7UXRV77UL_FT.[52/g+bF[=CFUXb>XSC#?#+GPKUfe9T
D5JB(Jg<EG5bA1b0BJaLYJUga#2Dg[((_^)?/c7N13N9P2CI)4H+<4^KL?-ZX>SA
JAMA;<F/H3NcbVSa,MC@)?@R\LD>O)8M]Ua+67#5/LeF0PXbPRT^VD7]&?RP-E_E
a@4,a)LgQ85-9dWN:981HG#)CQIc?OI=/C:BM7^;)cR&I(?XRVIVTHN^^[W>Fd@S
WaNfMgeN=PA<f2#BbU97V2Fe9RDK.A0_RE7PIFT;VRYc;XT9Qb([5NDH@[7I;=OM
KN@<_;fS)^A6-B2.^X0^)RKCAL[^^dY,H?@:V1dBNH.F?E+5?:B>3cFfE#U-;;2@
4DTDe(HM_4:,b8>X\+G-?[aZcc]EEH34@F-#]1D#T;E41f_Z-a3If-1^eeG]0G3a
3?b.8IQJ_E75@a>]<_6VOa6C193;),KH9<a)4</@S?&^gdQ]Nc_ET=@Sef-[7Rg6
Wb9SBV,[YV(baAOg#:KW0WcNVCN5_C)=0UH+R+g#+R\V&QI.6H@J@BLG,X@ASGYW
3KG7FaT65>FBR^NW-fQDTDUN8<:Z=^9E:eX;3847V2P:.CLS9eL0#f.)(NJF)?7C
ZgH-JAH6<7<g2eWV2Y7b=0X#H^c1:?B]6WXUSc:eAM_ZGX<JR8D^-P[M3T[-]D9&
e=aN20M8,:24C9-+;3feJ9Re)cKHXBOW62)3P88@Z9@f2=38S7/YRFIFVG?PMLH<
#A41SB#/8Z.FF/U(4]\9K^O35c7A@BI?Sg66@cZUGP?W^6d+:O+WITcdgGML(Bd4
VS[3)0^Yd38O?O-[@eW+4:OeUK]_L-9;UA0ZU;6H[[SYV)K40fQD:FMXL/f^&EaV
b7((+6][cY@D#bO\RAKb.(KBD_\Za0N)d[4C:8b?G&/S@D33UU0aWF7d]AQI:7Pf
,XWAUCB9\][@;RdY0+)UB+f(6@&J8Y96@IFZcb/+YEC.ILe00-Ib,F#Ae5T9]JbQ
@b=5&@;2a?=AaZ^(e0ID8XEJeS-S)).47[-4TAf[eGcV/);3/b9,Ta1WU>4Je:I#
e?.AD(bY)@4DAeFT7//>#f4WVL>R3-g[7&CJEdD#(YOLM0Q-f:=]bbMceX3.B&L\
6Z;d97WF[7:KHd0DYVZ1E/f:5=HGA><)/:J9>.#@;B)#fS39dcQF,+?5-BPO/bC8
J1LVY8^0L^X0@MD[DX8ED8+FZ-K)Z&TTLcVPV]7@+9J&\&9Af(04CFcUEB6P/+L.
BeI6_;T\W.62fcLfd/;)f#5.THeE9FMYP(gC809.UCdH&=)Z+A2D,8:bRIBeMSb,
eg<f3.,-B:b>A7_>B]V(LW]/I7RZRN]KDDS+PNd-J(AR6GNOVd_Q+8RDHX4e_DK+
dO@<W2V\]2XA&.A?)NN?VZCBHOTD+3LJ.9FE];BTIMC\\.+UdT/?(2RdK#c[;+F)
^WeOO0@A.@XO1EZWG5-7]c--+GLgOffc5GgXg0FM2OI+eC0/.A?/?9MGRRFRaO.f
KKK1bZ+RTG.E>QgN1)E07)Ff7?97\^G_5M1g?YX/M,F?&DZeSI[8c5M0(1,H1(>C
>].GFc(3dP8V9WIB3H94c2)cFa\I9Q):@39HX8#9#1IXDb2,2?9]Z2JGaDVF/Gg[
E^g2,NQ?NGa(:-+VLAA+S,#bOMQc?=7_49_:0cL\PJbc\E#,aJ>,,>,QS6a2ZORW
c2;1,#+BI7M;Ga^(J^FB()#^ecU.ZW73^c6DJ^PT5J9Q7W6KF>5bTeNcHGX)500Q
MB_N(-&M,Z<_JbAX5E6]B;^/:L6?If^YNX)8c3-#ZP<(W+1PD&[db@8E+TJ?(D<8
&3/b=_1Z7F[VLJZU=fQ;7cAZ;@K)MY^=#3BcUXPT7__[0fdYWN]e>CJGX_)SKW?(
HJVM[(d,X/G,+c>F&_(IUJ(2]X8QNR@M167&0ELDPR]2S511?,,baPf<2W+M;F\]
MSPcE/F=eUM,a+_YQf,^d#)1(T3_#b>(;6,Q?Q3PIgJ-SFY2P#d.ZTSVCa9\9BIa
Z8:XO>e>/&[D6,.:[B)@Q//G\I@R\I&bac,S;ed5?SW4aO[U&2ZRO3AV4&&<E,PN
NMg0gDgR/03@Se?P>dDOfW5#E?XQEE;\S21cc2cSB+X/,>N)=KO#[IaW:?H\;25R
7E0[2POb:Rf.aA)#AGT1bdd0;W9T/_5eH?+[DBYR3;aC6@Y+/A^ZI_&5/Ta4^bU#
?:^)6[)0?3:VGcgOPC(/f^g>UbX>/(\?-F8T:H;]F<V8W:=d+D&Vbb1L\3b-g>PJ
[1+BVBPRUe.B4bOe:F.9DD_5Mb3G&f-ZY]YU3C-#Le?MH7Z,#T(.U2c3HBL<Q[P-
DC_#:^U\4f#gG01&GO+><d(_]V:d@dO_-897HB0>KI]&3QaGH#=>WeS@RJ&&U4?]
^MWB<,a867I1C(De3a)#WdGR;,e#GB^e:AE?6;1^P=>5G/b,8ccEKSR:;YUg905(
6d3R3>?T,^HbOYNH4/;R;==C@3EGa@P(_-P\#:D+A7Qg/&Be6V=Oc61AVA^UZccP
:K);cV^TP>S-=Q.YL?aU]3;:L/\:\8=HQK8?ccIBAfVAdcG;6],cC^&T;-<2fEVK
T3E=GAU)3/0UI?=#5G3#8X?0cOG,1EOK\UWYLg7[3DSA;.^-+>:]AW8SKT80LX;R
UR=9VbEX27Qc0;OMgGeL@,/?bI3/L]7.D;HFBed-(U^B3,>ANV:,2((B.eDJVe^Y
JW5O0gZ@(OTc0L:Q,R_eDV>LJJ]3SN2AJ#S3LZ+d@J2>68Wd4N+C=9XA&(SD9T@J
?DF]NQbBa>[+:2018e]ZgdJ=ZQJ1-a-Sc4APK2RFLA>eg6MZg>W32_?QUDS];4RG
YX;Na2SLGB1NAV[L12@0^,H_Y?Uba5)e7NdgJB,@B>_7=KK]BIHJ@-ZGNZFH1<A6
P8(4MG3g7;XK9=KYM4UCOZJ5d+MB#C1[VW,JQ&:F_=b4#BQ2?]<E]LH#KHf2a2ZS
b1XbKY)9(93V/PcbWNMX96-.:53<\WLe=VF+_4PH;Wc?Zd1b_Mg@=7IO45GeP6AL
fBO?^0&_GQ@JR2PGAECKKJ]G?eIbg<&;&0Bc)(>CZeV/,a\?ZGNcC^d9P>C\.V@F
=aV/6KME<bOZE>Cf<8Ic#?-34I@dH58><cQI2H/@JCDYCQ0F0HH_VH2?O->,CT==
NTZO-FUO(P>6RR/3S92e0\c-A26ZF0ZNR:FPP7O+7=(2BENee37VLgB:XGeD<f,G
CPBf@KV/bTX5BC]J.b5_7c5P3g@B9FF-\R?]IGMG05.Y8<,T<[,YTQB6V3AVU_XX
.#G=\SPP&L[cSL&I:f?X)RK6N8J:\:L(a2O_-)bZOZbFJ([#MYLP>@X)3(:DF1\B
[\C0T]17I7D#Ka^M[UW7PQ4L=G/.IPY_C\]8G-.3BGLJ.+#8EgdKHZ5NbVH<)-Wf
:Ld,/]JHGP&7RE6(=QNM41HR&E5Y]?DP=)_,6D1@<,g^O>>=^,EJ77=SPdQ>b)<F
aCcgQE2Z<K@7_Q1/G-L41I&Ba<S:_3X]LTJa;O6G/:BTZE?NX^H6M&#;/W;,(&5S
-T1ET(\A8C&gAd4=_RbZ,S:B#B0\aPIK/0N.7@TS9)#4Y1,VU5KV1GbT@]#91<,]
fMcLLIQ,bRL_T]:(g>;&ZQVUO<GfWW,+#<Pb.0a4+&eP&&[E_#CEED/_(P98G:B:
8]<)B6O.L#b.742/<.3FDC+/_HDBVGBBG:8JNCWMLS]-#b]+Z-=+JO6U2;D=Cg/#
ANFgI]AF5LTGPfIg8F<HeJCa4AJ:+P:\dd@dFe/U/?UZ<YV/0W]@&TN]-[Q?1f_K
<JM49TOU,dOG=e7C9^WT:g[fX8_<J>?c6>/#4KE4I(QVOKE9+-P1NKBb8SV;26[,
SbHWO>3RC][_F+ON4EL\=5,G1&R-I1?EB^&>RNLOB2-9VEgYMM]ZF&WQ&b6Z[9Q6
TF0U?QZ2[1bO9d8Jb;O=U>eM8A^J4A6Q1[,,L^dBbbf2I?/1P(A^.L<)9=IM4&6d
:./(W=#ded>UCN=[=RP-cU&GNa4e>OE/cJ+K^[B4a/Yg05QE38I/R5B[##3+TO-6
AL2(0c6]PWM+F@13B2=V#FAO\&S>39.8W@1Z3,PIEeVdM5CZWN\=SCO>aGON,[+F
[+Q3,NN2J>RN1cWeCW][OMdg,1FSQ&V?IPYZ<3@KIP@<AfDHRdF14BI/3S]R&(P(
\3gQ72ge-S[K86c?_KYgQ813dRWd,9J#fcOeed(L6]K3I9TN>QT.5NGS<#)UC/a8
I?)C5@+N-7&?MQ1f9_a2XUH]A>XJ6X#D1aRT0K)6.)=b:cLXB:<C/XKgS3QKJO2A
gAA;I\P&7gXVYa.Z0FRb+K>3YYGCZ3-B1\GNSE7?;C]dQDCG#;D8O,MJ0YHQ^4MT
=MTYV10<(PQIOa<IJ[IF+c9EA;BdP>WR[[>;\W&>W\&L53<:M];.,Y_2e?+TR,&R
8DZ/-8/3?:eD/,P?7[S&+SA2f9RKWF9Ja#^QBcJa<&I<_2<Pa\RK501C23::JU@+
(d/J[0J#Mdc\4+;@V4\1K3U6DGIbU#<<]BVX425JdV[8cc?L;)LF9fEZSaba1+^Q
cG#M+XD\G>D=T:\=<(+@O;d(aT;/)7F6L?)8=CRI:MdVY,YL[QaaYO1>Qa>=:L.W
1F?,3PSe(0R+If9JRS7VL.NGe\5UQ@.T=TY\-c=f6cK,D61RLIK(<WE-Id(+Nebe
Pffb:\)ga^(-0GbaD]HJYUPR7KX^>eS.>@N_gbXIB97D=LbG^?P/;)8W?G&f-D-]
(4Mgf+Gg2WN&,_Bc#2\23I82E0-^S<V0gO:OTZO+=D8]@d=)4Aaf<M8V&:+D-;RN
KW@5[cRVK69;YS)G082Od.8EeX[>NfZP2CC/_>_a#;P;f]859:MH39ZPPaDQEG]3
3.?,B&KNe&eAXYDFJKGdNaVb>?_]LPI,AQTZ@W-#]b0<6#F8(D=1YW;O4Q&B-aHY
:-&Z:a#g(F-ea_8;e8#MDJ9,+<4&>\5DFHT<865IX(\D,e#-GR@[F]JUa^KVF1AS
<V4g.cHXF-^gf^[d](A+<7fB+K;QL(]_2PO<NEX6?2S@EP,2g0Y(YQ#F=J)(6>.U
)3\Ug3fQS2Y#Rb&&KJ(X&0N:E(>-A-/P(F)fe#3I&Z-?083=61=C-C=Q)R^]ZHeQ
X9X2<(?4Iaa5X-\J@].3E^Kc;[N5(X/(SeX?>/.faHSM^+9B6UK;_\LTfA]b,eO=
0<5=M_FOKM[^0;GE\P/6b3a7+03<OS\KR)dG7UXCF\V^I4U<@?>/[f,J-dBac#<3
OTSTC3]>Z:1.fPLQ]E]8UcBT#3N(H9B[54P<a6M_Z:>#_?)^OSIf#<L0U5NSD@52
@481B4Q5-E,NBeE>=5U1/.&HW3M_I6S+MZCYP@?(X9aLb/BKZVD7G,;LUc0>/8?e
H26NCGb,^?_BX-D^Y=3)L@VCOKW^75FMBFL09X(X0C/YI>.eWN&LW=Gfc5#>\AI,
]4OL[U.?b&WbSfV<.#W^V2,>8)(c[G5LcM+VDB#MFYAXTHQ#S.d,-AZZU7K9F2YG
&P(B8NNSQ&[NB)P+@d\(]W-J\a.,;.N>M(a3&WU;+dQ8f,W,Mc2fM@ZZI$
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
PgUUF?TMTfTH)>gJ=4IO=ST&9.a9,4^\(P2M9>8c4B3BHR43S8gR)C;5=2#\,7A^
1a^=R.3[FRPT_QgGVLFX(f[I]NRL-X]^<\4^LY:=SU)Oc6AY?Ybfc8L-1LULJE3F
fMd9dO1A@&&R_\RRO=C)2](9Y5@TdOe?eGKPD3=7S(6dI+b01Gc##G<Y;IEYB_fO
BdQHNZ;.7=APDcUbdg-/\&_NI:Zag?Ie4KOb^7E[:&LeaH>-8g_R.Q2\CJ+BSg;5
db:U];W9a&8L.;EgUY0A_253TR,>PJ7@7LX\C+\[.K)>/1<2.5]A:_g,#&U/7P19
&?65HQ,:L?\XG&/+XfaC\.a+1gRC@97/??./G,N7NOQgDe@M-^bH6+4dY_EWF/2(
6^dBPB09Q7H93/@/D04X^M^(N6;=gX1ZeQ\;T4G07TBB/9Y#gfgaI\7;W9Fe5U3Q
S&6&>+N;31EW.\ESN(aX:Dg,@FVJ6Z\QPfSfIY&be)(/d70f(QBSDSN\2+3+3=08
3>(A430I6[7g<C7286/?g&T68+W=aIbW1^O8,,XZPg96V=Vdf:b@f2Va:598/.YY
_]EO3Z@G0I@03_8VdZWZ9\++UW6e;665UQ7E@4[P]d#C2YdQYS81S?9O,-?:Z0^d
.URTdE^T3AgF.G5e<_D6gY4)W7S2YeR@d3_S[c[Hg#_?0MJLV1\W)W6:?3P?eN9L
U-IE>MGb.Q1OO:MJ3<#/_CDbTXY/PYH0:VG=Kd\8ZD;U^T7;1\SKUbYeBT5(X-XZ
J58-BO,IH&ZIdO>#]7Y0<<TO]=;86?K\M.G(F^:OB/S>@7PFYa7[:E]1D-g]e-ce
[:;0>R<C2N].931C;@g)6,[DQ5<e+I;\=+A,=;9c0PaI[C@8?\?4NL1b-C(ROaBD
Q7LX,>Ib7LY_&2K)C?WH/7C]7?V?=T-[2.:B1M1-=<g<^>Y,#7c_8HL;-62YT101
A>ffgDSOeP&:RD&?.8CA?(8B[/SHa\@FHVXK:#e>8Y,I;Y=3>?NXf\#g.4ER[O9d
3,2Q9+\gZ_LI);+X>GVO(JAV4.1.75.HU8_#7b^3(VC]8T7/TF[@g2\;6aU]#W@7
I;X5[&]AO.a0X&f3\-0(7@fKTc1\.,aS)^^I:SRIP,[8&Z<YFe,f&W]N<^WbK<cR
-_6G4b(c-+9PD@K#-Qg1_NG^H?WZ(MX/S>)TB#?H&LT?4]ad0;D?0_PbPVSR)W0F
X#NIVI\-)e)V#g:24-<W<F6HFdNf59F7CUg,bgVeS->[#\60IJ#dH-DeX@#CV?U<
g;M9\WS>YeDgHXS<d]bPXM+)<e#&2C[T4Kg3?P[8^7MaOHGH^U(\9eUe<0d:Xf?0
Lc@7(V^B4Z<6F=JgDS)=31D8U(He5#+-1[(RTMBB)P/,S+B\(WH94AB3<#@Fb<DA
,LdCYO8fA>_bR[DUIE)ZMA>CZ-dQSf[U/#eE6Z<21--]A]/;#a4+[030\eRT71[N
4N8][J-aL-P6P/&cUb[FV6\L)(=e6EK&M[JME-@VHYBH#/:;?V[UN9;5ZXO(R/[-
&CV;C#dHeH=bAQX1(65Y5[I46gIDQ,<gQ2(O]cW9O+N6ZA:@TCZ=ESO^VT-Cg1T\
@&Q\^N^N+)H=ZHQADT1FfA??G3#@KYH#,RK/2IcA^Q&Ca4.\GdBLb&PKD:\4D1.M
[,W^DYK]TfY4[6CSf/]NV._1H:)>dJW#Y<@AKD36BAM4dND:#.aMDdC;_0TcS\[6
TfK#4A9T9EA(=2T0[J34G/8[;0\+8MDaI&AP#K=B:LdY9?5ND1MD;EV)OBSKcbS[
(]?AMKVP.],P0^YMX3:<DA[(H&]F:aag14_3354-]9T@57&fJ8e^BH/?M?P80R[3
WASC9XADe^3WDRP+f7=HI_-Qd?O8+D3^\ICDK7V2]_E2Qa7a8F,_K],,\+FfC,IW
/a)bT(]g2Q,A/O9LQ5g9?fCV^P20EUO=aDDA]b87AR,(=PM.#JKZ0IRH8b^Y\7A,
OYWDG1;-MAC_^Z\)^5>\)\N)1DJ]Ob4F80SX.aH/]Cb11+176DZ7:F;I/@e67KdK
EUO;#U&g4.Rb@@A[^9-UW3Yg10F#+X<?U7((^K:9JZ\d<U-?OZM71DBdL.-^4UD<
PI?MW=K<B^B6aG13]a&)?VGN/g-=:]>@g7gYaN+1C<^N,A:EO5RY).FJe6?cZGXA
@;[M\W^4#&=OaSX_6#QP2+5XOP?J\fVXBgD[4FbUQ\7@FgLWAXM#D+H9:;LM:Uf]
^I,I=CD3\a>E-68AM-<DdW>-MB/L5TA6b[A_GaJ;6/S51a>[]\M5J7#;CDYKN(\:
NGXTZ,)^RR5XS/Db30fW30]E<(^GVcJ3YT#cNEC>_Y=&1I9A(E6L?0;A1(g99M1_
2@^.@=RAg\L-;5N@@(W(N?Tb55Q),CQWN\@f?KNYa:AG(/DDZ2TFDAC2(IZ#SU,H
]R&(T.H6/46<bL2K7bWe;CD\(K]3K-CgH1L8#)JQ)2)>F3HcPW0:VLb@eBS(DHf2
bY6?#N<a:P]Z9Wa-Y(DCEL6GIWA1WZ@[Ig8e.=d0/;fPJGA1HCI#:c49.,USY@SS
]#M9#IL4ON=D?e&-a)6T.T9G2+0=C9+==e//3#F9=bK\Q(JNJ[1/cJ0McH7HZMT4
]TX<Z&gRIf\Y-c7J;(HWM@d=9F[OG2W=15IbXX(B;3;KfYBE\,[bYC:e@3+_TP,[
V5gXW9caE3fb0?W.@?FXQL>PI2VR6^ca4L=M3E<&SCA#aDRKMf^/cETMMZG;[IS#
_<G(4PbG8>IU]4@/:M5=S,F3WY&5HAL1ZA\ba78?afT]OZUg36Z=90@5K\5FJFX[
;RZ1GO#<aefK55/<#ZD:P5#X9ZbXO0@5A)/.Rg9B//0NRPBR)GIU\=3]a#aH^D)e
#YF(>;^2g72\7=#C94(HS^K-E[AS5A2UQI7[abT=F)#c[c/bOP(OL;TN4#c9F;#8
bX)V8VJ,8)?Ace2MS6^HUJFLTg5gC-HM[/a1TAf/7(QLDESbdYOW/#T@H@S<6QHN
]VL;:(\;c\X62Z]KB:]N@:2U:_\7@;/)6dB@UMIB2;0a9g_/A_RI^MAP2<W&^(JG
10YW8PeOe>a?5THG22V[EReJWT>&=3gS=Z3IPGUY?;9HgRgLG2P+N^APP$
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
J>eZT^cE\a0D(?V-,2bW(YfL</Ig-/T/,>Ne)D>123BeB4I3aQ<U<e>O-fUf8N]W
0W,e/@B4a3CM)]]>-e/=?&^R;RZdAfH5T8ZI_Kg4KN_84Fd[4Gg72V>SG.=a<_P@
V^.SDP/bT^.-]6YLAM?6IG,;RCT;Y/d:3Ce9@0aC]AHLAf[V#7W=&AAV+;I@JF<T
_LERB-POG02)bQBc?W.BB(CdE#GIXN+K<CL^9@.QSOb(8c@I<V:aY9/dfgd:AKS7
JDb5.;99Xe&?bE3+N9GT0GaPU+9@7;IIOdMQ,Q^=&ZX0JJ1V.f[\X14&NK#bR(U=
IGI5#JP];gWfL#,^[/?da,_MML&:OT?H[I=AJ2OZ)#II1Z-cQ6e:KS&KDNSKR.;J
Tc,T2GbSH<B3+CQ^N7(YD_OcNN/S3J^\<5b5=FB4B2U?E0C0;?JKGJ]10[GcD,7?
SSOT#BI8R6Y#@9/c.D4(.eAJ.FQ]c<\1ZF\7]6R75d0OLJK;cEJY@)Zf.43bRKc?
fMDZa[&:+0-aP6<JUH)<,Z#)R^VXHK7H(_bEN5;-71D#e?;&D?cCZeX]DR0dXf=V
PL)V>afS,B,[:6a->JZfRUCYR@<#QG=aD4P7c4?IP&_/H_XY]P#0LB+ON<9O)B6I
,4f<fDRMd6F^EC?IJ:0@\0\Q^7EOaNY-C.FV4H^;f;+IG,Z1?Q1NJa2PeJS[T2Kf
[:M?fV>[0cbbd6+cRN6T].Bd+DOO;_G>R.G7bN/&(;.;fZ?+[f<F,YZKTF+SW#Y_
c31ZK.V,/P#8_E#=d&=A6^T4=1,:<BJfeW0U_b-=)_W_Le^);I8B.^2MN2f_V9@E
<3)c,/U+#3B53A-S52J,3fKBG)L[PM5<=(eCGND/Y\MgJ(d/e]\E@D<da1\S+8X-
YM5cfT7@fNDK)G8VS3&d&&O<L1,6@?Ibf_?@4WNb,)9R6^>,0&IV]P0[9aW3Sf_E
E,.<)0\D6W)@SM8V[.ITcC#<8fVA))Gf]EK[D#JB\UX[\:SfX[K#:gS1>g(7a@-:
8eTG/A1=L3H;gN<gE\\F57\F2?Sb-B15=>U_cXJ2;Jdc[Kgd=Nc16Y[G;P-M;?V-
N[(G0;+BUR<6&-Vc@4CaAL>N<gbH\:SNCV<86>=)R7/H<[X(YVHa]D3QF/80+c/[
f2YE]Q<7CH1OC9UO+gfdC.(6F[VFUBY^c7H:D;e,JUM4-)?R(_<NKAcUBZBF8(&8
(IJ+K-(+8B_FTbg^]+J&2QE,+SA_&60LL9S52A8I8E<?Y.@f\ba:_8[0Z7+2XUD^
XHR+VB8gI_O[,V7:8Q5,WdT6dJ<#&T#F0+D6Ie5H-)IbbCF33XEId#Z@SbRI/G<C
2AcV;9IbP+7S<?Jf.E9--#T(569/DZ=@aOV,c]FN:<c\?R<E\E/Y6gS?&d^>SN[D
>?7G3eJS+AC.KaV?PKd022HS;F/NB[[X7:/SKUF?\BWE2]4M4O5\4MEd-faHOJQ<
<d),./R<.[NL&S5b,/AeJZ>_g9O#A.0]H>b7[H=_V),]V;L]ONfBFP9[@6(JI.3=
8J.1EaLa;/)BF&&3Wag60d^AOCNYKO#BB,W6=N-4@LgfXbHaAC>7J,L@_X=,LXN<
IaSTM5H^21>JF=H=cXd0Z\1TM-PO>8]F;[UA7@Y0KVH5,P5(\O.8O;837+L.eQ5K
.UW+-_^0dgB9HfR#_B[9V/)05\N(g4BGcg-#I2/3D6G,cG-3]G4&AEA6eUM4BJG#
P9XZF+1eFT8YOWMZQOec:TJIfMHJ,B[6FSRB]<QTT;Y9LT3\-#Wa=]M\J\CSdg+)
[I.BC)-\XFSA8MOd3YM;@[9a3R?Td4J7CUaZ9.6CZAW).L:<?aR2#^X><6QDK2-D
AC.&B90aa9#=>7>TA[80\UU3G,bLMg,NY,@N6<&&VGH=Q?#)D7@18;[N6#A=>aa&
+W]^FQ^g?RSD0IWDFA4XfBK5W<]C/T.<(6=NZLF-DcAL^ZA8g:.1TUCA:\->H10?
<I(UNcHaEI^PQ[-ZUV/EH5+/LTMLd]9-I,+aQ823dW9e^U2(aH2TIENXY6[,fR4d
aEK]E,=[bfTSHEKbaEU,Y<;V:@e=9;_gGX:]V#cY#7/[ZCLB_E3JR+eQaC)a;d:T
LT?(M=NaVST=BQ-HJW:ROY5)a2d@f8T(C@W@VENd]54Kf1C/Hd4H8ZHe_B\5I7/H
;=f(PRa#T.R(39(;F^D4PX@_?(PgW\bNVaWJWZ08aBS(.8:W&AH2QbLTac/S76\#
0X-WS+/UO/,H:IV/H3_Q/L=N\>88DRV[b[2LJJ[+N(E:c1aZG]I_HBT;23>TNRcL
9YdI1MK;99RE\e)=10fVCVc&KX&,]aU_:+)K+ZfZ7.g&cG&BV[:\>UBRW=21TC+F
.K)HaQ[+IG8FYT;C/M1N4;]S2BJ_c)RKX=-J)3B(6O37R964WCHKF3<15(_AgA2#
9S]@O^28B+9X\MVc-SA-9Qd)R^#WPgKFF^O33<Wa#YAKP^2Jf6G,70;<F/HFf6_)
a_3[-40FcD\&&.\LaWXBT:;\d#/ZcMQb2]61<()J,Y>>K.bJNc03Lf>fTPF<#N3M
2)/-3c(PQdggV8R2+IQ4BU/I>IOR?QX6&W:P)4<DeMZ0)B.cL(:0_0fXRa<8g]6@
=DU@g.\6-FL1b[N><cQN+I2T;Rg9:-\#WAP+-C\LUGOB0?YbEVXDL);VFIF1:H0K
IF_?+c?OY48YX4Q0E5a4G)7V-_e8+HQ/_g2VeX2F0T=9Q2_3QQT.6]5WLVL^KHZ7
b-A2,U5c&9-+1eGb;2:DE(,A46(.D).)49)[Q>7\;4D1H=C?;(Be?H?=C-_g?)0:
a.d+-@aU/T4/Z+F-e/UYU;2[W\-HSQ;0:bU69][Df3.CWO)(f^Hd4M:d0&8g=2Q>
<E7;Y&G<,1(R)AO?5JK[3N)Bd5^#+(=bKQ(NOcD-aXLbea1Y.ASH<#&(4E]/H^IZ
K^Ag9[3f\HfL.0b1c6/aUQ,1c&82&U?W<gbZ1LS4-f<+VJ.2RC.L&V/>GRJ;[VWB
S_T[]9C9W)7POC_0d<f_Ge>.=dSYMT[YH5@=6]#&G5bEg\#I@4]<f8(NWKV9\a4B
c5EBSbBV#A3K>QZV,f5<78Y1OP>R6-#OITGdJ<5H8-UF\7ZeW;PM&+;.BBKFc[19
26H_I\LLJ72=FL3A_C/<g>O)UB:CXYS+d8V&[9=Y-[>8</)aQ5fBZ=cG#P,PMUE6
fGPNdRWCZ,IR1g)5KRAOfU[U+bd2D88OK(M7M#+KG/?BcM(E12/SRETE:R3]6N0+
:HDU^Q;Tg1AI6F9.f6>#[0/&OGcJ\(_#6b]BZDLaGGA,+b551^&6T-QcB>.(KAU.
\O:?^>bb]DbNK[1;^?H)Q93ZICaI7RW9:,bcZbN8dD_[M)S2U8bC&)]]+NR\XWP=
V4g,XPaNUVV2FTZ2^&\&=7(\H6J+-bD[f9ae/?;I5H#Ha#GK0fWSg_&Q-LMPY5NT
f-]?^Ce:Y(2bHJb]SWN2RYbBZH1(7V9BJ/BBG/AKEM[ZY<?Z,Xb@f(CP7-5S?5/R
<B:X[J]>A2W\Ig8U]BYg?gT&VUL0X[N-HKE<+>#WHH3/GOEN:Xeag=H:F=;b0f=3
UMb#2H^^RV5F1]UO15/gPC57aX65MW-JI-;ZZV(J(dZ16N6KY/@2(,_)-DE<gZ&C
7Dg@<@VV_2M094@?Y3[K[A-SAS1&5#::&#OK/P[U4+H7((@PBVQNF3+g>.6;Y.(K
]bcDNXD(?JF2a@/dD2790-Za]eBb@c]^TLUZF>+L&<I?D;\0Sb:FfOX9/c\aF<+#
gP7HIY+LF2cO@6@>V6ZY5ec@16Pd/;;BG;>/3_)=?fM2[14HS6B1?=Y@;<EcV7D]
T57f/:?<=CR]:5N95CLc;HfGNWXNXXNHKF<P3E,1Z^;?91KFI3\-MW^81;AN4J<>
3(\T01?9fSgSdSgf/;=Q)]W&4QNcF_&Of6cP+IWFILR(M3fd:(YD^\K-#:RNCccR
#G+b-4JL,S16X2S1,)0d\L2SV+N0H#@8?;Z_FGX/65QZV@,HSD0[6fX@cDEbWccW
TE;K4&=&20M/ZS4f?:MUM5ZP].Z,Q;O?d2(/(.3J(Tg,7&>2/[2O]YK0)6?#\S_A
2;?+]?V@[]N#T&:7/:>V,LDPCN1)):@b8a1#:>c(21Zc7LTN;[?T=]+MeHXeF0gU
E4eM(cU()9#gd,73X=9&/P,R\GdISgb2+fHWK.dZ/(=cC:&G3YW(e?E4_bU-,gP>
@c6>+Ae(PO=NE_><g[(aB#cHQ;0+H0&e]00H6UaZ#JQH=GfYb.6fW<cSK01+;BLU
_fO[8EB@-^^b4/T^YR_JSYU(VU>g;7]C^f[(0Xg?<_--W6;YM_Z@ISg18]<]bW7S
9&(72#H2@A(8P&:gXNbcYHYb1@T5MXU#cgb6&d.(>F#M_C]U11MW>YMA+LPfSWK>
b#V3AF9H>>WS>;]M-Y8RL>[EQD>,dK(^&U:<HaX8LeT.G_Y.P1)B@^XGREPB9aK(
V/S;0.A#MN3CZ9X=NRENQ/DGDW9_U6[F-FcDJO3J/]DcFbaE.>#d].X[0>,6L-Rg
+d)>42IK1bGNG.UCgFf/??fc;9bEC.LUSVCg.+O/FZIX51IJO.(gDA_YQY<7?>_d
EWg#1TO+1^aQ+JJN=YDI1>;]9T8CTceJL,XBe4_610N83@PcQ:B.[,??GV3[39E)
e_<O#YLJb,3g+dYY5=PXZ/Cbc5-1Ec>08W.5/^4d7CKaVFK/O66/401fcFE=I\\L
QE)<NZY+J#ZNFE7YO=JQ9CG+DZ@1fYE1PMBLE/.@9O6?7&G\7.YfMV7.RZ00\H^[
.J(9RaYGPXfA7e9[5g-(/-28bfFH?\9g/V.Pf;g^+P^(SXb2N?WeH9JG7ZCH>?gZ
<^>#2[UHJOG/>UN#.ZV&NZ3fFK#b97;_eYXTAN?V:HYTT3T1]@D/R,&I5Zb;=gQZ
>f\OC@bUC4@3XPR?Feg?3CdE)UFTMMD2X5,)TG6[P>I8;=Q3QQFXB4XgL:D^S.Ue
M9\)C-RV23FP0HSOJJ?G^)eN\BP._HV=B=I#6PC2[_VDDWS\+gRUEe@I.1&cDQcD
:eDg-\c55VLbgT,1Z?fYI5ZJ#EJF^-[ZBgBU></-WLOAVIfH:c?GQJc&U44e9PAI
8+W^PI?+(?9+dUe43O2O&PGbS54M&W=GFXdf\M;29K)=?>BB4KB&E[2>SC?fYABb
NaLTRaVf[@7=866=D>7;SR>XM957Yd^N;8;8_@WUAQaB,S:4&5_HV=Y5bd#237eI
1L9^K62:ELL7?<dS1cbe3@4<0YP<+2@fQK.<GO,c79?C6,5<NbV3[eca(F&=TSB5
V&8_KGV0N\Yg6J:\K6N>5M?@A.:W-;44g/3NE=FFMM37aX26D+BNJdXQ[#V<2@;b
C\Q5[OIC+CcOaLWD_0](/dUJDLaeQSE2C5KD46N/M<(E]B\NCUdBcRAe^?V7=O;#
TN@>9>XTJM_WLV?_521#_I6JWcfOWca1:,;92B#044SPbQ#Z=^,LXY=&?eC4E2\0
[;HQ^:Ce1fZB+.a>1bD.@GOY-f7(MW91IJ</0c:GY@W1)W^;002[f)(H,9A&;3ZW
gB36[d5cRD=017?VgLfNS@X5^?_ATJKL#[(P+7_XC=EB4[Y#QLSa.L;[):=&T.WA
0H>f9GcM:bV9,Z)VI+B[(a-=+;+ZTZ3):,IgKReKcaG\(^EYSE@gSIO>g)8L1X]b
B&GJYY=6Mb@2[+SSY0.Ya;#UA.SRI2L3TZSB2eNbPI\c\70Y>B2^-]OM<D/[Nf\N
=Ob+HBeC:&Gd[Y_S<6OV-[c1SNI_b+b00=P-Ef.B=;3]&PU8^d?TeF(eHK.@S?#<
/K2<G;=?CFX_,UDY1>D9X@,SA-H>gBc8,eE;O-#WBE#/G[Jbb9agGJ0NI4=GaeTb
BVLg/daO69Z,+]DWUZDLL_I9(N?aSGN1WcJM5T3Y@;F>N3XCO2GQ(fDC-NH?/0MO
/CgW<=C3UE>WJYMS7@V1\U(H\R7)&[?S0f2<:CO4],/;E^\&@)RWO^N2]2XCM7C0
\CNX(@D#)/A#:OFa2S?15&CY^>65aN4S?H4TLCHf_KR&]U-dd3;6DR)JHTUU&0&B
^]e,IV,Y9:?dc32W(?DT]gXXG_fIS]T+I0-?<Q#[bD(b0ZQ8PL5g^-ZfgN;2;g.P
=PBLLLf)2U#O/_^-TUZK#H=&HM##@5]aNCX/G2;?M([d?+(\T.R_c8^ZZZJa59d2
.X+E:N(d(A0@X<68B,ICd?KFK\K2T&-+a(Aa]YW??UUT8ZIEb<E91RA3d.O3Z484
KYD[=+\dJIfWI6W3aA&.f1/J(aBadObL&QER7EB4V[_XIM64TJ60Lb8LF-c@7P+V
-Z9#,0ZCMQf61<O4GQf@A#HC#;E)L<dQ..>Q_^N/MSI4Ef;3e=?aRJ.XRZYF>/Z1
-:^]XSY_I;R^[a2F[X,C6W_Y.J[aQPZcMF)1-Y&&B;3&<.NQHD96/cP(NCS=bE75
K@2QU,>C,Q2R;:7E]?5U(g:_;I[A7+RD0SUTH/UWZ\WEZE^4,J<8^SFN98g=>G1R
FZH;+IaQ1KO^gL&^g]\/[(ORVC(85H>>Ja.XRE4H1ST]E.QG4YPd=,(L(4Y>G+-;Q$
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
+D:KM4&gdf#R=V,Q,b5e)e:C=[:^=(&28,EG<X+\9R((L+5G[\K;(FSF81-,8-R>
:/Se^_d0=7Fcd6\ac8OA4H(Gaf5g;-B78KYdgd8Xf)PV._6@VBf@eOU-T=GR&U?F
EQ:.//46g0MLI?.?(/>g#&MF4?#,d9B0W=9LE9.KZJGfAK^eNG&:K59SO^N>X^]Y
GbX@YVTb&P+SeW7F,,7EC8QA##0dYI7K4Xb.DU;(aG86b\_<bE6@70XG0H;\T?(_
WFVd(_K5X[0U&S<4=eY98)a?)KII#d-c:-LAB;1T7cZIE5UaS,TDf1Y8,4d?O]^A
f2FLTT5VO=F64TR;V<8HGWGP^e\CgW8>J)?Q;MP@QRcZ?EX8W2Z6T(IQR;S##/6+
g(MA<-Yf-_UaXdB1>E9?OLM1[.G=5cN[B+>4>8<IdN6UHPV/N,W^a7K/_JLS<DHe
U^42;1#dA[U_KU.IY1\_U>6Q_6SK/0>GA>U4;Wee:f6-OJXAb#+T0.9XHaKP5^=I
Q)IeWIB,d?@5ER.+<<e#XV5BUTP&BI\T?TM8E7+R.L8VB5<=?2g6H1<&QB+5Xa@b
A&P6?gL47?F-EQ7<IH3g^5,baJ4RG#/;4Qg4?B2Xgfe:C#6NCGH9#g5[OP6.CNXR
::/C=PBba((TDL/#eBLP\)ScAN+eG5+-:(N]A<]f#e@EdTNg?0J]?S<9F)IYU8a&
:EIC;U]4:A[S==I>-AYa.FTI.e7ZEPT@]6KX&Hc],^QVOOXP34T.DRAa&8#:J@L=
VM]/>#g3<Z=c[ZOAbT8.?7Ee57XgVee&AX/S4&U,]0/[\IQW)3(@QR[>7>,ecPNG
7cb:,Q3Z0JU1BYDL+G)ZDEQQJ.#FAC&_X:cZ@HLaD.8bdM<O41&>D9JYD0IAI().
6[;SH0(A7df^XcI=D:7_;<(.)0;2V7Q5Y(919G(Lb/A@-P8OT>2>f@(,,c4+7/=I
^&,eg+51=^FA9MM#><()])d39aQ8FQZM]1X?I6eeWMXS8XHXPVGUS^>0<c_>8WUM
+/3gSD^DHc(KdYOWBFWVL=TYQ3B+]7X#/B#44Z[6N[J1,-cC0Q.aCM1?Q6[g6c@Y
L<Y4;/KBJYeA2F&&UKFMM0?gf#YS(3MGCG7L_SCGE?XXLG>X/RE[>OdFF0:Z0C_N
\bDU_,FX6--T_f0_731>5f[<9PB<:7(6aXWB[@L:LVaXVZ.>F.^U))bdBf;35Vc\
)795&QeEXCY9.2LDFQd(U#Z/-CV>,(M+W42(V&V2dT6,(YC8TOS175]P;5;M4QY0
)_@S@0A0XKC3fb7KE56N[H[7,(IXg9Wf(TE]5O9#J:f<H^768&VSF0_e+08:FDGE
EgZMWMT>D+QVdH,WS=bQUIE79gM\Bf98@AFaR>+PQY+>:a@;RE<SD/^I+bGUBf2U
(b,JR4XP^b;XJ[[65bB^_CAMWf?37dcP4X+TGWg-fKQB93?JK;EAD#<M(LYc(X<-
ZF#I&C1/4LWKO_1:LZ3[V\U),1OE.W391W\V_+)4Gc9]E>B#gO>;Q6\-A5.@<K/c
3<>P3OZHP:OQ4eCX82=><.:__RI&b.bGY<XAHd#7].@FW[,W/MO[g4EaQ9&8N4<b
MVP;VW;eTe9E+9CZRNXf?JG2I>gPR\E1A]WFGU:1):2K6W5\X<Z(<ZJB\H\I8/F7
Y#_9D46,GLfH=T6H#B.KX)T[_N)ILa.,0<1<SbB]f-]gIMc<BXYWN/adW/]MZ],K
OgGL5(K#2\-[F/?\\L4Df;#[dBO=[I_D?K7I#9gg=M+Hf+ObBT_F\L?4OTVRNP6,
c9^B1B&Y[->EBN8S<30SZ_X(8?FSN^0eWVU<9CgYD\J/dNX;NbA=53.TMX^6(C,@
:.+MS,P,&Z,OXBI^#+/I<XT)HA,S@AT_]Y3>PHTbeBcZ.O@ffP/EV_^U>C6SI19O
BK=[ZGJ#1MEGOK&,7QBLTg3P7Na<_;;T;8]P0YS>=K(dK>2V>B]FG][dV)[aTee.
]EWVcP?6PA.)4QdD:^.,L3bH?+H5-Y]>.<Z&Bg5f+BFE2Eg9)1OcDOBgRY1^e-9P
Y6Qd(5b>&UXK\eFAEBb:;;=V/_BFaLNF;e7144W;H39W<H>[)a\>JQKAAO5[/S:,
^Q)-g0A\B>@_RVEgd;Z5;.8OLJ<QQD-\6O_@1<P;,Ea0<?<DLeS@9YFDQ&/XZ;96
)I?IA(O\OK^R0R0]&Lb,N2?e-d],Y\S4GFQd5)7+5ZEP^ED>:5Z]fUS7/]<;d_;J
gTfPg2YV-^d;&;,LL\)V4]E11dKI8YX;febVX_LW#5cc7;EP3UIcWPCGX;H-#.\R
G3Z#0J^N?7?NM\U/5Z>:?TWf.UG0bYEcQ.M2<aH&.8fXEdId#R^.R\N@)1XH:QB)
W?L8Lf-=>&&P7AWQFXfF^Sd1([;DP[_]MfW_R[>&-IDg^FQSNKYFd@>0Q96P4.f:
?5=L[G/WXL>@=KWPIV+b9YO:#E7I-XVI7P=g2<FMSfa;Y6=E;X6)<YbRdRJ4OJO9
@G/\(W7-Q@B,d_2(=g0+XZb7J6+g&/@JM3X\0F^B4B0A1S.W&d0HHa#TEZYc7FIU
VRT/11?Yd[QQHS>a=Ge1bcA_M0#7FEXVDPSW477(G9g2@I#Ra=#11eZ[a2Y8CIIO
CVJNO_(Y-.4<N3WgbQ7OZ(42Y\CC6HN3f-4(fZ=C;CTUaX=?D<T_2,/__&UL))T^
#K#G.JI@Z(fGC;4?\_IJcYARQ_PC6IZ75aV4M<701K_:W;3?UAYa,?<93P=YE@VF
GV0^c7YfXBg2&3625LK2XWS)f0Xfa&>90)+76;6@E^47+T+,V-LEDPcM[:THDaYN
UG5>?I9&SO^M7K6H0@5QMZA0X=5G8S69VG1.9e;J5;FF./SE6H=c,,9L]FE6.N3.
5R4J8R>F_\:RfEPK[4_A0B3OGWC]Nb;M#M:/=AS@HSAd+Id70BF^(2BFaf9[T-TH
;.7DS,ea)6\f()IS\72;2c5f)b+d1&BN=Z_\FN\5//KT3TS+@b.I5#J(VNg;22B]
O+>@?-^CKF3];9R>4,@g.(46,c3fQCa9;O\T(0;QC.WJ,]9ccdA&;QWAUeWRAcYJ
G#AB/^_WHZ5-Y<Q==6UW#a/U\fG,D>2)Y?;e-S)\JE5UG<b63Mb^_IJaNeQ-JAgN
/?^H\WIX9b,][PU[>KP.D;[>L[JY(Q.ae.dLW],KdG2MBYg]D)1SS1g[e^5OW&6[
4DNVgQdeTDL]=bPO5J24WWO13\^BB>K_#KVQO-QYLQ?1:\F9aB^8S-3?@bf/)3#-
1R1.e+#K;[f]\1KbMBd(A<KYMS1+_<T&)20G<\gH[H28Xd8I[,aQ>1Y7de.#O)>H
(&8YU,H&:+-EZZ)@&d&S5+C2gKD9C@U;:PT818YP>^2&Jc43\\FKNJY7L$
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
6TUA;(UKD?bV-0@a<1-.8P+7,4#V9X,^=9BW)IZ0.4R@2&[Ie;Q=8MeJ(T)G<K&J
0GH3KP\IVZY3a<b0I.9gKYK6WYe(K5gQd3I7S1A^>UWf_3H,6Wc)5B<Q5>ZM&7Y2
5(U9fTK:Y)NAK;bN+gbHJ:76;5UUIAdD8FTJIKf[2-BL+adEEEIdGD>:XdJ6:U=>
3g/Q^M_SW64I.V=V8MI65g<gN^#721G<gf:3_de-Y(A#f,f6:M7[a8V4+1gUaN04
ZBfE55IGe9?ZG_6.2#a/1DIP3<3Z^GfScC[SU>C^Q:MWgGF\W0/.(1,[]-9?[LLF
Q9+\X@DE5B:/+:[5R]aCTK5VED&8/C_D3>e>RXU3g]MN8]f1U?O+5/TF76?0+/Vd
.bf;^eN<K&>egUb1PU\^V9Od;LZ..#KK(1K#=fOB^,Ka/L8(+cC@F(<^?6K5;G;U
A+-R&EWJfFG)#_c]:FRQ>#BcL_QRKXG;NEOFVa]#G08^T#\A&RHJP?EX=HG^9Rf:
6^(?XND(0?[9DJcI3Bc?W2R7_;\Z^/8C7S.NEacgYQKK]010[E6C&99:T,1E?T;+
RdIS^.fXb\Y^?6XN2cL_PPMNI&@c7A<:;d@Fe0N]X^@-Jf69RNV;/0+53]#PbWD+
QcR/a#2N[fBFYD_5LT>^-8]4]68IU;9ZP02FZNIY3?OGD+F<KB[Jb1L#5C?50TRd
)bA0D:3+&?e4Y1HP8EOQY7WJ>[MOOBD^AIMc_4UJbdO+O:8&K&W^cL,F612G[1.#
]]#E/-(-f/^-JK?P@3VX76Mf(eRP>KW-0GQEH/W7BA#AKQILA&BC?1D+XYH;C6SL
)R]5VZ1JX]0[Aag?J2VDV/PH?]cZ^b/R[-1Y\.\-XRFLKNQBU4SK_0&]Y>NYC+a<
RO^=^1@17#5-^M(46Y8>VE,PJ9K)G#U1<OEP&VG2@VZ>0E=,H[0[:Ra4Ac[^AH[D
M?8Y,-b4_8H4dD4bd+?3Z2)K]<aOYeA,R@8I[5I>@4C;6g+Gg>&^Q.MVTGOV1.-<
DVa[TLO5</0N6W4bXCWEW#M)1V2A]E&RgL]O_c,261.[RLX#BX.)5F3.BfY]NS0J
VLJK0cfS=.OT@b1U7M,9HXN4AKc=:ES>\,If9;IDS_QR?D@2MIB4:gWf)1,:FD/b
(>49J:=NM^]^4S4d-O1)JF_(,cJf\9H)C0abgKg_&LO/^.?(QBdTgA>SH+.cg>>3
BY2D:;DKS(_bU<1@&XAB>Y7c11L^8V2ef.OfU(G3?OCRdN[NdWb-.4W]b[ERWS5a
#\.4Z7RFIL.CLRNA8T1e)IMg<]>8/QI;N8W&egG;)E;W5+MZKC;3BgHTWA:VHbdK
25Y&5DKO[O=T/FYY_8-ZX.3:FUDG_<GCHO@^NaXUS(59M9\1<COZbYR2=M#V9WX^
Wa#L5/P0ANMfcLgT]Af.-Q&/aB05d82?7,4(Ec_-P&V=>OWSN&=S8JK5IG^FKS-,
-D>N.+fSg3UJ412ZI=?G_ON@OAJ>&EU5CJTU<dHF1e7=S-#deQ_(S6-80fM?VSD2
VO3\-:(.Z3^QNXP-][IH6J>,e6TaD?c#V0@#/48&gGI?:@RSW_5FdQBTD47d<O@S
SAF.CJB8F+<F^P&Z7R7A7KR3M?-A@-faY8BA.^O+CA+;9]]Sd>_5ZB2A,b@AY#gE
Z=DZd#A6A,HVHdBUJT:LED5S&_S&A2F6C19XSYPH0__YFQ@_,?&33Xg;.\(>SIP6
IQY/ZK(-)Y)H4F?><08NB,EB\7fc7)P/:\d@APZYWd].+fGdB3.)7S6Sf4e4)5Dg
=7?VfQP@C9MbYTeEJb@aW9HJ>W<BZX?21aECMSb/C^5EbN\?K\;-:@D?BTSL/GUL
05P(1Sf<R><+<aBeJ4BCJ6e5.,0/-_@K]78QI7ED:4]R(G>E+?TFfeSO5YKf]dFB
7f>OK)=2T8I1?/6XV>f8/V8d8:US0^1TQO?4JRcc1PMB(=5.LQ1TG/SQ+PNF)8+d
VY0KK@Sc,5&;[\LSR7R3Xa3AaSNRB5FV1C4U,d@2Tfd)2;UM(TB>0aZPa.@4K-Od
CAafeM]OU]#@b<6A(\SREM-(QOEVI[>D,6(CD@Ea:bPd=c;I571F<RCKdcSHMYXg
G8/EQ;R6GPY-0)+DBBc6RegYfWDK.KHC2WdT.Z4>+\F^gSQ&<5b@X2Hc6PN6F4T2
4U[&EAHQZ-F/;<ZFa77>:7BXZd?XB>&2XBFPM6ZdFL4cM;IZL-2L]4(1gJ#A,1_L
ZNYKd?]WZSC;_G^5Oa96@]3Ob72ObBePQ/2DT6<>F6Z/EOM(0;_4J_,&FfF?MR8G
4fD.f^)IIgM+E_1eHQ0X.<<W20(HQY^[bW^16\>[OT-c>.8,.]]YJS)>@9XC>0FQ
g,/fY7fD7:X1-PK./LVH(_5S+.E3MTf[FHdf9RbbB19>dcgX&VI\F0Y8SKUEY>TJ
>-Y5FCIg3C<,VW8Y1<>b8][BV[.)/X030QK2?WI[-+d/7:/-\<CZL2:Y-ER3(M+#
U/Z^[#>64]]>@BDf>1fQBS;aS]PeHV[[1Yf8=Xg(=S9/C$
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
[8BOFVAgHLeX)Z@f,I?>=W)I<N[>9Y3.<X9A-4U/?7M/ga9Wdee#)V#M=HL/=Ia;
1-8@--B;B-,9bM:G4GX:K)+N_3=X8;CPA0QSUWXAEZLR5;>0A<WE0SGbV_-DX(5d
ZOSGKYK?.TLWTX428JV+,d-_/A(gWL#(RCH\YRN9@60T>39E6JD6+=YO0JEHWX/c
,Q^V?(2c>\g=PTN@24&Wb#+0U2,VTg5M),N3Tcb3X)03Ad0DcSX[:@/&dW^M(C3H
?#GWNfX=5LP^g_Bd^5^Q#2NO,+<)@CCa,H#^Jc\AUU^]#HOT=d\U\;O&3J\+Q7e[
MU(W]4d;;:^UcQ]Na_NJW(]T;21[,0Y.73@5^e/2YUC/IT6A9K)9R3AdFL.0JZ#U
fF+W.GHJbS,:1J=1@,18N5&-FQMbDWM6DDN+#<IC319[MI5=]K-AXJE4HLcKJcZ6
#/.+?b7?8OCbIFbS.S0:U/0>J?J46QQAZ-g-Z,7>(]G0W7W;:9=?F5C,([cB_OG7
H1ZJO@<U3?[MKf]VP(Y0R35R+KB6cfd?-S8SU#QJ3PCA0T#aRS6:,.4;5><)7=&N
3MBB^&bM6#_gJ/[WW<T650S.QO\J37-Z#V#SHI[5];9AWU?KfXd/2,7ESYeS[#-W
3;I<R1EK+J3Y&1(fIP11C[,B/K)I1+CV.f?V4_>GG-XMDge6I-1]PD;NeQ,.HH7A
-)E@J(1caQ<H?N=-JS3+51ad).gE2dN0R4^J&D?9ZL\L)::4,,bAaE)PgC2NdCY_
AADV\Hf/]-]N+)W+c=+2OEd[:5MTWeIJbC8^Md3Y4JRc-S_>LGaIC<#6#EK=HP3;
P4]@44R3R?Q>NX010Y)b5&8>Y2G2DE1X_+;/N,dfHH\0ea<THR3Ag+622AVGfZUW
IJA2ZB<REHD5K6EGHDY4=_#;aB<XWJ\E1CJ\OLg>AU+\)D-J3b9(D8\0L+)g.XOO
\7+Y0)>)NQZUPT_9K41Q9H?VGdVbK]0.3XP\d<1(9-4VRBb&aHd?+9R47T@LVMf7
e<)4T(1Re1(5U-)X?DaFEE<bJ;\VP#XB-,,Og7d_F0F7E4dKO#b[aSK)Of-)_OT3
EUF4#MUU;#X._QF8+FL5V27Y0JEZcI8;E,(I>_g]^.OGH#fUY2A-GA(@X66+8M=1
BW=IC=07V/P8\JZ>M#(gW_Rg^A:O(4Q=ULZcO/PK^_<4+3.</[eVGC[0\+C:R1,3
9e>FN.7U7:Iaf;Y&;:U[7USc6B/A:(7>SfP;>c2AB(NHDXDDQ)4<<;XaDLZTEQ.&
1TF_.>Y^>e/EGfKKQ+9TH9_a])WV4@FS57V<LSSA:J9Ze7Te#0d+Vb^U6GE,\8P1
\^EAaTG-=Z<KY/-T]^0T@+MK=:edXbP9#N4JU>;K<G/]53.+QO^0]SLc5:B0\/Q5
>:J].RV_P2AEINgZ<S::d=9a#Ad20[9@XdKR_@B]N\gPC_V4aKR,M9^[aJWY@\VH
]@aEN@7M<]S#a-+[50DTcVO#1L(BR2fO5cVf<?eOJ9G6Z=2\_UNVB4>fXCWH+M=V
II:H-X&7]2:,MC9WPYe:c&CHHR(gX0fKC7<;)c/#-_,d;5GFVg):L19\S[IG>c]T
@E?-]W\NcR0UN>63gJ1G(d21480e5.PTgc,F2^UQJ[K28^61^P54bB2_HGH[/XD7
F55)eTFK5&cc<B0VBfECR58=65D>G?ffHV,7@:&49ec4Z1U^@?YYa2dE]6[+_D:6
\f(^[&:5,S@e;2&]D]9<CG=FbF]@&_EMD>g4I2g/W4?N#34?\KYcWW@/W0_.K9J)
X8&F/J:b@VZ\TF]LA:PQL:T.=K9dW46WRWCS8J/&8-0cTJbf\6=Y?[=BO@VM0=49
cg4//_7eVB\#UOcE,HM-9#\a1<,?G>RaYR2XLb:gDUT(J(AFe8CbceZ1Q^O:<e&L
[#-=7V9Ed>Ff#RO<)5B[9+,[\GU=NL,X#8@U8S]=E17W)9Ve0d=()+FgV,HLLRS:
Q5+):SK/a3=S_-dE5<GSd9eM&LRXV.HT<L(4R,]FU)?1\JNWd]^QNeV5=#^\@1GB
N3P?V^7)D#)MIJH+-=Zd\]/V&\PW=R6c-bY=8(SQfa=SA^XD3@\T_\.5HN14N;L#
Q<(@#ScM]KD>:aI1X(PgDGIS?f_ETb\[.A3TUP:Pc.,:RNbSCD\ggG;J)Y-.E1T)
NOLFI?6PfT#1(;#7TI(O>gM24/;ZJAdDb_6N))35g^2C]QU7fK=c+8_;>(O@9F#5
Td5)G4.&J/)EcC28d_#2+:aDP/TfDS2Zb9a497[\7]dB[7?SB=.,7;66W\J8#T3F
/@5a64S98F?SBe7,OYc;\\FQ]V0ZID+8OHDKeY_O]4H/f.?=CXfAY#.\LV&Q:A[#
M_E,U+eZ/-<Me66MEf-@Q2B&aDb-Ade8\N_^_YOFB-TBFVEe:5a3VbY:_D0E@?EI
WDR,(6(D]bcAdDY:+EKd>PLdS/]#K<-]&P?SY[-<\Y-F/0D1BJ?JgZf^<c_YOD5V
A/E:WWN2H/])F.RB3<^\RgE/X+>#e>M_D,3dO8_:.XBO,;Q0VD2^CPGYV^9b-QfJ
CNbSNS@Ea-#4-80S1?AIaPR;(K0f^NN\-_52dI\SY339dgOU_&bZ/3W+XW=6M-IR
//[G;&N3W3NBgba_>KY@,YH_Te#P=TJLBXN(4)@+aV].UI+O@VDDfSAO^Z]8@LO)
KP/RgC=VDe:C1@g3WPWMQP1TVYWR;NLS?2F?C\eG#)b6d&O#de^0EPPB+F=4#cC>
-OO;W@4AI__CEaM;YI\^LB[dV5KSa8#TJMUG)f.N@S(1^PCfO^[L\K>KNI8Q;<-\
,.NTI19,5>??.AN4L(d;89U-dQb(fO>X;PT,b952YH5:&]QfB-<&QC-[25).2.@T
@<F1V:.Ye@+YOV>VX2#c\\@#Dg&f@QF#S1.dCJ(ES]Y9-\.)IY:-=d(b3?792^B=
3HSX[d(,^)J,Ccf(@3ONFV[g?[.D0U#0_&9^,aP3.?+Z_:8gbZOcY[9/AB-3IHRO
S&Z.;B&&8E9&RdX]KCe2\]<:Q/f&50M3AD:gaVfYcN=-?6L+N7aH(a=R;Qb;DcAc
VgIRUYFHGCV5IW-QR.6dTeDIOa8FXC&e>3M5GY6XNVeRDe89&bcacZ^+]<N&-GT8
;1aHAB.Y2Z\XGIBQU=YN=dUF[MXI?dYK0Ae[fTYd;M[a<\UI5-DG6-4:JV<Rg>ad
2T&<9::P;Q.QdUY7]-2g8[/_)BgT:(P^K7)._DAKIXe:F3XS>/c;=W=)gd0#7EE^
U1Q&94:.8^b1.E;SdG=5GLOY/K<>W.A7SK6UPa3LJMPS6S/,Y\[T+VM/bUUMM\<f
B09f\RfTRSFCG@7MdF]NJO6fdO#CCWDH-D@_1@.Y/bG;Cd]Z1fOC2a[Q24+Hfe\T
S8>DRZC.CG&SfIYL2FYKA6YS_fD9bdgeZ0:54Y50@\BG1ZCY?(,MWZ,+1@Wf<4_c
FD(-;AdF.8+1@>VSF)[#g<H(0Z<.S^e@Q#7D@6;<5GXM#e?+[R2b]?1]b#&5Z\<O
BGPT<=E2QD:1RG-]2g^N\SHY9#B9cY<6^\NSE0F?b+VGYY,Y&5.D+]4,GIZNR)(4
0,D4a8WUKgg-Had1=aN@/#dRA#7S>M]_C-(-K=T2GLV&<e2VE]<_[g@9dNc]?TXB
)CB/G9RMIMZRL4?GFM:;<g?F?+LX;92c&^?g9A@O##1@+g1TXdY<H(F-4Z-MFfNE
L8DUL>K?+,VQ=fY9V,^WSMEAJWW>8)AMK/4H&M7D^O5@ZK]?e39QJ>3L5[^7.Z>9
>PVA?HA1.6<H?:I/TVXC6<EbA0g67+T/)L1S5O@YNVa&#d:dU:(,D6)c/,9gN1)^
DaIJC6>(bBPFQg8g;>@^3A4EWS;?gA:BGa73MTC\868K12I\KW4\\XB,H0O-;6XB
]K)GM4(^M=6fZ2YT/F2#bg5#@O-UCEFWB<fG]DBC=P3_AH5g7R_VV@SO0TJTGMTY
-AWW>_NIXK2?.H-I(H/^d=OTg]55c=S/+&cgO>L4;VBd#=cJ543EWS5[2X+P<XMf
1<D:/02YOcLMaRINO,VMeEBN>e>(8I-VfN6NTTQ;=);I_#A6a>c?+B1@_T_57\=3
[#7_Qgc\YKKW#>-JG/1PK6V_L:6=-a^JX7A=9fI=UOc3^/_\=dgAad#O:)AZefG[
74O0I.LEQ6+165FK+)&]F6F<,+^TAKJ^>a=]@T83).HGcAENf_5Cb#SAe:AB89E(
+-UV;8?8dF\YY4@F2VS.JG)O2(A)9\F^a4dIcA/VW;&7QGAab4.?WW&J1^TKI2V]
_X^?\]a++.S[GQBZF9=B(5P@(;)9@6(75e(3?,(ANG?8QY.dc8T,NJT<H9QbT)JO
eRTB4<5S+X&@2PR2+a1+B]O5#BW\bgJaF.PAJGa9(D8]OO2;3F)?X=882f7Z_VL7
]C2,&#9ILa>P:VCg<ET^+<fIc>4-4TPS(OE=38-b-YPH>fgW0dS;,&5W9fWB_Z;3
KX0V5_R8TO6YU]f1_V.51J;&/3]3PeA?:W)f<MDg\I:X@a4<V&@>H@/3D0NQ,25]
-)d[Ha?)BUP+XZIYY7\KJPTEK7eQTb:[)B8\W3]c\#2ec/J2a0\PI86YWgXdVT]5
(0,9Q0O?.P#3D/]5EbfgI>Z[g@7ELG-((&,0VgPR/_KC7A#R19a\9UDJ2RTYMT9C
W6J0/YLOEFPb<H-#eg&?aaf+.G8?JY6O0ad:1SVKXW6ARc2d&?@PHZS=7&^E7)&6
TFX0];gWGCI>?UI03g@WO^SK0.X,F/b-@@@><Bd:fFO/c,NQ=+@ZS\@=@(OfXL],
@M5e_=a@E8E[E]/=4Ea#Y)/4+PC_+/^FI&#CMY.@UDafHQ]:-I.5gcDbgTY&F?7Y
/4/J2dH9L/0?GAaf:UU)@bE_[b+Tb,d/eDN;A7#e=g9[@?5<6[BE-6(EWVSc_/FH
M\^#VZSUS6c15DLQ+?#DI6NSF&?>Me4RBPL72&-H,f,CY=OQA\eYBDII>]b-1;&a
IeAF,=+0Ke3.Q)d4C.4HR:6;1R#E7+K,e^YFI64:fWaS6N0ILU?e6?J6b3J0cb8O
0WH[eB&4)^,?QgF;6#fd.Vb_:DG4[56=d6Uf]FROKT>62<V2K\G@A91WD0:)WX>M
TG:0><[&1fa1=MH;;#?:d3a.<[-J&4GfIe<;NI]Ke,BIMTXL[F9^\+^_aDNBUW-N
92CSX\6<Da(.EP[GZ.7F)c5#6aHK+S@KD(JB=:KdB4eJfGaQAOVUJP=?9eK.(NPW
_,Q::LUcXA2cQ[Wd_<,O=UEX,G3GP-f<QEc6>^M-;7QTE3KJH:Ea=(L28I89aALB
/[TCb\.adE=VJS0,K:,@?KVd\RVIKG-0T[PWOH+#MQW_9,JMOb+R2Z/DfX(?Md4.
LQTf8OKE@I\(dKPPG1K=(J;(_>bE1CAcY69NRZYPCG<g5&L;EG=f2Ha\]]f;;?C1
:&b8BX\CbN_&OU?]DF6WO.P^P-E4WOI:a2_[]a-5#8S#a<S5A1&8,77EO:TIB\(A
=71(UA>aK]3UcN?AXfMN-EZa@[e;>]L9J.;H/EcMM8.B=g>fY82ffg7T^AC&TT[a
1CJ+#)>FU)8^CF@G;e;V_,b\UARF/-@,???/=LZ5XX[XYGLb][RE/NWg_-0MPMOb
VQ.FUEAWF<b.I=dMFY-IC:.3;)<X[DO>TQI,cU?WX^FOQ&8_3UA_IfSc56R0[bRE
-OBXcR=(dE.PfaRZAb,)>MaI?SFDRGL=G#8GU9a3#MX/0GIc_B&=9HScJ$
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
Ze9WS5P@4?cO,PCS9a=C-4Q_(\PM<:5+,\AI)Ra(;IcIA5<[HIb,9;CO<ObL8E8+
/O=3H))=C:EA&B#5>L.&N2bf?YNa.aWHO,e)ULc1))]fNRZ:?;(aXXg,.@A1&9,G
PXbVV]\F4g13_E:^B\Jf&:+1M]X1:Q/Fb[aH)<CL&ORJ3?Vb:dd>C_fc,:T_/XW2
XbEBdP7J8)d,SbM93B<DgFS<C+S_D.AC7LZ+b./[M&A:7?UIc8?gS6_&5M)ZX)RT
D8cZC<f7fKMN]eV-KRaM18DQeYMfVPI_;3R4/&H8S9U;Sc1DL+.[/YS+7^)Bf^Mg
9M\)YE.?\DeL]NZ-<H]5<9gFC6cX[9&,ON><GQTU5O5E.CYT<+-eIUZILZ->^13D
=f(1P5\GBV;&\(K5V1Y:;WV+6NcB.BOO70<9_]EUXXV\D+L_f>LJ0IF#M2J,/2fS
R^JHF,fX&NWXS0\7W+((^bgC?.27/EE]+e4-C&,LR8++>RFQMT+Q4Cf@+I<^DKY0
^f)R-0<;#e>8B)>bW&N.dT)4V3T8EV3FbG+/-EA58U[QENM7BYR],)-N@?Z0^9fg
&=:=1d^>/?H9ZV<bT/?:GB/+B2F-Rd<GQ6C<ECRfI8^J0[4<0e+?+;dR1NS)bF.B
730d]]a(?K,+b(DfJ8-=.fZSYA>P-T?X/.-MWYNacU)2Y:GQRP&3I9P6IZa:AEI&
2\O.gAMB#25?8W>ETN=.e1)2BFWN13A4FEfB630_E#T@&1?YER-[.HG?PALOKJ:;
ZKF+V7dG[\MUE?J[D7U0.;1?P.2[>AfdLO&QW@BeAXT5HaL98D[WcAL5=(MM6^J;
:;(NPD(AFg26>XBP9AVfPVd&C(J]c<@)4+C89=M[bgY-CUY2Sc:\Q<TD=#17McK2
Z_/eTf==;\VE4f^bK.PCB8J(RV3g=4d5^1,Z?/E[BbZa6]BfK/:L,0BAIc;aU]g5
VOIKJef.?g=:0>7FS^5()LY?2NcS><45G1VJg,;HPIcX??.M8AAdLgafUB+e\>CR
WFNP^-H-?_=S&+f#a)TQ7:@Wbd9@^]P8M:6@+=M>B0YK]Gb+>@N(6?E,JA>&&9C(
MWEEKVZN:BBbV#3/=2G_)E9^-NJT[U<J<YW+<Nb2C4J/&53T^5;9WMCWV,RJeA@+
C=51#/(<JDfKC9g61V.\CQFD4OG0gER1M#0F8#T+D\HOSBKV;-Rc,HW>Q(#YB,C1
>/,]^=G7OKRb/bRf[[dXeY+\ENBJ,P05GT4a/&GU?C=I(bbcc9X,6UU6VF,a=7OF
-_16]G:-..+.E.2LJJBJ#WAR_=B:OCX,J7B7fSL^UP?W<\7S)ZD\L+&OM1/774a/
5\WT>>B[e:&f1H1>23@g85Mf45KG65[]P:]MM0Bg4L[;NS5Y+L7?HTD/b1(MPe_4
^8[eg=?\#@&D)6Ed)OT\\@?@?Q=eSW6=c4LD<a?#6/QHAQKU[Ag7.PRHLb(?7)&Y
ORfUI=0?8/[e]J1DO0R(^(aG&HI9IZ,ePDIf/Y?H:7Ud(7WWMOK,#8/Q9;XOMP/S
V?(L)a=&bF21V82>QUJ6?KA<)Q1@.>(4(7fbH7f;>&WSLQQeI4#4cI1&TG8aR?aZ
aR)c45J?76)aS65Y/PRec3=FO]Y^#+]d=J^LL>+A:Q9Y>c;7&3^?VOVIfdE2K+_[
Z[;A(dX4NQ_cH]9]G7d7Z?=Wf=).,V3b:??f?&VY0Q(fM=g<0V=^XIHG859aT[>P
?a7:9-=6IKDd:/6<V:e7Y#9GL[Re#gba_LHCQD;9-E@>NY)YS1(@LK,3N]3(1WOM
2=_62UDa(Cd4OFDH+(G72UA3JZ_QY/Y?T?Q0WO?T_AeF^RX)-L9E=NO[6B[U&:5[
X3PAD2,gWFZ3^@2GM<A(Q2NFg/_X>0B6R_XDb5T7NGT?&f^DRF\->6gY9XIE5F.Y
De_9K#b.9&^8V;7EX=RS9=0LVd[#R&eDQ[>BDW1I@^ggWGQ@XbEVa0>&aLQW)II;
T;00fdDf2#;XP(L@f?feCOIa=2DR@Z=W]@ac_,&7:g+K;);^?dYC#0)YR#ZX9,]L
0fddXc?:C^_ZDc0974HPN5_FB\S)9O6&@2ST0TVN0@<8GHXe=Z.Q2>4[)T#c>S0E
(.]BP.-c;?@QdM-:0::1eTI)K.0I5H.\c<#a6S^A5FP+#;[,-J^,7FVd<d[.<7W&
\@Ec:(^9W<;6Cg=N>F\5[Z\La6E_F>bd)FF:DXDQP6TMQ8/8AfXgKVf18Z)8>(#X
B^97MC\H+D/60$
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
