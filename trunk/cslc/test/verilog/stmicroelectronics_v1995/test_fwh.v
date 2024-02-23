/***************************************************************************** 
    
    Testbench FWH Interface
  
******************************************************************************   
  
    THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,        
    EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE        
    IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR      
    PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERforMANCE OF         
    THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU      
    ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.     
  
*****************************************************************************/ 

`define DATABUS_DIM 8         
`define ADDRBUS_DIM 28       
`define MEMADDR_DIM 19
`define FWHBUS_DIM  4
`define HIGH 1'b1
`define LOW  1'b0
`define X    1'bX
`define Z    1'bZ
`define FALSE 1'b0
`define TRUE 1'b1

`define MANUFCODE_ADDR 19'h00000
`define DEVCODE_ADDR   19'h00001
`define GPI_ADDR       20'hC0100
`define LOCKREG_ADDR   16'h0002

// Memory commands
`define RD     8'hFF  // Read Memory Array op. code
`define RSR    8'h70  // Read Status Register op. code
`define RSIG_1 8'h90  // Read Electronic Signature op. code
`define RSIG_2 8'h98  // Read Electronic Signature alternative op. code
`define EE     8'h20  // Erase op. code
`define PG_1   8'h40  // Program op. code 
`define PG_2   8'h10  // Program alternative op. code 
`define QPGM   8'h30  // Quadruple Byte Program op. code
`define CLRSR  8'h50  // Clear Status Register op. code
`define PES    8'hB0  // Program/Erase Suspend op. code
`define PER    8'hD0  // Program/Erase Resume (Erase Confirm) op. code
     
//`define FWH_START 4'h0
`define FWH_STARTREAD  4'hD
`define FWH_STARTWRITE 4'hE

`define FWH_TAR   4'hF
`define FWH_RSYNC 4'h0
`define FWH_WSYNC 4'h5
`define FWH_MSIZE 4'h0
`define FWH_MSIZE16 4'h4
`define FWH_MSIZE32 4'h5

