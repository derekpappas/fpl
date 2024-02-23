// Copyright 2003 Star Galaxy Publishing
// File: ifstmt.v

module ifstmt (sync, mode, cond);
  input sync, mode;
  output cond;

  assign cond = sync > mode ? mode : sync;
endmodule
