#!/usr/bin/perl

#Author costelc
use strict;
 my $path = "$ENV{WORK}/test/csl_test_gen";
  
        print (" Generated path: $path/assign_port_sig_valid/\n");

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
    my ($count,$i, $j ,$i11, $j11,$k)=@_;  
    my $test_name = "assign_port_sig".$count."_legal.csl";
#    &createCslFile($test_name, $count);
    &mkDir("$path/assign_port_sig_valid");
    open(FH,">$path/assign_port_sig_valid/$test_name");
#}


#sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
  #  my($test_name, $count) = @_;
   
    my $val = int(rand(500));
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));

    if($val == 0) { $val = 1; } ;   
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
   

    if($count>=0){
    print FH "//costelc \n";
    print FH "//Test cases from: assign_test_matrix.odg, part_select_matrix.odg\n"; 
    print FH "//assign port-signal \n\n";
    print FH "csl_bitrange br($val);\n";
    
    print FH "csl_unit a{ \n";
    print FH "csl_port p_a1(input, $val2);\n";
    print FH "csl_port p_a2(output, br); \n";
    print FH "csl_port p_a3(input, br); \n";
    print FH "csl_port p_a4(output, $val3+$val2); \n";
  #  print FH "csl_signal s_a1(br); \n";
  #  print FH "csl_signal s_a2($val2);\n";
  #  print FH "csl_signal s_a3($val3);\n";
  #  print FH "csl_signal s_a4($val2+$val3);\n";
    print FH "a() { \n";
   # assign port- signal from the same unit 
    print FH " } \n";
    print FH "}; \n";

    print FH "csl_unit b{ \n";
    print FH "csl_port p_b1(input, $val2);\n";
    print FH "csl_port p_b2(output, br); \n";
    print FH "csl_port p_b3(output, br); \n";
    print FH "csl_port p_b4(input, $val3+$val2); \n";
    print FH "csl_signal s_b1(br); \n";
#    print FH "csl_signal s_b2($val2);\n";
#    print FH "csl_signal s_b3($val3);\n";
    print FH "csl_signal s_b4($val2+$val3);\n";
  # assign port signal (different units)- parrent+child
    print FH "a a0(.p_a1(p_b1),.p_a2(p_b2),.p_a3(s_b1),.p_a4(s_b4)) ; \n";
    print FH "b() { \n";
#    print FH "  p_b$i=a.s_a$j;\n";
    print FH "} \n";
    print FH "}; \n";

        
        

    print FH "csl_unit top{ \n";
    print FH "csl_port p1(input,$val2);\n";
 #   print FH "csl_port p2(input,$val3); \n";
    print FH "csl_port p3(output, br); \n";
 #   print FH "csl_port p4(output, $val3+$val2); \n";
    
    print FH "csl_signal s1(br); \n";
 #   print FH "csl_signal s2($val2);\n";
 #   print FH "csl_signal s3($val3);\n";
    print FH "csl_signal s4($val2+$val3);\n";
    
    print FH "b b0(.p_b1(p1),.p_b2(p3),.p_b3(s1),.p_b4(s4)) ; \n";
    print FH "top() { \n";           
  # assign port signal different units :                                    
 #   print FH "      p$i=b.s_b$j;\n";     #parrent-child                                   
 #   print FH "      p$j=b.a.s_a$k; \n";  #parrent-child/child
    
    print FH "} \n";
    print FH "}; \n";
}
         
    close(FH);
}
