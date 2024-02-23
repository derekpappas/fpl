//4-bit counter
module counter4(state, r, clk);
    input r, clk;
    output [3:0] state;
    
    reg [3:0] state;
    
    wire d0, d1, d2, d3,;
    
    DFF D0(q0, nq0, r, d0, clk),
        D1(q1, nq1, r, d1, nq0),
        D2(q2, nq2, r, d2, nq1),
        D3(q3, nq3, r, d3, nq2);
     assign d0=nq0;
     assign d1=nq1;
     assign d2=nq2;
     assign d3=nq3;
     
     always@(q0 or q1 or q2 or q3)
     state={q3,q2,q1,q0};
endmodule

//test
module test_counter4;
    wire [3:0] stare;
    reg r, clk;
    
    counter4 CNT(stare, r, clk);
    
    initial begin
        r=1'b0;
        clk=0;
        #2;
        r=1'b1;
    end
    always #5 clk=!clk;
    always@(clk)
    $display("at t=%t r=%b clk=%b stare=%b", $time, r, clk, stare);
endmodule