module DMA();
    
parameter memory_offset = 4; // programmable byte addressable 32-bit words

reg dma_base[17:0];
reg dma_addr[17:0];
reg bus_addr[17:0];
reg bus_length[17:0];
reg dma_length[17:0];
reg dma_max[17:0];
reg dma_burst;
wire dma_clr = dma_max;
wire dma_inc = ~dma_clr;
wire BUS_RD_OP, bus_cmd, BUS_WR_OP, bus_valid, bus_burst, dma_on, clk, r_;

wire bus_trans_rd_op = bus_valid & (BUS_RD_OP == bus_cmd);
wire bus_trans_wr_op = bus_valid & (BUS_WR_OP == bus_cmd);
wire mem_op = bus_trans_rd_op || bus_trans_wr_op;

always@(posedge clk or negedge r_) begin
  if (~r_) begin
    dma_addr  = {18{1'b0}};
    dma_max   = {18{1'b0}};
    dma_burst = 1'b0;
  end
  else if (dma_clr) begin
    dma_addr = {18{1'b0}};
    dma_max = {18{1'b0}};
    dma_burst = 1'b0;
  end
  else if (mem_op) begin // new bus transaction works for single or 
//burst read
     dma_max <= bus_addr + bus_length;
     dma_addr <= dma_addr;
  end
  else if (bus_burst) begin  
     dma_max <= dma_max;
     dma_addr <= dma_addr + memory_offset;
  end
end

// this is a simple state machine to control the burst logic

always@(posedge clk or negedge r_) begin // (maybe this should be negedge clk) 
  if (~r_) begin
    dma_burst = 1'b0;
  end
  else if (dma_clr) begin
    dma_burst = 1'b0;
  end
  else if (mem_op || dma_on) begin
    dma_burst = 1'b1;
  end
end

wire mem_rd_addr[17:0];
assign mem_rd_addr[17:0] = dma_addr;
assign dma_clr = dma_base ~^ dma_max; // equals

endmodule