//####################################
//# Circuit: mPC                     #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Mar 30, 2007               #
//####################################

module mpc(pc_addr, 
           ofs, br_addr, 
           ofs_en, 
           br_en, 
           clock, 
           reset_);
   parameter ADDR_WIDTH = 6;
   
   input ofs_en, br_en, clock, reset_;
   input [ADDR_WIDTH-1:0] ofs;
   input [ADDR_WIDTH-1:0] br_addr;
   output [ADDR_WIDTH-1:0] pc_addr;
   
   reg [ADDR_WIDTH-1:0] pc; 
   
   assign pc_addr = pc;
      
   always@(posedge clock or negedge reset_) begin
       if(!reset_) begin
           pc = 0;
       end
       else begin
           pc = br_en? br_addr : (ofs_en ? (pc+ofs) : (pc+1));
       end
   end   
endmodule

//mpc testbench
module tb_mpc();
   parameter ADDR_WIDTH = 6;
   
   reg ofs_en, br_en, clock, reset_;
   reg [ADDR_WIDTH-1:0] ofs;
   reg [ADDR_WIDTH-1:0] br_addr;
   wire [ADDR_WIDTH-1:0] pc_addr;
   
   mpc #(ADDR_WIDTH)PC(pc_addr, ofs, br_addr, ofs_en, br_en, clock, reset_);
   
   initial begin
       clock = 0;
       reset_= 1;
       ofs = 6'b000100;
       br_addr = 6'b100111;
       ofs_en = 0;
       br_en = 0;
       #3;
       reset_=0;
       #5;
       reset_=1;
       #30;
       br_en = 1;
       #10;
       br_en = 0;
       #30;
       ofs_en = 1;
       
   end
   
   always #5 clock = ~clock;
endmodule