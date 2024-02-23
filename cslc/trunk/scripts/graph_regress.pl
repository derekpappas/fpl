#!/usr/bin/perl -w
# Change above line to point to your perl binary

# useful links to understand the code in this program
# http://www.wdvl.com/Authoring/Languages/Perl/Weave/chart1-4.html
# http://linuxgazette.net/issue83/padala.html
# http://search.cpan.org/~mverb/GDGraph-1.43/Graph.pm
# http://perldoc.perl.org/perlreftut.html -> see Make Rule 2
# http://www.jonblog.uklinux.net/www/presentation/img5.html

use CGI ':standard';
use GD::Graph::lines;
use GD::Graph::mixed;
use GD::Text;
use strict;
use Class::Struct;


if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/cslc";
}  
my $totDir             = $ENV{WORK};
my $testRootDir        = "$totDir/test";
my $reportRootDir      = "$testRootDir/report";

&testDirExists($totDir            );
&testDirExists($testRootDir       );
&testDirExists($reportRootDir     );


struct( regressSummary => {
    date                      => '$', 
    name                      => '$', 
    total_valid_num_tests_passed=> '$', 
    total_valid_num_tests       => '$', 
    total_valid_percent_passed  => '$', 
});

my %regressionList = ();
my @regressionList = {};

my @percentageList = ();

&main();


sub main {

    my @regressionType = ("dist_regress_results", "results");
    my @hdlList = ( "csl", "csl_v2", "csl_new_bug", "csl_test_gen", "csl_design_gen", "csl_cc_gen", "verilog");


    foreach my $rt (@regressionType) {
        foreach my $hdl (@hdlList){
            %regressionList = ();
            @regressionList = {};
            @percentageList = ();
            &run($rt, $hdl);
        }
    }
    &createHtmlIndexFile(\@regressionType);
}



