// Test type: conditional_statement - if(expr) null else statement
// Vparser rule name:
// Author: andreib
module conditional_statement4;
reg a,b,c;
initial if(a==b) ;
else c=0;
endmodule
