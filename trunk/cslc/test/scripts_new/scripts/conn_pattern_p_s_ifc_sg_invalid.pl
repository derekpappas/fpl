#!/usr/bin/perl

#Author Petronela
use strict;
use Switch;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for generated tests is : $path"."conn_pattern_p_s_ifc_sg_invalid/ \n";

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

foreach(my $i = 1; $i <= 30; $i++) {
    my @map1  = ("p_a$i","pa","p");
    my @map11 = ("p_ifca$i","p_ifa");
    my @map12 = ("p_ifcb$i","p_ifb","p_if");
    my @map2  = ("p","p_b$i");
    my @map21 = ("p_ifca$i","p_ifa","p_if");
    my @map22 = ("p_ifcb$i","p_ifb");
    my @map3  = ("pc","p","p_c_br$i");
    my @map31 = ("p_ifca$i","p_ifa","p_if","p_ifta$i");
    my @map32 = ("p_ifcb$i","p_ifb","p_if","p_iftb$i","p_b");
    my @map4  = ("p_d$i","p"); 
    my @map5  = ("p_e$i","p","pe");
    my @map6  = ("p_top$i","p_top_br$i","p");
    if($i <= 5 ) {  
        foreach my $it1 (@map1) {
            if($i <= 2 ) {
                foreach my $it2 (@map11) {
                    &main($i,$it1,$it2);
                }
            }   
            else {
                foreach my $it3(@map12) { 
                    &main($i,$it1,$it3);
                }
            }
        }
    }
    elsif($i > 5 && $i <= 10) {
        foreach my $it1 (@map2) {
            if($i > 5 && $i <= 7) {
                foreach my $it2(@map21) {
                    &main($i,$it1,$it2);
                }
            }
            else {
                foreach my $it3(@map22) {
                    &main($i,$it1,$it3);
                }
            }
        }       
    }
    elsif($i > 10 && $i <= 15) {
        foreach my $it1 (@map3) {
            if($i > 10 && $i <= 12) {
                foreach my $it2(@map31) {
                    &main($i,$it1,$it2);
                }
            }
            else {
                foreach my $it3(@map32) {
                    &main($i,$it1,$it3);
                }
            }
        }       
    }
    elsif($i > 15 && $i <= 20) {
        foreach my $it1 (@map4) {
            if($i > 15 && $i <= 17) {
                foreach my $it2(@map31) {
                    &main($i,$it1,$it2);
                }
            }
            else {
                foreach my $it3(@map32) {
                    &main($i,$it1,$it3);
                }
            }
        }       
    }
    elsif($i > 20 && $i <= 25) {
        foreach my $it1 (@map5) {
            if($i > 20 && $i <= 22) {
                foreach my $it2(@map11) {
                    &main($i,$it1,$it2);
                }
            }
            else {
                foreach my $it3(@map12) {
                    &main($i,$it1,$it3);
                }
            }
        }       
    }
    elsif($i > 25 && $i <= 30) {
        foreach my $it1 (@map6) {
            if($i > 25 && $i <= 27) {
                foreach my $it2(@map31) {
                    &main($i,$it1,$it2);
                }
            }
            else {
                foreach my $it3(@map32) {
                    &main($i,$it1,$it3);
                }
            }
        }       
    }
}

