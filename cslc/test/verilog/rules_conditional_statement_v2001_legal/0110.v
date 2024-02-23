// Test type: conditional_statement - if(expr) null else if(expr) null else null
// Vparser rule name:
// Author: andreib
module conditional_statement11;
reg a,b,c;
initial if(a==b) ;
else if(a<=b) ;
else ;
endmodule
