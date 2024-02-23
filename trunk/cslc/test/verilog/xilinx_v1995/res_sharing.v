/* Resource Sharing Example 

* RES_SHARING.V 

* May 2001 

*/ 


module res_sharing (A1, B1, C1, D1, COND_1, Z1); 


input COND_1; 

input [7:0] A1, B1, C1, D1; 

output [7:0] Z1; 


reg [7:0] Z1; 


always @(A1 or B1 or C1 or D1 or COND_1) 

begin 

if (COND_1) 

Z1 <= A1 + B1; 

else 

Z1 <= C1 + D1; 

end 


endmodule 

