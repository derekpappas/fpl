module box(en,clk,in1,in2,out1,out2);
    parameter hi_level = 1'b1;
    input en, clk;
    input [7:0] in1, in2;
    output [7:0] out1, out2;
    wire [7:0] out1, out2;
    wire [7:0] con1, con2;
    rs_d reg1(en,hi_level,clk,in1,con1);
    rs_d reg2(hi_level,en,clk,con1,out1);
    rs_d reg3(en,hi_level,clk,in2,con2);
    rs_d reg4(hi_level,en,clk,con2,out2);
endmodule
module rs_d(rd_en,wr_en,clk,d,q);
    integer i = 0;
    parameter init_val = 8'b0;
    input rd_en, wr_en, clk;
    input [7:0] d;
    output [7:0] q;
    reg [7:0] q;
    reg [7:0] mem;
    initial
       q <= init_val;
    always @(posedge clk) begin
       if(rd_en) begin
          for(i = 0; i < 7; i=i+1)
             mem[i] <= d[i];
       end
       if(wr_en) begin
          for(i = 0; i < 7; i=i+1)
             q[i] <= mem[i];           
       end
    end
endmodule