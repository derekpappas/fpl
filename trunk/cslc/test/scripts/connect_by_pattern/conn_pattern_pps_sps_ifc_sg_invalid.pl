#!/usr/bin/perl

#Author Petronela
use strict;
use Switch;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for generated tests is : $path"."conn_pattern_pps_sps_ifc_sg_invalid/ \n";

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

my @lower = (0,3,23);
my @upper = (32,51,64);

for (my $i = 1; $i <= 5; ++$i ) {
    foreach my $l(@lower) {
        foreach my $u(@upper) { 
            &main($i,$l,$u);
        }
    }
}


sub main {
    my ($i,$l, $u) = @_;
    my $test_name = "connect_pattern_pps_sps_ifc_sg$i"."_".$l."_".$u."_illegal.csl";
    &createCslFile($test_name,$i, $l, $u);
}

sub createCslFile {
    my($test_name, $i,$l, $u) = @_;    
    my $w = $u - $l + 1;
    my $val1 = $u + int(rand(100)) + 1;
    my $val2 = $val1 + int(rand(100)) + 1;
    my $val3 = $u + int(rand(60)) +1;
    &mkDir("$path/conn_pattern_pps_sps_ifc_sg_invalid");
    open(FH,">$path/conn_pattern_pps_sps_ifc_sg_invalid/$test_name");
    
    print FH "//Generated by Petronela\n";
    print FH "//testing the method connect_by_pattern for connections port[part select] to ifc, signal[part select] to ifc, ifc to port[part select] and ifc to signal[part select],\n";
    print FH "//port[part select] to signal_group, signal[part select] to signal_group, signal_group to port[part select] and signal_group to signal[part select]\n";
    print FH "//port[part select] to ifc.ifc, signal[part select] to ifc.ifc, ifc.ifc to port[part select] and ifc.ifc to signal[part select],\n";
    print FH "//port[part select] to sg.sg, signal[part select] to sg.sg, sg.sg to port[part select] and sg.sg to signal[part select]\n";
    print FH "csl_bitrange br($val1);\n";
    print FH "csl_bitrange brt($val2);\n";
    print FH "csl_interface ifca {\n";
    if($i <= 2 ) {
        print FH "  csl_port p_ifca$i(input,$w);\n";
        print FH "  csl_port p_ifa(input,br[$u:$l]);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "  csl_port p_ifca$i(output,$w);\n";
        print FH "  csl_port p_ifa(output,brt[$u:$l]);\n";
        print FH "  csl_port p_if(output,$w);\n";
    }
    elsif($i > 4 ) { 
        print FH "  csl_port p_ifca$i(input,$w);\n";
        print FH "  csl_port p_ifa(input,$w);\n";
        print FH "  csl_port p_if(input,$w);\n";
        print FH "  csl_port p_ifta$i(input,br[$u:$l]);\n";
    }
    print FH "  ifca() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

    print FH "csl_interface ifcb {\n";
    print FH "  ifca ifca0;\n";
    if($i == 1 ) {
        print FH "  csl_port p_ifcb$i(input,br[$u:$l]);\n";
        print FH "  csl_port p_ifb(input,$w);\n";
        print FH "  csl_port p_if(input,$w);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "  csl_port p_ifcb$i(output,$w);\n";
        print FH "  csl_port p_ifb(output,br[$u:$l]);\n";
        
    }
    elsif($i > 3) {  
        print FH "  csl_port p_ifcb$i(input,$w);\n";
        print FH "  csl_port p_ifb(input,brt[$u:$l]);\n";
        print FH "  csl_port p_if(input,$w);\n";
        print FH "  csl_port p_iftb$i(input,br[$u:$l]);\n";
        print FH "  csl_port p_b(input,$w);\n";
    }
    print FH "  ifcb() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_interface ifcd {\n";
    print FH "  ifcb ifcb4;\n";
    if($i == 1 ) {
        print FH "  csl_port p_ifcd$i(input,$w);\n";
        print FH "  csl_port p_ifd(input,$w);\n";
        print FH "  csl_port p_if(input,$w);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "  csl_port p_ifcd$i(output,$w);\n";
        print FH "  csl_port p_ifd(output,$w);\n";
        
    }
    elsif($i > 3) {  
        print FH "  csl_port p_ifcd$i(input,$w);\n";
        print FH "  csl_port p_ifd(input,$w);\n";
        print FH "  csl_port p_if(input,$w);\n";
        print FH "  csl_port p_iftd$i(input,$w);\n";
        print FH "  csl_port p_d(input,$w);\n";
    }
    print FH "  ifcd() {\n";
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
    print FH "csl_signal_group sga {\n";
    print FH "  csl_signal s_sga($val1);\n";
    print FH "  csl_signal s_sa($val2);\n";
    print FH "  csl_signal s_sgga($val3);\n";
    print FH "  csl_signal s_siga($val1);\n";
    print FH "  csl_signal s_sigga($val2);\n";
    print FH "  sga() {\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_signal_group sgb {\n";
    print FH "  sga sga0;\n";
    print FH "  csl_signal s_sga($val1);\n";
    print FH "  csl_signal s_sa($val2);\n";
    print FH "  csl_signal s_sgga($val3);\n";
    print FH "  csl_signal s_siga($val1);\n";
    print FH "  csl_signal s_sigga($val2);\n";
    print FH "  sgb() {\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_signal_group sgd {\n";
    print FH "  sgb sgb4;\n";
    print FH "  csl_signal s_sgd($val1);\n";
    print FH "  csl_signal s_sd($val2);\n";
    print FH "  csl_signal s_sggd($val3);\n";
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
    print FH "  sgd sgd0;\n";
    if($i <= 2) {
        print FH "  csl_port p_a$i(input,$val1);\n"; 
        print FH "  csl_port pa(input,$val2);\n";
        print FH "  csl_signal sa($val1);\n";
        print FH "  csl_signal s_a$i($val2);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "  csl_port p_a$i(output,$val2);\n"; 
        print FH "  csl_port pa(input,$val1);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_signal s_a$i($val2);\n";
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
    print FH "  ifcd ifcd0;\n";
    print FH "  sga sga1;\n";
    print FH "  sgb sgb0;\n";
    print FH "  sgd sgd0;\n";
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
    print FH "  ifcd ifcd0;\n";
    print FH "  sga sga1;\n";
    print FH "  sgb sgb0;\n";
    print FH "  sgd sgd0;\n";
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
    print FH "  ifcd ifcd1;\n";
    print FH "  sga sga2;\n";
    print FH "  sgb sgb1;\n";
    print FH "  sgd sgd1;\n";
    if($i <= 2) {
        print FH "  csl_port p_d$i(input,$val1);\n"; 
        print FH "  csl_port p_d_br$i(input,br);\n";
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_d_br$i($val1);\n";
        print FH "  csl_signal s_d$i($val2);\n";
        
    }
    elsif($i > 2 && $i <= 4) {      
        print FH "  csl_port p_d$i(input,$val1);\n";
        print FH "  csl_port p(output,$val2);\n";
        print FH "  csl_port pd(output,$val2);\n";
        print FH "  csl_signal s_d$i($val2);\n";
    }
    elsif($i > 4) {      
       print FH "  csl_port p_d$i(input,$val1);\n";
       print FH "  csl_port p(input,$val2);\n";
       print FH "  csl_signal s_d$i($val1);\n";
       print FH "  csl_signal s_d_br$i($val2);\n";
       print FH "  csl_signal sd($val1);\n";
    }
    print FH "  d() {\n";
    if($i <= 2) {
        print FH "    s_d$i"."[$u:$l].connect_by_pattern(a0.ifca1);\n";
        print FH "    c0.ifcb0.ifca0.connect_by_pattern(s_d_br$i"."[$u:$l]);\n";
        print FH "    p_d$i"."[$u-:$l].connect_by_pattern(b0.ifca1);\n";
        print FH "    s_d$i"."[$u:$l].connect_by_pattern(a0.sga1);\n";
        print FH "    c0.sgb0.sga0.connect_by_pattern(s_d_br$i"."[$u-:$l]);\n";
        print FH "    p_d$i"."[$u-:$l].connect_by_pattern(b0.sgd0.sgb4.sga0);\n";
    }
    elsif($i > 2 && $i <= 4) {
        print FH "    p_d$i"."[$u:$l].connect_by_pattern(b0.ifcb0.ifca0);\n";
        print FH "    b0.ifcb0.ifca0.connect_by_pattern(d.p[$u:$l]);\n";
        print FH "    c0.ifcd0.ifcb4.ifca0.connect_by_pattern(s_a$i"."[$u:$l]);\n";
        print FH "    p_d$i"."[$u:$l].connect_by_pattern(b0.sgb0.sga0);\n";
        print FH "    b0..sgd1.sgb0.sga0.connect_by_pattern(d.p[$u-:$l]);\n";
        print FH "    c0.sga1.connect_by_pattern(s_a$i"."[$u-:$l]);\n";
    }
    elsif($i > 4) {
        print FH "    s_d$i"."[$u:$l].connect_by_pattern(a0.ifcb0.ifca0);\n";
        print FH "    c0.ifca1.connect_by_pattern(p_d$i"."[$u-:$l]);\n";
        print FH "    s_d$i"."[$u-:$l].connect_by_pattern(a0.sga0);\n";
        print FH "    c0.sga1.connect_by_pattern(p_d$i"."[$u:$l]);\n";
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
    if($i == 1 ) {
        print FH "  csl_port p_e$i(input,$val1);\n"; 
        print FH "  csl_port p_e_br$i(input,br);\n";   
        print FH "  csl_port p(input,$val2);\n";
        print FH "  csl_signal s_e$i($w);\n";
        print FH "  csl_signal se(br[$u:$l]);\n";
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
        print FH "    s_e_br$i"."[$u:$l].connect_by_pattern(a0.ifca1);\n";
        print FH "    b0.ifcb0.ifca0.connect_by_pattern(s_e$i"."[$u:$l]);\n";
        print FH "    b0.pb[$u:$l].connect_by_pattren(ifca3);\n";
        print FH "    s_e_br$i"."[$u-:$l].connect_by_pattern(a0.sga1);\n";
        print FH "    b0.sgb0.connect_by_pattern(s_e$i"."[$u-:$l]);\n";
        print FH "    b0.pb[$u:$l].connect_by_pattern(sgd2.sgb4.sga0);\n";
    }
    elsif($i > 1 && $i <= 3) {
        print FH "    p_e$i"."[$u:$l].connect_by_pattern(c0.ifcb0);\n";
        print FH "    s_e_br$i"."[$u:$l].connect_by_pattern(b0.ifcb0);\n";
        print FH "    p_e$i"."[$u:$l].connect_by_pattern(c0.sgb0);\n";
        print FH "    s_e_br$i"."[$u-:$l].connect_by_pattern(b0.sgb0.sga0);\n";
    }
    elsif($i > 3) {
        print FH "    ifcb2.ifca0.connect_by_pattern(s_b_br$i"."[$u:$l]);\n";
        print FH "    p_e$i"."[$u:$l].connect_by_pattern(a0.ifca1);\n";
        print FH "    sgb2.connect_by_pattern(s_b_br$i"."[$u:$l]);\n";
        print FH "    p_e$i"."[$u-:$l].connect_by_pattern(a0.sga1);\n";
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
        print FH "  csl_signal stop(brt[$u:$l]);\n";
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
        print FH "    stop[$u:$l].connect_by_pattern(d0.a0.ifca1);\n";
        print FH "    s_top$i"."[$u:$l].connect_by_pattern(e0.c0.ifcb0.ifca0);\n";
        print FH "    d0.ifca2.connect_by_pattern(ptop[$u:$l]);\n";
        print FH "    stop[$u:$l].connect_by_pattern(d0.a0.sga1);\n";
        print FH "    s_top$i"."[$u:$l].connect_by_pattern(e0.c0.sgb0);\n";
        print FH "    d0.sgd1.sgb4.connect_by_pattern(ptop[$u-:$l]);\n";
    }
    elsif($i == 3) {
        print FH "    e0.a0.ifcb0.ifca0.connect_by_pattern(s_top$i"."[$u:$l]);\n";
        print FH "    stop[$u:$l].connect_by_pattern(d0.b0.ifca1);\n";
        print FH "    ifca4.connect_by_pattern(e0.b0.s_b$i"."[$u:$l]);\n";
        print FH "    e0.a0.sgb0.connect_by_pattern(s_top$i"."[$u:$l]);\n";
        print FH "    stop[$u-:$l].connect_by_pattern(d0.b0.sga1);\n";
        print FH "    sga4.connect_by_pattern(e0.b0.s_b$i"."[$u:$l]);\n";
    }
    elsif($i > 3) {
        print FH "    p_top_br$i"."[$u:$l].connect_by_pattern(e0.ifcb2);\n";
        print FH "    p_top_br$i"."[$u:$l].connect_by_pattern(e0.ifca3);\n";
        print FH "    d0.a0.ifcb0.connect_by_pattern(stop[$u:$l]);\n";
        print FH "    p_top_br$i"."[$u:$l].connect_by_pattern(e0.sgb2);\n";
        print FH "    p_top_br$i"."[$u-:$l].connect_by_pattern(e0.sga3);\n";
        print FH "    d0.a0.sgb0.sga0.connect_by_pattern(stop[$u:$l]);\n";
    }
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
