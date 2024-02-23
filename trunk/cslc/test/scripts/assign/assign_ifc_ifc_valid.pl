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
    my $test_name = "assign_ifc_ifc".$count."_legal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $i2;
    my $x=0 ;
    my $y=0;
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
   if($count==1){
        print (" Generated path: $path/assign_ifc_ifc_valid/\n");}
    my $val = int(rand(500));
    my $val2 = int(rand(500));
    my $val3 = int(rand(500));

    if($val == 0) { $val = 1; } ;   
    if($val2 == 0) { $val2 = 1; }  ; 
    if($val3 == 0) { $val3 = 1; };
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_ifc_ifc_valid");
        open(FH,">$path/assign_ifc_ifc_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/assign_ifc_ifc_invalid"); 
        open(FH,">$path/assign_ifc_ifc_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "// Test cases from test matrix: assign_test_matrix.odg \n";
    print FH "//assign interface_interface \n\n";
    print FH "csl_bitrange br($val);\n";
#interface
    print FH "csl_interface ifc { \n";
  
    $val=int(rand(300));
    if ($val==0) {$val=1};
    print FH "csl_port p1_ifc$i(input,$val); \n";


    $val=int(rand(300));
    if ($val==0) {$val=1};
    print FH "csl_port p2_ifc$i(output,$val); \n";

print FH "ifc() {} \n";
print FH "}; \n";

#unit a
    print FH "csl_unit a{ \n";
  
    print FH "ifc ifc_a$i;\n";

    print FH "a() { \n";
  # assign interface-interface from the same unit     
   print FH "//           assign interface-interface from the same unit \n";
#    print FH " ifc_a$i=ifc_a$j; 
   print FH " } \n";
    print FH "}; \n";
#unit b
    print FH "csl_unit b{ \n";

    print FH "ifc ifc_b$i;\n";
    print FH "ifc ifc_a$j;\n";

    print FH "a a_$i(.ifc_a$i(ifc_b$i)) ; \n";

    print FH "b() { \n";
print FH "//           assign interface to interface from the same unit\n";
 # assign interface to interface from  different units (parrent-child)        
#    print FH "  ifc_b$j=ifc_a$k;\n";
    print FH "} \n";
    print FH "}; \n";

#unit c
    print FH "csl_unit c{ \n";
       
    print FH "ifc ifc_c$i;\n";
    print FH "ifc ifc_b$i;\n";
    print FH "b b_$i(.ifc_b$i(ifc_c$i),.ifc_a$j(ifc_b$i));\n";

    print FH "c() { \n";
 # assign interface-interface   different units (parrent-parrent)        
print FH "//           assign interface to interface from the same unit\n";
#    print FH "  ifc_c$i=ifc_b$i;\n";
    print FH "} \n";
    print FH "}; \n";
        
        
#unit top
    print FH "csl_unit top{ \n";
  
    print FH "ifc ifc$i;\n";
    print FH "ifc ifc_b$i;\n";
    print FH "ifc ifc_a$i;\n";
   
    print FH "b b_$i(.ifc_b$i(ifc_b$i),.ifc_a$j(ifc$i)) ; \n";
    print FH "c c_$i(.ifc_c$i(ifc_a$i),.ifc_b$i(ifc_b$i)) ; \n";

    print FH "top() { \n";           
  # assign interface interface different units :                                    
print FH "//           assign interface to interface from the same unit \n";\
#    print FH "      ifc$i=ifc_b$j;\n";     #parrent-child                                   
#    print FH "      ifc$j=ifc_a$k; \n";  #parrent-child/child
#    print FH "      ifc$k=ifc$j; \n";

    print FH "} \n";
    print FH "}; \n";
         
    close(FH);
}
