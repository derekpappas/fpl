#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for the generated tests is : $path"."assign_part_select_pps_pps_invalid/ \n";

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
for(my $i=1;$i <=9;++$i){
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
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $val1 + int(rand(30)) + 1;
    my $val4 = $val1 + int(rand(30)) + 1;
    my $val5 = $val1 + int(rand(30)) + 1;
    &mkDir("$path/assign_part_select_pps_pps_invalid");
    open(FH,">$path/assign_part_select_pps_pps_invalid/$test_name");
    
    print FH "//Generated by Petronela\n";
     print FH "//Test cases from: assign_test_matrix.odg, part_select_matrix.odg\n"; 
    print FH "//part select used in assign port[ps] parent input,child output,child inout with port parent output,child input,child inout \n";
    print FH "//and port parent input,child output,child inout with port[ps] parent output,child input,child inout \n\n";
    
    print FH "csl_unit a {\n";
    print FH "  csl_port p_data(input,$val1);\n"; 
    print FH "  csl_port p_addr(output,$val4);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n"; 
    print FH "  csl_port p_addr2(inout,$w);\n";
    print FH "  csl_port p_data2(inout,$val1);\n"; 
    print FH "  a() {\n";
    if($i <=3 ){
        print FH "    p_data[$u:$l] = p_data1;\n";
        print FH "    p_data2[$u-:$l] = p_addr2;\n";
    }
    elsif($i >=3 && $i <= 6){
        print FH "    p_data1 = p_data[$u:$l];\n";
    }
    else{
        print FH "    p_data[$u-:$l] = p_addr[$u:$l];\n";
        print FH "    p_data2[$u:$l] = p_addr[$u:$l];\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    if($i >= 4 ){
        print FH "csl_unit f {\n";
        print FH "  csl_port p_data(input,$val1);\n"; 
        print FH "  csl_port p_addr(output,$val1);\n";
        print FH "  csl_port p_data1(inout,$val1);\n";
        print FH "  f() {\n";  
        print FH "    p_data1[$u:$u] = p_addr[$u:$l];\n";
        print FH "  }\n";        
        print FH "};\n";        
        print FH "\n";
    }
    print FH "csl_unit b {\n"; 
    if($i < 4){
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
   
    print FH "  csl_port p_data(input,$val1);\n";
    print FH "  csl_port p_addr(output,$val2);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n";
    print FH "  csl_port p_data2(inout,$val1);\n";
    print FH "  csl_port p_addr2(inout,$w);\n";
    print FH "  b() {\n";
    if($i <= 3){
        print FH "    a0.p_addr[$u-:$l] = p_addr1;\n";     
        print FH "    a1.p_data2[$u:$l] = p_addr2;\n";
    }
    elsif($i > 3 && $i <=6){
        print FH "    a0.p_addr1 = p_data2[$u:$l];\n";
        print FH "    p_addr = a0.p_data[$u-:$l];\n";
    }
    else {
        print FH "    a0.p_addr[$u:$l] = a0.p_addr[$u:$l];\n";
        print FH "    a0.p_data2[$u-:$l] = a0.p_data2[$u:$l];\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";
    if($i < 4){
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
 
    print FH "  csl_port p_data(input,$val1);\n";
    print FH "  csl_port p_addr(output,$val1);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n";
    print FH "  csl_port p_data2(inout,$val1);\n";
    print FH "  csl_port p_addr2(inout,$w);\n";
    print FH "  c() {\n";
    if($i <=3){
        print FH "    b0.p_addr[$u:$l] = p_addr ;\n"; 
        print FH "    a0.p_data2[$u-:$l] = b0.p_data;\n";
    }
    elsif($i > 3 && $i <=6){
        print FH "    b0.p_addr2 = p_addr[$u-:$l] ;\n"; 
        print FH "    a0.p_addr2 = b0.p_data[$u:$l];\n";
    }
    else{
        print FH "    b0.p_data2[$l] = p_addr[$l] ;\n"; 
        print FH "    a0.p_data2[$u:$l] = b0.p_data[$u:$l];\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit d {\n";  
    if($i < 4){
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
    print FH "  csl_port p_data(input,$val2);\n"; 
    print FH "  csl_port p_addr(output,$val1);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n";
    print FH "  csl_port p_data2(inout,$val1);\n";
    print FH "  csl_port p_addr2(inout,$w);\n";
    print FH "  d() {\n";
    if($i < 4) {
        print FH "    p_data[$u:$l] = b0.p_addr1;\n";
        print FH "    c0.b0.p_data2[$u:$l] = c0.p_data1;\n";
       
    }
    elsif($i > 3 && $i <=6){
        print FH "    c0.b0.p_addr2 = c0.p_data[$u:$l];\n";
        print FH "    p_data1 = p_addr[$u:$l];\n";
    }
    else{
        print FH "    b1.p_data[$u:$l] = c0.p_data[$u:$l];\n";
        print FH "    c0.a0.p_data2[$u] = c0.p_addr[$u];\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    print FH "csl_unit e {\n";  
    if($i < 4){
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
    }
    elsif($i >= 4) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  c c2;\n";
    }
  
    print FH "  csl_port p_data(input,$val1);\n"; 
    print FH "  csl_port p_addr(output,$val1);\n";   
    print FH "  csl_port p_data1(input,$w);\n";  
    print FH "  csl_port p_addr1(output,$w);\n";  
    print FH "  csl_port p_data2(inout,$val1);\n"; 
    print FH "  csl_port p_addr2(inout,$w);\n";   
   
    print FH "  e() {\n";
    if($i <= 3) {
        print FH "    c0.p_data[$u:$l] = c0.b1.p_addr2;\n";
        print FH "    b0.p_addr[$u:$l] = p_addr1;\n ";
    }
    elsif($i > 3 && $i <=6){
        print FH "    p_data1 = d1.p_data[$u:$l];\n";
        print FH "    c0.p_addr2 = p_addr[$u-:$l];\n";
    }
    else {
        print FH "    d0.c1.p_addr1[$u:$l] = c1.b0.p_data1[$u:$l];\n";
        print FH "    p_addr[$l] = c2.b1.p_addr2[$u];\n";
    }
  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    if($i < 4){
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  d d2;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
    }
    elsif($i >= 4) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
        print FH "  e e2;\n";
        print FH "  a a0;\n";
    }
    print FH "  csl_port p_data(input,$val1);\n"; 
    print FH "  csl_port p_addr(output,$val1);\n";   
    print FH "  csl_port p_data1(input,$w);\n";  
    print FH "  csl_port p_addr1(output,$w);\n";  
    print FH "  csl_port p_data2(inout,$val2);\n"; 
    print FH "  csl_port p_addr2(inout,$w);\n";   
    print FH "  top(){\n";
    if($i <= 3) {
        print FH "    p_data2[$u:$l] = d1.p_addr2;\n";
        print FH "    e1.d0.b0.a0.p_addr1[$u:$l] = d1.p_data1;\n";
    }
    elsif($i > 3 && $i <=6){
        print FH "    e0.d0.b1.p_data1 = d0.p_addr[$u:$l];\n";
        print FH "    e0.p_addr2 = d1.b0.p_data[$u-:$l];\n"; 
    }
    else {
        print FH "    e1.p_addr[$u:$l] = d1.p_data[$u:$l];\n";
        print FH "    a0.p_data[$u-:$l] = e1.p_addr[$u:$l];\n";
        print FH "    p_data2[$l] = p_addr[$u];\n";
        
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}

