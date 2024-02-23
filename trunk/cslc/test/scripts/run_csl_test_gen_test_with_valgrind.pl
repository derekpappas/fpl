#!/usr/bin/perl -w
# Change above line to point to your perl binary

use strict;
use lib "$ENV{WORK}/trunk/scripts";
use FplLib;

my $csl_test_gen_dir = "$ENV{WORK}/test/csl_test_gen";

my @cslFiles = `ls $csl_test_gen_dir`;

foreach ( @cslFiles ) {
    chop;
    print "generated test dir = $_\n";
    system ("run_regress.pl -hdl csl_test_gen -dir_filter $_ -val  2>&1 | tee $_.log");
}

