`timescale  100ps /  10ps


//
//                              CY7C1302
//                      Simulatiom of Verilog model 
//
//

//                              ds1304.v
//
//                      test bench for US vector input
//
//

//      define speed 133MHz


`define tx10 #200                //1.0 period
`define tx08 #160                //0.8 period
`define tx05 #100                //0.5 period  50MHZ
`define tx04 #80                 //0.4 period
`define tx02 #40                 //0.2 period

/*
`define tx10 #7.5               //    period
`define tx08 #6                 //0.8 period
`define tx05 #3.75              //0.5 period  133MHZ
`define tx04 #3                 //0.4 period
`define tx03 #1
`define tx02 #1.5               //0.2 period

`define tx10 #10                //    period
`define tx08 #8                 //0.8 period
`define tx05 #5                 //0.5 period  100MHZ
`define tx04 #4                 //0.4 period
`define tx02 #2                 //0.2 period

`define tx10 #12.5              //    period
`define tx08 #10                //0.8 period
`define tx05 #6.25              //0.5 period   80MHZ
`define tx04 #5                 //0.4 period
`define tx02 #2.5               //0.2 period

`define tx10 #15                //    period
`define tx08 #12                //0.8 period
`define tx05 #7.5               //0.5 period   66MHZ
`define tx04 #6                 //0.4 period
`define tx02 #3                 //0.2 period

`define tx10 #20                //    period
`define tx08 #16                //0.8 period
`define tx05 #10                //0.5 period   50MHZ
`define tx04 #8                 //0.4 period
`define tx02 #4                 //0.2 period
*/

/*
// Include

`include "metops.v"
`include "my_models.v"
`include "stdcells.v"
`include "UDP_inRstdcells.v"
*/

module rw_test;

`define num_vectors    160
`define inp {A[3:0], RPSb, WPSb , BWSb[1:0], oeB , testout[7:0], testin[7:0]}


reg     [25:1]  lsim_vectors    [1:`num_vectors];

reg     [17:0]  dIn;
wire    [17:0]  dOut;
reg     [18:0]  A;
reg     [17:0]  testin;
reg     [7:0]   testout;
reg             noti3;
reg             strb,j;
integer         vector,i;
reg CQ, CQb, K, Kb, oeB, RPSb, WPSb, zz;
reg     [1:0]   BWSb;

/*
reg [1:0] aAry , bwsB;
reg [2:0] aCol , aBlk , aRowXsb ;
reg [3:0] aRowLsb , aRowMsb ;
wire [0:100] dnu ;
reg CQ, CQb, K, Kb, oeB, RPSb, WPSb, BWS0b, BWS1b, zz;
reg ZQ , sortHiZLHS , sortHiZRHS;

// Supplies
supply1 vpwr  ;
supply1 vddq ;
supply0 vgnd  ;
supply0 vssq ;

// Description

cy1340_Chip Chip ( dOut[0], dOut[1], dOut[2], dOut[3], dOut[4],
     dOut[5], dOut[6], dOut[7], dOut[8], dOut[9], dOut[10], dOut[11],
     dOut[12], dOut[13], dOut[14], dOut[15], dOut[16], dOut[17],
     dnu[100], vgnd, vpwr, ZQ, aAry[0], aAry[1], aBlk[0], aBlk[1],
     aBlk[2], aCol[0], aCol[1], aCol[2], aRowLsb[0], aRowLsb[1],
     aRowLsb[2], aRowLsb[3], aRowMsb[0], aRowMsb[1], aRowMsb[2],
     aRowMsb[3], aRowXsb[0], aRowXsb[2], bwsB[0], bwsB[1], c, cB,
     dIn[0], dIn[1], dIn[2], dIn[3], dIn[4], dIn[5], dIn[6], dIn[7],
     dIn[8], dIn[9], dIn[10], dIn[11], dIn[12], dIn[13], dIn[14],
     dIn[15], dIn[16], dIn[17], dnu[31], dnu[32], dnu[50], k, kB, nc14,
     nc82, nc83, nc98, nc99, oeB, rpsB, sortHiZLHS, sortHiZRHS, vRef,
     vddq, vssq, wpsB, zz );
*/

cy1302 test_file ( dIn, dOut, A, K, Kb, RPSb, WPSb, BWSb[0], BWSb[1], CQ, CQb); 



//Create a dump file for the outputs
initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0,rw_test);
//  $dumpvars(0,Chip.horzSpine);
//  $dumpvars(0,Chip.right);
//  $dumpvars(0,Chip.vertSpine);
//  $dumpvars(1,Chip.plane_0_) ;
end

//Variable Initialization

initial
  begin

	strb        =        1'b0 ;
	dIn         =        18'b000000000000000000 ;
	BWSb        =        2'b00 ;
	CQ 	    =	     1'b0  ;
	CQb	    =	     1'b1 ;
	K	    =        1'b0  ;
	Kb	    =        1'b1 ;
	RPSb	    =	     1 ;
	WPSb	    =	     1 ;
	A[18:4]     =        15'b000000000000000 ; 
//vRef=1 ;
//zz=0 ;
//sortHiZRHS=0;
//sortHiZLHS=0;
//oeB=1'b0 ;
//aAry=2'b00 ;
//aCol=3'b000 ;
//aBlk=3'b000 ;
//aRowXsb=3'b000 ;
//aRowLsb=4'b0000 ;
//aRowMsb=4'b0000 ;

  end

//Initialization
initial
  begin
//`tx02 ;
	forever `tx05 strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	`tx02 ;
	forever `tx05 K =~K;
  end

initial
  begin
	`tx02 ;
	forever `tx05 Kb = ~Kb;
  end

initial
  begin
	`tx02 ;
	forever `tx05 CQ =~CQ;
  end

initial
  begin
	`tx02 ;
	forever `tx05 CQb = ~CQb;
  end

initial
 begin
 
 $readmemb("donato_vectors", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(strb)
    begin
         `inp = lsim_vectors[vector];
          dIn[17] = 0;
          dIn[8]  = 0;
          dIn[16:13] = testout[7:4];
          dIn[12:9] = testout[7:4];
          dIn[7:4] = testout[3:0];
          dIn[3:0] = testout[3:0];
    end
   #1 $finish; // This prevents simulation beyond end of test patterns
 end

always@(K)
begin
    testin[17] = 0;
    testin[8]  = 0;
    testin[16:13] = testin[7:4];
    testin[12:9] = testin[7:4];
    testin[7:4] = testin[3:0];
    if ( dOut[3:0] === testin[3:0] && dOut[7:4] === testin[7:4] )
    	$display("OUTPUT	: 001: line = %d data = %b test = %b",
         vector-1,dOut,testin);
 //   $display("NOTICE	: 002 : line = %d OK",vector -1);
    else
        $display("ERROR   *** : 003 : line = %d data = %b test = %b",vector -1,dOut,testin);

/*    begin
      j =0;
      for (i =0;i<18; i=i+1)
      begin
        if(testin !== 1'bx)
        begin
          if (dOut[i] !== testin[i]) j = 1;
        end
      end
      if (j)  
      //   else
  //  $display("NOTICE      : 000 : line = %d OK",vector -1);
  //  end
*/
end
endmodule











