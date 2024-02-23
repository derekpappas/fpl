//####################################
//# Circuit: mROM                    #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Mar 30, 2007               #
//####################################

module mrom(pc_rom_addr,
            rom_ir_instr);
  input [5:0] pc_rom_addr;
  output [31:0] rom_ir_instr;
  
  reg [31:0] inst_rom[0:63];
  reg [31:0] instr;
  integer i;
  
  assign rom_ir_instr = inst_rom[pc_rom_addr];
  
  initial begin
      instr = 32'hC0000000;
       for(i=0; i<=63; i=i+1) begin
           inst_rom[i] = instr;
           instr = instr + 1;
       end
       inst_rom[12]=32'h3000003A;
   end
endmodule

module tb_mrom();
   reg [5:0] pc_rom_addr;
   wire [31:0] rom_ir_instr; 
   
   
   mrom IM(pc_rom_addr, rom_ir_instr);
   initial begin
       pc_rom_addr = 6'b000001;
       #5;
       pc_rom_addr = 6'b000010;
       #5;
       pc_rom_addr = 6'b000100;
       #5;
       pc_rom_addr = 6'b001000;
       #5;
       pc_rom_addr = 6'b010000;
       #5;
       pc_rom_addr = 6'b100000;
       #5;
       pc_rom_addr = 6'b100001;
       #5;
       pc_rom_addr = 6'b100010;
       #5;
       pc_rom_addr = 6'b100100;
       #5;
       pc_rom_addr = 6'b111111;
   end
endmodule