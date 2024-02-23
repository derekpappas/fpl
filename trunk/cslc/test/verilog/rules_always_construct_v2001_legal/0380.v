// Test type: always statement - task_enable - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon38;
reg a,b;
task test_task;
;
endtask
always (*b*) test_task;
endmodule
