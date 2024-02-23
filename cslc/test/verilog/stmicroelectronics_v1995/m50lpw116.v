/***************************************************************************** 
   
                                              16 Mbit (2Mbit x 8,  Boot Block) 
  
                                    3V Supply Low Pin Count (LPC) Flash Memory
  
                                                         Type Name : M50LPW116
  
                                         Copyright (c) 2003 STMicroelectronics
  
****************************************************************************** 
  
  Version History
  
  Version 1.0
  Author : Giacopelli Giampaolo

  Based on Preview Release of M50LPW116 Spec Datasheet (March 2002)
  
******************************************************************************   
  
    THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,        
    EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE        
    IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR      
    PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERFORMANCE OF         
    THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU      
    ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.     
  
*****************************************************************************/ 

`include "m50lpw116.h"
`include "def.h"

module m50lpw116 (LAD, LFRAME, RFU, ID, GPI, CLK, IC, RP_N, INIT_N, WP_N, TBL_N, VCC, VPP, VPPH, VSS);
  input LFRAME, VCC, VPP, VPPH, VSS, CLK, IC, TBL_N, WP_N, INIT_N, RP_N;
  input [4:0] GPI;
  input [3:0] ID;			
  inout [`LPCBUS_DIM-1:0] LAD;
  inout [4:0] RFU;			
  

  // PARAMETER  
  parameter memoryfile = "./memory_file";
  
  reg [`DATABUS_DIM-1:0] memory [0:`MEMORY_DIM-1];     // The memory   

  reg [`DATABUS_DIM-1:0] lock_reg [0:`BLOCK_NUM-1];    // The lock registers

  
  reg [`DATABUS_DIM-1:0] SR;                           // The Status Register
 
  integer startBlk_addr[`BLOCK_NUM-1:0];		
  integer endBlk_addr[`BLOCK_NUM-1:0];			
  integer block_dim[`BLOCK_NUM-1:0];
  reg [8:0] lock_reg_index [0:`BLOCK_NUM];           // The lock registers Index ---- Indentified Address Register
  time timeLG_N, timeHRC, timeLRST, timeHRST;
  time timePGM_susp, timePGM_start, timeEE_susp, timeEE_start;
  time time2DQ;
  
  integer lpc_status, read_status, write_status,write_status_old, running_status;
  integer Vpp_status, Vcc_status;
  integer nibble;  
  integer lpc_nByteRead, lpcFastRead;	
  integer lpcFastWrite; 

  reg [9:0] reg_addr;
  reg [1:0] byte_num;
  integer msg_error; 
  integer n_block;
  integer n_block_reg;    
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

  reg [`LPCBUS_DIM-1:0]  lpc_cmd;

  event AddrBusEvent;
  reg completion, dataout, msgout;
  wire [`LPCBUS_DIM-1:0] lpc_InDataBus;
  reg [`LPCBUS_DIM-1:0] lpc_OutDataBus;  
  wire Vpp_signal = Vpp_status;
  assign lpc_InDataBus = LAD;
  
  wire RESET = `LPC_INTERFACE ? INIT_N & RP_N : RP_N;  // Reset signal

  tri0 [3:0] id_internal = ID;			
  
  // AAMUX INTERFACE
  wire [`AAMUXADDRBUS_DIM-1:0] aamux_AddrBus;
  wire [`DATABUS_DIM-1:0] aamux_InDataBus;
  wire RC = CLK;
  wire G_N;
  wire W_N;
  reg [`DATABUS_DIM-1:0] aamux_OutDataBus; 
  reg RB;
  
  
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-1:`AAMUXADDRBUS_DIM-5] = GPI;
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-6] = WP_N;
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-7] = TBL_N;
  assign aamux_AddrBus[`AAMUXADDRBUS_DIM-8:`AAMUXADDRBUS_DIM-11] = ID;		
  
  assign aamux_InDataBus[`DATABUS_DIM-1:`DATABUS_DIM-4] = RFU[3:0];
  assign aamux_InDataBus[`DATABUS_DIM-5:`DATABUS_DIM-8] = LAD;
  assign RFU[3:0] = `AAMUX_INTERFACE ?  aamux_OutDataBus[`DATABUS_DIM-1:`DATABUS_DIM-4] : {4{`Z}};
  assign #time2DQ LAD = `AAMUX_INTERFACE ? aamux_OutDataBus[`DATABUS_DIM-5:`DATABUS_DIM-8] : lpc_OutDataBus;
  assign RFU[4] = `AAMUX_INTERFACE ? RB : `Z;
  assign G_N = INIT_N;
  assign W_N = LFRAME; 

  reg [`ADDRBUS_DIM - 1 : 0] temp;  
  initial 

  begin: init_block
  
  
  integer i,j;

  // initalize Dimension of blocks
     // Parameter Block
  for (i=0; i<=15; i = i + 1) block_dim[i] = `BLOCK_DIM4;	
     // Main Block
  for (i=16; i<=45; i = i + 1) block_dim[i] = `BLOCK_DIM64;	
  block_dim[46] = `BLOCK_DIM32;				
     // Parameter Block
  for (i=47; i<=48; i = i + 1) block_dim[i] = `BLOCK_DIM8;	
     // Boot Block (TOP)
  block_dim[49] = `BLOCK_DIM16;				

  // Block Mapping
      startBlk_addr[0] = 0;
      endBlk_addr[0] = block_dim[0] - 1;
      for (i = 1; i < `BLOCK_NUM; i = i + 1)      // Block Addresses Setup
          begin
          startBlk_addr[i] =  endBlk_addr[i - 1] + 1; 
          endBlk_addr[i]   =  startBlk_addr[i] + block_dim[i] - 1; 
          end

 // Register Mapping
      for (i = 0 ; i<= 15 ; i = i + 1) begin 
      			
      			
			lock_reg_index[i]=0;
			end
      for (i = 16; i < `BLOCK_NUM; i = i + 1) 
          begin
	  temp =  startBlk_addr[i];
      	  lock_reg_index[i] = temp[20:12];
	  end
	  
      
      
      



     
      for (i = 0; i < `MEMORY_DIM; i = i + 1)  memory[i] = {`DATABUS_DIM{`HIGH}};    // Memory Reset
      if (memoryfile !== "") $readmemb(memoryfile, memory);   // Memory Init 
 
      lockRegInit_task;     // lock registers init  

      lpc_status = `START;
      lpcFastWrite = `FALSE; 
      write_status = `WRITECMD;
      write_status_old = -1;
      completion = `LOW;
      dataout = `LOW;
      msgout = `LOW;
      lpc_cmd = {`LPCBUS_DIM{`HIGH}}; 
      lpc_OutDataBus = {`LPCBUS_DIM{`Z}};
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


  always @(RC)
  begin
    if (`AAMUX_INTERFACE && `SUPPLYON && RESET == `HIGH && $time > 0) begin  
      if (RC == `LOW) mem_addr[`AAMUXADDRBUS_DIM-1: 0] = aamux_AddrBus; 
      else begin
        timeHRC = $time;
        mem_addr[`MEMADDR_DIM-1:`AAMUXADDRBUS_DIM] = aamux_AddrBus; 
        
	byte_num = mem_addr[1:0];		
        -> AddrBusEvent;
      end 
    end
  end
  

  always @(posedge CLK) 
  begin
   if (`LPC_INTERFACE && `SUPPLYON && RESET == `HIGH && $time > 0) begin 
    case (lpc_status)
     `START:
      begin
        if (LFRAME == `LOW) lpc_cmd = lpc_InDataBus; 
        else 
          if (lpc_cmd == `LPC_START) begin
             lpc_cmd = lpc_InDataBus;
             lpc_status = `DIR;
             hold_addr = 0;
             nibble = 0;  
	     lpcFastRead=`LOW;lpc_nByteRead=0;  
           end
         end 
     `DIR:
      begin
        if (`LPCBUSREAD_OP || `LPCBUSWRITE_OP) begin 
           lpc_status = `ADDRIN;
           hold_addr[`ADDRBUS_DIM-1:`ADDRBUS_DIM-4] = lpc_InDataBus;
           nibble = nibble + 1; 
	   if (`LPCBUSFASTREAD_OP) lpcFastRead=`HIGH;  
        end
        else begin 
           lpc_status = `START;
           lpc_cmd = {`LPCBUS_DIM{`HIGH}};   
        end
      end 
     `ADDRIN: 
      begin: addrin_blk
        reg addrvalid;
        case (nibble)
          0:  hold_addr[`ADDRBUS_DIM-1:`ADDRBUS_DIM-4] = lpc_InDataBus;
          1:  hold_addr[`ADDRBUS_DIM-5:`ADDRBUS_DIM-8] = lpc_InDataBus;
          2:  hold_addr[`ADDRBUS_DIM-9:`ADDRBUS_DIM-12] = lpc_InDataBus;
          3:  hold_addr[`ADDRBUS_DIM-13:`ADDRBUS_DIM-16] = lpc_InDataBus;
          4:  hold_addr[`ADDRBUS_DIM-17:`ADDRBUS_DIM-20] = lpc_InDataBus;
          5:  hold_addr[`ADDRBUS_DIM-21:`ADDRBUS_DIM-24] = lpc_InDataBus;
          6:  hold_addr[`ADDRBUS_DIM-25:`ADDRBUS_DIM-28] = lpc_InDataBus;
          7:  hold_addr[`ADDRBUS_DIM-29:`ADDRBUS_DIM-32] = lpc_InDataBus;
          default: begin end
        endcase
        nibble = nibble + 1;
        if (nibble >= 8) begin
          lpcAddrVerify_task(addrvalid);
          if (addrvalid == `TRUE)
             if (`LPCBUSWRITE_OP) begin
               lpc_status = `DATAIN;
               nibble = 0;
               hold_data = 0;
             end
             else lpc_status = `TAR_IN;
        end
      end
     `DATAIN: 
      begin
      if (nibble % 2 == 0)  hold_data[`DATABUS_DIM-5:`DATABUS_DIM-8] = lpc_InDataBus;
                       else hold_data[`DATABUS_DIM-1:`DATABUS_DIM-4] = lpc_InDataBus;
      if (lpcFastWrite)
        begin 
	    if (nibble % 2 != 0) begin 
	    			 pgm_data[nibble / 2] = hold_data;
				 pgm_cell[nibble / 2] = `TRUE;
				 end		 
        end
      nibble = nibble + 1; 
      if ((nibble >= 8 && lpcFastWrite) || (nibble >=2 && !lpcFastWrite)) lpc_status = `TAR_IN;
      end 
     `TAR_IN:
      begin
        lpc_status = `TAR_IN_FLOAT;
      end
     `TAR_IN_FLOAT:
      begin
        if (`LPCBUSWRITE_OP) begin 
                             lpc_OutDataBus = `LPC_RSYNC;   
                             lpc_status = `RSYNC;
                             end
        else begin
             lpc_OutDataBus = `LPC_WSYNC;   
             lpc_status = `WSYNC_1; 
             end 
      end   
     `RSYNC:
      begin

        if (`LPCBUSWRITE_OP) begin 
           lpc_status = `TAR_OUT; 
           lpc_OutDataBus = `LPC_TAR;    
           if (hold_addr[`REGENABLE_ADDR] == `LOW)  RegWriteOp_task; 
                        else MemWriteOp_task; 
        end
        else begin


          nibble = 0;

        end  
      end
     `TAR_OUT:
      begin

        lpc_OutDataBus = {`LPCBUS_DIM{`Z}};
        lpc_status = `TAR_OUT_FLOAT;
      end
     `TAR_OUT_FLOAT:
      begin

        lpc_status = `START;
      end 
     `WSYNC_1:
      begin
        lpc_OutDataBus = `LPC_WSYNC;
        lpc_status = `WSYNC_2;
      end  
     `WSYNC_2:
      begin
        lpc_OutDataBus = `LPC_RSYNC;   

     lpc_status = `DATAOUT;
     nibble = 0;
     hold_data = 0; 

      end       
     `DATAOUT:
      begin
        case (nibble)
          0: begin
                dataout_error = `TRUE;
                if (hold_addr[`REGENABLE_ADDR] == `LOW) RegReadOp_task;  
                else MemReadOp_task;   
             lpc_OutDataBus =  hold_data[`DATABUS_DIM-5:`DATABUS_DIM-8];
             end
          1: begin 
	     lpc_OutDataBus =  hold_data[`DATABUS_DIM-1:`DATABUS_DIM-4]; 
	     if (lpcFastRead==`HIGH) begin 					
	     		   if (hold_addr[`REGENABLE_ADDR] == `LOW) begin 
	 	           					   hold_addr = hold_addr+1;
								   reg_addr  = hold_addr[20:12];
								   mem_addr = hold_addr[`MEMADDR_DIM-1:0];
								   end
			      else mem_addr = mem_addr + 1;
			   lpc_nByteRead = lpc_nByteRead + 1;
		           end
	     end
          default: begin end
        endcase
        nibble = nibble + 1; 
        if (nibble > 2 ) begin
                         
			 lpc_status = `TAR_OUT;
                         lpc_OutDataBus = `LPC_TAR;

			 nibble=0;
			 if (lpcFastRead==`HIGH) 				
			    if (lpc_nByteRead==`LPC_BYTEFASTREAD)
			           begin    
				   lpc_nByteRead=0;
				   lpcFastRead=`LOW;
				   end
		              else lpc_status=`DATAOUT; 
			 end
      end 
     default: begin end
    endcase 
   end
  end   
    

  always @(negedge LFRAME)  
  begin
    if (`LPC_INTERFACE && `SUPPLYON && RESET == `HIGH) begin
      lpc_OutDataBus = {`LPCBUS_DIM{`Z}}; 
      lpc_cmd = {`LPCBUS_DIM{`HIGH}}; 
      if (lpc_status !== `START) begin
          lpc_status = `START;
          $display("Warning! \n Input Communication Frame is Low during a bus operation. The operation is aborted!\n Scope: %m\n Time: %d \n", $time);
      end 
    end
  end
  
  
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
    time2DQ = `LPC_INTERFACE ? `tCHQV  : 0;
    
    if (running_status !== `BUSY_RSTSUSP && Vcc_status == `NORMAL) 
       $display("Warning! \n The Interface Configuration must be selected before power-up or during a reset!\n Scope: %m\n Time: %d \n", $time);  
  end
 

  always @(msgout)
  begin
     case (msg_error) 
       `INVPGM_MSG: 
          begin
             $display("Warning!  Invalid Address \n The memory location addressed is not empty."); 
             $display("The array will not be programmed correctly!\n Scope: %m\n Time: %d \n", $time);
          end
       `WRITEPROTECT_MSG:
          $display("Warning!  Invalid Address \n This block is write protected!\n Scope: %m\n Time: %d \n", $time);
       `VPPPROTECT_MSG:
          begin
             $display("Warning!  Invalid Command \n All blocks are write protected (VPP < VPPLK)!\n"); 
             $display("Scope: %m\n Time: %d \n", $time);
          end   
       `INVEEADDR2_MSG:
          begin
             $display("Warning!  Invalid Address \n It is not possible to program cells in erasing block addresses!\n");
             $display("Scope: %m\n Time: %d \n", $time);
          end   
       `LOCKPROTECT_MSG:
          begin
             $display("Warning!  Invalid Operation \n"); 
             $display("Changes to the selected register cannot be performed (Lock-Down =+ 1)!\n"); 
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `MANUFPROTECT_MSG:
          begin
             $display("Warning!  Invalid Operation \n"); 
             $display("Changes to the Manufacturer Code Register cannot be performed!\n"); 
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `DEVPROTECT_MSG:
          begin
             $display("Warning!  Invalid Operation \n"); 
             $display("Changes to the Device Code Register cannot be performed!\n"); 
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `GPIPROTECT_MSG:
          begin
             $display("Warning!  Invalid Operation \n"); 
             $display("Changes to the General Purpose Input Register cannot be performed!\n"); 
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `INVREGADDR_MSG:
          begin
             $display("Warning!  Invalid Address \n It is not possible to read Interface Configuration Registers!\n");
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `BADCOMMAND_MSG:
          begin
             $display("Warning! \n Invalid Command, Device Busy, or Program/Erase controller error!\n");
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `INVSUSPEND_MSG:
          begin
             $display("Warning!  Invalid Command \n No Erase or Program operations in progress!\n");
             $display("Scope: %m\n Time: %d \n", $time);
          end
       `SRERROR_MSG:
          begin
             $display("Warning!  Invalid Command \n"); 
             $display("P/E Controller Error. Clear Status Register command must be issued before attempting a new command!\n");
             $display("Scope: %m\n Time: %d \n", $time); 
          end
       `INVRESUME_MSG:
          begin
             $display("Warning!  Invalid Command \n"); 
             $display("No Erase or Program operations suspended!\n Scope: %m\n Time: %d \n", $time); 
          end   
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
             begin
                $display("Warning!  Invalid Address \n It is not possible to read cells in programming address!\n");
                $display("Scope: %m\n Time: %d \n", $time);
             end   
         `INVEEADDR_MSG:
             begin
                $display("Warning!  Invalid Address \n It is not possible to read cells in erasing block addresses!\n");
                $display("Scope: %m\n Time: %d \n", $time);
             end   
         `INVESADDR_MSG:
             begin
                $display("Warning!  Invalid Address \n It is not possible to read Manufacturer Code or Device Code!\n");
                $display("Scope: %m\n Time: %d \n", $time);
             end   
         `INVLREGADDR_MSG:
             begin
               $display("Warning!  Invalid Address \n It is not possible to read Interface Configuration Registers!\n");
               $display("Scope: %m\n Time: %d \n", $time);
             end  
         `BADCOMMAND_MSG:
             begin
               $display("Warning! \n Invalid Command, Device Busy, or Program/Erase controller error!\n");
               $display("Scope: %m\n Time: %d \n", $time);  
             end  
         default: 
             $display("Error! \n  Invalid data!\n Scope: %m\n Time: %d \n", $time);
       endcase
       dataout_error = `FALSE;
    end       
    
    if (`AAMUX_INTERFACE && G_N == `LOW) aamux_OutDataBus = hold_data;
    else aamux_OutDataBus = {`AAMUXADDRBUS_DIM{`Z}};
    
  end


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
        if (`LPC_INTERFACE) begin
           lpc_OutDataBus = {`LPCBUS_DIM{`Z}};
           lpc_cmd = {`LPCBUS_DIM{`HIGH}};
           lpc_status = `START;
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

// --------------------------------------------------------------
//
// ------------------------  Task  ------------------------------
// 
// --------------------------------------------------------------


task lockRegInit_task; 
  integer i;
  begin
    
    for (i = 0; i < `REG_NUM-1; i = i+1) lock_reg[i] = `WRITELOCK;    
  end
  endtask


task lpcAddrVerify_task;   
  output addr_valid;
  begin
     addr_valid = `TRUE;
     if (hold_addr[`ADDRBUS_DIM-1:26] !== {(`ADDRBUS_DIM-26){`HIGH}} || 			

	{hold_addr[25:23],hold_addr[21]} !== ~id_internal) begin				
        lpc_OutDataBus = {`LPCBUS_DIM{`Z}}; 
        lpc_cmd = {`LPCBUS_DIM{`HIGH}}; 
        lpc_status = `START;
        addr_valid = `FALSE;
     end
     else begin
        mem_addr = hold_addr[`MEMADDR_DIM-1:0];
        reg_addr = hold_addr[20:12];    
     end  
  end 
  endtask


task findblock_task;
  input [`MEMADDR_DIM:0] addr; 
  integer i;
  begin  
    for (i = 0; i < `BLOCK_NUM; i = i + 1) 
       if (startBlk_addr[i] <= addr && endBlk_addr[i] >= addr) n_block = i; 		

    if (n_block<=15) n_block_reg = 0;    						
	else n_block_reg = n_block - 15;	        				
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
  input op_type;
  output errflag;
  begin
    errflag = `FALSE;
    findblock_task(mem_addr);
    case (op_type)
      `WRITEOP: 
         if ((TBL_N == `LOW && n_block == `TOPBLOCK) || 
            (WP_N == `LOW && n_block !== `TOPBLOCK) || 
            ((lock_reg[n_block_reg] & `WRITELOCK) == `WRITELOCK) )  begin
            msg_error = `WRITEPROTECT_MSG;
            msgout <= #time2DQ ~msgout;
                                 
            write_status = `WRITECMD;
            read_status = `READSTATUSREG;
            SR = (SR | `SRPROTECERR);
            errflag = `TRUE; 
          end 
      `READOP:
         if ((lock_reg[n_block_reg] & `READLOCK) == `READLOCK) errflag = `TRUE; 
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
      $display("Warning!  Invalid Command \n Quadruple Byte Program operation cannot be performed (VPP < VPPH)!\n");
      $display("Scope: %m\n Time: %d \n", $time);   
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
    if (`LPC_INTERFACE && error_flag == `FALSE) protectCheck_task(`WRITEOP, error_flag);       
    if (error_flag == `FALSE) begin
       running_status = `BUSY_PGM;
       write_status = `WRITECMD;
       read_status = `READSTATUSREG;
       SR = (SR & `SRPGMSTART);
       RB = `LOW;
       
       if (cmd == `QBPGM_4) begin
          for (n_byte = 0; n_byte < 4; n_byte=n_byte+1) begin
            
	    pgm_addr[n_byte] = {mem_addr[`MEMADDR_DIM-1:2], n_byte[1:0]}; 	
            if (pgm_cell[n_byte] == `TRUE) locationPGM_task(pgm_addr[n_byte], pgm_data[n_byte]); 
          end
	  lpcFastWrite = `FALSE;   
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
     if (`LPC_INTERFACE) timeDataOut = time2DQ;
 
     dataout <= #timeDataOut ~dataout;
  end
  endtask
  
  
  task FindReg;
  input [9:0] InpReg;
  output [31:0] index;
  integer i;
  	begin
	lock_reg_index[`BLOCK_NUM] = InpReg;
 	for (i = 0; lock_reg_index[i] != InpReg;i = i + 1) index = i; 
	index = i;
	end
  endtask

  task RegReadOp_task;
  integer index;
  begin
       FindReg(reg_addr,index); 
       if ((index<`BLOCK_NUM) && (mem_addr == {reg_addr, `LOCKREG_ADDR})) begin 
    
    
       findblock_task(mem_addr);				
       dataout_error = `FALSE; 
       
       if (index<=15) begin hold_data = lock_reg[0];end
       		else begin hold_data = lock_reg[index-15];end
       $display("Value %h read from Lock Register Address %h \n", hold_data, mem_addr);
       $display("  Scope: %m\n Time: %d \n\n",$time);
       end
     else if (mem_addr==`MANUF_REG) begin
       dataout_error = `FALSE;
       hold_data = `MANUFCODE;
       $display("Manufacturer Code Register: value %h read \n Scope: %m\n Time: %d \n\n", hold_data, $time);
     end 
     else if (mem_addr==`DEV_REG) begin
       dataout_error = `FALSE;
       hold_data = `DEVCODE;
       $display("Device Code Register: value %h read \n Scope: %m\n Time: %d \n\n", hold_data, $time);
     end 
     
     else if (mem_addr == `GPI_ADDR) begin
       dataout_error = `FALSE;
       hold_data = GPI;  
       $display("General Purpose Input Register: value %h read \n Scope: %m\n Time: %d \n\n", hold_data, $time);
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
           $display("Read Status Register value %h \n Scope: %m\n Time: %d\n", hold_data, $time);
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
              if (`LPC_INTERFACE) protectCheck_task(`READOP, error_flag); 
              if (error_flag == `TRUE) begin 
                 hold_data = {`DATABUS_DIM{`LOW}}; 
                 msg_error = `READPROTECT_MSG;
              end 
              else begin
                 dataout_error = `FALSE;
                 hold_data = memory[mem_addr];   
                 $display("Read value %h at address %h\n Scope: %m\n Time: %d\n", hold_data, mem_addr, $time);
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
              $display("Read Manufacturer Code %h \n Scope: %m\n Time: %d\n", hold_data, $time);
           end 
           else if (mem_addr == `DEVCODE_ADDR) begin
             dataout_error = `FALSE;
             hold_data = `DEVCODE; 
             $display("Read Device Code %h\n Scope: %m\n Time: %d\n", hold_data, $time);
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
  integer index;
  begin
    FindReg(reg_addr,index); 
    
    if ((index<`BLOCK_NUM) && (mem_addr == {reg_addr, `LOCKREG_ADDR})) begin 
    
    
      if (index<=15) begin index=0; end
       		else begin index = index - 15;end
      if ((lock_reg[index] & `LOCKDOWN) == `LOCKDOWN) begin
         msg_error = `LOCKPROTECT_MSG;
         msgout <= #time2DQ ~msgout; 
      end
      else begin 
            lock_reg[index] = (8'b00000111 & hold_data);
            $display("Value %d written at Lock Register Address %h \n", hold_data, mem_addr);
            $display("Scope: %m\n Time: %d \n\n", $time);
           end 
    end 
    else 
      if (mem_addr==`MANUF_REG) begin 
         msg_error = `GPIPROTECT_MSG;
         msgout <= #time2DQ ~msgout; 
      end
      else 
         if (mem_addr==`DEV_REG) begin 
            msg_error = `GPIPROTECT_MSG;
            msgout <= #time2DQ ~msgout; 
          end
         else 
          if (mem_addr == `GPI_ADDR) begin
            msg_error = `GPIPROTECT_MSG;
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
         read_status = `READSTATUSREG; 	
	SR = (SR | `SR_SEQCMDERR);					
    end
    else if (hold_data !== `CHIPEECONF && cmd == `CHIPERASE) begin 
        msg_error = `INVCHIPEECONFIRM_MSG;
        msgout <= #time2DQ ~msgout;   
        write_status = `WRITECMD;
         read_status = `READSTATUSREG; 	
	SR = (SR | `SR_SEQCMDERR);					

    end
    else begin 
        vppCheck_task(cmd, error_flag);
        if (`LPC_INTERFACE && error_flag == `FALSE) protectCheck_task(`WRITEOP, error_flag);
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
                   $display("Read Memory Array Command ! \n\n Scope: %m\n Time: %d\n",$time);
               end
               else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end 
             end
            `RSR:
             begin  
                read_status = `READSTATUSREG;
                $display("Read Status Register Command ! \n\n Scope: %m\n Time: %d\n",$time);
             end
            `RSIG_1, `RSIG_2:
             begin
                if (running_status == `FREE) begin 
                   dataout_error = `TRUE;
                   read_status = `READELECTSIG;
                   $display("Read Electronic Signature Command ! \n\n Scope: %m\n Time: %d\n",$time);
                end
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end   
             end
            `BLKEE:
             begin
                if (running_status == `FREE &&  `SR_EEFREE) 
                   begin 
                      write_status = `BLKERASE;
                      $display("Block Erase Command ! \n\n Scope: %m\n Time: %d\n",$time);
                   end
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end    
             end
            `CHIPEE:
             begin
               if (`AAMUX_INTERFACE && running_status == `FREE &&  `SR_EEFREE) 
                  begin
                   write_status = `CHIPERASE;
                   $display("Chip Erase Command ! \n\n Scope: %m\n Time: %d\n",$time);
                  end 
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
               end    
             end
            `PG_1, `PG_2:
             begin
                if (running_status == `FREE && `SR_PGMFREE) 
                   begin
                     write_status = `PROGRAM;
                     $display("Program Command ! \n\n Scope: %m\n Time: %d\n",$time);
                   end  
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
                end   
             end
            `QPGM_AAMUX:
     	     begin:blk_qpgm
                integer i;
                if (`AAMUX_INTERFACE && running_status == `FREE && `SR_PGMFREE) 
                   begin
                     write_status = `QBPGM_1;
                     for (i = 0; i < 4; i = i+1) begin 
                        pgm_cell[i] = `FALSE;
                        pgm_data[i] = {`DATABUS_DIM{`HIGH}};
                      end
                      $display("Quadruple Byte Program Command (A/A Mux Mode) ! \n\n Scope: %m\n Time: %d\n",$time);
                   end
                else begin
                  msg_error = `BADCOMMAND_MSG;
                  msgout <= #time2DQ ~msgout;   
                end   
             end
	    `QPGM_LPC:
	     begin:blk_qpgm2
	        integer i;
	        if (`LPC_INTERFACE && running_status == `FREE &&  `SR_PGMFREE)
		     begin
                     write_status = `QBPGM_LPC;
		     lpcFastWrite = `TRUE;
	     	     for (i = 0; i < 4; i = i + 1) begin 
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
                if (running_status == `FREE) 
                  begin
                     SR = (SR & `SRCLEAR);
                      $display("Clear Status Register Command ! \n\n Scope: %m\n Time: %d\n",$time);
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
               else 
                  if (running_status == `BUSY_PGM) 
                     begin
                       timePGM_susp = $time;
                       running_status = `BUSY_PGMSUSP;
                       completion <= #`PGMSUSP_LATENCY ~completion;
                       $display("Program Suspend Command ! \n\n Scope: %m\n Time: %d\n",$time);
                     end
               else begin
                  timeEE_susp = $time;
                  running_status = `BUSY_BLKEESUSP;
                  completion <= #`EESUSP_LATENCY ~completion;
                  $display("Erase Suspend Command ! \n\n Scope: %m\n Time: %d\n",$time);
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
                  $display("Program Resume Command ! \n\n Scope: %m\n Time: %d\n",$time);
               end 
               else if (running_status == `FREE && `SR_EESUSP) begin
                  running_status = `BUSY_BLKEE;
                  SR = (SR & `SREESTART);
                  RB = `LOW;
                  read_status = `READSTATUSREG;
                  if (chipErase == `TRUE)  completion <= #(`CHIPEE_TIME - timeEE_susp + timeEE_start) ~completion;  
                  else  completion <= #(`BLKEE_TIME - timeEE_susp + timeEE_start) ~completion;  
                  $display("Erase Resume Command ! \n\n Scope: %m\n Time: %d\n",$time);
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
        `CHIPERASE: 
         begin
           erase_task(`CHIPERASE);  
         end  
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
	`QBPGM_LPC:
	 begin
	   program_task(`QBPGM_4);
	 end 	 
        default: begin
             $display("Error! \n Invalid write status!\n Scope: %m\n Time: %d \n", $time);
         end
      endcase
  end
  endtask


  specify
    // LPC AC Signal Timing characteristics 
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
   
    
 
    // LPC Interface Clock Characteristics 
    $width(posedge CLK &&& `LPC_INTERFACE, tHIGH);
    $width(negedge CLK &&& `LPC_INTERFACE, tLOW);
    $period(posedge CLK &&& `LPC_INTERFACE, tCYC); 
    // LPC Interface AC Signal Timing Characteristics    
    $setuphold(posedge CLK &&& `LPC_INTERFACE, LAD, tDVCH, tCHDX);   
    $setuphold(posedge CLK &&& `LPC_INTERFACE, LFRAME, tFLCH, tCHFH);   
    $hold(posedge RESET, negedge LFRAME &&& `LPC_INTERFACE, tPHFL); 
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

