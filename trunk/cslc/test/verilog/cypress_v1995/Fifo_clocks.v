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
/* Filename: Fifo.clocks.v                                                 */
/* Author: Johnie Au                                                       */
/* Release: 2002.03                                                        */
/* SCCS Path: /models/verilog/cy7c4808v25/                                 */
/* @(#)Fifo.clocks.v	1.2 03/21/02 */
/***************************************************************************/

 initial
  begin
     #tstart1 sysclk1 = 1;
     forever 
       begin 
         #(tch1+inc1) sysclk1 = ~sysclk1;
         #tcl1 sysclk1 = ~sysclk1;
         //inc1 = inc1 + 0;
       end
   end

 initial
  begin
     #tstart2 sysclk2 = 1;
     forever 
       begin 
         #(tch2+inc2) sysclk2 = ~sysclk2;
         #tcl2 sysclk2 = ~sysclk2;
         //inc2 = inc2 + 1;
       end
  end

 initial
  begin
     #(tstart1+tvpl) vplclk1 = 1;
     forever 
       begin 
         #(tch1+inc1) vplclk1 = ~vplclk1;
         #tcl1 vplclk1 = ~vplclk1;
         //inc1 = inc1 + 1;
       end
  end

 initial
  begin
     #(tstart2+tvpl) vplclk2 = 1;
     forever 
       begin 
         #(tch2+inc2) vplclk2 = ~vplclk2;
         #tcl2 vplclk2 = ~vplclk2;
         //inc2 = inc2 + 1;
       end
  end

