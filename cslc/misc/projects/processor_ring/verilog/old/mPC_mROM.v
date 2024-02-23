//test mPC + mROM
module tb_mPC_mROM();
   parameter ADDR_WIDTH = 6;
   
   reg ofs_en, br_en, clock, reset_;
   reg [ADDR_WIDTH-1:0] ofs;
   reg [ADDR_WIDTH-1:0] br_addr;
   wire [ADDR_WIDTH-1:0] pc_addr;
   wire [31:0] rom_ir;
   
   reg [ADDR_WIDTH-1:0]PC;
   reg [31:0] IR;
   reg valid;
   
   mpc #(ADDR_WIDTH)mPC(pc_addr, ofs, br_addr, ofs_en, br_en, clock, reset_);
   mrom mIM(pc_addr, rom_ir);
   
   always@(posedge clock or negedge reset_) begin
       if(!reset_) begin
           PC = 0;
           IR = 0;
           //valid = 0;
       end
       else begin
           PC = pc_addr;
           IR = rom_ir;
           //valid = !br;
       end
   end
   
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