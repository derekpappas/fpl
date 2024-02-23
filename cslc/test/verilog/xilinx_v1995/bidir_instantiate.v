module bidir_instantiate (DATA, READ_WRITE); 


input READ_WRITE ; 

inout [1:0] DATA ; 


reg [1:0] LATCH_OUT ; 

wire [1:0] DATA_OUT ; 

wire GATE ; 


assign GATE = ~READ_WRITE; 


assign DATA_OUT[0] = LATCH_OUT[0] & LATCH_OUT[1]; 

assign DATA_OUT[1] = LATCH_OUT[0] | LATCH_OUT[1]; 

// I/O primitive instantiation 


ILD_1 INPUT_PATH_0 (.Q(LATCH_OUT[0]), .D(DATA[0]), .G(GATE)); 

ILD_1 INPUT_PATH_1 (.Q(LATCH_OUT[1]), .D(DATA[1]), .G(GATE)); 

OBUFT_S OUPUT_PATH_0 (.O(DATA[0]),.I(DATA_OUT[0]),.T(READ_WRITE)); 

OBUFT_S OUPUT_PATH_1 (.O(DATA[1]),.I(DATA_OUT[1]),.T(READ_WRITE)); 

endmodule 

