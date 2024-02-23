// Test type: conditional_statement - if(expr) null else if(expr) statement else null
// Vparser rule name:
// Author: andreib
module conditional_statement12;
reg a,b,c;
initial if(a==b) ;
else if(a<=b) c=0;
else ;
endmodule
