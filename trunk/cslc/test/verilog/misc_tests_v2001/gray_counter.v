module gray_cnt(rst_sgn,clk,en_sgn,cnt_sgn,gray_code_sgn,gray_code);
    parameter rst_val = 4'b0000;
    input rst_sgn, clk, en_sgn, cnt_sgn;
    output [3:0] gray_code_sgn;
    reg [3:0] gray_code_sgn;
    output [3:0] gray_code;
    reg [3:0] gray_code;
    integer i;
    always @(posedge clk or negedge rst_sgn) begin
        if(!rst_sgn) begin
            gray_code = rst_val;
            gray_code_sgn = rst_val;
        end
        else if(en_sgn & cnt_sgn) begin
            gray_code = gray_code + 1;
        end
        else if (en_sgn & !cnt_sgn) begin
                gray_code = gray_code -1;
        end
        gray_code_sgn[3] = gray_code[3];
        for (i =0; i<=2; i=i+1) begin
            gray_code_sgn [i] = gray_code [i+1] ^ gray_code [i];
        end
    end
endmodule


module testb_gray_cnt;
    reg rst_sgn, clk, en_sgn, cnt_sgn;
    wire [3:0] gray_code_sgn;
    wire [3:0] gray_code;
    
    gray_cnt dut(rst_sgn,clk,en_sgn,cnt_sgn,gray_code_sgn,gray_code);
    initial begin
        rst_sgn = 0;
        clk = 0;
        #3
        rst_sgn = 1;
        #1
        cnt_sgn = 1;
        en_sgn = 1;
        #20
        en_sgn = 0;
        #4
        cnt_sgn = 0;
        #4
        en_sgn = 1;
        #30
        en_sgn = 0;
    end

    always #1 clk = ~clk;
endmodule