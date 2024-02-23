// Test type: always statement - disable_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon10;
task the_task;
;
endtask
always disable the_task;
endmodule
