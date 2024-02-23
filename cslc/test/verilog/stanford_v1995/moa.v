//
// Multiply Or Add Unit
// A general purpose floating unit for TORCH 
//
// Only double precision operands supported 
//
module InputMux (CK,A,B,xiz,yiz, x, y);
	input [51:0] A,B; // mantissa portions of raw operands
	input CK;

	output [51:0] x,y;
	output xiz,yiz;	// "is zero" indicators for each operand

	reg [51:0] x,y;
	reg xiz,yiz;
	//
	// latch incoming operands and perform a wired or comparison
	// at output for detection of a zero mantissa
	//
	always @(A or B)
	  begin
	     x = A;
	     y = B;
          end    
	always @(posedge CK)
	begin
	xiz = ~(|x[51:0]);	// for exception detection
        yiz = ~(|y[51:0]);
	end
endmodule

module ExpMux (CK,A_EXP,B_EXP,OP,x_exp,y_exp,op,zeros,ones);
	input [11:0] A_EXP,B_EXP;// exponent portions from raw operands
	input [3:0] OP;// operation to be performed
	input CK;

	output [11:0] x_exp,y_exp;// buffered, latched exponents
	output [3:0] op;
	output [1:0] ones,zeros;// flags for max and min exponent values

	reg [11:0] x_exp,y_exp;
	reg [11:0] a_exp,b_exp;
	reg [3:0] op;
	reg [1:0] ones,zeros;
	//
	// latch exponents and check for special exponent values
	//
	always @(A_EXP or B_EXP or OP)
	begin
             a_exp = A_EXP[11:0];	
	     b_exp = B_EXP[11:0];	
	     x_exp = a_exp;
	     y_exp = b_exp;
	     op = OP;
	end
	always @(posedge CK)
	begin
     	     zeros = {{~|a_exp[10:0]},{~|b_exp[10:0]}};
	     ones = {&a_exp[10:0],&b_exp[10:0]};
	end
endmodule

