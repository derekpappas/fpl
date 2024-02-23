// Test type: disable_statement - disable hierarchical task id
// Vparser rule name:
// Author: andreib
module disable_statement1;
task TEST;
;
endtask
initial disable TEST;
endmodule
