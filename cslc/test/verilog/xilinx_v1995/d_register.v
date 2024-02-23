/* Changing Latch into a D-Register  
 * D_REGISTER.V 
 * May 2001                           */ 
 
 
module d_register (CLK, DATA, Q); 
 
input CLK; 
input DATA; 
output Q; 
 
reg Q; 
 
 
    always @ (posedge CLK) 
    begin: My_D_Reg 
     Q <= DATA; 
    end  
 
endmodule 