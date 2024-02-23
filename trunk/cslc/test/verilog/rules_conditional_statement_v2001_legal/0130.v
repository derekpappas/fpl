// Test type: conditional_statement - if(expr) statement else if(expr) null else null
// Vparser rule name:
// Author: andreib
module conditional_statement13;
reg a,b,c;
initial if(a==b) c=1;
else if(a<=b) ;
else ;
endmodule
