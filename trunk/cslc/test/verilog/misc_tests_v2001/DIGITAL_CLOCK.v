//digital clock
module CLOCK (H, h, M, m, r, clk);
    input r, clk;
    output [3:0] H, h, M, m;
    
    //reg [3:0] H, h, M, m;
    wire [3:0] Hi, hi, Mi, mi;
    wire nm, nM, nh;
    
    BCD_9 min(mi, r, clk);
    BCD_5 MIN(Mi, r, nm);
    BCD_9 hour(hi, r, nM);
    BCD_2 HOUR(Hi, r, nh);
    
    assign nm=!mi[3];
    assign nM=!Mi[2];
    assign nh=!hi[1];
    
    assign H=Hi;
    assign h=hi;
    assign M=Mi;
    assign m=mi;
    
endmodule

//test
module test_CLOCK;
    wire [3:0] H,h,M,m;
    reg clk,r;
    
    CLOCK CEAS(H, h, M, m, r, clk);
    initial begin
        r=1'b0;
        clk=0;
        #2;
        r=1'b1;
    end
    always #1 clk=!clk;
    always@(clk)
    $display("at t=%t H=%b h=%b M=%b m=%b clk=%b r=%b", $time, H, h, M, m, clk, r);
endmodule   