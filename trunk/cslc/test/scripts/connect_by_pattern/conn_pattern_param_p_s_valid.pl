#!/usr/bin/perl

#Author Petronela

#Test_Matrix: /test_matrices/ar_conn_by_pattern_matr.ods, 2 test cases
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for generated tests is : $path"."conn_pattern_param_p_s_valid/ \n";

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

sub word {
    my $val = $_[0];
    my @alpha = ('a'..'z','A'..'Z');
    my @alphanumeric = ('a'..'z','A'..'Z','0'..'9');
    my $ret = $alpha[rand @alpha]."zz";
    for(my $i=1;$i < $val; ++$i){
        $ret = $ret.$alphanumeric[rand @alphanumeric];
    }
    return $ret;
}

foreach(my $i = 1; $i <= 4; $i++) {
    my @map1 = ("b0","b1");
    my @map2 = ("c0","c1");
    my @map3 = ("b0","b1");
    my @map4 = ("d0","d1");
    my @map5 = ("d1","d2");
    my @map6 = ("b0","b2");
    my @map8 = ("f0","f1","a0","a1","a2");
    my @map7 = ("c0","c1");
    my @map9 = ("f0","f1");
    my @map10 = ("e0","e2");
    my $it1;
    my $it2;
    my $it3 = "";
    my $it4 = "";
    my ($it5,$it6);
    if($i <= 2){
        foreach $it1 (@map1) {
            foreach $it2 (@map2){
                if($it1 ne $it2){
                    if($i == 1){
                        foreach $it3 (@map3){
                            foreach $it4 (@map4){
                                if($it3 ne $it4){
                                    &main($i,$it1,$it2,$it3,$it4);
                                }
                            }
                        }
                    }
                    else{
                        foreach $it5 (@map4){
                            foreach $it6 (@map1){
                                if($it5 ne $it6){
                                    &main($i,$it1,$it2,$it5,$it6);
                                }       
                            }
                        }
                    }
                }
            }
        }
    }
    else {
        foreach $it1 (@map7) {
            foreach $it2 (@map8){
                if($it1 ne $it2){
                    if($i == 3){
                        foreach $it3 (@map2){
                            foreach $it4 (@map6){
                                if($it3 ne $it4){
                                    &main($i,$it1,$it2,$it3,$it4);
                                }
                            }
                        }
                    }
                    else{
                        foreach $it5 (@map10){
                            foreach $it6 (@map8){
                                if($it5 ne $it6){
                                    &main($i,$it1,$it2,$it5,$it6);
                                }       
                            }
                        }
                    }
                }
            }
        }
    }
    
}


sub main {
    my ($i,$it1,$it2,$it3,$it4) = @_;
    my $test_name;
   
    $test_name = "conn_pattern_param_p_s".$i."_".$it1."_".$it2."_".$it3."_".$it4."_legal.csl";
   
    &createCslFile($test_name, $i,$it1,$it2,$it3,$it4);
}

