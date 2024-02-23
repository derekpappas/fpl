#this version is for cslc directory only
#no svn revision

package mRegress;


use Switch;               # the switch/case command
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command
use POSIX;                # POSIX functions
use HTML::Template;       # Html templates
use Net::SMTP;
#use MIME::Lite; #commented on dec 6th
use strict; 
use Exporter;
use constant;
use Readonly;
use lib "$ENV{WORK}/trunk/scripts";
use FplLib;

## export the names
#
#our @ISA = qw(Exporter);
#our @EXPORT = qw(
#    regressHdl                 
#    generate_hdl_directory_list
#    getSvnRevision              
#    sortDirectories          
#    );


############################## random quotes ####################################################

Readonly::Array our @array => ( "Live long and prosper! SPOCK",
              "Feel the force Luke.",
              "Bye Bye",
              "There is no spoon...",
              "Who has the Ark. Top men are on it. FBI man to Indiana Jones",
              "A man who fears nothing is a man who loves nothing. And if you love nothing, what joy is there left in your life?",
              "Segmentation fault...just kidding",
              "A perfect blossom is a rare thing. One might spend an entire life looking for it. And it would not be a wasted life.(The Last Samurai)",
              "\"I've seen things you people wouldn't believe...Attack ships on fire off the shores of Orion...\nI watched c-beams glitter in the dark near the Tanhauser Gate.\nAll those moments will be lost...like tears in rain.\" - Roy Batty.",
"Maximus: Three weeks from now, I will be harvesting my crops.\nImagine where you will be, and it will be so. Hold the line! Stay with me!\nIf you find yourself alone, riding in the green fields with the sun on your face, \ndo not be troubled. For you are in Elysium, and you're already dead! 
[Cavalry laughs]\n 
Maximus: Brothers, what we do in life... echoes in eternity."
              );

############################## globals ####################################################

our %systemErrorMap;

$systemErrorMap{"139"} = "Exit code 139: Segmentation fault";
$systemErrorMap{"9"}   = "Exit code 9: Ran out of CPU time.";
$systemErrorMap{"64"}  = "Exit code 64: The framework ended the job nicely for you, most likely because the job was running out of CPU time. But it means you did not go through all the data requested. The solution is to submit the job to a queue with more resources (bigger CPU time limit).";
$systemErrorMap{"125"} = "Exit code 125: An ErrMsg(severe) was reached in your job.";
$systemErrorMap{"127"} = "Exit code 127: Something wrong with the machine?";
$systemErrorMap{"130"} = "Exit code 130: The job ran out of CPU or swap time. If swap time is the culprit, check for memory leaks.";
$systemErrorMap{"131"} = "Exit code 131: The job ran out of CPU or swap time. If swap time is the culprit, check for memory leaks.";
$systemErrorMap{134} = "Exit code 134: The job is killed with an abort signal, and you probably got core dumped. Often this is caused either by an assert() or an ErrMsg(fatal) being hit in your job. There may be a run-time bug in your code. Use a debugger like gdb or dbx to find out what's wrong.";
$systemErrorMap{"137"} = "Exit code 137: The job was killed because it exceeded the time limit."; 
$systemErrorMap{"140"} = "Exit code 140: The job exceeded the \"wall clock\" time limit (as opposed to the CPU time limit).";

################################################################################
# vars for  the names of the phases and status
################################################################################

Readonly::Scalar our $MINOR_ERROR    => 10;
Readonly::Scalar our $MAJOR_ERROR    => 11;
Readonly::Scalar our $VALGRIND_ERROR => 12;
                    
Readonly::Scalar our $STAGE_LEXER               => "lexer"         ;
Readonly::Scalar our $STAGE_PARSER              => "parser"        ;
Readonly::Scalar our $STAGE_WALKER              => "walker"        ;
Readonly::Scalar our $STAGE_INST_TREE           => "instance_tree" ;
Readonly::Scalar our $STAGE_AUTO_ROUTER         => "autorouter"    ;
Readonly::Scalar our $STAGE_AUTO_MAPPER         => "automapper"    ;
Readonly::Scalar our $STAGE_CSLOM_CHECKER       => "cslom_checker" ;
Readonly::Scalar our $STAGE_CSLOM_CONN_CHECKER       => "cslom_connection_checker" ;
Readonly::Scalar our $STAGE_CPP_CODE_GEN        => "cppcodegen"    ;
Readonly::Scalar our $STAGE_CSIM_CODE_GEN       => "csimcodegen"   ;
Readonly::Scalar our $STAGE_ADAPTER             => "adapter"       ;
Readonly::Scalar our $STAGE_CDOM_CHECKER        => "cdom_checker"  ;
Readonly::Scalar our $STAGE_VERILOG_CODE_GEN    => "verilogcodegen";
Readonly::Scalar our $STAGE_SYSTEM_C_CODE_GEN   => "syscodegen"    ;
Readonly::Scalar our $STAGE_VALGRIND            => "valgrind"      ;
Readonly::Scalar our $STAGE_OVERALL_STATUS      => "fileOverall"   ;
Readonly::Scalar our $STAGE_MINOR_ERROR         => "minorErrorCnt" ;
Readonly::Scalar our $STAGE_MAJOR_ERROR         => "majorErrorCnt" ;
Readonly::Scalar our $STAGE_VALGRIND_ERROR      => "valgrindErrorCnt" ;
Readonly::Scalar our $STAGE_CPHASE_PASS_PERCENT => "compilerPhasePassedPercentage";
                    
