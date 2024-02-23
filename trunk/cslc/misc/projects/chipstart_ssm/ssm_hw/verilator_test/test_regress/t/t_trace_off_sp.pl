#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

top_filename("t/t_trace_ena.v");

compile (
	 v_flags2 => [$Self->{v3}?'-notrace -sp':''],
	 );

execute (
	 check_finished=>1,
	 );

if ($Self->{v3}) {
    !-r "$Self->{obj_dir}/simx.vcd" or $Self->error("Tracing should be off\n");
}

ok(1);
1;