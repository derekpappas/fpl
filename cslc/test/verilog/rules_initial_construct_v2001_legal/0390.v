// Test type: initial statement - task_enable - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon39;
reg a,b,c;
task test_task;
;
endtask
initial (*b, c*) test_task;
endmodule
