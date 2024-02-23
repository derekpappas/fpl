// Test type: initial statement - system_task_enable - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon35;
reg a,b;
initial (*b*) a=$random;
endmodule
