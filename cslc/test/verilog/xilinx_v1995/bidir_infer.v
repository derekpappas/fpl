module bidir_infer (DATA, READ_WRITE); 

input READ_WRITE ; 

inout [1:0] DATA ; 


reg [1:0] LATCH_OUT ; 


always @ (READ_WRITE or DATA) 

begin 

if (READ_WRITE == 1'b1) 

LATCH_OUT <= DATA; 

end 


assign DATA[0] = READ_WRITE ? 1'bZ : (LATCH_OUT[0] & LATCH_OUT[1]); 

assign DATA[1] = READ_WRITE ? 1'bZ : (LATCH_OUT[0] | LATCH_OUT[1]); 

endmodule 

