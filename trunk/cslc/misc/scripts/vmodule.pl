#!/usr/bin/perl -w -I/opt/tools/perl_pm
use rvp;   # use the rough verilog parser

# Read in all the files specified on the command line
$vdb = rvp->read_verilog(\@ARGV,[],{},1,[],[],'');

# Print out all the modules found
foreach $module ($vdb->get_modules()) { 
	print "$module\n"; 
}
