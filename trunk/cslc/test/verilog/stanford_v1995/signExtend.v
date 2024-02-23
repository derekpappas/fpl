// +----------------------------------------------------------------+
// |            Copyright (c) 1994 Stanford University.             |
// |                      All Rights Reserved.                      |
// |                                                                |
// |   This software is distributed with *ABSOLUTELY NO SUPPORT*    |
// |   and *NO WARRANTY*.   Use or reproduction of this code for    |
// |   commerical gains is strictly prohibited.   Otherwise, you    |
// |   are given permission to use or modify this code as long      |
// |   as you do not remove this notice.                            |
// +----------------------------------------------------------------+
//
//  Title: 	Sign Extend Module
//  Created:	Fri May 13 16:25:36 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  signExtend.v,v 1.6 1995/01/28 00:49:06 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: 
//
//	Hierarchy: 
//
//  Revision History:
//
`include "torch.h"

module signExtend (
    dCacheBusOut_v2m,
    selByte1Pass_s2m,
    selByte1One_v2m,
    selByte1Zero_v2m,
    selByte23Pass_s2m,
    selByte23One_v2m,
    selByte23Zero_v2m,
    cacheData_v2m
    );

//
// Data input
//
input	[31:0]	dCacheBusOut_v2m;

//
// Control inputs
//
input		selByte1Pass_s2m;
input		selByte1One_v2m;
input		selByte1Zero_v2m;
input		selByte23Pass_s2m;
input		selByte23One_v2m;
input		selByte23Zero_v2m;

//
// Data output
//
output	[31:0]	cacheData_v2m;

//---------------------------------------------------------------------------
//			  --- Sign Extend ---
//---------------------------------------------------------------------------
MUX3_8	    Byte1Mux(cacheData_v2m[15:8],
			dCacheBusOut_v2m[15:8], 8'hff, 8'h00,
			selByte1Pass_s2m, selByte1One_v2m, selByte1Zero_v2m);
MUX3_8	    Byte2Mux(cacheData_v2m[23:16],
		    dCacheBusOut_v2m[23:16], 8'hff,8'h00,
		    selByte23Pass_s2m, selByte23One_v2m, selByte23Zero_v2m);
MUX3_8	    Byte3Mux(cacheData_v2m[31:24],
		    dCacheBusOut_v2m[31:24], 8'hff,8'h00,
		    selByte23Pass_s2m, selByte23One_v2m, selByte23Zero_v2m);
			
BUF_8	    LowByte(cacheData_v2m[7:0], dCacheBusOut_v2m[7:0]);

endmodule				  // signExtend
