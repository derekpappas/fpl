// Test type: initial statement - system_task_enable - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon36;
reg a,b,c;
initial (*b, c*) a=$random;
endmodule
