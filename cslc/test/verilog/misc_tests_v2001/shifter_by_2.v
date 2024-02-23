module shifter_by_2(rst,clk,en,out);
    parameter reset_val = 8'b00000001;
    parameter final_val = 8'b01000000;
    parameter amount = 2;
    input rst, clk, en;
    output [7:0] out;
    reg [7:0] out;
    reg [7:0] tmp;
    initial begin
        out = reset_val;
        tmp = reset_val;
    end
    always @(!rst) begin
       out = reset_val;
       tmp = reset_val;
    end
    integer i;
    always @(posedge clk) begin
       if(en) begin
           for(i=0;i<amount;i=i+1) begin
               tmp = tmp << 1;
           end
       end 
       out = tmp;
    end
endmodule