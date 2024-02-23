//minutes-seconds
module MS(msd, lsd, r, clk);
    input r, clk;
    output [3:0] msd, lsd;
    
    wire [3:0] msd, lsd;
    wire [3:0] M, L;
    wire res, res_q, res_nq, reset;
    
    BCD_9 MSD(M, cym, reset, !cyl);
    BCD_9 LSD(L, cyl, reset, clk);
    DFF R(res_q, res_nq, r, res, clk);
    
    assign res=!(M[2] & M[0] & L[3] & L[0]);
    assign reset=r & res_q;
    assign msd=M;
    assign lsd=L;
endmodule

//test
module test_MS;
    wire [3:0] msd, lsd;
    reg clk, r;
    
    MS secunde(msd, lsd, r, clk);
    
    initial begin
        r=1'b0;
        clk=0;
        #2;
        r=1'b1;
    end
    always #5 clk=!clk;
    always@(clk)
     $display("at t=%t msd=%b lsd=%b r=%b clk=%b ", $time, msd, lsd, r, clk);
 endmodule
    
    
    
    
    