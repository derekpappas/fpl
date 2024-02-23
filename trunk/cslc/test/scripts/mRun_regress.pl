#!/usr/bin/perl 
#this version is for modif_cslc only

#Maintainers(s): Oana B and Derek

use lib "$ENV{WORK}/test/scripts";
use mRegress; #use this for the new regression
use FplLib;
use strict;
use Config; #checking if the system has signals enabled
use POSIX qw(ceil floor);

use constant maintainer  => "OanaB and Derek"; #put your name here if you are the current maintainer of this script
use constant myVersion   => "0.4";
#use constant wgs         => 0; # Total no of warnings

#require "$ENV{WORK}/trunk/scripts/regress_include.pl";

my %externalArguments = (); # command line args

#TODO: modify the next line so that is platform independent (can be run on x86_32 too etc.)
chomp( my $arch = `uname -m`); #getting information about the current system
if ($arch =~ m/i686/) {
    $arch = "x86";      #changed by Monica
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

my $guiDir = $mRegress::totDir . "/trunk/src/FastPath";
my $guiExec = "$guiDir/FastPath";              # gui executable
if(-e $guiExec) {
    &FplLib::testFileExists($guiExec); 
}


my $signalName = "";

my $help                 = "";
my $version              = "";
my $verbose              = "";
my $hdlExtParam          = "";
my $guiExtParam          = "";
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
my $postCompileCsim      = "";
#my $noPostCompileSystemC = "";
my $postCompileSystemC   = "";
my $noPostCompileVerilog = "";
my $noPostCompileVHDL    = "";
my $runSysCVerilogSim    = "";
my $include_empty_dirs   = "";
my $no_html              = "";

my  @lexer_stage              = {};
my  @parser_stage             = {};
my  @walker_stage             = {};
my  @inst_tree_stage          = {};
my  @auto_router_stage        = {};
my  @auto_mapper_stage        = {};
my  @cslom_checker_stage      = {};
my  @cslom_conn_checker_stage = {};
my  @cpp_code_gen_stage       = {};
my  @csim_code_gen_stage      = {};
my  @adapter_stage            = {};
my  @cdom_checker_stage       = {};
my  @verilog_code_gen_stage   = {};
my  @system_c_code_gen_stage  = {};
my  @vhdl_code_gen_stage      = {};
my  @valgrind_stage           = {};

my  %errorListByCompilerPhase = (
 STAGE_LEXER              => \@lexer_stage              ,
 STAGE_PARSER             => \@parser_stage             ,
 STAGE_WALKER             => \@walker_stage             ,
 STAGE_INST_TREE          => \@inst_tree_stage          ,
 STAGE_AUTO_ROUTER        => \@auto_router_stage        ,
 STAGE_AUTO_MAPPER        => \@auto_mapper_stage        ,
 STAGE_CSLOM_CHECKER      => \@cslom_checker_stage      ,
 STAGE_CSLOM_CONN_CHECKER => \@cslom_conn_checker_stage ,                                 
 STAGE_CPP_CODE_GEN       => \@cpp_code_gen_stage       ,
 STAGE_CSIM_CODE_GEN      => \@csim_code_gen_stage      ,
 STAGE_ADAPTER            => \@adapter_stage            ,
 STAGE_CDOM_CHECKER       => \@cdom_checker_stage       ,
 STAGE_VERILOG_CODE_GEN   => \@verilog_code_gen_stage   ,
 STAGE_VHDL_CODE_GEN      => \@vhdl_code_gen_stage      ,
 STAGE_SYSTEM_C_CODE_GEN  => \@system_c_code_gen_stage  ,			    
 STAGE_VALGRIND           => \@valgrind_stage           ,    
);


&main();

################################################################################

sub main {

    print "STAGE_CSIM_CODE_GEN = ", $mRegress::STAGE_CSIM_CODE_GEN ,"\n";


    print "maintainer = ", maintainer,"\n";
    
    &FplLib::display_message( "[INFO] Your system architecture is: $arch\n");
    #    if($arch ne 'i686' and $arch ne 'x86_64') {
    #        die "[ERROR] initGeneral: Your architecture $arch is not supported by this script. Only  Linux x86_64 and x86_32 are supported.\n";
    #    }
    
    %externalArguments = &processExternalArgs();           #testing if the arguments are correct and if so then they are processed
    
    my $cslTestRootDir     = $mRegress::testRootDir . "/$externalArguments{hdlExtParam}";
    
    
    &FplLib::testDirExists($cslTestRootDir    );
    &FplLib::testDirExists($mRegress::verilogTestRootDir);
    &FplLib::testDirExists($mRegress::reportRootDir     );
    
    ################################################################################
    # set the current regression directories
    # create a new results directory for each new regression
    ################################################################################
    my $resultsRootDir = "";
    
    if ($externalArguments{results_dir} eq "" ) {
        chomp (my $results_date = `date "+%G.%m.%d_%T"`);
        $results_date =~ s/(:)/_/g;
        $resultsRootDir = $mRegress::reportRootDir . "/results_". $results_date;     #the results directory
        print "[INFO] Created resultsDir = $resultsRootDir \n";
        print "export REGRESS_DIR=$resultsRootDir \n";
        `echo $resultsRootDir > $mRegress::reportRootDir/last_run`;
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
    
    &initSignal($resultsRootDir, $mRegress::test_start_time); 
    
    &testAllDependencies();
    
    if( $externalArguments{"hdlExtParam"} eq "all" ) {
        die "[EXIT] -hdl all is deprecated only -hdl csl or -hdl csl_v2 or -hdl verilog are allowed\n";
    }
    
    my $currentHdl = $externalArguments{"hdlExtParam"};
    print("[INFO] current HDL language: $currentHdl\n");
    
    my $status = "Did not run any tests";
    
    if($externalArguments{"hdlExtParam"}) {
        my $testDirFilter = $externalArguments{"dir_filter"};
        if($externalArguments{"no_html_report"}) {
            $status = &mRegress::regressHdl($resultsRootDir, $currentHdl, $testDirFilter, \%externalArguments, 1);
        }
        else {
            $status = &mRegress::regressHdl($resultsRootDir, $currentHdl, $testDirFilter, \%externalArguments, 0);
        }           
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
                              'gui'                     => \$guiExtParam         ,
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
			      'compile_csim'            => \$postCompileCsim     ,
                              #'no_post_compile_systemc' => \$noPostCompileSystemC,
			      'compile_systemc'         => \$postCompileSystemC,	
                              'no_post_compile_verilog' => \$noPostCompileVerilog,
                              'no_post_compile_vhdl'    => \$noPostCompileVHDL   ,
			      'run_sysc_verilog_sim'    => \$runSysCVerilogSim,
                              'include_empty_dirs'      => \$include_empty_dirs,
                              'no_html_report'          => \$no_html
                              );
    
    print "hdlExtParam = $hdlExtParam\n";
    print "guiExtParam = $guiExtParam\n";
    
    %externalArguments = ( 
                           "h"                       => $help             ,
                           "help"                    => $help             ,
                           "version"                 => $version          ,
                           "v"                       => $verbose          ,
                           "hdlExtParam"             => $hdlExtParam      , 
                           "guiExtParam"             => $guiExtParam      , 
                           "exitMsg"                 => $exitMsg          , 
                           "enableValgrind"          => $enableValgrind   , 
                           "no_execute"              => $no_execute       , 
                           "results_dir"             => $results_dir      , 
                           "firefox"                 => $firefox          , 
                           "mail"                    => $mail             ,
                           "dir_filter"              => $testDirFilter    , 
                           "errors_only"             => $errorsOnly       ,
                           "major_errors_only"       => $majorErrorsOnly  ,
                           "no_post_compile"         => $noPostCompile    ,
                           "no_post_compile_cpp"     => $noPostCompileCpp ,
			   "compile_csim"            => $postCompileCsim  ,
                           #"no_post_compile_systemc" => $noPostCompileSystemC,
			   "compile_systemc"         => $postCompileSystemC,
                           "no_post_compile_verilog" => $noPostCompileVerilog,
                           "no_post_compile_vhdl"    => $noPostCompileVHDL,
			   "run_sysc_verilog_sim"    => $runSysCVerilogSim,
                           "include_empty_dirs"      => $include_empty_dirs,
                           "no_html_report"          => $no_html
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
    
    if(! (&isCslHdlArg($hdlExtParam) || $hdlExtParam eq "verilog" || $hdlExtParam eq "gui") ) {
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
    
    my $bool = 
        $currentHdl    eq "csl" 
        || $currentHdl eq "csl_v2"  
        || $currentHdl eq "csl_new_bug" 
        || $currentHdl eq "csl_test_gen" 
        || $currentHdl eq "csl_design_gen"  
        || $currentHdl eq "csl_cc_gen" 
#        || $currentHdl eq "gui" # gui runs csl tests 
        || $currentHdl eq "csl_ar_gen";
    
    return $bool;
}

#################################################################################################
#                                          testAllDependencies                                  #
##subroutine for testing if dependencies are met                                                #
#################################################################################################

sub testAllDependencies {
    # print "[INFO] testAllDependencies: begin \n";
    
    &testDependencies($cslcExec);
    if($externalArguments{enableValgrind}) {
        &testDependencies("/usr/bin/valgrind");
    }
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
        print "REGRESSION STOPPED binary $binary not found !\n";
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
    
    print "[INFO] regressDir: begin\n";
    my %testResults = ();
    #    if ( ! $externalArguments{"no_execute"}) {
    my @testlist = &generate_regression_list( $currentTestDirectory, $currentHdl ); # Generating regression lists for $currentTestDirectory
    @testlist = sort(@testlist);
    print ("[INFO] regressDir: sourceDir = $currentTestDirectory testlist cnt = $#testlist\n"); 
    print ("[INFO] regressDir: Executing regression for $currentTestDirectory testlist cnt = $#testlist\n"); 
    
    print ("[INFO] regressDir: Executing testlist = " , @testlist, "\n");
    %testResults = &executeDirectoryTestlist($resultsRootDir, $currentHdl, $currentTestDirectory, \@testlist, $testListSummaryFileWithOutHtmlExt, $resultsTestDirectory, $currentHdlDirectory );  
    #    }
    
    if($testResults{totalDirNumTests} == 0) {
        print "[INFO] REGRESSION FAILED ! -  $currentTestDirectory directory is empty called in currentTestDirectory = $currentTestDirectory hdlExtParam = $hdlExtParam\n";
    }
    
    print "[INFO] regressDir: end testResults = ", %testResults, "\n";
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
    my $fHdlFileExtension;
    if   ($currentHdl eq "verilog"  ) { $hdlFileExtension = "v"      ; }
    elsif($currentHdl eq "gui"      ) { $hdlFileExtension = "csl.xml"; } 
    elsif(&isCslHdlArg($currentHdl) ) { $hdlFileExtension = "csl"    ; } 
    else { die("[ERROR] generate_regression_list: couldn't determine the selected hdl currentHdl = $currentHdl"); }

    if   ($currentHdl eq "verilog"  ) { $fHdlFileExtension = "vf";  }
    elsif($currentHdl eq "gui"      ) { $fHdlFileExtension = "NO cf or vf file extension!!!!";} 
    elsif(&isCslHdlArg($currentHdl) ) { $fHdlFileExtension = "cf";} 
    else { die("[ERROR] generate_regression_list: couldn't determine the selected hdl currentHdl = $currentHdl"); }
    
    my $cwd = `pwd`;
    
    #    my $testDirPath = $mRegress::testRootDir . "/$currentHdl/$currentTestDirectory/*.$hdlFileExtension";
    my $testDirPath = $mRegress::testRootDir . "/$currentHdl/$currentTestDirectory";
    
    print "[INFO] generate_regression_list: testDirPath = $testDirPath\n";
    
    my $ls_cmd = "cd $testDirPath && find . -name \"*.$hdlFileExtension\" -print && cd $cwd" or print "Can't find directory:".$testDirPath."\n"; #select only the regular files from the current tests dir
    
#    my $ls_cmd_f = "cd $testDirPath && find . -name \"*.$fHdlFileExtension\" -print && cd $cwd"; #select only the regular files from the current tests dir

    print "[INFO] ls_cmd = $ls_cmd\n";

    my @cslFiles;
    my @testlistWithPath = ();
    my @cfFiles;
    
    
    if(-e $testDirPath) {
	chdir($testDirPath); # or die "Can't find directory:".$testDirPath."\n";
    }
    my $ls = `ls $testDirPath`; # or die "Can't find directory::".$testDirPath."\n";
    
    my @Files = split(/\n/, $ls);
    chomp(@Files); # get rid of '\n'
    foreach my $file(@Files) {
        if($file =~ /\.cf$/) {
            push(@cfFiles,$file);
        }
    }
    if ($#cfFiles != -1) {
        my @cslInCfFiles;
        foreach my $cfFile(@cfFiles) {
            my $gr = `grep .csl $cfFile`;
            my @cslInCfFile = split(/\n/,$gr);
            chomp(@cslInCfFiles);
            push(@cslInCfFiles,@cslInCfFile);
        }
        foreach my $file(@Files) {
            if($file =~ /\.csl$/) {
                push(@cslFiles,$file);
            }             
        }   
        #print "\n+++++@cslFiles\n";         
        if(@cslFiles =~ @cslInCfFiles)      {
            print "All csl files are in the cf file\n";
        }
        else {
            print "Csl files that are not in the cf file\n";
            my $f=0;
            foreach my $test (@cslFiles) {
                foreach my $test1 (@cslInCfFiles) {
                    if($test eq $test1) {
                        $f = 1;
                    }
                }
                if(!$f) {
                    push ( @testlistWithPath, $testDirPath . "/$test" );
                }
                $f = 0;
            }
        }        
    }
       
    # print "[INFO] generate_regression_list: ls_cmd = $ls_cmd\n";
    
    #    my $ls_cmd = "ls $testDirPath"; #select only the regular files from the current tests dir
    #FIX - need to handle .cf and .vf files here
    #FIX - Verilog include files are a problem
    # don't need a skip list if the verilog file does not have a module ... endmodule do not compile it
    # open the cf/vf file and read all of the names in the file.
    # then remove each of the file names from the test list and add the cf/vf file to the testlist
#    my $f_file_list =`$ls_cmd_f`;

#    my @f_file_list = split(/\n/, $f_file_list);
#    chomp(@f_file_list); # get rid of '\n'
    
    my $hdl_file_list =`$ls_cmd`;

    print "[INFO] hdl_file_list = $hdl_file_list\n";

    my @hdl_file_list = split(/\n/, $hdl_file_list);
    chomp(@hdl_file_list); # get rid of '\n'
    my @testlist = (); #flushes the list
    
   
    
    my @file_list;
    if ($#cfFiles == -1) {
        print "No cf or vf files!\n";
        @file_list = @hdl_file_list;
    }
    else {
        print "cf or vf files!\n";
#        @file_list = @f_file_list;
        @file_list = @cfFiles;       
    }

    foreach my $fileName( @file_list ) { # remove the Verilog files which do not have modules
        chomp( $fileName );  #removes \n
        push ( @testlistWithPath, $testDirPath . "/$fileName" );
    }       
    
    if (&isCslHdlArg($currentHdl) ) {
        @testlist = @testlistWithPath;
    }
    elsif ($currentHdl eq "gui" ) {
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
    print "-----------@testlist\n";
    print "[INFO] generate_regression_list: end testlist cnt = $#testlist test_list = ", @testlist, "\n";
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
    my $testSrcDir = $mRegress::testRootDir . "/$currentHdl/$currentTestDirectory";
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
    $numStagesPassed{gccCompileVHDLCode    } = 0;
    $numStagesPassed{gccCompileSystemCCode } = 0;
    $numStagesPassed{sysCVerilogSim        } = 0;
    
    foreach my $stageName (@mRegress::compilerPhaseList) {
        my $s = $stageName . "Status";
        $numStagesPassed{$s} = 0;
    }
   
    # create a linked list of pages to add to the html page
    my %mapPages = ();
       
   # print "totalTestListPageNum = $totalTestListPageNum total_pages = $totalTestListPageNum numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
        for ( my $k = 0; $k < $totalTestListPageNum; $k++ ) {
            my $linkPage = "../../".$testListSummaryFileWithOutHtmlExt . "_$k.html";
            $mapPages{$k} = $linkPage; 
        }
        # print "linkPage = $linkPage\n";
       
    # put the create a linked list of pages that will be created into URL links
        my @listPageNums = sort keys %mapPages;
        my @pageLinkList = {}; # list to pass to the page template               
    
        for ( my $k = 0; $k <= $#listPageNums; $k++ ) {
            my %pageRow=(pageLink => $mapPages{$k},
                         pageNum  => $k);  
            push(@pageLinkList, \%pageRow);
        }


    my $cslcVerilogCompileStatus = $mRegress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcCppCompileStatus     = $mRegress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcCsimCompileStatus    = $mRegress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcSystemCCompileStatus = $mRegress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcVHDLCompileStatus    = $mRegress::STATUS_PHASE_DID_NOT_RUN;
    my $cslcSysCVerilogSimCompileStatus  = $mRegress::STATUS_PHASE_DID_NOT_RUN;
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
        print "Executing test: $testPathName\n";
        if($no_html eq "") {
        if ( 0 == ($includedTestNumber % $numTestsPerHtmlPage)) { # a page is created when the testcnt == $numTestsPerHtmlPage
            # print "Created template totalDirNumTests = $totalDirNumTests includedTestNumber = $includedTestNumber = numTestsPerHtmlPage = $numTestsPerHtmlPage\n";
            $testListPageTemplate = HTML::Template->new(filename => $mRegress::htmlTemplateDir . "/test_list_page.tmpl");
            $testListPageTemplate->param(dateTime      => $mRegress::test_start_time       );
            $testListPageTemplate->param(styleCss      => "../../../../../test/scripts/regress_html_templates/" . $mRegress::styleCssFile );
            $testListPageTemplate->param(testDirName   => $currentTestDirectory  );
            $testListPageTemplate->param(testDirValInv => $testDirValInv         );
        }
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
        my $cslcVHDLCompileLog        = "did_not_run_regression_no_log_file_generated";  
	my $cslcSysCVerilogSimCompileLog = "did_not_run_regression_no_log_file_generated";  
        my $cslcVerilogCompileLogName = "did_not_run_regression_no_log_file_generated";
        my $cslcCppCompileLogName     = "did_not_run_regression_no_log_file_generated";
        my $cslcCsimCompileLogName    = "did_not_run_regression_no_log_file_generated";
        my $cslcSystemCCompileLogName = "did_not_run_regression_no_log_file_generated";
        my $cslcVHDLCompileLogName    = "did_not_run_regression_no_log_file_generated";
	my $cslcSysCVerilogSimCompileLogName = "did_not_run_regression_no_log_file_generated";  
        
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
                if (&isCslHdlArg($currentHdl)) {
                    my $cslcArgs    = " --cslom_ast --info --csl_pp on --cpp_gen $callCsimGen $genCodArg";                               
                    $cmd         = "$cslcExec $cslcArgs $testPathName 1> $cslcLogFile 2>&1";
                    print "cmd = $cmd\n";
                }
                elsif ($externalArguments{"guiExtParam"} ) {
                    my $xmlTestName = $testPathName; 
                    my $guiArgs    = " -batch -xml $xmlTestName -logdir $cslcLogFile";                               
                    $cmd         = "$guiExec $guiArgs";
                    print "cmd = $cmd\n";
                }
            }
            elsif ($testPathName =~ m/\.v/){
                #                # print "[INFO] Verilog sourceDir = $currentTestDirectory TESTNAME= $testPathName\n"; 
                #                my $cslcArgs    = "--info --single";                               
                my $cslcArgs    = "--info  $genCodArg";                               
                $cmd         = "$cslcExec $cslcArgs $testPathName 1> $cslcLogFile  2>&1";
            }
            elsif ($testPathName =~ m/\.vf/){
                #                # print "[INFO] Verilog sourceDir = $currentTestDirectory TESTNAME= $testPathName\n"; 
                #                my $cslcArgs    = "--info --single";                               
                my $cslcArgs    = "--info  $genCodArg";                               
                $cmd         = "$cslcExec $cslcArgs -f $testPathName 1> $cslcLogFile  2>&1";
            }
            elsif ($testPathName =~ m/\.cf/){
                my $grepResults = `grep csl_unit $testPathName`;    
                
                if (!($grepResults eq "")) { $foundUnit = 1}
                
                my $callCsimGen = "";
                if ($foundUnit ) {
                    $callCsimGen = "--csim_gen"; # add to the command line after the compiler supports this option
                }
                
                #my $cslcArgs    = " --cslom_ast --info --single --csl_pp on --cpp_gen $callCsimGen $genCodArg";                               
                my $cslcArgs    = " --cslom_ast --info --csl_pp on --cpp_gen $callCsimGen $genCodArg";                               
                $cmd         = "$cslcExec $cslcArgs --f $testPathName 1> $cslcLogFile 2>&1";
                #print "cmd = $cmd\n";
            }
            
            if($externalArguments{enableValgrind}) {
                #$cmd = "valgrind --suppressions=/opt/valgrind/suppress/.supp --leak-check=full --show-reachable=yes -v " . $cmd;
                $cmd = "valgrind  --leak-check=full --show-reachable=yes -v " . $cmd;
            }
            
            ################################################################################
            # run cslc on the test
            ################################################################################
            #            print "cmd = $cmd\n";
 
            my $r;
            my $retVal;
            my $errorNumber;
            
            if ($externalArguments{"guiExtParam"}) {
                $r = system("$cmd");
                $retVal = $?;
                $errorNumber = ( $retVal >> 8 );
                # FIX !!!! this causes a race condition with the GUI shell and is written in random positions in the shell
                # `echo "cmd = $cmd"  >> $cslcLogFile`;
            }
            else { # Fork a new process and run the command in it. this is done to make sure that the gui finishes its 
                my $kidpid;

                if (!defined($kidpid = fork())) {
                    # fork returned undef, so failed
                    die "cannot fork: $!";
                } elsif ($kidpid == 0) {
                    # fork returned 0, so this branch is the child
                    print "Entering Child fork\n"; 
                   $r = `$cmd`;
                    $retVal = $?;
                    $errorNumber = ( $retVal >> 8 );

                    # if the exec fails, fall through to the next statement
                    die "can't exec xterm cslc command: $!";
                } else { 
                    # fork returned neither 0 nor undef, 
                    # so this branch is the parent

                    print "Waiting in parent for child fork\n"; 

                    waitpid($kidpid, 0);
                } 

 
                #sleep 10;                

 #               unless (defined ($pid = fork)) {
 #                   die "cannot fork: $!";
 #               } 
 #
 #               unless ($pid) {
 #                   $r = system("$cmd");
 #                   $retVal = $?;
 #                   $errorNumber = ( $retVal >> 8 );
 #
 #                   exit; # the child stops here
 #               } 
            }
#            print "enter any char:\n";
#            my $key = getc(STDIN);

            print "fork done\n"; 

            if ( defined ($mRegress::systemErrorMap{$errorNumber})) {
                $majorError = $errorNumber;
                my $signalErrorMsg = $mRegress::systemErrorMap{$errorNumber};
                #                print "Major error majorError = $majorError defined testname = $testName exit code = $errorNumber signalErrorMsg = $signalErrorMsg\n";

            # FIX !!!! this causes a race condition with the GUI shell and is written in random positions in the shell
            # `echo "found signal:$signalErrorMsg"  >> $cslcLogFile`;
                #$totalDirMajorErrorCnt++;
                print "[MAJOR ERROR] testname = $testPathName error :$signalErrorMsg\n";
            }       
            
            ################################################################################
            # Compile the CSLC generated code
            ################################################################################
            
            my $lsDir;
	    if(-e $genCodeTestDir) {
		$lsDir = `ls $genCodeTestDir`; # directory with the generated code            
	    }
            chop $lsDir;
            my $genCodeDir = $genCodeTestDir . "/" . $lsDir;
            print "genCodeDir = $genCodeDir\n";
            
            if ( ($retVal == 0) && ! $externalArguments{no_post_compile}  && ! $externalArguments{no_post_compile_verilog} && ! $externalArguments{run_sysc_verilog_sim}){
#            if ($foundUnit  && ($retVal == 0) && ! $externalArguments{no_post_compile}  && ! $externalArguments{no_post_compile_verilog} ){
                print "1 Post compile the Verilog code genCodeDir = $genCodeDir\n";
                
            ################################################################################
            # Compile the CSLC generated verilog code with iverilog
            ################################################################################

                #my @instanceList = `ls $genCodeDir`; # directory with the generated Verilog code            
                #chop  @instanceList;
                my $instanceDir = "code"; 
                print "2 Post compile Verilog inst list = $instanceDir \n";
                #foreach my $instanceDir (@instanceList){
                print "3 Post compile Verilog cslcVerilogCompileStatus = $cslcVerilogCompileStatus genCodeDir = $genCodeDir\n";                        
                my $verilogCodeDir    = "$genCodeDir/$instanceDir/verilog"; # directory with the generated Verilog code

                print "4 Post compile Verilog in if stmt $verilogCodeDir\n";
                # vf file containing the names of the generated Verilog files
                
                my $verilogCodeVfFile = &getVfFileName($verilogCodeDir); 
               
                if ($verilogCodeVfFile ne "") {
                    
                    my $IVERILOG_EXEC = "/usr/bin/iverilog";
                    my $VerilogCompileLogName = "$testName.verilog_compile.txt";
                    my $VerilogCompileLog     = "$verilogCodeDir/$VerilogCompileLogName"; 
                    chdir($verilogCodeDir);
                    #`iverilog -E  -o$testName.v -c$verilogCodeVfFile`;
                    #`iverilog -t vvp cat.v -o cat1`;
                    #my $cmd           = " vvp $testName.v > $VerilogCompileLog  2>&1";
                    my $cmd           = "iverilog -c$verilogCodeVfFile 1> $VerilogCompileLog 2>&1";
                    print("Verilog compile:: $cmd\n");
                    system("$cmd");
                    my $retVal = $?;
                    my $errorNumber = ( $retVal >> 8 );

                    if ( defined ($mRegress::systemErrorMap{$errorNumber})) {
                        $majorError = $errorNumber;
                        my $signalErrorMsg = $mRegress::systemErrorMap{$errorNumber};
                        `echo "found signal:$signalErrorMsg"  >> $VerilogCompileLog`;
                        #$totalDirMajorErrorCnt++;
                        print "[MAJOR ERROR] compiling generated Verilog code from testname = $testPathName\n";
                    }
                        
                    $cslcVerilogCompileStatus = $retVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;      
                   
                }
            }
        #}

                           

                ################################################################################
                # Compile the CSLC generated vhdl code with vhdlp
                ################################################################################
                 if (($retVal == 0) 
		     && ! $externalArguments{no_post_compile}  
		     && $currentHdl ne "verilog" 
		     && ! $externalArguments{no_post_compile_vhdl} && ! $externalArguments{run_sysc_verilog_sim}) {

                my $instanceDir = "code";                  
               
                my $vhdlCodeDir   = "$genCodeDir/$instanceDir/vhdl"; # directory with the generated VHDL code

		my @addVhdlPack =`cp $mRegress::totDir/trunk/src/cdom/vhdl_lib/csl_util_package.vhd $genCodeDir/$instanceDir/vhdl`; #copy the csl_util package
		chop @addVhdlPack;
		my @addVhdlLib =`cp $mRegress::totDir/trunk/src/cdom/vhdl_lib/csl_util.sym $genCodeDir/$instanceDir/vhdl`; #copy the csl_util lib
		chop @addVhdlLib;
		my @packageComp = ` vhdlp $genCodeDir/$instanceDir/vhdl/csl_util_package.vhd `; #compile the copied package
		chop @packageComp;
         
                #my $vhdlCodeVhFile = &getVhFileName($vhdlCodeDir); 

                #if ($vhdlCodeVhFile ne "") {
		if(-e $vhdlCodeDir) {
		    chdir($vhdlCodeDir); # or die "Can't find directory:".$vhdlCodeDir."\n";
		

		
                ##my $VhdlCompileLogName = "$testName.vhdl_compile.txt"; 
                ##my $VhdlCompileLog     = "$vhdlCodeDir/$VhdlCompileLogName";
		$cslcVHDLCompileLogName = "$testName.vhdl_compile.txt"; 
		$cslcVHDLCompileLog     = "$vhdlCodeDir/$cslcVHDLCompileLogName";

                                
                my $cmd1 = "$mRegress::totDir/trunk/src/cdom/vhdl_lib/csl_util_package.vhd -work csl_util";
                print "Created library for vhdl $cmd1\n";
		    `vhdlp $mRegress::totDir/trunk/src/cdom/vhdl_lib/csl_util_package.vhd -work csl_util`;
                my @vhdlList = `ls $vhdlCodeDir`; # directory with the generated VHDL code            
                chop  @vhdlList;
		
		    my $retVal = "";
                
                foreach my $elem (@vhdlList) {
                    if($elem =~ m/([a-z0-9_]+)(\.vh)$/i) {           
                        my $cmd = "vhdlp \`cat $elem\` 1> $cslcVHDLCompileLog 2>&1"; # call the generated make file
                        system("$cmd");
			$retVal = $?;
		    }
                }

		 	       
		  ##my $errorNumber = ( $retVal >> 8 ); # move the upper byte to the lower byte

		##if ( defined ($mRegress::systemErrorMap{$errorNumber})) {
		    ##$majorError = $errorNumber;
		    ##my $signalErrorMsg = $mRegress::systemErrorMap{$errorNumber};
		    ##`echo "found signal:$signalErrorMsg"  >> $cslcVHDLCompileLog`;
		    #$totalDirMajorErrorCnt++;
		    ##print "[MAJOR ERROR] compiling generated VHDL code from testname = $testPathName\n";
		##}

		$cslcVHDLCompileStatus = $retVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED; 
                
		} ## dir with generated vhdl exists
	    else {
		$cslcVHDLCompileStatus = $mRegress::STATUS_PHASE_DID_NOT_RUN;  
	    }
		    
	    }
                
                ################################################################################
                # Compile the CSLC generated SystemC code with gcc - support added by Oana B
                ################################################################################
                
	    if (($retVal == 0) 
		&& ! $externalArguments{no_post_compile}  
		&& $currentHdl ne "verilog" 
		&& $externalArguments{compile_systemc} || $externalArguments{run_sysc_verilog_sim}) {

		if(!defined($ENV{SYSTEMC})) { die "SYSTEMC env not set!\n";}

		
		my $instanceDir = "code"; 

                #foreach my $instanceDir (@instanceList){
		###my $sysCDir = "/opt/tools/systemc-2.2.0";
                my $systemCCodeDir    = "$genCodeDir/$instanceDir/systemC"; # directory with the generated SystemC code
		###my $sysC_ex = "$sysCDir/examples/sysc";
		###my $sysCCompile = "$sysC_ex/systemC";


#check if directory with generated systemc exists
		if(-e $systemCCodeDir) {

		    print "Compiling SystemC generated code!\n";

		    #print "@@@@@@@@@@@@2current test dir path:".$testDirPath."\n\n";


	       $cslcSystemCCompileLogName = "$testName.systemC_compile.txt";
               $cslcSystemCCompileLog = "$systemCCodeDir/$cslcSystemCCompileLogName";
	       my $SysCRunLogName = "$testName.systemC_run.txt";
	       my $SysCRunLog     = "$systemCCodeDir/$SysCRunLogName";

	       #my $retVal = "";


# in order to create the vectors for the systemc simulator we need user written code for each test in systemc_simulator directory
               if($currentTestDirectory eq "systemc_simulator" && $externalArguments{run_sysc_verilog_sim}) {


		   
		  my $syscSimFilesDir = "$mRegress::totDir/test/$currentHdl/$currentTestDirectory/$testName";

		  #print "@@@@@@@@3lallalaa:".$syscSimFilesDir."\n\n"; die;
		  chdir($syscSimFilesDir) or die "Can't change test dir:$syscSimFilesDir\n\n";

		  my @sysCfiles = `ls *.h`; # existing systemC code
		  chop @sysCfiles;

		  my $main = "main.cpp"; # existing systemC code
		  
		  my $copyMain = `cp -fr $main $systemCCodeDir`;
		  
		  system($copyMain) or die "Can't copy main file in $systemCCodeDir!\n";

		  foreach my $file (@sysCfiles) {

		       #print "---$file----$systemCCodeDir\n\n";

		       my $cp_cmd = `cp -fr $file $systemCCodeDir`;
		       system($cp_cmd) or die "Can't copy header files!!\n\n";
		   }

        ## compile generated systemC code using makefiles => main

                chdir($systemCCodeDir) or die "Can't change systemC dir!!\n";
		## remove old main files
		`make clean`;
		
		print "Creating exec main file!!!\n";

		  `make 1> $cslcSystemCCompileLog 2>&1`;
		  my $retVal = $?; # get the return value from the command just executed


           ##simulator part


		  ##run main file to create the stim and exp vector files
		  `main` or die "Can't run exec main file!\n";
		  
		  my @stimVecFiles = `ls stim_*`;
		  my @expVecFiles = `ls exp_*`;
		  chop @stimVecFiles;
		  chop @expVecFiles;
		  
		  
		  ##go to the verilog generated code directory
		  my $ver = "$genCodeDir/$instanceDir/verilog";
		  chdir($ver) or die "Can't go to verilog directory!\n\n";

		  $cslcSysCVerilogSimCompileLogName = "$testName.verilogTb_compile.txt";
		  $cslcSysCVerilogSimCompileLog = "$ver/$cslcSysCVerilogSimCompileLogName";
		  

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
		  my $lnExpFile = "exp_output.vec";
		  my $expLn = "ln -s $lnExpInst"."_"." $lnExpFile";
		  system("$expLn"); ## or die "Can't create soft link for exp\n\n";
		  
		  my $topUnit = `ls *.vf`;

		  my $sRetVal = "";
		  if($topUnit =~ m/([a-z0-9]+)(.vf)$/i) {
		      
		      my $runVerilog = "vpp $1.v > $1.vpp && iverilog -s tb *.v -o $1.sim && vvp $1.sim  1> $cslcSysCVerilogSimCompileLog 2>&1";
		      system("$runVerilog") or die "Can't run Verilog simulator!\n";
		      #my $retVal = $?; # get the return value from the command just executed
		      $sRetVal = $?; # get the return value from the command just executed
		      
		  }

		   #create softlinks to the vector files in the systemC gen code dir
		   ##foreach my $st (@stimVecFiles) {
		       ##`ln -s ../systemc/$st   stim_input.vec` or die "Can't create soft link\n\n";
		   ##}
		   ##foreach my $ex (@expVecFiles) {
		       ##`ln -s ../systemc/$ex   exp_output.vec` or die "Can't create soft link\n\n";
		  ## }


		  $cslcSysCVerilogSimCompileStatus = $sRetVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED; 
		   
	      }

## the rest of the systemC code is just compiled

           elsif(! $externalArguments{run_sysc_verilog_sim}) {


                ## compile generated systemC code using makefiles => main

                chdir($systemCCodeDir) or die "Can't change systemC dir!!\n";
		print "Creating main file!!!\n";

		my $cmd = "make 1> $cslcSystemCCompileLog 2>&1"; # 1> $cslcSystemCCompileLog 2>&1";
		system("$cmd");
		my $retVal = $? >> 8; # get the return value from the command just executed

		
		$cslcSystemCCompileStatus = $retVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;

	    }




###########old way to compile systemC code

		    ###`cp -fr $systemCCodeDir $sysC_ex`;
		    ###chdir($sysCCompile);  # or die "Can't change sysC compile dir\n";
		
		###my @sysCfiles = `ls -I "Makefile.in" -I "Makefile.am" -I "Makefile"`;
		###my @hFiles = "";
		###chop @sysCfiles;
		###foreach my $elem (@sysCfiles) {
		    ###if($elem =~ m/([a-z0-9_]+)(\.h)$/i) {
			###push @hFiles,$elem;
		    ###}
		###}

                ## open Makefile.am and add the right h files for every test at a time

		###my $MakefileAm = "$sysCCompile/Makefile.am";
		###my @lines;
		###my $lineNo = 1;
		###open (FILE, "$MakefileAm");## or die ("[ERROR] check_results: Error opening Makefile !\n");
		###@lines = <FILE>;
		###close(FILE);
		###my $l = join("  ",@hFiles);
		###my $ll = $l."\n";


		###open (FILE, "> $MakefileAm");## or die ("[ERROR] check_results: Error opening Makefile !\n");
		
		###foreach my $line (@lines) {
#		    if($line =~ m/([a-z0-9_]+)(\.h)([(\s+)]*)/g) {
		    ###if($lineNo == 34) {
			###print FILE $ll;## or die "Can't write in Makefile.am file!\n";
		    ###}
		    ###else {
			###print FILE $line;## or die "Can't write in Makefile.am file!\n";
		    ###}
		    ###$lineNo++;
		###}
		###close(FILE);

                
                ## open Makefile.in and add the right h files for every test at a time

		###my $MakefileIn = "$sysCCompile/Makefile.in";
		##my @lines;
		##my $lineNo = 1;
		##open (FILE, "$MakefileIn");## or die ("[ERROR] check_results: Error opening Makefile !\n");
		##@lines = <FILE>;
		###close(FILE);


		###open (FILE, "> $MakefileIn");## or die ("[ERROR] check_results: Error opening Makefile !\n");
		###foreach my $line (@lines) {
#		    if($line =~ m/([a-z0-9_]+)(\.h)([(\s+)]*)/g) {
		    ###if($lineNo == 94) {
			###print FILE $ll;## or die "Can't write in Makefile.in file!\n";
		    ###}
		    ###else {
			###print FILE $line;## or die "Can't write in Makefile.in file!\n";
		    ###}
		    ###$lineNo++;
		##}
		###close(FILE);

                ## open Makefile and add the right h files for every test at a time

		###my $Makefile = "$sysCCompile/Makefile";
		###my @lines;
		###my $lineNo = 1;
		###open (FILE, "$Makefile");## or die ("[ERROR] check_results: Error opening Makefile !\n");
		##@lines = <FILE>;
		###close(FILE);


		###open (FILE, "> $Makefile");## or die ("[ERROR] check_results: Error opening Makefile !\n");
		###foreach my $line (@lines) {
#		    if($line =~ m/([a-z0-9_]+)(\.h)([(\s+)]*)/g) {
		    ###if($lineNo == 94) {
			###print FILE $ll;## or die "Can't write in Makefile file!\n";
		    ###}
		    ###else {
			###print FILE $line;## or die "Can't write in Makefile file!\n";
		    ###}
		    ###$lineNo++;
		###}
		###close(FILE);

		##my $SysCCompileLogName = "$testName.systemC_compile.txt";
		##my $SysCCompileLog     = "$systemCCodeDir/$SysCCompileLogName";
		###$cslcSystemCCompileLogName = "$testName.systemC_compile.txt";
                ###$cslcSystemCCompileLog = "$systemCCodeDir/$cslcSystemCCompileLogName";
		###my $SysCRunLogName = "$testName.systemC_run.txt";
		###my $SysCRunLog     = "$systemCCodeDir/$SysCRunLogName";


                ## create main.o with g++
		###print "Creating main.o file with g++!\n";
		###`g++ -I\$SYSTEMC/include -c main.cpp 1> $cslcSystemCCompileLog 2>&1`;
	       ###`make check 1> $SysCRunLog 2>&1`;
		
		    ###my $retVal = $?; # get the return value from the command just executed
		

                ## remove h files and main for every test 
		###foreach my $elem (@sysCfiles) {
		    ###`rm -fr $elem`;
		###}


                
		
		#$cslcSystemCCompileStatus = $retVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;      
		} ## dir with gen code exists
	    else {
		$cslcSystemCCompileStatus = $mRegress::STATUS_PHASE_DID_NOT_RUN;      
	    }

}

###########################################



	    
#########################################












            if (($retVal == 0) && ! $externalArguments{no_post_compile}  && ! $externalArguments{no_post_compile_cpp} 
                && $currentHdl ne "verilog" && ! $externalArguments{run_sysc_verilog_sim}){
                
                ################################################################################
                # Compile the CSLC generated C++ code with gcc
                ################################################################################
                
                my $outputCppCodeDir  = "$genCodeTestDir/generated_code/generated_cpp"; # directory with the generated Cpp code
                $cslcCppCompileLogName = "$testName" . "_cpp_compile.txt"; 
                $cslcCppCompileLog = "$outputCppCodeDir/$cslcCppCompileLogName"; # cslc compile of generated cpp log file 
                my $cwd            = `pwd`;
                my $outputSCCodeDir   = "$genCodeTestDir/cpp_generated_code" ;
                if (-e $outputCppCodeDir) {
                    system("cd $outputCppCodeDir &&  make > $cslcCppCompileLog 2>&1; ");  # or die "Can't find directory:".$outputCppCodeDir."\n";
                    #print ("cd $outputCppCodeDir &&  make > $cslcCppCompileLog 2>&1; ");
                    my $retVal = $?; # get the return value from the command just executed
                    system("cd $cwd"            ); # return to our current directory
                    my $errorNumber = ( $retVal >> 8 ); # move the upper byte to the lower byte
                    if ( defined ($mRegress::systemErrorMap{$errorNumber})) {
                        $majorError = $errorNumber;
                        my $signalErrorMsg = $mRegress::systemErrorMap{$errorNumber};
                        `echo "found signal:$signalErrorMsg"  >> $cslcCppCompileLog`;
                        #$totalDirMajorErrorCnt++;
                        print "[MAJOR ERROR] compiling generated Cpp code from testname = $testPathName\n";
                    }
                    $cslcCppCompileStatus = $retVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;      
                }
                else {
                    $cslcCppCompileStatus = $mRegress::STATUS_PHASE_DID_NOT_RUN;      
                }
                
                ################################################################################
                # Compile the CSLC generated C++ C simulator code with gcc
                ################################################################################
                if ($foundUnit && $externalArguments{compile_csim} ){ ## CSimGen only generates code if there are units
                    

		    print "!!!!!!!Compile csim code!!!!!!!!!\n";
		    # testbench_valid/gen_code/csl_testbench/generated_code/generated_csim/csl_testbench_csim_compile.txt
		    # correct: testbench_valid/gen_code/csl_testbench_generate_report/a_cslc_generated/code/csim


		    my $outputCsimCodeDir = "$genCodeDir/code/csim/generated"; # directory with the generated csim code
                    #my $outputCsimCodeDir  = "$genCodeTestDir/csim_generated_code"; # directory with the generated Csim code
		    #print "!!!!!!!directory with generated csim:".$outputCsimCodeDir."\n";
                    $cslcCsimCompileLogName = "$testName" . "_csim_compile.txt"; # cslc compile of generated csim log file 
                    $cslcCsimCompileLog = "$outputCsimCodeDir/$cslcCsimCompileLogName"; # cslc compile of generated csim log file 
                    my $cwd             = `pwd`;
		    my $outputSCCodeDir  = "$genCodeDir/code/csim";
                    #my $outputSCCodeDir    = "$genCodeTestDir/csim_generated_code" ;
                    if (-e $outputCsimCodeDir) {
                        system("cd $outputSCCodeDir") || die ("[ERROR] $outputSCCodeDir does not exist\n"); # go to the generated Csim directory 
                        #system("make > $cslcCsimCompileLog 2>&1"               ); # call the generated make file
			chdir($outputSCCodeDir) or print "Can't change directory:".$outputSCCodeDir."\n";
			#print "-----------------".$outputSCCodeDir."\n";
			# run the compile.pl script for each directory with generated code
			`./compile.pl generated/`;
                        my $retVal = $?; # get the return value from the command just executed
                        system("cd $cwd"            ) or print "Can't find directory:".$cwd."\n"; # return to our current directory
                        my $errorNumber = ( $retVal >> 8 ); # move the upper byte to the lower byte
                        if ( defined ($mRegress::systemErrorMap{$errorNumber})) {
                            $majorError = $errorNumber;
                            my $signalErrorMsg = $mRegress::systemErrorMap{$errorNumber};
                            `echo "found signal:$signalErrorMsg"  >> $cslcCsimCompileLog`;
                            #$totalDirMajorErrorCnt++;
                            print "[MAJOR ERROR] compiling generated Csim code from testname = $testPathName\n";
                        }
                        $cslcCsimCompileStatus = $retVal == 0 ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;      
                    }
                    else {
                        $cslcCsimCompileStatus = $mRegress::STATUS_PHASE_DID_NOT_RUN;      
                    }
                }
            }
        }  
        
########### Insert new post compile code Here


        my %testRow = &getFileErrors ($currentHdl, $cslcLogFile, $totalDirNumTests, $testName, $testPathName, $isValid, $majorError, $foundUnit, $currentTestDirectory, 
                                      $cslcVerilogCompileStatus, $cslcCppCompileStatus, $cslcCsimCompileStatus, $cslcVHDLCompileStatus, $cslcSystemCCompileStatus, $cslcSysCVerilogSimCompileStatus, 
                                      $cslcVerilogCompileLog, $cslcCppCompileLog, $cslcCsimCompileLog, $cslcVHDLCompileLog, $cslcSystemCCompileLog, $cslcSysCVerilogSimCompileLog,
                                      $cslcVerilogCompileLogName   , $cslcCppCompileLogName   , $cslcCsimCompileLogName   , $cslcVHDLCompileLogName   , $cslcSystemCCompileLogName   , $cslcSysCVerilogSimCompileLogName   ,
                                      $cslcLogFileShort);
        
        my $testStatus = ( $mRegress::STATUS_PASSED eq $testRow{ overallTestStatus }) ? 1 : 0 ;
        
        $totalDirMajorErrorCnt    += $testRow{majorErrorCnt}; 
        $totalDirValgrindErrorCnt += $testRow{valgrindErrorCnt}; 
        
        #print "majorErrorCnt = $majorErrorCnt testRow{majorErrorCnt} = $testRow{majorErrorCnt} totalDirMajorErrorCnt = $totalDirMajorErrorCnt\n"; 
        
        foreach my $stageName (@mRegress::compilerPhaseList) {
            my $s = $stageName . "Status";
            #print "xx testRow{$s} = $testRow{$s}\n";
            if ($mRegress::STATUS_PASSED eq $testRow{$s}) { $numStagesPassed{$s}++; }
        }
        
        if ($mRegress::STATUS_PASSED eq $testRow{cslcCompileVerilogCode}) { $numStagesPassed{cslcCompileVerilogCode}++; }
        if ($mRegress::STATUS_PASSED eq $testRow{gccCompileCppCode     }) { $numStagesPassed{gccCompileCppCode     }++; }
        if ($mRegress::STATUS_PASSED eq $testRow{gccCompileCsimCode    }) { $numStagesPassed{gccCompileCsimCode    }++; }   
    	if ($mRegress::STATUS_PASSED eq $testRow{gccCompileVHDLCode }) { $numStagesPassed{gccCompileVHDLCode }++; }
        if ($mRegress::STATUS_PASSED eq $testRow{gccCompileSystemCCode }) { $numStagesPassed{gccCompileSystemCCode }++; }
	if ($mRegress::STATUS_PASSED eq $testRow{sysCVerilogSim }) { $numStagesPassed{sysCVerilogSim} ++; }
        
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
       if($no_html eq "") {
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
    }
    
    my %testResults = ();
    if($no_html eq "") { 
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
}
    
    
    $testResults{totalDirNumTests        } = $totalDirNumTests      ;
    $testResults{totalDirNumTestsPassed  } = $totalDirNumTestsPassed;
    $testResults{totalDirPercentPassed   } = $totalDirPercentPassed * 100 ;
    $testResults{directoryStatusCSS      } = (100 == $totalDirPercentPassed) ?  $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;
    $testResults{totalDirMajorErrorCnt   } = $totalDirMajorErrorCnt   ;
    $testResults{totalDirValgrindErrorCnt} = $totalDirValgrindErrorCnt;
    $testResults{numStagesPassed         } = \%numStagesPassed;
    # print "[INFO] executeDirectoryTestlist: end testResults = ", %testResults, "\n";
    # print "[INFO] executeDirectoryTestlist: end \n";
    
    foreach my $stageName (@mRegress::compilerPhaseList) {
        my $s = $stageName . "Status";
        #print "tt numStagesPassed{$s} = $numStagesPassed{$s}\n";
    }

   # write out the resutls for the directory run so that it can be read by ssh_dist_regress.pl and merged into one summary
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
   
    chomp $ls_cmd;
    chomp $fileName;
    print "getVfFileName:: vf = $fileName\n";
    
    return $fileName;
}

#################################################################################################
#                                          detectErrors                                         #
#subroutine for checking if any error has occured                                               #
#################################################################################################

sub getFileErrors {
    my ($currentHdl, $cslcLogFile, $testCnt, $testName, $testPathName, $isValid, $majorError, $foundUnit, $currentTestDirectory,  
        $cslcVerilogCompileStatus, $cslcCppCompileStatus, $cslcCsimCompileStatus, $cslcVHDLCompileStatus, $cslcSystemCCompileStatus, $cslcSysCVerilogSimCompileStatus,
        $cslcVerilogCompileLog   , $cslcCppCompileLog   , $cslcCsimCompileLog   , $cslcVHDLCompileLog   , $cslcSystemCCompileLog   , $cslcSysCVerilogSimCompileLog   ,
        $cslcVerilogCompileLogName   , $cslcCppCompileLogName   , $cslcCsimCompileLogName   , $cslcVHDLCompileLogName   , $cslcSystemCCompileLogName   , $cslcSysCVerilogSimCompileLogName   ,
        $cslcLogFileShort) = @_;
    
    my %Status = ();
    my $relativeFileName = "";
    
    # this $relativeFileName causes the following error if placed at the bottom of this function
    # Illegal declaration of subroutine main::finishUp at /home/dpappas/fplsrl_repo/fpl/cslc/trunk/scripts/run_regress.pl line 1828.

    if ($currentHdl eq "verilog") {
        $relativeFileName = "../../../../../test/$currentHdl/$currentTestDirectory/$testName.v"; 
    }
    else {
        if($testPathName =~ /([a-z0-9_]+)(\.cf)/) {
            $relativeFileName = "../../../../../test/$currentHdl/$currentTestDirectory/$testName.cf"; 
        }
        else{
            $relativeFileName = "../../../../../test/$currentHdl/$currentTestDirectory/$testName.csl"; 
        }
    }
    
    # init the status for each phase
    foreach my $phase (@mRegress::compilerPhaseList) {
        $Status{$phase            } = $mRegress::STATUS_PHASE_DID_NOT_RUN;        
    }
    
    my %foundSection  = ();
    foreach my $k (@mRegress::compilerPhaseList) {
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
                     overallTestStatus            => $mRegress::STATUS_PHASE_DID_NOT_RUN,   
                     cslcCompileVerilogCode       => $mRegress::STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileCppCode            => $mRegress::STATUS_PHASE_DID_NOT_RUN,   
                     gccCompileCsimCode           => $mRegress::STATUS_PHASE_DID_NOT_RUN,
   		     gccCompileVHDLCode           => $mRegress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileSystemCCode        => $mRegress::STATUS_PHASE_DID_NOT_RUN, 
		     sysCVerilogSim               => $mRegress::STATUS_PHASE_DID_NOT_RUN, 
                     cslcCompileVerilogLog        => "no_log_file",   
                     gccCompileCppLog             => "no_log_file",   
                     gccCompileCsimLog            => "no_log_file", 
  		     gccCompileVHDLLog            => "no_log_file",
                     gccCompileSystemCLog         => "no_log_file",
		     sysCVerilogSim               => "no_log_file",
                     
                     minorErrorCntCSSClass                 => $mRegress::STATUS_PHASE_DID_NOT_RUN,    
                     majorErrorCntCSSClass                 => $mRegress::STATUS_PHASE_DID_NOT_RUN,    
                     valgrindErrorCntCSSClass              => $mRegress::STATUS_PHASE_DID_NOT_RUN,    
                     overallTestStatusCSSClass             => $mRegress::STATUS_PHASE_DID_NOT_RUN,
                     compilerPhasePassedPercentageCSSClass => $mRegress::STATUS_PHASE_DID_NOT_RUN,    
                     cslcCompileGenVerilogStatusCSSClass   => $mRegress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenCppStatusCSSClass        => $mRegress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenCsimStatusCSSClass       => $mRegress::STATUS_PHASE_DID_NOT_RUN,
		     gccCompileGenVHDLStatusCSSClass       => $mRegress::STATUS_PHASE_DID_NOT_RUN,
                     gccCompileGenSystemCStatusCSSClass    => $mRegress::STATUS_PHASE_DID_NOT_RUN,
		     sysCVerilogSimStatusCSSClass          => $mRegress::STATUS_PHASE_DID_NOT_RUN,
                     
                     );
        return %testRow;
    }
    

    while (!-e $cslcLogFile) { print "waiting for $cslcLogFile\n"; sleep 1; }

    open (FH, $cslcLogFile) or die "[ERROR] could not open cslcLogFile: $cslcLogFile\n";
    my @lines = <FH>;
    
    my $errorType             = 0;
    my $minorErrorCnt         = 0;
    my $majorErrorCnt         = 0;
    my $valgrindErrorCnt      = 0;
    my $warnCnt               = 0;
    my $foundPreviousStageNum = 1;
    my $stageNum              = 0; # current stage number
    my $stageName             = $mRegress::compilerPhaseList[$stageNum];
    my %StatusCssClass        = ();
    my $valgrind_error        = 0;
    
    for ( my $i = 0; $i <= $#lines; $i++ ) {
        my $line = $lines[$i];
        
        if ($externalArguments{enableValgrind}) {
            if (($line =~ m/definitely lost: [1-9]/) || ($line =~ m/possibly lost: [1-9]/) || ($line =~ m/still reachable: [1-9]/)) { 
                $valgrind_error++;
                $valgrindErrorCnt = 1; 
                $Status{"$stageName"} = $mRegress::STATUS_FAILED;
                
                print "found valgrind error\n";
                # add a record to the error list which will be emailed to owners
                my %errorRpt = ( "directory"  => $currentTestDirectory,
                                 "testname"   => $testName,
                                 "minorError" => ""       ,
                                 "majorError" => ""       ,
                                 "valgrindError" => $line ,
                                 );
                # print "errorRpt = ", %errorRpt, "\n";
                
                push (@{$mRegress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                #                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", mRegress::errorListByCompilerPhase{$stageName}, "\n"; 
                print "go to done\n";
                goto DONE; 
            }            
        }
        
        if (0 == $foundUnit && &isCslHdlArg($currentHdl) && $stageName eq "$mRegress::STAGE_CSIM_CODE_GEN") { # skip CSIM code gen stage
            print "skip $mRegress::STAGE_CSIM_CODE_GEN stage\n";
            $stageNum++;
            $stageName = $mRegress::compilerPhaseList[$stageNum];
            $i--; # stay on the same line until the right stage name is reached
        }
        elsif (($currentHdl eq "verilog" ) && &isCslStage($stageName)) { # this is a Verilog test and we do not run CSl compilation steps on verilog tests
            print "finderrors isCSLStage stageName = $stageName\n";
            $stageNum++;
            $stageName = $mRegress::compilerPhaseList[$stageNum];
            # print "finderrors  stageName = $stageName\n";
            $i--; # stay on the same line until the right stage name is reached
        }
        else {
            my $pattern = "$stageName" . "_begin";
            print "pattern = $pattern line = $line\n";
            if ($line =~ m/$pattern/i ) {  ## found begin stage
                # print "found phase= $stageName \n";
                print "found begin pattern a line = $line\n";
                $Status{"$stageName"} = $mRegress::STATUS_FAILED; # inside of begin-set to failed unless end is reached and no errors are found
                for ( my $k = $i+1; $k <= $#lines; $k++ ) {
                    $i = $k;
                    $line = $lines[$k];
                    # print "b line = $line\n";
                    my $pattern = "$stageName" . "_end";
                    print "pattern = $pattern line = $line\n";
                    #print "before findErrors line = $line\n";
                    
                    if ($line =~ m/$pattern/i ) { # found end-so section passed
                        print "found end pattern\n";
                        
                        $foundSection{"$stageName"} = 1;
                        if (0 == $warnCnt) {
                            $Status{"$stageName"} = $mRegress::STATUS_PASSED;
                        }
                        elsif ($warnCnt > 0) {
                            $Status{"$stageName"} = $mRegress::STATUS_PASSED_WARNING;
                        }
                        
                        $StatusCssClass{"$stageName"} = &getStatusCssClass("$stageName", $Status{"$stageName"});         
                        $stageNum++;
                        $stageName = $mRegress::compilerPhaseList[$stageNum];
                        # print "stageName = $stageName foundUnit = $foundUnit\n";
                        
                        print "go to next\n";
                        
                        goto NEXT;
                    }
                    else {
                        
                        $errorType = &findErrors($line);
                        if    ($mRegress::MINOR_ERROR == $errorType) { # found error - section failed
                            $minorErrorCnt = 1;                         
                            $Status{"$stageName"} = $mRegress::STATUS_FAILED;
                            print "found minor error\n";
                            
                            if ($isValid) { # add a record to the error list which will be emailed to owners
                                my %errorRpt = ( "directory"  => $currentTestDirectory,
                                                 "testname"   => $testName,
                                                 "minorError" => $line    ,
                                                 "majorError" => ""       ,
                                                 "valgrindError" => ""    ,
                                                 );
                                #print "errorRpt = ", %errorRpt, "\n";
                                push (@{$mRegress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                                # print "Minor error stageName = $stageName testName = $testName Added error rpt = /%errorRpt/ to errorListByCompilerPhase{$stageName} = ", $mRegress::errorListByCompilerPhase{$stageName}, "\n"; 
                            }
                            if (!$externalArguments{enableValgrind}) {
                                print "go to done\n";
                                goto DONE; 
                            }
                        }
                        elsif ($mRegress::MAJOR_ERROR == $errorType) { # found error - section failed
                            $majorErrorCnt = 1; 
                            $Status{"$stageName"} = $mRegress::STATUS_FAILED;
                            
                            # print "found major error\n";
                            # add a record to the error list which will be emailed to owners
                            my %errorRpt = ( "directory"  => $currentTestDirectory,
                                             "testname"   => $testName,
                                             "minorError" => ""     ,
                                             "majorError" => $line  ,
                                             "valgrindError" => ""       ,
                                             );
                            # print "errorRpt = ", %errorRpt, "\n";
                            
                            push (@{$mRegress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                            #                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $mRegress::errorListByCompilerPhase{$stageName}, "\n"; 
                            if (!$externalArguments{enableValgrind}) {
                                print "go to done\n";
                                goto DONE; 
                            }
                        }
                        elsif ($mRegress::VALGRIND_ERROR == $errorType) { # found error - section failed
                            $valgrindErrorCnt = 1; 
                            $Status{"$stageName"} = $mRegress::STATUS_FAILED;
                            
                            print "found valgrind error\n";
                            # add a record to the error list which will be emailed to owners
                            my %errorRpt = ( "directory"  => $currentTestDirectory,
                                             "testname"   => $testName,
                                             "minorError" => ""       ,
                                             "majorError" => ""       ,
                                             "valgrindError" => $line ,
                                             );
                            # print "errorRpt = ", %errorRpt, "\n";
                            
                            push (@{$mRegress::errorListByCompilerPhase{$stageName}}, \%errorRpt);
                            #                        # print "Major error stageName = $stageName testName = $testName Added error rpt = $errorRpt to errorListByCompilerPhase{$stageName} = ", $mRegress::errorListByCompilerPhase{$stageName}, "\n"; 
                            if (!$externalArguments{enableValgrind}) {
                                print "go to done\n";
                                goto DONE; 
                            }
                        }
                        
                    }
                }
            }  ## end of pattern match begin
        }
      NEXT:
    }
    print "before done\n";
    
  DONE:
    close (FH);
    
    $Status{$mRegress::STAGE_VALGRIND        } = $mRegress::STATUS_PHASE_DID_NOT_RUN;
    $StatusCssClass{$mRegress::STAGE_VALGRIND} = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN; 
    
    if ($externalArguments{enableValgrind}) { 
        my $valgrind_passed = ($valgrind_error == 0);
        my $valgrind_status = $valgrind_error;
        $StatusCssClass{$mRegress::STAGE_VALGRIND} = $valgrind_passed ? $mRegress::CSS_STATUS_PASSED : $mRegress::CSS_STATUS_FAILED; 
    }
    
    $Status{$mRegress::STAGE_OVERALL_STATUS} = $mRegress::STATUS_FAILED;
    
    my $k;
    my $allSectionsPassed = 1;
    
    foreach my $stageName (@mRegress::compilerPhaseList) {
        if (0 == $foundUnit && $stageName eq $mRegress::STAGE_CSIM_CODE_GEN) { # skip CSIM code gen stage
            next;
        }
        elsif (($currentHdl eq "verilog" ) && &isCslStage($stageName)) { # this is a Verilog test and we do not run CSl compilation steps on verilog tests
            next;
        }
        elsif (!($mRegress::STATUS_PASSED eq $Status{"$stageName"})) {
            $allSectionsPassed = 0;
            last;
        }
    }
    
    my $postCompilePassed =  ($mRegress::STATUS_PASSED == $cslcVerilogCompileStatus) && ($mRegress::STATUS_PASSED ==  $cslcVHDLCompileStatus) && ($mRegress::STATUS_PASSED ==  $cslcSystemCCompileStatus) && ($mRegress::STATUS_PASSED == $cslcCppCompileStatus) && ($mRegress::STATUS_PASSED == $cslcCsimCompileStatus)  && ($mRegress::STATUS_PASSED == $cslcSysCVerilogSimCompileStatus);
    
    #FIX ADD LATER $allSectionsPassed = $allSectionsPassed && $postCompilePassed;
    
    #print "XXX majorError = $majorError\n";

    if ($majorError > 0) { # when we have a major error it doesn't matter if it is a valid test or a invalid test the file overall stage must be FAILED
        $Status{$mRegress::STAGE_OVERALL_STATUS} = $mRegress::STATUS_FAILED;
        $majorErrorCnt = 1;
    }
    else {
        if(1 == $allSectionsPassed) { # if all stages did not run then look for a major error such as abort or segfault
            if (0 == $minorErrorCnt && 0 == $majorErrorCnt && 0 == $valgrindErrorCnt ) { 
                $Status{$mRegress::STAGE_OVERALL_STATUS} = $isValid ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;
            }
            elsif (0 != $valgrindErrorCnt ) { 
                $Status{$mRegress::STAGE_OVERALL_STATUS} = $isValid ? $mRegress::STATUS_FAILED : $mRegress::STATUS_PASSED;
            }
            elsif ($warnCnt > 0) { 
                $Status{$mRegress::STAGE_OVERALL_STATUS} = $isValid ? $mRegress::STATUS_PASSED_WARNING : $mRegress::STATUS_FAILED;
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
                $Status{$mRegress::STAGE_OVERALL_STATUS} = $isValid ? $mRegress::STATUS_FAILED : $mRegress::STATUS_PASSED;
            }
            elsif ($minorErrorCnt > 0) { 
                $Status{$mRegress::STAGE_OVERALL_STATUS} = $isValid ? $mRegress::STATUS_FAILED : $mRegress::STATUS_PASSED;
            }
            else {             
                $Status{$mRegress::STAGE_OVERALL_STATUS} = $isValid ? $mRegress::STATUS_FAILED : $mRegress::STATUS_PASSED;
            }
        }
    }
    
    my $passedStages = 0;
    foreach my $name (@mRegress::compilerPhaseList) {
        my $status = $Status{$name};
        if ($status eq $mRegress::STATUS_PASSED){
            $passedStages++;
        }
    }
    
    my $stageCnt = 0;
    if ( $currentHdl eq "verilog" ) {
        foreach my $stageName (@mRegress::compilerPhaseList) {
            if ( !&isCslStage($stageName)) {$stageCnt++;}
        }
    }
    else {
        $stageCnt = $#mRegress::compilerPhaseList +1; # FIX this is an approximation-if the --csim_gen flag if off then one stage should be subtracted. Not sure if this is worth doing
        #print "else branch: stageCnt = $stageCnt\n";
    }
    
    my $compilerPhasePassedPercentage = ($passedStages/($stageCnt)) * 100;
    my $percentage                    = sprintf( "%3d%", $compilerPhasePassedPercentage);
    $Status{$mRegress::STAGE_CPHASE_PASS_PERCENT} = $percentage; # make it a percentage
    
    foreach my $phase (@mRegress::compilerPhaseList) {
        $StatusCssClass{$phase} = &getStatusCssClass($phase, $Status{$phase});         
#        print "StatusCssClass{$phase} = ", $StatusCssClass{"$phase"},"\n";

    }
    
    if(0 == $foundUnit){ 
        my $phase = $mRegress::STAGE_CSIM_CODE_GEN; 
        $Status{$phase} = $mRegress::STATUS_PHASE_DID_NOT_RUN;
        $StatusCssClass{$phase} = &getStatusCssClass($phase, $Status{$phase});  
    }
    
    $StatusCssClass{$mRegress::STAGE_MINOR_ERROR      } = &getStatusCssClass($mRegress::STAGE_MINOR_ERROR      , $minorErrorCnt   );    
    $StatusCssClass{$mRegress::STAGE_MAJOR_ERROR      } = &getStatusCssClass($mRegress::STAGE_MAJOR_ERROR      , $majorErrorCnt   );    
    $StatusCssClass{$mRegress::STAGE_VALGRIND_ERROR   } = &getStatusCssClass($mRegress::STAGE_VALGRIND_ERROR   , $valgrindErrorCnt);    
    $StatusCssClass{$mRegress::STAGE_OVERALL_STATUS   } = &getStatusCssClass($mRegress::STAGE_OVERALL_STATUS   , $Status{$mRegress::STAGE_OVERALL_STATUS   });  
    
    $StatusCssClass{$mRegress::STAGE_CPHASE_PASS_PERCENT} = (100 == $compilerPhasePassedPercentage) ? $mRegress::STATUS_PASSED : $mRegress::STATUS_FAILED;
    
    if ($externalArguments{no_post_compile}) {
        $StatusCssClass{$mRegress::CSLC_COMPILE_GENERATED_VERILOG     } = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN;  
       	$StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_VHDL_CODE    } = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN;
        $StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_SYSTEMC_CODE } = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN; 
        $StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_CPP_CODE     } = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN; 
        $StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_CSIM_CODE} = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN; 
	$StatusCssClass{$mRegress::SYSC_VERILOG_SIM} = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN;
    }      
    else {
        $StatusCssClass{$mRegress::CSLC_COMPILE_GENERATED_VERILOG     } = ($cslcVerilogCompileStatus eq $mRegress::STATUS_PASSED) ? $mRegress::CSS_STATUS_PASSED :( ($cslcVerilogCompileStatus eq $mRegress::STATUS_FAILED) ? $mRegress::CSS_STATUS_FAILED : $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN); 
        $StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_CPP_CODE     } = ($cslcCppCompileStatus     eq $mRegress::STATUS_PASSED) ? $mRegress::CSS_STATUS_PASSED :( ($cslcCppCompileStatus     eq $mRegress::STATUS_FAILED) ? $mRegress::CSS_STATUS_FAILED : $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN); 
        $StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_CSIM_CODE} = ($cslcCsimCompileStatus    eq $mRegress::STATUS_PASSED) ? $mRegress::CSS_STATUS_PASSED :( ($cslcCsimCompileStatus    eq $mRegress::STATUS_FAILED) ? $mRegress::CSS_STATUS_FAILED : $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN);
	$StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_VHDL_CODE } = ($cslcVHDLCompileStatus eq $mRegress::STATUS_PASSED) ? $mRegress::CSS_STATUS_PASSED :( ($cslcVHDLCompileStatus eq $mRegress::STATUS_FAILED) ? $mRegress::CSS_STATUS_FAILED : $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN);
        $StatusCssClass{$mRegress::GCC_COMPILE_GENERATED_SYSTEMC_CODE } = ($cslcSystemCCompileStatus eq $mRegress::STATUS_PASSED) ? $mRegress::CSS_STATUS_PASSED :( ($cslcSystemCCompileStatus eq $mRegress::STATUS_FAILED) ? $mRegress::CSS_STATUS_FAILED : $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN);
	$StatusCssClass{$mRegress::SYSC_VERILOG_SIM } = ($cslcSysCVerilogSimCompileStatus eq $mRegress::STATUS_PASSED) ? $mRegress::CSS_STATUS_PASSED :( ($cslcSysCVerilogSimCompileStatus eq $mRegress::STATUS_FAILED) ? $mRegress::CSS_STATUS_FAILED : $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN);

    }
    
    
    # create the row to add to the TMP_LOOP
    my %testRow=(testNumber                   => $testCnt,
                 linkToLogFile                => $cslcLogFileShort,
                 testName                     => $testName        ,
                 linkToTestName               => $relativeFileName,
                 minorErrorCnt                => $minorErrorCnt   ,
                 majorErrorCnt                => $majorErrorCnt   ,
                 valgrindErrorCnt             => $valgrindErrorCnt,
                 compilerPhasePassedPercentage=> $Status{$mRegress::STAGE_CPHASE_PASS_PERCENT  },
                 overallTestStatus            => $Status{$mRegress::STAGE_OVERALL_STATUS       },   
                 cslcCompileVerilogCode       => $cslcVerilogCompileStatus,   
                 gccCompileCppCode            => $cslcCppCompileStatus    ,   
                 gccCompileCsimCode           => $cslcCsimCompileStatus   , 
  		 gccCompileVHDLCode           => $cslcVHDLCompileStatus,
                 gccCompileSystemCCode        => $cslcSystemCCompileStatus,  
		 sysCVerilogSim               => $cslcSysCVerilogSimCompileStatus,
#                 cslcCompileVerilogLog        => "gen_code/$testName/generated_code/generated_verilog/$cslcVerilogCompileLogName",   
                 cslcCompileVerilogLog        => "gen_code/$testName",   
                 gccCompileCppLog             => "gen_code/$testName/generated_code/generated_cpp/$cslcCppCompileLogName"        ,   
                 #gccCompileCsimLog            => "gen_code/$testName/generated_code/generated_csim/$cslcCsimCompileLogName"      ,   
		 gccCompileCsimLog            => "gen_code/$testName",
		 gccCompileVHDLLog            => "gen_code/$testName",
                 gccCompileSystemCLog         => "gen_code/$testName",  
		 sysCVerilogSimLog            => "gen_code/$testName", 
                 
                 minorErrorCntCSSClass                 => $StatusCssClass{ $mRegress::STAGE_MINOR_ERROR                   },    
                 majorErrorCntCSSClass                 => $StatusCssClass{ $mRegress::STAGE_MAJOR_ERROR                   },    
                 valgrindErrorCntCSSClass              => $StatusCssClass{ $mRegress::STAGE_VALGRIND_ERROR                },    
                 overallTestStatusCSSClass             => $StatusCssClass{ $mRegress::STAGE_OVERALL_STATUS                },
                 compilerPhasePassedPercentageCSSClass => $StatusCssClass{ $mRegress::STAGE_CPHASE_PASS_PERCENT           },    
                 cslcCompileGenVerilogStatusCSSClass   => $StatusCssClass{ $mRegress::CSLC_COMPILE_GENERATED_VERILOG      },
                 gccCompileGenCppStatusCSSClass        => $StatusCssClass{ $mRegress::GCC_COMPILE_GENERATED_CPP_CODE      },
                 gccCompileGenCsimStatusCSSClass       => $StatusCssClass{ $mRegress::GCC_COMPILE_GENERATED_CSIM_CODE     },
		 gccCompileGenVHDLStatusCSSClass       => $StatusCssClass{ $mRegress::GCC_COMPILE_GENERATED_VHDL_CODE  },
                 gccCompileGenSystemCStatusCSSClass    => $StatusCssClass{ $mRegress::GCC_COMPILE_GENERATED_SYSTEMC_CODE  },
		 sysCVerilogSimStatusCSSClass          => $StatusCssClass{ $mRegress::SYSC_VERILOG_SIM  },
                 
                 );
    
    foreach my $stageName (@mRegress::compilerPhaseList) {
        my $s = $stageName . "Status";
        $testRow{$s} = $Status{$stageName}
    }
    
    foreach my $stageName (@mRegress::compilerPhaseList) {
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
    if    ($stageName eq $mRegress::STAGE_INST_TREE         ) { $cslStage = 1; }  
    elsif ($stageName eq $mRegress::STAGE_AUTO_ROUTER       ) { $cslStage = 1; }  
    elsif ($stageName eq $mRegress::STAGE_AUTO_MAPPER       ) { $cslStage = 1; }  
    elsif ($stageName eq $mRegress::STAGE_CSLOM_CHECKER     ) { $cslStage = 1; }  
    elsif ($stageName eq $mRegress::STAGE_CSLOM_CONN_CHECKER) { $cslStage = 1; } 
    elsif ($stageName eq $mRegress::STAGE_CPP_CODE_GEN      ) { $cslStage = 1; }  
    elsif ($stageName eq $mRegress::STAGE_CSIM_CODE_GEN     ) { $cslStage = 1; }  
    elsif ($stageName eq $mRegress::STAGE_ADAPTER           ) { $cslStage = 1; }        
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
    if( $line =~ m/(abort)/i               ) { $errorType = $mRegress::MAJOR_ERROR; }
    elsif( $line =~ m/(assert)/i           ) { $errorType = $mRegress::MAJOR_ERROR; }
    if    ( $line =~ m/(antlr exception)/i  ) { $errorType = $mRegress::MAJOR_ERROR; }
    elsif ( $line =~ m/(exception)/i        ) { $errorType = $mRegress::MAJOR_ERROR; }
    elsif ( $line =~ m/(noviablealt)/i      ) { $errorType = $mRegress::MAJOR_ERROR; }
    elsif ( $line =~ m/(segmentation)/i     ) { $errorType = $mRegress::MAJOR_ERROR; }
    elsif ( $line =~ m/(error)/i            ) { $errorType = $mRegress::MINOR_ERROR; }
    elsif ( $line =~ m/(type check on cast failure)/i ) { $errorType = $mRegress::MAJOR_ERROR; }
    elsif ($line =~ m/LEAK SUMMARY/                  ) { $errorType = $mRegress::VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid free/                  ) { $errorType = $mRegress::VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid write/                 ) { $errorType = $mRegress::VALGRIND_ERROR; }
    elsif ($line =~ m/Invalid read/                  ) { $errorType = $mRegress::VALGRIND_ERROR; }
    elsif ($line =~ m/Mismatched free/               ) { $errorType = $mRegress::VALGRIND_ERROR; }
    elsif ($line =~ m/Conditional jump or move depends on uninitialised value/) { $errorType = $mRegress::VALGRIND_ERROR; }
    
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
    
    if ($status eq $mRegress::STATUS_FAILED) { $cssStatus = $mRegress::STATUS_FAILED; }
    elsif ($status eq $mRegress::STATUS_PASSED) { 
        $cssStatus = $mRegress::STATUS_PASSED;
    }
    elsif (($compilerPhase eq $mRegress::STAGE_MINOR_ERROR) || ($compilerPhase eq $mRegress::STAGE_MAJOR_ERROR) || ($compilerPhase eq $mRegress::STAGE_VALGRIND_ERROR)) {
        if ($status != 0) { $cssStatus = $mRegress::STATUS_FAILED; }
        else              { $cssStatus = $mRegress::STATUS_PASSED; }
    }
    elsif ($status eq $mRegress::STATUS_PHASE_DID_NOT_RUN ) { $cssStatus = $mRegress::CSS_STATUS_PHASE_DID_NOT_RUN; }
    elsif ($status eq $mRegress::STATUS_VALGRIND_ERROR    ) { $cssStatus = $mRegress::CSS_STATUS_VALGRIND_ERROR;    }
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
                                     csl_ar_gen      : run the CSL csl_ar_gen     tests (Perl script corner case generators).
                                     \n";
    print " -dir_filter <filter> -> only run the regression script on the specified directory. \n";  
    print " -errors_only         -> only display the failed tests in the HTML output \n";  
    print " -major_errors_only  -> only display the failed tests with MAJOR ERRORS in the HTML output \n";  
    print " -www                 -> pops up firefox with the html results. \n";  
    print " -no_post_compile     -> Do not compile the generated code. \n";  
    print " -no_post_compile_cpp -> Do not compile the CPP and CSIM CPP generated code. \n";  
    ##print " -no_post_compile_systemc -> Do not compile the SystemC CPP generated code. \n";
    print " -compile_systemc -> Compile the SystemC generated code. \n";
    print " -run_sysc_verilog_sim -> Run systemC simulator for Verilog testbenches. \n";
    print " -no_post_compile_vhdl ->Do not compile the VHDL generated code. \n"; 
    print " -no_post_compile_verilog ->Do not compile the Verilog generated code. \n"; 
    print " -results_dir <path2> -> saves the current results files to <path2>. \n";
    print " -no_exec             -> do not run cslc; the regression generates the HTML report using the last version of the results files. \n";
    print " -h                   -> display help info\n";
    print " -version             -> prints version\n";
    print " -v                   -> verbosity on \n";
    print " -val                 -> run valgrind to detect memory leaks\n";
    print " -no_html_report      -> do not generate html reports\n";
}  

#################################################################################################
#                                          finishUp                                             #
#subroutine for finishing the regress when a signal is received                                 #
#################################################################################################

sub finishUp() {
    my($test_start_time) = @_;
    
    # print "[WARNING] Caught $signalName . Finishing up...\n";
    # print "\nCaught $signalName ! Regression halted!\n";
    
    #my @array = ();
    my $index   = rand @mRegress::array;
    my $element = $mRegress::array[$index];
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
    print ERROR_FH "compilerPhaseList cnt = $#mRegress::compilerPhaseList compilerPhaseList = ", @mRegress::compilerPhaseList ,"\n";
    
#    foreach my $phase (@mRegress::compilerPhaseList){
#        my $phaseList = $mRegress::errorListByCompilerPhase{$phase};
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
    if($no_html eq "") {
    if($firefox ne "") {
        my $file = "$resultsRootDir/$currentHdl" . "_regression_summary.html";
        print "url = $file\n";

        `firefox -remote "openurl($file)"`; 
    }
}

    #    &news();
    # print a random message for entertainment value
    my @array = ();
    my $index   = rand @array;
    my $element = $array[$index];
    print "\n\n$element\n\n\n";
    
    print "Exit msg: $exitMsg\n";
    print "Overall regression status = $status\n";
    print "REGRESSION DONE\n";
    if ($mRegress::STATUS_PASSED eq $status){ exit 0; }
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
    my $subject      = "compiler stage error report: ", $mRegress::test_start_time;
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
