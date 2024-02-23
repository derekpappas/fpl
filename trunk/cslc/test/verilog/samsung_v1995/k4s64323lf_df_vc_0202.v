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
    `ifdef M128
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
   `ifdef M512 //
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
N;K+]6@+X71a,;_Y<f5]9RBF,8(f-H#Z9f8f(9Z#9K5LA2H-TFES<NgV)R&2(R1:
a]&^4+3#;U<C)1T:-F#(dfOP#WK>^d-5C?ER?)e<JUWS.U3<JEYAV1+,C8HA(CdA
++cY)WObDI-S,_CBY:>T#bS]=5UNXcO&D#RQc<Wd9K?08(XD8e;^_-BUCO>BK&F#
4T+>^3eALeOGaT-336659g:_-)3LBQTg)J[ggaCO=56FT@#6P?WP==;#.S)-P;Qc
5AH-1ZH9LNVZA]b206KfMeI\?&J.0#3+5X7FPVVQ87CDL4>_--FCLd.MN)aDN8K:
)c)/eH)0247gXR&QU/>K\5FIN9+5EB.<0[/d?)bO9.?\/c=>=_Pag7F4/8EA4;7T
Tg-dFI[4XQ9;WM)f/eG/A>03N8X#,[<4WICMIK32.90QD2&FeR^90A^K1RS.d@1b
WQ(_\CY78bP-b;>84Db?/\Yee_N@dJ=SNUC;SfX<TG5,^#]\]<07ggcS049ZUM+:
JSOa-C?M8IV:FE@IUKXd=#g-2Za9-?2.b<:OJ?ZO)2c5IW<3S17Ic\<Vf<<-UFGQ
(b]&_.0gAO[aK.5=>(g/RHT@^+O(2adLWZ5XO9@9[>P/EL>eL]-_Leb^AOe@PWe>
IJXac>-7M)<T9+_DKQLG@)+c0\d=A8GQb\EH,,#.9\K#ZVKLE;].U8+&RSH73L-G
CHX)D(].RVG\_Z9A.R]cT<R:73?c,Yd@?Ie0IMQWbEYC(<-ebKT;d5cU6_@d.E=Y
,3e1R5a]N^>-0^1G,_I1,0D&+FdPVZAID4C0cU6[PgLTA<.?4T\EJgKe5)Dg2fEM
3O^2(2GP)LdGe<&GIXf#,?_Me657BP72>c6]RE5^:d:KTP@FV3M306RS^IP@Og;#
UfE&=R9Y46\6)/=8L?(Ybe/.4W;4(PYJ,EgUY>S=R;P+_g\H>P;R9cLUa&^2_ED,
G(g4KZ4J<^@#D9]@@Z-A4-9;616F]M7E4VAWR/?RUE+O>H\J)IUU3IOVYEPSW37c
fB0c:P(0O>6]W2/G?U>]:5cW+c&;_:V#NSTg2IH=161?=_MR>4d>IU:.WC2:Cde=
CR//ST2AD(9V01J/1X:@BPWO2#d4U67#L=5K5&;0#IU.\.&;6\(MF&@J[&dM]Dd:
;5K/1NE5[T4_P<I,gC;MS@#-8+\Z?HJg0IWA5<6ND9^YUaQVG9,V[^5V-6P2GRY>
9;++LYU\T;4+BgE<+D(HNAUW@cN=2&[b_[H)?9Ed[/4cgN6RJQ/4@fT4##4PB_ae
@(KePd:^)#=8VX9=EV0#A=?O3V^4^c>SUHCPc1N.U&GD.2+?(d)26=]T,cH-3I,=
WK<JS\J,YBOd3Z:[DCL5D5,66[<6.[f>WbF1B6F&.e&LK]YeU8-(9+McZ+^A_Cgf
.:Hc)Y54J]-A:@TQ[dWYJ&dg#@#3H58C((aP;H+1XS-JTW/Z_QL0b;,(<6_5SWBe
84c^5]g]dZ@a6KVC+Q+UOHC5aaS[]Pc9dP()<4<1IYPRL-e\HK>\AGAB(RA#BL2=
)YPAW6a;3R(URbMUNXA[cXMGI-EC#.N;dHQ[,7OI>G;YY7AERD+aXN^UM:7T[fRW
-O5HLZHTN^HLcbXX;SE/a1aabYJ,_=/:XH<W,SB8f+\L)IO6VGDL-2B1fCb3Uc5)
/a,DVA^MFAT1>XO]3f]]V64Y?)2QZ(M7E\B^+9/dAbWEbeG_)ZXB7,S79B)baBIG
2LfPE,SdA2_VT[IU9E9812b>5[/McA/LFUEdBJ]fDD=S/<PK4G&_OT6\[-g](?70
+(d>9MZ.]fQ2D6C0Z?JbLVV8JN19D6^48EfPUJ)3KVXQ;KQ>7EHU4:QEFMP:TM8]
D:NDJTX?]dYD;&J79b/-9(+1]\BFEKYK?$
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
MG>Y]R=&,8XI<D#C)WGQ<?5),YU08AfG<,4f)fU><U=T,59BX>B:-[ZK8B.S-a7K
F+K5U7HgCTL0?>8XE,Z2#:CDDDSF)9#UC,ee0(S#?XL-LH(73GVHRc^GC5.:b3XC
5_S<gU.0DEP-V#WKXBaG)&M94NW8[:_&Lb+EP[CAc()HHRd>_8\?^gAXVW7e6]2>
L:&,60#PQ57H;97;0c6Ja9K<J;a(6OQDA?SJ@6\^c0YVKMPCH&QD7.L\f-L=e_c)
QC&8TL0LVUX#K6g@@_dKM:BdDZ:4]aLC2Z[2N=85]90GZXafJX9=--]#4EMPcOV0
PBBFWcXPe5&=L>D<,^KQ&LR@)+Z[7Ig>/0@ADFW[Vg_gK7A<\[7R_FdI>I].V:C/
JRY-<>XRg2,?J@MM51J97=:YE^W.9=@fEW.HaYP[7RO7I@OQD??GOLE;=W8L-/?R
e_+RFP)(95,IRZ9)TOPI4d#>>),R;]25\@<2F79\],YZD]F28aWE)-2MgZDVCV#6
)\GI(baXAZ(+I^V)59O>I1f0YR9O5L89M<(E::?BTS2&#_;V)g5618[6RS80\dUg
R8[_+U&.CT,6SEN#eg.KTDH8(P@3)-07?M4N>-e(,TV\A[1TS:OFZMGbdc[&BTTe
W=e_O_1W2,694bFRWcTCf2;KAeMgH\@\0]7QL,=Xd:E-E#1(>cS;P)^G;K1YS:\I
F2>I,RIB8S]=]U\Bfc8d-L+cT#?XK>\4FSaEfB(,ggW;D9cFJ58)KHJ\0\N#O^5#
E/K)/S:Kc>\]2H,P-Rf&cTHH4C0f/b8NPP+C2CZ\DZO(cJ;V/Q,+OR(@cXN@bbBf
DgRD3#aZG2E3Z.Rd5^LD&Q)OL4Q+V51[U<N37>>0Cb8KU[eFc.7)I9ND#2#53d9[
/#=J@(0<28U[gY>g?_V-W\+RB?)=L+PN^.?G#(EK946cTA8b)OLbHESCGCNA3KAP
DAD59DJ0.7=9fF=^=[2XN2208+)e.0CB[8e-LVD9U@faE._eJf48>cAH+X:163<,
][V:[aYF6H-&JA6O9)OA<]g,+:?C09@UPICRDSM0+GV)OF7<F8;_cT<]fDM@?BA7
4J?V&a/Q>8-JPP)PF:IP505)/R2=08&[VW=V4/W-c:=(?@XO[K10IbQ1:WN=YcN6
.2FASM.cTHM>@gBN=a_VKL,+ST2J58<1KS.+W&2L8QE1D06Ebg:W4E5._a548(MV
(L>QF,/<2PgI+FWH+c^QI=?WVReHS<:d]BZ-#;6_7U?8T5;e:S]@);BED=RNSP:/
VV6g1IT4PGYgMWEBQ1L+Z1#?+75<(XgXG;U(QL>_/,#c)ZeK.659.&M<380?V6Q@
^-#fL,SU5#g)>/-@&NF]L+S]=BZON5H=;IQ^]Y2Y/Fde?4LgH;dFY]cMD0VNEB4g
UL&;XN06XH>1cEHUa,1>(PY;\WJ?Mb8U_4@;0NG3?d&eXC6)A+T1:ZG:f^Q(?eI6
Q<EeH&H.+F5O]Z7QHY>?>cAA2Y1/QF^fY#&?:9(=A98WLMZa&JXZB4>Gd#f;4W-3
>&Sf89PW;A[98JMfe01.cFKDSBf<8\:\O,F;BK[#5ORB[II=0CI@T0,D-6E-cdW[
<R]ZgQ6K=\S&M-#[W.YFW>Lce.;&(BTU_^L#GW>)2\GL.e^;)2.I=KN-aZ<FVfI+
H],(.XeGdX)AE4?_c-2D(.0E):gf\DDK[?#+P-(W#_+UDfga_P=CE0eEZ6SC+8]S
M.ZE/8=QR)=?AcW8W>bM[\F<5Y573&g\8UIL>U)9O]Ge/=URHQ5Yb<IgS/B43BFE
@(<9=]15I455&cGE?5Y[b+C^D:X:Z9b6Q)IXN20>?J71_9b,4N0@3NC#]XeCc0;2
DPV]]HX?;E9.GebKg?;ZJ#ETcgP\)V9+DV89fSV5QLRgOPgdZb_><IN0F-3\C^-W
XO(fER#Q4(Q(gb29:5?QSZZUPdK?O@3)5cND&)GFS+CK<U6>RL/O4#?89-X_Of&G
VY)/.1UTA/J1((31:4/(-e>S9G2-/O:#Yf4A&^\EB@@LU7X&)eHT1N<W?D)FLY?8
R=R;J&>9K_Z1IBLF@gV1b#1dETe/>NS.(,0L>9,eD/BS6OL2<2D5_2V66N)?^R7P
R#.^XRY[g8_.Fc.;U<WBgI&>9PFBMT,_c,E9(657eQ]JOE0;)J]U+HG=\_?SX=eO
GKZO<2<:gCXLUN9C&R+>[/Q<:b:9R_cBUcM604\::b-;YR>WKJ:cZ2132Lc)W\04
2ba:aadH/.,MfWK5=WM2NOO#:2+BZTBT//62_Z)b&:eHDCJb,TC15VSQ(,&2V1T5
HHQ_O_]#Y2N6H8&MgBVR9)B+-<#ca#MC)OE.ZV(]bI?Y-6cCDK<=dXGd8=IYAc?c
dfLcR>I&RPNg<O71e3<V-Yfa1H,F?K55b(HU:#.QI8T(I+#JcC)AZ[(<)>Y3RAYH
XC_a1^9OF^)N4Y,B=Aa<46D8gQOBa73(,]Z\ad5-7G9Z[,C56cg[BGdWOZQW41CD
RF\?GFOAb5\Z<fA8.;LA4@.1Y#F,OZMdc,EY1d;:SGZ6OLL]fP60Z+:RfCef==)A
V6C-BN]@@gfIZIB#(Y?E>cL\8RNK#+F;_R<1BMGBS4GX<2BRH?bP:6+]Q_TL^BSW
aV??R\:@SgX>FJ5P=4DE:W>\BYd:e5HPaE#dd,<L[<+(Y&=Q;MIN8@g5)XD?&A_+
V;(5eK7SXWd=4#O9HN+g\.G,[,=0>TOY]8-Y5IYE[X^\g&Xd&;7=WZ8O)OA2YOaX
-C-3SYbBA@,,>IT5MdNA>YA2dg]I+gKHZ#e<N.@E=/Ge+N<SA]\[.f+T9:--gI9I
E3[4WY#e.QdWOd_CY)Ugd[MGLb,&+gGQO#UHXC#1_-+B?HTH(P8Jg0HHb:M]Ed:8
H5@5.#YN:\XHZe1?<g07EVD0(e,Cd^SXG^^G.(#0<42I2^,JAI72_)8\-g-RPTF#
H:de#7(A&\IH0$
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
^f7Qd\e/<Z0:,TM#=<=99W>[);?:M(c4-;+E-Z2->P@B37SB5=N99+I2=DE?,NW,
;A6R1A;fP0Q^AWUB&5?)DEV;<6Mf_@R0GcLKK/3<2Z:aQH123?-g7DE(.:D?#R=T
eA1F#.CO/<O.;L\HZBQDf9YZOCXR=I9?4KZa?^[B/gL&:NEA4F8X2L9#8_@CbHC4
GQ1@^^1:1=F2L&P0@Gg:3O5>BPKa[2E;S=:HP=/;JL:,EG43(\4D(@N?g3ZWL0VI
,P5I:J1)?gK_;TTKaP#D^?NNfJ6[/_Z?f(I@>9F</]+2,fEYeLX8R5VAc5Z=,:fe
Vf0_T0B]-1fY8bQSFc&bYQUY,NZ7#T&1O+UP1=fKb0b2\]/Qe4)[XV.b:N.PI;C1
5A@++:I?6O1Qdb&./T\7S4Z@8VW\2_a?NgHKR(85U<:Zdg&J1A9IXFZ2e7RG,8^?
E;5L.9#=bBXfESC_.<X_ebZL\@SH9a988;A3O[EK46#Pce\.-:=\d9:,f0g9#Ua\
BP#?8gBQf9DXAC-3IN[bROM=SaMB=/.^-,-8:6)FA365UDDX9Ge)+E\-3YGJ4QC0
=/G&a67.0?-6-N]H8HLg^E0G-7C./2)JA8Xc<?U;65V;W4Kaf+A^S=]=Q?#@M]P(
?/fXYOK9@@eJMZ-c@2ZRWGFWI\9TG5RZ15E\48cENG:O:LM5bfc=T19aQbd:X3/+
,^cNdd[1DZJ+S(H&RVKE:QI/eQHLEP1A3N5Q^,KG3]J8Ld40L5faB5_^f@VAYYg[
8>9bJ_9YUCdWREe#E-ZH.OY>R:Q1VP5;I5-Jf8=CTOFM71\GD5F:Z249V-_R+Ig[
/8G=L41N@=5Hc#(\>Se5C81F)O[9VNMS77-7b->eE&_L(JJYOX9SO+GUKQe2C.K8
+8OILIY-:V=,g:g0S2]#[UGBN6TMaN0H/2<4^11>:&S5Q_.JVCWN.,;?c#\gb0K&
&_1L9]=4LY;\Pc7)bC4,70I8c5ZgJ2HV4d1a>NJD7+c\]&SDSX>bLHO4/8:[VNMQ
f83<ZWWI/MSM)AgH)=&EK7N^QINM3bcL/91V[JGS05>L]_Y-_9baIdJZ,_V76fKS
+H.105/ObUJ,5bL8]L)4DJ96+DHV&4E?gBcg0K?[O7;X&/]XV-Yb<AY=Y?g=be>a
TT-gIA/]JegX\D;<1)\5VE5f_88^5LI1/JBSJ-.(UJ1;Qf4f[:(U6A8;7K##]?A#
XBCebB[@/#H-e0)TJ&&@aR)S\?OO#82aQAgb37]10S,Q-WFJ[DFD:;L9]LJYD/-O
4c@bTBHC.C95?G.4C#MAId:3+7PT67I>O7>HB;0#NSM0B99,Wae1#VVUK9PY6cOW
I[dU\T\]#KNQLD#,#SdB<DERV^(5^CN&_V/We1?Y#Z?T9>=Td).@4N-G8&FUS2bW
4)UDU/U3dH:^KG_N#6KZG.<M3DZM\^bea1g\L+_K-]4RW;P9e8eX&AAP4AVK>JS5
_\VD>]<1ZdA28IeR-W7BW^8bIJg\FHO:F+_4VE0FSZ.d\&.cV9d2LP#cMM\>G]CE
(Of9GUa?LaB>eJB/F[5Z]U5<ZA]0C15I(AA2=<1>e:7S.GRL1bQ01MA#SV[BcPL/
#6[.ZFK0T#5g>7BN[(PBY.Q_Mb]aWEY/A(D(1O?W/<H9:9=WfI4Na.U2#^@U2ENK
[cMf.eDX38,8bNH\FEe]4M=IbC\[EKeID+aE3)Bd\#W[NcN63HdffZUFKa#_f72N
H+d9#WVFRG.1=2e>(ccgMZa6Oa:BeQLH.9>+-\?-7V_LY&LCMf4faM0;PZ]42b&R
cC&Pb,Xa;U\A3&LJd9a8)G2C012WgO^5^FUGP.7T^(D/G=+Hgd>OA#-aLGYHPSI7
:.@NM<1U:g<USH;?U_7b8BdK&FHP]C_S]R(:60.Q:b3F[7abZ]=E8a-g@-076PDL
@JeD>G7X0X<0L&X59#H2(K:e+GM9SQO2_CJPZaN/@U?A?;8TP?Q3,ENY<9EV7XIS
)X@?X,2GO(DYZN7SOVdD3D5b#bc=JUT&f8=>_(W)P^LMHcH,QAYCb#?Y-g,5O9.R
TTRd&&\Dg;61K#?VR.Vd61L=;?K&IPgWc/).3\#96EK6Y-?4_PZNMFP6SAA,UN\I
KM);Sb<fHZc>^>4XVZ?bF+#cAN@M)JRVf69<e,5(?fCU17D@C>HM.+[U:+;Wc;0,
\;>FX&FdHD<W90JBOa]9I15-5WBI635<@I8.=JF5\G[D?c<AO9DddY+CE_]3<0-U
1,YfF^@@6MDH;@5aVK4JDff:0#T[I3g?C(<J/3/=e,?e,Mf&F\ebTHL;a(J[_L7a
7bB:7Q@&&Fc00O0X,fU,JOI-]ST3J5=--Ie+Y597dB7\[Y+#d?_d:AR+/XfV\MXF
(\,NP;L#6V,SDf)0\C3;7aaa#)D8#>:[U;9V(4JA+4/1OBG8>4HTQTL?\JFLS22<
=VEINI&f(IdIb1Lc?^:Pd(\;11_70[5GcHcIG0Y],8G[HL<O9:>;&Y>,SRM,LQ,[
(N&49&U0T:==1NSId7a11&]@>?]&c]9FNV)bOG.]<<eVWEZS[^KIAE616.4f@10O
&1cbcgCHEgL?54UXM-I=?feb<._R5b<W2H9CKT#)PB=J9EQIf,D<#_b&0_]>0dQg
\;16P5cEMagW<L71,#NPY?eH&G5FDHW5<ad50435.\B8Zc(K_A-cBHDX#97V:d<U
+cX_^3FUQ1EDBeR#]JGXIJMQLA,=R(-KWdQPb/Q7Z-Q8+A8&-,M#e2g-SAJXcE&8
?,WaBd-(67N>@4G0^^)4F:bLPDZZWXb(,A4g+L,ZHY0(2R4G=(LaL#O3^f,?e+7=
5Ne.FH0=U.S+\7RDaZ[fYFG5L-]NgCJ5JM=3bD?^bK_L;Q:6f&.-JQfR&V=UI-DJ
Y>MADQBB/_gBKWN0T]0>.2=@KHdU(Ec?C#]b9cae.<78+#\;[]eOI6+Pd0>-e^>=
a\;P(/RdBg>K4XN>AI71<UXCN6C4EH<+cb7TH.CXB>;.eO.UM=H<QMgH^X1O-caI
cVVOC8A0;J:Fd-([3La;>9(K[=:KNe+O9BF9([P&Hc94YD6XLY3eUI@2-@AM+^S+
,(;=9/0M-]cW1cf>-M3KTU_^X[[M966@H>RDTb^U96(ZDWJ6Rfe,2>:B^[gb6<.;
<V]_MRf#349K,02R82=aQR@LZR3^MZYH6;c6B5R#eZ(<7McY0V7T25ME;DZWD?6:
#:D?Y\59>JA:30#cZf@UW.^)g])_=88^9_58X5A_Ea0[g-L(1FB(KA>bNP:]:PBY
(99.8WYQ84<8=NEf/1&SR2+U&\EH,3[O.D9TgC=g\TW:/OZ.aF]M+;#7C>=bfD[9
e0NIOBCK5gVC(.,ee61,Q:0]UA9e[CV)gDgC+VSHY1;0J&:WSBMb(-3-<.a1NUBF
J&NS771IUN2-&3,A=aYM,=&=1RK-@A1U8SS0?RJHP9L;6fWZ9E9)#2A;=D#K(29J
Y6(Q1U0+)&8.54OKD2^8W_=[4+MP(#XP&?OJO[f4GA<J2Z>)WY4JU=[PN8WREJRR
BRJ9SNFI7CPBBD9]USY+++Ef3NLZ^BTfcfcJJNOMM(@Y,P-f(P^EBaMI:5N:@7,5
=?.7W#&P>:CC5O<04?&+cV__T<f?;M40]<FOe^1:_H]G,4<G]6Z9I2CFIe;]AQPJ
)=(adMA)AVT/fd9eeR7=YR@I]P-F=>YA#T7d.1;\.(I&<1:\&>,aTTK@).NU?,DW
eH5Q]/=_NW]/gMJO62LVd8MY>&,Q3/bG>fEU:55SdGd(=C<@bHe>9Q<U^,\J6.<6
7R+B<2eA=+NY=8aELN[YS]d?1aBV/cI?2)71W/GbZPFd@@=H]O@1eGB.7H[):;XO
@L;-\7^1+YC6P[)51Pb<gcM:/;QSLN;9UKV;P3&K2#e/<8dDa\/]_Ra;AI]fYXEb
/(.+eMG5@.0WW(eLTDFcg81^?SVbf>gdA3>41S)AFB/af5TK,8Qedg^:@_[3]a53
Zc/^e4dc;<d6>.<fH]H(;5Y4\KCS8c3H28>Be:a<C],;Q@F#RRR(:7C:JU<K=YDR
SZ:)>Db>4TG.P#df4gK<e8T0\&X,REFV6FU/6F?g\KHRJ#7(Z5g;JU<XRG/\b-PJ
I4AI.Xf3J#9c0,CJ+N-d6a.IG3?4XaRCDEbGg;6:DSP_@AQ;9J[N62eVdS)NBZJ;
3G>L5#76E0)YRZQ1bZd:d^Xf<6gP-Q@<6;I/O(JS5)T#4fB9Q98SO/^.0bF,];Ib
V?<caX?TS2JA5DQ-W+9#3b28[DG-KQ/8fV@DU6c=2LfQ5[+NA>QUSQWU.RPOUNU4
000@f1c^AVEWL\O.<4aW03R(YIf&JDJc+VI+O@T(CC:eQV&6XCQ]U6^MJE<cFE1a
2I)_f\;+/QE,3P_d].D7/A<3FQ=4WFKIZ:81@F;:K_P1L?-[:cYFZNDE1U8[WG.@
,AV)=b+A71<(#b/4gB@ZGB(+b56b\gVe+:P,&&5ZQ0#+]R6Dd/2:gfcH3GE.:EDM
ZbG1]P4&JDae#D8C7:>#2U<AW;?[+&VQM>)c<XL7^)3,^ReXE&E^K67H.TQc3</6
24fK<,c_6(+VQC9AY+/^W#V)F6FALLVG^.g3H90/]4XE\F.,=cS<MaH67e#^W^_#
/<MF<@P&@bg^M#dAESf>KRF5)2a7T49d:^e:;[\eBCT57B-.C=cb\<+33JR9Bd.L
+YRB-4_T,8Jb/#:gR^Z#d4,)/9MPJD,;FAfU-?V3OeUJL[bDP5[+gfd25?JNTLAN
a>=)?3<PFVe;ZP(a9d8G:_QcNG.5aOe3CHZ[VaFU(I,ZOV]2\&BQL\Z)S,:^F9]0
6W+O&>I2Zcc0LJ+cSNGY:Zc\LFE?D>G9Jb[T,ZJ.+G:KUTLE9XdMF4;I^HL:c&J#
L^eV,XY4c6K&<64.G+_;F]WadX>P=UeL/LC5.QT6BfGSM(.4A4#Va??fgaa_#6@B
g2;KE>-(?Jd>2-J:Af<CJcGa@GU)d9DF,1^(AMCd@]9C@N1fVB/(@S1#ZX1Z\W1J
,5=(U@#V#\X4=)aM?+M3FQT[Y5HNgQ:ZMf<J&?3T:4bN:70L)ecU7Q[H+((=@b_B
d^D-Cf,S;:f>(:Q<02AI(3<HZb&HQdA]eV;OaV:#7JR;5KSH+^87/cLCV+F__a65
e^Z1S9NaZfR/G,S6[J6,,--f68<UcML\K3c8Z]V\f3VdCdD7#ROLcc7+=1P=WT,5
.\9C/OU[d530bC3^C_>b0gJ.[_6P#XbgMe@b.199_Q/#DE<4POIaFPKWN:G#-8MP
+W.Z#X?[6#V7EHeb)[eX=Egf2QW5PcX46N9[ZBLYYC7=1RRT0]7I4eUH]GRQ=2Ha
/(Z_7/(Q@8T4ITOSA><H+XX5=:+HM,0(3W6F<;T:CKM\4&IYN#+;aSNJ@OM9JM.[
Z3#/>_U214U,\EH[3]HS17dDbVgY#]@;-61#[9#\_G-d#WWTL:X-/&WSQPg&;9/I
/WcPfKU1OZR#6K7VG0ZC731fB=aI.<>LHaJPZ[-.1)H\]TA)WHg[W(:]SO)]QWS#
Tc4bc_gKEHGg/[c>#=RMLCAH.5ZN3N5_eb?)420\F3_3Y_GO9IV._YU8F+\_M4&1
+/KJO302:W/IR9_B(JC^CMK@\F_24?2WVfEQ?[]B00V>=12KA(0.4;eB+7[B+ad)
0@94)78Vg\<7)O(;cP7\NNNI0=CEM#IGXb9KP:ee,QO\fQ5X>5PQDO6JOPHS?4J7
91X47Q>fDY,Y.J8D;-dRbPZDDH[B9^,eS+4ZUO(L@_GT7RSVa7V;V;D-e[>PWH@V
]b2;G4O8K([;WgbS[TS<](5<^MWcadC_VA0_)^?)#M^J#D^VdC2a:5X+\C#G.EF.
Dg/8S,0_X+-4R06EXS?OT,]6bQX,N9LQdT701J4-?3DC_LZ:;;MBa48DS]Rg<DRS
T8XE^fF(##FMJ1.FXZ_Y:bJVEEV0V-@T?K?\^^R,M&FAQUWgcRVZ_D1XMI:=adZD
H0]U89SY]^a,&+,)JZ4T#f176]E]MM@9GDG[7T#_Ud._DHA].a><>SW&-aN(&;Y[
H[ZP2-dL?V?G#b>#7GZ^;,?ZD1?F8SdQ?)cggNdE)9Q,J/[C>4)3Y:a[9__^?&X1
?N^#E5RCXQdIKO):X\IX)A2TCJ.fBHaWKX6L)Dg[;+F/]?I11WFAE>(HaD(H3&+]
Q]RC#S<a-\0@_YL76<VYGM)-@^S>/f<[).2WTN77eabMVF^+6SRGL<:U&TX_a-TN
XJ^,4;3ULG[P6.8/_6U@EN4dFS]-eTN0PL.-C+,2MdLBDXR)6ZTL&BG,:.DRQ6/T
67Z(?1(b>ACUX\9F=SQ@ga5f:##Y9[+F4IRUaf@>_LK46X]NB\eHg(M3>U=-J3D0
DHY#NH>dJSC>d@=\#86<J[QB?7&G3MZ:E]5ZIF_C33_)f5fG]YW_aD-4P=I@_AX2
SG@5E5a.WH/NJA0T_e<Z]S&G&)?d23[9@-8Z;)+TU&U+Y16=_^T1.2H5bJR<3>#D
SFS08/e:N@VXI0@YU6=R-.NaGEVQR)AAK@6Af4<Fb4WYg2fZNbRA)eL\GO9)A)M,
PBZOGYX\f@4=3,I5-ME-;&OW,fJT(WWE[B(^.ZSZF5._GURCEJB__N38+0QNN36=
MYLPH?4[8=O8GF]_DRQb0\#0S65WYL,c<BOR3C@cWW.U\<eCf1C69HUg:I@2@04T
1QVF1O_HTKO33fH5C+:?f4XZfYN3K)PeMR;BDN-E=;:XDZU[\U&>=E\Ze[C6d@eG
gGT8d,Ag&?dWc/NYO=O:Qb/OBP>XaEf99Q]VW.\B&A51:A\BK1IDK@#1fK3-Y@:,
-JDf.8IPd\3.#gcce8DGTMf8@PV9)/KXENHVK:5e7U4I.>7S(-F07L1DSK6I>=@T
W]TE);/2JM<I;_RU3:PW.1)UgVdMXSgN=4>aH3UVE])9MCS6Ce=&-F-0-#feAS#c
NPBZD(DB5Y_)g#WD1?9@4-V@)G@XQ/UICA-c+:^feAJV[KT6OBERMV-0I$
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
bGR_1GdGA(;:<=,D)C&==MT@98M1=K8#=>EU)ae,:6U->NN0<E&a(QPW<EDA)O+5
?-<C0)O_OF94X-H78[<LL:+>?G-#S^]@?]R-(2P+;0Z==dV_f<KF]YK+)C00/7cW
c(B>O^MVS#9U^cd1a?S&C:3BVbcc+f:E>@=XIW84:;RfaZbV5(IK9a+//PJf,9T#
B8B((BMSbGSIc.f]C:(G3HZT,F6\ZV_/Qc^(aHHBLWZN^4X/_>,^:UNKO3R1#0F-
b>Q#bU0@-.^d_E>5FOV\65Q2dX+B3U9N1Ha9A.PPB[148?H&F6M)0#Td9f?,WfYM
H4L_&DRC:=GOfQ4C.P6a(M)RYL[Nf?/(E8J?<_UdaG>\Q-gaT&cCUIbON^.B2N#Q
af1;)-Gc^1A]ICS<Df+=)<4Sd(7<O_#/aD-d5a#AT+#EEH?bJ6G&6&#6,:7/;W-]
D\(5X<MFBCfVF7O#bF(U1/IBEgIIK@/]eO49+5.:5c._C12)Pg2)71:;9:Q4)UFf
JXX-fY+@OL:U^TM7gZF2Q@(VR2L&@g)RFIMP](0b>,)=:6>2<IM>#V],:]-+d]JV
gA(01.;WG>dCbN>&JfEISf1,,\a7R&@IQLC.fGXZNPbSD[K)N#M[MGK@D@98I9B(
Qg:PNA[V8_H<gdGV.]=@31JP[.K,U/#OR?+,M#bY:6MH<#-6:[OYHGYG9@S-/g\H
,(4ONcB2EcI96dgTR0gFMgVJ?LFOfb<IYTN=S^FQ]K>@QUa:F?R0]KN2,NgS=9c]
AgII6?F?2a]6DQ)J/d079^?2FR93bOgb(K0cYZH./f-T&3FY[3\WUII\.902JFO\
()&TEZ+g>L/J6;-MTc/eQ;ac#KAF/aLREddM1.K]eFX/dD\bMPQP&;D4CB/B4YEd
g.7RCV-fde1B^>@H3<EL/PK]G@EJ+8L/UN9GZ18FCIfga_D6bT1&b\bQL:I(BM@N
(>B5PgC#f)QgIL=D]7U,#L_,[QT]cbgSG-U9H6TYG6-:c^EPR4d]5Q;1F;<D^C9J
;9H)8J:U1PQb6([>?2g@.WVI#D#[K5bNKYA32/M63N+Da3d8)^T;+S-68WYSC5dN
V2aGH_^L:TN);TP=41U+4?-4a/W8GB+d6N[F_DNRVYU4].#L]UTZ;)GD.(HJB6c>
d7LfP\9VLL[fc/PF3^Y..Ja<5BITR#;PYZ85/_7I-+H5:8f<5G@bB]7a=B(ZFZB9
4Y2F([fU]D<=@L6IH6SOc@JIYA94W1BPIDaTg[V04fUVZ12Z[Fc)?2Q3dRXU@T7G
CGVQVCDW6Z\fP<5bX0-K8)[c3;I)J\N-S5RDaW_RUgX\EFCI^#g[+29e.N=ZUHVJ
OKW(NSO(2e0-]_;NT1>&\VZLcY)U^886)>M<V1[S],8MJI<KBaB\,OT&C/-YVCWK
KXICV/-Ma[N,=d^+PZTY,6+g.9bAF2f7,TF-=+[.KAH-9NASdIIG,I:_6_-[?:?E
SSS<e1f2XX)DMJTf\O@==Ha/Z]MGR6c8.1Sbb.2cOL)2Nd,Bc^8-3e/<Bg49g_bC
=1YI[b?I3?S74(NU;(I^Q?a1]^ZK0WHDa>JCG868:f\[HCe@T:[Y<W;aAQ33>UK0
CWR4@B68[74AO<7HOd;#&067;FI27R]8#,9KdMGL1RR2F1&)O,:PU5@78;>SWN\a
@VA\A#/CVS/R2(UG)M+8T<1EJN8(#d/+GG<8LFG\&LA[@U<_6##FGCX1=O\^U#N+
65a?HOH[I5C?IZNaB(^f1UARdAEICZ\FD+Z-ALcM/R,359).d>E7P(T>a5LPXVOC
LI8AZC\gGSGA.IAQX0LMFbIV8\ZH8DaE1^9@4H<#Bf=2.#UD;59gaH@TM37Gc7TT
P[/@4JbR<85+f&gH2_H<PU=:H)8f#+b7&F[1TdH=:MPIa,,O?f3O0/7_]B&,+M:N
-;ZUa&J:+GF2f>@CgOBGB[DB1W(.>:P3GEMd\Df]RVGM>LP;;VK>C_=Z97L<7E4Z
Gd&K^BD++QB-b2Z4OSD4AdN3aAX)BVgg1+1T5N&UYR/(C0f(4-X+XN:]V4W72PTR
H?8;QA#U;]3HYZ?WBK8\O14I=^GfNI0d(I0RWY)9EOMb_A6[S:SOLU_Pc86:I1CA
^,7E1@W@R#M;T^ZdPA6_a8H6ZZePT<b.(DC+\U9_O4><,P2)0[O/88)/S&F60+6/
4I>0:LY-F]W5H6a:N[LJZcG75SMRE\T,?faKegY^;X#^@+QU8)AF#UT(GfY763V.
eF@Sa82,-Tg;8YCO_]1NP<b](ZX7E77Q5gFTfe-;Z4c1#:H],/C5RK.cI/=E;6VD
dc@EU>DNN-F0V&4O@9_KRB<VS_DJcX&7\@O7e6J0@8\^E>7LN?<KcME;2];GZfH7
Pb.(7bY_]<B-,0JPNc/8\:<8EI)0+K5W3=0@G&,dETYI<(;@ZS:OT9\7bN;,9H_b
\26VF3#7@-UWcHNC?.,.Q[@;5RIO;5DSSI\]TD7V0U?A[R5?KfWFZ:Ff5N.PU)d/
\0e>S)(OE:-?d=7Hb?CWKR4a)2c_(e>cCgF?BB:g6G3[._Ra32NWZ,g+ZBP<#Y<G
a4&Y.^g\W0@F3.UVR+K)Z&V?D)4_Nb.5S(=Y:I)cc=02EP-aNGX6a4V>M07[?V]W
gO[\)20/GaM7TEYXSg[#Eg,IL_[X,d48.#_^MU-450LDE^N0NaBbedWac95_a0>e
(>G9<=+RcT:aH7(Y/cRgeLa/UD)HI8V3ScNCU;4YAI.N;GZWPDT:eT.LR1NKg+NE
]egJZ&6\;+R71P3/>6C\(L4gR;T@X4]@FTS?>aHfTb<9f.N[4R(</Y0N>S8RdP0I
@M>Fc7@_Jc:HS9K945H:JbMgP&21AbgP5.]7e4Z[F:\aUMU,;@[OX#Y6+AcfdEF4
+?=cgg7@OOZC<F<^dQcFV8J[K@MHM)b-/-(J=16>dJcH8,HZK(6+75)PQN2eU8WD
\H4^MSJ)UbKdRcY-O&]V71.TWKZUE=8^S.)dSZbJ5#PD)cNBaR;Ef^SY?fT9(NVA
T9JT@>].]MfVKHD[C\QW1(CLdZ<SfW[<]M37?.Q-N8=OX0Xg8,?IQST3EDCY,4W/
E>+C#ENUg0S/:XfP7>7AEe5Ef)5VB)[SM67DUIR_46/^H@9_HMCEAZT3P$
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
DDKY00AZPB\g=BUZ9]O),G[c)U3#9_>3(dJ,)NTT3S.6Jc/bJCL#)9AX-f3G<)OT
ZM3S+AU])<_a44>VWdg>18Q<XEZ<_\_FH1JWWGN&CN\\Abb5-XR:X(RG/<KaP,g6
4bUXcOb^&KRSV1^1F2_+gZbPd97.]dW^GJC_0J;7O70WR7NZV]E7H.@A0<,aB^6H
PaT@T3&^8BG,]S8B0eH23PT)UGH>ZGX;V3R,FF\4ROYZLS6YaZgXD03UBd8MIYL0
FI-3^GAY<-7+L6\Y(_G.WN3;8L_7O)3,EKg^_?_Iag;/6T09dZ__KAF2g-5WG/&V
0[DaWgYK3bI6->WC<b.d=eC@e?PMAB#72C0D5GRTd_NB)@0MQT\ES2R86/^W8B5I
A<H,bMD(c/XJg6_P#dSN9B2XA9>T2cDX_\;.E,R):VIME&?fR1Q?cE+F/eA85/gO
_b0CE9fN;YFDJ(F@RZIHQ&<C=E4aBNeU_SVA]\_=)L>W;00aJJCQE;1Ba(=e][gW
5IE/R@::LYga7F&JH_2cFZ)>f3Z,<^M./4\g9eS+?#EUd#<=CIQ[DNDG5&GUb5L4
=&@\C;)Wd4S1R<]UUTUD9[UBC4-@7QDfCGE8[dM.;Sa4]/;.0]M.@+-&J/EL5/<f
,Z1:A9=1>-?96Zc5(QLEZY#3^R6=#e(^1e;RC2NCHEU5ZS1YF,]6<M^7DLNG>)W5
4c;Vg7^:fc<MG&R7BHgaOa]ZU,=Db6a=eOW]@/0[X4fR+M=.MdPDL_U748NVQAY@
HE@14_:G09[#f=[.,-K8B.=2?=:JO)-[d8,cE[bb7<@P\b_3FPZ)5bZ<eC4\J?I_
6C5,8.IS8VU&<1e[E2#LM3MW1VaKKg]#f5<G.7FV>LFRb(Y6K[QM+cDKdU8A&;J[
@YYf2EBa(dB>HXQFNL-YH;J#\Sf2)^:;b/@KC1F<g4DA#S]WZRW?,?-=Td-BU#<&
R;)#L68b_E)0KPfb^G.9dQ)5?N(-CZQ3@WN2G:\EIOWb5+DTdLRIIa()ZO^2Q:0L
62]2<L3GMe7\STd9OZX>]#-2G;BIUO\:1[\;2DI;:&==S-;U/-=Id#H)D8.b_5cJ
DXN#6c^W<_5AE>H2]:;;a;>CK]R5/-TZF^^MZJJ-E#8.(X(/P:3PYW/E7X)>KC;a
[[f@0)@6a8McN3g[Weg^[(0K;bOb34F&:QbbH;2EGZ4(30CAKT@X,)B:[;Of&5g/
;H0)&O:(Ff<E/GBdeQ/-P:JYN[\JL:<OADGWcd7#&>H\.4@^&8)AZ.Q:;V/[QLB8
<e:6XM#W/G2GH@F+^(SHO6&LZKQVW>c3U),0:f+O&:2G&.QEac^WEI=RbXeX\&;P
ca)I6gcT.P_XF6R4QSIHWe0GOAYEH7MDWbKgMXBM]=[L)=PB/+;JY>7BV4./b6QI
X\Vb,bQHF\4J(=/Q]?e+W>&][<?ZEeLcQLef1@I[d5@4M-QEYY_PRgf3J7@.U5G#
53.;?753M^aQ^EcP:H360N@]W?7NN(/5UfF><WPBT7-C\>H&3\E/aWK,KB(/QBff
:aY&Z/DbJb6,DN)](>WU3B;fJR:7a7A/R1;LEB9XQDg9V\49Bg2K6\Wef[VSJQ>@
1c9gaZ]>[URW,gCU1LDJJ(0Jd>5;=#;LN8beZ]K5)b^>3J8f;1_ZZ9(aW+fA0SMZ
=/>6=IS3IQ>9/+d&+\[MMdA7.UgAGMgFD&T,P[9L07@d4>bAT15>25+:U5L.2RLG
6MZ&90fUH@/;49U.7SXXbPcZ1?aG3J?#63S4M>;Ig@TC6LHBK1H7WK?.F9gc:RR,
C2f)FO<91KAF(T\,VM6](U&3]@X[&RI4W25,H<_G2D>@XVgUB]QY59^8UQE>8eH3
fQ,6V;2fa6f)0Q(,cJgGG:,F[&,RH7eLF3XB7/-e1P(4V\b5E2cgE;V5ZKXJ+c?D
I+d_a4b+4B:Z:W=>^Qa:&)X=JM93)Gg;J(c6W)BeM83c?b1,fe8:dR[X;f:@1N=G
L9^@2c7A-5#Q8PH8c?;(c<X.cU]S)74#F2?9]7e67S+3(-:d2NdR<E>a1(SC0K3N
&<?][[[9B\0I^fA]YF5]FXF_R?RTKfd]MdX8W2LE_T>-#c?O_NKOR(XCI[^R7=1K
^bL4)7VFT9_\G,1G27)])&P]cVab3&MG=#_6[(=>5f9:WW8ba=3>f<A0P>#3;=]D
UA8K/eW\T@?ZPRV>\0-D]5);WO>>Sd/9A82eN,C;<[=GbG>5+\R5I<:KY<:f5Gbb
X&AK[)W0=5TS])R254AD,;JP?>C^G_,ST>97FFGX@ZM1A8\B=^DUAb(c,b8&7Xa-
5N]I=9M:d;1OU5?DY<bGELY2gVHBP=f),;Z9\I)5,ZC#X90eE:>)]Ve(5fN#Gcg.
?X/F0IE^GRW5;/00.(.1^>JYC.RX1,#NVCUW9CIRVZZQU=R86+KVWV7)caOXRF&>
&C.3,G:N)#CFeGN=Z/aMF<G(\+SC+R7TRNdIHWO4>V68GgYIM&8ZQ?Gbb-;+PXdC
0,H9a66,2Fa#5S\gJ)dFEC^JbNc8GV,5@N0IB[R;&^_>4<DJA5WXa4@9,RDGT6(b
2NgN+0.OFW=\ZGU[f=_7ZYY#.7CTQUfT]TZRXZQ[&?UJ7NF<SbQ\Y-8FX01.CGQa
FG[+3MUaD#G3Kbd<daSfD5XScJd-<)L-2T2&Dg3U1^V2)5WU<W013C9LdG6MN6+>
A-F<[B8aFb8IV0F&?/-:GB,RARMdc@/YPc)F]Kec(KW5Z@UeT@JR_.-RGI2X)CK=
7D=BYW2QbQN<4B8J]UU+/7K>4^819>;NXH.Y_5/OQAMDCI\7(7&b4bG4W^EN^;4<
TE(D,<<MA)-4;S_2(D)I-0S<eR,.>H,PS@\D?(F>e_1BS7I+_;+=OW\&.Q+fS/7R
9W[JW?X@=3H,/3dG9KMYZ[JOQA3ed?g41,HbcK=,6Q?a^d@.4Y4/M#?ZJA:1P#HI
R+44,/PV4aeMeG3+&e7.a]U7038-G_<cP2]SeRHB.3O4E26>()1P5Z161TYHOZT]
_Fa)J>K0>2[,eVI;\<g3R,FCcVW.T<>GGbQ<[8E9J&;F5/VLH#gLASTY-aDEW>OE
4Cd<ZU(,LFaGMLJP]g6FaED[SD3D.O&(,:JVCV4cD^YdWf#LdaG,A1W\^9fAASg\
^114L,ca26BVXOT/6&]ETV8O6M\7RV.[e:.H&S5(AP,92+b]6-<]4_?/8T(CXPTT
^\.ET9e?@M<8E45B<f=C@0fU9YGLXUbZ=U2J=[Q_]-JJKeT)NHbFLDHeIA5OT3[?
WZ\g946VAG^C/IL5I:XEI2E)P?UF=bJ#DT9L7O,b.2\DLba0\<bU-5adccaA>@F5
L+OGg3W/gH06H_Z:+]_A@\@OOD<U:.OUVFICa<YFH=5]#Se5J^c?GCZ^PCLP[Wa0
XRd<-^@U<&FM7L?H6bF_Z7&\#CNK>KaYaLcXUMBSR:1_Z+Z;=[_0G85OQJG^<FRX
1E6:<c_KH)\D6/WE;+aZ0\EK=I5W6Pe=gKAYZg\e&FU#P2@<gM7,>gU;/[,@_bBa
;+#WTMA[XD52a45U=JL=&9ZLG4<F#[&MBR)]If\UWac/?^/[UESJWDCSdE_D_T89
[2KZ<Q=YA:(CDDc?Bd6IOGR3-N<V@d/,O1\FU-d:YM?eddSMLB\?fW,,H#P(()P-
Bag45fa\b_UEJ]=+KgRZ\Tg(fa>\Q\@S7_B/H#)=[02XQ/E1Ag6D61&P[]KWS5@Q
bCZE5-B8gT#Ef&2\7[WO/JYIc,ZR(L;N;F04(TR2HNUO-46DB:DdLXf+aQRAQPZY
NK;Q:<UKA)=#.8CDRQ;8=ZI#KD0+HXC,7gS_9?QHW#@\A2&8SeGM7c54?McU)S?,
T8XV5+I0Z5,;7+;2\BdN5YIVKD>N7UM6]_1894[I??@@HM4e7e.1>88KC+^W2U[0
7NBN=:=6g4)Ee?eRS=VK2&a4^FOIG?A0dC4cE&.R3/?6,U^_fZ9:d@Y17Bd67H?T
5g/T\G\_()Z7\4)[BO3gV/G]]6KK<CG+9G5JWLR.C\3A:,D-M=:+f(dCENFQ?5AH
V1E21M6L/U;(S@7:cV;-[)bXeYI[#R)Y\+X6T:7/RHL.&b/F=976_g\AGB6TF;]=
++H>aG20@f(;Y4N\YD4HSEHNU^bWP1JXba#2d74J6c,MB(T4W>9N]eO;QORV\@6,
8^:#V>=R4QNW\/e&L/+U])&:Wg(P&[+)]eS@R#\0IL&f^XYL==0EfL7SZ#W1AX-=
d3Vd4)f>EP-:<GU5[^adNd?D1<F9\(42c4a/Z2SF;1L1Uc(AW&VNDOLf@aIf-/1<
gF[;K6R2YKN+Y<)VVeHS)<^2)K/[^5fTLF,g_+eO>UFJJ)&J8D<R0KEML/d)I#f&
,ART6)T>5@bJD>.7g7[7-a8-TME_&?-D3RcE&f),\;0IL>OHRF>Pf4X_9M04GD6B
],5dEK_cOEg6BD#I39)?gR^KaW3I[_M4)[Xg7g@fCRfBBAd+)N3+/8?TQ_.2FFWV
(2?QLZ(M)9FdOP=(?dVT+_2JWOa:A6.-(X^S7^[=,MXQC](>HUA282B:fE[R+AMU
0O)W-3#[2H655X^HMW-P0NR4,^6B1=6/<6?>/U45OZ4OYH17/>QgAZ[?#bJXR2HE
bWQS,8(NbfUeI;BbNOBH=OG^N@_PJ0LX.MgDNZGS>P)fYKQ^LD(BD(H^H3f[P&0\
?2)<S]Ib]9T9:O\CQ0,H7IKfPU64;G(,J\1aHNY91]C;B^L>U^IR3fTC_\6Z(V3L
7?gfWeJf>8H#_f(LIJ?GDRCTA:bMZ2/2fHVF#aB5-[+396fLFd6MKBcM9g0KbA3Z
#AL#7NNJ;+/4dD>GZ]0W:f?&FM/CSWE[,Ud#.<_=RCMPPTOB\4MY0:GCJ0a46J)5
2IR]6B9I\_BRZ8ebA?I^,V\WCP<YLNGXe3IL\.:UOBEI_+gX8H1,&0F)<#R2Fe7Y
LfN<bT7cNcW3_M/b;Je02+Z8A56[/bWDc9CKCLB-bVJ@@:gKHE(7aeA55=84VacV
bV=[0U6Ue[c:25/J_S1>fbL_d<b;)@KOIae^a4CZ=G,ceHCM/b=gBZO:G@A+)Q)D
_@JGYP-BA_(\G?-C@NMRY/QK;EACQT(8:3YQQ[>bTR?4.4N,NH[-Na9?0@cMb,_7
OTg[>+:\K\bC+D8eV<[1[UH6@)U85W-ZOUaFEU1-4(>FBR+EVQ564,;O.>D@<@SS
8J<</N:,TNP:SWM>GUY;P&</&@Ne&RHFV8-GY=VE)]U2WUHS0IMc+;dH\\A(,cFP
510Y8WS<TNEE)369]/1:Ie;P>4OD[^ABW)FR4@8dVU.?KJ7HfWNfca?1)Dec#T?T
K_MZHg8RESg+D.cM[ZF(CHK^[HTA<NfES2T1?MJV3@LC&ACEXU&QbOL_Ab+Q7-ZN
5\+<V+aAR00FSIYD2ed(4dP8TM>]?Z#/8,PA0=U[gJ3Q][Wf0)aRL,13E8EO\BZ2
D5-9&:F;gT;W[]+[>^f)Z;Z<10a8J4.3-EWGEBR2?Y,HQW<B@@9SbQfH2I].O7R<
IP_9Ba8RPKEcFb\Wa5050+XYC>.32g?gVfL3ee:[M6ZD#aC?,d]g7a=)37=GN?RD
eTO=)C#Q_W3D=Y;WS+W=7D\@/A-&PQ:7L;HLZ-/SXP]&J._,-YE\Z:e0#[H_B@H7
34,4VX7^V@-VR\WLK)dV:T<U1LbBEZ6-A5YH;UQNLB\dT]L4Sg0?H6,QZ+F@?__7
FZQ]L>#F@O(D-1a+^WW5VHGB@MK&G?gDI>g1a14Z[Se^HG^fC:L:B9G6BK<9/3Fc
SSAUH.ZDEC&0F5(IH0\WF]fAS(4/>=V+0-;@/:L-[WJ[SN5+e\\2[\0&a1[X9]F7
37V<+UW=@C4O(H8GU/>P64<E;V7VZ>C:8;Q05O_L6e]90VW(GLNgU7+ZU,Z(=ZL\
AReV@-Ha^/GVGDaBBKIP_-Y=N(7]P_c-7^f<+OP>J_f+f\B[b=Xf.W#KOZa1e[FU
K4WG:F-P08AL@@?g).)f?[dAMb]:FO)Rg&SR#62++Y4J)O\De7U+f.VNZ5:=cd#)
>.26JE]EUGgaV6?(S_B[QZT&;(=,0L3Q2CcHJ>_OUW+PHH=JOOE2C;.<fL[DW&JU
3I=>CHULT,eY[NC[:Qg9>84>&d[;MCXPOZ\#d=Z:1C0+KHU1EbQ-(9:O7UQEE2->
?E?86(UPaL[bI,G=Y,W):\9@46+^T@1[&-,a:G\.@c-WR-VH7E7FfacR,Aaa5,H<
.Tg.c)8X[GSPdVgO#6Bb#R3=Ee0.MRf8+^),,K.T?EAgX:(.GB22<,;E6KL-P_TZ
LUZYeM;P74CULFIJ=6.#EMYS+a(-5cagA/K<4(VWZDR;8)g)Z/4<a&^/?IY)b>-6
L,-48fX=cKba5H/7QWC_5_B9Va&U;=RA>W&E8A2QVD40a7b7d61R(V3-aN[EK-,1
P<Sc:&#8g6d44M78Dd19UQM<9OQ;;K5;cK/a5IC<(T#UR;-6FRCI0FO-^g1Q,a:-
4;UWQDg\#O;[a1HO#dYYO<4]G)fbR919UN:<<EG.-_NK\VZ:?=+Bcb.=cGgW?Rd6
@=P7K)&&]eYd8,gEcNU/109HP/e9(.YMVYAB)?5TFNW@g()<g+[U3LBL3b?f&Q5QQ$
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
N_FP#RYGI7HE)eI41N(:)+5H)TD9-IXP9224,I)+)Sd[QHZ@EGF^):31)Ob.-:1T
\X-.dC0FEMdOg87P+c(.+]ReQI7AS3B=MH<..@e(B2+<\7aEe;0cCN#C-I8d78-#
0H.C3ggCM>ZbUW+-]C22T6e;_AT^b][7OD+RdfV4aPD8W#Gc+f)Z]6I^;HLd@,\F
^#LG,F+aB/YB2SM.6g9<M>1Y#fGN^2C6aeKI(@HO]=-W<3#A]gXTQ3\Q6:)EVe&M
:7E\N##M07a:C=4:Z346[I)43?LK39F;@0@IABJID=472a@/;^F_)5R4UY3b/DRd
XV72:-D):YeR=dUO91[A7X\HgVMS4;O=6^^O<-VO),TP1TY0ag)^@LC3d2Nd7U:S
JXf@MW8+gQ21=-R\Bf53_F)_OP:\)?U\HAUPX#c]5c)C>6X5BF)HS4c,)[eY,FZX
IW\e&daeHdCRW4G55_AY2=XP&M4H(XZ5Z7[<IX7M(7^/.0^BK?0J]+@KSfS^:Z7A
=&MO7+AUDT_[\K@Y9.6@:WZQ#dMFSc8Tc:X9JeA;J&Y=ca=8_SAIETVfc(??d5&8
6_K]04_)OGMfH7M2/G.U)WUEf)#VNCP.Wa-]>[V?])9GEeA@>c6CY@NR2>I=GQ9U
3AcE\25Qg(:66GKYJC1UP2339V;8:^>_E>.^f:IIC8VW:a?d^)0CW[N9]J>cY)#K
IJTId=LB1YO//ba3D&-g]6?,g/JfDBI-L7^C9d]Q@=VFBTTA(BbOYg-10[8bH<(]
XWY3NS1[4ITYH8ECN?=M>3fTUI&9W]]N@X__Y0JP:X3bEQ6E^EF1\=9Q7dI=(C)D
/:@16529#<)aK/F-H)&_PU;Q3dH0CQB;:eS9KRgWF[\:MJ#+@R6U1QQI7@E.S^1?
A<+.,>/Z)W=6NF4;1?B0F;K\Td1=?Y4>]B(+B<]Ma(408[&27Ka4BaYV#3S8;JbK
QcH#G;4^Pg/(PLUc)-+?]8+T&1PdP=gN\&e-)6(J;#TH:C#1-T9+G@>de4U8=OGE
ZD[>A>=AT+Y_G&4&\BMaOSg[^_6DT[W?1H1f4:b3D1ZJL[A?WW8L[C4JCYB7L),:
D=dNS7c7/Pe+dA2:f:?+.dELTf02MES32@]<7[,X#\RY3<HSF&4(TOZSL9N?RCIK
>Rc+_A?RB-Y_+.J4?7>+OOSM1U0Ma9JLS+d1]ZX7IW_/DEfTO[>Q85(>Z4Y4>KYY
(9?WZ59I,H4ZZDL#I_KO3GZ,YVF0F_9<aaV1V3KB9;A[A_1P9\N\DV#[)@[EF1>X
&7JBMKYO<S/-<:-JSUd(=DMa,NS;:?D.cN3U=G\^W^I@c7._77GX@fDU0Hb9U0&-
c.KL_RUO6cW)gK[?D2##C,4B71L[&)8#OP+I_/da@48A[E6NL?<S,T_)+ZHgC5Ga
N-]<&Lb<gX>VUHXS>bEfg411b[;e?-(52VbIAeC&-\P_K^&489\Z<Sbc,ea8Rb+C
5a0<9#4#HR5g>2F]&X6XOE+LcI>E/;<C^#>aE6-2\;GC9LeG5a:+CNU+=^ff&Z(6
[?=A#e/;+#LPaf)-GF?UR,d3]ILGQG+M2D7M^==SYVLfd/I?KHeW?IAZZXQ-)2)S
TEdSV^+SYWT<C1229Jc8,:a\D?Q/B-<AZ1,TGIe_&B&@Bb/ddEOBJXaaCAB/fGKQ
6DMJZIX6FQXUEYKH;>-AcWRNYBS<J:0=_.95@2f78HWXP+1f_G9]gH-cJP0bJA<0
2<<b1D6UCE;_3d+7)3gX#<_2?@4_PZ\M)_;/;7&5Q3SWR1]>QbN.[>=S>d/I(>9F
c-W+ZTDF?Z5CA?O70-eU_LS)<4GZ>&ATF(R8&=Q?8GTA;9EDD^^5M3H8E;X_b&X8
(IGJ@=C5;@NG9_0;J270YbNBJNCf_gNba)51<c]bWLaHI)XCU_T9J2K3C58ZeT/5
JZLH@5:B@A+Y,_?(O>B>J(]<6<[_O/@6SG2]JfUdIG7Bd9d.cT5A9P9NNdW>;Ucf
8Nf+N^;g4LYV.2;=([KaN8J5GF=9..bERVZ#T[CEee5H#2dPXc\NCa>FV3@7JT6T
?4S#Q&35;K5W[303=\/_5?P&gd\c@YI];Z2f[9>4(_8H63GU>C\B<A3GbD+B;Y6a
eg;9\>f,>Fe]9g,WST@SLAdU[LW>GBN0B\3I8.?359c3#?a)R)R2>eBe#ZOM.)T3
<H(NKN9L1U&[8GHcfH4PF-LXPW3?SS3CAI4/;#24#,df\#X;OS[?332(c4&X>:[\
-S/HBBMPZba-&89<\H4AFB&@f\3P@EgQ&CO8EKKF^J++f-8Z;JA&XLVg7)GE:O9J
UV(K;(>\>SFXZb3-C<6;,UdU.\N5JT[&JG)#QegPMD<,0Ne_0#US2I<375e@3GUZ
bG<Ed],=W,T,T,QOUcRdYI3(fRX9a6:4SP/+W,?XTY5.J\\:J9MWJ<(;ASCaI8.P
U/(=#cQ?a?6/gc9=7f?^^;X<BA.\&_Y5:gg_^T<.SIZe>Y,>SEdNYR>d-&4HR8c_
#^f02I2UX5[-5SG>a7ge;>(.DNZ9O/3;G3Id[=OIQW7[5:OXGDL>N;36:+_aP<4;
3C8#O&4<e/5e3)Wc\KIA&+7dESd^RN59RY-[Hg5IB;89G]=HTTU?Z=N99NQSDPUf
GTB2H:>/5_()VJDV[b/Q2caTRYDEJ(US5=G,4&,R<1OII0DG<.-X1&O;:6f5[;d(
L5Y-<6)[2e8a3;c_TB?4?ZTeYRA&-@d)?W@cXPY]T\M0FTAVPL1a40<]<??F3V&I
.47VRbBG@18>BY=QC.()Gb.#O/HJ1#85fNVGgQ-3^caFAUdW0VE6..Sc&Y7CN+=_
E781:EDE@P)Q52++.F:_U[/e:gUZL^.TZAfAQ+7PdccZ#D<5N,6[<6A2bKVaaP#7
6@^K.g6agRDD?GbM?;gZ-&RFAP7f)GaDTcBeXDMCE3c+07-(fFV<_86c?F5)UNMI
AR#Hf3K)RUO\J9?QB,ZT@;OWOOVVXV^?C[LbYWbIb#HG1H)ZNDOTQ,3C-_PL30C8
5gg+#T<IAVCR&<Y9D<BGIgP&e2>8#bdO(0d?],UP<:6-bHc\e]1C3+_<ZJ5B>3bf
[RLMc4LR[26L0KBde4]L^V?X<:>>^MIeB.Ue;7bE-[b\6Z4ZN+XgA.0&gP8b[b2X
f7D2_c-3=E>_TBD<Y&2=\+J.ZM)79:D^dRA\)][DFOB3U<>]SIP-2>:4A(4:5_)<
46L((6^[_67L6H0Eca0GPgJV:,2(1Q6);\ZQ(33L^E_#T_g[SfF5/VA,b?-G3#,^
1]/3K(D(IF0-Ua3.P\XEO?FFcGOC/08b\A&(5597WeCXCLN?EM=65X6bbdR9GYI?
I6L.<P=(^=<//,Aef<>A>I4<cCJ3L5#_E#:I5M>1#N(ECQaBg.6?eM6bL$
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
Y,>A-R#5A<CO999X=:>,<4U9-E?-,5@e<W4=9_#13T+K(9^8a=Ua8aWQ,;5Z(K\6
62GX-GN(I-PH[PQY;::2Z&eaM^),^84+HV?_Z9;_QeKJ0U@ga//D4gJF#gNZ:O;V
#@)I]6=V5_b6+3f,I3AYLAL)ZG4P9c3S=BTY@?#P)3+(Z)^YTCEb[:O-K3D48Q9.
>?GC1E9YO9>eF(6-T(IcIUYIC@UDe^>B3?8MMR98#?D9J8T8^/DgY:HI/&UX#ZCe
;0JX).C&.FV_L)LG=T#XIR7>&5HXB>/+4RI7X>G2L,<^/GSBSR#aN+Fd,+b?_7Ae
F1YJ=&,NRg;E@LO>L\X21]Sf.M;RUS[/F(/ZB_TS)MLf6Cf.A4<X[Z<#AYB7D5Gd
-CaIXDe+Q]QHP[XK@P[Y6+E[Kf&V)5TMJ/UI(JEOO_WS-9KNNRG?G19@C-EGIWT)
F^dV@JV.FbB>(_>)JF:AGV(ER-,eW.O1E:U9@<&FTD2g<#=(FWR0G81>2CPQZ;06
&ES:c?cTLY&KeV[:e,7-4P/-:L-;:IUg8M9#0gGO^06.dL\^#c>Bb26fMc-dDO?7
<2R7Z19FY6_8/Q85RP&Q_GSO+AOfSJYf_\]]?RF8\@K)d-=>eS;S2S)e5:e:=ES-
g?;PS<0fD>YV^>QCARZaP0bF6F:5:cK)T^L)^b#>5D:U4M#]Tf7/dQ9_[B_<;-#7
2QR^=WLLQ&d3CAJB9^0+ITYbM#&>QK>5SF/W8P9&(eC:3,2RScTTODA)/-4((W?E
4&gDf/7V<.74_>0a)RI)8GWG?EK/U<#;U.)f#T_0[__b46V&U)QF6,(7@Y,@b0fL
cV0KO-W9QGTEIGMWdf0aUB]^P]RFK4:KgF:YM@&VK0I4J8@3V<O/X+4XL+1ZY5Yb
+]ZbF2G\__&D3K=(GJBTM@5.>9:P>GYaQ&1LC3YKTg(Fd,aSMSbJ7U>:?LeKJMeJ
9_Y+.W._8cf^?C<C9NYQX)Z0c9AfCbN>HLd.VYJBD8;bAfUAIgGR&+]J/Q8Q<7NH
,YLQd41.^TD::fGZ#Vc>^cF02eE)EX&Q<N5=3R(Y00J7g#:/4JDcD,=CL.<C3&P#
g?-[gdZGD&KAFa=BR4gg=D3]S+a9A9c@\CaWMM.6Q/Y,4G?M8E^?<TDN[/C:;dV<
/@<T6&LP>?b6bE:+^\\=.<X3O&]P)4G;9]Qd6/:+:.G3Db]/7-<HRG<;-HZ_/<QH
bIJBcKX52<B.43D8dSBY@H-XcQ;:90g2E^8W9UU:e2EP:V?V?\2V?3L-Y/<Qe5X>
)a<g/c3FU;UB#G:e:,3b^G,Y?6.fYM&[UAGc8SM95I;ED5d&_UBIJMR#K;##:N&D
U>I?9PA(F@ZZOKQ(9?WXRNUK9E/U949b@F,1c#8-K-d\?4#D1Hd(E8H[dCR)EA1<
LUZVb+YMK42^;f)V<..LeK_gf@Uc6J9EeQBc@EYIef>0/@N>d3_/B=F);Aa[9.;U
WGF+14?7.LQfRM:3b<;CWF#O)A^c>J?=eOPAOQ0(P.-T3LQ=V)=S2gQ9FOQ4#17d
.#&BeT))dQKfZ-42C?dVL_^(@\>IfANDX&,WUHg6N&Ea9QMd?R:/@I<cb_3@3X^5
2.50dIb:268Q,\4Z6F</T&RZACFT4UYBO:O)T<<)5Da;/;X#2^)/F/N9Y\1fVHbC
De46&JWK.G:]5Z?bJ&Df,.cB+R3,(b5/0[^&cO#MQbDZKJeDFZUeE5EQ9Wa8,[7?
HLRMVO#9.aS&WJ9f>YcgCaeMFMQ]YF91Y/g&?b_W.VN9Uf?b862H5R#L#,1GE.YL
.HAe])-6K&^6,?QKCCH(>U@1&T^(_@P5d]aGf125?^7g<)DCMgE:)4H<bA?OQWC6
GO[ATTaJ7\/>7C3=\-=@4W3&]]L#6L_L-^BPeE:Deg<b.<_Yae5EMG.GdbCHM^_V
Y:>4-+;N4(_6L0Q(WDdW,R6cO]\VI-bfKQM><7&dX/@YB?F]LQV@8&)dgeGX-BNU
@92./KgV-Nb8b(J\4K+-#H>Q8&-dVK:BJ9e=AHX_b;aP3A0#0eJ8-DR@J\3):0e&
3GK<0^1De/)7A8SV<SD]-VQWD4=gFD,LD9X;..<;\4eTe<\)g/=Pa\[)F&+].1H5
7GH<T-f6d?JaO2Z9gB33>Q0d=WBgXVZ4+U?6;PE#1VEM\IYSdF<6FHH/R77/Q2&.
>RZ3J97-/.5)./VA33b=OJK@Mgc(gC@Z5/((RI8K.cS;@WBU8K7Ig+cZ@FS;f#OC
00bR;J-Z)OcCF<2cB)O]cCN/IcFce?a@R=(:B8.-#3_S_#a--.,Oee+gK:6N<V,8
&g>bVV([4@Ye&g]X20.\,>Q4693&SKHeTRZAGPN8-[(fSBG@?/CE)P=bR.?Jga>M
7b,eT9Q1.XY>SB2GFI2X5QQRC@:G]YY2FEe\C=7^bMTH-\\=HHF3QQgB<=PV-:d<
R+(,V[EGb5SA0JB89N/L\P3:Kc[#f)(gX)WD0&#+@0:/cKf\9Y7<JW/d6:F6&?/D
9RcEf@f;\LDfBB?_O8W)DLY/ATL57OI0VB,>A024,L7/C$
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
N,g)N;K&aLQF,0^Q-:4L9:KX)Tc59aY5)5XJ=TW5:2dGEWfHc?J;-JAb9K9@(dO;
:(C?KJZ-S7W?2,VI&Lcb]N^,U0[?#@G3eB6OfEW^GF/Y?DHR8Q(GNF3eU3OL0Q#<
e@EWL71:5da^ZHIAC>fAD=LE3:/cebKKQFJe0@/A1c)9:8X[Q4_d;HO_OQDae?1C
<.Fe;QCVM+D(e+CO&7-\M,]]REA6O#LWcXP2:O+@b6SXdJ.V)bX5D=ZUR4c:WHRO
BO&ZZ3eTPd\1>H+^G+c@KZ@?ABNJF3^]DEEY[;:WT&L_@G.33+B@S_g:PQYY,-G\
-DI6@\4G<G^AU<W-3N9aR?9O[d=+Ef8HQJOU#<])73d[[A+A0KD>g.=P0,c2MX8&
MF3T@0:g[/Z+<5&A#e9>O8gKcET4TQ&:K8=L-B;b?Y8^/HW4&IO0H\W:9:^J4cWS
)M)N\ZU(AYLeH7^11g^9DdCg3.aLVA[R8MZNYN7/#A/9>f4ZSd/4](Q=,9cRa=Q4
4G5JPX5M+Ef<?W3/9)gRe0C3Y)W)V5I7d<P;]0HK?;_Ad7G(6ULZ(L2_LZX9+B\U
&e0ZPY=9PIH<cZA&;(D;eTN;/<g]M/XP^9.^]@O7a)[<C&N>I7&+SW5ELF;d0J:I
U,XXD;C7-M1D\[O8=.]\2WG3K1OAg]7b27V3H2[M^/<2].TQ1ZHbX(.,@T_N+J9:
M)Y^;5RPeJEP)C^gC6CWW#Me8>GCIL;XO:a[S<^D=..f88^Bd.3KbGNTYbQM6e^2
I-TA=>g&09)FK7U3)cT\2c9b+K1@dCI?#dP;&ZcNV_5:(:0?57R9O]fBVTM,UWR)
c0EeBR0(aD\b(-=BGRL;]B;X+:KfW6C,LU7]+5V[^1MHZ;].+C5/ca&P+]ZP@NU;
(]CgH03UAXGZNXJMD<=,;;\15EJ<G:^I:[UE=aWd,D<LZgRD:CV)9_23eQM]D>NV
B302aZ&fW6(S03YR&W_A;^-99,&HYYRTM=<)\6\IW]]74S7V)dM1M3Id3WL,>gJB
V3D13JHVSMb\-WI9dfB0-a95Ab8J6>TM>=NaMF@;:&F024E781S<UTS.<C#>_/WE
U<).-?I#S4TP)EW\f[0[AD<Y<UN07Z#.?Qc32-MX7-OS[X\(;B=c7:<OMP]4Dd4X
H1CA0YS8>^508&JY2PTgTgI](Y@L(G?&1U:JC_[-:Ne5OcDPKUd>bJ7OX>3<Z=6(
bUTDB-?LX5171;YDK;?/f=J..0I29:Y6&_L<Uc/9>Y:&BG:UM>+Cc:X8G;Q4[2M>
6ZWRAWMM=):7\2P(fGSLWE-2\7)1;b<VbTK7R=()fd)aX398;H3^Z89KPW]3;7Z0
?&H7?d@,_S>?,)^:S]\=D.\R:7Z1d&0Ed_JA;SaZbFe#)6^_LCgBg[T2b/;;H.1Y
(3+1SEZR;YbO5QC:LE:Bcf(F5BJU^f@/=C[NLbOC4Of5RH41RNB)G+E;QSYbd,5U
27\feCL6_.?+<_^-dB1IbFDT\g[.7a/L<De<7/?I@6PF(HN31FF\_8bMQ/,6g&#B
LV>U1(-&XA(KQ#/&_Bd=d@N.&RK^=K&4\=JP+OB&gQE_W:dG37cI>&W5HT291F5L
]?W2\E+c9NLg5BWF:8aWNW?2C;JF[.41EX:LE7)5Q.0DAO7d+UX:7)\SI]WT4Qf6
](54+&RT36LK83>47QBYQ@FeHLTdR13a[Z=GaX(H?PB@2e_[01DHW0AZ/E:?ON=C
Y0C_9O9dPHS6?B27R@N[7A3+_+dAg47Bc_U3#A4AX0S.2H^L02RG_eTOY;aPCB#K
CNI:\L7Bf998\N(1Q=Z\\#geJgbET[Q<Ma8?7+.ec/#N4Z7/041(7g92R#/b?S@_
#9AL4bS@W/:dWF(?O+(.?Ka4S)7[gM456];D)6&IVMD_4NQY;H?ZL(54Nd.9Yc5+
IS1KbA3c>,CDST6?P:@cFMBS=Q7)9Y6,Ta0_04a@QL9D;[4ICX-_&]N77cDFc/M8
&,PEZHHI;aR-g9NZ>SaOT:\a=,P#FA/bR>..TIU&V_P/XJ9gD)PVfO(34B:cNCc:
K/1T?.82]?M<R7^f^>@,\12O,G<2SZB5#./>P)X+M0IKGF2a#F@-R.V:@b+Z?[DS
@@gd59IRcL&=NA-ZCB+fEB+ZO2W0=/4B:eBb(H#W?O.?\DG?dJG=+J:dRR&CV0HQ
?<&:.VgL+J/<AI+-g_+UNXTGYgW.)F5<:)X1RA,BT-9A5a1M]EDb]9DaGHC3aNI^
SY7@^,05F7G-K79BJ1)g=7be<77+:\@@6gU-YKZQYcX=_e-3D#P_V3:H\&;OZO-&
W\54BU3_0+/+O.QXCMERH8-W,V.a-YW64=:gA1>AY:_^LU#)G+G0aW5TG,UDB[1B
]MDP6.UCA]HdT9&9KL44PS;;A]-F=9QSS3=2J]]JeXd^()WTQWA>(3<cMg78b13E
O,:)Ae[7c);C6.A3F:4JSGg>?Y9XL54;.&J14?--@?MB^HNg+#TbgKJ)_AA4>cV4
gdY?D[X(TT_HWeE+A8c<5675aGgZ/Kf4d:c>.#HU@P7[@G#CgXg+U-G?Cf028a=P
=Q7e16\X1U>H#[8CE&?9N(^6A9R4DQ-AU26HH,LWUH#Q@cffEWgD]LTJ:))@H0Z8
@TH=ZFQUeO&000(F72+2K+-LTOY6bP^<U[2F@[1#.@c&1T<YcY@2A^KP_YNL2/DZ
XJD8MD>H;1D[BO43[PQ.-9)OL16^Z971J@.8MK9a2+Z:)gR&b8./:Jg[X1^O(GK,
-),48V#S2@#_6CLL8TM76&b0,-(a+9K+_(^-8;T/.N5,>C)RU0\#EIG<\Yb)DLK.
Q49TD428X7aN<b3T=[&MHY(VQ:O_H;dF?569KQB0^UA2A2:__KcaEg39OW2<QC1,
V[35b>([8T_HWR<Y>2?R:N047M0)Ug43:21L]c>/VNPa3J=2?@04KS3IU=^?7LPA
PKZ<R;IA0B.PJ-,Ne-PM>cJU44Y&PUP3A@04YdHNd]8]Y,cF@@V<)H:<_+/Z/WUa
g:4bSeTdEe7@\P7GKN9<eG+9JMe@d[6QN,e>^P/Eae#B_?9H:P>O[RP60-9?=?^K
LC5R?Y6+(E9S945]/[_T\d#:dHV]JQc6g/VbE4Z4c\=B]Rg>&I6Rda+a&8VV_:@@
VV?gDA-RgADASeNL@+(WW_O05T^/PQCW/O5;XWM2OH,OONNSK83<FBUccFS?SO(G
J,/77Se)b=\DAVDH-\0ZXMe]H6^2HM0U_\CM55GfG+97K4aWG2;PCc09DHLY0M8Q
d=::A?HYYc.3g4P5QD@+/_4KSgf7FXHF/S+aP/\LeSV9<>MC[81,W]S#Ca4)<L;5
2X/&&P@GO5+@4)&ag.c5&WGV26A;69G.B&aOg&7([.O]9>LfTT3DWC>4A4Z)WV;V
KfQ+;,dG=Hg5bUYY22.eJ#e7,[=K<K,DI0TG^6,NHfSQ2@B/#+\5(:fWS94H9N</
?K]X_@Vg>4PgP3\34\_[A))b:#/)MD51_-U[Se(Q^66NZEb)(?HVVdBHcEf;aDcf
X^PHI(S905.^=5(=7;c[6/:51=7K;H/7?3LMEWgBHF&b2(^642IUTEO=3[9+>&82
3Pe_TEdZeUP_+7/A]c/E2O:55Z]2.LaX&?P84&9.GgT&81XRe&>]73DgWYg/E;YR
1+HB4U7OYGg2;@eO->D+Af?[KIa;8XHcZDBd->&\X0eCb]4TR&P8,@e/fRB/@a<J
)]cK73SX]@L:3W^J3^IE<gQ0@&WfR=eg3;;[Nb^S_6JG5.G>_#(Z^3C=f?aB>HLI
V-R^FQ#/W5W;.KeVW5^9[.dN?Wa5K_+4T9TJ+)2S.@7@;]LgG_&-K?e/9,DE^:K)
fI5>1..cQ=G12@04;#fgJKL1>HE)T<84FYVeORP-8Zc@/=IHCA9UQPHH/[LK/8a\
R\51N3Gb2-e4C)e#@C8a>SX9NJV-gAd75(G?U)RQWI0._#ObBa&cU_,&L1,KT9<S
,_/M\Y0CLUe^g2Y0[Q3^YYR=W2N)O2g.Ga5A_USO8<dV;L-D6.X_X&e-[9<<=KTE
:KH&NG]cJB;:H/K3BbgLNP7X&a:I6LAEb-I9ILNRS?E-Y>^:+5<d>-N#4/SEVbQ2
]X&RT0J[+,2U3?bRZ.+^X\^+1S[]4ScE4)U797N[C1/)KR9fbIW85.[OA43<>U+\
80cG/WT[V;IH>(/U\^P[g0IIL<)46LT=SE_V<6;FGUA=1:0T+SUc#e9DaX#fAV/S
L?AM=b9+.A<c<C6I6<CWD^aXQ.YC>=dN36Tbbb.2@(#cM\TMW;)aE;O85H[VPGM_
D&2f]4c996HDWY36:^<<U>[@E\/<^ag&9_\WSW3T.:),I(Fc=<f#S6R)B>T[T].G
4cOg;3\.M<^<Q?aZ_1b.352^7SCC&L=X[X,Q=G0ZY1YJ2UPKA1C9LVLC)Da8-RR]
7)02A\6N5e@X_Q/_K5gT\DF:0X-2b(AfC?E+GBB&OR#WA)-Y6<a:<;SG6:PF5YCb
36OfX[06<@Y7=A]5:@cT3NR/6Md[g&MM/?KC-VHY)X(@Q7e,R=gT/HN6\DZMZAIO
H):?_8\dff>#bNM5F6(,ARQR)-Ud(:7P:/EC6;NE#dH6E9[KA35;(\V7-3A^K0,2
d9MX&L^2+/4:c^P6+R?\.O#BJI#-cNPc(UU:HT_R4F#/#4L.W2@^gNMb8R:B&>D)
gE(gO>UU=,^SD-]OLHFMRBQ+KF2>KJ?,afQ(3^#QCYT)8Nf12d1+ZEJG]3F_>T59
=[?\C-NOII39e?C0=aLE(Oa2J#)2De_.JTH\Y/;X<W,:#XOVYXH-:)g_7>.S24O3
3,P&UT51(Q+5O[M#Sg]]6SYKVOb[#d-//F9@?2Db:Q2OTJU;d>=,NA/HMCW,FX/#
HV42IS57O-9K^eYB+Qcd-FM7>L>>beYMKVF+\.^RdMQRbaW4.)+1X,^:A6/f>KVe
&?fgJ<4E5QfEG3S5K0ZJ#3[=PRI]dXL=PBTF+USQ=LA=dE(4&C/Wf5Qca,dN8?Le
Se/4J&c7J#\LO#GX?E/<)f_5]B3[V1R(:a-)VIS[cC(T23E2TIJ&H<T@0&B1L;5&
]P)c?>/R)39?d;(-9I2S,V^Cg>([(Q<K#.26CfBU(O(,FA3UY+>?9#3V?N6S&T?Q
4=f9[+XGI;0gD,_3Lc/1-+>bc5]4H46-J_BS)UgRZ+,3:@d-/<;<C[X6-^=#V[da
<2>L@/2VT,H&04,B&)-\8\47[.3Q8BHIPO?NU_ZI59.7@GfC-7b=&P:N3)fIEXWX
cY(&c#7I\QTaD06dL=UF8c)3H3#H2f],;CIL7&77X98bK+LZSNIG/=FEBSV0:0<E
:)=Y+X_A;bRcHHH[AM=HeP)V>2#8^eUW###9#95d>dbO?6)QIM6CR:Ld].G-T<O:
/FF/CaA<fQ4(<fK]/UbRF7e7W/(A/b:D6YDcL,2-,\.HeOXQ?gYNcK6_Td6S[JTN
><4Y>[CPgES0f;.A2)P8aMM1S9TA&?+PSN>D\A7Rb9ZB>4#]:5bfZ/Gf5K-/V1cg
;=)&2V=0O0I]L+^/f)N6bV?HGP?XRJIc,@HXOWdZ._X2E+SA+&,9]2HR;]dT8>H<
M0TY-gXDBcPc^E:DZ;)c2]1bGY4\G8?KXB5@U6c+F5]UbA-^SG-]N&TZ>TQbd,d]
KMS,[e?M5K/SJE>-.C)(?8/Pb73PfZ<+3W@2Y@83@d<WBV#,BQ/<61H+8LWIJ-gM
8fMRB00X4fJQH29#_;(a?YLEgM?cf#(b4Q:9ZCa<>8E58CHFC9?7fFH+J$
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
,U1JP52N@1XB8+DC(&ZI9KW09Y;e,.A3-8Ce,2a^@\[-77gY7(KY)g@a=S,8)VH5
d1BZQGS^D5?\DdWW3eEDd1:6>3=TJ@JQ(5(9TfZFc+U6[F[Qg?0?N0+Ce4gU><TV
Y=SbEMgD@c^14R@dXX(\WVHe[+B8dV]SHR1V7^H0:X1SF04c]9UWOD4S27(\/0BQ
NbU8JYUa2IP@@UfPbg1-)b/H107GDFHH)F85B68:+>GL&J]eg&(=[f^5;>?QA=-G
(PQ+C>#dd+_0&[-5DKS;<Df+6AX.PG2T>K.1XRY-X>?I<I34RM/OJ/O1X>8\>V[b
BH[Za:D?bJV\53Of\KTZdGXI1Q_Tee(L5YP[I<&ZQ<:T,?>LebC7F3?(V9E]a2F^
.9S=7f^b4(:6e_A1S@N4SJMU;1(BPM7_F,1_Dg<[1.S7RNMC:&]b8b3JFPTKg_KK
[41VX=RZ5TE,\C=b@0f4VR3H9DDgA8N64NA[[)bJfZPV?H(cbS5DG&]RW0RA\4M5
/2K?ZVaT+F.f7.]Q&/c(Q&B_N@,6\;f]&J&#?#XH02LAPKVbL+_IbDe5[a;S08Tb
))Vc?LO#Kc^:fA/>DAY+YQ9LW?5=;YXQ+^ddUaQEKW)9IV]DVB,Q^E#UVE0,ZF#)
W?_D1#)XdGG:6Xf@8\BH)@.XdWfQTI2&>;+)13a@(OOB][814>SE[UENNU-BH9V6
7GTU2=@K.EJQ7:&K)KC6<E]VOcL^(<NfDO.9#I.)b9DMOU3eS=/4MZ=#)Kb,V390
K1SV&I(F[^.<GPaBORf]If#>:NGGc:_bU,\SA05(0T>>Y^J73QS)f_Y7>Y>U5A+L
VNQJDX0DPDe<-<X:/4>6Sc@6b2(5(M,F8M]K&D8&d9=e4bA=g9MWOOD3dU[,J8)T
CM@2fe3=^?5>N9d>2>?_[>ONBU/ZLY#\O6?XM]UcA6,=/0<(O7@[N-2M2g3UbLI3
0+89[6JZ&0+O6@FPIa24b&X/\]0F;FNMW]4,SE_\5?OX&Ab/Y41M;F#Ad\AT@-^I
5c(GMQRLG_+HeV,c=1,8870U]EK@0(@P#DVf(Ka[IbNbL54VA_HK1K4G<(6=g)0e
XC@Q&#1d@AgI&4<QNgN-LG?d<65/8VQAN/,JGPLDZ>KUWD3da5U>@?LZ-1@8VYNU
8WX-UY;5F2Ze\]4T^/PFCFI82cNQ^JXbTgQIKCJ]FJ6Z&af8_2Y8?@0Ogf[M&===
<XI.FB(TL&6-A4aWNY=,f@YN7-ETVW[GI2(<d-[&bC=g)TCDCLEdc9DbN\A12A\K
6S6KHTSTeac8\<3AcFNX.,C(FS7d50a1Xg=[3&TO=#1NN9C1MB+Z4,6.OC_abK\+
2M^Hf.AC([5O,C[[/E;bBfDT&6_EEI@,&#C;G(b(P>,Z&;F,_.60;\U?XcfY:X/A
FBF\5@?]/3GA/Q\eKcYJ(\RWE),][M?DVKaUZTH2a,U-@JH)&R>+>eAW/aT>[6&^
TJg:L5[=+WU2O=b/PHL9C\gZ\W9;;LY97-7@E(Y;F18ODO9&#8QO?>7g8KeIR4=N
:F3a]PYZ)700LW;P91/5Z2dR&K60^f;_CS@LU0\aP,T]<L);J/T(KC3c3@1YgE1V
S2/E4BQPY+_KQ19c#2EFZ:IIZS(e:^TTTS?P&cX@26EMgJEB),\+T\<_5^(3Jb^V
&F62+JFV3G(=gH\.FRK32RKYO_U038=?5^HKF7F^0XPURdA1]/>&cL3Cd;M8W+a:
.bea;a.=++<1YgP@9NM.H1TT:/?ag-gYYH5K;29QHVRZ.E2:@IW2dBD0K?CEW[\I
<YGU5e+RRV29&FE,^>_?>,3-QLZTWSY17dI27d2XDJBGV+B+#.K-g3[DJ/UAa1<]
]#1_B[XU8[ag#9F.f5N;P0M#Ea56A,g5,bFBDQFSK;KD2^-\8)N38EDLA7gPZgP3
6g_BfDHXWdZ8g0IZ0I[1gS(^#(.?F6JU5Nd_H6N45.#-6S[7E/P)5\JAU,IZ@Ae1
Ra=4@46-Z?5Y.3K=M\1Z+@ZC(R9F&\L&4+L.ZANFS-2N8?6>C/SZ=BN;Qe?.B30=
2dA(+>(<cY7D>aU9.#)P\MBYP\/#=fPJ.5@3G8Q<QW:]J;MNdKC\O>#ZZO?+>AcQ
RD[Qg^a#U^NKKVH/=g8><+ZJ8]&bBK]:BJHY27-L3IO,Qc/-[.,PUAY+0VKa^.A,
XDZ,XfJ]RbgF?;@()dU_fVUI<LgV;afRg?S5951ZAeZc.EKcPd7eEVb:E(RdE7We
9+:V^JUdR7\F0$
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
