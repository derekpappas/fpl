#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for the generated tests is : $path"."assign_part_select_pps_op_concat_replic_invalid1/ \n";

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

my @lower = (0,6,12,24);
my @upper = (35,59,65,77);
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
    $test_name = "assign_part_select_pps_op_concat_replic".$i."_".$l."_".$u."_illegal.csl";
    my $w = $u - $l + 1;
    my $val1 = $u + int(rand(100)) + 1;
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $val1 + int(rand(30)) + 1;
    my $val4 = $val1 + int(rand(30)) + 1;
    my $val5 = $val1 + int(rand(30)) + 1;
    my $val6 = $w/2;
    my $val7 = $w/3;
    my $val8 = $w/6;
    my $val9 = 2*$w;
    my $val10 = 3*$w;
    my $val11 = 6*$w;
    &mkDir("$path/assign_part_select_pps_op_concat_replic_invalid1");
    open(FH,">$path/assign_part_select_pps_op_concat_replic_invalid1/$test_name");
    print FH "//Generated by Petronela\n";
     print FH "//Test cases from: assign_test_matrix.odg \n"; 
    print FH "//part select used in assign  port parent output,child input,parent inout with op expr,concat expr.,replication expr. \n\n";
    #print FH "csl_bitrange br($val2);\n";
    #print FH "csl_bitrange brt($val3);\n";
    #print FH "csl_filed f1($val4),f2($val5);\n";
    print FH "csl_unit a {\n";
    print FH "  csl_port p_data(input,$val9);\n"; 
    print FH "  csl_port p_addr(output,$val4);\n";
    print FH "  csl_port p_data1(input,$val6);\n";
    print FH "  csl_port p_addr1(output,$val6);\n"; 
    print FH "  csl_port p_addr2(inout,$val7);\n";
    print FH "  csl_port p_data3(output,$val7);\n";
    print FH "  csl_port p_addr3(input,$val7);\n";
    print FH "  csl_port p_data4(input,$val8);\n";
    print FH "  csl_port p_data2(inout,$val1);\n"; 
    print FH "  csl_port p_addr4(output,$w);\n";
    print FH "  a() {\n";
    if($i <=3 ){
        print FH "    p_addr[$u:$l] = {p_data3,p_addr2,p_addr3};\n";
        print FH "    p_data2[$u:$l] = {p_addr1,p_data1};\n";
    }
    elsif($i >3 && $i<= 6){
        print FH "    p_addr[$u:$l] = {3{p_data3}};\n";
        print FH "    p_data2[$u:$l] = {2{p_addr1}};\n";
    }
    else{
        print FH "    p_addr[$u:$l] = ~p_addr4;\n";
        print FH "    p_data2[$u:$l] = p_addr4 & p_data1;\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    print FH "csl_unit b {\n"; 
    if($i < 2){
        print FH "  a a0;\n";
        print FH "  a a1;\n";
    }
    else {
        print FH "  a a0;\n";
        print FH "  a a1;\n";
        print FH "  a a2;\n";
    }
   
    print FH "  csl_port p_data5(input,$val1);\n";
    print FH "  csl_port p_addr5(output,$val2);\n";
    print FH "  csl_port p_data11(input,$val2);\n";
    print FH "  csl_port p_addr11(output,$w);\n";
    print FH "  csl_port p_data21(inout,$val1);\n";
    print FH "  csl_port p_addr21(inout,$w);\n";
    print FH "  csl_port p_data31(input,$val9);\n";
    print FH "  csl_port p_addr31(output,$val10);\n";
    print FH "  csl_port p_data41(inout,$val11);\n";
    print FH "  b() {\n";
    if($i<=3){
        print FH "    p_addr31 = {p_addr5[$u:$l],p_data5[$u:$l],p_data11[$u:$l]};\n";
        print FH "    p_data5 = {p_data21[$u:$l],p_data5[$u:$l]};\n";
    }
    elsif($i >3 && $i<=6){
        print FH "    p_addr31 = {3{p_addr5[$u:$l]}};\n";
        print FH "    p_data5 = {2{p_data21[$u:$l]}};\n";
    }
    else{
        print FH "    p_addr11 = p_addr5[$u:$l] | p_data11[$u:$l];\n";
        print FH "    p_addr21 = p_data21[$u:$l] & p_data5[$u:$l];\n";
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
 
    print FH "  csl_port p_data6(input,$val1);\n";
    print FH "  csl_port p_addr6(output,$val2);\n";
    print FH "  csl_port p_data12(input,$val2);\n";
    print FH "  csl_port p_addr12(output,$w);\n";
    print FH "  csl_port p_data22(inout,$val1);\n";
    print FH "  csl_port p_addr22(inout,$w);\n";
    print FH "  csl_port p_data32(input,$val9);\n";
    print FH "  csl_port p_addr32(output,$val11);\n";
    print FH "  csl_port p_data42(inout,$val10);\n";
    print FH "  c() {\n";
    if($i<=3){
        print FH "    p_data32 ={p_addr6[$u:$l],p_data12[$u:$l]};\n";
        print FH "    p_data42 = {p_addr6[$u:$l],p_data12[$u:$l],p_data6[$u:$l]} ;\n"; 
    }
    elsif($i >3 && $i<=6){
        print FH "    p_data32 ={2{p_data6[$u:$l]}};\n";
        print FH "    p_addr32 = {3{p_addr6[$u:$l],p_data12[$u:$l]}} ;\n";
    }
    else{
        print FH "    p_data6 = p_data6[$u:$l] & p_addr6[$u:$l];\n";
        print FH "    p_addr6 = p_addr6[$u:$l] | p_data12[$u:$l] ;\n"; 
    }
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
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
    }
    print FH "  csl_port p_data7(input,$val3);\n"; 
    print FH "  csl_port p_addr7(output,$val4);\n";
    print FH "  csl_port p_data13(input,$val6);\n";
    print FH "  csl_port p_addr13(output,$val6);\n"; 
    print FH "  csl_port p_addr23(inout,$val7);\n";
    print FH "  csl_port p_data33(output,$val7);\n";
    print FH "  csl_port p_addr33(input,$val7);\n";
    print FH "  csl_port p_data43(input,$val8);\n";
    print FH "  csl_port p_data23(inout,$val1);\n"; 
    print FH "  csl_port p_addr43(output,$w);\n";  
    print FH "  d() {\n";
    if($i < 4) {
        print FH "    p_data7[$u:$l] = {p_addr13,p_data13};\n";
        print FH "    p_data23[$u:$l] = {p_data33,p_addr23,p_addr33};\n";
       
    }
    elsif($i >= 4 && $i <= 6) {
        print FH "    p_data7[$u:$l] = {2{p_data13}};\n";
        print FH "    p_data23[$u:$l] = {3{p_data43}};\n";
    }
    else{
        print FH "    p_data7[$u:$l] = p_addr43 & p_data13;\n";
        print FH "    p_data23[$u:$l] = p_data33 | p_addr43;\n";  
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
  
    print FH "  csl_port p_data8(input,$val2);\n"; 
    print FH "  csl_port p_addr8(output,$val4);\n";
    print FH "  csl_port p_data14(input,$val6);\n";
    print FH "  csl_port p_addr14(output,$val6);\n"; 
    print FH "  csl_port p_addr24(inout,$val7);\n";
    print FH "  csl_port p_data34(output,$val7);\n";
    print FH "  csl_port p_addr34(input,$val7);\n";
    print FH "  csl_port p_data44(input,$val8);\n";
    print FH "  csl_port p_data24(inout,$val1);\n"; 
    print FH "  csl_port p_addr44(output,$w);\n"; 
   
    print FH "  e() {\n";
    if($i <= 3) {
        print FH "    p_addr8[$u:$l] = {p_addr14,p_data14};\n";
        print FH "    p_data8[$u:$l] = {p_addr34,p_addr24,p_data34};\n";
    }
    elsif($i > 3 && $i >= 6) {
        print FH "    p_data8[$u:$l] = {3{p_addr34}};\n";
        print FH "    p_addr8[$u:$l] = {2{p_addr14}};\n";
        
    }
    else{
        print FH "    p_addr8[$u:$l] = p_data14 | p_addr44;\n";
        print FH "    p_data8[$u:$l] = ~p_addr44;\n";
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
    print FH "  csl_port p_data9(input,$val1);\n";
    print FH "  csl_port p_addr9(output,$val2);\n";
    print FH "  csl_port p_data15(input,$val2);\n";
    print FH "  csl_port p_addr15(output,$w);\n";
    print FH "  csl_port p_data25(inout,$val1);\n";
    print FH "  csl_port p_addr25(inout,$w);\n";
    print FH "  csl_port p_data35(input,$val9);\n";
    print FH "  csl_port p_addr35(output,$val10);\n";
    print FH "  csl_port p_data45(inout,$val10);\n"; 
    print FH "  top(){\n";
    if($i <= 3) {
        print FH "    p_data35 = {p_data9[$u:$l],p_addr9[$u:$l]};\n";
        print FH "    p_addr35 = {p_addr9[$u:$l],p_data15[$u:$l],p_data25[$u:$l]};\n"; 
    }
    elsif($i > 3 && $i <=6) {
        print FH "    p_data35 = {2{p_addr9[$u:$l]}};\n";
        print FH "    p_addr35 = {3{p_data25[$u:$l]}};\n";
    }
    else{
        print FH "    p_addr15 = ~p_addr9[$u:$l];\n";
        print FH "    p_addr25 = p_data25[$u:$l] & p_addr9[$u:$l];\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
