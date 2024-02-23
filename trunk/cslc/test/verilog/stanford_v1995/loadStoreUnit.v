//
//  Title: 	Load Store Unit
//  Created:	Fri May 13 15:24:49 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  loadStoreUnit.v,v 1.3 1995/01/28 00:49:03 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: Logic for load Store Unit that sits on the main 
//		     integer datapath.
//
//	Hierarchy: 
//
//  Revision History:
//
`include "torch.h"

module loadStoreUnit (
    Phi1,
    Phi2,
    Psi1_q1,
    Alpha_q2,
    Beta_q2,
    AbufSel_s1,
    BbufSel_s1,
    selAstore_s1,
    selAstore_b_s1,
    selByte1Pass_s2m,
    selByte1One_v2m,
    selByte1Zero_s2m,
    selByte23Pass_s2m,
    selByte23One_v2m,
    selByte23Zero_s2m,
    drvMemBusCD_q2m,
    drvMemBusSMD_q2m,
    drvNonCache_q2m,
    BResultBus_v2e,
    BTBus_s1e,
    dCacheBusOut_v2m,
    storeData_s1,
    MemBus_v2m,
    BResultBus_s1m,
    SharedMemData_s2
    );

//
// Clocks & Stalls
//
input		Phi1;
input		Phi2;
input		Psi1_q1;
input	[3:0]	Alpha_q2;		  // Clock for A store buffer
input	[3:0]	Beta_q2;		  // Clock for B store buffer

//
// Control inputs
//
input	[3:0]	AbufSel_s1;		  // Select one entry from A buffer
input	[3:0]	BbufSel_s1;		  // Select one entry from B buffer
input		selAstore_s1;	  // Use data from A for next store
input		selAstore_b_s1;
input		selByte1Pass_s2m;	  // Pass byte as-is
input		selByte1One_v2m;	  // Sign extend to be all 1s
input		selByte1Zero_s2m;	  // Sign extend to be all 0s
input		selByte23Pass_s2m;
input		selByte23One_v2m;
input		selByte23Zero_s2m;
input		drvMemBusCD_q2m;	  // drv memBus w/ data from cache
input		drvMemBusSMD_q2m;	  // drv MemBus w/ non-$-able data
input		drvNonCache_q2m;	  // drv store data from non-$-able

//
// Bus inputs
//
input	[31:0]	BResultBus_v2e;		  // Store address
input	[31:0]	BTBus_s1e;		  // Store data
input	[31:0]	dCacheBusOut_v2m;	  // Sign extend and drive on MemBus
input	[31:0]	SharedMemData_s2;

//
// Bus outputs
//
output	[31:0]	storeData_s1;		  // Store data to dCache
output	[31:0]	MemBus_v2m;		  // Rerturn load data to datapath
output	[31:0]	BResultBus_s1m;		  // Store Address for conflict comp

//
// Local Wires
//
wire	[31:0]	cacheData_v2m;
wire	[31:0]	storeData_s2e;
wire	[31:0]	storeData_s1m;
wire	[31:0]	storeData_s2m;
wire	[31:0]	storeData_s1w;

//---------------------------------------------------------------------------
//			   --- Store Data ---
//---------------------------------------------------------------------------
PHI1_LATCH_32	StoreData_S2E(storeData_s2e, BTBus_s1e, Psi1_q1);
PHI2_LATCH_32	StoreData_S1M(storeData_s1m, storeData_s2e, Phi2);
PHI1_LATCH_32	StoreData_S2M(storeData_s2m, storeData_s1m, Psi1_q1);
PHI2_LATCH_32	StoreData_S1W(storeData_s1w, storeData_s2m, Phi2);

//---------------------------------------------------------------------------
//			  --- Store Buffer ---
//---------------------------------------------------------------------------
storeBufferData storeBufferData (
	.Psi1_q1		(Psi1_q1),
	.Alpha_q2		(Alpha_q2),
	.Beta_q2		(Beta_q2),
	.AbufSel_s1		(AbufSel_s1),
	.BbufSel_s1		(BbufSel_s1),
	.selAstore_s1		(selAstore_s1),
	.selAstore_b_s1		(selAstore_b_s1),
	.storeData_s1w		(storeData_s1w),
	.storeData_s1		(storeData_s1)
    );

//---------------------------------------------------------------------------
//			     --- MemBus ---
//---------------------------------------------------------------------------
signExtend signExtend (
	.dCacheBusOut_v2m	(dCacheBusOut_v2m[31:8]),
	.selByte1Pass_s2m	(selByte1Pass_s2m),
	.selByte1One_v2m	(selByte1One_v2m),
	.selByte1Zero_s2m	(selByte1Zero_s2m),	
	.selByte23Pass_s2m	(selByte23Pass_s2m),
	.selByte23One_v2m	(selByte23One_v2m),
	.selByte23Zero_s2m	(selByte23Zero_s2m),
	.cacheData_v2m		(cacheData_v2m[31:8])
    );
TRIBUF_32	MemBus1(MemBus_v2m,
			{cacheData_v2m[31:8], dCacheBusOut_v2m[7:0]},
			drvMemBusCD_q2m);

//---------------------------------------------------------------------------
//			 --- Non Cacheable ---
//---------------------------------------------------------------------------
TRIBUF_32	SharedMemData(SharedMemData_s2[31:0], storeData_s2m,
			drvNonCache_q2m);
TRIBUF_32	MemBus2(MemBus_v2m, SharedMemData_s2, drvMemBusSMD_q2m);

endmodule				  // loadStoreUnit
