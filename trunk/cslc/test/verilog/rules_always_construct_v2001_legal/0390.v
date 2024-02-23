// Test type: always statement - task_enable - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon39;
reg a,b,c;
task test_task;
;
endtask
always (*b, c*) test_task;
endmodule
