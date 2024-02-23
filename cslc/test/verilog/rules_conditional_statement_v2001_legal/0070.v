// Test type: conditional_statement - if(expr) null else if(expr) null
// Vparser rule name:
// Author: andreib
module conditional_statement7;
reg a,b,c;
initial if(a==b) ;
else if(a<=b) ;
endmodule
