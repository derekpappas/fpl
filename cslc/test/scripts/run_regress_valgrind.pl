#!/usr/bin/perl

#Author Petronela
use strict;

my @dirs = ("csl");#,"csl_v2","csl_new_bug","csl_test_gen","csl_design_gen","csl_cc_gen","csl_ar_gen","verilog");
my $dir;
foreach $dir(@dirs){
    my $cmd = "run_regress.pl -hdl $dir -val";
    system("$cmd");
}
