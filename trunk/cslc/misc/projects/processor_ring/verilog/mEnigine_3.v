//####################################
//# Circuit: mEngine                 #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Mar 30, 2007               #
//####################################

module mengine(clock, reset_);
    parameter INSTR_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
    
    input clock, reset_;
        
    wire br;
    wire [ADDR_WIDTH-1:0] br_addr;
    wire [ADDR_WIDTH-1:0] rom_pc;
    reg [ADDR_WIDTH-1:0]PC0, PC1, PC2;
    reg [INSTR_WIDTH-1:0]IR1, IR2;
    wire [INSTR_WIDTH-1:0]instr;
    reg v1, v2;
    
    mpc mPC(rom_pc, 6'b0, br_addr, 1'b0, br, clock, reset_);//offset disabled
    mrom mROM(rom_pc, instr);
    mdec mDec(IR1, br, br_addr);    
    
    always@(posedge clock or negedge reset_) begin
       if(!reset_)begin
           //PC0=0;
           PC1=0;
           PC2=0;
           v1=0;
           v2=0;
           IR1=0;
           IR2=0;
       end 
       else begin
           PC1<=rom_pc;
           PC2<=PC1;
           IR1<=instr;
           IR2<=IR1;
           v1<=!br;
           v2<=v1 & !br;
       end
    end
endmodule

module tb_mengine();
    parameter INSTR_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
    
    reg clock, reset_;
    wire [INSTR_WIDTH-1:0] IR2;
    wire [ADDR_WIDTH-1:0] PC2;
    wire v2;
        
    mengine mEng(IR2, PC2, v2, clock, reset_);
    
    initial begin
        clock = 0;
        reset_=1;
        #3 reset_=0;
        #5 reset_=1;
    end
    
    always #5 clock=~clock;    
endmodule