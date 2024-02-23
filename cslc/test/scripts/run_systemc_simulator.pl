#!/usr/bin/perl 

# implemented by Oana B

use lib "$ENV{WORK}/test/scripts";
use mRegress; #use this for the new regression
use FplLib;
use strict;
use Config; #checking if the system has signals enabled
use POSIX qw(ceil floor);

my %externalArguments = (); # command line args


chomp( my $arch = `uname -m`); #getting information about the current system
if ($arch =~ m/i686/) {
    $arch = "x86";      
}
elsif ($arch =~ m/x86_64/) {
    $arch = "x86_64";
}
elsif ($arch =~ m/i386/) {
    $arch = "x86_32";
}

my $buildDir = $mRegress::totDir . "/trunk/build/linux/$arch";
print "totDir = ", $mRegress::totDir,"\n";
print "scriptsDir = $mRegress::scriptsDir\n";
my $cslcExec = "$buildDir/cslc/cslc";              # cslc executable
&FplLib::testFileExists($cslcExec);


my $help    = "";
my $setUnit = "";

my $testsDir = $mRegress::totDir . "/test/csl_new_bug/systemc_simulator";


chdir($testsDir) or die "Can't change test dir: $testsDir!!\n";

my @dirs = `ls`;  # directories with each csl test and the necessary systemC files
chop @dirs;

print "-------@dirs\n";

foreach my $dir (@dirs) {

    chdir($testsDir."/".$dir) or die "Can't change dir: $dir!!\n";

    my @cslTests = `ls *.csl`;   ## csl test(s) for each directory
    chop @cslTests;

    foreach my $test (@cslTests) {
    
	`$cslcExec $test`;  ## compile csl test
    }

## copy the existing systemC code into the generated directory

    my $genCodeDir = `ls -d *_cslc_generated`;  # dir(s) with generated code
    chop $genCodeDir;

    my $sysCCodeDir = $testsDir."/".$dir."/".$genCodeDir."/code/systemC";

    my @headerFiles = `ls *.h`; # existing systemC code
    chop @headerFiles;

    my $main = "main.cpp"; # existing systemC code

    my $copyMain = `cp -fr $main $sysCCodeDir`;

    system($copyMain) or die "Can't copy main file in $sysCCodeDir!\n";


    foreach my $h (@headerFiles) {

	my $copyH = `cp -fr $h $sysCCodeDir`;
	system($copyH) or die "Can't copy header files!\n";
    }


## compile generated systemC code using makefiles => main.x
    chdir($sysCCodeDir) or die "Can't change systemC dir: $sysCCodeDir!!\n";

            print "Creating exec main file!!!\n";

            `make -f Makefile.gcc`;


##simulator part

		   
		   ##run main file to create the stim and exp vector files
		   `main` or die "Can't run exec main file!\n";

                   my @stimVecFiles = `ls stim_*`;
		   my @expVecFiles = `ls exp_*`;
		   chop @stimVecFiles;
		   chop @expVecFiles;

    ##go to the verilog generated code directory
    my $ver = $testsDir."/".$dir."/".$genCodeDir."/code/verilog";
    chdir($ver) or die "Can't go to verilog directory!\n\n";
    
    print "Choose unit instance to simulate:\n";
    foreach my $st (@stimVecFiles) {
	if($st =~ m/stim_vec_([a-z0-9]+)(_)$/i) {
	    print $1."\t\t";
	}
    }
    print "\n>";
    my $unitInst = <STDIN>;

    #remove old soflinks

    `rm -f *.vec`;
    
    #create softlinks to the vector files in the systemC gen code dir
    my $lnStimInst = "../systemC/stim_vec_$unitInst";
    chop $lnStimInst;
    my $lnStimFile = "stim_input.vec";
    my $stimLn = "ln -s $lnStimInst"."_"." $lnStimFile";
    #print "\n:softlink:".$stimLn."\n";
    system("$stimLn");## or die "Can't create soft link for stim\n\n";

    my $lnExpInst = "../systemC/exp_vec_$unitInst";
    chop $lnExpInst;
    my $lnExpFile = "exp_input.vec";
    my $expLn = "ln -s $lnExpInst"."_"." $lnExpFile";
    system("$expLn"); ## or die "Can't create soft link for exp\n\n";

    my $topUnit = `ls *.vf`;
    if($topUnit =~ m/([a-z0-9]+)(.vf)$/i) {

	my $runVerilog = "vpp $1.v > $1.vpp && iverilog -s tb *.v -o $1.sim && vvp $1.sim";
	system("$runVerilog") or die "Can't run Verilog simulator!\n";

    }







}




