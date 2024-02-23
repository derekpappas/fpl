////////////////////////////////////////////// 
// CLOCK_MUX.V Version 1.1                                             // 
//This is an example of an instantiation of // 
// global buffer (BUFGS) from an internally // 
// driven signal, a multiplied clock.                                             // 
// March 2001                                             // 
////////////////////////////////////////////// 
 
module clock_mux(DATA,SEL,SLOW_CLOCK,FAST_CLOCK,
                    DOUT); 
       input  DATA, SEL; 
   input  SLOW_CLOCK, FAST_CLOCK; 
   output DOUT; 
 
    reg   CLOCK; 
    wire   CLOCK_GBUF; 
    reg    DOUT; 
        always @ (SEL or FAST_CLOCK or SLOW_CLOCK) 
        begin 
        if (SEL == 1'b1) 
            CLOCK <= FAST_CLOCK; 
        else 
            CLOCK <= SLOW_CLOCK; 
          end 
 
        BUFGS GBUF_FOR_MUX_CLOCK (.O(CLOCK_GBUF), 
                              .I(CLOCK)); 
 
    always @ (posedge CLOCK_GBUF) 
        DOUT = DATA; 
endmodule 
