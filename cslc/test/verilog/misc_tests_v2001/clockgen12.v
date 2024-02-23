// clock generator with a gived frequency
module clk_gen(per,clk);
    input per;
    output clk;
    reg clk = 1'b0;
    always begin
        #per clk <= ~clk;
    end
endmodule

module test;
    wire clock;
    reg period;
    clk_gen DUT(period,clock);
    initial begin
       period = 1; //[ns]  
       #10;
       period = 0;
       #10;
       period = 3;
       #10;
       period = 4;
       #10;
       period = 5;
       #10;
       period = 6;
     end 
endmodule