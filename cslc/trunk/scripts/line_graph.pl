#!/usr/bin/perl -w
# Change above line to point to your perl binary

use CGI ':standard';
use GD::Graph::lines;
use strict;
use Class::Struct;
    struct( compilerPhaseResults => {
        name                => '$', # a chapter name or all results combined
        totalTests          => '$', 
        passTests           => '$', 
        failTests           => '$', 
        lexerPhasePass      => '$',
        treewalkPhasePass   => '$',
        cslomPhasePass      => '$',
        adaptorPhasePass    => '$',
        cdomPhasePass       => '$',
        cdomPhasePassPass   => '$',
        verilogCGPhasePass  => '$',
    });

    struct( chapterResult => [
                              chapterName => '$',      
                              compilerPhaseResults  => "%", #compilerPhaseResults key: regressName val:result
 ]);

my %chapterResults = ();

    my $int = compilerPhaseResults->new(  
     name                => "interconnect", 
     totalTests          => 800, 
     passTests           => 600, 
     lexerPhasePass      => 550,
     treewalkPhasePass   => 490,
     cslomPhasePass      => 470,
     adaptorPhasePass    => 440,
     cdomPhasePass       => 390,
     cdomPhasePassPass   => 360,
     verilogCGPhasePass  => 350,
     );

$chapterResults{$int->name} = $int;


    my $rf  = compilerPhaseResults->new(  
     name                => "rf", 
     totalTests          => 800, 
     passTests           => 600, 
     lexerPhasePass      => 550,
     treewalkPhasePass   => 490,
     cslomPhasePass      => 470,
     adaptorPhasePass    => 440,
     cdomPhasePass       => 390,
     cdomPhasePassPass   => 360,
     verilogCGPhasePass  => 350,
     );

$chapterResults{$rf->name} = $rf;


    my $reg = compilerPhaseResults->new(  
     name                => "register", 
     totalTests          => 800, 
     passTests           => 600, 
     lexerPhasePass      => 550,
     treewalkPhasePass   => 490,
     cslomPhasePass      => 470,
     adaptorPhasePass    => 440,
     cdomPhasePass       => 390,
     cdomPhasePassPass   => 360,
     verilogCGPhasePass  => 350,
     );

$chapterResults{$reg->name} = $reg;

    my $lang = compilerPhaseResults->new(  
     name                => "language", 
     totalTests          => 800, 
     passTests           => 600, 
     lexerPhasePass      => 550,
     treewalkPhasePass   => 490,
     cslomPhasePass      => 470,
     adaptorPhasePass    => 440,
     cdomPhasePass       => 390,
     cdomPhasePassPass   => 360,
     verilogCGPhasePass  => 350,
     );

$chapterResults{$lang->name} = $lang;

    my $fifo = compilerPhaseResults->new(  
     name                => "fifo", 
     totalTests          => 800, 
     passTests           => 600, 
     lexerPhasePass      => 550,
     treewalkPhasePass   => 490,
     cslomPhasePass      => 470,
     adaptorPhasePass    => 440,
     cdomPhasePass       => 390,
     cdomPhasePassPass   => 360,
     verilogCGPhasePass  => 350,
     );

$chapterResults{$fifo->name} = $fifo;

struct combinedResults => {
                              results  => '$', #compilerPhaseResults key: regressName val:result
 };

  my $results = combinedResults->new (
                                      results  => *chapterResults, #compilerPhaseResults key: regressName val:result
 );


# Both the arrays should same number of entries.
my @data = (['rev_1', 'rev_2', 'rev_3', 'rev_4' ], # map keys
            [80, 90, 85, 75],
            [76, 55, 75, 95],
            [66, 58, 92, 83]);

my $mygraph = GD::Graph::lines->new(800, 600);
$mygraph->set(
    x_label     => 'Regressions',
    y_label     => 'number of Tests',
    title       => 'Regression Results',
    # Draw datasets in 'solid' lines
    line_types  => [1, 1, 1],
    # Set the thickness of line
    line_width  => 2,
    # Set colors for datasets
    dclrs       => ['blue', 'green', 'red'],
# Show the grid
    long_ticks  => 1,
) or warn $mygraph->error;

$mygraph->set_legend_font(GD::gdMediumBoldFont,36);
$mygraph->set_legend('interconnect', 'register_file', 'fifo', 'language', '', '', '', '');
my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

open(IMG, "> lines.png") or die $1;
  binmode IMG;
  print IMG $myimage->png;
close(IMG);
