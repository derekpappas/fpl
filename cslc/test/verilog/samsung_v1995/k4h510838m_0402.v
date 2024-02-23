 /*==============================================================================================================
 * Copyright(c) Samsung Electronics Co., 1997,1998,1999.  All rights reseved.
 *
 * Verilog Behavioral Model of DDR(Double Data Rate) Synchronous DRAM 
 *
 * Device: -  64M DDR SDRAM
 *	   - 128M DDR SDRAM
 *	   - 256M DDR SDRAM
 *	   - 512M DDR SDRAM
 *	   -   1G DDR SDRAM
 *                                                              
 * Description: This is a DDR synchrounous high data rate DRAM,
 *              fabricated with SAMSUNG's high performance  
 *              CMOS technology.                                
 *
 * Author 	: Jae-Ha Kim.
 *  		  CAE Group. Semiconductor R&D Centor.
 *		  Semiconductor Division. Samsung Electronics Co.
 * Revision     : Yong-Cheol Bae.
 * (1'st) 	  DRAM2 Design. Semiconductor R&D Centor.
 *		  Semiconductor Division. Samsung Electronics Co.
 * Revision 	: Geun-Hee Cho.
 * (2'nd~5'th)	  DRAM1 Design. Semiconductor R&D Centor.
 *		  Semiconductor Division. Samsung Electronics Co.
 * Revision 	: Tae-Jin Yoo.
 * (6'th~)	  DRAM1 Design. Semiconductor R&D Centor.
 *		  Semiconductor Division. Samsung Electronics Co.
 *===============================================================================================================
 * Revision No. : 00
 * date		: Jun. 1997   - First version
 * Revision No. : 01
 * date		: Mar. 1998   - added /QFC function
 * Revision No. : 02
 * date		: Apr. 1999   - tWR(old name:tRDL) = 2CLK
 * Revision No. : 03
 * date		: Sep. 1999   - added Warning message "Illegal command" to satisfy tCDLR parameter
 *                            - You can simulate with Verilog-XL compiler or VCS compiler, and the result is same.
 *                              Also, there is no difference between +turbo and +turbo+3 option in Verilog-XL.
 * Revision No. : 04
 * date		: Nov. 1999   - modified QFC function and added AC parameter of QFC
 * Revision No. : 05
 * date		: Feb. 2000   - modified nCOL(number of column address) definition according to Density and Bit organization
 *
 ****************************************************************************************************************************
 * Revision Number format is changed. The first number in new format indicates major change, and the second does minor change.
 ****************************************************************************************************************************
 *
 * Revision No. : 5.1
 * date		: Mar. 2000   - modified "EMRS" entering address from 'addr[13]' to 'ba[0]'
 * Revision No. : 5.2
 * date		: May. 2000   - "DLL_RESET" is enabled when EMRS(DLL ON) command is issued at power-up sequence. 
 * Revision No. : 06
 * date         : Sep. 2001   - modified Power-Up Sequence description coding
 *                            - added DLLOFF-mode function
 *                            - modified CL1.5 read-g1-read, CL3 read-g2-read coding (DQS preamble bug)
 *                            - modified multi-bank write-write-precharge coding (write address bug)
 * Revision No. : 6.1 
 * date         : Oct. 2001   - modified write-precharge-write BL8 pattern coding (com3_05_a8/b8)
 *                            - modified read-read-read BL4 pattern coding (com3_10_a4)
 *                            - modified 'ifdef' statement & A10
 *                            - disabled qfc function (internally)
 * Revision No. : 6.2 
 * date         : Nov. 2001   - inserted Low-Voltage Mobile DDR Function (Normal/Mobile Option)
 *
 * Revision No. : 6.3 
 * date         : Feb. 2002   - modified BL2 WRITE_MODE disable timing for 'write-int-write(ap)' operation @133MHz
 *                            - modified initial value of TRAS_PP[1] & TPRE_P[i] for VCS simulation 
 *
 * Revision No. : 6.4 
 * date         : Apr. 2002   - Spec has been updated 
 *                            - inserted 1G DDR & Moblie DDR Spec.
 *
 * Revision No. : 6.5 
 * date         : Dec. 2002   - modified self_refresh/auto_refresh/power_down operation(delate meaningless warnings)
 *			      - modified Mobile DDR MRS/EMRS operation
 *			      - apply real tSAC @DLLOFF ( before(~Rev6.4): tSAC = 1/2 CLK )
 *                            - inserted DDR333, DDR400 Spec.
 * Revision No. : 7.0 
 * date         : Jan. 2004   - modified write with autoprecharge operation (tWR delay : time base)
 *===============================================================================================================
 */

 /* Note : This Verilog DDR Model is an united model.
  *        So, You have to choose a density, bit organization and speed binning.
  *        Refer to the ReadMe file.
  */


`timescale    1ns / 10ps
//`timescale    1ns / 1ps
 

  `define K1			1024
  `define M1			1048576
  `define BYTE			8


`ifdef LP			// Low-Power
  `define MOBILE		// Mobile DDR
`else
  `define NORMAL		// Normal DDR
`endif

`ifdef M1024
  `ifdef BANK8
     `define M1024_8BANK
  `endif
`endif

`ifdef NORMAL
`ifdef M128             // Rev. 0.6 June  '99
`ifdef SCC 		// 200MHz(400Mbps)@CL=3
    `define tRC         55      // Row cycle time(min)
    `define tRFC        70      // Row cycle time(min)
    `define tRASmin 	40      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	15      // Ras to cas delay(min)
    `define tRP         15      // Row precharge time(min)
    `define tRRD    	10      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	6      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	6     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.6     // Input setup time (old tSS)
    `define tIH         0.6     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SC4 		// 200MHz(400Mbps)@CL=3
    `define tRC         60      // Row cycle time(min)
    `define tRFC        70      // Row cycle time(min)
    `define tRASmin 	40      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD    	10      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	6      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	6     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.6     // Input setup time (old tSS)
    `define tIH         0.6     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SAA 		// 133MHz(266Mbps)@CL=2   AA
    `define tRC         60      // Row cycle time(min)
    `define tRFC        75      // Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	15      // Ras to cas delay(min)
    `define tRP         15      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.9     // Input setup time (old tSS)
    `define tIH         0.9     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.75	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB3               // 166MHz(333Mbps)@CL=2.5
    `define tRC         60      // Row cycle time(min)
    `define tRFC        72      // Row cycle time(min)
    `define tRASmin     42      // Row active minimum time
    `define tRASmax     70000  // Row active maximum time
    `define tRCD        18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD        12      // Row to row delay(min)
    `define tCCD        1       // Col. address to col. address delay: 1 clk
    `define tCKmin      6     // Clock minimum cycle time
    `define tCKmax      12      // Clock maximun cycle time
    `define tCK15       7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2        7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25       6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3        6     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45    // Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55    // Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45    // Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55    // Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.75     // Input setup time (old tSS)
    `define tIH         0.75     // Input hold time (old tSH)
//  `define tSHZ                // Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns)
//  `define tRDL                // Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR               // Last data in to Read delay : 1 clk
//  `define tCDLW               // Last data in to Write delay : 0 clk
//  `define tMRD                // Mode register set cycle time : 2 clk
//  `define tDQSSmin            // CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax            // CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ                // tSLZ is 1clk
    `define tDS         0.45    // Data in & DQM set-up time
    `define tDH         0.45    // Data in & DQM hold time
    `define tDQSH       0.6     // DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL       0.6     // DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC        1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX       10      // Power Down exit Time
    `define tSREX       200     // Self refresh exit time : 200 clk
    `define tHZQ        0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK      0.6     // DQS out edge to clock edge (min:-0.6, max:+0.6)
//  `define tDQCK       0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ       0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA2 		// 133MHz(266Mbps)@CL=2
    `define tRC         65      // Row cycle time(min)
    `define tRFC        75      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS out edge to clock edge (min:-0.75, max:+0.75)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB0 		// 133MHz(266Mbps)@CL=2.5
    `define tRC         65      // Row cycle time(min)
    `define tRFC        75      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//  `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS out edge to clock edge (min:-0.75, max:+0.75)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA0 		// 100Mhz(200Mbps)@CL=2
    `define tRC         70      // Row cycle time(min)
    `define tRFC        80      // Refresh Row cycle time(min)
    `define tRASmin 	48      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	20      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	10       // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	10       // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	10       // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk) 
//  `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.6	// Data in & DQM set-up time
    `define tDH		0.6	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.8     // Data out high impedance time from CK/CKB (min:-0.8, max:+0.8)
    `define tDQSCK	0.8	// DQS out edge to clock edge	
//  `define tDQCK	1       // tDQCK changed following tAC
    `define tAC  	0.8     // Output data access time from CK/CKB (min:-0.8, max:+0.8)
    `define tDQSCK	0.8	// DQS out edge to clock edge (min:-0.8, max:+0.8)	
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.6, max:+0.6)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCHWI      1.5      // QFC hold time on writes (            max:1.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif
`endif

`ifdef M256             // Rev. 0.4 July 1. '99
`ifdef SCC 		// 200MHz(400Mbps)@CL=3
    `define tRC         55      // Row cycle time(min)
    `define tRFC        70      // Row cycle time(min)
    `define tRASmin 	40      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	15      // Ras to cas delay(min)
    `define tRP         15      // Row precharge time(min)
    `define tRRD    	10      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	6      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	6     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.6     // Input setup time (old tSS)
    `define tIH         0.6     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SC4 		// 200MHz(400Mbps)@CL=3
    `define tRC         60      // Row cycle time(min)
    `define tRFC        70      // Row cycle time(min)
    `define tRASmin 	40      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD    	10      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	6      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	6     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.6     // Input setup time (old tSS)
    `define tIH         0.6     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SAA 		// 133MHz(266Mbps)@CL=2   AA
    `define tRC         60      // Row cycle time(min)
    `define tRFC        75      // Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	15      // Ras to cas delay(min)
    `define tRP         15      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.9     // Input setup time (old tSS)
    `define tIH         0.9     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.75	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB3 		// 166MHz(333Mbps)@CL=2.5
    `define tRC         60      // Row cycle time(min)
    `define tRFC        72      // Row cycle time(min)
    `define tRASmin 	42      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD    	12      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	6     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	6     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.75     // Input setup time (old tSS)
    `define tIH         0.75     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA2 		// 133MHz(266Mbps)@CL=2
    `define tRC         65      // Row cycle time(min)
    `define tRFC        75      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS-out eccess time from CK/CKB (min:-0.75, max:+0.75)
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC  	0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB0 		// 133MHz(266Mbps)@CL=2.5
    `define tRC         65      // Row cycle time(min)
    `define tRFC        75      // Refresh Row cycle time(min)
    `define tRASmin 	48      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out active to High-Z (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS out edge to clock edge	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA0 		// 100MHz(200Mbps)@CL=2
    `define tRC         70      // Row cycle time(min)
    `define tRFC        80      // Refresh Row cycle time(min)
    `define tRASmin 	48      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	20      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	10       // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	10       // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	10       // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 1.5 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1.5 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk) 
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.6	// Data in & DQM set-up time
    `define tDH		0.6	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1
    `define tDSC	1
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.8     // Data out active to High-Z (min:-0.8, max:+0.8)
    `define tDQSCK	1	// DQS out edge to clock edge	
//  `define tDQCK	1       // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.8     // Output data access time from CK/CKB (min:-0.8, max:+0.8)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.6, max:+0.6)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif
`endif

`ifdef M512             // Rev. 0.4 July 1. '99
`ifdef SCC 		// 200MHz(400Mbps)@CL=3
    `define tRC         55      // Row cycle time(min)
    `define tRFC        70      // Row cycle time(min)
    `define tRASmin 	40      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	15      // Ras to cas delay(min)
    `define tRP         15      // Row precharge time(min)
    `define tRRD    	10      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	6      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	6     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.6     // Input setup time (old tSS)
    `define tIH         0.6     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SC4 		// 200MHz(400Mbps)@CL=3
    `define tRC         60      // Row cycle time(min)
    `define tRFC        70      // Row cycle time(min)
    `define tRASmin 	40      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD    	10      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	6      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	6     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.6     // Input setup time (old tSS)
    `define tIH         0.6     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB3 		// 166MHz(333Mbps)@CL=2.5
    `define tRC         60      // Row cycle time(min)
    `define tRFC        72      // Row cycle time(min)
    `define tRASmin 	42      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD    	12      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	6     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	6     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.75     // Input setup time (old tSS)
    `define tIH         0.75     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SAA 		// 133MHz(266Mbps)@CL=2   AA
    `define tRC         60      // Row cycle time(min)
    `define tRFC        75      // Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	15      // Ras to cas delay(min)
    `define tRP         15      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.9     // Input setup time (old tSS)
    `define tIH         0.9     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.75	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA2 		// 133MHz(266Mbps)@CL=2
    `define tRC         65      // Row cycle time(min)
    `define tRFC        75      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS-out eccess time from CK/CKB (min:-0.75, max:+0.75)
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC  	0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB0 		// 133MHz(266Mbps)@CL=2.5
    `define tRC         65      // Row cycle time(min)
    `define tRFC        75      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out active to High-Z (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS out edge to clock edge	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA0 		// 100MHz(200Mbps)@CL=2
    `define tRC         70      // Row cycle time(min)
    `define tRFC        80      // Refresh Row cycle time(min)
    `define tRASmin 	48      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	20      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	10       // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	10       // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	10       // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 1.5 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1.5 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk) 
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.6	// Data in & DQM set-up time
    `define tDH		0.6	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1
    `define tDSC	1
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.8     // Data out active to High-Z (min:-0.8, max:+0.8)
    `define tDQSCK	1	// DQS out edge to clock edge	
//  `define tDQCK	1       // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.8     // Output data access time from CK/CKB (min:-0.8, max:+0.8)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.6, max:+0.6)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif
`endif

`ifdef M1024             // Rev. 0.4 July 1. '99
`ifdef SB3 		// 166MHz(333Mbps)@CL=2.5
    `define tRC         60      // Row cycle time(min)
    `define tRFC        72      // Row cycle time(min)
    `define tRASmin 	42      // Row active minimum time
    `define tRASmax 	70000  // Row active maximum time
    `define tRCD    	18      // Ras to cas delay(min)
    `define tRP         18      // Row precharge time(min)
    `define tRRD    	12      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	6     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	7.5      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	6     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	6     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.75     // Input setup time (old tSS)
    `define tIH         0.75     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR		15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.45	// Data in & DQM set-up time
    `define tDH		0.45	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC	1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.7    // Data out high impedance time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSCK	0.6	// DQS out edge to clock edge (min:-0.6, max:+0.6)	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.7    // Output data access time from CK/CKB (min:-0.7, max:+0.7)
    `define tDQSQ	0     // Data strobe edge to output data edge (min:-0.45, max:+0.45)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA2 		// 133MHz(266Mbps)@CL=2
    `define tRC         65      // Row cycle time(min)
    `define tRFC        115      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	7.5     // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.9     // Input setup time (old tSS)
    `define tIH         0.9     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.35tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.35tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	7.5	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out high impedance time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS-out eccess time from CK/CKB (min:-0.75, max:+0.75)
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC  	0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SB0 		// 133MHz(266Mbps)@CL=2.5
    `define tRC         65      // Row cycle time(min)
    `define tRFC        115      // Refresh Row cycle time(min)
    `define tRASmin 	45      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	7.5     // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	7.5     // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         0.9     // Input setup time (old tSS)
    `define tIH         0.9     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 2 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk)
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.5	// Data in & DQM set-up time
    `define tDH		0.5	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1       // DQS-in cycle time, tSIC changed following tDSC
    `define tDSC        1       // DQS-in cycle time  (min:0.9, max:1.1)
    `define tPDEX	7.5	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.75    // Data out active to High-Z (min:-0.75, max:+0.75)
    `define tDQSCK	0.75	// DQS out edge to clock edge	
