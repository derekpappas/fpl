// Copyright 2003 Star Galaxy Publishing
// File: init_packet.v

module init_packet (send, tsq_packet_id, tsq_packet_state);
  input send;
  output [1:0] tsq_packet_id, tsq_packet_state;

  assign tsq_packet_id = send ? 15 : 1;
  assign tsq_packet_state = send ? 0 : 3;
endmodule
