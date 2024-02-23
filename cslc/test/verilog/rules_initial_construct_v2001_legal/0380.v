// Test type: initial statement - task_enable - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon38;
reg a,b;
task test_task;
;
endtask
initial (*b*) test_task;
endmodule
