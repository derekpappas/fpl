

module testbench;

reg clk, reset_;

initial begin
    clk = 1'b0;
    forever #2 clk  = ~clk;
end

   `define D_W 8
   `define A_W 8

//-----------------------------------------------------------------------------
// Reset Generation
//-----------------------------------------------------------------------------
initial begin
    reset_ = 1'b1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    reset_ = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    reset_ = 1'b1;
    @(posedge clk);

    @(posedge clk);
    rf_wr_data_in <= `D_W'h00;
    rf_wr_addr     <= `A_W'h0;
    rf_wr_en        <= 1'b1;

    @(posedge clk);
    rf_wr_data_in <= `D_W'h11;
    rf_wr_addr     <= `A_W'h1;
    rf_wr_en        <= 1'b1;

    @(posedge clk);
    rf_wr_data_in <= `D_W'h22;
    rf_wr_addr     <= `A_W'h2;
    rf_wr_en        <= 1'b1;

    @(posedge clk);
    rf_wr_data_in <= `D_W'h33;
    rf_wr_addr     <= `A_W'h3;
    rf_wr_en        <= 1'b1;

end
 
   reg [`D_W - 1: 0] rf_wr_data_in;
   reg  [`A_W - 1: 0] rf_wr_addr;
   reg  rf_wr_en
   reg [`A_W - 1: 0] rf_rd_addr;
   wire [`D_W - 1: 0] rf_data_out;
   wire rf_v

// register_file #(`D_W, `A_W) rf0 (
//                             .clk                (clk               ),
 //                            .reset             (reset_            ),
//                             .rf_wr_data_in (rf_wr_data_in ),
//                             .rf_wr_addr     (rf_wr_addr     ),
//                             .rf_wr_en        (rf_wr_en        ),
//                             .rf_rd_addr      (rf_rd_addr      ),  
//                             .rf_data_out    (rf_data_out),
//                             .rf_v               (rf_v)
//                            );

reg [`D_W - 1: 0] mem_data [0:`A_W-1];
reg [`A_W - 1: 0] mem_addr [0:`A_W-1];

integer j;
initial j =0;

// save the writes (addr and data) to the register file
always @(posedge clk) begin
  if (rf_wr_en) begin
    mem_data[rf_wr_addr] <= rf_wr_data_in;
    mem_data[j]               <= rf_wr_addr;
    j = j + 1;
  end
end

integer i;
initial i =0;

reg [`D_W - 1: 0] check_data;
reg [`A_W - 1: 0] check_addr;

// compare the output of the reigster file when the valid bit is set to the
// value that was written to the checker memory

always @(posedge clk) begin
  if (rf_v) begin
     check_addr <= mem_addr[ i ];
     check_data <= mem_addr[ check_addr ];
     if (check_data  != rf_data_out) begin
       $display("Error mismatch i = %d mem[ %d ] =  %x  rf_data_out = %x 
", i, check_addr, mem[ check_addr ], rf_data_out );
      end
       i = i + 1;
  end
end

endmodule
