// Copyright 2003 Star Galaxy Publishing
// File: tri_state.v

module tri_state (ready, dina, dinb, selectx);
  input ready, dina, dinb;

  output selectx;

  assign selectx = ready ? 'bz : dina & dinb;
endmodule
