module sig_ned(Q, clk);
    input clk;
    output [3:0] Q;
    
    reg [3:0] Q;
        
    initial 
     begin 
       Q=4'b0000;
     end
    always@(posedge clk)
      Q=Q+1;
endmodule

module tb;
    wire [3:0] Q;
    reg clk;
    
    sig_ned S(Q, clk);
    initial clk=0;
    always #5 clk=~clk;
endmodule