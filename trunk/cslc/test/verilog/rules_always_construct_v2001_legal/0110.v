// Test type: always statement - disable_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon11;
reg b;
task the_task;
;
endtask
always (*b*)disable the_task;
endmodule
