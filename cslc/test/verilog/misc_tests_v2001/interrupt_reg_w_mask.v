`define MASK 8'b01101110
module int_reg(rst,clk,en,int_in,int_out);
    integer i;
    input rst, clk, en;
    input [7:0] int_in;
    output int_out;
    reg int_out;
    reg out;
    reg [7:0]tmp;
    always @(!rst) begin tmp <= 8'b0; end
    always @(posedge clk) begin
       if(en) begin
           tmp = `MASK & int_in;
           for (i=0;i<8;i=i+1) begin out = out | tmp[i]; end  
       end
       int_out <= out;
    end  
endmodule