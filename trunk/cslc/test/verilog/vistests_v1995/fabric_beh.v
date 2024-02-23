/* The Implementation of FAB4B4, Include ARBITRATION, ACKNOWLEDGMENT,PAUSE_DATASWITCH,
IN_LATCHES AND OUT_LATCHES */

module FAB4B4 ( dExt, frameStart, ackIn, clock, dOutExt, ackOut );

input [0:31] dExt;
input [3:0] ackIn;
input frameStart, clock;
output [0:31] dOutExt;
output [0:3] ackOut;
wire [0:31]  dOut, d;
wire [0:3] xGrant, yGrant, outputDisable, outputEnable;

latch latch0 ( dExt, d, clock );
latch latch1 ( dOut, dOutExt, clock );


ARBITRATION  ARBITRATION0 ( d, frameStart, clock, xGrant, yGrant, outputDisable);
PAUSE_DATASWITCH PAUSE_DATASWITCH0 ( d, clock, xGrant, yGrant, outputDisable, dOut);
ack  ack0 (ackIn, xGrant, yGrant, outputDisable, ackOut);

endmodule

module latch ( dExt, d, clock);

input [0:31] dExt;
output [0:31] d;
input clock;
reg [0:31] d;
initial begin 
  d = 0;
  end

always @( posedge clock) begin
  d = dExt;
  
end

endmodule

/* The Implementation of ARBITRATION, include TIMING, ARBITERS, PRIORITY_DECODE */

module ARBITRATION ( d, frameStart, clock, xGrant, yGrant, outputDisable);

input [31:0] d;
input frameStart, clock; 
output [0:3] xGrant, yGrant, outputDisable;

wire routeEnable;
wire [15:0] ItReq;

TIMING TIMIMG0 ( frameStart, clock, d[0], d[8], d[16], d[24], routeEnable);
PRIORITY_DECODE  PRIORITY_DECODE0 ( d, clock,  ItReq);
ARBITERS  ARBITERS0 ( ItReq, frameStart, clock, routeEnable, xGrant, yGrant, outputDisable);

endmodule


typedef enum {RUN, WAIT, ROUTE} timing_state;
module TIMING ( frameStart, clock, active0, active1, active2, active3, x);

input frameStart, clock;
input active0, active1, active2, active3;
output x;
timing_state reg state;

wire anyActive;
assign anyActive = active0 ||  active1 || active2 || active3;
assign x = (state == ROUTE) ;
initial 
  state = RUN;
 

always @(posedge clock)  begin

case (state)
   RUN:
   if ( frameStart == 1)  
       state = WAIT;
       
      
 
 
    WAIT: 
       if ( ( frameStart == 0) && (anyActive == 1))
       state = ROUTE;
      
  


    ROUTE: begin

        if ( frameStart == 0)
        state = RUN;
        else state = WAIT;
     end   
 
endcase

end
endmodule


/* The Implementation of PRIORITY_DECODE, include DECODE_N, PRIORITY, and PAUSE */

module  PRIORITY_DECODE ( d, clock,  ItReq);

input [31:0] d;
input clock;
output [0:15] ItReq;
reg [15:0] ItReq;

wire [15:0] hiReq, genReq, req;
initial ItReq = 0;
DECODE_N  DCODE_N ( d,  hiReq, genReq );
PRIORITY  PRIORITY ( hiReq, genReq,  req );

always @(posedge clock)

begin 

	ItReq = req ;

end
	
endmodule


/* DECODE_N.v Implementation */

module DECODE_N ( d,  hiReq, genReq );

input [31:0] d;
output [15:0] hiReq, genReq;


