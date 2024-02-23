#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for generated tests is : $path"."conn_units_s_sps_invalid/ \n";

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

my @lower = (0,3,9,23,32);
my @upper = (35,49,53,69,90);

for (my $i = 1; $i <= 5; ++$i ) {
    foreach my $l(@lower) {
        foreach my $u(@upper) { 
            &main($i,$l,$u);
        }
    }
}

sub main {
    my ($i,$l, $u) = @_;
    my $test_name = "connect_units_s_sps$i"."_".$l."_".$u."_illegal.csl";
    &createCslFile($test_name,$i, $l, $u);
}

sub createCslFile {
    my($test_name, $i,$l, $u) = @_;
    my $val1 = $u + int(rand(100)) + 1;
    my $w = $u - $l + 1;
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $val1 + int(rand(50)) + 1;
    &mkDir("$path/conn_units_s_sps_invalid");
    open(FH,">$path/conn_units_s_sps_invalid/$test_name");

    print FH "//Generated by Petronela\n";
    print FH "//testing the methos connect_units for signal to signal[part select],signal[part select] to signal and signal[part select] to signal[part select]\n\n";
    print FH "csl_bitrange br($w);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_unit a {\n";
    if($i <= 2) {
        print FH "  csl_signal s($val1);\n"; 
        print FH "  csl_signal s_a_br$i(br);\n";
        print FH "  csl_signal sa($val1);\n";
        print FH "  csl_signal s_a$i($val3);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "  csl_signal s($w);\n";
        print FH "  csl_signal s_a$i($val1);\n";
        print FH "  csl_signal s_a_br$i($val2);\n";
    }
    elsif($i > 4) {
        print FH "  csl_signal s_a$i($val3);\n";
        print FH "  csl_signal s_a_br$i($val1);\n";
        print FH "  csl_signal sa($w);\n";
    }
    print FH "  a() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit b {\n";  
    if($i == 1) {
        print FH "  csl_signal s_b$i($val1);\n";
        print FH "  csl_signal s($val1);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_signal s_b$i($val2);\n";
        print FH "  csl_signal sb($val2);\n";
        print FH "  csl_signal s_b_br$i(brt);\n";
        print FH "  csl_signal s($val1);\n";
    }
    elsif($i > 3 ) {      
        print FH "  csl_signal s_b$i($val1);\n";
        print FH "  csl_signal s_b_br$i(br);\n";
        print FH "  csl_signal s($val1);\n";
    }
    print FH "  b() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_unit c {\n";  
    if($i <= 3) {
        print FH "  csl_signal s_c$i($val1);\n";
        print FH "  csl_signal sc($val1);\n";
        print FH "  csl_signal s_c_br$i(br);\n";
        print FH "  csl_signal s($val1);\n";
    }
    elsif($i == 4) {      
        print FH "  csl_signal s_c$i($val2);\n";
        print FH "  csl_signal s($val2);\n";
    }
    elsif($i == 5) {  
        print FH "  csl_signal s_c$i($val3);\n";
        print FH "  csl_signal sc($val1);\n";
        print FH "  csl_signal s($w);\n";
        print FH "  csl_signal s_c_br$i(br);\n";
    }
    print FH "  c() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
     print FH "csl_unit d {\n";  
    print FH "  a a0;\n";
    print FH "  b b0;\n";
    print FH "  c c0;\n"; 
    if($i <= 2) {
        print FH "  csl_signal s_d$i($val1);\n"; 
        print FH "  csl_signal s_d_br$i(br);\n";
        print FH "  csl_signal s($val2);\n";
    }
    elsif($i > 2 && $i <= 4) {      
        print FH "  csl_signal s_d$i($val2);\n";
        print FH "  csl_signal s($val2);\n";
        print FH "  csl_signal sd($val1);\n";
    }
    elsif($i > 4) {      
       print FH "  csl_signal s_d$i($val1);\n";
       print FH "  csl_signal s($w);\n";
    }
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    s_d$i"."[$u:$l].connect_units(s_a_br$i);\n";
        print FH "    s_d_br$i.connect_units(c0.sc[$u-:$l);\n";
        print FH "    s[$u:$l].connect_units(s_c_br$i"."[$u:$l]);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "    s_d$i"."[$u:$l].connect_units(a0.s_a$i"."[$u:$l]);\n";
        print FH "    s[$u:$l].connect_units(b0.s_b$i);\n";
    }
    elsif($i > 4) {
        print FH "    s.connect_units(sc[$u:$l]);\n";
        print FH "    a0.sa[$u-:$l].connect_units(s_d$i"."[$u-:$l]);\n";
    }
    
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    print FH "csl_unit e {\n";  
    print FH "  a a0;\n";
    print FH "  b b0;\n";
    print FH "  c c0;\n";
    if($i == 1) {
        print FH "  csl_signal s_e$i($val3);\n"; 
        print FH "  csl_signal s_e_br$i(br);\n";   
        print FH "  csl_signal s($val2);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_signal s_e$i($w);\n";    
        print FH "  csl_signal s($val1);\n";
        print FH "  csl_signal s_e_br$i(brt);\n";
    }
    elsif($i > 3) {      
        print FH "  csl_signal s_e$i($val1);\n";
        print FH "  csl_signal s($val3);\n";
        print FH "  csl_signal se($val2);\n";
    }
    print FH "  e() {\n";
    if($i == 1) {
        print FH "    s_e_br$i.connect_units(a0.sa[$u:$l]);\n";
        print FH "    s_e$i"."[$u:$l].connect_units(b0.s);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "    s_e$i.connect_units(b0.sb[$u:$l]);\n";
        print FH "    b0.s_b$i.connect_units(s_a$i"."[$u:$l]);\n";
    }
    elsif($i > 3) {
        print FH "    s_e$i"."[$u:$l].connect_units(a0.s_a_br$i"."[$u:$l]);\n";
        print FH "    s_c$i"."[$u:$l].connect_units(se[$u:$l])";
        print FH "    s[$u-:$l].connect_units(s_b_br$i);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_unit top {\n";
    print FH "  d d0;\n";
    print FH "  e e0;\n"; 
    if($i <= 2) {
        print FH "  csl_signal stop($val2);\n";
        print FH "  csl_signal s($w);\n";
    }
    elsif($i == 3) {
        print FH "  csl_signal s_top$i($w);\n";      
        print FH "  csl_signal s($val3);\n";
        print FH "  csl_signal stop($val2);\n";
    }
    elsif($i > 3) {
        print FH "  csl_signal s_top$i($val3);\n";      
        print FH "  csl_signal s($val2);\n";
        print FH "  csl_signal s_top_br$i(br);\n";
    }
    
    print FH "  top(){\n";
    if($i <= 2) {
        print FH "    stop[$u:$l].connect_units(d0.a0.s_a$i"."[$u:$l]);\n";
        print FH "    s.connect_units(s_d$i"."[$u:$l]);\n";
    }
    elsif($i == 3) {
        print FH "    s_top$i.connect_units(e0.a0.s_a$i"."[$u:$l]);\n";
        print FH "    d0.b0.s[$u-:$l].connect_units(e0.s_e$i);\n";
        print FH "    stop[$u:$l].connect_units(d0.c0.sc[$u:$l]);\n";
    }
    elsif($i > 3) {
        print FH "    s_top_br$i"."[$u:$l].connect_units(d0.a0.s_a_br$i"."[$u:$l]);\n";
        print FH "    s[$u-:$l].connect_units(e0.a0.s_a$i);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
