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
// I've changed the way init work. Now I just simulate a reset but 
// I don't let the PC go to hyper-space. I release Reset, and still
// hold the PC to 0. After sometime I release the PC, and the machine
// is ready to run.

module init();

initial begin
force `PCU.NextPC_v1r = 0;
force `PROCESSOR.Reset_ww = 1;
// force initialization of EntryHi so PCPID is valid
force `TLBD.preEntryHi_s1w = 0;
// Uncomment to enable interrupts
force `COP0.cp0regdpath.nextStatus_s1 = 32'hff13;

#810 release `PROCESSOR.Reset_ww;
#1200 release `TLBD.preEntryHi_s1w;
#1200 release `PCU.NextPC_v1r;
// Uncomment to enable interrupts
#1200 release `COP0.cp0regdpath.nextStatus_s1;
//#5000 $stop;
//#5000 $toggle_count(system.Torch);
`ifdef VCS
//#500000 $power_report(system.Torch, 1, 0, "vcs.rep");
`else
#500000 $power_report(system.Torch, 1, 0, "cadence.rep");
`endif
end
endmodule

