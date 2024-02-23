#!/usr/bin/perl
#Maintainers(s): Ines and Petronela and Derek

use Switch;               # the switch/case command
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command
use POSIX;                # POSIX functions
use HTML::Template;       # Html templates
use Net::SMTP;
use MIME::Lite;

# use strict; 
# FIX uncomment and fix errors
# name the variables with explicit names !! (long names if necessary)

my $maintainer  ="Petronela E. and Ines C. and Derek"; #put your name here if you are the current maintainer of this script
my $myVersion   = "0.4";
my $signalName  = "";
#my $wgs         = 0; # Total no of warnings
my $results_dir = "";

############################## random quotes ####################################################

my @array = ( "Live long and prosper! SPOCK",
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
Maximus: Brothers, what we do in life... echoes in eternity.",

              );

############################## globals ####################################################

%systemErrorMap;

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

my $MINOR_ERROR    = 10;
my $MAJOR_ERROR    = 11;
my $VALGRIND_ERROR = 12;

my $LEXER_STAGE               = "lexer"         ;
my $PARSER_STAGE              = "parser"        ;
my $WALKER_STAGE              = "walker"        ;
my $INST_TREE_STAGE           = "instance_tree" ;
my $AUTO_ROUTER_STAGE         = "autorouter"    ;
my $AUTO_MAPPER_STAGE         = "automapper"    ;
my $CSLOM_CHECKER_STAGE       = "cslom_checker" ;
my $CPP_CODE_GEN_STAGE        = "cppcodegen"    ;
my $CSIM_CODE_GEN_STAGE       = "csimcodegen"   ;
my $ADAPTER_STAGE             = "adapter"       ;
my $CDOM_CHECKER_STAGE        = "cdom_checker"  ;
my $VERILOG_CODE_GEN_STAGE    = "verilogcodegen";
my $SYSTEM_C_CODE_GEN_STAGE   = "syscodegen"    ;
my $VALGRIND_STAGE            = "valgrind"      ;
my $OVERALL_STATUS_STAGE      = "fileOverall"   ;
my $MINOR_ERROR_STAGE         = "minorErrorCnt" ;
my $MAJOR_ERROR_STAGE         = "majorErrorCnt" ;
my $VALGRIND_ERROR_STAGE      = "valgrindErrorCnt" ;
my $CPHASE_PASS_PERCENT_STAGE = "compilerPhasePassedPercentage";

my $STATUS_FAILED               = "failed";
my $STATUS_PASSED               = "passed";
my $STATUS_PASSED_WARNING       = "passed_w";
my $STATUS_PHASE_DID_NOT_RUN    = "cpdnr";
my $STATUS_NO_TESTS             = "no_tests";
my $STATUS_VALGRIND_PASSED      = "vg_passed";
my $STATUS_VALGRIND_ERROR       = "vg_error";
my $STATUS_VALGRIND_NOT_ENABLED = "vg_not_en";

my $CSS_STATUS_FAILED             = "failed";
my $CSS_STATUS_PASSED             = "passed";
my $CSS_STATUS_PASSED_WARNING     = "passed_w";
my $CSS_STATUS_PHASE_DID_NOT_RUN  = "compiler_phase_dnr";
my $CSS_STATUS_VALGRIND_ERROR     = "valgrind_ne";

my $CSLC_COMPILE_GENERATED_VERILOG      = "verilog_code"; 
my $GCC_COMPILE_GENERATED_SYSTEMC_CODE  = "systemc_code";
my $GCC_COMPILE_GENERATED_CPP_CODE      = "cpp_code"    ;
my $GCC_COMPILE_GENERATED_CSIM_CODE = "csim_code"   ;

################################################################################
# vars for tracking the status of each phase
################################################################################

my %ownerListByCompilerPhase = ( 
   $LEXER_STAGE              => 'ostolnicu@fplsrl.com',
   $PARSER_STAGE             => 'ostolnicu@fplsrl.com',
   $WALKER_STAGE             => 'andreib@fplsrl.com',
   $INST_TREE_STAGE          => 'bogdanz@fplsrl.com',
   $AUTO_ROUTER_STAGE        => 'bogdanz@fplsrl.com',
   $AUTO_MAPPER_STAGE        => 'bogdanz@fplsrl.com',
   $CSLOM_CHECKER_STAGE      => 'bogdanz@fplsrl.com',
   $CPP_CODE_GEN_STAGE       => 'adrian@fplsrl.com',
   $CSIM_CODE_GEN_STAGE      => 'adrian@fplsrl.com',
   $ADAPTER_STAGE            => 'alinap@fplsrl.com',
   $CDOM_CHECKER_STAGE       => 'alinap@fplsrl.com',
   $VERILOG_CODE_GEN_STAGE   => 'andreib@fplsrl.com',
   $SYSTEM_C_CODE_GEN_STAGE  => 'andreib@fplsrl.com',
   $VALGRIND_STAGE           => 'bogdanz@fplsrl.com',     
);

@lexer_stage             = {};
@parser_stage            = {};
@walker_stage            = {};
@inst_tree_stage         = {};
@auto_router_stage       = {};
@auto_mapper_stage       = {};
@cslom_checker_stage     = {};
@cpp_code_gen_stage      = {};
@csim_code_gen_stage     = {};
@adapter_stage           = {};
@cdom_checker_stage      = {};
@verilog_code_gen_stage  = {};
@system_c_code_gen_stage = {};
@valgrind_stage          = {};

my %errorListByCompilerPhase = (
 $LEXER_STAGE              => \@lexer_stage            ,
 $PARSER_STAGE             => \@parser_stage           ,
 $WALKER_STAGE             => \@walker_stage           ,
 $INST_TREE_STAGE          => \@inst_tree_stage        ,
 $AUTO_ROUTER_STAGE        => \@auto_router_stage      ,
 $AUTO_MAPPER_STAGE        => \@auto_mapper_stage      ,
 $CSLOM_CHECKER_STAGE      => \@cslom_checker_stage    ,
 $CPP_CODE_GEN_STAGE       => \@cpp_code_gen_stage     ,
 $CSIM_CODE_GEN_STAGE      => \@csim_code_gen_stage    ,
 $ADAPTER_STAGE            => \@adapter_stage          ,
 $CDOM_CHECKER_STAGE       => \@cdom_checker_stage     ,
 $VERILOG_CODE_GEN_STAGE   => \@verilog_code_gen_stage ,
 $SYSTEM_C_CODE_GEN_STAGE  => \@system_c_code_gen_stage,
 $VALGRIND_STAGE           => \@valgrind_stage         ,    
);

############################## Start script ####################################################

my $test_date_start      = `date "+%d/%m/%G, %T"`; #getting the date and time for this regression run
my $regression_start_time= time();
my $cpu_speed            = `cat /proc/cpuinfo|grep MHz`;
my $cpu_bogomips         = `cat /proc/cpuinfo|grep bogomips`; 
my $cpu_model            = `cat /proc/cpuinfo|grep \"model name\"`;
my @mem                  = `cat /proc/meminfo|grep MemTotal` =~ /[0-9]+/g;
my $total_ram            = int @mem[0]/1024;
chomp( my $arch  = `arch` ); #getting information about the current system

################################################################################
# set the top level directories
################################################################################

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to $TOT/cslc";
}  
$totDir             = $ENV{WORK};
$scriptDir          = "$totDir/trunk/scripts";
$testRootDir        = "$totDir/test";
&testDirExists($totDir            );
&testDirExists($testRootDir       );

my $cslTestRootDir    ; 
my $verilogTestRootDir;
my $reportRootDir     ; 

################################################################################
# set the html template directory
################################################################################

$htmlTemplateDir = "$scriptDir/regress_html_templates";
# print "[INFO] htmlTemplateDir = $htmlTemplateDir\n";

$styleCssFile = "style.css"; # style sheet used in generated Html files

#TODO: modify the next line so that is platform independent (can be run on x86_32 too etc.)
chomp( my $arch  = `arch` ); #getting information about the current system

&display_message( "[INFO] Your system architecture is: $arch\n");
if($arch ne 'i686' and $arch ne 'x86_64') {
    die "[ERROR] initGeneral: Your architecture $arch is not supported by this script. Only  Linux x86_64 and x86_32 are supported.\n";
}

$buildDir = "$totDir/trunk/build/linux/$arch";
$cslcExec = "$buildDir/cslc/cslc";              # cslc executable
&testFileExists($cslcExec);

my @compilerPhaseList = ($LEXER_STAGE,$PARSER_STAGE,$WALKER_STAGE,$INST_TREE_STAGE,$AUTO_ROUTER_STAGE,$AUTO_MAPPER_STAGE,$CSLOM_CHECKER_STAGE,$CPP_CODE_GEN_STAGE,$CSIM_CODE_GEN_STAGE,$ADAPTER_STAGE,$CDOM_CHECKER_STAGE,$VERILOG_CODE_GEN_STAGE,$SYSTEM_C_CODE_GEN_STAGE);
&main();

################################################################################

sub main {
    &initSignal($test_start_time,$totalPercentPassed); 

    %externalArguments = &processExternalArgs();           #testing if the arguments are correct and if so then they are processed


    $cslTestRootDir     = "$testRootDir/$externalArguments{hdlExtParam}";

    print "cslTestRootDir = $cslTestRootDir\n";
    
    $verilogTestRootDir = "$testRootDir/verilog";
    $reportRootDir      = "$testRootDir/report";

    &testDirExists($cslTestRootDir    );
    &testDirExists($verilogTestRootDir);
    &testDirExists($reportRootDir     );

    ################################################################################
    # set the current regression directories
    # create a new results directory for each new regression
    ################################################################################
    
    if ($externalArguments{results_dir} eq "" ) {
        chomp (my $results_date = `date "+%d.%m.%G_%T"`);
        $results_date =~ s/(:)/_/g;
        $resultsRootDir = "$reportRootDir/results_". $results_date;     #the results directory
        print "[INFO] Created resultsDir = $resultsRootDir \n";
        `mkdir $resultsRootDir`;
    }
    else {
        $resultsRootDir = $externalArguments{results_dir};                           #the results directory
        if ($externalArguments{no_execute} eq "") {
            &mkDir($resultsRootDir);
            print "[INFO] Created resultsDir = $resultsRootDir because  -results_dir is set no_execute = $externalArguments{no_execute}\n";
        }
        else {
            if(-d $resultsRootDir ) {  print "[INFO] User set resultsDir = $resultsRootDir no_execute = $externalArguments{no_execute}\n"; }
            else { die "[ERROR] -no_exec set and -results_dir called with directory $resultsRootDir which does not exist\n";}
        }
    }       
    
    &testAllDependencies();

    if( $externalArguments{hdlExtParam} eq all ) {
        die "[EXIT] -hdl all is deprecated only -hdl csl or -hdl csl_v2 or -hdl verilog are allowed\n";
    }

    my $currentHdl = $externalArguments{hdlExtParam};
    print("[INFO] current HDL language: $currentHdl\n");

    my $status = "Did not run any tests";

    if($externalArguments{hdlExtParam}) {
        $testDirFilter = $externalArguments{dir_filter};
        $status = &regressHdl( $currentHdl, $testDirFilter );
    }
    else {
        # print "[ERROR] no -hdl arg specified on the command line";
    } 
    &postProcess($currentHdl, $status);


}

#################################################################################################
#                                          processExternalArgs                                  #
#subroutine for processing the external arguments                                               #
#################################################################################################