`define CLKPERIOD 30
`define DELAY 200 
`define DEVID0 4'b0000    // DEVICE ID (boot memory)


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

module stim (fwh, fwh4, rfu, fgpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  output fwh4, clk, ic, tbl_n, wp_n, init_n, rp_n;
  output [4:0] fgpi;
  output [4:0] rfu;
  output [3:0] fwh;
  //output [3:0] idsel;
  
  output  vcc, vpp, vpph, vss;  

  reg start;  
  reg fwh4, ic, tbl_n, wp_n, init_n, rp_n;  
  reg [3:0] fwh_bus; 
  reg [3:0] idsel;      // ???????????????????????????? 
  
  
  wire [4:0] fgpi = 5'b01011;
  wire [4:0] rfu = 5'bZZZZZZ;
  wire [3:0] fwh;

  assign fwh[3:0] = fwh_bus[3:0];

  nand #15 (clk, start, clk);
  
  real vcc_real, vpp_real;
  
  assign vcc = (`VCC_LOW ? `LOW : `HIGH);
  assign vpp = (`VPP_HIGH ? `HIGH : `LOW);
  assign vpph = (`VPP_FAST ? `HIGH : `LOW);
  assign vss = 0;   
   
  reg [`ADDRBUS_DIM-1:0] addr;
  reg [`DATABUS_DIM-1:0] data;  

  task fwh_readMem_op;
  input [`MEMADDR_DIM-1:0] address;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTREAD;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = {1'h1, address[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE;
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
  endtask

  task fwh_readMem16_op;
  input [`MEMADDR_DIM-1:0] address;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTREAD;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = {1'h1, address[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE16;
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
  endtask

  
  
  task fwh_readMem32_op;
  input [`MEMADDR_DIM-1:0] address;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTREAD;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = {1'b1, address[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE32;
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
  endtask

  task fwh_readReg_op;
  input [`MEMADDR_DIM-1:0] reg_addr;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTREAD;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hB;
    #`CLKPERIOD fwh_bus = {1'b1, reg_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE;
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
  endtask

  task fwh_readReg32_op;
  input [`MEMADDR_DIM:0] reg_addr;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTREAD;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hB;
    #`CLKPERIOD fwh_bus = {1'b1, reg_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE32;
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
  endtask
 
  task fwh_writeMem_op;
  input [`MEMADDR_DIM-1:0] address;
  input [`DATABUS_DIM-1:0] data;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTWRITE;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = {1'b1, address[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = address[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE;
    #`CLKPERIOD fwh_bus = data[`DATABUS_DIM-5:`DATABUS_DIM-8]; 
    #`CLKPERIOD fwh_bus = data[`DATABUS_DIM-1:`DATABUS_DIM-4]; 
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
 endtask
  
  task fwh_writeReg_op;
  input [`MEMADDR_DIM:0] reg_addr;
  input [`DATABUS_DIM-1:0] data;
  begin
    fwh4 = `LOW;
    fwh_bus = `FWH_STARTWRITE;
    #`CLKPERIOD fwh4 = `HIGH;
    fwh_bus = idsel;
    #`CLKPERIOD fwh_bus = 4'hF;
    #`CLKPERIOD fwh_bus = 4'hB;
    #`CLKPERIOD fwh_bus = {1'b1, reg_addr[`MEMADDR_DIM-1:`MEMADDR_DIM-3]};
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-4:`MEMADDR_DIM-7];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-8:`MEMADDR_DIM-11];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-12:`MEMADDR_DIM-15];
    #`CLKPERIOD fwh_bus = reg_addr[`MEMADDR_DIM-16:`MEMADDR_DIM-19];
    #`CLKPERIOD fwh_bus = `FWH_MSIZE;
    #`CLKPERIOD fwh_bus = data[`DATABUS_DIM-5:`DATABUS_DIM-8]; 
    #`CLKPERIOD fwh_bus = data[`DATABUS_DIM-1:`DATABUS_DIM-4]; 
    #`CLKPERIOD fwh_bus = `FWH_TAR;
    #`CLKPERIOD fwh_bus = {`FWHBUS_DIM{`Z}};
  end
  endtask

  task fwh_readMemoryArrayCmd;
  begin
    fwh_writeMem_op(19'h7FFFF, `RD);
  end
  endtask

  task fwh_readStatusRegisterCmd;
  begin
    fwh_writeMem_op(19'h7FFFF, `RSR);
  end
  endtask

  task fwh_clearStatusRegisterCmd;
  begin
    fwh_writeMem_op(19'h7FFFF, `CLRSR);
  end
  endtask

  task fwh_electronicSignatureCmd;
  begin
    fwh_writeMem_op(19'h7FFFF, `RSIG_2);
  end
  endtask

  task fwh_programCmd;
  input [`ADDRBUS_DIM-1:0] address;
  input [`DATABUS_DIM-1:0] data;
  begin
    fwh_writeMem_op(19'h7FFFF, `PG_1);
    #`DELAY fwh_writeMem_op(address, data); 
  end
  endtask

  task fwh_eraseCmd;
  input [`ADDRBUS_DIM-1:0] address;
  begin
    fwh_writeMem_op(19'h7FFFF, `EE);
    #`DELAY fwh_writeMem_op(address, `PER); 
  end
  endtask
  
  task fwh_peSuspendCmd;
  begin
    fwh_writeMem_op(19'h7FFFF, `PES);
  end
  endtask  
  
  task fwh_peResumeCmd;
  begin
    fwh_writeMem_op(19'h7FFFF, `PER);
  end
  endtask  
 
  initial 
    begin
      vcc_real = 3.0;
      vpp_real = 3.0;
      ic = `LOW;
      tbl_n = `HIGH;
      wp_n = `HIGH;
      init_n = `HIGH;
      rp_n = `HIGH;
     
      idsel = `DEVID0; 

      fwh_bus = 4'hz; 
      fwh4 = `HIGH; 
      start = 0;
      #30 start = 1;  
       
    end 
  

  initial
    begin
      #3112 fwh_programCmd(19'h10023, 8'h34);
      #490  fwh_readMem_op(19'h10023); 
      #300  fwh_writeReg_op(19'h10002, 8'h00);
      #300  fwh_readReg_op(19'h10002); 
      #300  fwh_programCmd(19'h10023, 8'h34);
      #300  fwh_clearStatusRegisterCmd;
      #300  fwh_readMem_op(19'h7FFFF);
      #300  fwh_programCmd(19'h10023, 8'h34);
      #500  fwh_readMem_op(19'h10023);
      #1500 fwh_readMem_op(19'h10023); 
      #300  fwh_peSuspendCmd;
      #500  fwh_readMem_op(19'h10023);
      #700  fwh_readMem_op(19'h10023); 
      #500  fwh_readMem_op(19'h10023); 
      #300  fwh_electronicSignatureCmd;
      #1000 fwh_readMem_op(19'h00001);
      #300  fwh_peResumeCmd;
      #1000 fwh_readMem_op(19'h7FFFF);
      #1000 fwh_readMem_op(19'h7FFFF);
      #500  fwh_readMemoryArrayCmd;
      #500  fwh_readMem_op(19'h10023);

      #5000 fwh_readMem16_op(19'h10023);
      #5000 fwh_readMem32_op(19'h7FFF0);
      #10000 fwh_readReg32_op(19'h10000);
      #10000 $finish;
    end


endmodule


module test;
  wire fwh4, clk, ic, tbl_n, wp_n, init_n, rp_n;
  wire [4:0] fgpi;
  wire [4:0] rfu;
  wire [3:0] fwh;
  wire [3:0] idsel=`DEVID0;
  
  wire vcc, vpp, vpph, vss; 

  stim stimulus (fwh, fwh4, rfu, fgpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  m50fw040 memory (fwh, fwh4, rfu, idsel, fgpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);

endmodule
