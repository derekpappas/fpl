#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

compile (
	 v_flags2 => ["--stats"],
	 );

if ($Self->{v3}) {
    file_grep ($Self->{stats}, qr/Optimizations, Split always\s+0/i);
}

execute (
	 check_finished=>1,
     );

ok(1);
1;
