#!/usr/bin/perl

#Author Petronela
#modified by oanab
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

foreach(my $i = 1; $i <= 20; $i++) {    
    my @map1 = ("s_a$i","sg","s_b$i","sb","s_c$i","sc");
    my @map2 = ("s_a$i","sg","s_b$i","sb","s_d$i");
    my @map3 = ("s_a$i","sg","s_b$i","sb","s_c$i","sc","s_d$i","s_top$i");
    my $var;
    if($i <= 5) {
        foreach my $it1 (@map1) {
            $var = $it1; 
            &main($i,$var,$it1);
        }
    }
    elsif($i > 5 && $i <= 10 ) {
        foreach my $it1(@map2) {
            $var = $it1; 
            &main($i,$var,$it1);
        }
    }
    else {
        foreach my $it1(@map3) {
            $var = $it1; 
            &main($i,$var,$it1);
        }
    }
}

sub main {
    my ($i,$var,$it1) = @_;
    my $test_name;
    $test_name = "ar_conn_name_ps_sp".$i."_".$it1."_legal.csl";
   
    &createCslFile($test_name, $i,$var);
}

sub createCslFile {
    my($test_name, $i, $var) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    my $val1 = int(rand(100))+1;
    my $val2 = int(rand(100))+1;
    my $val3 = int(rand(100))+1;
    
    &mkDir("$path/ar_conn_name_ps_sp_valid");
    open(FH,">$path/ar_conn_name_ps_sp_valid/$test_name");
   
    print FH "//Generated by Petronela\n";
    print FH "//connections port to signal and signal to port\n\n";
    print FH "csl_bitrange br($val1);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_unit a {\n";
    if($i <= 10) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
#        print FH "  csl_signal s_a$i($val1);\n";
    }
    elsif($i > 10 && $i <= 15) {
	print FH "  csl_port pt(input,$val2);\n";
        print FH "  csl_signal sg($val2);\n";
    }
    elsif($i > 15 && $i <= 20) {
	print FH "  csl_port p_a$i(output,$val2);\n"; 
#        print FH "  csl_signal sg($val2);\n";
    }
    print FH "  a() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit b {\n";
    if($i <= 10) {
        print FH "  csl_port p_b$i(input,$val1);\n"; 
        print FH "  csl_signal s_b$i($val1);\n";
    }
    elsif($i > 10 && $i <= 15) {
	print FH "  csl_port pt(input,$val2);\n";
#        print FH "  csl_signal sb($val2);\n";
    }
    elsif($i > 15 && $i <= 20) {
	print FH "  csl_signal s_b$i($val2);\n"; 
        print FH "  csl_port p_b$i(output,brt);\n";
	print FH "  csl_signal sb($val2);\n";
    }
    print FH "  b() {\n"; 
    if($i > 15 && $i <= 20) {
	print FH "    s_b$i = sb;\n";
    } 
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";


    print FH "csl_unit c {\n";  
    if($i <= 10) {
	print FH "  a a0;\n";
	print FH "  b b0;\n";
#        print FH "  csl_port p_c$i(input,$val2);\n"; 
        print FH "  csl_signal s_c$i($val1);\n";
    }
    elsif($i > 10 && $i <= 15) {  
	print FH "  a a0;\n";
	print FH "  b b0;\n";
	print FH "  csl_port pt(input,brt);\n";
        print FH "  csl_port p_c$i(input,$val2);\n";
    }
    elsif($i > 15 && $i <= 20) {
	print FH "  a a0;\n";
	print FH "  b b0;\n";
	print FH "  csl_port p_c$i(input,$val2);\n";
        print FH "  csl_signal s_c$i($val2);\n";
        print FH "  csl_signal sc(brt);\n";
    }
    print FH "  c() {\n";
    if($i <= 10) {
        print FH "    b0.p_b$i.connect_by_name(s_c$i);\n";
	print FH "    b0.s_b$i.connect_by_name(a0.p_a$i);\n";
    }
    elsif($i > 10 && $i <= 15) {
	print FH "    a0.sg.connect_by_name(p_c$i);\n";
	print FH "    pt.connect_by_name(b0.pt);\n";
               
    }
    elsif($i > 15 && $i <= 20) {
        print FH "    a0.p_a$i.connect_by_name(s_c$i);\n";
        print FH "    sc.connect_by_name(b0.p_b$i);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit d {\n";  
    if($i <= 10) {
	print FH "  csl_port pt(input,$val2);\n";
#        print FH "  csl_signal s_d$i($val1);\n";
    }
    elsif($i > 10 && $i <= 15) { 
        print FH "  csl_port p_d$i(output,$val2);\n";
#        print FH "  csl_signal s_d$i($val2);\n";
    }
    elsif($i > 15 && $i <= 20) {
	print FH "  a a1;\n";
	print FH "  b b1(.p_b$i(s_d$i));\n";
	print FH "  csl_port pt(input,$val2);\n";
        print FH "  csl_signal s_d$i($val2);\n";
    }
    print FH "  d() {\n";
    if($i > 15 && $i <= 20 ) {
        print FH "    pt.connect_by_name(b1.s_b$i);\n";
        print FH "    b1.sb.connect_by_name(pt);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_unit top {\n";
    if($i <= 10) {
	print FH "  c c0;\n";
	print FH "  d d0;\n";
	print FH "  csl_port pt(input,$val2);\n";
#        print FH "  csl_signal s_top$i($val2);\n";
    }
    elsif($i > 10 && $i <= 15) { 
	print FH "  c c0(.pt(s_top$i),.p_c$i(s_top$i));\n";
	print FH "  d d0;\n";
#	print FH "  csl_port pt(input,$val2);\n";
	print FH "  csl_port p_top$i(input,$val2);\n";      
        print FH "  csl_signal s_top$i($val2);\n";
    }
    elsif($i > 15 && $i <= 20) {
	print FH "  c c0;\n";
	print FH "  d d0(.pt(pt));\n";
	print FH "  csl_port pt(input,$val2);\n";
#        print FH "  csl_port p_top".$i."(output,$val2);\n";
        print FH "  csl_signal s_a$i($val2);\n";
    }
    print FH "  top(){\n";
    if($i <= 10) {
	print FH "    d0.pt.connect_by_name(pt);\n";
    }
    elsif($i > 10 && $i <= 15) {
        print FH "    c0.a0.pt.connect_by_name(p_top$i);\n";
	print FH "    d0.p_d$i.connect_by_name(s_top$i);\n";
    }
    elsif($i > 15 && $i <= 20) {
        print FH "    d0.a1.p_a$i.connect_by_name(s_a$i);\n";
        print FH "    s_a$i.connect_by_name(c0.p_c$i);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