sub run {
    my ($rt, $hdlDir) = @_;
    my @dirList = &getRegressDirs($rt);

    print "hdlDir = $hdlDir dirList = \n";
    foreach my $d (@dirList) {
        print "dirList[$d] = $dirList[$d] \n";
    }       


    my $dirDate = "";
    foreach my $dir (@dirList) {
       # print "for dir = $dir\n";
       my $summaryFile = "$dir/$hdlDir" . "_regression_summary.html";
       $dirDate = "";         
       $dir =~ m/results_(\d+.\d+.\d+_\d+_\d+_\d+)/;
       $dirDate = $1;
       if (-e $summaryFile) {
           open(SUM_FH, "$summaryFile");
           my @lines = <SUM_FH>;	
           chop @lines;
           close(SUM_FH);
           my @totalValidInvalidPassCount   = grep(/total_invval/, @lines);
           my @totalValidPassCount          = grep(/total_valid/, @lines);
           my @totalValidPassCountByStage   = grep(/pnvalpc/  , @lines);
           my @totalInvalidPassCount        = grep(/total_invalid/, @lines);
           my @totalInvalidPassCountByStage = grep(/pninvpc/  , @lines);
           my @svnLine                      = grep(/SVN Revision/ , @lines);
           my $svnRevision = "";

           foreach my $svnLine (@svnLine){
               #print "svnLine = $svnLine\n";
               if ($svnLine =~ m/SVN\s+Revision[^\d]+(\d+)/) {
                   $svnRevision = $1;
               }
               else {
                   $svnRevision = "NOT_FOUND";
               }
               # print "svnRevision = $svnRevision\n";
           }

           my $total_invval_major_error_cnt  = 0;
           my $total_invval_num_tests_passed = 0;
           my $total_invval_num_tests        = 0;

           my $total_valid_num_tests_passed  = 0;
           my $total_valid_num_tests         = 0;

           my $total_invalid_num_tests_passed = 0;
           my $total_invalid_num_tests        = 0;

           my $pnvalpc_lexer          = 0;
           my $pnvalpc_parser         = 0;
           my $pnvalpc_walker        = 0;
           my $pnvalpc_autorouter     = 0;
           my $pnvalpc_automapper     = 0;
           my $pnvalpc_cslom_checker  = 0;
           my $pnvalpc_instance_tree  = 0;
           my $pnvalpc_adapter        = 0;
           my $pnvalpc_cdom_checker   = 0;
           my $pnvalpc_verilogcodegen = 0;
           my $pnvalpc_cppcodegen     = 0;
           my $pnvalpc_csimcodegen    = 0;
           my $pnvalpc_sysCodeGen     = 0;

           my $pninvpc_lexer          = 0;
           my $pninvpc_parser         = 0;
           my $pninvpc_walker        = 0;
           my $pninvpc_autorouter     = 0;
           my $pninvpc_automapper     = 0;
           my $pninvpc_cslom_checker  = 0;
           my $pninvpc_instance_tree  = 0;
           my $pninvpc_adapter        = 0;
           my $pninvpc_cdom_checker   = 0;
           my $pninvpc_verilogcodegen = 0;
           my $pninvpc_cppcodegen     = 0;
           my $pninvpc_csimcodegen    = 0;
           my $pninvpc_sysCodeGen     = 0;

           foreach my $l (@totalValidInvalidPassCount) {
               if ($l =~ m/total_invval=\"total_invval_num_tests_passed\"\s*>\s*(\d+)/) { 
                   #print "match total_invval_num_tests_passed = $1\n";
                   $total_invval_num_tests_passed = $1;
               }                                      
               elsif ($l =~ m/total_invval=\"total_invval_num_tests\"\s*>\s*(\d+)/) { 
                   #print "match total_invval_num_tests = $1\n";
                   $total_invval_num_tests = $1;
               }
               elsif ($l =~ m/total_invval=\"total_invval_major_error_cnt\"\s*>\s*(\d+)/) { 
                   #print "match total_invval_major_error_cnt = $1\n";
                   $total_invval_major_error_cnt = $1;
               }
           }

           foreach my $l (@totalValidPassCount) {
               if ($l =~ m/pnvalpc=\"total_valid_num_tests_passed\"\s*>\s*(\d+)/) { 
                   # print "match total_valid_num_tests_passed = $1\n";
                   $total_valid_num_tests_passed = $1;
               }                                      
               elsif ($l =~ m/pnvalpc=\"total_valid_num_tests\"\s*>\s*(\d+)/) { 
                   # print "match total_valid_num_tests = $1\n";
                   $total_valid_num_tests = $1;
               }
           }

           foreach my $l (@totalValidPassCountByStage) {
               # print "totalValidPassCountByStage = $l\n";
               if ($l =~ m/pnvalpc=\"lexer\"\s*>\s*(\d+)/) {         
                   $pnvalpc_lexer = $1;
               }
               elsif ($l =~ m/pnvalpc=\"parser\"\s*>\s*(\d+)/) {        
                   $pnvalpc_parser    = $1;
               }
               elsif ($l =~ m/pnvalpc=\"walker\"\s*>\s*(\d+)/) {       
                   $pnvalpc_walker = $1;
               }
               elsif ($l =~ m/pnvalpc=\"autorouter\"\s*>\s*(\d+)/) {    
                   $pnvalpc_autorouter    = $1;
               }
               elsif ($l =~ m/pnvalpc=\"automapper\"\s*>\s*(\d+)/) {    
                   $pnvalpc_automapper = $1;
               }
               elsif ($l =~ m/pnvalpc=\"cslom_checker\"\s*>\s*(\d+)/) { 
                   $pnvalpc_cslom_checker    = $1;
               }   
               elsif ($l =~ m/pnvalpc=\"instance_tree\"\s*>\s*(\d+)/) { 
                   $pnvalpc_instance_tree = $1;
               }
               elsif ($l =~ m/pnvalpc=\"adapter\"\s*>\s*(\d+)/) {       
                   $pnvalpc_adapter    = $1;
               }
               elsif ($l =~ m/pnvalpc=\"cdom_checker\"\s*>\s*(\d+)/) {  
                   $pnvalpc_cdom_checker = $1;
               }
               elsif ($l =~ m/pnvalpc=\"verilogcodegen\"\s*>\s*(\d+)/) {
                   $pnvalpc_verilogcodegen    = $1;
               }
               elsif ($l =~ m/pnvalpc=\"cppcodegen\"\s*>\s*(\d+)/) {    
                   $pnvalpc_cppcodegen = $1;
               }
               elsif ($l =~ m/pnvalpc=\"csimcodegen\"\s*>\s*(\d+)/) {   
                   $pnvalpc_csimcodegen    = $1;
               }
               elsif ($l =~ m/pnvalpc=\"sysCodeGen\"\s*>\s*(\d+)/) {    
                   $pnvalpc_sysCodeGen = $1;
               }
           }

           foreach my $l (@totalInvalidPassCount) {
               # print "totalInvalidPassCount = $l\n";
               if ($l =~ m/pninvpc=\"total_invalid_num_tests_passed\"\s*>\s*(\d+)/) { 
                   # print "match total_invalid_num_tests_passed = $1\n";
                   $total_invalid_num_tests_passed = $1;
               }                                      
               elsif ($l =~ m/pninvpc=\"total_invalid_num_tests\"\s*>\s*(\d+)/) { 
                   # print "match total_invalid_num_tests = $1\n";
                   $total_invalid_num_tests = $1;
               }
           }

           foreach my $l (@totalInvalidPassCountByStage) {
#               # print "totalInvalidPassCountByStage = $l\n";
               if ($l =~ m/pninvpc=\"lexer\"\s*>\s*(\d+)/) {         
                   $pninvpc_lexer = $1;
               }
               elsif ($l =~ m/pninvpc=\"parser\"\s*>\s*(\d+)/) {        
                   $pninvpc_parser    = $1;
               }
               elsif ($l =~ m/pninvpc=\"walker\"\s*>\s*(\d+)/) {       
                   $pninvpc_walker = $1;
               }
               elsif ($l =~ m/pninvpc=\"autorouter\"\s*>\s*(\d+)/) {    
                   $pninvpc_autorouter    = $1;
               }
               elsif ($l =~ m/pninvpc=\"automapper\"\s*>\s*(\d+)/) {    
                   $pninvpc_automapper = $1;
               }
               elsif ($l =~ m/pninvpc=\"cslom_checker\"\s*>\s*(\d+)/) { 
                   $pninvpc_cslom_checker    = $1;
               }   
               elsif ($l =~ m/pninvpc=\"instance_tree\"\s*>\s*(\d+)/) { 
                   $pninvpc_instance_tree = $1;
               }
               elsif ($l =~ m/pninvpc=\"adapter\"\s*>\s*(\d+)/) {       
                   $pninvpc_adapter    = $1;
               }
               elsif ($l =~ m/pninvpc=\"cdom_checker\"\s*>\s*(\d+)/) {  
                   $pninvpc_cdom_checker = $1;
               }
               elsif ($l =~ m/pninvpc=\"verilogcodegen\"\s*>\s*(\d+)/) {
                   $pninvpc_verilogcodegen    = $1;
               }
               elsif ($l =~ m/pninvpc=\"cppcodegen\"\s*>\s*(\d+)/) {    
                   $pninvpc_cppcodegen = $1;
               }
               elsif ($l =~ m/pninvpc=\"csimcodegen\"\s*>\s*(\d+)/) {   
                   $pninvpc_csimcodegen    = $1;
               }
               elsif ($l =~ m/pninvpc=\"sysCodeGen\"\s*>\s*(\d+)/) {    
                   $pninvpc_sysCodeGen = $1;
               }
           }

           my %record = (name                           => $dir                           , 
                         date                           => $dirDate                       , 
                         svnRevision                    => $svnRevision                   ,
                         total_invval_major_error_cnt   => $total_invval_major_error_cnt  ,
                         total_invval_num_tests         => $total_invval_num_tests        ,
                         total_invval_num_tests_passed  => $total_invval_num_tests_passed ,
                         total_valid_num_tests_passed   => $total_valid_num_tests_passed  , 
                         total_valid_num_tests          => $total_valid_num_tests         , 
                         total_invalid_num_tests_passed => $total_invalid_num_tests_passed, 
                         total_invalid_num_tests        => $total_invalid_num_tests       , 

                         pnvalpc_lexer          => $pnvalpc_lexer         ,
                         pnvalpc_parser         => $pnvalpc_parser        ,
                         pnvalpc_walker         => $pnvalpc_walker        ,
                         pnvalpc_autorouter     => $pnvalpc_autorouter    ,
                         pnvalpc_automapper     => $pnvalpc_automapper    ,
                         pnvalpc_cslom_checker  => $pnvalpc_cslom_checker ,
                         pnvalpc_instance_tree  => $pnvalpc_instance_tree ,
                         pnvalpc_adapter        => $pnvalpc_adapter       ,
                         pnvalpc_cdom_checker   => $pnvalpc_cdom_checker  ,
                         pnvalpc_verilogcodegen => $pnvalpc_verilogcodegen,
                         pnvalpc_cppcodegen     => $pnvalpc_cppcodegen    ,
                         pnvalpc_csimcodegen    => $pnvalpc_csimcodegen   ,
                         pnvalpc_sysCodeGen     => $pnvalpc_sysCodeGen    ,

                         pninvpc_lexer          => $pninvpc_lexer         ,
                         pninvpc_parser         => $pninvpc_parser        ,
                         pninvpc_walker        => $pninvpc_walker       ,
                         pninvpc_autorouter     => $pninvpc_autorouter    ,
                         pninvpc_automapper     => $pninvpc_automapper    ,
                         pninvpc_cslom_checker  => $pninvpc_cslom_checker ,
                         pninvpc_instance_tree  => $pninvpc_instance_tree ,
                         pninvpc_adapter        => $pninvpc_adapter       ,
                         pninvpc_cdom_checker   => $pninvpc_cdom_checker  ,
                         pninvpc_verilogcodegen => $pninvpc_verilogcodegen,
                         pninvpc_cppcodegen     => $pninvpc_cppcodegen    ,
                         pninvpc_csimcodegen    => $pninvpc_csimcodegen   ,
                         pninvpc_sysCodeGen     => $pninvpc_sysCodeGen    ,
                         );

#           print "record = ", %record ,"\n";

           $regressionList{$record{name}} = \%record;
           push(@regressionList, $record{name});

##Total Percentage Passed          :&nbsp;    88%
#
#           $regressionList{$record{name}} = \%record;
#           push(@percentageList, $record{name});
       }
   }
   &makeDataStructures($rt, \%regressionList, $hdlDir);

}

