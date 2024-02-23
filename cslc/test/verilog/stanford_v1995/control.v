/////////////////////////////////////////////////////////////////////////////

module control(phi1, phi2,
		// control signals from cache
		ExtCacheWrite_s1, ExtCacheRead_s1, ExtCacheReset_s1,
		// signals to cache
		WriteStall_s2, ReadStall_s2, ReadMatch_s2,
		// signals from bus
		BusGrant_s2, WriteDone_s1,
		// signals to bus
		BusRelease_s2, WriteMem_s1, BusRequest_s2,
		// signals from datapath
		Match_v1, ValidValue_v1,
		// control signals to datapath
		WriteTag_s1, WriteValid_s1,
		CacheWrite_s2, CacheRead_s2,
		SysBusRead_s1, SysBusRead_s2,
		HeadShiftEnable_s2, TailShiftEnable_s2,
		HeadTailReset_s2, HeadTailSelect_s1,
		// pad control signals
		CacheAddrDrv_q1, CacheDataDrvChip_q2, ChipDataDrvCache_q2);

/////////////////////////////////////////////////////////////////////////////

  input		phi1,
		phi2,
		ExtCacheWrite_s1,
		ExtCacheRead_s1,
		ExtCacheReset_s1;

  output	WriteStall_s2,
		ReadStall_s2,
		ReadMatch_s2;

  input		BusGrant_s2,
		WriteDone_s1;

  output	BusRelease_s2,
		WriteMem_s1,
		BusRequest_s2;

  input		Match_v1;

  inout		ValidValue_v1;

  output	WriteTag_s1,
		WriteValid_s1,
		CacheWrite_s2,
		CacheRead_s2,
		SysBusRead_s1,
		SysBusRead_s2,
		HeadShiftEnable_s2,
		TailShiftEnable_s2,
		HeadTailReset_s2,
		HeadTailSelect_s1;

output		CacheAddrDrv_q1, 
		CacheDataDrvChip_q2, 
		ChipDataDrvCache_q2;

/////////////////////////////////////////////////////////////////////////////

  wire		SysBusRead_s1,
		SysBusRead_s2,
		BusReset_s2,
		OKToLatch_s1;
		
/////////////////////////////////////////////////////////////////////////////

  dpcontrol	dpcontrol(phi1, phi2,
                ExtCacheWrite_s1, ExtCacheRead_s1, ExtCacheReset_s1,
                OKToLatch_s1, Match_v1,
                WriteStall_s2, ReadStall_s2, ReadMatch_s2,
                WriteTag_s1, WriteValid_s1, ValidValue_v1,
                CacheWrite_s2, CacheRead_s2,
                SysBusRead_s1, SysBusRead_s2,
		BusReset_s2,
		// right here!
		CacheAddrDrv_q1, CacheDataDrvChip_q2, ChipDataDrvCache_q2,
                HeadShiftEnable_s2, TailShiftEnable_s2,
                HeadTailReset_s2, HeadTailSelect_s1);

  buscontrol	buscontrol(phi1, phi2, 
                SysBusRead_s1, SysBusRead_s2, BusGrant_s2, WriteDone_s1, 
                BusReset_s2, BusRequest_s2, BusRelease_s2, WriteMem_s1,
                OKToLatch_s1);

endmodule
