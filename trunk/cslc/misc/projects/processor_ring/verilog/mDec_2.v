//####################################
//# Circuit: mDec                    #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Apr 2, 2007                #
//# Last Update: Apr 3, 2007         # 
//####################################

module mdec(ir, br, br_addr, alu, mem);
    parameter INSTR_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
        
    input [INSTR_WIDTH-1:0]ir;
    output br, alu, mem;
    output [ADDR_WIDTH-1:0] br_addr;
    
    assign br = (ir[INSTR_WIDTH-1:INSTR_WIDTH-2]==2'b00);
    assign alu = (ir[INSTR_WIDTH-1:INSTR_WIDTH-2]==2'b01);
    assign mem = (ir[INSTR_WIDTH-1:INSTR_WIDTH-2]==2'b10);
    assign br_addr = br ? ir[ADDR_WIDTH-1:0] : 6'b000000; 
endmodule