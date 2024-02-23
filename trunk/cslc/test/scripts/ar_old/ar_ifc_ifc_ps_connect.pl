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
    my $test_name = "connect_ifc_p_ifc_p_ps".$i."_legal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";

    my $val1 = 200;
    my $val2 = 150;
    my $val3 = 8;
   

    if($test_name=~/(_legal)/){
        &mkDir("$path/ifc_p_ifc_p_ps_ar_connect_valid");
        open(FH,">$path/ifc_p_ifc_p_ps_ar_connect_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/ifc_p_ifc_p_ps_ar_connect_invalid"); 
        open(FH,">$path/ifc_p_ifc_p_ps_ar_connect_invalid/$test_name");
    }

    print FH "//Generated by Anamaria\n";
    print FH "//Connect Ifc.Port--Ifc.Port.Ps\n\n";
   

    print FH "csl_interface ifc1 {\n";
    if($i <= 10) {
        print FH "  csl_port p_a$i(input,$val2);\n";  
        print FH "  csl_port p_aa$i(output,$val3);\n"; 
    }
    elsif($i > 10 && $i <= 20) {
        print FH "  csl_port p_a$i(output,$val3);\n"; 
    }
    elsif($i > 20 && $i <= 30) {
        print FH "  csl_port p_a$i(input,$val2);\n";
    }
    elsif($i > 30 && $i <= 40) {
        print FH "  csl_port p_a$i(output,$val2);\n";
    }
    elsif($i > 40 && $i <= 50) {
        print FH "  csl_port p_a$i(input,$val2);\n"; 
        print FH "  csl_port p_aa$i(input,$val1);\n";
    }
    print FH "  ifc1() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";


    print FH "csl_unit unit_a {\n";  
    print FH "  ifc1 ifc_a0;\n";
    print FH "  unit_a(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";
   
    print FH "csl_interface ifc2 {\n";

    if($i <= 10) {
        print FH "  csl_port p_b$i(output,$val1);\n"; 
        print FH "  csl_port p_bb$i(input,$val2);\n";
    }
    elsif($i > 10 && $i <= 20) { 
        print FH "  csl_port p_b$i(input, $val2);\n";        
    }
    elsif($i > 20 && $i <= 30) {
        print FH "  csl_port p_b$i(output,$val1);\n";
    }
    elsif($i > 30 && $i <= 40) {      
        print FH "  csl_port p_b$i(input,$val1);\n";
        print FH "  csl_port p_bb$i(output,$val3);\n";
    }
    elsif($i > 40 && $i <= 50) {      
         print FH "  csl_port p_b$i(output,$val2);\n";
         print FH "  csl_port p_bb$i(output,$val3);\n";
    }
    print FH "  ifc2() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_unit unit_b {\n";
    print FH "  unit_a a0;\n";
    print FH "  unit_a a1;\n";
    print FH "  unit_b(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";

    print FH "csl_unit unit_c {\n";  
    print FH "  ifc2 ifc_b0;\n";  
    print FH "  unit_b b0;\n";
    print FH "  unit_c(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";

    print FH "csl_unit unit_top {\n";  
    print FH "  unit_a a2;\n";
    print FH "  unit_c c0;\n";
    print FH "  unit_b b1;\n";
    print FH "  unit_top() {\n";
    if($i <= 10) {
        print FH "    a2.ifc_a0.p_a$i.connect(c0.ifc_b0.p_b_$i [1:150]);\n";
        print FH "    a2.ifc_a0.p_aa$i.connect(c0.ifc_b0.p_bb_$i [100:107]);\n";
    }
    elsif($i > 40 && $i <= 50) {
        print FH "   c0.ifc_b0.p_bb$i.connect(b1.a1.ifc_a0.p_aa_$i [5:12]);\n";
        print FH "   c0.ifc_b0.p_b$i.connect(b1.a0.ifc_a0.p_aa_$i [133:140]);\n";
        print FH "   a2.ifc_a0.p_a$i.connect(b1.a0.ifc_a0.p_aa_$i [11:160]);\n";
    }
  
    if($i > 10 && $i <= 20) {
        print FH "    a2.ifc_a0.p_a$i.connect(c0.ifc_b0.p_b_$i [55:62]);\n";
    }
    elsif($i > 20 && $i <= 30) {
        print FH "    b1.a0.ifc_a0.p_a$i.connect(c0.ifc_b0.p_b_$i [30:179]);\n";    
    }
    elsif($i > 30 && $i <= 40) {
	print FH "   b1.ifc_b0.p_bb$i.connect(a2.ifc_a0.p_a_$i [100:107]);\n";
        print FH "   c0.b0.a1.ifc_a0.p_a$i.connect(b1.ifc_b0.p_b_$i [19:168]);\n";  
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
