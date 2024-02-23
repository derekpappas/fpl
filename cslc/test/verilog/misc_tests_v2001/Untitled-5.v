module as;
    parameter period = 100;
    reg clk;
    initial
    clk = 0;
    always clk = #(period) ~clk;
endmodule