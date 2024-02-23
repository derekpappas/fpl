module SRFF_4b_reg(async_set,async_rst,en,clk,s,r,q);
    input async_set,async_rst;
    input clk ,en;
    input [1:0] r,s;
    output [1:0] q;
    reg [1:0] q;
    always @(async_set or async_rst) begin
        if (async_set == 0)
        q = 1'b1;
        else if(async_rst == 0)
        q = 1'b0;
    end
    always @(posedge clk) begin
        if (r == 0 & s == 1)
        q = 1;
        else if(r == 1 & s == 0)
        q = 0;
        else if(r == 1 & s == 1)
        $display("Hazard, r and s can't be 1 in the same time");
    end
endmodule