#!/usr/bin/perl -w

use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command
use POSIX;                # POSIX functions
use HTML::Template;       # Html templates
use strict;

use lib "$ENV{WORK}/trunk/scripts/";
use FplLib;
use Regress;

my $maintainer  = "Petronela E. and Ines C. and Derek"; #put your name here if you are the current maintainer of this script
my $myVersion   = "0.4";

# command lnie argument helpers

my $help                 = "";
my $version              = "";
my $verbose              = "";
my $hdlExtParam          = "";
my $enableValgrind       = "";
my $postCompile          = "";
my $no_execute           = 0;
my $results_dir          = "";
my $firefox              = "";
my $noPostCompile        = "";
my $noPostCompileCpp     = "";
my $noPostCompileSystemC = "";
my %externalArguments    = ();

my $testDir   = $Regress::totDir . "/test";
my $trunkDir  = $Regress::totDir . "/trunk";
my $srcDir    = "$trunkDir/src";
my $scriptDir = "$trunkDir/scripts";

my $pid = getppid();
chomp (my $results_date = `date "+%d.%m.%G_%T"`);
$results_date =~ s/(:)/_/g;

my $resultsRootDir = $Regress::totDir . "/test/report/dist_regress_results_" . "$results_date" . "_$pid" ; 

print "resultsRootDir = $resultsRootDir\n";

my $ADD_SEMAPHORE = 1; # use a semaphore with this command
my $NO_SEMAPHORE  = 0; # do not use a semaphore with this command

my $BACK_GROUND   = "&"; # back ground the command

my $semaphore_dir = "$ENV{HOME}/semaphore_dir";  

my $WS_0 = "";

my @wsList = (); # list on workstations to run jobs on

my $numWorkStations = 14;

&main();

