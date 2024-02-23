//flip-flop
module DFF (Q, nQ, R, D, Clk);
    input R, D, Clk;
    output Q, nQ;
    
    reg Q, nQ;
    
    always @(R or D or Clk)
    if(R==0) 
       begin
        Q=1'b0;
        nQ=1'b1;
    end
       
    always@(posedge Clk)
    begin
        Q=D;
        nQ=!D;
    end 
endmodule

//test
module test_DFF;
    wire q, nq;
    reg r, d, clk;
    
    DFF D1(q, nq, r, d, clk);
    
    initial begin
        r=1'b0;
        clk=1'b0;
        d=1'b0;
        #1;
        r=1'b1;
        #4;
        clk=1'b1;
        #5
        clk=1'b0;
        d=1'b1;
        #5;
        clk=1'b1;
     end
     always@(d or clk)
     $display("at t=%t r=%b d=%b clk=%b q=%b nq=%b", $time, r, d, clk, q, nq);
 endmodule