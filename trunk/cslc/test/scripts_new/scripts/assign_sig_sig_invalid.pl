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
    my $test_name = "assign_sig_sig".$count."_illegal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
   if($count==1){
        print (" Generated path: $path/assign_sig_sig_invalid/\n");}
    my $val = int(rand(500));
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));

    if($val == 0) { $val = 1; } ;   
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_sig_sig_valid");
        open(FH,">$path/assign_sig_sig_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/assign_sig_sig_invalid"); 
        open(FH,">$path/assign_sig_sig_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "//assign signal-signal \n\n";
    print FH "csl_bitrange br($val);\n";
#unit a    
    print FH "csl_unit a{ \n";
 foreach ($x=1; $x<10; $x++)
{  
    $val=int(rand(500));
    if ($val==0) {$val=1};
    print FH "csl_signal s_a$x($val);\n";
}
    print FH "a() { \n";
  # assign signal-signal from the same unit     
print FH "//           assign signal to signal from the same unit \n";
    print FH " s_a$i=s_a$j;  } \n";
    print FH "}; \n";
#unit b
    print FH "csl_unit b{ \n";
foreach ($x=1; $x<10; $x++)
{
    $val=int(rand(400));
    if ($val==0) {$val=1};
    print FH "csl_signal s_b$x($val);\n";
}
    print FH "a a ; \n";
    print FH "b() { \n";
print FH "//           assign signal to signal from different units (parrent-child)\n";
 # assign signal-signal from  different units (parrent-child)        
    print FH "  s_b$j=a.s_a$k;\n";
    print FH "} \n";
    print FH "}; \n";

#unit c
    print FH "csl_unit c{ \n";
foreach ($x=1;$x<10; $x++)
{       
    $val=int(rand(500));
    if ($val==0) {$val=1};
    print FH "csl_signal s_c$x($val);\n";
}
    print FH "c() { \n";
 # assign assign signal-signal from   different units (parrent-parrent)        
print FH "//           assign signal to signal from different units (parrent-parrent)\n";
    print FH "  s_c$i=s_c$j;\n";
    print FH "} \n";
    print FH "}; \n";
        
        
#unit top
    print FH "csl_unit top{ \n";
foreach ($x=1; $x<10; $x++)
{   
    print FH "csl_signal s$x($val2);\n";
}    
    print FH "b b ; \n";
    print FH "c c ; \n";
    print FH "top() { \n";           
  # assign signal-signal different units :                                    
print FH "//           assign signal to signal from different units \n";\
    print FH "      s$i=b.s_b$j;\n";     #parrent-child                                   
    print FH "      s$j=b.a.s_a$k; \n";  #parrent-child/child
    print FH "      s$k=s$j; \n";

    print FH "} \n";
    print FH "}; \n";
         
    close(FH);
}
