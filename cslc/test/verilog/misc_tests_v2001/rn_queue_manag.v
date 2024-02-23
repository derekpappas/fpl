    wire node_en;
    
    assign node_en = (NID ~^ bus_cmd_DstNID);
    assign fifo_push = bus_cmd_valid0 & bus_cmd_age & (!fifo_cmd_full) & node_en;
    assign bus_cmd_conf = !fifo_cmd_full;
    assign bus_cmd_confNID = bus_cmd_SrcNID;
    assign valid1 = fifo_cmd_push ? 0 : bus_cmd_valid0;

