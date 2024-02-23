`define CNT_W 4
module counter(clk,cnt_en,cnt_val);
    parameter CW =0;
    input clk;
    input cnt_en;
    output [CW-1:0] cnt_val;
    reg [CW-1:0] cnt_val;
    initial begin
    cnt_val=0;
end 
    always@(posedge clk )begin
        if(cnt_en)begin
            cnt_val=cnt_val+1;
                    end
          end
endmodule
module ff(ff_in,clk,ff_out);
    input clk;
    input ff_in;
    output ff_out;
    reg ff_out;
    always@(posedge clk)begin
        ff_out=ff_in;
    end
endmodule
module DUT(v_in, cnt_en,clk, v_out,cnt_val);
    parameter CW = 0;
    input v_in;
    input clk;
    input cnt_en;
    output v_out;
    output [CW-1:0] cnt_val;
    
    ff ff(.ff_in(v_in),.clk(clk),.ff_out(v_out));
    counter #(.CW(`CNT_W)) counter(.clk(clk),.cnt_en(cnt_en),.cnt_val(cnt_val));
endmodule
module tb;
    integer file_w;
    wire v_in=(5>2);
    wire cnt_en=(1<3);
    reg clk;
    reg [3:0] ra;
    wire v_out;
    wire [`CNT_W - 1:0] cnt_val;
    reg [1:0] mem [0:9];
    reg [1:0] tmp;
    initial begin
        clk=0;
        ra = 0;
        file_w = $fopen("exp_file");
        $readmemb("user_file",mem);
        tmp = mem[ra];
    end
    always #2 clk=~clk;
    DUT #(.CW(`CNT_W)) DUT(.v_in(tmp[1]),.cnt_en(tmp[0]),.clk(clk),.v_out(v_out),.cnt_val(cnt_val));
    always@(posedge clk) begin
        $fdisplay(file_w,"%b || %b", v_out, cnt_val);
        ra=ra+4'b0001;
        tmp=mem[ra];
    end    
endmodule
    