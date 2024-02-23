/***************************************************************************** 
    
                                             16 Mbit (2 Mbyte x 8, Boot Block) 
                                          
                                          3V Supply Low Pin Count Flash Memory
                
                                         Stimule  for  Device Name:  M50LPW116

              Reading and Writing on the LPC Interface Configuration Registers 
  
                                         Copyright (c) 2003 STMicroelectronics
  
****************************************************************************** 
  
  Version History
  
  Version: 1.0
  Date   : 02/24/03
  Author : Giuseppe Tomasino
           Tel    : +39916689948
           e-mail : giuseppe.tomasino@st.com

  
******************************************************************************   
  
    THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,        
    EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE        
    IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR      
    PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERforMANCE OF         
    THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU      
    ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.     
  
*****************************************************************************/ 

`include "m50lpw116.h"
`include "def.h"

`define CLKPERIOD 30
`define DELAY 200 
`define ADD_2524   2'b11     // A25 - A24
`define ADD_23     1'b1      // A23
`define ADD_21     1'b1      // A21 
`define DEVID   4'b0000      // DEVICE ID

module stim (lad, lframe, rfu, id, gpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  output lframe, clk, ic, tbl_n, wp_n, init_n, rp_n;
  output [4:0] gpi;
  output [4:0] rfu;
  output [3:0] lad;
  output [3:0] id;
  
  output  vcc, vpp, vpph, vss;  

  reg start;  
  reg lframe, ic, tbl_n, wp_n, init_n, rp_n;  
  reg [3:0] lad_bus;  
  reg [3:0] dev_id;
  
  wire [4:0] gpi = 5'b01011;
  wire [4:0] rfu = 5'bZZZZZ;
  wire [3:0] lad;
  assign lad[3:0] = lad_bus[3:0];

  nand #15 (clk, start, clk);
  
  real vcc_real, vpp_real;
  
  assign vcc = (`VCC_LOW ? `LOW : `HIGH);
  assign vpp = (`VPP_HIGH ? `HIGH : `LOW);
  assign vpph = (`VPP_FAST ? `HIGH : `LOW);
  assign vss = 0;   
  assign id = dev_id; 
   
  task lpc_readMemory;
  input [`MEMADDR_DIM-1:0] address;
  begin
    #10  lframe = `LOW;
         lad_bus = `LPC_START;
    #`CLKPERIOD lframe = `HIGH;
                lad_bus = `LPC_READ;
    #`CLKPERIOD lad_bus = 4'hF;                                                 // 31 - 28
    #`CLKPERIOD lad_bus = {2'b11, `ADD_2524};                                   // 27 - 24
    #`CLKPERIOD lad_bus = {`ADD_23,1'b1,`ADD_21, address[`MEMADDR_DIM-1]};      // 23 - 20
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-2:`MEMADDR_DIM-5];               // 19 - 16
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-6:`MEMADDR_DIM-9];               // 15 - 12
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-10:`MEMADDR_DIM-13];             // 11 -  8
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-14:`MEMADDR_DIM-17];             //  7 -  4
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-18:`MEMADDR_DIM-21];             //  3 -  0
    #`CLKPERIOD lad_bus = `LPC_TAR;
    #`CLKPERIOD lad_bus = {`LPCBUS_DIM{`Z}};
  end
  endtask
  
  task lpc_readRegister;
  input [`MEMADDR_DIM:0] reg_addr;
  begin
    #10  lframe = `LOW;
         lad_bus = `LPC_START;
    #`CLKPERIOD lframe = `HIGH;
                lad_bus = `LPC_READ;
    #`CLKPERIOD lad_bus = 4'hF;
    #`CLKPERIOD lad_bus = {2'b11, `ADD_2524};                                    // 27 - 24
    #`CLKPERIOD lad_bus = {`ADD_23, 1'b0, `ADD_21, reg_addr[`MEMADDR_DIM-1]};    // 23 - 20
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-2:`MEMADDR_DIM-5];               
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-6:`MEMADDR_DIM-9];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-10:`MEMADDR_DIM-13];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-14:`MEMADDR_DIM-17];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-18:`MEMADDR_DIM-21];
    #`CLKPERIOD lad_bus = `LPC_TAR;
    #`CLKPERIOD lad_bus = {`LPCBUS_DIM{`Z}};
  end
  endtask
  
 
  task lpc_writeMemory;
  input [`MEMADDR_DIM-1:0] address;
  input [`DATABUS_DIM-1:0] data;
  begin
    #10  lframe = `LOW;
         lad_bus = `LPC_START;
    #`CLKPERIOD lframe = `HIGH;
                lad_bus = {`LPC_WRITE, 1'b0};     // LPC_WRITE non deve essere 3 ma 6 o 7
    #`CLKPERIOD lad_bus = 4'hF;                                                  // 31 - 28
    #`CLKPERIOD lad_bus = {2'b11, `ADD_2524};                                    // 27 - 24
    #`CLKPERIOD lad_bus = {`ADD_23, 1'b1, `ADD_21, address[`MEMADDR_DIM-1]};     // 23 - 20
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-2:`MEMADDR_DIM-5];                // 19 - 16
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-6:`MEMADDR_DIM-9];                // 15 - 12
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-10:`MEMADDR_DIM-13];              // 11 -  8
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-14:`MEMADDR_DIM-17];              //  7 -  4
    #`CLKPERIOD lad_bus = address[`MEMADDR_DIM-18:`MEMADDR_DIM-21];              //  3 -  0 
    #`CLKPERIOD lad_bus = data[`DATABUS_DIM-5:`DATABUS_DIM-8]; 
    #`CLKPERIOD lad_bus = data[`DATABUS_DIM-1:`DATABUS_DIM-4]; 
    #`CLKPERIOD lad_bus = `LPC_TAR;
    #`CLKPERIOD lad_bus = {`LPCBUS_DIM{`Z}};
  end
  endtask
  

  task lpc_writeRegister;
  input [`MEMADDR_DIM:0] reg_addr;
  input [`DATABUS_DIM-1:0] data;
  begin
    #10  lframe = `LOW;
         lad_bus = `LPC_START;
    #`CLKPERIOD lframe = `HIGH;
                lad_bus = {`LPC_WRITE, 1'b0};
    #`CLKPERIOD lad_bus = 4'hF;
    #`CLKPERIOD lad_bus = {2'b11, `ADD_2524};                                    // 27 - 24
    #`CLKPERIOD lad_bus = {`ADD_23, 1'b0, `ADD_21, reg_addr[`MEMADDR_DIM-1]};     // 23 - 20
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-2:`MEMADDR_DIM-5];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-6:`MEMADDR_DIM-9];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-10:`MEMADDR_DIM-13];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-14:`MEMADDR_DIM-17];
    #`CLKPERIOD lad_bus = reg_addr[`MEMADDR_DIM-18:`MEMADDR_DIM-21];
    #`CLKPERIOD lad_bus = data[`DATABUS_DIM-5:`DATABUS_DIM-8]; 
    #`CLKPERIOD lad_bus = data[`DATABUS_DIM-1:`DATABUS_DIM-4]; 
    #`CLKPERIOD lad_bus = `LPC_TAR;
    #`CLKPERIOD lad_bus = {`LPCBUS_DIM{`Z}};
  end
  endtask

  task lpc_readMemoryArrayCmd;
  begin
    lpc_writeMemory(21'h1FFFFF, `RD);
  end
  endtask

  task lpc_readStatusRegisterCmd;
  begin
    lpc_writeMemory(21'h1FFFFF, `RSR);
  end
  endtask

  task lpc_clearStatusRegisterCmd;
  begin
    lpc_writeMemory(21'h1FFFFF, `CLRSR);
  end
  endtask

  task lpc_electronicSignatureCmd;
  begin
    lpc_writeMemory(21'h1FFFFF, `RSIG_2);
  end
  endtask

  task lpc_programCmd;
  input [`ADDRBUS_DIM-1:0] address;
  input [`DATABUS_DIM-1:0] data;
  begin
    lpc_writeMemory(21'h1FFFFF, `PG_1);
    #`DELAY lpc_writeMemory(address, data); 
  end
  endtask

  task lpc_blockEraseCmd;
  input [`ADDRBUS_DIM-1:0] address;
  begin
    lpc_writeMemory(21'h1FFFFF, `BLKEE);
    #`DELAY lpc_writeMemory(address, `PER); 
  end
  endtask
  
  task lpc_programEraseSuspendCmd;
  begin
    lpc_writeMemory(21'h1FFFFF, `PES);
  end
  endtask  
  
  task lpc_programEraseResumeCmd;
  begin
    lpc_writeMemory(21'h1FFFFF, `PER);
  end
  endtask  
 
  initial 
    begin
      vcc_real = 3.0;
      vpp_real = 3.0;
      ic       = `LOW;
      tbl_n    = `HIGH;
      wp_n     = `HIGH;
      init_n   = `HIGH;
      rp_n     = `HIGH;
     
      dev_id   = `DEVID; 
      lframe   = `HIGH; 
      start    = 0;
      lad_bus  = 4'bzzzz;
      
      #30 start = 1;   
    end 
  
    initial
    begin
      #3000 lpc_writeRegister(21'h030002,8'h00);       // Unlock Block 18 (Address FFA30002)
      #500  lpc_writeRegister(21'h140002,8'h00);       // Unlock Block 35 (Address FFB40002)
      #500  lpc_readRegister(21'h030002);
      #500  lpc_readRegister(21'h1E0002);              // Read Block 45 (Address FFBE0002)
      #500  lpc_readRegister(21'h1C0000);              // Read Manufacturer Code Register
      #500  lpc_readRegister(21'h1C0001);              // Read Device Code Register
      #500  lpc_readRegister(21'h1C0100);              // Read General Purpose Input Register

      #1000 $finish;
    end


endmodule