sub createCslFile {
    my($test_name, $i,$it1,$it2,$it3,$it4) = @_;
    
    my $val1 = int(rand(30)) + 1;
    my $val2 = int(rand(30)) + 1;
    my $val3 = int(rand(30)) + 1;
    my $val4 = int(rand(30)) + 1;
    my $val5 = int(rand(30)) + 1;
    my $word = &word($val1);
    my $word1 = &word($val2);
    my $word2 = &word($val1);
    my $word3 = &word($val2);
    my $word4 = &word($val3);
    my $word5 = &word($val4);
    my $word6 = &word($val5);
    &mkDir("$path/conn_pattern_param_p_s_valid");
    open(FH,">$path/conn_pattern_param_p_s_valid/$test_name");
    
    print FH "//Generated by Petronela\n";
    print FH "//testing the command connect_by_pattern with parameter for connections port to signal and signal to port \n\n";
    print FH "//Test_Matrix: /test_matrices/ar_conn_by_pattern_matr.ods\n\n";

    print FH "csl_unit a {\n";
    print FH "  csl_parameter a_x($val1);\n";
    print FH "  csl_parameter a_y($val1);\n";
    print FH "  csl_parameter a_z($val1);\n";
    print FH "  csl_parameter a_t($val1);\n";
    print FH "  csl_port p_data(input,a_x);\n"; 
    print FH "  csl_port p_addr(output,$val1);\n";
    print FH "  csl_port p_data1(input,$val1);\n";
    print FH "  csl_signal s_data(a_y);\n"; 
    print FH "  csl_signal s_addr(a_t);\n";
    print FH "  csl_signal s_data1($val1);\n";
    print FH "  a() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    if($i > 2 ){
        print FH "csl_unit f {\n";
        print FH "  csl_parameter f_x($val1);\n";
        print FH "  csl_parameter f_y($val1);\n";
        print FH "  csl_port p_data(input,$val1);\n"; 
        print FH "  csl_port p_addr(output,f_x);\n";
        print FH "  csl_port p_data1(input,$val1);\n";
        print FH "  csl_signal s_data(f_y);\n"; 
        print FH "  csl_signal s_addr($val1);\n";
        print FH "  csl_signal s_data1($val1);\n";
        print FH "  f() {\n";  
        print FH "  }\n";        
        print FH "};\n";        
        print FH "\n";
    }
    print FH "csl_unit b {\n"; 
    if($i <= 2){
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
    if($i < 3) {
        print FH "  csl_parameter b_x($val1);\n";
        print FH "  csl_parameter b_y($val1);\n";
        print FH "  csl_parameter b_z($val1);\n";
        print FH "  csl_parameter b_t($val1);\n";
        print FH "  csl_port p_data(output,$val1);\n";
        print FH "  csl_port p_addr(output,b_x);\n";
        print FH "  csl_port p_data1(output,$val1);\n";
        print FH "  csl_signal s_data(b_t);\n"; 
        print FH "  csl_signal s_addr(b_z);\n";
        print FH "  csl_signal s_data1($val1);\n";
    }
    else {
        print FH "  csl_parameter b_x($val1);\n";
        print FH "  csl_parameter b_y($val1);\n";
        print FH "  csl_parameter b_z($val1);\n";
        print FH "  csl_port p_data(input,$val1);\n";
        print FH "  csl_port p_addr(output,$val1);\n";
        print FH "  csl_port p_data1(output,b_y);\n";
        print FH "  csl_signal s_data(b_x);\n"; 
        print FH "  csl_signal s_addr(b_z);\n";
        print FH "  csl_signal s_data1($val1);\n";
    }
    print FH "  b() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";
    if($i <= 2){
        print FH "  b b0;\n";
        print FH "  b b1;\n";
    }
    else {
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  b b2;\n";
        print FH "  a a0;\n";
    }
    if($i <= 2){
        print FH "  csl_parameter c_x($val1);\n";
        print FH "  csl_parameter c_y($val1);\n";
        print FH "  csl_parameter c_z($val1);\n";
        print FH "  csl_port p_data(input,c_z);\n";
        print FH "  csl_port p_addr(input,c_y);\n";
        print FH "  csl_port p_data1(input,$val1);\n";
        print FH "  csl_signal s_data($val1);\n"; 
        print FH "  csl_signal s_addr($val1);\n";
        print FH "  csl_signal s_data1(c_x);\n";
    }
    else {
        print FH "  csl_parameter c_x($val1);\n";
        print FH "  csl_parameter c_y($val1);\n";
        print FH "  csl_parameter c_z($val1);\n";
        print FH "  csl_port p_data(input,$val1);\n";
        print FH "  csl_port p_addr(input,$val1);\n";
        print FH "  csl_port p_data1(output,c_y);\n";
        print FH "  csl_signal s_data(c_x);\n"; 
        print FH "  csl_signal s_addr(c_z);\n";
        print FH "  csl_signal s_data1($val1);\n";
    }

    print FH "  c() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit d {\n";  
    if($i <= 2){
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
    print FH "  csl_parameter d_x($val1);\n";
    print FH "  csl_parameter d_y($val1);\n";
    print FH "  csl_parameter d_z($val1);\n";
    print FH "  csl_port p_data(output,d_x);\n"; 
    print FH "  csl_port p_addr(input,$val1);\n";
    print FH "  csl_port p_data1(input,d_z);\n";
    print FH "  csl_signal s_data($val1);\n"; 
    print FH "  csl_signal s_addr(d_y);\n";
    print FH "  csl_signal s_data1($val1);\n";
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    $it1.p_data.connect_by_pattern($it2.s_data,$word);  //port --> sig \n";
        print FH "    $it1.s_addr.connect_by_pattern($it2.p_addr,$word4); //port --> sig \n";
       
    }
    elsif($i > 2) {
        print FH "    b1.$it2.s_data.connect_by_pattern($it1.p_data1,$word4); //sig-->port\n";
        print FH "    b1.$it2.p_addr.connect_by_pattern($it1.s_data,$word);   //port --> sig\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
     print FH "csl_unit e {\n";  
    if($i <= 2){
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
    }
    elsif($i > 2) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  c c2;\n";
    }
    if($i <= 2){
        print FH "  csl_parameter e_x($val1);\n";
        print FH "  csl_parameter e_y($val1);\n";
        print FH "  csl_parameter e_z($val1);\n";
        print FH "  csl_port p_data(input,$val1);\n"; 
        print FH "  csl_port p_addr(output,e_z);\n";   
        print FH "  csl_port p_data1(output,$val1);\n";
        print FH "  csl_signal s_data(e_y);\n"; 
        print FH "  csl_signal s_addr($val1);\n";
        print FH "  csl_signal s_data1(e_x);\n";
    }
    else {    
        print FH "  csl_parameter e_x($val1);\n";
        print FH "  csl_parameter e_y($val1);\n";
        print FH "  csl_parameter e_z($val1);\n";
        print FH "  csl_port p_data(input,e_y);\n"; 
        print FH "  csl_port p_addr(output,e_z);\n";   
        print FH "  csl_port p_data1(input,$val1);\n";
        print FH "  csl_signal s_data($val1);\n"; 
        print FH "  csl_signal s_addr(e_x);\n";
        print FH "  csl_signal s_data1($val1);\n";
    }
    print FH "  e() {\n";
    if($i == 1) {
        print FH "    $it3.p_addr.connect_by_pattern($it4.s_data1,$word1);\n";
        print FH "    c0.s_data.connect_by_pattern($it4.p_data,$word5);\n";
    }
    elsif($i == 3) {
        print FH "    d0.s_addr.connect_by_pattern(d1.c1.$it4.p_data1,$word1);\n";
        print FH "    d1.s_data1.connect_by_pattern(d0.c0.$it4.p_addr,$word5);\n";
    }
  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    if($i <=2){
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  d d2;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
    }
    elsif($i > 2) {
        print FH "  d d0;\n";
        print FH "  d d1;\n";
        print FH "  e e0;\n"; 
        print FH "  e e1;\n"; 
        print FH "  e e2;\n";
        print FH "  a a0;\n";
    }
    print FH "  csl_parameter top_x($val1);\n";
    print FH "  csl_port ptop(input,$val1);\n";
    print FH "  csl_port p(input,top_x);\n";
    print FH "  top(){\n";
    if($i == 2) {
        print FH "    e0.d0.$it4.s_data1.connect_by_pattern(e0.$it3.p_addr,$word6);\n";
        print FH "    e1.d0.$it4.a0.p_data1.connect_by_pattern(e1.$it3.s_data,$word2);\n";
        print FH "    e0.s_addr.connect_by_pattern(e0.d1.p_data1,$word3);\n"; 
    }
    elsif($i == 4) {
        print FH "    e1.c0.b0.$it4.p_addr.connect_by_pattern($it3.s_data1,$word2);\n";
        print FH "    a0.s_addr.connect_by_pattern($it3.p_data1,$word6);\n";
        print FH "    e1.c1.p_data1.connect_by_pattern($it3.s_data1,$word3);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
