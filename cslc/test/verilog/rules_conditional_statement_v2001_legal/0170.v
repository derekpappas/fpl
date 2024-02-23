// Test type: conditional_statement - if(expr) statement else if(expr) null else statement
// Vparser rule name:
// Author: andreib
module conditional_statement17;
reg a,b,c,d;
initial if(a==b) c=1;
else if(a<=b) ;
else d=1;
endmodule
