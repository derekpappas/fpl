always @ (posedge clk or negedge reset_) begin
  if(~reset_) begin
    out <= 2'b00;
  end
  else begin if(en) begin
         out <= out + 1;
       end
  end
end