sub main {
#test    &runSsh("hostname && hostname && hostname", 0, $ADD_SEMAPHORE, $BACK_GROUND, $semaphore_name);

    %externalArguments = &processExternalArgs();           #testing if the arguments are correct and if so then they are processed

    my $log  = "dist_regress.log";
    open(LOG, "> $log");


    for(my $ws = 1; $ws < $numWorkStations; $ws++) {
        if ($ws != 8 && $ws != 4 && &isWsAlive($ws)) { 
        #if (&isWsAlive($ws)) { 
            push(@wsList, $ws);  #if the ws is online ... add it to ws list
            print LOG "Adding ws = $ws\n";
        }
    }
    my @hdlList = ("csl", "csl_v2", "csl_new_bug", "verilog");
    my $currentHdl = "csl"; #add a funtion with the rest of the main; add foreach my $currentHdl (@hdlList)

    print "after process externalArguments{no_exec} = ", $externalArguments{"no_exec"} ,"\n";
    print "no_execute = $no_execute\n";

    if ($externalArguments{no_exec}) {
        $resultsRootDir = $externalArguments{results_dir};                           #the results directory
        unless (-e $resultsRootDir) { die "[ERROR] resultsRootDir: $resultsRootDir does not exist";} 
    }
    else {
        &mkDir($resultsRootDir);
        &mkDir("$resultsRootDir/csl");

        my $topHdlDir = "$testDir/$currentHdl";
        my $ls_cmd    = "ls $topHdlDir"; 
        my $r = system("$ls_cmd");
        my $retVal = $?;
        my $errorNumber = ( $retVal >> 8 );

        my $directoryList = `$ls_cmd`;
        my @directoryList = split(/\n/, $directoryList);
        chomp(@directoryList); # get rid of '\n'

        my $testType = "";
        if ("verilog" eq $currentHdl) { $testType = "v"  ; }
        else                          { $testType = "csl"; }

        my %hdlDirMap; # map the dirname to the file count in the dir

        my $totalFileCnt = 0; # total number of files in all directories

        my $dirNum = 0; # the count of the number of directories with hdl files in them

        my @hdlDirectoryList;
        foreach my $dir ( @directoryList ) {
            my $pattern = "$topHdlDir/$dir/*.$testType";
            my $ls_cmd    = "ls $pattern"; 
            my $r = system("$ls_cmd > /dev/null");
            my $retVal = $?;

            if (0 == $retVal) { # add the directory to the list if the dir contains hdl files
                chomp(my $fileCnt = `$ls_cmd | wc -l`); # FIX in each directory count the number of chars in each file and use this to balance the dirs
                print "fileCnt = $fileCnt\n";
                $hdlDirMap{$dir} = $fileCnt; # no of files per directory
                $totalFileCnt += $fileCnt;
                $dirNum++;		# count no of directories
                push(@hdlDirectoryList, $dir); #save the dir to directory list
            }
        }

################################################################################
# in each dir automatically figure out the number of tests and number 
# of lines of code in each test 
# then distribute the jobs to the different work stations
################################################################################

        my %dirWsList = ();         

        my $cnt = 0;

        my $averageNumFilePerDir = int($totalFileCnt/$#wsList); 

        print "averageNumFilePerDir = $averageNumFilePerDir dirNum = $dirNum numWorkStations = $numWorkStations\n";

        my $wsFileCnt = 0; # current count of the number of files being sent to the work station
        my @wsJobList = ();

################################################################################
# create a map of empty lists
# the index into the map is a work station number
################################################################################

        foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
            my @wsJobList = ();
            $dirWsList{$ws} = \@wsJobList; 
        }

        foreach my $ws (sort keys %dirWsList) { # the work station numbers are stored a in a list-some are missing-can't just count
            print LOG "print dirWsList{$ws} = $dirWsList{$ws}\n";
        }

################################################################################
# add lists of dierctories to the map
# each work station is an index into the map
# each work station has an associated list of directories 
#
# The average number of hdl test per work station is equal to the total number of all hdl tests divided
# by the number of work stations
#
# Each work station is sent a number of directories which contain a total amount of hdl tests less
# than the average number of hdl test per work station. The last work station may have more that the
# average number of tests
#
# foreach directory in the list of directories create a run_regress.pl job and send it to the work station
################################################################################

#    foreach my $dir (sort { $hdlDirMap{$a} < $hdlDirMap{$b} } keys %hdlDirMap) {
        foreach my $dir (sort keys %hdlDirMap) {
            print "sort $dir $hdlDirMap{$dir}\n";
        }

################################################################################
#    foreach my $dir (sort keys %hdlDirMap) {
################################################################################

        my @wsListCopy = @wsList; # make a copy fo the work station list and pop the numbers from it in the loop
        my $wsNum = pop(@wsListCopy);


# Fix the algorithm-once a work station has been filled up with tests then recalc the averageNumFilePerDir
# which is the average number of files per work station in the distributed computing pool

#    foreach my $dir (sort { $hdlDirMap{$a} < $hdlDirMap{$b} } keys %hdlDirMap) {
        foreach my $dir (sort keys %hdlDirMap) {
            print LOG "hdlDirMap{$dir} = $hdlDirMap{$dir}\n";

            print "averageNumFilePerDir = $averageNumFilePerDir cnt = ", ($wsFileCnt + $hdlDirMap{$dir}) , "\n";

            if ( ( 1 == $wsNum) || ($wsFileCnt + $hdlDirMap{$dir}) < $averageNumFilePerDir ) { # insert the dir in the list if the cnt is below the average
                $wsFileCnt += $hdlDirMap{$dir}; 
                push (@{$dirWsList{$wsNum}}, $dir);
                print "if pushed wsNum = $wsNum $dir => ", @{$dirWsList{$wsNum}}, "\n";
            }
            else { # work station list is done-get the next work station number
                $wsNum     = pop(@wsListCopy);
                $wsFileCnt = 0; # reset the works station file counter to 0
                print "else next work station wsNum = $wsNum\n";
            }
        }


        foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
            my @dirWSList = @{$dirWsList{$ws}};
            print LOG "dirWsList{$ws} = $dirWsList{$ws} / @dirWSList\n";
            foreach my $dir (@dirWSList) {
                print LOG "   dir = $dir\n";
            }
        }
        my $semaphore_name = "$semaphore_dir/semaphore_pid_$pid";

################################################################################
# set +o noclobber 
# turn off the bash noclobber option for files can be over written
################################################################################

        my $svnRmCmd      = "hostname && /bin/rm -fr $trunkDir && echo svnRmCmd";

################################################################################
# add another loop to loop through the hdls
################################################################################

        print "srcDir/build.xml = $srcDir/build.xml\n";

#    foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
#        &runSsh($ws, $svnRmCmd     , 0, $ADD_SEMAPHORE, $BACK_GROUND, $semaphore_name);
#    }
#    &waitforJobsTofinish($semaphore_name, "svn rm");

################################################################################
# ant build the cslc executable on the server only
################################################################################


        my $snvUpCmdBuild = "svn up $trunkDir && svn up $testDir";
        `$snvUpCmdBuild`;

        print LOG "svn up on build done\n";

        my $antCmd        = "hostname && set +o noclobber && ant -f $srcDir/build.xml debug && echo antCmd";
        &runAnt($antCmd);

        print LOG "ant on build done\n";


################################################################################
# copy the cslc executable to each work station in the work station pool    
################################################################################

        my $cslcExec = $Regress::totDir . "/trunk/build/linux/x86_64/cslc/cslc";

        foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
            my $scpCmd = "scp -P  22 $cslcExec dist_regress\@fpl64-$ws.fplsrl.com:$cslcExec";
            print LOG "$scpCmd\n";
            `$scpCmd`;
        }