//  `define tDQCK	0.75    // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.75    // Output data access time from CK/CKB (min:-0.75, max:+0.75)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.5, max:+0.5)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif

`ifdef SA0 		// 100MHz(200Mbps)@CL=2
    `define tRC         70      // Row cycle time(min)
    `define tRFC        120      // Refresh Refresh Row cycle time(min)
    `define tRASmin 	48      // Row active minimum time
    `define tRASmax 	120000  // Row active maximum time
    `define tRCD    	20      // Ras to cas delay(min)
    `define tRP         20      // Row precharge time(min)
    `define tRRD    	15      // Row to row delay(min)
    `define tCCD     	1       // Col. address to col. address delay: 1 clk
    `define tCKmin  	10       // Clock minimum cycle time
    `define tCKmax  	12    	// Clock maximun cycle time
    `define tCK15    	10      // Clock minimun cycle time at cas latency=1.5
    `define tCK2    	10      // Clock minimun cycle time at cas latency=2
    `define tCK25    	10       // Clock minimun cycle time at cas latency=2.5
    `define tCK3     	10       // Clock minimun cycle time at cas latency=2.5
    `define tCHmin      0.45  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCHmax      0.55  	// Clock high pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmin      0.45	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tCLmax      0.55 	// Clock low pulse width (min:0.45tCK, max:0.55tCK)
    `define tIS         1.1     // Input setup time (old tSS)
    `define tIH         1.1     // Input hold time (old tSH) 
//  `define tSHZ   		// Valid DQS to DQS Hi-Z Delay (tCK/2 +1ns) 
//  `define tRDL		// Last data in to Row precharge : 1.5 clk, tRDL changed following tWR
    `define tWR         15      // Write recovery time
//  `define tCDLR		// Last data in to Read delay : 1.5 clk	
//  `define tCDLW		// Last data in to Write delay : 0 clk
//  `define tMRD		// Mode register set cycle time : 2 clk
//  `define tDQSSmin	 	// CLK to valid DQS-in  (0.75 clk) 
//* `define tDQSSmax	 	// CLK to valid DQS-in  (1.25 clk)
//  `define tSLZ		// tSLZ is 1clk		
    `define tDS		0.6	// Data in & DQM set-up time
    `define tDH		0.6	// Data in & DQM hold time
    `define tDQSH	0.6	// DQS-in high level width (min:0.4tCK, max:0.6tCK)
    `define tDQSL	0.6	// DQS-in low level width (min:0.4tCK, max:0.6tCK)
//  `define tSIC	1
    `define tDSC	1
    `define tPDEX	10	// Power Down exit Time 
    `define tSREX	200	// Self refresh exit time : 200 clk
    `define tHZQ	0.8     // Data out active to High-Z (min:-0.8, max:+0.8)
    `define tDQSCK	1	// DQS out edge to clock edge	
//  `define tDQCK	1       // out data edge to clock edge, tDQCK changed following tAC
    `define tAC         0.8     // Output data access time from CK/CKB (min:-0.8, max:+0.8)
    `define tDQSQ	0	// Data strobe edge to output data edge (min:-0.6, max:+0.6)
    `define tQCSW       3.5       // Delay from the clock edge of write command to QFC out on writes (max:4ns)
    `define tQCHW       0.5      // QFC hold time on writes (min:1.25ns, max:0.5tCK)
    `define tQCH        0.4       // QFC hold time on reads (min:0.4tCK, max:0.6tCK)
    `define tQCS        0.9       // QFC setup time on reads (min:0.9tCK, max:1.1tCK)
`endif
`endif
`endif


module
ddr(clk, clkb, csb, cke, ba, ad, rasb, casb, web, dm, dqi, dqs, qfc);

`define tSAC        4

`ifdef M64
  `define TBITS			64*`M1			// Total bit
  `define nBank			4
  `define ADDRTOP		11			// Top address is A11

  `ifdef X4
    `define A10_LESS					// Top column address is less than A10
    `define B			4			// number of bit(x4)
    `define nCOL		10			// Top column address is CA9 (nCOL-1)
    `define PAGEDEPTH		1024
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X8
      
    `define A10_LESS					// Top column address is less than A10
    `define B			8			// number of bit(x8)
    `define nCOL		9			// Top column address is CA8 (nCOL-1)
    `define PAGEDEPTH		512
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X16
    `define A10_LESS					// Top column address is less than A10
    `define B			16			// number of bit(x16)
    `define nCOL		8			// Top column address is CA7 (nCOL-1)
    `define PAGEDEPTH		256
    `ifdef NORMAL
      `define nDM		2
      `define nDQS		2
    `endif
  `endif
`endif							// endif `ifdef M64


`ifdef M128
  `define TBITS			128*`M1
  `define nBank			4
  `define ADDRTOP		11

  `ifdef X4
    `define A10_MORE					// Top column address is more than A10
    `define B			4			// number of bit(x4)
    `define nCOL		11			// Top column address is CA11 (nCOL), because of A10
    `define PAGEDEPTH		2048
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X8
    `define A10_LESS					// Top column address is less than A10
    `define B			8			// number of bit(x8)
    `define nCOL		10			// Top column address is CA9 (nCOL-1)
    `define PAGEDEPTH		1024
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X16
    `define A10_LESS					// Top column address is less than A10
    `define B			16			// number of bit(x16)
    `define nCOL		9			// Top column address is CA8 (nCOL-1)
    `define PAGEDEPTH		512
    `ifdef NORMAL
      `define nDM		2
      `define nDQS		2
    `endif
  `endif
`endif							// endif `ifdef M128


`ifdef M256
  `define TBITS			256*`M1
  `define nBank			4
  `define ADDRTOP		12

  `ifdef X4
    `define A10_MORE					// Top column address is more than A10
    `define B			4			// number of bit(x4)
    `define nCOL		11			// Top column address is CA11 (nCOL), because of A10
    `define PAGEDEPTH		2048
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X8
    `define A10_LESS					// Top column address is less than A10
    `define B			8			// number of bit(x8)
    `define nCOL		10			// Top column address is CA9 (nCOL-1)
    `define PAGEDEPTH		1024
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X16
    `define A10_LESS					// Top column address is less than A10
    `define B			16			// number of bit(x16)
    `define nCOL		9			// Top column address is CA8 (nCOL-1)
    `define PAGEDEPTH		512
    `ifdef NORMAL
      `define nDM		2
      `define nDQS		2
    `endif
  `endif

`endif							// endif `ifdef M256


`ifdef M512
  `define TBITS			512*`M1
  `define nBank			4
  `define ADDRTOP		12

  `ifdef X4
    `define A10_MORE					// Top column address is more than A10
    `define B			4			// number of bit(x4)
    `define nCOL		12			// Top column address is CA12 (nCOL), because of A10
    `define PAGEDEPTH		4096
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X8
    `define A10_MORE					// Top column address is more than A10
    `define B			8			// number of bit(x8)
    `define nCOL		11			// Top column address is CA11 (nCOL), because of A10
    `define PAGEDEPTH		2048
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X16
    `define A10_LESS					// Top column address is less than A10
    `define B			16			// number of bit(x16)
    `define nCOL		10			// Top column address is CA9 (nCOL-1)
    `define PAGEDEPTH		1024
    `ifdef NORMAL
      `define nDM		2
      `define nDQS		2
    `endif
  `endif
`endif							// endif `ifdef M512


`ifdef M1024
  `define TBITS			1024*`M1
 `ifdef M1024_8BANK
  `define nBank			8
 `else
  `define nBank			4
 `endif
  `define ADDRTOP		13

  `ifdef X4
    `define A10_MORE					// Top column address is more than A10
    `define B			4			// number of bit(x4)
    `define nCOL		12			// Top column address is CA12 (nCOL), because of A10
    `define PAGEDEPTH		4096
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X8
    `define A10_MORE					// Top column address is more than A10
    `define B			8			// number of bit(x8)
    `define nCOL		11			// Top column address is CA11 (nCOL), because of A10
    `define PAGEDEPTH		2048
      `define nDM		1
      `define nDQS		1
  `endif

  `ifdef X16
    `define A10_LESS					// Top column address is less than A10
    `define B			16			// number of bit(x16)
    `define nCOL		10			// Top column address is CA9 (nCOL-1)
    `define PAGEDEPTH		1024
    `ifdef NORMAL
      `define nDM		2
      `define nDQS		2
    `endif
  `endif
`endif							// endif `ifdef M1024


  `define HB			`B/2
  `define BIT			`B-1:0
  `define BIT_C			`nCOL-1:0
  `define nWORD			`TBITS/`B/`nBank
  `define BIT_T			`nCOL+`ADDRTOP:0	// 0~nCOL-1(Column) + 0~ADDRTOP(Row)
  `define WORD			`nWORD-1:0
  
  inout   [`BIT]  dqi;
  input   [`nBank/2-1:0] ba;
  input   [`ADDRTOP:0]  ad;
  input   rasb,casb,web;
  input   clk,clkb,cke,csb;
  input   [`nDM-1:0] dm;
  inout   [`nDQS-1:0] dqs;
  output   qfc;
  reg      QFC;
  wire     qfc = QFC;
  
parameter       pwrup_time = 0, pwrup_check = 1;
//parameter       pwrup_time = 200000, pwrup_check = 1;


////`protect

wire     [`nBank/2 + `ADDRTOP : 0] addr;
assign addr = {ba, ad};

reg		[`BIT]	mem_a[`WORD];	// memory cell array of a bank
reg		[`BIT]	mem_b[`WORD];	// memory cell array of b bank
reg		[`BIT]	mem_c[`WORD];	// memory cell array of c bank
reg		[`BIT]	mem_d[`WORD];	// memory cell array of d bank

// $readmemh
//initial begin
//        $readmemh("a_bank_data",mem_a);
//        $readmemh("b_bank_data",mem_b);
//        $readmemh("c_bank_data",mem_c);
//        $readmemh("d_bank_data",mem_d);
//end

/*
initial begin
	$damem_declare("mem_a", `B-1, 0, `nWORD-1, 0);//Dynamic,
	$damem_declare("mem_b", `B-1, 0, `nWORD-1, 0);//Dynamic
	$damem_declare("mem_c", `B-1, 0, `nWORD-1, 0);//Dynamic
	$damem_declare("mem_d", `B-1, 0, `nWORD-1, 0);//Dynamic
end
*/


reg	[`BIT] 	t_dqi;
wire	[`BIT]	dqi = t_dqi;
reg 	[`nDQS-1:0] 	dqsi;
reg 	[`nDQS-1:0] 	dqsi_;
assign	dqs = dqsi;

reg 	[`BIT] 	dqo, t_dqo;	// output temp. register declaration
reg		[`ADDRTOP:0]	r_addr_[`nBank-1:0];
reg		[`ADDRTOP:0]	r_addr;
reg		[`BIT_C] c_addr;	// column address
reg		[`BIT_C] c_addr_delay;	// column address
reg		[`BIT_T] m_addr; 	// merge row and column address 
reg		[`BIT_T] m1_addr; 	// merge row and column address  psudeo
reg 	[`BIT]  dout_reg[`PAGEDEPTH:0];
reg 	[`BIT]  din_reg[`PAGEDEPTH:0];	// din register
/*
reg 	[`BIT]  din_rega[`PAGEDEPTH:0];	// din register for a bank
reg 	[`BIT]  din_regb[`PAGEDEPTH:0];	// din register for b bank
reg 	[`BIT]  din_regc[`PAGEDEPTH:0];	// din register for c bank
reg 	[`BIT]  din_regd[`PAGEDEPTH:0];	// din register for d bank
*/
reg 	[`BIT]  clk_dq;				
reg		ptr;

reg		[`BIT]	ZDATA;
reg		[7:0] 	ZBYTE;


