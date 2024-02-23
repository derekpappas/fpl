#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for the generated tests is : $path"."assign_part_select_pps_pps_invalid1/ \n";

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

my @lower = (0,3,10,23);
my @upper = (32,51,64,80);
for(my $i=1;$i <=3;++$i){
    foreach my $l(@lower) {
        foreach my $u(@upper) { 
            &main($i,$l,$u);
        }
    }
}

sub main {
    my ($i,$l,$u) = @_;
    my $test_name;
    $test_name = "assign_part_select_pps_pps".$i."_".$l."_".$u."_illegal.csl";
    my $val1 = $u + int(rand(100)) + 1;
    my $w = $u - $l + 1;
    my $w1 = $w -1; 
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $val1 + int(rand(30)) + 1;
    my $val4 = $val1 + int(rand(30)) + 1;
    my $val5 = $val1 + int(rand(30)) + 1;
    &mkDir("$path/assign_part_select_pps_pps_invalid1");
    open(FH,">$path/assign_part_select_pps_pps_invalid1/$test_name");
    
    print FH "//Generated by Petronela\n";
    print FH "//Test cases from: assign_test_matrix.odg, part_select_matrix.odg\n"; 
    print FH "//part select used in assign port[ps] parent output,child input,parent inout with port parent input,child output,parent inout \n";
    print FH "//and port parent output,child input,parent inout with port[ps] parent input,child output,parent inout \n\n";
    #print FH "csl_bitrange br($val1);\n";
    #print FH "csl_bitrange brt($val2);\n";
    #print FH "csl_filed f1($val1),f2($val5);\n";
    print FH "csl_unit a {\n";
    print FH "  csl_port p_data(input,$val1);\n"; 
    print FH "  csl_port p_addr(output,$val4);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n"; 
    print FH "  csl_port p_addr2(inout,$w);\n";
    print FH "  csl_port p_data2(inout,$val1);\n"; 
    print FH "  a() {\n";
    print FH "    p_data[$u:$l] = p_data1;\n";
    print FH "    p_addr1 = p_addr[$u:$l];\n";
    print FH "    p_data2[$u:$l] = p_addr2;\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    if($i >= 2 ){
        print FH "csl_unit f {\n";
        print FH "  csl_port p_data(input,$val1);\n"; 
        print FH "  csl_port p_addr(output,$w);\n";
        print FH "  csl_port p_data1(inout,$val1);\n";
        print FH "  f() {\n";  
        #print FH "    p_data1[$u:$l] = p_addr;\n";
        print FH "  }\n";        
        print FH "};\n";        
        print FH "\n";
    }
    print FH "csl_unit b {\n"; 
    if($i < 2){
        print FH "  a a0;\n";
        print FH "  a a1;\n";
    }
    else {
        print FH "  f f0;\n";
        print FH "  f f1;\n";
        print FH "  a a0;\n";
        print FH "  a a1;\n";
        print FH "  a a2;\n";
    }
   
    print FH "  csl_port p_data3(input,$val1);\n";
    print FH "  csl_port p_addr3(output,$val2);\n";
    print FH "  csl_port p_data11(input,$w);\n";
    print FH "  csl_port p_addr11(output,$w);\n";
    print FH "  csl_port p_data21(inout,$val1);\n";
    print FH "  csl_port p_addr21(inout,$w);\n";
    print FH "  b() {\n";
    print FH "    p_addr3[$u:$l] = p_addr11;\n";
    print FH "    p_data11 = p_data3[$u:$l];\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";
    if($i < 2){
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  a a0;\n";
    }
    else {
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  b b2;\n";
        print FH "  a a0;\n";
    }
 
    print FH "  csl_port p_data4(input,$val1);\n";
    print FH "  csl_port p_addr4(output,$val1);\n";
    print FH "  csl_port p_data12(input,$w);\n";
    print FH "  csl_port p_addr12(output,$w);\n";
    print FH "  csl_port p_data22(inout,$val1);\n";
    print FH "  csl_port p_addr22(inout,$w);\n";
    print FH "  c() {\n";
    print FH "    p_addr12 = p_addr4[$u:$l] ;\n"; 
    print FH "    p_data4[$u:$l] = p_data4[$u:$l];\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit d {\n";  
    if($i < 2){
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
    }
    else {
        print FH "  f f0;\n";
        print FH "  f f1;\n";
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
    }
    print FH "  csl_port p_data5(input,$val2);\n"; 
    print FH "  csl_port p_addr5(output,$val1);\n";
    print FH "  csl_port p_data13(input,$w);\n";
    print FH "  csl_port p_addr13(output,$w);\n";
    print FH "  csl_port p_data23(input,$val1);\n";
    print FH "  csl_port p_addr23(input,$w);\n";
    print FH "  d() {\n";
    if($i < 2) {
        print FH "    p_addr5[$u:$l] = p_addr13;\n";
        print FH "    p_addr23 = p_data5[$u:$l];\n";
       
    }
    elsif($i >= 2) {
        print FH "    p_data5[$u:$l] = p_data23[$u:$l];\n";
        print FH "    p_addr13 = p_addr5[$u:$l];\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    print FH "csl_unit e {\n";  
    if($i < 2){
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
    }
    elsif($i >= 2) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  c c2;\n";
    }
  
    print FH "  csl_port p_data6(input,$val1);\n"; 
    print FH "  csl_port p_addr6(output,$val1);\n";   
    print FH "  csl_port p_data14(input,$w);\n";  
    print FH "  csl_port p_addr14(output,$w);\n";  
    print FH "  csl_port p_data24(input,$val1);\n"; 
    print FH "  csl_port p_addr24(input,$w);\n";   
   
    print FH "  e() {\n";
    if($i == 1) {
        print FH "    p_data14 = p_data6[$u:$l];\n";
        print FH "    p_data6[$u:$l] = p_addr24;\n";
    }
    elsif($i == 2) {
        print FH "    p_addr14 = p_addr6[$u:$l];\n";
        print FH "    p_addr6[$l] = p_addr14[$w1];\n";
    }
  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    if($i < 2){
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  d d2;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
    }
    elsif($i >= 2) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
        print FH "  e e2;\n";
        print FH "  a a0;\n";
    }
    print FH "  csl_port p_data7(input,$val1);\n"; 
    print FH "  csl_port p_addr7(output,$val1);\n";   
    print FH "  csl_port p_data15(input,$w);\n";  
    print FH "  csl_port p_addr15(output,$w);\n";  
    print FH "  csl_port p_data25(input,$val2);\n"; 
    print FH "  csl_port p_addr25(input,$w);\n";   
    print FH "  top(){\n";
    if($i == 1) {
        print FH "    p_data15 = p_data7[$u:$l];\n";
        print FH "    p_data25[$u:$l] = p_data15;\n";
        print FH "    p_addr7[$u:$l] = p_addr7[$u:$l];\n"; 
    }
    elsif($i == 3) {
        print FH "    p_addr15 = p_addr7[$u:$l];\n";
        print FH "    p_data7[$u:$l] = p_data15;\n";
        print FH "    p_addr25 = p_data25[$u:$l];\n";
        
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}

