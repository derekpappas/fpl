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
foreach ($i=1; $i<=5; $i++){
    foreach ($j=1; $j<=5; $j++){
        foreach ($k=1; $k<=5; $k++){
            $count=$count+1;          
                        &main($count,$i, $j ,$i11, $j11,$k);
                    }
    }
}

sub main {     
  #  my $count = $_[0];  
    my $test_name = "f2a_sg_sg".$count."_illegal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my $val = int(rand(100));
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
   if($count==1){
        print ("Generated path: $path/f2a_sg_sg_invalid/ \n");}
    my $val2 = int(rand(100));
    my $val3 = int(rand(100));
    if($val == 0) { $val = 1; };
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
    if($test_name=~/(_legal)/){
        &mkDir("$path/f2a_sg_sg_valid");
        open(FH,">$path/f2a_sg_sg_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/f2a_sg_sg_invalid"); 
        open(FH,">$path/f2a_sg_sg_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "//f2a_signal_group_signal_group \n\n";

#signal_group1
print FH "csl_signal_group sgg {\n";   
 foreach ($x=1; $x<=5; $x++)
{  
    print FH "csl_signal s_sgg$x($val);\n";
}
print FH "sgg() {}\n";
print FH "};\n";
#signal_group2
    print FH "csl_signal_group sg {\n";   
 foreach ($x=1; $x<=5; $x++)
{  
    print FH "csl_signal s_sg$x($val);\n";
}
print FH "sgg sgg; \n";
print FH "sg() {}\n";
print FH "};\n";

 #unit a   
    print FH "csl_unit a{ \n";
print FH "sg sg_a;\n";
foreach ($x=1; $x<=5; $x++)
{  
    print FH "csl_signal s_a$x;\n";
}
    print FH "a() {} \n";
    print FH "}; \n";

#unit b
    print FH "csl_unit b{ \n";
    print FH "sg sg_b;\n";
foreach ($x=1; $x<=5; $x++)
{
   print FH "csl_signal s_b$x($val);\n";
}      
    print FH " //    f2a s-sg.s  \n";    
    print FH "a a(.s_a$j(sg_b.s_sg$k)) ; \n";
    print FH "b() {} \n";
    print FH "}; \n";


#unit c
    print FH "csl_unit c{ \n";
   foreach ($x=1; $x<=5; $x++)
{
   print FH "csl_signal s_c$x($val);\n";
}      
    print FH "sg sg_c;\n";
    print FH "c() {} \n";
    print FH "}; \n";
#unit top
    print FH "csl_unit top{ \n";
    foreach ($x=1; $x<=5; $x++)
{
    print FH "csl_signal s$x;\n";
}
    print FH "sg sg ;\n";
    print FH "// f2a  ,s-sg     , s-sg.sg              ,sg.s-sg    \n ";    
    print FH     "b b(.s_b$i(sg),.s_b$j(sg.sgg),.sg_b.s_sg$k(sg)            );\n";
    
    print FH "// f2a sg.s-sg.sg          ,sg.sg.s-sg            ,sg.sg.s-sg.sg                 \n";
    print FH     "c c(.sg_c.s_sg$i(sg.sgg),.sg_c.sgg.s_sgg$i(sg),.sg_c.sgg.s_sgg$j(sg.sgg) );\n";
    
   
    print FH "top() {} \n";               
    print FH "}; \n";
    
         
    close(FH);
}
