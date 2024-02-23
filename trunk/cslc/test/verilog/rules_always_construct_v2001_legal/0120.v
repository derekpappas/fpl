// Test type: always statement - disable_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon12;
reg b,c;
task the_task;
;
endtask
always (*b, c*)disable the_task;
endmodule