#################################################################################
## svn up 
#################################################################################

        my $svnUpCmd      = "hostname && svn up $testDir && svn up $trunkDir && echo svnUpCmd";

        foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
            &runSsh($ws, $svnUpCmd, 0, $ADD_SEMAPHORE, $BACK_GROUND, $semaphore_name);
        }
        &waitforJobsTofinish($semaphore_name, "svn up");


################################################################################
# foreach work station 
#   foreach dir 
#     send one run_regress.pl job to the work station
################################################################################

#    my @hdlList = ("csl", "csl_v2", "csl_new_bug", "csl_design_gen", "csl_cc_gen", "verilog"); # FIX add verilog later
        my @hdlList = ("csl", "csl_v2", "csl_new_bug", "verilog"); # FIX add verilog later

        foreach my $hdl (@hdlList) {
            my $hdl = "csl";
            foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
                my @dirWSList = @{$dirWsList{$ws}};
                print "dirWsList{$ws} = $dirWsList{$ws} / @dirWSList\n";
                foreach my $dir (@dirWSList) {
                    my $d = "$resultsRootDir/csl/$dir";
                    &mkDir($d);
                    my $editMsg = $ws . "_$dir" . "_done";
                    my $valArg = "";
                    if($externalArguments{enableValgrind} ne "") {
                        $valArg = "-val";
                    }
                    my $postCompileArg = "";
                    if($externalArguments{postCompile} eq "") {
                        $postCompileArg = "-no_post_compile";
                    }
                    my $distRegressLog = "dist_regress_$ws". "_$dir.log";
                    my $runRegressCmd = "$scriptDir/run_regress.pl $valArg $postCompileArg -hdl $hdl -results_dir $resultsRootDir -dir_filter $dir -msg $editMsg > $distRegressLog; echo runRegressCmd ";
                    print LOG " runRegressCmd = cmd = $runRegressCmd\n";

                    &runSsh($ws, $runRegressCmd, 0, $ADD_SEMAPHORE, $BACK_GROUND, $semaphore_name);
                }
            }
            &waitforJobsTofinish($semaphore_name, "run_regress");
        }

        foreach my $hdl (@hdlList) {
            my $hdl = "csl";
            foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
                my @dirWSList = @{$dirWsList{$ws}};
                print "dirWsList{$ws} = $dirWsList{$ws} / @dirWSList\n";
                foreach my $dir (@dirWSList) {
                    my $d = "$resultsRootDir/csl/$dir";
                    my $scpCmd1 = "scp -r -P  22  dist_regress\@fpl64-$ws.fplsrl.com:$resultsRootDir/csl/$dir/summary.txt $d/summary.txt";
                    my $scpCmd2 = "scp -r -P  22  dist_regress\@fpl64-$ws.fplsrl.com:$resultsRootDir/csl/$dir/*html $d/$dir";
                    print "$scpCmd1 \n";
                    print "$scpCmd2 \n";
                    
                    `$scpCmd1`; 
                    `$scpCmd2`;
                }
            }
        }
