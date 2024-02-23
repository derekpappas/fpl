/***************************************************************************** 
    
                                             16 Mbit (2 Mbyte x 8, Boot Block) 
                                          
                                          3V Supply Low Pin Count Flash Memory
                
                                         Stimule  for  Device Name:  M50LPW116

                                Chip Erase Command - Testbench AAMUX Interface
  
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

module stim (lad, lframe, rfu, id, gpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  output lframe, clk, ic, tbl_n, wp_n, init_n, rp_n;
  output [4:0] gpi;
  output [4:0] rfu;
  output [3:0] lad;
  output [3:0] id;
  output  vcc, vpp, vpph, vss;  

  
  real vcc_real, vpp_real;
  assign vcc = (`VCC_LOW ? `LOW : `HIGH);
  assign vpp = (`VPP_HIGH || `VPP_FAST ? `HIGH : `LOW);
  assign vpph = (`VPP_FAST ? `HIGH : `LOW);
  assign vss = 0;   
  
  reg [`AAMUXADDRBUS_DIM-1:0] addressBus;
  assign gpi = addressBus[`AAMUXADDRBUS_DIM-1:`AAMUXADDRBUS_DIM-5];
  assign wp_n = addressBus[`AAMUXADDRBUS_DIM-6];
  assign tbl_n = addressBus[`AAMUXADDRBUS_DIM-7];
  assign id = addressBus[`AAMUXADDRBUS_DIM-8:`AAMUXADDRBUS_DIM-11];
  //assign rfu[6:5] = addressBus[`AAMUXADDRBUS_DIM-10:`AAMUXADDRBUS_DIM-11];

  reg [`DATABUS_DIM-1:0] dataOut; 
  assign rfu[3:0] = dataOut[`DATABUS_DIM-1:`DATABUS_DIM-4];
  assign lad = dataOut[`DATABUS_DIM-5:`DATABUS_DIM-8];
     
  wire [`DATABUS_DIM-1:0] dataBus;
  assign dataBus[`DATABUS_DIM-1:`DATABUS_DIM-4] = rfu[3:0];
  assign dataBus[`DATABUS_DIM-5:`DATABUS_DIM-8] = lad;  
  assign dataBus = dataOut;
 
  //wire rb = rfu[4];
  reg rfu4;
  wire rb;

  assign rb = rfu4;
  
  reg rc, ic, rp_n,   g_n, w_n;
  assign init_n = g_n;
  assign lframe = w_n; 
  assign clk = rc;

  
  task aamux_writeData;
  input [`MEMADDR_DIM-1:0] addr;  
  input [`DATABUS_DIM-1:0] data; 
  begin
     addressBus = addr[`AAMUXADDRBUS_DIM-1:0];  
     #50 rc = `LOW; 
     #50 w_n = `LOW;
     #50 addressBus = { 2'b11, addr[`MEMADDR_DIM-1:`AAMUXADDRBUS_DIM]};
         dataOut = data;
     #50 rc = `HIGH;
     #50 w_n = `HIGH;
     #10 addressBus= { `AAMUXADDRBUS_DIM {`Z} };
     #10 dataOut = {`DATABUS_DIM{`Z}};   
  end
  endtask
  
  task aamux_writeCmd;
  input [`DATABUS_DIM-1:0] data;
  begin
     rc = `LOW; 
     #40 w_n = `LOW;
     #40 dataOut = data;
     #40 rc = `HIGH;
     #50 w_n = `HIGH;
     #10 addressBus= { `AAMUXADDRBUS_DIM {`Z} };
     #10 dataOut = {`DATABUS_DIM{`Z}};   
  end
  endtask
  

  task aamux_readData;
  input [`MEMADDR_DIM-1:0] addr;
  begin
    addressBus = addr[`AAMUXADDRBUS_DIM-1:0];  
    #50 rc = `LOW; 
    #50 addressBus = { 2'b11, addr[`MEMADDR_DIM-1:`AAMUXADDRBUS_DIM]};
    #50 rc = `HIGH;
    #50 addressBus = { `AAMUXADDRBUS_DIM {`Z} };
    #50 g_n = `LOW;
    #150 g_n = ~g_n;
  end
  endtask


  task aamux_readStatusRegOp;
  begin
    #100 g_n = `LOW;
    #150 g_n = ~g_n; 
  end
  endtask



  task aamux_readMemoryArrayCmd;
  begin
    aamux_writeCmd(`RD);
  end  
  endtask
  
  task aamux_readStatusRegCmd;
  begin
    aamux_writeCmd(`RSR);
  end
  endtask

  task aamux_clearStatusRegCmd;
  begin
    aamux_writeCmd(`CLRSR);
  end
  endtask   

  task aamux_readElectronicSignatureCmd;
  begin
    aamux_writeCmd(`RSIG_1);
  end
  endtask   

  
  task aamux_programCmd;
  input [`MEMADDR_DIM-1:0] address;
  input [`DATABUS_DIM-1:0] data; 
  begin
    aamux_writeCmd(`PG_2);
    #100 aamux_writeData(address, data);
  end
  endtask   

  task aamux_QuadrupleProgramCmd;
  input [`MEMADDR_DIM-1:0]  address1, address2, address3, address4;
  input [`DATABUS_DIM-1:0] data1, data2, data3, data4; 
  begin
    aamux_writeCmd(`QPGM_AAMUX);
    #100 aamux_writeData(address1, data1);
    #100 aamux_writeData(address2, data2);
    #100 aamux_writeData(address3, data3);
    #100 aamux_writeData(address4, data4);

  end
  endtask   
  
  task aamux_blkEraseCmd;
  input [`MEMADDR_DIM-1:0]  address;
  begin
    aamux_writeCmd(`BLKEE);
    #100 aamux_writeData(address, `PER);
  end
  endtask
 

  task aamux_chipEraseCmd;
  begin
    aamux_writeCmd(`CHIPEE);
    #100 aamux_writeCmd(`CHIPEECONF);
  end
  endtask
 

  task aamux_peSuspCmd;
  begin
     aamux_writeCmd(`PES); 
  end
  endtask

  task aamux_peResumeCmd;
  begin
     aamux_writeCmd(`PER); 
  end
  endtask
  
  
  initial 
    begin
      vcc_real = 3.0;
      vpp_real = 12.0;
      ic = `HIGH;
      rp_n = `HIGH;
      rfu4 = `Z;
    end 
  
  initial
    begin
      g_n = `HIGH;
      w_n = `HIGH;    
      dataOut = {`DATABUS_DIM{`Z}};
      addressBus = {`AAMUXADDRBUS_DIM{`Z}};
      rc = `HIGH;
    end

   

  initial
    begin
      
      #3000 aamux_QuadrupleProgramCmd(21'h1AB650,21'h1AB651,21'h1AB652,21'h1AB653,8'h22,8'h35,8'hCE,8'hD0);
      #(`PGM_TIME) ;
      #500  aamux_readMemoryArrayCmd;          // Read Memory Array Command
      #500  aamux_readData(21'h1AB650);
      #500  aamux_readData(21'h1AB651);        // Read Data
      #500  aamux_readData(21'h1AB652);
      #500  aamux_readData(21'h1AB653);
      #500  aamux_chipEraseCmd;                // Chip Erase Command
      #(`CHIPEE_TIME) ;
      #500  aamux_readData(21'h1AB600);        // Read Status Register
      #500  aamux_readMemoryArrayCmd;          // Read Memory Array Command
      #500  aamux_readData(21'h1AB652);        // Read Data
      #1000 $finish;
      
    end


endmodule
