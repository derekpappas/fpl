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
foreach ($i=1; $i<=10; $i++){
    foreach ($j=1; $j<=10; $j++){
        $count=$count+1;          
        &main($count,$i, $j);
    }
}

sub main {     
    my ($count,$i,$j) = @_;
    my $test_name = "f2a_port_port".$count."_legal.csl";
    &createCslFile($test_name, $count,$i,$j);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my $val = int(rand(500));
    my($test_name, $count,$i,$j) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    if($count==1){
        print ("Generated path: $path/f2a_port_port_valid/ \n");}
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));
    if($val == 0) { $val = 1; };
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
    
    &mkDir("$path/f2a_port_port_valid");
    open(FH,">$path/f2a_port_port_valid/$test_name");
   

    print FH "//costelc \n";
    print FH "//Test cases from: Interconnect_F2A_matrix.ods \n";
    print FH "//f2a_port_port \n\n";  
 
    print FH "csl_unit a{ \n";

    foreach ($x=1; $x<=5; $x++){
        print FH "csl_port p_a$x(input, $val);\n";
    }
    foreach ($x=6; $x<=10; $x++) {
        print FH "csl_port p_a$x(output, $val);\n";
    }
    print FH "a() {} \n";
    print FH "}; \n";

#unit b
    print FH "csl_unit b{ \n";
   
    foreach ($x=1; $x<=5; $x++){
        print FH "csl_port p_b$x(input, $val);\n";
    }
    foreach ($x=6; $x<=10; $x++){       
        print FH "csl_port p_b$x(output, $val);\n";
    }   
    if ($i<=10 ){    
        print FH " //    f2a parrent  input -input \n";    
        print FH "a a0( ";
foreach ($x=1; $x<=10; $x++){
    if($x<10){
        print FH " .p_a$x(p_b$x),\n" ;
    }
    else{
        print FH " .p_a$x(p_b$x));\n" ;
    }
    }
   
    }

  
    print FH "b() {} \n";
    print FH "}; \n";


#unit c
    print FH "csl_unit c{ \n";
    foreach ($x=1; $x<=5; $x++)
{
    print FH "csl_port p_c$x(input, $val);\n";
}
   foreach ($x=6; $x<=10; $x++)
{
    print FH "csl_port p_c$x(output, $val);\n";
}  
    print FH "b b0(";
foreach ($x=1; $x<=10; $x++){
    if($x<10){
        print FH " .p_b$x(p_c$x),\n" ;
    }
   else
  {
   print FH " .p_b$x(p_c$x));\n" ;
  } 
}
    print FH "c() {} \n";
    print FH "}; \n";

#unit top
    print FH "csl_unit top{ \n";
    foreach ($x=1; $x<=5; $x++)
{
    print FH "csl_port p$x(input, $val);\n";
}
    foreach ($x=6; $x<=10; $x++)
{
    print FH "csl_port p$x(output, $val);\n";
}   
    if ($i<=10)
{
    print FH "c c0( ";
 foreach ($x=1; $x<=10; $x++)
{  
    if($x<10){
  print FH " .p_c$x(p$x),";
}
   else
{
 print FH " .p_c$x(p$x));\n";
}
}
}

    print FH "top() {} \n";               
    print FH "}; ";
    
         
    close(FH);
}
