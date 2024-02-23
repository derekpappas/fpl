// clock generator with a gived frequency
module clk_gen(freq,clk);
    input freq;
    output clk;
    reg clk = 1'b0;
    wire per;
    assign per = 1/freq;
    always #per begin
        clk <= ~clk;
    end
endmodule

module test;
    wire clock;
    reg frequency;
    clk_gen DUT(frequency,clock);
    initial begin
    frequency = 20;
end  
endmodule
