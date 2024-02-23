// clock generator with a gived frequency
module clk_gen(clk);
    parameter per = -1;
    output clk;
    reg clk = 1'b0;
    always begin
        #per clk <= ~clk;
    end
endmodule

module test;
    wire clock;
    // period;
    //parameter p;
    clk_gen #(12) DUT(clock);
    /*initial begin
       period = 3'd1; //[ns]  
       #10;
       period = 3'd2;
       #10;
       period = 3'd3;
       #10;
       period = 3'd4;
       #10;
       period = 3'd5;
       #10;
       period = 3'd6;
     end */
endmodule