Readonly::Scalar our $STATUS_FAILED               => "failed";
Readonly::Scalar our $STATUS_PASSED               => "passed";
Readonly::Scalar our $STATUS_PASSED_WARNING       => "passed_w";
Readonly::Scalar our $STATUS_PHASE_DID_NOT_RUN    => "cpdnr";
Readonly::Scalar our $STATUS_NO_TESTS             => "no_tests";
Readonly::Scalar our $STATUS_VALGRIND_PASSED      => "vg_passed";
Readonly::Scalar our $STATUS_VALGRIND_ERROR       => "vg_error";
Readonly::Scalar our $STATUS_VALGRIND_NOT_ENABLED => "vg_not_en";
                    
Readonly::Scalar our $CSS_STATUS_FAILED             => "failed";
Readonly::Scalar our $CSS_STATUS_PASSED             => "passed";
Readonly::Scalar our $CSS_STATUS_PASSED_WARNING     => "passed_w";
Readonly::Scalar our $CSS_STATUS_PHASE_DID_NOT_RUN  => "compiler_phase_dnr";
Readonly::Scalar our $CSS_STATUS_VALGRIND_ERROR     => "valgrind_ne";
                    
Readonly::Scalar our $CSLC_COMPILE_GENERATED_VERILOG      => "verilog_code"; 
Readonly::Scalar our $GCC_COMPILE_GENERATED_SYSTEMC_CODE  => "systemc_code";
Readonly::Scalar our $GCC_COMPILE_GENERATED_CPP_CODE      => "cpp_code"    ;
Readonly::Scalar our $GCC_COMPILE_GENERATED_CSIM_CODE => "csim_code"   ;

################################################################################
# vars for tracking the status of each phase
################################################################################

Readonly::Hash our %ownerListByCompilerPhase => ( 
   $STAGE_LEXER              => 'ostolnicu\@fplsrl.com',
   $STAGE_PARSER             => 'ostolnicu\@fplsrl.com',
   $STAGE_WALKER             => 'andreib\@fplsrl.com',
   $STAGE_INST_TREE          => 'bogdanz\@fplsrl.com',
   $STAGE_AUTO_ROUTER        => 'bogdanz\@fplsrl.com',
   $STAGE_AUTO_MAPPER        => 'bogdanz\@fplsrl.com',
   $STAGE_CSLOM_CHECKER      => 'bogdanz\@fplsrl.com',
   $STAGE_CPP_CODE_GEN       => 'adrian\@fplsrl.com',
   $STAGE_CSIM_CODE_GEN      => 'adrian\@fplsrl.com',
   $STAGE_ADAPTER            => 'alinap\@fplsrl.com',
   $STAGE_CDOM_CHECKER       => 'alinap\@fplsrl.com',
   $STAGE_VERILOG_CODE_GEN   => 'andreib\@fplsrl.com',
   $STAGE_SYSTEM_C_CODE_GEN  => 'andreib\@fplsrl.com',
   $STAGE_VALGRIND           => 'bogdanz\@fplsrl.com',     
);


############################## Start script ####################################################

Readonly::Scalar our $test_start_time       => `date "+%d/%m/%G, %T"`; #getting the date and time for this regression run
Readonly::Scalar our $regression_start_time => time();
# Not on MAC OS XReadonly::Scalar our $cpu_speed             => `cat /proc/cpuinfo|grep MHz`;
# Not on MAC OS XReadonly::Scalar our $cpu_bogomips          => `cat /proc/cpuinfo|grep bogomips`; 
# Not on MAC OS XReadonly::Scalar our $cpu_model             => `cat /proc/cpuinfo|grep \"model name\"`;
Readonly::Scalar our $cpu_speed             => "no data";
Readonly::Scalar our $cpu_bogomips          => "no data";
Readonly::Scalar our $cpu_model             => "no data";
#Readonly::Array  our @mem                   => `cat /proc/meminfo|grep MemTotal` =>~ /[0-9]+/g;
#Readonly::Scalar our $total_ram             => int ($mem[0])/1024;
Readonly::Scalar our $arch                  => `arch`; #getting information about the current system

