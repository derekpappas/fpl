//####################################
//# Circuit: mDec                    #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Apr 2, 2007                # 
//####################################

module mdec(ir, br, br_addr);
    parameter INSTR_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
    //parameter CTRL_WIDTH = 15;
    
    input [INSTR_WIDTH-1:0]ir;
    output br;
    output [ADDR_WIDTH-1:0] br_addr;
    //output [CTRL_WIDTH-1:0] ctrl;
    
    assign br = (ir[INSTR_WIDTH-1:INSTR_WIDTH-2]==2'b00) ? 1'b1 : 1'b0;
    assign br_addr = br ? ir[ADDR_WIDTH-1:0] : 6'b000000; 
    //assign ctrl = ir[CTRL_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH];
endmodule