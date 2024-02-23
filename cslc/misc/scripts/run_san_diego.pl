#! /usr/bin/perl -w
#oanab
#run the csl_csv_gen.pl in san_diego and compile the generated code

use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

my $totDir     = $ENV{WORK};
&testDirExists($totDir);

sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
}

#directory with the project
my $dir = "$totDir/misc/projects/san_diego/";

chdir($dir) or die "Can't change dir!!\n"; # go to san_diego dir in projects

# chmod the script
my $cmd = "chmod 700 csl_csv_gen.pl";
system($cmd);

# run the script that generates the csl code
my $run = "csl_csv_gen.pl -f agent_cl.csv -i agent_cl.ifc.lib.csl -d agent_cl.hier ";
system($run);

# generated tests dir
my $test = "$totDir/test/csl_test_gen/";

chdir($test) or die "Can't change dir!!\n"; # go to generated tests dir

# create san_diego dir in the tests dir
my $mdir = "mkdir san_diego";
system($mdir);

chdir($dir) or die "Can't change dir!!\n"; # go to san_diego dir in projects

# copy the interfaces and the generated files to the san_diego dir in tests
my $cpy = "cp agent_cl.ifc.lib.csl $totDir/test/csl_test_gen/san_diego/";
my $cpy1 = "cp -r generated $totDir/test/csl_test_gen/san_diego/";

system($cpy);
system($cpy1);

# san_diego dir in tests
my $san = "$test/san_diego/";
chdir($san) or die "Can't change dir!!\n"; # go to san_diego dir in tests

# compile generated csl code
my $rreg = "cslc agent_cl.ifc.lib.csl generated/agent_cl.csl --info";
system($rreg);