sub main {
    my ($i,$it1,$it2) = @_;
    my $test_name = "connect_pattern_p_s_ifc_sg".$i."_".$it1."_".$it2."_illegal.csl";
    &createCslFile($test_name, $i,$it1,$it2);
}
sub createCslFile {
    my($test_name, $i,$it1,$it2) = @_;
    my $val1 = int(rand(100)) + 1;
    my $val2 = int(rand(100)) + 1;
   
    &mkDir("$path/conn_pattern_p_s_ifc_sg_invalid");
    open(FH,">$path/conn_pattern_p_s_ifc_sg_invalid/$test_name");
    
    print FH "//Generated by Petronela\n";
    print FH "//testing the method connect_by_pattern for conections port to ifc, signal to ifc, ifc to port ,ifc to signal, port to signal_group, signal to sg, sg to port \n";
    print FH "//sg to signal ,port to ifc.[+]ifc,signal to ifc.[+]ifc,port to sg.[+]sg,signal to sg.[+]sg\n\n";
    print FH "csl_bitrange br($val1);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_interface ifca {\n";
    if($i <= 5 || ($i > 20 && $i <= 25) ) {
        print FH "  csl_port p_ifca$i(input,$val1);\n";
        print FH "  csl_port p_ifa(input,$val1);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "  csl_port p_ifca$i(output,$val2);\n";
        print FH "  csl_port p_ifa(output,$val2);\n";
        print FH "  csl_port p_if(output,$val2);\n";
    }
    elsif($i > 10 ) { 
        print FH "  csl_port p_ifca$i(input,$val1);\n";
        print FH "  csl_port p_ifa(input,$val1);\n";
        print FH "  csl_port p_if(input,$val1);\n";
        print FH "  csl_port p_ifta$i(input,$val1);\n";
    }
    print FH "  ifca() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_interface ifcb {\n";
    print FH "  ifca ifca0;\n";
    if($i <= 5 || ($i > 20 && $i <= 25)) {
        print FH "  csl_port p_ifcb$i(input,$val1);\n";
        print FH "  csl_port p_ifb(input,$val1);\n";
        print FH "  csl_port p_if(input,$val1);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "  csl_port p_ifcb$i(output,$val2);\n";
        print FH "  csl_port p_ifb(output,$val2);\n";
        
    }
    elsif($i > 10) {  
        print FH "  csl_port p_ifcb$i(input,$val1);\n";
        print FH "  csl_port p_ifb(input,$val1);\n";
        print FH "  csl_port p_if(input,$val1);\n";
        print FH "  csl_port p_iftb$i(input,$val1);\n";
        print FH "  csl_port p_b(input,$val1);\n";
    }
    print FH "  ifcb() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_interface ifcd {\n";
    print FH "  ifcb ifcb4;\n";
    if($i <= 5 || ($i > 20 && $i <= 25) ) {
        print FH "  csl_port p_ifcd$i(input,$val1);\n";
        print FH "  csl_port p_ifd(input,$val1);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "  csl_port p_ifcd$i(output,$val2);\n";
        print FH "  csl_port p_ifd(output,$val2);\n";
        print FH "  csl_port p_if(output,$val2);\n";
    }
    elsif($i > 10 ) { 
        print FH "  csl_port p_ifcd$i(input,$val1);\n";
        print FH "  csl_port p_ifd(input,$val1);\n";
        print FH "  csl_port p_if(input,$val1);\n";
        print FH "  csl_port p_iftd$i(input,$val1);\n";
    }
    print FH "  ifcd() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_signal_group sga {\n";
    print FH "  csl_signal s_sga($val1);\n";
    print FH "  csl_signal s_sa($val2);\n";
    print FH "  csl_signal s_sgga($val1);\n";
    print FH "  csl_signal s_siga($val1);\n";
    print FH "  csl_signal s_sigga($val2);\n";
    print FH "  sga() {\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_signal_group sgb {\n";
    print FH "  sga sga0;\n";
    print FH "  csl_signal s_sga($val1);\n";
    print FH "  csl_signal s_sa($val2);\n";
    print FH "  csl_signal s_sgga($val1);\n";
    print FH "  csl_signal s_siga($val1);\n";
    print FH "  csl_signal s_sigga($val2);\n";
    print FH "  sgb() {\n";
    print FH "  }\n";
    print FH "};\n\n";

    print FH "csl_signal_group sgd {\n";
    print FH "  sgb sgb4;\n";
    print FH "  csl_signal s_sgd($val1);\n";
    print FH "  csl_signal s_sd($val2);\n";
    print FH "  csl_signal s_sggd($val1);\n";
    print FH "  csl_signal s_sigd($val1);\n";
    print FH "  csl_signal s_siggd($val2);\n";
    print FH "  sgd() {\n";
    print FH "  }\n";
    print FH "};\n\n";
    
    print FH "csl_unit a {\n";
    print FH "  ifca ifca1;\n";
    print FH "  ifcb ifcb0;\n";
    print FH "  ifcd ifcd0;\n";
    print FH "  sga sga1;\n";
    print FH "  sgb sgb0;\n";
    if($i <= 5  || ($i > 25 && $i <= 30)) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
        print FH "  csl_port pa(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_a$i($val1);\n";
        print FH "  csl_signal sa($val1);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "  csl_port p_a$i(output,$val2);\n"; 
        print FH "  csl_port pa(output,$val2);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal s_a$i($val2);\n";
        print FH "  csl_signal sa($val2);\n";
    }
    elsif($i > 10 && $i <= 25) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
        print FH "  csl_port p_a_br$i(input,br);\n";
        print FH "  csl_port pa(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_a$i($val1);\n";
    }
    print FH "  a() {\n";
    if($i <= 2) {
        print FH "    $it1.connect_by_pattern(ifca1);\n";
        print FH "    s_a$i.connect_by_pattern(ifca1);\n";
        print FH "    ifcb0.connect_by_pattern(sa);\n";
    }
    elsif($i > 2 && $i <= 5) {
        print FH "    $it1.connect_by_pattern(ifcb0);\n";
        print FH "    s_a$i.connect_by_pattern(ifca1);\n";
        print FH "    ifca1.connect_by_pattern(sa);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "    ifca1.connect_by_pattern(pa);\n";
        print FH "    ifcb0.connect_by_pattern(p);\n";
        print FH "    s_a$i.connect_by_pattern(ifca1);\n";
        print FH "    sga1.connect_by_pattern(pa);\n";
        print FH "    sgb0.connect_by_pattern(p);\n";
        print FH "    s_a$i.connect_by_pattern(sga1);\n";
    }
    elsif($i > 10 && $i <= 15) {
        print FH "    ifca1.connect_by_pattern(p_a_br$i);\n";
        print FH "    ifca1.connect_by_pattern(p_a$i);\n";
        print FH "    ifcd0.ifcb4.connect_by_pattern (pa);\n";
        print FH "    s_a$i.connect_by_pattern(ifcb0);\n";
        print FH "    sga1.connect_by_pattern(p_a_br$i);\n";
        print FH "    sga1.connect_by_pattern(p_a$i);\n";
        print FH "    sgb0.connect_by_pattern(pa);\n";
        print FH "    s_a$i.connect_by_pattern(sgb0);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    print FH "csl_unit b {\n";  
    print FH "  ifca ifca1;\n";
    print FH "  ifcb ifcb0;\n";
    print FH "  ifcd ifcd0;\n";
    print FH "  sga sga1;\n";
    print FH "  sgb sgb0;\n";
    print FH "  sgd sgd0;\n";
    if($i <= 5) {
        print FH "  csl_port p_b$i(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_b$i($val1);\n";
        print FH "  csl_signal sb($val1);\n";
    }
    elsif(($i > 5 && $i <= 10) || ($i > 20 && $i <= 25) ) {      
        print FH "  csl_port p_b$i(output,$val2);\n";
        print FH "  csl_port pb(output,$val2);\n";
        print FH "  csl_port p_b_br$i(output,brt);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal s_b_br$i(brt);\n";
        print FH "  csl_signal s_b$i($val2);\n";
    }
    elsif($i > 10) {      
        print FH "  csl_port p_b$i(input,$val1);\n";
        print FH "  csl_port p_b_br$i(input,br);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal sb($val1);\n";
        print FH "  csl_signal s_b_br$i(br);\n";
    }
    print FH "  b() {\n";
    if($i <= 5){
        print FH "    ifcb0.connect_by_pattern(p);\n";
        print FH "    ifcb0.ifca0.connect_by_pattern(p);\n";
        print FH "    s_b$i.connect_by_pattern(ifca1);\n";
        print FH "    sgb0.sga0.connect_by_pattern(p);\n";
        print FH "    sga1.connect_by_pattern(p);\n";
        print FH "    s_b$i.connect_by_pattern(sga1);\n";
    }
    elsif($i > 5 && $i <= 7) {
        print FH "    $it1.connect_by_pattern(ifca1);\n";
        print FH "    s_b_br$i.connect_by_pattern(ifcb0.ifca0);\n";
        print FH "    ifcb0.connect_by_pattern(s_b$i);\n";
    }
    elsif($i > 7 && $i <=10) {
        print FH "    $it1.connect_by_pattern(ifcb0);\n";
        print FH "    s_b$i.connect_by_pattern(ifca1);\n";
        print FH "    ifca1.connect_by_pattern(s_b_br$i);\n";
    }
    elsif($i > 10 && $i <= 15) {
        print FH "    ifcd0.ifcb4.ifca0.connect_by_pattern(p_b$i);\n";
        print FH "    sb.connect_by_pattern(ifcb0);\n";
        print FH "    ifca1.connect_by_pattern(s_b_br$i);\n";
        print FH "    sga1.connect_by_pattern(p_b$i);\n";
        print FH "    sb.connect_by_pattern(sgb0);\n";
        print FH "    sgd0.sgb4.connect_by_pattern(s_b_br$i);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit c {\n";  
    print FH "  ifca ifca1;\n";
    print FH "  ifcb ifcb0;\n";
    print FH "  ifcd ifcd0;\n"; 
    print FH "  sga sga1;\n";
    print FH "  sgb sgb0;\n";
    print FH "  sgd sgd0;\n";
    if($i <= 5 || $i > 20 && $i <= 25 ) {
        print FH "  csl_port p_c$i(input,$val1);\n";
        print FH "  csl_port pc(input,$val1);\n";
        print FH "  csl_port p_c_br$i(input,br);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal sc($val1);\n";
    }
    elsif($i > 5 && $i <= 10) {      
        print FH "  csl_port p_c$i(output,$val2);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal sc($val2);\n";
        print FH "  csl_signal s_c$i($val2);\n";
        print FH "  csl_signal s_c_br$i(brt);\n";
    }
    elsif($i > 10 && $i <= 20) {      
        print FH "  csl_port pc(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_port p_c_br$i(input,br);\n";
        print FH "  csl_signal s_c$i($val1);\n";
        print FH "  csl_signal s($val1);\n";
        print FH "  csl_signal sc($val1);\n";
    }
    print FH "  c() {\n";
    if($i <= 5){
        print FH "    ifca1.connect_by_pattern(pc);\n";
        print FH "    sc.connect_by_pattern(ifcb0.ifca0);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "    ifcb0.ifca0.connect_by_pattern(p_c$i);\n";
        print FH "    ifca1.connect_by_pattern(p);\n";
        print FH "    s_c_br$i.connect_by_pattern(ifca1);\n";
        print FH "    sgb0.sga0.connect_by_pattern(p_c$i);\n";
        print FH "    sgd0.sgb4.connect_by_pattern(p);\n";
        print FH "    s_c_br$i.connect_by_pattern(sga1);\n";
    }
    elsif($i > 10 && $i <= 12) {
        print FH "    $it1.connect_by_pattern(ifca1);\n";
        print FH "    s_c$i.connect_by_pattern(ifcb0.ifca0);\n";
    }
    elsif($i > 12 && $i <= 15) {
        print FH "    $it1.connect_by_pattern(ifcb0);\n";
        print FH "    s.connect_by_pattern(ifca1);\n";
        print FH "    ifcd0.ifcb4.connect_by_pattern(sc);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit d {\n";  
    print FH "  a a0;\n";
    print FH "  b b0;\n";
    print FH "  c c0;\n"; 
    print FH "  ifca ifca2;\n";
    print FH "  ifcb ifcb1;\n";
    print FH "  ifcd ifcd1;\n";
    print FH "  sga sga2;\n";
    print FH "  sgb sgb1;\n";
    print FH "  sgd sgd1;\n";
    if($i <= 5 || ($i > 25 && $i <= 30)) {
        print FH "  csl_port p_d$i(input,$val1);\n"; 
        print FH "  csl_port p_d_br$i(input,br);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_d$i($val1);\n";
        print FH "  csl_signal sd($val1);\n";
    }
    elsif($i > 5 && $i <= 10  ) {      
        print FH "  csl_port p_d$i(output,$val2);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_port pd(output,$val2);\n";
        print FH "  csl_signal s_d$i($val2);\n";
        print FH "  csl_signal s_d_br$i($val2);\n";
    }
    elsif($i > 10 && $i <= 25) {      
       print FH "  csl_port p_d$i(input,$val1);\n";
       print FH "  csl_port p(input,$val1);\n";
       print FH "  csl_signal sd($val1);\n";
       print FH "  csl_signal s_d$i($val1);\n";
       print FH "  csl_signal s_d_br$i($val1);\n";
    }
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    a0.p_a$i.connect_by_pattern(ifcd1);\n";
        print FH "    c0.pc.connect_by_pattern(ifcb1.ifca0);\n";
        print FH "    b0.sb.connect_by_pattern(ifca2);\n";
        print FH "    sd.connect_by_pattern(a0.ifcb0);\n";
    }
    elsif($i >2 && $i <= 5) {
        print FH "    p_d$i.connect_by_pattern(ifcb1);\n";
        print FH "    s_d$i.connect_by_pattern(b0.ifca1);\n";
        print FH "    c0.ifcb0.ifca0.connect_by_pattern(sd);\n";
        print FH "    a0.ifca1.connect_by_pattern(sd);\n";
    }
    elsif($i > 5 && $i <= 7) {
        print FH "    s_d$i.connect_by_pattern(c0.ifca1);\n";
        print FH "    c0.ifcb0.connect_by_pattern(s_d_br$i);\n";
    }
    elsif($i > 7 && $i <= 10) {
        print FH "    p_d$i.connect_by_pattern(ifcb1);\n";
        print FH "    ifcd1.ifcb4.ifca0.connect_by_pattern(p_d$i);\n";
        print FH "    s_d_br$i.connect_by_pattern(a0.ifca1);\n";
    }
    elsif($i > 10 && $i <= 15) {
        print FH "    p_d$i.connect_by_pattern(ifcb1);\n";
        print FH "    sd.connect_by_pattern(b0.ifcb0);\n";
        print FH "    p_d$i.connect_by_pattern(sgd1.sgb4.sga0);\n";
        print FH "    sd.connect_by_pattern(b0.sgb0.sga0);\n";
    }
    elsif($i > 15 && $i <= 17){
        print FH "    $it1.connect_by_pattern(ifca2.$it2);\n";
        print FH "    p_d$i.connect_by_pattern(ifcb1.p_ifb);\n";
        print FH "    c0.ifcb0.p_ifb.connect_by_pattern(s_b_br$i);\n";
    }
     elsif($i > 17 && $i <= 20){
        print FH "    $it1.connect_by_pattern(ifcd1);\n";
        print FH "    b0.p_b$i.connect_by_pattern(ifca2);\n";
        print FH "    s_d$i.connect_by_pattern(a0.ifcb0);\n";
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
    print FH "  ifcd ifcd2;\n";
    print FH "  sga sga3;\n";
    print FH "  sgb sgb2;\n";
    print FH "  sgd sgd2;\n";
    if($i <= 5) {
        print FH "  csl_port p_e$i(input,$val1);\n"; 
        print FH "  csl_port p_e_br$i(input,br);\n";   
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_e$i($val1);\n";
        print FH "  csl_signal s_e_br(br);\n";
    }
    elsif($i > 5 && $i <= 10) {      
        print FH "  csl_port p_e$i(output,$val2);\n";    
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_port p_e_br$i(output,brt);\n";
        print FH "  csl_signal se($val2);\n";
    }
    elsif($i > 10 && $i <= 30) {      
        print FH "  csl_port p_e$i(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_port pe(input,$val1);\n";
        print FH "  csl_signal s_e_br$i(br);\n";
        print FH "  csl_signal se($val1);\n";
    }
    print FH "  e() {\n";
    if($i <= 5) {
        print FH "    p_e_br$i.connect_by_pattern(ifcd2.ifcb4.ifca0);\n";
        print FH "    a0.sa.connect_by_pattern(ifca3);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "    p_e$i.connect_by_pattern(ifcd2);\n";
        print FH "    se.connect_by_pattern(c0.ifcb0.ifca0);\n";
        print FH "    b0.s_b_br$i.connect_by_pattern(ifcb2);\n";
    }
    elsif($i > 10 && $i <= 20) {
        print FH "    ifca3.connect_by_pattern(a0.p_a_br$i);\n";
        print FH "    s_e_br$i.connect_by_pattern(b0.ifca1);\n";
        print FH "    sgd2.sgb4.connect_by_pattern(a0.p_a_br$i);\n";
        print FH "    s_e_br$i.connect_by_pattern(b0.sga1);\n";
    }
    elsif($i > 20 && $i <= 22) {
        print FH "    $it1.connect_by_pattern(ifca3);\n";
        print FH "    c0.ifcb0.ifca0.connect_by_pattern(se);\n";
    }
    elsif($i > 22 && $i <= 25) {
        print FH "    $it1.connect_by_pattern(ifcb2.ifca0);\n";
        print FH "    se.connect_by_pattern(a0.ifca1);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_unit top {\n";
    print FH "  d d0;\n";
    print FH "  e e0;\n"; 
    print FH "  ifca ifca4;\n";
    print FH "  ifcb ifcb3;\n";
    print FH "  ifcd ifcd3;\n";
    print FH "  sga sga4;\n";
    print FH "  sgb sgb3;\n";
    print FH "  sgd sgd3;\n";
    if($i <= 5) {
        print FH "  csl_port ptop(input,$val1);\n";
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_signal s_top$i($val1);\n";
        print FH "  csl_signal stop($val1);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "  csl_port p_top$i(output,$val2);\n";      
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_port ptop(output,$val2);\n";        
        print FH "  csl_signal st($val2);\n";
        print FH "  csl_signal s_top_br$i(brt);\n";
    }
    elsif($i > 10 && $i <= 30) {
        print FH "  csl_port p_top$i(input,$val1);\n";      
        print FH "  csl_port p(input,$val1);\n";
        print FH "  csl_port p_top_br$i(input,br);\n";
        print FH "  csl_signal s_top$i($val1);\n";
        print FH "  csl_signal stop($val1);\n";
    }
    print FH "  top(){\n";
    if($i <= 5) {
        print FH "    ifca4.connect_by_pattern(d0.a0.p_a$i);\n";
        print FH "    p.connect_by_pattern(ifca4);\n";
        print FH "    s_top$i.connect_by_pattern(d0.ifcd1);\n";
    }
    elsif($i > 5 && $i <= 10) {
        print FH "    ifcb3.connect_by_pattern(e0.a0.p_a$i);\n";
        print FH "    ptop.connect_by_pattern(ifcd3);\n";
        print FH "    e0.ifcb2.ifca0.connect_by_pattern(st);\n";
        print FH "    s_top_br$i.connect_by_pattern(d0.b0.ifcb0);\n";
    }
    elsif($i > 10 && $i <= 15) {
        print FH "    p_top_br$i.connect_by_pattern(ifca4);\n";
        print FH "    ifcb3.ifca0.connect_by_pattern(p);\n";
        print FH "    s_top$i.connect_by_pattern(e0.c0.ifca1);\n";
        print FH "    p_top_br$i.connect_by_pattern(sga4);\n";
        print FH "    sgb3.sga0.connect_by_pattern(p);\n";
        print FH "    s_top$i.connect_by_pattern(e0.c0.sga1);\n";
    }
    elsif($i > 25 && $i <= 27) {
        print FH "    $it1.connect_by_pattern(ifca4);\n";
        print FH "    d0.a0.p_a$i.connect_by_pattern(ifca4);\n";
        print FH "    stop.connect_by_pattern(e0.b0.ifcb0.ifca0);\n";
        print FH "    s_top$i.connect_by_pattern(e0.c0.ifca1);\n";
        print FH "    $it1.connect_by_pattern(sgd3);\n";
        print FH "    d0.a0.p_a$i.connect_by_pattern(sga4);\n";
        print FH "    stop.connect_by_pattern(e0.b0.ifcb0);\n";
        print FH "    s_top$i.connect_by_pattern(e0.c0.sga1);\n";
    }
    elsif($i > 27) {
        print FH "    $it1.connect_by_pattern(ifcb3.ifca0);\n";
        print FH "    e0.b0.p.connect_by_pattern(ifca4);\n";
        print FH "    ifca4.connect_by_pattern(s_top$i);\n";
        print FH "    $it1.connect_by_pattern(sgb3.sga0);\n";
        print FH "    e0.b0.p.connect_by_pattern(sgd3);\n";
        print FH "    sga4.connect_by_pattern(s_top$i);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);
}
