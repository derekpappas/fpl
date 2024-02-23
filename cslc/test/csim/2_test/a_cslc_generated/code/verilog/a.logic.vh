  always @( posedge clk or negedge reset_ )  begin 
    if ( ~(reset_) )  begin 
      out <= 0;
      valid_out <= 0;
    end
    else  begin 
      out <= in;
      valid_out <= valid_in;
    end
  end
