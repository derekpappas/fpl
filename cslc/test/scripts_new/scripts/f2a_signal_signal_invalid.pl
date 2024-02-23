#!/usr/bin/perl

#Author costelc
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

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

print "Generated tests path : f2a_signal_signal_invalid/\n";

# for
my $n=1;
my $i ;
my $j;
my $i11;
my $j11;
my $count=0;
my $k; 
foreach ($i=1; $i<=10; $i++){
    foreach ($j=1; $j<=10; $j++){
        $count=$count+1;          
                        &main($count,$i, $j ,$i11, $j11,$k);
                    }
}

sub main {     
  #  my $count = $_[0];  
    my $test_name = "f2a_signal_signal".$count."_illegal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my $val = int(rand(500));
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));
    if($val == 0) { $val = 1; };
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
    if($test_name=~/(_legal)/){
        &mkDir("$path/f2a_signal_signal_valid");
        open(FH,">$path/f2a_signal_signal_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/f2a_signal_signal_invalid"); 
        open(FH,">$path/f2a_signal_signal_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "//f2a_signal_signal \n\n";
 #unit a   
    print FH "csl_unit a{ \n";
    foreach ($x=1; $x<=10; $x++)
{  
    print FH "csl_signal s_a$x($val);\n";
}
    print FH "a() {} \n";
    print FH "}; \n";

#unit b
    print FH "csl_unit b{ \n";
    foreach ($x=1; $x<=10; $x++)
{
    print FH "csl_signal s_b$x($val);\n";
}    
    print FH " //    f2a  \n";    
    print FH "a a(.s_a$i(s_b$j)) ; \n";
    print FH "b() {} \n";
    print FH "}; \n";


#unit c
    print FH "csl_unit c{ \n";
    foreach ($x=1; $x<=10; $x++)
{
    print FH "csl_signal s_c$x($val);\n";
}
    print FH "c() {} \n";
    print FH "}; \n";
#unit top
    print FH "csl_unit top{ \n";
    foreach ($x=1; $x<=10; $x++)
{
    print FH "csl_signal s$x($val);\n";
}
    print FH "// f2a \n";    
    print FH "b b(.s_b$i(s$j),.a.s_a$i(s$j)) ; //parrent-child && parent-child/child \n";
    print FH "c c(.s_c$i(s$j));\n";
    print FH "top() {} \n";               
    print FH "}; ";
    
         
    close(FH);
}
