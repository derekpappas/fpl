/***************************************************************************** 
   
  4 Mbit (512Kbyte x 8, Uniform Block) 3V Supply Low Pin Count (FWH) Flash Memory
  
  Type Name : M50fw040
  
  Copyright (c) 2001 STMicroelectronics
  
****************************************************************************** 
  
  Version History
  
  Version 2.0
  Author : Pugliese Andrea

  Based on Preview Release of M50LPW080 Spec Datasheet (April 2001)
  
******************************************************************************   
  
    THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,        
    EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE        
    IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR      
    PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERforMANCE OF         
    THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU      
    ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.     
  
*****************************************************************************/ 

// Constant definitions
`define MEMORY_DIM 524288   //Change from m50lpw080
`define DATABUS_DIM 8        
`define ADDRBUS_DIM 28      
`define MEMADDR_DIM 19	    //Change from m50lpw080
`define REGENABLE_ADDR 22 
`define FWHBUS_DIM  4
`define AAMUXADDRBUS_DIM 11
  
`define BLOCK_DIM 65536       
`define BLOCK_NUM 8	//Change from m50lpw080             
`define TOPBLOCK  7    //Change from m50lpw080       

`define HIGH 1'b1
`define LOW  1'b0
`define Z    1'bZ
`define X    1'bX
`define FALSE 1'b0
`define TRUE 1'b1

`define LOCKOUT 0 
`define NORMAL 1
`define FAST 2

`define WRITEOP 0
`define READOP 1

`define READLOCK  8'b00000100
`define LOCKDOWN  8'b00000010
`define WRITELOCK 8'b00000001

`define MANUFCODE 8'h20
`define DEVCODE   8'h2C		//Change from m50lpw040
`define MANUFCODE_ADDR 19'h00000
`define DEVCODE_ADDR   19'h00001
`define FGPI_ADDR       19'h40100
`define LOCKREG_ADDR   16'h0002

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
`define SR_SEQCMDERR  8'hB0			//!ADD
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
`define FGPIPROTECT_MSG 9
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
`define QPGM   8'h30      // Quadruple Byte Program 
`define CLRSR  8'h50      // Clear Status Register 
`define PES    8'hB0      // Program/Erase Suspend 
`define PER    8'hD0      // Program/Erase Resume 
`define BLKEECONF 8'hD0   // Erase Confirm      

// FWH bus field definitions
`define FWH_STARTREAD 4'hD	  // Change
`define FWH_STARTWRITE 4'hE	  // Change
`define FWH_MSIZE_0 4'h0	  // Add
`define FWH_MSIZE_16 4'h4	  // Add
`define FWH_MSIZE_32 4'h5	  // Add
//`define FWH_FASTREAD 4'h5 // Add
`define FWH_TAR   4'hF
`define FWH_RSYNC 4'h0
`define FWH_WSYNC 4'h5
//`define FWH_BYTEFASTREAD 32       //add m50lpw080
`define FWH_INTERFACE IC == `LOW 
`define AAMUX_INTERFACE IC == `HIGH

// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

`define FWHBUSREAD_OP  fwh_busOpRead == `TRUE    //Change
`define FWHBUSWRITE_OP fwh_busOpRead == `FALSE   //add	

// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//`define FWHBUSFASTREAD_OP fwh_cmd[`FWHBUS_DIM-1:0] == `FWH_FASTREAD	//Add
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
`define READSTATUSREG 0
`define READARRAY 1
`define READELECTSIG 2

// FWH bus operations //ALL change
`define START 0
`define IDSEL 1 
`define ADDRIN 2
`define MSIZE  3
`define TAR_IN 4
`define TAR_IN_FLOAT 5
`define TAR_OUT 6
`define TAR_OUT_FLOAT 7
`define RSYNC 8
`define DATAOUT 9 
`define DATAIN 10
`define WSYNC_1 11
`define WSYNC_2 12  

// Running status
`define FREE 0
`define BUSY_PGM 1
`define BUSY_BLKEE 2
`define BUSY_BLKEESUSP 3
`define BUSY_CHIPEE 4
`define BUSY_PGMSUSP 5
`define BUSY_RSTSUSP 6

// FWH AC signal timing characteristics
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


// TIMESCALE COMPILER DIRECTIVE 
`timescale 1 ns / 100 ps 

