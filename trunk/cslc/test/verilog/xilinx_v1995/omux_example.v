module omux_example (DATA_IN, SEL, DATA_OUT) ; 
input  [1:0] DATA_IN ; 
input        SEL ; 
output       DATA_OUT ; 
OMUX2 DUEL_OUT (.O(DATA_OUT), .D0(DATA_IN[0]), 
 .D1(DATA_IN[1]), .S0(SEL)); 
endmodule 