assign hiReq[0] = (d[0] == 1) && ( d[1] == 1) && ( d[2] == 0 ) && (d[3] == 0);
assign hiReq[1] = (d[0] == 1) && ( d[1] == 1) && ( d[2] == 0 ) && (d[3] == 1);
assign hiReq[2] = (d[0] == 1) && ( d[1] == 1) && ( d[2] == 1 ) && (d[3] == 0);
assign hiReq[3] = (d[0] == 1) && ( d[1] == 1) && ( d[2] == 1 ) && (d[3] == 1);
assign hiReq[4] = (d[8] == 1) && ( d[9] == 1) && ( d[10] == 0 ) && (d[11] == 0);
assign hiReq[5] = (d[8] == 1) && ( d[9] == 1) && ( d[10] == 0 ) && (d[11] == 1);
assign hiReq[6] = (d[8] == 1) && ( d[9] == 1) && ( d[10] == 1 ) && (d[11] == 0);
assign hiReq[7] = (d[8] == 1) && ( d[9] == 1) && ( d[10] == 1 ) && (d[11] == 1);
assign hiReq[8] = (d[16] == 1) && ( d[17] == 1) && ( d[18] == 0 ) && (d[19] == 0);
assign hiReq[9] = (d[16] == 1) && ( d[17] == 1) && ( d[18] == 0 ) && (d[19] == 1);
assign hiReq[10] = (d[16] == 1) && ( d[17] == 1) && ( d[18] == 1 ) && (d[19] == 0);
assign hiReq[11] = (d[16] == 1) && ( d[17] == 1) && ( d[18] == 1 ) && (d[19] == 1);
assign hiReq[12] = (d[24] == 1) && ( d[25] == 1) && ( d[26] == 0 ) && (d[27] == 0);
assign hiReq[13] = (d[24] == 1) && ( d[25] == 1) && ( d[26] == 0 ) && (d[27] == 1);
assign hiReq[14] = (d[24] == 1) && ( d[25] == 1) && ( d[26] == 1 ) && (d[27] == 0);
assign hiReq[15] = (d[24] == 1) && ( d[25] == 1) && ( d[26] == 1 ) && (d[27] == 1);

assign genReq[0] = (d[0] == 1) && (d[2] == 0) && (d[3] == 0);
assign genReq[1] = (d[0] == 1) && (d[2] == 0) && (d[3] == 1);
assign genReq[2] = (d[0] == 1) && (d[2] == 1) && (d[3] == 0);
assign genReq[3] = (d[0] == 1) && (d[2] == 1) && (d[3] == 1);
assign genReq[4] = (d[8] == 1) && (d[10] == 0) && (d[11] == 0);
assign genReq[5] = (d[8] == 1) && (d[10] == 0) && (d[11] == 1);
assign genReq[6] = (d[8] == 1) && (d[10] == 1) && (d[11] == 0);
assign genReq[7] = (d[8] == 1) && (d[10] == 1) && (d[11] == 1);
assign genReq[8] = (d[16] == 1) && (d[18] == 0) && (d[19] == 0);
assign genReq[9] = (d[16] == 1) && (d[18] == 0) && (d[19] == 1);
assign genReq[10] = (d[16] == 1) && (d[18] == 1) && (d[19] == 0);
assign genReq[11] = (d[16] == 1) && (d[18] == 1) && (d[19] == 1);
assign genReq[12] = (d[24] == 1) && (d[26] == 0) && (d[27] == 0);
assign genReq[13] = (d[24] == 1) && (d[26] == 0) && (d[27] == 1);
assign genReq[14] = (d[24] == 1) && (d[26] == 1) && (d[27] == 0);
assign genReq[15] = (d[24] == 1) && (d[26] == 1) && (d[27] == 1);

endmodule

/* PRIORITY Implementation */

module PRIORITY ( hiReq, genReq,  req );

input [15:0] hiReq, genReq;
output [15:0] req;


