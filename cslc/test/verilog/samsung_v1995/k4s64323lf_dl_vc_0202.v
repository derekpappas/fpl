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
[/0S32cDX8-9=5E=8V-4)g@2,@/9)G#,<N1]I(Ld:CDXCc+5N48c9F)Z8\gV-40N
cMUH)a]_UVaB(Kgd&YF29Z=c+;6)H4QFJ7\gWPFL&6,0X_@8Y;]P@)LDJO<8#MSE
UJ/ee8,B6ZcXSZ\1Q8=?eNUdU#fX5fCWC<PgL,GENV.b^\&@CgEWd-3c@f(1<=?3
9b5[bcYc6c_.c_KY?LWg7Y,F&+\EKLSGO,I4<QA8JJ13^1GQP,NF>Y/2?aXP\C.d
SX&eW=3-GUV_PD3.^8:_?Z</P90cHeC<8a:a5IeS=SHW8d/,AeZG7?67UF[]4]?Q
T9>-HdQ(g@P<6U,@2_HM)NQ/<MROVV=d.(e2?f1=.g-KeY0,a_aZ9dg:>O>TRMfB
<M-+9\OD6TOeb9M#c@0O\R2Wd\VW.[,^.U\U+VSU]UM[[28@C^^V(\Cg<-L2]?)7
3?EFPIU7H-N@NXO>1#HMA>O+@;29)U0-8:;<YPA1,HIR^a89.(_RM/#_&;(ZD=QW
>E_^7aH3C8IN_WX[3V&@=>agA2?EKHKSE^Te4:<HA4ER2;ZI-I-(?+:a^X@7OT&c
2ae2(2F<bY3M)GV=60dI-?bI;3C0P=(S3O\0GQR+^VXaPW,:fA]71#492D<M?<B0
b(D3]S+##^OSO4a>S=PVX+fYH_C>XME93Ydg.:NH9-Y:N/Y=Rca]X,VB,T[32g(B
f:>bD=@G;I2#K[MbU.FOK^g^8JTTI1Z^[N2ZWQ)RUE:WMZ/IPSb&J=K<K<Sf=/I-
HB,g1##&eHNTV=:\9E:8WCcW@0?T=&@#D:PX^+NS(b91,?6@&g17XFSQI+QBH1dI
(3^7fY;[Ug7TY-Id:DDg\[5aUa..LU[8?]&D:Q;TA)9Ae->YbfbONfE633H@46,&
aY3=:1>QX4ZRZ0UM1AMQMK<e?LKR.,e3V7QFfEb\S3:YW8DFN-_:+JILc3aV-M:_
5O.Gf,]:0,58)c;\VfcCLY;[2g#UcX]3+LXCC:g?I39)F/;2g6=D1K(2?g^9dJEY
\00YSO2e7Sfd;TXFZHK_aEI@&.5La03&a3)GJVD#USU[L^gF45I]EYDJ7de,45fE
W(LM1\@2NJbFEEW65dX(T(TAAK6S;&V5XLE4)?FVCJ_e-a;\T\5KM(<I/\REKYZ,
_YRbEaag9/L));.R,-H5V72<OdOI@@Ng4C:P6U&D@AT5T^^.\03Q^EcKL^HaLd)\
Pd2Fb)QG8UJB5GYMBLP16?e.;5_@_9R31d#V)9T6515B;)NgU7H2.AN7D?B4,3L7
G.9NXI;?2gUM]XQL()HJEIL_bL-9TF#325Q)6ZH4ed8Yf42a.Dd3[HgXTB&3EN0U
47U,.UJ\8+_JS];3]+F\F6RN,2PI7^X/&WMPG7#KS0PF3THKSJeIV1@PWc9BY@f[
:)<MYO<5G_OEK?3?RBTEMR>])/<Q5A3TUHEDR0;2&LfCE7#VQ/S3UU:J+V8^IJA2
XH3,:6M6G^MYDJH2TQZ@7g2J(eGQ#N42OR,[b/TVGJ2V07H(6V<Yg#RcAKOgbfa=
L).0<D43:(/;WUQf.7EH;O?.D1]9>a5L#>]5#):AC#(BZB/-d^LR;,,X;BA&L,,E
a??B;dCMAEF0(7\<<<J:5.EIDGR&.<@20#2SO6-QXOTd67M2/6Z6d5HeBSJ1Q[cZ
SLQgc#)._X8]\,Ia4ef)-++9<E;2757/G\5?d&QE-J.\.;QOE-B>T#>FS[I/PX?P
R9ab<-;PRGg-NfUWd5-6]cXOC+8?DXJg+I9V-d)cX7ZgVNYPFPKa7G@cc>@(-K<X
K3aKO_0:Q0K=WN;FO+ObP\&\O_;VH\dDJ64F=S(>=#be?=P,KD)WBB/W<OD]Be/M
4UcZ@KG/N:@J&34O/@C/A<5Z7bLI-?^:?$
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
B?QL/\_a).2&8K>d<3#b-c+4-;52-L2X9AcN9;]&;XM?]3])UKbL<TY<-Qd9)K[O
K8A@+SC@J6/DFN8<X.,eXaT0W8gUZI:_C<2-IP[d?W=YTYee]M8D3:.GE&MYUaRa
c1+&^/A4<PB4]^gg_eZR-#81G-^L+BI/.0[RWad:93=FL1VDR.94LUO5W(I:R&>G
#U^dK),9+G[7BOQ]9b>[<U0S5<Z,790>I9<<[QALTB<2LK::(&+RYBUL4V=\\S\K
_(0-\H97;P@^aDgNZ9\[_H,Q?20eU3,.<B3/XKYV+JT\CUGA;D=:767MSYBeEVN]
=NK\)O&IAa[O]0Z5eb02LVAU@>A8LSI2)@VF_+9;@<NK^B8eeV@_?VO0_@>E54<I
+2UVP^9c?QJ&^=QT#U\PZGFG9K_]8-dg6:<4dN0:C(477@/?V2X)7U(165S2837_
#NNaPaJ^33dE.P3.<89SG9G/W4+fYFY0<77RJ<QL0DE5WFQWD?c?#6K63<VQ5VC^
63B;),YdNa;TVUdC#=-<3K=fP?LdE+I?\VSS73eFHXe3/C2a)d_.I<1NT&BG@&R\
>c<F6B\EO+?(,C6J_L-,2FN(?=>ZSIBXbG,;(FD]X,g\.Q0FJbf6U\E^CgPE?/+_
O\\/=0f?;a+M>/#)7:D,dL6)</N?M8.EL&CX:Rb:AEN/M9Rdb=JSP]\6BU&/L1cO
,_YVU@?[0Y7T:f<D]Qa:,a5CK,BSKHg/gEKS&WGgZe@2@\T3AAK-AUbV@&8+WE08
S+U.92OW-K3PLT]EU28#EBTV.GHYK_(+8-W<@(/,IH@1&REH=J<dT;62_B+\]C+P
3^F6ed,J=#E,IE2D2g&UD;@73O:CJ,7((IG[6D-Jg6IJBY72.BM;(:aY2+/8VU-@
N2V_7-;fY&a32e6X]HW=W1\UAdE>e4^F=AH&74dLQFf@<]ZKcRNe2@6V.M)UDRET
NBEKE-]GcD44O0>>EO?b((bOI+]+?])&:f+F<b;<8OU2&98R6OT/?1ZXE^,fBP@A
4LGG2W);d296A#LOa];af-P)TfGXLbD^+51?aa4^\)>[);g&Q/^3DA_Od3K,<@R9
.H[b-g@SXN.^4W6a/0)J#U0OF;K&.&KQ)G.W;=EgT]MUW:[@GGNAf)Xg6f#TLIE@
_[+H0B.#.G-Oc)RdG]Sd7.#8N^H&&/#D_Db]TKcfC5MO-D8f.W<[9a#DJdd=^0b+
S;N8N\ST@?AfaRA3S[G;:eaWS982CL7K;@e]Y[J-g0?X1SE[8(f;[JZgWR,aL)K#
A?SSZ4KQ8(aHTBd-:^c5T[g[N7&g7;/F8#CQ@[TFDbQeRdeOYf=(TQ+2;#OJNG=8
16/HW9fe<e5gV7U;_I\JEC?<HH]V9.7+=?#X//0dgaSCa0Y.,GIT4@X0E;&fF<65
.-S/5+J9P2EHaaFBA1P_?;gNZVID?9UOaffLHd9T#bXIZ:)O#&J<\AR9P/4TA2B(
<;+LY<+9e[[&5P=gfB4B5-55+,9QG7QAO>#5fHBGPeA;JM.[&6^#U6M>F^/0Pe5D
PR6I>DRALSF5SNb^>7CMBSFN4TFI715HRfaeS08=&&?/aRP?<=DP_Eg5@?ZCcIFK
,:1\PGWBCRZO7E9<;Q01Kf8LgT8@GB4HLI22[5Y^&WSVQYY+aO7(2B^fZS8.#JC_
?J871F\;P2K;I1^XGT,#>QTgF:.W7.c(ED6O#bTYD^[M8_,>0=3@5YcSZRJ\2?3P
ddCMe1HB/6+c8RPWbR)ZAb9Dc-6=2OEc:g:AOYZ-XYFNcaG)=BPP/_1UVfJQCVK0
,dP>Jb=1MY1BK:QP3>@3T3]Of7dRWP<X)TXJ^BTf>3,_Q_.>7-#.&<SacF>?\FM>
9CQ-9=+YS,bIV.[;F#8UD9ATdEN9H\,\6.KJMFXcCJGfVFcX6F26S^F;R\/T=+TT
5A24JbS)2Q\KaP<Za\^(>FYWaH1X&BUFLW>-Zg,AQaJ(UA/J8+?BI/#H-Nc3VP2]
#L<5-YF:1U3R,#Z0<b/UPaRH:(0(EOf^aaf.2gPFJ_SN4G,)TTY^V^_#_M)XbD01
3ZZ6Y>^:2^7dC.]Be9XXL&F,>0DIYVdRMAbP66SH1CLI6Z8D1<6f+0V9CL-PCYJL
bYOg>NR-KD,T,X/2JABHQXR7B^/\TC_5f)BP<a>O7+Me;H_/JIbb41;[f;9&P7d:
d&;=M8IY9dESRZf^_,WD8V<OG2-)T,b<cEJJZ?V+GZ+<^N47OF0Gc_7[7Rb)EAFU
7KD#WZ^f]GX((GL_IY.QIWacP]\3Q^MH2;HHR:Re::/eeIVN0C=cB0c;[WW/a#RM
M>DKY<TT1F?,<E7^?O<TUG\0;+0H5@8DZ5@;.OGV1,?5T.D_O>_4:FM<^Q00RL1#
8@]eCD0>73803^@1T.c-@8(L:8c8?cae,\B9AR[=F@d<G0^3A)&JN:3P.L_&)V(=
Ca)[.2JXR1fAQWdE+<X<DOeC7c5Qc4JS5EDeKHPf^d/EKHBT8H,E-BU>#F7+(2E.
D3;GNJS?_:#<eTVB7eM<S>0K?13E\+/2/>A#C41NJYE#IC(?-Vd5G7Q[d+J(4AZ#
=f<@Z0Y8,\OCPRJ:JZ?Y0UFGSEfY.&CP[aUc0fd\e29@@(@NRANBDR=PZB:/]Nb)
WOLZ2^UeU62RB+=+b5UX[XLC]0U(XZ=c,ZEIO7@6+3:L>_V(a1W0,_WIFGX[^RZR
0V3LdC&3[W8)S5N;aXSTb^:3FZU&M08S;OD2ZC7a::.LWQQMD]3+U/eU@)KMVfJ-
QX.,#^#S:R:84d(CQ0OYL&Q[T/Ae:dX1aREYZ,X7586ba?aOIH6?f+VfPeA5B04W
S>][MS++Q\8IX3NeN-aE(0==#MLXf#QTdbd]O=H5URbB.=)X.]YF.N1^:-:U1U)_
]aIa/ec9^S3_)-c3_7Wg-b1?J[Y[99b.M(O4eSbY2[[6XD?M&=WG.A_)2AI.7X#U
):Y\YE26675_0$
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
S/<WIFMf)JIQ<U:e<F^,=Lf&8+B59GBE8cGW(BPRF5MEAJ;VKZ;Z=7Y0(E+Z(\:C
&VfN&6HI1)\<V55LE7?ZUV8IS(]D&C-X@QA^,8=(ObN:Hf:Td4e9g:RaIQEBBNU?
[1H;c0ZZ^W^W_4YQ9CHL</Cg\gWV2_Uf36UCF_AMY6+].;D?N#ZS];b>,A]Q\4LO
A)WSKC(UENbGL<VCDgRZYU<^+_^FLgS,@3.)A5@Ba<^=Xca1F#YO@>[I<0:8e8b2
g69O1:+D)?g6)5TADFPMMDe0A)I_>2F:-N+=J4QGS6JcK-eB]V5L_cC&54Q0[G9d
CU)XaAHW;O2\-/FKQGD1d93D]U@8d:589cU.QG.5QFE&b@GHJ7\=0g#(#M#,dNH2
5)N[H=\&QgT);OJ;V<^&BAQgY-[]MedS+La)gZF<_c10-6R^9C\<H:09D;FCL2(/
4e1@FH+1CdMA[ada&+3=Y,9DY0QJ3<=cfVMI2ea-cLc^QA=@]DDfb--.>H+.QQ&>
P[a0=)=10:gWQ@;3XEbE#;2e[JF2W(C)7[?T_+=;>f1H)E5H;_;F?F;Q(#Q<IIHX
1ONKY;IbG\SN(J.UCSP/:ED_<@abXM,4A4aWA6L32^&#_5=\4Y9_3(A]\S;XKUg<
VRVQW;FIBHYMVJB_5MO/\dD154[WO1U)M1X3C5\e,KN0S@dK^27I80)721A\,YYC
F\S\,9F1cAO(;@(Q)8:\dJ;1:YYED7>dH3;@dU4,(eV>))W279#,b3GCJQE?\bX<
K>2gRaKaQ(_8?e\[]S91Ob2M<3H#BBc(^DXDVMD&#c_W]&g)+W])B-0A7b4(=7ML
&a9[7:gYTF3?>W8cP<cU&d&,^8H,.6,5f>\gVP:\9&c\FP=O7DO]g(X02\P02BG3
:STYX,E2PJ=E6P=X4AV@Ya3^J#72E&Bc75eJH121DaXTA)E:VVPS\Q+<>c-]fF]R
]La1F_Q/La>68C&:GR8efD,R&P?#>1A\6DNa^W]NT4FG8@#8fC4R64]^4OG571I+
Qg7bFS:QdcEQ:G2b&_2,cI4?KBLK>3,:/2:E[,S9OY6:&7,(=eK6C(7FON^LL<;<
J9+Y]L?R7QR,B1eQLU]?=dF2W33VCdD=5F-.[XdeBS\3J-UFa)4@5a:V^cMW#EJB
9Q/F<_L@J^&(80JDT^H2ZEO?N5c?Y11e)885I_:G;(0^NF^1C4:>2b7Oc_?VT2RZ
d]JdJI(17\I..N(?64FOBKZ_XU)B1CXIc=>\Y;8=CcTA>EG[O8UVG]SPg0a5/-^[
7(MJE&:c8>-=&Z)f@=;4Z)^GPd.[)W3egVL=LBA1Z=C(OD^VEQ2<>8[g.cOG,NA)
f.GbM6X\6V)UR9)E@DRKUN1(0>R>:]Q#-[O:@9c#L4ME3LC/,6GdWcdT_TBRV.g7
AM&?AFZQ]0Ue<-OH6J>CCDCeX]T[cR1,ff/\gcS?&^Ug>R0L7A1UbAUKb823c.3g
X3^S[#Y-b0g&[IL8]:FEKa1a>CNZU<e81YIPN8?+>>-0NAE[ENf,PR[e87O;d;+U
WP=E[De0SBYbI9T&e_b-FV&W<6..dX:?Ie79^fFc16.6a<g5Nc5gGd2>K?P9fc-[
F\CA?eb.2X49ZVFQa_I-O=1NH0Fg&[T6]BPf0Kg_eBTCCcUJSXSRKL?GPX8fL<@C
]FAGNgL>_:e&G:>&;c?-=P69:2H,0+N]K./f+f-3H?a/[VF5Sd8HJ@XMACDX\Fg+
3g_^8;Af4g\aO)&[;da,FVW@)9;^M-)X:SL,.TNXNPFQKP\#&F;dGK,M^ee,Na;/
a_f#_C1aN5SNWH_[\X:[>9a72A=;(W;(V5]aXYR]^(:JNHB(78E(G9@L00K8RScT
bE]4L.fgV2K1b7.B,(ZB:7I@A<,1XQC@]S=NNLFaY/a#NXH,D:E(U-d[Bc?9;O.d
b9B=ZSVDafd\B1:SNA8EIVc15.dF@^K1T=OFMH6QH^F2\\4fNC[A1JB#DO0G=L0?
>1-(7?F;bZeM\]?4AL4RPIGQ7C5ZNG=4JDS\2@/+VRcJa<_fJ7]Q.Dc><KNbM4#J
aC=7.R.56[EH5]@;NG4FU4g8>fF@Ef9SO,KKe=1)Vcg\I88Q]:9VNfT/(dWAg-c3
EC1DQ5Z2FU.f0<a7<<SeS0@3CDJ;M.++=G-c/J]HR_]b^,PgXMWf4L1b\c2/SW1G
1Z4FD98:CM60BHVCY96DTVReWGDW\LKT=9J3FG1@U2IZS+S(+gKX;B4&OY1c,Ude
I[PCc3GI3:^45GU5fY__bTg.VKLPYGJKI50BFD4eB(5<PXHbQF+-OOC>Ne;4SS[Q
gW4+5\2cAW;ddg5ZXgH>T8gXF84PeR?QbU6Z=+^.FVZ9DA,),Ccb3AH3,ZWZdHYC
+JIeI7eaF=N3a@WdD/QE,T/^ec4M=V2-20IUHAXGK.EPOF_N]-L()JRT1>VF,H7>
0BgH?(YXGRTC+G;#L3FVYZ0C7RFI]?]bRQ:D3Rf=VHT<fEM,9+].^3TJ[,Ze-a4b
Xd;,^0(EgER6e74N0EL&#8J)gF6/3faEW.Qaf&:FV8;(UW7OVP=R+3IYg)A,K.X&
;.>]PZD^Z<F0g#f0Y[aSg<>F?=BF89W=T5-7e=?]#I=_Sefe8-cDW3XVf7bc/+./
@Q:?YJc@<LFIEXbMgHf>&c<a-B6<L]gE>),^<c,.+=Rd3V>bP6=cOA(NBJ2G@,a<
M9R&ZHPI4)S4A>..R:O#QV)UaLX,W>-QR50Z.X.c,5g1&:Bf<9>26(?Z/^BC>)]M
>QW?-?&RG0E1QX4(E\,1QR)Q^&_@IGES0^7O_TK)Ne#+8f;7#@(NGURXEd^PIK3H
9D7LL.1Wb.b2>VZ_E?17-c#V=5AJV[Y&]gE>;9Q5a<Kb>[?6d;Q7Vb@bTIFLFI]2
,#EA[cS@XO(7A_=7<Ke,Lb,JdMaS_OK2=V5+9>9\]:ZXQBDW/;6gdUJBe[F5DUFC
,[aH@FIS##XYE7I-IN0-;#\U@D_Q.dfD00,@)Y+R\(M+:W?&+K/YA8bb#ReBF^ZN
>)?f>4Ic@/;Q8]Y3UIX<-DXA=I;<&9OCbWYMDY=_UGN=?Q4VfE5+c4,.f.97X]TZ
L7KIcZ(MIY51\=_SZO8f3__7g[\eg_\Y9H9T;:)38Pa[OB1Q>7ggUgG4J;W96]HI
#9#+\YONGG:H&9Y0Id+R_C\#Rgee[He>ZaHNe()5,O;D9]DH:G7M3]-UZaV;;)Fe
C\^RWaS:[FaT4a83Wc/K#[174c;_@8E\-(9Cfb5:R0-<_7:FAX6ZG4-F(=gA1.Q?
/e,A6Z90Q]OUPZO50DfV6\A+P8ca29W8F/]>(5L<UYT8@@FXP\.&Q(aZK0A\f&/1
75[-[YITLB,L3a3#0H8T=W\NY(:6TgbW/0_GE_(;^YaJ2Ug+3T3>N1WU>eC><_3Y
.3K_\6:g/9VWI<A<2:S?QG-=e=B04O+]JS6_JDM0_RWX1P\__A80IJT9bKN]#f_3
c[&WK>U6?9)ZP_/9PCeS7bG-0?BERAW]MN@/5T#f2[0>J]a+OY8We8ERRTEJL-WO
-ab#f[8CG,8-;]F</133?P87J\d9WEO3]WB9N@?,T,YMQV9W(]&)C1BIQO.U9&7,
Fe<A1PX&9efSaX0&0N=b8IWaQ1#Z[1K0_cbQbL].TI=N,J=\[CDO>:BWIS:&B7P6
X8BR]b>2,E,M1Z(6\?fUW],?GH/>&)bR)PX)-fS2XS<LP0>KGbHL;<bG]>>-]=a?
IKC,L3&c?DCLI4ZI0a.3+#5aH=27L>WLP?-VAC4Z<6=AO0bWP0LA@OBff\Q9Rc[9
KOJ+cKgP5=8c/L.(/KV/VM6C]@95864-@N3-4=?(\LL>3V3T,Z?.ZggVVEd9_S@+
O\MX3]NKFBDF\3[^X=R8?BL327)M^^RG,(,PMI2S9:)K9N:R#_)4[@TDN8dCdLP@
G>8W+44A6,I)#F3fcXUZaGc>-]b7AKRG69]6#F12-34M6JSfc5[>N0EA4K>BgGD^
NZ8XBSR-^A/,gP(#R8GTg8C:-f<73H=]KTMW?FZKGSCM&4S/(W:A@V,f772,^O2]
BVV@002RaGbL#21eWSHR?Z\/?NA[MBL8GG8I86S_9IHMJ3CD>5gR6;NJJHU<E^2<
D5V_aeJd@-d.8UL8=5f1EHc8+e#0a^<b]e:&e+S.QTWdJfD]1BZ2GQ/Rfg@9e4@R
/6K7^BXD?3.gW9=6WASgRc0P<YcdfAH(8,.#9G/gBd7IJ?Z<H[T@;TL@R12EF,BG
PK@Y/=/a.]1N#6P8:c@O/QPJO+9e=VVNVYWO3;fGL--<CRT..(KFT]SGS8,Sg-<0
0Dg^44Y5-d>&AVC1.R;,CJE_1AT#F79+2(^)>6W)b.XB#2SS\Z3912W(,R_bD?8#
9R;Q&R)(78)=fTX(9GW1]L73Z_KCb/W;a(d@5Z9\ee10?Y\\HPB#f(DIH(J;g<<3
NE2.]+VI(>J(MdH)+[LB[P:dWI.c:+75\8C>@TbWZA5J1H3J,;0/Q)D2>6.NE7:-
<HeK>S&G_O/Bc@BKKJG>\+CA@@,6a??C\RL3>BI](#UE^FScbF_BNP[]XNTN8Qeg
/0<JAJ[1HC_c:Nd#&d/@Y\@(CQ9YC3aJZXdS4R>)V2\g2d:.==F0)^C_5[L[8Ye)
VD<,=FWRCT^[Lde<#[NYE.HBDdG]/<<IS-+)9faKA_621FL;V@T2Y_G4e<.D-D3;
47C6YQN9ZM6^d\_=/7V+S+.+e+U;>\<O-cAabfcI[\AIU6Qg[HCAU>7O5aaRga3T
dg6-J(I>#1McL]Z?=&f5GD>6(8O\9N/X;b;LO]+6@G<U3\^+gJT[b(aHW-,0Ydb:
CO/+X=F+G2R/.0HGS/CbZe52#X-JE/OI16EC1Y(8I1Qd^WgBL0<V(2N-)<X>IDaT
ZYb)/@@EYH23aBW?H7bBb+HdRg-E4GRdaMZ2_IBDe)b;@P+b:?HXQU94TGM##fUW
R#@UGU9I9LXG1(6NaZ3@KEMG9/b5\C8f2GO3@FSZV]2<R<@SA(ABKWQ=1Z)a3Pc\
JH\\^4;WX,5fL<6H,bG9N36Zd(I>]XbRc&G0R6;/0(>aN.a<>a?eaSDb;Q\KM<9E
0E1G+S:VQ90QaTV4dTd-1==ADe1YfH^9ScJ;G<7]FZf(P6gV[;9^@&]V>b9O(4E#
MM)6?;-G.8BHDXC5O6A)?:J0BPd56YG<6WCA.=XZc[(^LPf26R#,1M1e#FE,S&,1
ZY[TS33;VLW10W6V^6b);@-WcY#,0aKf6.0E;ag<;8g0e(aNNFJ&DTQC+.14^2+Y
SJ]:a\Q4^T+@.45K;Hc=H-;\;4:3L=@A<RICV<76A^(A-;21bF;J+SNc9BZecI^V
Y&,YfC]g:S\^I?FGOJ#Fe-NSIa@WB;Ec(5VK5H9Q.^4]9M#+<dX9&TU<)D.;.G;I
CK-A=\WVNG]S1,cdb&9HB9e0E30\_S^)N8^;=1>L,B4+IAMFC0,^NL2;2DD+g\?/
YTJ=Z,TZ[<4:[/#X?2][f,dHQ>GX.Ye@?<MYNU+d2=(>N,IZUH7g57N@(#Yf:+,Y
+/W;@L_g1.N_X_6/KQG#ag;a;>6f5<c4G^5/PL#ZaU-G&(2?O9<0)SMQ+8X15YgL
Yd-K)<1V&&,PJV&=\HCYDAYFgR:0FRAf>I4_U=]O6D^Rb[4^WM&5TV&0gbR3OXgg
bWFYae>0YB>9eTcH)9P/TS=T@,dJHR9,J_K_EY<PF<+N#HDICUab;a[]//aTWK.g
;S;T=04J5O\(J4OL8M)eLQ6G_WWaEWfXRNM<.:g;2-aUDg>cSW[#,#_cC>:^D:RG
\8Q/VKRBfX[O&35<),OOK7L5R&NPG/HA6T2W+ZU0aHaQ]T<gFHg5:9K?Y<6NL\O]
759FJPD.?f?>Df^9TXWG(0b:Hd1A\cTU--)L)]8GOWKVe6+ZYGDWJ)(-8M/IDAbJ
X.:XB^-#V>@C&52KMN4Gg.T@:POBbZ#_)0F?(:TG5<J99@#Z=K[T:eFGVOA#L_CQ
]>B;K:QU.2(?cIJQL=GM#.I?Mc9VVHO@c]1.@O&2Q-C3Q;C\<NdXc]X+>g(3adaL
11gdZW4f4:X^OWg_cOLN4^+Mg#OX-N+6,=gI-=UAc,(R=1a\Z7fc,a,N7LP(_9C#
K]VP)S[TAc81+KTDC,g=/:&AV8[?\QRQAR3D#SA&><-/MFS;5,Ka,#7)AV14K/+1
=PD?P8CX8J.AWaR3IHB)-[RRM]bd4&g5Ka1X&7fE]Laa?2WB90;UE:YDMUfN)5F+
4^ASSN_\1GEGW.C^NDYX)6IYg2P>T-0F?)@5K^+IH4;a/dE[aLd53LYfAQ&8JE(K
TFJFgH@)ge::<F]c7M<>ZIL^E^/H)Ve0VX0>]ZP0XD(_gcYG0.X^A8)7:\-gP0TI
=IJNRQ]XGVbA;X^QFB_@D)efUAN1RV:R2&1-YXD:G@H)-=1gdZ5MbP)dVKfLdIH6
]-XG]1/WXL2\]75HCE[XD#Y:,ODDW+e4)5,,5DH_)V9F+#d_,.dQ#:@47C5#MU74
0A#dQ5>>0Z(^D<BcM1?1LO&CeY1S)2V^GGb51=A-Q9?_.E?NWgAF+6@B;ER/^G.^
?N?:]ZW55/0]7eEE+4Z4PZ?@U2Y^B+5ES5B_=PJZ=Qc1>HfX<AL@OJA:3/T:C21E
f>JO3KTT1f.d+J2M]U3[70,#E1gfH@-3[N682RPJKA&baRRF=f(MI65.//+NZ2])
:RZd/BgUaCRMeb4J7Wa3@,0@U0Z#4<CMJ>ZG;RAK#Y5=1^0507DQ,G<Q-c&G.g-I
.\/S4:5Q.H#[66]8/Bg1\0,-(/WCS8R3L\M?U\4<I=:7;d1a374+8(#Y]JfS#JOP
?\2;3b9J];JEEEe<]W-K@Sg8G/a3N4,N(.@c6:>B6Z1OTPLT&KM+-FQgeU9+dRf.
dKLCQM,fW)^+^1D6LaOOf?0>[<F\CTK3?CAI9I1,&S&/CO-d,)ZC-KIO2V4/c.F(
SZdPHPOg54FV#[?Y8VGSCc<CUgK/(Gc^^J2L;[XUd1+5-PHGd&A0-TIOI$
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
Ya(VR9SQec#<9(]1<U#E=M>0,H?59AW.)B/d-1K+3[f]0I2Z=U2.,KC\)=DR-Z&R
8>8UP;X9)A9?,LL<_RI;U)W[8P0fUYQ)\HgQVZGaBd0YDGfa3+SXGP-:Zb6Y2H:F
6\^_]/1XfN:1SFe;E0F)aOUJJ.>_S:\feK&0#OH<L<<9QZgQ.#+\.fI-IfbYWNg)
8:]2KY\g(]R,<4Jgf[?=:cLbfM7@:3H>cc5[FYVJR9QEZ6DGX@8+Hc_A71@2gTR_
QY:Y1O-UO>QVdX(:ZXJ(I)D1<B-B[V)d\PQ^d?Ne=a_-&ZSeWa.D4BfQ-@PYJ,.8
U_EH]G^.G@](.Ne05fe>QfgEYdBVfXLL5?acTOEZeK-S4d#-6^??/PCX95d:KT>;
@Y\N/:Qe__\9&<-CN</_Lb8S2\?PFgc_(3TWA3Q>R_H4^:\37d1Z@4@(E5=+de;,
aaDg:S)b_,\#S01_0[a>PN/=6,H\&)?R?;eFNNQ#Ya,OcA3DPQIb@Z8BH4b]U6&b
W<-:+T_EJR[BU&-B^f-ULO/22O3Uec@OMWRS5Z=4T+SR6Vb^_aY9Sf#]-=WfA,_G
.c7T==X=21V-\R(1Q95[Ya9.BTNLS,,:P6^7_5#(E#0V.AHB/[QaG1L\B/dEK0P;
E\NM\[;P3P?YY-[=b^=UIN,K?(E2U;Ag6c1ag15Ld7KYE6Y/W89eL0&6R7b3@J[b
dWbG/3d]]7dS^GZXJ0D2XX]AB[RI-L+9W[[P12WY0X2;edCdAV/U0g:(BfD?_I(?
a-GE)^2SdT8Ng=KfL0.TgI9UNAPb65OPPNL6;,aVU@?-7de^22Y2H3.VE;O=G_9\
,1HO&+,3\VD+aK.E4(\6NQ@^Y;E?:B^?A9O)G^GD@K:)IGSfS[G[#TS@Heg&TGKK
&g;KJ6.Q[#M8B0+#YN,Q2(a,__(?-XTDH/_K0L<2g]PJ>cXAU2:MGHG+=8=R^(F(
cbcTY?c3a]SIV9B2PAgDB&,2\:4Cg#\LB0g^Q.]c6[0Bb@G6KV42OK1>C1eT?DK^
>?,;49XD/@PRaG7OaE.+f\G9:,==ReQAEY7A18-0fW_,0XT<B/JOL#9-B?^fW#g)
G[\#YT;)Kf2&S#W)N/1[Eg[5P+0-W<+<H(MT3(eX@\[K^7L)\#TBWf@_[4\EXZ&N
,?XY2ZD2\0^FDdHL__g_Ca58=L2^?X7Z0HS)^ZXeaR_YR2D^SL.Cc3[E1J&D9?77
M8-C,a+CQB8NVg]X11LQHBPI4=HP-MJO/L+M4_AG<J:YAe;H6BNY&Y3^K26:.d7T
L5c36;IT_;UcS5,IXS_L>Y2B<+>^f^.(BTDJO+S6LMP?^Ba5]R3B9a8<>FGc@fDU
J/F+[JY:Q+dF4<_RXE9AH?4H^GB-X>==<4WFb7<=Sc1a/(RQI)Id44K.^>JTeBe#
>RN;gea;Z2=KXFLeR[B6,0#d<<XZ8?6N;])K_-+03:@UeBH<2cN&[5I6XbA7:.<#
#M9NY+CA(X6@6a^R_]ZbYHGT[a7F3:M/dTHNfDfOEH166@XK#c;?(RRbMRf\+^Nc
egc2LX7+Q=B<\dST265PP?O2_6L]]NO5c2]Ke0=RKM2f?K,1c-H0\-EY&R/R:aM.
=&,2<KU.cYWRGdH98/0,8I6?^23>AH5b[NYXCcG:416KO&BN0gQIQHgAfIL4Q^UU
)YJB\@TfVgXab=1G5KbCUXE@b1JB_OW4bVBX/;;:O(cUOV(Z=9OF:cf1KJNTB9E>
BAI>VaU>Y(a1WAf62^AE^Sg&91X[?AebJ;eY4C],4EGAH9c3(C^eMD3TcN9ef^ZQ
J0WPUQ#6UV7P8(XCY^ZDUc]6dACAZ3Y7/aNcRQTA^HI=RL834Fa#782eL_)e\F4G
Y([THQ#ULP.eR7=1V5?+F2UI8LU>e=3V&@U^)MJ;f^8&((3BZ32egLSdK4)g/R]\
I>XHJ#aI1_;,V@E9fRE[Uf;[],-c-DDW2d6FaAVA3H?TX_&CG<^C>?]?[UBE?^\R
>fW[-=#NT/:_>DF^N[P+aBFG#9.>aW=MB\#GL^?J_#2/^@D>^?#.,Jc7OZ-_2THR
&Z[AgG_49WXCg9#2,e?>U8C86GeXX>V=3:\E-aD)cbG0W^8gIY)DOK4]RZD#e<KI
+-U]^(G4Z;R>eH6XHa(T)?Z/;1-eLFfNEPB,NbH5Q\UT@HG4.A9[YBAO[=1A7P;T
3=B(XfTQ:SNQ8]3_W/E:9Q[59@024DBNOL3;7PYW4fZeP6G>6TXF67+,&3f9E=FX
C]O76?-(H=<JH[R):/TAKC5X6[-9DecDY&P\4CP&f:W+&GQ+Mcd#.2<7X:)WHCf8
+-5U1#5-6Q<Ica1,;CF4F[[\S-)R1gL?Id:T)PGM,;f)DRb<3-42KIX+cV\NaI8=
4L/F27C70N1G&B&DU]&1Ja)9P)UC^_<;S=bKSEZ,9E4JZG/7+?YbR?d4N=EI//X^
f7\D4b85&QA)9-2:U<Jc_+A1dPVRIHJ,EQTd87HY4V4YJ_1EI:MHF)1\.CH1EaB]
F:gfH[Ae[5g0AJ:/5F54YH7WVSTPB(g#+[)9P.<dD>_JQS#V:T<:,?2c3,_D-8._
H3FIS(K^--4Q^B+.ZL,)6G-cD4e+Q6[(ALJB>J(Y,SOWOO;69+c=U2SAcRgP^_Mb
74,Z8F/BKf?f3\6#<Z<O<=U&[f^?.fbg_ELZ)EK3KG:cd=Y/M)4@b^.P)4b0PWQ&
GVe;@KFRSGEc@0]IIPK=O7(=?^C7FPfcN\U392JCXRTRQE;1A,YRC4PA/&5^KR7E
-L?aITB9@6K[D)Gd#N1WTQfQ5bAT@;,MEA>Z;TD)T6UNOS(J+>J;b4V:K]4caXS1
P6HXZ,<6HgW@@I\K#\Q_0H^T5<@ZEdF]@;D9Z#XaMV_]?#C4S5^6K,[7=&&VE?5>
(ag0UFN:?aMU>6gCZWIHb/-+X3(f77.K=MFQ7Lc@CNgGgIUZEL/K>3]Q?]7@8Yf1
TQ(OQGFgYIF#We65d3_HJ[#>@[/PIV32bR+E4>O@B+YH-3)?-CdgI0)DTafZ>.7A
)E10_R66U>2gK.XVOf;=?G\=-NPfTd(K:S5R?)6Oe>.Wf:H4+Af38_Z.0UW)2fdF
1gSVg-g]U:MD3&aBYN/UL35,VUaYETaa9K:_RG3>+#gW90QRJG#XX-Z.P$
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
=[CFa5]WQQ<c<LW58:P69gAK,+FT),e#9EW^H(=bBNLZ>;Qb=MfE(&=:8&R2,J:\
2d1eB3caEV7\3\HFX\B#^9U1IVV-Ye<Vg@(Vd1TG7M)(^VYY>@cDL?5#+Xdd-b@\
,6Zc?J#>E)1ZafcQP[Z)I?62Z67-H^SIgG]_,gCH/QVNKCU\<&2T5G2LY@0g9Od/
\SOL^7X>B?Q#_DM@_VQNJ.9.BTTG)aK:)Q(YU(@X9J#J(bZZ;F?J+=SYAC6\,DKQ
^WN86@OHGeb5c==0Q.I?FIF>KN^c34LD]#f:bMYbC@aLBX9c?IH;8GF9_VQb8Q2Y
+7RXMc1(A.Y]f=Fc9/\^7<6,N56TX)e<>SV>\f0e.B](2AHfUZe8G=fIWP#KI0.X
XA2YgQ]/?&N8O=?a&a].TCPQbfS+\5DE6B8+@Q#^U.9K6\QBK6E1N0IZFYFKP1g#
9?a=WbBK>M6\(<^,]M9SJgPAe\HWF]Q)X#&A+b+c3)6N;[/-4^(cV;=8_ATU:Z6H
89\C#5CSS7eQ6P;d=ZK;G2GS8+.](]W[]V>&+_IWdL;+;3VVV#KGJ,B:>9#<DNB7
fa7Bd<2C9GeaMA)9<_4)=.H:J8CP(MKV1DSF&19A8bR2[/NF=g>8<K#=@RgR/ION
QFJ,Z\-a5b(>SPQ=9-I@Nc/H=4.1g=W=aKU#FAZM+Y+R7V4g<U1LR>VHA0T#W69a
IfcILb6>I<]Q>GP-7a<C<WQGIOP=J/f;4-fP+EY?P4,?:IVF57NH1Y77,J)\d)=0
H(Q0=E6-HOb20V4(DMJGXV]U[MOM\?Xg\NG2c]@>C;4&^I0]<P,e)E=KS.REZ4\K
/;F2&.\B8/XSV6THa-Za72^^A8<[]..e^5(&X@Md#d5&>BC_Q><<LM;T2]1/NHA6
-dY7KCT02C)&#/Me_0@Z9XX[-dZ)NPQ^_0/\9G8^K#WPeM>&NKQ[W6JGIH@),55>
C8IO0_0^#9/Z0c5/1[4=TDIeEK6Q,>OAC\U7@_K07PC>-9DSPE9,^b&MGSS8M8F/
I5HfIBa@:N]\T5##OTB@9+GZ<-e,e<Q^dF0>&+LD4]a7aeVI//Gb_=>;0G&S@H^g
K_K^.Q7H9,&:X0RPZ3D,6]S<W:f1GT&.6DC=1:I?Q@=6[;HfaUY?d&2.@&A]GN)(
&?g_<aLR1gGg(,8\Q]aO.AVB\59;4_KB=W-g<4aSEHYG9PCUEP2KA5aGA7VAB_VD
TVQNb@:fALWa>;:aUX5.McF.,Y&ZS(0[+AWW\ZV>5OT7[E=+T&785:=CG&VCB1][
E4&56.;3R6,9I_.#[8Y,5QZ0HTQ:C8TXDNNEQ;]THReYg5/^#MN=U;YPg>34;QaE
HK[<FRO9J_4[cA-.#O+G5S[V[(AbYPOMKKSPX^RBX(=/FE,.AIM/d1]8++1M.IE&
4)LcBV>T4@OQfV.K=2[-/)G20,D#DES)^gb3)5Z-VG>EE,M#NBC/P0IXP\U2GTXM
<GSTD5;MR]+XH^6cT.W2Q.fdg@PLbGF<d<6<DF)cSa>CX-]X_F:>?.@[;OZX1Z#=
T[R=UFZ=GY2]L6/#K8fNd_WQ=6X[gf<W=C,ZL45IL;PeJ)a-0N+87QMZ;L81Bf2R
U,L6d^[KM&Z#WecB#=B;d.C8L<eK:G8Y\=?V8B:VH)KF;N#XO/Z+:TZ<F1_ROSQY
<Q=AWR]GFG2_1JfTa[S+2:S8DJ6DBL;HLT@_EO0M9M\Z#f+0:W6)H7GB:-LJ,6GA
^@\cNY_K<Z-VBI7I#+]YB+)@WB&64e:[@BEG3^Cb#+YL.V#-RT.YQd18@TA=)dFT
JMd2Uf#NcQAOX0.&a@0:2FKT_SJZV;5[__[^8c90D79@BVbO@SPe2gHC_1Q<?)U&
^@@C3(dc:MIRAY1^B+)a>N6D2cT[U(YUa@(&JfG4+@^RcJ_;@TgAde.@2_g;=H.c
(/>@257XN(1A40B,DEAWd[_&R?Ne.b)M>Q41[N0G>37f_U<LRJ:KFG)D#3b#E[b\
#D2R8:Y&E.?NZbKNd&&IgIP?-=+YC&J5Y)F93T0X08?:8D:B&.,P+:&gd],^Ab[B
[Q4?Hb2>b.4NO,6bRT3B,[KS++>;NJe4G]PV?.G]MHWVU;^<54A_6E+OVb,Bd2JF
HaT+LEO-e[E5MU^(42PY7E-FK-[M+2EM]Gb3Y:2C7fVT6\:gAVYW7@H@A/_+ZSP]
:;@?HT80)b#8Pg(V4130Hgb=:9>L.d29UTLNG(P#dBKBT534H:V[FT[R2)+d.:S7
(.6/:7PH:bQg-\gW5PON]+c;3.7PRI:\UHe,XP-;3K3#KABTA5,g&05WD/M=JSM+
9&GE;WJ/O:>1^EHK:)_8a5ZU#bH[3N43N;J@QXXKA)1\OdG1U\Ue0c?J9;g_<VI2
TJ&)M&V<c6,^Z0U<7NN98FY@;EW7)XPd@>c1T&Z2)\<EIgb(?Y=WFfA?@J+eI:(W
Z-6C\<;4=R;E0)4-4YM0T@D?1HB0gcK9JI;\AKHG3K=X.eTWQe:e_-a<,S^&K\P7
WP_GI)V=,4G,I9IFBRMZaIdQG#[Je#7]&SYCaFIO:Jb]N.P7GS1YIfG>E#G1c-3S
Q\[B7;gHZ@<f,[Q\4=10HYXQV(J/,WGVXX:3#:<B5K@_+L8-V&@Q(?-W?[>M+Na0
U5c4+&W?a\IZ;(1-</Z(=:XJ(61e#J-9ED_MR)EE>Udc0S5&<<R]>4>e4_C\P.&M
dWR):b42OCW8f1\1Ta0]fO(W3.;VE?0>T@D&K0Z@;IHROeF1.NgaAeC?22+:c;ZG
O=LX/2RIVRMdW=A5_5DUc6GG?a3ZDAW+1CUPgc(+2,RAAMJ>T76e;GOL_JRS^W.e
L-:H3ED\JUAP8(N0>G8^e#e\UA3A#ZgNL)7SGK\;&A8Wc3BIXVMC3GZG]2J2)&(W
#NSEJO5&&feKEF,5MbRbXA2F-[@bA0A-<Kf<YL3?W>0:T)\8/]eP:50DD>NadAfF
FW+\b=fOVD?2OY8GKX?,>c?GAE_VYGUBZQ[3dU9W5V)P.?I0a9&2<Na6f=T@Db7F
^H^_a(RdBgA9gLfEUOfaO;Jf:D@MG/bd<M,a?0[a1XOag26ZXgY8EBT-&3H>W7(g
58E<DQ]F#VQU@I?#bG1a(35+/ZYFWK,)9>BdVSE8@^:Ydg6>9CKe10)6bE9ffJH.
&Pef6ZE6:O1fPeB3LM)BW:Z<dVQ>74TcFc.gOH\\gR,A1X(^QB>?gd0#M02O?GIT
JfI:bI<Ab#.9S:^c>c<cDE4,:).Pa@@D,+_<]#D-TB/<6/MFA//9.a+89@NAFU<U
b:eF-;LO[3geRAO<4HC1.Ybde7,=)&JCe),eG;[)@4gR2,S>-\TDPAA<J4eeb8Og
.G/1<QU;JP-7^Sc=aKK6b<JZ420=:@MH;XfKJWg8dOT(Dg0O_S3)[TAB_2AaJf@V
e(Kf@SZAD-<<B2^eTAd4(9SO_9@H<e9GSH\gI7f1c+:92<C(@9-NXFSLK64[aD.B
64NDQG)W6E/W_\N+U@<WNOKb3ED@&6,U/TNJf91M/U,+S2):=U1[471<4Bad.3PL
af#^M)BF15,TS5U,\M-d@Dc2(#6S7F9.HFI&525M&+?&W;f8bQR:50I&W;35L\.G
b3FZ/.dDFJg]2?dZTGH:N/.#3?ER;UR>ZYPAgaPWD]N[L\b#e6WMF^Gf@D=aASOa
f01U)@VM^1W-X#=9feLac@&8+-aXK<Y[U+HE:OK&F[P\6+C7(DB2X0WB9gEV./7B
9PPG)9<.V2,,G4IQO9P83B#AUZ3Z[R;a97[+23J._>,JJG5XW+(G[YWe?L].LHD\
4QH48Nee;R\L?)A?9[KS[bN?adA&4<b2D&;LAP=c(ER1&fdG.@([#IU3L]X&89bL
P3@=d6OD[Kc1;9QCc^Qd/TEPFg6-)+=&ZS0MdN8OE=N?0Yd/VYR@D^Nb0;FYCN_V
d:1aBVH07eUDg/^RDgI1F&5JY_/-SMa.PFY^2TO8dGRV7O.Q.Ie4[)/JQFU)POM:
TIEXO2@SI2G-K/<a:D>I4.Z=\dR4df8&JCTY\?92:4&c4-RFEQY=:dKRNZ\QX;+c
(5JJ>c_AOAXH@ES,M:DC2+OGdWfDZV6[a>6XT9UgMGb=[JA^eL=,<?].N&E7EG,]
7[;O<Gf+(U?Q&>BWCF#\e8SB3b^3GgP/3cZ]dQUHGa(3E46c\A@=3]]b6[W8b3ca
/9]V4M_/DA7D?:GJB42<^&\+VbAH^H4-=C)CXL@;MaP;[@QJ>b&@(DQTW@7UR>E#
PdJB.M:bf#]@:gM9YN=ICT>/WWNb.N64CPV6WeUA-_g.XL)RO+-\;N9Z)/Oc.cJ<
RcbTgDYbUPX1T1&9;Y^^[)XP2^A7.OZB/IF9#MW4JN],GGE1,)FK5&CE;L:QgCSP
S.>fA&O>\FJe8#3)eZI8+584BI2HOGYYTDW>7><[[5\NXPdN6a<E\\E^4dR,93C3
a.79B24K0@6+GO90?6RU[_\0WN_9FX\f<)[cg\+32L/3THRMbPE84EP[:19J[PW<
1U2IO#G2JL/[X.1T\fF6Tg#FNZKIe.TK^8NcXENK-Y<0B?4NXM(dQIIF#\QJU:aE
FK6f#@HJ#C7&YVI]>YdGB4.Q4A5YISe_#BSO;NF7JX4.EV96Tc6O)N/DGZHH7dYS
MFDD>6;:.N)15N@ZZXU7WJW@:&cAFe0&_FH58AQUW1K?(+XDR4E./WgE:VfAIK,f
2;a^G5S.Q<<ffCXfC00GYUgD4MD#DXedBFKEDfROV08A7N8NbdY34\1O+NK@G<;4
??b6B_I\eH;VPIXYdI5LGbe/6_#Kf#Ua[f9e_M>15?^SSMdJ[SMRIQ5,7cCaSN;<
[T@b=ZOd;V8>ZL1LUL<SMY^YU;QW-:0KR\&M0Ie6DMg?:Ig.T(L^9_-e+I>-fba&
YEV>J&0P;(Ef43Pf=/RNVQODQP60;\Y13IN02N,e,TZ2__+B0X<;@6[G57]f:b0H
0GUXWI=2[:BY5T3M:2^+OWJ1(aTEX]HQ5EI5.fLa9bA=EZK4F?g7@KZbYbW=2KS@
O#6_HFB7;673/d)93;Kaa4]bGc5NZ#T_QER72CT<7C\_-6c6P+bJLPHH7G>A#NeU
F(cc0dFf?U2bec?IK3fRfWSYRf4&TGA26#YMb)0W\c##E,V[.3THQ<f>5;[TMT9X
E)#L^YG208&D\HBFU2Ge2?dfIA,E#_:\4E#Y;0B)OPZd4RH7&T4\d+\>Ic//?d98
OB^Y0T+6Y[S+9:ba@DaJ\09U&HIPKZN:RAcU:e\5?L-g,,0?aCD/^AQ))74Z,Q9O
8Hb&AP-QbFO:-5ZV?#SQPK<ROZH;>3&9=JTB1UcIV>9\F=b&XJ@O@=ZT7b>6ZG_H
+VG+QSg(K9Z3]L1Q7@\J>fYSDJe6:/=YAC+&:VKI__R7AF1TY>3R-9?I76\.Z;EX
X.@7PN)D>F2:?KdG[b/SQY2HLa9K=c>:b8TU8]JJXdcBBW]RW=I)a+USU.:;gPW\
P5RT_<-NU:a:+dc,FMCL(\X:3-FIHDM7b^MQ[RIVd5/IFDDC@#N(T6SfY9_RWG1[
7KfJS4[T1?[M_0;g8Bd+&OK,R<@\)e7V3&aQOeJ:c7cV4+?1>WN\55AbBTd+_Y50
W1g71+1<],HbgFY.g4Q@MU^0)WYNK;/M8V:U/_?MPD.MD.QR=74L+0gYJRe;-[@_
E0cA_\C;;/1#=c_[8_@]_=I#-:SH@N\Od<)L]BNOM,2JGG[SV>5(/b=EaW-LWAME
Y##R[V0<4KH8&)\@6TY\LR9-XaB3;1-=1O(/&BT&T^/PJdHBbB_=[eTa)ZVVIX),
fSX;U(.H7RMP8<LY6#V?1aOI^:cHRG2EW8@PfOP6@e\L:MNAUM8B^/S6<FQ7eLId
Y^DZYR+V9)ZdcL3J>EC<1L>+^71HU5#RQgIN5D-4GHKOK)agP1_/9=)b:8Le6?F:
,2:2SfA&RF2SGQ=0C&P-0.Va[7<U;DR(:<;#;VXTXK0b7[1;/Xd7aS,_XT?f0f[0
S:5UR9(?S_#eZXHOCI.L6I2K3-dLZR09\&/2)_^bSDN@2c_R2J7UMQaQALM]S0Ma
GD57HH(+e+;eRO\WbI+A8JZd54NW6VS]^GL_\)-I/HLJVZ7(UKFU9:ZFcLC/AM\O
BdQURbJ/0JGY/B,Kc;Fb\7Ha]6>1BQP,(BSN+bZX8+,[EZb-Xg+OQ/PbF7Y]ZL5?
,[TaM^D4GW.bKa:#,d4(3N=.cOg]/6_+MURLOO42-9IM\8]eC3R4\T=DN0PG0bT0
9G?;NP8.PfDbS64dZ]G/,\O,1EHNb>A=a_W(?13f&80eFM(WD#;Tf+3S-G1155Y#
?5/ZZ[91?SZ7<\<P:d6?QG6]@?>C0#80T2SH<bZIJ<e7V@^,K,\QYRG9J7JI85>L
O40R3SF35LG+WN&;-YI;PUQFV3Ld[@1QTP7;NCE:<)U1JI,=U>dUJUZ,@>=7RXU4
(DOHW;_,\P1MO+BB2_6g:ZX[U2I?<_UKg[18EK&XK-g+PR,GOKBb78#;AHF.L>US
4g=4?-M@S9L;D:7FB>4^fUV)YQ7PCfZ84QLV^3W;#c&4P\[E.aVBV_@Cc8+34EC4
d:&6aSVH,MAQWAPe=d#B\dW,e;H5FN_6C4RG4L0.[+(QF2I1G=S2\L@NMf_9B@Z0Q$
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
D#8RF16eTB9;<L1d)7V)=AP?(_53(1\A<?&4<?)U/eLBDW<SA=S#8;G&<3_N8N?G
d6.K]^J@YQ\ZE5=SePX&2+ZXMgF.g0U>U5Idf,))^DTeNDDE[;gHKa;.PW:/W786
aIWE[PWgJ2J6^SEGBP>ITLe7&9HRCb\C9#@:JCOF8D(_6GVB8GKA1)H7^2YI#J87
fL/VEW3fP96<gEV;Q(3T2B:V&++9([f+;EbITE>@C[@g,+_&\8gdQ\Cc5K\NPXf/
fZ9=D@K(fV)gEG7U=V6;BC-?X^Od/_^5I_g0A\2IQR:OOAV4cF[9^_.(JUe_#285
eMV,)gX<>,FD9J<[V\e)e5cgS/9H,NJ\FLD3fEH5b-EXUL>-[@I@HCRg9\;dDgI;
99ZR#C(C\B;[DeK^U>@fcZRL(FS9g-JTe=3>Y(/,7?=R6PSIP;4a_H#YS3Y5UV^e
1X[ME/?\fg6\;@,CY3THXW(&1,D,_YYbQ<R-_+Vg06g:)eI\W?9@=BYCC1EYMI;e
CCB8@\VYL-@(3TDAHM<e9(FR_d=9),(6>?3Y2V?:=B9_36SOgYY.=;&9[#,;cLfg
(-8.0eIE4KdE6(DVF&2&WW,Ca/Z.D\=RA\-c)0PSS7+Ed7B34)4cG@W\_=03c+(7
MgECJ(,F8J,b63Ce+)5KfAddZ=)V_]Q4/Zeb2N<XMY#5cU;UeB6<M:5ggND5=Ec#
\HWf_#44^&=c+)_-A6?6&?OFDCEB_S_SI(.DI[If+9290+Xa1D(:Xc1SNH\DAY54
fY:&PVK(BMC\6:.G]3F_e_DI&(E)dP48E)9?S0.DgedPITT0WH([[##V]U2E>QCG
G8)aR?Rf)O=fV-d_aM3Ig1+EYI6D^5XR5;#AP>YOd&?0d[4>\P<YY4,f)eg8R)]L
U=(_(cB#O/1gI2HZ=@YCG4^62HQU2:d4#_RD/)9d599L,IVN)FK]&e7MMR4X&_N5
<Og6_:aCY5@0E->\d)K,Qg.dAW3W>Y^cLYA4.I3a28(/(FIc):LT5Z7=Ig53+=RP
^U?]&g\GQ.[W9WeZ3:R>4I51>f_bCIMDaNVOfS;K3K1W.R6,<:GL]aU:&C>1^(3b
6:M5A6WR5-aQ)e:c&@S4-F;&G/,^^bRG6B=MGCefO.g[;1/.E_H@M=R-CEUO4;/P
.Y@O5^9gW.L288<Q&gMVAMSRJc_&7@OM=HVMM]V_>D^_SeLcacTP[<B<V/TZ^&PJ
a=+CdY/UFF8H5(=Yb(GA41/M(S72(-fU_LH&2R)65QcDWWJaGc#F[,G=GVLAIT]&
L-.L\FUQPO,O3Z=1W/4_(9gMHQX20>=OHc3Uf:N#>[?QRF(W?7_GAK<f5(ER.(DQ
AA(Y?DQHK\d4/[\NY#_R[[5.#+dD_dL8L:+6T-TZT>.LdK.SRR+B.VMN;?2EJR7A
F46VYSSZ\.CU@#ccO+:eE.B_;ZIK64;1-#L<\BJH-4+Y2fC<O^R91PLA@L^+SX6V
b<+gb^#NF+4BKg,Gb(.S6&:)XPCf<]129\-?g7I\@_V61YLa>DeFNK5b>A2ZB#MR
:]+1RJOY@/W^HS]8F+Ic@>B^;_=WfQZFT7VKZ-?bZSXYJ\B[M9@NU&7[#>:(O^W^
4AIgU-KLbYTdNB2-EDIW;BOXB#D\I1Z=@S(O/2G1SCJC)eYb494c:),O_JcYYFF[
X\ROZ_86Ade(MdVD\2eeTT0NP(XBfRCJX\cbGC>?^)<U3_?eD0fES(#ML11IQX>>
&Z4Bg7fABN)MP^Cde[Y(NOIaNAS(aN6KBb=626M\5Z05#BRc21?AX,M/39KJKQI.
?)P8(\)CURP>Y@+-NU]@NW-<R476GQYL95KM<,[a5@9CI\-P</EH4=EH8\BWaXTc
1.:&#M82(AS(#VH/G[bg4BMfLFS&?dfb9fHR=DQZ)VNNI/N+1@\L3T=Q<)(CB[(&
L)EeKZ3X#S&/b>R0R.>D/<VN924@Z9^V+dDFg8B3E?^c#QNBM_57GI01cW/abb9E
7HE/NdY6F?OHS3IR=(LcZDRL5B>=c9(&QXa:_XP@5\Bb?8fDGg_F>Wdf7M,dIU)&
X;M-0^^Q41[#E,(=,T;OQXa/S6;,9CFUVV/,&Tf&^,V_/GXW6-:0]f3^@3.NKO[6
QC^ST91XUacgSZJO,8+8HSX3]dKO=?V?aA).)LIQ+C)ZZL^D#dK=2I[O<BQ8X=Qb
IJ_YS^6HGKH.(=/SV&BE0W@gA7fg@[9fdQW;^CX-PNc)531,bH]9d885fM6D-f7f
J79F.KKf)V#_=17bceg?)Q&O0XY&_G0Z16M5\&-V6G]\&.bSH)#CK(/R8@?4?2#[
4X9\===)/R_AU#W.63dIS@2PQFe5_SJRK4PJaBa>K42DW)KX=QaX]XJVg=\K>S^>
M?V^P-(a0TF@#Y4Xf:cUFNIEa(1#;?2<SLDdAf:Y/4SG@NQJ1D+7^P^UC#;W9@[@
)TUd,J7H:T?R)>KT4(<bS]5fe=#60\dTfC9Lbf:W-4P:0PQ3R7E3/KC84P7f-6W#
<(&?\7LTNWS;QJ3?Z8,>=;A.[X>6A;&B.H]Ld?68G7NV-B,Y([97&V>&I064Ya54
f^1G0afJ4VO8ReG[I=FP+J(BRH#F=ZeM8<@:bZY\F-&NH4HKHF6L\cN6;^7B\J^d
H86M>KZ>f^RWM=Jca(bPVOdSXWPV?U-D79W+fI_1U8ZV=B+XLf8E-:L2-3a;b2eA
IY)/b=W71,8YX7C=MI>PWPA2#@M_=bWZKB<.Vb5.bLD8&;Cb,2)=4ETRV:M4+_B1
dG_5M@@Tg(.-RT/+:b29GN7d+T8J:;C\:CdgRMJOGE<R.;GD&F&1ELILgND?eAMY
0Tf4K3\\\\6M5O7(g#0PJ-\Kg]>e_MBE.RASDO]d03&B<@bKHF8=95O&MaQB]/4Z
3ETb.c^L/E-(WLT\WC_<MJN8UM_&LA;?gaC+PVRJ@c=1(?>8T1FMT@\3G_:DH+,4
M9[A/7b0\0B\[;5GYA+@_=\=LQQaFd)&1)3QU3_DL_3S3M>e[>ST3,[eW@?3S2TP
S6(3O)eJY1Y7XDYXV?Q1F@>9IA)<:;F58#9RNUP]#:G(G8.L25,/fQQY#:5)^F)5
3F(?V:YUfgE7YRa)g#>^?MXLZX?R/&5N4BfY[W-XD(dI2dMNcb+]a/ECgDc0@9NX
>B#W>;,&I6A9Ld7\J3]eF(ARd\8[;Y+fBgUV^3NMZI.RI2N=O06.]D,b;G->LD_2
),_+gRea1PAW#>HU6ACN_MWV5gNA<86[d(f1WJ8Z=dFWN,H7eVY<<0\XE>K,&P=H
)N5XZa59F[B:CH(GJ?+X>5FD=a[@AeG2Ee,KM_7aRL<\Z&a>DVTb5/U=c_A;M?@B
cI;aX+Q<WIJG(=40);N8<\f)Hc;.R+M<PJf186_<K4>P.BEZUDcDE<U=L$
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
&9USc7gYD5OB)HZO8E)A=7/Y(.:B,@:)(;Z0-Y;b(_I9Z;?OK:Q;)DM<9J2U)9cN
M-EeF>14L3]S]]]LM-H.002\L_9K;]5:XGKXOc&GYIMB-Q0Z,^HAK@/O]QG:M^(+
KTB4AE,f4+6)<YB(7eG=Vee+b,O8M3TTTYLJ?:&=AP-[2+,NV,6.QC(5X4V,aS+X
/[OR8cDa-P78SN.SB#6Me,,SJJ^ee.\[(J8PD]ZJ2./+CZaY#H^6O,)#/H\a6#3L
a+CIYL_aF8JM]^LJ-00P&F]4UWAFe#)cScV)-NF,5A^U8)SK\=R;L;_e;3_:ISC8
a.WAf,QG]5O9?9@5,B7(BG,<<NAH9&N8RN8K-4-C);:R:E8&P,K?cV_IBA/bQ)Y1
20\-ZJfe+HN^?G^-Y35LJ3JN99D1^@3f0HF4,E=\_^&[G(8/;=9++VH2.c+C@<,Z
-PR88FaGZfS0A:bBgSCgY@aN.-]B@EVa:P?8eCQ5>^WWKI75UD]B495GWU?2eGL]
&X)Y?30IU<-Q.85IEHaSX-3Q=<AbJcU,GD8KJ1#6B/bT6GDC\JbB-EM;cN@)?Q(5
68XC:a)SYTCN8?5#fQ@8NTKCGa8cUD>c(OcMc,_\24E<7^28d.I6;:W&da#XdOEA
@W@+[[=GUBPT#/4AZ/=L,e7=,SS+U/Zf07g^E.&PfU1.1YLSRYY/B0e>H7;F4Z:?
N]1S@UA5HZ4T#>8H&TVI3P#aYJ4C9_)fP<^3MH^OQNfV?a1_DV_@3+N@^0BQ4FRN
BbceRJCTUc[KbOBe6[K2a-W[G_LA(6VSfa[CUgb&;T]FUTe/0?RW[=XH8\X3XNa_
X.Hc>E:GcB+NVNFd1V:&Ca2\?/N].XK?<)S0SEG51ROb&N@:P+JLH^&289O06a>d
(fC_.UQdQH_/.V;]E>#fN_I_XB#bP;YZIeQBa)ND/V/?d01V]HGF_2+(;eDQ:6P#
6eJ==T8>4b;;):I6WYWZF4U(>RFP2&O,PR(H22C<OdVd)+VC_6(N40K.^YFY_P7:
Y:f-D^E3R<BJG+57FVM?4&VH5T-?Z6:R,L>K>VJ&/3d675WEIA9D+8B9/8(5M7\-
^^\[7OG7N(Xd:F9:2^M,G#1)b_<=)>IIY3KG6\CJB+WLS_E:TX21fP5bUFJ&[Gd6
fL;R21aIbMGaW\beKI8H+-?IXJC?\L.NYUSd&1P3VRJe;/a9)LfYaG:d(]c9<,2=
Z_6)7Y9YPeeXBf.Cg;K9M?SY44XgeHADeZ)1V.A8Z;BAe.A&O,8?c1(RU0g\&_e1
QC/b[L[I;<_^QR9/#2D;0K>=XZAP@E7aI>W0F[>=d+?G@?PZ05@[H.2>M-d,f?fX
^@[29QUZ\\9)TXPZ/Ed?@9e0Q,;0.^Aa<Q/7DFK0XT-7]c5H.7C5:ZKf/XL4I[+b
&_S2H_79LD<8-Fg;aX:d5cVK01-@6(g:L\Q>#MR=FKKfO?@B4Y6WA.M].TMH0BKd
B.YSC@PUA=@eCKKRAL]=R(dRD2+KDEX-?7/AV>a@;/R_).g;b7PBIB2UH)MYBd.7
f1bgaX_fdeB/848[YBJHTX@g-C)->(.O-KB,L21;M<@^FUT0EO>E&C>E\?KZV-;B
2<_26_Z1JWZ-^bSQU3OgC=<2E.=ZOR-L;(CN)_G\DFOYfT/Na;G3N]DRO9/66^f5
G4W</OG4@f;()gN_RQ]]YW?GO?4-O<Ff/5fgTWX;@+-,F0<MGEMZ8IY<]eXdZ)QW
?W^)]@_P8O)?W>GF:UbE34OQ&&e&GbVGHKJ(+HV5JE4U1E4>(69MaN[14.Wb-OZ7
JCb:JYfN-KHg#U_&#S(78H?(dI:<(6CD0>>?C7ZKK<,QZdF9&dN\&:Ge:OH..;H-
C@3U@^ZB_6/F9&T1EMWgeP/6<@K1QUEM]e_C0YZ/5K9IN(<^\0\]cV0ADG4gU=B_
JD3FP0^P),J56A^Z]d+[&2X5A@3G\L[K;KFOR+H;FQYF1e?YLT&_[V73HWMCVSJQ
a&R(:R.C,G11bA8T[PF#:0F1?5dT1eeXGT9]].)DIH-P<WZ:fFZHMeb,Oc5]M?\@
7,bU,1E3X]QKISEQ@++_Nf1QV0V,GWEUW3S41VKgCFF7C8WPed837NYe>Q>-:>A&
4RXa9YDGW)F8D7-K:FBY=fc]#_<RA<@N4>+[dc=<I)GW3W2FcVcTRFT/V(UAd[MT
G@X25Y(dC:IVRI]<@2Sa\ff\8\.)g(5GfR5_5S/OTGD5ba;)LgV3L[YF[_\YT@@7
b?=59SNJN]WV:LCX=HWK.@I^]d3Tb6g=g<eFKbR/G8-B2_X&.(caS#e)>O\Q@gT0
P:2A#A+d&\e[.33H4cQ2e&FJX]UKg.g\FB3@4X>-KM(1&cM;I^4N5:@XB1e^Q?AP
MM2T)0c4e:c.\)Tc)G<a\ILLJO)eR08e02[E0_KGO/^I.Te.ZXP+@]EC-,Y.^A81
@BSY;+TI](eY82).HVVGX.BWXB/_16O9UJ.#@4gFYb<f(S9OT+R;C@-2aGCR+[[#
e5?)8a,b5E@gZ9aXD6:724H-SgGCc1V&S)DGH1]9-3FfC$
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
ND]+9LFSUJaR-B</)dbc9,SC84gO(aX&(R&B82T5/-_c8BELU>[C985F<9Z[,]5P
A[1cePF:_)3VD(]-9;O336,31^HSC]+Uc_@QcR(QDF7@5If[ZIHeTbXA6-(<N]fF
7Bf@&\N&a6CS=@5XVHY2V)XZF4UHP@bdXFZKZG0cN^gZ]FCD_^9-4bKO.YL=?6[9
d>.7..Q6>))c8)&>T=#=HNHL8)(1(e>EX/:[KTZf_OUC3:0RT4FNPZ6D\6#^-&?G
A7HQ(UXK\[)I^GO5?#&K;CSV=Af]+OAQEIc,50Q_-K<6<CS2>BT6\XT;cA?OIV6Y
/DJb_8U-VM]DKc]G.fCa3.[2K&:J/UX<K?M&W.,T9)9G,aNU7R/+6SbZ<[(U_NEg
&QeD8JPAXXZ3:=2&T)^Y?X9E^U=9b\aB7(42^Y;9=-=>ca4I&eOO3fCXA]&)g+IY
0g_T=9)b5f1^g.JE6UKB;=E96[AP<XO-eBbV<.(FZL2f=^P)_H@-A8G65,E.2G@f
/UPcV0g7)\gXX#eOdYP\KGS7^\@fB7WWTB[\H,D?@<0(0F^4&(2-10K\8_@<,^<R
PIb9[,6I8#&_&?P45T7)WMK-PZ.[\KVd(gFaKE\?6&faf;cbSNZT7@Y2a.dALd41
#YLF5D[@32P,B+MK4=WZRb#[8AE(>0XEJ8gdC3dG:aSJAJJ/]JQKJG9@1([b/9M=
0SLAZBEc&b:ZNAVgbJJ@V9TD7I_>[(9-<8FKHEe(S@1<)AY)8QM5=bLY@36e2,d+
<1g<HfU?GcZbQV+&Y(O0TC1K&.MAW[4/Te1_1K:;,8VDgF>]L&9IV#V8,O3&A@aR
g1<_Q#g8^)KAfRE3U<Y)b/OP]0RRN(c5I.bXGd[#d#8>34IT]2O0EG69FRSV1>d]
G,&X@AHBVB<94E6I2:b_<T,[MMB-=9-#UJ?)#^;(Y3Ia.2)#6Z5Q<L;]1Hc&=@F&
^NL:<J]:/99Y,g62]=)6W^X19--[Q,NWM:.DT>c^#V0LJXe;(5@>57.(I6H0#IbS
)=;N[)?8f+S/g:I]Z.8#Sd^K9_Ze0b6_d4]A:ZJ,(7^S1+1UD2RH-G?_N7@J0;7)
>12W0_8CE]_,I>+fg7f\>,+?^SU)1Q.T:K#4W1b>RPX3PMU=1:Q6=&&8H</JUUP2
_b7QGQ,9\ADZ.EB26[9ERK@KGg-JEG+V&35A;93?cde)cEBR80a1:bTT59O]P_<e
DO-PR+DU69cH]c-L7M,A8aM4f9M4f&Z_SH6\&&26U&:@.);EP,4F@T\AD5?>13D2
WOEFg1P:B5#F._9:W2U-6DBGR5bS]eD4>(#]D:]10F-XAG(fC-6KI/H.,X<W/Ng^
4+bD0.TZDX>c3gY<aQ(9O5TeR^ed6_8D@QQOSL#8YMOVV)WO-1S/c++0^#A.;:ZE
3S[4b4(2@RfW7X0e@P4;c#PEXW.W1K./#-(W)e>dF/5)9b09SLHCBGUQ><7]KZ0T
H0K(>BA7@T1(=5=WXX#IP-R3ER4QO2ZN;5E&/K?MS71;ZF#\c@+GV^;f8P;eWHY.
91,&7=<f5/a5K,0MK:f;&<MVIH6VAWB9G3<K\1)K,[U/UHYIV8[SZdIBa<60?e2(
YC]JbSgaH/S6/B1<@A<X[<gAK-Y),2-?c&L-)+MA+YA7>9,A<N[UB^DUX1+((1MM
XEM8FKgMN59:/)U-/;a,0)]/GZG3)V[2/+e3/+7,?PLT+b]f4fHSCQG/,8P#EdV>
QJL>P/W.1XQ)gAQ1b2&7KR33TI:I;B.W)GS>;:.gD906XY#R79NC><9@)7Kb2FPD
KERdFB1I>/Y+P,(e^CS^(G>bL/)R:;[c5I/CRc^77F.SJYcS8F^Tgf.Ta(gA:c[Q
^/Y&aW[H@4+>B#MEJdI3g7KE&X9Q?57;:T9)_b7ZVO5#;<_bD:VGPYfV7:fc&Q,T
Yg4e2QTeH_B=)X=HPNOfXbgCFA-REdNVQ=)^Ef;)_6>Z7#-RE>cRd\/X&1=P6DA6
2U#NVLHX&A+\EZ3//LAd08WZGfT&6gf@A\&@N<[(.I[@gabA7ICNG<>C6Z2+3W..
W&HYE/0fON,bX,CTBK,0-cG@GgTCfXZXY@2FJTWCS?4C)^D\P2W1^\(1CSM&e2=D
\Z=EGD_BCPd#Y&H<PeS.eMRZ-_4G(PP2UG&M8eGV>YQ@OW#CXC4J(/B9:ZW][<Md
:+:DI_VA0+I7@=-W6Vc=U/c89>GJL1C#0H#ZG0Vf<3Va),&^=52fDO^-XW5R9dPd
W<X^BV5Sg;0EMTQW/;5JJe\ag,AZ?ZT=X[,DK/WeZ4/O>b&1daG\H6Mb(0?[TB8Y
1X^IIW)_9]/3NdEcG]@P2G_ST:;>+;Eg:IL#dEaJ;3)c1JUK/cQ6ICMQC=IIcN-+
B/b938PCBPHX2TF(//Z8O@O&:b_>+U14b&PEOX108:e/I(Pa#gAO.SJ94BIaV\T0
f/BZ3@RH[^>10RbCSJEQ2?b5ggeJ1Z)?e@&V9gS#4LAf&O/5#P8GJ55Q7:1\77:d
+HfOO(/6(W)#2I7SC3eL3^@0Y-3S5AGAT2X.-[:9(:3Z)]AZYe]Cg[0dN;d]SJP#
bY5U6H:4RQ/+?fIJP]E#1\bbGdLNMY3HW#B&[C>XBO3&a?14/9IA/f<T:,GFeZMg
VZYH#G4SCHK[/,5DI,2L^ZU9-IUGF\XN5g7Pe-7cg.7c;#O(MU/)=PfO<ZWJ2_M\
ZN&:,KH[/W/@I];<3W8H)F4HKU6#KeCa,L6-&eJ^?+e>A#<Xe2+=4LPS4;M]N4L_
M<0cE.9>#X](MXI.;7X1V8C:Ub5dAdT6Fe2LJK-AR:V?gUT[ddaN2a0NY+W^@30X
AJYcDEE?+>ZPXJ)[,NJ-ST>4@#317(+?_<C2BO/S781cLD(KIHS9UF5MFJ.B0::S
N-55A;JcSJD.I#WIPd0JH:<C50_C]X[4Y1KKSF:\..WI_f#=:6EU,D=SO0?V2<-[
,-F)b&@ag-XCN2_H0SJDO4Ra[7d46Rf#7e>5#geDQPF)9I&cFDDe&=WD>>/;_050
ZU\DeZ3-be6Ud&+,gZA-g#Z.Z3aVKZWL<fBd+/U@N88cWaLb5GL#V2^YCgH;L_g<
5#^ZL[8I0,@^U75SKg0V;?4<(P,Q&a17AaB2^b3##R?GLeYL#RHR1;-KL9KT<X.X
cON^@3U71#/.7H)69>d46&+X6C8-)c:,2DGgg<@<:7AST5bZ@:?[E?HX<PXOG#X1
:Id>-cR\Nb1KbaGZI@F#/bM26,-:dSC@6&=:J+5eXO0dZZ#:86?009^?:^=?:_GE
@Q-XDAH(cdM_TK&g<U>>(IQ&<dX&XG1/)^AX90^O3cZ_L;9:H[+5Ta8E9;]NWOM=
V=9[E=fQ0\T8_T1>9Ma3b6/f_dK;FT^b402,LB0,-XT+?2S91/T=D/3XgQMTK)6^
+.2G_b8RaFM(TH9G.@W16)dH==ca+\?W\4f23B#Uf7#D]JA=bD_..\RU8e@^J6aL
++d)K4T.KAgd[gPBQ[dL#c\a)1[?^f>R]4.a[+dJeabf-2XGb4)Y)Y4R:43Kc]4g
Z,==\6;HQCMG_WUbgB6:D:J6bGAE9]a\A\1R3R3_HGPfOU.8Q=U;/.#CR+0TXSX_
9+]+,PcY+7Ga2Y1#T/?cYCUO:<,P,Ieg0:?aJ01(]6,<;66V8>KGPHTE9\:KF[^^
8R)+7@/F52P#E[aUX[VJJ\Q96EF:L1]cfX=XKVbZd.CEX_JP&d2/@a)ebKVfK(&)
1V(BfF#?MY[_0RbU>UGXDC;R@2f1F=9,WMQS[,?/Id?S^;TOZD2Y0HW&d7)S/\c@
.g:TD.K+WXC8g9LdaL^^E7L7DNHY?3H>G+UY<aO7KL7D;V_;09.X&c6=]IBHK1K7
,RZ(+?1/+&//Hd)-[88STC280aLA#5]:S31/MOHKKUU?A#6VSdK39U6Y^;\KT6FQ
c>X-]LgBKRGXE)VQ5S[D1Dg=eFW/_PK6KDYLHVTTS_NYRR?9R,\RRdF?5S[.RCXO
DPf(\0?Y&d6&Z1WH7B/FVM[g5@1<H?2ecT:4<4<4f8d:ZE8UI#P8Bf>@CNIg^,2b
V\S-D6YK_#+L,bc=S\d1ga__-7MA[/Vf5;X,SP/Q]AC&;_0:JbCLARBdO?>_8E:+
V9_H.9);#Y;EX#fW,bXAGM&UX[bD\@\U4DLa1JXVOV;T8J&5_WP2MGUTM?]Y9:@2
9>+.9dfL:Re)Ig;V.AXP@+K=T9S1\=YLCQX^dXcA,e1KH#;Q=RK9->eU5&K6XP-f
9^N[(DgCZ(CBcOVg+]4X<+&(?5V;[B>25.DS2C.ARGSDKZR#N7dafLDR4XK>./CC
aHCB=<-E:eLE2ZX)]1^B9gS/]dLJWRW#MEAOfLKg4I9<d^U0AH#W7^+0\>RM7McR
\@KGcIYdN^SH/BEDQM5e[-A\>b,J/R_T<2V7#P92\5HR[9:)3_bcC0_TQK9RL.9I
QR1aB<c0/aBC(4V;&&F\Tf;OfeVJL43<=^\N41;SS-Y-?MUR&VH.VV(bfUXQ,S+f
KJH@,S=4_65C;F3T1EF()DNBf-S^Q7;/O?\WE?<FA=dHV,UU9__d37\5Ob]/SSG3
/:>\9;B\^T03[U7aUZ1NE1<9WTDb5\SXZ<HX[7a5e1R>-:OKcJN0DVN@X3:3UI7]
N&:7a@L7</3UF,Q77+]G],MRd572fP,P.@d,U.OEJ36L41f6:7>G?QJ<2eLHC#)c
A^Y>;S\[d:KB;]I.7VB/bYYMD5VaD8g^@DSQ&&G)Rfd@55ge7M45TUOC.J+>6J\H
6C+<N]]R]:24=9C:F?T(dWHa\W^+AIE3?UX>YIeQFSTZ8RN(Nc[PR_K5H6,cO@((
8+32^6EM2W@/BVP(+(H\=(USJF@AN[D0M9X2WXO3/Z);(c9Jb17WZL1UJY;<(g^/
P,.Abbga4f(X[^QAN\^9+4cRN/53c00G+5/2cR0Ne\g5L,1K2g=D>:6=d#B,eV?H
<UQ9R-9Sg&OZHZO+_O]75IcZWf,X9M7&<J[a_)9;GAAGLd9KKS3G:F=\IO-KH5+J
42<S1K+BZ>(Y4A);GTN8XGCSaZWT8@+LQ<R=EYbI:LXc66BPQ_dfKE=+&R<,bWDO
5.53G,UTf\UC-aK^26=.If1^C.456b63QcVG=^Q9F-8)0cL2bRCDNCg#eD(eBbO)
+VB7/<YIIOI-O)EB=3I7U=QY[BI[:N=^>+M3T7<c4A)4_O=WN4=O53_DDZKKVg:)
R<X9JZ)HV::(ceA.)Q^:7Rg>I@<9R<C.6TUIHL5YJe=AeJ>#YWa+Hb-XP>Lf;9>?
>EH4EP16K9^0;X[cABf,0@A>YP)f/Qf;(MBFO[TSL[+>6]TDKJD#(>6^IUND(Y?F
PGg9fDKHL7A+^ECg67-#g+O8;g^F\83.F-_A^6L((W,M:7XD,N]:/U1U)AgI,7B-
N]J1c23E:DfX8\NH)6XW?b^;RP@g2.7aK3gJ.[CW91]I6-#[REG7P#DV&[0R4b8d
W\90Ia],3_d_^V4).@Va3(]2E-+=RMD:1=52IXUeKXC1O.B3U8:\?3#(D06ca>HK
SQPUS(8;2LH1.:/+9+P;D,O.4X4+8WZI.W91XN8DDF&=_DS3WTU,3_07(_b913Pb
#Y)1;9;ea#6NI?Le87B76MVJ#45g_(3UA+bHU_42NTS2f+ZcXK.O](O^:?3\;D^;
ag2UC#aGeK;RVOS93dG0#BJ/ALGLK4baJQ_,864>d#(IE:YPB1Z]2c\6(M=Z05@2
L=FH82YAO_#e6bf+SVSU<b#ab0C:aZ4c1Af488X[K2ZK1ST5&X7bB]\6J$
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
7LM-WEg-eS?/82I5-&IK9X7S-,>Y-G=(97CV8/\\,F3<&A:<1^W\)G/2(2@&,\7e
<c0N.W<<LIYR0JTcQLY5cY8gN@)dKSgC4D)Hcg>:Gc@,7F:@^;8/#EIJ>bHZN)W&
06A@4HM]Td\fH17=FPP@#N[WG&.T37B&ZIURW]H+2>d(6c4=G<_HcNFTKa.UGZab
7c>0=&D\SBFT6TDW_UW=2+Dd/@fP,UTMN1J@;4[J?LE4:)-S?Rb^,A.)WDYAQX\a
HdcRGL(GP>6,K7MUDYXEO?g_aa1:]a6^ZNE4\UL(Md:YcE8a8]]BND&T+5H#M5d8
,8;RU4,F>9F--Ga+YXZ02QGIg\@60N(+>#/0=gUUOOa(<:a;FO^eDd<S1I&)@ba_
V<>::VHR#RQe5_^>BZ-b2QQbXNB3:^27=UWHFUWV)B\E_V4U:(.()#<VE<_C+/.D
@6W\.R@I)L7,L9g<f<J+b@:8a5QGOaY@YQVDZg[B[RK&_D)R^&N3:Kf:06I>8)=N
V3@4@e5KV[OKG>RFC\-)AV3.0TU.9B[4-5)^+VU.e:8JHT#8M@Q:;YGA9#)?/7AY
eF[J5?#4QR?_#Qd@fWdJ6PAcQJR.3#GB4.g=S0_Ze^[>ga(dgY7K^a?<SIMC\AO)
VZ(^;Ob<&&GCMg]O8U?\V]+2E:?9P[26Z[bd7:#S,SKTP0OY[8Wg7.ARO)3>41YV
/g0D/8#@\>_2M224MI>?>&;G3E.#UYID;8Y4GGI5+I1@;ELUf5FH+3B)X4gV>[H_
WdC&XQPSV/>.c\LOFHG:cVY[DK7D)70>.a\W?A)YZ_4/Nd53IKPAQI.7f,&5V@11
MI_W0^Z(cN3Fg0=>4++HFD67XC^WBG7-57U2[Z?;5J(gcB-(,M[4S=6KFC,;T?Id
BT-T//^3OL1N(S^QC&U[dJ/H1L-^ac3F23dL[4gMc)@)#VY0]9&SL30e>/^?)^1e
Lc2aEM/:=[Mf\QNI9W0(/(-X:8ME\5;4?G:(Y);3/XZ6._)7C818+11+9=\e55R0
I/2^0^&3_1R<H/ccFU:WV]68>0PX]Fg.GSTPA1QDHb-S]F,YZ3NFD#X4HF.>OT=1
NIC4^0M<[9IT.c@&_K_K,DQAg7&Da.Y9g5DGQg^+OFDNK#SY>MW0[AD24C1:0eHI
JL,E(CWR#Hc?V@N4Z]QEMUb,d[/][g.aD9N39V\4N;L\V\GfOOFd3\c<.Sdba&3A
\U(^DQ4]HM1]a[\(7904RN]7RLM:2=f#F?:<UZ\=<_;2(LQd6PTc;/TTd\JbVSCL
(XaH=P\M6P+WC#>9gTA_BNFBVc5BK2Q4+0g[C0dMTRbA#?@3A,K_bEU6WR.Z=dWN
9R\^0Gb:_SLMFeU@10^L6GD&fP#N64I:(7;[-LYHWd]PR7aBX_=-_SXMfGZ7IcF^
)-Q;\8[=13+PXTP4I>c2EC[[U-U]K?bQAa_RHZ<dOL70Ae[S\CY.UN439_C@N89U
3C?gSeaTe7&YK(?R0V?39\7J:XAd8a26U_Q?7(<EQTdFZSa1F(_/.d/U.bG:\T@?
;ga4=\Sd1;T,8@P:8C;a_(+WW&@@-,TM:Y>;#6,AS?+fD&V;D0eW3AQQR]K/0ZF8
V7SeU,Uf7a]/ID3B<bERFF?I.Q/0K13LKO&7T^=FBEMV8E,D0X5Y9[5YKI.<Z/][
,f,E/Q72&P<e;>8HWX,(YfX?Y_MRD+_J/5G&Pfd+fV(8NbYP_YDMKgV?1^@<?@\3
;d[eS[ZK)dQ@R>U+&T#K(C6B)9&EDZ.&B0PV-&>BDV4X7+5QRg]9d?X9<P1I:e8b
Q-^/e0Yg+_B9gZX@J&H(]f87=#Z9OZ;a]J/]N)((F0++Y=1.@>33c&\:#;?/F2XU
1:2IMV&(#8T_DC-VB.G,+?3CXOe(d344.ePDG8b9ZR38.P#@JKL-B(20aP823V@J
WFS5#Xg2342b#DL?Mc[Y.f)B<^\?TDE+?L-0]Ige?Ca-]#LeST&86,.&N#867G?4
C98\;/1HDNH_f]MeXA].2[eeFUX,OIC(DC=_PPH73<?XKG>6g3?)R^D^(]@^[dOR
@_L\Y[67Qf>XP[1#/CD+Q_E1:82,Pc<Q(H:_S)^_Uf=9O456?\c.-LUFI=#JH:?G
.&@H64<(X;1ce)O3HET34WaNcG90R.H.W:D]-+1NG&f[e=SX@g^e\Bg^904YcB)c
9/+L0Z.R;EPC8FfP6<G;2a<-7]]Q8++T4)Yd6&E([,22Y8B\a]@4e>+L6[K2.RB<
ODfIN8Q[[L,C0$
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
