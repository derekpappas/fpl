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
use Switch;
use vars qw($debug @files @inc_dirs @lib_dirs $lib_ext $vdata $m );

# Parse the verilog
$vdata = rvp->read_verilog(\@ARGV,[],{},1,[],[],"");
my @problems = $vdata->get_problems();
if (@problems) {
    foreach my $problem ($vdata->get_problems()) {
	print STDERR "$problem.\n";
    }
    # die "Warnings parsing files!";
}

my %instanceTree;
my %unitHash;
my %instanceTreeF2As;
my %portNames;

my $fileName = "mitch_complete.csl";
open my $FILE, ">", $fileName or die $!;
print $FILE "// auto generated Mitch CSL code\n";
close $FILE;

# find modules at the top of the hierarchy (ie have no instantiators)
#  and call hierPrint on them.
foreach $m (sort $vdata->get_modules()) {
    if  (! $vdata->get_first_instantiator($m)) {
	#print "$m\n";
        #print "0 fileName = $fileName\n";
	hierPrint($vdata, 1, $m, "", $fileName);
	#print "\n";
    }
}

foreach $signal (sort keys %portNames) {
  print "$signal:\n";
  my @connectionList = @{$portNames{$signal}};
  foreach $connection ( @connectionList) {
      foreach $element ( @{$connection}) {
          print "  $element\t";              
      }
      print "\n";
  }
  print "\n\n";
}

my %interfaceList;
foreach $instName (sort keys %instanceTreeF2As) {
    my @f2aList = @{$instanceTreeF2As{$instName}};
    print "InstName = $instName\n";
    my $lastWordPrefix = "";
    my $matchPrefix    = "";

# find the prefix sets in the SORTED f2a lists
    foreach $f2aMapping ( @f2aList) {
        my @f2a = @{$f2aMapping};
        foreach $name ( @f2a) {
            print " $name \t";              
        }   
        print "\n";
        my $formalName = $f2a[0];

        if ($formalName =~ /([^_]+)_/) { # get the first word before the first '_'
            my $prefix = $1;
#            chop $prefix;
            if ($lastWordPrefix eq $prefix) {
                $matchPrefix = $prefix;
            }
            else {
                $matchPrefix = "";
            }
            print "formal prefix matching        formalName = $formalName\n        prefix = $prefix\nlastWordPrefix = $lastWordPrefix\n   matchPrefix = $matchPrefix\n\n";
            $lastWordPrefix = $prefix;
        }
    }
    print "\n\n";
}

foreach $instName (sort keys %instanceTreeF2As) {
    my @f2aList = @{$instanceTreeF2As{$instName}};
    print "InstName = $instName\n";
    my $lastWordPrefix = "";
    my $matchPrefix    = "";

# find the prefix sets in the SORTED f2a lists
    foreach $f2aMapping ( @f2aList) {
        my @f2a = @{$f2aMapping};
        foreach $name ( @f2a) {
            print " $name \t";              
        }   
        my $actualName = $f2a[1];

        if ($actualName =~ /([^_]+)_/) { # get the first word before the first '_'
            my $prefix = $1;
#            chop $prefix;
            if ($lastWordPrefix eq $prefix) {
                $matchPrefix = $prefix;
            }
            else {
                $matchPrefix = "";
            }
            print "actual prefix matching        actualName = $actualName\tprefix = $prefix\tlastWordPrefix = $lastWordPrefix\tmatchPrefix = $matchPrefix\n";
            $lastWordPrefix = $prefix;
        }
    }
    print "\n\n";
}

exit 0;