assign req[0] = ( hiReq[0] == 1 ) || ( ( genReq[0] == 1 ) && ( hiReq[4] == 0 ) && ( hiReq[8] == 0 ) && ( hiReq[12] == 0 )); 
assign req[1] = ( hiReq[1] == 1 ) || ( ( genReq[1] == 1 ) && ( hiReq[5] == 0 ) && ( hiReq[9] == 0 ) && ( hiReq[13] == 0 )); 
assign req[2] = ( hiReq[2] == 1 ) || ( ( genReq[2] == 1 ) && ( hiReq[6] == 0 ) && ( hiReq[10] == 0 ) && ( hiReq[14] == 0 )); 
assign req[3] = ( hiReq[3] == 1 ) || ( ( genReq[3] == 1 ) && ( hiReq[7] == 0 ) && ( hiReq[11] == 0 ) && ( hiReq[15] == 0 )); 
assign req[4] = ( hiReq[4] == 1 ) || ( ( genReq[4] == 1 ) && ( hiReq[0] == 0 ) && ( hiReq[8] == 0 ) && ( hiReq[12] == 0 )); 
assign req[5] = ( hiReq[5] == 1 ) || ( ( genReq[5] == 1 ) && ( hiReq[1] == 0 ) && ( hiReq[9] == 0 ) && ( hiReq[13] == 0 )); 
assign req[6] = ( hiReq[6] == 1 ) || ( ( genReq[6] == 1 ) && ( hiReq[2] == 0 ) && ( hiReq[10] == 0 ) && ( hiReq[14] == 0 )); 
assign req[7] = ( hiReq[7] == 1 ) || ( ( genReq[7] == 1 ) && ( hiReq[3] == 0 ) && ( hiReq[11] == 0 ) && ( hiReq[15] == 0 )); 
assign req[8] = ( hiReq[8] == 1 ) || ( ( genReq[8] == 1 ) && ( hiReq[0] == 0 ) && ( hiReq[4] == 0 ) && ( hiReq[12] == 0 )); 
assign req[9] = ( hiReq[9] == 1 ) || ( ( genReq[9] == 1 ) && ( hiReq[1] == 0 ) && ( hiReq[5] == 0 ) && ( hiReq[13] == 0 )); 
assign req[10] = ( hiReq[10] == 1 ) || ( ( genReq[10] == 1 ) && ( hiReq[2] == 0 ) && ( hiReq[6] == 0 ) && ( hiReq[14] == 0 )); 
assign req[11] = ( hiReq[11] == 1 ) || ( ( genReq[11] == 1 ) && ( hiReq[3] == 0 ) && ( hiReq[7] == 0 ) && ( hiReq[15] == 0 )); 
assign req[12] = ( hiReq[12] == 1 ) || ( ( genReq[12] == 1 ) && ( hiReq[0] == 0 ) && ( hiReq[4] == 0 ) && ( hiReq[8] == 0 )); 
assign req[13] = ( hiReq[13] == 1 ) || ( ( genReq[13] == 1 ) && ( hiReq[1] == 0 ) && ( hiReq[5] == 0 ) && ( hiReq[9] == 0 )); 
assign req[14] = ( hiReq[14] == 1 ) || ( ( genReq[14] == 1 ) && ( hiReq[2] == 0 ) && ( hiReq[6] == 0 ) && ( hiReq[10] == 0 )); 
assign req[15] = ( hiReq[15] == 1 ) || ( ( genReq[15] == 1 ) && ( hiReq[3] == 0 ) && ( hiReq[7] == 0 ) && ( hiReq[11] == 0 )); 


endmodule


/* The Implementation of ARBITERS, include 4 arbiters */

module ARBITERS ( req, frameStart, clock,  routeEnable, xGrant, yGrant, outputDisable);

input [15:0] req;
input frameStart , routeEnable, clock;
output [3:0] xGrant, yGrant, outputDisable;

ARBITER ARBITER0 ( req[0], req[4], req[8], req[12], routeEnable, frameStart, clock, xGrant[0], yGrant[0], outputDisable[0] );
ARBITER ARBITER1 ( req[1], req[5], req[9], req[13], routeEnable, frameStart,clock, xGrant[1], yGrant[1], outputDisable[1] );
ARBITER ARBITER2 ( req[2], req[6], req[10], req[14], routeEnable, frameStart,clock,  xGrant[2], yGrant[2], outputDisable[2] );
ARBITER ARBITER3 ( req[3], req[7], req[11], req[15], routeEnable, frameStart,clock,  xGrant[3], yGrant[3], outputDisable[3] );

