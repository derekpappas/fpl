module top(en,clk1,clk2,s2,r2,s1,r1,q1,q2);
    input en, clk1, clk2;
    input s2, r2, s1, r1;
    output q1;
    output [1:0] q2;
    reg q1;
    reg [1:0] q2;
    rsff reg0(en,clk1,s1,r1,q1);
    box box1(en,clk2,s2,r2,q2);
endmodule
module box(en,clk2,s2,r2,q2);
    input en, clk2;
    input s2, r2;
    output [1:0] q2;
    wire q_1, q_2;
    assign q2 = {q_1,q_2};
    rsff reg1(en,clk2,s2,r2,q_1);
    rsff reg2(en,clk2,s2,r2,q_2);   
endmodule
module rsff(en,ck,s,r,q);
    input en, ck;
    input s,r;
    output q;
    reg q;
    always @(posedge ck) begin
       if(en) begin
           if(r == 0 & s ==1)
           q = 1;
           else if(r == 1 & s == 0)
           q = 0;
           else if(r == 1 & s == 1)
           $display("Hazard, r and s can't be 1 in the same time");
       end 
    end
endmodule