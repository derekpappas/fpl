#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for the generated tests is : $path"."assign_part_select_sps_p_invalid/ \n";

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
    $test_name = "assign_part_select_sps_p".$i."_".$l."_".$u."_illegal.csl";
    my $val1 = $u + int(rand(100)) + 1;
    my $w = $u - $l + 1;
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $val1 + int(rand(30)) + 1;
    my $val4 = $val1 + int(rand(30)) + 1;
    my $val5 = $val1 + int(rand(30)) + 1;
    &mkDir("$path/assign_part_select_sps_p_invalid");
    open(FH,">$path/assign_part_select_sps_p_invalid/$test_name");
    
    print FH "//Generated by Petronela\n";
    print FH "//part select used in assign port parent input,child output,child inout with sig[ps], sg[.+sg].sig[ps] with \n\n";
    print FH "csl_signal_group sga {\n";
    print FH "  csl_signal s_sga$i($val1);\n";
    print FH "  csl_signal s_sgga($val2);\n";
    print FH "  csl_signal s_sa($w);\n";
    print FH "  csl_signal s_sgaa$i($w);\n";
    print FH "  sga() {\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_signal_group sgb {\n";
    print FH "  sga sga0;\n";
    print FH "  sga sga1;\n";
    print FH "  csl_signal s_sga$i($val1);\n";
    print FH "  csl_signal s_sgga($val2);\n";
    print FH "  csl_signal s_sa($w);\n";
    print FH "  csl_signal s_sgaa$i($w);\n";
    print FH "  sgb() {\n";
    print FH "  }\n";
    print FH "};\n\n";

    
    print FH "csl_unit a {\n";
    print FH "  sgb sgb0;\n";
    print FH "  csl_signal s_data($val1);\n"; 
    print FH "  csl_signal s_addr($val4);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n"; 
    print FH "  csl_signal s_addr2($w);\n";
    print FH "  csl_signal s_data2($w);\n"; 
    print FH "  csl_port p_addr3(inout,$w);\n";
   
    
    print FH "  a() {\n";
    print FH "    p_data1 = s_data[$u:$l];\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    if($i >= 2 ){
        print FH "csl_unit f {\n";
        print FH "  csl_signal s_data($val1);\n"; 
        print FH "  csl_port p_addr(input,$w);\n";
        print FH "  csl_signal s_data1($val1);\n";
        print FH "  f() {\n";  
        print FH "    p_addr = s_data[$u:$l];\n";
        print FH "  }\n";        
        print FH "};\n";        
        print FH "\n";
    }
    print FH "csl_unit b {\n"; 
    if($i < 2){
        print FH "  a a0;\n";
        print FH "  a a1;\n";
        print FH "  sgb sgb1;\n";
        print FH "  sga sga2;\n";
    }
    else {
        print FH "  f f0;\n";
        print FH "  f f1;\n";
        print FH "  a a0;\n";
        print FH "  a a1;\n";
        print FH "  a a2;\n";
    }
   
    print FH "  csl_signal s_data($val1);\n";
    print FH "  csl_signal s_addr($val2);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n";
    print FH "  csl_signal s_data2($w);\n";
    print FH "  csl_signal s_addr2($w);\n";
    print FH "  csl_port p_data3(inout,$w);\n";
    print FH "  b() {\n";
    print FH "    a0.p_data1 = s_data1[$u:$l];\n";
    print FH "    a1.p_data3 = sga.s_sgga[$u-:$l];\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";
    if($i < 2){
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  sgb sgb2;\n";
        print FH "  sgb sgb3;\n";
    }
    else {
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  b b2;\n";
        print FH "  a a0;\n";
        print FH "  sgb sgb2;\n";
        print FH "  sgb sgb3;\n";
    }
 
    print FH "  csl_signal s_data($val1);\n";
    print FH "  csl_signal s_addr($val1);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n";
    print FH "  csl_signal s_data2($w);\n";
    print FH "  csl_signal s_addr2($w);\n";
    print FH "  csl_port p_data3(inout,$w);\n";

    print FH "  c() {\n";
    print FH "    b0.p_data3 = sgb2.s_sga$i"."[$u:$l] ;\n"; 
    print FH "    b1.a0.p_addr1 = b0.sgb1.s_sgga[$u-:$l];\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit d {\n";  
    if($i < 2){
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  sgb sgb4;\n";
        print FH "  sgb sgb5;\n";
    }
    else {
        print FH "  f f0;\n";
        print FH "  f f1;\n";
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  sgb sgb4;\n";
        print FH "  sgb sgb5;\n";
    }
    print FH "  csl_signal s_data($val2);\n"; 
    print FH "  csl_signal s_addr($val1);\n";
    print FH "  csl_port p_data1(input,$w);\n";
    print FH "  csl_port p_addr1(output,$w);\n";
    print FH "  csl_signal s_data2($w);\n";
    print FH "  csl_signal s_addr2($w);\n";
    print FH "  csl_port p_data3(inout,$w);\n";
    
    print FH "  d() {\n";
    if($i < 2) {
        print FH "    b0.p_addr1 = sgb4.s_sgga[$u:$l];\n";
        print FH "    b1.p_addr1 = c0.s_data[$u-:$l];\n";
       
    }
    elsif($i >= 2) {
        print FH "    b1.p_addr1 = c0.sgb3.sga0.s_sgga[$u:$l];\n";
        print FH "    p_data1 = c0.a0.sgb0.sga$i"."[$u-:$l];\n";
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
        print FH "  sgb sgb3;\n";
        print FH "  sgb sgb4;\n";
    }
    elsif($i >= 2) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  c c2;\n";
        print FH "  sgb sgb3;\n";
        print FH "  sgb sgb4;\n";
        print FH "  sga sga3;\n";
    }
  
    print FH "  csl_signal s_data($val1);\n"; 
    print FH "  csl_signal s_addr($val1);\n";   
    print FH "  csl_port p_data1(input,$w);\n";  
    print FH "  csl_port p_addr1(output,$w);\n";  
    print FH "  csl_signal s_data2($w);\n"; 
    print FH "  csl_signal s_addr2($w);\n";   
    print FH "  csl_port p_data3(inout,$w);\n";
    print FH "  e() {\n";
    if($i == 1) {
        print FH "    b0.p_addr1 = d1.sge2.s_sgga[$u:$l];\n";
        print FH "    b1.a0.p_data3 = c0.s_data[$u:$l];\n";
    }
    elsif($i == 2) {
        print FH "    d0.c1.p_data1 = c1.b0.s_data1[$u:$l];\n";
        print FH "    d1.p_data1 = c2.b1.s_addr[$u:$l];\n";
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
        print FH "  sgb sgb6;\n";
        print FH "  sgb sgb7;\n";
    }
    elsif($i >= 2) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
        print FH "  e e2;\n";
        print FH "  a a0;\n";
        print FH "  sgb sgb6;\n";
        print FH "  sgb sgb7;\n";
    }
    print FH "  csl_signal s_data($val1);\n"; 
    print FH "  csl_signal s_addr($val1);\n";   
    print FH "  csl_port p_data1(input,$w);\n";  
    print FH "  csl_port p_addr1(output,$w);\n";  
    print FH "  csl_signal s_data2($w);\n"; 
    print FH "  csl_signal s_addr2($w);\n";   
    print FH "  csl_port p_data3(inout,$w);\n";
    
    print FH "  top(){\n";
    if($i == 1) {
        print FH "    e0.d0.b1.p_addr1 = d0.s_addr[$u:$l];\n";
        print FH "    d1.p_addr1 = e1.d0.b0.a0.s_data1[$u-:$l];\n";
        print FH "    d1.b0.p_addr1 = e0.s_addr[$u:$l];\n"; 
    }
    elsif($i == 3) {
        print FH "    e1.p_data1 = d1.s_data1[$u:$l];\n";
        print FH "    e1.p_data1 = a0.s_addr[$u:$l];\n";
        print FH "    e2.p_data3 = sgb6.s_sgga[$u-:$l];\n";
        
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}

