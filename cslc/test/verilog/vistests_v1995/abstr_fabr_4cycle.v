typedef enum { S0, S1, S2, S3, S4, S5, S6, S7} abstract_state;

module environment ( clock );

input clock;
output[3:0] dOut;
abstract_state wire state;
wire [3:0] din0, din1, din2, din3;
wire fs;
FAB4B4 FAB0( din0,din1,din2,din3, ackIn, fs,  clock, dOut, ackOut );
Data d0 ( clock, din0, din1, din2, din3, fs, state, ackIn ) ;
endmodule

module Data ( clock, din0, din1, din2, din3 , fs, state, ackIn ) ;
input clock;
output [3:0] din0, din1, din2, din3, ackIn;
output fs;
output state;
abstract_state reg state;
wire[3:0]  d0, d1, d2, d3, a;

reg [3:0] din0, din1, din2, din3, ackIn;
reg fs;
reg term;
reg  d30, d31, d32, d33;
initial begin
  din0 = 0;
  din1 = 0;
  din2 = 0;
  din3 = 0;
  ackIn = 0;
  fs = 1;
  term = 0;
  state = S0;
  d30 = 0;
  d31 = 0;
  d32 = 0;
  d33 = 0;
end
assign d0 = $ND( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
assign d1 = $ND( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
assign d2 = $ND( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
assign d3 = $ND( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
assign a =  $ND( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);

always @ ( posedge clock ) begin

 case ( state ) 
     S0: state = S1;
     S1: state = S2;
     S2: state = S3;
     S3: state = S4;
                            
     S4: state = S5;
     S5: state = S6;
     S6: state = S7;
     S7: state = S2;
     
 endcase

 fs = ( state == S0 || state == S6) ? 1 : 0;
 if ( state == S0 || state == S1 || state == S4 || state == S5 || state == S6 ||
      state == S7 ) begin 
      din0 = 0;
      din1 = 0;
      din2 = 0;
      din3 = 0;
 end
 if ( state == S2 ) begin 
               din0 = d0;
               din1 = d1;
               din2 = d2;
               din3 = d3;
           
             
 end
 if ( state == S3 ) begin
  
               din0 = d0;
               din1 = d1;
               din2 = d2;
               din3 = d3;
               d30 = din0[0];
               d31 = din1[0];
               d32 = din2[0];
               d33 = din3[0];
   
 end

 if ( state == S5 || state == S6 ) 
       ackIn = a;
 else  
       ackIn = 0;
end
 
endmodule





module FAB4B4 ( dExt0,dExt1,dExt2,dExt3, ackIn, frameStart, clock, dOutExt, ackOut );

input [3:0] dExt0, dExt1, dExt2, dExt3, ackIn;
output [3:0] ackOut, dOutExt;
wire [3:0] d0, d1, d2, d3, dOut;
input frameStart, clock;
wire [3:0] xGrant, yGrant, outputDisable;

latch latch0 ( dExt0, d0, clock );
latch latch1 ( dExt1, d1, clock );
latch latch2 ( dExt2, d2, clock );
latch latch3 ( dExt3, d3, clock );
latch latch4 ( dOut, dOutExt, clock);


ARBITRATION ARBITRATION0(d0, d1, d2, d3, frameStart, clock, xGrant, yGrant, outputDisable);
PAUSE_DATASWITCH PAUSE_DATASWITCH0 ( d0[0], d1[0] , d2[0], d3[0], clock, xGrant, yGrant, outputDisable, dOut);
ack  ack0 (ackIn, xGrant, yGrant, outputDisable, ackOut);


endmodule

module latch ( dExt, d, clock);

input [0:3] dExt;
output [0:3] d;
input clock;
reg [0:3] d;
initial begin 
  d = 0;
end

always @( posedge clock) begin
  d = dExt;
  
end

endmodule



/* The Implementation of ARBITRATION, include TIMING, ARBITERS, PRIORITY_DECODE */

module ARBITRATION (d0, d1, d2, d3, frameStart, clock, xGrant, yGrant, outputDisable);

input [3:0]d0, d1, d2, d3;
input frameStart, clock; 
output [0:3] xGrant, yGrant, outputDisable;

wire routeEnable;
wire [15:0] ItReq;

TIMING TIMIMG0 ( frameStart, clock,d0[0], d1[0], d2[0], d3[0], routeEnable);
PRIORITY_DECODE  PRIORITY_DECODE0 (d0, d1, d2, d3, clock,  ItReq);
ARBITERS  ARBITERS0 ( ItReq, frameStart, clock, routeEnable, xGrant, yGrant, outputDisable);

endmodule


/* TIMIMG Implementation */

module TIMING ( frameStart, clock, active0, active1, active2, active3, x);

input frameStart, clock;
input active0, active1, active2, active3;

output x;
wire xBar, dx, dy, yterm, anyActive, frameStartBar;
reg x, y;

initial begin
   x = 0;
   y = 0;
end

not InvX (xBar, x);

or OrAnyActive (anyActive, active0, active1, active2, active3);
not InvFS (frameStartBar, frameStart);

and AnyTerm (yterm, xBar, y);

and AndDx (dx, xBar, y, anyActive, frameStartBar);
or OrDy (dy, yterm, frameStart);
always @(posedge clock)

begin

	x = dx;
	y = dy;

end
endmodule



/* The Implementation of ARBITERS, include 4 arbiters */

module ARBITERS ( req, frameStart, clock,  routeEnable, xGrant, yGrant, outputDisable);

input [15:0] req;
input frameStart , routeEnable, clock;
output [3:0] xGrant, yGrant, outputDisable ;

ARBITER ARBITER0 ( req[0], req[4], req[8], req[12], routeEnable, frameStart, clock, xGrant[0], yGrant[0], outputDisable[0] );
ARBITER ARBITER1 ( req[1], req[5], req[9], req[13], routeEnable, frameStart, clock, xGrant[1], yGrant[1], outputDisable[1] );
ARBITER ARBITER2 ( req[2], req[6], req[10], req[14], routeEnable, frameStart, clock, xGrant[2], yGrant[2], outputDisable[2] );
ARBITER ARBITER3 ( req[3], req[7], req[11], req[15], routeEnable, frameStart, clock, xGrant[3], yGrant[3], outputDisable[3] );

endmodule

/* The Implementation of ARBITER, include ARBITER_XY and OUTDIS */

module ARBITER ( req0, req1, req2, req3, routeEnable, frameStart, clock, xGrant, yGrant,
                 outputDisable);

input  req0, req1, req2, req3, routeEnable, frameStart, clock;
output xGrant, yGrant, outputDisable;
wire  outputEnable;

OUTDIS OUTDIS0( req0, req1, req2, req3, routeEnable, frameStart , clock, outputDisable, outputEnable);
ARBITER_XY ARBITER_XY0( req0, req2, req1, req3, routeEnable, clock, xGrant, yGrant );

endmodule
/* OUTDIS Implementation */

module OUTDIS ( req0, req1, req2, req3, routeEnable, fs, clock, outputDisable, outputEnable);

input  req0, req1, req2, req3;
input routeEnable, fs, clock;
output outputDisable, outputEnable;

wire kOut, anyReq;

or AnyOr ( anyReq, req0, req1, req2, req3 );
and AndKout (kOut, routeEnable, anyReq);

JKEF FFOutDis ( fs, kOut, clock, outputDisable, outputEnable);

endmodule  
/* JKEF Implementation */
module JKEF ( j, k, c,  q, qBar);

input j, k, c;
output q, qBar;

wire d, dOne, okOne, dZeroBar, jBar, kBar; 
reg q;
initial q = 1;

not InvQ ( qBar, q);
not InvK ( kBar, k);
not Invj ( jBar, j);

assign dZeroBar= !( ( k & jBar) | ( k & q) );
and AndOKOne ( okOne, dZeroBar, q);

assign dOne = (j & kBar)| (j & qBar);


or OrD ( d, dOne, okOne );


always @(posedge c)

begin

    q = d;
    
   
end

endmodule


/* ARBITER_XY Implementation  Including ARB_XEL, ARB_YEL and ARBITER_FF, This is a
modified version , since the output x and y will be the inputs of ARBY and ARBX and
ARBITER_FF in the next state at the mean time, so I cannot treat the ARBITER_FF as a
module to implement this circuit */

module ARBITER_XY ( req0, req1, req2, req3, routeEnable, clock, x, y );

input req0, req1, req2, req3, routeEnable, clock ;


wire jy, ky, jx, kx;
output x, y;

reg x, y;

initial begin
  
  x = 0;
  y = 0;

end


ARB_YEL ARB_YEL0 ( req0, req1, req2, req3, x, jy, ky );
ARB_XEL ARB_XEL0 ( req0, req1, req2, req3, y, jx, kx );

wire dX, dOneX, okOneX, dZeroBarX, jBarX, kBarX, qBarX; 
wire dY, dOneY, okOneY, dZeroBarY, jBarY, kBarY, qBarY; 

not InvQx ( qBarX, x);
not InvKx ( kBarX, kx);
not Invjx ( jBarX, jx);

not InvQy ( qBarY, y);
not InvKy ( kBarY, ky);
not Invjy ( jBarY, jy);


and AndOKOneX ( okOneX, dZeroBarX, x);
and AndOKOneY ( okOneY, dZeroBarY, y);

assign dOneX = (jx & kBarX)|| (jx & qBarX);
assign dOneY = (jy & kBarY)|| (jy & qBarY);

assign dZeroBarX= !( ( kx & jBarX) || ( kx & x) );
assign dZeroBarY= !( ( ky & jBarY) || ( ky & y) );

or OrDx ( dX, dOneX, okOneX );
or OrDy ( dY, dOneY, okOneY );

always @(posedge clock)

begin

   if ( routeEnable == 1) begin

    x = dX ;
    y = dY ;
    end

   else begin
    x = x;
    y = y;
   end
    
   
end

endmodule

/* ARB_XEL Implementation */

module ARB_XEL (req0, req1, req2, req3, y, jx, kx   );

input req0, req1, req2, req3, y;
output jx, kx ;

wire reqBarJxKxCLB1, reqBarJxKxCLB3;
wire [1:0] jxFact, kxFact;

/* Jx */

not InvReqJxKxCLB1 (reqBarJxKxCLB1, req1);

or OrFactJx0 ( jxFact[0], y,  reqBarJxKxCLB1);
or OrFactJx1 ( jxFact[1], req3, req2 );
and AndJx ( jx, jxFact[0], jxFact[1]);

/* Kx */

not InvReqJxKxCLB3 (reqBarJxKxCLB3, req3);


or OrFactkx0 ( kxFact[0], y,  reqBarJxKxCLB3);
or OrFactKx1 ( kxFact[1], req0, req1 );
and AndKx ( kx, kxFact[0], kxFact[1]);

endmodule
/* ARB_YEL Implementation */

module  ARB_YEL ( req0, req1, req2, req3, x, jy, ky);

input req0, req1, req2, req3, x;
output ky, jy;

wire  reqBarJyCLB0, reqBarJyCLB2, reqBarKyCLB1, reqBarkyCLB3;
wire  jyTerm0, jyTerm1, kyTerm0,  kyTerm;
wire  xBarJyCLB, xBarkyCLB;

/*Jy */

not InvXJyCLB ( xBarJyCLB, x);
not InvReqOJyCLB ( reqBarJyCLB0, req0);
not InvReq2JyCLB ( reqBarJyCLB2, req2);

or OrTermJy0 ( jyTerm0, x, reqBarJyCLB2);
or OrTermJy1 ( jyTerm1, xBarJyCLB, reqBarJyCLB0);

assign jy = (jyTerm0 & req3) ||  (jyTerm1 & req1);
/* Ky */

not InvXKyCLB (  xBarkyCLB, x); 
not InvReqOKyCLB ( reqBarKyCLB1, req1);
not InvReq2KyCLB ( reqBarkyCLB3, req3);

or OrTermky0 ( kyTerm0, xBarkyCLB , reqBarKyCLB1);
or OrTermky1 ( kyTerm1, x, reqBarkyCLB3);

assign ky = (kyTerm0 & req2) ||  (kyTerm1 & req0);

endmodule



module  PRIORITY_DECODE ( d0, d1, d2, d3, clock,  ItReq);

input [3:0]  d0, d1, d2, d3;
input clock;
output [0:15] ItReq;
reg [15:0] ItReq;

wire [15:0] hiReq, genReq, req;

initial ItReq = 0;
DECODE_N  DCODE_N ( d0, d1, d2, d3,  hiReq, genReq );
PRIORITY  PRIORITY ( hiReq, genReq,  req );

always @(posedge clock)

begin 

	ItReq = req ;

end
	
endmodule

/* DECODE_N.v Implementation */

module DECODE_N (  d0, d1, d2, d3,  hiReq, genReq );

input [3:0]  d0, d1, d2, d3;
output [15:0] hiReq, genReq;

DECODE Decode0 ( d0[0], d0[1], d0[2], d0[3], hiReq[0],hiReq[1],hiReq[2],hiReq[3], genReq[0],genReq[1],genReq[2],genReq[3]);
DECODE Decode1 ( d1[0], d1[1], d1[2], d1[3], hiReq[4],hiReq[5],hiReq[6],hiReq[7], genReq[4],genReq[5],genReq[6],genReq[7]);
DECODE Decode2(  d2[0], d2[1], d2[2], d2[3], hiReq[8],hiReq[9],hiReq[10],hiReq[11], genReq[8],genReq[9],genReq[10],genReq[11]);
DECODE Decode3 ( d3[0], d3[1], d3[2], d3[3], hiReq[12],hiReq[13],hiReq[14],hiReq[15], genReq[12],genReq[13],genReq[14],genReq[15]);

endmodule

/* DECODE Implementation */

module DECODE ( act, pri, r1, r2, hiReq0,hiReq1,hiReq2,hiReq3, genReq0, genReq1, genReq2, genReq3 );

input act, pri, r1, r2;
output hiReq0,hiReq1,hiReq2,hiReq3, genReq0,genReq1,genReq2,genReq3;

wire r1Bar, r2Bar;

not InvR1 ( r1Bar, r1);
not InvR2 ( r2Bar, r2); 

and andHiReq0 ( hiReq0, act, pri, r1Bar, r2Bar);
and andHiReq1 ( hiReq1, act, pri, r1Bar, r2);
and andHiReq2 ( hiReq2, act, pri, r1, r2Bar);
and andHiReq3 ( hiReq3, act, pri, r1, r2);

and andGenReq0 ( genReq0, act, r1Bar, r2Bar);
and andGenReq1 ( genReq1, act, r1Bar, r2);
and andGenReq2 ( genReq2, act, r1, r2Bar);
and andGenReq3 ( genReq3, act, r1, r2);

endmodule

/* PRIORITY Implementation */

module PRIORITY ( hiReq, genReq,  req );

input [15:0] hiReq, genReq;
output [15:0] req;

PRIFIL4CLB PriFilter0 (hiReq[0], hiReq[4], hiReq[8], hiReq[12], genReq[0], genReq[4], 
			genReq[8], genReq[12], req[0], req[4], req[8], req[12]);
PRIFIL4CLB PriFilter1 (hiReq[1], hiReq[5], hiReq[9], hiReq[13], genReq[1], genReq[5], 
			genReq[9], genReq[13], req[1], req[5], req[9], req[13]);
PRIFIL4CLB PriFilter2 (hiReq[2], hiReq[6], hiReq[10], hiReq[14], genReq[2], genReq[6], 
			genReq[10], genReq[14], req[2], req[6], req[10], req[14]);
PRIFIL4CLB PriFilter3 (hiReq[3], hiReq[7], hiReq[11], hiReq[15], genReq[3], genReq[7], 
			genReq[11], genReq[15], req[3], req[7], req[11], req[15]);

endmodule

/* PRIFIL4CLB Implementation */

module PRIFIL4CLB ( hiR0, hiR1, hiR2, hiR3, genR0, genR1, genR2, genR3, req0,
			 req1, req2, req3);

input hiR0, hiR1, hiR2, hiR3, genR0, genR1, genR2, genR3 ;
output req0, req1, req2, req3 ;


PRIFILUNIT PriUnit0 (hiR0, genR0, hiR1, hiR2, hiR3, req0);
PRIFILUNIT PriUnit1 (hiR1, genR1, hiR0, hiR2, hiR3, req1);
PRIFILUNIT PriUnit2 (hiR2, genR2, hiR0, hiR1, hiR3, req2);
PRIFILUNIT PriUnit3 (hiR3, genR3, hiR0, hiR1, hiR2, req3);

endmodule

/* PRIFILUNIT Implementation */

module PRIFILUNIT (hiR, genR, hiOtherR0, hiOtherR1, hiOtherR2, req);

input hiR, genR;
input hiOtherR0, hiOtherR1, hiOtherR2;
output req;

wire notAnyHi, lowOK;

nor NorAnyHi ( notAnyHi, hiOtherR0, hiOtherR1, hiOtherR2);
and AndLowOK ( lowOK, notAnyHi, genR);
or OrReq (req, lowOK, hiR);

endmodule




module PAUSE_DATASWITCH ( d0, d1, d2, d3, clock, xGrant, yGrant, outputDisable, dOut);

input  d0, d1, d2, d3 ;
input  clock;
input [3:0] xGrant, yGrant, outputDisable;

output [3:0] dOut;
wire [3:0] dPause;

XiDFFd Pause0 ( d0, clock, dPause[0] );
XiDFFd Pause1 ( d1, clock, dPause[1] );
XiDFFd Pause2 ( d2, clock, dPause[2] );
XiDFFd Pause3 ( d3, clock, dPause[3] );


DATASWITCHC DSW0 (dPause, clock, xGrant[0], yGrant[0], outputDisable[0], dOut[0]);

DATASWITCHC DSW1 (dPause, clock, xGrant[1], yGrant[1], outputDisable[1], dOut[1] );

DATASWITCHC DSW2 (dPause, clock, xGrant[2], yGrant[2], outputDisable[2], dOut[2]);

DATASWITCHC DSW3 (dPause, clock, xGrant[3], yGrant[3], outputDisable[3], dOut[3]);

endmodule 

/* XiDFFd implementation */
module XiDFFd (d, clock, dPause);
input clock;
input  d;
output  dPause;
reg  dPause;

initial dPause = 0;
always @(posedge clock) 
begin
   
	dPause = d;
end
endmodule







module DATASWITCHC ( d, clock, x, y, outputDisable, q0);

input [3:0] d;
input clock, x, y, outputDisable;

output  q0;
reg q0;
initial begin
  q0 = 0;
end

always @ ( posedge clock) begin
  
  if ( ! outputDisable ) begin 
     q0 = ( x == 0 && y == 0 ) ? d[0] : 
          ( x == 0 && y == 1 ) ? d[1]: 
          ( x == 1 && y == 0 ) ? d[2] : d[3] ;
          
    end
  else  q0 = 0;
                   

end

endmodule


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
          
              
         