################################################################################
# set the top level directories
################################################################################

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to $ENV{WORK}/cslc";
}  
Readonly::Scalar our $totDir      => $ENV{WORK};
Readonly::Scalar our $scriptDir   => $totDir . "/trunk/scripts";
Readonly::Scalar our $testRootDir => $totDir . "/test";
&FplLib::testDirExists($totDir            );
&FplLib::testDirExists($testRootDir       );

Readonly::Scalar our $verilogTestRootDir => $testRootDir . "/verilog";
Readonly::Scalar our $reportRootDir      => $testRootDir . "/report";

################################################################################
# set the html template directory
################################################################################

Readonly::Scalar our $htmlTemplateDir => $scriptDir . "/regress_html_templates";
# print "[INFO] htmlTemplateDir = $htmlTemplateDir\n";

Readonly::Scalar our $styleCssFile => "style.css"; # style sheet used in generated Html files

Readonly::Array our @compilerPhaseList => (
$STAGE_LEXER            ,                 
$STAGE_PARSER           ,
$STAGE_WALKER           ,
$STAGE_INST_TREE        ,
$STAGE_AUTO_ROUTER      ,
$STAGE_AUTO_MAPPER      ,
$STAGE_CSLOM_CHECKER    ,
$STAGE_CSLOM_CONN_CHECKER    ,
$STAGE_CPP_CODE_GEN     ,
$STAGE_CSIM_CODE_GEN    ,
$STAGE_ADAPTER          ,
$STAGE_CDOM_CHECKER     ,
$STAGE_VERILOG_CODE_GEN ,
$STAGE_SYSTEM_C_CODE_GEN
);


#################################################################################################
#                                          regressHdl                                           #
#################################################################################################

