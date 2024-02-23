// Test type: initial statement - disable_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon11;
reg b;
task the_task;
;
endtask
initial (*b*)disable the_task;
endmodule