#  ################################################################################
#  # copy the regression results from each work station to the server
#  ################################################################################
#  
#      foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
#          my $scpCmd = "scp -r -P  22  dist_regress\@fpl64-$ws.fplsrl.com:$resultsRootDir/csl/* $resultsRootDir/csl";
#          print "$scpCmd\n";
#          `$scpCmd`;
#      }

        print "resultsRootDir = $resultsRootDir\n\n";
    }
################################################################################
# copy the regression results from each work station to the server
################################################################################

#    foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
#        my $scpCmd = "scp -r -P  22  dist_regress\@fpl64-$ws.fplsrl.com:$resultsRootDir/csl/*/summary.txt $resultsRootDir/csl";
#        print LOG "$scpCmd\n";
#        `$scpCmd`;
#    }
#
#    foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
#        my $scpCmd = "scp -r -P  22  dist_regress\@fpl64-$ws.fplsrl.com:$resultsRootDir/csl/*/*html $resultsRootDir/csl";
#        print LOG "$scpCmd\n";
#        `$scpCmd`;
#    }

################################################################################
# merge the results files into one summary
# run_regress.pl -no_exec -hdl csl -val -results_dir $resultsRootDir
################################################################################
    my $testDirFilter = "";
    $externalArguments{"no_exec"} = 1; # turn on no exec to generate the summary files from the summary.txt files.
    $externalArguments{"no_post_compile"} = 1; 

    &Regress::regressHdl ($resultsRootDir, $currentHdl, $testDirFilter, \%externalArguments ); 

################################################################################
# create the png graph files
################################################################################

#    `graph_regress.pl`;

    close LOG;
}


#################################################################################################
#                                          processExternalArgs                                  #
#subroutine for processing the external arguments                                               #
#################################################################################################

sub processExternalArgs {
    use Getopt::Long;

    # print "[INFO] processExternalArgs: begin \n";

#with =s it gets the string from the command line
#without =s it sets the value to 1 if -myOption is typed or to 0 otherwise
    my $argument = GetOptions(
                           'h'                       => \$help                , 
                              'help'                    => \$help                , 
                              'version'                 => \$version             ,
                              'v'                       => \$verbose             , 
                              'hdl:s'                   => \$hdlExtParam         ,
                              'val'                     => \$enableValgrind      ,
                              'post_compile'            => \$postCompile         ,
                              'no_exec'                 => \$no_execute          ,
                              'results_dir:s'           => \$results_dir         ,
                              'www'                     => \$firefox             ,
                              'no_post_compile'         => \$noPostCompile       ,
                              'no_post_compile_cpp'     => \$noPostCompileCpp    ,
                              'no_post_compile_systemc' => \$noPostCompileSystemC,
                              );

    #print "hdlExtParam = $hdlExtParam\n";

    my %externalArguments = ( 
                              "h"                       => $help                ,
                              "help"                    => $help                ,
                              "version"                 => $version             ,
                              "v"                       => $verbose             ,
                              "hdlExtParam"             => $hdlExtParam         , 
                              "postCompile"             => $postCompile         , 
                              "enableValgrind"          => $enableValgrind      , 
                              "no_exec"                  => $no_execute          , 
                              "results_dir"             => $results_dir         , 
                              "firefox"                 => $firefox             , 
                              "no_post_compile"         => $noPostCompile       ,
                              "no_post_compile_cpp"     => $noPostCompileCpp    ,
                              "no_post_compile_systemc" => $noPostCompileSystemC,
                              );

    print "externalArguments{no_exec} = ", $externalArguments{"no_exec"} ,"\n";
    print "no_execute = $no_execute\n";

    #if there is any argument left unfiltered (after filtering the options in the lines above) then it is an invalid use of the script
    unless ( @ARGV == 0 ) { die("[ERROR] processExternalArgs: Invalid argument. Type -h for details: @ARGV\n"); }

    if( $help ) {
        &usage();  
        exit;
    } 

    if ( $version ) {
        print"[EXIT] FPL Regression Parser - VERSION: $myVersion\nCurrent maintainer: $maintainer. Type -h for help usage information.\n";
        exit;
    } 

    if(1 == $no_execute ) {
        unless(-e $results_dir) { die "[ERROR] The 'results_dir' directory argument does not exist: $results_dir\n";}
    } 


    if($externalArguments{"no_exec"} ne "" && ! (&isCslHdlArg($hdlExtParam) || $hdlExtParam eq "verilog") ) {
        print"[ERROR] The 'hdl' argument $hdlExtParam is not correct\n";
        &usage();  
        exit;
    } 

    return %externalArguments;
}