sub getRegressDirs {
    my ($rt) = @_;
    my $dir;
    opendir($dir, "$reportRootDir") || die("Could not find directory\n");;
    my @resultsDirArray = grep { /($rt)/ } readdir($dir);
    closedir($dir);

    my @dirList;
    foreach my $dir (sort (@resultsDirArray)) {
        $dir =~ s/(.)/$reportRootDir\/$1/; #	prepend a # to the string
        #print "dir = $dir\n";
        push(@dirList, $dir);
    }

    return @dirList;
}

sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
}

# Each anonymous array should same number of entries.
#my @data = (['rev_1', 'rev_2', 'rev_3', 'rev_4' ], # map keys
#            [80, 90, 85, 75],
#             [76, 55, 75, 95],
#            [66, 58, 92, 83]);


# an anonymous array is created using square braces
# @a = [0,1,2];
# this is the same as
# @a = (0,1,2);
# $a = \@a; # \@a is a reference to the array @a

sub makeDataStructures {
    my ($rt, $regressionList, $hdlDir) = @_;
    my @revs                          ;
    my @svnRevision                      ;
    my @total_invval_major_error_cnt  ;
    my @total_invval_num_tests        ;
    my @total_invval_num_tests_passed ;
    my @total_valid_num_tests_passed  ;
    my @total_valid_num_tests         ;
    my @total_invalid_num_tests_passed;
    my @total_invalid_num_tests       ;
    my @pnvalpc_lexer         ;
    my @pnvalpc_parser        ;
    my @pnvalpc_walker       ;
    my @pnvalpc_autorouter    ;
    my @pnvalpc_automapper    ;
    my @pnvalpc_cslom_checker ;
    my @pnvalpc_instance_tree ;
    my @pnvalpc_adapter       ;
    my @pnvalpc_cdom_checker  ;
    my @pnvalpc_verilogcodegen;
    my @pnvalpc_cppcodegen    ;
    my @pnvalpc_csimcodegen   ;
    my @pnvalpc_sysCodeGen    ;
    my @pninvpc_lexer         ;
    my @pninvpc_parser        ;
    my @pninvpc_walker       ;
    my @pninvpc_autorouter    ;
    my @pninvpc_automapper    ;
    my @pninvpc_cslom_checker ;
    my @pninvpc_instance_tree ;
    my @pninvpc_adapter       ;
    my @pninvpc_cdom_checker  ;
    my @pninvpc_verilogcodegen;
    my @pninvpc_cppcodegen    ;
    my @pninvpc_csimcodegen   ;
    my @pninvpc_sysCodeGen    ;

    my $cnt = 0;
    foreach my $name ( @regressionList ) {
        my $rev = sprintf( "rev_%d", $cnt);
        $cnt++;
        push(@revs                          , $rev                                                 );
        push(@svnRevision                   , $regressionList{$name}{svnRevision                   });
        push(@total_invval_major_error_cnt  , $regressionList{$name}{total_invval_major_error_cnt  });
        push(@total_invval_num_tests        , $regressionList{$name}{total_invval_num_tests        });
        push(@total_invval_num_tests_passed , $regressionList{$name}{total_invval_num_tests_passed });
        push(@total_valid_num_tests_passed  , $regressionList{$name}{total_valid_num_tests_passed  });
        push(@total_valid_num_tests         , $regressionList{$name}{total_valid_num_tests         });
        push(@total_invalid_num_tests_passed, $regressionList{$name}{total_invalid_num_tests_passed});
        push(@total_invalid_num_tests       , $regressionList{$name}{total_invalid_num_tests       });
        push(@pnvalpc_lexer             , $regressionList{$name}{pnvalpc_lexer             });
        push(@pnvalpc_parser            , $regressionList{$name}{pnvalpc_parser            });
        push(@pnvalpc_walker            , $regressionList{$name}{pnvalpc_walker            });
        push(@pnvalpc_autorouter        , $regressionList{$name}{pnvalpc_autorouter        });
        push(@pnvalpc_automapper        , $regressionList{$name}{pnvalpc_automapper        });
        push(@pnvalpc_cslom_checker     , $regressionList{$name}{pnvalpc_cslom_checker     });
        push(@pnvalpc_instance_tree     , $regressionList{$name}{pnvalpc_instance_tree     });
        push(@pnvalpc_adapter           , $regressionList{$name}{pnvalpc_adapter           });
        push(@pnvalpc_cdom_checker      , $regressionList{$name}{pnvalpc_cdom_checker      });
        push(@pnvalpc_verilogcodegen    , $regressionList{$name}{pnvalpc_verilogcodegen    });
        push(@pnvalpc_cppcodegen        , $regressionList{$name}{pnvalpc_cppcodegen        });
        push(@pnvalpc_csimcodegen       , $regressionList{$name}{pnvalpc_csimcodegen       });
        push(@pnvalpc_sysCodeGen        , $regressionList{$name}{pnvalpc_sysCodeGen        });
        push(@pninvpc_lexer             , $regressionList{$name}{pninvpc_lexer             });
        push(@pninvpc_parser            , $regressionList{$name}{pninvpc_parser            });
        push(@pninvpc_walker            , $regressionList{$name}{pninvpc_walker            });
        push(@pninvpc_autorouter        , $regressionList{$name}{pninvpc_autorouter        });
        push(@pninvpc_automapper        , $regressionList{$name}{pninvpc_automapper        });
        push(@pninvpc_cslom_checker     , $regressionList{$name}{pninvpc_cslom_checker     });
        push(@pninvpc_instance_tree     , $regressionList{$name}{pninvpc_instance_tree     });
        push(@pninvpc_adapter           , $regressionList{$name}{pninvpc_adapter           });
        push(@pninvpc_cdom_checker      , $regressionList{$name}{pninvpc_cdom_checker      });
        push(@pninvpc_verilogcodegen    , $regressionList{$name}{pninvpc_verilogcodegen    });
        push(@pninvpc_cppcodegen        , $regressionList{$name}{pninvpc_cppcodegen        });
        push(@pninvpc_csimcodegen       , $regressionList{$name}{pninvpc_csimcodegen       });
        push(@pninvpc_sysCodeGen        , $regressionList{$name}{pninvpc_sysCodeGen        });

    }

    #print "total_invval_num_tests = @total_invval_num_tests\n";


    &drawTotalGraph(\@revs                          ,
                    \@svnRevision                      ,
                    \@total_invval_major_error_cnt  , 
                    \@total_invval_num_tests        , 
                    \@total_invval_num_tests_passed ,
                    \@total_valid_num_tests_passed  ,
                    \@total_valid_num_tests         ,
                    \@total_invalid_num_tests_passed,
                    \@total_invalid_num_tests       ,
                    $rt                             , 
                    $hdlDir                         
                    );
    my $invPngFileName = "$reportRootDir/" . $rt . "_" . $hdlDir . "_fplRegressInvalidTestSummary.png";
    &drawTotalInvalidValidGraph($invPngFileName             ,
                                \@revs                      ,
                                \@pninvpc_lexer             ,
                                \@pninvpc_parser            ,
                                \@pninvpc_walker            ,
                                \@pninvpc_autorouter        ,
                                \@pninvpc_automapper        ,
                                \@pninvpc_cslom_checker     ,
                                \@pninvpc_instance_tree     ,
                                \@pninvpc_adapter           ,
                                \@pninvpc_cdom_checker      ,
                                \@pninvpc_verilogcodegen    ,
                                \@pninvpc_cppcodegen        ,
                                \@pninvpc_csimcodegen       ,
                                \@pninvpc_sysCodeGen        
                                );
    my $valPngFileName = "$reportRootDir/" . $rt . "_" . $hdlDir . "_fplRegressValidTestSummary.png";

    &drawTotalInvalidValidGraph($valPngFileName             ,
                                \@revs                      ,
                                \@pnvalpc_lexer             ,
                                \@pnvalpc_parser            ,
                                \@pnvalpc_walker           ,
                                \@pnvalpc_autorouter        ,
                                \@pnvalpc_automapper        ,
                                \@pnvalpc_cslom_checker     ,
                                \@pnvalpc_instance_tree     ,
                                \@pnvalpc_adapter           ,
                                \@pnvalpc_cdom_checker      ,
                                \@pnvalpc_verilogcodegen    ,
                                \@pnvalpc_cppcodegen        ,
                                \@pnvalpc_csimcodegen       ,
                                \@pnvalpc_sysCodeGen        
                                );


}