module ExpAdd (CK,A_EXP,B_EXP,add_exp,mpy_exp,mpy_sign,shift,shift_ov,
	overflow,underflow,stall,swap,{ADD,SUB,MPY});

	input [11:0] A_EXP,B_EXP;
	input CK,MPY,ADD,SUB;// which operation we are performing

	output [12:0] mpy_exp,add_exp;
	output mpy_sign,shift_ov,overflow,underflow,stall,swap;
	output [5:0] shift;

        reg [12:0] add_exp,mpy_exp,shift1,shift2;
	reg [5:0] shift;
	reg mpy_sign,a_gt_b,b_gt_a,shift_ov,overflow,underflow,stall,swap;
	//
	// This unit does the compare of the two exponents and determines
	// which is the smaller => which operand gets right shifted on an
	// add.  This shift value is then driven to exp2bsel which does
	// the conversion to booth select lines.  In actual hardware, the
	// comparison should happen in exp2bsel.
	// 
	// exceptions are also detected, both real and early versions, the
	// latter are used to drive the FPStall line.
	// 
	always @(posedge CK)
	begin
		mpy_sign = A_EXP[11] ^ B_EXP[11];
				// offset (bias) is 1023 for DP ops
                mpy_exp = A_EXP[10:0] + B_EXP[10:0] - {11'b01111111111};
		// two possible shift values
		{b_gt_a,shift1} = A_EXP - B_EXP; // gt sigs contain sign
		{a_gt_b,shift2} = B_EXP - A_EXP;
		shift=6'b0;			// default
		add_exp = A_EXP;swap = 0;	// A is smaller
		if (a_gt_b)
		begin
			shift=shift1[5:0];
			add_exp = A_EXP;
	        end else if (b_gt_a)
		begin
			shift=shift2[5:0];
			add_exp = B_EXP;
			swap = 1;	// must right shift B, not A
		end
		// if smaller operand is too small, just set sticky
		shift_ov = (b_gt_a & (shift2 > 53)) | (a_gt_b & (shift1 > 53));
		overflow=0;underflow=0;
		// detect exceptions for multiply
	  	if (MPY) begin
			if ((mpy_exp >= 2048) & ~mpy_exp[12])
			  overflow = 1;
			if (mpy_exp[12])
			  underflow = 1;
		end
		stall = 0;	// see if an exception could happen
		if ((overflow | (mpy_exp <= 1)) & MPY)
			stall = 1;
		if (((add_exp >= 11'b11111111110) & ADD) |
			((add_exp <= 53) & SUB))
			stall = 1;
	  end 
endmodule

module Exp2Bsel (CK,OV,MPY,SHIFT,onex,twox,fourx);
	input [5:0] SHIFT;
	input CK,OV,MPY;
	output [17:0]onex,twox,fourx;

	reg [17:0]onex,twox,fourx;
	reg [5:0] shift;
	//
	// convert the exponent comparison result into appropriate booth
	// select lines for right shifting of the small operand.  
	// 
	// shift amount for onex[i] = (18-i)*3-1
	// shift amount for twox[i] = (18-i)*3-2
	// shift amount for fourx[i]= (18-i)*3-3
	//
	always @(posedge CK)
	begin
	  if (~MPY)	// an ALU op
	  begin
		  fourx = 18'b0; // initialize, default if OV
		  twox = 18'b0;
		  onex = 18'b0;
		  if (~OV)
		  begin
		    // choose the Booth select which shifts the smaller operand
		    // by the amount indicated by SHIFT
		    shift = 54-SHIFT;
		    if ((shift%3)==0) fourx[(shift/3)-1]=1;
		    if (((shift+1)%3)==0) twox[(shift-2)/3]=1;
		    if (((shift-1)%3)==0) onex[(shift-1)/3]=1;
		  end
	   end else begin
		  fourx = 18'bz; // tri-state and let Booth drive them
		  twox = 18'bz;
		  onex = 18'bz;
	  end
	end 
endmodule

module ExpPipe1 (CK,ADD_EXP,MPY_EXP,ADD_SIGN,MPY_SIGN,OP,
	EXCEPTIONS,exp_out,sign,op,exceptions);

input [12:0] ADD_EXP,MPY_EXP; 
input [3:0] OP; 
input [5:0] EXCEPTIONS;
input CK,ADD_SIGN,MPY_SIGN;

output [12:0] exp_out; 
output [3:0] op; 
output [5:0] exceptions;
output sign;

reg [12:0] exp_out; 
reg [3:0] op; 
reg [5:0] exceptions;
reg sign;
	//
	// pipe exponent and control along
	// 
	always @(negedge CK) // _s1 
	begin
	#1;		// let expPipe 2 grab ouput
	if (OP[1])	// mpy
	begin
           exp_out = MPY_EXP[12:0];
	   sign = MPY_SIGN;
	end else begin
           exp_out = ADD_EXP[12:0];
	   sign = ADD_SIGN;
	end
        op = OP; 
	exceptions = EXCEPTIONS;
   end 
endmodule

module ExpPipe2 (CK,EXP_IN,SIGN,OP,EXCEPTIONS,exp_out,sign,op,exceptions);

input [12:0] EXP_IN; 
input [3:0] OP; 
input [5:0] EXCEPTIONS;
input CK,SIGN;

output [12:0] exp_out; 
output [3:0] op; 
output [5:0] exceptions;
output sign;

reg [12:0] exp_out; 
reg [3:0] op; 
reg [5:0] exceptions;
reg sign;
	//
	// pipe exponent and control along
	//
	always @(negedge CK) // _s3 
 	begin
	exp_out = EXP_IN;
	sign = SIGN;
        op = OP; 
	exceptions = EXCEPTIONS;
   end 
endmodule

module Cntl1 (CK,ZEROS,ONES,MZ,MSB,ADD_SIGN,ADD,SUB,MPY,STALL,
		denorm,iszero,isinf,isnan,add_sign,stall,unimp,invalid);

	input [1:0] ZEROS,ONES,MZ,MSB;
	input ADD,SUB,MPY,STALL;
	input CK,ADD_SIGN;

	output [1:0] denorm,iszero,isinf,isnan;
	output add_sign,stall,unimp,invalid;

	reg [1:0] denorm,iszero,isinf,isnan;
	reg add_sign,mpy,stall,unimp,invalid;
	integer i;
	//
	// check for special IEEE specified operands operands
	// and set various exception flags for later reference

	always @(posedge CK or ADD_SIGN)
	begin
           #1;
	   {unimp,invalid} = 2'b0;
	   for (i=0;i<=1;i=i+1)
	   begin
	     if (~MZ[i] & ZEROS[i]) denorm[i]=1;
	     else denorm[i]=0;
	     if (MZ[i] & ZEROS[i]) iszero[i]=1;
	     else iszero[i]=0;
	     if (MZ[i] & ONES[i]) isinf[i]=1;
	     else isinf[i]=0;
	     if (~MZ[i] & ONES[i]) isnan[i]=1;
	     else isnan[i]=0;
	     if (denorm[i] || isnan[i]) unimp = 1;
	     if (isnan[i] && MSB[i]) invalid = 1;// signalling NaN
	     if (ADD && isinf[i]) invalid = 1;
	   end
           if (MPY && ((isinf[0] & iszero[1]) | (isinf[1] & iszero[0]))) 
		invalid = 1;
	   add_sign = SUB^ADD_SIGN;	// subtract xor sign bit
	   stall = STALL;	// possible exception this flop
        end 
endmodule

module Booth (CK,MPY,Y,SIGN,zerox,onex,twox,threex,fourx,neg,y);
	input [51:0] Y;
	input SIGN,CK,MPY;
	output [17:0] zerox,onex,twox,threex,fourx,neg;
	output [53:0] y;

	reg [17:0] zerox,onex,twox,threex,fourx,neg;
	reg [53:0] y;
	reg [54:0] OP;
        reg [3:0] bits;
        reg hixor,loxor;
	//
	// Radix 8 Booth Recoder:
	// Take the Y input and recode it.
	// negate all partial products on negative SIGN.
	// Avoid doing Gary Bewicks partially redundant scheme for now
	// to save complexity although the real implementation will need
	// this method in order to make timing (can't do a full add in time)
	//
	integer i;

	always @(posedge CK)	// start on ph1 CK
	  begin
	      #1; // let Sgen latch outputs
	      if (SIGN)		// Y is negative
	      	OP = {SIGN,1'b0,~Y,1'b1};
	      else
	      	OP = {SIGN,1'b1,Y,1'b0};
	      for (i = 0; i <18; i=i+1)
	      begin
		// equations for 3 bit booth recoding
		bits = {OP[3*i+3],OP[3*i+2],OP[3*i+1],OP[3*i]};
		hixor = bits[3] ^ bits[2];
		loxor = bits[1] ^ bits[0];
	        zerox[i] = &bits[3:0] | &(~bits[3:0]);
	        neg[i] = bits[3] & ~zerox[i]; 	// don't negate a zero
	        onex[i] = ~hixor & loxor;
	        twox[i] = ((~bits[0] & ~bits[1]) & bits[2]) |
			  ((bits[0] & bits[1]) & ~bits[2]);
		threex[i] = hixor & loxor;
		fourx[i] = (&bits[2:0] & ~bits[3]) | (&(~bits[2:0]) & bits[3]);
	      end
	      if (~MPY)	// we are doing an add
	      begin
		y = OP[54:1];	// put the addend into the PP array
		zerox=18'b0;	
		neg = 18'b0;
		threex = 18'b0;
		onex = 18'bz;	// tri-state selects and let exp2bsel drive
		twox = 18'bz;
		fourx = 18'bz;
	      end else
		y = 54'b0;	// don't add anything if mpy
		
	  end 
endmodule

module Mgen (CK,X,Y,ADD,SWAP,x,x3);
	input [51:0] X;
	input [53:0] Y;
	input CK,ADD,SWAP;

	output [53:0] x;
	output [54:0] x3;

	reg [53:0] x,x2;
	reg [54:0] x3;
	//
	// Generate threex multiple of x for partial product summation
	// I will not implement the Bewick scheme of partially redundant
	// multiples yet for simplicity's sake
	//
	always @(posedge CK or X or SWAP)
	  begin
	      x = {2'b01,X};
              if (ADD & SWAP) 	// listen to exponent compare and exchange
		      x = Y;	// operands if Y is smaller
	      x2 = x << 1;
 	      x3 = x2 + x; 	// x + 2*x = 3*x
	  end 
endmodule

module PPSum (CK,Y,X,X3,NEG,ZEROX,ONEX,TWOX,THREEX,FOURX,MPY,
		  cout,sout,p0,p1,ls,lc); 
input CK,MPY; 
input [17:0] FOURX,THREEX,TWOX,ONEX,ZEROX,NEG; 
input [53:0] X,Y; 
input [54:0] X3;

output [58:0] cout,sout;
output [44:0] ls;
output [29:0] lc;
output [5:0]p0;
output [2:0]p1;

reg [55:0]CARRY,SUM,PP,PP0,PP1,PP2,sum,carry;
reg [58:0]cout,sout;
reg [5:0]p0;
reg [2:0]p1;
reg [44:0]ls;
reg [29:0]lc;
	//
	// sum up 18 partial products and the addend using the booth-3
	// select lines and multiples.
	//
integer i,j;

   // Sum function of CSA
   function [55:0] csa_sum;
     input [55:0] a, b, c;
     begin
       csa_sum = a ^ b ^c;
     end
   endfunction
   // Carry function of CSA
   function [55:0] csa_carry;
     input [55:0] a, b, c;
     begin
       csa_carry = (a&b) | (a&c) | (b&c);
     end
   endfunction
   function [55:0] booth;
     input [53:0] x;
     input [54:0] x3;
     input zerox, onex, twox, threex, fourx, neg;
     begin
       booth = {56'b0};	// zerox is the default
       if (onex) booth = {2'b0,x};
       if (twox) booth = {1'b0,x,1'b0};
       if (fourx) booth = {x,{2'b0}};
       if (threex) booth = {1'b0,x3};
       if (neg) booth = ~booth;
     end
   endfunction

   always @(negedge CK)		// evaluate on ph2 of EX
   begin
      #1;	// let adders catch outputs
      PP0 = booth(X,X3,ZEROX[0],ONEX[0],TWOX[0],THREEX[0],FOURX[0],NEG[0]);
      PP1 = booth(X,X3,ZEROX[1],ONEX[1],TWOX[1],THREEX[1],FOURX[1],NEG[1]);
      PP2 = booth(X,X3,ZEROX[2],ONEX[2],TWOX[2],THREEX[2],FOURX[2],NEG[2]);
      CARRY = csa_carry({{6{PP0[55]}},PP0[55:6]},	// first 3 PP's sum
		   {{3{PP1[55]}},PP1[55:3]},
		   PP2[55:0]);
      SUM = csa_sum({{6{PP0[55]}},PP0[55:6]},
		   {{3{PP1[55]}},PP1[55:3]},
		   PP2[55:0]);

     // ignore the even/odd structure for this model
	for (i=3;i<18;i=i+1) 				// remaining 15
	begin
	  PP={booth(X,X3,ZEROX[i],ONEX[i],TWOX[i],THREEX[i],FOURX[i],NEG[i])};
	   // dump off LSB's
	   lc[2*i-6] = CARRY[0];
	   lc[2*i-5] = CARRY[1];
	   ls[3*i-9] = SUM[0];
	   ls[3*i-8] = SUM[1];
	   ls[3*i-7] = SUM[2];
	   // 3:2 reduction
           sum = SUM;carry = CARRY;
	   CARRY = csa_carry({{3{sum[55]}},sum[55:3]},
			{{2{carry[55]}},carry[55:2]},
			PP[55:0]);
	   SUM = csa_sum({{3{sum[55]}},sum[55:3]},
			{{2{carry[55]}},carry[55:2]},
			PP[55:0]);
	 end
	 // now combine results with addend
	 // note: the MPY value is for rounding purposes
	 sout = csa_sum(SUM[55:0],{CARRY[54:0],MPY},{Y[53],Y[53],Y[53:0]});
	 cout = csa_carry(SUM[55:0],{CARRY[54:0],MPY},{Y[53],Y[53],Y[53:0]});
	 p0 = PP0[5:0];
	 p1 = PP1[2:0];
   end 
endmodule

module Sgen (CK,LS,LC,NEG,P0,P1,cout,sticky,guard);
	input CK;
	input [44:0] LS;
	input [29:0] LC;
	input [17:0] NEG;
	input [5:0] P0;
	input [2:0] P1;

	output cout,guard,sticky;

	reg cout,sticky,guard;
	reg [50:0] sum,A,B,P,G;
	reg [51:0] carry;
	reg [17:0] neg;
	integer i;
	//
	// assimilate the mpy array lsb's and generate sticky, carry out
	//
    always @(posedge CK)
	neg = NEG;	// latch
    always @(negedge CK)	// evaluate ph2
     begin
	// pack LSBs together for carry propagation
	// the neg's are in here to accomplish the 2's complement when 
	// negating multiples in the array
	//
	A ={LS[44:0],P1[2:0],{3{neg[1]}}};
	B ={LC[29],LC[28],neg[16],LC[27],LC[26],neg[15],
	    LC[25],LC[24],neg[14],LC[23],LC[22],neg[13],
	    LC[21],LC[20],neg[12],LC[19],LC[18],neg[11],
	    LC[17],LC[16],neg[10],LC[15],LC[14],neg[9],
	    LC[13],LC[12],neg[8],LC[11],LC[10],neg[7],
	    LC[9],LC[8],neg[6],LC[7],LC[6],neg[5],
	    LC[5],LC[4],neg[4],LC[3],LC[2],neg[3],
	    LC[1],LC[0],neg[2],P0[5:0]};
	carry[0] =neg[0];
	P = A ^ B;	// propagate and generate terms
	G = A & B;
	// propagate carry for sticky and carry into adder
	for (i=0; i<51; i=i+1)
	begin
	   carry[i+1] = (P[i] & carry[i]) | G[i];
	end
	sum = carry[50:0] ^ P;
	cout = carry[51];
	sticky = |sum[49:0];
	guard = sum[50];
    end endmodule

module CselAdd (CK,SUM,CARRY,STICKY,CIN,GUARD,MPY,
		carry0,carry1,prop,select,inexact,ov);
	input [58:0] SUM,CARRY;
	input CK,CIN,STICKY,GUARD,MPY;

	output [57:0] prop,carry0,carry1;
	output select,inexact,ov;

	reg [56:0] sum;
	reg [57:0] carry0,carry1;
	reg [57:0] prop,gen,A,B;
	reg ov,select,sign,lsb,two_comp,add,inexact;
	integer i;
	//
	// simple emulation of a carry propagate.
	// with IEEE round to nearest logic 
	// generate two carry outputs, one with +1 assumed and one +0
	//
    always @(negedge CK or STICKY or GUARD or CIN)
    begin
	// pack in inputs to CSA row
	A = SUM[57:0]; // significance sign,109 -> 51
	B = {CARRY[56:0],CIN}; // significance 109 -> 52,cin
	prop = A ^ B;
	gen = A & B;
	carry0[0]=1'b0;	// +0
	carry1[0]=1'b1;	// for +1 rounding case
	for (i=0; i<57; i=i+1)
	begin
	   carry0[i+1] = (prop[i] & carry0[i]) | gen[i];
	   carry1[i+1] = (prop[i] & carry1[i]) | gen[i];
	end
	sign = carry0[55] ^ prop[55];	// sign 
	ov = carry0[54] ^ prop[54] ^ sign; // mpy res > .5 => right shift 1
	lsb = prop[0];			// LSB with no carry in
	// take a shot at rounding
	two_comp = sign & ~STICKY;	// does the 2's complement lsb 
					// addition make to the guard position?
	add = (GUARD&~MPY) | ov;
	if (MPY)	// the round bit has already been stuffed in for MPY
		select = (ov | two_comp) & (STICKY | lsb);
	else		// round to nearest logic w/ 2's complement 
		select = ((add | two_comp) & (STICKY | lsb))|(add & two_comp);
	inexact = add | two_comp | STICKY; // flag if rounding occurred
	if (sign) prop = ~prop;	// one's complement if negative
   end 
endmodule

module LOP (CK,SUM,CARRY,MPY,
		shift_val,pstate,kstate,gstate,shift);
	input [58:0] SUM,CARRY;
	input CK,MPY;

	output [4:0] shift;
	output [56:0] pstate,gstate,kstate;
	output [56:0] shift_val;

	reg [56:0] pstate,kstate,gstate;
	reg [56:0] shift_val;
	reg [58:0] prop,gen,kill;
	reg [4:0] shift;

	integer i;
	//
	// emulation of a leading one predictor based on IBM's RS6000 
	// algorithm, as detailed their Journal of R&D
	//
	// output is decoded into binary for the shifter
	//
     always @(negedge CK)
     begin
	prop = SUM ^ CARRY;
	gen = SUM & CARRY;
	kill = ~SUM & ~CARRY;
	shift_val[56]=0;
	// keep track of which state I'm in
	pstate[56]=1;kstate[56]=1;gstate[56]=1;
	for (i=55; i>=0; i=i-1)
	begin
	   pstate[i] = prop[i+1]&pstate[i+1];
	   kstate[i] = kill[i+1]&kstate[i+1] | pstate[i+1]&gen[i+1];
	   gstate[i] = gen[i+1]&gstate[i+1] | pstate[i+1]&kill[i+1];
	   shift_val[i] = pstate[i] | kstate[i] | gstate[i];
	end
        shift=5'b0;
	// now decode the shift string
	shift[4] = shift_val[24];
	shift[3] = shift_val[8] | shift_val[40]&~shift_val[24];
	for (i=48;i>=16;i=i-16)
		shift[2] = (shift_val[i] & ~shift_val[i-8]) |shift[2];
	for (i=52;i>=4;i=i-8)
		shift[1] = (shift_val[i] & ~shift_val[i-4]) |shift[1];
	for (i=54;i>=6;i=i-4)
		shift[0] = (shift_val[i] & ~shift_val[i-2]) |shift[0];
	shift[0] = shift[0] | shift_val[1];	// last position
	if (MPY) shift = 5'b0;	// don't shift on a multiply
    end endmodule

module Sfinal (CK,CARRY0,CARRY1,PSTATE,GSTATE,KSTATE,SHIFT,SELECT,MPY,
	shiftl1,shiftr1);

	input CK,SELECT,MPY;
	input [57:0] CARRY0,CARRY1;
	input [56:0] PSTATE,GSTATE,KSTATE,SHIFT;

	output shiftl1,shiftr1;

	reg shiftl1,shiftr1;
	reg [57:0] carry;
	reg [56:0] ad;
	integer i;
	//
	// generate final stage of shift (0,-1) based on LOP coarse
	// result and the carry selected from rounding.  
	//
	always @(posedge CK)	// ph1 evaluate 
	begin
	  if (SELECT) carry = CARRY1;	// get carry based on round result
	  else carry = CARRY0;
	  for (i=55; i>=0;i=i-1)
	  begin
		// adjust term
	    ad[i] = GSTATE[i]&~carry[i+1] | KSTATE[i]&carry[i+1];
	  end
	  ad[56]=1'b0;shiftl1=0;shiftr1=0;
	  for (i=55;i>=3;i=i-2)
	  begin
		shiftl1 = (SHIFT[i] & ~SHIFT[i-1] & ~ad[i]) | shiftl1;
		shiftr1 = (~SHIFT[i-2] & SHIFT[i-1] & ad[i-1]) | shiftr1;
	  end
	  shiftl1 = shiftl1 | SHIFT[0]&~ad[0];	// last position
	  if (MPY) // don't shift on a mpy
	  begin
		  shiftl1=0;shiftr1=0;
	  end
	end
endmodule

module AddSel (CK,PROP,CARRY0,CARRY1,SELECT,OV,sum);
	input [57:0] PROP,CARRY0,CARRY1;
	input CK,SELECT,OV;

	output [54:0] sum;

	reg [54:0] sum;
	reg [55:0] isum;
	// 
	// select from +1/+0 addition result based on the rounding
	// SELECT line.
	// Also perform a one bit right shift if the mpy result > .5 (OV)
	// 
	always @(posedge CK)	// ph1 evaluation
	begin
	  if (SELECT) isum = CARRY1[55:0] ^ PROP[55:0];
	  else isum = CARRY0[55:0] ^ PROP[55:0];
	  if (OV) 	// mpy result > .5 => normalize
	    sum = isum[55:1];
  	  else sum = isum[54:0];
	end
endmodule

module PostNormalize (CK,SHIFT,SHIFTL1,SHIFTR1,SUM,
		result);
	input [4:0] SHIFT;
	input CK,SHIFTR1,SHIFTL1;
	input [54:0] SUM;

	output [51:0] result;

	reg [51:0] result;
	reg [4:0] shift;
	reg [54:0] shift_val;

	integer i,shift_amt;
	//
	// final left shift of mpy/add result for normalization
	//
	// wait for sum select and fine shift amounts
     always @(posedge CK or SUM or SHIFTL1 or SHIFTR1)
     begin
	   shift_val = SUM;
	   shift_amt = 2;
		// shift amount is in binary
	   for (i=0; i<5; i=i+1)
	   begin
	      if (SHIFT[i]) 
		 shift_val = shift_val << shift_amt;
	      shift_amt = shift_amt*2;
	   end
	   if (SHIFTL1)	// left by one
		shift_val = shift_val << 1;
	   if (SHIFTR1)	// right by one
		shift_val = shift_val >> 1;
	   result = shift_val[52:1];
     end
endmodule

module Drive (CK,ZERO,NaN,RESULT,result);
	input [51:0] RESULT;
	input CK,ZERO,NaN;

	output [51:0] result;

	reg [51:0] result;
	//
	// Mux special result values and drive on result bus
	//
    always @(negedge CK)	// drive on ph2
	begin
	  if (NaN) 	result = {1'b1,51'b0};// signalling NaN
	  else
	  if (ZERO)	result = 52'b0;
	  else 		result = RESULT;	
	end
endmodule

module ExpSubtract (CK,EXP_IN,SIGN,SHIFT,SHIFTR1,SHIFTL1,EXCEPTIONS,INEXACT,OV,
  zero,exceptions,exp_out,sign);

input [12:0] EXP_IN;
input CK,SHIFTL1,SHIFTR1,SIGN,INEXACT,OV;
input [4:0] SHIFT;
input [5:0] EXCEPTIONS;

output [10:0] exp_out;
output zero,sign;
output [5:0] exceptions;

reg [10:0] exp_out;
reg [12:0] exp;
reg zero,ov,uf,sign,inexact;
reg [5:0] esub,exceptions;
	//
	// adjust exponent based on post normalize amount and check for 
	// exceptions based on exponent and previous detection.
        // ph1 evaluate (normalization phase)
	//
always @(posedge CK or SHIFTR1 or SHIFTL1) 
begin
  esub = (2*SHIFT[4:0]) + SHIFTL1 - SHIFTR1 + OV; //amount to subtract
  exp = EXP_IN - esub;	// could be positive, OV from MPY or SHIFTR1 from Add
  sign = SIGN;
  zero = 0;ov = 0;uf = 0;// defaults
if (exp[12] || EXCEPTIONS[1]) // negative exponent or previous underflow
begin
  exp_out = 11'b0;
  zero = 1;uf = 1;
end else exp_out = exp[10:0];
// overflow detection
if (~uf && (exp >= 11'b11111111111 || EXCEPTIONS[2]))
begin
	exp_out = 11'b11111111111;
	zero = 1;
	ov = 1;
end
if (|EXCEPTIONS[5:4])// unimplemented or invalid operation => NaN
begin
	zero =1;	
	exp_out = 11'b11111111111;
end
inexact = INEXACT;
if (ov==1) inexact = 1;
exceptions = {EXCEPTIONS[5:3],ov,uf,inexact};
end
endmodule

module ExpDrive (CK,EXP_IN,SIGN,sign,exp_result);
input [10:0] EXP_IN;
input CK,SIGN;

output [10:0] exp_result;
output sign;

reg [10:0] exp_result;
reg sign;
//
//	drive exponent to bypass mux
//
always @(negedge CK)
begin
  exp_result = EXP_IN;
  sign = SIGN;
end
endmodule

module CKBuffer (Phi1,STALL,CK);

input Phi1,STALL;
output CK;
reg CK;
// buffer clock with stall capability
always @(Phi1)
begin
   if (STALL == 1'b0) CK = Phi1;
end
endmodule

//
module MOAUnit(
    	Phi1	 ,
    	Phi2	,
    	IStall_s1  	,
    	MemStall_s2	,
    	fpOpIsAdd_s1e	,
    	fpOpIsSub_s1e	,
    	fpOpIsMul_s1e	,
    	fpOpIsDiv_s1e	,
    	fpOpIsAbs_s1e	,
    	fpOpIsMov_s1e	,
    	fpOpIsNeg_s1e	,
    	fpOpIsCmp_s1e	,
    	fpOpIsSingle_s1e   	,
    	fpOpIsDouble_s1e   	,
    	fpOpIsFixed_s1e    	,
    	fsBus_s1e  	,
    	ftBus_s1e  	,
    	resultBus_v2w	,
	FPStall_s1w,
	FPExceptions_v2w
    	);

input  	Phi1	 ,
    	Phi2	,
    	IStall_s1  	,
    	MemStall_s2	,
    	fpOpIsAdd_s1e	,
    	fpOpIsSub_s1e	,
    	fpOpIsMul_s1e	,
    	fpOpIsDiv_s1e	,
    	fpOpIsAbs_s1e	,
    	fpOpIsMov_s1e	,
    	fpOpIsNeg_s1e	,
    	fpOpIsCmp_s1e	,
    	fpOpIsSingle_s1e   	,
    	fpOpIsDouble_s1e   	,
    	fpOpIsFixed_s1e;
input [63:0] fsBus_s1e,ftBus_s1e;

output [63:0] resultBus_v2w;
output FPStall_s1w;
output [5:0] FPExceptions_v2w;

wire ck;
// exponent stuff
wire xiz_s1,yiz_s1,add_s1,sub_s1,mul_s1,cmp_s1;
wire [51:0] x_s1,y_s1;
wire [11:0] x_exp_s1,y_exp_s1;
wire [12:0] exp_s3,exp_s5;
wire [1:0] zeros_s1,ones_s1;
wire [12:0] add_exp_s2,mpy_exp_s2;
wire mpy_sign_s2,big_shift_s2,sign_s3,sign_s5;
wire [5:0] shift_s2;
wire [17:0] zerox_s2,onex_s2,twox_s2,threex_s2,fourx_s2,neg_s2;
wire [3:0] op_s3,op_s5;
wire zero_s6,inf_s6,ov_s6,uf_s6,sign_s6,add_sign_s2;
wire overflow_s2,underflow_s2,stall_s2,swap_s2;
wire [5:0] exceptions_s3,exceptions_s5;
wire [10:0] exp_s6;
// control outputs
wire [1:0] denorm_s2,iszero_s2,isinf_s2,isnan_s2;
wire [53:0] addend_s2,x_s2;
wire invalid_s2,unimp_s2;
// 3x multiple
wire [54:0] x3_s2;
// multiplier array outputs
wire [58:0] cout_s3,sout_s3;
wire [5:0] p0_s3;
wire [2:0] p1_s3;
wire [44:0] ls_s3;
wire [29:0] lc_s3;
// final add
wire cout_s5,sticky_s5,guard_s5,sumselect_s5,inexact_s5,ov_s5;
wire [57:0] carry0_s5,carry1_s5,prop_s5;
// lop
wire [56:0] shiftval_s5,pstate_s5,kstate_s5,gstate_s5;
wire [4:0] shift_s5;
wire shiftr1_s6,shiftl1_s6;
// final phase
wire [54:0] sum_s6;
wire [51:0] shiftresult_s6;
//
// multiply or add unit
// 
// perform ieee compliant operations on double precision operands with 
// three cycle invariant latency and a minimum of hardware.
// currently supports the following operations:
//	multiply
// 	add
//	sub
//

InputMux InputMux(CK,fsBus_s1e[51:0],ftBus_s1e[51:0],xiz_s1,yiz_s1,x_s1,y_s1);

ExpMux ExpMux (CK,fsBus_s1e[63:52],ftBus_s1e[63:52],
	{fpOpIsAdd_s1e,fpOpIsSub_s1e,fpOpIsMul_s1e,fpOpIsCmp_s1e},
	x_exp_s1,y_exp_s1,{add_s1,sub_s1,mul_s1,cmp_s1},zeros_s1,ones_s1);

ExpAdd ExpAdd(CK,x_exp_s1,y_exp_s1,add_exp_s2,mpy_exp_s2,mpy_sign_s2,
	shift_s2,big_shift_s2,overflow_s2,underflow_s2,stall_s2,swap_s2,
	{add_s1,sub_s1,mul_s1});

Exp2Bsel Exp2Bsel(CK,big_shift_s2,mul_s1,shift_s2,onex_s2,twox_s2,fourx_s2);

ExpPipe1 ExpPipe1(CK,add_exp_s2,mpy_exp_s2,ftBus_s1e[63],mpy_sign_s2,
	{add_s1,sub_s1,mul_s1,cmp_s1},{unimp_s2,invalid_s2,1'b0,overflow_s2,
	underflow_s2,1'b0},exp_s3,sign_s3,op_s3,exceptions_s3);

ExpPipe2 ExpPipe2(CK,exp_s3,sign_s3,op_s3,exceptions_s3,exp_s5,sign_s5,op_s5,
	exceptions_s5);

ExpSubtract ExpSubtract(CK,exp_s5,sign_s5,shift_s5,shiftr1_s6,shiftl1_s6,
	exceptions_s5,inexact_s5,ov_s5,zero_s6,FPExceptions_v2w,exp_s6,
	sign_s6);

ExpDrive ExpDrive(CK,exp_s6,sign_s6,resultBus_v2w[63],resultBus_v2w[62:52]);

CKBuffer CKBuffer (Phi1,IStall_s1,CK);

Cntl1 Cntl1(CK,zeros_s1,ones_s1,{xiz_s1,yiz_s1},{ftBus_s1e[51],fsBus_s1e[51]},
	ftBus_s1e[63],add_s1,sub_s1,mul_s1,stall_s2,denorm_s2,iszero_s2,
	isinf_s2,isnan_s2,add_sign_s2,FPStall_s1w,unimp_s2,invalid_s2);

Booth Booth(CK,mul_s1,y_s1,mpy_sign_s2,zerox_s2,onex_s2,twox_s2,
	threex_s2,fourx_s2,neg_s2,addend_s2);

Mgen Mgen(CK,x_s1,addend_s2,add_s1,swap_s2,x_s2,x3_s2);

PPSum PPSum(CK,addend_s2,x_s2,x3_s2,neg_s2,zerox_s2,onex_s2,twox_s2,threex_s2,
	fourx_s2,op_s3[1],cout_s3,sout_s3,p0_s3,p1_s3,ls_s3,lc_s3);

Sgen Sgen(CK,ls_s3,lc_s3,neg_s2,p0_s3,p1_s3,cout_s5,sticky_s5,guard_s5);

CselAdd CselAdd(CK,sout_s3,cout_s3,sticky_s5,cout_s5,guard_s5,op_s3[1],
	carry0_s5,carry1_s5,prop_s5,sumselect_s5,inexact_s5,ov_s5);

LOP LOP(CK,sout_s3,cout_s3,op_s3[1],
	shiftval_s5,pstate_s5,kstate_s5,gstate_s5,
	shift_s5);

Sfinal Sfinal(CK,carry0_s5,carry1_s5,pstate_s5,gstate_s5,kstate_s5,
	shiftval_s5,sumselect_s5,op_s5[1],shiftl1_s6,shiftr1_s6);

AddSel AddSel(CK,prop_s5,carry0_s5,carry1_s5,sumselect_s5,ov_s5,sum_s6);

PostNormalize PostNormalize(CK,shift_s5,shiftl1_s6,shiftr1_s6,sum_s6,
	shiftresult_s6);

Drive Drive(CK,zero_s6,1'b0,shiftresult_s6,resultBus_v2w[51:0]);

endmodule