################################################################################
# return true if currentHdl is a csl directory
################################################################################

sub isCslHdlArg {
    my($currentHdl) = @_;

    my $bool = $currentHdl eq "csl" || $currentHdl eq "csl_v2"  || $currentHdl eq "csl_new_bug" 
        || $currentHdl eq "csl_test_gen" || $currentHdl eq "csl_design_gen"  || $currentHdl eq "csl_cc_gen";

    return $bool;
}

#################################################################################################
#                                            usage                                              #
#subroutine for printing the regress parser usage                                               #
#################################################################################################

sub usage {
    print "#########################\n";
    print "# Regress Parser Usage: #\n";
    print "#########################\n";
    print "[perl] run_regress.pl -hdl <name> [-no_exec <path2>]  
          [-h] [-version] [-v] [-val] [-post_compile]\n";
    print "[INFO] The variabile WORK is the path to your home folder (must be defined in .bash_profile)
           ex: WORK=HOME/svn or WORK=HOME/fpl/cslc (no final slash) \n";
    print " -hdl <name>          -> only tests from hdl named <name> are chosen. <name> can be one of the folowing: 
                                    verilog         : run the Verilog verilog    tests.
                                    csl             : run the CSL csl            tests (golden test suite).                                      csl_v2          : run the CSL csl_v2         tests (CSL version 2 tests).
                                    csl_new_bug     : run the CSL csl_new_bug    tests (tests that should be verified and promoted to csl golden.
                                    csl_test_gen    : run the CSL csl_test_gen   tests (Tibi test generators).
                                    csl_design_gen  : run the CSL csl_design_gen tests (designGen.cpp) .
                                    csl_cc_gen      : run the CSL csl_cc_gen     tests (Perl script corner case generators).
                                    \n";
    print " -no_exec <path2>     -> do not run cslc; the regression generates the HTML report using the last version of the results files in <path2>. \n";
    print " -no_post_compile     -> Do not compile the generated code. \n";  
    print " -no_post_compile_cpp -> Do not compile the CPP and CSIM CPP generated code. \n";  
    print " -no_post_compile_systemc -> Do not compile the SystemC CPP generated code. \n";  
    print " -h                   -> display help info\n";
    print " -version             -> prints version\n";
    print " -v                   -> verbosity on \n";
    print " -val                 -> run valgrind to detect memory leaks\n";
}  


sub runAnt {
    my ($antCmd) = @_;
    my $r = system("$antCmd");
    my $retVal = $?;
    my $errorNumber = ( $retVal >> 8 );
    print "ssh errorNumber = $errorNumber  retVal =  $retVal\n";
    
    if (0 != $errorNumber) {
        print "[ERROR] ant command failed\n";
        exit(1);
    }
    else {
        print "[INFO] ant command passed\n";
    }
}

################################################################################
# wait for all semaphores to be cleared
# time out after n minutes
################################################################################

sub waitforJobsTofinish {
    my ($semaphore_name, $jobName) = @_;

    my $sleepTime = 10;
    my $done = 0;
    while (0 == $done) {
        $done = 1; # set done equal to 1, if any semaphore still exists for loop set to 0
        foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
            my $semaphore = $semaphore_name . "_ws_$ws";

            if (-e $semaphore) {
                print "jobName = $jobName Semaphore $semaphore ACTIVE\n";
                $done = 0;
            }
            else {
                print "jobName = $jobName Semaphore $semaphore DELETED\n";
            }
        }           
        `sleep $sleepTime`;
        print "jobName = $jobName Semaphore sleep $sleepTime done = $done\n";
    }

    print "All semaphores cleared\n";
}

