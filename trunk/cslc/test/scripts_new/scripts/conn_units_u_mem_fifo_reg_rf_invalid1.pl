#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen";
print "the path to the generated tests is: $path/conn_units_u_mem_fifo_reg_rf_invalid1\n";

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

my @units = ("fifo","register","register_file","memory");
foreach my $unit(@units){
    for(my $i = 1; $i <= 4; $i++) {
        my @map1 = ("c0","c1");
        my @map2 = ("ua0","ub0");
        my @map3 = ("f0","f1","a0","a1","a2");
        my @map4 = ("ub0","uc1","ua0","ud0","ue0");
        my @map9 = ("f0","f1");
        my @map10 = ("d0","d1","e0","e1","e2");
        my $it1;
        my $it2;
        my $it3 = "";
        my $it4 = "";
        my ($it5,$it6);
        if($i <= 2){
            foreach $it1 (@map1) {
                foreach $it2 (@map2){
                    if($it1 ne $it2){
                        &main($i,$unit,$it1,$it2);
                    }
                }
            }
        }
        else {
            foreach $it1 (@map1) {
                foreach $it2 (@map4){
                    if($it1 ne $it2){
                        &main($i,$unit,$it1,$it2);
                    }
                }
            }
        }
       
 }   
}


sub main {
    my ($i,$unit,$it1,$it2) = @_;
    my $test_name = "conn_units_".$unit."_".$i."_".$it1."_".$it2."_illegal.csl";
    &createCslFile($test_name, $unit,$i,$it1,$it2);
}

sub port{
    my $val =1;
    my $val1 = 3; 
    my $val2 = 5;
    print FH "  csl_port empty(input,$val);\n"; 
    print FH "  csl_port full(input,$val);\n";
    print FH "  csl_port push(output,$val);\n";
    print FH "  csl_port pop(output,$val);\n"; 
    print FH "  csl_port clk(output,$val);\n";
    print FH "  csl_port reset_(output,$val);\n";
    print FH "  csl_port valid(input,$val);\n"; 
    print FH "  csl_port rd_data(input,$val1);\n"; 
    print FH "  csl_port wr_data(output,$val1);\n";
    print FH "  csl_port rd_addr(input,$val);\n";
    print FH "  csl_port reset(output,$val);\n";
    print FH "  csl_port clear(output,$val);\n"; 
    print FH "  csl_port clock(output,$val);\n";
    #print FH "  csl_port wr_addr(output,$val2);\n";
    #print FH "  csl_port rd_addr1(output,$val2);\n";
    #print FH "  csl_port rd_addr0(output,$val2);\n";
    #print FH "  csl_port data_in(output,$val1);\n"; 
    print FH "  csl_port wr_en(output,$val);\n";
    print FH "  csl_port rd_en0(output,$val);\n";
    print FH "  csl_port data_out1(input,$val1);\n"; 
    print FH "  csl_port data_out0(input,$val1);\n";
    print FH "  csl_port rd_en1(output,$val);\n";
    print FH "  csl_port data(output,$val);\n"; 
    print FH "  csl_port enable(output,$val);\n";
    print FH "  csl_port reg_out(input,$val1);\n";
    print FH "  csl_port address(output,$val);\n";
}


sub word {
    my $val = $_[0];
    my @alpha = ('a'..'z','A'..'Z','_');
    my @alphanumeric = ('a'..'z','A'..'Z','0'..'9','$','_');
    my $ret = $alpha[rand @alpha];
    for(my $i=1;$i < $val; ++$i){
        $ret = $ret.$alphanumeric[rand @alphanumeric];
    }
    return $ret;
}

