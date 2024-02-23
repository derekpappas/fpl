// Copyright 2003 Star Galaxy Publishing
// File: case_ex.v

module case_ex (day_of_week, sleep_time);
  input [2:0] day_of_week;

  output[3:0] sleep_time;
  reg[3:0] sleep_time;

  always @(day_of_week)
    case (day_of_week)
      1, 2, 3, 4: sleep_time = 6;
      5 : sleep_time = 8;
      6 : sleep_time = 9;
      0 : sleep_time = 7;
      default : sleep_time = 6;
    endcase
endmodule
