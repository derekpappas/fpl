module shift_serial_input(rst,clk,in,out);
    input in, clk, rst;
    output [3:0] out;
    reg [3:0] out;
    always @(posedge clk or negedge rst) begin
        if(! rst) begin
            out = in;
        end
        else begin
            out = {in,out} >> 1;
        end
    end 
endmodule

module testb_shift;
    reg in, clk, rst;
    wire [3:0] out;
    
    shift_serial_input dut(rst,clk,in,out);
    
    initial begin
        clk = 0;
        rst = 1;
        #1
        rst = 0;
        #4
        rst = 1;
        in = 1;
        #2
        in = 1;
        #2
        in = 0;
        #2
        in = 1;
    end

    always #1 clk = ~clk;
endmodule