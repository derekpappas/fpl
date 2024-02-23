module control(clk,
                  reset_,
                  stop_sim,
                  stall,
                  cmp_on,
                  rd_1st_2,
                  valid_off);
   input          clk,
                  reset_,
                  stop_sim;
   output         stall,
                  cmp_on,
                  rd_1st_2,
                  valid_off;
   reg            stall,
                  cmp_on,
                  start_sim,
                  rd_1st_2;
   wire random_gen_en = (cmp_on & ~stall & start_sim);
   wire valid_off;
   reg [1:0]nr_valid_off;
   
   assign valid_off = (random_gen_en ? $random:0);
      
   initial begin
       start_sim = 1'b0;
       cmp_on = 1'b1;
       rd_1st_2 = 1'b0;
       stall = 1'b0;
       #4 start_sim = 1'b1;
       nr_valid_off = 2'b00;
   end       

   always@(posedge clk) begin
       stall <= $random;
   end
   always@(negedge reset_) begin
       rd_1st_2 <= 1'b1;
   end
   endmodule
   
   module testbench;
       reg clk;
       wire stall,rd_1st_2,valid_off;
       wire cmp_on = ~rd_1st_2;
       reg stop_sim;
       reg reset_;
       
       initial begin
           clk = 1'b0;
           stop_sim = 1'b0;
           reset_ = 1'b1;
           #6 reset_ = 1'b0;
       end
       
       always clk =  #2 ~clk;
       
       control control(.clk(clk),.reset_(reset_),.stop_sim(stop_sim),.stall(stall),.cmp_on(cmp_on),.rd_1st_2(rd_1st_2),.valid_off(valid_off));
   endmodule