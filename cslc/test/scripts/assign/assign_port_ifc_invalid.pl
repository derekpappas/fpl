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
        foreach ($k=1; $k<=3; $k++){
                        $count=$count+1;          
                        &main($count,$i, $j ,$i11, $j11,$k);
                    }
    }
}

sub main {     
  #  my $count = $_[0];  
    my $test_name = "assign_port_ifc".$count."_illegal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    if($count==1){
        print (" Generated path: $path/assign_port_ifc_invalid/ \n");}
    my $val = int(rand(500));
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));

    if($val == 0) { $val = 1; } ;   
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
   
    &mkDir("$path/assign_port_ifc_invalid");
    open(FH,">$path/assign_port_ifc_invalid/$test_name");

    print FH "//costelc \n";
     print FH "//Test cases from: assign_test_matrix.odg, part_select_matrix.odg\n"; 
    print FH "//assign port-interface \n\n";
    print FH "csl_bitrange br($val);\n";
# ifc
    print FH "csl_interface ifc{ \n";
    print FH "csl_port ifc_p1(input,br),ifc_p2(input,$val),ifc_p3(output,$val2), ifc_p4(output,$val3);\n";
    print FH "ifc() {} \n";
    print FH "};\n";
#unit a    
    print FH "csl_unit a{ \n";
    print FH "csl_port p_a1(input, $val2);\n";
    print FH "csl_port p_a2(output, br); \n";
    print FH "csl_port p_a3(input, br); \n";
    print FH "csl_port p_a4(output, $val3+$val2); \n";
    print FH "ifc ifc1;\n";
    print FH "a() { \n";
  # assign port- interface from the same unit 
    print FH " p_a$i=ifc1;  } \n";
    print FH "}; \n";
#unit b
    print FH "csl_unit b{ \n";
    print FH "csl_port p_b1(input, $val2);\n";
    print FH "csl_port p_b2(output, br); \n";
    print FH "csl_port p_b3(output, br); \n";
    print FH "csl_port p_b4(input, $val3+$val2); \n";
    print FH "ifc ifc2 ;\n";
    print FH "a a ; \n";
    print FH "b() { \n";
 # assign port interface from  different units :        
    print FH "  p_b$i=a.ifc1;\n";
    print FH "} \n";
    print FH "}; \n";

#unit c
    print FH "csl_unit c{ \n";
    print FH "csl_port p_c1(input, $val2);\n";
    print FH "csl_port p_c2(output, br); \n";
    print FH "csl_port p_c3(output, br); \n";
    print FH "csl_port p_c4(input, $val3+$val2); \n";
    print FH "ifc ifc3 ;\n";
    print FH "c() { \n";
 # assign port interface from  different units :        
    print FH "  p_c$i=ifc3;\n";
    print FH "} \n";
    print FH "}; \n";
        
        
#unit top
    print FH "csl_unit top{ \n";
    print FH "csl_port p1(input,$val2);\n";
    print FH "csl_port p2(input,$val3); \n";
    print FH "csl_port p3(output, br); \n";
    print FH "csl_port p4(output, $val3+$val2); \n";
    
    
    print FH "b b ; \n";
    print FH "c c ; \n";
    print FH "top() { \n";           
  # assign port interfce different units :                                    
    print FH "      p$i=b.ifc2;\n";     #parrent-child                                   
    print FH "      p$j=b.a.ifc1; \n";  #parrent-child/child
    print FH "      p$k=ifc$j; \n";

    print FH "} \n";
    print FH "}; \n";
         
    close(FH);
}