sub hierPrint {
    my ($vdata, $indent, $m, $instName, $fileName) = @_;
    my ($imod,$mf,$iname,$l,@subMods, @subInsts);
    print "hierPrint unitName = $m instName = $instName\n";

    if ( defined $unitHash{$m}) { return; } # already made this unit
    else { $unitHash{$m} = 1;}
# build the instance tree

    $instanceTree{$m} = \@subInsts; # set parent equal to children

    open my $FILE, ">>", $fileName or die $!;

    print $FILE "// ------------------------------------------------------------\n";
    print $FILE "// Unit $m \n";
    print $FILE "// ------------------------------------------------------------\n";

    print $FILE "csl_unit $m {\n";

# get the signals in the module

    print $FILE "\n// Ports\n\n";
    
    if ( my @signals = $vdata->get_modules_signals($m)) {
        foreach $signal (sort @signals) {

            #print "signal = $signal\n";
            my ($s_line,$s_a_line,$s_i_line,$s_type,$s_file,$s_p,$s_n, $s_type2,$s_r_file,$s_r_line,$range,$s_a_file,$s_i_file) = $vdata->get_module_signal($m, $signal);           

            #print "range = $range\n";
            my @indices = split(/:/, $range);

            #print "indices = @indices\n";

            my $width = 1;
            if ($#indices == 1) {
                #print "i0 = $indices[0] i1 =  $indices[1]\n";
# check for non numeric values (tick defines and params)
                $width = $indices[0] - $indices[1] + 1;
            }

            #print "width = $width\n";

            switch ($s_type) {
                case "input" { print $FILE   "  csl_port \t$signal\t($s_type\t, $width);\n" }
                case "output"{ print $FILE   "  csl_port \t$signal\t($s_type\t, $width);\n" } 
                case "inout" { print $FILE   "  csl_port \t$signal\t($s_type\t, $width);\n" }
            }

            #print "Before add signal : $signal: m=$m instName=$instName type=$s_type\n";
            
            push @{$portNames{$signal}} , ["t:$s_type", "un:$m", "in:$instName"]; 
            # my @connectionList = @{$portNames{$signal}};
            # foreach $connection ( @connectionList) {
            #     print " $connection \t";              
            # }
            # print "\n\n";
        }      

        print $FILE "\n// Locals\n\n";

        foreach $signal (sort @signals) {

            #print "signal = $signal\n";
            my ($s_line,$s_a_line,$s_i_line,$s_type,$s_file,$s_p,$s_n, $s_type2,$s_r_file,$s_r_line,$range,$s_a_file,$s_i_file) = $vdata->get_module_signal($m, $signal);           

            #print "range = $range\n";
            my @indices = split(/:/, $range);

            #print "indices = @indices\n";

            my $width = 1;
            if ($#indices == 1) {
                $width = $indices[0] - $indices[1] + 1;
            }

            #print "width = $width\n";

            switch ($s_type) {
                case "reg"   { print $FILE "  csl_signal \t$signal\t($s_type\t, $width);\n" }
                case "wire"  { print $FILE "  csl_signal \t$signal\t($s_type\t, $width);\n" }
            }
        }      
    }
    
    # get a list of sub modules
    for (($imod,$mf,$iname,$l) = $vdata->get_first_instantiation($m );
	 $imod;
	 ($imod,$mf,$iname,$l) = $vdata->get_next_instantiation()) {
	push(@subMods,$imod);
	push(@subInsts,$iname);
        print $FILE "\n  $imod $iname(\n";
        my %port_con = $vdata->get_current_instantiations_port_con();
        foreach $port (sort keys %port_con) {
            print $FILE "    .$port\t(", $port_con{$port} , "\t),\n";
            push @{$instanceTreeF2As{$iname}} , ["$port", "$port_con{$port} " ];
        }
        print $FILE "  );\n";
    }

    if (!(($imod,$mf,$iname,$l) = $vdata->get_first_instantiation($m ))) {
        print $FILE "// unit $m instName: $iname has no children\n";
    }
    print $FILE "  $m () {}\n";
    print $FILE "  \n";
    print $FILE "};\n\n";
    close $FILE;

    # recurse down hierarchy
    foreach $imod (sort @subMods) {
        $iname = pop(@subInsts);
        #print "vdata = $vdata\n";
        #print "indent = $indent\n";
        #print "imod = $imod\n";
        #print "2.5 fileName = $fileName\n";
	hierPrint($vdata, $indent + 2, $imod, $iname, $fileName);
    }
}

