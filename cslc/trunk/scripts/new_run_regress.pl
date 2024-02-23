#!/usr/bin/perl

#Maintainers(s): Ines and Petronela and Derek

use lib "$ENV{WORK}/trunk/scripts";
use Regress;
use FplLib;
use strict;
use Config; #checking if the system has signals enabled
use POSIX qw(ceil floor);

use constant maintainer  => "Petronela E. and Ines C. and Derek"; #put your name here if you are the current maintainer of this script
use constant myVersion   => "0.4";
#use constant wgs         => 0; # Total no of warnings

#require "$ENV{WORK}/trunk/scripts/regress_include.pl";

my %externalArguments = (); # command line args

#TODO: modify the next line so that is platform independent (can be run on x86_32 too etc.)
chomp( my $arch = `arch`); #getting information about the current system
my $buildDir = $Regress::totDir . "/trunk/build/linux/$arch";
print "totDir = ", $Regress::totDir,"\n";
print "scriptsDir = $Regress::scriptsDir\n";
my $cslcExec = "$buildDir/cslc/cslc";              # cslc executable
&FplLib::testFileExists($cslcExec);

my $signalName = "";

my $help                 = "";
my $version              = "";
my $verbose              = "";
my $hdlExtParam          = "";
my $exitMsg              = "";
my $enableValgrind       = "";
my $no_execute           = "";
my $results_dir          = "";
my $firefox              = "";
my $mail                 = "";
my $testDirFilter        = "";
my $errorsOnly           = "";
my $majorErrorsOnly      = "";
my $noPostCompile        = "";
my $noPostCompileCpp     = "";
my $noPostCompileSystemC = "";
my $include_empty_dirs   = "";

my  @lexer_stage             = {};
my  @parser_stage            = {};
my  @walker_stage            = {};
my  @inst_tree_stage         = {};
my  @auto_router_stage       = {};
my  @auto_mapper_stage       = {};
my  @cslom_checker_stage     = {};
my  @cpp_code_gen_stage      = {};
my  @csim_code_gen_stage     = {};
my  @adapter_stage           = {};
my  @cdom_checker_stage      = {};
my  @verilog_code_gen_stage  = {};
my  @system_c_code_gen_stage = {};
my  @valgrind_stage          = {};

my  %errorListByCompilerPhase = (
 STAGE_LEXER              => \@lexer_stage            ,
 STAGE_PARSER             => \@parser_stage           ,
 STAGE_WALKER             => \@walker_stage           ,
 STAGE_INST_TREE          => \@inst_tree_stage        ,
 STAGE_AUTO_ROUTER        => \@auto_router_stage      ,
 STAGE_AUTO_MAPPER        => \@auto_mapper_stage      ,
 STAGE_CSLOM_CHECKER      => \@cslom_checker_stage    ,
 STAGE_CPP_CODE_GEN       => \@cpp_code_gen_stage     ,
 STAGE_CSIM_CODE_GEN      => \@csim_code_gen_stage    ,
 STAGE_ADAPTER            => \@adapter_stage          ,
 STAGE_CDOM_CHECKER       => \@cdom_checker_stage     ,
 STAGE_VERILOG_CODE_GEN   => \@verilog_code_gen_stage ,
 STAGE_SYSTEM_C_CODE_GEN  => \@system_c_code_gen_stage,
 STAGE_VALGRIND           => \@valgrind_stage         ,    
);


&main();

################################################################################

