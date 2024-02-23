//####################################
//# Circuit: mEngine                 #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Mar 30, 2007               #
//####################################

module mengine(clock, reset_);
    parameter INSTR_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
    parameter RF_ADDR_WIDTH = 5;
    parameter DATA_WIDTH = 32;
    
    input clock, reset_;
        
    wire br, alu, mem, alu_en;
    wire [ADDR_WIDTH-1:0] br_addr;
    wire [ADDR_WIDTH-1:0] rom_pc;
    reg [ADDR_WIDTH-1:0]pc_0, pc_1, pc_2;
    reg [INSTR_WIDTH-1:0]ir_1, ir_2;
    wire [INSTR_WIDTH-1:0]instr;
    wire [RF_ADDR_WIDTH-1:0]src_a, src_b, dest;
    reg v_1, v_2, alu_3, mem_3, alu_4, mem_4, we;
    reg [DATA_WIDTH-1:0] opr_a, opr_b, wr_data;
    
    mpc mpc(rom_pc, 6'b0, br_addr, 1'b0, br, clock, reset_);//offset disabled
    mrom mROM(rom_pc, instr);
    mdec mDec(ir_1, br, br_addr, alu, mem);  
    mrf mRF(src_a, rd_data_a, src_b, rd_data_b, dest, wr_data, we, reset_);
    malu mALU(opcode, opr_a, opr_b, wr_data, alu_en) ; 
    
    assign {src_a, src_b, dest} = ir_2[(3*RF_ADDR_WIDTH)-1:0];
        
    always@(posedge clock or negedge reset_) begin
       if(!reset_)begin
           pc_1 <= 0;
           pc_2 <= 0;
           v_1  <= 0;
           v_2  <= 0;
           ir_1 <= 0;
           ir_2 <= 0;
       end 
       else begin
           pc_1 <= rom_pc;
           pc_2 <= pc_1;
           ir_1 <= instr;
           ir_2 <= ir_1;
           v_1  <= !br;
           v_2  <= v_1 & !br;
           //rf output
           opr_a<= rd_data_a;
           opr_b<= rd_data_b;
           //alu and mem enable flow
           we   <= alu_4 | mem_4;
       end
    end
endmodule

module tb_mengine();
    parameter INSTR_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
    
    reg clock, reset_;
    wire [INSTR_WIDTH-1:0] ir_2;
    wire [ADDR_WIDTH-1:0] pc_2;
    wire v_2;
        
    mengine mEng(ir_2, pc_2, v_2, clock, reset_);
    
    initial begin
        clock = 0;
        reset_=1;
        #3 reset_=0;
        #5 reset_=1;
    end
    
    always #5 clock=~clock;    
endmodule