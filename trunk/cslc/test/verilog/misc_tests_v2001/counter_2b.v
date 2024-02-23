//2-bit counter
module count_2b(state, r, clk);
    input r, clk;
    output [1:0] state;
    
    reg [1:0] state;
    
    wire d0, d1;
    
    DFF D0(q0, nq0, r, d0, clk),
        D1(q1, nq1, r, d1, nq0);
     assign d0=nq0;
     assign d1=nq1;
     
     always@(q1 or q0)
     state={q1,q0};
endmodule

//test
module test_count_2b;
    wire [1:0] stare;
    reg r, clk;
    
    count_2b CNT(stare, r, clk);
    
    initial begin
        r=1'b0;
        clk=0;
        #10;
        r=1'b1;
    end
    always #5 clk=!clk;
    always@(clk)
    $display("at t=%t r=%b clk=%b stare=%b", $time, r, clk, stare);
endmodule