# the $total* are references to arrays
sub drawTotalGraph {
    my ($revs                          ,
        $svnRevision                      ,
        $total_invval_major_error_cnt  ,
        $total_invval_num_tests        ,
        $total_invval_num_tests_passed ,
        $total_valid_num_tests_passed  ,
        $total_valid_num_tests         ,
        $total_invalid_num_tests_passed,
        $total_invalid_num_tests       ,
        $rt                             , 
        $hdlDir                                
        ) = @_;

    my @data = ($svnRevision                      ,
                $total_invval_major_error_cnt  ,
                $total_invval_num_tests        ,
                $total_invval_num_tests_passed ,
                $total_valid_num_tests_passed  ,
                $total_valid_num_tests         ,
                $total_invalid_num_tests_passed,
                $total_invalid_num_tests       
                );

    #print "data = ", @data , "\n";

#    my $mygraph = GD::Graph::lines->new(800, 600);
    my $mygraph = GD::Graph::mixed->new(1600, 1200);
    $mygraph->set(
                  x_label     => 'SVN Revisions',
                  y_label     => 'Number of Tests',
                  title       => 'My Regression Results',
                  line_types  => [ 1, 1, 1, 1],     # Draw datasets in 'solid' lines
                  line_width  => 4,             # Set the thickness of line
                  dclrs       => ['blue', 'green', 'red', 'yellow', 'orange', 'blue', 'magenta'], # Set colors for datasets
# Show the grid
                  long_ticks  => 1,
                  show_values => 1,
                  y_max_value => 1300,
                  bar_width   => 3,


                  ) or warn $mygraph->error;

#    $mygraph->set_legend_font(GD::gdMediumBoldFont,18);
    $mygraph->set_legend_font('arial', 30);

    $mygraph->set_legend('svnRevision', 
                         'total_invval_major_error_cnt', 
                         'total_invval_num_tests', 
                         'total_invval_num_tests_passed', 
                         'total_valid_num_tests_passed',
                         'total_valid_num_tests',
                         'total_invalid_num_tests_passed',
                         'total_invalid_num_tests');

    my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

    my $summaryPngFileName = "$reportRootDir/" . $rt . "_" . $hdlDir . "_fplRegressionSummaryGraph.png";

    open(IMG, "> $summaryPngFileName") or die $1;
    binmode IMG;
    print IMG $myimage->png;
    close(IMG);
}

