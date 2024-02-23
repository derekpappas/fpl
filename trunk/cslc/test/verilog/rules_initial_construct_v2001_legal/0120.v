// Test type: initial statement - disable_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon12;
reg b,c;
task the_task;
;
endtask
initial (*b, c*)disable the_task;
endmodule
