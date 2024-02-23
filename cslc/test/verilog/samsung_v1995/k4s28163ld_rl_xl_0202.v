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
V25mKSQH5DT^<C`1?Mna:]Do1X@Q\dCPSTY[=6e0=onW0\@`YXg>?OjQ0KZYKAUL
20UQBPF[B;\kID=poLDcD<jQgmQYUJ1dE\lmHOKSgcHB9XDDS8d7V`]DPQ2lMQhZ
^Q1EPH;gf9dMYgBA;<hqj^h\]Wo<GN@K3QYYo_<?X[W`KBZP=G^A3H]b6;iI:^UT
>60JUDM`Rg54oCmBCgpQB0RO1qBELJnlpBkoC_ZjpI2h5ESE3BPj?PB2Ka4eaVE4
n@;>jFI;a=lnS>S4aXBL5K3b?CT;8l=<G2:dq^GgI<maYbDfiFY`5DkcHb7Em6FY
RY>A]`42ISQp7]Rdg@NLI539JK?ZW6O_57BZ5GB`jg;>EWpjaAgTfS]I>@HLYC?@
U:\a_>m\1m=Haj2gEYgO74gnNbq3nbX2j[8f]2Sd?@C<8DVkAi3XH`g7n9@Q[e2;
?ChjA]qS5D1DN_7P:10j>@=iXgQLFP5?A6N9cI8qejN=mKgn4^hHZim<8RYVIh:<
IoO0el`0[[F5ABZ0]RJP\=[QqlC9lj]040HZle41[3CUQ<XlcU@e0jjIglXp0a;X
jidiWSD7:LkYImPc7N9IR3RA`54pEA=4Cg;PQl\4JjHEJ7gaRI8UB^o<WKUWL^F_
R]a@c:\U1BX7XRYPMgJ\Zcq5g=k0e>pAkRGn[aif`UlUFg2a]MlnbXgFjE]VVlFg
EgNfQ34Q:=OZ^ac:<NeShRbm6gRO0IBn:ll=:IpmB^n;hTd39lCP=SBbJO6W[H1f
70c<gMG?h:eplX`4cT[QAZXOA6o6>JD3A^@38P6bb?Ch86<[J:O6YZmKp]iMgHmV
qE2I]ol:kWBF?mYYW7_6V>@fDb?`fp^7BlkI`hO6DDh]:<SOQK]0?M0RVBZSlaC<
8U5J=H`SHhV<^`AUWGdgCopMl<e=S9_bn8oGnJH0E4;nY^0TI7;E311>?qadM3oE
YpO5JCRfjpSDd4Kln?aoFWHcEi2e[DnR:Go089FF16M_ID2jN::^`2TcRc61\495
K]DJGMZL]PBD4B0ENidAOa[_fV=7mNhoeGWH7FB[4eQ=RQJ]b@bibN8]A4Q4pbYP
]iK9]o7HXL>c^N=Tfo5^GRaK>1BE2:iO<60AA9M]cf>Ug8]aq6E_[XlVL0MZRoP0
=GX2c2B[baETYfKlcQQHOEB<b;MC6_Qmjn_lk_OPJ:MAGpA<]U^o5kC]2?4nTLIV
llX4FJIf8glGK2Bj6Q\]a50R7Jaj29ilpNYiE3VHPmj;H?FELS13_`e\0K1WWU2Y
IDdI<63DVL>3GG?of?h>apNLL47Sln0:Ff5d:ICSjGf=SQ^KG\3`[la9f>:MV3mU
5c:PieaS:XKjW`BUP@HcTIqMDcM:PFTfim4@\Fa]4HW16A78>HL7]^1=P<kD<L3`
NBORiYDKf1Ne2@[o;:qd>bfFT9Lc:?93^KWT\R`dmcYZ?=^bm<GRjCh]c:mo@a:=
6a4Q8OMN=6_5VPm1@816=cQ`HlO2\R;i\kD3QqZeNCE]2QiB2Eiol`alW64f[_Pa
l>mTYFUIETPlV09_iQ@^;\bBLmjAoMO<7Q46;pfUDYHATZ046]ZZLkU2PjF9B]N8
aeP[U>4h8<5NPPcYl4b\cc^J1d8Y\baTk1^;Xj<Y6]_?Vh]\gj@^L@ZOnLKgRSB<
gYVL;d:QS5:1jkJDQhmBkpC=_S@H0Ka8IANjJ@1a`^Od<4Z`<YFATaL=eDPZEP^?
nQF6PE09]EPcd:j=ROCCQZpkbW:J@:b2=E3LK\`0lWi;><p0J[@6]c[YX?cPPUZP
QBSW2lZWc9A4:4<f3pDXj;aU7hgIZn?ObQC9=e5iajRV4OmJdiI@^[FadLWJ:_jE
B\H_]JefR9=5HG8jiD_l8A\>jR6mCj6iV0NIG^PnecaJV2jahF:CFBZ`qod4K1?4
NO>@RolSN93[;fb<SWid:kGQjJMdI25[^`Z]Q61Q4Lo013kQnZIU>]aAST6^f_0J
L_Vqoelfc5lBE5QmKadpQU9Jc_=<5NAG67RR4m=_?nAhjg^iYlJYYI4Q>CpJbRBE
PC@D?Z55bLWIMG]@H886?n40@2lH>Cno1<p`>XYM_[^M:Dd_7>JX;G55cpKOeR3@
M<DJ1U_`O5]88c=JAFQP:6jY6pHVOL@_2UZZPR:^;MK@fgjg?p1W3e9=m2Pn8;O7
3T1IhLQF3;BB5_qkT?MJ[4Jff1TI4o\470Qok=T?F02WFJT86qdRdNcQb3R1Z<d>
7a_WpPJoi=m[goTPE0OMjngiq^nLXA4DG>E:WQFQgFLKW8`hbKVD]n3PmS2AqEnh
=j9]PZ<\2VD=dn3[Kh8h80Gd?Fe9GAO_^NKji`iQK_0n`kfjiJX^3LJd3B@<9a?T
PEG_O_fXDhbq_BYBU1NG=dk<nb008T>SWDn4kJp^3dY>n2jdJSYLF9X6KXU31doC
cM2Y7h5XbEQUTnlRAk@[ZTBJ;LgfMb6X_RE1<SE^fn30<$
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
_Q`NdSQ:5DT^<22haRE=?lhh>UlQR`Fgq6a@W04>O2j92fFe7ne4M7OJ;<J[]Nmj
@LjCH\LiQ4PWdXoYlHAHBBNWX@IJZho28]@q@HV5LHG3:MM_4MN9YM^<6YZ\j;Q=
NWK@=Gp7g0M91qd;T0V^=IB=dT@fl5g<jIe<TpbKQFJhG6c^oMG<>d@Y=b?3^C@<
<ko[7XU[H5[oPm8Cl@0?9q9jL57c>MNBcD6GFJJZQkoIl;:\M?iEZGK;W1bgpYCn
FcXq2[8:NSG8?@S8BWCCa4cN=W;XMH;qL`;7TZGeE11EA1oAUnqL;^YJYMKeMZUC
_<q7Z11a4FgQ]8N]K>eE\^DEl^ZXN0\PKL^o\8gfhq=04jVA[iOWA2mf3LV;2dGV
0IOMULiW^>OnF<_e>9H^<Vjdjg1XUcZd??0SgI;18q8T_j6HMq[D^2WcmLo0GRf[
]hl]L;OL]2@]6>Co[NbH^RnBl@LK9@A6e;8Yk[8o=XP`PdVk0q00O`P5qHd5RJ9m
lQeBGhMFRTXF[?b9j_3?8G9Qp5m_ChCEo@l63WjT96knEFG<FD\^F]QeM16CDlMD
pi_?_Rh]32;RQ;ACBFYq?jX8dM^[6DcQ>WHaC2]2;EY\cNJEf[cGp[46d2nq]LQ[
_c[JZ6Fh8]UiVKJ]@ECPqDdT=REk7<f;a:eIFdDbKKA6^b?M]OJG1nI^:CkLAA<J
`A_?XmO2PA1p?Fi6dFT_V[<B]fHLRNb[hSHK<2h7KCZ6ZL^qCW1NKVq;gO3HToQn
G_`>W@@]?UhJQ;dim;1ag:fQQ>hKM_RNB;:Vc[3lEAL;?2LF:4iI8Ogp[1c1M]Lp
5UYk8e:7dDPfG`<I`8WgKP[[VI^>2c]]gXIb^KFol;:6PQfPFiR^=oq?Kl?j`FXh
Sikg>AgN`FSY5qaQAhOCA>l1N9^h6oe_\LL?Yq913KHWmSDSO;24P=ZGN?1<\qc6
P?b;KE:=A]\Q=G6_YHW0SqSEER7ei8oOmE]oK3am>=>BqY3S5;bWe6f8<5O9h4P<
`Uli[bXp[Um^SN\TQGRcf5D^SQF@VWpP[GVRSO8fQQhI:Q=chZgbCpDd\fV5MncG
g9Z;`29IDW^Rd9C4>p:8hl:4U[\`V5_6LFG;Ai;QET\k?p5W`jdE=TA<H5iMDbQL
44o><<a:P6po]MYhlU^`67XgJhi8llUVbROJ:\Dp28_6\f2acV>[\lZn;[B?;`Jd
mAXp=;Li4QlN]Hb[8Kf>G[OH[2@Y`>ZKU59p@8b\^[ojYNVkMLm1FbTIb;1e0Y7H
dP:2q2VfDh^M\IcO7=V55]kj4jJ0C[O;7ke0Rf4n\IT<d]li_WaHoD=p:F5koOn1
Niio=_V=@J7RiYh:ao;6qKJlPLS>HG]8m3l^\T7BCoeRJ:VWIF5MYkYD=3?TQT4J
\6NXO8OV@[R3WIipW`AgEC15Sk[Q6E1hc8Y^Q8WcXcX^AWURK1qKh3fCWeDbd3Io
VSCHKM=Bh:RA6EG;H>QqM1gT4^qnb=EeGpCJAfZ>p3L]IX[q7BFnQ]fh\4n8U0:`
a[=ZU[:?;DFjR<6pggSA8<U4_;@E99;^H2CiIZh=670D`BSq5T5=_JHg4I][^]Zm
S0ol^6=k:2fegbN?hhRXWQE`kFC<LNJWpl1gU=GdMUdAmV6<<hh@6OhJ^CMXI5Dq
A<=kfoT3^bU5KEOR2jcojVLR1g;0b2q7jYoPLW^FP0^gj\0YaFq82A[XMpUHI1hJ
pf?U9KQqn61;;=p_3ER@S?9F9?fil`mB3?;4[lkqhaoJc33XcmI;N;k>gCI@c@W;
\gofG<:pT9gA_iPi>9OciOkfIo0KePj>oA>lXN4qX^HKjCSeQjGEo`\T9UkUEAMo
lj1KkXp7akjhI6ZE91SiKX:8I\QU6?@hW52j6q<4F:4l_6J=A>?H_?X[V6F8G7Lj
o54aTM^do7JlSi5:ZoU;<e;5;c@eiE7cB1]hQkqJ\]iUFEHpDflMPQmpnGef4?p1
[46B9[poO5ODb4>B=ZJFTe5G8Od6o7U=SLfa=0qC]eR77==ToG1790=KCL9aU5h9
UcPNJIqI>@4G5W7Mo<8n0eT1deXXa=RNgA=c7pb[`;hfEd[o?lGeIOfdJKTYAVAX
J]U2p6L6NA7lp4f4X\JCK<PF<efZ06[^\?E;DFb<Teg]_G^3Y?=EEAU;>DXl_\fE
0O:BJD^?q\4FN46pQ6S_B92qg=PjC2Z2:KMYYg1hjB>e[mgHq\996VfMJ<?n[h_A
i_JL]h5@M@@KPV>p\1GNR2[W6gd1SP\O3F9o1ObGCDN:`LPQB^qWI^ee]C:FUQTC
k[BS=P]Ao9`NQ93F0EQq2279QFcIYo<0_SP<S9\LN3;O=:?\HKffboGgG@mq_XaR
EcK[ld0<5A;lGH<XG2fVXgAX@`d<=\\UJabIq6F6bZ`c>XL3iR`^5ZNUY9lHkW0e
jZhN8>h`3q=5^<Y01f\F6?_0F0f=SB1;8ZB3knc_]M6BWDVWiacOYHQDWLMbKq91
:]>j=WIO7V6fJPa<::2P\ih5Aa43HBPca<q^o>AlRJoIf2Q_:SnRFSVn1dX\2hEj
HjEIkIOqeTP5:e2DDX5fMn=5p?THC@hRld8cNg1Lbi8?FmP[oFGDmmm1Ta6HqPiX
j3k\48ZS]0hfZ]EjdYe]KCadDi6aoeE7pW_W5h@Zp;GKlYQ@2gXPRY1gk>lqFYP^
Z^Ekk]agIoTiN7\Q<B5WIERF9Xq:UIb4Q?^QO8VoT6MFglnjYMd?TNcSaApjOf^e
16a2giGB]@ElOM;\2?9b50PjfP:Znq:khH>U@9V3IO=DW=_I5^n>;7A1V2iM?qDU
bb`dAqOZUj63BDIh2Clgq4TZHRe_MC\M^O>O3`5@THj2[mSW[k:QdGbmpG_n6KWn
mP[C_;0e;Gc4l>QQ0Rmdn^C_Y;DND2[I>_UKjmf;YMN^MBOGYGTf;YSDCMmpXE1=
6lRj:7096DX?H>bOjH=a7ijWIKCM?L[?p@4ZiokDlWj6D>j`]`5cm4:Jk6ja^J]i
:qHdU\RJ^pL28XX6JE74F3J:\kIJX;MZo4?_eeRMUB6=`pM=cdcX=q_<DMfblkF`
?Dl]7FNQLgi4OgB]Zk1H:3SoAoelLV^b?KmYnBI`?oMU^MY6m:HJ\^L<U37bfan]
?Ll^TKe5JZlIWepfBh^4i1R;I]NFbbmL\fNEX85SoL:W=__`i4egnU@pSNJi27f1
Y]HUNPBXgbUVFipl;^LF7?Kig?ZX:4PGVJW<87`[Ka=qV^GMLUbAdBFamj=04bqn
WcY=6Zh9[>CQFA_Vc]inN]Zn1Bj]41]?C0408no8V?Fa@O;Od=IG568>8MA:CMBd
kUpk_mWJh?cAIGP]f6IP[f;lGCH_dOoCOOZ=\^p]1SfVE4lJf>S\]bA6<G_EF[Wb
I3lfS9AL3?L;lU6PRlUK^c[V\PXAcSD2k[QnMiALhWEndpTBOidLHp6QHCQ\L3e:
?il4goBnRW0FYZS6>X77C>BUfd0>nLpZaf5^l5pG5NZ4\W;73>_nAO4BJMTbRR?4
FC_GW>k<9CCOMW>=N?KH><ooj[YRHXS2hi\M`pgEh\6kap=Vh:B>Wm?E;Eel?TGY
TV\?4@hR=o73L>TlWFMBSZ<PgMPf9R:e6QOedD??2bfl[`AAoDEEVBIdHE3<C4JR
5RjI:<9F_YigHY09q9M]jhaRp87o1R8?MMjF4n^b=SHBa0ii7k`V7=9iQPLiP008
XoOCp]3iAjC65?@RIY^DmhjKfqD@mU=Cn>N@`V5GO]1D?g:3c>QHPgWVIG=@HICG
D;lCXOLh]FT9`a95K7BDm;B7leU9k2g_<iMZ:QGTmZp3N9R:KWqVj4c`gSWS;=qg
l:ZkA=pD2?L3;<:529X^\Ao9h^N7\`VVh9SKAAi<KHhKe<qViM3_BR>J7NkOiMVg
MN4BQgBKmZcl:^$
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
[d>0QSQH5DT^<`L:c\jg?_9jLOH\1=A?dVLiEC\^TS4l]IqIlV0]B2kAcV_e=@h<
Q52k9gRWA7B5l@2FBl:KIHV2hcdhJbEQ<l1pL>moiN_emJ09MQJ:b;7TdEb>bTql
bX<nOq3ZVaRSb\3U5>a8gi7?2N6eHV5`FBb>SERYDfj3gB;M9CO8[MY=36I_EICC
p=JFg]e:ae@@XL6kg[XBf9LAM0lZn8@8BhM6V@J=ZKG6mko8YkX[HTT=9==<4UoW
OY>AGZ`obok4q24^>kl:BF@WK>=f0SDl>c1qg1B\5Qb^`d1VA`Rk<Fld`]8H\oZn
X1jkkAjjJP[b<@nZ2JV0F774<M@qO@<3HRE0\U8fmIFmiihaCiQf[;Ebk_NS=0BS
b8kb<bkY>2EZk@EP2MCi[dQWJ=J1lInAGHFe]<IJ[0e^5Cop=EO`d_6pR`h:oUPj
G4Cc871QXdFj=G_F]m[^pN2YYoHUUXMk7dk^1^XmTGMH6QQ7]HIS@ElpbCR;?\eB
1Y`A>l_]N@1P\Z[K<n5fnhaBMoBnj2I0S5Gi^gJ4pMj`k=@=q?GTc[\B42N^^2MB
DlOBhi=W\:YfGlJiB`D3@G8EQH9i2UflkNCLn:V7EqV5_dfKdTdBPfhG=;^22CjY
[6dJXK:cNZ^=iPRM]o]i4`RR^U?Z7o=l4V=fN=@9BaANH4^VJ@9jlaC_\lXRUIpo
RF8YXXp5\MDX[0UN]01EVoCjYT9CUQMkfh:SAhpboEhj5d`]Lb5cC^E:M0a@lYX[
m;0Ml6YFCdN?ZFS2iQA^E:FWk3>WOLgqW?o@@X5;1gFSm1B_;7fO?oBCo5iDKjYH
kE4W0\a=JoX54eJIHemZImC_RN8JUO2oG9XNQeXMJ\R9?RcJ9LnWpW<;R3h9qYhU
GXWd2]N4<m8K_cBjAoM0d1`dqNU6h1YHPo?`d4b`:DC8\P`Q<i\8T\j@phMVK?>p
JHPf5fc]0JRl]M^6me`L^`=^ik1^6n=?NB@_oa=4XO3F7`3P2cHFf7Tp5;Nf0=Xj
hLiVdKhFTSP5Y`UmJ5=WHTXa0VKBQOhb2h<@kZaT7hd;9dJP2lF0SZG?<W35aKW7
63kb:6aPNXHqIK2jBPSpX`bO;BJPX`^50na9eU^bJL;aDfI8EYY:?DZ]R7[L]7?o
ZV[ON?;CVV_2``c;6\MRfmpo2D]_];]a_[FWCI:Bl>4Dh38GSC2pf3`QB3Zp21GK
??W0>bcdn86okOS]g0J0m03gXFDcaIDafKcB;9H:1BOF72R5Rdb6?]i:pMPh5M1Y
6?fXI5Y]fT=e@d2V9F_2mI@Jf18OHHF>53bN8B<2TXWb2VdNZ9aie0[GP`[X8UVS
<Q6]`G1q7H17JZN`HA]L1f?OX5:Vn>:?MO3g;L7AlV^`\7KhZPaWj`h:]]R:GdcO
CD3cAS`O7NnCod<NAIC^0C^b35_o]JdSX0[eE4p7I`bgY5;01pEdDbkM]`N?9bRB
1FK@KkEMbQkCMh<mSnIaVRSoXC3Z8n41]HNfR93h_WX7Bog9dZ5R9p\YaH>f:K=Q
@5e9UjRYh:[U63o@;_BS8C8j@_d\<pX5ooYdHRPh@I@6UWKb\hi]A:SLiQdQm\oT
JaqG@4Y;>EqWE1eDc[qJ1j1QVnp7[M?JV6Plj_NcI\V_HFJ>CN[Zm7g6>[iqI<;8
e59q]E:nZb2GNBkh2?QcJ>WM9Vip?`MZULlk[__=>`WZ7?Z8jFGQd]RH]QafXE4;
In[l25<F]JC?I1f=N_f_ImqG5]giZ8BaQdP^g5m;T@^\o;<K;KZqW2oOX52b_dO5
mD9h<6co\`pnQ\^JgWc5oRmZWj6j^0^p5GSZb6X]\VkB;=9ckl3<M9;:6dVO:=MF
?mp>O`_C6BC80SC9]ofXQL1<N?bF<3\gMKR0HpHHml00bONFe@GXhZNdR[cIWk2D
QqBSm7_`YN^84GccaYIC_FGKH3jm\OUA:JP4gYbQWkM<`Vf3Yk14qNR9>YSXH7]0
3QS1CARZ8lYefYfb2WMoK;PpF]INhg;p0@iPUnOm9W\k9603@I5>p?hEPC>gZ57Y
S2aWQK5@D6>h@>3]bJ5\V<FdI65R>W\LQB0BEfQQd^RdQiho6KJ4G<<HMPecEUZK
>E7WZ^GLODPh>qC8`K=oOgH1TG@MTE_oFPV`_3LCpjMCUFa<qHOW05UonjH0G8eO
;pF87FiYmP>adA]ZI\Eo9jd?9[23bRdEUNh\gnK`WWA6Il_R@R8jOXRM>Yq1`QQ0
?5D8<0P>MH`9YmGW4SgDDDF1URoH_ZJ\F7AcK1Od`ZRl?oH:L:Q<h:dhg_T6AC?;
>m]<U:6M@giDCkkiZPdqkJkeGgg11Coc=0?VU6qdI@T:\[L0`Hi5^o9>2KQ@DJ18
KqgLN\?cKNSjOb9m3nMfOHHSBV<Ul:Il\;MF>nN;_E4^D:Q_?3f7^<CkoX56D=AH
h:g>02=e_9pGQC]9SJp>fR=YYMIeVJ8mSglGO2hA_H\f9[6WZjXK?FceQ6HH`LhH
=ClMT`2ZOB@3jfJFG3:Y1Bi[]=onJ9KD:1G59ZFBell9BgHFSfD>I2`DM8L5SpI1
\6LYd`8BOoGN_S4V:JmHO3\CqEfEjdckqGFc041lCb`9dQMo]:^;DX<B54QVNA6j
lFooWg6jInX=6?CE8<S?<70nYpe;=lV>Yf5G]3m`pd6W?]K5_>FmbDAPWee89o;F
0bbKR?c_9k7c?hAEXqaS`hHXWAQ@?RA=R0WO]B747GDC<?BH72obBGbPL4hf2cUU
mh4A8JW>4\7jhG?:cHa;6RCZW322\7T3YAWb3?d=a2@C1LolKQcJ0jREL?_5iACm
p^:VD=l<<@EXY]Mm7RC8\1EA]mbq0h:6[Lmq66HCiKa3F\3G[6eYB]6`]6GZi2<C
3lQp^hgJ:dZTX<CPhI;iQ\Y`UdnA8UCGhkFEM8X2XB^qQ;TR0ODn78FJClVYaccj
F:jeJX]iTS;T4MNZ3i]^kiI[PL^EhU`:NSiAQ?JZkf4_@XTRP4L08Xp[4lACJ=9:
Q_dgMS?<M<I1AEke7mApIZH`@X2=O;_neAhVHK;;e]I]F^j\G16m\^ZjkBRj\Eg<
VRcqn\YR<h?h3>3i1DVVAUSqkef4Xloo7Qi;`VP6odj2\Al4]mC6^P^R54Iq_ONA
Xm8lR8bQ4l9:If1:cOTg[?iPn=<T9Rffm[N?AHCmSHD^Rn3pX=8?B@7^q0BFV=n4
R:?H7L\d_SDhqBc_nk[_;h`[=IkS=c6oHYV3N;Sb[MaXd[AYHC=lH7JC7j<nJF8F
Fm8]2ef_JQ2T?LVFG?Hlp5Rba]N7PoB[Ia10LI81fVODA;Q2j@cI;64>[=L]9Snq
JB`]RIbUo887UifdOlBb9j]Q<[5Dn99_NgIKNo?B]>p_;Eh6>=U=CFPk1n7>l;gO
hAP_Fn?PT2]kC91cXMi`PAj0;DEf<iq9kLU8FFdH5hbKB7?cU?=]7>:KNeid9qSd
AjUL2AqMm8TjR]Qq;LYYoQOORBVc6_IEk;ABhXLQVF@MQAR6qbQOYZcogi?FCMB;
ZVMAOhWpjWK?07GpI?V>@H;LFdY;7=7D0Ba]7Z`Q[fl;<cYIME1M=XYSji324<Cf
;e>cZ^4TlXWpF5`56[49:`ibKl\FND>eUhPM2l44ej7Cd]_OFDB:ROJ@leYigSc5
nZ`Wj1:]JTCT[PR7^bfDOb1=Jl?UMIjgU<OcfWhgEij9VLKdH[j@c24YoGVkM@b]
Y2JXj=\8l1pbThdEiBqifh?A\1Ec7;aCg5f^GFb=1WH`UIm]1S]gUb_>Thf8L3hW
\a\\nAB2ol71_?;;`Gli5e3LSjpB`>Y[RQOm>1<aB<:Id6hV[Pe]8EUMN>je>3DR
1OKQHi^B3DFa895YBYYh>Kd`Y9m=WC7o70AXD;^3bhfh5qma918h5aD?hQdg8CCH
n`BO?Am]VVEMkJD`DhH?UkKBdUa?Q>U@mlk2qka7F5hLO1;ACPcg7H8O6@emdpo8
ADRaFpL3I@e[3_KOhQM8[7_9fg21oZ1OTDW4UO_dl:bXeQ[X^g_mpOS=6nY53FKi
3Eofk1Y=bL9\S;]SGQmWN86JFdXQaL=Z>V7M>b_Y=VmG\6<MRX^k_1CRJ`J@h3<N
:4DTd1OU=]0jd<7TJn2Wlak3=HN2EIDSdiHR>_1DBf\4Wc<OL=3[cK>HpiMfmcgQ
qP6<KdHPJ]N7@h;iRnUPXjLoR=hTSaB4bli?UYMLSKJpAGgPA3MXNg4eHRlg<OKG
FCf`=81GJNiGaBZ<_`MRU`LOLAg=WAiZ82kL=Wii[ibh`>g5Flbkm^q3mi`FQd`O
9HO^k[Nh<hO6_oX[9Mn5\93[c1HqPN>1g_0L]aB:X02LHE3k_i7Tb5HX2HVLq@YC
ekfhA=1?TYoPgfLQpb;fYTDHqed2I74?`g0m6lBCY2LDk^V2W1mo[X]aJD;VR5od
T8Ll_MWS:;6?NhVo>8J;9h@jjN1k0JB\RL=BSHDGRa?I1p@=;bM0UfK1DS9>Q5l1
:Tc@I?TglRYMX3:Q[A@65=Mj_5ejI35BjhAd?2LShqJWZW\L_19G7m@BQ\Z]g4a<
\3qK55g78Pqj0P1DV<[nHLi9he7?4>=SQ4RXH=]geBJ`7JObbDD>hSROKCG_@B62
A8`>H;91c:R6:U31ADHf6gF[PDkD3I?\L>YXP>nN1KBcVTAjI2TVdlU<KCaO73g2
1UJ4G4gq4IncWdIqTGLdEK4q`Ad5;=q1hJ6]kipK>78Bg7dhTfmTP[4UMP4>QY<M
:kWpeW@V8=`65lMGP:kkPQfIMNCFj<[=`]f=p31MkVYPd^[:l0m];lIGSk=GK9<?
ooeJa1dAddRjEb5EkFJ9@@HXpT3EjXR@pc04FG1I^\[:<9fW6j0m<iB?Ag_k<1Qi
Td\5lS<[^IUg4Fc3P[Yf^0eg@amqLUn8ajY@fed]hFFgpbMGQT;YqEfT<?F1h3RT
bNm_1W;I`VVc^[dGQ<kemA_iPEnkoRMW1^b2Xdk]9G5:m77DnA7:VLn<qA^37S;5
Sd@`bkNQUJ5ENS?LfH<N^p`@[;oSc@_dfF=UnKPgEqj7JgF4_eX`O4cNK=B:Uce^
PIbl0=N`7TfRSq@m=_ce76g\Lc\4fP`iI?1eAKXQVD:081GHEQlOXFMM?04fk<L7
3qRB4n1Oo8pRKj_0d@_IQdA5Se_aDlqPGdHI_AG0mS6H>SGIUeeaBTOGDf]F<Oj0
[<9E1oG2AQ=qLf]KF_QXUU46l<S0I3><@70<]H>kIKdSXdNXOk0QM[pFQe:kR7A:
L\TnS04o8jb3SQfh?:iLL>DMVZRdf3mXipHmGUM?VW4n@Nk`6B=FfR\Zk;81Z]^6
`Df6eZ3I@QeT46UXH]YOEqRM=4J[oJq`:gif90Wq>J9TZmL^_\\R3P6p`P[_QJKA
i:61=7a=1[SGogPIUeESXn`CbYW8Ki4Plj76]>pO0<[l89kpLPFWZ3X3jKCjCB@X
aJbgJh1hEFi892RH8JNC_i7KcO6CWU=k]hi=9TRmYWX7eHgEdf;Y:BqD22]kj^Wl
<7Z2nZOBmoUe2pUh5a7mepdQ9mV0Z:gFX\A\9@qYP11LVSdWVkQfI:UW3pTKP@cE
3qZDW]Cm2?2e>bWXJ6P?q1Dg<aTG8=PRgKHoil5JH`5>^_8kj=i0[[U:ima]l5`o
qg>`ROf83Io=n@AMZE7Ae5bIkq<iL:T2TqPSMK@eQ;NC2V?;^]qoJLa\>fpnYeeV
XBkB3U4X@3`QeX;o3nG_:6;mk]2JmqXMHGO4j\N:jfd<9QZo3pZ6EanY98^<65A6
eiFKPdDbcolP_UogH8pD^h6B9:qJ;f<=ejDDbYlWlSD3I6mp<LAgM>@jPK:QA1I`
XmQp[MPR>me\fMR[QQ9j328M9Lh:KWpmLjTSBgq;h2@=]Cq@MXPPB2OOcO:JhoIc
H]I?O;;Gm\U9Z?jd[oS`GBfXIWKcTj5nTcac@d[leRRkS7SJEan>HG4Q]L1AAPL_
I4fjh7bjiAZ1Z?VOb6JDifeCo;q3bg8:A<p_?an7XpB9:C<R5]kBmqIHnjGB_L76
F24\?[BAYl[`T6BMAMD<C7<A<LS79UG38p:f@d9in7OODB9=[F>Sg4c;]ee:S2;H
VF<ojoZ6V@8CZ5R[66GV>M_CaNl4E08QW80N59^@YZX<A`>[X_nSj9kKR3Td`hX`
`ALImJ9d_88AhZEe>p893VV6kq5:PFo5YpKDI>D1W<VoQ27aCS\U<T?RC_OXqHgI
OJ<hnSQ:7?F2\;TV\:iD0Vgd585q\I5QmhZp^gfOD:Gq;DQdk[\LmRGhOH<\G=LF
fUQSAAS;4m0BpQ]bKeJ1W@3D2n?H<NMmlhkJ>I\oX]l=9hW7mENYDf_H5ni:`iBa
Y3OAbqX_O=CJO459`XMG;_qgN4e2VnqWa5]a[1V;T4WFk\57l8[3NJY<:j\G?BVg
7qW5Kg^HSgff]D4cF<gTd3jI8m\WW8?]G:ND0Q67R]1E5KkX^@miUU\=SIV@Eh`d
ic8N@0hB[fp>=Ci58Ana5f;i>Y33D@qR5i\FbXYCjEkA^n9LJJ?>eATgX=:`>\Tq
<f0B^OhpH4ne<<UCS]^<\R`:WRJqdRNQHK3GABbPk0@inNPk1N?F;6p6YXMJgHpk
l_jJTIVJQQ`ob4Pp3EDN7`@p\^P@CCB4dn3]<TgZQ7hR2g4Z?nh[6e@Bl^K=:P2b
c24^7kNilADZ]Fj[@5L2FIT^;QG]_[mQALOa]]^M?PK]0D;2^4fJj]@BnNVeLZd[
;YVqfGcodgKpil[4YQdfHMSlhN_Hq3c:U];0q1;oc<J1dFTWlm2[@5mCin2gBBAn
=Zdbf[mq8JYUcHAnP<COTUE5Bj7n3`MaK\6i<^TgAh;VZKT_dOX=E\C>T2IKYF49
aKSUe^0MogjJ=SpY9^<X91qFKUTUKO[Y]?H@Lb7BanlH@lOD1cgG>VR;Hj]kL?3;
XKp3Go>lg7AeHWI^XT=HQoXQcEkQhTT:lE\mOCGqcWZa`Gd^<YWUBM5h6GoE?IK[
_<KcVRVZ?hf3?;:EpWd<eXhJm5SMP6=\R<k]\K0TYDMn_glZCia435L>J7=E]i7L
68i=d4\VFY;>1=7lOWXFMIR?8QneG:EbS^85ISi6eC<SILhX]Q<D3@@gISRDb=09
?ABqk4?n4D60l;;fWApf5<D`:;qiBgHYS=G]kn<LGJF6aq:_egnO[p34Y_CAal_Y
ahmMHePW9o;JA9BRNM]RndGPqIN^kKHDVanCR5ddH`QO?dShCh5NJ67WQ7jZ17[1
SC_c_YLj5=[>YY4h_4IAEXnaN]9;OPPk@W[h:J2AB7Ni\UR[51m5Ib7VaIYXQ@:0
b9bqD1P:JYI;lO7VaZOL4eRD^7ha1nM3TGC`q18h\91[AM>7P:bO<]PTqcD8aZgL
N@LO<1[=c73;Oci4Xc^KC8RhTNIGP>2cXK9E30^SS:^^^[4<JK8o1Te\C:bXY_K`
a>9cZb>;J1>F8P[om:=LF2^XIFinQ]hSfInoV1Tg=HEl3lA:K\`K>W[Wg1]fq4TH
[?E`$
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
MSgjmSQd5DT^<g5HG[Lh2kB4l6NnSUlG1]?90h:WUAc5L6hCTlQNjj:EjYpceY2^
bD371FTR1NU3g\199ME_lZg>Gl_Q^R81=2OC3V]>Gi7XGfp@FBlf3EkTg?:]=_8g
_0a<h;;7k\fb[U]jM>S;DYbB;\gXL=hbULWpT3f6DHpV^l<jB6>GFAmOHQ6id7NG
B[bM4Od9YQkWdj\ZD]9`jM1qk]d3[UHqW_nOj6cWgG4TIk[852A6OVKXnDoS[hIY
eWGdqD50Pee=pJO57;Te@\X1;CNhKQL;R3POUR`jGF`ph4118iGARRW@^Ba?<7\F
=Y80?ZVg_BnNd\ndc<cL@_3kfi13ARN8IIQiF5S`Kg\[6B9GgQTOmCAfDdTBqSkL
nZ:lCB;]m_]m=1=MijCEGl:M@CHe@N=diR?`2R[63pQXMf;`dR30<]OjCS`W0cCd
:5ki4:iP:qU\0o3kBV1Z>i<Oa844_L?I5<1JGHT764_fWZ43GCpNI7d`a`p0JGCN
a7q8l:00?RO4Y?aPF_cR50Q0j_<H9Lgk>FMq[k1KFEJAS[Adg=OhacGPpIo^:[JL
n5^]OB9i\]kg9eEE;>;94[ZZGMjVQT;^dY3g<`9Mg@R2]eBqYnGJ2gB?;@eReh9G
dQ0hLN2LcQF4Zocp<LIF35YpnhJY1@2Dg8V=[7nhc>A8?5Qo>VNn2gC@o]m0@\e1
64\dXON8Na0]`6^FOck>q6HojknKh@0SnjiieW6PUBPKM]16@]lUEHR>\W>pTmb?
G:2pc>XHl;[RbUgU?CLA4Y<jXA^Z<6Cm0Wpg1hMCKY^nh8cL_519n^_bLcX5D[]2
06hUTQ:]7;2Pk6Qk_][EZ3?;aSQ@8QMo@X[PT0g7NX=j[nAHl?0pMOY2<_SLYED[
dL5On4[_:SF4gjaoqRSa8=CJfbTLihom86N3X5WJ<gJGm>e?DV0?`WoCB`b2T:lp
T84DYd??6CQ6kk:m\acNJlOV];@HRoP:peiGlP3UJVf=XQL?^QRnKl;4h@0kBgE^
bCLNWdbpMG@ZCKXqnWb`gX?;?7qUlNmV;W:8Y@MfXU?X2^2VK;YTR9WXQVab8j9f
Fle4`;9qT`]9o`@f[JHd\TFZNe[oaVm?]U4BZ8Fq>kGZD9>q\aBL;G4qlk5C:2H;
fgEQXY_;Z:Df:Db5?J2LCioE@F9l^8IHkTiGXHeDYm8D\ee\I<p=V0bkc1pMnZmd
C\jZg?]SB_Z>aanm>LUXh[PMP>9?`p7SX1^MN9?nKgc;MfUbfi43_0lXpkGT17QO
q2\:0W?OPNkIAE`F>SJ_BK?NdJ`aa?EmVFTlqSbhn01K40:_gY\l`[\b47eg`62U
]BMS@S`5]3BZgSFL0N[7GWNlR2acp@SDj4CYY?33b1ee?FNCAFHJ0:HUIF>fOgCh
]io]JUTkHQ2`SS7Bl1k5_NO81B5Y0Ml0FlaiOH3aY3fL[d`6pT<QZ5nfj_5F5Rih
GCPbegB:LelK<0m?1Y2l?IApjjcj4`8pE9kO@X?@=Eki>Kad]UK38hAB:8;G?diK
RnQlK?DjaEd2@D;A<M[3\4[U=5J_\iWWZfGqBA^6YQ6VN:[A`GJbjhim?1mMF2qK
5i6:^7f6?SF3YlOITG@ABf\n9Sm3F1SL:?haUK=lm91DmkF?S=Ogj0anHDWRf>]=
<pBSVTohCe7QHJiXoLM=b?ab11Qb=o0]LKI5gf1mo0n0poE3Jla0V5\[jhWBG[VV
47hnm2YTEUb7VTi_fiJ`M`^p[MTB2?p`B1gT[JCfb[YkYQeBJR11WVEUH2WHIOk;
1q`M>LcFfJ5@oa[0`X5RA=O]M9adVnVWBa2mdeoYH;AL\1q9>_\`JYpBmJ9UcZHb
DnD89ceWK2[mBF:J@bcB]8Alf8Cp1_LCfh_qVg[<\gg2>]5AJ_W^J48I<n>;oOe5
YEY>mb4]QKY;LbGlSh:<mSaE1hgoI3P4FO:HQj@dCIV^L2fDco`:eWMZWdLg8n]X
T=YBZPRMf>O1DhQ?p2]2nXWqnA8X^I>p>@Dc14`=?eEd=jUHqg:[g3NgOSA`Ejlq
:WV^c7S4lU;9XSNA>49A`IEEW\djHC@pcPaUGY@]j@cQ=R1W\dFk`?ma9k@qoA`?
_b;;NGJ>e;\^E=`hnM8@4dX`FMo8ReVXWDCR?831XbF:pM`jH9Zo:i2ccU8E`Q2_
6Q47^9^RBZ<2lq;MSUV`?qR9fQ9o1qCe:ki0MJM_;DELXlb\Ag8?XF7`70\]9__d
UU81Q_@ol_q\O5OMh>pB@>h=:^7ET;CJdehfJBQd^Q\a[nT_aZ`m:W5qHE>APc6q
@MMP:eeKLIAShANLPfR3GfXoE`G=JYS5p6>3V\PcIU1Y:;5Dn@\jRV0f7U6=g[d6
3`F:l5MM10i3oll;jmPLXNN7HWbX?GA8eaF1nOAeZlRL2bo>bqQ5V8Zb_EcG4;O@
8[8S0eUI0R]dDM^b<O55GQL:apm1@j?_hqWlFH;Pfo[CCHj<S\01M?0k:ip8ULjV
c:plg47kY;K:AlD6<U04da_RJega1S7C<I87_7T6gAp_nA5kDGpjNK2m8pFBLg?T
fG5:9S7khkKnV9`1>g4RR<RYJDpoT_Sc:K3MCjVi7G2VXdoleSEc1FLY`KFO9E[k
Cl`]D7Y9^W9n28ndiTTn73G_YdA1KLCWFE\L=:Go1gKpSQR4127p0GSe<2i<^fA_
ffCj6>e`_jWjSUqKM[[=2Yb]e;SG`AEfHkGnnO<f_nQkFP[B5=QKZQB^BhlOQCkp
><ULGRH;FOkYGh7WHDjmb>1_D]2U8I1XI_6L65eQ50Abb?\d50h>lXQ=C^nqKIj\
K291pNX_ac9P;=l2fPN^MTfN]Kgc^a;h5QnQ@0Yq_S^SR9i9qGXI4mGM]]7DHWAg
`Lcdl>MhoA>qdR_Bkg5p]>YVU5P6c65Uj3`@n4_6X?^I8Nbkm7oNiohqOkV3c]eL
@53iPolB9MM63Gi1:WNU8;U5<Y4<F521=bg31FgUY@SkbnB?QAbl8J2GX2<pZNA@
BP2q>CO\Al_6@Z1dcDm:pJUOUF9O$
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
lGZJ]SQ:5DT^<8GMgY`[1mjLiSk9LPm30V2hA6O?Ro@I73\OG18[Q4m@BZm@_:6C
WfNE73epb4jId5dE;SMd1G:S:4SGNQ^PO5_ZZAVK9[Ml670RLomH7HpW`\geg0]m
35i_X4RpPJbALmq[Vdi9PbQ5=FL3S=C<>`peM0<nC;R4S@`17YCd^p5V:EIk44Xc
o>G<c`fRA>WNkNp\<kn=UkNRo?Zf3ledeFRR<p1[;\GD6:eG>>SF7:IbW9Ta][qk
cT1]\oqcX3L0k?j`WMqajdPQNb3@6NV7idJ2<YBolChn[dm@j2DSR3TKdSp0ATQQ
;8pd6c@Lk0pWn;5?`@pJ5HhID`qB8<:c@YQ\AoJS^GHFV_pESjJbio9c4MjA1ngU
XmjpZn2f_PoQVVH1]Zg7dm6I=dCpeKe:V8^mU<>Jk2F5o4YlmMVn_508gN@dTD2T
6Gj=kG1[F@CIBh4dUnqb6O:4bYN=9q2=LUh8magnelMoPVELBohYQ;g6ecWBeTbf
d1WKULoF]kjSaDPdYbf?R72a<Ao1F2>]TiDTSPiX8J:olaD@294hQQLNhUPWqG[:
;TOAp55?J6BSp^I:lnbi6_6JO_9M@Z;_oqOD4R10fAh_MB2op1g5X_Ta5eV7C^@L
V]ERDSF1JF[l3oRC4D2pJ:S<dFRVCTWRP[fW_6o9DS<98OL^7\JN03D?ChqS_CF`
Y?qZAZE<dXC=1RjlbIDUKf?oI53_1pAMQGielZ[ChaB?1B^X^S^FkB5cl7fn0kGP
eZcM0U:BI]<?XjV:fTKMX2A[Ab=[Hbk0R6FlP5nLfQ7ZAo>himqYL\1KC7qe@7En
W6kM6d2:2@aHZ^PK_;Mg=?RI0``ZEBUR13qf]2Q1`i\`A[iUNe0KOabf2f74DpkX
mDi3Z3RYnAVg8QkHDi:EP84;Q`F9;q2hf?`j8pUj69^Z[qHU0aIC^g[=qm7Z>WkH
c3Zd192U<8X^oS<4UnFUVihIK7g0HWNEK;c`JP[hn?0XiaRI=CaE;oZj[o1NkR12
KY05en4T9@HK]SP4TdIcjO?q>6\=PFLpOV:YOIGqV@<I1c@pb?ndZ36EkR2REG:_
7U^hE37p;^\Z5?<7]<M9EHUbmA:G[MDBc>DB5MQWa6L]E=TB5Ej<YYRQLT6]>m5^
\4cAq2\S=QcRHZ8]L4nnmoBD2Ubd6UG:8SijkhC=[N70h:NYT96>0<OeWf<=Z_^<
E1CGfL221l5kP080a4Bk5Kk4YA8lZJPmS>:Cnh0dXOEX`Lj:fJ9qGhHZ12GpJZ9H
\enUAJeaS<1@m7FOLeea7LoeN2jW:5qeVGF87Gp=HY:MO4XOiFA_0QN;hkG20BL:
>b@mX9Ted8bWi`8ORCR9?NBkK_k1=daMoVPMgM5j:LaVCTgO2be_Epd@S?e:DqMm
OGWX>EJFY59X;26Uib?R4_T9:4k^:P4L8;=Kp=QVG`F>p<fNClU>SM5LahU`lh@d
_O3n8^I0[=2N:1d2?O;H95UmgO2\IWPU=i05>Nd75FJoqXm]mK_KpQaLV?LKpC_@
\CkBbBCFDTZWNCmWb57]FNEmSK7M3WaO`DKdni;>oCf<_l`N>MF<1iXJI4VQL2j\
kdnb=;`[6L=XR4BP\MSpdcK]nfPqD:mF0SZ;1YKl;e0==E2=TFjoCkTO3Ql82iHq
d1BX;\Mqa1g4BnIq[ehDj?]YdA_^_ngL?26AB\2CDFm@onkSdE]DPWb2X_EpOd<`
Ue:L1n18XFNFZOD2ecpabgN:45LhZmRTCYfh4Wd?IO@EN]CpaH@c1nGqhOF[CWS3
kVM>R]Kcf4iVkYY;6\F8W?8DH0Vpd4mF34<jWELTGO2OmanDdY_HTGG<Hfj^Pc0>
TK]BlOE]kM]iSPP3NgCI14p[7PFVe2SfmH3b2hlDJjRmJ5??blJclHC^ZJA^6V3C
MBX=0TJb[:CN:h?BUalPR?O:S6j4;D6?8kqdbej?[UCED]1bGTGEFnNMEk_H9n=<
2=hq783a[b0qZVX]fKe6R[nX6j6FEW6K5mM\A;OR:A@PJd1YU:McL>gp8\dgVZl?
ldNEiLYlpAjV>oS0qmAX5nCO[Ok]m6D<f6Z93RO2\_[<>i?l2gI=p@6DE>2HXT5Q
O5jc<YJ7NP9WgZRVf<OUp34hl1>:9]H^eHm7?U2G7Z9IFc89iqJf5f8^9fSF@MY@
WaQKMoKikk7oUA;`hIU:[V3?GLaLRn6XJIZJm:71`Id=BofLH>JG[n?b7CFUc39e
SoZUl7I=3AWk[jE>p\18fTSG3Vc[di[M:CPK7<C9J^PCEHR]bA>BPaVn@eOV;dH]
Mi;V@m1n1ZjQaASN4<oaHTeo9VU0S0jeOcWqYEN@aUEH[47fMfa]a@LIjjRJgd6[
GUP0=G;>nW;FG@^D6^dWiS5jW_gC?nlliTmVf2p]eEBa?h2fPaUnH0p;5M45K2?h
R6jmieAVXm41YENZLE@:SqLA4Ck>a?kB1QSSNKPOI6H2449M`XF6pFOUDCoJq:mI
jV5_Jb>P=]WDo`DqKiZ2YUgq[<35YiLd>;Ma:Yc7Ql>fn:L`@_QNlS<3Gl@q9j`j
5A7G3l0NKGMBK_L26n1:?PXk3^Qbf;j>VRVXKQKO[UVO=g?^3nYHFMR2e4V0hS`I
W_hfD29qBF7f:K5ooLGh;D^^:1Bk29HegNLJkAPJ75aF8k5Cc7<\^243ijU1GQG5
21p9V@i6AoahaMY15Nbk^Af<6CPa=;U2G3nY_bZB>7^TA4`373Of7h@FnWT_Q]C=
Ya@=V04IQMC\mHB3bmiaFE`CI`p\1eRBNaLfdG9;a0TR32P=o@fPib\Pdkq531^3
b[ZU5bkW^Z6RN0V]D:c7dZCRI`pPV:ge6[qjTMSin:jfK\jDYon>886BlNBW7DTB
Pk9ko=qUGZ]knCq9EW_Gg?I[3@>;1EdRJ9@C49IlH3@[dY;Rl^p5?Ud>QgEoTeY9
iIolNGW0i9=anLEMn`J9`0mGAU]ObUJ`@977jjpba[Vj0AFKDRgJ@hjN;`7?Fa:h
A9@cef7gXhWgOU4NJc<n@CH0LeW1bpJa`^:jBVIAZd`g=^VAb47aoC6BWAoZG:oD
]hSg^5A>Q`e4F@9V=mMXjMhdVaH7iX\df>;Ej3WX4>XVGqIjeHB;;H27JKT:NYM=
dj=oPLdUD7A9<91DkSkijlkikMh[FBFbmkdYXc]V4R6PeeL8hn79:m_`3A03KkZ9
SpcN?gJkHO<AeAB;001>?jS<8cjKLAlgLFbNCLhoep1>4oeD68D6\=ij3Mqh\d]B
X88fMfE7ElgdJ\WJLL\2jIT^\\p51E_JSWohJ7e3eigY?718jLB4HM<ZOAq3m:__
aiqS5V=kTah^eHaOD8NQOHJb]G1L<RCjfW\\;Rp4B?BI:dUnfZ`^S557MA1b]?l8
HM[PkJdnL9X^:[IJii:VlC=<04p^1Aa56np_k4YZ2WbBMc>FJGAYfPVKT8ZCd0:^
K_JLJ4qfa0?hVk1gI2ej68d]boHn0hl8j?kWliJN6B3G04NGB=i9nHmN9H8jWqOH
32^1WNTG@CMgO\XWB3cB?4=[4@5XGB02B:k>[M7=NSQ\eCP0ke^aNkLc<[Tf8D2I
>eOWj][?\d7eSqn>UEZ``Tm[@ASC:HScpo=jflIjA3hV>EZFP6miI0i]1DHO40XP
SY;G1=B<o;27HEMHQ:V=kmbXFage;`W42W4ijlho5:]4C2:ZJ^8IpH`G5:WQma<E
AoSQ[pTeZki`1SKTNAmm2Hgie7kP1_bAnP1oSqCXT6^5W1TAVABegbLQKm<XCCTh
M^0bKq6>VfU0gqTfBN;E?>FO_FPoFaWRah?f[Vgc4bUPT[pUoK5RFYqRhkH4^`?E
<S^8DfPcjJkn;<L@>iAaTaVN=gGGnF=qM<?V[Ig8T9WI4TBhJbA4g9CgNED2JANQ
?UmpHb[=C64nKmfUS;DajKphn:DelJln5A]j?Jg`0o\[=YmNW50[0@Cj1OBQl9>R
D_mH8_4N;`And>kFF?J]QB^DKd]phY_bmnkcdYLe7_k<3;CjlaDX28l6aXWQT]^V
6hL?81=`Xd85NUjepaQTEh98Oom1hO0b\F8Q6X:_?DH_K5`Fn@QH980H]M;0kG\1
;P>[^Ejo?L9hB7ePl[];l?;jlUM29QDOnV\7`XVR?bEb;9YWF02<p4KW@a9?9cN4
KSVFgP6VO5BPfG70@Fdh@QVQD2LW1FMF@63j4W2n_[eA\]IJ0hFmVT40ZbLAT8<^
6a8bZ1hpF\Aa6b_C0RE?edZiVU:\HgkQM0JfI:pdJDTXVHpG3VlNRl@a3e72;]eD
n9lQA4CWT:KSaCBpRQ7@ML]q_@NA^\1S=Zh7EGW\HJ@c[\ia;UEGEgW??^Nq3F2P
9R:LMIZgMg1c:;Q\<dD<?W5gDi<?6h9_c94;QW2Z9N7p1;:Lce:hUdU6F=o796D5
EENNCC_31a?0fSkYXAK1]_NgH\=FGg0iJmp8XKZn=n8n\=6^ZHF?b6mb3VS:8JZ;
9feANRG^>8m<g<A>NY\m?0g@c`1[l<^HeBO;j[=lSDZkiGjSG1qWM]C9PmF2XnmU
\GE2o82?SUf:o<gXhcNDKOX^nhU]DX=:VL<jVJo]]gEeZE@VZRY0[bMMY8^eafgg
:mlLQpLA5n8O>eC\Bc@k5p4cND<_`k95I;Ha_Q1kaHYc]YlRjkW;V31Wq1W=CAO^
B`^0I8MfC`0nf:2be0`39gMpJCOf=62pGAoXRM\C^aG@CK:5X5aJBR:^h8PCq09F
0IQ:G<Nn`ZN?Wdc6d4HiA;YV=^VpCClFNlYq8FHamZo8];G[>Um>p1SC^j9=qoW@
iK>H1K`fTVFahT\43n>bj?KKqjk[;[`Wp4D82m9BaZ6LbfHpYaoOWFcJ]BbK[k];
R4h1;1M:f<3ied4Of\9qb?ndn<b1iaGXZS\;8e=:9heA?ef]H;h:3<i_GV8^X@PV
X4cb?kIO3_4T0:paNKFoi5Gl>=;PO5cQkA<=aNANHM8SZ]2\@leBOm7iPL71@^6o
>9O7NV0n8ea`dXUlbmU^ZXIjTmTI2N\Y8qAN<W@^Hq9@Q?2cdo<7eL>XPY6EiVN1
]W2a7:D`8\0o[7nZ^nZTVCANK`J9q2^4oZcAOZD:2LYY3M<7l^ES=W<3Q95qDc?o
aQjq>hb9^h>gbgTc^oAd_CPpMhOX\Y\aZ4j=`WZPC7jMCdc::66^ChRc43`qAQ__
EQHQ<aDk6Cnb=?Hb@SnmGWlqKH27>3eOoSYBTgkEc6k3\6NSFVH3H1_Bnc4::8SD
bB[VN:`D]o\]Z0cKhYY6qG[]`R2UL=h34QocL[fAZ2nH0DV=ZdnYR457mYlOZL:1
CPjE^Rjo8K7OBZdNGn7e<>;2RBbBZ3hJLj^pUfEe?f7hLj@:Fh>h1kk@eXgb5ebW
fFE4GRDf4eND3ITZN?X4g6PRS>k@GSRV3=Ngn:KMbg@LiNX]Y`9_kL9fb;n9IifM
qk^Y`I[L;YC<l:RI2Nd49PJU9LV2hFNB^\cqPcdLJ14AVM]8haJ7`Jnj<MJP=EdP
OTK=CM]5<kLogfUL>@3`N`XiqPVkLHh;qcfb?S4p2I?@4OpSD8HaBbpK@mM@7eO0
1b19^cc`fF_Aj1E@U8>\n<EMA=V]4XlaSoUO`p`^nF:KKToDfemB_[i5Ng]367cf
CoqC@aeb@?4\:7UHkR<3Tk1MVARq=L9^eD058=4dCfSX9U33f_fe>op=@M3M4CpO
ZcMjY0\5iKLJVF:9Xa7:Dl<A7U[X;Y<SfWKgkRjn\>TAA<PP@l^:?SpiNneB9@p>
BH9Rl<TEPN[J^_OHO1QYJq_`k?CSa5[65Jbn=dRRo5MoXSf2biJ@4b?9cR7WDXIo
keq9hYH\i8KI[FWd>R^=KhIYBBXD=P]pd]AGOX[pL9MM7]0pZT3Q3UAp><XO5Cfp
0?[=:4G8Rl5HC:Xg>f?\Z2YL3>@3V9iPRRP2Jbk=48Um6O4HP:IZel3fSgR^kPp`
1409eXh]HX?MJSbd\Gmd3[OR`GL1e^pe8RHEjWKU28V<DY9m3\Ni4liJ`<qaIDBR
gH[V0_9<8j8JKUk^VALn]XQcGQ>qPDHTe9]_l:Q8Ab^6<Hn@gnjBiebDj1q[A>Lm
DNjKTfG113IX5h]igeUM38TiKg@[Wl8YYW0Aj2D<@DXZG\h5g[:ATk;;mj8_j:pB
h0nYIo0[0nK:`m4?U>@ckCl\T;^]^GTSKo9@3]J2I8V3>Y2R6kfkkeN>G9\VZPS[
Iah9]n7<CqeVb879cqgmB<P^=peLNUk^AqIO:_bXY<>gC`2ef43`26@Fn]Gc@dcU
Up^`ncYaQIg<>n_5cBYB:Sn=qSAUURBJREY61<X8[cd?GpP?=hk4dX\NKa68b4Gm
UT552N=I7jk5Tf5WVDU;O6n?[o2WpKblCgN^pC7Q67<W<c=WCTibF`S^D3I=MX4E
dh>DJ:@Eo^0gI8kR5DeFU?7VN6JJ:`7JPmAPY_`Kim:GVfkR@6e2>Lh\;I?a9_O=
<@2io`aGg8<;Ugl6Up_m3=Bl\D_eab3OP3D55q4`nlDj=pSlCF0PgkgSG]kc0oGj
enf<VlXeTQ_SI;qTJ\=;78@73KWm4VZoHF1\cSgNc<[BUKbZb:G92T>W@Ua_nA27
WQ\6NW:g>OK=MkRJLPRgYfkq\h5Va?[]<F;RA?:l@hKZcZ9cGGTSGRST\_^Vf7RI
q2CQ;mY7qNJXIHAWq0jhe6hgEFiTC8<:@2W4l:@eOS4nE\ISmZ:[l3QP>9Db8>B3
O[2Bc:Qhh@i3JC<j>3l`j=Kj?9_>aQmWd^GqFnNi]NA0E;1\6MhoJGIpX3KT?a7q
hlK>^Tilc1DjU_@]<H@LP1BeaSA2\XqdZF`OmJpf8XUC`4STffD5BHkp@Df\oY9J
L^SDmNbC1MG73B81eNX`Ck5RZ:DTndEXBMUHKFG@S73_?9D:U5\kSFCXJ<W2TMN9
qKk0:ijmpMcSaA3PmE\8NM3HdMRKiW[:CRM2`plnh<`9_KXSo>LjE4l<`1qWQ^Jg
>d4iiMnNMcgQ0=p=0;UVA9chm1LjYc`j5P?pRUA]_X07=`W[<X4A5c0I^GBY5mU1
H\cWQlN:23h>Sg?<8OgfBfkPZcH[qMY@bRbUXH?4Pn<GBkn?nM\J1gYeX\h:b@nG
LJ:e6J;:5Y[lLpNP^PPJDpKNjm=;db^h9l49RW=oR=p0S^n?9jjdHX39eN5NnnpB
ABGb9T=Q7:3F00YZ?QJphfT=>g]8QM1e`Y@hcAOT8;;:7[HHZ<28B`^F9`<=8Eia
YNY[p6S2BCOhq1R?Y?D<QGd<VBR@S@5NcqDb6OUQTmCSn^R=;o@PCq3`N5n>m:<c
VCN19V^@65PbP6:HT\?c>q;5eS0h?Pgli`[?nL:`81p[i]M0658TSJB36CC4<R]M
2>X81dIiiV0[?<5m[RYgTY:<=lipo<ej>h9p\];dK75HidMBO`Q<AOlMpO8@J\YI
n^SA1KFQ5XJ0q8h;9oDX=6;a`V:kSBn>4qC`AaDXEVUkaH=9n[H<d>PX\58kSicM
oWTbVlgo?n8H<CoD:2qKm2T:9le>K:^=aE2pIm7;<\7qVcUViB6>:nnMY;@?an60
qZX5aJkT^JjfHL9X448eh?b10MRiTp9Q0H]A_i];K7@1PhQSEbB3h>VA9f[>p5W7
BMR\mJS=H?R<CMWSae65`]CM;7RLQRnPmKN5@8GceMblC\J7_HVJP@\RaiZ>?Bop
L60_=emp2]gonahWl]2LWoRgDBPe3dWK;=Qa55Xi9:j2YBIT3T25koioI;o9?SV:
lJefNVfZ[6pX[McGHM$
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
3k6gWSQ:5DT^<IlKOQcOZUEq_>\aoi\m=HQOT_N^QVH4cdWSYfnOp`CWUDWk3:1f
XNB^PFn8k6[33ML^DI][P?[n1@K[Z:k4j^P@Dg]OPndA=ik7WpNlnYdkqf;>0_Q[
RA4IfO=dE:U3PqH`QVU@;W=EMe>?fl:We31nmPqkJXAIJ78cc8RA;nU=Y<eqX6L>
fIJeFVi8:=>`;OTcK7\Oo\aA;9Y_9<pIF1W=@8I\B`;42ifbl]YO<qe;^F\M<GRL
hSPY6=cageMi[]2[9YCh]lbaHIOR5ekJeooYG:1kYlokVSpfAeIb\5qZgO5XXK@@
[YLTeB6jOR^dHO8kg`A=lPd676`KPm<]Eb_8_5hT1>Cb:e=_ciN^`LekAKC8]O4=
PMdqMaA9D0LFhRDmO]gQ_BK_NXFpNf1:Lc0q?X`RZn6FDkRKNiZ=Ro6MkTHlUY]<
;8<piPTS9WFhB^U=<bi[QZM4Zdp_15IcU>i1MLOchR@_T6\3jgIOZb^25E3T<jD[
Xk;nGcqjm`5e@HDodU>nOabkVJYDJT=Jc990_84SXK8qdE@7b<pL?dXXRGgUP[h\
e_k\?3n9I3f`o;<M=506djD9kE3IDHU91bdPadUYHi`QJTk1OAjN=NV]H3Y4EomW
\GOD?kK`OOp;N>3c\h?HGPKQ1:EdQ=BSV=g6;S4Q:B:``=kdZZZ97\:j\9nJ:=B8
P1pD?N^Q2[5m?nMh0dS4WAWc:Z=2mF??<>L8cX\`nF`O]AfX9LL>;<Dg0UG43ZQ>
D_cHTd_Z4ODDH\3lTFDPcaq>k`ZA5TKNnoJY>FVS^aejj]ko5hCj>KOOGX;P4lSZ
Rf0QA3]Z@kHdD<D[N=AiSbU1bFn\VVBiYWIIB@24j[pW^\Dm[PG<VjLhlRVcm=OK
jC@^I0mTW4_WSoHnB^_1W_75i6bgL\f1NHkT@LAkbiFW\_AEk;BLH<@jRmfKjqPQ
:RGF<q=aCie7jfl[cHd_<\H1<@?;GJ;f`2Z4^G`hEPYIX9>I4kFN@_if<?<XXoX8
mlGebEf@WgQ2IS_5:pRP90A5Jm;TiTgk=Q@mdjFclqCLJQD7Yq5MPNo1pMm?6h8D
hYMTE^MfI;6Q88:G5<W:5Noejea92_I7DAKkZlohCb]^QDBLejbd6]R@JMD?6KI1
_8V1Q9L@>ZF<=[I72qF`4?@<Eh<:M\j=c31Yc<TliiRUiVB3]\fXTUU_O^ZRViRa
WXSTUS5_e7b3^`@eqnioMbl<0aDk8RJ]EHLEG42`gVkKYL^2]:eGhU5?b`8=OjgM
KFU=:\D=?N093EY;en\oA:QGNig0SYRiGlb1ApOUJMk]_M8OhICUaH2XVD8K7aeR
V0V0l^Li_J17jceMc7OCj?PJN[o352NYb^db9\OnJcZK5QjL3l[mh>mVCWqE2^Km
_n9\NB2YoCXmH;MLFYfWY0IZZSdBEKP=ldA2:i]J:TNKOcH>C]`EO4;@>E^l6k4h
fcOH=A[HY?gb39pgLJl>XLp9PQ1iNLGc6WD[30m44g5E0\;h:Xll\b2JKl\82WSj
3jfQm?P=P]:5iTSX[S[H6<GFN?ULLmcoS1pa=HjEV][WD:W^D5l]9BE9Q3PkaE<0
cTI[01lOC9dnVc^f6p;768lTZR7E[\f9n3>n6IVGEp`V09BoKpL^C96jOl5:ki?k
cNG4EX?N1^EDmC4KN0i=iH5lERpeFdZeJ:pAlbRlbB``KcY3bDVL;l]1EhEBW4Ii
DajNABR4J]aSm@=DT?L\>2klnXYTg5HjKa@A:01_0hS;IMeoWDAl9`C75P<bNUST
\=h;NgkeFde=DVCH;2Sk3pG^i=j0]YEFQF[\m]YI9I5>mk0f17d0=AaW[=no1kg2
X2Q5B9lifIIT8;_?IeV1CgF<1qc4l?m`Sq@h;=FCPpK<fBYKQqQRGLP4E4`7W;eI
QTa5k4WdeVQK=R1ZKnekEEgVNfpPMlXX8:AO5NWcV_MVdZ0?KacCo?h3bT;^jP:l
oO?f;XW^fjlRa530Lm[^dQH_67=bf5PL=P6LH@kETNfp>e75;QOpjRL646q5<:]X
2HEG5oXSTa]Kd6bqUbl[\>d_6Inn33MZkLD<4XQ?abGdNCld>NgYCj4dM0TB<e3M
pWVBSga@=lWc4;h39U_?b1L7XY[fYDV\fITgmoO6NAShq91T6;4eRfH<dPPjFNa0
3la:aPhlif8_680hL8b2Bj0Rpf9;2;E;nOTAClS5LLEQRZbgW;<2R8G;6mLad25:
cYn]pcc6678Bnf<n85C<H1OSYTeI=CIjEO8C=iH99SmI\J74plX39T@\qRhUXM4V
:NOhh>eb`=nV_EYW>MQ3ihU4QLSfe@RO><5YL`;ca10OGFEJHX>_Tqi5_iOLSpnB
B2keqS;8IT`ogM24\6f_M^2>SqcTa>FD0aeLj>HHdfWLe;3>JUKi^PB<[XNOMYZb
qK@=9:Nh7a7:dUdJTT`9D6a_b\CWNagGkhkdWe1U94V@p0ZbR9K\IXf5C_EQ]oXl
YW;_[jWO1Tha8QXKeg\1THn9pKJOCh\2nblYQ>0DXBh^0d9f7LPQi`fAOXIb3bmG
YlB8qQY\KBZmhV[e0QOc^;FI7a2=cXG2C@J5\_LT^c:el_caqaHo72?f\FCdiOT^
R9T:03kjX4IZTcI^PVgaA<]kClZX_SX7mb5<@U>HYF@0a[;qAc2GdaLp=\h]e=MD
]nbJc8i84\BV]HaIn:3bjI60q[0gil[>pk=PjWRb527jE=NJTHWpI0:3>Ag6;\0R
D2DOhn8WJj7:pWMRU:k?iM>QYnW52^O^4pS?25j]B@Fe9WfV[T@E?W_>_4XVUXkJ
XhMCp5XOA8TGbjXd74W5^J_6;F=T2k[Vd`\fWiVacZg:ln1Ob\UeAhe0VHF40qod
L^0FE;:mWDX5Z7c^R0H^Hda>_qQYWk?BYq>0WooZaZi4IiJT`R[10le<8R_AH44i
m]_L@kAl_WlE3gV1486V1Nl8ZiPM?[>;X;OehGc1>VgZc2pH`geI52QNL[:iSgN^
e@X4D;ApE7MV]\lq;nhUGX4ahnG<h;oR:Ib0p^4VjCT^N;jg[gMh`ZKlXKYeINQX
8b0AR5NC056:l6S?4g;OM0;Ed[NNX>k0W3NB_`]1U??kSqc8_hXZe5G<>V1\KbTC
S4AfWLMchp9UeOLL3Mpn_iMP;\D;SiH8=eRJBVeqGCEJjAcOSJWQPX3>F6GNYAAg
j?of9M\Q1AZ]c_4A?A[K6fkL<Y`kcA<8^?5l_edkOap08Ia1>i^q?6J]OV33OMP<
n20kJWNXmiS>BTGpgR[dd5Z71;]b8fSKU<YN3HJMme1Y_Jmgl3Rbk0PaO0jL;j=l
3?eGce2@]ZoKhWk=O=qi3U<5G@YqV3\1C^nkVS=U<g3?=N2_^geFd4UmG8V?EQiH
P6pEd0HmJF`qomVMR6`?VRDNJHRGon>@^L]jYD@of[h7l<DV]9>cGb_:lOqih;E[
Jh5q7>O2X@OEq=;aiE3SRR^bcQP;JG7On\YQXa01Tg[>qGKE9VkiJjT]0Ni6JU=H
jg;NTN^0f4U;eTi0kGEC0O=;qSbhYM0mFCQYX==b59^dChbkI1oWgO79k>_TQpoa
HT<eXY[`YIk]Wq5IN:ZJpRlO_?^oVX6]N?oH^YCmZ;a\?TPVWL[j=]J^j]k;3;Q>
ocC6eDR<g9io4eAc7leRQb`;Ln5hnnc[;1^G06=>F3oICi1qGfIHISBaa]B_e09C
QjanZ>b\RW1>8oo2PgMgG0DHCmSo;24FG;OPmQ_\Q^Kana`XgXATjdBSLD5D\L:S
U\0Yn\p23iCQ=EK^gkQW4n;2U7`lM=jY7OW@YNS5Lh05oC0NGBNKPPmA8E`70GJP
Q=^6TV:TPO0PN01F0nYS?VRL?QAP5pi10i>GeBaW=b=78B[RN141B?KXj\Y5HF7f
4CojVogH]9Ad6@MCHAL@_m<Q7f=X>liV=:^GHobHbANa1Q[lh:q`hGF:;7qDQ@k9
4?oN3nC4:D7>XVX?fM=0kV3e=54@I9;Kan4\ZbYnIhIGffXbg3P2h<BNOi6AiMRA
NYN0EQkpgN@odT]jlGP^`Meip7j6^WhI7KNKIm`M3KN?B>V^\pUD=8nU3qAb6Xam
9T<bR<oU2Z>fZV?Q]l6]6cO^D=o3I[KQ9NQ^2]$
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
95dC2SQ:5DT^<gghBBl\lnfknP20nkIUm:R`q47NleeFANOTjk<d78\Y`DZ;DKSX
7FFMP?Y1n^6HOQ@I7[]_qh7g2O@H7Y0am6RD;R_ABQ2qmc337?qO<9Nl5<ZebEFa
L@de>k9=njLnUhqd=jhcDRq8`a7>E6mgST30H_MD?9G@O5Z@OpaF9\0omSSYG[mV
Y=DI:\Ii2^BBJVqQF=ZaIfq][J4=WVm\3DLZ?DRJJGf]]BUg2hKdlp03DZe[hpcF
<IeXU0C>?RDfO:]2]AnZi]=T:aq`0_0aQ81764Uc\j52:QO;W9h:2np3l=c[`n18
X?iXWG]=ZD[TdqfBLKX[[VcPe\<Z]>3ik\aYJX_3UR>CAQZ_Ym8mM@JPWB@;JoUY
R_dLFZp\B26lZQqX?AOPH[OE`MnUko6_h<3GN2<SGCZ6okVn1LDC[MDQn;@KIan<
TBMRm=ToR9e[C_[c?>GENH\H3eKo36Zb9I6<1UpLX]_\JZWYkP;GRhQ8alJqSMcI
60lpIYFW`2`0DU^?GC85_>VhefelS6m_^dg>;Y@pjjLlIJnM1Tj62SJpmMB@AlQ[
_N;P5`[BVHSbEK7\_<5_]MSA31M@1EnN_^fX[DG`k^IB_4:aeG>aeEX_:O7cL>_4
`oWd\>7=R36aJNXq9_QGk;e:e;c@5KTPMPl_pJSnLenZpOHLb9_dc1Q2BdgnV0V8
VPQRe;iaHRfB=`l0pK=ZBhSdZTi1q8>@GP0PelUiI@ValEahnDf``8G>;]M=OJBS
C8la[MM0ZKV`KVYo90HH`5=KBBHeQ7d>HnmEKqeae8l5L6INiW_3bKTka0>S5oS`
dcqd2LL0[BqE?PA\L_9Zj\i7`]>8WI3g6kRKd]R[SMg;NMLo4JWXC[m^70pTS[o`
72p:<b8374T`gKcT<gV3PMY[[CoX7`pY5E7Ub5=gFZ6=cU2AI^^@7qiVHh6Fij>6
2kCl55n`3YFOX@^JV0aQ6^^AGp4]1PBi8NCOTPeK=7[7_9c:`RE67NWc?:6CApA6
8Tf^:JWZGp\Y0DVMaQZcX7he36q_oR]^oPTXfMKUN\73:?>qE<n0G;DVM=IVMLiI
]ReFh<ZdSO>^>h0@iYeAk`p`m73:AV5T>99C`DEOSmiHT5RfH1QGkg65B9bAR7ah
:;cMQ;PZ84301mFgkaFdgFa>]m<ACHK]]]4nN5[E81mQ1=Qiffp]L5`X_JZeL9WC
C_F4XNo_fT1NXg<VCC6dC2:Z^@hpe:mS0H@6;\XTVLaT`?a@DZE<AGFQ86c_G;^Q
^>Nh[O43C9[^750U>>8\k9O_GP[da:_T]cVO<eWQD@3JKF`m0RFW3mAq\Be8WiCp
[D^FZncp3k7I;9>5LH2mJK9\1BcU=fABnN29l<hQK[Df`2@Oe<WiG=X?<7f<PS5@
l3@Fn<9h56p0L@KiS:KAjH`VP`e3^pgIM15lPIB@>nA<MDRZWeon>m7QEmm15FS1
qFG?`I\J8g6FQi@9E5G23\6CO3WPT6m;B]ke[o3n]i:h60^_YY<Gn=\fZGFUH:N1
Y^@IRDlPREfVhQIEhV=[?<HfTX`?OS6ZZfodKmIcq[=K6AkFKeUdaE=0Bfm<\AEX
2HYYgUEa3PV>:qW1algoU95GDZAP;?mhho3[F2jhkc7LagJRXibFP9T_dZ^2Q7S<
L7<VM4L\CLR1mC8`cO1lkIWRSEIombjeHj`nhRB?BICio6Di`OfUUpTQel3WaM^]
kXOCD7EKAOc2X04R?48?O]FX;SqlV[g`Xj9cl:3fIQ2230LKl`?V42GgOf96@QSW
WSln]`Xi>H<:]BD2[FMoN9OSNkIBi>8T9H7_I\MNAJVUHJClfEo`nH>RnK?eEC9A
X`q=ZbWSEfpCiD[2HRqEb[jXcNZDH@21gOHTB4QmXl_g?L98MV`q<K1NlKGF<5m_
]eajH4eR=G13=KEdMNLM`8aVI=Q?6HE@cS;?C@F6hC[j<G4Bl:01Tfj8m;?O<AkD
18[9PNGpYO_Xl67pcGE>lB\618\QW?<S5Sj[Tmn1PVU6\:Nq:ZWk1B2pL?HN6CL\
M<q75>jDMd@lWUKg>FlOSJSB<f1j9j8o>`dJRAhmKJ;Xd:B@5\>AS[4eQCP0g5i_
<le7;R`OGnhjC^09LK73d;^AdNEUkfaHYp[cBCFWTK3=;cWCMR8LkhpE[TDSLIY;
1OjHFPq36fJ3K=p^?7d0_M@klLj1m`kb=DQ68X@8eld?HAd>V?WHLiMETB^Gc[2;
HhT;]qiY2L3J0q>M^3Ol2;[D4KT3?M\NJgD;n<kEBh83[MT2A6_O49@SL`lQ7?Ah
XpPGJV6^qnm1b4Ki3YZ;0XgMaKYK4I?14IObGm:OZ=]L`ci[91UHSEMlmW[IX;92
BV^N?]KAWnA1b8m7kAIZBahPKqjf2J^FFNU[XcNj;O2>_>j68IbG[Kfe\GQRbNDj
V619fciWbC?g8H>CkQaKMHJkg]jh2KFISRReVVpNYWQR3>QFf5JkoID89Ibl@n09
ni<ZQ;VgS78KOQ9LhEIIGQX1nIO_IFa6o2ReU?`NVWdBi^8BhZ5pD4Rh85ULLBMZ
6N7QXR9^WlB310IK:HKZAihK7jike66KKcEe>:bb<\7fBYi]WC;B@2SkRk25k[Xp
hID\GXcPXbeYT`Jo7VTBoA?1d]Hhlgl0mCbJIV5aV:7]iVk01_91DF]lOfdq;gOZ
dBTTWAd5kY_0a<?VlAA4:;V=^^BM5KPFYEOUlI]^SXVQZi][YgBQdaGRG]W2=P3B
8O0_WcpLlUY[n:p6M?l]5<po=kCej=??HS07RQnjFg<e=Z3O7p:edohbebS^UH=W
lX5KP@eo8o:jOZi7<LqiSBALbK^`CWK0mGV7^n37ITjBObi@e4Za`jo;3d6^_la2
1EpIdSgH_LB=QSg5ah\QZEcZcTpCEh2kC$
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
0ZKl2SQ:5DT^<KMb>2jJb0C]Qd;8W1?CHGnh@h5GX\i??cnWq<bHd8GP6@O2_:fN
^7ib37KE8NKDDP<XRb]E?8TC@b0Vn4AmS4X??E8?cEAUlT734qe4WSEL3G=[9Z0J
`hJM>odE`oM0baAGq5?W8D=qY2^=?fkMKm>Tc3EUB>n[Im>CVi=\]0cMEZH_C2J4
3<q>@GZ[9TqK\fo8DXV<92`TVHN9\32P>UgZejKU=G59a_oL3]le<BpOnaMb]Cp@
hjZfd2Q^G=9l3\@G]gl=LB]pG1PAV8qTLX[lnoCiL2[iNf]3SJUH5?jX?JUG[Vo8
FeQ=4no0N\KffQTkBjmTj>o97Z=?9G>6NRW?\?8WhO\iAS5g]NJQd72>9CKT9pmJ
8<1P06GaeHVjVB:NkNNSRi2bG?`TYiD\Q@9VM;[<MmUTbMHk`f^XTDIX>VfM`^jc
Wo0N0Ja<gmd1`R5\``KoYglcp4dXoQ^oPOcTYVGUG>@nohdP=^_dVUm\P^U9dCUY
N4leRJ752^FGZiIPPj41E>TSFfLeoE3\8mWUf;UV:RCM4U5?[8ApSQ5JSgkHQR6>
V15i=kkSMiB9l[5iV;e:K7`4UA`Mffi@F:^Mo\]7QT?[:g2<FoN_>_4Z`@`XI8\G
7m2X9<K`=fBcqLI?\HOaqHUU`gCfZ5[Yfj7LOceV26gF1@BSijEZe5kOi`[DHd@g
?2Rl>LPXCF]23`TGhl]^6cCNmBl0>?mg=oL`nKQ<^N9WF:fE>edoKhKqgG2N:\5m
K85`8;XIMEV_IDpMoiScJ=NK[kIW=XWR1ESHOg8kC<Ui40Uh2Lbf\JSB3qMfkI2Q
8qkke@XMp7VJ@>MZiUCKBU2CFhXh13EaXOkhhR3AAln21TTO=SiS\@];k:AGc;D8
>oWf27E2g`R0B@<@LB?PmkmTSa3KCC^0U@]Fc4`3<K\00R`[MWn^BD0Ulc>Y<;bS
`_Q1g;oeW7GhAS5ApTC;4F=kgeX\dhV5KnK?G=Ib>7[ZaR7?HfS=_ZZPnVZ>Mg:f
=eWj2Mj^=gI0187cQeo<P`JgMV:TgmS]8dBdD?]l@nmpH9gIJFnRn?6hf:<^]DZ1
a:d6:g2b7EiT?7PW3W>FSWaF1W3?QZFbXKJAG?:C14Paf`1p8CUbaUR\R0=@PPRM
LiW\7;:HMe^`L1CnG1ZodS:^=CA>[KP6bHNbged^bg;R57DMYU54J2lco_X;6miS
_nI0IVX?cCqJ476DXW9ZWifRhkKNAlDXF9Y]Pe\OZaGobkeajkX0TS3gPUJRUVfk
=KB9>lFWVO95lAfCZ6UiB<WEX@W^e`jMmEn5lp3;6R73nb:I\@;5fd`Yfa8:U^>5
Q[oaE`1K1GULIJbXniDn1Z0BJ9fFmA:=c:<[U0TDP2:OQKTT>P91:5N6c`<lj2M<
8O@iE82mq?FY2A2S;MLE;lD60A<L7W:3DYAY>@7CeiEgCGj2m=aKZ0>pGl]HbZVH
EHWhd^W?O<g^bYqg:Xml8>B2[gc>AbSZ=hF<GhoBNaJZY?gpOE4gT795=SdP=E9b
WaKLa6pRe;mln^eKZ<k=QAVX4:oWa<@c2QYPm]>R[Jm<P;bVG[bjFBa@2c1PkPji
OPm4eFlJRZZJZZUh@N<OCAVX;H9b:\qMTk1N;`pCIOh?eI5dU1nYR=GaDHnGS`P1
bQ0`8_H9I4XgK3p44iI4>jqHfmZkjFql@ADJ8<q85U5\W2ehf;Xk:[BLd7UjSXYo
AS4X`G`hWQBJQ0MY=0D>M8hMNBin3VKTe4G@QRCod55LEeRNY5ZPKNl@a[h@PR28
n:PNLV9E8p;]XfdnWq<mD]n;ZC`27F7iVE=;n@Y=qW0>^fa]H=dL5Gfg7g0O3Ic9
Pj2FM>oCMAQ1VQecDEaUY63iIP?WA1Q6mk?A<pKn5Um_eqKcZ_hk2\_QOD1KaObE
e1aTMQQ1M[DmdY2EkUn8e\DY^\DG5M:N`p?c2TdZV21DH85:SFa0dJ72Md1>>1JI
`K?[mpW;@KcZCJNAaYDce80R5En_MlEJ5U>Ji=kRoqmZ7YQ6pTY=A7Ecdhkl]`T8
d\J8D>Z=qhEamb\I\6<RWMn:\8AH7plAUilJJ>D:R@LFVi_Ua:[4o\4N<Ca`7Q<_
i_G;TLN>qM2HF;:W>NE4a3VFVL>iTj[RRM@AYf@8N>]31CPNN5hqGCLL<2QWQ]IJ
Xj;\_bP;BSCYFjA:\n^YfD_F0Of7X9p?D<NnELjIm34^5YeZG6dHSGO@9e8?kXl:
CiAgDPQ6Aq_?PjhD1q<1mb<EXcXRfl]U=TZa>PBHnSVKeSSF8;53Bkck`gLQY^Vl
Sf6K?dUP9iDjTKVMLfq:BkI:]RpoBDTIAqF=Vb?c4pgoL1mObpL=[]eLQV`6^Hc`
_LG?mL6GZXeh>@ZPQJRG2jZ64jL]I>fNaY2V=Vq^nmg<X^qe@FYFD:LEg08=nA4V
>jYR3YcfIa5fTLIAJODCN1aSji@Dl_joilpWY3R<b=dh8\145b8>^UU3c7@WKlWn
djbGP9]nKJ=?F0X84nITk4aK^Tp9<DZFNQpP=H701LD6_@Zp_j>1Q;hWZnk]c<pE
VdP[6012Fco88afgde>B=RdTgn`1nq3JbGLb\Q\;4k57qJfF=YCVKNZEN3<S3PH^
k?Io@=4M9>9p6hHe5EUDKdj?aeknH@Kb_c]K^M2>9[Md:a^f`<G`hQARhcgn5@U]
LJpndfU786bXg8S9hq=]Ka>T7B^9I?\B7`lEPb9^E;]Nf=Zkp8Vfl;QYbhFhgWUp
E9YS:nV3<B2kooW9F7HjERBBiWhUT?q_PMCCL^@I2p?3>^:3LUK]n@JkN@1BX7T=
=SjBfRj>:pG9Q[iN5ZmNml@ao9=Y^kb[Ge:i6g30ofT0^qHLZa[`YqO3Bm@cp@QF
DZVYO0aNmGBdC6dhQ=9>>B?EQV6F9Z=oJ0^B]Nm>ZhFHHJ9PCYU>Z8XaLhF`mWP^
IQok[a`WV39DEBXTLjH[PXQ^RSnPSJ4U7o1cn:I]MlF4SLVi;p^9^W7IaOP2Pe2a
cGEZI3f\^O8g?gjA9V\n`be67MRD^nN6`HHUjGVeGmEZ3AeS?QdnX4^m3OBNGj8P
ImRKpC_7nUP7IjSm9`:SiC8KOA`Oa`eJf[SaKo2Cf@<UmcKcOSmoG]e[`iWR_N5A
>MV@ID92F:]`=G_8]=8d_B4qMcG;nkkE4MkA=CPa6\QcRj]kF1lca6@iKWBNhaWf
gF8TlO7?UBR`8i05\dK[j<cBXHckfnh4QY1J398=f1qdU3eN>EpcH6;OnUSPCc3>
K3PVJSj:7o<j\P7<d4clRE:6D9=GmfK`PYV^X2PEW6OnJUK7Kl4[ON^VG3HMQ4:a
gH@UQY1XmB_=XBZd6Xhl@HNqOhlabk:bZ[\K02S7c3m]D3qUjK[?[>JdP0l]>Fdp
=8B_RKXqF0Le;CqWXP;ShHKDRfB;G]JKn5QNkcNRY=3oU@PK<[o\936<YDLImVG3
>]i>:b^Mkb3ET<c[@9;IIQTG9^5<8e0:BM3NT7_IY9?J_LmNQY@f>J;o5J<BN<cI
Si@H9RX]_J6EE<c_JKCgXUcCN^S<?mC_Ge7pZc[?4aPR[RRcd:Y?R>Z\`o\_BMlJ
0Mo;_XNoVO9e=cf4iF:OT:Y5@CnEDE8cKf0[>VglP7oT0dGC`3RlRepY8ln=4kCZ
oh7CPb4N7HD3hWdaBhJk6GnU8IiZY>LLiXA<cUG6e9\jePhYY^?kOWK2Qfiaoc1H
HiC@OO`9eq`bcid;ag1e31X8cY;EZnf8EQfKWFUURU<ARU:WAF]BUSifNoHH:af;
6_```OIbDDP:o3:I0i@[>42e:>[kqDAU2Da4CTd7ScZF@D=ij7L\mkH1g3`0P9ol
L`KoLPU[:QchP8LSZcno]j:aA9<QRqm?Nk5LR7==kGoaNR0<TAS=P_F5OWL10=78
YGQHn6Ze1:Si0M;66;kSQ\\L^Y3cgaI4b^NGdT<j>:UE7nGlALIPdoe5GLM6\07[
@1q\>JTL5a:RbR>c:Ld9YA`CdVlE=SA<8<cJUmje1qS5nFPTnh_9c4AHi4gk?OTX
Sm=oD[_TYipoWK;]>LX]CdKCa=5R;ER\@Nm[dJ6:g5=i1[le3E51P5qjcU:?ln3M
h@8eZBGe:GQ]6i_4>:X;LL:^L;d37]Fq=hhT]dpRIWS5n?`jb[?pTTm^YT\nRVYf
]AloG8V1nonb8Y9?jcV4B>i3H_SIHep[5;_:LXjIb9M]ZjVZLYD;ThAIcc89I8SM
HC:UM?N07q[n<gD>;BfeF`K>f8=SIU6H94iDONGQQi]1Zk05N7>dp`c9JNZ:SQ`\
NTH4mjPO5g??;UfEWA3Sghb]X60?B=`q1bPBbJ8F\b_[;UiIPj8cTEVo5kc0B7F6
BM6Oq;GAh?j^pKCOIlMXjj6>4ekcM:^=>>QH0aCj`R27KMjd1P[qhiK\\E6q[P[?
EBqbn@6@@3Y`fNbo0Ka?:Jpd4W36F4^[9Wab=N6=5gncS_<5P0=1^:<BZBgTDNfZ
b8In`_\4PI@?T=\X@b^HQkK?UBFY?7M3lFZd5Xa:AHNd=BVP;?q3EP;d\Mp3oEB\
;fLpkdof5Go2LJhEm8Wm=56qZCbjN9Z=:6KIcT8ioGNRED]2O=O6jPVLNXkbPaLK
\j58C<3oqS4RY?889j:h;3d8jc3ia^XBFK?Sg787D0jnm8VGdagU2^HNh03jah4k
@>mQ1J\fl>KhCh5HE18m;GebEf@WgQ2ISShSH3D?fCeqgGc9;mDqnIMWVW7Bq?[f
MI^;q^A8]:LNqiD:J1eRpOijM_cCMX9lgIcKdAFR]:<F0g1eBFN=RfZYKKgG1B4S
UAb^`6bh1<K3h_bIDgVolHoh1QF<flk]S8?QE6KL^VI9\SSbia7]5U?qUg6d;:9q
GBPQb0]`cD@:97?JAe4>P4po5i7nnHJ=1RQ_MSScN>C><VVMJ<p6VGoU?SqBV@E`
X<0`71JnmHYBH019;1_Odlco24B]]aqJ;hM46XcW=ZP`81do5k[gocPG8]SRo3`1
IHqOh0V?hIpgWdchMI=8U`YT^VJg;MMTDAdjO?mOeqNhNg_2@LEfY23Bb?hi^:[c
Y7V]b;ba4:7>?nV<PV\]ccH4l7\4U>lk>qf91IgUF$
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
L:jR9SQH5DT^<[CDAAledg=UP1b=SfKH`\556So<AU9TOl9f_7FD3jo4GBXbkoq[
]mS1876:Yj9_e[5HZ\WJl3m7G5CMZk]70^?DoJbBXpI10TOU;XGc67lo:oI8BdQ9
DdKl;mSaYqK8Ph9LqMA5;ENSgg:dm2PYn_=dePl0>mnnaO2IZq@2>j:8:d>N7fB>
K=OHSSQ<pDP3LaE38_MHT82;YAJVYpld6hM=hkA4\OQ3@5VIC_7=jDTAjn@XY@F1
p`c>cjRZW1i8^=dIoN=8U`2_A4@Aqh@C;5L?G4\>Gf60=l4DJ^BNDECjUjLXG]kA
bq04ifBDapEYbILYF56KZJ_6[@36m3hcS;K:N`43gde@QhnOe;PQ5D[ZARY5DT0W
kpd:ZE@8;?F5n^FFCfIGH9oCR[W5Y]]9^Z4Y5:dTMmIIZ]mQSWqT:diMhg]I@:_N
bKM]o?0HKF5VmWN=@9?Ikcb0<7N[C<pMWN;KnEpo8Addl[2WEA5f7e6_`nGTgL]^
O=IjHSOYK10RMhTRRg@jQG1LbI3<kZ1;W_CUTF6Q99bgF3;@m9lOi?DHnifnbpP[
HKc?RpLCD67U86o?ERo[TY4\Ib;lHkAaCdiDA3qMGIV>`;\0:M7]Gj:ZBD4DYhk]
fTj]2NGCHOX5S\lIB0d^UeaOlAO<d7538q\^g>ND^@T^g3;?boHcflom0?qWcbb?
m;qm<X=A9hqCVE:JgF88KGL]ladA7@mIQO4SLjG_g@9fVRBaJqACgm\]mqfREdf[
QgG]DHfRf`;<0FL\P=2?FBJgcNJnW433o`QdjRB>KYf]8APh]p:Emj677SC=@kSn
YHfXMB04V@6@PkS8PXgd>\`Kf\VQgP\hlYpk47kDElGZMXMdn>Z?^ngaCV>f03Q1
HfGXogOY3_mGK@qJ<a\OBk6Q^a2hC^gQTi>P[0YMXY0IG8j2U:Lp[Ce2d>eq``C]
jh678gTZZHXHM6D3QA?KZXVj6XMNnR>ZP4KWAY>8X1h[;TX>f3GOS3RffT`jQTJD
ZA5U>BdJLCe_llSTYX`qEoG?DDap6k=92OT[UR6434V?m8Hm8`_nGDG=g?U0R5U9
LT>Dc2hXb8EN7ADTIakk3c`B\VbL>`_8eLV4bXllS`P\7Y?NpkBkdCfj2VV6MS46
_[3Cm]A:EIZaPg59XG>^pkd]WA7J2JQj5S>BhQE;=kGAjDf\me>cij\3TG4XI8m]
0Z6>VGBD_]93@<<03XLllYi4SfHO<J<@G11pbV__3`YpXGF0gP=L0F>H0E0g6`V2
p?dJFQB0EEQdPY4CN`oK=8D243@gmp\QM?62np1^QJeX^qQKUO7^=[CLDNhRWNFF
c8X@815^keDS1=SnpADBFcA_fd7:=dY1^MY>_\3RB]nqeC0Y2\WqS@PJ[hJpaOFe
P^1IooX<HV__Vm3N\h?d:21KT\NQ1YRg3n^dj9K0nS1IBjKnRSajJ3LB;[<pGl2R
NbSqIg@gH<L73ZThIjOl_2@IIZbWd?N2B@Y6\ddX>P1CpN8`bbYHId^4j[`Ga]mW
9D9OHkCe]Y8cB61NhKG9[ok6<pYIN[m1QdmK63>gIA_gc2aeo`W5N83Uj`RRD?3W
nc5:2?WlmnHREIKS2Hqe@HBiB9gmFhQY\VYM[H8?^f4YPIa5biQ^S?n?H2BMMe]m
76KLF7SU=N\Y;JUqM^Y<A]Gp32V4Q69HgIlZiFef[k7OQK;kn;:6\MbGf_3gOTdB
Fl3g0YD]omqodl0kIO_Gmp6JmAWbc82I8Xn>D`<d<DBmiK;L^7JQNIWEKYk<MhWS
]J7ZnAqWHkWfDeLPnlm<mYO5JNQDCMEJ56W;JIfU_XbKkR4m@K^[ROZch=g9E9RQ
=YMBfIj<RS=I:3q8lWi@^5qT\KIc=pU\K\AKgiDk94\oH?F7?Yn>9LWXD4B:`>>e
aLQF\;gJ_Up4IXoQoc^DT2QIoKO0\UN1gC^C??^B;4?5Ri[CT79iQ=7qgQYW0bXI
Jl^f5[cUdQe>gUlUg`nUl[jPjIQYakk`00dGGiKIRE8512nmpNa`:TF7E4WmYc`H
SGPBkRRPFOE;377kGG`nL_bOn=0?F=>;DBEqMQV2\A9H_?fWUSeDj55Q@54:I34[
OCMlE`UaJAme[M<h@P;M=goo`0`ljV@6pKbVCI64q7SjH=EJ@39p[P]IBaIT[@=Y
X4d?\KV@djZ`K;[Y]<W9=U5F_hLMmn5ID8IfLPJ=qg;12=P]I1bEb1RBbC2L<68:
o`o]1KSN`nO_Eh<W9\R:F2L>6P<@k;6>fJdJ[8FOU]^ahEjlCeY0qT`Ua;>EpiI5
_Ynqke>jBSUf_Y\XFJD8W<YVQhZQ`4DO;>^Q?eNk_fo]oTgBpCflidEbi;`gJ6DE
\NjDdUd2l1Kj@9l=hN<J4akOGIXa@p^QQeA\WFEnA@`lcIoFE1VYUD:cATpDVGlO
fScfQFJnXdN=>CX0Q\3OW`>^5d@<91SEV?NJo2iDQRbnUbnCS?PqlJAYd=;6Xk;\
gD0H\29]Wm5B27Wbg>EM3_1O;5kcg[bM8]2[f@NWdZ`VZF`FqHF\aYiWp57W?nQZ
]Imq52O7EMi@fSOm4TXX<hM?HFBL9g0Bd?RNb3DhEkeJkghc84O6Nhn0pkSRiNIM
Z2[:YP;ci98]TcM<gd[`ND;UI=Jn4bQ\AcdkS<aWkHPOonc];PZT906g\7LT3]bP
n@TPqR>Sl`4HZP3CX9ld4[lcTToaKn6O8VMXOPT?IN^]=qcIi8fhnqBVOQSi$
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
