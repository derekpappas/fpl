// Test type: conditional_statement - if(expr) null else if(expr) null else statement
// Vparser rule name:
// Author: andreib
module conditional_statement15;
reg a,b,c,d;
initial if(a==b) ;
else if(a<=b) ;
else d=1;
endmodule
