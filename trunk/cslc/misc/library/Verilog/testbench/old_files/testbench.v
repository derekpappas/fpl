//defines here
`define DMW 2
`define DMD 8
`define DAW 3
`define ONE 1
`define VER 1
`define VID 3
`define TIMEOUT 7

//modules declarations
//DFF declaration
module ff(clk,in,out);
    parameter AW = 0;
    input             clk;
    input  [AW - 1:0] in ;
    output [AW - 1:0] out;
    reg    [AW - 1:0] out;
    
    always@(posedge clk) begin
        out <= in;
    end
endmodule 

//RF declaration
module rf(clk,re,ra,rd);
    parameter AW = 0, MW = 0, MD = 0;
    input             clk, re;
    input  [AW - 1:0] ra     ;
    output [MW - 1:0] rd     ;
    reg    [MW - 1:0] rd     ;
    
    reg    [MW - 1:0] mem [0:MD -1];
        
    always@(posedge clk) begin
        if(re) begin
            rd <= mem[ra];
        end
    end
endmodule

//Counter declaration
module counter(clk,en, r_, cnt);
   parameter AW = 0;
   input clk,r_,en;
   output [AW - 1:0] cnt;
   reg    [AW - 1:0] cnt;
  
  always@(posedge clk or negedge r_) begin
      if(~r_) begin
         cnt <= -1;
     end
     else begin
         if(en) begin
         cnt <= cnt + 1;
     end
     end
  end
endmodule

module tb_control(clk,
                  stop_sim,
                  bubble,
                  stall);
   input          clk,
                  stop_sim;
   output         bubble,
                  stall;
   reg            bubble,
                  stall,
                  cmp_on,
                  start_sim,
                  rd_1st_2;
   initial begin
       start_sim = 1'b1;
       cmp_on = 1'b1;
       rd_1st_2 = 1'b1;
       stall = 1'b0;
   end       
       
   always@(posedge clk) begin
       bubble = (cmp_on & ~stall & start_sim & rd_1st_2);
   end
   endmodule

//Testbecnh declaration
module testbench();
    //control block
    reg clk, rd_en, r_;
    wire bubble;
    //wire rd_en_ff;
    wire [`DAW - 1:0] ra;
    wire [`DMW - 1:0] rd;
    //mux to dut    
    wire [`DAW - 1:0] ra_mux;
    wire zero_mux = (ra_mux == 0 || ra_mux == 1);
    wire [`DMW - 1:0] stim_vec = (zero_mux | bubble) ? 0: rd;
    //id/version checker
    wire [`DMW - 1:0] version = `VER;
    wire [`DMW - 1:0] id = `VID;
    wire version_assert = (rd == version);
    wire id_assert = (rd == id);
    wire stall;
    reg stop_sim;
    //timeout checker
    //integer 
        
    
    //instantiations
    tb_control control(.clk(clk),.stop_sim(stop_sim),.bubble(bubble),.stall(stall));
    counter #(.AW(`DAW)) counter(.clk(clk),.en(bubble),.r_(r_),.cnt(ra));
    rf #(.AW(`DAW),.MW(`DMW),.MD(`DMD)) rf(.clk(clk),.re(bubble),.ra(ra),.rd(rd));
    //ff #(.AW(`ONE)) ff_stim(.clk(clk),.in(rd_en),.out(rd_en_ff));
    ff #(.AW(`DAW)) ff_ra_mux(.clk(clk),.in(ra),.out(ra_mux));
  
    //control block init  
    initial begin
       $readmemb("E:\\mem_list",rf.mem);
       clk = 1'b0;
       //rd_en = 1'b0;
       rd_en = 1'b1;
       r_ = 1'b0;
       #1
       r_ = 1'b1;
       stop_sim = 1'b0;
    end
   
    always clk = #2 ~clk;
    
    always @(posedge clk) begin
    //id/version checker logic
    //using ra_mux (delayed version of ra) to
    //select the appropriate rd value which
    //gets delayed by the rf operation
       if(ra_mux == 0) begin
            if(~version_assert) begin
                $display("Vector version mismatch! Exiting simulation");
                $finish;
            end
        end
       if(ra_mux == 1) begin
            if(~id_assert) begin
                $display("Vector Id mismatch! Exiting simulation");
                $finish;
            end
        end           
   end
endmodule