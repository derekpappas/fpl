// mE logic

assign  cntl_alu_id0={{16{1'b0}},control.p_immed};  // 16b immediate value, concat with zero 
assign  dm_rd_addr=alu_dm_dm7[9:0];                  // 10 bits read address for DM
assign  dm_wr_addr=alu_dm_dm7[9:0];
assign  dm_data_out=rf1_alu_rf4;                    // write data for DM , from RF second output


