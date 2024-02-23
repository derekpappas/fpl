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

`ifdef VCS  // VCS Release 6.0
//`protected
aUX&5(4e#ME_=Jg48F0^(?;e9U64)DD?(g:S8_fX=,LfBd.S4QK3=-<)9Z:U,S5@
IOLA1P-d3:KM_=<X4N;AY@dI[9\B?J40IT=g_4J;F=Q4f)7(UI2c#d?<:0IW_Z@X
;V&e<Q5,7C[#A,W8S?gYgZ&53J-(:XB-TbD[WHXGf;UIPfDHBJI=HS/2?+0.DJI:
(<Zc8\Zae+HYJ[D]Q>/gN.G:>4>R:[?/bS[JU#5ZbLG9X_4gP)^&>_eI7BDG;Y4U
J.eX\ZJT.E].Q#2Ld0F#,fcd5E=d;C[VMX[cgI&^=GbCR<<Ggd4)A#.N:_C(Q+#Y
@YBA,3)]09F(7C&TUbTUQbFP>A:DfKNJ2:NE-Da[CM2Od(W@Ff9];LBg/a/>CaEP
IMM-S;>AUT..93@>SL#Z-B8XB5,Tc+f@L_(YH=)DIVKKb8AOI_5)><@Y_(0.SE._
]_IR-6PWT;DgY4?]8]L;@c?ZE&0/AUS0ebP.FPI+VW?0CJ<]P/c]J^b;,S-P8;Ce
FeSMN1/TcAVOa9B\NLBL(SXPT1]G4\0A;#@JKfCVLCg/:X@HHf7F4]8ReM<_Da9X
@&Zd?+^f6\_SM=bBKEJd6>/QeN8-BcY;#D_?+=GeMYb.KaE46H&\&/&62GHd5_Af
De8B>BgD5/G\5Q[.e&fA69CaAc[=+9&@:;dID(H#J=C\1cYUXJGQZR1?5\Q<>gT6
]V@H3O_.Je0eSc02Pa/RE^E^()O5.;5:VX/.+g)YfXI=-WPR.I3UFX?Z,+>Z7)c]
@gNXMI^V[V1c=V>A,-^4Mfcb0B_JB9JWUMLVf6PeQAVDV[AA;HOZ@>C2XB==FU9(
ZQ.b(@ecNX&9IfT-CX<NUM)_7_6LC?;E:Yd\eN.BET:P-TOF14@Dg\Wb,Y#:_GG4
P2ePRO7>J7AACLbT<(6?fYM^82I(Q:c[4N8H6#]a)A6PTP@@bWYUWK(]]C#:L526
cNA0NcM9ZY&,_[RY?b4>Y)1^gHZaEJIAEYCOGK73d]VI:1I<d@?5e8-CZa>gZ?He
6d-J9_S4FXS3DUf3CSgM6]_7IG]]H.R&DbOR@_0NO5cQ.?);[U3:UU@;;]bF4GC(
2\JHdJNO8[):c-O1SKK-&I67HWR,6OQXE0WSdB1fMCL9A[)Xe96f=GUg[gH0S0R:
gJ1D=Y:e?APM#gMRZR3#eFJGbfb<b+GMB#1gUV&]N0eQL@dETYQOcK>7/GII(.2?
Z99C2A):=6#Dc>@c;:D<Y[JBKC1fLd>Z3Ig<4CW@C</<8]M^GF:BIgA5Jc[9Hf>,
9YLOS03TA=1R2-CY#N>TTfTeF.ITgJfR[PCBIC,eT0-,1)7S3IP\Y;Je,?KQ[@:F
D@SF4RIGHO35C-,ML>-B;L+9RB\f[JZTIR)9?\aSOISM<=SL)+.=P\P&SC+gOV]2
1^TBPMTBJOJ8A>cDdeUe^KfY3M[ZT^EW8FL#SCV?VTb4e0V_V3&MZ=\37DC.7^N3
gHZ3Q;^>/0eX+K)_/dM=_eR+Y^[,T&7X-3Y])L:VcW7\?<\KfZG/WTTVO80A(&B/
6#4S1MB]D9Q^DaE/7ND0/J6U(YM]6S3?US(e]fN++(\C9_Lg397cS@Ga_:.^EP84
fEKb17;[7OgX4]FU8c/K>(49Ge>D:^[)O4@4LbSDXC;=@_EZG<K,L=;6=#dDL2/R
:P/PZ]PN(Nd\Q>D>(#][ZR=3R8A-<d0V^DOJcUd>BE)0(R[W:@U+>+.T:a1,DHb2
NE5^+U@>YALCI-\A<T^O2#/U;F.Bg2\9F?V@Gb]H)P6NH2Rdg-?X[/</&a9G5cYD
/FLX7BcdDa>#A]=+H=RaLcTbRC(8MWf5_OIEHI/e3ALMPLJNVYH,8GDbb+V-0C6C
3dJ5_QK[e:=R(L[a(J[,@K,dN0bD<=H@?$
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
5Q9PGb)4=_&V).[W,-(=<XEf)#Uf)?ba8ggM)Q-]0-YD?Ie,A(J;9&Mb(0>.,)CV
R0[\Eb)QYC7d/F1\-HS[.JIN>fH/4Z@Fb.ZQ7)?8fD3[@YXb5M#3F1PC7/>M)\&O
\+,+IA)_S/W4;f;Z5CfYZ6(AJfN1MUHNNPda#POX>GY#/HH3Y?H1TbH(.A6Ke4M3
)T^62Y>GL)&;;Z1J#EU8?HLB?M;SHUdD-eSU-LTV@=EDS2C\gcUS3T]\Q2@4\a96
@#75.IIU^/6f\&XS04DXS+:X3@PGK;AUbBTY]ZX>+g(W\8A4[.:16XeGL0.>I&g/
YE2<^OgBJ=cGJH_WXEeVf=SIJ7XXU0N6/?F;7M;KYd3@<TTPE?2JL;bJa<NABQ-?
]^Q5B-EY+b]WYS,.G7;4:\QH3[ZW/W=:]HP_1BG<X=K;=?=S2#C[FXcdNZRXNQZ[
64PIcT-QDOQJ0&d?gKY?;I;gDL:6Qb.dU[C@?cI,I-CbES#O4Fc@SNM7a=E2[MZf
0ERY;B\R/Ig/fID2:@/YNeCQ-]?ea))\fG2L/+aLJPU-<^Z(Z#2[99.A&Z>+R(1_
A7I=P=]<@;=_PH=F=71fXRBH_OH>Ng@Q-I+d7P)SP0Zf9M/Q^=R):&[4L&G7HW?[
J/G\J/]T8SRf,.Y4V@c]9a1HUXNZ);.5WA0((Z8I42d:CaZIgLaG(TCI1;]X;/DL
P/Rf9BKd=cYaPJc(]8)U8A<)UaN=2##]YDg#QDW4?4ET26ZeGK,:S(8#W65T?1;;
79308?7ZWFO7IK<2:VFEL:ZeIdJT6)^DIb[FMKdKYB<4S9Q1;(L&f)06fJ)NfUA-
&gY;676L6SE#A>efCL6E,PF/@?8X@G6=(\^I^FV3,.#bXadNYNV]aeXe+K#U8/[Q
,:SE4N&M_[YH6I1K(F,.VVcJ(+0_WUZ-B,#cK,eE+;Lf?_fW6+b9<,NXLa\UW[I9
>4#Z/fCLRdFVECTLY7>KP@cT?DBMQC+X=I049HdUFX[-]4FF<M)F2)^fN/]cP]AM
D_)J,Y@7bIMdCE+_WSFIbe_T2R@QV3GR@5HceBH&?IdO9UAY7]>Ub0NYDHN36YD@
^+-7IT:F^bHZ_21^W7DEMCBPe4RcEQcC9,(F>B(gQ6&O-]e7-CT3GA(A:bI4M?gD
2Ib=#ZWTR6d#\NS5(3E)BOIH[<GR@#)^DcAS,W>XR8+gCKB8:801-g9CR0]CMH=.
]_P2-?&DA?^&_5JI]PCc,PN-&1)aJ\&O[OF:9^H#;X_bPg;X?V;SM9.L>QV5MHe>
7P/f:NG#Y9[ZY[[g7Z0P>R3Eg5(?PUHL8G<20WHbc+#:Y-QVT^5HQEFK46&F9LfG
AHHBAWVDBJZ).7,/):A)/(>SDP=:UZ:.gWaFY:Q]ZP70YH&?0X]eTcN:DV.K0Z?]
XZ6)cI)Z&FZ_7#d/(=<HJ@CEZJPI2fJdA##Y6gP5ZS1;7@0G+.7RZdST_7R?dJ.V
gQW]4?9d7=([BNP6e2P8G^gKLdKZ@=Bg6db0Dd\8.6SH)F9+>=EN]LC]+3K-(K;B
89O._+,@AS2_8QP8MKQ)SWe+6CJeMEd_TRJ/HU0?b3T:[RG->4FX:AP^;e3Z+gB9
<&@bNE&]=4Y_b=37g_fMe(9)d;Y?[McWR0OI\YY[0LGY#\:A)N+DKc_HRIC]OESZ
e\aQ-J5-Z-aIJb-UY?6f1P[Q\F1O^IELagA0OROO9acW,d\#^CVDf/WgRYP^B^bV
c#M.cU5]V>>_46bKR4A,3K>Ie?&QJGd?PBQY;YEG/4#H(SNDBA2Z8VN5d^]C\_+3
WXV(eaVIDI.)E<>2E0=Q7R]<S1<U,W3&ZQ0BIA@cS7N[43C1a3UMaGCQ[2R<H]He
#aU_7U.1QDfb;51a>a/M[cXbU65@T1EHHPM)[g3V/&a,73O/]df8C.JYR]&F(eKG
M#];eJ/XFDIT;]E^^#C7M+SI=@db;AMH5LSD)6K7W>#41;f9HNKH9I-T^\^UCP.K
YcWNIW[4K=&La+dJF?ANN4(SA=/FM^AKa<=N5D7W35OP_8)SH2]7WXM59XfE<:U,
X&OH>_&6V.TQ\c):F-cW4HTRGD]V:G7J7d\OH;LSaf:<<#M^M)_ZG#MWef?,),d#
YHeZ:ZKPeLC0,A5J_9<XD\8_JPW,U34KUKO6^R6:M+e/\.B,0ZQLCX)=cH#DG<N@
=I<RPXGZ)_+:M0T^gJT1^8AN;]X=AeH@T2+DU>DcO3(80V31-TUH.FN(<8;IU9eL
??W4Yf+2Z_SKH8S?gV&Z^Gc-dDA+RDeP3+P+G?dIG<75Y\D?d=UDXg=;FT;b?b?1
D[,4&BNMDa@AW964_DNED;Tf^RKF=AC+MQ>^8-D)P2/0NX7JS@9dG@]ggQ?4CI4R
dMg_^H#W2Y&JI--3MBD4;W31.Z;G=20WLaU))c)d5A<]MV.Qg[PZOL6T#7PdCgA\
JE@[)1AL>,I4Rc9NeU&L30dCR-SWH0I^@A^NA>J4&-=S7.9CJMZ1.SOA)g=#edAg
0(OIMe;HX03E.@>aeKdX+7[4)99G6a)2/LZ1O7XLdF(:eVBM(e,U?@cP[B&__6B1
#b;7=0F94/;@BUSX+B;A^Z_#/KG:XfB4?ME&F30=^1&Hf75W@,Jd2XAW6g_(b=b5
3;=-Qa=@>\LXYB7R1B.D]<);E\NL+^?<G\(--ODaI[2:35\1K#U[a&BT3N,e#b/,
2(c3146g\cKW&Z:f+g]6[RV&/@]@(^/=H\<eUD?,IeK09eCKI,?gedTL<aP;49UJ
=ZM.8Q5a4HA=eWg=bPWdOc&5e^WegWf\WbOL#S+@WCd=aBP2<N0&HQCEI.(.:XeS
=a1U44O35:bA24@&3gP:bN9U[D-f-RJ2A?Q7(]+Fe9&1Cd]K+D6VMHNM#6gVKCX0
-Og+aO8@a&OL/deNCQB[\E9&\Y.J<1[CdP,XdSM&g=[Df#)UD+,/WC9/&LB)Z)+]
:<^gc3D2=;QL0$
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
(:.U=MEZAVA=<U?]9KaC,4M_,XW&,Dd#-;E[,F[,=cLWd69;gZ>V(2D><?[Y9/Bf
;@c9VTK[dfS8#c9YT2T=NfA#=PYN>L2&-RMD.0;8bIIDBgdMIUA[Q.>)2VcFVF6d
XDQ5UKJLS/MRcW,E_Q^X?JbF:]2CI=8P8(7I35QC?5HLc3N4,>C4G8-9SQ;)F6#&
bE-PG6FfbfU-U&851E4c;RTA6Q^UCfV>G3=aT9a+8R#]PNQb6Q)5N#VWNW+I#R_S
KK(VM]-D1-=[f/VBX2@dVL7(JLI);))g/T-Qf^M[F[U<QVgL_(c,^e;6HSV8WLMB
dD:M0-C(0a1JJAV(X-(7C6(Ae69c6bb9.PGIb(/O^bN^RF6E4N9f>CY0)a8E(6/C
:B?eT+eVAO_#MO,;<AL;M]<eGHAVI&gS\Da,(W-9^d>_YfS=7R@c&.N-@Jc9P#;D
Fc;J<[BI0,:__T0;B[L&Q]I=QF,RM7J.::7M3(K07<9KTL9.0Xb@8U(BQ^a0DgJ,
Z(d6JD^6[;L#/#@ff\08C7.:9T@e/DCBC^(QHY#VL-;:0S^WfAT?f3AFA,c8/2SH
b)N7HfL6e7IV<R]8MC_LJ^YH\:(RF)MG/,9693gK?PN=NK]HOd:5PEB&0DEL\]W.
EcS&#5,VY)PW;L=/@@f_F&AD03TR3-6:2d[SR>_a?1=g@C)gg^g]3VB=IgYfR@G7
Z)#]AZ@0[[SKEde:LX0a>fdc[N:Y2(XCY_>Q1^_1O\?0a54]?fEYRTb(-Ba?W:2a
J/DW4C:SW&:BQ9Fc5J\L>:3?\(@aG2M_4UT)C,9(a0C3+=-b/J.+4bP4QB<0LWBS
@(Y,:(^H6N<S,[cC)0eFB1U<+E7eb01@)C5c8_dVIVDGPUSUVM-5g:K>]Re^/IZ1
>WF.FGDc^RCa9V2<16M[HT:/<]AI=ZQPEM/6.JH60P0]HBO+gOMMRH\Z5BLANZ[^
H4gB6:9?9bCF_^7\3)[=/V0ZEWF@=-_7&d-a;f<efFY0Za^gL:#^,3H.C8#,=gW)
SBQ9A_QSVCFRN5DA/^-N[aU?Ja#H>CY=c9O2LLAA@aM:PG-=^:Q0]PId8Y<[+M8.
Pfc&G0;A>@E4#GU20)[-5Fa-7@@3ST2:8/b]7ed.=02UEV+)T:@=Ad\aW:[(]J+)
/NR?d7gNEV&8YXZe>b=T)Z=KSFGe8/REW7;HJY)]72fH+;51ODW_X7[?ZZfRNcWG
3]fT>164QGQRc)g<df3-_De#\6X>Q<(V(GIdW<C37(J21g<TecKJ3X[?#eO&>-We
?X2_X<#c,b>;-IP4MNEQ7]a^b>2MVDE4B_C#R<d7Y&>AcM:>56E&;QA:,YO8]S:(
4#PLC3Ma_8U3LKeC80/5CQ58U3dEZ;IV<f.AID9-fX=)9gc>/&>\-JBXgeK\W)e:
]_61;3J8\ceO,L@K)cgS@X^D8X8_g@/B\[bZ&/ZEO+I5ONP9a.IF7He#gSH8Af[M
.F&=B)_&#B)IQ<\@8\IJU[&5<=W:,C&LbV_X<H=^)Q/[;>OAON\a#T5QM].9(71O
AI+f=NaP+>UPgO;H.Z(+K;1geVXFVLZ=^F(JCU/b>T?^TL<4)(927-IE\IBVZR&&
?2bBfNR]_XREfG3eIHIbR>+/=O[2bP10KH:bHD>,4@4]PO4O9Z9R2K&?^D.V<Ib\
?I&d[@[a:aFCXBbf^6=#I.e8/ZBWES<.T;+3\,I:C&eeGQ+\UFeZYFd_Gd(1:)<d
=18(ca#G#&E?RRZ>HEUWab)U5)6&XG77(=,V5ZgY=-&d92_=EMA[SGU1V-ZZ/MgN
[01e[<IBd=04.3S=AfTK=B;ZM,MH(3644gf;c1=KB-MP_V5H;dRD;2:(e_9?H2bc
M>YP;=8](=\_cF,9&gYSf.f0HLF(/g_G#8J]R-GD]P?++XE1BQ\)L(]]&/b10Yc0
1SGUV-[OQ>4^O#af,FT6,ZG^;Zd>05gSbM&eU@/X0J1XUZ1cba[\&[#GcE?V-aeI
.S391GU8NMPGFNE=c,=F[1R^cR(_LD>ABIfV\3-?70G&YP3JGU)UCB92FX3.-.cT
AcUCO68L<5<,]KP:O&3H[aO)f5c5b&=f#>.XL:7>eP:97\\=Qd\:^F=R94T)DQGK
Z8B_@b.?1Ue>f-+/)0)ZC<V8.63Q=:d=WR6L>\Y.Z0dQ_K63:>I>,98<67\dJ05<
[ff(8.^[9=7/4\;DQ<g;#OOR_4L7TJaO>bO\VJ3GXHe/#=?2daga[(9;8B2]^JB)
7ZT6#I2be6,#DKc]6EHg:0).#E=S]D/<7H61],J<=Z=e#;300]e8^&I+?<.c(_F&
V?V3L7INgTP^Q9Q=3)\@:/:051TQ<?#IPdF^,D+YDe4E3dL]@40)_1)J5F-f@4U.
3Y]#V&aP>0/:e20b;1:<Nf-d15DO?M&>JYVTBg-&Z)+OC:GQ63DcGG-dZ5Q^C4I6
ZW0E,K2SL:8U;.#<P-S:Y-8,#_9SGVGeg.X-e\[JGI,b7CGIM>GKY@HdK4Wc1Z[c
=_bUUHZ8[4M?f<Z,O?I(Bc)32)-PN)E^D\)Ta0eR++UG:a]9]Z[9d#(]^OJ=[;GU
]XC,b#^bX4YRYAQIW,>M<Y=5G[La_>-b?)2HBfOM(b(58^\&IC2?LAQf74-15_K]
6[gS;A:WI+AX8<.#bPUS3I_BX\<;:4+L#VXc?d4VYca/I#D+W1WaA)HUVdKW&3G=
B(&H;KX;FYWXAO3Y^G>EFfZLEb4Y3E#FN_1Jb:]8g/^X:>KU)_fab#CaZYV20-VM
47(f?>0g@(3B5aBP3B4(MAf3HJ1&-.6-HC1QWNaePM&H(G\I_9:23<?N7KQ&@H=]
67TdL>U&W&@aR:>P)Eb/U:7.R)2ESUP8813R&+@.eb1>>U>7=CC7,<[,33F6KUU8
7f]C:X68]M0/HDF(]7(MM6c(,=2E5+bLd=I_T9\Ef;31;1=cBUNc6?1&GR3RY9+e
:PR+g;]_)R#TG)(U?b&;T2(Q@Q&b;HL)J=URP)-<4D?g[fa(C)ZVP1\=[G.g[2FB
#)ca9]ge=&8N;W3Z:D3.BU251-;JYDUZ&?.;?E5L1)b<L<I.TCNK^f-Zg83aGE@O
SUC&0Ac]UbY1\fN2,GACI2e+3_L-I/WH0?8fPf/988(I4KB/?#S@T74-NNRe?d:(
(N<,UD7-VV0?K7^+(bAW7_YQa&e,KA;&HIcaH+R389/>[(1B.@V9_KR1@FbaWg1C
Q/.?@972LB4cH^Ob1VB^2\>+bC-Z2YA)LP1XQe.,W<&-S(3E_\PX2QE>X&5[L(41
NY4UOE_d;8Qe5((6a5OdGD6d-B3&;:)EJa##6=0+Xf\D2g#Q1FIY/JV[/PD-_-CY
YdQ91TP+(dO5(O8)8c9g\PAB3\?G.^(ReAK8881R)MRgOL6PG3#0@-_a;.a?1(5O
62bU:>8EJ>X[:W@#.d4>_E>.C,U.8:;RcYTfN=WK00N((Q>4TS+1O3.e+@(SdHf)
JYe5NCLP>_a0EI?JW1:Z6H>L9LY7((L>d>a2JZ5^/I-d.2TA1&<Z2_XLQZ@H.\W[
NT>YU[(5=@_FXX/2Fe1SS\>IT8O0.[e\G((C0#OVBR_I)#>HXUbgS1I\_.5X9_(\
a\RgU00W:;.fM8L(dARY-,E\C=;^-R2W-B?Q@RgM-]f<Gc?3=T?a^?OLPKH98;?[
>7cL.X<NNRU4SH6VW0@G?>MD;XI\7N,U.[0\DRUMO.[113_,/:__Ig(ab3>X\4F<
-LDTVB:[@_AH?W=c5cO-c8=XC]A<:PVRcZdT074I0W@6(.QN:HB-Z]Ub2+W6Q/\[
XHgV,+L-^=6BG6f6ADb@5KBH&BR4g#E6G\8RTKDBJRg)>Z>9HVXVc/a+YJ,)4T/M
R82NZ[;U2K&WO.F-)d/A)(<HD=TP7:0NFNW&-D2-c8Ud>cICW5WHf3JZJLe1@-(Y
/G)Jd)=H27CG(.-Y,6;f(6K[F#V5;&D>-UKbB^(9bD+9POZ_YIM22.d;MG:fO@?V
/W5ecA/-[6?gS+b0J9/Z98@M=_#.7O>HGX#C@RbKR6/KYSc68\&eLc2##JWGdeX0
JAEA;F:(3_<(]EI>PTXGSHU;RA6L8aQ<E5T6A.^L&Z\O:FPNZC8XgL7D<,)F5/M1
HRCJ\9)IAFIR]g.QO8cK75Q+V/[eI8Z@YG09gF1O-;cV#cM(bIbbHJ.,dE4+]4AK
Q6OUc/b-,F+YTK.DA+8F7Kg-0H,BJ5;-.#(g5XD:-53VMN><P?=b\Ag^GGd4Hc\O
Oc4a;>F4GOOUT).,CCR62\XC]CSXTJXV4PaQ^+E43g@PHF+7+0?7IMI:;>.\.eg8
BHSF]YC3YW&ZAe:Q1RY-[Gd=:2GEFD[d4FGVN?[3I8VUL3^,/=Me#Z<4,8/LMFg8
&S[L(0K]1\PP@6?Z9/&>RaMW?cFCDJ1=Gc78R[cKI>M-FALf/ZC?;B@O=H7FMRU0
@@)YL#\d^S7)L-\V#DP]BGZH93)YDYB[)XEOJHSJ:QR[5UA1&(X85WPEV,?..SBP
>RM6268<L0d9A/6875@Y+2Q,_QaEbbcI2X[-BTD&I3dOZ:Kg8\;)R_HL=/.J>;[#
>QUJR]1K/b>)d&KD#+2gb-Z;c6S<-b>S.)#_Y2T4bE:eLRWH]ITW/GK=71X/M)KO
eV5>a3I-f^ebJXI04[OR?49N.;A1RU4-./If-B>FC\?BEcU]FRC\Te+)XK)56;G>
[-L\ZaB.@0B+T[\EQb],e::5:#/CcXW@6[W-ReQ0[fW@MD=a@<JeE5I^->>Xf=L/
+d/V;Y-X6fQ[CYP=9M\IR:\957&afgY[:]C\/X=SNO.E+d57f&.-XeGS2;OL:H42
HcEP_U9<dg)N+IA@2)5AXRH\ZCW:V_gGE[f0a/d.@eb3GK44CC6NC4?G[:?,<H@c
APMZ3V8.W-K5M)W>O8?_=TU/X5;T9N=0UE\&NgJPc>b/Q(gQZ6Q9+@WW]/I0:TL3
c,cO4\5.R9H1L(b)>Z(W;7T?X0d4?WL@(TQcU?JP.FcSVE2;ARGUT)W.T/g2,^S=
SP_7TI.)+DGOR0/G&B^),EbTLJXfX\EV2B?WR4P?0LFbd]7Y:.[.#HMZ2e.MTD(g
1[aA:[0BAY?0P<,_]B;?CK_c#c<]IS;58/4>c[N-3?E)EAN^52I-Da-+ga:,3a>e
8fPY1S)CKX:9A40S\_CB6C#VZG\L4TZ3)Q@?=UU^]f/\\V]V#[.07S,5WC4.fW_J
5Z<#R5E=g,SM&CCS#f>2ZPQBE:GM;HRL\R>3[:dC.0_b;+R-cFKOC:G[^G^UXJd<
8UHRNOUF@fS;WLDf5YC#Ae2YN,A43FeFL-=T6PNf^0HB4C@UV+?f48=/Z[Q,Q#()
b-4a0V3D_==(BI(=b39&8W8X/98fD:?=47VaQM?91-1d>-,^:B?_g]AKGQ&T:.@c
f<F1d2bW)b.;),e-aFb,Y(]f(R?a4.g</CM0JR#E@USGAbT4G(_cD)G((JVE3^S<
O#_DQ431DT_DXDb;BFeAbQN&W2IZ&DQ&UFFMDOEf)I7\,b]^0P-N7HHT?f+ABIdb
L8<(0IXIb:P8-:BaY]:e(aa4fO2X1=35fHgH47I(fSQH3.=NHQ#_0+].X-47HAgb
;5eI/BXY?a1]7YH0&b]g8aS.2VbA_PX;.4UTBgN-63LMHE[>?#\9)=KD[H8/]74H
##:LY9/(IQ?KM/<BW?TAf.__=_CYSW=4O=EaY#X=L/:P+be?;K+/d5fU46b[\]NU
Q9BS6><fLFZ4R:DQ[A,G2b(\\?gWeH?c5JZ)-)CW9GRG?:(D1HWTOF,BB7<ZBBCI
e-FDeW.E7g)9@CT#B0,b9<L4#aUVI58@+LD+=7MZ90L6MgKId4a,dLMegcG,S-H_
MaS7PaASd\KUP+8L=;d>_C;(3#JKQdI3WW5d1[L4AO/YLTRbV_a#BCD]ID\[]3dX
GQFC-5C:#g3:B)#3UY\>Q1MK]-gT[g=>UN9bZD.5Bg^1Ve0+c2agG2N/0/;MR6^3
8W(?C_e[>4V;1,D>7BI_cd^J)4W][g.(U1OgfQ1W7B\L.Ob2ZHdD,NTCFFIb:_@L
:&-,g;),;\^b:LQAW_UgY]Ea;,aZKQccPEHRSN[8:&6XO4,J>BQGde179I8S+RBO
+\#]Z<Y.CIQW8,1Z23HHQ3NMT6V3-fN\5F\Z+M/-SM=CN[P_Hb@PT3aAe[E@ccWX
C^=C1Gd+F:H6g:6bb:IgPaK?F01=?\YBA.@13]deJVB^=9M^fHdMBLJ\_N?3.XZ-
1(YdLe\3?@a+I@ZFAJ0KR1GbGC96C0Ve6XFHPPDH?_G(dHVEWO+-8edPaQAF4(9;
#4d&EC_Hc<3<^.;=_g>>;AX,4ZVI<dfD;TI\8();gb2?^4:e/Pb/]ZIW=<93LD8F
DC7BX.U_Z]P_DUHbAP8M=CG4K@1OG38JA0GaZFDBUN_@@dF.RVg-_5@K/YQ5L-X8
,JM04^OUQ?L93HZXaLgKQ<[01BaOX+_Q0/G<6S37R^HPS1g_^D;:VPXT9UI\a\PV
P0WHN4;0(Oc/<<2b(I19YF&.+T,]&7DH<8^gVNNQ[I8,XIPVf/RN>M<c>WA&(g[<
JN1I[9<^A+:;UN#a;d]bH+]US?,E,Q](dK7ZWL0XRbC\[KbCZ3NE17\W&D<@2N<1
D@e/?-fL^,SIB&JeZ@WUY^JcVRIb@Oa-;9QMcF_,4;=8Kg,?H.C_c3;P;#8B0_4g
[\G7L[+]^#.K]OdaZ3<_O#5K\aaDG>+Q1V;^ID48=QP1e[3a9C=_(MC4RH]d5T&;
3=N0NY]6<=BZMJ7K@7H-GLC1.HL0.B[;+4?&,PKD/L-:EU>/:YL\50U1X_P+W[(U
@G?WB&0A<PT2+b6Y-)6R?QO]DaR^We791[T2RSH9dg/TO4[FD#Me>U-gHGEM>WB0
/@5+4<)E/30gbOUJPP9X]^VZ4=>Id^dY>dS62=<DQRVH;NcMW+N:U4dKU2_.P+b:
1M4XYX#-;A4BL1;W)(2#JdWA\Ib2I&G8<L.D4T30\N^c8-5>[401U:dKI$
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
c]K)M2-:LMX@=?/:<U?O-D.c(.@5-0#8=0+f)g&R=BXL)F#aYcF(9Td79JCf-,DH
0A,d9BLGTKRe/9NV[/RC.\GKE(gTC1AD1DGBLIf[/\A/W9Q@((;_/;QD<Q0ZV)L#
_-2LZ?(0)RF]Z8>PK_U\Y&8XC-g4D8DF1N\SVcM_;6Q^QL?CNgANf?SW10X\44OR
ffZIR79Va3DeY,b:(&<eU/X/1366K;2M>^[8J+G@TZ+3UIe?a0B\1U9Z8\7)g4YB
JO<W<TK]#De5@2=);^Q;S?EJ<_S2UK(8SBf_ALYPcG.f@D2D99\AE_g#MPJ]G]g2
SFCQ=MSP45V]DH&LQ>M:89H4T<TXVBMX.E?dOU@]3?b0&W<g:V+^H@Cb=<U,QM.B
PXbOd\+Eb&Eb#bRdLJJF03Eb>DLP3E\fB6RUCa21-dMgE,;g6E>MXb8_X(Td&11C
JVZYJEbaRe:.ML+W&6578=M(@:HOOZM/(L,TT131ZBO)NF9;ZfCZ2HB7+d#WYPC5
cMgZ6dY&FU\<G,bZG+-g@H:3a9U-UUXb@+UMgc;^,3dVUD4.d>C7)?AOML_:LD:)
.0IfT;EJ=VeAF(PQU2Tb8F1baJ[PKQ:NA,CV4_.6>S8XM[fC>7O+Vd0F=e1C4NXG
[U/8J@^-LCCN<M9g>EV#@+655+d10c36,AL.cE_7G1SX1^YT>UUc\cUef.ICLe/P
dV@AbP,T-b&F1G14FY\Jg+Df_<_0cRS_ZF]e-PA#,7)5c_,]_cBcYP+b@QVgeXJA
ISP[5X=G<b+E:M7gZ._IX\efJ:D=RJYP2\EFB7V8K>dB6+BbUcA[C-e,<AO-)+\@
gVeLHg.V(S-E<;I2)]cZ;.8-0Q.HM759WYS-b14#QLb=b9[.^dg[&=SPW^4[Fg#Z
8OB7S8?+1X_BI4_Y](R>IMS#0KPAIfMKTY0=6:?^[-&AH;5JL8YT^K5C=]?Z0BG8
TXObCE1e:@A7IY0X;e)DI<DL,;W[[H-Pd2B>-/YJ&<I+4E)F;8(IC>.>;2:baV1=
6I;GIVfGQTF@_CT/^99Y.ZB,3\C.7XREE_DZO42Q[aDfKD++eTB1>2_^b=CLB_9#
)01b]=eOO0K;B^6ZDB@eY0CK#gaK5f0HMSA6<=Y1.?]@GBQfE&c+O+/=J&T+98&E
=#c#d?>]\H0U1Z\FN.d-G;\P7>cFXebC[TBGdZ\_KA[R15a5:FdU:J</ZN<C5V-P
4U]b+);f4ff5[ZZ;U2NE@>>1;F-3)a6U+#2XBaX9A1.L)@cf(T8QOOcW20&L?SaA
[K7bb>c&?Z.Ne=L+RG@RL7NNPVP6:,MA4M&b=bBLH9K69#<Og02F(c1A@F8THOFc
Ec^5X0Ce<[6)#3S6Rb3BU<R\KG,X^2Q?:Y-F>39++f0(f<_V8@K8,.SbcWVX4D5G
4@S5:)9\N;U^(X7_S/QSOY/geC2]_-)44Ff[30>QGKNdgNG0&W#]69M9R=T8JAI?
U&:+3[;?R,f,C=2D9L,+^ZU[9.2-aE#BOBHDDGCFXW)\.(K+a?AH&@Z2XYUOd_LM
2L2VeXc8a(CX[6Z&C2[5/K(AU&P07T.1U1(C@(a3YCdG#eX.5Zbc9J(HaKXQ2NNQ
-;NPd3HA31D9:C+FB,d]F5L;2Zb_]XV,N\[\9GKDDHJ28ZN6N,FOa)]]K[U>^eae
Of[e7&&X2\OX[[27SfN444@@)^:=\KUQ62J<@KR-T@6;S1VR#P\DSdI_5D<-gQQ+
Z,MYLe,]X,:C9UfEf[MU5ZQANWb_(8^1FW>R8<7,8YV171CVEH/WRUe<E]PbGRJ(
)L:]3J@3bg[de0,G_c7:5OOc#J&SVU=KO(TPZ([e>>N7UZN+SYQ(U#ME;cJ5CeCW
O&_5&Ta9&(1ZZ&TRW?#[]Ff:XHAV6W9I)\-8?.(LAe_OP=(:T<77P#5JSa+fV;Y^
2)</TFX?P):Ed_ZF8C[@HMRVSQbd=HDF+4dLSB?5CNYQ>(&JgCE?bZHe<TMIGKB/
O]=W7&)G&L;KHce1\[IfD,MN]FH)]\B?(#\:.2Wd-cUa=[L61EJ?0d#ICMDQP(<U
X\fH\PI=W#5L&54e@CP])bG&D>,f:3F<>eG7;DB\8W<K@b^<:TVR_6?(Jcg=U.:a
?W#:\1R-Q^VXTaeS;aLf.M>QAT&PdW[=e27C_a#(bDU1&bKa_#T&)2/@>9_Rf_OY
:,EZMeJ)gT^&\M=WF@@[7;F^F2WKV,G(1)fG_H#:^-_C,\A:IcBZ),][M\[9dQKE
D+2B<RU21a@]UC7W,/9N+],].9e3+5=IZ6N2EPJ\K5&VVX0DCK<K,#YG5R5F(^g/
ac4_\01VLEG,e(.ObY[gD&:8S_7+&@&\L<c)DXP[TIRK.&^KJReRfb[R>Ee?51>M
;@M,G1;02(Xf<2Q?PW-Z+TS9FMgGU\(QTN_>W]X;Sb)ZK(PVFJ8R72TCTa@\G7gR
X?c[JX)I+QIGQ,AA)\;MI)4O8.AMe&VEUJZR@H>N=;\J?0[(cP<5R,ZWUP):I?-&
LC7Hf?2d4aC-\SFeOcT>8[dFW0EGU72088LOc<Z(];Y.D@d8+0]=C&Q((1@TM8+?
Y#-M>aI1LEM;gF0^MHB4JO4^C)S+?AS,/4e@HT_Q09#;M8K30+.0A.?GFGH7dXfd
QESc0[NZHaF,<BfR^YQI=HV.3-X9B2e,(ODX.X?YO/QT_KO]ZHDM,@C3)4;Z0KWH
C(^8Q=4^Q+<U)RgK\KJGKZ\T7@,dJJ9\/E&BQ.]aQU#36IB?Y_2b@)JU^?:A,N8^
bG\D)243U2KQ0YL>[.K\:EF85TII_\_T:WY6B[OKCRIIBa2GHA>(bQeJGgZ)d^6Q
@78G+OB]g^&\X:RaZ=S1G4K]02aK/8;-Kb&<aZ_F]HO5;[TE@\.7P_)MaKTWAZ6f
cG\]@@;E&S+a[aa8U6:&:G,+\NfB2:H.bHOZUCYDOVeb-143OK+7Le2D<c:EdKP2
Q>BUTQ1KJXPd.[E-L\@UY4C48,4WXeg(ZCNOD;5aMLR:L#JFcL3a>N.OD:W]bQRC
DcSVgA\8Q\)45C2>U8=-?EV-aCS65:(J<K5Q(aX]8K];(]J82QXLe@);M:[]WQ^(
c/[OX_B29&Y?4>@/0<+HN0O]8,+Q^-A6#F1dE?:4C&,BX:2f#CN0UM);P$
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
(Sd>-VL\E<Tb(_Y6=AQe-+3+,<dX<DgP,]OY8eF6:IGH#<U9YIBC=:cY<I[J(/Zg
&ERR^&=5#;-VJIBKMd.=]J=MKR8CX;^d11WaLDI5C]B9FJG5&d/8TKBM]6/gcf0b
fca9;gV6RDHN/>-MY;C70:>DaX[L[gX5U?0JRGRZG708_P#2bKS]YOcY18<FgD;H
:RNb+.&)W0-&?14KCHG.WJWJJ676HL^DOBT<5(OIb?&Zef:&?QX)V]1aE1F47^G@
6F5.3f@GQ=GE[^[eOeb3&,5f\:#QEADLa6e+#,a63K&Pbe,Hf3^/(BO8GOPdU8I\
\6?650MUI<A4U4.ILA0EVT.#1d;XaV@VJA4]1-,H;TOVg>?L]ad/J;LQd0;?_PIP
P7+Y+MP:JT&\6PX7:(QM\+,HJ+A/?ICgf07-)eVOM6X9G8D^V[ZOEZ>e]//>aZgX
HGb=UGKc#gg=9f6GK0;M+F2@UIZ]]fK[Cf&1;F,2OK2<7B1/f[ge,J;KOd3d7?d.
AZA65aQ=/@JFT[Q54NVGHZBQ9J.#^1g/a5f5N=^=8bOJ,[W:cY>L:D\5Q59;SA?X
[KFJf8<gRQI.JH<SP]aC_2(<FN-[E<Ef9(:Q+PGJHFKCR<]ZcV^e@V@Y]/]&f>Z+
_[#X+\BAQ]?)JV)FHcY.cO19dXX1(/EVDdV<>>79V9+.8KBc\Z&.6IGN9KS0Eb(@
D?>cV;]eWJ\9N4g8c92Q,(&^e.FY0N8X,aW,Lgg2#S4QaBeUGX?7FA@UFKICMMdd
#G+a.,6DOPJ/E.aff^RJcb,c#2;&773C;7dU,F^,c\9>FBc?=Eb9^Id7TFD_40G6
Y/RE;QD22.g1)d,GN[0]G.DLa;>K[NRO,a>cd.,e@g8(a:.C3GeLF=P/C\1Q[;M(
f7b#@3K;\M/7MbS,O5eMNOW6T?IF<A]S&94ND+,>1Q,Q::5\Kad,U/7P&,IeCN)a
2HX;6\Z7;L;+MLBO0Z^IDK@X[-G0HPGZ25<^@+FaMG)a&MM/-WWES,0aIEI0f60U
O@1HUZQI#P=0>-9MEV8QBC=Xb4U[Z+17;QdBSc(#>FJNd9JMaAReQT?N]_XWJ7D]
=fQ&SO_,4=[,68Dg(91Z4eeeX_BN#9g19g/0g3Z7=S8OKZ_d]AZT8+b5CG3/CU,b
c1</GE;PcOZO?T;DE<(F9[E6N\Z+HTT56=C2P4-a#gb>e+K4;[Z&2#5[CC6-FJ&)
g<NQ[.3Aa;][U?N(:+Ob1&72.T7<VO6\1[a#HMLS0\+OJ1G7U1QF3L4SXMX,d>M[
PT9H]HM;N#T.Z4O-d&0_Eeg@WD98A->LDe86_[fB+5CL-R9/?\R2QG3U_?Nfe&SC
ELcEQSS7U+R0[P2#9A]^].IQO&2DGc#-,4<V5=A1#YFZX7gO/<b,U\=)X_:JSD_C
K#Y#>e+VOd)[E&&X==cJd2W=2H/@V0))J=(8&^IJ9MY@D4]5N?Tc&7Q65JOALf=@
+CAGa,\2>>gIMcF[TAC=aUIT-;+#0>eM;S(gK7?;UU\&]2g7Z<&C]#:8Zd<408/0
).[)+WTG-<A&>3S>;5Y9d:6B.Cc7LYQUA0X<:QV#]/dd[.3([B>6IO#1E/\;OWU/
03_gI7^<4[[VI4K:XbJ8RP89.<c=[D040)?JMc6GMXbCf=.deN;LEBK5)_56DGeF
6?3.?UNH<d;5-?LV=7PeHU];&9E]39RQPgUcT];;=9K^@0a1V8[/dbaVKY4N0&#S
=[WRg-\P?WIYTAXG4\O[5XJdQ4[gM0@Ca#9X9:EE1#?U,\JT9a-L#I^I]\Q:6d5D
B<N<);JEb5bW.VP(LQQc]gFX4A#\;>_G=R4/>0G8[EZ]]6H/Q+/O,21bN#N27AKH
:_((D0OMUG?ceeBR6S4@-BWaMH(_^J:\HR?B/G?5\+4-T84#@4;Yf4P_eO1]eE#H
MFOY&AHgJDddCKU_)P\^L).70De9F>2[Ad12F8L-8TXX0dPIG5(B9b[GaOGET2GF
YU=CAE.Xa.#2Vd3NY=\8=EVHE,fE2gL>TZ7L.7R<K;P<d7QE5Y].E^+OJ;gbfgPP
eag#Ffb)VZP34(BbQ\=TTW7B#-e2[c-Q?d:5F@)T9&98/d0FX1Z,[LIf?E;UIB):
+Z?MNT95GLf6eTP9.RaQ++^90NKL,Y3[(R@gTOET1T\NJb2KGN1)9=[Z8:6PWTeg
#;Db1/c#U1O5g[3QE\G<b0fXZT8f)BaYAdQJg8UCV(g\NH[T_(:FaEOP-J_Sa+]T
Lee>A;b[X-He-N^F35,gBgHLYVU,#Z09#LJC1M+(<?dS-N;f,;ZFC5b?\g;(+e][
&WFMfFHT>T7-d^0P^53LO,cNCUWVXI:>[4LBRUN3Y:D+C2,aWY+G=5;4Ec/9?U+f
8fU9TZTO.#4SOO;<JPBU&;0fbL<40_,;eK6cRRR+@R^_Zf4#7LPQ9L\R.)f_H&;B
C96]ZbW=GPGHGM/+]55/99]Z7Qd;K@?_c:VeF5ZT==f^UDP2Q^5:YS8,UVQ=IbEX
E._D1HcJQ[B]=Nc<gadPAB3HH1<&-4XL.8)[@-UD=I-(HFVYfEMS>CcZ8(c-_Q?K
)b+?_CaeT-BHF-S.TRc]#.CUaRE=88e^?QIe5HSYVFBG@9+N\JSW00e+e7;_4]Xb
I48dZ@]0)c80^@<A+Q5cbKICSA&fP;[2>ga?M?VR;?)DbFFSA26@</^P:#I,9N:W
RCaHQF4&5E=NJT_L[ZUL12O6/9bVL@)D234Q:3aKWB?W^5]]a<\:+&NMSf_OOfI2
WQ5a9#SM,_-MF40]#T\SSMEZ32^A94MfTefg\@VI^ACG.=U)APO78->\<8O9INO\
9G\<3]ML8ZbTND8d0O)CeM=MD-MZH^e1e&&5M@OPEJJ(TC3;X#,IE;X=P.-AD1L1
&)UR^CH+3T;?4.WJ3TfT;f345c-3CN=JI[<IcR+&[6Q&FG#?A,MK#Qa_g9VRD^Nc
P)]LD,@LaSD27G=EXF.agO:B?E-0Ve@bZNU]O080B,M1-H.a;DK.CXMP-1WP55:9
c\1,,gM;V]DE2ML.,KA(Ng,b1QObQT@=UI8A6STfKQ0RB#5?-^4ET#>D6G/T(:W?
EHFT(>XCD-dgbc:+K8U@ac\YbeLf53eFDU0f-a\-SRf25f]0MeZbX;A>N<TG?K<Q
<TOe:[O>H2<W<f?bID]a..R5aSV?BD>c5&NHc39[X/6-d)S8dbV/<]W1U-#=cBJ_
Q__6DE-7?3DZ#)\ggL_,_g5<&-@9ZH?>:@UgK=S]7EUc\T,L>=;)\4/M5G#&G8V+
X1E791-WF#<8FO4I@8M\]f.V70P)-NYO0,_,:F68]FgDY+Y9fCV&N#X(9GCH7Y@M
=HL\\\NgUaQV8Q<<5d]]X,S/<RU94X?S<a4WXdDY<;T2&QOKICR[GB&#1(K;H58.
1[[M\LbFfOL#JK:K(/I<#)+[TRM;&Ee@KA]#P)J:0:5c#@e#^^A2\^Q2F@W3dC9R
=06c9+46KZgJ#J8Q9QdR&d1E=LT[K_5bdaH[?-&ICHOLRf1eA8<]?I.EZ&<d\J(]
Z?<Y:B1@R:129ENacR)E_bDcU/GbQM(V4N+R++g-_LM]a7NAOT^JZPa\;OGZT=>R
SeQ8aOJ1<4I4];VWSH2..#2G;6XfD&]@_LRO((]XYA7/;5<WJ846E79E-[:bVSCL
MFCbQ&(.c[<TH4)\OX0NNIGZNS\(VUa26N,ZX)&SA4/?JWO[TQ.U)3TH>g1_EK^&
-00_)Of60>#&U#,]E7?<GTWb6;YIWEK)5Y_C-675FD?.E+CCKd4/ES#J:2BeOeB)
f^Y47=f<AR._D96M3YZa&SWM/]XaB-gR)b4:C,J6?,CX<V?&WX+\^2a^>-QF>BT]
dWK9HBH=Aa.#)<&XI-@2N6]aDCED?;Fa]\[>S=f_P/7)3PZc[fO6\\eP]W-&]bV#
R@63^JFObV487+/AYWU_KDF_BK_62SPX+N6ASfSAA];RS]ZP:-[SN:#XEa-=Q5:&
^HY5LKS^;GU6b.aeCF9WQ5J3eDYTc>_62LHWag9A\#A^XYP@SMT;\:b^)H-I&?GA
2)M_b+GI#5ETLGN2M6\FO5@^>?AL#LV63[\17FWEC^Z.R?W+K(6fW0Oa>OANFF8;
<g2Z+[S#WSc>&VV9Sf8=#SR)M]g8g._5D60_b7K\(23I/IKZ0bB1/;#7NN,>B?QW
6HW]f6^0N+^67O1T<^1P,WSeNJAH/85D51JLP@;e3AED>)1&1/P3U_c>_MY7De?K
1+F)4H-8)8RPe(\YU1g((6/b]?Q[GgO_3aI)^99:3@_X0K_FL69a#?3fYK2^J?9f
GTI5Bb[=Q,W^P>OCCV#2]c(.>V4Y6(a0)OPO73A[U7Ra3X3U0=cB>dO>\I/-@MN-
d1Nb3S:UgJ-J0]B.?5\.0?b;A@_]MR&RfMgg:)(@+E:3(2RJL)ZTW.9.a.c2bX0X
AZ^JCQEZ2;Z.Ef>(<>]YBGAb6/a67,W&[3V72X4HCZGS712=Oe09F03N\aaNR^6?
0-#PB?>d,fM&Q3:aL9B17&bD;b6QCFTO:?/CDT(.\1Z&H:K-:>4/7,Ra,+0A#N,6
SeY?U(/6\E6CXdDLa7(1.NWAZRRB,6]+U?0WR(1)DVA)=Y6W@NQ)91L+[#(c<2g6
&-1:3FJP(6Sd27A)B:(N+/dRRF++:B?f<I:+(0F^RMV3RP_bS:G?f?EZ.]/PH_Z4
Z[eA)_e47aUL.V7VXU;J0E-.W5,?;],?f.4;#QOLb57C0cOS7CJ^Z72d0@1a#a)[
7(3CbZKPX_-dX\67=_8W:c\4D9P??c>D3M(\I6^J;P0BSMZb;GgZHVHb.]I=fWP6
^AU.R11fW5&6Y13A1O5MRWMZM=?EZV]=3>-b?D>CA3TCPO[a3f-3L26.,RWBNcUD
+N.Yc4P:VRPC3ISQbV9QbDE.&5<R&2=)F_[[)gB,[2;RH>Y8EW.,G,/^?fcV)ZX&
&Q,?&-QI#WabRI96QOHZ6#53[QM0)^ddJOXJEN?A7:[R8_:7&@F<K-aMB#S-@WSZ
_.c]D1_PISWc[L9Y&?4?3cLR(9N2,6GZfP,F9F/&R7>X^C7AP&E&Nb-g;f+1C/Mf
S6N<cU88aAZ>.G_X,K&OHG4UL1^4f^V[,;=/XI<W_c^;F,:_;V+e7ITEEPM.fE,N
&^>D(GGSZB@-FL@aaG),Y48bg9Oe4&9=7HLMfH:c2+KG;1/TBJ2fag?FN6>I&MZa
CAA>?8INE2U-bc,_Q^VNYb)fFP-XI_,N4L^-CIBO#IPSOOXHK:dFK92G3RZ_9cUU
5&TR#cM<X6_dR=/[5SZcS+>Wb=/.aMSMa[I<&[EIB\P59LB\W-?@?Y-<;U[c]Zf2
ZH@D_WO=0262&[dA,>5DI(09TP^GV0d?f>5-B2FA&]_e^PC,6;[Gcc^b6&3J)?1R
8b@G?Hc3eKQC[IOYg;2NIcSL^PL/<211XgTS_Oe8G)0]QC?J:eaCJKAA+#&I2]J<
6^IHQ/a9)J_M;<]CODBDDKXDF]:e+--<2AR>c@GI\70-9)>,T[b]X)61OXSYQXDO
B9H53B)Ra7=S2A5^)fOPHUB\-MXWECV9;d?/?]->&<5YSRW[?E+=B=B3\[e=?cTE
=<#;e>c2D[7=V>FL2KEB@UgD56S_MggR[-gCQME&C67U98\(BE3X303<@=cX/.F+
7+LDd>eL&<[Z0gACZ>R0XD(G)8&6[,T(?>.Q[fGcS(O^^1b,S.5+5@<,UPT6I@-M
7\KNOe,Y[Y]S:NW0<6#K1I#cg&,^S@BYF:>cZKI8DcATfGF4eK7:.K-Z#GQ_=IQX
R-F#4FXQCG1X9+@6CcdJ8=CfgK)A-A:c>+)(2EB-8^TT>_5I#R_(C:a6=_D)WBWR
Vb0@e+5d@EBS8A2Le.^f6\A3+EfP/YebH_9^AOc.XRSf\=<NA&QLgV7#[<[7^5Lg
IdXJ61NO=e]U8bHX?.BVAb13f8)I#4cZ(f_L-2g7;7?K0=.ac[8X=1OROC8.\_XL
>3fgf3g]_VeN(F+4b[MR,-O(\\P>S0Q#fAJH?,]\)B2]Q;fW^]U&-J9cJ=^fG4;U
F^WAJ.SY[]#1<QP#602.ZePc,7eJb^gZL4YH1.G2WM:?K?IHHJPP6WcIDLTdO.)-
;1K+SZA:Z#BVSYAJ?/G9cK86C>EBcb,[QA9[6IVPa#[-(HY.,RH@?ba?VFQK])A4
Z:Ib8f+B1VdK&_;a?8<HZRXgSU7))\7c/cX+H)P&S<BcHXBd_+G[CY:I^P8W=@cG
.KTA7@58_8<YE//D)CDOYW]c>d(4Z&),TQ,)?/Q^D&E+E/3[OgI[ZH-7We>Q,\IF
28a@W^^c9TY?XdZD[]W.6#[\:E@BOL/#4X7#WG&O&5ZLR23TGg73VP,ZaYJLQ\:L
A1)eI17]&Ja(.LD+^eeS9EP.5/6Wa7T8E1?1TH&SS@6F9E]?\XN&,2?bbI5G/4SY
KYT9N:-9/X0:aN3&fKJNB/=:a+5GfMDbc3,RgZeI>8R_7IBJ@(6^?.H^R_e2)5A3
0P,^4]CR0_EC<YNGbW<C2BR^IEa(g=NPd3>R4b)M2@P_WD3f-R8g+]KA5e^M.Xa/
c7QU\[.@F2@cXeNJ.]SWE,I.+U:S,AZ@C\dNN/2L@d3/f(9JOSW@cVIGIW8.]8?_Q$
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
S[aL&;J)I4ZL8cRA-W#4-Nfg=[2K(5PH8,V4(E^,:[L4d,#bfJHF,9@N:9S(-gfM
c8VF5W)4U7H+:E[S9UI/]HL;OXXQ<8TLfSC];a.-B1NTONL,?<.a15I6RX0eII.?
KC1?eP=6@@?AYdQ\1Pe-CJZCFE(a0R6?@I;<R<Q_YPP>&938EE&IA^PS,&+>?:^/
EB@eVGB?I<<f/PV?K@ZZBC;,bT>8DHKa.A=3d#)OT)3P/Nc+).5F&=O_[G&2GeHb
SXO]@cg;#@7]bR@gMP8^R1828=<9MD&.I;BV9T#ab-9(U4R7b)FaTJ\4NIK0?VXQ
Td(;IE1LXCWS0/X=&a(S15#0+Xba)LXg@IPK+&fJJg/V&Ug^EcO+^?1PV+56AN3L
JI9DLP8J+-QQ47>LIJ6)D#6=N?^;W2G.KJLI_O26_WB#5H1fO@[_,9daRU)gcVg3
?5/Q=V&aONb7g?QNd_bI.L5=cO_/#@S:92;Idc[bc&GP:0^8DYS[M)<2]SB=Z/L=
FR.HS-H50BIBTfR9@,db]EAR\G15.<JZ/,B2V>D?W4)S;.\H#99RG_A=B[I#A3:X
:JIBUMI1@2/=>>dD0>P.[=>QPUEM8<CdU&O8109a)RPGR-ae[=8#>L32<[3=05C.
188F^2C2<B#Y;I1fT9EJD_^De\E&72WRb7D;:9Of2W0]C6B_96)\PYL<VfbNC4Qg
6bPAfee_8G5.g_/LG1L<_Jd8_TC^/^0^BOG3GBcFEP6Cg[+f^d6IGOB.?-^Yg\.V
g/[/RUIdI60>C5BEJ\;O5fXbGMA+FLR^/0AGQ<3S8>TQ.6_f>(+@UBWQ)85Y0F_Z
1L]PK=&bNAKDL@bZ22+TfX<.a9Z,#0:7.MMaU63Z]7Of0:3M?1W>V0D_QAVC36N0
E_<_1UfI-9BBH;SSKSO=8LO,[Z7AI+]VTaY&2g+K&T:]@B884PI0_J?108TQ?#&H
W>&e2BP7f[5a-K8)I/H0KT<WaA&8<O?.N?LNQ6MOM>^R?@)I@QB#(FF,+:LSY:M#
#ce7T6_R?DgA(f<2dc5ZQBAO-PGXB2a-Pgg:F(9+b.[ML?G/(fcDRH;32IJ4;HP1
I4I&^LAa;JgX4,?\Ka^g>bfW)cS)9B6,=,-&M3(G_.NS2^C&5R_fE?T;D8RK@[?I
\-d[S7)O^()_Q&f2.AO#0E5GG6(^cC:decC;I@F;F=\EKa+7&05O>?\?E3&-FJR4
81RMM]T:6]^-T;YV-(=S-baE.HPYQ]5Z)UC7X:<V7VKVMIeQNb<2QN55dTHWb-??
WESWLB1fBdFW<Yg+N=-0I,Nad[1[342.(A^1eU5ZB#.(LH^8.]:79MF&(RV@gTP/
>2H9[O97(-EV#UV2\6>5KPZ[Z#JbJ6ZZF^^gd(9&fJf;,Md]D>OXGHdF-UT/O68P
_\I^5>\b6LPe-Y<4:LY9R@(0a[a((6,.Ta?b[&\GfBDK&Nc\OY_GYWY=@MfY_,;J
][W3^4EAZS?9?X^WCfN:Ma#+Y:N7O@UegI9OEQVKa<#+K6/2DNf/#GFOY+UgNKf6
JZe>d72;5&=fJ),>N-0gNV(4675f6J;U?P.]Hf+\GKb7.cQ&AG&,CXgGg=&S]J5D
U.O7[QV0&T4[-)Z:S(P?4O<cZ6g;Cf3;LfY_)=N0B[DT,SR5Te,c06111YBW^EeI
C/3T8;H=c&D1-D(&(5:T+8+7:._G=C:)bBK8Yc6UH=aEDPQYK3[KF)=8.VW7M97P
E)DKg#f@B.B.+gU8#E8EASQIbJK7dE\=(#>5#RQM4RE^(HTG42TaG7I5=[Q3A30H
Xgb\cMa:dU(JdN#dc=6FQ8c]<=N/O1&e>V@,+IOgEF1ab_1?-cg)J-1W>-XDFLNM
D1)1X#Me5)PFJM9Y[GO1ULWD\d2>4/W8>AXYK+/QUNN@XYVG-U=c/YRLD/:-_[)9
[NCG_e(5>L[4/LGd<9Q+;X-DO)R5gR:aDb7#[^UJ)7A\+/2(7IfSKLf6.N=Q>V6/
>W)A<5g7^FCM@67Q@c0bNX<</49V1#.2<F.;.de+0/#[]POL\OE#(X=@233?17B#
W.9:NS5F/c5Od=P]NX5gS6Z<=O;eRR)D5J6gNaWKETA\1)8WZ5\#I(:f3EVN@AJd
F\^I,:F=(_X:<80LZGYDBDQfgeO56Y[[[a+,KgCP0)^a\(&2OBR>#L7)NPV;(RHO
;TE41gb.XNZOVR0Va48=>6<7cH=&WTVRdSf4AR)LA@\BS-Tg_d;1FU]CM-HVQ#8A
eI,67b&B)SgG0MB5VH306aCLS6_40TOfOOX3#)b).+ME9CBTf8^B<3A&WbW<d]4S
D[aCX>@FTL/-3]I,+9AZfcf)&#K3ec2ZG;-7cO5PD8c7<]c,7/cb.fe?B9^K;Fd)
:VaQE:M-VG#6@R.N7VRO(ZISZV^@[ZG3(S-@dXT)HZUSgJ]:cGVAEgQd-8/;0R5F
@&GK5S_e:g]VD;>#::VT/8DKB/8K.P:J#[Q?E,0\\R4LXQ68A.]U>cJd7P\II)b>
Ob:7[fd,=LSG#,3Gc_+J851]]<Y-^RB<NKRebBPc8:XBP(1:ZP9^Mg4&NQK+\^>>
=F&&N]93X7G^/](Q8Z1NMEcA>C2<5C@<?FKc1BJF?5X=E/YL<V.CdGL_<KG9G,TN
gR-CNU]-b<)5OA?DET,O?bHeb)0.OOK9[MA#&6ZF:]gTf_&D6McEd-)Q^UHQ=X;2
7#EFU0ZY-Y[+:M^#)I:Z8e>/\IU2]c,T<O(^ZNd;bO#0D(1K+V)GN1[2JS>E;7\d
AO]&VDT?CP9FTFA[:4[f#1OUH^THeL#J((UfD\d7_]LAAV/#B6HCO3aM_Y,U>a_S
@70A^>NCPcP\OP25;cM[?6g8R9UUNNCbYV,,\K#AOHSf;d@[\HY)LY,KYC]HO8g.
LY_TO(2;B1AI.+P4Ggd3a>AEb-:1T-B3H.>T8dI9/ELCd(0D@\&/b-5>dS2VPL<9
7?9=2,(DV0^e9f_YJ/G;M(EK#<M5WfNZ:R[OeaUM>S7//[X;,=:fD:A7@WWX-E<8
<Jc1^\c+5-<DB+c3=T],J&C)[&I4?g5J&f23WG,-,3RJ2HRXM&gVXV_>[6bL)VS4
SAJ\5L+N7\8S3,>HXGWdBY-9KTU;]2WcA03K,GG9C?G2Ag)gL6(UYJ+69/\+Bf<c
Q^G[9^a,VM7K\ZIFAR\67fNMf)-.MDc5W\Q5?R]_6/Qg]EV4&_</MBQ+0S3EDQcA
HTXY6[C-DdXXc@/=BWf9887ILW\@@eZN5MXS0[,cEce-+1DRE9f;MR7RI-\&bN7I
74AEde2=Ff=39d35J1BUR]-D)4=0QI^T&FAS<[YPIQY6g44Z;BDCCFc-#BLN_X[C
2E-@47d/@#01=@bK6-0TDK1T=+0JCANB^,JOTO0E[ZSL#9O+P3F^3Ic-L$
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
KAf0]-&#YIaa9Md>8DC1(e]R,1IE=<ML82f^-46C(LEEeId0e;36-^Q1),,+)+-8
+,bI_Y0EegG5T>6(@4\#&bAFcN;G^a@UXY56[,N+<PQb\X&eEIJ#KUU#&/8].@C+
6AYgV+7g?gM/AF<;Z3UW37<M1.KGdD_H[^&<R2]Y#0<=Uc]/-Y)]:E\H-7a16JN/
#\X>U^f7KSbR1F3R.MF-SQHCLTSYZ;YQAQXXN#_9\V&PJVS)9P3S5@=;:@:#OQC6
bGQXCWN1<VXW1c@Q3QD]))M2/D>Pe/IC2J_@U&H<-,HJ6VNH#&O39a?eJ.TO0;4R
BRGE.fb;a3&4,[#C/?-f]1ETW;#,1J^:VJ;J.:JJEGc.;,J@9HI>Y+0&:(Z]FA@J
CKI_#B=^>)RQ1E+aM+F&HH--P;1A/=PUGQNBeUc/C8I6>MOa\<2Bb(LHCNF7S4cb
ZN(-a(6DBUPaW#&H1cS4T;U+_(d#@4]U,].M+81P^bK&++Z)EYDLA2@PM=W,#-4E
YNEgI&][0YK<gd3YMF?7J-UTV&#_=0aE(/.@3TTIL\daCc_A0N#RQ^WFRMdYCd^8
#GM[II+>Z=(^]\WXBPCcH08WY,ZR75S0YWNBG:17gMZ[),--Y/\+L;>&-@3<1WTN
QMEb-#\43##ZUN>Ibb)d2:2B_(;27AKZ^A7a#Bcd/2f<S1#_&bQX8Y-XJa].IVC^
W=>S;C8EJG8Jb+714JUgeU>VIX8Z>K7RA/HTgES#4//<MJX7\R.)HC?(G1G4W>L?
F@6^<6DZEGL;2DQ.1,TPce=#+?-4DSO1R+X^Q[S58;:Z@[7U+6173ASd/,.;0]ed
YHe-NGKAHb6#@FIB#g[(aW-W..BQ98TIC/X3B#U-:H-[LRSdf(ddK.TR+MQa5::B
5>6[19X^7XV-H2;U+H-HKIV\)0?NfU+STf_R1YLKSH5ZL2.PBAHKCA(R2X3?:F_K
7DYGRO937-B^U8+aC>8ES5,W(9P@UKQFQ(bLBR:O]VPHZ#^,F)SHZW@K:/#A&4]P
BCC:L-E(J/KGW8e.bgQ,a?/bQKS6?Gg[97<dd];Ug++VUMFcb>\3cF<Q0<eHOJ4X
0R\#,d?G<GS2#/Q11;P\;?5;40MEecdU<D[\MJd9(Y>=S<LWd#K8D0g>8T);L+VC
M?cY3Ya-WYRSNC,#6D#]=@C2XRPMZJF<J0EDI793AfQ9d8?Ra:7X&7Q&B>V/[\I_
4Vcb9>32:C1XP-?E:M/H_HAI+\S.8Z\-gSU[f8:8W2>+)8JXBR=LZB.O)T?0C7[V
P@bI@S4DYg:>W#97.8e\S>,#dN0Q62aAE#SGR-Se#=dH?c8G.6_^R:HSdX+6ZC;#
ddM[aU:8;AfJ&#O#XS1PLNM0=DX6)^_Q[M9XGYZb6+4/8?4aAA6\V>+[\@3NR@<^
c1WM)EA]AYB5Ic.B._S]JBQB>(D859+)[O8Q1F,(3EcXW#D&EdPPJ7QHg]])IP-0
3IfJ,aEBS;K-C-(KO6+KRU/8<3T@MSMCWN+bA4,6)9FgV:8900MI>U>>+,c_L,XI
LZ^XV2SC3eF&1>7M?0O]5W68O_/?TfH+S8#VMeUFg/PWdR]_([PAY#PaX/8b+b;b
\G32J(^PeS4\+#N38AZMN>T\fb[8_Z:.aAU:R0-MG^@/3;MZ,b>R2I^[F9Z<@gSK
.[I+73d<]IOKRfc+1AIM#/8&fBE\aYZfPK#HEf?>?&,WSFI?U.,TD\M?C@.eM_6_
N/UW/JTMJc)<U;.C.=XKYNQ==,H3L>=LL@1627J;T5&Z#C6Oc]/XRGPZgMXU?HMV
C_XfLW?J?]0(\>SNQC_g)e,AU+\4J@1KR#=]/]cHK5GLSC#J&KB9?bZ3]7Ub(8Mc
9>1^f,^Nbd?a)RDaTIGfPP_S&K#ZK,1N8ge9K4S=aJN4f6U7MSVOWagJ8d6USBJH
D2LV)>Cd[)+KRP:C][^d#c&)H,fdBe^0-X34gcKYgI;B>Y0L1\.O62U/@&L2H;+L
e??PaU;UfaP8-&76J<-YTa0A<=1[JW_eT3=OK4,_Q7S)-CZ6Of,(,G5E4<>4WE0g
.C2d0LYQZ7Y^83F[g&BBB;b#7/L2/-W[3&-K9+Wg5Q(9IBfQc1V8/SN<F_e:G48L
[@d^9O=fPcIQ2YHW-N_C(@]Qa#8B<T/?P+D(Z-0D4L0(Ia<0N9;]PYf\ROD&5Iab
-[#E[T]2TP=.4^>T;2b0e2U9>R>W&UM/McXQQT&X07AHaZTf]=g\\d_TR]3KefBV
]bdg>IY>=6X7PV8+/XGG97BC,dGJEe<Y\/[4N/9FOOcdMU#IVNL?@d#;0&ad31TY
#J-<:J:H8L2/#2(c#d/5b5RHFa:6?cLR\NIZ2T_=P8C/CeX,ED?#:205:cP&;JXB
^Ya@]SG54I+QMR0B1D+3;Z;T\OP_Q9?SOSP8aH^19GL:TH&G_/(#Q_?I_^F:4LEI
aIW8B@?3@:3A5ZVR.Z0N)7Xg7Pg\b)EL3a_WP6eL+.AFAIJ:ACQUaa\L_U]=T@KW
]?C3K@(H6/YF=BAAD03+P4c]ZY\2BLD)S.FMK;eBO(MFC$
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
,)](\6[2LeNG<;[X,e+^(GP;)?DD8e6_,830)S0VD.TE7T&a;WCg<@R])YPK=Oag
150c]?NY/R\>3K6K8ODA8XccUM22:X[>K3>GSK^/576UJ@CV[^8cSK@2/59^,TSJ
2LH0Jb?\3?d2\a-P/3_--BCWI&EFWHc6S-@O[6;C8PE@JNKKBC)c@)J\dT?c@K_G
I10PU+.G&4&/=,V9DZ3;b/87A9>_0)R=OVNVSP^dOW<[8RF8BbF@?<IXT8JQJSJY
B^&+P.O.^Q>5=9NF]<22NAU:?KP/68Z@RGH/Yd_,WFa@.aOT9-?:bd-0G/0@8RZ5
R1HV9>Kc7.);fCK.\L;QVg^_YZR#H&Ie\G[3f<=GJbO2c,\3b+VM774BY?E.[>YB
b9ag9Bb?aa1I:\WO_\P3T5U9VW5[+\,JMOfa\(Y+3^da5S216HN1FQEO-d?CXQPd
PJgB@P8RZ#?d=cF4b_QP#KB6J-C+0@H4;_b2O<+H43<-BcJ^[.><<Z2UO<AIg>@V
PHDLe_MXA#>MLC[Y^SA9-DZf0S&IP?5TK9#,BcSfB^_1M#U[P/OEb3Y=?^USeZeC
VWCQLYO#\U#FcY>:CJQ,UI78P&M2AGdWfeZa5\NAHg(XaA.LW<J+^5/,?a@,URcX
9(g80NR8\IM8\HL[4e0^d,2N;LT[YbY)LO@\F;//G=+#L;dW&UQWVVJS)GKWLQ11
@8EO8&HdQ-1dSb7Wb;A1Z6VGNg>MJ+.a_RA\<^83(FI&1(441dgO#Xd[31YAPD,W
9O&D)WeY?D3U@c]9O5L_9@CAA^]<N&P/FA(UT4RU?HIL3>.<&0NZHTYcb?gLA.GB
K,I&K=\9]+I7AdA@,1ZZI05PA5EKBU..Ra_8EDDLbgNXb-1QAQ1[+TBf;@SPGLE8
3X5^OV&3?0W]Wa/3TH/&HWA:1_7fEdYdUQCXQT&JfVfG_8QZ<1L;)&WI)Y\@gYH,
8V]Y2N&KCF\,]OH^3&b+[R^gL,NBeeT[dRMGd-[f7;d2B<O00Gd#<eBbMGM5RD:Y
@bHS&+a-dR]CP6)6<@g.(B?A]c_A;RA[VM6DH]1MS7P>Bg;#]4L=EZc7@aV9d.7d
6=7Vca6L^3Y)+B;Re;c.b0IT5@7K40fK/G?>[bM]4)GdEWb:WIe3;SO=LS:M>^7M
a>E4(#^XMZa\6D:H\BXIK^^>a::W-NFa6/7F:((_<[#00/7fbc>G#f.B4&^#dHI8
+_Oe7OG0=d+FJWMSccfS;2NV_>8R@AbO6-&;CQER3a>MUYBWXbd2LRNf#QJX[I,9
3HVdEOA=-IY6XFR9XKd6_3G6^<cVJ(1YL[-dA&W>C2LNG/NaJ5_>U]bc.YW;#S&G
Y=9NE<^\609,d1&7&beUL]FJGXSCN\bGFLgQRK=A</UHT-;?6,4c>NVN=Q#W^,_2
Ed6YCfPBH;_gZd:I[(B8@J^LgI.P:F#aDPD?2N?:\@CE^aO>Bf-P_G1a6S1ATKH1
PKT4d\V4LH-BMX54P86U+)@bb3VaN\_f8XJL2G4Y<HQacF+2AY8\3[0+[.SJ.)e;
WJAgR4S4/c,P(dQ<>_\1P0,?P?>]HR/19#]HA?=GKFP-aL..WQ?dOC,D52R;@4JN
Y_(R#/#HO-_?HMDL)NB[TSR1]ZK8RAKg=<HV.S5D9_HNP,)&>cV3WI,Wd+DTaC9d
HeFI)&)6c@6&.DN>/Z_S&1J=]dPC#A/D]NJe:?;44O/6?\Ag-a7,N8HUW?D@?2/3
gM-&D/LdU7F@A;N+c,fL;9R4+gOL;IH7Db87a53:>:Y7;QF-K[e1b#6aE]YEXTHg
AdS[A&.\0Ug8F-KW1\4XE.d2bC:B]bQ^0H2AN.?72<dIFLZcJZN+GM603UX2gGL]
Ca0P:.=,SM[VN@IU.Oc(He4357#XUK_?REUPQ+@(0N5b]L]&T.a8^O9CKJ34]ZM_
\F<8>>aWG_1QLf^0edWU=BEcSU=?&-c2\gK4HQ7ZYYg0WIAES,SSWI)Q794cP\EJ
X7EEK7>GLV>C(fX\08/7a#,;GLW^N7))5b6f>R?9J@DFe^R^4Y42)<WS/3BZ>D-]
.3e6Z)B7A#B8)A4=IM[1X#VNXL0G-Pe(D/?UBX@6F5eLK44NWYN>_ZMA3L60+0ZR
aK?8bL/L0(>B[@?[=_M0-e8Hb(RUgNHK9_3IMWfI75D/4LDB-E7dPPE0^6U..1X_
/2)X9YY.7C/4FV>3-2L:;3E0eEA)R3402&dP@PJ3)N-WL-&>gQL,>PA0J1B=[]5V
L3gK,H:KJXNAUFOV_4A=P;Z<N16+Z[KL28V+WEZ.,&,TA[PT5.]59cV86@#6#1:T
9YW8O03WZ:<>fV_CJQf(b4BL>GgKN0N_?@V>Cf_3+3ZS-+Y2.EDX^^,eLS2eO).]
RO_><@=+IU.&R?Q<IGdbfc2@9HNA76#VKZ(+EIW>V?AU>GU+/IJS5B0;7QQH556D
U_O[;3M[?&8]#(&T=<L&FE<O^F6g[g[)M2N(NF#2a_(N.36^R1UGb2?K(&S],^F^
0eRJLOK>;46)0V1)SSNAfDS)_ccPf+PFA&I)=dAY_^#809@-?\fI-:8eKV@.N:?.
7WV::.@ZE<W0F?K:OZ=g:JOB9;b<GX^P]D)fW[6#;c5<62L^cRab1E47?HSQ?O]T
G3?83KI\LXMV23MI1C:);H^AU6ec+[Y(>3592QCP5U##&T2gF(F/63&XD7I(M;XG
DL/ZT]R35(A;9-YHT=LEB+&)EB[>^XF,U2B,-JBB?T91bd=AMbG6<J2GRQZ+<R[0
Y:,UefL>(7^F/^ZV-_eX<W_a(_)&f5G3f&JQ1-/</\&;]YcL;O,:HCTgb9aYSENe
c\23N3GRaOO0TJDW)0#b<5ZcMeRLO@G;ABM:\7#&[/.71?b<V25^.I4?;H-,0?[Q
Z2\S/gRNAK8e#>6Kc.SI.J&;]gV)I\E(-+Q_D956.8)+>a-T44TYA,V?F(BfB,:X
9Qe\S]f;Pa;+)BN=T:?QbV-HG-a<<,?I_E:LX,-A1.gI#Zf>F;-S@LJT^V;;];<X
&;QBTgE7B<XQ=Q2Q\83-D#+=<Y7#R7DJ\-(+E=/58^R^D8VJb>N(,AY#+Q:9<85e
N.++6c=Vcd=J<Hb0N;9_>)WP9]LfUI=/^AMab/SaDA\I<293?=/O_;G>O?[cT_SY
_4+_2,7f47V8&4]2@ZB3.[Ig_[4-[eM\dgA2KTN&IUXV46WD2[XDZ[9#YSSQL^b+
0IPfYI>MIA)>;C9MdLU2B8ZeIdJWfe#(.MKe>C:13gYTE_[7Y#4,E[bd3)-_A5,4
>/336a+ge=[O0J+OFAJ@1f,9[#DP4&XE,K?(XeeK_U#GK2;Y4Z33eL;6d20>?3ab
R)8K,OOFfA8T.6+Vb9J#OCRDXdPf_=6+,E19NT0AAURLgR]Cc(,X72I4a7I(P:AF
R,<M7&(0_^;dBN@82c25aO9;Gc13+A=,6O0EHU0C+&X?4V82PJC3<25;bZ.\QFWR
M(V/]?ISJ3+c;Gc?;PEd9_>/.>T;a2XE5UaZV3)Dbf10>(3[O+0b6@d81,>=d>+[
SB>ObC+J8M#?UfB>UN<M;INX,V6^^CK07e4Q,B7<GfZe88O<CT0Q+MHF:aA455V)
Z&[Te[SO@&DAG;;?8A-DB^TI=+^7<>4G/P+Yg-fE<b=/RdR;JY#OG?If,ObF4aN<
=V^S)I53MIH9XT2;PY@>6NB118)?J]&0V-W7f^_H#RM3TT5Ad13f2()OQ(_>5b[]
;X)@273DgGEE4/]C<:75D+KHfS(O>&Q6?(&GN?5M<dOYfL.AAc.ddP(Ib[d&#ZbO
(:_24<D\6V_ceD;69YfQ^=.X)4d6S)9_WC9VP61ARA3W#;EK\A9e)WgB@HPBS3Qg
-:,Re>\C-U]GfVF:6[0&F?QL9WUY5\;aWHNA/dR7=7aAV6D<=V=]30gS+b1^BC)>
YU3:30BZKP(^b<:ZI>,U^#6).Wd+QKL:=f&[]6?V0++)?Q-&)cY7;aZI62G_HC)N
_3_ce,(6\Z??.0>Z,V02O7#S.8aVW3QSE:de0M],]]>[Q4f^I3Z6-0PDSU_FBGbC
[RVBYP?@/3-,6.b(8:S)C=fU.e-T-MCA6(A7\;DN^>>JI<.2Y358Z3;C^5\KI43I
T9-,4^^H])&3I\0>b:.E.(V)7H+SUMMA-N,V7<^Cb)&1?NaE)(6XA?,b:)@46G0Q
)7bP0TGLL[f?Ff5dW8A\bI\4][(>A23DR(XdCUJ+\PRfb_8cI\I(63H7WHNdQbfa
WI,X#]e[,Y+TK:a5)NaB7M71E9eW<?R/TZ+ZHZ:A0Va-IC+d7M=AfF#gUP(2D(-8
9T[34V&.1;eU#=6?g:d\K.(<XQ)K(1?F,GS1bQAXWA4O:\/JQOVJ07?]>T:)T)69
f9W<aLY;YU2.JBe8_@OI5F<XB_JC6M-OF^2M:N(]E#.&V]KM@=3&S#3@6C:D/>;E
&c2J(U]b/<.1S&YdE>6-#.3LC)0E:-JOV.^881e^Y3fPXC6Dc##/OfT.ER77#+bL
-VCd-B0gM6fP6Q@bOa<ScEJ7P=T)1E8?&dU,@X,-F=(_UKG3MJH/K)CYQ.JVCMD\
/JHWVbG=HC&V/I\?eAbR^IYJXJ4S44(8+MZc_+4X5U#GP@G>-:GMM#SBZ7+MgE>8
D3X;3>eNIHX6Q3TBI16,IaZ5#FHEG\XbNV-.V+\+ZV?4#7X^b^e,+RZ\0=X-KE87
D6UP?ZZCFWL/OdH2@KaSL<0Xb)9N=ADQT,,_Mb\+g]>PP:1>.B[J=CIW+I5fbWI=
@(a?a[J^@&c^2F(Ye,S[R02CM&=)]FG\5D(S-->S-3c05.-(=Y>[1U8Q]9b6<M]_
)c]cc7Gbeg@FV6b:5RVdC=]8&Cg::HQcDNOe3(ILGJ-@-1^IOLQBK>_2:;,_NbWM
Vd^0##V3SKAN;A231UfQ,+_eZ8.[=9d;b1Y:PA3KI3))O3U<2b.U\8H1F)J)#XUK
.]b)P7A&DBa8?B6\Q#VVA)/C+)?#:a]F##F:f.+JX;@EeHacG[TK#<S#3?VOe8&5
=fF^;eb^6#;XaZDg#dg#8Gef[MdaE(Y8]@3&J9fDIW.@(+^Ub#/g7>01]S(fB(&E
=+[Z?]CfRfO-=4XFVdDFV?d.OUVT6)UbM=FAFQ?[D5XLFZ(@>bINY?]1a>23(O@Z
;(Sa/:4.O6,FOEXHa,#8Z,3HHLOIX06Fe?5GY&FZ3]WQRPFa/,3.1J\>d)68V[-D
Z/2L^B:Q[\3A4O\@UHBaSR20b0<R.KPc3eFY.9X6OG0P+9U(WeAY?BJCg+06<PQe
IKB>NL+1?b2[DfK;9]WfI>7ZQeE=8MLXMVe?\G)V4D]e8OJ5&TB6GLKYW,RJ;H;X
Q(b8c=KT6YN=0Yb7YG.Z)7:-7g-H=2@1@D;HMUa8Z+:Z_Y,/>+-<03]-dXE^=VL.
7H=H]?JT(HbQQ]N;5HFIX8V5cA7]Z##7MNcf:40T[b27M-2F7S6QHe9\63]Y::IK
/[R:CbAF4VaJY[W6SJ)MDN5f&UQ-Z+fg[gB,N]DZTFPG=4O\-JEL[GWG4fX)2./T
g+PA;H>fc^B8?S5I/GG6^I3>N4+YBIN=ZAU#39O[R3=f-S&)a4_7_Z<L>9NL8Z-#
;?W6ON-8eG0&.@BL9G7Y0P7P]2^GfaW8D=eQ>eCGPD.=1&6.MES_cD1X-T([;S)K
S:Q#.K>)R/cUA8ddU_09O9LdY@UN)7_3YSW,:c.7ce)=S74T@0;M@c9IX4dIeSJM
S\I3]/FXH6;ES:X]>A90\6_9O/]ZG#GBC_=?)efHELP\=-]OA^[c#M9IJ$
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
ebAD99F#T\T=-?\O)^6_,>d[84Md-#^/<OTJ(Hf\?f2>f-QD.f,g<Q4;-&]()48&
XI9^8D+S0Gf#N-BgSE_4Y(6=MG/#2aJUK@[Z7F=,g6dKgB[4AaNeTHd\(E5)YHGW
ba9N=)CAD@W_B<\>,M+X>ZE87&Bcd\.IQaKY<JA3VK-Rb2D#HA-_[?AW^8T2g)CT
E[^g^BOZM&R433P_FZLg8-HZ6P&61,STBR:&ONg)CZ&e#3Ke-/,SF).4:e(Ld],#
=SKF.U>IYgbV4aY9X;-:aK)/eIU<dID7NASb2M\1XB514(KJ\:;PG].&+aZ1E0C(
5HS.a_XgX.#SIT\a0)5UDM(?bR=->H:)+#0-=(HgC2ICMHCP))deWNZJI_#+d?_R
H<YEBE_+/O61?1^VXUL<]ZJ#FEa.\G>eC1M?;SJNRDY?2b@@>-D0TGgZ.(N[OG82
KKVASY4W8)&SAL7bW4MW@>gfDA^X(\J9EK^>&e+1S=<^7FG-FDN.EJ2ab.B-+]@)
J=AOaP[M(#(KWKL2OE/9AJYTfT3@)-DI/=e&,eMGDH-).03?-]?/[,TD/@7;b@+3
KC3HRGOEOKMZ4K11S-3[6-;<=9+@49:F1)ffMIW^()E&;=b[=c4g:=/GNNX44gBH
dfRDP8S5dQNHE<^Hf<UZ5a_b.Bcd1.GP,V6b/^3,4^[6^CIT27NG2L?N-DE&AI&5
,TgbRIMHe3W],^P?T((D23ON>4Z_gQV)[e__=O+HdU=1D#e7@BL+7HT;;2;V\VY?
gZY,F&9E]?1\PWbFg,Q((Q/a+\EZ_&I?)1F2=Qe4GbQY21J:1=>-U0d0TYX4?0)0
>X^+M?;O3bIT;b=_1=K\WU6L)_LcfIUg0?<bK/,K939E)fMEA^c4?Fd1#M_8>f7f
Q[4D[:>TT:df5(7f<?9Cf1M+6L4M/dPN?>MEV[V/ZY#aECb?2R/=C#RU0<[1bXH3
RaLbOOVgbH68:ZeC&a)[2^Ub,c9?G/Y[QQ>2@&)G3cDBZ5ScL29QJXac,S61DX^1
/_+/RH;RgHCERdIZT86#ECHJaHCO\R_bYcM_(]E2Pf>VRN-eBHDD4XYT0<DSNE9V
:CVSQGBLB,Q\;0WEL8d?8PIeT:):.c12Zd/8BR=)>7e8IAZbb6AGTd1-?.<]D&+-
R+(164a=0cJ94,]W,@eJCfZ0-J>0c=VcgJ;X5[);E[a>M=0:FfO0Z4I1eFS)(NLg
:XfZ8PZDW)CM,G_\8O_a(gF[8_@^2)W<J2.J57.OM;-+RIf>#e9ZYM:gQ-3.?06g
8S35b;V4<+9J_A<Xg]383?M_AaXfBa+G2Wgf2?F0@gd&BZN&,IESAN\ORG[H_[5<
8H>O&2(gVDNW,8NH-^PQ?WgFMB,Ff4E[D,Y?8=EKO@]g(b?0bV=<[)].V9(PdIXM
0BD1-&E68X#8B&6(QRSC8E]RYT36D#.GGSK5g-QGIK]Z=_;;2HObB-G?+e5bRaDf
EE9-Y7I3,TZS;Vd7#2]^DY&L2QbA(f\@U[4G?28#HLY2AU]M((,47fMR;=ELEGVR
HdM[eeacZO6D>_gK3)..e:.N5gfY;.d0.5V/8UDTb^;(KQJ(3b&X4IYANdVJ\M,;
b[KS:#<MS&0>(aUN;,&9;A36c3+T+N0^Hg4^Z=Ge7bO,G/VLeWXO=GX;,13A21C_
4:(K_QaS<T9K;cY\H;L3(#8AOAJZ>H)-OCHd##Ka.JF=_JYP/IIP<HaYA:KS18S+
A]UNFO+/18E[>GGW))0)/PKGIfVP8d#&.E8?+TdLB+(BdSX+7c_[E<Ld^\5\+#FE
F:)7MD8<Y-+H7TfFVR:VD+0E7^JF^E6fM]9NK[-9ZYbXL62[Za6SV9)U=SUbE4a=
:e.\G/[_<ZEUG6:IO[WDBQQO0GdL;[7?4VM+0M.+FPP)CF/IeJJKbYe(eUY<RTMZ
OUUH&cC42]DbMQ,]?^IIfF@>e0BKE@<a2H-FZD=QfdBg>?10fV3.Qa2)/,)2c6bS
K[/+0T4S2Me>[Y=(S6D<0RZ4LCLf9(f[1L6[NZ]O?#U[7DgFL[<\9bNI\N@N[Oc_
,5IbAO/FAT>EOf+-+Uf;OKDT&)S)S84Q+&9?R=E/H5DU4O7MR:HF8S]_;,<NL<bB
[)DNKEE027Z?L5aOMWc,e?2WPHM_IOeZ-8OeGPcQA.I.HKMFB0EUGE9bM28#23Pf
GDI\5#DKZYWBKe(-T)aP9Se&XX,S+RHJ^5=0@NPgf:2^544HC^L7J+])S0D4_YBS
:f_];3aPbY_B0$
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
