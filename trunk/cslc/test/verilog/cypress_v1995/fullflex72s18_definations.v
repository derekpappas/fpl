
//Copyright 2005, Cypress Semiconductor Corporation
/*****************************************************************************/
//This software is owned by Cypress Semiconductor Corporation (Cypress) and is
//protected by United States copyright laws and international treaty provisions.
//Cypress hereby grants to Licensee a personal, non-exclusive, non-transferable
//license to copy, use, modify, create derivative works of, and compile the
//Cypress Source Code and derivative works for the sole purpose of creating
//custom software in support of Licensee product ("Licensee Product") to be
//used only in conjunction with a Cypress integrated circuit. Any reproduction,
//modification, translation, compilation, or representation of this software
//except as specified above is prohibited without the express written permission
//of Cypress.


//Disclaimer: Cypress makes no warranty of any kind, express or implied, with
//regard to this material, including, but not limited to, the implied warranties
//of merchantability and fitness for a particular purpose. Cypress reserves the
//right to make changes without further notice to the materials described
//herein. Cypress does not assume any liability arising out of the application
//or use of any product or circuit described herein. Cypress products described
// herein are not authorized for use as components in life-support devices.
//This software is protected by and subject to worldwide patent coverage,
//including U.S. and foreign patents. Use may be limited by and subject to
//the Cypress Software License Agreement.
/*****************************************************************************/

//Source File Information Header Template
// *******************************************************************
// File           : fullflex72s18_definations.v
// Author         : 
// Author's Email :
// Date           : 23 MAR 2005 
// Revision       : 1.0
// *******************************************************************
// Description :
// This is file contains the defination for different sizes of the devices. 
// It contains  Address width, data width, last address, and byte width for 
// different address configurations 
//
// *******************************************************************

// This file contains the global definations.


`define CYP_LASTADDR_TEST 20  

  `ifdef CYDD36S72V18_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S72V18_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S72V18_133
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else	  
  `ifdef CYD36S72V18_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S72V18_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S72V18_133
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else	  
  `ifdef CYDD18S72V18_250
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S72V18_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S72V18_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else

  `ifdef CYD18S72V18_250
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S72V18_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S72V18_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
	  
  `ifdef CYDD09S72V18_250
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S72V18_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S72V18_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else

  `ifdef CYD09S72V18_250
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S72V18_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S72V18_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S72V18_250
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535 
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S72V18_200
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535 
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S72V18_167
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535 
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
    `ifdef CYDD04S72V18_200
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535 
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S72V18_167
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535 
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S72V18_133
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535 
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S36V18_200
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S36V18_167
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S36V18_133
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S18V18_200
     `define CYP_ADDRWIDTH 21
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 2097151
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S18V18_167
     `define CYP_ADDRWIDTH 21
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 2097151
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S18V18_133
     `define CYP_ADDRWIDTH 21
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 2097151
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S18V12_167
     `define CYP_ADDRWIDTH 21
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 2097151
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S18V12_133
     `define CYP_ADDRWIDTH 21
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 2097151
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S36V18_250
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S36V18_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S36V18_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S36V18_250
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S36V18_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S36V18_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S36V18_250
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S36V18_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S36V18_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071 
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S18V18_250
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S18V18_200
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S18V18_167
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S18V18_250
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S18V18_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S18V18_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S18V18_250
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S18V18_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S18V18_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S36V18_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S36V18_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S36V18_133
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S36V18_250
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S36V18_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S36V18_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S36V18_250
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S36V18_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S36V18_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S36V18_250
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S36V18_200
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S36V18_167
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S18V18_200
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S18V18_167
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S18V18_133
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S18V18_250
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S18V18_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S18V18_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S18V18_250
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S18V18_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S18V18_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S18V18_250
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S18V18_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S18V18_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
	  
  `ifdef CYDD36S72V12_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S72V12_133
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else

  `ifdef CYD36S72V12_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S72V12_133
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
	  
  `ifdef CYDD18S72V12_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S72V12_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else

  `ifdef CYD18S72V12_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S72V12_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
	  
  `ifdef CYDD09S72V12_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S72V12_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else

  `ifdef CYD09S72V12_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S72V12_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
	  
  `ifdef CYD04S72V12_200
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S72V12_167
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S72V12_167
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S72V12_133
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S36V12_167
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD36S36V12_133
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S36V12_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S36V12_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S36V12_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S36V12_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S36V12_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S36V12_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S18V12_200
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD18S18V12_167
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S18V12_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD09S18V12_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S18V12_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYD04S18V12_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 0
     `define CYP_ISSDR 1
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S36V12_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S36V12_133
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S36V12_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S36V12_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S36V12_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S36V12_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S36V12_200
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S36V12_167
     `define CYP_ADDRWIDTH 16
     `define CYP_DATAWIDTH 36
     `define CYP_LASTADDR 65535
     `define CYP_BYTEWIDTH 4
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S18V12_167
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD36S18V12_133
     `define CYP_ADDRWIDTH 20
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 1048575
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 1
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S18V12_200
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD18S18V12_167
     `define CYP_ADDRWIDTH 19
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 524287
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S18V12_200
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD09S18V12_167
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S18V12_200
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 1
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
  `ifdef CYDD04S18V12_167
     `define CYP_ADDRWIDTH 17
     `define CYP_DATAWIDTH 18
     `define CYP_LASTADDR 131071
     `define CYP_BYTEWIDTH 2
     `define CYP_ISDDR 1
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 0
     `define CYP_ISFREQ167 1
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1
  `else
     `define CYP_ADDRWIDTH 18
     `define CYP_DATAWIDTH 72
     `define CYP_LASTADDR 262143
     `define CYP_BYTEWIDTH 8
     `define CYP_ISDDR 0
     `define CYP_ISSDR 0
     `define CYP_ISFREQ200 0
     `define CYP_ISFREQ250 1
     `define CYP_ISFREQ167 0
     `define CYP_ISFREQ133 0
     `define CYP_ISFREQ100 0
     `define CYP_ISFREQ83 0
     `define CYP_ISMINDEL 0
     `define CYP_ISMAXDEL 1 
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
 `endif
module definations;
endmodule