################################################################################
# check if ssh to the work station works
# if it does then
#   check if the the semaphore file exists
#   if the semaphore file does not exist then 
#     touch the semaphore file
#     ssh svn up and rm the semaphore file
# 
################################################################################

sub runSsh {
    my ($ws,  $cmd0, $timeout, $add_semaphore, $backGround, $semaphore_name) = @_;
    print "runSsh\n";
    my $semaphore = $semaphore_name . "_ws_$ws";
    my $semaphoreTouchCmd = "";
    my $semaphoreRmCmd    = "";

    if ($ADD_SEMAPHORE == $add_semaphore) { # use a semaphore to control the processes
        print "Adding semaphore\n";
        $semaphoreTouchCmd = "/bin/touch -f $semaphore && ";
        $semaphoreRmCmd    = "&& /bin/rm -f $semaphore ";
    }

    if (!(-e $semaphore_name)) {
        my $cmd = "ssh  dist_regress\@fpl64-$ws.fplsrl.com -p 22 \"nice -n 10 $semaphoreTouchCmd $cmd0 $semaphoreRmCmd && echo ws_$ws done && hostname \" &";
        print("$cmd\n");
        my $r = system("$cmd");
        my $retVal = $?;
        my $errorNumber = ( $retVal >> 8 );
    }   
    else {
        print "SEMAPHORE blocked cmd currently running on workstation fpl64-$ws\n";
        exit;
    }
}

################################################################################
# is the work station alive?
################################################################################

sub isWsAlive {
    my($ws) = @_;    

    my $sshCmd = "ssh  dist_regress\@fpl64-$ws.fplsrl.com -p 22 nice -n 10 ";
    print("$sshCmd\n");

    # check if the machine is alive
    my $sshLsCmd = "$sshCmd ls > /dev/null";
    print("$sshLsCmd\n");
    my $r = system("$sshLsCmd");
    my $retVal = $?;
    my $errorNumber = ( $retVal >> 8 );
    print "ssh ls $ws errorNumber = $errorNumber  retVal =  $retVal\n";

    my $alive = 0 == $retVal;
    return $alive;
}

################################################################################
# if he directory does not exist make a new one
################################################################################

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { 
        mkpath("$dirName"); 
        print "[INFO] Created directory $dirName\n";
    }
}

#################################################################################################
# distributeJobs                                                                                #
#                                                                                               #
# distribute the jobs to the workstations in the work station pool                              #
#################################################################################################

sub distributeJobs {
#    my () = @_;

}

#################################################################################################
#                                                                                               #
# Instead of executing the jobs and grepping the log files                                      #
# we extract the results from the copy of the                                                   # 
# HTML directory summary file                                                                   #
#                                                                                               #
#################################################################################################

