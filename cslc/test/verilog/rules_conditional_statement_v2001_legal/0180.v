// Test type: conditional_statement - if(expr) statement else if(expr) statement else statement
// Vparser rule name:
// Author: andreib
module conditional_statement18;
reg a,b,c,d;
initial if(a==b) c=1;
else if(a<=b) c=0;
else d=0;
endmodule