// define mode dependency flag
`define INITIAL 0	// no bank precharge
`define TRUE    1
`define FALSE   0
`define HIGH    1
`define LOW     0

/*
 *-----------------------------------------------------
 *	We know the phase of external signal 
 *	by examining the state of its flag.
 *-----------------------------------------------------
 */

reg		r_bank_addr;				// row bank check flag	

reg		[`nBank/2-1:0] c_bank_addr;				// column bank check flag	
reg		[`nBank/2-1:0] c_bank_addr_delay;				// column bank check flag	
reg		[`nBank/2:0] prech_reg;		// precharge mode (addr[13:12] && addr[10])

reg		[`nBank-1:0] auto_flag;					
reg		burst_type,					// burst type flag
		auto_flagx,
		self_flag;					// auto & self refresh flag
integer	kill_bank;
integer	k;
reg		[`nBank-1:0] precharge_flag;			// precharge each bank check flag
reg		[1:0]	autoprech_reg;
reg		pwrup_done;
reg		[`nBank-1 : 0]	first_pre;
integer auto_cnt;
integer i;

`ifdef M64
	  wire	[5:0]	RFU = {addr[13:9], addr[7]}; 
`endif
`ifdef M128
	  wire	[5:0]	RFU = {addr[13:9], addr[7]}; 
`endif
`ifdef M256
	  wire	[6:0]	RFU = {addr[14:9], addr[7]}; 
`endif
`ifdef M512
	  wire	[6:0]	RFU = {addr[14:9], addr[7]}; 
`endif
`ifdef M1024
	  wire	[7:0]	RFU = {addr[15:9], addr[7]}; 
`endif


reg     [`nBank-1:0] Mode;                      // check mode dependency
reg     [`nBank-1:0] PRDL;
reg     [`nBank-1:0] IGNORE_RDL;
reg             reautoprecharge;
integer BL, WBL;                // burst length
real    CL;                     // cas latency(1.5, 2, 2.5)
real    CL_TMP;                 //  cas latency @ DLLOFF
real    CL_TMP2;

reg     write_event;
reg     autoprecharge_WIRevent;
reg     write_mode_flag;
reg     dqsi_flag;
reg     dqsi_flag_;
real    write_start;
real    tDSS_min, tDSS_max;

real    tSHZ;                   // clk to output in hi-Z
real    tSAC;                   // clk to valid output

event
        kkk,
        active,         // main operation of SDRAM
        modeset,
        emodeset,


        read,
        write,
        write_pre,
        write_mode,
        write_mode_del,
        write_task,
        flush_write,
        precharge,
        autoprecharge,
        autoprecharge_WIR,
        autoprecharge_write,
        autoprecharge_write_int,
        autoprecharge_write_int2,
        precharge_start,
        precharge_flag_kill,
        autorefresh,
        autostart,
        selfrefresh,
        selfexit,

	rdl_start;

// initialize each flag

initial
        begin
                for (i = 0; i < `nDQS; i = i + 1)
                  dqsi[i]  = 1'bz;

                for (i = 0; i < `nBank; i = i + 1)
                  auto_flag[i]  = `FALSE;

                auto_flagx =            `FALSE;
                reautoprecharge =       `FALSE;
                self_flag  =            `FALSE;
                write_event =           `FALSE;
                autoprecharge_WIRevent = `FALSE;
                write_mode_flag =       `FALSE;
                pwrup_done =            `FALSE;
                dqsi_flag =             `FALSE;
                dqsi_flag_ =             `FALSE;
                Mode = `nBank'b0;
                PRDL = `nBank'b0;
                IGNORE_RDL = `nBank'b0;

                for(i = 0; i < `nBank; i = i + 1)
                begin
                        first_pre[i]  = `TRUE;
                        precharge_flag[i] = `FALSE;
                end

                ZBYTE = 8'bz;
            for (i = 0; i < `B; i = i + 1) begin
                        ZDATA[i] = 1'bz;
                end
        end

//--------------------------------------------------------------
//---------    TIMING VIOLATION CHECK ROUTINE
//--------------------------------------------------------------

real  CUR_TIME, TCKE, TADDR, TRASB, TCASB, TCSB, TWEB, TDQI, TCLK_H, TCLK_L,
          TCC_P, pclk_high, last_read, last_rw, burst_time, write_burst;
real  DQS_TIME, WRITE_TIME, READ_TIME;

reg [63:0] TDQS[`nDQS-1:0];
reg [63:0] TDM[`nDM-1:0];

//real  TRAS_P, TCAS_P, TRASA_P, TRASB_P, TPREA_P, TPREB_P, TSELF, TSEXIT;
// 4 bank
real  TRAS_P, TCAS_P, TSELF, TSEXIT;
real  TSELF_TCCP;
real  TDQSI, TDQSI_H, TDQSI_L;

reg  [63:0] TRAS_PP [`nBank-1:0];
reg  [63:0] TPRE_P  [`nBank-1:0];

reg   CKE_FLAG, CSB_FLAG, RASB_FLAG, CASB_FLAG, WEB_FLAG;

reg   MRS_SET, WRITE_MODE, READ_MODE, READ_MODE2, UNMODE, POWERDOWN_MODE,
           AUTOREF_MODE, SELFREF_MODE;
reg   EMRS_SET, QFC_ENABLE, DIC_WEAK, DIC_NORMAL, DLL_ON, DLL_RESET, DLL_RESET_DONE;
reg   MRS_ING;
reg   PWR, INIT;
reg   [`nBank-1:0] BANK_ID_INT;
reg   [`nBank-1:0] BANK_ID_READ;
reg   [`nBank-1:0] BANK_ID_WRITE;


`define NOP   (RASB_FLAG == `HIGH && CASB_FLAG == `HIGH && WEB_FLAG == `HIGH)
`define NOP1  (RASB_FLAG == `HIGH && CASB_FLAG == `HIGH)


/*
 *-----------------------------------------------------
 *	 wire declaration 
 *-----------------------------------------------------
 */

reg      pcke;
reg [`nDM-1:0] dm_delay;
reg [`nDM-1:0] dm_r;
reg [`nDM-1:0] dm_ri;

//reg      QFCB;
reg      data_read;
reg      data_read_;
reg      tdata_read;
reg      data_write;
reg      dqsi_delay;
reg      write_int_write;
reg [`BIT] clkh_dq;
reg [2:0]  prev_com;
reg          rw_dm;
reg        gapless;
wire     pclk = pcke & clk;

wire [2:0] com = {RASB_FLAG, CASB_FLAG, WEB_FLAG};

always @(posedge pclk) begin
    pclk_high <= #0.01 $realtime;
    clkh_dq <= #0.01 dqi;
end

always @(READ_MODE) begin		//  for tSAC delay @DLLOFF
        if (READ_MODE == 1'b1) begin // for VCS
	    if (DLL_ON == `TRUE) begin
                data_read  <= #((CL-1)*TCC_P-0.51) 1'b1;
                data_read_  <= #((CL-1)*TCC_P-0.51) 1'b1;
                dqsi_delay  <= #(CL*TCC_P-0.01)  1'b1;
	    end
	    else begin
		if(CL >= CL_TMP) begin
                data_read_  <= #((CL_TMP-1)*TCC_P-0.51) 1'b1;
                dqsi_delay  <= #(CL_TMP*TCC_P-0.01)  1'b1;
		end

		else begin
		data_read_  <= #((CL-1)*TCC_P-0.51) 1'b1;
                dqsi_delay  <= #((CL_TMP-0.5)*TCC_P-0.01)  1'b1;
		end
	    end
        end
        else begin
	    if (DLL_ON == `TRUE) begin
                data_read  <= #((CL-1)*TCC_P-0.51) 1'b0;
                data_read_  <= #((CL-1)*TCC_P-0.51) 1'b0;
                dqsi_delay  <= #(CL*TCC_P-0.01)  1'b0;
	    end
	    else begin
		if(CL >= CL_TMP) begin
                data_read_  <= #((CL_TMP-1)*TCC_P-0.51) 1'b0;
                dqsi_delay  <= #(CL_TMP*TCC_P-0.01)  1'b0;
		end
		else begin
		data_read_  <= #((CL-1)*TCC_P-0.51) 1'b0;
                dqsi_delay  <= #((CL_TMP-0.5)*TCC_P-0.01)  1'b0;
		end

	    end
        end
        burst_time <= #(CL*TCC_P-0.1) $realtime;
end

always @(data_read_) begin
	if (DLL_ON == `FALSE)
		if(CL >= CL_TMP)
		data_read <= #((CL-CL_TMP)*TCC_P) data_read_;
		else
		data_read <= #((CL_TMP-CL)*TCC_P-0.5) data_read_;
end

always @(t_dqo or READ_MODE)
begin : dqo_block
        if(READ_MODE) begin
                dqo <= #((CL-1)*TCC_P) t_dqo;
	end
        else begin
                dqo <= #((CL-1)*TCC_P) `B'bz;
	end
end


always @(dqo or data_read)
begin : tdqi_block
        if(data_read_) begin
                t_dqi <= #(TCC_P+`tDQSQ) dqo;  // tSAC para adjust, for Edge aligned DQ

	end
        else begin
                t_dqi <= #(TCC_P+`tDQSQ) `B'bz;  // tSAC para adjust
	end
end


always @(negedge tdata_read) begin
	data_read = tdata_read;
	tdata_read = `TRUE;
end

always @(posedge write_int_write) begin
		 #(0.7*TCC_P) disable write_block;
      -> kkk;

end

always @(write_pre) begin
		@(posedge dqs)
		write_event <= 1; // for VCS
		write_event <= #0.1 0;
		data_write = `TRUE;
end

//dqsi operation

