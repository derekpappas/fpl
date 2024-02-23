// rf verilog code
reg [15:0] rf_memory [0:15];

always @ (posedge clock or negedge reset)
  begin
    if (reset == 0)
      begin
        data_out1=16'b0;
        data_out2=16'b0;
      end else
           if (rd_en1) begin
             data_out1 <= rf_memory[rd_addr1];
           end
           if (rd_en2) begin
             data_out2 <= rf_memory[rd_addr2];
           end
           if (wr_en) begin
             rf_memory[wr_addr] <= data_in;
           end
  end

