module shift_serial_output(rst,clk,in,out);
    input clk, rst;
    input [3:0] in;
    reg [3:0] sft_reg;
    output out;
    reg out;
    always @(posedge clk or negedge rst) begin
        if(! rst) begin sft_reg = in; end
        else begin
            out = sft_reg[0];
            sft_reg = sft_reg >> 1;
        end
    end 
endmodule

module testb_shift;
    reg clk, rst;
    reg [3:0] in;
    wire out;
    
    shift_serial_output dut(rst,clk,in,out);
    
    initial begin
        clk = 0;
        rst = 1;
        #1
        rst = 0;
        in = 4'b1000;
        #4
        rst = 1;
        in = 4'b0001;
        #2
        in = 4'b1001;
        #2
        in = 4'b0101;
        #2
        in = 4'b0011;
    end

    always #1 clk = ~clk;
endmodule
