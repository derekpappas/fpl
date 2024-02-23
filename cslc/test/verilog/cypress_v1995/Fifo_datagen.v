/***************************************************************************/
/* Cypress Semiconductor, Inc. Company Confidential                        */
/* Copyright 2002, Cypress Semiconductor Inc. All Rights reserved          */
/* Cypress Semiconductor proprietary source code                           */
/* Permission to use, modify or copy this code is prohibited               */
/* without the express written consent of Cypress Semiconductor Inc        */
/* 3901 North First Street,                                                */
/* San Jose, CA 95134                                                      */
/*                                                                         */
/* Description: CY7C4808V25-200                                            */
/* Filename: Fifo.datagen.v                                                */
/* Author: Johnie Au                                                       */
/* Release: 2002.03                                                        */
/* SCCS Path: /models/verilog/cy7c4808v25/                                 */
/* @(#)Fifo.datagen.v	1.2 03/21/02 */
/***************************************************************************/

module datagen( grstb, clk, dataout );

  input grstb,clk;
  output [ 79 :  0 ] dataout;
  reg    [ 79 :  0 ] dataout;

  reg    [ 83 :  0 ] pattern;
  wire   [  3 :  0 ] pat;
  reg    [  9 :  0 ] byte;
  wire   clk_d;
  reg    clk_1;

  reg    oddeven;

 /*
  parameter [83:0] user = 0;
  parameter [83:0] up   = {4'd1,80'b0};
  parameter [83:0] down = {4'd2,80'b0};
  parameter [83:0] zero = {4'd3,80'b0};
  parameter [83:0] one  = {4'd4,80'b0};
  parameter [83:0] chk  = {4'd5,80'b0};
  parameter [83:0] chkb = {4'd6,80'b0};
  parameter [83:0] abc  = {4'd7,80'b0};
 */

  initial pattern = {4'd1,80'd0}; // 4'd1 -- upcounter

  assign pat = pattern[83:80];

  always @ ( pat or pattern )
  begin 

     casex( pat )

      4'b0001: // up counter
         begin
           dataout[ 9: 0] = byte+1;
           dataout[19:10] = byte+2;
           dataout[29:20] = byte+3;
           dataout[39:30] = byte+4;
           dataout[49:40] = byte+5;
           dataout[59:50] = byte+6;
           dataout[69:60] = byte+7;
           dataout[79:70] = byte+8;
           byte = byte + 8; 
         end

      4'b0010: // down counter
         begin
           dataout[ 9: 0] = byte-1;
           dataout[19:10] = byte-2;
           dataout[29:20] = byte-3;
           dataout[39:30] = byte-4;
           dataout[49:40] = byte-5;
           dataout[59:50] = byte-6;
           dataout[69:60] = byte-7;
           dataout[79:70] = byte-8;
           byte = byte - 8; 
         end

      4'b0011: // zero
         begin
           dataout = 0;
         end

      4'b0100: // one
         begin
           dataout = {80{1'b1}};
         end

      4'b0101: //chk 
         begin
           if ( oddeven )
             dataout = {40{2'b01}};
           else
             dataout = {40{2'b10}};
         end

      4'b0110: //chkb 
         begin
           if ( oddeven )
             dataout = {40{2'b10}};
           else
             dataout = {40{2'b01}};
         end

      4'b1000: //alt
         begin
           if ( oddeven )
             dataout = {40{2'b11}};
           else
             dataout = {40{2'b00}};
         end

      4'b1001: //altb
         begin
           if ( oddeven )
             dataout = {40{2'b00}};
           else
             dataout = {40{2'b11}};
         end
      /*
           abc A 01000001
           abc B 01000010
           abc C 01000011
           abc D 01000100
           abc E 01000101
           abc F 01000110
           abc G 01000111
           abc H 01001000
       */

      4'b0111: // abc
         begin
           if ( oddeven )
             dataout = 80'b01000001_01000010_01000011_01000100_01000101_01000110_01000111_01001000; // ABCDEFGH
           else
             dataout = 80'b01000001_01000010_01000011_01000100_01000101_01000110_01000111_01001000; // ABCDEFGH
         end

      4'b0000: // user
         begin
           dataout = pattern[79:0];
         end

      default: dataout = 0;

     endcase
  end



  always @ ( posedge grstb )
  begin
    #3 clk_1 = 1;
    #3 clk_1 = 0;
  end

  assign clk_d = clk | clk_1;

  //always @ ( pattern )
  //  dataout = pattern[79:0];

  always @ ( negedge grstb or posedge clk_d )
   if ( !grstb ) 
   begin

     oddeven = 0;
     clk_1   = 0;
     dataout = 0;
     byte    = 0;
     pattern = {4'd1,80'd0}; // 4'd1 -- upcounter

     case ( pat )
      4'b0101: //chk 
           dataout = 80'b1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010;

      4'b0110: //chkb 
           dataout = 80'b0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101;
     endcase

   end else 
   begin

     #0.6
     oddeven = oddeven + 1;

     //dataout = pattern[79:0];

     casex( pat )

      4'b0001: // up counter
         begin
           dataout[ 9: 0] = byte+1;
           dataout[19:10] = byte+2;
           dataout[29:20] = byte+3;
           dataout[39:30] = byte+4;
           dataout[49:40] = byte+5;
           dataout[59:50] = byte+6;
           dataout[69:60] = byte+7;
           dataout[79:70] = byte+8;
           byte = byte + 8; 
         end

      4'b0010: // down counter
         begin
           dataout[ 9: 0] = byte-1;
           dataout[19:10] = byte-2;
           dataout[29:20] = byte-3;
           dataout[39:30] = byte-4;
           dataout[49:40] = byte-5;
           dataout[59:50] = byte-6;
           dataout[69:60] = byte-7;
           dataout[79:70] = byte-8;
           byte = byte - 8; 
         end

      4'b0011: // zero
         begin
           dataout = 0;
         end

      4'b0100: // one
         begin
           dataout = {80{1'b1}};
         end

      4'b0101: //chk 
         begin
           if ( oddeven )
             dataout = {40{2'b01}};
           else
             dataout = {40{2'b10}};
         end

      4'b0110: //chkb 
         begin
           if ( oddeven )
             dataout = {40{2'b10}};
           else
             dataout = {40{2'b01}};
         end

      4'b1000: //alt
         begin
           if ( oddeven )
             dataout = {40{2'b11}};
           else
             dataout = {40{2'b00}};
         end

      4'b1001: //altb
         begin
           if ( oddeven )
             dataout = {40{2'b00}};
           else
             dataout = {40{2'b11}};
         end
/*
abc a 01100001
abc b 01100010
abc c 01100011
abc d 01100100
abc e 01100101
abc f 01100110
abc g 01100111
abc h 01101000
*/

      4'b0111: // abc
         begin
           if ( oddeven )
             dataout = 80'b01000001_01000010_01000011_01000100_01000101_01000110_01000111_01001000; // ABCDEFGH
           else
             dataout = 80'b01000001_01000010_01000011_01000100_01000101_01000110_01000111_01001000; // ABCDEFGH
         end

      4'b0000: // user
         begin
           dataout = pattern[79:0];
         end

      default: dataout = 0;

     endcase

   end

endmodule