endmodule


/* The Implementation of ARBITER, include ARBITER_XY and OUTDIS */

module ARBITER ( req0, req1, req2, req3, routeEnable, frameStart, clock, xGrant, yGrant,
                 outputDisable);

input  req0, req1, req2, req3, routeEnable, frameStart, clock;
output xGrant, yGrant, outputDisable;
wire  outputEnable;

OUTDIS OUTDIS0( req0, req1, req2, req3, routeEnable, frameStart , clock,  outputDisable, outputEnable);
ARBITER_XY ARBITER_XY0( req0, req2, req1, req3, routeEnable, clock, xGrant, yGrant );

endmodule




module ARBITER_XY ( req0, req1, req2, req3, routeEnable, clock, x, y );

input req0, req1, req2, req3, routeEnable, clock ;
output x, y;
reg x, y;

wire [0:1] ipi;


wire req_prii0, req_prii1, req_prii2, req_prii3;
initial begin 
  x = 0;
  y = 0;
end


assign req_prii0 = req0;
assign req_prii1 = req1;
assign req_prii2 = req2;
assign req_prii3 = req3;
assign ipi[0] = y;
assign ipi[1] = x;
always @(posedge clock) begin
 if ( routeEnable) begin

   

   case(ipi)
    2'b00: begin
           if ( req_prii1) begin x = 0; y = 1; end /*ipi_n = 2'b01;*/
           else if ( req_prii2) begin x = 1; y = 0; end /*ipi_n = 2'b10;*/
           else if ( req_prii3) begin x = 1; y = 1; end /*ipi_n = 2'b11;*/
           else begin x = 0; y = 0; end /*ipi_n = 2'b00;*/
           end

    2'b01: begin
           if ( req_prii2) begin x = 1; y = 0; end /*ipi_n = 2'b10;*/
           else if ( req_prii3) begin x = 1; y = 1; end /*ipi_n = 2'b11;*/
           else if ( req_prii0) begin x = 0; y = 0; end /*ipi_n = 2'b00;*/
           else begin x = 0; y = 1; end /*ipi_n = 2'b01;*/
           end
   
    2'b10: begin
           if ( req_prii3) begin x = 1; y = 1; end /*ipi_n = 2'b11;*/
           else if ( req_prii0) begin x = 0; y = 0; end /*ipi_n = 2'b00;*/
           else if ( req_prii1) begin x = 0; y = 1; end /*ipi_n = 2'b01;*/
           else begin x = 1; y = 0; end /*ipi_n =2'b10;*/
           end

    2'b11: begin
           if ( req_prii0) begin x = 0; y = 0; end /*ipi_n = 2'b00;*/
           else if ( req_prii1) begin x = 0; y = 1; end /*ipi_n = 2'b01;*/
           else if ( req_prii2) begin x = 1; y = 0; end /*ipi_n = 2'b10;*/
           else begin x = 1; y = 1; end /*ipi_n = 2'b11;*/
           end
    endcase
    
  end
  else begin x = x;
             y = y;
  end

end


endmodule
/* OUTDIS Implementation */

module OUTDIS ( req0, req1, req2, req3, routeEnable, fs, clock, outputDisable, outputEnable);

input  req0, req1, req2, req3;
input routeEnable, fs, clock;
output outputDisable, outputEnable;

wire anyReq;

assign outputEnable = ~ outputDisable;
assign anyReq = req0 | req1 | req2  | req3;
disabl disable0 ( outputDisable, fs, anyReq, routeEnable, clock);
endmodule


module disabl( outputDisable, fs, anyReq, routeEnable, clock);
input clock, fs, anyReq, routeEnable;
output outputDisable;
reg outputDisable;
initial  outputDisable = 0;

