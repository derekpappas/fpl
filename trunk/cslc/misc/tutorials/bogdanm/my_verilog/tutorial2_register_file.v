module rf_tesbench;//this was tesed using the wave window
reg[31:0] wr_data_in = 32'b0;
reg[3:0] rd_addr;
reg[3:0] wr_addr = 4'b0;
reg clock, wr_enable, rd_enable;
wire valid_bit, rd_event, wr_event;
wire[31:0] out;
register_file dut(out, rd_event, wr_event, valid_bit, rd_enable, rd_addr, wr_enable, wr_addr, wr_data_in, clock);
reg[3:0] memory [31:0];//external memory for recording the writes to the register file (dut)(I'm questioning the necessity
//of this memory in the testbench)
initial begin clock = 1'b0;//clock generation
forever #2  clock = !clock;
end
initial begin
   repeat(16) begin//this will write all memory locations in the register file
      #1 wr_enable = 1'b1;
      memory[wr_addr] = wr_data_in;//recording the writes
      #3 wr_addr = wr_addr + 1;
      wr_data_in = wr_data_in + 1;
      wr_enable = 1'b0;
   end
end   
initial begin//this will execute 2 read operations(the second must generate the rd_event)
   #73 rd_addr = 4'b1001;
   rd_enable = 1'b1;
   #3 rd_enable = 1'b0;
   rd_addr = 4'b1100;
   #1 rd_enable = 1'b1;
   #3 rd_enable = 1'b0;
end
endmodule



module register_file(out, rd_event, wr_event, valid_bit, rd_enable, rd_addr, wr_enable, wr_addr, wr_data_in, clock);
parameter D_WIDTH = 32;
parameter A_WIDTH = 4;//4 bits are enough for addressing 16 memory locations
input clock, wr_enable, rd_enable;
input[D_WIDTH-1:0] wr_data_in;
input[A_WIDTH-1:0] wr_addr;
input[A_WIDTH-1:0] rd_addr;
output reg valid_bit, rd_event, wr_event;
output reg[D_WIDTH-1:0] out;
reg[A_WIDTH-1:0] rf [D_WIDTH-1:0];//it's here where all the values of the register file will be stored
always @(posedge clock) begin
   valid_bit = rd_enable;
   if(rd_enable == 1'b1) begin
      out = rf[rd_addr][D_WIDTH-1:0];//output of the register file will contain the data from the memory location with the read_addr address
      rd_event = (rd_addr == 4'b1100 || rd_addr == 4'b1110) ? 1'b1 : 1'b0;//generate an event when memory locations 12 or 14 are read
   end
   else//obviously if rd_enable is not active, then rd_event must be 0
      rd_event = 1'b0;
   if(wr_enable == 1'b1) begin
      rf[wr_addr][D_WIDTH-1:0] = wr_data_in;//after a write, the memory location with the write_addr address will contain write_data_in
      wr_event = (wr_addr == 4'b0111) ? 1'b1 : 1'b0;//generate an event when memory location 7 is written
   end
   else
      wr_event = 1'b0;
end
endmodule
//there is something left unspecified: what if rd_enable and wr_enable are both active in one posedge? What should happen then?
//Is this case even aloud for the register file?
