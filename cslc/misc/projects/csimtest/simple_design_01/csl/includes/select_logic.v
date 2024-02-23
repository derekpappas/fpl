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