always @( posedge clock) begin

    case ( outputDisable) 
    1'b0: 
          if ( fs )  outputDisable = 1;
    1'b1: 
          if ( routeEnable & anyReq )  outputDisable = 0;
    endcase
end

endmodule



/*DATASWITCH Implementation*/

module PAUSE_DATASWITCH ( d, clock, xGrant, yGrant, outputDisable, dOut);

input [31:0] d ;
input  clock;
input [3:0] xGrant, yGrant, outputDisable;

output [31:0] dOut;
wire [31:0] dPause;

XiDFFd Pause ( d, clock, dPause );


DATASWITCHC DSW0 (dPause, clock, xGrant[0], yGrant[0], outputDisable[0],
dOut[0],dOut[1],dOut[2],dOut[3],dOut[4],dOut[5],dOut[6],dOut[7]);

DATASWITCHC DSW1 (dPause, clock, xGrant[1], yGrant[1], outputDisable[1], 
dOut[8],dOut[9],dOut[10],dOut[11],dOut[12],dOut[13],dOut[14],dOut[15] );

DATASWITCHC DSW2 (dPause, clock, xGrant[2], yGrant[2], outputDisable[2], 
dOut[16],dOut[17], dOut[18],dOut[19],dOut[20],dOut[21],dOut[22],dOut[23]);

DATASWITCHC DSW3 (dPause, clock, xGrant[3], yGrant[3], outputDisable[3], 
dOut[24],dOut[25],dOut[26],dOut[27],dOut[28],dOut[29],dOut[30],dOut[31]);

endmodule 

/* XiDFFd implementation */
module XiDFFd (d, clock, dPause);
input clock;
input [31:0] d;
output [31:0] dPause;
reg [31:0] dPause;

initial dPause = 0;
always @(posedge clock) 
begin
   
	dPause = d;
end
endmodule

/* the implementation of DATASWITCHC */


module DATASWITCHC ( d, clock, x, y, outputDisable, q0, q1, q2, q3, q4, q5, q6, q7);

input [31:0] d;
input clock, x, y, outputDisable;

output  q0, q1, q2, q3, q4, q5, q6, q7;

DMUX2B4CALL Pr0 ( d[0], d[8], d[16], d[24], d[1], d[9], d[17], d[25], clock, x, y,
		outputDisable, q0, q1);
DMUX2B4CALL Pr1 ( d[2], d[10], d[18], d[26], d[3], d[11], d[19], d[27], clock, x, y,
		outputDisable, q2, q3);
DMUX2B4CALL Pr2 ( d[4], d[12], d[20], d[28], d[5], d[13], d[21], d[29], clock, x, y,
		outputDisable, q4, q5);
DMUX2B4CALL Pr3 ( d[6], d[14], d[22], d[30], d[7], d[15], d[23], d[31], clock, x, y,
		outputDisable, q6, q7);


endmodule
/* The Implementation of DMUX2B4CALL */

module DMUX2B4CALL( d0, d1, d2, d3, d4, d5, d6, d7,  clock, x, y, outputDisable,
dOut0, dOut1);
input  d0, d1, d2, d3, d4, d5, d6, d7;
input clock, x, y, outputDisable;
output  dOut0, dOut1;

wire [7:0] d;
wire [1:0] q0, q1;

assign d[0]=d0;
assign d[1]=d1;
assign d[2]=d2;
assign d[3]=d3;
assign d[4]=d4;
assign d[5]=d5;
assign d[6]=d6;
assign d[7]=d7;

DMUX4T2FFC P0 ( d[0], d[1], d[2], d[3], clock, y, outputDisable, q0);
DMUX4T2FFC P1 ( d[4], d[5], d[6], d[7], clock, y, outputDisable, q1);
assign dOut0 = ( q0[0] && (x ==0 )) || ( q0[1] && ( x == 1 )),
       dOut1 = ( q1[0] && (x ==0 )) || ( q1[1] && ( x == 1 ));
       

endmodule


/*The implement of DMUX4T2FFC*/

