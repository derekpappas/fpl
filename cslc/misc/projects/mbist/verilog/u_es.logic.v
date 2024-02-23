// u_es verilog code

assign ct_out=ct_in[7] ? {8'b11111111,ct_in} : {8'b0,ct_in};