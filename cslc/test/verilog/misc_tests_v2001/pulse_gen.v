`timescale 1ms / 1us  

module pulse_gen(pulse, clk, reset_);
    input clk, reset_;
    output pulse;
    
    reg pulse;
    reg [9:0] count;
    
    always@(posedge clk or negedge reset_) begin
        if(!reset_) begin
            count = 0;
            pulse = 0;
        end
        else begin
            if(count != 10'b1111100111) begin
                count = count + 1;
                pulse = 0;
            end
            else begin
                count = 0;
                pulse = 1;
            end            
        end
    end    
endmodule

module tb_pulse_gen();
   reg clk, reset_;
   wire pulse; 

   pulse_gen PG(pulse, clk, reset_);
   
   initial begin
       clk = 0;
       reset_ = 1;
       #6;
       reset_ = 0;
       #5;
       reset_ = 1;
   end
   always # 0.5 clk=~clk;
endmodule