sub drawTotalInvalidValidGraph {
    my ($filename              ,
        $revs                  ,        
        $pninvpc_lexer         ,        
        $pninvpc_parser        ,
        $pninvpc_walker       ,
        $pninvpc_autorouter    ,
        $pninvpc_automapper    ,
        $pninvpc_cslom_checker ,
        $pninvpc_instance_tree ,
        $pninvpc_adapter       ,
        $pninvpc_cdom_checker  ,
        $pninvpc_verilogcodegen,
        $pninvpc_cppcodegen    ,
        $pninvpc_csimcodegen   ,
        $pninvpc_sysCodeGen    ) = @_;

    my @data = ($revs                  ,        
                $pninvpc_lexer         ,        
                $pninvpc_parser        ,
                $pninvpc_walker       ,
                $pninvpc_autorouter    ,
                $pninvpc_automapper    ,
                $pninvpc_cslom_checker ,
                $pninvpc_instance_tree ,
                $pninvpc_adapter       ,
                $pninvpc_cdom_checker  ,
                $pninvpc_verilogcodegen,
                $pninvpc_cppcodegen    ,
                $pninvpc_csimcodegen   ,
                $pninvpc_sysCodeGen    );

    #print "data = ", @data , "\n";

    my $mygraph = GD::Graph::lines->new(1600, 1200);
    $mygraph->set(
                  x_label     => 'Regressions',
                  y_label     => 'number of Tests',
                  title       => 'My Regression Results',
                  line_types  => [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],     # Draw datasets in 'solid' lines
                  line_width  => 4,             # Set the thickness of line
                  dclrs       => ['blue', 'green', 'red', 'yellow', 'orange', 'blue'], # Set colors for datasets
# Show the grid
                  long_ticks  => 1,
                  show_values => 1,
                  y_max_value => 1300,
                  ) or warn $mygraph->error;

#    $mygraph->set_legend_font(GD::gdMediumBoldFont,18);
    $mygraph->set_legend_font(GD::gdMediumBoldFont,24);
#    $mygraph->set_legend_font('arial', 30);
    $mygraph->set_legend(
                         'revs                  ',
                         'pninvpc_lexer         ',
                         'pninvpc_parser        ',
                         'pninvpc_walker       ',
                         'pninvpc_autorouter    ',
                         'pninvpc_automapper    ',
                         'pninvpc_cslom_checker ',
                         'pninvpc_instance_tree ',
                         'pninvpc_adapter       ',
                         'pninvpc_cdom_checker  ',
                         'pninvpc_verilogcodegen',
                         'pninvpc_cppcodegen    ',
                         'pninvpc_csimcodegen   ',
                         'pninvpc_sysCodeGen    ');

    my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

    open(IMG, "> $filename") or die $1;
    binmode IMG;
    print IMG $myimage->png;
    close(IMG);
}


