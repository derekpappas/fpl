/***************************************************************************** 
    
    Testbench AAMUX Interface
  
******************************************************************************   
  
    THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,        
    EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE        
    IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR      
    PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERforMANCE OF         
    THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU      
    ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.     
  
*****************************************************************************/ 



`define DATABUS_DIM 8     
`define MEMADDR_DIM 19	//Change
`define AAMUXADDRBUS_DIM 11
`define HIGH 1'b1
`define LOW  1'b0
`define X    1'bX
`define Z    1'bZ
`define FALSE 1'b0
`define TRUE 1'b1

`define MANUFCODE_ADDR 19'h00000 //Change
`define DEVCODE_ADDR   19'h00001 //Change
`define GPI_ADDR       19'h40100 //Change
`define LOCKREG_ADDR   16'h0002

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

`define VPPLK     1.5
`define VPP1_LOW  3.0
`define VPP1_HIGH 3.6
`define VPPH_LOW  11.4
`define VPPH_HIGH 12.6 
`define VCCLK     2.3

`define VCC_LOW (vcc_real < `VCCLK)
`define VPP_HIGH (vpp_real >= `VPP1_LOW && vpp_real <= `VPP1_HIGH)
`define VPP_FAST (vpp_real >= `VPPH_LOW && vpp_real <= `VPPH_HIGH)

`timescale 1 ns / 100 ps 

module stim (fwh, fwh4, rfu, id, fgpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  output fwh4, clk, ic, tbl_n, wp_n, init_n, rp_n;
  output [4:0] fgpi;
  output [4:0] rfu;
  output [3:0] fwh;
  output [3:0] id;
  output  vcc, vpp, vpph, vss;  
  
  real vcc_real, vpp_real;
  assign vcc = (`VCC_LOW ? `LOW : `HIGH);
  assign vpp = (`VPP_HIGH || `VPP_FAST ? `HIGH : `LOW);
  assign vpph = (`VPP_FAST ? `HIGH : `LOW);
  assign vss = 0;   
  
  reg [`AAMUXADDRBUS_DIM-1:0] addressBus;
  assign fgpi = addressBus[`AAMUXADDRBUS_DIM-1:`AAMUXADDRBUS_DIM-5];
  assign wp_n = addressBus[`AAMUXADDRBUS_DIM-6];
  assign tbl_n = addressBus[`AAMUXADDRBUS_DIM-7];

  //assign rfu[4] = addressBus[`AAMUXADDRBUS_DIM-8];  //Change

  assign id = addressBus[`AAMUXADDRBUS_DIM-8:`AAMUXADDRBUS_DIM-11]; //Change

  reg [`DATABUS_DIM-1:0] dataOut; 
  assign rfu[3:0] = dataOut[`DATABUS_DIM-1:`DATABUS_DIM-4];
  assign fwh = dataOut[`DATABUS_DIM-5:`DATABUS_DIM-8];
     
  wire [`DATABUS_DIM-1:0] dataBus;
  assign dataBus[`DATABUS_DIM-1:`DATABUS_DIM-4] = rfu[3:0];
  assign dataBus[`DATABUS_DIM-5:`DATABUS_DIM-8] = fwh;  
  assign dataBus = dataOut;
 
  wire rb = rfu[4];
  
  reg rc, ic, rp_n,   g_n, w_n;
  assign init_n = g_n;
  assign fwh4 = w_n; 
  assign clk = rc;

  
  task aamux_writeData;
  input [`MEMADDR_DIM-1:0] addr;  
  input [`DATABUS_DIM-1:0] data; 
  begin
     addressBus = addr[`AAMUXADDRBUS_DIM-1:0];  
     #50 rc = `LOW; 
     #50 w_n = `LOW;
     #50 addressBus = { 3'b111, addr[`MEMADDR_DIM-1:`AAMUXADDRBUS_DIM]}; //change
         dataOut = data;
     #50 rc = `HIGH;
     #50 w_n = `HIGH;
     #10 dataOut = {`DATABUS_DIM{`Z}};   
  end
  endtask
  
  task aamux_writeCmd;
  input [`DATABUS_DIM-1:0] data;
  begin
     rc = `LOW; 
     #50 w_n = `LOW;
     #50 dataOut = data;
     #50 rc = `HIGH;
     #50 w_n = `HIGH;
     #10 dataOut = {`DATABUS_DIM{`Z}};   
  end
  endtask
  

  task aamux_readData;
  input [`MEMADDR_DIM-1:0] addr;
  begin
    addressBus = addr[`AAMUXADDRBUS_DIM-1:0];  
    #50 rc = `LOW; 
    #50 addressBus = { 3'b111, addr[`MEMADDR_DIM-1:`AAMUXADDRBUS_DIM]}; //Change
    #50 rc = `HIGH;
    #100 g_n = `LOW;
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

  task aamux_electronicSignCmd;
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

  task aamux_QuadProgramCmd;
  input [`MEMADDR_DIM-1:0]  address1, address2, address3, address4;
  input [`DATABUS_DIM-1:0] data1, data2, data3, data4; 
  begin
    aamux_writeCmd(`QPGM);
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
      vpp_real = 3.0;
      ic = `HIGH;
      rp_n = `HIGH;
    end 
  
  initial
    begin
      g_n = `HIGH;
      w_n = `HIGH;    
      dataOut = {`DATABUS_DIM{`Z}};
      rc = `HIGH;
    end

   

  initial
    begin
      #1000 aamux_electronicSignCmd;
      #500  aamux_readStatusRegOp;
      #2000 vpp_real = 12.0;  

      #200  aamux_QuadProgramCmd(19'h1FB00, 19'h1FB01, 19'h1FB02, 19'h1FB03, 8'hEA, 8'hB3, 8'h42, 8'hF3);       
      #200  aamux_readStatusRegOp;
      #1000 aamux_readStatusRegOp;
      #100  aamux_peSuspCmd; 
      #500  aamux_readStatusRegOp;
      #1000 aamux_readStatusRegOp;
      #600  aamux_readStatusRegOp;
      #100  aamux_electronicSignCmd;
      #100  aamux_readData(19'h00000);           
      #500  aamux_peResumeCmd;
      #200  aamux_readStatusRegOp;
      #1000 aamux_readStatusRegOp;
      #1500 aamux_readStatusRegOp;
      #100  vpp_real = 3.0;  
      #100  aamux_readMemoryArrayCmd; 
      #100  aamux_readData(19'h1FB00); 
      #100  aamux_readData(19'h1FB01);
      #100  aamux_readData(19'h1FB02); 
      #100  aamux_readData(19'h1FB03);  
      #200  aamux_chipEraseCmd; 
      #2500 aamux_readStatusRegOp;
      #5500 aamux_readStatusRegOp;
      #2500 aamux_readStatusRegOp;
      #2000 aamux_readStatusRegOp;
      #100  aamux_readMemoryArrayCmd; 
      #3000 aamux_readStatusRegOp;
      #2000 aamux_readStatusRegOp;
      #2000 aamux_readStatusRegOp; 
      #100  aamux_readMemoryArrayCmd; 
      #100  aamux_readData(19'h1FB00); 
      #100  aamux_readData(19'h1FB01);
      #100  aamux_readData(19'h1FB02); 
      #100  aamux_readData(19'h1FB03);  
      
      #1000 $finish;
    end


endmodule

module test;
  wire fwh4, clk, ic, tbl_n, wp_n, init_n, rp_n;
  wire [4:0] fgpi;
  wire [4:0] rfu;
  wire [3:0] fwh;
  wire [3:0] idsel;
  
  wire vcc, vpp, vpph, vss; 

  stim stimulus (fwh, fwh4, rfu, idsel, fgpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  m50fw040 memory (fwh, fwh4, rfu, idsel, fgpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);

endmodule

