// TIMESCALE COMPILER DIRECTIVE 
`timescale 1 ns / 100 ps 

// Constant definitions
`define MEMORY_DIM 2097152 //!Change
`define DATABUS_DIM 8           
`define ADDRBUS_DIM 32        
`define MEMADDR_DIM 21
`define REGENABLE_ADDR 22 
`define LPCBUS_DIM  4
`define AAMUXADDRBUS_DIM 11
`define LPC_BYTEFASTREAD 128  //!Add for Fast Read

//!`define BLOCK_DIM 65536 //!Eliminate no uniform block 
`define BLOCK_DIM64 65536 //!Add
`define BLOCK_DIM32 32768 //!Add
`define BLOCK_DIM16 16384 //!Add
`define BLOCK_DIM8  8192  //!Add
`define BLOCK_DIM4  4096  //!Add
`define BLOCK_NUM 50      //!Change         
`define REG_NUM   35	  //!Add reg_num!=block_num
`define TOPBLOCK  49      //!Change       
`define ADDR_REG_INI 	  //!Add for Boot Block
`define ADDR_REG_END	  //!Add for Boot Block

// Lock Register Bit Definition
`define READLOCK  8'b00000100
`define LOCKDOWN  8'b00000010
`define WRITELOCK 8'b00000001

// Elettronic Signature
`define MANUFCODE 8'h20
`define DEVCODE   8'h30
`define MANUFCODE_ADDR 21'h000000
`define DEVCODE_ADDR   21'h000001
`define MANUF_REG      21'h1C0000
`define DEV_REG        21'h1C0001

// GPI & Lock Register Address
`define GPI_ADDR       21'h1C0100
`define LOCKREG_ADDR   12'h002			//!Add

// Status Register bits
`define SRCLEAR       8'hC4
`define SRPGMSTART    8'h40
`define SREESTART     8'h00 
`define SRPGMSUSP     8'h84
`define SREESUSP      8'hC0
`define SRFREE        8'h80
`define SRPROTECERR   8'h82  
`define SRVPPERR      8'h88
`define SREEERR       8'hA0
`define SR_SEQCMDERR  8'hB0			//!Add
`define SR_EESUSP     SR == `SREESUSP
`define SR_EEFREE     SR == `SRFREE
`define SR_EEERR      SR == `SREEERR 
`define SR_BUSY       (SR == `SREESTART || SR == `SRPGMSTART) 
`define SR_PGMSUSP    (SR == `SRPGMSUSP || SR == `SRCLEAR)
`define SR_PGMFREE    (`SR_EEFREE || `SR_EESUSP)
`define SR_VPPERR     (SR == `SRVPPERR || SR == 8'hC8)
`define SR_PROTECERR  (SR == `SRPROTECERR || SR == 8'hC2)
`define SR_PGMERR     (SR == 8'h90 || SR == 8'hD0)
`define SR_ERROR      (`SR_VPPERR || `SR_PROTECERR || `SR_EEERR || `SR_PGMERR || `SR_SEQCMDERR)		//!MOD 

// Error messages
`define READPROTECT_MSG 0
`define WRITEPROTECT_MSG 1
`define INVPGMADDR_MSG 2
`define INVEEADDR_MSG 3
`define INVESADDR_MSG 4
`define INVLREGADDR_MSG 5
`define INVPGM_MSG 6
`define INVEEADDR2_MSG 7
`define LOCKPROTECT_MSG 8
`define GPIPROTECT_MSG 9
`define MANUFPROTECT_MSG 18
`define DEVPROTECT_MSG 19
`define INVREGADDR_MSG 10
`define BADCOMMAND_MSG 11
`define INVSUSPEND_MSG 12
`define SRERROR_MSG 13
`define INVRESUME_MSG 14
`define INVBLKEECONFIRM_MSG 15
`define INVCHIPEECONFIRM_MSG 16
`define VPPPROTECT_MSG 17 

// Commands
`define RD     8'hFF      // Read Memory Array 
`define RSR    8'h70      // Read Status Register 
`define RSIG_1 8'h90      // Read Electronic Signature 
`define RSIG_2 8'h98      // Read Electronic Signature alternative
`define BLKEE  8'h20      // Block Erase
`define CHIPEE 8'h80      // Chip Erasee
`define CHIPEECONF  8'h10 // Chip Erase Confirm 
`define PG_1   8'h40      // Program  
`define PG_2   8'h10      // Program 
`define QPGM_AAMUX   8'h30  // Quadruple Byte Program AAMUX mode
`define QPGM_LPC     8'h31  // Quadruple Byte Program LPC mode //! Add for FastWrite
`define CLRSR  8'h50      // Clear Status Register 
`define PES    8'hB0      // Program/Erase Suspend 
`define PER    8'hD0      // Program/Erase Resume 
`define BLKEECONF 8'hD0   // Erase Confirm      

// LPC bus field definitions
`define LPC_START 4'h0
`define LPC_READ  4'h4     //!Modified: bit 0 is reset to 0 
`define LPC_FASTREAD 4'h5  //!Add
`define LPC_WRITE 3'h3     //!Bit 0 is don't care (x)
`define LPC_TAR   4'hF
`define LPC_RSYNC 4'h0
`define LPC_WSYNC 4'h5


`define LPC_INTERFACE IC == `LOW 
`define AAMUX_INTERFACE IC == `HIGH
`define LPCBUSREAD_OP lpc_cmd[`LPCBUS_DIM-1:0] == `LPC_READ
`define LPCBUSWRITE_OP lpc_cmd[`LPCBUS_DIM-1:1] == `LPC_WRITE

`define LPCBUSFASTREAD_OP lpc_cmd[`LPCBUS_DIM-1:0] == `LPC_FASTREAD //!Change

`define SUPPLYON Vcc_status == `NORMAL

// AAMUX bus operations  
`define WRITECMD 0
`define PROGRAM 1
`define BLKERASE 2
`define CHIPERASE 3
`define QBPGM_1 4
`define QBPGM_2 5
`define QBPGM_3 6
`define QBPGM_4 7 
`define QBPGM_LPC 8
`define READSTATUSREG 0
`define READARRAY 1
`define READELECTSIG 2

// LPC bus operations 
`define START 0
`define DIR 1
`define ADDRIN 2
`define TAR_IN 3
`define TAR_IN_FLOAT 4
`define TAR_OUT 5
`define TAR_OUT_FLOAT 6
`define RSYNC 7
`define DATAOUT 8 
`define DATAIN 9
`define WSYNC_1 10
`define WSYNC_2 11  

// Running status
`define FREE 0
`define BUSY_PGM 1
`define BUSY_BLKEE 2
`define BUSY_BLKEESUSP 3
`define BUSY_CHIPEE 4
`define BUSY_PGMSUSP 5
`define BUSY_RSTSUSP 6

// LPC AC signal timing characteristics
`define tCHQV 11     // max value
`define tCHQV_aamux 150
`define tGLQV 50
`define tPLRH 3000   // real typical value 30000
`define tPLPH 100
`define tGLQX 0
`define tGLQZ 50
`define tGHQX 0
`define tGHQZ 50
`define tWHRL 0

// Program/Erase times 
`define PGMSUSP_LATENCY 2500 // real typical value 5000  
`define EESUSP_LATENCY 5000  // real typical value 30000
`define PGM_TIME 5000        // real typical value 10000
`define BLKEE_TIME 10000     // real typical value 1000000
`define CHIPEE_TIME 20000    // real typical value 9000000

`define VPPLK     1.5
`define VPP1_LOW  3.0
`define VPP1_HIGH 3.6
`define VPPH_LOW  11.4
`define VPPH_HIGH 12.6 
`define VCCLK     2.3

`define VCC_LOW (vcc_real < `VCCLK)
`define VPP_HIGH (vpp_real >= `VPP1_LOW && vpp_real <= `VPP1_HIGH)
`define VPP_FAST (vpp_real >= `VPPH_LOW && vpp_real <= `VPPH_HIGH)
