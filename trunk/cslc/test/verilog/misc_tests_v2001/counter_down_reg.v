module cnt_down_to_zero(reset, en, clk, count_out);
    parameter count_dir = 0;
    parameter init_val = 8'b11111111;
    parameter final_val = 8'b00000000;
    parameter step = 2;
    input reset, en, clk;
    output [7:0] count_out;
    reg [7:0] count_out;
    initial
    count_out <= init_val;
    always @(reset)
    count_out <= init_val;
    always @(posedge clk) begin
        if(!reset)
            count_out <= init_val;
        else if(en) begin
            case (count_dir)
            0:count_out <= count_out - step;
            1:count_out <= count_out + step;
            default:$display("Wrong step number");
            endcase
         end    
    end
endmodule

module cnt_down_TB;
    parameter semiper = 1;
    reg reset, en, clk;
    wire [7:0] count_out;
    cnt_down_to_zero cnt_DUT(reset,en,clk,count_out);
    initial begin
       clk = 0;
       en = 0;
       reset = 1;
       #30
       en = 1;
       #174
       reset =0;
       #12
       reset =1;
       #3
       en = 0;
       #5
       en = 1;
    end
    always #semiper 
    clk= ~clk;    
endmodule