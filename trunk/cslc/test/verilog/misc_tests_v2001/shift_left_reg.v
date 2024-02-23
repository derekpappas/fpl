//shift-left-register(fifo)
module sh_left(s_out, s_in, clk, reset);
    input s_in, clk, reset;
    output s_out;
    
    wire s_out;
    reg [15: 0] state;
    
    always@(reset, posedge clk)
    begin
        if(reset==0)
            state=0;
        else begin
            state[15:1]=state[14:0];
            state[0]=s_in;
        end
    end
    assign s_out=state[15];
endmodule

//testbench
module test_sh_left;
    wire s_out, clk;
    reg s_in, reset;
    
    sh_left DUT(s_out, s_in, clk, reset);
    clk_gen #(5) clock(clk);//the clk generator
    
    //
    
    
    initial begin//initial block including reset
        reset=0;
        s_in=1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        reset=1;
        @(posedge clk);
    end
endmodule