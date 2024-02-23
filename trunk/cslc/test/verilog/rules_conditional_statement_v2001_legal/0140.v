// Test type: conditional_statement - if(expr) statement else if(expr) statement else null
// Vparser rule name:
// Author: andreib
module conditional_statement14;
reg a,b,c;
initial if(a==b) c=1;
else if(a<=b) c=0;
else ;
endmodule
