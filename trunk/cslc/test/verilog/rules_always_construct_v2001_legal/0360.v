// Test type: always statement - system_task_enable - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon36;
reg a,b,c;
always (*b, c*) a=$random;
endmodule