sub regressDir{ 
    my ($resultsRootDir, $currentTestDirectory, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdl, $currentHdlDirectory) = @_;


# initialize the test results

    my %testResults = ();
    my $chapterDir = "$currentHdlDirectory/$currentTestDirectory";

    my $dirSummaryFile = "$chapterDir/summary.txt";

    print "regressDir: chapterDir = $chapterDir dirSummaryFile = $dirSummaryFile\n";

    if (-e $dirSummaryFile) {
        open (DIR_SUMMARY, "$dirSummaryFile") or die ("[ERROR] check_results: Error opening $dirSummaryFile summary file !\n");
        my @lines = <DIR_SUMMARY>;
        @lines;
        close DIR_SUMMARY;
        my %numStagesPassed = ();
        print @lines;

        foreach my $line (@lines) {
            print "line = /$line/\n";
            if    ($line =~ m/cslcCompileVerilogCode\s*=\s*(\d+)/  )  { $numStagesPassed{cslcCompileVerilogCode} = $1; }
            elsif ($line =~ m/gccCompileCppCode\s*=\s*(\d+)/       )  { $numStagesPassed{gccCompileCppCode     } = $1; } 
            elsif ($line =~ m/gccCompileCsimCode\s*=\s*(\d+)/      )  { $numStagesPassed{gccCompileCsimCode    } = $1; } 
            elsif ($line =~ m/gccCompileSystemCCode\s*=\s*(\d+)/   )  { $numStagesPassed{gccCompileSystemCCode } = $1; } 
            elsif ($line =~ m/totalDirNumTests\s*=\s*(\d+)/        )  { $testResults{totalDirNumTests          } = $1; } 
            elsif ($line =~ m/totalDirNumTestsPassed\s*=\s*(\d+)/  )  { $testResults{totalDirNumTestsPassed    } = $1; } 
            elsif ($line =~ m/totalDirPercentPassed\s*=\s*(\d+)/   )  { $testResults{totalDirPercentPassed     } = $1; } 
            elsif ($line =~ m/directoryStatusCSS\s*=\s*(.*)$/      )  { $testResults{directoryStatusCSS        } = $1; } 
            elsif ($line =~ m/totalDirMajorErrorCnt\s*=\s*(\d+)/   )  { $testResults{totalDirMajorErrorCnt     } = $1; } 
            elsif ($line =~ m/totalDirValgrindErrorCnt\s*=\s*(\d+)/)  { $testResults{totalDirValgrindErrorCnt  } = $1; } 
            elsif ($line =~ m/numStagesPassed\s*=\s*(\d+)/         )  { $testResults{numStagesPassed           } = $1; }
            elsif ($line =~ m/([^S]+)Status\s*=\s*(\d+)/)  { 
                my $phase = $1 . "Status";
                $numStagesPassed{$phase} = $2; 
            }
            else {
                print "WARNING $line\n";
            } 
        }

        $testResults{numStagesPassed} = \%numStagesPassed;

        foreach my $phase (@Regress::compilerPhaseList) {
            print "numStagesPassed{$phase} = /", $numStagesPassed{$phase },"/\n";
        }

        print "totalDirNumTests        /", $testResults{totalDirNumTests         } ,"/\n";
        print "totalDirNumTestsPassed  /", $testResults{totalDirNumTestsPassed   } ,"/\n";
        print "totalDirPercentPassed   /", $testResults{totalDirPercentPassed    } ,"/\n";
        print "directoryStatusCSS      /", $testResults{directoryStatusCSS       } ,"/\n";
        print "totalDirMajorErrorCnt   /", $testResults{totalDirMajorErrorCnt    } ,"/\n";
        print "totalDirValgrindErrorCnt/", $testResults{totalDirValgrindErrorCnt } ,"/\n";
        print "numStagesPassed         /", $testResults{numStagesPassed          } ,"/\n";

       # print "grep = " , grep(/totalDirNumTests/, @lines) ,"\n";

    }
    else {
        print "[ERROR] chapter directory summary file missing: $dirSummaryFile \n";
    }

    print "testResults{totalDirNumTests}  = ", $testResults{totalDirNumTests}  ,"\n";

    return %testResults;
}

