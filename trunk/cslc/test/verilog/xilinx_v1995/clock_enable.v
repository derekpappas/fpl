/* Clock enable example 
 * CLOCK_ENABLE.V 
 * May 2001                                     
*/ 
 
module clock_enable (IN1, IN2, DATA, CLK, LOAD, DOUT); 
 
input IN1, IN2, DATA; 
input CLK, LOAD; 
output DOUT; 
 
wire ENABLE; 
reg DOUT; 
 
assign ENABLE = IN1 & IN2 & LOAD; 
 
    always @(posedge CLK) 
    begin  
            if (ENABLE)  
                 DOUT <= DATA; 
    end 
 
endmodule 
