#!/usr/bin/perl

#oanab

use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

my $totDir     = $ENV{WORK};
my $scriptsDir = "$totDir/test/scripts"; # scripts directory

# go to scripts directory
chdir($scriptsDir) or die "Can't change dir!\n"; 

my @files = `ls $scriptsDir/*_valid*`; #files in the scripts directory

print @files;
my $dirs = 0;  # number of directories in the generated tests directory
my $scripts = 0; # scripts number
my $scriptNo = 0; # current script number

foreach my $file (@files) {
    if($file =~ m/(.+)(\.pl)$/) {
        $scripts++;
    }

}
my $allScripts = $scripts; #number of scripts in the directory
my $testsDir = "$ENV{WORK}/test/csl_test_gen";
my @testDirs = `ls $testsDir`; # generated tests directories
chdir($testsDir) or die "Can't change dir!\n"; # go to generated tests directories
#delete previous generated tests
foreach my $dir (@testDirs) {
#    print "---deleting dir $dir\n";
    my $del = "rm -r $dir";
    system($del);
}

chdir($scriptsDir) or die "Can't change dir!\n"; # go to scripts directory
#search for scripts
foreach my $file (@files) {
    if($file =~ m/(.+)(\.pl)$/) {    
        $scriptNo++;
        my $chMod = "chmod 700 $file"; 
        system("$chMod"); 
# run first half of the scripts
        if($scriptNo <= int($allScripts/2)) {
            print("running test: $file\n"); 
            system("$file"); 
        }
    }
}


# # go to generated tests directory
# chdir($testsDir) or die "Can't change dir!\n"; 
# #run regression for the generated tests
# my $compile = "run_regress.pl -hdl csl_test_gen ";  
# system($compile);
# 
# chdir($scriptsDir) or die "Can't change dir!\n"; # go to scripts directory









