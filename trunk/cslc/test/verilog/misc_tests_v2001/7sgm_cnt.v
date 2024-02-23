module counter_4(rst_, clk, en, cnt_out);
    input rst_, clk, en;
    output [3:0] cnt_out;
    reg [3:0] cnt_out;
   
    always @(posedge clk or negedge rst_)
    begin
        if(! rst_)
           cnt_out = 0;
        else if(en)
           cnt_out = cnt_out + 1;
    end
endmodule

module led_7sgm(cnt_out, led_out);
    input [3:0] cnt_out;
    output [7:0] led_out;
    reg [7:0] led_out;
    
    always @(cnt_out)
    begin
        case (cnt_out)
            0: led_out = 8'hFC;
            1: led_out = 8'h60;
            2: led_out = 8'hDA;
            3: led_out = 8'hF2;
            4: led_out = 8'h26;
            5: led_out = 8'hB6;
            6: led_out = 8'hBE;
            7: led_out = 8'hE0;
            8: led_out = 8'hFE;
            9: led_out = 8'hF6;
       endcase
   end
endmodule