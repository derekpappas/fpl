#!/usr/bin/perl -w -I/opt/tools/perl_pm
###############################################################################
#
# Print out a design's hierarchy (very simple version)
#  Usage:
#   simple_hier_print.pl verilog_files...
#
# As usual there is no warranty!
#
# Costas
#
# $Header: /home/cc/v2html/rvp_scripts/RCS/simple_hier_print.pl,v 1.3 2005/12/20 15:51:20 cc Exp $
###############################################################################

require rvp;
#use strict;

use vars qw($debug @files @inc_dirs @lib_dirs $lib_ext $vdb $m );

# Parse the verilog
$vdb = rvp->read_verilog(\@ARGV,[],{},1,[],[],"");
my @problems = $vdb->get_problems();
if (@problems) {
    foreach my $problem ($vdb->get_problems()) {
	print STDERR "$problem.\n";
    }
    # die "Warnings parsing files!";
}

# find modules at the top of the hierarchy (ie have no instantiators)
#  and call hierPrint on them.
foreach $m ($vdb->get_modules()) {
    if  (! $vdb->get_first_instantiator($m)) {
	print "$m\n";
	hierPrint($vdb,1,$m);
	print "\n";
    }
}

exit 0;

sub hierPrint {
    my ($vdb,$indent,$m) = @_;
    my ($imod,$mf,$iname,$l,@subMods, @subInsts);


    # get a list of sub modules
    for (($imod,$mf,$iname,$l) = $vdb->get_first_instantiation($m );
	 $imod;
	 ($imod,$mf,$iname,$l) = $vdb->get_next_instantiation()) {
	push(@subMods,$imod);
	push(@subInsts,$iname);
    }
    
    &printCSLUnit ($imod, $iname, $subMods, $subInst);


    # recurse down hierarchy
    foreach $imod (@subMods) {
        $iname = pop(@subInsts);
        print "" . (" " x $indent x 2) . "$imod ::$iname\n";
	hierPrint($vdb,$indent+2,$imod);
    }

}

sub printCSLUnit {
    my ($imod, $iname, $subMods, $subInst) = @_;




}