module DMUX4T2FFC(d0, d1, d2, d3, clock, y, outputDisable, q);
input clock, y, outputDisable;
input  d0, d1, d2, d3;
output [1:0] q;
wire [1:0] mux;

assign mux[0]= (d0 && ( y == 0))||(d1 && ( y == 1)),
       mux[1]= (d2 && ( y == 0))||(d3 && ( y == 1));

XiDFFrd BFF0 (mux[0], clock, outputDisable, q[0]);
XiDFFrd BFF1 (mux[1], clock, outputDisable, q[1]);

endmodule


/*the implement of XiDFFrd*/
module XiDFFrd(xD, xC, xRD, xQ);
input  xC, xRD;
input  xD;
output xQ;
reg xQ;
initial xQ = 0;

always @(posedge xC)
begin
   if (!xRD)
      xQ = xD;

   else

       xQ = 0;
       
end
endmodule




/*ack*/

module ack (ackIn, xGrant, yGrant, outputDisable, ackOut);

input [3:0] ackIn, xGrant, yGrant, outputDisable;
output [3:0] ackOut;

assign ackOut[0] = (( ackIn[0] == 1 ) && ( xGrant[0] == 0 ) && ( yGrant[0] == 0 ) && ( outputDisable[0] ==  0 )) ||
                   (( ackIn[1] == 1 ) && ( xGrant[1] == 0 ) && ( yGrant[1] == 0 ) && ( outputDisable[1] ==  0 )) ||
                   (( ackIn[2] == 1 ) && ( xGrant[2] == 0 ) && ( yGrant[2] == 0 ) && ( outputDisable[2] ==  0 )) ||
                   (( ackIn[3] == 1 ) && ( xGrant[3] == 0 ) && ( yGrant[3] == 0 ) && ( outputDisable[3] ==  0 )) ;
assign ackOut[1] = (( ackIn[0] == 1 ) && ( xGrant[0] == 0 ) && ( yGrant[0] == 1 ) && ( outputDisable[0] ==  0 )) ||
                   (( ackIn[1] == 1 ) && ( xGrant[1] == 0 ) && ( yGrant[1] == 1 ) && ( outputDisable[1] ==  0 )) ||
                   (( ackIn[2] == 1 ) && ( xGrant[2] == 0 ) && ( yGrant[2] == 1 ) && ( outputDisable[2] ==  0 )) ||
                   (( ackIn[3] == 1 ) && ( xGrant[3] == 0 ) && ( yGrant[3] == 1 ) && ( outputDisable[3] ==  0 )) ;
assign ackOut[2] = (( ackIn[0] == 1 ) && ( xGrant[0] == 1 ) && ( yGrant[0] == 0 ) && ( outputDisable[0] ==  0 )) ||
                   (( ackIn[1] == 1 ) && ( xGrant[1] == 1 ) && ( yGrant[1] == 0 ) && ( outputDisable[1] ==  0 )) ||
                   (( ackIn[2] == 1 ) && ( xGrant[2] == 1 ) && ( yGrant[2] == 0 ) && ( outputDisable[2] ==  0 )) ||
                   (( ackIn[3] == 1 ) && ( xGrant[3] == 1 ) && ( yGrant[3] == 0 ) && ( outputDisable[3] ==  0 )) ;
assign ackOut[3] = (( ackIn[0] == 1 ) && ( xGrant[0] == 1 ) && ( yGrant[0] == 1 ) && ( outputDisable[0] ==  0 )) ||
                   (( ackIn[1] == 1 ) && ( xGrant[1] == 1 ) && ( yGrant[1] == 1 ) && ( outputDisable[1] ==  0 )) ||
                   (( ackIn[2] == 1 ) && ( xGrant[2] == 1 ) && ( yGrant[2] == 1 ) && ( outputDisable[2] ==  0 )) ||
                   (( ackIn[3] == 1 ) && ( xGrant[3] == 1 ) && ( yGrant[3] == 1 ) && ( outputDisable[3] ==  0 )) ;


endmodule