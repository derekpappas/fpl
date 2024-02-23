// Test type: initial statement - disable_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module initcon10;
task the_task;
;
endtask
initial disable the_task;
endmodule
