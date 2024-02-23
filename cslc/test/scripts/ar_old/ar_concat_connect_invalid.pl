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

my @lower = (0,4,8,16,28);
my @upper = (43,55,63,77,93);

for (my $i = 1; $i <= 5; ++$i ) {
    foreach my $l(@lower) {
        foreach my $u(@upper) { 
            &main($i,$l,$u);
        }
    }
}

sub main {
    my ($i,$l, $u) = @_;
    my $test_name = "connect_concat_connect$i"."_".$l."_".$u."_illegal.csl";
    &createCslFile($test_name,$i, $l, $u);
}

sub createCslFile {
    my($test_name, $i,$l, $u) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";
    my $w = $u - $l + 1;
    my $val1 = int(rand($w)) + 1;
    my $val2 = int(rand($w)) + 1;
    my $val3 = $w - $val1;
    my $val4 = $w - $val2;
    my $val5 = int(rand($w/3)) + 1;
    my $val6 = int(rand($w/3)) + 1;
    my $val7 = $w - $val5 - $val6;
    my $val8 = $u + int(rand(50)) + 1;
    my $val9 = $u + int(rand(50)) + 1;
    &mkDir("$path/ar_concat_connect_invalid");
    open(FH,">$path/ar_concat_connect_invalid/$test_name");

    print FH "csl_bitrange br($w);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_unit a {\n";
    if($i <= 2) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
        print FH "  csl_port pa(input,$val3);\n";
        print FH "  csl_port p_a_br$i(input,brt);\n";
        print FH "  csl_port p(input,$val4);\n";
        print FH "  csl_signal sa($val2);\n";
        print FH "  csl_signal s_a$i($val4);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "  csl_port p_a$i(output,$val6);\n"; 
        print FH "  csl_port pa(input,$val5);\n";
        print FH "  csl_port p(output,$val7);\n";
        print FH "  csl_signal s_a$i($val4);\n";
        print FH "  csl_signal s_a_br$i(brt);\n";
        print FH "  csl_signal sa($val2);\n";
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
        print FH "  csl_port p(input,$val3);\n";
        print FH "  csl_port pb(input,$val8);\n";
        print FH "  csl_signal s_b_br$i($val5);\n";
        print FH "  csl_signal s_b$i($val7);\n";
        print FH "  csl_signal sb($val6);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_port p_b$i(output,$val8);\n";
        print FH "  csl_port pb(output,$val4);\n";
        print FH "  csl_port p_b_br$i(output,brt);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal s_b$i($w);\n";
        
    }
    elsif($i > 3) {      
        print FH "  csl_port p_b$i(output,$val8);\n";
        print FH "  csl_port p_b_br$i(input,brt);\n";
        print FH "  csl_port p(input,$val4);\n";
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
        print FH "  csl_port p_c$i(input,$val5);\n";
        print FH "  csl_port pc(input,$val6);\n";
        print FH "  csl_port p_c_br$i(output,brt);\n";
        print FH "  csl_port p(input,$val7);\n";
        print FH "  csl_signal s_c$i($val2);\n";
        print FH "  csl_signal sc($val4);\n";
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
        print FH "  csl_port pc(input,$val8);\n";
        print FH "  csl_port p(input,$val4);\n";
        print FH "  csl_port p_c_br$i(input,brt);\n";
        print FH "  csl_signal s_c$i($val1);\n";
        print FH "  csl_signal sc($val3);\n";
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
        print FH "  csl_port p(input,$val3);\n";
        print FH "  csl_signal s_d_br$i($w);\n";
        print FH "  csl_signal s_d$i($w);\n";
    }
    elsif($i > 2 && $i <= 4) {      
        print FH "  csl_port p_d$i(output,$val1);\n";
        print FH "  csl_port p(output,$val3);\n";
        print FH "  csl_port pd(output,$w);\n";
        print FH "  csl_signal s_d$i($val9);\n";
    }
    elsif($i > 4) {      
       print FH "  csl_port p_d$i(input,$val1);\n";
       print FH "  csl_port p(input,$val3);\n";
       print FH "  csl_signal s($w);\n";
       print FH "  csl_signal s_d$i($val7);\n";
       print FH "  csl_signal s_d_br$i($val6);\n";
       print FH "  csl_signal sd($val5);\n";
    }
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    {a0.p_a$i,a0.pa}.connect(s_d$i);\n";
        print FH "    {a0.p,a0.p_a_br$i}.connect(p_d_br$i);\n";
        print FH "    {c0.p_c$i,c0.pc,c0.p}.connect(d.p[$l:$u]);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "    {a0.pa,a0.p_a$i,a0.p}.connect(s_d$i"."[$l:$u]);\n";
        print FH "    {p,p_d$i}.connect(b0.p_b".$i."[$l:$u]);\n";
        print FH "    {a0.s_a$i,a0.s_a_br$i}.connect(pd[$l:$u]);\n";
    }
    elsif($i > 4) {
        print FH "    {c0.p_c_br$i,c0.p}.connect(s);\n";
        print FH "    {s_d_br$i,s_d$i,sd}.connect(c0.pc[$l:$u]);\n";
    }
    
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    

    print FH "csl_unit e {\n";  
    print FH "  a a0;\n";
    print FH "  b b0;\n";
    print FH "  c c0;\n";
    if($i == 1 ) {
        print FH "  csl_port p_e$i(input,$val9);\n"; 
        print FH "  csl_port p_e_br$i(input,brt);\n";   
        print FH "  csl_port p(input,$val4);\n";
        print FH "  csl_signal s_e$i($val6);\n";
        print FH "  csl_signal se($val7);\n";
        print FH "  csl_signal s_e_br$i(br);\n";
        print FH "  csl_signal s($val5);\n";
    }
    elsif($i > 1 && $i <= 3) {      
        print FH "  csl_port p_e$i(output,$val9);\n";    
        print FH "  csl_port p(output,$val4);\n";
        print FH "  csl_port p_e_br$i(output,brt);\n";
        print FH "  csl_signal s_e$i($val8);\n";
        print FH "  csl_signal s_e_br$i($val1);\n";
    }
    elsif($i > 3) {      
        print FH "  csl_port p_e$i(input,$val1);\n";
        print FH "  csl_port p(input,$val8);\n";
        print FH "  csl_port pe(input,$val3);\n";
        print FH "  csl_signal se($w);\n";
    }
    print FH "  e() {\n";
    if($i == 1) {
        print FH "    {b0.p_b$i,b0.p}.connect(s_e_br$i);\n";
        print FH "    {b0.s_b$i,b0.sb,b0.s_b_br$i}.connect(p_e$i"."[$l:$u]);\n";
        print FH "    {s_e$i,se,s}.connect(b0.pb[$l:$u]);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "    {a0.s_a$i,a0.sa}.connect(p_e$i"."[$l:$u]);\n";
        print FH "    {b0.p_b$i,b0.p_b_br$i}.connect(s_e$i"."[$l:$u]);\n";
    }
    elsif($i > 3) {
        print FH "    {b0.p_b_br$i,b0.p}.connect(p[$l:$u]);\n";
        print FH "    {b0.p,b0.p_b_br$i}.connect(se);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    print FH "  d d0;\n";
    print FH "  e e0;\n"; 
    if($i <= 2) {
        print FH "  csl_port ptop(input,$w);\n";
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_top$i($w);\n";
        print FH "  csl_signal stop($w);\n";
    }
    elsif($i == 3) {
        print FH "  csl_port p_top$i(output,$val3);\n";      
        print FH "  csl_port p(output,$val9);\n";
        print FH "  csl_port ptop(output,$val1);\n"; 
        print FH "  csl_signal stop($w);\n";
        print FH "  csl_signal s_top$i($w);\n";
    }
    elsif($i > 3) {
        print FH "  csl_port p_top$i(input,$val5);\n";      
        print FH "  csl_port p(input,$val7);\n";
        print FH "  csl_port ptop(input,$val6);\n";
        print FH "  csl_signal s_top$i($w);\n";
        print FH "  csl_signal s_top_br$i(br);\n";
        print FH "  csl_signal stop($w);\n";
    }
    
    print FH "  top(){\n";
    if($i <= 2) {
        print FH "    {a0.p_a_br$i,a0.p}.connect(stop);\n";
        print FH "    {c0.p_c$i,c0.pc,c0.p}.connect(s_top$i);\n";
        print FH "    {a0.s_a$i,a0.sa}.connect(d0.p"."[$l:$u]);\n";
        print FH "    {d0.p_d$i,d0.p}.connect(ptop);\n";
    }
    elsif($i == 3) {
        print FH "    {a0.p_a$i,a0.pa,a0.p}.connect(s_top$i);\n";
        print FH "    {b0.p_b$i,b0.p_b_br$i}.connect(stop);\n";
        print FH "    {c0.s_c$i,c0.sc}.connect(p[$l:$u]);\n";
        print FH "    {p_top$i,ptop}.connect(s_e[$l:$u]);\n";
    }
    elsif($i > 3) {
        print FH "    {e0.p_e$i,pe}.connect(s_top_br$i);\n";
        print FH "    {d0.p_d$i,d0.p}.connect(s_top_br$i);\n";
        print FH "    {ptop,p_top$i,p}.connect(d0.b0.p_b$i"."[$l:$u]);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