sub regressHdl {
    my($resultsRootDir, $currentHdl, $testDirFilter, $externalArguments,$html_report) = @_;  

    # print "[INFO] regressHdl: begin currentHdl = $currentHdl \n";
   ###print "********************************\n";
 
    my $regressStatus = $STATUS_FAILED;

    my $currentHdlTotalNumTests = 0;
    my $totalNumTestsPassed     = 0;
    my $totalNumTestsFailed     = 0;
    my $currentHdlPassPercent   = 0;

    my %totalNumValidStagesPassed = (); # counters to track the total number of tests that passed each stage
    my %totalNumInvalidStagesPassed = (); # counters to track the total number of tests that passed each stage

    foreach my $stageName (@compilerPhaseList) {
        $totalNumValidStagesPassed  {$stageName} = 0;
        $totalNumInvalidStagesPassed{$stageName} = 0;
    }

    my $svn_revision = &getSvnRevision();

    my $cnt = 0;
    my $regressMajorErrorCnt = 0;
    my $regressValgrindErrorCnt = 0;
    my $regressionSummaryTemplate = 0;
###next line added for run_regress_new.pl
  if($html_report == 0) {
    $regressionSummaryTemplate = HTML::Template->new(filename =>$ htmlTemplateDir . "/summary.tmpl");
    $regressionSummaryTemplate->param(styleCss        => "../../../trunk/scripts/regress_html_templates/" . $styleCssFile   );
    $regressionSummaryTemplate->param(dateTime        => $test_start_time);
    $regressionSummaryTemplate->param(cpuName         => $cpu_model      );
    $regressionSummaryTemplate->param(svnRevision     => $svn_revision   );
    $regressionSummaryTemplate->param(cpuMhz          => $cpu_speed      );
    $regressionSummaryTemplate->param(bogomips        => $cpu_bogomips   );
#    $regressionSummaryTemplate->param(availableMemory => $total_ram      );
    $regressionSummaryTemplate->param(scriptDir       => $scriptDir      );
    $regressionSummaryTemplate->param(currentHdl      => uc($currentHdl));
 }

    my $currentHdlDirectory = "$resultsRootDir/$currentHdl";
    if ($main::externalArguments{"no_exec"} ne "") {
        &FplLib::mkDir($currentHdlDirectory);
    }

    my $totalValidNumTests         = 0;
    my $totalInvalidNumTests       = 0;
    my $totalValidNumTestsPassed   = 0;
    my $totalValidNumTestsFailed   = 0;
    my $totalInvalidNumTestsPassed = 0;
    my $totalInvalidNumTestsFailed = 0;
    my %totalGenCodeStagesPassed   = ();

    my $totalNumTests           = 0;
    my $totalPercentPassed      = 0;
#    my $totalWarningsCnt        = 0;   
    my $totalDirPercentPassed   = 0;

    my $testResults = 0;
    $totalGenCodeStagesPassed{cslcCompileVerilogCode} = 0;
    $totalGenCodeStagesPassed{gccCompileSystemCCode } = 0;
    $totalGenCodeStagesPassed{gccCompileCppCode     } = 0;
    $totalGenCodeStagesPassed{gccCompileCsimCode    } = 0;

    my @loop = ();

    my @test_dir_list = &generate_hdl_directory_list($currentHdl, $testDirFilter);

    # sort by valid/invalid
    my @sorted_test_dir_list = &sortDirectories(\@test_dir_list);
    foreach my $currentTestDirectory ( @sorted_test_dir_list ) {
        print "Executing tests in the $currentTestDirectory directory\n";

        print "[INFO] regressHdl: begin currentTestDirectory = $currentTestDirectory \n";
        my $resultsTestDirectory = "$currentHdlDirectory/$currentTestDirectory";

        if ($main::externalArguments{"no_exec"}) {
            &FplLib::mkDir($resultsTestDirectory);
        }
        my $testListSummaryFileWithOutHtmlExt = 0;
###next line added for run_regress_new.pl
        if($html_report == 0) {
            $testListSummaryFileWithOutHtmlExt = "$currentHdl/$currentTestDirectory/$currentHdl" ."_" . "$currentTestDirectory" . "_" . "regression_summary"; 
        }       
        my %testResults = &main::regressDir($resultsRootDir, $currentTestDirectory, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdl, $currentHdlDirectory);

        #foreach my $k (keys %testResults) {
        #    print "testResults{$k} = $testResults{$k}\n";
        #}

        $regressMajorErrorCnt    += $testResults{totalDirMajorErrorCnt};
        $regressValgrindErrorCnt += $testResults{totalDirValgrindErrorCnt};

        if ($testResults{totalDirNumTests} > 0) {
            my $percentage      = ($testResults{totalDirNumTestsPassed}/$testResults{totalDirNumTests}) * 100;
            $totalDirPercentPassed = sprintf( "%3d%", $percentage);
            $testResults{totalDirPercentPassed } = $totalDirPercentPassed;
        }
        else {
            $testResults{totalDirPercentPassed } = $STATUS_NO_TESTS;;
        } 
        my $directoryStatusCSS = $testResults{totalDirNumTests} > 0 
            ? 0 == $testResults{totalDirMajorErrorCnt} && 0 == $testResults{totalDirValgrindErrorCnt} && (100 == $totalDirPercentPassed) 
            ? $STATUS_PASSED 
            : $STATUS_FAILED 
        : $STATUS_NO_TESTS;


        my $numStagesPassed = $testResults{numStagesPassed};

        #print "numStagesPassed = $numStagesPassed\n";

        #foreach my $k (keys %{$numStagesPassed}) {
        #foreach my $k (@compilerPhaseList) {
        #    print "XXX numStagesPassed{$k} = ", $numStagesPassed->{$k},"\n";
        #}

        my $numCslcCompileVerilogCode = $numStagesPassed->{cslcCompileVerilogCode};
        my $numGccCompileCppCode      = $numStagesPassed->{gccCompileCppCode     };
        my $numGccCompileCsimCode     = $numStagesPassed->{gccCompileCsimCode    };
        my $numGccCompileSystemCCode  = $numStagesPassed->{gccCompileSystemCCode };

        my $cslcCompileVerilogCodeStatus = "failed";
        my $gccCompileCppCodeStatus      = "failed";
        my $gccCompileCsimCodeStatus     = "failed";
        my $gccCompileSystemCCodeStatus  = "failed";

        if ( $numCslcCompileVerilogCode == $testResults{totalDirNumTests} ) { $cslcCompileVerilogCodeStatus = "passed"; }
        if ( $numGccCompileCppCode      == $testResults{totalDirNumTests} ) { $gccCompileCppCodeStatus      = "passed"; }
        if ( $numGccCompileCsimCode     == $testResults{totalDirNumTests} ) { $gccCompileCsimCodeStatus     = "passed"; }
        if ( $numGccCompileSystemCCode  == $testResults{totalDirNumTests} ) { $gccCompileSystemCCodeStatus  = "passed"; }

        my %row=(currentTestDirectory     => $currentTestDirectory,
                 currentHdl               => uc($currentHdl)          ,
                 testListSummaryFile      => "$testListSummaryFileWithOutHtmlExt" . "_0.html",
                 totalDirNumTests         => $testResults{totalDirNumTests        },
                 totalDirNumTestsPassed   => $testResults{totalDirNumTestsPassed  },
                 totalDirNumTestsFailed   => $testResults{totalDirNumTests        } - $testResults{totalDirNumTestsPassed }, 
                 totalDirMajorErrorCnt    => $testResults{totalDirMajorErrorCnt   },
                 totalDirValgrindErrorCnt => $testResults{totalDirValgrindErrorCnt},
                 totalDirPercentPassed    => $testResults{totalDirPercentPassed   },
                 overall                  => $directoryStatusCSS,
                 directoryStatusCSS       => $directoryStatusCSS,
                 totalDirCslcCompVerilogCodeStagesPassed => $numCslcCompileVerilogCode,
                 totalDirGccCompCppCodeStagesPassed      => $numGccCompileCppCode     ,
                 totalDirGccCompCsimCodeStagesPassed     => $numGccCompileCsimCode    ,
                 totalDirGccCompSystemCCodeStagesPassed  => $numGccCompileSystemCCode ,

                 totalCslcCompVerilogCodeStagesPassedCSS =>  $cslcCompileVerilogCodeStatus ,
                 totalGccCompCppCodeStagesPassedCSS      =>  $gccCompileCppCodeStatus      ,
                 totalGccCompCsimCodeStagesPassedCSS     =>  $gccCompileCsimCodeStatus     ,
                 totalGccCompSystemCCodeStagesPassedCSS  =>  $gccCompileSystemCCodeStatus  ,
                 );


        $totalGenCodeStagesPassed{cslcCompileVerilogCode} += $numStagesPassed->{cslcCompileVerilogCode};
        $totalGenCodeStagesPassed{gccCompileCppCode     } += $numStagesPassed->{gccCompileCppCode     };
        $totalGenCodeStagesPassed{gccCompileCsimCode    } += $numStagesPassed->{gccCompileCsimCode    };
        $totalGenCodeStagesPassed{gccCompileSystemCCode } += $numStagesPassed->{gccCompileSystemCCode };



        $totalNumTests       += $testResults{totalDirNumTests      };
#        $totalWarningsCnt    += $testResults{totalDirWarningsCnt   };
        $totalNumTestsPassed += $testResults{totalDirNumTestsPassed};
        if ($currentTestDirectory =~ m/invalid/i) { 
            $totalInvalidNumTests       += $testResults{totalDirNumTests}; 
            $totalInvalidNumTestsPassed += $testResults{totalDirNumTestsPassed} ;  
        }
        else { 
            $totalValidNumTests       += $testResults{totalDirNumTests}; 
            $totalValidNumTestsPassed += $testResults{totalDirNumTestsPassed} ; 
        }       

        my $dir_has_tests = ($testResults{totalDirNumTests} > 0) ? 1 : 0;

        foreach my $stageName (@compilerPhaseList) {
            my $s0 = $stageName . "Status";
            my $s1 = $stageName . "StagePassedCnt";
            my $numTestsPassedStage = $numStagesPassed->{$s0}; # save the number of tests which passed this stage
            $row{$s1} = $dir_has_tests ? $numTestsPassedStage : $STATUS_NO_TESTS;
            my $percentage = 0;
            my $formattedPercentage = "";
            if ( $testResults{totalDirNumTests} > 0) {
                $percentage = ($numTestsPassedStage/$testResults{totalDirNumTests})*100;
                $formattedPercentage = sprintf( "%5d%", $percentage);
            }
            else {
                $formattedPercentage = $STATUS_NO_TESTS;;
            } 
            my $s2 = $stageName . "StagePassedPercentage"; # save the percentage of tests which passed this stage
            $row{$s2} = $dir_has_tests ? $formattedPercentage : $STATUS_NO_TESTS;

            #print "COMPARE $numTestsPassedStage == $testResults{totalDirNumTests}\n";

            my $stagePassed = $numTestsPassedStage == $testResults{totalDirNumTests} ? 1 : 0;
            my $stageStatus = $stagePassed ? $STATUS_PASSED : $STATUS_FAILED;
            if (0 == $testResults{totalDirNumTests}) { $stageStatus = $STATUS_FAILED; }
            my $s3 = $stageName . "StatusCSS";
            if ($currentTestDirectory =~ m/invalid/i) {
                $totalNumInvalidStagesPassed{$stageName} += $numTestsPassedStage; # add the number of tested which passed this stage to the regress total cnter
            }
            else {
                $totalNumValidStagesPassed{$stageName} += $numTestsPassedStage; # add the number of tested which passed this stage to the regress total cnter
            }

            $row{$s3} = $dir_has_tests ? $stageStatus : $STATUS_NO_TESTS;
        }
        if ($main::include_empty_dirs ne "") { # if the exclude flag is set and the dir has test add the new exclude directory 
            push(@loop,\%row);
        }
        else {
            if ($dir_has_tests) {
                push(@loop,\%row);  
            }
            else {
                print "Excluded directory = $currentTestDirectory because it is empty\n";
            }
        }
    }

    my $totalValidPercentPassed = 0;
    my $percentage = 0;
    if ($totalValidNumTests > 0 ) {
        $percentage = ($totalValidNumTestsPassed/$totalValidNumTests)*100;   
        $totalValidPercentPassed = sprintf( "%5d%", $percentage);
    }   
    else {
        $totalValidPercentPassed = $STATUS_NO_TESTS;
    }    
    my $overallValidStatusCSS   = ($totalValidNumTests > 0) ? ((100 == $totalValidPercentPassed) ? $STATUS_PASSED : $STATUS_FAILED) : $STATUS_NO_TESTS;

    my $totalInvalidPercentPassed = 0;
    if ($totalInvalidNumTests > 0 ) {
        $percentage = ($totalInvalidNumTestsPassed/$totalInvalidNumTests)*100;   
        $totalInvalidPercentPassed = sprintf( "%5d%", $percentage);
    }       
    else {
        $totalInvalidPercentPassed = $STATUS_NO_TESTS;
    }    
    my $overallInvalidStatusCSS = ($totalInvalidNumTests > 0) ? ((100 == $totalInvalidPercentPassed) ? $STATUS_PASSED : $STATUS_FAILED) : $STATUS_NO_TESTS;

    if ($totalNumTests) { 
        $percentage = ($totalNumTestsPassed/$totalNumTests)*100;
        $totalPercentPassed = sprintf( "%5d%", $percentage);
    }
    else {
        $totalPercentPassed = $STATUS_NO_TESTS;
    }    

    my $select =  (0 == $regressMajorErrorCnt) && (0 == $regressValgrindErrorCnt) && (100 == $totalPercentPassed) ;
 
    my $overallStatusCSS = ($totalPercentPassed > 0) ? ($select
           ? $STATUS_PASSED 
           : $STATUS_FAILED) 
        : $STATUS_NO_TESTS;

    $regressStatus = $overallStatusCSS;

    $totalNumTestsFailed = $totalNumTests - $totalNumTestsPassed;
###next line added for run_regress_new.pl
  if($html_report == 0) {
    $regressionSummaryTemplate->param(testDirStatusLoop     => \@loop                  );
    $regressionSummaryTemplate->param(totalNumTests         => $totalNumTests          );
    $regressionSummaryTemplate->param(totalNumTestsPassed   => $totalNumTestsPassed    );
    $regressionSummaryTemplate->param(totalNumTestsFailed   => $totalNumTestsFailed    );
    $regressionSummaryTemplate->param(totalMajorErrorCnt    => $regressMajorErrorCnt   );
    $regressionSummaryTemplate->param(totalValgrindErrorCnt => $regressValgrindErrorCnt);
    $regressionSummaryTemplate->param(totalPercentPassed    => $totalPercentPassed     );
    $regressionSummaryTemplate->param(totalOverall          => $overallStatusCSS       );
    $regressionSummaryTemplate->param(overallStatusCSS      => $overallStatusCSS       );

    $totalValidNumTestsFailed = $totalValidNumTests - $totalValidNumTestsPassed;
    $regressionSummaryTemplate->param(totalValNumTests          => $totalValidNumTests        );
    $regressionSummaryTemplate->param(totalValNumTestsPassed    => $totalValidNumTestsPassed  );
    $regressionSummaryTemplate->param(totalValNumTestsFailed    => $totalValidNumTestsFailed  );
    $regressionSummaryTemplate->param(totalValPercentPassed     => $totalValidPercentPassed   );
    $regressionSummaryTemplate->param(totalValOverall           => $overallValidStatusCSS     );
    $regressionSummaryTemplate->param(overallValStatusCSS       => $overallValidStatusCSS     );

    $totalInvalidNumTestsFailed = $totalInvalidNumTests - $totalInvalidNumTestsPassed;
    $regressionSummaryTemplate->param(totalInvNumTests        => $totalInvalidNumTests      );
    $regressionSummaryTemplate->param(totalInvNumTestsPassed  => $totalInvalidNumTestsPassed);
    $regressionSummaryTemplate->param(totalInvNumTestsFailed  => $totalInvalidNumTestsFailed);
    $regressionSummaryTemplate->param(totalInvPercentPassed   => $totalInvalidPercentPassed );
    $regressionSummaryTemplate->param(totalInvOverall         => $overallInvalidStatusCSS   );
    $regressionSummaryTemplate->param(overallInvStatusCSS     => $overallInvalidStatusCSS   );

    $regressionSummaryTemplate->param( totalCslcCompVerilogCodeStagesPassed  =>  $totalGenCodeStagesPassed{cslcCompileVerilogCode}  );
    $regressionSummaryTemplate->param( totalGccCompCppCodeStagesPassed       =>  $totalGenCodeStagesPassed{gccCompileCppCode     }  );
    $regressionSummaryTemplate->param( totalGccCompCsimCodeStagesPassed      =>  $totalGenCodeStagesPassed{gccCompileCsimCode    }  );
    $regressionSummaryTemplate->param( totalGccCompSystemCCodeStagesPassed   =>  $totalGenCodeStagesPassed{gccCompileSystemCCode }  );
}
    my $cslcCompileVerilogCodeStatus = "failed";
    my $gccCompileCppCodeStatus      = "failed";
    my $gccCompileCsimCodeStatus     = "failed";
    my $gccCompileSystemCCodeStatus  = "failed";

    if ( $totalGenCodeStagesPassed{cslcCompileVerilogCode} == $totalNumTests ) { $cslcCompileVerilogCodeStatus = "passed"; }
    if ( $totalGenCodeStagesPassed{gccCompileCppCode     } == $totalNumTests ) { $gccCompileCppCodeStatus      = "passed"; }
    if ( $totalGenCodeStagesPassed{gccCompileCsimCode    } == $totalNumTests ) { $gccCompileCsimCodeStatus     = "passed"; }
    if ( $totalGenCodeStagesPassed{gccCompileSystemCCode } == $totalNumTests ) { $gccCompileSystemCCodeStatus  = "passed"; }
###next line added for run_regress_new.pl
  if($html_report == 0) {
    $regressionSummaryTemplate->param( totalCslcCompVerilogCodeStagesPassedCSS =>  $cslcCompileVerilogCodeStatus );
    $regressionSummaryTemplate->param( totalGccCompCppCodeStagesPassedCSS      =>  $gccCompileCppCodeStatus      );
    $regressionSummaryTemplate->param( totalGccCompCsimCodeStagesPassedCSS     =>  $gccCompileCsimCodeStatus     );
    $regressionSummaryTemplate->param( totalGccCompSystemCCodeStagesPassedCSS  =>  $gccCompileSystemCCodeStatus  );
}
    foreach my $stageName (@compilerPhaseList) {
        my $totalNumValInvTests  = 0;
        my $totalNumStagesPassed = 0;

        foreach my $val_inv (("Val", "Inv")) {
            if ($val_inv eq "Val") {
                $totalNumStagesPassed = $totalNumValidStagesPassed{$stageName};
                $totalNumValInvTests  = $totalValidNumTests;
            }
            else {
                $totalNumStagesPassed = $totalNumInvalidStagesPassed{$stageName};
                $totalNumValInvTests  = $totalInvalidNumTests;
            }
            my $s = $stageName . "StageTotal" . "$val_inv" . "PassCnt";
###next line added for run_regress_new.pl
  if($html_report == 0) {
            $regressionSummaryTemplate->param($s => ($totalNumValInvTests > 0 ? $totalNumStagesPassed : $STATUS_NO_TESTS));
        }

            $percentage = 0;
            if ($totalNumValInvTests > 0) {
                $percentage = ($totalNumStagesPassed/$totalNumValInvTests)*100;
            }
            my $formattedPercentage = ($totalNumValInvTests > 0) ? sprintf( "%5d%", $percentage) : $STATUS_NO_TESTS;
            my $s2 = $stageName . "StageTotal" . "$val_inv" . "PassPercent"; # save the percentage of tests which passed this stage
###next line added for run_regress_new.pl
  if($html_report == 0) {
            $regressionSummaryTemplate->param($s2 => $formattedPercentage);
        }
            my $s3 = $stageName . "Overall" . "$val_inv" . "StatusCSS";
            my $stagePassed = $totalNumStagesPassed == $totalNumValInvTests ? 1 : 0;
            my $stageStatus = ($totalNumValInvTests > 0) ? ($stagePassed ? $STATUS_PASSED : $STATUS_FAILED) : $STATUS_NO_TESTS;
###next line added for run_regress_new.pl
  if($html_report == 0) {
            $regressionSummaryTemplate->param($s3 => $stageStatus);
        }
        }
    }
    my $regression_finish_time  = time(); #statistics on the time elapsed from the start of the regression until it's end
    my $regression_elapsed_time = $regression_finish_time - $regression_start_time;
    my $regression_day          = int $regression_elapsed_time/86400;
    my $regression_hour         = int $regression_elapsed_time%86400/3600;
    my $regression_min          = int $regression_elapsed_time%3600/60;
    my $regression_sec          = $regression_elapsed_time-$regression_day*86400-$regression_hour*3600-$regression_min*60;

    my $regressionSummaryHtmlFile = 0;
###next line added for run_regress_new.pl
  if($html_report == 0) {
    $regressionSummaryTemplate->param( regression_elapsed_time => $regression_elapsed_time        );

#FIX    if($signalName){ print("\nREGRESSION DIDN'T COMPLETE ! \n"); }
#FIX    else           {  print("REGRESSION DONE !\n"             ); }
    $regressionSummaryHtmlFile = "$currentHdlDirectory" . "_regression_summary.html";

    # print "regressionSummaryHtmlFile = $regressionSummaryHtmlFile\n";
    open(SF, "> $regressionSummaryHtmlFile");
    print SF $regressionSummaryTemplate->output;
    close(SF);
}
    my $sum =  "$currentHdlDirectory" . "_all_summary.txt"; # file with the summary for all tests
    if($html_report != 0) {
  
        open(SUM_FILE,"> $sum") or die ("[ERROR] check_results: Error opening summary file !\n");
        print SUM_FILE "overallStatusCSS = $overallStatusCSS\n";
        print SUM_FILE "totalNumTests = $totalNumTests\n";
        print SUM_FILE "totalNumTestsPassed = $totalNumTestsPassed\n";
        print SUM_FILE "totalNumTestsFailed = $totalNumTestsFailed\n";
        print SUM_FILE "regressMajorErrorCnt = $regressMajorErrorCnt\n";
        print SUM_FILE "regressValgrindErrorCnt = $regressValgrindErrorCnt\n";
        print SUM_FILE "totalPercentPassed = $totalPercentPassed\n";
        close SUM_FILE;
    }

    # print "[INFO] RESULTS DIRECTORY: $regressionSummaryHtmlFile\n";

    # print "[INFO] regressHdl: end\n";

    return $regressStatus;
}

