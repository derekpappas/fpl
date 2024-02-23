#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

top_filename("t/t_assert_synth.v");

compile (
	 v_flags2 => [$Self->{v3}?'--assert':($Self->{nc}?'+assert':''),
		      '+define+FAILING_PARALLEL',],
	 );

execute (
	 check_finished=>0,
	 fails=>1,
	 expect=>
'%Error: t_assert_synth.v:\d+: Assertion failed in top.v: synthesis parallel_case'
	 );

ok(1);
1;
