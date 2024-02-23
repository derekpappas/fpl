`timescale 1 ps / 1 ps


module tb;
    reg clk;
    reg rd_1st_3;
  
  initial begin
    clk = 1;
   forever begin
   #2 clk = ~clk;
   end 
   end
    reg [2:0] ra_tb;
    reg reset_;
  initial begin
    @ (posedge clk)reset_ = 1;
    @ (posedge clk)reset_ = 0;
    @ (posedge clk)reset_ = 1;
    @ (posedge clk)rd_1st_3 = 1'b0;
    @ (posedge clk)rd_1st_3 = 1'b0;
    @ (posedge clk)rd_1st_3 = 1'b0;
    @ (posedge clk)rd_1st_3 = 1'b1;
    @ (posedge clk)rd_1st_3 = 1'b1;
    @ (posedge clk)rd_1st_3 = 1'b1;
    @ (posedge clk)rd_1st_3 = 1'b0;
  end
  
  tmp tmp_1(.clk(clk), .reset_(reset_), .rd_1st_3(rd_1st_3));
  
  always@(posedge clk or negedge reset_) begin
      if (~reset_) begin
          ra_tb <= 0;
      end
      else if(rd_1st_3) begin
          ra_tb <= ra_tb + 1'b1;
      end
     end
  endmodule
  
  
module tmp (clk, reset_, rd_1st_3);
    input clk;
    input reset_;
    input rd_1st_3;
    
    reg [2:0]ra;
        
    always@(posedge clk or negedge reset_) begin
      if (~reset_) begin
          ra <= 0;
      end
      else if(rd_1st_3) begin
        ra <= ra + 1'b1;
      end
    end
endmodule
