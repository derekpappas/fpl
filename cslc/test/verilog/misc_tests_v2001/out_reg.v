module REG(d, q, vi, vo, pop, stall, prec_pop, clk, reset);
    parameter stack_width=4;
    
    input [stack_width-1: 0] d;
    input vi, clk, reset, stall, pop;
    output [stack_width-1: 0] q;
    output vo, prec_pop;
    
    reg [stack_width-1: 0] q;
    reg vo, prec_pop;
    wire e;
    
    assign e=(stall && vi && !vo) && (stall && vi && !(pop ^ vo));
    
    always@(reset, posedge clk) begin
        prec_pop<=e;
        if(~reset)begin 
           q<=0;
           vo<=0;
        end
        else begin
            if(e) begin
                q<=d;
            end
            vo<=vi;
        end
    end
endmodule

//tb_reg
module tb_REG;
    parameter stack_width=4;
    reg [stack_width-1: 0] d;
    reg vi, e, clk, reset;
    wire [stack_width-1: 0] q;
    wire vo;
    
    REG #(stack_width)reg_inst(d, q, vi, vo, e, clk, reset);
    
    initial begin
        clk=0;
        e=0;
        vi=1;
        d=4'b0011;
        reset=0;
        #7;
        reset=1;
        #6;
        e=1;
        #10;
        vi=0;
        d=4'b1111;
    end
    always#5 clk=~clk;
endmodule