#################################################################################################
#                                          generate_hdl_directory_list                             #
#subroutine that generates the regression list file                                             #
#################################################################################################

sub generate_hdl_directory_list {
    my($currentHdl, $testDirFilter) = @_; #geting the source directory
#    print "[INFO] generate_hdl_directory_list begin\n";
#    print "testDirFilter = $testDirFilter\n\n";

    my @directoryList = ();

    if ($testDirFilter eq "") {
        my $topHdlDir = $testRootDir . "/$currentHdl";
#        print "topHdlDir = $topHdlDir\n";
        my $ls_cmd    = "ls $topHdlDir"; #select only the regular files from the current tests dir
#        print "[INFO] generate_hdl_directory_list ls_cmd = $ls_cmd\n";
        my $directoryList = `$ls_cmd`;
#        print "[INFO] generate_hdl_directory_list = $directoryList\n";
        @directoryList = split(/\n/, $directoryList);
#        print "[INFO] generate_hdl_directory_list = @directoryList\n";

        chomp(@directoryList); # get rid of '\n'
    }
    else {
        push(@directoryList, $testDirFilter);
    }

#    print "[INFO] generate_hdl_directory_list: directoryList = ", @directoryList, "\n";
#    print "[INFO] generate_hdl_directory_list: end\n";
    return @directoryList;
}

