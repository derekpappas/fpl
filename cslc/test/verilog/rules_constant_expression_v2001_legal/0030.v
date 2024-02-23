// Test type: Constant Expression - primary - specparam
// Vparser rule name:
// Author: andreib
module constantexpression(a,b,q);
input a,b;
output q;
specify
  specparam delay=15;
  (a=>q)=delay;
endspecify
or o1(q,a,b);
endmodule
