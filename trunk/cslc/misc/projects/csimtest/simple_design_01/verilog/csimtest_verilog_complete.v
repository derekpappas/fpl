//////////////////////////////////////////////
//        Design hierarchy & logic          //
//////////////////////////////////////////////

module cnt(out   ,
           reset_,
           en    ,
           clk   );
output reg [1:0] out;
input  reset_;
input  en    ;
input  clk   ;

always @ (posedge clk or negedge reset_) begin
  if(~reset_) begin
    out <= 2'b00;
  end
  else begin if(en) begin
         out <= out + 1;
       end
  end
end   

endmodule
         
module select(out0,
              out1,
              out2,
              out3,
              in  ,
              reset_,
              clk);
output reg out0;
output reg out1;
output reg out2;
output reg out3;
input [1:0] in ;
input    reset_;
input clk      ;

always @ (posedge clk) begin
  if(~reset_) begin
    {out0, out1, out2, out3} <= 4'b0000;
end else begin
  case (in)
    2'b00 : begin 
             out0 = 1'b1;
{out1, out2, out3} = 3'b000;
            end
    2'b01 : begin 
             out1 = 1'b1;
{out0, out2, out3} = 3'b000;
            end
    2'b10 : begin 
             out2 = 1'b1;
{out0, out1, out3} = 3'b000;
            end
    2'b11 : begin 
             out3 = 1'b1;
{out0, out1, out2} = 3'b000;
            end

  endcase
end
end
endmodule
              
module top(even  ,
           odd   ,
           valid ,
           reset_,
           en    ,
           clk);

 output even;
 output odd ;
 output valid;
 input reset_;
 input en;
 input clk;
 
 wire out0;
 wire out1;
 wire out2;
 wire out3;
 wire weven = out0 ^ out2;
 wire wodd  = out1 ^ out3;
 wire even = weven;
 wire odd  = wodd ;
 wire wvalid = weven ^ wodd;
 wire valid = wvalid & en;
 wire [1:0] wcntcase;

 cnt cnt(.out(wcntcase), .reset_(reset_), .en(en), .clk(clk));
 select select(.out0(out0), .out1(out1), .out2(out2), .out3(out3), .in(wcntcase), .reset_(reset_), .clk(clk));

endmodule


//////////////////////////////////////////////
//                Testbench                 //
//////////////////////////////////////////////
module top_tb();
    reg clk;
    reg reset_;
    reg en;
    
    wire even, odd, valid;
    
    top top(.even(even), .odd(odd), .valid(valid), 
            .reset_(reset_), .en(en), .clk(clk));
            
    initial begin
       clk = 1'b0;
       reset_ = 1'b0;
       en = 1'b0;
       #4 reset_ = 1'b1; 
       #10 en = 1'b1;
       #16 en = 1'b0;
       #4  en = 1'b1;
   end
            
   always #2 clk = ~clk;
            
    
endmodule