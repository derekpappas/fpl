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
`define D19X32
`define V30
`define LVTTL
`define NBANK4
`define X32


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
I_\7=5T24d(D<;;F8YRf,[LU&gD(-dNV,BBA(.WL-17S^G6^M1EX9Z[_)>\5()[/
9265,gFde3&8b]ZD[]Ug\949VL.D3G2E7LZH,J>R_ZSZF26?H+I-1QKO1CN=39EX
e4F28+?628:gF0IF=eU0b[R30NV0H1WbH0GP->OZR#ES1]a3Hf5N+5H?I7WZe]ga
C?UM]265YHO2.;\d,&7/;]&E6OUUX#&:RO\FI48bB;<\R[RV@S0:G/JL/B0ARe,g
N_<@YJc4S4<Q[+5)MG,XW.#&cI\OHBbQD:RaGabI0<D/\_fSSMNO^aL(/9XM(B]B
C@._a-B@KdM=MBMPULDbAQJXRe+5YbdKYf1/F>fVcbMdO]e:LMB2ALT0[[<2-X3L
XK)RIcPE^MP>4#>aMZ.+LZ(U+RX=;La2^F-V^PJfUL3PJg+G99b&B8ABXRBa=.QS
&0W(6Tc4NV]+-U?0203We5US1K)]&g]NJ#)/Y\C>@66I[\eKS\WWR9Lg_40#geQD
#0RQX?[;>LfS1TdJ5Q2.Zd5T5=/2NQ?eS+<;#;+)##dO#@b>K+\0B)0>ADB;>cH8
f\3RAZU+Y?(d.6-e7>[IE+BK8E<2^B](X3>6;65]a/PbeQg#/:;ZUT7\2@S#7:NE
[ZIRSJDA2WJ>#C6&07dc+\GK7[f;ZAN7=;Yc+@[E_M=Ue6=aeR]g2cd89]H[1_<A
3C0,>?I<B@DaNO><bJd??D^G()D=W-I\CTYO,#HaJM+#(K^Wc,Z?eYK:d=TY<JR:
d2;F\A6N@APX[2KfL/C&2dF(<\1QK9F<SPFG4Qc5TM.OV0^\94WD6/Kf)ZQA_YRf
]P9B5g0^73AD?ZRY@9;;54_H@\4Z83YN<-A5X^MSR<?3b/G(f;eEBV,Qg9(P5aF&
:]T\B&RIYU7^Dc@YP8:O3U23-M#A5C(Zg6\fOd,UFI6AY-:>P]PE\87<5&2;R/B6
-d9WQ)?A;E&_9RB\HOCP4g.f27e2ddcA+Q?^?\FFOIRFdC2W5W=d1&FH,R&(.QEC
Yc_Af)-eU/9bN&BgBW:.ZOR//1g-[#Q:BgD&@c0\BX>eUZJKN>>4fK,Xeb_SKVSF
c_F>5M6MGeSVNQ/\R\3V3,:>\V=WQ.TGXW^Kc3HG2_Y2PQD^Vf=10\(aX2AAWWU8
4+&.>;Z:X:=BE,N18_,V^;NbTM=&Fe[9>-e#PQ=UE.R8^PRCY^#8@\3RdR4gVf7B
e;0cS8,gcCTBSLX[80SG+]9TK#A=_I#>;@,CY6>-M@MaNR.5PV/:b[+>4J)AVfeE
A9IW5:=3eB8[WY_&@/YF+>.[f6/K#6HE,JfH9PH&1):@6dHbH6RNS;_JL9HU?N;\
,<A)b3\ZbFC[#OY?fZ9#Wa427&C7XRX#W&_N.S9PAAaQ^_D4HW2-YH0(2c&;LID.
IX<dBW\][Z1J09[d[?E1cMA.I@Z.\;^P\1[Hd6UA&_HZB5#M(f<9M8Zg@K>W00_F
);7T548g]>/)1KC)F0\71:^P^WM=#<R.K]D>@fRD:-&[\aZ(/_ALFfY<6>a::>2&
:XR<US;,E.@ZYAgIWLRb4f_D=YQ,dX:9]L0RJ>a6XL668[+098MTS6F)B\_BI@S]
T()UT3RR60CF];M:U.^\-3;IDaJS[a+04(Hg?OQ6Sc>OQBfD4Je(d:gfC@&[.;)0
Ce9geH\GJGdKfP\.WJOaX4Xg#2/O)#7KWR?c6T64<136XYX(X6Zf32b=fb+fKWfI
c.;/_V(9G0gdbM0;d:RIYN=UK8cFe8E(5UN;D3&N(^FOA#.-/YQ-;K4Pc,-/gV#6
_DQU9_[-KTa;11]E8<bU7M:FSQfXe[K>,Q)-0Y>.O]Q&#53Q@BMWXSF8H,A.1:&D
E>YOQfL&(eeQY:OL2+IYgC-.O(L.9IS\?$
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
7\bGUW0U5,._-0dL8bKW9>A>)a\O9a^<8FA/(U3J.FOQ.dIG;Ae-8b#79\\M))_O
V^LCc<S^c?2T&#a5)CSC2P<R3L;?8Ra3)><4?\1>#9O:/J+U.^?SE81LF=\ZaI-4
6\FHWK,E(^4fNI[/OK9L5IMTK^(FU79BN4+.0(/=F9B[6):O6-GR==,ZU.1_Z[@L
JTO51UcSD;CcD3G9M1&P^>Q)Ac\R7E)1\.5bg>S8LeXY]ANB8g1a_MCQQS4QUOG@
TR341SXJV<aUA<eE.6NG1eE+C\BHfJ8=N[0FIOR;S_+QMUK6]#=XI=[[AUL^#=E(
-0FY^-U.,b0fgf\4UI(fb?9^AM[0&?dP2WHA8_PB.f+O)F)(\cNHIY0Z\/[R7db2
D^^e@^<DEIS6F9085bYc(cM(73N6d3c:N^VGP[3:O;\[SJ+VB,dJe=3gAVY&:;++
gH0I<9C)QAOGPS7J6\Y+#EgQ\WD,PT\a)9eQTY;36R(^PSf)Ic8<--=CNH<W8R[K
7MNCL8.BP(/fV0Jd6,f&JRdXgJ[->+[Q814;d46OCLDV,1LR=W866/]7^C[T:\L.
351@P>\[8RDNC:dD.U6EVR0fON03C5I...2QF-U=WAaU=d;7dG(]XB8Q=H<YUO[0
J8(Wd/XeO#K#.I?dWI\/1Jb[2)d#@#[,Ie/L(>>=(5bN6d[H,ON34IV)9KLD8AfV
Z\69a/?+2+PXBZ1<J<9X^7aS/?eV49/A6Ye#QCQV,,>bDV\^.(W24LO[TeHD?K\S
4d1^AJTPT7MZc#Q6HOW]EY08MS=[Sf1#AYd.#=Q7bO^0K_,KK-dH,NKEMGede;EW
E@SEJDaUYQ4-8O=2cZ1C,[g(^c4aHYd/IK[YCEQ+0)FOSH+0Q1[Zg@ZK7eD^?1R,
3@3e6:)M;+?<aJ]84e]=OW,F#V7Z[[Z5+13NI7IT^/_;L)?He31=3bdZ,&aeA5Va
bVGQ=U_2Y0ffUca/;#,(W@@b9A<Yg<X,;1FG(LJL4+;B2:c?-1@_#T\-K+#9^K9M
O<[?_.OCa@@S^_U,T=LcH3[:/;E-[<1F+NQZ<5R>4.BZeHg=Z^2SgDacPBT<<QO]
HQfP)CD:G_U2b,A6ad2]AZSUa6ZG9N-+^FTGKPgC#L):4@>WNX#2G?_SVbWG/-_&
d9:?7Q#FL]eC[P>H3XCO097_+S,WXd\<3-H@U@7><SK&&/XHe>W<HX)a<A<XH65L
@H2G6gAE=9FTH4LdL)NH3<W>cB5SKF\dUb1(Ef?UJbfUBBFJ8Lc1PJdT2D?T4Z]>
O66VU6:XeB&K9G8D9JK&>X#[Z8\&cUIKNT1b@Ag9)3J;>U=REBS#gQCd3CN;K1?3
G@<O?NI,+\UR/KQ4ANZf=Na3HZ&<TCaBCABICE^_)&=/J9#>);22YgFPb?G([O\Q
D1G=4A7\(.]<I\L]UM#P,XN]AMS0CDT<g?E2d0ICWJ7e6@NY_0V--J[7&=c(5dXC
&;UO0S/@H)<0FM)fLLD[NMFY@3.AR_JIY]LDT[S13:+_\3/X+O@>[<7SMWMAVgeD
<]UP)ZB)<3[ZY5+QG5Z1^93,.5;P#>[/BPO6JSUAJMD+[PS,MPC.GbN@Y[@VX,+(
HB)2L>c6T410EI8=8Y?T?AT.YM-A?7O^M/Eb>RE0TRY_f.>42KF#g>dA@c#VY9TR
MU+NZ,6D1&bC+8I@fP4dV.Lb(X3E42_]VPJT8[?#QE.>8S-gb/=aAKaE362F)_V-
ECVb#7JJUQ?QOB4TZaX\-RK8Zga(OS]g];#74NP_4:##V8O<A[:^=(L/F>YL&51:
WB]dTB-I[&OL4>e&L6caSA17Pc(G_U7N;0AILEKHJ)24(/]UAcdV&33Udc=_R2N)
_H<Y:JG,J0<c8(EL;MZ:.?aU-C;VIUFS(S@+RgP:P-)&F3bMXGA+OZ&\#dAbUJM.
@A->>0@cD_;FGO.5R8^T1a:d(Hc0Le-HK/Z>BYC]2]@\]b,dU]RO6KA_XO[,?abE
6/=#ZDY.3eU@J(=R\bS[VZ>MM-U6F/Z7Y[+R9E8@I04=3gD9#IHC=D,C.BXU1L6C
\RFDJ@G8#G<WF_DZE\J=OWZJK?/A1&)_8R.1_&e,ggG.68HY3,R15G:?=(RM<<;X
\)PEHC,KPW(=YZ>Z])<:D8df]N?^g0(ff;-]fV,bS2,Q-5)<^HS]X<\<NS&B,WTa
aV)5S&F+G-WR1<RPd6[1<Q;2_HD=(/;&gBL?@3Y9JcP6X=#)OUMD(.)?2NHa.<S(
:K,eW[I#K-g<d>O[3KP3+0G.8<?KC/(RARDB5^7\WDYMeW07Df.a_L:<#\K4E>/(
#POFgG:Hc1UKV8YBL.N?G[@_-<911M2g>f1;W>3f2SMFAVW)683.)&00.J>D?NI:
&(O@O+?2dZ]/2gR1bG?40;7&/?L&J)MNS4=Ib9B&4bKa;DGg_^E#.3[,ZJQWX:b?
ND[B1)=#HWX1]T=YIAX4E.5PXV:]BUbNTW[JbW_.I1)Z)64A-:aZ[:MXgJC]IH51
\=3V9)MQ4W2aTCMSWfT9SDEaL4Q&.#FaF3L^L^Q=5@^88b_PIEG9G=\F:_Le]Z2;
0#JV)JV:A_7N4,@L&#G7UPd..=KY/L\..=,?>O@)Eacg[R_[K:7HT;-_8LA5Jae&
c&O@J<bGU7[X\8-KDIU+Z08I9V3+#.,G\JKY[:&ad=-,3(O^>277@MZNHDHB84O.
NTGKZV(MJT&72d9L4,,=QSgYbX_J&W;ZfLYHXfRPH9AIJT?5fO[WV#fWXK]>EJ]>
92P6Da9b6?H7MKd511WC^UbODGd4KDI@(.7O/79,?+_=SN<Y8=GNBGM(Z:FF+@gS
MA7DOTMc1.Ug?TJNIJ4K:EW60N05_44>KfL87JWJT12,<3BWHN6&OQe)J;aRA9I.
:Yc3I^EZOQ3:4/f61&6MN@>JU5ZSH#ZB.g.\LF)LCVPb?#9BHL@+)1:C_,aAH]SJ
5b0=)\>[;^\:0$
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
HW8NPN+KLA8E=HS;<^Cf,_@F=aY-86.29Dd]8;C:FV)2e)Cg])01-MU)8N@>-,U:
b65R^?GS5CT:64)<1X_+5;eU2E;)7.8#+;f3B/5_Ge2:Z50+F;;_^4g\=DVO?eM;
GP@OWQ:6N1VJGL>YDFbD;3?5\@E&>9ZM#8d<FS&U7IIeIDIVC8RF=M(aA:dK(-<4
3;Y;fL>/acb]HQe?D##a?AAfZeB5fOR&;6IA2VcRe/(3<QB#BD=1Z_D>MFB9Y;#;
9\d&[a54#5&LG4gYX[Z[[acE(0X_8#dE,<W<e-H_gPEHf.F5VXK/&ab[/#U,Ic(<
\/LSd)WQH-P<Y/ZEK8U4OM>Q9>69(@5RNY#XID,cV/[R3V6,E)-6)e&bbD(]g.M6
NDO\F&<f1V^c<EbdeM^/P5bcg^5ReH#bVD@\O6/aEVC<D1A0B1]Fg8e&0(_b1dY.
\)4K,PEJ^E89)E3_^?C;)[@I-HfF\0c@edAY[/2(Q9)<S&/(I-4;V4dM&9VAf:ff
-J68I9(?f4;(3b^(/45gL0DKRV7PP4Z8=>;@J,DRG0QMfYU7b3e=L^.)U1KLRT4E
3E<F?22#1g+\YO(@M)5#:RY^9ESIT5K@=-67JJ:?a8FKTV#K+/DV>7d:IF#KEMfP
F9UEOg::bc-^+fE<OU(\JNG[_aLUQ/R>;P.Y?J1_gU/9GRW-7/3R?UWPDA6S&.<K
T2V[DPf:0GS.5O2MAEQVN]LgU#b\OM.E2+M&JVabJ[/\M4IAI83f2_KOY>a^@[V/
O\@S7W.0O<PbH402c/UX4cJY3+Y5@Wd7(HS(K+R=S9(-6UFCDg80RO6WBJL0f:B&
US\QCZ6)JH0XL/<M<]I++./eTcH]\U3/(\PdB8d>W5:X3#4Z0A9a)VbH>4EZ0V86
4e9UUa\56L(+fFQM5g]gfSKc]>7,QG#36NRS7Uga^6BD.@VFGL5edFX^+B\L;1?O
+8CH_M/a2TgA#@f;80][L[VNa.bI[7/.V9S@;\)I1VHU]5d;^(HE#FXMU=TZ_[5/
M_L-;M48P]N8:,#30]V7_RA_g^R7a6dVG(^d&_#gSQYTD0G4QSN46VMe\K.I;C7&
KQ5O2bE9<cceV:=T9Z1>CX1MYa+Y#LX\UFd&YL?5^M/1cCdg:QN=:?DO_\^ZJPC+
84F+ee5.286ag(X@Od)D8=c#c@<\D_?7eaTMIagPU24_\JGVf.DWB,gX:<)FAE<Y
][bQgX]U8Q<XR6bJ6LEW/(=G0.Se]J7E6N8cgYLME68eHR-H(ZGHe8R4L<&L2?3Y
0]gM334AC,g?4H5/CU;&R8FBU&[>/HK8ecLd1dM(LK+^)9]R02K#356J:=V)+D5L
D8.8?NcD16b0YfVND<20&Ee2DP@fdUa:dU6=\\N7b9baRZ=<?D3d;=87@H/&V#,e
c\g0HACS+:)H5Sb7(YE@3BbR9T:)]A&&2McbQZD&H(fJbX+;G,J37A#\??1=cAEZ
LG\15TB5GH+YJQ_T=33&TaISQ]\QbILOLZAI8LFI:NUAC.XP?e#GC&@<IEgeVJ=<
Q\W2#5Q#.LfaG?#YVE.E&,1fb=VLJ.@>aZ1-<Y&C.cKH3QH>b\,+f.D^O3E[)\d&
]UIC:gL:8+0<SR0#9E6>OH/B.=X9X.&L4A-#;2/527>CBXHKVc^4M1c.[Z2IOfDV
eYe[ZXNE^JMTVY6(X#TY0UEU:PJ;AKE<9eW&#8B3JN_]6)-RbRNP+.eV#YZ@D..Q
D2a0bf&EQP1I>K0KW+DAN9NA+XF;^5)+N&=g)/_R)V-2_QZO@[+6UP<6bDb_Q9W+
^/3I?d1a#YM]V+)O#_a-]-PQ.g)WH.G)(c<QAJ:T\SC0:T3OBXg#-:aH6eHMP5OM
b:IW4Td=,I52#ITY4ZU?:17G;VB(S7>fTL@eBU>eULI)#M2;_SPY,?#G\\@&WXga
L\Zg11Y<T#?N=f2QT-b^SO&J]X,V^H?4^JZ]S39<+8?9)+Td\C;aLgb:fF/IL5^<
_L7R9_aCR[N7_O[-A8RXWOaWJf/DA8XV6KQB;bg0H[D@QRQP?EH9CaU><4Rb^62:
.0?U=<aNdLIJRDg))7:_S9;HbHW-P@8WQK0^0-Je?SC:N.B7b&5aObNU61BQ.QDe
F8L/g6f(c/OL.Ndc&4T5_M.O@D35A>g09.9Q)cf1X-U)gK_+UQ>52P6/d^L2VY\U
8X1F3V)))B,^OI>Kg7+IC?0UaAgeJM=dE3&JcA2/.CJP?<ON7L]fI^7HBKKAOU;0
2))?)>\@a#_21H/2OcO+PSKH->dTB>:gFOB=c?0:I/.>UKc^AXFHR59TS[\=gCd+
;((\8M\,5@T)OEHc.SPHed-6fO6X#;+B<R^?/U.<5Y(Mg06E&M?\=:L,R]H)gUS]
d9BVC&H+R2gAA-Y,b05P.BLaJV<&D3QZ@D.8PU)2/>&f;&+7_BW=dQQ:+cIL@97]
<8JK(15MN:_SCR=W[Y-&6]7:7Z;0,cJ?D8_1f?R=(_8E6I5E96M.O@dFMBG/5AC)
],e-5)3U4UIC0O:?,Y,H,=#]5.N&EaXaX^?EbNUUKES,LXZ/^-./+0Je=]VB+,&_
a+\gH@/O4W+)T<JL@HaORag</VU9+1?A&XII/GN2DbQ3IXYIDA&;NJYeB&H#5)CS
aS8PJ/?QR561.&1>F+KYbg+XO3/UA@3CeBT@,fg^K1&<--4HdUHT<KVZ5c9LM;/M
+ZJ]]:cXKN/IYg;S\ID4LF_Z>.fI[O(654DXb,II1S&@DJNJ@?J(Z#</b<c<BABP
2,acZ,G&-T6-DG9N9_SfNO:.aE;(PJa:1VK#bGeRM9ZOVBNPe6F&T))N?T6HY?\I
3XUC2Ad\OPX67[aaNB1VM1)&#]MQ3+Q-C74(6@Q)J3/I,)Z7K(;B]=+WX,B-P(O8
FHF2?C;FU/=99S^F#SK3/c0cLc/3)OfTg0:?6JNOfB.]:+SWG)[=]3[L+YTC#M[)
N9H(Z6EJCXSfdfe9JF1TUK-)W2XEdXRNb,@+,;=,LS\?.(FUdCRDER2c7W@]Jf8,
@?I8F\G,Z^/&BPb@JN):#&2X,-Hed_SGI7QIa66V<(eJVB9H6F0#81_EFE2RZf?d
MN^1^3RcKH5BCPWD8:7]aC)6EN\P:bd+?E-[IWMO8_^M#cC^GDJZ<f&0[@<]-K@c
AKS^7Q5bc1I@JHO:K>HM4A/=QIK+#767E]5eN\<C0;Hbg@AY>afQ2]51(<1f<L[_
4UT:ZL4B?F^]7F>)UQ@Y1-XQbM:-TL5]N:A]a]2NY?Gg#dU5e#b,\?08P]-FKLH/
SU5JBJH?(5;\HYVT#Z6IKCP-7H#@JWLKY5E@.HHF)^9ff\Xf4NMXGBKfQ(BRc0H/
;TLV7=].1IL1:D[ea7c&Xc.=NE/V<#Qa2HffO^A7-@JI@Pc5&OP:NBbHY1S#ZOE_
<._g.0,f?bAfPM52)EC#bSSRMXYZK:Z5^5KL8TPK>Y\NXA6878M2@O3f1bFB@C[(
<&?b?VR@;2,.NK3.0K&Y\?,_:.:aPJ0ZJX(H+R7R.75&(HKaJP?5Z0AJ+2JKA&fV
c-?K<66(1NK2ag)@b9VfXZH3Q5V&D[XW73XO:KN2E(RLRa@[f3&fd/2E8.GZRY3:
92>]@bbJU_B?HK[a._D2f/WGYedXXbd)7E.RZ9&5AK7;D&b(b;cYLWC\[OMYWYY=
GcC4]^U/?WT/E#c13d8FNKg+DBNVIEJ[_[cB&DA7dJ:=Rb7)>CeFFeBJVH8cRDGH
GP[Z4ZObIXg[U>TK-^=fJUVY)CZ=[c2aEgL3aZ?_2JCg8ME]>0MK.&P42?YQF5Bc
Id:_=OA#\,Z&;+QJ:J:GT-fRg2?CKg+5+0R.GdX)IWHKUFISbV@T:E-FFF7@+YXW
T0Ef?fbE@+VD:0_<;(FN#DTYb2bad;DfA]M[E5J:a?/J8dICS,+f9STT,]>)c]^?
f;(Ba6<ObbH0c8-342#<^d1d9;.HIW+S<?)-W(VNWOI0>c&S051g?1?<]4JFBE9S
W;7S@)N<E+K,N?6W.@Ug)6;6fR+_LOU/+9eJdU77=K/?aF,FDZCcfHIe[^A=^C7g
d[R&^Y8gaKQKagKT9ddE8^T+-HV3bZZUL?KZggDJ@8X_>c<c).^O0-M3,A7KT\XC
G&:B1eTTB/d&NS0.]M70>B&^[GFP>9@Wg[[f:@VDeVPI.8CI(LeeZ86BMOKA;=@,
JTQB4O^_@fM5FJ;e)#+#>JeNc>,LI5ML;.^&OQ8WTJ2Agg+??4]QV8ZCdgUY#KbS
WN;1;]VL,BKeCd.4;/COY=1VWV>b9]LU<I\(I+C]bFQAU14UFFg&dG2>^8@B?aN,
<F7,E84MS:O>Fd7K@@7?YL5;#<&JUIW>FUaaBRG0U\Nd9DI948O1O\e,eBabe4.f
c.c7C;CG+L^ZE1(L,_#Pg/ePF+DVQC_4_Z@c1PE?IPVR/dQ_34?]2R\V;OJMV=VV
LMX;7<OUM,.[TCDC3@/-J,RTETHP=#?cQZ1K^M\YI\2:[P7OLeCaJ3OQc#Q=OIg6
&dA#GNH^K7(EG1+F]dd^VE/11HF8AH5?@CNN?Y;RYPPP8B6V_A5b;Fa^?04g;9Y=
c0-.^>1QOUd@:Le5.9Kc&,&H75\^ESXD#.Y,QXB:GM6Kc(@QM(-WW4A_^FEPH9GU
VYa)U3fI40EeCSBMT0X^:&3>PSGbS4[]A@dD,#LCL>//A,[7>^2-(B[Fa.Z>2I.R
SJ]WYbM>IaO8gb53)HN>H;;[?UV4,C>3KC((F^R9.PNQI;XEI/4(P;AFZDA8-_-S
7ZMB8E@O;L-5c2G.X@d^aA)L7/C,FBACBf[3T-9d+&9D;:5Z0ODA#S:XC=8BRZ#T
V?_@R^+R=YO8S.5V\Qa=OQ6#a2:gGMGZZ_E#XUI7Oe9R),T-N._Xa]5]5+gJe,gY
e/:M9Z-0(.V5+@/DV=<&?NgGQ20g3>A<8TW(CKcO2eE+D.f3db&R:;.HL:=35#V;
Y:-ggF.ISac<LJCYR]7-2CTHR_1[M@fPWCB/.b8dN<<:+g7)4&]7P#8G005@d7^F
aH:8]bI1c;LUVR./(#3=CRUM2+BEbSO?c[34ABe[G#\L7QB]FZ7-VP[JX0T\EZg_
FLO(g4NS+e2HgK+OK-ZZ:.PL(E(Q)7Q91E.[_YJ0gR#6E>3aM@N1]cO,G):@R/,;
8dN,2S0HBdPY]?\6C+=7e_FLX^cM)F:QU)4ARFN3KLg);7-[T4@3?I[RT-]-VYZf
)ac,HNKEG+314Y[7U@ZFeANAfX\-.b<.@LS+K.dZT)XOe66_)_/CbE3DXKPL]QH1
@7^1d_+UH7GMW>dQE<4&bW+Q_N(&V,#\]G=<?4;fVXN&=,9L_bZaXLV\A#]3-8C7
VISc7-SC,TBJ,BgF-+9,9O3PX>P#HaMZ&U3RD?=K03RL9&OKC62]0J2)H1E+XA=;
O6CK=aIcYTd?])B&GB3GHI_AO,6TG#6;8GQ3d\4DRcHS;E]O]XP\/<:UIKb>,Dd+
4&L6<L@5]#19]G9>=IXI9&7ZZ/-D0[?eVfT-^B+#fQTgIcBQI])&))-NgQA2PVfP
IYYMeN6D.DA]5C-C5>&7Z28@4&0;[DYV9>4K1f-AK5B-M]-[IJ.&7#dS(e;DRE;E
2CUJd]cS5(23Q-FX[\3M,Z(>4+De)/,(He9g5&0O>8cD;23L@VR[:T@L19bCK(@#
VDdLH+NOD^TRUFXE5PdA;TVa-GH6ML14>CZ@C(JN_WYZJKKJT;>[5Nb9,Rc8<LS(
LX?1)c7=QfADG+12[dCb_@[Z0PIJ5UNXYPfJdcZ?ADH\PP5KY(0WBJ<d01YFBVad
3;>7cOH2b)/R/3EUK_KW2X/-a.-<fUf.4JPfe]Z\/[?JW7COH;+X:MPLAffLSB>5
9=2<WI5#S^J-YN>7I-,12GYX7]<GW7;_N<L1^555YRc5./_8GOV^_b)]CC-,0c+K
VG#]&4d:=UMW+ONN_>1DZA_J?5WPM2OFM=<J@+=:#7IN>X#-&MM>;(#,)bPfCPOM
7O48O\@Q]BQBT3-_NH\&6980:<_S^McB:UC(5O8WIU92dXbORT)^UVU:1G/PPV5U
9Z]Z_87)eV&bHQ-?2AFLZK>J[6=Y9FX)MX?U[)>b>Z(G0].A^D_Y0aA=<&]A/_C#
T[S_)).C\14g\g:)-?RB(Za2F&Q6Rf\fTW)5@NWQ:bJb/T32^:>XT.BXFAA</4>H
?LV:)&S_[>&AVS35&A2TLN&a/Z\A>I]Q(+WZdL8PW6]_TX66)]U/I<:1Q:7b]0EW
?X9FD\gRcM\2DF)5=&-16/KRg?D(7fXT9dYeI-57/ZLM4LX@:V(EVgZR\<>:=51B
@>8;_3F[6[PR#,0N4R^>E>C.O.6/4a9_/dWd[4S]RSDN0HeTN_B_O7ETVcHLUWdO
HT]Z5,Q4YD5K+C0ONFYM;X)_)\Q2IQ4L38>=^aU?<M0Wf2A6Kbe,Wb96)DC^BVMG
&VT#NX4YdQG5[7OJ:J3faZe]?73G0-L9U&]/_LA9Y,cJ>HE6E#bRP4J8BP-;f4/1
I/#;C)P4CT@#DB]M<fJ)b8P\Wd]e.#O2:gc)@/eVMge;AR2=<MZIM5>EeUed/EWg
=><f#DUFJKHKZU9Ie[+)5F91C8[D5O]LE[MG^;;V9:O&R51S/2bE;-O0R@)>f9Q:
Fa,3e(:@cSH-DZ8c8_1D>WN]W<6-JfV=:@Y2ZF6TeMD<T8DLC)9C<GX:DDUcDUX2
<G-GBf0X9MGJ/^\?^<B:::81CSH2SfLK^\Q(O=ZSa-16#6W3?6[E15:UA#<OA1_1
+FA@3bNZ#31:IEG[TK_ZT-WaJSS#UHXS)Z>9BA]?957CMM7;c\-D[N@TL(<^KV&<
.-LDU]9);4H(&eM08<BIg,=F6:eZe4(B,eBPBeIF7S8G&:JaLKdRJMFR5P^)BF2S
]f98824e7T]3g=XEEZ<d-;GI3:._E1=&#7;#<V@X<K;I[a&?\1MHE8^^2W7Q3KQ4
V=;^Y<[JCOGRBA;@FSBGMWX>ALbBeC0BPfObB=8O_D3\+K0@4U+15H^^I$
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
2IN/ZP_9-&EE-Q:58g]c8--#(a[=))2;=-c_(CX+(Ie3)gfR>L:M8HZc,^=]8=K=
2+/OTDR?((gS4aNX,=YWVCFgT.0d[(N:J99_5WfMgX#UPO1ME5c(OQ4:>M+W4faD
9B.0,H3LOVG>X7DTO9?eY;M26V+HLH:1Y:d(R]:W0W5KLBL2O,dUWRS=I<RdMC89
B)]9Qe>[E6ZZAP4D?]Qf[5E--9C^WU2W;G0KMLNbZdEe7_f4EX;WgO>9>SIeaX]:
a-?C]P_LKd2S2_[7SN)-HZ2SI/a]()UZDd6A(e0]VWHN)::SE&_XCaOD6+CfaPcU
Uc.VTH^4PJ)IbHY0GM]E_8OPQdXL3[a#]d@QPN[FLaO&PBg_&gZ3D-]PFc-K6FMS
_28X5K?9XfZ)HC0M1-g2PF.=8fP.>-@Jb)^BK8W;MFX0?;Hc^NW<C)aCYR,YKCR,
^K]AV,3]e9Z3WU@>T><3caCQB:MCK9L)Ig2LI;D,@W,BIB,XZ&ODH90\5<YC8dc?
R:,@N]#TLSSe.-<:O,(8Dg)AVB^>gZ:?f=FRAaaULQ.UO8)1][FG.KX24U/I8X]]
AeQ4?H)[0]OM>gWG1,ECLg_4b_SN,Q3,8J&;_NP7AKRBDKH9a:^.3YOWde=BUV?#
U\<3<?N@+K0.NaXY&?(5Cd&.)Z4fBR@ZW&^fZbG[0c4Y)Q<C=+9AYa?dM@55C(&W
>2V(_T,[A0)RQ_Ldg]2fXPVOHSP4&G.B.)<C#-2C_BV#>U#7>]HVZMY05Me3ZDAR
YY8ed-Q?QH\Y)O(SNTUgRJ[YV^BH40<@YgY?b_DcJW;NTS[Qg0=@OMUTL9FCX2E&
b=DNUE1NB=;)(R8JddUM,-FZ@,U7F>.f?#;&C=?3<^K\MEP6G1N\52#8WO[+#E&5
16eMZc#U-5YOHTP[M4KF8g;Y9I&TDcMDgJDJN&AK#W2Z)H_fb1<Wab=da^Q-_O.T
82U(HbIJLEECTg6dK8PC8c9L@6J>]^>.aK].T)T]LG[=dfV((:gRW&XI5]=H,=5<
^U:D?XYHf<Rf4SE[75XQ9#MKa_=-L<)9T(=[_eeMeQ)A?7GW.KYNfY9)C8+)&HD<
)A9]?8c_eLX<&(Bc1U=KMUO#e-RB\8]/fA3</PKS:BUYQ@ZZ:.B\R?AY^QCYgL.U
d<@eA9ONVRP0e3@ZfbB?EJBY-#^Le[RM;.1,I8RU^)7Q2G.S>.\b3aY;.R6&\VX]
1W^XV2B/WB+^6CX<b<46e(TT>GLL1D^0\H>;T)]KbIc6QR(_L9L.(+#PDVY&D+N(
+3F?R\.58,=DPIC<V2W39cS;CI#@^V>)F[-:,@+ZD>?gcgC:=D:fEPD;]^BEcSTR
VJXP)[+LCX@WXM/^\RaTO#d4E/&TD932;@:W3]/8PP<dKHLg=&fUA(cX#BW?06bB
JY#][.WB;eWT>Z@5F<cWa<FN__3efK2.0]UOT6BO2cW?+N:+4)=]eQW-U:(c?8S<
UCIf[G5b-JGM@N>c;f<S;]^;S)UQK\I\?A/];C8Z-DOH,5DE2#dMRYc(JHG9E/f=
gV9F3A=/F_VCcM;g-e,6beEc2:[.U#6C6HcQXD^9b\VA\8Q0@L?7>D&>OIOSV7a>
Zf>8+O398G4R;L05-;EeGY_MY3gPEX8(Z4?d,Q(_FLWeDN=^FXDD.QLa<HJ?9IZe
g6a.BRH/._Z)D07EeU)Z5O;EZF#;CIW#.MeeEY;fQQD3ZFdDg&ANe(E)Y[W=B_Bb
IWdD_d(1OV.H=9AI2S@;/Of6_gD[[TWNN3SU>G)UXN^VJ]J=D]_[,c.F5fIRdJL5
]+54UD(5d2(J(G/ND,N6>4PgA>Y,eREWW/;>JIQ+f5X+#b.O.^g.OUT66,_1ZA^;
8EPV+Q4W&62PSP3O3)3[?_N1BW\d_X9OAAfZ@OC)INg=YH431)EE9;ccF5AT)_L0
gBZAMBP)__U_O]QYF0M+Q-^J+6FaQ_Xg965>789>VaH42EUA)KK&?HW4UH/>KMUR
UK4:(_ROM7+Y@RJ3^LDA^XfJ#S=8VCe5b\A2PEF)S=a\?EFf3f8H>I(YQbd/N1G9
0Y+K#8C)0T8/T[BZ05\<A7R]H\5PHQM)TdTS+:d0N<0WE_I:eEVL6WI];+U(:d:+
R.3^LeWPY5^U=Q?LGIG[e^X9cED7C:9S-@c?Y<]/&8QY/(Db0FTa5KOJ<-bJ<e2G
#IPU.Kf)=_V.[N=QL;aD36NGGb,Zd=PD]3F[F@ee94FC:L]>23dc:_f>N8e6e_A^
bU=8VIRY:W^f2)7A+fT_V.X]+HS;UN+GA,NG:E6?PgM:]..U:CN8N[Z\Q@LgZET)
W,-PV9g7<=(91:8#>,XOQLM^K,,;4H1Ne;WRTL#ae(TgZ3ad2N?O0&2EGBfa,.DY
;/W+\&cg<Rd2a4+\WU(SObb]DT+T-^H)60;QE:ELHUR#E9&CNG5[?/>NMQ8gLZ_P
1;O-@G.JO4/H4&RY#D#5)bN:?_C_>0GJNDLQ[Ic349K>=-U+Wf^RL2b>B895<+bM
_SZa1&[VAF[5Ka&V@3cDgfW.W5e2a-:6(@]B7((?e6ZQ=A/44OIA0<#Y=>RLd:DN
]5GKa^30@(J@b+RV+ag3C2<S,d(^/L2SOT0U[fS;16.17MYH[,]\4@gMUg]BUQ.L
@FM..HS.3fbHRKUQ4,P:\/(?a=?fc-<LA[1Cd4+/SF=g;#-ES]]N<_@EDIE>\2DW
U5F7_?>KQ5L>g/-]2IP(3g/7)4QeI+/+YO1caSg2:(6K0:07?]=MXR,;3<B?(gES
\:6V0PFZO/-KZ=2\=L1[/TWPK_PL5CFHfQG[+S6Ke[AA-B^O@64+=PF:eQDH4I0#
N7?/8]+Yc@b;[G)68]-WF:]d#K_PU\).RCJVV)&7bKBP.-2W;V/RgTD.fA(0V@C4
17D60Ka9CfH@+T-:96DCPA14[EFfLZ+7\II>J/\W(VD<d2OG)gD:K4DRfC>]fTQ?
#16Y/IO5>[d4dOZe^^b9E&OdQ9BM2GW^TgX8e&BELM-EJ^<1^9]KZU;_<fe,7>8P
dSJ#>/62/<,CII1Z>I>bVWSAPCR5OX[;2YRe?=LI^Ka71UG)X:VcRJg3KPK[Nc/f
C)B33g2FNT=96TJO?0_HU[Ag@I3&3e9W]f]d_XdcF#aS_S1?SG>G2;g3P$
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
77SD&AYU,X5B,BaQ=&2V,;:=<)QD<PJR84MS96BR=0)=0JR_EZCb-0D_(J#09>)g
N[cLDIX2;R/8f+2=@N+=A+NR3Y#Bd9Y]@H&CA[;B:CH^f^4MPZdK;/0G^C1^Y(.f
^#RI_fR8#N;R80P;P_<R&6O@?=DA<VE0YZDb9CY_=3Yf_,d6AgW7208P0L_bc5\.
fc_K9UGZIc)M+O4J3UU@\,G>(3P61PA1;0V8[A&X<#UNTR@(2^]VA]:/K().>\42
:^76b8bU?W(@;S[;E>6XN8H]2DX7L19T?],gT<:_.e\(V:4dJ4a0eLK30U#R)GB#
eJ\H_[\D8C=&WVM)+,-U(Zg&,PHX3I/GYfc9fV/>-4@;LO0QOg;:@^YT>T62G:B;
/0^-[YW2EE;3&Ib&OJY=dfgE?@:Y6R67U3ZDPH)+ZA)4fW0@#\3F89X22e)0PbeZ
8.VWg7>c.aSIXWD]&^2R,_/MEUGYN;C,8dW#?gUeP9[LG?0EG7?@g_I<eP3e#.bR
^IVbT/7RB+W,H[8/4T^8DBO0B.Wg)MSSLVQLXND^1U/Ea?J4S\aRD43=2Y&a@g6Z
NP/WP@-7;.F1a)>./aYPZ+^JT@OVbFQXBWA\#cc8J9>>3S(VW_:SEeLE9f_Zc7[#
ZVTO8MeKcbLZ21B2_09U5C3O-^:T)?;2TIN(//0W7;S([(;Z>,VbW58#Z[.QUU8&
V@F&GbX#Q=B=.\JaP\Z6(SQ)18C_PK43M[-&,7-75_fSa6Y@.1+5KP#=:TO7\Q,:
YB#KH=ZWBeIeLa8d>JF+(9T@(C--NG=fDVcE@]c6ASgUd?XbadY2S/Tb[Z@F_,a<
HO0dNN#S[gGLPEZd2F=:^P&MBOaD#_[A_X#f6V.AfK4A.+X0\g[IeR\f58;A6gZV
6=ST_;&Q,QN,=GN0[R4See>8aLbdA-SV_.dR]VZOBT7;]?=)P2\21g7SdXeb\J^U
6XB?J;5B2BW]-Fc#4eBa3O4d4XcHgJ52=b/1C,eAg<d/+b6Z48&aEX(d0R]?/aAG
6>V&(M<1G-+S:Je(_+OgJ8;JCEC0#G:7F79[_fZaNXUNQ2S_Ka/YIR\YQ(4E]Nc2
:FSIBH<#OT>IWY_@R<7[?09:13J-7]LP./X:^Ue,Z-JB/4O]a4fX;[Z]:E3KB31E
SGE0\Q[D#MLVIF<NB0H\gZWcD+;V7&(2#B)8.O4[X?MEP](5E&/L=,&Q_)Gb)AKU
JS0LFW3[C+(TLS]6O)ZLD-.AB3db>KF.EV5:>-PU+dZ:A>L1Cg-</3A5La=+0@HJ
:W1LS+)J7E@g6AgQSc37XRaN_@OM59CGcgdT?fcXU5.HMH.\]RagYEI)S53B3X<a
XMB89KAfBC]cb+#^B@I]SO5J)f=/.4.@fI[P-0:F5?WJeD;>[;-5)\LcEe[:<\H1
O)55IY@FT-<EHe:=Q>)G7^S15I>._2Jc2)1ND#GML#>C<MW0(Vg;7a.FdMA4CKMN
4:,FX</&7_S2_L<F,;4M#]d?F>(54.:Wc?B/-MQYCOU[B?70Y&?\fgMR-Pe5d)7_
>ZQ(-C9Ad7GZ125T=-OLZ.I@&)W,g4FKIH\9;&Hgb^0+e3?XQEO[a[;JM-85^#IS
PE;=-Oc<\e69,c8K]4+)Ue0C(?SeA&N@<]UN@>(D82:-aCQ3N>XcP2PTJ5XB7A9A
)Q<&_R8]=?1[+>BNMY<.4&fIfQEM6<?9cL-(5HbKO3-GMN=JGNL?QGVEIK+fA(],
:CH.PXSV&M=0/Z4>47+HBUBI]g[/^e#][0f\0-0?40)4.Y-W<P5Y:X/4f500cd_9
[5[M95+M?1^9(GC8fHCETC(?6?VPMf_0^@NOa[0GEA+bOa,/f?MMafgUV(K=NZ2V
,#4064WeBcVJ_d40I-]^LGOLP.>WT1/\^N9_,.V95M8(_^NQR([H5I),(L[K.63E
.CGXZ=H>gQTYGaM&Kc#,VOHBUKN<]27(TN[.@?/_+)IC?+W(GPO+D8CTTO=]V[FZ
W;A5XETb42a^#;W(\3/]X0WYC/F/#MTM=?=:5L:1F7^_15e7gE#b?eWCafK2]-g,
WXdB(H):-KC222Q..KF^^(-4RN7:1E0(W^)H#X#BbbcH&0>X)<9aS.NK(LSZfTJd
I(S,RE]=W2QR6@P&.E(0SA[RNT)&H_<E&MZ3c@aU:=KfWHgMgM-GCVQ,LLVPfUV)
C\3T?NE4\M61@PR;><)MK_@0#(BO@XUbA-F9LGSe.Q^AQ:4JI@HcE3.X@]5?5MMJ
&b\^=LcDfS1+2,]LG.?+Q((-,KMZB/Kd1#@-DGF0:I@8YF+decSP@HMd^-59?<f9
(][EL#Ea3<Df+ZgRL:WPT,c?@e/U_BFaE=>(Ic@3[+5Y?55.gE8YU7]=GS?5[9YU
Q1_.X#TUHB8YS8FH5[bISTI6,F\3T:[cV?_Q=IOI;0CcVb_HJM2OZ<-a?U;3.D^M
86WP)EM[M0^[&N8\@MC(_Bb.WbDf<Gf+bR^D4dIF)c6F<)&CD/O(EBQ-Gg_gE-FG
WE6bQg(ILe-NQAA[E@6Ac&5UC.]5@R(5IIUDN:>[C2,.4O2[;UeX+9)NW3f,0/c^
=</PGe[9eB23BT-DGIP7:)Ca@5&(3D>@S1:=f=@->L)U0#DY20)CB81#TK3HAYK=
D?YM[\BbJ(aELO8AAQWUe:>Q@HQ2NBZ8YY1O[g,7Z.,cB6N[-)7&\RGI:IK0?]/)
342M=#;dJ7Y_a9:WScNPVNGWORR-YW1VF___6/A9<\9@JOf_)c.)d-S3HVa[[K5)
ERe<VJY1-<BT0UW>XgJB-R?,OPV;e)CSd6ab[BB:R3.?]=/MJQZ=U=8D0WJdCE,-
dWIXHa]EH]:c^:7>.-N-05e,H6NJ=]EY9<9>&L4XR1CPL7X+gE-OW&dII62QAO3H
7@f]VReJPaRSd2=H<TCc,Q#.3cb(]SJB+ZS)YEEeNYN?a@ZbEO1,N#8@U;I+)&XK
CAL<K1I7>6F10SHLHF3,>DeJb7<d0;6GgI9V;.aR[7YT5RT^)JB^1E=d1&++[F<\
Td4Qd>L37L,?3DD[)R?:N/4D#RB/2;WPBA6])[R?\c3dfE173;>Ha[(19#NZ&D^/
JcAZB^++/9fJ65I(REC?^Zc79Y(HM#]Mf[4d=39+3=.\@<W)=SR7A9I0+dVQ&^M?
W.c9OJ)>Fe_&6bg^N05eWL[A;>GAM,#c;61CM3NYHZ<38=&,0Y<PN3&IcWdPbed9
7LMfTG8;3gOR;9=\^6AagCf^6dU(:IJYM7C.I:#V]CbW=IL)T4?@c,_X[B2)5eZW
I72ReM9&a]O^1Qe@+V43ITbRg?]4;Jf]D_>b+ANSG/2\^LLIgO)c,+f2^(G?fNHY
U94N#[>7[6?FI4J(MX;_AZ5WS1@D=0C(c?(2)RXJb+)]S81D14[24D->S8Q?<9A?
bFF4+X2X^18R9KT[Z-F<=22d@TKX&)Y<,T6?D8))-ESTRYH6XfZC(P_a@U)8EH/6
aN?HUYL_,aLE?[_8->(ZAgUE5AA/@-3HQQJOLQ&Kd<5^a^R#_W(+0U6T]:3/S_/Q
HSF.?M@;Y_LGM_O/C#\+(._POGVbTJXa[\)++;[G)?GbN^2^UZb?229H.NIPZ&\R
?/cDEI/>.;TV8^^6Y9Q0+3:X^@f7R(\S2592K:^-_QHHN;0ID2W@2OZ,TSc;:>=M
-@eD?#X969^.a6SOJ_JPU]NI+W-R.?MSF]2<g=,N9#1>P3+4/,,/D7TBCR+/YYC[
M2;GN[@2=Q48Z0G;H6Nc/Wf].2V#,;LFM_XPM;9<T.LUJ0:8JE&..DC.]KNX5K;d
7P2#Q2L6LW<CT<X99GZY;g+S@?)NJPVW2\:]:VVXH;H;T8E#@[;[WX@.a0<[2G98
^J=KFV;Z3N0]&S0>ZV/OGfCL,=V8^VSAPHNb8:7VW=E045df3<,_<d\^a2AKZe;Z
7N<^6AHd@-,FN)c/G)\gN-3(FN?P:b)SJ#&WATNAf,]#?(NeDS:HYQVX9a7\]Y3S
#?3]:+/Q3#+F;1W<;IONeYgU?0WFC:8/;QU/gQ0]^9,P#+=35X;_eMe,9.S/?Af7
WWASe_c[,.-2Bf-d^B86OMQ\>UOB#[<::J4/)1Q(2J/;>RF.ZDDYZ9cA9>@X0KV=
PYF^-]PUHH;=#&/+GFS.ZSF3Q.X0Q?-1H[SCV.3?\G@&JSLKP+\/bL9f4_9HSS-I
f-;,D?_(Zc[>Q^&^?B_+]4#9OebFE=DdA(X1[18Ff4:RVJFPd1.faA?@Hb<@Z-+9
1CcW&>WP8\=Bd,?C3@XJbM;(:7[\RSC<59A>PgBa4.IHW@LRKDBEL/Y9g7EQM:5+
5L<\Z[V_0;Y/[&3D[EQK]WQ:E3caA^?C/__0#^[08R1\G5SJ);Z<8aa-8^]&0;<_
JV,4\Tf3[IQ\RA&N?YM/9S)RYYWG2&FPT3aC3f_-,#NF5]PfSfYF>Pg6P#ZVECT_
6FdTc5:OS(=<JgA5?_WVSW,^_HKMQ+#[#<DJ+bb#=OIP79;4-V#67XMT_.Od9b>c
K+ICC6K,T7,4@O5[XMf,[b^cR3??AOK=/?X#3/:9(=B+BAO1:Wda/b_87]19KaD,
W6+&6e:<X:g5?@&)&4O(]7C0Y9D.PP-3F&)_F@g&R8Zf7ea\BcRc3-<>_b\VdL,S
MMdK;H4P7N[4=^R^D\Ac\2EMOb<.4_];;._#R<X_O;L&OD=Va7]W(FX139fH]a_B
5McFKa=MLX&W+)==Lc4]-Vb8XN/b2c/&J/aE6YJMb87YWQNe3W9UQ>LR&<MXG;ZE
[S=aM(]G3UA)1&d),(5@T@@.V&+6gJg+NcT_]0HeaMRMO7Hec^E[;WVJc-Y_c&a3
V&5_cCT0/=U-1H,YdRY#[2FOPJ24X56@gf?]_gIL&T]DA7PFIAMM)Ha1EGGI?,cf
<E,E&c/14Z=(HG(GI7EAK;@D(aVE)?APCZ<6PJ14@6R-6Za\3>=TELfM^M&[_2.C
T_/YE?+^4&(baU7b:8U[BdD0#0041[GNDA#c[BS)M>-?f:cTEL?WOHF0YXT>#TEa
PXG.K(XC37.3\J_GR@[/cB/BXd5]2U094;QLS5)A4:A2E-F.M\-V\a>^fegS0>-@
S3^R:(d7&XV2@O?Gdd8f=?M0Ad&aG[Hb+cZ;^-6#]AR#2&Db(<Jf]CII+58KKa5H
VNU2QTfgPE/6RS4^<YVa5g]9f;1#E&OG/M^(U4?4I9fYfATN/L\.Ab-FV322b:/N
=S[4:,C.T#.Ie)/Nd_B2fT&JfQ=DTG/fR]L)aQ1S7O@gII8DO#Q2>Fg8gB82QO87
>86@:FZ,H7bUM/@<02#WSeH;2MY=_/K?E9=Da9;Z]f=C(F<@(,&RbgI^T^7.8[;4
=JB:A@7<,N)1HbO)6cScWc#NFc]R=?1S)R5AX#S\+]\;;3D],Q4/BMPYcf>#7VY8
XWNC(YW9_9_BK14M.TG+26Zd]>f39-784MIA;VV(/Tf^+N)]XFV4(J>bFe1A_4EL
e?M@;I@NT4T3BL@D29#5F;UVV2HNHMa_0HCT:,E..L//Q<VcBJ\88G-6eEg4e(PH
aEfHdI[=]CXD_WZbC8[KeaOg\6XEH]YU9P2?LZ3E<e@L@QAfEQYLJ3QZHAU4C,7H
YQ1A/<Jg(^Nd:?(H5Z+4DR.e(MI_aRK8#0,5V@:&/@M.Z0G1b8DTNW^CE/7OXY,.
8b1/\_:Rf<U#].8/(R2(^:@f#5J^=e)B<;EbSRY1SWUN8?>T9S-]ZB,aP,NJG_8d
<2Fb#7TYfB..gLJ73c6=8UBeZ<F?Na.C(N?=gf=.OCQ),7=81@3Egf>_V]=S60M8
NS1Qeca:MKV]g#,N[B;@5HX,E4DAe)K;>564\28WX8+9S7/E3_<4]-c.Y=N\LbYF
QW)>^E:cZHLK73&K6aQ=9M.If?B]f0GW+IFB/d[/-Y6cVafg\G6?e-OV>SR:ceFD
)7U<+#&Q;##eJOdc2:8:LH]dS0TYB#bH><7]CV-SUY-<PSEXE2bfYJKS,[G??^c\
NH)SJgcfQd8ZeVVbAYIg&#/FTS_3Q>c?<@=HUO)Z?5G.a(V33S(;G9J;3/13_PG@
V<=^5L=D3?.2QNgN0<#;Q6]fR.KV-=g<V5/WFPQNP&LZK=6XS+cR3e]]@)YS8bWB
O#Y9S4gE11R9Y5gDYG^C.);#O(1B/4:D4/K=gKVROX0^1,QOKTD1,fI<@W<Y&c=H
b7&EeRgM4=ERM))f&-NJ3]P_-[VXO.ObP#G\<#+]M\e-5=6N;eP[-[N28fC\;b_g
(M&=a/f7WAD^CVZCPZ=.5bbM?I4&/-CLUYOBE@64C,db,Y1ACa.WO(>ER7)V<b,S
3CG/dWCF8PKU&.d&@CNH#]ff#/FVJQO6C0>H0)ULFOTP\g0V&]f1RJLH^7a-_AE?
e@#\[d#&+a;]XM631=;c(#-fV#Y9.EScRQ0TRd2CK^)4BNI(79)R45d]Ked^)T.X
fVA58O?PE;DBZL>baaab:b6a4aK5:_.GEfIO-9g&44<K0]HS93.8[IcGcZ\^:MbD
0=[?_LP<CO0dGg^YS?[<Lf@NO,b<I)31A35Eg0(H45f<PI]c1gf_^<+2Z5;AU[+Y
0+XI(^7c84+@[74Z=Z4X\(XRI0GI-BXW-BF:E^U70c4>a(aQTfRG@^W7f.72ENb,Q$
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
/TG0IbZPT@&A9M=-=0_L9O4_(eH[=[U>8#\.<VcW3M8dAS.6=\L^9X-,,^]=-3:Z
Q&;eA>.(7FgF.LdQKQN^dLG<gZ;;>3aI([Y4>G;G/28<3a;AF3SW5b^J4_3T59>/
L]5<b).4B&?KZ8722:TIXNI.).cHP_7X0:3^HMDO@&/X;H.cL41>A\PRJE9c.+&S
eQ\7]\ZX5UXZ)WOPCZ+;^]MKS;CJV8;0).LS<?:R<Q\3QY\8,d-54@bD7d-)^M24
X+HR\6X0L=aI;+OJ>dKCC;73/cQ3;B\].gQe=#O=J[SZ/3b([WGB_ZI]0fMI:G3&
F+\HLPJ6U?-F>7Va/<-dI5R]D6R]d7f#^TAa.)P?L.2HKZ2,62;DIE.[:CXIM]5=
6+85Q>[e:H-UffPB2Eb^WE7aIUC-PIGV4=.Z[J<9e0C2K8SL,TDCdPKX[TT2D)f\
#SSb4YHc&2^+_2ce77J7BKD.H@>T@-OE#cXSA+2<ENJKQL7/d>3@9Q1DU@Y/R\2[
;CH79<4SNM<O\)1DEPXTG75)3R4fV\]UM6S,@@/4fOHcW.4V=]gfaK\6Xe0TJB-G
VcH6,>0XV=MAR#\)FbEgHc?>#Q\G&]cdL4f2N4cYD^;cYPeP<)0_N=Md+_A4Sa49
GW6f6SU53LEF_OFM2\^[YSE^[XTJGQRXTY9H?[SB7MYEX#WYP+Q:M#@(a<];B&fX
I]aJe@8>XbA<EWX9]R@fGMISVCg^K(VA;CQK-&&&5G-c>D^6ecY8#VK_#W#KZX;W
-1\&dM<^.F4:5Y]M)Z=[fO+Y6?XL?0dU]OX:D^51TL<)(4Q.&(a@286\^]B6LO;d
9?^OWdc_Z6e:cGVHD^O/]YKG2;IZQ#_,L.[=P<[?+e_S9<7QDU-6Tg^>e+TG4E=a
4^EDWd4:2\G-:C],K0M/F4UGV/X&IC5@1:cYb&?7A<g5YIE0#IF6JXXgID??bRRf
]I2SM\\Y2J_]R#NJ-P(@7bBRMd:#VZdK3ADLI_-B<\IY-2Cgb5U&D^:_KJaC,Z#F
6d-;fH>KUT6d5^;-AFNKQX+J71eAGUgHb8DGMRC1E:HU:RZQ\=<6Vd2d5:,PEc[L
P\I6.^)_eN3KM+[KMdWXa,+Rg0#-^Ie&U&Q9M,178P@K/G5Z(R5[[<ab8W3d6?;;
MfcO_aPQVG(OZA\\d9AdUWIZ+1P\=AB=9CJ?c/<1?^4]8DCaCRA1?M<OLLcegU)P
73@fB\V?BJ4QZ;UZ]\Y9.S=8gV24;@D5RL0J4DSF:3/RXbA8L?I/EVAIX1XU)b#g
e=Y506.2ULIU7J1d:5ZFa]619XT+7P-T#H^JA-6HG:I_#)_\920e^a:6PSeDGY0>
6b#A^6HId/J#C?;FeUO[A9@6c&XXN&O/,aHa=d6<834JK]=;F-gLY._,5beDY9F6
f5?T^IS0D.QN;3b3WD9N)^>DG,-ZIC_T_gXSBRaHLN>_L3gd_Zg;<@ZWDc08#/\2
^-(:-;[R)(F5QN;D-9D^#(fKJf;K+C;GL4F/&&8VRf(a+_:f+&C>\9\XN(?#MZRb
QaS)bXO:+f<;^5ceU?:QK3D]VN6N58.c7F6W8?D^A@A)]g[E6)GT^@JO00,K)_2E
#-?Xe&]@MU9I?^9)M^f^I5VVgKC)B5ACa@[4/(&.SggP_55L.dM<8G2#=7^H&b9Y
_R&I<8,K^S.c?fJ?SVUBUd7I_e9TL&fMCCB/RDGed>EIFScCRC@c;/=35V-f5)aK
N]:ABWG#]fXeL^a7;,9H\4g]3B5F#1Y-KTRa5)=<bKA+2Md+Vc6(^c;>->S]N>_?
g/UF^]Q\JH3D>Q\(f51,N.Y))/H0A)@[5+WK[_MX/OGgg;I4G[QULJd5aC-f\I\9
J+MMc(e[(\]PO]@LH&-IX^]3@EI_+[afb4FQ)/.Q1Z3.cREX[[b5L?a2^DE71B9V
df\3CcHYFV5S,\>L@6<,4HcC(-T=b)@>W+H&A;BS^<1WVV#UQC_-I&.;<R4?2_C_
M=cfG^g83E)d+?Ad:->Y@#J@:TcOOY7/f_1/M5?;\45<DPGUD:0BTX:,W#[2@;,[
-^1FU788Cf[3RW/8:1I<fW+V.)G.KaUYN\+6A35HF#PZ(V4O8U>\A9MC5Z3DTbEY
M#G^Y6T8g@Tf+e[:9=VOKPQ[:IB++G&O^+McQF.=;X+1@8M@A^VD#)cG+(Q;R,]A
RS])?=<2I6KBPRHcb?-YIQ,^1#+H;8;OR8HD^5g_=MY7S[9We<dX[&S#>.f=#Jb;
a0D7AVHe=X@S[@>W.X]>e\U\c.QRdP5#2=LCf=)I]V8>.;1c[UG&2XS-Ldc5<(FY
NfXeA866PMX(\(,aPJ>e;C;VNN_@^QZDE/1J:HF[]c@-8BT_/?d-C@d/Gc60;4K,
HQC]7[4\MPg\\^RX9;QUYT68JA8.1OQ9RD6JB)OU;R]ef&P5[I?fbZL893]<E2T1
NJ;2ISCA_##P7.9E\5VHW]F4Q_1bFO4-J,_Z)FT+.ZBcUM&e<,=L5=0d-E7S1=BD
,KfST/(^0\L&MA7R,:4g:09g4f<FGXV9gG+VIbca.N(XG3#>cNeE+.(]F3JQ?FO;
OL?@L-V@P.WR.+HMgJfH&DPb0)bc\Ad4M.,1>-P4#3/ETFO3GBZ0^b.<)O_@ARA)
f=DBEc#>E_PE738Bb221<b;7,QJZ+FYIOA;F,+)SAR&/=?]1NHKY#=HT?LBLY75:
ER=EX_dSY/P3EgNF0,6[:a-?aJ&#B]L^)W5NAG9U8\[[/3c&F>aW_dRZ#PDOHdc=
7#4aO_\,.AedQB,@N)_^?H[d8G84.RJALKeZcYCUMQUH]9CD70#b=6U4[HB,I@DK
C7VS_RdIdCKYR(V)_]5.[99SLEF6g9O;TL]Eg)3ODJ[4DDU0eS5>1La,fE9/R]/>
H;J/Zb4P/7BOd)#;517@Mb@ZW66>+F-E]0MZ<4DTP,;<PM)>93Z]bLcG7I\93@>6
,?@TL??GHe8[1\1^5NV(gZ]@/UF5cO2Eeg5UEA\4966^He,e(XVV5Y=TV4C/NPV^
\B8,D82J9O0ef)EaQR+g+93O3&)\Qb1VNNU<Y@IO/^eZ_-3T]86#+CYH?6^).=fY
>gNVJ3b@OHg26^41YOc8F.Vg5e\E/O#Bf4b&(5H;Z1A\NI/+B6EFLbM7/P)<N?2.
J2-MG1]XDe.X[RSB1WQGO78VgdJHP-?01XE[a?b-E,<(SF>gc:D8=8fg\0@afVgQ
#@5FM<6KQ>;+[\0XR8)QSN1K;CQ+/@0XMHbeQV;e;5N(.DgULObFeD3FF[&@1d1?
B]DfQcV\XHS,VeVIe;8>J=^\>:G>V70CD8c)gUH<7>9LAKSLI]5U+=U5^B84_X1R
5D^dQ:)7YW>:4?&=49.^8SVaaSN[1G6eYZ0BJ(VcQegN+eSXY>(9+WU5L$
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
WdN9?0DI-.W=8&<@=5U)<0R)(3=H9)@#<]@S9)9&3,eb9McH\N4L=#@D)>[W-W?\
N3+/Y0MA^-7eB#ASE1<88DKCaO_2&WM9>QGZT[GR(R+1TPAY0YFK:9M[#=@R:P3>
&FQ)fdG[@K53(^Vf.J:)c2O\8EN9EJ=B(2_[S#afQU:4-L=7?b@>58.gDALc#MV7
OO-I_-Y)\Oa9.Mdge9FdRaSK>JMF\5118[,[C#UN--\[WC\Zg2;?;I+V7ZW0)3S@
4Z-3C\S0DZW8<6NFL#f^70FcJZ?)V\@J?7cda1RUbA16U>FE,VB>+D=fX+(N8=4#
[5C8Cf_Y#W6\/2(=O)/55KZ/C10^IC02Ng32a>1KJUGI:GXI4I<WAG]aeEW1J=N^
DXR&/dW6(#\PX_)@c7[R6,2Fe(&>A0F/+P6BMgKTPJKPfGXa/WCV7Z&4#cCTG8W;
b]F?AaVGXaSQ)da/e;YC4WYJC7DAOE?a&Z,_+#[cT4\61ZD0+1T\6+88W=JP@?LU
7S7FYA3<ZMCQ8Z6LW^XOHb)2J+=GeC>,S5A+Q1U)]F<&E)RPIb]dU./-FB0E.d\5
<YfV&4,@[bBfN&KEa;TGaDM+(>3U8,NaQ#CfJSL8a5X2D[ASLUfU&DMN>P-R+a(0
Rd)/gaF+<BNQX+I1/4Y643>K?AIBP@eKd@B58+4bD+&@->X>Y[GfS(ZLf/de6IE1
D-R8::Q\UQCJ1I7\IHY;5&I8+>.J9MR5g?EH?80PSL:).NXDg-I>0<6c[V55bdJ@
.1D95LFZ>,S@Y==]@>RKfeGI3e<##FA789O&V178cV3OB4YI2b,Z6&f#fXN0?Yc5
,+NO93XU.(KVD)Q08->HeC^MB-D14.OIU4ZLdN7M<9D\-3CggLGIX\1CA/?cKH>Q
Z\2eI8g0T<EX-,Kb2_8fKIeg:MdDfTg^CAI+^7KJd(S7T5Cb)I3_0eYYVV<UASKe
5ZT5GPN/c69bGD0Qc8A7d9)fdL3@&:0TgJ\50[;/^7(@OWa]PZ3Y^A2+Hg^@T[K]
HV@-4cULY/+18cO)X9W,IbD4[Ja]Z?7DQAE.fY?SKL4XERRg#6O0VT.G^5))1TgK
)A,#+3C(6KX].;W[.0(D?KEc/WPBAffBLeFR)g-5GXgVB9\GRXC@8,KZ=IXH/>C[
71;=2,T8KY.FF5X3[6R^g7OO2>Gg91T\M@(D7(LdI1O&NW)Yb+NTEaeXA\3G3@+,
\0#QH(KN^,DW9H=->81QA/:R-QYZNgDH]8S6ABVA+SFI;/UWKd:g[=bg##L_(<WT
,,35TA;<(CC<H]a3CTb4QI:X(HSD9ZLQRK\/>Q3E8E0_-7AOES1GC+aE+6HC(=+4
<X[O^RI>._\C@bQ;R+F32\;P;7ScFAJ^fbP50^d@ceGGX75M]](#da#:eS^a]AVc
Eg#a=_M;.41+HH1b/UBZ#].L;V]_9>:_@\,,=O#S\JMB.7YISacaa3+H<B?fPJcM
3=MR/,G(fY:Na-:f-]6TWJ-UE@8K&S-LR192d.W[QA(3;.YH_Y&AZV7Rg3MW+]J;
1//^g?3,6>V^FeNE^:()T,.JUfV:C^a<8QJS1<-=<V#_,@8fK28HYUW2^H>;T4RI
LAA;EC:BP-5fR5YICS:&DI:KV7//Z&)HU0TV]U=U788.4IJ,NIH=SL:6\RWSRX]\
H\NP5ASZD-f:T:FW.Q<<Ce/Q_@NV8=?e#KTY+F/<[5)a\FG6,\HbVD_GNDS;R50A
1aWR+Ma<R>]6S7gO#g[W<]Y-_McL??gE>^8b/g\G?29:gPe>9c8-;Q\X+I]dL7VA
+7d^8\/UP3SUPOONf0:T0,OKJM5P9\E?=35]Jg,9&^2B#X(MTCT4:9/6fJIKbCc0
R.=:4[BgO(KIag5g6#\a@/HXM\WbC2PIWaC9D+USQ)L1?27[F2+@N.8P6aQ.&Y8N
ZBL6V@FA/W)(2+?<QAKSLJDM++?^KWeY(Q]A9XeS&IQfc,+[,&.1D)afJ](/e=1f
/8L.R-5LC8+R1Ha0ga5J)9\V21:=c5g(_3:=d=a]G/D06;.KIS&\@-HJ=U[)Fg\L
94M-]BbYR4Dd-fHP?WgCdLAL=,QJQ[25eN,WK[GTD;(g5O-.0#X]a3dF64YXcYW&
cQCH9SWX_P=O4b_WM-YVZ[#GJT./((R8e;>\3YNg@CN2#^T+LXEZWA&_Uc5Q8)fc
8Yc/Z/3R#_>\@?c;6]IX</H9FAQYILJOEaF;X/G=C<(RPX8@783_>[Kd_VH71c^L
6)RafQRF_L]0+TI4>=c3Qf1QdIU(cGUQYLfdZE+M?#.+VF00/NQ?d3]K1cX=OJZ.
[CX&d4b.f5Jb<aM#CE;Y_ICD7@0B-I],X;N9EU60#RVa5>Q&E#3;)Gbg_Ia(@LU&
d@+M-:JH<E_9[;Vf_#.YP6ad)2IB6M7a6UTQN;TE05KDE1?#FgR,Q[5JMe^8gZ1d
^JJWb+\4LbG\-FGa53#/LS:1/AS?TV+K6=]@E\XY.a<#GHfN3.7US\b4?SWV+9.;
7\1Z^,D_)V\D_YcTDQ??H94782K9Z:#SNPU;Bb++be&#C$
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
.D-G4KD&MUF3,&Ue,3&5-;I0-1+E(SVD8I3\8O5K)-]2BUd0^H2Y-BNZ88M58)?b
#E89;>_:&0]-^?;d<\XX8J2]M&.G(IHWY,G^SL_UaNIG?@3ILYA;IRU5?+6f(:[\
\8(3e>PK>;O+f5W>Q0C06>,58K<:b#TQ:;)fV)7b\4d#dGYe[7Ice3cIU]>SP6D_
U]E.a1Z]\gF(R^)TOc1SFWSA3WS1(G7>M-B0fFBb3<S?YXQ3PGK2/K]COCK<H]fG
YI48;CN5_8\),fNe-R<XOa>(&beN=MM0N^63]P^Hccc8K?@Yg^fQ/6\MO[VHe_DT
E/@\GXg#gICJ+(Q-Fa/=.,UHW(OR<CP+SGYd.0@U:P2K.Xe\VeR.E@O<.VY:;ffI
A/1RHWK1)LQ#eR#K7LaYXFI\LF3)4+_-0G8HgQG8f5.^2+1R/7NO6;/?/:J\gaK@
;V3MX@7;QXegV]QYV,6bK\f.=009&/^(YD7Yc.5b)V:>e4KS>E)CQ+XR3BQU83&4
e-GGBP[7GYFd8(7+]G.K1T@FK;F)_?4(]7G6,5;(_FSgaG7_;Me^&C#gJ7bU+POf
B,QH1AaPOg9d.9>6_--Z8R8d@BdN^gEM=11.G+CcY#7G8=5UB=(\N+g>gQ<2X=cG
4BY#&gd/++WSOTaH0]WTVb3H=,5EDGS_5MFL-@UCC5&a&=ERK+RNKC6PN_2#E&TC
N9R-0e<OZQCY7/IaM3;+b8)YR@[#eZbaCXF8IE^KQ2eUC8A;?I2][53@@D=5<]Z<
JG&))U-?:735T/G4R[e0f2.&1g1.+@d7[;/:XBPOP7b=aJN?R/3Y:bB+0P\X-_W/
NAFHdIR92G&=\]Y2R3)8HBMFGCNZ?e]3;=\TcP_0WH7+U:G@/MN85dM_.@\PgIG-
?b@&<RF>I@H)LcgN[PQ1f@5H0XIIB2Ca,a?W3cE.IW1V0BB8X)LS=f()fKScIM)F
)Ne46/E=5KN0aI<KJI1EL6V_WgWa@T-1+T^,g0?BNGWA;U12c(AI;dT1?Pd,.K)g
A^W0.4\WUd]6M9b1:DYeCHJgc&_0,c,ObP:.V+^#g+]>/Jg0VfIQG4#JTFC[bEX,
#d3&4,/&LMLa9VDbFIF-]T68a./GDa7aB^D0c#/=3:N_YDO3f--,H@8)Pc#D+/1U
TZbd0c^9-/adO3(QFA,-IFB1I5CESZ#3eX8c>Y<CC4C&faZ,Q0<F]+BP>d@0dcCg
,fAQS(ICb^/d7-U-)YO1#MeN/Bg\0:KP45dNA>IHC/50FdX?W[d3@CP5f,7UJGTS
J]-_6>gJ:Y01BPgLV/[\;T:fcgHOCdE>>H5D-O@/K&[H#^gSfYU\U4)>b<BeBb:1
P=/1+9OE#X0QY,YJ[0-L,)D=88Q@9;S#Y2EEF)<I#Wd1M?=[LIV>9@0+DCe#VIAU
8]d-@UK95#A_QY0HKTMQKF;7?3_MT1B2BPJ10:0796GcR2L@5f;(H/KJLI,N58K&
;-\7R?f8BRXQK->:2_0G\9>4e0G]V[OBCPQH>d)073Kd9^(7N4L])+\RH&4Hbg-_
Ib[RPDUEA,\IO4F8c-FS?NDYZ2>bWPO8Y5Y-T\:;-W_4&1\>VcT+RTNb.Od\<6e5
CLGa]c\9AXQg&KOPbf))/(3P@#SDfL_;<F&]J:#;a4?UZ3+_D?L(DK?9#723JC)C
&G]CW391)4X&b\[2@A<#2)deR(,AX654NfKGdC]2,5/@fMRJW2GZd]MIO:?T1_F&
d:]W22U[+a<=@\FFa[?,L<KJYJcTP5G5C95^YDKP-Q8_CR\,U+M-VM=[<49_QN)(
JQ7g:U55IY,/(RLFX3efM,9H1/_M_TJ0-^E)L:0ZP.;D]KUJ8.JQccHLTcOO=g#S
,fG,5J,GFDT2ZOL<gg.(Sfg/:[-f<1@\CHfZ1d5c^GZ..aAd9-A-_TeINH(@^(]F
bHeb<7_).1O]:c#+P-XQ6FV/:Y4&O:_2=D#=_bbNWeK;b\9QO_bI-[e#\=SP+?;Z
-8-[950e?:]R<=SfQX(6F</6&S\E?YS8;^?f\2X4M<LZBC@P<U0D_TN)4BRaO63b
P65K.)AU[A2F/[B1^d5G/e/BbS4\+&,bJ(QB+4P\IY5E[e,F(1=BTCf[OVG,[_#f
/\a0T8SW3\H/=;HbdKfQ8T-WUQY8/&a[Tf2OVPg=_G+SYWK?<&2XEZDGHb^(5RfZ
5D[#Z.g&2PY1E2IV=>?/C87(@KFC[dH)CN7]Y2F/,PIg9:6B,Pd,7M^a+/f4bfOM
(US=aOQ30cL\<UV/cgLSb9\?QA22?LYU1-?AE-;T_HE&d=Jf[Q[CG:_@,7&cA#_M
C,=b>AW-+QdK3V3P5ZM;]&DB&FYO7MA>)G1?7B<b/afD):XPV=3UJ9b@aECbHTdS
5(e^ORg.D.IC-5YUF@<;7c96J-\I.I_JI:8,<.-J_;9YKV)94U#5G0Q>VINd><M;
WVgM8I:IZY\7?BPdRU/fODcOMcT&>C[0ODbYU=#;L.6C,g1f+AKS27/>(@4:Q&/5
]:G&feBJeaS\K8N<(d75>PX,JOFg7\F]cQ\Q+c-D\H7EQPe^?[43=-,XCa+c?.(>
R4B+e;a^8cZ.c859;@H)g?c30ga;<0R:c\5c&7;N#,L-#7)O>Cd;5S3eLQZR(DOE
V?[PS;d3+:X9^TV#]>N-fS43TBY9\O&e)b79e4<Qda])KA\NW)XZ4bJ(f,P.ZO7T
\=2=&9DU?IQ7D7YLJOIN?WVfEWS_LOBD48+D=+OA&QJ0^UCI)X[S/]5EYXB/T<B:
MX8T1P#LdNeV-LedAUgg9(&<5SZVPGOE?OgW^\BcZZK,SS5PIQ7[dQGQ_:4RY)1D
d(IH1;R++]EU4>g#&\@GFc7Hb/3PM=><Rf;a2&I-ge8=QAU+C>+#Lc=[PJ311[65
(@,Q2Z4QbPI)#RAN]:WN@WY5?1,8OD5IdQ8UPUNUc8T\;2ZCeC2HfaI/_S@c1Q4D
Q&JUGT/C5J0=4,KOa-ZSY2+(5Y>PF2@GRJV[/D54)bN?MbbG,[K_H=1a.Ig57g8H
&-L9QLfKY;7VT+,JC)I(QMOBG.0-1X=Cg4+S.3\U-FJc54MWE:7TBM](Y:SA+E_P
Md]gg9EGcd5/[>/QYZNN+8>VI6/aA[;^:-J<e9D5394^cTC0Z?D[D@W.OB(JbRb)
0M:_RNXN&1-+d>E<(bL]b;[J[;YR:Zd2a@@f@e(#R,PLT:gXT]59[=:T=5NI+78L
e_(IMeUAV@&,4A-E<E][ee)&STURZW&+;&)=)2P#VJ3Ub2U>NKHC?Y5BOP3/?9L]
]#R+_M018G=c[8OfJOU+YHHR<D.ba+<B]bdW:IbJWL6H2_F4V5?ef:>K9^:#_&Y<
P3V:>g3g_?>V_K26?1M+NOTd&8O6[2:=K2aT\X#eWJF5bX@ZDMc<f=<JFIDb3><.
:Ue^AV,V<,^7V?UY^Y9eJ:&TN:.<VGZ87T1:OPAP,D6aXT=d+0B0Me4I900gK^Ac
5]fPaR3(CW[a#De<-/4VbLNdB;=?<-2DY-\?KFgSMK#D4K.WbWA&4\)9fG1])@C^
&cKJF0N?[5,6c=YEf.\gf>W5Dg6(9&cVQ[2?&Y>V6dRd#U60+/1Ha8JcM0?fG>c4
O/;0D0=GU?4=(^.b-[XT5X5O/GD<AZCAMI_TKYgX2(#Fc+4\g49fLNIKa(A8H41]
Q#L3Jg=,W@Z5]SC4[U5bO812R528T:A3F\6TZcX4cbS&S;:?,/#PAE,&,;bWJ@5[
5K^CN>NMYA#J/P<U^G:S:Da0R0a+J](RV9ZW^RJW.AUK_,TC@2AAOW/B_K[ZH]Ld
(f?1/X,\eH>Oa\-96+[([R5bH#<;A<a(K6#WLV/W32A1e4=0a>KF:],d3,_79S]<
-^QYC(&?@>QB<C0Oc6@6#B8+Ld.Z,Y<(9H7_6&1OMDQO<TIWG?F[<Nc#2:],?3ZZ
0,C\+f#a7dZV.MWcI59AC[-+7faQI#>D)BZg&<>bVNFI42<&OK\Q8Z0U:9X=G/M(
70:].J@(\9TD5[<>#-&7,Y)b+PV<_S(]/X_6c7\7,a+<+&O)Z3A]g,FGG^Z--Q];
gHHGQD^[>D8:eg6#,N)=P(<V7G(I1(.#CBG(YD4fU7;S5&.H5=/HPdf2B+6P_\2;
6<WEY2^=BWOIU.EV#8:4BBG3\1L\VZ<[>6b072YA-TAW&A(#OH=fZ&V6<Tc^:&RM
=[0>gPDB?A;g+UT2R.)H/LaGT(@8AIN6BY<.LG)>>)Db0LM,I8K:SNY@>GM/54K8
A2GQRMD1[J_g+OaM96GBJCe#O&9C9,XEgOgeJeD-DPBWX&,<bTAS47QX_A&0+O0A
7-TQc^?\#]dI].SKNeU8;eZC)e<D(PWWR#QK9Hf?#,IDaATC,R7BeZTafIB]C.f>
^fU\?a_Y=1+6Z.4UH][IXB\1f+KfgCK&Ob?@:331=E8:T<@c=[-FS-_aFM-L<JDQ
EQd0RJH.:43H8(bJcOHB;0:d7P=22(HKf82ZS;5WI.=RC0SY+Z+BbZ_d5HQJML^X
L4a>0@FWbAUOWH;C84_6c+;^&LEZS_1<EG;)ER\4V4+SQO9,:>.E32IX.MC<5LM^
?F4TA?XI@8X(@6C00Tac9VfC6DeMfUg=696S&,^(K]1V&Q2L?&gJ^f9RV8#65-F5
LNXcI<b7f)I(Df4DX_\:)9=HYVSP.Q3LSV9bD;.@AWIV1N;P\_3D9^OSf<VOY9G7
K=@I9EKWZ;RRVFg/@6,O8C+WL0\P)LA(Ma73HPH#c101R,-I+Ha]7Y9&WaIII#C[
@-9c(_[)Y9Q)aBY^Qc?gcf4@6VF;b<>/AAbX1(>W<_4Q7aBR@WgdOUEMP0H07,gg
&J4/R.8DT&I#K^TU-g-=H7eOcO(TJ_2[57?SZNDCRWN,QU[4[a1IId1(<1L0UL@5
>Fd?E^1+7J?dNeUN8^bU;Z&.PQg06agNDg:Lde/T3eN;.[N-UbEWR,_6CYV2DA7]
(1R5+0R8E&\SVK./G=Z8C8@B+TLbR>:gL.cZNJE\(QPMW&MPJI#fH>fYA6H+.ad>
81UY>TD<\^bN6gA5-:N[(6:99H&eBB&RH(TT2C_,5WLOAA<(H,aM]G2,dGDeQcNb
V>2\F)>X6?^B3LWHC-E]QOb&aGX)<JKN1\Efd;8V6J^.&-C.BZg(L#SZfd3DKgZC
&G6&R=/bdK3JVO5X+5VgK1O1[_SDY1Y=.<6ZeGD+8<=_##^WCCS@)=_SFVZJ<B9T
7]<)0B1K@=PJLN#T_4-^U:4^8fWdf=U<H@DJHVF,8&-5:MH4<[_dLP]NRB=Ac/<O
_LaL6)Ve_X[C>e6XgR>g13P(;[VBE(L_X()\S-Jc>QNPD=)@<SbOFJ1/@KYEc<cE
&E<1b-6M=^(),c:@XB;a;M1KB;6eFUQ[:L)N^1R18I>T1.+_\I.O1)Z+6/0^_/@N
-)WG@BRTQ<:\7NBTBQ>)e5R0Kbb^I)^96V:^)ZaMQfMB7+dF16<aVIX_C.L;L?IO
1JIQHKVa[e-RER]DWPWcPO=g_,8.IEZH[]P+[fE/;-)LfJDYBRBVI/f#R/AIgOHA
AJ3HI/\(8b&S/X:U[5TM_43C6-S8VR^YB)S?QZF9?/I8=V=+A_5^#06)DDO;dUY8
NdSQ3@2BO+>A5FRS/+g3aPYVYSBa=I/De+f=E#GU5\,Ka8GU6V2[cYL@5WVI:91S
TK-[2FUQgEFB[LA<b2+C289Q1edEEC<I=L,X@;HS4S2SN:a1&:,;P6]6PWf7NP#/
O]WfM07JPfZ6O_]@9@GILRe[/(9H@T;X:fTYM7P5HCUcD+7gga,RP@]6J$
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
6bS98S2gQ@T5,JX.(5+.--YH=P\T9AM1(HH-=KEd@TG3\Z?c5?b+=eZ)(R9<)<X)
?L@&O_+6K+0WNZ.Q-f=N(P?>,Mb>5<#9&,2I88O0&@T-=b-C>W;RHDP[_;,\X.=G
=(-@[GM6I#dD7D,MKXC&H-[=):dX4&QP2(9B.AePa;IVF=/4H.WZ/1eH>E.-=6EC
(X47@#XY0I30(Q.2P3aWEa/48[8Ag5f=.G0U6L;&<f=N&)LAc84(\K#<3F/fPePc
8.Sf=E#K4cGH:D-&U/WN-V4:<JZX4CQcUHNQ-/NK8<6Q:^?IZU4BPQ+]>>Z7<B-[
-YF.8VR3G24;5;51VLG;A#c-5U2;Lb)Q[)T.<A9E>e&?=\SMLU:XAUB_SQO6TEXf
&WbYL+)V9PRP8,3EAN6Cc-[\=XL1eC]^Ma,4)5KfTU9&&Q.OeL(-.Y3C,<&d<c#d
,R/9SXWO4W#(I00L\N1e?D/TB-)b.1NE=.?c<^;OAag/XO)O1@G>/VMY:D#NTV.M
[PeK&J2<JV86fX_7VSF?c:SB)^2DX6J_5SSYgZ1E+5+HCC\dR3RYM1V_@]Gb@6@8
(\.,YXAOQCg=T\0SPVY/YR9g84?]9X?+b4QKd-,@JE@H&CgOCH@YE^W@#&ZfICT6
VJWV;1H5ebX+VR(YM+FX+\26gU#NE?Y<6C&-<7Qf]&5a;VceY(3LX<:BWg7B=7?W
UK(Q_d4JIW0eB..OQ?^W@#[7VUBU2(ZR&fWbUDUb<5J;=0E7fM.1Y\[P:Z:DCGf7
(HN;<3=H7H=RBNBB\4F]ILa.4G]@KVM62&VL3;B30^5)B[N^K9<F(&CB-EBaMU@V
fTaIO\BaU8]@<.#5>FaWUcJV=2)PeWMZ\V8XW04>[VWUa]ZABN[U>R:]a213PTKA
8#_4IBBTSPJ+fWVcK5GN36AJF=LaTe+DR8cU+>MH;-NDC#0Z\6N,5AAT3Gb@d/KW
3?2DZ/D-G>Yd@:>L@.]eKGM.HH\ZRM.0HROHE@)8KLX93:8#;&BaHT-WMQbMU8-B
>JBKGR&:)OWa/Q@F@c?,agG_(Yf_3M:bKF0+cJdbA,?8bDfL1E0QdgVb[@R)d]f]
-PZ_2FdB?7OIK[G-IXESB@1fa+6U7F]XX3ZG3;(fc)0[-#c>7GU0-X>8=^\:(=HY
ZY5a>#I+eEF2^-Ha?=>O?+5EdYB./G(PL#5g0-_]2C_5PB>CK0D?ebE8]7KJ0X0+
6f,-PZN&WaSfR0E?9)V\&ZAO@=EBB2I+,C)f5#LZ44^:;Y^.Q],K)dX@=7SVIYTA
4?6/.Pc3S3)4,Y+=[;-Gg=[f(9(]=(;SS\?,<gFRg3AF]O+@N^L75XfE0LJ;T+GV
BKg?I@cMcV<G3/.RXb\_1#MBbGS/)^bL\B77-gLGM0VEQPW9I?cHc&O3[0g.W;ZO
8IAOV6::Y485#I4&S_F8W>>f:.AeY&0^R;f46A:L@J@_/-J-GHWKHY:D]=4bPd7?
ZKH)U.TA[-Qa/FV.?[B&T4WG+QT+(0c1OZTT;1Z-UG]K5@0bK@8OeKLD<U>\//W-
+54>c>>ZSO;MAOE,.DGgHNBMcS-/g9>2+1VM.gM+GQ[CYU&=ddd]06E]@>P_cTL4
(Y=3J^T)d952dI,7.>N>Y:9H&JdO9MYC5>Vb,VGLK8NYBL;TR<M-.JMVN\)^8F#Z
N6-a@-EZ,6Q8U6Y?05Q2@JGQaS:X.b_H2SZ6XfO<2W[Q>[fX,V&ZN+R+GEJDJ.(/
4<^g.;NdNWICOdJaJ8?BY:61Ka;&C28@8>H[^F.U6P]VR:9g(IJK_AIMYR4aO<Q/
MKc]>2)(:M0-N#2TF/_T9e64ZaBY70(BBMLLNR1@96H1]T1VJ?PGAM3Dg]>5EEYe
b7QFc(bJX2RNVUOW_&OJ7H-I360/?J&#DRTVJ(HM\a=<W=Cg\<R3;^Eg/(ROD4E-
\1-7^<_JR-4^,\AN>M@_&Ya+&^O0c0J@=0c7;.&3L2V9UGHH<?M77XV4NUTN6>X5
OgJ:Z2Ob58O<B:Z\gI;S<(0.Y>JC9^=g\UJWLRFBTACWP^.I8[U_L_ab,DRJ9NcQ
CR@)7c,YNT54.\+UNHa:;E66/NeH&JSN6IMD?<,4a01@e03f7&CDX[N=V+L)][ZW
f17EM?Agd8;P.aN\7:#O^g65DME:4OIM/bXbEX0W7Q/:)fU=#?X;8\OO]&DBDM[(
c8CCd(33@[LE@2c\EG-CA#cA&@ef5+0@1L0=RK@Q@GD:Oddf9#^F2#_XDeT=E4fD
-@)>_bg&,fWE0$
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
