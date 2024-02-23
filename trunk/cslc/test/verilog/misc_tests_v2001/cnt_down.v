module cnt_down(rst,en2,clk,count_out2);
    parameter start_val = 8'b10110111;
    parameter end_val = 8'b01001000;
    input rst, en2, clk;
    output [7:0] count_out2;
    reg [7:0] count_out2;
    always @(posedge clk or negedge rst) begin
        if(!rst) begin count_out2 = start_val; end
        else if(en2) begin
            if (count_out2 > end_val)
            count_out2 = count_out2 - 1;        
            else if (count_out2 == end_val)
            count_out2 = start_val;
            else
            $display("Wrong value!");
         end    
    end
endmodule
