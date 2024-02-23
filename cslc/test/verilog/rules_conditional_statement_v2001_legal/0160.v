// Test type: conditional_statement - if(expr) null else if(expr) statement else statement
// Vparser rule name:
// Author: andreib
module conditional_statement16;
reg a,b,c,d;
initial if(a==b) ;
else if(a<=b) c=0;
else d=0;
endmodule
