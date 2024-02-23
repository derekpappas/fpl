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
/* Filename: utils.v                                                       */
/* Author: Johnie Au                                                       */
/* Release: 2002.03                                                        */
/* SCCS Path: /models/verilog/cy7c4808v25/                                 */
/* @(#)Fifo.utils.v	1.2 03/21/02 */
/***************************************************************************/

 module MONITOR;

  reg monitor_on_off;

  task ON;
   begin
    monitor_on_off = 1; 
   end
  endtask

  task OFF;
   begin
    monitor_on_off = 0; 
   end
  endtask

 endmodule


 module STROBE;

  reg strobe_on_off;

  task ON;
   begin
    strobe_on_off = 1; 
   end
  endtask

  task OFF;
   begin
    strobe_on_off = 0; 
   end
  endtask

 endmodule



 module PROBE;

  reg probe_on_off;

  task ON;
   begin
    probe_on_off = 1; 
   end
  endtask

  task OFF;
   begin
    probe_on_off = 0; 
   end
  endtask

 endmodule