sub main {

    print "STAGE_CSIM_CODE_GEN = ", $Regress::STAGE_CSIM_CODE_GEN ,"\n";


    print "maintainer = ", maintainer,"\n";
    
    &FplLib::display_message( "[INFO] Your system architecture is: $arch\n");
    #    if($arch ne 'i686' and $arch ne 'x86_64') {
    #        die "[ERROR] initGeneral: Your architecture $arch is not supported by this script. Only  Linux x86_64 and x86_32 are supported.\n";
    #    }
    
    %externalArguments = &processExternalArgs();           #testing if the arguments are correct and if so then they are processed
    
    my $cslTestRootDir     = $Regress::testRootDir . "/$externalArguments{hdlExtParam}";
    
    
    &FplLib::testDirExists($cslTestRootDir    );
    &FplLib::testDirExists($Regress::verilogTestRootDir);
    &FplLib::testDirExists($Regress::reportRootDir     );
    
    ################################################################################
    # set the current regression directories
    # create a new results directory for each new regression
    ################################################################################
    my $resultsRootDir = "";
    
    if ($externalArguments{results_dir} eq "" ) {
        chomp (my $results_date = `date "+%d.%m.%G_%T"`);
        $results_date =~ s/(:)/_/g;
        $resultsRootDir = $Regress::reportRootDir . "/results_". $results_date;     #the results directory
        print "[INFO] Created resultsDir = $resultsRootDir \n";
        `mkdir $resultsRootDir`;
    }
    else {
        $resultsRootDir = $externalArguments{results_dir};                           #the results directory
        if ($externalArguments{"no_execute"} eq "") {
            &FplLib::mkDir($resultsRootDir);
            print "[INFO] Created resultsDir = $resultsRootDir because  -results_dir is set no_execute = ", $externalArguments{"no_execute"} , "\n";
        }
        else {
            if(-d $resultsRootDir ) {  print "[INFO] User set resultsDir = $resultsRootDir no_execute = ", $externalArguments{"no_execute"} , "\n"; }
            else { die "[ERROR] -no_exec set and -results_dir called with directory $resultsRootDir which does not exist\n";}
        }
    }       
    
    &initSignal($resultsRootDir, $Regress::test_start_time); 
    
    &testAllDependencies();
    
    if( $externalArguments{"hdlExtParam"} eq "all" ) {
        die "[EXIT] -hdl all is deprecated only -hdl csl or -hdl csl_v2 or -hdl verilog are allowed\n";
    }
    
    my $currentHdl = $externalArguments{"hdlExtParam"};
    print("[INFO] current HDL language: $currentHdl\n");
    
    my $status = "Did not run any tests";
    
    if($externalArguments{"hdlExtParam"}) {
        my $testDirFilter = $externalArguments{"dir_filter"};
        $status = &Regress::regressHdl($resultsRootDir, $currentHdl, $testDirFilter, \%externalArguments );
    }
    else {
        # print "[ERROR] no -hdl arg specified on the command line";
    } 
    &postProcess($resultsRootDir, $currentHdl, $status);
    
    
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
    my $argument = GetOptions(
                              'h'                       => \$help                , 
                              'help'                    => \$help                , 
                              'version'                 => \$version             ,
                              'v'                       => \$verbose             , 
                              'hdl:s'                   => \$hdlExtParam         ,
                              'msg:s'                   => \$exitMsg             ,
                              'val'                     => \$enableValgrind      ,
                              'no_exec'                 => \$no_execute          ,
                              'results_dir:s'           => \$results_dir         ,
                              'www'                     => \$firefox             ,
                              'mail'                    => \$mail                ,
                              'dir_filter:s'            => \$testDirFilter       ,
                              'errors_only'             => \$errorsOnly          ,
                              'major_errors_only'       => \$majorErrorsOnly     ,
                              'no_post_compile'         => \$noPostCompile       ,
                              'no_post_compile_cpp'     => \$noPostCompileCpp    ,
                              'no_post_compile_systemc' => \$noPostCompileSystemC,
                              'include_empty_dirs'      => \$include_empty_dirs   
                              );
    
    print "hdlExtParam = $hdlExtParam\n";
    
    %externalArguments = ( 
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
        print"[EXIT] FPL Regression Parser - VERSION: ", myVersion , "\nCurrent maintainer: ", maintainer ,". Type -h for help usage information.\n";
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
#                                          regressDir                                           #
#subroutine for calling the regression for a specific dir                                       #
#################################################################################################

sub regressDir{
    my($resultsRootDir, $currentTestDirectory, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdl, $currentHdlDirectory) = @_; #read the parameter
    
    # print "[INFO] regressDir: begin\n";
    my %testResults = ();
    #    if ( ! $externalArguments{"no_execute"}) {
    my @testlist = &generate_regression_list( $currentTestDirectory, $currentHdl ); # Generating regression lists for $currentTestDirectory
    @testlist = sort(@testlist);
    # print ("[INFO] regressDir: sourceDir = $currentTestDirectory testlist cnt = $#testlist\n"); 
    # print ("[INFO] regressDir: Executing regression for $currentTestDirectory testlist cnt = $#testlist\n"); 
    %testResults = &executeDirectoryTestlist($resultsRootDir, $currentHdl, $currentTestDirectory, \@testlist, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdlDirectory );  
    #    }
    
    if($testResults{totalDirNumTests} == 0) {
        # print "[INFO] REGRESSION FAILED ! -  $currentTestDirectory directory is empty called in $testRootDir/$externalArguments{"hdlExtParam"}\n";
    }
    
    # print "[INFO] regressDir: end testResults = ", %testResults, "\n";
    return %testResults;
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
    
    #    my $testDirPath = $Regress::testRootDir . "/$currentHdl/$currentTestDirectory/*.$hdlFileExtension";
    my $testDirPath = $Regress::testRootDir . "/$currentHdl/$currentTestDirectory";
    
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
    
    foreach my $fileName( @file_list ) { # remove the Verilog files which do not have modules
        chomp( $fileName );  #removes \n
        push ( @testlistWithPath, $testDirPath . "/$fileName" );
    }       
    
    if (&isCslHdlArg($currentHdl) ) {
        @testlist = @testlistWithPath;
    }
    else {
        
        foreach my $fileName( @testlistWithPath ) { # remove the Verilog files which do not have modules
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
    my($resultsRootDir, $currentHdl, $currentTestDirectory, $testlist, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdlDirectory) = @_;
    
    my @testlist =  @{$testlist};
    my $test_date = `date "+%d/%m/%G, %T"`;
    chomp($test_date);
    
    # print "[INFO] executeDirectoryTestlist: begin currentTestDirectory = $currentTestDirectory cnt = $#testlist testlist = @testlist testlist\n";
    my $testSrcDir = $Regress::testRootDir . "/$currentHdl/$currentTestDirectory";
    my $chapterDir = "$currentHdlDirectory/$currentTestDirectory";
    
    # create the directory to put the generated code from the compiler
    my $genCodeRootDir = "$chapterDir/gen_code";
    &FplLib::mkDir($genCodeRootDir);
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
    
    foreach my $stageName (@Regress::compilerPhaseList) {
        my $s = $stageName . "Status";
        $numStagesPassed{$s} = 0;
    }
    
    # create a linked list of pages to add to the html page
    my %mapPages = ();  
    
    # print "totalTestListPageNum = $totalTestListPageNum total_pages = $totalTestListPageNum numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
    for ( my $k = 0; $k < $totalTestListPageNum; $k++ ) {
        my $linkPage = "../../".$testListSummaryFileWithOutHtmlExt . "_$k.html";
        $mapPages{$k} = $linkPage; 
        # print "linkPage = $linkPage\n";
    }
    
    # put the create a linked list of pages that will be created into URL links
    my @listPageNums = sort keys %mapPages;
    my @pageLinkList = {}; # list to pass to the page template               
    
    for ( my $k = 0; $k <= $#listPageNums; $k++ ) {
        my %pageRow=(pageLink => $mapPages{$k},
                     pageNum  => $k);  
        push(@pageLinkList, \%pageRow);
    }
    
    my $cslcVerilogCompileStatus = $Regress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcCppCompileStatus     = $Regress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcCsimCompileStatus    = $Regress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcSystemCCompileStatus = $Regress::STATUS_PHASE_DID_NOT_RUN;
    
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
    my $testListSummaryFilePageNum = 0;
    my $testListPageTemplate;
    my @testListLoop = ();
    foreach my $testPathName (@testlist) {
        #        print "Executing test: $testPathName\n";
        
        if ( 0 == ($includedTestNumber % $numTestsPerHtmlPage)) { # a page is created when the testcnt == $numTestsPerHtmlPage
            # print "Created template totalDirNumTests = $totalDirNumTests includedTestNumber = $includedTestNumber = numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
            $testListPageTemplate = HTML::Template->new(filename => $Regress::htmlTemplateDir . "/test_list_page.tmpl");
            $testListPageTemplate->param(dateTime      => $Regress::test_start_time       );
            $testListPageTemplate->param(styleCss      => "../../../../../trunk/scripts/regress_html_templates/" . $Regress::styleCssFile );
            $testListPageTemplate->param(testDirName   => $currentTestDirectory  );
            $testListPageTemplate->param(testDirValInv => $testDirValInv         );
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
            my $retVal = $?;
            my $errorNumber = ( $retVal >> 8 );
            `echo "cmd = $cmd"  >> $cslcLogFile`;
            
            if ( defined ($Regress::systemErrorMap{$errorNumber})) {
                $majorError = $errorNumber;
                my $signalErrorMsg = $Regress::systemErrorMap{$errorNumber};
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
                
                my $outputVerilogCodeDir     = "$genCodeTestDir/generated_code/generated_verilog"; # directory with the generated Verilog code
                my $outputVerilogCodeVfFile  = &getVfFileName($outputVerilogCodeDir); # vf file containing the names of the generated Verilog files
                #print "outputVerilogCodeVfFile = $outputVerilogCodeVfFile\n";
                $cslcVerilogCompileLogName = "$testName" . "_verilog_compile.txt"; # cslc compile of generated verilog log file 
                $cslcVerilogCompileLog     = "$outputVerilogCodeDir/$cslcVerilogCompileLogName"; # cslc compile of generated verilog log file 
                my $cmd                    = "$cslcExec -f $outputVerilogCodeVfFile > $cslcVerilogCompileLog  2>&1";
                print("$cmd\n");
                system("$cmd");
                #print("cslc gen cmd = $cmd\n");
                my $retVal = $?;
                my $errorNumber = ( $retVal >> 8 );
                if ( defined ($Regress::systemErrorMap{$errorNumber})) {
                    $majorError = $errorNumber;
                    my $signalErrorMsg = $Regress::systemErrorMap{$errorNumber};
                    `echo "found signal:$signalErrorMsg"  >> $cslcVerilogCompileLog`;
                    #$totalDirMajorErrorCnt++;
                    print "[MAJOR ERROR] compiling generated Verilog code from testname = $testPathName\n";
                } 
                $cslcVerilogCompileStatus = $retVal == 0 ? $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;      
                
            }
            
            if (($retVal == 0) 
                && ! $externalArguments{no_post_compile}  
                && ! $externalArguments{no_post_compile_systemc}
                && $currentHdl ne "verilog" ){
                
                
                ################################################################################
                # Compile the CSLC generated SystemC code with gcc
                ################################################################################
                
                my $outputSystemCCodeDir  = "$genCodeTestDir/generated_code/generated_systemC"; # directory with the generated SystemC code
                $cslcSystemCCompileLogName = "$testName" . "_systemC_compile.txt";
                $cslcSystemCCompileLog = "$outputSystemCCodeDir/$cslcSystemCCompileLogName"; # cslc compile of generated systemC log file 
                my $cwd                = `pwd`;
                my $outputSCCodeDir       = "$genCodeTestDir/systemc_generated_code" ;
                if (-e $outputSCCodeDir) {
                    system("cd $outputSCCodeDir");# || die ("[ERROR] $outputSCCodeDir does not exist\n"); # go to the generated SystemC directory 
                    system("make > $cslcSystemCCompileLog 2>&1"); # call the generated make file
                    my $retVal = $?; # get the return value from the command just executed
                    system("cd $cwd"            ); # return to our current directory
                    my $errorNumber = ( $retVal >> 8 ); # move the uppoer byte to the lower byte
                    if ( defined ($Regress::systemErrorMap{$errorNumber})) {
                        $majorError = $errorNumber;
                        my $signalErrorMsg = $Regress::systemErrorMap{$errorNumber};
                        `echo "found signal:$signalErrorMsg"  >> $cslcSystemCCompileLog`;
                        #$totalDirMajorErrorCnt++;
                        print "[MAJOR ERROR] compiling generated SystemC code from testname = $testPathName\n";
                    }
                    $cslcSystemCCompileStatus = $retVal == 0 ? $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;      
                }
                else {
                    $cslcSystemCCompileStatus = $Regress::STATUS_PHASE_DID_NOT_RUN;      
                }
                
            }
            if (($retVal == 0) && ! $externalArguments{no_post_compile}  && ! $externalArguments{no_post_compile_cpp} 
                && $currentHdl ne "verilog"){
                
                ################################################################################
                # Compile the CSLC generated C++ code with gcc
                ################################################################################
                
                my $outputCppCodeDir  = "$genCodeTestDir/generated_code/generated_cpp"; # directory with the generated Cpp code
                $cslcCppCompileLogName = "$testName" . "_cpp_compile.txt"; 
                $cslcCppCompileLog = "$outputCppCodeDir/$cslcCppCompileLogName"; # cslc compile of generated cpp log file 
                my $cwd            = `pwd`;
                my $outputSCCodeDir   = "$genCodeTestDir/cpp_generated_code" ;
                if (-e $outputCppCodeDir) {
                    system("cd $outputCppCodeDir &&  make > $cslcCppCompileLog 2>&1; ");
                    #print ("cd $outputCppCodeDir &&  make > $cslcCppCompileLog 2>&1; ");
                    my $retVal = $?; # get the return value from the command just executed
                    system("cd $cwd"            ); # return to our current directory
                    my $errorNumber = ( $retVal >> 8 ); # move the uppoer byte to the lower byte
                    if ( defined ($Regress::systemErrorMap{$errorNumber})) {
                        $majorError = $errorNumber;
                        my $signalErrorMsg = $Regress::systemErrorMap{$errorNumber};
                        `echo "found signal:$signalErrorMsg"  >> $cslcCppCompileLog`;
                        #$totalDirMajorErrorCnt++;
                        print "[MAJOR ERROR] compiling generated Cpp code from testname = $testPathName\n";
                    }
                    $cslcCppCompileStatus = $retVal == 0 ? $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;      
                }
                else {
                    $cslcCppCompileStatus = $Regress::STATUS_PHASE_DID_NOT_RUN;      
                }
                
                ################################################################################
                # Compile the CSLC generated C++ C simulator code with gcc
                ################################################################################
                if ($foundUnit ){ ## CSimGen only generates code if there are units
                    
                    my $outputCsimCodeDir  = "$genCodeTestDir/csim_generated_code"; # directory with the generated Csim code
                    $cslcCsimCompileLogName = "$testName" . "_csim_compile.txt"; # cslc compile of generated csim log file 
                    $cslcCsimCompileLog = "$outputCsimCodeDir/$cslcCsimCompileLogName"; # cslc compile of generated csim log file 
                    my $cwd             = `pwd`;
                    my $outputSCCodeDir    = "$genCodeTestDir/csim_generated_code" ;
                    if (-e $outputCsimCodeDir) {
                        system("cd $outputSCCodeDir");# || die ("[ERROR] $outputSCCodeDir does not exist\n"); # go to the generated Csim directory 
                        system("make > $cslcCsimCompileLog 2>&1"               ); # call the generated make file
                        my $retVal = $?; # get the return value from the command just executed
                        system("cd $cwd"            ); # return to our current directory
                        my $errorNumber = ( $retVal >> 8 ); # move the uppoer byte to the lower byte
                        if ( defined ($Regress::systemErrorMap{$errorNumber})) {
                            $majorError = $errorNumber;
                            my $signalErrorMsg = $Regress::systemErrorMap{$errorNumber};
                            `echo "found signal:$signalErrorMsg"  >> $cslcCsimCompileLog`;
                            #$totalDirMajorErrorCnt++;
                            print "[MAJOR ERROR] compiling generated Csim code from testname = $testPathName\n";
                        }
                        $cslcCsimCompileStatus = $retVal == 0 ? $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;      
                    }
                    else {
                        $cslcCsimCompileStatus = $Regress::STATUS_PHASE_DID_NOT_RUN;      
                    }
                }
            }
        }   
        
        my %testRow = &getFileErrors ($currentHdl, $cslcLogFile, $totalDirNumTests, $testName, $testPathName, $isValid, $majorError, $foundUnit, $currentTestDirectory, 
                                      $cslcVerilogCompileStatus, $cslcCppCompileStatus, $cslcCsimCompileStatus, $cslcSystemCCompileStatus, 
                                      $cslcVerilogCompileLog   , $cslcCppCompileLog   , $cslcCsimCompileLog   , $cslcSystemCCompileLog   ,
                                      $cslcVerilogCompileLogName   , $cslcCppCompileLogName   , $cslcCsimCompileLogName   , $cslcSystemCCompileLogName   ,
                                      $cslcLogFileShort);
        
        my $testStatus = ( $Regress::STATUS_PASSED eq $testRow{ overallTestStatus }) ? 1 : 0 ;
        
        $totalDirMajorErrorCnt    += $testRow{majorErrorCnt}; 
        $totalDirValgrindErrorCnt += $testRow{valgrindErrorCnt}; 
        
        #print "majorErrorCnt = $majorErrorCnt testRow{majorErrorCnt} = $testRow{majorErrorCnt} totalDirMajorErrorCnt = $totalDirMajorErrorCnt\n"; 
        
        foreach my $stageName (@Regress::compilerPhaseList) {
            my $s = $stageName . "Status";
            #print "xx testRow{$s} = $testRow{$s}\n";
            if ($Regress::STATUS_PASSED eq $testRow{$s}) { $numStagesPassed{$s}++; }
        }
        
        if ($Regress::STATUS_PASSED eq $testRow{cslcCompileVerilogCode}) { $numStagesPassed{cslcCompileVerilogCode}++; }
        if ($Regress::STATUS_PASSED eq $testRow{gccCompileCppCode     }) { $numStagesPassed{gccCompileCppCode     }++; }
        if ($Regress::STATUS_PASSED eq $testRow{gccCompileCsimCode    }) { $numStagesPassed{gccCompileCsimCode    }++; }       
        if ($Regress::STATUS_PASSED eq $testRow{gccCompileSystemCCode }) { $numStagesPassed{gccCompileSystemCCode }++; }
        
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
            $testListPageTemplate->param(testPageNumber      => $pageNum++     );
            $testListPageTemplate->param(testListResultsLoop => \@testListLoop );
            @testListLoop = ();
            $testListSummaryFilePageNum = "$resultsRootDir/$testListSummaryFileWithOutHtmlExt" . "_$pageCnt.html";
            open(TF, "> $testListSummaryFilePageNum");
            print TF $testListPageTemplate->output;
            close(TF);
            $pageCnt++;
        }
    }
    
    my %testResults = ();
    
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
        %testResults = ();
    }
    
    
    $testResults{totalDirNumTests        } = $totalDirNumTests      ;
    $testResults{totalDirNumTestsPassed  } = $totalDirNumTestsPassed;
    $testResults{totalDirPercentPassed   } = $totalDirPercentPassed ;
    $testResults{directoryStatusCSS      } = (100 == $totalDirPercentPassed) ?  $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;
    $testResults{totalDirMajorErrorCnt   } = $totalDirMajorErrorCnt   ;
    $testResults{totalDirValgrindErrorCnt} = $totalDirValgrindErrorCnt;
    $testResults{numStagesPassed         } = \%numStagesPassed;
    # print "[INFO] executeDirectoryTestlist: end testResults = ", %testResults, "\n";
    # print "[INFO] executeDirectoryTestlist: end \n";
    
    foreach my $stageName (@Regress::compilerPhaseList) {
        my $s = $stageName . "Status";
        #print "tt numStagesPassed{$s} = $numStagesPassed{$s}\n";
    }
    
    
    # write out the resutls fo the directory run so that it can be read by ssh_dist_regress.pl and merged into one summary
    my $dirSummaryFile = "$chapterDir/summary.txt";
    open (DIR_SUMMARY, "> $dirSummaryFile") or die ("[ERROR] check_results: Error opening $dirSummaryFile summary file !\n");
    foreach my $key (keys %testResults) {
        print DIR_SUMMARY "$key = $testResults{$key}\n";
    }
    foreach my $s (keys %numStagesPassed) {
        print DIR_SUMMARY "$s = $numStagesPassed{$s}\n";
    }
    
    close DIR_SUMMARY;
    
    return %testResults;
}

sub getVfFileName {
    my ($outputVerilogCodeDir) = @_;
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
    
    my %Status = ();
    
    # this $relativeFileName causes the following error if placed at the bottom of this function
    # Illegal declaration of subroutine main::finishUp at /home/dpappas/fplsrl_repo/fpl/cslc/trunk/scripts/run_regress.pl line 1828.
    my $relativeFileName = "../../../../../test/$currentHdl/$currentTestDirectory/$testName.csl"; 
    
    # init the status for each phase
    foreach my $phase (@Regress::compilerPhaseList) {
        $Status{$phase            } = $Regress::STATUS_PHASE_DID_NOT_RUN;        
    }
    
    my %foundSection  = ();
    foreach my $k (@Regress::compilerPhaseList) {
        $foundSection{$k } = 0;
    }
    
    if ($externalArguments{"no_execute"} ne "" && ! -e $cslcLogFile) { # Allow files to not exist if the -no_exec option is used
        my %testRow=(testNumber                   => $testCnt,
                     linkToLogFile                => "no_log_file",
                     testName                     => "$testName",
                     linkToTestName               => "no_log_file",
                     minorErrorCnt                => 0   ,
                     majorErrorCnt                => 0   ,
                     valgrindErrorCnt             => 0,
                     compilerPhasePassedPercentage=> 0,
                     overallTestStatus            => $Regress::STATUS_PHASE_DID_NOT_RUN,   
                     cslcCompileVerilogCode       => $Regress::STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileCppCode            => $Regress::STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileCsimCode           => $Regress::STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileSystemCCode        => $Regress::STATUS_PHASE_DID_NOT_RUN,   
                     cslcCompileVerilogLog        => "no_log_file",   
                     gccCompileCppLog             => "no_log_file",   
                     gccCompileCsimLog            => "no_log_file",   
                     gccCompileSystemCLog         => "no_log_file",   
                     
                     minorErrorCntCSSClass                 => $Regress::STATUS_PHASE_DID_NOT_RUN,    
                     majorErrorCntCSSClass                 => $Regress::STATUS_PHASE_DID_NOT_RUN,    
                     valgrindErrorCntCSSClass              => $Regress::STATUS_PHASE_DID_NOT_RUN,    
                     overallTestStatusCSSClass             => $Regress::STATUS_PHASE_DID_NOT_RUN,
                     compilerPhasePassedPercentageCSSClass => $Regress::STATUS_PHASE_DID_NOT_RUN,    
                     cslcCompileGenVerilogStatusCSSClass   => $Regress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenCppStatusCSSClass        => $Regress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenCsimStatusCSSClass       => $Regress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenSystemCStatusCSSClass    => $Regress::STATUS_PHASE_DID_NOT_RUN,
                     
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
    my $stageName             = $Regress::compilerPhaseList[$stageNum];
    my %StatusCssClass        = ();
    my $valgrind_error        = 0;
    
    for ( my $i = 0; $i <= $#lines; $i++ ) {
        my $line = $lines[$i];
        
        if ($externalArguments{enableValgrind}) {
            if ($line =~ m/LEAK SUMMARY/ ) { 
                $valgrind_error++;
                $valgrindErrorCnt = 1; 
                $Status{"$stageName"} = $Regress::STATUS_FAILED;
                
                # print "found valgrind error\n";
                # add a record to the error list which will be emailed to owners
                my %errorRpt = ( "directory"  => $currentTestDirectory,
                                 "testname"   => $testName,
                                 "minorError" => ""       ,
                                 "majorError" => ""       ,
                                 "valgrindError" => $line ,
                                 );
                # print "errorRpt = ", %errorRpt, "\n";
                
                push (@{$Regress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                #                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", Regress::errorListByCompilerPhase{$stageName}, "\n"; 
                goto DONE; 
            }
            
        }
        
        if (0 == $foundUnit && &isCslHdlArg($currentHdl) && $stageName eq "$Regress::STAGE_CSIM_CODE_GEN") { # skip CPP code gen stage
            #print "skip CPP code gen stage\n";
            $stageNum++;
            $stageName = $Regress::compilerPhaseList[$stageNum];
            $i--; # stay on the same line until the right stage name is reached
        }
        elsif (($currentHdl eq "verilog" ) && &isCslStage($stageName)) { # this is a Verilog test and we do not run CSl compilation steps on verilog tests
            # print "finderrors isCSLStage stageName = $stageName\n";
            $stageNum++;
            $stageName = $Regress::compilerPhaseList[$stageNum];
            # print "finderrors  stageName = $stageName\n";
            $i--; # stay on the same line until the right stage name is reached
        }
        else {
            my $pattern = "$stageName" . "_begin";
            if ($line =~ m/$pattern/i ) { 
                # print "found phase= $stageName \n";
                # print "found begin pattern\n";
                # print "a line = $line\n";
                $Status{"$stageName"} = $Regress::STATUS_FAILED; # inside of begin-set to failed unless end is reached and no errors are found
                for ( my $k = $i+1; $k <= $#lines; $k++ ) {
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
                            $Status{"$stageName"} = $Regress::STATUS_PASSED;
                        }
                        elsif ($warnCnt > 0) {
                            $Status{"$stageName"} = $Regress::STATUS_PASSED_WARNING;
                        }
                        
                        $StatusCssClass{"$stageName"} = &getStatusCssClass("$stageName", $Status{"$stageName"});         
                        $stageNum++;
                        $stageName = $Regress::compilerPhaseList[$stageNum];
                        # print "stageName = $stageName foundUnit = $foundUnit\n";
                        
                        # print "go to next\n";
                        
                        goto NEXT;
                    }
                    else {
                        
                        $errorType = &findErrors($line);
                        if    ($Regress::MINOR_ERROR == $errorType) { # found error - section failed
                            $minorErrorCnt = 1;                         
                            $Status{"$stageName"} = $Regress::STATUS_FAILED;
                            # print "found minor error\n";
                            
                            if ($isValid) { # add a record to the error list which will be emailed to owners
                                my %errorRpt = ( "directory"  => $currentTestDirectory,
                                                 "testname"   => $testName,
                                                 "minorError" => $line    ,
                                                 "majorError" => ""       ,
                                                 "valgrindError" => ""    ,
                                                 );
                                #print "errorRpt = ", %errorRpt, "\n";
                                push (@{$Regress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                                # print "Minor error stageName = $stageName testName = $testName Added error rpt = /%errorRpt/ to errorListByCompilerPhase{$stageName} = ", $Regress::errorListByCompilerPhase{$stageName}, "\n"; 
                            }
                            goto DONE; 
                        }
                        elsif ($Regress::MAJOR_ERROR == $errorType) { # found error - section failed
                            $majorErrorCnt = 1; 
                            $Status{"$stageName"} = $Regress::STATUS_FAILED;
                            
                            # print "found major error\n";
                            # add a record to the error list which will be emailed to owners
                            my %errorRpt = ( "directory"  => $currentTestDirectory,
                                             "testname"   => $testName,
                                             "minorError" => ""     ,
                                             "majorError" => $line  ,
                                             "valgrindError" => ""       ,
                                             );
                            # print "errorRpt = ", %errorRpt, "\n";
                            
                            push (@{$Regress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                            #                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $Regress::errorListByCompilerPhase{$stageName}, "\n"; 
                            goto DONE; 
                        }
                        elsif ($Regress::VALGRIND_ERROR == $errorType) { # found error - section failed
                            $valgrindErrorCnt = 1; 
                            $Status{"$stageName"} = $Regress::STATUS_FAILED;
                            
                            # print "found valgrind error\n";
                            # add a record to the error list which will be emailed to owners
                            my %errorRpt = ( "directory"  => $currentTestDirectory,
                                             "testname"   => $testName,
                                             "minorError" => ""       ,
                                             "majorError" => ""       ,
                                             "valgrindError" => $line ,
                                             );
                            # print "errorRpt = ", %errorRpt, "\n";
                            
                            push (@{$Regress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                            #                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $Regress::errorListByCompilerPhase{$stageName}, "\n"; 
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
    
    $Status{$Regress::STAGE_VALGRIND        } = $Regress::STATUS_PHASE_DID_NOT_RUN;
    $StatusCssClass{$Regress::STAGE_VALGRIND} = $Regress::CSS_STATUS_PHASE_DID_NOT_RUN; 
    
    if ($externalArguments{enableValgrind}) { 
        my $valgrind_passed = ($valgrind_error == 0);
        my $valgrind_status = $valgrind_error;
        $StatusCssClass{$Regress::STAGE_VALGRIND} = $valgrind_passed ? $Regress::CSS_STATUS_PASSED : $Regress::CSS_STATUS_FAILED; 
    }
    
    $Status{$Regress::STAGE_OVERALL_STATUS} = $Regress::STATUS_FAILED;
    
    my $k;
    my $allSectionsPassed = 1;
    
    foreach my $stageName (@Regress::compilerPhaseList) {
        if (0 == $foundUnit && $stageName eq $Regress::STAGE_CSIM_CODE_GEN) { # skip CSIM code gen stage
            next;
        }
        elsif (($currentHdl eq "verilog" ) && &isCslStage($stageName)) { # this is a Verilog test and we do not run CSl compilation steps on verilog tests
            next;
        }
        elsif (!($Regress::STATUS_PASSED eq $Status{"$stageName"})) {
            $allSectionsPassed = 0;
            last;
        }
    }
    
    my $postCompilePassed =  ($Regress::STATUS_PASSED == $cslcVerilogCompileStatus) && ($Regress::STATUS_PASSED ==  $cslcSystemCCompileStatus) && ($Regress::STATUS_PASSED == $cslcCppCompileStatus) && ($Regress::STATUS_PASSED == $cslcCsimCompileStatus);
    
    #FIX ADD LATER $allSectionsPassed = $allSectionsPassed && $postCompilePassed;
    
    if ($majorError > 0) { # when we have a major error it doesn't matter if it is a valid test or a invalid test the file overall stage must be FAILED
        $Status{$Regress::STAGE_OVERALL_STATUS} = $Regress::STATUS_FAILED;
    }
    else {
        if(1 == $allSectionsPassed) { # if all stages did not run then look for a major error such as abort or segfault
            if (0 == $minorErrorCnt && 0 == $majorErrorCnt && 0 == $valgrindErrorCnt ) { 
                $Status{$Regress::STAGE_OVERALL_STATUS} = $isValid ? $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;
            }
            elsif (0 != $valgrindErrorCnt ) { 
                $Status{$Regress::STAGE_OVERALL_STATUS} = $isValid ? $Regress::STATUS_FAILED : $Regress::STATUS_PASSED;
            }
            elsif ($warnCnt > 0) { 
                $Status{$Regress::STAGE_OVERALL_STATUS} = $isValid ? $Regress::STATUS_PASSED_WARNING : $Regress::STATUS_FAILED;
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
                $Status{$Regress::STAGE_OVERALL_STATUS} = $isValid ? $Regress::STATUS_FAILED : $Regress::STATUS_PASSED;
            }
            elsif ($minorErrorCnt > 0) { 
                $Status{$Regress::STAGE_OVERALL_STATUS} = $isValid ? $Regress::STATUS_FAILED : $Regress::STATUS_PASSED;
            }
            else {             
                $Status{$Regress::STAGE_OVERALL_STATUS} = $isValid ? $Regress::STATUS_FAILED : $Regress::STATUS_PASSED;
            }
        }
    }
    
    my $passedStages = 0;
    foreach my $name (@Regress::compilerPhaseList) {
        my $status = $Status{$name};
        if ($status eq $Regress::STATUS_PASSED){
            $passedStages++;
        }
    }
    
    my $stageCnt = 0;
    if ( $currentHdl eq "verilog" ) {
        foreach my $stageName (@Regress::compilerPhaseList) {
            if ( !&isCslStage($stageName)) {$stageCnt++;}
        }
    }
    else {
        $stageCnt = $#Regress::compilerPhaseList +1; # FIX this is an approximation-if the --csim_gen flag if off then one stage should be subtracted. Not sure if this is worth doing
        #print "else branch: stageCnt = $stageCnt\n";
    }
    
    my $compilerPhasePassedPercentage = ($passedStages/($stageCnt)) * 100;
    my $percentage                    = sprintf( "%3d%", $compilerPhasePassedPercentage);
    $Status{$Regress::STAGE_CPHASE_PASS_PERCENT} = $percentage; # make it a percentage
    
    foreach my $phase (@Regress::compilerPhaseList) {
        $StatusCssClass{$phase} = &getStatusCssClass($phase, $Status{$phase});         
#        print "StatusCssClass{$phase} = ", $StatusCssClass{"$phase"},"\n";

    }
    
    if(0 == $foundUnit){ 
        my $phase = $Regress::STAGE_CSIM_CODE_GEN; 
        $Status{$phase} = $Regress::STATUS_PHASE_DID_NOT_RUN;
        $StatusCssClass{$phase} = &getStatusCssClass($phase, $Status{$phase});  
    }
    
    $StatusCssClass{$Regress::STAGE_MINOR_ERROR      } = &getStatusCssClass($Regress::STAGE_MINOR_ERROR      , $minorErrorCnt   );    
    $StatusCssClass{$Regress::STAGE_MAJOR_ERROR      } = &getStatusCssClass($Regress::STAGE_MAJOR_ERROR      , $majorErrorCnt   );    
    $StatusCssClass{$Regress::STAGE_VALGRIND_ERROR   } = &getStatusCssClass($Regress::STAGE_VALGRIND_ERROR   , $valgrindErrorCnt);    
    $StatusCssClass{$Regress::STAGE_OVERALL_STATUS   } = &getStatusCssClass($Regress::STAGE_OVERALL_STATUS   , $Status{$Regress::STAGE_OVERALL_STATUS   });  
    
    $StatusCssClass{$Regress::STAGE_CPHASE_PASS_PERCENT} = (100 == $compilerPhasePassedPercentage) ? $Regress::STATUS_PASSED : $Regress::STATUS_FAILED;
    
    if ($externalArguments{no_post_compile}) {
        $StatusCssClass{$Regress::CSLC_COMPILE_GENERATED_VERILOG     } = $Regress::CSS_STATUS_PHASE_DID_NOT_RUN;         
        $StatusCssClass{$Regress::GCC_COMPILE_GENERATED_SYSTEMC_CODE } = $Regress::CSS_STATUS_PHASE_DID_NOT_RUN; 
        $StatusCssClass{$Regress::GCC_COMPILE_GENERATED_CPP_CODE     } = $Regress::CSS_STATUS_PHASE_DID_NOT_RUN; 
        $StatusCssClass{$Regress::GCC_COMPILE_GENERATED_CSIM_CODE} = $Regress::CSS_STATUS_PHASE_DID_NOT_RUN; 
    }      
    else {
        $StatusCssClass{$Regress::CSLC_COMPILE_GENERATED_VERILOG     } = ($cslcVerilogCompileStatus eq $Regress::STATUS_PASSED) ? $Regress::CSS_STATUS_PASSED :( ($cslcVerilogCompileStatus eq $Regress::STATUS_FAILED) ? $Regress::CSS_STATUS_FAILED : $Regress::CSS_STATUS_PHASE_DID_NOT_RUN); 
        $StatusCssClass{$Regress::GCC_COMPILE_GENERATED_CPP_CODE     } = ($cslcCppCompileStatus     eq $Regress::STATUS_PASSED) ? $Regress::CSS_STATUS_PASSED :( ($cslcCppCompileStatus     eq $Regress::STATUS_FAILED) ? $Regress::CSS_STATUS_FAILED : $Regress::CSS_STATUS_PHASE_DID_NOT_RUN); 
        $StatusCssClass{$Regress::GCC_COMPILE_GENERATED_CSIM_CODE} = ($cslcCsimCompileStatus    eq $Regress::STATUS_PASSED) ? $Regress::CSS_STATUS_PASSED :( ($cslcCsimCompileStatus    eq $Regress::STATUS_FAILED) ? $Regress::CSS_STATUS_FAILED : $Regress::CSS_STATUS_PHASE_DID_NOT_RUN);
        $StatusCssClass{$Regress::GCC_COMPILE_GENERATED_SYSTEMC_CODE } = ($cslcSystemCCompileStatus eq $Regress::STATUS_PASSED) ? $Regress::CSS_STATUS_PASSED :( ($cslcSystemCCompileStatus eq $Regress::STATUS_FAILED) ? $Regress::CSS_STATUS_FAILED : $Regress::CSS_STATUS_PHASE_DID_NOT_RUN);
    }
    
    
    # create the row to add to the TMP_LOOP
    my %testRow=(testNumber                   => $testCnt,
                 linkToLogFile                => $cslcLogFileShort,
                 testName                     => $testName        ,
                 linkToTestName               => $relativeFileName,
                 minorErrorCnt                => $minorErrorCnt   ,
                 majorErrorCnt                => $majorErrorCnt   ,
                 valgrindErrorCnt             => $valgrindErrorCnt,
                 compilerPhasePassedPercentage=> $Status{$Regress::STAGE_CPHASE_PASS_PERCENT  },
                 overallTestStatus            => $Status{$Regress::STAGE_OVERALL_STATUS       },   
                 cslcCompileVerilogCode       => $cslcVerilogCompileStatus,   
                 gccCompileCppCode            => $cslcCppCompileStatus    ,   
                 gccCompileCsimCode           => $cslcCsimCompileStatus   ,   
                 gccCompileSystemCCode        => $cslcSystemCCompileStatus,   
                 cslcCompileVerilogLog        => "gen_code/$testName/generated_code/generated_verilog/$cslcVerilogCompileLogName",   
                 gccCompileCppLog             => "gen_code/$testName/generated_code/generated_cpp/$cslcCppCompileLogName"        ,   
                 gccCompileCsimLog            => "gen_code/$testName/generated_code/generated_csim/$cslcCsimCompileLogName"      ,   
                 gccCompileSystemCLog         => "gen_code/$testName/generated_code/generated_systemc/$cslcSystemCCompileLogName",   
                 
                 minorErrorCntCSSClass                 => $StatusCssClass{ $Regress::STAGE_MINOR_ERROR                   },    
                 majorErrorCntCSSClass                 => $StatusCssClass{ $Regress::STAGE_MAJOR_ERROR                   },    
                 valgrindErrorCntCSSClass              => $StatusCssClass{ $Regress::STAGE_VALGRIND_ERROR                },    
                 overallTestStatusCSSClass             => $StatusCssClass{ $Regress::STAGE_OVERALL_STATUS                },
                 compilerPhasePassedPercentageCSSClass => $StatusCssClass{ $Regress::STAGE_CPHASE_PASS_PERCENT           },    
                 cslcCompileGenVerilogStatusCSSClass   => $StatusCssClass{ $Regress::CSLC_COMPILE_GENERATED_VERILOG      },
                 gccCompileGenCppStatusCSSClass        => $StatusCssClass{ $Regress::GCC_COMPILE_GENERATED_CPP_CODE      },
                 gccCompileGenCsimStatusCSSClass       => $StatusCssClass{ $Regress::GCC_COMPILE_GENERATED_CSIM_CODE     },
                 gccCompileGenSystemCStatusCSSClass    => $StatusCssClass{ $Regress::GCC_COMPILE_GENERATED_SYSTEMC_CODE  },
                 
                 );
    
    foreach my $stageName (@Regress::compilerPhaseList) {
        my $s = $stageName . "Status";
        $testRow{$s} = $Status{$stageName}
    }
    
    foreach my $stageName (@Regress::compilerPhaseList) {
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
    my $cslStage = 0;  
    if    ($stageName eq $Regress::STAGE_INST_TREE    ) { $cslStage = 1; }  
    elsif ($stageName eq $Regress::STAGE_AUTO_ROUTER  ) { $cslStage = 1; }  
    elsif ($stageName eq $Regress::STAGE_AUTO_MAPPER  ) { $cslStage = 1; }  
    elsif ($stageName eq $Regress::STAGE_CSLOM_CHECKER) { $cslStage = 1; }  
    elsif ($stageName eq $Regress::STAGE_CPP_CODE_GEN ) { $cslStage = 1; }  
    elsif ($stageName eq $Regress::STAGE_CSIM_CODE_GEN) { $cslStage = 1; }  
    elsif ($stageName eq $Regress::STAGE_ADAPTER      ) { $cslStage = 1; }        
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
    if( $line =~ m/(abort)/i               ) { $errorType = $Regress::MAJOR_ERROR; }
    elsif( $line =~ m/(assert)/i           ) { $errorType = $Regress::MAJOR_ERROR; }
    if    ( $line =~ m/(antlr exception)/i  ) { $errorType = $Regress::MAJOR_ERROR; }
    elsif ( $line =~ m/(exception)/i        ) { $errorType = $Regress::MAJOR_ERROR; }
    elsif ( $line =~ m/(noviablealt)/i      ) { $errorType = $Regress::MAJOR_ERROR; }
    elsif ( $line =~ m/(segmentation)/i     ) { $errorType = $Regress::MAJOR_ERROR; }
    elsif ( $line =~ m/(error)/i            ) { $errorType = $Regress::MINOR_ERROR; }
    elsif ( $line =~ m/(type check on cast failure)/i ) { $errorType = $Regress::MAJOR_ERROR; }
    elsif ($line =~ m/LEAK SUMMARY/                  ) { $errorType = $Regress::VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid free/                  ) { $errorType = $Regress::VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid write/                 ) { $errorType = $Regress::VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid read/                  ) { $errorType = $Regress::VALGRIND_ERROR; }
    elsif ($line =~ m/Mismatched free/               ) { $errorType = $Regress::VALGRIND_ERROR; }
    elsif ($line =~ m/Conditional jump or move depends on uninitialised value/) { $errorType = $Regress::VALGRIND_ERROR; }
    
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
    
    if ($status eq $Regress::STATUS_FAILED) { $cssStatus = $Regress::STATUS_FAILED; }
    elsif ($status eq $Regress::STATUS_PASSED) { 
        $cssStatus = $Regress::STATUS_PASSED;
    }
    elsif (($compilerPhase eq $Regress::STAGE_MINOR_ERROR) || ($compilerPhase eq $Regress::STAGE_MAJOR_ERROR) || ($compilerPhase eq $Regress::STAGE_VALGRIND_ERROR)) {
        if ($status != 0) { $cssStatus = $Regress::STATUS_FAILED; }
        else              { $cssStatus = $Regress::STATUS_PASSED; }
    }
    elsif ($status eq $Regress::STATUS_PHASE_DID_NOT_RUN ) { $cssStatus = $Regress::CSS_STATUS_PHASE_DID_NOT_RUN; }
    elsif ($status eq $Regress::STATUS_VALGRIND_ERROR    ) { $cssStatus = $Regress::CSS_STATUS_VALGRIND_ERROR;    }
    else  { die "[ERROR] contact developer: default else statement compilerPhase = $compilerPhase status = $status"; }
    
    return $cssStatus;
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
            ex: WORK=HOME/svn or WORK=HOME/fpl/cslc (no final slash) \n";
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
    my($test_start_time) = @_;
    
    # print "[WARNING] Caught $signalName . Finishing up...\n";
    # print "\nCaught $signalName ! Regression halted!\n";
    
    my @array = ();
    my $index   = rand @array;
    my $element = $array[$index];
    die "$element\n";
}

#################################################################################################
#                                          initSignal                                           #
#subroutine for catching signals                                                                #
#################################################################################################

sub initSignal {
    my ($resultsRootDir, $test_start_time) = @_;
    
    defined $Config{sig_name} || print "[WARNING] No signals detected. Type kill -l for the list of signals. 
 If there are signals, please report this to ", maintainer ,"\n";
    $SIG{INT}  = sub { $signalName = "SIGINT";  &finishUp($test_start_time);  };
    $SIG{TERM} = sub { $signalName = "SIGTERM"; &finishUp($test_start_time);  };
    $SIG{HUP}  = sub { $signalName = "SIGHUP";  &finishUp($test_start_time);  };
}

sub postProcess {
    my ($resultsRootDir, $currentHdl, $status) = @_;
    my @e = keys %Regress::errorListByCompilerPhase;
    
    my $errorFile =  "$resultsRootDir/compiler_phase_error_report.txt";
    
    # print "Writing file $errorFile\n";
    open(ERROR_FH, "> $errorFile");
    
    print ERROR_FH "phaseCnt = $#e\n";
    print ERROR_FH "errorListByCompilerPhase = ", %Regress::errorListByCompilerPhase, "\n";
    print ERROR_FH "compilerPhaseList cnt = $#Regress::compilerPhaseList compilerPhaseList = ", @Regress::compilerPhaseList ,"\n";
    
#    foreach my $phase (@Regress::compilerPhaseList){
#        my $phaseList = $Regress::errorListByCompilerPhase{$phase};
#        my @a = @{$phaseList};
#        print ERROR_FH "\n\nErrorList: test errors phase: $phase error cnt = $#a\n";
#        if (@a ) {
#            foreach my $er (@a){
#                my %errorRecord = %{$er};
#                if (%errorRecord) {
#                    if ("" eq $errorRecord{"minorError"}){
#                        print ERROR_FH "    major error phase: $phase directory: ", $errorRecord{"directory"} ," testname: ", $errorRecord{"testname"}, "\.$currentHdl   major_error: ", $errorRecord{"majorError"}, "\n";
#                    }
#                }
#            }
#            foreach my $er (@a){
#                my %errorRecord = %{$er};
#                if (%errorRecord) {
#                    if ("" eq $errorRecord{"majorError"}){
#                        print ERROR_FH "    minor error phase: $phase directory: ", $errorRecord{"directory"} ," testname: ", $errorRecord{"testname"}, "\.$currentHdl   minor_error: ", $errorRecord{"minorError"}, "\n";
#                        print ERROR_FH "\n";
#                    }
#                }
#            }
#        }
#    }
    
    close(ERROR_FH);
    
    if ( $externalArguments{mail} ){ # send the report to 
        print "sending email to team = ", %Regress::ownerListByCompilerPhase,"\n"; 
        &mail('dpappas@fplsrl.com', $errorFile);
        &mail('camarand@fplsrl.com', $errorFile);
        
        foreach my $owner (values %Regress::ownerListByCompilerPhase) {
            print "sending email to $owner\n";
            &mail($owner, $errorFile);
        }
    }             
    
    if($firefox ne "" ) {
        my $file = "$resultsRootDir/$currentHdl" . "_regression_summary.html";
        print "url = $file\n";

        `firefox -remote "openurl($file)"`; 
    }

    #    &news();
    # print a random message for entertainment value
    my @array = ();
    my $index   = rand @array;
    my $element = $array[$index];
    print "\n\n$element\n\n\n";
    
    print "Exit msg: $exitMsg\n";
    print "Overall regression status = $status\n";
    if ($Regress::STATUS_PASSED eq $status){ exit 0; }
    else                                   { exit 1; }
}

sub news {
    
    print ("NEWS BULLETIN 2\n");
    print ("See help.\n");
    print ("Send dpappas\@fplsrl.com any enhancement suggestions for the run_regress.pl and graph_regress.pl scripts\n");
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
    my $subject      = "compiler stage error report: ", $Regress::test_start_time;
    my $message_body = "Here's the attachment file(s) you wanted";
    my $attachment   = "";
    my $mail_host    = "mail.fplsrl.com";
    # print "to_address = $to_address\n";
    ### Create the multipart container
    my $msg = MIME::Lite->new (
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
