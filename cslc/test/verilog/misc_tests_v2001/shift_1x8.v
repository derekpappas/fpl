module shift_1X8(clk,sr_out,rst);
    parameter init_val = 8'b00000001;
    parameter final_val = 8'b00001000;
    input clk, rst;
    output [7:0] sr_out;
    reg [7:0] sr_out;  
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            sr_out = init_val;
        end
        else if(sr_out != final_val) begin
            sr_out = sr_out << 1; 
        end
    end
endmodule
module testb_shift;
    reg clk,rst;
    wire [7:0] sr_out;
    
    shift_1X8 dut(clk,sr_out,rst);
    
    initial begin
        rst = 0;
        clk = 0;
        #4
        rst = 1;
    end

    always #1 clk = ~clk;
endmodule