always @(posedge data_read) begin
	for (i = 0; i < `nDQS; i = i + 1) begin
		if (dqsi[i] === 1'bz) begin
			dqsi[i]  <= `FALSE;
		        dqsi_flag <= `FALSE;
		end
	end
end


always @(posedge dqsi_delay) begin
        if (READ_MODE2 == `TRUE && READ_MODE == `FALSE)
	    READ_MODE2 = `FALSE;
       end


always @(negedge dqsi_delay) begin	// read-1gap-read preamble
        for (i = 0; i < `nDQS; i = i + 1) begin
            if (data_read == `FALSE && DLL_ON == `TRUE)
                dqsi[i]  <= #0.01 1'bz;
            else if (data_read_ ==`FALSE && DLL_ON == `FALSE) begin
		if (CL >= CL_TMP)
                dqsi[i]  <= #((CL-CL_TMP)*TCC_P+0.01) 1'bz;
		else	// @Low frequency
                dqsi[i]  <= #(`tSAC) 1'bz;
	    end
	end
end

always @(clk) begin  // tSAC para adjust
        if ( dqsi_delay ) begin

                if ( dqsi_flag ) begin
                        for (i = 0; i < `nDQS; i = i + 1)
                                dqsi_[i]  <= `FALSE;
                        dqsi_flag_ <= `FALSE;
                end

                else if ( ~dqsi_flag ) begin
                        for (i = 0; i < `nDQS; i = i + 1)
                                dqsi_[i]  <= `TRUE;
                        dqsi_flag_ <= `TRUE;
                end
        end
end


always @(dqsi_flag_) begin  // create dqsi_flag_, dqsi_[i] : tSAC delay @DLLOFF 
 if ( DLL_ON == `TRUE ) begin
     dqsi_flag = dqsi_flag_;
   for (i = 0; i < `nDQS; i = i + 1)
     dqsi[i]  <= dqsi_[i];
 end
 else begin
    if(CL >= CL_TMP) begin
        dqsi_flag <= #((CL-CL_TMP)*TCC_P) dqsi_flag_;
      for (i = 0; i < `nDQS; i = i + 1)
        dqsi[i]  <= #((CL-CL_TMP)*TCC_P) dqsi_[i];
    end
    else begin
        dqsi_flag <= #(`tSAC) dqsi_flag_;
      for (i = 0; i < `nDQS; i = i + 1)
        dqsi[i]  <= #(`tSAC) dqsi_[i];
    end
 end
end


/*
 *-----------------------------------------------------
 * setup hold check	
 *-----------------------------------------------------
 */

initial #0.01 pcke = cke;

initial  // time variables initialization
	begin
		$timeformat(-9, 1, " ns", 10);
		QFC = 1'bz;
		TDQSI = 0;
		TDQSI_H = 0;
		TDQSI_L = 0;
		TCKE = 0;
		TADDR = 0;
		TRASB = 0;
		TCASB = 0;
		TCSB = 0;
		TWEB = 0;
		TDQI = 0;
		TCLK_H = 0;
		TCLK_L = 0;
		TRAS_P = -200;
		TCAS_P = -200;
		TSELF   = -200;
		TSEXIT   = -4000;
		pclk_high = -20;
     		last_read = -200;
                burst_time = 0;
                write_burst = -200;
		last_rw = -20;
		write_start = 0;
		TCC_P = 1;
	        CL = 2;
	        CL_TMP = 2;
	        CL_TMP2 = 2;
		

		for (i = 0; i < `nDM; i = i + 1)
		  TDM[i] = 64'b0;
		for (i = 0; i < `nDQS; i = i + 1)
		  TDQS[i] = 64'b0;
		for (i = 0; i < `nBank; i = i + 1)
		  TRAS_PP[i] = -200;
//		  TRAS_PP[i] = 0;             // FOR vcs simulation, 020305
		for (i = 0; i < `nBank; i = i + 1)
		  TPRE_P[i] = -200;
//		  TPRE_P[i] = 0;              // FOR vcs simulation, 020305

	end

initial  // mode register variables initialization
	begin
		RASB_FLAG = `HIGH;
		CASB_FLAG = `HIGH;
		CSB_FLAG  = `HIGH;
		WEB_FLAG  = `HIGH;
		CKE_FLAG  = `HIGH;
	end

initial  // mode register variables initialization
	begin
		INIT        = `TRUE;
		MRS_SET     = `FALSE;
		MRS_ING     = `FALSE;
	     `ifdef NORMAL
		EMRS_SET    = `FALSE;
	     `endif
		QFC_ENABLE  = `FALSE;
		DIC_WEAK    = `FALSE;
	        DIC_NORMAL  = `FALSE;
		DLL_ON      = `FALSE;
		DLL_RESET   = `FALSE;
		DLL_RESET_DONE    = `FALSE;
		WRITE_MODE  = `FALSE;
		READ_MODE   = `FALSE;
		READ_MODE2  = `FALSE;
		data_read   = `FALSE;
		data_read_   = `FALSE;
		data_write  = `FALSE;
		dqsi_delay  = `FALSE;
		write_int_write  = `FALSE;
		POWERDOWN_MODE = `FALSE;
		AUTOREF_MODE   = `FALSE;
		SELFREF_MODE   = `FALSE;
	end

always @( posedge clk )
	if( PWR == `TRUE )
	begin : main
		CUR_TIME = $realtime;

		if( POWERDOWN_MODE == `FALSE && CKE_FLAG == `TRUE )
		begin
			if( SELFREF_MODE == `TRUE )
			  begin
				if( CUR_TIME - TSELF < `tRASmin )
				begin
				`ifdef delw
				`else
				  $display("%t (%m) Warning: tRAS violation in self refresh", CUR_TIME);
				`endif
				end
				->selfexit;
				if( CUR_TIME - TCKE >= `tIS && TCKE != 0 && CUR_TIME < TCKE + TCC_P)
				`ifdef delc
				`else
				$display("%t (%m) >> self refresh exit", CUR_TIME);
				`endif
				POWERDOWN_MODE = `FALSE;
				CKE_FLAG = `FALSE;
				#0 pcke = cke;
				
			end
			else
			begin
				if( CUR_TIME - TCKE >= `tIS && TCKE != 0 && CUR_TIME < TCKE + TCC_P)
				begin
					`ifdef delc
					`else
					$display("%t (%m) >> power down exit", CUR_TIME);
					`endif
					POWERDOWN_MODE = `FALSE;
					CKE_FLAG = `FALSE;
				    pcke <= repeat (1) @(negedge pclk)  cke; 
				end
				else if(CUR_TIME - TCKE < `tIS && |Mode == 1'b0)
				begin
					  `ifdef delw	
					  `else
					  $display("%t (%m) Warning: tIS Precharge Power Down Exit Setup Violation",CUR_TIME);
					  `endif
					disable main;
				end
			end
		end

		if( POWERDOWN_MODE == `FALSE)
		begin
			if( CUR_TIME - TCKE < `tIS )	// check cke setup timing
			begin
				`ifdef delw
				`else

				$display("%t (%m) Warning: CKE setup violation", CUR_TIME);
				`endif
			end
			else
				pcke <= @(negedge clk) cke;
		end
		CKE_FLAG = cke;

// clock timing check

			TCC_P = CUR_TIME - TCLK_H;  // saving current clock period

			// CLK shut down @self refresh
                        if( CUR_TIME - TCLK_H < `tCKmin && POWERDOWN_MODE == `FALSE )
			begin
				`ifdef delw
				`else
                                $display("%t (%m) Warning: tCKmin violation", CUR_TIME);
				`endif
			end
                        if( CUR_TIME - TCLK_H > `tCKmax && POWERDOWN_MODE == `FALSE )
			begin
				`ifdef delw
				`else
                                $display("%t (%m) Warning: tCKmax violation", CUR_TIME);
				`endif
			end


// pcke is high
		if( pcke ) begin

// csb timing check
			if( CUR_TIME - TCSB < `tIS )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: CSB setup violation", CUR_TIME);
				`endif
			end
			else  
				CSB_FLAG = csb;

// if chip selected
			if( CSB_FLAG == `LOW )
			begin
				if( CUR_TIME - TRASB < `tIS )
				begin
					`ifdef delw
					`else

					$display("%t (%m) Warning: RASB setup violation", CUR_TIME);
					`endif
				end
				else 
					RASB_FLAG = rasb;

				if( CUR_TIME - TCASB < `tIS )
				begin
					`ifdef delw
					`else

					$display("%t (%m) Warning: CASB setup violation", CUR_TIME);
					`endif
				end
				else 
					CASB_FLAG = casb;
					
				if( CUR_TIME - TWEB < `tIS )
				begin
					`ifdef delw
					`else

					$display("%t (%m) Warning: WEB setup violation", CUR_TIME);
					`endif
				end
				else 
					WEB_FLAG = web;

			end
			for (i = 0; i < `nDM; i = i + 1) begin
			  if( CUR_TIME - $bitstoreal(TDM[i]) < `tIS )
			  begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: DM(%d) setup violation", CUR_TIME,i);
				`endif
			  end
			  else begin
				dm_r[i] <= dm_ri[i];
				dm_ri[i] <= dm[i];
			  end
			end
		end

		TCLK_H = CUR_TIME; // the time clock is high

	end

/*------------------------------------------
 *       command recognition
 *------------------------------------------
 */

always @( posedge pclk )
	if( PWR == `TRUE )
	begin : command
		integer bank_id;
		reg		[8*8:1] str;

		if( CSB_FLAG == `LOW )
		begin : command_sel
			if( auto_cnt == -1 )
			begin
				if( ~ `NOP ) // NOP1 -> NOP because of burst stop
				begin
					`ifdef delw
					`else
					$display("%t (%m) Warning: NOP required during power-up pause time.",CUR_TIME);
					`endif
				end
				disable command_sel;
			end

			if( CUR_TIME - TADDR < `tIS )
				begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: Address setup violation", CUR_TIME);
				`endif
				end

			if( `NOP ) 	// deleted by burst stop -> NOP1 -> NOP
				disable command_sel;

			if( AUTOREF_MODE == `TRUE || SELFREF_MODE == `TRUE )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: Illegal command in refresh operation", CUR_TIME);
				`endif
				disable command_sel;
			end

			if( ~pwrup_done )

			  `ifdef NORMAL
				if( auto_cnt < 2 || ( DLL_ON == `TRUE && DLL_RESET_DONE == `FALSE ))
				begin
					case ( {RASB_FLAG,CASB_FLAG,WEB_FLAG} )
						'b010 :
							begin
							`ifdef M1024_8BANK
								  prech_reg[3] = ba[2];
							`endif
								  prech_reg[2] = ba[1];
								  prech_reg[1] = ba[0];
								  prech_reg[0] = addr[10];
								->precharge;
							end
						'b001 :
							if( cke )
								begin
									auto_cnt = auto_cnt + 1; 
									->autorefresh;
								end
						'b000 :
				                        begin
				                        if ( ba[0] == 1'b1 ) begin
					                        ->emodeset;
							      end
                    			                else if( EMRS_SET == `TRUE )
                        			                ->modeset;
                    			                else begin
								`ifdef delw
								`else
                        			                $display("%t (%m) Warning: MODE register set need 2 clock cycles", CUR_TIME);
								`endif
							end
				                        end			
					endcase
					disable command_sel;
				end
			  `endif	

				else 
					pwrup_done = `TRUE;

			case( {RASB_FLAG,CASB_FLAG,WEB_FLAG} )
			'b000 :      // MRS command 
			   `ifdef NORMAL
				begin
					if( EMRS_SET == `TRUE )
						->modeset;
					else begin
						`ifdef delw
						`else
						$display("%t (%m) Warning: MODE register set need 2 clock cycles", CUR_TIME);
						`endif
					end
				end
			   `endif

			'b011 :		// acitve
				begin
					if( EMRS_SET == `TRUE && ( DLL_ON == `FALSE || DLL_RESET_DONE == `TRUE ) && MRS_SET == `TRUE )
					begin
						bank_id = BankSelect(ba);
						str = PrintBank(ba);
						if(Mode[bank_id] == `TRUE)
						begin
							`ifdef delw
							`else
							$display("%t (%m) Warning: Illegal active (%0s is not precharged)",CUR_TIME,str);
							`endif
						end

						else
							->active;
					end

					else if( INIT == `FALSE )
					begin
						`ifdef delw
						`else
						$display("%t (%m) Warning: MODE register set need 2 clock cycles",CUR_TIME);
						`endif
					end
					else if( INIT == `TRUE )
					begin
						`ifdef delw
						`else
						$display("%t (%m) Warning: Initial MODE register set must be required before active",CUR_TIME);
						`endif
					end
				end
			'b101 :
				begin	// read command
					bank_id = BankSelect(ba);
					str = PrintBank(ba);
                                        gapless = (CUR_TIME == last_rw && auto_flag[bank_id]) ? `TRUE : `FALSE;
				if( Mode[bank_id] == `TRUE)
					begin
						if( READ_MODE == `TRUE)
						begin
							READ_MODE = `FALSE;
							#0 disable read_block;
						end
						if( WRITE_MODE == `TRUE || data_write == `TRUE || {RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b100)
						begin
							WRITE_MODE = `FALSE;
							for (i = 0; i < `nBank; i = i + 1)
							begin
							    if (auto_flag[i] == `TRUE) begin
			        	                        auto_flag[i] = `FALSE;
								autoprecharge_WIRevent <= `TRUE;
								autoprecharge_WIRevent <= #1 `FALSE;
                                                            end
                                                        end
						        data_write = `FALSE;
							disable write_block;
						end   
                                            last_read = CUR_TIME;
                                            prev_com <= #0.1 {RASB_FLAG,CASB_FLAG,WEB_FLAG};
                                            rw_dm <= `FALSE;
                                            READ_TIME = $realtime;
					    #0 ->read;
					end

					else begin
						`ifdef delw
						`else

						$display("%t (%m) Warning: Illegal read (%0s is not acitve)",CUR_TIME,str);
						`endif
					end
				end
			'b100 :
				begin	// write command
					bank_id = BankSelect(ba);
					str = PrintBank(ba);
                      if (prev_com == 3'b101) begin
                            if ( burst_time - write_burst < TCC_P )
			    begin
			    `ifdef delw
			    `else
                            $display("%t (%m) Warning: HIZ should be issued 1 cycle before write op ", CUR_TIME);
			    `endif
			    end
                      end
                            gapless = (pclk_high == last_rw && auto_flag[bank_id]) ? `TRUE : `FALSE;

				if( Mode[bank_id] == `TRUE)
					begin
						if( dqsi_delay == `TRUE )
						begin
							dqsi_delay = `FALSE;
							tdata_read <= @(posedge pclk) READ_MODE;
							#0 disable read_block;
						end

   				                write_start <= #0.01 $realtime;
                               		        WRITE_TIME = $realtime;

                        prev_com = {RASB_FLAG,CASB_FLAG,WEB_FLAG};
                        if (pclk_high == last_read)
                        rw_dm <= @(negedge pclk) `TRUE;


						if( WRITE_MODE == `TRUE ) 
						begin
							WRITE_MODE <= #0.1 `FALSE;
							write_int_write = `TRUE;
                                                	write_int_write <= #(TCC_P*0.5) `FALSE;
						      disable write_mode_block;  
						end 
						#0  ->write_mode;
						#(0.5*TCC_P);
						#0 -> write_pre;
                                                write_burst = $realtime;
					end
					else begin
						`ifdef delw
						`else
						$display("%t (%m) Warning: Illegal write ( %0s is not active)",CUR_TIME,str);
						`endif
					end
				
				end
			'b110 :  // burst stop
                begin    
					`ifdef delc
					`else
					$display ("%t (%m) Note: Burst stop",CUR_TIME);
					`endif


                    if( READ_MODE == `TRUE )
                    begin
			for (i = 0; i < `nBank; i = i + 1)
			     begin
		                 if (auto_flag[i] == `TRUE)
				    begin
			        	    auto_flag[i] = `FALSE;
						    #0 ->autoprecharge;
			          end
			      end
                        READ_MODE = `FALSE;
			`ifdef delc
			`else
                        $display("%t (%m) -- reading burst stop", CUR_TIME);
			`endif
                        disable read_block;
                    end

                    prev_com = {RASB_FLAG,CASB_FLAG,WEB_FLAG};
                end
			'b010 :   // precharge command
				begin
					if(auto_flagx == `TRUE && (addr[10] || ba == c_bank_addr))
					begin
						`ifdef delw
						`else
						$display("%t (%m) Warning: Illegal command in auto-precharge command",CUR_TIME);
						`endif
						disable command_sel;
					end
					`ifdef M1024_8BANK
					    prech_reg[3] = ba[2];
					`endif
					    prech_reg[2] = ba[1];
					    prech_reg[1] = ba[0];
					    prech_reg[0] = addr[10];
					->precharge;
				end
			'b001 : begin
				if( cke )
					->autorefresh;
				else if( ~cke )
					->selfrefresh;
			end
			endcase
		end  // command_sel

	end

`ifdef sim_vcs
// for VCS
always @(negedge WRITE_MODE) begin
if({RASB_FLAG,CASB_FLAG,WEB_FLAG} == 3'b100) begin
      WRITE_MODE = `TRUE;
      #0.1 WRITE_MODE = 0;
      write_int_write <= 1;
      write_int_write <= #(TCC_P*0.5) 0;
end
end
`endif

// power down enter mode
always @( posedge pclk )
	if( POWERDOWN_MODE == `FALSE && cke == `LOW && CUR_TIME - TCKE >= `tIS && MRS_SET == `TRUE)
	begin
		if( |Mode == 1'b0 )
		begin
		POWERDOWN_MODE = `TRUE;
                   if( CSB_FLAG == `TRUE)
		   begin
			`ifdef delc
			`else
                        $display("%t (%m) >> power down enter (precharge)",CUR_TIME);
			`endif
		   end
                end
		else if( |Mode != 1'b0 && CSB_FLAG == `TRUE)
		begin
			`ifdef delc
			`else
			$display("%t (%m) >> power down enter (active)",CUR_TIME);
			`endif
			POWERDOWN_MODE = `TRUE;
		end
	end


// clock low width duty check
always @( negedge clk )
        if( PWR == `TRUE && CUR_TIME > (2*TCC_P))
        begin
                CUR_TIME = $realtime;
                        if( CUR_TIME - TCLK_H < `tCHmin*TCC_P )
			begin
				`ifdef delw
				`else
                                $display("%t (%m) -- Warning -- tCHmin violation", CUR_TIME);
				`endif
			end
                        if( CUR_TIME - TCLK_H > `tCHmax*TCC_P )
			begin
				`ifdef delw
				`else
                                $display("%t (%m) -- Warning -- tCHmax violation", CUR_TIME);
				`endif
			end
                TCLK_L = CUR_TIME;
        end

always @(cke)
        begin
                CUR_TIME = $realtime;
                if( PWR == `TRUE )
                        if( POWERDOWN_MODE == `FALSE && CUR_TIME - TCLK_H < `tIH )
			begin
				`ifdef delw
				`else
                                $display("%t (%m) Warning: CKE hold violation", CUR_TIME);
				`endif
			end
			else if( cke == `FALSE )
                                CKE_FLAG = `FALSE;
                TCKE = CUR_TIME;
                if(cke == `TRUE) begin
                CKE_FLAG = `TRUE;
                #0.5 POWERDOWN_MODE = `FALSE;
		if(TCKE != 0)
                ->selfexit;
                end
        end


always @(addr) 
	begin
		CUR_TIME = $realtime;
		if( PWR == `TRUE && CSB_FLAG == `LOW && pcke == `HIGH )
			if( CUR_TIME - TCLK_H < `tIH )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: Address hold violation", CUR_TIME);
				`endif
			end
		TADDR = CUR_TIME;
	end

always @( negedge rasb or posedge rasb)
	begin
		CUR_TIME = $realtime;
		if( PWR == `TRUE && CSB_FLAG == `LOW )
			if( pcke == `HIGH && CUR_TIME - TCLK_H < `tIH )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: RASB hold violation", CUR_TIME);
				`endif
			end
		if(rasb)
			RASB_FLAG = `HIGH;
		TRASB = CUR_TIME;
	end

always @( negedge casb or posedge casb)
	begin
		CUR_TIME = $realtime;
		if( PWR == `TRUE && CSB_FLAG == `LOW )
			if( pcke == `HIGH && CUR_TIME - TCLK_H < `tIH )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: CASB hold violation", CUR_TIME);
				`endif
			end
		if(casb)
			CASB_FLAG = `HIGH;
		TCASB = CUR_TIME;
	end

always @( negedge csb or posedge csb)
	begin
		CUR_TIME = $realtime;
		if( csb )
			CSB_FLAG <= #(CUR_TIME - TCLK_H + `tIH) csb;
		if( PWR == `TRUE && pcke == `HIGH && CUR_TIME - TCLK_H < `tIH )
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: CSB hold violation", CUR_TIME);
			`endif
		end
		TCSB = CUR_TIME;
	end

always @( negedge web or posedge web)
	begin
		CUR_TIME = $realtime;
		if( PWR == `TRUE && CSB_FLAG == `LOW )
			if( pcke == `HIGH && CUR_TIME - TCLK_H < `tIH )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: WEB hold violation", CUR_TIME);
				`endif
			end
		if(web)
			WEB_FLAG = `HIGH;
		else
			WEB_FLAG = `LOW;  
		TWEB = CUR_TIME;
	end

always @(dqi)
	begin
		if( data_write )
		begin
			CUR_TIME = $realtime;
		     for(i = 0; i < `nDQS; i = i + 1) begin
			if( CUR_TIME - TDQSI < `tDH && dqs[i] !== 1'bz )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: DQi hold violation", CUR_TIME);
				`endif
			end
		     end
		end
		TDQI = $realtime;
	end

always @(dm) 
	begin
  		CUR_TIME = $realtime;
  		if (PWR == `TRUE)
			for (i = 0; i < `nDM; i = i + 1) begin
			  if (CUR_TIME - TDQSI < `tDH && pcke == `HIGH)
			  begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: DM(%d) hold violation",CUR_TIME, i);
				`endif
			  end
		end
		TDM[i] = $realtobits(CUR_TIME);
		dm_delay <= #(1*TCC_P) dm;
	end


always @(dqs)  // DDR write
        begin : write_check
        integer i;
                if(data_write)
                begin
                        TDQSI = $realtime;

                     for(i = 0; i < `nDQS; i = i +1) begin
                        if( TDQSI - TDQI < `tDS-0.01 && dqs[i] !== 1'bz )
			begin
			`ifdef delw
			`else
                        $display("%t (%m) Warning: DQi setup violation",CUR_TIME, TDQSI);
			`endif
			end
                     end

                        for (i = 0; i < 2; i = i + 1) begin
                                if (TDQSI - TDM[i] < `tDS)
				begin
					`ifdef delw
					`else
                                        $display("%t (%m) Warning: DM setup violation", CUR_TIME, TDQSI);
					`endif
				end
      
                        end

                        if( |dqs == 1'b1 ) 
                        begin
                                TDQSI_H = TDQSI;
                                if((TDQSI_H > write_start) && TDQSI_H - TDQSI_L < 0.4*`tDSC*TCC_P) begin
					`ifdef delw
					`else
                                        $display("%t (%m) Warning: tDSC violation", CUR_TIME, TDQSI_H);
					`endif
                                end
                        end

                        else if( &dqs == 1'b0 )
                                TDQSI_L = TDQSI;
                end
        end


/*
 *-----------------------------------------------------
 *	 power up check routine							
 *-----------------------------------------------------
 */

initial
	begin
		auto_cnt = -1;
		PWR = `FALSE;
		if(pwrup_check)
		fork
			@(posedge clk or negedge clk) PWR <= #0.01 `TRUE;
			begin
				#pwrup_time auto_cnt = 0;
				Mode = `nBank'b0; 
			end
		join
		else
		begin
			@(posedge clk or negedge clk);
			auto_cnt = 2;
			pwrup_done = `TRUE;
			EMRS_SET = `TRUE;
			DLL_RESET = `TRUE;
			DLL_RESET_DONE	= `TRUE;
			PWR <= #0 `TRUE;
			$display("%t (%m) -- power up check routine skipped",CUR_TIME);
		end
	end

`ifdef NORMAL
/*
 *-----------------------------------------------------
 *	 EMRS(extended mode register set) 
 *-----------------------------------------------------
 */

always	@(emodeset) begin
	EMRS_SET = `FALSE;
	if(addr[0] == 0) begin
	    DLL_ON	 = `TRUE;
	    `ifdef delc
	    `else
	    $display("%t (%m) >> Extended MRS(DLL-ON) enter" , CUR_TIME);
	    `endif
        end
	if(addr[0] == 1) begin
	    DLL_ON	 = `FALSE;
	    `ifdef delc
	    `else
	    $display("%t (%m) >> Extended MRS(DLL-OFF) enter" , CUR_TIME);
	    `endif
        end
        if(addr[1] == 1) begin
	    DIC_WEAK = `TRUE; // DIC : Driver Impedance Control
	    `ifdef delc
	    `else
	    $display("%t (%m) >> Driver Impedance Control is weak" , CUR_TIME);
	    `endif
	    end
	    else begin
	    DIC_NORMAL = `TRUE;
	    `ifdef delc
	    `else
	    $display("%t (%m) >> Driver Impedance Control is normal" , CUR_TIME);
	    `endif
	end
        EMRS_SET <= repeat (2) @(negedge pclk) `TRUE;
end
`endif


/*
 *-----------------------------------------------------
 *	 MRS(mode register set) 
 *-----------------------------------------------------
 */

always	@(modeset)
	begin : mrs_op

		if( &precharge_flag == 1'b1)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: Illegal command in precharge operation", CUR_TIME);
			`endif
			disable mrs_op;
		end

		if (|Mode == 1'b0)
		begin
			`ifdef delc
			`else
			$display("%t (%m) >> MODE register set", CUR_TIME);
			`endif
		end
		else
			begin 
				`ifdef delw
				`else
				$display("%t (%m) Warning: Illegal MRS command",CUR_TIME);
				`endif
				disable mrs_op;
			end


// mode initialization

		if (~|RFU && addr[8] == 1)
		begin
			DLL_RESET	= `FALSE;
			DLL_RESET_DONE	= `FALSE;
			DLL_RESET	<= repeat (2) @(negedge pclk) `TRUE;
			DLL_RESET_DONE	<= repeat (200) @(negedge pclk) `TRUE; //#((200-1)*TCC_P) `TRUE;
				`ifdef delc
				`else
				$display("%t (%m) >> DLL RESET enter" , CUR_TIME);
				`endif
		end

		else if (~|RFU && addr[8] == 0 )

			begin  // {
				case(addr[2:0]) // burst length programming
					3'b001:begin
						BL = 2;
						WBL = 2;
						`ifdef delc
						`else
						$display("%t (%m) -- burst length = 2",CUR_TIME);
						`endif
					end
					3'b010:begin
						BL = 4;
						WBL = 4;
						`ifdef delc
						`else
						$display("%t (%m) -- burst length = 4",CUR_TIME);
						`endif
					end
					3'b011:begin
						BL = 8;
						WBL = 8;
						`ifdef delc
						`else
						$display("%t (%m) -- burst length = 8",CUR_TIME);
						`endif
					end
					default: begin
						`ifdef delc
						`else
						$display("%t (%m) Warning: Invalid Burst length!",CUR_TIME);
						`endif
					end
				endcase
	
				if(addr[3] && BL != `PAGEDEPTH)		// burst type  programming
				begin
					burst_type = 1'b1;   
					`ifdef delc
					`else
					$display("%t (%m) -- burst type   = interleave.",CUR_TIME);
					`endif
				end
				else
				begin
					if ( addr[3] && BL == `PAGEDEPTH) begin   // 8.14
						`ifdef del2
						`else
						$display("%t (%m) Warning: interleave mode does not support Full page Mode",CUR_TIME);
						$display("%t (%m)          interleave mode will be changed to sequential mode",CUR_TIME);
						`endif
					end
					burst_type = 1'b0;
					`ifdef delc
					`else
					$display("%t (%m) -- burst type   = sequential.",CUR_TIME);
					`endif
				end

				if ( DLL_ON == `TRUE )
				begin		// DLL ON CAS Latency Definition
					case(addr[6:4])		// CAS latency programming
						3'b101:begin
						        CL=1.5;
							if( TCC_P < `tCK15 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=1.5",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 1.5",CUR_TIME);
						  `endif
							end
						end
						3'b010:begin
						        CL=2;
							if( TCC_P < `tCK2 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=2",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 2",CUR_TIME);
						  `endif
							end
						end
						3'b110:begin
						        CL=2.5;
							if( TCC_P < `tCK25 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=2.5",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 2.5",CUR_TIME);
						  `endif
							end
						end

			           		3'b011:begin
						        CL=3;
							if( TCC_P < `tCK3 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=3",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 3",CUR_TIME);
						  `endif
							end
						end

						default: begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: Invalid CAS latency!",CUR_TIME);
								`endif
							end
					endcase
				end

				else
				begin		// DLL OFF CAS Latency Definition
					case(addr[6:4])		// CAS latency programming

						3'b010:begin
						        CL = 1 + `tSAC/TCC_P;	// real latency delay @CL2
						        CL_TMP = 1.5;		// for dqsi_flag starting point
						        CL_TMP2 = 1;
							if( TCC_P < `tCK15 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=2",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 2",CUR_TIME);
						  `endif
							end
						end
					    `ifdef NORMAL   
						3'b110:begin
						        CL = 1.5 + `tSAC/TCC_P;	// real latency delay @CL25
						        CL_TMP = 2;		// for dqsi_flag starting point
						        CL_TMP2 = 1.5;
							if( TCC_P < `tCK2 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=2.5",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 2.5",CUR_TIME);
						  `endif
							end
						end
					    `endif

			           		3'b011:begin
						        CL = 2 + `tSAC/TCC_P;	// real latency delay @CL3
						        CL_TMP = 2.5;		// for dqsi_flag starting point
						        CL_TMP2 = 2;
							if( TCC_P < `tCK25 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=3",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 3",CUR_TIME);
						  `endif
							end
						end 

					    `ifdef NORMAL   
			           		3'b111:begin
						        CL=3;
							if( TCC_P < `tCK3 )
							begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: clock minimun cycle violation at cas latency=3.5",CUR_TIME);
								`endif
					       	  `ifdef delc
						  `else
						   $display("%t (%m) -- cas latency  = 3.5",CUR_TIME);
						  `endif
							end
						end 
					    `endif

						default: begin
								`ifdef delw
								`else
								$display("%t (%m) Warning: Invalid CAS latency!",CUR_TIME);
								`endif
							end
					endcase
				end
	
			MRS_SET    = `FALSE;
			MRS_SET	   <= repeat (2) @(negedge pclk)  `TRUE; 
			end 
			else
			begin
				`ifdef delw
				`else
				$display("%t (%m) -- reserved for future use !!",CUR_TIME);
				$display("%t (%m) -- check address: [13:9,7] = %b",CUR_TIME,RFU);
				`endif
			end

			MRS_ING    = `TRUE;
			MRS_ING	   <= repeat (2) @(negedge pclk)  `FALSE; 
	end

always @(TCC_P)
begin
   if(DLL_ON == `FALSE && MRS_SET == `TRUE) begin
       CL = CL_TMP2 + `tSAC/TCC_P;	// real latency delay @CL3
       CL_TMP = CL_TMP2+0.5;		// for dqsi_flag starting point
   end
end

/*
 *-----------------------------------------------------
 *	 ACTIVE command									
 *-----------------------------------------------------
 */

// In active command, bank is selected in accordance with A11 address.

always	@(active)
	begin : active_op
		integer bank_id, loop;
		reg		[8*8:1] str;

		if(CUR_TIME - TRAS_P < `tRRD)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tRRD violation", CUR_TIME);
			`endif
			disable active_op;
		end

		r_bank_addr = ba;

		bank_id = BankSelect(ba);
		str = PrintBank(ba);

			if(CUR_TIME - $bitstoreal(TPRE_P[bank_id]) < `tRP)
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: tRP violation", CUR_TIME);
				`endif
				disable active_op;
			end
			if(CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) < `tRC)
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: tRC violation", CUR_TIME);
				`endif
				disable active_op;
			end
			if(Mode[bank_id] == `TRUE)
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: Illegal active (%0s is not precharged)",CUR_TIME,str);
				`endif
			end
			else
			begin
				Mode[bank_id] = 1'b1;
				`ifdef delc
				`else
				$display("%t (%m) >> active (%0s)", CUR_TIME,str);
				`endif
	
				TRAS_PP[bank_id] = $realtobits(CUR_TIME);			// save current time for tRCD,tRC check.
				r_addr_[bank_id] = addr[`ADDRTOP:0]; 
        		end
		TRAS_P = CUR_TIME;

	end  // active operation
/*
 *-----------------------------------------------------
 *	 READ command									  
 *-----------------------------------------------------
 */

always	@(read)
	begin :read_block
		integer bank_id;
		reg		[8*8:1] str;

		if(CUR_TIME - TCAS_P < `tCCD*TCC_P)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tCCD violation", CUR_TIME);
			`endif
			disable read_block;
		end

	`ifdef A10_LESS
		c_addr = addr[`BIT_C];
        `endif
	`ifdef A10_MORE
		c_addr = {addr[`nCOL:11],addr[9:0]}; 
        `endif

		c_bank_addr = ba;

		bank_id = BankSelect(ba);
		BANK_ID_READ = bank_id;
		str = PrintBank(ba);
		if(CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) < `tRCD)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tRCD violation", CUR_TIME);
			`endif
			disable read_block;
		end

		if(PRDL[bank_id] == `TRUE) begin
			IGNORE_RDL[bank_id] = `TRUE;
			IGNORE_RDL[bank_id] <= #(`tWR) `FALSE;
		end

		r_addr = r_addr_[bank_id];

		if(Mode[bank_id] == `TRUE)
		begin
		    if( addr[10] == `TRUE)
		    begin
				`ifdef delc
				`else
				$display("%t (%m) >> read with auto precharge(%0s)",CUR_TIME,str);
				`endif
				auto_flag[bank_id] <= @(negedge pclk) `TRUE;
				autoprech_reg <= @(negedge pclk) ba;
                                for (i = 0; i < `nBank; i = i + 1)
                                      begin
                                          if (auto_flag[i] == `TRUE)
                                            begin
                                                auto_flag[i] = `FALSE;
                                                if (i != bank_id ) begin 

                                                    #0 ->autoprecharge;
						end
                                            end
                                      end 
		    end
		    else begin
				`ifdef delc
				`else
		  	        $display("%t (%m) >> read (%0s)",CUR_TIME,str);
				`endif
                                for (i = 0; i < `nBank; i = i + 1)
                                      begin
                                          if (auto_flag[i] == `TRUE)
                                            begin
                                                auto_flag[i] = `FALSE;
				                if (i != BANK_ID_READ ) begin
                                                #0 ->autoprecharge;
                                                end
                                            end
                                      end 

			end
		end 

		else begin
			`ifdef delw
			`else
		        $display("%t (%m) Warning: Illegal read (%0s is not acitve)",CUR_TIME,str);
			`endif
			disable read_block;
		end

		READ_MODE = `TRUE;	// read operation start
		    if (BL == 2)
		        READ_MODE2 = `TRUE;
		TCAS_P = CUR_TIME;

		m_addr = {r_addr, c_addr};

                if ((WBL == 2 && READ_TIME - WRITE_TIME == 2*TCC_P) ||(WBL == 4 && READ_TIME - WRITE_TIME == 3*TCC_P) || (WBL == 8 && READ_TIME - WRITE_TIME == 3*TCC_P) || (WBL == 8 && READ_TIME - WRITE_TIME == 4*TCC_P) || (WBL == 8 && READ_TIME - WRITE_TIME == 5*TCC_P)) begin
		    if (READ_MODE == `TRUE) begin
			for (i = 0; i < `nDM; i = i + 1) begin : dm_check
			    if(dm_delay[i] == `FALSE) begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: Illegal command, tCDLR violation", $realtime);
				`endif
				i = `nDM;
		            end
		        end
		    end
		end

		if(~burst_type)
			increment_read;
		else	
			interleave_read;
		read_task;			// task call

		READ_MODE = `FALSE;   // read operation end. 0518
		if (BL == 2) begin
		    READ_MODE2 <= #0.5 `FALSE; 
		end
		last_rw = TCLK_H;
		if( auto_flag[bank_id] )
		begin
			auto_flag[bank_id] = `FALSE; 
			#0 ->autoprecharge;
			disable read_block;
		end


	end

/*
 *-----------------------------------------------------
 *	 WRITE command									 
 *-----------------------------------------------------
 */

always  @(write_mode)
	begin:write_mode_block 
		integer bank_id;
		reg		[8*8:1] str;

		if(CUR_TIME - TCAS_P < `tCCD*TCC_P)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tCCD violation", CUR_TIME);
			`endif
			disable write_block;
		end

	`ifdef A10_LESS
		c_addr = addr[`BIT_C];
        `endif
	`ifdef A10_MORE
		c_addr = {addr[`nCOL:11],addr[9:0]}; 
        `endif

		c_bank_addr = ba;


	#0.5	bank_id = BankSelect(ba);
		BANK_ID_WRITE = bank_id;
		str = PrintBank(ba);
		r_addr = r_addr_[bank_id];

		if(CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) < `tRCD)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tRCD violation", CUR_TIME);
			`endif
			disable write_block;
		end

		if(PRDL[bank_id] == `TRUE) begin
			IGNORE_RDL[bank_id] = `TRUE;
			IGNORE_RDL[bank_id] <= #(`tWR) `FALSE;
		end
			

		if(Mode[bank_id] == `TRUE)
		begin
			if(addr[10])
			begin
				`ifdef delc
				`else
				$display("%t (%m) >> write with auto precharge( %0s )",CUR_TIME,str);
				`endif
                                for (i = 0; i < `nBank; i = i + 1)
                                      begin
                                          if (auto_flag[i] == `TRUE)
                                            begin
                                                auto_flag[i] = `FALSE;
                                                if (i != bank_id ) begin
                                                #0.1 ->autoprecharge_write;
                                                end
                                            end
                                      end 
				auto_flag[bank_id]  <= @(negedge pclk) `TRUE;
				autoprech_reg <= @(negedge pclk) ba;
			end
			else begin
				`ifdef delc
				`else
				$display("%t (%m) >> write ( %0s )",CUR_TIME,str);
				`endif
                                for (i = 0; i < `nBank; i = i + 1)
                                      begin
                                          if (auto_flag[i] == `TRUE)
                                            begin
                                                auto_flag[i] = `FALSE;
                                                if (i != bank_id ) begin
                                                #0.1 ->autoprecharge_write;
                                                end
                                            end
                                      end 
			end

		end
		else 
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: Illegal write command",CUR_TIME);
			`endif
			disable write_block;
		end
		WRITE_MODE = `TRUE;
		TCAS_P = CUR_TIME;
		#(0.25*TCC_P);
		#0.1;

		//c_addr_delay <= repeat (1) @(posedge dqs) addr[`BIT_C];
		//c_bank_addr_delay <= repeat (1) @(posedge dqs) ba;
		c_addr_delay <= #(TCC_P/4) addr[`BIT_C];
		c_bank_addr_delay <= #(TCC_P/4) ba;
		m1_addr <= @(negedge clk) {r_addr, c_addr};


                if ( WBL == 2 ) begin
		     #(TCC_P-2.3);
		     WRITE_MODE = `FALSE;
		     end
                else if ( WBL == 8 ) begin
		     WRITE_MODE = repeat (WBL) @(pclk) `FALSE; 
		     end
                else if ( WBL == 4 ) begin
		     WRITE_MODE = repeat (WBL) @(pclk) `FALSE; 
		end

		last_rw = CUR_TIME;

		`ifdef sim_vcs
		if( auto_flag[bank_id] == `TRUE && READ_MODE == `FALSE || auto_flag[bank_id] == `TRUE && (READ_MODE == `FALSE && WBL == 8 && addr[10] == 1'b1 && { RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b100  ))
		`else
		if( auto_flag[bank_id] == `TRUE && READ_MODE == `FALSE || (READ_MODE == `FALSE && WBL == 8 && addr[10] == 1'b1 && { RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b100  ))
		`endif
		begin
			auto_flag[bank_id] = `FALSE;
			if (autoprecharge_WIRevent == `FALSE) begin
		        #0 ->autoprecharge_write;
		        end
		end

	end



always  @(WRITE_MODE)
	begin
	#(TCC_P/2+0.5);
	  m_addr <= @(posedge dqs) m1_addr; //jjk0202
       end


// In bank interleave write mode, din data should be stored 
// in din register as the other bank selection occurred.

always	@(flush_write)
	begin
		if(~burst_type)
			increment_write;
		else
			interleave_write;
	end

/*
 *-----------------------------------------------------
 *	 AUTO REFRESH command								   
 *-----------------------------------------------------
 */

always	@(autorefresh)
	begin : auto_op
		if (EMRS_SET == `FALSE || (DLL_ON == `TRUE && DLL_RESET == `FALSE) || MRS_ING == `TRUE) // for refersh protection during MRS_ING
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: Illegal refresh command",CUR_TIME);
			`endif
		    disable auto_op;
		end
		if (|Mode !== 1'b0) begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: Illegal refresh command",CUR_TIME);
			`endif
			disable auto_op;
		end

		for(i=0; i < `nBank; i=i+1)
		begin
			if( (TRAS_P != $bitstoreal(TRAS_PP[i])) && (CUR_TIME - $bitstoreal(TRAS_PP[i]) < `tRFC) )
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: tRFC violation",CUR_TIME);
				`endif
			end
		end

		AUTOREF_MODE = `TRUE;
		`ifdef delc
		`else
		$display("%t (%m) >> auto refresh",CUR_TIME);
		`endif
		AUTOREF_MODE = #(`tRFC) `FALSE;

	end	

/*
 *-----------------------------------------------------
 *	 SELF REFRESH command								   
 *-----------------------------------------------------
 */

always	@(selfrefresh)
	begin : self_op
		if(CUR_TIME - TSEXIT < `tSREX*TCC_P)
		begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tSREX violation", CUR_TIME);
			`endif
			disable active_op;
		end
		if (|Mode == 1'b0) begin
			SELFREF_MODE = `TRUE;
			`ifdef delc
			`else
  			$display("%t (%m) >> self refresh enter",CUR_TIME);
			`endif
			TSELF = CUR_TIME;
			TSELF_TCCP = TCC_P;
		end
		else begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: Illegal self refresh command",CUR_TIME);
			`endif
			disable self_op;
		end

		for(i =0; i < `nBank; i = i+1)
		begin
			if( CUR_TIME - $bitstoreal(TRAS_PP[i]) < `tRC )
			begin
			`ifdef delw
			`else
			$display("%t (%m) Warning: tRC  violation",CUR_TIME);
			`endif
			end
		end
	end	

always @(selfexit) begin
        TSEXIT = CUR_TIME;
        SELFREF_MODE = #(`tSREX*TSELF_TCCP) `FALSE;
end

/*
 *-----------------------------------------------------
 *	 PRECHARGE command								 
 *-----------------------------------------------------
 */

// precharge command performs to disable active operation.

always	@(precharge)
	begin : prech_op
		integer bank_id;
		reg		[8*8:1] str;
	`ifdef M1024_8BANK
		  bank_id = BankSelect(prech_reg[3:1]);
		  str = PrintBank(prech_reg[3:1]);
	`else
		  bank_id = BankSelect(prech_reg[2:1]);
		  str = PrintBank(prech_reg[2:1]);
	`endif

		if(prech_reg[0] == `FALSE)
		begin
			if(CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) < `tRASmin)
			begin 
				`ifdef delw
				`else
				$display("%t (%m) Warning: tRASmin violation  TRAS_PP= %t", CUR_TIME, $bitstoreal(TRAS_PP[bank_id]));
				`endif
				disable prech_op;
			end
			if(first_pre[bank_id]==`FALSE && CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) > `tRASmax)
			begin
				`ifdef delw
				`else
				$display("%t (%m) Warning: tRASmax violation( %0s )",CUR_TIME,str);
				`endif
			end

			first_pre[bank_id] = `FALSE;

			if(Mode[bank_id] == 1'bx || Mode[bank_id] == 1)
			begin
				Mode[bank_id] = 1'b0;
				`ifdef delc
				`else
				$display("%t (%m) >> precharge ( %0s )", CUR_TIME, str);
				`endif
			end

			else
			begin
				`ifdef delc
				`else
				$display("%t (%m) -- current precharge command is NOP",CUR_TIME);
				`endif
				disable prech_op;
			end

			precharge_flag[bank_id] = `TRUE;
			kill_bank = bank_id;
			->precharge_flag_kill;
			TPRE_P[bank_id] = $realtobits(CUR_TIME);
		end
	
		else
		begin
			for(i = 0; i < `nBank; i = i+1)
			begin
				if(CUR_TIME - $bitstoreal(TRAS_PP[i]) < `tRASmin)
				begin
					`ifdef delw
					`else
					$display("%t (%m) Warning: tRASmin violation ( %0s )", CUR_TIME, str);
					`endif
					disable prech_op;
				end

				if(first_pre[i]==`FALSE && CUR_TIME - $bitstoreal(TRAS_PP[i]) > `tRASmax)
				begin
					`ifdef delw
					`else
					$display("%t (%m) Warning: tRASmax violation( %0s )", CUR_TIME, str);
					`endif
				end
				first_pre[i] = `FALSE;
			end

			if(|Mode[`nBank-1:0] == 1'b1)
			begin
				`ifdef delc
				`else
				$display("%t (%m) >> precharge ( all bank )",CUR_TIME);
				`endif
			end

			else
			begin
				`ifdef delc
				`else
				$display("%t (%m) -- current precharge command is NOP",CUR_TIME);
				`endif
				disable prech_op;
			end

			Mode = `nBank'b0;

			for(i = 0; i < `nBank; i = i+1)
			begin
				precharge_flag[i] = `TRUE;
				TPRE_P[i] = $realtobits(CUR_TIME);
				first_pre[i] = `FALSE;
			end
			kill_bank = bank_id;
			->precharge_flag_kill;

		end
		->precharge_start;
	end

/*
 *-----------------------------------------------------
 *	 AUTO PRECHARGE command								 
 *-----------------------------------------------------
 */

always	@(autoprecharge or autoprecharge_write or posedge reautoprecharge)
begin : autoprech_op
real difftime;
integer bank_id;
reg		[8*8:1] str;
reg		tmp_reauto;
integer	prev_bank;
integer tmp_bank;

	tmp_reauto = `FALSE;
 	
	`ifdef M1024_8BANK
	bank_id = BankSelect(autoprech_reg[2:0]);
	`else
      
	bank_id = BankSelect(autoprech_reg[1:0]);
	`endif 
	BANK_ID_INT = bank_id;
      if ( gapless == `TRUE && autoprech_reg == ba) begin
		reautoprecharge = `FALSE;
		gapless = `FALSE;
        disable autoprech_op;
      end
	  else
		gapless = `FALSE;
	if (reautoprecharge == `TRUE) begin
		reautoprecharge = `FALSE;
		tmp_bank = prev_bank;
	end
	else
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);
	if(data_write == `TRUE)
            difftime = $realtime + 2*TCC_P - $bitstoreal(TRAS_PP[tmp_bank]);
        else
	    difftime = $realtime - $bitstoreal(TRAS_PP[tmp_bank]);
	if(difftime < `tRASmin)
	begin
		  auto_flagx <= `TRUE;
		  auto_flagx <= #(`tRASmin-difftime) `FALSE;
		  prev_bank <= #(`tRASmin-difftime) tmp_bank;
		  reautoprecharge <= #(`tRASmin-difftime) `TRUE;
		  tmp_reauto = `TRUE;
		  `ifdef delc
		  `else
		  $display("%t (%m)  Info: Starting Auto precharge (%s) delayed by tRASmin violation", $realtime, str);
		  `endif

	          if (data_read == `TRUE || READ_MODE == `TRUE || auto_flag[i] == `TRUE || {RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b110 || CSB_FLAG == `TRUE || RASB_FLAG == `TRUE || CASB_FLAG == `TRUE) begin
	        	if ({RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b101) begin  
		            if (bank_id == ba ) begin
				`ifdef delc
				`else
			        $display("%t (%m) >> DISABLE autoprecharge (%s)", $realtime, str);
				`endif
		                #0 disable autoprech_op;
		            end
		        end
		   end

	end
	if(difftime > `tRASmax)
	begin
		`ifdef delw
		`else
		$display("%t (%m) Warning: tRASmax violation", $realtime);
		`endif
	end

	if (tmp_reauto == `FALSE) begin
		if (data_write == `TRUE && WRITE_MODE == `TRUE) begin
         		#(0.5*TCC_P-0.4);
			BANK_ID_INT = bank_id;
			->autoprecharge_write_int;
		        #0 disable autoprech_op;
			end

	if ( prev_com == 3'b100 && ( data_write == `TRUE || {RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b100 || { RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b010 )) begin 
         		#(`tWR);
			if (READ_TIME - WRITE_TIME > 0 && (READ_TIME - WRITE_TIME < 2*TCC_P || READ_TIME - WRITE_TIME == 2*TCC_P)) begin
			    `ifdef delw
			    `else
			    $display("%t (%m)  Warning: Illegal command, at least the gap between Write and (interrupt)Read command is needed 3 cycle to satisfy tCDLR parameter at DDR", READ_TIME);
			    `endif
			    //#0 disable autoprech_op;	// '//'
			end
			if (data_write == `TRUE) begin // 990727
			    if (bank_id == BANK_ID_WRITE) begin
		                 #0 disable autoprech_op;
			    end
			end
			->autoprecharge_write_int2;
		          #0 disable autoprech_op;
			end

       if ( CL == 2.5 && BL == 2) begin
	            for (i = 0; i < `nBank; i = i + 1)
		         begin
		             if (auto_flag[i] == `TRUE ) begin
			       if ({RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b101) begin
                                    #0 disable autoprech_op;
				    end
                               else begin
			       `ifdef delc
			       `else
		               $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
			       `endif
				end
		               Mode[tmp_bank] = 0;
		               precharge_flag[tmp_bank] = `TRUE;
		               kill_bank = tmp_bank;
			        ->precharge_flag_kill;
		               TPRE_P[tmp_bank] = $realtobits($realtime);
			       end
			 end
                         end

	   if (data_read == `TRUE || READ_MODE == `TRUE || auto_flag[i] == `TRUE || {RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b110 || CSB_FLAG == `TRUE || RASB_FLAG == `TRUE || CASB_FLAG == `TRUE) begin
		if ({RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b101) begin
		    if (bank_id == ba ) begin
		        #0 disable autoprech_op;
		    end
		    else if (bank_id != ba ) begin
				`ifdef delc
				`else
			        $display("%t (%m) >> autorecharge start (%s)", $realtime, str);
				`endif
				Mode[tmp_bank] = 0;
				precharge_flag[tmp_bank] = `TRUE;
				kill_bank = tmp_bank;
				->precharge_flag_kill;
				TPRE_P[tmp_bank] = $realtobits($realtime);
		    end
		end
		else begin
		`ifdef delc
		`else
		$display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
		`endif
		end
		Mode[tmp_bank] = 0;
		precharge_flag[tmp_bank] = `TRUE;
		kill_bank = tmp_bank;
			->precharge_flag_kill;
		TPRE_P[tmp_bank] = $realtobits($realtime);

	   end
	end
end

always  @(autoprecharge_write)
begin : trdl_start_op
        integer  bank_id;
        integer  bank_id2;

        bank_id = BankSelect(c_bank_addr_delay);
        bank_id2 = BankSelect(ba);

	#0.2;
	`ifdef sim_vcs
	if(bank_id == bank_id2 && {csb, rasb, casb, web} == 4'b0100)
	     PRDL[bank_id] = `FALSE;
	else begin
             PRDL[bank_id] <= repeat (1) @(posedge clk) `TRUE;
             repeat (1) @(posedge clk) -> rdl_start;
	end
	`else
             PRDL[bank_id] <= repeat (1) @(posedge clk) `TRUE;
             repeat (1) @(posedge clk) -> rdl_start;
	`endif
end

always  @(rdl_start)
begin : trdl_check_op
        integer i;

        for(i=0; i<`nBank ; i=i+1)
	begin
	   if(i == BANK_ID_INT)
        	PRDL[i] <= #(`tWR) `FALSE;
        end
end



/*
 *-----------------------------------------------------
 */

always @(autoprecharge_write_int)
       begin : autoprecharge_write_int_op
       reg	[8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                bank_id  = BANK_ID_INT;
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);

	    if (READ_MODE == `TRUE) begin
	            for (i = 0; i < `nBank; i = i + 1)
		         begin
		             if (auto_flag[i] == `TRUE || auto_flag[i] == `FALSE) begin
				  if (i == BANK_ID_READ ) begin
		            #0 disable autoprecharge_write_int_op;
				   end
			     end
                         end
	    end


	    if (READ_MODE == `TRUE) begin
	            for (i = 0; i < `nBank; i = i + 1)
		         begin
		             if (auto_flag[i] == `TRUE || auto_flag[i] == `FALSE) begin
				  if (i == BANK_ID_READ ) begin
		            	  #0 disable autoprecharge_write_int_op;
				   end
			     end
                         end
	    end
       end

always @(negedge PRDL[0]) 
       begin : autopre_start_a_op
       reg	[8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                bank_id  = 0;
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);

	if(PWR == `TRUE && IGNORE_RDL[bank_id] !== `TRUE)
	begin
	     `ifdef delc
	     `else
	     $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
	     `endif
	     Mode[tmp_bank] = 0;
	     precharge_flag[tmp_bank] = `TRUE;
	     kill_bank = tmp_bank;
	     ->precharge_flag_kill;
	     TPRE_P[tmp_bank] = $realtobits($realtime);
	end
end

always @(negedge PRDL[1]) 
       begin : autopre_start_b_op
       reg      [8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                bank_id  = 1;
                tmp_bank = bank_id;
        str = PrintBank(tmp_bank);
        
	if(PWR == `TRUE && IGNORE_RDL[bank_id] !== `TRUE)
	begin
	     `ifdef delc
	     `else
             $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
	     `endif
             Mode[tmp_bank] = 0;
             precharge_flag[tmp_bank] = `TRUE;
             kill_bank = tmp_bank;
             ->precharge_flag_kill;
             TPRE_P[tmp_bank] = $realtobits($realtime);
	end
end

always @(negedge PRDL[2]) 
       begin : autopre_start_c_op
       reg      [8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                bank_id  = 2;
                tmp_bank = bank_id;
        str = PrintBank(tmp_bank);
        
	if(PWR == `TRUE && IGNORE_RDL[bank_id] !== `TRUE)
	begin
	     `ifdef delc
	     `else
             $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
	     `endif
             Mode[tmp_bank] = 0;
             precharge_flag[tmp_bank] = `TRUE;
             kill_bank = tmp_bank;
             ->precharge_flag_kill;
             TPRE_P[tmp_bank] = $realtobits($realtime);
	end
end

always @(negedge PRDL[3]) 
       begin : autopre_start_d_op
       reg      [8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                bank_id  = 3;
                tmp_bank = bank_id;
        str = PrintBank(tmp_bank);
        
	if(PWR == `TRUE && IGNORE_RDL[bank_id] !== `TRUE)
	begin
	     `ifdef delc
	     `else
             $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
	     `endif
             Mode[tmp_bank] = 0;
             precharge_flag[tmp_bank] = `TRUE;
             kill_bank = tmp_bank;
             ->precharge_flag_kill;
             TPRE_P[tmp_bank] = $realtobits($realtime);
	end
end

always @(autoprecharge_write_int2)
       begin : autoprecharge_write_int2_op
       reg	[8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                bank_id  = BANK_ID_INT;
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);

	     if ( READ_MODE == `TRUE || { RASB_FLAG,CASB_FLAG,WEB_FLAG } == 3'b101 ) begin //one-bank RD before WAP+tRDL 990609
		   for (i = 0; i < `nBank; i = i + 1)
		       begin
				if (BANK_ID_WRITE != ba && Mode[tmp_bank] == `TRUE) begin
				#(1*TCC_P-0.8); 
				`ifdef delc
				`else
	                        $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
				`endif
			        Mode[tmp_bank] = 0;
	             		precharge_flag[tmp_bank] = `TRUE;
			        kill_bank = tmp_bank;
			        ->precharge_flag_kill;
			        TPRE_P[tmp_bank] = $realtobits($realtime);
		                #0 disable autoprecharge_write_int2_op;
				end
				else if (BANK_ID_WRITE == ba ) begin
		                #0 disable autoprecharge_write_int2_op;
				end

		       end
	    end

	    if (READ_MODE == `TRUE) begin
		   for (i = 0; i < `nBank; i = i + 1)
		       begin
				if (BANK_ID_WRITE != BANK_ID_READ && Mode[tmp_bank] == `TRUE ) begin
				`ifdef delc
				`else
	                        $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
				`endif
				Mode[tmp_bank] = 0;
				precharge_flag[tmp_bank] = `TRUE;
				kill_bank = tmp_bank;
				->precharge_flag_kill;
				TPRE_P[tmp_bank] = $realtobits($realtime);
		                #0 disable autoprecharge_write_int2_op;
				end
				else if (BANK_ID_WRITE == BANK_ID_READ ) begin
		                #0 disable autoprecharge_write_int2_op;
				end
			        
		       end
	    end

	    if ( {RASB_FLAG, CASB_FLAG, WEB_FLAG} == 3'b101 ) begin
	           for (i = 0; i < `nBank; i = i + 1)
	                begin
			   #0.50
	                       if (BANK_ID_WRITE != ba ) begin
				    `ifdef delc
				    `else
	                            $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
				    `endif
	                            Mode[tmp_bank] = 0;
	                            precharge_flag[tmp_bank] = `TRUE;
	                            kill_bank = tmp_bank;
	                            ->precharge_flag_kill;
	                            TPRE_P[tmp_bank] = $realtobits($realtime);
		                    #0 disable autoprecharge_write_int2_op;
	                       end
	                       else if (BANK_ID_WRITE == ba ) begin
	                       #0 disable autoprecharge_write_int2_op;
	                       end
	                end
           end
       end

always @(posedge autoprecharge_WIRevent)
       begin : autoprecharge_WIR_op
       reg	[8*8:1] str;
       integer tmp_bank;
       reg   [`nBank-1:0] bank_id;
                //bank_id  = BANK_ID_INT;
                bank_id  = BANK_ID_WRITE;
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);

              if (READ_TIME - WRITE_TIME < 2*TCC_P || READ_TIME - WRITE_TIME == 2*TCC_P) begin
		  `ifdef delw
		  `else
	          $display("%t (%m) Warning: Illegal command, at least the gap between Write and (interrupt)Read command is needed 3 cycle to satisfy tCDLR parameter at DDR", READ_TIME);
		  `endif
		  #0 disable autoprecharge_WIR_op;
              end

	            for (i = 0; i < `nBank; i = i + 1)
		         begin
			 #1.0
			      if (BANK_ID_WRITE == BANK_ID_READ ) begin
		                  #0 disable autoprecharge_WIR_op;
			      end
			      else if (BANK_ID_WRITE != BANK_ID_READ && Mode[tmp_bank] == `TRUE) begin
                                      #(2*TCC_P-1.0); 
				      `ifdef delc
				      `else
	                              $display("%t (%m) >> autoprecharge start (%s)", $realtime, str);
				      `endif
	                              Mode[tmp_bank] = 0;
	                              precharge_flag[tmp_bank] = `TRUE;
	                              kill_bank = tmp_bank;
	                              ->precharge_flag_kill;
	                              TPRE_P[tmp_bank] = $realtobits($realtime);
	                        #0 disable autoprecharge_WIR_op;
                              end
                         end
       end

always @(autostart)
	begin : autostart_op
		if( READ_MODE )
		begin
			auto_flagx = repeat (BL/2) @(negedge pclk) `FALSE;  
		end
		else if( WRITE_MODE )
		begin
			auto_flagx = repeat (WBL/2) @(negedge pclk) `FALSE; 
		end
	end

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
		integer j;
		integer	bank;
        	reg [`BIT_T]  maddr;
		reg [15:0] tmp_reg0;

		if(data_write == `TRUE) bank = BankSelect(c_bank_addr_delay);
		else                    bank = BankSelect(c_bank_addr);
        	
		maddr = m_addr;
		for(j=0; j<= BL-1; j=j+1) begin
			case(bank)
				  'd0: begin
					dout_reg[j] = mem_a[maddr];
					din_reg[j] = mem_a[maddr];
					//$damem_read("mem_a", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_a", maddr, din_reg[j]);//Dynamic
				  end
				  'd1: begin
					dout_reg[j] = mem_b[maddr];
					din_reg[j] = mem_b[maddr];
					//$damem_read("mem_b", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_b", maddr, din_reg[j]);//Dynamic
				  end
				  'd2: begin
					dout_reg[j] = mem_c[maddr];
					din_reg[j] = mem_c[maddr];
					//$damem_read("mem_c", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_c", maddr, din_reg[j]);//Dynamic
				  end
				  'd3: begin
					dout_reg[j] = mem_d[maddr];
					din_reg[j] = mem_d[maddr];
					//$damem_read("mem_d", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_d", maddr, din_reg[j]);//Dynamic
				  end
			endcase

        		case(BL)
            			'd1: begin end
            			'd2: maddr[0] = ~maddr[0];
            			'd4: maddr[1:0] = maddr[1:0]+1;
            			'd8: maddr[2:0] = maddr[2:0]+1;
            			`PAGEDEPTH: maddr[`BIT_C] = maddr[`BIT_C]+1;
            			default: begin
					`ifdef delw
					`else
                			$display("%t (%m) Warning: burst length is out of spec",CUR_TIME);
					`endif
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
    reg [`BIT_T] maddr;  //8.14

		if(data_write == `TRUE) bank = BankSelect(c_bank_addr_delay);
		else                    bank = BankSelect(c_bank_addr);

        	maddr = m_addr;
		for(j=0; j<=BL-1; j=j+1) begin
			case(bank)
				'd0: begin
					dout_reg[j] = mem_a[maddr];
					din_reg[j] = mem_a[maddr];
					//$damem_read("mem_a", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_a", maddr, din_reg[j]);//Dynamic
				end
				'd1: begin
					dout_reg[j] = mem_b[maddr];
					din_reg[j] = mem_b[maddr];
					//$damem_read("mem_b", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_b", maddr, din_reg[j]);//Dynamic
				end
				  'd2: begin
					dout_reg[j] = mem_c[maddr];
					din_reg[j] = mem_c[maddr];
					//$damem_read("mem_c", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_c", maddr, din_reg[j]);//Dynamic
				  end
				  'd3: begin
					dout_reg[j] = mem_d[maddr];
					din_reg[j] = mem_d[maddr];
					//$damem_read("mem_d", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_d", maddr, din_reg[j]);//Dynamic
				  end
			`ifdef M1024_8BANK
				  'd4: begin
					dout_reg[j] = mem_e[maddr];
					din_reg[j] = mem_e[maddr];
					//$damem_read("mem_e", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_e", maddr, din_reg[j]);//Dynamic
				  end
				  'd5: begin
					dout_reg[j] = mem_f[maddr];
					din_reg[j] = mem_f[maddr];
					//$damem_read("mem_f", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_f", maddr, din_reg[j]);//Dynamic
				  end
				  'd6: begin
					dout_reg[j] = mem_g[maddr];
					din_reg[j] = mem_g[maddr];
					//$damem_read("mem_g", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_g", maddr, din_reg[j]);//Dynamic
				  end
				  'd7: begin
					dout_reg[j] = mem_h[maddr];
					din_reg[j] = mem_h[maddr];
					//$damem_read("mem_h", maddr, dout_reg[j]);//Dynamic
					//$damem_read("mem_h", maddr, din_reg[j]);//Dynamic
				  end
			`endif
			endcase

			case(BL)
				'd1:begin end
				'd2: maddr[0] = ~maddr[0];
				'd4: begin
					if( j == 0 || j == 2) maddr[0] = ~maddr[0];
					else maddr[1:0] = ~maddr[1:0];
				end
				'd8: begin
					if(j == 0 || j == 2 || j == 4 || j==6) maddr[0] = ~maddr[0];
					else if(j == 1 || j == 5) maddr[1:0] = ~maddr[1:0];
					else maddr[2:0] = ~maddr[2:0];
				end
				default: begin
					`ifdef delw
					`else
					$display("%t (%m) Warning: burst length is out of spec.",CUR_TIME);
					`endif
				end
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
		integer j, k;
        	reg [`BIT_T] maddr;
		integer bank, loop;

		bank = BankSelect(c_bank_addr_delay);
        	maddr = m_addr;

		for(j=0; j<WBL; j=j+1) begin
			case(bank)
				'd0: begin
					mem_a[maddr] = din_reg[j];
					//$damem_write("mem_a", maddr, din_reg[j]);//Dynamic
				end
				'd1: begin
					mem_b[maddr] = din_reg[j];
					//$damem_write("mem_b", maddr, din_reg[j]);//Dynamic
				end
				'd2: begin
				        mem_c[maddr] = din_reg[j];
					//$damem_write("mem_c", maddr, din_reg[j]);//Dynamic
				     end
				'd3: begin
				        mem_d[maddr] = din_reg[j];
					//$damem_write("mem_d", maddr, din_reg[j]);//Dynamic
				     end
			`ifdef M1024_8BANK
				'd4:    mem_e[maddr] = din_reg[j];
					//$damem_write("mem_e", maddr, din_reg[j]);//Dynamic
				'd5:    mem_f[maddr] = din_reg[j];
					//$damem_write("mem_f", maddr, din_reg[j]);//Dynamic
				'd6:    mem_g[maddr] = din_reg[j];
					//$damem_write("mem_g", maddr, din_reg[j]);//Dynamic
				'd7:    mem_h[maddr] = din_reg[j];
					//$damem_write("mem_h", maddr, din_reg[j]);//Dynamic
			`endif
			endcase

        		case(WBL)
            			'd1: begin end
            			'd2: maddr[0] = ~maddr[0];
            			'd4: maddr[1:0] = maddr[1:0]+1;
            			'd8: maddr[2:0] = maddr[2:0]+1;
            			`PAGEDEPTH: maddr[`BIT_C] = maddr[`BIT_C]+1;
            			default: begin
					`ifdef delw
					`else
                			$display("%t (%m) Warning: burst length is out of spec",CUR_TIME);
					`endif
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
	integer j, k;
	integer bank, loop;
    	reg [`BIT_T] maddr;

	bank = BankSelect(c_bank_addr_delay);
    	maddr = m_addr;

	for(j=0; j <= WBL-1; j=j+1) begin
			case(bank)
				'd0: begin
					mem_a[maddr] = din_reg[j];
					//$damem_write("mem_a", maddr, din_reg[j]);//Dynamic
				end
				'd1: begin
					mem_b[maddr] = din_reg[j];
					//$damem_write("mem_b", maddr, din_reg[j]);//Dynamic
				end
				'd2: begin
				        mem_c[maddr] = din_reg[j];
					//$damem_write("mem_c", maddr, din_reg[j]);//Dynamic
				     end
				'd3: begin
				        mem_d[maddr] = din_reg[j];
					//$damem_write("mem_d", maddr, din_reg[j]);//Dynamic
				     end
			endcase
			case(WBL)
				'd1:begin
               			 end
                		'd2: maddr[0] = ~maddr[0];
                		'd4: begin
                    			if((j % 2) == 0) maddr[0] = ~maddr[0];
                    			else maddr[1:0] = ~maddr[1:0];
                		end
                		'd8: begin
                    			if((j % 2) == 0) maddr[0] = ~maddr[0];
                    			else if(j == 1 || j == 5) maddr[1:0] = ~maddr[1:0];
                    			else maddr[2:0] = ~maddr[2:0];
                		end
				default: 
				begin
					`ifdef delw
					`else
					$display("%t (%m) Warning: burst length is out of spec.",CUR_TIME);
					`endif
				end
			endcase
		end
	end
endtask


/*
 *-----------------------------------------------------
 *   precharge interrupt
 *-----------------------------------------------------
 */

always @(precharge_start)
	begin: pc_start
	integer bank_id;
	reg		[8*8:1] str;

		if( READ_MODE == `TRUE )
		begin
			bank_id = BankSelect(c_bank_addr);
			str = PrintBank(c_bank_addr);
			if(precharge_flag[bank_id])
			begin
				`ifdef delc
				`else
				$display("%t (%m) -- read operation interrupted by precharge",CUR_TIME);
				`endif
				READ_MODE = `FALSE;
				disable read_block;
			end
		end
		if( data_write == `TRUE )
		begin
			#0.1
			bank_id = BankSelect(c_bank_addr_delay);
			str = PrintBank(c_bank_addr_delay);
			if(precharge_flag[bank_id])
			begin
			  if ( dqs !== `nDQS'bz) begin
				`ifdef delc
				`else
				$display("%t (%m) -- write operation interrupted by precharge",CUR_TIME);
				`endif
				for (i = 0; i < `nDM; i = i + 1) begin : dm_high_check
				  if(dm[i] == `FALSE) begin
					`ifdef delw
					`else
					$display("%t (%m)    DM must be high", CUR_TIME);
					`endif
					i = `nDM;
				  end
				end
			  end
				disable write_block;
				data_write = `FALSE;
			end
		end
	end

/*
 *-----------------------------------------------------
 *   precharge done after tRP     
 *-----------------------------------------------------
 */

always @(precharge_flag_kill) begin
	if (prech_reg[0] == `TRUE) begin
		for (i = 0; i < `nBank; i = i+1)
			precharge_flag[i] <= #(`tRP-1) `FALSE;
	end
	else begin
		if( precharge_flag[kill_bank] )
			precharge_flag[kill_bank] <= #(`tRP-1) `FALSE;
	end
end

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
				@(pclk);
				if( i == `PAGEDEPTH -1)  i = -1; // full page wrap around  8.14
			end
		end

	end
endtask

/*
 *-----------------------------------------------------
 *	 write task
 *-----------------------------------------------------
 */

//always @(write) 
always @(posedge write_event) // for VCS
	begin: write_block
		begin: write_op
			integer    i, j, k;
			reg [`BIT] tmp_reg;
			integer bank_id;
			reg	[8*8:1] str;

#0.2;
			if(~burst_type)
				increment_read;
			else
				interleave_read;

			begin: write_seq
				for(i = 0; i < WBL; i = i+1)
				begin  // { for loop
					begin
						bank_id = BankSelect(c_bank_addr_delay);
						str = PrintBank(c_bank_addr_delay);
						if(precharge_flag[bank_id] == `TRUE) 
						begin
							disable write_seq;
						end

						tmp_reg = din_reg[i];
						
                                                for (k = 0; k < `nDM; k = k + 1) begin
                                                  if (dm[k] == 1'b0) begin
                                                        for (j = k*`BYTE; j < (k+1)*`BYTE; j = j + 1) begin
                                                           tmp_reg[j] = (dqi[j] == 1'b1 || dqi[j] == 1'b0)?
                                                                                    dqi[j]:1'bx;
                                                        end
                                                  end
                                                  else if( dm[k] == 1'b1 && i < WBL-1)
                                                        if(dqi !== `B'bz) begin
                                                        end
                                                        else
                                                        disable write_seq;
                                                end

						din_reg[i] = tmp_reg;
					end

					if( dqs !== `nDQS'bz )
					->flush_write;

					if( i == WBL-1 && WBL !== `PAGEDEPTH )   // 8.14
						disable write_seq;
					@(dqs);
					if( CUR_TIME - TDQI < `tDS - TCC_P)
					begin
						`ifdef delw
						`else
						$display("%t (%m) Warning: DQi setup violation", CUR_TIME);
						`endif
					end
					if ( i == `PAGEDEPTH-1 ) i = -1; // full page wrap around 8.14 

					#0.2;

				end  // } for loop end
			end  // write_seq
				`ifdef sim_vcs
				if( WRITE_MODE == `FALSE)
				data_write <= repeat (1) @(posedge clk) `FALSE;  //
				`else
				data_write = #(TCC_P*0.5-0.21) `FALSE;  //CGh 990726
				`endif

		end

	end

//endtask 

/*
 *-----------------------------------------------------
 *	 function definition 
 *-----------------------------------------------------
 */

function integer BankSelect;
input	[1:0] 	c_addr;
integer			bank;
begin
	case(c_addr)
		2'b00 : bank = 0;
		2'b01 : bank = 1;
		2'b10 : bank = 2;
		2'b11 : bank = 3;
		default : bank = -1;
	endcase
	BankSelect = bank;
end
endfunction
function [8*8 : 1] PrintBank;
input	[1:0]	bs;
reg		[8*8 : 1]	s_bank;
begin
	case(bs)
		2'b00 : s_bank = " A Bank";
		2'b01 : s_bank = " B Bank";
		2'b10 : s_bank = " C Bank";
		2'b11 : s_bank = " D Bank";
		default : s_bank = "Bad Bank";
	endcase
	PrintBank = s_bank;
end
endfunction

//`endprotect

endmodule
