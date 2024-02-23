#!/usr/bin/perl

#Author Anamaria
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

foreach(my $i = 1; $i <= 50; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my $test_name = "connect_ifc_p_ps_ifc_p".$i."_legal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";
    my $val1 = 300;
    my $val2 = 500;
    my $val3 = 250;
  
    if($test_name=~/(_legal)/){
        &mkDir("$path/ifc_p_ps_ifc_p_ar_connect_valid");
        open(FH,">$path/ifc_p_ps_ifc_p_ar_connect_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/){
        &mkDir("$path/ifc_p_ps_ifc_p_ar_connect_invalid");
        open(FH,">$path/ifc_p_ps_ifc_p_ar_connect_invalid/$test_name");
    }
    print FH "//Generated by Anamaria\n";
    print FH "//Connect Ifc.Port.Ps--Ifc.Port\n\n";
    print FH "csl_bitrange br1($val2);\n";
    print FH "csl_bitrange br2($val3);\n";


    print FH "csl_interface ifc1 {\n";
    if($i <= 10) {
        print FH "  csl_port p_a_br1$i(input,br1);\n"; 
    }
    elsif($i > 10 && $i <= 20) {
        print FH "  csl_port p_a$i(output,$val2);\n"; 
    }
    elsif($i > 20 && $i <= 30) {
        print FH "  csl_port p_a$i(input,$val2);\n";
        print FH "  csl_port p_a_br2$i(output,br2);\n"; 
    }
    elsif($i > 30 && $i <= 40) {
        print FH "  csl_port p_a$i(output,$val3);\n";
    }
    elsif($i > 40 && $i <= 50) {
        print FH "  csl_port p_a$i(output,$val1);\n"; 
        print FH "  csl_port p_a_br1$i(output,br1);\n";
    }
    print FH "  ifc1() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";


    print FH "csl_unit unit_a {\n";  
    print FH "  ifc1 ifc_a0;\n";
    print FH " unit_a(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";
   
    print FH "csl_interface ifc2 {\n";

    if($i <= 10) {
        print FH "  csl_port p_b_br1$i(output,br2);\n"; 
    }
    elsif($i > 10 && $i <= 20) {      
        print FH "  csl_port p_b$i(input,$val1);\n";
    }
    elsif($i > 20 && $i <= 30) {
        print FH "  csl_port p_b_br2$i(input,br1);\n";
        print FH "  csl_port p_b$i(output,$val1);\n";
    }
    elsif($i > 30 && $i <= 40) {      
        print FH "  csl_port p_b$i(input,$val1);\n";
    }
    elsif($i > 40 && $i <= 50) {      
        print FH "  csl_port p_b$i(input, $val3);\n";     
        print FH "  csl_port p_b_br1$i(input,br2);\n";
    }
    print FH "  ifc2() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_unit unit_b {\n";
    print FH "  ifc2 ifc_b0;\n";  
    print FH "  unit_a a0;\n";
    print FH "  unit_a a1;\n";
    print FH "  unit_b(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";

    print FH "csl_unit unit_c {\n";  
    print FH "  unit_b b0;\n";
    print FH "  unit_c(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";

    print FH "csl_unit unit_top {\n";  
    print FH "  unit_b b1;\n";
    print FH "  unit_c c0;\n";
    print FH "  unit_top() {\n";
    if($i <= 10) {
        print FH "    b1.a1.ifc_a0.p_a_br1_$i [20:269].connect(b1.ifc_b0.p_b_br1$i);\n";
    }
    elsif($i > 40 && $i <= 50) {
        print FH "   c0.b0.a0.ifc_a0.p_a_br1_$i [51:300].connect(b1.ifc_b0.p_b_br1$i);\n";
        print FH "   b1.a1.ifc_a0.p_a_$i [5:254].connect(b1.ifc_b0.p_b$i);\n";
    }
  
    if($i > 10 && $i <= 20) {
        print FH "    b1.a1.ifc_a0.p_a_$i [1:300].connect(c0.b0.ifc_b0.p_b$i);\n";
    }
    elsif($i > 20 && $i <= 30) {
        print FH "    b1.a0.ifc_a0.p_a_$i [100:399].connect(c0.b0.ifc_b0.p_b$i);\n";
        print FH "    c0.b0.ifc_b0.p_b_br2_$i [200:449].connect(b1.a1.ifc_a0.p_a_br2$i);\n";
    }
    elsif($i > 30 && $i <= 40) {
        print FH "    b1.ifc_b0.p_b_$i [10:259].connect(c0.b0.a1.ifc_a0.p_a$i);\n";
    }
   
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
