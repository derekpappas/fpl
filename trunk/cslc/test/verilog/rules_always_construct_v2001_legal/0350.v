// Test type: always statement - system_task_enable - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon35;
reg a,b;
always (*b*) a=$random;
endmodule
