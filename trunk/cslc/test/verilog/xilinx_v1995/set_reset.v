module setreset (CLK, DIN1, DIN2, SET, RESET, 

DOUT1, DOUT2); 

  input CLK; 

  input DIN1, DIN2; 

  input SET, RESET; 

  output DOUT1, DOUT2; 


  reg DOUT1, DOUT2; 

always @ (posedge SET or posedge RESET or posedge CLK) 

  begin: set_then_reset 

    if (SET) 

      DOUT1 <= 1'b1; 

    else if (RESET) 

      DOUT1 <= 1'b0; 

    else 

      DOUT1 <= DIN1; 

  end 

always @ (posedge RESET or posedge SET or posedge CLK) 

  begin: reset_then_set 

    if (RESET) 

      DOUT2 <= 1'b0; 

    else if (SET) 

      DOUT2 <= 1'b1; 

    else 

      DOUT2 <= DIN2; 

  end 

endmodule 

