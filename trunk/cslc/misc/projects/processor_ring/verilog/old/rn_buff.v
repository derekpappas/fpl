always@(posedge ck or negedge rst_) begin
  if(!rst_) begin
    {bus_out_data, bus_out_addr, bus_out_unit_id, bus_out_be,
  bus_out_cmd, bus_out_src_nid, bus_out_dst_nid, bus_out_age,
  bus_out_valid} =0;
  end
  else begin
    {bus_out_data, bus_out_addr, bus_out_unit_id, bus_out_be,
  bus_out_cmd, bus_out_src_nid, bus_out_dst_nid, bus_out_age,
  bus_out_valid}={bus_in_data, bus_in_addr, bus_in_unit_id, bus_out_be,
  bus_in_cmd, bus_in_src_nid, bus_in_dst_nid, bus_in_age,
  bus_in_valid};
  end
end
