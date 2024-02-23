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
initial q = 0;

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

DECODE Decode0 ( d[0], d[1], d[2], d[3], hiReq[0],hiReq[1],hiReq[2],hiReq[3], genReq[0],genReq[1],genReq[2],genReq[3]);
DECODE Decode1 ( d[8], d[9], d[10], d[11], hiReq[4],hiReq[5],hiReq[6],hiReq[7], genReq[4],genReq[5],genReq[6],genReq[7]);
DECODE Decode2( d[16], d[17], d[18], d[19], hiReq[8],hiReq[9],hiReq[10],hiReq[11], genReq[8],genReq[9],genReq[10],genReq[11]);
DECODE Decode3 ( d[24], d[25], d[26], d[27], hiReq[12],hiReq[13],hiReq[14],hiReq[15], genReq[12],genReq[13],genReq[14],genReq[15]);

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




/*ack*/

module ack (ackIn, xGrant, yGrant, outputDisable, ackOut);

input [3:0] ackIn, xGrant, yGrant, outputDisable;
output [3:0] ackOut;

wire [15:0] ackTerm;

ackgen_n ackgen(ackIn, xGrant, yGrant, outputDisable, ackTerm);
ackor_n ackor_n (ackTerm, ackOut); 

endmodule


/*ackgen_n*/

module ackgen_n(ackIn, xGrant, yGrant, outputDisable, ackTerm);

input [3:0] ackIn, xGrant, yGrant, outputDisable;
output [15:0] ackTerm;

ackgen ackgen0(ackIn[0], xGrant[0], yGrant[0], outputDisable[0], ackTerm[0], ackTerm[4], ackTerm[8], ackTerm[12]);
ackgen ackgen1(ackIn[1], xGrant[1], yGrant[1], outputDisable[1], ackTerm[1], ackTerm[5], ackTerm[9], ackTerm[13]);
ackgen ackgen2(ackIn[2], xGrant[2], yGrant[2], outputDisable[2], ackTerm[2], ackTerm[6], ackTerm[10], ackTerm[14]);
ackgen ackgen3(ackIn[3], xGrant[3], yGrant[3], outputDisable[3], ackTerm[3], ackTerm[7], ackTerm[11], ackTerm[15]);

endmodule


/*ACKEN generates the ackownledgement signals for a single output port.*/

module ackgen ( ackIn, x, y,  disabled, ackTerm0, ackTerm1, ackTerm2, ackTerm3);
input x, y, ackIn, disabled;
output ackTerm0, ackTerm1, ackTerm2, ackTerm3;

wire xBar, yBar;
wire [0:3] ackTermPre;

not InvX (xBar, x);
not InvY (yBar, y);

nand NandAckTermpre0 (ackTermPre[0], xBar, yBar, ackIn);
nand NandAckTermpre1 (ackTermPre[1], xBar, y, ackIn);
nand NandAckTermpre2 (ackTermPre[2], x, yBar, ackIn);
nand NandAckTermpre3 (ackTermPre[3], x, y, ackIn);

nor NorDis1 (ackTerm0, disabled, ackTermPre[0]);
nor NorDis2 (ackTerm1, disabled, ackTermPre[1]);
nor NorDis3 (ackTerm2, disabled, ackTermPre[2]);
nor NorDis4 (ackTerm3, disabled, ackTermPre[3]);

endmodule


/* ackor_n.v*/

module ackor_n ( ackTerm, ackOut);

input [15:0] ackTerm;
output [3:0] ackOut;

ackor AckOut0( ackTerm[0],ackTerm[1],ackTerm[2],ackTerm[3], ackOut[0]);
ackor AckOut1( ackTerm[4],ackTerm[5],ackTerm[6],ackTerm[7], ackOut[1]);
ackor AckOut2( ackTerm[8],ackTerm[9],ackTerm[10],ackTerm[11], ackOut[2]);
ackor AckOut3( ackTerm[12],ackTerm[13],ackTerm[14],ackTerm[15], ackOut[3]);

endmodule

/*Ackor is a or4 gate*/
module ackor (ackTerm0,ackTerm1,ackTerm2,ackTerm3, ackOut);
input ackTerm0,ackTerm1,ackTerm2,ackTerm3;
output ackOut;

or Orack (ackOut, ackTerm0,ackTerm1, ackTerm2, ackTerm3);

endmodule



/*DATASWITCH Implementation*/

module PAUSE_DATASWITCH ( d, clock, xGrant, yGrant, outputDisable, dOut);

input [31:0] d ;
input clock;
input [3:0] xGrant, yGrant, outputDisable;

output [31:0] dOut;

wire [31:0] dPause;

XiDFFd Pause ( d, clock, dPause );

DATASWITCHC DSW0 (dPause, clock, xGrant[0], yGrant[0], outputDisable[0], dOut[0],dOut[1],dOut[2],dOut[3],dOut[4],dOut[5],dOut[6],dOut[7]);
DATASWITCHC DSW1 (dPause, clock, xGrant[1], yGrant[1], outputDisable[1], dOut[8],dOut[9],dOut[10],dOut[11],dOut[12],dOut[13],dOut[14],dOut[15] );
DATASWITCHC DSW2 (dPause, clock, xGrant[2], yGrant[2], outputDisable[2], dOut[16],dOut[17],dOut[18],dOut[19],dOut[20],dOut[21],dOut[22],dOut[23]);
DATASWITCHC DSW3 (dPause, clock, xGrant[3], yGrant[3], outputDisable[3], dOut[24],dOut[25],dOut[26],dOut[27],dOut[28],dOut[29],dOut[30],dOut[31]);

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

module DATASWITCHC ( d, clock, x, y, outputDisable, q0, q1, q2, q3, q4, q5, q6, q7 );

input [31:0] d;
input clock, x, y, outputDisable;

output q0,q1,q2,q3,q4,q5,q6,q7 ;

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

module DMUX2B4CALL( d0, d1, d2, d3, d4, d5, d6, d7,  clock, x, y, outputDisable, dOut0, dOut1);

input  d0, d1, d2, d3, d4, d5, d6, d7;
input clock, x, y, outputDisable;
output  dOut0, dOut1;
wire [1:0] q0, q1;


DMUX4T2FFC P0 ( d0, d1, d2, d3, clock, y, outputDisable, q0);
DMUX4T2FFC P1 ( d4, d5, d6, d7, clock, y, outputDisable, q1);
DMUX4T2 FB (q0, q1, x, dOut0, dOut1);

endmodule

/* The impementation of DMUX4T2 */

module  DMUX4T2 (d1, d2, x, dOut0, dOut1);
input x;
input [1:0] d1, d2;
output  dOut0, dOut1;

wire xBar;

not XiINV ( xBar, x );

assign dOut0 = (d1[0] & xBar) || (d1[1] & x),
       dOut1 = (d2[0] & xBar) || (d2[1] & x);

endmodule
/*The implement of DMUX4T2FFC*/

module DMUX4T2FFC(d0, d1, d2, d3, clock, y, outputDisable, q);
input clock, y, outputDisable;
input d0,d1,d2,d3 ;
output [1:0] q;

wire yBar;
wire [1:0] mux;

not XiINV (yBar, y);

assign mux[0]= (d0 & yBar)||(d1 & y),
       mux[1]= (d2 & yBar)||(d3 & y);

XiDFFrd BFF0 (mux[0], clock, outputDisable, q[0]);
XiDFFrd BFF1 (mux[1], clock, outputDisable, q[1]);

endmodule

/*the implement of XiDFFrd*/
module XiDFFrd(xD, xC, xRD, xQ);
input xD, xC, xRD;
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