sub createCslFile {
    my($test_name, $unit,$i,$it1,$it2) = @_;
    my $val = 1;
    my $val10 = 3;
    my $val1 = int(rand(20)) + 1;
    my $val2 = $val1 + int(rand(20)) + 1;
    my $val3 = int(rand(30)) + 1;
    my $val4 = int(rand(50)) + 1;
    my $val5 = int(rand(80)) + 1;
    my $val6 = int(rand(100)) + 1;
    my $val7 = int(rand(10)) + 1;
    my $val8 = int(rand(10)) + 2;
    my $val9 = int(rand(10)) + 2;
    my $word = &word($val5);
    my $word1 = &word($val8);
    my $word2 = &word($val7);
    my $word3 = &word($val6);
    my $word4 = &word($val9);
    my $word5 = &word($val2);
    my $word6 = &word($val1);
    my $word7 = &word($val3);
    &mkDir("$path/conn_units_u_mem_fifo_reg_rf_invalid1/");
    open(FH,">$path/conn_units_u_mem_fifo_reg_rf_invalid1/$test_name");
    print FH "//Generated by Petronela\n";  
    print FH "//testing cmd. connect_units for invalid connections  unit to fifo, unit to register,unit to register_file,unit to memory \n";
    print FH "//and fifo to unit, register to unit, register_file to unit, memory to unit\n\n";
    print FH "csl_$unit ua {\n";
    print FH "  ua(){\n";
    print FH "    set_width($val10);\n";
    if($unit ne "register"){
        print FH "    set_depth($val1);\n";
    }
    else{
        print FH "    set_type(register);\n";
    }   
    print FH "  }\n";
    print FH "};\n\n";
    
    print FH "csl_$unit ub {\n";
    print FH "  ub(){\n";
    print FH "    set_width($val10);\n";
    if($unit ne "register"){
        print FH "    set_depth($val1);\n";
    }
    else{
        print FH "    set_type(register);\n";
    }  
    print FH "  }\n";
    print FH "};\n\n";
    
    print FH "csl_$unit uc {\n";
    print FH "  uc(){\n";
    print FH "    set_width($val10);\n";
    if($unit ne "register"){
        print FH "    set_depth($val1);\n";
    }
    else{
        print FH "    set_type(register);\n";
    }   
    print FH "  }\n";
    print FH "};\n\n";
    
    print FH "csl_$unit ud {\n";
    print FH "  ud(){\n";
    print FH "    set_width($val10);\n";
    if($unit ne "register"){
        print FH "    set_depth($val1);\n";
    }
    else{
        print FH "    set_type(register);\n";
    }   
    print FH "  }\n";
    print FH "};\n\n";
    
    print FH "csl_$unit ue {\n";
    print FH "  ue(){\n";
    print FH "    set_width($val10);\n";
    if($unit ne "register"){
        print FH "    set_depth($val1);\n";
    }
    else{
        print FH "    set_type(register);\n";
    }   
    print FH "  }\n";
    print FH "};\n\n";
    
    print FH "csl_unit a {\n";
    #print FH "  ua ua0;\n";
    #print FH "  ua ua1;\n";
    &port();
    print FH "  a() {\n";  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    if($i >= 3){
        print FH "csl_unit f {\n";
        #print FH "  ua ua0;\n";
        #print FH "  ub ub3;\n";
        &port();
        print FH "  f() {\n";
        print FH "  }\n";        
        print FH "};\n";        
        print FH "\n";
    }
    print FH "csl_unit b {\n";  
    if($i <= 2){
        print FH "  a a0;\n";
        print FH "  a a1;\n";
        #print FH "  ub ub0;\n";
        #print FH "  ua ua1;\n";
        #print FH "  ub ub2;\n";
    }
    else {
        print FH "  f f0;\n";
        print FH "  f f1;\n";
        print FH "  a a0;\n";
        print FH "  a a1;\n";
        print FH "  a a2;\n";
        #print FH "  ua ua0;\n";
        #print FH "  ub ub0;\n";
    }
    &port();
    print FH "  b() {\n";  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";
    if($i <= 2){
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  uc uc0;\n";
    }
    else {
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  b b2;\n";
        print FH "  a a0;\n";
        print FH "  uc uc0;\n";
    }
    &port();
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
        print FH "  ua ua0;\n";
        print FH "  ub ub0;\n";
        print FH "  ud ud0;\n";
        print FH "  uc uc1;\n";
        print FH "  ub ub2;\n";
        print FH "  ue ue0;\n";
    }
    else {
        print FH "  ua ua0;\n";
        print FH "  ub ub0;\n";
        print FH "  f f0;\n";
        print FH "  f f1;\n";
        print FH "  b b0;\n";
        print FH "  b b1;\n";
        print FH "  c c0;\n";
        print FH "  c c1;\n";
        print FH "  ud ud0;\n";
        print FH "  uc uc1;\n";
        print FH "  ue ue0;\n";
    }
    #&port();
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    ub0.connect_units($it1,\"$word\");\n";
        print FH "    $it1.connect_units($it2);\n";
    }
    elsif($i > 2) {
        print FH "    $it2.connect_units($it1);\n";
        print FH "    $it2.connect_units($it1,\"$word\");\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    #print FH "csl_unit e {\n";  
    #if($i <= 2){
    #    print FH "  d d0;\n";
    #    print FH "  d d1;\n";
    #    print FH "  b b0;\n";
    #    print FH "  b b1;\n";
    #    print FH "  c c0;\n";
    #    print FH "  ue ue0;\n";
    #    print FH "  ud ud0;\n";
    #}
    #elsif($i > 2) {
    #    print FH "  d d0;\n";
    #    print FH "  d d1;\n";
    #    print FH "  c c0;\n";
    #    print FH "  c c1;\n";
    #    print FH "  c c2;\n";
    #    print FH "  ue ue0;\n";
    #    print FH "  ud ud0;\n";
    #}
    #&port();
    #print FH "  e() {\n";
    #if($i == 1) {
    #    print FH "    $it3.connect_units(b0.$it4.ua1,\"$word1\");\n";
    #    print FH "    c0.uc0.connect_units($it4);\n";
    #}
    #elsif($i == 3) {
    #    print FH "    d0.$it3.ub3.connect_units(c1.$it4,\"$word1\");\n";
    #    print FH "    d1.$it3.connect_units(c2.$it4.ua0);\n";
    #}
    #print FH "  }\n";        
    #print FH "};\n";        
    #print FH "\n";
    #
    #print FH "csl_unit top {\n";
    #if($i <=2){
    #    print FH "  d d0;\n";
    #    print FH "  d d1;\n";
    #    print FH "  d d2;\n";
    #    print FH "  e e0;\n"; 
    #    print FH "  e e1;\n"; 
    #}
    #elsif($i > 2) {
    #    print FH "  d d0;\n";
    #    print FH "  d d1;\n";
    #    print FH "  e e0;\n"; 
    #    print FH "  e e1;\n"; 
    #    print FH "  e e2;\n";
    #    print FH "  a a0;\n";
    #}
    #print FH "  top(){\n";
    #if($i == 2) {
    #    if($it3 eq "e0" || $it3 eq "e1"){
    #        print FH "    $it3.ue0.connect_units(d0.$it4);\n";
    #        print FH "    $it3.ue0.connect_units(d0.$it4.a0,\"$word2\");\n";
    #        print FH "    d2.c1.b0.a1.connect_units(e0.d0.ud0,\"$word3\");\n"; 
    #    }
    #    else {
    #        print FH "    $it3.ub2.connect_units(e0.d0.$it4);\n";
    #        print FH "    $it3.connect_units(e0.d0.$it4.a0.ua0,\"$word2\");\n";
    #        print FH "    d1.b1.ub0.connect_units(e1.c0.b0.a1,\"$word3\");\n";
    #    }
    #}
    #elsif($i >= 4) {
    #    print FH "    $it3.ud0.connect_units(e0.d0.c0.$it4,\"$word2\");\n";
    #    print FH "    a0.ua0.connect_units(d1.c1.$it4);\n";
    #    print FH "    d1.uc1.connect_units(e2.c1.a0,\"$word3\");\n";
    #}
    #print FH "  }\n";        
    #print FH "};\n";        
    #print FH "\n";

    close(FH);

}
