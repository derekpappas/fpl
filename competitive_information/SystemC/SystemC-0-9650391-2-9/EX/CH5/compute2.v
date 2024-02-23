// Copyright 2003 Star Galaxy Publishing
// File: compute2.v

module compute2 (marks, grade);
  input [3:0] marks;

  output [1:0] grade;
  reg [1:0] grade;

  always @(marks)
    if (marks < 5)
      grade = 0;
    else if (marks < 7)
      grade = 1;
    else
      grade = 2;
endmodule
