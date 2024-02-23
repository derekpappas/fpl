module top(async_set,async_reset,clk,s,r,q,nq);
    input async_set,async_reset,clk;
    input [7:0] s, r;
    output [7:0] q, nq;
    wire [7:0] q, nq;
    wire [7:0] int_1,int_0;
    wire neg_clk;
    assign neg_clk = ~clk;
    reg_rs reg1(async_set,async_reset,clk,s,r,int_1,int_0);
    reg_rs reg2(async_set,async_reset,neg_clk,int_1,int_0,q,nq);
endmodule
module reg_rs(async_s,async_r,clk,s,r,q,nq);
    integer i = 0;
    input async_s,async_r,clk;
    input [7:0] s, r;
    output [7:0] q, nq;
    reg [7:0] q, nq;
    initial begin
        q <= 8'b1;
        nq <= 8'b0;
    end
    always @(async_s , async_r) begin
        if (! async_s) begin
           q <= 8'b1;
           nq <= 8'b0;
        end
        else if(! async_r) begin
           q <= 8'b0;
           nq <= 8'b1;
        end
        else if(!(async_s | async_r)) begin
            $display("Hazard, asynchronous reset and set can't be 0 in the same time");
        end
    end
    always @(posedge clk) begin
       for(i = 0; i < 7; i=i+1) begin
          if (r[i] == 0 & s[i] == 1)
              q[i] = 1;
          else if(r[i] == 1 & s[i] == 0)
              q[i] = 0;
          else if(r[i] == 1 & s[i] == 1)
              $display("Hazard, r and s can't be 1 in the same time");
       end   
    end
endmodule

module top_tb;
    parameter semi_per = 2;
    reg async_set,async_reset,clk;
    reg [7:0] s, r;
    wire [7:0] q, nq;
    top dut(async_set,async_reset,clk,s,r,q,nq);
    initial begin
        clk <= 0;
        async_set <= 1;
        async_reset <= 1;
        #7
        s <= 8'b 10101100;
        r <= 8'b 01010011;
        #2
        s <= 8'b 11111111;
        r <= 8'b 00000000;
        #6
        async_reset <= 0;
        #5
        async_reset <= 1;
        #7
        async_set <= 0;
        #8
        async_reset <= 0;
        #4
        async_set <= 1;
        async_reset <= 1;
        #7
        async_reset <= 0;
        #3
        async_reset <= 1;
        #10
        s <= 8'b 11000101;
        r <= 8'b 00111000;
        #8
        s <= 8'b 10101100;
        r <= 8'b 01010011;
        #8
        s <= 8'b 11111111;
        r <= 8'b 00000000;
        #7
        async_reset <= 0;
        #6
        async_reset <= 1;
    end
    always #semi_per 
    clk <= ~clk;    
endmodule