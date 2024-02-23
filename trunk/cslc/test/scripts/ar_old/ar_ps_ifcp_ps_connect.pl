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

my @lower = (0,3,10,23,31);
my @upper = (32,46,51,64,80);

for (my $i = 1; $i <= 5; ++$i ) {
    foreach my $l(@lower) {
        foreach my $u(@upper) { 
            &main($i,$l,$u);
        }
    }
}

sub main {
    my ($i,$l, $u) = @_;
    my $test_name = "connect_ps_ifcp_ps$i"."_".$l."_".$u."_legal.csl";
    &createCslFile($test_name,$i, $l, $u);
}

sub createCslFile {
    my($test_name, $i,$l, $u) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";
    my $w = $u - $l + 1;
    my $val1 = $u + int(rand(100)) + 1;
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $u + int(rand(60)) +1;
    &mkDir("$path/ar_ps_ifcp_ps_connect_valid");
    open(FH,">$path/ar_ps_ifcp_ps_connect_valid/$test_name");

    print FH "//Generated by Petronela\n";
    print FH "//conections port to ifc.port[part select], signal to ifc.port[part select], ifc.port[part select] to port and ifc.port[part select] to signal\n";
    print FH "//and connections  ifc.port[part select] to port[part select], ifc.port[part select] to signal[part select], port[part select] to ifc.port[part select]  and signal[part select] to ifc.port[part select] \n\n"
    print FH "csl_bitrange br($val1);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_interface ifca {\n";
    if($i <= 2 ) {
        print FH "  csl_port p_ifca$i(input,$val1);\n";
        print FH "  csl_port p_ifa(input,$val2);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "  csl_port p_ifca$i(output,$val2);\n";
        print FH "  csl_port p_ifa(output,$val1);\n";
        print FH "  csl_port p_if(output,$val2);\n";
    }
    elsif($i > 4 ) { 
        print FH "  csl_port p_ifca$i(input,$val1);\n";
        print FH "  csl_port p_ifa(input,$val2);\n";
        print FH "  csl_port p_if(input,$val1);\n";
        print FH "  csl_port p_ifta$i(input,$val2);\n";
    }
    print FH "  ifca() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_interface ifcb {\n";
    print FH "  ifca ifca0;\n";
    if($i == 1 ) {
        print FH "  csl_port p_ifcb$i(input,$val1);\n";
        print FH "  csl_port p_ifb(input,$val2);\n";
        print FH "  csl_port p_if(input,$val2);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "  csl_port p_ifcb$i(output,$val2);\n";
        print FH "  csl_port p_ifb(output,$val1);\n";
        
    }
    elsif($i > 3) {  
        print FH "  csl_port p_ifcb$i(input,$val2);\n";
        print FH "  csl_port p_ifb(input,$val1);\n";
        print FH "  csl_port p_if(input,$val2);\n";
        print FH "  csl_port p_iftb$i(input,$val1);\n";
        print FH "  csl_port p_b(input,$val2);\n";
    }
    print FH "  ifcb() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit a {\n";
    print FH "  ifca ifca1;\n";
    print FH "  ifcb ifcb0;\n";
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
    print FH "  ifca ifca1;\n";
    print FH "  ifcb ifcb0;\n";
    if($i == 1) {
        print FH "  csl_port p_b$i(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_port pb(input,$w);\n";
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
    print FH "  ifca ifca1;\n";
    print FH "  ifcb ifcb0;\n";
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
    print FH "  ifca ifca2;\n";
    print FH "  ifcb ifcb1;\n";
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
       print FH "  csl_port p_d$i(input,$w);\n";
       print FH "  csl_port p(input,$val2);\n";
       print FH "  csl_signal s_d$i($w);\n";
       print FH "  csl_signal s_d_br$i($w);\n";
       print FH "  csl_signal sd($w);\n";
    }
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    s_d$i.connect(a0.ifca1.p_ifca$i"."[$l:$u]);\n";
        print FH "    c0.ifcb0.p_ifcb".$i."[$l:$u].connect(s_d_br$i);\n";
        print FH "    p_d$i.connect(b0.ifca1.p_ifa[$l:$u]);\n";
        print FH "    a0.p_a$i"."[$l:$u].coonect(ifcb1.p_ifb[$l:$u]);\n";
        print FH "    ifcb1.p_if[$l:$u].connect(a0.sa[$l:$u]);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "    p_d$i.connect(b0.ifcb0.p_ifb[$l:$u]);\n";
        print FH "    b0.ifcb0.p_ifcb".$i."[$l:$u].connect(d.p);\n";
        print FH "    c0.ifca1.p_if[$l:$u].connect(s_a$i);\n";
        print FH "    c0.p_c$i"."[$l:$u].connect(ifca2.p_ifca$i"."[$l:$u]);\n";
        print FH "    ifcb1.p_ifb[$l:$u].connect(c0.pc[$l:$u]);\n";
    }
    elsif($i > 4) {
        print FH "    s_d$i.connect(a0.ifcb0.p_b[$l:$u]);\n";
        print FH "    c0.ifca1.p_ifca$i"."[$l:$u].connect(p_d$i);\n";
        print FH "    b0.s_b$i"."[$l:$u].connect(ifca2.if[$l:$u]);\n";
        print FH "    ifcb1.p_ifcb$i"."[$l:$u].connect(b0.sb[$l:$u]);\n";
    }
    
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    

    print FH "csl_unit e {\n";  
    print FH "  a a0;\n";
    print FH "  b b0;\n";
    print FH "  c c0;\n";
    print FH "  ifca ifca3;\n";
    print FH "  ifcb ifcb2;\n";
    if($i == 1 ) {
        print FH "  csl_port p_e$i(input,$val1);\n"; 
        print FH "  csl_port p_e_br$i(input,br);\n";   
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_e$i($w);\n";
        print FH "  csl_signal se($w);\n";
        print FH "  csl_signal s_e_br$i($w);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_port p_e$i(output,$w);\n";    
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
        print FH "    s_e_br$i.connect(a0.ifca1.p_ifca$i"."[$l:$u]);\n";
        print FH "    b0.ifcb0.p_ifb[$l:$u].connect(s_e$i);\n";
        print FH "    b0.pb.connect(ifca3.p_ifa[$l:$u]);\n";
        print FH "    ifcb2p_ifcb$i"."[$l:$u].connect(a0.pa[$l:$u]);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "    p_e$i.connect(c0.ifcb0.p_ifcb$i"."[$l:$u]);\n";
        print FH "    s_e_br$i.connect(b0.ifcb0.p_ifb[$l:$u]);\n";
        print FH "    c0.s_c$i"."[$l:$u].connect(ifca3.p_ifa);\n";
        print FH "    ifca3.p_ifca$i"."[$l:$u].connect(c0.p[$l:$u]);\n";
    }
    elsif($i > 3) {
        print FH "    ifcb2.p_iftb$i"."[$l:$u].connect(s_b_br$i);\n";
        print FH "    p_e$i.connect(a0.ifca1.p_ifa[$l:$u]);\n";
        print FH "    ifca3.p_if[$l:$u].connect(c0.sc[$l:$u]);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    print FH "  d d0;\n";
    print FH "  e e0;\n"; 
    print FH "  ifca ifca4;\n";
    print FH "  ifcb ifcb3;\n";
    if($i <= 2) {
        print FH "  csl_port ptop(input,$w);\n";
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
        print FH "  csl_port p_top$i(input,$w);\n";      
        print FH "  csl_port p(input,$w);\n";
        print FH "  csl_port p_top_br$i(input,br);\n";
        print FH "  csl_signal s_top$i($w);\n";
        print FH "  csl_signal s_top_br$i(br);\n";
        print FH "  csl_signal stop($w);\n";
    }
    
    print FH "  top(){\n";
    if($i <= 2) {
        print FH "    stop.connect(d0.a0.ifca1.p_ifca$i"."[$l:$u]);\n";
        print FH "    s_top$i.connect(e0.c0.ifcb0.p_ifb[$l:$u]);\n";
        print FH "    d0.ifca2.p_ifa[$l:$u].connect(ptop);\n";
        print FH "    ifcb3.p_if[$l:$u].connect(e0.a0.sa[$l:$u]);\n";
    }
    elsif($i == 3) {
        print FH "    e0.a0.ifcb0.p_ifcb$i"."[$l:$u].connect(s_top$i);\n";
        print FH "    stop.connect(d0.b0.ifca1.p_ifca$i"."[$l:$u]);\n";
        print FH "    ifca4.p_ifa[$l:$u].connect(e0.b0.s_b$i);\n";
        print FH "    d0.b0.pb[$l:$u].connect(ifcb3.p_ifb[$l:$u]);\n";
    }
    elsif($i > 3) {
        print FH "    p_top_br$i.connect(e0.ifcb2.p_b[$l:$u]);\n";
        print FH "    p_top_br$i.connect(e0.ifca3.p_ifca$i"."[$l:$u]);\n";
        print FH "    d0.a0.ifcb0.p_iftb$i"."[$l:$u].connect(stop);\n";
        print FH "    d0.b0.sb[$l:$u].connect(ifca4.ifa[$l:$u]);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