sub createHtmlIndexFile {
    my ($regressionType) = @_;

    my @regressionType = @{$regressionType};
    my $filename = "$reportRootDir/png_index.html";
    open(INDEX, "> $filename") or die $1;

    my $h_size = 500;
    my $v_size = 200;

    print INDEX "<html>
<body>
<table>
";


    my @hdlList = ( "csl", "csl_v2", "csl_new_bug", "csl_test_gen", "csl_design_gen", "csl_cc_gen", "verilog");

    foreach my $rt (@regressionType) {
        foreach my $hdl (@hdlList){

            my $pngPrefix = $rt . "_" . $hdl;

            my $summaryPngFileName = $pngPrefix . "_fplRegressValidTestSummary.png";
            print INDEX "
<tr>
<td>
<A href=\"$summaryPngFileName\"> <img src=\"$summaryPngFileName\" width=\"$h_size\" height=\"$v_size\"> <br> $summaryPngFileName </A>
</td>
";

            my $invalidSummaryPngFileName = $pngPrefix . "_fplRegressInvalidTestSummary.png";
            print INDEX "
<td>
<A href=\"$invalidSummaryPngFileName\"> <img src=\"$invalidSummaryPngFileName\" width=\"$h_size\" height=\"$v_size\"> <br> $invalidSummaryPngFileName</A>
</td>
";

            my $validSummaryPngFileName = $pngPrefix . "_fplRegressionSummaryGraph.png";
            print INDEX "
<td>
<A href=\"$validSummaryPngFileName\"> <img src=\"$validSummaryPngFileName\" width=\"$h_size\" height=\"$v_size\"> <br> $validSummaryPngFileName</A>
</td>
</tr>
";

        }
    }

    print INDEX "
</table>
</body>
</html>
";


}
