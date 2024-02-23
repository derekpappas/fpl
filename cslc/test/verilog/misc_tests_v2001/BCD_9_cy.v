//BCD counter
module BCD_9(state, cy, r, clk);
    input r, clk;
    output [3:0] state;
    output cy;
    
    reg [3:0] state;
    reg cy;
    
    wire d0, d1, d2, d3, res, res_q, res_nq, reset;
    
    DFF D0(q0, nq0, reset, d0, clk),
        D1(q1, nq1, reset, d1, nq0),
        D2(q2, nq2, reset, d2, nq1),
        D3(q3, nq3, reset, d3, nq2);
     assign d0=nq0;
     assign d1=nq1;
     assign d2=nq2;
     assign d3=nq3;
     assign res=!(q0 & q3);
     assign reset=r & res_q;
     DFF DR(res_q, res_nq, r, res, clk);
     
     always@(q0 or q1 or q2 or q3)begin
        state={q3,q2,q1,q0};
        cy=res;
     end
endmodule

//test
module test_BCD_9;
    wire [3:0] stare;
    wire cy;
    reg r, clk;
    
    BCD_9 NINE(stare, cy, r, clk);
    
    initial begin
        r=1'b0;
        clk=0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #2;
        r=1'b1;
    end
    always #5 clk=!clk;
    always@(clk)
    $display("at t=%t r=%b clk=%b stare=%b cy=%b", $time, r, clk, stare, cy);
endmodule