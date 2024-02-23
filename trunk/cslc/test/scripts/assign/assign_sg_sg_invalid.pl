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
foreach ($i=1; $i<10; $i++){
    foreach ($j=1; $j<10; $j++){
        foreach ($k=1; $k<10; $k++){
                        $count=$count+1;          
                        &main($count,$i, $j ,$k);
                    }
    }
}

sub main {     
  #  my $count = $_[0];  
    my $test_name = "assign_sg_sg".$count."_illegal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
   if($count==1){
        print (" Generated path: $path/assign_sg_sg_invalid/\n");}
    my $val = int(rand(500));
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));

    if($val == 0) { $val = 1; } ;   
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_sg_sg_valid");
        open(FH,">$path/assign_sg_sg_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/assign_sg_sg_invalid"); 
        open(FH,">$path/assign_sg_sg_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "// Test cases from: assign_test_matrix.odg\n";
    print FH "//assign signal_group-signal_group \n\n";
    print FH "csl_bitrange br($val);\n";
#signal_group
    print FH "csl_signal_group sg { \n";
foreach ($x=1; $x<10; $x++)
{   
    $val=int(rand(300));
    if ($val==0) {$val=1};
    print FH "csl_signal s_sg$x($val); \n";
}
print FH "sg() {} \n";
print FH "}; \n";

#unit a
    print FH "csl_unit a{ \n";
 foreach ($x=1; $x<10; $x++)
{  
    print FH "sg sg_a$x;\n";
}
    print FH "a() { \n";
  # assign signal_group-signal_group from the same unit     
print FH "//           assign signal_group to signal_group from the same unit \n";
    print FH " sg_a$i=sg_a$j;  } \n";
    print FH "}; \n";
#unit b
    print FH "csl_unit b{ \n";
foreach ($x=1; $x<10; $x++)
{
    print FH "sg sg_b$x;\n";
}
    print FH "a a ; \n";
    print FH "b() { \n";
print FH "//           assign signal_group to signal_group from different units (parrent-child)\n";
 # assign signal_group-signal_group from  different units (parrent-child)        
    print FH "  sg_b$j=a.sg_a$k;\n";
    print FH "} \n";
    print FH "}; \n";

#unit c
    print FH "csl_unit c{ \n";
foreach ($x=1;$x<10; $x++)
{       
    print FH "sg sg_c$x;\n";
}
    print FH "c() { \n";
 # assign assign signal-signal from   different units (parrent-parrent)        
print FH "//           assign signal to signal from different units (parrent-parrent)\n";
    print FH "  sg_c$i=sg_b$i;\n";
    print FH "} \n";
    print FH "}; \n";
        
        
#unit top
    print FH "csl_unit top{ \n";
foreach ($x=1; $x<10; $x++)
{   
    print FH "sg sg$x;\n";
}    
    print FH "b b ; \n";
    print FH "c c ; \n";
    print FH "top() { \n";           
  # assign signal-signal different units :                                    
print FH "//           assign signal to signal from different units \n";\
    print FH "      sg$i=b.sg_b$j;\n";     #parrent-child                                   
    print FH "      sg$j=b.a.sg_a$k; \n";  #parrent-child/child
    print FH "      sg$k=sg$j; \n";

    print FH "} \n";
    print FH "}; \n";
         
    close(FH);
}
