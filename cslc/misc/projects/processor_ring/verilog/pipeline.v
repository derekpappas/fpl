// Monica
//29 feb 2008
// valid bit, pc and control pipeline

module ff_en(clk, r_, en, d, q);
  parameter WIDTH = 0;
  
  input              clk;
  input              r_ ;
  input              en ;
  input  [WIDTH-1:0] d  ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <= {WIDTH{1'b0}};
     end
     else if (en) begin
        q <= d;
     end
  end

endmodule

module valid_pipeline(pc_en,
                      br,
                      br_c,
                      pc0,
                      cnt3,
                      v6,
                      pc6,
                      cnt6,
                      clk,
                      r_,
                      en);

    input pc_en,pc0,cnt3,br,br_c,clk,r_,en;
    output v6,pc6,cnt6;
    wire v1_,v2_,v3_,v4_,v5_;    
    wire v1,v2,v3,v4,v5;           //valid bit pipestages
    wire pc1,pc2,pc3,pc4,pc5;   //pc pipestages
    wire cnt4,cnt5;    

    and (v1_,v1,~br,~br_c);      
    and (v2_,v2,~br,~br_c);
    and (v3_,v3,~br,~br_c);
    and (v4_,v4,~br_c);
    and (v5_,v5,~br_c);
  
  // valid pipeline
    ff_en #(1) ffv0(clk,r_,en,pc_en,v1);
    ff_en #(1) ffv1(clk,r_,en,v1_,v2);
    ff_en #(1) ffv2(clk,r_,en,v2_,v3);
    ff_en #(1) ffv3(clk,r_,en,v3_,v4);
    ff_en #(1) ffv4(clk,r_,en,v4_,v5);
    ff_en #(1) ffv5(clk,r_,en,v5,v6);
   
 //pc pipeline
    ff_en #(1) ffpc0(clk,r_,en,pc0,pc1);
    ff_en #(1) ffpc1(clk,r_,en,pc1,pc2);
    ff_en #(1) ffpc2(clk,r_,en,pc2,pc3);
    ff_en #(1) ffpc3(clk,r_,en,pc3,pc4);
    ff_en #(1) ffpc4(clk,r_,en,pc4,pc5);
    ff_en #(1) ffpc5(clk,r_,en,pc5,pc6);
    
//control pipeline
    ff_en #(1) ffcnt3(clk,r_,en,cnt3,cnt4);
    ff_en #(1) ffcnt4(clk,r_,en,cnt4,cnt5);
    ff_en #(1) ffcnt5(clk,r_,en,cnt5,cnt6);

    initial 
    $monitor("pc_en=%b,v1=%b,v2=%b,v3=%b,v4=%b,v5=%b,v6=%b \n pc0=%b,pc1=%b,pc2=%b,pc3=%b,pc4=%b,pc5=%b,pc6=%b,cnt3=%b,cnt4=%b,cnt5=%b,cnt6=%b",
    pc_en,v1,v2,v3,v4,v5,v6,pc0,pc1,pc2,pc3,pc4,pc5,pc6,cnt3,cnt4,cnt5,cnt6);
   
 endmodule

