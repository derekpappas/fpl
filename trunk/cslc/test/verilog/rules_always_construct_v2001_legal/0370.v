// Test type: always statement - task_enable - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon37;
reg a;
task test_task;
;
endtask
always test_task;
endmodule
