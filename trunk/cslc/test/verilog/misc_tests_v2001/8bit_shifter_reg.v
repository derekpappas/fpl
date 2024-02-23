module shift_1X8(clk,sr_out);
    parameter init_val = 8'b00000001;
    parameter final_val = 8'b00001000;
    input clk;
    output [7:0] sr_out;
    reg [7:0] sr_out;
    initial begin
        sr_out = init_val;
    end
    always @(posedge clk) begin
        if(sr_out != final_val)
        sr_out = sr_out << 1;
    end
endmodule