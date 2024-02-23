module atom_reg(en,rst,clk,data_in,data_out);
    input en, rst, clk;
    reg lock_bit;
    input [7:0] data_in;
    output [7:0] data_out;
    reg [7:0] data_out;
    initial begin
        lock_bit = 0;
    end
    always @(en) begin
        lock_bit = en;
    end
    always @(!rst) begin
        data_out <= 8'b0;
    end
    always @(posedge clk) begin
        if(!lock_bit) begin
            data_out <= data_in;
        end
    end
endmodule