sub processExternalArgs {
    use Getopt::Long;

    # print "[INFO] processExternalArgs: begin \n";

    if( @ARGV==0 ) {&usage();  die("[ERROR] processExternalArgs: Invalid use of this script.\n"); }

#with =s it gets the string from the command line
#without =s it sets the value to 1 if -myOption is typed or to 0 otherwise
    $argument = GetOptions(
                           'h'                   => \$help             , 
                           'help'                => \$help             , 
                           'version'             => \$version          ,
                           'v'                   => \$verbose          , 
                           'hdl:s'               => \$hdlExtParam      ,
                           'msg:s'               => \$exitMsg          ,
                           'val'                 => \$enableValgrind   ,
                           'no_exec'             => \$no_execute       ,
                           'results_dir:s'       => \$results_dir      ,
                           'www'                 => \$firefox          ,
                           'mail'                => \$mail             ,
                           'dir_filter:s'        => \$testDirFilter    ,
                           'errors_only'         => \$errorsOnly       ,
                           'major_errors_only'   => \$majorErrorsOnly  ,
                           'no_post_compile'     => \$noPostCompile    ,
                           'no_post_compile_cpp' => \$noPostCompileCpp    ,
                           'no_post_compile_systemc' => \$noPostCompileSystemC    ,
                           'include_empty_dirs'  => \$include_empty_dirs
                           );

    print "hdlExtParam = $hdlExtParam\n";

    my %externalArguments = ( 
                              "h"                   => $help             ,
                              "help"                => $help             ,
                              "version"             => $version          ,
                              "v"                   => $verbose          ,
                              "hdlExtParam"         => $hdlExtParam      , 
                              "exitMsg"             => $exitMsg          , 
                              "enableValgrind"      => $enableValgrind   , 
                              "no_execute"          => $no_execute       , 
                              "results_dir"         => $results_dir      , 
                              "firefox"             => $firefox          , 
                              "mail"                => $mail             ,
                              "dir_filter"          => $testDirFilter    , 
                              "errors_only"         => $errorsOnly       ,
                              "major_errors_only"   => $majorErrorsOnly  ,
                              "no_post_compile"     => $noPostCompile    ,
                              "no_post_compile_cpp" => $noPostCompileCpp    ,
                              "no_post_compile_systemc" => $noPostCompileSystemC,
                              "include_empty_dirs"  => $include_empty_dirs
                              );
    if($argument == ""){
        &usage();  
        die("[ERROR] processExternalArgs: Invalid use of this script. Type -h for details\n");
    }
    
    if($hdlExtParam eq ""){
        &usage();  
        die("[ERROR] processExternalArgs: -hdl arg must be set. Type -h for details\n");
    }

    #if there is any argument left unfiltered (after filtering the options in the lines above) then it is an invalid use of the script
    unless( @ARGV==0 ) { die("[ERROR] processExternalArgs: Invalid argument. Type -h for details\n"); }

    if( $help ) {
        &usage();  
        exit;
    } 

    if ( $version ) {
        print"[EXIT] FPL Regression Parser - VERSION: $myVersion\nCurrent maintainer: $maintainer. Type -h for help usage information.\n";
        exit;
    } 

    if(! (&isCslHdlArg($hdlExtParam) || $hdlExtParam eq "verilog") ) {
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
#                                          testAllDependencies                                  #
##subroutine for testing if dependencies are met                                                #
#################################################################################################

sub testAllDependencies {
    # print "[INFO] testAllDependencies: begin \n";

    &testDependencies($cslcExec);
    &testDependencies("/usr/bin/valgrind");
    # print ( "[INFO] All the binary files were found\n");
    # print "[INFO] testAllDependencies: end \n";
}

#################################################################################################
#                                     testDependencies                                          #
#subroutine for testing dependencies                                                            #
#################################################################################################

sub testDependencies {
    my $binary=$_[0];
    # print "[INFO] testDependencies: begin \n";

    if( !(-e $binary) ) {
        print("no\n");
        # print "REGRESSION STOPPED binary $binary not found !\n";
        exit;
    }
    else {
        return 1;
    } 
    # print "[INFO] testDependencies: end \n";
}

#################################################################################################
#                                          regressHdl                                           #
#################################################################################################

sub regressHdl {
    my($currentHdl, $testDirFilter) = @_;  

    # print "[INFO] regressHdl: begin currentHdl = $currentHdl \n";
    my $regressStatus = $STATUS_FAILED;

    $currentHdlTotalNumTests = 0;
    $totalNumTestsPassed     = 0;
    $totalNumTestsFailed     = 0;
    $currentHdlPassPercent   = 0;

    my %totalNumValidStagesPassed = (); # counters to track the total number of tests that passed each stage
    my %totalNumInvalidStagesPassed = (); # counters to track the total number of tests that passed each stage

    foreach $stageName (@compilerPhaseList) {
        $totalNumValidStagesPassed  {$stageName} = 0;
        $totalNumInvalidStagesPassed{$stageName} = 0;
    }

    my $svnRevision = &getSvnRevision();

    my $cnt = 0;
    my $regressMajorErrorCnt = 0;
    my $regressValgrindErrorCnt = 0;
    $regressionSummaryTemplate = HTML::Template->new(filename => "$htmlTemplateDir/summary.tmpl");
    $regressionSummaryTemplate->param(styleCss            => "../../../trunk/scripts/regress_html_templates/$styleCssFile"   );
    $regressionSummaryTemplate->param(dateTime            => $test_date_start);
    $regressionSummaryTemplate->param(cpuName             => $cpu_model      );
    $regressionSummaryTemplate->param(svnRevision         => $svnRevision    );
    $regressionSummaryTemplate->param(cpuMhz              => $cpu_speed      );
    $regressionSummaryTemplate->param(bogomips            => $cpu_bogomips   );
    $regressionSummaryTemplate->param(availableMemory     => $total_ram      );
    $regressionSummaryTemplate->param(scriptDir           => $scriptDir      );
    $regressionSummaryTemplate->param(currentHdl          => uc($currentHdl) );

    my $currentHdlDirectory = "$resultsRootDir/$currentHdl";
    mkDir($currentHdlDirectory);

    my $totalValidNumTests   = 0;
    my $totalInvalidNumTests = 0;
    my $totalValidNumTestsPassed = 0;
    my $totalValidNumTestsFailed = 0;
    my $totalInvalidNumTestsPassed = 0;
    my $totalInvalidNumTestsFailed = 0;
    my%totalGenCodeStagesPassed;

    $totalGenCodeStagesPassed{cslcCompileVerilogCode} = 0;
    $totalGenCodeStagesPassed{gccCompileSystemCCode } = 0;
    $totalGenCodeStagesPassed{gccCompileCppCode     } = 0;
    $totalGenCodeStagesPassed{gccCompileCsimCode    } = 0;

    my @test_dir_list = &generate_hdl_directory_list($currentHdl, $testDirFilter);

    # sort by valid/invalid
    my @sorted_test_dir_list = &sortDirectories(\@test_dir_list);
    foreach $currentTestDirectory ( @sorted_test_dir_list ) {
        print "Executing tests in the $currentTestDirectory directory\n";

        # print "[INFO] regressHdl: begin currentTestDirectory = $currentTestDirectory \n";
        my $resultsTestDirectory = "$currentHdlDirectory/$currentTestDirectory";
        mkDir($resultsTestDirectory);
        my $testListSummaryFileWithOutHtmlExt = "$currentHdl/$currentTestDirectory/$currentHdl_$currentTestDirectory" . "_" . "regression_summary"; 
        %testResults = &regressDir( $currentTestDirectory, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdl, $currentHdlDirectory);

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

        my $numCslcCompileVerilogCode = %$numStagesPassed->{cslcCompileVerilogCode};
        my $numGccCompileCppCode      = %$numStagesPassed->{gccCompileCppCode     };
        my $numGccCompileCsimCode     = %$numStagesPassed->{gccCompileCsimCode    };
        my $numGccCompileSystemCCode  = %$numStagesPassed->{gccCompileSystemCCode };

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


        $totalGenCodeStagesPassed{cslcCompileVerilogCode} += %$numStagesPassed->{cslcCompileVerilogCode};
        $totalGenCodeStagesPassed{gccCompileCppCode     } += %$numStagesPassed->{gccCompileCppCode     };
        $totalGenCodeStagesPassed{gccCompileCsimCode    } += %$numStagesPassed->{gccCompileCsimCode    };
        $totalGenCodeStagesPassed{gccCompileSystemCCode } += %$numStagesPassed->{gccCompileSystemCCode };



        $totalNumTests       += $testResults{totalDirNumTests      };
        $totalWarningsCnt  += $testResults{totalDirWarningsCnt };
        $totalNumTestsPassed += $testResults{totalDirNumTestsPassed};
        if ($currentTestDirectory =~ m/invalid/i) { 
            $totalInvalidNumTests       += $testResults{totalDirNumTests}; 
            $totalInvalidNumTestsPassed += $testResults{totalDirNumTestsPassed} ;  
        }
        else { 
            $totalValidNumTests       += $testResults{totalDirNumTests}; 
            $totalValidNumTestsPassed += $testResults{totalDirNumTestsPassed} ; 
        }       

        $dir_has_tests = ($testResults{totalDirNumTests} > 0) ? 1 : 0;

        foreach $stageName (@compilerPhaseList) {
            my $s0 = $stageName . "Status";
            my $s1 = $stageName . "StagePassedCnt";
            my $numTestsPassedStage = %$numStagesPassed->{$s0}; # save the number of tests which passed this stage
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
        if ($externalArguments{include_empty_dirs}) { # if the exclude flag is set and the dir has test add the new exclude directory 
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

    my $overallStatusCSS = ($totalPercentPassed > 0) 
        ? (((0 == $regressMajorErrorCnt) && (0 == $regressValgrindErrorCnt) && (100 == $totalPercentPassed)) 
           ? $STATUS_PASSED 
           : $STATUS_FAILED) 
        : $STATUS_NO_TESTS;

    $regressStatus = $overallStatusCSS;

    $totalNumTestsFailed = $totalNumTests - $totalNumTestsPassed;
    $regressionSummaryTemplate->param(testDirStatusLoop   => \@loop              );
    $regressionSummaryTemplate->param(totalNumTests       => $totalNumTests      );
    $regressionSummaryTemplate->param(totalNumTestsPassed => $totalNumTestsPassed);
    $regressionSummaryTemplate->param(totalNumTestsFailed => $totalNumTestsFailed);
    $regressionSummaryTemplate->param(totalMajorErrorCnt    => $regressMajorErrorCnt   );
    $regressionSummaryTemplate->param(totalValgrindErrorCnt => $regressValgrindErrorCnt);
    $regressionSummaryTemplate->param(totalPercentPassed  => $totalPercentPassed );
    $regressionSummaryTemplate->param(totalOverall        => $overallStatusCSS   );
    $regressionSummaryTemplate->param(overallStatusCSS    => $overallStatusCSS   );

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

    my $cslcCompileVerilogCodeStatus = "failed";
    my $gccCompileCppCodeStatus      = "failed";
    my $gccCompileCsimCodeStatus     = "failed";
    my $gccCompileSystemCCodeStatus  = "failed";

    if ( $totalGenCodeStagesPassed{cslcCompileVerilogCode} == $totalNumTests ) { $cslcCompileVerilogCodeStatus = "passed"; }
    if ( $totalGenCodeStagesPassed{gccCompileCppCode     } == $totalNumTests ) { $gccCompileCppCodeStatus      = "passed"; }
    if ( $totalGenCodeStagesPassed{gccCompileCsimCode    } == $totalNumTests ) { $gccCompileCsimCodeStatus     = "passed"; }
    if ( $totalGenCodeStagesPassed{gccCompileSystemCCode } == $totalNumTests ) { $gccCompileSystemCCodeStatus  = "passed"; }

    $regressionSummaryTemplate->param( totalCslcCompVerilogCodeStagesPassedCSS =>  $cslcCompileVerilogCodeStatus );
    $regressionSummaryTemplate->param( totalGccCompCppCodeStagesPassedCSS      =>  $gccCompileCppCodeStatus      );
    $regressionSummaryTemplate->param( totalGccCompCsimCodeStagesPassedCSS     =>  $gccCompileCsimCodeStatus     );
    $regressionSummaryTemplate->param( totalGccCompSystemCCodeStagesPassedCSS  =>  $gccCompileSystemCCodeStatus  );

    foreach $stageName (@compilerPhaseList) {
        foreach $val_inv (("Val", "Inv")) {
            if ($val_inv eq "Val") {
                $totalNumStagesPassed = $totalNumValidStagesPassed{$stageName};
                $totalNumValInvTests  = $totalValidNumTests;
            }
            else {
                $totalNumStagesPassed = $totalNumInvalidStagesPassed{$stageName};
                $totalNumValInvTests  = $totalInvalidNumTests;
            }
            my $s = $stageName . "StageTotal" . "$val_inv" . "PassCnt";
            $regressionSummaryTemplate->param($s => ($totalNumValInvTests > 0 ? $totalNumStagesPassed : $STATUS_NO_TESTS));

            my $percentage = 0;
            if ($totalNumValInvTests > 0) {
                $percentage = ($totalNumStagesPassed/$totalNumValInvTests)*100;
            }
            my $formattedPercentage = ($totalNumValInvTests > 0) ? sprintf( "%5d%", $percentage) : $STATUS_NO_TESTS;
            my $s2 = $stageName . "StageTotal" . "$val_inv" . "PassPercent"; # save the percentage of tests which passed this stage
            $regressionSummaryTemplate->param($s2 => $formattedPercentage);
            my $s3 = $stageName . "Overall" . "$val_inv" . "StatusCSS";
            my $stagePassed = $totalNumStagesPassed == $totalNumValInvTests ? 1 : 0;
            my $stageStatus = ($totalNumValInvTests > 0) ? ($stagePassed ? $STATUS_PASSED : $STATUS_FAILED) : $STATUS_NO_TESTS;
            $regressionSummaryTemplate->param($s3 => $stageStatus);
        }
    }
    my $regression_finish_time  = time(); #statistics on the time elapsed from the start of the regression until it's end
    my $regression_elapsed_time = $regression_finish_time - $regression_start_time;
    my $regression_day          = int $regression_elapsed_time/86400;
    my $regression_hour         = int $regression_elapsed_time%86400/3600;
    my $regression_min          = int $regression_elapsed_time%3600/60;
    my $regression_sec          = $regression_elapsed_time-$regression_day*86400-$regression_hour*3600-$regression_min*60;

    $regressionSummaryTemplate->param( regression_elapsed_time => $regression_elapsed_time        );

    if($signalName){ print("\nREGRESSION DIDN'T COMPLETE ! \n"); }
    else           {  print("REGRESSION DONE !\n"             ); }

    my $regressionSummaryHtmlFile = "$currentHdlDirectory" . "_regression_summary.html";

    # print "regressionSummaryHtmlFile = $regressionSummaryHtmlFile\n";
    open(SF, "> $regressionSummaryHtmlFile");
    print SF $regressionSummaryTemplate->output;
    close(SF);

    if($externalArguments{firefox} ) {
        `firefox -remote "openurl($regressionSummaryHtmlFile)"`; 
    }

    # print "[INFO] RESULTS DIRECTORY: $regressionSummaryHtmlFile\n";

    # print "[INFO] regressHdl: end\n";

    return $regressStatus;
}

#sort the directories first by invalid/other
#then alphabetically

sub sortDirectories {
    my ($test_dir_list) = @_;
    my @test_dir_list = @{$test_dir_list};

    my @sorted_test_invalid_dir_list;
    my @sorted_test_valid_dir_list;
    my @sorted_test_dir_list;

    foreach $dir ( @test_dir_list ) {
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


#################################################################################################
#                                          regressDir                                           #
#subroutine for calling the regression for a specific dir                                       #
#################################################################################################

sub regressDir{
    my( $currentTestDirectory, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdl, $currentHdlDirectory) = @_; #read the parameter

    # print "[INFO] regressDir: begin\n";
    my %testResults = ();
#    if ( ! $externalArguments{no_execute}) {
        my @testlist = &generate_regression_list( $currentTestDirectory, $currentHdl ); # Generating regression lists for $currentTestDirectory
        @testlist = sort(@testlist);
        # print ("[INFO] regressDir: sourceDir = $currentTestDirectory testlist cnt = $#testlist\n"); 
        # print ("[INFO] regressDir: Executing regression for $currentTestDirectory testlist cnt = $#testlist\n"); 
        %testResults = &executeDirectoryTestlist( $currentHdl, $currentTestDirectory, \@testlist, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdlDirectory );  
#    }

    if($testResults{totalDirNumTests} == 0) {
        # print "[INFO] REGRESSION FAILED ! -  $currentTestDirectory directory is empty called in $testRootDir/$externalArguments{hdlExtParam}\n";
   }

    # print "[INFO] regressDir: end testResults = ", %testResults, "\n";
    return %testResults;
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
        my $topHdlDir = "$testRootDir/$currentHdl";
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

#################################################################################################
#                                          generate_regression_list                             #
#subroutine that generates the regression list file                                             #
#################################################################################################

sub generate_regression_list {
    my($currentTestDirectory, $currentHdl) = @_; #geting the source directory
    # print "[INFO] generate_regression_list: begin sourceDir = $currentTestDirectory\n";

    my $hdlFileExtension;
    if   ($currentHdl eq "verilog"  ) { $hdlFileExtension = "v";  }
    elsif(&isCslHdlArg($currentHdl) ) { $hdlFileExtension = "csl";} 
    else { die("[ERROR] generate_regression_list: couldn't determine the selected hdl currentHdl = $currentHdl"); }

    my $cwd = `pwd`;

#    my $testDirPath = "$testRootDir/$currentHdl/$currentTestDirectory/*.$hdlFileExtension";
    my $testDirPath = "$testRootDir/$currentHdl/$currentTestDirectory";

    # print "[INFO] generate_regression_list: testDirPath = $testDirPath\n";

    my $ls_cmd = "cd $testDirPath && find . -name \"*.$hdlFileExtension\" -print && cd $cwd"; #select only the regular files from the current tests dir

    # print "[INFO] generate_regression_list: ls_cmd = $ls_cmd\n";

#    my $ls_cmd = "ls $testDirPath"; #select only the regular files from the current tests dir
#FIX - need to handle .cf and .vf files here
#FIX - Verilog include files are a problem
# don't need a skip list if the verilog file does not have a module ... endmodule do not compile it
# open the cf/vf file and read all of the names in the file.
# then remove each of the file names from the test list and add the cf/vf file to the testlist

    my $file_list =`$ls_cmd`;
    my @file_list = split(/\n/, $file_list);
    chomp(@file_list); # get rid of '\n'
    my @testlist = (); #flushes the list

    my @testlistWithPath = ();

    foreach $fileName( @file_list ) { # remove the Verilog files which do not have modules
        chomp( $fileName );  #removes \n
        push ( @testlistWithPath, $testDirPath . "/$fileName" );
    }       

    if (&isCslHdlArg($currentHdl) ) {
        @testlist = @testlistWithPath;
    }
    else {
        local $fileName;

        foreach $fileName( @testlistWithPath ) { # remove the Verilog files which do not have modules
            chomp( $fileName );  #removes \n
            my $foundModuleEndModule = `grep endmodule $fileName`;        
            if ($foundModuleEndModule ) {
                push ( @testlist, "$fileName" );
            }
        }       
    }

    # print "[INFO] generate_regression_list: end testlist cnt = $#testlist test_list = ", @testlist, "\n";
    return @testlist;
}

###########################################################################################################################################
#                                                      EXECUTE REGRESSION                                                                 #
#subroutine that execute the regression for the entire testsuite                                                                          #
###########################################################################################################################################

sub executeDirectoryTestlist {
    my($currentHdl, $currentTestDirectory, $testlist, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdlDirectory) = @_;

    my @testlist =  @{$testlist};
    my $test_date = `date "+%d/%m/%G, %T"`;
    chomp($test_date);

    # print "[INFO] executeDirectoryTestlist: begin currentTestDirectory = $currentTestDirectory cnt = $#testlist testlist = @testlist testlist\n";
    my $testSrcDir = "$testRootDir/$currentHdl/$currentTestDirectory";
    my $chapterDir = "$currentHdlDirectory/$currentTestDirectory";

# create the directory to put the generated code from the compiler
    my $genCodeRootDir = "$chapterDir/gen_code";
    mkDir($genCodeRootDir);
    #print "genCodeRootDir = $genCodeRootDir\n";

    my @mapEmailTests = ();
    
    my $total_lines_page=50;
    my $totalTestListPageNum = ceil($#testlist / $total_lines_page);
    my $pageNum = 0;
    my $testPathName;
    my $numTestsPerHtmlPage = 50;

    my $testDirValInv = "valid";
    if ($currentTestDirectory =~ m/_invalid/) { $testDirValInv = "invalid"; }
 
    my %numStagesPassed = ();

    $numStagesPassed{cslcCompileVerilogCode} = 0;
    $numStagesPassed{gccCompileCppCode     } = 0;
    $numStagesPassed{gccCompileCsimCode    } = 0;
    $numStagesPassed{gccCompileSystemCCode } = 0;

    foreach $stageName (@compilerPhaseList) {
        my $s = $stageName . "Status";
        $numStagesPassed{$s} = 0;
    }
    
# create a linked list of pages to add to the html page
    local %mapPages = ();  

    # print "totalTestListPageNum = $totalTestListPageNum total_pages = $totalTestListPageNum numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
    for ( $k = 0; $k < $totalTestListPageNum; $k++ ) {
        $linkPage = "../../".$testListSummaryFileWithOutHtmlExt . "_$k.html";
        $mapPages{$k} = $linkPage; 
        # print "linkPage = $linkPage\n";
    }

# put the create a linked list of pages that will be created into URL links
    my @listPageNums = sort keys %mapPages;
    my @pageLinkList = {}; # list to pass to the page template               

    for ( $k = 0; $k <= $#listPageNums; $k++ ) {
        my %pageRow=(pageLink => $mapPages{$k},
                     pageNum  => $k);  
        push(@pageLinkList, \%pageRow);
    }

    my $cslcVerilogCompileStatus = $STATUS_PHASE_DID_NOT_RUN;
    my $cslcCppCompileStatus     = $STATUS_PHASE_DID_NOT_RUN;
    my $cslcCsimCompileStatus    = $STATUS_PHASE_DID_NOT_RUN;
    my $cslcSystemCCompileStatus = $STATUS_PHASE_DID_NOT_RUN;

    # print "[INFO] pageLinkList = @pageLinkList\n";

    my $valgrindErrorCnt        = 0;
    my $pageCnt                 = 0;
    my $testPassedCnt           = 0;
    my $totalDirNumTests        = 0;
    my $totalDirWarningsCnt   = 0;
    my $totalDirNumTestsPassed  = 0;
    my $totalDirPercentPassed   = 0;
    my $totalDirMajorErrorCnt = 0;
    my $totalDirValgrindErrorCnt = 0;

    my $includedTestNumber      = 0; # a test can be excluded if the -errors_only option is on which only includes the tests which fail
                                # we only increment the included test cnter if the test is actually included
    my $testListPageTemplate;
    my @testListLoop = ();
    foreach $testPathName (@testlist) {
#        print "Executing test: $testPathName\n";

        if ( 0 == ($includedTestNumber % $numTestsPerHtmlPage)) { # a page is created when the testcnt == $numTestsPerHtmlPage
            # print "Created template totalDirNumTests = $totalDirNumTests includedTestNumber = $includedTestNumber = numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
            $testListPageTemplate = HTML::Template->new(filename => "$htmlTemplateDir/test_list_page.tmpl");
            $testListPageTemplate->param(dateTime                     => $test_date_start       );
            $testListPageTemplate->param(styleCss                     => "../../../../../trunk/scripts/regress_html_templates/$styleCssFile"  );
            $testListPageTemplate->param(testDirName                  => $currentTestDirectory  );
            $testListPageTemplate->param(testDirValInv                => $testDirValInv         );
        }

        $totalDirNumTests++;
        # print "currentTestDirectory = $currentTestDirectory TestCnt = $totalDirNumTests Testname = $testPathName\n";

        $testPathName =~ m/([a-z0-9_]+)\./i;
        my $testName = $1;

        my $genCodeTestDir = "$genCodeRootDir/$testName";


#        # print "pattern match testname = $testName testPathName = $testPathName\n";

        my $cslcLogFileShort  = "$testName.cslc.txt";
        my $cslcLogFile      = "$chapterDir/$cslcLogFileShort";
#        # print "cslcLogFile = $cslcLogFile\n";

        my $isValid = $testDirValInv eq "valid" ? 1 : 0;

        my $foundUnit = 0;

        my $majorError = 0;

        my $cslcVerilogCompileLog     = "did_not_run_regression_no_log_file_generated";
        my $cslcCppCompileLog         = "did_not_run_regression_no_log_file_generated";
        my $cslcCsimCompileLog        = "did_not_run_regression_no_log_file_generated";
        my $cslcSystemCCompileLog     = "did_not_run_regression_no_log_file_generated";
        my $cslcVerilogCompileLogName = "did_not_run_regression_no_log_file_generated";
        my $cslcCppCompileLogName     = "did_not_run_regression_no_log_file_generated";
        my $cslcCsimCompileLogName    = "did_not_run_regression_no_log_file_generated";
        my $cslcSystemCCompileLogName = "did_not_run_regression_no_log_file_generated";

        my $genCodArg = "--dir \"$genCodeTestDir\""; # compiler will generate code in this directory; default name is "generated_code"
    
        if (!$no_execute) {
            my $cmd = "";
            if ($testPathName =~ m/\.csl/){
#                # print "[INFO] CSL sourceDir = $currentTestDirectory TESTNAME= $testPathName\n"; 

                my $grepResults = `grep csl_unit $testPathName`;    
    
                if (!($grepResults eq "")) { $foundUnit = 1}

                my $callCsimGen = "";
                if ($foundUnit ) {
                    $callCsimGen = "--csim_gen"; # add to the command line after the compiler supports this option
                }
 
                #my $cslcArgs    = " --cslom_ast --info --single --csl_pp on --cpp_gen $callCsimGen $genCodArg";                               
                my $cslcArgs    = " --cslom_ast --info --csl_pp on --cpp_gen $callCsimGen $genCodArg";                               
                $cmd         = "$cslcExec $cslcArgs $testPathName 1> $cslcLogFile 2>&1";
                #print "cmd = $cmd\n";
            }
            elsif ($testPathName =~ m/\.v/){
#                # print "[INFO] Verilog sourceDir = $currentTestDirectory TESTNAME= $testPathName\n"; 
#                my $cslcArgs    = "--info --single";                               
                my $cslcArgs    = "--info  $genCodArg";                               
                $cmd         = "$cslcExec $cslcArgs $testPathName 1> $cslcLogFile  2>&1";
            }

            if($externalArguments{enableValgrind}) {
                $cmd = "valgrind --leak-check=full --show-reachable=yes -v " . $cmd;
            }

################################################################################
# run cslc on the test
################################################################################
#            print "cmd = $cmd\n";

            my $r = system("$cmd");
            $retVal = $?;
            my $errorNumber = ( $retVal >> 8 );
            `echo "cmd = $cmd"  >> $cslcLogFile`;

            if ( defined ($systemErrorMap{$errorNumber})) {
                $majorError = $errorNumber;
                my $signalErrorMsg = $systemErrorMap{$errorNumber};
#                print "Major error majorError = $majorError defined testname = $testName exit code = $errorNumber signalErrorMsg = $signalErrorMsg\n";
                `echo "found signal:$signalErrorMsg"  >> $cslcLogFile`;
                #$totalDirMajorErrorCnt++;
                print "[MAJOR ERROR] testname = $testPathName\n";
            }       

################################################################################
# Compile the CSLC generated code
################################################################################


            if ($foundUnit  && ($retVal == 0) && ! $externalArguments{no_post_compile} ){

################################################################################
# Compile the CSLC generated verilog code with cslc
################################################################################

                $outputVerilogCodeDir     = "$genCodeTestDir/generated_code/generated_verilog"; # directory with the generated Verilog code
                # $outputVerilogCodeVfFile  = "$outputVerilogCodeDir/$testName.vf"    ; # vf file containing the names of the generated Verilog files
                $outputVerilogCodeVfFile  = &getVfFileName($outputVerilogCodeDir); # vf file containing the names of the generated Verilog files


                #print "outputVerilogCodeVfFile = $outputVerilogCodeVfFile\n";
                $cslcVerilogCompileLogName = "$testName" . "_verilog_compile.txt"; # cslc compile of generated verilog log file 
                $cslcVerilogCompileLog     = "$outputVerilogCodeDir/$cslcVerilogCompileLogName"; # cslc compile of generated verilog log file 
                my $cmd                    = "$cslcExec -f $outputVerilogCodeVfFile > $cslcVerilogCompileLog  2>&1";
                print("$cmd\n");
                system("$cmd");
                #print("cslc gen cmd = $cmd\n");
                $retVal = $?;
                my $errorNumber = ( $retVal >> 8 );
                if ( defined ($systemErrorMap{$errorNumber})) {
                    $majorError = $errorNumber;
                    my $signalErrorMsg = $systemErrorMap{$errorNumber};
                    `echo "found signal:$signalErrorMsg"  >> $cslcVerilogCompileLog`;
                    #$totalDirMajorErrorCnt++;
                    print "[MAJOR ERROR] compiling generated Verilog code from testname = $testPathName\n";
                } 
                $cslcVerilogCompileStatus = $retVal == 0 ? $STATUS_PASSED : $STATUS_FAILED;      

            }

            if (($retVal == 0) 
                && ! $externalArguments{no_post_compile}  
                && ! $externalArguments{no_post_compile_systemc}
                && $currentHdl ne "verilog" ){
                

################################################################################
# Compile the CSLC generated SystemC code with gcc
################################################################################

                $outputSystemCCodeDir  = "$genCodeTestDir/generated_code/generated_systemC"; # directory with the generated SystemC code
                $cslcSystemCCompileLogName = "$testName" . "_systemC_compile.txt";
                $cslcSystemCCompileLog = "$outputSystemCCodeDir/$cslcSystemCCompileLogName"; # cslc compile of generated systemC log file 
                my $cwd                = `pwd`;
                $outputSCCodeDir       = "$genCodeTestDir/systemc_generated_code" ;
                if (-e $outputSCCodeDir) {
                    system("cd $outputSCCodeDir");# || die ("[ERROR] $outputSCCodeDir does not exist\n"); # go to the generated SystemC directory 
                    system("make > $cslcSystemCCompileLog 2>&1"); # call the generated make file
                    $retVal = $?; # get the return value from the command just executed
                    system("cd $cwd"            ); # return to our current directory
                    my $errorNumber = ( $retVal >> 8 ); # move the uppoer byte to the lower byte
                    if ( defined ($systemErrorMap{$errorNumber})) {
                        $majorError = $errorNumber;
                        my $signalErrorMsg = $systemErrorMap{$errorNumber};
                        `echo "found signal:$signalErrorMsg"  >> $cslcSystemCCompileLog`;
                        #$totalDirMajorErrorCnt++;
                        print "[MAJOR ERROR] compiling generated SystemC code from testname = $testPathName\n";
                    }
                    $cslcSystemCCompileStatus = $retVal == 0 ? $STATUS_PASSED : $STATUS_FAILED;      
                }
                else {
                    $cslcSystemCCompileStatus = $STATUS_PHASE_DID_NOT_RUN;      
                }

            }
            if (($retVal == 0) && ! $externalArguments{no_post_compile}  && ! $externalArguments{no_post_compile_cpp} 
                && $currentHdl ne "verilog"){

################################################################################
# Compile the CSLC generated C++ code with gcc
################################################################################

                $outputCppCodeDir  = "$genCodeTestDir/generated_code/generated_cpp"; # directory with the generated Cpp code
                $cslcCppCompileLogName = "$testName" . "_cpp_compile.txt"; 
                $cslcCppCompileLog = "$outputCppCodeDir/$cslcCppCompileLogName"; # cslc compile of generated cpp log file 
                my $cwd            = `pwd`;
                $outputSCCodeDir   = "$genCodeTestDir/cpp_generated_code" ;
                if (-e $outputCppCodeDir) {
                    system("cd $outputCppCodeDir &&  make > $cslcCppCompileLog 2>&1; ");
                    #print ("cd $outputCppCodeDir &&  make > $cslcCppCompileLog 2>&1; ");
                    $retVal = $?; # get the return value from the command just executed
                    system("cd $cwd"            ); # return to our current directory
                    my $errorNumber = ( $retVal >> 8 ); # move the uppoer byte to the lower byte
                    if ( defined ($systemErrorMap{$errorNumber})) {
                        $majorError = $errorNumber;
                        my $signalErrorMsg = $systemErrorMap{$errorNumber};
                        `echo "found signal:$signalErrorMsg"  >> $cslcCppCompileLog`;
                        #$totalDirMajorErrorCnt++;
                        print "[MAJOR ERROR] compiling generated Cpp code from testname = $testPathName\n";
                    }
                    $cslcCppCompileStatus = $retVal == 0 ? $STATUS_PASSED : $STATUS_FAILED;      
                }
                else {
                    $cslcCppCompileStatus = $STATUS_PHASE_DID_NOT_RUN;      
                }

################################################################################
# Compile the CSLC generated C++ C simulator code with gcc
################################################################################
                if ($foundUnit ){ ## CSimGen only generates code if there are units

                    $outputCsimCodeDir  = "$genCodeTestDir/csim_generated_code"; # directory with the generated Csim code
                    $cslcCsimCompileLogName = "$testName" . "_csim_compile.txt"; # cslc compile of generated csim log file 
                    $cslcCsimCompileLog = "$outputCsimCodeDir/$cslcCsimCompileLogName"; # cslc compile of generated csim log file 
                    my $cwd             = `pwd`;
                    $outputSCCodeDir    = "$genCodeTestDir/csim_generated_code" ;
                    if (-e $outputCsimCodeDir) {
                        system("cd $outputSCCodeDir");# || die ("[ERROR] $outputSCCodeDir does not exist\n"); # go to the generated Csim directory 
                        system("make > $cslcCsimCompileLog 2>&1"               ); # call the generated make file
                        $retVal = $?; # get the return value from the command just executed
                        system("cd $cwd"            ); # return to our current directory
                        my $errorNumber = ( $retVal >> 8 ); # move the uppoer byte to the lower byte
                        if ( defined ($systemErrorMap{$errorNumber})) {
                            $majorError = $errorNumber;
                            my $signalErrorMsg = $systemErrorMap{$errorNumber};
                            `echo "found signal:$signalErrorMsg"  >> $cslcCsimCompileLog`;
                            #$totalDirMajorErrorCnt++;
                            print "[MAJOR ERROR] compiling generated Csim code from testname = $testPathName\n";
                        }
                        $cslcCsimCompileStatus = $retVal == 0 ? $STATUS_PASSED : $STATUS_FAILED;      
                    }
                    else {
                        $cslcCsimCompileStatus = $STATUS_PHASE_DID_NOT_RUN;      
                    }
                }
            }
        }   

        my %testRow = &getFileErrors ($currentHdl, $cslcLogFile, $totalDirNumTests, $testName, $testPathName, $isValid, $majorError, $foundUnit, $currentTestDirectory, 
                                      $cslcVerilogCompileStatus, $cslcCppCompileStatus, $cslcCsimCompileStatus, $cslcSystemCCompileStatus, 
                                      $cslcVerilogCompileLog   , $cslcCppCompileLog   , $cslcCsimCompileLog   , $cslcSystemCCompileLog   ,
                                      $cslcVerilogCompileLogName   , $cslcCppCompileLogName   , $cslcCsimCompileLogName   , $cslcSystemCCompileLogName   ,
                                      $cslcLogFileShort);

        my $testStatus = ( $STATUS_PASSED eq $testRow{ overallTestStatus }) ? 1 : 0 ;

        $totalDirMajorErrorCnt    += $testRow{majorErrorCnt}; 
        $totalDirValgrindErrorCnt += $testRow{valgrindErrorCnt}; 

        #print "majorErrorCnt = $majorErrorCnt testRow{majorErrorCnt} = $testRow{majorErrorCnt} totalDirMajorErrorCnt = $totalDirMajorErrorCnt\n"; 

        foreach $stageName (@compilerPhaseList) {
            my $s = $stageName . "Status";
            #print "xx testRow{$s} = $testRow{$s}\n";
            if ($STATUS_PASSED eq $testRow{$s}) { $numStagesPassed{$s}++; }
        }

        if ($STATUS_PASSED eq $testRow{cslcCompileVerilogCode}) { $numStagesPassed{cslcCompileVerilogCode}++; }
        if ($STATUS_PASSED eq $testRow{gccCompileCppCode     }) { $numStagesPassed{gccCompileCppCode     }++; }
        if ($STATUS_PASSED eq $testRow{gccCompileCsimCode    }) { $numStagesPassed{gccCompileCsimCode    }++; }       
        if ($STATUS_PASSED eq $testRow{gccCompileSystemCCode }) { $numStagesPassed{gccCompileSystemCCode }++; }
                           
        if ( $externalArguments{major_errors_only} ) {
            if ($majorError != 0) {
                push(@testListLoop,\%testRow);
                $includedTestNumber++;
            # print "Created template page currentTestDirectory = $currentTestDirectory testListLoop = $#testListLoop testCnt = $totalDirNumTests numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
            }
        }
        elsif ( $externalArguments{errors_only} ) {
            if (0 == $testStatus) {
                push(@testListLoop,\%testRow);
                $includedTestNumber++;
            # print "Created template page currentTestDirectory = $currentTestDirectory testListLoop = $#testListLoop testCnt = $totalDirNumTests numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
            }
        }
        else {
            push(@testListLoop,\%testRow);
            $includedTestNumber++;
            # print "Created template page currentTestDirectory = $currentTestDirectory testListLoop = $#testListLoop testCnt = $totalDirNumTests numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
        }

        $totalDirNumTestsPassed += $testStatus;                
        $totalDirPercentPassed   = $totalDirNumTestsPassed/$totalDirNumTests;

        if ( 0 == ($includedTestNumber % $numTestsPerHtmlPage) && $includedTestNumber > 0) { # a page is created when the testcnt == $numTestsPerHtmlPage
            # print "in forloop wrote to file template page totalDirNumTests = $totalDirNumTests includedTestNumber = $includedTestNumber currentTestDirectory = $currentTestDirectory testListLoop = $#testListLoop testCnt = $totalDirNumTests numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
            $testListPageTemplate->param(testLinkPageNumLoop => \@pageLinkList );
            $testListPageTemplate->param(testPageNumber      => $pageNum++       );
            $testListPageTemplate->param(testListResultsLoop => \@testListLoop );
            @testListLoop = ();
            $testListSummaryFilePageNum = "$resultsRootDir/$testListSummaryFileWithOutHtmlExt" . "_$pageCnt.html";
            open(TF, "> $testListSummaryFilePageNum");
            print TF $testListPageTemplate->output;
            close(TF);
            $pageCnt++;
            &updateXmlReport();
        }
    }


    if ( 0 != ($includedTestNumber % $numTestsPerHtmlPage) && $includedTestNumber > 0) { # create the last page if not == 0
        # print "after forloop wrote to template page currentTestDirectory = $currentTestDirectory testListLoop = $#testListLoop testCnt = $totalDirNumTests numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
        $testListPageTemplate->param(testLinkPageNumLoop => \@pageLinkList    );
        $testListPageTemplate->param(testPageNumber      => $pageNum          );
        $testListPageTemplate->param(testListResultsLoop => \@testListLoop    );
        @testListLoop = ();

        $testListSummaryFilePageNum = "$resultsRootDir/$testListSummaryFileWithOutHtmlExt" . "_$pageCnt.html";
        open(TF, "> $testListSummaryFilePageNum");
        print TF $testListPageTemplate->output;
        close(TF);
        &updateXmlReport();
        %testResults = ();
    }

    &errorXmlReport();  

    $testResults{totalDirNumTests        } = $totalDirNumTests      ;
    $testResults{totalDirNumTestsPassed  } = $totalDirNumTestsPassed;
    $testResults{totalDirPercentPassed   } = $totalDirPercentPassed ;
    $testResults{directoryStatusCSS      } = (100 == $totalDirPercentPassed) ?  $STATUS_PASSED : $STATUS_FAILED;
    $testResults{totalDirMajorErrorCnt   } = $totalDirMajorErrorCnt   ;
    $testResults{totalDirValgrindErrorCnt} = $totalDirValgrindErrorCnt;
    $testResults{numStagesPassed         } = \%numStagesPassed;
    # print "[INFO] executeDirectoryTestlist: end testResults = ", %testResults, "\n";
    # print "[INFO] executeDirectoryTestlist: end \n";

    foreach $stageName (@compilerPhaseList) {
        my $s = $stageName . "Status";
        #print "tt numStagesPassed{$s} = $numStagesPassed{$s}\n";
    }
    

# write out the resutls fo the directory run so that it can be read by ssh_dist_regress.pl and merged into one summary
    my $dirSummaryFile = "$chapterDir/summary.txt";
    open (DIR_SUMMARY, "> $dirSummaryFile") or die ("[ERROR] check_results: Error opening $dirSummaryFile summary file !\n");
    foreach $key (keys %testResults) {
        print DIR_SUMMARY "$key = $testResults{$key}\n";
    }
    foreach $s (keys %numStagesPassed) {
        print DIR_SUMMARY "$s = $numStagesPassed{$s}\n";
    }

    close DIR_SUMMARY;

    return %testResults;
}

sub getVfFileName($outputVerilogCodeDir) {
    my $ls_cmd = "ls $outputVerilogCodeDir/*.vf";
    my $fileName = `$ls_cmd`;

    print "vf = $fileName\n";

    return $fileName;
}

#################################################################################################
#                                          detectErrors                                         #
#subroutine for checking if any error has occured                                               #
#################################################################################################

sub getFileErrors {
    my ($currentHdl, $cslcLogFile, $testCnt, $testName, $testPathName, $isValid, $majorError, $foundUnit, $currentTestDirectory,  
        $cslcVerilogCompileStatus, $cslcCppCompileStatus, $cslcCsimCompileStatus, $cslcSystemCCompileStatus, 
        $cslcVerilogCompileLog   , $cslcCppCompileLog   , $cslcCsimCompileLog   , $cslcSystemCCompileLog   ,
        $cslcVerilogCompileLogName   , $cslcCppCompileLogName   , $cslcCsimCompileLogName   , $cslcSystemCCompileLogName   ,
        $cslcLogFileShort) = @_;
    # print "[INFO] getFileErrors: begin isValid = $isValid\n";

    my %Status = ();

# this $relativeFileName causes the following error if placed at the bottom of this function
# Illegal declaration of subroutine main::finishUp at /home/dpappas/fplsrl_repo/fpl/cslc/trunk/scripts/run_regress.pl line 1828.
    my $relativeFileName = "../../../../../test/$currentHdl/$currentTestDirectory/$testName.csl"; 

# init the status for each phase
    foreach $phase (@compilerPhaseList) {
        $Status{$phase            } = $STATUS_PHASE_DID_NOT_RUN;        
    }

    my %foundSection  = ();
    foreach $k (@compilerPhaseList) {
        $foundSection{$k } = 0;
    }

    if ($externalArguments{no_execute} ne "" && ! -e $cslcLogFile) { # Allow files to not exist if the -no_exec option is used
        my %testRow=(testNumber                   => $testCnt,
                     linkToLogFile                => "no_log_file",
                     testName                     => "$testName",
                     linkToTestName               => "no_log_file",
                     minorErrorCnt                => 0   ,
                     majorErrorCnt                => 0   ,
                     valgrindErrorCnt             => 0,
                     compilerPhasePassedPercentage=> 0,
                     overallTestStatus            => $STATUS_PHASE_DID_NOT_RUN,   
                     cslcCompileVerilogCode       => $STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileCppCode            => $STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileCsimCode           => $STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileSystemCCode        => $STATUS_PHASE_DID_NOT_RUN,   
                     cslcCompileVerilogLog        => "no_log_file",   
                     gccCompileCppLog             => "no_log_file",   
                     gccCompileCsimLog            => "no_log_file",   
                     gccCompileSystemCLog         => "no_log_file",   

                     minorErrorCntCSSClass                 => $STATUS_PHASE_DID_NOT_RUN,    
                     majorErrorCntCSSClass                 => $STATUS_PHASE_DID_NOT_RUN,    
                     valgrindErrorCntCSSClass              => $STATUS_PHASE_DID_NOT_RUN,    
                     overallTestStatusCSSClass             => $STATUS_PHASE_DID_NOT_RUN,
                     compilerPhasePassedPercentageCSSClass => $STATUS_PHASE_DID_NOT_RUN,    
                     cslcCompileGenVerilogStatusCSSClass   => $STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenCppStatusCSSClass        => $STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenCsimStatusCSSClass       => $STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenSystemCStatusCSSClass    => $STATUS_PHASE_DID_NOT_RUN,

                     );
        return %testRow;
    }

    open (FH, $cslcLogFile) or die "[ERROR] could not open cslcLogFile: $cslcLogFile\n";
    my @lines = <FH>;

    my $errorType             = 0;
    my $minorErrorCnt         = 0;
    my $majorErrorCnt         = 0;
    my $valgrindErrorCnt      = 0;
    my $warnCnt               = 0;
    my $foundPreviousStageNum = 1;
    my $stageNum              = 0; # current stage number
    my $stageName             = $compilerPhaseList[$stageNum];
    my %StatusCssClass        = ();
    my $valgrind_error        = 0;

    for ( $i = 0; $i <= $#lines; $i++ ) {
        $line = $lines[$i];

        if ($externalArguments{enableValgrind}) {
            if ($line =~ m/LEAK SUMMARY/ ) { 
                $valgrind_error++;
                $valgrindErrorCnt = 1; 
                $Status{"$stageName"} = $STATUS_FAILED;

                # print "found valgrind error\n";
# add a record to the error list which will be emailed to owners
                my %errorRpt = ( "directory"  => $currentTestDirectory,
                                 "testname"   => $testName,
                                 "minorError" => ""       ,
                                 "majorError" => ""       ,
                                 "valgrindError" => $line ,
                                 );
                # print "errorRpt = ", %errorRpt, "\n";

                push (@{$errorListByCompilerPhase{$stageName}}, \%errorRpt);
#                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $errorListByCompilerPhase{$stageName}, "\n"; 
                goto DONE; 
            }

        }

        if (0 == $foundUnit && &isCslHdlArg($currentHdl) && $stageName eq $CSIM_CODE_GEN_STAGE) { # skip CPP code gen stage
            #print "skip CPP code gen stage\n";
            $stageNum++;
            $stageName = $compilerPhaseList[$stageNum];
            $i--; # stay on the same line until the right stage name is reached
        }
        elsif (($currentHdl eq "verilog" ) && &isCslStage($stageName)) { # this is a Verilog test and we do not run CSl compilation steps on verilog tests
            # print "finderrors isCSLStage stageName = $stageName\n";
            $stageNum++;
            $stageName = $compilerPhaseList[$stageNum];
            # print "finderrors  stageName = $stageName\n";
            $i--; # stay on the same line until the right stage name is reached
         }
        else {
            my $pattern = "$stageName" . "_begin";
            if ($line =~ m/$pattern/i ) { 
                # print "found phase= $stageName \n";
                # print "found begin pattern\n";
                # print "a line = $line\n";
                $Status{"$stageName"} = $STATUS_FAILED; # inside of begin-set to failed unless end is reached and no errors are found
                for ( $k = $i+1; $k <= $#lines; $k++ ) {
                    $i = $k;
                    $line = $lines[$k];
                    # print "b line = $line\n";
                    my $pattern = "$stageName" . "_end";
                    # print "pattern = $pattern\n";
                    # print "before findErrors line = $line\n";

                    if ($line =~ m/$pattern/i ) { # found end-so section passed
                        # print "found end pattern\n";

                        $foundSection{"$stageName"} = 1;
                        if (0 == $warnCnt) {
                            $Status{"$stageName"} = $STATUS_PASSED;
                        }
                        elsif ($warnCnt > 0) {
                            $Status{"$stageName"} = $STATUS_PASSED_WARNING;
                        }

                        $StatusCssClass{"$stageName"} = &getStatusCssClass("$stageName", $Status{"$stageName"});         
                        $stageNum++;
                        $stageName = $compilerPhaseList[$stageNum];
                        # print "stageName = $stageName foundUnit = $foundUnit\n";

                        # print "go to next\n";

                        goto NEXT;
                    }
                    else {
                
                        $errorType = &findErrors($line);
                        if    ($MINOR_ERROR == $errorType) { # found error - section failed
                            $minorErrorCnt = 1;                         
                            $Status{"$stageName"} = $STATUS_FAILED;
                            # print "found minor error\n";

                            if ($isValid) { # add a record to the error list which will be emailed to owners
                                my %errorRpt = ( "directory"  => $currentTestDirectory,
                                                 "testname"   => $testName,
                                                 "minorError" => $line    ,
                                                 "majorError" => ""       ,
                                                 "valgrindError" => ""    ,
                                                 );
                                #print "errorRpt = ", %errorRpt, "\n";
                                push (@{$errorListByCompilerPhase{$stageName}}, \%errorRpt);
                                # print "Minor error stageName = $stageName testName = $testName Added error rpt = /%errorRpt/ to errorListByCompilerPhase{$stageName} = ", $errorListByCompilerPhase{$stageName}, "\n"; 
                            }
                            goto DONE; 
                        }
                        elsif ($MAJOR_ERROR == $errorType) { # found error - section failed
                            $majorErrorCnt = 1; 
                            $Status{"$stageName"} = $STATUS_FAILED;

                            # print "found major error\n";
# add a record to the error list which will be emailed to owners
                            my %errorRpt = ( "directory"  => $currentTestDirectory,
                                             "testname"   => $testName,
                                             "minorError" => ""     ,
                                             "majorError" => $line  ,
                                             "valgrindError" => ""       ,
                                             );
                            # print "errorRpt = ", %errorRpt, "\n";

                            push (@{$errorListByCompilerPhase{$stageName}}, \%errorRpt);
#                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $errorListByCompilerPhase{$stageName}, "\n"; 
                            goto DONE; 
                        }
                        elsif ($VALGRIND_ERROR == $errorType) { # found error - section failed
                            $valgrindErrorCnt = 1; 
                            $Status{"$stageName"} = $STATUS_FAILED;

                            # print "found valgrind error\n";
# add a record to the error list which will be emailed to owners
                            my %errorRpt = ( "directory"  => $currentTestDirectory,
                                             "testname"   => $testName,
                                             "minorError" => ""       ,
                                             "majorError" => ""       ,
                                             "valgrindError" => $line ,
                                             );
                            # print "errorRpt = ", %errorRpt, "\n";

                            push (@{$errorListByCompilerPhase{$stageName}}, \%errorRpt);
#                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $errorListByCompilerPhase{$stageName}, "\n"; 
                            goto DONE; 
                        }

                    } 
                }
            }
       }
        NEXT:
    }
#    print "before done\n";

    DONE:
    close (FH);
    
    $Status{$VALGRIND_STAGE        } = $STATUS_PHASE_DID_NOT_RUN;
    $StatusCssClass{$VALGRIND_STAGE} = $CSS_STATUS_PHASE_DID_NOT_RUN; 

    if ($externalArguments{enableValgrind}) { 
        my $valgrind_passed = ($valgrind_error == 0);
        my $valgrind_status = $valgrind_error;
        $StatusCssClass{$VALGRIND_STAGE} = $valgrind_passed ? $CSS_STATUS_PASSED : $CSS_STATUS_FAILED; 
    }

    $Status{$OVERALL_STATUS_STAGE} = $STATUS_FAILED;

    my $k;
    my $allSectionsPassed = 1;

    foreach $stageName (@compilerPhaseList) {
        #print "allSectionsPassed currentHdl = $currentHdl $stageName = $stageName Status{$stageName} = $Status{$stageName} allSectionsPassed = $allSectionsPassed\n";
        if (0 == $foundUnit && $stageName eq $CSIM_CODE_GEN_STAGE) { # skip CSIM code gen stage
            next;
        }
        elsif (($currentHdl eq "verilog" ) && &isCslStage($stageName)) { # this is a Verilog test and we do not run CSl compilation steps on verilog tests
#print "isCSLStage stageName = $stageName\n";
            next;
        }
        elsif (!($STATUS_PASSED eq $Status{"$stageName"})) {
            $allSectionsPassed = 0;
            last;
        }
    }
#print "\n";

    my $postCompilePassed =  ($STATUS_PASSED == $cslcVerilogCompileStatus) && ($STATUS_PASSED ==  $cslcSystemCCompileStatus) && ($STATUS_PASSED == $cslcCppCompileStatus) && ($STATUS_PASSED == $cslcCsimCompileStatus);

#FIX ADD LATER $allSectionsPassed = $allSectionsPassed && $postCompilePassed;

#print "allSectionsPassed = $allSectionsPassed\n";

    if ($majorError > 0) { # when we have a major error it doesn't matter if it is a valid test or a invalid test the file overall stage must be FAILED
        $Status{$OVERALL_STATUS_STAGE} = $STATUS_FAILED;
    }
    else {
        if(1 == $allSectionsPassed) { # if all stages did not run then look for a major error such as abort or segfault
            if (0 == $minorErrorCnt && 0 == $majorErrorCnt && 0 == $valgrindErrorCnt ) { 
                $Status{$OVERALL_STATUS_STAGE} = $isValid ? $STATUS_PASSED : $STATUS_FAILED;
            }
            elsif (0 != $valgrindErrorCnt ) { 
                $Status{$OVERALL_STATUS_STAGE} = $isValid ? $STATUS_FAILED : $STATUS_PASSED;
            }
            elsif ($warnCnt > 0) { 
                $Status{$OVERALL_STATUS_STAGE} = $isValid ? $STATUS_PASSED_WARNING : $STATUS_FAILED;
            }
            elsif ($majorErrorCnt > 0) { 
                die "[ERROR] getFileErrors: problem in else error check- found all sections but majorErrorCnt > 0";
            }
            elsif ($minorErrorCnt > 0) { 
                die "[ERROR] getFileErrors: problem in else error check- found all sections but minorErrorCnt > 0";
            }
            else { 
                die "[ERROR] getFileErrors: problem in else error check";
            }
        }
        else {
            if ($majorErrorCnt > 0) { 
                $Status{$OVERALL_STATUS_STAGE} = $isValid ? $STATUS_FAILED : $STATUS_PASSED;
            }
            elsif ($minorErrorCnt > 0) { 
                $Status{$OVERALL_STATUS_STAGE} = $isValid ? $STATUS_FAILED : $STATUS_PASSED;
            }
            else {             
                $Status{$OVERALL_STATUS_STAGE} = $isValid ? $STATUS_FAILED : $STATUS_PASSED;
            }
        }
    }
#    # print "allSectionsPassed = $allSectionsPassed isValid = $isValid Status{$OVERALL_STATUS_STAGE} = $Status{$OVERALL_STATUS_STAGE}\n";

    my $passedStages = 0;
    foreach $name (@compilerPhaseList) {
        my $status = $Status{$name};
#        # print "TTT $name = $name status = $status\n";
        if ($status eq $STATUS_PASSED){
            $passedStages++;
#            # print "TTT name = $name passedStages = $passedStages\n";
        }
    }

    my $stageCnt = 0;
    if ( $currentHdl eq "verilog" ) {
        foreach my $stageName (@compilerPhaseList) {
            if ( !&isCslStage($stageName)) {$stageCnt++;}
        }
    }
    else {
        $stageCnt = $#compilerPhaseList +1; # FIX this is an approximation-if the --csim_gen flag if off then one stage should be subtracted. Not sure if this is worth doing
    }

    my $compilerPhasePassedPercentage = ($passedStages/($stageCnt)) * 100;
    my $percentage                    = sprintf( "%3d%", $compilerPhasePassedPercentage);
    $Status{$CPHASE_PASS_PERCENT_STAGE} = $percentage; # make it a percentage

# print "TTT total passedStages = $passedStages stageCnt = $stageCnt  percentage = $percentage\n";

    foreach $phase (@compilerPhaseList) {
        $StatusCssClass{$phase} = &getStatusCssClass($phase, $Status{$phase});         
    }

    if(0 == $foundUnit){ 
        my $phase = $CSIM_CODE_GEN_STAGE; 
        $Status{$phase} = $STATUS_PHASE_DID_NOT_RUN;
        $StatusCssClass{$phase} = &getStatusCssClass($phase, $Status{$phase});  
    }
 
#    $Status{$MINOR_ERROR_STAGE    } = $minorErrorCnt   ;   
#    $Status{$MAJOR_ERROR_STAGE    } = $majorErrorCnt   ;   
#    $Status{$VALGRIND_ERROR_STAGE } = $valgrindErrorCnt;   

    $StatusCssClass{$MINOR_ERROR_STAGE      } = &getStatusCssClass($MINOR_ERROR_STAGE      , $minorErrorCnt   );    
    $StatusCssClass{$MAJOR_ERROR_STAGE      } = &getStatusCssClass($MAJOR_ERROR_STAGE      , $majorErrorCnt   );    
    $StatusCssClass{$VALGRIND_ERROR_STAGE   } = &getStatusCssClass($VALGRIND_ERROR_STAGE   , $valgrindErrorCnt);    
    $StatusCssClass{$OVERALL_STATUS_STAGE   } = &getStatusCssClass($OVERALL_STATUS_STAGE   , $Status{$OVERALL_STATUS_STAGE   });  

    $StatusCssClass{$CPHASE_PASS_PERCENT_STAGE} = (100 == $compilerPhasePassedPercentage) ? $STATUS_PASSED : $STATUS_FAILED;

    if ($externalArguments{no_post_compile}) {
        $StatusCssClass{$CSLC_COMPILE_GENERATED_VERILOG     } = $CSS_STATUS_PHASE_DID_NOT_RUN;         
        $StatusCssClass{$GCC_COMPILE_GENERATED_SYSTEMC_CODE } = $CSS_STATUS_PHASE_DID_NOT_RUN; 
        $StatusCssClass{$GCC_COMPILE_GENERATED_CPP_CODE     } = $CSS_STATUS_PHASE_DID_NOT_RUN; 
        $StatusCssClass{$GCC_COMPILE_GENERATED_CSIM_CODE} = $CSS_STATUS_PHASE_DID_NOT_RUN; 
    }      
    else {
        $StatusCssClass{$CSLC_COMPILE_GENERATED_VERILOG     } = ($cslcVerilogCompileStatus eq $STATUS_PASSED) ? $CSS_STATUS_PASSED :( ($cslcVerilogCompileStatus eq $STATUS_FAILED) ? $CSS_STATUS_FAILED : $CSS_STATUS_PHASE_DID_NOT_RUN); 
        $StatusCssClass{$GCC_COMPILE_GENERATED_CPP_CODE     } = ($cslcCppCompileStatus     eq $STATUS_PASSED) ? $CSS_STATUS_PASSED :( ($cslcCppCompileStatus     eq $STATUS_FAILED) ? $CSS_STATUS_FAILED : $CSS_STATUS_PHASE_DID_NOT_RUN); 
        $StatusCssClass{$GCC_COMPILE_GENERATED_CSIM_CODE} = ($cslcCsimCompileStatus    eq $STATUS_PASSED) ? $CSS_STATUS_PASSED :( ($cslcCsimCompileStatus    eq $STATUS_FAILED) ? $CSS_STATUS_FAILED : $CSS_STATUS_PHASE_DID_NOT_RUN);
        $StatusCssClass{$GCC_COMPILE_GENERATED_SYSTEMC_CODE } = ($cslcSystemCCompileStatus eq $STATUS_PASSED) ? $CSS_STATUS_PASSED :( ($cslcSystemCCompileStatus eq $STATUS_FAILED) ? $CSS_STATUS_FAILED : $CSS_STATUS_PHASE_DID_NOT_RUN);
    }


# create the row to add to the TMP_LOOP
    my %testRow=(testNumber                   => $testCnt,
                 linkToLogFile                => $cslcLogFileShort,
                 testName                     => $testName        ,
                 linkToTestName               => $relativeFileName,
                 minorErrorCnt                => $minorErrorCnt   ,
                 majorErrorCnt                => $majorErrorCnt   ,
                 valgrindErrorCnt             => $valgrindErrorCnt,
                 compilerPhasePassedPercentage=> $Status{$CPHASE_PASS_PERCENT_STAGE  },
                 overallTestStatus            => $Status{$OVERALL_STATUS_STAGE       },   
                 cslcCompileVerilogCode       => $cslcVerilogCompileStatus,   
                 gccCompileCppCode            => $cslcCppCompileStatus    ,   
                 gccCompileCsimCode           => $cslcCsimCompileStatus   ,   
                 gccCompileSystemCCode        => $cslcSystemCCompileStatus,   
                 cslcCompileVerilogLog        => "gen_code/$testName/generated_code/generated_verilog/$cslcVerilogCompileLogName",   
                 gccCompileCppLog             => "gen_code/$testName/generated_code/generated_cpp/$cslcCppCompileLogName"        ,   
                 gccCompileCsimLog            => "gen_code/$testName/generated_code/generated_csim/$cslcCsimCompileLogName"      ,   
                 gccCompileSystemCLog         => "gen_code/$testName/generated_code/generated_systemc/$cslcSystemCCompileLogName",   

                 minorErrorCntCSSClass                 => $StatusCssClass{ $MINOR_ERROR_STAGE                   },    
                 majorErrorCntCSSClass                 => $StatusCssClass{ $MAJOR_ERROR_STAGE                   },    
                 valgrindErrorCntCSSClass              => $StatusCssClass{ $VALGRIND_ERROR_STAGE                },    
                 overallTestStatusCSSClass             => $StatusCssClass{ $OVERALL_STATUS_STAGE                },
                 compilerPhasePassedPercentageCSSClass => $StatusCssClass{ $CPHASE_PASS_PERCENT_STAGE           },    
                 cslcCompileGenVerilogStatusCSSClass   => $StatusCssClass{ $CSLC_COMPILE_GENERATED_VERILOG      },
                 gccCompileGenCppStatusCSSClass        => $StatusCssClass{ $GCC_COMPILE_GENERATED_CPP_CODE      },
                 gccCompileGenCsimStatusCSSClass       => $StatusCssClass{ $GCC_COMPILE_GENERATED_CSIM_CODE     },
                 gccCompileGenSystemCStatusCSSClass    => $StatusCssClass{ $GCC_COMPILE_GENERATED_SYSTEMC_CODE  },

                 );

    foreach $stageName (@compilerPhaseList) {
        my $s = $stageName . "Status";
        $testRow{$s} = $Status{$stageName}
    }

    foreach $stageName (@compilerPhaseList) {
        my $s = $stageName . "StatusCSSClass";
        $testRow{$s} = $StatusCssClass{$stageName}
    }

    # print "[INFO] getFileErrors: end \n";
    return %testRow;
}

#################################################################################################
#                                          isCslStage                                           #
# return true if the stage is only run for CSL tests                                            #
#################################################################################################

sub isCslStage {
    my ($stageName) = @_;
    $cslStage = 0;  
    if    ($stageName eq $INST_TREE_STAGE    ) { $cslStage = 1; }  
    elsif ($stageName eq $AUTO_ROUTER_STAGE  ) { $cslStage = 1; }  
    elsif ($stageName eq $AUTO_MAPPER_STAGE  ) { $cslStage = 1; }  
    elsif ($stageName eq $CSLOM_CHECKER_STAGE) { $cslStage = 1; }  
    elsif ($stageName eq $CPP_CODE_GEN_STAGE ) { $cslStage = 1; }  
    elsif ($stageName eq $CSIM_CODE_GEN_STAGE) { $cslStage = 1; }  
    elsif ($stageName eq $ADAPTER_STAGE      ) { $cslStage = 1; }        
    # print "isCslStage stageName = $stageName cslStage = $cslStage\n";
    return $cslStage;
}

#################################################################################################
#                                          findErrors                                           #
# find an error in a line                                                                       #
#################################################################################################

sub findErrors {
    my ($line) = @_;
#    # print "findErrors line = $line\n";

    my $errorType = 0;
    if( $line =~ m/(abort)/i               ) { $errorType = $MAJOR_ERROR; }
    elsif( $line =~ m/(assert)/i           ) { $errorType = $MAJOR_ERROR; }
    if( $line =~ m/(antlr exception)/i  ) { $errorType = $MAJOR_ERROR; }
    elsif( $line =~ m/(exception)/i        ) { $errorType = $MAJOR_ERROR; }
    elsif( $line =~ m/(noviablealt)/i      ) { $errorType = $MAJOR_ERROR; }
    elsif( $line =~ m/(segmentation)/i     ) { $errorType = $MAJOR_ERROR; }
    elsif( $line =~ m/(error)/i            ) { $errorType = $MINOR_ERROR; }
    elsif( $line =~ m/(type check on cast failure)/i ) { $errorType = $MAJOR_ERROR; }
    elsif ($line =~ m/LEAK SUMMARY/                  ) { $errorType = $VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid free/                  ) { $errorType = $VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid write/                 ) { $errorType = $VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid read/                  ) { $errorType = $VALGRIND_ERROR; }
    elsif ($line =~ m/Mismatched free/               ) { $errorType = $VALGRIND_ERROR; }
    elsif ($line =~ m/Conditional jump or move depends on uninitialised value/) { $errorType = $VALGRIND_ERROR; }

    return $errorType; 
}


#################################################################################################
#                                          getStatusCssClass                                    #
# returns the CSS class that corresponds to the status                                          #
#################################################################################################

sub getStatusCssClass {
    my($compilerPhase, $status) = @_;
    my $cssStatus = "";

#    print "getStatusCssClass: compilerPhase = $compilerPhase status = $status\n";

    if ($status eq $STATUS_FAILED) { $cssStatus = $STATUS_FAILED; }
    elsif ($status eq $STATUS_PASSED) { 
        $cssStatus = $STATUS_PASSED;
    }
    elsif (($compilerPhase eq $MINOR_ERROR_STAGE) || ($compilerPhase eq $MAJOR_ERROR_STAGE) || ($compilerPhase eq $VALGRIND_ERROR_STAGE)) {
        if ($status != 0) { $cssStatus = $STATUS_FAILED; }
        else              { $cssStatus = $STATUS_PASSED; }
    }
    elsif ($status eq $STATUS_PHASE_DID_NOT_RUN ) { $cssStatus = $CSS_STATUS_PHASE_DID_NOT_RUN; }
    elsif ($status eq $STATUS_VALGRIND_ERROR    ) { $cssStatus = $CSS_STATUS_VALGRIND_ERROR;    }
    else  { die "[ERROR] contact developer: default else statement compilerPhase = $compilerPhase status = $status"; }

    return $cssStatus;
}

#################################################################################################
#                                          file_exists                                          #
#subroutine for testing if a file exists and gives an warning message                           #
#################################################################################################

sub file_exists {
    my ($name) = @_[0];
    unless (-e $name) { print ("[ERROR] File doesn't exist: '$name'\n"); return 0;}
    return 1;
}

#################################################################################################
#                                          display_message                                      #
#subroutine for printing a message                                                              #
#################################################################################################

sub display_message {
    my ($message_content) = @_[0];
#    if( $verbose eq 1 ) {print "$message_content"; }
}

#################################################################################################
#                                            usage                                              #
#subroutine for printing the regress parser usage                                               #
#################################################################################################

sub usage {
    print "#########################\n";
    print "# Regress Parser Usage: #\n";
    print "#########################\n";
    print "[perl] run_regress.pl -hdl <name> [-www] [-results_dir <path2>] [-no_exec] [-errors_only] [-dir_filter <directory_name>] 
          [-h] [-version] [-v] [-val] [-no_post_compile] [-no_post_compile_cpp]\n";
    print "[INFO] The variabile WORK is the path to your home folder (must be defined in .bash_profile)
           ex: WORK=$HOME/svn or WORK=$HOME/fpl/cslc (no final slash) \n";
    print " -hdl <name>          -> only tests from hdl named <name> are chosen. <name> can be one of the folowing: 
                                    verilog         : run the Verilog verilog    tests.
                                    csl             : run the CSL csl            tests (golden test suite).  
                                    csl_v2          : run the CSL csl_v2         tests (CSL version 2 tests).
                                    csl_new_bug     : run the CSL csl_new_bug    tests (tests that should be verified and promoted to csl golden.
                                    csl_test_gen    : run the CSL csl_test_gen   tests (Tibi test generators).
                                    csl_design_gen  : run the CSL csl_design_gen tests (designGen.cpp) .
                                    csl_cc_gen      : run the CSL csl_cc_gen     tests (Perl script corner case generators).
                                    \n";
    print " -dir_filter <filter> -> only run the regression script on the specified directory. \n";  
    print " -errors_only         -> only display the failed tests in the HTML output \n";  
    print " -maojor_errors_only  -> only display the failed tests with MAJOR ERRORS in the HTML output \n";  
    print " -www                 -> pops up firefox with the html results. \n";  
    print " -no_post_compile     -> Do not compile the generated code. \n";  
    print " -no_post_compile_cpp -> Do not compile the CPP and CSIM CPP generated code. \n";  
    print " -no_post_compile_systemc -> Do not compile the SystemC CPP generated code. \n";  
    print " -results_dir <path2> -> saves the current results files to <path2>. \n";
    print " -no_exec             -> do not run cslc; the regression generates the HTML report using the last version of the results files. \n";
    print " -h                   -> display help info\n";
    print " -version             -> prints version\n";
    print " -v                   -> verbosity on \n";
    print " -val                 -> run valgrind to detect memory leaks\n";
}  

#################################################################################################
#                                          finishUp                                             #
#subroutine for finishing the regress when a signal is received                                 #
#################################################################################################

sub finishUp() {
    my($test_start_time, $totalPercentPassed) = @_;
    
    # print "[WARNING] Caught $signalName . Finishing up...\n";
    # print "\nCaught $signalName ! Regression halted!\n";

    $index   = rand @array;
    $element = $array[$index];
    die "$element\n";
}

#################################################################################################
#                                          initSignal                                           #
#subroutine for catching signals                                                                #
#################################################################################################

sub initSignal {
    my ($test_start_time, $totalPercentPassed) = @_;
    
    use Config; #checking if the system has signals enabled
    defined $Config{sig_name} || print "[WARNING] No signals detected. Type kill -l for the list of signals. If there are signals, please report this to $maintainer\n";
    $SIG{INT}  = sub { $signalName = "SIGINT";  &finishUp($test_start_time,$totalPercentPassed);  };
    $SIG{TERM} = sub { $signalName = "SIGTERM"; &finishUp($test_start_time,$totalPercentPassed);  };
    $SIG{HUP}  = sub { $signalName = "SIGHUP";  &finishUp($test_start_time,$totalPercentPassed);  };
}

sub postProcess {
    my ($currentHdl, $status) = @_;
    @e = keys %errorListByCompilerPhase;

    my $errorFile =  "$resultsRootDir/compiler_phase_error_report.txt";

    # print "Writing file $errorFile\n";
    open(ERROR_FH, "> $errorFile");

    print ERROR_FH "phaseCnt = $#e\n";
    print ERROR_FH "errorListByCompilerPhase = ", %errorListByCompilerPhase, "\n";
    print ERROR_FH "compilerPhaseList cnt = $#compilerPhaseList compilerPhaseList = @compilerPhaseList\n";

    foreach $phase (@compilerPhaseList){
        $phaseList = $errorListByCompilerPhase{$phase};
        my @a = @{$phaseList};
        print ERROR_FH "\n\nErrorList: test errors phase: $phase error cnt = $#a\n";
        if (@a ) {
            foreach $er (@a){
                my %errorRecord = %{$er};
                if (%errorRecord) {
                    if ("" eq $errorRecord{"minorError"}){
                        print ERROR_FH "    major error phase: $phase directory: ", $errorRecord{"directory"} ," testname: ", $errorRecord{"testname"}, "\.$currentHdl   major_error: ", $errorRecord{"majorError"}, "\n";
                    }
                }
            }
            foreach $er (@a){
                my %errorRecord = %{$er};
                if (%errorRecord) {
                    if ("" eq $errorRecord{"majorError"}){
                        print ERROR_FH "    minor error phase: $phase directory: ", $errorRecord{"directory"} ," testname: ", $errorRecord{"testname"}, "\.$currentHdl   minor_error: ", $errorRecord{"minorError"}, "\n";
                        print ERROR_FH "\n";
                    }
                }
            }
        }
    }

    close(ERROR_FH);

    if ( $externalArguments{mail} ){ # send the report to 
        print "sending email to team = ", %ownerListByCompilerPhase,"\n"; 
        &mail('dpappas@fplsrl.com', $errorFile);
        &mail('camarand@fplsrl.com', $errorFile);

        foreach $owner (values %ownerListByCompilerPhase) {
            print "sending email to $owner\n";
            &mail($owner, $errorFile);
        }
    }             

#    &news();
# print a random message for entertainment value
    $index   = rand @array;
    $element = $array[$index];
    print "\n\n$element\n\n\n";

    print "Exit msg: $exitMsg\n";
    print "Overall regression status = $status\n";
    if ($STATUS_PASSED eq $status){ exit 0; }
    else                          { exit 1; }
}

sub news {

    print ("NEWS BULLETIN 2\n");
    print ("See help.\n");
#    print ("You can track the progress of your changes using the graphs.\n");
#    print ("Three different .png files are created in the directory that you run the graph_regress.pl script in.\n");
#    print ("Load the .png files into your browser to see the graph\n");
#    print ("Did you know you can use the -errors_only flag to see only tests with errors in the generated HTML reports");
#    print ("Did you know you can use the -major_errors_only flag to see only tests with major errors (e.g. seg faults) in the generated HTML reports");
#    print ("Did you know that you can use the -dir_fitler option to only run a particular directory\n");
#    print ("Did you know that you can run the CSL version two tests in the test/csl_v2 directory with -hdl csl_v2?\n");
#    print ("Include test directories that have no tests using the -include_empty_dirs flag.\n");
#    print ("The default is now to exclude test directories that have no tests.\n");
#    print ("Added new failed number of test column to summary page\n");
#    print ("MOVED MAJOR ERRORS TO THE FIRST COLUMN-PLEASE FIX THESE ERRORS FIRST!\n");
#    print ("\n");
    print ("Send dpappas@fplsrl.com any enhancement suggestions for the run_regress.pl and graph_regress.pl scripts\n");

    print ("Your friendly neighborhood design automation engineer.\n");
}



#################################################################################################
#                                       mail                                                    #
#subroutine that sends a mail on company with the asserts and seg faults                        #
#################################################################################################

sub mail {
    my ( $to_address, $errorFile) = @_;
    my $from_address = "";
    print "[INFO] mail: begin \n";

    if (defined $ENV{USER}) {
        $from_address = "$ENV{USER}\@fplsrl.com";
    }
    else {
        $from_address = "dpappas\@fplsrl.com";
    }
    my $subject      = "compiler stage error report: $test_date_start";
    my $message_body = "Here's the attachment file(s) you wanted";
    my $attachment   = "";
    my $mail_host    = "mail.fplsrl.com";
    # print "to_address = $to_address\n";
    ### Create the multipart container
    $msg = MIME::Lite->new (
                            From => $from_address,
                            To => $to_address,
                            Subject => $subject,
                            Type =>'multipart/mixed'
                            ) or die "Error creating multipart container: $!\n";
    
    open(FH, "< $errorFile");
    my @attachment = <FH>;
    close(FH);
    
    my $attachment = join('', @attachment);

    ### Add the text message part
    $msg->attach (
                  Type => 'TEXT',
                  Data => $attachment,
                  ) or die "Error adding the text message part: $!\n";
    
    print" Send the Message from $from_address to $to_address via mail host  $mail_host\n";
    MIME::Lite->send('smtp', $mail_host, Timeout=>60);
    $msg->send;
      
    print "[INFO] mail: end \n";
}

#################################################################################################
#                                         topXmlReport                                          #
#subroutine that prints the top Xml report                                                      #
#################################################################################################

sub topXmlReport {
    my($xmlFile) = @_;
    # print "[INFO] topXmlReport: begin \n";

    open (REPORT_XML, "> $xmlFile") or die ("[ERROR] check_results: Error opening $xmlFile report file !\n");
    chomp( my $arch  = `arch` ); #getting information about the current system
    printf REPORT_XML "%s\n"  , "<?xml version=\"1.0\"?>";
    printf REPORT_XML "%s\n"  , "<testsuite>";
    printf REPORT_XML "\t%s\n", "<name>$currentTestDirectory</name>";
    printf REPORT_XML "\t%s\n", "<date>".$test_date."</date>";
    printf REPORT_XML "\t%s\n", "<machine_architecture>".$arch."</machine_architecture>";
    printf REPORT_XML "\t%s\n", "<regression_script_path>".$scriptDir."</regression_script_path>";
    # print "[INFO] topXmlReport: end \n";
}

#################################################################################################
#                                     updateXmlReport                                           #
#subroutine for updating the xml file with the statistics read from the logs                    #
#################################################################################################

sub updateXmlReport {
    printf REPORT_XML "\t%s\n"                 , "<test>";
    printf REPORT_XML "\t\t<name>%s</name>\n"  , "@testname[1].v";
    printf REPORT_XML "\t\t<type>%s</type>\n"  , "$currentHdl";
# FIX - RM     printf REPORT_XML "\t\t<pps>%s</pps>\n"    , ($preprocessor_error_found ? "F":"P");
    printf REPORT_XML "\t\t<ps>%s<>\n"      , ($parser_error_found ? "F" : $cntValues{warning} ? "W" : "P");
    printf REPORT_XML "\t\t<vmps>%s</vmps>\n"  , ($valgrind_error_found ? "F":"P");
    printf REPORT_XML "\t\t<vmpps>%s</vmpps>\n", ($valgrind_error_found ? "F":"P");
    printf REPORT_XML "\t\t<tr>%s</tr>\n"      , "TDNE";
    printf REPORT_XML "\t%s\n"                 , "</test>";
}

#################################################################################################
#                                      errorHtmlReport                                          #
#subroutine that prints how many errors do we have                                              #
#################################################################################################

sub errorHtmlReport {
    my @numberOfErrors=("Tests passed: $cntValues{pass_cnt} of $total_noskip \n",
                        "Sources cnt for this testsuite: $cntErrorValues{num_tests}\n",
                        "Warnings:              $cntErrorValues{warnings}\n",
                        "Memcheck errors:       $cntErrorValues{memcheckErrors}\n",
                        "Exception errors:      $cntErrorValues{exception_error}\n",      
                        "Assert errors:         $cntErrorValues{assert_error}\n",
                        "Seg fault errors:      $cntErrorValues{seg_fault_error}\n",
                        "Abort errors:          $cntErrorValues{abort_error}\n",
                        "No via alt errors:     $cntErrorValues{no_via_alt}\n",
                        "Mismatch errors:       $cntErrorValues{mismatch_error}\n",
                        "Unexpect token errors: $cntErrorValues{unexpected_token}\n",
                        "Normal Error:          $cntErrorValues{normal_error}\n",
# FIX - RM                        "Errors preprocessing Verilog program: $cntErrorValues{pps_error}\n",
                        "Passed percentage:     $percent_passed\n");
#    foreach $k(@numberOfErrors){ print REPORT "<tr align=\"center\"><td colspan=\"$colSpan\" class=\"error\">".$k ."</td></tr>";}
}

#################################################################################################
#                                          errorXmlReport                                       #
#subroutine that prints how many errors do we have in the Xml report                            #
#################################################################################################

sub errorXmlReport {
    printf REPORT_XML "\t%s\n", "<warnings>$cntErrorValues{warnings}</warnings>";
    printf REPORT_XML "\t%s\n", "<memcheck_errors>$cntErrorValues{memcheckErrors}</memcheck_errors>";
    printf REPORT_XML "\t%s\n", "<exception_errors>$cntErrorValues{exception_error}</exception_errors>";
    printf REPORT_XML "\t%s\n", "<assert_errors>$cntErrorValues{assert_error}</assert_errors>";
    printf REPORT_XML "\t%s\n", "<segmentation_fault_errors>$cntErrorValues{seg_fault_error}</segmentation_fault_errors>";
    printf REPORT_XML "\t%s\n", "<abort_errors>$cntErrorValues{abort_error}</abort_errors>";
    printf REPORT_XML "\t%s\n", "<no_via_alt_errors>$cntErrorValues{no_via_alt}</no_via_alt_errors>";
    printf REPORT_XML "\t%s\n", "<mismatch_errors>$cntErrorValues{mismatch_error}</mismatch_errors>";
    printf REPORT_XML "\t%s\n", "<unexpected_token_errors>$cntErrorValues{unexpected_token}</unexpected_token_errors>";
    printf REPORT_XML "\t%s\n", "<normal_errors>$cntErrorValues{normal_errors}</normal_errors>";
    printf REPORT_XML "\t%s\n", "<preprocessing_errors>$preprocessor_error</preprocessing_errors>";
    printf REPORT_XML "\t%s\n", "<all_tests_cnt>$cntErrorValues{num_tests}</all_tests_cnt>";
    printf REPORT_XML "\t%s\n", "<tests_passed_cnt>$cntValues{pass_cnt}</tests_passed_cnt>";
    printf REPORT_XML "\t%s\n", "<tests_passed_percentage>$percent_passed</tests_passed_percentage>";
    printf REPORT_XML "\t%s\n", "<testsuite_overall_status>".($percent_passed ne 100 ? $STATUS_FAILED:$STATUS_PASSED)."</testsuite_overall_status>";
    printf REPORT_XML "</testsuite>";
    close ( REPORT_XML );
}

#################################################################################################
#                                       initErrorCnters                                    #
#subroutine that initialized the values for Html report                                         #
#################################################################################################

sub initErrorCnters {
    @initCntValues=("pass_cnt","crash_cnt","warning");
    @initErrorsValues=("num_tests","exception_error","assert_error","seg_fault_error", "abort_error","no_via_alt","mismatch_error","unexpected_token","normal_error","memcheckErrors","warnings");
    foreach $k(@initCntValues){ $cntValues{$k}=0;}
    foreach $k(@initErrorsValues){ $cntErrorValues{$k}=0;}
}

#################################################################################################################################################
# helper functions
#################################################################################################################################################

sub testFileExists {
    my($execName) = @_;
    unless(-e $execName) { die "[ERROR] The file $execName does not exist!\n"; }
    # print "[INFO] file $execName exists\n";
}

sub testDirExists {
    my($dirName) = @_;
    unless(-e $dirName) { die "[ERROR] The directory $dirName does not exist!\n"; }
    # print "[INFO] directory $dirName exists\n";
}

sub mkDir {
    my($dirName) = @_;
    unless(-e $dirName)  { mkpath("$dirName"); }
    # print "[INFO] Created directory $dirName\n";
}

sub copyFile {
    my($fileName, $dirName) = @_;
    # print "[INFO] cp $fileName $dirName\n";
    unless(-e "$fileName" && -e "$dirName" ) { `cp $fileName $dirName` };
}
