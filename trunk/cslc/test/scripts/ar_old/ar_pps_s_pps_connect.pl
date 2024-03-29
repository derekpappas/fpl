#!/usr/bin/perl

#Author Petronela
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

my @lower = (0,5,9,17,29);
my @upper = (33,44,53,68,82);

for (my $i = 1; $i <= 5; ++$i ) {
    foreach my $l(@lower) {
        foreach my $u(@upper) { 
            &main($i,$l,$u);
        }
    }
}

sub main {
    my ($i,$l, $u) = @_;
    my $test_name = "connect_unit_pps_s_pps$i"."_".$l."_".$u."_legal.csl";
    &createCslFile($test_name,$i, $l, $u);
}

sub createCslFile {
    my($test_name, $i,$l, $u) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";
    my $val1 = $u + int(rand(100)) + 1;
    my $w = $u - $l + 1;
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $val1 + int(rand(100)) + 1;
    &mkDir("$path/ar_pps_s_pps_connect_valid");
    open(FH,">$path/ar_pps_s_pps_connect_valid/$test_name");

    print FH "//Generated by Petronela\n";
    print FH "//connections port[part select] to signal and signal to port[part select]\n\n";
    print FH "csl_bitrange br($w);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_unit a {\n";
    if($i <= 2) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
        print FH "  csl_port pa(input,$val2);\n";
        print FH "  csl_signal sa($val1);\n";
        print FH "  csl_signal s_a$i($w);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "  csl_port p_a$i(output,$val2);\n"; 
        print FH "  csl_port pa(input,$val1);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal s_a$i($w);\n";
        print FH "  csl_signal s_a_br$i(brt);\n";
    }
    elsif($i > 4) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
        print FH "  csl_port p_a_br$i(input,brt);\n";
        print FH "  csl_port pa(input,$val2);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_a$i($val3);\n";
        print FH "  csl_signal sa($val2);\n";
    }
    print FH "  a() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    print FH "csl_unit b {\n";  
    if($i == 1) {
        print FH "  csl_port p_b$i(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_b_br$i($val2);\n";
        print FH "  csl_signal s_b$i($val3);\n";
        print FH "  csl_signal sb($val1);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_port p_b$i(output,$val1);\n";
        print FH "  csl_port pb(output,$val3);\n";
        print FH "  csl_port p_b_br$i(output,brt);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal s_b$i($w);\n";
        
    }
    elsif($i > 3) {      
        print FH "  csl_port p_b$i(output,$val1);\n";
        print FH "  csl_port p_b_br$i(input,brt);\n";
        print FH "  csl_port p(input,$val3);\n";
        print FH "  csl_signal s_b$i($val2);\n";
        print FH "  csl_signal s_b_br$i(br);\n";
        print FH "  csl_signal sb($val3);\n";
    }
    print FH "  b() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";  
    if($i <= 3) {
        print FH "  csl_port p_c$i(input,$val2);\n";
        print FH "  csl_port pc(input,$val1);\n";
        print FH "  csl_port p_c_br$i(output,brt);\n";
        print FH "  csl_port p(input,$val3);\n";
        print FH "  csl_signal s_c$i($val2);\n";
    }
    elsif($i == 4) {      
        print FH "  csl_port p_c$i(output,$val2);\n";
        print FH "  csl_port p(output,$val3);\n";
        print FH "  csl_port pc(input,$val1);\n";
        print FH "  csl_signal sc($val3);\n";
        print FH "  csl_signal s_c_br$i(brt);\n";
        print FH "  csl_signal s_c$i($val2);\n";
    }
    elsif($i == 5) {      
        print FH "  csl_port pc(input,$val1);\n";
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_port p_c_br$i(input,brt);\n";
        print FH "  csl_signal s_c$i($val3);\n";
        print FH "  csl_signal sc($val2);\n";
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
        print FH "  csl_port p_d$i(input,$val1);\n"; 
        print FH "  csl_port p_d_br$i(input,br);\n";
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_d_br$i($w);\n";
        print FH "  csl_signal s_d$i($w);\n";
    }
    elsif($i > 2 && $i <= 4) {      
        print FH "  csl_port p_d$i(input,$w);\n";
        print FH "  csl_port p(output,$w);\n";
        print FH "  csl_port pd(output,$val2);\n";
        print FH "  csl_signal s_d$i($w);\n";
    }
    elsif($i > 4) {      
       print FH "  csl_port p_d$i(input,$val1);\n";
       print FH "  csl_port p(input,$val2);\n";
       print FH "  csl_signal s_d$i($w);\n";
       print FH "  csl_signal s_d_br$i($w);\n";
       print FH "  csl_signal sd($w);\n";
    }
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    s_d$i.connect(p_a".$i."[$l:$u]);\n";
        print FH "    c0.p_c".$i."[$l:$u].connect(s_d_br$i);\n";
        print FH "    p_d$i"."[$l:$u].connect(s_a$i);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "    s_d$i.connect(pc[$l:$u]);\n";
        print FH "    b0.p_b".$i."[$l:$u].connect(s_d$i);\n";
        print FH "    pd[$l:$u].connect(s_a$i);\n";
    }
    elsif($i > 4) {
        print FH "    s_d$i.connect(a0.p[$l:$u]);\n";
        print FH "    c0.pc[$l:$u].connect(sd);\n";
    }
    
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    

    print FH "csl_unit e {\n";  
    print FH "  a a0;\n";
    print FH "  b b0;\n";
    print FH "  c c0;\n";
    if($i == 1 ) {
        print FH "  csl_port p_e$i(input,$val1);\n"; 
        print FH "  csl_port p_e_br$i(input,br);\n";   
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_e$i($w);\n";
        print FH "  csl_signal se($w);\n";
        print FH "  csl_signal s_e_br$i($w);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_port p_e$i(output,$val1);\n";    
        print FH "  csl_port p(output,$val3);\n";
        print FH "  csl_port p_e_br$i(output,br);\n";
        print FH "  csl_signal s_e$i($w);\n";
        print FH "  csl_signal s_e_br$i($val1);\n";
    }
    elsif($i > 3) {      
        print FH "  csl_port p_e$i(input,$w);\n";
        print FH "  csl_port p(input,$val3);\n";
        print FH "  csl_port pe(input,$w);\n";
        print FH "  csl_signal se($w);\n";
    }
    print FH "  e() {\n";
    if($i == 1) {
        print FH "    s_e_br$i.connect(a0.pa[$l:$u]);\n";
        print FH "    b0.p[$l:$u].connect(s_e$i);\n";
        print FH "    b0.p[$l:$u].connect(s_e_br$i);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "    s_e$i.connect(c0.p[$l:$u]);\n";
        print FH "    s_e_br$i.connect(b0.p_b$i"."[$l:$u]);\n";
    }
    elsif($i > 3) {
        print FH "    p[$l:$u].connect(s_b_br$i);\n";
        print FH "    se.connect(a0.p_a_br$i"."[$l:$u]);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    print FH "  d d0;\n";
    print FH "  e e0;\n"; 
    if($i <= 2) {
        print FH "  csl_port ptop(input,$val1);\n";
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_top$i($w);\n";
        print FH "  csl_signal stop($w);\n";
    }
    elsif($i == 3) {
        print FH "  csl_port p_top$i(output,$val3);\n";      
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_port ptop(output,$val1);\n"; 
        print FH "  csl_signal stop($w);\n";
        print FH "  csl_signal s_top$i($w);\n";
    }
    elsif($i > 3) {
        print FH "  csl_port p_top$i(input,$val2);\n";      
        print FH "  csl_port p(input,$val3);\n";
        print FH "  csl_port p_top_br(input,br);\n";
        print FH "  csl_signal s_top$i($w);\n";
        print FH "  csl_signal s_top_br$i(br);\n";
        print FH "  csl_signal stop($w);\n";
    }
    
    print FH "  top(){\n";
    if($i <= 2) {
        print FH "    stop.connect(d0.a0.p_a$i"."[$l:$u]);\n";
        print FH "    s_top$i.connect(e0.c0.p_c$i"."[$l:$u]);\n";
        print FH "    d0.p_d_br$i"."[$l:$u].connect(e0.a0.s_a$i);\n";
    }
    elsif($i == 3) {
        print FH "    s_top$i.connect(e0.a0.p_a$i"."[$l:$u]);\n";
        print FH "    stop.connect(d0.b0.p_b$i"."[$l:$u]);\n";
        print FH "    p[$l:$u].connect(e0.b0.s_b$i);\n";
    }
    elsif($i > 3) {
        print FH "    s_top_br$i.connect(e0.p_e$i"."[$l:$u]);\n";
        print FH "    s_top_br$i.connect(e0.p[$l:$u]);\n";
        print FH "    d0.a0.pa[$l:$u].connect(stop);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