################################################################################
# 
################################################################################

sub getSvnRevision {
    my $revision = "";

    my $svnInfo = `cd $ENV{WORK} && svn info`;

    #print "svnInfo = $svnInfo\n";

    if ($svnInfo =~ m/Revision: (\d+)/) {
        $revision = $1;
    }
    else {
        die "[ERROR] Could not find the SVN revision\n";
    }

    return $revision;
}

################################################################################
#sort the directories first by invalid/other
#then alphabetically
################################################################################

sub sortDirectories {
    my ($test_dir_list) = @_;
    my @test_dir_list = @{$test_dir_list};

    my @sorted_test_invalid_dir_list;
    my @sorted_test_valid_dir_list;
    my @sorted_test_dir_list;

    foreach my $dir ( @test_dir_list ) {
        if ($dir =~ m/invalid/) { push (@sorted_test_invalid_dir_list, $dir); }
        else                    { push (@sorted_test_valid_dir_list  , $dir); }   
    }

    push (@sorted_test_dir_list, @sorted_test_valid_dir_list  );
    push (@sorted_test_dir_list, @sorted_test_invalid_dir_list);

#    foreach $dir ( @sorted_test_dir_list ) {
#        print "dir = $dir\n";
#    }
#    exit;
    return @sorted_test_dir_list;
}

################################################################################
# do not edit below this line
# file must return true
################################################################################

1; 
