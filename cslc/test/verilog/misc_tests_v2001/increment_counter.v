module cnt_inc(rst,clk,inc_sgn,out);
    parameter start_val = 4'b0;
    input rst, clk, inc_sgn;
    output [3:0] out;
    reg [3:0] out;
    always @(posedge clk or negedge rst) begin
        if(! rst) begin
            out = start_val;
        end
        else if(inc_sgn) begin
            out = out +1;
        end
    end      
endmodule

module testb_count;
    reg rst, clk, inc_sgn;
    wire [3:0] out;
    cnt_inc dut(rst,clk,inc_sgn,out);
    initial begin
        clk = 0;
        rst = 1;
        inc_sgn = 1;
        #1
        rst = 0;
        #4
        rst = 1;
        inc_sgn = 0;
        #10
        inc_sgn = 1;
        /*rst = 0;
        #8
        rst = 1;
        #8
        inc_sgn = 1;
        #8
        rst = 0;
        #4
        rst = 1;
        #20
        inc_sgn = 0;*/
    end

    always #1 clk = ~clk;
endmodule