module m50fw040 (FWH, FWH4, RFU, ID, FGPI, CLK, IC, RP_N, INIT_N, WP_N, TBL_N, VCC, VPP, VPPH, VSS);
  input FWH4, VCC, VPP, VPPH, VSS, CLK, IC, TBL_N, WP_N, INIT_N, RP_N;
  input [4:0] FGPI;
  input [3:0] ID;		//Change from m50lpw080	
  inout [`FWHBUS_DIM-1:0] FWH;
  inout [4:0] RFU; 		//Change from m50lpw080	


  // PARAMETER  
  parameter memoryfile = "./memory_file";
  
  reg [`DATABUS_DIM-1:0] memory [0:`MEMORY_DIM-1];     // The memory   
  reg [`DATABUS_DIM-1:0] lock_reg [0:`BLOCK_NUM-1];    // The lock registers
  reg [`DATABUS_DIM-1:0] SR;                           // The Status Register
 
  integer startBlk_addr[`BLOCK_NUM-1:0];
  integer endBlk_addr[`BLOCK_NUM-1:0];


  time timeLG_N, timeHRC, timeLRST, timeHRST;
  time timePGM_susp, timePGM_start, timeEE_susp, timeEE_start;
  time time2DQ;
  
  integer fwh_status, read_status, write_status, running_status;
  integer Vpp_status, Vcc_status;
  integer nibble; 
  integer fwh_nByteRead, fwh_fastRead, fwh_iByteReading;
  integer fwh_busOpRead;
  
 
  reg [3:0] reg_addr;
  reg [1:0] byte_num;
  integer msg_error; 
  integer n_block;
  integer erasing_block;
  integer timeDataOut;
  reg dataout_error;
  reg chipErase;

 
  reg [`ADDRBUS_DIM-1:0] hold_addr;
  reg [`DATABUS_DIM-1:0] hold_data;
  reg [`MEMADDR_DIM-1:0] mem_addr;

  reg pgm_cell [3:0];
  reg [`DATABUS_DIM-1:0] pgm_data [0:3];
  reg [`MEMADDR_DIM-1:0] pgm_addr [0:3];

  reg [`FWHBUS_DIM-1:0]  fwh_cmd;

  event AddrBusEvent;
  reg completion, dataout, msgout;
  wire [`FWHBUS_DIM-1:0] fwh_InDataBus;
  reg [`FWHBUS_DIM-1:0] fwh_OutDataBus;  
  wire Vpp_signal = Vpp_status;
  assign fwh_InDataBus = FWH;
  
  wire RESET = `FWH_INTERFACE ? INIT_N & RP_N : RP_N;  // Reset signal
  
//  tri0 [2:0] id_internal = ID;				//Change from m50lpw080
  
 
  // AAMUX INTERFACE
  wire [`AAMUXADDRBUS_DIM-1:0] aamux_AddrBus;
  wire [`DATABUS_DIM-1:0] aamux_InDataBus;
  wire RC = CLK;
  wire G_N;
  wire W_N;
  reg [`DATABUS_DIM-1:0] aamux_OutDataBus; 
  reg RB;

  
  assign RFU[4] = `Z;								//Change from m50lpw080
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-1:`AAMUXADDRBUS_DIM-5] = FGPI;
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-6] = WP_N;
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-7] = TBL_N;
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-8:`AAMUXADDRBUS_DIM-11] = ID;		//Change from m50lpw080
  assign aamux_InDataBus[`DATABUS_DIM-1:`DATABUS_DIM-4] = RFU[3:0];
  assign aamux_InDataBus[`DATABUS_DIM-5:`DATABUS_DIM-8] = FWH;
  assign RFU[3:0] = `AAMUX_INTERFACE ?  aamux_OutDataBus[`DATABUS_DIM-1:`DATABUS_DIM-4] : {4{`Z}};
  assign #time2DQ FWH = `AAMUX_INTERFACE ? aamux_OutDataBus[`DATABUS_DIM-5:`DATABUS_DIM-8] : fwh_OutDataBus;
  assign RFU[4] = `AAMUX_INTERFACE ? RB : `Z;
  assign G_N = INIT_N;
  assign W_N = FWH4; 

  
  initial 
  begin: init_block
      integer i; 
      for (i = 0; i < `BLOCK_NUM; i = i+1)      // Block Addresses Setup
      begin
        startBlk_addr[i] = `BLOCK_DIM * i;
        endBlk_addr[i]   =  startBlk_addr[i] + `BLOCK_DIM - 1;
      end     
      for (i = 0; i < `MEMORY_DIM; i = i+1)  memory[i] = {`DATABUS_DIM{`HIGH}};    // Memory Reset
      if (memoryfile !== "") $readmemb(memoryfile, memory);   // Memory Init 
      lockRegInit_task;     // lock registers init  

      fwh_status = `START;
      write_status = `WRITECMD;
      completion = `LOW;
      dataout = `LOW;
      msgout = `LOW;
      fwh_cmd = {`FWHBUS_DIM{`HIGH}}; 
      fwh_OutDataBus = {`FWHBUS_DIM{`Z}};
      timeLRST = 0;
      timeHRST = 0;
     
      aamux_OutDataBus = {`DATABUS_DIM{`Z}};
      mem_addr = {`MEMADDR_DIM{`HIGH}}; 
      byte_num = 2'b11; 
 
      // Memory Reset
      running_status = `BUSY_RSTSUSP;
      read_status = `READARRAY;
      SR = `SREESTART; 
      completion <= #`tPLRH ~completion;  
 
  end

  task lockRegInit_task; 
  integer i;
  begin
    for (i = 0; i < `BLOCK_NUM-1; i = i+1) lock_reg[i] = `WRITELOCK;     
  end
  endtask
  
  
  always @(RC)

  begin
    if (`AAMUX_INTERFACE && `SUPPLYON && RESET == `HIGH && $time > 0) begin  
      if (RC == `LOW) mem_addr[`AAMUXADDRBUS_DIM-1: 0] = aamux_AddrBus; 
      else begin
        timeHRC = $time;
        mem_addr[`MEMADDR_DIM-1:`AAMUXADDRBUS_DIM] = aamux_AddrBus; 
        byte_num = mem_addr[1:0]; 		// Change
        -> AddrBusEvent;
      end 
    end
  end
 
  task fwhAddrVerify_task;   
  output addr_valid;
  begin
     addr_valid = `TRUE;
     if (hold_addr[`ADDRBUS_DIM-1:`REGENABLE_ADDR+1] !== {(`ADDRBUS_DIM-`REGENABLE_ADDR-1){`HIGH}}) 
        begin
        fwh_OutDataBus = {`FWHBUS_DIM{`Z}}; 
        fwh_cmd = {`FWHBUS_DIM{`HIGH}}; 
        fwh_status = `START;
        addr_valid = `FALSE;
     end
     else begin
        mem_addr = hold_addr[`MEMADDR_DIM-1:0];
        //reg_addr = hold_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-4]; //ORGINAL 
	//reg_addr = {1'b0, hold_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-3]}; //change
	reg_addr = {1'b0, hold_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
     end  
  end 
  endtask

  always @(posedge CLK) 
  begin
   if (`FWH_INTERFACE && `SUPPLYON && RESET == `HIGH && $time > 0) begin 
    case (fwh_status)
     `START:
      begin
        if (FWH4 == `LOW) begin 
			  fwh_cmd = fwh_InDataBus; 
        		  if (fwh_cmd==`FWH_STARTREAD || fwh_cmd==`FWH_STARTWRITE)
	        				begin
						   if (fwh_cmd==`FWH_STARTREAD) fwh_busOpRead=`TRUE;
		    				   			   else fwh_busOpRead=`FALSE; 
	      					   fwh_status = `IDSEL;
						   hold_addr = 0;
						   nibble = 0;  
						end
	  		  end 
      end
	     
     `IDSEL:
      begin
	
        if (ID==fwh_InDataBus) begin 
			       fwh_status=`ADDRIN;
			       hold_addr = 0; 
			       nibble = 0;
			       end
	   else begin // Il Device Indirizzato non e' quello corrente
	   	fwh_status = `START;
           	fwh_cmd = {`FWHBUS_DIM{`HIGH}};
		fwh_OutDataBus = {`FWHBUS_DIM{`Z}}; 
		end
      end
     `ADDRIN: 
      begin: addrin_blk
        reg addrvalid;
        case (nibble)
          0:  hold_addr[`ADDRBUS_DIM-1:`ADDRBUS_DIM-4] = fwh_InDataBus;
          1:  hold_addr[`ADDRBUS_DIM-5:`ADDRBUS_DIM-8] = fwh_InDataBus;
          2:  hold_addr[`ADDRBUS_DIM-9:`ADDRBUS_DIM-12] = fwh_InDataBus;
          3:  hold_addr[`ADDRBUS_DIM-13:`ADDRBUS_DIM-16] = fwh_InDataBus;
          4:  hold_addr[`ADDRBUS_DIM-17:`ADDRBUS_DIM-20] = fwh_InDataBus;
          5:  hold_addr[`ADDRBUS_DIM-21:`ADDRBUS_DIM-24] = fwh_InDataBus;
          6:  hold_addr[`ADDRBUS_DIM-25:`ADDRBUS_DIM-28] = fwh_InDataBus;
          default: begin end
        endcase
        nibble = nibble + 1; 
        if (nibble >= 7) 
	  begin
          fwhAddrVerify_task(addrvalid);
          if (addrvalid == `TRUE)
	     begin
	     nibble = 0;
             hold_data = 0;
	     fwh_status = `MSIZE;
	     end    
      	  end
      end
     `MSIZE: 
      begin
       	if (`FWHBUSWRITE_OP) fwh_status=`DATAIN;
      	   else begin
                fwh_status=`TAR_IN;
		fwh_iByteReading=0;
                   	case (fwh_InDataBus)
   			   `FWH_MSIZE_0 : begin 
			 		  fwh_nByteRead=0;
					  fwh_fastRead=`FALSE;
					  end
 			   `FWH_MSIZE_16: begin
					  fwh_nByteRead=16; 
					  fwh_fastRead=`TRUE;
					  end
			   `FWH_MSIZE_32: begin
			   		  fwh_nByteRead=32;
					  fwh_fastRead=`TRUE;
					  end
		           default: begin end
                        endcase					 
		end
      end
 
     `DATAIN: 
      begin
        case (nibble)
          0:  hold_data[`DATABUS_DIM-5:`DATABUS_DIM-8] = fwh_InDataBus;
          1:  hold_data[`DATABUS_DIM-1:`DATABUS_DIM-4] = fwh_InDataBus;
          default: begin end
        endcase
        nibble = nibble + 1; 
        if (nibble >= 2) fwh_status = `TAR_IN;
      end 
     `TAR_IN:
      begin
        fwh_status = `TAR_IN_FLOAT;
      end
     `TAR_IN_FLOAT:
      begin
        if (`FWHBUSWRITE_OP) fwh_status = `RSYNC;
        else fwh_status = `WSYNC_1; 
      end   
     `RSYNC:
      begin
        fwh_OutDataBus = `FWH_RSYNC;
        if (`FWHBUSWRITE_OP) begin 
           fwh_status = `TAR_OUT; 
           if (hold_addr[`REGENABLE_ADDR] == `LOW)  RegWriteOp_task; 
           else MemWriteOp_task; 
        end
        else begin
          fwh_status = `DATAOUT;
          nibble = 0;
          hold_data = 0; 
        end  
      end
     `TAR_OUT:
      begin
        fwh_OutDataBus = `FWH_TAR;
	fwh_status = `TAR_OUT_FLOAT;			 
      end
     `TAR_OUT_FLOAT:
      begin
        fwh_OutDataBus = {`FWHBUS_DIM{`Z}};
        fwh_status = `START;
      end 
     `WSYNC_1:
      begin
        fwh_OutDataBus = `FWH_WSYNC;
        fwh_status = `WSYNC_2;
      end  
     `WSYNC_2:
      begin
        fwh_status = `RSYNC;
      end       
     `DATAOUT:
      begin
        case (nibble)
          0: begin
                dataout_error = `TRUE;
                if (hold_addr[`REGENABLE_ADDR] == `LOW) RegReadOp_task; 
                else MemReadOp_task;   
                fwh_OutDataBus =  hold_data[`DATABUS_DIM-5:`DATABUS_DIM-8];
             end

          1: begin 
	     fwh_OutDataBus =  hold_data[`DATABUS_DIM-1:`DATABUS_DIM-4]; 
	     if (fwh_fastRead==`TRUE) begin 						//add
	     		   if (hold_addr[`REGENABLE_ADDR] == `LOW) begin 
	 	           					   hold_addr = hold_addr+1;
								   reg_addr  = {1'b0, hold_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
								   mem_addr = hold_addr[`MEMADDR_DIM-1:0];
								   end
			      else mem_addr=mem_addr+1;
			   fwh_iByteReading=fwh_iByteReading+1;
		           end
	     end  
	     default: begin end
        endcase
        nibble = nibble + 1;  
        if (nibble == 2) begin 
			 fwh_status = `TAR_OUT;
			 nibble=0;
			 if (fwh_fastRead==`TRUE)
          			if(fwh_iByteReading==fwh_nByteRead) 
				    begin
				    fwh_iByteReading=0;
				    fwh_fastRead=`FALSE;
				    end
		         	else fwh_status=`WSYNC_1;
			 end
				 
      end 
     default: begin end
    endcase 
   end
  end   
    

  always @(negedge FWH4)  
  begin
    if (`FWH_INTERFACE && `SUPPLYON && RESET == `HIGH) begin
      fwh_OutDataBus = {`FWHBUS_DIM{`Z}}; 
      fwh_cmd = {`FWHBUS_DIM{`HIGH}}; 
      if (fwh_status !== `START) begin
          fwh_status = `START;
          $display("Warning! \n Input Communication Frame is Low during a bus operation. The operation is aborted!\n Scope: %m\n Time: %d \n", $time);
      end 
    end
  end
  

  task findblock_task;
  input [`MEMADDR_DIM:0] addr; 
  integer i;
  begin  
    for (i = 0; i < `BLOCK_NUM; i = i + 1) 
       if (startBlk_addr[i] <= addr && endBlk_addr[i] >= addr) n_block = i; 
  end
  endtask 


  task locationPGM_task;
  input [`MEMADDR_DIM-1:0] address;
  input [`DATABUS_DIM-1:0] value;
  begin
     if ((memory[address] & value) !== value) begin
        msg_error = `INVPGM_MSG;
        msgout <= #time2DQ ~msgout;
     end 
     memory[address] = (memory[address] & value);      
  end
  endtask 

 
  task protectCheck_task;
  input  op_type;
  output errflag;
  begin
    errflag = `FALSE;  
    case (op_type)
      `WRITEOP: 
         if ((TBL_N == `LOW && n_block == `TOPBLOCK) || 
            (WP_N == `LOW && n_block !== `TOPBLOCK) || 
            ((lock_reg[n_block] & `WRITELOCK) == `WRITELOCK) )  begin
            msg_error = `WRITEPROTECT_MSG;
            msgout <= #time2DQ ~msgout;
                                 
            write_status = `WRITECMD;
            read_status = `READSTATUSREG;
            SR = (SR | `SRPROTECERR);
            errflag = `TRUE; 
          end 
      `READOP:
         if ((lock_reg[n_block] & `READLOCK) == `READLOCK) errflag = `TRUE; 
    endcase 
  end
  endtask

 
  task vppCheck_task;
  input [4:0] cmd;
  output errflag;
  begin
    if (Vpp_status == `LOCKOUT) begin
       msg_error = `VPPPROTECT_MSG;
       msgout <= #time2DQ ~msgout; 
       
       write_status = `WRITECMD;
       read_status = `READSTATUSREG;
       SR = (SR | `SRVPPERR);
       errflag = `TRUE;
    end
    else if (cmd == `QBPGM_4 && Vpp_status == `NORMAL) begin
      $display("Warning!  Invalid Command \n Quadruple Byte Program operation cannot be performed (VPP < VPPH)!\n Scope: %m\n Time: %d \n", $time);   
      write_status = `WRITECMD;
      read_status = `READARRAY;
      errflag = `TRUE;  
    end 
    else errflag = `FALSE; 
  end
  endtask


  task program_task;
  input [4:0] cmd;
  reg error_flag; 
  reg [2:0] n_byte;
  
  begin
    timePGM_start = $time;
    findblock_task(mem_addr);
    
    vppCheck_task(cmd, error_flag);
    if (`SR_EESUSP && (erasing_block == n_block || chipErase == `TRUE)) begin
       msg_error = `INVEEADDR2_MSG;
       msgout <= #time2DQ ~msgout;
       write_status = `WRITECMD;
       read_status = `READARRAY;
       error_flag = `TRUE;  
    end
    if (`FWH_INTERFACE && error_flag == `FALSE) protectCheck_task(`WRITEOP, error_flag);       
    if (error_flag == `FALSE) begin
       running_status = `BUSY_PGM;
       write_status = `WRITECMD;
       read_status = `READSTATUSREG;
       SR = (SR & `SRPGMSTART);
       RB = `LOW;
       
       if (cmd == `QBPGM_4) begin
          for (n_byte = 0; n_byte < 4; n_byte=n_byte+1) begin
	    pgm_addr[n_byte] = {mem_addr[`MEMADDR_DIM-1:2], n_byte[1:0]};		//Change
            if (pgm_cell[n_byte] == `TRUE) locationPGM_task(pgm_addr[n_byte], pgm_data[n_byte]); 
          end
       end
       else begin
         for (n_byte = 0; n_byte < 4; n_byte=n_byte+1)   pgm_addr[n_byte] = mem_addr;
         locationPGM_task(mem_addr, hold_data); 
       end
       completion <= #`PGM_TIME ~completion;   
    end
  end
  endtask


  task dataOut_task;
  integer temp;
  begin
     timeDataOut = `tGLQV - $time + timeLG_N;
     temp = `tCHQV_aamux - $time + timeHRC;
     if (timeDataOut < temp) timeDataOut = temp;

     if (timeDataOut < 0) timeDataOut = 0;
     if (`FWH_INTERFACE) timeDataOut = time2DQ;
 
     dataout <= #timeDataOut ~dataout;
  end
  endtask

  
  always @(VPP or VPPH) 
  begin
    if (VPP == `LOW) begin
       $display("Warning! \n Optional Supply Voltage VPP < VPPLK. Program and Erase operations cannot be performed!\n Scope: %m\n Time: %d \n", $time);
       Vpp_status = `LOCKOUT; 
    end     
    else if (VPP == `HIGH && VPPH == `LOW)  Vpp_status = `NORMAL;
    else if (VPP == `HIGH && VPPH == `HIGH) Vpp_status = `FAST; 
  end
  
  
  always @(VCC)
  begin
   if (VCC == `LOW) begin
      $display("Warning! \n Supply Voltage VCC < VLKO. Program and Erase operations will be aborted!\n Scope: %m\n Time: %d \n", $time);
      Vcc_status = `LOCKOUT;
   end
   else begin
      // Memory reset
      Vcc_status = `NORMAL; 
      running_status = `BUSY_RSTSUSP;
      read_status = `READARRAY;
      SR = `SREESTART; 
      completion <= #`tPLRH ~completion;   
   end 
  end
 
  always @(IC) 
  begin
    time2DQ = `FWH_INTERFACE ? `tCHQV  : 0;
    
    if (running_status !== `BUSY_RSTSUSP && Vcc_status == `NORMAL) 
       $display("Warning! \n The Interface Configuration must be selected before power-up or during a reset!\n Scope: %m\n Time: %d \n", $time);  
  end
 

  always @(msgout)
  begin
     case (msg_error) 
       `INVPGM_MSG: 
          $display("Warning!  Invalid Address \n The memory location addressed is not empty. The array will not be programmed correctly!\n Scope: %m\n Time: %d \n", $time);
       `WRITEPROTECT_MSG:
          $display("Warning!  Invalid Address \n This block is write protected!\n Scope: %m\n Time: %d \n", $time);
       `VPPPROTECT_MSG:
          $display("Warning!  Invalid Command \n All blocks are write protected (VPP < VPPLK)!\n Scope: %m\n Time: %d \n", $time);
       `INVEEADDR2_MSG:
          $display("Warning!  Invalid Address \n It is not possible to program cells in erasing block addresses!\n Scope: %m\n Time: %d \n", $time);
       `LOCKPROTECT_MSG:
          $display("Warning!  Invalid Operation \n Changes to the selected register cannot be performed (Lock-Down =+ 1)!\n Scope: %m\n Time: %d \n", $time);
       `FGPIPROTECT_MSG:
          $display("Warning!  Invalid Operation \n Changes to the General Purpose Input Register cannot be performed!\n Scope: %m\n Time: %d \n", $time);
       `INVREGADDR_MSG:
          $display("Warning!  Invalid Address \n It is not possible to read Interface Configuration Registers!\n Scope: %m\n Time: %d \n", $time);
       `BADCOMMAND_MSG:
          $display("Warning! \n Invalid Command, Device Busy, or Program/Erase controller error!\n Scope: %m\n Time: %d \n", $time);       
       `INVSUSPEND_MSG:
          $display("Warning!  Invalid Command \n No Erase or Program operations in progress!\n Scope: %m\n Time: %d \n", $time);
       `SRERROR_MSG:
          $display("Warning!  Invalid Command \n P/E Controller Error. Clear Status Register command must be issued before attempting a new command!\n Scope: %m\n Time: %d \n", $time); 
       `INVRESUME_MSG:
          $display("Warning!  Invalid Command \n No Erase or Program operations suspended!\n Scope: %m\n Time: %d \n", $time);  
       `INVBLKEECONFIRM_MSG:
          $display("Warning!  Invalid Command \n Invalid Block Erase Command sequence!\n Scope: %m\n Time: %d \n", $time); 
       `INVCHIPEECONFIRM_MSG:
          $display("Warning!  Invalid Command \n Invalid Chip Erase Command sequence!\n Scope: %m\n Time: %d \n", $time);  
      
       default: begin
          $display("Error! \n  Invalid data!\n Scope: %m\n Time: %d \n", $time);
       end 
     endcase  
  end
   

  always @(dataout)
  begin
    if (dataout_error == `TRUE) begin
       case (msg_error)
         `READPROTECT_MSG:
             $display("Warning!  Invalid Address \n This block is read protected!\n Scope: %m\n Time: %d \n", $time);
         `WRITEPROTECT_MSG: 
             $display("Warning!  Invalid Address \n This block is write protected!\n Scope: %m\n Time: %d \n", $time);
         `INVPGMADDR_MSG:
             $display("Warning!  Invalid Address \n It is not possible to read cells in programming address!\n Scope: %m\n Time: %d \n", $time);
         `INVEEADDR_MSG:
             $display("Warning!  Invalid Address \n It is not possible to read cells in erasing block addresses!\n Scope: %m\n Time: %d \n", $time);
         `INVESADDR_MSG:
             $display("Warning!  Invalid Address \n It is not possible to read Manufacturer Code or Device Code!\n Scope: %m\n Time: %d \n", $time);
         `INVLREGADDR_MSG:
             $display("Warning!  Invalid Address \n It is not possible to read Interface Configuration Registers!\n Scope: %m\n Time: %d \n", $time);
         `BADCOMMAND_MSG:
             $display("Warning! \n Invalid Command, Device Busy, or Program/Erase controller error!\n Scope: %m\n Time: %d \n", $time);  
         default: 
             $display("Error! \n  Invalid data!\n Scope: %m\n Time: %d \n", $time);
       endcase
       dataout_error = `FALSE;
    end       
    
    if (`AAMUX_INTERFACE && G_N == `LOW) aamux_OutDataBus = hold_data;
    else aamux_OutDataBus = {`AAMUXADDRBUS_DIM{`Z}};
    
  end

  task RegReadOp_task;
  reg [18:0] test; 
  begin
     test = {reg_addr, `LOCKREG_ADDR};
     if (mem_addr == {reg_addr, `LOCKREG_ADDR}) begin
       dataout_error = `FALSE; 
       hold_data = lock_reg[reg_addr]; 
     end
     else if (mem_addr == `FGPI_ADDR) begin
       dataout_error = `FALSE;
       hold_data = FGPI;  
     end 
     else begin
       msg_error = `INVLREGADDR_MSG;  
       hold_data = {`DATABUS_DIM{`X}}; 
     end
      
     dataOut_task;   
  end  
  endtask


  task MemReadOp_task; 
  begin
      findblock_task(mem_addr); 
      case (read_status)
        `READSTATUSREG:
         begin
           dataout_error = `FALSE; 
           hold_data = SR;
           dataOut_task; 
         end
        `READARRAY:
         begin: blk_readarray
           reg error_flag;
           integer i;
           if (`SR_PGMSUSP &&
               (mem_addr == pgm_addr[0] || mem_addr == pgm_addr[1] || 
                mem_addr == pgm_addr[2] || mem_addr == pgm_addr[3] )) begin 
              hold_data = {`DATABUS_DIM{`X}};
              msg_error = `INVPGMADDR_MSG;
           end
           else if ((`SR_EESUSP || SR == `SRCLEAR) && (erasing_block == n_block || chipErase == `TRUE)) begin
              hold_data = {`DATABUS_DIM{`X}};
              msg_error = `INVEEADDR_MSG;
           end 
           else if (running_status == `BUSY_RSTSUSP) begin
              hold_data = {`DATABUS_DIM{`X}};
              msg_error = `BADCOMMAND_MSG;
           end
           else begin 
              if (`FWH_INTERFACE) protectCheck_task(`READOP, error_flag); 
              if (error_flag == `TRUE) begin 
                 hold_data = {`DATABUS_DIM{`LOW}}; 
                 msg_error = `READPROTECT_MSG;
              end 
              else begin
                 dataout_error = `FALSE;
                 hold_data = memory[mem_addr];   
              end
           end
           dataOut_task; 
         end
        `READELECTSIG:
         begin
           if (mem_addr !== `MANUFCODE_ADDR &&  mem_addr !== `DEVCODE_ADDR) begin
              msg_error = `INVESADDR_MSG;
              hold_data = {`DATABUS_DIM{`X}};
           end
           else if (mem_addr == `MANUFCODE_ADDR) begin
              dataout_error = `FALSE;
              hold_data = `MANUFCODE;
           end 
           else if (mem_addr == `DEVCODE_ADDR) begin
             dataout_error = `FALSE;
             hold_data = `DEVCODE; 
           end
           dataOut_task; 
         end
        default: begin 
           $display("Error!  \n Invalid read status!\n Scope: %m\n Time: %d \n", $time);
         end
      endcase
  end 
  endtask
  
  task RegWriteOp_task;
  begin
    if (mem_addr == {reg_addr, `LOCKREG_ADDR}) begin
      if ((lock_reg[reg_addr] & `LOCKDOWN) == `LOCKDOWN) begin
         msg_error = `LOCKPROTECT_MSG;
         msgout <= #time2DQ ~msgout; 
      end
      else lock_reg[reg_addr] = (8'b00000111 & hold_data); 
    end 
    else if (mem_addr == `FGPI_ADDR) begin
       msg_error = `FGPIPROTECT_MSG;
       msgout <= #time2DQ ~msgout; 
    end
    else begin
       msg_error = `INVREGADDR_MSG;
       msgout <= #time2DQ ~msgout; 
    end 
         
  end
  endtask
  
  task erase_task;
  input [4:0] cmd;
  reg error_flag; 
  integer i; 
  begin
    timeEE_start = $time;
    
    if (hold_data !== `BLKEECONF && cmd == `BLKERASE) begin
        msg_error = `INVBLKEECONFIRM_MSG;
        msgout <= #time2DQ ~msgout;   
        write_status = `WRITECMD;
        /*! read_status = `READARRAY; */ read_status = `READSTATUSREG; 	//! MOD
	SR = (SR | `SR_SEQCMDERR);					//! ADD
    end
    else if (hold_data !== `CHIPEECONF && cmd == `CHIPERASE) begin 
        msg_error = `INVCHIPEECONFIRM_MSG;
        msgout <= #time2DQ ~msgout;   
        write_status = `WRITECMD;
        /*! read_status = `READARRAY; */ read_status = `READSTATUSREG; 	//! MOD
	SR = (SR | `SR_SEQCMDERR);					//! ADD
    end
    else begin 
        vppCheck_task(cmd, error_flag);
        if (`FWH_INTERFACE && error_flag == `FALSE) protectCheck_task(`WRITEOP, error_flag);
        if (error_flag == `FALSE) begin
           
           write_status = `WRITECMD;
           read_status = `READSTATUSREG;
           SR = (SR & `SREESTART);
           RB = `LOW;
           if (cmd == `BLKERASE) begin
              running_status = `BUSY_BLKEE;
              findblock_task(mem_addr);    
              for (i = startBlk_addr[n_block]; i < endBlk_addr[n_block]; i= i+1) 
                  memory[i] = {`DATABUS_DIM{`HIGH}};
              erasing_block = n_block;
              chipErase = `FALSE;
              completion <= #`BLKEE_TIME ~completion;
           end
           else begin
              running_status = `BUSY_CHIPEE;
              chipErase = `TRUE;
              for (i = 0; i < `MEMORY_DIM; i= i+1)
                  memory[i] = {`DATABUS_DIM{`HIGH}}; 
              completion <= #`CHIPEE_TIME ~completion;
           end 
       end
    end    
  end 
  endtask 
 
  task MemWriteOp_task;
  begin
      findblock_task(mem_addr); 
      case (write_status)
        `WRITECMD:
         begin
           case (hold_data) 
            `RD:
             begin
               if (running_status == `FREE &&  SR !== `SR_ERROR) begin
                   dataout_error = `TRUE;
                   read_status = `READARRAY;
               end
               else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end 
             end
            `RSR:
             begin  
                read_status = `READSTATUSREG;
             end
            `RSIG_1, `RSIG_2:
             begin
                if (running_status == `FREE) begin 
                   dataout_error = `TRUE;
                   read_status = `READELECTSIG;
                end
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end   
             end
            `BLKEE:
             begin
                if (running_status == `FREE &&  `SR_EEFREE) 
                   write_status = `BLKERASE;
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end    
             end
/*	     
            `CHIPEE:
             begin
               if (`AAMUX_INTERFACE && running_status == `FREE &&  `SR_EEFREE) 
                   write_status = `CHIPERASE;
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end    
             end
*/
            `PG_1, `PG_2:
             begin
                if (running_status == `FREE && `SR_PGMFREE) 
                   write_status = `PROGRAM;
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
                end   
             end
            `QPGM:
     	     begin:blk_qpgm
                integer i;
                if (`AAMUX_INTERFACE && running_status == `FREE && `SR_PGMFREE) begin
                   write_status = `QBPGM_1;
                   for (i = 0; i < 4; i = i+1) begin 
                      pgm_cell[i] = `FALSE;
                      pgm_data[i] = {`DATABUS_DIM{`HIGH}};
                   end
                end
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
                end   
             end
            `CLRSR:
             begin
                if (running_status == `FREE) begin
                   SR = (SR & `SRCLEAR);
                end
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
                end   
             end
            `PES:
             begin
               if (running_status == `BUSY_RSTSUSP) begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end   
               else if (running_status !== `BUSY_PGM &&  running_status !== `BUSY_BLKEE &&  running_status !== `BUSY_CHIPEE) begin
                  msg_error = `INVSUSPEND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end 
               else if (running_status == `BUSY_PGM) begin
                  timePGM_susp = $time;
                  running_status = `BUSY_PGMSUSP;
                  completion <= #`PGMSUSP_LATENCY ~completion;
               end
               else begin
                  timeEE_susp = $time;
                  running_status = `BUSY_BLKEESUSP;
                  completion <= #`EESUSP_LATENCY ~completion;
               end       
             end
            `PER:
             begin
               if (running_status == `FREE && `SR_PGMSUSP) begin
                  running_status = `BUSY_PGM;
                  SR = (SR & `SRPGMSTART);
                  RB = `LOW;
                  read_status = `READSTATUSREG;
                  completion <= #(`PGM_TIME - timePGM_susp + timePGM_start) ~completion; 
               end 
               else if (running_status == `FREE && `SR_EESUSP) begin
                  running_status = `BUSY_BLKEE;
                  SR = (SR & `SREESTART);
                  RB = `LOW;
                  read_status = `READSTATUSREG;
                  if (chipErase == `TRUE)  completion <= #(`CHIPEE_TIME - timeEE_susp + timeEE_start) ~completion;  
                  else  completion <= #(`BLKEE_TIME - timeEE_susp + timeEE_start) ~completion;  
                     
               end
               else if (`SR_ERROR) begin
                  msg_error = `SRERROR_MSG;
                  msgout <= #time2DQ ~msgout;   
               end 
               else begin
                  msg_error = `INVRESUME_MSG;
                  msgout <= #time2DQ ~msgout;   
               end
             end
            default: begin
               msg_error = `BADCOMMAND_MSG;
               msgout <= #time2DQ ~msgout;   
            end
           endcase
         end
        `PROGRAM:
         begin
           program_task(`PROGRAM); 
         end
        `BLKERASE:
         begin
           erase_task(`BLKERASE); 
         end
/*
        `CHIPERASE: 
         begin
           erase_task(`CHIPERASE);  
         end  
*/
        `QBPGM_1:
         begin
           pgm_cell[byte_num] = `TRUE;
           pgm_data[byte_num] = hold_data & pgm_data[byte_num];
           write_status = `QBPGM_2; 
         end
        `QBPGM_2:
         begin
           pgm_cell[byte_num] = `TRUE;
           pgm_data[byte_num] = hold_data & pgm_data[byte_num];
           write_status = `QBPGM_3; 
         end
        `QBPGM_3:
         begin
           pgm_cell[byte_num] = `TRUE;
           pgm_data[byte_num] = hold_data & pgm_data[byte_num];
           write_status = `QBPGM_4; 
         end
        `QBPGM_4:
         begin
           pgm_cell[byte_num] = `TRUE; 
           pgm_data[byte_num] = hold_data & pgm_data[byte_num];
           program_task(`QBPGM_4); 
         end
        default: begin
             $display("Error! \n Invalid write status!\n Scope: %m\n Time: %d \n", $time);
         end
      endcase
  end
  endtask


  always @(AddrBusEvent or negedge G_N)
  begin
    if (`AAMUX_INTERFACE && `SUPPLYON) begin
      if (RESET == `HIGH && W_N == `HIGH && G_N == `LOW) begin
         timeLG_N = $time;
         dataout_error = `TRUE;
         MemReadOp_task; 
      end 
    end
  end
 
  always @(G_N)
  begin
    if (`AAMUX_INTERFACE && `SUPPLYON && RESET == `HIGH) begin
       if (G_N == `LOW)  
          aamux_OutDataBus <= #`tGLQX {`AAMUXADDRBUS_DIM{`X}};
       else begin
          aamux_OutDataBus <= #`tGHQX {`AAMUXADDRBUS_DIM{`X}};
          aamux_OutDataBus <= #(`tGHQZ - `tGHQX) {`AAMUXADDRBUS_DIM{`Z}};   
       end
    end 
  end  

  always @(posedge W_N)
  begin
    if (`AAMUX_INTERFACE && `SUPPLYON && $time > 0) begin
      if (RESET == `HIGH && G_N == `HIGH) begin
         hold_data = aamux_InDataBus;
         MemWriteOp_task;
       end 
    end
  end 

  
  always @(completion) 
  begin
    case (running_status) 
      `BUSY_PGMSUSP:
       begin 
         if ($time - timePGM_susp < `PGMSUSP_LATENCY)  
             completion <= #(`PGMSUSP_LATENCY + timePGM_susp - $time)  ~completion;
         else begin 
           SR = (SR | `SRPGMSUSP);  
           running_status = `FREE;
           write_status = `WRITECMD;
           RB = `HIGH;
         end
       end  
      `BUSY_BLKEESUSP: 
       begin
         if ($time - timeEE_susp < `EESUSP_LATENCY)  
            completion <= #(`EESUSP_LATENCY + timeEE_susp - $time)  ~completion;
         else begin 
           SR = (SR | `SREESUSP); 
           running_status = `FREE;
           write_status = `WRITECMD;
           RB = `HIGH;
         end
       end
      `BUSY_RSTSUSP: 
       begin
         if (timeHRST - timeLRST < `tPLRH && $time - timeLRST < `tPLRH)
             completion <= #(`tPLRH + timeHRST - $time) ~completion;
         else begin 
           SR = `SRFREE;
           running_status = `FREE;
           write_status = `WRITECMD;
           read_status = `READARRAY; 
           RB = `HIGH;
         end 
       end
      default: 
      begin
         running_status = `FREE;
         write_status = `WRITECMD;
         RB = `HIGH;
         SR = (SR | `SRFREE); 
      end  
    endcase
   
  end
 

  always @(RESET)
  begin
    if (`SUPPLYON) begin
      if (RESET == `LOW) begin 
        if (`FWH_INTERFACE) begin
           fwh_OutDataBus = {`FWHBUS_DIM{`Z}};
           fwh_cmd = {`FWHBUS_DIM{`HIGH}};
           fwh_status = `START;
        end 
        else aamux_OutDataBus = {`AAMUXADDRBUS_DIM{`Z}};
        timeLRST = $time;
      end
      else begin
        timeHRST = $time;
        dataout_error = `TRUE;
        lockRegInit_task;
        SR = `SREESTART;
        read_status = `READARRAY; 
        if (running_status == `FREE || (timeHRST - timeLRST >= `tPLRH)) begin 
           running_status = `BUSY_RSTSUSP; 
           completion <= ~completion;
        end
        else  begin
           running_status = `BUSY_RSTSUSP;
           completion <= #(`tPLRH - timeHRST + timeLRST) ~completion;
        end
      end
    end
  end


  specify
    // FWH AC Signal Timing characteristics 
    specparam tCYC  = 30;      
    specparam tHIGH = 11;  
    specparam tLOW  = 11;    
    specparam tDVCH = 7;    
    specparam tCHDX = 0;   
    specparam tPHFL = 3000;   // real typical value 30000  
    specparam tFLCH = 7;
    specparam tCHFH = 0;

    // AAMUX AC Signal Timing characteristics 
    specparam tAVAV = 250;
    specparam tAVCL = 50;
    specparam tAVCH = 50;
    specparam tCLAX = 50;
    specparam tCHAX = 50;
    specparam tQXGH = 0;
    specparam tWLWH = 100;
    specparam tDVWH = 50;
    specparam tWHDX = 5;
    specparam tWHWL = 100; 
    specparam tCHWH = 50;
    specparam tVPHWH= 100;
    specparam tWHGL = 30; 
    specparam tPHWL = 5000;   // real typical value 50000
    specparam tPHGL = 5000;   // real typical value 50000
    specparam tPHAV = 1000;
    specparam tQVVPL = 0;
   
    
 
    // FWH Interface Clock Characteristics 
    $width(posedge CLK &&& `FWH_INTERFACE, tHIGH);
    $width(negedge CLK &&& `FWH_INTERFACE, tLOW);
    $period(posedge CLK &&& `FWH_INTERFACE, tCYC); 
    // FWH Interface AC Signal Timing Characteristics    
    $setuphold(posedge CLK &&& `FWH_INTERFACE, FWH, tDVCH, tCHDX);   
    $setuphold(posedge CLK &&& `FWH_INTERFACE, FWH4, tFLCH, tCHFH);   
    $hold(posedge RESET, negedge FWH4 &&& `FWH_INTERFACE, tPHFL); 
    // AAMUX Interface AC Signal Timing  
    $hold(posedge RESET, negedge W_N &&& `AAMUX_INTERFACE, tPHWL);
    $hold(posedge RESET, negedge G_N &&& `AAMUX_INTERFACE, tPHGL);
    $setuphold(posedge RC &&& `AAMUX_INTERFACE, aamux_AddrBus, tAVCH, tCHAX);
    $setuphold(negedge RC &&& `AAMUX_INTERFACE, aamux_AddrBus, tAVCL, tCLAX);
    $hold(posedge RESET, aamux_AddrBus &&& `AAMUX_INTERFACE, tPHAV);    
    $width(posedge W_N &&& `AAMUX_INTERFACE, tWHWL);
    $width(negedge W_N &&& `AAMUX_INTERFACE, tWLWH);
    $hold(posedge W_N &&& `AAMUX_INTERFACE, negedge G_N, tWHGL);  
    $setup(posedge Vpp_signal, negedge W_N &&& `AAMUX_INTERFACE, tVPHWH);  
    $hold(negedge RFU[4] &&& `AAMUX_INTERFACE, negedge Vpp_signal, tQVVPL);
    $setuphold(posedge W_N &&& `AAMUX_INTERFACE, aamux_InDataBus, tDVWH, tWHDX);
    $hold(posedge RESET, negedge W_N &&& `AAMUX_INTERFACE, tPHWL);
    $hold(posedge RC, posedge W_N &&& `AAMUX_INTERFACE, tCHWH);   

    $width(negedge RESET, `tPLPH); 
 
  endspecify

endmodule 

