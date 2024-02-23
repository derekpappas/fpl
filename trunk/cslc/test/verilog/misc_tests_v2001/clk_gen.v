// clock generator with a gived frequency
module clk_gen(clk);
    parameter per = -1;
    output clk;
    reg clk = 1'b0;
    always begin
        #per clk <= ~clk;
    end
endmodule 
//test
module test_clock_gen;    
    reg clk;
    clk_gen #(5) DUT0(clock0);
    clk_gen #(10) DUT1(clock1);
    initial clk=0;
    always #5 clk=~clk;
endmodule