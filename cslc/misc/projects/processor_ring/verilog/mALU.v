//####################################
//# Circuit: mALU                    #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Apr 3, 2007                #
//####################################

module malu(opcode, opr_a, opr_b, res, en);
    parameter OPCODE_WIDTH = 3;
    parameter DATA_WIDTH = 32;
    
    input [OPCODE_WIDTH-1:0]opcode;
    input [DATA_WIDTH-1:0] opr_a, opr_b;
    input en;
    output [DATA_WIDTH-1:0] res;
    
    reg [DATA_WIDTH-1:0] res;
    
    always@(opcode or opr_a or opr_b) begin
        if(en)begin
         case (opcode)
            3'b000: res = opr_a + opr_b;
            3'b001: res = opr_a - opr_b;
            3'b010: res = opr_a & opr_b;
            3'b011: res = opr_a | opr_b;
            3'b100: res = opr_a << opr_b;
            3'b101: res = opr_a >> opr_b;
            default res = 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ;
         endcase
        end
        else begin
            res = 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ;
        end
    end
endmodule

//testbench mALU
module tb_malu();
    parameter OPCODE_WIDTH = 3;
    parameter DATA_WIDTH = 32;
    
    reg [OPCODE_WIDTH-1:0]opcode;
    reg [DATA_WIDTH-1:0] opr_a, opr_b; 
    wire [DATA_WIDTH-1:0]res;
    
    malu mALU(opcode, opr_a, opr_b, res) ;
    
    initial begin
        opr_a = 32'h FFFF0000;
        opr_b = 32'h 00000004;
        opcode = 3'b 000;
        #5;
        opcode = 3'b 001;
        #5;
        opcode = 3'b 010;
        #5;
        opcode = 3'b 011;
        #5;
        opcode = 3'b 100;
        #5;
        opcode = 3'b 101;
        #5;
    end
endmodule