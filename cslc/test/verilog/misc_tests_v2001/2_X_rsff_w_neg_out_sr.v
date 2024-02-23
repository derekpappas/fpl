module box1(en,en1,en2,clk,s,r,q1,q1_neg,q2,q2_neg,init_sgn);
    input en, en1, en2, clk, init_sgn;
    input [7:0] s, r;
    output [7:0] q1, q1_neg, q2, q2_neg;
    wire [7:0] q1, q1_neg, q2, q2_neg;
    wire [7:0] sgn1, sgn1_neg;
    rs_reg reg1(en,clk,s,r,sgn1,sgn1_neg,init_sgn);
    rs_reg reg2(en1,clk,sgn1,sgn1_neg,q1,q1_neg,init_sgn);
    rs_reg reg3(en2,clk,sgn1,sgn1_neg,q2,q2_neg,init_sgn);
endmodule
module rs_reg(en,clk,s,r,q,q_neg,init_sgn);
    integer i = 0;
    parameter init_val = 8'b1;
    parameter init_val_neg = 8'b0;
    input en, clk, init_sgn;
    input [7:0] s, r;
    output [7:0] q, q_neg;
    reg [7:0] q, q_neg;
    initial begin
       q <= init_val;
       q_neg <= init_val_neg;
    end
    always @(posedge clk) begin
       if(init_sgn) begin
           q <= init_val;
           q_neg <= init_val_neg;
       end
       else if(en) begin
          for(i = 0; i < 7; i=i+1) begin
             if (r[i] == 0 & s[i] == 1) begin
                 q[i] <= 1;
                 q_neg <= 0;
             end
             else if(r[i] == 1 & s[i] == 0) begin 
                 q[i] <= 0;
                 q_neg <= 1;
             end
             else if(r[i] == 1 & s[i] == 1)
             $display("Hazard, r and s can't be 1 in the same time");
          end
       end 
    end
endmodule