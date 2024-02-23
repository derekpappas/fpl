//counter with enable
module counter(state, en, r, clk);
    parameter BITS=4;
    input en, r, clk;
    output [BITS-1:0]state=0;
    
    reg [BITS-1:0]state;
    
    always@(posedge clk or negedge r) begin
        if(!r) begin
            state=0;
        end
        else
        if(en) begin
            state=state+1;
        end
    end
endmodule

//testbench
module tb_counter();
   parameter BITS=4;
   reg en, r, clk;
   wire [BITS-1:0]state;
   
   counter CNT(state, en, r, clk); 
   initial begin
       clk=0;
       en=0;
       r=1;
       #6;
       r=0;
       #5;
       r=1;
       #15;
       en=1;
   end
   always #5 clk=~clk;
endmodule