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
# for
my $n=1;
my $i ;
my $j;
my $i11;
my $j11;
my $count=0;
my $k; 
foreach ($i=1; $i<=4; $i++){
    foreach ($j=1; $j<=4; $j++){
        foreach ($k=1; $k<=4; $k++){
                        $count=$count+1;          
                        &main($count,$i, $j ,$i11, $j11,$k);
                    }
    }
}

sub main {     
  #  my $count = $_[0];  
    my $test_name = "assign_op".$count."_legal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    if($count==1){
        print (" Generated path: $path/assign_op_valid/\n");}
    my $val = int(rand(500)) + 1;
    my $val2 = int(rand(500)) + 1;
    my $val3 = int(rand(500)) + 1;
    if($val == 0) { $val = 1; }
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_op_valid");
        open(FH,">$path/assign_op_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/assign_op_invalid"); 
        open(FH,">$path/assign_op_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "//assign port_port \n\n";
    print FH "csl_bitrange br($val);\n";
    
    print FH "csl_unit top{ \n";
    print FH "csl_port p1(input,$val2);\n";
    print FH "csl_port p2(input,$val3); \n";
    print FH "csl_port p3(output, br); \n";
    print FH "csl_port p4(output, $val3+$val2); \n";
    print FH "csl_signal s4($val3+$val2); \n";
    print FH "csl_signal s2($val3); \n";
    print FH "csl_signal s1($val2); \n";
    print FH "csl_signal s3(br); \n";
    print FH "top() { \n";           

    print FH "      p$i=p$j+p$k ;  \n";
    print FH "      p$i=p$j&p$k ; \n";
    print FH "      p$i=~p$j; \n";
    print FH "      p$i=p$j | p$k; \n";
    print FH "      p$i=p$j^p$k; \n";
    print FH "      p$i=p$j^~p$k; \n";
    print FH "      p4=s4;\n";
    print FH "      p2=s2;\n";
    print FH "      p1=s1;\n";
    print FH "      p3=s3;\n";

    print FH " } \n";
    print FH "};";
   
         
    close(FH);
}
